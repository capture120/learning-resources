---
name: research-process-nathan
description: general advice on how to conduct research. use when the problem itself is unknown or ill-defined and you must discover the right questions. covers the four research stages (ideation, exploration, understanding, distillation), the three core mindsets (truth-seeking, prioritisation, moving fast), and research taste.
---

Research differs from problem solving. In problem solving you are given problem X and find a solution. In research you often do not know the right problem yet. Most of the work is discovering the right questions to ask.

# References

This skill is a distillation. Read the source files when the summary is not enough.

- `references/neel-nanda.md` - Neel Nanda's full three-post series. This is the source for everything in this skill. Read it when you need the reasoning behind a bullet, concrete examples, or detail on one stage (e.g., how to design experiments in Understanding, or how to write up in Distillation). It also contains mech-interp-specific advice (tooling, TransformerLens, experiment ideas) that this skill omits on purpose.
- `references/research-as-a-stochastic-decision-process-restored.md` - Jacob Steinhardt's "Research as a Stochastic Decision Process." Not distilled into this skill. Read it when planning or ordering a set of experiments: it gives a framework for sequencing tasks by information gained per unit time, de-risking the riskiest steps first, and estimating how likely a plan is to fail.

Default rule: apply the bullets in this skill directly. Open a reference only when a bullet needs justification, you face an edge case the bullet does not cover, or you are doing experiment-sequencing (Steinhardt).

# The four stages (Neel Nanda)

Know which stage you are in. Each stage has a different north star, so each stage needs a different prioritisation rule.

1. **Ideation** - Choose a problem.
   - North star: choose a fruitful problem.
   - Lean on a mentor, an existing research agenda, or replicate and extend a paper.
   - Understand how your work fits the existing literature: what is known, what is open.
   - For your first project or two, lean on a mentor and read a few key papers. Deep literature knowledge takes time and is easier once you have hands-on experience. Deep Research tools are invaluable for literature reviews in unfamiliar domains.
2. **Exploration** - Gain surface area.
   - North star: gain information.
   - You will not have a clear hypothesis yet. This is fine and normal. Most stuck junior researchers think they are in Understanding when they are actually in Exploration.
   - Run many quick experiments. Visualise data many ways. Follow curiosity. Do not be a perfectionist about picking the "best" experiment.
   - Frequently ask: "am I getting enough information per unit time?" If you have not learned anything recently, shake it up.
   - Keep a highlights doc of interesting results. It helps you spot connections.
   - Do not leave this stage at the first plausible hypothesis. Check for unexplained anomalies and alternative explanations first; most of your probability mass should sit on "a hypothesis I have not thought of yet."
   - It is fine to believe false things briefly. Move fast and reflexively try to falsify beliefs, so you never build a long rabbit hole on a false premise. Qualitative deep dives (e.g., a single prompt) are fine here.
   - Most of the value of this stage is discovering the right questions to ask. Once found, crystallising them into hypotheses is often easy.
   - Long-term, exploration should feel like play: be fascinated by the problem and follow curiosity. This needs calibrated intuitions, so do not worry about it at first.
3. **Understanding** - Test hypotheses.
   - North star: convince yourself a key hypothesis is true or false.
   - Starts when you can write down specific hypotheses and imagine evidence that would confirm or refute them.
   - A great experiment cleanly distinguishes between several plausible hypotheses, validates non-trivial predictions, and is tractable. To design one: simulate the world where hypothesis X is true, think through its implications, and turn an implication into an experiment.
   - Be relentlessly skeptical. Seek alternative explanations, implement strong dumb baselines, check for bugs. Expect to dip back into exploration when results are weird.
   - Think in a Bayesian way. Ask "was this observation more likely under hypothesis A or B?", not just "did my favourite hypothesis predict it?"
   - Prefer quantitative evidence here. If you use qualitative case studies, sample them randomly to avoid cherry-picking. Exception: a claim of the form "at least one example of X exists" can rest on a single case.
   - When reading papers, find the key experiments their core claims hinge on. Ask what made each one important and how you might have thought of it.
