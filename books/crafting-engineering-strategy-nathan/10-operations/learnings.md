# Chapter 10: Operations

This chapter covers strategy operations: the art of making policies actually work after you've written them. Even the best policies fail if the teams they're intended to serve don't adopt them, and a one-time announcement probably won't persistently change a company's behavior. The single most important takeaway: a strategy without operational mechanisms "will fade quietly into your organization's history" — operations is at least as essential as any other step, yet it is often skipped. Effectively operating a policy is roughly two-thirds avoiding common practices that don't work, and one-third repetition that can be practiced in any engineering role — no need to wait until you're an executive to start building mastery. The chapter doubles as a rescue toolkit for putting an existing, floundering strategy back on track — and if you see no opportunity to write new strategy in your organization, there's still probably room to flex your operational skill.

## Core ideas

### What operational mechanisms are

Operations are how a policy is implemented and reinforced; effective operations ensure that your policies actually accomplish something. Examples: a recurring weekly meeting, an alert that fires when a threshold is exceeded, new requirements for promotions.

Policies can carry both explicit mechanisms (e.g., "exceptions approved in writing by the CTO") and implicit, undefined ones (e.g., a backfill-at-lower-level policy says nothing about *how* down-leveling is enforced). Operations is the art of picking the right mechanism for your circumstances, running it, and tweaking it as you learn. For one policy there can be several candidate mechanisms — e.g., CTO approves levels in a group chat, recruiting owns enforcement, or trust hiring managers — and choosing among them is the operational decision.

