# Chapter 16: Service Migration Strategy — Examples

This chapter is itself a case study, presented as three recreated internal documents written from the perspective of Uber's service provisioning team in 2014. The entries below capture the concrete worked example: the situation, the actual policies and task sequence chosen, the systems model, and the Wardley map.

## The framing story: four engineers, 1,000+ services

Larson joined Uber in early 2014 as engineering manager for Infrastructure. The subset of his team working on service provisioning never grew beyond four engineers, yet those four migrated more than 1,000 services onto a new, future-proofed service platform — and absorbed the majority of the migration workload themselves rather than spreading it across Uber's 2,000+ engineers. They had no executive sponsor; the strategy succeeded by solving a pressing user problem (escaping the Python monolith) with effective ergonomics.
Illustrates: A small team can drive company-wide strategy bottom-up when adoption is earned through effectiveness rather than mandated through authority.

## The diagnosis: demand doubling, capacity fixed

The recreated strategy document's Diagnose section lays out the situation concretely. Product teams fleeing the monolith generated 2–3 provisioning requests per week, projected to reach 8–12 within a year as engineering doubled every six months. The four-person provisioning team would get no additional headcount, and SRE bandwidth was already committed. Provisioning took about a week end to end but only 3–4 hours of actual work when information was complete and accurate; missing or incorrect information caused the round trips that dominated delay. The toolchain (Puppet manifests, Clusto metadata, a port registry on a Phabricator wiki page) had few safeguards, so an inattentive provisioning step could cause a production outage. It was widely agreed across infrastructure engineering that the components should be replaced, but no team owned replacing them.
Illustrates: A diagnosis that quantifies demand growth versus fixed capacity, isolates the true bottleneck (information round trips, not work hours), and names accountability gaps.

## The four guiding policies Uber adopted

The strategy document (which folds Operation into Policy) commits to: (1) cap manual provisioning at exactly one full-time engineer and put the rest on automation, accepting short-term degradation to avoid permanent degradation; (2) require that self-service be safely usable by a new hire with no Uber context, since the existing Puppet/Clusto tooling could damage production; (3) replace Phabricator tickets with structured requests carrying a schema of required fields, which lets the team "get paid twice" by cutting manual errors now and becoming the self-service interface later; (4) initialize new services with good defaults instead of demanding predictions from requesters, using the development-to-production gate as the checkpoint where settings get refreshed.
Illustrates: Policies as explicit resource commitments and design constraints, each justified by the diagnosis.

## The five-step task sequence

The policies materialize as ordered tasks: (1) build an internal tool coordinating provisioning, replacing Phabricator tickets, with a schema of required fields to eliminate the majority of back-and-forth; (2) make that tool the interface for future automation so the request workflow never has to change again; (3) extend it to generate Puppet scaffolding from the request data, eliminating most human template tweaks and typo-class errors; (4) fully automate port allocation first because port reuse can break routing to production services — moving the port registry from a wiki page into a database guarded by checks; (5) replace manual server assignment (which piled new services onto already-loaded servers) with automated placement, designed to migrate onto the Mesos/Aurora cluster once production-ready. Each week the team reviews queue size and provisioning time to test whether the strategy is working.
Illustrates: Sequencing where each step pays off standalone while building toward the end state, automating the highest-risk step first, and a standing operational check.

## The systems model: sketch of the provisioning pipeline

Document 16-2 sketches provisioning as a pipeline of stocks: requested services flow through inflight, port/name assigned, Puppet generated, Puppet config merged, and finally server capacity allocated in Clusto. The sketch gives a sense of the stages, where things might go wrong, and what can be measured to evaluate whether provisioning is working well. Dotted "links" connect hiring rate to product engineers and product engineers to requested services — influences that don't flow directly. The sketch deliberately connects links to stocks rather than flows (a purist would object) because readability served the audience better.
Illustrates: Sketching a system as stocks and flows before modeling, and accepting purity tradeoffs in service of clarity.

## Adding error flows to the model

The initial sketch missed how things go wrong. The team modeled two error types: missing/incorrect information (which occurs at port assignment, a short trip back, and at Puppet configuration, a much larger trip back to the start) and Puppet errors (which send a nearly finished request one step back). The combination means a service can be almost fully provisioned, then bounce from Puppet testing back to Puppet configuration, then all the way back to the beginning — nearly all progress lost. Reasoning over the sketch also flagged that the model understates cost asymmetries: missing-information errors are costlier than modeled because resolving them requires cross-team coordination, while Puppet testing errors are probably cheaper because they should be fixable within one team with a quick iteration loop.
Illustrates: Error flows, not just happy paths, define a pipeline's real throughput.

## The model code

The model, built with the lethain/systems package (full implementation in the lethain/eng-strategy-models GitHub repository), starts with success states: `HiringRate(10)` feeding `ProductEngineers(1000)`, requests generated at `ProductEngineers / 10`, and a chain of `Leak(1.0)` transitions with inflight services capped at 10. Errors are added by splitting transitions, e.g. `PortNameAssigned > PuppetGenerated @ Leak(0.8)` with `PortNameAssigned > RequestedServices @ Leak(0.2)`, and similarly 80/20 splits for Puppet generation and Puppet merge errors. Even these modest 20% error rates meaningfully cut overall throughput.
Illustrates: A concrete, runnable stock-and-flow model small enough to build quickly yet rich enough to test strategy options.

