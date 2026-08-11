# Chapter 13: A Philosophy of Streaming Systems — Learnings

## Central thesis

No single tool serves all access patterns, so real applications must compose several specialized data systems. The most robust way to compose them is not distributed transactions but asynchronous, log-based dataflow: designate systems of record, derive everything else from an ordered event log via deterministic, idempotent transformations. Correctness then comes from end-to-end mechanisms (request IDs, idempotence, asynchronous constraint checking, auditing) rather than from synchronous coordination.

Why no single tool suffices: every piece of software — even a so-called "general-purpose" database — is designed for a particular usage pattern. It's hard enough to get one code path robust and performing well; trying to satisfy too many use cases with many features tends to produce poor implementations of those features compared to specialized tools. And vendors are understandably reluctant to say which workloads their software handles badly, so you must read between the lines.

This chapter is deliberately opinionated: it develops one philosophy rather than surveying alternatives.

## Data Integration

### Deriving data instead of dual writes

- When the same data lives in multiple systems (OLTP database, search index, cache, warehouse, ML features, notification systems), be explicit about which system is the source of truth and which representations are derived from it.
- **Dual writes are the failure mode:** if the application writes directly to both the database and the search index, two concurrent clients can have their writes applied in different orders in the two systems, leaving them permanently inconsistent. Neither system is "in charge" of ordering.
- **The fix:** funnel all writes through one system that decides a total order (a system-of-record database plus CDC, or an event-sourcing log). Derived systems apply the changes in that same order. This is state machine replication applied to heterogeneous systems. Whether you use CDC or event sourcing matters less than the principle of deciding a total order.
- Derivation from a log can be made deterministic and idempotent, which makes fault recovery easy: replay.

### Derived data vs. distributed transactions

- Both aim to keep systems mutually consistent. Transactions use atomic commit; log-based systems use deterministic retry + idempotence.
- **Key difference:** transaction systems usually guarantee you can immediately read a value after writing it (read your own writes). Derived systems are often updated asynchronously, so reads may be stale by default.
- Distributed transactions have been used successfully in environments willing to absorb their performance and operational costs, but XA/heterogeneous distributed transactions have poor fault tolerance and performance, and a better widely adopted protocol is unlikely soon. In its absence, **log-based derived data is the most promising integration approach.**
- Don't just tell users "eventual consistency, deal with it" — the chapter later builds stronger guarantees on top of asynchronous systems (waiting for output events, end-to-end IDs).

### Limits of total ordering

A totally ordered event log requires all events through one leader node. Total order breaks down when:
- Throughput exceeds a single machine → log must be sharded → order across shards is undefined.
- Multiple geographic regions each have their own leader (synchronous cross-region coordination is too slow) → no order across regions.
- Microservices keep separate durable state per service → events from different services have no defined order.
- Offline-capable clients apply updates locally before the server sees them → clients and server see different orders.

Formally, total ordering is total order broadcast, which is equivalent to consensus. Most consensus algorithms assume a single node can handle the full event throughput; there is no good mechanism for multiple nodes to share ordering work.

### Capturing causality without total order

Concurrent (causally unrelated) events can be ordered arbitrarily — that's fine. Updates to the same object can be ordered by routing them to the same log shard by object ID. The hard case is subtle cross-object causality (e.g., unfriend-then-rude-message). No complete solution exists; partial approaches:
- Logical timestamps: ordering without coordination, but consumers must handle out-of-order delivery and carry extra metadata.
- Log an event recording what state the user saw before acting, give it a unique ID, and have later events reference that ID to record the causal dependency.
- Conflict resolution algorithms (CRDT-style): fine for converging state, useless for external side effects like sending a notification.

### Batch and stream processing for derived state

- Batch and stream processing share principles; the fundamental difference is bounded vs. unbounded input.
- Both favor deterministic, pure functions: immutable inputs, append-only outputs, no side effects. Stream processing adds managed, fault-tolerant state. Determinism isn't only for fault tolerance — it also simplifies reasoning about the dataflows across a whole organization (pipelines that derive one thing from another).
- **Asynchrony is the robustness feature:** synchronous maintenance (like a distributed transaction) amplifies failures — if one participant fails, the transaction aborts and the failure spreads. An async log contains the fault: a slow/failed consumer buffers in the log and catches up later; producers and other consumers are unaffected.
- Cross-shard secondary index maintenance is also most reliable and scalable when asynchronous.

