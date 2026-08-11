# Chapter 9: Setting Policy

This chapter covers the first decision-making phase of strategy: translating a diagnosis into policy. Policy is "interpreting your diagnosis into a concrete plan" — a collection of decisions, tradeoffs, and approaches (coding practices, hiring mandates, architectural decisions, guidance on how choices get made). The single most important takeaway: a good policy is one that is *effective* — applicable, enforceable, and solving the diagnosis — not one that is novel or inspiring. With an excellent diagnosis, policies should feel inevitable, even boring, and that is a sign of quality.

## Core ideas

### What policy is (and is not)

Policy interprets the diagnosis into a concrete plan. An effective policy solves the *entirety* of the strategy's diagnosis — though the diagnosis itself should specify which aspects can be ignored. When a diagnosis contains genuine uncertainty (e.g., unknown headcount-reduction targets), a valid policy is to explicitly acknowledge the ambiguity and commit to revisiting once information arrives, rather than guessing.

Two frequent points of confusion:

1. **Policy is a subset of strategy, not the whole of it.** Policy is only meaningful in the context of the strategy's diagnosis. An "N-1 backfill policy" makes sense under new private-equity ownership; it would be wrong in a rapidly expanding organization. A strategy without policy is useless, but "policies without context aren't worth much either" — which is why strategies communicated without their diagnosis sections lose their force.
2. **Policy describes how tradeoffs *should* be made; it does not verify how they *are* made.** Verification is the job of operations (Chapter 10), which inspects organizational behavior to ensure policies are followed.

While drafting, keep policy and operations sections separate: whether a policy is effective is independent of the meeting or mechanism used to review it, and the operational mechanisms depend on how many policies you end up with. When later reworking for readability, merging the two sections is often fine.

### The six steps for setting policy

Larson finds writing policy feels either uncomfortably easy or painfully hard, never in between. It's usually easy *because* exploration, diagnosis, and refinement already did the heavy lifting — even when the easy conclusion is hard to swallow. The steps:

1. **Review diagnosis.** Ensure it captures the most important themes. Not perfect, but no glaring omissions.
2. **Select policies that address the diagnosis.** Explicitly match each policy to one or more diagnosis elements it addresses. Keep adding policies until every diagnosis element is covered. You'll mostly select from policies surfaced during exploration, tweaking them or reapplying familiar policies to new circumstances.
3. **Consolidate policies.** Merge overlapping or adjoining policies (e.g., two team-specific policies generalize into one organization-wide policy).
4. **Backtest.** Test the new policy against recent real decisions — especially effective if your organization keeps a decision log.
5. **Mine for conflict.** Solicit feedback, emphasizing people with perspectives different from yours — but don't wholly exclude those who agree with you. Just as you can crowd out opposing views in diagnosis, you can accidentally crowd out your *own* perspective by over-anchoring on others'.
6. **Refine.** If you're unsure the approach works, apply a refinement technique (Chapter 8). Real strategy takes many refinement passes, not one.

These steps are pedestrian *because* the earlier phases did the work. Skipping exploration/diagnosis/refinement and jumping to these steps produces far lower quality.

### How many policies?

Most strategies need a *set* of policies, not one, because diagnoses are complex. There is no universally right number — the right number is whatever it takes to solve the diagnosis. (The monolith-decomposition strategy needed exactly four.)

### The four kinds of policies

Most policies fall into four categories:

- **Approvals** define the process for making a recurring decision — e.g., invoking an architecture advice process or requiring sign-off from an authority figure. Different approval processes encode different tradeoffs between safety, productivity, and trust (paired-lead escalation builds mutual trust post-acquisition; written CISO exceptions manage corporate risk).
- **Allocations** describe how resources are split across potential investments. Allocations are "the most concrete statement of organizational priority" and articulate the organization's beliefs about how productivity happens (swarm people onto critical problems vs. force teams to solve problems without added headcount — both can work). Allocation policies create surprising clarity; the author includes one in almost every policy, either explicitly or, in a higher-altitude strategy, implicitly.
- **Direction** provides explicit instruction on how a decision *must* be made. Right when you know both the destination and the exact route — problems you understand clearly, where consistency matters more than empowering individual judgment. Direction works well when you need an unambiguous policy that doesn't leave room for interpretation. Use it when individual judgment produces incompatible decisions, or when misaligned incentives mean a softly stated policy would simply be ignored.
- **Guidance** provides a *recommendation* about how a decision should be made. Right when there's enough nuance, ambiguity, or complexity that you can explain the desired destination but cannot mandate the path. Guidance enables incremental progress in areas where concrete direction would cause confusion (e.g., five engineers will give five answers about whether a given service can merge back into a monolith — that's fine).

