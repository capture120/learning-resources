# Chapter 14: Choosing Names — Examples

## The Sprite `block` bug: a vague name costs six months

**Context.** In the late 1980s/early 1990s, Ousterhout and his graduate students built the Sprite distributed operating system. Files occasionally lost data: a data block would turn to all zeroes even though no user had modified the file. The bug was intermittent, so several students tried and gave up; Ousterhout spent six months tracking it down — the hardest bug he ever fixed.

**The bad approach.** The file system code used the single variable name `block` for two different things: in some places a *physical* block number on disk, in others a *logical* block number within a file. At one point, a `block` variable holding a logical block number was accidentally used where a physical block number was required, so an unrelated disk block got overwritten with zeroes.

**Why the name made it worse.** Multiple people, including Ousterhout, read the faulty line and missed the bug: seeing `block` used as a physical block number, they reflexively assumed it held one. Only after instrumentation proved the corruption *must* happen at that statement could he get past the mental block the name created and trace where the value came from.

**The good approach.** Distinct names — `fileBlock` and `diskBlock` — would almost certainly have prevented the error; the programmer would have known a `fileBlock` couldn't be used there. Even better: distinct *types* for the two kinds of blocks, so they cannot possibly be interchanged.

**Lesson.** `block` was "reasonably close" for both meanings — not a horrible name — yet it caused a hugely expensive bug. Don't settle for reasonably close; choose names that are precise, unambiguous, and intuitive. This also illustrates the third consistency requirement: one name must not cover entities with different behaviors.

## `getCount()` → `numActiveIndexlets`: too-generic method name

**Bad.**

```java
/** Returns the total number of indexlets this object is managing. */
int IndexletManager::getCount() {...}
```

"Count" is too generic — count of what? Anyone seeing a call site must read the documentation to know what it returns.

**Good.** `numActiveIndexlets`: most readers can guess what the method returns without looking at its docs.

**Lesson.** Names should be precise enough to be understood at the call site (the "Vague Name" red flag).

## Student text editor: `x` and `y` for character positions

A GUI text editor project used `x` and `y` for the position of a character in the file. These names could mean many things — e.g., pixel coordinates of the character on screen — and nobody seeing `x` in isolation would guess "position of a character within a line of text." `charIndex` and `lineIndex` are clearer because they reflect the specific abstractions the code implements.

**Lesson.** Precision: names should reflect the actual abstraction, not a generic coordinate metaphor.

## Student editor: `blinkStatus` → `cursorVisible`

**Bad.**

```java
// Blink state: true when cursor visible.
private boolean blinkStatus = true;
```

"Status" is too vague for a boolean — it gives no clue what true or false means. "Blink" is also vague: blinking *what*?

**Good.**

```java
// Controls cursor blinking: true means the cursor is visible,
// false means the cursor is not displayed.
private boolean cursorVisible = true;
```

Readers can now guess what true means. The general rule: boolean names should always be predicates. Note the trade-off: the word "blink" is gone, so readers wanting to know *why* the cursor isn't always visible must consult the documentation — acceptable, because that information is less important. Names emphasize what matters most and push secondary detail to docs.

**Lesson.** Precision for booleans; names are abstractions with a word budget.

## Consensus protocol: `VOTED_FOR_SENTINEL_VALUE` → `NOT_YET_VOTED`

A student consensus-protocol project defined:

```java
// Value representing that the server has not voted (yet)
// for anyone for the current election term.
private static final String VOTED_FOR_SENTINEL_VALUE = "null";
```

The name says the value is special but not what the special meaning *is*. `NOT_YET_VOTED` is better.

**Lesson.** Name sentinel values for their meaning, not their role as sentinels.

## `result` in a method with no return value

A student method used a variable named `result` even though the method returned nothing. Two problems: it falsely implies the value becomes the method's return value, and it conveys nothing about the value beyond "something computed." Name what it actually holds — `mergedLine`, `totalChars`. In methods that *do* return the value, `result` is reasonable: still a bit generic, but readers can check the method docs and benefit from knowing it eventually becomes the return value.

**Lesson.** Names must not create false impressions; generic names are tolerable only when context (a real return value) gives them meaning.

