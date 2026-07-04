# Chapter 12: Stream Processing — Examples and Case Studies

All examples below come from the chapter, retold compactly.

## Daily batch jobs are too slow
A daily batch process reflects input changes in its output up to a day later. Running smaller batches more often (hourly, per-second) reduces the delay; the limit of that progression is abandoning fixed time slices and processing every event as it happens — stream processing.
**Demonstrates:** stream processing as the continuous limit of batch processing.

## Sensor readings vs event counts under message loss
If a sensor sends periodic temperature or CPU metrics, one lost reading barely matters — the next reading supersedes it (though losing *many* messages can silently corrupt your metrics). If you are counting events, every lost message makes the counter wrong, so reliable delivery matters much more.
**Demonstrates:** acceptable message loss depends on the semantics of the data, and this should drive your durability choices.

## UDP multicast for stock market feeds
Financial exchanges distribute market data over UDP multicast because latency is paramount. UDP is unreliable, so the application layer compensates: producers remember sent packets and retransmit on request.
**Demonstrates:** direct, brokerless messaging wins on latency but pushes loss handling into application code.

## StatsD metrics over UDP
StatsD-style agents collect machine metrics over unreliable UDP. Counter metrics are correct only if every message arrives, so the resulting metrics are at best approximate.
**Demonstrates:** the drop-messages option in practice, and its silent accuracy cost.

## Webhooks
A consumer service registers a callback URL with a producer service; the producer makes an HTTP request to that URL whenever an event occurs.
**Demonstrates:** direct messaging via RPC — push delivery without a broker, but only while both sides are online.

## Consumer crash causes reordering (m3/m4)
Two consumers load-balance a queue. Consumer 2 crashes while processing message m3; the broker redelivers m3 to consumer 1, which has meanwhile processed m4. Consumer 1 thus processes m4 before m3 — the producer's order is violated even though the broker tries to preserve order.
**Demonstrates:** load balancing plus redelivery inevitably reorders messages; avoid load balancing when causal order between messages matters.

## The poison message loop and dead letter queues
A producer emits a malformed message (say, JSON missing a required key). The consumer crashes on it, never acks, and the broker redelivers it — crashing the next consumer, forever. With strict ordering the whole queue stalls; without it, resources are wasted on a message that will never succeed. The fix is a dead letter queue: move the message to a separate monitored queue, where an operator drops it, fixes and replays it, or fixes the consumer.
**Demonstrates:** unbounded redelivery is a failure mode; DLQs convert a stuck stream into an operator alert.

## tail -f as a message broker
Unix `tail -f` watches a file and emits data as it is appended. A log-based broker works the same way: producers append, consumers read sequentially and wait at the end of the log for new data.
**Demonstrates:** the log abstraction underlying Kafka-style brokers.

## Partitioning by user ID for ordering
A sharded log only orders messages within one partition. If events about one user must stay in order, choose the user ID as the partition key so all of that user's events land in the same partition.
**Demonstrates:** partition key choice is how you buy ordering guarantees in a sharded log.

## The 22-hour disk buffer calculation
A typical large hard drive holds 20 TB and writes sequentially at 250 MB/s. Writing flat-out, it takes about 22 hours to fill — so a disk-backed log buffers at least ~22 hours of messages even at maximum rate. Real deployments use a fraction of write bandwidth, so retention is usually days to weeks.
**Demonstrates:** why log-based brokers can treat "buffering" as a large bounded circular buffer, leaving humans time to fix lagging consumers.

## Safely attaching a debug consumer to production
With a log-based broker, a consumer that crashes, lags, or is shut down leaves behind only its offset and consumes nothing. So you can experimentally consume a production topic for development or debugging without endangering production consumers. With AMQP-style brokers, by contrast, an abandoned queue keeps accumulating messages and steals memory from active consumers.
**Demonstrates:** the operational advantage of read-only, offset-based consumption.

## Reprocessing yesterday with a different offset
Because the consumer controls its own offset, you can start a copy of a consumer at yesterday's offset, write its output elsewhere, and reprocess a day's messages — repeatedly, with varying code.
**Demonstrates:** log replay restores the batch-processing virtues of repeatability and safe experimentation.

## The dual-write race condition (X = A vs X = B)
Two clients update item X: client 1 writes A, client 2 writes B, each writing first to the database and then to the search index. The requests interleave: the database applies A then B (final value B), the index applies B then A (final value A). No error occurred, nothing detected the conflict, and the two systems disagree permanently. A second dual-write hazard: one write succeeds and the other fails. With CDC instead, the database alone decides the write order, the changelog records it, and the search index applies the same order — agreement guaranteed.
**Demonstrates:** why dual writes are broken and CDC (single leader, ordered changelog) fixes them.

## Cat video play counts (log compaction)
A log of key-value pairs records play counts for cat videos keyed by video ID. Compaction discards all but the latest value per key and merges shrunken segments. The compacted log's size depends on the number of distinct keys, not on how many updates ever happened, and still contains the latest value of every key — so a new consumer scanning from offset 0 gets a full database copy with no snapshot.
**Demonstrates:** log compaction turns a changelog into durable full-database storage.

