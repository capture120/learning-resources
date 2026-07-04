# Chapter 2: Defining Nonfunctional Requirements — Core Learnings

**Central thesis:** Functional requirements say what an app does; nonfunctional requirements (performance, reliability, scalability, maintainability) determine whether it is usable at all — an unbearably slow or unreliable app might as well not exist. Nonfunctional requirements are often not written down because they seem obvious, yet they are just as important as functionality. Others — security, legal compliance — are also nonfunctional requirements; security mostly falls outside this book's scope. This chapter defines precise vocabulary and measurement techniques for these requirements so you can articulate them for your own systems and reason about the trade-offs they force.

## Case Study: Social Network Home Timelines

The chapter grounds its concepts in a Twitter/X-style service: 500M posts/day (~5,800 posts/sec average, spikes to 150,000/sec), average user follows 200 and has 200 followers. The distribution around those averages is extremely skewed: most users have only a handful of followers, while a few celebrities exceed 100M.

Two architectures for the home timeline:

1. **Query-on-read (pull):** A SQL join over `posts`, `follows`, `users` per timeline load. With 10M online users polling every 5 seconds, that's 2M queries/sec × 200 followed accounts = **400M lookups/sec**. Untenable.
2. **Materialize-on-write (push):** Precompute each user's timeline; on every new post, fan out the post into each follower's cached timeline. 5,800 posts/sec × fan-out factor 200 = **~1M timeline writes/sec** — 400× cheaper than the pull approach.

Key terms introduced:
- **Fan-out:** the factor by which one request multiplies into downstream requests.
- **Materialization / materialized view:** precomputing and incrementally updating a query result. Speeds reads at the cost of more work on writes.
- **Derived data:** the precomputed timelines are derived from the posts — every post write must also update them, which is why the write path gets more expensive.

**Trade-off and extreme cases:**
- Load spikes: timeline deliveries can be enqueued and delayed; reads stay fast because they hit the cache. Write path absorbs spikes via buffering.
- User who follows huge numbers of busy accounts: their timeline write rate is high, but they can't read everything anyway — **dropping some timeline writes (lossy timelines) is acceptable**.
- Celebrity with millions of followers: dropping writes is NOT acceptable. **Hybrid approach:** store celebrity posts separately and merge them into the materialized timeline at read time. Even so, celebrities require disproportionate infrastructure.

**Rule:** read-heavy workloads with predictable queries favor precomputation; handle the extreme tail of the distribution (celebrities) with a different code path than the average case.

## Describing Performance

Two metric families:
- **Response time:** elapsed time from user request to answer (seconds). What users care about.
- **Throughput:** requests/sec or data volume/sec (somethings per second). Determines required hardware and therefore cost.

In the case study: posts/sec and timeline-writes/sec are throughput metrics; time to load the home timeline and time until a post reaches followers are response time metrics.

They are coupled by **queueing:** as throughput approaches hardware capacity, queueing delays — and response times — increase sharply. A system is **scalable** if its maximum throughput can be significantly increased by adding computing resources.

### Overload and metastable failure

A near-overloaded system can enter a vicious cycle: long queues → client timeouts → retries → even more load (**retry storm**). The system can stay stuck in the overloaded state even after the original load subsides, until rebooted/reset — a **metastable failure**.

Defenses (memorize this list):
- Client side: **exponential backoff with jitter** between retries; **circuit breaker** or **token bucket** to stop sending to a recently failing service.
- Server side: **load shedding** (proactively reject requests near overload); **backpressure** (tell clients to slow down).
- Queueing and load-balancing algorithm choice also matters.

### Latency vs. response time (precise definitions)

- **Response time:** what the client sees; includes all delays everywhere.
- **Service time:** time the service actively processes the request.
- **Queueing delay:** waiting time at any point (waiting for a CPU, network buffer, etc.).
- **Latency:** catchall for time a request is *latent* (not being actively processed); network latency = time in transit.

**Gotcha:** queueing delay is not part of service time, so **measure response times client-side** — server-side service-time metrics hide queueing. Because a server can process only a small number of requests in parallel (bounded e.g. by its CPU core count), it takes only a few slow requests to hold up everything behind them (**head-of-line blocking**) even when subsequent requests have fast service times.

Response time varies significantly even when the exact same request is repeated. Sources of random variation: context switches, packet loss + TCP retransmission, GC pauses, page faults, even rack vibration. Variation in network delay is called **jitter**. Queueing delays often account for a large part of the variability in response times.

### Percentiles, not averages

