---
name: swe-google-learnings-nathan
description: Distilled knowledge from Software Engineering at Google (Winters, Manshreck, Wright) — engineering culture, teams, code review, testing, style guides, version control, build systems, static analysis, dependency management, large-scale changes, and CI/CD. Use for questions about software engineering practices, tooling, or scaling an engineering organization.
---

# Software Engineering at Google — Learning Library Router

This library distills the book "Software Engineering at Google" (Winters, Manshreck, Wright) into per-chapter learning files.
Source: https://abseil.io/resources/swe-book/html/toc.html

## How this library is organized

Each chapter has its own directory named `chNN-slug/` containing exactly two files:

- `core-learnings.md` — the chapter thesis, core principles, named concepts, actionable guidance, and the book's own TL;DR bullets.
- `examples.md` — every substantive example, case study, and anecdote from the chapter, retold with full context.

Routing rule: read `core-learnings.md` first for principles and guidance. Read `examples.md` when you need concrete evidence, stories, or illustrations to support a point.

## The book's core thesis (Chapter 1)

Software engineering is "programming integrated over time." It differs from programming along three dimensions: time (how long code must survive change), scale (how practices hold up as the organization grows), and trade-offs (decisions made from costs and evidence rather than taste). Hyrum's Law governs everything: with enough users, every observable behavior of a system will be depended on, regardless of what the contract promises.

## Book structure

- **Part I: Thesis** — Chapter 1
- **Part II: Culture** — Chapters 2–7 (people, teams, leadership, measurement)
- **Part III: Processes** — Chapters 8–15 (rules, review, docs, testing, deprecation)
- **Part IV: Tools** — Chapters 16–25 (version control, build, CI/CD, infrastructure)

## Quick routing by problem

| If the question is about... | Go to |
|---|---|
| Why long-lived code needs different practices; upgrade/refactor investment; Hyrum's Law; trade-off framing | ch01 |
| Team dynamics, sharing work early, bus factor, blameless postmortems, ego/conflict | ch02 |
| Onboarding, mentorship, docs strategy, knowledge silos, learning culture, psychological safety | ch03 |
| Product bias/fairness, inclusive design, diversity beyond hiring pipelines | ch04 |
| Becoming/being a manager or tech lead, feedback, motivation, low performers | ch05 |
| Leading teams-of-teams, delegation, prioritization, leader overload and burnout | ch06 |
| Whether/how to measure developer productivity; metrics design; GSM; QUANTS | ch07 |
| Coding standards, style guide governance, when a convention should be a rule | ch08 |
| Code review process, approval policy, change sizing, review etiquette | ch09 |
| Writing/maintaining docs, comments, design docs, doc reviews, doc rot | ch10 |
| Test suite structure, test sizes/scopes, test pyramid, flaky tests, testing culture | ch11 |
| Writing maintainable unit tests, brittleness, state vs interaction, DAMP vs DRY | ch12 |
| Mocks/stubs/fakes, when to use real implementations, contract tests | ch13 |
| Integration/e2e/system tests, hermetic SUTs, testing in production, diff testing | ch14 |
| Sunsetting a system/API, migration off legacy, preventing backsliding | ch15 |
| Branching strategy, monorepo vs many-repo, trunk-based development, One-Version Rule | ch16 |
| Code search/browsing tools, code intelligence infrastructure, indexing at scale | ch17 |
| Build systems, Bazel, hermetic/reproducible builds, build target structure | ch18 |
| Code review tool design, review UX, attention management, analysis-in-review | ch19 |
| Linters, static analysis rollout, false positives, presubmit vs compiler enforcement | ch20 |
| Third-party dependencies, SemVer limits, diamond dependencies, Live at Head | ch21 |
| Mass refactoring/codemods, API migrations across a large codebase | ch22 |
| CI pipeline design, presubmit vs post-submit, keeping builds green | ch23 |
| Release process, deployment frequency, feature flags, staged rollouts | ch24 |
| Container orchestration, Borg/Kubernetes, failure-tolerant services, serverless vs containers, cloud lock-in | ch25 |

## Chapter index

