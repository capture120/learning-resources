# Chapter 3: Working with Code

Most engineering work happens in existing codebases, not fresh repositories, and existing code is inevitably messy: layers written by different people in different eras, missing tests, twisted by changing requirements. This chapter explains the forces that create the mess (software entropy and technical debt), teaches a safe method for changing code you didn't write, and warns against the tempting but dangerous reactions to messy code: rewrites, rogue tech choices, ignored standards, and unmaintained forks.

## Core Concepts

### Software Entropy

Code naturally drifts toward disarray as it changes. This drift is *software entropy*. Messy code is a normal side effect of change, not a sign of bad developers, so don't blame past authors for untidiness. Entropy has many causes: developers misunderstand each other's code or differ in style, technical stacks and product requirements evolve, and bug fixes and performance optimizations add complexity.

Entropy can't be eliminated, but it can be managed: code style and bug detection tools keep code clean, code reviews spread knowledge and reduce inconsistency, and continuous refactoring works against the drift.

### Technical Debt

Technical debt is a major cause of software entropy. It is *future work owed to fix shortcomings in existing code*. Like financial debt, it has principal and interest:

- **Principal**: the original shortcoming that needs fixing.
- **Interest**: paid as code evolves without addressing the shortcoming — increasingly complex workarounds get implemented. Interest compounds as workarounds are replicated and entrenched; complexity spreads and causes defects.

Unpaid technical debt is common, and legacy code has a lot of it.

**What does NOT count as debt.** Technical decisions you disagree with are not technical debt. Code you don't like is not technical debt. To qualify as debt, the problem must force the team to "pay interest," or the code must risk triggering a critical problem requiring urgent payment. Overusing the phrase "technical debt" weakens it and makes it harder to get real debt addressed.

**The technical debt quadrant (Martin Fowler).** Debt comes in four flavors along two axes — deliberate vs. inadvertent, and reckless vs. prudent:

| | Reckless | Prudent |
|---|---|---|
| **Deliberate** | "We don't have time for design." | "Let's ship now and deal with consequences." |
| **Inadvertent** | "What's layering?" | "Now we know how we should've done it." |

- **Prudent, deliberate**: the classic form — a pragmatic, known trade-off between a shortcoming and delivery speed. Good debt, as long as the team is disciplined about addressing it later.
- **Reckless, deliberate**: created under delivery pressure. The word "just" is a tell that reckless debt is being discussed ("We can *just* add structured logging later," "*Just* increase the timeout").
- **Reckless, inadvertent**: comes from unknown unknowns. Mitigate by writing down implementation plans and getting feedback before building, doing code reviews, and learning continuously.
- **Prudent, inadvertent**: the natural result of growing experience — some lessons are only learned in hindsight. The team didn't know it was taking on debt; this is learning about the problem domain, not negligence. Healthy teams use retrospectives to discover this debt and decide when and whether to pay it down.

Key takeaway from the matrix: some debt is unavoidable because you can't prevent inadvertent mistakes. Debt can even be a mark of success — the project survived long enough to become messy.

### Addressing Technical Debt

Don't wait for the world to stop so you can fix problems for a month. Clean up and do minor refactoring continuously, as you go, in small independent commits and pull requests.

Sometimes incremental refactoring isn't enough and larger changes are needed. Large refactors are a serious commitment, and the economics are counterintuitive: in the short term, paying down debt slows feature delivery while taking on debt accelerates it; in the long term, the opposite is true. Product managers are incentivized to push for more features (and thus more debt). The right balance is highly context-dependent.

If you want to propose a large refactor or rewrite, make the case to your team first, **in writing**, using this framework:

1. State the situation factually.
2. Describe the risk and cost of the debt.
3. Propose a solution.
4. Discuss alternatives (including not taking action).
5. Weigh the trade-offs.

Never base the appeal on a value judgment ("this code is old and ugly"). Focus on the cost of the debt and the benefit of fixing it. Be specific, and expect to be asked to demonstrate the benefits after the work is done.

### Changing Code

