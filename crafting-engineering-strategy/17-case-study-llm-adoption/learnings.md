# Chapter 17: LLM Adoption Strategy

This chapter is a Part IV case study: a complete set of engineering strategy documents written for a hypothetical company ("Theoretical Ride Sharing," 2,000 employees, 300 engineers, $400M raised, $50M revenue) deciding how to adopt LLMs. It demonstrates how strategy refinement techniques — systems modeling and Wardley mapping — let leaders find a reasonable path forward under the "impossible combination of urgency and uncertainty." The single most important takeaway: when a technology is hyped, unfamiliar, and rapidly evolving, optimize the strategy for *rate of learning* rather than commitment, and use models to find the actual constraint in your system before deciding where to apply the technology — because the intuitive interventions (faster coding, faster onboarding) often don't move the metric that matters at all.

## Core ideas

### Strategy under urgency plus uncertainty

In 2024, LLM adoption pressure was everywhere: most integrations were superficial, yet companies feared falling behind. Almost no teams or leaders had meaningful adoption experience, while industry pressure demanded broad, fast incorporation. The chapter's answer is not to resolve the uncertainty but to structure around it: bound the investment, mandate cheap experiments that generate learning, and schedule an explicit policy refresh (six months) to re-decide with better information. The why: internal expertise is the limiter on both problem selection and effective use of LLMs, so the highest-return first investment is expertise itself, not product bets.

### Three distinct needs; only one is differentiation

The diagnosis separates what people lump together as "adopt LLMs" into three needs:

1. **Productivity tools for non-engineers** (ad hoc rewriting, summarization)
2. **Productivity tools for engineers** (e.g., Copilot-style autocomplete)
3. **Product extensions** (e.g., document extraction in driver onboarding)

Only product extensions are potential *strategic differentiation*. The other two are workflow optimizations that improve productivity but "don't necessarily differentiate us from the broader industry." This distinction drives resource allocation: differentiation work gets modeled carefully and tied to the core business metric; workflow optimization gets a minimal mandated baseline ("at least one tool") whose purpose is learning, not advantage.

### Reversibility determines how careful you must be up front

Some decisions carry a strategic imperative to get them right from the beginning (the chapter's example: migrating AWS to Azure is very expensive due to customization and lock-in). LLM provider choice is *not* in that category: switching across foundational models is cheap economically and in integration cost, since APIs are largely consistent across providers. Therefore the company can pick one provider (Anthropic via existing AWS Bedrock) without anxiety, knowing the decision is revisable. A subtlety: model behavior varies over time even within one provider (GPT-3.5 allegedly got "lazier"), so the overhead of handling model behavioral differences is unavoidable even with a single model — meaning that overhead is not a reason to fear switching. The remaining switching friction is regulatory (updating data processing agreements), not technical.

### Foundational model economics

Training a competitive foundational model is prohibitively expensive ($3M–$100M+ and rising each generation: LLaMa 1 ~$3M, LLaMa 2 $20–30M, GPT-4 allegedly $100M) — out of the question for a company that raised $400M total. Larger models generally outperform smaller ones, so there is little incentive to train a small model unless you have a large unique dataset, and even then fine-tuning or in-context learning is probably better. Meanwhile inference is cheap (roughly $0.25–$60 per million input tokens; an English word averages ~1.3 tokens), so significant LLM work costs less than a startup's snack budget. On future capability (a debate the author likens to the ongoing argument over whether Moore's law has died): pure compute scaling will hit cost walls (few companies tolerate $1B training runs; $100B is unimaginable), but algorithmic and dataset improvements may continue progress. The only high-confidence prediction: model quality likely doubles one or two more times over three years, then either keeps doubling or plateaus — both outcomes are plausible, so the strategy must work in either world.

### Wardley map of the LLM ecosystem

LLMs are a proven platform now being applied widely to discover new patterns: RAG was the trending pattern of 2023, agents/agentic workflows of 2024, and more patterns are coming. Each pattern pushes product companies to stand up supporting infrastructure (e.g., search indexes for RAG), creating significant cost that market forces will likely absorb into productized offerings. Two questions define the space's evolution:

1. Will LLM framework platforms (agents, RAG, evals) stay bundled with model providers (OpenAI, Anthropic), or split into separately offered models and platforms?
2. Which framework elements are productizable short-term? Evals and basic agent support look straightforward to bundle; RAG looks bundleable but most production use cases need real-time updates, incurring the full complexity of scaled search clusters.

The mapped future: platforms decouple from model providers, with platforms licensing model access so companies needn't negotiate per provider. Given the richness of investment in the space, every plausible combination will likely exist to some degree until the ecosystem stabilizes in one dominant configuration. If the mapped future is correct, both pure model providers (limited to their own models) and narrow pattern platforms (servicing only some patterns) face headwinds. **The strategic conclusion: adopt the broadest LLM pattern platforms available, and explicitly decouple your pattern platform from your model provider.**

