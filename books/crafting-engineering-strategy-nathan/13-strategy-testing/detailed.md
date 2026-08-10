# Chapter 13: Strategy Testing for Iterative Refinement — Detailed Reference

## Introduction

Larson opens with the single idea about technical strategy he would popularize above all others if he could choose only one: **prematurely rolling out a strategy prevents you from evaluating whether the strategy is effective.** The reasoning behind this claim:

- Pressure changes people's behavior in profound ways.
- Under pressure, people often change their behavior specifically to create the *impression* that they are complying with your strategy, while in reality:
  - minimizing changes to the status quo (this is the typical response if you are an executive), or
  - working to get your strategy repealed (this is the typical response if you are *not* an executive).
- Neither response is particularly helpful — in both cases, the rollout has destroyed your ability to learn whether the strategy actually works.

Larson then frames the broader failure mode this chapter addresses:

- Some strategies are obviously wrong from the beginning, but it is **much more common** to see *reasonable* strategies fail because they didn't get the small details right.
- Premature pressure is one common symptom of a more general phenomenon: **most strategies are developed in a waterfall model**, finalizing their approach before incorporating the lessons that reality teaches when you attempt the strategy in practice.
- One effective way to avoid this "waterfall strategy trap" is **explicitly testing your strategy to refine the details.**

The chapter describes the mechanics of strategy testing, covering:

1. When it's important to test strategy (and when it isn't)
2. How to test strategy
3. When you should stop testing
4. Roles in strategy testing
5. Metrics and meetings for strategy testing
6. How to identify an untested strategy
7. What to do when a strategy has progressed too far without testing

Attribution: many of the ideas in this chapter came together while Larson was working with **Shawna Martell, Dan Fike, Madhuri Sarma, and many others in Carta Engineering.**

## When to Test Strategy

**Definition:** Strategy testing is *ensuring that a strategy will accomplish its intended goal at a cost that you're willing to pay.*

**Timing:** Because of this definition, testing needs to happen **before the strategy is implemented** — usually in its early development stages.

### Examples of when to test common strategy topics

- **Integrating a recent acquisition:** your testing might focus on getting a **single API integration** working before you finalize the overall approach.
- **A developer productivity strategy requiring typing in a Python codebase:** you might start by having an **experienced team member type one important module.**
- **A service migration:** you might attempt to migrate **one simple component** (to test the migration tooling) and **one highly complex component** (to test integration complexity) before moving to a broader rollout.

### The two most important properties of a test

In every case above, the two most important pieces are:

1. **Testing before finalizing the strategy.**
2. **Testing narrowly**, with a focus on the **underlying mechanics of the approach.** Avoid getting caught up in solving broad problems, like motivating adoption or addressing conflicting incentives.

### When you might not test a strategy

This isn't to say that every strategy needs testing. A few common cases where you might not want to test a strategy:

- **Permissive strategies that are very cheap to apply** (see Chapter 4 for permissive strategies). Testing isn't always important for these. Indeed, you can treat most highly permissive strategies as themselves being *tests* of whether it would be effective to implement a similar but less permissive strategy in the future.
- **Cases where testing isn't viable.** For example, a hiring strategy where you shift hiring into certain regions isn't something you can test in most cases; you might need to run it for **several years** to get any meaningful signal on results.
- **Cases of very high conviction** in a given strategy, where testing isn't worth it — perhaps because you've already done something nearly identical at the same company. Larson's caveat: "Hubris comes before the fall," so he is generally **skeptical of this category.**

### The default stance

That said:

- You should **try very hard to find a way to test every strategy.**
- You certainly **should not try hard to convince yourself that testing a strategy isn't worthwhile.**
- Testing is "so, so much cheaper than implementing a bad strategy that it's almost always a good investment of time and energy."

## How to Test Strategy

For a valuable step that's so often skipped, strategy testing is relatively straightforward. The approach Larson has found effective:

1. **Identify the narrowest, deepest available slice of your strategy.**
2. **Iterate on applying your strategy to that slice** until you're confident the approach works well.

Example: if you're testing a new release strategy for your Product Engineering organization, you might decide to do **exactly one important release** following the new approach.

### Metrics during testing

