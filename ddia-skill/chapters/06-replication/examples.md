# Chapter 6: Replication — Examples and Case Studies

All examples below come from the chapter text. Each entry retells the example and states the principle it demonstrates.

## Profile image update with mixed sync/async followers (Figure 6-2)
A user updates their profile image on a website. The client sends the write to the leader. The leader forwards the change to follower 1 synchronously — it waits for follower 1's confirmation before reporting success to the user — and to follower 2 asynchronously, without waiting. Follower 2 happens to process the message after a substantial delay. Normally replication completes in under a second, but nothing bounds the delay: a recovering follower, a system near capacity, or network trouble can push lag to minutes.

**Principle:** synchronous replication guarantees the follower is up to date at the cost of blocking on it; asynchronous replication never blocks but gives no freshness or durability guarantee.

## GitHub's out-of-date follower promotion (failover incident)
In an incident at GitHub, a MySQL follower that was lagging behind the leader was promoted to leader during failover. The database assigned primary keys from an autoincrementing counter, and the new leader's counter was behind the old leader's, so it reissued primary keys that the old leader had already handed out. Those keys were also referenced in a Redis store. The reuse made MySQL and Redis disagree about which row a key referred to, and some users were shown private data belonging to other users.

**Principle:** discarding unreplicated writes during failover is especially dangerous when external systems are coordinated with database contents — durability violations propagate beyond the database.

## Split brain and over-eager fencing
If failure detection goes wrong, two nodes can simultaneously believe they are the leader. If both accept writes with no conflict resolution, data is lost or corrupted. Some systems respond by shutting down one node when two leaders are detected, but the chapter notes (citing a second GitHub outage) that a badly designed mechanism can shut down *both* nodes — and detection may come too late, after data is already corrupted.

**Principle:** split brain is the core hazard of automatic failover; fencing mechanisms must be designed carefully or the cure is worse than the disease.

## Nondeterministic SQL statements breaking statement-based replication
If a leader ships raw SQL statements to followers, a statement calling NOW() or RAND() produces different values on each replica. Statements using autoincrement columns or `UPDATE ... WHERE <condition>` depend on existing state and execution order, and triggers or stored procedures cause side effects that may differ per replica. MySQL used statement-based replication before version 5.1 and now switches to row-based replication when a statement is nondeterministic; VoltDB keeps statement-based replication safe by requiring transactions to be deterministic.

**Principle:** replaying statements only converges if execution is fully deterministic and identically ordered; otherwise replicate row-level effects instead.

## User submits a comment, then can't see it (Figure 6-3)
A user writes data (a comment, a customer record) which goes to the leader, then immediately reloads the page. The read is served by an asynchronous follower that hasn't yet received the write. The user's own submission appears to be lost. The fix is read-after-write consistency, e.g., the social-network rule: a user's own profile is editable only by them, so always read your *own* profile from the leader and everyone else's from followers.

**Principle:** read-after-write consistency — users must see their own writes; achievable by routing reads of potentially self-modified data to the leader.

## Cross-device read-after-write
The same user accesses a service from a desktop browser and a mobile app. They enter data on one device and expect to see it on the other. Timestamp-based tricks fail because one device doesn't know about the other device's writes — that metadata must be centralized. Worse, the desktop on home broadband and the phone on cellular may be routed to different regions, so all of a user's devices may need routing to the same region for leader reads.

**Principle:** read-after-write across devices requires centralized write metadata and consistent routing, not per-client state.

## Comment that appears, then disappears (Figure 6-4)
User 1234 adds a comment. User 2345 runs the same query twice — each page refresh hits a random replica. The first query lands on a barely lagging follower and returns the comment; the second lands on a more lagged follower and returns nothing. To user 2345, the comment appeared and then vanished: time went backward. Monotonic reads prevent this, e.g., by always routing a given user's reads to the same replica chosen by a hash of their user ID.

**Principle:** monotonic reads — sequential reads by one user must never observe an older state after a newer one.

## Mr. Poons and Mrs. Cake (Figure 6-5)
Mr. Poons asks, "How far into the future can you see, Mrs. Cake?" She answers, "About 10 seconds usually, Mr. Poons." An observer reads through followers where her shard replicates quickly and his replicates slowly, so the observer hears the answer before the question — apparent psychic powers. The answer causally depends on the question, but independent shards have no global write order, so causality is violated for readers.

**Principle:** consistent prefix reads — causally ordered writes must be observed in order; a particular hazard in sharded databases where each shard replicates independently.

## Update overtakes the insert it depends on (Figure 6-8)
Client A inserts a row on leader 1; client B then updates that row on leader 3. In an all-to-all topology, some network links are faster than others, so leader 2 may receive the update before the insert — from its point of view, an update to a row that doesn't exist. These two writes are *not* concurrent: B's update builds on A's insert (B is causally dependent on A), so every replica must apply the insert first. Attaching a timestamp to every write doesn't fix the ordering, because clocks can't be trusted to be sufficiently in sync; version vectors can. Many multi-leader systems don't order updates correctly, so the chapter advises reading the documentation and testing whether your database really provides the guarantees you believe it has. The chapter later reuses this figure as its canonical example of a happens-before (non-concurrent) pair, contrasting it with the truly concurrent writes of Figure 6-14.

