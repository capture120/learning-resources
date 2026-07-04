# Chapter 10: One Thing — Examples

### The 3,000-line `gi` function (war story)

Martin once owned a 3,000-line C function named `gi` ("graphic interpreter"). Asked whether it did one thing, he would have said "Certainly! It interprets graphics" — showing how useless the phrase "one thing" is without a real definition. He knew the function *geographically*: to change the x-axis scaling, he'd scroll to the big comment block and count three indents down. He likens this to hominids reading the savannah horizon — the undulating indentation gave him peaks-and-valleys landmarks. But a new programmer has no map: no idea where the watering hole or the saber-toothed tiger is, and can only fumble through the morass. The lesson: geographic knowledge dies with the author. A function named `setScalingOnX` in an `Axis` namespace serves every future reader. This anecdote also seeds the later insight that `gi`'s locals (`i`, `j`) and indented regions were a class waiting to be discovered.

### Extractions that are not meaningful

Two counter-examples define the limits of "extract till you drop":

Too little — extracting a function's entire body leaves a pure delegator:

```java
public void addRental(Rental rental) { doTheAdd(rental); }
public void doTheAdd(Rental rental) { rentals.addElement(rental); }
```

Pointless (except in the rare case where the delegator exists so the extracted function can move to another module).

Too much — splitting a two-line `clearTotals()` into `clearAmount()` and `clearPoints()` yields names indistinguishable from their implementations, failing The Stepdown Rule: a meaningful abstraction's name must be more abstract than its body.

### Prose-like control flow

The target state after extracting bodies and predicates from control statements:

```java
if (shouldDeleteRecord(r))
    deleteRecord(r);
```

It reads like well-written prose — keywords plus well-named function calls, nothing to decode.

### Promoting locals to fields inside `gi` (hypothetical refactor)

Imagining `gi` in Java: the IDE refuses to extract an `if` body that modifies two local variables (`i++; j++;`) because it can't return two values. The fix is to promote `i` and `j` to instance variables of `GraphicInterpreter`, after which extraction succeeds. Repeating this, indent after indent, produces many methods that all manipulate the shared fields `i` and `j` — and a set of methods manipulating a shared set of variables *is a class*. The deliberate encapsulation break is the tool that reveals it. Anchors the chapter's central claim: "Every large function is really hiding a class (or more) inside it."

### The Video Store (Fowler's Refactoring example, in Go) — the chapter's main case study

Martin reworks Martin Fowler's famous 1999 Video Store example: a `Customer` class whose `statement()` method computes rental charges and frequent-renter points in one loop with a type-code `switch`, while formatting a text statement. The refactoring proceeds in stages, each anchoring a lesson:

**1. Fix the tests first.** The original tests assert full statement strings — testing through the UI. Those strings are volatile (marketing will reword "Rental Record for..." on a whim), so every test would break: fragile. Redesign: test the statement format exactly once; have all other tests assert the computed totals via `assertOwedAndPoints`. Also replace production-flavored data (`Fred`, `The Cell`) with intent-revealing data (`Customer Name`, `New Release 1`), and tighten wordy tests with shared movie variables and a composed assertion. Asserting on totals required exposing `totalAmount` and `frequentRenterPoints` as fields — the same locals-to-fields promotion as in `gi`.

**2. Extract till you drop.** The monolithic `statement()` becomes:

```go
func (customer *Customer) makeStatement() string {
    customer.clearTotals()
    return customer.makeHeader() +
        customer.makeDetails() +
        customer.makeFooter()
}
```

with `makeDetail`, `determineAmount`, `determinePoints`, `formatDetail`, etc. below in call order. Despite fears of "all those tiny functions," the top function now states the high-level procedure of most reports (header, details, footer). A bug in the footer? Go straight to `makeFooter`. Martin calls this code *polite* — little to decode, directions pointing to every answer — and the original, by contrast, *rude*.

**3. Move methods to where they belong.** Scanning the extracted methods, `determineAmount` and `determinePoints` never use the `Customer` — they operate entirely on the `Rental` passed in. So they move to `Rental`. The tests pass unchanged, proving "the tests have a design that tolerates change."

**4. Rename what extraction exposed.** With the business rules gone, `Customer` is all about formatting the statement — so it becomes `RentalStatement`. Cleaning up reveals wrong names and concepts that were hidden before. (`formatDetail` stays in `RentalStatement` even though it uses none of its fields, because formatting is that class's purpose.)

**5. Move the type code.** The relocated `determine` functions use both `Rental` fields (`movie`, `daysRented`) — strong cohesion — but are also strongly coupled to `Movie`, which is troubling. That coupling is entirely about `movieType`, raising the question of why the type lives in `Movie` at all. The original tests hint that "The Tigger Movie" was rented both as a new release and as a children's movie — so the type belongs to the *rental*, not the *movie*. `movieType` moves from `Movie` to `Rental` as `rentalType`, leaving `Movie` nearly empty (just a title). This change did affect the tests — the `NewRental` constructor gained the type — but it was a pretty quick change.

**6. Replace the switch with polymorphism.** "Switch statements are like gerbils — given enough time they'll reproduce all over your code" (a second baby switch was already growing in `determinePoints`). A `RentalType` interface with `determineAmount`/`determinePoints` gets three implementations — `NewReleaseRental`, `ChildrensRental`, `RegularRental` — each encapsulating one type's business rules. (The tests had to change again, but only a little.) An architectural boundary forms below `RentalType`: new rental types can be added without changing existing code, the Open–Closed Principle at work.

Net result: one large function dissolved into three new classes plus one existing class, business rules cleanly separated from formatting — vindicating "every large function is hiding a class (or more)."

(A "Future Bob" note: Robert Laszczak published improvements to this example, more consistent with common Golang style, at threedots.tech/clean-code; Martin, a self-described Golang novice, agrees with most, but prefers longer names and `get`-prefixed getters.)

### QuadraticFormula — extraction and shared scope (Java)

A `solve(a, b, c)` function with nested `if`/`else` handling linear, single-root, two-root, and complex cases. Pretending it will grow more complex, Martin extracts `linearSolution`, `quadraticSolution`, `complexSolution`, `singleQuadraticSolution`, and `twoQuadraticSolutions` — the top-level `solve` becomes a two-branch policy statement. Then a second step: instead of threading `a`, `b`, `c`, `discriminant` through every function's parameter list, he loads them into class variables so the extracted functions communicate through their enclosing scope. Cleaner — with one stated risk: static variables can be corrupted in a multithreaded environment, fixable by switching to instance methods and variables. Lesson: extracted functions may legitimately share state via the class that contains them.

### Quadratic formula in Clojure — closures as the scope

The same problem in Clojure is "very pretty" as a single `cond` and needs no extraction at its real size. But pretending it's larger, Martin extracts `linear-solution`, `single-solution`, and `two-solutions` as `let`-bound inner functions. They take no arguments because Clojure closures capture the surrounding `let` scope — a function creates "a kind of object" with variables and functions scoped within it — and since nothing is static, the Java version's concurrency worry disappears. Lesson: the share-state-through-enclosing-scope pattern is natural in functional languages, and extraction judgment depends on actual size — small, clear code shouldn't be extracted just on principle.
