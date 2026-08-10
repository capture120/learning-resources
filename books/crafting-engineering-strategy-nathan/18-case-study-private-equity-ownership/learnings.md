# Chapter 18: Private Equity Ownership Strategy

This chapter is a case study of an engineering organization ("Fungible Ecommerce Company") preparing for new private equity ownership before receiving concrete cost targets. It pairs a strategy document (Document 18-1) with a systems model of engineering seniority mix (Document 18-2). The single most important takeaway: when you lack clear goals from above, do not stall — use the waiting period to validate options, commit to the no-regret moves you can already justify (like N-1 backfill and senior-level caps), and explicitly defer the decisions that depend on missing information. "Sometimes the only path forward is preparation, and then all you can do is prepare."

## Core ideas

### What private equity ownership expects

A trademark of private equity ownership is a binary expectation: either the company maintains its current margin and grows revenue at 25%–30%, or it grows more slowly and increases free cash flow year over year. In many organizations, engineering costs are a major lever on free cash flow. Cloud hosting and similar costs can be cut, but the discussion inevitably reaches engineering headcount costs directly. This is why an engineering leadership team should model headcount-cost policies *before* being told to cut.

### Seniority mix is the hidden driver of headcount cost

One of the largest contributors to engineering headcount cost is the organization's seniority mix: senior engineers are paid substantially more than earlier-career engineers. Headcount cost can grow much faster than headcount itself. In the case study, headcount grew 7%–9% while headcount *costs* grew 15%–18%; the gap decomposed into salary band adjustments (4%), a focus on hiring senior roles (3%), and hiring in higher-cost geographies (1%). The why: if you only track headcount, costs drift upward invisibly through level and geography mix.

### Organizations naturally become top-heavy

Modeled as stocks and flows, an organization that backfills departures at the same level (an SWE2 replaced by an SWE2) becomes increasingly top-heavy over time — an exponential growth problem at the most senior level. The mechanism: promotions continuously push people upward, while at-level backfill never pushes anyone downward. The intuition "we needed an SWE2 before, so hire an SWE2" feels right and is structurally wrong.

### Only a combination of strong policies fixes seniority mix

The model's central learning, established across iterations:

1. **N-1 backfill alone is insufficient.** Backfilling each departure one level below the departed employee converts the exponential top-heavy growth into linear growth — better, but the senior share still rises too high and the organization stays expensive.
2. **N-1 backfill plus a hiring freeze is still insufficient.** Even with zero external hiring, the ratio lands around 1.25 SWE1s per SWE4 when a healthy ratio is closer to five to one.
3. **The full fix requires three policies together:** stop hiring at the most senior levels, backfill at N-1, and cap the maximum number of people at the most senior level.

The author's blunt conclusion: "Any collection of lower-powered policies simply will not impact the model's outcome." The why: promotion flows compound; only hard caps and downward backfill pressure counteract them.

### The promotion-rate inequality

From reasoning about the sketched system: if promotion rates at any level exceed the rate of hiring at that level plus the rate of N-1 backfill at that level, the proportion of engineers at that level grows over time. When hiring is low, this simplifies to promotion rate versus departure rate. Consequence: a company that does little hiring and has high retention cannot afford to promote frequently. Promotions into senior roles become financially constrained even if the stated policy explains it some other way.

### "Career level" policies are usually financial constraints in disguise

Many companies designate a "career level" — a level where promotions generally stop happening. The rationale is rarely stated explicitly, but the model implies it is likely a financial constraint that incentivizes the policy. Understanding this lets you see seemingly cultural ladder policies as cost-structure mechanisms.

### Markets judge engineering spend by peer comparison

Financial markets evaluate companies relative to peers. Private equity firms value businesses the same way public markets do, even though they generally take controlling interests in private companies. Most investors judge engineering through total R&D spend, typically via a scatterplot of R&D spend versus year-over-year revenue growth for a cohort of comparable companies (similar industry, similar revenue, same regions). You can anticipate ownership pressure by plotting yourself into that chart before they do: the chapter's dataset shows a clear "strong performer" quadrant in the top-left to plot yourself against.

### Cost-line growth rates predict where cuts will land

The Zendesk exploration shows the pattern: after a private equity acquisition, the cost lines growing faster than revenue attract reductions. R&D growing ~50% faster than revenue and G&A growing more than twice as fast as revenue preceded two rounds of reductions (November 2022, then May 2023); precise data is hard to get, but the author's impression is that the reductions focused on areas where expenses were growing quickly, with particular focus on G&A. The diagnostic heuristic: compare each expense line's growth rate to revenue growth; lines outpacing revenue are the exposed ones.

### Making progress despite imperfect information

