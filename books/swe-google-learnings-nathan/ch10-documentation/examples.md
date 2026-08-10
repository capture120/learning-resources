# Chapter 10: Documentation — Examples, Case Studies, and Anecdotes

All examples come from Chapter 10 ("Documentation") of *Software Engineering at Google*. Each is retold in plain prose so it stands alone without the book.

## Case Study: The Google Wiki (GooWiki)

**Setup.** When Google was small it had few technical writers, so the easiest way to share engineering knowledge was a single internal wiki called GooWiki. Every engineer shared one documentation set and could edit anything. At small scale this seemed reasonable.

**What happened.** As Google grew, the wiki model broke down. Documents had no true owners, so many went obsolete. There was no process for adding documents, so duplicates proliferated. The wiki had a flat namespace and nobody imposed hierarchy, so at one point there were 7 to 10 different documents on setting up Borg (Google's production compute environment), only a few of which were maintained, and most of which baked in team-specific permissions and assumptions. A deeper structural problem emerged: the people who could fix the documents were not the people who used them. New users hitting a broken document couldn't confirm it was wrong or report the error, while the experts who could fix it never needed to read it again. Documentation quality decayed until it became the number one developer complaint on Google's annual internal developer surveys. (When GooWiki was finally deprecated, roughly 90% of its documents had no views or updates in the preceding few months.)

**The fix.** Google moved important documentation under the same source control used for code. Documents gained owners, canonical locations in the source tree, and bug-tracking for errors; changes went through the existing code review process. Markdown as a common format meant engineers could edit docs without knowing HTML or CSS. Google later built g3doc, a framework for embedding documentation inside the codebase, so docs lived beside source code in the engineer's development environment and code and docs could be updated in the same change. The move was controversial — many engineers feared that raising the bar (required reviews, required owners) would kill the wiki's "freedom of information" and lower quality. The opposite happened: the documents got better, and engineers began fixing docs themselves or sending changes to the technical writers who owned them.

**Lesson.** Wikis fail at scale because they lack ownership, canonical sources, and a feedback loop between readers and fixers. Treating documentation like code — source control, owners, reviews, bug tracking — and leveraging *existing* developer workflows rather than inventing new ones is what made documentation improve.

## Case Study: The Developer Guide Library

**Setup.** The same wiki-era problems (no ownership, competing documents, obsolete information, no way to file doc bugs) afflicted most Google documentation — but notably *not* the Google C++ Style Guide. That document stayed healthy because a select group of senior engineers ("style arbiters") implicitly owned it, and it was canonical: there was exactly one C++ style guide.

**What happened.** Google generalized the pattern. Documentation tied to a specific API moved into per-API g3doc directories (Markdown files readable in the Code Search browser), which established de facto ownership and made docs feel like part of the code. But some documentation — for example a "C++ developer guide" for all Googlers — crosses API boundaries and has no natural home in the source tree. For these, Google created standalone documentation sets in their own dedicated repository ("depot"), organized by topic rather than by API, with common navigation and look-and-feel. These "Developer Guides" were typically managed by technical writers, who are better at explaining topics that span API boundaries. Over time the guides became canonical: authors of competing or supplementary documents merged their content into the canonical set and deprecated their own copies; the C++ style guide itself became part of a larger C++ Developer Guide. Engineers started filing bugs because they knew someone maintained the documents, and started sending changelists directly to the technical writers. Memorable short links ("go/ links", e.g., go/cpp) plus better internal search cemented the guides' canonical, authoritative status.

**Lesson.** Ownership plus canonical status is what keeps a document alive. Documents that cross API boundaries deserve their own topic-organized, writer-managed documentation sets — and once a canonical set exists, competing documents naturally fold into it.

## Example: File comment for str_cat.h

**Setup.** Nearly every code file at Google must open with a file comment. The book shows the header comment from Abseil's `str_cat.h`.

**The example.** The comment opens with a banner naming the file, then states in one paragraph that the header contains functions for efficiently concatenating and appending strings — `StrCat()` and `StrAppend()` — and notes that the work is handled through a special `AlphaNum` parameter type that manages string conversion and avoids copies.

**Lesson.** A file comment should begin with an outline of what the code contains, its main use cases, and its intended audience. And it doubles as a design test: any API that cannot be succinctly described in the first paragraph or two is usually a sign of an API that is not well thought out and should be broken into separate components.

## Example: Class comment for AlphaNum

**Setup.** All public classes and structs at Google must carry a class comment describing the class, its important methods, and its purpose.

**The example.** The `AlphaNum` class comment says the class acts as the main parameter type for `StrCat()` and `StrAppend()`, providing efficient conversion of numeric, boolean, and hexadecimal values into strings.

**Lesson.** Class comments should be "nouned" — written to emphasize the object aspect: "The Foo class contains x, y, z, allows you to do Bar, and has the following Baz aspects."

## Example: Function comment for StrCat() and the verb-first convention

**Setup.** All free functions and public methods at Google must have a function comment describing what the function does.

**The example.** The `StrCat()` comment reads: "Merges the given strings or numbers, using no delimiter(s), returning the merged result as a string." Starting with an indicative verb creates consistency across a header file: a seeker scanning the API can read just the leading verbs — "Merges, Deletes, Creates" — to judge whether a function fits their need.

**Lesson.** Function comments should stress the active nature of use, opening with a verb that states what the function does and returns. Consistency is the pedagogical device that serves seekers.

## Example: AddCustomer — prose over boilerplate sections

**Setup.** Some documentation styles and generators demand boilerplate sections on every function comment: "Returns:", "Throws:", and so on. Google found these unnecessary.

**The example.** A single-sentence comment: "Creates a new record for a customer with the given name and address, and returns the record ID, or throws `DuplicateEntryError` if a record with that name already exists." — on `int AddCustomer(string name, string address)`. The postcondition, parameters, return value, and exceptional case are documented together in one sentence because they are not independent of one another.

**Lesson.** Explicit boilerplate sections make comments more verbose and repetitive but no clearer — arguably less clear. Prefer unified prose when the pieces of the contract depend on each other.

## Example: A bad tutorial, made better

**Setup.** Tutorials must walk a newcomer through steps in order. The book contrasts a bad seven-step tutorial with a fixed four-step version for installing a fictional "foobar" system.

**What was wrong.** The bad version numbered seven steps: download the package, copy the shell script home, execute it, "the foobar system will communicate with the authentication system," "once authenticated, foobar will bootstrap a new database named baz," test baz by executing a SQL command, and finally "Type: CREATE DATABASE my_foobar_db;". Steps 4 and 5 happen on the server — the user does nothing — yet they were numbered as if the user must act. Steps 6 and 7 look like two steps but are actually one.

**The fix.** The improved version has four numbered steps, each requiring specific user intervention, each showing the exact command on its own line in monospace (e.g., `$ curl -I http://example.com`, `$ cp foobar.sh ~`, `$ cd ~; foobar.sh`, `baz:$ CREATE DATABASE my_foobar_db;`). The server-side side effects (authentication, database bootstrap) are folded into the prose of the execution step instead of being numbered.

**Lesson.** Number only the actions the user takes, not system responses; combine atomic user operations into single steps; show user-visible input and output on separate monospaced lines. If a tutorial's focus is something else (e.g., "life of a server"), number from that perspective instead. Nothing is more annoying than failing at step 4 because the author forgot to say you needed to authorize your username.

## Example: Abseil's StrFormat concepts document

**Setup.** Even a well-scoped API can need more explanation than its reference provides.

**What happened.** Abseil's StrFormat string-formatting library involves a variety of concepts that accomplished users need to understand, so Google provides a separate "format concepts" document alongside the reference, both internally and externally.

**Lesson.** Conceptual documentation augments reference documentation; when an API's ideas span its surface (or multiple APIs interact), a standalone concept document is the right home. Related aphorism from the chapter: if comments are the unit tests of documentation, conceptual documents are the integration tests.

## Example: "C++ Tips of the Week" — even tiny documents need sections

**Setup.** Google's popular internal "C++ Tips of the Week" are very short documents, each focused on one small piece of advice.

**What happened.** Even at that size, each tip uses a beginning-middle-end structure: the first section states the problem, the middle walks through recommended solutions, and the conclusion summarizes the takeaways. Single-section versions would leave readers struggling to tease out the important points.

**Lesson.** Nearly every document has more than one thing to say. Sections provide a roadmap, and deliberate redundancy — summarize the point up front, argue it in detail below — helps readers grasp what matters.

## Example: The "TL;DR statement" opener

**Setup.** "Stumblers" — readers who only vaguely know what they're looking for — waste time on documents that aren't for them.

**What happened.** Many Google documents open with an explicit audience filter, e.g., "TL;DR: if you are not interested in C++ compilers at Google, you can stop reading now."

**Lesson.** Clearly identifying when a document is *not* appropriate for a reader is itself a service; clarity for stumblers starts with the very first line.

## Example: Freshness dates in documentation metadata

**Setup.** Documents rot like code does, and the main long-term concern for any document is maintainability.

**What happened.** Google attaches machine-readable freshness metadata to documents, e.g.:

```
<!--*
# Document freshness: For more information, see go/fresh-source.
freshness: { owner: `username` reviewed: '2019-02-27' }
*-->
```

The documentation system emails the owner a reminder when the document hasn't been touched in, say, three months. Because the docs live in source control, updating the date requires a code review — a low-cost forcing function to look the document over. Google also found that displaying the owner in a visible "Last reviewed by..." byline increased adoption, since named ownership creates an incentive to keep the date current.

**Lesson.** Cheap automated freshness tracking plus visible named ownership keeps a documentation set maintained over time.

## Anecdote: Assigning technical writers to "important" projects backfired

**Setup.** In Google's growth years (and still today) there were never enough technical writers. The early policy gave writers to projects deemed important, on the theory that a writer would relieve the team of documentation burden and let the important project move faster.

**What happened.** The assumption proved wrong. Teams can document things for their own team perfectly well — the feedback loop is immediate and the shared assumptions are clear. Dedicating a scarce writer to one team didn't scale, and it created a perverse incentive: become an important project and your engineers won't need to write documents. That discourages engineers from writing — the opposite of the goal.

**Lesson.** Deploy technical writers where engineers genuinely struggle: documentation for *other* audiences, especially documentation that crosses API boundaries. A writer's unfamiliarity with the domain is an asset there, and one of their critical roles is to challenge the team's assumptions about the project's utility.

## Anecdote: Documentation today is like testing in the 1980s

**Setup.** The chapter frames documentation's organizational status with a historical comparison.

**What happened.** The state of engineering documentation in the late 2010s resembles the state of software testing in the late 1980s: everyone agrees more effort is needed, but organizations don't yet recognize its critical benefits. Testing eventually became universally accepted at Google — every code change gets tested, with rich tooling plugged into the workflow. Documentation lags because docs, unlike tests, mostly can't be made atomic, can't follow prescribed form, can't be automated, and are judged subjectively by the reader rather than the writer, often long after writing.

**Lesson.** Documentation is on the same acceptance curve testing traveled. The way forward is the same: fold it into the engineering workflow, and accept that engineers are both the problem and the solution — for any code expected to live more than a few months, documenting it pays back the author, not just the readers.

## Aside: Pascal on brevity

The chapter quotes Blaise Pascal — "If I had more time, I would have written you a shorter letter" — to make the point that short, clear documents cost the writer extra editing effort (write long, then cut duplication), but that expense is amortized across every reader, and a short clear document satisfies experts and novices simultaneously.