Changing existing code is not like writing code in a fresh repository. You must change behavior without breaking existing behavior, understand what previous developers were thinking, stick to existing styles and patterns, and gently improve the codebase as you go. The techniques are largely the same whether you're adding features, refactoring, deleting code, or fixing bugs — and these change types are often combined (refactoring happens while adding a feature because it makes the feature easier to add; code gets deleted during a bug fix). Changing large codebases is a skill refined over years, even decades.

### The Legacy Code Change Algorithm

Michael C. Feathers (*Working Effectively with Legacy Code*) gives five steps to safely modify existing codebases:

1. **Identify change points** — locate the code that needs to change, by reading code, experimenting, and asking questions.
2. **Find test points** — entry points into the code you want to modify; the places tests can invoke and inject into. Test points reveal behavior before you change anything, and you'll use them to test your changes.
3. **Break dependencies** — if test points aren't accessible, restructure the code so it's testable. "Dependencies" here aren't libraries or services; they're the objects and methods required to test your code. These restructuring changes must NOT change behavior.
4. **Write tests** — add tests that validate existing behavior. Consider automated tooling that generates tests capturing current behavior.
5. **Make changes and refactor** — with the perimeter secured, make the real changes, add tests validating them, and refactor further to improve design.

The mental model: the first four steps are clearing space and building a fence around a field before planting seeds in step five. Until the fence is up, wild animals can dig up your plants.

Breaking dependencies is the riskiest phase — it may involve changing preexisting tests, making behavior changes harder to detect. Take small steps, introduce no new functionality during this phase, and keep tests fast so you run them frequently. Techniques for breaking dependencies:

- Pull a large, complex method apart into smaller methods so pieces can be tested independently.
- Introduce an interface (or other indirection) so tests can supply a simple stand-in for a complex object — incomplete, but sufficient for testing.
- Inject explicit control points to simulate hard-to-control aspects of execution, such as the passage of time.

Do NOT change access modifiers (making private methods or variables public) just to enable tests. It breaks encapsulation and increases the surface area of behavior you must guarantee for the life of the project.

### Leave Code Cleaner Than You Found It

Apply the Boy Scout principle — "always leave the campground cleaner than you found it" — to code. A codebase is shared like a campground, and it's nice to inherit a clean one. Cleaning as you go means code improves over time with no stop-the-world refactoring project; the cost of refactoring is amortized across many changes.

Be opportunistic, not crusading: clean code adjacent to your bug fixes and features, but don't go hunting for dirty code. Keep cleanup commits separate from behavior-changing commits — separation lets you revert functional changes without losing cleanup, and smaller commits are easier to review.

Refactoring isn't the only cleanup. Target *code smells*: code that isn't necessarily buggy but uses patterns known to cause problems. Examples linters can catch: missing braces around conditional bodies, very long methods or classes, duplicate code, excessive branching or looping, too many parameters. Subtler anti-patterns require tooling and experience to spot.

### Make Incremental Changes

Two common bad shapes of refactoring: a giant change-the-world review touching dozens of files at once, and a muddled pull request mixing refactoring with new features. Both are hard to review, and combined commits make it hard to roll back functional changes without losing refactoring you want to keep. Instead: keep refactoring changes small, make separate pull requests for each step of the legacy code change algorithm, use smaller commits when changes are hard to follow, and get team buy-in before a refactoring spree — it's your team's code, and they get to weigh in.

### Be Pragmatic About Refactoring

Refactoring is not always wise. Deadlines and competing priorities exist; refactoring takes time. A team may deliberately skip refactoring to ship features — that adds debt, and it might be the right call. The cost of a refactor can exceed its value: old, deprecated code being replaced doesn't need refactoring, and neither does low-risk or rarely touched code.

### Use an IDE

IDEs carry a stigma among self-styled elite coders who treat editor "help" as weakness and fetishize Vim or Emacs. This is nonsense — use the best tools available. IDEs shine during refactoring: renaming and moving code, extracting methods and fields, and updating method signatures are tedious and error-prone by hand in large codebases, and IDEs do them automatically. Two cautions: don't get carried away (a few easy IDE tweaks can balloon into a huge code review that a human still must review), and know the limits of automation (a renamed method invoked via reflection or metaprogramming won't get updated).

