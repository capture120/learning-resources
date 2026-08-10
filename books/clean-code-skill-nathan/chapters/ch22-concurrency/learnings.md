# Chapter 22: Concurrency

Concurrency is a decoupling strategy — it separates *what* gets done from *when* it gets done — but that decoupling makes correctness radically harder. Code can look fine and pass tests yet harbor failures that surface only under load, once in a million executions. The defense is rigor: isolate thread-aware code, minimize shared data, keep locks small, and test aggressively in many configurations. "Objects are abstractions of processing. Threads are abstractions of schedule." (Coplien). The chapter is by Brett L. Schuchert; a Robert C. Martin sidebar notes everything here applies equally to services and microservices.

## Why Concurrency?
Adopt concurrency for structure or for throughput/response-time constraints, not by default. In single-threaded code, what and when are so strongly coupled that a stack backtrace often reveals the state of the entire application — a debugger with breakpoints tells you everything; concurrency trades away that visibility. Decoupling what from when makes a system look like many small collaborating computers rather than one big main loop, which separates concerns and can improve understanding. Throughput gains come only when there is significant wait time (e.g., I/O at web sockets) to overlap, or genuinely parallel processors. Even managed environments (servlets, modern web stacks) provide imperfect decoupling — you must still understand concurrent update and deadlock.

## Myths and Misconceptions
- *Concurrency always improves performance* — false; it helps only when wait time can be shared across threads or processors.
- *Design does not change when writing concurrent programs* — false; decoupling what from when usually has a huge effect on system structure.
- *Understanding concurrency doesn't matter when a web server manages it* — false; you must know what your server does and guard against concurrent update and deadlock.

Balanced truths: concurrency incurs overhead (performance and extra code); correct concurrency is complex even for simple problems; concurrency bugs aren't usually repeatable, so they get dismissed as one-offs ("cosmic rays") instead of real defects; concurrency often requires a fundamental change in design strategy.

## Why It's Hard: the Pathway Explosion
Even one line like `return ++lastIdUsed;` shared by two threads has 12,870 possible bytecode execution paths (2.7 million if the field is a `long`). Most paths yield correct results; a few don't. This is why bugs are rare, random-seeming, and nearly impossible to reproduce — and why intuition about "code that obviously works" fails.

## Single Responsibility Principle
Concurrency design is complex enough to be a reason to change in its own right, so it deserves separation from the rest of the code. Concurrency-related code has its own development/change/tuning life cycle and its own, harder challenges; don't burden it with surrounding application logic. **Recommendation: keep your concurrency-related code separate from other code.**

## Corollary: Limit the Scope of Data
Severely restrict access to any data that may be shared. Every additional place that touches shared data multiplies the chances you forget to guard one (breaking all the code that modifies it), duplicates guarding effort (a DRY violation), and obscures the source of failures. Use critical-section protection (e.g., `synchronized`) but restrict how many critical sections exist. A Martin sidebar adds: consider a functional language, or at least a functional style, when writing concurrent modules.

## Corollary: Use Copies of Data
A good way to avoid shared-data problems is to not share the data in the first place. Copy objects and treat them as read-only, or give each thread a copy, collect results, and merge in a single thread. Don't assume the object-creation cost is prohibitive — experiment; avoiding synchronization usually saves more than the extra creation and garbage collection costs.

## Corollary: Threads Should Be as Independent as Possible
Write each thread as if it lives in its own world: one client request per thread, all data from an unshared source, stored in local variables, no synchronization needed. (Servlets approximate this — data arrives as method parameters — until threads hit shared resources like database connections.) **Recommendation: partition data into independent subsets that independent threads (possibly on different processors) can operate on.**

## Know Your Language and Library
Use the provided thread-safe collections (in Java, `java.util.concurrent` — `ConcurrentHashMap` outperforms `HashMap` in nearly all situations and supports composite operations safely); use threading frameworks like `Executor` for unrelated tasks; prefer nonblocking solutions when possible; know which library modules are and are not thread safe. In Java, learn `java.util.concurrent`, `.atomic`, and `.locks`.

## Know Your Execution Models
Most concurrency problems you will meet are variations of three canonical problems. Study them and write solutions yourself so you recognize them in the wild:
- **Producer-Consumer**: producers put work on a bound queue; consumers take it; both signal and wait on the queue's state.
- **Readers-Writers**: balancing reader throughput against writer freshness; a simple wait-for-no-readers strategy starves writers if readers are continuous, and giving frequent writers priority makes throughput suffer.
- **Dining Philosophers**: threads competing for limited resources; careless designs yield deadlock, livelock, and throughput/efficiency degradation.

## Beware Dependencies Between Synchronized Methods
Two independently `synchronized` methods on the same shared class can still combine incorrectly. **Recommendation: avoid using more than one method on a shared object.** When you can't, three correct options: **client-based locking** (client locks the server across the whole call sequence), **server-based locking** (server exposes one method that locks, calls everything, unlocks), or an **adapted server** (an intermediary that does the locking when the original server can't change).

## Keep Synchronized Sections Small
Locks are expensive: they create delays and add overhead. Guard every genuine critical section (any code that must be protected from simultaneous use for the program to be correct), but design for as few critical sections as possible — and don't "simplify" by making sections large, because extending synchronization beyond the minimal critical section increases contention and degrades performance.

