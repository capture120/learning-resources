# Chapter 4: When Should You Write Strategy—and How Much? — Examples

## The blank "Engineering Strategy" document at Calm

Shortly after becoming CTO of Calm, Larson opened a document titled "Engineering Strategy," stared at the blank page, and put it away for a year because he didn't know what to write. When he returned to it, he wrote just three guiding principles: choose boring technology, resolve conflict with curiosity, and prefer vendors for commoditized functionality. Those simple statements greatly reduced conflict in decision making and freed energy for improving the product.
Illustrates: Writing nothing is often the best available choice until you have something useful to say, and a tiny strategy can deliver outsized alignment.

## Service architecture as the three strategic states

The chapter grounds the three strategic states in service architecture decisions. Globally consistent: everyone agrees new product functionality goes in the existing monolith. Consistent within teams: product engineering wants new functionality in new services within a shared monorepo, while platform engineering wants everything in the monolith. Highly varied: individual engineers split between new services in a monorepo, new services in polyrepos, and the existing monolith.
Illustrates: How to diagnose your current strategic state by comparing the answers different people give to the same question.

## Uber's hypergrowth fragmenting strategy

Uber doubled its engineering headcount every six months for four years and opened many distributed engineering offices. This produced highly varied technical approaches, and because most engineers were recent hires, inconsistency kept climbing.
Illustrates: Rapid hiring is a recurring cause of abrupt decline in strategic state, signaling a good moment to write strategy.

## Playbook-driven executives creating strategy rifts

Many newly hired external leaders, eager to make an early impact, skip diagnosing their new environment and make sweeping changes — a known antipattern in executive onboarding. The result is a rift between teams that align with the new direction and teams maintaining the existing software and infrastructure.
Illustrates: New leadership behavior is a trend-driver of strategic state, and acting before building context fragments the organization rather than aligning it.

## Onboarding as decision propagation

Some companies drill new hires on how decisions get made; others expect teams to train new hires locally. Both approaches can work well and both can work poorly.
Illustrates: How effectively you document and communicate historical decisions shifts strategic state; the mechanism matters less than its effectiveness.

## Uber: service provisioning before monolith decomposition

At Uber, reliability and productivity were suffering in the monolithic Python codebase. Larson's team had no authority to forbid commits to the monolith, but it could make provisioning and operating new services painless, so that became the entire strategy. The eventual goal — decomposing and departing from the monolith — was deliberately not addressed directly; the team proved out the prerequisite first. Had they started with the broader strategy, they might have gotten stuck in intellectual debate and needed many teams to buy into a future vision with no concrete step to take. By the time there was a concrete step people needed to take, most were already operating as intended, so there was no intellectual debate about whether it was possible.
Illustrates: Start with one small strategy that is a prerequisite of the larger goal, and delay consensus-building until there is a concrete step for people to take.

## The Uber strategy looking like "losing the plot"

While the real problem was the monolithic codebase, the team spent its time talking about service provisioning. From a distance it must have looked like they had lost the plot and lacked ambition.
Illustrates: Effective strategy development can appear overly conservative; pair focused execution with proactive storytelling so stakeholders see how the increment expands into something larger.

## Driving with the windows down

Driving down the highway with the windows down feels faster but is actually slower. The same holds true in software engineering.
Illustrates: Friction isn't velocity — a focused, quiet approach can be faster than a sweeping one that feels fast.

## Digg's clear architecture in a burning building

When Larson joined Digg, the engineering strategy was extremely clear and consistent: a PHP frontend, Python services, and Cassandra for all storage. The company still collapsed.
Illustrates: A few strategies that work beat many strategies, even good ones, in a burning building; clear strategy alone doesn't rescue a failing company.

## Four strategies at four altitudes

The chapter gives one example for each quadrant of permissiveness by altitude. Permissive at org altitude: a developer experience team builds a mechanism for teams to define their own linting rules, ships opinionated defaults, and lets each team override locally. Prescriptive at org altitude: a CTO mandates that every pull request includes a test and that CI/CD blocks merges reducing code coverage. Permissive at team altitude: a product engineering team tells engineers to consider security issues and provides educational resources. Prescriptive at team altitude: a product team schedules bug fixes first in sprint planning and only schedules features once the bug backlog is drained.
Illustrates: The two dimensions of strategy altitude — permissive vs. prescriptive, and team vs. organization level — and what each combination looks like in practice.

## Carta: broad strategy via permissiveness and escalation paths

Joining Carta, Larson rolled out a large amount of strategy across engineering within six months. Part of it was simply documenting existing strategy, which cost little to adopt. The new shifts were built as permissive strategies. Every strategy included an escalation path to support local customization, generally asking each team's Navigator (a Staff-plus engineer responsible for the area) to override the strategy as appropriate. He was highly prescriptive in exactly one place — provisioning new services — where the escape hatch was more restrictive, requiring escalation to the CTO. Being more prescriptive overall would have failed, even though he might have looked like a more courageous leader.
Illustrates: The formula to increase strategy volume is to reduce altitude, increase permissiveness, or both — Carta covered a broad range of topics at high altitude by focusing on permissive strategies with local override paths; looking effective and being effective tend to be only lightly correlated.
