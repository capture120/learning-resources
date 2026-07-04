# Chapter 4: When Should You Write Strategy—and How Much? — Detailed Reference

## Introduction

Even for someone who believes strategy is generally useful, two universal problems arise. First, it is difficult to decide that *today* is the day to start writing engineering strategy. Second, once you do start, it is easy to write such an overwhelming amount of strategy that your organization ignores it rather than investing the time to understand it. Both extremes are failure modes, and a handful of useful mental models exist to avoid each one.

The chapter covers four topics:

1. When to write strategy.
2. How much strategy your organization can tolerate.
3. Using **strategy altitude** — how permissive a given strategy is, and where it's implemented — to manage the overhead that strategies create.
4. Mechanisms to debug whether you're doing too much or too little strategy work.

The stated outcome: after reading, you should have a clear perspective on when to start writing strategy, on determining how many strategies to write, and on using strategy altitude to reduce overhead when you do decide to write a high volume of strategies.

## When to Write Strategy

The section opens with a personal example. Shortly after becoming Calm's CTO, Larson opened a document, titled it "Engineering Strategy," stared into "that blank abyss," and then put it away — for a year. When he came back to it, he documented three guiding principles:

- Choose boring technology
- Resolve conflict with curiosity
- Prefer vendors for commoditized functionality

These simple statements greatly reduced conflict in decision making and allowed the organization to focus more energy on improving the product. When Larson started, he felt the organization needed a clearer strategy, but he just didn't know what to write — so he wrote nothing.

The lesson drawn: often, writing nothing is the best available choice. A common slur against leaders is that they "want to be strategic," implying they're too focused on abstract ideas rather than the concrete needs of today. Behind that allegation is an important truth: strategy work isn't always the most valuable way you can spend your time. Sometimes working on strategy is just a way of "snacking" to avoid doing something more important.

Before starting strategy work, you must decide whether now is the correct time. That decision depends on three criteria:

1. Your organization's **current strategic state**.
2. The **trend** of that strategic state over time.
3. Whether you have **enough context** to be effective.

### Current Strategic State

The first criterion is the idea of *strategic state*. Using the example of service architecture strategy (the chapter points to Document 20-1, a service architecture strategy elsewhere in the book), an engineering organization is in one of three strategy states:

**Globally consistent**
: There is a clearly agreed-upon strategy, *even if it's not written down*. When you ask different members of the team how to approach a given problem, you get similar answers. Example: everyone agrees to write new product functionality in the existing monolithic codebase.

**Consistent within teams**
: There is a clear strategy within pockets of the organization, but some inconsistency across pockets. Example: product engineering believes all new functionality should be in a new service within a shared monorepo, but platform engineering believes all new functionality should be implemented in a monolith.

**Highly varied**
: There's little agreement across individuals within engineering on how to approach problems. Example: some engineers want to do work in new services in a monorepo, others in new services in polyrepos, and some believe in implementing new functionality in an existing monolithic service.

Decision rule: if your organization is globally consistent, it's unlikely that doing more strategy work will be useful — *unless* your organization is consistently deciding upon undesirable approaches. If you're in either of the latter two states (consistent within teams, or highly varied), then it's likely a useful time to write some strategy.

### Trends in Strategic State

Even if the organization's current state is good, if it's *trending toward a worse state*, now is a valuable time to start doing strategy work. Conversely, if the current state is decent and trending toward something better, it's likely not a valuable opportunity.

A handful of recurring causes can lead to abrupt — sometimes unexpected — shifts in strategic state, making each of them a good opportunity to consider writing strategy:

**How much you are — or aren't — hiring**
: Uber doubled its engineering headcount every six months for four years and opened many distributed engineering offices, which led to highly varied approaches. It also meant that most engineers were recent hires, driving up inconsistency even more.

**Whether your newly hired external leaders tend to be playbook-driven or respond to the organization's current context**
: Although it's a known antipattern in executive onboarding, many leaders are so desperate to make an early impact that they forget to diagnose their new environments before making sweeping changes. This creates a strategy rift between teams that align with the new direction and teams maintaining the existing software and infrastructure.

