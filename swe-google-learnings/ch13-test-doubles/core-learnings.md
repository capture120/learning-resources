# Chapter 13: Test Doubles

*Software Engineering at Google* — written by Andrew Trenk and Dillon Bly, edited by Tom Manshreck.

## Chapter Thesis

A test double is an object or function that stands in for a real implementation in a test, the way a stunt double stands in for an actor. Test doubles let you write many small, fast, non-flaky unit tests for code whose real dependencies are slow, nondeterministic, or expensive (external servers, databases, payment services). But Google learned the hard way that test doubles are a double-edged sword: overusing them — especially via mocking frameworks — produces tests that are unclear, brittle, and ineffective, and that impose constant maintenance cost while rarely catching bugs. The chapter's central guidance is a preference ordering: use the **real implementation** whenever feasible; if not, use a **fake**; use **stubbing** sparingly and only when its purpose is directly tied to the test's assertions; and avoid **interaction testing** except in narrow cases, preferring **state testing** instead.

## Core Principles and Ideas

### What a test double is

- A **test double** stands in for a real implementation in a test. Examples range from a simpler look-alike implementation (an in-memory database) to objects that make it easy to trigger rare error conditions or confirm a heavyweight function was invoked without executing it.
- The practice is commonly called "mocking," but the chapter avoids that word because "mocking" also names a specific technique (interaction testing) and a category of tools (mocking frameworks).

### The three trade-off dimensions test doubles introduce

1. **Testability.** A codebase must be designed so tests can swap real implementations for test doubles. Retrofitting testability into a codebase written without testing in mind requires major refactoring, so invest early.
2. **Applicability.** Proper use of test doubles boosts engineering velocity; improper use produces brittle, complex, less effective tests, and the damage compounds across a large codebase. In many cases the right answer is to not use a double at all and use the real implementation.
3. **Fidelity.** Fidelity is how closely a test double's behavior matches the real implementation it replaces. A double with very low fidelity (e.g., a database double that ignores writes and always returns empty results) makes tests worthless. Perfect fidelity is usually infeasible — doubles must be simpler than the real thing to be useful — so unit tests using doubles often need to be supplemented by larger-scope tests that exercise the real implementation.

### Seams and testability

- **Testable code** is code structured so unit tests can be written for it. A **seam** is a point in the code where a test can substitute a different dependency than production uses — it is what makes test doubles possible.
- **Dependency injection** is the most common way to create seams: a class receives its dependencies (e.g., through its constructor) rather than instantiating them itself, so a test can pass in a double. Frameworks like Guice and Dagger (Java) automate the wiring.
- In dynamically typed languages (Python, JavaScript) you can replace individual functions or methods at runtime, so dependency injection matters less: you can use the real dependency and override only the unsuitable methods.
- Writing testable code is an upfront investment that gets harder to make the longer you defer it.

### Mocking frameworks

- A **mocking framework** is a library that makes creating test doubles easy: it lets you replace an object with a **mock**, a test double whose behavior you specify inline in the test, without defining a new class each time. Examples: Mockito (Java), googlemock in Googletest (C++), unittest.mock (Python).
- Google's history: mocking frameworks initially looked like "a hammer fit for every nail." Years later Google realized the resulting tests were easy to write but required constant maintenance while rarely finding bugs. The pendulum has swung back toward more realistic tests.

### The three techniques for using test doubles

