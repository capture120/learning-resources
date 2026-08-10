# Chapter 1 Examples: What Is Software Engineering?

Every substantive example, case study, and anecdote from Chapter 1 of "Software Engineering at Google," retold so a reader who never opens the book fully understands each one.

## The Life Span Spectrum: A One-Off Python Script vs. Google Search

**Setup.** The chapter frames "expected life span" — how long code will continue to be built, executed, and maintained — as the key variable separating programming from software engineering. Reasonable life spans vary by a factor of about 100,000: from minutes to decades. Figure 1-1 in the book contrasts two projects at opposite ends of this spectrum.

**What happens.** Imagine you're writing a Python script that will run exactly once, and a new version of your operating system ships mid-task. Should you stop and upgrade? Obviously not — the upgrade is irrelevant to code that dies in an hour. Now imagine the opposite extreme: Google Search still running on an operating system from the 1990s. That would be a clear and serious problem. Somewhere between these poles a transition occurs where a project must begin reacting to changing externalities (new OS versions, new language versions, changed dependencies). The book's footnote estimates this transition generally falls somewhere between 5 and 10 years of expected life.

**Lesson.** Whether an upgrade matters depends entirely on expected life span. Short-lived code is "just" a programming problem, the way a cube squashed flat enough is a square. Long-lived code must plan for change from the start, because projects that never planned for upgrades face a first upgrade that is painful for three compounding reasons: hidden assumptions have accumulated, the engineers have never done this kind of task, and the upgrade batches many years of change at once.

## Novice Programmers, Startup Engineers, and Mobile Apps (Short-Lived Code in the Wild)

**Setup.** The chapter surveys who actually writes short-lived code.

**What happens.** Students write programs measured in hours or days — assignments are write-once, never refactored, often never run again. In industry, mobile apps often have short life spans and full rewrites are common. Early-stage startup engineers rationally prioritize immediate goals over long-term infrastructure: the company may not live long enough to reap a slow-payoff investment. A serial startup developer can accumulate 10 years of experience while never maintaining software expected to last more than a year or two.

**Lesson.** Short-life-span development is a legitimate and common mode, not a failure. But it means many experienced developers have never faced the problems that define software engineering, and the practices they learned don't transfer automatically to decades-long projects.

## Hash Ordering (the canonical Hyrum's Law example)

**Setup.** Hyrum's Law states: with a sufficient number of users of an API, it does not matter what you promise in the contract — all observable behaviors of your system will be depended on by somebody. The book illustrates with hash iteration ordering. A hash-based set is a container that stores elements in an order determined by internal hashing, not insertion order. Insert five fruits into a Python set and print them, and you get some scrambled order like durian, carrot, apple, eggplant, banana.

