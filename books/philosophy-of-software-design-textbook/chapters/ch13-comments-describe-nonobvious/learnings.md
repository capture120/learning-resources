# Chapter 13: Comments Should Describe Things that Aren't Obvious from the Code

## Central idea

Comments exist because code cannot capture all the important information that was in the developer's mind when the code was written. The guiding principle: **comments should describe things that aren't obvious from the code** — units, boundary conditions, invariants, the *why* behind code, rules like "always invoke a before b," and above all abstractions. A comment can give the simpler, higher-level view that code can't ("after this method is invoked, network traffic will be limited to maxBandwidth bytes per second"). Good comments explain things at a *different* level of detail than the code: lower-level for precision, higher-level for intuition. Comments at the same level as the code just repeat it and are worthless.

A key consequence: developers should be able to understand the abstraction provided by a module without reading any code other than its externally visible declarations. The only way to achieve this is to supplement declarations with comments — code is too detailed to convey an abstraction by itself. An abstraction (Chapter 4) is a simplified view of an entity that preserves essential information and omits details that can safely be ignored; code can't describe one because it is too low-level and exposes implementation details that shouldn't be visible in the abstraction. Hence the chapter's second bolded rule: **if you want code that presents good abstractions, you must document those abstractions with comments.**

The end goal of comments: make the system's structure and behavior obvious to readers, so they can quickly find the information they need and modify the system with confidence that their changes will work.

## Key concepts

**The four comment categories** (most comments fall into one of these):
- **Interface comment**: a block immediately preceding the declaration of a class, data structure, function, or method, describing its interface. For a class: the overall abstraction it provides. For a method: overall behavior, arguments, return value, side effects, exceptions, and preconditions the caller must satisfy.
- **Data structure member comment**: next to the declaration of a field (instance or static variable).
- **Implementation comment**: inside the code of a method, describing how it works internally.
- **Cross-module comment**: describes dependencies that cross module boundaries. Rarest, hardest to write, but quite important when needed.

Interface and data-member comments are the most important: every class, every class variable, and every method should have one. Implementation comments are often unnecessary; cross-module comments are rare.

**Precision vs. intuition** — the two valid levels for a comment:
- *Lower-level comments add precision*: they clarify the exact meaning of the code (units, boundaries, null semantics, ownership, invariants). Most useful for variable declarations, arguments, and return values, where name + type are typically not precise enough.
- *Higher-level comments enhance intuition*: they omit details and convey overall intent, the reasoning behind the code, or a simpler way to think about it. Most useful inside methods and for interface comments.
- Comments at the *same* level as the code are likely to repeat it.

**Interface vs. implementation separation**: interface comments give the information someone needs to *use* a class or method — they define the abstraction. Implementation comments describe how the code works internally. Keep them strictly separate so users of an interface aren't exposed to implementation details. Diagnostic value: **if an interface comment must also describe the implementation, the class or method is shallow** — writing comments provides clues about design quality.

**Side effect**: any consequence of a method that affects the future behavior of the system but is not part of the result (e.g., adding to an internal data structure retrievable by future calls; writing to the file system). All side effects must be documented in the interface comment.

## Actionable principles

**Pick conventions first.** Decide what you will comment and the format before writing. Use the ecosystem's documentation tool conventions (Javadoc, Doxygen, godoc) — none is perfect, but the tooling benefits outweigh imperfections. If no conventions exist, borrow from a similar language or project. Conventions ensure consistency, and they ensure you actually write comments at all: without a clear plan of what to comment, it's easy to write nothing.

**Comment everything in the interface/member categories rather than agonizing per case.** Occasionally a declaration is so obvious there's nothing to add (some getters/setters), but this is rare; it costs less to comment everything than to spend energy deciding case by case.

**Don't repeat the code.** The most common comment failure. Test after writing: *could someone who has never seen the code write this comment just by looking at the code next to it?* If yes, the comment adds nothing — comments like these are why some people think comments are worthless.

**Use different words in the comment than in the name of the entity.** Comments that recombine the words of the method or variable name (plus argument names/types) carry zero information. Pick words that add meaning: explain what the term means, give units, state scope ("both sides of each line"), define jargon the name uses.

**For variables, fill in what name + type can't express.** Specifically:
- Units (pixels vs. characters, ms vs. s).
- Whether boundary conditions are inclusive or exclusive.
- If null is permitted, what it means.
- For resources that must be freed or closed: who is responsible.
- Invariants — properties always true ("this list always contains at least one entry").

These could often be deduced by examining all code that uses the variable, but that is slow and error-prone; the declaration comment should make it unnecessary. ("Aren't obvious from the code" means the code *next to* the comment, i.e. the declaration — not all the code in the application.)

**Avoid vagueness.** The most common problem with variable comments is that they're too vague ("Current offset in resp Buffer" — current as of what?). Be precise: state exactly what the value represents, what each part of a compound structure means, and what an *absent* entry means.

**Think nouns, not verbs, when documenting a variable.** Describe what the variable *represents*, not the sequence of operations that manipulate it. A state-based description ("true means a heartbeat has been received since the last timer reset") is shorter and lets the reader *infer* the manipulations; a manipulation-based description doesn't let the reader infer the meaning.

