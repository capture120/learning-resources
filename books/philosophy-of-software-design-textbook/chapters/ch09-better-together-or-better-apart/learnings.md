# Chapter 9: Better Together Or Better Apart?

## Central idea

Given two pieces of functionality, should they live in one place or be separated? Decide based on which structure reduces the complexity of the system as a whole and improves its modularity — not on size, count, or any rigid rule. The question applies at every level: functions, methods, classes, and services.

## Key concepts

- **Subdivision has costs.** Splitting a system into more, smaller components does not automatically reduce complexity. Subdivision creates new complexity of four kinds:
  1. **Component count:** more components are harder to track and harder to search through; each new interface adds complexity.
  2. **Management code:** code that handled one object may now have to manage several.
  3. **Separation:** subdivided components end up farther apart (different classes, different files), making it harder to see them together or even know they exist. Separation is good only if the components are truly independent — then a developer can focus on one component at a time without being distracted by the others. If they have dependencies, separation is bad: developers flip back and forth between them and may miss the dependencies entirely, causing bugs.
  4. **Duplication:** code that existed once before subdivision may need to exist in each piece afterward.

- **Relatedness test.** Bringing code together pays off only when the pieces are closely related. Signs that two pieces of code are related:
  - They **share information** (e.g., both depend on the syntax of the same document format).
  - They are **used together, bidirectionally**: anyone using one is likely to use the other *and vice versa*. A one-way relationship is not compelling — a disk block cache almost always involves a hash table, but hash tables have many other uses, so they should stay separate modules.
  - They **overlap conceptually** under a simple higher-level category (substring search and case conversion are both "string manipulation"; flow control and reliable delivery are both "network communication").
  - **One cannot be understood without the other.**

- **Conjoined methods (anti-pattern).** Pieces of code that are physically separate but can only be understood by reading each other. The separation buys nothing and costs reading effort.

- **Depth over length.** A method's quality is measured by its abstraction, not its line count. Each method should do one thing and do it completely, with an interface much simpler than its implementation. A method with hundreds of lines is fine if it has a simple signature and reads easily — it is deep, which is good.

## Decision rules

- **Bring code together if it shares information.** When two pieces both encode knowledge of the same format or design decision (information leakage), combining them usually makes the code shorter and simpler, because the knowledge lives in one place.

- **Bring code together if it simplifies the interface.** A combined module may admit an interface simpler or easier to use than the originals; this often happens when the original modules each implemented part of the solution to a single problem. Combining can eliminate the interfaces that shuttled intermediate results between them, and can let the combined module do things automatically so most users never need to know about them (e.g., buffering on by default in file I/O).

- **Bring code together to eliminate duplication.** If the same snippet recurs:
  - Factor it into a separate method **when the snippet is long and the replacement method gets a simple signature**. A one-or-two-line snippet, or one entangled with many local variables (forcing a complex signature), gains little from extraction.
  - Alternatively, restructure so the snippet only executes in one place — e.g., a single error-cleanup block at the end of a method reached by `goto` from each error point. `goto` is generally bad, but escaping nested code to a shared exit path is a legitimate use.

- **Separate general-purpose code from special-purpose code.** A module providing a general mechanism should contain only that mechanism — no code specializing it for a particular use, and no other general mechanisms. Special-purpose code belongs in a different module, typically the one associated with that purpose. This eliminates information leakage and extra interfaces (e.g., text class provides general text operations; the UI module implements "delete selection").

- **Splitting a method: only if it yields cleaner abstractions overall.** Length alone is rarely a good reason; developers tend to over-split. Splitting introduces additional interfaces (more complexity) and separates the pieces of the original method, which makes the code harder to read if the pieces are actually related. Two valid forms:
  1. **Extract a subtask (best way):** child method holds the subtask, parent keeps the same interface as before and calls the child. Do this only if the subtask is cleanly separable: a reader of the child needs to know nothing about the parent, and a reader of the parent needs nothing of the child's implementation. The child is typically somewhat general-purpose — conceivably usable by other callers. If you end up flipping between parent and child to understand them, the split was a mistake.
  2. **Split into two sibling methods, both caller-visible:** only sensible when the original interface was overly complex because it did multiple unrelated things. Each new method must have a simpler interface than the original, and ideally most callers need only one of them. If callers must invoke both, passing state between them, the split adds complexity and risks producing several shallow methods. This form rarely works; judge it solely by whether it simplifies life for callers. A good sign: the new methods are more general-purpose than the original.

- **Join methods when joining simplifies the system.** Joining can replace two shallow methods with one deeper one, eliminate duplication, remove dependencies or intermediate data structures between the originals, improve encapsulation by isolating shared knowledge in one place, or yield a simpler interface.

## Nuances and counterpoints

- **Smaller is not automatically simpler.** It is tempting to think many small components minimize complexity; the act of subdividing itself creates complexity (interfaces, management code, separation, duplication) that did not exist before.

- **Long methods are not always bad.** Five sequential, relatively independent 20-line blocks can be read one block at a time; extracting each into its own method buys little. If the blocks interact in complex ways, keeping them together is *more* important so readers see all the code at once rather than flipping among spread-out methods.

- **Disagreement with Clean Code.** Robert Martin argues functions should be split on length alone — even 10 lines is too long, and blocks inside `if`/`while` should be a single line (a function call). Ousterhout disagrees: once a function is down to a few dozen lines, further shrinking barely improves readability, and the real question is whether the split reduces the complexity of the *system*. More functions mean more interfaces to document and learn. Functions made too small lose independence and become conjoined functions that must be read together — at that point the one larger function is better. **Depth is more important than length: first make functions deep, then try to make them short enough to read easily. Never sacrifice depth for length.**

- The insertion-cursor/selection example shows that surface-level relatedness (manipulated together, positionally linked) is not enough to justify combining; combine only when combining simplifies both interface and implementation. The same example shows the value of dropping to a lower-level but more general-purpose abstraction (a `Position` class) instead of either special-purpose object.

## Bottom line

Base split/join decisions on complexity: pick the structure that gives the best information hiding, the fewest dependencies, and the deepest interfaces.

## Red flags

- **Repetition (explicit red flag):** the same code, or nearly the same code, appears over and over. You haven't found the right abstractions.
- **Special-General Mixture (explicit red flag):** a general-purpose mechanism contains code specialized for one use of that mechanism. It complicates the mechanism and leaks information between mechanism and use case: future changes to the use case are likely to require changes to the mechanism as well.
- **Conjoined Methods (explicit red flag):** you cannot understand one method's implementation without also reading another's. Applies to any physically separated code that must be read together.
- Implicit warnings:
  - You flip back and forth between a parent method and an extracted child to understand how they work together — the extraction was a bad idea.
  - A split forces callers to invoke multiple methods and pass state between them.
  - Splitting is justified by line count or a rigid rule ("split anything over 20 lines") rather than by cleaner abstractions.
  - A combined object's users still treat its parts as distinct entities and manipulate them separately — the combination provides no benefit and should be undone.
  - Helper methods that are shallow, called from exactly one place, and need heavy documentation relative to their one line of work.
