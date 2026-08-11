# Chapter 19: The SOLID Principles

Clean code makes good bricks, but you can still build a mess with well-made bricks. The SOLID principles govern the next level up: how to arrange functions and data into classes (any coupled grouping of functions and data, OO or not) and how to interconnect those groupings so the resulting mid-level structures tolerate change, are easy to understand, and can be reused in other systems. The unifying idea: control which code depends on which, so changes in one place cannot ripple into places that should not care. The warning recurs one level up: just as well-made bricks can still make a substantial mess, well-designed mid-level components can still make a systemwide mess — hence the component-level and architectural counterparts that follow. (The chapter is an abridged set of excerpts from *Clean Architecture*, meant as a quick reference; the author calls it "a good introduction, but insufficient for a deep understanding" and directs readers to the detailed writings.)

## SRP: The Single Responsibility Principle

**A module should be responsible to one, and only one, actor.** An actor is a group of one or more people (users or stakeholders) who require changes for the same reasons.

- The name misleads. SRP does NOT mean "every module should do just one thing." That rule ("a function should do one, and only one, thing") is real but applies at the lowest level, when refactoring large functions into small ones. It is not the SRP.
- The historical phrasing is "a module should have one, and only one, reason to change" — and the reason to change is always a person or group requesting the change.
- The executive-summary framing: the best structure for a software system is heavily influenced by the social structure of the organization that uses it, such that each module has one, and only one, reason to change.
- Cohesion is the force that binds together the code responsible to a single actor; "module" means a cohesive set of functions and data structures.
- The driving value: when code serving different actors lives in close proximity, a change demanded by one actor can silently break behavior another actor depends on ("Accidental Duplication"). Separate the code that different actors depend upon.
- Fixes all move the functions into different classes: split data from functions (e.g., a methodless `EmployeeData` structure shared by separate function classes that may not know about each other), or use the **Facade pattern** to instantiate and delegate to the split classes, or keep the most important business rules in the original class and let it act as a facade for the rest.
- Don't fear "one-function classes" — each separated responsibility typically needs many public and private methods.
- The SRP reappears at higher levels: as the **Common Closure Principle** at the component level, and as the **axis of change** that creates architectural boundaries at the architecture level.

## OCP: The Open–Closed Principle

**A software artifact should be open for extension but closed for modification** (Bertrand Meyer, 1988). You should be able to extend behavior without modifying existing code.

