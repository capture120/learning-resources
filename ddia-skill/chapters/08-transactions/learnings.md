# Chapter 8: Transactions — Core Learnings

**Central thesis:** A transaction groups several reads and writes into one logical unit that either fully commits or fully aborts, letting the application ignore partial failures and many concurrency problems. But "ACID" hides enormous variation: most databases default to weak isolation levels that still permit subtle race conditions (lost updates, write skew, phantoms), so you must know exactly what your isolation level prevents and what it leaves to you. Serializability eliminates all these races and is achievable at acceptable cost (serial execution, 2PL, or SSI), while distributed atomic commit (2PC) is a separate, harder problem with real operational risks.

## What ACID Actually Means

- **Atomicity** = abortability, not concurrency. If a fault happens mid-transaction, all writes so far are discarded; the application can safely retry. ("Abortability" would have been a better name.)
- **Consistency** = application-defined invariants (e.g., credits and debits balance) hold at commit time; an invariant may be temporarily violated mid-transaction. It is mostly a property of the application, not the database. Enforce what you can with declared constraints (foreign-key, uniqueness, check), triggers, or materialized views; the rest is on your transaction logic. (Beware: "consistency" has at least five meanings — replica/eventual consistency, a consistent snapshot per the happens-before relation, consistent hashing, CAP's consistency = linearizability, and ACID consistency.)
- **Isolation** = concurrent transactions cannot step on each other. Textbook ideal is serializability; in practice most databases use weaker levels. Oracle's "serializable" is actually snapshot isolation.
- **Durability** = committed data survives crashes. Single node: fsync to disk + write-ahead log + checksums. Replicated: copied to N nodes before acking commit.
- "ACID compliant" is mostly a marketing term; one database's ACID is not another's. BASE ("basically available, soft state, eventual consistency") just means "not ACID."
- The NoSQL-era belief that transactions can't scale was wrong: NewSQL systems (CockroachDB, TiDB, Spanner, FoundationDB, YugabyteDB) provide ACID at scale by combining sharding with consensus. Spanner's authors argue it's better to give programmers transactions and let them deal with performance bottlenecks as they arise than to always code around the lack of transactions.

### Durability is risk reduction, not a guarantee
- The meaning of durability has shifted over time: archive tape → disk/SSD → replication. None is strictly better.
- Disk-only durability: data survives but is unavailable until the machine is fixed. Replication keeps it available, but correlated faults (power outage, a bug crashing every node) can lose in-memory data on all replicas at once — so disk writes still matter for replicated systems.
- Asynchronous replication loses recent writes on leader failure.
- fsync can fail or lie: SSDs violate guarantees on power loss; PostgreSQL used fsync incorrectly for over 20 years; one firmware bug killed drives at exactly 32,768 power-on hours.
- 30–80% of SSDs develop at least one bad block in their first four years; HDDs have fewer bad sectors but fail completely more often. Worn-out SSDs left unpowered can lose data within weeks to months.
- Silent on-disk corruption can spread to replicas and recent backups; you may need historical backups.
- **Rule:** combine disk writes, remote replication, and backups. Trust no single mechanism.

## Single-Object vs Multi-Object Operations

- Storage engines almost universally give atomicity + isolation for a single object on one node (log for crash recovery, per-object lock). A half-written 20 kB JSON value should never be observable.
- Atomic single-object operations (increment, compare-and-set/conditional write) prevent lost updates on one object, but they are not transactions. Cassandra/ScyllaDB "lightweight transactions" and Aerospike "strong consistency" offer linearizable reads and conditional writes on a single object only. (Terminology nit: "atomic increment" uses atomic in the multithreaded sense; in ACID terms it would properly be an *isolated* increment.)
- You need multi-object transactions when: foreign-key/graph references must stay valid; denormalized data must stay in sync with its source; secondary indexes must be updated together with the row (an index is a separate object — without isolation a record can appear in one index but not another).
- Relational databases scope a transaction to a TCP connection (BEGIN…COMMIT); if the connection is interrupted, the transaction must be aborted. Many non-relational multi-put APIs are NOT transactional: some keys can succeed while others fail.

### Retrying aborted transactions — gotchas
- ORMs (ActiveRecord, Django) typically don't retry aborts; the exception just bubbles up and user input is lost. Retry is the whole point of aborts — implement it.
- If the commit succeeded but the ack was lost, a retry executes the transaction twice — need application-level deduplication.
- If the error is from overload, retries make it worse: cap retry counts, use exponential backoff, treat overload errors specially.
- Only retry transient errors (deadlock, isolation violation, network blip, failover) — never permanent ones (constraint violation).
- Side effects outside the database (e.g., email) can happen even when the transaction aborts; if multiple systems must commit together, that's 2PC territory.
- If the client process itself crashes while retrying, any data it was trying to write is lost.
- Leaderless-replication datastores are "best effort": they won't undo partial work; recovery is the application's job.

## Weak Isolation Levels

Concurrency bugs are timing-dependent, hard to test for, and have caused real money loss (bankrupted a Bitcoin exchange, triggered financial-audit investigations). Even "ACID" relational databases default to weak isolation. Attackers can deliberately exploit race conditions with bursts of concurrent requests (ACIDRain) — so prevention must be systematic, not probabilistic.

### Read committed
Guarantees: **no dirty reads** (see only committed data) and **no dirty writes** (overwrite only committed data). Default in Oracle, PostgreSQL, SQL Server, and many others.
- Dirty reads would expose partial updates and data that later rolls back (cascading aborts).
- Dirty writes interleave conflicting multi-row writes from two transactions (e.g., one buyer recorded on the listing, the other gets the invoice).
- Implementation: row-level write locks held until commit/abort prevent dirty writes. Dirty reads are usually prevented by remembering both old committed value and uncommitted new value, serving the old one to readers. Read locks would also work but stall all readers behind one long writer; some databases use them anyway (IBM Db2, SQL Server with `read_committed_snapshot=off`).
- Read uncommitted (weaker): prevents dirty writes only. Cheaper (no second row version needed) and reduces the probability of lost updates without preventing them.
- Read committed does NOT prevent: read skew, lost updates, write skew, phantoms. The counter-increment race (two read-modify-writes interleave, one increment lost) is allowed.

### Snapshot isolation (a.k.a. "repeatable read")
Each transaction reads from a consistent snapshot of the database as of its start. Essential for long-running reads: backups, analytics, integrity checks — anything that scans a lot of data would otherwise see different parts at different points in time, and an inconsistent backup makes anomalies permanent.

- **MVCC (multiversion concurrency control):** keep several committed versions of each row. In PostgreSQL each row version carries `inserted_by` / `deleted_by` transaction IDs; an update = delete + insert; garbage collection (vacuum) reclaims invisible versions. (PostgreSQL txids are 32-bit and wrap after ~4 billion transactions; vacuum handles this.)
- **Visibility rules:** ignore writes from transactions in progress at your start, from transactions with later IDs, and from aborted transactions. Everything else is visible. A row is visible iff its inserter committed before your transaction started and its deleter (if any) had not. (A side benefit of the aborted-transactions rule: an abort needn't remove its rows immediately — the filter hides them and GC cleans up later.)
- All versions of a row live in the same heap regardless of commit status, chained as a linked list that queries iterate to find a visible version. Implementation details matter for performance: PostgreSQL avoids index updates when row versions fit on the same page; some databases store only diffs between versions to save space.
- Key performance principle: **readers never block writers, writers never block readers.** Writers still take write locks against each other (no dirty writes).
- Indexes: entries point at one version; queries follow the version chain to find a visible row. Alternative: immutable copy-on-write B-trees (CouchDB, Datomic, LMDB) where every write batch creates a new root = a snapshot; no txid filtering needed.
- Adoption: PostgreSQL, MySQL/InnoDB, Oracle, SQL Server all support variants. Some databases (Oracle, TiDB, Aurora DSQL) offer snapshot isolation as their *highest* isolation level, and cloud data warehouses like BigQuery use it for point-in-time analytical queries.
- **Naming chaos:** snapshot isolation is called "repeatable read" in PostgreSQL, "serializable" in Oracle. MySQL's "repeatable read" is weaker than true snapshot isolation (doesn't detect lost updates). Db2's "repeatable read" means serializable. The SQL standard predates snapshot isolation (based on System R, 1975) and its isolation definitions are ambiguous — never trust the level name; check the actual guarantees (e.g., with the Hermitage test suite). Repeatable read has been formally defined in research literature, but most implementations don't satisfy that definition — in practice nobody really knows what "repeatable read" means.

### Preventing lost updates
Lost update = two concurrent read-modify-write cycles; the later write clobbers the earlier. Occurs with counters, balances, JSON-document edits, full-page wiki saves. Solutions, in order of preference:
1. **Atomic write operations** (`UPDATE counters SET value = value + 1 …`, MongoDB document operators, Redis data-structure ops). Best when expressible. Implemented via an exclusive lock on the object when read, or by running all atomic operations on a single thread. Beware: ORMs make it easy to write unsafe read-modify-write instead.
2. **Explicit locking** — `SELECT … FOR UPDATE` then update in the same transaction. Needed when application logic must validate (e.g., game rules). Risk: forgetting a lock somewhere; deadlocks (database detects and aborts one; you retry).
3. **Automatic lost-update detection** — let them run in parallel, abort the loser. PostgreSQL repeatable read, Oracle serializable, SQL Server snapshot do this; **MySQL/InnoDB repeatable read does NOT** (arguably therefore not true snapshot isolation). Less error-prone since no special code, but you must retry aborts.
4. **Conditional write / compare-and-set** — `UPDATE … WHERE id = ? AND content = <old>` or a version-number column ("optimistic locking"). For databases without transactions. Check affected-row count and retry. Caveat: under MVCC the concurrently written new value may not be visible to your snapshot; many implementations make an exception so the WHERE clause of UPDATE/DELETE sees other transactions' latest committed writes, but whether this technique is safe depends on the database implementation.
5. **Replicated/multi-leader/leaderless systems:** locks and CAS assume a single up-to-date copy — they don't apply. Use commutative operations / CRDTs and merge siblings. Last-write-wins (the common default) loses updates.

### Write skew and phantoms
**Write skew** generalizes lost update: two transactions read the same objects, then update *different* objects, jointly violating an invariant (both on-call doctors go off call; two bookings for one room; balance goes negative from two concurrent spends). Neither dirty write nor lost update; snapshot isolation does NOT prevent it, and no popular weak level auto-detects it. In the special case where both transactions update the *same* object, write skew degenerates into a dirty write or lost update, depending on timing. ORM-generated SQL is also prone to write skew ("feral concurrency control").

The common pattern: (1) SELECT checks a requirement; (2) application decides based on the result; (3) a write changes the very rows the SELECT depended on. Repeating the SELECT after commit would give a different answer. (The steps can occur in a different order — e.g., write first, then SELECT, then decide whether to commit or abort.)

**Phantom:** a write in one transaction changes the result of a search query in another. When step 1 checks for the *absence* of rows (room free, username untaken), there's nothing for `SELECT FOR UPDATE` to lock — phantoms make write skew especially hard.

Options against write skew:
- True serializable isolation (the only general automatic fix).
- A database constraint if one fits (uniqueness solves the username race cleanly; multi-object constraints usually aren't supported — maybe triggers/materialized views).
- `SELECT FOR UPDATE` on the rows the decision depends on — works only when those rows exist (doctors example yes; empty-result checks no).
- **Materializing conflicts:** create rows purely to lock (e.g., a pre-populated table of room × 15-minute time slots; lock the slots, then check and insert). Last resort: error-prone and leaks concurrency control into the data model.

## Serializability

Strongest level: outcome equals some serial order, so all the above races are impossible. If transactions are individually correct, they remain correct concurrently. Researchers have said "use serializable isolation!" since the 1970s because weak levels are a losing game: they're inconsistently implemented across databases, you can't tell by reading application code whether it's safe at a given level (especially in large apps where you don't know what else runs concurrently), and there are no practical tools for detecting race conditions (static analysis exists in research but hasn't reached practice; testing is defeated by nondeterministic timing). Three implementation families:

### 1. Actual serial execution
Run transactions one at a time on a single thread (VoltDB/H-Store, Redis, Datomic). Feasible since ~2000s because RAM got cheap (active dataset in memory) and OLTP transactions are short; long analytics run on a snapshot outside the loop.
- Disallows interactive multi-statement client/server transactions: a single-threaded loop can't afford network round trips per statement. Transactions must either contain a **single statement** or be submitted ahead of time as a **stored procedure** (in the SQL standard as SQL/PSM since 1999). Modern stored procedures use general-purpose languages (VoltDB: Java/Groovy; Redis: Lua; Datomic: Java/Clojure; MongoDB: JavaScript).
- Historic stored-procedure pain: vendor languages (PL/SQL etc.), hard to version/debug/monitor, a bad procedure hurts a shared database more than bad app-server code, untrusted tenant code is a security risk.
- VoltDB also replicates by running the same stored procedure on each replica — procedures must be deterministic (state machine replication; e.g., date/time via special APIs).
- Scaling: shard so each transaction touches one shard → linear scaling per core. Cross-shard transactions need lockstep coordination: VoltDB reports ~1,000 cross-shard writes/sec, orders of magnitude below single-shard, and adding machines doesn't help. Whether transactions can be single-shard depends on data structure: simple key-value data shards easily; data with multiple secondary indexes likely forces heavy cross-shard coordination.
- Constraints: every transaction small and fast (one slow transaction stalls everything); active dataset fits in memory; write throughput within one core or cleanly shardable.

### 2. Two-phase locking (2PL)
The classic approach (~30 years the only option), sometimes called strong strict two-phase locking (SS2PL) to distinguish it from other 2PL variants. Shared lock to read, exclusive to write (a transaction that reads then writes upgrades its shared lock to exclusive); readers block writers AND writers block readers (opposite of snapshot isolation's mantra). Locks held until commit/abort: growing phase acquires, shrinking phase releases — hence "two-phase"; once any lock is released, no new locks may be acquired. Used by MySQL/InnoDB and SQL Server serializable, Db2 repeatable read. (2PL ≠ 2PC — completely different things.)
- **Predicate locks** prevent phantoms: lock all objects matching a search condition, including rows that don't exist yet. Pure predicate locks are too slow to check.
- **Index-range (next-key) locks**: approximate the predicate by locking a wider but indexed range (all bookings for room 123, or all rooms noon–1pm). Safe because broader; cheap because attached to index entries. No suitable index → fall back to locking the whole table.
- Performance: poor throughput and unstable tail latency under contention — the cost is partly lock bookkeeping but mostly reduced concurrency. One slow or lock-heavy transaction (e.g., a full-table read needing a shared table lock) can stall the whole system; transaction timeouts and slow-query monitoring are used to detect and limit misbehaving queries. Deadlocks happen even under lock-based read committed but are far more frequent under 2PL; aborted work is wasted.

### 3. Serializable snapshot isolation (SSI)
Optimistic concurrency control on top of snapshot isolation (first described 2008). Transactions proceed without blocking; at commit, the database checks whether serializability was violated and aborts if so. Used by PostgreSQL serializable, SQL Server Hekaton, HyPer, CockroachDB, FoundationDB, BadgerDB.
- Core insight: write skew = acting on an **outdated premise**. The database must detect when a query result a transaction read may have changed before it commits. Two cases:
  1. **Stale MVCC reads:** the snapshot ignored a write that was uncommitted at the time; if that writer commits first, abort the reader at its commit time. (Wait until commit because the reader might be read-only, or the writer might abort — avoids unnecessary aborts.)
  2. **Writes affecting prior reads:** track which transactions read which index ranges (like index-range locks, but non-blocking "tripwires"); a write notifies prior readers; whoever commits second aborts. With no suitable index, reads are tracked at table level. Read-tracking data is kept only until the transaction and all concurrent transactions finish.
- Pessimistic (2PL, serial execution) vs optimistic (SSI): 2PL is like mutual exclusion in multithreaded programming; serial execution is pessimism taken to the extreme — effectively an exclusive lock on the entire database (or shard), compensated by making each transaction very fast. Optimistic concurrency control is an old, long-debated idea; it wins with spare capacity and low contention, loses under high contention (abort storms — retries add load when you can least afford it). Commutative atomic operations (e.g., increments not read in-transaction) reduce contention.
- vs 2PL: no blocking on locks → predictable latency, great for read-heavy workloads. vs serial execution: not limited to one core; FoundationDB distributes conflict detection across machines.
- Tracking granularity is a tradeoff: fine-grained = precise but expensive bookkeeping; coarse = faster but more false aborts. PostgreSQL uses theory about when overwritten reads are still serializable to cut false aborts.
- Keep read/write transactions short — long ones likely conflict and abort (long read-only transactions on a snapshot are fine). Still, SSI is less sensitive to slow transactions than 2PL or serial execution.
- How significant SSI's checking overhead is vs plain snapshot isolation remains debated: some argue serializability checking isn't worth it; others argue serializable performance is now so good there's no reason to use weaker snapshot isolation at all.

## Distributed Transactions

With single-leader replication, transaction execution (including concurrency control) happens only on the leader; followers just apply the committed write log. True distributed transactions arise when a transaction spans multiple shards or a global secondary index on another node. Concurrency control distributes straightforwardly (serial execution per shard, distributed 2PL, distributed SSI). **Atomic commitment** is the hard part. On a single node it's simple: the storage engine durably writes the data, then a commit record, to the log — the instant the disk finishes writing the commit record is the commit point, and a single device (one disk controller) makes it atomic. Across nodes there is no such single device: sending commit to all nodes independently fails because some may commit while others abort (constraint violation on one node, lost messages, crash before commit record). Once one node commits, you can't retract — other transactions may have read the committed data. All-or-nothing across nodes = the atomic commitment problem.

### Two-phase commit (2PC)
A coordinator (transaction manager — often a library inside the application process; e.g., Narayana, JOTM, BTM, MSDTC) runs the protocol over participants:
1. Application gets a globally unique transaction ID; runs single-node transactions on each participant tagged with it.
2. Phase 1 — **prepare**: each participant durably writes everything needed to commit under any circumstance, checks constraints, and by voting "yes" **surrenders the right to abort** (crash, power loss, full disk are no excuse).
3. Coordinator decides; writes the decision to its own log on disk — the **commit point** (a single-node atomic commit on the coordinator).
4. Phase 2 — commit/abort sent to all; coordinator **retries forever** until acknowledged. A crashed participant that voted yes must commit on recovery.

Two points of no return: a participant's yes vote, and the coordinator's logged decision.

**Coordinator failure is the Achilles heel.** A participant that voted yes is **in doubt**: it cannot unilaterally commit or abort (either could diverge from other participants) and must wait for the coordinator to recover and read its log. (Participants could in principle vote among themselves, but 2PC includes no such protocol.) 2PC is therefore a *blocking* protocol. If the coordinator's log is lost, only a human can resolve in-doubt transactions; if just the tail of the log is lost, the recovering coordinator may try to abort transactions that already committed elsewhere, violating atomicity.

**Why in-doubt is so bad:** the participant must keep holding its row locks (exclusive on writes; shared on reads under 2PL) across the entire in-doubt period — even across restarts. A 20-minute coordinator outage = 20 minutes of blocked rows; a lost log = blocked forever pending manual resolution. Large parts of an application can become unavailable.

**Three-phase commit (3PC)** is nonblocking only under bounded network delay and bounded process pauses — assumptions real systems can't make, so it can't guarantee atomicity in practice. The real fix: replace the single-node coordinator with a fault-tolerant consensus protocol (Chapter 10).

Performance cost of 2PC: extra fsyncs (prepare on each participant, decision on coordinator) and extra network round trips.

### Heterogeneous (XA) vs database-internal distributed transactions
- **XA (eXtended Architecture, 1991)**: standard for 2PC across different technologies (databases + message brokers; Java's JTA; WS-AtomicTransaction for SOAP web services). Widely implemented: PostgreSQL, MySQL, Db2, SQL Server, Oracle; brokers ActiveMQ, HornetQ, MSMQ, IBM MQ. Not a network protocol — a C API into a coordinator library, usually loaded inside the application process; the coordinator's local-disk log becomes critical durable state, as important as the databases themselves.
- XA failure modes: if the application server dies, all its prepared transactions are stuck in doubt until that server restarts and the library reads the log; participants can't contact the coordinator directly. Orphaned in-doubt transactions (corrupted/lost logs) sit forever holding locks; "heuristic decisions" let a participant unilaterally commit/abort — a euphemism for probably breaking atomicity, for emergencies only.
- XA is a lowest common denominator: no cross-system deadlock detection (would need a standardized lock-exchange protocol), incompatible with SSI (would need cross-system conflict identification). The coordinator is a single point of failure, and so is the application code driving it — even a replicated coordinator wouldn't fix XA, because coordinator and participants can only communicate through the application code; fixing that would mean making application code replicated/restartable (durable-execution style), which no tools do in practice. Many cloud services refuse to implement distributed transactions for these operational reasons.
- **Database-internal** distributed transactions (CockroachDB, TiDB, Spanner, FoundationDB, YugabyteDB, VoltDB, Cassandra, MySQL NDB; Kafka internally) also use 2PC but avoid XA's problems: replicated coordinator with automatic failover (consensus), direct coordinator↔shard communication, replicated participants, and concurrency control integrated with atomic commit (deadlock detection, consistent cross-shard reads). Snapshot isolation and SSI both achievable across shards. These can work well.

### Exactly-once without distributed transactions
2PC's marquee use case — acknowledge a queue message iff its database transaction committed — can be done with database-local transactions plus idempotence:
1. Keep a processed-message-IDs table. In one local transaction: check the ID (drop+ack if present), insert it, do the processing writes, commit.
2. Ack the message to the broker only after commit; delete the ID later.
Crash before commit → broker redelivers, transaction rolled back. Crash between commit and ack → redelivery hits the dedup check. A uniqueness constraint on the ID table guards concurrent redelivery. Side effects that can't roll back (e.g., sending email) break exactly-once under any scheme unless that system also participates in atomic commit.
Internal distributed transactions still help scale this pattern (message IDs on one shard, data on others).

## Decision Guidance (condensed)

- Single-record read/write apps may not need transactions; multi-object invariants, denormalization, and secondary indexes are the signals that you do.
- Default read committed is enough only if you have no read-modify-write cycles, no multi-row invariants, and no long scans.
- Long-running read-only work (backups, analytics, integrity checks) → snapshot isolation, always.
- Counter/balance updates → atomic write operations; if logic is needed → SELECT FOR UPDATE; if the database can detect lost updates, rely on it (but verify — MySQL doesn't).
- Any "check then act" pattern (especially checking for absence) → assume write skew; use serializable isolation, or a uniqueness constraint if one fits; materialize conflicts only as a last resort.
- Choosing a serializability implementation: in-memory data + short shardable transactions → serial execution; high contention where blocking beats abort storms → 2PL; otherwise SSI for predictable latency and scalability.
- Avoid XA/heterogeneous 2PC if you can; prefer idempotent processing with local transactions, or a database-internal distributed transaction system. If you must use 2PC, plan for in-doubt transactions holding locks and have a manual-resolution runbook.
- Never trust an isolation level by name; test the actual anomalies (Hermitage).

## Anomaly × Isolation Level Summary

| Isolation level | Dirty reads | Read skew | Phantom reads | Lost updates | Write skew |
|---|---|---|---|---|---|
| Read uncommitted | possible | possible | possible | possible | possible |
| Read committed | prevented | possible | possible | possible | possible |
| Snapshot isolation | prevented | prevented | prevented | depends on impl. | possible |
| Serializable | prevented | prevented | prevented | prevented | prevented |

(Dirty writes are prevented by essentially all implementations.)

## Named Things Worth Remembering

- Anomalies: dirty read, dirty write, read skew (nonrepeatable read), lost update, write skew, phantom.
- Techniques: MVCC, copy-on-write B-trees, SELECT FOR UPDATE, optimistic locking (version column), compare-and-set, materializing conflicts, predicate locks, index-range (next-key) locks, 2PL, SSI, stored-procedure serial execution, state machine replication, 2PC, 3PC, XA/JTA, heuristic decisions, idempotent message processing.
- Numbers: ~1,000 cross-shard writes/sec in VoltDB; PostgreSQL 32-bit txids wrap at ~4 billion; SSI first described 2008; ACID coined 1983; System R defined the model in 1975 (today's MySQL/PostgreSQL/Oracle/SQL Server transactions are uncannily similar 50 years later); stored procedures in the SQL standard (SQL/PSM) since 1999; XA standard 1991; 30–80% of SSDs develop a bad block within four years; drives that failed at 32,768 hours.

## How This Connects

- **Chapter 2 (reliability/performance):** overload-aware retry policies; tail latency under 2PL; "perfect durability does not exist."
- **Chapter 3 (data models):** denormalization in document models creates the multi-object update problem.
- **Chapter 4 (storage):** write-ahead logs and B-tree crash recovery implement single-node atomicity/durability.
- **Chapter 6 (replication):** replicated durability; multi-leader/leaderless conflict resolution, CRDTs, and LWW replace lock-based lost-update prevention; leaderless stores' best-effort writes.
- **Chapter 7 (sharding):** secondary indexes across shards motivate distributed transactions; single-shard design enables serial execution scaling.
- **Chapter 9 (distributed system faults):** unbounded delay and process pauses are why 3PC fails and 2PC blocks.
- **Chapter 10 (consistency & consensus):** consensus replaces the single-node 2PC coordinator; linearizability for single-object guarantees; CAP's "consistency."
- **Chapter 12 (stream processing):** exactly-once semantics via idempotence (Kafka Streams).
- **Chapter 13:** alternative approaches for applications without transactions.
