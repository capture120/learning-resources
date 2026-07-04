# Chapter 5: Steps to Build an Engineering Strategy — Detailed Reference

## Chapter Introduction

Often a disorganized collection of ideas gets labeled as a "strategy." Even when such documents are dense with ideas, they can be hard to parse. This is a major reason why most engineers will claim their company doesn't have a clear strategy — even though, as Chapter 1 showed, all companies follow some strategy, even if it's undocumented.

This chapter lays out a repeatable, structured approach to drafting strategy and introduces each step of that approach. Each step is detailed further in its own respective chapter. Here, the chapter covers how the five steps fit together to facilitate creating strategy, especially by preventing practitioners from skipping steps that feel awkward or challenging. It also looks at how to decide for yourself whether to follow these exact steps for your own strategy work or to adjust them.

High-level summary of each step:

- **Step 1: Exploring.** Exploring the wider industry's ideas and practices around the strategy you're working on. Exploration is understanding what recent research might change your approach, and how the state of the art has changed since you last tackled a similar problem.
- **Step 2: Diagnosing.** Diagnosing the details of your problem. It's hard to slow down to understand your problem clearly before attempting to solve it, but it's even more difficult to solve anything well without a clear diagnosis.
- **Step 3: Refining.** Refinement is taking a raw, unproven set of ideas and testing them against reality. Three techniques are introduced to support this validation process: strategy testing, systems modeling, and Wardley mapping.
- **Step 4: Setting policy.** Policy makes the tradeoffs and decisions to solve your diagnosis. These can range from specifying how software is architected, to how pull requests are reviewed, to how headcount is allocated within an organization.
- **Step 5: Operations.** Operations are the concrete mechanisms that translate policy into an active force within your organization. These can be nudges that remind you about code changes without associated tests, or weekly meetings where you study progress on a migration.

From this chapter's starting point, you can decide where you want to read further.

## How the Steps Become Strategy

You can't create effective strategy through the rote incantation of a formula; following these steps doesn't guarantee that you'll create a great strategy. However, what Larson has consistently found is that strategies fail more often due to avoidable errors than to fundamentally unsound thinking. Busy people skip steps — especially steps they dislike or have failed at before.

These steps are the way to avoid those errors. By practicing them routinely, you'll build powerful habits and intuition around which approach is most appropriate for the current strategy you're working on. They also help turn strategy into a community practice that you, your colleagues, and the wider engineering ecosystem can participate in together.

Each step is an input that flows into the next step:

- Your exploration is the foundation of a solid diagnosis.
- Your diagnosis helps you search the infinite space of policy for what you currently need.
- Operational mechanisms help you turn policy into an active force supporting your strategy, rather than an abstract treatise.

If you're skeptical of the steps, you should certainly maintain your skepticism, but do give them a few tries before discarding them entirely. You may also appreciate the discussion in Chapter 12 on bridging between theory and practice when doing strategy.

## Step 1: Exploring

Exploration is "the deliberate practice of searching through a strategy's problem and solution spaces before allowing yourself to commit to a given approach." It's understanding how other companies and teams have approached similar questions, and whether their approaches might also work well for you. It's also learning why what brought you success at your former employer isn't necessarily the best solution for your current organization.

The Uber service migration strategy (Document 16-1) used exploration to understand the service ecosystem by reading industry literature. Quoting that strategy:

> As a starting point, we find it valuable to read "Large-Scale Cluster Management at Google with Borg", which informed some elements of the approach to Kubernetes, and "Mesos: A Platform for Fine-Grained Resource Sharing in the Data Center", which describes the Mesos/Aurora approach.

The same strategy also used a Wardley map to explore the cloud compute ecosystem, shown in Figure 5-1 ("Evolution of service orchestration in 2014").

For more details on exploration, see Chapter 6; Chapter 15 is a deep dive into Wardley mapping.

## Step 2: Diagnosing

Diagnosis is "your attempt to correctly recognize the context that the strategy needs to solve before deciding on the policies to address that context." Building a diagnosis starts from what you learned in Step 1 (exploring) and your understanding of your current circumstances. This step forces you to delay thinking about solutions until you fully understand your problem's nuances.

A diagnosis can be largely data-driven, such as the strategy for navigating a private equity ownership transition, discussed in Chapter 18. Quoting that diagnosis:

> Our Engineering headcount costs have grown by 15% YoY this year, and 18% YoY the prior year. Headcount grew 7% and 9% respectively, with the difference between headcount and headcount costs explained by salary band adjustments (4%), a focus on hiring senior roles (3%), and increased hiring in higher cost geographic regions (1%).

It can also be less data-driven, instead aiming to summarize a problem. The Index acquisition strategy's diagnosis summarized the known and unknown elements of the technical integration prior to the acquisition closing:

> We will need to rapidly integrate the acquired startup to meet this timeline. We only know a small number of details about what this will entail. We do know that point-of-sale devices directly operate on payment details (e.g., the point-of-sale device knows the credit card details of the card it reads).
>
> Our compliance obligations restrict such activity to our "tokenization environment," a highly secured and isolated environment with direct access to payment details. This environment converts payment details into a unique token that other environments can utilize to operate against payment details without the compliance overhead of having direct access to the underlying payment details.

