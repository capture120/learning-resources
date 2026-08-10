# Chapter 7: Sharding — Examples and Case Studies

Every meaningful example, scenario, and worked illustration from the chapter, retold compactly.

## Leader-per-shard layout (Figure 7-1)

A cluster combines sharding with single-leader replication. Each shard has exactly one leader, placed on some node, with its followers on other nodes. Any given node is leader for some shards and follower for others, so leadership duties spread across the cluster rather than concentrating on one "leader node."

**Demonstrates:** sharding and replication are orthogonal; a record belongs to one shard but lives on several nodes.

## The "shard" name from Ultima Online

One origin theory: in the game Ultima Online, a magic crystal shattered into shards, each refracting a copy of the game world. "Shard" came to mean one of a set of parallel game servers and migrated to databases. A rival theory says it was an acronym, System for Highly Available Replicated Data, from a lost 1980s database.

**Demonstrates:** terminology trivia; "shard" = one parallel slice of a system.

## PostgreSQL: partitioning vs sharding

PostgreSQL treats the two terms differently. Partitioning splits a large table into multiple files on the *same* machine (e.g., enabling fast deletion of an entire partition). Sharding splits the dataset across *multiple* machines. Many other systems use "partition" simply as a synonym for shard.

**Demonstrates:** the same words mean different things in different systems; check vendor definitions.

## One process per core: Redis, VoltDB, FoundationDB

These systems shard even within a single machine: one single-threaded process per CPU core, with sharding spreading load across the cores. This exploits CPU parallelism and NUMA architectures, where some memory banks are closer to one CPU than others.

**Demonstrates:** sharding is a parallelism tool, not only a multi-machine scaling tool.

## Email marketing service as a multitenant system

In an email marketing SaaS product, each business that signs up is a tenant: its newsletter sign-ups and delivery data are self-contained and separate from other businesses' data. Giving each tenant its own shard (or grouping small tenants into shared shards) yields resource isolation, permission isolation, per-tenant backup/restore, simple GDPR/CCPA export-and-delete, data-residency placement, and tenant-by-tenant schema rollouts.

**Demonstrates:** tenant boundaries are natural shard boundaries in SaaS systems.

## The print encyclopedia (Figure 7-2)

A paper encyclopedia is key-range sharded: each volume covers a contiguous alphabetical range of entry titles, so you can pick the right volume straight off the shelf for any title. Crucially, the ranges are not evenly spaced — volume 1 covers only A–B while volume 12 covers T–Z — because entries aren't uniformly distributed over the alphabet. Fixed "two letters per volume" boundaries would produce wildly unequal volumes.

**Demonstrates:** key-range sharding gives fast key lookup and ordered data, but boundaries must adapt to the actual key distribution.

## Sensor network with timestamp keys

An application stores sensor measurements keyed by timestamp. Range scans are great for "all readings from March." But with key-range sharding, each shard covers a time range, so live writes all land in the current month's shard — one shard takes the full write load while the rest idle. The fix is reordering the key to `(sensorID, timestamp)`: with many active sensors, writes spread across shards. The cost: a query for several sensors over a time window now needs a separate range query per sensor.

**Demonstrates:** the classic monotonic-key hot-spot, and the write-spread vs read-convenience trade-off in key design.

## Hash functions fit (and unfit) for sharding

MongoDB hashes partition keys with MD5; Cassandra and ScyllaDB use Murmur3 — no cryptographic strength needed, just uniform spreading of skewed input. But language built-in hashes can betray you: Java's `Object.hashCode()` and Ruby's `Object#hash` may return different values for the same key in different processes, so different nodes would disagree about which shard a key belongs to.

**Demonstrates:** a sharding hash must give the same output for the same key everywhere; uniformity matters, cryptographic strength doesn't.

## Hash mod N rebalancing disaster (Figure 7-3)

