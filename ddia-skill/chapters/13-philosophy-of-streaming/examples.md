# Chapter 13: A Philosophy of Streaming Systems — Examples

## Database + search index integration

A common need: an OLTP database must support arbitrary keyword queries. PostgreSQL's built-in full-text indexing can be enough for simple cases, but sophisticated search needs a specialist information-retrieval tool — and search indexes are poor as a durable system of record. So the application must combine two tools. As more representations pile on (warehouse copies, caches, machine learning/classification/ranking/recommendation systems, notification systems), the integration problem compounds.

Demonstrates: no single tool fits all access patterns; composition of specialized systems is inevitable.

## Dual writes vs. CDC funnel

If the application writes to both the database and the search index directly, two clients sending concurrent conflicting writes may be applied in different orders by the two stores — neither is in charge of ordering, so they diverge permanently. Instead, write only to the system-of-record database and apply its change stream (CDC) to the index in the same order. The index is then entirely derived from the database and consistent with it (barring bugs).

Demonstrates: funnel all writes through one ordering point; derive other representations from that order.

## Unfriend, then complain (lost causality)

On a social network, a user unfriends their ex-partner and then sends a message to remaining friends complaining about the ex. The intent: the ex must not see it. But friendship status and messages live in different systems, and the notification service is effectively a join between messages and the friend list. If it processes the message-send event before the unfriend event, the ex gets notified. The causal dependency between events in different systems was lost. The chapter notes no simple fix exists; candidates include logical timestamps, logging an event that records the state the user saw (and referencing its ID from later events), and conflict resolution algorithms (which help state but not external side effects like notifications).

Demonstrates: without total order, subtle cross-system causal dependencies can be violated; this remains an open problem.

## Railway gauge conversion (schema migration sidebar)

19th-century English railways used competing track gauges; trains built for one gauge couldn't run on another. After standardization in 1846, tracks were converted without long shutdowns by adding a third rail (dual/mixed gauge), letting both old and new trains run during a years-long gradual transition; the nonstandard rail was removed at the end. The conversion was expensive, which is why nonstandard gauges survive (e.g., BART in the San Francisco Bay Area).

Demonstrates: large migrations are done gradually by running old and new versions side by side — the model for derived-view schema migrations.

## Gradual migration via dual derived views

To restructure a dataset, don't flip a switch. Maintain the old and new schemas as two independently derived views over the same underlying data. Route a small share of users to the new view to find bugs and test performance, ramp up gradually, then drop the old view. Every stage is reversible, so a working system always exists to fall back to — and lowered risk lets you move faster.

Demonstrates: reprocessing plus derived views makes application evolution safe and incremental.

## CREATE INDEX as dataflow

When you run CREATE INDEX, the database scans a consistent snapshot of the table, sorts and writes the index, processes the backlog of writes made during the scan, then keeps the index updated on every transaction. This is essentially the same procedure as setting up a new follower replica and as bootstrapping CDC with an initial snapshot.

Demonstrates: index creation is reprocessing an existing dataset to derive a new view — databases already contain the unbundled-dataflow pattern internally.

## Currency conversion: RPC vs. stream subscription

