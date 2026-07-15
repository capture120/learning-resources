# Chapter 1: What Is Software Engineering?

*From "Software Engineering at Google" (written by Titus Winters, edited by Tom Manshreck).*

## Chapter Thesis

Software engineering differs from programming along three dimensions: time, scale, and the trade-offs at play. Google's shorthand is "Software engineering is programming integrated over time." Programming is the immediate act of producing code; software engineering is the set of policies, practices, and tools needed to keep that code useful for its entire life span and to let a team collaborate on it. Because expected code life spans vary by a factor of roughly 100,000 (minutes to decades) and organization sizes vary by a factor of roughly 10,000, no single set of best practices applies universally. The engineer's job is to aim for sustainability — the *capability* to react to any valuable change for the life of the software — and to manage the scaling costs of the organization, the product, and the development workflow while making explicit, evidence-based trade-off decisions.

## Core Principles and Ideas

### "Programming integrated over time"

- Programming (development) is a subset of software engineering (development plus modification plus maintenance).
- Adding time as a dimension changes the problem qualitatively. The book's analogy: cubes aren't squares, distance isn't velocity, software engineering isn't programming.
- The key diagnostic question is "What is the expected life span of your code?" Here "life span" means maintenance lifetime — how long the code will continue to be built, executed, and maintained — not execution time. Reasonable answers vary by a factor of 100,000, from minutes to decades.
- Code on the short end of the spectrum is effectively "just" a programming problem. As life span grows, change to dependencies, operating systems, language versions, and product direction becomes near-certain, and the problem becomes software engineering.
- A memorable framing: "It's programming if 'clever' is a compliment, but it's software engineering if 'clever' is an accusation."
- Neither domain is superior. They are distinct problem domains with different constraints and best practices. Integration tests, continuous deployment, semantic versioning, and dependency management matter for long-lived projects; a few-day project should just use whatever solves the task.

### Sustainability

- Definition: a project is sustainable if, for the expected life span of the software, you are *capable* of reacting to whatever valuable change comes along, for technical or business reasons.
- Capability is the requirement, not action. You may rationally choose to skip a given upgrade. Being fundamentally *unable* to react is a high-risk bet that the change never becomes critical. Safe for short projects; probably not over decades.
- Codebase-level version: "Your organization's codebase is sustainable when you are able to change all of the things that you ought to change, safely, and can do so for the life of your codebase."
- A hand-wavy but useful definition of technical debt from the chapter's footnotes: things that "should" be done but aren't yet — the delta between your code and what you wish it was.

### The multiperson dimension

- An early definition of software engineering the book endorses: "The multiperson development of multiversion programs." The difference from programming is one of both time and people.
- Programming is often individual creation; software engineering is a team effort, which brings new problems but also greater potential value than any single programmer could produce. These scale concerns go back to Frederick Brooks's *The Mythical Man-Month*.

### Hyrum's Law (the Law of Implicit Dependencies)

- Statement: "With a sufficient number of users of an API, it does not matter what you promise in the contract: all observable behaviors of your system will be depended on by somebody."
- The book treats Hyrum's Law like entropy in thermodynamics: it cannot be eradicated, only understood and mitigated. Just as entropy's inevitability doesn't stop us pursuing efficiency, Hyrum's Law's inevitability doesn't stop us planning for change.
- Practical consequence for API owners: your stated interface contract gives you some freedom, but the real difficulty of a change depends on how useful users find your *observable* behaviors. Given enough time and users, even the most innocuous change will break someone. The value analysis of any change must include the cost of investigating, identifying, and resolving those breakages.
- Hyrum's Law marks the difference between "it works" and "it is maintainable/correct."

### Why "nothing changes" is not a viable plan

