# Chapter 35: Estimate Honestly and Fairly

An estimate is an honest statement of uncertainty, not a date and not a promise. The chapter's oath: "I will produce estimates that are honest both in magnitude and precision. I will not make promises without reasonable certainty." This covers estimating projects and large multi-day/multi-week tasks (not the Agile practice of estimating small tasks and stories, which Martin covers in *Clean Agile*). Estimating is an essential skill — every business needs to know roughly what something will cost before committing resources — yet most developers are very bad at it: it is not uncommon for estimates to be off by a factor of 2, 3, or even 4 or 5.

## Most estimates are lies

Most estimates are dishonest because they are constructed backward from a known end date. When the deadline is mandated first (Healthcare.gov's launch date was fixed by law), every "estimate" supporting it is fiction. Declaring "we really have to make that date" is not a solution for making the date. Estimates produced in such environments are "lies that support the plan." The landscape is littered with billions of dollars in software failures, often due to poor estimation; our failure to understand what estimates actually are, and how to create them, has led to an almost catastrophic loss of trust between programmers and businesses.

## Honesty, Accuracy, Precision

The most important property of an estimate is honesty. The most honest estimate is "I don't know" — but it lacks accuracy and precision, and you do know something. The job of estimation is to quantify what you do and don't know:

- **Accurate**: name a range of dates you are confident about. ("Between now and 10 years from now" is accurate for a hello-world program but lacks precision.)
- **Precise**: narrow that range only as far as your confidence allows. ("Yesterday at 2:15 a.m." is precise but probably not accurate if you haven't started yet.)

Never dare to be more precise than your knowledge supports. Brutal honesty is the only option for both operations.

## An estimate is a probability distribution, not a date

Real estimates can be off by a factor of 6 (too low) or 20 (too high), so a single date is far too precise to be honest. Every estimate is likely wrong; part of estimating is estimating how wrong you probably are. Express estimates as a distribution with a mean and a sigma (width).

## Three-point estimation (Best / Normal / Worst)

Martin's favorite technique: estimate three numbers per task.

- **Normal case (N)**: how long if the average number of things go wrong — ~50% chance of making this date.
- **Worst case (W)**: the Murphy's-law estimate; everything that can go wrong does — ~95% chance of making this date.
- **Best case (B)**: everything goes perfectly, no distractions — ~5% chance (one in twenty).

These three numbers sketch a probability distribution; that distribution *is* your estimate. Without certain knowledge, probabilities are the only logical way to estimate.

## Aggregation: PERT

To combine task estimates into a project estimate, use PERT (Program Evaluation and Review Technique), invented in the late 1950s for the Polaris missile program:

- Per task: sigma = (W − B) / 6; expected time Mu = (2N + (B + W) / 2) / 3. Mu lands between N and the midpoint (B + W)/2, weighted toward N — the midpoint typically lies well past N because projects go long far more often than they go short.
- Project Mu = sum of all task Mus. Project sigma = square root of the sum of squares of the task sigmas.

This is basic statistics, proven on thousands of projects.

## Estimates vs. commitments

If your estimate is a date, you are making a commitment, not an estimate — and a commitment you absolutely must keep. Sometimes commitments are necessary and managers have a right to ask for them; comply only if you are reasonably certain you can. Never promise a date you aren't sure you can make: that is deeply dishonest. If you don't *know* you can hit the date, offer a range with probabilities instead ("I can't promise Friday. It might take as long as the following Wednesday.").

## Communicating uncertainty and the cost of certainty

Honest estimating communicates your real level of uncertainty to those who must manage the project's risk. People dislike uncertainty, so customers and managers will press you to be more certain. The only way to truly increase certainty is to do parts of the project; perfect certainty requires doing the whole thing. Tell stakeholders the cost of increasing certainty. When asked to commit, recognize it for what it is: management trying to transfer their risk onto you. That's legitimate — but accept only when you can genuinely deliver.

## Saying no

It is critical to say no to commitments you are unsure of; saying yes anyway sets up a domino chain of failures for you, your boss, and everyone counting on you. Be willing to discuss options and workarounds — hunt for ways to say yes, never be eager to say no, but never be afraid to say no. You were hired for your ability to say no: anybody can say yes, but only people with skill and knowledge know when and how to say no, and doing so saves the company untold grief and money.

## Pressure and the word "try"

Managers may cajole you — accusing you of not being a team player or lacking commitment. Don't be fooled by those games; work with them on solutions, but don't be bullied into yes. Beware "Will you at least try?" The honest answer is no: you are already trying as hard as you can; there are no magic beans in your pocket. Saying "Yes, I'll try" with no plan to change your behavior is a lie told just to get rid of them — the most dishonest thing of all.

## In practice

- Never give a single date as an estimate; give a range (or Best/Normal/Worst) that reflects your actual confidence.
- Don't reverse-engineer estimates from a mandated deadline; call that out as a commitment, not an estimate.
- Quantify uncertainty: B (5%), N (50%), W (95%); compute Mu and sigma with PERT when aggregating tasks.
- Remember asymmetry: tasks run long more often than short; weight estimates accordingly, and expect errors as large as 6x or even 20x.
- Distinguish estimates from commitments. Commit only when reasonably certain; once committed, you must deliver.
- When pressed for certainty, explain that certainty costs work: only doing part of the project reduces uncertainty.
- Say no clearly when you can't promise, then immediately describe your uncertainty and explore workarounds.
- Never say "I'll try" as a way to end the conversation; it's a lie unless you have a concrete plan to change something.
