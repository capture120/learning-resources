# Chapter 11: Batch Processing — Examples and Case Studies

All examples come from the chapter text. Each retells the example and states the principle it demonstrates.

## NGINX log analysis with a Unix pipeline

A web server appends one line per request to an access log (NGINX default format: client IP, user, timestamp, request, status, bytes sent, referer, user agent). To find the five most popular pages, the chapter builds a pipeline: `cat access.log | awk '{print $7}' | sort | uniq -c | sort -r -n | head -n 5`. The `awk` step extracts the URL (field 7), the first `sort` makes repeated URLs adjacent, `uniq -c` counts adjacent duplicates, the second `sort -rn` ranks by count, and `head` keeps the top five. The output lists counts like 4189 hits for /favicon.ico.

The pipeline processes gigabytes in seconds and is trivially modifiable: change the `awk` pattern to exclude CSS files (`$7 !~ /\.css$/`) or count client IPs instead (`{print $1}`). Log analysis like this is real production work at technology companies, used for everything from ad pipelines to payment processing — it drove the original adoption of MapReduce and "big data."

**Principle:** composable single-purpose tools connected by a uniform interface form a powerful, flexible batch processor.

## Python script vs. Unix pipeline: hash aggregation vs. sorting

The same top-5-URLs analysis is rewritten as a short Python script that reads the log line by line, increments a counter per URL in an in-memory hash table, then sorts the table's entries to print the top five. Syntactically it's a matter of taste, but the execution model differs fundamentally from the pipeline: the script needs random-access memory proportional to the number of *distinct* URLs (a million log lines for one URL still cost one hash entry), while the pipeline relies on sorting.

If the distinct-key working set fits in roughly 1 GB of memory — true for most small to mid-sized websites — the hash table works fine even on a laptop. If the working set exceeds memory, sorting wins: data is sorted in memory chunks, written as sorted segment files, and merged, giving sequential disk access patterns. GNU `sort` does this spilling automatically and also parallelizes across CPU cores, so the naive-looking pipeline scales to datasets far larger than RAM; the bottleneck becomes disk read rate.

**Principle:** choose in-memory aggregation when distinct keys fit in RAM; choose sort-based processing when the working set exceeds memory, because mergesort degrades gracefully to disk.

## The operating-system analogy for distributed frameworks

