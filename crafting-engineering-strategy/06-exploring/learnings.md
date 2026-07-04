# Chapter 6: Exploring

This chapter defines exploration as the mandatory first step of strategy creation: deliberately searching the problem and solution spaces before committing to any approach. The single most important takeaway: a surprising number of strategies are doomed from inception because the author anchored on a familiar approach (usually from prior experience) without checking alternatives. Larson's summary claim is even stronger: every one of the worst strategic failures he has encountered would have been prevented if its primary author had taken a few days to explore the space before anchoring — a few days of feeling slow are always worth avoiding years of misguided effort.

## Core ideas

### What exploration is

Exploration is "the deliberate practice of searching through a strategy's problem and solution spaces before allowing yourself to commit to an approach." It means understanding how others have approached the same problem — recently and in the past, in trendy companies you admire and in practical companies that actually resemble yours.

Why it matters: exploration is the antidote to early anchoring. It verifies that your prior experience remains relevant rather than assuming the industry has been stagnant since you last worked on the problem. Larson frames it as "continuing to believe that things can get better when you're not watching."

### Why strategies fail without it: early anchoring

A surprising number of strategies are doomed from inception because their authors get attached to one approach without considering alternatives better suited to current circumstances. Two common triggers: engineers picking tools solely because they are trending, and executives insisting on the tech stack from their prior organization where they felt comfortable.

The failure mechanism is structural, not stupidity: very intelligent leaders accept early thoughts as the foundation of their strategy, build everything on top of those ideas, and eventually so much weight rests on the early assumptions that acknowledging the errors becomes impossible.

### The Grand Migration antipattern

A new senior leader declares that a massive migration to a new technology stack — typically their former employer's stack — will solve every pressing problem. What distinguishes the Grand Migration is not the initially bad selection but the single-minded ferocity with which the leader keeps pushing even after it becomes clear to others that it doesn't solve the problem at hand.

### Internal vs. external exploration mix

Exploration is usually more external than internal, but the proportion depends on company size. In a 100,000-engineer organization, there are likely existing internal solutions you've never heard of; in a 50-engineer organization, much of the exploration will likely be external.

### When to explore, and when to stop

Exploration is always the first step. Skipping it inadvertently boxes you into whatever approach you focus on first. It is especially critical for problems you have solved before, because it is the only thing preventing you from overindexing on prior experience.

Stopping rule: explore until you know how three similar teams within your company (at a large company) and three similar companies have recently solved the same problem, and you can explain the thinking behind those decisions. Then move to diagnosis.

Time bounds: less than a few hours of exploration is very suspicious; more than a week is questionable.

### Internal precedent as strategy

