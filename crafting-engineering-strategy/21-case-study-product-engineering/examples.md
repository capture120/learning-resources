# Chapter 21: Product Engineering Strategy — Examples

This chapter is itself a worked example: two reconstructed strategy documents from Will Larson's tenure as CTO of Calm. The sections below capture the concrete documents (policies, diagnoses, operational mechanisms) and the smaller illustrations used along the way.

## The setting: a scattered startup engineering team

When Larson joined Calm as CTO — his first executive role, after nonexecutive strategy work like Uber's service migration — the engineering team was scattered across competing concerns: should they build more scalable infrastructure? Was failing to adopt leading programming languages their greatest risk? How could they rescue a stuck service decomposition initiative? The two strategy documents below are where the team landed after numerous rounds of iteration, debate, and some disagreement.

Illustrates: the typical strategic vacuum at a startup, and that mandated executive strategy still emerges through iteration and debate rather than decree.

## Worked example 1: Document 21-1, "We're a Product Engineering Company!"

### The policies and operating mechanisms

- **We are a product engineering company.** Users write in every day saying the product changed their lives; the infrastructure doesn't get many such letters, and that is unlikely to change because it is low-scale and low-complexity. Devote maximum possible attention to product engineering.
- **New technologies are adopted exclusively to create valuable product capabilities.** The current stack can handle the majority of current and future roadmaps. Adoption happens only when a product capability is inherently impossible without the new technology — never because someone wants to learn it, and never because it is 30% better suited to a task.
- **All new code is written in the monolith.** What was previously ambiguous (JavaScript monolith vs new services) is now explicit: all new code goes in the monolith. If a functional requirement makes that implausible, request an exception.
- **Exceptions are granted by the CTO, in writing only.** The policies are deliberately restrictive and will sometimes be wrong; exceptions exist for that. But each must be deliberate and grounded in a concrete problem everyone is aligned both on solving and on how to solve — otherwise everyone scatters toward preferred solutions and creates negative leverage. If there is no written CTO approval, the exception is not approved.

Illustrates: a complete restrictive-defaults-plus-written-exceptions policy set for a low-complexity consumer product company.

### The two real exceptions that prove the mechanism

1. **Incremental TypeScript migration.** Static typing was found to prevent user-facing bugs, and TypeScript offered a clean incremental path from the JavaScript codebase. Goal: migrate everything within six months. Owner: the Web engineering team.
2. **Evaluating Postgres Aurora as primary database.** Many recent production incidents were caused by index scans on tables with high write velocity (such as customer-login tracking); Aurora was expected to handle these workloads better. Owner: the Infrastructure engineering team.

Illustrates: exceptions done right — each tied to a concrete observed problem, scoped, and owned by a named team; their existence proves the exception process is real, not theoretical.

### The diagnosis behind Document 21-1

- Nothing on the current or one-year roadmap was constrained by missing infrastructure capabilities.
- Uptime, stability, and latency were "OK but not great," with issues traced to exactly two causes: deploying code with a missing index that performed fine in test environments, and expensive writes combined with index scans on a small number of extremely large, skinny tables.
- Three infrastructure engineers supported 30 product engineers, with the team split between supporting monolith and service workflows; maintenance load (one way to measure technical debt) was meaningful but not overwhelming. However, they were increasingly dragged into incidents for components moved out of the monolith into services — partly from increased inherent complexity, but more from those services' lack of monitoring and ambiguous accountability.
- Product and executive stakeholders experienced engineering as "competing factions": radically different answers depending on which engineer they asked, and group discussions that derailed into approach debates instead of producing a clear point of view. The document frames why this matters: engineering exists to build and operate software for the company, and part of that is being easy to work with — not supporting every Product ask (e.g., ones misaligned with goals like maintaining security), but generally presenting a consistent perspective.
- An outsized amount of time went to debating technology adoptions and rewrites — extend a feature or migrate it to a service first? Database or new Redis cache? Is JavaScript enough or rewrite in Go? — most acutely around a services migration that had been in flight for over a year without moving any core production code.
- Net result: more time on infrastructure and platform work than product work, at odds with stakeholder expectations.

Illustrates: an honest, specific diagnosis that names technical root causes, organizational dynamics, and stakeholder perception as equal inputs.

### The exploration behind Document 21-1: Calm's architecture and the industry current

Calm is a mobile app guiding users to build meditation or sleep habits. Recommendations are individualized, but the content itself is shared across all customers and CDN-cacheable — so the app stays usable even if all non-CDN production infrastructure is unreachable. In 2010, a product of this complexity would have required significant bespoke infrastructure and likely a physical datacenter presence; by 2020, comparable applications generally minimize internal infrastructure, and new companies founded in this space treat essentially all of it as a commodity bought from a cloud provider — even ML, with training on offerings like AWS Bedrock and models from Anthropic or OpenAI. Reference points: Intercom's "Run Less Software" and Dan McKinley's "Choose Boring Technology."

Illustrates: validating a strategy against the product's actual architecture and the direction the industry is already moving.

## Worked example 2: Document 21-2, How to Resource Engineering-Driven Projects

### The context

