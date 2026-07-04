# Chapter 10: Operations — Detailed Reference

## Introduction

Even the best policies fail if the teams they're intended to serve don't adopt them. The chapter opens with a rhetorical question: can you persistently change your company's behaviors with a one-time announcement? The answer: "No, probably not."

Larson names the art of making policies work **operations**, or **strategy operations**. Two framing claims set up the chapter:

- Effectively operating a policy is **two-thirds avoiding common practices that simply don't work**.
- The remaining **one-third takes some repetition, but can be practiced in any engineering role** — there is no need to wait until you're an executive to start building mastery.

The chapter's stated focus areas:

1. How operations support policies with mechanisms that ensure they work well.
2. Evaluating operational mechanisms to select the most effective choice.
3. Composing an operational plan to support your specific set of policies.
4. Operations mechanisms, effective and otherwise — including approval forums, inspection mechanisms, and nudges.
5. How to adjust your approach to operations if you are in an engineering (non-executive) role.
6. The largest threat to effective strategy operations: **cargo-culting**.

The chapter promises two uses: it shows you how to roll out a strategy of your own, and it also provides a **rescue toolkit** you can use to put an existing, floundering strategy back on track. If you don't see an opportunity to write new strategy within your organization, there's still probably room to flex your operational skill.

## What Are Operational Mechanisms?

**Definition:** Operations are how a policy is implemented and reinforced. Effective operations ensure that your policies actually accomplish something.

Examples of operations:

- A recurring weekly meeting.
- An alert that notifies the team when a threshold is exceeded.
- New requirements for promotions.

### Example: the N-1 backfill policy (Document 18-1)

The strategy for working with new private equity ownership (Document 18-1) introduces a policy to backfill hires at a lower level and cap the number of principal engineers. The policy text:

> We will move to an "N-1" backfill policy, where departures are backfilled with a less senior level. We will also institute a strict maximum of one Principal Engineer per business unit, with any exceptions approved in writing by the CTO—this applies for both promotions and external hires.

This policy introduces an **explicit operational mechanism**: escalations go to the CTO. It also introduces an **implicit, undefined mechanism**: how do we ensure the backfills are actually down-leveled as the policy instructs? Three potential operational solutions to implementing this policy:

1. The CTO approves the levels of backfilled roles in a group chat with engineering recruiting.
2. Enforcing downleveling becomes the Recruiting team's responsibility.
3. Take it on trust that hiring managers will do the right thing.

**Operations is the art of picking the right option for your circumstances, running it, and tweaking it as you learn.**

### Sidebar: Operations in Government

For another interesting take on how critical operations are, Larson recommends *Recoding America* by Jennifer Pahlka (Metropolitan Books, 2023) as well worth the read. It explores how well-intended government legislation often isn't feasible to implement, which results in policies that require massive IT investments but provide little benefit to constituents.

## How to Evaluate Mechanisms: A Rubric

To determine the most effective operational mechanisms for the problems you're working on, it's useful to have a standardized evaluation rubric. The rubric presented here isn't perfectly universal, but **having any rubric will make it easier to evaluate your options consistently**, and you can customize it for your needs.

Larson's rubric for evaluating whether an operational mechanism will be effective has **six factors**:

1. **Measurability** — Can you measure both leading and lagging indicators to inspect the mechanism's impact? If you have to choose, measuring leading indicators allows much quicker evaluation so you can iterate on your mechanisms.

2. **Adoption cost** — How much work will migrating to this mechanism require? Can this work be done incrementally, or does it require a major, coordinated shift?

3. **User ease (or burden)** — After adopting this policy, how much easier (or harder) will it be for users to perform their work? If things will be harder, can those users tolerate the additional effort?

4. **Provider ease (or burden)** — How much additional ongoing maintenance will this mechanism require from the centralized or platform team providing it? Example: if every new architecture proposal requires a thorough review by your Security team, can the Security team actually support those reviews?

5. **Reliance on authority** — How much does this mechanism depend on a top-down authority's active support? If the sponsoring executive departs, will this mechanism remain effective? Is that an effective tradeoff in this case?

6. **Cultural alignment** — Is this something that your organization wants to do, or something it will fight at each step? Is there a way you can adjust the framing to make it more acceptable to your organization's culture?

### The common failure: not accepting the evaluation's consequences