The machine running the Unix pipeline has storage accessed through a filesystem, a scheduler allocating CPU to processes, and programs wired together by pipes. The chapter maps each component onto distributed batch frameworks: distributed filesystems play the filesystem role, job orchestrators play the kernel scheduler role, and tasks exchanging data over the network or through files play the role of piped processes. Local filesystem layering (block drivers → page cache → ext4/XFS metadata → VFS) likewise maps to DFS layering (data-node block daemons → data-node page caches → metadata services like HDFS's NameNode → a pluggable protocol such as the S3 API).

**Principle:** a distributed batch framework is a distributed operating system; the analogy predicts what components it must have.

## Block sizes: a 900 MB file on HDFS

Local filesystems use tiny blocks (ext4: 4,096 bytes) and physical devices must write whole blocks. DFSs use much larger blocks — HDFS defaults to 128 MB; JuiceFS and many object stores use 4 MB — because larger blocks mean less metadata at petabyte scale and lower seek overhead relative to read size. Because DFS blocks are files on ordinary filesystems, the last block need not be padded: a 900 MB file stored with 128 MB blocks occupies seven 128 MB blocks plus one 4 MB block.

**Principle:** DFS block size is tuned for metadata economy and sequential throughput, not for the constraints of physical disks.

## S3 object keys and the illusion of directories

An object lives at a URL like `s3://my-photo-bucket/2025/04/01/birthday.png`: bucket name (globally unique) plus key (unique within the bucket). The slashes are convention, not directories. A prefix list behaves like a recursive `ls -R`, returning everything under the prefix including subpaths. Empty directories cannot exist: delete all objects under `.../2025/04/01` and `01` vanishes from listings, so practitioners create zero-byte marker objects to keep "directories" present.

Renames illustrate the deeper difference: object stores have no atomic rename, no links, no locking. Renaming means copy-then-delete, and renaming a "directory" means individually renaming every object whose key contains it.

**Principle:** object stores are key-value interfaces over immutable blobs; treating them as filesystems hides real semantic differences that bite at the edges.

## Scheduling two 100-core jobs on a 160-core cluster

A five-node cluster has 160 CPU cores. Two job requests arrive, each wanting 100 cores. The scheduler's options each carry a cost: split the cluster (run 80 tasks per job, backfill as tasks finish); gang-schedule (run one job fully, start the second only when 100 cores free up); or, if the second request arrives much later, guess whether to give the first job everything or hold cores back for a job that may never come. Gang scheduling that *reserves* cores leaves nodes idle and can deadlock if other jobs reserve too; passively *waiting* for 100 free cores risks starvation as other jobs grab them; preempting the first job's tasks frees cores but wastes the killed tasks' work.

Scaled to hundreds or millions of job requests, optimal allocation is NP-hard, so real schedulers use heuristics: FIFO, dominant resource fairness, priority queues, capacity/quota scheduling, bin-packing.

**Principle:** cluster scheduling is a fairness-versus-efficiency trade-off with no optimal solution; every strategy (splitting, gang scheduling, reservation, preemption) has a concrete failure mode.

## Spot instances and preemption

Cloud providers sell spare capacity cheaply as spot instances (AWS), spot VMs (Azure), or preemptible instances (Google Cloud), which can be killed whenever a higher-priority workload arrives. Batch jobs are usually not time-sensitive and regenerate output from scratch, so they are the ideal tenant for this capacity — it raises cluster utilization and cuts cost. The catch: tasks on such capacity die from preemption more often than from hardware faults, so the framework must retry at individual-task granularity rather than restarting whole jobs.

**Principle:** batch's tolerance of task-level restarts converts unreliable cheap capacity into a cost advantage.

## A multi-tool workflow: Spark to HDFS to Trino to S3

As an example of why workflows (DAGs of jobs) exist, the chapter describes a pipeline where a Spark job writes its output to HDFS, then a Python script triggers a Trino SQL query that processes those HDFS files further and writes results to S3. Other motivations: one team's output feeds several other teams' jobs (so it must land somewhere all can read), and multi-stage pipelines where consecutive stages need the data sharded by different keys. Workflows of 50–100 jobs are common, managed by workflow schedulers like Airflow, Dagster, or Prefect, which wait for all of a job's input-producing jobs to succeed before running it.

**Principle:** materializing output to shared storage between jobs decouples teams, tools, and schedules — at the cost of waiting for upstream jobs to finish.

## Fault-handling strategies: MapReduce vs. Spark vs. Flink

When one task's output feeds another, frameworks diverge on protecting intermediate data. MapReduce writes all intermediate data to the distributed filesystem and lets consumers read only after the write completes — robust even with frequent preemption, but expensive in replicated disk writes. Spark keeps intermediate data in memory, spilling to local disk, writes only final results to the DFS, and records the lineage of each intermediate dataset so lost pieces can be recomputed. Flink instead periodically checkpoints snapshots of its tasks.

**Principle:** intermediate-state durability trades I/O cost against recovery cost; lineage-based recomputation and checkpointing avoid paying replication costs on every stage boundary.

## MapReduce as a generalized Unix pipeline

The chapter maps the log-analysis pipeline directly onto MapReduce's four steps: split input into records (one log line each); a mapper extracts a key and value per record (`awk '{print $7}'` — URL as key, empty value); the framework sorts all pairs by key (the first `sort`); a reducer iterates the now-adjacent same-key pairs (`uniq -c` counting them). The second ranking sort has no slot in a single job — it requires a second MapReduce job consuming the first job's output. Mapper = prepare data for sorting; reducer = process sorted data.

**Principle:** MapReduce is the Unix sort-pipeline pattern made distributed, with the sort step built into the framework.

## Shuffle mechanics: three mappers, three reducers

The chapter walks through a Hadoop job (its Figure 11-1) with input sharded into files m1, m2, m3 — shards of one dataset are grouped by sharing an HDFS directory or an object-key prefix. One map task starts per input shard; the job author separately chooses the number of reduce tasks. Each mapper writes a local sorted file per reducer — pair (m1, r2) is mapper 1's data destined for reducer 2 — choosing the file by a hash of the key, and sorting within each file using the in-memory-batch-then-merge segment technique. When mappers finish, each reducer copies its file from every mapper, merges them mergesort-style so same-key records are consecutive regardless of origin mapper, and invokes the reducer function once per key with an iterator over its values. Reducer outputs (r1, r2, r3) become the sharded output dataset on the DFS. Modern systems like BigQuery refine this with in-memory shuffles and dedicated replicated shuffle services.

**Principle:** a shuffle is a distributed sort with sharded input and output — the foundational primitive beneath joins, grouping, and aggregation.

## Sort-merge join: activity events joined with user profiles

Two large sharded datasets: a clickstream log of user activity events (the fact table) and a user-profile database with dates of birth (a dimension table). The analysis — are certain pages more popular with younger or older users? — needs a join on user ID. One mapper emits (user ID → page URL) from the event log; another emits (user ID → date of birth) from the user database. The shuffle delivers all records for a given user ID to one reducer, and a *secondary sort* orders them so the profile record arrives first, followed by activity events in timestamp order. The reducer stores the date of birth in a local variable and streams through the events, emitting (URL, viewer date of birth) pairs — one user record in memory at a time, no network requests during the join.

A second job then groups by URL: shuffle on URL as key, and each reducer keeps per-age-group counters as it iterates a URL's page views, producing the age distribution per URL.

**Principle:** sorting plus co-partitioning turns a join into a cheap streaming merge (sort-merge join), and the same shuffle machinery implements group-by aggregation.

## Pregel/BSP graph processing for recommendations

Recommendation engines and ranking systems lean on graph algorithms expressed as repeated traversals: join a vertex with its neighbor along one edge, propagate information, repeat until no edges remain to follow or a metric converges. The bulk synchronous parallel (BSP) model, popularized by Google's Pregel paper, structures this iteration and is implemented by Apache Giraph, Spark's GraphX, and Flink's Gelly. Iterative algorithms like PageRank are also cited as workloads that are hard to express in SQL.

**Principle:** iterative graph algorithms need a dedicated batch model (BSP/Pregel) because they don't fit the one-pass relational/SQL paradigm.

## LLM training data preparation

Preparing raw web text for large language model training is presented as a modern batch workload. Raw HTML sits in a DFS or object store; batch preprocessing extracts plain text and fixes malformed text, detects and removes low-quality, irrelevant, and duplicate documents, then tokenizes the text and converts tokens into embeddings. Purpose-built frameworks — Kubeflow, Flyte, Ray — handle these pipelines with built-in PyTorch/TensorFlow/XGBoost integrations; OpenAI uses Ray in its ChatGPT training process.

**Principle:** AI data pipelines are classic batch jobs — huge immutable inputs, embarrassingly parallel transforms, freshness not critical.

## Industries that run on batch

Brief real-world cases anchoring the use-case survey: companies reconcile accounting and inventory against bank transactions as batch jobs; manufacturers run demand forecasting as periodic batch jobs; ecommerce, media, and social media companies train recommendation models in batch (Facebook is cited running a 60 TB+ Spark production job); and the US banking network (ACH) runs almost entirely on batch processing.

**Principle:** batch fits wherever data volume is large and freshness is unimportant — which covers much of the economy's core data processing.

## The anti-pattern: writing from a batch job straight into a production database

It is tempting to use a database client library inside a batch job and insert results one record at a time into the production database serving live traffic. The chapter dismantles this: per-record network requests run orders of magnitude slower than batch throughput (client-side batching barely helps); many parallel tasks writing at full batch speed can overwhelm the database and degrade live queries, cascading into other systems; and external writes destroy the job's all-or-nothing guarantee — partially completed or retried tasks leak duplicate, externally visible side effects.

The recommended fix is to push outputs to a stream such as a Kafka topic, which Elasticsearch, Pinot, Druid, Venice, and ClickHouse can all ingest. Streams take sequential bulk writes well, buffer between the job and production (consumers throttle their own reads), fan out to multiple consumers, and can sit in a DMZ network as a security boundary. To recover all-or-nothing semantics, the job must notify consumers on completion, and consumers must hide ingested data until notified — like an uncommitted transaction under read-committed isolation.

**Principle:** never couple batch write throughput directly to a serving database; insert a stream as buffer, fan-out, and commit boundary.

## Bulk-loading prebuilt database files

An alternative serving pattern, common when bootstrapping: the batch job builds complete database files itself, which are then bulk-imported — TiDB's Lightning, Apache Pinot's Hadoop import jobs, and RocksDB's SST-file ingestion API are cited. This is very fast and lets the serving system atomically swap between dataset versions. Its weakness is incremental updates, so hybrid designs emerge: LinkedIn's Venice supports hybrid stores combining full dataset swaps with batch row-based updates.

**Principle:** building the database inside the batch job gives atomic version swaps; combine with row-based updates when you need both bootstrapping and incremental loads.
