# Chapter 16: Service Migration Strategy — Detailed Reference

## Chapter Introduction

In early 2014, Will Larson joined Uber as an engineering manager for the Infrastructure team. The team was responsible for a wide range of tasks, including provisioning new services. While the overall team Larson led grew significantly over time, the subset working on service provisioning never grew beyond four engineers.

Those four engineers successfully migrated 1,000+ services onto a new, future-proofed service platform. More importantly, that small team did it while absorbing the majority — although certainly not the entirety — of the migration workload, rather than spreading that workload across the 2,000+ engineers working at Uber at the time.

Their strategy serves as an interesting case study of how a team can drive strategy, even without any executive sponsor, by focusing on solving a pressing user problem — and providing effective ergonomics while doing so.

## Reading These Documents

The documents in this chapter are recreations intended to capture Larson's time at Uber, written from the perspective of 2014. They should be read as internal documents, written from the service provisioning team's perspective. They are:

- **Document 16-1: Service Migration Strategy** — The Infrastructure team's approach to facilitating migration out of Uber's Python monolith.
- **Document 16-2: Service Onboarding Model** — A systems model of why service provisioning was going slowly.
- **Document 16-3: Wardley Mapping the Service Orchestration Ecosystem** — A Wardley map of how the team predicted service orchestration would evolve.

The full implementation of the service onboarding systems model is available on GitHub.

How to read depends on your goal:

- If your goal is **applying the strategies** the documents put forward, start at the top and read to the end.
- If your main goal is **understanding the thinking** behind them, read the sections in reverse order: starting with Explore, then Diagnose, and so on.

Chapter 11 explains this approach to separating reading from thinking, and details the general structure of strategy documents. Chapters 14 and 15 provide similar guides to reading and writing systems models and Wardley maps, respectively. Larson's commentary on the documents appears in footnotes (reproduced in this reference at the points where they occur).

## Document 16-1: Service Migration Strategy: Uber

### Policy and Operation

The team adopted these guiding principles for extending Uber's service platform:

1. **Constrain manual provisioning allocation to maximize investment in self-service provisioning.** The service provisioning team will maintain a fixed allocation of one full-time engineer on manual service-provisioning tasks. The remaining engineers move to work on automation to speed up future service provisioning. This will degrade manual provisioning in the short term, but the alternative is *permanently* degrading provisioning by the influx of new service requests from newly hired product engineers.

2. **Self-service must be safely usable by a new hire without Uber context.** It is possible today to make a Puppet or Clusto change while provisioning a new service that negatively impacts the production environment. This must not be true in any self-service solution.

3. **Move to structured requests, and out of tickets.** Missing or incorrect information in provisioning requests creates significant delays in provisioning. Further, collecting this information is the first step of moving to a self-service process. As such, the team can "get paid twice": reducing errors in manual provisioning while also creating the interface for self-service workflows.

4. **Prefer initializing new services with good defaults rather than requiring user input.** Most new services are provisioned for new projects with strong timeline pressure but little certainty on their long-term requirements. These users cannot accurately predict their future needs, and expecting them to do so creates significant friction. Instead, the provisioning framework should suggest good defaults and make it easy to change the settings later when users have more clarity. The gate from development environment to production environment is a particularly effective one for ensuring settings are refreshed.

Those principles materialize into this sequenced set of tasks:

