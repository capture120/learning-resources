# Chapter 23 Examples, Case Studies, and Anecdotes

These are the concrete stories Chapter 23 of *Software Engineering at Google* uses to illustrate Continuous Integration (CI) concepts. Terms: *presubmit* means automated tests run before a change is merged; *post-submit* means tests run after merging; *hermetic* tests run in a fully self-contained environment with no external dependencies like production backends; a *flaky* test fails nondeterministically without a real underlying problem.

## The Hermetic Google Assistant

**Setup.** Google Assistant provides a framework for engineers to run end-to-end tests, including a test fixture for setting up queries, choosing whether to simulate a phone or a smart-home device, and validating the responses in an exchange with the Assistant. Originally the team ran nonhermetic end-to-end tests (tests that talked to live backends) on presubmit.

**What happened.** The nonhermetic presubmit tests failed routinely. On some days more than 50 code changes bypassed and ignored the test results — the signal had become noise engineers just skipped. The team made the presubmit suite fully hermetic. Runtime dropped by a factor of 14 with virtually no flakiness. Failures still occur, but they are now easy to find and roll back because a hermetic failure points at the team's own code or test change. The nonhermetic tests moved to post-submit, where failures now accumulate instead. Debugging failing end-to-end tests there remains difficult; some teams don't have time and simply disable them — better than stopping everyone's development, but it can let production failures through.

Ongoing challenges: fine-tuning caching so presubmit catches more of the issue types previously only found post-submit without becoming brittle, and figuring out presubmit testing as the Assistant decentralizes into microservices, since running the full hermetic stack of a large complex system on every presubmit would cost too much in engineering work, coordination, and resources.

**The hotswapping trick.** The team turned the decentralization into a clever post-submit failure-isolation strategy. For each of the N microservices in the Assistant, they run a post-submit environment containing that one microservice built at head (latest code), combined with production (or near-production) versions of the other N-1 services, isolating problems to the newly built server. Naively this costs O(N^2) servers (N environments times N services each). A feature called *hotswapping* — a request can instruct a server to swap in a different backend address to call instead of its usual one — cuts the cost to O(N): they run only the N head-built servers and swap the same shared set of production backends into each "environment."

**Lesson.** Hermetic presubmits transform an ignored, flaky suite into a fast, trusted one; and creative environment composition (hotswapping) can make per-service failure isolation affordable.

## DisplayAds: 400 Servers Sandboxed on Every Presubmit

**Setup.** The cleanest way to get a presubmit-worthy integration test is a fully hermetic setup: start the entire stack sandboxed. This is normally feasible only for smaller applications.

**What happened.** Google's DisplayAds team is the extreme counterexample: it starts about four hundred servers from scratch on every presubmit run and continuously on post-submit.

**Lesson.** Full sandboxed stacks can work even at large scale, but since that system was built, record/replay (recording live backend responses and replaying them hermetically) has become the more popular and cheaper paradigm for large systems.

## Google Takeout Case Study

Google Takeout began in 2011 as a data backup and download product. Its founders pioneered "data liberation": users should be able to take their data with them, in a usable format, wherever they go. Takeout started by producing downloadable archives (photos, contact lists, and so on) for a handful of Google products, then grew into both a platform and a service for a wide range of Google products. The case study traces four scenarios in its CI transformation, showing that effective CI is especially critical when an application grows rapidly.

### Scenario 1: Continuously broken dev deploys

**Setup.** Other Google teams wanted Takeout's fetch-archive-download capabilities, so Takeout grew from one product's backend into APIs for at least ten products — for example Google Drive folder downloads and Gmail ZIP-file previews. The team deployed each API as a customized instance of the same Takeout binaries with different configuration. The Drive bulk-download environment had the largest fleet, the most quota for the Drive API, and custom authentication letting non-signed-in users download public folders.

**What happened.** "Flag issues" appeared: a flag added for one instance would break the others, and deployments broke when servers could not start under incompatible configurations. Security and ACL (access control list) configuration compounded the mess — for instance the consumer Drive download service must not have access to keys that encrypt enterprise Gmail exports. Breakages became nearly nightly. The deeper problem: an engineer making a code change could not practically hand-test that every server started under every configuration, and configuration failures only surfaced at the next day's dev deploy. Existing presubmit/post-submit unit tests didn't catch this class of issue.

