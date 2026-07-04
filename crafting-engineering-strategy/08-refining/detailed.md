# Chapter 8: Refining — Detailed Reference

## Introduction

In the book *Great by Choice* (Random House Business, 2011), Jim Collins and Morten T. Hansen develop a concept they call "Fire Bullets, Then Cannonballs." Their premise: you should test new ideas cheaply before fully committing to them. Your organization can only afford to fire a small number of cannonballs, but it can bankroll far more bullets. Why not use bullets to derisk your cannonballs' trajectories?

This chapter introduces the practice of strategy refinement and presents a series of concrete techniques that Larson has personally used to refine strategies before they reach the cannonball stage. The chapter works through four things:

1. Why strategy refinement is the highest-impact step of strategy creation.
2. How mixed incentives often lead people to skip the refinement stage, even though doing so leads to worse organizational outcomes.
3. How to build your personal strategy-refinement toolkit for refining strategy with techniques like strategy testing, systems modeling, and Wardley mapping.
4. How to avoid antipatterns that skip refinement, or that manufacture consent to create the illusion of refinement without providing its benefits.

Each of these refinement techniques is also covered in greater detail in its own chapter of the book.

## What Is Strategy Refinement?

Most strategies succeed because they properly address narrow problems within a broader strategy. Fully implementing a strategy in order to validate it is possible, but this approach is typically inefficient and slow. Worse, it is easy to get so distracted by miscellaneous details that you lose sight of the levers that will make your strategy impactful.

Strategy refinement is a toolkit of methods to do two things:

1. Identify those narrow problems that matter most.
2. Validate that your solutions to those problems will be effective.

The right tool within the toolkit varies depending on the strategy you're working on:

- It might be **Wardley mapping** to understand how the ecosystem's evolution will impact your approach.
- It might be **systems modeling** to determine which part of a migration is the most valuable lever.
- In other cases, it's **slowing down committing to your strategy** until you've done a narrow test drive to derisk the pieces you don't quite have conviction in yet.

Whatever tools you've relied on to refine strategy thus far in your work, there are always new refinement tools to pick up. The book presents a workable introduction to several tools Larson finds reliably useful, while providing a broader foundation for deploying other techniques that you develop toward strategy refinement.

## Does Refinement Matter?

The section answers with two contrasting cases — one where skipped refinement caused failure, one where refinement alone produced success.

### Stripe's one-meeting Agile rollout (failure from skipped refinement)

At Stripe, the head of engineering rolled out Agile techniques in one meeting. The change was aimed at the company's difficulties with planning in periods longer than a month, which was becoming an increasing challenge as Stripe started working with enterprise businesses who wanted commitments to specific functionality as part of signing their contracts.

The approach worked poorly because it assumed the issue was engineering managers being generally unfamiliar with Agile techniques. The actual challenge of adoption wasn't awareness, but rather the difficulty of prioritizing tasks from numerous stakeholders in an environment where saying no was frowned upon.

In this Agile rollout, the lack of a shared planning paradigm was a real, apt problem. However, the solution "solved the easiest part of the problem, without addressing the messier parts," and consequently failed to make meaningful progress. Larson notes this happens "a surprising amount," and "can be largely avoided with a small dose of refinement."

### Uber's service adoption strategy (success built exclusively through refinement)

On the opposite end, Uber's service adoption strategy (covered in Chapter 16) was created exclusively through refinement, because the infrastructure engineering team didn't have any authority to mandate wider changes. Instead, the team relied on two different kinds of refinement to focus their iterative efforts:

1. **Systems modeling** to understand what parts of adoption they needed to focus on.
2. **Strategy testing** to learn by migrating individual product engineering teams over to the new platform.

### The verdict

In the Agile adoption example, failure to refine turned a moderately challenging problem into a strategy failure. In the service migration example, focus on refinement translated an extremely difficult problem into a success. Refinement is, in Larson's experience, "the kernel of effective strategy."

## If It Matters, Why Is It Skipped?

The section diagnoses why refinement is skipped despite its value, working through several distinct causes.

### Low-altitude strategy gets refined — but out of powerlessness, not belief

When a small team creates a strategy — called a low-altitude strategy — they almost always spend a great deal of time refining it. This isn't because most teams believe in refinement. Rather, it's because most teams lack the authority to force others to align with their strategy. This lack of authority means they must incrementally prove out their approach until other teams or executives believe it's worth aligning with.

