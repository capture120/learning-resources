# Chapter 05: Comments

Comments are, at best, a necessary evil: every comment is a failure to express intent in code. The only language of truth is the code itself, so spend your energy making code so clear and expressive that comments become unnecessary — but write a good comment when code genuinely cannot carry the explanation.

## Compensating for Failure
The proper use of comments is to compensate for our failure to express ourselves in code. When you feel the need to write a comment, first try to turn the tables and express the same thing in code. Comments may sometimes be necessary, but that necessity is unfortunate, never a cause for celebration. This is not a license for laziness: never use "comments are failures" as an excuse to skip needed explanation and context.

## Comments Should Be Visible
IDEs collapse, gray out, or grass-green comments precisely because we want to ignore them. Martin paints comments fire-engine red: if someone wrote one, read it — then delete it on the spot if it doesn't help, or fix it on the spot if it's wrong. Comments, when they exist, should be visible.

## Lying Comments
Comments often lie; the lies aren't intentional, but they are also not infrequent. The older a comment is and the farther it sits from the code it describes, the more likely it is to be plain wrong, because code moves and evolves while comments become orphaned blurbs. Inaccurate comments are far worse than no comments: they delude, mislead, and set expectations that will never be fulfilled. Truth lives in only one place — the code — so minimize comments rather than demanding the discipline to maintain them.

## Comments That Are Too Intimate
Authors write comments from intimate knowledge of their code, but readers lack that intimacy. A comment that only makes sense after you've already understood the code has failed at its one job. Write comments for the reader's context, not your own.

## Comments Do Not Make Up for Bad Code
"Don't comment bad code—rewrite it" (Kernighan & Plaugher, one of the chapter's two epigraphs — the other is Jeff Langr's "Comments are the distracting footnotes of code"). A common motivation for commenting is messy code: "Ooh, I'd better comment that!" No — you'd better clean it. Clear, expressive code with few comments beats cluttered, complex code with many comments. Spend the time cleaning the mess, not annotating it.

## Explain Your Intent in Code
Code is usually a fine vehicle for explanation; the belief that it seldom is, is patently false. In many cases it's simply a matter of creating a function that says the same thing as the comment you wanted to write (e.g. `employee.isEligibleForFullBenefits()` instead of a comment over a flags-and-age check). It takes only a few seconds of thought.