### Systems model 1: LLM impact on developer experience

A five-stock model of development (Open Tickets → Started Coding → Tested Code → Deployed Code → Closed Tickets) with three backward exception flows (testing finds error → back to coding; deployment exposes error → back to coding; production error → back to a new open ticket). Exercising it yields counterintuitive results:

- The system reaches an **equilibrium where closed tickets stop increasing**, because errors discovered in production keep recycling work back to the start.
- **Reducing the production error rate** (25% → 10%) shifts the equilibrium higher — real progress — though equilibrium still eventually returns. As long as error rate is a function of everything previously shipped, "we are eventually in trouble."
- **Tripling testing rate changes nothing** — at that point the immediate constraint is the rate of starting tickets, which motivates the next experiment — and **tripling both start and test rates creates noise but not progress**: more work in flight, same completed output. Relieving each apparent constraint only exposes the real one underneath, the production error discovery rate.

The constraint on this system is errors discovered in production. Any technique that changes anything else makes little impact, and "any approach that increases development velocity while also increasing production error rate is likely net-negative." A corollary insight: if an LLM tool works well, more time will be spent in the testing loop (more comprehensive tests catch more errors early), so **slower testing might be a successful outcome rather than a failure**. A skeptic might argue the opposite — that LLM tooling causes more issues to surface "late," after deployment, rather than early in testing. Either way, optimist and skeptic converge on the same measurement goal: reduce the errors-found-in-production flow. And a clear non-goal: don't penalize the testing-found-error flow, which should probably increase.

An idea outside the model: iterating more on fewer things may beat shipping more things, since multiple changes to one area still represent one feature's worth of production error surface, not many.

### Systems model 2: driver onboarding and reactivation

A seven-stock model of the driver lifecycle (City Population → Applied → Eligible → Onboarded → Active → Departed/Suspended) with three backward flows (request missing information; re-engage departed; remove suspension). Exercising it overturns the obvious assumption that faster onboarding grows the driver base:

- **Doubling the rate of qualifying applicants has little long-term impact on active drivers**; even *eliminating* the missing-information error flow barely matters. Once the city's applicant pool is exhausted, onboarding speed is irrelevant.
- **Raising departed-driver reactivation (5% → 20%) significantly raises the active-driver equilibrium.**
- Surprisingly, **raising suspended-driver reactivation (1% → 2.5%) has even higher impact**, because a slowly deflating stock accumulates a growing population of drivers over time. A small flow can matter more than its size suggests.
- **Increasing both reactivation rates beats increasing either alone**; if either is low, you lose an increasingly large pool of drivers over time.

The model's primary story: reactivating departed and suspended drivers is the only meaningful lever on active drivers. Other improvements (faster onboarding) may cut operating costs — worthwhile, but they don't solve the core problem. The conclusion is conditional on market maturity: while a city's applicant pool is untapped (early market entry), onboarding new drivers is essential; once the pool is exhausted, only reactivation moves the number — which is why the policy scopes the LLM reactivation work to *mature markets*. The why behind the whole exercise: the model determines *problem selection* for LLMs, which is exactly where limited expertise would otherwise lead intuition astray.

### Simple models beat complex models

The dev-experience model looks "embarrassingly simple" — the author admits that was his own first reaction. The instruction: recognize that feeling, then dig into whether it matters. The value of a model is in refining thinking, and simple models are usually more effective at refining a group's thinking than complex ones, simply because complex models are difficult to align a group around. Even a very simple model can expose counterintuitive insights — the kind that build conviction to push back where intuition misleads.

### Modeling tooling tradeoffs

