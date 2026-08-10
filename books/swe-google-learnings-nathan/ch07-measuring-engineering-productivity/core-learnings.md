# Chapter 7: Measuring Engineering Productivity

*Software Engineering at Google* — written by Ciera Jaspan, edited by Riona Macnamara.

## Chapter thesis

A growing company cannot scale its business linearly with headcount, because communication costs grow quadratically as an organization grows (the classic Mythical Man-Month observation). The alternative lever is making each engineer more productive — but improving productivity requires measuring it, and measurement itself is expensive and easy to get wrong. Google's answer is a dedicated research team (mixing software engineers with social scientists such as cognitive psychologists and behavioral economists) that measures engineering productivity in a disciplined, data-driven way. The chapter's core discipline has three stages: (1) **triage** — decide whether a question is even worth measuring, which hinges entirely on whether a concrete decision will be made from the result; (2) **metric selection** — derive metrics top-down from goals via the Goals/Signals/Metrics (GSM) framework, covering all five QUANTS trade-off dimensions of productivity; and (3) **action** — validate quantitative metrics with qualitative data, then turn findings into tool-driven recommendations and track improvement. The chapter's running example is Google's "readability" certification process, which the C++ and Java language teams asked the research team to evaluate: is the expensive human-review process worth its cost?

## Core principles and ideas

### Why measure productivity at all

- Scaling business scope requires more engineers, but communication overhead grows quadratically with organization size, so output does not scale linearly with headcount.
- Increasing per-engineer productivity lets the business grow without a commensurate increase in communication overhead.
- Productivity improvement is a continuous loop: understand what makes engineers productive, identify inefficiencies, fix them, repeat.
- The improvement effort itself must be efficient. It is not worth spending 50 engineer-years of measurement effort to recover 10 engineer-years of productivity.
- Google staffs this with a centralized team of productivity specialists rather than making every team chart its own course. The team includes social scientists, which lets it study not just software artifacts but the human side: motivations, incentive structures, and strategies for managing complex tasks.

### Triage: is it even worth measuring?

Measurement costs people-time to collect, analyze, and disseminate. The measurement process can slow the organization down, and tracking can change engineers' behavior in ways that mask the underlying issues. So before measuring, Google first asks the requester to phrase what they want to know as a **concrete question** (the more concrete, the more useful the result), and then asks four screening questions:

1. **What result are you expecting, and why?** Nobody is a neutral investigator. Stating expected results up front surfaces preconceived notions and prevents post hoc rationalization of whatever the data shows.
2. **If the data supports your expected result, what action will be taken?** If no action follows, there is no point measuring. (A valid action can be "maintain the status quo" — if a change was planned that the result would cancel.)
3. **If we get a negative result, will appropriate action be taken?** This is the question that kills most proposed measurement projects: decision makers often want to know the answer but would not actually change course, because other inputs override any negative result.
4. **Who will decide to take action on the result, and when?** The requester must be the person empowered to act (or acting directly on their behalf). You must also know what *form* of evidence convinces that decision maker — stories from interviews, survey results, logs data, or statistical analysis — because if the decider doesn't believe the form of the result in principle, measuring is pointless.

The chapter's definition of success: **success means giving a stakeholder the data they need to make a decision** — not proving a hypothesis right or wrong. If the stakeholder won't use the data, the project is a failure. Only measure a software process when a concrete decision will be made based on the outcome.

Common good reasons *not* to measure:

- **You can't afford to change the process or tools right now** (time or money constraints; e.g., a faster build tool would save hours weekly, but a funding deadline makes the switchover interruption unaffordable).
- **Results will soon be invalidated by other factors** (e.g., measuring just before a reorganization, or measuring technical debt of a system already slated for deprecation).
- **The decision maker has strong opinions you cannot realistically move** with the type and volume of evidence available. Know your audience: some stakeholders never trust self-reported survey data; others are swayed only by narrative interviews; others only by logs analysis. Mixed methods triangulate best, but if the stakeholder only believes methods inappropriate for the problem, don't do the work.
- **The results would be vanity metrics** — support for something you were going to do anyway. This is the most common reason Google tells teams not to measure.
- **The only available metrics are too imprecise or confounded** to measure the problem. Imprecise metrics (e.g., lines of code) produce uninterpretable results: if the result confirms preexisting beliefs, stakeholders proceed without questioning the metric; if it doesn't, the metric's imprecision provides an easy excuse to proceed anyway. Either way the measurement changed nothing.