The distinguishing test between direction and guidance: if the policy requires significant judgment to interpret (you can state the desired outcome but cannot mandate the path), it's guidance.

Which categories feel natural depends on role:
- Developer-productivity teams lean on guidance, backing it with support in platform details.
- Executives lean on direction — often *too* heavily, when guidance would work better for areas where they understand the direction but not the path.
- Product engineering organizations may need to narrow direction's scope to their own engineers, given cross-organization dynamics.

The categories are a tool, not a constraint: if a clear approach doesn't fit any category, try it anyway and adapt.

### Strategy altitude

Be deliberate about *where* in the organization a policy is created, especially regarding how it eliminates flexibility. An organization-altitude policy (e.g., enforcing one programming language everywhere) takes away team freedom but unlocks centralized investment. A team-altitude policy (e.g., teams own their roadmap resourcing) preserves local control because solving it higher up would just be routed around. "Both altitudes make sense. Both have consequences." Engineers and executives generally write at different altitudes.

### Criteria for effective policies

From The Engineering Executive's Primer, three criteria: policies should be **applicable** (useful for navigating complex real-world scenarios, particularly tradeoffs), **enforced** (teams are held accountable for following them), and **create leverage** (compounding or multiplicative impact). Larson revises the third outside the executive context: what matters isn't leverage per se, but that the policy **solves part of the diagnosis**. Some policies create leverage (avoiding API deprecation strengthens retention mechanisms); some don't and are still good (N-1 backfill).

Applicable and enforced remain non-negotiable: "Any policy you can't determine how to apply or aren't willing to enforce simply won't be useful."

A subtlety: making a policy applicable by assigning judgment to one person (e.g., code authors decide DRY violations) shifts the enforcement burden — the policy now only works if the organization holds individuals accountable for the *quality of their judgment*. The same policy can be right in one context and wrong in another (service-oriented architecture at Uber vs. Calm/Carta); organizations unwilling to make such distinctions and hold decision-makers accountable get no value from the policy.

### Developing novel policies

In Larson's experience, truly novel policies are vanishingly rare — someone has almost always done something similar. Details are particular to your company; the general approach is industry-common. The likeliest place for genuine novelty is the widespread-adoption phase of a new technology (mobile, cloud, LLMs). Even then, you can often treat the new technology generically: a policy reading "LLM-backed" could say "data-driven" and read identically. Policy can sidestep areas of uncertainty by being a bit abstract, avoiding over-specificity about things you don't yet understand.

A policy may still be novel *to you or your organization*. To debug a (locally) novel policy, run a condensed strategy process focused on exploration and refinement:
1. Collect similar policies and articulate how they differ from yours.
2. Create a systems model (Chapter 14) of how the new policy will work and how it differs from the comparables.
3. Run a strategy testing cycle on the proto-policy to surface "unknown unknowns" about practice.

How often you face this is a function of experience: early-career strategists do (personally) novel work frequently; veterans mostly adapt well-known policies to new circumstances.

### Competing policy proposals signal diagnosis gaps

Developing a set of policy options is a useful *stage*, but its real value is exposing gaps in your diagnosis, not refining the policy itself. When two proposals seem equally valid (build Sorbet vs. migrate to Golang/Java), the resolution comes from sharpening the diagnosis (clarifying resourcing priorities) until one option is clearly better. If you do develop alternatives, move them to an appendix rather than the core document — readers follow the selected approach more easily without the distraction of roads not taken.

### Recognizing constraints

A frequent failure: writing a policy you cannot possibly fund or enforce. Policies that would only work "in an alternate universe" sound inspirational but accomplish little. Notably: "your leadership is never bound to honor a policy you write that they disagree with."

