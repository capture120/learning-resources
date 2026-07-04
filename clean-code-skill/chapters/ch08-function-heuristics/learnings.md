# Chapter 08: Function Heuristics

A collection of biases — not hard rules — for keeping functions clean: minimize and discipline arguments, separate commands from queries, prefer exceptions to error codes, eliminate essential duplication, and contain side effects. Martin states upfront: "I don't follow them as hard-and-fast rules, but when all else is equal, these are my biases." The goal underneath them all: functions are the verbs of a domain-specific language the program defines, and they must read like a story.

## Function Arguments

The easiest argument list to understand is the empty argument list; each added argument makes a function harder to understand. Every function already has one implied argument — the enclosing scope (`this`/`self` in OO, the global scope in C) — which is not counted. One argument (`f(x)`) is easy; two are manageable (make them commutative if you can); three starts getting difficult (five ways to misorder them). Three is usually Martin's limit — admittedly arbitrary ("You do you, I'll do me"). Arguments are couplings, and they are harder to read than to write: the IDE helps you while writing, far less while reading.

For more than three arguments, group them: if four things are cohesive enough to pass as a unit, why aren't they already an object? Alternatives: a hash map with nice names, or lift the values into fields of the current class. One reason OO is powerful is that it creates contexts that let functions communicate without long argument lists.

