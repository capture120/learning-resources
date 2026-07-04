# Chapter 15: Write The Comments First (Use Comments As Part Of The Design Process)

## Central idea

Write comments at the *beginning* of the development process, as part of design — not at the end after coding and testing. Delaying documentation is one of the surest ways to produce poor documentation, and it forfeits the biggest benefit of comments: they are a design tool that exposes bad abstractions before you commit code to them.

## Key concepts

- **Delayed comments are bad comments.** Developers postpone documentation claiming "the code is still changing" (and, less admitted, because they see it as drudge work). Delay compounds: once you start delaying, it's easy to delay more; by the time the code is "stable" there is so much of it that writing docs has become a huge, unattractive task, and there's never a convenient time to stop and backfill. Result: the comments often never get written at all.
- **Even backfilled comments are low quality.** By the end, you've checked out mentally — the code feels "done" and you want to move on, so you make a quick pass adding just enough comments to look respectable. Your memory of the design process has gone fuzzy, you write comments while looking at the code, so the comments repeat the code and omit the most important design ideas — exactly the things comments exist to capture.
- **Comments-first workflow.** For a new class: (1) write the class interface comment first; (2) write interface comments and signatures for the most important public methods, leaving bodies empty; (3) iterate over these comments until the basic structure feels right; (4) write declarations and comments for the most important instance variables; (5) fill in method bodies, adding implementation comments as needed; (6) when body-writing reveals the need for new methods or instance variables, write each new method's interface comment before its body, and each new variable's comment at the same time as its declaration. When the code is done, the comments are done — there is never a backlog of unwritten comments.
- **Comments-first has exactly three benefits (the chapter's organizing claim).** (1) It produces better comments: key design issues are fresh in your mind while you design the class, so they're easy to record. (2) It produces better system designs — the second and *most important* benefit. (3) It makes comment-writing more fun. Each is expanded below.
- **Comments are a design tool (the most important benefit).** Comments provide the only way to fully capture abstractions, and good abstractions are fundamental to good design. Writing a good comment forces you to identify the essence of a thing: what are its most important aspects? Doing this early lets you review and tune abstractions before writing implementation code; skipping it means you are "just hacking code."
- **Comments as a canary in the coal mine of complexity.** If a method or variable requires a long comment, that is a red flag that you don't have a good abstraction. Recall Chapter 4: classes should be deep — very simple interfaces implementing powerful functions — and the comments describing an interface are the best way to judge its complexity. A short, simple interface comment that still gives all information needed to use the method indicates a simple interface. If a method *cannot* be described completely without a long, complicated comment, the interface is complex. Compare interface comment to implementation to measure depth: if the interface comment must describe all the major features of the implementation, the method is shallow. Same for variables: needing a long comment to fully describe a variable suggests a wrong variable decomposition.
- **Early comments are fun comments.** For Ousterhout, most comments get written during the early design phase of a new class — one of the most enjoyable parts of programming for him; comments are how he records and tests the quality of design decisions. Seek the design that can be expressed completely and clearly in the fewest words — simple comments are a source of pride. If you are programming strategically (goal: great design, not just working code), comment-writing should be fun, because it's how you identify the best designs.

## Actionable principles

- Write the class interface comment before anything else when starting a new class; then write public-method interface comments and signatures with empty bodies; iterate on these until the structure feels right.
- Write each method's interface comment *before* its body, even for methods discovered mid-implementation, so you focus on the abstraction and interface without being distracted by implementation details.
- Write each instance variable's comment at the same moment you write its declaration.
- Treat comment difficulty as a design signal: if a simple-yet-complete comment is hard to write, redesign the thing being described rather than writing a longer comment.
- Use the interface-comment-vs-implementation comparison to test method depth; restructure shallow methods whose interface comments must restate the implementation.
- Expect to fix and improve comments during coding and testing — comments-first means comments evolve with the code, ending better than a backfill pass would produce.
- Optimize designs for the fewest words needed to describe them completely and clearly.

## Nuances and counterpoints

- **"Early comments get reworked as code evolves, so they're expensive" — refuted by arithmetic.** Typing code plus comments (including revisions) is unlikely to exceed ~10% of total development time; even if half your lines are comments, comment-writing is at most ~5% of development time. Delaying saves only a fraction of that 5% — not much.
- **Comments-first may actually be faster overall.** Writing comments first stabilizes the abstractions before coding starts, probably saving coding time. Code-first lets abstractions evolve during coding, forcing more code revisions. Net: comments-first might win on total time, not just quality.
- **Comments only measure complexity if they are complete and clear.** An interface comment that omits information needed to invoke the method, or is too cryptic to understand, gives no valid measure of the method's depth. Don't game the canary by writing vague comments.
- **Don't trust your discipline to backfill.** Ousterhout's blunt warning: "don't fool yourself: you probably don't" have the self-discipline to go back and write comments later.
- The chapter ends with an invitation, not a mandate: try comments-first long enough to get used to it, then judge its effect on comment quality, design quality, and enjoyment.

## Red flags

- **Hard to Describe (explicit red flag).** The comment describing a method or variable should be simple and yet complete. If you find it difficult to write such a comment, there may be a problem with the design of the thing you are describing.
- A method or variable requiring a long comment — signals you don't have a good abstraction (long variable comment: wrong variable decomposition; interface comment that must cover all major implementation features: shallow method).
- Comments that merely repeat the code — a symptom of writing them at the end while reading the code.
- A growing backlog of undocumented code, or "I'll document once the code stabilizes" — delay compounds and usually ends in no documentation at all.