## Good Comments (worth the bits they consume)
- **Legal Comments**: copyright/license headers mandated by standards are reasonable; where possible, refer to a standard license or other external document rather than embedding legal tomes.
- **Informative Comments**: basic facts the code can't carry — e.g. explaining a regex's intended match format, or a return value when a naming convention (like the Singleton pattern's `…Instance` form) prevents a more descriptive name.
- **Explanation of Intent**: documenting the *why* behind a decision. Even if readers disagree with the solution, they know what the author was trying to do.
- **Clarification**: translating obscure arguments or return values into readable form — justified mainly when the code is standard-library or otherwise unalterable. Risky: clarifying comments can themselves be wrong and are hard to verify.
- **Warning of Consequences**: warning other programmers ("Don't run unless you have some time to kill"; "SimpleDateFormat is not thread safe"). Prevents eager mistakes. Prefer mechanisms like `@Ignore("reason")` when the platform offers them.
- **Amplification**: flagging that something seemingly inconsequential (a `trim()` call) is in fact critical.
- **Javadocs in Public APIs**: nothing is as helpful as a well-described public API; if you publish one, write good doc comments — but they can lie, mislead, and go nonlocal like any other comment.

## Bad Comments (delete on sight)
Bad comments are usually crutches or excuses for poor code, or justifications for insufficient decisions — the programmer talking to themselves.
- **Mumbling**: a comment plopped in because process demands it, whose meaning forces the reader to look in other modules. Any comment that forces you elsewhere for its meaning has failed.
- **Redundant Comments**: comments that say nothing the code doesn't, take longer to read than the code, and are less precise — enticing the reader to accept imprecision in lieu of understanding ("a used-car salesman assuring you that you don't need to look under the hood"). Sloppy, imprecise comment prose (terms used interchangeably, wandering capitalization) confuses and misleads — and makes the reader wonder whether the imprecision carries over into the code.
- **Misleading Comments**: well-intentioned but subtly inaccurate statements (e.g. "returns when closed is true" for a method that actually times out blindly) that send other programmers into debugging sessions.
- **Mandated Comments**: rules requiring a Javadoc on every function or a comment on every variable are just plain silly; they produce clutter, propagate misinformation, and add zero documentary value.
- **Journal Comments**: change logs at the top of a module. Source control keeps the journal now; delete them.
- **Noise Comments**: restating the obvious ("Default constructor.", "The day of the month."). We learn to skip them, and then fail to notice when they begin to lie. Frustration-venting comments ("Give me a break!") signal energy that should go into restructuring the code.
- **Scary Noise**: noisy doc comments whose copy-paste errors prove even the author wasn't reading them.
- **TODO Comments**: Martin reversed his first-edition position — experience taught him "TODO means Don't Do." He still writes TODOs while working but never checks them in: do the thing, eliminate the need for it, or put it in the backlog.
- **Position Markers**: banner comments (`// Actions ////`). Rarely justified; overuse turns them into background noise, like the boy who cried "Wolf!"
- **Attributions and Bylines**: `/* Added by Rick */` is graffiti. Same for PR numbers and JIRA tags — put them in commit messages, where source control keeps them accurate.
- **Commented-Out Code**: an abomination — don't check it in. Others won't dare delete it, so it gathers like dregs. Source control remembers code for you. (Commenting out while debugging is fine; the rule is never to commit it.)
- **HTML Comments**: HTML markup makes comments unreadable in the one place they should be easiest to read — the source. Formatting is the documentation tool's job, not the programmer's.
- **Nonlocal Information**: a comment must describe the code it appears near, not systemwide facts (like a default port set elsewhere) that the local code does not control and that will drift out of date.
- **Too Much Information**: historical discussions and arcane details (RFC excerpts) nobody reading the code needs.
- **Unobvious Connection**: the link between a comment and its code must be obvious. A comment whose terms ("filter bytes", "+200") raise more questions than they answer needs its own explanation — a pity, since its purpose was to explain.
- **Function Headers**: short functions don't need much description; a well-chosen name and signature for a small function that does one thing is usually better than a comment header (`generateNPrimes(int n)` over a Javadoc on `generate(int n)`).
- **Javadocs in Nonpublic Code**: for code maintained by a small team and not for public consumption, the formality of doc comments is cruft and distraction.

## Use a Function or a Variable Instead of a Comment
When a comment explains a condition or computation, extract explanatory variables or functions until the code reads like well-written prose. The extracted names are easier to understand than the comment was.

## Conclusion
Comments are not "pure good." They are sometimes utterly essential and other times dangerous and damaging. When code cannot carry the intent, accepting the risk of ambiguous natural language can be worth it — but tread carefully; there dwell dragons.

## In practice
- Before writing a comment, try to express the same thing in code: rename, extract a function, or introduce an explanatory variable.
- Treat every comment you write as a (sometimes necessary) failure; treat every comment you read as suspect until verified against the code.
- When you encounter a comment: read it; delete it if it doesn't help; fix it on the spot if it's wrong or stale.
- Keep allowed comments local, accurate, minimal, and written for a reader without your context.
- Write good doc comments for public APIs; skip mandated/boilerplate doc comments on internal code.
- When a comment is genuinely necessary, the worthy categories are: informative facts the code can't carry, intent behind decisions, warnings of consequences, amplification of non-obvious importance, clarification of unalterable code, legal headers — but still expend significant energy to minimize even these.
- Never check in: commented-out code, TODOs, journal/changelog comments, bylines, PR/ticket tags, noise or redundant comments.
- Never comment a mess — clean it instead.