**Exceptions to the three-argument bias:**
- **Variadic arguments**: `format(String format, Object... args)` really takes two arguments — the format and the args array.
- **Rationale-based ordering**: `distance(x1,y1,x2,y2)` is fine because the ordering follows an obvious rationale. Without a rationale, four arguments have 23 wrong orderings — a large risk, especially when reading, since you won't notice misordered arguments.
- **Keyword arguments**: when the language names arguments at the call site (C#, Ruby, Clojure hash maps), Martin doesn't worry as much about order and might, on occasion, pass more than three.

## Flag Arguments

Flag arguments are ugly. Passing a boolean into a function is generally careless: it complicates the signature and loudly proclaims the function does more than one thing — one thing if true, another if false. At the call site (`getMonths(false)`) the flag is unreadable; the only way to learn what it means is to read the implementation (or at least its "ugly Javadoc"). The solution, where possible: split into two functions, one for the true case and one for the false case (`getLongMonthNames()` / `getShortMonthNames()`). Exception: objects with genuine binary flags set via `setFlag(boolean)` are fine.

## Output Arguments

Avoid using arguments to carry outputs. Readers expect data to go into a function through arguments and come out through the return value; an output argument violates the principle of least surprise (the Law of Least Astonishment) and can cause a double take. Alternatives: return multiple values (Go, Python, Ruby) or a small object; split into two functions (one per value) — all else equal, probably the best solution; or let the object itself act as the output (`stats.calculate(list)` then `stats.getMean()`), since OO largely eliminated the old need for output arguments.

## Error Codes

Go's convention of returning an error alongside the value (`f, err := os.Open(...)`) is reasonable so long as it is applied narrowly and consistently — especially in a language without exceptions.

## Command Query Separation

Under CQS, a function either does something or answers something, never both: a command changes system state; a query returns information. Mixing them produces ambiguous reads — `if (set("username", "unclebob"))` could be checking a prior state or reporting success, because you can't tell whether `set` is a verb or an adjective. The fix is not a better name but separating command from query so the ambiguity cannot occur.

CQS is sometimes impractical: `stack.pop()` violates it conveniently. The cost of violating it is concurrency — a non-atomic query-plus-mutation invites race conditions. C++'s STL splits `top()` from `pop()` for exactly this reason (plus exception safety: an overridden assignment operator throwing mid-pop could leave the stack in an unknown state). Martin's stance: take CQS seriously, and violate it only after considering the possible outcomes.

## Prefer Exceptions to Returning Error Codes

Returning error codes from command functions subtly violates CQS — it promotes commands into the predicates of `if` statements — and forces the caller to deal with each error immediately, producing deeply nested structures. Guard clauses only pretend the nesting is gone; "the lack of those else clauses doesn't mean they aren't actually there." Exceptions let the error-processing code be separated from the happy path and simplified. Caveat: exceptions are reliable in most modern languages; in older languages, most notably C++, that reliability is not guaranteed; and in some languages, like Go, they don't exist.

## Extract Try/Catch Blocks

Try/catch blocks are ugly in their own right — they confuse code structure and mix error processing with normal processing. Extract the bodies of the try and catch blocks into their own functions, so one function is all about error processing (easy to understand and then ignore) and another is all about the actual work.

## Error Handling Is One Thing

Functions should do one thing; error handling is one thing; therefore a function that handles errors should do nothing else. Concretely: if `try` appears in a function, it should be the first word (after perhaps some variable declarations), and nothing should follow the `catch`/`finally` blocks.

## The Dependency Magnet of Error Codes

If you must define shared error codes, beware of turning them into a dependency magnet. The old C `error.h` that every module included meant any new error code forced a system-wide recompile — hours back then — so programmers reused old codes in "creative" ways, leading to "confusion, disillusion, and heartache." Java enums limit recompilation to directly impacted files; Go's `Error` interface (or duck typing in Python) lets each error live in its own file with no magnet risk at all. Know how your build system works and whether dependency magnets will thrash your builds and deployments.

## DRY: Don't Repeat Yourself

Duplication should be avoided — advice as old as Codd's normal forms and Meyer's Single Choice Principle. But the decision to extract depends on the size of the duplicated snippet (L lines) and the number of places it appears (P):

- If both L and P are small, the duplication does little harm, and removing it may do more harm than good (extracting two trivial lines is only worth it as a readability convenience, not to kill duplication).
- If P is large, extract even small snippets — a future change would otherwise have to be hunted down everywhere.
- If L is large, extract even with small P — the odds a snippet needs later modification grow with its size.

**Similar Code**: snippets that differ only in a constant or variable are still duplication — usually with larger L, so they should be extracted, typically by adding an argument or two to the extracted function. If the extracted function then has too many arguments, move some into fields.

**Loop Duplication**: when many functions traverse the same data structure with identical loops but different loop bodies, extract the traversal once and parameterize the body — with a lambda, or with the Command, Strategy, or TemplateMethod patterns. Then the odds are that a change to the data structure touches only that one place. Martin prefers TemplateMethod over the lambda version; his '90s team called the technique "Write a Loop Once."

## Accidental versus Essential Duplication

Not all apparent duplicates are duplicates. **Essential duplicates** change together — they evolve together — and should be unified. **Accidental duplicates** merely look alike but evolve apart, and it is very important NOT to combine them. The test is the Single Responsibility Principle (SRP): if two similar stretches of code live in modules responsible to different actors, they are likely to evolve separately as those actors request different changes — extracting a common function is likely to break the system for one actor while you satisfy the other. If they answer to the same actor, they are likely to evolve together, and forgetting to change one breaks the system for that actor.

## Side Effects

The definition has shifted since the first edition. The old meaning: a function with a primary purpose that also does something else on the side (the first-edition example: a function that checked a login password's validity but also initialized the current session when the password was valid). The modern, generalized definition: a side effect is any state change that outlives the function, even if that change is the function's primary intent — a function with a side effect is impure (so `stack.pop()` has a side effect). Side effects introduce **temporal coupling** — coupling in time: a state change separates the code above from the code below and forces the order of lines to be preserved (can't close before open, can't free before malloc, can't release a semaphore before seizing it). Side-effect functions often come in pairs — open/close, seize/release, malloc/free — "like The Sith: always two there are."

**We Are Bad at This**: the proof is garbage collection — a "horrible hack" added to nearly every major language because we could not balance malloc with free. And GC fixes only memory; there is no garbage collection for file descriptors, graphics contexts, or semaphores. Temporal couplings are at the root of all concurrent update problems, all reentrancy problems, all race conditions, and nearly all initialization and finalization problems.

**Functional Languages** suppress side effects by forbidding overwriting of values — names can be rebound, but values are never varied, so no state change separates one line from the next. This helps greatly but is not a cure-all: temporal couplings are still possible (though most functional languages make it very obvious when you create them), functional languages have escape hatches (e.g., Clojure atoms), and OS facilities like files still demand side effects. A functional language can help you manage side effects; it cannot eliminate them.

**Object-Oriented Languages** are accused of promoting side effects (objects are containers of state), but they also provide very good facilities to suppress and hide them: encapsulate all the side-effecting steps behind a single public method so no temporal coupling leaks out to callers. The class can serve as a protected namespace for the stateful machinery. Watch the caveat: hidden static state is only safe single-threaded; for concurrency, add a semaphore or make it a real instantiated object.

## Structured Programming

Dijkstra's 1968 "Go To Statement Considered Harmful" established that all programs should be built from three recursively applied control structures — **sequence, selection, and iteration** — each a unit with a single entry and a single exit. His rationale: such structures are easy to reason about; you can follow every path and evaluate the outcomes, which unrestricted gotos make impractical. Nowadays our languages restrict control flow for us — most of us don't use languages with a goto, and those who do tend not to use it — but when writing clean functions it helps to keep the recursive application of these three structures in mind.

## This Is Too Much to Constantly Keep in Mind

Writing software is like any other writing: the first draft might be clumsy and disorganized, and you refine it until it reads well. Martin's own functions come out long and complicated — nested loops, long argument lists, arbitrary names, duplication, temporal couplings — but covered by unit tests. Then he massages: splitting out functions, renaming, eliminating duplication, making functions purer, all while keeping the tests passing. Nobody writes clean functions on the first try. **"First, make it work. Then, make it right."**

## Conclusion: Functions Are the Verbs

Every system is built from a domain-specific language designed by its programmers: functions are the verbs, contexts are the nouns. The art of programming is, and always has been, the art of language design. Master programmers think of systems as stories to be told rather than programs to be written; in an artful act of recursion, the functions are written to use the very domain-specific language they define to tell their own small part of the story. The heuristics are mechanics in service of that — functions must fit together into a clear, precise language that tells the system's story.

## In practice

- Keep declared arguments to three or fewer; if more are needed, group them into an object, a named hash map, or class fields — unless ordering has an obvious rationale or the language supports keyword arguments.
- Never pass a boolean flag to select behavior; split the function into one per case (genuine `setFlag(boolean)` setters excepted).
- Return outputs through the return value, never through arguments; for multiple results, prefer two functions, then multiple returns or a result object.
- Make each function either a command (changes state) or a query (returns information); violate CQS only deliberately, after weighing concurrency and exception-safety costs.
- Prefer exceptions to returned error codes where the language supports them reliably; Go-style error returns are fine if applied narrowly and consistently.
- If a function contains `try`, make `try` effectively its first word and put nothing after `catch`/`finally`; extract try and catch bodies into named functions.
- Keep shared error-code definitions from becoming dependency magnets; prefer per-file errors via interfaces/polymorphism when the build would thrash.
- Extract duplication when the snippet is large or appears in many places; leave tiny, rarely repeated duplication alone.
- For repeated traversal loops with varying bodies, write the loop once and inject the body (lambda, TemplateMethod, Strategy, Command).
- Before unifying similar code, apply the SRP test: do the copies answer to the same actor? If not, they are accidental duplicates — keep them separate.
- Treat every state change that outlives a function as a side effect; pair create/undo operations and hide side-effecting sequences behind one encapsulating public method.
- Build control flow from sequence, selection, and iteration with single entry and exit per unit.
- Write the messy first draft under tests, then refactor toward these heuristics while keeping tests green.
