# Chapter 18: Private Equity Ownership Strategy — Detailed Reference

## Introduction

This chapter's documents take on the role of an engineering organization attempting to navigate new ownership by a private equity group. The chapter frames this as an increasingly frequent scenario: after many years of learning to operate under the direction of its original founders, and the brief excitement of going public, the company now has a short runway to change operating models.

The company is called Fungible Ecommerce Company. It is a platform for supporting online commerce. Document 18-1 is its Engineering leadership team's attempt to think through their options while waiting for the new ownership to provide concrete guideposts.

One of the trademarks of private equity ownership is the expectation that either:

- the company maintains its current margin and grows revenue at 25% to 30%, or
- the company grows more slowly and increases its free cash flow year over year.

In many organizations, engineering costs have a major impact on free cash flow. There are many costs to reduce — cloud hosting and such — but inevitably, part of the discussion is addressing engineering headcount costs directly.

One of the largest contributors to engineering headcount costs is an organization's seniority mix: more senior engineers are paid quite a bit more than earlier-career engineers. Document 18-2 models how various policies impact an organization's seniority mix.

## Reading These Documents

The documents in this chapter are combinations of real documents addressing several similar circumstances across multiple companies. They are:

- **Document 18-1: Navigating Private Equity Ownership** — summarizes the Engineering organization's strategy for working with new private equity ownership.
- **Document 18-2: Engineering Organization Seniority-Mix Model** — a system model exploring how different cost-management strategies will impact the Engineering organization's cost structure over time.

Reading order depends on the reader's goal:

- If reading with the goal of applying the strategies the documents put forward, start at the top and read to the end.
- If the main goal is to understand the thinking behind them, read the sections in reverse order, starting with Explore, then Diagnose, and so on. (For more on this structure, see Chapter 11.)

As with the other chapters in Part IV, this chapter reproduces a set of documents, provides context and commentary in footnotes, and concludes by drawing out some key takeaways. The full model and visualizations for each iteration in Document 18-2 are available on GitHub.

## Document 18-1: Navigating Private Equity Ownership

> Footnote 1 (attached to the Policy section): relative to the default strategy-document structure, this document has been refactored in two ways to improve readability. First, Operation has been folded into Policy. Second, Refine has been embedded in Diagnose.

### Policy

The organization's policy for managing its new ownership structure:

1. **Wait for explicit targets before planning reductions.** The team believes the new ownership will provide a specific target for Research and Development (R&D) operating expenses during the upcoming financial year planning. They will revise these policies again once they have explicit targets, and will delay planning around reductions until they have those numbers — explicitly "to avoid running two overlapping processes."

2. **Expect moderate reduction pressure; absorb it without major headcount cuts.** Looking at their R&D investment relative to comparably growing peer sets, they believe they will get pressure to moderately reduce spend. They aim to accomplish that reduction through a series of policies and one-off infrastructure projects, without requiring a major reduction in headcount spend.

3. **N-1 backfill and Principal Engineer cap, effective immediately.** They will move to an "N-1" backfill policy, where departures are backfilled with a less senior level. They will also institute a strict maximum of one Principal Engineer per business unit, with any exceptions approved in writing by the CTO — this applies for both promotions and external hires. These policies are effective immediately and are based on the model of engineering-org seniority mix (Document 18-2).

4. **Headcount cost reduction commitment.** They commit to this policy of reducing headcount costs by approximately 5% year over year, every year, for the foreseeable future.

5. **Geographical hiring strategy: no change, honestly stated.** They evaluated a number of potential changes to the geographical hiring strategy, but they believe that staffing engineers with cross-functional partners (Product, Marketing, Sales, and so on) is a priority. They have not been able to reach an agreement cross-functionally, and as such they are not changing the geographical hiring strategy at this time. If a policy could be agreed on here, it could accomplish a 10%–20% reduction in cost over two to three years — but the details matter a great deal, so they cannot commit to a specific outcome until there is more cross-functional alignment.

6. **Continue the infrastructure efficiency strategy.** Infrastructure spend has grown significantly more slowly than revenue for the past two years, meaning the organization has successfully implemented its infrastructure spend strategy of growing infrastructure costs more slowly than revenue. They will continue the current infrastructure efficiency strategy, and believe there are relatively few high-impact efficiency opportunities remaining at this point.

7. **Infrastructure growth cap.** They commit to growing infrastructure spend at no more than 5% year over year, significantly lower than the projected revenue increase of 25% year over year.

8. **Post-acquisition infrastructure integration.** There are two narrow infrastructure spend opportunities, both related to the integration of prior acquisitions into shared infrastructure and away from one-off approaches. They will prioritize the post-acquisition integration work next quarter, with the goal of fully standardizing all infrastructure across the company into the stack maintained by the centralized Infrastructure Engineering team.

