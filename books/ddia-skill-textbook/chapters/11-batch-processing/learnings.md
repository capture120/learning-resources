# Chapter 11: Batch Processing — Core Learnings

**Central thesis:** A batch job reads immutable, bounded input and regenerates its output from scratch on every run, with no side effects. This makes batch jobs cheap to retry, easy to debug, and tolerant of human error: if the output is wrong, fix the code and rerun, or switch back to a kept previous output. Distributed batch frameworks are best understood as distributed operating systems — they have a filesystem (DFS/object store), a scheduler (job orchestrator), and processes (tasks) that exchange data through files or network channels.

## Batch vs. online systems

- **Online systems** (web servers, APIs, databases, caches): request/response; primary metric is response time; need high availability.
- **Batch (offline) systems**: process a large bounded input; primary metric is **throughput** (data processed per unit time); may run minutes to days, often on a periodic schedule.
- Batch output is **derived data**: deterministic function of read-only input. Properties that follow:
  - **Human fault tolerance**: buggy code → delete output, roll back code, rerun. Read/write transactional databases lack this; rolling back code does not fix bad data already written. Object stores and open table formats support keeping old outputs ("time travel").
  - **Minimized irreversibility** speeds up feature development (Agile principle).
  - Same input files feed many jobs, including monitoring jobs that compare a run's output to the previous run.
  - Far cheaper than batch-processing through OLTP databases or app servers.
- Limits: output usually usable only after the whole job finishes; any input change — even one byte — forces reprocessing the entire input; not for low-latency needs.
- The online/batch boundary is blurry — a long-running database query looks a lot like a batch process. Batch's distinctive role includes **data integration**: composing multiple data systems (e.g. ETL) to achieve what no single system can.
- Stream processing (Ch 12) is the alternative: same idea but the input is unbounded and the job never finishes.
- MapReduce (Google, 2004) shaped the field — open-source implementations appeared not just in Hadoop but also in CouchDB and MongoDB — but is now largely obsolete (no longer used at Google). It was always a fairly low-level model — less sophisticated than the parallel query execution engines in data warehouses — but a step forward in scale on commodity hardware. Modern work runs on Spark, Flink, or cloud data warehouse engines, orchestrated by Airflow/Dagster/Prefect, stored on object stores (S3) more than HDFS-style distributed filesystems.

## Unix tools as the mental model