### High-altitude strategy skips refinement for reputational reasons

High-altitude strategy is typically the domain of executives, who generally have the ability to mandate adoption. They routinely skip the refinement stage, even when it's inexpensive and is almost guaranteed to make them more successful.

Why? When executives start a new role, they know making an early impression matters. They also, unfortunately, know that "sounding ambitious often resonates more loudly than doing good work." So, while they do hope to eventually be effective, early on they kick off a few aspirational initiatives — like a massive overhaul of the codebase — believing it'll establish their reputation as an effective leader at the company.

### Promotion incentives reproduce the same failure below the executive level

This isn't uniquely an executive failure. It also happens frequently in permissive strategy organizations that require an ambitious, high-leverage project to get promoted into senior engineering roles. For example, you might see a novel approach to networking or authorization implemented, whose adoption fails after solving some easier proof points, and trace its heritage back to the company's promotion criteria.

In many cases, the promotion will come before the rollout stalls out, disincentivizing the would-be-promoted engineer from worrying too deeply about whether this was net-positive for the organization. The executive responsible for the promotion rubric will eventually recognize the flaw, but it's not the easiest tradeoff for them: they must pick between an organization that innovates too much while empowering individuals, or an organization with little waste but restricted room for creativity.

### Forced urgent commitment

Another reason refinement gets skipped: sometimes you're forced to urgently create and commit to a strategy, usually because your boss tells you to. This doesn't actually prevent refinement — "just say you're committed and refine anyway" — but often this interaction turns off the strategist's mind, tricking them into thinking they can't change their approach because they've already committed to it. "This is never true; all decisions are up for review with proper evidence," but it takes a certain courage to refine when those around you are asking for weekly updates on completing the project.

### Missing toolkit

There's one other important reason strategy refinement gets skipped: many people haven't built out a toolkit to perform strategy refinement, and they haven't worked with someone who has a toolkit.

## Building Your Toolkit

Larson is "eternally grateful" to his father, a professor of economics, who brought him to a systems modeling workshop in Boston one summer when Larson was in high school. This opened his eyes to the wide world of techniques for reasoning about problems, and systems modeling became the first tool in his toolkit for strategy refinement.

Part III of the book, on refinement, goes into three refinement techniques in significant detail — strategy testing, systems modeling, and Wardley mapping — as well as surveying a handful of other techniques more common to strategy consultants. Larson adopted systems modeling early, whereas he only learned Wardley mapping while working on this book.

Key claims about toolkit-building:

- Few individuals are proficient users of many refinement tools, but it's "extraordinarily powerful to unlock your first tool," and worthwhile to slowly expand your experience with other tools over time.
- All tools are flawed, and each is best at illuminating certain types of problems.
- If all of these tools are unfamiliar, skim over all of them and pick the one that seems most applicable to a current problem you're working on.
- You build expertise by trying a tool against many different problems, and talking through the results with engaged peers.

A critical communication rule for practice: the important thing to share is **what you learn from these techniques**; avoid getting too caught up in sharing the techniques themselves. Larson has seen these techniques meaningfully change strategies, but he has "never seen those changes successfully justified through the inherent insight of the refinement techniques themselves."

## Strategy Testing

Sometimes you'll need a strategy to solve an ambiguous problem, or a problem where a diagnosis is difficult because the issues blocking progress are poorly understood.

### Carta example: improving code quality

At Carta, one strategy problem the team worked on was improving code quality, which is a good example of both conditions: it's difficult to agree on what code quality is, and equally difficult to agree on appropriate, concrete steps to improve it.

To navigate that ambiguity, the team spent relatively little time thinking about the right initial solution, and a great deal of time deploying the strategy-testing technique (discussed in Chapter 13):

1. Identify the narrowest, deepest available slice of your strategy. Iterate on applying that slice until you see some evidence it's working.
2. As you iterate, identify metrics that help you verify the approach is working.
3. Operate from the belief that people are well-meaning, and strategy failures are due to excess friction and poor ergonomics.
4. Keep refining until you have conviction that your strategy's details work in practice, or that the strategy needs to be approached from a new direction.

### Outcome and interpretation