## Writing Correct Startup and Shutdown Code Is Hard
Graceful startup/shutdown is a deadlock minefield: a parent waiting on a deadlocked child never finishes; a consumer blocked waiting on a producer that already shut down never receives the shutdown signal. These hangs apply equally to startup scenarios. **Recommendation: think about startup and shutdown early and get them working early; it will take longer than you expect, so review existing algorithms.**

## Testing Threaded Code
Testing cannot prove threaded code correct, but good testing minimizes risk. **Write tests with the potential to expose problems and run them frequently under varied programmatic configurations, system configurations, and load. If a test ever fails, track it down — never dismiss it because it passes on the next run.** The fine-grained rules:

- **Treat spurious failures as candidate threading issues.** Threading bugs may surface once in a million runs; assume one-offs do not exist. The longer they are ignored, the more code is built on a faulty foundation.
- **Get your nonthreaded code working first.** Build simple thread-ignorant modules called by threads, testable outside the threaded environment. Never chase nonthreading and threading bugs at the same time.
- **Make your threaded code pluggable.** Run with one thread, several, or a varying number; against real collaborators or test doubles; with doubles that are fast, slow, or variable; for many iterations.
- **Make your threaded code tunable.** Thread counts come from trial and error: time performance under different configurations, make the count easy to change (even at runtime), and consider self-tuning by throughput and utilization.
- **Run with more threads than processors.** Forcing frequent task swaps exposes missing critical sections and deadlocks.
- **Run on different platforms.** OSes have different threading policies; tests of known-broken code failed less frequently on Windows XP than on OS X. Test in every potential deployment environment, early and often.
- **Instrument your code to try and force failures.** Add jiggling calls (`wait`, `sleep`, `yield`, `priority`) to alter execution orderings so broken code fails early and often. If jiggling breaks the code, the code was already broken — the jiggle merely made it evident (a footnote concedes this is not strictly true: the JVM doesn't guarantee preemptive threading, so an algorithm might always work on an OS that doesn't preempt threads, and the reverse is also possible). Hand-coding the calls is a shotgun approach. Dividing the system into modules that know nothing of threading and modules that control it makes instrumentation points easier to find and enables test jigs with varied sleep/yield regimens. Prefer an automated **jiggle point** (e.g., a `ThreadJigglePoint.jiggle()` that is a no-op in production and randomly sleeps/yields/falls through in tests), or instrumentation tools. **Use jiggling strategies to ferret out errors.**

## 2025 Update and Report from the Field
Modern stacks (React Native, serverless Lambdas, managed datastores) purport to handle "all the multiuser stuff," but the original problems still exist whenever multiple users depend on shared data. Eventual consistency (DynamoDB), uncoordinated rendering loops, and uncontrolled async resource loading all reproduce classic concurrency failures. Key lesson: once you discover a shared-data issue, there is no single fix — the field report shows five problems solved five different ways:
- Isolate the non-thread-safe code and execute it later in a single thread (isolate and separate).
- Lock objects with a flag (application-level lock) rather than long-lived database transactions.
- Do nothing — accept the race when humans can cheaply detect and recover, and preventing it would reduce the value of the experience.
- Don't start the second parallel activity until it's actually needed; clear it first when state changes.
- Impose ordering structurally via a parent–child relationship so the child can't run before the parent initializes.

In several of these cases the fix also produced cleaner code overall: related things moved together, duplication disappeared, the UX got simpler.

## Conclusion Principles
- Break the system into simple modules that separate thread-aware from thread-ignorant code; keep thread-aware code small and focused, and test only it.
- Know the sources of concurrency issues: multiple threads on shared data, common resource pools, and boundary cases (startup, shutdown, loop-iteration ends).
- Lock exactly the regions that must be locked; do not lock regions that don't need it; avoid calling one locked section from another. Keep the number of shared objects and the scope of sharing as narrow as possible.
- Change designs of shared-data objects to accommodate clients rather than forcing clients to manage shared state.
- Invest early in instrumentation and run thread-based code in many configurations on many platforms, repeatedly and continuously, before production.

## In practice
- Before adding threads/async, ask whether structure or throughput genuinely requires it; concurrency adds overhead and a different design.
- Put all concurrency mechanics in their own small, focused modules; keep business logic thread-ignorant (SRP).
- Shrink shared mutable state: encapsulate it, copy it, or partition it so each thread works on independent data with local variables.
- Prefer library thread-safe collections, executors, and nonblocking primitives over hand-rolled synchronization; verify which modules are thread safe.
- Recognize whether your problem is Producer-Consumer, Readers-Writers, or Dining Philosophers, and apply known solutions.
- Avoid multiple synchronized methods on one shared object; when unavoidable, use client-based, server-based, or adapted-server locking around the whole sequence.
- Keep every synchronized section as small as possible; never nest or chain locked sections casually.
- Design and test graceful startup/shutdown early; budget extra time for it.
- Get nonthreaded code passing tests before introducing threads; never debug both classes of bug simultaneously.
- Make threaded code pluggable and tunable; run tests with more threads than cores, on every target platform, under varied load.
- Treat every flaky or spurious test failure as a candidate threading bug; never write it off as a one-off.
- Instrument code with jiggle points (no-op in production, random sleep/yield in tests) to force rare orderings.
- In "managed" modern stacks (serverless, eventually consistent stores, multiple render loops), still audit every place multiple users or async activities touch shared data; pick the fix that fits — serialize, flag-lock, structurally order, defer, or even deliberately accept the race when recovery is cheap.