The team built temporary, sandboxed mini-environments for each instance that ran on presubmit and verified every server started healthy. This prevented 95% of broken servers from bad configuration and cut nightly deployment failures by 50%. End-to-end tests still broke deploys, though, and couldn't run on presubmit because they use test accounts that behave like real accounts and fall under the same security and privacy safeguards; redesigning them was too big an undertaking. Wanting feedback faster than the next day's deploy, but without deploying dev every two hours (overhead, plus disruption to engineers' long-running dev processes) or provisioning a whole new shared environment, the team extended the presubmit sandboxes into a post-submit environment. Post-submit code is approved, so the security safeguards allowed the test accounts there. Every two hours the post-submit CI grabs the latest green code and configuration, creates a release candidate, and runs the same end-to-end suite already used in dev.

**Lesson.** Faster feedback loops prevent broken dev deploys. Moving per-instance startup tests from "after nightly deploy" to presubmit prevented 95% of configuration-broken servers and halved nightly deploy failures. Even when tests can't reach presubmit, moving them from nightly to a two-hour post-submit cycle cut the "culprit set" (the changes that could have caused a failure) by 12x.

### Scenario 2: Indecipherable test logs

**Setup.** Takeout matured into a plug-in platform: product teams insert product-specific data-fetching code directly into Takeout's binary (the Google Photos plug-in knows how to fetch photos and album metadata). Integrations grew from a handful of products to more than 90.

**What happened.** The end-to-end tests dumped failures into a log, which did not scale to 90 plug-ins. Failures piled up, were easy to miss, and reading logs became a frustrating time sink; the tests were almost always failing. The team refactored the tests into a dynamic, configuration-based suite using a parameterized test runner with a friendly UI showing each test green or red. They made failures debuggable from the error message itself, most notably by embedding links to relevant logs: if Takeout failed to fetch a Gmail file, the test dynamically constructed a link searching Takeout's logs for that file ID and put the link in the failure message. This automated much of the debugging for plug-in engineers and stopped them needing the Takeout team to send logs.

**Lesson.** Accessible, actionable feedback from CI reduces test failures and improves productivity. These changes reduced the Takeout team's involvement in debugging client (plug-in) test failures by 35%.

### Scenario 3: Debugging "all of Google"

**Setup.** Takeout's CI verifies the archive output of 90-some end-user-facing products, so in effect it was testing "all of Google."

**What happened.** The suite caught real issues that had nothing to do with Takeout — good for Google's overall quality, but bad for Takeout's CI, since most failures were not in Takeout's build but in loosely coupled microservices behind the product APIs it called. The team needed failure isolation. Their fix: run the exact same test suite continuously against production as the post-submit CI already ran. This was cheap to implement. If a failure appears in both production and post-submit, the problem lies in a backend (say, a microservice release somewhere else in Google); if only in post-submit, the problem is new in Takeout's build.

**Lesson.** Running the same suite against production and against a post-submit CI (newly built binaries, same live backends) is a cheap failure-isolation technique. Remaining challenge: the burden of "testing all of Google" grows with each integration, and manually comparing CI to production wastes the Build Cop's time (the Build Cop is the rotating engineer responsible for keeping the team's tests green). Planned improvement: hermetic record/replay testing in the post-submit CI, which would eliminate backend-API failures from the suite so it catches only what it is meant to — failures from the last two hours of Takeout changes.

### Scenario 4: Keeping it green

**Setup.** With every product plug-in bringing its own end-to-end tests, the suites were nearly always broken. Many failures came from bugs in plug-in binaries the Takeout team didn't control; some failures mattered (release-blocking bugs) and some didn't (low-priority bugs, bugs in test code). Commenting out failing tests would make them too easy to forget. A recurring failure source: staged feature rollouts. A YouTube plug-in playlist-fetching feature might be enabled in dev months before production, but the tests knew only one expected result, forcing per-environment disabling and manual curation during rollouts.

