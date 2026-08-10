# Chapter 22: Concurrency — Examples

### The ID generator with 12,870 execution paths
The chapter's opening demonstration of why concurrency is hard. A trivial class:

```java
public class X {
    private int lastIdUsed;
    public int getNextId() {
        return ++lastIdUsed;
    }
}
```

Set `lastIdUsed` to 42, share one instance between two threads, and have both call `getNextId()`. Three outcomes are possible: (43, 44), (44, 43), or — surprisingly — both threads getting 43 with the field ending at 43. The threads can interleave through that single line of code in 12,870 different bytecode-level execution paths (2,704,156 if the field is a `long`). Most paths produce valid results; a few don't. Lesson: even one-line code hides an enormous space of interleavings, which is why concurrency bugs are rare, random-seeming, and invisible to ordinary inspection and testing.

### The single-threaded information aggregator
A system fetches data from many websites and merges it into a daily summary, hitting each site in turn. As sites are added, the run exceeds its 24-hour window — most of the time is spent waiting on web-socket I/O. A multithreaded algorithm that hits multiple sites at once recovers the throughput. Lesson: concurrency improves performance specifically when there is lots of shareable wait time, illustrating "why concurrency" alongside the one-user-per-second responsiveness example (no user wants to wait behind 150 others) and parallel processing of large data sets across machines.

### The servlet model
Web servers run servlets asynchronously per request, partially managing concurrency for the programmer; each servlet execution lives in its own little world with data arriving as parameters to `doGet`/`doPost`. As long as a servlet uses only local variables, it cannot cause synchronization problems — it acts as if it has its own machine. But the decoupling is imperfect: real applications eventually hit shared resources like database connections, so servlet programmers must still understand concurrent update and deadlock. Lesson anchored: threads should be as independent as possible, and managed environments don't excuse you from understanding concurrency.

### The three canonical execution models
Presented as the patterns underlying most real concurrency problems:
- **Producer-Consumer**: producers place work on a bound queue, consumers take it; each side waits and signals on the queue's empty/full state.
- **Readers-Writers**: a mostly-read shared resource occasionally updated by writers; making writers wait for zero readers starves writers, while prioritizing writers kills read throughput. The whole problem is finding that balance without concurrent-update bugs.
- **Dining Philosophers**: philosophers (threads) around a table each need two forks (resources) to eat; competition like this, unless carefully designed, produces deadlock, livelock, and throughput degradation — just like enterprise processes competing for resources.

Recommendation attached: study these algorithms and implement them yourself in advance so you recognize production problems as variations of them.

### Deadlocked shutdown scenarios
Two short war-story sketches about graceful shutdown. First: a parent thread spawns children and waits for all to finish before releasing resources; one child deadlocks, so the parent waits forever and the system never shuts down. Second: a parent signals all children to finish, but two children are a producer/consumer pair — the producer shuts down promptly, and the consumer, blocked waiting for a message from the producer, can never receive the shutdown signal, hanging the parent too. Lesson: plan startup/shutdown early; it is harder and takes longer than you think.

### Hand-inserted yield in `nextUrlOrNull`
Demonstrates hand-coded instrumentation to force failures:

```java
public synchronized String nextUrlOrNull() {
    if (hasNext()) {
        String url = urlGenerator.next();
        Thread.yield(); // inserted for testing.
        updateHasNext();
        return url;
    }
    return null;
}
```

The inserted `yield()` changes the execution pathways and may make latent bugs surface. If the code breaks, the yield didn't break it — the code was already broken; the yield made the failure evident. Drawbacks listed: you must guess where to place calls, production code is slowed if they remain, and it's a shotgun approach with poor odds.

### `ThreadJigglePoint` — automated jiggling
The improvement over hand-coded yields. A seam class:

```java
public class ThreadJigglePoint {
    public static void jiggle() {
    }
}
```

Calls to `ThreadJigglePoint.jiggle()` are sprinkled between statements of the code under test (the book shows `nextUrlOrNull` with three jiggle calls). Two implementations exist: the production one does nothing; the test one randomly sleeps, yields, or falls through. Run the tests a thousand times with random jiggling and you may root out flaws — and if they pass, you've done due diligence. Tools like CGLIB or ASM can insert the calls automatically. Lesson: combine well-written tests with jiggling to dramatically raise the odds of finding ordering bugs.

