# Chapter 2: Defining Nonfunctional Requirements — Examples

All examples below come from the chapter; none are invented.

## Social network home timeline: query-on-read

A simplified X/Twitter clone stores users, posts, and follow relationships in three relational tables. The home timeline (recent posts by followed accounts) is computed by a SQL join: find everyone the user follows, fetch their recent posts, sort by timestamp, take the latest 1,000. Assumed load: 500M posts/day (5,800/sec average, spikes to 150,000/sec); average user follows 200 people and has 200 followers.

To make posts appear within 5 seconds, clients could poll this query every 5 seconds. With 10M concurrent online users, that's 2M queries/sec, each touching ~200 followed accounts — 400M lookups/sec. Worse, some users follow tens of thousands of accounts, making their query individually expensive.

**Demonstrates:** a straightforward query-on-read design can be correct yet infeasible at scale; load analysis (throughput × fan-in) exposes this before building.

## Social network home timeline: materialized timelines with fan-out

Instead of polling, the server pushes: each user has a precomputed home timeline data structure, and every new post is inserted into the timeline of each follower, like delivering mail to mailboxes. Reads become cache hits; clients subscribe to a stream of timeline additions. The cost moves to writes: 5,800 posts/sec × fan-out of 200 = ~1M timeline writes/sec — still large, but 400× cheaper than 400M lookups/sec. During posting spikes, deliveries can be queued and delayed slightly; timeline reads stay fast because they hit the cache.

**Demonstrates:** materialization (precomputing a query result) trades extra write work for cheap reads — the right trade when reads vastly outnumber writes; buffering writes absorbs load spikes.

## The follower-of-everyone and the celebrity

Two extreme cases break the simple fan-out design. First, a user following a huge number of busy accounts receives a torrent of timeline writes — but since they can't read everything anyway, it's acceptable to drop some writes and show a sample (the chapter cites a Bluesky write-up calling this "lossy timelines"). Second, a celebrity with millions of followers (e.g., Barack Obama, 100M+) would require millions of timeline insertions per post, and dropping those is not acceptable. Solution: store celebrity posts separately and merge them into each follower's materialized timeline at read time. Even with such optimizations, handling celebrities can require a lot of infrastructure — the chapter cites a report titled "3% of Twitter's Servers Dedicated to Justin Bieber."

**Demonstrates:** the tail of a load distribution often needs a different code path than the average case; hybrid push/pull designs handle skewed fan-out.

## Retry storms and metastable failure

A system running near its throughput limit develops long queues; response times grow until clients time out and resend requests. The retries add load, lengthening queues further — a retry storm. The system can stay overloaded even after the original load drops, recovering only after a reboot or reset. This is a metastable failure, a documented cause of serious production outages. Countermeasures: exponential backoff with randomization on clients, circuit breakers or token buckets to stop calling a failing service, load shedding and backpressure on servers.

**Demonstrates:** overload creates self-reinforcing feedback loops; well-intentioned retries can be the mechanism that prevents recovery.

## Amazon and the 99.9th percentile

Amazon defines internal service response-time requirements at p999 — affecting only 1 in 1,000 requests — because the slowest requests tend to come from customers with the most data in their accounts, i.e., the customers who have bought the most and are the most valuable. Keeping the site fast for them is worth the cost. Amazon judged optimizing p9999 (1 in 10,000) too expensive: at very high percentiles, response times are dominated by random events outside your control, and the benefit diminishes.

**Demonstrates:** tail latency targets are a business decision; the tail often correlates with your most valuable users, but there's a percentile beyond which optimization stops paying.

## Tail latency amplification across backend calls

One end-user request fans out to several backend service calls in parallel. The user-visible response time is the time of the slowest call. Even if only a small percentage of backend calls are slow, a request making many calls has a high chance of hitting at least one slow call, so a much larger fraction of end-user requests end up slow.

**Demonstrates:** in service-oriented architectures, backend p99s compound; high percentiles of internal services matter more than their medians.

## Conflicting studies on latency and user behavior

In 2006 Google reportedly found that slowing search results from 400 ms to 900 ms cut traffic and revenue by 20% — but a 2009 Google study found a 400 ms latency increase reduced searches by only 0.6%. Bing (2009) found a 2-second load-time increase cut ad revenue 4.3%. Newer data from these companies appears not to be publicly available. An Akamai study claimed +100 ms reduced ecommerce conversions up to 7%, yet the same data showed very fast pages also converting poorly — because the fastest-loading pages were contentless 404 pages; the study never separated content effects from speed effects. The most credible result is Yahoo's, conducted the year after the Akamai study: controlling for result quality, fast search results got 20–30% more clicks than slow ones when the gap was at least 1.25 seconds.

**Demonstrates:** latency affects user behavior, but widely cited statistics are often confounded or contradictory — scrutinize methodology before using such numbers to justify engineering work.

## Averaging percentiles is meaningless

To put percentiles on a dashboard, you might keep a 10-minute rolling window of response times and compute the median and percentiles each minute (sorting the list, or using approximation libraries like HdrHistogram, t-digest, OpenHistogram, DDSketch). A common mistake is averaging percentile values to lower time resolution or to combine data from several machines — that operation is mathematically meaningless. The correct aggregation is adding the underlying histograms.

