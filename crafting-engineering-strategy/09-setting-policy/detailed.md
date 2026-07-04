# Chapter 9: Setting Policy — Detailed Reference

## Introduction

Chapter 1 defined strategy as "making decisions." The book then spent three chapters on exploration, diagnosis, and refinement — chapters where, arguably, nothing was decided at all. Clarifying the problem to be solved is a prerequisite for effective decision making, but eventually decisions do have to be made. In this chapter on policy, and the following chapter on operations, the book finally starts making some decisions.

The chapter covers:

- How policy is defined, and how setting policy differs from operating policy (the subject of the next chapter)
- The structured steps for setting policy
- How many policies you should set — whether it's preferable to have one policy or many, or whether it doesn't matter much either way
- Recurring kinds of policies that appear frequently in strategies
- Why it's valuable to be intentional about your strategy's altitude, and how engineers and executives generally maintain different altitudes in their strategies
- Criteria for evaluating whether your policies are likely to be impactful
- How to develop novel policies, and why doing so is rare
- Why having multiple bundles of alternative policies generally indicates a gap in your diagnosis
- How policies that ignore constraints sound inspirational but accomplish little
- Making progress on your strategy even when your cross-functional stakeholders have an unclear strategy

By the end of the chapter, you should be ready to evaluate why an existing strategy's policies aren't making an impact, and to start iterating on policies for a strategy of your own.

## What Is Policy?

Policy is interpreting your diagnosis into a concrete plan. That plan is a collection of decisions, tradeoffs, and approaches, which could include coding practices, hiring mandates, architectural decisions, and guidance about how choices are made within your organization.

An effective policy solves the entirety of the strategy's diagnosis — although the diagnosis itself should specify which aspects can be ignored. The example given is Document 18-1's strategy for working with private equity ownership, whose diagnosis acknowledges that the authors don't have clear guidance on what kind of reduction to expect:

> Based on general practice, it seems likely that our new Private Equity ownership will expect us to reduce R&D headcount costs through a reduction. However, without concrete details, we cannot yet make structured decisions. Our strategy will depend significantly on the scale of any proposed reductions.

Faced with that uncertainty, the policy simply acknowledges the ambiguity and commits to reconsidering when more information becomes available:

> We believe our new ownership will provide a specific target for Research and Development (R&D) operating expenses during the upcoming financial year planning. We will revise these policies again once we have explicit targets, and will delay planning around reductions until we have those numbers to avoid running two overlapping processes.

There are two frequent points of confusion when creating policies, both worth addressing directly:

1. **Policy is a subset of strategy, not the entirety of strategy**, because policy is only meaningful in the context of the strategy's diagnosis. For example, the "N-1 backfill policy" makes sense in the context of new private equity ownership; the same policy wouldn't work well in a rapidly expanding organization. It's true that any strategy without a policy is useless, but policies without context aren't worth much either. This is unfortunate, because strategies are so often communicated without those critical context sections.
2. **Policy describes how tradeoffs should be made, but it doesn't verify how the tradeoffs are actually made in practice.** Chapter 10, on operations, covers how to inspect an organization's behavior to ensure policies are followed.

When you're reworking a strategy to be more readable (see Chapter 11), it often makes sense to merge the policy and operation sections together. However, when drafting strategy, it's valuable to keep them separate. You might use a weekly meeting to review whether the policy is being followed, but whether it's an effective policy is independent of having such a meeting, and the operational mechanisms you use will vary depending on the number of policies you intend to implement.

## How to Set Policy

Every part of writing a strategy feels hard while you're doing it, but Larson finds that writing policy either feels uncomfortably easy or painfully challenging — never a happy medium. Fortunately, the exploration and diagnosis usually come together to make writing your policy simple, even if that simple conclusion is sometimes difficult to swallow.

The six steps Larson follows to write a strategy's policy:

