# Chapter 15: Deprecation

*Software Engineering at Google* — written by Hyrum Wright, edited by Tom Manshreck.

## Chapter Thesis

All software systems age: even though bits do not physically decay, new technologies, languages, libraries, and ecosystem changes render old systems obsolete, and obsolete systems keep costing money in maintenance, esoteric expertise, and drag on everything around them. **Deprecation** is the process of orderly migration away from, and eventual removal of, an obsolete system. The chapter argues that deprecation belongs to software *engineering* rather than programming because it is about managing systems over time: done well, it reduces resource costs and improves velocity by removing accumulated redundancy and complexity; done poorly, it can cost more than leaving the old system alone. Deprecation is hard for both technical and social reasons, so it must be treated as a real, staffed, managed project — with owners, milestones, policy, and tooling — not as a warning label you attach and walk away from.

## Core Principles and Ideas

### Code is a liability, not an asset

- Code itself does not bring value; the **functionality** it provides brings value. Functionality is an asset if it meets a user need; the code implementing it is merely the means to that end.
- Given identical functionality, one line of maintainable code beats 10,000 lines of convoluted spaghetti. The simpler the code that delivers the same functionality, the better.
- The metric to maximize is **functionality delivered per unit of code**, not lines produced or codebase size. One of the easiest ways to raise that ratio is not writing more code — it is removing excess code and systems that are no longer needed. Deprecation policies and procedures are what make that removal possible.

### When deprecation is (and is not) justified

- Age alone does not justify deprecation. Some old systems (the book cites the LaTeX typesetting system, refined over decades) are excellent and still maintained. "Old" does not mean "obsolete."
- Deprecation is best suited for systems that are **demonstrably obsolete** and for which a **replacement already exists** that provides comparable functionality — more efficient resource use, better security, more sustainable construction, or fixed bugs.
- Keeping two systems that do the same thing is expensive over time: they may need complicated transformation code to interoperate, they can grow to depend on each other (making removal of either harder), and the old system drags on the new one's evolution because the new system must stay compatible with it. Removing the old system frees the replacement to evolve faster.
- Organizations have a limit on how much deprecation work they can absorb simultaneously — both for the teams doing the work and for their customers. (Analogy: repaving every road at once means nobody can drive anywhere.) Choose deprecation projects with care, then commit to finishing them.

### Why deprecation is so hard

