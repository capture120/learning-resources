# Chapter 9: The Trouble with Distributed Systems — Examples and Scenarios

Every meaningful example, scenario, and case study from the chapter, retold compactly. Each ends with the principle it demonstrates.

## Coda Hale's datacenter war stories

An engineer (not even in operations) reports personally encountering: long-lived network partitions inside a single datacenter, power distribution unit failures, switch failures, accidental power cycles of whole racks, whole-datacenter backbone and power failures, and a hypoglycemic driver crashing a Ford pickup truck into the datacenter's HVAC system.

**Principle:** the range of real-world faults is far wider than anything you'd design for from the armchair; partial failures come from the physical world.

## The unanswerable request (Figure 9-1)

You send a request over the network and get no response. Six distinct things could have happened: the request was lost; the request is queued and will arrive later; the remote node crashed; the remote node is temporarily paused (e.g., GC) and will resume; the node processed the request but the response was lost; or the response is merely delayed. From the sender's side all six are identical — silence. Even with a timeout, you cannot know whether the operation was performed.

**Principle:** in an asynchronous network, no response carries zero information about what happened; timeouts detect "something is wrong" but never which thing.

## Why TCP "reliability" isn't end-to-end

TCP retransmits lost packets and orders data, but when a connection closes with an error you have no idea how much of the data the remote application actually processed — a kernel-level acknowledgment only means the remote OS buffered the bytes; the application may have crashed before reading them. And TCP's deduplication only covers one connection: if the application reconnects and retransmits, data can be duplicated.

**Principle:** reliability must be confirmed end-to-end by the application (a positive application-level response), not assumed from the transport layer.

## Measured network faults in real datacenters

A study of a medium-sized datacenter found about 12 network faults per month — half disconnecting a single machine, half disconnecting an entire rack. Another study found that adding redundant networking gear reduces faults less than expected, because human error (e.g., misconfigured switches) is a major cause of outages and redundancy doesn't help with that. Wide-area links have been cut by cows, beavers, sharks, scavengers, and saboteurs. Round-trip times of several minutes have been observed at high percentiles across cloud regions, and over a minute within one datacenter during a switch topology reconfiguration gone wrong.

**Principle:** network faults are routine, not exotic; redundancy doesn't cover human error; delays must be assumed unbounded.

## Asymmetric and partial network failures

Documented cases include: node A and B can talk, B and C can talk, but A and C cannot; and a network interface card that dropped all inbound packets while successfully sending outbound packets — the node was alive and talking, but deaf.

**Principle:** connectivity is not transitive and not symmetric; "the network works" is not a single yes/no fact.

## When fault handling itself fails

If error handling of network faults is undefined and untested, the reaction can be worse than the fault: a cluster could become deadlocked and permanently unable to serve requests even after the network recovers (Elasticsearch), or the system could potentially delete all your data (Redis Sentinel scenarios).

**Principle:** error-handling paths for network faults must be defined and tested; software in an unanticipated situation does arbitrary things.

## The fictitious bounded network: timeout = 2d + r

Imagine a network that guarantees every packet is delivered within time d or lost, and servers that always respond within time r. Then 2d + r is a provably sufficient timeout: no response by then means a genuine failure. Real asynchronous networks and real servers offer neither bound, which is why no "correct" timeout exists and timeouts must be chosen experimentally.

**Principle:** sound timeouts require bounded delay; without bounds, every timeout choice is a false-positive/false-negative trade-off.

## The congested switch (Figure 9-2)

Several machines simultaneously send traffic destined for the same machine. The switch must queue the packets and feed them one at a time into the destination link. When the queue fills, packets are dropped and must be resent — even though every link and node is healthy. Plus: the destination OS queues data when CPUs are busy, VM hypervisors buffer packets while the VM is descheduled, and TCP queues at the sender for congestion control.

**Principle:** queueing at every layer, not broken hardware, is the main source of network delay variability — and it explodes as utilization approaches capacity.