### The OS X vs. Windows XP course material
In mid-2007 the authors built a concurrency course on OS X and taught it on Windows XP in a VM. Tests written to demonstrate failure in deliberately broken code failed far less often on XP than on OS X — even though the code was known incorrect in all cases. Lesson: operating systems have different threading policies, so multithreaded code behaves differently per environment; run threaded tests on every potential deployment platform. (Footnote: the JVM doesn't even guarantee preemptive threading.)

### Field report: joining a game (DynamoDB eventual consistency)
A 2025-update case study. A mobile training-game platform capped games at six players, each assigned a role 1–6. The original implementation combined login, joining a game, and role assignment in one parallel flow against DynamoDB, which is only eventually consistent. Result: months of occasional "lost players," duplicate roles, and overfilled games. The fix expanded the domain rather than fighting the database: players now join a *waiting room* at login, and later an administrator assigns all waiting players to games in a single request. This moved the non-thread-safe work (game joining and role assignment) from parallel execution by many clients to later execution by a single thread/single user — "isolate and separate." Side benefit: the UX got simpler (pick a waiting room from a dropdown instead of game name + username + password) and less error prone. Lesson: sometimes the cleanest concurrency fix is a domain redesign that removes the parallelism, not cleverer synchronization.

### Field report: working on a shared design (flag-based locking)
A system for collaboratively designing commercial security installations, backed by a relational database. Designs have dozens of images with connected elements; typically fewer than five users work on different parts, so conflict probability was low. The team piggybacked on an existing interaction — selecting an element to edit it — and made selection set a *locked flag* on the element. Locking an already-locked element fails and tells the user; deselection releases the lock. They chose a flag over a database lock because the latter would require long-lived transactions. With proper transaction isolation, this is a clean, safe solution. Lesson: lightweight application-level locks, attached to a natural user action, can beat heavyweight database locking.

### Field report: parallel deck-building (the anti-case)
A mobile game where up to four players collaboratively build a deck of cards, possibly creating duplicates in parallel. The team identified the race early — and deliberately chose not to fix it. Duplicate cards just get the deck rejected by the instructor; the team cleans up and resubmits, and the incident sparks valuable discussion about collaboration and communication. Preventing the duplication would have reduced the experience's value. Lesson: "do nothing" is a legitimate concurrency strategy when humans can detect and recover cheaply and the race has upside.

### Field report: double-deleting Skia resources on rerender
A React Native (plus React Native Web) app used the Skia 2D graphics library, which has its own rendering engine — two unsynchronized rendering loops running simultaneously. No problems appeared until designs were loaded asynchronously: React Native would rerender the view mid-load (normal for React Native), and Skia would delete then re-delete the same resources, crashing the app. The fix: render the Skia view only when loading is complete (otherwise render an empty view); on any change that triggers a rerender, first clear a setting to stop Skia rendering, then set the new value so everything renders fresh. The result was cleaner code overall. Lesson: when two parallel engines aren't coordinated, gate the second one — allow it to run only when its preconditions hold, and shut it off before changing shared state. It wasn't a Skia bug; it was how they used it.

### Field report: loading icon resources (ordering via parent–child)
Designs could load before the icon-loading code had started executing, leaving missing icons or forcing a reload. The fix moved icon resources into a React Native *provider*, and ensured any code that could load a design executes under that provider. The parent–child relationship guarantees the parent (icons) initializes before any child (design loading) runs. This also pulled related things closer together and removed duplication. Lesson: enforce required ordering structurally, through component hierarchy, rather than hoping async timing works out.

### The five problems, five different fixes
The field report closes by lining up its examples: parallel game-join with an eventually consistent store; parallel editing of a shared design; parallel card creation; uncoordinated dependent render loops; uncontrolled async resource loading. The matching fixes: isolate and serialize the unsafe part; flag-based locking; deliberately do nothing; gate the second thread until needed and clear it first; impose parent–child ordering. Lesson: shared-data problems have no single recipe — once you find one, choose among many approaches based on the domain, the cost of failure, and recoverability.