Larson finds that folks are generally good at evaluating mechanisms against these criteria, but **somewhat worse at accepting the consequences of their evaluation**. Two illustrative failure modes:

- Someone falls in love with a particular mechanism whose adoption cost is unbearably high and tries to force the organization to accept it.
- Someone introduces a mechanism that creates significant user burden for a team already struggling with tight efficiency goals.

Self-awareness helps here, but so does **consulting others who are willing to point out the errors in your reasoning** — which Larson identifies as a core part of how he has found success in adopting operational mechanisms.

## Composing an Operational Plan

**Definition:** Your operational plan is the sum of the mechanisms used to support your policies. Evaluating each individual mechanism in isolation is part of creating an operations plan, but it's also valuable to consider how the mechanisms will work **together**. The composition process:

1. **Review the policies you've developed.** What sort of mechanisms seem most likely to support these policies? How might you pool these mechanisms together to avoid redundancy?
2. **Review the operational mechanisms used in your organization.** Which have had the best effects, and which have left too bad an aftertaste to be reused?
3. **Revisit mechanisms from your exploration phase.** Which new mechanisms showed up in exploration? If any of them seem particularly well suited to the policies you're considering, and none of your organization's frequently used mechanisms are good fits, consider testing a new one.
4. **Evaluate each mechanism you're considering against the evaluation rubric** (the six factors above).
5. **Consolidate the full set of mechanisms into one coherent operational plan.** Be particularly mindful of any ease or burden the *integrated* plan creates for users and/or platform providers.
6. **Validate your plan with users and providers** to make sure they don't impose an unreasonable burden or a workflow that simply won't work.
7. **If you run this process and still can't agree with stakeholders on your proposed plan, commit to running a strategy testing process that includes the plan.** This will build confidence in the approach before people feel forced to commit to following it long-term.

Even if you don't use strategy testing for your plan, **at least schedule a review in three months** to reflect on how things have worked out.

Closing emphasis: your operational plan is **the vehicle that delivers your policies to your organization**. It's extremely tempting to skip refining the details here, but doing so is a relatively quick step that can **completely change your strategy's outcomes**.

## Effective Mechanisms and Patterns

Most companies have a handful of frequently used operational mechanisms. Some are company-specific, such as **Amazon's weekly business review**; others repeat across companies, like **requiring executive approval**. This section categorizes the mechanisms Larson has found consistently effective.

### Approval and Advice Forums

The motivating problem: at a high level, new policies are obvious and simple; they apply cleanly to the problem they're intended to solve. However, when you apply those policies to detailed, complex circumstances, it isn't always clear how to stay loyal to the policy's intentions. **Approval and advice forums are a common solution to that problem.**

#### Example: Calm's CTO exception process (Chapter 21)

Calm's product engineering strategy shows the simplest, most common approval forum in practice:

> Exceptions are granted by the CTO, and must be in writing. The above policies are deliberately restrictive. Sometimes they may be wrong, and we will make exceptions to them. However, each exception should be deliberate and grounded in concrete problems we are aligned both on solving and how we solve them. If we all scatter toward our preferred solution, then we'll create negative leverage for Calm rather than serving as the engine that advances our product.
>
> All exceptions must be written. If they are not written, then you should operate as if it has not been granted. Our goal is to avoid ambiguity around whether an exception has, or has not, been approved. If there's no written record that the CTO approved it, then it's not approved.

This example also has several weaknesses that are common in approval forums. Most importantly, it doesn't explicitly specify:

- **How to get approvals** (perhaps by asking in a `#cto-approvals` Slack channel).
- **How to research prior requests and approvals.**

#### Loaned authority: the LLM adoption strategy (Document 17-1)

Approvals don't necessarily need to come from senior leadership. Instead, senior leadership can **loan their authority on a topic to another group**. The LLM adoption strategy in Document 17-1 provides a good example:

> Start with Anthropic. We use Anthropic models, which are available through our existing cloud provider via AWS Bedrock. To avoid maintaining multiple implementations, where we view the underlying foundational model quality to be somewhat undifferentiated, we are not looking to adopt a broad set of LLMs at this point. This is anchored in our Wardley map of the LLM ecosystem.
>
> Exceptions will be reviewed by the Machine Learning Review in #ml-review.

