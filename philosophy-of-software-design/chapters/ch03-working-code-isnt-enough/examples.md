# Chapter 3 Examples: Working Code Isn't Enough

## The tactical death spiral (composite scenario)

**Design problem:** You're under a hard deadline and need to finish a feature or bug fix fast.

**Bad approach (tactical):** You skip looking for the best design and accept "a bit of complexity or a small kludge or two" to finish sooner. Each task contributes a few such complexities, each of which seems like a reasonable compromise in isolation. Before long the early shortcuts start causing problems — but refactoring would slow the current task, so you reach for quick patches to work around them. Each patch adds complexity that requires more patches. Eventually the code is a mess that would take months to clean up; no schedule can tolerate that delay, and fixing only one or two problems wouldn't seem to make a difference, so everyone keeps programming tactically.

**Good approach (strategic):** Refuse the kludge in the first place; when a design problem surfaces, take a little extra time to fix it rather than patch around it.

**Lesson:** Complexity is incremental (Chapter 2's point), so the tactical mindset — not any single bad decision — is what makes systems complicated. Once you start down the tactical path, it's difficult to change.

## The tactical tornado

**Context:** Almost every development organization has at least one developer who takes tactical programming to the extreme — Ousterhout names this archetype the *tactical tornado*.

**The pattern:** The tornado is a prolific programmer who pumps out code far faster than anyone else and gets quick features done faster than anybody. Some managements treat tactical tornadoes as heroes.

**The reality:** They leave behind a wake of destruction. The engineers who must later work with the tornado's code rarely consider them heroes. Typically other engineers clean up the tornado's messes, which ironically makes those engineers — the real heroes — appear to make slower progress than the tornado.

**Lesson:** Raw output speed is a misleading productivity signal; measuring it rewards tactical programming and punishes the people absorbing its cost. Demonstrates why "working code isn't enough" must be an organizational value, not just an individual one.

## Figure 3.1: the strategic vs. tactical progress curves

**The illustration:** A graph of total progress over time. The tactical curve rises faster at first, then flattens as accumulated complexity drags productivity down. The strategic curve starts slower (because of design investment) but stays nearly linear, crossing above the tactical curve over time.

**The quantitative claim:** Invest about 10–20% of development time in design. Initial projects take 10–20% longer, but benefits appear within a few months; soon you develop at least 10–20% faster than you would tactically, at which point past investments fund future ones and investment becomes free. Conversely, tactical programming finishes the first projects 10–20% faster, but development soon slows by at least 10–20%, giving back all early gains, and you develop more slowly for the rest of the system's lifetime. Anyone who has worked in a badly degraded code base will confirm that poor quality slows development by at least 20%.

**The crossover question:** Where do the curves cross — how long until strategy pays for itself? Ousterhout has no data and notes a controlled experiment would be hard; his personal opinion is 6–18 months. The mechanism is memory: after a few months developers have forgotten most of what was in their minds when writing the code, so complex code becomes expensive to work with, quickly erasing tactical gains. He explicitly flags both the figure and the estimate as qualitative/opinion, not measurement.

**Lesson:** Design investment is an economic argument, not an aesthetic one — strategy wins on total progress, and the payback arrives sooner than most schedules assume.

## Technical debt as a financial analogy

**The analogy:** Tactical programming borrows time from the future — development goes faster now and slower later. As with financial debt, you repay more than you borrowed.

**Where the analogy breaks:** Unlike financial debt, most technical debt is never fully repaid; you keep paying and paying forever.

**Lesson:** Frames why avoiding the debt beats planning to repay it — repayment rarely happens.

## Startups and the "clean it up later" rationalization

**Design problem:** Early-stage startups feel tremendous pressure to ship early releases fast; even a 10–20% investment can seem unaffordable.

**Bad approach:** Many startups go fully tactical — little effort on design, even less on cleanup — rationalizing that if they succeed they'll have money to hire extra engineers to clean things up.

**Why it fails, three ways:**
1. Once a code base turns to spaghetti it is nearly impossible to fix; you'll likely pay high development costs for the life of the product.
2. The payoff for good (or bad) design arrives quickly, so the tactical approach probably won't even speed up the first release.
3. Hiring: company success depends heavily on engineer quality, and the best way to lower development costs is hiring great engineers — they cost little more than mediocre ones but are tremendously more productive. Great engineers care deeply about good design; if your code base is a wreck, word gets out, recruiting suffers, you end up with mediocre engineers, costs rise, and the structure degrades further.

**Lesson:** The forces pushing startups tactical are real, but the rationalization fails on its own economic terms — even the short-term speedup is doubtful.

## Facebook: "Move fast and break things"

**Context:** A real startup that explicitly encouraged tactical programming. For years the motto was "Move fast and break things." New engineers fresh out of college dove straight into the code base; pushing commits to production in your first week was normal.

**Upside:** Facebook earned a reputation for empowering employees — engineers had tremendous latitude and few rules in their way.

**Downside:** The code base suffered: much of the code was unstable, hard to understand, with few comments or tests, and painful to work with. The company eventually recognized the culture as unsustainable and changed its motto to "Move fast with solid infrastructure" to push engineers toward design investment. Whether it can clean up years of accumulated tactical damage remains to be seen.

**Fairness note:** Ousterhout points out Facebook's code probably wasn't much worse than the startup average; tactical programming is commonplace among startups — Facebook is just a visible example. And Facebook succeeded spectacularly as a company despite the approach.

**Lesson:** Tactical culture scales its damage with the company; even a wildly successful company eventually had to reverse course, and the accumulated debt may never be fully repaid.

## Google and VMware: strategic counterexamples

**Context:** Both companies grew up around the same time as Facebook but embraced a more strategic approach.

**The approach:** Heavy emphasis on high-quality code and good design; both built sophisticated products solving complex problems with reliable software systems.

**The payoff:** Their strong technical cultures became well known in Silicon Valley, and few other companies could compete with them for hiring top technical talent — directly illustrating the recruiting feedback loop from the startup section.

**Lesson:** A company can succeed with either approach — but the strategic approach is compatible with startup success, yields reliable systems, wins the talent competition, and (Ousterhout's closing point) "it's a lot more fun to work in a company that cares about software design and has a clean code base."

## The crunch-time slippery slope

**Scenario (from the conclusion):** During a crunch it is tempting to put off design cleanups until the crunch is over.

**Why it fails:** After this crunch there will almost certainly be another, and another after that. Once you start delaying design improvements, the delays easily become permanent and the culture slips into the tactical approach. The longer you wait, the bigger the design problems become and the more intimidating the solutions, which makes them even easier to put off — a self-reinforcing loop.

**Good approach:** Treat investment as something to do today, not tomorrow; the most effective model is every engineer making continuous small investments in good design.

**Lesson:** Consistency is the load-bearing property of strategic programming; a "temporary" exception is the mechanism by which cultures go tactical.