One of the most powerful forms of strategy is simply documenting how similar decisions have been made internally — often enough by itself to steer how the organization makes similar decisions in the future (the "Write five, then synthesize" approach from Larson's *Staff Engineer*). For people in established companies, this is the most valuable exploration step.

A non-obvious why: sometimes the internal approach isn't ideal but is still superior, because it's already implemented and someone else maintains it. Your strategy can ride along as that other owner fixes the imperfect fits over time.

### The personal network as an exploration tool

Some topics you can't learn much about without talking directly to practitioners — especially security, compliance, operating at truly large scale, and competitive processes like optimizing advertising spend. Additionally, people often publicly describe solving a problem very differently from how they actually approach it, so public accounts can mislead. A broad network gives you the breadth of possible solutions quickly, plus the practical downsides people often omit when speaking publicly.

Caveat: evaluate network information with skepticism. Your network can be wrong, and the people in it never know how your circumstances differ from theirs.

Larson calls networking "a foundational technique for effective decision making" and points readers wanting depth on building one to *Staff Engineer*'s "Build a network of peers" and *The Engineering Executive's Primer*'s "Building your executive network."

### Read widely; read narrowly

Two distinct reading motions:

- **Read widely, ongoing**: Larson reads 10–20 industry-relevant works per year (not necessarily new releases, just new to him), deliberately on topics he doesn't know much about or arguments he initially disagrees with. This stocks ideas for future problems.
- **Read narrowly, per-strategy**: when starting a specific strategy, read surveys and papers on that exact topic to understand the range of options and find further references — not to get final answers.

Reading sources need not be books: blog posts, essays, interview transcripts, conference talks all count.

### Each job is an education

Experience — time spent working on the details of meaningful problems — is the most effective and the slowest exploration mechanism. You probably shouldn't optimize every job choice for learning (financial stability matters too), but occasionally choosing a job for learning lets you explore complex problems over time, with the awareness that some prior knowledge will have gone stale.

### Save judgment for later

The point of exploration is to go broad: to understand approaches you might not have considered and to invalidate things you initially think are true. Both are only possible if you defer judgment. If you're labeling approaches "good" or "bad" during exploration, the exploration is probably going astray.

Soft rule: if no one involved in the strategy has changed their mind about something they believed at the start of exploration, you're not done exploring. This applies most strongly to senior leaders — their beliefs are often well-justified by years of experience, but even they start each exploration unsure whether that experience has gone stale.

## Actionable guidance

The five-step exploration process (run inside your draft strategy document):

1. Gather every resource you can think of related to the problem.
2. Do web searching and foundational-model (LLM) prompting, and ask a few current and former colleagues what topics and resources you're missing.
3. Summarize the gathered list, separating resources you will explore from those you won't spend time on but are worth mentioning.
4. Work through the list one by one, collecting notes in the strategy document; then synthesize the notes into a concise, readable summary of what you've learned.
5. Once you generally understand how a handful of similar internal and external teams have recently approached the problem, stop.

Further rules and heuristics:

- Always explore first. Exploration is the most inherently open-ended step of strategy creation, so an alternative personal process is fine as long as it doesn't skip exploration; if unsure, follow the five steps closely.
- Bound exploration: minimum a few hours, maximum about a week.
- Stop criterion: you can explain how three similar internal teams (at a large company) and three similar companies recently solved this problem, including their reasoning.
- Mine internal precedent even if you're tenured — look for related internal experiments, especially if you joined recently or work far from the codebase.
- An imperfect internal solution is sometimes still superior, because it's already implemented and someone else maintains it.
- Text industry peers to validate assumptions fast; a question answered mid-meeting can collapse weeks of disagreement into minutes.
- Treat network answers skeptically: peers don't know your circumstances.
- Skim books liberally; skip content irrelevant to your current goal. Even tightly edited books contain much you don't need.
- Read widely each year (Larson reads 10–20 industry-relevant works), biased toward unfamiliar topics and arguments you initially disagree with.
- When starting a new strategy, read narrowly on that topic (e.g., a survey work or industry papers) to map the option space and find further references.
- Wardley mapping (Chapter 8) can support exploration; it was designed within a different strategy tradition, and pigeonholing it as only an exploration or only a refinement tool ignores some of its potential uses. There's no perfect way to do strategy — take what works and use it.
- Test for completion: has anyone changed their mind yet? If not, keep exploring.

## Pitfalls and misconceptions

- **Anchoring on your first approach**: skipping exploration boxes you into whatever you focused on first; you will always regret it.
- **The Grand Migration**: importing your former employer's stack as a universal fix and pushing it with single-minded ferocity even as it becomes clear to others that it doesn't solve the problem.
- **Adopting tools because they're trending** rather than because they fit your circumstances.
- **Assuming your prior experience is still current**: industries move; exploration exists to check for staleness.
- **Passing judgment during exploration**: evaluating "good/bad" while exploring defeats the purpose of going broad and invalidating your own beliefs.
- **Trusting public accounts**: how people publicly describe solving a problem often differs from what they actually did; practitioner conversations correct for this.
- **Accepting network input uncritically**: your peers' context differs from yours and they can be wrong.
- **Under- or over-exploring**: less than a few hours is very suspicious; more than a week is questionable as well.
- **Copying only admired companies**: study both trendy companies you admire and practical companies that actually resemble yours.
