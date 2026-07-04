# Chapter 22: Developer, API, and Acquisition Strategy at Stripe

This chapter presents three Stripe engineering strategy documents from its hypergrowth era — on API deprecation, on building the Sorbet type checker instead of decomposing its Ruby monolith, and on integrating the 2018 Index acquisition — plus a systems model used to validate the API strategy. The single most important takeaway: Stripe's wins came from deliberately rejecting the standard industry patterns of the time (routine API deprecation, monolith decomposition), and what made that contrarianism work was not first-principles thinking alone but "extremely detail oriented, enduring first-principles thinking" — strategies applied consistently for a decade. Almost all of their impact would have been undermined if they had lasted only a year or two.

## Core ideas

### Strategy details and endurance decide success

Larson stresses these documents are "a particular testament to how much the details matter in strategy" — he doubts the same approaches would consistently work if adopted elsewhere. The deciding factor between success and failure was not the contrarian choice itself but detail-oriented, enduring application. A strategy abandoned after a year or two would have delivered almost none of its value.

### API stability as a foundational business decision (Document 22-1)

Stripe's willingness to significantly prioritize API stability is, in Larson's view, its most interesting strategy work and "one of the unsung heroes of Stripe's business success." It is almost invisible externally; internally it drove frequent, detailed discussion. The key reframe: API stability is not a technical design quirk — in an API-driven business it is a foundational decision.

Key definition: **API deprecation is any change that would require customers to modify an existing integration.** This customer-centric definition (rather than a provider-centric one like "removing an endpoint") makes the policy's scope unambiguous.

The core policy commitments:

- **Never deprecate APIs without an unavoidable requirement.** Even when maintaining support is technically expensive, Stripe absorbs that cost. Exceptions require approval by API Review and then the CEO (e.g., dropping TLS 1.2 for PCI compliance).
- **Design for long API lifetime.** APIs are not inherently durable; durability has to be designed in deliberately.
- **Add new APIs rather than change old ones** when significant new functionality is needed (e.g., creating `/v1/subscriptions` rather than extending `/v1/charges`).
- **Manage the implied technical debt with an API translation layer.** Only one implementation exists internally — the latest API version. A series of version transformations layered on top serve all prior versions. This doesn't eliminate the overhead of supporting many versions, but it significantly reduces complexity because only one modern implementation is maintained.
- **SDKs may eventually soften the policy** by absorbing migration complexity on the customer's behalf. Most new integrations already go through official SDKs and direct integrations have dropped significantly, but making more backward-incompatible changes this way is "certainly not the case yet today."

### Why API stability matters: the churn diagnosis

The diagnosis behind the policy:

- Integrating an external API change looks easy to an engineer-heavy startup, but is genuinely hard for small businesses without dedicated engineers and for enterprises with many stakeholders. Even if this is only marginally true, modeling the impact of minimizing API changes on long-term revenue growth showed a significant effect — the policy is robust even under a weak version of the assumption.
- API instability directly creates churn, and API stability also **retains** customers: without an API change forcing them to touch their integration, hypergrowth customers are particularly unlikely to switch payment providers absent a concrete motivation.
- Relatively few companies provide long-term API stability in general, and particularly few in complex, dynamic areas like payments — making stability a rare differentiator. And companies that do deprecate APIs are not ill-informed. They face a real technical-debt tradeoff between API provider and API consumers, and most are simply unwilling to consistently absorb that debt internally. Stripe's strategy is to absorb it.
- Future compliance and security requirements (like TLS upgrades for PCI, or new markets' regulations) may force changes that cannot be predicted now — hence an exception path rather than an absolute ban.

### Churn reduction is a system-level optimization (Document 22-2)

The systems model of API deprecation produced a non-obvious result. With a 10% baseline churn per round, cutting the share of customers experiencing deprecation from 50% to 10% raised steady-state integrated customers by only about 5%. But with baseline churn eliminated, the same deprecation reduction changed the outcome dramatically (roughly 6,000 vs. 1,750 integrated customers, with the low-deprecation line still growing rather than plateauing).

The takeaway: **eliminating API-deprecation churn alone won't significantly grow integrated customers, but you cannot fully benefit from reducing baseline churn without simultaneously reducing deprecations.** The two churn sources mask each other; reducing either magnifies the benefit of reducing the other. Treat churn reduction as a system-level optimization, not a collection of discrete improvements.

The model also clarified where engineering can act: baseline churn is dominated by non-technical factors (company dissolution, pricing) and is expensive to move without sacrificing margin. Engineering decisions, by contrast, directly control the number of deprecations and the ease of reintegration — and the same work that eases reintegration also eases initial integration, making it a doubly attractive investment.

A modeling craft point: whether parameter values are "reasonable" depends on what a round represents (a month vs. a year), and extreme values are useful as deliberate contrast against realistic ones.

### Investing in the monolith instead of decomposing it (Document 22-3)

Stripe kept its single Ruby monolith past 3,000 engineers, building the Sorbet static (and runtime) type checker rather than migrating to a statically typed language or decomposing into isolated codebases. The strategy came from the Product Infrastructure team, which shared the goals of other companies' Developer Experience or Developer Productivity teams but had a distinct method: preventing errors and improving productivity through changes to the internal architecture of the codebase itself, rather than relying solely on external tooling or processes. The strategy's logic:

- **The leverage math drives the language decision.** A ~10-engineer Product Infrastructure team supported ~250 product engineers, with sublinear headcount growth expected. Every additional programming language fragments that fixed support capacity; Stripe was "already failing to support additional languages" (Golang, Scala). Consolidating on Ruby maximized the return on a fixed platform-team investment.
- **Ruby's weaknesses didn't matter for Stripe's costs.** Ruby is not highly performant, but the majority of spend was on storage and batch computation, not application compute — so language efficiency alone could not justify replacement.
- **Static typing attacks the diagnosed problem directly.** The diagnosis: >99% test coverage but tests too slow to run locally, so an increasing number of engineers ran an overly narrow subset or skipped local tests entirely, then waited 20–30 minutes for server builds, losing focus for hours. Newly hired engineers (despite long tenure elsewhere) found it very difficult to determine how to safely make changes. A type checker expected to check the entire codebase locally in under 30 seconds restores a tight local feedback loop and catches an error class tests miss: unexpected types flowing across code paths tested only for expected scenarios.
- **Centrally absorb the cost.** Product Infrastructure built the type checker and did the initial rollout itself, so product engineers stayed focused on shipping features rather than migrating code. This is the same "absorb the debt centrally" move as the API translation layer.
- **Bound the downside.** The bet was explicitly sized: if the approach failed, the known cost was about six months of half the team — what was needed to determine viability.
- **Value incrementally.** The codebase did not need to be wholly typed before delivering value; typing could be prioritized to the highest-value places. Deep-dives handled complex areas; AST-rewriting scripts handled simpler ones. CQRS-style interfaces were advocated as high-leverage seams for introducing types.

The operating model around it: every six months Product Infrastructure picks its three highest-priority areas, invests a significant majority of energy there, gives minimal support elsewhere, refreshes priorities after the twice-yearly developer productivity survey, and shares results in the Quarterly Business Review.

Notably, Larson was initially skeptical — he preferred incremental migration to Java (library coverage) or Golang (existing familiarity) — and was won over by "indisputable results." Good strategy can come from the team, not the executive.

### Acquisition integration strategy (Document 22-4)

The chapter reframes acquisitions: discussion usually centers on diligence and whether to acquire, but **the integration afterward can be more complex than the deal**. There are few irreversible trapdoor decisions in engineering, but decisions made early in an integration tend to be surprisingly durable. The business rationale for the acquisition is not the strategy's focus — it is merely part of the diagnosis defining the integration tradeoffs.

A taxonomy of acquisitions: **talent** (bring on a team), **business** (buy revenue and product), **technology** (add a capability hard to build internally), and **time-to-market** (you could build it, but acquiring is meaningfully faster). Most acquisitions blend several; classifying which dominates clarifies the integration constraints. Index was primarily time-to-market: Stripe's largest customers were pushing for a point-of-sale device, at least one enterprise customer was believed likely to churn without a committed timeline — with vertically integrated Square a plausible destination — and building internally would take ~12 months versus 6 with the acquisition.

The policy pattern for integrating under uncertainty — "a mix of a commitment to joint refinement and several provisional architectural policies":

- **Joint refinement mechanism**: weekly syncs between paired leads (one from each side) until initial release, with all escalations going to both leads, because there is little shared context across teams.
- **Hard security boundary**: anything touching raw payment details must live in the secured tokenization environment, and nothing else may be added there; everything that changes frequently or has complex external dependencies stays in standard environments. Security must explicitly sign off on any decision touching the tokenization environment — speed does not justify cutting security corners.
- **Explicit deferral**: the question of introducing Java (incompatible with Stripe's language-consolidation strategy, and impossible to align stakeholders on quickly) was deliberately deferred until after launch, named as a distraction from the six-month goal. Deferring a decision you cannot yet resolve is itself a policy.

The Explore section's synthesized patterns from prior acquisition experience (Stripe had no internal playbook):

1. Deal teams usually made commitments — or the acquired team perceived commitments — that will be hard to honor, often unknown to integrators. Odd behavior is a signal of such a misunderstanding; engage directly to debug it.
2. Every acquisition needs an engaged executive sponsor — typically the best person to ask about the company's intentions for the acquisition. If one is missing or disengaged, recruit a new one rather than working without.
3. Close the culture gap quickly where there's little friction, cautiously where there's little trust. You have years; the most successful approaches moved people into and out of the acquired team rather than applying force.
4. The long-term cost of supporting a new technology stack is high. This is not the place to be flexible: each additional feature built in the new stack takes you further from the desired outcome.
5. Derisk key departures early. The easiest starting point is consolidating infrastructure immediately, even if product and software consolidation take longer.

An honest meta-lesson: this exploration "was not the most reassuring" — abstract, with strongly held conflicting perspectives. Acquisitions may be a domain with no consistently right way to do it well — a setting that suits provisional policies plus a refinement mechanism over a fixed plan. Also: integration teams typically learn of the deal only after it closes, so early work is a scramble to apply strategy testing to separate optimistic dates from technical realities.

## Actionable guidance

API design and deprecation:

- Define deprecation from the customer's perspective: any change requiring customers to modify an existing integration counts.
- Before releasing an API, build a test application without it, then migrate that application to the new API yourself, to feel the integration friction firsthand. Then game out future provider-side changes against both the API and your test application.
- After initial API Review approval, recruit a handful of early-adopter companies to place additional pressure on the design, and test with them before releasing the final, stable API.
- Route every new or modified API through a formal API Review before any customer exposure; require a written proposal; approve most asynchronously and reserve live discussion for complex or controversial proposals; keep a searchable archive of past reviews as precedent.
- Default to never deprecating. Make exceptions require escalating approval (API Review, then CEO) so the cost of breaking customers is felt at the top.
- When significant new functionality is needed, ship a new API alongside the old one rather than changing the old one.
- Maintain exactly one internal implementation (the latest version) and serve old versions through a translation/transformation layer; require every API modification to update that layer.
- Track API versions in a changelog.
- Watch for conditions that let you relax the policy (e.g., as integrations shift to SDKs you control, migrations may increasingly be absorbed in SDK code).

Modeling and diagnosis:

- When data shows a correlation (deprecation correlates with churn), build a systems model to test whether you believe correlation matches causation before betting strategy on it.
- Exercise a model flow by flow: vary one flow, observe which stock moves, and let surprising non-results ("lowering deprecation barely helped") point you to the dominating flow.
- Look for compounding interventions: pairs of changes that individually do little but together change the trajectory (deprecation reduction plus baseline-churn reduction).
- Scope the model deliberately: skip dynamics (like recovery of churned customers) that are unlikely to change your understanding of the question.
- Prefer investments where one piece of work serves two flows (reintegration tooling also improves initial integration).

Platform and developer productivity:

- Concentrate a small platform team: pick the three highest-priority areas per half, invest the significant majority of energy there, explicitly give minimal support to everything else, and refresh priorities each half using a developer productivity survey plus standard metrics (deploy time/stability, test coverage/time/flakiness).
- Justify unconventional bets by bounding the downside: state the known, fixed cost of discovering the approach doesn't work.
- Have the platform team centrally absorb migration and rollout costs instead of taxing product engineers.
- Roll out incrementally where value accrues before completion; don't require whole-codebase adoption before benefit.
- Weigh new programming languages against the fixed capacity of your platform team: support burden fragments across every language you add.
- Use new-hire confusion ("can't safely make changes") as a leading indicator of codebase health, separate from the productivity of long-tenured engineers.
- When precise test selection is impossible (e.g., no static types), statistically infer which tests are likely to fail for a changed file so engineers can run them locally — viable given very high test coverage and the full suite still running before production deploy.
- When the cause of a problem is disputed (flaky infrastructure vs. flaky tests), invest in instrumentation to build a trustworthy dataset before acting.

Acquisition integration:

- Classify the acquisition (talent, business, technology, time-to-market) and let the dominant type set integration priorities.
- Start integration with provisional policies plus a standing joint-refinement meeting; don't pretend you have enough context for a fixed plan.
- Pair leadership: joint ownership of the sync meeting and dual-lead escalation paths while shared context is thin.
- Quarantine compliance-sensitive systems: put the minimum necessary functionality inside the secured environment, forbid anything else there, and require explicit security sign-off on changes to it.
- Explicitly defer decisions you can't align on yet, with a named time to revisit (after launch), rather than letting them block the timeline.
- Hold the line on technology-stack consolidation; treat each new feature built on the acquired stack as compounding divergence.
- Hunt for hidden deal commitments early; treat odd behavior from either side as a possible symptom of such a misunderstanding to debug directly.
- Secure an engaged executive sponsor or recruit one.
- Consolidate infrastructure immediately to derisk key departures, even when product integration will take longer.
- Apply strategy testing early to distinguish optimistic dates from technical realities, since the integration team usually learns of the deal only after close.

## Pitfalls and misconceptions

- **"API deprecation is necessary for developer velocity."** The standard 2010s view; Stripe showed the opposite tradeoff can win when the provider absorbs the debt. But don't assume deprecating companies are ill-informed — they face a real cost they've chosen not to absorb.
- **"Reducing one churn source is independently worthwhile."** The model shows churn sources mask each other; a single-flow fix can look nearly worthless until the dominating flow is also addressed.
- **"Decompose the monolith / migrate languages to scale."** A migration consumes product engineers' attention; Stripe judged that centrally built tooling on the existing stack preserved more total productivity. The right answer depends on details like platform-team size and where spend actually goes.
- **Believing correlation without modeling.** Stripe had data correlating deprecation with churn but built a model specifically to decide whether to believe causation.
- **Treating early integration decisions as reversible.** Few engineering decisions are trapdoors, but early acquisition-integration decisions are surprisingly durable.
- **Being flexible on tech stack during integration.** Named explicitly as the place not to be flexible.
- **Cutting security corners for launch speed.** The policy demands security sign-off even under the six-month deadline.
- **Forcing culture convergence.** The most successful stories moved people into and out of the acquired team rather than applying force; close the gap quickly where there's little friction, cautiously where there's little trust — you have years.
- **Expecting a playbook for acquisitions.** Research returned conflicting, strongly held views; the answer was provisional policy plus refinement, not certainty.
- **A strategy that doesn't endure.** Short-lived strategies forfeit nearly all of the value these documents created.
