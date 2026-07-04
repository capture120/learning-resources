# Chapter 09: The Clean Method

Clean code is produced by a disciplined working rhythm, not by talent: make a small bit of code work, then immediately make it right, in tight nested loops backed by fast trusted tests — never letting the mess grow too big to clean.

## First, make it work. Then, make it right.

Kent Beck's rule is the engine of the whole method. Most programmers are not particularly adept at keeping two goals in their head at once; the primary goal of making code work crowds out the secondary goal of making it right, so by the time code works it is also a mess. Don't fight that — accept it, and treat cleaning as a separate, deliberate step that happens *after* the code works. Skipping the second step because "good programmers should write right code the first time" is the standard self-deception that produces messes.

## Clean code depends on fast, convenient, and comprehensive tests

You will not clean code unless you can prove cleaning didn't break it. Without a test suite you can run quickly and implicitly trust, refactoring feels dangerous and gets skipped. The goal is never "clean code that doesn't work" — tests are the safety mechanism that makes the make-it-right step possible at all.

## The refactoring loop

Cleaning has its own tight loop: (1) clean one little thing, (2) run the tests, (3) if the tests fail, revert, (4) repeat. Each cycle takes five seconds to two minutes. Per Martin Fowler, refactoring is "a change made to the internal structure of software to make it easier to understand and cheaper to modify without changing its observable behavior." Note the revert step: when a small cleaning breaks tests, throw it away.

## The outer loop: alternate as often as possible

Nest the two loops: get something small to work (writing + testing), then when it starts getting messy, switch to the cleaning loop until it's clean, then go back. Transition between writing and refactoring as often as possible — on the order of minutes to an hour. Unless you are a "multitalented mega being," writing clean code means sitting patiently in this outer loop, cleaning up after yourself, never allowing the mess to get too big to clean. Be like the sushi chef who never stops making sushi and never stops cleaning the implements and the environment.

## The TDD way: watch the test fail first

Write the test, see it fail, then make it pass with the simplest (even degenerate) code. Seeing the failure first looks like a waste of time but saves large amounts of debugging time. TDD is not a magic bullet — you will still write bugs — but a growing suite of tests is likely to uncover them (the chapter's negative-tax bug was caught by a later test written for a different rule).

## Changing many tests means your test design is flawed

"Anytime you have to go back and change a bunch of tests, it means there's a flaw in the design of your tests." Fix the flaw before proceeding. The cure is to decouple tests from the production code's data structures and incidental details: use builder/factory helpers with sensible defaults, shared constants for recurring expected values, and composed assertion methods. Then new fields or rule changes require touching one helper, not every test.

## As the tests get more specific, the code gets more generic

Tests should grow linearly — each new test case makes the test class more specific. Meanwhile the production code evolves and morphs to become more generic: logic gets peeled off into separate classes and table-driven algorithms. This keeps the tests from knowing too much about the production code, so production changes ripple into few test changes.

## Tests are a second statement of intent

Martin is usually not in favor of letting tests know the details of the production code, such as reusing the same rate table. It makes little sense to use the production code to test the production code. So he prefers to compute expected values manually and enter them into the tests.

## Prefer tables over conditional chains for data that will change

When an if/elif chain encodes numbers you expect to change (rates, brackets, rows being added), replace it with a data table plus a small loop. Maintaining the chain is labor intensive and error prone; a table makes new rows trivial. Apply this to production code eagerly; make tests parametric/table-driven only when the need actually arises.

## Classes give complexity a named home (the "classitis" rebuttal)

Splitting a module into several small classes is not "classitis" (too many classes complicating the design) when the classes don't add complexity that wasn't already there — they just move it into nicely named places. "A place for everything, and everything in its place!" Classes also earn their keep as namespaces, as a way for methods to communicate through instance variables rather than arguments, and as a wall hiding internal data structures (the `TaxReturn` class hides the raw dict, so structure changes don't ripple outward).

## Step back and consider design and architecture

Periodically pause the loop and look at the shape of the whole module. Identify the axes of change — the independent reasons the system will be modified — and protect them with architectural boundaries. Use the Single Responsibility Principle (SRP) to separate them and the Dependency Inversion Principle (DIP) so every dependency arrow crossing the boundary points inward, toward high-level policy (the Dependency Rule). Lower-level details, including main, live outside; main creates the implementations and hands them to the high-level class, which uses the Strategy pattern to delegate to them. In dynamically typed languages, the "interfaces" can simply be duck-typed method signatures. Also remove smells like reciprocal (two-way) class relationships and asymmetric designs where one concern gets a class while a peer concern stays buried.

## Names improve as understanding grows

Rename tests, methods, and classes as you learn more about the domain. Name improvement is a normal, recurring refactoring, not a one-time act — and stay humble about your names; someone else may find better ones.

## In practice

- Work in the outer loop: make a small piece work, then immediately clean it; never batch up cleaning.
- Write the test first, watch it fail, then make it pass with the simplest code that works.
- Clean one little thing at a time; run tests after each; revert a failed cleaning step.
- Keep the test suite fast and trustworthy — without it you will stop cleaning.
- When a change forces edits to many tests, stop and fix the test design (builders with defaults, shared constants, composed assertions).
- Let production code grow generic (extracted classes, table-driven logic) while tests grow specific; avoid sharing data tables between tests and production code — prefer computing expected values by hand.
- Replace conditional chains over changeable numbers with data tables.
- Hide raw data structures behind accessor classes so structural changes don't ripple.
- Periodically step back: find the axes of change, apply SRP and DIP, draw boundaries with dependencies pointing inward, and wire details together in main.
- Keep improving names as your understanding of the domain deepens.
