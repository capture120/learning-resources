# Chapter 21: Product Engineering Strategy

This chapter is a case study from Will Larson's time as CTO of Calm: two real (reconstructed-from-memory) strategy documents that refocused a scattered startup engineering team on product work and created a protected channel for engineering-driven projects. The single most important takeaway: for a low-scalability, low-complexity consumer product, a reasonably good starting point is deliberately restrictive defaults — "we are a product engineering company," boring technology, one monolith — enforced through written exceptions, paired with a small, explicitly protected budget for engineering-driven work so improvement projects stop dying to short-term pressure.

## Core ideas

### Executive strategy can be mandated, not just proposed

Most of Larson's strategy work had been in nonexecutive roles, where you can only propose. Calm was Larson's first executive role, where he could "not only propose but also mandate strategy." Mandate does not mean dictate from day one: the strategies emerged from "numerous rounds of iteration, debate, and inevitably some disagreement" with the team. The resulting documents are "basic and also unambiguous about our values" — a good strategy for this company type does not need to be clever, it needs to be clear.

### Declare what kind of engineering company you are

The anchor policy is an identity statement: "We are a product engineering company." The reasoning: users write in daily saying the product changed their lives; the technical infrastructure "doesn't get many user letters" — and is unlikely to, because the infrastructure is relatively low-scale and low-complexity. Rather than trying to make infrastructure matter, devote "the absolute maximum possible attention to product engineering." The why: strategy is about where value is actually created. When infrastructure is not the constraint on the product, infrastructure-style investment is misallocated attention.

### Adopt new technology only when a capability is otherwise impossible

Policy: "We exclusively adopt new technologies to create valuable product capabilities." Calm believes the existing stack can solve the majority of current and future roadmaps. A new technology is adopted only when a product capability is *inherently impossible* without it. Explicitly excluded reasons: someone wants to learn the technology, or the technology is "30% better suited to a task." The why: most of Calm's internal disagreement and wasted time stemmed from technology-adoption and rewrite debates; a bright-line rule removes the recurring argument.

### Default everything into the monolith

It had been ambiguous whether new code belonged in the JavaScript monolith or in new services. The policy removes the ambiguity entirely: "all new code must be written in the monolith." If a functional requirement makes the monolith implausible, request an exception. The why: ambiguity itself was the cost — engineers gave stakeholders contradictory answers and derailed into architecture debates, and the year-old services migration had moved no core production code while pulling infrastructure engineers into incidents with poor monitoring and ambiguous accountability.

### Restrictive policies plus written exceptions

The policies are "deliberately restrictive. Sometimes they may be wrong, and we will make exceptions to them." Exceptions are granted only by the CTO and must be in writing: "If there's no written record that the CTO approved it, then it's not approved." Each exception must be deliberate and grounded in a concrete problem the team is aligned both on solving and on how to solve it. The why: "If we all scatter toward our preferred solution, then we'll create negative leverage for Calm rather than serving as the engine that advances our product." Written exceptions kill ambiguity about what was approved, and the exception process is the escape valve that makes a restrictive policy safe to enforce. Calm immediately demonstrated the mechanism with two real exceptions (TypeScript, Postgres Aurora), each justified by a concrete problem and owned by a named team — proving exceptions are genuinely available, not theoretical.

### Diagnosis: name the real constraint, including the human one

The Document 21-1 diagnosis models what an honest diagnosis looks like:

- **Check whether infrastructure actually constrains the roadmap.** Nothing on Calm's one-year roadmap was blocked by infrastructure capabilities.
- **Measure technical debt as maintenance time.** "One way to measure technical debt is to understand how much time the team is spending maintaining the current infrastructure" — meaningful but not overwhelming for 3 infrastructure engineers supporting 30 product engineers.
- **Notice where incidents come from.** Stability issues traced to two specific causes (missing indexes that passed in test environments; expensive writes plus index scans on large skinny tables) — and to services moved out of the monolith with lacking monitoring and ambiguous accountability.
- **Take stakeholder perception seriously as a strategy input.** "Our product and executive stakeholders experience us as competing factions": ask different engineers, get radically different answers; group discussions derail into approach debates instead of a clear point of view. Engineering should present a consistent perspective even while pushing back on misaligned asks.
- **Sum the costs.** All of the above combined meant engineering spent more time on infrastructure and platform work than product work, directly contradicting stakeholder expectations.

