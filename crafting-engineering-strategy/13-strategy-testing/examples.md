# Chapter 13: Strategy Testing for Iterative Refinement — Examples

## Origin at Carta Engineering

Larson notes that many of the chapter's ideas came together while he was working with Shawna Martell, Dan Fike, Madhuri Sarma, and others in Carta Engineering. Those ideas reflect lived practice rather than pure theory.
Illustrates: many of the chapter's ideas came together inside a real engineering organization.

## Testing an acquisition integration with one API

When integrating a recently acquired company, rather than finalizing the overall integration approach up front, test by getting a single API integration working first. That one narrow slice exercises the real mechanics of the approach before you commit to the broad plan.
Illustrates: testing narrowly and early on the underlying mechanics before finalizing strategy.

## Typing one Python module before mandating types

For a developer productivity strategy requiring type annotations across a Python codebase, start by having an experienced team member add types to one important module. This surfaces the approach's real mechanics and costs at small scale, before any mandate.
Illustrates: choosing the narrowest, deepest slice as the test vehicle.

## Migrating one simple and one complex component

For a service migration, attempt to migrate exactly two components before any broader rollout: one simple component to test the migration tooling, and one highly complex component to test integration complexity. The pair covers both ends of the difficulty spectrum cheaply.
Illustrates: designing a minimal test set that exercises distinct failure modes of the strategy.

## Permissive strategies as free tests

A highly permissive strategy that is very cheap to apply often doesn't need its own test. In fact, rolling it out permissively *is* the test: how it fares tells you whether a similar but less permissive (more mandated) version would be effective later.
Illustrates: a legitimate exemption from testing, and reuse of permissive rollouts as test data.

## Regional hiring strategy: untestable in practice

A hiring strategy that shifts hiring into certain geographic regions usually can't be tested. You might need to run it for several years before getting any meaningful signal on results, so the feedback loop is too long for a testing phase to work.
Illustrates: the "testing isn't viable" exemption — some strategies only yield meaningful signal after running for years.

## One important release through the new process

To test a new release strategy for a Product Engineering organization, run exactly one important release following the new approach, then iterate. Pair it with impact metrics — does the new process reduce customer impact, or drive more top-of-funnel visitors? — rather than adoption counts.
Illustrates: the narrow-slice method plus impact metrics (not adoption metrics) for verifying a test.

## Unused release tooling: assume complexity, not resistance

If people aren't using new release tooling during testing, assume the tooling is too complex — definitely don't assume people are resistant to change. The good-intent assumption keeps you debugging the excess friction and ergonomics that make adoption difficult.
Illustrates: operating from the belief that strategy failures are most likely due to friction, not bad actors.

## Auth standardization that "sounds right" but fails

Fully standardizing authorization and authentication on one implementation across a company sounds obviously right — yet it can still fail, for example if each team is left responsible for its own approach to determining what the standard is. The direction was fine; the missing concrete detail (who decides the standard) sank it.
Illustrates: strategies that skip testing "sound right, but don't accomplish much"; details determine outcomes.

## The Amazon migration myth and "pressure without a plan"

Service migrations are especially prone to the "pressure without a plan" pattern — a strategy that sounds right but lacks concrete details — perhaps because of apocryphal retellings of Amazon's 2000s service migration as a top-down, zero-details mandate to leave the monolith.
Illustrates: the signature anti-pattern of untested strategies and how folklore propagates it.

## Real traffic versus commitment spreadsheets

To check whether an authentication-service migration is actually working, track API requests to the new authentication service as a percentage of all authentication requests. That is more meaningful than a spreadsheet recording whether each team has formally committed to moving. Commitments are a proxy; traffic is the actual thing that matters.
Illustrates: avoiding proxy metrics when identifying whether a strategy is driving impact.

## A "slow" team that is genuinely progressing

A team supporting adoption of a new authentication service might look slow while it designs an approach for migrating existing services to fit the new service's design. The impact numbers aren't moving yet, but the team is still making progress as long as it's uncovering a path forward. Generally, the best validating evidence is new software running in a meaningful environment (production, for product code).
Illustrates: how to judge progress when metrics are flat — debugging mechanism plus concrete artifacts, not just numbers.

## Skeptics: right about the past, not the present

When validating a struggling strategy, it's useful to talk with skeptics and veterans of failed integrations — but be cautious of debugging exclusively with them. They're almost always right, yet often aren't describing current problems.
Illustrates: weighting qualitative evidence sources during strategy debugging.

## Stuck monolith migrations at Calm and Carta

The strategy document "Should We Decompose Our Monolith?" (Document 20-1 in the book) addresses recovering from a failing service migration, and is lightly based on Larson's experience with similarly stuck service migrations at both Calm and Carta. The prescribed recovery: write a new strategy and run the testing phase that the original skipped.
Illustrates: real-world recovery from a strategy that progressed too far without testing.

## Pausing implicitly via a provisioning investment

When officially pausing a struggling migration is difficult, use an indirect mechanism: delay new services while taking a month to invest in improving service provisioning. That might give you enough breathing room to test the strategy's missing mechanisms without anyone losing face over a failing migration.
Illustrates: implicit pauses as a face-saving tool when explicit pauses would trigger stakeholder backlash.
