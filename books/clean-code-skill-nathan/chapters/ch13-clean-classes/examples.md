# Chapter 13 Examples: Clean Classes

The chapter is built around one running case study — a library system's `HoldingService` — refactored step by step from an SRP-violating service into closed, single-purpose classes. Supporting anecdotes reinforce the values.

### The HoldingService interface: spotting too many responsibilities
The book introduces `HoldingService`, which manages a library's holdings (books, DVDs, etc.) with seven public methods: `isAvailable`, `find`, `add`, `transfer`, `dateDue`, `checkOut`, `checkIn`. Viewed as a UML diagram, the class looks cohesive — everything "manages the disposition of holdings." But each method implements a distinct library *policy* (e.g. due dates: books 21 days, DVDs 7; check-in: mark available, fine the patron if late). Policies vary independently — check-out rules can change without check-in rules changing. That independent variance means multiple reasons to change, so strict SRP compliance would split each policy into its own class (`CheckOutService`, `CheckInService`, ...), leaving `HoldingService` as a consolidated interface that only delegates. Lesson: a class can look single-purpose at the interface level and still violate SRP; and don't speculatively split now — wait for the next real change request.

### The dateDue method: interfaces hide where change lands
A proposed policy change (extend DVD rentals from 7 to 14 days) is traced through `dateDue`, which simply finds a `Holding` and delegates `holding.dateDue()`. The change would land in `Holding` (or maybe another class it depends on), not `HoldingService`. Lesson: you cannot find all reasons to change from UML or the public interface — you must open the source and read the code. Delegation shields a class from changes to the details it delegates.

### The checkIn method: a buried policy line and its comment
`checkIn` reads mostly as clean policy, except one line of raw implementation detail flagged with a comment:

```java
if (holding.dateLastCheckedIn().after(holding.dateDue())) { //late?
```

This conditional encodes a policy ("late = returned after due date") that could grow considerably more complex (VIP exemptions, grace periods), making it another hidden reason for `HoldingService` to change. It also slows readers, who must mentally assemble the detail into a concept. The fix is *not* a better comment ("comments are the distracting footnotes of code" — and can lie); it's extraction:

```java
if (isLate(holding)) { ... }

private boolean isLate(Holding holding) {
    return holding.dateLastCheckedIn().after(holding.dateDue());
}
```

The comment disappears because the method name `isLate` carries the same information. Lesson: when a comment guides readers through a few lines, extract those lines into a method named after the comment. Predicates are especially worth extracting.

### isLate has feature envy: move it to Holding
Once isolated, `isLate(Holding)` exhibits the "feature envy" code smell: it asks `Holding` two questions (date checked in, date due) and uses nothing from `HoldingService`. The book moves it onto `Holding`, so the call site becomes the immediately digestible `if (holding.isLate())`. The authors note this isn't buck-passing: `HoldingService` lost a reason to change and gained an abstraction. After every such move, re-ask whether the new home now has too many reasons to change — continuous design. (A "Future Jeff" aside: creating new classes takes moments in an IDE and has few downsides, yet developers often do everything they can to avoid clicking "New Class." Just do it.)

### calculateLateFine: a drippy switch with three reasons to change
The same treatment applied to fine calculation moves `calculateLateFine` from `HoldingService` into `Holding`, revealing an old-style fall-through-prone switch over `MaterialType`: books and new-release DVDs fined `fineBasis * daysLate`; cassettes, CDs, Blu-rays, etc. fined `min(1000, 100 + fineBasis * daysLate)`. Even in its new home it predominantly interrogates `Material`, and it has at least three reasons to change: new material types, new fine schemes, new rates. This violates the Open–Closed Principle — `Holding` stays "open," and every edit risks breaking existing behavior. The book deliberately pauses here: since the codebase is already rampantly open, speculative cleanup adds risk without need. Wait for a real change.

### The change arrives: Strategy classes and a self-describing enum
A real requirement appears (the library will lend jigsaw puzzles and board games under a new fine scheme). The book first "prefactors": each switch branch's calculation is extracted into a tiny Strategy class implementing a common interface:

```java
public interface LateStrategy {
    int calculateFine(int daysLate);
}
```

`DaysLateStrategy` (basis × days) and `ConstrainedFineStrategy` (capped, base-fee variant) replace the inline math. Then the `MaterialType` enum, which already carried per-type checkout periods and daily fines, is upgraded to carry a `LateStrategy` per value (e.g. `BOOK(21, new DaysLateStrategy(10))`). `MaterialType.calculateFine` delegates to its strategy, and `Holding.calculateLateFine` collapses to one line:

```java
public int calculateLateFine() {
    return getMaterial().materialType().calculateFine(daysLate());
}
```

The authors explicitly reject fancier options (Singleton strategies, reflection-instantiated classes): "why make things more complicated?" Lesson: prefactor when change demands it, prefer the simplest pluggable mechanism, and let polymorphism replace type-switching.

### DegradingFineStrategy: the new feature as a drop-in class
The new puzzle/game fine scheme (a geometrically degrading daily fine) is test-driven as `DegradingFineStrategy`, with real unit tests shown (`firstDayIsFineBasis`, `nextDayReducedUsingDegradationRate`, `multipleDays` — asserting e.g. 1000 + 900 + 810 + 729 + 656 for five days). The only edit to existing code is one new enum line: `GAMES_AND_PUZZLES(21, new DegradingFineStrategy(500, 0.20))`. The book notes the system still isn't *fully* closed — but moving material-type configuration to a database would make it OCP-compliant: code a new class, seed config data, no existing class changes. The whole strategy, tests included, took under 20 minutes, with no need to modify or extend tests of an existing class. Lesson: closed, single-purpose classes make new features cheap, fast, and low-risk — and the isolated policy class becomes self-documenting through its focused tests.

### Subroutine history: von Neumann, Goldstine, Wilkes, and Wheeler
A historical anecdote anchors the chapter's premise: 1940s systems were monoliths read top to bottom. Von Neumann and Goldstine's 1947 paper proposed subroutines for reuse and defect reduction; Wilkes and Wheeler implemented them on EDSAC in 1951, betting (before research confirmed it) that modularization would make development cheaper. Lesson: clean class design is the continued extrapolation of a seven-decade, empirically vindicated bet on modularity.

### The Smalltalk ideal and the "ravioli" worry
Two counterweight anecdotes frame the over/under-engineering question. On one side, the authors describe a hypothetical fully SRP/OCP-compliant system — one class per route, polymorphic conditionals, one class per workflow step — which sounds ridiculous but truly supports change by drop-in extension; they recall real Smalltalk systems 30 years ago that approached this (most classes small, the majority of methods one to three lines each — "Life was bliss"), though newcomers initially complain "there's all these objects and none of 'em are doing anything!" On the other side, Kent Beck's fourth rule (minimize elements) and John Ousterhout's fears about the "One Thing" rule warn against pointless ravioli of one-method classes. Resolution: treat SRP/OCP as ideals to move toward, not destinations; typical systems err overwhelmingly toward monolith, not ravioli.

### Steering AI with examples and clean style
The closing section argues from the AI era: LLMs get class-level code about 80% right. The remedy is to provide examples, demand a simple style (small single-purpose classes/functions, less state and side effects, clarity), have the AI generate tests from the examples, vet those tests, and run them. With SRP-compliant modules, fixing AI errors means conversing about one small class (or extracting a "method object" for one troubled method), and changing behavior means updating examples and regenerating the whole module. Lesson: clean class design isn't obsoleted by AI — it's the control surface that makes AI-generated code safe and regenerable.
