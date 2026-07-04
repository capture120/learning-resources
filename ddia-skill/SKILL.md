---
name: designing-data-intensive-applications
description: Distilled knowledge from "Designing Data-Intensive Applications" 2nd edition (Kleppmann & Riccomini) — data models, storage engines, replication, sharding, transactions, distributed systems, batch/stream processing, and data ethics. Use when designing, choosing, debugging, or reasoning about databases and data systems.
---

# Designing Data-Intensive Applications — Skill Overview

This skill distills DDIA 2nd edition, a book about the architecture of systems that store and process data. Its central stance: there are no solutions, only trade-offs — every design choice (data model, storage engine, replication scheme, isolation level, processing style) buys something by giving something up, and good engineering means matching those trade-offs to your application's actual needs. The skill is organized by chapter under `chapters/NN-slug/`. Each chapter directory has two files: `learnings.md` (core concepts, trade-offs, decision guidance) and `examples.md` (the chapter's concrete examples and case studies, retold). A shared `glossary.md` at the root defines terminology used across all chapters.

## Routing guide

Find the chapter matching the question, then load its files.

**1. Trade-Offs in Data Systems Architecture** — `chapters/01-tradeoffs-in-data-systems/`
Data system design is choosing among trade-offs: operational vs. analytical systems, cloud vs. self-hosting, distributed vs. single-node, business vs. legal/societal obligations.
Load when: warehouse/lake/ETL vs. querying production; managed cloud vs. self-host; distribute vs. one big machine; microservices/serverless; system-of-record vs. derived data; storage/compute separation; GDPR/data-residency basics; core terms (OLTP/OLAP, data lake, cloud native).

**2. Defining Nonfunctional Requirements** — `chapters/02-nonfunctional-requirements/`
How to define and measure performance (response-time percentiles, throughput), reliability (faults vs. failures), scalability, and maintainability — grounded in a social-network timeline fan-out case study.
Load when: picking SLOs/SLAs or percentiles (p99, tail latency); retry storms and metastable overload; fan-out-on-write vs. query-on-read for feeds; vertical vs. horizontal scaling decisions; expected fault rates; percentile monitoring pitfalls; postmortems and operability.

**3. Data Models and Query Languages** — `chapters/03-data-models-query-languages/`
Choosing among relational, document, graph, event-sourcing, and DataFrame models (and their query languages) based on relationship shape, schema needs, and read/write patterns.
Load when: relational vs. document vs. graph DB choice; normalize vs. denormalize; ORM/N+1 problems; schema-on-read vs. schema-on-write and migrations; graph queries (Cypher/SPARQL/recursive SQL); GraphQL; event sourcing/CQRS; star/snowflake warehouse schemas; DataFrames for ML.

**4. Storage and Retrieval** — `chapters/04-storage-and-retrieval/`
How storage engines work internally: LSM-trees vs. B-trees for OLTP, column-oriented storage for analytics, and specialized indexes (multidimensional, full-text, vector).
Load when: B-tree DB (PostgreSQL) vs. LSM DB (RocksDB/Cassandra); write amplification, compaction stalls; which indexes to add; columnar formats (Parquet), table formats (Iceberg), warehouses; geospatial/full-text/fuzzy search; vector indexes (IVF/HNSW) for semantic search/RAG; true deletion and snapshots.

**5. Encoding and Evolution** — `chapters/05-encoding-and-evolution/`
Encoding data (JSON, Protocol Buffers, Avro) so old and new code/data versions coexist, and how compatibility plays out across databases, REST/RPC, workflows, and messaging.
Load when: choosing a serialization format; is this schema change safe (add/remove/rename field); rolling upgrades; backward/forward compatibility; schema registries; REST vs. gRPC vs. async messaging; API versioning; durable execution (Temporal); service discovery/meshes.

**6. Replication** — `chapters/06-replication/`
Keeping copies of changing data consistent via single-leader, multi-leader, or leaderless replication, and the consistency, failure, and conflict trade-offs each forces.
Load when: replicas inconsistent or reads stale/out-of-order; failover, split brain, fencing; sync vs. async replication; read-your-writes/monotonic reads; offline-first and collaborative apps (CRDTs/OT); quorum tuning (n, w, r) in Dynamo-style stores; last-write-wins data loss; multi-region.

**7. Sharding** — `chapters/07-sharding/`
Splitting a dataset into shards across nodes: partition keys, key-range vs. hash schemes, rebalancing without hot spots, request routing, and sharded secondary indexes.
Load when: whether to shard at all; choosing a partition key; hot shard/hot key debugging; rebalancing and shard counts; routing tiers and coordination services (ZooKeeper/etcd); local vs. global secondary indexes; scatter/gather latency; multitenant SaaS isolation; slow cross-shard queries.

**8. Transactions** — `chapters/08-transactions/`
What ACID actually guarantees, which races each isolation level allows (read committed, snapshot isolation, serializable), how serializability is implemented, and distributed atomic commit (2PC).
Load when: picking an isolation level; lost updates, write skew, phantoms, double bookings; atomic UPDATE vs. SELECT FOR UPDATE vs. compare-and-set; serializable options (serial execution, 2PL, SSI); cross-shard or cross-system transactions, 2PC/XA; exactly-once via idempotence; retry semantics; durability.