1. **Review diagnosis.** Review your diagnosis to ensure it captures the most important themes. It doesn't need to be perfect, but it shouldn't have any glaring omissions.
2. **Select policies that address the diagnosis.** Explicitly match each policy to one or more diagnoses that it addresses. Continue adding policies until every diagnosis is covered. This is a broad instruction, but it's simpler than it sounds, because you'll typically select from policies you identified during your exploration phase. There is certainly space to tweak those policies, and to reapply familiar policies to new circumstances.
3. **Consolidate policies.** Consolidate overlapping or adjoining policies. For example, two policies about specific teams might be generalized into a policy about all teams in the engineering organization.
4. **Backtest.** Backtest the new policy against recent decisions you've made. This is particularly effective if you maintain a decision log in your organization.
5. **Mine for conflict.** Mine for conflict once again, much as you did in developing your diagnosis. Emphasize feedback from teams and individuals with different perspectives than your own, but don't wholly eliminate those you agree with. Just as it's easy to crowd out opposing views during diagnosis if you don't solicit their input, it's possible to accidentally crowd out your own perspective if you anchor too much on others' perspectives.
6. **Refine.** If you finish writing and you just aren't sure your approach works, refine it. Deploy one of the refinement techniques from Chapter 8 to increase your conviction. Remember that, while people talk about strategy like it's all done in one pass, almost all real strategy takes many refinement passes.

The steps of writing policy are relatively pedestrian, largely because you've already done so much of the work in the exploration, diagnosis, and refinement steps. If you skipped those phases, you might still follow these steps for writing policy, but the quality would be far lower.

## How Many Policies?

Addressing the entirety of the diagnosis is often complex, which is why most strategies feature a set of policies rather than just one. For example, the strategy for decomposing a monolithic application (Document 20-1) is not one policy deciding not to decompose, but a series of four policies:

1. Business units should always operate in their own code repository and monolith.
2. New integrations across business unit monoliths should be done using gRPC.
3. Except for new business unit monoliths, we don't allow new services.
4. Merge existing services into business unit monoliths where you can.

Four isn't universally the right number either — it's simply the number that was required to solve that strategy's diagnosis. With an excellent diagnosis, your policies will often feel inevitable, perhaps even boring. That's a great thing: what makes a policy good is that it's effective, not that it's novel or inspiring.

## Kinds of Policies

While there are very many policies you can write, Larson has found they generally fall into one of four major categories: **approvals**, **allocations**, **direction**, and **guidance**.

### Approvals

Approvals define the process for making a recurring decision. This might require invoking an architecture advice process or involving an authority figure, like an executive.

In the Index post-acquisition integration strategy (Document 22-4), there were a number of complex decisions to be made, and the approval mechanism was:

> Escalations come to paired leads: Given our limited shared context across teams, all escalations must come to both Stripe's Head of Traffic Engineering and Index's Head of Engineering.

Consulting both the acquired and acquiring teams before any decision was finalized allowed them to start building mutual trust.

By contrast, the user data access strategy's approval mechanism (Document 19-1) was more focused on managing corporate risk:

> Exceptions must be granted in writing by the CISO. While our overarching Engineering Strategy states that we follow an advisory architecture process as described in Facilitating Software Architecture, the customer data access policy is an exception and must be explicitly approved, with documentation, by the CISO. Start that process in the #ciso channel.

These two approval processes had different goals, so they made different tradeoffs between safety, productivity, and trust.

### Allocations

Allocations describe how resources are split across multiple potential investments. Allocations are the most concrete statement of organizational priority, and they articulate the organization's beliefs about how productivity happens in teams. Some companies believe you go fast by swarming more people onto critical problems; others go fast by forcing teams to solve problems without additional headcount. Both methods can work, and both teach you something important about the company's beliefs.

The strategy for Uber's service migration (Document 16-1) has two concrete examples of allocation policies.

The first describes the infrastructure engineering team's allocation between manual provisioning tasks and investing in a self-service provisioning platform:

> Constrain manual provisioning allocation to maximize investment in self-service provisioning. The service provisioning team will maintain a fixed allocation of one full-time engineer on manual service-provisioning tasks. We will move the remaining engineers to work on automation to speed up future service provisioning. This will degrade manual provisioning in the short term, but the alternative is permanently degrading provisioning by the influx of new service requests from newly hired product engineers.

The second allocation policy is implicitly noted in the same strategy's diagnosis, where it describes the allocation policy set in the Engineering organization's higher-altitude strategy:

> Within infrastructure engineering, there is a team of four engineers responsible for service provisioning today. While our organization is growing at a similar rate as product engineering, none of that additional headcount is being allocated directly to the team working on service provisioning. We do not anticipate this changing.

Allocation policies often create a surprising amount of clarity for the team. Larson includes them in almost every policy he writes — either explicitly or, in a higher-altitude strategy, implicitly.

### Direction

Direction provides explicit instruction on how a decision must be made. This is the right tool when you know where you want to go and the exact route you want to take to get there. Direction is appropriate for problems you understand clearly, especially when you value consistency more than empowering individual judgment.

Direction works well when you need an unambiguous policy that doesn't leave room for interpretation. For example, Calm's policy for working in the monolith (Document 21-1) includes:

> We write all code in the monolith. It has been ambiguous if new code (especially new application code) should be written in our JavaScript monolith, or if all new code must be written in a new service outside of the monolith. This is no longer ambiguous: all new code must be written in the monolith.
>
> In the rare case that there is a functional requirement that makes writing in the monolith implausible, then you should request an exception as described below.

In that case, the team couldn't agree on what should go into the monolith. Individuals would often make incompatible decisions, so creating consistency required removing personal judgment from the equation.

Sometimes judgment is the issue, and sometimes consistency is difficult due to misaligned incentives. A good example of the latter comes from the private equity strategy (Document 18-1):

> We will move to an "N-1" backfill policy, where departures are backfilled with a less senior level. We will also institute a strict maximum of one Principal Engineer per business unit.

It's likely that hiring managers would simply ignore this backfill policy if it was stated more softly — although sometimes less forceful policies are useful.

### Guidance

Guidance provides a recommendation about how a decision should be made. Guidance is useful when there's enough nuance, ambiguity, or complexity that you can explain the desired destination, but you can't mandate the path to reaching it.

One example of guidance comes from the Index acquisition integration strategy (Document 22-4):

> Minimize changes to tokenization environment: Because point-of-sale devices directly work with customer payment details, the API that directly supports the point-of-sale device must live within our secured environment where payment details are stored.
>
> However, any other functionality must not be added to our tokenization environment.

This might read like direction, but it's clarifying the desired outcome of avoiding unnecessary complexity in the tokenization environment. Because it can't articulate what complexity is necessary, it requires significant judgment to interpret — making it guidance rather than direction.

A second example of guidance comes from the strategy on decomposing a monolithic codebase (Document 20-1):

> Merge existing services into business unit monoliths where you can. We believe that each choice to move existing services back into a monolith should be made "in the details" rather than from a top-down strategy perspective. Consequently, we generally encourage teams to wind down their existing services outside of their business unit's monolith, but defer to teams to make the right decision for their local context.

This is another case of knowing the desired outcome, but encountering too much uncertainty to direct the team on how to get there. If you ask five engineers whether it's possible to merge a given service back into a monolithic codebase, you'll probably get five different answers. That's fine. Guidance makes it possible to make incremental progress in areas where more concrete direction would cause confusion.

### Using the categories

When working on a strategy's policy section, it's important to consider all of these categories. Which feel most natural to use will vary depending on your team and role, but they're all usable. For instance:

- If you're a developer productivity team, you might have to lean heavily on guidance in your policies and provide increased support for that guidance within the details of your platform.
- If you're an executive, you might lean heavily on direction. Indeed, executives often lean too heavily on direction, even though guidance often works better for areas where you understand the direction but not the path.
- If you're a product engineering organization, you might have to narrow the scope of your direction to the engineers within that organization, to deal with the realities of complex cross-organization dynamics.

Finally, if you have a clear approach you want to take that doesn't fit cleanly into any of these categories, don't let the framework dissuade you. Give it a try, and adapt if it doesn't initially work out.

## Maintaining Strategy Altitude

Chapter 4 introduced the concept of strategy altitude: being deliberate about where certain kinds of policies are created within your organization. Altitude is particularly relevant when considering if or how your new policies eliminate flexibility within your organization. Consider two somewhat opposing strategies:

- **Stripe's Sorbet strategy (Document 22-3)** could only have worked in an organization that enforced the use of a single programming language across (essentially) all teams.
- **Calm's strategy for resourcing Engineering-driven projects (Document 21-2)** acknowledged that resourcing had to be managed by the team directly. Attempting to solve the problem at another level would simply result in someone talking to the team directly to rewrite their priorities to incorporate a new urgent project.

