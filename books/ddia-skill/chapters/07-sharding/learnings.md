# Chapter 7: Sharding — Core Learnings

**Central thesis:** When data volume or write throughput exceeds what a single node can handle, split the data into shards and spread them across nodes. The goal is to spread data and query load *evenly* (avoiding hot spots), choose a sharding scheme that fits the data's access patterns, and rebalance shards as nodes are added or removed — all while keeping requests routed to the right node. Sharding adds real complexity, so avoid it until a single machine genuinely cannot cope.

## Terminology and basics

- A **shard** (= partition in Kafka, range in CockroachDB, region in HBase/TiDB, vBucket in Couchbase, vnode in Riak, token-range in Cassandra, tablet in Bigtable/YugabyteDB/ScyllaDB) is a subset of the data. Each record belongs to exactly one shard.
- Sharding is orthogonal to replication: shards are typically also replicated, and a node can be leader for some shards and follower for others. Everything from Chapter 6 (replication) applies per-shard.
- **Mental model:** each shard is effectively a small database of its own; some systems support operations touching multiple shards, but every shard operating mostly independently is precisely what lets a sharded database scale across machines. The problem case is a write spanning several shards — if one shard's write succeeds and another's fails, you need the machinery of later chapters (Chapter 8).
- In PostgreSQL, "partitioning" means splitting a table into files on one machine; "sharding" means splitting across machines. Many systems use the terms interchangeably.
- The **partition key** decides which shard a record lives in; all records with the same partition key are in the same shard. In a key-value store it is usually the key or its first part; in a relational table it is some column (not necessarily the primary key).
- "Partitioning" has nothing to do with *network partitions* (a network fault, Chapter 9). Consistent hashing's "consistent" has nothing to do with replica consistency or ACID consistency.

## When to shard (and when not to)

- **Shard for scalability**: data size or *write* throughput too big for one node. For read throughput alone, prefer read replicas / read scaling (Chapter 6) — no sharding needed.
- Sharding is one of the main tools for **horizontal scaling** (a scale-out architecture): grow capacity by adding more (smaller) machines rather than moving to a bigger one. If each shard takes a roughly equal share, shards process their data and queries in parallel.
- Replication is useful at *both* small and large scale (it provides fault tolerance and offline operation); sharding is a heavyweight solution mostly relevant at large scale.
- **Prefer a single-shard database when one machine suffices** (and modern single machines handle a lot). Sharding adds complexity:
  - You must choose a partition key; lookups without it require an inefficient search of all shards.
  - The sharding scheme is hard to change later.
  - Works well for key-value access; harder for relational workloads needing secondary-index search or cross-shard joins.
  - Writes touching records in several shards need distributed transactions (Chapter 8), which are far slower than single-node transactions and can bottleneck the whole system.
- Sharding is also used *within* a single machine: one single-threaded process per CPU core to exploit parallelism and NUMA (Redis, VoltDB, FoundationDB).

## Sharding for multitenancy

One shard per tenant (or grouping small tenants into a shard) in SaaS systems — the shards may be physically separate databases or separately manageable portions of one larger logical database — gives:

- **Resource isolation** — one tenant's expensive operation doesn't slow others.
- **Permission isolation** — access-control bugs are less likely to leak data across physically separated tenants.
- **Cell-based architecture** — group services + storage for a tenant set into self-contained cells; faults stay inside one cell.
- **Per-tenant backup/restore** — restore one tenant without touching others (useful when a tenant accidentally deletes or overwrites important data).
- **Regulatory compliance** — GDPR/CCPA export and deletion become per-shard operations.
- **Data residence** — pin a tenant's shard to a jurisdiction.
- **Gradual schema rollout** — migrate one tenant at a time to limit blast radius (hard to do transactionally).

Challenges: assumes every tenant fits on one node (a too-big tenant forces sharding *within* the tenant); many tiny tenants → per-shard overhead, and grouping them raises the question of moving tenants between shards as they grow; cross-tenant features require cross-shard joins.

## Sharding key-value data

Goal: even spread of data *and* load — in theory, 10 nodes handle 10× the data and 10× the read/write throughput of one node (ignoring replication). Skewed sharding → a **hot shard / hot spot**; a single high-traffic key is a **hot key**. In the worst case all load lands on one node and the other 9 of 10 sit idle. The shard-assignment algorithm must be amenable to rebalancing.

### Key-range sharding

- Each shard owns a contiguous range of partition keys (like encyclopedia volumes). Range boundaries must adapt to the data distribution — they aren't evenly spaced.
- Keys stored sorted within a shard (B-tree / SSTables) → **efficient range scans**, and the key works as a concatenated index.
- Boundaries chosen manually (Vitess, a sharding layer for MySQL) or automatically (Bigtable, HBase, MongoDB range option, CockroachDB, RethinkDB, FoundationDB; YugabyteDB offers both).
- **Failure mode: hot shard from writes to nearby keys.** Timestamp keys mean all current writes hit the "this month" shard. Fix: reorder the key so a spreading element comes first (e.g., `sensorID, timestamp`) — at the cost of needing one range query per sensor for cross-sensor time-range reads.
- **Rebalancing:** split a shard when it's too big or too hot; merge adjacent small shards after deletions (analogous to a B-tree's top level). **Pre-splitting** (HBase, MongoDB) sets initial shard boundaries on an empty database but requires knowing the key distribution in advance.
- Split triggers: configured size (HBase default **10 GB**) or sustained write throughput — so a hot-but-small shard can still be split.
- Shard count adapts to data volume (good). But splitting rewrites all the shard's data into new files (like a compaction), and the shard needing a split is usually already under high load — splitting can push it over the edge.

