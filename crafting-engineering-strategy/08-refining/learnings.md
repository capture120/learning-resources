# Chapter 8: Refining

This chapter introduces strategy refinement: a toolkit of cheap methods for identifying the narrow problems within a strategy that matter most, and validating your solutions to them before fully committing. Larson frames it with Jim Collins and Morten Hansen's "Fire Bullets, Then Cannonballs" concept from *Great by Choice*: an organization can only afford a small number of cannonballs (big committed bets) but can bankroll far more bullets (cheap tests), so use bullets to derisk your cannonballs' trajectories. The single most important takeaway: **refinement is, in Larson's experience, "the kernel of effective strategy"** — the highest-impact step of strategy creation — yet it is routinely skipped, often for incentive reasons rather than rational ones, and skipping it can turn moderately hard problems into strategy failures.

## Core ideas

### What strategy refinement is

Most strategies succeed because they properly address *narrow* problems within a broader strategy. You could validate a strategy by fully implementing it, but that is typically inefficient, slow, and distracting — you get lost in miscellaneous details and lose sight of the levers that actually make the strategy impactful. Strategy refinement is a toolkit of methods to (1) identify those narrow problems that matter most and (2) validate that your solutions to them will be effective.

The right tool varies by strategy:
- Wardley mapping to understand how the ecosystem's evolution will impact your approach.
- Systems modeling to determine which part of a problem (e.g., a migration) is the most valuable lever.
- Strategy testing — slowing down commitment until a narrow test drive derisks the pieces you don't yet have conviction in.

There are always new refinement tools to pick up; the book covers these three in detail, surveys a handful of other techniques more common to strategy consultants, and provides a foundation for developing your own.

### Why refinement matters

Failure to refine can turn a moderately challenging problem into a strategy failure; focus on refinement can translate extremely difficult problems into successes. A common failure shape: the diagnosis identifies a real, apt problem, but the chosen solution "solved the easiest part of the problem, without addressing the messier parts," and consequently fails to make meaningful progress. This happens surprisingly often and "can be largely avoided with a small dose of refinement." Conversely, a team with *no* authority to mandate anything can still drive an org-wide strategy purely through refinement, using cheap models and incremental tests to focus iterative effort.

### Why refinement gets skipped despite mattering (the incentives diagnosis)

- **Low-altitude strategy (small teams) almost always gets refined — but not out of belief.** Small teams lack the authority to force alignment, so they *must* incrementally prove out their approach until other teams or executives believe it's worth aligning with. Refinement is forced by powerlessness.
- **High-altitude strategy (executives) routinely skips refinement** even when refinement is inexpensive and almost guaranteed to improve outcomes. New executives know early impressions matter, and know that "sounding ambitious often resonates more loudly than doing good work." So they kick off aspirational initiatives (e.g., a massive codebase overhaul) to establish a reputation, deferring effectiveness.
- **Promotion incentives create the same failure below the executive level.** Permissive-strategy organizations that require an ambitious, high-leverage project for promotion into senior engineering roles produce novel projects (a new networking or authorization approach) whose adoption stalls after the easy proof points — but in many cases the promotion lands before the rollout stalls, so the engineer is disincentivized from asking whether it was net-positive. Fixing the rubric is a genuine tradeoff for executives: an org that innovates too much while empowering individuals versus an org with little waste but restricted creativity.
- **Forced urgent commitment.** Sometimes your boss forces you to commit to a strategy immediately. This doesn't actually prevent refinement — "just say you're committed and refine anyway" — but often the interaction tricks the strategist into thinking they can't change an approach they've committed to. "This is never true; all decisions are up for review with proper evidence," but refining while people demand weekly completion updates takes courage.
- **Missing toolkit.** Many people have never built a refinement toolkit and have never worked with anyone who has one, so refinement isn't an available move for them.

### Building your toolkit

Few people are proficient with many refinement tools, but unlocking your *first* tool is extraordinarily powerful, and it's worthwhile to slowly expand over time. All tools are flawed; each is best at illuminating certain types of problems. Expertise comes from trying one tool against many different problems and talking through results with engaged peers.

Critical communication rule: **share what you learn from the techniques, not the techniques themselves.** Larson has seen these techniques meaningfully change strategies, but has "never seen those changes successfully justified through the inherent insight of the refinement techniques themselves." The model or map convinces *you*; the learnings convince *others*.

### Strategy testing (when the problem is ambiguous)

Use when the problem is ambiguous or the diagnosis is difficult because the issues blocking progress are poorly understood (e.g., "improve code quality" — hard to agree on what it is, equally hard to agree on concrete steps). Spend little time on the right initial solution; spend most of your time on the testing loop:

1. Identify the narrowest, deepest available slice of your strategy. Iterate on applying that slice until you see some evidence it's working.
2. As you iterate, identify metrics that help you verify the approach is working.
3. Operate from the belief that people are well-meaning, and strategy failures are due to excess friction and poor ergonomics.
4. Keep refining until you have conviction that your strategy's details work in practice, or that the strategy needs to be approached from a new direction.

A legitimate outcome is ending the initiative early without a large organizational commitment. In Larson's experience, that isn't failure: "having a problem doesn't mean you have an elegant solution," and strategy testing validates whether the solution's efficiency and ergonomics are viable before you commit.

**Route to it when:** the problem is deeply ambiguous and there's no agreement on the nature of the reality you're operating in.

### Systems modeling (when you can't find the lever)

Use when you generally understand a problem but are unsure where the leverage points are in a complex system; modeling cheaply determines which levers might be effective. You can reach the same insights without modeling, but modeling "tends to make the insights immediately visible." Bonus property: when the model *doesn't* immediately illuminate what matters, studying where the model's projections conflict with real-world data shows you where your assumptions are contorting your understanding of the problem.

**Route to it when:** you understand the problem but need to determine where to focus efforts for the largest impact.

### Wardley mapping (when the ecosystem is moving)

Many engineering strategies implicitly assume the ecosystem they operate in is static — which is certainly false. Experienced engineers with great judgment still deploy flawed strategies because they've anchored on their *memory* of how things work rather than noticing how things have changed over time. Wardley maps let you plot users and their needs, then study how the solutions to those needs will shift over time, so changes inform your strategy instead of hitting you over the head.

**Route to it when:** your strategy involves adopting a highly dynamic technology (e.g., observability in the 2010s, LLMs today), or is intended to span five-plus years.

## Actionable guidance

- Fire bullets before cannonballs: cheaply test the uncertain parts of a strategy before making the large commitment. Reserve full commitment for approaches whose narrow critical pieces you've already validated.
- Don't validate strategy by full implementation. Identify the narrow problems that determine success and validate just those.
- Match the tool to the problem:
  - Ambiguous problem, no agreed-on reality → strategy testing.
  - Understood problem, unknown leverage point → systems modeling.
  - Dynamic ecosystem or 5+ year horizon → Wardley mapping.
- If all tools are unfamiliar, skim them all and pick the one most applicable to a problem you're working on *right now*. Build expertise by applying one tool to many problems and discussing results with engaged peers.
- When presenting refined strategy, lead with the learnings, not the model or map that produced them. Don't expect the technique's inherent insight to justify the change.
- If forced to commit urgently: say you're committed, then refine anyway. All decisions remain up for review with proper evidence.
- In strategy testing, assume people are well-meaning; attribute adoption failure to friction and ergonomics, not to people, and fix the friction.
- Be willing to end an initiative early when testing shows the solution isn't viable. Funding a few targeted bets and stopping is a success of refinement, not a failure of strategy.
- Treat model-versus-reality mismatches as diagnostic gold: they locate the assumptions distorting your understanding.
- If you have authority to mandate, be especially suspicious of your own urge to skip refinement — refinement is cheap and almost guaranteed to make you more successful.

## Pitfalls and misconceptions

- **Skipping refinement entirely** — the most frequent and most damning antipattern. Includes mimicry-driven strategy: adopting an approach because similar companies are doing it, with no evidence it helps you (Calm's monolith decomposition, pursued for a year).
- **Manufactured consent** — creating the *impression* of refinement by citing internal adopters as evidence, when those adopters are privately skeptical. Surface-level agreement gets used to convince the wider organization of belief that doesn't exist.
- **Discarding counterevidence to serve a side goal** — refinement happens, but its findings are ignored because the team is optimizing for something else (e.g., wanting to use an exciting technology). If only 3 of 15 engineers will touch the codebase, that's counterevidence, not noise.
- **Solving the easiest part of a correctly diagnosed problem** — an apt diagnosis paired with a solution that dodges the messy core (Agile rollout that assumed unfamiliarity when the real issue was the difficulty of prioritizing tasks from numerous stakeholders in an environment where saying no was frowned upon).
- **Believing commitment forecloses change** — being told to commit tricks strategists into turning off their strategic mind. Commitment never actually prevents refinement.
- **Anchoring on memory of the ecosystem** — great judgment built on how things *used to* work produces flawed strategy when the ecosystem has moved.
- **Misreading early termination as failure** — ending a tested strategy early without large commitment is the technique working as intended.