Stripe's organization-altitude policy took away individual teams' freedom to select their preferred technology stacks. In return, it unlocked their ability to centralize investment in a powerful way. Calm went the opposite way, empowering only teams to manage the contents of their roadmap; executives were more senior, but frequently overridden by other executives' out-of-band instructions.

Both altitudes make sense. Both have consequences.

## Criteria for Effective Policies

In *The Engineering Executive's Primer*'s chapter on engineering strategy, Larson introduced three criteria for evaluating policies:

1. Policies ought to be **applicable**: useful for navigating complex real-world scenarios, particularly when making tradeoffs.
2. Policies should be **enforced**: teams are held accountable for following them.
3. Policies should **create leverage**, with a compounding or multiplicative impact.

The third criterion, creating leverage, made sense in the context of a book about engineering executives, but probably makes less sense here. Some policies certainly should create leverage — for instance, the policy to avoid deprecating APIs makes other customer retention mechanisms more effective — but others might not, like moving to an N-1 backfill policy. Outside the executive context, what's important isn't necessarily creating leverage, but that a policy **solves for part of the diagnosis**.

That leaves the other two criteria — being applicable and enforced — both of which are necessary for a policy to actually address the diagnosis. Any policy you can't determine how to apply, or aren't willing to enforce, simply won't be useful.

### Applying the criteria: talent density policies

First, consider policies aimed at improving the talent density of an engineering team:

> We only hire world-class engineers.

This isn't applicable, because it's unclear what "world-class engineer" means. Because there's no mutually agreeable definition in this policy, it's also not consistently enforceable.

> We only hire engineers who get at least one "strong yes" in scorecards.

This is applicable, because there's a clear definition. It's also enforceable — depending on the organization's willingness to reject otherwise good candidates who don't happen to get a strong yes.

### Applying the criteria: code reuse policies

Next, consider a policy regarding code reuse within a codebase:

> We follow a strict Don't Repeat Yourself policy in our codebase.

There's room for debate within a team about whether two pieces of code are truly duplicative, but this is generally applicable. Because there's room for debate, enforcing it will be a very context-specific determination.

> Code authors are responsible for determining if their contributions violate Don't Repeat Yourself, and rewriting them if they do.

This is much more applicable, because now there's only a single person's judgment to assess the potential repetition. In some ways, this policy is also more enforceable, because there's no longer any ambiguity around who decides whether a piece of code is repetitive.

The challenge is that enforceability now depends on one individual, and making this policy effective will require holding individuals accountable for the quality of their judgment. Larson illustrates with his own experience: he thinks adopting a service-oriented architecture was absolutely the best available choice at Uber, but he immediately paused service rollouts at Calm and at Carta after joining each. One policy, but very different outcomes depending on circumstances. If an organization is unwilling to make that sort of distinction — and to hold decision-makers accountable for making decisions that reflect those distinctions — it won't get any value out of the policy.

If you ever find yourself wanting to include a policy that for some reason can't be applied or enforced: stop. Ask yourself what you're trying to accomplish and whether there's a different policy that might be better suited to that goal.

## Developing Novel Policies

Larson's experience is that there are vanishingly few truly novel policies to write. Someone else has almost always done something similar to your intended approach already. Calm's engineering strategy (Document 21-1) is such a case: the details are particular to the company, but the general approach is common across the industry.

The most likely place to find truly novel policies is during the widespread-adoption phase of a new technology, such as mobile phones, cloud computing, or LLMs. Even then, as Document 17-1 explores, you can engage with the new technology as a generic technology:

> Develop an LLM-backed process for reactivating departed and suspended drivers in mature markets. Through modeling our driver lifecycle, we determined that improving onboarding time will have little impact on the total number of active drivers. Instead, we are focusing on mechanisms to reactivate departed and suspended drivers, which is the only opportunity to meaningfully impact active drivers.

You could simply replace "LLM-backed" with "data-driven" and it would be equally readable. In this way, policy can generally sidestep areas of uncertainty by being a bit abstract. This avoids being overly specific about topics you simply don't know much about.

