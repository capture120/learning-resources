# Chapter 2: Is Engineering Strategy Useful? — Examples

## Stripe's real-but-bemoaned engineering strategy (2016)

When Larson joined Stripe in 2016, engineers still complained about missing strategy, yet the company clearly had one, expressed in guiding policies: maintain backwards API compatibility at almost any cost (force a TLS 1.2-to-1.3 upgrade to keep PCI compliance, but never force migration off the `/v1/charges` endpoint to `/v1/payment_intents`); work in Ruby within a monorepo except for the PCI environment, data processing, and data science; and hold engineers fully responsible for the usability of their work even when product or engineering managers are involved. The strategy on any topic was generally discoverable, though sometimes only by asking around.
Illustrates: there's always a strategy, even when people insist there isn't—it lives in repeated decisions and policies, not necessarily in a document.

## The Ruby-versus-Java mediation document that failed

At Stripe, the question of adopting Ruby versus Java grew contentious enough that the answer to "what is our strategy here?" became genuinely unclear. Larson distributed a strategy document attempting to mediate the disagreement. It wasn't particularly successful, for reasons obvious in hindsight—particularly that the document had no enforcement mechanism.
Illustrates: writing a strategy down is necessary but not sufficient; without enforcement, a document doesn't resolve a contested decision.

## Calm: strategy that reset focus and caused departures

Calm, the meditation app company, suffered pervasive friction in its engineering team. The strategy (detailed in Chapter 21) clarified how major technology decisions get made and named the motivating goal: maximize time and energy spent on the product rather than on platform changes. Concretely, it raised the burden of proof for adopting new technologies, canceled a planned service decomposition, and narrowed innovation to efforts directly improving the product. It successfully reset the team's focus—and several engineers left, because experimenting with new technologies mattered more to them than product progress. For the first time, everyone could see what game was being played and its rules, and decide informedly whether to play.
Illustrates: clear written strategy creates alignment, and some attrition is the alignment working, not failing.

## Not decomposing the monolith concentrates investment

Deciding against decomposing a monolith (the Chapter 20 case) means the majority of tooling effort goes into one language, one test suite, and one deployment mechanism instead of being spread across many services and stacks.
Illustrates: strategy concentrates company investment into a smaller space.

## The N-1 backfill policy and common infrastructure configuration

