# Chapter 6 Examples: General-Purpose Modules are Deeper

## 1. Text class for a GUI editor — special-purpose API (the bad approach)

**Design problem.** Students in Ousterhout's design course built a simple GUI text editor: display a file, point/click/type to edit, support multiple simultaneous windows on the same file, and multi-level undo/redo. Each project had a class managing the file's underlying text (load, read, modify, write back).

**Bad approach.** Many teams tailored the text class's API to the editor's user-visible features. Backspace deletes the character left of the cursor and delete removes the character to its right, so they added one method per UI feature:

```java
void backspace(Cursor cursor);
void delete(Cursor cursor);
void deleteSelection(Selection selection);
```

The teams assumed mirroring UI features in the text class would make the UI easier to implement. In reality it provided little benefit and created high cognitive load on both sides:

- The text class accumulated many shallow methods, each suitable for only one UI operation; many (like `delete`) were called from a single place.
- A UI developer had to learn a large number of text-class methods.
- UI abstractions (selection, backspace key, `Cursor` type) leaked into the text class — information leakage.
- Every new UI operation required a new text-class method, so UI developers ended up modifying the text class too. The two classes could not be developed independently.

**Principle demonstrated.** Special-purpose APIs produce shallow modules, information leakage, and coupling between layers that should be independent.

## 2. Text class — the general-purpose API (the good approach)

**Good approach.** Define the text class's API only in terms of basic text operations, with no knowledge of higher-level editor features. Two methods suffice for all modification:

```java
void insert(Position position, String newText);
void delete(Position start, Position end);   // deletes [start, end)
```

The generic `Position` type replaces `Cursor` (which reflected one specific UI). Add general-purpose position navigation:

```java
Position changePosition(Position position, int numChars);
// returns the position numChars away (negative = earlier),
// automatically crossing line boundaries
```

Now the UI implements its specialized features on top:

```java
// delete key:
text.delete(cursor, text.changePosition(cursor, 1));
// backspace key:
text.delete(text.changePosition(cursor, -1), cursor);
```

**Tradeoff and why it still wins.** The UI code is slightly longer than calling `text.backspace(cursor)`, but it is more obvious: a UI developer cares exactly which characters backspace deletes, and the new code shows it directly — with the old code they had to go read the `backspace` method's documentation or source. Overall there is *less* total code, because a few general methods replace many special-purpose ones. Concretely: the special-purpose API had at least three text-deletion methods (`backspace`, `delete`, `deleteSelection`); the general API has a single `delete` serving all three purposes — the "simplest interface covering all current needs" question in action.

**Reuse bonus.** A hypothetical app that replaces all occurrences of one string with another would get almost everything it needs from the general-purpose text class; the only missing piece is something like `Position findNext(Position start, String string)` — which an editor with search-and-replace would already have. The special-purpose methods (`backspace`, `delete(Cursor)`) would be useless to it.

**Information hiding payoff.** The text class no longer knows how the backspace key is handled; those details are encapsulated in the UI class. New UI features need no new text-class methods. UI developers learn only a few simple, reusable methods.

**Principle demonstrated.** A general-purpose interface is deeper, more obvious, smaller in total code, and gives cleaner separation/information hiding — even when used by only one client.

## 3. The `backspace` method as a false abstraction

**Lesson within the editor example.** The original `backspace` method purported to hide which characters get deleted — but the UI module genuinely needs to know that. UI developers would read `backspace`'s implementation to confirm its precise behavior, so placing it in the text class only made the needed information harder to get. When details matter to the caller, make them explicit and obvious (as in the revised `text.delete(...)` call), instead of hiding them behind an interface, which creates obscurity.

**Principle demonstrated.** Determining who needs to know what, and when, is central to design; hiding information callers need is a false abstraction.

## 4. Single-character text API — generality taken too far

**Overcorrection counterexample.** One could design the text class around single-character operations: `insert` adds one character, `delete` removes one character. This API is both simple and fully general-purpose, yet bad: editor code would be full of loops to insert or delete ranges, and large operations would be inefficient.

**Fix.** Build range operations into the text class.

**Principle demonstrated.** "Is this API easy to use for my current needs?" is the test that catches over-generalization. If callers must write lots of code to use a class, the interface lacks the right functionality.

## 5. Device drivers — pushing specialization downwards

**Design problem.** An operating system must support hundreds or thousands of device types (e.g., many kinds of secondary storage), each with its own specialized command set, without specialized device behavior leaking into the OS core.

