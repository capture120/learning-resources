# Chapter 18 Examples: Code Should be Obvious

## 1. Parameter documentation with and without white space

**Problem:** A Javadoc comment documents two parameters (`numThreads` and `handler`) of a `MessageManager`, but all the text is squeezed together with no visual structure.

**Bad approach:** Continuous run-on comment lines. It's hard to see where the documentation for one parameter ends and the next begins. It isn't even obvious how many parameters there are or what their names are.

```java
/**
 * ...
 * @param numThreads The number of threads that this manager should
 * spin up in order to manage ongoing connections. The MessageManager
 * spins up at least one thread for every open connection, so this
 * should be at least equal to the number of connections you expect
 * to be open at once. ...
 * @param handler Used as a callback in order to handle incoming
 * messages on this MessageManager's open connections. ...
 */
```

**Good approach:** Put each `@param` tag on its own line and indent the description text beneath it:

```java
/**
 *   @param numThreads
 *        The number of threads that this manager should spin up in
 *        order to manage ongoing connections. ...
 *   @param handler
 *        Used as a callback in order to handle incoming messages on
 *        this MessageManager's open connections. ...
 */
```

With a little whitespace the structure suddenly becomes clear and the documentation is easy to scan.

**Principle:** Judicious use of white space makes code (and documentation) more obvious — formatting should expose structure.

## 2. Blank lines separating blocks in `Buffer::allocAux` (RAMCloud)

**Problem:** A nontrivial C++ method, `Buffer::allocAux`, performs several distinct steps: round the requested length up to a multiple of 8 bytes for alignment; try to satisfy the request from memory at `firstAvailable` (allocating down from the top, where memory is guaranteed aligned); next try extra space at the end of the last chunk; otherwise create a new allocation.

**Good approach shown:** Each logical step is separated by a blank line, and the first line after each blank line is a comment describing the next block:

```cpp
void* Buffer::allocAux(size_t numBytes)
{
    // Round up the length to a multiple of 8 bytes, to ensure alignment.
    uint32_t numBytes32 = (downCast<uint32_t>(numBytes) + 7) & ~0x7;
    assert(numBytes32 != 0);

    // If there is enough memory at firstAvailable, use that. Work down
    // from the top, because this memory is guaranteed to be aligned...
    if (availableLength >= numBytes32) { ... }

    // Next, see if there is extra space at the end of the last chunk.
    if (extraAppendBytes >= numBytes32) { ... }

    // Must create a new space allocation; allocate space within it.
    ...
}
```

**Principle:** Blank lines separate major blocks of code within a method; the technique works particularly well when each blank line is followed by a comment describing the next block, because the blank lines make the comments more visible.

## 3. White space within a statement

Compare the same `for` loop with and without internal white space:

```c
for(int pass=1;pass>=0&&!empty;pass--) {
for (int pass = 1; pass >= 0 && !empty; pass--) {
```

The second version reads at a glance; the first must be visually parsed token by token.

**Principle:** White space within a statement clarifies the statement's structure.

## 4. Event-driven programming and the `RpcNotifier::failed` handler

**Problem:** In event-driven programming (responding to network packets, mouse clicks, etc.), one module reports incoming events and other parts of the application register handlers for them. Handler functions are never invoked directly: the event module calls them indirectly through a function pointer or interface. Even if you find the invocation point in the event module, you can't tell which specific function will run — that depends on what was registered at runtime. This makes control flow hard to follow and makes it hard to convince yourself the code works.

**Good approach:** Compensate for the obscurity with the handler's interface comment, stating when it is invoked. From RAMCloud's transport layer:

```cpp
/**
 * This method is invoked in the dispatch thread by a transport if a
 * transport-level error prevents an RPC from completing.
 */
void Transport::RpcNotifier::failed() { ... }
```

**Principle:** Some useful techniques are inherently nonobvious; when you use them anyway, extra documentation must supply the missing information (here: who calls this, on which thread, under what condition).

## 5. Generic containers: returning a `Pair` from a method

**Problem (bad approach):** Java's `Pair` (or C++'s `std::pair`) makes it easy to return multiple values from a method:

```java
return new Pair<Integer, Boolean>(currentTerm, false);
```

The caller must then access the values as `result.getKey()` and `result.getValue()` — names that give no clue what the values actually mean (the reader has no way to know `getKey()` returns the number of the current term).

**Good approach:** Don't use generic containers. Define a new class or structure specialized for this particular use. Its elements get meaningful names, and the declaration can carry additional documentation — impossible with a generic container.

**Principle:** This example illustrates the chapter's general rule: **software should be designed for ease of reading, not ease of writing.** The generic container is expedient for the writer but confuses every subsequent reader; a few extra minutes spent defining a specific structure makes the code obvious.

## 6. Declared type differs from allocated type (`List` vs `ArrayList`)

**Problem (bad approach):**

```java
private List<Message> incomingMessageList;
...
incomingMessageList = new ArrayList<Message>();
```

This is legal Java (`List` is a superclass of `ArrayList`), but a reader who sees only the declaration is misled about the actual type. The concrete type can affect how the variable is used: `ArrayList` has different performance and thread-safety properties than other `List` subclasses.

**Good approach:** Match the declaration to the allocation so the declaration tells the truth.

**Principle:** Declarations are read far from allocations; making them disagree withholds information the reader needs.

## 7. Code that violates reader expectations: `RaftClient` in `main`

**Problem:** The main program of a Java application ends with:

```java
public static void main(String[] args) {
    ...
    new RaftClient(myAddress, serverAddresses);
}
```

Most applications exit when `main` returns, so readers will assume that happens here. It doesn't: the `RaftClient` constructor creates additional threads that keep running after the main thread finishes.

**Good approach:** Document this behavior in the interface comment for the `RaftClient` constructor, and — because the behavior is nonobvious enough — also add a short comment at the end of `main` indicating that the application continues executing in other threads.

**Principle:** Code is most obvious when it conforms to the conventions readers expect; when it doesn't, document the deviation prominently (at both the cause and the point of surprise) so readers aren't confused. This is also the chapter's closing illustration of obscurity as missing information: the reader lacks one fact (the constructor spawns threads), and the fix is to supply it.
