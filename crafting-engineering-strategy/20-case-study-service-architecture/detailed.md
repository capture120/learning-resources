# Chapter 20: Service Architecture Strategy — Detailed Reference

## Chapter Introduction

Since microservices were first introduced in 2005, the debate between adopting a microservices architecture, a monolithic service architecture, or a hybrid of the two has become "one of the least reversible decisions that most engineering organizations make." The chapter sets the stakes with a comparison: even migrating to a different database technology is generally a less expensive change than moving from monolith to microservices or from microservices to monolith.

The industry has in many ways gone full circle on that debate. Most hyperscalers in the 2010s took part in multiyear monolith-to-microservices migrations. Kelsey Hightower's iconic 2017 tweet predicted the reversal: "Monolithic applications will be back in style after people discover the drawbacks of distributed monolithic applications."

Even as popular sentiment has generally turned away from microservices, many engineering organizations have a bit of both — often the remnants of one or more earlier but incomplete migration efforts. This service architecture strategy looks at a fictional organization stuck with a bit of both approaches and looking to determine its path forward: Theoretical Compliance Company.

## Reading This Document

This chapter contains just one document: Document 20-1, "Should We Decompose Our Monolith?", written in 2022.

Reading guidance depends on your goal:

- If your goal is to **apply** the strategies the document puts forward, start at the top and read to the end.
- If your main goal is to **understand the thinking** behind it, read the sections in reverse order: starting with Explore, then Diagnose, and so on.

Chapter 11 explains this approach to separating reading from thinking and details the general structure of strategy documents. The author's commentary on this document appears in the footnotes.

## Document 20-1: Should We Decompose Our Monolith?

### Policy

The document opens by stating that the company's policy for service architecture is documented here. (A footnote notes that, relative to the default strategy-document structure, this document has been refactored in two ways to improve readability: first, the Operation section has been folded into Policy; second, Refine has been embedded in Diagnose.)

Escalation and questions:

- All exceptions to this policy must escalate to a local Staff-plus engineer for their approval, and then escalate with that Staff-plus engineer to the CTO.
- Questions about the policies go to the #eng-strategy channel.

The policy itself:

1. **Business units operate their own repository and monolith.** Business units should always operate in their own code repository and monolith. They should not provision many different services. They should rarely work in other business units' monoliths. There will be nuanced cases; in these cases, "prefer decisions that move us closer to this policy."
2. **New cross-monolith integrations use gRPC.** New integrations across business unit monoliths should be done using gRPC. The emphasis is on *new* integrations: it is desirable but not urgent to migrate existing integrations that use other implementations (HTTP/JSON, etc.).
3. **Velocity over purity in subtle cases.** When the decision is subtle (e.g., changes to an existing endpoint), optimize for business velocity rather than technical purity. When the decision is far from subtle (e.g., a brand new endpoint), comply with the policy.
4. **No new services, except new business unit monoliths.** Except for new business unit monoliths, no new services are allowed. You should work within the most appropriate business unit monolith or within the existing infrastructure repositories. Provisioning a new service, unless it corresponds with a new business unit, always requires approval from the CTO in #eng-strategy.
5. **Approval is generally denied, with a nonfunctional-requirements exception.** That CTO approval generally will not be granted, unless the new service requires significantly different nonfunctional requirements than an existing monolith. Examples given: if it requires significantly higher compliance review prior to changes, such as the existing payments service; or if it requires radically higher requests per second; and so on.
6. **Merge existing services back into business unit monoliths where you can.** The company believes that each choice to move existing services back into a monolith should be made "in the details" rather than from a top-down strategy perspective. Consequently, teams are generally encouraged to wind down their existing services outside their business unit's monolith, but the policy defers to teams to make the right decision for their local context.

### Diagnose

Theoretical Compliance Company has a complex history with decomposing its monolith. The company is also increasing its number of business units while limiting investment into its core business unit. These are complex times, with a lot of constraints to juggle. To improve readability, the diagnosis is split into two sections: business constraints and engineering constraints.

#### Business constraints

- **Business model.** The company sells business-to-business compliance solutions to other companies on an annual subscription. There is one major, established business line, and two smaller, partially validated business lines that are intended to attach to the established business line to increase average contract value.
- **Headcount.** There are 2,000 people at the company. About 500 are in the engineering organization. Within that 500, about 150 work on the broadest definition of "infrastructure engineering": things like developer tools, compute and orchestration, networking, security engineering, and so on.
- **Board pressure on spend.** The business is profitable, but revenue growth has been 10%–20% year over year, creating persistent pressure on spend from the board, based on mild underperformance relative to public market comparables. Unless the company can increase YoY growth by 5%–10%, the board expects it to improve free cash flow by 5%–10% each year — which jeopardizes the company's ability to maintain long-term infrastructure investments.
- **Funding new business units from existing budget.** Growth in the primary business line is shrinking. The company's strategy includes spinning up more adjacent business units to increase average contract value with new products. These business units must be funded without increasing the overall budget, which means budget for the new business units must be pulled away from either the core business or the platform teams.
- **Efficiency pressure on the core business.** In addition to needing to fund the new business units, there is ongoing pressure to make the core business more efficient, which means either accelerating growth or reducing investment. It is challenging to accelerate growth while reducing investment, which suggests that most improvement will come from reducing investment.
- **Cost-allocation methodology.** The methodology for allocating platform costs against business units does so proportionately to the revenue created by each business unit. The core business generates the majority of revenue, which means it is accountable for the majority of platform costs — even if those costs are motivated by the new business lines.
- **The resulting squeeze.** This means that, even as the burden placed on platform teams increases due to spinning up multiple business units, there is significant financial pressure to reduce platform spend, because that spend is primarily represented as a cost to the core business whose efficiency must improve. Conclusion: "we have little tolerance for anything that increases infrastructure overhead."

