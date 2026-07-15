# Chapter 14: Larger Testing

## Chapter Thesis

Unit tests are the foundation of a healthy testing culture, but they cannot cover everything: they run in an artificial vacuum, rely on doubles that may not match reality, and only test behaviors the author anticipated. "Larger tests" — integration, end-to-end, and system tests that span multiple processes, machines, or even production itself — exist to close that fidelity gap. But they are inherently slower, flakier, harder to own, and harder to standardize, so they must be designed deliberately: keep the system under test as small as possible while retaining fidelity, drive out flakiness and slowness, make failures understandable, assign clear owners, and choose test types via an explicit test strategy that maps risks to the tests that mitigate them.

## Core Principles and Ideas

### What larger tests are

- Google classifies tests by **size** (resources used) and **scope** (how much code is exercised). Small tests are restricted to one thread, one process, one machine. Larger tests drop those restrictions.
- Consequences of dropping the restrictions: larger tests **may be slow** (default timeouts of 15 minutes or 1 hour at Google; some run for hours or days), **may be nonhermetic** (they share resources and traffic with other tests and users), and **may be nondeterministic** (outside interference makes exact repeatability nearly impossible).
- Unit tests give confidence in individual functions and modules; larger tests give confidence that the **overall system works as intended**. Automated larger tests scale in a way manual "run it and poke at it" testing does not.

### Fidelity

- **Fidelity** is the degree to which a test reflects the real behavior of the **system under test (SUT)** — the assembled software being exercised. The primary reason larger tests exist is to increase fidelity.
- Fidelity has an **environment dimension**: there is a spectrum from a unit test bundled with a code fragment (lowest fidelity) up to production itself (highest fidelity). Higher fidelity costs more and, near the production end, carries real risk of user impact. The skill is finding the right point on the spectrum for each risk.
- Fidelity also has a **test-data dimension**: handcrafted data reflects the author's imagination and biases and covers a narrow range of cases; data copied from production is far more faithful. The scenarios your data never exercises are a fidelity gap. (This is acute in AI/ML, where seed data often carries intrinsic bias.)

### The gaps unit tests leave (why larger tests must exist)

1. **Unfaithful doubles.** A test double is a stand-in (mock, stub, or fake) for a real dependency. The engineer writing a mock usually did not write the real dependency and can misunderstand its behavior — the "behavioral contract" between units is then verified against a wrong model. Mocks also go **stale**: when the real implementation changes, nothing signals the mock-based test to update. (Team-provided fakes for their own services mostly avoid this.)
2. **Configuration issues.** Binaries ship with deployment configs, starter scripts, and config databases that unit tests never touch. At Google, configuration changes are the **number one cause of major outages**. Keep configuration in version control so bad configs can be identified as the source of bugs and can be exercised in large tests.
3. **Issues that arise under load.** Performance, load, and stress behaviors only appear when large traffic volumes hit a real binary — sometimes thousands or millions of queries per second. That does not fit in a unit test.
4. **Unanticipated behaviors, inputs, and side effects.** Unit tests only test what their author imagined. Per **Hyrum's Law**, users depend on every *visible* behavior of a system, not just the documented contract, so conformance testing against the spec alone is insufficient.
5. **Emergent behaviors and the "vacuum effect."** A unit test is like a problem in theoretical physics: sealed in a vacuum, isolated from real dependencies, networks, and data. That isolation is what makes it fast and reliable — and also what makes whole categories of defects invisible to it.

### Why not make everything a large test

- Developer-friendly tests must be **reliable** (not flaky, useful pass/fail signal), **fast** (fits the developer workflow), and **scalable** (can run for every affected change, presubmit and postsubmit). Larger tests routinely violate all three.
- Two extra structural problems:
  - **Ownership.** A unit test is owned by whoever owns the unit. A large test spans multiple units and thus multiple owners. Without a clear owner, the test rots.
  - **Standardization (lack of).** Large-test infrastructure varies by team, architecture, language, and platform. This means large tests get skipped during large-scale changes, cross-team integration tests require unifying incompatible infrastructures, and there is no single approach you can teach new engineers.

### Larger tests and time (the ice cream cone antipattern)