**What happened.** The team built responsible test disablement: a failing test gets tagged with an associated bug filed to the responsible team (usually a plug-in team), and the testing framework suppresses the tagged failure. The suite stays green while still signalling that everything *besides* known issues passes. For rollouts, plug-in engineers can specify a feature flag name or change ID plus the expected output both with and without the feature; the test queries the environment to see whether the feature is enabled there and checks the matching expectation. When stale bug tags accumulated, the team automated cleanup: tests query the bug system's API, and if a tagged-failing test has been passing longer than a configured limit, the system prompts to remove the tag and mark the bug fixed. Exception: tests tagged as *flaky* are never prompted for cleanup on a pass, since a flaky test passing proves nothing. The result was a mostly self-maintaining suite; the book proposes the DevOps-style metric MTTCU — mean time to clean up — for how quickly fixed tests get their tracking tags closed.

**Lesson.** Disabling failing tests you can't immediately fix — with a tracking bug attached — is a practical way to keep the suite green and stay aware of all failures. Automating suite maintenance (rollout-aware expectations, auto-cleanup of tracking bugs) prevents the suite from decaying into technical debt. Future improvement: automating the *filing* and tagging of bugs, still a manual burden here though some larger Google teams already do it.

### Remaining challenge: upstream service breakage

**Setup.** Takeout still faces rare breakages that originate in upstream services rather than its own code or its backends' APIs.

**What happened.** A security update in the streaming infrastructure used by Takeout's Drive-folder-downloads API broke archive decryption when the update deployed to production. The upstream services stage and test themselves, but no simple CI check verified their compatibility with Takeout before they launched to production. The team tried an "upstream staging" CI environment that tested production Takeout binaries against staged versions of upstream dependencies, but it proved hard to maintain because of further compatibility issues between staging and production versions.

**Lesson.** Failure isolation across independently deployed upstream dependencies remains an unsolved CI challenge; version skew (incompatible mixed versions of code, data, or configuration) makes staged-combination environments both incompatible and prone to false positives.

## Supporting Anecdotes and Illustrations

### The image-bytes test and the retry-count alert (from the "CI Is Alerting" sidebar)

**Setup.** Titus Winters draws a parallel between brittle tests and brittle cause-based production alerts.

**What happened.** If a monitoring system offers no easy end-to-end probe but makes aggregate statistics easy to collect, teams write threshold alerts on arbitrary statistics (say, retries in the past hour) with no fundamental link to user-visible health. Likewise, if a test framework offers no high-level assertion like "fail if the decoded image isn't roughly the same as this reference image," teams assert that the raw byte streams are identical — a brittle proxy that fails on harmless changes. Both brittle forms retain debugging value: "requests started failing an hour ago and retries ticked up around then — start there," or "the image pipeline outputs garbage and a unit test says the JPEG compressor returns different bytes — start there."

**Lesson.** Brittle tests and cause-based alerts are rough proxies for correctness, useful as debugging leads but not ideal problem detectors. Build high-level, invariant-based checks where possible.

### TAP scale figures and the 11-minute submit

**Setup.** TAP (Test Automation Platform) is Google's global continuous build over its monorepo and the gateway for almost all changes.

**What happened.** TAP handles more than 50,000 unique changes and runs more than four billion individual test cases every day — more than one change per second, which forces batching of changes and then automatic batch-splitting plus binary-search culprit-finding tools when a batch fails. Google lets changes land after only a fast presubmit subset because a change passing presubmit empirically has a 95%+ chance of passing everything else; the average wait to submit is about 11 minutes, often spent in the background. TAP was also upgraded to roll back changes automatically when it has high confidence they are the culprit, and any change to Google's codebase can be rolled back with two clicks.

**Lesson.** Optimistic integration (land after a fast presubmit, verify the rest asynchronously) plus disciplined Build Cops and fast rollbacks beats exhaustive presubmit gating. TAP's speed bias — fewer triggered tests means faster submission, with a difference of tens of minutes between 100-test and 1,000-test changes on a busy day — nudges engineers toward small, focused changes.