### Hash sharding

Use when you don't need nearby keys grouped together (e.g., tenant IDs). A good hash makes skewed input uniformly distributed: a 32-bit hash maps any string to a seemingly random number in 0 to 2³² − 1, scattering even very similar inputs evenly across that range (while the same input always yields the same output).

- Hash need not be cryptographic: MongoDB uses MD5; Cassandra/ScyllaDB use Murmur3.
- **Gotcha:** language-built-in hashes (Java `Object.hashCode()`, Ruby `Object#hash`) can return different values for the same key in different processes — unusable for sharding.

**Hash mod N (number of nodes): don't.** When N changes, most keys move to a different node — massively wasteful rebalancing. We want schemes that move as little data as possible.

**Fixed number of shards:** create many more shards than nodes (e.g., 1,000 shards on 10 nodes → 100 each); key → shard via `hash(key) % num_shards`; track shard→node assignment separately.
- Rebalancing moves *whole shards* between nodes; key→shard mapping never changes. Old assignment serves reads/writes during the transfer.
- Pick a shard count divisible by many factors so it splits evenly across various node counts. Assign more shards to beefier nodes to handle mismatched hardware.
- Used by Citus (a sharding layer for PostgreSQL), Riak, Elasticsearch, Couchbase.
- Limits: can't have more nodes than shards; if the initial count was wrong, resharding is expensive (split every shard, rewrite files, lots of extra disk), and some systems can't reshard under concurrent writes → downtime. Shard size grows with total data: too-large shards make rebalancing and failure recovery expensive; too-small shards add overhead. Hard to get "just right" when dataset size is highly variable.

**Hash-range sharding:** shards own contiguous ranges of *hash values*; split/merge shards as needed, so shard count adapts to the workload. Avoids key-range's nearby-key hot spots.
- Downside: range queries over the partition key scatter across all shards. But with a composite key (partition key = first column), range queries over the *remaining* columns stay efficient within one partition key.
- Used by YugabyteDB and DynamoDB; an option in MongoDB.
- Cassandra/ScyllaDB variant: split the hash space into ranges with *random* boundaries, several per node (Cassandra default 16, ScyllaDB 256). Per-range imbalances average out across a node's many ranges. Adding a node takes partial ranges from existing nodes — a fair share without excess data movement.
- Data warehouses (BigQuery, Snowflake, Delta Lake) use the analogous pattern: partition key picks the partition, "cluster columns/keys" sort within it; clustering helps range scans, compression, and filtering.

**Consistent hashing:** any algorithm mapping keys to shards such that (1) keys spread roughly equally, and (2) when the shard count changes, as few keys as possible move. Cassandra/ScyllaDB's scheme resembles the original consistent hashing; alternatives include **rendezvous (highest-random-weight) hashing** and **jump consistent hashing**. With those alternatives a new node receives individual keys previously scattered everywhere, instead of subranges split from a few shards — which is better depends on the application.

### Skewed workloads and hot keys

