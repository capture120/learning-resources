# Chapter 23: Continuous Integration

## Chapter Thesis

Continuous Integration (CI) is classically defined as team members integrating their work frequently, with each integration verified by an automated build and test, so that problematic changes are caught as early as possible. This chapter argues that in the modern world of distributed, rapidly evolving systems, CI must be redefined more broadly: as "the continuous assembling and testing of our entire complex and rapidly evolving ecosystem." Dependencies are no longer just code in your repository; they include upstream microservices, data, machine learning models, operating systems, runtimes, cloud services, and devices — many owned by other teams or companies and deployed on their own schedules. From a testing perspective, CI is the paradigm that decides *which* tests to run *when* in the development and release workflow, and *how* to compose the system under test (SUT) at each point, balancing fidelity against setup cost. Done well, CI provides a verifiable, timely guarantee that the application is good to progress to its next stage — replacing hope in individual carefulness with a guaranteed working state, which improves confidence, quality, and team productivity.

## Core Principles and Ideas

### The two definitions of CI

- Classic definition (Fowler): members of a team integrate their work frequently, and each integration is verified by an automated build (including test) to detect integration errors as quickly as possible.
- Modern definition offered by the book: *Continuous Integration (2): the continuous assembling and testing of our entire complex and rapidly evolving ecosystem.* Anything that can change under you — upstream microservices reached by RPC or HTTP, ingested data, ML models, platforms, runtimes — counts as a dependency whose changes should be continuously integrated.

### CI as a testing paradigm

CI answers two questions:

1. *Which* tests to run *when* in the development/release workflow, as changes are continuously integrated.
2. *How* to compose the system under test (SUT) at each point, balancing fidelity against setup cost. For example, a presubmit SUT (built from unreviewed code) should generally not talk to real production backends because of security and quota risks, while a staging SUT often can.

### Fast feedback loops (shift left)

The cost of a bug grows almost exponentially the later it is caught. Later-caught bugs are costlier because they get triaged by an engineer unfamiliar with the change, they force the author to re-investigate a change they no longer remember, and they harm other engineers or end users. CI therefore pushes for *fast feedback loops* — also called "shifting left on testing," meaning moving problem detection earlier (leftward) in the development timeline. Common feedback loops from fastest to slowest:

1. The edit-compile-debug loop of local development.
2. Automated test results to the change author on presubmit (tests run before a change is merged).
3. An integration error between two projects detected post-submit (after both changes merged and are tested together).
4. An incompatibility with an upstream microservice found by a QA tester in staging when that service deploys.
5. Bug reports from internal users opted in to a feature early.
6. Bug or outage reports from external users or the press.

Related concepts:

- *Canarying*: deploying to a small percentage of production first, creating a subset-of-production feedback loop before all-of-production. It reduces blast radius but can cause *version skew* — a state of a distributed system in which it contains multiple incompatible versions of code, data, and/or configuration running at once.
- *Experiments and feature flags*: extremely powerful feedback loops that reduce deployment risk by isolating changes in modular components that can be dynamically toggled in production. Heavy feature-flag guarding is a common Continuous Delivery paradigm.

### Accessible and actionable feedback

Feedback from CI should be widely accessible and actionable. Google keeps a unified test reporting system where anyone can look up any build or test run and its logs (excluding personal data), plus history of when targets began failing, where the build was cut, and who ran it. A Google-wide statistical flake-classification system tells engineers whether a failing test is flaky (a *flaky* test fails nondeterministically without a real code problem) so they do not have to diagnose that themselves. Open test history and open bug trackers let disparate teams diagnose and learn from integration failures between their systems. Feedback must also be *actionable*: easy to use to find and fix problems. Improving test output readability automates the understanding of feedback.

### Automation: Continuous Build and Continuous Delivery

Automating development tasks saves engineering resources; processes defined as code get peer review and are faster, easier, and more reliable than manual execution. CI specifically automates the build and release processes.