### Chapter 1 — What Is Software Engineering? (`ch01-what-is-software-engineering/`)
Defines software engineering as "programming integrated over time" and distinguishes it from programming along time, scale, and trade-offs. Teaches sustainability, Hyrum's Law, scalable policies (Churn Rule, Beyoncé Rule), shifting left, and explicit cost-based decision making with the right to revisit decisions.
**Topics:** software engineering vs programming, expected code life span, Hyrum's Law, hash ordering, Churn Rule, Beyoncé Rule, shift left, trade-offs, technical debt, Jevons Paradox, fork vs dependency.
**Use when:** questions about why long-lived code needs different practices, when to invest in upgrades or infrastructure, API compatibility breakage, designing policies that scale, or framing engineering trade-off decisions.

### Chapter 2 — How to Work Well on Teams (`ch02-how-to-work-well-on-teams/`)
Software engineering is a team endeavor; engineer insecurity (the Genius Myth, hiding work) creates avoidable risk. Teaches the three pillars — humility, respect, trust — plus early sharing, raising the bus factor, tight feedback loops, constructive criticism, blameless postmortems, and embracing failure.
**Topics:** Genius Myth, hiding code, bus factor, fail fast, humility respect trust, blameless postmortems, vulnerability, culture fit, working styles.
**Use when:** questions about team dynamics, collaboration culture, review feedback, sharing early vs polishing alone, knowledge silos, handling failure, or interpersonal conflict.

### Chapter 3 — Knowledge Sharing (`ch03-knowledge-sharing/`)
How organizations spread expertise so they can answer their own questions. Grounded in psychological safety and a learning culture; covers asking questions, canonical sources, incentives, and Google's readability mentorship-through-code-review program.
**Topics:** psychological safety, tribal knowledge, Chesterton's fence, information islands, haunted graveyards, readability process, canonical sources, go/ links, incentives, brilliant jerk, onboarding.
**Use when:** questions about onboarding, documentation strategy, mentorship, reducing bus factor, incentivizing teaching, or human help vs written docs trade-offs.

### Chapter 4 — Engineering for Equity (`ch04-engineering-for-equity/`)
Unconscious bias is the default in software products; equitable outcomes require deliberate action rather than good values alone. Covers multicultural capacity, rejecting single-cause fixes, designing first for the user least like you, and measuring equity.
**Topics:** equity, unconscious bias, inclusive design, biased training data, representation, retention and progression, velocity vs harm.
**Use when:** designing products for diverse or underrepresented users, evaluating ML data or features for bias, improving team diversity beyond hiring, or weighing launch velocity against harm.

### Chapter 5 — How to Lead a Team (`ch05-how-to-lead-a-team/`)
Transitioning from engineer to leader. Defines engineering manager vs tech lead vs TLM, champions servant leadership, catalogs six leadership antipatterns and eight positive patterns, and closes with the autonomy/mastery/purpose motivation model.
**Topics:** servant leadership, influence without authority, antipatterns, hiring bar, low performers, delegation, honest feedback, one-on-ones, intrinsic motivation, people are like plants.
**Use when:** becoming or being a manager or tech lead, handling low performers, giving hard feedback, delegation, motivation and morale, or diagnosing bad-management behaviors.

### Chapter 6 — Leading at Scale (`ch06-leading-at-scale/`)
Leading a team of teams via the "three Always": Always Be Deciding (trade-off rebalancing over perfect answers), Always Be Leaving (build a self-driving organization), Always Be Scaling (defend time, attention, energy).
**Topics:** trade-offs, analysis paralysis, delegation, single point of failure, problem vs product identity, urgent vs important, dropping balls, energy management, burnout, imposter syndrome.
**Use when:** growing from team lead to leader of leaders, deciding among ambiguous trade-offs, building self-sufficient organizations, or managing a leader's overload.

### Chapter 7 — Measuring Engineering Productivity (`ch07-measuring-engineering-productivity/`)
Measure only when a concrete decision hangs on the result. Teaches triage questions, the Goals/Signals/Metrics (GSM) framework, the five QUANTS dimensions, pairing quantitative logs with qualitative surveys, and never using productivity metrics on individuals.
**Topics:** GSM framework, QUANTS, streetlight effect, vanity metrics, survey bias, experience sampling, lines-of-code criticism, tool-driven recommendations.
**Use when:** deciding whether/how to measure developer productivity or a tool's impact, designing team metrics or dashboards, or debating metrics in performance reviews.

