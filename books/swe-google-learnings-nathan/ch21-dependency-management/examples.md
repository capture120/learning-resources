# Chapter 21: Dependency Management — Examples, Case Studies, and Anecdotes

These are all the substantive examples the chapter uses, retold in plain language. Terms are defined on first use.

## The Diamond Dependency Problem (libbase / liba / libb / libuser)

**Setup.** This is the chapter's running toy model of a dependency network. A dependency network is the full graph of libraries your code pulls in, directly and transitively. A low-level library `libbase` is used by two mid-level libraries, `liba` and `libb`, developed by separate organizations. Your application `libuser` depends on both `liba` and `libb`. Drawn as a graph, the four nodes form a diamond shape — hence the name.

**What happens.** `libbase` releases a version with an incompatible change. `liba` upgrades to the new `libbase`; `libb` stays on the old one. Since `liba` and `libb` do not coordinate, this is inevitable eventually. Now `libuser` needs two incompatible versions of `libbase` in the same build, and in the general case there is no way to make that work. Some languages soften the blow: Java can "shade" (rename the symbols of) one copy so two isolated versions coexist. C++ has almost zero tolerance — two versions of the same library violate its One Definition Rule and produce undefined behavior. But even shading fails when data types cross library boundaries: a map object created by `libbase` v1 cannot be handed to an API that expects a `libbase` v2 map in any semantically consistent way.

**The lesson.** The central problem of dependency management is conflicting requirements across a *network*, not managing any single import. The engineer who discovers the diamond is typically the least equipped to fix it, since the incompatibility lives in two other groups' code. Any conflicting requirement (compiler version, OS, language version) is the same problem with a hidden node in the graph. Every dependency-management scheme is ultimately judged by how it prevents or resolves diamonds while still letting uncoordinated groups change their code.

## Four Compatibility Promises: C++ Standard Library, Go, Abseil, Boost

**Setup.** A compatibility promise is a dependency provider's public statement of what kinds of changes consumers should expect between versions, which determines the consumer's expected maintenance cost. The chapter compares four major infrastructure projects.

**What happens.**
- The **C++ standard library** offers near-indefinite backward compatibility, including ABI compatibility (binary artifacts built against an old version still link against a new one — on Linux gcc, roughly a decade of stability in practice). Its Standing Document 8 (SD-8) implicitly defines the small set of change types the library may make. **Java** is similar: old JAR files work with new releases.
- **Go** promises source compatibility between most releases but no binary compatibility: you cannot link a library built with one Go version into a program built with another.
- **Abseil**, Google's foundational C++ library (underpinning about 250 million lines of internal C++ code), refuses to promise ABI stability or indefinite API stability, because freezing known-faulty APIs forever "feels wrong." Instead it promises: any breaking API change ships with an automated refactoring tool that rewrites user code from the old API to the new. The worst cost a user should ever face is "run this tool."
- **Boost**, a prominent C++ library collection, promises nothing between versions. Boost is an experimental proving ground by design; users are told to upgrade only when a change will not cause problems. The book stresses this is not about skill — Boost developers are as expert as standard-library developers — it is purely about what the project chooses to prioritize.

**The lesson.** A dependency is a contract, and providers occupy legitimately different points on the promise spectrum. Consumers must read the promise before importing: a no-promise library embedded deep in a decades-lived system works fine right up until anything forces an upgrade. These are software engineering (change-over-time) concerns, not programming concerns.

## Alice and Bob: How a third_party Import Rots at Google

**Setup.** Google keeps external open-source code in a monorepo directory called `third_party`. Policy for adding a package is a light checklist: it builds, no duplicate already exists, and two engineers sign on as OWNERS (nominal maintainers). The chapter walks through a hypothetical but "unfortunately common" scenario.

