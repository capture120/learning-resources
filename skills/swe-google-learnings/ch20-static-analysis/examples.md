# Chapter 20: Static Analysis — Examples, Case Studies, and Anecdotes

All examples come from Chapter 20 of *Software Engineering at Google*. Each is retold in plain language. Terms are defined on first use.

## The dead-code warning that could introduce a bug

**Setup.** Static analysis (automated inspection of source code without running it) often flags "dead code" — code that exists but is never called. A naive policy would demand that developers fix every such warning, even in old code.

**What happened.** The chapter points out that "fixing" a dead-code warning by adding a call to the previously dead code makes untested (possibly buggy) code suddenly run in production. Code that is not being modified and runs fine in production offers unclear benefit and potentially high cost when touched.

**Lesson.** Every warning has a cost-benefit trade-off. Focus on newly introduced warnings and warnings on modified lines. Only surface pre-existing issues in working code when they are especially important (security issues, significant bugs). Developers looking at their own fresh changes also have the most context to judge a warning.

## The hash-table `contains` check: a "wrong" warning developers still want

**Setup.** Google defines an "effective false positive" as any analysis result after which the developer takes no positive action — the false-positive rate as perceived by users, not as measured against technical ground truth. Google has a Java analysis targeting the `contains` method on a hash table. On Java's `Hashtable`, `contains` checks *values* (it is equivalent to `containsValue`), but developers usually mean to check *keys* (`containsKey`).

**What happened.** The analyzer flags every call to `contains`. Sometimes the developer genuinely meant to check for a value, so technically the warning is a false positive. But even then, the developer usually makes the suggested change to `containsValue` anyway, because the explicit name reads more clearly.

**Lesson.** A technically incorrect report that the developer happily acts on is *not* an effective false positive. Conversely, a technically correct report the developer does not understand (and therefore ignores) *is* one. Tool builders should optimize the perceived rate, not the academic one.

## The `long`-hashing shift bug fixed 31 times by Error Prone

**Setup.** Error Prone is Google's tool that extends the Java compiler to spot antipatterns in the abstract syntax tree (the compiler's structured representation of code). A standard Java idiom for hashing a 64-bit `long` field `f` is:

```java
result = 31 * result + (int) (f ^ (f >>> 32));
```

The `>>> 32` shifts the top 32 bits down so both halves of the value influence the hash.

**What happened.** When someone copies this idiom onto a field whose type is `int` (32 bits), the code still compiles, but shifting an `int` right by 32 is a no-op in Java. The field gets XORed with itself, producing zero, so the field silently stops contributing to the hash at all. While enabling this check as a compiler error, Google found and fixed 31 occurrences of this exact bug in its codebase.

**Lesson.** Abstract-syntax-tree antipattern checks catch real bugs that compile cleanly and pass casual review. At large-codebase scale, even an obscure bug pattern appears dozens of times, so mechanical detection pays off. (The chapter adds a readability cousin of this idea: flagging a redundant `.get()` call on a smart pointer in C++.)

## Cross-file and cross-artifact analyzers: Deleted Artifact Analyzer, IfThisThenThat, Finch, binary size

**Setup.** Most analyzers look at one file or one function. Some of Google's analyzers instead reason about relationships between files or about build outputs.

**What happened.**
- The *Deleted Artifact Analyzer* warns when a change deletes a source file that non-code places in the codebase still reference, such as checked-in documentation.
- *IfThisThenThat* lets developers declare that two portions of different files must always change together, and warns when a change updates one without the other.
- Chrome's *Finch analyzer* runs on configuration files for A/B experiments (experiments that show different behavior to different user populations). It flags missing launch approvals and "crosstalk" — two running experiments interfering because they target the same user population. To do this, the analyzer makes remote procedure calls (network requests to other services) for live information.
- A *binary size checker*, enabled by many projects, warns when a change significantly grows the size of a compiled binary — an analysis of a build artifact rather than of source text.

