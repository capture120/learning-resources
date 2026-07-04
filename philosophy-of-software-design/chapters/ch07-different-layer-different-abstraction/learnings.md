# Chapter 7: Different Layer, Different Abstraction

## Central idea

Software systems are built in layers, where higher layers use facilities provided by lower layers. In a well-designed system, every layer provides a *different* abstraction from the layers above and below it; as an operation moves up or down through method calls, the abstraction should change at each call. When adjacent layers offer similar abstractions, that similarity is a red flag for a broken class decomposition: the duplicated layer adds interface complexity without adding functionality.

## Key concepts

- **Layered abstractions.** Each layer should contribute its own distinct abstraction. Example layerings: a file system's top layer exposes files as variable-length byte arrays, the layer below caches fixed-size disk blocks in memory, and the bottom layer is device drivers moving blocks between storage and memory. In TCP, the top layer is a reliable byte stream while the layer beneath transmits bounded-size packets best-effort (some lost or reordered).

- **Pass-through method.** When adjacent layers have similar abstractions, the problem most often manifests as pass-through methods. A pass-through method is one that does little or nothing except invoke another method whose signature is similar or identical to its own. Pass-through methods make classes shallower: they add interface complexity (more API for developers to learn) without adding any functionality to the system. They also create dependencies between classes — if the underlying method's signature changes, the pass-through signature must change to match. Their deeper meaning: they signal confusion over the division of responsibility between classes; the same abstraction is owned by two places at once.

- **Dispatcher.** A method that uses its arguments to select which of several other methods to invoke, then passes most or all of its arguments to the chosen method. Its signature often matches the signatures of the methods it calls, but it is *not* a pass-through: choosing the right handler is real, useful functionality.

- **Decorator (wrapper).** An object that takes an existing object and extends its functionality while providing an API similar or identical to the underlying object, forwarding calls to it. The motivation is to separate special-purpose extensions from a generic core, but decorators tend to be shallow: lots of boilerplate (many pass-through methods) for a small amount of new functionality.

- **Pass-through variable.** Another form of API duplication across layers: a variable passed down through a long chain of methods that don't use it, only so a low-level method eventually can. Every intermediate method must declare it and be aware of it, which adds complexity without functionality; adding a new such variable later forces edits to many interfaces along every relevant path.

- **Context object.** An object holding all of an application's system-global state (anything that would otherwise be a pass-through variable or global variable): configuration options, shared subsystems, performance counters. One context exists per instance of the system, so multiple instances can coexist in one process. A reference to the context is stored as an instance variable in most major objects and passed explicitly only in constructors.

## Actionable principles and decision rules

- **Make each layer's abstraction different from its neighbors'.** If walking an operation down the call stack shows the same abstraction at two adjacent levels, the decomposition is wrong — one of the layers is not paying for itself.

- **Put the interface to a piece of functionality in the same class that implements it.** A class that exposes `insertString` while another class fully implements insertion splits one responsibility across two classes; that is usually a bad idea.

- **When you find pass-through methods, ask: "Exactly which features and abstractions is each of these classes responsible for?"** You will usually find overlapping responsibilities. Then refactor so each class has a distinct, coherent set of responsibilities, using one of three moves (Figure 7.1):
  1. Expose the lower-level class directly to the higher class's callers, removing the feature from the higher class entirely.
  2. Redistribute functionality between the classes so neither needs to call through the other.
  3. If the classes can't be disentangled, merge them into one class.

- **Judge same-signature methods by whether each contributes significant functionality, not by the signature duplication itself.** Duplication of signatures is fine when each method does distinct useful work. Dispatchers qualify. So do multiple implementations of one interface (e.g., disk drivers in an OS): they actually *reduce* cognitive load, because learning one teaches you all of them. Note that such same-interface methods usually live in the same layer and do not invoke each other — that is what distinguishes them from pass-throughs.

