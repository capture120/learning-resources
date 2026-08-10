# Chapter 6: Testing

Tests can easily become busywork: bad tests add developer overhead without providing value and make test suites unstable. This chapter teaches how to test effectively — what tests are actually for, the main test types and tools, how to take ownership of testing your own code, and how to find and eliminate nondeterminism, the disease that quietly destroys a test suite's value.

## Core Concepts

### The Many Uses of Tests

Tests do far more than check that code works:

- **Verify behavior.** Above all, tests verify that software behaves as expected. Unpredictable behavior hurts users, developers, and operators alike.
- **Protect against future change.** Tests first show code works as specified, then remain to shield existing behavior from new changes. When an old test fails, it forces a decision: did the developer intend to change behavior, or did they introduce a bug?
- **Encourage clean code and good interfaces.** Tests are usually the first place a developer interacts with their own code, so they expose clumsy interface design early, while it can still be corrected. Tests also expose messy implementation: spaghetti code — code with too many dependencies — is hard to test. Writing tests forces better separation of concerns and looser coupling.
- **Force developers to use their own APIs.** New code has rough edges; being its first consumer reveals them.
- **Document the code.** Tests illustrate how code is meant to be used. They're the first place an experienced programmer reads to understand a new codebase.
- **Serve as a playground.** Developers run tests with debuggers attached to step through code. When bugs are discovered or behavior questions arise, new tests can be added to understand them.

The code-cleanliness side effects of testing are so strong that **test-driven development (TDD)** — writing tests before code — has become commonplace. The tests fail when written; code is then written to make them pass. TDD forces thinking about behavior, interface design, and integration before cranking out implementation.

### Types of Tests

There are dozens of test types; these five form a foundation:

- **Unit tests** verify "units" of code — a single method or behavior. They should be fast, small, and focused. Speed matters because unit tests run frequently, often on developer laptops. Small, focused tests make it easy to see what broke when a test fails.
- **Integration tests** verify that multiple components work together. Rule of thumb: if you're instantiating multiple objects that interact with each other in one test, you're probably writing an integration test. They're slower, need more elaborate setup, and run less frequently (longer feedback loop), but they flush out problems that are difficult to identify by testing standalone units individually — components that each work perfectly can still be incompatible in combination.
- **System tests** verify a whole system. End-to-end (e2e) workflows simulate real user interactions in preproduction environments. Automation approaches vary: some organizations require system tests to pass before release, meaning all components are tested and released in lockstep. Organizations whose systems are too large to synchronize releases instead run extensive integration tests supplemented by **synthetic monitoring** — scripts running in production that simulate real user activity (register, browse, purchase). Synthetic monitoring requires instrumentation so billing, accounting, and other downstream systems can distinguish test traffic from real activity.
- **Performance tests** (load and stress tests) measure system performance under different configurations. **Load tests** measure performance under various levels of load — e.g., 10, 100, or 1,000 concurrent users. **Stress tests** push load to the point of failure, exposing how far a system can go and what happens under excessive load. Both are useful for capacity planning and defining SLOs.
- **Acceptance tests** are performed by a customer (or their proxy) to validate that delivered software meets acceptance criteria. They're common in enterprise software, where formal acceptance criteria are part of an expensive contract; ISO's security standard requires acceptance tests validating explicit business requirements, and certification auditors ask for documentation of both requirements and tests. In less regulated settings, acceptance testing is informal: "I just changed a thing; can you let me know if everything still looks good?"

Real-world caveat: successful projects are often inconsistent about test categories (intermingling "unit" and "integration" tests, missing whole flavors of tests). Know what the categories mean and their trade-offs, but don't obsess over perfect naming and categorization. Make pragmatic testing decisions, improve test suites when you get the chance, and don't pass judgment on imperfect setups — software entropy is a powerful force.

### Test Tools

Test tools fall into three categories: test-writing tools (e.g., mocking libraries), test execution frameworks, and code quality tools.

**Every tool added comes with baggage.** Everyone must understand the tool and its idiosyncrasies; the tool may pull in many other libraries, increasing system complexity; some tools slow tests down. Avoid adding outside tools until you can justify the complexity trade-off and your team is bought in.

#### Mocking Libraries