### Reprocessing for evolution

- Stream processing keeps derived views fresh with low latency; batch reprocessing lets you rebuild views from all historical data.
- Without reprocessing, schema evolution is limited to trivial changes (add an optional field). With it, you can restructure into a completely different model.
- **Gradual migration pattern:** maintain old and new schemas side by side as two independently derived views over the same data. Shift a small fraction of users to the new view, ramp up, eventually drop the old view. Every stage is reversible — reducing the risk of irreversible damage lets you move faster.

### Unifying batch and stream (kappa over lambda)

The lambda architecture (parallel batch and streaming layers) had problems and has fallen out of use. The kappa approach runs batch (historical replay) and stream (live) computations in the same system. Required features:
1. Replay of historical events through the same engine (log brokers replay; some stream processors read from object storage/distributed filesystems).
2. Exactly-once semantics: output identical to a fault-free run; discard partial outputs of failed tasks.
3. Windowing by event time, not processing time (processing time is meaningless during replay). E.g., Apache Beam API, executed on Flink or Google Cloud Dataflow.

## Unbundling Databases

### The meta-database view

- Databases, batch/stream processors, and operating systems are all information management systems. Unix exposes low-level abstractions (files, pipes); relational databases give high-level abstractions (SQL, transactions). NoSQL can be read as applying Unix-style low-level thinking to distributed OLTP.
- Each philosophy is "simpler" in its own sense: Unix is a fairly thin wrapper around hardware resources; a relational database lets a short declarative query draw on powerful infrastructure (query optimization, indexes, join methods, concurrency control, replication) without the query author understanding the implementation. Both emerged in the early 1970s, and the tension still isn't resolved. Practical difference too: many filesystems cope badly with a directory of 10 million small files, while a database with 10 million small records is completely unremarkable.
- `CREATE INDEX` is the model: snapshot the table, derive the index, process the backlog of writes since the snapshot, then keep it updated. This is the same procedure as setting up a new replica or bootstrapping CDC. Every ETL/batch/stream pipeline in an organization is doing what a database's index-maintenance subsystem does — the org's whole dataflow is one big unbundled database.

### Two ways to compose tools

- **Federated databases (unifying reads):** one query interface over many storage engines (PostgreSQL foreign data wrappers; Trino, Hoptimator, Xorq). Relational tradition: high-level language, elegant semantics, complicated implementation. Mapping data models for read-only queries is manageable.
- **Unbundled databases (unifying writes):** the harder problem — ensuring every data change reaches all the right places despite faults. Unix tradition: small tools, uniform low-level API (the event log as the pipe), composed by higher-level glue.
- Transactions *within* a single storage or stream-processing system are feasible — some stream processors use distributed transactions internally for exactly-once, and that works well. The problem is data crossing technology boundaries: heterogeneous distributed transactions across systems written by different teams have no standardized protocol. **An ordered event log with idempotent consumers is a simpler, more feasible abstraction across heterogeneous systems.**

### Why log-based integration wins: loose coupling

- System level: the log buffers when a consumer is slow or down; faults stay contained instead of escalating (distributed transactions escalate local faults into large-scale failures).
- Human level: teams develop and operate their systems independently, interfacing through the log. The log is strong enough (durable, ordered) to carry real consistency properties, yet generic enough for any data.

### When NOT to unbundle

- If one technology satisfies all your needs, use it. Unbundling pays off only when no single product covers your requirements. **It's about breadth of workloads, not depth of performance** — an integrated product may achieve better and more predictable performance than a composed system on the workloads it was designed for.
- Every extra moving part has a learning curve, configuration issues, and operational quirks. Building for scale you don't need is premature optimization and can lock in an inflexible design.
- Databases aren't going away: stream processors still need state stores, and outputs still need query-serving systems; data warehouses still excel at exploratory analytics.
- Composition tooling is improving: Debezium (CDC from many databases), the Kafka protocol as a de facto event-stream standard, incremental view maintenance engines.

