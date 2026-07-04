# Chapter 21: Continuous Design

Design is not a phase that happens before coding; the code itself is the design (Jack W. Reeves), and every line you add or change alters it. Continuous design means treating every code change as a conscious design decision, judged against four criteria — Clarity, Conciseness, Confirmability, Cohesion — so that each choice minimizes the cost of all future choices.

## Code Is the Design, and It Changes Continuously
"Design" classically means two things: the plan for building something, and the form and functionality exuded by the current state of that something — continuous design covers both at once. Software is thousands of small behaviors (units) implemented as code; the system's design is the accumulated set of choices made so far. The primary building blocks are few — modules (classes), functions (methods), data references (variables), and statements/expressions; the first three can be named, giving humans a better chance of understanding what concepts exist in the codebase and of finding the code to change. How we manage and organize these building blocks *is* the activity of software design. There are infinite ways to write any behavior and most are suboptimal. Each design choice impacts the cost of future choices — "We succeed only if we minimize the negative design impact of each choice." Attending to design continuously is easier than producing up-front models and pretending design is finished.

## The Four Cs of Continuous Design
A memorable rule set (the author's self-deprecating "YADP: Yet Another Design Perspective") that complements SOLID, code smells, simple design, design patterns, Law of Demeter, and Tell-Don't-Ask:
- **Clarity**: every programmer intent in the system is clearly stated.
- **Conciseness**: intents are implemented in a minimal amount of code.
- **Confirmability**: every unit behavior can be easily tested, with tests serving as "living documentation" of behavioral choices.
- **Cohesion**: each module's elements maximally relate to one another.

The Cs intertwine and sometimes oppose each other (e.g., increasing clarity might reduce conciseness). Unclean code makes it harder to find code, understand where to change it, change it without defects, and test it.

## Clarity: If Others Can't Make Quick Sense of It, It's Broken
Getting code working is step one, never the end. You will read the code again — in a half hour, or when extending it, or when asked what it does — and "anything unclear wastes time." The mantra "If it ain't broke, don't fix it" is lame and misapplied: "If other people can't make quick sense of your code, it is broken." Like a badly written book that forces rereading, hard-to-parse code is defective even when it runs.

## Edit Your Code Like a Writer
Programmers are writers; others must consume what we write. After getting code working, spend a few moments editing the first-draft "spewage" for clarity before moving on — that's caring about teammates (and your future self). Most code shows that we're never taught to edit (high "WTFs per minute"). Fearing to make changes to your code is a quality smell; tests (Chapter 14, "Testing Disciplines") give the controls that report instantly whether a tiny change broke working logic.

**Quick Steps to Clarity:**
- Extract implementation detail from multipurpose functions into new functions with concise, intention-revealing names.
- Move functions to more appropriate modules — this raises cohesion and puts code where readers expect it.
- Replace comments with clear declarations.
- Write tests that double as documentation of every behavioral intent.

## Declare Intent, Don't Ooze Details
Top-level functions should read as statements of policy, with details hidden in small named helpers (one to three lines each). A policy-level function can be understood in ~15 seconds; details you don't need to change are details you can ignore, maybe forever. Even short idiomatic phrases (a `map`/`join` one-liner, a ternary) demand careful token-by-token assembly and harbor small defect risk — an off-by-one `<=` in a loop header looks idiomatic and slips past readers. Prefer functional pipelines over procedural loops, and name even tiny inline lambdas so the pipeline reads as abstracted flow rather than stepwise detail. Don't eliminate idioms unless they bring readers to a grinding halt; if one does, abstract it behind a named function.

## Conciseness: Elegant, Not Clever
Maximal conciseness without clarity is obfuscation (legitimate only for deployment compression/security or entertainment). Balance conciseness against clarity by asking teammates — watch them read your code; their struggle is your signal. Comments on self-explanatory statements only add development, comprehension, and maintenance cost. "We don't seek clever code; we instead seek elegant code. Elegant code says exactly what it needs, without too few or too many words."

## Code Duplication: Once and Only Once
Conciseness means implementing each concept once and only once. Hunt duplicate implementations of *concepts*, not incidentally similar lines — don't obsess over two lines that happen to look alike. Duplication multiplies costs: reading, searching (wading through irrelevant results), testing, finding all points of change, the risk of missing one, analyzing whether variances are deliberate or defects, changing, refactoring, and propagating defects in the copied code. Eliminating duplication usually means replacing concrete details with abstractions — a win across all four Cs. **Extract-and-move** is the trustworthy workhorse: identify a clump of detail representing a singular concept, extract it to a function, then move it to the right module. New modules attract more related behavior, raising cohesion further.

## Conciseness Nits
- **Return boolean expressions** directly instead of `if (cond) return true; else return false`. The author rarely calls anything flat-out wrong in programming; this is one of those cases.
- **Unnecessary else**: after a conditional return, drop the `else`; an early return suffices. Braces on a short single-line `if` are overprotective clutter (though team standards may insist). A ternary is fine; aesthetic objections accepted.
- Idiomatic code "isn't obvious the first time you see it" — but like riding a bicycle, once learned it's read as a single chunk. Learn the most concise representation of common concepts in your language.

## Confirmability: Tests Make Change Safe
Without knowing what code is intended to do, any change is unsafe. Thousands of small, fast unit tests reveal regressions within seconds. Higher-level tests (end-to-end, performance, load, contract) are still needed, but moving fast requires tests around the unit implementations — integration tests are costlier, slower, can't realistically cover all logic variants, and make defects harder to pinpoint when they fail.

## Fear Degrades Design
Lacking fast test feedback, developers fall back to "it ain't broke, don't fix it," slap out first drafts without editing, and the codebase degrades by definition. Fear-driven coding teaches developers to do the worst possible thing to a system rather than the best thing they know. "Fear significantly increases code duplication and costs."

## Small, Isolated Units Imply Simple Tests
Large conflated functions are daunting to test, and incomplete coverage of their nuances ships defects. Extract conceptual units into small functions and cohesive modules: controllers reduce to policy declarations coverable by a couple of end-to-end tests, while extracted calculation modules get fast, trivial unit tests. Tests then give the confidence to fearlessly refactor further. A refactoring may grow one function's line count while shrinking the module overall — judge at module scope.

## Test First; Coverage Mandates Backfire
Writing tests after the fact is harder because untested code lacks clarity, cohesion, and conciseness, and contains deep (often private) dependency chains demanding setup effort and reshaping for injection. Coverage mandates are self-fulfilling prophecies: mandate 75% and you get exactly that — leaving the untested quarter, typically the most complex code, as a blob of "who really knows what this stuff does." Instead, start with a test for each new behavior: the test's name summarizes the behavior (making it findable), its code pins down the interface design, and complete coverage of every designed behavior follows naturally. Mandates are a bad idea; the coverage number is never what's important — what matters is that developers are sold on the value of delivering software they know works.

## Cohesion: One Purpose per Module
Cohesion is how well a module's elements align to the same purpose — it says the same thing as the Single Responsibility Principle (SRP), minus some nuances. Code can pass clarity, conciseness, and confirmability and still fail cohesion, e.g., conflating domain logic with its storage mechanism. Hide implementation specifics behind an abstract interface (add/get/deleteAll, exporting nothing that betrays the underlying data structure) so the implementation can change without touching other modules. Cohesive design from the start is easier to build and ready for change, instead of forcing you to "prefactor" code before a change fits.

## Design Is Omnipresent
Design awareness pervades every development activity, not just production coding:
- **Up-front design**: summary diagrams of the current design plus speculative sketches for new behaviors are fine — as a starting point, not a finished phase. Estimates are a design consideration: you must know how much the current design *resists* a feature (ideally zero, if the four Cs held). Estimates feed back into scope decisions.
- **Readying for work**: digging into feature specifics with product people reveals hidden complexity — what seems trivial to them may be very difficult to fit into the existing design.
- **Starting work**: decompose features into small behavioral slices deliverable in hours or days; slicing requires design awareness and may spur design discussion.
- **Doing work**: write a test to drive in each unit behavior — the test is the primary mechanism for designing and documenting the system's interface. Make it pass, then edit for clarity, conciseness, and cohesion before the next test. Ship when all behaviors are tested and passing.

## In practice
- Treat every change, however small, as a design decision; ask what it does to the cost of future changes.
- After making code work, edit it before moving on: extract intention-revealing helpers, move them to the right module, delete comments made redundant by clear names.
- Keep top-level functions as policy declarations readable in ~15 seconds; push detail into one-to-three-line named functions.
- Name inline lambdas in pipelines; abstract idioms only when they stop readers cold.
- Return boolean expressions directly; drop unnecessary `else` after a return.
- Eliminate duplicate implementations of concepts via extract-and-move; ignore incidental line-level similarity.
- Write the test first for each new behavior; let tests document intent and pin the interface design.
- Never treat a coverage percentage as the goal; treat fear of touching code as a smell to fix with tests.
- Keep modules cohesive: separate domain logic from persistence and other concerns behind abstractions that don't leak the implementation.
- Check work against the four Cs — Clarity, Conciseness, Confirmability, Cohesion — and expect trade-offs among them.