**Approach.** The OS defines a general-purpose interface every storage device must implement, such as "read a block" and "write a block." Each device gets a *device driver* module that implements this general interface using that device's specialized features.

**Result.** Specialization is pushed down into drivers; the OS core is written with no knowledge of specific device characteristics. Adding a device requires no changes to the OS — if it can implement the driver interface, it plugs in.

**Principle demonstrated.** Specialization can't be eliminated, but it can be pushed downwards behind a general-purpose interface, keeping middle layers generic. (The editor example showed the mirror move: pushing UI specialization upwards out of the text class.)

## 6. Editor undo mechanism — separating general-purpose core from special-purpose handlers

**Design problem.** The editor needed multi-level undo/redo covering not just text changes but also selection, insertion cursor, and view. Example: user selects text, deletes it, scrolls away, then hits undo — the editor must restore the deleted text, reselect it, and scroll it back into view.

**Bad approach.** Some teams put the entire undo mechanism in the text class. It kept the list of all undoable changes, auto-logging text edits; the UI called extra text-class methods to log selection/cursor/view changes; on undo, the text class processed entries itself for text changes and called back into the UI for everything else. Problems:

- The general-purpose core (managing a list of executed actions, stepping through it) was buried in the text class alongside special-purpose handlers for text, selection, etc.
- The selection/cursor undo handlers had nothing to do with the rest of the text class — information leakage between text class and UI, plus extra methods in each module just to pass undo data back and forth.
- Any new kind of undoable entity would require new entity-specific methods in the text class.
- The undo core had little to do with the class's general-purpose text facilities.

**Good approach.** Extract the general-purpose core into its own class:

```java
public class History {
    public interface Action {
        void redo();
        void undo();
    }
    History() {...}
    void addAction(Action action) {...}
    void addFence() {...}
    void undo() {...}
    void redo() {...}
}
```

`History` manages a list of `History.Action` objects over the application's lifetime and walks backwards/forwards through it on undo/redo. It knows nothing about what the actions contain or how they undo/redo themselves. The special-purpose knowledge lives in `Action` implementations defined in the modules that understand each operation: the text class implements `UndoableInsert`/`UndoableDelete` and calls `History.addAction` whenever it modifies text; the UI creates `UndoableSelection`/`UndoableCursor` objects. *Fences* — markers added via `addFence` by higher-level code — group related actions so one user-level undo undoes everything back to the previous fence (restore text, reselect it, reposition cursor).

This splits undo into three independently implementable categories:

1. General-purpose action management, grouping, and undo/redo invocation (`History`).
2. Specifics of particular actions (many small classes, each knowing a few action types).
3. Grouping policy (high-level UI code placing fences for correct application behavior).

None needs to understand the others; `History` could serve entirely different applications. The key design decision was separating the general-purpose part from the special-purpose parts — once `History.Action` subclassing was chosen, the rest of the design "fell out naturally."

**Nuance the book adds here.** "Separate general from special-purpose" applies *per mechanism*. Special-purpose undo code (undoing a text insertion) must be separated from general-purpose undo code (history-list management) — but it is fine to combine special-purpose code for one mechanism with general-purpose code for another: the text-specific undo actions rightly live in the (general-purpose) text class, because they relate closely to other text functions.

**Principle demonstrated.** Extract the general-purpose core of a mechanism into its own deep class and push the specialized parts up/out into the modules that own that knowledge.

## 7. Selection that always exists — eliminating a special case in code

**Design problem.** Students had to implement text selection with copy and delete of the selection. There are times when no selection is visible, so most students added a state variable meaning "selection exists / doesn't exist."

**Bad approach.** The explicit "no selection" state forced numerous checks throughout the selection-handling code to detect and specially handle the missing-selection condition.

**Good approach.** Make the selection always exist. Represent "no visible selection" as an *empty* selection whose start and end positions are equal. Then:

- **Copy:** copying an empty selection inserts 0 bytes at the destination; implemented correctly, no "0 bytes" special check is needed.
- **Delete (single-line selection):** take the line text before the selection, concatenate the line text after it, and that's the new line. With an empty selection this regenerates the original line unchanged — the empty case is handled by the normal code path with zero extra checks.

**Principle demonstrated.** Eliminate special cases by designing the normal case so it automatically handles edge conditions; this removes `if`-statement clutter and a whole class of bugs. (Chapter 10 extends this to exceptions, which create many more special cases.)
