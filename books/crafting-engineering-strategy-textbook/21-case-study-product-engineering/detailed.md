# Chapter 21: Product Engineering Strategy — Detailed Reference

## Introduction

The majority of the strategy work in Larson's career was done in nonexecutive roles — things like Uber's service migration (presented as Document 16-1 elsewhere in the book). Joining Calm was his first executive role, where he was able to "not only propose but also mandate strategy."

Like almost all startups, the engineering team at Calm was scattered when he joined. The open, competing questions at the time:

- Was the most important work creating more scalable infrastructure?
- Was the greatest risk the failure to adopt leading programming languages?
- How could the stuck service decomposition initiative be rescued?

The strategies in this chapter are where the Calm engineering team and Larson aligned after "numerous rounds of iteration, debate, and inevitably some disagreement." As strategies, they are "both basic and also unambiguous about our values," and Larson believes they are "a reasonably good starting point for any low scalability-complexity consumer product."

## Reading These Documents

The documents in this chapter are rewritten from memory to capture the strategies pursued during Larson's time at Calm. They are:

- **Document 21-1: "We're a Product Engineering Company!": Engineering Strategy at Calm** — outlines Calm's strategy for focusing on product engineering work, explicitly not focusing on infrastructure-style foundational work, and the rationale behind that approach.
- **Document 21-2: How to Resource Engineering-Driven Projects at Calm** — summarizes Calm's approach to investing in Engineering priorities when the prior prevailing belief within Engineering was that the company was not willing to make such investments.

How to read them depends on your goal:

- If your goal is **applying** the strategies they put forward: start at the top and read to the end.
- If your main goal is **understanding the thinking** behind them: read the sections in reverse order — starting with Explore, then Diagnose, and so on.

Chapter 11 explains this approach to separating reading from thinking, and details the general structure of strategy documents.

## Document 21-1: "We're a Product Engineering Company!": Engineering Strategy at Calm

### Policy and Operation

The new policies, and the mechanisms to operate them:

- **We are a product engineering company.** Users write in every day to tell Calm that the product has changed their lives for the better. The technical infrastructure "doesn't get many user letters" — and this is unlikely to change going forward, because the infrastructure is relatively low-scale and low-complexity. Rather than attempting to change that, the company wants to devote "the absolute maximum possible attention to product engineering."

- **We exclusively adopt new technologies to create valuable product capabilities.** The belief: the technology stack as it exists today can solve the majority of current and future product roadmaps. In the rare case where a new technology is adopted, it is adopted because a product capability is *inherently impossible* without adopting that new technology.
  - **New technologies are not adopted for other reasons.** Two explicit examples of disqualified reasons: a technology would not be adopted because someone is interested in learning about it; nor would a technology be adopted because it is "30% better suited to a task."

- **We write all code in the monolith.** It had been ambiguous whether new code (especially new application code) should be written in the JavaScript monolith, or whether all new code must be written in a new service outside of the monolith. "This is no longer ambiguous: all new code must be written in the monolith."
  - In the rare case that there is a functional requirement that makes writing in the monolith implausible, you should request an exception, as described in the exception policy below.

- **Exceptions are granted by the CTO, and must be in writing.** The above policies are deliberately restrictive. Sometimes they may be wrong, and exceptions will be made to them. However, each exception should be deliberate and grounded in concrete problems the team is aligned on — both on solving them and on how to solve them. The rationale: "If we all scatter toward our preferred solution, then we'll create negative leverage for Calm rather than serving as the engine that advances our product."

- **All exceptions must be written.** If an exception is not written, you should operate as if it has not been granted. The goal is to avoid ambiguity around whether an exception has, or has not, been approved. "If there's no written record that the CTO approved it, then it's not approved."

Proving the point about exceptions, there are two confirmed exceptions to this strategy:

1. **Incremental migration to TypeScript.** The team found that static typing can prevent a number of user-facing bugs. TypeScript provides a clean, incremental migration path for the JavaScript codebase, and the aim is to migrate the entirety over the next six months. The Web engineering team is leading this migration.
2. **Evaluating Postgres Aurora as the primary database.** Many recent production incidents were caused by index scans for tables with high write velocity, such as tracking customer logins. The belief is that Aurora will perform better under these workloads. The Infrastructure engineering team is leading this initiative.

### Diagnose

The current state of the engineering organization:

- **The product is not limited by missing infrastructure capabilities.** Reviewing the roadmap, there is nothing the team is trying to build today, or over the next year, that is constrained by the technical infrastructure.

