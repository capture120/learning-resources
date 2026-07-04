# Chapter 12: Objects and Data Structures

Objects and data structures are very nearly opposites, not synonyms. An object hides its data and exposes behavior; a data structure exposes its data and has no meaningful behavior. Each makes a different kind of change cheap, so the central skill is deciding — per part of the system — which is more likely to change, behavior or data, and hiding the volatile side behind the static one.

## What Is an Object?

An object is a bundle of data manipulated by dedicated functions, only some of which are public; the data's structure is hidden. Alan Kay's biology analogy drives the intuition: objects are like cells passing molecular messages — they tell each other what to do and never ask questions. If you only tell an object what to do and never ask it anything, its internal data is irrelevant to you. OO design therefore focuses primarily on behavior and the flow of messages; the internal data structure is nearly irrelevant to the majority of that behavior. Avoiding all queries is impractical, but keep them to a minimum.

A database is the opposite: a published set of data structures with no intrinsic functions, where the schema dominates the programs that surround it.

## Data Abstraction

We keep variables private so no one else depends on them, preserving the freedom to change their type or implementation on a whim. Hiding implementation is not just a matter of putting a layer of getters and setters between callers and variables — hiding implementation is about abstractions. Expose abstract interfaces that let users manipulate the *essence* of the data without knowing how it is stored (e.g., `getPercentFuelRemaining()` instead of `getGallonsOfGasoline()` plus `getFuelTankCapacityInGallons()`). Single-variable getters/setters expose implementation even when the fields are private. Put serious thought into the best way to represent an object's data; the worst option is to blithely add getters and setters.

Abstraction can also encode behavioral policy: a `Point` interface whose setters take both coordinates at once enforces that coordinates are set atomically, and hides whether the implementation is rectangular or polar.

## Data/Object Antisymmetry

The fundamental dichotomy:
- Procedural code (functions over data structures) makes it **easy to add new functions** without changing existing data structures, but **hard to add new data structures** because every function must change.
- OO code makes it **easy to add new data structures (classes)** without changing existing functions, but **hard to add new functions** because every class must change.

What is hard for OO is easy for procedures, and vice versa. Mature programmers know that "everything is an object" is a myth — sometimes you really do want simple data structures with procedures operating on them. (Workarounds like Visitor/dual-dispatch exist but carry their own costs and effectively return the design to procedural structure.)

## The Law of Demeter

A module should not know about the innards of the objects it manipulates. A method `f` of class `C` should only call methods of: `C` itself; objects `f` creates; objects passed as arguments to `f`; objects held in instance variables of `C`. Do not invoke methods on objects returned by any of those calls. In short: **be shy, talk to friends, and don't talk to strangers.**

Crucial nuance: Demeter applies only to *objects*. If `ctxt.options.scratchDir.absolutePath` traverses pure data structures (public data, no behavior), they naturally expose their structure and Demeter does not apply. The issue would be a lot less confusing if we adopted the convention that data structures have public variables and no functions, while objects have private variables and public functions.

## Trainwrecks

Chained calls like `ctxt.getOptions().getScratchDir().getAbsolutePath()` are called trainwrecks — sloppy style, generally to be avoided; it is usually best to split them into separate statements. But splitting doesn't remove the knowledge problem: the calling function still knows how to navigate through many objects' internals. Whether it violates Demeter depends on whether the things traversed are objects or data structures.

## Hybrids

Avoid half-object/half-data-structure hybrids: structures with significant functions *and* public variables (or accessors/mutators that effectively make private variables public). They make it hard to add new functions **and** hard to add new data structures — the worst of both worlds — and indicate a muddled design whose authors didn't know whether they needed protection from new functions or new types. (Related smell: feature envy.)

## Hiding Structure / "Tell the Other Guy"