The chapter's summary theme: interesting strategy documents find a way to make progress without clear, stable plans and goals, because those rarely exist. The strategy explicitly declines to run a reduction-planning process before targets arrive ("to avoid running two overlapping processes"), while still committing immediately to policies it can defend independently. It also explicitly records where alignment failed (geographic hiring) rather than pretending to a commitment it cannot keep.

### Honest diagnosis includes what you cannot measure

The diagnosis admits: there is likely an opportunity to cut R&D maintenance spend (especially narrow geo-expansion features), but the team lacks believable metrics on time spent maintaining the software and time saved by cleanup. Without those metrics, projects cannot be pitched as revenue-saving "with much conviction." The strategic response is not to guess but to spin up a working group to identify features with the highest support load — converting an unmeasurable claim into a data-gathering step.

### Modeling methodology: sketch, reason, then model and exercise

Document 18-2 demonstrates the systems-modeling workflow. Sketch first in a simple tool — simple sketching tools keep you focused on iterating stocks and flows rather than tuning settings, like a designer starting with messy wireframes. Derive qualitative conclusions from the sketch before building the executable model. Then model iteratively: each model version produces learnings that prompt new questions requiring the next version (the chapter deliberately combines Model and Exercise to show this loop). Stop adding levels or refinements when the model becomes burdensome relative to additional insight — the author stops at four levels and ends modeling once the key lessons are extracted, while noting remaining artifacts (an SWE3 surplus from promotion backpressure) as future policy work.

## Actionable guidance

- When new ownership is coming but targets are unknown, state explicitly that you will revise policy once targets arrive, and delay reduction planning until then to avoid running two overlapping processes.
- Benchmark yourself the way investors will: build a scatterplot of R&D spend versus revenue growth for a peer cohort (similar industry, revenue, region) and locate yourself on it. Use a rough public dataset (e.g., the R&D Investment Scoreboard) as a starting point; upgrade to SEC EDGAR data if you repeat the exercise.
- Study a public precedent of your scenario (e.g., Zendesk's 2022 take-private): pull the last 10-Q, reformat the P&L into year-over-year changes by cost line, and assume cuts will target lines growing faster than revenue.
- Decompose headcount-cost growth into its drivers (raw headcount, band adjustments, seniority mix of hires, geography mix) so you know which levers actually move cost.
- To control seniority mix, implement all three policies together: backfill departures at N-1 (except the most junior level, which backfills at-level), stop external hiring into the most senior levels, and hard-cap the count at the most senior level (e.g., one Principal Engineer per business unit, written CTO approval for exceptions, applying to both promotions and external hires).
- Apply the promotion-rate test: if promotion rates at a level exceed hiring at that level plus N-1 backfill at that level, that level's share will grow. In low-hiring, high-retention orgs, ratio-check promotion rate against departure rate before approving promotion budgets.
- Commit to quantified targets where you have a model (e.g., reduce headcount costs ~5% year over year; cap infrastructure spend growth at 5% YoY against 25% YoY revenue growth; a one-time 3% infrastructure reduction from consolidating acquired companies onto shared infrastructure).
- Where you cannot reach cross-functional agreement (e.g., geographic hiring strategy), say so in the strategy, note the potential size of the prize (10%–20% over two to three years), and refuse to commit to outcomes you cannot deliver.
- Where you suspect savings but lack believable metrics, kick off a working group to gather the data (e.g., identify features with the highest support load) instead of committing to unverifiable savings.
- When systems modeling: sketch stocks and flows in a simple tool first; verify the coded model matches the sketch (e.g., render via Graphviz) before trusting its output; use information links (a stock's size as a shared variable, like `HiringRate`) for easy iteration; use infinite stocks (`[Candidates]`) for effectively unlimited pools and capped stocks (`SWE4(10, 20)`) for hard limits; iterate model → learning → new question → next model; stop when added complexity outweighs added insight.

## Pitfalls and misconceptions

- **Backfill-at-level feels logical and is a trap.** "You needed an SWE2 before, so why hire someone less senior?" — this intuition produces unbounded top-heaviness.
- **Single policies don't work.** N-1 backfill alone, or even N-1 plus a hiring freeze, still leaves the senior ratio far too high. Collections of weak policies will not change the outcome; only the combined strong policies do.
- **Tracking headcount instead of headcount cost** hides 8–9 points of annual cost growth coming from levels, bands, and geography.
- **Running reduction planning before targets exist** creates two overlapping processes and wasted work.
- **Committing cross-functionally unagreed savings** (the geographic hiring case) overpromises; the details matter too much to commit before alignment.
- **Pitching maintenance-reduction projects without believable metrics** undermines conviction; gather data first.
- **Assuming "career level" caps are purely cultural** misses that they are typically financially incentivized constraints.
- **Expecting clear goals before acting.** Work is easy with clear, stable plans, but those rarely exist; waiting for them instead of preparing is the failure mode this strategy avoids.
