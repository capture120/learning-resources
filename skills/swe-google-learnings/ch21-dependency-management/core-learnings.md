# Chapter 21: Dependency Management

## Chapter Thesis

Dependency management is the practice of managing networks of libraries, packages, and other code that your organization does not control: how to import it, how to describe its versions, how to update it, and how to keep an ever-changing web of external code working together over time. The chapter (written by Titus Winters) argues that this is one of the least understood and most important problems in software engineering. The hard part is not importing a single package; it is keeping an entire *network* of transitive dependencies mutually compatible as every node in that network changes on its own schedule, without coordination. The industry's de facto answer, semantic versioning, is a lossy human estimate of change risk that gets treated as an absolute by automated solvers, so it both overconstrains and underprotects at scale. The authors' honest admission: they know what does *not* work at scale better than they know what does. Their strongest bets are (a) turning dependency problems into source-control problems whenever possible, and (b) replacing version-number estimates with actual evidence — running the tests of downstream consumers — a model they call "Live at Head."

## Core Principles and Ideas

### Dependency management vs. source control

- Both topics are about how organizations work with source code. The dividing question is "Does our organization control the development and updating of this subproject?"
- If yes, it is a source-control problem: you have visibility into all usage, you can run all affected tests, and coordination is cheap. This is Google's monorepo approach.
- If no (open source projects, other companies, even other uncoordinated teams with separate repos), it is a dependency-management problem: upstream code changes without knowing about your code, so it can break you.
- **The chapter's strongest single piece of advice: all else being equal, prefer source-control problems over dependency-management problems.** Redefining "organization" more broadly (the whole company instead of one team, e.g. via a monorepo) is very often a good trade-off, because source-control problems are far easier and cheaper to reason about.

### Programming vs. software engineering framing

