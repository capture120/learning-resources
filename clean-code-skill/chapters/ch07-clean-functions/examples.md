# Chapter 07: Clean Functions — Examples

### Sparkle: programming with Kent Beck (1999)

Martin visited Kent Beck to see test-driven development (then "test-first programming") firsthand, as a skeptic. Together they built "Sparkle," a small Java/Swing program where sparkles dripped from the mouse cursor like the fairy godmother's wand in Cinderella, falling under simulated gravity. Martin was struck that every function was two to four lines long, descriptively named, transparently obvious — each told a story and led to the next in a compelling order. This experience, against his habit of Swing functions taking "miles of vertical space," drove home the value of very small functions. The anecdote anchors the chapter's central rule: **Small!**

### The video store `statement()` function (mixed abstraction levels)

A Go method builds a customer's rental statement in one long function: it loops over rentals (high level), switches on movie type to pick pricing rules (intermediate level), and does per-type price arithmetic and `frequentRenterPoints++` (low level), all interleaved with string formatting. Mixing the levels is usually confusing: readers may not be able to tell which expressions are essential concepts and which are details, and like broken windows, mixed-in details invite more details to accrete. It demonstrates violating "one level of abstraction per function." (The example comes from the Video Store case study explored fully in Chapter 10.)

### The Stepdown refactoring of `statement()`

The same logic refactored into a `RentalStatement` type whose top function reads as a complete summary:

```go
func (statement *RentalStatement) makeStatement() string {
    statement.clearTotals()
    return statement.makeHeader() +
        statement.makeDetails() +
        statement.makeFooter()
}
```

Below it come `clearTotals`, `makeHeader`, `makeDetails`, `makeDetail`, `formatDetail`, `makeFooter` — each containing lines exactly one abstraction level below its own name, each positioned after its caller. Reading top to bottom descends one level at a time: the Stepdown Rule in action. Martin notes the original messy version is what depth-first first drafts naturally look like; refactoring extracts the levels afterward. First make it work, then make it right.

### `determineAmount()`: the problematic switch

Extracted from the video store code, this function switches on movie type to compute the rental amount. Problems: it's bigger than desired and grows with every new movie type; it does N things; it violates the Single Responsibility Principle (multiple reasons to change) and the Open–Closed Principle (must be edited for new types). Possibly worst, it breeds clones — `determinePoints`, a future `applyCoupon` or `getAgeRestriction` would each repeat the same switch.

### Burying the switch in an Abstract Factory

The fix: one switch, hidden "in the basement" of a factory that maps a type name to a polymorphic `RentalType` instance (`ChildrensRental{}`, `NewReleaseRental{}`, `RegularRental{}`). This illustrates Martin's tolerance rule for switches: appear once, live in a concrete module, create polymorphic objects, stay hidden behind an interface.

### `addAtoBandDivideBy2` vs `average` (naming abstraction)

An absurd counter-example: `addAtoBandDivideBy2(a, b)` describes the implementation, not the intent. Renaming it `average` makes the name an implicit verb that hides the implementation — so when the function later expands to a variadic version using streams, the name needs no change. Names should be slightly more abstract than the code they label.

### `addSalesReceipt` in `CommissionedEmployee` (name length vs scope)

A one-line method carries a three-word name. Why? It lives in a derived class — a detailed, narrow context — and detailed contexts need more words to describe behavior. Contrast `File.open`: global scope, very general, so a short memorable name is right, and `openFileAndThrowExceptionIfNotFound` would be inconvenient; likewise plain `add` would be disconcerting for the receipt method. Anchors the heuristic: name length should be inversely proportional to scope size.

### The subway turnstile finite state machine (Insulated)

A turnstile FSM has states Locked/Unlocked, events Coin/Pass, and five actions (alarmOff, alarmOn, lock, unlock, thankyou). Events become a `TurnstileEvents` interface with zero-argument `coin()` and `pass()`; actions become a zero-argument `TurnstileActions` interface; the transition logic lives in an abstract `TurnstileFSM` class implementing both — abstract so the action functions can be implemented in a derived class, decoupling the machine's logic from the implementations of the actions. The running system knows only `TurnstileEvents` — it is completely decoupled from states, logic, and actions, which live behind a strong insulation barrier. Demonstrates that zero-argument functions work because the context (the FSM's private state) is prepared for them, and that limiting arguments at context boundaries keeps coupling very low.

### `orientation()` → `getChirality()` (Homogenous)

A geometry function computes whether traveling a→b→c turns left, right, or not at all. The original mixes one appropriately-abstract line (the cross product) with four lower-level lines that extract its sign. Step one: pull the four lines into a `sign(n)` helper, making both lines of `orientation` homogenous. Step two: improve communication — introduce a `Chirality` enum (left, right, none) replacing the error-prone −1/0/+1 returns, and name the parts `crossProduct` and `chirality`:

```java
public static Chirality getChirality(Point a, Point b, Point c) {
    return chirality(crossProduct(a, b, c));
}
```

The result is twice as long as the original and costs a few CPU cycles more. Martin's verdict: if you desperately need to save 50ns, trim it — but the maintainer's time is worth possibly far more than the 50ns costs you.

### The four `sigma` implementations (purity is external)

Four versions of a standard-deviation function, each progressively "more impure" inside: (1) functional-style with only initializations; (2) the same with declarations split from true assignments; (3) a traditional loop mutating `variance` in place — Martin's favorite, "just nice, straightforward code"; (4) delegation to a mutable `SigmaCalculator` object with instance variables mutated freely. Every version is pure, because no mutation is visible to any outside observer. The lesson: purity is an external characteristic, not an internal one — exactly how functional languages claim purity while hiding impure implementations.

### `fopen` and `openAndDo` (Partial Purity)

C's `fopen` is impure: it leaves a file open, so `fgetc`/`fputc` misbehave without it, and calling it twice with the same arguments without an intervening `fclose` will likely fail. Wrapping it as `openAndDo(fileName, doTo)` — open the file, apply the passed function, close it — restores system state, so the wrapper appears pure. Even when the passed function appends a newline — a program that does leave the system altered — `openAndDo` still counts as pure to observers who never inspect the file's contents. Demonstrates that purity depends on what is being observed, and that side effects can be confined behind wrappers presenting a pure face.

### Historical thread: from notebooks to functions

The chapter opens and the "Contextual" section continues a history: Grace Hopper hand-copying subroutines from notebooks into Harvard Mark 1 programs (the first modules); call instructions arriving in the early '50s but initially shunned as too expensive; Fortran/PL-1-era subroutines and functions; 1960s modular programming; Dahl and Nygaard inventing object orientation (named later by Alan Kay); Parnas promoting information hiding. The thread grounds the claim that functions are the first line of organization, and that contexts — modularity and information hiding — are hard-won disciplines the programmer must actively manage.