## VoIP chooses UDP: retry at the human layer

In an internet phone call there is no time to retransmit a lost packet before its audio must play. So VoIP uses UDP: the application fills the lost packet's slot with a brief silence and moves on. If the gap mattered, the human says "Could you repeat that? The sound cut out."

**Principle:** when delayed data is worthless, skip transport-level reliability (UDP) and accept loss; the reliability/latency trade-off belongs to the application.

## The telephone circuit: bounded delay by reservation

A fixed-line phone call establishes a circuit: an ISDN network runs at 4,000 frames per second, and a call is allocated 16 bits in each frame, in each direction — a guaranteed 16 bits of audio every 250 microseconds along the whole route, for the duration of the call. No queueing occurs because the space in the next hop is already reserved, so maximum end-to-end latency is fixed.

**Principle:** bounded network delay is achievable through static resource reservation — the thing packet networks deliberately gave up.

## Transferring a file over a circuit: the bandwidth-guessing problem

If you had to send a file over a circuit-switched network, you'd have to guess a bandwidth allocation. Guess too low and the transfer is needlessly slow with capacity sitting idle; guess too high and the circuit can't be established at all. TCP instead adapts its rate dynamically to whatever capacity is available.

**Principle:** packet switching exists because bursty traffic has no natural bandwidth requirement; dynamic sharing maximizes utilization at the cost of queueing.

## The 10,000-call wire: static vs dynamic partitioning

A wire between telephone switches carries up to 10,000 simultaneous calls, each with one fixed slot. Even if you're the only caller, you get exactly one slot's bandwidth. The internet instead lets senders jostle for the whole wire, deciding allocation moment to moment. The same applies to CPUs: dynamically scheduled threads sometimes wait in the run queue, but the hardware is far better utilized than with static cycle allocation. Hence multitenant clouds.

**Principle:** variable delay is the direct consequence of dynamic resource sharing chosen for cost efficiency — not a law of nature.

## The lost increment (Figure 9-3): LWW with skewed clocks

In a multi-leader database, client A writes x = 1 on node 1 (local timestamp 42.004 s). The write replicates to node 3, where client B increments it to x = 2 — but node 3's clock is slightly behind, so the increment gets timestamp 42.003 s. The skew is under 3 ms, better than typical real-world sync. When node 2 receives both writes and applies last-write-wins, it keeps x = 1 (the "newer" timestamp) and silently discards the causally later increment. Cassandra and ScyllaDB use client-clock timestamps with LWW and carry exactly this risk: a node with a lagging clock can't overwrite a fast-clock node's values until the skew elapses, dropping arbitrary data with no error reported.

**Principle:** wall-clock timestamps cannot safely order events across nodes; causality requires logical clocks or version vectors.

## Clock failure modes catalog

The quartz clock in a typical computer drifts; Google budgets up to 200 ppm — 6 ms per 30-second sync interval, or 17 seconds per day. A node firewalled off from NTP drifts unnoticed for ages because everything else still works. Some public NTP servers report time off by hours. Leap seconds (a 59- or 61-second minute) have crashed many large systems; the best mitigation may be having NTP servers "smear" the leap gradually across a day, though actual NTP server behavior varies in practice. In VMs the clock appears to jump forward after the hypervisor pauses the guest. And on end-user devices, people set the clock wrong on purpose — for instance, to cheat in games.

**Principle:** incorrect clocks fail silently, and software relying on synchronized clocks dies subtly (data loss) rather than loudly (crash) — so monitor clock offsets and evict drifted nodes.

## MiFID II: buying microsecond clocks for regulators

The European MiFID II regulation requires high-frequency trading funds to synchronize clocks to within 100 microseconds of UTC, to help debug market anomalies such as flash crashes and to detect market manipulation. Achieving this takes GPS receivers or atomic clocks, the Precision Time Protocol, and careful monitoring — and GPS alone is risky because the signal is easily jammed (it happens regularly near military sites).