### Use Version Control System Best Practices

Commit to a version control system (e.g., Git), which tracks who made each change and when. Commit early and often during development — frequent commits show evolution, enable undo, and act as a remote backup. But frequent commits produce throwaway messages ("oops," "fix broken test") that are worthless to others. Before submitting for review: rebase your branch, squash your commits, and write a clear commit message.

Follow your team's conventions; prefixing the message with an issue ID (e.g., "[MYPROJ-123] Make the backend work with Postgres") is common and links the change to context, scripts, and tooling. Absent team rules, follow Chris Beams's guidelines:

- Separate subject from body with a blank line.
- Limit the subject line to 50 characters.
- Capitalize the subject line.
- Do not end the subject line with a period.
- Use the imperative mood in the subject line.
- Wrap the body at 72 characters.
- Use the body to explain what and why, not how.

### Avoiding Pitfalls: The 10x Bar for Breaking Convention

Existing code comes with baggage — libraries, frameworks, and patterns already in place — and some standards will bother you. The temptation to rewrite or ignore standards is dangerous: rewrites can destabilize a codebase and come at the expense of new features, and diverging from coding standards makes code harder for everyone.

Borrowing Ben Horowitz's startup rule (a new product must be ten times better to get people to switch), apply the same bar to code: if you want to rewrite code or diverge from standards, your improvement must be an order of magnitude better. Small gains aren't worth the cost. Most engineers underestimate the value of convention and overestimate the value of ignoring it.

### Use Boring Technology

New tools, languages, and frameworks appear constantly, making existing code look dated. But successful companies run durable code on older libraries and patterns for a reason: success takes time, and churning through technologies is a distraction.

New technology is less mature. Per Dan McKinley's "Choose Boring Technology": the failure modes of boring technology are well understood. All technology breaks, but old technology breaks in predictable ways; new technology breaks in surprising ways. Immaturity means smaller communities, less stability, less documentation, less compatibility, fewer Stack Overflow answers.

Sometimes new technology will solve your company's problems and sometimes it won't; discerning when takes discipline and experience, and the benefit has to exceed the cost. Each adoption of new technology costs an *innovation token* — effort that could otherwise go into innovative features — and a company has a limited number. Spend tokens on technologies that serve high-value areas (core competencies), solve a wide range of use cases, and can be adopted by multiple teams. New technology is worth more when it makes the company more competitive, and wide adoption means more teams benefit and less total software to maintain.

Adopting a new *programming language* is especially expensive — it pulls an entire stack (build systems, test frameworks, IDEs, libraries) into your ecosystem. A language may offer major advantages — a particular programming paradigm, ease of experimentation, eliminating some kinds of errors — but those advantages must be balanced against its trade-offs. If a new framework or database costs one innovation token, a new language costs three. The ecosystem's maturity matters as much as the language's features: build and packaging quality, IDE support, library maintainership, test frameworks, paid support, hiring pool, learnability, performance, and integration with existing company tools. Billion-dollar companies are built on boring languages (C, Java, PHP, Ruby, .NET); unless a language is dying, its age and lack of buzz are not arguments against it.

### Don't Go Rogue

Don't ignore company or industry standards because you dislike them. Nonstandard code doesn't fit the company's environment — continuous integration checks, IDE plugins, unit tests, linting, log aggregation, metrics dashboards, and data pipelines are already integrated, so a custom approach is costly even if your preference is genuinely better.

In the short term, do what everyone else does. Try to understand the reasoning behind the standard — it may solve a nonobvious problem. If you can't find a good reason, ask around; if there's still no answer, start a conversation with your manager and the owning team. Changing standards involves priority, ownership, cost, and implementation details, and convincing a team to kill something they own is hard — there will be many opinions, so be pragmatic. As with rewrites, changing something widely adopted is slow, but slow doesn't mean it isn't worth doing. Going through proper channels pays off: exposure across the organization (good for networking and promotions), early-adopter access to the replacement, and influence over its design. Just don't let it crowd out your daily work, and keep your manager aware of the time you're spending.