### Explore: ground strategy in where the industry is converging

The exploration validates the policy against the outside world: an app like Calm (shared content, CDN-cacheable, usable even when non-CDN infrastructure is down) would have needed bespoke infrastructure and likely datacenters in 2010; by 2020 comparable applications generally minimize internal infrastructure, and new companies founded in the space view essentially all infrastructure as a commodity bought from a cloud provider — even ML training (e.g., AWS Bedrock) and models (Anthropic, OpenAI). Touchstones: Intercom's "Run Less Software" and Dan McKinley's "Choose Boring Technology." The why: the explore section shows the diagnosis isn't idiosyncratic; the strategy rides an industry-wide current rather than fighting it.

### Protect engineering-driven work structurally, not aspirationally

Document 21-2 addresses the universal long-term vs short-term balance problem — particularly the Product/Engineering debate over new functionality versus improving what exists. It was written against the prior prevailing belief within Engineering that the company was not willing to make such investments at all. Calm's mechanism:

- One Engineering-driven project per product engineering team, per quarter.
- Maximum 20% of the team's bandwidth.
- Each project must advance a measurable metric and be designed to show progress on that metric within four weeks.
- Projects must adhere to the existing engineering strategies (Document 21-1).
- **Resource these projects first in planning, not last** — but only concrete projects are resourced. No concrete proposal, no reserved time.
- The engineering manager decides the project, ensures it is valuable, and pushes back on attempts to defund it.
- No CTO approval needed for selection, but escalate friction or disagreement to the CTO.
- The CTO reviews all engineering-driven projects quarterly — summarizing impact, giving engineering managers feedback on selection and execution, and reviewing teams that ran *no* project to understand why.

The why behind each design choice: resourcing first defeats the observed failure mode where projects make the initial roadmap and then get deprioritized under delivery pressure; the concreteness requirement prevents the budget from becoming a vague slush reservation; the four-week metric requirement forces projects to demonstrate value fast enough to defend themselves; EM ownership plus CTO escalation gives the project a named defender with executive backing; the quarterly review of non-participating teams makes opting out visible rather than silent.

### Why structural alternatives were rejected

The diagnosis explains why obvious alternatives fail at Calm's size and shape: about one-third of engineering time went to content-release work where "Engineering is involved due to implementation limitations, not because our involvement adds inherent value." The 20-engineer team was not very fungible (iOS, Android, Backend, Frontend, Infrastructure, QA specialization), so the Infrastructure team — which *could* make such investments stick — lacked the product experience to do this work. Spinning up a Platform team or moving product engineers to Infrastructure would either break the company's Product Manager / Engineering Manager pairing goal or be "indistinguishable from prioritizing within the existing team." And because company planning was organic, decisions could be silently reversed "in a side discussion missing context on why the project is important," across executive and team forums with imperfect mutual awareness. The mechanism is designed precisely against these failure modes.

### Prioritization methods succeed on sponsorship, not on the method

The Document 21-2 explore section surveys prioritization solutions: RICE scoring (Reach × Impact × Confidence ÷ Effort), the Scaled Agile Framework, Google's historical 20% time, and Stripe's Foundational Initiatives for cross-pillar long-term projects. The key finding: every method has clear successes and clear failures. "Where these initiatives have succeeded, they had an engaged executive sponsoring the practice's rollout, including triaging escalations when the rollout inconvenienced supporters of the prior method." Without a sponsor, or when misaligned with company culture, the same methods consistently fail. The why: the mechanism's content matters less than whether someone with power absorbs the cost of defending it.

### Select from what already works; don't mandate novelty