9. **One-time infrastructure reduction.** They commit to a one-time reduction in infrastructure of 3% year over year.

10. **R&D maintenance working group.** They believe there are significant opportunities to reduce R&D maintenance investments, but lack conviction about which particular efforts to prioritize. They will kick off a working group to identify the features with the highest support load.

### Diagnose

The diagnosis of Fungible Ecommerce Company's current state:

- **Revenue.** Revenue has grown 20%–25% year over year for the past two years, and the target for next year is 25% year-over-year revenue growth. This is not a guarantee — growth was slower than 25% last year — but it is a defensible goal with a good chance of being achieved.

- **Headcount costs versus headcount.** Engineering headcount costs grew by 15% year over year this year, and 18% year over year the prior year. Headcount itself grew 7% and 9% respectively. The difference between headcount growth and headcount-cost growth is explained by:
  - salary band adjustments: 4%
  - a focus on hiring senior roles: 3%
  - increased hiring in higher-cost geographic regions: 1%

- **Likely ownership expectations, with explicit uncertainty.** Based on general practice, it seems likely that the new private equity ownership will expect a reduction in R&D headcount costs through a reduction. However, without concrete details, the team cannot yet make structured decisions. The strategy will depend significantly on the scale of any proposed reductions.

- **Infrastructure spend history.** Infrastructure engineering spend (including vendors) has grown by 4%–5% year over year for the past three years. The organization made a significant push on reducing costs three years ago, and has grown slower than revenue since then.

- **Remaining infrastructure savings.** There are few remaining opportunities to significantly reduce infrastructure costs, but several acquisitions made since the prior infrastructure consolidation represent significant potential savings: roughly one-time 1.5% year-over-year reductions for each of the two largest opportunities.

- **R&D maintenance burden.** A significant portion of current R&D spend goes into maintaining existing functionality, particularly functionality related to earlier geo-expansion efforts that only apply narrowly to some small markets. The team suspects there is an opportunity to reduce maintenance overhead here.

- **Missing metrics.** However, the team lacks believable metrics on both (1) time spent maintaining the software and (2) time that would be saved by these cleanup efforts. As a result, it is hard to pitch projects of this sort as revenue saving with much conviction.

### Explore

Framing for the exploration: financial markets evaluate companies in comparison to their peers. This is most obvious in public markets, where there is significant information transparency about business performance, and sufficient liquidity to allow markets to revalue companies in something approaching real time. While private equity firms generally take controlling interest of private businesses — or buy with the intent of taking the business private if it happens to be public — they value businesses in the same way.

The exploration digs into two questions: first, a dataset on the performance of public technology companies; second, the concrete example of Zendesk, taken private in 2022 after being bought by two private equity firms.

#### Comparable companies

Most investors evaluate engineering within the context of the overall Research and Development (R&D) investment. They generally judge that spend by constructing a scatterplot of R&D spend versus year-over-year revenue growth for a cohort of similar companies. Perfectly similar companies don't exist, so this cohort is generally constructed from companies:

- in similar industries,
- with similar revenue,
- operating in the same regions.

The team reached out to their investors to see if they can provide the internal datasets used for this analysis. In the meantime, they developed a directionally useful dataset using the **2023 R&D Investment Scoreboard**, with some rough cutting of the data to remove outliers (shown in Figure 18-1: R&D investment versus operating profit growth at public companies). If the process is repeated, they will use the **SEC's EDGAR database** to pull a more specifically helpful dataset, but the Scoreboard has been a useful starting point.

This is not a perfect dataset — they would prefer revenue growth over growth in operating profit — but it was the best option within the dataset they could quickly pull down. Nonetheless, there is a clear strong-performer quadrant in the top-left of the scatterplot that the company can plot itself into to understand its general performance; that positioning is discussed further in the Diagnose section.

#### Zendesk

The second topic of exploration: understanding the general sequence of steps taken by private equity ownership after acquiring a company. For an example with available public documentation, the team focused on the purchase of Zendesk in 2022.

Method:

1. Pull Zendesk's final 10-Q before going private (Figure 18-2: Zendesk's P&L from their 2022 10-Q).
2. Reformat those values into a chart (Figure 18-3) focusing on the year-over-year changes in the six-month period ending in 2022 versus the same period in 2021.

Findings — the changes are "a bit concerning":

- Sales and Marketing (S&M) costs grew more slowly than revenue, which is positive.
- Research and Development (R&D) expenses grew about 50% faster than revenue.
- General and Administration (G&A) charges grew more than twice as quickly as revenue.

