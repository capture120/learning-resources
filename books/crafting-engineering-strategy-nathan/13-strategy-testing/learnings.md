# Chapter 13: Strategy Testing for Iterative Refinement

This chapter explains how to test an engineering strategy before committing to it: validate the narrowest, deepest slice of the approach in practice, iterate on its mechanics with weekly debugging meetings and impact metrics, and only then roll out broadly. The single most important takeaway is Larson's core claim about technical strategy: **prematurely rolling out a strategy prevents you from evaluating whether the strategy is effective.** Pressure changes people's behavior — they comply in appearance while preserving the status quo (if you're an executive) or work to get the strategy repealed (if you're not) — so a strategy pushed before testing never produces honest signal about whether it actually works.

## Core ideas

### Definition: what strategy testing is

Strategy testing is "ensuring that a strategy will accomplish its intended goal at a cost that you're willing to pay." It must happen **before** the strategy is finalized and implemented — usually in its early development stages. Testing does not determine whether a strategy *might* be good; it "exposes the missing details required to translate a directionally accurate strategy into a strategy that works."

### Why testing matters: the waterfall strategy trap

Some strategies are obviously wrong from the start, but it is far more common for *reasonable* strategies to fail because they got small details wrong. Premature pressure is one symptom of a general phenomenon: most strategies are developed in a waterfall model, finalizing the approach before incorporating the lessons that reality teaches when you attempt the strategy in practice. Explicit testing is the way out of this trap — and testing is "so, so much cheaper than implementing a bad strategy that it's almost always a good investment."

### Test narrowly and early

The two essential properties of a good test:

1. **Test before finalizing the strategy.**
2. **Test narrowly**, focusing on the underlying mechanics of the approach — not broad problems like motivating adoption or resolving conflicting incentives.

The method: identify the *narrowest, deepest available slice* of the strategy, and iterate on applying the strategy to that slice until you're confident the approach works (e.g., run exactly one important release through a proposed new release process).

### When testing is legitimately skippable

Not every strategy needs testing. Three cases:

- **Highly permissive, cheap-to-apply strategies** (see Chapter 4). In fact, a highly permissive strategy can itself serve as a test of whether a less permissive version would work later.
- **Testing isn't viable** — e.g., a hiring strategy shifting hiring into certain regions may need years of operation before producing meaningful signal.
- **Very high conviction**, e.g., you've already done something nearly identical at the same company. Larson is generally skeptical of this category: "hubris comes before the fall."

The strong default: try very hard to find a way to test every strategy, and do *not* try hard to convince yourself testing isn't worthwhile.

### Measure impact, not adoption

As you iterate, identify metrics that verify the approach is working. These must measure **the impact of the change, not adoption** — e.g., metrics showing a new release process reduces customer impact, not a count of teams using it. Avoid proxy metrics; "look at the actual thing that matters." (Example: the percentage of authentication API requests hitting the new service is meaningful; a spreadsheet of teams that formally committed to migrating is not.)

### Assume good intent; diagnose friction

Operate from the belief that people mean well, and that strategy failures are most likely due to excess friction and poor ergonomics that make adoption difficult. If people aren't using your tooling, assume it's too complex — never assume they're just resistant to change.

### When to stop testing

Keep refining until you're *positive* the strategy's details work in practice — or positive they don't, in which case you need to approach the strategy from a new direction. Both outcomes are wins: strategy testing is only valuable because many strategies don't work as intended, and learning that early is much cheaper than learning it after rollout.

### Roles: sponsor and guide

Testing is sometimes led by one person, but more commonly split into two roles:

**The sponsor** provides organizational authority (an executive, or at a smaller company a principal engineer). Responsibilities:
- Make quick decisions to avoid getting stuck in development stages
- Push past historical decisions and old beliefs that block meaningful testing
- Marshal support across the organization
- Storytell to stakeholders (especially the executive team) to keep funding flowing
- Prevent people from overloading the strategy to solve their semirelated problems
- Set the pace to avoid stalling out
- Notice when energy is dropping
- Identify when to move to the next phase (e.g., development → implementation)

**The guide** coordinates the day-to-day work of validating the approach (an engineering manager, a technical program manager, or at a larger company a principal engineer). Responsibilities:
- Translate the strategy into particulars, especially when testing gets stuck
- Identify and address slowdowns and blockers
- Escalate to the sponsor as frequently as needed
- Track goals and workstreams
- Maintain the pace set by the sponsor

**What makes each role good or bad.** A sponsor is only meaningful to the extent that they are genuinely authorized by the company to make their decisions, care enough to make difficult decisions quickly, and are available to rapidly resolve escalations — an unavailable or slow-resolving sponsor is a poor sponsor. A guide must execute at the sponsor's pace without being derailed by organizational messes, and must have good, nuanced judgment about the strategy domain. The worst guides are **ideological** (they reject the results of testing) or **easily derailed** — you're likely testing because there's friction somewhere, so someone who can't navigate friction fails by default.

### The weekly testing meeting

The only absolute requirement of the testing phase: the sponsor, guide, and other key people **must meet every single week**. In that meeting you iterate on which metrics capture the areas being refined, discuss what prior metrics and data taught you, and schedule one-off follow-ups to keep progress moving. The best version of this meeting is "heavy on debugging and light on presentation."

A built-in health check: be suspicious of any week where you didn't learn something that informs subsequent testing or make a decision that modifies your testing approach. A learning-free week may mean the effort is underresourced or the testing approach is too ambitious — either way, it's a meaningful signal that testing isn't showing enough promise to maintain attention.