- A pipeline like `awk | sort | uniq -c | sort -rn | head` is a batch job: each program is a stage, pipes are the data channels.
- **Sorting vs. in-memory aggregation — the key trade-off:**
  - **Hash table in memory**: works when the *working set* (number of distinct keys, not number of records) fits in RAM — ~1 GB covers all distinct URLs of most small/mid websites. A million records for one key still costs one hash entry.
  - **Sort-based**: when the working set exceeds memory. Sorting spills to disk gracefully: sort chunks in memory, write sorted segment files, merge (mergesort's sequential access pattern is disk-friendly — same principle as log-structured storage/SSTables).
  - GNU `sort` automatically spills to disk and parallelizes across cores, so the Unix pipeline scales to datasets far larger than RAM; the bottleneck becomes input read rate from disk.
- Unix tools' hard limit: one machine. Distributed frameworks exist for data that exceeds one machine's memory and disk.

## Distributed filesystems (DFS)

- Same layering as a local filesystem: block layer → page cache → filesystem metadata → common API (VFS analogue = the DFS protocol, e.g. the S3 API, which MinIO/R2/Tigris/B2 also implement — pluggable storage).
- **Block sizes**: HDFS defaults to 128 MB; JuiceFS and many object stores use 4 MB; ext4 uses 4,096 bytes. Larger blocks → less metadata (matters at petabyte scale) and lower seek-to-read overhead. Unlike physical devices, DFS blocks need not be fully used (a 900 MB file with 128 MB blocks = 7 full blocks + one 4 MB block).
- **Data nodes**: every machine runs a daemon (HDFS DataNode, glusterfsd) exposing read/write of blocks stored as local files. Reads benefit from each node's OS page cache; some DFSs add client-side/local-disk cache tiers (JuiceFS).
- **Metadata service** tracks file→block→machine mapping, permissions (HDFS NameNode; DeepSeek 3FS persists metadata to a key-value store like FoundationDB).
- **Shared-nothing**, commodity hardware + ordinary datacenter network — contrast with shared-disk NAS/SAN (custom appliances, Fibre Channel).
- **Fault tolerance for storage**: replicate blocks across machines, or use **erasure coding (Reed–Solomon)** for lower storage overhead than full replication. Like RAID, but over the network. Replication also gives schedulers placement choices (run a task on a node holding its input).
- Some DFSs are POSIX-compliant via FUSE or NFS. NFS is perhaps the best-known DFS protocol, originally designed for many clients reading/writing a *single* server; EFS and Archil scale NFS by hiding distributed metadata/data services behind one NFS endpoint.

## Object stores vs. DFS — gotchas

- Major services: Amazon S3, Google Cloud Storage, Azure Blob Storage, OpenStack Swift. Objects are addressed by bucket + key, read with `get`, written with `put`. **Objects are immutable**: updating means rewriting the whole object. No fopen/fseek file handles. Appends supported only by a few (Azure Blob, S3 Express One Zone).
- **There are no directories.** Slashes are key convention. Prefix listing ≈ recursive `ls -R`. Empty directories cannot exist (workaround: zero-byte marker object).
- **Missing filesystem features**: no hard/symbolic links, no file locking, and **renames are nonatomic** (copy + delete; renaming a "directory" means renaming every object individually).
- FUSE drivers can mount object stores as filesystems, and some systems (JuiceFS, Ceph) offer both APIs — but performance and consistency guarantees differ; verify behavior, don't trust the API shape.
- Optimization target: large objects (MB–GB), infrequent large reads — vs. key-value stores' small values and low-latency access. The gap is closing (S3 Express One Zone: single-millisecond latency, KV-like pricing).
- **Data locality**: HDFS-style DFSs can schedule compute on the node holding the data (saves bandwidth when code is smaller than data). Object stores separate storage and compute — more network traffic, but modern networks are fast, and CPU/memory scale independently of storage. Separation usually wins today.

## Job orchestration

Components present in nearly every orchestrator (Kubernetes, YARN):
- **Task executors** (kubelet, NodeManager): per-node daemons that fetch executable code, start tasks, heartbeat, report status; enforce isolation via cgroups (security + performance isolation between tasks).
- **Resource manager**: global cluster state — hardware per node, task statuses, network locations. Centralized, so it is a scalability/availability bottleneck (YARN uses ZooKeeper; Kubernetes uses etcd).
- **Scheduler**: matches job requests (task count, CPU/memory/disk/GPU needs, image, credentials, parameters) to nodes. Application-specific sub-schedulers (YARN ApplicationMasters, Kubernetes operators) handle domain logic like autoscaling.

### Resource allocation trade-offs
- Optimal scheduling is **NP-hard**; real schedulers use heuristics: FIFO, dominant resource fairness (DRF), priority queues, capacity/quota scheduling, bin-packing.
- **Gang scheduling** (hold resources until a job can start all tasks at once): risks idle nodes, lower utilization, even deadlock if multiple jobs reserve concurrently. Waiting passively instead risks **starvation** (other jobs keep grabbing cores). **Preemption** (kill running tasks to make room) restores fairness but wastes the killed tasks' work.
- **Spot/preemptible instances**: batch work is usually not time-sensitive, so it can run on cheap low-priority capacity that may be killed at any moment. Note: preemptions are *more frequent than hardware faults* — design for task-level retry.

### Workflows (DAGs of jobs)
- A workflow chains jobs: one job's output is another's input. Reasons: outputs shared across teams; moving data between tools (e.g. Spark → HDFS → Trino → S3); multi-stage pipelines that re-shard by different keys.
- Not the same as **durable-execution workflow engines** (Ch 5): those run sequences of steps that typically make RPCs to external services and handle less data per request. A batch workflow's jobs take input data and produce output data without external RPCs (though the line is fuzzy).
- Two coupling styles:
  - **Pipe-like / direct task-to-task transfer** (Unix pipes; Spark/Flink between tasks): small buffers, backpressure, low latency between stages.
  - **Materialize to DFS/object store between jobs**: decouples jobs in time, lets different teams/tools consume, enables retry from the boundary. This is the typical pattern.
- Per-job schedulers (YARN ResourceManager, Spark's scheduler) don't manage cross-job dependencies; **workflow schedulers** (Airflow, Dagster, Prefect — replacing Oozie/Azkaban) do. They wait until all upstream jobs succeed before starting a consumer. Workflows of **50–100 jobs are common**; in large orgs many teams consume one another's outputs, so tooling matters.

### Fault handling — framework comparison
- Long jobs with many parallel tasks will see failures (hardware faults, network, and especially preemption). Because output is regenerated from scratch, recovery = delete partial output, rerun the task elsewhere. Some simple batch systems just abort and restart the whole job on a fault; MapReduce and its successors keep parallel tasks independent so they can retry at **task granularity**, avoiding wasted whole-job reruns.
- **MapReduce**: writes all intermediate data to the DFS and waits for the write to complete before consumers read. Robust even under heavy preemption, but lots of DFS writes (replicated, on-disk) — slow.
- **Spark**: keeps intermediate data in memory, spills to local disk; writes only final results to DFS. Tracks **lineage** (how each intermediate dataset was computed) and recomputes lost partitions.
- **Flink**: periodically checkpoints task snapshots.

## Processing models

### MapReduce
Four steps per job: (1) split input files into records (input format parser); (2) **mapper** extracts key-value pairs from each record — stateless, called once per record, may emit 0..n pairs, parallel over input shards; (3) framework **sorts by key** (implicit, always happens); (4) **reducer** iterates values grouped per key — sorted order makes same-key records adjacent, so little state needed.
- Mapper's role: put data into sortable form. Reducer's role: process sorted data. A second sort stage = a second MapReduce job.
- Functional-programming heritage: stateless, side-effect-free mapper/reducer calls are what allow arbitrary parallelism and safe retries with the same input. Lisp introduced map and reduce (fold) as higher-order list functions, since adopted by Python, Rust, Java. Many common operations, including those SQL offers, can be implemented on top of MapReduce.
- Why it lost: raw API is laborious (e.g. you implement joins yourself); rigid map→sort→reduce alternation; file-based I/O between jobs prevents pipelining (downstream can't start before upstream finishes); new JVM per task.

### Dataflow engines (Spark, Flink; lineage: Dryad, Nephele)
Handle a whole workflow as one job, with explicitly modeled dataflow. They expose two API levels: a low-level per-record UDF API (like MapReduce) plus higher-level relational operators — join, group by, filter, aggregate — all implemented internally on shuffles. Advantages over MapReduce:
- Sort only where actually needed, not between every stage.
- Fuse consecutive non-resharding operators (map, filter) into a single task — less data copying.
- Declared dependencies let the scheduler do **locality optimization** (place consumer next to producer, exchange via shared memory instead of network).
- Intermediate state kept in memory or local disk, not the replicated DFS.
- Operators start as soon as input is ready; no stage barrier.
- Process reuse instead of per-task JVM startup.

### Shuffle
- **A shuffle is a distributed sort** (despite the name — no randomness): input and output both sharded; foundational for joins, grouping, aggregation. Implemented by MapReduce, Spark, Flink, Daft, Dataflow, BigQuery.
- Hadoop mechanics: number of map tasks = number of input shards; number of reduce tasks is chosen by the job author. Each mapper writes one local sorted file *per reducer*, routing each key by **hash of key**; sorting uses the SSTable technique (sorted in-memory batches → sorted segments → merge). Reducers pull their file from every mapper, merge (preserving order), then call the reducer once per key with an iterator over values. Reducer outputs become the sharded output dataset on the DFS.
- Modern engines (e.g. BigQuery) keep shuffle data in memory and use dedicated external shuffle services that also replicate shuffle data for resilience.

### Joins and grouping
- **Sort-merge join**: map both inputs to key-value pairs keyed by the join key (e.g. user ID); shuffle brings both sides' records for a key to the same reducer; **secondary sort** can order records so the dimension record (e.g. user profile) arrives before the fact records (e.g. activity events). Reducer holds one dimension record in a local variable and streams through the facts — constant memory per key, **zero network requests** during the join itself.
- **Group-by/aggregation**: shuffle on the grouping key, then the reducer iterates each group keeping counters.

### Query languages and DataFrames
- Batch infrastructure now stores and processes **many petabytes on clusters of 10,000+ machines**; with physical operation largely solved, attention shifted to the programming model.
- **SQL is the lingua franca** of batch processing: less code, supports interactive/exploratory use by non-engineers, and enables machine-level optimization — cost-based optimizers (Hive, Trino, Spark, Flink) pick join algorithms and reorder joins to minimize intermediate state. A natural fit because legacy data warehouses used SQL, analytics/ETL tools already support it, and all developers and analysts know it.
- Niche alternatives: Pig (step-by-step relational pipelines; Morel is a modern language influenced by it), jq/JMESPath/JSONPath for JSON, Gremlin for graphs.
- **Batch frameworks and cloud warehouses have converged**: batch systems adopted SQL, columnar formats (Parquet), vectorized execution; warehouses adopted batch-style scheduling, fault tolerance, shuffles, DFS storage, DataFrame APIs (BigQuery DataFrames, Snowflake Snowpark).
- **When SQL doesn't fit**: iterative graph algorithms (PageRank), complex ML, multimodal/AI data (images, video, audio). **When warehouses don't fit**: row-by-row computation on columnar storage is inefficient; warehouses tend to cost more — large jobs are often cheaper on Spark/Flink. The choice usually comes down to cost, convenience, ease of implementation, and what's available — large enterprises run many processing systems and can pick per job; smaller companies often get by with just one.
- **DataFrames**: relational operators as function calls. Gotchas when moving from local to distributed: local DataFrames (Pandas, R) are indexed and ordered; distributed ones generally are not — expect performance surprises. Pandas executes eagerly; Spark builds a query plan and optimizes before executing. Daft splits client-side (small, in-memory) vs server-side (large) execution, with Apache Arrow as the shared columnar model.

## Batch use cases

Rule of thumb: batch fits wherever there is **lots of data and freshness doesn't matter**. Real examples: accounting/inventory reconciliation, demand forecasting, recommendation-model training, and the US banking network (ACH), which runs almost entirely on batch.

### ETL
- Transformations are mostly embarrassingly parallel (filter, project).
- Workflow schedulers give retries on transient failures, clear failure surfacing, and built-in source/sink operators (Airflow ships connectors for MySQL, PostgreSQL, Snowflake, Spark, Flink, ...).
- Rerunnability is the debugging superpower: inspect failed input files, fix logic, rerun (e.g. an input file missing a field the transform expects — spot it, then fix the transform or the job that produced the input).
- Data mesh / data contracts / data fabric practices let teams beyond a central data-engineering team publish and manage pipelines safely.
- Pipelines and analytics increasingly share execution engines (SparkSQL, Trino, DuckDB run both).

### Analytics
- **Lakehouse architecture**: SQL query engine over DFS/object store, with table formats (Apache Iceberg) and catalogs (Unity) managing table-to-file metadata.
- Two query styles: **pre-aggregation** (scheduled rollups into OLAP cubes/data marts, optionally pushed to real-time OLAP stores like Druid or Pinot) and **ad hoc** (iterative exploration where response time matters).
- SQL support is what connects batch engines to BI tools (Tableau, Power BI, Looker, Superset).

### Machine learning
- Feature engineering (transforming text/discrete values into the numeric form models need), model training (data in → weights out), and batch inference (bulk predictions when real-time isn't needed, including evaluating a model's predictions on a test dataset). Spark MLlib, FlinkML provide tooling.
- Graph algorithms (recommendations, ranking) use the **bulk synchronous parallel (BSP) / Pregel** model: repeated edge traversals propagating information until convergence (Giraph, Spark GraphX, Flink Gelly).
- LLM data prep is batch: extract text from HTML, deduplicate/filter low-quality docs, tokenize and embed. Purpose-built frameworks: Kubeflow, Flyte, Ray (OpenAI uses Ray for ChatGPT training), integrating PyTorch/TensorFlow/XGBoost, with built-in support for feature engineering, training, batch inference, and fine-tuning (adapting a foundation model to specific use cases).
- Data scientists explore data in interactive notebooks (Jupyter, Hex); notebook cells commonly run batch jobs through DataFrame APIs or SQL.

### Serving derived data — critical anti-pattern and fixes
Typical derived datasets: product recommendations, user-facing reports, ML features — served from a production database, key-value store, or search engine, so the data must travel from the DFS/object store back to the system serving live traffic.

**Do not write from batch tasks directly to a production database, record by record.** Three reasons:
1. Per-record network round-trips are orders of magnitude slower than batch throughput (even with client batching).
2. Many parallel tasks writing at batch speed can overwhelm the database and degrade production queries, cascading into operational problems elsewhere.
3. It breaks the **all-or-nothing guarantee**: batch jobs normally produce output as if every task ran exactly once, even after retries; external writes leak partial/duplicate output from failed or retried tasks.

Better patterns:
- **Push to a stream (Kafka topic)**; downstream systems (Elasticsearch, Pinot, Druid, Venice, ClickHouse) ingest from it. Streams are optimized for sequential writes, act as a buffer so consumers throttle their own read rate, fan out one output to many consumers, and can serve as a security boundary (DMZ between batch and production networks). Caveat: streaming alone doesn't restore all-or-nothing — the job must send a completion notification, and consumers must keep ingested data invisible until notified (like an uncommitted transaction under read committed).
- **Build the database inside the batch job and bulk-load the files** (TiDB Lightning, Pinot Hadoop import, RocksDB SST ingestion). Very fast; enables atomic switching between dataset versions. Weakness: incremental updates are hard — hybrid approaches (e.g. Venice hybrid stores) combine full swaps with row-based updates.

## How this connects

- **Ch 1**: derived data vs. systems of record; data warehousing and ETL; operational vs. analytical systems.
- **Ch 2**: shared-nothing vs. shared-disk architectures (basis of DFS design); hardware and software faults — one reason long batch jobs must tolerate task failures.
- **Ch 3**: graph data models (batch graph processing); DataFrames as a data model.
- **Ch 4 (storage)**: log-structured storage/SSTables (the sort-and-merge technique reused in shuffle and GNU sort); column-oriented storage (Parquet); materialized views and data cubes; cloud data warehouses; key-value stores (contrast with object stores).
- **Ch 5 (encoding)**: Avro as a row-based batch file format (Parquet's columnar details are in Ch 4); durable execution/workflow engines (distinct meaning of "workflow").
- **Ch 6**: replication (DFS block replication).
- **Ch 7**: sharding, hash-of-key routing (the shuffle partitions by key hash); parallel execution depends on sharding.
- **Ch 8 (transactions)**: read committed isolation, used as the model for hiding stream-ingested data until a batch job signals completion.
- **Ch 9**: unreliable networks — another source of task failures in long batch jobs.
- **Ch 10**: coordination services (ZooKeeper, etcd) that store orchestrator cluster state.
- **Ch 12 (next)**: stream processing — batch with unbounded input; batch outputs feed streams (Kafka) to serve derived data.