In 2020, Calm was growing rapidly through the COVID-19 pandemic. The team felt saturated by incoming requests and struggled to make improvements — the classic Product-vs-Engineering tension between new functionality and improving what exists (a sibling of broader long-vs-short-term tradeoffs, like scaling under ramping load while known security vulnerabilities wait). The prior prevailing belief within Engineering was that the company was not willing to make such investments; this strategy was the attempt to solve that problem.

Illustrates: the universal balance problem this mechanism solves.

### The policies and operating mechanisms

- One protected Engineering-driven project per product engineering team, per quarter, at a maximum of 20% of team bandwidth.
- Each project must advance a measurable metric and be designed to show progress on that metric within four weeks.
- Projects must adhere to Calm's existing engineering strategies (Document 21-1).
- These projects are resourced **first** in team planning, not last — but only concrete projects get resourced; no concrete proposal means no budgeted time.
- The engineering manager decides the project, ensures it is valuable, and pushes back on attempts to defund it.
- Selection needs no CTO approval, but friction or disagreement escalates to the CTO.
- The CTO reviews all engineering-driven projects quarterly: summarizing impact, giving engineering managers feedback on selection and execution, and reviewing teams that ran no project to understand why.

Illustrates: a complete structural mechanism for protecting improvement work from short-term pressure.

Communicating this strategy frequently produced conceptual alignment ("sounds reasonable") coupled with uncertainty about what projects should actually be selected — an ambiguity that partly reflects the belief that teams will identify the best opportunities bottoms-up. To answer it, the document greenlit two concrete examples in the first batch:

### Greenlit example project: code-free media release

Releasing new media historically required multiple pull requests to add, organize, and publish content. The work was high-urgency but exercised little engineering judgment, and manual steps often introduced errors. The project tracks and eliminates these pull requests while increasing the number of releases possible without growing the content release team.

Illustrates: a qualifying engineering-driven project — measurable (PR count, release throughput), removes low-value engineering involvement, empowers another team.

### Greenlit example project: machine learning content placement

New media often takes weeks or months to produce, and once ready, debates erupt over where to place it — placement drives user engagement for the company and performance evaluations for the content creator, repeatedly entangling Product and Engineering in placement arguments. The project surfaces the best content for each user's interests via ML while giving the Content team several explicit positions to highlight content without Product or Engineering involvement.

Illustrates: an engineering-driven project that improves a user metric (engagement) while removing a recurring cross-team conflict. The document notes the two examples' similarity is happenstance, not a template — teams choose their own biggest opportunities bottoms-up.

### The diagnosis behind Document 21-2

- About one-third of engineering time went into launching, debugging, and changing content releases — involvement driven by implementation limitations, not by inherent value ("We mostly just make releases slowly and inadvertently introduce bugs of our own").
- Clear ideas existed for empowering the Content team and eliminating engineering involvement, but the team struggled to find time to implement or validate them.
- Without prioritizing and finishing such a project, Calm would struggle to support its goals to release more content and develop more product functionality that year.
- The Infrastructure team could make these investments stick, but product engineering teams got projects onto the initial roadmap only to see them deprioritized under delivery pressure.
- The 20-engineer team was not very fungible (iOS, Android, Backend, Frontend, Infrastructure, QA specialization); Infrastructure lacked the product development experience to take this work over.
- A new Platform team or moving product engineers into Infrastructure was rejected: it would either break the goal of joint Product Manager / Engineering Manager pairs, or be indistinguishable from prioritizing within the existing team since the same PM/EM pair would run it.
- Company planning was organic — many discussions, limited structured process — so an investment decision could easily be reversed in a side discussion missing context, in either executive or team-specific forums, with imperfect awareness between the two.

Illustrates: diagnosing why improvement projects kept dying, and pre-emptively ruling out the obvious structural alternatives.

### The exploration behind Document 21-2: a survey of prioritization mechanisms

- **RICE scoring**: priority = (Reach × Impact × Confidence) ÷ Effort, widely used as a generalized planning method.
- **Scaled Agile Framework (SAFe)**: the complex-methodology extreme of generalized planning.
- **Google's 20% time**: a carve-out letting individuals pursue experimental projects that didn't align directly with top-down priorities.
- **Stripe's Foundational Initiatives**: a Foundation Engineering mechanism to prioritize cross-pillar projects with long-term implications that otherwise struggled to get prioritized within team-led planning.

Every one of these has clear successes and clear failures. The differentiator: success cases had an engaged executive sponsoring the rollout, including triaging escalations when it inconvenienced supporters of the prior method. Without a sponsor, or when misaligned with company culture, the methods consistently failed despite succeeding elsewhere.

Illustrates: the mechanism you pick matters less than executive sponsorship and cultural fit.

## Closing contrast: the new-executive anti-pattern

A surprising number of executives begin new roles by mandating a brand-new process or architecture. The Calm documents demonstrate a different approach Larson has consistently found more effective: identify approaches already working well inside the company and eliminate the less effective competing ones. At its best, selecting from existing successful techniques lets you bypass strategy refinement entirely.

Illustrates: the chapter's summary lesson — curate and prune what exists rather than imposing novelty.
