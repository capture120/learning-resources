# Chapter 8: Style Guides and Rules

*Software Engineering at Google* — written by Shaindel Schwartz, edited by Tom Manshreck.

## Chapter Thesis

Rules are mandatory laws that govern how code is written in an organization, and a style guide is the canonical collection of those rules. The purpose of rules is not aesthetic preference; it is to manage the complexity of a large, long-lived codebase so that both the code and the engineering organization stay sustainable as they scale and age. Because rules restrict choice, every rule must be justified by the goal it advances. Google derives its rules from a small set of principles (rules must pull their weight, optimize for the reader, be consistent, avoid error-prone constructs, and concede to practicalities), documents the reasoning behind each decision so rules can be reevaluated when conditions change, and enforces rules automatically with tooling wherever possible.

## Core Principles and Ideas

### Rules versus guidance

- **Rules** are laws. They are strict and mandatory, universally enforceable, and may be disregarded only with an approved exception (a waiver). Rules are the "musts."
- **Guidance** consists of recommendations and best practices. Guidance is advisable to follow but allows room for variance. Guidance is the "shoulds."
- A **style guide** is the canonical collection of an organization's rules. "Style" is a misnomer; the guide covers the full set of conventions that govern code, not just formatting. Style guide rules may still call for judgment (for example, "use names as descriptive as possible, within reason"), but the guide is the definitive source engineers are held accountable to.
- Google maintains a **separate style guide per programming language** because languages differ in strengths, features, and adoption history. Guides vary widely in length and strictness. Some guides mostly defer to external community conventions (Go). Others deliberately diverge from external norms (the C++ guide bans exceptions, a feature widely used outside Google).

### Why have rules at all

- Rules exist to encourage "good" behavior and discourage "bad" behavior. Good and bad are not universal; each organization defines them based on what it values (memory footprint, runtime performance, consistency, and so on). Identify what the organization values first, then write rules that push behavior in that direction.
- Rules shape a **common vocabulary of coding**. With a shared vocabulary, engineers focus on what their code needs to say rather than how to say it, and they do the "good" thing by default, even subconsciously.
- The key question when creating rules is not "What rules should we have?" but "**What goal are we trying to advance?**" Google asks "Why does something go into the style guide?" rather than "What goes into the style guide?"
- Google's context makes the stakes concrete: more than 30,000 engineers of widely varying skill making about 60,000 daily submissions to a codebase of over two billion lines that will live for decades. The goal is an engineering environment **resilient to both scale and time**. Rules trade away some flexibility and individual choice in exchange for consistency and reduced conflict.

### The five guiding principles for rules