**Principle:** replication messages traveling different paths can violate causality; ordering causally dependent writes requires version vectors (or similar), not timestamps.

## Calendar apps as extreme multi-leader replication
Your phone, laptop, and other devices each hold a calendar replica that must accept reads and writes regardless of connectivity. Each device's local database is a leader, and an asynchronous sync process replicates between devices when online. Replication lag may be hours or days. Architecturally this is multi-region multi-leader replication taken to the extreme: each device is a "region" with an extremely unreliable link.

**Principle:** offline-capable apps are inherently multi-leader; conflict handling is unavoidable because conflict avoidance can't work for disconnected writers.

## Google Docs, Figma, Linear: real-time collaboration is multi-leader
Collaborative apps reflect user input in the UI immediately, without a server round-trip, and propagate edits to collaborators with low latency. Every browser tab with the file open is a replica accepting local writes, asynchronously replicated to other users. Even without offline support, letting multiple users edit without waiting for the server already makes the system multi-leader, requiring merge/conflict logic. The supporting library is called a sync engine; some apps target rendering input within one 16 ms frame at 60 Hz.

**Principle:** low-latency collaborative editing forces the multi-leader model and its conflict-resolution machinery even for always-online apps.

## Git as local-first software
Git is offline-first — you commit locally without a network — and local-first: collaboration continues even if any one hosting provider disappears, because you can sync via GitHub, GitLab, or any other host using the open protocol. It lacks real-time collaboration but exemplifies open-protocol sync. Manual merge-conflict resolution in Git also serves as the chapter's model for manual conflict resolution in databases.

**Principle:** local-first software survives vendor shutdown via open sync protocols; version-control merging is the familiar face of replica conflict resolution.

## Wiki page title conflict: A → B vs. A → C (Figure 6-9)
Two users edit the same wiki page on different leaders. User 1 changes the title from A to B; user 2 independently changes it from A to C. Each write succeeds on its local leader; the conflict only surfaces when changes replicate asynchronously. The writes are concurrent because neither was aware of the other when made — regardless of physical timing. Under LWW, if user 1's timestamp is higher, both leaders settle on B and the write of C is silently discarded.

**Principle:** asynchronous multi-leader writes to the same record produce conflicts that single-leader systems never see; LWW resolves them by randomly discarding acknowledged writes.

## Conflict avoidance via home regions and odd/even IDs
An application where users edit only their own data routes each user's requests to a fixed "home" region; from each user's perspective the system is single-leader and conflicts can't arise. This breaks when the designated leader changes — a region fails or the user relocates — and a write lands mid-change. Separately, two leaders generating autoincrement IDs can be configured so one issues only odd and the other only even numbers, preventing concurrent assignment of the same ID.

**Principle:** conflict avoidance by pinning records to one leader works well until leadership must move; partitioning the keyspace prevents specific conflict classes.

## Amazon's reappearing shopping-cart items (Figure 6-10)
Amazon's cart once merged concurrent sibling versions by taking the set union of cart contents. Device 1 removed Book from the cart while device 2 concurrently removed DVD. The union merge restored both removed items, so deleted items reappeared in customers' carts. A merge algorithm that tracks deletions (tombstones) would yield Cart = {Soap}.

**Principle:** naive automatic sibling merging (set union) loses deletions; convergent merges must track removals explicitly.

## Inconsistent conflict resolutions creating new conflicts
If multiple nodes observe the siblings B and C and resolve them concurrently, one node may merge them as B/C while another produces C/B. Those resolutions are themselves conflicting siblings, and merging them can produce B/C/C/B or similar garbage.

**Principle:** conflict resolution itself must be deterministic and consistently ordered, or it generates new conflicts.

## "ice" → "nice!": OT vs. CRDT text merging (Figure 6-11)
Two replicas start with the text "ice". One prepends "n" (making "nice"); the other concurrently appends "!" (making "ice!"). Both should converge to "nice!". OT records operations by index — insert "n" at 0, insert "!" at 3 — and when applying the remote "!" after "n" has been inserted, transforms its index from 3 to 4; applying it untransformed would yield "nic!e". A CRDT instead gives every character an immutable unique ID (i=1A, c=2A, ...) and expresses the insert as "place character 4B after character 3A", so no transformation is needed and concurrent same-position inserts are ordered by ID.

**Principle:** the two automatic-merge families differ in mechanism — OT transforms operation indexes, CRDTs address positions by immutable IDs — but both converge all replicas to the same merged state.

