# Chapter 10: Consistency and Consensus — Examples

## The sports website (Aaliyah and Bryce)

Aaliyah and Bryce sit in the same room checking the score of a game on their phones. Just after the final score is announced, Aaliyah refreshes, sees the winner, and tells Bryce. Bryce reloads his own phone, but his request hits a lagging database replica, so it shows the game still in progress. Had they refreshed simultaneously, different results would be unsurprising. But Bryce started his query *after* hearing Aaliyah's result, so he expected a result at least as fresh as hers.

Crucially, Bryce only noticed the staleness because of a second communication channel: Aaliyah's voice. Without it, he would have refreshed later and never known.

**Demonstrates:** linearizability is a recency guarantee — once one client observes a new value, every later-starting read must also see it; violations surface through out-of-band channels.

## Register reads concurrent with a write (Figures 10-2 and 10-3)

Client C writes x = 1 (initially 0) while clients A and B repeatedly read x. Each request is a time interval from send to response, and the client can't know exactly when within that interval the database processed it. Reads completing before the write starts must return 0; reads starting after the write completes must return 1; reads overlapping the write may return either. But that alone isn't linearizability: readers could otherwise see the value flip back and forth during the write. The extra constraint: the value flips atomically at some instant inside the write's interval, so once A's read returns 1, a read by B that starts afterward must also return 1 — even though C's write is still in flight.

**Demonstrates:** the formal core of linearizability — an atomic flip point plus no going back to old values.

## Marked execution with CAS operations (Figure 10-4)

A denser timeline adds compare-and-set operations. Each operation gets a marker at the instant it logically took effect, and joining the markers must give a valid sequential register history moving only forward in time. Notable details: B's read can return a value written by a request *sent later* (the requests were concurrent — B's read was just delayed in the network); a read can return a written value before the writer itself receives its OK response; D's CAS fails because the value changed before the database processed it; and B's final read is the violation — it returns 2 after client A already read 4, so B observed an older value than an earlier-completed read.

**Demonstrates:** how to check linearizability by finding (or failing to find) forward-moving sequencing points; no transaction isolation is assumed.

## Locking, leader election, and Oracle RAC

A single-leader system must guarantee one leader, or split brain corrupts data. Leader election via a lease must be linearizable: two nodes must never both acquire it. ZooKeeper and etcd provide this using consensus (with caveats: ZooKeeper writes are linearizable but reads may be stale; etcd v3+ reads are linearizable by default). At a much finer grain, Oracle Real Application Clusters takes a linearizable lock per disk page, with multiple nodes sharing one disk array; because these locks sit on the critical path of every transaction, RAC deployments use a dedicated cluster interconnect network.

**Demonstrates:** locks and leader election require linearizability, and linearizable locks on the hot path demand serious network investment.

## Uniqueness constraints (usernames, bank balances, seats)

A username or file path must identify exactly one thing. If two people concurrently register the same name and one must get an error at write time, you need linearizability — registering is like acquiring a lock on the name, or a CAS setting the name to your user ID if unclaimed. The same applies to never letting a bank balance go negative, never overselling stock, and never double-booking a seat. Counterpoint: if the constraint can be relaxed (an overbooked flight is fixed with rebooking and compensation), linearizability may be unnecessary; foreign-key and attribute constraints also don't need it.

**Demonstrates:** hard uniqueness needs a single agreed-on up-to-date value; soft constraints are an escape hatch.

## The video transcoder race (Figure 10-5)

A website lets users upload videos; a background transcoder produces low-bandwidth versions. The web server stores the video in a file storage service, then puts a transcode instruction on a message queue (videos are too big for the queue itself). If the storage service is not linearizable, the queue may outrun the storage service's internal replication: the transcoder receives the job, fetches the file, and sees an old version or nothing. Transcoding an old version leaves the original and transcoded videos permanently inconsistent. The race exists because there are two channels between web server and transcoder: storage and queue. A variant: a mobile push notification arrives quickly, but the app's follow-up fetch hits a lagging replica and can't find the data the notification announced.