As you iterate, identify metrics that help you verify the approach is working. These metrics should measure **not adoption, but the impact of the change.** For example: metrics showing that the new release process **reduces customer impact** or **drives more top-of-funnel visitors** — rather than metrics counting who is using it.

### The good-intent operating assumption

Operate from the belief that **people mean well**, and that strategy failures are most likely due to **excess friction and ergonomics that make adoption difficult.** For example, if people aren't using the release tooling:

- You might assume that the tooling is **too complex.**
- You definitely should **not** assume that people are just too resistant to change.

### When to stop testing

Keep refining until you're **positive** that your strategy's details work in practice — **or** that they don't, and thus you need to approach the strategy **from a new direction.** Either conclusion is a valid stopping point.

The chapter's example, in its own words: "if the metrics you previously identified show that the new process has significantly reduced the customer impact of the new release, that's a clear sign that you need to change course." (The point is that the previously identified impact metrics are what deliver the clear, decisive signal about whether to keep the approach or change direction.)

### What NOT to do (the most important details)

The most important details are the things you should not do:

- **Don't go broad** in areas where impact feels higher but iteration cycles are slower.
- **Don't get so caught up in forcing people to adopt the new approach** that you're distracted from improving the underlying mechanics.
- **Don't get so attached to your current approach** that you can't accept that it might not be working. Strategy testing is *only* valuable because many strategies don't work as intended, and it's much cheaper to learn that early.

## Testing Roles: Sponsors and Guides

Sometimes the strategy-testing process is led by one individual. However, it's **more common** for the responsibilities to be split between two roles:

- a **sponsor**, who provides organizational authority, and
- a **guide**, who coordinates the day-to-day work of validating the approach.

### The sponsor

Who fills the role: the sponsor might be **an executive**, or (at a smaller company) **a principal engineer.**

The sponsor is responsible for:

- Making quick decisions when necessary to avoid getting stuck in the development stages
- Pushing past historical decisions and old beliefs that prevent meaningful testing
- Marshaling support across the organization
- Storytelling to stakeholders — especially the executive team — to keep funding flowing
- Preventing people from overloading the strategy (to make it solve their semirelated problem)
- Setting the pace to avoid stalling out
- Identifying when the energy is dropping
- Identifying when to change to the next phase of strategy building (such as from development to implementation)

### The guide

Who fills the role: the guide could be **an engineering manager**, **a technical program manager**, or (at a larger company) **a principal engineer.**

The guide is responsible for:

- Translating the strategy into particulars, especially when testing gets stuck
- Identifying and addressing slowdowns and blockers
- Escalating issues to the sponsor **as frequently as needed**
- Tracking goals and workstreams
- Maintaining the pace set by the sponsor

### Lessons on filling these roles

Larson's accumulated lessons on staffing the two roles:

**For sponsors**, what matters the most:

- They're **genuinely authorized by the company** to make the decisions they're making.
- They **care enough about the impact** to be willing to make difficult decisions quickly.
- A sponsor is **only meaningful to the extent that they're available to rapidly resolve any issues the guide escalates to them.** If they aren't available for escalations, or don't resolve them quickly, **they're a poor sponsor.**

**For guides**, you need someone who:

- Can **execute at the sponsor's pace** without getting derailed by various organizational messes.
- Has **good, nuanced judgment relevant to the strategy being tested.**

The **worst guides** are:

- **Ideological** — they reject the results of testing.
- **Easily derailed.** You're likely testing because there's friction somewhere, so someone who can't navigate friction is going to **fail by default.**

## Meetings and Metrics

### The weekly meeting requirement

The **only absolute requirement** for the strategy-testing phase: the sponsor, guide, and any other key folks working on the strategy **must meet every single week.**

Within that meeting, you will:

- **Iterate on which metrics** capture the current areas you're trying to refine
- **Discuss what you've learned** from prior metrics or data
- **Schedule one-off follow-ups** to ensure you're making progress

### Character of the meeting

The best version of this meeting is **heavy on debugging and light on presentation.**

### The weekly health check

Look with some suspicion at any week where you're **not** doing at least one of:

- learning something that informs subsequent testing, or
- making a decision that modifies your approach to testing.

A learning-free, decision-free week might mean:

- you've **underresourced** the testing effort, or
- your testing approach is **too ambitious.**