Response time is a **distribution**, not a number.
- **Mean:** useful for estimating throughput limits, but tells you nothing about how many users experienced a given delay.
- **Median (p50):** the typical user wait.
- **p95 / p99 / p999 (tail latencies):** how bad outliers are (a p95 of 1.5 s means 95 of 100 requests finish in under 1.5 s; 5 take 1.5 s or more). They matter because the slowest requests often hit the most valuable users — Amazon found its slowest customers were those with the most data, i.e., the heaviest purchasers, and set internal SLOs at p999. They judged p9999 too expensive: very high percentiles are dominated by random events outside your control, with diminishing returns.

**Tail latency amplification:** if one end-user request requires many parallel backend calls, the request waits for the slowest call. Even a small fraction of slow backend calls makes a much larger fraction of end-user requests slow. This is why backend services need tight high-percentile SLOs.

**SLO vs. SLA:** an SLO is a target (e.g., median < 200 ms, p99 < 1 s, ≥99.9% of valid requests non-error); an SLA is a contract specifying consequences if the SLO is missed (e.g., refunds). Defining genuinely meaningful availability metrics is harder than it looks.

### Computing percentiles correctly

- Naive: keep a rolling window (e.g., 10 min) of all response times, sort each minute.
- Efficient approximation libraries: **HdrHistogram, t-digest, OpenHistogram, DDSketch**.
- **Gotcha:** averaging percentiles (across time buckets or machines) is mathematically meaningless. Aggregate by **adding histograms**.

### User impact of latency (treat cited stats skeptically)

Often-cited numbers are unreliable. Google 2006 claimed 400→900 ms cost 20% of traffic; Google 2009 found a 400 ms increase cost only 0.6% of searches. Bing 2009: +2 s load time → −4.3% ad revenue. An Akamai study (+100 ms → up to −7% conversions) is confounded: the fastest pages were content-free error pages. Best-controlled result: Yahoo found 20–30% more clicks on fast vs. slow search results when the gap was ≥1.25 s. Lesson: latency matters, but demand rigor from latency-revenue claims.

## Reliability and Fault Tolerance

**Reliability ≈ continuing to work correctly even when things go wrong.**

"Working correctly" bundles the typical expectations: the app performs the function the user expected; it tolerates the user making mistakes or using it in unexpected ways; its performance is good enough for the use case under expected load and data volume; and it prevents unauthorized access and abuse.

- **Fault:** one component stops working correctly (a disk dies, a machine crashes, a dependency has an outage).
- **Failure:** the system as a whole stops providing required service to users (misses its SLO).
- Same event at different levels: a dead disk is a failure *of the disk* but only a fault *of the system* — if the system has a redundant copy, the fault doesn't become a failure.

**Fault tolerance:** continuing to provide service despite certain faults. A component whose fault escalates to system failure is a **single point of failure (SPOF)**.