Assign keys to nodes with `hash(key) % N`. (Intuition: writing the hash as a decimal number, `hash % 10` is just its last digit.) With 3 nodes, node 0 holds hashes 0, 3, 6, 9, ... Add a fourth node and recompute mod 4: hash 3 moves to node 3, hash 6 to node 2, hash 9 to node 1, and so on — most keys relocate. The mod-N function is trivial to compute but rebalancing moves far more data than necessary.

**Demonstrates:** why naive hash-mod-node-count fails; rebalancing schemes should minimize data movement.

## 1,000 shards on 10 nodes (Figure 7-4)

Create far more shards than nodes up front: a 10-node cluster split into 1,000 shards, 100 per node, keyed by `hash(key) % 1000`. Adding a node means reassigning some whole shards to it until the distribution is fair again; removing a node reverses this. The key→shard mapping never changes — only shard→node placement. While a shard transfers over the network, the old placement keeps serving reads and writes. Choose a shard count with many divisors so it splits evenly across many cluster sizes, and give powerful nodes more shards. Used by Citus, Riak, Elasticsearch, Couchbase. If you outgrow the shard count, resharding is expensive and may require downtime.

**Demonstrates:** the fixed-shard-count strategy — cheap whole-shard moves at the cost of guessing the right count up front.

## Hash-range shards over a 16-bit hash space (Figure 7-5)

Using a 16-bit hash (0–65,535; the 16 bits are for illustration — real systems usually use 32-bit or larger hashes), assign each shard a contiguous range of *hash values*: 0–16,383 to shard 0, 16,384–32,767 to shard 1, etc. Even near-identical keys (consecutive timestamps) hash to uniformly scattered values, eliminating nearby-key hot spots. Shards split when too big or too hot, so the count adapts to data volume. Range queries on the partition key become inefficient, but with composite keys, range queries on the columns after the partition key still hit one shard.

**Demonstrates:** hash-range sharding combines adaptive splitting with uniform load, sacrificing partition-key range scans.

## Data warehouse clustering: BigQuery, Snowflake, Delta Lake

Data warehouses use the same partition-then-sort pattern under different names. In BigQuery, the partition key picks the partition and "cluster columns" sort records within it. Snowflake auto-assigns records to micro-partitions and lets users define cluster keys. Delta Lake supports manual and automatic partition assignment plus cluster keys. Clustering improves range scans, compression, and filtering.

**Demonstrates:** partition key for placement + sort key within partition is a general pattern beyond OLTP stores.

## Cassandra/ScyllaDB random-boundary token ranges (Figure 7-6)

The hash space is split into contiguous ranges with *random* boundaries, several ranges per node (default 16 in Cassandra, 256 in ScyllaDB). Individual ranges vary in size, but with many ranges per node the imbalances average out. When node 3 joins a 2-node cluster, node 1 hands over parts of two of its ranges and node 2 part of one range, giving the newcomer a roughly fair share while transferring no more data than necessary.

**Demonstrates:** a practical consistent-hashing variant — fair rebalancing with minimal data movement.

## The celebrity hot key

On a social network, a celebrity with millions of followers posts something, triggering a storm of reads and writes to a single partition key (the celebrity's user ID or the post's ID). Hashing doesn't help: the load concentrates on one key, so one shard saturates while others idle. Range-based schemes can isolate the hot key in its own shard, even on a dedicated machine. (The chapter's citation here is a 2010 Mashable article titled "3% of Twitter's Servers Dedicated to Justin Bieber"; the figure comes from that title, not the chapter text.)

**Demonstrates:** uniform key distribution does not mean uniform load; skew comes from the workload, not the hash.

## Salting a hot key with two random digits