- For most projects over a long enough period, everything underneath them might need to change. Exceptions exist (pure C with only very stable dependencies like POSIX) but are rare.
- Three forces make change necessary even when you made no mistakes:
  - Security vulnerabilities (Heartbleed, Meltdown, Spectre) surface in dependencies at every level and demand the ability to patch.
  - Hardware evolution shifts what "efficient" means (e.g., the widening CPU-cycles-versus-memory-latency gap makes linked lists and binary search trees relatively worse); old optimizations stop being helpful even though nothing broke.
  - Product and business direction changes.
- Change is not inherently good; don't change for change's sake. But you must be *capable* of change, and if change is eventually necessary, consider investing to make it cheap. Practice and expertise drive efficiency and reliability (like actually rehearsing a tape-backup restore instead of only knowing it's theoretically possible).

### The upgrade transition and the first-upgrade penalty

- Somewhere between a one-off script and a decades-long project, a transition happens: the project must start reacting to changing externalities. (The book's footnote estimate: this transition generally lands somewhere between 5 and 10 years of expected life.)
- For a project that never planned for upgrades, the first upgrade is painful for three compounding reasons:
  - The task has never been done for this project, so more hidden assumptions have been baked in.
  - The engineers doing the upgrade lack experience with this kind of task.
  - The upgrade is bigger than usual — several years' worth of changes at once instead of incremental steps.
- After one painful upgrade, teams overestimate the cost of the next one and conclude "never again," leading either to full rewrites or to freezing forever. The more responsible answer is often to invest in making upgrades less painful.
- Expect the first upgrade of a codebase to be significantly more expensive than later ones, even controlling for other factors. The more frequently you upgrade infrastructure, the easier it becomes: upgraded code stops depending on implementation nuances and starts depending on the actual guaranteed abstraction.
- Getting past the first big upgrade *and* reaching the point where you can reliably stay current is the essence of long-term sustainability.

### Scale and superlinear costs

- Everything the organization relies on to produce and maintain code — human effort, development compute (test clusters, build farms), and the codebase itself (build system, version control) — must scale sublinearly with organization and codebase growth. (The book's informal meaning of "scalable": sublinear scaling with regard to human interactions.)
- If costs grow superlinearly, the operation is not sustainable: when the project doubles, the task costs more than double, and eventually you can't do it at all.
- These problems are boiled-frog problems: metrics like full-build time, repo-clone time, or language-upgrade cost degrade slowly and never present a single moment of crisis. Only organization-wide awareness and commitment keeps them in check.
- A footnote's useful model: an average engineer produces a roughly constant number of lines of code per unit time, so a fixed engineering population grows the codebase linearly. Any task whose effort scales with lines of code is therefore a concern.

### Spotting policies that don't scale

- Heuristic: consider the work a policy imposes on a single engineer, then imagine the organization 10x or 100x larger. If the engineer's work grows with the size of the organization or the codebase, and nothing automates or optimizes it, the policy has a scaling problem.
- Anti-example 1 — traditional deprecation: "We'll delete the old Widget on August 15th; make sure you've converted." Pushing migration work onto every customer team fails as the dependency graph deepens.
- Anti-example 2 — per-team development branches: merging less frequently to "stabilize" trunk creates ever-growing resync-and-test overhead as branch count grows with the organization.

### Policies that scale well

- The Churn Rule (Google, 2012): infrastructure teams must migrate their internal users to new versions themselves, or do the update in place in a backward-compatible way — rather than pushing migration work onto users. A dedicated group of experts learns the whole problem once and applies that expertise everywhere; forcing every user team to respond to churn means each team ramps up badly, solves only its own case, and throws the knowledge away. Expertise scales better; it pairs with economies of scale.
- The Beyoncé Rule: "If a product experiences outages or other problems as a result of infrastructure changes, but the issue wasn't surfaced by tests in our Continuous Integration (CI) system, it is not the fault of the infrastructure change." Colloquially: "If you liked it, you should have put a CI test on it." One-off bespoke tests outside common CI don't count. This frees infrastructure teams from tracking down every affected team and asking how to run their tests — feasible with a hundred engineers, impossible at tens of thousands.
- Shared expertise and communication forums: knowledge is viral, experts are carriers. One helpful Java expert answering questions in a shared forum soon produces a hundred engineers writing better Java.

### Codebase flexibility factors

From Google's compiler-upgrade experience, five factors determine how flexible (upgrade-ready) a codebase is:

- **Expertise** — the team knows how to do the upgrade because it has done many.
- **Stability** — adopting releases regularly means less change between releases.
- **Conformity** — most code has already been through prior upgrades.
- **Familiarity** — routine upgrades reveal redundancies that can be automated (parallels the Site Reliability Engineering concept of eliminating toil).
- **Policy** — rules like the Beyoncé Rule mean infra teams only worry about usage visible in CI, not every unknown usage.

The deeper lesson: once a recurring task is recognized as necessary, find ways to perform it with a *constant* number of engineers even as the codebase grows. Stagnation is an option but rarely a wise one.

### Shifting left

- Picture the developer workflow as a timeline running left to right: conception, design, implementation, review, testing, commit, canary, production deployment.
- Finding problems earlier ("shifting left" on that timeline) reduces cost. A security flaw found in production is very expensive; found before deploy, cheaper; found before the developer even commits, cheapest — the developer still has full context and can revise immediately instead of forcing someone else to triage later.
- The term originated in security ("shift left on security") but the pattern generalizes: static analysis and code review catch bugs far more cheaply than production does. No single tool must be perfect; adopt defense in depth and catch as many defects as far left as possible.

### Trade-offs, costs, and decision making

- "Cost" is not just money. It aggregates:
  - Financial costs (money)
  - Resource costs (CPU time)
  - Personnel costs (engineering effort)
  - Transaction costs (what it costs to take action)
  - Opportunity costs (what it costs to *not* take action)
  - Societal costs (impact on society at large)
- Societal costs were historically easy to ignore, but at billions of users even small discrepancies in usability, accessibility, fairness, or potential for abuse are magnified — often to the detriment of already-marginalized groups.
- In software engineering, financial cost is usually not the limiting factor; personnel cost is. Keeping engineers happy, focused, and engaged can dominate other factors because focus and productivity vary easily by 10-20%.
- Beware decision biases: status quo bias, loss aversion.
- Legitimate grounds for a decision reduce to two:
  - We must (legal requirements, customer requirements).
  - It is the best option we can see at the time, based on current evidence, as determined by an appropriate decider.
- "Because I said so," "just because," and "because everyone else does it this way" are where bad decisions lurk. The goal is consensus, not unanimity — "I don't agree with your metrics but I see how you got there" is fine. There must be a decider and clear escalation paths.
- Two decision scenarios:
  - **Everything is measurable or estimable** (CPU vs. RAM vs. network vs. engineer-time). No excuse for being bad at these. Maintain a conversion table (this many CPUs = this much RAM = this much bandwidth) so every engineer can run their own trade-off analysis.
  - **Some quantities are subtle or unmeasurable** (the cost of a poorly designed API; societal impact). Rely on experience, leadership, and precedent; treat these decisions with equal priority and *greater* care.
- "Google is a data-driven culture" is a simplification: even without data there is evidence, precedent, and argument. Instinct and accepted best practice are acceptable only after attempts to measure or estimate the true costs are exhausted.

### Revisiting decisions and admitting mistakes

- Decisions are made on currently available data; data changes over time, assumptions get dispelled, contexts shift. A data-driven culture therefore implies both the ability and the *necessity* of admitting mistakes and changing direction.
- For long-lived projects, the ability to change course after an initial decision is often critical. Deciders need the right to admit mistakes. Leaders who admit mistakes are more respected, not less.
- Be evidence driven, but recognize that unmeasurable things can still have value; leaders are asked to exercise judgment and assert that things are important.

### Jevons Paradox (in a software context)

- Consumption of a resource may *increase* in response to greater efficiency in its use. Making builds cheap and distributed removed the incentive individual engineers had to keep builds lean, and build bloat ran rampant. Efficiency improvements need accompanying incentive and governance design.

### The fork-versus-depend trade-off (time versus scale in conflict)

- Time and scale usually reinforce each other (the Beyoncé Rule helps both). They conflict most clearly in the question: add a dependency, or fork/reimplement it?
- Forking a bespoke solution can outperform a general-purpose utility, ease feature addition, and isolate you from upstream churn — you control when to react to change.
- But if everyone forks everything, scalability and sustainability suffer: a security fix in a library now requires finding every vulnerable fork and all of *their* users.
- Guidance: short-lived projects can fork with less risk; provably scope-limited forks are safer; avoid forking anything that operates across time or project boundaries — data structures, serialization formats, networking protocols. Consistency has great value, but generality has costs; a careful bespoke solution can win.

## Actionable Guidance

- Ask "What is the expected life span of this code?" before choosing practices; match rigor to life span rather than applying one standard everywhere.
- Aim for capability to change, not constant change. Make deferred maintenance an explicit, recorded decision with its deferred costs stated.
- Do upgrades regularly and incrementally rather than in rare big-bang efforts; budget for the first upgrade being much more expensive than subsequent ones.
- Adopt a Churn Rule: infrastructure teams migrate their users or ship backward-compatible updates; never push migration work onto every consumer team.
- Adopt a Beyoncé Rule: only breakage surfaced by the common CI system counts against an infrastructure change; teams that care about a behavior must put a CI test on it.
- Stress-test every recurring policy with the 10x/100x question: does per-engineer work grow with org or codebase size, and is anything automating it away?
- Watch slow-moving boiled-frog metrics deliberately: full-build time, repository clone time, cost of a language-version upgrade, per-person test-cluster compute.
- Shift problem detection left: invest in static analysis, code review, and pre-commit tooling; use defense in depth across the workflow.
- Track your organization's costs for compute and engineer-time and publish a conversion table so any engineer can evaluate trade-offs like "two weeks of work to save 2,000 CPUs at a cost of 5 GiB of RAM."
- Include personnel, transaction, opportunity, and societal costs in every cost analysis, not just dollars and machines.
- Ban "because I said so" as a decision rationale; require either necessity or best-current-evidence, with a named decider and escalation paths.
- Revisit past decisions when data changes; make it culturally safe for deciders to admit mistakes.
- Prefer dependencies over forks for anything crossing time or project boundaries (data structures, serialization formats, network protocols).
- Cultivate and concentrate expertise: shared Q&A forums and dedicated expert teams for recurring changes scale far better than distributing the burden to everyone.

## The Chapter's TL;DRs (faithful capture)

- "Software engineering" differs from "programming" in dimensionality: programming is about producing code. Software engineering extends that to include the maintenance of that code for its useful life span.
- There is a factor of at least 100,000 times between the life spans of short-lived code and long-lived code. It is silly to assume that the same best practices apply universally on both ends of that spectrum.
- Software is sustainable when, for the expected life span of the code, we are capable of responding to changes in dependencies, technology, or product requirements. We may choose to not change things, but we need to be capable.
- Hyrum's Law: with a sufficient number of users of an API, it does not matter what you promise in the contract: all observable behaviors of your system will be depended on by somebody.
- Every task your organization has to do repeatedly should be scalable (linear or better) in terms of human input. Policies are a wonderful tool for making process scalable.
- Process inefficiencies and other software-development tasks tend to scale up slowly. Be careful about boiled-frog problems.
- Expertise pays off particularly well when combined with economies of scale.
- "Because I said so" is a terrible reason to do things.
- Being data driven is a good start, but in reality, most decisions are based on a mix of data, assumption, precedent, and argument. It's best when objective data makes up the majority of those inputs, but it can rarely be all of them.
- Being data driven over time implies the need to change directions when the data changes (or when assumptions are dispelled). Mistakes or revised plans are inevitable.
