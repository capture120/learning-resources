# Chapter 19: Software Trends

## Central idea

Popular software-development trends are not automatically good; each must be judged by one criterion: does it provide leverage against complexity in large systems? This chapter evaluates object-oriented programming, agile development, unit testing, test-driven development, design patterns, and getters/setters against the book's principles. Some trends genuinely reduce complexity; others, applied uncritically or taken too far, make it worse.

## Key concepts

- **Interface inheritance**: a parent class (or interface) defines method signatures without implementations; each subclass implements them its own way. Multiple implementations reuse one interface, so knowledge from one implementation transfers to others. The more implementations an interface has, the *deeper* it becomes — to support many implementations it must capture the essential features common to all while excluding the details that differ. That is the heart of abstraction.
- **Implementation inheritance**: a parent class provides default method implementations that subclasses inherit or override. It eliminates duplicating the same method across subclasses, reducing change amplification (Chapter 2). But it creates dependencies between parent and child: shared instance variables leak information across the hierarchy, so modifying one class often requires examining others. In the worst case, changing any class requires complete knowledge of the entire hierarchy. Extensive implementation inheritance tends to produce high complexity.
- **Agile development**: emerged in the late 1990s from ideas for making development more lightweight, flexible, and incremental; formally defined at a practitioners' meeting in 2001. Development proceeds in a series of iterations, each adding and evaluating a few new features; each iteration includes design, test, and customer input. Agile is mostly about the *process* of development (organizing teams, managing schedules, the role of unit testing, interacting with customers), not software design — but it still intersects the book's design principles.
- **Unit tests vs. system tests**: unit tests are small, focused (typically one section of code in a single method), runnable in isolation without a production environment, and usually written by developers, often with a coverage tool to ensure every line of code is tested. System (integration) tests verify that the different parts of an application work together properly; they run the whole application under production-like conditions and are more often written by a separate QA team. Unit tests achieve higher coverage, so they are more likely to catch bugs.
- **Test-driven development (TDD)**: write unit tests before code, then write just enough code to make each test pass in turn.
- **Design pattern**: a commonly used, generally agreed-upon clean solution to a recurring problem (iterator, observer, etc.) — an alternative to designing a mechanism from scratch.
- **Getters and setters**: paired `getFoo`/`setFoo` methods exposing an instance variable (the getter returns its current value, the setter modifies it), popular in the Java community. They aren't strictly necessary — the variable could simply be made public.

## Actionable principles

### Object-oriented programming
- Use private methods and variables to enforce information hiding: no external code can depend on them.
- Prefer interface inheritance; it provides real leverage against complexity through deep, reusable interfaces.
- Treat implementation inheritance with caution. Before using it, ask whether **composition** gives the same benefit — e.g., small helper classes implementing the shared functionality that the original classes build upon, instead of inheriting from a parent.
- If implementation inheritance is unavoidable, separate parent-managed state from subclass-managed state: have certain instance variables managed entirely by parent-class methods, with subclasses accessing them read-only or via parent methods. This applies information hiding *within* the class hierarchy to reduce dependencies.
- OOP mechanisms assist clean design but do not guarantee it. Shallow classes, complex interfaces, or externally accessible internal state still produce high complexity regardless of how object-oriented the code is.

### Agile development
- Incremental, iterative development matches this book's approach: you can't visualize a complex system well enough at the outset to pick the best design, so develop in increments, each adding a few abstractions and refactoring existing ones based on experience.
- But **the increments of development should be abstractions, not features**. Agile's feature focus, and its advice to defer design (build a minimal special-purpose mechanism now, generalize later), argues against the investment mindset and encourages tactical programming, which rapidly accumulates complexity.
- It is fine to defer all thought about an abstraction until a feature first needs it. Once needed, invest the time to design it cleanly and make it somewhat general-purpose (Chapter 6).

### Unit tests
- Write unit tests for your own code, and update them whenever you write or modify code, to maintain coverage. (Developer-written tests are themselves an agile tenet: developers once rarely wrote tests — a separate QA team did, if anyone — until agile's insistence that testing be tightly integrated with development made the practice widespread.)
- Tests matter for *design* because they enable refactoring. Without a good test suite, structural changes are dangerous, bugs surface only after deployment where they're expensive, developers avoid refactoring and minimize changes per fix — so complexity accumulates and design mistakes never get corrected. With good tests, developers refactor confidently and the design improves over time.
- Prefer unit tests over system tests for this purpose: their higher coverage uncovers more bugs.

### Test-driven development
- Avoid TDD. **Its problem is that it focuses attention on getting specific features working rather than finding the best design** — tactical programming, pure and simple. TDD is too incremental: at every moment the temptation is to hack in whatever makes the next test pass, and there's no obvious time to do design, so you end up with a mess.
- Once you discover the need for an abstraction, don't build it in pieces over time; design it all at once (or at least a reasonably comprehensive set of core functions) so the pieces fit together well.
- Exception — bug fixes: write a failing unit test *before* fixing a bug, then fix it and confirm the test passes. If you fix first and test second, the test may not actually trigger the bug, so it can't prove the fix worked.

### Design patterns
- Apply a well-known pattern when it fits: patterns exist because they solve common problems with generally agreed-upon clean solutions, and you'll rarely beat a fitting pattern with a custom approach.
- The greatest risk is **over-application**. Don't force a problem into a pattern when a custom approach is cleaner. Patterns only improve a system when they fit; "design patterns are good" does not mean "more design patterns are better."

### Getters and setters
- Avoid getters and setters — and any exposure of implementation data — as much as possible. Exposing an instance variable makes part of the implementation externally visible, violating information hiding, and getters/setters are shallow methods (usually one line) that clutter the interface without adding functionality.
- The standard argument for them (they allow adding side behavior later — updating related values, notifying listeners, enforcing constraints — without changing the interface) only matters *if you must expose instance variables*. The better move is not to expose them at all.
- Their overuse in Java illustrates a general hazard: once something becomes an established pattern, developers assume it's good and apply it everywhere.

## Nuances and counterpoints

- Ousterhout partially endorses agile: incrementalism is right, but agile's unit of increment (features) and its deferral of generalization are wrong. This is a direct disagreement with agile practitioners who say "don't build general-purpose mechanisms up front."
- He strongly advocates unit testing while explicitly rejecting TDD — the two positions are independent. Tests are a design-enabling tool; writing them first (except for bug fixes) drives tactical programming.
- Implementation inheritance is not banned, only demoted: composition first, then state separation within the hierarchy as a fallback.
- The conclusion generalizes the chapter: when you encounter any new development paradigm, challenge it from the standpoint of complexity. Many proposals sound good on the surface but, examined deeply, make complexity worse.

## Red flags

This chapter has no boxed red flags; these are its implicit warning signs:

- Extensive implementation inheritance — parent and subclasses sharing instance variables; changes to one class requiring inspection of the whole hierarchy.
- Equating OOP usage with good design while classes remain shallow, interfaces complex, or internal state externally accessible.
- Increments of development defined as features rather than abstractions; deferring all design "until later" in the name of agility.
- A codebase without a good test suite where developers avoid refactoring and minimize each change — complexity accumulating because mistakes can't safely be corrected.
- Building an abstraction piecemeal, one test or feature at a time, instead of designing its core all at once.
- Forcing a problem into a design pattern that doesn't fit, or measuring quality by pattern count.
- Proliferating getters/setters (or any exposure of instance variables) — shallow methods cluttering an interface and leaking implementation.
- Adopting a paradigm because it's popular rather than because it demonstrably reduces complexity in large systems.