1. Create an internal tool that coordinates service provisioning, replacing the process where teams request new services via Phabricator tickets. This new tool will maintain a schema of required fields that must be supplied, with the aim of eliminating the majority of back and forth between teams during service provisioning.
2. In addition to capturing necessary data, this tool will also serve as the interface for automating various steps in provisioning — without requiring future changes in the workflow used to request service provisioning.
3. Extend the internal tool to generate Puppet scaffolding for new services, reducing the potential for errors in two ways. First, the data supplied in the service provisioning request can be directly included in the rendered template. Second, this will eliminate most human tweaking of templates, where typos can create issues.
4. Port allocation poses a particularly high risk, as reusing a port can break routing to an existing production service. As such, this will be the *first* area fully automated, with the provisioning service supplying the allocated port rather than requiring requesting teams to provide an already allocated port. Doing this requires moving the port registry out of a Phabricator wiki page and into a database, which allows guarding access with a variety of checks.
5. Manual assignment of new services to servers often leads to new services being allocated to already heavily utilized servers. The team will replace the manual assignment with an automated system, and do so with the intention of migrating to the Mesos/Aurora cluster once it is available for production workloads.

**Operational check:** Each week, the team will review the size of the service provisioning queue, along with the service provisioning time, to assess whether the strategy is working or needs to be revised.

**Footnote 1 (on this section):** Relative to the default strategy-document structure, this document makes one tweak: folding the Operation section in with Policy.

**Footnote 2 (on the weekly review):** Although Larson didn't have a name for this practice in 2014 when the team created and implemented this strategy, the section captures an important reality of team-led bottom-up strategy: when you don't have the authority to mandate compliance, you have to get the details right. The best way to do that is a prolonged strategy testing phase. Indeed, because compliance is rooted in effectiveness, Larson's experience is that nonexecutive strategy developers can never stop refining their approach.

### Refine

In order to refine the diagnosis, the team created a systems model for service onboarding (Figure 16-1: "Systems model of provisioning services at Uber circa 2014"). The model allows simulating a variety of different approaches to the problem and determining which approach, or combination of approaches, will be most effective.

As the team exercised the model, it became clear that:

1. **We are increasingly falling behind.**
2. **Hiring onto the service provisioning team is not a viable solution.**
3. **Moving to a self-service approach is our only option.**

While the model writeup (Document 16-2) justifies each of those statements in more detail, the strategy document includes two charts:

- The first chart (Figure 16-2: "Service provisioning model without error states") shows the status quo, where new service-provisioning requests — labeled "Initial RequestedServices" — quickly accumulate into a backlog.
- The second comparison (Figure 16-3: "Impact of self-service provisioning on provisioning rate") compares outcomes between the current status quo and a self-service approach. In that chart, the service provisioning backlog in the self-service model remains steady, represented by the "SelfService RequestedServices" line.

Of the various attempts to find a solution, none of the others showed promise — including eliminating all errors in provisioning, and increasing the team's capacity by 500%.

### Diagnose

The team diagnosed the current state of service provisioning at Uber as:

- Many product engineering teams are aiming to leave the centralized monolith, which is generating **two to three service provisioning requests each week**. This rate is expected to increase roughly linearly with the size of the product engineering organization.
- Even if infrastructure disagrees with this shift to additional services, there's no team responsible for maintaining the extensibility of the monolith, and working in the monolith is **the number one source of developer frustration**, so there is no practical counter-proposal to offer engineers other than provisioning a new service.
- The engineering organization is **doubling every six months**. Consequently, a year from now, expect **eight to twelve service provisioning requests every week**.
- Within infrastructure engineering, there is a team of **four engineers** responsible for service provisioning today. While the infrastructure organization is growing at a similar rate as product engineering, none of that additional headcount is being allocated directly to the team working on service provisioning, and this is not anticipated to change.
- Some additional headcount is being allocated to Service Reliability Engineers (SREs), who can take on the most nuanced, complicated service provisioning work. However, their bandwidth is already heavily constrained across many tasks, so **relying on SREs is an insufficient solution**.
- The queue for service provisioning is **already increasing in size** as things stand today. Barring some change, many services will not be provisioned in a timely fashion.
- Today, provisioning a new service takes **about a week**, with numerous round trips between the requesting team and the provisioning team. **Missing and incorrect information between teams is the largest source of delay** in provisioning services.
- If the provisioning team has all the necessary information and it's accurate, then a new service can be provisioned in about **three to four hours of work**, spanning configuration in Puppet, metadata in Clusto, allocating ports, assigning the service to servers, and so on.
- There are **few safeguards** on port allocation, server assignment, and so on. It is easy to inadvertently cause a production outage during service provisioning unless done with attention to detail.
- Given the rate of hiring, training the engineering organization to use this unsafe toolchain is an impractical solution: "even if we train the entire organization perfectly today, there will be just as many untrained individuals in six months." Further, product engineering leadership has no interest in their teams being diverted to service-provisioning training.
- It's widely agreed across the infrastructure engineering team that **essentially every component of service provisioning should be replaced** as soon as possible, but there is no concrete plan to replace any of the core components. Further, there is **no team accountable** for replacing these components, which means the service provisioning team will either need to work around the current tooling or replace that tooling themselves.
- It's **urgent to unblock development of new services, but moving those new services to production is rarely urgent**, occurring after a long internal development period. Evidence of this: requests to provision a new service generally come with significant urgency and internal escalations to management. After the service is provisioned for development, there are relatively few urgent escalations other than one-off requests for increased production capacity during incidents.
- Another team within infrastructure is actively exploring adoption of **Mesos and Aurora**, but there's no concrete timeline for when this might be available for the provisioning team's usage. Until that team commits to supporting these workloads, an alternative solution is needed.

