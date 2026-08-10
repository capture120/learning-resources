# Chapter 11 Examples: Design it Twice

## GUI text editor: choosing the interface for the text class

**Design problem.** You are building the class that manages a file's text for a GUI text editor. The first step is defining the interface this class presents to the rest of the editor. Rather than picking the first idea that comes to mind, sketch several radically different candidates (only the most important methods, not full specs):

1. **Line-oriented interface**: operations insert, modify, and delete whole lines of text.
2. **Character-oriented interface**: operations insert and delete individual characters.
3. **String-oriented interface**: operations act on arbitrary ranges of characters that may cross line boundaries.

**Comparison (pros and cons).** The most important criterion for an interface is ease of use for higher-level software, and on that score the first two candidates fail:

- The line-oriented interface forces higher-level software to split and join lines itself during partial-line and multi-line operations, such as cutting and pasting a selection.
- The character-oriented interface forces higher-level software to write loops for any operation that modifies more than one character. It is also likely to be significantly slower than the others, because every character requires a separate call into the text module — an example of the secondary criterion "does one interface enable a more efficient implementation?"
- On the secondary criterion of simplicity, the candidates don't separate: all three text interfaces are relatively simple. The remaining secondary question — is one interface more general-purpose than another? — is worth asking too; the chapter raises it without applying it to this example.

**Resolution: derive a better design from the failures.** Suppose you had considered only the line-oriented and character-oriented options. Both are awkward for the same reason: they require higher-level software to perform additional text manipulation. The chapter calls this a red flag — if there's going to be a text class, it should handle all of the text manipulation. Fixing that means the interface must match the operations that actually happen in higher-level software, and those operations don't correspond to single characters or single lines. This reasoning leads to a **range-oriented API** for text (operations on arbitrary character ranges), which eliminates the problems of the earlier designs.

**Lessons demonstrated.**
- Sketch multiple radically different alternatives before choosing.
- Judge interfaces primarily by ease of use for callers, then by simplicity, generality, and efficiency of possible implementations.
- When no alternative is attractive, use the specific problems you found to drive a new design rather than settling for the least-bad option.
- The best design sometimes isn't on the original list — comparison reveals it.

## The same text class: designing the implementation twice

**Design problem.** After the interface is fixed, apply design-it-twice again to the implementation of the text class. Candidate representations include a linked list of lines, fixed-size blocks of characters, or a "gap buffer."

**Point of the example.** The evaluation criteria change with the level: for an implementation the most important factors are simplicity and performance, not caller convenience (the interface already fixed that). The chapter doesn't pick a winner; the example exists to show that the principle applies separately, with separate goals, at each level of design — and also at higher levels, such as choosing features for a user interface or decomposing a system into major modules. In each case, comparing a few alternatives makes the best approach easier to identify.

## Anecdote: why smart people resist designing twice

**The story.** Ousterhout observes that the design-it-twice principle is sometimes hard for really smart people to embrace. Growing up, their first quick idea about any problem was sufficient for a good grade, so they never needed a second possibility — a habit that becomes a liability as they are promoted into environments with harder and harder problems. Eventually everyone hits problems where first ideas are no longer good enough; the design of large software systems is in that category — no one is good enough to get it right on the first try. He often sees smart people insist on implementing the first idea that comes to mind, which makes them underperform their true potential and makes them frustrating to work with. He suspects a subconscious belief that "smart people get it right the first time," so trying multiple designs would mean they aren't smart.

**The lesson.** Needing multiple design attempts doesn't mean you aren't smart; it means the problems are really hard. That's a good thing — difficult problems that require careful thought are more fun than easy ones that don't. A side benefit: the practice of devising and comparing multiple approaches teaches you what makes designs better or worse, so over time you rule out bad designs faster and home in on great ones.