## Cassandra's quorum-write CDC
In a quorum-based store there is no single leader log to subscribe to; whether a write is "visible" depends on the reader's consistency level. Cassandra sidesteps this by exposing each node's raw log segments; CDC consumers must merge the per-node logs themselves, like a quorum reader would.
**Demonstrates:** CDC presumes a single source of truth; leaderless databases must push the merge problem onto consumers.

## The outbox pattern
In microservices, CDC on internal tables turns your private schema into a public API — dropping a column can break downstream production consumers and cause a customer-facing outage. The outbox pattern writes events to a dedicated outbox table with a stable schema, in the same transaction as the domain write, and exposes only the outbox to CDC. It looks like a dual write, but both writes share one database transaction, so the dual-write hazards don't apply. Costs: maintaining the internal-to-outbox transformation and extra database write volume.
**Demonstrates:** decoupling internal schemas from CDC consumers while keeping atomicity.

## The accountant's ledger
Accountants record transactions in an append-only ledger; accounts like the balance sheet are derived by summing it. Mistakes are never erased — a compensating transaction is added, and the wrong entry stays for auditing. If wrong figures were already published, the next period includes a correction.
**Demonstrates:** centuries-old precedent for immutable event logs with derived state and compensating corrections.

## The abandoned shopping cart
A customer adds an item to their cart, then removes it. For order fulfillment the two events cancel out, but for analytics the fact that the customer considered the item is valuable — maybe they'll buy later or found a substitute. An event log retains this; a state-only database that deletes the row loses it.
**Demonstrates:** immutable events capture information that current state destroys.

## Recovering from a buggy deploy
If deployed code with a bug destructively overwrites database rows, recovery is hard. If writes are appended to an immutable event log, you can diagnose what happened and recover much more easily; customer service can likewise use the audit log to investigate complaints.
**Demonstrates:** immutability as an operational safety net, not just an architectural nicety.

## Side-by-side view migration
Deriving several read-oriented views from one event log works like having multiple consumers of a stream — Druid ingests directly from Kafka this way, and Kafka Connect sinks export from Kafka to databases and indexes. The same capability enables migration: to present existing data in a new way, build a new read-optimized view from the event log and run it alongside the old one. Migrate readers gradually, then shut the old view down.
**Demonstrates:** deriving multiple views from one log makes schema evolution a deploy-and-switch operation rather than an in-place migration.

## GDPR deletion, excision, and crypto-shredding
Privacy law can require truly deleting a user's data — appending a "consider it deleted" event is not enough; history must be rewritten (Datomic calls this excision; the Fossil version control system calls it shunning). Genuine deletion is hard: SSDs and filesystems write new copies rather than overwriting, and backups are deliberately immutable. Crypto-shredding stores data encrypted and "deletes" by destroying the key — but key granularity must be decided up front, and per-item keys make the key store as large as the data.
**Demonstrates:** the limits of immutability and why deletion is really "making data harder to retrieve."

## Classic monitoring uses of streams
Fraud detection (block a stolen credit card when usage patterns shift), algorithmic trading (act on price changes), manufacturing (detect machine malfunctions fast), and military/intelligence early-warning systems.
**Demonstrates:** the original motivating applications for continuous, pattern-matching stream processing (CEP).

## Media monitoring and real-estate alerts (search on streams)
A media monitoring service registers search queries in advance and matches every incoming news item against them, alerting on mentions of tracked companies or topics. Real-estate sites similarly notify users when a new listing matches their saved search. Elasticsearch's percolator implements this; with many queries, you index the queries themselves to narrow the candidates per document.
**Demonstrates:** stream search inverts the search engine — queries are stored, documents are transient.

## The Star Wars release order
Episodes IV, V, VI were released 1977–1983; I, II, III in 1999–2005; VII, VIII, IX in 2015–2019. Watching in release order means processing the story out of narrative order: episode number is the event timestamp, viewing date is the processing time.
**Demonstrates:** event time and processing time are independent orderings, and processors must handle the mismatch.

## The fake request-rate spike after a redeploy
A stream processor counts requests per second. It is redeployed, stays down for a minute, then races through the backlog. Measured by processing time, this looks like a sudden traffic spike; the real request rate was steady all along.
**Demonstrates:** windowing by processing time creates artifacts whenever processing rate varies; window by event time.

## When is the 37th minute over? (stragglers)
Counting requests per minute by event time, you have events for minute 37, and arrivals are now mostly in minutes 38–39. When do you close minute 37's window? Events may still be buffered on a machine behind a network interruption. Options: drop stragglers (tracking the drop rate as a metric) or publish a correction and possibly retract the earlier output. A producer can emit watermarks ("no more events before t"), but with many producers the consumer must track each one's watermark, and adding/removing producers gets tricky.
**Demonstrates:** event-time windows can never be definitively complete; straggler policy is a design decision.

