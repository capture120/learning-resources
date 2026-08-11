# Chapter 8 Examples: Pull Complexity Downwards

## Text class for a GUI editor: line-oriented vs. character-oriented interface (8.1)

**Design problem.** A class manages the text of a file for a GUI text editor (the same project as Chapters 6 and 7): read the file from disk into memory, query and modify the in-memory copy, write it back to disk.

**Bad approach.** Many students chose a line-oriented interface — methods to read, insert, and delete whole lines of text. This made the class's implementation simple but pushed complexity up into every higher layer. User-interface operations rarely involve whole lines: a keystroke inserts a single character within a line; copying or deleting a selection modifies parts of several lines. With a line-oriented API, the UI code had to split and join lines itself to implement basic editing.

**Good approach.** A character-oriented interface (as in Section 6.3) that inserts and deletes arbitrary ranges of text. Sketch:

```
insert(position, text)        // any range, mid-line OK
delete(startPos, endPos)      // can span lines
```

The UI code becomes simpler: no line splitting or merging anywhere above the text class. The text class's implementation probably gets more complex — if it stores text internally as a collection of lines, it must now split and merge lines itself to implement character-oriented operations.

**Lesson.** This is better because the split/merge complexity is encapsulated in one place (the text class) instead of leaking into all higher-level software, reducing overall system complexity. A simple interface beats a simple implementation.

## Configuration parameters: complexity moved upward (8.2)

**Design problem.** A class isn't sure what policy to implement internally — cache size, number of retries before giving up — so it exports parameters and makes users choose. Configuration parameters are very popular; some systems have hundreds.

**The argument for them.** Users can tune the system for their requirements and workloads. Sometimes low-level infrastructure genuinely can't know the best policy while users know their domain — e.g., a user knows some requests are more time-critical than others and can assign them higher priority. In such cases parameters yield better performance across a broader variety of domains.

**The argument against them.** Parameters are an easy excuse to dodge an important issue and pass it to someone else. Often users and administrators can't determine the right values either. In other cases, the right value could be determined automatically with a little extra implementation work. Every exported parameter must be learned and set by every administrator at every installation — complexity amplified across many people instead of handled once.

**Lesson.** Avoid configuration parameters as much as possible. Before exporting one, ask: "Will users (or higher-level modules) be able to determine a better value than we can determine here?" If you must export one, provide a reasonable default so values are only needed in exceptional conditions. A module should solve its problem completely; a parameter is an incomplete solution that adds system complexity.

### Sub-example: network retry interval

A transport protocol must handle lost packets: if no response arrives within some time, it resends the request. The easy route is a `retryInterval` configuration parameter. The better route pulls complexity down: the protocol measures the response time of successful requests and uses a multiple of that as the retry interval. This saves users from guessing the right value, and because the value is computed dynamically, it adjusts automatically when operating conditions change — whereas a static configuration parameter easily goes out of date.

## Backspace method in the text class: pulling down gone wrong (8.3)

**Design problem.** In the same editor project, Chapter 6 described students who defined methods in the text class that mirrored the user interface, such as a method implementing the backspace key.

**Why it looks right but isn't.** It might seem good — it "pulls complexity downward" into the text class. But it fails the chapter's criteria: knowledge of the user interface doesn't relate to the text class's core function (managing text), and embedding it barely simplifies the higher-level code. The result is information leakage, not encapsulation.

**Lesson.** Pulling complexity down makes the most sense when (a) the complexity is closely related to the class's existing functionality, (b) it produces simplifications elsewhere in the application, and (c) it simplifies the class's interface. The extreme of pulling everything into one giant class is obviously wrong; the goal is always to minimize overall system complexity, not to relocate complexity ritually.