Mocks replace external dependencies (systems, libraries, objects) with stubs that mimic the real system's interface, responding to inputs with hard-coded responses. Benefits:

- Eliminating external dependencies keeps unit tests fast and focused.
- Mocking remote systems bypasses network calls, simplifying setup and avoiding slow operations.
- Mocking methods and objects allows focused unit tests that exercise one specific behavior.
- Mocks keep test-specific methods, parameters, and variables out of application code. Test-specific code changes are hard to maintain, hard to read, and cause confusing bugs (never add a boolean `isTest` parameter to a method). Mocks also let tests reach protected methods and variables without modifying regular code.

Don't overdo it. Mocks with complex internal logic make tests brittle and hard to understand. Start with basic inline mocks inside a unit test; only extract a shared mock class once you're repeating mocking logic between tests. Excessive reliance on mocks is a code smell suggesting tight coupling — whenever you reach for a mock, ask whether the code could be refactored to remove the dependency instead. Separating computation and data-transformation logic from I/O code simplifies testing and makes programs less brittle.

#### Test Frameworks

Frameworks help write and execute tests (unit, integration, performance, even UI). They:

- Manage test setup and teardown
- Manage test execution and orchestration
- Generate test result reports
- Provide tooling such as extra assertion methods
- Integrate with code coverage tools

**Setup/teardown:** lets you specify steps (data setup, file cleanup) before/after each test or set of tests. Frameworks offer multiple scopes — before each test, before all tests in a file, before all tests in a build — so read the documentation to use them correctly. Don't expect teardown to run in all circumstances: it won't run if a test fails catastrophically and kills the whole test process.

**Orchestration:** tests run serially or in parallel. Serial is safer (less chance of tests impacting each other); parallel is faster but more error-prone due to shared state, resources, or other contamination. Frameworks can start a new process per test for stronger isolation, but spawning processes is expensive.

**Reports:** show which tests passed, failed, or were skipped, which assertion failed, and organize logs and stack traces per test for quick debugging. Beware: result locations aren't obvious — a summary prints to the console while the full report goes to disk. Look in test and build directories if you can't find a report.

#### Code Quality Tools

**Linters** enforce code quality rules through static analysis and style checks; monitoring tools report metrics like complexity and coverage. Analysis tools usually run as part of the build or compile step.

- **Static code analyzers** catch common mistakes (open file handles, unset variables). They're especially important for dynamic languages like Python and JavaScript, which lack a compiler to catch syntax errors. They aren't immune to false positives — think critically about reported problems, and override false positives with code annotations that tell the analyzer to ignore a specific violation.
- **Code style checkers** enforce consistent formatting (line length, camelCase vs. snake_case, indentation). Consistent style helps multiple programmers collaborate on shared code. Set up your IDE to apply style rules automatically.
- **Code complexity tools** calculate **cyclomatic complexity** — roughly, the number of paths through the code. Higher complexity means harder to test and more likely to contain defects. Complexity naturally grows with codebase size, so a high overall score isn't necessarily bad — but a sudden jump in complexity, or individual highly complex methods, are causes for concern.
- **Code coverage tools** measure how many lines of code the test suite exercises. If your change lowers coverage, write more tests, and make sure tests exercise your new changes. Aim for reasonable coverage — rule of thumb: 65 to 85 percent. Coverage alone is a misleading quality measure both when high and when low: measuring generated code (scaffolding, serialization classes) creates misleadingly low numbers, while obsessively hitting 100 percent doesn't guarantee the code integrates safely.

Engineers tend to fixate on quality metrics. A tool flagging an issue doesn't mean it's actually a problem or worth fixing immediately. Be pragmatic with codebases that fail quality checks: don't let code get worse, but avoid disruptive stop-the-world cleanup projects. Treat quality fixes like technical debt — fix deliberately, when it's worth it.

### Writing Your Own Tests

**You are responsible for making sure your team's code works as expected. Write your own tests; don't expect others to clean up after you.** Many companies have formal quality assurance (QA) teams with varying responsibilities: writing black-box or white-box tests, writing performance tests, performing integration/user-acceptance/system tests, providing and maintaining test tools, maintaining test environments and infrastructure, and defining formal test certification and release processes.

