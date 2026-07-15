# Chapter 2: How to Work Well on Teams

*Software Engineering at Google* — written by Brian Fitzpatrick.

## Chapter Thesis

Software development is a team endeavor, not a solo craft. The chapter argues that the biggest obstacle to effective engineering is not technical skill but human insecurity: engineers hide their in-progress work out of fear of judgment, chase the fantasy of solo genius, and thereby take on enormous, avoidable risk. The fix is to reorganize your behavior around three core principles — humility, respect, and trust — and to build working habits (early sharing, fast feedback, blameless failure analysis) that treat collaboration as the default rather than the exception.

## Core Principles and Ideas

### Insecurity is the root symptom

Engineers commonly ask for ways to hide unfinished work (hidden branches, private-until-ready projects, wiped history). The common theme behind these requests is insecurity: fear of being judged on work in progress. The chapter treats this insecurity as a symptom of a larger problem in how engineers think about their work.

### The Genius Myth

The Genius Myth is the human tendency to ascribe a team's success to a single person or leader. Linus Torvalds is credited with Linux, but he wrote only the beginning of a proof-of-concept kernel; Linux itself is the collective labor of thousands of contributors, and Torvalds's real achievement was leading and coordinating them. The same pattern holds for Guido van Rossum and Python, Bill Gates and Microsoft, Steve Jobs and the Macintosh, and even Michael Jordan, whose championships depended on the team Phil Jackson built around him.

Key corollaries:

- Actual geniuses are extremely rare, and even genius is not enough — geniuses still make mistakes, and brilliant ideas do not guarantee successful software.
- Being a genius is not an excuse for being a jerk; anyone with poor social skills is a poor teammate.
- Most work does not require genius-level intellect, but 100% of the work requires a minimal level of social skill. Collaboration ability, not raw brilliance, makes or breaks a career.
- The Genius Myth is itself another manifestation of insecurity: programmers hide early work because visible mistakes would reveal they are not geniuses.

### Hiding is harmful

Working alone in secret ("hiding in a cave until the code is perfect") increases the risk of failure and stunts growth. Specific mechanisms:

- **Early detection.** Fundamental design mistakes are easy to make early. Hiding forfeits early feedback, risks reinventing existing solutions, and delays discovering you are on the wrong track. The more feedback you solicit early, the lower this risk. Mantra: "Fail early, fail fast, fail often." (Caveat from the chapter: too much feedback too early can be harmful if you are still unsure of your general direction.)
- **The bus factor.** The bus factor is the number of people who would need to be hit by a bus before a project is completely doomed. If only one person understands the code, the project dies when that person leaves (marriage, moves, departures, family leave — not just buses). Raise the bus factor by spreading knowledge: good documentation plus a primary and a secondary owner for each area of responsibility. It is better to be one part of a successful project than the critical part of a failed one.
- **Pace of progress.** Programmers work best in tight feedback loops — write a function, compile; add a test, compile — rather than writing 10,000 lines and compiling once. The same principle applies at the whole-project level: teams provide the rapid feedback that keeps a project relevant as requirements, environments, and politics shift. This is the "shift left" idea from DevOps: the earlier a problem is found, the cheaper it is to fix. A sharpened version of the classic quote: "Many eyes make sure your project stays relevant and on track." People who work in caves emerge to find the world has changed and their project is irrelevant.

Bottom line: working alone is inherently riskier than working with others. Fear of idea theft or of looking unintelligent should worry you far less than wasting huge amounts of time on the wrong thing.

### It's all about the team

Lone craftspeople are extremely rare, and even they do their world-changing work through a spark of inspiration followed by a heroic team effort. Almost no widely used, successful software was truly written by one person. A great team makes brilliant use of its superstars, but the whole is always greater than the sum of its parts. High-functioning teams are the true key to success.

### The Three Pillars of Social Interaction

The foundation of all healthy interaction and collaboration:

1. **Humility.** You are not the center of the universe, and neither is your code. You are neither omniscient nor infallible, and you are open to self-improvement.
2. **Respect.** You genuinely care about the people you work with, treat them kindly, and appreciate their abilities and accomplishments.
3. **Trust.** You believe others are competent and will do the right thing, and you are OK letting them drive when appropriate.

A root-cause analysis of almost any social conflict traces back to a lack of humility, respect, and/or trust.

### Why the social game matters

Relationships always outlast projects. Investing in relationships is not manipulation; it is how you get things done, because coworkers with whom you have rich relationships will go the extra mile when you need them. Richard Hamming's lecture illustrates this: small ongoing kindnesses to support staff paid off when he urgently needed help that no process would have delivered.

