# Chapter 8: Transactions — Examples and Case Studies

All examples below come from the chapter, retold in plain language.

## Two clients incrementing a counter (Figure 8-1)

Two clients each read a counter (value 42), add 1 locally, and write the result back. Both read before either writes, so both write 43. Two increments happened but the counter rose by only one. The race exists because read-modify-write is not atomic; read committed isolation does not prevent it, since the second write happens after the first transaction commits.

**Demonstrates:** the lost update anomaly, the canonical read-modify-write race.

## The Post Office Horizon scandal

The chapter cites the UK Post Office Horizon scandal as an example of how transactions can prevent a lot of grief: the technical cause was probably a lack of ACID transactions in the underlying accounting system. (The scandal's background is covered in Chapter 2's discussion of reliability, which the chapter cross-references.)

**Demonstrates:** missing transactional guarantees can cause real-world catastrophe, not just engineering inconvenience.

## Email unread counter (Figures 8-2 and 8-3)

An email app denormalizes the unread-message count into its own field because `SELECT COUNT(*)` over many emails is too slow. Inserting a new email and incrementing the counter are two writes that must stay in sync. Without isolation, a user can list their mailbox between the two writes and see a new unread email while the counter still says zero (a dirty read of the email insert). Without atomicity, if the counter update fails after the email insert succeeds, the data stays permanently out of sync; an atomic transaction rolls back the insert. The book adds: if a wrong unread counter seems trivial, substitute "account balance" and "payment."

**Demonstrates:** why denormalized data needs multi-object transactions — isolation prevents observing the halfway state, atomicity prevents it persisting.

## Writing a 20 kB JSON document

A client writes a 20 kB JSON document. What if the network drops after 10 kB? What if power fails while the database is overwriting the old value on disk? What if another client reads mid-write? Storing an unparseable fragment, splicing old and new values, or exposing a partial value would all be absurd — so storage engines almost universally provide atomicity (via a crash-recovery log) and isolation (via a per-object lock) for single objects on one node.

**Demonstrates:** single-object atomicity and isolation are a near-universal baseline, distinct from multi-object transactions.

## Aaliyah and Bryce buy the same car (Figure 8-5)

A used-car site processes a sale with two writes: update the listing with the buyer, and create the invoice. Aaliyah and Bryce click "buy" simultaneously. With dirty writes allowed, the writes interleave so the listing records Bryce as the buyer while the invoice goes to Aaliyah. Read committed prevents this by making the second writer wait for the first transaction to finish.

**Demonstrates:** dirty writes mixing two transactions' multi-row updates into a nonsensical combined outcome.

## Aaliyah's vanishing $100 (Figure 8-6)

Aaliyah has $1,000 split across two accounts of $500. A transfer moves $100 between them. If she views her balances while the transfer commits, she may see the destination account before the deposit ($500) and the source after the withdrawal ($400) — $900 total, $100 apparently gone. Both values she read were committed, so read committed allows this. Reloading the page later shows correct balances.

**Demonstrates:** read skew (nonrepeatable read) — observing the database at two different points in time within one query session.

## Backups and analytics during read skew

A backup copies the whole database over hours while writes continue; parts of the backup capture older state, parts newer. Restoring it makes inconsistencies (like the vanished $100) permanent. Similarly, analytical scans and periodic integrity checks return nonsense if they observe different parts of the database at different times. Snapshot isolation — every transaction reads from the database as of one point in time — is the standard fix.

**Demonstrates:** why long-running read-only operations need snapshot isolation, not just read committed.

## PostgreSQL MVCC bank account (Figure 8-7)

Transaction 13 deducts $100 from account 2. Internally the update becomes: mark the $500 row as `deleted_by = 13` and insert a new row with $400 and `inserted_by = 13`. Concurrent transaction 12 reads account 2 and still sees $500, because visibility rules hide both the deletion and the insertion made by the later transaction 13. Garbage collection later removes versions no transaction can see.

**Demonstrates:** how MVCC implements snapshot isolation — updates as delete+insert plus visibility rules keyed on transaction IDs.

## Multiplayer game: moving a figure (Example 8-1)

Several players can move the same game figure concurrently. An atomic database operation isn't enough because the app must first validate the move against game rules — logic that can't run as a single database expression. The fix: `SELECT * FROM figures WHERE name = 'robot' AND game_id = 222 FOR UPDATE`, validate, then update the position. The lock makes concurrent movers wait. But the chapter later notes the lock doesn't stop two players moving *different* figures to the same board position — a rule violation across different rows that locking one row can't catch.

**Demonstrates:** explicit locking (SELECT FOR UPDATE) for read-modify-write with application logic, and its limits — the residual risk is write skew across different objects.

## Concurrent wiki page edits

Two users edit the same wiki page; each saves by uploading the full page content, overwriting whatever is stored. One user's changes silently vanish. Atomic operations don't fit arbitrary text edits. A conditional write helps: `UPDATE wiki_pages SET content = 'new' WHERE id = 1234 AND content = 'old'` — if the content changed since you read it, the update affects zero rows and you retry. A version-number column works the same way ("optimistic locking"). The chapter cautions the bare content-compare form may or may not be safe depending on the database's MVCC visibility rules for UPDATE's WHERE clause.