**How frequently you have significant organizational changes**
: Changes such as reorganizations or layoffs can break the mechanisms that propagate organizational culture, which are the sort of subtle glue work that often gets ignored in spreadsheet-driven exercises.

**How effectively you document and communicate historical decisions**
: Communication during onboarding is key. Some companies drill new hires on how decisions are made; others expect teams to do the training locally. Both approaches can work well. Both can work poorly.

### Your Context Level

Finally, even if the current state is poor and getting worse, you have to assess whether you understand the organization well enough to start doing useful strategy work. Many new leaders jump in, make assumptions without testing them, and attempt a massive migration or some other grand, sweeping gesture. That might feel like an audacious example of driving strategy, but "it's mostly just anxiety and ego wrapped in a Gantt chart."

Two self-test questions determine readiness:

- Do you understand the history around the areas you want to change?
- Do you understand the individuals who made the decisions, and the context that made them good decisions at the time?

If so, you're ready to step into strategy. If not, it's worth slowing down to build the relationships and context necessary to make your subsequent work useful.

Combined decision rule for the whole section: if things could be better or are trending down, *and* you know enough about the company to get started, then it's time to start working on strategy.

## How Much Strategy to Write

The next question is how much strategy to undertake. Should you write something about programming language choice? Or service decomposition? Or how you prioritize bugs? Or should it be about data warehouses? What about doing all four at once?

The potential strategies you could work on are genuinely infinite, so it's hard to decide where to start. By far the most valuable decision you can make is to **limit the work you have in progress at any given time, even if it means starting smaller than you want**. What Larson has found effective: start with small pieces of strategy, iterate until you get them working, and only then move on to something larger. Limit yourself to developing one or two strategies at a time. This gives you the bandwidth to ensure your strategies actually work.

To remain effective while limiting concurrent strategy development, it's important to have a **clear, but lightly held, point of view about where you want to get over time**. This clarity makes it possible to align small chunks toward the same destination so they build into something larger, while also remaining flexible enough to adjust as each step teaches you more about the path you're on.

Concrete example — Uber: the organization was having reliability and productivity issues related to its monolithic Python codebase. Larson's team didn't have the ability to forbid commits there, but it did have the ability to make service provisioning "really, really easy." So the team created a strategy around making service provisioning and operation as painless as possible. The strategy aimed to solve a *later* problem — decomposing and departing from the monolith — but the team didn't address that directly. They focused on the first step, believing it was a necessary prerequisite for the subsequent steps. After they proved out the first step, it then became possible to work strategy on the subsequent steps.

The counterfactual: had they started with the broader strategy, they might have gotten stuck in an intellectual debate about what should happen in the future, and success would have required many different teams to buy into the future vision without any concrete step to take right then and there. By narrowing focus, the team was able to iterate on the prerequisites and **delay building consensus until there was a concrete step they needed people to take**. At that point, there was no intellectual debate about whether it was possible, because most people were already operating as intended.

One challenge with reducing the volume of your concurrent strategies is that it **appears unambitious**. In the Uber example, the real need was to solve development in the monolithic codebase, but instead the team was talking about service provisioning. From a distance, it must have seemed like they'd lost the plot. This is a recurring challenge: effective strategy development can appear overly conservative. The solution to that apparent lack of ambition is to pair your focused approach with **broader, proactive storytelling to your stakeholders**. This allows the team's execution to remain focused while also explaining to stakeholders how the incremental initiative will expand into something remarkable over time.

Sometimes this isn't just a stakeholder problem: it can feel slow to *you* as well. In those moments, Larson tries to remember that **friction isn't velocity**: driving down the highway with windows down feels faster, but is actually slower — and the same holds true in software engineering. Example: Digg's engineering strategy when Larson joined had an extremely clear and consistent architecture (a PHP frontend, Python services, Cassandra for all storage), but the company still collapsed around them. The takeaway: a few strategies that *work* are more valuable than a bunch of strategies — even good ones — in a burning building.

