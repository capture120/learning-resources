# Chapter 10: Consistency and Consensus — Learnings

**Central thesis:** Strong consistency means a replicated system behaves as if there were a single copy of the data with atomic operations on it; the precise formalization is linearizability. Making linearizability fault-tolerant is the consensus problem, and a wide family of seemingly different problems (CAS, locks, uniqueness constraints, shared logs, atomic commit) are all equivalent to consensus. Consensus is solvable in practice with quorum-based leader algorithms (Raft, Multi-Paxos, Zab, Viewstamped Replication), but it costs latency, requires a majority of nodes, and is not always the right tool.

**Warning:** these topics are notorious for being hard to implement correctly — it is very easy to build a system that behaves fine with no faults but falls apart under an unlucky combination of faults or message orderings its designers never considered. For serious work on consensus infrastructure, informal intuition is not enough; you need the theory.

## Two philosophies for replicated data

- **Eventual consistency:** replication is visible to the application; you handle conflicts and staleness yourself. Typical of multi-leader and leaderless replication. Inevitable if users can write while offline.
- **Strong consistency:** the system behaves like a single node. Simpler for application developers, but costs performance, and some faults that eventually consistent systems tolerate cause outages.
- Rule of thumb: replicas in datacenters with fast, reliable links → strong consistency is often affordable. Offline/sync-engine apps → eventual consistency is unavoidable.

## Linearizability

**Definition:** the system appears to have one copy of the data, and every operation takes effect atomically at some point between the request's start and its response. It is a **recency guarantee**: once any client reads (or writes) a new value, all later reads must see at least that value — no flipping back to stale data. Intuition: it makes the database behave like a variable in a single-threaded program.

Mechanics of the definition:
- A read concurrent with a write may return the old or new value — but once one read returns the new value, every read that starts afterward must too.
- You must be able to place a marker inside each operation's request/response interval such that the markers form a valid sequential history that only moves forward in time.
- Operations concurrent with each other may be ordered either way.
- Linearizability is per-object (a "register"): one key, row, or document. It says nothing about multi-object transactions.
- Testable (but expensive): record all request/response timings and check whether a valid sequential order exists (Jepsen/Knossos, Elle).

Also called: atomic consistency, strong consistency, immediate consistency, external consistency. It is the strongest single-object consistency model in common use; read-after-write, monotonic reads, and consistent prefix reads are weaker models it subsumes.

### Linearizability vs. serializability

- **Serializability** is a transaction isolation level: multi-object transactions behave as if executed in some serial order. That order may differ from real-time order — stale reads are allowed.
- **Linearizability** is a single-object recency guarantee. It does not group operations into transactions and does not prevent write skew.
- Both together = **strict serializability** (strong-1SR). Single-node databases are typically linearizable; Spanner and FoundationDB offer strict serializability; CockroachDB offers serializability with some recency guarantees but not strict serializability (the extra coordination is expensive).
- Consistency model and isolation level can be chosen largely independently.

### When you actually need linearizability

- **Locks, leases, leader election:** acquiring a lease must be linearizable, or two nodes can both believe they hold it (split brain). ZooKeeper and etcd serve this role. Note: ZooKeeper writes are linearizable but reads may be stale by default; etcd v3+ gives linearizable reads by default.
- **Hard uniqueness constraints:** usernames, file paths, "don't sell more stock than exists", "one booking per seat" — all need a single up-to-date value all nodes agree on. Registering a username is effectively acquiring a lock / a CAS on that name.
  - If the constraint can be handled loosely (overbooked flight → compensate the customer), you may not need linearizability. Foreign-key and attribute constraints don't need it either.
- **Cross-channel timing dependencies:** when two components communicate through more than one channel (e.g., file storage + message queue, or server data + push notification), a nonlinearizable channel can race the other one. Linearizability is the simplest fix; alternatives exist if you control the channel (read-your-writes techniques) at the cost of complexity.

### Which replication methods can be linearizable

| Method | Linearizable? |
|---|---|
| Single-leader replication | Potentially — if all reads/writes go to the leader AND you truly know who the leader is. A delusional leader violates it; async failover can lose committed writes. |
| Consensus algorithms | Likely — designed to prevent split brain. But reads served without confirming leadership can still be stale. |
| Multi-leader replication | No — concurrent writes on multiple nodes, async replication, conflicts. |
| Leaderless (Dynamo-style) | Probably not — even with quorums (w + r > n). |

