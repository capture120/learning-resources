# Chapter 12: Stream Processing — Core Learnings

**Central thesis:** Stream processing is batch processing on unbounded data: instead of processing fixed chunks on a schedule, you process every event as it arrives. Logs (append-only, replayable, ordered) are the unifying abstraction — they connect message brokers, database replication, change data capture, and event sourcing, and they make derived data systems (caches, indexes, materialized views) reproducible and continuously up to date.

## Transmitting Event Streams

- An **event** = a small, self-contained, immutable record of something that happened at a point in time, usually with a timestamp. The streaming analog of a batch record.
- **Producers** write events; **consumers** read them; related events are grouped into a **topic**. Polling a database for new events gets expensive at low latencies — the more often you poll, the lower the fraction of requests that return new events, so overhead rises. You want push notification, which databases historically do badly (triggers are limited). Hence dedicated messaging systems. Messaging generalizes the Unix pipe / TCP model from one sender–one recipient to many producers and consumers per topic.

### Two questions that classify any messaging system
1. **What happens when producers outpace consumers?** Three options: drop messages, buffer in a queue, or apply backpressure (block the producer; what Unix pipes and TCP do). If buffering: what happens when the queue exceeds memory or disk fills?
2. **What happens when a node crashes — are messages lost?** Durability needs disk writes and/or replication, which costs throughput/latency. Tolerable loss depends on the data: periodic sensor/metric readings can miss a point (next reading supersedes it); event *counts* cannot — every lost message corrupts the counter.

### Direct messaging (no broker)
UDP multicast (finance market feeds), brokerless libraries (ZeroMQ, nanomsg), StatsD-style UDP metrics, webhooks (HTTP callback registered with another service).
- **Trade-off:** lowest latency, but application code must tolerate message loss. Assumes producers and consumers are constantly online; an offline consumer misses messages, and producer-side retry buffers are lost if the producer crashes.

### AMQP/JMS-style message brokers
RabbitMQ, ActiveMQ, IBM MQ, Azure Service Bus, Google Cloud Pub/Sub (log-like architecture but JMS-style API). Broker is a server; durability problem moves to the broker (some keep messages only in memory, others write to disk, depending on configuration). Faced with slow consumers, brokers generally choose unbounded queueing rather than dropping or backpressure. Delivery is **asynchronous** — producer waits only for the broker's buffer confirmation; consumers usually get the message within a fraction of a second but possibly much later under backlog. Some brokers can even participate in two-phase commit via XA/JTA, making them quite database-like. (Using an actual database as a queue is possible, but tuning it for good performance is not straightforward.)

Differences from databases:
- Broker deletes a message once acknowledged → unsuitable for long-term storage.
- Assumes short queues; large backlogs (spilling to disk) degrade throughput.
- No secondary indexes/queries, but does notify clients of new data (databases give point-in-time snapshots and no change notification).
- Consumption is **destructive**: acking deletes the message, so you can't rerun a consumer and get the same result (unlike batch's read-only inputs). A newly registered consumer receives only messages sent after registration — prior messages are gone and unrecoverable.

Two consumption patterns (combinable, e.g., Kafka consumer groups: each message goes to one consumer *within* a group, and every group gets every message):
- **Load balancing:** each message goes to one consumer in a group — parallelize expensive processing. (AMQP: multiple clients on one queue; JMS: "shared subscription".)
- **Fan-out:** each message goes to all consumers — independent subscribers, like multiple batch jobs reading one file. (JMS topic subscriptions; AMQP exchange bindings.)