### Designing applications around dataflow

- Goal: spreadsheet semantics at data-system scale — change an input, and every dependent index/cache/aggregation updates automatically ("most data systems still have something to learn from VisiCalc, 1979"). Unlike spreadsheets, data systems must also be fault-tolerant, scalable, durable, and built from heterogeneous parts by different teams.
- **Application code as a derivation function:** secondary indexes have a cookie-cutter derivation built into databases; full-text search, ML models, and UI caches need custom application code — exactly where databases (triggers, stored procedures, UDFs) are weak.
- Why those derivations resist standardization: full-text indexing is an NLP pipeline (language detection, word segmentation, stemming/lemmatization, spelling correction, synonyms) feeding an inverted index, and sophisticated versions need domain-specific tuning; ML feature engineering is notoriously application-specific; a UI cache's derivation depends on which fields the UI displays, so a UI change can force redefining and rebuilding the cache. An ML model is itself derived data — from the training data via feature extraction and statistical analysis.
- **Keep application code out of the database and persistent state out of the application** ("separation of Church and state"). Databases are poor application runtimes: no dependency management, version control, rolling upgrades, monitoring, or service calls. Kubernetes/Docker etc. do that job well; databases do state.
- The standard model treats the database as a mutable shared variable you can only poll — you can't subscribe. (Hand-rolled change notification is the observer pattern, but few languages build it in; databases inherited the same passive stance, and subscribing to changes is only just emerging as a feature.) Dataflow renegotiates this: code responds to state changes by producing state changes elsewhere (as in CDC, the actor model, triggers, incremental view maintenance).
- Requirements that log-based brokers meet: **stable ordering** (multiple views derived from one log stay mutually consistent only if they process events in the same order) and **fault-tolerant processing** (one lost message permanently desyncs a derived view). Stringent, but far cheaper and more robust than distributed transactions.

### Dataflow vs. microservices

- Both decompose functionality for organizational scalability; the difference is one-directional async message streams vs. synchronous request/response.
- **Subscribe-ahead pattern:** instead of calling another service at request time (e.g., querying an exchange-rate service), subscribe to its change stream in advance and keep a local replica; query locally at request time. Faster (no network hop — "the fastest and most reliable network request is no network request at all") and robust to the other service being down. The RPC becomes a stream join — which makes the time dependence of the join explicit (reprocessing needs the historical rate, not the current one).

### Write path and read path

- **Write path:** precomputed, eager work done when data arrives, regardless of whether anyone reads it. **Read path:** lazy work done at query time. The derived dataset (index, cache, materialized view) is where they meet.
- Indexes, caches, and materialized views all just **shift the boundary** between write-time and read-time work: no index = cheap writes, expensive reads (grep everything); precomputing all possible query results = impossibly expensive writes; caching common queries = a middle point. The celebrity/fan-out timeline problem from Chapter 2 is the same boundary choice, drawn differently per user class.

### Extending the write path to clients

