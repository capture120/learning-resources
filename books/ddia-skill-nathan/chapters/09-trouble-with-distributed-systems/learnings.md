# Chapter 9: The Trouble with Distributed Systems — Core Learnings

**Central thesis:** Distributed systems fail in ways single computers do not: partial failures are nondeterministic, networks deliver messages with unbounded delay or not at all, clocks cannot be trusted, and processes can pause arbitrarily long without noticing. A node can never know anything about another node for certain — it can only infer from messages it receives or fails to receive. Reliable systems are still possible, but only by stating explicit assumptions (a system model), designing algorithms that hold their safety properties even when those assumptions are stressed, and never letting a single node's local judgment be authoritative.

---

## Faults and Partial Failures

- A single computer is deliberately designed to be deterministic: it either works or fails totally (crash, kernel panic). Wrong-but-running is rare by design.
- A distributed system instead exhibits **partial failure**: some parts broken, others fine, nondeterministically. You may not even know whether an operation succeeded.
- Partial failure is also the opportunity: tolerating it enables rolling upgrades and building reliable systems from unreliable components — more reliable than any single node. In principle a distributed system can run forever with all faults handled at the node level — though a bad configuration change rolled out to all nodes will still bring it down.
- One-in-a-million events happen daily at scale. Design posture: suspicion, pessimism, paranoia. Deliberately inject the faults you claim to tolerate (see Fault injection below).

## Unreliable Networks

- Shared-nothing systems communicate only via **asynchronous packet networks**: no guarantee a packet arrives, or when. If you send a request and get no response, you cannot distinguish: request lost, request queued, remote node crashed, remote node paused, response lost, or response delayed. The only tool is a **timeout**, and after a timeout fires you still don't know whether the request was processed (it may even be delivered later).

### Limits of TCP
- Network packets max out at a few kilobytes; TCP exists to break larger messages into packets and reassemble them. Multiple requests/responses share one connection via length-prefix framing (a header stating the message length, then the message) — how HTTP and many RPC protocols work.
- TCP retransmits, reorders, checksums, and does congestion control — but only within one connection. If the connection breaks, you don't know how much data the remote *application* processed; a kernel ACK only means the remote OS received bytes. **End-to-end confirmation requires a positive application-level response.** Reconnect-and-retransmit can duplicate data. The same caveats apply to QUIC, SCTP, and similar transports.
- When no ACK arrives, TCP can't tell whether the outbound packet or the acknowledgment was lost; it resends, and after a configurable timeout gives up and signals an error to the application (it can't plug the cable back in for you).

### Network faults in practice
- Faults are common even inside one datacenter: one study measured ~12 network faults/month in a medium datacenter (half isolating one machine, half a whole rack).
- Redundant network hardware helps less than expected because **human misconfiguration** is a major outage cause and redundancy doesn't guard against it.
- Delays can be extreme: multi-minute round-trip times at high percentiles across cloud regions; >1 minute packet delay inside a datacenter during switch topology reconfiguration. Assume arbitrary delay.
- Partial/asymmetric faults occur: A↔B and B↔C work but A↔C doesn't; a NIC that drops all inbound packets but sends outbound fine. One working direction does not imply the other.
- Untested fault handling can be worse than the fault: clusters that deadlock permanently after a brief partition, or delete all data. Even a brief network interruption can have repercussions that last much longer than the original outage.
- Terminology: a **network partition** (netsplit) just means part of the network is cut off — not fundamentally different from other network faults, and unrelated to sharding (also sometimes called "partitioning").
- Handling faults need not mean tolerating them — showing users an error can be valid — but you must know and test how the system behaves and that it recovers.

