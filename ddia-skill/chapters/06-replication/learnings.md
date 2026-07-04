# Chapter 6: Replication — Core Learnings

**Central thesis:** Replication keeps copies of the same data on multiple machines for availability, durability, latency, disconnected operation, and read scalability. Replicating immutable data is trivial; all the difficulty is in handling *changes*. Three families of algorithms cover almost all distributed databases — single-leader, multi-leader, and leaderless — and the choice determines what consistency you can offer, what failures you survive, and what conflicts you must resolve.

The principles haven't changed much since they were studied in the 1970s, because the fundamental constraints of networks have remained the same. At a minimum a replicated system must handle unavailable nodes and network interruptions — and that's before considering more insidious faults like silent data corruption from software bugs or hardware errors.

Replication and backups are complementary, not substitutes: replicas propagate writes (including accidental deletes) quickly; backups let you go back in time. Some databases keep internal immutable snapshots of past states as a kind of built-in backup, but that stores old versions on primary storage; for large data it's cheaper to keep old snapshots in an object store and only the current state in primary storage.

## Single-Leader Replication

**Mechanism:** One replica is the leader (primary); all writes go to it. The leader writes locally, then sends changes to followers via a replication log. Followers apply writes in the same order the leader processed them. Reads can go to any replica; writes only to the leader. With sharding, each shard has its own leader.

Used by PostgreSQL, MySQL, Oracle Data Guard, SQL Server Always On, MongoDB, DynamoDB, Kafka, DRBD, and some network filesystems. Consensus algorithms (Raft, in CockroachDB/TiDB/etcd/RabbitMQ quorum queues) are single-leader with automatic leader election.

Terminology: leader-based = primary-backup = active/passive replication; followers are also called read replicas, secondaries, or hot standbys. The older term "master–slave" means the same thing but should be avoided as it is widely considered offensive.

### Synchronous vs. asynchronous replication
- **Synchronous:** leader waits for follower acknowledgment before confirming the write to the client *and before making it visible to other clients*. Guarantees an up-to-date copy on the follower, but one unresponsive synchronous follower blocks all writes.
- Making *all* followers synchronous is impractical — any single node outage halts writes. Practical pattern: **semisynchronous** — one synchronous follower, rest async; if the sync follower fails or slows, promote an async one. Guarantees up-to-date data on at least two nodes.
- Some systems update a **majority quorum** synchronously (e.g., 3 of 5 including leader); common with consensus-based leader election.
- **Fully asynchronous:** leader never waits. Writes confirmed to clients can be lost if the leader fails unrecoverably — confirmed ≠ durable. Still widely used (many followers, geo-distribution) because the leader keeps processing writes even when followers lag.
- Normal replication delay is under a second, but there is no upper bound; lag can reach minutes during recovery, near-capacity operation, or network problems.

### Setting up new followers (without downtime)
1. Take a consistent snapshot of the leader (no global lock; e.g., Percona XtraBackup for MySQL).
2. Copy the snapshot to the new node.
3. Follower requests all changes since the snapshot — requires the snapshot to be tied to an exact log position (PostgreSQL: log sequence number; MySQL: binlog coordinates or GTIDs).
4. Follower applies the backlog ("catches up"), then streams ongoing changes.

The practical steps vary significantly by database: fully automated in some systems, an arcane multistep workflow performed manually by an administrator in others.

Archiving the replication log plus periodic snapshots to object storage doubles as backup/disaster recovery (WAL-G for PostgreSQL/MySQL/SQL Server; Litestream for SQLite).

### Object-storage-backed databases
Object stores (S3, GCS, Azure Blob) increasingly serve live data, not just archives. Benefits: cheap; built-in multi-zone/region replication with high durability (and avoids inter-zone network fees); conditional writes (compare-and-set) can implement transactions and leader election; shared open formats (Parquet, Iceberg) simplify integration. Costs: much higher latency than local disk; per-API-call fees force batching (more latency); objects are immutable, so random writes are expensive; missing POSIX features (e.g., nonsequential writes, symlinks) even via FUSE. Mitigations: tiered storage (hot data on SSD/NVMe), separate low-latency WAL store (EBS, Neon Safekeepers), or **zero-disk architecture (ZDA)** — all persistence in object storage, disks/memory as cache only, so nodes are stateless (WarpStream, Confluent Freight, Bufstream, Redpanda Serverless, most cloud warehouses, Turbopuffer, SlateDB).