If weekly meetings feel like too large a commitment, that's a signal about strategy altitude: adjust the volume or permissiveness of the strategy. A strategy not worth testing is either already obviously good or only worth rolling out in a highly permissive format.

### Identifying untested strategies

While not all strategies require testing, **essentially all failing strategies skipped the testing phase** and moved directly into implementation. Strategies that skip testing "sound right, but don't accomplish much."

A telltale pattern is **"pressure without a plan"**: a strategy that sounds right but lacks concrete details. Service migrations are especially prone to this, perhaps due to apocryphal retellings of Amazon's 2000s service migration as a top-down, zero-details mandate to leave the monolith.

To identify whether a strategy was tested, ask two questions:

1. **Are there numbers showing the strategy is driving the desired impact?** Real impact numbers, not proxies (actual traffic to the new system, not commitment spreadsheets).
2. **If the numbers aren't moving, is there a clear mechanism for debugging and solving those issues — and is the team actually making progress?** A team can legitimately look slow while uncovering a path forward (e.g., designing the migration approach for existing services); that still counts as progress.

When numbers aren't moving, find a different source of meaningful evidence that progress is real. The best evidence is **new software running in a meaningful environment** (for product code, production). Talking with skeptics and veterans of failed integrations is useful, but don't debug exclusively with skeptics: "they're almost always right, but often aren't describing *current* problems."

Unless the answer to one of these questions is obviously yes, you've very likely found an untested strategy.

### Recovering from skipped testing

When a strategy skipped testing and is now struggling, **the answer is always to write a new strategy — and don't skip testing this time.** Typically that means explicitly pausing the struggling strategy while you run a new testing phase. This is painful because people invested in the current strategy will be upset, but some people will disagree with any change; in the long term, the only thing that makes most people happy is a successful strategy, and anything delaying that is a poor investment.

When you can't pause officially, find an **indirect mechanism to pause implicitly** — e.g., delay new services while spending a month improving service provisioning, buying room to test the strategy's missing mechanisms without anyone losing face over a failing migration. Managing personalities is an enduring leadership challenge; even executives just have a different set of messy stakeholders.

## Actionable guidance

- Test before you finalize the strategy, during early development — never after rollout pressure has started.
- Pick the narrowest, deepest available slice of the strategy and iterate on that slice until you're confident the mechanics work (e.g., one real release, one typed module, one simple plus one complex component migrated).
- Choose test slices that exercise the *mechanics* of the approach; explicitly defer broad problems like adoption motivation and conflicting incentives.
- Define metrics that measure impact, not adoption, and not proxies. Measure the actual thing that matters.
- When adoption lags during testing, treat it as a friction/ergonomics bug in your approach and fix the mechanics; do not attribute it to resistance to change.
- Keep refining until you're positive the details work — or positive they don't, then restart from a new direction rather than pushing forward.
- Staff two roles: a sponsor with real, company-granted authority who resolves escalations fast, and a guide with nuanced domain judgment who executes at pace through organizational friction.
- Reject sponsors who are unavailable or slow to resolve escalations; reject guides who are ideological about outcomes or easily derailed.
- Hold a mandatory weekly meeting of sponsor, guide, and key contributors. Run it as debugging, not presentation: iterate on metrics, discuss what the data taught you, schedule follow-ups.
- Audit each week: did we learn something that informs the next test, or decide something that changes our testing approach? If not, investigate underresourcing or overambition.
- If testing feels too heavy for the strategy, lower the strategy's altitude: reduce its volume or make it more permissive instead.
- To audit any in-flight strategy: (1) check for impact numbers actually moving; (2) if not, check for a working debugging mechanism and real progress. If neither is obviously yes, treat it as untested.
- Validate stalled-but-progressing efforts with new software running in a meaningful environment (production for product code).
- Interview skeptics and veterans of failed attempts, but cross-check their input — their complaints often describe past problems, not current ones.
- To rescue a strategy that skipped testing: write a new strategy, pause the old one (explicitly if possible, implicitly via an indirect mechanism if not), and run the testing phase you skipped.

## Pitfalls and misconceptions

- **Premature rollout destroys your signal.** Once pressure is applied, people optimize for appearing compliant or for getting the strategy repealed; you can no longer tell whether the strategy works.
- **Waterfall strategy development.** Finalizing the approach before reality has taught you anything is the root failure mode this chapter exists to prevent.
- **Going broad where impact feels higher but iteration cycles are slower.** Stay narrow.
- **Forcing adoption during testing.** Energy spent compelling people to adopt is energy diverted from improving the underlying mechanics.
- **Attachment to your current approach.** If you can't accept that the strategy might not be working, testing produces no value — its whole point is cheap early disproof.
- **Talking yourself out of testing.** High-conviction "we've done this before" exemptions are usually hubris.
- **Adoption and proxy metrics.** Commitment spreadsheets can be green while the strategy accomplishes nothing.
- **"Pressure without a plan."** A directionally right-sounding mandate with no concrete details (the caricatured Amazon-style migration decree) is the signature of an untested strategy.
- **Strategies that "sound right."** Sounding right is not evidence; e.g., standardizing on one auth implementation sounds right but fails if each team independently decides what the standard is.
- **Debugging exclusively with skeptics.** Their criticisms are almost always valid but frequently stale.
- **Refusing to pause a failing strategy to avoid upsetting its backers.** Someone will always be upset by change; only a successful strategy ultimately satisfies most people, so anything delaying it is a poor investment.