### Explore

Uber's server and service infrastructure in 2014 is composed of a handful of pieces:

1. Servers run **on-prem within a handful of colocations**.
2. Each server is described in **Puppet manifests** to support repeatable provisioning of servers.
3. Fleet and server metadata is managed in a tool named **Clusto**, originally created by Digg, which allows populating Puppet manifests with server- and cluster-appropriate metadata during provisioning.

In general, the team agrees that the current infrastructure is nearing its end of lifespan, but it's less obvious what the appropriate replacements are for each piece.

There's **significant internal opposition to running in the cloud, up to and including the CEO**, so the team doesn't believe that will change in the foreseeable future. However, the team does believe there's opportunity to change:

- Service definitions: from Puppet to something along the lines of **Docker**.
- The metadata mechanism: toward a more purpose-built solution like **Mesos/Aurora** or **Kubernetes**.

As a starting point, the team found it valuable to read two papers: **"Large-Scale Cluster Management at Google with Borg"**, which informed some elements of the approach to Kubernetes, and **"Mesos: A Platform for Fine-Grained Resource Sharing in the Data Center"**, which describes the Mesos/Aurora approach.

**Footnote 3:** If you're wondering why there's no mention of the article "Borg, Omega, and Kubernetes" — it wasn't published until 2016, after this strategy was developed.

On canvassing for operating experience: within Uber, there are a number of **ex-Twitter engineers who can speak with confidence to their experience operating with Mesos/Aurora at Twitter**. The team was unable to find anyone to speak with who has production Kubernetes experience operating a comparably large fleet of **10,000+ servers** — although presumably someone is operating, or close to operating, Kubernetes at that scale.

The team's general belief about the evolution of the ecosystem is supported by the Wardley mapping exercise on service orchestration (Figure 16-4: "Wardley map of service orchestration"; the exercise itself is Document 16-3).

**Footnote 4:** Wardley mapping is introduced in Chapter 15 as one of the techniques for strategy *refinement*, but it can also be a useful technique for *exploring* a dynamic ecosystem — like service orchestration in 2014. Assembling each strategy requires exercising judgment on how to compile the pieces together most usefully, and in this case Larson found the map fit most naturally with the rest of Explore rather than in the more operationally focused Refine section.

Acknowledged unknowns and rejected options:

- One of the unknowns is **how the evolution of Mesos/Aurora and Kubernetes will look in the future**. Kubernetes seems promising with Google's backing, but there are **few if any meaningful production deployments** today. Mesos/Aurora has more community support and more production deployments, but the **absolute number of deployments remains quite small, and there is no large-scale industry backer outside of Twitter**.
- Even further out, there's considerable excitement around **"serverless" frameworks**, which seem like a likely future evolution. But canvassing the industry and the team's networks turned up insufficient real-world usage to justify making an active push toward this destination today.

## Document 16-2: Service Onboarding Model

At the core of Uber's service migration strategy (2014) is understanding the service onboarding process and identifying the levers to speed up that process. This document develops a systems model representing the onboarding process, then exercises the model to test a number of hypotheses about how best to speed up provisioning.

The document covers:

- Where the model of service onboarding suggested focusing efforts.
- Developing a system model using the **lethain/systems** package on GitHub. The model itself is available in the **lethain/eng-strategy-models** repository.
- Exercising that model to learn from it.

### Learnings

- **Even with a 100% success rate (no errors at all), the backlog of requested new services continues to increase over time** (Figure 16-5: "Service provisioning model without error states"). This clarifies that the problem to be solved is *not* the service provisioning team's efficiency in running their current process, but rather that **the fundamental approach is not working**.
- **Although hiring is tempting as a solution, the model suggests it is not a particularly valuable approach in this scenario** (Figure 16-6: "Impact of infrastructure engineering hiring on service provisioning"). Even increasing the Service Provisioning team's staff allocated to manually provisioning services by **500%** doesn't solve the backlog of incoming requests.
- **If reducing errors doesn't solve the problem, and increased hiring for the team doesn't solve the problem, then manual service provisioning must be eliminated entirely.** The most promising candidate is moving to a **self-service provisioning model**, which the model shows solves the backlog problem effectively (Figure 16-7: "Impact of self-service provisioning on provisioning rate").
- **Refinement of the hiring conclusion:** additional hiring *may* benefit the team — if those hires can be focused on building self-service provisioning, *and* if their productivity can be ramped up faster than the increase of incoming service provisioning requests.

### Sketch

The initial sketch of service provisioning (Figure 16-8: "Systems model of provisioning services") is a simple pipeline starting with **Requested services** and moving step by step through to **Server capacity allocated to service in Clusto**. Some of these steps are likely much slower than others, but the sketch gives a sense of:

- the stages,
- where things might go wrong, and
- what can be measured to evaluate whether the approach to provisioning is working well.

One element worth mentioning: the dotted lines from **Hiring rate** to **Product engineers**, and from **Product engineers** to **Requested services**. These are called **links** — stocks that influence another stock but don't flow directly into it.

**Footnote 5:** A purist would correctly note that links should connect to *flows* rather than *stocks*. That is true! However, when converting this sketch into a model, there are actually several counterintuitive elements that are necessary to model this system but make the sketch less readable. As a modeler, you'll frequently encounter these sorts of tradeoffs, and you'll have to decide what choices best serve your needs in the moment.

The biggest missing element of the initial model is **error flows**, where things can sometimes go wrong in addition to sometimes going right. There are many ways things can go wrong, but the model focuses on a few error flows in particular:

1. **Missing/incorrect information** occurs *twice* in this model, and throws a provisioning request back into the initial provisioning phase where information is collected. When this occurs during **port assignment**, it is a relatively small trip backward. However, when it occurs in **Puppet configuration**, it is a significantly larger step backward.
2. **Puppet error** occurs in the second-to-final stock, **Puppet configuration tested and merged**. This sends requests back one step in the provisioning flow.

Updating the sketch to reflect these flows gives a fairly complete, somewhat nuanced view of the service provisioning flow (Figure 16-9: "Model of provisioning services with error transitions").

Note that the combination of these two flows introduces the possibility of a service being almost fully provisioned, but then traveling from Puppet testing back to Puppet configuration due to a Puppet error, and then backward again to the initial step due to missing/incorrect information. **This means nearly all provisioning progress can be lost if things go wrong.**