### Handling node outages
- **Follower failure — catch-up recovery:** the follower knows its last applied position, reconnects, and requests the missed changes. Conceptually simple; can be heavy under high write throughput. Gotcha: if a follower is down long, the leader must either retain the log (risking disk exhaustion) or delete it (forcing the follower to restore from backup).
- **Leader failure — failover:** promote a follower, repoint clients, repoint other followers. Automatic failover steps: (1) detect failure, usually a timeout (~30 s of no responses) — not needed for planned maintenance, where the leader triggers a safe handoff before shutting down; (2) choose new leader via election or controller node — pick the most up-to-date replica; (3) reconfigure routing and force the old leader to step down when it returns.
- **Decision rule:** the most important thing in failover is picking an up-to-date follower. With (semi)synchronous replication, that's the follower the old leader waited for; with async, the follower with the highest log sequence number. Losing a fraction of a second of writes may be tolerable; promoting a follower that is days behind is catastrophic.

**Failover failure modes (memorize these):**
- With async replication, the new leader may lack the old leader's latest writes; on rejoin those writes are usually discarded — silently breaking durability promises.
- Discarding writes is especially dangerous when external systems depend on database contents (see GitHub primary-key reuse incident).
- **Split brain:** two nodes both believe they are leader; if both accept writes with no conflict resolution, data is lost or corrupted. Guarding by shutting down one leader is called **fencing**; a badly designed shutdown mechanism can kill both nodes.
- Timeout tuning: too long → slow recovery; too short → spurious failovers under load spikes or network glitches, which make an already struggling system worse.
- Because none of these have clean solutions, some teams prefer manual failover even when automatic failover is supported.

### Replication log implementations
| Method | How | Pros | Cons |
|---|---|---|---|
| Statement-based | Ship SQL statements | Compact | Nondeterminism (NOW(), RAND()), order-dependence (autoincrement, UPDATE…WHERE), side effects (triggers) diverge replicas |
| WAL shipping | Ship the physical write-ahead log (PostgreSQL, Oracle) | Reuses existing log; exact byte-level copy | Coupled to storage engine; usually no version mismatch allowed → upgrades need downtime |
| Logical (row-based) | Ship row-level insert/update/delete records + commit markers | Decoupled from storage internals; leader/follower can run different versions → zero-downtime upgrades; parseable by external systems (change data capture) | Separate log to maintain |

Nondeterminism workaround: the leader can replace nondeterministic function calls (NOW(), RAND()) with fixed return values when logging the statement. MySQL used statement-based pre-5.1, now falls back to row-based (binlog) on nondeterminism; VoltDB makes statement-based safe by requiring deterministic transactions — but determinism is hard to guarantee in practice, so most databases prefer other methods. PostgreSQL logical replication decodes the WAL into row events. Deterministic statements in a fixed order = state machine replication.

Logical log record contents: an inserted row logs the new values of all columns; a deleted row logs enough to uniquely identify it (the primary key — or the old values of all columns if the table has none); an updated row logs its identity plus the new column values (at least the changed ones). A multi-row transaction emits one record per row plus a commit record. MySQL's row-based binlog is a separate logical log kept *in addition to* the WAL.

**Zero-downtime upgrade trick:** if followers can run a newer version than the leader, upgrade followers first, then fail over to an upgraded node.

## Replication Lag and Read Consistency

Read-scaling (many async followers serving reads) only works with async replication — synchronously replicating to all followers would make a single node failure block all writes, and the more followers you add, the likelier it is that one is down at any moment. But async followers can serve stale data. **Eventual consistency:** if writes stop, replicas converge eventually; "eventually" has no bound. The term was coined by Douglas Terry et al. and popularized by Werner Vogels, becoming the battle cry of the NoSQL movement — but it applies equally to async-replicated relational databases, not just NoSQL.