- *Continuous Build (CB)*: integrates the latest code changes at head (the latest versioned code on the mainline/trunk; integrating at head is trunk-based development) and runs an automated build and test. "Breaking the build" includes breaking tests, not just compilation. The CB creates two versions of head: *true head* (latest committed change) and *green head* (latest change the CB has verified). Engineers commonly sync to green head for a stable dev environment but must sync to true head before submitting.
- *Release candidate (RC)*: a cohesive, deployable unit created by an automated process, assembled of code, configuration, and other dependencies that have passed the continuous build. Static configuration must be included in the RC and versioned with the code so it is tested together with the exact code that will use it — a large share of production bugs are "silly" configuration problems, and version skew is often caught during RC promotion.
- *Continuous Delivery (CD)*: a continuous assembling of release candidates, followed by the promotion and testing of those candidates throughout a series of environments — sometimes reaching production and sometimes not. Most Google teams cut RCs at green head. Continuously deploying entire large binaries on every green build is usually infeasible, so *selective* Continuous Deployment via experiments and feature flags is a common strategy.
- As an RC progresses through environments, its artifacts should not be recompiled or rebuilt. Containers (Docker) enforce consistency of an RC across environments; orchestration tools (Kubernetes, or Borg at Google) enforce consistency between deployments. Consistency gives higher-fidelity early testing and fewer production surprises.

### Continuous Testing: what to test when

As a change moves rightward from local development to production, it is subjected to progressively larger-scoped automated tests.

**Why presubmit isn't enough.** Running every test on presubmit is too expensive: engineer time is valuable, and waiting hours on submission is severely disruptive. Presubmits need not be exhaustive; big efficiency gains come from restricting scope or selecting tests via a model predicting failure likelihood. Blocking engineers on flaky failures unrelated to their change is also costly. And even a passing presubmit can be invalidated by a *mid-air collision*: two changes touching completely different files that together cause a test failure, because the repository changed while the presubmit ran. Mid-air collisions are rare per change but happen most days at Google's scale; small repositories can avoid them by serializing submits.

**Presubmit versus post-submit.** Rule of thumb: run only fast, reliable tests on presubmit. Accept some coverage loss there, catch escapes post-submit, and accept some rollbacks. Post-submit can tolerate longer runtimes and some instability given proper failure-management mechanisms. Presubmit tests are typically limited to the project where the change happens and run concurrently. Most Google teams run their small tests (unit tests) on presubmit. For teams that want larger-scoped tests on presubmit, hermetic testing is a proven way to reduce instability; alternatively allow them to be unreliable but disable them aggressively when they fail.

**Release candidate testing.** Run a comprehensive automated suite against each RC as it is promoted through test environments (sandboxed temporary environments and shared dev/staging environments, often with some manual QA), even if the CB already ran the same suite, because:

1. *Sanity check* — verify nothing strange happened when the code was cut and recompiled into the RC.
2. *Auditability* — test results are attached to the RC itself, no digging through CB logs.
3. *Cherry picks* — a cherry-picked fix makes the RC diverge from what the CB tested.
4. *Emergency pushes* — CD can cut from true head and run the minimal necessary tests without waiting for a full CB pass.

**Production testing.** Run the same suite against production (tests sometimes called *probers*) to verify both (1) the working state of production according to the tests and (2) the relevance of the tests according to production. Continuous testing at every step is "defense in depth": quality comes from many combined testing approaches, not one technology or policy.

### CI Is Alerting (sidebar by Titus Winters)

CI and production alerting serve the same purpose: identify problems automatically, as soon as reasonably possible. CI works the early end of the developer workflow via test failures; alerting works the late end via metric thresholds. Framing CI as the "left shift" of alerting imports SRE (Site Reliability Engineering) wisdom into testing:

- Localized signals (unit tests / cause-based alerts) versus cross-dependency signals (integration and release tests / black-box probing): end-to-end signals have the highest fidelity, paid for in flakiness, resource cost, and debugging difficulty.
- Brittle tests are the analog of brittle cause-based alerts: both fire on arbitrary invariants or thresholds without a fundamental connection to real correctness or user-visible health. Both still have debugging value as leads during investigation, but neither is the ideal problem detector. If a signal isn't actionable, it shouldn't be alerting; if it isn't actually violating an invariant of the SUT, it shouldn't be a test failure.
- A 100% green CI rate, like 100% uptime, is awfully expensive; a race between testing and submission makes it nearly unattainable anyway. This mirrors the SRE *error budget* insight: pick a realistic target and spend the budget deliberately.
- Not every test failure signals an upcoming production issue; be liberal about disabling tests known to fail for irrelevant reasons.
- Policies like "nobody can commit unless CI is green" are probably misguided: failures should be investigated before people commit on top of them, but if the root cause is understood and clearly wouldn't affect production, blocking commits is unreasonable.

### CI Challenges

- *Presubmit optimization*: choosing which tests to run at presubmit and how.
- *Culprit finding* and *failure isolation*: determining which change caused a problem and in which system. "Integrating upstream microservices" — staging your stable servers with upstream services' new servers — helps isolate whether a problem is yours or a backend's, but version skew makes the environments incompatible and produces false positives.
- *Resource constraints*: large tests are expensive to run, and the infrastructure for automated testing throughout the pipeline costs a lot.
- *Failure management*: large end-to-end suites are inherently hard to keep consistently green. There must be a mechanism to temporarily disable and track broken tests so releases can proceed. Google commonly uses bug "hotlists" filed by an on-call or release engineer and triaged to the right team; larger products auto-generate these bugs. Release-blocking bugs get fixed immediately; non-blockers still get prioritized so the suite doesn't decay into a pile of disabled tests. Often end-to-end failures are problems with tests rather than code.
- *Flaky tests*: they erode confidence like broken tests but are harder to trace to a rollback candidate. Some teams temporarily remove flaky tests from presubmit while fixing them. Test instability can also be mitigated by allowing multiple attempts (retries) at the suite or within test code.

### Hermetic Testing

*Hermetic tests* run against a test environment (application servers and resources) that is entirely self-contained, with no external dependencies such as production backends. Two key properties:

1. *Greater determinism (stability)*: what goes into the test doesn't change with outside dependencies, so the same application and test code produce the same result. A hermetic failure points to your own application or test change (or, rarely, a restructuring of the hermetic environment). When CI reruns tests hours or days later, hermeticity makes failures easy to narrow down.
2. *Isolation*: production problems don't affect the tests, and the tests don't affect production. Running everything on one machine removes network-connectivity worries. Hermetic test success should not depend on which user runs the test, which lets anyone reproduce CI runs and run other teams' tests.

Ways to achieve hermeticity:

- *Fakes* (lightweight stand-in implementations of a backend): cheaper than a real backend but require maintenance and have limited fidelity.
- *Fully hermetic sandboxed stack*: start the entire stack sandboxed; cleanest option for presubmit-worthy integration tests, more feasible for small applications. Google provides out-of-the-box sandbox configurations for popular components like databases. One extreme exception: DisplayAds starts about 400 servers from scratch on every presubmit.
- *Record/replay*: record live backend responses, cache them, and replay them in a hermetic environment. Now the more popular and cheaper paradigm for large systems, but it produces brittle tests due to a hard balance between *false positives* (test passes when it shouldn't because the cache is hit too much, hiding problems a fresh response would reveal) and *false negatives* (test fails when it shouldn't because the cache is hit too little, forcing slow, often submit-blocking response updates). Ideally a record/replay system cache-misses only when a request changed in a meaningful way — which is incredibly difficult to determine in a large evolving system.

Hermetic backends cost more resources and are slower to set up, so many teams mix hermetic and live backends in their test environments.

### TAP: Google's Global Continuous Build

TAP (Test Automation Platform) is Google's massive continuous build over the entire monorepo (single shared repository), running the majority of Google's automated tests. It is the gateway for almost all changes: more than 50,000 unique changes and more than four billion individual test cases per day. When an engineer submits code, TAP runs the associated tests and reports pass/fail; passing changes enter the codebase.