For a known-hot key, append or prepend two random digits at write time. Writes spread evenly across 100 derived keys that can land on different shards. But reads must now fetch and merge all 100 keys — read load per shard is not reduced, only writes are split. You also need bookkeeping: salt only the few hot keys (salting everything adds pointless overhead), track which keys are split, and have a process to convert a regular key into a managed hot key. Complications: virality fades after days, and some keys are read-hot rather than write-hot, needing different handling. Cloud systems automate this (Amazon's heat management, DynamoDB adaptive capacity).

**Demonstrates:** application-level skew mitigation, its read penalty, and its operational bookkeeping cost.

## Rebalancing-triggered cascading failure

One node, overloaded, responds slowly. The other nodes conclude it's dead and automatically rebalance, moving its shards away — which adds data-transfer and serving load to the network and remaining nodes, worsening the situation. Now other nodes slow down, get falsely declared dead too, and the failure cascades.

**Demonstrates:** automatic rebalancing plus automatic failure detection can amplify overload into cluster-wide failure; a human in the loop prevents operational surprises.

## Preemptive manual rebalancing for known surges

Before predictable traffic spikes — Cyber Monday sales, World Cup ticket sales — operators rebalance manually in advance rather than letting the system react under fire.

**Demonstrates:** manual control lets you rebalance when the system is calm instead of during the surge.

## Three request-routing architectures (Figure 7-7)

(1) Clients contact any node via a round-robin load balancer; a node owning the shard answers directly, otherwise it forwards the request and relays the reply. (2) All requests go through a dedicated routing tier — a shard-aware load balancer that forwards but doesn't serve. (3) Clients themselves know the shard-to-node assignment and connect directly. All three must answer: who decides placement (and how to make that coordinator fault-tolerant without split brain), how routers learn of changes, and what happens to in-flight requests during a shard-move cutover.

**Demonstrates:** the design space for routing requests in a sharded system.

## ZooKeeper-style coordination (Figure 7-8)

Nodes register in ZooKeeper, which holds the authoritative shard→node mapping; routing tiers and shard-aware clients subscribe and get notified on every ownership change. Consensus inside ZooKeeper provides fault tolerance and split-brain protection. HBase and SolrCloud use ZooKeeper; Kubernetes uses etcd for instance placement; MongoDB uses its own config servers with mongos routers; Kafka, YugabyteDB, TiDB, and ScyllaDB embed Raft instead. Riak instead gossips cluster state among nodes — weaker consistency, split brain possible, tolerable because leaderless systems already make weak guarantees. Client-to-router IP discovery just uses DNS, since those addresses change slowly.

**Demonstrates:** concrete coordination patterns for tracking shard assignments, and the consensus-vs-gossip trade-off.

## Used-car website: local secondary indexes (Figure 7-9)

A used-car listing site shards by listing ID (IDs 0–499 in shard 0, 500–999 in shard 1, ...). Users filter by color and make, so each shard maintains its own secondary indexes over only its own listings: adding a red car to shard 1 appends its ID to shard 1's `color:red` postings list. Writes touch one shard. But a search for all red cars must query every shard and merge results, because red cars sit in both shard 0 and shard 1 — scatter/gather, prone to tail-latency amplification, and adding shards doesn't raise query throughput since every shard processes every query.

**Demonstrates:** local (document-partitioned) indexes — cheap writes, expensive cross-shard reads.

## Used-car website: global secondary indexes (Figure 7-10)

Same site, but now one global index covers all shards and is itself sharded *by the indexed value*: colors a–r on index shard 0, s–z on index shard 1 (makes split similarly between f and h). All red cars' IDs, from every data shard, appear under `color:red` on a single index shard, so a one-condition query reads one index shard. Costs: fetching the actual records still hits all data shards owning those IDs; an AND of two terms (color and make) may require shipping long postings lists between shards to intersect; and one write can touch many index shards, making sync hard — either distributed transactions or async updates (DynamoDB's choice, so global-index reads can be stale).

**Demonstrates:** global (term-partitioned) indexes — cheap single-term reads, expensive multi-shard writes; best when reads dominate and postings lists are short.

## Hand-rolled secondary index warning

If your store is key-value-only, you might build a secondary index yourself as a value→IDs mapping maintained in application code. Race conditions and partial write failures (some changes saved, others lost) easily drive the index out of sync with the data; you need multi-object transactions to do it safely.

**Demonstrates:** index maintenance must be atomic with data writes; don't improvise it without transactional support.
