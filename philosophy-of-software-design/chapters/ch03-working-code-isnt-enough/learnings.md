# Chapter 3: Working Code Isn't Enough (Strategic vs. Tactical Programming)

## Central idea

Good design comes from the mindset you bring to every programming task, not from any single technique. The tactical mindset ("just get it working fast") makes good system design nearly impossible because complexity accumulates one small kludge at a time. The strategic mindset treats great design — not merely working code — as the primary goal, and it is cheaper than the tactical approach over the long run.

## Key concepts

**Tactical programming.** The default mindset: most programmers approach development this way, and many organizations actively encourage it. The main focus is getting something working — a feature, a bug fix — as quickly as possible. At first glance this seems totally reasonable (what could be more important than writing code that works?), which is exactly what makes it seductive. But it is short-sighted by construction: planning for the future is not a priority, you implement the first idea that comes to mind, and you accept "a bit of complexity or a small kludge or two" to finish faster. Each compromise seems reasonable in isolation; the damage comes from accumulation. Soon shortcuts cause problems, but refactoring would slow the current task, so you patch around problems instead — which creates more complexity, requiring more patches. Eventually the code is a mess that would take months to clean up; no schedule tolerates that, and fixing one or two problems wouldn't seem to matter, so tactical programming continues. Once you start down the tactical path, it is difficult to change.

**Tactical tornado.** A prolific programmer who pumps out code far faster than anyone else, working in a totally tactical fashion. Management often treats tactical tornadoes as heroes, but they leave a wake of destruction. Other engineers must clean up their messes, which makes those engineers — the real heroes — appear slower than the tornado.

**Strategic programming.** Starts from the realization that **working code isn't enough**. Introducing unnecessary complexity to finish a task faster is not acceptable. The most important thing is the long-term structure of the system: most code in any system is written by extending the existing code base, so your most important job is to facilitate those future extensions. Your code must work, but working code is a side effect; the primary goal is a great design that also happens to work.

**The investment mindset.** Strategic programming means continually investing time to improve the system's design rather than taking the fastest path through the current task. Investments slow you down slightly in the short term and speed you up in the long term. Two kinds:

- *Proactive investments:* spend extra time finding a simple design for each new class — try a couple of alternative designs and pick the cleanest rather than implementing the first idea; imagine a few ways the system might change in the future and make sure your design makes them easy; write good documentation.
- *Reactive investments:* no matter how much you invest up front, design mistakes are inevitable and become obvious over time. When you discover a design problem, don't ignore it or patch around it — take a little extra time to fix it. Strategic programming means continually making small design improvements; tactical programming means continually adding small bits of complexity.

**Technical debt.** Programming tactically borrows time from the future: development goes faster now, slower later. As with financial debt, you pay back more than you borrowed. Unlike financial debt, most technical debt is never fully repaid — you keep paying forever.

## Actionable principles

- Treat great design as the primary goal of every task; treat "it works" as a necessary but insufficient bar. Reject changes that add unnecessary complexity even when they finish the task faster.
- Before implementing a new class or module, sketch a couple of alternative designs and pick the cleanest, because the first idea that comes to mind is rarely the simplest.
- Imagine a few plausible future changes and check that your design accommodates them easily.
- When you discover a design flaw in existing code, fix it now rather than patching around it, because patches compound: each one adds complexity that demands more patches.
- Spend roughly 10–20% of total development time on design investments. This is small enough not to wreck schedules but large enough to compound: projects initially take 10–20% longer, benefits arrive within a few months, and soon you develop at least 10–20% faster than you would tactically — at which point past investments pay for future ones and the investment is effectively free. The converse also holds: tactical programming finishes the first projects 10–20% faster, but development soon slows by at least 10–20%, quickly giving back all the time saved, and you develop more slowly for the rest of the system's lifetime.
- Do NOT make a huge up-front investment in designing the entire system. That is the waterfall method, and it doesn't work; the ideal design emerges in bits and pieces as you gain experience with the system. Make lots of small investments continually instead.
- Invest today, not tomorrow. In a crunch it is tempting to defer cleanups until afterward, but there will almost certainly be another crunch after this one. Deferred design improvements easily become permanent and the culture slips tactical. The longer you wait, the bigger the problems and the more intimidating the fixes, making them even easier to put off.
- Apply the strategic approach consistently — every engineer making continuous small investments is the most effective model. A single tactically-minded contributor (or one "exception" task) leaks complexity into the system.
- Expect the payback period for strategic programming to be roughly 6–18 months (Ousterhout's opinion; he notes there is no empirical data). The mechanism is developer memory: after a few months you've forgotten what was in your mind when you wrote the code, so complex code slows you down dramatically, quickly erasing tactical gains.
- In a startup under release pressure, resist the rationalization "we'll hire engineers to clean it up once we succeed." Once a code base turns to spaghetti it is nearly impossible to fix, and you'll pay high development costs for the life of the product. The payoff for good design comes quickly enough that the tactical approach may not even speed up the first release.
- Weigh the hiring effect: the best engineers care deeply about good design and are vastly more productive without costing much more. A wrecked code base becomes known, hurts recruiting, leaves you with mediocre engineers, and degrades the structure further — a reinforcing loop.

## Nuances and counterpoints

- Ousterhout is candid about the limits of his evidence: Figure 3.1 (tactical progress starts faster, strategic overtakes it as complexity slows the tactical curve) is a qualitative illustration only — he knows of no empirical measurements of the curves, and the 6–18 month payback estimate is personal opinion without data.
- Both approaches can produce successful companies: Facebook succeeded spectacularly while tactical; Google and VMware succeeded while strategic. The argument for strategy is about long-term development cost, code quality, recruiting, and the fact that "it's a lot more fun to work in a company that cares about software design and has a clean code base" — not that tactical companies must fail.
- He is fair to Facebook: its code probably wasn't much worse than the startup average; tactical programming is commonplace among startups, Facebook is just a visible example.
- The overcorrection warning runs the other way too: don't swing from tactical to waterfall. Designing everything up front fails because design knowledge only emerges through experience with the system. The right shape is many small continual investments, not one big one.
- Anyone who has worked in a badly degraded code base will report that poor code quality slows development by at least 20% — use this as the baseline cost when arguing for investment.

## Red flags

This chapter has no boxed red flags, but it teaches these warning signs:

- **"It's OK to add a small kludge or two"** — the rationalization that starts complexity accumulation; each compromise seems reasonable, the aggregate is fatal.
- **Patching around problems instead of fixing them** — quick workarounds that add complexity, which then requires more patches.
- **"It's more important to ship the next feature than to refactor"** — the recurring excuse that makes tactical debt permanent.
- **The tactical tornado** — a developer celebrated for raw speed whose code others must constantly clean up; management treating them as a hero is an organizational red flag.
- **Deferring cleanups until "after the crunch"** — a slippery slope; another crunch always follows and the delays become permanent.
- **"We'll clean it up after we're successful / when we hire more engineers"** — the startup rationalization; spaghetti is nearly impossible to fix after the fact.
- **Implementing the first design that comes to mind** without considering alternatives.