Three anomalies and their guarantees:

### Read-after-write (read-your-writes) consistency
Users must see their own submitted data on reload (no promise about other users' writes). Techniques:
- Read user-modifiable-by-self data from the leader or a synchronously updated follower (e.g., own profile from leader, others' from followers). Requires a way of knowing what the user *might* have modified without querying it.
- If most data is user-editable: read from leader for ~1 minute after the user's last write; or block reads on any follower more than a minute behind.
- Client remembers the (logical or wall-clock) timestamp of its last write; only replicas caught up to that timestamp may serve its reads — else route the read to another replica or wait for catch-up. Wall-clock variant makes clock sync critical.
- With replicas spread across regions, any read that must hit the leader has to be routed to the leader's region — extra complexity even for a single device.
- **Cross-device** read-after-write requires centralizing last-write metadata (devices don't see each other's writes) and may require routing all of a user's devices to the leader's region (home broadband and cellular may route differently).

### Regions and availability zones (terminology)
A region is one or more datacenters in a single geographic location; each datacenter is an availability zone. Inter-zone links are fast enough that most distributed systems can span the zones of one region as if they were a single zone. Multi-zone deployments survive a zonal outage but **not** a regional one; surviving regional outages requires multi-region deployment, at the cost of higher latency, lower throughput, and bigger cloud networking bills.

### Monotonic reads
A user must never see time go backward (read newer data, then older). Happens when successive reads hit replicas with different lag (e.g., page refreshes load-balanced randomly). Fix: pin each user to one replica, e.g., by hashing user ID; handle rerouting on replica failure. Stronger than eventual consistency, weaker than strong consistency.

### Consistent prefix reads
If writes happen in a causal order, readers must see them in that order (the answer must not appear before the question). Mainly a problem in sharded systems where shards apply writes independently with no global order. Fixes: write causally related data to the same shard, or track causal dependencies explicitly (happens-before tracking).

### Decision guidance
Ask: what happens to the app if lag grows to minutes or hours? If users suffer, design for a stronger guarantee — don't pretend async replication is synchronous. Solving these in application code is complex and error-prone; the simplest programming model is a database with linearizability and ACID transactions ("NewSQL" systems offer this with distributed fault tolerance). The early-2010s NoSQL movement claimed these features precluded scalability; NewSQL has since disproved that — and the name is less about SQL than about new approaches to scalable transaction management. Weaker-consistency replication remains attractive for resilience to network interruptions and lower overhead.

## Multi-Leader Replication

**Mechanism:** multiple nodes accept writes (active/active, also called bidirectional replication); each leader forwards its writes to all others and acts as a follower of the other leaders. Synchronous multi-leader is equivalent to single-leader, so multi-leader in practice means asynchronous.

**When to use:** almost never within a single region (complexity outweighs benefit). Good fits:
1. **Geo-distributed operation** — a leader per region; within a region, normal leader-follower.
2. **Offline clients** — each device's local database is a leader; sync when reconnected (calendar apps); lag may be hours or days.
3. **Real-time collaboration** — every browser tab/device is a replica accepting local writes (Google Docs, Figma, Linear).

### Single-leader vs. multi-leader across regions
- **Performance:** single-leader sends every write across the internet to the leader's region; multi-leader writes locally and replicates async — inter-region delay hidden from users.
- **Regional outages:** multi-leader regions keep operating independently; single-leader needs failover.
- **Network problems:** inter-region links are less reliable than intra-region; single-leader writes block on that link; async multi-leader rides out interruptions.
- **Consistency (the big downside):** multi-leader cannot enforce global constraints like unique usernames or non-negative balances — two leaders can each accept individually fine writes that jointly violate the constraint. This is a fundamental distributed-systems limitation. If you need such constraints, use single-leader.

Multi-leader is a retrofitted feature in many databases (MySQL, Oracle, SQL Server, YugabyteDB; add-ons like Redis Enterprise, EDB Postgres Distributed, pglogical) with subtle pitfalls: autoincrement keys, triggers, integrity constraints. Often considered dangerous territory; avoid if possible.

### Topologies
- **All-to-all:** every leader sends to every other. Most fault tolerant (multiple message paths), but faster links can let writes "overtake" their causal predecessors (update arrives before the insert it depends on). Timestamps don't fix this (clock skew); version vectors do. Many systems don't handle this well — test your database's actual guarantees.
- **Circular / star (generalizes to tree):** writes pass through intermediate nodes; each write is tagged with the IDs of all nodes it has passed through, and a node ignores changes tagged with its own ID (prevents infinite replication loops). One failed node interrupts replication flow between others, usually requiring manual reconfiguration.

### Sync engines and local-first software
Keep persistent state on the client; server communication is a background process. Advantages: UI responds from local data (some apps target next-frame, 16 ms at 60 Hz); offline is just a very large network delay (no separate offline mode); reads/writes on local data almost never fail, simplifying frontend code vs. per-RPC error handling; pairs well with reactive UI updates. Limit: requires downloading all needed data in advance — fine for a user's own documents, not for an ecommerce catalog. **Offline-first** = works offline; **local-first** = also survives the vendor shutting down its servers (open sync protocol, multiple providers — Git is the canonical example). Pioneered by Lotus Notes in the 1980s. Engines: Firestore, Realm, Ditto (proprietary backend); PouchDB/CouchDB, Automerge, Yjs (open source). Games solve the analogous problem with netcode; techniques don't transfer.

### Dealing with conflicting writes
Two writes are **concurrent** if neither knew about the other when made — physical time is irrelevant (offline edits hours apart can be concurrent).

1. **Conflict avoidance:** route all writes for a record through the same leader (e.g., per-user "home region"). Breaks down when the designated leader must change (region failure, user moved). Impossible for offline sync clients. Variant: partition the ID space (one leader assigns odd IDs, the other even).
2. **Last write wins (LWW):** take the value with the greatest timestamp; tie-break by value. For concurrent writes "last" is meaningless — one write is effectively chosen at random and the others are silently discarded despite being acknowledged. Fine if you only insert unique keys and never update; otherwise expect lost updates. Wall-clock timestamps add clock-skew sensitivity (a fast clock can make later writes get ignored); logical clocks fix that part.
3. **Manual resolution (siblings):** store all concurrently written values ("siblings"); return all of them on read; the application or user merges and writes back. Used by CouchDB. Costs: API becomes set-valued; building merge UI is hard; naive automatic merges surprise users (set-union resurrects deleted shopping-cart items); concurrent resolutions can themselves conflict (B/C vs. C/B → B/C/C/B).
4. **Automatic conflict resolution:** merge algorithms that guarantee **convergence** — all replicas that saw the same set of writes reach the same state regardless of arrival order. Eventual consistency + convergence = **strong eventual consistency**. Type-aware merges: text (preserve all insertions/deletions, deterministic ordering for same-position inserts), collections (track deletions so removed items stay removed), counters, e.g. likes on a social post (sum per-replica increments/decrements without double-counting), maps (merge per key). Hard limit: invariants like "at most 5 items in the list" cannot be preserved under concurrent additions — something must be dropped.

**CRDTs vs. OT:** the two algorithm families for automatic merging. OT transforms operation indexes to account for concurrently applied operations; used for collaborative text editing (Google Docs). CRDTs give each element an immutable unique ID and address positions by ID, so replicas converge without transformation; used in Redis Enterprise, Riak, Azure Cosmos DB. JSON sync engines exist on both (Automerge/Yjs = CRDT; ShareDB = OT). Their advantages can be combined.

**Subtle conflicts:** not all conflicts are two writes to one field. A meeting-room booking system that inserts a record per booking can create overlapping bookings if two clients check availability concurrently — both see the room free. Application-level constraint conflicts have no quick ready-made answer; the book points forward to more conflict examples in Chapter 8 (transactions) and scalable conflict detection and resolution in Chapter 13.

## Leaderless Replication

**Mechanism:** no leader; clients (or a coordinator node that does not order writes) send each write to several replicas in parallel and read from several replicas in parallel. Some of the earliest replicated systems were leaderless; the idea was mostly forgotten during the relational-database era and revived by Amazon's Dynamo paper (2007). "Dynamo-style": Riak, Cassandra, ScyllaDB. (Note: Dynamo itself was in-house only, never released outside Amazon; DynamoDB the AWS product is *not* Dynamo-style — it uses single-leader replication via Multi-Paxos.)

No failover exists. If a replica is down during a write, it just misses the write; reads compensate by querying multiple nodes and using version numbers to pick the newest value.

### Catch-up mechanisms for a recovered replica
- **Read repair:** a client reading in parallel detects stale responses and writes the newer value back. Only helps frequently read values.
- **Hinted handoff:** another replica stores writes ("hints") on behalf of the unavailable one and delivers them when it recovers. Covers never-read values.
- **Anti-entropy:** background process diffs replicas and copies missing data, in no particular order, possibly with significant delay.

### Quorums
With n replicas, require w acknowledgments per write and r responses per read. If **w + r > n**, the read set and write set overlap in at least one node, so reads see the latest successful write. Common: n odd (3 or 5), w = r = (n+1)/2. Tuning:
- w < n: writes survive an unavailable node; r < n: reads do. n=3, w=r=2 tolerates 1 node down; n=5, w=r=3 tolerates 2.
- Read-heavy: w = n, r = 1 — fast reads, but one failed node blocks all writes.
- w + r ≤ n: lower latency (especially beneficial when replication is synchronous/blocking) and higher availability — the database only becomes unavailable once reachable replicas drop below w (for writes) or r (for reads) — but more stale reads: a probabilistic trade, not a correctness guarantee.
- Requests still go to all n replicas; w and r are just how many responses you wait for — think of them as the minimum number of *votes* needed for a write or read to be valid. If fewer than w or r nodes respond successfully, the operation returns an error.
- Majorities (more than n/2) satisfy w + r > n while tolerating up to n/2 (rounded down) failures, but quorums need not be majorities — only overlap matters (this flexibility is exploited in distributed algorithm design).
- "Unavailable" covers anything — crash, full disk, network interruption: the client cares only whether a node returned success, never which kind of fault occurred.
- n is per *value*, not cluster size: a cluster can have more than n nodes, with each value stored on only n of them (this is what allows sharding datasets larger than one node).

### Why quorum consistency is weaker than it looks (gotchas)
Even with w + r > n, you can read stale data when:
- A node holding a new value fails and is restored from a stale replica, dropping the new value below w copies.
- Rebalancing/sharding changes which nodes hold the n replicas, so read and write quorums stop overlapping.
- A read concurrent with a write may or may not see it — and a later read may see *older* data than an earlier one (not linearizable).
- A write that succeeded on fewer than w replicas is reported failed but **not rolled back** — later reads may or may not return it.
- LWW with wall-clock timestamps (Cassandra, ScyllaDB) silently drops writes when another node's clock runs fast.
- Concurrent writes reach replicas in different orders → conflicts, same as multi-leader.

Treat w/r as dials on the *probability* of stale reads, not absolute guarantees. Dynamo-style stores target workloads that tolerate eventual consistency.

### Monitoring staleness
Leader-based: lag = leader log position − follower log position; easy to expose as a metric. Leaderless: no write order, so lag is hard to quantify; hint counts are a weak proxy. "Eventual" needs quantifying for operability.

### Performance comparison vs. single-leader
Leader reads are fresh but: read throughput capped by the leader; failover pauses are user-visible; leader slowness immediately hurts everyone. Leaderless resilience comes from *not distinguishing normal from failure cases*: requests go to several replicas anyway, so one slow/dead replica barely matters — using the fastest responses (**request hedging**) cuts tail latency. Especially valuable for **gray failures** (node degraded but not down) where a leader-based system must make a fraught failover decision.

Leaderless costs: failure detection and hinted handoff add load exactly when the system is strained; larger quorums mean waiting on more nodes and higher chance of hitting a slow one — in practice quorums rarely exceed 4-of-7 or 5-of-9; a large network interruption can make quorums unreachable. **Sloppy quorum** (Riak/Dynamo; Cassandra `ANY`): accept writes on any reachable node even if it's not a designated replica for the key — write survives, but subsequent reads may not see it.

Spectrum: multi-leader tolerates network interruptions best (talk to one local leader) but reads can be arbitrarily stale; quorum reads/writes are the compromise — good fault tolerance, high likelihood of fresh reads; single-leader gives the strongest consistency.

### Multi-region operation
Cassandra/ScyllaDB: client picks a local coordinator node; the coordinator sends to all local replicas and one replica per remote region (which fans out locally) — avoids repeated cross-region hops. Configurable consistency levels: quorum across all regions, per-region quorums, or local-region quorum only (faster, staler). Riak keeps n within one region and replicates across regions asynchronously, multi-leader style.

### Detecting concurrent writes: happens-before and version vectors
Conflicts are not always detected as the writes happen; they may surface only later, during read repair, hinted handoff, or anti-entropy. A happens-before B if B knew about, depends on, or builds upon A. Exactly three possibilities for any two ops: A → B, B → A, or concurrent. If ordered, the later overwrites the earlier; if concurrent, you have a conflict to resolve. (A plain LWW timestamp can't tell you which case you're in — it orders values without revealing whether they actually conflicted.)

Mental model from special relativity: two events too far apart for light to travel between them cannot affect each other, so they are concurrent regardless of clock readings. Computer systems are even looser: a slow or interrupted network makes operations concurrent that physical time would have allowed to influence each other — concurrency is about mutual unawareness, not simultaneity.

**Single-replica algorithm:** server keeps a version number per key, incremented on every write. Reads return all unoverwritten values (siblings) plus the latest version — a client must read a key before writing it. Writes must include the version from the client's prior read and must merge the siblings it received. The server overwrites all values at or below that version, keeps higher-versioned values as siblings. Write responses also return the current siblings and new version, so a client can chain several writes without re-reading. A write with no version number is concurrent with everything — it overwrites nothing. The server never needs to interpret the values themselves, so they can be any data structure.

**Multiple replicas:** one counter is not enough; use a version number *per replica, per key*. Each replica increments its own counter and tracks counters seen from others. The full collection is a **version vector** (Riak 2.0 uses the dotted version vector variant, exposed to clients as an opaque "causal context"). Version vectors travel: replica → client on read, client → replica on write. They make it safe to read from one replica and write to another — at worst siblings are created, and no data is lost if siblings are merged correctly. Terminology: version vectors ≠ vector clocks; for comparing replica states, version vectors are the right structure.

## Numbers and named things worth remembering
- Failure-detection timeout example: ~30 s. Replication lag normally < 1 s; unbounded in the tail.
- Quorum formula: w + r > n; defaults w = r = (n+1)/2, n = 3 or 5; practical quorums ≤ 4/7 or 5/9.
- 16 ms render budget (60 Hz) motivates local-first reads.
- Named: active/passive (single-leader), active/active / bidirectional (multi-leader), semisynchronous replication, failover, split brain, fencing, state machine replication, change data capture, GTID/log sequence number, read-after-write / monotonic reads / consistent prefix reads, strong eventual consistency, CRDT, OT, siblings, LWW, read repair, hinted handoff, anti-entropy, sloppy quorum, request hedging, gray failure, version vector / dotted version vector, zero-disk architecture, sync engine, offline-first, local-first, NewSQL.

## How this connects
- **Chapter 4 (storage):** WAL shipping reuses the B-tree write-ahead log; logical logs decouple from it.
- **Chapter 7 (sharding):** this chapter assumes each replica holds the full dataset; sharding relaxes that. Per-shard leaders, request routing, rebalancing breaking quorum overlap, and consistent-prefix problems all interact with sharding.
- **Chapter 8 (transactions):** single-leader systems can offer serializable transactions; conflict examples (meeting-room booking) reappear there.
- **Chapter 9 (distributed-system faults):** unreliable clocks undermine LWW and timestamp-based ordering; split-brain scenarios; network partitions.
- **Chapter 10 (consistency & consensus):** leader election is a consensus problem; linearizability defines what quorums fail to deliver; shared-log replication theory.
- **Chapter 12 (stream processing):** logical replication logs feed change data capture.
- **Chapter 13:** scalable conflict detection and resolution.