However, even if your policy isn't novel to the industry, it might still be novel to you or your organization. The steps Larson has found useful to debug novel policies are the same steps as running a condensed version of the strategy process, with a focus on exploration and refinement:

1. Collect a number of similar policies and articulate how those policies differ from the policy you are creating.
2. Create a systems model (see Chapter 14) to articulate how the new policy will work, as well as how it will differ from the similar policies you're considering.
3. Run a strategy testing cycle for your proto-policy to discover any "unknown unknowns" about how it works in practice.

Whether you run into this scenario is largely a function of the extent of your — and your organization's — experience. Early in his career, Larson found himself doing novel (for him) strategy work very frequently; these days, it's much rarer for him than adapting well-known policies to new circumstances.

## Are Competing Policy Proposals an Antipattern?

When creating policy, you'll often have to engage with the question of whether you should develop one preferred policy or a series of potential policies to pick from. Developing a set of options is a useful stage of setting policy, but rather than helping you refine your policy, Larson encourages you to think of it as a way to expose gaps in your diagnosis.

For example, when Stripe developed the Sorbet Ruby-typing tooling, there was debate between two policies:

> Should we build a Ruby-typing tool to allow a centralized team to gradually migrate the company to a typed codebase?

or

> Should we migrate the codebase to a preexisting strongly typed language, like Golang or Java?

These were, initially, equally valid hypotheses. Only when the team clarified its diagnosis around resourcing did it become clear that it would be better to incur the bulk of costs in a centralized team than to spread the costs across many teams. Specifically, they recognized that they wanted to prioritize short-term product-engineering velocity, even if it led to a longer migration overall.

If you do develop multiple policy options, move the alternatives into an appendix rather than including them in the core of your strategy document (see Chapter 11 on readable strategy documents). Focusing on the selected approach makes it easier for readers to understand how to follow your policies, without the distraction of other possible approaches.

## Recognizing Constraints

Another frequent policy failure is developing a policy that you cannot possibly fund. It's easy to get enamored with policies that would only work in an alternate universe where it was possible to enforce and resource them — but adopting them would be bad policy.

A few examples:

- The strategy for controlling access to user data (Document 19-1) might have proposed requiring manual approval of every access to customer data by a second party. However, that would have gone nowhere, because it would have harmed customer experience by greatly slowing down internal workflows.
- The approach to Uber's service migration (Document 16-1) might have required more staffing for the infrastructure engineering team — but the authors knew that wasn't going to happen, so it would have been a meaningless policy to propose.
- The strategy for navigating private equity ownership (Document 18-1) might have argued that the new owners should not hold engineering accountable to a new standard on spending. But the owners would have just invalidated that strategy in the next financial planning period, because your leadership is never bound to honor a policy you write that they disagree with.

An impractical policy isn't just a poor one: it also suggests your diagnosis is missing an important pillar. Rather than debating the policy options, the fastest path to resolution is to align on a diagnosis that would invalidate some of the potential paths forward.

In cases where aligning on the diagnosis isn't difficult — for example, because you simply don't understand the possibilities of a new technology, as encountered in the strategy for adopting LLMs — then you've likely found a valuable opportunity to use strategy refinement to build alignment.

## Dealing with Missing Strategies

At a recent company offsite meeting, Larson and colleagues were debating policies to deal with annual plans that kept getting derailed after less than a month. Someone remarked that this would be much easier if they could get the executive team to commit to a clearer written strategy about which business units the organization was prioritizing.

They were, of course, right. It would have been much easier. Unfortunately, this goes back to the problem discussed in Chapter 7 about reframing blockers into diagnoses. If a strategy from the company or a peer function is missing, the empowering thing to do is to include the absence in your diagnosis and move forward.

Sometimes, even when you do this, it's easy to fall back into the belief that you cannot set a policy because a peer function might set a conflicting policy in the future. Whether you're an executive or an engineer, you'll never have all of the details you want to make the ideal policy. Meaningful leadership requires taking meaningful risks, which is never comfortable.

## Summary

After working through this chapter, you know how to develop policy, how to assemble policies to solve your diagnosis, and how to avoid a number of the frequent challenges that policy writers encounter. At this point, there's only one phase of strategy left to dig into: operating the policies you've created.