Here exceptions route to the Machine Learning Review in a `#ml-review` channel rather than to an executive.

#### Community-grounded forums and variations

In a more community-minded organization, approval forums might not require senior leadership to be involved at all. Instead, the culture might create an environment where the forums' feedback is taken seriously **on its own merits**.

Every company does approval forums a bit differently:

- At **Carta**, the **Navigators program** experimented with granting executive authority for technical decisions to named engineers in each area.
- Larson recommends **Andrew Harmel-Law's** discussion of this topic in *Facilitating Software Architecture* (O'Reilly, 2024).

You can spend a lot of time arguing the details here. Larson's experience: **having the right participants and a good executive sponsor matter a lot, and the other pieces matter a lot less.**

### Inspection

The motivating observation: while even the best policies can fail, it's more common for a policy to **sort of work** and need some modest adjustments. An inspection mechanism allows you to evaluate whether your policy is succeeding and whether you need to make adjustments.

#### Example: the user-data access strategy (Document 19-1)

> Measure progress on percentage of customer data access requests justified by a user-comprehensible, automated rationale. This will anchor our approach on simultaneously improving the security of user data and the usability of our colleagues' internal tools. If we only expand requirements for accessing customer data, we won't view this as progress because it's not automated (and consequently is likely to encourage workarounds as teams try to solve problems quickly). Similarly, if we only improve usability, charts won't represent this as progress, because we won't have increased the number of supported requests.
>
> As part of this effort, we will create a private channel where the security and compliance team has visibility into all manual rationales for user-data access, and will notify the manager of anyone who repeatedly uses a manual justification for accessing user data.

Larson's assessment: this example is a good start, but **fully realizing an inspection mechanism requires concretely specifying where and how the data will be tracked**. A better version would include:

- A dashboard link.
- A commitment to reviewing the data at specified intervals.

#### Example: asynchronous recurring review

For a recent inspection mechanism, Larson created a **recurring invite** for the working group members who had agreed to review the data, with a link to the relevant data dashboard and a specific chat channel for discussion. This wasn't a synchronous meeting, but rather **a commitment to independently review the data and discuss anything that felt surprising**.

#### Forms and the cardinal rule

Your particular inspection mechanisms could be:

- Threshold-triggered alerts.
- Something you fold into an existing metrics review meeting.
- A script you commit to running and reviewing periodically.
- Something else.

The most important property: **it cannot silently fail**. If your mechanisms fail without triggering inspection, then they won't accomplish anything.

### Nudges

The motivating observation: it's common to hear complaints about how a team isn't following a new policy, as if it were a deliberate choice they'd made. Larson finds that **people usually want to do things the new way, but rarely take time to learn how**.

**Definition:** Nudging means providing individuals with context to inform them about a better way they might do something. Nudges are an exceptionally effective mechanism.

#### Example: Stripe's cloud-spend nudge

At Stripe, there was a policy of allowing teams to **self-authorize new cloud hosting costs**. This worked well almost all the time. However, sometimes teams would accidentally introduce large cost increases — almost always without realizing it. Even if they'd been told not to introduce unapproved spending spikes, **they simply didn't perceive they'd done it**.

The choice: prevent all teams from introducing new spend, or try a nudge. The nudge added did a few things:

1. Informed teams whenever their cloud spend **accelerated month over month**.
2. Directed them to **charts that explained the acceleration**.
3. Told them **where to go to ask questions**.

Nudges pair well with inspections, so the **Efficiency Engineering team reviewed any spikes monthly** and reached out where necessary.

The trade-off analysis: maybe all teams could have been forced to review new spend, but the nudge approach **didn't require an authoritative mandate**. It also meant time was spent advising only teams that **actually** spent too much, instead of having discussions with every team that **might** spend too much.

#### Example: Carta's untested pull request nudge

At Carta, some managers had said they didn't know when or why their team members merged untested pull requests. The working group added a nudge to **inform managers anytime this occurred**. This made it easy to detect and also **respected their attention** by only sending a notification if there was a new, untested pull request.

#### Doing nudges well

With poor ergonomics, nudges can be an overwhelming assault on your colleagues' attention; done well, Larson continues to believe **they are the most effective operational mechanism**. To stay in the effective camp:

- **Limit the total number of nudges.**
- Ensure that **each nudge has an explicit action** that the recipient can take.
- Include **clear instructions on how to take that action**.

