# Chapter 14: Systems Modeling

This chapter teaches systems modeling as a strategy *refinement* tool: building stock-and-flow models to cheaply test how a complex system behaves before committing to a strategy. The single most important takeaway: models create a cheap way to understand reality when fully understanding it would be too cumbersome — but the model is never reality, so the real risk is overconfidence in your model. Modeling is a tool to use in tandem with judgment, not a replacement for it.

## Core ideas

### Stocks and flows: the two-minute primer

- A **stock** is "anything that can accumulate" — each box in a model diagram (e.g., Requests, Server in the chapter's load-balancer example) is a stock.
- A **flow** is a change to a stock — every arrow between stocks (e.g., "OK", "Error in server") is a flow.
- **Systems modeling** is "the practice of using various configurations of stocks and flows to understand circumstances and behaviors that might otherwise be surprising or too slow to understand from measurement."

Why this matters: without a model, debates about complex systems devolve into philosophy ("how ridiculous that the downstream server is load-sensitive"). With a model, the dynamics become immediately visible (the load-sensitive server is obviously worth protecting via a throughput-capping load balancer, even if its sensitivity is concerning). Larson calls systems modeling "the most effective, flexible tool I've found to debug complex problems."

### The three scenarios where systems modeling is the right technique

1. **You're unsure where the leverage points are in a complex system.** Modeling lets you cheaply test which levers matter. (Modeling Uber's driver onboarding showed improving onboarding mattered less than reengaging departed drivers.)
2. **You have significant data to compare against.** Lots of real data lets you focus on the places where the data and the model are *in tension* — that tension is where learning happens.
3. **Stakeholders disagree based on unstated intuitions.** A model turns those intuitions into something structured that can be debated effectively.

In all three cases, the why is speed of iteration: modeling lets you iterate your thinking much faster than running a live process or technology experiment with your team. With practice, modeling can be faster than asking industry peers for advice — Larson's models for this book took under an hour each (except the LLM model, where he deliberately used an impractical tool).

### Models surface counterintuitive dynamics

A key value of modeling is exposing dimensions you wouldn't intuit. Example: a model of LLM impact on developer experience suggested effective LLMs might cause *more* time writing and testing code but *less* time fixing post-production issues. You might expect LLMs to reduce testing time, but the model shows reducing testing time is only valuable if production-discovered issues stay at worst constant — if production issues increase, cutting testing time does not increase productivity.

### Modeling needs praxis

"Modeling without praxis creates unsubstantiated conviction: true understanding comes from applying ideas to real situations." A model alone proves nothing; combine it with learning from applying the model, and few techniques accelerate learning as much.

### When NOT to use systems modeling (technique selection)

- If you're **already sure of your general approach** and want to refine narrow details → use **strategy testing** instead.
- If you're trying to **understand the evolution of a wider ecosystem** → use **Wardley mapping** instead.
- Systems modeling fits the middle: "you have the general shape but lack conviction on how the pieces fit together."

### Tooling: pick anything, then stop thinking about it

The tooling ecosystem is fragmented (perhaps because early tools were expensive; complex requirements, patent consolidation, and a perceived small market have also discouraged a modern solution from consolidating the market), and Larson suspects tooling quality — at least as much as lack of practice — is why many find modeling slow. Bad tooling is costly: building a model in a spreadsheet was slow, brittle, hard to extend, and bug-prone. Introductory tools (SageModeler, Insight Maker) tend to be constrained, high learning curve, or hard to share. Larson uses his own open source toolchain, `lethain/systems`, because it is: quick to create and iterate on models, easy to share, leaves little surface area for model bugs, free/open source/self-hosted, and integrates with the Jupyter ecosystem.

The decisive guidance: pick any tool that feels right, practice until you can model scenarios quickly, then stop thinking about tools. "The most important thing is to build models and learn from them quickly, and almost any tool will be sufficient for that goal with some deliberate practice."

### The five-step modeling process

1. **Sketch** the stocks and flows on paper or in a diagramming app (Excalidraw, Figma, Whimsical — whatever is comfortable).
2. **Reason** about how a potential change would shift the flows: which flows go up, which go down, and how would that movement let you evaluate whether your strategy is working?
3. **Model** the stocks and flows in your spreadsheet tool of choice (Larson's literal step — almost any tool you're fluent in works). Model left-to-right "happy path" flows first; only once those fully work, add the right-to-left "exception path" flows.
4. **Exercise** the model with different starting values to see how rates influence outcomes — essentially sensitivity analysis.
5. **Document** in a standalone writeup, linked from any strategy that benefits from the model's insights.

With experience, steps 1–4 collapse into a single iterative loop; document after several iterations, not before.

### Decouple models from strategy documents

