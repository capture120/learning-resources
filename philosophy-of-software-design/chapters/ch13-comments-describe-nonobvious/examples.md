# Chapter 13 Examples: Comments Should Describe Things that Aren't Obvious from the Code

## 1. Line-by-line comments from a research paper (comments repeat the code)

Code from a recent research paper, with one comment per line at the same level of detail as the code:

```python
ptr_copy = get_copy(obj)        # Get pointer copy
if is_unlocked(ptr_copy):       # Is obj free?
    return obj                  # return current obj
if is_copy(ptr_copy):           # Already a copy?
    return obj                  # return obj
thread_id = get_thread_id(ptr_copy)
if thread_id == ctx.thread_id:  # Locked by current ctx
    return ptr_copy             # Return copy
```

The only comment with any useful information is "Locked by current ctx," which hints at something not deducible from the code. Everything else restates the adjacent line. Diagnostic pattern: one comment per line, comment at the same level of detail as the code.

**Principle**: Don't repeat the code; comments at the same level as the code are rarely useful (red flag: Comment Repeats Code).

## 2. Scroll bars and caret variables (worthless GUI comments)

```java
// Add a horizontal scroll bar
hScrollBar = new JScrollBar(JScrollBar.HORIZONTAL);
add(hScrollBar, BorderLayout.SOUTH);

// Add a vertical scroll bar
vScrollBar = new JScrollBar(JScrollBar.VERTICAL);
add(vScrollBar, BorderLayout.EAST);

// Initialize the caret-position related values
caretX = 0;
caretY = 0;
caretMemX = null;
```

The first two comments add nothing: the code is already clear. The third case is a spot where a comment *could* help, but this one lacks the detail to be helpful (what are these values, what does `caretMemX = null` mean?). Ousterhout's test: could someone who has never seen the code write the comment just by looking at the adjacent code? Here, yes — so the comments are worthless.

**Principle**: Apply the "could a stranger write this comment from the code alone?" test; such comments are why some people think all comments are worthless.

## 3. Comments that recycle the entity's name

```java
/*
 * Obtain a normalized resource name from REQ.
 */
private static String[] getNormalizedResourceNames(HTTPRequest req) ...

/*
 * Downcast PARAMETER to TYPE.
 */
private static Object downCastParameter(String parameter, String type) ...

/*
 * The horizontal padding of each line in the text.
 */
private static final int textHorizontalPadding = 4;
```

Each comment just rearranges the words of the name plus argument names; in the second one, the only word not already in the code is "to." Meanwhile genuinely needed information is missing: what is a "normalized resource name"? What are the elements of the returned array? What does "downcast" mean? What are the units of padding, and is it one side or both?

The fix for the third one uses *different words* that explain rather than echo:

```java
/*
 * The amount of blank space to leave on the left and
 * right sides of each line of text, in pixels.
 */
private static final int textHorizontalPadding = 4;
```

It adds units (pixels), scope (both sides of each line), and defines "padding" for readers who don't know the term.

**Principle**: Use different words in the comment than in the entity's name; pick words that add information about meaning.

## 4. Vague variable comments: buffer offset and lineWidths

Two imprecise variable comments:

```c
// Current offset in resp Buffer
uint32_t offset;
```

What does "current" mean? Revised to pin down the exact semantics:

```c
// Position in this buffer of the first object that hasn't
// been returned to the client.
uint32_t offset;
```

```java
// Contains all line-widths inside the document and
// number of appearances.
private TreeMap<Integer, Integer> lineWidths;
```

Unclear that keys are line widths and values are occurrence counts; unclear whether widths are pixels or characters. Revised:

```java
// Holds statistics about line lengths of the form <length, count>
// where length is the number of characters in a line (including
// the newline), and count is the number of lines with
// exactly that many characters. If there are no lines with
// a particular length, then there is no entry for that length.
private TreeMap<Integer, Integer> numLinesWithLength;
```

The revision also improves the *name*: longer and more informative, and "length" replaces "width" because "length" suggests characters while "width" suggests pixels. Note it documents what a *missing* entry means, not just present ones.

**Principle**: Lower-level comments add precision — units, exact meaning, key/value semantics, and the meaning of absent entries; names and comments work together.

## 5. receivedValidHeartbeat (nouns, not verbs)

A boolean documented by how code manipulates it:

```java
/* FOLLOWER VARIABLE: indicator variable that allows the Receiver and the
 * PeriodicTasks thread to communicate about whether a heartbeat has been
 * received within the follower's election timeout window.
 * Toggled to TRUE when a valid heartbeat is received.
 * Toggled to FALSE when the election timeout window is reset. */
private boolean receivedValidHeartbeat;
```