From those growth rates, one would assume the new ownership might push to aggressively reduce spend in those two areas (R&D and G&A). That is indeed what history suggests happened: a November 2022 reduction, followed some months later by a May 2023 reduction. It is hard to get precise data here, but the team's impression is that these reductions focused on areas where expenses were growing quickly, with particular focus on G&A functions.

## Document 18-2: Engineering Organization Seniority-Mix Model

### Learnings

The model's headline learnings, stated up front:

1. An organization without a "backfill at N-1" hiring policy — for example, an organization that hires a Software Engineer (SWE) 2 to replace a departed SWE2 — will have an increasingly top-heavy organization over time (Figure 18-4: ratio of engineers at the most senior level becomes increasingly heavy over time).

2. However, even introducing the "backfill at N-1" hiring policy is insufficient: representation at senior levels will become far too high, even if external hiring into the most senior levels stops (Figure 18-5: implementing an N-1 backfill policy prevents unbounded increase of the rate of most-senior engineers).

3. To fully accomplish the goal of a healthy seniority mix, the organization must do all three of: stop hiring at the most senior levels, implement a "backfill at N-1" policy, and cap the maximum number of individuals at the most senior level (Figure 18-6: N-1 backfill policy and capping number of engineers at most senior level).

4. "Any collection of lower-powered policies simply will not impact the model's outcome."

### Sketch

The system is first sketched in Excalidraw. It is always fine to use whatever tool you prefer, but simpler sketching tools generally help you focus on iterating the stocks and flows — without getting distracted by tuning settings — much like a designer starting with messy wireframes rather than pixel-perfect designs.

Sketching sequence:

1. Start with the most junior level, SWE1 (Figure 18-7: hiring, departures, and promotions for SWE1 engineers). External candidates are hired to become SWE1s. Some get promoted to SWE2, some depart, and those departures are backfilled with new SWE1s (Figure 18-8: hiring and promotion lifecycle for SWE1 and SWE2).

2. As the full stocks and flows for SWE2 are sketched, the idea of backfilling at the prior level is introduced.

3. Replicating this pattern for two more career levels — SWE3 and SWE4 — gives the complete model (Figure 18-9: hiring and promotion lifecycle for four levels of career ladder).

4. The final level, SWE4, is simplified relative to the prior levels, because it is no longer possible to get promoted to a further level.

5. The model could go further than four levels, but it would simply get increasingly burdensome to work with, so it stops at four levels.

### Reason

Reviewing the sketched system, a few interesting conclusions emerge:

- **The promotion-rate inequality.** If promotion rates at any level exceed the rate of hiring at that level plus the rate of N-1 backfill at that level, then the proportion of engineers at that level will grow over time.

- **The low-hiring simplification.** If you are not hiring much, then this problem simplifies to promotion rate versus departure rate. A company that does little hiring and has high retention cannot afford to promote frequently. Promotion into senior roles will become financially restrained, even if the policy is explained by some other mechanism.

- **"Career level" policies as financial constraints.** Many companies use the "career level" policy as the mechanism to identify a level where promotions generally stop happening. The rationale is often not explicitly described, but we can conclude it is likely a financial constraint that typically incentivizes this policy.

With those starter insights, the modeling of details begins.

### Model and Exercise

The model is built using **lethain/systems**. The first version is relatively simple, albeit with a number of stocks given the size of the model; additional features are then layered on while iteratively testing a number of different scenarios.

The author chose to combine the Model and Exercise steps deliberately, to showcase how each version of the model can inspire new learnings that prompt new questions that require a new model to answer. The full model and visualizations for each iteration are available on GitHub.

#### Backfill-at-level

The first policy explored is backfilling a departure at the same level: if an SWE2 departs, you backfill them at SWE2. This intuitively makes sense — "you needed an SWE2 before to perform the work, so why would you hire someone less senior?"

Two new systems-modeling concepts are introduced in this model:

1. **Information link.** For easier iteration, the model uses the systems-modeling concept of an "information link," which is basically using a stock as a variable to define a flow. Specifically: create a stock named `HiringRate` with a size of two, then use that stock's size to define hiring flows at each career level. In programming terms, think of this as defining a reusable variable — any stock's size can define flows.

2. **Infinite stock.** There are effectively an infinite number of potential candidates for the company, so the model uses an infinite stock, represented by initializing a new stock surrounded by `[` and `]` — here, `[Candidates]`. A fixed-size stock with 100 people would instead be initialized as `Candidates(100)`. Depending on what you're modeling, both options are useful.

The initial model:

```
HiringRate(2)

[Candidates] > SWE1(10) @ HiringRate
SWE1 > DepartedSWE1 @ Leak(0.1)
DepartedSWE1 > SWE1 @ Leak(0.5)

Candidates > SWE2(10) @ HiringRate
SWE1 > SWE2 @ Leak(0.1)
SWE2 > DepartedSWE2 @ Leak(0.1)
DepartedSWE2 > SWE2 @ Leak(0.5)

Candidates > SWE3(10) @ HiringRate
SWE2 > SWE3 @ Leak(0.1)
SWE3 > DepartedSWE3 @ Leak(0.1)
DepartedSWE3 > SWE3 @ Leak(0.5)

Candidates > SWE4(0) @ HiringRate
SWE3 > SWE4 @ Leak(0.1)
SWE4 > DepartedSWE4 @ Leak(0.1)
DepartedSWE4 > SWE4 @ Leak(0.5)
```

To confirm the model is reasonable, it is rendered using Graphviz (Figure 18-10: Graphviz representation of systems model). The render looks like the same model sketched earlier, without the downlevel backfill flows that haven't yet been added — so the model is in a good spot.

The four distinct flows for the SWE2 stock, in order:

1. External candidates being hired at the SWE2 level, at the fixed `HiringRate` defined here as two hires per round.
2. SWE1s being promoted to SWE2 at a 10% rate. This is a leak because someone being promoted to SWE2 doesn't mean the other SWE1s disappear.
3. SWE2s leaving the company at a 10% rate.
4. Backfill hires of departed SWE2s, who are rehired at the same level (at a 50% rate).

Running the model shows how populations at the various levels grow over time (Figure 18-11: ratio of engineers at most senior level becomes increasingly heavy over time). Conclusion: the backfill-at-level policy is pretty inefficient, because the organization becomes more and more top-heavy with SWE4s over time. Something needs to change.

#### Backfill at N-1

To reduce the number of SWE4s, the model is updated to backfill all hires at the level below the departed employee — a departing SWE2 causes hiring an SWE1. Concretely, this means replacing lines like:

```
DepartedSWE2 > SWE2 @ Leak(0.5)
```

with hiring into the prior level:

```
DepartedSWE2 > SWE1 @ Leak(0.5)
```

The one exception: SWE1s are still backfilled as SWE1s, because as the most junior level there is no lower level to backfill into.

Running this updated model gives a better-looking organization (Figure 18-12: N-1 backfill policy without overall hiring cap). The organization is still top-heavy, but the exponential growth problem has been turned into a linear growth problem — an improvement. However, this is still a very expensive engineering organization to run, and certainly not an organization that is reducing costs.

#### No hiring

One reason the model shows so many SWE4s is that it hires at an even rate across all levels, which isn't particularly realistic. Also, it is unlikely the organization is growing headcount at all, given the aim to reduce engineering costs over time.

This is modeled by setting `HiringRate` to zero and setting more representative initial values for each cohort of engineers (only the changed lines are shown; the full model is on GitHub):

```
HiringRate(0)

[Candidates] > SWE1(100) @ HiringRate
Candidates > SWE2(100) @ HiringRate
Candidates > SWE3(100) @ HiringRate
Candidates > SWE4(10) @ HiringRate
```

The starting state is now 100 SWE1s, 100 SWE2s, 100 SWE3s, and a smaller cohort of just 10 SWE4s. Running the model (Figure 18-13: implementing an N-1 backfill policy prevents unbounded increase of rate of most senior engineers) shows that eliminating hiring improves the ratio of SWE4s to the other levels, but it is still just too high: the model ends up with roughly 1.25 SWE1s for each SWE4, when the ratio should be closer to five to one.

#### Capped size of SWE4s

Finally, a stock with a maximum size is introduced. No matter what flows want to accomplish, they cannot grow a flow over that maximum. Here, SWE4 is defined as a stock with an initial size of 10 and a maximum size of 20:

```
SWE4(10, 20)
Candidates > SWE4 @ HiringRate
```

This could also be combined into a one-liner, although it is potentially easy to miss in that form:

```
Candidates > SWE4(10, 20) @ HiringRate
```

With that one change, the model is close to an engineering organization that works as desired (Figure 18-14: N-1 backfill policy and capping number of engineers at the most senior level). The ratio of SWE4s to other functions is right.

One remaining artifact: the cap's backpressure creates a surplus of SWE3s in the organization. Other policy work might improve that as well — for example, presumably more SWE3s depart than SWE2s, because SWE3s see that their ability to be promoted is capped by the departure rate of existing SWE4s. However, the author judges that the model has already taught quite a bit, and ends modeling here.

## Summary

One of the recurring themes in interesting strategy documents is finding a way to make progress despite imperfect information, and that theme certainly shows up in these documents. Work is usually easy when you have clear, stable plans and goals, but those rarely exist. This strategy accepts the absence of a clear goal and instead focuses on using the available time to validate options for moving forward. "Sometimes the only path forward is preparation, and then all you can do is prepare."