#### Engineering constraints

- **Fixed infrastructure headcount.** The infrastructure engineering team is 150 engineers supporting 350 product engineers, and it is certain that infrastructure will not grow significantly in the foreseeable future.
- **Business unit proliferation and governance ambiguity.** Two new business units were spun up in the past six months, and an additional two new business units are planned in the next year. Each business unit is led by a general manager, with engineering and product within that business unit principally accountable to that general manager. The CTO and CPO still set practice standards, but it is situationally specific whether these practice standards or direction from the general manager is the last word on any given debate.
- **Example of governance failure.** One business unit has been unwilling to support an on-call rotation for their product, because their general manager insists it is a wasteful practice. Consequently, that team often doesn't respond to pages, even when their service is responsible for impacting the stability of shared functionality.
- **Conviction about service overhead and reorg churn.** The company has conviction that, in general, it is more overhead for infrastructure to support more services. It also found that, in this organization, the rate of service ownership changing due to team reorganizations counteracts much of the initial productivity gains from leaving the monolith.
- **The key tension between the two preceding observations.** It is generally more overhead to have more services, but it is even more overhead to have irresponsible business units breaking a shared monolithic service. For example: it is much easier to rate-limit usage from a misbehaving service than to fix a misbehaving codepath within a shared service.
- **The payments service.** The company has a payments service that moves money from customers to the company. Compliance and security requirements for changes to this service are significantly higher than for the majority of the company's software, "because the blast radius is essentially infinite."
- **Ruby's runtime characteristics.** The primary programming language is Ruby, which generally relies on blocking IO, and service-oriented architectures generally spend more time on blocking IO than monoliths. Similarly, Ruby is relatively inefficient at serializing and deserializing JSON payloads, which the company's service architecture requires as part of cross-service communication.
- **Lingering partial migrations.** The company has previously attempted to decompose, and has a number of lingering partial migrations that don't align cleanly with the current business unit ownership structure. The number of these services continues to grow over time, creating more burden on both infrastructure today and on product teams in the future as they try to maintain these services through various team reorganizations.

### Explore

**Industry adoption history.** In the late 2010s, most large or scaling companies adopted services to some extent. Few adopted microservices; the majority of adopters opted for a service-oriented architecture instead. Kelsey Hightower's iconic 2017 tweet on the perils of distributed monoliths captured the beginning of a reversal, with more companies recognizing the burden of operating service-oriented architectures.

**The original motivations mellowed.** In addition to wider recognition of those burdens, many of the cloud infrastructure challenges that originally motivated service architectures began to mellow:

- Most infrastructure engineers today only know how to operate with cloud-native patterns, rather than starting from machine-oriented approaches.
- Standard database technologies like PostgreSQL have significantly improved capabilities.
- Cloud providers have fast local caches for quickly retrieving verified upstream packages.
- The supply and cost of cloud compute are affordable.
- Slow programming languages are faster than they were a decade ago.
- Untyped languages have reasonable incremental paths to typed codebases.

**Resulting pattern by company age.** As a result of this shift, a new, emerging company is particularly likely to have a monolith in one backend and one frontend programming language. A five-plus-year-old company, however, might look like almost anything. One particularly common case: a monolith with most functionality, plus "an inconsistent constellation of team-scoped macroservices scattered across the organization."

**Macroeconomic shift.** The shift away from a zero interest-rate policy has also impacted trends, because service-oriented architectures tend to require more infrastructure to operate efficiently — such as service meshes, service provisioning and deprovisioning, etc. Properly tuned, service-oriented architectures ought to be cost competitive, and potentially superior in complex workloads, but it is hard to maintain the required investment in infrastructure teams in a cost-cutting environment. This has encouraged new companies to restrict themselves to monolithic approaches, and pushed existing companies to attempt to reverse their efforts to decompose their prior monoliths, "with mixed results."

## Summary

While the details matter a great deal when it comes to identifying an effective strategy, this document shows how the broad strokes of many strategies can be ported across companies. The author could have written most of this document about Stripe, Calm, or even Carta. The details, however, would have been quite different in every case. Exactly copying the approach from any one of those companies to another would have gone quite poorly, whereas copying the general strokes worked quite well.

## Footnote

1. Relative to the default structure, this document has been refactored in two ways to improve readability: first, Operation has been folded into Policy; second, Refine has been embedded in Diagnose.