## Exercising the model, test 1: which error matters most?

The team raised each error rate independently from 20% to 50% and compared throughput. During sketching they had assumed Puppet-generation errors mattered most because they caused a long trip backward. The simulation showed the opposite: a very high error rate early in the process hurts more, because requests that pass it still face every later error, so early failures compound with everything downstream.
Illustrates: Exercising a model overturns intuition formed during sketching; early-stage errors compound worst.

## Exercising the model, test 2: hiring 5x doesn't work

To simulate hiring more manual provisioners, the team raised the inflight-services cap from 10 to 50 — a 500% capacity increase. The backlog of requested services remained extremely high. Separately, even a zero-error version of the manual process still accumulated an ever-growing backlog. Refined conclusion: hiring may benefit the team if the hires focus on building self-service and their productivity ramps faster than request growth.
Illustrates: Quantitative proof that neither efficiency improvements nor hiring can rescue a structurally capped manual process.

## Exercising the model, test 3: self-service solves it

Simulating self-service by removing the inflight cap entirely (`InflightServices(0)` instead of `InflightServices(0, 10)`) finally held the backlog steady. Of all attempted interventions — eliminating all errors, 500% more capacity, self-service — only self-service worked.
Illustrates: The model exists to identify the one lever that actually fixes the problem before committing the team to it.

## The Wardley map: three users and the scheduling anchor

Document 16-3 frames the problem as leaving the Python monolith while also scaling with user traffic that doubled every six months. It maps the orchestration ecosystem within a single company, emphasizing what did and did not stay the same from roughly 2008 to 2014, around three (deliberately artificial) user aggregates: Product Engineers, who provision and deploy services and never see servers; the Service Provisioning team, the bridge that orchestrates resources and routes traffic; and the Server Operations team, which adds capacity and never touches Product Engineers. The map shows that the era's hard problems — cost-efficient scaling, reliable deployment, fast deployment — all anchor on the same underlying problem of resource scheduling, so that's where investment should go. The real Traffic/Service Networking team is folded into Service Provisioning because the simplification clarifies what matters to the orchestration question.
Illustrates: Using a Wardley map (placed in Explore rather than Refine, where it fit best) to locate the anchor problem in a value chain, and simplifying users to sharpen the analysis.

## The industry-evolution read: Clusto and Puppet are a dead end

Uber ran its servers on-prem in a handful of colocations, managing metadata with Clusto (an open source Digg tool with goals similar to HashiCorp's Consul but limited adoption) plus Puppet manifests and custom scripts, which required ongoing custom scheduling support — posing the key question of whether to build their own scheduling algorithms (e.g., bin packing) or adopt a different approach. The map's evolution analysis showed the industry solving scheduling via two paths: cloud providers, and open source frameworks like Mesos and Kubernetes. Peers with 5+ years of physical infrastructure were almost unanimously adopting open source schedulers, partly as a bridge toward eventual cloud migration; newer companies went straight to cloud; only the extraordinarily large (Google, Microsoft) or the change-averse did neither. Continuing with Clusto and Puppet would be an expensive investment misaligned with the industry's direction.
Illustrates: Reading ecosystem evolution to avoid investing in components the industry is moving past.

## Choosing Mesos/Aurora over Kubernetes in 2014

The Explore section judged the current infrastructure near end of life, with opportunity to move service definitions from Puppet toward something like Docker and metadata toward a purpose-built solution like Mesos/Aurora or Kubernetes. The team read the primary sources — Google's Borg paper and the Mesos paper (the "Borg, Omega, and Kubernetes" article didn't exist yet) — and canvassed for production experience. Uber employed ex-Twitter engineers who could speak confidently to operating Mesos/Aurora at Twitter; nobody could be found with production Kubernetes experience on a fleet of 10,000+ servers, despite Google's backing. Even Mesos/Aurora's absolute deployment count was quite small, with no large-scale industry backer outside Twitter — the strategy named the evolution of both as an open unknown. Serverless generated excitement but canvassing found no real-world usage sufficient to justify a push. Cloud was ruled out by opposition reaching up to the CEO. So the plan targeted Mesos/Aurora — while noting another infrastructure team was exploring it with no committed timeline, requiring an interim solution.
Illustrates: Weighting technology bets by verifiable production experience at comparable scale, not hype or vendor backing, and naming the residual uncertainty rather than hiding it.

## The urgency asymmetry observation

Requests to provision a new service arrived with significant urgency and internal escalations to management. But once a service was provisioned for development, urgent escalations nearly stopped, apart from one-off capacity requests during incidents. The team read this as evidence that unblocking development is urgent while production promotion rarely is, and shaped the workflow accordingly — including using the development-to-production gate as the natural place to refresh default settings.
Illustrates: Letting observed escalation patterns reveal where speed actually matters.

## The epilogue: success with a deferred cost

The strategy worked exceptionally well — a tiny team solved a series of complex problems and migrated 1,000+ services. But it also facilitated a very difficult developer experience for engineers building atop the resulting service architecture. Larson developed the concept of "strategy phases" (Chapter 23) specifically to reckon with this legacy: a strategy can work extremely well initially and run into trouble later. Acknowledging the downside is part of why real strategy documents teach more than press releases.
Illustrates: Strategy is a study of tradeoffs; honest assessment includes the costs that surface after the win.
