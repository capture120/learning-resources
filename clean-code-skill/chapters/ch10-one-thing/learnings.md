# Chapter 10: One Thing

"Clean code does one thing well" (Stroustrup) is empty advice until "one thing" is defined. Martin's definition: **a function does one thing if you cannot meaningfully extract another function from it.** Everything in the chapter flows from this test and from the practice it implies — extract relentlessly, because small, well-named functions in a well-named structure reveal intent, expose hidden design, and are polite to the reader.

## The definition of "one thing"

> A function does one thing if you cannot meaningfully extract another function from it.

The logic is irrefutable: if you can split a function into two, the original did two things. So keep applying Extract Method until no meaningful extraction remains.

## What "meaningfully" rules out

You can extract too little and too much:

- **Too little**: extracting the entire body of a function, leaving a pure delegator (e.g. `addRental` calling `doTheAdd`), is pointless. (Rare exception: creating a delegator so you can move the extracted function to a new module.)
- **Too much**: splitting `clearTotals()` (two assignments) into `clearAmount()` and `clearPoints()` produces names indistinguishable from their implementations.

A meaningful abstraction follows **The Stepdown Rule**: the name of a function must be more abstract than its implementation. If the name adds no abstraction over the body, the extraction was not meaningful.

## Extract till you drop!

Consider every possible extraction; you may not perform them all, but think about each one. The result is mostly small functions of a few lines — three, four, six. Exceptions exist: certain `switch` statements, formatting code, and certain languages legitimately produce longer functions.

Typical extractions: the bodies of `if`/`else` and `for`/`while` statements, and the predicates inside them, until control statements are little more than keywords plus function calls that read like well-written prose:

```java
if (shouldDeleteRecord(r))
    deleteRecord(r);
```

## Answering the five objections

This is the most controversial recommendation from the first edition. Martin addresses each fear:

1. **Drowning in tiny functions** — There is no "sea" of functions; namespaces and classes are named, hierarchical cubbyholes. Well-named functions tucked into a well-named hierarchy become guideposts that let other programmers locate and understand code. Knowing a 3,000-line function "geographically" only works for its author; a newcomer needs `setScalingOnX` in an `Axis` namespace, not the third indent after the big comment block.
2. **Obscured intent** — The opposite happens: a well-designed, well-named structure of namespaces, classes, and functions reveals intent. Extraction moves low-level detail out of the way so high-level intent stands alone.
3. **Performance** — Function calls cost nanoseconds now. The fear is real only in nanosecond-critical domains (first-person shooters, high-speed trading, missile guidance). Elsewhere it is irrelevant; if measurement shows a slowdown, inline the critical functions — and good compilers will often inline single-caller functions for you.
4. **Bouncing around** — Valid only if functions are scattered rudely. Order extracted functions in the order they are called: if A calls B and C, the file reads A, B, C (in languages like Clojure, C, B, A). The reader then scrolls down from high level to low level, never hunting.
5. **Entanglement** — The most reasonable objection (John Ousterhout's point). An extracted lower-level function may not be understandable without the higher-level one. **If entanglement is severe** — several facts established by the parent must be held in mind while reading the child — **the extraction may not be worth doing.** If entanglement is minimal, the descriptive name plus placement directly after the parent likely makes it worthwhile. It's a judgment call. Choose wisely.

## Every large function is really hiding a class (or more) inside it

A large function has a set of local variables and indented regions that manipulate them. Promote the locals to instance variables (yes, deliberately trading away some encapsulation to enable extraction), extract the indented regions as methods, and you discover: a bunch of methods manipulating a shared set of variables *is a class*. Extraction is how you find the classes buried in big functions.

## Extraction reveals misplaced code and wrong names

When you extract small methods, you can see which ones never use the fields of their own class — a sign they belong elsewhere (in the Video Store example, the `determine` functions belonged in `Rental`, not `Customer`). After moving them, the `Customer` class turned out to be about formatting statements, so it was renamed `RentalStatement`. "When you clean things up, you see things that were hidden before." Note the legitimate exception: `formatDetail` stayed in `RentalStatement` despite using no fields, because formatting is that class's responsibility — cohesion of purpose can outrank field usage.

## Switch statements breed; prefer polymorphic dispatch

"Switch statements are like gerbils — given enough time they'll reproduce all over your code." When a `switch` dispatches on a type code, consider replacing it with a polymorphic type hierarchy — *consider*, not always: Chapter 12 weighs the pros and cons of `switch` statements. In the Video Store, a `RentalType` interface with `NewReleaseRental`, `ChildrensRental`, and `RegularRental` encapsulated each type's business rules, formed an architectural boundary, and let new types be added without changing existing code — the **Open–Closed Principle (OCP)** at work.

## Polite code versus rude code

Extracted, well-named code is *polite*: the reader sees a simple statement of policy with directions pointing to answers, instead of decoding strings, variables, loops, and `if`s. By that measure the unextracted original was rude — a newcomer can only fumble through a 3,000-line morass. Write for the reader who has never seen the code.

## Tests should tolerate change

In redesigning the Video Store tests: don't test through volatile UI strings many times (test the format once; test computed values elsewhere); don't use production-like data (`Fred`, `The Cell`) — test data should explain the intent of the test; tighten wordy tests with shared variables and composed assertions. When a fundamental design change later left the tests passing unchanged, that proved "the tests have a design that tolerates change."

## Extracted functions may communicate through enclosing scope

Rather than threading arguments through every extracted function, it can be cleaner to let them share variables in the scope that contains them — class fields in Java/Go, `let`-bound closures in Clojure. Caveat: shared *static* variables can be corrupted under multithreading; use instance variables (or closures, which avoid the problem entirely).

## Size is preference; the insight is not

Whether you settle at 4-line or 20-line functions is a matter of style. But it was extraction that exposed misplaced code and hidden classes in the Video Store. If you prefer larger functions, don't miss those opportunities: **extract first, then do strategic inlining** once you've determined where everything belongs. And remember: **when you inline a function, you destroy its name.**

## In practice

- For each function you write or touch, ask: can I meaningfully extract another function from it? If yes, it does more than one thing.
- Extract the bodies and predicates of `if`/`else` and loops until control flow reads like prose.
- Reject extractions that leave a pure delegator or produce a name no more abstract than its body (The Stepdown Rule).
- Before extracting, gauge entanglement: if the child needs several facts from the parent to be understood, reconsider.
- Order functions in call order so the file reads top-down, high level to low level (the order reverses in languages like Clojure).
- When a function is large, look for the class hiding inside it: promote locals to fields, extract methods, then split out the class.
- After extracting, check which methods don't use their class's fields — move them to the class whose data they use, and rename classes whose responsibility has shifted.
- Replace type-code `switch` statements with polymorphic dispatch when they start to multiply.
- Don't avoid extraction for performance except in measured, nanosecond-critical code; inline selectively afterward if needed.
- Keep test data intent-revealing, not production-realistic, and test volatile formatting exactly once.
- If you choose larger functions, extract first to discover structure, then inline strategically — knowing inlining destroys names.