A purchase priced in one currency is paid in another, so the checkout code needs the current exchange rate. Microservices approach: query an exchange-rate service at purchase time (a synchronous network call). Dataflow approach: subscribe ahead of time to a stream of rate updates, keep the current rate in a local database, and read locally at purchase time. The local read is faster and keeps working when the rate service is down — "the fastest and most reliable network request is no network request at all." (Caching the rate inside the microservice doesn't escape this: keeping that cache fresh means periodically polling or subscribing to a change stream — which is exactly the dataflow approach.) The RPC has become a stream join between purchase events and rate-update events, which exposes the time dependence: reprocessing old purchases needs the historical rate at the original purchase time, not today's rate.

Demonstrates: replacing request/response with subscribe-and-replicate improves latency and fault tolerance; framing the lookup as a stream join makes explicit a time dependence that exists in either approach (reprocessing needs historical rates).

## Search index: shifting the write/read boundary

With a full-text index, writes update index entries for every term in the document, and reads look up query words and apply Boolean logic. With no index, writes are free but every query scans all documents like grep — fine for tiny corpora, ruinous at scale. At the other extreme, precomputing results for every possible query is impossible (the query space is effectively infinite). A middle option: precompute results for the most common queries (a cache/materialized view that must be updated when new matching documents arrive), serving rare queries from the index.

Demonstrates: caches, indexes, and materialized views are points on a dial that shifts work between the write path and the read path.

## Celebrities and home timelines, revisited

The social-network home timeline case study from Chapter 2 is reinterpreted: fanning out posts to follower timelines at write time vs. assembling timelines at read time is exactly the write-path/read-path boundary, and the boundary is drawn differently for celebrities (read-time merge) than ordinary users (write-time fan-out).

Demonstrates: the write/read boundary can be chosen per data class, not just per system.

## Offline-capable clients as replicas

Browsers used to be stateless; now single-page apps and mobile apps hold persistent local state and work offline, syncing in the background. Think of on-device state as a cache of server state: model objects in the app are a local replica of datacenter state, and the pixels on screen are a materialized view of the model objects. With server push (server-sent events, WebSockets) the write path extends to the device; offline periods are handled the same way a log consumer resumes from its offset after disconnection, missing no messages — each device is a small subscriber to a small stream.

Demonstrates: stream/log concepts extend beyond the datacenter to end-user devices, enabling responsive and offline-capable UIs.

## Storm distributed RPC: who saw this URL?

Storm's distributed RPC feature has been used to compute how many people saw a URL on a social network — the union of the follower sets of everyone who posted it. The user set is sharded, so the computation must combine results from many shards, routed through the stream-processing infrastructure.

Demonstrates: representing queries as events enables distributed multishard query execution on stream-processor infrastructure.

## Fraud scoring across sharded reputation databases

To assess whether a purchase is fraudulent, a system checks reputation scores for the user's IP address, email address, billing address, and shipping address. Each reputation database is sharded differently, so scoring one purchase event requires a sequence of joins with differently sharded datasets. (The chapter notes a database with multishard join support is usually simpler, but the stream approach is an option past the limits of off-the-shelf systems.)

Demonstrates: multishard request processing as a series of stream joins.

## Online shop: reads affect decisions (provenance)

The predicted shipping date and inventory status shown to a shopper likely influence whether they buy. To analyze that connection, you must record what the user's query returned — i.e., treat read events as durable data. Logging reads costs storage and I/O, but if you already log requests operationally, making that log the source of truth for requests is a small change.

Demonstrates: recording reads as events enables causal tracking and data provenance.

## Example 13-1: the non-idempotent $11 transfer

A classic transaction moves $11 between accounts with two UPDATE statements inside BEGIN/COMMIT. TCP deduplicates packets within one connection, but if the connection drops after the client sends COMMIT and before it hears the result, the client doesn't know if the transaction committed (the in-doubt situation from Chapter 9). On reconnect and retry, the database sees a brand-new transaction — $22 may move instead of $11. 2PC doesn't fix this either, and even if client-server duplicates were suppressed, the end user's browser can re-submit a timed-out HTTP POST ("Are you sure you want to submit this form again?" — the user says yes; the Post/Redirect/Get pattern suppresses that warning in normal operation but doesn't help when the POST times out). To every lower layer, that retry is a fresh request. The textbook atomicity example "is not correct, and real banks do not work like this."

Demonstrates: duplicate suppression at any single layer (TCP, transactions, 2PC) cannot prevent end-to-end duplicates.

## Example 13-2: end-to-end request IDs

Fix: the client generates a unique request ID (a UUID hidden in the form, or a hash of the form fields). The transaction inserts the ID into a requests table with a UNIQUE constraint before applying the balance updates; a duplicate submission hits the constraint and aborts. Uniqueness constraints hold even at weak isolation levels, unlike application-level check-then-insert (vulnerable to write skew). Bonus: the requests table is itself an event log — the balance updates are redundant and could be derived downstream from the request event, again deduplicated by request ID.

Demonstrates: exactly-once execution requires an identifier carried end to end, from the user's client to the final datastore.

## End-to-end argument: checksums and encryption

