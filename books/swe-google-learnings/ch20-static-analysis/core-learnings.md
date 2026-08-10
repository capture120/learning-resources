# Chapter 20: Static Analysis

*Software Engineering at Google* — written by Caitlin Sadowski, edited by Lisa Carey.

## Chapter Thesis

Static analysis means programs that examine source code (without running it) to find bugs, antipatterns, and other issues. The chapter's central claim is that the hard part of static analysis in a large organization is not inventing clever analyses. The hard part is scalability and usability: making tools fast enough for an enormous codebase and trustworthy enough that developers actually act on their output. Google succeeded by focusing on developer happiness (aggressively low false-positive rates plus real feedback channels), by wiring analysis into the workflow developers already use (chiefly code review, plus compiler errors, commit gates, and IDEs), and by letting any engineer contribute checks so domain expertise scales across the company. Static analysis then does more than find bugs: it codifies best practices, keeps code on modern APIs, prevents backsliding during migrations, and teaches developers as they work.

## Core Principles and Ideas

### What static analysis is and what it is for
- Static analysis inspects source code without executing it. Dynamic analysis (the contrast term) observes a running program.
- Static analysis finds bugs early, before code is checked in. Examples of catchable issues include constant expressions that overflow, tests that never run, and invalid format strings in logging statements that would crash at runtime.
- Beyond bug finding, Google uses static analysis to codify best practices, verify naming conventions, flag deprecated APIs, suggest simpler equivalent expressions, keep code current with modern API versions, and reduce technical debt.
- Static analysis is integral to API deprecation and large-scale changes: it prevents backsliding (new code reintroducing the old API) during a migration.
- Static analysis checks educate developers. Google has evidence that checks actually prevent antipatterns from entering the codebase in the first place.
- Static analysis lets expensive processes (human review, testing) focus on issues that cannot be verified mechanically.

### Scalability
- Tools must scale to a multibillion-line codebase without slowing development. Google makes analyses shardable and incremental: analyze only the files affected by a pending change, and typically show results only for edited files or lines.
- Scale is also an opportunity: a huge codebase contains lots of low-hanging-fruit bugs.
- Scaling the *process* matters too: infrastructure avoids human bottlenecks by routing analysis results directly to the relevant engineers rather than through a central triage team.
- Scaling the number and variety of analyses is done by soliciting contributions from across the whole company.

### Usability and the cost-benefit trade-off
- Every warning has a cost: developer time to triage or fix, plus the risk that a "fix" introduces a bug. Fixing a dead-code warning by adding a call to previously dead code can suddenly run untested, possibly buggy code.
- Therefore Google focuses on *newly introduced* warnings (or warnings on modified lines). Existing issues in working code are only worth surfacing when particularly important (security issues, significant bugs). Developers viewing warnings on their own fresh changes also have the most context.
- Anything that can be fixed automatically should be fixed automatically. A machine-applicable fix lowers the cost side of the trade-off.
- Homogenizing everything into one workflow lets a dedicated tools team evolve analysis tools together with the workflow and the code.

### False positives, false negatives, and the "effective false positive" rate
- A false negative: the code has an issue the tool was designed to find, and the tool misses it. A false positive: the tool flags code that does not have the issue.
- Academic research historically optimized for fewer false negatives. In practice, a low false-positive rate is what makes developers willing to use a tool at all.
- The key mental model is the **effective false-positive rate**: the false-positive rate *as perceived by developers*. An issue is an effective false positive if the developer took no positive action after seeing it.
  - A technically correct warning with a confusing message that users misread as wrong counts as an effective false positive.
  - A technically correct but unimportant warning counts as an effective false positive.
  - Conversely, a technically *incorrect* report that the developer happily fixes anyway (because the fix improves readability or maintainability) is *not* an effective false positive.
- User trust is the decisive asset. Deploy only analyses with low false-positive rates, measure tool performance, and act on user feedback in real time. This creates a virtuous cycle between tool users and tool authors.
- One noted exception: reviewers may tolerate much higher false-positive rates for analyses that find critical problems, such as certain security analyses.

