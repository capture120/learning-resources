# Chapter 15 Examples: Write The Comments First

This chapter contains no code listings or named case studies (no RAMCloud/HTTP-server/text-editor walkthroughs). Its concrete material consists of behavioral scenarios, a step-by-step workflow, a measurement technique, and a back-of-the-envelope cost calculation. Each is captured below.

## The procrastinating developer (composite anecdote)

**Design problem:** When should documentation be written during development?

**Bad approach:** Nearly every developer Ousterhout has met defers comments to the end, after coding and unit testing. The stated rationale: "the code is still changing — writing docs early means rewriting them later, better to wait until the code stabilizes." The unstated rationale: documentation feels like drudge work, so it gets pushed off.

**What actually happens:** Delay compounds. The code will be "even more stable in a few more weeks," so the backfill keeps slipping. By the time the code has inarguably stabilized there is a lot of it, making the documentation task huge and even less attractive. There's never a convenient time to stop for a few days and fill in missing comments; it's easy to rationalize that fixing bugs or shipping the next feature serves the project better — which creates even more undocumented code. Even when a developer does go back ("don't fool yourself: you probably don't"), they've checked out mentally: the code feels done, they want it over with, so they make one quick pass adding just enough comments to look respectable. Memories of the design process are fuzzy by then, so they write comments while staring at the code — producing comments that repeat the code and miss the unrecoverable design ideas, the most important things comments should describe.

**Lesson:** Delayed comments are bad comments (Section 15.1). The end-of-project pass structurally cannot produce good documentation, regardless of the developer's intentions.

## Ousterhout's comments-first workflow for a new class

**Design problem:** How to integrate documentation into design so neither suffers.

**Good approach — the concrete procedure he uses:**

1. Write the class interface comment first.
2. Write interface comments and signatures for the most important public methods, leaving every method body empty.
3. Iterate over these comments until the basic structure feels about right.
4. Write declarations plus comments for the most important instance variables.
5. Fill in the method bodies, adding implementation comments as needed.
6. While writing bodies, new methods and instance variables get discovered. For each new method, write the interface comment before the body; for each new instance variable, fill in the comment at the same time as the declaration.

**Outcome:** When the code is done, the comments are also done — never a backlog of unwritten comments. Comments written this way are better because key design issues are fresh in mind, and writing each method's interface comment before its body lets you focus on the abstraction without being distracted by implementation. Problems noticed during coding and testing get fixed, so comments improve over development.

**Lesson:** Comments-first makes documentation a byproduct of design rather than a tax after it (Section 15.2).

## Comments as a complexity gauge: judging method depth

**Design problem:** How do you objectively tell whether an interface is simple or complex, or whether a method is deep or shallow (the Chapter 4 ideal: simple interface, powerful functionality)?

**Technique:** Use the comment as the measuring instrument — "a canary in the coal mine of complexity":

- If the interface comment gives all the information needed to use the method *and* is short and simple, the interface is simple.
- If there is no way to describe the method completely without a long, complicated comment, the interface is complex.
- Compare the interface comment against the implementation: if the comment must describe all the major features of the implementation, the method is shallow.
- Same test for variables: if a variable takes a long comment to fully describe, you may have chosen the wrong variable decomposition.

**Caveat built into the example:** The gauge only works if comments are complete and clear. An interface comment that omits information needed to invoke the method, or is too cryptic to understand, measures nothing.

**Lesson:** Writing comments early lets you evaluate design decisions before implementation exists, so you discover and fix abstraction problems cheaply (Section 15.3, and the "Hard to Describe" red flag).

## The back-of-the-envelope cost calculation

**Design problem:** The strongest objection to comments-first: writing comments early means reworking them as code evolves, wasting time.

**The calculation:** Estimate the fraction of total development time spent physically typing code and comments together, including revisions — unlikely to exceed about 10%. Even if half of all code lines are comments, comment-writing accounts for at most about 5% of total development time. Delaying comments to the end saves only a fraction of that 5% — not much.

**The counter-saving:** Comments-first stabilizes the abstractions before coding begins, which probably saves time during coding. Code-first lets abstractions evolve as you code, requiring more code revisions than the comments-first approach. Considering all factors, comments-first might be faster overall.

**Lesson:** The cost argument for delaying comments doesn't survive arithmetic; the supposed savings are tiny and may be net negative (Section 15.5).

## Comment simplicity as a design fitness function (the "fun" framing)

**Context:** Ousterhout describes his own practice during the early design phase of a new class — for him the most enjoyable part of programming. Most of his comments are written in this phase, and the comments are how he records and tests the quality of his design decisions.

**The practice:** He hunts for the design that can be expressed completely and clearly in the fewest words. The simpler the comments turn out, the better he feels about the design; finding simple comments is a source of pride.

**Lesson:** Under strategic programming (Chapter 3: goal is a great design, not just working code), comment-writing becomes fun because it is the mechanism by which you identify the best designs (Section 15.4).