Limits and guidance:
- Fault tolerance is always bounded: "tolerates up to 2 simultaneous disk failures" or "1 of 3 nodes crashing." Tolerating arbitrary faults is impossible (you can't survive all nodes dying).
- **Fault injection / chaos engineering:** deliberately trigger faults (e.g., randomly kill processes) so the fault-tolerance machinery is continuously exercised. Many critical bugs are due to poor error handling.
- **Prefer tolerance over prevention** — except where no cure exists, notably security: a data breach cannot be undone, so prevention is mandatory there.

### Hardware faults — concrete failure rates

| Component | Rate |
|---|---|
| Magnetic hard drives | 2–5% fail/year → in a 10,000-disk cluster, ~1 failure/day (recent data suggests disks are getting more reliable, but rates remain significant) |
| SSDs | 0.5–1% fail/year; small bit-error counts are auto-corrected, but ~1 uncorrectable error/drive/year (worse than HDDs, even when new) |
| CPUs | ~1 in 1,000 machines has a core that occasionally computes wrong results, likely from manufacturing defects (may silently corrupt, not crash) |
| RAM (even with ECC) | Corruption from cosmic rays or permanent physical defects; >1% of machines/year hit an uncorrectable error (usually crashes the machine and forces module replacement); certain pathological access patterns can flip bits with high probability |
| Other components (power supplies, RAID controllers, memory modules) | Also fail, but less often than drives |
| Datacenters | Whole-DC unavailability from power outage or network misconfig; permanent destruction by fire, flood, or earthquake; a solar storm ejecting charged particles induces large currents in long-distance wires, threatening power grids and undersea cables — rare but catastrophic if not tolerated |

Small systems can often just replace broken hardware; at large scale, hardware faults are **part of normal operation** and must be handled in software.

**Redundancy:** RAID, dual power supplies, hot-swap CPUs, backup generators — keeps a single machine up for years. Redundancy works best when faults are **independent**, but real component failures are significantly **correlated** (whole racks and datacenters fail together). Cloud providers expose **availability zones** to mark physically co-located resources that are likely to fail together.

Cloud-era stance: worry less about individual machine reliability; achieve high availability **at the software level** by tolerating loss of whole machines, racks, or zones. Bonus: a multi-node fault-tolerant system supports **rolling upgrades** (patch one node at a time, no planned downtime), which a single-server system cannot.

### Software faults — the harder problem

Hardware failures can be weakly correlated but are still mostly independent (if one disk dies, the others are likely fine for a while); **software faults are highly correlated** because every node runs the same code with the same bugs. They cause more failures than hardware faults. Examples:
- A bug that crashes every node simultaneously under the same trigger (2012 leap-second bug hung many Java apps via a Linux kernel bug; a firmware bug killed certain SSD models after exactly 32,768 hours).
- A runaway process exhausting a shared resource (CPU, memory, disk, bandwidth, threads) — e.g., a process eating too much memory on a large request gets OOM-killed, or a buggy client library sends far more requests than anticipated (the chapter cites "Clients Are Jerks: How Halo 4 DoSed the Services at Launch").
- A dependency slowing down, hanging, or returning corrupted responses.
- Emergent behavior from interactions between systems that each test fine in isolation.
- **Cascading failures:** one overloaded component overloads the next.

These bugs lie dormant until an unusual circumstance violates an assumption the software was making about its environment. No silver bullet — mitigations: scrutinize assumptions and interactions, thorough testing, process isolation, crash-and-restart design, avoid feedback loops (retry storms), and measure/monitor production behavior.

### Humans and reliability

A study of large internet services found **operator configuration changes were the leading cause of outages; hardware faults played a role in only 10–25% of cases**. Humans don't just follow rules — their creativity and adaptiveness is a strength, but it also brings unpredictability and mistakes.

- "Human error" is a symptom of a sociotechnical-system problem, not a root cause. Blame is counterproductive.
- Technical mitigations: thorough testing (including property tests on random inputs), fast **rollback** for config changes, **gradual rollouts**, detailed monitoring and observability, interfaces that make the right thing easy.
- Organizational mitigation: **blameless postmortems** — full disclosure without punishment so the org learns; outcomes may include changed priorities or incentives.
- When investigating incidents, distrust simplistic answers ("Bob should have been more careful" and "rewrite it in Haskell" are equally unproductive).
- Reality check: organizations often choose features over resilience investment; when the predictable mistake happens, the problem is the priorities, not the person.

### How important is reliability?

Even mundane apps carry stakes: lost productivity, legal risk from wrong figures, lost revenue and reputation from ecommerce outages. **Temporary outages of minutes/hours are often tolerable; permanent data loss or corruption is usually catastrophic.** The UK Post Office Horizon scandal (1999–2019): accounting-software bugs led to hundreds of wrongful theft/fraud convictions, enabled by a legal presumption that computers operate correctly. It's legitimate to sacrifice reliability to cut cost (e.g., a prototype for an unproven market) — but do it consciously and know the consequences.

## Scalability

**Scalability = a system's ability to cope with increased load.** It is not a one-dimensional label; "X is scalable" is meaningless. The real questions:
- If load grows in a particular way, what are the options for coping?
- How do we add resources for the extra load?
- At current growth, when do we hit the limits of the current architecture?

**When NOT to worry about scale:** a startup or new product with few users should optimize for simplicity and flexibility to iterate on product-market fit. Premature scalability work is at best wasted effort and at worst locks you into an inflexible design. Scale up your worry only once you have real load and can see actual bottlenecks.

### Understanding load

Before discussing growth, quantify current load: requests/sec, GB of new data/day, checkouts/hour — and sometimes peaks (simultaneous online users). Also capture distributional characteristics: read/write ratio, cache hit rate, items per user (e.g., followers). Your bottleneck may be the average case or a small number of extreme cases — it depends on the application.

Two ways to frame load growth:
1. Increase load, hold resources fixed → how does performance degrade?
2. Increase load → how many more resources to hold performance constant?

Goal: stay within SLA at minimum cost. Some hardware types are more cost-effective than others, and the calculus shifts over time as new hardware appears. **Linear scalability** (2× resources → 2× load at same performance) is good. Occasionally sub-linear cost is possible (economies of scale, better peak-load distribution across tenants); far more often cost grows **faster** than linearly (e.g., with more data, a single write costs more even at the same request size).

### Shared-memory, shared-disk, shared-nothing

- **Vertical scaling / scaling up (shared-memory):** one bigger machine; threads share RAM. Individual CPU cores are no longer getting significantly faster, so "bigger" means more cores, RAM, and disk. Cost grows faster than linearly — a machine with 2× resources costs much more than 2× and, due to bottlenecks, handles less than 2× the load.
- **Shared-disk:** independent machines, shared disk array over NAS/SAN. Traditionally used for on-prem data warehousing; **contention and locking overhead limit scalability**.
- **Shared-nothing / horizontal scaling / scaling out:** each node has its own CPUs, RAM, and disks; all coordination over the network in software. Advantages: potential for linear scaling, best price/performance hardware (especially cloud), elastic resource adjustment, and fault tolerance across datacenters/regions. Costs: requires explicit **sharding** and all the complexity of distributed systems.
- **Modern cloud-native hybrid:** separate storage and compute services, multiple compute nodes sharing one storage service. Resembles shared-disk but avoids its scalability problems by replacing the filesystem/block abstraction with a storage API purpose-built for the database (e.g., Socrates/SQL Server in the cloud).

### Principles for scalability

- **No magic scaling sauce:** large-scale architecture is application-specific. 100,000 req/s at 1 kB each and 3 req/min at 2 GB each have identical data throughput (100 MB/s) but need completely different designs.
- An architecture for one load level rarely survives **10× that load**. On a fast-growing service, expect to rethink the architecture at every order of magnitude. **Don't plan more than one order of magnitude ahead.**
- Core technique: **break the system into smaller components that operate largely independently** (underlies microservices, sharding, stream processing, shared-nothing). The hard part is choosing where to draw the boundaries.
- **Don't over-complicate:** a single-machine database beats a distributed setup if it suffices. With predictable load, manual scaling has fewer surprises than autoscaling. 5 services are simpler than 50. Good architectures pragmatically mix approaches.

## Maintainability

Most software cost is in ongoing maintenance, not initial development: bug fixes, operations, failure investigation, platform adaptation, new use cases, tech-debt repayment, new features. Every valuable system becomes a legacy system; design for the maintainers. Legacy maintenance is as much a people problem (lost institutional knowledge, outdated tech few engineers know — mainframes and COBOL are the canonical example, plus fixing other people's mistakes) as a technical one, because computer systems are intertwined with the human organizations they support.

Three design principles:

### Operability — make it easy to keep the system running
- Good operations can work around bad software, but good software cannot run reliably with bad operations.
- Automation is essential at scale but double-edged: the cases automation can't handle are the most complex, so heavy automation demands a *more* skilled ops team, and a misbehaving automated system is harder to troubleshoot than a manual one. More automation is not always better; find the sweet spot.
- Good operability = making routine tasks easy so the operations team can focus on high-value activities.
- Concrete operability features: support monitoring/observability of key metrics; no dependency on individual machines (allow maintenance without downtime); good docs and a predictable operational model ("if I do X, Y happens"); sane defaults with admin overrides; self-healing plus manual control of system state; minimize surprises.

### Simplicity — manage complexity
- Complexity ("big ball of mud") slows everyone, blows budgets, and breeds bugs: hidden assumptions, unintended consequences, unexpected interactions.
- Simplicity is subjective — a complex implementation behind a simple interface vs. a simple implementation exposing internals; the essential/accidental complexity split is also flawed because tooling shifts the boundary.
- The best tool is **abstraction**: hide implementation detail behind a clean façade, reuse it widely, and let quality improvements propagate to all users. Examples: high-level languages (hide machine code), SQL (hides on-disk structures, concurrency, crash recovery). This book's subject matter is general-purpose abstractions — transactions, indexes, event logs — on top of which app-level methods (design patterns, DDD) can build.

### Evolvability — make change easy
- Requirements never stop changing: new facts, use cases, priorities, platforms, regulations, growth.
- Agile working patterns and tools (test-driven development, refactoring) handle change at the level of one codebase; **evolvability** is the analogous agility at the level of a data system made of several applications or services. Loosely coupled, simple systems are easier to modify than tightly coupled, complex ones.
- **Minimize irreversibility:** a database migration you can roll back is far lower-stakes than one you cannot. Irreversible actions demand extra caution; reversibility buys flexibility.

## How this connects

- The fan-out/materialized-view case study foreshadows caching, derived data, and stream processing; **exactly-once semantics** for fault-tolerant fan-out is covered in Chapter 12 (stream processing).
- Random delay sources and timeouts are expanded in the distributed-systems problems chapter ("Timeouts and Unbounded Delays", Ch. 9 territory).
- Shared-nothing scaling requires **sharding (Chapter 7)** and incurs distributed-system complexity **(Chapter 9)**; fault-tolerance via cross-datacenter takeover appears in **Chapters 6 and 10** (replication, consistency/consensus).
- Rolling upgrades and schema/code evolution connect to **Chapter 5** (encoding and evolution).
- Separation of storage and compute, operations in the cloud era, and microservices/serverless refer back to **Chapter 1**.
- The abstraction principle (transactions, indexes, event logs as building blocks) frames the entire rest of the book.