- **Hyrum's Law** (the observation that with enough users, every observable behavior of a system will be depended on by somebody): the more users a system has, the more likely they use it in unexpected, unforeseen ways — usage that "happens to work" rather than being "guaranteed to work." Removing a system is the *ultimate* change: you are not altering behavior, you are deleting it entirely, which shakes loose unexpected dependents.
- **No one-to-one mapping**: deprecation usually is not an option until a newer system provides the same or better functionality — but the new system is by definition *different* (otherwise migrating would offer users no benefit). So every use of the old system must be individually evaluated against the new one.
- **Emotional attachment**: engineers resist tearing down things they spent years building ("I like this code!"). This is understandable but self-defeating: an obsolete system is a net cost and should be removed. Google mitigates this by making the source repository searchable *historically*, so removed code can always be found again.
- **The "deprecated vs. not-yet-ready" gap**: an old Google joke says there are two ways of doing anything — the deprecated way and the not-yet-ready way. This is the reality of fast-moving environments where the replacement is "almost" done. Good documentation, clear signposts, and expert teams helping with migration ease the confusion.
- **Political/funding difficulty**: staffing a deprecation team costs visible money, while the cost of letting an old system lumber along is *not readily observable*. This makes deprecation hard to sell to stakeholders, especially when it competes with feature development. Quantitative research techniques (see the book's chapter on Measuring Engineering Productivity) can provide concrete evidence that a deprecation is worthwhile.
- **In-place evolution is usually cheaper**: because full replacement is so hard, it is often better to evolve a system *in situ*. Incrementality does not avoid deprecation entirely, but it breaks the work into smaller, manageable chunks that yield incremental benefits. Google has repeatedly observed that migrating to entirely new systems is extremely expensive and the costs are frequently underestimated.

### Deprecation during design

- Systems can be designed from the start for eventual decommissioning. Choice of programming language, architecture, team composition, and even company policy and culture all affect how easy removal will be later. Other engineering disciplines do this routinely — nuclear power plants are designed (and funded) with decommissioning in mind from day one.
- Software culture works against this: engineers prefer building and launching to maintaining; corporate incentives reward shipping fast; and it is psychologically hard to plan for the demise of what you are building.
- Two questions Google encourages design teams to ask:
  1. How easy will it be for my consumers to migrate from my product to a potential replacement?
  2. How can I replace parts of my system incrementally?
- The support decision is made when the project starts. Once a system exists, the only options are: support it indefinitely, carefully deprecate it, or let it break when some external event kills it. **Do not start projects your organization is not committed to supporting for the expected lifespan of the organization.** Even planned deprecation has costs, but planning plus investment in tools and policy mitigates them.

### Types of deprecation: advisory vs. compulsory

Deprecation is a continuum from "we'll turn this off someday, we hope" to "this goes away tomorrow." Google divides it into two broad kinds:

**Advisory deprecation** ("aspirational deprecation")
- No deadline, not high organizational priority, no dedicated resources. The team hopes clients migrate but cannot force them. As Google's SRE (Site Reliability Engineering) colleagues say: **"Hope is not a strategy."**
- Good for advertising a new system and attracting early adopters. The new system must *not* be in beta: once the old system is deprecated in any way, the replacement is critical infrastructure and must be production-ready and supported indefinitely.
- Advisory deprecation works best when the new system's benefits are **transformative, not incremental**. Users will not migrate on their own for marginal gains; even vastly better systems will not reach full adoption through advisory efforts alone.
- Existing uses of an old system exert conceptual and technical *pull*: a heavily used old system keeps attracting new uses no matter how loudly you say "please use the new one." Marking something deprecated and walking away reduces *new* uses slightly but rarely causes teams to actively migrate.

**Compulsory deprecation**
- Comes with a **deadline** for removal: users still depending on the system past that date will find their own systems broken.
- Counterintuitively, compulsory deprecation scales best by **centralizing migration expertise in a single team** — usually the team removing the old system. That team builds experience and tools reusable across the whole organization (often via the Large-Scale Change process, Google's tooling for making one change across thousands of files).
- The schedule needs a real **enforcement mechanism**: empower the deprecation team to break noncompliant users after sufficient warning and migration help. Without that power, customer teams will always deprioritize migration in favor of features.
- Compulsory deprecation **without staffing** reads as an *unfunded mandate* — customers must shove aside their own priorities just to keep running, creating friction between infrastructure teams and their customers. Google strongly advocates that compulsory deprecations be actively staffed by a specialized team through completion.
- Even with policy behind it, politics can intervene: if the last remaining user is critical infrastructure the whole company depends on, the deadline is not credibly "compulsory" if that team can veto progress.
- **Discovering hidden dependencies**: static analysis over Google's monolithic repository reveals most code-level dependencies, but not all. Dynamic discovery techniques include temporarily turning the old system off in tests of increasing frequency and duration, announcing planned outages of growing length in the months before turndown (similar to Google's Disaster Recovery Testing, "DiRT," exercises), and occasionally renaming implementation-only symbols to see who breaks.

### Deprecation warnings

- Programmatically marking systems as deprecated is useful for both advisory and compulsory efforts — but warnings **prevent new uses; they rarely cause migration of existing uses**. Again: hope is not a strategy.
- Warnings accumulate, especially transitively (library A depends on B depends on C; C's warning surfaces when A builds), until users ignore them entirely — the phenomenon health care calls **alert fatigue**.
- Every deprecation warning must have two properties:
  - **Actionability**: the user can actually act on it, in practical terms, given an average engineer's expertise — e.g., "replace this call with its updated counterpart," or an email listing the concrete steps to move data to the new system.
  - **Relevance**: it surfaces *when the user is performing the indicated action* — warn about a deprecated function while the engineer is writing the code, not weeks after check-in; send the migration email months before removal, not the weekend before.
- Resist plastering warnings everywhere. Google liberally marks old functions deprecated but uses tooling (ErrorProne for Java, clang-tidy for C++) to surface warnings only in **targeted ways** — e.g., only on newly changed lines, catching *new* uses. Intrusive warnings (like deprecated build-graph targets) are reserved for compulsory deprecations where a team is actively migrating users. Tooling delivers the right information to the right people at the right time, allowing more warnings without fatigue.

### Managing the deprecation process

Deprecation projects are managed like any other software project, with a few key differences:

**Process owners**
- Without explicit owners, a deprecation makes no meaningful progress regardless of how many warnings the system emits. The alternatives to explicit ownership are worse: never deprecate anything (maintain every old system forever), or delegate migration to users (which degrades to advisory deprecation and never organically finishes).
- Centralizing deprecation effort builds expertise and makes costs transparent, which actually reduces them.
- **Abandoned projects**: every sizable organization has actively used projects nobody owns — often *because* they were deprecated and the owners moved to the successor. These do not fade away on their own; they need deprecation experts to remove them before they fail at an inopportune time. Removal should be the team's **primary goal**, not a side project — under competing priorities, deprecation always loses. These important-not-urgent cleanups are a great use of 20% time and expose engineers to other parts of the codebase.

**Milestones**
- A new system has natural incremental milestones; a deprecation can feel like it has only one — total removal — which the team may never reach, and which, if the team did its job, nobody outside even notices (the system has no users left by then).
- Do not make total removal the only measurable milestone. Define **concrete incremental milestones** that are measurable and deliver value (e.g., deleting a key subcomponent), and celebrate them the same way you would celebrate feature launches. This matters for morale.

**Deprecation tooling** — three categories:
- **Discovery**: find out how and by whom the obsolete system is used, including unanticipated uses (which may even force revisiting the deprecation decision). Google uses Code Search and Kythe (a code-indexing system) to statically find customers of a library and sample actual usage; logging and runtime sampling in production catch dynamic dependencies; and the global test suite serves as an *oracle* for whether all references to an old symbol are gone (customers are responsible for having tests sufficient to prove removal won't harm them).
- **Migration**: the actual codebase updates are done with the same code-generation and code-review tooling as other large efforts — chiefly the Large-Scale Change (LSC) process.
- **Preventing backsliding**: the often-overlooked piece — stop *new* uses of the thing being removed, or deprecation becomes whack-a-mole (users keep adding uses of the familiar old system faster than the team migrates them — counterproductive and demoralizing). At the micro level, Google's Tricorder static-analysis framework flags new calls to deprecated symbols at code-review time, driven by compiler annotations (like Java's `@deprecated`) that let the owning team control the messaging; in some cases it offers a push-button fix to the replacement. At the macro level, **visibility whitelists** in the build system block new dependencies on the deprecated system, and automated tooling periodically prunes those whitelists as dependents migrate away.

## Actionable Guidance

- Evaluate old systems on ongoing maintenance cost vs. removal cost — not on age.
- Only deprecate when a production-ready replacement with comparable functionality exists.
- Limit concurrent deprecations; pick projects deliberately and commit to finishing them.
- At design time, ask how consumers will migrate away and how parts can be replaced incrementally; do not start projects you will not support long term.
- Never rely on advisory deprecation (warnings alone) to complete a migration; expect it only to slow new adoption.
- For compulsory deprecation: set a deadline, give the deprecation team enforcement power to break noncompliant users after sufficient warning, and staff the team to do the migration work itself — otherwise it is an unfunded mandate.
- Centralize migration expertise in one dedicated team whose primary goal is removal.
- Make every warning actionable (concrete next step an average engineer can perform) and relevant (surfaced at the moment of action, e.g., on newly changed lines at review time); throttle warnings to avoid alert fatigue.
- Discover hidden dependencies with static analysis, production logging/sampling, planned outages of increasing duration, and (sparingly) renaming implementation-only symbols.
- Use the test suite as the oracle that all references are gone.
- Install backsliding prevention early: review-time flags on new uses plus build-system visibility allowlists that get pruned as teams migrate.
- Define and celebrate incremental milestones; do not let "fully removed" be the only measure of progress.
- Prefer incremental in-place evolution over wholesale replacement when turndown costs are counted; expect full-replacement costs to be underestimated.
- Use productivity-measurement research to build the quantitative case for funding a deprecation.

## The Chapter's TL;DRs (verbatim in substance)

- Software systems have continuing maintenance costs that should be weighed against the costs of removing them.
- Removing things is often more difficult than building them to begin with because existing users are often using the system beyond its original design.
- Evolving a system in place is usually cheaper than replacing it with a new one, when turndown costs are included.
- It is difficult to honestly evaluate the costs involved in deciding whether to deprecate: aside from the direct maintenance costs of keeping the old system around, there are ecosystem costs of having multiple similar systems to choose between and that might need to interoperate. The old system might implicitly be a drag on feature development for the new. These ecosystem costs are diffuse and difficult to measure. Deprecation and removal costs are often similarly diffuse.