The chapter's closing lesson: "A surprising number of executives start new roles by mandating a brand-new process or architecture." The more effective approach is "identifying approaches that are already working well within the company, and eliminating the less effective, competing approaches. At its best, selecting from existing, successful techniques means you can bypass strategy refinement entirely." The why: existing successful practices are already validated in your context; novelty imports both unproven assumptions and political resistance.

### Reading strategy documents: apply forward, understand backward

To *apply* a strategy document, read top to bottom (Policy → Diagnose → Explore). To *understand the thinking*, read in reverse: Explore, then Diagnose, then Policy. This separates reading from thinking (the structure detailed in Chapter 11).

## Actionable guidance

- Decide explicitly what kind of engineering company you are, and write it down as policy. Allocate attention to where users actually receive value.
- Before investing in infrastructure, audit the roadmap: is anything you plan to build in the next year actually constrained by infrastructure? If not, don't invest there.
- Adopt a new technology only when a product capability is inherently impossible without it. Reject adoptions motivated by learning interest or marginal (e.g., 30%) fit improvements.
- Pick one default place for all new code and remove the ambiguity. Make deviations exception-only.
- Make policies deliberately restrictive, then pair them with a real exception process: exceptions granted by a single named role (CTO), always in writing. Treat any unwritten exception as not granted.
- Seed the exception process with one or two genuine, concrete-problem-grounded exceptions (with named owning teams) to prove it works.
- Measure technical debt as the fraction of team time spent maintaining current systems.
- When diagnosing, include how stakeholders experience engineering. Inconsistent answers across engineers is a strategy problem, not a communication nit.
- Protect engineering-driven work with a concrete mechanism: one project per team per quarter, capped at 20% bandwidth, tied to a measurable metric showing progress within four weeks.
- Resource protected projects first in planning, never last — but only if a concrete proposal exists.
- Assign the engineering manager as the project's owner and defender; route friction to the CTO via escalation rather than requiring CTO pre-approval.
- Run a quarterly executive review of these projects, including explicitly asking teams that ran none why not.
- When publishing an abstract mechanism, include concrete greenlit examples so teams understand what qualifies — while stating the examples don't define the only acceptable shape.
- Require engineering-driven projects to comply with the broader engineering strategy, so the carve-out can't be used to route around the restrictive defaults.
- Before adopting any prioritization framework (RICE, SAFe, 20% time, etc.), confirm an engaged executive sponsor exists who will triage escalations from people the rollout inconveniences. No sponsor, no rollout.
- As a new executive: inventory what is already working in the company, amplify it, and eliminate the competing weaker approaches — rather than mandating a new process or architecture.
- Read strategy docs top-down to apply them; bottom-up (Explore first) to understand the reasoning.

## Pitfalls and misconceptions

- **Mandating a brand-new process or architecture upon arrival as an executive.** The chapter's explicit anti-pattern; prefer selecting from existing successful approaches.
- **Adopting technology out of learning interest or for a modest (e.g., 30% better) fit.** Technology-adoption and rewrite debates fueled most of Calm's internal disagreement and time loss.
- **Letting "should this be a service?" stay ambiguous.** Ambiguity produces contradictory stakeholder answers, derailed debates, and a migration that ran over a year without moving core production code.
- **Verbal or implied exceptions.** If approval isn't written, people will operate on assumed permission and scatter; unwritten means not approved.
- **Scheduling improvement work last.** It will make the initial roadmap and then be defunded under delivery pressure; this was Calm's observed, repeated failure mode in product teams.
- **Reserving time without concrete projects.** A bandwidth reservation with no concrete proposal becomes unaccountable slack; resource only named projects.
- **Solving prioritization with org structure (a new Platform team) when the team isn't fungible.** It either breaks existing organizational invariants (PM/EM pairing) or changes nothing because the same leaders still prioritize.
- **Assuming a prioritization framework works because it worked elsewhere.** Methods fail without an engaged executive sponsor or when misaligned with company culture, regardless of prior success at other companies.
- **Treating stakeholder frustration as a perception problem.** "Competing factions" feedback reflected a real strategy vacuum, and was treated as a first-class diagnostic input.