There are more nuances that could be introduced, but there's already enough complexity here to learn quite a bit from this model.

### Reason

Studying the sketches, a few things stand out:

1. **The hiring of product engineers is going to drive up service provisioning requests over time, but there's no counterbalancing hiring of infrastructure engineers to work on service provisioning.** This means there's an *implicit, but very real, deadline* to scale this process independently of the size of the infrastructure engineering team. Even without building the full model, it's clear the options are exactly three: (a) stop hiring product engineers, (b) turn this into a self-service solution, or (c) find a new mechanism to discourage service provisioning.
2. **The size of error rates is going to influence results a great deal, particularly those for Missing/incorrect information.** This is probably the most valuable place to start looking for efficiency improvements.
3. **Error costs are asymmetric relative to what the model implies.** Missing information errors are *more* expensive than the model implies, because they require coordination across teams to resolve. Conversely, Puppet testing errors are probably *cheaper* than the model implies, because they should be solvable within the same team and consequently benefit from a quick iteration loop.

With those observations in hand, the next step is to build a model that helps guide inquiry into those questions.

### Model

The full implementation of this model is on GitHub (lethain/eng-strategy-models); the document shows emphasized snippets.

First, the success states:

```
HiringRate(10)
ProductEngineers(1000)
[PotentialHires] > ProductEngineers @ HiringRate

[PotentialServices] > RequestedServices(10) @ ProductEngineers / 10
RequestedServices > InflightServices(0, 10) @ Leak(1.0)
InflightServices > PortNameAssigned @ Leak(1.0)
PortNameAssigned > PuppetGenerated @ Leak(1.0)
PuppetGenerated > PuppetConfigMerged @ Leak(1.0)
PuppetConfigMerged > ServerCapacityAllocated @ Leak(1.0)
```

Running this model shows (Figure 16-10: "Service provisioning model without error states") that the number of requested services grows significantly over time. This makes sense: only a maximum of 10 services can be provisioned per round (the inflight-services cap).

However, this is also the *best case*, because it doesn't capture the three error states:

1. Unique port and name assignment can fail because of missing or incorrect information.
2. Puppet configuration can also fail due to missing or incorrect information.
3. Puppet configurations can have errors in them, requiring rework.

Updating the model to include these failure modes, starting with unique port and name assignments. The error-free version:

```
InflightServices > PortNameAssigned @ Leak(1.0)
```

Adding an error rate where 20% of requests are missing information and return to the inflight services stock (so stated in the original text; the snippet itself routes them to RequestedServices):

```
PortNameAssigned > PuppetGenerated @ Leak(0.8)
PortNameAssigned > RequestedServices @ Leak(0.2)
```

The same for Puppet configuration errors:

```
# original version
PuppetGenerated > PuppetConfigMerged @ Leak(1.0)

# updated version with errors
PuppetGenerated > PuppetConfigMerged @ Leak(0.8)
PuppetGenerated > InflightServices @ Leak(0.2)
```

Finally, a similar change to represent errors made in the Puppet templates themselves:

```
# original version
PuppetConfigMerged > ServerCapacityAllocated @ Leak(1.0)

# updated version with errors
PuppetConfigMerged > ServerCapacityAllocated @ Leak(0.8)
PuppetConfigMerged > PuppetGenerated @ Leak(0.2)
```

Even with these relatively low error rates, the throughput of the overall system is meaningfully impacted by introducing the errors (Figure 16-11: "Service provisioning model with error states").

With the foundation of the model built, it's time to start exercising the model to understand the problem space better.

### Exercise

**Test set 1: Which errors matter most?** The errors are known to impact throughput; the first exercise narrows down which errors matter most by increasing the error rate for each of them *independently* and comparing the impact. Three new specifications were created, each increasing one error from a 20% error rate to a 50% error rate:

```
# test 1: port assignment errors increased
PortNameAssigned > PuppetGenerated @ Leak(0.5)
PortNameAssigned > RequestedServices @ Leak(0.5)

# test 2: puppet generated errors increased
PuppetGenerated > PuppetConfigMerged @ Leak(0.5)
PuppetGenerated > InflightServices @ Leak(0.5)

# test 3: puppet merged errors increased
PuppetConfigMerged > ServerCapacityAllocated @ Leak(0.5)
PuppetConfigMerged > PuppetGenerated @ Leak(0.5)
```

Comparing the impact of increasing the error rates from 20% to 50% in each of the three error loops gives a sense of the model's sensitivity to each error (Figure 16-12: "Impact of error rates across stages of provisioning").

That chart captures why exercising is so impactful: **during sketching, the team had assumed that errors in Puppet generation would matter the most because they caused a long trip backward — but it turns out a very high error rate early in the process matters even more, because there are still multiple other potential errors later on that compound on its increase.**

**Test set 2: Does hiring more manual provisioners work?** The impact of hiring more people onto the service provisioning team to manually provision more services is modeled by increasing the maximum size of the inflight services stock from 10 to 50:

```
# initial model
RequestedServices > InflightServices(0, 10) @ Leak(1.0)

# with 5x capacity!
RequestedServices > InflightServices(0, 50) @ Leak(1.0)
```

Unfortunately (Figure 16-13: "Impact of infrastructure engineering hiring on service provisioning"), even increasing the team's capacity by 500% doesn't solve the backlog of requested services. There's some impact, but not that much, and the backlog of requested services remains extremely high. Conclusion: **more infrastructure hiring isn't the solution.**

**Test set 3: Does self-service work?** The impact of moving to self-service is simulated by removing the maximum size from inflight services entirely:

```
# initial model
RequestedServices > InflightServices(0, 10) @ Leak(1.0)

# simulating self-service
RequestedServices > InflightServices(0) @ Leak(1.0)
```

Figure 16-14 ("Impact of self-service provisioning on provisioning rate") shows that this **finally solves the backlog**.

At this point, the model has been exercised a fair amount and the team has a good sense of what it wants to tell them: which errors are most important to address early, and that the move to a self-service platform needs to happen sometime soon.

## Document 16-3: Wardley Mapping the Service Orchestration Ecosystem

In Uber's 2014 service migration strategy (Document 16-1), the team explored how to navigate the move from a Python monolith to a services-oriented architecture **while also scaling with user traffic that doubled every six months**.

The Wardley map (Figure 16-15: "Wardley map for service orchestration") explores how orchestration frameworks were evolving during that period, to be used as an input into determining the most effective path forward for Uber's Infrastructure Engineering team.

### How Things Work Today

There are three primary internal teams involved in service provisioning. The **Service Provisioning team** abstracts applications developed by **Product Engineering** from servers managed by the **Server Operations team**. As more servers are added to support application scaling, this is invisible to the applications themselves, freeing Product Engineers to focus on what the company values the most: developing more application functionality.

The challenges within the current value chain are:

1. cost-efficient scaling,
2. reliable deployment, and
3. fast deployment.

All three of those problems **anchor on the same underlying problem of resource scheduling**. The team wants to make a significant investment into improving resource scheduling, and believes that understanding the industry's trend for resource scheduling underpins making an effective choice.

### Transition to Future State

Most interesting cluster orchestration problems are anchored in **cluster metadata and resource scheduling**:

- Request routing — whether through DNS entries or allocated ports — depends on cluster metadata (see Figure 16-16: "Pipeline showing progression of service orchestration over time").
- Mapping services to a fleet of servers depends on resource scheduling managing cluster metadata.
- Deployment and autoscaling both depend on cluster metadata.

This is also an area where significant changes are occurring in 2014.

