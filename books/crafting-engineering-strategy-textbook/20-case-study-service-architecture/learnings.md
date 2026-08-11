# Chapter 20: Service Architecture Strategy

This chapter is a worked case study: a complete strategy document ("Should We Decompose Our Monolith?", written 2022) for a fictional company, Theoretical Compliance Company, that is stuck partway between a monolith and services and must decide its path forward. The single most important takeaway: service architecture (monolith vs. microservices vs. hybrid) is one of the least reversible decisions an engineering organization makes — less reversible even than migrating databases — so the policy must be grounded in the company's actual business and engineering constraints, and the *broad strokes* of such a strategy port well across companies while the *details* never do.

## Core ideas

### Service architecture is a nearly irreversible decision

Since microservices appeared in 2005, the monolith-vs-microservices-vs-hybrid choice has become "one of the least reversible decisions that most engineering organizations make." Even migrating to a different database technology is generally cheaper than moving from monolith to microservices or back. Why this matters: irreversibility raises the stakes of getting the policy right and justifies strong central guardrails (escalation paths, approval requirements) that would be overkill for cheaper-to-undo decisions.

### The industry has gone full circle on microservices

Most hyperscalers ran multiyear monolith-to-microservices migrations in the 2010s. Kelsey Hightower's 2017 tweet marked the beginning of the reversal: "Monolithic applications will be back in style after people discover the drawbacks of distributed monolithic applications." Sentiment has since turned away from microservices, but many organizations are left with a bit of both — remnants of one or more earlier, incomplete migration efforts. Why this matters: most real organizations are not choosing between clean alternatives; they are deciding what to do with an inherited hybrid.

### Why the pendulum swung back (the Explore reasoning)

In the late 2010s most large or scaling companies adopted services to some extent, but few adopted true microservices; most chose a coarser service-oriented architecture. Two forces then reversed the trend:

1. **The original motivations mellowed.** The cloud infrastructure problems that justified service architectures faded: infrastructure engineers now start from cloud-native patterns rather than machine-oriented ones; PostgreSQL and standard databases gained significant capability; cloud providers offer fast local package caches; compute is affordable; slow languages got faster; untyped languages now have reasonable incremental paths to typing.
2. **The end of zero interest-rate policy (ZIRP).** Service-oriented architectures tend to require more infrastructure to operate efficiently (service meshes, provisioning/deprovisioning tooling, etc.). Properly tuned, they ought to be cost competitive and potentially superior for complex workloads, but the required infrastructure investment is hard to sustain in a cost-cutting environment.

Resulting industry pattern: new emerging companies typically have one monolith, one backend language, one frontend language. Companies five-plus years old can look like almost anything; a particularly common case is a monolith holding most functionality plus "an inconsistent constellation of team-scoped macroservices scattered across the organization."

### The chosen policy: business-unit-scoped monoliths

The document's policy (each point exists because of a specific diagnosed constraint):

- **Each business unit operates its own code repository and monolith.** Business units should not provision many services and should rarely work in other business units' monoliths. In nuanced cases, "prefer decisions that move us closer to this policy."
- **New cross-monolith integrations use gRPC.** Migrating existing integrations (HTTP/JSON, etc.) is desirable but not urgent — the emphasis is on *new* integrations.
- **Velocity over purity in subtle cases.** "When the decision is subtle (e.g., changes to an existing endpoint), optimize for business velocity rather than technical purity. When the decision is far from subtle (e.g., brand new endpoint), comply with the policy."
- **No new services**, except new business unit monoliths. Work in the most appropriate business unit monolith or existing infrastructure repositories. Provisioning a new service requires CTO approval, which "generally will not be granted" unless the service has significantly different nonfunctional requirements than an existing monolith (e.g., much higher compliance review burden, like a payments service, or radically higher requests per second).
- **Merge existing services back into business unit monoliths where you can** — but each merge decision is made "in the details" rather than top-down. Teams are generally encouraged to wind down out-of-monolith services, but the team decides for its local context.
- **Exceptions escalate** to a local Staff-plus engineer for approval, then with that engineer to the CTO.

Why a hybrid of central mandate and local discretion: the policy is strict where decisions are expensive and irreversible (new services), and deferential where local context dominates (winding down existing services).

### Diagnosis: split into business constraints and engineering constraints

The diagnosis is deliberately divided into two sections for readability. The deeper lesson is that architecture strategy is downstream of business mechanics, not just technical preference:

**Business constraints driving the policy:**
- B2B compliance products on annual subscription; one major established business line plus two smaller, partially validated lines meant to attach to it and raise average contract value.
- Modest growth (10–20% YoY) underperforms public comparables, so the board demands either 5–10% more growth or 5–10% better free cash flow yearly — jeopardizing long-term infrastructure investment.
- Growth in the primary business line is itself shrinking, which is why the company's strategy is to spin up more adjacent business units; these must be funded without budget growth, pulling money from the core business or platform teams.
- **Cost allocation distorts incentives:** platform costs are allocated to business units proportional to revenue. The core business generates most revenue, so it bears most platform costs — even costs motivated by the new business lines. Since the core business must become more efficient, there is intense pressure to cut platform spend exactly when new business units increase the platform burden. Conclusion: "we have little tolerance for anything that increases infrastructure overhead."