### Don't Fork Without Committing Upstream

A fork is a complete, independent copy of a repository with its own trunk, branches, and tags. Forking to prepare a pull request is normal and healthy. Forking with no intention of contributing back — due to direction disagreements, abandonment, or merge friction — is unhealthy. Internal company forks are especially pernicious: developers promise to contribute changes back "later," which rarely happens; minor uncontributed tweaks compound until you're running entirely different software; merging upstream features and fixes becomes increasingly difficult; and the team discovers it has implicitly signed up to maintain an entire project. Some companies even end up forking their own open source projects because they don't contribute internal changes.

### Resist the Temptation to Rewrite

Refactoring efforts often escalate into full rewrites because refactoring is daunting and starting fresh feels easier. Treat rewrites as a last resort. Be honest about your motives: disliking the language or framework is not a good reason. Undertake a rewrite only if the benefit exceeds the cost — rewrites are risky and expensive, engineers always underestimate how long they take, and migrations in particular are awful (data must move, upstream and downstream systems must update; it can take years or decades).

Rewrites aren't even reliably better. Fred Brooks's "Second System Syndrome" (*The Mythical Man-Month*) describes how simple systems get replaced by complex ones: the first system is limited in scope because its creators didn't understand the domain — awkward but functional. The now-experienced developers see where they went wrong and pour every clever idea into the second system, designing for maximal flexibility (everything configurable and injectable). Second systems are usually a bloated mess. If you do rewrite, be very cautious about overextending.

## Actionable Practices

The authors' own summary (their Do's and Don'ts):

- DO refactor incrementally.
- DO keep refactoring commits separate from feature commits.
- DO keep changes small.
- DO leave code cleaner than you found it.
- DO use boring technology.
- DON'T overuse the phrase "technical debt."
- DON'T make methods or variables public for testing purposes.
- DON'T be a language snob.
- DON'T ignore your company's standards and tools.
- DON'T fork codebases without committing upstream.

Additional concrete rules from the chapter:

- Don't blame past developers for messy code; entropy is natural.
- Reserve the term "technical debt" for problems that force interest payments or risk critical failure.
- Listen for "just" in planning discussions — it signals reckless, deliberate debt.
- Use retrospectives to surface inadvertent debt and decide whether to pay it down.
- Propose large refactors in writing: facts, risk and cost, solution, alternatives (including doing nothing), trade-offs. Never argue from "old and ugly."
- Follow Feathers's algorithm for any legacy change: change points, test points, break dependencies, write tests, then change and refactor.
- Add tests that capture existing behavior before changing it; run the full suite frequently; keep tests fast.
- Break dependencies by extracting methods, introducing interfaces/indirection, and injecting control points (e.g., for time) — never by weakening access modifiers.
- Take small steps and add no new functionality while breaking dependencies.
- Clean adjacent code opportunistically; don't hunt for dirt.
- Get team buy-in before any refactoring spree.
- Skip refactoring deprecated, low-risk, or rarely touched code.
- Use an IDE for refactoring operations, but review automated changes and watch for reflection/metaprogramming misses.
- Commit early and often locally; rebase, squash, and write a clear conventional message before review.
- Prefix commits with issue IDs where conventional.
- Hold rewrites and standard-breaking to a 10x improvement bar.
- Spend innovation tokens only on high-value, broadly applicable technology; budget a new language at triple the cost of a new framework or database.
- Evaluate a new language's ecosystem (build, IDE, libraries, testing, support, hiring, performance, integration) as heavily as its features.
- Understand the reason behind a standard before challenging it; then go through your manager and the owning team.
- Keep your manager informed when you spend time on standards-change or platform projects.
- Contribute changes upstream instead of accumulating fork drift.

## Pitfalls & Anti-patterns