**Demonstrates:** lost updates on whole-object writes, and compare-and-set / optimistic locking as a remedy in databases without transactions.

## Doctors going off call (Figure 8-8)

A hospital requires at least one doctor on call per shift. Aaliyah and Bryce are both on call and both feel ill. Each clicks "go off call" at the same moment. Each transaction checks `currently on call >= 2` — both see 2 under snapshot isolation — and each updates *their own* row. Both commit; now zero doctors are on call. Run serially, the second transaction would have been blocked by the check. Fixes: serializable isolation, or `SELECT ... FOR UPDATE` on the on-call rows the check depends on (possible here because the checked rows exist).

**Demonstrates:** write skew — two transactions reading the same data and updating different rows, jointly breaking an invariant that neither breaks alone.

## Meeting room double-booking (Example 8-2)

To book a room, a transaction counts existing bookings overlapping the requested time; if zero, it inserts the booking. Two users booking the same room and time both see zero conflicts under snapshot isolation and both insert. SELECT FOR UPDATE can't help: the check looks for the *absence* of rows, so there is nothing to lock. Only serializable isolation guarantees no double-booking.

**Demonstrates:** a phantom causing write skew — a write changes the result of another transaction's search, and absence checks defeat row locking.

## Claiming a username

Two users simultaneously register the same username. Each transaction checks the name is free, then creates the account — unsafe under snapshot isolation for the same phantom reason as the room booking. Here, though, a uniqueness constraint on the username column is a clean fix: the second insert violates the constraint and aborts.

**Demonstrates:** when an invariant maps to a built-in constraint, the database can prevent write skew without serializability.

## Preventing double-spending

A service checks that a user's spending doesn't exceed their balance by inserting a tentative spending item, listing all items, and verifying the sum stays positive. Two concurrent spends each pass the check against the old state, and together drive the balance negative — neither transaction sees the other's insert.

**Demonstrates:** write skew in financial logic; check-then-insert patterns are unsafe under snapshot isolation.

## Materializing conflicts for room bookings

If phantoms leave nothing to lock, create something: pre-populate a table with one row per room per 15-minute slot for the next six months. A booking transaction locks (FOR UPDATE) the slot rows for its desired room and time, then checks for overlaps and inserts. The slot table stores no booking data — it exists purely as a set of lock targets. The chapter calls this a last resort: hard to get right, and it leaks concurrency control into the data model.

**Demonstrates:** materializing conflicts — converting a phantom into a lock conflict on concrete rows.

## Weak isolation causing real losses

Race conditions under weak isolation have caused substantial loss of money: they bankrupted a Bitcoin exchange, led to investigation by financial auditors, and corrupted customer data (the cited reports name the Flexcoin and Poloniex exchanges). The retort "use an ACID database for financial data" misses the point: many popular relational databases considered ACID use weak isolation and would not necessarily have prevented these bugs. The chapter also warns that even if such bugs are rare in normal operation, an attacker might deliberately send a burst of highly concurrent requests to exploit them (citing the ACIDRain paper).

**Demonstrates:** weak-isolation anomalies are an exploited, money-losing reality; isolation must be chosen deliberately, not assumed from "ACID."

## Banking over FTP text files

Much of the interbank system exchanges text files over secure FTP. In that world, audit trails and human-level fraud controls matter more than ACID properties.

**Demonstrates:** transactional guarantees are one tool among several; some critical systems rely on reconciliation and auditing instead.

## The airline booking transaction that never was

Early database designers imagined one transaction spanning an entire user activity: searching flights, choosing an itinerary, reserving seats, entering passenger details, paying. But humans take ages to decide, and a database can't efficiently hold huge numbers of idle open transactions. So OLTP applications keep transactions short and never wait for user input inside one; on the web, a transaction completes within a single HTTP request.

**Demonstrates:** why transactions are scoped to be short — and the background for why serial execution disallows interactive multi-statement transactions (requiring single statements or stored procedures instead).

## VoltDB: stored procedures, determinism, and the cross-shard cliff

Single-threaded serial execution (VoltDB/H-Store, Redis, Datomic) avoids locking overhead but can't afford per-statement network round trips, so the whole transaction is submitted as a stored procedure executing against in-memory data. VoltDB also replicates by running the same stored procedure on every replica, which requires procedures to be deterministic — e.g., current time must come from special APIs (state machine replication). Sharding scales throughput linearly when each transaction stays in one shard, but cross-shard transactions need lockstep coordination: VoltDB reports about 1,000 cross-shard writes per second, orders of magnitude below single-shard throughput and not improved by adding machines.

**Demonstrates:** the serial-execution recipe (in-memory data + stored procedures + single-shard transactions) and its scaling cliff at cross-shard coordination.

## GraphQL proxy validation in a stored procedure

An application exposing its database directly through a GraphQL proxy may have nowhere to put complex validation logic. Embedding it in a stored procedure puts the validation inside the database; without stored procedure support you'd have to insert a separate validation service between the proxy and the database.

