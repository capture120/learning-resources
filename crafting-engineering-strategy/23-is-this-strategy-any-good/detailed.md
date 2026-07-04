# Chapter 23: Is This Strategy Any Good? — Detailed Reference

## Introduction (unlabeled chapter opening)

By this point in the book, the reader has read a lot of strategy and can judge a strategy's format and its construction — both useful skills. However, "format is a predictor of quality, not quality itself." That gap raises the chapter's central question: how should you assess whether a particular strategy is actually any good?

The motivating puzzle is Uber's service migration strategy (Document 16-1, from Chapter 16). That strategy unblocked the entire organization, allowing it to make rapid progress. It also led to a sprawling architecture problem down the line. Was it a great strategy or a terrible one? Reasonable people will disagree, but Larson argues it's worthwhile to develop a point of view on why you should prefer one interpretation or the other.

The chapter's stated focus, in order:

- Common techniques for evaluating strategies
- A rubric for evaluating strategies in phases
- Why ending a strategy is often a sign of a good strategist
- The problem with evaluating other companies' strategies
- Why you can learn just as much from bad strategies as from good ones

The framing for the chapter: "Time to refine your judgment about strategy quality."

## How Are Strategies Evaluated Across the Industry?

Before proposing his own rubric, Larson surveys how the software industry evaluates strategies in practice. He doesn't particularly agree with these approaches — he thinks each misses at least one important nuance — but understanding their flaws is the foundation his rubric builds on. The two approaches covered are grading on outputs and grading on inputs.

### Grading on outputs

Grading strategy on its outputs is by far the most prevalent approach in the industry, and it does make sense on its face: a strategy's results are more important than anything else. However, as appealing as this is, the line of thinking can go awry, as the section documents:

1. **Copying without a counterfactual.** When massive companies like Google do things like move to service architectures, other companies copy them, reasoning that if it worked for Google, it'll likely work for them. As discussed in Chapter 20, however, it did not work particularly well for most adopters. The underlying flaw: looking only at outputs doesn't let you distinguish between how much better your results are *because of* your strategy versus the expected outcome if you hadn't used the strategy at all.

2. **Indistinguishable alternatives.** Acquiring Index allowed Stripe to build a point-of-sale business line (see Chapter 22), but Stripe was also on track to build that business internally. Looking only at outputs can't help distinguish whether it would have been better to build the business via acquisition or internally — yet one of those paths must have been the better strategy.

3. **Success at unreasonable cost.** Some strategies succeed, but at unreasonably high costs. Stripe's API deprecation strategy (Document 22-2) is the example: it was extremely well worth the cost for the company's first decade, but eventually became too expensive to maintain as the evolving regulatory environment created more overhead. Fortunately, Stripe modified its strategy to allow some deprecations — but if the company had attempted to maintain its original strategy, it would likely have failed due to its accumulating costs.

### Grading on inputs

Confronted with these problems, it's compelling to switch to the opposite lens and evaluate strategies purely on their inputs: as long as the sum of the strategy's parts makes sense, it's a good strategy, even if it doesn't accomplish its goals. This approach is appealing because it appears to focus purely on how much better your results are because of your strategy — exactly the counterfactual that output-grading can't isolate.

Larson finds this view similarly deficient. Example: the strategy in Document 17-1 (Chapter 17) offers a cautious approach to adopting LLMs. If that company loses significant revenue because its competitors better incorporate LLMs, Larson argues this strategy isn't a great one — even if it's rooted in a proper diagnosis and effective policies. The principle: "Doing good strategy requires reconciling the theoretical with the practical," so inputs alone aren't enough to evaluate strategy work.

The decisive distinction within the inputs critique: if a strategy is conceptually sound but struggling to make an impact, then its authors should continue to refine it. If its authors take a single pass and ignore subsequent information that it's not working, then it's a failed strategy, "regardless of how thoughtful the first pass was."

### Building on both

While both mechanisms are incomplete, they're still instructive. Incorporating bits of each gets "surprisingly close" to a rubric that avoids these particular downfalls — which is the next section's contribution.

## A Rubric for Evaluating Strategy