1. **Faking.** A **fake** is a lightweight working implementation of an API that behaves like the real thing but isn't suitable for production — e.g., an in-memory database or file system. The system under test should not be able to tell it is talking to a fake.
2. **Stubbing.** Specifying return values inline for a function that otherwise has no behavior (e.g., Mockito's `when(...).thenReturn(...)`). Quick, but it hardcodes pieces of the dependency's contract into the test with no guarantee of correctness.
3. **Interaction testing.** Validating *how* a function is called (that it was called, how many times, with which arguments) without executing its implementation (e.g., Mockito's `verify(...)`). Sometimes itself called "mocking."

### Prefer real implementations (classical testing)

- Google's first choice is the **real implementation** — the same code used in production. This is called **classical testing**, as opposed to **mockist testing**, which prefers mocks. Google found mockist testing hard to scale.
- **Prefer realism over isolation.** Realistic tests give more confidence the system actually works. Tests that over-rely on doubles force engineers into extra integration testing or manual verification, or let bugs slip through when those steps get skipped.
- Replacing all dependencies with doubles arbitrarily isolates the test to whatever code the author happened to put in one class. A good test is written against the API being tested, independent of how the implementation is split across classes.
- If a real implementation has a bug and your test fails — that's good. That's the test doing its job. CI systems make cascading failures easy to trace to the offending change.
- Every use of stubbing or interaction testing **duplicates behavior provided by the API**; doubles frequently violate the real API's contract (e.g., returning null where the real method never can), and thousands of such duplications freeze an API owner's ability to change their implementation.

### Deciding when the real implementation is feasible

Use the real implementation when it is **fast, deterministic, and has simple dependencies**. Value objects (money amounts, dates, addresses, lists, maps) should always be real. Evaluate three factors:

1. **Execution time.** Unit tests must be fast for quick feedback. There is no exact threshold — one extra second per test may be fine for 5 tests but not 500. For borderline cases, use the real implementation until it becomes too slow, then switch. Test parallelization and a caching build system (e.g., Bazel) mitigate both runtime and build-time costs.
2. **Determinism.** A test is **deterministic** if the same version of the system always produces the same result. Nondeterminism causes **flakiness**, which erodes trust in the suite. Common causes: non-**hermetic** code (depending on external services outside the test's control, e.g., a live HTTP server), multithreading, and reliance on the system clock. Replace these with doubles (e.g., a hardcoded-time clock double) or hermetic server instances controlled by the test.
3. **Dependency construction.** Real implementations require constructing their whole dependency tree; a double needs one line. But rather than hand-building objects in tests, the ideal is to reuse production's construction code (factory methods, automated dependency injection) made flexible enough to accept doubles.

### Fakes in depth

- A fake is **often the ideal technique when a real implementation can't be used**. One well-engineered fake can radically improve the testing experience of an API; at organizational scale, fakes are a major velocity multiplier. Where fakes are rare, engineers fall back on slow/flaky real implementations or on stubbing and interaction testing.
- **Who writes fakes:** the team that owns the real implementation should write and maintain the fake, because a fake requires domain expertise and must be updated whenever the real implementation's behavior changes. Whether to write one is a cost/benefit call: worthwhile with hundreds of users, maybe not with a handful.
- **Where to fake:** create the fake at the **root** of the untestable code — fake the database API itself, not every class that calls the database.
- **Cross-language services:** rather than duplicating a fake per client language, run a single fake service and point client libraries at it. Heavier (cross-process), but acceptable if tests stay fast.
- **Fidelity of fakes:** a fake should maintain fidelity **to the API contract**: same inputs produce the same outputs and state changes as the real implementation. It need not match on things the contract doesn't guarantee (exact hash values, latency, resource consumption, disk vs. memory storage). Think of it as perfect fidelity *from the perspective of the test*.
- A fake need not implement 100% of functionality (e.g., rare error-handling edge cases). Unsupported paths should **fail fast** — raise an error — so engineers know the fake doesn't apply.
- **Fakes must be tested**, or their behavior silently diverges from the real implementation over time. The recommended approach is **contract tests**: one test suite written against the public API, run against both the real implementation and the fake. The slow real-implementation runs only burden the fake's owners.
- **If no fake exists:** (1) ask the API owners to create one; (2) write your own by wrapping all API calls in a single class and faking that wrapper (you usually need only a subset of the API) — and consider contributing it back; (3) fall back to the real implementation or other double techniques. A fake can be viewed as an **optimization**: only worth building if the speedup outweighs creation and maintenance cost.

### Stubbing in depth

Overused stubbing causes three failure modes:

1. **Tests become unclear.** The stub-setup code obscures the test's intent. Warning sign: you have to mentally step through the system under test to understand why functions are stubbed.
2. **Tests become brittle.** Stubbing leaks implementation details into the test. A good test should change only when the API's user-facing behavior changes, not when its implementation changes.
3. **Tests become less effective.** A stub like `when(stubCalculator.add(1, 2)).thenReturn(3)` duplicates the dependency's contract with no guarantee the duplication is correct. Stubs also hold no state, so you can't save an item and then read it back the way you can with a real implementation or fake.

**When stubbing is appropriate:** when you need a function to return a specific value to drive the system under test into a particular state, including error conditions or return values that a real implementation or fake can't easily produce. Rules of thumb: each stubbed function should relate directly to the test's assertions; stub only a small number of functions. Needing many stubs signals overuse or an over-complex system under test. Even when appropriate, real implementations or fakes remain preferred.

### Interaction testing in depth

- **Prefer state testing.** In **state testing** you call the system under test and assert on the returned value or resulting state. In interaction testing you can only assert that certain calls happened — you must *assume* the calls had the intended effect ("if `database.save(item)` was called, we assume it saved"). State testing validates the assumption.
- Interaction testing leaks implementation details just like stubbing. Googlers jokingly call tests that overuse it **change-detector tests**: they fail on any production-code change even when behavior is unchanged.
- **When interaction testing is warranted:**
  1. You cannot do state testing because no real implementation or fake is usable (e.g., the real thing is too slow and no fake exists). It provides a basic confidence fallback.
  2. The *number or order* of calls is itself the behavior under test — e.g., verifying a cache prevents extra database reads: `verify(databaseReader, atMostOnce()).selectRecords()`.
- Interaction testing never fully replaces state testing. If a unit test can only do interaction testing, supplement it with a larger-scope test (e.g., an integration test against a real database) that does state testing.
- **Best practice 1 — only verify state-changing functions.** Calls to dependencies are either **state-changing** (side effects on the world outside the system under test: `sendEmail()`, `saveRecord()`, `logAccess()`) or **non-state-changing** (pure reads: `getUser()`, `findResults()`, `readFile()`). Verify only state-changing calls; verifying reads is redundant (the return value flows into output you can assert on), brittle, and noisy. A clue: if a function was stubbed earlier in the test, verifying the same call is unneeded.
- **Best practice 2 — avoid overspecification.** Test one behavior per test method. Verify only the functions and arguments relevant to that behavior; use argument wildcards (`eq(...)` for the relevant argument, `any()` for the rest) and split unrelated verifications into separate tests. Overspecified tests fail when unrelated behavior changes.

## Actionable Guidance (team checklist)

- Prefer this ordering for test dependencies: real implementation → fake → stubbing → interaction testing.
- Always use real value objects (money, dates, addresses, collections) in tests.
- Design for testability from day one: inject dependencies through constructors; reuse production construction code (factories, DI frameworks) in tests.
- For borderline-slow dependencies, start with the real implementation and switch to a double only when tests demonstrably become too slow or flaky.
- Replace non-hermetic dependencies (live servers, system clock, thread-order-dependent code) with doubles or hermetic instances.
- If you own an API that others test against: ship a fake, test the fake with contract tests run against both fake and real implementation, and mark types with `@DoNotMock` (or your language's equivalent policy) where a real implementation or fake is the better choice.
- Have fakes fail fast on unsupported code paths.
- Create fakes at the root API (the database client), not per-caller wrapper classes throughout the codebase.
- In tests: keep stubs few and directly tied to assertions; verify only state-changing interactions; verify the minimum arguments needed; one behavior per test.
- When a unit test can only assert interactions, add a larger-scope test that does real state testing.

## TL;DRs (verbatim from the chapter)

- A real implementation should be preferred over a test double.
- A fake is often the ideal solution if a real implementation can't be used in a test.
- Overuse of stubbing leads to tests that are unclear and brittle.
- Interaction testing should be avoided when possible: it leads to tests that are brittle because it exposes implementation details of the system under test.
