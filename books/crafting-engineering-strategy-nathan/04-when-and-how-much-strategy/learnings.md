# Chapter 4: When Should You Write Strategy—and How Much?

This chapter answers two timing-and-dosage questions: when is the right moment to start writing engineering strategy, and how much strategy can your organization actually absorb? Larson argues that both extremes fail — writing nothing when the organization is fragmenting, and writing so much that the organization ignores it. The single most important takeaway: **always be working on exactly one strategy.** Doing more feels like progress but usually fails; doing less is always a missed opportunity.

## Core ideas

### Writing nothing is often the best available choice

Strategy work isn't always the most valuable use of your time. The common slur that a leader "wants to be strategic" carries a real truth: focusing on abstract ideas can be a way of avoiding the concrete needs of today. Working on strategy can be "snacking" — a way to avoid doing something more important. Before starting, you must decide whether now is the correct time, which depends on three criteria:

1. Your organization's **current strategic state**
2. The **trend** of that strategic state over time
3. Whether you have **enough context** to be effective

### Current strategic state (three states)

Using service architecture as the example domain, an engineering organization is in one of three strategy states:

- **Globally consistent** — there is a clearly agreed-upon strategy, *even if it's not written down*. Asking different team members how to approach a problem yields similar answers (e.g., everyone agrees new product functionality goes in the existing monolith).
- **Consistent within teams** — clear strategy within pockets of the organization, but inconsistency across pockets (e.g., product engineering wants new services in a shared monorepo; platform engineering wants everything in the monolith).
- **Highly varied** — little agreement across individuals; some want new services in a monorepo, others polyrepos, others the monolith.

Decision rule: if globally consistent, more strategy work is unlikely to be useful — *unless the organization is consistently deciding on undesirable approaches*. In either of the other two states, it's likely a useful time to write strategy.

Why this matters: where agreement already exists, doing more strategy work is unlikely to be useful. Note the key insight that strategy can exist and function without being written down.

### Trends in strategic state

Even a good current state warrants strategy work if it's trending worse. Conversely, a decent state trending better is likely not a valuable opportunity. Recurring causes of abrupt, sometimes unexpected, shifts in state — each a signal to consider writing strategy:

- **Hiring rate (or lack of it).** Rapid growth means most engineers are recent hires, driving inconsistency up. (Uber doubled engineering headcount every six months for four years and opened distributed offices, producing highly varied approaches.)
- **Whether newly hired external leaders are playbook-driven or context-responsive.** Many leaders, desperate for early impact, skip diagnosing their new environment before making sweeping changes. This creates a strategy rift between teams aligned with the new direction and teams maintaining existing software and infrastructure.
- **Frequency of significant organizational changes.** Reorganizations and layoffs break the mechanisms that propagate organizational culture — subtle glue work that spreadsheet-driven exercises ignore.
- **How effectively historical decisions are documented and communicated.** Some companies drill new hires on how decisions are made; others leave training to local teams. Both can work well, and both can work poorly — the variable is effectiveness, not the mechanism.

### Your context level

Even with a poor and worsening state, you must understand the organization well enough to do useful strategy work. Test yourself with two questions: Do you understand the history around the areas you want to change? Do you understand the individuals who made the decisions, and the context that made them good decisions at the time? If yes, you're ready. If not, slow down and build the relationships and context first.

The warning: new leaders who jump in, make untested assumptions, and attempt a massive migration or grand sweeping gesture may feel they're driving strategy audaciously, but it's "mostly just anxiety and ego wrapped in a Gantt chart."

Combined rule: if things could be better or are trending down, *and* you know enough about the company to get started, it's time to work on strategy.

### How much strategy to write: limit work in progress

The potential strategies you could write are genuinely infinite, so the most valuable decision is to **limit the strategy work in progress at any given time, even if it means starting smaller than you want.** Start with small pieces of strategy, iterate until they work, and only then move to something larger. Limit yourself to one or two strategies at a time. The why: this preserves the bandwidth to ensure your strategies actually work, rather than producing volume that nobody adopts.

### A clear but lightly held destination

To stay effective while limiting concurrent strategy work, hold a clear — but lightly held — point of view about where you want to get over time. This clarity lets you align small chunks toward the same destination so they build into something larger, while remaining flexible enough to adjust as each step teaches you more about the path. (Uber example: the long-term goal was leaving the monolith; the first strategy was only about making service provisioning painless, a prerequisite step.)

Sequencing benefit: narrowing focus lets you iterate on prerequisites and *delay building consensus until there's a concrete step you need people to take*. By then there's no intellectual debate about whether it's possible, because most people are already operating as intended. Starting with the broad strategy instead would have triggered abstract debate and required many teams to buy into a future vision with no concrete step to take.

### Effective strategy looks unambitious

Reducing concurrent strategy volume appears conservative — even like you've "lost the plot." This is a recurring challenge: **effective strategy development can appear overly conservative.** The fix is to pair focused execution with broader, proactive storytelling to stakeholders, explaining how the incremental initiative expands into something remarkable over time. The team's execution stays narrow; the narrative carries the ambition.

It can feel slow to you too, not just stakeholders. The mantra: **friction isn't velocity.** Driving down the highway with the windows down feels faster but is actually slower; the same holds in software engineering. A few strategies that work are more valuable than many strategies — even good ones — in a burning building (Digg had an extremely clear, consistent architecture and still collapsed; clear strategy alone doesn't save a failing company).

### Strategy altitude

Sometimes you genuinely need broad, comprehensive strategy quickly, violating the one-at-a-time rule. **Strategy altitude** can often make this possible. Every strategy varies along two dimensions:

- **Permissiveness**: permissive (defaults, guidance, education, opt-outs) vs. prescriptive (mandates, enforcement, blocking mechanisms).
- **Altitude**: where it's implemented — team level (low) vs. engineering organization or company level (high).

The four combinations, with examples:

- *Permissive, org altitude*: a developer experience team builds a mechanism letting teams define their own linting rules, ships opinionated defaults, and lets each team override locally.
- *Prescriptive, org altitude*: a CTO mandates every pull request includes a test, with CI/CD blocking merges that reduce code coverage.
- *Permissive, team altitude*: a product team tells engineers to consider security issues when implementing software and provides educational resources.
- *Prescriptive, team altitude*: a product team schedules bug fixes first in sprint planning, only scheduling features after the bug backlog is drained.

Cost model: **permissive strategies are cheaper than prescriptive ones** because they require little to no enforcement. **Lower-altitude strategies are cheaper than higher-altitude ones** because they rely on local mechanisms for rollout and maintenance, whereas wide-communication channels are often oversaturated and lossy (engineering-wide chat channels are, at best, ineffective).

**The formula to increase strategy volume: reduce altitude, increase permissiveness, or both.**

### Looking effective vs. being effective

At Carta, Larson rolled out broad strategy in six months by keeping nearly everything permissive, with escalation paths (team Navigators — Staff-plus engineers — could override). He was highly prescriptive in only one place: provisioning new services, where the escape hatch required CTO escalation. Being more prescriptive across the board "would have certainly failed, even though I might have looked like a more courageous leader. Annoyingly, looking effective and being effective tend to be only lightly correlated."

### Debugging: are you doing too much?

Although many engineers feel their company lacks a clear engineering strategy, Larson's experience is that **significantly more leaders fail by attempting too much strategy work than too little.** The single most valuable debugging question: **has your prior strategy work affected subsequent decisions?** If you've shared lots of strategy but it isn't changing how software is written, the strategy isn't working — scale back.

## Actionable guidance

**Deciding when to write strategy:**
- Assess your current strategic state: ask different people how they'd approach the same problem. Similar answers mean globally consistent; pocket-level agreement means consistent within teams; no agreement means highly varied.
- Skip strategy work when the organization is globally consistent — unless it's consistently choosing bad approaches.
- Watch the trend, not just the state. Start strategy work when a good state is trending worse; hold off when a decent state is improving on its own.
- Treat these as triggers to consider writing strategy: rapid hiring, playbook-driven new executives, reorganizations or layoffs, and weak documentation of historical decisions.
- Before starting, verify your context: can you explain the history of the area, who made the key decisions, and why those decisions were good at the time? If not, build relationships and context first.
- Accept that writing nothing is often the correct choice. Don't use strategy work to avoid more important, concrete work.

**Pacing strategy volume:**
- Work on exactly one strategy; two at most. Limit work in progress even if it means starting smaller than you want.
- Start small, iterate until the strategy demonstrably works, then move to something larger.
- Hold a clear but lightly held long-term destination so small strategies compound toward it, and revise the destination as each step teaches you more.
- Sequence strategies so each delivers a concrete prerequisite for the next. Delay consensus-building until there's a concrete step you need people to take.
- Pair focused execution with proactive stakeholder storytelling: explain how the small initiative expands into something larger over time, so narrow focus doesn't read as lost ambition.
- When progress feels slow, remember friction isn't velocity.

**Using strategy altitude:**
- To cover many topics quickly, reduce altitude, increase permissiveness, or both.
- Make permissive strategies the default: ship opinionated defaults with local override rights rather than mandates.
- Build an explicit escalation path into every strategy (e.g., a designated senior engineer per team who can override it).
- Reserve prescriptive, hard-to-escape strategies for the few places they're truly essential, and make the escape hatch deliberately costly there (e.g., requires CTO escalation).
- Cheaply absorb existing alignment by documenting strategies the organization already follows — adopting them doesn't require much overhead.

**Debugging too much vs. too little:**
- Regularly ask: did prior strategy work change subsequent decisions? If not, stop adding strategies.
- Recovery sequence when overwhelmed: (1) scale back to a single strategy and get it working well, (2) deeply understand what went wrong in prior efforts, (3) only then return and fix the prior work, (4) only after that, expand further.
- If adoption is lagging, lower the altitude or increase permissiveness of existing strategies before adding new ones, and pause new strategy until existing ones are fully adopted.

## Pitfalls and misconceptions

- **"Wanting to be strategic" as avoidance.** Strategy work can be snacking — abstract effort that dodges the concrete, higher-value work of today.
- **The new-leader sweeping gesture.** Making untested assumptions and launching a massive migration before diagnosing the environment is "anxiety and ego wrapped in a Gantt chart," and a known executive-onboarding antipattern. It creates a rift between teams following the new direction and teams maintaining the existing systems.
- **Mistaking volume for progress.** Writing many strategies at once feels productive but overwhelms the organization; adopting new approaches is hard, and changing everything at once is overwhelming.
- **Mistaking conservatism for lack of ambition.** Focused, incremental strategy looks unambitious from a distance; the fix is storytelling, not broadening scope.
- **Mistaking friction for velocity.** Activity that feels fast can actually be slower — like driving down the highway with the windows down.
- **Optimizing for looking effective.** Being more prescriptive can make a leader look more courageous while the approach fails; looking effective and being effective tend to be only lightly correlated.
- **Believing strategy alone saves you.** Digg had a clear, consistent architecture and still collapsed — strategies that work matter more than strategies that exist, and even good strategy doesn't fix a burning building.
- **Believing too little strategy is the common failure.** In Larson's experience, far more leaders fail from attempting too much strategy work than too little.