## The mobile app with an offline clock
A mobile app reports usage events, buffering them locally while offline — possibly for days — so they arrive as extreme stragglers. The meaningful timestamp is the device's, but device clocks can't be trusted. Fix: record three timestamps — event time (device clock), send time (device clock), receive time (server clock). Receive minus send estimates the device clock's offset; applying that offset to the event time estimates the true event time. The correction assumes network delay is negligible compared to the accuracy required, and that the device's clock offset stayed the same between the event and its send.
**Demonstrates:** a practical technique for correcting untrusted client clocks.

## Two web servers, swapped event order
A user makes request 1 (handled by server A) then request 2 (handled by server B). B's event reaches the broker before A's, so consumers see them in reverse order of occurrence.
**Demonstrates:** even without failures, network delays reorder events from different producers.

## Search click-through rate (stream–stream join)
To measure search quality you join search events with click events sharing a session ID; advertising systems need the same kind of join. The click may come seconds, days, or weeks later — or never — and due to network delays may even arrive before the search event. Choose a join window (say one hour), keep both streams' recent events indexed by session ID, emit a joined event on match and a "no click" event on expiry. Embedding search details inside the click event is not equivalent: it misses the searches that got no click, which the click-through rate needs.
**Demonstrates:** stream–stream joins need windowed state on both sides and explicit handling of absent matches.

## Enriching activity events with user profiles (stream–table join)
An activity event stream carries user IDs; the output is the same events enriched with profile data. Querying the profile database per event is slow and can overload it, so the processor keeps a local copy (in-memory hash table or local index) and subscribes to the profile database's CDC stream to keep it current. Unlike a batch job's point-in-time snapshot, the long-running processor's table changes over time — the table side is a join with an infinite window where new versions overwrite old.
**Demonstrates:** stream enrichment via local state maintained by CDC.

## Home timelines as a table–table join
A social network's per-user timeline cache is maintained by events: a new post is inserted into every follower's timeline; deletions remove it; a new follow backfills recent posts; an unfollow removes them. The processor keeps a follower-set table to know which timelines to touch. The whole thing materializes the join `posts JOIN follows GROUP BY follower`, updated on every change to either table — and the change stream of a join follows the calculus product rule, (u·v)′ = u′v + uv′.
**Demonstrates:** a denormalized cache is a continuously maintained materialized join view.

## Tax rates and slowly changing dimensions
Invoices must use the tax rate in force at the time of sale, which differs from the current rate when reprocessing history. If event ordering across the sales stream and the tax-rate changelog is undetermined, the join is nondeterministic across reruns. Data warehouses solve this with slowly changing dimensions: each tax-rate change gets a new version ID and the invoice references it — deterministic, but it forbids log compaction since all versions must be kept. The alternative is to denormalize the rate into each sale event.
**Demonstrates:** time-dependent joins force a choice between determinism and compaction.

## PostgreSQL's REFRESH MATERIALIZED VIEW vs IVM
Databases typically refresh materialized views by rerunning the whole query on a schedule or on demand: all data is reprocessed even though most is unchanged, and the view is stale between refreshes. Triggers can update easily-partitioned views (e.g., per-day sales totals) incrementally, but most SQL doesn't convert easily. Incremental view maintenance systems (Materialize, RisingWave, ClickHouse, Feldera) compile queries into incremental operators that recompute only what changed, buffering recent events in memory and merging them with on-disk views at read time.
**Demonstrates:** why stream-based incremental computation beats periodic full recomputation for view freshness and cost.

## Storm's distributed RPC
Apache Storm lets user queries be farmed out to the same nodes that process event streams; queries interleave with stream events and results are aggregated back to the caller.
**Demonstrates:** the crossover point between stream processing and RPC-style request/response systems.

## Microbatching in Spark Streaming
Spark Streaming chops the stream into batches of roughly one second and runs each as a miniature batch job. The size is a compromise: smaller batches add scheduling overhead, larger ones add output latency. Each microbatch also acts as an implicit processing-time tumbling window; larger windows require explicitly carrying state across batches. Flink's variant uses barrier-triggered rolling checkpoints instead, avoiding a forced window size. Both give exactly-once semantics inside the framework — but neither can retract output that already left it (a database write, an email), which a retry would then duplicate.
**Demonstrates:** fault-tolerance via discardable units of work, and its boundary at external side effects.

## Storing the Kafka offset with the database write
When a processor writes values to an external database, it includes the offset of the triggering message with each value. On retry after a failure, it can see that an update for that offset was already applied and skip it. Storm's Trident state handling uses the same idea. This works only if replay delivers the same messages in the same order (log-based brokers do), processing is deterministic, no other node writes the same value concurrently, and failover uses fencing against zombie nodes.
**Demonstrates:** idempotence with a little metadata as a cheap route to effectively-once output.

## Three ways to rebuild processor state
Flink periodically snapshots operator state to a distributed filesystem. Kafka Streams replicates state changes to a dedicated log-compacted Kafka topic, CDC-style. VoltDB instead processes every input message redundantly on several nodes. Sometimes replication is unnecessary: a short window's aggregates can be rebuilt by replaying that window's input, and a CDC-maintained table can be rebuilt from its compacted changelog. Which is best depends on infrastructure — network latency may beat disk latency, and the trade-off shifts as hardware evolves.
**Demonstrates:** the design space for recovering stateful stream operators after failure.