**Demonstrates:** cross-channel timing dependencies — with multiple communication channels, a nonlinearizable one causes races; linearizability is the simplest fix.

## Nonlinearizable quorum (Figure 10-6)

Dynamo-style cluster, n = 3, w = 3, r = 2; x starts at 0. A writer sends x = 1 to all three replicas, but the writes land at different times. Client A reads from a two-node quorum and gets {1, 0} → returns 1. Client B then reads from a *different* two-node quorum and gets {0, 0} → returns 0. The quorum condition w + r > n holds, yet B's read began after A's completed and returned an older value. Quorums can be made linearizable with synchronous read repair on reads plus a quorum read before writes — Riak skips this for performance; Cassandra does sync read repair but its wall-clock LWW timestamps break linearizability anyway. Even then, CAS is impossible without consensus.

**Demonstrates:** quorum overlap does not equal linearizability under variable network delays.

## Multi-region partition: single-leader vs. multi-leader (Figure 10-7)

A database is replicated across two regions and the link between them dies, while clients can still reach their local region. Multi-leader: both regions keep operating; writes queue up and exchange when connectivity returns. Single-leader: the leader lives in one region; clients in the follower region cannot write or do linearizable reads — they either wait, error, or accept stale follower reads. Clients that can reach the leader region are fine. This is the CAP trade-off in concrete form: require linearizability and a partition makes part of the system unavailable (CP); drop it and stay available (AP).

**Demonstrates:** any linearizable system, regardless of implementation, becomes unavailable to clients cut off from the deciding nodes.

## Multi-core RAM is not linearizable

A thread writing to a memory address on one CPU core is not guaranteed to be seen immediately by a thread reading the same address on another core, unless a memory barrier/fence is used. Each core has its own cache and store buffer, updated asynchronously — multiple copies of the data, just like replicas. Here the CAP framing makes no sense: a core doesn't keep operating "partitioned" from the rest of the machine. The trade-off is purely performance. The same is true of many databases that drop linearizability — it's for speed, not fault tolerance, and Attiya & Welch proved linearizable response times must scale with network delay uncertainty.

**Demonstrates:** linearizability is usually sacrificed for performance, not availability; even hardware does it.

## Chat app with autoincrementing IDs (Figure 10-8)

A chat application assigns autoincrementing integer IDs to messages. Displaying messages in ID order yields sensible threads: Aaliyah's question gets ID 1, Bryce's reply gets the larger ID 3. The single-node ID generator is linearizable (an atomic fetch-and-add): if Aaliyah's post completes before Bryce's begins, Bryce's ID is greater. Concurrent messages (Aaliyah's and Caleb's) may be ordered either way. But the generator is a single point of failure, slow from other regions, and a throughput bottleneck — and the distributed alternatives (sharded ID ranges, preallocated blocks, random UUIDs, timestamp IDs like Snowflake/UUIDv7/ULID) all give up causally correct ordering.

**Demonstrates:** a single-node autoincrement counter is linearizable; every easy way to distribute it weakens ordering.

## Lamport clocks in the chat (Figure 10-9)

Same chat, now with Lamport timestamps: each timestamp is (counter, node ID). Aaliyah and Caleb post concurrently without seeing each other's messages; both stamp (1, name). Bryce sees both, raises his counter to 1, then replies with (2, "Bryce"). Comparing counter first, then node ID lexicographically: (1, "Aaliyah") < (1, "Caleb") < (2, "Bryce") — a total order consistent with causality, with no central node. (Here the equal counters reveal that Aaliyah's and Caleb's messages were concurrent; with different counters you can't tell concurrency from causation.) But the order of concurrent events is arbitrary, the counters say nothing about wall-clock time, and two nodes that never communicate can drift to wildly different counter values — limitations addressed by hybrid logical clocks (used in CockroachDB), which track physical time but jump forward and increment like Lamport clocks. Vector clocks, by contrast, can detect concurrency, at the cost of one counter per node in every timestamp.