- For a *programming* task (code you will never need to update), importing a dependency is nearly free: if it works today and is not malicious, use it.
- For a *software engineering* task (code expected to live and be maintained over time — see the book's definition of software engineering as "programming integrated over time"), every dependency carries ongoing maintenance cost. Security vulnerabilities, platform changes, and the surrounding dependency network can force an upgrade regardless of your intent, and the question becomes "how expensive will that forced upgrade be?"
- Much bad practice comes from not knowing which of these two modes you are in. "I got it to work" is not the same as "this works in a supported fashion."

### The diamond dependency problem (conflicting requirements)

- The central failure mode of dependency networks. It requires at least three layers: a low-level library `libbase` is used by two mid-level libraries `liba` and `libb`, which are both used by your code `libuser`.
- If `libbase` ships an incompatible change and `liba` upgrades but `libb` does not (they are separate organizations that do not coordinate), there is no general way for `libuser` to build a working whole: it needs two incompatible versions of `libbase` at once.
- Any conflicting requirement (OS version, compiler version, language version) is isomorphic to a diamond: model the requirement as a hidden node in the dependency graph.
- Languages tolerate diamonds differently. Java can "shade" (rename symbols) to embed multiple isolated versions of a library. C++ has nearly zero tolerance: multiple versions violate the One Definition Rule and cause undefined behavior. But all such workarounds are partial: if *types* from the library are passed between dependencies (e.g. a map created by `libbase` v1 handed to an API expecting `libbase` v2), no renaming trick saves you.
- When you hit a diamond, the only easy fix is to move versions forward or backward until something is compatible. Otherwise you must locally patch dependencies you do not understand — and the person who discovers the conflict is usually the person least equipped to fix it, because the incompatibility lives in code owned by two other groups.
- **The whole field reduces to one question: "How do we avoid conflicting requirements while still allowing change among noncoordinating groups?"**

### Compatibility promises: a dependency is a contract

- A dependency provider should state explicitly what compatibility it promises over time, because that promise sets the consumer's expected maintenance cost. Real-world examples of different points on the spectrum:
  - **C++ standard library**: near-indefinite backward compatibility, including binary (ABI) compatibility — decade-old binaries generally still link. Standing Document 8 (SD-8) defines what kinds of changes the standard library may make. Java is similar.
  - **Go**: promises source compatibility across releases but no binary compatibility (you cannot mix libraries built with different Go versions).
  - **Abseil** (Google's C++ foundation library): promises no ABI compatibility, but promises that any breaking API change ships with an automated refactoring tool that migrates user code. The user's worst case should be "run this tool."
  - **Boost**: promises nothing between versions, by design — it is an experimental proving ground. Not a technical-skill difference from the standard library; purely a difference in what the project chooses to promise.
- Key insight: these are software *engineering* differences, not programming ones. Boost embedded in a critical long-lived system works fine — until you (or anything near you) needs to upgrade.
- Projects with no compatibility promise that are also popular (Boost-like) are the riskiest imports for a codebase with a multi-decade expected lifespan.

### Four theoretical models of dependency management

A good solution must prevent conflicting-requirement problems in a dynamic network without assuming any node stays stable forever. The chapter surveys four models:

1. **Nothing Changes (the Static Dependency Model)**: never update anything; only allow bug fixes that cannot break users. Unsustainable over long time periods (security bugs force updates eventually), but it is where every organization starts — and it is *the right model for most new organizations* until a project demonstrably needs decade-scale life. Version selection is trivial: there are no versions.
2. **Semantic Versioning (SemVer)**: the de facto industry standard. Dotted-triple version numbers (`major.minor.patch`) where a major bump signals breaking API change, minor signals additive change, patch signals low-risk implementation change. Requirements like "requires libbase ≥ 1.5" turn the dependency network into a constraint graph; package managers run version-satisfiability solvers over it — directly analogous to SAT-solvers in logic research (and in fact SemVer constraint satisfaction over a network is NP-complete). When no satisfying assignment exists, that is "dependency hell."
3. **Bundled Distribution Models**: an organization gathers a set of dependencies, finds one mutually compatible set of versions, tests and patches it, and ships the whole collection as a unit — Linux distributions are the canonical case. This introduces a new actor, the *distributor*, who does version selection for everyone. It collapses your dependency network into one aggregated dependency ("I depend on Red Hat version N"). Works great as long as you rely on exactly one bundle.
4. **Live at Head**: the model Google advocates. It is trunk-based development extended to dependencies: always depend on the current version of everything; never commit a change that dependents cannot easily absorb. Providers test proposed changes against the CI of all visible downstream dependents; a change that breaks dependents does not get committed, or ships only after dependents are fixed or an automated migration tool is provided. Safety is determined *experimentally* by tests, not estimated by a version number. Version selection becomes "what is the most recent version of everything?" This shifts significant cost onto API providers and presupposes ubiquitous unit tests and CI — theoretically sound, but unproven across the industry and hard to bootstrap in open source.

### The limits of SemVer

- **A SemVer number is an estimate, not a proof.** The maintainer is guessing "how risky do I think this change is?" without knowing how consumers actually use the API. Compatibility can only be evaluated against actual usage; it cannot be proven from the API alone.
- **SAT-solvers escalate estimates into absolutes.** Package managers treat these human guesses as hard logical constraints, building version-satisfaction logic on a shaky foundation.
- **SemVer overconstrains (false negatives)**: a library bumps its major version for a breaking change to function `Bar`, but your dependencies only use function `Foo`. Everything would actually work, yet the solver refuses to assemble it. Version numbers apply to whole packages, not to the individual APIs that actually changed, so the compression is lossy. Result: needless dependency hell.
- **SemVer overpromises / underprotects (false positives)**: Hyrum's Law — "with a sufficient number of users, every observable behavior of your system will be depended upon by somebody" — means "safe" patch releases break real consumers: a 1 ms latency change, a changed logging format, a changed iteration order of an "unordered" stream. There is no absolute notion of a "breaking change"; breakage is only definable relative to how consumers actually use the code. The fact that package managers even allow pinning to patch versions (`>1.1.14` rather than `1.1`) is a tacit admission that patch versions differ observably.
- **Misaligned incentives**: maintainers bear a tiny fraction of the cost of a major-version bump; most affected users are indirect and never hear about the change. Maintainers who are also users are even incentivized to break things, because designing a better interface is easier without legacy constraints. Go and Clojure handle this well: a major-version bump is expected to be *a fully new package* — if you break compatibility, stop pretending it is the same set of APIs.
- **Human fallibility**: deciding major vs. minor vs. patch is human judgement. Detecting semantic (behavioral) changes algorithmically is computationally infeasible; even syntactic-change tooling is limited. Across thousands of dependencies, expect clerical error.
- **When SemVer does work** — at limited scale, provided all three hold:
  1. Dependency providers are accurate and responsible with version bumps.
  2. Dependencies are fine-grained (so version numbers track actual API units).
  3. All API usage stays within expected/supported usage.
- Google's experience: you cannot maintain all three properties at scale over time. Scale is what exposes SemVer's weaknesses, as compounded fidelity loss produces both dependency hell and silent breakage.

### Minimum Version Selection (MVS)

- Proposed by Russ Cox in 2018 for Go's package management. When a dependency requires `libbase ≥ 1.7`, most solvers pick the *newest* allowed version (say 1.8). MVS picks 1.7 — the *minimum* that satisfies the constraint.
- Rationale: "requires ≥ 1.7" almost certainly means the author developed and tested against 1.7. MVS therefore "produces high-fidelity builds in which the dependencies a user builds are as close as possible to the ones the author developed against." Smaller version jumps are safer, the same way committing an hour of work is safer than dumping a year of work at once.
- MVS implicitly admits SemVer's core flaw: a theoretically compatible newer version may be incompatible in practice. It improves SemVer's practical fidelity without fixing its theoretical or incentive problems. The book calls it a manifest improvement, with the jury still out on whether it makes SemVer "good enough."

### The infinite-resources thought experiment

- Ask: what would dependency management look like with unlimited compute? The industry uses SemVer because (1) it needs only local information, (2) it assumes no tests/CI/compute, and (3) it is existing practice. None of these is fundamental.
- Dependency networks form in only two environments — inside a single organization, and in the open-source ecosystem where source is visible. In both, downstream usage information is theoretically available; SemVer's dominance means we are *choosing to ignore it*.
- The better signal than "in my estimation this change is safe" is *evidence*: run the tests of affected downstream dependencies against every proposed change. If the tests pass, the change is good — no need to classify it as major/minor/patch at all. With enough downstream tests, you get at least a statistical argument of safety in the practical, Hyrum's-Law sense.
- Even without full ecosystem CI, targeted presubmit analysis helps: prioritize tests in dependencies that are heavily used, well maintained, and historically high-signal; scale testing effort to the estimated risk of the change (a pure refactoring needs less downstream testing than removal of a deprecated interface).
- What the OSS ecosystem would need for this model: ubiquitous unit tests; an indexed, queryable dependency graph including *reverse* edges (dependents, not just dependencies); widely available CI compute; unpinned dependencies (pins block experimental testing of upstream changes); and reputation/history signals in CI scoring.
- Testing every historical version combination is infeasible even for Google, so the natural simplification is "test against the current stable version of everything" — which means **the infinite-resources model converges on Live at Head.**

### Exporting dependencies: being a provider

- Publishing a library (open source or closed) is not simple charity or business upside. Two failure modes:
  1. **Reputation loss**: a poorly maintained release hurts your organization and the community. Apache's saying applies: prioritize "community over code."
  2. **Engineering-efficiency tax**: if the internal and external copies cannot stay in sync, you have a fork — and given time, all forks become expensive.
- External users you cannot see, in organizations with different priorities (especially paying customers), will exert Hyrum's-Law inertia on your code and can veto or delay your internal engineering changes for years.
- The learned rule: **do not release things without a plan and a mandate to support them long-term.** External users of an API cost far more to maintain than internal ones.

## Actionable Guidance

- Prefer source-control problems to dependency-management problems: pull code into your organization's visibility and CI when you can (e.g. monorepo-style consolidation across teams).
- Know whether you are doing programming (throwaway, never upgraded) or software engineering (maintained over time) before importing anything; apply dependency discipline only where time matters — but be honest about expected lifespan.
- Before importing a dependency, ask Google's checklist:
  - Does the project have tests you can run, and do they pass?
  - Who provides it? (Reputation and skill vary enormously; depending on the C++ standard library or Guava is not like depending on a random GitHub/npm package.)
  - What compatibility does the project aspire to? Does it document what usage is supported?
  - How popular is it? How long will you depend on it? How often does it make breaking changes?
  - And internally: how hard would it be to implement this yourselves? What incentives will keep the dependency updated? Who will perform an upgrade, and how difficult will it be?
- When it matters long-term, choose well-maintained dependencies; a small set of carefully chosen, fine-grained, responsibly versioned dependencies is the regime where SemVer actually works.
- Require real ownership for imported third-party packages — Google's minimum of "two engineers signed as OWNERS" proved too weak; ownership rots as people change teams. Make regular updating easier and more rewarding than letting a package sit; treat popular no-compatibility-promise projects (like Boost) as high-risk imports for long-lived codebases.
- Update dependencies frequently in small steps rather than rarely in giant leaps; an upgrade spanning years of accumulated releases plus Hyrum's-Law accretion, forced under security-deadline pressure, is the worst case.
- If you provide a dependency: publish an explicit statement of intent about compatibility, supported usage, and breaking-change policy — even a best-effort, nonbinding statement gives everyone a basis for reasoning.
- If you must make a breaking change as a provider: fix downstream users first, or ship an automated migration tool so any consumer can update without expert knowledge (the Abseil promise).
- If you break backward compatibility wholesale, consider the Go/Clojure convention: release it as a new package rather than a major-version bump of the old one.
- As a consumer under Live at Head, keep your tests passing and use dependencies only in supported ways — flaky or brittle tests get labeled low-signal and skipped, forfeiting your protection.
- Prefer MVS-style minimum version selection where available: it selects versions closest to what authors actually tested against.
- Prefer languages with real public/private API access control; naming an API `ForInternalUseOnly...` does not stop users from depending on it.
- Do not open source or otherwise externally release a library without a long-term support plan and an organizational mandate behind it.

## The Chapter's TL;DRs (verbatim from the book)

- Prefer source control problems to dependency management problems: if you can get more code from your organization to have better transparency and coordination, those are important simplifications.
- Adding a dependency isn't free for a software engineering project, and the complexity in establishing an "ongoing" trust relationship is challenging. Importing dependencies into your organization needs to be done carefully, with an understanding of the ongoing support costs.
- A dependency is a contract: there is a give and take, and both providers and consumers have some rights and responsibilities in that contract. Providers should be clear about what they are trying to promise over time.
- SemVer is a lossy-compression shorthand estimate for "How risky does a human think this change is?" SemVer with a SAT-solver in a package manager takes those estimates and escalates them to function as absolutes. This can result in either overconstraint (dependency hell) or underconstraint (versions that should work together that don't).
- By comparison, testing and CI provide actual evidence of whether a new set of versions work together.
- Minimum-version update strategies in SemVer/package management are higher fidelity. This still relies on humans being able to assess incremental version risk accurately, but distinctly improves the chance that the link between API provider and consumer has been tested by an expert.
- Unit testing, CI, and (cheap) compute resources have the potential to change our understanding and approach to dependency management. That phase-change requires a fundamental change in how the industry considers the problem of dependency management, and the responsibilities of providers and consumers both.
- Providing a dependency isn't free: "throw it over the wall and forget" can cost you reputation and become a challenge for compatibility. Supporting it with stability can limit your choices and pessimize internal usage. Supporting without stability can cost goodwill or expose you to risk of important external groups depending on something via Hyrum's Law and messing up your "no stability" plan.
