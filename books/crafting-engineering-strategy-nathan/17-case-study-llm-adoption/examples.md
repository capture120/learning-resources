# Chapter 17: LLM Adoption Strategy — Examples

This chapter is itself a worked example: four strategy documents written for a hypothetical company deciding how to adopt LLMs. The sections below capture the concrete company, the actual policies chosen, the diagnosis and exploration specifics, both systems models, and the supporting real-world anecdotes.

## The company: Theoretical Ride Sharing

A hypothetical ride-sharing business similar to Uber or Lyft, whose innovation is using larger vehicles — essentially reinventing public transit. It has 2,000 employees (300 software engineers), has raised $400 million, does $50 million in annual revenue, and operates in 200 cities across North America and Europe. Written in 2024, when LLM adoption pressure was high and experienced adopters were rare.
Illustrates: a realistic mid-size company context where LLM hype meets limited internal expertise.

## The adopted policy (Document 17-1)

The combined policy has six elements, each with a named operational mechanism:

1. **Develop an LLM-backed process for reactivating departed and suspended drivers in mature markets.** Modeling the driver lifecycle showed onboarding speed has little impact on active drivers; reactivation is "the only opportunity to meaningfully impact active drivers." Progress reported monthly in the Exec Weekly Meeting, coordinated in #exec-weekly.
2. **Start with Anthropic**, via the existing cloud provider through AWS Bedrock. Since foundational model quality is viewed as roughly undifferentiated, the company avoids maintaining multiple implementations and doesn't adopt a broad set of LLMs. Anchored in the Wardley map. Exceptions reviewed by the Machine Learning Review in #ml-review.
3. **The Developer Experience team must offer at least one LLM-backed developer productivity tool** for TypeScript, available to all engineers, to build conviction for increasing (or decreasing) next year's investment. One tool is the required baseline; further tools (e.g., GitHub Copilot) can be brought to the Engineering Exec team, reviewed on rate of learning, vendor cost, and data security. Vendor approvals reviewed in #cto.
4. **The Internal Tools team must offer at least one LLM-backed ad hoc prompting tool** for arbitrary non-engineering uses (text extraction, rewriting notes), usable with customer data while honoring existing data-processing commitments, available to all employees. Vendor approvals reviewed in #coo.
5. **Refresh the policy in six months.** The primary goal is to quickly learn about an unfamiliar domain with limited internal expertise, then review whether to increase investment.
6. **Flag questions and suggestions in #cto.**

Illustrates: a learning-optimized, reversibility-aware policy with operations (cadence, channels, review forums) embedded directly in each policy item.

## The diagnosis specifics (Document 17-1)