Sketch first (e.g., Excalidraw): spreadsheet modeling is labor intensive, so iterate maximally in the sketch phase before touching the spreadsheet. Build one or two models in a spreadsheet to gain intuition for the underlying math, but spreadsheets are brittle, slow, hard to iterate on, and error-prone — even very smart people make spreadsheet errors, and catching them is exceptionally hard (the author left some errors unfixed because fixing them made the model harder to reason about). For real work, prefer a purpose-built tool (the author's `lethain/systems` library, whose emphasis on rapid development and reproducible, shareable models is somewhat unique among modeling techniques like spreadsheets and SageModeler). Key library distinction: `Leak(0.25)` moves 25% of a stock onward and keeps the rest; `Conversion(0.25)` (the meaning of a bare `@ 0.25`) converts 25% and *destroys* the unconverted remainder — choosing the wrong one silently changes model behavior.

### Document structure and reading order

The strategy uses the book's standard structure (Chapter 11), refactored for readability: Operation is folded into Policy, and Refine is embedded in Diagnose. To *apply* the strategy, read top to bottom (Policy → Diagnose → Explore). To *understand the thinking*, read in reverse: Explore first, then Diagnose, then Policy.

## Actionable guidance

- **Classify each proposed LLM use as strategic differentiation or workflow optimization before funding it.** Model the differentiation candidates against the core business metric; give workflow optimization a minimal mandated baseline.
- **Build a systems model to find the binding constraint before choosing where to apply LLMs.** Fund only interventions that move the constraint; expect intuitive interventions elsewhere to produce noise, not progress.
- **Optimize for learning when expertise is the limiter.** Mandate at least one LLM-backed tool per relevant team (one developer-productivity tool, one general ad hoc prompting tool for all employees), explicitly framed as developing conviction for next year's increase — or decrease — in investment.
- **Set an explicit refresh date for the policy** (here: six months) so the experiment has a built-in decision point.
- **Assess reversibility first.** If switching is cheap (as with LLM providers), pick one option and move; don't over-engineer for portability. If switching is expensive (cloud providers), invest in getting it right up front.
- **Start with a single model provider available through your existing cloud** (here: Anthropic via AWS Bedrock) when you judge foundational model quality to be roughly undifferentiated; avoid maintaining multiple implementations. Route exceptions through a named review forum.
- **Decouple your LLM pattern platform from your model provider, and prefer the broadest pattern platforms**, since narrow platforms and bundled model-provider frameworks both face headwinds if the ecosystem decouples as mapped.
- **Do not train your own foundational model** unless you have a large, unique dataset — and even then, prefer fine-tuning or in-context learning.
- **Define tool-success metrics from the model, not from intuition:** measure reduction in errors found in production, and measure end-to-end time from starting work to closing for tickets with no production error in their first 90 days. Do *not* treat increased testing time as failure — expect it to rise if the tool works.
- **Keep humans in the loop for high-stakes decisions; use LLMs to prioritize human attention.** Example rule: don't let an LLM approve suspension removals; let it surface the requests most likely to merit approval.
- **Embed operations into the policy:** name the reporting cadence and venue (monthly in the exec meeting), the exception-review forum, the vendor-approval channels, and where to flag questions.
- **Balance three criteria when reviewing new tool requests:** rate of learning, vendor cost, and data security.
- **Require internal tools that touch customer data to honor existing data-processing commitments**, and expect regulatory friction (data processing agreements) when switching model providers even though technical switching is cheap.
- **Modeling workflow:** sketch stocks and flows first; iterate in the sketch; model the left-to-right happy path before the right-to-left exception flows (exception flows are "where models get interesting"); put configuration values in a separate sheet/section so the model is easy to exercise; use literal values in the first row and formulas after; chart only the stocks, hiding intermediate calculation columns; use FLOOR if fractional tickets bother you (purely aesthetic, only matters with small starting values).
- **Exercise the model by changing one rate at a time** and watching which changes move the outcome, to identify the constraint.

## Pitfalls and misconceptions

- **Fear-of-falling-behind investing.** Most LLM integrations are superficial; very few companies use LLMs in scaled, differentiated ways despite "prolific thought leadership" to the contrary. A major investment before developing in-house expertise is high risk and low reward when no industry player has found a meaningful advantage.
- **"Conference-talk-driven development."** Widely discussed techniques are sometimes genuinely adopted, but other times platform vendors inflate the maturity of industry adoption. Don't calibrate your roadmap to conference talks.
- **Treating slower testing as tool failure.** If LLM tooling works, time in the testing loop should increase; the payoff is fewer expensive production errors. Judging the tool on testing speed will make you kill a success.
- **Believing faster shipping increases productivity.** When production error rate is a function of shipped volume, tripling development and testing velocity changes how much work you start but not how much you complete. Velocity gains that raise production error rates are likely net-negative.
- **Assuming the intuitive lever is the real one.** Faster driver onboarding "obviously" grows the driver base — the model shows it doesn't. Small flows (suspended-driver reactivation at 1%) can be the highest-impact lever.
- **Dismissing simple models.** The embarrassment of a simple model is a feeling to interrogate, not a verdict; simple models align groups and still surface counterintuitive insights.
- **Trusting spreadsheets for complex models.** They're brittle, error-prone, and errors are exceptionally hard to catch; use them once or twice for intuition, then move to better tools.
- **Confusing Leak with Conversion** in flow-rate modeling silently destroys stock and corrupts results.
- **Locking into bundled or narrow platforms.** Model providers can only offer their own models; narrow pattern platforms can only serve some patterns; both face headwinds if the ecosystem decouples.