### Chapter 8 — Style Guides and Rules (`ch08-style-guides-and-rules/`)
Why organizations codify mandatory rules and how Google creates, changes, and enforces them. Rules must pull their weight, optimize for the reader, ensure consistency, avoid error-prone constructs, and concede to practicalities. Automate enforcement wherever possible.
**Topics:** rules vs guidance, optimize for the reader, consistency, expert chunking, style arbiters, waivers, gofmt, formatters, presubmit checks, clang-tidy, Error Prone.
**Use when:** creating or changing coding standards, lint/format enforcement strategy, deciding rule vs advice, or handling exceptions and rule governance.

### Chapter 9 — Code Review (`ch09-code-review/`)
Google's precommit review with three combinable approval bits: peer LGTM, owner approval, readability approval. The biggest benefits at scale are comprehension, consistency, collective ownership, and historical record. Keep review scalable: ~200-line changes, one reviewer, 24-hour turnaround, good descriptions.
**Topics:** LGTM, OWNERS files, readability approval, small changes, change descriptions, presubmits, etiquette, rollbacks, greenfield vs machine-generated changes, code is a liability.
**Use when:** running or improving a code review process, approval policies, change sizing and description standards, or reviewing automated changes.

### Chapter 10 — Documentation (`ch10-documentation/`)
Treat documentation like code — source control, owners, reviews, tracked bugs, freshness checks — and write for a named audience. Defines five document types, three review types, and when technical writers actually add value.
**Topics:** documentation as code, API vs implementation comments, seekers vs stumblers, canonical documents, design docs, tutorials, landing pages, WHO/WHAT/WHEN/WHERE/WHY, freshness, deprecating docs.
**Use when:** writing or maintaining docs, READMEs, design docs, doc ownership and reviews, stale docs, structuring for an audience, or involving technical writers.

### Chapter 11 — Testing Overview (`ch11-testing-overview/`)
Why developer-driven automated testing is the foundation for changing software safely at scale. Defines test sizes (small/medium/large) and scopes (unit/integration/e2e), the 80/15/5 pyramid and its antipatterns, the Beyoncé Rule, flaky test economics, and coverage pitfalls.
**Topics:** test sizes, test scope, test pyramid, ice cream cone, hourglass, Beyoncé Rule, flaky tests, hermetic tests, code coverage, testing culture, Testing on the Toilet, Test Certified.
**Use when:** structuring or balancing a test suite, choosing test size/scope, flaky or slow tests, coverage policy debates, or building testing culture.

### Chapter 12 — Unit Testing (`ch12-unit-testing/`)
Preventing the two failure modes of test suites: brittleness and unclarity. Strive for unchanging tests, test via public APIs, verify state not interactions, one complete-and-concise test per behavior, no logic in tests, DAMP over DRY.
**Topics:** brittle tests, four kinds of code changes, front-door principle, state vs interaction, given/when/then, test naming, failure messages, DAMP vs DRY, shared setup, test infrastructure.
**Use when:** writing or reviewing unit tests, deciding what to assert, structuring or naming tests, helper/fixture debates, or diagnosing a suite that breaks on every refactor.

### Chapter 13 — Test Doubles (`ch13-test-doubles/`)
Using test doubles without wrecking maintainability. Preference ordering: real implementations first, then well-engineered fakes, sparing stubbing, and interaction testing only for state-changing calls.
**Topics:** fakes, stubbing, interaction testing, seams, dependency injection, fidelity, contract tests, @DoNotMock, classical vs mockist, change-detector tests.
**Use when:** deciding whether to mock/stub/fake a dependency, tests drowning in mock setup, designing a fake for an API you own, or state vs interaction assertions.

### Chapter 14 — Larger Testing (`ch14-larger-testing/`)
Why unit tests alone cannot mitigate all risk and how to design larger tests around a System Under Test, seeded data, actions, and verification. Catalogs functional, performance, A/B diff, probers, canary, chaos engineering, and user-evaluation test types.
**Topics:** fidelity, hermetic SUT, contract tests, record/replay, data seeding, A/B diff testing, probers, canary analysis, DiRT, dogfooding, test ownership.
**Use when:** testing beyond unit scope — integration/e2e/system design, SUT environment choice, faithful mocks, testing in production, or slow/flaky/unowned large suites.

