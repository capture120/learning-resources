# Chapter 18: Private Equity Ownership Strategy — Examples

This chapter is itself a worked case study. The examples below capture the concrete strategy documents (composites of real documents from several similar situations across multiple companies) and the model iterations.

## Fungible Ecommerce Company: the scenario

A fictional online-commerce platform, after years under its founders and a brief period as a public company, is acquired by a private equity group. The engineering leadership team has a short runway to change operating models but has not yet received concrete targets from the new owners. Document 18-1 is their attempt to think through options while waiting for guideposts.
Illustrates: the increasingly common situation of engineering leadership preparing for private-equity cost expectations under incomplete information.

## Document 18-1, Policy: the actual commitments

The strategy's operative policies, decided before targets arrived:

- Wait for the explicit R&D operating-expense target expected in upcoming financial-year planning; revise policies then; delay reduction planning until numbers exist to avoid running two overlapping processes.
- Expect moderate pressure to reduce spend (based on peer comparison) and aim to absorb it through policies and one-off infrastructure projects, without a major reduction in headcount spend.
- Effective immediately: an "N-1" backfill policy (departures backfilled one level junior) and a strict maximum of one Principal Engineer per business unit, exceptions only with written CTO approval, applying to both promotions and external hires. Both grounded in the seniority-mix model (Document 18-2).
- Commit to reducing headcount costs roughly 5% year over year for the foreseeable future.
- On geographic hiring: evaluated changes, but staffing engineers alongside cross-functional partners (Product, Marketing, Sales) is a priority, and cross-functional agreement could not be reached, so no change now. A future agreement could yield 10%–20% cost reduction over two to three years, but no commitment until alignment exists.
- Infrastructure: continue the existing efficiency strategy; commit to growing infrastructure spend at most 5% YoY against projected 25% YoY revenue growth; prioritize integrating two prior acquisitions onto the centralized Infrastructure Engineering team's shared stack next quarter; commit to a one-time 3% YoY infrastructure reduction.
- R&D maintenance: believed significant savings exist but without conviction on priorities, so kick off a working group to identify features with the highest support load.

Illustrates: a complete policy section that mixes immediate no-regret commitments, quantified targets, explicit deferrals, and honest non-commitments.

## Document 18-1, Diagnose: the company's numbers

Revenue grew 20%–25% YoY for two years; next year's target is 25% (defensible, not guaranteed — last year came in under 25%). Engineering headcount costs grew 15% and 18% YoY over the last two years while headcount grew only 7% and 9%; the gap was salary band adjustments (4%), senior-heavy hiring (3%), and higher-cost geographies (1%). Based on general practice, the new private equity ownership will likely expect R&D headcount costs to fall through a reduction, but without concrete details no structured decisions are possible — the strategy will depend significantly on the scale of any proposed reductions. Infrastructure spend grew only 4%–5% YoY for three years following a past cost push, leaving few large savings except two acquisition-integration opportunities worth roughly a one-time 1.5% YoY reduction each. Significant R&D spend goes to maintaining old functionality, especially geo-expansion features serving small markets, but the team lacks believable metrics on maintenance time spent or time that cleanup would save, so it cannot pitch such projects as revenue-saving with conviction.
Illustrates: a diagnosis that quantifies cost drivers, names likely ownership expectations, and candidly flags what cannot yet be measured.

## Comparable-companies benchmarking

To anticipate investor judgment, the team built a scatterplot of R&D investment versus growth for a cohort of public technology companies using the 2023 R&D Investment Scoreboard, roughly trimmed of outliers. The dataset was imperfect (it offered operating-profit growth where revenue growth would be preferred), but it exposed a clear strong-performer quadrant in the top-left the company could plot itself into. They asked their investors for the internal datasets used for this analysis and noted that a repeat pass should use the SEC's EDGAR database.
Illustrates: building a directionally useful peer benchmark quickly from public data instead of waiting for perfect data.

## Zendesk's take-private (2022)