Uber initially solved this problem using **Clusto**, an open source tool released by Digg with goals similar to HashiCorp's **Consul** but with limited adoption. Uber also used **Puppet** for configuring servers, alongside **custom scripting**. This has worked, but has required custom, ongoing support for scheduling. The key question confronting the team: **whether to build their own scheduling algorithms (e.g., bin packing) or adopt a different approach.**

It seems clear that the industry intends to directly solve this problem via two paths:

1. relying on **cloud providers** for orchestration (Amazon Web Services, Google Cloud Platform, etc.), and
2. **open source scheduling frameworks** such as Mesos and Kubernetes.

The industry-evolution pattern:

- Industry peers with **more than five years of infrastructure experience are almost unanimously adopting open source scheduling frameworks** to better support their physical infrastructure. This also gives them a tool to perform a *bridged migration* from physical infrastructure to cloud infrastructure.
- **Newer companies with less existing infrastructure are moving directly to the cloud** and avoiding the orchestration problem entirely.
- The only companies not adopting one of these two approaches are either **extraordinarily large and complex (think Google or Microsoft) or allergic to making any technical change at all**.

From this analysis, it's clear that **continuing reliance on Clusto and Puppet is going to be an expensive investment that's not particularly aligned with the industry's evolution**.

### User and Value Chains

The map in Figure 16-16 explores the orchestration ecosystem **within a single company**, with an emphasis on what did, and did not, stay the same from roughly **2008 to 2014**. It attends to three users in particular:

1. **Product Engineers** are focused on provisioning new services, and then deploying new versions of those services as they make changes. They operate their own service and are entirely unaware of anything beneath the orchestration layer (including any servers).
2. **The Service Provisioning team** invests its energy in provisioning new services, orchestrating resources for those services, and routing traffic to those services. This team acts as the bridge between the Product Engineers and the Server Operations team.
3. **The Server Operations team** prioritizes adding server capacity to be used for orchestration. They work closely with the Service Provisioning team and have no contact with the Product Engineers.

It's worth acknowledging that, in practice, these are **artificial aggregates of multiple underlying teams**. For example, routing traffic between services and servers is typically handled by a Traffic or Service Networking team. However, these omissions are intended to clarify the distinctions relevant to the evolution of orchestration tooling.

## Summary

Chapter 23 presents a rubric to evaluate the service provisioning strategy described in these three documents. In particular, that chapter introduces the concept of **strategy phases**, which allow you to concretely talk about a strategy that works extremely well initially but runs into issues later.

Larson developed the concept of strategy phases **specifically to deal with the legacy of the Uber service migration described in this chapter**. This strategy worked exceptionally well, solving a series of complex problems with a very small team. It also, unfortunately, facilitated the introduction of a **very difficult developer experience** for the engineers building on top of the service architecture the team facilitated. Although this was indeed a downside of the approach, **strategy is ultimately a study of tradeoffs**, and acknowledging these challenges is part of why looking at real strategy documents is so much more valuable than reading press releases.

## Figures Referenced

| Figure | Caption |
|---|---|
| 16-1 | Systems model of provisioning services at Uber circa 2014 |
| 16-2 | Service provisioning model without error states |
| 16-3 | Impact of self-service provisioning on provisioning rate |
| 16-4 | Wardley map of service orchestration |
| 16-5 | Service provisioning model without error states |
| 16-6 | Impact of infrastructure engineering hiring on service provisioning |
| 16-7 | Impact of self-service provisioning on provisioning rate |
| 16-8 | Systems model of provisioning services (initial sketch) |
| 16-9 | Model of provisioning services with error transitions |
| 16-10 | Service provisioning model without error states |
| 16-11 | Service provisioning model with error states |
| 16-12 | Impact of error rates across stages of provisioning |
| 16-13 | Impact of infrastructure engineering hiring on service provisioning |
| 16-14 | Impact of self-service provisioning on provisioning rate |
| 16-15 | Wardley map for service orchestration |
| 16-16 | Pipeline showing progression of service orchestration over time |