**What happens.** Most programmers know hash containers are "non-obviously ordered," but few know whether their specific hash table promises that specific order forever. Industry experience has since evolved: hash-flooding attacks (a denial-of-service attack where an attacker who knows the hash function crafts inputs that degrade the table's performance) created an incentive for *nondeterministic* iteration order, and research into better hash algorithms requires the freedom to change iteration order. Meanwhile, per Hyrum's Law, programmers *will* write code that depends on the traversal order if they can observe it. Even if your own code doesn't depend on the order, dependence can leak transitively: if your library serializes values into a Remote Procedure Call (RPC) response, the remote caller may end up depending on the order of those values. Some languages fought back by randomizing hash order between library versions or even between runs of the same program — and Hyrum's Law struck again: some code began using the randomized hash ordering as a cheap random-number generator, so *removing* the randomness would now break those users.

**Lesson.** "It works" and "it is correct" are different claims. Depending on iteration order is fine for a short-lived program and a genuine risk for a long-lived one, because given enough time something (efficiency, security, future-proofing) will make changing that order valuable, and every observable behavior — even deliberately injected randomness — will have accumulated dependents. Hyrum's Law is like entropy: you cannot eradicate it, only plan for and mitigate it.

## Heartbleed, Meltdown, and Spectre (Why "Nothing Changes" Fails on Security)

**Setup.** One might hope to avoid the whole problem of change by freezing everything. The chapter tests that hope against real security history. Heartbleed was a critical 2014 vulnerability in the OpenSSL networking library; Meltdown and Spectre were 2018 vulnerabilities arising from speculative execution in CPUs themselves.

**What happens.** Security problems get disclosed in every layer of technology — processors, networking libraries, application code. Each dependency carries some risk of containing a critical bug that only comes to light after you already rely on it.

**Lesson.** If you have assumed or promised that nothing will ever change, you are incapable of deploying a patch for the next Heartbleed or mitigating the next Meltdown/Spectre. That is a significant gamble, not a strategy. Sustainability means retaining the capability to change even if you rarely exercise it.

## Linked Lists and Binary Search Trees on Modern Hardware (Why "Nothing Changes" Fails on Efficiency)

**Setup.** Google wants cost-effective datacenter hardware, especially CPU efficiency. Early-Google-era algorithms and data structures were designed against the hardware realities of their day.

**What happens.** A linked list or a binary search tree still *works* fine, but the ever-widening gap between CPU speed and memory latency changed what "efficient" code looks like (structures that chase pointers through scattered memory now waste most of their time waiting on memory). Buying newer hardware yields diminished returns unless the software's design changes with it. Crucially, the original design was perfectly reasonable at the time — no mistakes were made; the passage of time alone made change valuable.

**Lesson.** Backward compatibility keeps old systems functioning but doesn't keep old optimizations helpful. Long-lived projects must be able to exploit efficiency opportunities that emerge from an evolving hardware landscape, or pay large ongoing costs. The chapter adds the sysadmin analogy: knowing in theory you can restore from tape backup is very different from knowing in practice exactly how to do it and what it costs — practice and expertise drive efficiency and reliability.

## The "Delete the Old Widget by August 15th" Deprecation (a Policy That Doesn't Scale)

**Setup.** Deprecation is the process of retiring an old system in favor of a new one. The traditional approach: a team builds a new Widget, decides everyone should switch, and announces "We'll delete the old Widget on August 15th; make sure you've converted."

**What happens.** This works in a small organization but fails as the dependency graph grows in depth and breadth. Teams depend on ever more Widgets, and a single build break affects a growing percentage of the company. The migration work lands on every customer team, each of which must ramp up on a problem they've never seen.

**Lesson.** Pushing migration work to customers scales badly. The scalable alternative is for the owning team to internalize the migration work — which led Google to the Churn Rule (see next example).

## The Churn Rule (a Policy That Scales)

**Setup.** In 2012, Google adopted a rule to stop the constant migration churn that infrastructure changes imposed on user teams.

**What happens.** The Churn Rule: infrastructure teams must either move their internal users to new versions themselves or perform the update in place in a backward-compatible fashion. Dependent projects no longer spend progressively more effort just keeping up. Google also learned that a dedicated group of experts executing a change scales better than demanding maintenance effort from every user: experts learn the whole problem deeply once and apply that expertise to every subproblem, while forced users each ramp up badly, solve only their immediate case, and then throw the knowledge away.

**Lesson.** Expertise combined with economies of scale beats distributed burden. Make the team that causes churn absorb its cost.

## Development Branches (Another Policy That Doesn't Scale)

**Setup.** An organization notices that merging large features into trunk (the main shared line of development) destabilizes the product, and concludes it needs tighter merge controls and less frequent merges. Every team or feature gets its own long-lived development branch.

**What happens.** Whenever a branch is declared "complete," it is tested and merged into trunk — which triggers expensive resyncing and retesting work for every other team still on its own dev branch. Juggling 5 to 10 branches is manageable for a small organization. As the organization and the branch count grow, the overhead of doing the same task keeps increasing.

**Lesson.** A control that felt prudent at small scale imposes superlinear costs at large scale. (The book resolves this in its version-control chapter with trunk-based development.)

## The Beyoncé Rule (a Policy That Scales)

**Setup.** Infrastructure teams need to make changes safely without personally verifying every possibly-affected product in the company.

**What happens.** Google's internal policy: "If a product experiences outages or other problems as a result of infrastructure changes, but the issue wasn't surfaced by tests in our Continuous Integration (CI) system, it is not the fault of the infrastructure change." Colloquially: "If you liked it, you should have put a CI test on it" — the Beyoncé Rule, named after the refrain "if you liked it then you shoulda put a ring on it" from the song "Single Ladies." Complicated one-off bespoke tests that the common CI system doesn't trigger do not count. Without this rule, an infrastructure engineer would have to track down every team with affected code and ask how to run their tests — feasible with a hundred engineers, impossible at Google's size.

**Lesson.** A single clear liability rule converts an unscalable human coordination problem into an automated, scalable one, and protects infrastructure teams' ability to keep systems current.

## The Friendly Java Expert (Knowledge Is Viral)

**Setup.** The chapter asks what scales *better* than linearly as an organization grows.

**What happens.** With a hundred engineers writing Java, a single friendly expert willing to answer questions in shared forums soon produces a hundred engineers writing better Java code. Knowledge spreads through discussion; new experts grow.

**Lesson.** "Knowledge is viral, experts are carriers." Shared communication forums and cultivated expertise deliver superlinear value as an organization scales, by clearing common stumbling blocks for everyone at once.

## The 2006 Compiler Upgrade (Case Study in Upgrade Pain and Recovery)

**Setup.** A compiler translates source code into executable programs; upgrading one should theoretically be cheap because languages work hard at backward compatibility. In practice a compiler upgrade almost always changes behavior subtly: miscompilation fixes, optimization tweaks, changes to previously undefined behavior. In 2006 Google had several thousand engineers and hadn't updated its compiler in about five years. Most engineers had never experienced a compiler change; most code had only ever seen one compiler version.

**What happens.** The upgrade fell to a team of mostly volunteers and became a hunt for shortcuts and workarounds for upstream compiler and language changes nobody knew how to adopt (concretely: C++ standard library interfaces now had to be referenced in namespace std, and an optimization change to std::string turned out to be a significant *pessimization* for Google's usage, requiring extra workarounds). Years of accumulated Hyrum's Law problems — implicit dependencies on the old compiler's observable behavior — made the migration extremely painful. There was no Beyoncé Rule and no pervasive CI system yet, so the team couldn't know the impact ahead of time and risked being blamed for regressions.

**What happened after.** The unusual part is not the pain — many companies have a similar story — but the response. Google recognized the pain and invested in turning scale into an advantage via automation (one human can do more), consolidation and consistency (low-level changes have limited problem scope), and expertise (a few humans can do more). Five factors of codebase flexibility emerged: expertise (hundreds of compiler upgrades done since), stability (smaller deltas because releases are adopted regularly, for some languages every week or two), conformity (little code that hasn't been through an upgrade), familiarity (routine reveals what to automate, echoing the Site Reliability Engineering idea of eliminating toil), and policy (the Beyoncé Rule means only CI-visible usage matters). Code that survives an upgrade becomes less brittle: it stops depending on implementation nuances and starts depending on the guaranteed abstraction.

**Lesson.** The first upgrade is always the most expensive. Once a recurring task is recognized as necessary, engineer things so it can be done with a constant number of engineers even as the codebase grows. The counterfactual: had Google decided upgrades were too expensive, it might still be on a 2006 compiler — paying perhaps 25% extra compute from missed optimizations and running infrastructure that a 2006-era compiler cannot help protect against speculative-execution attacks. Stagnation is an option, but rarely a wise one.

## Shift Left on Security (the Workflow Timeline)

**Setup.** Picture a feature's developer workflow as a timeline from left to right: conception, design, implementation, review, testing, commit, canary (a limited production trial), production deployment. The term "shift left" originated in security arguments that security review must not be deferred to the end.

**What happens.** A security problem discovered in production is very expensive. Caught before deployment, it still costs work but much less. Caught before the developer even commits the flaw, it is cheapest of all: the developer still has the feature loaded in their head, and revising to meet security constraints directly is far cheaper than committing the flaw and forcing someone else to triage and fix it later.

**Lesson.** Detecting problems earlier in the workflow reduces cost, generally — the same pattern holds for bugs caught by static analysis and code review versus bugs that reach production. No single tool needs to be perfect; use defense in depth and catch as much as possible on the left side of the timeline.

## Whiteboard Markers (an Explicit Trade-Off on a Trivial Good)

**Setup.** In many organizations, whiteboard markers are treated as precious goods: tightly controlled, always in short supply, and half of the ones at any whiteboard are dry. Meetings get disrupted and trains of thought derailed over a product that costs less than a dollar.

**What happens.** Google instead keeps unlocked closets full of office supplies, including markers, in most work areas. Anyone can grab dozens in assorted colors at a moment's notice.

**Lesson.** Google made an explicit trade-off: obstacle-free brainstorming matters far more than protecting against someone walking off with markers. The point is not the markers — it is that *every* decision, from office supplies to global-scale service provisioning, deserves the same eyes-open, explicit weighing of costs and benefits. Personnel cost (engineer focus and flow) usually dominates financial cost in software organizations.

## The Linked-List Optimization Question (Using a Cost Conversion Table)

**Setup.** For trade-offs where every quantity is measurable, the chapter recommends organizations publish a conversion table: this many CPUs cost the same as this much RAM or this much network bandwidth (exact dollar amounts optional).

**What happens.** With the table in hand, any engineer can self-serve an analysis such as: "If I spend two weeks changing this linked list into a higher-performance structure, I will use five gibibytes more production RAM but save two thousand CPUs. Should I do it?" The answer depends on the RAM-versus-CPU exchange rate, plus personnel cost (two weeks of an engineer) and opportunity cost (what else those two weeks could have produced).

**Lesson.** There is no excuse for being bad at decisions where everything is measurable. Distributing cost data lets every engineer make informed trade-offs without escalation.

## Distributed Builds and Jevons Paradox (Case Study in Unforeseen Costs)

**Setup.** A build is the process of compiling source code into runnable software. Per the book's informal Twitter polling, roughly 60-70% of developers build locally on their own machines despite today's large, complicated builds — hence the famous "Compiling!" excuse for idle time. In the mid-2000s Google built everything locally; some engineers had machines massive enough to build Google Maps on their desktops.

**What happens.** As the codebase grew, compile times ballooned. Google paid rising personnel costs (engineers waiting) and resource costs (ever-more-powerful desktops that sat idle most of the day). So Google built a distributed build system — one that farms compilation out to shared datacenter machines. It cost engineer-time to develop, more time to migrate everyone's habits, and additional compute. The savings clearly outweighed those costs: builds got faster, engineer-time was recouped, and hardware investment shifted to managed shared infrastructure (actually a subset of the production fleet) instead of desktops.

**The twist.** That was not the happy ending. Over time the distributed builds themselves bloated. Previously, each engineer felt the pain of a slow local build and had a vested interest in keeping dependencies lean. The distributed system hid that pain, and bloated or unnecessary dependencies in the build graph became rampant — nobody was incentivized to watch build bloat anymore. The book likens this to Jevons Paradox, the economic observation that consumption of a resource may *increase* when its use becomes more efficient. Google then had to reconceptualize the system's goals, identify best practices (small dependencies, machine-managed dependencies), and fund tooling and maintenance for the new ecosystem.

**Lesson.** The trade-off was still hugely net-positive, but even a simple "spend money on compute to recoup engineer time" decision had unforeseen downstream effects. Efficiency gains change incentives; expect second-order costs and revisit decisions as new data arrives.

## Fork or Depend? (Time and Scale in Direct Conflict)

**Setup.** Usually the themes of time and scale reinforce each other (an OS interface change requires many small refactorings, but they scale well because they all have similar form). They conflict most sharply in one recurring question: should you add a dependency on existing utility code, or fork/reimplement it for your own needs? This arises at every level of the stack — microservices, in-memory caches, compression routines.

**What happens.** A bespoke fork customized to your narrow problem can outperform the general solution, makes adding features easier, and isolates you from upstream changes: no other team or third party dictates when you must react. But if every developer forks everything, sustainability collapses at scale — responding to a security flaw in a library stops being "update one dependency" and becomes "find every vulnerable fork and every user of every fork."

**Lesson.** No one-size-fits-all answer. Forks are less risky for short-lived projects and for provably scope-limited code. Never fork things that operate across time or project boundaries: data structures, serialization formats, networking protocols. Consistency has great value, but generality has costs — doing your own thing can win if done carefully.