The underlying reasoning: people can't enforce policies if they don't know they exist or how to follow them. In Larson's experience, nudges are the most effective way to solve **both** of those problems, because **nudges bring information to people at exactly the moment that information would be useful**. At most companies, well-done nudges are relatively uncommon, and the far more common solution to lack of information is documentation and training (the next section).

### Documentation and Training

There are many approaches to documentation and training. Larson explicitly hedges here: he has **not** found his own approaches particularly effective, so he hesitates to give much advice. **Following standard practices for your company, even if the outcomes seem imperfect, is probably your best bet.**

Two warnings:

- Internal knowledge bases **tend to rot quickly**.
- Introducing yet another knowledge base is **almost always an illusion of progress** — even when you really don't like the current one.

The success criterion: for documentation and training, the measure of success is **not** necessarily that everyone in the company knows how the new policy works. A more useful goal is **"informational herd immunity"**: as long as someone on each team understands your policy, the team will generally be capable of following it.

### Automation

The motivating observation: relying on humans to respond to new policies is **slow**, and the **quality of response will vary**. In many cases, automation is the most effective and scalable mechanism to support your policies' rollout.

#### Example: Uber's service migration strategy (Document 16-1)

Automation was key in the Uber service migration strategy, moving out of a slow manual process that was taking up a great deal of user and provider time:

> Move to structured requests, and out of tickets. Missing or incorrect information in provisioning requests create significant delays in provisioning. Further, collecting this information is the first step of moving to a self-service process. As such, we can get paid twice by reducing errors in manual provisioning while also creating the interface for self-service workflows.

In that case, better automation allowed elimination of a series of back-and-forth negotiations to collect data, instead providing the necessary information in a single step. Occasionally there were still users who couldn't fill in the form, but now the team could **focus on providing a good manual experience for those rare exceptions**.

#### The user-experience condition

**Automation can't have a positive impact as a core strategy mechanism without an effective user experience.** If you view user experience as a secondary concern, automation is unlikely to make much impact.

### Deferral to Future Work

The motivating situation: sometimes there's something you really want a policy to do, but you also know that you have **no reasonable mechanism** to do it. In that case, **explicitly deferring action** can be useful.

#### Example: the Index acquisition integration at Stripe (Document 22-4)

> Defer making a decision regarding the introduction of Java to a later date: the introduction of Java is incompatible with our existing engineering strategy, but at this point we've also been unable to align stakeholders on how to address this decision. Further, we see attempting to address this issue as a distraction from our timely goal of launching a joint product within six months.
>
> We will take up this discussion after launching the initial release.

#### Example: the private equity acquirer strategy (Document 18-1)

> We believe there are significant opportunities to reduce R&D maintenance investments, but we don't have conviction about which particular efforts we should prioritize. We will kick off a working group to identify the features with the highest support load.

The principle: **there's no shame in deferral**. As much as you want to make progress on a certain area, it's better to explicitly acknowledge that you can't right now — **and clarify when you will be able to** — than to allow the organization to continue churning on an intractable problem.

### Meetings

You can fit any and all of the preceding mechanisms into a meeting. Meetings are a **universal mechanism**, although frequently overused, because they can do an adequate job of operating almost any policy. Meetings are **almost always the most expensive mechanism you can find** to solve a problem, but they are **easy to suggest, run, and iterate on**.

#### Reporting meetings: the most common type

The LLM adoption strategy (Document 17-1) suggests reporting progress in the Executive Weekly Meeting:

> Develop an LLM-backed process for reactivating departed and suspended drivers in mature markets. Through modeling our driver lifecycle, we determined that improving onboarding time will have little impact on the total number of active drivers. Instead, we are focusing on mechanisms to reactivate departed and suspended drivers, which is the only opportunity to meaningfully impact active drivers.
>
> Report on progress monthly in Exec Weekly Meeting, coordinated in #exec-weekly.

#### Other archetypes and guidance

Another common meeting archetype is the **weekly working meeting**, discussed in Chapter 13.

If you can't find any other mechanism you believe in, a meeting is a **decent starting point**. Just don't get too fond of them — and **try to iterate your way to canceling every recurring meeting that you start**.

## Antipatterns and Ineffective Mechanisms

