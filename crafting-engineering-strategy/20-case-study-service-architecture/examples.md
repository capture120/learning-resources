# Chapter 20: Service Architecture Strategy — Examples

The chapter is itself one extended worked example: Document 20-1, "Should We Decompose Our Monolith?" (written 2022), a full strategy document for the fictional Theoretical Compliance Company. The sections below capture the concrete elements of that document plus the smaller illustrations embedded in it.

## The worked example: Theoretical Compliance Company

### Company profile

A profitable B2B company selling compliance solutions on annual subscriptions. One major established business line, plus two smaller, partially validated lines designed to attach to the main one and raise average contract value. 2,000 employees; about 500 in engineering; about 150 of those in the broadest definition of infrastructure (developer tools, compute and orchestration, networking, security engineering). Revenue grows 10–20% year over year, mildly underperforming public market comparables, so the board expects either 5–10% faster growth or 5–10% better free cash flow annually. The company is in the common post-2017 position: a monolith plus leftover services from earlier, incomplete decomposition attempts that no longer match the ownership structure.

Illustrates: the typical mature-company starting point for a service architecture strategy — an inherited hybrid, not a greenfield choice.

### The actual policy adopted

Six rules: (1) each business unit operates its own code repository and monolith, provisions few services, and rarely works in other units' monoliths — nuanced cases should move closer to this policy; (2) new integrations across business unit monoliths use gRPC; migrating existing HTTP/JSON integrations is desirable but not urgent; (3) subtle decisions (changing an existing endpoint) optimize for business velocity, clear-cut decisions (a brand-new endpoint) must comply; (4) no new services except new business unit monoliths — provisioning one requires CTO approval in the #eng-strategy channel; (5) approval is generally denied unless the service needs significantly different nonfunctional requirements, like higher compliance review or radically higher requests per second; (6) teams are encouraged to merge existing stray services back into their business unit's monolith, deciding case by case in their local context. All exceptions escalate to a local Staff-plus engineer, then with that engineer to the CTO.

Illustrates: a complete, operational service-architecture policy — strict on irreversible additions, deferential on local cleanup.

### The funding squeeze diagnosis

Growth in the primary business line is shrinking; the company's strategy is to spin up adjacent business units to increase average contract value with new products. The new units must be funded without growing the overall budget, so money comes from the core business or platform teams. The core business is also under direct pressure to become more efficient, and since accelerating growth while reducing investment is challenging, most improvement will likely come from reduced investment. Meanwhile infrastructure is 150 engineers supporting 350 product engineers, certain not to grow significantly in the foreseeable future, even as two new business units launched in the past six months and two more are planned within the next year.

Illustrates: how business-side budget mechanics, not technical taste, set the boundaries an architecture policy must respect.

### The cost-allocation trap

Platform costs are allocated to business units proportional to revenue. The core business generates most revenue, so it absorbs most platform costs — including costs actually driven by the new business lines. Because the core business must improve its efficiency, there is strong financial pressure to cut platform spend at the very moment new business units are increasing the platform burden. The diagnosis concludes the company has "little tolerance for anything that increases infrastructure overhead."

Illustrates: how an accounting methodology creates engineering constraints; a services-heavy architecture would be financially untenable here regardless of technical merit.

### The general manager who refused on-call

Each business unit is led by a general manager, and whether CTO/CPO practice standards or the GM's direction wins any debate is situationally specific. One business unit's GM insists on-call rotations are wasteful, so the team often does not respond to pages — even when their service is destabilizing shared functionality.

Illustrates: why the policy scopes monoliths to business units rather than sharing one monolith — a misbehaving service can be rate-limited far more easily than a misbehaving codepath inside a shared service can be fixed, and central standards cannot be assumed enforceable.

### The payments service exception

The company has a payments service that moves money from customers to the company. Compliance and security requirements for changes to it are far higher than for other software "because the blast radius is essentially infinite."

Illustrates: the legitimate template for granting a new-service exception — significantly different nonfunctional requirements, not team preference.

### Ruby as an architectural constraint

The primary language is Ruby, which generally relies on blocking IO; service-oriented architectures generally spend more time on blocking IO than monoliths do. Ruby is also relatively inefficient at serializing and deserializing JSON, which cross-service communication requires.

Illustrates: language runtime characteristics changing the cost-benefit math of services for a specific company.

### The lingering partial migrations

Previous decomposition attempts left a set of partial migrations that do not align with the current business unit ownership structure. The number of these orphaned services keeps growing, burdening infrastructure now and product teams later as reorganizations shuffle ownership. The company also observed that reorg-driven ownership churn counteracts much of the initial productivity gain from extracting services.

Illustrates: the long tail cost of incomplete migrations, and why the policy encourages winding stray services back into monoliths.

## Smaller illustrations from the chapter

### Kelsey Hightower's 2017 tweet

Hightower predicted that "Monolithic applications will be back in style after people discover the drawbacks of distributed monolithic applications." The chapter uses it twice: as the marker of when industry sentiment began reversing on microservices, and as shorthand for the distributed-monolith failure mode.

Illustrates: the industry pendulum from microservices enthusiasm back toward monoliths.

### New companies versus five-year-old companies

Because the cloud problems that motivated services have mellowed (cloud-native defaults, better PostgreSQL, package caches, cheap compute, faster languages, incremental typing), a new emerging company today likely runs one monolith with one backend and one frontend language. A five-plus-year-old company might look like almost anything; one particularly common case is a monolith holding most functionality plus an inconsistent constellation of team-scoped macroservices scattered across the organization.

Illustrates: company age predicts architecture, and most strategy work addresses the inherited-hybrid case.

### ZIRP's end and the retreat from services

Service-oriented architectures tend to require more infrastructure to operate efficiently — service meshes, provisioning and deprovisioning tooling. Properly tuned they ought to be cost competitive and potentially superior for complex workloads, but post-zero-interest-rate cost-cutting makes sustaining that infrastructure investment hard. This pushed new companies toward monoliths and pushed existing companies to attempt reversing earlier decompositions, "with mixed results."

Illustrates: macroeconomic conditions changing which architecture is viable, independent of technical arguments.

### Stripe, Calm, and Carta

The author notes he could have written most of this strategy document about Stripe, Calm, or even Carta — but the details would have differed in every case. Copying any one company's exact approach to another would have gone quite poorly; copying the general strokes worked quite well.

Illustrates: strategies port across companies in broad strokes only; details must be rederived from each company's own diagnosis.

### The refactored document structure

Relative to the book's default strategy structure, this document folds the Operation section into Policy and embeds Refine inside Diagnose. The chapter also advises reading the document top-to-bottom to apply it, but in reverse order (Explore, then Diagnose, then Policy) to understand the thinking behind it.

Illustrates: strategy documents are written for readers, not in thinking order, and their structure may be refactored for readability.