Either way, it's a **meaningful signal that testing isn't showing enough promise to maintain attention.**

### If the commitment seems too large

If all of this seems like an overly large commitment, Larson pushes you to consider your **strategy altitude** — adjust the **volume** or **permissiveness** of the strategy you're working on. The logic: if a strategy isn't worth testing, then it's either:

- **already quite good** (which should be widely evident), or
- **only worth rolling out in a highly permissive format.**

## Identifying Untested Strategies

### The core observation

While not all strategies must be refined by a testing phase, **essentially all failing strategies skip the testing phase** to move directly into implementation. Strategies that skip testing **sound right, but don't accomplish much.**

Example: fully standardizing authorization and authentication across your company on one implementation *sounds right*, but can still fail — for example, **if each team is responsible for its own approach to determining the standard.** (The direction is fine; the missing detail of who decides the standard sinks it.)

### "Pressure without a plan"

One particularly obvious pattern is what Larson describes as **"pressure without a plan"**: a strategy that sounds right but **lacks concrete details.**

- **Service migrations are particularly prone to this** — perhaps due to apocryphal descriptions of **Amazon's service migration in the 2000s**, which is often summarized as a **top-down, zero-details mandate to switch away from the monolith.**

### The two identification questions

Identifying an untested strategy comes down to understanding two things:

**Question 1: Are there numbers that show the strategy is driving the desired impact?**

- Example: tracking **API requests to the new authentication service as a percentage of all authentication requests** is more meaningful than **a spreadsheet tracking whether each team has formally committed to moving** to the new service.
- Rule: **try to avoid proxy metrics when possible; look at the actual thing that matters.**

**Question 2: If the numbers aren't moving, is there a clear mechanism for debugging and solving those issues — and is this team actually making progress?**

- Example: a team supporting adoption of a new authentication service might **look slow** as it designs an approach to migrating existing services to fit the new service's design — but it's **still making progress as long as it's uncovering a path forward.**

### Validating progress when the numbers aren't moving

Because the numbers aren't moving, you need to find a **different source of meaningful evidence** to validate that progress is happening:

- Generally, the **best bet is new software running in a meaningful environment.** For product code, that meaningful environment is **production.**
- It's also useful to **talk with skeptics or veterans of failed integrations** — but **be cautious of debugging exclusively with skeptics.** They're **almost always right, but often aren't describing current problems** (their criticisms tend to be about the past, not the present).

### The decision rule

**Unless the answer to one of these two questions is obviously yes, it's very likely that you've found a strategy that hasn't been tested.**

## Recovering from Skipped Testing

Once you've recognized a strategy that skipped testing and is now struggling, the next question is what to do about it.

### Reference document and provenance

- The strategy doc **"Should We Decompose Our Monolith?" (Document 20-1)** looks at recovering from a failing service migration.
- That document is **lightly based on Larson's experience dealing with similarly stuck service migrations at both Calm and Carta.**

### The recovery rule

**The answer to a stuck strategy is always to write a new strategy — and don't skip testing this time.**

### Pausing the struggling strategy

Typically, recovery means **explicitly pausing the struggling strategy while you run a new testing phase.** This is painful to do because:

- the people invested in the current strategy will be upset with you —
- but there will **always** be people who disagree with **any** change.
- In the long term, **the only thing that makes most people happy is a successful strategy**, and anything that delays progress toward that is a **poor investment.**

### Implicit pauses when an official pause is infeasible

Sometimes it is difficult to pause a struggling strategy *officially*. In that case, look for an **indirect mechanism to pause it implicitly.** Example:

- **Delaying new services while you take a month to invest in improving service provisioning** might give you enough breathing room to **test the missing mechanisms from your strategy, without anyone losing face over a failing migration.**

Larson's closing qualification: it would be nice to always be able to say these things out loud, but **managing personalities is an enduring leadership challenge** — even when you're an executive, you just have a **different set of messy stakeholders.**

## Summary

- Testing doesn't determine whether a strategy *might* be good. It **exposes the missing details required to translate a directionally accurate strategy into a strategy that works.**
- After reading this chapter, you know how **sponsors and guides** lead that translation process.
- You can **set up and run the necessary meetings** to test a strategy.
- You can also **put together metrics** to determine if the strategy is ready for a broader rollout.