### The Goals/Signals/Metrics (GSM) framework

Once you decide to measure, GSM guides what to measure. Definitions:

- **Goal**: the desired end result, phrased in terms of what you want to understand at a high level, with *no reference to any specific way of measuring it*. Goals are not themselves measurable, but a good set of goals is something everyone can agree on before proceeding.
- **Signal**: how you would know you achieved the goal. Signals are things you would *like* to measure but may not be measurable themselves. Every goal should have at least one signal; goals can have several signals, and goals can share signals (no 1:1 relationship).
- **Metric**: a proxy for a signal — the thing you actually *can* measure. It may not be the ideal measurement, just close enough. One signal may need multiple metrics to triangulate on the underlying truth.

Why GSM works (three properties):

1. **It prevents the streetlight effect** — named for "looking for your keys under the streetlight": searching only where it's easy to see. With metrics, this means grabbing whatever data is easily accessible regardless of whether it suits your needs. Deriving metrics from goals forces you to measure what actually matters.
2. **It prevents metrics creep and metrics bias.** Because the metric set is chosen by a principled process *before* results exist, stakeholders agree in advance that these metrics map to the goals. When results later disappoint someone, they can't credibly demand different metrics that would produce the answer they want.
3. **It exposes measurement coverage gaps.** Listing all goals and their signals reveals which signals have no measurable metric. Knowing what you *cannot* measure is itself valuable — you can then decide whether to build new metrics or whether measuring is worthwhile at all.

The essential discipline is **traceability**: every metric must trace back to the signal it proxies and the goal that signal serves, so you always know what you're measuring and why.

### QUANTS: the five components of productivity

Teams routinely forget core trade-offs when setting goals — most classically, optimizing velocity while forgetting quality (the reductio: "I can make your review velocity very fast: just remove code reviews entirely"). To combat this, Google divides productivity into five components that are **in trade-off with one another**, and asks teams to consider goals in each so they don't improve one while silently degrading another. The mnemonic is **QUANTS**:

- **QU — Quality of the code.** What is the quality of the code produced? Are test cases good enough to prevent regressions? Does the architecture mitigate risk and change?
- **A — Attention from engineers.** How often do engineers reach a state of flow? How much do notifications distract them? Does a tool force context switching?
- **N — iNtellectual complexity.** How much cognitive load does a task require? What is the inherent complexity of the problem? Are engineers dealing with unnecessary complexity?
- **T — Tempo and velocity.** How quickly can engineers accomplish tasks? How fast can they push releases? How many tasks complete in a given timeframe?
- **S — Satisfaction.** How happy are engineers with their tools? Do tools meet their needs? Are they satisfied with their work and end product? Are they burning out?

Not every measurement question needs goals in all five areas (the readability study had no Attention goal, and that was fine) — but each area must be *considered*.

### Qualitative and quantitative metrics together

