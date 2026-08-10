# Chapter 06: Formatting

Code formatting is about communication, and communication is the professional developer's first order of business — not "getting it working." Functionality changes every release, but the readability of your code shapes every change ever made to it: "Your style and discipline survive, even though your code does not." Formatting is too important to ignore and too important to treat religiously; choose a simple set of rules and apply them consistently; it helps to have an automated tool apply them for you.

## The Purpose of Formatting

Formatting signals professionalism. When people look under the hood, neatness, consistency, and attention to detail tell them professionals were at work; a scrambled mass of code makes them assume the same inattention pervades the whole project. Coding style sets precedents that affect maintainability and extensibility long after the original code is changed beyond recognition.

## Vertical Formatting (file size)

Prefer small source files: typically around 200 lines, with an upper limit near 500. Uncle Bob's statistical analysis of seven projects (JUnit, FitNesse, TestNG, Time and Money, JDepend, Ant, Tomcat) suggests it "appears to be possible" to build significant systems (FitNesse was close to 50,000 lines at the time) out of such files. "Although this should not be a hard-and-fast rule, it should be considered very desirable" — small files are usually easier to understand and maintain than large ones. (His 2nd-edition epigraph notes the analysis is nearly two decades old and other languages may yield slightly different numbers.)

## Vertical Openness between Concepts

Separate distinct thoughts with blank lines. Code reads top to bottom; each group of lines is a complete thought, and a blank line is a visual cue marking a new and separate concept. This extremely simple rule has a profound effect: with blank lines, groupings pop out; without them, the code is a muddle.

## Vertical Density

Lines that are tightly related should appear vertically dense — openness separates concepts, density implies close association. Useless comments or stray blank lines between closely related lines (e.g., two instance variables) break that association and force extra eye and head motion. The cleaned example fits in an "eye-full" — or at least it does for Uncle Bob.

## Vertical Distance

Concepts that are closely related should be kept vertically close, so readers don't chase their tail hopping around the file. Closely related concepts should not live in separate files without a very good reason — this is one reason to avoid protected variables. Vertical separation should measure how important each concept is to understanding the other.

- **Variable declarations**: declare variables as close to their usage as possible. Since functions should be short, locals go at the top of the function. Loop control variables go inside the loop statement. In rare cases (a long-ish function), a variable may be declared at the top of a block or just before a loop.
- **Instance variables**: declare them in one well-known place — top of the class in Java/C#, bottom under the C++ "scissors rule" (public at top, private at bottom). This shouldn't increase their vertical distance from usage, because in a well-designed class they are used by many, if not all, of the methods. The scissors rule is more logical, but follow the pervasive convention of your language rather than confusing everyone by appealing to logic. Never bury declarations mid-file where readers stumble on them by accident.
- **Dependent Functions**: if one function calls another, keep them vertically close, with the caller above the callee if at all possible (below in inverted languages like Clojure), and called functions appearing in call order. Readers then trust that definitions follow shortly after use, giving the program a natural downward flow.
- **Keep constants at the appropriate level**: pass a well-known constant (e.g., a default value) down from the high-level function where knowing it makes sense, rather than burying it in a low-level function.

## Conceptual Affinity

Some code wants to be near other code even without a direct dependence. Affinity might be based on direct dependence — one function calling another, or a function using a variable — but there are other possible causes: a group of functions performing a similar operation under a common naming scheme (e.g., JUnit's assertTrue/assertFalse overloads, where the fact that they call each other is secondary). The stronger the affinity, the smaller the vertical distance should be.

## Horizontal Formatting (line width)

Keep lines short — the statistics show programmers strongly prefer them (40% of lines fall between 20 and 60 characters). The old Hollerith limit of 80 is a bit arbitrary; 100 or even 120 is fine, but beyond that is probably careless. Operating rule: never force your readers to scroll to the right. Uncle Bob personally draws a soft line at column 120 and won't cross it.

## Horizontal Openness and Density

Use horizontal white space to associate strongly related things and disassociate weakly related ones. Surround assignment operators with spaces to accentuate the two sides; put no space between a function name and its opening parenthesis (they are conjoined); put spaces after commas to show arguments are separate. White space can also reflect operator precedence (no space within high-precedence factors like `b*b`, spaces around lower-precedence `+`/`-`) — though most reformatting tools are blind to precedence and erase such subtlety.

## Horizontal Alignment

Don't horizontally align declaration lists or assignment r-values into columns. Alignment emphasizes the wrong things (you read down the column of names and miss the types or the operators). If a list is long enough to seem to need alignment, the problem is the length of the list — it suggests the class should be split — and unaligned code keeps that deficiency visible.

## Indentation

Indent in proportion to position in the hierarchy of scopes (file, class, method, block, nested block). Programmers rely on the left edge to see what scope a line is in, to skip irrelevant scopes, and to scan for declarations; without indentation programs are virtually unreadable by humans.

## Breaking Indentation

Avoid collapsing short if statements, loops, or functions onto one line; whenever Uncle Bob succumbed to that temptation, he almost always went back and restored the indentation. Exception he allows: occasionally a simple one-liner (e.g., `public int getCount() {return count;}`) is more visually appealing than dangling braces.

## Team Rules

Every programmer has favorite formatting rules, "but if they work in a team, then the team rules." The team agrees on one style — brace placement, indent size, naming — encodes it in the IDE/formatter, and everyone complies, even against personal preference (Uncle Bob did so on FitNesse; deciding took about ten minutes). Good software is a set of documents with a consistent, smooth style; readers must be able to trust that a formatting gesture means the same thing in every file. A jumble of individual styles adds complexity.

## Uncle Bob's Formatting Rules

His personal rules are very simple and are shown as code rather than prose: "code makes the best coding standard document." A well-formatted example file communicates the standard better than a written spec.

## In practice

- Run an agreed-upon automated formatter; follow the team's style over your own preferences.
- Keep files small (aim ~200 lines, rarely over 500) and lines short (never force horizontal scrolling; ~100–120 max).
- Put a blank line between each complete thought; remove blank lines and noise comments between tightly related lines.
- Declare variables next to first use; loop variables inside the loop; instance variables in the one conventional place for the language.
- Place a callee just below its caller, in call order; group functions that do similar things, even if they don't call each other.
- Don't column-align declarations or assignments; if a list begs for alignment, split the class instead.
- Indent every scope; don't collapse scopes to one line except the occasional trivial one-liner.
- Keep well-known constants in high-level functions and pass them down.