The diagnosis names the key tensions: three distinct internal asks (non-engineer productivity, engineer productivity, product extensions), of which only product extensions could be strategic differentiation. Candidate differentiators: reactivating departed/suspended drivers (the largest lever per the lifecycle model), faster driver onboarding with less human involvement (cuts operating costs but won't increase active drivers), and improved customer support response speed and quality. The company has limited LLM expertise — as does the industry, despite "prolific thought leadership." It wants expertise without irreversible commitment, since a major pre-expertise investment is relatively high risk and low reward. Switching model providers is cheap technically and economically. The ecosystem's evolution is genuinely unknowable — current providers will likely train one or two more model generations before training becomes cost-prohibitive, after which differentiation might move into developer experience, or open source models like LLaMa might become significantly cost-advantaged, "or something else entirely." Training a foundational model ($3M–$100M to match Anthropic/OpenAI general models) is prohibitive for a company that raised $400M total.
Illustrates: a diagnosis that separates differentiation from optimization and grounds the policy in expertise limits, reversibility, and cost realities.

## Foundational model training costs (Explore)

Meta allegedly spent $20–30 million training LLaMa 2, up from about $3 million for LLaMa 1. OpenAI's GPT-4 allegedly cost $100 million. Costs grow each generation; next major versions seemed likely to cost $500M+. Few companies can tolerate $1B training runs, fewer $10B, and a $100B model is hard to imagine — so it's unlikely models can keep improving merely through more compute spending, though algorithmic and dataset improvements may continue progress. The high-confidence prediction: one or two more doublings over three years, then either continued doubling or a plateau — both plausible.
Illustrates: why "train our own model" is off the table and why the strategy must work whether models keep improving or plateau.

## Inference is cheap (Explore)

Anthropic charged $0.25–$15 per million input tokens, OpenAI $0.50–$60, output a bit more. The average English word is about 1.3 tokens, so "you can do a significant amount of LLM work while spending less than most venture-funded startups spend on snacks."
Illustrates: the cost asymmetry — training is prohibitive, but usage is nearly free at experiment scale.

## AWS-to-Azure versus LLM provider switching (Explore)

Migrating from AWS to Azure is very expensive due to customization and lock-in, so cloud choice must be right from the beginning. LLM providers are the opposite: industry peers experiment freely across Anthropic, OpenAI, and Mistral because APIs are largely consistent and financial commitment is low. The remaining friction is regulatory — updating data processing agreements.
Illustrates: reversibility analysis determining how much up-front rigor a decision deserves.

## GPT-3.5 getting "lazier" (Explore)

Model behavior varies across providers, but it also varies over time within one model — GPT-3.5 allegedly got "lazier." So the overhead of handling model behavioral differences is unavoidable even with a single provider.
Illustrates: why standardizing on one provider doesn't eliminate model-variance work, and why evals matter.

## Stripe and Uber's LLM adoption (Explore)

Stripe invested heavily in LLMs for internal productivity — presumably including tasks previously done by employees, like verifying a company's website matches its onboarding application details — but had not clearly shifted its product or user experience with LLMs. Uber similarly adopted LLMs for internal developer and operations productivity (documented in its August 2023 and May 2024 engineering posts), with no breakout ride-sharing-specific product approach.
Illustrates: even sophisticated scaled companies had found internal-productivity wins but no differentiated product advantage — evidence against rushing a big bet.

## Systems model: LLM impact on developer experience (Document 17-2)

Five stocks model a developer workflow: Open Tickets → Started Coding → Tested Code → Deployed Code → Closed Tickets, with three backward flows: testing found error (back to Started Coding), deployment exposed error (back to Started Coding), and error found in production (all the way back to a new open ticket). Built first as an Excalidraw sketch, then implemented in Google Sheets with three worksheets (Model, Charts, Config), modeling left-to-right happy-path flows first, then right-to-left exception flows as percentage flows, with a percentage of the target stock triggering the error condition (e.g., 25% of closed tickets surface a production bug each round).

Exercising it: the baseline shows closed tickets quickly stop increasing — an equilibrium between production errors and shipped work. Cutting the production error rate from 25% to 10% raises the equilibrium (real progress) but doesn't eliminate it. Tripling the testing rate changes nothing, because at that point the constraint is the rate of starting tickets — which motivates also tripling the start-coding rate. Tripling both start and test rates changes how much work is in flight but not how much completes: "starting or testing tickets faster creates noise but not progress." Conclusion: the constraint is errors discovered in production; the only meaningful productivity lever is reducing that rate.
Illustrates: a deliberately simple model exposing the counterintuitive insight that velocity tooling which raises production error rates is likely net-negative, and that slower testing can be a success signal.

## The "embarrassingly simple" model reaction

The author admits his first reaction to his own five-stock sketch was that it was embarrassingly simple. The lesson he draws: recognize the feeling, then check whether it matters. The model went on to reveal that increased testing time would look like tool failure but actually signal success — exactly the misjudgment the model helps a team avoid.
Illustrates: simple models usually refine group thinking better than complex ones, which are hard to align a group around.

## Spreadsheet modeling's hidden errors

While building the Google Sheets model, several errors became evident. Some were fixed easily; others were deliberately left unfixed because fixing them made the model harder to reason about. The author's conclusion: build one or two spreadsheet models to internalize the math, but choose almost any other tool for complex models — even very smart people make spreadsheet errors, and catching them is exceptionally hard.
Illustrates: why spreadsheets are a teaching tool, not a production modeling tool.

## Wardley map of the LLM ecosystem (Document 17-3)

RAG was the trending pattern of 2023, agents the pattern of 2024, with more patterns coming; each drives product companies to fund supporting infrastructure (e.g., search indexes for RAG). Two questions define the future: will pattern platforms stay bundled with model providers or decouple, and which framework elements (evals, agent support, RAG) are productizable short-term? The map drawn imagines platforms decoupling from providers and licensing model access on companies' behalf, with most non-RAG functionality bundled into platforms — RAG resists bundling because production use needs real-time updates and scaled search clusters. If correct, both model providers and narrow platforms face headwinds, so the best bet is adopting the broadest pattern platforms and explicitly decoupling platform from provider. The map's users: Product Engineers (want fast paths through evolving patterns), Machine Learning Infrastructure (steers adoption, owns shared elements like search indexes), and Security and Compliance (safe hosting, approved data only, evolving AI risk requirements). The author notes he artificially consolidated teams (Finance omitted; Security and Compliance merged; ML Infrastructure could split) and that different questions justify different groupings.
Illustrates: Wardley mapping turning ecosystem uncertainty into a concrete procurement stance, and tailoring map granularity to the question asked.

## Systems model: driver onboarding (Document 17-4)

Seven stocks model one city's driver lifecycle: City Population (10,000) → Applied Drivers (100/round) → Eligible Drivers (25% leak) → Onboarded Drivers (25% leak) → Active Drivers (50% leak), with Active Drivers draining 10% each to Departed (voluntary) and Suspended (involuntary). Backward flows: request missing information (10% of Eligible back to Applied), re-engage (5% of Departed return), remove suspension (1% of Suspended return). Built with the author's `lethain/systems` library (model and visualizations in the lethain/eng-strategy-models JupyterHub notebook; Graphviz export can combine sketching and modeling into a single step, though the generated diagrams are generally harder to read than a custom-drawn sketch).

Exercising it: the base model stabilizes around 800 active drivers after exhausting the city's applicant pool. Doubling eligibility qualification (25% to 50%) barely changes long-term active drivers; even deleting the missing-information flow entirely has little impact. Raising departed-driver re-engagement from 5% to 20% significantly lifts both peak and equilibrium. Surprisingly, raising suspended-driver reactivation from just 1% to 2.5% has even higher impact, because the slowly deflating Suspended stock accumulates a growing driver population over time. Raising both rates beats raising either alone.
Illustrates: the model overturning the obvious bet (faster onboarding) and revealing that a tiny flow can be the highest-impact lever — directly producing the strategy's headline policy.

## LLM candidate interventions from the onboarding model (Reason step)

Reasoning over the sketch generated candidate LLM applications before exercising the model: real-time identification of missing application information (replacing later human review), personalized re-engagement emails mapping a departed driver's stated reason for leaving against recent product changes and retention promotions, triaging unsuspension requests to focus human attention on the most promising (explicitly not letting the LLM approve removals), and a Q&A tool helping residents decide whether to apply. Reasoning also surfaced the key conditional: with an effectively infinite city population, attracting new drivers is what matters; with a finite one, onboarding is essential early in a city's life but reengaging departed drivers is probably at least as important long term — anticipating why the policy targets mature markets. The model's exercise results then filtered these options: only the reactivation-focused ones address active drivers; the rest at best cut operating costs.
Illustrates: generating options by walking a model's flows, then letting the exercised model select among them — and keeping humans in the loop for high-stakes approvals.

## Leak versus Conversion

With 100 applied drivers and 100 eligible drivers, applying a 25% rate two ways: `Leak(0.25)` ends with 75 applied and 125 eligible (the unconverted 75 remain); `Conversion(0.25)` — what a bare `@ 0.25` means — ends with 0 applied and 125 eligible, destroying the unconverted portion.
Illustrates: a subtle modeling-primitive distinction that silently changes results if you pick the wrong one.

## Document structure note

Relative to the book's default strategy structure, this chapter's main document was refactored for readability: Operation was folded into Policy, and Refine was embedded in Diagnose. Readers applying the strategy should read top to bottom; readers studying the thinking should read in reverse — Explore, then Diagnose, then Policy.
Illustrates: the strategy structure is a tool to adapt, and the writing order (refinement first) is the reverse of the reading order.