Keep models in standalone writeups linked from strategies, not embedded in them. Why: "the details of any given model are a distraction from understanding a strategy." The link lets a reader who is *surprised by the conclusion* drill into the details; everyone else is spared them.

### How to document a model

The core problem: model readers split into distinct groups — some lack familiarity with your tooling; others will dig into the details to refine or invalidate the model. Write first for the audience least likely to dig in; keep raw details available (ideally in the rawest, manipulable form) as a secondary goal.

Recommended document order:
1. **Learning section** with charts showing what the model taught you (insights first).
2. **Sketch and explain** the stocks and flows.
3. **Reason about what the sketch itself teaches**.
4. **Explain how you developed the model**, emphasizing complex portions.
5. **Exercise the model**: show how changing flows and stocks changes outcomes.

The one rule to remember: "most people don't care how you built the model — they just want the insights." Give insights early, and assume no one will trust your model as much as you do. "Models are an input into a strategy, but never a reliable sole backer."

### What systems modeling isn't: three cautions against overcommitment

Many practitioners come to believe their models *are* reality rather than reflections of it. Three cautions:

1. **When your model and reality conflict, reality is always right.** Attachment to a model makes you look for reasons to disregard reality's lessons instead of engaging with them.
2. **Models are immutable, but reality isn't.** A model frozen at creation time can't detect that the bottleneck has moved (or was never where the model assumed).
3. **Every model omits information; some omit critical information.** A model can capture everything *your team* cares about while saying nothing about whether the overall endeavor is a good idea.

In each failure case, two things were simultaneously true: the model was extremely valuable, *and* it subtly led the team astray — and the team would have been led astray even without a model. The lesson isn't that models are inherently misleading; "the real risk is being overly confident about your model."

### Further resources for deeper exploration

- *Thinking in Systems: A Primer* by Donella Meadows (Chelsea Green, 2008) — the exceptional introduction, and where Larson first learned the technique.
- Larson's essay "Introduction to Systems Thinking" (also in *An Elegant Puzzle*, Stripe Press, 2019) — a shorter, "worse" introduction by his own admission.
- *Business Dynamics: Systems Thinking and Modeling for a Complex World* by John D. Sterman (McGraw-Hill, 2000).
- *An Introduction to Systems Thinking* by Barry Richmond (Isee Systems, 2004).
- More worked models in the systems-thinking category of Larson's blog.

## Actionable guidance

- Reach for systems modeling when: you don't know where the leverage points are, you have real data to test the model against, or stakeholder disagreement is rooted in unstated intuitions.
- Don't use it when you're already confident in the approach (use strategy testing) or studying ecosystem evolution (use Wardley mapping).
- Pick one modeling tool, practice until you can model scenarios quickly, then stop evaluating tools. Avoid spreadsheets for nontrivial models: they're brittle, hard to extend, and breed bugs.
- Follow the sequence: sketch → reason about expected flow shifts → model happy-path flows left-to-right first, then exception paths → run sensitivity analysis with varied starting values → document standalone.
- Before building the numeric model, predict which flows a change should move up or down and decide how that movement would tell you whether the strategy works.
- Publish each model as a standalone document; link to it from strategies rather than inlining it.
- Structure model writeups insights-first: learnings and charts at the top, methodology last. Write for readers who won't open the model; keep raw artifacts available for those who will.
- Pair every model with praxis: apply its predictions to real situations and update when reality disagrees.
- When model and data are in tension, treat the tension as the signal — investigate it rather than explaining it away.
- Treat models as one input to strategy among several, never the sole justification.
- Periodically re-derive your model rather than continuing to optimize against an old one; the constraint may have moved.
- Explicitly ask what your model omits, especially second-order consequences of succeeding (e.g., what happens *after* the migration completes).

## Pitfalls and misconceptions

- **"Modeling slows things down."** Partly a familiarity problem — the models Larson built for this book took under an hour each — but Larson suspects tooling quality is "at least as big a part" of why modeling feels slow and laborious.
- **Believing the model is reality.** The chapter's central warning. Symptoms: spending effort collecting and classifying data to feed the model instead of attacking the most important problems; defending the model against contradicting evidence.
- **Optimizing a stale model.** Years spent tuning a hiring funnel's top and close stages while the actual blocker (interviewer misalignment) sat outside the model entirely.
- **Scoping the model to your team's concerns.** A model can correctly drive your team's success while omitting whether the broader effort is worthwhile.
- **Reducing a flow without checking coupled flows.** E.g., cutting testing time only helps if production issues don't rise.
- **Modeling without applying the lessons** ("unsubstantiated conviction").
- **Front-loading methodology in writeups.** Readers want insights, not construction details; burying insights loses the primary audience.
- **Over-trusting tool ergonomics.** Bad tooling (e.g., spreadsheets) silently introduces model bugs and blocks extension and iteration.