- This is "the most fundamental reason that we study software design": when simple requirement extensions force massive changes, the architects have engaged in a spectacular failure. A good architecture reduces changed code to the barest minimum; ideally, zero.
- Mechanism: separate the things that change for different reasons (the SRP), then organize the dependencies between them properly (the DIP).
- The directional rule: **if component A should be protected from changes in component B, then component B should depend upon component A.** Dependencies point toward the components you want to protect.
- This creates a hierarchy of protection based on "level": the highest-level component (the Interactor, holding the business rules — the central concern) is the most protected; Views, among the lowest-level concepts, are the least protected. Higher-level components are protected from changes to lower-level ones.
- Interfaces serve two distinct purposes here: **directional control** (inserting an interface inverts a dependency that would otherwise point the wrong way) and **information hiding** (an interface shields a client from transitive dependencies on internals it doesn't directly use).
- Practical note ("Future Bob"): you are not expected to draw full class diagrams to do this; a whiteboard sketch of the component view suffices because the classes within are obvious to the team.

## LSP: The Liskov Substitution Principle

**Subtypes must be substitutable for their base types** without changing the behavior of programs written against the base type (Barbara Liskov, 1988).

- The canonical violation is the **Square/Rectangle problem**: Square is not a proper subtype of Rectangle because Rectangle's height and width are independently mutable while Square's must change together; code that sets width and height and asserts the area gets surprised.
- The only defense against such a violation is adding type-detection mechanisms (an `if` statement) to the user — but since the user's behavior now depends on which type it uses, the types are not substitutable, and that `if` violates the OCP. **Every violation of the LSP is a latent violation of the OCP.**
- LSP has broadened beyond inheritance into a general principle of **interfaces and implementations**: a Java-style interface, several Ruby classes sharing method signatures, or a set of services responding to the same REST interface. Wherever users depend on a well-defined interface and on the substitutability of its implementations, LSP applies.
- The cost of violation is architectural: one nonconforming implementation (the taxi-aggregator `dest` vs `destination` example) forces special-case logic, and the workarounds (configuration-driven dispatch mechanisms) can pollute the architecture with significant extra machinery. Hard-coding a special case name (e.g., `if (uri.startsWith("acme.com"))`) invites mysterious errors and security breaches.

## ISP: The Interface Segregation Principle

**Don't depend on things you don't need.**

- Original form: if a class OPS offers op1/op2/op3 and User1 only calls op1, then in a language like C++ User1 still source-depends on op2 and op3, and a change to op2 forces User1 to be recompiled and redeployed even though nothing it cares about changed. Segregating the operations into per-user interfaces (User1 depends only on U1Ops) removes that.
- Language nuance: statically typed languages (C++ `#include`) create the hardest source-code dependencies; Java/C# dependencies are softer (declaration-based); dynamically typed languages (Ruby, Python) infer interfaces at runtime, so no source dependencies force recompilation — one reason dynamic languages produce more flexible, less coupled systems. This could suggest ISP is merely a language issue.
- But the deeper concern is design-level: depending on a module that carries more than you need (a framework F bound to database D — changes to D's unused features may well force redeployment of F and S, and a failure in one of them may cascade into F and S) "can cause you troubles that you didn't expect."
- Reappears at the component level as the **Common Reuse Principle** (CRP).

## DIP: The Dependency Inversion Principle

**High-level policy should not depend on low-level detail; details should depend on policies.** Source code dependencies should refer only to abstractions, not to concretions. As James Grenning puts it: "It's better to depend on something you control than on something you don't control, lest it end up controlling you."

- Historically, source dependencies followed the flow of control (high-level modules called, and thus depended on, low-level modules). Polymorphic interfaces let you invert a source dependency against the flow of control. "This ability is power!" — it gives the designer absolute control over every source code dependency, enabling **plug-in architectures** where business rules are independent of UI and database.
- Crucial exception: this is not a hard-and-fast rule. Stable concretions like Java's `String` are fine to depend on — we ignore the stable background of OS and platform facilities. **It is the volatile concrete elements — modules under active development and frequent change — that we must avoid depending upon.**
- **Stable Abstractions**: interfaces are generally less volatile than implementations (interface changes force implementation changes, but implementation changes don't always, or even usually, require interface changes). Good designers work hard to add functionality to implementations without changing interfaces — "This is Software Design 101."
- The specific coding practices (written as rules, but "actually more like warnings"):
  - **Don't refer to volatile concrete classes.** Refer to abstract interfaces; this constrains object creation and generally enforces Abstract Factories. The rule applies in statically and dynamically typed languages alike — in a dynamic language, a "concrete module" is any module in which the functions being called are implemented.
  - **Don't derive from volatile concrete classes.** Inheritance is the strongest, most rigid source-code relationship in static languages; use with great care (less of a problem, but still a dependency, in dynamic languages).
  - **Don't override concrete functions.** Overriding inherits the function's dependencies rather than eliminating them; make the function abstract with multiple implementations instead.
  - **Never mention the name of anything concrete and volatile.**
- Pragmatism: a pragmatic programmer will violate this principle frequently, but a wise one considers the warnings first. Slavish obedience can lead to an explosion of interfaces nobody needs; blithe ignorance can cause tangled, rigid software. Conform **gradually, as the system evolves and needs arise** — backed by a test suite "they trust with their lives," so adding inverting interfaces later is relatively easy and free of risk.
- **Factories**: object creation requires a source dependency on the concrete definition, so use an Abstract Factory; the application calls a factory interface, and the concrete factory on the other side of the boundary instantiates the implementation.
- **Concrete Components**: DIP violations cannot be entirely removed; gather them into a small number of concrete components (typically `main`) kept separate from the rest of the system. `main` instantiates the concrete factories and hands them to the abstract side.
- The architectural boundary line separates abstract from concrete; all source dependencies cross it pointing toward the abstract side, against the flow of control — this becomes the **Dependency Rule** of high-level architecture.

## In practice

- Before grouping code into a class/module, ask: which actor (which group of people) will demand changes to this? Never mix code answering to different actors.
- When sharing an algorithm between two features, check whether the features answer to different actors; if so, accidental duplication coupling is worse than the duplication — separate them.
- When a new requirement arrives, measure your design by how much existing code must change; aim for zero (add new code instead).
- Point every dependency toward the thing you want to protect from change: business rules at the top, UI/database/views at the bottom.
- Before subclassing or implementing an interface, verify the implementation is fully substitutable — no caller should need an `if` to detect which implementation it got.
- Building multiple implementations of one interface (classes, services, REST endpoints)? Treat the interface as a contract; one deviant implementation can pollute the whole architecture.
- Don't make clients depend on operations or modules they don't use; split fat interfaces, and avoid frameworks/dependencies that carry baggage you don't need.
- Refer to abstractions, not volatile concretions; use factories for creating volatile concrete objects; confine unavoidable concrete dependencies to `main`-like components.
- Depending on stable platform facilities (e.g., `String`, the OS) is fine — don't abstract them.
- Add inverting interfaces gradually, as needs arise, with a trusted test suite — don't pre-build an interface explosion.