- Treat on-device state as a cache of server state: model objects are a local replica; pixels on screen are a materialized view of the model.
- Server-sent events (EventSource) and WebSockets let servers push state changes to clients, extending the write path to the end-user device. Initial load still uses the read path; afterwards the client consumes a change stream. (HTTP-based feed protocols like RSS are really just a basic form of polling, not push.)
- Offline devices are just disconnected log consumers: the consumer-offset mechanism (reconnect and resume from your last offset, missing nothing) works for end-user devices too — each device is a small subscriber to a small stream.
- Client UI tools like React and Elm already re-render in response to local state changes; the natural extension is letting the server push state-change events into that same client-side event pipeline.
- End-to-end event streams (device → log → processors → another device's UI) can propagate changes in under a second; instant messaging and online games already work this way ("real-time" in the sense of low delay, not response-time guarantees). The blocker is that request/response and stateless-client assumptions are baked into databases, libraries, frameworks, and protocols; few datastores support subscribe. Moving to publish/subscribe dataflow would mean more responsive UIs and better offline support.

### Reads are events too

- Stream processors already hold state for aggregations and joins; some frameworks expose that state to outside queries (e.g., interactive queries in Apache Kafka's stream processing), turning the processor itself into a kind of simple database.
- Serving a query is fundamentally a join. You can represent read requests as events routed through the stream processor to the relevant shard; one-off reads are transient joins, subscriptions are persistent joins with past and future events.
- Benefits: causal tracking and provenance (reconstruct what the user saw before deciding); enables distributed multishard query execution using the stream processor's existing routing/sharding/joining machinery (Storm distributed RPC). Cost: extra storage and I/O for logging reads — still an open research problem.
- For multishard joins, a database that supports them is usually simpler (data warehouse query engines' internal execution graphs look much like these stream-join topologies); streams are an option when you outgrow off-the-shelf solutions.

## Aiming for Correctness

### Why transactions aren't enough

- Stateful systems remember forever, so mistakes potentially last forever.
- Four decades of ACID still leave confusion (weak isolation levels), products whose claimed guarantees fail under faults (Jepsen findings), and applications that misuse the features (hard-to-understand configuration leads to subtle bugs that appear only under concurrency and faults).
- In some areas transactions have been abandoned entirely for models with better performance and scalability but messier semantics; "embrace weak consistency" is often asserted without any clear idea of what it means in practice. It is genuinely hard to determine whether a given application is safe at a given isolation level or replication configuration — simple solutions appear correct at low concurrency without faults, then reveal subtle bugs under demanding conditions.
- Serializability and atomic commit work but typically confine you to a single datacenter and limit scale and fault tolerance.
- Immutable, append-only data helps recovery from application bugs (faulty code can't destroy good data) but is not a cure-all.

### Exactly-once and the end-to-end argument

- Exactly-once = arrange the computation so the final effect is as if no fault occurred even though processing was retried. The main tool is **idempotence**, which for non-naturally-idempotent operations needs metadata (e.g., set of operation IDs applied) and fencing on failover.
- **Duplicate suppression at any one layer is insufficient.** TCP deduplicates within one connection; a transaction tied to that connection can still be retried as a new transaction after a timeout (Example 13-1: a non-idempotent transfer can move $22 instead of $11). 2PC breaks the connection-transaction tie but still can't stop the end user's browser from re-POSTing after a timeout — that retry is a fresh request and a fresh transaction to every lower layer.
- **The fix is end to end:** the client generates a unique request ID (UUID or hash of the form fields), and that ID flows all the way to the database, where a uniqueness constraint on `request_id` rejects duplicates (Example 13-2). Uniqueness constraints hold even at weak isolation levels, unlike application-level check-then-insert (write skew). The requests table doubles as an event log; the balance updates can be derived downstream from the request event.
- **End-to-end argument (Saltzer, Reed, Clark 1984):** a function (duplicate suppression, integrity checking, encryption) can be implemented completely and correctly only with knowledge of the application at the endpoints; lower-layer versions (TCP dedup, Ethernet/TCP/TLS checksums, WiFi encryption) are useful performance/probability optimizations but never sufficient by themselves.
- Consequence: even serializable transactions don't make an application correct — the application must add its own end-to-end measures. We still lack a good reusable abstraction that wraps high-level fault tolerance the way TCP wraps packet loss; transactions were that abstraction — they collapse a wide range of problems (concurrent writes, constraint violations, crashes, network interruptions, disk failures) into just two outcomes, commit or abort, a huge simplification of the programming model — but they're not enough by themselves, they're too expensive across heterogeneous systems, and hand-rolled application mechanisms usually have bugs (the result is lost or corrupted data). Worth seeking: fault-tolerance abstractions that give application-specific end-to-end correctness while keeping good performance and operations at scale.

### Enforcing constraints without distributed transactions

- Uniqueness constraints (unique username/email, no duplicate filenames, one person per seat) are the archetype; the same techniques often handle similar constraints — non-negative account balances, not overselling stock, no overlapping meeting-room bookings.
- **Uniqueness requires consensus.** With concurrent claims on the same value, something must pick a winner. Single-leader = single decision point — fine as long as you accept funneling every request through one node (even for a client on the other side of the world) and that node not failing; consensus algorithms like Raft handle safe leader failover and prevent split brain. Scale out by sharding on the constrained value (hash of username, request ID). Async multi-leader is ruled out — leaders could accept conflicting writes. Immediate rejection of violating writes requires synchronous coordination; there's no way around it.
- **Log-based uniqueness:** route all claims for a value to the same log shard; a single-threaded stream processor reads them in order, keeps local state of taken values, and emits success/reject events to an output stream the client watches. Same construction as consensus-via-shared-log; scales linearly with shards. The general principle: **route potentially conflicting writes to the same shard and process them sequentially**; the processor can apply arbitrary validation logic.
- **Multishard operations without atomic commit (Figure 13-2 payment flow):** client appends a transfer request (with unique request ID) to the source-account shard. A deterministic processor checks funds, reserves the amount, and emits events (carrying the request ID) to the source, destination, and fees shards. Downstream processors apply incoming payments, deduplicating by request ID. Requirements: per-shard ordered processing, at-least-once delivery, deterministic processors. Crash safety: after recovery the processor reprocesses, makes the same decision, emits the same events; duplicates are dropped by ID. **Atomicity derives from the single atomic append of the initial request event** — everything downstream eventually follows. Exactly-once stream semantics simplify this further (state rolls back together with reprocessed messages). The client can subscribe to the output to learn whether the transfer was approved or declined.

### Timeliness vs. integrity

"Consistency" conflates two separable requirements:
- **Timeliness:** users see an up-to-date state. Violations are temporary — wait and retry. Linearizability is strong timeliness (it's what the CAP theorem means by "consistency"); read-after-write is a weaker useful form. The transactional property that a commit's writes are immediately visible to others is formalized as strict serializability — exactly what multi-stage asynchronous stream processing gives up.
- **Integrity:** no corruption — no loss, no contradictory data; derived data correctly reflects its source. Violations are **permanent** until explicitly checked and repaired.

Slogan: violations of timeliness are "eventual consistency"; violations of integrity are "perpetual inconsistency." **In most applications integrity matters far more than timeliness** (a credit card transaction taking 24h to appear is normal; a statement that doesn't add up is catastrophic).

- ACID gives both at once, so the distinction is invisible there. (ACID "consistency" usually means application-specific integrity; atomicity and durability are tools for preserving it.) Dataflow systems **decouple** them: asynchronous processing sacrifices timeliness by default. A client can wait for the corresponding output event (e.g., payment executed/declined) to restore timeliness for itself, but correctness of the processing never depends on whether anyone waits — notification is decoupled from effect. Integrity is central and preserved via: (1) the write as one atomically appendable message (event sourcing), (2) deterministic derivation of all other state (like stored procedures), (3) end-to-end request IDs for idempotence, (4) immutable messages allowing reprocessing after bugs.

### Loosely interpreted constraints and apologies

Many "hard" constraints are actually negotiable in the business domain:
- Oversold warehouse stock → backorder, apologize, discount. (You need this workflow anyway — a forklift can destroy stock you thought you had.)
- Airlines and hotels deliberately overbook; compensation processes (refunds, upgrades) already exist because cancellations and weather happen regardless.
- Overdrafts → fee and repayment demand; bound the bank's risk with daily withdrawal limits.
- Cross-organization data (interbank settlement) inevitably has inconsistencies; correction mechanisms are mandatory.

The fix-up is a **compensating transaction**. Apology cost is often low (refund a double charge, send a correcting email — you can't unsend the original, but a follow-up correction works; cash already dispensed by an ATM can't be directly clawed back, though debt collectors remain a last resort). If the business accepts the apology cost, you can **write optimistically and validate after the fact** — validate before actions that are expensive to reverse, but not necessarily before recording the data. Fixing up after the fact is akin to the conflict-resolution approaches for concurrent writes (Chapter 6). These apps still require integrity (no lost reservations, no vanished money), just not timely constraint enforcement.

### Coordination-avoiding data systems

Two observations combine:
1. Dataflow systems maintain integrity without atomic commit, linearizability, or synchronous cross-shard coordination.
2. Many applications tolerate loose constraints fixed up later, as long as integrity holds.

Therefore many applications can run **coordination-free with strong integrity**: e.g., multi-leader across regions, async replication, each datacenter independently operational. Not linearizable — weak timeliness — but strong integrity. Use serializable transactions at small scope where they work well; add synchronous coordination only where strictly needed (before unrecoverable actions); don't make everything pay for what only a small part needs. Framing: coordination reduces apologies for inconsistencies but increases apologies for outages and slowness — tune for the sweet spot; the number of apologies never reaches zero.

### Trust, but verify (auditing)

- A system model declares what faults can/can't happen, but reality is probabilistic: memory, disk, and network corruption all occur, and at scale, rare events happen. Software has bugs too — even MySQL has violated uniqueness constraints and PostgreSQL's serializable isolation has exhibited write skew; application code is far buggier and often doesn't even use the database's integrity features (feral concurrency control).
- ACID "consistency" presumes bug-free transactions; if the app misuses weak isolation, the database cannot guarantee integrity.
- **Auditing = checking data integrity.** Not just for finance — auditability matters there precisely because everyone accepts that mistakes happen and must be detectable and fixable. Mature systems assume failure: HDFS and S3 don't trust disks — background processes continually re-read files, compare replicas, and rebalance to mitigate silent corruption. Same principle: actually restore your backups periodically; data you never read back is data you only hope exists.
- **Event sourcing improves auditability:** user input is one immutable event; derived updates are deterministic and repeatable. Check the event log with hashes; check derived state by re-deriving it (or running a redundant parallel derivation). Explicit dataflow gives provenance and time-travel debugging. By contrast, a mutated-tables transaction log doesn't tell you *why* mutations happened — the application logic invocation is transient.
- The end-to-end argument applies to integrity checking: the more of the pipeline a single check covers, the fewer places corruption can hide. Continuous end-to-end checks are like automated tests — they let you change systems confidently and move faster.
- Tools: audit tables are weak (signing the log doesn't prove the right transactions entered it). Blockchains are Byzantine-fault-tolerant shared logs with cryptographic checks (smart contracts ≈ stream processors) — too much overhead for most apps, but their primitives travel: **Merkle trees** efficiently prove a record is in a dataset; **certificate transparency** uses verified append-only logs + Merkle trees with a single leader per log (no consensus protocol needed). Expect more self-validating/self-auditing systems.

## Rules of thumb worth remembering

- Decide a total order of writes in ONE place; derive everything else from it.
- Asynchrony contains faults; synchronous coordination spreads them.
- Keep old and new derived views side by side during migrations; every step must be reversible.
- Unbundle only when no single product meets your needs — breadth, not depth.
- Caches/indexes/views = movable boundary between write-path and read-path work.
- A request ID generated at the true endpoint (the user's client) and enforced by a uniqueness constraint is the cheapest reliable exactly-once mechanism.
- Route conflicting writes to one shard; process sequentially and deterministically with at-least-once delivery + dedup by ID.
- Integrity > timeliness. Never trade integrity; trade timeliness freely when the business can apologize.
- If you don't read your data back and check it (backups included), assume it's corrupt.
- End-to-end propagation latency for full dataflow UIs: roughly under one second is achievable.

## How this connects

- Builds directly on **Chapter 12** (streams): CDC, event sourcing, log-based brokers, consumer offsets, exactly-once/idempotence, time-dependent joins, keeping systems in sync.
- Uses **Chapter 11** (batch): deterministic pure functions, reprocessing, Unix philosophy of composable tools.
- **Chapter 2**: reliability/scalability/maintainability goals; the social-network timeline case study reappears as the write-path/read-path boundary.
- **Chapter 4** (storage engines) and **Chapter 6** (replication): index creation ≈ new-follower setup; multi-leader conflicts; replication lag/read-your-writes.
- **Chapter 8** (transactions): weak isolation, write skew, serializability — what transactions do and don't guarantee.
- **Chapter 9** (distributed systems faults): in-doubt commits, system models, fencing.
- **Chapter 10** (consistency/consensus): total order broadcast ≡ consensus; uniqueness needs consensus; consensus-via-shared-log construction; linearizability vs. serializability.
- 2PC/XA limitations from "Distributed Transactions Across Different Systems" motivate the whole log-based alternative.