- The right test types shift with a codebase's expected lifespan. Code expected to live minutes gets manual testing; anything living longer needs unit tests; long-lived systems need the full range — with maintainability becoming the dominant concern.
- The **ice cream cone antipattern** (lots of manual and end-to-end tests, few unit tests — the inverse of the test pyramid) develops when a "temporary" prototype grows into a real product while still being tested only by hand. If the code was written in a way that is hard to unit-test, the only automated tests possible are end-to-end ones, and you have created "legacy code" within days.
- The cure: move toward the **test pyramid** within the first few days of development — build unit tests first, then top off with automated integration tests, and retire manual end-to-end testing.

### Larger tests at scale

- In a microservices graph with N nodes, each new node multiplies the number of distinct execution paths. Distinct end-to-end scenarios grow exponentially or combinatorially, so exhaustive end-to-end testing does not scale.
- Simultaneously, fidelity math makes larger tests *more* valuable at scale: if each service double has fidelity (1 − ε), the chance of a bug when composing N of them compounds. Two doubles that are each only 10% accurate give a 99% chance of a bug (1 − 0.1 × 0.1).
- **"The smallest possible test":** even for integration tests, smaller is better — a handful of moderate tests beats one enormous one. Test scope is coupled to SUT scope, so shrink the SUT to shrink the test.
- **Chained tests:** decompose a long user journey into multiple smaller pairwise integration tests, persisting the output of one test to a data repository and using it as the input of the next — chaining by data, not by execution.

### Structure of a large test

Nearly all large tests follow one workflow:

1. **Obtain a system under test**
2. **Seed necessary test data**
3. **Perform actions** using the SUT
4. **Verify behaviors**

### The system under test (SUT)

Judge every SUT form on two often-conflicting axes:

- **Hermeticity** — the SUT's isolation from interactions other than the test itself. High hermeticity means minimal exposure to concurrency and infrastructure flakiness.
- **Fidelity** — how accurately the SUT reflects production (similar binaries, configuration, infrastructure, topology).

SUT forms, roughly ordered from most hermetic to most faithful:

- **Single-process SUT** — the whole system packed into one binary, possibly with the test code inside it. Can qualify as a "small" test but is least faithful to production topology and configuration.
- **Single-machine SUT** — separate binaries as in production, plus a test binary, all on one machine ("medium" tests). Use production launch configurations for extra fidelity.
- **Multimachine SUT** — distributed across machines like a real cloud deployment ("large" tests); higher fidelity, but susceptible to network and machine flakiness.
- **Shared environments (staging and production)** — cheapest because the environment already exists, but tests can collide with other users, must wait for code to be pushed there, and production carries end-user risk.
- **Hybrids** — run the component you actually care about, share its backends. Practically unavoidable at Google scale; nobody can stand up a private copy of every interconnected service.

**Benefits of hermetic SUTs:** production tests cannot run until code reaches production, so they can never block that code's release — the SUT is "too late." Giant shared staging environments and reservation schemes do not scale with engineers or services. Cloud-isolated or machine-hermetic SUTs avoid the conflicts and the reservation bottleneck.

### Reducing SUT size at problem boundaries

- **UI/backend boundary:** UI tests are notoriously brittle (cosmetic changes break them without behavior changes) and hard to test (asynchronous behavior), and frontend-plus-backend tests carry a multiplicative maintenance cost. If the backend has a public API, split the tests at the UI/API boundary and drive end-to-end tests through the public API. This applies to browser, CLI, desktop, and mobile UIs alike.
- **Third-party boundary:** do not point automated tests at real third-party APIs — there may be no shared test environment and real traffic may cost money. That dependency is an important seam at which to split tests.
- Other shrinking moves: replace databases with in-memory equivalents; drop servers outside the scope you actually care about. The prize: if a handful of binaries plus a test fit on the same machines that run compiles and unit tests, you have the easiest and most stable integration tests available.

### Keeping doubles honest: contract tests and record/replay

