# Chapter 06: Formatting — Examples

### File-size survey of seven open-source projects

Uncle Bob plots file lengths (on a log scale) for JUnit, FitNesse, TestNG, Time and Money, JDepend, Ant, and Tomcat. JUnit, FitNesse, and Time and Money are built from small files — none over 500 lines, most under 200 (FitNesse averages ~65 lines per file, max ~400) — while Ant and Tomcat have files thousands of lines long. Since FitNesse was close to 50,000 lines at the time, it "appears to be possible" to build significant systems from files typically 200 lines long with a 500-line ceiling. Lesson: small files are very desirable, though not a hard-and-fast rule.

### BoldWidget with and without blank lines (Vertical Openness)

The book shows FitNesse's small `BoldWidget` class twice: once with blank lines separating the package declaration, the imports, and each method, and once with those blank lines stripped. The two are semantically identical, yet the second is a muddle — especially if you unfocus your eyes, the groupings in the first version pop out while the second blurs together. Lesson: each blank line is a visual cue marking a new concept; a bit of vertical openness has a profound effect on readability.

### ReporterConfig and the comment clutter (Vertical Density)

A `ReporterConfig` class declares two instance variables, each preceded by a useless Javadoc comment ("The class name of the reporter listener", "The properties of the reporter listener"). The comments push the two related variables apart and force extra eye and head motion. The cleaned version drops the comments:

```java
public class ReporterConfig {
    private String m_className;
    private List<Property> m_properties = new ArrayList<Property>();

    public void addProperty(Property property) { ... }
}
```

Now the whole class fits in an "eye-full": two variables and a method, visible at a glance. Lesson: tightly related lines should be vertically dense; noise between them breaks the association.

### JUnit's readPreferences and countTestCases (variable placement)

From JUnit 4.3.1: `readPreferences()` declares its local `InputStream is = null;` at the top of the function, right before the try block that uses it — fine, because functions are short. `countTestCases()` declares its loop control variable inside the loop statement itself (`for (Test each : tests)`). A third snippet from a very long TestNG function shows the rare case where a variable is declared just before a loop mid-function. Lesson: declare variables as close to their usage as possible.

### The hidden instance variables in JUnit's TestSuite

In JUnit 4.3.1's `TestSuite` class — a listing Uncle Bob "greatly attenuated" to make the point — two instance variables (`fName` and `fTests`) are declared about halfway down the listing, between a batch of static methods and the constructors. Uncle Bob remarks "it would be hard to hide them in a better place" — a reader stumbles on them only by accident, as he did. Lesson: instance variables belong in one well-known place (top of the class in Java), so everybody knows where to look.

### WikiPageResponder (Dependent Functions and constant placement)

FitNesse's `WikiPageResponder.makeResponse` sits at the top and calls `getPageNameOrDefault`, `loadPage`, `notFoundResponse`, and `makePageResponse` — and those functions are defined below it, in the order they are called. Readers can trust that a definition follows shortly after its use, giving the module a natural top-down flow. The same snippet shows constant placement: the `"FrontPage"` default is passed into `getPageNameOrDefault` from `makeResponse` rather than buried inside the low-level function, keeping a well-known constant at the level where knowing it makes sense.

### JUnit's Assert class (Conceptual Affinity)

`assertTrue(String, boolean)`, `assertTrue(boolean)`, `assertFalse(String, boolean)`, and `assertFalse(boolean)` sit together. They share a naming scheme and perform variations of the same task; the fact that they call each other is secondary. Lesson: even functions with no direct dependence want to be vertically close when their conceptual affinity is strong.

### Line-width distribution across the seven projects

A second statistical chart shows line lengths: every width from 20 to 60 characters accounts for about 1% of all lines (40% total), another ~30% are under 10 characters, and frequency drops sharply above 80 (significant on a log scale). Lesson: programmers clearly prefer short lines; 80 is a bit arbitrary, 100–120 acceptable, beyond that probably careless. Never force readers to scroll right.

### measureLine (Horizontal Openness and Density)

In `measureLine`, assignment operators are surrounded by spaces (`int lineSize = line.length();`) to accentuate the left side/right side split, while function names abut their opening parentheses (`recordWidestLine(lineSize)`) because a function and its arguments are conjoined. Commas get trailing spaces to separate arguments. Lesson: horizontal white space associates the strongly related and disassociates the weakly related.

### Quadratic roots and operator precedence

The `Quadratic` class writes `return b*b - 4*a*c;` — no spaces inside the high-precedence multiplications, spaces around the lower-precedence subtraction — so the equation reads the way it parses. Uncle Bob notes the trade-off: most reformatting tools are blind to precedence and will erase this subtle spacing.

### FitNesseExpediter aligned vs. unaligned (Horizontal Alignment)

A version of `FitNesseExpediter` shows column-aligned declarations and assignments, an assembly-language habit Uncle Bob carried into C, C++, and Java. He abandoned it: the alignment tempts you to read down the variable names without seeing the types, or down the r-values without seeing the assignments. The unaligned version is preferred because it exposes the real deficiency — a declaration list long enough to want alignment means the class should be split up, not prettified.

### FitNesseServer indented vs. unindented (Indentation)

Two syntactically and semantically identical versions of `FitNesseServer`: one with scopes properly indented, one with line breaks placed chaotically and no indentation hierarchy. The indented version reveals at a glance that it's a simple socket front end with a timeout; the unindented one is "virtually impenetrable without intense study." Lesson: programmers rely on the left edge to read scope; without indentation, code is virtually unreadable by humans.

### CommentWidget one-liners (Breaking Indentation)

`CommentWidget` is shown with its constructor and `render()` collapsed onto single lines (`{super(parent, text);}`), then expanded with proper indentation. Whenever Uncle Bob gave in to collapsing short scopes, he almost always went back and re-expanded them. He allows the exception that a trivial one-liner like `public int getCount() {return count;}` can be more visually appealing than dangling braces.

### The FitNesse team-style anecdote (Team Rules)

When the FitNesse project started in 2002, Uncle Bob sat down with the team and settled the coding style — braces, indent size, naming — in about ten minutes, then encoded the rules into the IDE's formatter and stuck with them. They were not the rules he personally preferred, but "the team rules": he followed them as a member of that team. Lesson: a codebase must read as one consistent set of documents, not a jumble written by disagreeing individuals.

### CodeAnalyzer as a living style guide (Uncle Bob's Formatting Rules)

Instead of writing his personal formatting rules as prose, Uncle Bob presents a complete, well-formatted `CodeAnalyzer` class and says to consider it "an example of how code makes the best coding standard document." Lesson: the rules he uses personally are very simple and are illustrated by the code itself, not enumerated in prose.
