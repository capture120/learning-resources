# Chapter 2: The Nature of Complexity — Examples

## Web site banner color, version (a): color hard-coded on every page

**Design problem:** A web site has many pages, each displaying a banner with a background color.

**Bad approach (Figure 2.1a):** Each page specifies the color explicitly (`bg = "red"` repeated on every page), as many early web sites did. Changing the site's background color means hand-editing every page — nearly impossible for a site with thousands of pages. Every page implicitly depends on every other page, because they must all stay in sync.

**Lesson / principle:** This is the canonical illustration of **change amplification** — a simple design decision (banner color) is duplicated everywhere, so one conceptual change requires many code modifications. It also shows **dependencies** as a cause of complexity: all pages depend on each other through the shared color requirement. Good design reduces the amount of code affected by each design decision.

## Web site banner color, version (b): central shared variable

**Good approach (Figure 2.1b):** Specify the color once in a central place (`bannerBg = "red"`); every page references that shared value (`bg = bannerBg`). The whole site's banner color changes with a single modification.

**Nuance the book draws out:** This did not eliminate dependency — it replaced one kind with another. Pages no longer depend on each other; instead each depends on the `bannerBg` API. But the new dependency is **simpler and more obvious**: it is clear each page depends on `bannerBg`, all uses are findable by searching the name, and the compiler catches stale references if the variable is renamed.

**Lesson / principle:** Dependencies can't be fully eliminated (every API creates them); the goal is to **reduce their number and make the remaining ones simple and obvious**. Replacing a nonobvious, manually-maintained dependency with an explicit, tool-checked one is real progress.

## Web site banner color, version (c): hidden emphasis color (unknown unknowns)

**Setup (Figure 2.1c):** The site uses the central `bannerBg` variable, so changing the color looks easy. But a few pages display an extra emphasis color — a darker shade of the banner background (`emph = "darkred"`) — and that darker color is hard-coded on those individual pages. If the background changes, the emphasis color must change to match.

**Why it's bad:** A developer changing `bannerBg` is unlikely to realize the emphasis color exists. Even a developer who knows about it can't easily tell which pages use it, so they may have to search every page in the site. The needed knowledge is invisible at the point of change; the bug surfaces only after the change ships.

**Lesson / principle:** This is the chapter's concrete example of **unknown unknowns**, the worst symptom of complexity — there is something you need to know, but no way to find out what it is or even that there is an issue. It is also **obscurity**: an important dependency (emphasis derives from background) is not visible anywhere a developer would look.

## C function that allocates memory and expects the caller to free it

**Setup:** A C function allocates memory, returns a pointer to it, and assumes the caller will free it.

**Why it's bad:** Every developer who uses the function must know and remember this obligation; forgetting it causes a memory leak. The obligation is an extra fact developers must carry, i.e. **cognitive load**.

**Better approach:** Restructure so callers don't have to worry about freeing — the same module that allocates the memory also takes responsibility for freeing it.

**Lesson / principle:** Reduce cognitive load by restructuring responsibilities rather than by asking users to remember more. Correct use of an API should require knowing fewer nonlocal facts.

## Frameworks where apps take few lines but those lines are very hard to write

**Setup:** Ousterhout has seen frameworks that let applications be written in only a few lines of code, but it was extremely difficult to figure out what those lines should be.

**Lesson / principle:** **Lines of code do not measure complexity.** The assumption "shorter implementation = simpler, few-line change = easy change" ignores cognitive load. Sometimes an approach that requires *more* lines of code is actually simpler, because it reduces cognitive load. Use understandability and modifiability — not terseness — as the test of simplicity.

## Network protocol sender and receiver

**Setup:** A network protocol typically has separate code for the sender and the receiver, but both must conform to the same protocol.

**Why it illustrates dependency:** Changing the sender's code almost always requires corresponding changes at the receiver, and vice versa. Neither side can be understood or modified in isolation.

**Lesson / principle:** A concrete instance of the book's definition of a **dependency**: code that cannot be changed without considering or modifying other code. Such dependencies are inherent to the problem; the design goal is to keep them simple and obvious.

## Method signature as a dependency

**Setup:** A method's signature creates a dependency between the method's implementation and every call site: add a new parameter and all invocations must be modified to supply it.

**Lesson / principle:** Dependencies are a fundamental, intentional part of software — every class you write creates dependencies around its API. They aren't evil per se; the goal is fewer of them, each as simple and obvious as possible (and ideally compiler-enforced, like signature mismatches).

## Obscure variable names and missing units

**Setup:** A variable named something as generic as `time` carries almost no useful information. Or a variable's documentation omits its units, so the only way to find out is to scan the code for places it is used.

**Lesson / principle:** Examples of **obscurity** — important information that is not obvious. Names and declarations should carry the information a reader needs; if readers must hunt through usages to learn basic facts, the design is obscure.

## Error status requiring an entry in a distant message table

**Setup:** When a new error status is added to a system, an entry must also be added to a table holding a string message for each status — but nothing at the status declaration reveals that the message table exists.

**Lesson / principle:** Obscurity often hides a dependency: the status declaration and the message table must change together, but the link is invisible. This kind of hidden coupling produces unknown unknowns — a developer adds the status, misses the table, and learns about it from a bug.

## One variable name used for two purposes

**Setup:** The same variable name is used for two different purposes in different places, so developers can't tell which purpose a particular use serves.

**Lesson / principle:** **Inconsistency is a major contributor to obscurity.** Consistent, single-purpose naming keeps important information visible.
