# Chapter 22: Developer, API, and Acquisition Strategy at Stripe — Examples

This chapter is itself a case study: four actual Stripe strategy documents. The worked examples below capture each document's concrete policies, diagnosis specifics, and operational mechanisms, plus the smaller illustrations embedded in them.

## Worked example: Stripe's API deprecation policy (Document 22-1)

The actual policy set: (1) Design for long API lifetime — before release, build a test application without the new API, migrate it to the API yourself, consider how integrations evolve, then take it to API Review and test with a handful of early-adopter companies before the final stable release. (2) Every new or modified API requires API Review approval before customer exposure, via written proposal to the api-review email group, with a searchable archive of past decisions; most approvals are asynchronous, complex or controversial ones get live discussion. (3) Never deprecate without an unavoidable requirement, where deprecation means any change forcing customers to modify an existing integration; exceptions need API Review then CEO approval. (4) Significant new functionality gets a new API instead of changing an old one. (5) Technical debt is managed by keeping a single internal implementation of the latest version, with a layer of version transformations serving all prior versions; every modification must update that layer. The diagnosis: API changes seem easy for engineer-heavy startups but hard for small businesses and enterprises; stability both prevents churn and raises switching costs; companies that deprecate aren't ill-informed, they just won't consistently absorb the provider-side debt.
Illustrates: a complete policy-and-diagnosis pair where the provider deliberately absorbs technical debt to buy customer retention.

### The TLS 1.2 exception

The one cited exception to the never-deprecate policy was dropping TLS 1.2 support, forced by PCI compliance obligations. The policy's exception path requires API Review approval followed by CEO approval.
Illustrates: exceptions exist only for unavoidable external requirements, and routing them to the CEO keeps the bar high.

### /v1/subscriptions instead of extending /v1/charges

When Stripe needed subscription workflows, it created a new `/v1/subscriptions` API rather than extending `/v1/charges`, leaving existing charge integrations untouched.
Illustrates: the "add a new API rather than change an existing one" policy in action.

### The Payment Intents API (footnote)

Europe's Strong Customer Authentication regulation required compliance changes. Stripe introduced the Payment Intents API to handle it, and even then the old charge API kept working as before for non–European Union payments.
Illustrates: even regulation-forced change was implemented additively, preserving existing integrations wherever possible.

### SDKs as a future escape hatch

Over time, fewer customers integrated directly against Stripe's APIs and most new integrations went through official SDKs. The strategy notes this may eventually allow more backward-incompatible changes, because migration complexity could be absorbed inside the SDKs Stripe controls — but states plainly that this was not yet true.
Illustrates: monitoring for conditions that would let a costly policy be safely relaxed.

## Worked example: the systems model of API deprecation (Document 22-2)

Stripe had internal data correlating deprecation with churn, and built this model to decide whether correlation matched causation. The model has five stocks (Potential, Engaged, Integrated, Deprecation-Impacted, and Churned customers) and six flows: acquisition (100 per round), initial integration (50% leak), baseline churn (10% leak), experiencing deprecation (50% leak), reintegration (90% leak), and deprecation-influenced churn (10% leak). The baseline run stabilized in about 40 rounds at roughly 1,000 integrated customers with 400 dealing with deprecations. Cutting deprecation exposure from 50% to 10% barely moved the steady state (about +5%). Zeroing baseline churn alone raised it to about 1,750. Doing both yielded about 6,000 integrated customers with the curve still growing rather than flattening.
Illustrates: churn sources mask each other — only reducing both deprecation churn and baseline churn together changes the trajectory, so churn reduction is a system-level optimization.

### Facebook's Ads API deprecation cadence

To sanity-check whether a 50%-per-round deprecation rate was plausible, Larson notes from personal experience that Facebook's Ads API deprecated at least one important field quarterly during 2012–2014. For a payments API the 50% figure would be high, and was chosen deliberately as a contrast case.
Illustrates: grounding model parameters in real-world reference points, and using deliberately extreme values to build intuition.

### Where engineering can and can't move churn

The model's Reason section: baseline churn for a payments API is hard to move without significantly lowering margin — many churning customers leave due to company dissolution, and revenue-weighted it is largely driven by non-technical factors, primarily pricing. Engineering decisions, by contrast, significantly impact deprecation frequency and reintegration ease, and reintegration work also supports the initial integration experience, serving two flows at once.
Illustrates: using a model to locate which flows engineering can actually influence, and preferring investments that serve multiple flows.

## Worked example: the Sorbet strategy (Document 22-3)

The 2017 operating policy: Product Infrastructure picks three top priorities every six months, invests the significant majority of energy there with minimal support elsewhere, refreshes priorities after each twice-yearly developer productivity survey, and reports in Quarterly Business Reviews. That half's priorities: (1) static typing for the highest-value parts of the Ruby codebase via a custom checker (Sorbet) runnable locally and on test machines, (2) selective test execution using statistical inference of which tests likely fail for a changed file (viable given very high test coverage and that all tests still run before production deploy), and (3) instrumenting test failures, annotating only high-conviction errors. The rollout plan was a hybrid of manual deep-dives for complex code and AST-rewriting scripts for the rest, with CQRS-style interfaces advocated as seams for incremental typing. The downside was bounded at roughly six months of half the team to prove viability; based on Facebook's Hack project, they expected whole-codebase checking in under 30 seconds.
Illustrates: an unconventional, expensive bet (12–24 months) made defensible through bounded downside, incremental value, and central absorption of the cost.