### The three key lessons (the chapter's core framework)
1. **Focus on developer happiness.** Measure how tools perform. Keep effective false positives low. Build and act on real-time feedback loops between analysis consumers and analysis writers.
2. **Make static analysis part of the core developer workflow.** The primary integration point at Google is code review. Developers are already in a change mindset there, they are blocked waiting on reviewers anyway (so multi-minute analyses fit), reviewers apply peer pressure to address warnings, and analysis saves reviewer time by catching mechanical issues. Code review is "a sweet spot" for analysis results.
3. **Empower users to contribute.** Domain experts and bug-bitten developers write new analyzers and checks. Google builds an ecosystem that is easy to plug into, with simple APIs usable by ordinary engineers, not just analysis or language experts. Refaster is an example: it lets an engineer define an analyzer by writing before-and-after code snippets demonstrating the intended transformation.

### Tricorder: Google's static analysis platform
- Tricorder is the platform that runs static analysis and displays results inside Critique (Google's code review tool) as gray comment boxes on the diff.
- Tricorder emerged after several failed attempts to integrate static analysis into the workflow. The difference: a relentless focus on delivering *only valuable results* to users.
- Architecture: microservices. Tricorder sends analyze requests plus change metadata to analysis servers. Servers read the changed file versions through a FUSE-based filesystem (FUSE means "Filesystem in Userspace," a way to expose data as ordinary files) and access cached build inputs and outputs. Results go to a storage layer; the latest result per category shows in Critique. Servers post status updates because analyses can take minutes.
- Scale numbers: more than 50,000 code review changes analyzed per day, often several analyses per second, results in more than 30 languages, more than 100 analyzers (most contributed from outside the Tricorder team), seven of which are themselves plug-in systems hosting hundreds of additional checks. Overall effective false-positive rate: just below 5%.
- **Four criteria for a new Tricorder check:**
  1. Be understandable — any engineer can understand the output.
  2. Be actionable and easy to fix — the result should include guidance on how to fix the issue.
  3. Produce less than 10% effective false positives — developers should feel the check points at a real issue at least 90% of the time.
  4. Have the potential for significant impact on code quality — issues need not affect correctness, but developers should take them seriously and deliberately choose to fix them.
- Most analyzers are intraprocedural (they reason only about code within a single function). Interprocedural analysis is feasible but would need extra infrastructure such as stored method summaries.

### Feedback channels
- Every Tricorder result carries a "Not useful" button that files a prepopulated bug against the analyzer's author. Reviewers have a "Please fix" button to ask authors to address a result.
- The Tricorder team tracks analyzers with high "Not useful" rates (especially relative to "Please fix" rates) and *disables* analyzers whose owners do not fix the problems.
- Daily volumes: "Please fix" clicked thousands of times per day; automated fixes applied about 3,000 times per day; "Not useful" clicked about 250 times per day.
- Before clear feedback channels existed, developers simply ignored results they did not understand.
- Sometimes the fix for a "bad" analyzer is just rewriting its diagnostic message. A good message explains what is wrong, why, and how to fix it, exactly where the developer needs it — and teaches the developer something.

### Suggested fixes
- Checks provide machine-applicable fixes when possible. Fixes double as documentation when the message is unclear, and they cut the cost of acting on a warning. Fixes can be applied in Critique or across a whole change via a command-line tool.
- Style and formatting issues should be fixed automatically by formatters. Pointing out formatting errors is not a good use of a human reviewer's time.

### Per-project customization (not per-user)
- After building trust with high-confidence, on-by-default results, Google added *optional* analyzers that projects can opt into (example: the Proto Best Practices analyzer, which flags breaking data-format changes to protocol buffers — those changes only matter for projects that store serialized data).
- Optional analyzers can graduate to on-by-default after improving through feedback and building a user base (a Java readability analyzer followed this path).
- The key insight: customize at the *project* level, never the *user* level. Project-level settings give all team members a consistent view and prevent one developer fixing an issue while another reintroduces it.
- Google tried user-level customization early on and removed it. User customization hid infrastructure bugs and suppressed the feedback needed to fix bad analyzers.

### Presubmits (commit gates)
- Developers can ignore code review warnings, so Google also supports presubmit checks: analyses that block committing a pending change.
- Built-in presubmits check change contents and metadata — for example, the commit description must not say "DO NOT SUBMIT," and test files must accompany corresponding code files. Presubmits also verify formatting, required test suites, and absence of Tricorder issues in chosen categories.
- Presubmits run when a change is mailed for review and again at commit, and can be triggered ad hoc.
- Teams write custom presubmits to enforce stricter standards than the company baseline (useful for new projects without legacy code). Because team-specific presubmits can obstruct large-scale changes, some are skipped for changes marked "CLEANUP=" in the description.

### Compiler integration
- Even earlier than presubmit: push analysis into the compiler as build-breaking errors. A broken build cannot be ignored.
- Criteria for a compiler check (Java's list; C++ is similar): actionable and easy to fix (ideally with a mechanically applicable suggested fix); *no* effective false positives (never stop the build on correct code); issues affecting only correctness, not style or best practices. Compiler checks must also be fast.
- Enabling a new compiler check requires first cleaning up every existing instance in the codebase. Google runs compilers (clang, javac) over the whole codebase in parallel on a cluster as a MapReduce operation; checks run this way must produce fixes so cleanup can be automated. After the cleanup change is committed, the check is turned on so no new instance can be committed without breaking the build.
- **Never issue compiler warnings.** Developers ignore warnings, repeatedly and reliably. A check is either an error that breaks the build or is not shown in compiler output at all (it may instead appear in code review via Tricorder). Because compiler flags are uniform across the codebase, this is a global decision. Java and C++ compilers at Google display no warnings. Go goes furthest: things other languages treat as warnings (unused variables, unused imports) are compile errors.

### IDE and code-browsing integration
- IDE analyses must be very fast (under 1 second, ideally under 100 ms), so some tools do not fit there. IDE integration is also messier: multiple IDEs must run analyses identically, and IDEs rise and fall in popularity.
- Code review beats the IDE for many analyses: the whole change is visible (some analyses are inaccurate on partial code, such as dead-code analysis when a function lands before its callers), and an author who wants to ignore a result must convince the reviewers too.
- Whole-codebase result browsing has its place: security teams want a holistic view of every instance of a problem, and developers planning a cleanup want to see all occurrences.

## Actionable Guidance

- Deploy only analyses with a low *effective* false-positive rate; hold checks to a bar like Tricorder's four criteria (understandable, actionable with fix guidance, under 10% effective false positives, significant quality impact).
- Measure perceived usefulness (e.g., "Not useful" vs. "Please fix" signals) and disable analyzers whose owners do not respond to feedback.
- Show warnings on new or modified code only; surface old issues only when they are important (security, significant bugs).
- Provide machine-applicable fixes wherever possible; auto-fix everything auto-fixable, especially formatting and style.
- Integrate analysis where developers already are: code review first, then presubmit gates, compiler errors, IDEs, and code browsing for special cases.
- Treat compiler diagnostics as binary: break the build or stay silent. Never emit ignorable warnings.
- Before enabling a build-breaking check, fix every existing violation across the codebase (automate this with fix-producing analyses run at scale).
- Customize analyzers per project, never per user.
- Invest in diagnostic message quality; a clearer message can eliminate a stream of false-positive complaints and turns each warning into a teaching moment.
- Open your analysis platform to contributions with simple APIs so domain experts encode their knowledge as checks.
- Roll out risky or noisy analyzers as project-level opt-ins; graduate them to default-on after feedback-driven improvement builds trust.

## TL;DRs (the chapter's own summary)

- Focus on developer happiness. We have invested considerable effort in building feedback channels between analysis users and analysis writers in our tools, and aggressively tune analyses to reduce the number of false positives.
- Make static analysis part of the core developer workflow. The main integration point for static analysis at Google is through code review, where analysis tools provide fixes and involve reviewers. However, we also integrate analyses at additional points (via compiler checks, gating code commits, in IDEs, and when browsing code).
- Empower users to contribute. We can scale the work we do building and maintaining analysis tools and platforms by leveraging the expertise of domain experts. Developers are continuously adding new analyses and checks that make their lives easier and our codebase better.