- **Consumer-driven contract tests** (public tools: Pact, Spring Cloud Contracts): the client defines input/output pairs it expects from a service; the real service then runs those pairs as tests to prove it actually behaves that way. The same contract drives both the client's mock and the provider's verification.
- **Record/replay proxies** (Google's preferred approach, since heavy protocol-buffer use makes the public contract tools a poor fit): a large "Record Mode" test runs continuously post-submit and records real traffic to external services (it must pass for the logs to be generated). A smaller "Replay Mode" test replays that recorded traffic during development and presubmit. Because of nondeterminism, requests are paired to recorded responses via matchers — making replay behave much like argument-matched stubs. When client behavior changes and requests stop matching, the engineer must re-run Record mode, so make Record mode easy, fast, and stable.

### Test data

Two kinds of data feed a large test:

- **Seeded data** — state preloaded into the SUT before the test starts.
- **Test traffic** — data the test sends to the SUT while running.

Seeding a large SUT is orders of magnitude harder than unit-test setup: **domain data** (config-like table contents a binary needs just to start), a **realistic baseline** (e.g., a social-network test needs a believable social graph with enough users and interconnections), and **seeding APIs** (writing directly to the datastore may bypass the triggers and validation the real binaries perform).

Data sources: **handcrafted** (laborious at SUT scale), **copied** from production (high fidelity baseline), and **sampled** — "smart sampling" copies the minimum data needed for maximum coverage.

### Verification

Three modes:

- **Manual** — a human works the SUT, either against a scripted test plan (regression) or exploratorily. Manual regression testing does not scale sublinearly: more system means proportionally more human time.
- **Assertions** — explicit machine-checked expectations, as in unit tests (e.g., `assertThat(response.Contains("Colossal Cave"))`).
- **A/B comparison (differential)** — run two versions of the SUT on the same input and diff the outputs; a human reconciles whether each difference is intended.

## The Catalog of Larger Test Types

Each type is a combination of SUT form + data source + verification mode, chosen to mitigate a specific risk.

| Type | SUT | Data | Verification |
|---|---|---|---|
| Functional test of one or more binaries | single-machine hermetic or cloud-isolated | handcrafted | assertions |
| Browser and device testing | same as functional | handcrafted | assertions |
| Performance/load/stress | cloud-deployed isolated | handcrafted or multiplexed from production | diff on performance metrics |
| Deployment configuration test | single-machine hermetic or cloud-isolated | none | assertion: it starts without crashing |
| Exploratory testing | production or shared staging | production or known test universe | manual |
| A/B diff (regression) testing | two cloud-deployed isolated environments | multiplexed or sampled from production | A/B diff comparison |
| UAT (user acceptance testing) | machine-hermetic or cloud-isolated | handcrafted | assertions |
| Probers and canary analysis | production | production | assertions and metric diffs |
| Disaster recovery / chaos engineering | production | production plus injected faults | manual and metric diffs |
| User evaluation | production | production | manual and metric diffs |

Key points per type:

- **Functional testing of interacting binaries:** the canonical large test; brings up all relevant binaries (common in microservices) and drives them through a published API.
- **Browser/device testing:** for end users the application *is* the public API; testing through the frontend adds a coverage layer beyond unit tests of the underlying code.
- **Performance/load/stress:** load-handling is a "highly emergent" property — it belongs to the whole system, not its parts — so these tests must look as close to production as possible. Deployment topology is a noise source: if the baseline runs on a fast machine and the candidate on a slow one, you see a phantom regression. Run both versions on the same machine, or calibrate with multiple runs and trim peaks and valleys.
- **Deployment configuration testing:** a smoke test that the binary boots with its real config files. Configuration, not code, is often the defect source.
- **Exploratory testing:** manual hunting for questionable behavior along *new* paths rather than repeating known flows — a human "fuzz test." Useful for unanticipated behavior and security issues. Every bug it finds should be captured as an automated test. **Bug bashes** are the organized form: the whole team meets and everyone manually attacks the product at once.
- **A/B diff regression testing:** probably the most common large-test form at Google (used since 2001, starting with Ads, Search, and Maps). Sends identical traffic to old and new versions and compares responses; every diff must be reconciled as intended or a regression. Variants: **A-A testing** (compare a system to itself to find nondeterminism and noise) and **A-B-C testing** (last production release vs. baseline vs. pending change, showing both immediate and accumulated impact). Limitations: diffs need human **approval**; **noise** drives manual investigation and is a major engineering cost; **coverage** (curating traffic that hits corner cases) is hard; **setup** of two synchronized SUTs roughly doubles the complexity.
- **UAT:** automated tests written from the *customer's* view of intended behavior, because developer-written unit tests verify "working as implemented," not "working as intended." Frameworks like Cucumber and RSpec express "runnable specifications." Google does little of this because product-defining engineers historically wrote the code themselves.
- **Probers and canary analysis:** production monitoring structured as tests. **Probers** run well-known, deterministic, read-only assertions against live production (e.g., search google.com and assert *some* result returns) — smoke tests giving early detection of major breakage. **Canary analysis** applies probers plus health-metric comparison to the small upgraded slice of production during a staged rollout. Use probers on any live system; use canary analysis whenever the rollout has a canary phase. Limits: anything caught here is already hitting users, and probers that perform writes mutate production.
- **Disaster recovery and chaos engineering:** test how systems react to failure. **DiRT** (Disaster Recovery Testing) is Google's annual company-wide war game injecting planetary-scale faults, from datacenter fires to simulated attacks. **Chaos engineering** (popularized by Netflix; Google's tool is Catzilla, running thousands of tests weekly) continuously injects a background level of faults to break teams' assumptions of stability. Only appropriate for systems with enough fault tolerance to absorb the tests, and the issues found are, again, already in production.
- **User evaluation:** production experiments as tests. **Dogfooding** (limited rollout to your own staff), **experimentation** (A/B test on unwitting user subsets, compared on aggregate metrics), and **rater evaluation** (humans judge which of two outputs is "better" — essential for ML and other nondeterministic systems that have no single correct answer, only better or worse).