### "You are not your code"

Criticism in a professional engineering environment is almost never personal; it is part of making the project better. The essential distinction is between constructive criticism of someone's creative output and an attack on someone's character. Self-worth must be decoupled from the artifacts you produce. You need to believe this yourself and help your coworkers believe it too.

### Failure is an option

If you never fail, you are not being innovative enough or taking enough risks. Failure is a learning opportunity — but repeating the same failure over and over is not failure, it is incompetence. Google X (the "moonshot" division) builds failure into its incentives: coworkers are rewarded for disproving outlandish ideas as fast as possible at the whiteboard, and only ideas that survive all attempts at debunking proceed to prototype.

### Vulnerability increases status

The more open you are to influence, the more you can influence others; the more vulnerable you appear, the stronger you appear. Admitting a mistake or saying "I don't know" demonstrates humility, accountability, and trust in others' opinions, and earns respect over the long run. Politicians never admit error because they face constant attack — but teammates are collaborators, not competitors, so the defensive posture is unnecessary. Stubborn people who cannot be influenced end up "routed around" by their teams like an obstacle.

## Actionable Guidance

- **Share early.** Show work in progress to get design flaws caught in the first week rather than after months of secret effort.
- **Raise the bus factor.** Document each area of responsibility and assign both a primary and a secondary owner.
- **Work in tight feedback loops** at both the code level (compile constantly, test early) and the project level (continuous team feedback on direction).
- **Office design.** Neither private offices (too isolated) nor giant open floor plans (so public that nobody talks) work well. The middle ground is best: group four to eight people in small rooms so spontaneous conversation is easy and non-embarrassing. Pair this with interruption-management conventions — a vocal protocol (say "Breakpoint Mary"; Mary either turns around or says "ack" and you come back later), tokens or stuffed animals on monitors, or headphones as a do-not-disturb signal. Headphones-only mode all day is as bad for collaboration as a walled office.
- **Lose the ego.** Don't need the first or last word on every subject; don't comment on every detail of every proposal. Aim for a "collective" ego — team accomplishment and group pride — like the Apache Software Foundation communities that reject self-promoters. Humility is not being a doormat; self-confidence is fine, being a know-it-all is not.
- **Give criticism constructively.** Introduce practices like code review with buy-in, not by surprise (see the "Joe" story). Frame feedback with humility, about yourself rather than the other person: not "You got the control flow wrong; use the standard xyzzy pattern like everyone else" but "I'm confused by the control flow here — would the xyzzy pattern make this clearer and easier to maintain?" Avoid the antipatterns of declaring someone "wrong," demanding change, and implying they are stupid. Leave room for the other person to peacefully reject the suggestion.
- **Take criticism gracefully.** Trust that the reviewer has your and the project's best interests at heart. Programming improves with practice like any skill; a critique of your code is not a verdict on your worth.
- **Run blameless postmortems.** Document failures with a root-cause analysis. A postmortem is not a list of apologies, excuses, or finger-pointing; it must state what was learned and what will change. Make it accessible and follow through. A good postmortem includes: a brief summary of the event; a timeline from discovery through investigation to resolution; the primary cause; impact and damage assessment; action items with owners to fix the problem immediately; action items to prevent recurrence; and lessons learned. "Don't erase your tracks — light them up like a runway for those who follow."
- **Learn patience and adapt working styles.** When collaboration styles clash (e.g., a bottom-up debugger paired with a top-down debugger), invent a new way of working together rather than giving up (see the Karl story).
- **Be open to influence.** Let others change your mind when they present new evidence; listen before staking out a position so you don't seem wishy-washy by reversing later. Choose battles carefully.
- **Admit ignorance.** Sometimes the best thing you can say is "I don't know."
- **Define culture expectations explicitly.** Google's vague term "Googley" drifted toward meaning "is just like me," a source of unconscious bias in hiring and reviews. Google replaced it with an explicit rubric of behaviors: thrives in ambiguity; values feedback; challenges the status quo; puts the user first; cares about the team; does the right thing. The lesson: always be specific about behavioral expectations rather than relying on undefined culture-fit terms.

## Chapter TL;DRs (verbatim from the book)

- Be aware of the trade-offs of working in isolation.
- Acknowledge the amount of time that you and your team spend communicating and in interpersonal conflict. A small investment in understanding personalities and working styles of yourself and others can go a long way toward improving productivity.
- If you want to work effectively with a team or a large organization, be aware of your preferred working style and that of others.