An impractical policy isn't merely poor — it signals your diagnosis is missing an important pillar. Rather than debating policy options, the fastest resolution is aligning on a diagnosis that invalidates some of the paths forward. Where aligning on the diagnosis isn't difficult (e.g., because you simply don't yet understand a new technology's possibilities), you've likely found a valuable opportunity to use strategy refinement to build alignment.

### Dealing with missing strategies

When a company-level or peer-function strategy is missing, the empowering move is to include that absence in your diagnosis and move forward — reframing the blocker into a diagnosis element (Chapter 7). Don't refuse to set policy because a peer might later set a conflicting one. You will never have all the details you want: "Meaningful leadership requires taking meaningful risks, which is never comfortable."

## Actionable guidance

- Follow the six steps in order: review diagnosis → select policies matched to diagnosis elements → consolidate → backtest against recent decisions → mine for conflict → refine.
- Explicitly map each policy to the diagnosis element(s) it addresses; keep adding policies until every element is covered.
- When the diagnosis contains unresolvable uncertainty, write a policy that acknowledges it and commits to revising when specific information arrives — and say what you'll wait for.
- Maintain a decision log — backtesting policies against recent decisions is particularly effective when you have one.
- When mining for conflict, weight dissenting perspectives, but don't erase your own view by over-anchoring on others.
- Keep policy and operations as separate sections while drafting; merge only when polishing for readability.
- Consider all four policy kinds (approvals, allocations, direction, guidance) for every strategy; don't default to the one your role finds comfortable.
- Include an allocation policy in nearly every strategy — it's the clearest statement of priority.
- Use direction only when you know both destination and route and value consistency over judgment; state it forcefully enough that misaligned incentives can't ignore it, and consider pairing it with an exception process for rare cases where following it is implausible.
- Use guidance when you can name the outcome but not the path; accept that interpretation will vary.
- Choose the altitude deliberately: solve problems at the level where the policy can actually bind behavior, not where it's most convenient to write.
- Test every policy against two gates: can someone determine how to apply it in a real tradeoff, and are you actually willing to enforce it? If either fails, stop and ask what you're really trying to accomplish, then find a different policy.
- When making a policy applicable by delegating judgment to individuals, plan how you'll hold them accountable for judgment quality — otherwise the policy is hollow.
- Sidestep uncertainty about new technologies by writing policies one level of abstraction up (the policy should survive swapping the buzzword for a generic term).
- For policies novel to your organization: collect comparables and articulate the differences, build a systems model, and run a testing cycle before committing.
- Treat competing policy bundles as a prompt to sharpen the diagnosis until one option wins; don't litigate the options directly.
- Move alternative policies into an appendix; keep the document body focused on the selected approach.
- Never propose a policy your leadership or budget won't sustain; if you're drawn to one, find the missing diagnosis pillar that rules it out.
- When a dependency's strategy is missing, write its absence into your diagnosis and proceed anyway.

## Pitfalls and misconceptions

- **Communicating policies without their diagnosis.** Stripped of context, policies lose their meaning and persuasive force; this is common and damaging.
- **Confusing setting policy with verifying it.** Writing the policy doesn't ensure anyone follows it — that's operations.
- **Valuing novelty or inspiration over effectiveness.** Boring, inevitable-feeling policies from a strong diagnosis are good; inspirational-sounding policies that ignore constraints accomplish little.
- **Executives over-relying on direction** where guidance would serve better (knowing the destination but not the path).
- **Unapplicable or unenforceable policies** ("we only hire world-class engineers") — vague terms with no mutually agreeable definition can't be consistently enforced.
- **Multiple competing policy bundles in the final document** — generally indicates a gap in the diagnosis, and clutters the document for readers.
- **Policies you can't fund or that leadership will override** — leadership is never bound by a policy they disagree with; the next planning cycle will invalidate it.
- **Treating a peer function's missing strategy as a blocker** instead of a diagnosis input — you'll never have all the details you want, and meaningful leadership requires taking meaningful risks.
- **Skipping exploration/diagnosis/refinement** and going straight to policy steps — the steps still execute, but quality collapses.