1. **Rules must pull their weight.** Every rule imposes a cost: engineers must learn it, remember it, and the rule set must be maintained. Too many rules make the guide harder to learn and follow. Do not write rules for self-evident things. The guide is not to be read in a lawyerly way; something not explicitly outlawed is not automatically legal. If only one or two engineers get something wrong, adding a rule that burdens everyone does not scale. (Note: "too many" is measured by how much engineers must *remember*, not the raw rule count. Once a formatter enforces formatting rules automatically, adding more formatting rules costs engineers nothing.)
2. **Optimize for the reader.** Code is read far more often than it is written. Prefer code that is tedious to type over code that is difficult to read; value "simple to read" over "simple to write." A related requirement: engineers must leave **explicit evidence of intended behavior** in code (for example, mandatory `override` annotations, or `std::unique_ptr` with explicit `std::move` to show ownership transfer). The aim is **local reasoning**: a reader should understand what happens at a call site without hunting through other code or implementations. Comment rules serve the same goal, both **documentation comments** (block comments on a file, class, or function describing design or intent) and **implementation comments** (inline comments justifying non-obvious choices and explaining tricky parts).
3. **Be consistent.** Consistency lets any engineer jump into an unfamiliar part of the codebase and get to work quickly, like a Googler's badge working at any office. Benefits: it enables **expert chunking** (experts recognize patterns as meaningful units and read code faster); it enables **tooling at scale** (uniform code lets one tool work everywhere instead of each team building bespoke variants); it scales the **human organization** (lower ramp-up when switching teams, easier for cross-project roles like SREs); and it gives **resilience to time** (people leave, projects merge and split, and consistent code makes transitions cheap). For many small decisions (indentation width, line length, import order) the value is in *having one answer*, not in which answer was chosen. Consistency follows a **hierarchy**: file conventions precede team conventions, which precede project conventions, which precede the overall codebase. When external community standards exist and the code is long-lived or may interact with the outside world, being consistent with the outside world usually pays off. Perfect consistency is not the goal at very large scale; Google's C++ arbiters explicitly gave up on ever making the whole codebase conform when the cost exceeded the value.
4. **Avoid error-prone and surprising constructs.** Complex or clever language features have subtle pitfalls, and future maintainers are not guaranteed to share the original author's expertise. Google's Python guide restricts reflection (`hasattr()`/`getattr()`) because dynamic attribute access hides evidence from readers, resists search and testing, and can even create security flaws. All engineers, not just experts, must be able to operate in the codebase, including an SRE debugging an outage in an unfamiliar language.
5. **Concede to practicalities when necessary.** "A foolish consistency is the hobgoblin of little minds" (Emerson). Performance can justify exceptions (C++ bans exceptions but allows `noexcept` for compiler optimizations). Interoperability can justify exceptions (snake_case for standard-library-mimicking C++ types; multiple inheritance allowed for Windows compatibility; generated code exempt from Java and JavaScript guides). Consistency is vital; adaptation is key.

### What goes into a style guide: three categories of rules

1. **Rules to avoid dangers.** Technical musts and must-nots: static members, lambdas, exceptions, threading, inheritance, which vocabulary types to use. Each ruling should document the pros and cons weighed and the reasoning.
2. **Rules to enforce best practices.** Where and how to comment (including mandatory comments for non-obvious intent such as switch fall-through and empty catch blocks), source file structure, naming, formatting and whitespace (often delegated to autoformatters). Also **preemptive restrictions on new, not-yet-understood language features**: restrict first, watch waiver requests to learn real usage patterns, then loosen the rule once good practice can be generalized (this is how `std::unique_ptr` went from banned to endorsed).
3. **Rules to ensure consistency.** Low-stakes decisions (naming conventions, indentation, import order) made primarily *to have a decision* and end bikeshedding. What was chosen matters less than that something was chosen.

Deliberately left out: self-evident universal advice ("don't be clever," "don't reinvent the wheel"). A style guide is not a complete software engineering curriculum.

### Changing the rules

- Style guides are not static. Triggers for reevaluation: a new language version; engineers investing effort to circumvent a rule; enforcement tooling becoming overly complex to maintain.
- Every rule should be **backed by documented evidence and reasoning** (pros, cons, consequences). Documented reasoning is what makes it possible to recognize when changed conditions invalidate a past decision.
- The change process is **solution based**: a proposal must identify an existing, *demonstrated* problem (patterns found in real code, not hypotheticals) and present the change as the fix.
- Most changes start with **community discussion** on language-specific mailing lists. Any engineer can propose a change. The community filters proposals; surviving proposals go to final approval.
- **Style arbiters** make final decisions: a group of long-time language experts who own each language's style guide. Decisions are trade-off judgments made within the guide's agreed-upon goals, never personal preference. Because decisions are made by consensus over trade-offs rather than by vote, an even-numbered arbiter group (C++ has four) works fine.
- **Exceptions (waivers)**: rules are designed for the general case, and arbiters can grant waivers where breaking the rule is more beneficial than following it. Waivers are not granted lightly, and preference-based requests are rejected; codebase integrity outweighs project-local consistency. A steady stream of valid waiver requests can signal that a rule needs amending, but a steady stream of *invalid* requests that superficially resemble the valid case can justify keeping a strict rule as-is.

### Guidance (the "shoulds")

Guidance is the collected wisdom of engineering experience, focused on what people frequently get wrong or what is new and confusing. Google's forms of guidance:

- **Primers**: descriptive (not prescriptive) references per language explaining how to use the features the style guide endorses; broad coverage for engineers new to the language at Google.
- **C++ Tips of the Week**: short, narrowly focused advice pieces grown out of real observed problems, covering hard topics (object lifetime, move semantics), new features, and gentle corrections. Not canon, but so grounded in real patterns that they act as a "canon of the common," frequently cited in code reviews.
- **"Language@Google 101" courses**: full-day courses per major language covering what makes development *in this codebase* different: frequently used libraries, idioms, in-house preferences, custom tools.
- **Ready references**: advice for hard-to-get-right areas (concurrency, hashing), breakdowns of new language features, and listings of key library abstractions (answering "I need a thing but don't know what it's called in our libraries").

### Applying and enforcing the rules

- Rules gain value when enforceable. Enforcement is **social** (training, documentation, mentored code review such as Google's readability process) or **technical** (tooling). Prefer **automated enforcement** whenever feasible.
- Why automate: rules survive time and organizational growth (new hires, changing rules, growing projects) without depending on memory or documentation; a tool applies **one unchanging definition of the rule**, removing variance from human bias and inconsistent interpretation; and enforcement **scales** — one expert team writes tools for the whole company, so doubling headcount does not double enforcement cost.
- Limits of automation: some rules **explicitly require human judgment** ("avoid complicated template metaprogramming," "composition is often more appropriate than inheritance"). Other rules are **social rather than technical**, and solving social problems with technical solutions is often unwise. Example: "prefer small code changes" — "small" is nebulous (a one-line change across hundreds of files can be easy to review; a 20-line change can be hard), so Google has no tool that auto-rejects changes over a line limit; reviewers push back at their discretion.
- **Error checkers** (static analysis: clang-tidy for C++, Error Prone for Java) verify code against rules and surface warnings, often with suggested fixes, inside the code review workflow. An informal 2018 survey estimated roughly 90% of the C++ style guide's rules could be automatically verified. Keeping the cost of compliance low makes engineers happy to comply; source-tagged deprecation warnings with suggested fixes made new uses of deprecated APIs disappear "almost overnight."
- **Code formatters** (clang-format for C++, a yapf wrapper for Python, gofmt for Go, dartfmt for Dart, buildifier for BUILD files) end formatting debates entirely. Automated formatters beat humans on average; humans win only in niche cases like formatting a matrix. Google enforces formatters with **presubmit checks**: if running the formatter would produce a diff, the submission is rejected with instructions to run the formatter.

## Actionable Guidance

- Before writing any rule, state the goal the rule advances and what the organization values.
- Do not add a rule unless its benefit exceeds the cost of everyone learning and remembering it; skip self-evident rules.
- When two options trade author convenience against reader clarity, pick reader clarity.
- Require in-code evidence of intent (override markers, explicit ownership transfer, mandated comments for non-obvious constructs) so readers can reason locally.
- For low-stakes choices (indent width, import order), pick one answer, document it, and stop the debate; the choice matters less than its existence.
- Follow the consistency hierarchy: match the file first, then the team, then the project, then the codebase; for long-lived code, prefer matching external community conventions.
- Restrict new language features initially; use waiver requests as data to learn real usage, then relax the rule once good practice is clear.
- Write down the pros, cons, and reasoning with every rule so future maintainers can tell when the rule is stale.
- Require rule-change proposals to cite demonstrated problems in real code, not hypotheticals.
- Appoint experienced style arbiters who decide by trade-off consensus against agreed goals, never personal taste.
- Automate enforcement with static analysis and formatters; enforce formatters via presubmit checks; reserve human enforcement for judgment-based and social rules.
- Adopt a standard formatter from day one of a new language or file format; retrofitting is far harder.
- Supplement rules with guidance: primers, short tips grown from real problems, onboarding courses, and library reference lists.

## Chapter TL;DRs (verbatim)

- Rules and guidance should aim to support resilience to time and scaling.
- Know the data so that rules can be adjusted.
- Not everything should be a rule.
- Consistency is key.
- Automate enforcement when possible.
