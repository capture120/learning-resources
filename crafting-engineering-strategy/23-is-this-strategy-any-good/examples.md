# Chapter 23: Is This Strategy Any Good? — Examples

## Uber's service migration strategy, scored across two phases

Uber's service migration strategy (Document 16-1) unblocked the entire organization and enabled rapid progress, but later produced a sprawling architecture problem. Was it a great strategy or a terrible one? Reasonable people will disagree, and the chapter uses it as the worked example for the rubric, scoring it once per phase to resolve the tension.

**Phase 1** — using service provisioning to address developer productivity problems in the monolith:

- Speed: 3. Starting with structured requests created an interface the team could iterate behind daily.
- Cost: 2. The platform and integration were mostly buildable by a single team; migrating existing services needed coordination with other teams, but on a flexible schedule.
- Impact: 2. Handling the high volume of new-service requests solved the most pressing problem and incrementally freed time to move the biggest existing services.
- Total: 7 — a high-quality strategy.

**Phase 2** — once the provisioning platform was wholly adopted and engineers had to build complex systems on top of it:

- Speed: 1. Changes within one service happen daily, but cross-service changes can take quarters.
- Cost: 1. Significant architecture changes require coordinating numerous teams, sometimes many dozens, even for relatively straightforward changes.
- Impact: 2. Service provisioning is wholly solved, but operating the provisioned services at scale is hard.
- Total: 4 — a degraded strategy.

Illustrates: strategy quality is phase-dependent; the same strategy can legitimately score 7 in one phase and 4 in the next, and very effective strategies are especially prone to difficult post-rollout phases.

## Google's service architecture and its copiers

When Google moved to service architectures, other companies copied the move, reasoning that what worked for Google would work for them. As covered earlier in the book (Chapter 20), it did not work particularly well for most adopters.

Illustrates: grading strategy on outputs alone fails because someone else's outputs don't transfer; there's no counterfactual telling you the result came from the strategy rather than the company's circumstances.

## Stripe's Index acquisition versus building internally

Acquiring Index let Stripe build a point-of-sale business line (Chapter 22), but Stripe was already on track to build that business internally. Looking only at the outcome cannot tell you whether acquiring or building was the better strategy — yet one of them must have been.

Illustrates: output-based evaluation can't distinguish a strategy's contribution from the expected outcome without it.

## Stripe's API deprecation strategy becoming too expensive

Stripe's policy of never deprecating APIs (Document 22-2) was extremely well worth its cost for the company's first decade. As the regulatory environment evolved and created more overhead, the strategy became too expensive to maintain. Stripe modified it to allow some deprecations; had it clung to the original, the strategy would likely have failed under accumulating costs.

Illustrates: a strategy can succeed and still be bad to continue — successful strategies carry costs that can grow until maintaining them becomes failure.

## The cautious LLM-adoption strategy that could still lose

Document 17-1 describes a cautious approach to adopting large language models. The chapter argues that if the company loses significant revenue because competitors incorporate LLMs better, the strategy isn't a great one — even if it's rooted in a proper diagnosis and effective policies.

Illustrates: input-based evaluation fails too; good strategy must reconcile the theoretical with the practical, and a sound-on-paper strategy that ignores evidence it isn't working is a failed strategy.

## Digg owning its own servers in 2010

Digg owned its own servers in 2010, but would certainly not have bought its own servers had it started ten years later.

Illustrates: diagnoses evolve with circumstances, so abandoning a strategy can simply reflect a changed world rather than a bad strategy.

## Larson's abandoned developer-productivity strategy

The author sponsored a developer-productivity strategy as an executive. It had some impact, but less than intended. The organization adopted a few of the smaller pieces, then returned to exploring a lower-altitude strategy owned by the teams instead of the high-altitude one he owned.

Illustrates: aborting a strategy in its first phase is a good sign when the cost of learning outpaces the rate of learning, and high-altitude strategy should yield ownership back to lower altitudes unless it's proven and highly impactful.

## The competitor's blog post you can't verify

When peers rolled out LLMs or microservices, engineers got pressured internally to explain why their company wasn't doing the same. But from outside you can't know how many phases the competitor went through before the publicly visible idea, what the early phases cost, whether the real mastery lives in unreported operational mechanisms, or whether the glowing blog post is accurate or hiring bait.

Illustrates: the "unpierceable veil" — external strategy evaluations are guaranteed to miss context, so hold them with low confidence.

## Stripe's failed Agile rollout versus Calm's successful product-engineering shift

The author learned just as much from Stripe's failed rollout of Agile, which struggled because it lacked operational mechanisms, as from Calm's successful transition to focusing primarily on product engineering. The key was knowing in advance which one worked; without that point of view, he'd have risked learning the wrong lessons.

Illustrates: failed strategies teach as much as successful ones — but only if you're aware of their quality; it's then particularly valuable to locate where (phase and strategy step) the failure occurred.