**Principle:** very accurate clocks are possible, but only with special hardware, special protocols, and serious operational investment.

## Spanner's TrueTime: commit-wait on the confidence interval

Google Spanner needs globally ordered transaction timestamps for cross-datacenter snapshot isolation. Its TrueTime API returns not a timestamp but an interval [earliest, latest]. If two intervals don't overlap, their order is certain. To guarantee timestamps reflect causality, Spanner deliberately waits out the width of the confidence interval before committing each read/write transaction, ensuring later readers' intervals can't overlap. GPS receivers and atomic clocks in each datacenter keep uncertainty around 7 ms, so the wait stays short — but the essential mechanism is the interval, not the hardware. YugabyteDB does similarly with AWS ClockBound.

**Principle:** clock readings are ranges, not points; exposing and waiting out the uncertainty turns physical clocks into a safe ordering mechanism.

## The leader-lease loop that pauses at the wrong moment

A shard leader holds a lease and runs a loop: renew the lease if under 10 seconds remain, check `lease.isValid()`, then process the request. Two bugs: the expiry time was set by another machine's clock and is compared against the local clock (unsynchronized clocks break it); and even with a monotonic clock, the thread can pause for, say, 15 seconds between the validity check and the processing — a stop-the-world GC, a VM suspension — during which the lease expires and another node becomes leader. The thread resumes with no idea it was paused and does something unsafe.

**Principle:** check-then-act over a lease is unsound because a process can pause arbitrarily long between the check and the act.

## Why threads pause: the catalog

Real causes of multi-second pauses at arbitrary points in execution: contention among threads on a shared lock or queue (often worse on machines with more CPU cores, and hard to diagnose); stop-the-world GC (historically minutes); VM suspend/resume and live migration (where the pause length depends on how fast processes are writing to memory); a user closing a laptop lid; CPU steal time under contention; synchronous disk I/O — including surprise I/O like the JVM lazily loading class files mid-execution, or "disk" that is actually a network block device like Amazon EBS — with I/O and GC pauses sometimes conspiring to combine their delays; page faults and thrashing under memory pressure (which is why servers disable swap); and SIGSTOP, perhaps sent accidentally by an operator pressing Ctrl-Z.

**Principle:** a node must assume its execution can stop for a long time at any point while the rest of the world keeps moving.

## The airbag and hard real-time systems

If a car's sensors detect a crash, the airbag must fire on deadline — an inopportune GC pause is unacceptable. Hard real-time systems achieve this with a real-time OS guaranteeing CPU scheduling, libraries with documented worst-case execution times, restricted or banned dynamic allocation, and enormous testing. The result is very expensive, restricts language and tooling choice, and often has *lower* throughput because timeliness beats everything.

**Principle:** bounded response time is achievable but so costly that server-side data systems instead accept pauses and design around them.

## Treating GC like a planned outage

One mitigation: if the runtime can warn the application that a node will soon need a garbage collection, the application stops sending new requests to that node, lets in-flight requests drain, then runs the GC with nothing in progress. A variant collects only short-lived objects and restarts processes periodically (rolling, with traffic shifted away) before long-lived garbage forces a full collection. Clients never observe the pause; tail latencies improve.

**Principle:** pauses you can't eliminate can be scheduled and masked using the same machinery as rolling upgrades.

## The node dragged to the graveyard

Three funeral scenarios. (1) An asymmetric fault: a node receives every message but its outbound messages are all dropped — after a timeout the others declare it dead while it "screams I'm not dead" unheard. (2) The semi-disconnected node notices its messages aren't acknowledged and realizes something is wrong, but can do nothing about being declared dead. (3) A node pauses for a full minute, is declared dead, then resumes and cheerfully rejoins, initially unaware any time has passed.

**Principle:** a node cannot trust its own judgment of its status; the system's notion of truth must be a quorum decision, and an outvoted node must step down.

## The HBase lock bug (Figure 9-4): GC pause breaks the lease