- **Uptime, stability, and latency are OK but not great.** There are semi-frequent stability and latency issues in the application, all of which are caused by one of two issues:
  1. Deploying new code with a missing index, because it performed well enough in a test environment.
  2. Writes to a small number of extremely large, skinny tables have become expensive in combination with scans over those tables' indexes.

- **The infrastructure team is split between supporting monolith and service workflows.** One way to measure technical debt is to understand how much time the team is spending maintaining the current infrastructure. Today, that is meaningful but not overwhelming work for the team of three infrastructure engineers supporting 30 product engineers.
  - However, infrastructure engineers are increasingly pulled into debugging incidents for components moved out of the central monolith into the service architecture. This is partially due to increased inherent complexity, but it is more due to exposing the lack of monitoring and the ambiguous accountability in services' production incidents.

- **Product and executive stakeholders experience Engineering as competing factions.** Engineering exists to build and operate software in the company. Part of that is being easy to work with. Engineering should not necessarily support every ask from Product if those asks are believed to be misaligned with Engineering's goals (e.g., maintaining security), but it should generally provide a consistent perspective across the team.
  - Today, stakeholders believe they will get radically different answers to basic questions of capabilities and approach depending on who they ask. If they try to get a group of engineers to agree on an approach, they often find the group derails into debate about the approach rather than articulating a clear point of view that allows the conversation to move forward.

- **An outsized amount of time is spent debating technology adoptions and rewrites.** Most disagreements stem from adopting new technologies or rewriting existing components into new technology stacks. Examples of recurring debate forms: Can this feature be extended, or does it have to be migrated to a service before extending it? Can this be added to the database, or should it move into a new Redis cache instead? Is JavaScript a sufficient programming language, or does this functionality need to be rewritten in Go?
  - This is particularly relevant to next steps around the ongoing services migration, which has been in-flight for over a year but is yet to move any core production code.

- **More time is being spent on infrastructure and platform work than product work.** This is the combination of all the above issues — from the stability issues encountered in the database design, to the lack of engineering alignment on execution. This places Engineering at odds with stakeholders' expectations that it is predominantly focused on new product development.

### Explore

Calm is a mobile application that guides users to build and maintain either a meditation or sleep habit. Recommendations and guidance across content are individual to the user, but the content is shared across all customers and is amenable to caching on a content delivery network (CDN). As long as the CDN is available, the mobile application can operate despite the inability to access servers — i.e., the application remains usable from a user's perspective even if the non-CDN production infrastructure is unreachable.

In 2010, enabling a product of this complexity would have required significant bespoke infrastructure, along with likely maintaining a physical presence in a series of datacenters to run the software. In 2020, comparable applications are generally moving toward maintaining as little internal infrastructure as possible. This perspective is summarized effectively in two references: Intercom's "Run Less Software" and Dan McKinley's "Choose Boring Technology."

New companies founded in this space view essentially all infrastructure as a commodity bought off your cloud provider. This even extends to areas of innovation, such as machine learning, where the training infrastructure is typically run on an offering like AWS Bedrock, and the model infrastructure is provided by Anthropic or OpenAI.

## Document 21-2: How to Resource Engineering-Driven Projects at Calm

One of the recurring challenges in any organization is how to split attention across long-term and short-term problems. Example tension: your software might be struggling to scale with ramping user load, while you also know you have a series of meaningful security vulnerabilities that need to be closed sooner rather than later. How do you balance across them?

These sorts of balance questions occur at every level of an organization. A particularly frequent format is the debate between Product and Engineering about how much time goes toward developing new functionality versus improving what's already been implemented. In 2020, Calm was growing rapidly while navigating the COVID-19 pandemic, and the team was struggling to make improvements, as they felt saturated by incoming new requests. This strategy for resourcing Engineering-driven projects was the attempt to solve that problem.

### Policy and Operation

The policies for resourcing Engineering-driven projects:

- **One Engineering-driven project will be protected per product engineering team, per quarter.** These projects should represent a maximum of 20% of the team's bandwidth. Each project must advance a measurable metric, and execution must be designed to show progress on that metric within four weeks.
- **These projects must adhere to Calm's existing Engineering strategies** (see Document 21-1).
- **These projects are resourced first in the team's planning, rather than last.** However, only concrete projects are resourced. If there are no concrete proposals, then the team won't have time budgeted for Engineering-driven work.
- **The team's engineering manager is responsible** for deciding on the project, ensuring the project is valuable, and pushing back on attempts to defund the project.
- **Project selection does not require CTO approval**, but you should escalate to the CTO if there's friction or disagreement.
- **The CTO will review Engineering-driven projects each quarter** to summarize their impact and provide feedback to teams' engineering managers on project selection and execution. The CTO will also review teams that did not perform a project, to understand why not.