The lightweight rubric Larson has found effective for evaluating strategy attempts to balance the strengths and flaws of the output and input lenses. It consists of three questions, each scored 0–3 points.

### Question 1 — Speed: How quickly can the strategy be refined?

Rationale: if a strategy starts out bad but improves quickly, that's a better strategy than a mostly right strategy that never evolves. "Strategy thrives when its practitioners understand it is a living endeavor."

Scoring:

| Points | Criterion |
| --- | --- |
| 3 | The strategy facilitates daily or weekly iteration |
| 2 | Monthly iteration |
| 1 | Quarterly iteration |
| 0 | Anything that requires longer periods of time |

### Question 2 — Cost: How expensive will it be to refine the strategy, especially in terms of cross-team impact?

Rationale: "Just as culture eats strategy for breakfast, good policy loses to poor operational mechanisms every time." Especially early on, good strategy should be validated cheaply. Expensive strategies are often discarded before they can be validated, let alone improved.

Scoring:

| Points | Criterion |
| --- | --- |
| 3 | The strategy can be implemented by a cross-team working group or within a single team |
| 2 | Small cross-team dependencies |
| 1 | Large cross-team dependencies with flexible timing |
| 0 | Anything with large cross-team dependencies with rigid timing |

### Question 3 — Impact: How well does the current iteration of the strategy solve its diagnosis?

Rationale: ultimately, strategy does have to address the diagnosis it starts from. Even if you're learning quickly and at a low cost, at some point you do have to actually make changes. Strategy must eventually be graded on its impact.

Scoring:

| Points | Criterion |
| --- | --- |
| 3 | The strategy directly solves the full problem at hand |
| 2 | The strategy solves the most difficult or essential portion |
| 1 | The strategy solves a simple portion |
| 0 | Otherwise |

### Interpreting the total

Add the points; totals range from 0 to 9. Any strategy with a score of **6 or higher** is a high-quality strategy that Larson would encourage pursuing. Lower scores should trigger "some strong introspection" on whether this is an effective path forward.

### Worked example: scoring Uber's service migration strategy (Phase 1)

With the rubric in hand, the chapter finally assesses Uber's service migration strategy:

- **Speed: 3 points.** The approach supported daily iteration by starting with structured requests that provided an interface the team could rapidly iterate behind.
- **Cost: 2 points.** The platform and integration could mostly be implemented by a single team. Migrating an existing service did require coordination with existing teams, but on a flexible schedule.
- **Impact: 2 points.** Supporting the high volume of requests for new services created the most pressing problem; addressing it incrementally freed up time to work on moving the biggest existing services.

Total: **7**, which is quite good.

### Strategy exists across multiple phases

The high score raises an interesting question: the Uber strategy worked exceptionally well initially but created a great deal of long-term problems as the number of services grew. Does that mean it really wasn't a good strategy after all?

The idea that strategies can start out good but degrade over time motivates the final component of the strategy quality rubric: the recognition that **strategy exists across multiple phases**. Each phase is defined by new information — "whether or not this information is known by the strategy's authors" — that renders the diagnosis incomplete.

The Uber strategy is best understood as existing across two phases:

- **Phase 1** used service provisioning to address developer productivity challenges in the monolith.
- **Phase 2** engaged with the consequences of a sprawling service architecture.

### Worked example: scoring Uber's strategy in Phase 2

Evaluating the second phase — where the service provisioning platform was wholly adopted and engineers needed to build complex systems on top of it — generates a very different evaluation:

- **Speed: 1 point.** Changes within a given service happen on a daily basis, but changes across services are quite challenging and can take quarters to accomplish.
- **Cost: 1 point.** Any significant service architecture change requires coordination across numerous teams — sometimes many dozens of teams — even for a relatively straightforward change.
- **Impact: 2 points.** The service provisioning problem is wholly solved, but operating those provisioned services is challenging at scale.

In this second phase, the judgment of 7 has degraded to **4**. The high rating in the first phase is still appropriate, but the second phase's challenges are real as well.

A general warning follows: very effective strategies are *particularly* prone to difficult phases after their initial rollout, because it's impossible to foresee and prevent every possible challenge ahead of time. The section closes: "The bad news is that strategy work never ends. That's the good news, too."