A storage file must be written by one client at a time, enforced by a lease from a lock service. Client 1 acquires the lease, then suffers a long stop-the-world GC pause. The lease expires; client 2 acquires it and writes. Client 1's GC finishes and — still believing its lease is valid — writes too. The file is corrupted. HBase actually had this bug.

**Principle:** a lease alone cannot guarantee mutual exclusion, because the holder can be paused past expiry without knowing it.

## The delayed write (Figure 9-5): no pause required

Client 1 holds the lease and sends a write, then crashes. The write sits delayed in the network (recall: real packets have been delayed a minute or more). Client 1's lease times out; client 2 acquires it and writes. Then client 1's old write finally arrives and is applied — corrupting the data even though no process pause ever occurred.

**Principle:** even shooting zombie nodes in the head (STONITH) can't make leases safe, because stale requests can still be in flight in the network.

## Fencing tokens (Figure 9-6): tokens 33 and 34

The lock service hands out a monotonically increasing fencing token with every lease grant. Client 1 gets the lease with token 33, then pauses; the lease expires; client 2 gets token 34 and immediately writes to the storage service, which records 34. When zombie client 1 wakes and writes with token 33, the storage service sees it has already processed token 34 and rejects the write. Equivalent mechanisms: Chubby sequencers, Kafka epoch numbers, Paxos ballot numbers, Raft term numbers, ZooKeeper's zxid/cversion, etcd's revision plus lease ID, Hazelcast FencedLock; or conditional writes in S3/Azure Blob/Google Cloud Storage as the server-side check.

**Principle:** zombies are fenced off only if the protected resource itself rejects out-of-order tokens; the new holder must write immediately to establish its token.

## Fencing a leaderless store (Figure 9-7): token in the timestamp

The storage layer is a leaderless replicated key-value store with LWW, where clients write directly to each replica with self-assigned timestamps. Put the fencing token in the most significant bits of the timestamp: client 2 (token 34) generates timestamps that beat anything from client 1 (token 33), regardless of real time. Client 2 writes to a quorum but can't reach replica 3; zombie client 1's later write lands on replica 3 only. That's fine: a quorum read prefers client 2's higher timestamp, and read repair or anti-entropy eventually overwrites replica 3.

**Principle:** fencing tokens generalize to multi-replica systems by embedding them where the conflict-resolution rule already looks — the timestamp.

## The Byzantine Generals (and why not Albanian)

Generalization of the two generals problem (two armies coordinating an attack via unreliable messengers): n generals must agree, but some unknown subset are traitors who send contradictory or fake messages. The name has nothing to do with historic Byzantium's politics — Lamport wanted a nationality that would offend no one and was advised "The Albanian Generals Problem" was unwise.

**Principle:** consensus among mutually untrusting participants who may lie is a fundamentally harder problem than consensus among honest-but-faulty nodes.

## Where Byzantine fault tolerance is and isn't worth it

