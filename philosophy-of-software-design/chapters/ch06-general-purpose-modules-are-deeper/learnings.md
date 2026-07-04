# Chapter 6: General-Purpose Modules are Deeper

## Central idea

Over-specialization may be the single greatest cause of complexity in software; general-purpose code is simpler, cleaner, and easier to understand. When designing a module, make it "somewhat general-purpose": the functionality should reflect today's needs, but the interface should not — it should be general enough to support multiple uses. General-purpose interfaces are simpler and deeper than special-purpose ones, result in less implementation code, and provide more information hiding. The principle applies at many levels: making an API general-purpose is one of the best ways to produce a deep module, and eliminating special cases is one of the most effective ways to simplify detailed code inside method bodies.

## Key concepts

- **The generality vs. specialization tradeoff.** The general-purpose argument: build a mechanism usable for a broad range of problems; it may find unanticipated future uses (consistent with the investment mindset of Chapter 3). The special-purpose argument: future needs are hard to predict, so a general solution may include facilities nobody ever uses or may solve today's actual problem poorly; build just what you need and refactor later (consistent with incremental development). Ousterhout initially favored the special-purpose view, then reversed it after repeatedly observing student projects: general-purpose classes were almost always better.
- **"Somewhat general-purpose."** The sweet spot. Functionality reflects current needs; the interface is general enough to support multiple uses and is easy to use for today's needs without being tied specifically to them. The word "somewhat" matters: do not build something so general it becomes difficult to use for your current needs.
- **Generality is cheaper, not just safer.** Counterintuitively, even if a class is only ever used one way, it is less work to build it general-purpose: the interface is simpler and deeper, and the implementation has less code (a few general methods replace many special-purpose ones). Reuse is a bonus, not the justification — general-purpose wins even with zero reuse.
- **Generality leads to better information hiding.** A general-purpose interface keeps higher-level abstractions (e.g., UI concepts) out of lower-level modules, so the modules can evolve independently and new high-level features need no new low-level supporting methods.
- **False abstraction.** A method that purports to hide information its callers actually need to know (e.g., a `backspace` method hiding which characters get deleted, when UI developers must know exactly that). Hiding information the caller needs creates obscurity, not abstraction. A core element of design is deciding who needs to know what, and when; when details matter, make them explicit and obvious rather than burying them behind an interface.
- **Pushing specialization up or down.** Specialization can't be eliminated — applications inevitably have specialized features. But specialized code must be cleanly separated from general-purpose code, either by pushing it **upwards** (specialized UI behavior stays in top-level application code, while lower layers stay generic) or **downwards** (e.g., device drivers: the OS defines a general interface like "read a block"/"write a block," and each driver implements it using one device's specialized commands, keeping the OS core device-agnostic and making new devices pluggable with no OS changes).
- **Special cases in code bodies.** Specialization also appears inside method bodies as special cases, producing code riddled with `if` statements that is hard to understand and bug-prone. The best fix: design the normal case so it automatically handles edge conditions with no extra code (e.g., represent "no selection" as an empty selection rather than a separate state).

## Actionable principles and decision rules

- Prefer a general-purpose interface over one tailored to known callers, because it yields a deeper, simpler API, less total code, and better information hiding — even if the module is only used one way today.
- Implement only the functionality your current needs require; do not speculatively build features. Generality belongs in the interface shape, not in extra unneeded capability.
- Define a low-level class's API only in terms of its own domain's basic operations (e.g., text insert/delete at positions), never in terms of the higher-level features that will be built with it (e.g., backspace keys, selections).
- Ask: **"What is the simplest interface that will cover all my current needs?"** Reducing the number of methods without reducing overall capability is a sign you're making the API more general-purpose — but only while each individual method stays simple. If shrinking the method count forces lots of extra arguments, you are not actually simplifying.
- Ask: **"In how many situations will this method be used?"** A method designed for one particular use is a red flag of over-specialization; try to replace several special-purpose methods with one general-purpose method.
- Ask: **"Is this API easy to use for my current needs?"** This catches overcorrection. If callers must write a lot of extra code (e.g., loops over single-character operations) to do common tasks, the interface is too primitive/general and lacks the right functionality. Support the granularity callers actually need (e.g., range operations), also for efficiency.
- When detail matters to callers, expose it explicitly in the interface; do not wrap it in a convenience method callers will have to read the source of anyway (false abstraction).
- Push specialization upward into application-level code or downward into adapter-like modules (drivers); keep the layers in between general-purpose.
- Separate general-purpose and special-purpose code **for the same mechanism** into different modules (e.g., generic undo-history management vs. undo handlers for specific entity types). It is fine — often right — to combine special-purpose code for one mechanism with general-purpose code for another in the same class, when they are closely related (e.g., text-specific undo actions living in the general-purpose text class).
- In method bodies, eliminate special cases by designing the normal case to subsume them (e.g., an always-existing empty selection means copy/delete logic needs no "no selection" checks). Eliminating special cases can also make code more efficient (developed further in Chapter 20).

## Nuances and counterpoints

- **This is not "design for the future."** Functionality should reflect current needs. The general-purpose approach here differs from speculative generality: you generalize the interface, not the feature set.
- **Don't take it too far.** A maximally general API (e.g., single-character insert/delete) can be simple and general yet painful and inefficient for real callers. Ease of use for current needs is the limiting test on generality.
- **Specialization is unavoidable** at the application's top level; the goal is reducing it and separating it cleanly, not eliminating it.
- **More information hiding is not always better.** When callers genuinely need a detail, hiding it is a false abstraction that creates obscurity. This tempers Chapter 5's information-hiding advice.
- **Recognition is easier than creation.** It is easier to recognize a clean general-purpose design than to invent one; use the three questions above as a deliberate checklist when designing interfaces.

## Red flags

- A method designed for one particular use / invoked from only a single call site — likely too special-purpose.
- A low-level class whose API mirrors the features of a specific higher-level client (UI concepts like cursors, selections, or key bindings appearing in a text-storage class) — information leakage and tight coupling between modules that should evolve independently.
- A class with a large number of shallow methods, each suitable for only one operation in one caller — high cognitive load for everyone touching either module.
- Every new high-level feature requiring a new supporting method in a lower-level class — the modules are not independent.
- Needing to write lots of extra caller-side code (loops, glue) to do common tasks with an API — the interface is too general/primitive and lacks the right functionality.
- Reducing method count only by piling on extra arguments — fake generalization.
- A "false abstraction": an interface that hides details its callers must know, forcing them to read the implementation.
- General-purpose infrastructure (e.g., a history/undo engine) embedded inside an unrelated class, mixed with entity-specific handlers and callback plumbing.
- Method bodies riddled with `if` statements checking for special states (e.g., "no selection") that a better representation of the normal case would make unnecessary.
