# Chapter 35 Examples: Estimate Honestly and Fairly

This chapter has no code examples. Its lessons come from anecdotes and one worked statistical technique.

### Healthcare.gov: the deadline written into law

The launch date for Healthcare.gov was mandated by legislation — the president signed a bill fixing the day the system had to go live. Nobody estimated that date; it was decreed. Martin calls the illogic "nausea inducing": when the end date precedes the estimate, every estimate produced to support it can only be a lie. Demonstrates the chapter's central claim that most estimates are dishonest because they are constructed backward from a known end date.

### "We really have to make that date"

About twenty years before writing, Martin consulted for a team whose young project manager (perhaps 25) returned agitated from a meeting with his boss and told the team, "We really have to make that date. I mean, we really have to make that date." The team rolled their eyes: needing to make a date is not a plan for making it, and the manager offered no solution. In such environments, estimates degrade into "lies that support the plan."

### The Laugh Track

Another client kept a huge software production plan on the wall, full of circles, arrows, labels, and tasks. The programmers nicknamed it "The Laugh Track." Martin offers it as another example of an environment where estimates are just "lies that support the plan."

### Story #1: Vectors — underestimating by 6x

In 1978 at Teradyne, 26-year-old Martin wrote 8085 assembler firmware for the COLT (Central Office Line Tester), a phone-company line tester whose 32K program was burned across thirty-two 1K ROM chips on three boards. Any one-line code change shifted every subroutine address after it, so all 32 chips had to be reburned, shipped worldwide, and swapped by field reps — chips whose pins bent and broke silently, making every redeploy a debugging ordeal. His boss asked him to make each chip independently compilable and deployable (vector tables, indirect calls, partitioning the program into sub-1K chunks — effectively turning each chip into a polymorphic object), then asked how long it would take.

Martin said two weeks. It took twelve. He was off by a factor of six. His boss didn't get angry — he saw Martin working daily and got regular status updates, so he understood the complexity. The story anchors the lesson that honest estimators must know how wrong they can be: when things go wrong, they can go very, very wrong.

### Story #2: pCCU — overestimating by 20x

In the early 1980s, Teradyne had promised the phone company a product called CCU/CMU, a full rearchitecture of their measurement technology for the new digital switching network (the phone company was harvesting its valuable copper wiring and replacing it with coax and fiber). The software was a known one-person-year job, but it kept getting deferred. Then Martin's boss discovered a small customer who had already installed an early digital switch and expected the promised CCU/CMU within a month.

Martin said a person-year of software in a month was impossible. His boss grinned: there was a way to cheat. The customer's installation was the smallest possible digital-switch configuration, and it happened to eliminate virtually all of the complexity the CCU/CMU existed to solve. Martin built a special-purpose, one-off unit — the pCCU — in two weeks: one twentieth of the expected time.

### The lesson of the two stories

Taken together, the two stories show the enormous spread real estimates can have: 6x too low on one job, 20x too high on another. Honestly, when things go wrong they go very wrong, and when they go right they can go very right. This is why an estimate can never honestly be a single date, and why estimates must be expressed as probability distributions.

### Worked technique: three-point estimation and PERT

The chapter's one formal "example" is the estimation math itself. For each task, estimate Best (B, 5% chance), Normal (N, 50%), and Worst (W, 95%). Then:

- sigma = (W − B) / 6
- Mu = (2N + (B + W) / 2) / 3  (weighted toward N, because projects go long more often than short)
- Project Mu = sum of task Mus; project sigma = sqrt of the sum of squared task sigmas.

This is PERT — the Program Evaluation and Review Technique, invented in the late 1950s to manage the Polaris Fleet Ballistic Missile program and used successfully on thousands of projects since.

### "Will you at least try?"

The closing vignette: a boss, failing to extract a commitment, asks "Well, will you at least try?" Martin supplies the internal answer: NO — I am already trying as hard as I can; there are no magic beans in my pocket with which to work miracles. You needn't use those words aloud, but that is what you should think. Saying "Yes, I'll try" when you have no plan to change your behavior is a lie told to end the conversation — "the most dishonest thing of all."