### Chapter 15 — Deprecation (`ch15-deprecation/`)
Code is a liability; weigh maintenance cost against removal cost. Distinguishes advisory from compulsory deprecation, explains why removal is harder than building, and prescribes running deprecation as a staffed project with owners, milestones, and tooling.
**Topics:** code as liability, advisory vs compulsory deprecation, alert fatigue, migration tooling, backsliding prevention, unfunded mandates, designing for decommissioning.
**Use when:** sunsetting or deleting a system/API/feature, keep-vs-remove decisions for legacy code, deprecation warnings, or forcing user migrations.

### Chapter 16 — Version Control and Branch Management (`ch16-version-control-and-branch-management/`)
Policy matters as much as tooling: one Source of Truth, the One-Version Rule, and trunk-based development instead of long-lived dev branches. Covers Piper, release vs dev branches, and virtual monorepos.
**Topics:** trunk-based development, One-Version Rule, Source of Truth, monorepo, dev branches, release branches, cherry-picks, DVCS vs centralized, DORA research, build horizon.
**Use when:** branching strategy, monorepo vs many-repo, long-lived feature branches, dependency pinning vs living at head, or release branch policy.

### Chapter 17 — Code Search (`ch17-code-search/`)
Why Google built a centralized zero-setup code search and browsing tool, framed around answering what/where/how/why/who/when questions in one click. Covers Kythe cross-references, indexing, ranking, and latency economics.
**Topics:** code search, browsing, Kythe, cross-references, n-gram indexes, ranking signals, index freshness, canonical code links, completeness and trust.
**Use when:** building or evaluating code search/browsing tools, code intelligence infrastructure, indexing/ranking design, or justifying investment in code-understanding tooling.

### Chapter 18 — Build Systems and Build Philosophy (`ch18-build-systems-and-build-philosophy/`)
Why task-based build systems (Ant, Maven, Gradle) fail at scale and how artifact-based systems (Blaze/Bazel) achieve fast, correct, reproducible builds by restricting flexibility. Covers hermeticity, remote caching/execution, and fine-grained dependency philosophy.
**Topics:** task-based vs artifact-based builds, Bazel, hermetic builds, sandboxing, remote caching, remote execution, 1:1:1 rule, target visibility, strict transitive dependencies, One-Version Rule.
**Use when:** choosing or designing a build system, Bazel migration, speeding up builds, structuring build targets, or managing dependency versions and supply-chain risk.

### Chapter 19 — Critique: Google's Code Review Tool (`ch19-critique-googles-code-review-tool/`)
Dissects Critique's four design values (simplicity, trust, generic communication, workflow integration) and its six-stage review flow. Covers the attention set, approval scoring, analyzer chips with one-click fixes, and reviewer suggestion at scale.
**Topics:** review tooling, Critique, Gerrit, attention set, unresolved comments, diffing, Tricorder integration, reviewer selection, dashboards, change archaeology.
**Use when:** designing or evaluating code review tools and workflows, approval/scoring models, reducing review friction, or integrating analysis and CI signals into review.

### Chapter 20 — Static Analysis (`ch20-static-analysis/`)
Making static analysis effective at scale by prioritizing developer trust (low effective false-positive rates), integrating into the core workflow (review, presubmit, compiler, IDE), and letting any engineer contribute checks. Never emit ignorable compiler warnings; ratchet new rules by cleaning existing violations first.
**Topics:** Tricorder, effective false-positive rate, review integration, Error Prone, clang-tidy, compiler errors vs warnings, suggested fixes, per-project customization, Refaster.
**Use when:** designing or rolling out linters or CI quality checks, deciding where checks run, handling false positives and pushback, or ratcheting a new rule onto an existing codebase.

### Chapter 21 — Dependency Management (`ch21-dependency-management/`)
One of software engineering's hardest problems, centered on the diamond dependency problem. Critiques semantic versioning as a lossy human estimate that SAT solvers escalate into absolutes; surveys static dependencies, bundled distributions, Minimum Version Selection, and Live at Head.
**Topics:** diamond dependency problem, SemVer limitations, dependency hell, Live at Head, MVS, compatibility promises, vendoring, third_party, costs of open sourcing.
**Use when:** importing third-party packages, versioning and upgrade strategy, version conflicts, monorepo dependency policy, or risks of publishing a library.