- **Before creating a decorator, exhaust the alternatives.** Ask, in order:
  1. Can the new functionality go directly into the underlying class? Do this when it is relatively general-purpose, logically related to the underlying class, or used by most users of that class (e.g., buffering should have been built into Java's `InputStream`, since nearly everyone wraps it in `BufferedInputStream` anyway).
  2. If the functionality is specialized for one use case, can it merge into that use case instead of becoming its own class?
  3. Can it merge into an existing decorator, making one deeper decorator instead of multiple shallow ones?
  4. Does it really need to *wrap* the base class at all, or could it be a stand-alone class independent of it (e.g., scrollbars implemented separately from the window rather than wrapping all window functionality)?

  Wrappers occasionally make sense — chiefly when an external class whose interface you cannot modify must conform to a different interface in your application, so a wrapper translates between them. Such situations are rare; there is usually a better alternative.

- **Make a class's interface different from its implementation.** The representations used internally should differ from the abstractions in the interface. If interface and implementation use similar abstractions, the class probably isn't deep: it isn't hiding anything. A class earns its keep precisely by the gap between a convenient interface and an inconvenient internal representation (e.g., a character-oriented text API over line-oriented storage). Do not mechanically mirror the internal data structure in the API.

- **Eliminate pass-through variables; prefer a context object.** Options ranked by the book:
  - Store the variable in an object already shared by the topmost and bottommost methods — but such an object may itself just be a pass-through variable (how else does the bottom method reach it?).
  - A global variable avoids the threading-through, but globals almost always cause other problems: notably, they make it impossible to run two independent instances of the system in one process, which matters a lot in testing even if not in production.
  - **Best available: a context object.** Add new global state to the context and only the context's constructor/destructor changes; no intermediate interfaces are touched. The context centralizes global state so it is easy to find and manage, and tests can reconfigure the application by setting fields on the context. To keep the context itself from becoming a pass-through variable, store a reference to it as an instance variable in most major objects; when creating a new object, the creator pulls the context from its own object and passes it to the new object's constructor. The context then appears as an explicit argument only in constructors.

- **Demand that every design element pay for itself.** Every interface, argument, function, class, or definition adds complexity because developers must learn about it. An element provides a net gain only if it eliminates more complexity than it introduces (e.g., a class that encapsulates functionality so users needn't know about it). Pass-through methods, shallow decorators, and pass-through arguments fail this test: they impose learning cost without contributing functionality. Ousterhout frames the entire "different layer, different abstraction" rule as just an application of this idea: when different layers share an abstraction, there is a good chance they haven't provided enough benefit to compensate for the infrastructure they represent.

## Nuances and counterpoints

- **Interface duplication is not automatically bad.** The test is functional contribution, not signature matching. Dispatchers and multiple implementations of one interface are legitimate and valuable. Don't pattern-match on "two methods with the same signature" and refactor reflexively.

- **The decorator pattern is easy to overuse.** Creating a new wrapper class for every small feature produces an explosion of shallow classes (the book's standing criticism of the Java I/O library). This is a direct pushback on design-pattern orthodoxy: a named pattern is not a justification; the resulting class still must be deep.

- **Context objects are a pragmatic compromise, not an ideal.** They inherit most disadvantages of global variables: it may be unclear why a variable exists or where it is used; without discipline a context becomes a huge grab-bag of data creating nonobvious dependencies across the system; and contexts can create thread-safety issues (mitigate by making context variables immutable). Ousterhout uses them anyway because he has found no better solution. Don't treat the context as a dumping ground.

- **Shared-object and global-variable workarounds have real costs.** A shared object may merely relocate the pass-through problem; globals break multi-instance testing. Weigh these before reaching for them.

## Red flags

- **Pass-Through Method (explicit, boxed in the book).** A method that does nothing except pass its arguments to another method, usually with the same API as the pass-through method. This typically indicates there is not a clean division of responsibility between the classes.
- **Adjacent layers with similar abstractions** — the chapter's framing red flag; it suggests a problem with the class decomposition.
- A class whose interface uses the same abstractions as its implementation (e.g., API mirrors the internal data structure) — the class is probably shallow.
- Many shallow wrapper/decorator classes, each adding one tiny feature with heavy boilerplate.
- A variable threaded through long chains of methods that never use it (pass-through variable).
- A context object growing into an undisciplined grab-bag of loosely related state.
