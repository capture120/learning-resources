# Chapter 03: First Principles

Clean code comes from a handful of old, well-established principles: keep everything small, name it well, organize it, and order it. These are guidelines, not laws — "more what you'd call guidelines" — applied in context to make room for coming growth, so the code grows without rotting from the inside out.

## Principles are guidelines, not laws
Apply each principle in the context of the problem at hand; take whatever license the problem requires. But when all else is equal, and all the variables are averaged out, these are the principles Martin believes emanate from well-cleaned code. Grasping them gets you 90% of the way toward cleaning code.

## Everything Small, Well Named, Organized, and Ordered
This heading alone is much of the essence of clean code. Keep everything small. Choose names that communicate to other programmers. Define and maintain a structure others can easily consume. Order elements so one concept follows another in a rational, sensible way. Your own understanding of the code biases your names and structures — work hard to put yourself in the headspace of those who do NOT understand the code.

## Functions should be small and do one thing
Most functions should be just a handful of lines. Smallness allows descriptive names, promotes separation of concerns, and ensures each function does one, and only one, thing. If a snippet of lines does something you can reasonably name, extract it into a function named for what it does. The name should be a verb, and the calling sequence should read "like well-written prose." A well-factored top-level function is short and obvious: you read it, agree with it, and move on; details are one look down, but usually you won't need them. Small things matter — even a leading minus sign that a `subtractDays` function would eliminate.

## Code grows; tidy it up first
Messy systems rarely start messy — like the chapter's example, they begin a bit unkempt and grow, feature by feature, degrading "like a piece of rotting meat." When you know business growth is coming, get ahead of it: tidy first, adding names and structure that make room for growth. The extra structure is not more executable code; it is more names and more structure, and it ensures future changes land in one small, obvious place instead of swelling a tangled function.

## The Single Responsibility Principle (SRP)
Gather together the things that are related and separate the things that are different. Different stakeholders (tax people, discount people) should each affect different functions/modules, making it not very likely that a change for one breaks the other. Ignoring SRP risks fragility: the system breaks in unexpected ways — change taxes, break discounts. Such breaks terrify stakeholders because they conclude you've lost control of the system. Stakeholders have the right to expect that a change to taxes will not break discounts.

## The Open–Closed Principle (OCP)
When you add a new feature, you should add it in one place, not many. Switch statements aren't intrinsically bad, but if the number of cases is likely to grow, they violate the OCP — a new case forces edits in every switch. Replace growing switches with data structures or polymorphism, and keep new changes out of old modules (e.g., move the catalog out of the module that uses it, so adding an item leaves that module untouched).

## The Dependency Inversion Principle (DIP)
High-level policy should not depend on low-level details — repeat that to yourself over and over. When it does, adding a low-level detail (a new catalog item) probably forces recompilation and redeployment of high-level modules (the safe bet is to assume it does) and adds cognitive burden. Invert dependencies with interfaces so the low-level details become a plug-in to the high-level policy: detail changes then never touch the policy. For small projects you may rightly skip this; for large projects (especially JavaScript shipped to browsers) the recompile/redeploy and cognitive burdens justify it.

## Architectural boundaries and Independent Deployability
A strong architectural boundary divides the system into a high-level-policy component and a low-level-details component. The rule for architectural boundaries: dependencies cross only toward the higher-level side. Components separated this way are independently deployable (separate jars; in a browser that caches the components, only the changed one re-downloads — which could be a big advantage on slow connections).

## YAGNI is a question, not a verdict
YAGNI's original intent was not "You Aren't Going to Need It" but "What if you aren't going to need it?" — a prompt to count the cost before investing in room for growth. When evidence says growth is coming, you may legitimately answer: "Yes, we are going to need it," and build the structure.

## Names grow in importance as the problem grows
When a problem is small, names can afford to be vague or inconsistent. As it grows, names keep the concepts straight in your head. Refactoring yields insight into what's really going on, and that insight should drive renames (ItemList → RentalReceipt, Statement → RentalOrder). Revisit names as your understanding deepens.

## Refactor under passing tests
Write the tests before refactoring, and keep them passing at every step. Minimize test churn by keeping tests decoupled from production code and isolating production details from test details.

## Structure has costs — pay them knowingly
Added structure adds complexity and a cognitive price; the indirection makes a casual read harder, and critics of "all those pieces" are not without a point. One mitigation: a clear directory structure becomes a road map that helps anyone understand the organization. Polymorphic dispatch is also probably slightly slower than a switch — though usually unmeasurably so. Accept these costs only when growth is expected, and accept known trade-offs explicitly: inverting dependencies costs a bit of static type safety (e.g., a String token replacing an enum), and some concerns (a too-concrete shared record) can be a "battle for another day."

## LLMs and architecture
An LLM (Grok3) reproduced the simple extract-method cleanup but did not invert dependencies or separate high-level policy from low-level detail. AIs have their uses, but they are not adept at understanding higher architectural goals — that judgment remains the programmer's job.

## In practice
- Keep functions a handful of lines; extract any nameable snippet into a verb-named function.
- Write top-level functions that read like prose; push detail down a level.
- Imagine the reader who doesn't understand the code; name and structure for them, not for yourself.
- Group code by stakeholder concern (SRP), so a tax change is unlikely to break a discount.
- When a switch's cases will grow, replace it with data or polymorphism (OCP), and move the growing part out of stable modules.
- Check dependency direction: nothing in high-level policy may depend on low-level detail (DIP); details plug in across an architectural boundary.
- Before adding structure for growth, ask YAGNI's real question — count the cost — and add it only when growth is genuinely expected.
- Rename things as refactoring reveals what they really are.
- Have passing tests before refactoring; keep them green at every step.
- Acknowledge the cognitive and (tiny) performance cost of structure; don't pretend it's free.