## Actionable Guidance

- **Write a test strategy.** Part of designing software is drafting a test plan whose core is a strategic outline of which test types you need and how much of each, mapped to the primary risk vectors of the system.
- **Escape the ice cream cone early.** Build unit tests within the first few days of any project; add automated integration tests next; retire manual end-to-end testing.
- **Prefer the smallest SUT that retains the fidelity you need.** Split at the UI/API boundary; never hit real third-party APIs from automated tests; swap in-memory databases for real ones; drop out-of-scope servers.
- **Chain tests** across a long user journey via persisted intermediate data instead of one giant scenario test.
- **Keep doubles honest** with consumer-driven contract tests or record/replay proxies. Make the Record-mode path easy, fast, and stable, since engineers must re-record whenever request shapes change.
- **Version-control configuration** alongside code and cover it with deployment-configuration smoke tests.
- **Integrate large tests into the developer workflow** even when they cannot live in the standard CI system: give them their own post-submit continuous build, encourage presubmit runs, and put a common API and shared code-review surface in front of both. For diff tests, make approving UI diffs a code-review requirement; automatically file release-blocking bugs when code lands with unresolved diffs. Accept the trade-off: tests too painful for presubmit run post-submit and at release, at the cost of tainting the repo and hunting culprits.
- **Speed tests up:** reduce scope or split into parallel tests; replace time-based sleeps with polling, event handlers, or notification subscriptions (sleep-based tests collapse under fleet load in a self-reinforcing spiral); make hardcoded production timeouts tunable and lower them under test; use prebuilt known-good versions of peer binaries instead of rebuilding every dependency.
- **Drive out flakiness as a high priority:** shrink scope (hermetic beats shared, single-machine beats distributed); make tests event-driven; tune internal timeouts deliberately. Beware graceful degradation masking flakiness — a system that silently drops a slow response (Google serves no ad rather than a 500) looks to a test like broken logic; make that failure mode explicit and the timeout tunable.
- **Make failures understandable.** A good failing large test: (1) says clearly *what* failed with context ("expected 10 search results but got 1"), not "Assertion failed" plus a stack trace; (2) minimizes root-cause effort — stack traces are useless across process boundaries, so produce cross-service traces (Google's Dapper correlates all logs in an RPC chain by request ID) or culprit-narrowing automation; (3) provides support and contact information.
- **Assign documented owners** empowered and incentivized to maintain the test. Project-internal integration tests belong to the project lead; cross-service feature tests belong to a "feature owner" (an end-to-end engineer, PM, or test engineer). Record ownership in a structured, automatable way: OWNERS files for standalone test artifacts, per-test annotations when one test class mixes methods with different feature owners.
- **Account for maintenance cost holistically.** A/B diff tests are popular because verification maintenance is cheap; production SUTs are cheaper to maintain than hermetic ones — but only until the cost of manually reconciling diffs or safeguarding production testing outweighs the savings.
- **Expect test data in production to be discovered** by end users (see the Webdriver Torso incident) and be prepared for it.

## Chapter TL;DRs (verbatim)

- Larger tests cover things unit tests cannot.
- Large tests are composed of a System Under Test, Data, Action, and Verification.
- A good design includes a test strategy that identifies risks and larger tests that mitigate them.
- Extra effort must be made with larger tests to keep them from creating friction in the developer workflow.