### Fault detection
- Why it's needed: load balancers must take dead nodes out of rotation; single-leader replication must detect a dead leader to promote a follower.
- Sometimes you get fast explicit signals (TCP RST/FIN if process dead but OS alive; a crash-notification script as in HBase; switch management interfaces; ICMP Destination Unreachable) — useful, but **never guaranteed**. The general case is: retry, wait for timeout, declare dead.
- Timeout tuning is a false-positive vs false-negative trade-off:
  - Too long: slow failover, users wait on a dead node.
  - Too short: a node that is merely slow (load spike, GC) is declared dead; its work may be done twice; transferring its load can trigger **cascading failure** in an already-overloaded system (worst case: all nodes declare each other dead).
- Theoretical ideal: with bounded network delay d and bounded request handling time r, timeout 2d + r is sound. Real networks/servers have **unbounded delays**, so no "correct" timeout exists — measure round-trip distribution experimentally and tune.
- Better: adapt timeouts dynamically from observed response times and jitter — the **Phi Accrual failure detector** (used in Akka, Cassandra); TCP retransmission timeouts work similarly.

### Why delays are variable: queueing
- Main sources: switch queues when multiple senders converge on one link (drops when queues fill, even on a healthy network); OS queues requests when CPUs busy; virtualization pauses (VM monitor buffers packets while another VM holds the core); TCP sender-side backpressure; TCP retransmit delay visible as latency.
- Queueing delay explodes near capacity; systems with headroom drain queues quickly.
- In multitenant clouds, **noisy neighbors** make delays highly variable and unobservable to you.