### The 2017 diagnosis behind Sorbet

Stripe was ~1,000 people with 400 engineers, growing ~70% year over year; with production stability improved over the preceding years, focus had turned to developer productivity. Test coverage exceeded 99% of lines, and tests ran quickly in CI only because they were multiplexed across a large fleet of test runners — locally they were slow enough that an increasing number of engineers ran overly narrow subsets or skipped local testing, relying on test servers whose merge-build-test cycle took 20–30 minutes — by completion they'd lost focus and might take hours to return. The survey's most concerning signal: long-tenured Stripe engineers felt productive, but experienced new hires found it very difficult to determine how to safely make changes. There was unresolved disagreement, with no trustworthy dataset, on whether flaky tests came from infrastructure or test quality.
Illustrates: a diagnosis combining metrics and survey data, surfacing new-hire safety as the most concerning signal and naming a data gap honestly.

### Why Ruby stayed

Ruby isn't highly performant, but the majority of Stripe's spend was real-time storage and batch computation, so language efficiency couldn't justify replacement. The 10-engineer Ruby-focused Product Infrastructure team supported ~250 product engineers; Golang (10 engineers) and Scala (40 data engineers) developers kept requesting central support that was challenging to prioritize against the Ruby majority. Two carve-outs: a narrow Golang tokenization service explicitly considered out of scope, kept small to absorb SOC1 compliance (whose developers had also raised no productivity concerns), and the Scala data infrastructure, which managed its own build and deploy tooling.
Illustrates: language consolidation justified by where money and platform-team leverage actually go, with principled exceptions.

### Larson's own skepticism

Larson, who later became responsible for Product Infrastructure, was initially skeptical of Sorbet, preferring incremental migration to Java (for library coverage) or Golang (for existing familiarity). The project's "indisputable results" won him over. He credits the team, not himself, for the strategy.
Illustrates: good strategy can originate below the executive, and results should be allowed to overturn a leader's priors.

## Worked example: integrating the Index acquisition (Document 22-4)

The 2018 situation: several of Stripe's largest customers demanded a point-of-sale device integrated with its API ecosystem; at least one enterprise was expected to churn — plausibly to Square, whose vertically integrated approach made it a credible destination despite its less-developed API ecosystem — if the best commitment was 12 months out. Stripe had no hardware expertise and, anchoring on its other internal zero-to-one efforts, estimated a year to hire the team and build internally, so it acquired Index, a point-of-sale startup (a Java/AWS shop versus Stripe's Ruby-and-Go/AWS), to commit to a six-month launch. The integration policy: weekly syncs jointly owned by Stripe's Head of Traffic Engineering and Index's Head of Engineering until release; all escalations to both paired leads; the point-of-sale API moves into the secured tokenization environment (which converts raw payment details into tokens) because the device touches card details, but nothing else may be added there; all frequently changing or dependency-heavy software stays in standard environments; security must explicitly sign off on anything touching the tokenization environment; and the contentious question of adopting Java — incompatible with Stripe's language strategy, with stakeholders unalignable in time — was explicitly deferred until after launch.
Illustrates: integrating under a hard deadline with provisional policies, paired leadership, a quarantined compliance boundary, and explicit deferral of an unresolvable decision.

### The four acquisition types applied

The document classifies acquisitions as talent, business, technology, or time-to-market, noting most blend several. Index was diagnosed as primarily time-to-market: Stripe could build point-of-sale capability internally in about a year, but acquiring compressed that to six months — which was the entire point, given the churn threat.
Illustrates: classifying the acquisition type to derive the integration's real constraint (speed).

### The Explore findings on acquisitions

Stripe's prior acquisitions were small with no meaningful product to integrate, so there was not much of an internal playbook. Synthesizing prior-company experience and peer interviews produced five patterns: hidden deal-team commitments surface as odd behavior worth debugging directly; an engaged executive sponsor is essential, and a missing one should be replaced rather than worked around; close the culture gap quickly where friction is low and cautiously where trust is low, preferring moving people across teams over force; never be flexible about supporting a new technology stack, since each new feature on it compounds divergence; and find a way to derisk key departures, with consolidating infrastructure immediately (even if product takes longer) as one of the easiest starting points. The authors candidly found this exploration unsatisfying — abstract, full of conflicting strong opinions — concluding acquisitions may have no reliably right way.
Illustrates: honest exploration that yields heuristics rather than answers, motivating provisional policies plus a refinement mechanism.

### Learning about the deal after it closes

Like most acquisitions, the integration team only learned of the Index deal after it closed, making early efforts a scramble to apply strategy testing to distinguish optimistic dates from technical realities.
Illustrates: why integration strategy must assume incomplete context and validate timelines immediately.

## Chapter-level example: defying the standard playbook

In the 2010s the standard hypergrowth playbook said deprecate APIs to keep developer velocity, and decompose the monolith for reliability and velocity. Stripe did neither — it refused to deprecate APIs without unavoidable cause, kept one Ruby monolith past 3,000 engineers, and built Sorbet instead — and made a tight acquisition timeline work. Larson's framing: first-principles thinking helped, but the deciding factor was that the thinking was extremely detail-oriented and endured for a decade of consistent application.
Illustrates: contrarian strategy succeeds through detail and endurance, not contrarianism itself.