### Chapter 22 — Large-Scale Changes (`ch22-large-scale-changes/`)
Why large atomic commits become impossible at scale and how Google lands large-scale changes as many small machine-generated shards. Covers the LSC infrastructure (Kythe, ClangMR, Rosie, TAP train, global approvers) and the four-phase LSC process.
**Topics:** LSC, mass refactoring, atomic commit barriers, haunted graveyards, Rosie, TAP train, global approver, codemod sharding, anti-backsliding.
**Use when:** executing sweeping changes across a large codebase — API migrations, compiler upgrades, codemod strategy, reviewing machine-generated changes, or assigning migration ownership.

### Chapter 23 — Continuous Integration (`ch23-continuous-integration/`)
Redefines CI as continuously assembling and testing the entire evolving ecosystem — code, config, upstream services, data. CI is deciding which tests to run when and how to compose the SUT at each stage. "CI is alerting" is the analogy to SRE.
**Topics:** continuous build, release candidates, presubmit vs post-submit, shift left, hermetic testing, mid-air collisions, TAP, Build Cop, culprit finding, rollback-first, Google Takeout case study.
**Use when:** designing or fixing CI pipelines, choosing what runs at each stage, keeping large suites green, flaky-test policy, or CI policy debates like blocking on red.

### Chapter 24 — Continuous Delivery (`ch24-continuous-delivery/`)
Faster is safer: frequent small-batch releases beat rare big ones on quality, risk, and cost. Covers flag-guarding, release trains with hard deadlines, shipping only what gets used, staged rollouts, and protecting the product from developer urgency.
**Topics:** release trains, feature flags, staged rollouts, canary releases, change-neutral releases, velocity is a team sport, error budgets, dynamic deployments, release qualification.
**Use when:** release process design, deployment frequency, safe rollouts, whether to hold a release for a feature, or when releases have become slow and scary.

### Chapter 25 — Compute as a Service (`ch25-compute-as-a-service/`)
Google's evolution from manual SSH deployment to Borg: automation of toil, containerization, multitenancy, and "cattle not pets." How to write software for managed compute and how to choose a compute service given lock-in trade-offs.
**Topics:** Borg, Kubernetes, cattle vs pets, containers, multitenancy, autoscaling, batch vs serving, state management, service discovery, idempotency, serverless vs containers, cloud lock-in.
**Use when:** deployment infrastructure, container orchestration, failure-tolerant service design, stateless vs stateful architecture, serverless/cloud choices, or platform lock-in.

## Cross-chapter reading paths

- **Testing deep dive:** ch11 (overview) → ch12 (unit) → ch13 (doubles) → ch14 (larger) → ch23 (CI).
- **Change safety at scale:** ch01 (Hyrum's Law) → ch16 (trunk/One Version) → ch22 (LSCs) → ch15 (deprecation).
- **Leadership track:** ch02 (teams) → ch05 (leading a team) → ch06 (leading at scale) → ch07 (measurement).
- **Code quality machinery:** ch08 (rules) → ch09 (review) → ch19 (review tooling) → ch20 (static analysis).
- **Shipping pipeline:** ch18 (build) → ch23 (CI) → ch24 (CD) → ch25 (compute).

## Recurring named concepts (and home chapters)

- **Hyrum's Law** — ch01 (also ch14, ch15, ch21, ch25): with enough users, all observable behavior gets depended on.
- **Beyoncé Rule** — ch01, ch11: "if you liked it, you should have put a CI test on it."
- **Shift left** — ch01, ch09, ch23, ch24: catch problems earlier in the developer workflow where they are cheaper.
- **Code is a liability, not an asset** — ch09, ch15.
- **One-Version Rule** — ch16, ch18, ch21.
- **Cattle not pets** — ch22, ch25: treat replicas and machines as replaceable, not hand-maintained.
- **Psychological safety** — ch02, ch03, ch05.
- **Haunted graveyards** — ch03, ch22: code nobody dares touch because knowledge was lost.