Quorum gotchas:
- Quorum reads/writes are **not** linearizable under variable network delays: two readers using different quorums during a write can see new-then-old values in real-time order.
- You can make Dynamo-style reads/writes linearizable by (a) readers doing **synchronous read repair** before returning, and (b) writers reading a quorum first to pick a higher timestamp. Costs performance; Riak skips sync read repair for that reason; Cassandra does sync read repair on quorum reads but loses linearizability anyway via wall-clock LWW timestamps.
- Even with those fixes, only reads/writes can be linearizable this way — a linearizable **CAS cannot** be built on quorums alone; it requires consensus.
- LWW conflict resolution using time-of-day clocks (Cassandra, ScyllaDB) is almost certainly nonlinearizable because of clock skew.
- Safest assumption: a Dynamo-style leaderless system is not linearizable.
- Sharding a single-leader database (leader per shard) does not hurt linearizability — it is a single-object guarantee. Cross-shard transactions are a separate problem.

### The cost of linearizability (CAP and beyond)

- During a network partition, a linearizable system must make disconnected replicas wait or error (**CP**: consistent but unavailable). If you don't need linearizability, replicas can keep serving independently (**AP**: available but not linearizable).
- "Pick two of three" is misleading: partitions are a fault, not a choice. The only way to guarantee no partitions is to have no network — i.e., a single replica — which forfeits high availability anyway. Better phrasing: **either consistent or available when partitioned**. A more reliable network makes the choice rarer, but never avoidable.
- CAP was named by Eric Brewer in 2000, though the trade-off was known to distributed-database designers since the 1970s. Its formal scope is narrow: only linearizability, only network partitions (per Google data, <8% of incidents). It says nothing about latency, dead nodes, or other trade-offs — historically influential (it triggered the NoSQL movement by pushing engineers toward shared-nothing designs) but of little practical design value today; it has been superseded by more precise impossibility results.
- CAP's formal "availability" doesn't match the usual meaning of the word: many genuinely highly available (fault-tolerant) systems fail CAP's idiosyncratic definition, and some systems deliberately provide neither linearizability nor CAP-availability — so they are neither CP nor AP, and the classification doesn't fit much real software.
- **PACELC** generalization: during a Partition choose Availability vs Consistency; Else choose Latency vs Consistency. (It inherits CAP's counterintuitive definitions of consistency and availability.)
- The deeper cost is latency, not just fault tolerance: Attiya & Welch proved linearizable read/write response time is at least proportional to network delay uncertainty. No faster algorithm exists; weaker consistency models can be much faster. This is why even multi-core CPU RAM is not linearizable (per-core caches and store buffers, asynchronously flushed) — dropped for performance, not fault tolerance. Many databases make the same choice.

## ID Generators and Logical Clocks

A single-node autoincrement counter is a linearizable ID generator (atomic fetch-and-add): if request A completes before B begins, B gets the larger ID. IDs fit in 64 bits (32 if you're sure you'll never exceed 4 billion records — risky). Problems: single point of failure, cross-region round trips, throughput bottleneck.

Distributed alternatives — all unique, all with **weaker ordering**:
- **Sharded ID assignment** (e.g., odd/even, or shard bits in the ID): compact, but ID order no longer matches creation order.
- **Preallocated blocks** (node A gets 1–1,000, node B gets 1,001–2,000): same problem — a later message can get a lower ID.
- **Random UUIDs (v4):** no coordination, 128 bits, but order is meaningless.
- **Wall-clock timestamp + uniqueness bits** (UUIDv7, X's Snowflake, ULID, Hazelcast Flake IDs, MongoDB ObjectIDs): NTP timestamp in the most significant bits, uniqueness from a shard number plus per-shard sequence number, or a long random value. Approximately ordered, but clock skew makes ordering inconsistent with actual event order — with a nonmonotonic clock, even a *single node's* IDs can be misordered. Not linearizable. High-precision clock sync (atomic clocks/GPS) reduces the inconsistency but needs special hardware.

### Logical clocks

A logical clock counts events instead of measuring physical time. Requirements: compact unique timestamps, total order, and **order consistent with causality** (if A happened-before B, A's timestamp < B's).

- **Lamport clock** (1978, one of the most-cited papers in distributed systems): timestamp = (counter, node ID). On every event, increment the local counter; on seeing a larger counter from another node, jump the local counter up to match. Compare by counter, then node ID. Gives a total order consistent with causality — but NOT linearizability: it orders only timestamps a node has seen; independent nodes that never communicated get arbitrary relative order.
- **Hybrid logical clock (HLC):** counts physical time (e.g., microseconds) but jumps forward like a Lamport clock when it sees a larger timestamp, and increments on every generation so it is monotonic even if the physical clock jumps backward (e.g., NTP adjustments). It may therefore run slightly ahead of the underlying physical clock; the algorithm keeps that discrepancy as small as possible. Usable almost like a wall-clock timestamp, plus causal ordering; needs only roughly NTP-synced clocks. Used by CockroachDB.
- Lamport/HLC timestamps are good transaction IDs for MVCC snapshots (snapshot consistent with causality).
- **Vector clocks:** one counter per node stored with each write; can detect that two writes were *concurrent* (Lamport/HLC generally cannot — they order concurrent events arbitrarily. One exception: two Lamport timestamps with *equal* counters must be concurrent; with different counters you can't tell). Cost: timestamp size grows with the number of nodes.

### Linearizable ID generators

- Simplest: a single node with an atomic counter, persisted and replicated with single-leader replication. TiDB/TiKV's **timestamp oracle** (from Google Percolator) works this way. Optimization: persist/replicate a batch of IDs at a time, hand them out from memory; a crash skips some IDs but never duplicates or reorders. A single node can sustain high throughput because the job is trivial — but you can't shard it or distribute it across regions.
- Alternative without a central node: Spanner's TrueTime — the clock returns an uncertainty interval, and the node **waits out the interval** before returning the timestamp. Guarantees real-time ordering with no communication, even across regions — but only if the interval is correct (the true physical time really lies within it) — and requires special clock hardware (atomic clocks/GPS) and software support.
- Limit: even a linearizable ID generator (or logical clock) cannot implement fault-tolerant locks or uniqueness constraints. Picking the lowest-timestamp request as winner requires hearing from every node that might hold a lower timestamp; one unreachable node halts the system. Fault-tolerant constraint enforcement needs **consensus**.

## Consensus

The recurring pattern: single-node solutions (leader, counter, CAS instruction) are trivial; fault tolerance is the hard part. All of these reduce to consensus: getting multiple nodes to agree on a value.

Main non-Byzantine algorithms: **Raft, Multi-Paxos, Zab (ZooKeeper), Viewstamped Replication**. They assume nodes may crash or be partitioned but follow the protocol (no malice). Byzantine-tolerant algorithms (used in blockchains, tolerate < 1/3 faulty nodes) are out of scope.

### FLP impossibility — and why consensus works anyway

FLP proves no deterministic algorithm always terminates in the fully asynchronous model (no clocks or timeouts) if a node may crash. In practice, timeouts (even imperfect failure suspicion) or randomness make consensus solvable. FLP matters theoretically, not operationally.

### Properties of single-value consensus

- **Uniform agreement:** no two nodes decide differently.
- **Integrity:** a node never changes its decision.
- **Validity:** the decided value was actually proposed (rules out "always decide null").
- **Termination:** every non-crashed node eventually decides (the fault-tolerance/liveness property; the first three are safety).

Key facts:
- Termination requires a **majority of nodes functioning** — provably. Three nodes tolerate one failure; five tolerate two.
- Safety holds even if a majority fails or the network breaks: an outage can stop progress but cannot corrupt decisions.
- A crashed node must be assumed gone forever; the algorithm cannot wait for it.

### The many faces of consensus (all equivalent)

You can convert a solution for any of these into a solution for the others:
- **Single-value consensus** — leader election, who gets the lock/lease/last seat.
- **Linearizable CAS** — set value if it equals expected; consensus over the proposed values (a real-world distributed CAS: conditional writes in object stores). CAS → consensus: initialize the register to null; each proposer does CAS(null → its value); the decided value is whatever the register ends up holding. Consensus → CAS: propose the new values via consensus, set the object to the decided one; invocations with different expected values use separate consensus runs. Consensus number ∞.
- **Shared log / total order broadcast** (a.k.a. atomic broadcast) — everyone reads the same entries in the same order. Properties: eventual append, reliable delivery, append-only/immutability, agreement on prefix, validity. Consensus number ∞. Log → consensus: the first entry read back wins. Consensus → log: run one consensus instance per log slot; a node whose value loses a slot re-proposes it for a later slot.
- **Fetch-and-add** — only solves consensus between **two** nodes (consensus number 2): the node that reads 0 wins, but if it crashes before announcing, others hang.
- **Atomic commitment** (distributed transactions) — like consensus but must abort if any participant voted abort (validity: commit only if all voted commit; nontriviality: if all vote commit and no communication times out, the outcome must be commit — abort is permitted on any timeout); equivalent to consensus.

### Consensus in practice: shared logs

Most production consensus systems expose a **shared log** (= total order broadcast). Raft, VSR, and Zab provide it natively; Paxos is single-value, but real deployments use Multi-Paxos, which is also a log.

Shared log uses:
- **State machine replication:** every replica applies the same deterministic writes in log order → consistent replicas. Same principle as event sourcing; feeds into stream processing.
- **Serializable transactions:** log entries as deterministic stored procedures executed in order on every node (Calvin-style).
- **Derived consensus forms:** first entry in the log wins (single-value/CAS); include a seat number in entries and take the first entry per seat (many parallel decisions); fetch-and-add = each entry holds the number to add, counter value = sum of all entries so far; a simple count of log entries = **fencing tokens** (ZooKeeper zxid).
- Sharded strongly consistent databases typically run one log per shard — better scalability, weaker cross-shard guarantees (snapshots, foreign keys); cross-shard serializable transactions need extra coordination.

### How leader-based consensus works

Consensus = "single-leader replication done right": automatic leader election and failover with no lost committed writes and no split brain. Traditional single-leader databases left failover to a human administrator — significant downtime, and it fails the termination property; consensus requires automatic election.

- The bootstrap puzzle — you seem to need consensus to elect a leader, and a leader to run consensus — is broken by weakening the goal: leaders need not be globally unique over time, only unique *within an epoch*.
- **Epochs** (Raft: term; Paxos: ballot; VSR: view): a node that hasn't heard from the leader within a timeout starts an election under a new epoch number greater than all previous ones. Higher epoch wins conflicts (e.g., when the old leader wasn't actually dead).
- **Two rounds of quorum voting:** one to elect a leader, one for each log entry the leader wants to append (a quorum is typically, but not always, a majority — see Flexible Paxos). The two quorums must **overlap** in at least one node — that's how a leader proposal would surface a newer epoch. If a proposal vote passes with no higher epoch revealed, the leader may safely append.
- Every entry is synchronously replicated to a quorum before being confirmed to the client.
- Differs from 2PC: any node can start an election and only a quorum must respond; in 2PC only the coordinator requests votes and **every** participant must say yes.
- New-leader catch-up: Raft only elects a node whose log is at least as up-to-date as a majority's; Paxos lets any node become leader but makes it catch up before appending.
- **Linearizable reads also need a quorum round-trip** to confirm the leader is still the leader (etcd does this). A read served on leader trust alone may be stale.
- Standard algorithms assume a fixed node set; reconfiguration extensions allow adding/removing nodes (useful for region migration).

### Weakened consensus: the availability escape hatch

If you let a stale node become leader (Kafka's **unclean leader election**, or any async-replicated database failover), you recover faster and stay available — but the consensus theory no longer applies, and faults can silently lose or corrupt data. Fine until the first unlucky fault.

### Pros and cons of consensus

Pros: no committed-write loss on failover, no split brain, the only proven-safe way to do automatic failover. Any system with automatic failover that doesn't use a proven consensus algorithm is likely unsafe. Caveat: using a proven algorithm is no guarantee of whole-system correctness — plenty of other places for bugs — but it's a good start.

Cons / limits:
- Requires a **strict majority**: 3 nodes to tolerate 1 failure, 5 to tolerate 2. A minority partition is blocked.
- Every operation needs a quorum round-trip: adding nodes does **not** add throughput — it slows the algorithm down.
- Timeout tuning is hard, especially geo-distributed: too long → slow failure recovery; too short → constant spurious elections that destroy throughput.
- Network sensitivity: Raft can livelock with leadership bouncing between nodes when one link is flaky (fixed by the pre-vote extension). Leaderless protocols like EPaxos are more robust to bad nodes/links.
- Latency cost is constant, not just during faults — expensive across regions.
- When you don't need strong consistency, prefer leaderless or multi-leader replication with logical clocks.

### Coordination services (ZooKeeper, etcd, Consul)

Key-value-store-looking systems built on consensus, designed for **small, slow-changing coordination data held entirely in memory** (still written to disk for durability), not general storage or high write volume. Modeled on Google's Chubby. Kubernetes uses etcd; Spark/Flink HA use ZooKeeper.

Features:
- **Locks and leases** via fault-tolerant atomic CAS.
- **Fencing tokens:** monotonically increasing IDs per log entry (zxid/cversion in ZooKeeper, revision in etcd) to fence out paused/zombie lease holders.
- **Failure detection:** client sessions with heartbeats; leases survive brief disconnections or server failures, but are released if heartbeats stop past the lease timeout (ZooKeeper ephemeral nodes).
- **Change notifications:** subscribe to key changes instead of polling.
- Of these, only the atomic operations and fencing actually require consensus; failure detection and change notifications don't, but they pair usefully with it.

Usage guidance:
- **Leader election and shard-to-node assignment:** the canonical use. Outsource consensus to a small fixed cluster (3 or 5 nodes) instead of running it across thousands of nodes. Data changes on a timescale of minutes/hours; for fast-changing state use a regular database or Apache BookKeeper.
- Use a library (Apache Curator) rather than raw primitives — correct recipes are hard.
- **Configuration management:** convenient (load on start, subscribe to changes) but doesn't need consensus; polling a file/URL also works.
- **Service discovery:** often overkill — it doesn't need linearizability, it needs availability and speed (everything grinds to a halt without it). Prefer caching with TTLs (DNS-style); clients that can't connect to a service bypass the cache, retry with the latest value, and update the cache. ZooKeeper **observers** (non-voting replicas, stale but available reads) support this pattern.

## Numbers and named things worth remembering

- Quorum: any consensus needs a majority alive; 3 nodes → 1 failure, 5 → 2. Chapter epigraph (Brooks): "Never go to sea with two chronometers; take one or three" — two nodes can't break a tie.
- Network partitions cause <8% of incidents (Google data) — CAP focuses on a minority fault class.
- Byzantine consensus tolerates < 1/3 malicious nodes.
- Fetch-and-add consensus number = 2; CAS and shared logs = ∞ (Herlihy's wait-free hierarchy).
- Lamport timestamp = (counter, node ID); merge rule: max + increment.
- Named systems: Raft (etcd), Zab (ZooKeeper), Multi-Paxos, Viewstamped Replication, EPaxos (leaderless), Chubby (Google), timestamp oracle (TiDB/Percolator), TrueTime uncertainty wait (Spanner), Snowflake/ULID/UUIDv7 (timestamp IDs), Calvin (log-ordered transactions), Curator (ZooKeeper recipes), BookKeeper (fast replicated state).
- Attiya–Welch: linearizable operation latency ≥ proportional to network delay uncertainty.

## How this connects

- **Chapter 6 (Replication):** builds directly on single-leader, multi-leader, and leaderless replication, quorums, read repair, and replication-lag anomalies (read-after-write, monotonic reads); consensus is single-leader replication with safe automatic failover.
- **Chapter 8 (Transactions):** serializability vs linearizability; CAS/conditional writes; MVCC snapshot isolation gets its transaction IDs from logical clocks; atomic commitment/2PC is reframed as consensus.
- **Chapter 9 (Trouble with Distributed Systems):** the fault model (delays, pauses, clock skew, fencing, split brain, safety vs liveness, system models) is what makes consensus necessary and FLP meaningful.
- **Chapter 12 (Stream Processing):** shared logs and total order broadcast reappear as the foundation of logs/event streams; message queues featured in the cross-channel race example.
- **Chapter 13:** approaches that avoid linearizability without sacrificing correctness ("Timeliness and Integrity" — loose constraint enforcement).