In communicating this strategy, the response was frequently conceptual alignment — that this sounds reasonable — coupled with uncertainty about what sort of projects should actually be selected. At some level, this ambiguity is an acknowledgment of the belief that teams will identify the best opportunities bottoms-up. However, the document also gives two concrete examples of projects greenlit in the first batch:

- **Code-free media release.** Historically, adding, organizing, and releasing new pieces of media has required a number of pull requests. This is high-urgency work, but Engineering doesn't exercise much judgment while doing it, and manual steps often create errors. The project aims to track and eliminate these pull requests, while also increasing the number of releases that can be facilitated without scaling the content release team.
- **Machine learning content placement.** Developing new pieces of media is often a multi-week or multi-month process. After content is ready to release, there's generally a debate on where to place it. Placement matters for the company, because it drives user engagement, but it matters even more to the content creator, who is generally evaluated in terms of their content's performance. This often leads to Product and Engineering getting caught up in debates about how to surface particular pieces of content. The project aims to improve user engagement by surfacing the best content for each user's interests, while also giving the Content team several explicit positions to highlight content without Product and Engineering involvement.

Although these two projects are similar, it is not intended that all Engineering-driven projects be of this variety. Instead, the similarity is happenstance based on what the teams view as their biggest opportunities today.

### Diagnosis

The assessment of the current situation at Calm:

- **A high percentage of time is going to urgent but low-engineering-value tasks.** Most significantly, about one-third of engineering time goes into launching, debugging, and changing content released into the product. Engineering is involved due to implementation limitations, not because its involvement adds inherent value. ("We mostly just make releases slowly and inadvertently introduce bugs of our own.")
- **Clear improvement ideas exist but never get implemented.** There are a number of fairly clear ideas for improving the platform to empower the Content team to speed up releases and to eliminate Engineering involvement. However, the team has struggled to find time to implement them, or to validate that the ideas will work.
- **The stakes of inaction:** if a project to reduce Engineering involvement in Content releases is not prioritized and successfully implemented, the team will struggle to support its goals to release more content and to develop more product functionality this year.
- **The Infrastructure team has been able to plan and make these kinds of investments stick; in Product Engineering teams, things don't go that well.** When such projects are attempted within Product Engineering teams, things don't go well: the projects make it onto the initial roadmap, but then get deprioritized due to pressure to complete other projects.
- **The Engineering team of 20 engineers is not very fungible**, largely due to specialization across roles like iOS, Android, Backend, Frontend, Infrastructure, and QA. The preference would be to staff these kinds of projects onto the Infrastructure team, but in practice that team does not have the product development experience to implement this kind of project.
- **Structural alternatives were considered and rejected.** Spinning up a Platform team, or moving product engineers onto Infrastructure, was discussed — but that would either (1) break the goal of maintaining joint pairs between Product Managers and Engineering Managers, or (2) be indistinguishable from prioritizing within the existing team, because it would still have the same Product Manager and Engineering Manager pair.
- **Company planning is organic**, occurring in many discussions and limited structured processes. If a decision is made to invest in one project, it's easy for that project to get deprioritized in a side discussion missing context on why the project is important.
  - These reprioritization discussions happen both in executive forums and in team-specific forums, and there is imperfect awareness across these two sorts of forums.

### Explore

Prioritization is a deep topic with a wide variety of popular solutions:

- Many software companies rely on **"RICE" scoring**, calculating priority as (Reach times Impact times Confidence) divided by Effort.
- At the other extreme are complex methodologies like the **Scaled Agile Framework**.

In addition to generalized planning solutions, many companies carve out special mechanisms to solve for particular prioritization gaps:

- **Google** historically offered **20% time** to allow individuals to work on experimental projects that didn't align directly with top-down priorities.
- **Stripe's Foundation Engineering** organization developed the concept of **Foundational Initiatives** to prioritize cross-pillar projects with long-term implications; these projects otherwise struggled to get prioritized within the team-led planning process.

All of these methods have clear examples of succeeding, and equally clear examples of struggling. Where these initiatives succeeded, they had an engaged executive sponsoring the practice's rollout — including triaging escalations when the rollout inconvenienced supporters of the prior method. Where they lacked a sponsor, or were misaligned with the company's culture, these methods have consistently failed, despite the fact that they had previously succeeded elsewhere.

## Summary

A surprising number of executives start new roles by mandating a brand-new process or architecture. These Calm strategy documents capture a different approach that Larson has consistently found more effective: identifying approaches that are already working well within the company, and eliminating the less effective, competing approaches. At its best, selecting from existing, successful techniques means you can bypass strategy refinement entirely.