## Linux kernel: `struct socket` vs. `struct sock`

The Linux kernel has two structures describing network sockets: `struct socket` and `struct sock`. A `struct sock` contains a `struct socket` as its first element — effectively a subclass. The names are so similar it's hard to remember which is which. Names like `struct sock_base` and `struct inet_sock` would be easy to distinguish and would clarify the relationship between the types.

**Lesson.** Related entities need names that both distinguish them and express their relationship.

## Loop variable `i`: when generic names are fine

```c
for (i = 0; i < numLines; i++) {
    ...
}
```

It's obvious `i` iterates over lines, because the loop spans a few lines and you can see the variable's entire usage range. Generic `i`/`j` are fine in that case. If the loop grows too long to see at once, or the variable's meaning is harder to infer, use a descriptive name. Related consistency rule: always use `i` for outermost loops and `j` for nested ones, so readers make instant safe assumptions.

**Lesson.** The exception to precision: short visible scope makes meaning obvious; this prefigures Gerrand's declaration-to-use distance rule.

## Too specific: `delete(Range selection)`

A method that deletes a range of text was declared:

```java
void delete(Range selection) {...}
```

`selection` is too specific — it implies the deleted text is whatever is currently selected in the user interface, but the method works on *any* range, selected or not. The argument should be named `range`.

**Lesson.** Precision can overshoot. Match the name to the entity's actual generality; over-specific names mislead just like vague ones.

## File copy: `srcFileBlock` and `dstFileBlock`

A method copying file data needs two block numbers, source and destination. Keep the established common name (`fileBlock`) and add distinguishing prefixes: `srcFileBlock`, `dstFileBlock`.

**Lesson.** How to stay consistent when multiple variables share one concept: common name plus distinguishing prefix.

## Extra words: `fileObject`, `filePtr`, Hungarian Notation, `File.fileBlock`

- Adding generic nouns like `object` or `field`: `fileObject` — does `Object` tell you anything? (Are there files that aren't objects?) Drop it.
- Type information in names: `filePtr` for a pointer to a file. The extreme is Hungarian Notation, used for years in Microsoft C code, where every name is prefixed with its full type — `arru8NumberList` means "array of unsigned 8-bit integers." Ousterhout used to include type info himself but no longer recommends it: modern IDEs jump to declarations or display types automatically.
- Repeating the class name in instance variables: `fileBlock` inside class `File`. Context already says the variable belongs to `File`; just call it `block` — unless the class holds multiple blocks of different types, in which case the qualifier earns its place.

**Lesson.** Every word in a name must add information; clutter words just cause wrapping and noise.

## Counterpoint: Go's `RuneCount` and the short-names debate

Andrew Gerrand, in a 2014 talk on Go naming (talks.golang.org/2014/names.slide), argues "long names obscure what the code does" and presents:

```go
func RuneCount(b []byte) int {
    i, n := 0, 0
    for i < len(b) {
        if b[i] < RuneSelf {
            i++
        } else {
            _, size := DecodeRune(b[i:])
            i += size
        }
        n++
    }
    return n
}
```

claiming it reads better than the same function with `buffer`, `index`, `count`.

**Ousterhout's response.** He finds the long-name version no harder to read; `count` actually gives a better clue than `n`, which he had to puzzle out by reading the code. Concession: if `n` is used consistently throughout a system for counts and nothing else, other developers will probably find it clear. But Go culture also reuses one short name for *multiple* things — `ch` for character or channel; `d` for data, difference, or distance — and such ambiguous names are likely to cause confusion and errors just like the Sprite `block` bug.

**Resolution.** Readability is determined by readers, not writers. If readers find your short names easy, fine; if they complain your code is cryptic (web searches for "go language short names" surface such complaints), use longer names — and vice versa. Ousterhout does endorse one Gerrand rule: "The greater the distance between a name's declaration and its uses, the longer the name should be" — the `i`/`j` loop convention is an instance of it.

**Lesson.** The book's explicit engagement with an opposing school: consistency can rescue short names, ambiguity condemns them, and reader feedback is the arbiter.