**Acknowledgments and redelivery:** broker redelivers if a consumer dies before acking. If the ack (not the processing) was lost, the message is processed twice — preventing that needs atomic commit or idempotence.
- **Gotcha:** load balancing + redelivery reorders messages even in brokers that promise ordering (a crashed consumer's message is redelivered after later messages). If causal order between messages matters, don't load-balance (one queue per consumer).
- **Poison messages:** a malformed message that crashes its consumer is redelivered forever, blocking the queue (with strong ordering) or wasting resources. Use a **dead letter queue (DLQ)**: move the message aside, alert an operator, then drop / fix-and-replay / fix the consumer.

### Log-based message brokers
Kafka, Amazon Kinesis Streams. Hybrid of database durability and messaging's low-latency notification. The broker is an append-only **log**, sharded into **partitions**; each message gets a monotonically increasing **offset** within its partition. Total order within a partition; **no order guarantee across partitions**. Millions of messages/sec via sharding; fault tolerance via replication.

Mechanics:
- Fan-out is free: reading doesn't delete; consumers read independently.
- Load balancing = assign whole partitions to consumer-group nodes; each node reads its partitions sequentially, single-threaded. Parallelism is bounded by partition count — increase parallelism by adding partitions, not threads. (Workarounds exist — two consumers splitting a partition by even/odd offsets, or a thread pool — but they complicate offset management; single-threaded per partition is preferable.)
- Consumer progress = a single **offset** per partition (like a replication log sequence number; broker acts like a leader, consumer like a follower). Cheap bookkeeping, great batching/pipelining → high throughput. On failover, the new consumer resumes from the last *recorded* offset, so some messages get processed twice.
- Events needing a consistent mutual order must share a partition key (e.g., partition by user ID for per-user ordering).

**When to use which broker:**
- **JMS/AMQP style:** expensive per-message work, want message-by-message parallelism, ordering unimportant, no need to reread old messages (e.g., task queues, async RPC).
- **Log-based:** high throughput, fast per-message processing, ordering matters, want replay. (Distinction blurring: Kafka now offers queue-style consumer groups; Pulsar/Kafka Streams have DLQs.)
- **Head-of-line blocking:** one slow message in a partition delays everything behind it in that partition.

Disk space and slow consumers:
- Log is segmented; old segments are deleted/archived → effectively a large disk-backed circular buffer.
- Rule of thumb: a 20 TB drive at 250 MB/s sequential write fills in ~22 hours at maximum rate; real deployments buffer days to weeks.
- A consumer that lags past the retention window silently misses messages — **monitor consumer lag** and alert long before that, leaving humans time to react.
- Big operational win: a lagging/crashed/experimental consumer harms nobody else; only its offset remains. You can attach a debug consumer to production safely. (Contrast: in AMQP brokers an abandoned queue accumulates messages and steals memory.)
- **Replay:** consuming is read-only; rewind the offset and reprocess with different code — batch-like repeatability and recoverability.
- Tiered storage moves old segments to object storage (Kafka, Redpanda); some brokers live entirely in object storage (WarpStream, Confluent Freight, Bufstream), often as Iceberg tables queryable by batch/warehouse jobs directly.

## Databases and Streams

The connection is fundamental: every database write is an event. A replication log is a stream of write events; state machine replication (same events, same order, deterministic processing → same state) is event streaming.

### Dual writes are broken
Application writes the same change to several systems (DB, cache, search index) itself. Two failure modes:
1. **Race condition:** two clients' writes interleave differently at each system → systems disagree permanently, with no error reported and no detection (absent version vectors).
2. **Partial failure:** one write succeeds, the other fails → inconsistent, and fixing it is the atomic-commit problem (expensive).
Root cause: two leaders, neither following the other. Fix: make one system the leader and everything else a follower.

### Change Data Capture (CDC)
Extract the database's change log and apply it, in order, to derived systems (search index, cache, warehouse). The DB of record is the leader; consumers are followers. Use a log-based broker for transport — it preserves order.

- CDC is usually built on the **logical replication log**, which brings its own challenges — handling schema changes and properly modeling updates — that CDC tools must address.
- Tools: **Debezium** (connectors for MySQL, PostgreSQL, Oracle, SQL Server, Db2, Cassandra, ...), Kafka Connect, Maxwell (MySQL binlog), GoldenGate (Oracle), pgcapture (PostgreSQL). Most databases and cloud vendors now expose change streams as first-class APIs (e.g., Google Cloud Datastream); MySQL/PostgreSQL send changes through the same replication log their own replicas use.
- CDC is **asynchronous** → slow consumers don't slow the system of record, but all replication-lag problems apply (e.g., read-after-write anomalies in derived views).
- **Initial snapshot:** the log is usually truncated, so bootstrapping a new derived system needs a consistent snapshot tied to a known log offset. Debezium uses Netflix's DBLog watermarking algorithm for incremental snapshots.
- **Log compaction** avoids re-snapshotting: keep only the latest value per key (tombstones mark deletes). The compacted log size depends on the dataset's current size, not write history. Scan a compacted topic from offset 0 → full copy of the database. Kafka supports this; it makes the broker usable as durable storage.
- Quorum databases (Cassandra) are awkward for CDC — no single source of truth. Cassandra exposes per-node raw log segments; consumers must merge them like a quorum reader.

### CDC vs event sourcing
Same idea (log of changes as truth) at different abstraction levels:
- **CDC:** application mutates the DB normally; the log is extracted at a low level. Each change event contains the full new record state → compaction works. Adoptable on an existing system with minimal change; the writing app may not even know.
- **Event sourcing:** application is *built on* immutable, append-only events expressing user intent (not state mechanics). Later events don't supersede earlier ones → **compaction impossible**; you need the full history (plus snapshots as a read/recovery optimization). Log-based brokers configured never to delete events suit event sourcing well: append-only storage plus low-latency notification.
- Prefer CDC for retrofitting; event sourcing is a major architectural commitment with richer semantics.

### CDC schema coupling and the outbox pattern
CDC publishes your table schema — it becomes a **public API**. Dropping a column can break downstream consumers, possibly causing customer-facing outages (worse than old ETL breakage because production services consume CDC streams). Mitigations: data contracts; the **outbox pattern** — write to a separate outbox table with a stable schema *in the same transaction* as the domain write, and CDC the outbox. It is a dual write, but both writes share one transaction, so the dual-write hazards vanish. Costs: you maintain an internal↔outbox transformation, and write amplification on the database.

### State, streams, and immutability
- Mutable state and an append-only event log are two views of the same thing: **state = integral of the event stream; change stream = derivative of state** (available seats = processed reservations; account balance = credits and debits; the analogy has limits — a second derivative of state isn't meaningful). Gray & Reuter (1992): the log contains all the information; the database exists only to make reads fast.
- **Advantages of immutable events:** auditability (accounting ledgers: errors are fixed with compensating entries, never erased); easier recovery from buggy deployments (bad data didn't destroy history); captures information current state loses (cart add-then-remove is invisible in state, valuable for analytics).
- **Multiple views from one log:** derive several read-optimized representations from the same event stream; build a new view alongside the old, migrate readers gradually, then retire the old — usually easier than in-place schema migration. Normalization debates fade: write in log form, denormalize freely in derived views; the translation pipeline keeps them consistent.
- **CQRS downside:** derived views are asynchronous → users may not read their own writes. Synchronous view updates need either a distributed transaction across the log and the view, or a way to wait until the event is reflected in the view — both usually impractical.
- **Concurrency simplification:** a self-contained event = one atomic append, removing much of the need for multi-object transactions. If log and state are sharded the same way, a single-threaded per-shard consumer needs no write concurrency control. Immutability for concurrency control isn't unique to event sourcing: databases use immutable/multiversion data for snapshot isolation, and Git/Mercurial/Fossil rely on it for version history.
- **Limits of immutability:**
  - High-churn workloads (many updates/deletes on a small dataset): history grows prohibitively large, fragmentation appears; compaction/GC performance becomes operationally critical. Append-mostly workloads are easy to make immutable.
  - Legal deletion (GDPR) requires actually rewriting history (Datomic "excision", Fossil "shunning"). Truly deleting is hard — copies live in SSDs, backups, derived systems.
  - **Crypto-shredding:** store data encrypted, delete the key to "delete" the data. This only moves the problem: the data stays immutable, but the key store is mutable. Caveats: key granularity must be chosen up front (shred all-or-nothing per key); per-item keys make key storage as big as the data. Puncturable encryption can selectively revoke a key's decryption abilities but isn't widely used yet. Deletion is really "making data harder to retrieve."

## Processing Streams

Three things to do with a stream: (1) write events into a database/cache/index, (2) push events to humans (alerts, dashboards), (3) transform streams into derived streams via **operators/jobs** (pipelines). Operators read input read-only and write output append-only, like Unix pipes / MapReduce. Crucial difference from batch: **the stream never ends** — sorting makes no sense on unbounded input (a sort must read *everything* before emitting anything, since the very last record could sort first), so no sort-merge joins; and "restart from scratch on failure" doesn't work for a years-long job.

### Use cases
- **Complex event processing (CEP):** declare patterns of events (like regexes over event sequences) in a declarative SQL-like language or GUI; engine keeps queries long-term, maintains an internal state machine per query, and on a match emits a *complex event* (hence the name) with the pattern's details — the query/data relationship is inverted vs a database. Developed in the 1990s. Esper, Apama, TIBCO StreamBase; Flink/Spark SQL on streams.
- **Stream analytics:** aggregations and statistics over windows (rates, rolling averages, week-over-week comparisons). Window sizing intuition: averaging over a few minutes smooths irrelevant second-to-second fluctuations while still giving a timely picture of traffic changes. Probabilistic algorithms (Bloom filters for membership, HyperLogLog for cardinality, percentile sketches) trade exactness for much less memory — an *optimization*, not an inherent property; stream processing is not inherently approximate. Frameworks: Storm, Spark Streaming, Flink, Samza, Beam, Kafka Streams; hosted: Google Cloud Dataflow, Azure Stream Analytics.
- **Materialized view maintenance:** needs a window back to the beginning of time, which clashes with windowed analytics frameworks; Kafka Streams/ksqlDB build on log compaction. DB-native `REFRESH MATERIALIZED VIEW` reprocesses everything and is stale between runs. **Incremental view maintenance (IVM)** recomputes only changed data (Materialize, RisingWave, ClickHouse, Feldera; DBSP/differential dataflow theory) → far cheaper, much fresher. Because reads are in SQL and views are stored in OLAP-style formats, these systems also serve large-scale data-warehouse-style queries.
- **Search on streams:** store queries, match each document/event against them (Elasticsearch percolator). Index the queries too if there are many.
- **Not stream processing:** actor frameworks — they manage concurrency/distribution, communication is ephemeral one-to-one, topologies can be cyclic; stream processing is a data-management technique over durable, multi-subscriber, acyclic pipelines. Many actor frameworks don't guarantee message delivery on crashes, so processing on them isn't fault-tolerant unless you add retry logic.

### Reasoning about time
- **Event time** (when it happened) vs **processing time** (when the processor sees it). They diverge under queueing, faults, restarts, and replays. Windowing by processing time is simple and acceptable when the delay from event creation to processing is negligibly short, but it breaks down with any significant lag and produces artifacts: a processor catching up on a backlog sees a fake "spike." Use event time for correctness and determinism (replays give the same result).
- Message delays also reorder events across producers (a later event can arrive first).
- **Stragglers:** with event-time windows you never know a window is complete. After declaring it done, late events arrive. Options: (1) drop them and track the drop rate as a metric, (2) emit a correction (and possibly retract prior output). Watermarks ("no more events before t") help but are tricky with multiple producers, each with its own minimum-timestamp threshold — consumers must track each producer individually, and adding/removing producers complicates this.
- **Untrusted clocks:** user-device clocks can be wrong; server receipt time is reliable but less meaningful. Fix with three timestamps: event time (device clock), send time (device clock), receive time (server clock). Offset ≈ receive − send; corrected event time ≈ event time + offset. Assumes network delay is negligible relative to the accuracy needed, and that the device's clock offset didn't change between the event and its send.
- Batch processing has exactly the same time-reasoning problems; they're just more noticeable in streaming.
- **Window types:**
  - **Tumbling:** fixed length, no overlap; each event in exactly one window (round timestamp down).
  - **Hopping:** fixed length with overlap (e.g., 5-min window hopping by 1 min) — smoothing; build from tumbling windows.
  - **Sliding:** all events within interval d of each other; needs a time-sorted buffer, expiring old events. Unlike fixed boundaries: events at 10:03:39 and 10:08:12 share a 5-min sliding window, but a tumbling/hopping boundary could separate them.
  - **Session:** no fixed length — events of one user grouped until an inactivity gap (e.g., 30 min); standard for web analytics.
- Window state can be O(1) (a counter) or O(events) (sliding windows, joins buffer events) — size state capacity for window length × throughput.

### Stream joins
All three kinds maintain state from one input and probe it from the other. 
- **Stream–stream (window join):** e.g., join search events with click events by session ID to compute click-through rate. Index recent events from both streams within the join window; emit on match (and on expiry without match — embedding search data in the click event is *not* equivalent, because it misses non-clicks). Delay between events is highly variable; either event may arrive first. The two inputs can be the same stream (a self-join) to find related events within one stream.
- **Stream–table (enrichment):** look up each event against a table (e.g., add user profile to activity event). Querying the remote DB per event is slow and can overload it; instead keep a local copy (hash table or local index, the technique called a hash join) and keep it current with CDC — effectively a join of the activity stream with the changelog stream, where the table side has an infinite window and newer versions overwrite older; the stream side may keep no window at all.
- **Table–table:** join two changelogs to maintain a materialized join view (e.g., home timelines = posts ⋈ follows). The change stream of a join obeys the product rule: (u·v)′ = u′v + uv′.
- **Time dependence:** if state changes over time (profile updates, tax rates), which version does an event join with? Cross-partition/stream ordering is undefined → joins are **nondeterministic** across reruns. Data-warehouse fix: **slowly changing dimensions (SCD)** — version every record with a unique ID and reference the version in each event. Makes joins deterministic but defeats log compaction (all versions must be kept). Alternative: denormalize the value into the event at write time.

### Fault tolerance and exactly-once
Batch gets "exactly-once" (better: **effectively-once**) by discarding failed tasks' output. A stream never finishes, so you can't wait to publish output.
- **Microbatching** (Spark Streaming): split the stream into ~1-second mini-batches. Smaller batches → more scheduling overhead; larger → more latency. Implicitly imposes a processing-time tumbling window.
- **Checkpointing** (Flink): periodic rolling state checkpoints triggered by barriers in the stream; on crash, restart from the last checkpoint and discard output since. No forced window size.
- **Limit of both:** once output leaves the framework (DB write, email, external broker), it can't be retracted — a retry causes the side effect twice. You then need:
- **Internal atomic transactions:** make state change + message acks + output publication atomic, within one framework (not heterogeneous XA). Google Cloud Dataflow, VoltDB, Kafka transactions. Amortize protocol overhead by batching many messages per transaction.
- **Idempotence:** an operation done several times has the same effect as once (deleting a key is idempotent; incrementing a counter is not). Non-idempotent writes can often be made idempotent with extra metadata, e.g., store the triggering message's offset with the written value and skip already-applied updates. Requires: deterministic processing, replay of the same messages in the same order (log-based brokers provide this), no concurrent writers to the same value, and **fencing** on failover against zombie nodes. Cheap and effective when assumptions hold.
- **Rebuilding state** (window aggregates, join tables) after failure:
  - Remote replicated store: simple but per-message remote queries are slow.
  - Local state, periodically replicated: Flink snapshots to durable storage; Kafka Streams replicates state changes to a compacted Kafka topic (CDC-style); VoltDB processes each input redundantly on several nodes.
  - Sometimes no replication needed: replay a short window's input, or rebuild a CDC-maintained replica from the compacted changelog.
  - Local vs remote state trade-off shifts with infrastructure (network latency can beat disk); no universal answer.

## How this connects

- **Ch 11 (Batch):** stream processing = batch on unbounded input; same dataflow/sharding/join patterns; replayable logs restore batch's input immutability and repeatability. Message brokers and event logs are the streaming equivalent of a filesystem.
- **Ch 4 (Storage) & Ch 6 (Replication):** log-structured storage, compaction, replication logs, and log sequence numbers reappear as broker internals; broker=leader, consumer=follower.
- **Ch 5 (Encodings):** event encoding; CDC turns schemas into public APIs (schema evolution concerns).
- **Ch 7 (Sharding):** partitioned logs; partition key choice determines ordering guarantees.
- **Ch 8–9 (Transactions, Distributed problems):** atomic commit, exactly-once, clocks, idempotence, fencing.
- **Ch 10 (Consistency/Consensus):** total order in a log as a form of consensus; state machine replication.
- **Ch 2 & 3:** home-timeline case study becomes a table–table join; event sourcing/CQRS background.
- **Ch 13:** handling events that span multiple state shards; building correct systems from these pieces.