This mirrors the code structure: it lists the places that modify the variable. Rewritten to describe what the variable *represents*:

```java
/* True means that a heartbeat has been received since the last time
 * the election timer was reset. Used for communication between the
 * Receiver and PeriodicTasks threads. */
private boolean receivedValidHeartbeat;
```

Shorter and more useful: from the state-based description, a reader can *infer* that the variable must be set true on heartbeat receipt and false on timer reset. The reverse inference (from manipulations to meaning) doesn't work.

**Principle**: When documenting a variable, think nouns, not verbs — what it represents, not how it is manipulated.

## 6. The readRpc loop (low-level comment vs. high-level intuition)

Code searching for an RPC to append a key hash to, with a too-low-level comment:

```java
// If there is a LOADING readRpc using the same session
// as PKHash pointed to by assignPos, and the last PKHash
// in that readRPC is smaller than current assigning
// PKHash, then we put assigning PKHash into that readRPC.
int readActiveRpcId = RPC_ID_NOT_ASSIGNED;
for (int i = 0; i < NUM_READ_RPC; i++) {
    if (session == readRpc[i].session
            && readRpc[i].status == LOADING
            && readRpc[i].maxPos < assignPos
            && readRpc[i].numHashes < MAX_PKHASHES_PERRPC) {
        readActiveRpcId = i;
        break;
    }
}
```

The comment fails in both directions: it partially repeats the code ("if there is a LOADING readRPC" duplicates the status test) yet never explains the overall purpose or how this fits the enclosing method. The better comment drops all details:

```java
// Try to append the current key hash onto an existing
// RPC to the desired server that hasn't been sent yet.
```

With that conceptual frame, the reader can explain almost every condition in the loop themselves (session = right server; LOADING = state where adding hashes is still safe; MAX_PKHASHES_PERRPC = per-RPC limit; only `maxPos` is left unexplained). Crucially, the new comment also gives readers a basis for *judging* the code: does it do everything needed to append a hash to an existing RPC? The original gave no intent against which to check correctness.

**Principle**: Higher-level comments enhance intuition; a good one supplies a simple conceptual framework ("append to an existing RPC") that explains everything in the code. Ask: what is this code trying to do? What is the simplest statement that explains everything?

## 7. Unprocessed key hashes ("how we get here" comment)

A code sample with a good two-part higher-level comment:

```java
if (numProcessedPKHashes < readRpc[i].numHashes) {
    // Some of the key hashes couldn't be looked up in
    // this request (either because they aren't stored
    // on the server, the server crashed, or there
    // wasn't enough space in the response message).
    // Mark the unprocessed hashes so they will get
    // reassigned to new RPCs.
    for (size_t p = removePos; p < insertPos; p++) { ... }
}
```

The second sentence gives an abstract description of what the code does. The first sentence does something different and rarer: it explains, in high-level terms, *why* the code is executed — the conditions under which we get here. "How we get here" comments are very useful, especially for documenting methods that are only invoked in unusual situations.

**Principle**: Implementation comments should cover what and why, not how; document the conditions that lead to a code path.

## 8. HTTP class interface comment

A good class-level interface comment:

```java
/**
 * This class implements a simple server-side interface to the HTTP
 * protocol: by using this class, an application can receive HTTP
 * requests, process them, and return responses. Each instance of
 * this class corresponds to a particular socket used to receive
 * requests. The current implementation is single-threaded and
 * processes one request at a time.
 */
public class Http {...}
```

It describes the overall capability without implementation detail or method specifics, states what each instance represents (one socket), and states the class's limitations (no concurrent access) — which matters to developers deciding whether to use it.

**Principle**: A class interface comment gives a high-level view of the abstraction: capabilities, what an instance represents, and limitations.

## 9. Buffer::copy interface comment (precision plus abstraction)

The interface comment for a method copying data out of a `Buffer`:

```cpp
/**
 * Copy a range of bytes from a buffer to an external location.
 *
 * \param offset   Index within the buffer of the first byte to copy.
 * \param length   Number of bytes to copy.
 * \param dest     Where to copy the bytes: must have room for at least
 *                 length bytes.
 *
 * \return  The actual number of bytes copied, which may be less than
 *          length if the requested range extends past the end of the
 *          buffer. 0 is returned if there is no overlap between the
 *          requested range and the actual buffer.
 */
uint32_t Buffer::copy(uint32_t offset, uint32_t length, void* dest)
```