- **Crying "technical debt" at code you merely dislike.** Dilutes the term, erodes credibility, and makes real debt harder to fund.
- **Reckless deliberate debt under deadline pressure.** "We can just…" workarounds compound interest into entrenched complexity.
- **Stop-the-world refactoring projects.** Waiting for a mythical free month instead of continuous incremental cleanup.
- **Value-judgment refactoring proposals.** "This code is old and ugly" persuades no one; cost/benefit does.
- **Making private members public for testability.** Breaks encapsulation and permanently expands the behavior surface you must guarantee.
- **Changing behavior while breaking dependencies.** The riskiest phase of legacy change; mixing in new functionality hides regressions.
- **Giant change-the-world pull requests, or PRs mixing refactoring with features.** Hard to review; impossible to roll back functional changes without losing cleanup.
- **Refactoring sprees without team buy-in.** It's the team's code, not yours alone.
- **Refactoring code that doesn't need it.** Deprecated, low-risk, or rarely touched code isn't worth the cost.
- **Editor machismo.** Refusing IDE help out of Vim/Emacs purism wastes time and invites errors in large-codebase refactors.
- **Unreviewed bulk IDE refactors.** Easy tweaks create huge diffs humans still must review; automated renames miss reflection and metaprogramming call sites.
- **Submitting "oops"-grade commit history for review.** Fine while working; worthless to everyone else — squash and rewrite first.
- **Chasing shiny technology.** New tech breaks in surprising ways; immaturity costs community, stability, docs, and compatibility.
- **Language snobbery.** Adopting a language for elegance while ignoring its ecosystem and operational cost; dismissing boring languages that power billion-dollar companies.
- **Going rogue on standards.** Even genuinely better personal preferences don't fit the integrated company environment; bypassing proper channels fails and isolates you.
- **Internal forks "to be synced later."** The sync never happens; drift compounds until you maintain a whole divergent project.
- **Refactors escalating into rewrites.** Rewrites are a last resort; engineers always underestimate their duration, and migrations can take years.
- **Second System Syndrome.** Pouring every clever idea into a rewrite produces an overconfigurable, bloated mess.

## Key Terms

- **Software entropy**: the natural drift of a codebase toward disarray as it changes.
- **Technical debt**: future work owed to fix shortcomings in existing code; has principal (the shortcoming) and interest (compounding workarounds built because the shortcoming persists).
- **Technical debt quadrant**: Fowler's 2x2 classification of debt as deliberate vs. inadvertent and reckless vs. prudent.
- **Refactoring**: improving internal code structure without changing functionality.
- **Change points**: the places in the code where your modification must be made.
- **Test points**: entry points into the code under change where tests can invoke and inject — used to observe behavior before and after changes.
- **Breaking dependencies**: restructuring code (without changing behavior) so it can be tested; "dependencies" here are objects/methods needed to test the code, not libraries or services.
- **Code smell**: code that isn't necessarily buggy but uses patterns known to cause problems.
- **Legacy code change algorithm**: Feathers's five steps — identify change points, find test points, break dependencies, write tests, make changes and refactor.
- **Boy Scout principle**: always leave the campground (codebase) cleaner than you found it.
- **Boring technology**: mature technology whose failure modes are well understood; it breaks in predictable ways.
- **Innovation token**: McKinley's notion of a scarce budget for adopting new technology; effort spent on new tech is effort not spent on features. A new language costs roughly three tokens vs. one for a new framework or database.
- **VCS / commit / commit message**: a version control system tracks the history of who changed what and when; each change is a commit with an attached message.
- **Fork**: a complete, independent copy of a repository with its own trunk, branches, and tags.
- **Second System Syndrome**: Brooks's observation that a simple first system tends to be replaced by an overambitious, bloated second system.

## Further Reading (the authors' "Level Up" picks)

- Michael C. Feathers, *Working Effectively with Legacy Code* — the chapter draws on it extensively, and it goes into far more detail; recommended if you're dealing with large, messy codebases.
- Jonathan Boccara, *The Legacy Code Programmer's Toolbox* — another helpful resource on legacy code.
- Martin Fowler — his blog for shorter reads on refactoring, and his canonical book *Refactoring: Improving the Design of Existing Code*.
- Fred Brooks, *The Mythical Man-Month* — a classic every software engineer should read about how software projects run in practice; it applies surprisingly well to daily work on the job.