In the Carta case, the team achieved some small wins, funded a handful of specific bets they believed would improve the problem long-term, and ended the initiative early without making a large organizational commitment. You could argue that's a failure, but Larson's experience is quite different: "having a problem doesn't mean you have an elegant solution," and strategy testing helps you validate whether the solution's efficiency and ergonomics are viable.

### When to use it

If you're dealing with a deeply ambiguous problem and there's no agreement on the nature of the reality you're operating in, strategy testing is a great technique to start with.

## Systems Modeling

When you're unsure where leverage points might be in a complex system, systems modeling (Chapter 14) is an effective technique to cheaply determine which levers might be effective. The chapter illustrates with Figure 8-1, a systems model of errors in a load balancer.

Two examples of modeling locating non-obvious leverage:

- **Ride-share driver onboarding** (Document 16-2): the systems model for onboarding drivers in a ride-share app shows that in a mature market, reengaging drivers who've left the platform matters more than bringing on new drivers.
- **Uber service migration** (Document 16-1): systems modeling helped the team focus on eliminating upfront steps during service onboarding — shifting to reasonable defaults and away from forcing teams to learn the new service platform before it had shown any usefulness to them.

Two properties of modeling:

- You can certainly reach these insights without modeling, but modeling "tends to make the insights immediately visible."
- In cases where your model doesn't immediately illuminate what matters most, studying how your model's projections conflict with real-world data will guide you to understand where your assumptions are contorting your understanding of the problem.

### When to use it

If you generally understand a problem, but need to determine where to focus efforts to make the largest impact, then systems modeling is a valuable technique to deploy.

## Wardley Mapping

Many engineering strategies implicitly make the assumption that the ecosystem we're operating within is static. However, that's certainly false. Many experienced engineers and engineering leaders have great judgment and great intuition, but nonetheless deploy a flawed strategy because they've anchored on their *memory* of how things work rather than noticing how things have changed over time.

If, rather than being hit over the head by these changes, you want to incorporate them into your strategy, Wardley mapping is a great tool to add to your kit.

Wardley maps allow you to plot users and their needs, and then study how the solutions to those needs will shift over time.

### LLM ecosystem example (Figure 8-2)

Today there is a proliferation of narrow platforms built on recent advances in LLMs, but studying a Wardley map of the LLM ecosystem (Figure 8-2, "Wardley map of large language model ecosystem") suggests it's likely this ecosystem will consolidate to fewer, broader platforms rather than remaining so widely scattered across distinct vendors.

### When to use it

If your strategy involves adopting a highly dynamic technology — such as observability in the 2010s — or if your strategy is intended to span five-plus years, then Wardley mapping will help surface how industry evolution will impact your approach.

## Antipatterns in Refinement

The chapter names three antipatterns.

### 1. Skipping refinement entirely (most frequent and most damning)

Already discussed in the "If It Matters, Why Is It Skipped?" section; it is the most frequent and most damning refinement antipattern. Example: at Calm, the team decomposed their monolithic codebase because that was what they saw similar companies doing around them. They had no reason to believe this was improving developer productivity, but continued to pursue the strategy for a year before recognizing they were suffering from skipping refinement.

### 2. Manufactured consent (second most common)

Creating the impression of strategy refinement through manufactured consent. A new senior leader joined Uber and mandated a complete technical rearchitecture, justifying it in part through the evidence that a number of internal leaders had successfully adopted the same techniques on their teams. When Larson spoke with those internal leaders, they themselves were skeptical that the proposal made sense, despite the fact that their surface-level agreement was being used to convince the wider organization that they believed in the new approach.

### 3. Discarding counterevidence to serve a side goal

Refinement often occurs, but counterevidence is then discarded because the refining team is optimizing for a side goal of some sort. Larson's first team at Yahoo! adopted Erlang for a key component of Yahoo! Build Your Own Search Service, which proved to be "an excellent solution to our problem of wanting to use Erlang, but a questionable solution to the core problem at hand." Only three of the engineers on the 15-person team were willing to touch the Erlang codebase, but that counterevidence was ignored because it conflicted with the side goal.

## Summary

The chapter introduced the concept of strategy refinement, surveyed three common refinement techniques — strategy testing, systems modeling, and Wardley mapping — and provided a framework for building your personal toolkit for refinement.