**Demonstrates:** a modern, legitimate use for stored procedures beyond performance.

## 2PL stalls behind a full-table read

Under two-phase locking, a transaction reading an entire table (backup, analytics, integrity check) needs a shared lock on the whole table. It first waits for all in-flight writers to finish; then, for the duration of the long read, every writer to that table is blocked. The database is effectively unavailable for writes. This illustrates why 2PL has unstable, slow tail latencies under contention.

**Demonstrates:** the performance failure mode of pessimistic locking — one big or slow transaction halts the system.

## Index-range locks on room bookings

A serializable database needs to stop anyone inserting a booking that would change the result of a search for "room 123, noon to 1 p.m." A precise predicate lock over that condition is too expensive to check, so the database widens it to something attached to an index: lock the index entry for room 123 (all times), or a time-range in a time index (all rooms, noon–1pm). Any conflicting insert must touch the same index region, hits the shared lock, and waits. Broader than necessary but cheap and safe; with no usable index, the fallback is a whole-table lock.

**Demonstrates:** index-range (next-key) locking as a practical approximation of predicate locks to block phantoms.

## SSI catches the doctors' race (Figures 8-10 and 8-11)

Rerun the on-call scenario under serializable snapshot isolation. Case 1 (stale MVCC read): transaction 43 reads Aaliyah as on-call because transaction 42's change is uncommitted at snapshot time; when 43 tries to commit, the database sees the ignored write has since committed and aborts 43. It waits until commit time because 43 might have been read-only (no skew risk) or 42 might have aborted. Case 2 (write affecting prior reads): transactions 42 and 43 both query on-call doctors for shift 1234; the database records on the shift_id index entry that both read it. When each writes, it trips the record and notifies the other that its premise may be stale. 42 commits first and succeeds; when 43 commits, the conflicting committed write forces 43 to abort.

**Demonstrates:** SSI's two detection mechanisms — stale snapshot reads and writes-after-reads — aborting only transactions whose premise actually became false.

## Commit succeeds on some nodes, fails on others (Figure 8-12)

Naively committing a multi-node transaction by sending commit to every node fails: one node may hit a constraint violation, a commit message may be lost, or a node may crash before writing its commit record — while other nodes commit successfully. Once a node has committed, it can't take it back: user 2 may already have read the committed data on database 2 while user 1's commit failed on database 1; retracting would require reverting other transactions too.

**Demonstrates:** the atomic commitment problem — why distributed commit needs a protocol, not independent commit messages.

## 2PC as a wedding ceremony (Figures 8-13 and 8-14)

The officiant (coordinator) asks each partner (participant) "do you take...?" — the prepare phase. Saying "I do" is a binding promise: you surrender the right to back out. After both say yes, the officiant pronounces the marriage — the logged commit decision, the point of no return — and announces it. If a partner faints after saying "I do" and misses the pronouncement, they are still married; on waking they ask the officiant (query the coordinator by transaction ID) or wait for the retry. The dark side (Figure 8-14): if the coordinator crashes after a participant votes yes but before delivering the decision, that participant is in doubt — it can't abort (the other database already committed) and can't commit (another participant might have voted no). It can only wait for the coordinator to recover and read its log.

**Demonstrates:** 2PC's two irrevocable promises that create atomicity, and its blocking failure mode when the coordinator dies.

## In-doubt transactions holding locks

An in-doubt 2PC participant must keep the transaction's row locks — exclusive locks on modified rows, shared locks on read rows under 2PL — until the outcome is known, even across database restarts. If the coordinator takes 20 minutes to restart, those rows are untouchable for 20 minutes; if the coordinator log is lost, forever, until an administrator manually resolves each transaction by checking what other participants did. XA's "heuristic decision" escape hatch lets a participant decide unilaterally — which probably breaks atomicity and is meant only for catastrophes.

**Demonstrates:** why in-doubt transactions are an availability disaster, not a harmless background anomaly.

## Exactly-once message processing with 2PC — and the email that breaks it

With heterogeneous distributed transactions, a message-queue acknowledgment and the database writes from processing that message commit atomically: if either side fails, both abort and the broker redelivers. The message is processed exactly once even across retries. But this only works if every affected system speaks the atomic commit protocol: if processing also sends an email and the mail server doesn't support 2PC, retries can send the email multiple times.

**Demonstrates:** the value and the boundary of heterogeneous atomic commit — exactly-once holds only within the set of participating systems.

## Exactly-once without distributed transactions

Give every message a unique ID and keep a processed-IDs table in the database. To process a message: in one local transaction, check the ID (if present, just ack and drop), insert the ID, apply the processing writes, commit; then ack to the broker; later delete the ID. Crash before commit → broker redelivers and the transaction rolled back. Crash after commit but before ack → redelivery is caught by the ID check. Crash after ack → a stale ID row remains, harmless. A uniqueness constraint on the ID table handles a redelivery racing the original. Kafka Streams uses a similar idempotence approach. Internal distributed transactions still help scale it — IDs on one shard, data on others, committed atomically.

**Demonstrates:** idempotence converts at-least-once delivery into exactly-once processing using only local transactions — no XA needed.