In addition to the effective operational methods in this chapter, there are a number of frequently used mechanisms Larson considers **antipatterns**. They can provide some value, but **there's almost always a better alternative**.

1. **Top-down pronouncements** — Sometimes leaders operationalize a policy by simply declaring that it must be followed. Example: some "return to office" policies dictate that the team must work from a central office, but driving a real change requires **motivating those individuals to actually return**.

2. **Education-as-announcement rollouts** — Many companies roll out policies through one-time "education" by default, often as an all-company announcement for existing employees. They might follow up by updating training for onboarding new hires. Education sounds great, but **a couple of trainings will never change the whole organization's behavior**. Changing that requires ongoing reminders, visible role models, inspections to understand why some teams are not adopting the behavior, and so on. **Education can be a good component of operationalizing a policy, but it cannot stand on its own.**

3. **Mandatory recurring trainings** — These are a staple of compliance-driven policies, generally because of laws mandating a certain number of hours of relevant training each year. There are two deep challenges:
   - Because attendance is required, **trainers tend to make little effort to make their content good**.
   - Many **trainees don't pay attention because they expect low-quality content**.

   It's not uncommon to hear people who've been trained on a policy annually for years say that they've never heard of that policy. It's possible to overcome these barriers, but in a situation where you're accountable for **actually changing the outcomes** (as opposed to simply shifting legal obligations away from the company), mandatory trainings tend to work poorly.

4. **"Just change the culture"** — Some leaders frame most problems as cultural problems, which is reasonable and often useful. Unfortunately, it's common for those who rely heavily on cultural framings to have **simplistic views about how to change culture**. Changing an organization's culture is tricky. It requires a combination of many techniques to create **visible leaders role-modeling the new behavior**, as well as **reinforcement mechanisms to weed out pockets of dissent**. Anyone who frames culture change as a simple or instant change "is living in an imaginary world."

Final qualification: if you're using one of these approaches, it isn't necessarily a bad choice. Just make sure you can **explain why you're using it — and make sure you believe that explanation**. If you don't, look for a more effective mechanism.

## What If You're Not an Executive?

It's easy to get discouraged thinking about which operational mechanisms are unavailable to you as a nonexecutive, like running mandatory recurring meetings or starting a binding architecture review process.

However, **there's always a related mechanism that can be implemented with less authority**:

- A binding architecture process can be replaced with an **architectural advice process**.
- A mandatory review of pull requests can be replaced with a **nudge**.

A key counterpoint from Larson's experience **as an executive**: although authoritative mechanisms may be more common, **they don't work particularly well**. They do a great job of technically shifting accountability to the wider organization, but **they often don't change anyone's behavior at all**.

The recommended path: instead of getting frustrated by what you can't do, focus on the mechanisms that are available to you today —

- Add nudges.
- Focus on the real dynamics of how colleagues do work in your organization.
- Build a real dataset.

The escalation logic: it's **very hard** to get an executive to support your initiative **before** you have mechanisms and data to support it, and **very easy** to get their support **once you do**. Once you've done what you can without authority to build confidence, if you really do need more authority, then you're in a good place to escalate to get an executive to support your policies.

## Beware Cargo-Culting

**Definition:** Cargo-culting is recreating a process that previously solved a problem **without understanding the circumstances that made that process effective**.

In some cases, that's enough: **you can kick a ball without understanding physics**. However, it's often disastrous: **how Larson's toddler thinks driving a car works is very different from how driving a car actually works**.

Larson's observation: the longer he works in the software industry, the more he is surprised by **how few strategists seem to care if their approaches actually work**. Instead, they seem focused on:

1. Doing something that *might* work,
2. Offloading accountability to the organization or some team, and
3. Moving off to the next problem.

A possible explanation: leaders are often evaluated by **how they appear**, rather than by **what they accomplish**. Either way, it's surprisingly difficult to know which patterns to borrow from strategy rollouts and implementations.

The best advice (Larson concedes, "unfortunately"): **remain skeptically optimistic. Collect ideas widely, but force them to prove their merit.**

## Summary

Having finished this chapter, you're significantly more qualified to write a complete, useful strategy than Larson was a decade into his career. The operations behind your strategy are **at least as essential as any other step, but are often skipped**; any strategy without them **"will fade quietly into your organization's history."**