- *Presubmit optimization*: rather than run everything before submit, Google optimistically lets potentially breaking changes land. Each team defines a fast presubmit subset (often unit tests). Empirically, a change passing presubmit has a 95%+ chance of passing all remaining tests. After submit, TAP asynchronously runs all potentially affected tests including the large, slow ones. Average wait to submit is around 11 minutes, often in the background.
- *Build Cop*: each team designates an engineer responsible for keeping all that project's TAP tests passing regardless of who broke them. On a failure notification, the Build Cop drops everything and fixes the build, usually by identifying the offending change and rolling it back (preferred) or fixing forward (riskier). A cultural norm strongly discourages committing new work on top of known failing tests.
- *Culprit finding*: TAP handles more than one change per second, so it batches related changes, which obscures which change broke a test. TAP automatically splits a failing batch into individual changes and reruns tests against each in isolation; developers also have culprit-finding tools that binary-search a batch.
- *Failure management*: rollback is the Build Cop's most effective tool — the fastest, safest route to a known good state. TAP now automatically rolls back changes when it has high confidence they are the culprit. Key mantra: tests give confidence to change, rollbacks give confidence to undo. Without tests, rollbacks aren't safe; without rollbacks, broken tests can't be fixed quickly.
- *Resource constraints*: most test executions run on Forge, Google's distributed build-and-test system in datacenters. Even at Google's scale, resources are constrained, so TAP analyzes the downstream dependency graph (maintained near-real-time by Forge and Blaze, the build tool) to run only the minimal set of tests downstream of each change. A side effect: changes triggering fewer tests finish sooner, which nudges engineers toward small, focused changes — a win for everyone.

## Actionable Guidance

- Run only fast, reliable tests on presubmit (typically the changed project's unit tests); accept some coverage loss and catch escapes post-submit with proper failure management and rollbacks.
- Include static configuration in release candidates and keep configuration in version control, subject to the same code review as code; test configuration together with the exact code that uses it.
- Do not rebuild artifacts as an RC moves between environments; use containers and orchestration to keep the release identical from local dev through production.
- Run the same comprehensive suite at post-submit, against each RC at every promotion stage, and against production (probers) — defense in depth.
- Running the same suite against production and against a post-submit CI (new binaries, same live backends) is a cheap way to isolate whether a failure is in your build or in the backends.
- Make CI feedback widely accessible (unified test reporting, open failure history, open bugs) and actionable (readable output, failure messages that embed links to relevant logs).
- Classify flakes centrally with statistics so individual engineers don't each have to determine whether a failure is flaky.
- Use hermetic testing to make larger-scoped tests presubmit-worthy; prefer record/replay over booting a huge sandboxed stack for large systems, while watching its false-positive/false-negative brittleness.
- Establish a Build Cop rotation whose job is dropping everything to fix the build, with rollback as the default remedy; automate rollbacks when culprit confidence is high.
- Disable failing tests you can't fix immediately, but responsibly: tag each disabled test with a tracking bug filed to the owning team so the suite stays green while known issues remain visible. Automate cleanup of stale tags by checking the bug tracker and how long the test has been passing (mean time to clean up, MTTCU). Exempt tests tagged flaky from pass-based cleanup prompts.
- For features rolling out gradually behind flags, let tests declare the flag name and the expected output both with and without the feature, and have the test query the environment to decide which expectation applies.
- Batch changes to save test resources when volume is high, then auto-split failing batches and provide binary-search culprit-finding tools.
- Don't chase 100% green or block all commits on any red; investigate failures, but allow commits when the root cause is understood and clearly wouldn't affect production.
- If CI feels unaffordable, count the cost you already pay for problems found in production — user harm plus stressful, demoralizing fire-fighting. CI is not a new cost but a cost shifted left to a cheaper stage; it yields a more stable product and a happier culture where engineers trust the system to catch problems and focus on features.
- A CI system is itself software: never complete, and continuously adjusted to the evolving needs of the application and its engineers.

## The Chapter's TL;DRs (verbatim)

- A CI system decides what tests to use, and when.
- CI systems become progressively more necessary as your codebase ages and grows in scale.
- CI should optimize quicker, more reliable tests on presubmit and slower, less deterministic tests on post-submit.
- Accessible, actionable feedback allows a CI system to become more efficient.
