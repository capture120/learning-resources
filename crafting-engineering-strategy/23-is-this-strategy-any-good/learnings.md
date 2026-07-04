# Chapter 23: Is This Strategy Any Good?

This chapter gives a structured way to judge strategy quality, moving beyond a binary "good strategy / bad strategy" verdict to a nuanced, phase-aware assessment. The single most important takeaway: evaluate a strategy on three dimensions — how quickly it can be refined (Speed), how cheaply it can be refined (Cost), and how well its current iteration solves its diagnosis (Impact) — and re-run that evaluation per phase, because even excellent strategies degrade as new information renders their diagnosis incomplete.

## Core ideas

### Format predicts quality; it is not quality

You can judge a strategy's format and construction, and both are useful signals. But "format is a predictor of quality, not quality itself." A well-structured document can still be a bad strategy, so you need a separate method for assessing whether a strategy is actually good.

### Why grading on outputs alone fails

Grading strategy by its results is the industry's most prevalent approach, and results genuinely matter more than anything else. But outputs alone fail in two ways:

1. **No counterfactual.** Outputs don't let you distinguish how much better your results are *because of* the strategy versus the expected outcome without it. When Google succeeds with service architectures, copying them doesn't transfer the success — it did not work particularly well for most adopters. Similarly, a strategy can "succeed" while an alternative path would have succeeded better, and outputs can't tell you which path was the better strategy.
2. **Hidden cost.** Some strategies succeed at unreasonably high cost. A strategy worth its cost in one era can become too expensive to maintain as circumstances change (e.g., regulatory overhead accumulating around a no-deprecations policy). A "successful" strategy maintained past the point where its costs accumulate will likely fail.

### Why grading on inputs alone also fails

Confronting the problems with output-grading makes it compelling to switch to the opposite lens — "as long as the sum of the strategy's parts makes sense, it's a good strategy, even if it doesn't accomplish its goals." This lens is appealing because it appears to focus purely on how much better your results are because of your strategy — the very counterfactual that outputs can't isolate. But it is similarly deficient. A strategy rooted in a proper diagnosis with effective policies can still be a bad strategy if it loses to competitors in practice. "Doing good strategy requires reconciling the theoretical with the practical." The author's decisive distinction: if a conceptually sound strategy is struggling to make an impact, its authors should keep refining it; if they take a single pass and ignore subsequent evidence that it's not working, "it's a failed strategy, regardless of how thoughtful the first pass was."

### The three-question rubric (Speed, Cost, Impact)

A lightweight rubric balancing the strengths and flaws of the output and input lenses. Score each question 0–3, sum to 0–9.

**Speed — How quickly can the strategy be refined?**
A strategy that starts bad but improves quickly beats a mostly right strategy that never evolves. "Strategy thrives when its practitioners understand it is a living endeavor."
- 3 points: facilitates daily or weekly iteration
- 2 points: monthly iteration
- 1 point: quarterly iteration
- 0 points: anything longer

**Cost — How expensive will it be to refine the strategy, especially in cross-team impact?**
"Just as culture eats strategy for breakfast, good policy loses to poor operational mechanisms every time." Early on especially, good strategy should be validated cheaply; expensive strategies are often discarded before they can be validated, let alone improved.
- 3 points: implementable by a cross-team working group or a single team
- 2 points: small cross-team dependencies
- 1 point: large cross-team dependencies with flexible timing
- 0 points: large cross-team dependencies with rigid timing

**Impact — How well does the current iteration solve its diagnosis?**
Even if you're learning quickly and cheaply, at some point you must actually make changes; strategy must eventually be graded on its impact against the diagnosis it starts from.
- 3 points: directly solves the full problem
- 2 points: solves the most difficult or essential portion
- 1 point: solves a simple portion
- 0 points: otherwise

**Interpretation:** a score of 6 or higher is a high-quality strategy worth pursuing. Lower scores should trigger strong introspection about whether this is an effective path forward.

### Strategies exist across phases

The final component of the rubric: strategy quality is not a single fixed grade, because strategy exists across multiple phases. "Each phase is defined by new information — whether or not this information is known by the strategy's authors — that renders the diagnosis incomplete." A strategy that scores 7 in its first phase can degrade to 4 in a later phase as the environment it created generates new problems. Both judgments are correct for their phases: a high early rating remains appropriate even when later challenges are real.

Why this matters: "Very effective strategies are particularly prone to difficult phases after their initial rollout, because it's impossible to foresee and prevent every possible challenge ahead of time." The conclusion — "strategy work never ends" — is both the bad news and the good news.

### Stopping a strategy is often a sign of a good strategist