**Demonstrates:** percentiles don't compose by averaging; aggregate histograms, not summary statistics.

## A hard drive failing: fault or failure?

If a hard drive stops working, the drive has failed. If the whole system is just that one drive, the system has failed too. But if the system spans multiple drives with the data copied elsewhere, the dead drive is merely a fault of the larger system, which keeps providing service. Concretely: at 2–5% annual drive failure rates, a 10,000-disk cluster expects about one disk death per day — routine operation, not an emergency.

**Demonstrates:** fault vs. failure is a question of system boundary; fault tolerance converts component failures into non-events.

## Fan-out machine crash and exactly-once delivery

In the social network, a machine performing timeline fan-out might crash mid-delivery. Fault tolerance requires another machine to take over without missing any posts that should have been delivered and without duplicating any — exactly-once semantics (detailed in Chapter 12).

**Demonstrates:** fault tolerance isn't just "keep running"; it must preserve correctness guarantees through the failure.

## The black hole and the limits of fault tolerance

A system might tolerate two simultaneous disk failures or one of three nodes crashing, but tolerating arbitrary faults is absurd: if Earth and all its servers were swallowed by a black hole, tolerance would require hosting in space — good luck getting that budget approved.

**Demonstrates:** fault tolerance is always bounded to specific numbers and types of faults; state the bound explicitly.

## Correlated software faults: the leap second and the 32,768-hour SSD

On June 30, 2012, a leap second triggered a Linux kernel bug that made many Java applications hang simultaneously, taking down several internet services. Separately, a firmware bug caused all SSDs of certain models to fail after exactly 32,768 hours (under four years) of operation, with the data unrecoverable. In both cases, every node ran the same software and hit the same bug at the same time.

**Demonstrates:** software faults are highly correlated — redundancy doesn't help when all replicas share the bug; this makes software faults more dangerous than mostly independent hardware faults.

## Operators cause more outages than hardware

A study of large internet services found configuration changes by operators were the leading cause of outages, while hardware faults contributed to only 10–25% of cases. The chapter's reading: "human error" is a symptom of a flawed sociotechnical system, not a cause; mitigate with testing, rollback mechanisms, gradual rollouts, observability, well-designed interfaces, and blameless postmortems rather than blame and tighter rules.

**Demonstrates:** reliability engineering must include humans and processes, not just hardware and code.

## The parent's photo collection

Consider a parent who stores every photo and video of their children in your application. A few minutes or even hours of downtime may be tolerable; a corrupted database destroying the collection is catastrophic — and would they even know how to restore from a backup?

**Demonstrates:** availability and durability are different requirements; for many applications, data loss is far worse than downtime.

## The Post Office Horizon scandal

Between 1999 and 2019, hundreds of British Post Office branch managers were convicted of theft or fraud because the Horizon accounting software showed shortfalls in their accounts. Many of the shortfalls turned out to be due to software bugs; many convictions were eventually overturned. English law presumed computers operate correctly unless shown otherwise, so the software's output was treated as reliable evidence. People were wrongfully imprisoned and bankrupted; some died by suicide. It is probably the largest miscarriage of justice in British history.

**Demonstrates:** unreliable software causes real human harm; never assume software is bug-free, and beware institutions that do.

## Same throughput, completely different systems

A system handling 100,000 requests/sec at 1 kB each and a system handling 3 requests/min at 2 GB each both move 100 MB/sec — yet they require entirely different architectures. There is no generic "magic scaling sauce."

**Demonstrates:** scalability is multi-dimensional; raw data throughput alone doesn't determine the design — request size, rate, and access patterns do.

## "You're not Google" — when not to scale

For a new product with few users (e.g., at a startup), the right goal is keeping the system simple and flexible to iterate as you learn customers' needs. Investing in hypothetical future scale is at best wasted premature optimization and at worst locks you into an inflexible design. Once the product is popular, real load reveals the actual bottlenecks and the dimensions along which to scale — that's when to start.

**Demonstrates:** scalability work has timing; before product-market fit, simplicity beats scale.

## Rethinking architecture every order of magnitude

An architecture suited to one load level is unlikely to cope with 10× that load. A fast-growing service should expect to rethink its architecture at each order-of-magnitude increase, and shouldn't plan more than one order of magnitude ahead because needs will evolve.

**Demonstrates:** scaling plans have a short horizon; over-planning is wasted.

## High-level languages and SQL as abstractions

High-level programming languages hide machine code, CPU registers, and system calls. SQL hides on-disk and in-memory data structures, concurrent access from other clients, and inconsistency after crashes. You still use machine code when running a high-level language — you're just spared from thinking about it. The book itself focuses on general-purpose abstractions of this kind: transactions, indexes, event logs.

**Demonstrates:** good abstractions are the primary tool for managing complexity — they hide detail, enable reuse, and concentrate quality improvements.

## Irreversible database migration

When migrating from one database to another, the stakes depend on reversibility: if you can switch back to the old system when the new one misbehaves, mistakes are cheap; if you cannot, every problem is high-stakes. Minimizing irreversibility improves flexibility and makes systems easier to evolve.

**Demonstrates:** evolvability comes from keeping actions reversible; treat irreversible steps with extra caution.