Doxygen-style syntax. It opens with the caller-perceived behavior, then gives precise per-argument constraints (dest must have room for length bytes) and an exact return contract including special cases. Note it follows Chapter 10's advice by *defining errors out of existence*: out-of-range requests aren't errors; they just copy fewer bytes. The reader needs nothing from the method body to call it, and the comment says nothing about how the implementation scans internal data structures.

**Principle**: A method interface comment provides everything needed to invoke the method — including special-case handling — and nothing about implementation.

## 10. IndexLookup class (extended case study: distributed storage system)

Context: `IndexLookup` is part of a distributed storage system holding tables of objects, each table with secondary indexes (e.g., by `name` or `age`). The class lets an application run an indexed range query:

```java
query = new IndexLookup(table, index, key1, key2);
while (true) {
    object = query.getNext();
    if (object == NULL) break;
    ... process object ...
}
```

The implementation is complex: objects are spread across multiple servers, indexes across a different set of servers; the class must query index servers, then fetch objects from storage servers.

**The five-question test.** For each fact, ask: does a developer need to know this to *use* the class?
1. Format of messages IndexLookup sends to servers — **No**: implementation detail, hide it.
2. The comparison function for range membership (integer, float, or string comparison?) — **Yes**: users need this.
3. Data structure used to store indexes on servers — **No**: encapsulated on the servers; not even IndexLookup's implementation should know.
4. Whether IndexLookup issues concurrent requests to multiple servers — **Possibly**: if it uses special performance techniques, give high-level information, since users may care about performance.
5. Mechanism for handling server crashes — **No**: RAMCloud recovers automatically, so crashes are invisible to applications. (If crashes *were* visible, document how they manifest — but not how recovery works.)

**Bad original class comment** (abridged): "This class implements the client side framework for index range lookups. It manages a single LookupIndexKeys RPC and multiple IndexedRead RPCs. Client side just includes IndexLookup.h... Several parameters can be set in the config below: number of concurrent indexedRead RPCs, max PKHashes per RPC, size of active PKHashes... To use IndexLookup, the client creates an object of this class by providing all necessary information. After construction, client can call getNext()..."

Problems found:
- Most of the first paragraph concerns implementation: RPC names and the configuration parameters (which are private variables relevant only to maintainers).
- It includes obvious content: any C++ programmer can guess they must include the header; "by providing all necessary information" says nothing.

**Better, shorter comment**:

```java
/*
 * This class is used by client applications to make range queries
 * using indexes. Each instance represents a single range query.
 *
 * To start a range query, a client creates an instance of this
 * class. The client can then call getNext() to retrieve the objects
 * in the desired range. For each object returned by getNext(), the
 * caller can invoke getKey(), getKeyLength(), getValue(), and
 * getValueLength() to get information about that object.
 */
```

The second paragraph isn't strictly necessary (it duplicates per-method comments) but earns its place as a usage example showing how the methods work together — helpful for deep classes with nonobvious usage patterns. The comment deliberately omits `getNext`'s NULL return (detail belongs in the method comment) and server crashes (invisible to users).

**Principle**: Red flag — Implementation Documentation Contaminates Interface. Filter every candidate fact through "does a user need this?"; omit implementation, omit the obvious, omit content-free phrases.

## 11. IndexLookup::isReady (implementation detail in a method's interface comment)

First version of the documentation:

```cpp
/**
 * Check if the next object is RESULT_READY. This function is
 * implemented in a DCFT module, each execution of isReady() tries
 * to make small progress, and getNext() invokes isReady() in a
 * while loop, until isReady() returns true.
 *
 * isReady() is implemented in a rule-based approach. We check
 * different rules by following a particular order, and perform
 * certain actions if some rule is satisfied.
 *
 * \return  True means the next Object is available. Otherwise, return false.
 */
bool IndexLookup::isReady() { ... }
```

Problems: the DCFT reference and the entire second paragraph are implementation — one of the most common errors in interface comments (useful implementation notes should move *inside* the method, separated from interface docs). The first sentence is cryptic (what is RESULT_READY?). Important information is missing. And describing getNext's internals doesn't belong here.

Better version:

```cpp
/*
 * Indicates whether an indexed read has made enough progress for
 * getNext to return immediately without blocking. In addition, this
 * method does most of the real work for indexed reads, so it must
 * be invoked (either directly, or indirectly by calling getNext) in
 * order for the indexed read to make progress.
 *
 * \return  True means that the next invocation of getNext will not block
 *          (at least one object is available to return, or the end of the
 *          lookup has been reached); false means getNext may block.
 */
```

