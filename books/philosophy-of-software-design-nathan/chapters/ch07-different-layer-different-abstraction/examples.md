# Chapter 7 Examples: Different Layer, Different Abstraction

## File system layering (good layering reference model)

A file system stacks three layers, each with a distinct abstraction. The top layer implements the *file*: a variable-length array of bytes, updated by reading and writing variable-length byte ranges. The middle layer implements an in-memory cache of fixed-size disk blocks; callers can assume frequently used blocks stay in memory for fast access. The bottom layer is device drivers that move blocks between secondary storage and memory.

**Principle demonstrated:** in a well-designed system the abstraction changes at every layer boundary — variable-length byte ranges, then fixed-size cached blocks, then physical block transfer. Each layer adds real functionality over the one below.

## TCP network transport (good layering reference model)

The topmost layer of a transport protocol like TCP provides a stream of bytes delivered reliably from one machine to another. It is built on a lower layer that transmits bounded-size packets between machines on a best-effort basis: most packets arrive, but some are lost or delivered out of order.

**Principle demonstrated:** same as above — the reliable-stream abstraction is genuinely different from the unreliable-packet abstraction below it, and that difference is the layer's value.

## Student GUI text editor: `TextDocument` pass-through methods (bad)

A student project implementing a GUI text editor contained a class consisting almost entirely of pass-through methods — 13 of its 15 public methods were pass-throughs. Sketch of the class:

```java
public class TextDocument ... {
    private TextArea textArea;
    private TextDocumentListener listener;
    ...
    public Character getLastTypedCharacter() {
        return textArea.getLastTypedCharacter();
    }
    public int getCursorOffset() {
        return textArea.getCursorOffset();
    }
    public void insertString(String textToInsert, int offset) {
        textArea.insertString(textToInsert, offset);
    }
    public void willInsertString(String stringToInsert, int offset) {
        if (listener != null) {
            listener.willInsertString(this, stringToInsert, offset);
        }
    }
    ...
}
```

Of the four methods shown, only the last has any functionality at all, and it is trivial (a null check on one variable). The problems: the class's interface complexity grows while total system functionality does not; and the pass-throughs create dependencies — if `TextArea.insertString` changes signature, `TextDocument.insertString` must change to match. The root cause is confused responsibility: `TextDocument` offers `insertString`, but insertion is implemented entirely in `TextArea`. The interface to a piece of functionality should live in the class that implements it.

**Fix:** the project had three classes with intertwined responsibilities (`TextDocument`, `TextArea`, `TextDocumentListener`). The student eliminated the pass-throughs by moving methods between classes and collapsing the three classes into two with clearly differentiated responsibilities.

**Principle demonstrated:** the Pass-Through Method red flag; pass-throughs signal no clean division of responsibility, fixed by refactoring so each class owns a distinct, coherent set of responsibilities.

## Figure 7.1: three ways to eliminate pass-through methods

Class C1 sits above class C2 and contains three pass-through methods that do nothing but invoke same-signature methods in C2. Three refactorings remove them:

- **(b) Expose the lower class directly:** C1's callers invoke C2 themselves; C1 drops all responsibility for those features.
- **(c) Redistribute functionality:** move methods between C1 and C2 so each owns its features outright and neither calls through the other.
- **(d) Merge:** if the classes can't be disentangled, combine C1 and C2 into a single class.

**Principle demonstrated:** the concrete refactoring menu for the pass-through red flag.

## Web server URL dispatcher (legitimate signature duplication)

When a web server receives an HTTP request, it invokes a dispatcher that examines the request's URL and selects a specific handler method — some URLs return a file from disk, others invoke a procedure in PHP or JavaScript. The dispatch is often intricate, driven by rules matched against the URL. The dispatcher's signature typically matches the handlers' signatures, and it passes most or all of its arguments along.

**Principle demonstrated:** signature duplication is fine when the method contributes real functionality. The dispatcher's work — choosing which handler carries out each task — is useful, so it is not a pass-through despite the matching signatures.

## OS disk drivers: many implementations of one interface (legitimate)

An operating system has multiple disk drivers, one per kind of disk, all implementing the same interface. Each provides distinct, useful functionality.

**Principle demonstrated:** several methods sharing a signature is good when each is a different implementation of the same abstraction — it *reduces* cognitive load, since learning one interface lets you work with all the implementations. Note the structural difference from pass-throughs: these methods sit in the same layer and don't invoke each other.

## Java I/O `BufferedInputStream` and windowing `ScrollableWindow` (decorator pitfalls)

Two decorator examples:

- `BufferedInputStream` (from the Chapter 4 Java I/O discussion) wraps an `InputStream`, offering the same API plus buffering: a one-character `read` triggers a large block `read` on the underlying stream and saves the extra bytes for future calls.
- In windowing systems, a `Window` class implements a basic non-scrollable window, and `ScrollableWindow` decorates it by adding horizontal and vertical scrollbars.

Decorators separate special-purpose extensions from a generic core, but they tend to be shallow: heavy boilerplate and many pass-through methods for little new functionality. Overusing the pattern — a new class for every small feature — produces an explosion of shallow classes, as in the Java I/O library.

The chapter's alternatives, applied to these cases: buffering should have been added directly to the underlying class, because virtually everyone who creates an `InputStream` also wraps it in a `BufferedInputStream` and buffering is a natural part of I/O — the classes should have been combined. The scrollbars could probably be implemented as a stand-alone class independent of the window, rather than wrapping all of the window's functionality.

The one situation where wrappers genuinely make sense: an external class whose interface cannot be modified must conform to a different interface required by your application, so a wrapper translates between the two. Such cases are rare.

**Principle demonstrated:** before creating a decorator, prefer adding functionality to the underlying class, merging with the use case, merging into an existing decorator, or building a stand-alone class.

## Text editor text class: line-oriented vs. character-oriented API (interface vs. implementation)

In the text editor class project (Chapter 6), most teams stored text as lines, each line held separately. Some teams also designed the text class API around lines, with methods like `getLine` and `putLine` — the interface mirrored the implementation. This made the class shallow and awkward: user-interface code commonly inserts text mid-line (as the user types) or deletes ranges spanning lines, so callers had to split and join lines themselves. That nontrivial code ended up duplicated and scattered across the UI implementation.

The better design kept the line-based internal representation but exposed a character-oriented interface: an `insert` method that inserts an arbitrary string (possibly containing newlines) at an arbitrary position, and a `delete` method that deletes text between two arbitrary positions. Line splitting and joining is now encapsulated inside the text class, making it deeper and simplifying all higher-level code.

**Principle demonstrated:** a class's interface should normally differ from its implementation; the gap between the convenient character-oriented API and the line-oriented storage *is* the valuable functionality the class provides. Mirroring internals in the API makes a class shallow.

## Datacenter service: the `cert` pass-through variable and the context object (Figure 7.2)

A datacenter service takes a command-line argument describing certificates for secure communication. Only a low-level method `m3` needs this information, when it calls a library function to open a socket. But `cert` is passed down through every method on the path from `main` to `m3`, appearing in each intermediate signature:

```
main(argc, argv) -> m1(..., cert, ...) -> m2(..., cert, ...) -> m3(..., cert, ...) { openSocket(cert, ...) }
```

Costs: every intermediate method must be aware of a variable it never uses; and if a new variable appears later (e.g., the system initially had no certificate support), you must modify a large number of interfaces along every relevant path.

The chapter walks through four approaches (Figure 7.2):

- **(a) Status quo:** thread `cert` through `m1` and `m2` — the pass-through variable problem.
- **(b) Shared object:** if an object holding other network-communication information is already accessible to both `main` and `m3`, store `cert` there. Catch: that object may itself be a pass-through variable — how else does `m3` get access to it?
- **(c) Global variable:** avoids the threading, but globals almost always create other problems — notably, you cannot create two independent instances of the system in one process because their accesses to the globals conflict. Multiple instances may seem unlikely in production but are often needed in testing.
- **(d) Context object (Ousterhout's usual solution):** a context stores all of the application's global state — configuration options, shared subsystems, performance counters, plus `cert` — with one context per system instance, so multiple instances coexist in one process. Because the context would otherwise itself become a pass-through variable, a reference to it is saved as an instance variable in most of the system's major objects; when a method creates a new object, it retrieves the context from its own object and passes it to the new object's constructor. The context is thus available everywhere but appears as an explicit argument only in constructors. Adding a new global variable touches only the context's constructor and destructor. The context also centralizes global state for easy discovery and lets tests reconfigure the application by setting context fields — far harder with pass-through variables.

Caveats stated with the example: context variables carry most of the disadvantages of globals (unclear why a variable exists or where it's used); an undisciplined context becomes a huge grab-bag creating nonobvious dependencies; contexts can create thread-safety issues, best avoided by keeping context variables immutable. Ousterhout has found no better solution.

**Principle demonstrated:** pass-through variables add complexity with no functionality; a context object is the most workable (though imperfect) way to eliminate them.