**What happens.** Alice, an engineer rushing to finish a demo before vacation, finds an open-source package that solves her problem. She adds it to `third_party` and recruits teammate Bob as the second OWNER. Neither knows anything about the package's internals. The package is now available to all of Google. Silently, other teams adopt it — Charlie adds a dependency from deep inside Search infrastructure, making the package critical to major Google systems, with no signal to anyone. Years pass without updates; Hyrum's Law reliance on the exact checked-in version accretes (Hyrum's Law: with enough users, every observable behavior of a system will be depended upon by somebody). Then a security vulnerability forces an urgent upgrade. Bob is now a manager; Alice changed teams; nobody updated the OWNERS file; thousands of projects depend on the package indirectly, so it cannot be deleted. The upgrade must span every release between the original import and the disclosure, performed under security-team pressure by people with no experience in the package.

**The lesson.** Google's own third_party policies "don't work" for this common case — the book says plainly, "we could do better." Importing needs a higher ownership bar; regular updating must be easier and more rewarding than letting a package sit; and packages must not be allowed to become simultaneously orphaned and load-bearing. Popular projects with no compatibility promise (Boost-like) are especially dangerous inside a codebase with a decades-long expected lifespan.

## Linux Distributions as the Bundled-Distribution Model

**Setup.** One long-standing industry model for dependency management is to draw a bigger box around many dependencies and release the collection as one unit. Linux distributions (e.g. Red Hat) are the canonical instance.

**What happened / how it works.** A distribution's components are not cut from the same moment in time — lower-level pieces are usually older than higher-level ones, reflecting integration lag. The distributors are a new class of engineer whose whole job is version selection: proposing a mutually compatible set of versions, testing the bundle, patching and resolving conflicts. For the consumer, an entire dependency network collapses into a single versioned dependency: "I depend on Red Hat version N" instead of "I depend on these 72 libraries at these versions."

**The lesson.** Delegating version selection to dedicated distributors works well — but only as long as you rely on exactly one bundle. It is one of the four viable theoretical models the chapter identifies (alongside Nothing Changes, SemVer, and Live at Head).

## SemVer Overconstraint: The Two-Function Library (Foo and Bar)

**Setup.** Semantic versioning (SemVer) attaches `major.minor.patch` numbers to releases, where a major bump signals a breaking change. Package managers run constraint solvers over these numbers. Imagine `libbase` contains exactly two functions, `Foo` and `Bar`. Both `liba` and `libb` use only `Foo`.

**What happens.** The maintainer makes a breaking change to `Bar` — a function nobody in this network calls — and, following SemVer rules, bumps `libbase` to 2.0. The solver sees that `liba` and `libb` require `libbase` 1.x and refuses to assemble the build, even though every actual line of code would work together flawlessly.

**The lesson.** SemVer compresses "something in this package changed incompatibly" into a whole-package number, losing the granularity of which API actually changed. The result is false incompatibility: dependency-hell effort that is a complete waste of time. Version numbers would need to apply per atomic API unit to be accurate, and they almost never do.

## SemVer Overpromising: Hyrum's Law Breaks "Safe" Patches

**Setup.** SemVer assumes changes fall cleanly into three buckets: breaking, purely additive, or non-API-impacting (patch). The chapter probes that assumption with concrete borderline changes.

**What happens.** Consider a patch release that adds one millisecond of latency to a time-sensitive API; or changes the format of logging output; or changes the order external dependencies are imported; or changes the result order of an explicitly "unordered" stream. None of these touch the API's syntax or contract, yet at scale each will break some consumer, per Hyrum's Law. Even naming an API `ForInternalUseByLibBaseOnlyDoNotTouchThisIReallyMeanIt` does not stop people from depending on it (the book notes from experience that scary names don't work — prefer languages with real access control). Meanwhile the very existence of patch-level version pins (`requires libbase > 1.1.14`) is an ecosystem-wide admission that patch versions differ observably.

**The lesson.** "Breaking change" is not a property of a change in isolation; it can only be evaluated against how consumers actually use the code — information SemVer does not carry. A solver can therefore report your dependencies compatible when they are not, producing build errors or runtime bugs with no upper bound on severity.

## Go and Clojure: Major Version Bump = New Package

**Setup.** SemVer gives maintainers weak incentives to preserve compatibility: indirect users never hear about breaking changes, and maintainers bear a tiny fraction of the cost they impose. Some ecosystems restructure the incentive.

**What happens.** In Go's and Clojure's standard package-management ecosystems, the equivalent of a major-version bump is expected to be released as a fully new package, with new naming.

**The lesson.** The book calls this "a certain sense of justice": if you are willing to throw away backward compatibility, stop pretending it is the same set of APIs. Making the provider do the repackaging work is a reasonable price for taking the nuclear option, and it correctly reallocates cost from the many consumers to the one breaker.

## Minimum Version Selection: Russ Cox and Go's Package Manager

**Setup.** In 2018, Google's Russ Cox, writing the essay series behind Go's module system, proposed Minimum Version Selection (MVS) as a variation on SemVer-based version selection. Conventional solvers, when a constraint like "requires libbase ≥ 1.7" must be satisfied, pick the newest allowed version.

**What happened.** MVS picks the *oldest* satisfying version instead: if `liba` requires `libbase ≥ 1.7`, MVS installs 1.7 even when 1.8 exists. The insight: "requires ≥ 1.7" almost certainly means the `liba` author had 1.7 installed while developing and testing, so choosing 1.7 "produces high-fidelity builds in which the dependencies a user builds are as close as possible to the ones the author developed against." It is anecdotal interoperability evidence rather than proof, but it is something — and smaller forward steps are safer than big leaps, just as committing an hour of work is safer than dumping a year of it at once.

**The lesson.** MVS implicitly concedes SemVer's core flaw (theoretically compatible versions may be practically incompatible) and buys back practical fidelity without fixing the underlying theory or incentives. The book judges it a manifest improvement over standard SemVer practice, with the jury still out on whether it makes SemVer "good enough."

## Open Sourcing gflags: A Reputation-Damaging Gift

**Setup.** Around 2006 Google open sourced its C++ command-line flag-parsing library (gflags), expecting a purely good act of giving back to the community.

**What happened.** Several forces doomed the release. Google could not yet perform large-scale internal refactorings, so internal code could not move to track the external version. Repository policy segregated in-house code from code with legal/licensing concerns. Accepting outside contributions raised ownership issues, so external patches could not flow back into Google's internal copy. The project was thus fated to be a "throw it over the wall" release — a disconnected fork. Company priorities then shifted: Google's toolchain narrowed to its in-house configuration, making the portability work an external OSS project needs nearly impossible to sustain. The original authors moved on; no team owned the external project or could justify supporting it; it rotted publicly until outside developers forked it and gave it proper attention.

There was a second, technical aftershock. A few Google-adjacent projects with unusual portability needs discovered (by trial and error) the stable common API subset shared by the internal and external forks, and between roughly 2008 and 2017 silently built on that accidental stability, swapping fork versions by environment. When C++ library teams later tweaked observable-but-undocumented parts of the internal flag implementation, those projects' builds broke and they "started screaming." A fleet-wide optimization worth thousands of aggregate CPUs was significantly delayed — not by the 250 million lines of code that used the supported API, but by a tiny handful of projects relying on unpromised behavior across forks. Hyrum's Law struck even across separately maintained forks in separate organizations.

**The lesson.** "Don't release things without a plan (and a mandate) to support it for the long term." An unmaintained release damages reputation and, via forks and accidental Hyrum's-Law contracts, can constrain your internal engineering years later.

## AppEngine: Paying Customers Freeze the Toolchain for Three Years

**Setup.** Google AppEngine is a service that lets external customers run applications on Google-managed infrastructure in popular languages. Its Python support originally ran a 32-bit build of an older Python interpreter. AppEngine itself was built in Google's monorepo with the common internal toolchain, in Python and C++.

**What happened.** In 2014 Google began a major coordinated upgrade of the Python runtime alongside its C++ compiler and standard library, effectively coupling "builds with the current C++ compiler" to "uses the new Python." For most internal projects this was a non-issue, with experts unblocking a few Hyrum's-Law edge cases. But AppEngine discovered that many of its *paying customers* could not or would not update — some refused the newer Python version, others could not afford the memory-consumption jump from 32-bit to 64-bit Python. Because significant revenue was at stake, AppEngine made a successful business case to delay the forced migration. That meant every piece of C++ code in AppEngine's transitive dependency closure had to remain compatible with the old compiler and standard library. The freeze lasted almost three years.

**The lesson.** Inside the monorepo, Google constrains users to its technical stack and can see all usage, so change stays possible. The moment you expose an API to outside users — especially ones paying you — you inherit competing priorities and unforeseeable constraints you cannot engineer around. External users of an API cost far more to maintain than internal ones. Release APIs with eyes open to that long-term risk.