Why this matters: well-intended policy without feasible implementation produces expensive activity with little benefit (the chapter points to Jennifer Pahlka's *Recoding America* for how this plays out in government legislation).

### The six-factor rubric for evaluating mechanisms

Use a standardized rubric so you evaluate options consistently. The rubric isn't universal — customize it — but having *any* rubric beats ad hoc judgment. The six factors:

1. **Measurability** — Can you measure both leading and lagging indicators of the mechanism's impact? If forced to choose, prefer leading indicators: they allow much quicker evaluation and iteration.
2. **Adoption cost** — How much work does migrating to this mechanism require? Can it be done incrementally, or does it need a major coordinated shift?
3. **User ease (or burden)** — After adoption, is users' work easier or harder? If harder, can those users tolerate the extra effort?
4. **Provider ease (or burden)** — How much ongoing maintenance does the central/platform team take on? (If every architecture proposal needs a Security review, can Security actually support that volume?)
5. **Reliance on authority** — How much does the mechanism depend on a top-down authority's active support? If the sponsoring executive departs, does it survive? Is that tradeoff acceptable here?
6. **Cultural alignment** — Is this something the organization wants to do, or will it fight at each step? Can you reframe it to fit the culture?

The key failure mode is not the evaluation but **accepting its consequences**: people fall in love with a mechanism whose adoption cost is unbearable and try to force it through, or impose heavy user burden on a team already under tight efficiency goals. Self-awareness helps; so does consulting others willing to point out errors in your reasoning.

### Composing an operational plan

Your operational plan is the sum of the mechanisms supporting your policies. Evaluate mechanisms individually, but also consider how they work *together* — particularly the integrated ease or burden the whole plan creates for users and platform providers. The plan "is the vehicle that delivers your policies to your organization"; skipping the refinement of these details is tempting but it's a relatively quick step that can completely change your strategy's outcomes.

### The mechanism catalog (effective patterns)

Most companies have a handful of frequently used operational mechanisms — some company-specific (like Amazon's weekly business review), others that repeat across companies (like requiring executive approval). The catalog below covers the categories the author has found consistently effective.

**Approval and advice forums.** Policies are simple at a high level but ambiguous when applied to detailed, complex circumstances; forums resolve how to stay loyal to a policy's intent in edge cases. The simplest form: exceptions granted by an executive, in writing — with the rule that an unwritten exception is no exception ("If there's no written record that the CTO approved it, then it's not approved"), eliminating ambiguity about what was approved. Variants: leadership can *loan authority* to another group (e.g., an ML review channel handles exceptions instead of the CTO), and in community-minded cultures a forum's feedback can carry weight on its own merits with no senior leadership involved. The author's experience: having the right participants and a good executive sponsor matter a lot; the other details matter much less.

**Inspection.** Policies more often "sort of work" than fail outright; inspection mechanisms let you evaluate whether a policy is succeeding and where it needs adjustment. Forms include threshold-triggered alerts, folding metrics into an existing review meeting, or a script you commit to running and reviewing periodically. The cardinal rule: **an inspection mechanism cannot be allowed to fail silently** — if your mechanisms fail without triggering inspection, they accomplish nothing. Fully realizing one requires concretely specifying where and how data is tracked: a dashboard link and a committed review cadence, not just a stated metric.

**Nudges.** When teams don't follow a new policy, it's rarely deliberate — people usually *want* to do things the new way but rarely take time to learn how. A nudge provides individuals with context about a better way to do something, at exactly the moment the information is useful. The author calls nudges "the most effective operational mechanism" when done well: they require no authoritative mandate, and they focus attention only on the cases that actually need it (advise only teams that actually overspent, not every team that might). Nudges pair well with inspections (e.g., a team reviews flagged spikes monthly and reaches out where needed). Done badly, nudges become an assault on colleagues' attention. People can't follow policies they don't know exist or don't know how to follow; nudges are the most effective way to solve both problems at once, because they bring the information exactly when it would be useful. At most companies, well-done nudges are relatively uncommon — the far more common (and weaker) answer to that information gap is documentation and training.

**Documentation and training.** The author hesitates to give much advice here, not having found his own approaches effective; follow your company's standard practices even if outcomes seem imperfect. Internal knowledge bases rot quickly, and introducing yet another knowledge base is almost always an illusion of progress. The success criterion is **"informational herd immunity"**: not everyone needs to know the policy — as long as someone on each team understands it, the team can generally follow it.

**Automation.** Relying on humans to respond to new policies is slow and inconsistent in quality; automation is often the most effective and scalable rollout mechanism. But automation cannot have a positive impact as a core strategy mechanism **without an effective user experience** — if UX is a secondary concern, automation is unlikely to make much impact. Done well, automation can "get paid twice": reducing errors in the manual process while building the interface for self-service, freeing humans to give good manual support to the rare exceptions.

**Deferral to future work.** Sometimes you want a policy to address something but you have no reasonable mechanism to do it. Explicitly defer: acknowledge you can't act now, and clarify *when* you will revisit. There is no shame in deferral — explicit acknowledgment beats letting the organization keep churning on an intractable problem, and it prevents an unresolvable debate from distracting from nearer-term goals.

**Meetings.** A universal mechanism — any other mechanism can be fitted into one, and they can adequately operate almost any policy — but almost always the most expensive option available. They're easy to suggest, run, and iterate on; their adequacy at operating almost any policy is why they're frequently overused. The most common type is the reporting meeting (e.g., monthly progress in an executive weekly); the other common archetype is the weekly working meeting (covered in Chapter 13). If you can't find any other mechanism you believe in, a meeting is a decent starting point; just "try to iterate your way to canceling every recurring meeting that you start."

### Operating without executive authority

For every authority-dependent mechanism there's a related mechanism implementable with less authority: a binding architecture review becomes an architectural advice process; a mandatory pull-request review becomes a nudge. The author's experience *as an executive* is that authoritative mechanisms don't work particularly well anyway: they do a great job of technically shifting accountability to the wider organization but often change no one's behavior.

The non-executive path: focus on mechanisms available today — add nudges, study the real dynamics of how colleagues do work, build a real dataset. It's very hard to get an executive to support your initiative before you have mechanisms and data, and very easy once you do. Build confidence first; then escalate for authority only if you still need it, from a position of strength.

### Cargo-culting: the largest threat to strategy operations

Cargo-culting is recreating a process that previously solved a problem **without understanding the circumstances that made it effective**. Sometimes that's fine (you can kick a ball without understanding physics); often it's disastrous. The author observes that surprisingly few strategists seem to care whether their approaches actually work — they do something that *might* work, offload accountability to the organization, and move to the next problem, perhaps because leaders are evaluated by how they appear rather than what they accomplish. Either way, it's surprisingly difficult to know which patterns from strategy rollouts and implementations are safe to borrow. The antidote: remain **skeptically optimistic** — collect ideas widely, but force them to prove their merit in your circumstances.

## Actionable guidance

### Composing an operational plan (step sequence)

1. Review the policies you've developed. Identify which mechanisms seem most likely to support them, and pool mechanisms across policies to avoid redundancy.
2. Review mechanisms already used in your organization. Reuse those with the best track record; avoid those that left too bad an aftertaste.
3. Revisit mechanisms discovered during your exploration phase. If one fits your policies well and no familiar mechanism does, consider testing the new one.
4. Score every candidate mechanism against the six-factor rubric.
5. Consolidate into one coherent plan, paying particular attention to the *cumulative* ease or burden on users and platform providers.
6. Validate the plan with users and providers to confirm it doesn't impose an unreasonable burden or an unworkable workflow.
7. If you still can't reach agreement with stakeholders, commit to a strategy-testing process that includes the plan — building confidence before anyone is forced to commit long-term.
8. Even without formal strategy testing, schedule a review in three months to reflect on how the plan has worked out.

### Decision rules and heuristics

- Prefer leading indicators over lagging ones when instrumenting a mechanism — faster feedback means faster iteration.
- Accept the consequences of your rubric evaluation; don't force a mechanism the organization can't afford just because you like it.
- Require exceptions to be in writing; treat unwritten approvals as not granted.
- When designing approval forums, spend your effort on getting the right participants and a good executive sponsor; don't over-argue other details.
- Make approval forums concrete: specify exactly how to request approval (e.g., a named channel) and how to research prior requests and decisions.
- Design every inspection mechanism so it cannot fail silently; commit to a specific data location (dashboard link) and a specific review cadence.
- An inspection "meeting" need not be synchronous: a recurring invite committing members to independently review a dashboard and discuss surprises in a channel works.
- Choose composite success metrics that prevent gaming (e.g., progress counts only if it improves *both* security and usability, so neither lockdowns nor pure convenience register as wins).
- Keep nudges effective: limit the total number of nudges, give each an explicit action the recipient can take, and include clear instructions for taking it. Notify only when there's something new and actionable.
- Pair nudges with inspection: nudge the individual at the moment of the event; have a team periodically review the aggregate and reach out where necessary.
- For documentation and training, aim for informational herd immunity (one informed person per team), not universal knowledge. Don't introduce a new knowledge base.
- Treat user experience as primary when using automation as a core mechanism; use automation to handle the common case and reserve human effort for rare exceptions.
- When you have no viable mechanism for a goal, defer explicitly: state that you're deferring, why, and when you'll revisit (e.g., "after launching the initial release" or "kick off a working group to identify priorities").
- Use a meeting only as a fallback mechanism, and iterate toward canceling every recurring meeting you start.
- If you lack authority: substitute advice processes for binding reviews and nudges for mandates; build mechanisms and data first, escalate for executive support second.
- If you're using one of the antipattern mechanisms anyway, be able to explain why — and make sure you believe the explanation. If you don't, find a better mechanism.
- For any borrowed mechanism, verify the circumstances that made it work elsewhere hold for you before adopting it.

## Pitfalls and misconceptions

- **One-time announcements change behavior** — they don't; persistent behavior change requires ongoing mechanisms.
- **Top-down pronouncements** — declaring a policy must be followed (e.g., return-to-office mandates) doesn't drive real change; that requires motivating individuals to actually comply.
- **Education-as-announcement rollouts** — a one-time all-company training plus updated onboarding sounds great, but a couple of trainings never change a whole organization's behavior. Education can be a component, never the whole plan; real change needs ongoing reminders, visible role models, and inspections into why some teams aren't adopting.
- **Mandatory recurring trainings** — a compliance staple with two deep flaws: required attendance removes trainers' incentive to make content good, and trainees tune out expecting low quality. People trained annually on a policy for years often say they've never heard of it. Fine for shifting legal obligation, poor for changing outcomes.
- **"Just change the culture"** — cultural framing of problems is often useful, but anyone presenting culture change as simple or instant "is living in an imaginary world." Real culture change needs visible leaders role-modeling new behavior plus reinforcement mechanisms to weed out pockets of dissent.
- **Falling in love with a mechanism** despite an unbearable adoption cost or untenable user burden, then forcing the organization to accept it.
- **Skipping operational refinement** because the strategy work feels done once policies are written — this quick step can completely change outcomes.
- **Cargo-culting** — copying mechanisms that worked elsewhere without understanding why they worked; doing something that might work and moving on, rather than caring whether it actually works.
- **Authoritative mechanisms as a goal** — even for executives, they technically shift accountability without changing behavior; less authoritative alternatives often work better.
- **Metrics that can be gamed one-sided** — e.g., counting expanded access requirements as security progress even though they're likely to encourage workarounds.