Worth it: flight control systems, where radiation can corrupt memory and a wrong output kills people; and blockchains/cryptocurrencies, where mutually untrusting parties must agree on transactions without a central authority. Not worth it: typical datacenter systems — your organization controls all the nodes, BFT protocols are expensive and need a >2/3 honest supermajority (4 nodes tolerate only 1 faulty), a bug deployed to all nodes defeats BFT anyway (you'd need four independent implementations), and an attacker who compromises one node can usually compromise them all since they run the same software. Web apps handle malicious browsers by making the server the authority, not by running BFT.

**Principle:** match the fault model to the trust environment; BFT buys nothing when all nodes run the same software under one owner.

## Weak forms of lying, cheaply defended

Three pragmatic guards short of full BFT: application-level checksums, because corrupted packets occasionally slip past TCP/UDP checksums (TLS also helps); input validation even behind the firewall (range checks, size limits), not just on public endpoints; and NTP clients configured with multiple servers so a single misconfigured server reporting a wrong time is detected as an outlier and excluded.

**Principle:** assume nodes are honest, but cheap sanity checks against hardware faults, bugs, and misconfiguration meaningfully improve reliability.

## Fencing-token correctness: uniqueness, monotonicity, availability

To define what a correct fencing-token algorithm means: uniqueness (no two requests get the same token) and monotonic sequence (if request x completed before y began, x's token is smaller) are safety properties — a violation is pinpointable and irreversible. Availability (every non-crashed requester eventually gets a response) is a liveness property — unmet now, possibly satisfied later. Distributed algorithms must keep safety properties in every circumstance, even total network failure; liveness may carry caveats like "if a majority is up and the network eventually recovers."

**Principle:** split correctness into safety (must always hold) and liveness (may depend on conditions improving) — the split is what makes guarantees possible in hostile system models.

## When stable storage lies: disk amnesia

Crash-recovery algorithms assume data on disk survives crashes. Real counterexamples: disks corrupted or wiped by hardware error or misconfiguration, and a server whose firmware bug made it fail to recognize its own drives after reboot even though they were correctly attached. A quorum algorithm relies on nodes remembering what they acknowledged storing; a node with amnesia silently breaks the quorum condition and the algorithm's correctness. Real implementations may need handling for "impossible" cases even if it amounts to `printf("Sucks to be you"); exit(666)` — letting a human clean up. The book calls this one difference between computer science and software engineering.

**Principle:** system models are simplified abstractions; implementations must consider violations of the model's own assumptions.

## TLA+ catches data loss in Viewstamped Replication

Researchers modeled the viewstamped replication consensus protocol in TLA+ and demonstrated potential data loss caused by ambiguity in the algorithm's prose description. CockroachDB, TiDB, and Kafka all use model specifications to find and fix bugs. Caveat: the checker runs a simplified model, not your code, and bounded exploration misses bugs that need long executions — and the model can drift from the implementation.

**Principle:** model checking finds nonobvious algorithm bugs that testing real systems would hit only under freak timing — but it verifies the model, not the code.

## Chaos Monkey and Jepsen

Netflix's Chaos Monkey popularized injecting faults directly into production (chaos engineering). Fault injection deploys coordinators and scripts that kill processes (`kill`), unmount disks (`umount`), and cut network connections (firewall rules), then observes whether the system survives. Because wiring all this up is cumbersome, frameworks like Jepsen package prebuilt fault injectors — and Jepsen has found critical bugs in many widely used distributed databases.

**Principle:** the only way to know a system tolerates the faults it claims to tolerate is to cause those faults and watch.

## Deterministic simulation testing: FoundationDB, TigerBeetle, Antithesis

DST runs the real code with network, I/O, and clocks replaced by mocks so the simulator controls the exact order of every event — failures replay exactly, and mocked time lets a timeout "elapse" instantly, so tests run faster than wall-clock. Three implementation levels: application (FoundationDB built on its Flow async library with an injectable simulated network; TigerBeetle models all state as a state machine in one event loop), runtime (FrostDB patches Go to run goroutines sequentially; Rust's MadSim provides deterministic Tokio/S3/Kafka stand-ins), and machine (Antithesis built a custom hypervisor that makes an entire containerized system deterministic, and branches executions when it discovers rare behavior).

**Principle:** if you control all sources of nondeterminism you can explore vastly more failure interleavings than real-world testing, and reproduce every one.

## Determinism as a recurring design tool

Beyond testing, the chapter notes determinism powering: event sourcing (replay an event log to rebuild materialized views), workflow engines (durable execution requires deterministic workflow definitions), and state machine replication (each replica independently executes the same deterministic transaction sequence — as in statement-based replication and serial stored-procedure execution). But full determinism is fragile: hash-table iteration order and hitting resource limits (memory allocation failure, stack overflow) remain nondeterministic even after mocking I/O, clocks, and randomness.

**Principle:** nondeterminism is the root of distributed-systems pain; engineering it away, where possible, simplifies replication, recovery, and testing alike.
