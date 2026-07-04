# Chapter 9 Examples: Better Together Or Better Apart?

## HTTP server: reading and parsing requests (bring together if information is shared)

**Problem:** A student project implementing an HTTP server needed to read an incoming request from a network socket and parse it into its components.

**Bad approach:** Two methods in different classes — one read the request text from the socket into a string, the other parsed that string. The split looked clean, but both methods ended up encoding deep knowledge of the HTTP request format. The reader could not even find the end of a request without doing most of the parsing work: it had to parse header lines to locate the header that gives the overall request length. The two methods shared information (the HTTP wire format), so the separation duplicated that knowledge.

**Good approach:** Read and parse the request in the same place. When the two classes were merged into one, the code became shorter and simpler. The merge also eliminated the interface that returned the raw request string from the first method and passed it to the second.

**Lesson:** Bring code together when the pieces share information; combining also simplified the interface (Sections 9.1 and 9.2).

## Java I/O: FileInputStream and BufferedInputStream (bring together to simplify the interface)

**Problem:** Java's I/O library puts buffering in a separate `BufferedInputStream` class that callers must explicitly wrap around a `FileInputStream`.

**Better design:** If the two classes were combined and buffering were on by default, the vast majority of users would never need to know buffering exists. A combined `FileInputStream` could still offer methods to disable or replace the default buffering, but most users would never learn about them.

**Lesson:** Combining functionality can let common behavior happen automatically, hiding it from users entirely — a simpler, deeper interface (Section 9.2).

## Duplicated error logging in packet-processing code (bring together to eliminate duplication; Figures 9.1 and 9.2)

**Problem:** Code processed incoming network packets in a `switch` on the packet opcode. For each packet type (`DATA`, `GRANT`, `RESEND`, ...), if the packet was too short for that type, the code logged a warning and returned. The identical multi-line `LOG(WARNING, "%s packet from %s too short (%u bytes)", ...)` call was copy-pasted into every case:

```c
switch (common->opcode) {
    case DATA: {
        DataHeader* header = received->getStart<DataHeader>();
        if (header == NULL) {
            LOG(WARNING, "%s packet from %s too short (%u bytes)", ...);
            return;
        }
        ...
    }
    case GRANT: { /* same NULL check, same LOG, return */ }
    ...
}
```

**Good approach:** Restructure so the snippet executes in only one place. Move the log-and-return code to a labeled block at the end of the method and `goto` it from each error point:

```c
switch (common->opcode) {
    case DATA: {
        DataHeader* header = received->getStart<DataHeader>();
        if (header == NULL)
            goto packetTooShort;
        ...
    }
    ...
}
packetTooShort:
    LOG(WARNING, "%s packet from %s too short (%u bytes)", ...);
    return;
```

**Lesson:** When extraction into a method would be awkward, refactor so the duplicated snippet only needs to exist once. `goto` is generally a bad idea and can produce indecipherable code if used indiscriminately, but it is useful precisely here: escaping from nested code to a shared exit path (Section 9.3).

## GUI text editor: general text class vs. UI operations (separate general-purpose and special-purpose code)

**Problem:** In the GUI editor project (from Chapter 6), where should operations like "delete the selection" live?

**Bad approach:** An earlier design implemented specialized user-interface operations inside the text class, mixing a general-purpose mechanism with code for one particular use. This created information leakage and extra interfaces.

**Good approach:** The text class provides only general-purpose text operations; operations particular to the user interface (such as deleting the selection) live in the user interface module.

**Lesson:** A general-purpose mechanism should contain just the mechanism. Specializing code belongs in the module associated with that purpose (Section 9.4). Violating this is the Special-General Mixture red flag.

## GUI text editor: insertion cursor and selection (a case where separation wins)

**Design problem:** The editor shows a blinking insertion cursor and a highlighted selection range. They seem related: the cursor always sits at one end of the selection, clicking and dragging sets both, and text insertion first deletes any selected text then inserts at the cursor.

**Bad approach:** One project team managed both with a single combined object storing two file positions plus booleans for which end was the cursor and whether the selection existed. The combined object was awkward:

- Higher-level code still treated selection and cursor as distinct entities and manipulated them separately (during insertion it called one method to delete the selected text, then another to fetch the cursor position) — so the combination gave callers no benefit.
- The implementation got *more* complex: the cursor position wasn't stored directly but derived by testing a boolean and picking the right end of the selection.

**Good approach:** Separate the selection and cursor. Both usage and implementation got simpler. In the revised version, no special class existed for either; a new general `Position` class (line number + character within line) represented a location in the file. The selection became two `Position`s, the cursor one. `Position` found other uses elsewhere in the project.

**Lesson:** Surface relatedness ("manipulated together") is not enough — these pieces were not closely related enough to combine. Separation gave simpler interfaces and simpler implementations, and the example also shows the benefit of a lower-level but more general-purpose abstraction (Chapter 6's theme) (Section 9.5).

## Student project: separate NetworkErrorLogger class (a case where joining wins)

**Bad approach:** In a student project, errors were not logged where they were detected. Instead, each catch block called a method on a special nested logging class defined at the bottom of the same file:

```java
try {
    rpcConn = connectionPool.getConnection(dest);
} catch (IOException e) {
    NetworkErrorLogger.logRpcOpenError(req, dest, e);
    return null;
}
```

`NetworkErrorLogger` held methods like `logRpcOpenError`, `logRpcSendError`, `logRpcReceiveError` — each logging one kind of error, each mostly a single `logger.log(...)` line, each preceded by a sizable doc comment, each called from exactly one place.

**Why it failed:** The separation added complexity with no benefit. The methods were shallow (one line of work, lots of documentation, more interface than implementation). They were highly dependent on their single invocation sites: a reader of the call would flip to the logging method to check what got logged, and a reader of the logging method would flip to the call site to understand its purpose — conjoined methods.

**Good approach:** Eliminate the logging methods and put the log statements at the points where the errors are detected. This makes the code easier to read and removes the methods' interfaces.

**Lesson:** Join code when separation creates shallow, single-caller, conjoined methods (Section 9.6; Conjoined Methods red flag).

## Splitting methods: the three shapes (Figure 9.3)

**Setup:** A method (a) can be split two ways, and one way to get it wrong.

- **(b) Extract a subtask — the best way.** A child method holds a cleanly separable subtask; the parent keeps the original interface and invokes the child. Valid only when readers of the child need nothing from the parent and readers of the parent need nothing of the child's implementation. The child is typically general-purpose enough to imagine other callers. If you flip back and forth between parent and child, the split was a bad idea (Conjoined Methods).
- **(c) Split into two caller-visible methods — rarely works.** Sensible only when the original method's interface was overly complex because it did multiple unrelated things. Each new method must end up with a simpler interface, and ideally most callers need only one of them. The new methods will be more focused in what they do. If callers must call both and pass state between them, complexity went up. Judge this split solely by whether it simplifies callers. A good sign: the new methods are more general-purpose than the original — you can imagine using them separately in other situations.
- **(d) Several shallow methods — avoid.** The failure mode of (c): callers invoke each piece in sequence, shuttling state, and every piece is shallow.

**Supporting point:** Long methods aren't always bad. A method with five sequential, relatively independent 20-line blocks reads fine one block at a time; if the blocks interact in complex ways, keeping them together matters even more so readers see everything at once. Hundreds of lines is fine given a simple signature and easy reading — that method is deep.

**Lesson:** Each method should do one thing and do it completely. Split only when it produces cleaner abstractions overall (Section 9.7).

## A different opinion: Clean Code on function length

**The opposing view:** In *Clean Code*, Robert Martin argues functions should be split based on length alone: functions should be small, "smaller than that," even 10 lines is too long, and blocks inside `if`/`else`/`while` should be one line — probably a function call — so indent depth stays at one or two.

**Ousterhout's response:** Shorter is generally easier to read, but below a few dozen lines further shrinking barely helps. The real question is whether breaking up a function reduces the complexity of the whole system: is several short functions plus the work of understanding how they compose easier than one larger function? More functions mean more interfaces to document and learn. Functions made too small lose independence and become conjoined functions that must be read together — at which point the single larger function is better, keeping related code in one place.

**Lesson:** Depth beats length. First make functions deep, then make them short enough to read easily — never sacrifice depth for length (Section 9.8).