**Lesson.** "Static analysis" is broader than lint rules on one file. An open ecosystem lets teams encode domain knowledge — documentation links, coupled files, experiment safety rules, binary bloat — as automated checks that run on every change.

## The Guava printf check and the "Not useful" bug flood

**Setup.** Tricorder (Google's static analysis platform, integrated into the Critique code review tool) gives every displayed result a "Not useful" button that files a prepopulated bug against the analyzer's author. Error Prone shipped a check for a printf-like function in Guava (Google's common Java library) that accepts *only* the `%s` placeholder — no other printf format specifiers.

**What happened.** The check fired when a call passed too many arguments for its format string. Developers who had written specifiers like `%d` saw the warning, counted their specifiers against their arguments, found the counts matched, and concluded the analyzer was broken. The Error Prone team received weekly "Not useful" bug reports insisting the analysis was wrong. The team then changed only the diagnostic text, stating directly that the function accepts only `%s`. The bug reports stopped.

**Lesson.** Perception drives the effective false-positive rate. A technically correct check with a confusing message behaves, socially, exactly like a broken check. A message that explains what is wrong, why, and how to fix it — at the exact point of relevance — can fix an analyzer without touching its logic, and teaches the developer something in the process.

## The Java readability analyzer that graduated from optional to default

**Setup.** After Tricorder built user trust with high-confidence default-on analyzers, Google added "optional" analyzers that individual projects could enable. One optional analyzer suggested Java readability improvements that typically did not change program behavior.

**What happened.** Users initially worried the analyzer would be too "noisy." The team improved it based on feedback, it accumulated a large voluntary user base, and it eventually graduated to on-by-default status — capitalizing on the trust built during the optional phase.

**Lesson.** Roll out lower-confidence or style-flavored analyzers as opt-ins first. Feedback-driven improvement plus demonstrated demand creates the trust needed to make them universal.

## The Proto Best Practices analyzer: customization that only some projects need

**Setup.** Protocol buffers are Google's language-independent data serialization format. Changing a protocol buffer's data format can break things — but only if serialized data is *stored* somewhere (for example, in server logs) and later read back with the new definition.

**What happened.** Google made the Proto Best Practices analyzer, which highlights potentially breaking data format changes, an *optional* analyzer. Projects that never store serialized protocol buffer data have no reason to enable it; projects that do can opt in.

**Lesson.** Some checks are only meaningful given project-specific facts. Per-project opt-in keeps such checks out of the way for teams where they would be pure noise, protecting overall trust in the platform.

## Removing user-level customization exposed hidden linter bugs

**Setup.** Early in Tricorder's development, simple style checkers ("linters") displayed results in Critique, and Critique offered *user-level* settings: each developer could pick a confidence threshold and suppress specific analyses.

**What happened.** Google removed all user customizability and immediately received complaints about annoying results. Instead of restoring the settings, the team asked users *why* the results annoyed them — and discovered real bugs and false positives that individual suppression had been hiding. The C++ linter had been running on Objective-C files and producing incorrect, useless output; the team fixed the linting infrastructure. The HTML linter had an extremely high false-positive rate with little useful signal and had been near-universally suppressed; the team simply disabled it.

**Lesson.** User-level customization hides bugs and suppresses the feedback loop that tool owners need. Customize per project instead: everyone on a team sees the same results, no one silently suppresses a broken analyzer, and no developer fixes an issue while a teammate reintroduces it.

## Compiler rollout at scale: MapReduce cleanups before turning on a check

**Setup.** The strictest integration point is the compiler itself: a check enabled as a compiler error breaks the build and cannot be ignored. But turning on a new error would instantly break every existing project that violates it.

**What happened.** Google's process: first run compilers (clang for C++, javac for Java) across the entire codebase in parallel on a cluster, structured as a MapReduce operation (a batch data-processing pattern that fans work out to many machines). Checks run this way must produce machine-applicable fixes so the cleanup can be automated. A change applying all the fixes across the codebase is prepared, tested, and committed. Only then does the check turn on as a compiler error, guaranteeing no new instance can ever be committed. The value of a check must be high enough to justify this full cleanup. This is the process by which the `long`-hashing bug above was eliminated (31 fixes, then the check became an error).

**Lesson.** Ratcheting is the pattern: clean up all existing violations first, then lock the door. Fix-producing analyses plus whole-codebase execution infrastructure make this feasible even at multibillion-line scale.

## "Never issue compiler warnings" and the Go extreme

**Setup.** Compilers traditionally distinguish errors (which stop the build) from warnings (which merely print text).

**What happened.** Google found repeatedly that developers ignore compiler warnings. So its policy is binary: a check either breaks the build as an error or does not appear in compiler output at all (it may surface in code review through Tricorder instead). Because the same compiler flags apply across the whole codebase, the choice is made globally. Both the Java and C++ compilers at Google are configured to show no warnings. The Go language takes the philosophy to its extreme: conditions other languages treat as warnings — an unused variable, an unused package import — are hard compile errors in Go.

**Lesson.** An ignorable signal trains people to ignore it. Make a diagnostic blocking or move it to a venue where someone is accountable for it (code review); do not emit it as a warning.

## Why code review beats the IDE for showing results

**Setup.** An integrated development environment (IDE) is another possible place to show analysis results, but IDE analyses must return in under a second (ideally under 100 milliseconds), must behave identically across the multiple IDEs in use (Google mandates no single IDE), and IDEs rise and fall in popularity.

**What happened.** The chapter gives a concrete accuracy example: a dead-code analysis misfires on partial code, such as when a developer implements a function *before* writing its callers — in the IDE mid-edit, the function looks dead; in code review, the full change with callsites is visible. Code review adds a social property too: an author who wants to dismiss an analysis result must convince the reviewers as well.

**Lesson.** Code review is the sweet spot: full change context, time for slower analyses (the author is blocked on reviewers anyway), and peer accountability. IDE integration remains a good extra venue for analyses fast and stable enough to fit it.

## When browsing the whole codebase is the right view: security teams and cleanups

**Setup.** Google's default is to show only newly introduced warnings, not the backlog of issues in existing code.

**What happened.** Two groups want the opposite. Security teams want a holistic view of *every* instance of a vulnerability pattern across the codebase, not just new ones. And developers planning a cleanup want to browse all occurrences of an issue to scope the work. (A footnote adds that reviewers may also tolerate much higher false-positive rates for analyses that identify critical security problems.)

**Lesson.** "New warnings only" is a default, not a law. Whole-codebase result browsing serves holistic audits and cleanup planning, and the acceptable false-positive bar shifts with the severity of what the analysis finds.

## Tricorder itself: the platform born from failed attempts

**Setup.** Before Tricorder, Google made several attempts to integrate static analysis into the developer workflow. They failed.

**What happened.** Tricorder succeeded where predecessors did not because of one difference: a relentless focus on delivering *only valuable results* to users. It integrates with Critique (results appear as gray comment boxes on the diff), runs as microservices reading changed files through a FUSE-based filesystem with cached build inputs and outputs, and posts status updates while multi-minute analyses run. Scale: over 50,000 review changes analyzed per day, results in more than 30 languages, over 100 analyzers (mostly contributed from outside the Tricorder team, seven being plug-in systems with hundreds more checks), an overall effective false-positive rate just below 5%, "Please fix" clicked thousands of times per day, automated fixes applied about 3,000 times per day, and "Not useful" clicked about 250 times per day. Analyzers with persistently high "Not useful" rates get disabled if their owners do not improve them.

**Lesson.** The platform's survival hinged on trust economics, not analysis sophistication: strict admission criteria for checks, measurable feedback loops with teeth (disable unresponsive analyzers), and workflow-native display of results.
