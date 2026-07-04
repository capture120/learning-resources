# Chapter 4: Modules Should Be Deep

## Central idea

Manage complexity by decomposing systems into modules so developers face only a small fraction of total complexity at once. The best modules are *deep*: they provide powerful functionality behind a simple interface. A module's interface is its cost to the system; its functionality is its benefit — maximize the ratio.

## Key concepts and definitions

- **Module**: any unit of code with an interface and an implementation — a class, a method, a function, a subsystem, or a service (whose interface may be kernel calls or HTTP requests). The techniques apply at every level, not just classes.
- **Dependency**: a relationship where changing one module may force changes in another (e.g., a method's signature creates a dependency on every caller; if the required arguments change, every invocation must change). Dependencies can be subtle — e.g., a method that only works if another method was called first. The goal of modular design is to minimize dependencies between modules. Why: in the ideal (unachievable) world of fully independent modules, a developer could work in any module knowing nothing of the others, and the system's complexity would be just the complexity of its worst module.
- **Interface**: everything a developer working in a *different* module must know to use this module. It describes *what* the module does, not *how*. Two parts:
  - **Formal interface**: explicitly specified in code and (partly) checkable by the language — method signatures, parameter/return types, exceptions; for a class, all public method signatures plus public variables.
  - **Informal interface**: high-level behavior and usage constraints the language cannot express or enforce (e.g., "this deletes the file named by its argument", "call init() before use"). Describable only in comments — and the language cannot check that those descriptions are complete or accurate. **If a developer must know it to use the module, it is part of the interface.** For most interfaces the informal part is larger and more complex than the formal part.
- **Implementation**: the code that carries out the interface's promises. A developer working in a module must understand that module's interface and implementation plus the *interfaces* of modules it calls — never the implementations of other modules.
- **Abstraction**: a simplified view of an entity that omits unimportant details. Each module's interface is an abstraction of its functionality. The word "unimportant" is crucial: the more unimportant detail omitted, the better — but only if the detail truly is unimportant.
- **False abstraction**: an abstraction that omits details that *are* important. It looks simple but isn't, and produces obscurity: developers reading only the abstraction lack information they need to use it correctly.
- **Deep module**: large functionality, simple interface. Visualize a rectangle: area = functionality, top edge = interface complexity. Deep modules are good abstractions because only a small fraction of internal complexity is visible to users.
- **Shallow module**: interface complexity nearly as large as the functionality it provides. It hides little, so it gives little leverage against complexity.
- **Classitis**: the syndrome arising from "classes are good, so more classes are better" — minimizing functionality per class and multiplying classes.

## Actionable principles

- **Make modules deep.** This is the most important issue in designing classes and modules: simple interfaces for the common use cases, significant functionality behind them. It maximizes the complexity concealed from the rest of the system.
- **Treat the interface as cost and functionality as benefit.** Smaller, simpler interfaces impose less complexity on the rest of the system. Interfaces are good, but more or larger interfaces are not necessarily better.
- **Prefer interfaces much simpler than their implementations**, for two reasons: (1) a simple interface minimizes the complexity the module imposes on everything else; (2) any change that doesn't alter the interface affects no other module — so the simpler the interface relative to the implementation, the more of the module can change freely.
- **Specify interfaces clearly (including informal parts) so users know exactly what they must know.** This eliminates "unknown unknowns" — developers can see the complete set of facts needed to use the module.
- **When designing an abstraction, decide what is genuinely important, then minimize it.** Two failure modes: including unimportant details (extra cognitive load) and omitting important ones (false abstraction / obscurity). Example of an important detail that must stay visible: a file system's cache-flush behavior matters to databases that need crash durability, so flush rules belong in the interface even though block allocation does not.
- **Design interfaces to make the common case as simple as possible.** Providing choice is good, but defaults should serve the majority. If a feature is rarely needed (e.g., disabling buffering, random file access), provide it via a cleanly separated mechanism most developers never have to know exists. When most users need only a few of an interface's features, the *effective* complexity is just the complexity of the commonly used features.
- **A module with no interface can be the deepest of all.** A garbage collector adds functionality while *shrinking* the system's overall interface (it removes the need to free objects). Adding functionality can reduce interface size.

## Nuances and counterpoints

- **Disagreement with conventional wisdom / Clean Code-style advice**: the prevailing dogma says classes and methods should be *small* — "break large classes up", "any method longer than N lines (N as low as 10) must be split". Ousterhout argues this produces large numbers of shallow classes and methods that *add* to system complexity. Depth, not size, is the right metric.
- **Why classitis hurts**: small classes individually look simple, but each carries its own interface; those interfaces accumulate into tremendous system-level complexity, plus per-class boilerplate makes code verbose. Java's class library is a visible case of classitis culture.
- **Shallow modules are sometimes unavoidable** (e.g., a linked-list class — its operations are so simple there's little to hide) and can still be useful; they just provide little leverage against complexity. Don't ban them; recognize their limits.
- **Modules can never be fully independent**: they must call each other, so some dependencies are inevitable. The aim is minimization, not elimination.
- **Don't justify a complex interface with "it gives users choice."** Choice is fine, but the common case must stay simple; route the uncommon choice through a separate, ignorable mechanism.
- **Formal specs can't replace informal interfaces (footnote)**: research languages exist that formally specify and machine-check a method's overall behavior, raising the question of whether they could replace the informal interface. Ousterhout's view: an interface described in English is likely more intuitive and understandable for developers than one in a formal specification language.

## Red flags

- **Shallow Module** (explicit red flag in the book): a module whose interface is complicated relative to the functionality it provides. It doesn't help much in the battle against complexity — the benefit (not learning the internals) is negated by the cost of learning and using its interface. *Small modules tend to be shallow.*
- A method that adds no abstraction — its full behavior is visible from its interface, documenting it would take more text than its code, and calling it takes more keystrokes than doing the work inline. Such a method makes complexity worse, not better.
- Wrapper/setup boilerplate where callers must compose several objects to get the common behavior (e.g., needing three stream objects to read a file with buffering) — the common case is not simple, and forgetting a layer silently degrades behavior.
- An interface that omits behavior users genuinely depend on (false abstraction) — apparent simplicity hiding obscurity.
- Proliferating tiny classes/methods to satisfy a size rule rather than to deepen abstractions (classitis).