**9. The Trouble with Distributed Systems** — `chapters/09-trouble-with-distributed-systems/`
The fundamental failure modes — unreliable networks, unreliable clocks, arbitrary process pauses — and reasoning tools: quorums, fencing tokens, system models, safety/liveness, testing.
Load when: tuning timeouts and failure detection; expired locks/leases and zombie processes; timestamp ordering vs. logical clocks; clock skew, NTP, leap seconds; GC pauses and nodes wrongly declared dead; Byzantine faults; system models for algorithm design; Jepsen/TLA+/deterministic simulation testing.

**10. Consistency and Consensus** — `chapters/10-consistency-and-consensus/`
Linearizability as the precise meaning of strong consistency, why ID generators and logical clocks fall short, and how consensus algorithms (Raft, Paxos) make linearizable fault-tolerant systems possible.
Load when: does this need linearizability (locks, leases, uniqueness, leader election); cross-channel race conditions; do quorum reads give strong consistency (no); ID generation schemes (UUIDv7/Snowflake/Lamport); operating Raft/etcd/ZooKeeper clusters; CAP/PACELC; fencing tokens and coordination services.

**11. Batch Processing** — `chapters/11-batch-processing/`
How batch jobs process large immutable datasets: Unix pipelines to Spark/Flink, distributed filesystems and object stores, orchestration and scheduling, shuffles and joins, serving derived output safely.
Load when: designing ETL pipelines and workflow DAGs (Airflow); Spark vs. warehouse vs. Unix tools; S3 semantics vs. real filesystems; batch job failures, spot-instance preemption; cluster scheduling trade-offs; distributed joins/group-bys/shuffles; ML/LLM data prep; getting batch output into serving systems.

**12. Stream Processing** — `chapters/12-stream-processing/`
Transmitting, storing, and continuously processing unbounded event streams: message brokers, logs, change data capture, windowing, stream joins, and effectively-once fault tolerance.
Load when: RabbitMQ/SQS-style vs. Kafka/Kinesis-style brokers; keeping caches/indexes/warehouses in sync (CDC, outbox, dual-write bugs); windowed aggregations and late events; stream joins and enrichment; exactly-once output; consumer lag and retention; deleting user data from immutable logs.

**13. A Philosophy of Streaming Systems** — `chapters/13-philosophy-of-streaming/`
Composing specialized systems by deriving all state from ordered event logs, and achieving correctness through end-to-end mechanisms (request IDs, idempotence, async constraints, auditing) instead of distributed transactions.
Load when: derived stores drifting from the source database; log-based integration vs. 2PC/XA; preventing duplicate execution of retried requests end-to-end; uniqueness/balance constraints without atomic commit; zero-downtime reprocessing migrations; RPC vs. subscribing to change streams; timeliness vs. integrity; auditing.

**14. Doing the Right Thing** — `chapters/14-doing-the-right-thing/`
The ethics of data systems: predictive analytics, bias amplification, feedback loops, behavioral tracking, and how engineers should weigh consent, privacy, minimization, and accountability.
Load when: automated decisions about people (credit, hiring, moderation) needing fairness or recourse; what behavioral data to collect/retain; proxy discrimination in ML; consent and GDPR for tracking; feedback loops and societal consequences; breach/acquisition/government threat models; engineer responsibility.

## Cross-cutting themes

- **Trade-off thinking** — no approach is fundamentally better; evaluate pros and cons against the application's specific needs. Framed in `01`, applied everywhere (notably `03`, `04`, `06`, `08`).
- **Logs as a unifying abstraction** — the append-only log underlies storage engines (`04`), replication (`06`), event sourcing (`03`), brokers and CDC (`12`), and whole-architecture design (`13`).
- **Derived data vs. systems of record** — caches, indexes, timelines, warehouses, and views are rebuildable copies needing an explicit sync process: `01`, `02`, `03`, `11`, `12`, `13`.
- **Fault tolerance and partial failure** — design so component faults don't become system failures: faults/failures in `02`, replication faults in `06`, network/clock/pause faults in `09`, consensus in `10`.
- **Concurrency and ordering** — happens-before, version vectors, logical clocks, isolation levels: conflicts in `06`, race anomalies in `08`, why wall clocks lie in `09`, linearizability and consensus in `10`.
- **Exactly-once is really effectively-once** — idempotence, dedup by request ID, and fencing replace distributed transactions: `05` (durable execution), `08` (dedup tables), `12` (stream fault tolerance), `13` (end-to-end argument).
- **Compatibility and evolution** — old and new code/data always coexist, so plan for schema evolution, rolling upgrades, and reversible migrations: `02` (evolvability), `03` (schema-on-read), `05` (encoding), `13` (reprocessing).
- **Data systems are shaped by law and society** — privacy regulation, data minimization, deletion from immutable storage, and ethical responsibility: `01`, `04` (hard deletion), `12` (crypto-shredding), `14`.

## How to use

Start from the routing guide above and load only what the question needs. Read a chapter's `learnings.md` for concepts, trade-offs, and decision guidance — this is the default. Add its `examples.md` when a concrete scenario helps explain or justify a recommendation. Consult `glossary.md` when terminology is unclear or a precise definition matters.