**Demonstrates:** logical clocks give causally consistent total order without coordination — but not linearizability.

## The private photo leak (Figure 10-10)

On a social network, user A's account is public. From their laptop they set it private, then from their phone they upload an embarrassing photo, expecting the new privacy setting to apply. Account settings and photos live in separate databases stamped by Lamport/hybrid logical clocks. The photos database never read from the accounts database, so its counter lags, and the photo upload gets a *lower* timestamp than the privacy change. A stranger viewing A's profile via an MVCC snapshot whose timestamp falls between the two sees the account as still public — and sees the photo. Possible fixes: have the photos database read account state first (easy to forget), track the user's latest write timestamp on the client (breaks across two devices), or — simplest — use a linearizable ID generator so the photo provably gets a higher timestamp.

**Demonstrates:** causal ordering from logical clocks is not enough when operations flow through channels the clock never sees; linearizable ID assignment closes the hole.

## Timestamp oracle and Spanner's wait

TiDB/TiKV implement a linearizable ID generator as a *timestamp oracle* (after Google's Percolator): one node atomically increments a counter, persists it, and is replicated by single-leader replication. To avoid a disk write and replication round per ID, it persists a record covering a whole batch of IDs and hands them out from memory; a crash skips some IDs but never duplicates or reorders them. The job is so simple one node handles huge throughput — but it can't be sharded or spread across regions. Google Spanner avoids the central node: its TrueTime clocks return an uncertainty interval, and a node waits out that interval before returning a timestamp, guaranteeing real-time order across regions with no communication — at the price of GPS/atomic-clock infrastructure.

**Demonstrates:** the two practical routes to linearizable IDs — a replicated single-node counter, or tightly bounded clock uncertainty plus waiting.

## Why a logical clock can't grant a lock

Suppose nodes racing for a lock (or a username) each stamp their request with a logical clock, and the lowest timestamp wins. With a linearizable clock you know future requests get higher timestamps — but a node still can't know its timestamp is the lowest without hearing from *every* node that might have issued a lower one. If any such node has crashed or is unreachable, the whole system grinds to a halt waiting. That isn't fault-tolerant.

**Demonstrates:** ordering alone can't make fault-tolerant decisions; locks, leases, and uniqueness need consensus.

## The node buried in mud

Why does consensus termination matter? If a crashed node might recover, you could wait. But imagine an earthquake triggers a landslide that buries the datacenter — the node is under 30 feet of mud and never coming back. A consensus algorithm must still decide. This is why termination requires only that a *majority* of nodes survive, and why algorithms can't block on any single node.

**Demonstrates:** fault tolerance means progress despite permanently dead nodes, bounded by the majority requirement.

## Fetch-and-add has consensus number 2

Try solving consensus with an atomic counter: every proposer does fetch-and-add; whoever reads 0 wins. The winner knows it won — but the others only know they lost, not *who* won. If the winner crashes before announcing its value, everyone else hangs forever; they can't pick a fallback because the winner might return and rightfully decide. Exception: with exactly two proposers who exchange proposed values first, the node reading 0 decides its own value and the node reading 1 decides the other's. So fetch-and-add solves consensus for two nodes only — consensus number 2 — while CAS and shared logs have consensus number infinity. (The reverse direction is easy: fetch-and-add can be built from CAS by reading the counter, then CAS(read value → read value + 1) in a retry loop — less efficient under contention than a native fetch-and-add, but functionally equivalent.)

**Demonstrates:** seemingly similar atomic primitives differ fundamentally in power (Herlihy's hierarchy).

## Atomic commitment built from consensus, and vice versa

Consensus → atomic commit: each transaction participant broadcasts its commit/abort vote to all nodes. A node that sees commit votes from everyone proposes "commit" via consensus; a node that sees any abort or times out proposes "abort." Everyone obeys the decided value — mixed proposals are fine because all nodes do the same thing. Atomic commit → consensus: each proposer starts a transaction across a quorum of nodes, doing a local CAS on each to claim a register for its value; CAS success → vote commit, failure → vote abort. A committed transaction decides its value; an aborted one retries. Unlike 2PC's coordinator, consensus needs only a quorum and any node can initiate.

**Demonstrates:** atomic commitment and consensus are equivalent — and consensus removes 2PC's single point of failure.

## Theater seats via a shared log

To sell each theater seat exactly once across many concurrent buyers, run one logical consensus per seat — concretely, write booking attempts as log entries that include the seat number, and the first log entry mentioning a given seat wins. The same shared log pattern yields state machine replication (replicas apply identical deterministic writes in log order), serializable transactions (deterministic stored procedures executed in log order, as in Calvin), fetch-and-add (each entry holds the number to add; counter = sum of all entries so far), and fencing tokens (a simple count of log entries — ZooKeeper's zxid is exactly this monotonically increasing log sequence number).

**Demonstrates:** a shared log is the most versatile practical form of consensus — most real systems (Raft, Zab, VSR, Multi-Paxos) expose one.

## Kafka's unclean leader election

Strict consensus demands that a new leader be up to date with all confirmed log entries before serving writes; otherwise it might overwrite entries the old leader already confirmed, violating the log's append-only property. Kafka offers a configuration called unclean leader election that lets *any* replica, even a stale one, become leader. The same situation arises in any asynchronously replicated database failover. You gain availability and faster recovery, but the theory of consensus no longer protects you: things work until a fault hits, and then data can be lost or corrupted.

**Demonstrates:** the consistency-versus-availability choice inside leader election itself; weakening it puts you on thin ice.

## Raft's flaky-link livelock

If a network works perfectly except for one persistently unreliable link, Raft can enter a pathology where leadership bounces endlessly between two nodes, or the current leader is repeatedly forced to resign — the cluster spends its time on elections instead of work. The original algorithm was extended with a pre-vote phase to fix this. Paxos's leader dependence causes similar issues; Egalitarian Paxos (EPaxos) avoids them with a leaderless protocol more robust to slow nodes and bad links.

**Demonstrates:** consensus algorithms are sensitive to partial network failures and timeout tuning; leader-based designs share a common weakness.

## Coordination services allocating work

A storage system with thousands of shards must decide which node leads each shard and rebalance when nodes join or fail. Running consensus across thousands of nodes would be hopelessly slow, so systems outsource it: a small fixed cluster (three or five nodes) of ZooKeeper/etcd holds assignments like "node 10.1.1.23 leads shard 7," using atomic operations, ephemeral nodes (leases auto-released when a client's heartbeats stop), and change notifications. Such data changes over minutes or hours, not thousands of times per second — fast-changing state belongs in a real database or Apache BookKeeper. Even with libraries like Apache Curator providing recipes, this is hard to get right, but far safer than hand-rolling consensus. Kubernetes (etcd) and Spark/Flink HA (ZooKeeper) work this way.

**Demonstrates:** outsourcing consensus to a small dedicated cluster is the standard pattern for leader election and work assignment.

## Service discovery and ZooKeeper observers

Services in cloud environments register their network endpoints in a registry at startup so others can find them; ZooKeeper, etcd, and Consul are popular choices because their failure detection and notifications track instances coming and going. But discovery rarely needs linearizability — it needs to be fast and highly available, since everything halts without it. DNS-based discovery embraces this with layers of TTL caching, accepting staleness. ZooKeeper supports the pattern with *observers*: replicas that receive the log and serve (possibly stale) reads but don't vote in consensus, adding read throughput and surviving partitions.

**Demonstrates:** using consensus where availability matters more than freshness is overkill; cache and accept staleness instead.