Uniform key distribution ≠ uniform *load*: some keys get far more data or requests (e.g., a celebrity's user ID). Mitigations:

- Range-based schemes (key or hash ranges) can isolate a hot key in its own shard, even on a dedicated machine.
- **Key salting:** append/prepend random digits to a hot key. Two random digits split *writes* across 100 keys/shards. Costs: reads must now fan out to all 100 keys and merge (read load isn't reduced); requires bookkeeping of which keys are split and a promotion process for keys that become hot. Only worth it for the few genuinely hot keys.
- Load shifts over time (a viral post is hot for days, then cools), and write-hot vs read-hot keys need different strategies.
- Big cloud systems automate this: Amazon's "heat management" / DynamoDB "adaptive capacity."

## Operations: automatic vs manual rebalancing

- Fully automatic (e.g., DynamoDB is promoted as adding/removing shards to adapt to load within minutes) means less ops work, but is **unpredictable and risky**: rebalancing is expensive (request rerouting + bulk data movement), can overload network/nodes, and near max write throughput the split process may not keep up with incoming writes.
- **Cascading-failure gotcha:** automatic rebalancing + automatic failure detection — an overloaded node responds slowly, peers declare it dead, rebalancing dumps its load onto others, which then overload and get declared dead too.
- Middle ground: system proposes an assignment, an administrator commits it (Couchbase, Riak).
- A human in the loop is slower but prevents operational surprises; manual rebalancing also enables *preemptive* rebalancing before known traffic surges (Cyber Monday, World Cup ticket sales).

## Request routing

Problem: given a key, which node (IP:port) handles it? Like service discovery, except requests can only be served by a node holding a replica of the right shard — the router must know key→shard and shard→node mappings. Three architectures:

1. **Any node**: client contacts any node (round-robin LB); the node serves the request or forwards it to the owner and relays the reply.
2. **Routing tier**: a shard-aware load balancer forwards each request to the right node (e.g., MongoDB's `mongos`).
3. **Shard-aware client**: clients know the assignment and connect directly.

Hard sub-problems: who decides shard placement (a single coordinator is simple but must be fault-tolerant without split brain); how routers learn of assignment changes; how to handle in-flight requests to the old node during a shard-move cutover.

Implementations:
- **External coordination service** (ZooKeeper, etcd) holds the authoritative shard→node map, using consensus (Chapter 10) for fault tolerance; routers subscribe to changes. HBase and SolrCloud use ZooKeeper; Kubernetes uses etcd. MongoDB uses its own config servers + mongos.
- **Built-in Raft**: Kafka, YugabyteDB, TiDB, ScyllaDB.
- **Gossip** (Riak): weaker consistency, split brain possible — tolerable for leaderless databases that already make weak guarantees.
- Clients find router/node IPs via DNS — fine, because those change much more slowly than shard assignments.
- This per-key routing applies to sharded OLTP. Analytical databases instead aggregate/join across many shards in parallel (Chapter 11).

## Sharding and secondary indexes

Secondary indexes (search by value, not unique key) don't map neatly to shards. Key-value stores often lack them; they are standard in relational databases, common in document databases, and the raison d'être of full-text search engines (Solr, Elasticsearch). Two approaches:

### Local secondary indexes (document-partitioned)

- Each shard indexes only its own records.
- **Writes are cheap**: only the one shard holding the record is updated.
- **Reads are expensive** when you don't know the partition key: scatter/gather the query to *all* shards and merge. Prone to tail-latency amplification; adding shards adds storage capacity but **not** query throughput, since every shard processes every query. If you know the partition key, or only need *some* results, you can query one/any shard.
- Used by MongoDB, Riak, Cassandra, Elasticsearch, SolrCloud, VoltDB.
- **Gotcha:** rolling your own secondary index on a key-value store (value→IDs mapping in app code) invites race conditions and partial-write inconsistency; needs multi-object transactions (Chapter 8).

### Global secondary indexes (term-partitioned)

- One index covering all shards, itself sharded **by the indexed value (term)** — by term range or hash of term — independently of the primary data's sharding. It *must* be sharded: stored on one node it would become a bottleneck and defeat the purpose of sharding. ("Term" comes from full-text search, where it means a searchable keyword; here it generalizes to any searchable value.)
- **Reads are cheap** for single-condition queries: one index shard holds the whole postings list. But fetching the actual records still touches all shards that own those IDs, and multi-condition (AND) queries whose terms live on different shards may need to ship long postings lists over the network to intersect.
- **Writes are expensive**: one record's terms may hit many index shards, making index/data sync hard. Options: distributed transactions for atomic updates (Chapter 8), or asynchronous index updates (DynamoDB) — global index reads may then be stale, like replication lag.
- Used by CockroachDB, TiDB, YugabyteDB; DynamoDB supports both local and global.
- **Rule of thumb:** global indexes pay off when read throughput exceeds write throughput and postings lists are short.

## Decision cheat sheet

| Situation | Choice |
|---|---|
| One machine handles the load | Don't shard |
| Read throughput is the bottleneck | Read replicas, not sharding |
| Need range scans on the key | Key-range sharding |
| Sequential keys (timestamps) + heavy writes | Don't lead the key with the timestamp; prefix with a spreading field, or use hash sharding |
| Shard count predictable, simple ops | Fixed number of shards (many per node) |
| Dataset size unpredictable | Hash-range sharding with split/merge (or key-range) |
| Hot key (celebrity) | Isolate it in its own shard, or salt the key (writes only) |
| Secondary index, write-heavy | Local indexes (accept scatter/gather reads) |
| Secondary index, read-heavy, short postings lists | Global indexes (accept costly/async writes) |
| Near max write capacity | Beware automatic rebalancing; consider manual, preemptive rebalancing |

## How this connects

- **Chapter 6 (Replication):** sharding combines with replication; each shard is replicated. Read scaling can replace sharding for read-heavy loads. DynamoDB's stale global-index reads mirror replication lag.
- **Chapter 4 (Storage):** sorted keys per shard use B-trees/SSTables; shard splits resemble compactions; postings lists come from indexing; multidimensional/concatenated indexes; full-text search terms.
- **Chapter 8 (Transactions):** cross-shard writes and synchronous global-index updates need distributed transactions; hand-rolled indexes need multi-object transactions.
- **Chapter 9 (Faults):** network partitions are a distinct concept; failure-detection interplay with rebalancing.
- **Chapter 10 (Consensus):** ZooKeeper/etcd/Raft coordinate shard assignment and prevent split brain.
- **Chapter 11 (Analytics):** parallel cross-shard query execution for analytical workloads.
- **Chapter 2 context:** shared-nothing scale-out architecture.
