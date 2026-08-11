# Chapter 08: Function Heuristics — Examples

### The implied argument: every function already takes the enclosing scope

Responding to first-edition readers who complained that a zero-argument function "can do little other than return a constant," Martin points out that every method has at least one implied argument — `this`/`self` in OO languages, the global scope in C. Counting only declared arguments, niladic functions are common and supremely readable: `stack.pop()`, `file.close()`, `semaphore.release()`, `buffer.flush()`. Lesson: the zero-declared-argument ideal is real, because the enclosing scope (object fields, context) carries the data.

### distance(x1, y1, x2, y2) — when more than three arguments is fine

Four arguments are usually risky (23 wrong orderings), but `distance(x1,y1,x2,y2)` is easy to keep in order because the ordering follows an obvious rationale. Lesson: the three-argument bias yields when structure makes order self-evident — and keyword-argument syntax (C#'s `createRental(movie: m, daysRented: 3)`, Clojure hash maps, Ruby keyword hashes) makes Martin worry less about order — he might, on occasion, pass more than three.

### getMonths(false) — the unreadable flag argument

The call `String monthNames[] = getMonths(false);` is opaque: are we getting months or not? The implementation reveals the boolean selects between long and short month names, but no caller can know that without clicking through to the code or its "ugly Javadoc." The fix splits the function in two:

```java
String[] getLongMonthNames() {…}
String[] getShortMonthNames() {…}
```

Lesson: a boolean flag proclaims the function does two things and hides the choice from every reader at the call site.

### stats() with output arguments — violating least surprise

A C++ function fills `mean` and `sum` through reference parameters:

```cpp
void stats(double* ns, int n, double& mean, double& sum)
```

At the call site, `stats(list, listSize, listMean, listSum)` makes readers wonder why mean and sum are being passed *in*. Readers expect data in through arguments, out through return values. Fixes: two separate functions (one for sum, one for mean — probably best, all else equal); multiple return values (`mean, sum = stats(list)` in Go/Python/Ruby — though Ruby returns a mutable array, caveat emptor); a two-element result object; or let the object hold the outputs — `stats.calculate(list)` then `stats.getMean()` / `stats.getSum()`, since in OO the object itself can act as the output argument.

### Go's error-return idiom

`f, err := os.Open("someFile")` followed by an `err != nil` check. Martin judges this a reasonable convention so long as it is applied narrowly and consistently — especially in Go, which has no exceptions. Lesson: heuristics bend to language reality.

### `if (set("username", "unclebob"))` — the CQS ambiguity

A function `boolean set(String attribute, String value)` both sets an attribute and returns whether it succeeded. In an `if` statement the reader cannot tell whether `set` is a verb (did the set succeed?) or an adjective (was it already set?). Renaming to `setAndCheckIfExists` doesn't much help; the real fix separates command from query:

```java
if (attributeExists("username")) {
    setAttribute("username", "unclebob");
}
```

Lesson: mixing command and query creates ambiguity that no name can fix; only separation removes it.

### stack.pop() and the C++ STL — the cost of violating CQS

`int top = stack.pop();` conveniently violates CQS: it queries the top and mutates the stack. The cost is concurrency — if pop isn't atomic, a race can hand the same top element to two threads. The C++ standard template library forces CQS here: `top()` then `pop()` as two statements. C++ has an extra reason: an overridden assignment operator might throw during the copy, and a combined pop-and-return could leave the stack in an unknown state. Lesson: CQS violations are sometimes acceptable, but only after weighing concurrency and exception-safety consequences.

### deletePage — error codes nest, exceptions separate

Checking `deletePage(page) == E_OK`, then `registry.deleteReference(...) == E_OK`, then `configKeys.deleteKey(...) == E_OK` produces three levels of nested if/else with logging and returns scattered throughout. Rewriting with guard clauses (early returns on `!= E_OK`) only pretends the nesting is gone — the structure is still there. With exceptions, the happy path collapses to three plain statements in a `try`, with one `catch` that logs. Lesson: returned error codes force immediate handling at every level; exceptions detach error processing from the main logic.

### Extracting the try/catch — delete(), deletePageAndAllReferences(), logError()

The exception version is then refined further: the public `delete(Page page)` contains only the try/catch skeleton; the try body becomes `deletePageAndAllReferences(page)`; the catch body becomes `logError(e)`. Now `delete` is all about error processing — easy to understand and then ignore — and `deletePageAndAllReferences` is all about deleting a page, with error handling invisible. Lesson: error handling is one thing; a function that handles errors should do nothing else, so `try` should be the first word of its function (after, perhaps, some variable declarations) and nothing should follow the catch/finally blocks.

### The error.h war story — error codes as a dependency magnet

In C, teams kept all error constants (`E_OK`, `E_INVALID`, `E_NO_SUCH`, ...) in one `error.h` that every module included. Adding one error code touched the file's date, so the build system recompiled the entire system — hours, in those days. Under that pressure, programmers stopped adding codes and instead reused old ones in "creative" ways, leading to "confusion, disillusion, and heartache." Java enums confine recompilation to directly impacted files; Go's `Error` interface (or Python duck-typed error classes) lets each error live in its own file, eliminating the magnet. Lesson: a shared definition file shapes programmer behavior — know how your build system reacts to dependency magnets.

### FitNesse testableHtml — extracting similar code, then shrinking the arguments

A real method from the FitNesse project (circa 2001) builds a wiki page's test HTML. Four nearly identical blocks each fetch an inherited page (SuiteSetUp, SetUp, TearDown, SuiteTearDown), compute its path, and append an `!include` line to a buffer — the blocks differ only in page name and include string. Step 1: extract the common block into `includeInheritedPage(pageName, wikiPage, buffer, includeString)`, vastly improving the flow of `testableHtml` and concentrating future modifications in one place instead of four. Step 2: four arguments is more than Martin likes, so `wikiPage` and `buffer` move into class fields, shrinking the call to `includeInheritedPage("SetUp", "!include -setup .")`. He notes the result still contains detectable duplication and leaves it to the reader. Lesson: similar (not identical) code is still duplication — extract it by parameterizing the differences, then use fields to keep the extracted function's signature small.

### Building scorer — "Write a Loop Once" (loop duplication)

In the late '90s, Martin's team had a data structure describing a building's floors and spaces and needed several dozen scored features, each requiring the same traversal. Naively, `SpaceFeature` and `AreaFeature` each repeat identical nested loops over `building.floors` and `floor.spaces`, differing only in the loop body (count spaces vs. sum width × length). Two fixes:

- **Lambda**: a shared `do_score(building, block)` owns the loop and calls `value = block.call(value, floor, space)` per space; each feature passes its one-line lambda.
- **TemplateMethod**: base class `Feature#score` owns the loop and calls an abstract `score_space(value, floor, space)`; each subclass overrides just that method.

Martin actually prefers the TemplateMethod version — it's what his team used in C++ before Design Patterns was published, under the name "Write a Loop Once." Either way, the odds are that a change to the data structure now touches only the one class owning the traversal. Lesson: when a traversal repeats with varying bodies, extract the loop once and inject the body.

### Accidental versus essential duplicates — the SRP test

Not a code listing but a decision rule: essential duplicates change together and should be unified; accidental duplicates merely look alike and evolve apart. The discriminator is the Single Responsibility Principle — if two similar stretches serve different actors, extracting a common function is likely to break the system for one actor while you satisfy the other; if they serve the same actor, they are likely to evolve together — forget to change one and you break the system for that actor. Lesson: DRY applies to essential duplication only.

### The password check that initialized the session — old vs. new "side effect"

Martin's first-edition example of a side effect: a function that checks the validity of a login password but also initializes the current session when the password is valid — a primary purpose plus a hidden extra. Since then the definition has generalized: any state change that outlives the function is a side effect, even when that change is the function's primary intent, so `stack.pop()` is impure too. Lesson: the term once meant "hidden extra work"; it now means any persisting state change — impurity itself.

### Garbage collection as proof "We Are Bad at This"

Martin argues that nearly every major language acquiring garbage collection is evidence that programmers cannot balance side-effect pairs: we were "so bloody awful at balancing malloc with free" — rebooting systems every midnight — that languages adopted GC as "a desperate measure." Reference counting and RAII tell the same story. But GC covers only memory: there is no garbage collector for file descriptors, graphics contexts, or semaphores. He adds the familiar debugging experience where swapping two adjacent function calls suddenly fixes a system and nobody knows why — temporal coupling leaking out. Lesson: side effects often come in pairs ("like The Sith: always two there are"), humans reliably fail to balance them, and temporal couplings underlie race conditions, reentrancy bugs, and init/teardown problems.

### Clojure update-clouds-age — rebinding names without varying values

From one of Martin's own Clojure programs: a `let` block binds the name `clouds` four times (fetch, decay concentrations, filter weak clouds, realize the sequence) before assoc-ing the result into a new world. Despite appearances, nothing is overwritten — the four `clouds` bindings refer to four distinct, persisting values. "The name clouds does not represent a variable, because nothing has varied." Functional languages forbid overwriting precisely because overwriting is a side effect that creates temporal coupling. He also notes the escape hatches (Clojure atoms, OS file handles) — functional style manages side effects but cannot eliminate them. Lesson: immutability removes the state change that forces line ordering.

### C++ LineCounter — hiding side effects behind encapsulation

A contrived class counts lines in a file via three private static methods — `initialize` (opens the file, zeroes the count), `countTheLines`, and `finalize` (closes the file, returns the count) — each riddled with side effects and temporal coupling. The sole public method, `count(fileName)`, calls them in order and itself exposes no side effect to callers (assuming single-threaded use). The class acts as a protected namespace; no temporal coupling leaks out. Caveat: in a multithreaded environment the static state needs a semaphore, or the class should become a real instantiated object. Lesson: OO languages, often accused of promoting side effects, also provide very good facilities to hide them behind encapsulation boundaries.

### Dijkstra's "Go To Statement Considered Harmful" — the origin of structured programming

A 1968 letter to the Communications of the ACM (titled by editor Niklaus Wirth) that was hotly debated for a decade — some thought Dijkstra a fool, others a god — and by the '90s had won so completely that languages stopped offering alternatives. The idea: build all programs from three recursively applied units — sequence, selection, iteration — each with a single entry and single exit (illustrated with a Nassi–Schneiderman flowchart of a quadratic-equation solver). Dijkstra's rationale: such structures can be reasoned about by following each path; arbitrary gotos make reasoning impractical. Lesson: keep the recursive application of the three structures in mind when shaping a function's control flow.

### Martin's own first drafts — "First, make it work. Then, make it right."

Martin confesses that his own functions come out long and complicated: heavy indenting, nested loops, long argument lists, arbitrary names, duplicated code, temporal couplings. But every clumsy line is covered by unit tests, so he then massages the code — splitting functions, renaming, removing duplication, purifying, sometimes breaking out whole classes — while keeping the tests passing, until the code follows the heuristics. "I don't write them that way to start. I don't think anyone could." Lesson: clean functions are a product of refactoring under tests, like wordsmithing a draft, not of writing perfectly the first time.