4. **Distillation** - Compress, refine, communicate.
   - North star: compress findings into concise, rigorous truth you can communicate.
   - Compress to a few bullet-point claims. Readers take away at most a few claims.
   - Refine evidence to convince a skeptical outsider, a higher bar than convincing yourself. Red-team: what could you be missing? What alternative hypotheses fit?
   - Write to inform, not persuade. Acknowledge limitations; discussing them well makes work stronger, not weaker.
   - Start writing early. Writing exposes holes and missing experiments. People often do not understand their own project until they write it up.
   - If writing reveals things are messier than you thought, go back a stage. That is normal, not failure.

# The three core mindsets

1. **Truth-seeking.** By default many research insights are false. Insufficient skepticism does not feel like insufficient skepticism from the inside; it just feels like doing research. So build skepticism into the process: alternative explanations, baselines, sanity checks, bug hunts. Most of your probability mass should usually sit on "a hypothesis I have not thought of yet." Do not warp the narrative to look publishable; publish negative results. But too much skepticism is also a failure mode: you must let yourself explore the implications of promising but unproven hypotheses, since that is how good experiments get designed.
2. **Prioritisation.** Good prioritisation means having a clear north star and ruthlessly evaluating actions against it. Write down three tiers: Goal (months), Sub-goal (weeks), Objective (days). Write a rough plan with time estimates; you will deviate, but planning surfaces uncertainties. Do not spend more than a few hours on it. If you feel stuck, set a 5-minute timer and brainstorm possible next actions. Be ruthless about dropping weak directions, but beware switching costs: switch constantly and you learn nothing. Prioritising and executing are different mental modes - keep them separate. Zoom out at least daily; do an extended weekly review (What is my goal? What progress? What blocked me? What mistakes? What am I confused about?). Mentors have good research priors, but you know far more about your specific problem than they do; that can be enough to out-decide even a very senior researcher.
3. **Moving fast.** Tight feedback loops are the top priority: shorten the time from experiment idea to result. Use notebooks, flexible tooling, small models, small data, fail-fast evals. Cultivate a deep-seated impatience: assume there is a faster way until proven otherwise. Prefer flexible tooling early (fast arbitrary experiments) and optimised, robust tooling later (e.g., during distillation). Do fast dirty experiments before slow conclusive ones; several quick experiments attacking different angles beat one polished experiment. Audit your time to find inefficiencies. Fail fast: ask "if this direction is doomed, how do I discover that as fast as possible?" But do not let speed become sloppiness: still make regular time to think and reflect rather than constantly producing results. Accept that there is no knowable "right" next step - make a best guess, act, and stay ready to update.

# Research taste

Taste is not mystical. It is the set of intuitions and judgments guiding every open-ended decision: which problem, which anomaly to chase, which experiment convinces, which narrative to tell. It decomposes into intuition (system 1), conceptual frameworks (system 2), the strategic big picture, and conviction.

Conviction is a double-edged sword: confidence arrives long before correctness. Aim for strategic conviction - adopt a confident mindset to maintain momentum, but regularly zoom out with skepticism and stay willing to abandon course on evidence. Being uncalibrated at first is fine; pursuing exciting ideas and watching some fail is exactly how calibration develops.

Train it like a model - it needs data, and data is scarce because feedback loops are long:

- **Get more data.** Lean on mentors (supervised data vs. the slow RL of solo research). Read papers critically - predict methods and limitations before revealing them; assume papers contain flaws and find them. Discuss with peers. Prefer projects with short feedback loops early on.
- **Learn more per data point.** Make explicit predictions and review accuracy. Keep a research log. Predict your mentor's advice before they give it, and dig into surprises - paraphrase their reasoning back until you find what you were missing. Post-mortem decisions when feedback finally arrives.
- **Expect it to be slow.** Tactical taste (experiment design) has short loops and improves fast. Strategic taste (problem selection) has month-to-year loops and improves slowly. Rely on external guidance early; that is expected, not a weakness.

# Reminders

- Research is hard. Expect dead ends, failed hypotheses, and imposter syndrome. Judge yourself on process and learning, not results. Your standards are likely too high.
- Different people need different advice: rabbit-holers should move on sooner; analysis-paralytics should just act. Know which one you are and take only the advice that targets it.
- Early on, the value of everything you do is dominated by learning value, so bad decisions are cheap.