Abandoning a strategy does not mean it was a bad strategy. Your diagnosis can evolve in ways that make abandonment appropriate; circumstances change (a company that owned its own servers in 2010 certainly wouldn't have bought them had it started a decade later). Aborting a strategy in its first phase is generally a good sign "when the rate of learning is outpaced by the cost of learning."

The deeper principle: all strategies compete with strategies at other altitudes, so giving up on strategies — especially high-altitude ones — is almost always a good idea. High-altitude (executive-owned) strategy carries a high opportunity cost, so explicitly return ownership to lower-altitude strategy unless there's a proven, highly impactful strategy that justifies operating above it.

### The unpierceable veil: you cannot evaluate other companies' strategies

It's generally impossible to accurately evaluate strategies happening inside other companies. The exploration step of strategy can identify where another company's strategy might be useful to you, but it cannot tell you after the fact whether that strategy or its strategists were effective. Too many rubric dimensions are invisible from outside: how many phases preceded the publicly visible idea, what the early stages cost, whether the real mastery lies in operational mechanisms never reported externally, and whether the public account (e.g., a blog post about a transformation) is real or recruiting material. You will still be forced to evaluate competitors' strategies in your own strategy work — the point is not to skip the attempt, but not to invest too much confidence in those appraisals, because "you're guaranteed to be missing something."

### You can learn as much from failed strategies as from successful ones

Judging quality matters, but a poor strategy is still a rich learning source — provided you are aware of its quality. Two reasons: even failed strategies have early phases that work extremely well, and strategies tend to fail for interesting reasons. The required precondition is a clear point of view on which strategies worked; without it, you risk learning the wrong lessons from a failure you mistook for a success.

Once a strategy is determined unsuccessful, diagnose *where* it failed: at which phase, and at which strategy step. Was it missing operational mechanisms? A policy poorly matched to the diagnosis? A diagnosis willfully ignorant of a real problem (such as an obstinate executive)? Answering these questions teaches you more than studying only successes, because it builds intuition for which parts of strategy truly matter.

## Actionable guidance

- Score any strategy you're evaluating on the three rubric questions (Speed, Cost, Impact), each 0–3. Pursue strategies scoring 6+; treat lower scores as a trigger for serious introspection, not automatic abandonment.
- Treat strategy as a living endeavor: design for fast iteration loops (daily/weekly beats quarterly) rather than aiming to be right in one pass.
- Validate strategy cheaply, especially early. Prefer designs implementable by a single team or working group; avoid large cross-team dependencies with rigid timing, which kill strategies before they can be validated.
- Re-score the strategy whenever new information renders the diagnosis incomplete — that's a new phase. Don't let a strong phase-1 score blind you to a degraded phase-2 score, and don't let phase-2 problems retroactively condemn a phase-1 success.
- When a conceptually sound strategy isn't landing, refine it; do not declare victory on inputs. Ignoring evidence that it's not working makes it a failed strategy regardless of how thoughtful it was.
- Abandon a strategy when the cost of learning outpaces the rate of learning. For high-altitude strategies, default to giving ownership back to lower-altitude, team-owned strategies unless your strategy is proven and highly impactful.
- When evaluating competitors' strategies (which your own strategy work will force you to do), hold conclusions loosely. Ask what you can't see: hidden phases, hidden costs, unreported operational mechanisms, and the gap between the public narrative and reality.
- After deciding a strategy failed, run a post-mortem locating the failure: which phase, and which step (diagnosis, policy, or operational mechanisms). Use the answer to build intuition for which parts of strategy matter most.
- Use the assessment diagnostically to improve your own work: maybe your approach is sound but your operational mechanisms are too costly for the rate of learning they facilitate; maybe you've treated strategy as a single-iteration exercise rather than recognizing that even excellent strategy goes stale over time.

## Pitfalls and misconceptions

- **Copying outputs:** adopting another company's strategy because it worked for them (e.g., Google-style service architectures) ignores the missing counterfactual; it did not work particularly well for most adopters.
- **Grading purely on outputs:** can't separate strategy-driven results from baseline expectations, and ignores strategies that succeed at unsustainable cost.
- **Grading purely on inputs:** a theoretically sound strategy that loses in practice is not a great strategy. Single-pass strategy that ignores feedback is failed strategy.
- **Treating quality as a single permanent grade:** strategies degrade across phases; effective strategies are especially prone to painful post-rollout phases.
- **Reading abandonment as failure:** stopping a strategy — especially a high-altitude one — is often the correct, skilled move.
- **Overconfident external evaluation:** the missing context behind other companies' strategies is an impenetrable veil; don't invest too much confidence in appraisals from outside.
- **Learning from failures without knowing they're failures:** studying a failed strategy as if it succeeded teaches the wrong lessons. Establish quality first, then extract lessons.
