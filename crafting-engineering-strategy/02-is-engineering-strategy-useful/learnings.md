# Chapter 2: Is Engineering Strategy Useful?

This chapter makes the case that engineering strategy is worth investing in, for both the organization and the individual. It argues that every organization already has a strategy whether or not anyone wrote it down, and that the value comes from making that strategy explicit. The single most important takeaway: **there is always a strategy embedded in an organization's decisions, and the single biggest action you can take to further strategy is to write it down** so the organization can debate it, agree on it, and explicitly evolve it.

## Core ideas

### There's always a strategy

Larson has never found an organization with no engineering strategy at all. Complaints about "missing strategy" are a truism; even when leadership documents and distributes an engineering strategy, the complaint just shifts to a missing product or company strategy. Echoing William Gibson ("The future is already here—it's just not very evenly distributed"), he argues a strategy is always embedded in an organization's decisions, even if it's only visible to a small group and quickly forgotten.

The operational definition: **whatever you find practitioners doing is their strategy.** Repeated decisions are always made according to some rule or set of rules, "even if the only rule is a powerful disregard for prior decisions."

Why this matters: if strategy always exists, the real choice is not "strategy or no strategy" but "deliberate, written strategy or implicit, accidental strategy."

### Strategy changes companies

Strategy creates impact through several distinct mechanisms, each with a concrete payoff:

- **Creating alignment.** A clear, documented strategy tells everyone "what sort of game we were playing and what the rules for that game were," letting people make an informed decision about whether to play it. This can cause some people to leave—and that is part of the alignment working, not a failure.
- **Concentrating company investment into a smaller space.** Deciding *not* to decompose a monolith lets you pour tooling effort into one language, one test suite, one deployment mechanism instead of spreading it thin.
- **Making properties available only through universal adoption.** Some benefits exist only at 100% consistency: an "N-1 policy" on backfilled roles manages costs only if consistently adopted; disaster recovery and multiregion availability strategies are only viable if all infrastructure shares a common configuration mechanism.
- **Focusing execution on what truly matters.** A good strategy lets a small team accomplish a hard goal without distracting the broader organization (Stripe's Sorbet effort: ~10 engineers pushed the Ruby monolith toward static typing incrementally).
- **Creating a knowledge repository of how your organization thinks.** Documented strategy makes onboarding—especially senior onboarding—far more effective, because rules that are obvious to people from one background are invisible to people from another. Undocumented policies see compliance decay quickly.

Limits: strategy cannot guarantee business growth, hire a particular individual, or guarantee that lobbying will change a legal framework like GDPR. But it has always been Larson's experience that developing a strategy creates progress, "even if that progress consists of understanding the inherent disagreement."

### Inappropriate strategy is especially impactful (in the wrong ways)

It sometimes feels like inappropriate strategy is far more impactful than good strategy—in all the wrong ways. The canonical failure mode: a sweeping rewrite/migration that consumes the organization's capacity at exactly the wrong moment. Almost every engineering organization has unused platform projects that captured decades of engineering-years at the cost of an important opportunity. A common driver: senior leaders joining a new company and initiating a grand migration—rewrite the architecture, switch languages—to make the new organization resemble a prior one "where they understood things better."

**"Inappropriate" versus "bad":** Larson deliberately avoids the word "bad" because the same strategy might be very effective in different circumstances. (A from-scratch rewrite could be exactly right for a three-person company with no revenue.) "Every approach undoubtedly works in some organization." Judge strategy against its circumstances, not in the abstract.

### Written strategy drives organizational learning

A "permissive strategy environment"—explicit guidance that individual teams may interpret according to their own beliefs—produces, over time, strongly divergent perspectives on the ideal path forward (Carta's situation when Larson joined).

Writing strategy down enables an organizational learning loop:

1. Writing forces you to describe the problems explicitly and discuss how to navigate them.
2. Iterate in a small group (Carta's "Navigators": ~10 named technical leaders representing key parts of a 400-engineer org—making iteration possible without negotiating with 400 engineers directly).
3. Share the artifact widely for feedback from teams you might have missed; discuss it in all-hands.
4. Return to it on a cadence ("each year—or when things stopped making much sense") and revise. Example: the initial Carta strategy said nothing about AI; later it added a conservative LLM stance; later still it was revised again for agentic workflows.

Key benefit of written strategy: **it makes it possible to disagree more precisely.** Disagreement is welcome—it's how the strategy evolves, both from new information (like the rapid evolution of AI practices) and from improving the initial approach (like changing how Navigators members were selected over time). New hires can disagree from an informed place rather than appearing attached to their prior company's practices, because the document preserves the thinking behind past decisions even when the original context is gone (e.g., a paused monolith decomposition that made sense under old service-provisioning friction looks arbitrary once that friction is fixed).

The deeper why: "With oral history, what you believe about the past and the present highly depends on who you talk with. With written history, it's far more possible to agree at scale, which is a prerequisite for growing at scale"—otherwise growth stays isolated within small pockets of senior leadership.

### Implicit strategy comes at a cost

Unwritten strategy actively does damage, in four ways:

- **Vulnerable to misinterpretation.** Verbal-first organizations depend on someone being in the room and then accurately repeating the information; people often fail to repeat it, or repeat it incorrectly. Both create significant problems.
- **Inconsistency across teams.** Informal policies (e.g., an unwritten preference for infrastructure work in Staff-plus promotions) distort behavior across the org, blindside new leaders in calibration, and—because no one is sure the policy is real—get applied randomly: good promotions blocked, borderline ones approved.
- **Inconsistency over time.** New policies mix persistent and one-time actions (linter check + one-time codebase pass to standardize an HTTP library). Years later, exceptions creep into the cracks. If the policy is written and a few people have read it, drift can be caught; if not, it's much less likely anyone remembers the policy—let alone the rationale—well enough to argue for it.
- **A hazard to new leaders.** Teams blame incoming Staff-plus engineers and executives for not understanding context behind past decisions. That's partly fair (uncovering context is the job) and partly unfair (documentation would make it much easier). The worst onboarding failures involve a new leader entering an unfilled role their own manager doesn't know how to do, so success depends entirely on their learning ability (and interest).

**Documentation as succession planning:** the full benefits accrue to the organization, not the author. The status quo survives while the original authors are present; valuing documentation requires considering what will matter to the organization after you've left.

**Information herd immunity:** the objection "no one reads anything" is partly true but misses the point. You don't need everyone to know the strategy; you need *enough* people to know it that confusion doesn't propagate far. You can't make all engineers know the details, but you can make sure every Staff-plus engineer and engineering manager does.

### Writing strategy supports personal learning

Even when you're not empowered to "do strategy," creating strategy is an underrated avenue for self-development:

- **Building self-awareness.** Going through the steps of building a strategy surfaces your real (often self-serving) motivations. Engineers who demand new languages because they want to learn them would, if forced to write the strategy out, produce one even they agreed didn't make sense.
- **Supporting situational awareness in new environments.** Situational awareness is a prerequisite to good strategy (per Wardley mapping); failing to understand the realities of your circumstances is the most destructive failure of new senior engineering leaders. Explicitly stating the diagnosis a strategy applies to makes it easier to see why reusing a prior strategy in a new team or company might not work.
- **Serving as your personal archive.** Documented strategy is institutional memory and personal memory. Over a long career, memory fades and motivated reasoning creeps in; explicit documentation persists, letting you understand the real impact of your prior approaches.

## Actionable guidance

- If you think your organization has no strategy, go find where it lives in practice. Observe what practitioners actually do when making repeated decisions; that is the strategy.
- Write strategy down. This is the single highest-leverage strategy action available: it lets the organization debate, agree, and explicitly evolve its approach.
- Judge strategies as appropriate or inappropriate *for their circumstances*, never as universally good or bad.
- Iterate on strategy in a small representative leadership group (roughly 10 people for a 400-engineer org) rather than negotiating with everyone directly; then share the draft widely for feedback and discuss it in all-hands.
- Revisit written strategy on a schedule—annually, or whenever it stops making sense—and revise it as conditions change (new technology waves, fixed pain points).
- Treat disagreement with the written strategy as a feature. Use it to evolve the strategy, and expect new hires to disagree from an informed position.
- Record the diagnosis and rationale behind each decision, not just the policy, so decisions remain legible after the original context disappears.
- Don't aim for everyone to read the strategy; aim for herd immunity. Ensure every Staff-plus engineer and engineering manager knows it cold.
- Convey important updates (especially strategy) to at least two people in each area of the organization to guard against one-to-one communication errors. Larson's two-leader model (a manager plus a senior engineer) per organization was adopted partly for this reason, and partly to include engineering context in senior decision making—expensive but worth it.
- When standardizing, pair one-time actions (codebase pass) with persistent mechanisms (linter checks) *and* a written policy, because enforcement mechanisms alone develop cracks.
- Practice the unglamorous basics: write things down, explore widely to see how other companies solve the same problem, and incorporate feedback from people who disagree with you. The most effective strategists win this way, not through high-prestige controversial decisions.
- Use strategy writing on yourself: before demanding a technology choice, write out the strategy that would justify it and check whether you still believe it.

## Pitfalls and misconceptions

- **"We have no strategy."** False; the strategy is in the decisions. Believing this blinds you to the implicit strategy already steering the org.
- **Distributing a strategy document with no enforcement mechanism.** Larson's Stripe Ruby-versus-Java mediation document wasn't particularly successful, chiefly for this reason. Writing is necessary but not sufficient.
- **The grand-migration trap.** New senior leaders rewriting architecture or switching languages to recreate a prior company they understood better. This is the signature inappropriate strategy.
- **Calling strategies "bad" instead of "inappropriate."** Leads to sterile debates about whether an approach can ever work, instead of whether it fits these circumstances.
- **Permissive strategy environments.** Guidance that teams freely reinterpret drifts into incompatible team-level strategies over time.
- **"No one reads anything" as a reason not to write.** Universal readership was never the goal; herd immunity among leaders is.
- **Expecting strategy to do what it can't.** It won't guarantee growth, land a specific hire, or change laws like GDPR—but writing one still creates progress, even if only an understanding of the inherent disagreement.
- **Equating strategy with high-prestige controversial decision-making.** The effective version is mundane: writing, researching peers, incorporating dissent.