**Engineering constraints driving the policy:**
- 150 infrastructure engineers support 350 product engineers, and infrastructure will not grow significantly in the foreseeable future.
- Two business units spun up in six months; two more coming within a year. Each is led by a general manager to whom engineering and product are principally accountable; whether CTO/CPO practice standards or GM direction wins any given debate is "situationally specific."
- Conviction that more services means more infrastructure overhead — and that team reorganizations change service ownership often enough to counteract much of the initial productivity gain from leaving the monolith.
- **The key tension:** more services is generally more overhead, "but it's even more overhead to have irresponsible business units breaking a shared monolithic service." A misbehaving *service* can be rate-limited far more easily than a misbehaving *codepath inside a shared service* can be fixed. This tension is why the answer is per-business-unit monoliths rather than one company-wide monolith: service boundaries are kept exactly where organizational accountability boundaries fail.
- The payments service has far higher compliance and security requirements than other software "because the blast radius is essentially infinite" — the template for legitimate nonfunctional-requirement exceptions.
- **Language runtime matters:** the primary language is Ruby, which relies on blocking IO, and service-oriented architectures spend more time on blocking IO than monoliths. Ruby is also relatively inefficient at JSON serialization/deserialization, which cross-service communication requires. The language itself makes services more expensive for this company than for another.
- Previous decomposition attempts left lingering partial migrations that don't align with current business unit ownership; the number of such services keeps growing, burdening infrastructure now and product teams later through reorganizations.

### Broad strokes port; details don't

The summary's claim: "the broad strokes of many strategies can be ported across companies." The author could have written most of this document about Stripe, Calm, or Carta — but the details would differ in every case, and exactly copying one company's approach to another "would have gone quite poorly, whereas copying the general strokes worked quite well." Why: the policy shape (constrain service proliferation, scope ownership to organizational units, allow nonfunctional-requirement exceptions) is general; the diagnosis that justifies and tunes it is always company-specific.

### Document structure can be refactored for readability

Relative to the book's default strategy structure (detailed in Chapter 11), this document folds Operation into Policy and embeds Refine in Diagnose. Reading guidance: read top-to-bottom to *apply* the strategy; read in reverse order (Explore, then Diagnose, then Policy) to *understand the thinking* — the document is written for readers, not in the order it was thought through.

## Actionable guidance

- Treat monolith/services architecture choices as nearly irreversible; apply far more scrutiny to them than to reversible decisions.
- Scope monoliths to organizational accountability boundaries (one repository and one monolith per business unit), not to the whole company and not to individual teams.
- Place service boundaries where accountability breaks down: if a unit cannot be trusted to operate responsibly in shared code (e.g., refuses on-call), isolate it behind a service boundary you can rate-limit, rather than sharing a monolith you cannot defend.
- Ban new services by default. Require executive (CTO) approval, generally granted only for significantly different nonfunctional requirements — compliance blast radius, radically higher throughput — not for team preference or ownership convenience.
- Route exceptions through a two-step escalation: local Staff-plus engineer first, then jointly to the CTO. Publish where questions go (a known channel).
- Standardize the integration protocol for *new* cross-monolith calls (here, gRPC); explicitly deprioritize migrating existing integrations rather than mandating a rewrite.
- Encode a velocity/purity decision rule: subtle changes (modifying an existing endpoint) optimize for business velocity; clear-cut cases (brand-new endpoint) must comply with policy.
- Encourage merging stray services back into monoliths, but make each merge decision locally, "in the details" — don't mandate consolidation top-down.
- Split your diagnosis into business constraints and engineering constraints; make the architecture policy answer both.
- Trace your cost-allocation methodology's incentives: if platform costs land on the unit under the most efficiency pressure, expect pressure to cut platform spend regardless of actual platform load, and design policy to minimize infrastructure overhead.
- Factor your primary language's runtime characteristics (blocking IO, serialization cost) into the monolith-vs-services calculus.
- Weigh reorganization frequency: if ownership churns often, expect reorgs to erase much of the productivity gain from extracting services.
- When borrowing another company's strategy, port the broad strokes and rederive every detail from your own diagnosis.
- Refactor the standard strategy-document structure when it improves readability (e.g., fold Operation into Policy), and note the refactor for readers.

## Pitfalls and misconceptions

- **The distributed monolith.** Hightower's tweet predicted monoliths would come back in style after people discover the drawbacks of distributed monolithic applications — the burden of operating service-oriented architectures that the Explore section describes as widely recognized.
- **Incomplete migrations.** Partial decompositions leave a hybrid mess: services misaligned with the current ownership structure, growing in number, taxing infrastructure today and product teams through every future reorganization.
- **Assuming extraction gains persist.** Initial productivity gains from leaving the monolith are substantially counteracted by ownership churn from reorganizations.
- **Ignoring the org chart.** A shared monolith assumes every team behaves responsibly; one general manager refusing on-call support can destabilize shared functionality for everyone, and you have no rate-limit equivalent for a bad codepath.
- **Copying strategies verbatim.** Exactly copying Stripe's, Calm's, or Carta's approach to another company would go quite poorly; only the general strokes transfer.
- **Running service architectures without funding the infrastructure.** Properly tuned, service-oriented architectures ought to be cost-competitive, but they tend to require more infrastructure (service meshes, provisioning tooling), and that investment in infrastructure teams is hard to maintain in a cost-cutting environment.
- **Technical purity over business velocity in marginal cases.** Forcing policy compliance on subtle, low-stakes changes burns velocity for negligible architectural benefit.