**For implementation comments: what and why, not how.** The main goal is to help readers understand *what* a block of code is doing (its intent), not how. Once readers know what the code is trying to do, the how is usually easy to follow. Practically:
- Most methods are short and simple enough to need no implementation comments at all: a short method does one thing, which its interface comment already describes, so the code plus interface comment make the internals easy to follow.
- In longer methods, put a comment before each major block giving a high-level description of what that block does ("Phase 1: Scan active RPCs to see if any have completed."). These help readers navigate to the parts that matter to them.
- Before nontrivial loops, describe what one iteration accomplishes. Short, simple loops need none.
- Document *why* when there are tricky aspects that won't be obvious from the code — e.g., why a bug-fix line exists. If a well-written bug report exists, reference the tracker ID instead of repeating details (avoids duplication).
- Comment a few important local variables in long methods, but most local variables with good names whose uses are all visible within a few lines need no comment — it's OK to let readers read the code. If a variable is used over a large span of code, consider a comment.
- "How we get here" comments — describing the conditions under which code executes or a method is invoked — are very useful, especially for methods invoked only in unusual situations.

**For interface comments on methods** — these mix both levels: higher-level information for abstraction plus lower-level details for precision — include:
- One or two opening sentences describing the behavior as perceived by callers (the higher-level abstraction).
- Precise description of each argument and the return value, including constraints on values and dependencies between arguments.
- All side effects.
- All exceptions that can emanate from the method.
- All preconditions (e.g., another method must be called first; a binary search requires the list to be sorted). Minimize preconditions, but document any that remain.

The interface comment must give *all* the information a developer needs to invoke the method, including how special cases are handled, and *no* information about how the method is implemented. The decision test for each candidate fact: *does a developer need to know this in order to use the class?* Omit implementation mechanisms (message formats, internal data structures, private config variables), things invisible to users (e.g., automatically-recovered server crashes), and statements that are obvious or content-free ("by providing all necessary information"). Possibly include high-level performance characteristics (e.g., concurrent requests) since users may care.

**Higher-level comments require stepping back.** They're harder to write than low-level ones because you must think about the code differently. Engineers tend to be detail-oriented — essential for engineering — but great designers can also step back, decide which aspects matter most, and ignore the low-level details. That is the essence of abstraction (finding a simple way to think about a complex entity), and it's exactly what writing a higher-level comment demands. Ask: What is this code trying to do? What is the simplest thing you can say that explains everything in the code? What is the most important thing about this code? A good higher-level comment expresses one or a few simple ideas that provide a conceptual framework ("append to an existing RPC"); given the framework, readers can see how each statement relates to the goal — and can *judge* whether the code correctly achieves it.

**Cross-module design decisions need documentation in a findable place.** Real systems inevitably have design decisions affecting multiple classes (e.g., a network protocol spans sender and receiver); these decisions are complex, subtle, and account for many bugs. The challenge is placement:
- If there's an obvious central place every affected developer must visit (e.g., the enum where new values get added), put the documentation there, listing every other place that must also change. Position it where it will be seen (e.g., at the end of a list that grows at the end).
- If there's no natural central place, neither duplicating the docs at every site (hard to keep in sync) nor picking one arbitrary site (developers won't find it) works well. Instead use a central `designNotes` file with clearly labeled sections per topic, and at each relevant code site leave a one-line pointer comment ("See 'Zombies' in designNotes."). Trade-off: single copy, easy to find via the pointer, but the doc is not near the code, so it's harder to keep up to date.

**"Obvious" is judged by the first-time reader, not the author.** When writing comments, adopt the mindset of someone reading the code for the first time and ask what they need to know. If a reviewer says something isn't obvious, don't argue — if a reader thinks it's not obvious, it *is* not obvious. Find what confused them and fix it with better comments or better code.

## Nuances and counterpoints

- This chapter directly answers the "comments are worthless / code should be self-documenting" school: it concedes that *repetitive* comments are indeed worthless — and identifies them as the reason that school exists — but holds that important information (abstractions, units, invariants, why) genuinely cannot be expressed in code.
- Even when information *could* be deduced by reading code, that doesn't make the comment redundant: forcing module users to read implementation code is time-consuming and exposes them to details they don't need. The comment exists to keep them out of the code.
- Don't over-comment implementation: most methods need no implementation comments, most local variables need none, and short loops need no loop comments. Comment where obviousness genuinely fails.
- A class-level usage example in interface docs may duplicate per-method comments and is "not strictly necessary," but it earns its place for deep classes with nonobvious usage patterns by showing how the methods work together.
- Sometimes renaming beats commenting: `lineWidths` → `numLinesWithLength` carried more information in the name itself and avoided a misleading term ("width" suggests pixels, "length" suggests characters). Names and comments work together.
- Writing comments is a *design probe*: difficulty separating interface comments from implementation detail signals a shallow abstraction (developed further in Chapter 15).

## Red flags

- **Comment Repeats Code** (explicit red flag box): if the information in a comment is already obvious from the code next to it, the comment isn't helpful. A telltale sign: the comment uses the same words that make up the name of the thing it describes.
- **Implementation Documentation Contaminates Interface** (explicit red flag box): interface documentation describes implementation details that aren't needed in order to use the thing being documented.
- Implicit: one comment per line of code, at the same level of detail as the code — such comments are almost never useful.
- Implicit: vague variable comments ("current X") that don't pin down exact meaning, units, or what missing/null values mean.
- Implicit: variable comments written as verbs (how code manipulates the variable) instead of nouns (what it represents).
- Implicit: an interface comment that must describe the implementation to make sense — the class or method is shallow.
- Implicit: arguing with a reviewer who says something is not obvious — by definition, it isn't.