### TCP vs UDP
- UDP skips flow control and retransmission: lower delay variability, no reliability. **Use UDP when late data is worthless** (VoIP, videoconferencing — fill a lost packet's slot with silence; "retry happens at the human layer"). Use TCP when data must arrive.

### Synchronous vs asynchronous networks
- Telephone circuits reserve fixed bandwidth end-to-end: no queueing, **bounded delay** (e.g., ISDN: 4,000 frames/s, a guaranteed 16 bits per 250 µs per call). Datacenter Ethernet/IP are packet-switched: optimized for **bursty traffic**, opportunistically using all available bandwidth, at the cost of queueing and unbounded delay.
- General principle: **variable delay is the price of dynamic resource sharing** (high utilization, cheap); bounded latency requires static partitioning (low utilization, expensive). Same trade-off applies to CPU scheduling. Variable delays are a cost/benefit choice, not a law of nature — most non-safety-critical systems choose cheap-and-unreliable over expensive-and-reliable.
- Hybrids (ATM, InfiniBand link-level flow control, QoS/admission control, L4S, Linux's traffic controller TC for packet reprioritization) can bound delay statistically, but **none of this is enabled in public clouds or the internet** — so assume congestion, queueing, and unbounded delay. (ISP peering agreements and BGP routes do resemble circuit switching — dedicated bandwidth is buyable — but at the level of whole networks, not individual connections.)

## Unreliable Clocks

- Distinguish duration questions (timeouts, percentiles) from point-in-time questions (timestamps, expiry). Each needs a different clock.

### Two kinds of clocks
- **Time-of-day (wall-clock)**: `CLOCK_REALTIME`, `System.currentTimeMillis`. Returns time since the epoch (midnight UTC, Jan 1, 1970, Gregorian calendar, not counting leap seconds). NTP-synchronized, comparable across machines (roughly). Can **jump backward** (forced NTP reset, leap seconds); DST jumps are avoidable by always using UTC. Unsuitable for measuring elapsed time. Historically coarse resolution (10 ms steps on older Windows); fine on recent systems. Despite the name, Linux's `CLOCK_REALTIME` has nothing to do with real-time operating systems.
- **Monotonic**: `CLOCK_MONOTONIC`/`CLOCK_BOOTTIME`, `System.nanoTime`. Always moves forward; microsecond resolution; NTP may slew its rate (±0.05% max) but never jump it. Absolute value meaningless; **never compare monotonic values across machines**. Use for timeouts and durations. Caveat: multi-socket servers may have a separate timer per CPU; the OS compensates to present a monotonic view, but take the guarantee with a pinch of salt.

### Clock accuracy realities (numbers worth remembering)
- Quartz drift: Google assumes up to **200 ppm** — 6 ms drift per 30 s sync interval, 17 s per day unsynchronized. Drift varies with machine temperature. This drift limits the best accuracy achievable even when everything works correctly.
- NTP over the internet: ~35 ms best-case error; spikes ~1 s under congestion. NTP accuracy is fundamentally limited by network round-trip time. Depending on configuration, large network delays can make the NTP client give up entirely.
- NTP failure modes: clock too far off → refuses to sync or force-resets (time jumps); firewalled-off NTP goes unnoticed while drift accumulates; some NTP servers report time off by hours (clients mitigate by querying several servers and discarding outliers).
- Leap seconds have crashed major systems; mitigate by **smearing** (NTP servers spread the second across a day). Leap seconds end in 2035.
- VMs: hardware clock virtualized; clock appears to jump forward after the hypervisor pauses the VM. An NTP client inside the VM can't see the pauses, so it may report clock accuracy incorrectly.
- User devices: don't trust the clock at all (users set clocks wrong deliberately, e.g., to cheat in games).
- High accuracy is buyable: GPS receivers/atomic clocks + PTP achieve ~100 µs (MiFID II requires this of high-frequency traders). GPS alone is jammable. Some cloud providers now offer high-accuracy clock sync for VMs — but it still requires care (a misconfigured NTP daemon or blocked NTP traffic lets drift grow fast).
- **Gotcha: bad clocks fail silently.** A broken CPU stops the machine; a drifting clock keeps everything looking fine while causing subtle data loss. If your software depends on synchronized clocks, **monitor clock offsets across the cluster and evict nodes that drift too far**.

### Timestamps for ordering events — dangerous
- Last-write-wins (LWW) keyed on time-of-day timestamps breaks causality: with even a few ms skew, a causally later write can carry an earlier timestamp and get silently dropped (multi-leader/leaderless replication).
- Prevention exists but costs a round trip: ensure every overwrite carries a timestamp greater than the value it replaces (even if that's ahead of the writer's local clock), which requires an extra read to find the greatest existing timestamp. Cassandra and ScyllaDB skip that read and use the client clock directly with LWW — exactly this exposure.
- Specific failure modes: a node with a lagging clock cannot overwrite a fast-clock node's writes until the skew elapses (silent data loss, no errors); LWW can't distinguish sequential from truly concurrent writes (need **version vectors**); equal timestamps (likely at millisecond resolution) need a tiebreaker (e.g., a large random number), which itself can violate causality.
- Fixing it via better NTP is impossible: ordering requires clock error ≪ network delay, but NTP error is itself bounded below by network delay. Intuition: even with tight NTP sync, a packet sent at timestamp 100 ms (sender's clock) can arrive at timestamp 99 ms (recipient's clock) — appearing to arrive before it was sent.
- **Prefer logical clocks** (incrementing counters that capture only ordering) for ordering events; physical clocks (time-of-day, monotonic) for actual time.

### Clock confidence intervals and global snapshots
- A clock reading is a range, not a point: uncertainty = quartz drift since last sync + server uncertainty + network round trip. If you know the time only ±100 ms, the microsecond digits of a timestamp are meaningless. Most APIs hide this (`clock_gettime` doesn't say whether its confidence interval is five milliseconds or five years); **Google TrueTime** (Spanner) and **AWS ClockBound** return [earliest, latest].
- Why synchronized clocks tempt database designers: distributed MVCC needs a global, monotonically increasing transaction ID that reflects causality — on a single node a simple counter suffices, but generating one across shards via coordination becomes an untenable bottleneck — synchronized-clock timestamps would have the right properties if accurate enough.
- Spanner's trick for cross-datacenter snapshot isolation: if two confidence intervals don't overlap, ordering is certain. Spanner **commit-waits** the width of the interval before committing, so transaction timestamps reflect causality. GPS/atomic clocks per datacenter keep uncertainty ~7 ms — small intervals make the wait short, but the essential ingredient is the confidence interval, not the fancy hardware. YugabyteDB does similarly with ClockBound on AWS.

### Process pauses
- A thread can be preempted **at any point, for any duration**, and resume without knowing it was paused. Causes: lock/queue contention; stop-the-world GC (historically minutes; tuned modern collectors a few ms); VM suspend/live migration; laptop lid close; CPU steal time; synchronous disk I/O (including surprise I/O — Java classloading, network block devices like EBS); swapping/thrashing (disable paging on servers); SIGSTOP. I/O pauses and GC pauses can conspire, combining their delays.
- Consequence: code like "check lease validity, then process request" is unsafe — the pause can land between the check and the action. Single-machine concurrency tools (mutexes, semaphores) don't transfer; there is no shared memory, only messages.
- **Hard real-time** systems eliminate pauses (RTOS with guaranteed CPU scheduling, bounded library calls, restricted allocation — real-time GCs exist but the app must still limit garbage, massive testing) but are extremely expensive, restrict tooling, and trade throughput for deadline guarantees. Not economical for server-side data systems — so plan for pauses. Terminology: embedded "real-time" means guarantees tested for all circumstances; "real-time" on the web (push, stream processing) carries no hard response-time constraint.
- GC mitigations: pause-free languages (Rust and Mojo via type-system lifetime tracking, Swift via reference counting); tuned collectors optimized for different memory profiles (Java's CMS, G1, ZGC, Epsilon, Shenandoah; Go's simpler self-tuning concurrent mark-sweep); object pooling/off-heap; treat GC as a planned node outage (drain traffic, collect, rejoin) to cut tail latency; use GC only for short-lived objects and do rolling restarts before long-lived garbage accumulates. These reduce, never eliminate, pauses.

## Knowledge, Truth, and Lies

- A node knows nothing for sure about other nodes; network problems are indistinguishable from node problems. So define truth by protocol, not by any node's local perception.

### The majority rules — quorums
- A node cannot trust its own judgment: it may be declared dead while healthy (asymmetric fault: receives but can't send), or it may pause a minute and resume believing nothing happened.
- Decisions (including "node X is dead") must come from a **quorum**, usually an absolute majority. If a quorum declares you dead, you must step down even if you feel alive.
- Majority quorums tolerate minority failure (3 nodes → 1 faulty, 5 → 2) and are safe because two disjoint majorities cannot exist simultaneously.

### Distributed locks and leases — fencing
- A **lease** is a lock with a timeout, used to enforce "only one of X" (one shard leader, one writer to a resource, one processor of a file). Decide what a duplicate holder costs: for idempotent/wasteful work it's fine; for data integrity it's corruption. Distributed locks/leases are prone to misuse and a common source of bugs; lock services are typically implemented on a consensus algorithm (Ch 10).
- Two ways a lease silently fails:
  1. Holder pauses (GC), lease expires, new holder acquired; old holder resumes and keeps writing (HBase had this bug).
  2. Holder's write is **delayed in the network** and arrives after the lease has changed hands — no pause needed.
- **Zombie** = ex-leaseholder that doesn't know it lost the lease. STONITH (shut the zombie down — by network disconnection, cloud-API VM shutdown, or physical power-off) is weak: it can't stop already-in-flight delayed requests, nodes can shut each other down, and it's often too late.
- **Fencing tokens** are the robust fix: the lock service issues a monotonically increasing number with each grant; the storage service rejects writes carrying a token lower than one it has already seen. A new leaseholder must write immediately to fence out predecessors. Crucially, **the resource being protected must check the token** — the lock service alone cannot make this safe.
- Equivalents in real systems: Chubby sequencers, Kafka epoch numbers, Paxos ballot numbers, Raft term numbers, ZooKeeper zxid/cversion, etcd revision + lease ID, Hazelcast FencedLock. Conditional writes (S3 conditional writes, Azure conditional headers, GCS request preconditions) serve as the check; if a single store supports conditional writes, a separate lock service is largely redundant.
- Fencing resembles optimistic concurrency control (Ch 8), except fencing is permanent — a fenced-off client cannot retry, while an OCC failure can.
- With leaderless replication + LWW, put the fencing token in the **most significant bits of the write timestamp**: every new-holder timestamp then beats every old-holder timestamp; quorum reads + read repair clean up writes a zombie sneaks onto a minority of replicas.
- Caveat: fencing only blocks nodes *inadvertently* acting in error. A node that deliberately wanted to subvert the system could just send a fake fencing token — that's Byzantine territory.
- Bottom line: **never assume only one node holds a lease at a time**; make the protected resource enforce ordering.

### Byzantine faults
- Default book assumption: nodes are unreliable but honest (crash, lag, hold stale state — but never lie). **Byzantine faults** = nodes sending arbitrary/false messages (the Byzantine Generals Problem: reach agreement despite traitors).
- BFT is warranted when: radiation can corrupt state (aerospace/flight control), or mutually untrusting parties with no central authority (blockchains, peer-to-peer).
- BFT is NOT the right tool for typical datacenter systems: nodes are under one organization's control; multitenant clouds isolate mutually untrusting tenants with firewalls, virtualization, and access control, not BFT; protocols are expensive; fault-tolerant embedded systems rely on hardware-level support; BFT needs a >2/3 supermajority honest (4 nodes tolerate 1 faulty); it can't protect against a software bug deployed to all nodes (you'd need 4 independent implementations) nor against a compromise that applies to all nodes (same software everywhere). Web apps handle malicious clients with server-side validation/authority, not BFT; security still comes from auth, access control, encryption, firewalls.
- Do guard against **weak lying** cheaply: application-level checksums (TCP/UDP checksums occasionally miss corruption; TLS also protects), input sanitization even on internal services, NTP clients querying multiple servers and discarding outliers.

### System models
Timing models:
- **Synchronous**: bounded network delay, pauses, clock error — not zero delay or perfect clocks, just a known fixed upper bound. Unrealistic for practical systems.
- **Partially synchronous**: behaves synchronously most of the time, with occasional unbounded excursions. **The realistic model for most systems.** Formally requires that the system eventually returns to a synchronous state — every network interruption lasts only a finite duration before being repaired.
- **Asynchronous**: no timing assumptions, no clocks/timeouts. Very restrictive.

Node-failure models:
- **Crash-stop** (fail-stop): nodes fail only by crashing, forever.
- **Crash-recovery**: nodes crash and may return; stable storage survives, memory is lost. **Most useful in practice** (paired with partial synchrony).
- **Degraded/partial function**: **limping nodes / gray failure / fail-slow** — alive enough to pass health checks, too slow to work (e.g., a gigabit NIC dropping to 1 Kb/s via driver bug; a process under memory pressure spending most of its time in GC; worn-out SSDs with erratic performance; hardware degraded by heat, loose connectors, vibration, power supply problems, or firmware bugs). Often harder than clean crashes. Also processes where one background thread is dead while the rest responds.
- **Byzantine**: anything goes.

### Correctness: safety and liveness
- Define algorithm correctness as properties. Example, fencing-token generation: uniqueness, monotonic sequence (safety), availability (liveness).
- **Safety** = nothing bad happens; a violation is pinpointable in time and cannot be undone. **Liveness** = something good eventually happens ("eventually" is the giveaway; eventual consistency is a liveness property).
- Design rule: **safety properties must hold in all situations** (even total crash/network failure — never return a wrong result); liveness may carry caveats (e.g., responses required only if a majority is up and the network eventually recovers).
- Models are abstractions: crash-recovery assumes stable storage survives, but disks get corrupted and firmware bugs lose data — breaking quorum assumptions (a node with "amnesia" violates quorum correctness). Real implementations need code for "impossible" cases, even if it just alerts a human. Theory still earns its keep by making the fault space tractable.

### Verifying distributed systems
- Combine theoretical analysis with empirical randomized testing: **property-based testing, fuzzing, and deterministic simulation** all use randomization to cover situations handwritten tests miss. AWS, FoundationDB, and TigerBeetle combine these techniques across their products.
- **Formal proof**: strongest, hardest; proves the algorithm, not the implementation.
- **Model checking** (TLA+, Gallina, FizzBee): exhaustively explores a simplified model's state space up to a bound. Demonstrated potential data loss in viewstamped replication caused by ambiguity in the algorithm's prose description; used by CockroachDB, TiDB, Kafka. Risk: model and code drift apart (checkable by verifying equivalent behavior, but that requires instrumenting the real implementation); bounded exploration misses long-execution bugs.
- **Fault injection / chaos engineering**: inject real failures (kill, umount, firewall rules) into a near-production or production system; Netflix Chaos Monkey popularized it; **Jepsen** frameworks have found critical bugs in many widely used systems. Downside: failures hard to reproduce.
- **Deterministic simulation testing (DST)**: run the real code under mocked network/IO/clock so the simulator controls all nondeterminism — failures replay exactly; simulated time runs faster than wall-clock. Three strategies: application-level (FoundationDB's Flow, TigerBeetle's state-machine event loop), runtime-level (FrostDB patching Go's scheduler, Rust MadSim), machine-level (Antithesis deterministic hypervisor).
- **Determinism is a recurring superpower**: event sourcing replay, durable workflow execution, state machine replication all rely on it. But full determinism is tricky — hash-table iteration order and resource limits (OOM, stack overflow) stay nondeterministic.

## Decision guidance — quick reference

| Situation | Guidance |
|---|---|
| Choosing timeouts | No correct constant; measure RTT distribution; prefer adaptive (Phi Accrual) |
| Measuring elapsed time | Monotonic clock, never wall-clock |
| Ordering events across nodes | Logical clocks / version vectors, not timestamps; if timestamps, need confidence intervals + commit-wait (Spanner) |
| LWW conflict resolution | Accept silent loss of concurrent/skewed writes, or add causality tracking |
| Latency-critical, loss-tolerant data | UDP; otherwise TCP |
| "Only one of X" | Lease + fencing token enforced by the resource (or conditional writes) |
| Failure detection | Quorum decision, not single-node judgment |
| Depending on synchronized clocks | Monitor offsets; evict drifted nodes |
| BFT? | Only for untrusted multi-party or radiation-prone environments; otherwise standard security |
| Single machine suffices? | Use it (e.g., an embedded storage engine) — distribution only for fault tolerance, latency (geo-placement), or scale |
| Bounded latency required? | Statically partition resources (expensive, low utilization) or hard real-time stack; otherwise accept variable delay |
| Build vs adopt | Prefer extensively tested, production-grade distributed systems — they already manage these problems |

## How this connects

- Builds on: reliability/fault terminology (Ch 2), replication and leader failover, LWW, version vectors, quorum reads/writes (Ch 6), sharding (Ch 7), snapshot isolation/MVCC and optimistic concurrency control (Ch 8).
- Leads into: Ch 10 (consistency and consensus — quorums, leader election, Paxos/Raft ballot/term numbers as fencing, shared logs/state machine replication, the two generals problem formalized), ID generators and logical clocks (Ch 10's "ID Generators and Logical Clocks"), stream processing's looser "real-time" (Ch 12).
- The system models defined here (partially synchronous + crash-recovery) are the assumptions under which Ch 10's consensus algorithms are proven correct.