## Meeting room double-booking
A booking system inserts a new record per reservation and must ensure no overlapping bookings for the same room. Even though no two writes touch the same record, two users can check availability at nearly the same time, both see the room free, and both insert bookings — a conflict invisible at the level of individual records. Checking before writing doesn't help, because the check and the insert aren't atomic across leaders.

**Principle:** conflicts aren't only concurrent updates to one field; application-level invariants spanning multiple records can be violated by individually valid concurrent writes.

## Writing with one of three replicas down (Figure 6-12)
A leaderless store has three replicas; one is down for a reboot. User 1234 sends a write to all three in parallel; the two available replicas acknowledge it, and with w = 2 the write is deemed successful — no failover happens or is needed. When the rebooted node returns, it has missed writes. User 2345 reads from all three in parallel and receives version 7 from two replicas but stale version 6 from the recovered one; the version numbers identify the fresh value, and the client writes version 7 back to the stale replica (read repair).

**Principle:** quorum writes (w + r > n, here n=3, w=r=2) tolerate node outages without failover, and parallel versioned reads detect and repair staleness.

## Concurrent writes arriving in different orders (Figure 6-14)
Clients A and B simultaneously write to key X in a three-node leaderless store. Node 1 receives only A's write (B's is lost in a transient outage); node 2 receives A then B; node 3 receives B then A. If each node simply applied writes in arrival order, node 2 would end with value B and nodes 1 and 3 with value A — permanently inconsistent replicas. Convergence requires a conflict-resolution mechanism (LWW in Cassandra/ScyllaDB, CRDTs in Riak, or sibling-based manual resolution).

**Principle:** without a leader there is no write order; replicas must detect concurrency and converge via explicit conflict resolution, not arrival order.

## Two shoppers, one cart: causal version tracking (Figures 6-15, 6-16)
Two clients concurrently add items to a shared cart on a single-replica store that tracks a version number per key. (1) Client 1 adds milk — stored as version 1. (2) Client 2, unaware, adds eggs — server keeps [milk] and [eggs] as siblings, version 2. (3) Client 1 adds flour, sending its last-seen version 1 with value [milk, flour] — the server overwrites [milk] (covered by version 1) but keeps the concurrent [eggs]. (4) Client 2 adds ham after merging the siblings it saw at version 2, writing [eggs, milk, ham] — overwrites [eggs], concurrent with [milk, flour]. (5) Client 1 merges its version-3 siblings and adds bacon, writing [milk, flour, eggs, bacon] — concurrent with [eggs, milk, ham], so both remain as siblings. Clients are never fully up to date, yet no write is ever lost, and old versions are eventually overwritten. The chapter offers air-traffic controllers adding aircraft to a tracked sector as a higher-stakes version of the same pattern. With multiple replicas, the single version number generalizes to a version vector (per replica, per key).

**Principle:** requiring clients to pass back the version they read lets the server distinguish overwrites from concurrent writes, preserving all causal information without interpreting the values.

## Cassandra/ScyllaDB and Riak multi-region strategies
In Cassandra and ScyllaDB, a multi-region write goes first to a coordinator node in the client's region, which forwards it to all local replicas and to a single replica in each remote region; that replica fans out locally. This avoids sending the same write across the expensive inter-region link multiple times. Consistency levels are configurable: a quorum across all regions, a quorum per region, or a local-region quorum only — the local quorum is fastest but most likely to return stale data. Riak instead scopes n entirely to one region and replicates across regions asynchronously in multi-leader style.

**Principle:** leaderless systems extend to multi-region by minimizing cross-region traffic and letting operators trade consistency for latency per request.

## Zero-disk architectures on object storage
WarpStream, Confluent Freight, Buf's Bufstream, and Redpanda Serverless are Kafka-compatible systems that persist all data to object storage and use local disks and memory purely as cache, leaving nodes with no persistent state. Nearly every modern cloud data warehouse, Turbopuffer (vector search), and SlateDB (cloud-native LSM engine) do the same. They lean on object stores' built-in replication, durability, and conditional-write (compare-and-set) primitives for leader election and transactions, while engineering around high latency, per-call fees (batching), and immutable objects. Neon stores its WAL on separate low-latency Safekeeper nodes rather than the object store.

**Principle:** shifting replication and durability to object storage dramatically simplifies database architecture, at the price of latency and access-pattern constraints.

## WAL-G and Litestream: backups as replication infrastructure
Archiving the replication log to an object store alongside periodic full snapshots serves double duty: it is a backup/disaster-recovery mechanism, and a new follower can perform the snapshot steps of setup (taking the snapshot and copying it to the new node) by downloading from the object store instead of loading the leader; it still connects to the leader to request the changes since the snapshot. WAL-G implements this for PostgreSQL, MySQL, and SQL Server; Litestream does the equivalent for SQLite.

**Principle:** backups and replication are complementary — the same snapshot-plus-log artifacts power both follower setup and point-in-time recovery.
