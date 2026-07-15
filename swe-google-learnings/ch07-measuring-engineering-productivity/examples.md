# Chapter 7 Examples: Measuring Engineering Productivity

Every substantive example, case study, and anecdote from the chapter, retold. The chapter is organized around one long running case study (the readability process study) plus several shorter anecdotes.

## The readability process study (running case study)

### Setup

"Readability" is an internal Google certification. An engineer earns readability in a programming language by having hundreds of experienced reviewers examine their code changes until the engineer demonstrates mastery of Google's style and best practices for that language; once certified, the engineer can approve code in that language without extra review. The process dates from Google's early days, before automatic code formatters and submit-blocking linters were commonplace. Because it consumes the time of hundreds of reviewing engineers plus every engineer going through it, the process is expensive. By the time of the study, some engineers viewed it as an archaic hazing ritual with no remaining value, and it was a favorite lunch-table argument. The C++ and Java language teams, who ran the process, asked Google's engineering-productivity research team a concrete question: is the time spent on the readability process worth the benefit to the company?

### Triage phase — the four screening questions applied

The research team ran the request through its standard screening questions before agreeing to measure anything:

- **Expected result?** The readability team honestly did not know. People had been sure the costs were justified years earlier, but with autoformatters and static analysis now mature, nobody was certain. Survey data showed engineers *claimed* benefits, but whether those benefits justified the author and reviewer time was unclear.
- **Action on a positive result?** The team would link the research and data from the readability FAQ and advertise the findings to set expectations.
- **Action on a negative result?** A strong commitment: if the analysis showed costs outweighed benefits, or benefits were negligible, the team would kill the process — evaluated per language, since languages differ in formatter and static-analysis maturity.
- **Who decides, and when?** Each language team was a clear, empowered decision maker. Java and C++ actively requested the study; other language teams (like Python) waited to see the outcome first, since Java and C++ had the most mature tooling — if the benefit couldn't be shown even there, weaker-tooling languages had nothing to gain from removing the process. The decision makers trusted self-reported experience for happiness and learning but demanded "hard numbers" from logs for velocity and code quality, so the study needed both qualitative and quantitative analysis. There was no hard deadline, but an upcoming internal conference was a natural announcement venue, giving the team several months.

The study passed triage: a concrete decision would be made either way, and the requesters had authority to make it.

### Goals, signals, and metrics for readability

Using the Goals/Signals/Metrics framework and the five QUANTS productivity dimensions (Quality, Attention, iNtellectual complexity, Tempo/velocity, Satisfaction), the team wrote goals such as: engineers write higher-quality and more consistent code because of readability; engineers learn the Google codebase and receive mentoring; engineers complete work faster; engineers see the process as worthwhile. Notably, there was **no Attention goal** — the book stresses that this is fine; not every question involves trade-offs in all five areas, but each area must be considered.

Signals included things like "changes written by readability-certified engineers are faster to review than changes by uncertified engineers" and "engineers report learning from the process." Metrics came from three sources:

1. A **readability-specific survey** given immediately after an engineer completed the process (avoiding recall bias but introducing recency bias — people who just succeeded feel good — and sampling bias — dropouts were never surveyed).
2. A **large-scale quarterly survey** tracking items readability was expected to affect (e.g., self-reported productivity and satisfaction with one's own code quality) without mentioning readability.
3. **Fine-grained logs metrics** from developer tools: median review time, median shepherding time, and median time-to-submit for changelists from authors with and without readability.

For the signal "code quality," the team faced a choice: use a poor proxy (academic literature has proposed many, none of which truly capture code quality) or admit the signal was unmeasurable quantitatively. They chose honesty — no quantitative code-quality metric — and fell back on engineers' self-ratings.

### Outcome

The study showed the readability process was overall worthwhile. Certified engineers were satisfied and reported learning from the process. Logs showed their code was reviewed faster and submitted faster, even after accounting for certified engineers needing fewer reviewers. The study also surfaced pain points, and the language teams used those recommendations to make the process faster and more transparent.

### Lesson

The full pipeline works: triage first (confirm a real decision hangs on the result and the decision maker has authority), derive metrics from goals via GSM across QUANTS, mix survey and logs data so each validates the other, acknowledge unmeasurable signals rather than faking them, and end with tool-and-process improvements rather than just a verdict.

## "Just remove code reviews entirely" (the forgotten-trade-off thought experiment)

**Setup.** Imagine the readability team focused solely on making the process fast and pleasant, tracking only review-duration and engineer-happiness metrics while forgetting the code-quality goal.

**What happened.** A researcher on the team offered the reductio ad absurdum: "I can make your review velocity very fast: just remove code reviews entirely." An extreme example — but teams forget core trade-offs all the time, chasing velocity while quality silently degrades (or vice versa).

**Lesson.** This is why Google requires teams to consider goals across all five QUANTS dimensions. Productivity's components are in tension; measuring one dimension in isolation invites optimizing it at the others' expense.

## The release tool team's vanity metric request

**Setup.** Google's release tool team requested a measurement of a planned change to the release workflow system. The change obviously wouldn't make things worse; the open question was only whether the improvement would be minor or large.

**What happened.** The research team asked: if the measurement shows only a minor improvement, would you build the feature anyway? The answer was yes — the change was also more performant and reduced the team's maintenance burden, so it was happening regardless. The research team declined to measure. (The feature did end up improving productivity, but as a side effect of a decision made for other reasons.)

**Lesson.** This is the book's canonical example of the most common reason not to measure: when results will only serve as vanity metrics to justify a decision already made, measurement wastes everyone's time. Measure only when the outcome will actually steer a decision.

## The faster build tool you can't afford to adopt

**Setup.** A hypothetical illustrating the "can't afford to change right now" triage exit: suppose you determine that switching to a faster build tool would save hours every week.

**What happened.** The switchover would pause development while everyone converts, and a major funding deadline is approaching, so the interruption is unaffordable.

**Lesson.** Engineering trade-offs are not evaluated in a vacuum. Broader business context can completely justify delaying action on a measurement result — and if you already know you can't act, don't measure yet.

## Stakeholders who only believe one kind of evidence

**Setup.** Even at Google, some decision makers hold unwavering beliefs shaped by past experience.

**What happened.** The research team has met stakeholders who never trust survey data because they reject self-reports; others who are best persuaded by a compelling narrative built from a handful of interviews; and others swayed only by logs analysis. The team always tries to triangulate on truth with mixed methods — but when a stakeholder only believes methods that are inappropriate for the question at hand, the team declines the work.

**Lesson.** Know your audience before measuring. If the decision maker won't believe the form of evidence the problem actually requires, the measurement cannot influence the decision and is pointless.

## The median build latency metric and the experience-sampling study

**Setup.** The team built a metric for each engineer's *median build latency*, intended to capture the "typical experience" of waiting on builds. To validate it, they ran an **experience sampling study** — a method where engineers are interrupted in the middle of the task of interest and asked a few questions. Right after an engineer started a build, an automatic short survey asked about their experience and expectations of build latency.

**What happened.** Some engineers answered that they had not started a build at all. Investigation revealed automated tools were launching builds on the engineers' behalf; the engineers were never blocked waiting on those builds, so those builds didn't count toward their felt "typical experience." The team adjusted the metric to exclude tool-initiated builds.

**Lesson.** Qualitative data validates quantitative metrics. A logs metric can be precisely computed and still measure the wrong thing. Google's recurring experience: when qualitative and quantitative metrics disagree, it is usually the quantitative metric that is failing to capture reality.

## Lines of code as a metric (the Dijkstra footnote)

**Setup.** The chapter dismisses lines of code (LOC) as a productivity metric and cites Edsger Dijkstra's essay "On the cruelty of really teaching computing science."

**What happened.** Dijkstra argued that measuring programmer productivity as "lines of code produced per month" is a costly measuring unit because it encourages writing insipid (bloated, low-value) code — and that lines of code should be booked as "lines *spent*," not "lines *produced*"; conventional wisdom puts the count on the wrong side of the ledger.

**Lesson.** Easily available metrics can be actively harmful. LOC is also the chapter's example of an imprecise, confounded metric whose results are uninterpretable no matter which way they point.

## In defense of anecdotes (footnote on "anecdata")

**Setup.** The industry disparages "anecdata" and prizes being "data driven," yet anecdotes persist.

**What happened.** The book's researchers note anecdotes are powerful because they carry context and narrative that raw numbers cannot, and resonate by mirroring personal experience. The team does not make decisions from anecdotes, but it deliberately uses structured interviews and case studies to deeply understand phenomena and to give context to quantitative data.

**Lesson.** Qualitative methods are legitimate instruments, not a lesser form of data — they explain the *why* behind the numbers and point to next steps.

## The temptation to rank individual engineers (footnote warning)

**Setup.** Fine-grained logs metrics (like time to complete specific tasks) make it tempting to evaluate individual engineers or identify high and low performers.

**What happened / the book's position.** Doing so would be counterproductive: the moment productivity metrics feed performance reviews, engineers game them, destroying their usefulness for measuring and improving the organization. The only way these measurements work is to abandon measuring individuals and measure aggregate effects.

**Lesson.** Productivity measurement is for improving systems, never for judging people. Using it for the latter destroys it for the former.