To understand what private equity owners do after acquiring a company, the team studied Zendesk, taken private in 2022 by two private equity firms. From Zendesk's final 10-Q, they reformatted the P&L into year-over-year changes for the six-month period ending in 2022 versus 2021. Sales and Marketing grew more slowly than revenue (good), but R&D expenses grew about 50% faster than revenue and General and Administration more than twice as fast. They predicted the new owners would aggressively cut those two areas — which matched history: a November 2022 reduction followed by a May 2023 reduction, apparently focused on fast-growing expense areas, especially G&A.
Illustrates: cost lines growing faster than revenue predict where post-acquisition cuts land.

## Seniority-mix model, sketch phase

The team sketched the organization in Excalidraw (any simple tool works; simplicity keeps focus on stocks and flows, like messy wireframes before pixel-perfect design). They started with SWE1: external hires arrive, some get promoted to SWE2, some depart, and departures are backfilled with new SWE1s. Replicating the pattern through SWE2, SWE3, and SWE4 produced the full four-level model; SWE4 is simpler since no further promotion exists. They stopped at four levels because more would make the model increasingly burdensome to work with.
Illustrates: sketching stocks and flows before coding a model, and capping model complexity deliberately.

## Reasoning from the sketch alone

Before any simulation, the sketch yielded conclusions: if promotion rate into a level exceeds hiring plus N-1 backfill into it, that level's share grows over time; with little hiring, this reduces to promotion rate versus departure rate, so a low-hiring, high-retention company cannot afford frequent promotions; and the common "career level" policy (a level where promotions generally stop) is likely a financial constraint dressed in other rationale.
Illustrates: qualitative insight extracted from system structure before running numbers.

## Model iteration 1: backfill-at-level

Built with the lethain/systems tool (the full model and visualizations for each iteration are available on GitHub), using two modeling devices: an information link (a stock `HiringRate(2)` whose size defines hiring flows at every level, like a reusable variable) and an infinite stock `[Candidates]` representing the unlimited hiring pool. Each level had external hiring at the HiringRate, a 10% promotion leak upward (none for SWE4, the top level), a 10% departure leak, and a 50% backfill leak rehiring departures at the same level. Promotions are leaks because promoting one engineer does not make the remaining lower-level engineers disappear. A Graphviz render confirmed the coded model matched the sketch. Running it showed the organization becoming ever more top-heavy with SWE4s — exponential growth of the senior share.
Illustrates: the intuitive backfill-at-same-level policy ("you needed an SWE2 before, so hire an SWE2") structurally produces a top-heavy organization.

## Model iteration 2: N-1 backfill

One-line change per level: departures now flow into the level below (`DepartedSWE2 > SWE1 @ Leak(0.5)`), except SWE1s, who still backfill as SWE1s since no lower level exists. The result: top-heaviness changed from exponential to linear growth — an improvement, but still a very expensive organization, and not one reducing costs.
Illustrates: N-1 backfill helps but is insufficient on its own.

## Model iteration 3: no hiring

The prior models hired at an even rate across all levels — not particularly realistic, and one reason they showed so many SWE4s. Setting `HiringRate(0)` and realistic starting cohorts (100 each of SWE1–SWE3, 10 SWE4s) modeled a cost-reducing organization that has stopped growing. The senior ratio improved but remained too high: roughly 1.25 SWE1s per SWE4, where a healthy ratio is closer to five to one.
Illustrates: even a hiring freeze combined with N-1 backfill cannot fix the seniority mix.

## Model iteration 4: capped SWE4 stock

Defining SWE4 as a capped stock — `SWE4(10, 20)`, initial size 10, maximum 20, which no flow can exceed — finally produced the desired ratio of SWE4s to other levels. The cap created backpressure: a surplus of SWE3s accumulated, suggesting future policy questions (presumably more SWE3s than SWE2s would depart, seeing their promotion capped by the departure rate of existing SWE4s). The author ended modeling there, judging the key lessons learned.
Illustrates: only the combination of N-1 backfill, no senior hiring, and a hard cap at the top level achieves a healthy seniority mix; caps create backpressure worth noting for follow-on policy.

## Document structure note

Relative to the book's default strategy structure, Document 18-1 was refactored for readability: Operation was folded into Policy, and Refine was embedded in Diagnose. Readers applying the strategy should read top to bottom; readers studying the thinking should read in reverse (Explore, then Diagnose, then Policy), per Chapter 11.
Illustrates: the strategy document structure is adaptable, and reading order depends on whether you are applying or studying the strategy.