- **Quantitative metrics** (typically logs data) give power and scale: you can measure the whole company over long periods with statistical confidence. But they provide no context or narrative — they can't explain *why* an engineer used an antiquated tool, took an unusual workflow, or circumvented a standard process.
- **Qualitative metrics** (surveys, structured interviews, case studies, experience-sampling studies) provide that context and are the only source of insight on *next steps* to improve a process. Anecdotes are disparaged in a "data-driven" industry, but structured qualitative methods are powerful precisely because they provide explanation and narrative that raw numbers cannot.
- **Use qualitative data to validate quantitative metrics.** Google's repeated experience: when qualitative and quantitative metrics disagree, it is usually the *quantitative* metric that is failing to capture the expected result. Agreement across independent methods raises confidence you've reached truth; disagreement is a signal to dig deeper.
- Know the biases of each instrument. Surveying people right after they finish a process avoids **recall bias** (memory favors especially interesting or frustrating events) but introduces **recency bias** (people biased toward their most recent experience — having just succeeded, they may feel unusually positive) and **sampling bias** (you only hear from people who completed the process, not those who dropped out).
- Some signals are simply unmeasurable today (the chapter's example: no proposed proxy in the academic literature truly captures *code quality*). It is better to acknowledge a signal as unmeasurable than to adopt a poor proxy and make decisions on it.

### A critical warning: never use these metrics on individuals

Fine-grained productivity metrics must not be used to evaluate individual engineers or to identify high and low performers. If productivity metrics feed performance reviews, engineers will game them, and the metrics become useless for measuring and improving productivity across the organization. The measurements only work if you let go of measuring individuals and embrace measuring the aggregate effect.

### Taking action and tracking results

- After a study, always produce a list of concrete recommendations: new tool features, better tool latency, improved documentation, removal of obsolete processes, or changed incentive structures.
- Recommendations should be **tool driven**: it does no good to tell engineers to change their process or mindset if the tools don't support the change. Assume engineers will make the right trade-offs *if* they have proper data and suitable tools at their disposal.
- Then repeat: track whether the improvements landed, in a continuous improvement loop.

## Actionable guidance (checklist form)

1. Before any productivity measurement, force the requester to state a concrete question, their expected result, the action on a positive result, the action on a negative result, and the empowered decision maker plus their trusted evidence type. If any answer is missing, decline to measure.
2. Refuse vanity-metric requests — measurements whose outcome won't change the decision.
3. Refuse to substitute imprecise or confounded metrics (like lines of code) when precise ones are unavailable; the result will be uninterpretable either way.
4. Write goals first (no measurement language), then signals, then metrics. Keep a traceability map from every metric back through its signal to its goal.
5. Sweep all five QUANTS dimensions when writing goals so you catch cross-dimension trade-offs (velocity vs. quality being the classic).
6. Where a signal is unmeasurable, say so explicitly rather than adopting a bad proxy; consider self-report as a stopgap.
7. Triangulate: pair logs-based metrics with survey/interview metrics for the same signal. Investigate disagreements; suspect the quantitative side first.
8. Validate metrics with qualitative techniques such as experience sampling (interrupting engineers in the moment with a short survey during the task of interest) to confirm the metric matches lived experience.
9. Design surveys aware of recall, recency, and sampling bias, and choose survey timing deliberately.
10. Keep a longitudinal survey mechanism (e.g., a quarterly engineering survey) for tracking beliefs and satisfaction over time, separate from one-off process-specific surveys.
11. Make recommendations that live inside the developer workflow, daily habits, and incentive structures rather than relying on training or exhortation.
12. Never wire productivity metrics into individual performance evaluation; measure aggregates only.
13. If the organization is large enough, staff a centralized productivity-research team with mixed expertise (engineering plus social science) rather than having each team improvise.

## The chapter's own TL;DRs

- Before measuring productivity, ask whether the result is actionable, regardless of whether the result is positive or negative. If you can't do anything with the result, it is likely not worth measuring.
- Select meaningful metrics using the GSM framework. A good metric is a reasonable proxy to the signal you're trying to measure, and it is traceable back to your original goals.
- Select metrics that cover all parts of productivity (QUANTS). By doing this, you ensure that you aren't improving one aspect of productivity (like developer velocity) at the cost of another (like code quality).
- Qualitative metrics are metrics, too! Consider having a survey mechanism for tracking longitudinal metrics about engineers' beliefs. Qualitative metrics should also align with the quantitative metrics; if they do not, it is likely the quantitative metrics that are incorrect.
- Aim to create recommendations that are built into the developer workflow and incentive structures. Even though it is sometimes necessary to recommend additional training or documentation, change is more likely to occur if it is built into the developer's daily habits.