## Strategy Altitude

Sometimes you do want to lay out a broad, comprehensive strategy, and you want to do it quickly. That violates the general rule of developing one strategy at a time, but one helpful idea can often make it possible: **strategy altitude**.

The idea is easiest to explain through examples of operating at different altitudes (the chapter's Figure 4-1, captioned "Example strategies at different strategy altitudes," depicts these four examples):

**A permissive strategy at the engineering organization altitude**
: A developer experience team wants to increase code quality. They create a mechanism that allows teams to define linting rules for their own builds. The developer experience team creates opinionated defaults for teams to adopt, but each team is empowered to override those defaults locally.

**A prescriptive strategy at the engineering organization altitude**
: A CTO wants to increase code quality. They mandate that every pull request must include a test, and that continuous integration/continuous delivery (CI/CD) should block merging pull requests that reduce code coverage.

**A permissive strategy at the team altitude**
: A product engineering team wants to decrease security vulnerabilities in its software. They tell engineers that it's important to consider a number of security issues when implementing software, and include resources for engineers to educate themselves.

**A prescriptive strategy at the team altitude**
: A product engineering team wants to reduce user-impacting bugs. They decide that their planning sprints will schedule bug fixes first, and only schedule features after draining the bug backlog.

The cost model behind these dimensions:

- **Permissive strategies are less expensive than prescriptive strategies** because they require little to no enforcement.
- **Lower-altitude strategies (such as team strategies) are less expensive than higher-altitude strategies (like org or company strategies)** because they can rely on local mechanisms for rollout and maintenance. Mechanisms for wider communication are often oversaturated and lossy: for instance, communicating in engineering-wide chat channels is, at best, ineffective.

Pulling these ideas together, **the formula to increase strategy volume is to either reduce altitude, increase permissiveness, or both**.

Concrete example — Carta: when Larson joined Carta, he worked across engineering to roll out quite a bit of strategy work in the first six months. Some of this was documenting *existing* strategy, so that adopting it didn't require much overhead. Other parts were shifts in approach, so the focus was on developing permissive strategies. Every strategy included an escalation path to support local customization — generally asking each team's **Navigator** (a Staff-plus engineer responsible for that area) to override the strategy as appropriate. There was only one place where Larson was highly prescriptive: provisioning new services. There, the escape hatch was more restrictive, requiring escalation to the CTO.

Because the focus was on permissive strategies, the rollout was able to cover a broad range of topics at high altitude. Had Larson been more prescriptive, the approach "would have certainly failed," even though he might have looked like a more courageous leader. "Annoyingly, looking effective and being effective tend to be only lightly correlated."

## Are You Doing Too Much?

Although many engineers feel that their company doesn't have a clear engineering strategy, in Larson's experience **significantly more leaders fail by attempting too much strategy work than too little**.

To debug whether you're doing too much, the most valuable question you can ask is: **has your prior strategy work affected subsequent decisions?**

If you've shared out a bunch of strategy work but it doesn't seem to be changing how your software is written, scale back. The recovery sequence is strictly ordered:

1. Focus on getting just a single strategy working well, and deeply understand what has gone wrong in your prior efforts.
2. Then, and only then, return to that prior work and fix it.
3. Finally, and only after completing the prior steps, expand further.

You may be doing good work but simply overwhelming the organization with too much of it. Adopting new approaches is hard, and changing everything at once is overwhelming. Two adjustments: adjust your strategy altitude to make your strategies easier to adopt, and slow down on adding more until the existing strategies have been fully adopted.

## Summary

After reading this chapter, you know when it's effective to write strategy, and how to pace yourself to write a reasonable volume of strategies. You can use strategy altitude to make strategies easier to adopt, and can debug whether you're overwhelming your organization with too much strategy work.

The closing rule — the one thing to take away if nothing else: **try to always be working on exactly one strategy**. Doing more feels like progress, but usually fails. Doing less is always a missed opportunity.