## Does Stopping a Strategy Mean It's a Bad Strategy?

With the rubric established, the chapter uses it to evaluate an important question: does giving up on a strategy mean that the strategy is a bad one?

The vocabulary of strategy phases helps here. Larson considers it uncontroversial that your prior diagnosis might evolve in ways that make it appropriate to abandon a strategy. Example: Digg owned its own servers in 2010, but would certainly not have bought its own servers if it had started 10 years later. Circumstances change.

Sometimes aborting a strategy in its first phase is actually a *good sign*. That's generally true "when the rate of learning is outpaced by the cost of learning." Larson's personal example: he recently sponsored a developer-productivity strategy that had some impact, but less than intended. The organization adopted a few of the smaller pieces, and then returned to exploring a lower-altitude strategy owned by the teams, rather than the high-altitude strategy that he owned as an executive.

The general principle: essentially, all strategies are competing with strategies at other altitudes, so Larson thinks giving up on strategies — especially high-altitude strategies — is "almost always a good idea." The opportunity cost of high-altitude strategy is high, so Larson recommends explicitly giving ownership back to lower-altitude strategy unless there's a proven, highly impactful strategy to push above it.

## The Unpierceable Veil

Working within the industry, engineers are often called upon to evaluate strategies from afar. As other companies rolled out LLMs in their products or microservices for their architectures, engineers' own companies pushed them on why they weren't making these changes as well. The exploration step of strategy helps determine where another company's strategy might be useful for you, but even that doesn't really help you evaluate, after the fact, whether the other company's strategy or strategists were effective.

There are simply too many dimensions of the rubric that you cannot evaluate from the outside. The chapter lists the unanswerable questions:

- How many phases did your competitors go through before they arrived at the idea that became the external representation of the strategy?
- How much did those early stages cost to implement?
- Is the real mastery in the operational mechanisms that are never reported on outside the organization?
- Is the blog post they wrote about their magical transformation real, or just something they put together to attract potential hires?

Conclusion: it's generally impossible to evaluate strategies happening in other companies accurately or with much conviction. Even if you want to, the missing context is "an impenetrable veil."

Qualification: this is *not* a reason to avoid evaluating competitors' strategies — that's something you'll be forced to do in your own strategy work. Instead, it's a reminder not to invest too much confidence in those appraisals: "you're guaranteed to be missing something."

## Learning from Failed Strategies

Although Larson believes it's valuable to judge the quality of strategies, he cautions against concluding that you can't learn from poor strategies. As long as you are *aware of its quality*, you can learn just as much from a strategy's failure as from its success.

Two supporting reasons:

1. Even failed strategies have early phases that work extremely well.
2. Strategies tend to fail for interesting reasons.

His personal example: he learned just as much from Stripe's failed rollout of Agile — which struggled due to missing operational mechanisms — as he did from Calm's successful transition to focusing primarily on product engineering. The precondition matters: without a clear point of view on which of these worked, you'd be at risk of learning the wrong lessons. With forewarning, you don't run that risk.

Once you've determined that a strategy has been unsuccessful, it's particularly valuable to determine **at which phase** and **where in the strategy steps** things went wrong. The diagnostic questions to ask:

- Was it a lack of operational mechanisms?
- Was the policy itself a poor match for the diagnosis?
- Was the diagnosis willfully ignorant of a problem, like a truculent executive?

Answering these questions will teach you more about strategy than only studying successful strategies, because you'll develop an intuition for which parts truly matter.

## Summary

Finishing the chapter, the reader has a structured rubric for evaluating a strategy, moving beyond "good strategy" and "bad strategy" to a nuanced assessment. The assessment is not just useful for grading strategy; it also makes it possible to specifically improve your own strategy work. Two closing diagnostic prompts:

- Maybe your approach is sound, but your operational mechanisms are too costly for the rate of learning they facilitate.
- Maybe you've treated strategy as a single-iteration exercise, rather than recognizing that even excellent strategy goes stale over time.

The chapter ends by pointing to the next chapter, on how you personally can get better at strategy work.
