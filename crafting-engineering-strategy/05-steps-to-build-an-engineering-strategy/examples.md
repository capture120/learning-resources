# Chapter 5: Steps to Build an Engineering Strategy — Examples

The chapter illustrates the steps (all but Step 3, Refining) with excerpts from real strategy documents that appear as full case studies later in the book.

## Uber service migration: exploration via industry literature (Step 1)

Uber's service migration strategy (Document 16-1) began by reading industry literature rather than jumping to a solution. The team found it valuable to read "Large-Scale Cluster Management at Google with Borg," which informed some elements of the approach to Kubernetes, and "Mesos: A Platform for Fine-Grained Resource Sharing in the Data Center," which describes the Mesos/Aurora approach. This used exploration to understand the service ecosystem through how other companies had approached similar questions.
Illustrates: exploration means deliberately studying how others have approached your problem before committing to your own approach.

## Uber service migration: exploration via Wardley mapping (Step 1)

The same Uber strategy also used a Wardley map (Figure 5-1, "Evolution of service orchestration in 2014") to explore the cloud compute ecosystem.
Illustrates: mapping as an exploration tool for understanding how an ecosystem is evolving.

## Private equity transition: a data-driven diagnosis (Step 2)

The strategy for navigating a private equity ownership transition (Chapter 18) diagnosed cost growth quantitatively: engineering headcount costs grew 15% year over year (18% the prior year) while headcount itself grew only 7% and 9%. The gap was decomposed into salary band adjustments (4%), a focus on hiring senior roles (3%), and increased hiring in higher-cost geographic regions (1%).
Illustrates: a diagnosis can be largely data-driven — quantifying the problem and decomposing it into its causal components before any policy is proposed.

## Index acquisition: a qualitative diagnosis of knowns and unknowns (Step 2)

Stripe's strategy for integrating the acquired startup Index summarized the problem before the acquisition closed, when few details were available. The diagnosis stated what was known: the integration had to happen rapidly to meet the timeline; point-of-sale devices directly handle payment details (the device knows the credit card it reads); and compliance obligations restrict such activity to a "tokenization environment" — a highly secured, isolated environment that converts payment details into tokens other environments can use without the compliance overhead of direct access.
Illustrates: a diagnosis can also be less data-driven, instead aiming to summarize the known and unknown elements of the problem.

## User-data control strategy: policy as directional guidance (Step 4)

The user-data control strategy (Document 19-1) set policy as a guiding principle: good security discussions don't frame decisions as a compromise between security and usability. The team committed to multi-dimensional tradeoffs that improve security and efficiency simultaneously — and declared that any discussion framed as security-versus-utility was a sign they were having the wrong discussion. Concretely, they prioritized mechanisms that both automatically authorize access and automatically document the rationale for that access, such as granting a support agent access to a customer's data only while that customer's ticket is assigned to the agent, and revoking it when the ticket is reassigned or resolved.
Illustrates: policy can be directional guidance — a decision-shaping principle plus a concrete preferred mechanism — rather than a one-time decision.

## Stripe/Index acquisition: policy as deliberate deferral (Step 4)

Stripe's acquisition strategy for Index (Document 22-4) explicitly deferred the decision about introducing Java. Java was incompatible with the existing engineering strategy, stakeholders couldn't be aligned on how to address it, and litigating it was a distraction from the goal of launching a joint product within six months. The policy: take up the discussion after the initial release launches.
Illustrates: deliberately postponing a contentious decision — with the rationale and a revisit point stated — is itself a valid policy.

## Calm product engineering strategy: escalation path as the simplest operational mechanism (Step 5)

Calm's product engineering strategy (Document 21-1) paired its deliberately restrictive policies with the simplest possible operational mechanism: exceptions are granted by the CTO and must be in writing. The strategy acknowledged the policies might sometimes be wrong, but required each exception to be deliberate and grounded in concrete problems the team was aligned on both solving and how to solve them. The stated reasoning: if everyone scatters toward their preferred solution, engineering creates negative leverage for Calm instead of serving as the engine advancing the product.
Illustrates: an explicit, written escalation path is the minimal operational mechanism that keeps a restrictive policy alive and consistently interpreted.