When tempted to navigate an object graph to fetch a resource, ask *why* you want it, and instead tell the object to do that thing. Instead of getting the scratch directory's absolute path to build a file, tell the context: `ctxt.createScratchFileStream(classFileName)`. This lets the object hide its internals and spares the caller a Demeter violation. Fix trainwrecks by telling objects what you want done, not by traversing the network of objects to gather resources. Dave Thomas and Andy Hunt's one-sentence summary of OO: "Keep it DRY, Shy, and Tell the Other Guy" (Don't Repeat Yourself; Law of Demeter; message-passing / command–query separation).

## Data Transfer Objects

The quintessential data structure is a class with public variables and no functions — a DTO. DTOs are genuinely useful for communicating with databases, parsing socket messages, and as the first stage in translating raw data into application objects. The Java "bean" form (private fields with getters/setters) is quasi-encapsulation that comforts OO purists but usually provides no other benefit — a DTO might as well have public fields.

## The Object/Relational "Impedance Mismatch"

ORMs cannot map a relational database to objects, because databases contain data structures, and data structures and objects are orthogonal. ORMs don't create objects; they just load data structures — a convenient table-to-struct conversion, nothing more. Don't expect an ORM layer to give you behavioral objects.

## Using Objects and Data Structures: hide the volatile

The choice comes down to which is more likely to grow and change. If behaviors are volatile, hide the behaviors and expose the static data structure (e.g., enterprise databases: schema is stable, business rules churn). If data structures are volatile, expose the static behavior and hide the data (e.g., an IDE: editing behavior is stable, but each new language brings a new data structure). We hide the volatile so changes don't affect the static — we build a barrier protecting the static from the volatile. This judgment requires thought and experience, and may go differently in different parts of the same system.

## Switch Statements and the OO/Procedural Trade-off

A switch (or if/else chain) on a type code, duplicated across many functions, is rigid (one requirement change forces many module changes — violating the Single Responsibility Principle and the Open–Closed Principle), fragile (you'll miss a case, especially where clever optimizations disguised the switch), and immobile (types are woven through the system, so parts can't be deployed independently — violating the Dependency Inversion Principle). Polymorphism removes all of that *for new types*: adding a type touches nothing existing (except, perhaps, the main program), and types become independently deployable.

But the OO solution only protects you from new types. If the change is a new *function* (e.g., `renderDropShadow`), polymorphism forces you to touch every class, while the procedural version needs only the new `renderDropShadow` functions added in one place (the `ShapeManager`). Use OO when you want to add new data types to existing functions; use procedural switches when you want to add new functions to existing data types.

Uncle Bob's general rule for switch statements: prefer designs that interpret change as new data types (hence prefer OO), and locate switch/if-else chains **at the periphery of the system** (e.g., the main module), with **at most one per switchable type**, whose cases **create the polymorphic objects** the rest of the system uses. But don't force an OO round peg into a procedural square hole: where behavior is overwhelmingly more volatile than data, use the switch.

## But What About Performance?

Compilers can make switch statements somewhat faster than polymorphic dispatch, so OO designs can incur a slight performance penalty. Most programmers have no need to care about stray nanoseconds. If you genuinely do, concentrate switches in the time-critical inner loops where they help — do not abandon OO design throughout the whole system for the sake of a few hot spots.

## In practice

- Before exposing data, ask: what abstraction expresses the *essence* of this data? Never blithely add getters and setters.
- Decide explicitly whether each type is an object (private data, public behavior) or a data structure (public data, no behavior) — never both. Reject hybrids.
- Tell objects what to do; don't query them for internals and do the work yourself ("Tell the Other Guy").
- Apply the Law of Demeter to objects: call methods only on yourself, your fields, your arguments, and things you create. Skip it for pure data structures and DTOs.
- When designing a component, ask which will change more — behavior or data — and hide the volatile side. Expect different answers in different parts of the system.
- Anticipating new types? Use polymorphism. Anticipating new operations on fixed types? A procedural switch over data structures is the right tool, not a smell.
- Keep type switches at the system's periphery, at most one per switchable type, creating polymorphic objects for the rest of the system.
- Use plain public-field DTOs at boundaries (databases, sockets); don't dress them up with getters/setters.
- Treat ORMs as data-structure loaders, not object factories.
- Only trade polymorphism for switches on performance grounds in measured, time-critical inner loops.