This states precisely what "ready" means and surfaces the crucial nonobvious contract: the method must eventually be invoked or the read makes no progress (a side effect/precondition a caller could never guess).

**Principle**: Keep implementation out of interface comments; be precise about what return values mean; document nonobvious obligations on the caller.

## 12. Block and loop comments inside long methods

For longer methods, a comment before each major block gives an abstract description of what the block does:

```java
// Phase 1: Scan active RPCs to see if any have completed.
```

Such comments help readers navigate to the parts that matter to them. For nontrivial loops, a comment before the loop describing one iteration:

```java
// Each iteration of the following loop extracts one request from
// the request message, increments the corresponding object, and
// appends a response to the response message.
```

The loop comment is abstract and intuitive — no details about how requests are extracted or objects incremented. Loop comments are only needed for longer or more complex loops; many loops are obvious without one.

**Principle**: Implementation comments describe what, not how; comment major blocks and complex loops, skip the obvious ones.

## 13. Bug-fix comment referencing the issue tracker

If a bug fix adds code whose purpose isn't obvious, add a comment explaining why the code is needed. When a well-written bug report exists, reference it instead of repeating the details:

```
Fixes RAM-436, related to device driver crashes in Linux 2.4.x
```

Developers can look up the bug database for full details. This avoids duplicating documentation (a theme developed in Chapter 16).

**Principle**: Implementation comments explain why; reference authoritative sources rather than duplicating them.

## 14. RAMCloud Status enum (cross-module docs at an obvious central place)

RAMCloud (Ousterhout's distributed storage system) defines a `Status` value returned by every request. Adding a new error condition requires modifying many files: one maps Status values to exceptions, another supplies human-readable messages per Status, and so on. Fortunately there is one place every developer *must* visit when adding a status: the `Status` enum declaration. So the team put a comment there enumerating every other required update:

```c
typedef enum Status {
    STATUS_OK = 0,
    ...
    STATUS_INDEX_DOESNT_EXIST = 29,
    STATUS_INVALID_PARAMETER  = 30,
    STATUS_MAX_VALUE          = 30,

    // Note: if you add a new status value you must make the
    // following additional updates:
    // (1) Modify STATUS_MAX_VALUE to equal the largest value and keep
    //     its definition last in the list (used primarily for testing).
    // (2) Add entries to the "messages" and "symbols" tables in Status.cc.
    // (3) Add a new exception class to ClientException.h.
    // (4) Add a "case" to ClientException::throwException mapping the
    //     status to its exception subclass.
    // (5) In the Java bindings, add a static class for the exception
    //     to ClientException.java.
    // (6) Add a case to throw that exception in ClientException.java.
    // (7) Add the exception to the Status enum in Status.java, in the
    //     position matching its status code.
} Status;
```

New values are appended at the end of the list, so the comment sits at the end where it will most likely be seen.

**Principle**: For cross-module design decisions with an obvious central touchpoint, document the full list of dependent changes there, positioned where developers will see it.

## 15. RAMCloud zombie servers and the designNotes file (no central place)

A zombie server is one the cluster believes has crashed but is actually still running. Neutralizing zombies required interdependent code in several RAMCloud modules with no obvious central home for the documentation. Duplicating the docs at every site is awkward and drifts out of sync; putting it at one arbitrary site means developers won't find it.

Ousterhout's solution: a central `designNotes` file with clearly labeled sections per major topic. Excerpt:

```
Zombies
-------
A zombie is a server that is considered dead by the rest of the
cluster; any data stored on the server has been recovered and will
be managed by other servers. However, if a zombie is not actually
dead (e.g., it was just disconnected from the other servers for a
while) two forms of inconsistency can arise:
* A zombie server must not serve read requests once replacement
  servers have taken over; otherwise it may return stale data...
* The zombie server must not accept write requests once replacement
  servers have begun replaying its log during recovery; if it does,
  these writes may be lost...

RAMCloud uses two techniques to neutralize zombies. First, ...
```

Each relevant code site carries a one-line pointer:

```c
// See "Zombies" in designNotes.
```

Trade-off: a single copy that developers can find via the pointer comments, but the documentation isn't adjacent to any of the code that depends on it, so it may be harder to keep up to date as the system evolves.

**Principle**: When cross-module documentation has no natural home, centralize it in a designNotes file and leave pointer comments at every dependent code site; accept the staleness risk in exchange for findability and a single source of truth.