Ethernet, TCP, and TLS checksums detect network corruption but not corruption from software bugs at either end or from disks — only end-to-end checksums catch everything. Similarly, WiFi passwords protect against local snooping, TLS against network attackers, but only end-to-end encryption protects against a compromised server. Low-level mechanisms remain valuable (HTTP would constantly break without TCP's ordering) but are never sufficient alone.

Demonstrates: the Saltzer/Reed/Clark end-to-end argument — correctness functions must be implemented at the application endpoints.

## Username uniqueness via a log

To guarantee unique usernames at scale: (1) each username claim is a message appended to a log shard chosen by hash of the username; (2) a single-threaded stream processor reads the shard in order, tracking taken names in a local database, and emits a success or rejection message per request; (3) the requesting client watches the output stream for its answer. Because all claims for the same name land in one shard and are processed sequentially, the winner is decided unambiguously and deterministically. This is the consensus-via-shared-log construction, and it scales by adding shards.

Demonstrates: log-based stream processing can enforce uniqueness (and similar constraints) — route conflicting writes to the same shard and process sequentially.

## Figure 13-2: multishard payment without atomic commit

A transfer involves three shards: request ID, payer account, payee account (plus a fees account). The traditional answer is an atomic commit across shards, which forces a total order over all transactions touching them and kills independent shard throughput. The dataflow alternative: (1) the client assigns a unique request ID and appends the request to the source-account log shard; (2) a deterministic stream processor (whose local database is derived entirely from the log) checks the request ID is new and the balance sufficient, reserves the amount, and emits events carrying the request ID to the source, destination, and fees shards; (3) when the outgoing-payment event comes back through the source shard's log, the processor executes the payment, ignoring duplicates by ID; (4) destination and fees processors apply incoming payments, also deduplicating by ID. If the processor crashes mid-flight, at-least-once delivery replays the request, determinism produces the same decision and the same output events, and downstream dedup absorbs duplicates. Atomicity comes from the single atomic append of the initial request event. The three accounts need not be in separate shards — the construction works identically if some are colocated; all that matters is per-account log order, at-least-once delivery, and determinism. The user learns the outcome by subscribing to the source shard for the payment-executed or payment-declined event.

Demonstrates: equivalent correctness to a multishard atomic transaction — every request applied exactly once to payer and payee — using only ordered logs, deterministic processors, and end-to-end IDs.

## Credit card statement: timeliness vs. integrity

A transaction made in the last 24 hours not yet appearing on your statement is unremarkable — banks reconcile and settle asynchronously, so timeliness barely matters. But a statement balance that doesn't equal previous balance plus transactions, or a charge taken from you and never paid to the merchant, would be catastrophic. Those are integrity violations.

Demonstrates: integrity (no corruption, books that balance) matters far more than timeliness (freshness) in most applications.

## Apology workflows: warehouses, airlines, hotels, overdrafts

If customers order more items than are in stock, you order more stock, apologize, and maybe offer a discount — the same workflow you'd need anyway if a forklift crushed inventory. Airlines deliberately overbook expecting no-shows; hotels overbook expecting cancellations; compensation processes (refunds, upgrades, a room at a neighboring hotel) exist regardless because weather and strikes cancel flights anyway. Banks let accounts go negative, then charge overdraft fees and bound their risk with daily withdrawal limits. Interbank settlement inevitably produces inconsistencies that correction mechanisms repair. The fix-up is a compensating transaction; whether the apology cost is acceptable is a business decision — often it is low (you can't unsend an email, but you can send a correcting follow-up; an accidental double credit card charge costs only the refund's processing fees and perhaps a complaint; cash dispensed by an ATM can't be directly recovered, though in principle debt collectors can pursue an overdrawn customer who won't return it). If it is, you can write optimistically and check constraints after the fact, as long as integrity is preserved throughout.

Demonstrates: many "hard" constraints are really loose business constraints; coordination can be skipped where an apology suffices.

## Battle-tested databases still had integrity bugs

Past versions of MySQL failed to maintain uniqueness constraints correctly, and PostgreSQL's serializable isolation level has exhibited write skew anomalies — in two of the most mature, widely reviewed databases in existence. Application code receives far less review and testing, and many applications don't even use the integrity features (foreign keys, uniqueness constraints) databases offer. Kyle Kingsbury's Jepsen experiments similarly exposed gaps between products' claimed guarantees and their behavior under network faults and crashes.

Demonstrates: software guarantees are probabilistic, not absolute — don't blindly trust claimed safety properties.

## HDFS and S3 don't trust disks

Large-scale storage systems run background processes that continually read files back, compare them against other replicas, and migrate files between disks to mitigate silent corruption. They assume disks work correctly most of the time — not always. The same logic says you should periodically restore from your backups; otherwise you discover the backup is broken only after you've lost the data.

Demonstrates: "trust, but verify" — continual self-auditing catches the corruption your system model says shouldn't happen.

## Blockchains, Merkle trees, and certificate transparency

Blockchains (Bitcoin, Ethereum) are shared append-only logs with cryptographic integrity checks; their transactions are events and smart contracts are essentially stream processors. Unlike Chapter 10's consensus protocols, theirs are Byzantine fault-tolerant: replicas continually verify each other, so the system survives nodes with corrupted data. The overhead is too high for most applications, but lighter-weight pieces transfer: Merkle trees efficiently prove a record's membership in a dataset, and certificate transparency uses cryptographically verified append-only logs plus Merkle trees to validate TLS certificates — avoiding a consensus protocol entirely by having a single leader per log.

Demonstrates: cryptographic auditing techniques from distributed ledgers can give event-based systems verifiable integrity at lower cost than full blockchains.
