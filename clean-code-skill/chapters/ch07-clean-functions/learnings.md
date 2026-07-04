# Chapter 07: Clean Functions

Functions are the first line of organization in any modern program. A clean function is very small, does one thing at one level of abstraction, and reads like well-written prose — and it has five attributes Martin names PINCH: Pure, Insulated, Nameable, Contextual, Homogenous.

## Small!

Functions should be very small — a dozen lines or less. Martin reports six decades of trial and error: from 3,000-line "abominations" to 100–300 lines, to 20–30, to a dozen or less. The idea is old: in the eighties the common rule was "no bigger than a screenful," which on a VT100 with editor overhead meant about twenty lines. Small functions with descriptive names are transparently obvious; each tells a story and leads to the next in a compelling order.

## Well-Written Prose

Blocks inside `if`, `else`, and `while` statements should be one or two lines long, usually a call to another well-named function. The function name flows with the keyword (`if (employee.shouldBePaidToday()) employee.pay();`), so control structures read like prose and the call adds documentary value. Small functions also can't hold deep nesting, so indent level should seldom exceed one or two.

**Exception the author insists on:** this is not a hard-and-fast rule and can be overdone. Some functions read better when not decomposed into four-line pieces — but those are exceptional cases. In general, small is the best strategy.

## One Level of Abstraction per Function

All statements in a function must sit at the same level of abstraction. Mixing high-level concepts (looping over rentals) with low-level details (`frequentRenterPoints++`, price arithmetic) is usually confusing: readers may not be able to tell whether an expression is an essential concept or a detail. Worse, like broken windows, once details mix with essentials, more details accrete.

## The Stepdown Rule

Code should read like a top-down narrative: every function is followed by those at the next level of abstraction, so the program reads from top to bottom, descending one level at a time. Each function's lines are one level of abstraction below its name. In the '70s and '80s this was called functional decomposition, an important part of the structured programming discipline.

Refactoring is how you get there: first drafts are naturally depth-first dives through abstraction levels. Once it works, extract the levels into nicely named functions. **"First, make it work. Then, make it right."**

## Entanglement (the Ousterhout objection)

Two functions are entangled when understanding one requires understanding the other; John Ousterhout objects that decomposition can create entangled small functions and would rather merge them. Martin concedes the point but weighs the cost differently: he tolerates a bit of entanglement so long as the functions step down one level of abstraction and lower-level functions appear after higher-level ones.

## Switch Statements

A `switch` (or `if/else` chain) is by nature large and does N things — and the same switch tends to be duplicated across many functions as new operations on the types appear. It violates the Single Responsibility Principle (more than one reason to change) and the Open–Closed Principle (must change for every new type).

Martin's general rule: a switch can be tolerated if it appears only **once**, lives in a concrete module like `main`, is used to **create polymorphic objects** (e.g., in an Abstract Factory), and is hidden behind an interface so the rest of the system can't see it.

## Contextual

Every function lives within a context: a cooperative grouping of functions and data structures with an external interface and an internal implementation (classes in OO languages, `.h`/`.c` files in C, or just conventions). It is the programmer's job to identify, create, and manage contexts. The public/private boundary expresses intent: public things are higher level and likely won't change very often; private things are lower level and likely will change frequently.

## Nameable — Descriptive

A function's name should describe what it does — a verb, verb phrase, or implicit verb (`Math.sign(x)`) — and be **slightly more abstract than the code inside**, hiding the implementation. `average` beats `addAtoBandDivideBy2`: callers know what to expect, and the implementation can change without the name changing.

More detailed contexts (e.g., methods of derived classes) require longer names to stay descriptive. A long descriptive name beats a short enigmatic name, and often beats a long descriptive comment. Use a naming convention like CamelCase, snake_case, or kebob-case so multiple words in a name read easily. Spend time on names: try several and read the code with each; IDEs make renaming trivial. Hunting for a good name often triggers a favorable restructuring. Recall Ward Cunningham's principle: "You know you are working on clean code when each routine turns out to be pretty much what you expected" — good names for small one-thing functions are half that battle.

## Nameable — Convenient

Convenience (short, memorable) trades off against descriptiveness. The heuristic: **the length of a function's name should be inversely proportional to the size of the containing scope.** Frequently called, large-scope functions deserve short names (`File.open`, not `openFileAndThrowExceptionIfNotFound`); narrow-scope private helpers can carry long names. The deeper down the function hierarchy, the longer names tend to get.

## Insulated

Insulation is Martin's term for what was once called low coupling or encapsulation — neither term seemed sufficient to him. Complexity means "more than one strand"; every argument and output is a coupling strand. Limit arguments — Martin prefers a limit of three where feasible. Fewer arguments mean less coupling and simpler calls. Zero-argument functions are easiest to call but only useful inside a context other functions have prepared (e.g., a finite state machine holding its own state). Past three arguments, ask why you aren't passing an object that encapsulates them — and whether the data and behavior should be split into separate contexts.

## Homogenous

All lines of a function must sit at the same abstraction level, one level below the name. If some lines are lower level than the rest, extract them into their own named function. Don't fear that the refactored version is longer or costs a few CPU cycles: the next maintainer's time has value — possibly a lot more than 50 nanoseconds.

## Pure

A pure function's behavior depends only on its arguments, and executing it changes the behavior of no other function. Advantages: it is a true mapping (replaceable by a lookup to trade speed for memory), far less susceptible to race conditions, easy to compose into networks, easy to test (no system state to set up or assert on), and easy to distribute across processors. The recipe: don't change variable values — "No Assignment Statements Ever!" Pure functions are immutable.

**The crucial nuance: purity is an external, observed characteristic, not an internal one.** A function full of loops, mutation, even mutable helper objects is still pure if no impurity is visible to any external observer (including other threads). This is exactly how functional languages claim purity — they hide impure implementations.

## Partial Purity

Because purity is observed, not intrinsic, a function can be pure relative to some observers. `fopen` is impure (it leaves a file open), but wrapping it as `openAndDo(name, fn)` — open, apply, close — restores the system state and looks pure to callers who don't inspect the file's contents. Use wrappers to confine side effects and present a pure face.

## In practice

- Keep functions to a dozen lines or less; keep indent depth to one or two.
- Keep every block inside `if`/`else`/`while` to one or two lines, usually a call to a well-named function.
- Hold every line of a function at the same abstraction level, one level below the name.
- Order functions so readers descend one abstraction level at a time (Stepdown Rule).
- Write the depth-first version to make it work, then extract levels to make it right.
- Replace repeated switch/if-else chains on a type with polymorphism; allow one switch only, in a low-level factory hidden behind an interface.
- Name functions with verbs slightly more abstract than their implementation; try several names; lengthen names as scope narrows, shorten as scope widens.
- Keep arguments to three or fewer; beyond that, pass an object or split contexts.
- Prefer pure functions; when side effects are needed, hide them behind boundaries so callers observe purity.
- Don't sacrifice readability for nanoseconds; the maintainer's time costs more.
- Allow rare exceptions: leave a function undecomposed when splitting genuinely reads worse.
