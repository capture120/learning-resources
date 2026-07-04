# Chapter 8: Refining — Examples

## Fire bullets, then cannonballs (Great by Choice)

Jim Collins and Morten T. Hansen's concept from *Great by Choice* (2011): test new ideas cheaply before fully committing. An organization can only afford to fire a small number of cannonballs, but it can bankroll far more bullets, so it should use bullets to derisk the cannonballs' trajectories. Larson uses this as the framing metaphor for the entire chapter: refinement techniques are the bullets.

Illustrates: the core rationale for strategy refinement — cheap validation before expensive commitment.

## Stripe's one-meeting Agile rollout

Stripe's head of engineering rolled out Agile techniques in a single meeting, targeting a real problem: the company struggled to plan beyond a month, which became acute as enterprise customers demanded committed functionality in their contracts. The rollout assumed the issue was engineering managers being unfamiliar with Agile. The actual issue was the difficulty of prioritizing tasks from numerous stakeholders in a culture where saying no was frowned upon. The diagnosis named a real problem (no shared planning paradigm), but the solution solved the easiest part while ignoring the messier parts, and failed to make meaningful progress.

Illustrates: skipping refinement turns a moderately challenging problem into a strategy failure; an apt diagnosis can still pair with a solution that dodges the hard core.

## Uber's service adoption strategy built entirely through refinement

Uber's infrastructure engineering team had no authority to mandate that product teams adopt their new service platform, so they built the strategy exclusively through refinement. They used systems modeling to understand which parts of adoption to focus on, and strategy testing to learn by migrating individual product engineering teams onto the platform one at a time. The modeling specifically pointed them toward eliminating upfront steps in service onboarding — shifting to reasonable defaults instead of forcing teams to learn the new platform before it had shown them any usefulness. (Full case study in Chapter 16, Document 16-1.)

Illustrates: refinement can translate an extremely difficult problem into a success, and is the natural mode for low-altitude teams that lack mandate authority.

## Executives skipping refinement to look ambitious

When executives start a new role, they know early impressions matter, and they know sounding ambitious often resonates more loudly than doing good work. So they kick off aspirational initiatives — such as a massive overhaul of the codebase — believing it will establish their reputation as an effective leader, even though refinement would be cheap and would almost guarantee better outcomes.

Illustrates: high-altitude strategy skips refinement because of reputational incentives, not because refinement lacks value.

## Promotion-driven projects that stall after the easy proof points

In permissive strategy organizations where promotion to senior engineering roles requires an ambitious, high-leverage project, you might see a novel networking or authorization approach implemented whose adoption fails after solving some easier proof points. In many cases, the promotion lands before the rollout stalls, disincentivizing the engineer from worrying too deeply about whether the project was net-positive. The executive who owns the promotion rubric eventually sees the flaw, but faces a genuine tradeoff: an organization that innovates too much while empowering individuals, versus one with little waste but restricted room for creativity.

Illustrates: incentive structures, not individual failings, drive skipped refinement below the executive level.

## Larson's father and the systems modeling workshop

Larson's father, an economics professor, brought him to a systems modeling workshop in Boston one summer during high school. This opened his eyes to the wide world of techniques for reasoning about problems, and systems modeling became the first tool in his refinement toolkit. By contrast, he only learned Wardley mapping while writing this book — even practiced strategists add tools slowly, one at a time.

Illustrates: a toolkit usually starts with one tool learned through exposure; many people skip refinement simply because no one ever showed them a tool.

## Carta's code quality initiative (strategy testing)

At Carta, "improve code quality" was a strategy problem where both the definition of the problem and the concrete steps were hard to agree on. The team spent relatively little time on the right initial solution and instead ran the strategy-testing loop: pick the narrowest, deepest slice, iterate, find verifying metrics, assume failures come from friction rather than ill will. They achieved some small wins, funded a handful of specific long-term bets, and ended the initiative early without a large organizational commitment. Larson rejects calling that a failure: having a problem doesn't mean you have an elegant solution, and strategy testing helps validate whether the solution's efficiency and ergonomics are viable.

Illustrates: strategy testing on an ambiguous problem, and early termination as a successful refinement outcome.

## Ride-share driver onboarding model

A systems model of onboarding drivers in a ride-share app (Document 16-2) shows that in a mature market, reengaging drivers who have left the platform matters more than bringing on new drivers — an insight that could be reached without modeling, but that the model makes immediately visible.

Illustrates: systems modeling cheaply locating the highest-leverage intervention in a complex system.

## Load balancer error model (Figure 8-1)

The chapter's figure shows a systems model of errors in a load balancer, as an example of modeling a technical system to find which levers matter.

Illustrates: systems modeling applied to a purely technical reliability problem.

## Wardley map of the LLM ecosystem (Figure 8-2)

Today there is a proliferation of narrow platforms built on recent LLM advances. Studying a Wardley map of the LLM ecosystem suggests the ecosystem will likely consolidate into fewer, broader platforms rather than staying scattered across distinct vendors. A strategy built on the assumption that today's fragmentation persists would be anchored on a snapshot, not the trajectory.

Illustrates: Wardley mapping surfacing how industry evolution will impact a strategy built on dynamic technology.

## Observability in the 2010s

Cited as the type of highly dynamic technology where Wardley mapping pays off: the observability space evolved rapidly through the 2010s, so strategies adopting it needed to account for where the ecosystem was heading, not where it stood.

Illustrates: the "dynamic technology" trigger condition for Wardley mapping.

## Calm's cargo-cult monolith decomposition

At Calm, the team decomposed their monolithic codebase because that was what similar companies around them were doing. They had no reason to believe it was improving developer productivity, yet pursued the strategy for a year before recognizing they were suffering from skipped refinement.

Illustrates: the most common antipattern — skipping refinement entirely, here driven by industry mimicry.

## Uber's manufactured-consent rearchitecture

A new senior leader at Uber mandated a complete technical rearchitecture, justified partly by evidence that several internal leaders had successfully adopted the same techniques on their teams. When Larson spoke with those internal leaders, they were themselves skeptical that the proposal made sense — yet their surface-level agreement was being used to convince the wider organization that they believed in the new approach.

Illustrates: manufacturing consent to create the illusion of refinement without its benefits.

## Erlang at Yahoo! Build Your Own Search Service

Larson's first team at Yahoo! adopted Erlang for a key component of Yahoo! Build Your Own Search Service. It proved to be "an excellent solution to our problem of wanting to use Erlang, but a questionable solution to the core problem at hand." Only 3 of the 15 engineers on the team were willing to touch the Erlang codebase, but that counterevidence was ignored because it conflicted with the side goal of using Erlang.

Illustrates: the third antipattern — running refinement but discarding counterevidence to protect a side goal.