The approach, and challenges, of developing a diagnosis are detailed in Chapter 7.

## Step 3: Refining

Strategy refinement is a toolkit of methods to identify which parts of your diagnosis are most important, and to verify that your approach to solving the diagnosis actually works. Chapter 8 discusses three methods in particular, each of which also has its own chapter:

- Strategy testing (Chapter 13)
- Systems modeling (Chapter 14)
- Wardley mapping (Chapter 15)

### Sidebar: Why Doesn't Refinement Come Earlier (or Later)?

A frequent point of disagreement with the steps as laid out is that refinement should occur before diagnosis. Another is that mapping and modeling are two distinct steps, and that mapping should occur before diagnosis, while modeling should occur after policy. A third is that refinement ought to be the final step of strategy, turning the steps into a looping cycle. These are all reasonable objections; Larson's rationale for the chosen structure:

- By far the biggest risk for most strategies is not that you model too early or map too late, but that you skip both steps entirely.
- His foremost concern is minimizing the required investment into mapping and modeling so that more folks do these steps at all.
- Refining after exploring and diagnosing allows you to concentrate your efforts on a smaller number of load-bearing areas.

That said, it's common to refine at many places in your strategy creation. You're just as likely to have three small refinement steps as one bigger one.

## Step 4: Setting Policy

Setting policy is "interpreting your diagnosis into a concrete plan that works." This requires careful study of what's worked within your company and any new ideas you've discovered while exploring the current problem.

Policies can do many things. Two examples of distinct forms:

**Directional guidance.** The user-data control strategy discussed in Document 19-1 provides directional guidance:

> Good security discussions don't frame decisions as a compromise between security and usability. We will pursue multi-dimensional tradeoffs to simultaneously improve security and efficiency. Whenever we frame a discussion on trading off between security and utility, it's a sign that we are having the wrong discussion, and that we should rethink our approach.
>
> We will prioritize mechanisms that can both automatically authorize and automatically document the rationale for access to customer data. The most obvious example of this is automatically granting access to a customer support agent for users who have an open support ticket assigned to that agent. (And removing that access when that ticket is reassigned or resolved.)

**Postponing a decision.** Stripe's strategy for acquiring Index (Document 22-4) postponed making a decision until later:

> Defer making a decision regarding the introduction of Java to a later date: the introduction of Java is incompatible with our existing engineering strategy, but at this point we've also been unable to align stakeholders on how to address this decision. Further, we see attempting to address this issue as a distraction from our timely goal of launching a joint product within six months.
>
> We will take up this discussion after launching the initial release.

Chapter 9 goes further into evaluating policies, overcoming ambiguous circumstances that make it difficult to decide on an approach, and developing novel policies.

## Step 5: Operations

Even the best policies have to be interpreted. There will be new circumstances their authors never imagined, and the policies may be in effect long after their authors have left the organization. Operational mechanisms are the concrete implementation of your policies.

The simplest mechanism is an explicit escalation path, as shown in Calm's product engineering strategy (Document 21-1):

> Exceptions are granted by the CTO, and must be in writing. The above policies are deliberately restrictive. Sometimes they may be wrong, and we will make exceptions to them. However, each exception should be deliberate and grounded in concrete problems we are aligned both on solving and how we solve them. If we all scatter toward our preferred solution, then we'll create negative leverage for Calm rather than serving as the engine that advances our product.

From that starting point, the mechanisms can get far more complex. Chapter 10 works through evaluating mechanisms, composing an operational plan, and the most common sorts of operational mechanisms Larson has seen across strategies.

## Is the Structure Sacrosanct?

When you're struggling to write a strategy document, one of the first tools people recommend is a strategy template. Templates are great: they reduce the ambiguity in an already broad project into something more tractable. If you're wondering whether you should use a template to craft strategy: sure, go ahead.

However, Larson finds that well-meaning, thoughtful templates often turn into "lumbering, callous documents that serve no one well." The secret to making a good template is that someone has to own it, and that person has to care about the template's user first and foremost, rather than the various constituencies that want to insert requirements into the strategy creation process. The security, compliance, and costs of your plans matter a great deal, but many organizations start to layer more and more requirements into these sorts of documents until writing them becomes prohibitively painful.

The best advice given: "discard every element of strategy that gets in your way as long as you can explain what that element was intended to accomplish." For example, if you're drafting a strategy and you don't find any operational mechanisms that fit, fine — discard that section. Ultimately, the structure is not sacrosanct: it's the thinking behind the sections that really matters. This topic is explored in more detail in Chapter 11.

## Summary

You now know the foundational steps to conducting strategy. From here, you can dive into the details with strategy case studies (Part IV of the book), or you can maintain a high altitude, starting with the next chapter (Chapter 6), about how exploration creates the foundation for an effective strategy. Whichever you start with, Larson encourages you to eventually work through both to get the full perspective.