QA teams help verify code is stable, but never "throw code over the fence" for them to do all the testing — and QA teams don't write unit tests anymore; those days are long gone. If your company has a formal QA team, find out what they own and how to engage them: embedded QA likely attends scrum and sprint planning; centralized QA may require tickets or formal requests.

#### Write Clean Tests

Write tests with the same care as production code. Tests introduce dependencies, require maintenance, and need refactoring over time; hacky tests carry a high maintenance cost, slow future development, and produce less stable, less reliable results.

- Use good programming practices: document how tests work, how to run them, and why they were written. Avoid hard-coded values; don't duplicate code. Apply design best practices — separation of concerns, cohesive and decoupled tests.
- **Test fundamental functionality, not implementation details.** Behavior-focused tests survive refactoring. Tests tightly coupled to implementation particulars break whenever the main code changes; those breakages stop meaning "something broke" and merely signal "the code changed," which provides no value.
- Keep test dependencies separate from regular code dependencies. If a test needs a library, don't force the whole codebase to depend on it — most build and packaging systems support test-scoped dependencies; use them.

#### Don't Overdo Testing

It's easy to lose track of which tests are worth writing. Write tests that **fail meaningfully**: a failing test should tell the developer that something important changed about the program's behavior. Tests that fail on trivial changes, or when one valid implementation is swapped for another valid implementation, create busywork and desensitize the programmer. You should not need to fix tests when the code is not broken.

- Don't chase coverage metrics. Testing thin database wrappers, third-party libraries, or basic variable assignments is worthless even if it boosts coverage. Use coverage as a guide, not a rule — code can have 100 percent coverage and still contain critical errors, because exercising a line isn't the same as exercising it usefully. Chasing a specific coverage percentage is myopic.
- Don't handcraft tests for autogenerated code (web framework scaffolding, OpenAPI clients). Code generators are thoroughly tested; testing their output wastes time. If coverage tools report generated code as untested, fix the tool's configuration to ignore it. Exception: if you manually modify generated files, test them. If you find a genuine need to test generated code, add tests to the generator instead.
- **Focus effort on the highest-value tests**: tests take time to write and maintain, and focusing on high-value tests yields the most benefit for the cost. Use a **risk matrix**, which defines risk as the likelihood and impact of a failure. Plot likelihood against impact; the intersection defines risk from Low to High. Tests shift code risk down the chart by making failures less likely. Test high-likelihood, high-impact code first. Low-risk or throwaway code, like a proof of concept, isn't worth testing.

### Determinism in Tests

**Deterministic code** always produces the same output for the same input; **nondeterministic code** can return different results for the same inputs (e.g., a unit test that calls a remote web service fails whenever the network fails). Nondeterministic tests plague many projects and degrade test value: intermittent failures (**flapping tests**) are hard to reproduce and debug because they don't happen every run — you can't tell whether the problem is the test or the code. Because flapping tests provide no meaningful information, developers start ignoring them and end up checking in broken code.

**Disable or fix intermittently failing tests immediately.** To reproduce a flapping failure, run the test repeatedly in a loop (IDEs have iterative-run features; a shell loop works too). Sometimes the nondeterminism comes from interactions between tests or from specific machine configurations — experiment. Once reproduced, eliminate the nondeterminism or fix the bug.

Nondeterminism usually comes from improper handling of sleeps, timeouts, and random number generation, plus tests that leave side effects or talk to remote systems. Escape it by making time and randomness deterministic, cleaning up after tests, and avoiding network calls:

- **Seed random number generators.** RNGs use the system clock as the default seed, and clocks change between runs, so results differ. Seed RNGs with a constant so they generate the same sequence every run — constantly seeded tests always pass or always fail.
- **Don't call remote systems in unit tests.** Network hops are unstable; calls can time out, so a test can pass hundreds of times and then fail once. Remote systems get shut off, restarted, frozen, or degraded. Avoiding remote calls also keeps unit tests fast and portable — critical because developers run them frequently and locally, and remote test systems usually sit in internal environments the host machine can't easily reach. Eliminate remote calls with mocks, or refactor so remote systems are only needed in integration tests.
- **Inject clocks.** Code depending on specific time intervals is brittle: network latency, CPU speed, garbage collection, and OS scheduling make operation durations unpredictable, and system clocks progress independently. Code that waits 500 ms passes when it runs in 499 ms and fails at 501 ms. Static clock methods like `now` or `sleep` signal time-dependent code. Make the clock an injectable constructor parameter (dependency injection): tests inject a mock clock that returns controlled values, while regular code defaults to the real system clock.
- **Avoid sleeps and timeouts.** Developers sleep or set timeouts when a test must wait for work in another thread, process, or machine. That assumes the other execution finishes within a specific time — which you cannot rely on: garbage collection or OS process starvation makes such tests fail sometimes. Sleeps also slow everything down (a test that sleeps 30 minutes means your suite never runs faster than 30 minutes), and high or absent timeouts make tests hang. If tempted, restructure the test to execute deterministically; if that's genuinely impossible (determinism isn't always achievable for concurrent or asynchronous code), that's okay — but make an honest effort first.
- **Close network sockets and file handles.** Developers assume tests are short-lived and the OS will clean up at exit, but frameworks reuse one process for many tests, so leaks accumulate. The OS caps open sockets and file handles and rejects new requests once too many leak, failing later tests; a leaked socket also blocks any subsequent test that needs the same port, even when tests run serially. Use standard resource management (try-with-resources, `with` blocks) for narrowly scoped resources; close shared resources in setup/teardown.
- **Bind to port zero.** Static port binding causes nondeterminism: a test runs fine on one machine and fails on another where the port is taken, and tests all bound to the same port pass serially but fail in parallel — nondeterministically, since execution order varies. Bind to port zero so the OS picks an open port, then retrieve the assigned port and use it for the rest of the test.
- **Generate unique file and database paths.** Constant filepaths and database locations make tests interfere with each other (same problem as static ports). Dynamically generate unique filenames, directory paths, and database/table names so tests can run in parallel against separate locations. Use safe temp-directory utilities (like Python's `tempfile`) or append UUIDs to paths.
- **Isolate and clean up leftover test state.** State lives anywhere data persists — global variables and counters in memory; databases and files on disk. Leftover state makes results depend on what ran before, and it fills disk space, destabilizing the test environment. Shared integration environments are especially dangerous: they're complex to set up and therefore shared, with many tests reading and writing the same datastores in parallel, affecting each other's data, performance, and stability. Reset state whether tests pass or fail — don't let failed tests leave debris. Use setup/teardown to delete test files, clean databases, and reset in-memory state between executions; rebuild environments between suite runs. Containers and VMs make it easy to throw machines away and start fresh, but they're slower than setup/teardown methods, so use them around large groups of tests.
- **Don't depend on test order.** Ordering dependencies usually arise when one test writes data and a later test assumes it exists. This is bad because: if the first test breaks, the second breaks too; tests are harder to parallelize; changes to the first test can accidentally break the second; and changes to the test runner can reorder execution. Instead, share logic through setup/teardown: provision each test's data in setup and clean it in teardown, so tests can't break each other by mutating state.

### Going Deeper

Target specific test techniques rather than exhaustive testing textbooks. Recommended: *Unit Testing* by Vladimir Khorikov (testing philosophy, unit test patterns and anti-patterns, plus integration testing despite the name); Kent Beck's *Test-Driven Development* (a must if your organization practices TDD); the property-based testing section of *The Pragmatic Programmer* by Hunt and Thomas; and Elisabeth Hendrickson's *Explore It!* on exploratory testing to learn complex code.

## Actionable Practices

The authors' own Do's and Don'ts:

- DO use tests to reproduce bugs.
- DO use mocking tools to help write unit tests.
- DO use code quality tools to verify coverage, formatting, and complexity.
- DO seed random number generators in tests.
- DO close network sockets and file handles in tests.
- DO generate unique filepaths and database IDs in tests.
- DO clean up leftover test state between test executions.
- DON'T ignore the cost of adding new testing tools.
- DON'T depend on others to write tests for you.
- DON'T write tests just to boost code coverage.
- DON'T depend solely on code coverage as a measure of quality.
- DON'T use avoidable sleeps and timeouts in tests.
- DON'T call remote systems in unit tests.
- DON'T depend on test execution order.

Additional rules from the chapter:

- Write tests with the same care as production code; document them and refactor them.
- Test fundamental behavior, not implementation details, so tests survive refactoring.
- Keep test dependencies out of the main codebase via test-scoped dependency declarations.
- Disable or fix flapping tests immediately; reproduce them by looping the test.
- Start with inline mocks; extract shared mock classes only when logic repeats. Treat heavy mocking as a signal to refactor (separate computation from I/O).
- Prioritize tests with a risk matrix: high-likelihood, high-impact code first; skip throwaway code.
- Aim for roughly 65-85 percent coverage; configure coverage tools to ignore generated code.
- Set up your IDE to apply style rules automatically.
- Read framework docs on setup/teardown scopes; don't assume teardown always runs.
- Know what your QA team owns and how to engage them (embedded vs. centralized).
- Don't get hung up on perfect test categorization; make pragmatic improvements when you see opportunities.

## Pitfalls & Anti-patterns

- **Tests as busywork.** Bad tests add overhead without value and increase suite instability.
- **Throwing code over the fence to QA.** You own your code's correctness; QA doesn't write your unit tests.
- **Test-specific application code.** Boolean `isTest` parameters and test-only methods are hard to maintain, hard to read, and cause confusing bugs — use mocks instead.
- **Over-mocking.** Mocks with complex internal logic make tests brittle; excessive mock use signals tight coupling that should be refactored away.
- **Coverage worship.** Chasing a coverage percentage produces worthless tests (thin wrappers, third-party libraries, variable assignments) and false confidence — 100 percent coverage can still hide critical errors.
- **Testing generated code.** Wastes time; generators are already thoroughly tested. Fix coverage configuration instead.
- **Tests coupled to implementation details.** They break on every change, so failures stop meaning anything.
- **Tolerating flapping tests.** Developers learn to ignore them and check in broken code.
- **Static clocks, sleeps, and timeouts.** Timing assumptions fail under GC pauses, OS scheduling, and slow machines; sleeps put a floor on suite runtime; missing timeouts hang suites.
- **Static ports, fixed paths, leaked resources, leftover state, order dependence.** All make tests interfere with one another and fail nondeterministically, especially in parallel or shared environments.
- **Adding tools without justification.** Every tool brings learning cost, dependencies, and slowdowns; get team buy-in first.
- **Metric fixation and stop-the-world cleanups.** Not every flagged issue is real or urgent; don't let code get worse, but fix quality debt deliberately rather than disruptively.

## Key Terms

- **Test-driven development (TDD):** writing tests before code; tests fail at first, then code is written to make them pass.
- **Spaghetti code:** code with too many dependencies, which is difficult to test.
- **Unit test:** fast, small, focused test of a single method or behavior.
- **Integration test:** test verifying multiple components work together.
- **System test / end-to-end (e2e) test:** test of a whole system simulating real user workflows in preproduction.
- **Synthetic monitoring:** scripts running in production that simulate user activity as continuous production tests; requires instrumentation to distinguish test traffic from real activity.
- **Performance test:** load and stress tests measuring system performance under different configurations.
- **Load test:** measures performance at various load levels.
- **Stress test:** pushes load to the point of failure to find system limits; informs capacity planning and SLOs.
- **Acceptance test:** validation by a customer or proxy that delivered software meets acceptance criteria.
- **Mock / stub:** test double that mimics a real dependency's interface, returning hard-coded responses.
- **Test framework:** tool that models the test lifecycle (setup to teardown), orchestrates execution, and reports results.
- **Linter:** tool enforcing code quality rules via static analysis and style checks.
- **Static code analyzer:** tool that finds common mistakes and code smells without running the code.
- **Cyclomatic complexity:** roughly, the number of paths through code; higher means harder to test and more defect-prone.
- **Code coverage:** percentage of code lines exercised by the test suite; a guide, not a quality guarantee.
- **QA (quality assurance) team:** team that may own black-box/white-box testing, performance testing, test tooling, environments, and release certification.
- **Black-box / white-box tests:** tests written without / with knowledge of internal implementation.
- **Deterministic code:** same input always yields same output; nondeterministic code may not.
- **Flapping test:** intermittently failing test; hard to reproduce, erodes trust in the suite.
- **Dependency injection:** passing dependencies (like a clock) in as parameters so tests can substitute controlled implementations.
- **Risk matrix:** grid defining risk as the intersection of a failure's likelihood and its impact, used to prioritize testing effort.