An "N-1 policy" on backfilled roles (detailed in the book's Document 18-2) is a significant cost-management opportunity, but only if adopted consistently everywhere. Similarly, many disaster recovery and multiregion availability strategies are only viable if all infrastructure shares a common configuration mechanism.
Illustrates: some valuable properties exist only through universal adoption, which strategy is the tool to achieve.

## Stripe's Sorbet: ten engineers, one monolith, static typing

Stripe's strategy for Sorbet let a team of 10 engineers push the company's Ruby monolith toward static typing incrementally, without distracting the larger organization. The project was difficult enough that it could have consumed the entire organization for many months; the strategy's focus let a small team do the majority of the early work.
Illustrates: strategy focuses execution on what truly matters, letting small teams achieve large goals.

## The user-data access rule new hires don't know they need

A strategy for accessing user data requires that all access be supported by a clear, user-understandable rationale. This might be obvious to new hires from larger companies; people with only small-company experience are likely to be completely unaware such a rule is necessary. Without documentation, compliance with the policy quickly declines.
Illustrates: written strategy is a knowledge repository of how the organization thinks, and is essential for onboarding and sustained compliance.

## Digg V4: the inappropriate strategy that killed the company

Digg V4 is the worst-considered strategy Larson personally participated in. It rewrote the Digg V3.5 PHP monolith into a PHP frontend plus a backend of a dozen Python services, moved the database from sharded MySQL to an early version of Cassandra, and—perhaps worst—replaced the nuanced algorithms developed over a decade with a hack implemented a few days before launch. Digg likely would have struggled to become profitable anyway (it relied on SEO for traffic, and in that era Google's search algorithm changed frequently), but the engineering strategy ensured it died quickly, closing off any chance to rebuild before the money ran out.
Illustrates: inappropriate strategy can be more impactful than good strategy—in all the wrong ways—accelerating a company's death.

## "Inappropriate" not "bad": the three-person-company counterfactual

Larson originally labeled strategies like Digg V4 "bad," then reconsidered: had Digg been a three-person company with no revenue, rewriting from scratch could have been the right decision. Every approach works in some organization, so he uses "inappropriate" to keep the judgment tied to circumstances.
Illustrates: strategies must be judged against their context, not in the abstract.

## The grand-migration pattern among new senior leaders

Almost every engineering organization has unused platform projects that absorbed decades of engineering-years at the expense of important opportunities. A shockingly common version: a senior leader joins a new company and launches a grand migration—rewriting the architecture or switching programming languages—to reshape the new organization into the prior one where they understood things better.
Illustrates: a shockingly common source of inappropriate strategy is leaders reshaping a new organization to resemble a prior one where they understood things better.

## Carta: from permissive drift to an explicit written strategy

When Larson joined Carta, teams had distinct "standard kits" of allowed technologies, inconsistent adoption of existing internal platforms and funding of new ones, and broad agreement that the monolith was being decomposed with no agreement on how. Carta was a permissive strategy environment—explicit guidance, freely interpreted—so team perspectives diverged over time. One of his first projects was writing an explicit engineering strategy with the newly formed Navigators team: about 10 named technical leaders representing key parts of the 400-engineer organization, making iteration possible without negotiating with 400 people directly. The Navigators program was itself part of Carta's new engineering strategy. They iterated in the small group, shared the artifact widely for feedback, discussed it at all-hands, and revisited it yearly or when it stopped making sense—evolving even the process itself, such as changing how Navigators members were selected over time.
Illustrates: how to actually produce and maintain a written strategy—small representative group, wide feedback, regular revision.

## Carta's AI policy evolving through revisions

Carta's initial strategy didn't mention AI at all. Months later it was extended with a very conservative stance on using large language models. It was then revised again as the team dove into agentic workflows.
Illustrates: written strategy is a living document that evolves with new information.

## The paused monolith decomposition that now looks arbitrary

Carta paused decomposing its monolith at a time when service provisioning carried significant friction. That's far less true today, so the pause could now seem a bit arbitrary. Only the written document consistently communicates the original context across a growing, shifting organization—and lets new hires disagree from an informed place rather than seeming wedded to their prior company's practices.
Illustrates: written strategy preserves decision context after the conditions that justified the decision are gone.

## Two-headed organizations

Larson shifted to a model where most engineering organizations he worked with had two leaders: a manager and a senior engineer. The goals were to include engineering context in senior decision making and to reduce communication errors. Having two leaders where one might suffice is expensive, but one-to-one communication errors are so prevalent and costly that he now ensures every important update (like strategy changes) reaches at least two people in each area.
Illustrates: structuring communication for redundancy mitigates the misinterpretation risk inherent in verbal information flow.

## The unwritten Staff-plus promotion bias

At one company, Staff-plus promotions happened at a much higher rate in infrastructure engineering than in product engineering. This drained product engineers toward infrastructure-shaped problems even when those weren't particularly valuable to the business. New leaders didn't know the informal policy existed, ran into trouble in calibration discussions, and didn't know to argue for a better policy. Because no one was sure it was a real policy, its application was random: good promotions sometimes blocked, borderline cases sometimes approved.
Illustrates: unwritten strategy creates inconsistency across teams and randomness in outcomes.

## The HTTP library that keeps coming back

To avoid wrangling error-handling differences across many HTTP clients, you standardize on one library: add a linter check rejecting known alternatives and do a one-time pass across the codebase. Two years later, three new random HTTP libraries have crept into the cracks around the linting. If the policy is written and a few people have read it, the drift can be caught and argued against; if not, it's much less likely anyone remembers the policy, let alone its rationale, well enough to argue about it.
Illustrates: unwritten strategy decays over time; enforcement mechanisms alone develop gaps that only remembered rationale can close.

## The new leader set up to fail

Every particularly bad new-leader onboarding Larson has seen involved a new Staff-plus engineer or executive entering an unfilled role that their own manager didn't know how to do. The team blames them for not understanding the context behind past decisions—partly fair, since uncovering context is the job, and partly unfair, since documentation would make it far easier. Their success ends up depending entirely on their own learning ability and interest.
Illustrates: implicit strategy is a hazard to new leaders; documentation is the mitigation.

## The "extremely senior" engineers who wanted to have fun

Larson worked with several engineers who saw themselves as extremely senior but routinely demanded that projects use new programming languages or technologies because they personally wanted to learn them. Their internal strategy was clear—work on something fun—but actually following the steps of building an engineering strategy would have produced a strategy even they agreed made no sense.
Illustrates: writing strategy builds self-awareness by forcing hidden motivations into the open.

## Writing the book before the memories fade

Part of why Larson wrote this book now rather than later: he noticed he was starting to forget the details of strategy work from earlier in his career. To preserve that era's lessons and avoid relearning them, he had to write them down—memory fades and motivated reasoning creeps in, but explicit documentation persists.
Illustrates: documented strategy serves as a personal archive, not just institutional memory.
