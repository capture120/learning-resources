# Chapter 10: Documentation

*Software Engineering at Google* — written by Tom Manshreck, edited by Riona MacNamara.

## Chapter Thesis

Poor documentation is one of the most common complaints in software engineering, and engineers themselves will always write most documentation, so the fix is not to turn engineers into technical writers but to make writing documentation easier and to fold it into the normal engineering workflow. Google's most successful approach treats **documentation like code**: documents get owners, live in source control alongside the code they describe, are reviewed for changes, have bugs filed against them, and are periodically evaluated for freshness. Documentation's benefits are all downstream — the author pays the cost up front while readers reap the value for years — which is exactly why organizations must build processes and incentives that scale, rather than rely on individual heroics. The chapter compares the state of documentation in the late 2010s to the state of software testing in the late 1980s: everyone knows it matters, but organizational recognition of its benefits is still catching up.

## Core Principles and Ideas

### What qualifies as documentation

"Documentation" means every supplemental text an engineer writes to do their job — not just standalone documents but code comments too. At Google, most of the documentation an engineer writes is code comments.

### Why documentation is needed (and why it is usually poor)

Quality documentation makes code and APIs more comprehensible, keeps project teams focused on stated goals, makes manual processes followable, and dramatically cuts the cost of onboarding new team members. It answers "why were these design decisions made?" and "why did we implement this code this way?" — including for your own code two years later.

The economics: you write a document roughly once, but it is read hundreds or thousands of times, so the initial cost is amortized across all future readers. Like testing, the investment pays for itself over time — but unlike testing, the benefits are not immediate to the author, which is the root cause of underinvestment.

Reasons engineers produce poor documentation:
- Benefits are downstream, not immediate to the writer.
- Engineers view writing as a separate skill from programming (the chapter argues it is not — documentation is a tool written in a different language, usually English, and has rules, syntax, and style just like code).
- Some engineers do not feel they are capable writers. You do not need strong command of English; you need to see things from the audience's perspective. "If you can read, you can write."
- Tool support and workflow integration are weak.
- Documentation is seen as an extra burden to maintain rather than something that makes maintaining existing code easier.

### Benefits to the writer (not just the reader)

- **It helps formulate an API.** Writing documentation is one of the surest tests of whether your API makes sense. If you can't explain it and can't define it, you probably haven't designed it well enough.
- **It provides a road map for maintenance and a historical record.**
- **It makes code look more professional and drives traffic.** Well-documented APIs are perceived as better-designed, and documentation quality is a good indicator of how well a product will be maintained.
- **It prompts fewer questions from other users** — probably the biggest benefit over time. If you have to explain something more than once, document it.

Still, the lion's share of benefits accrue to the reader. Google's C++ Style Guide maxim applies: **"optimize for the reader"** — for code, for comments, and for documentation sets.

### Documentation is like code (documentation as code)

Documentation is a tool written in a different language (usually English) to accomplish a particular task. Like a programming language it has rules, syntax, and style decisions that enforce consistency, improve clarity, and avoid comprehension errors. Grammar matters not for its own sake but to standardize voice and avoid distracting the reader.

Because documentation is tightly coupled to code, it should as much as possible be treated as code. Documentation should:

- Have internal policies or rules to be followed
- Be placed under source control
- Have clear ownership responsible for maintaining the docs
- Undergo reviews for changes (and change with the code it documents)
- Have issues tracked, as bugs are tracked in code
- Be periodically evaluated (tested, in some respect)
- If possible, be measured for aspects such as accuracy and freshness (tooling has still not caught up here)

**Ownership and canonical documents.** Documents without owners become stale and unmaintainable. When documents with different owners conflict, designate one canonical document: pick the primary source and consolidate or deprecate the duplicates. Memorable internal short links ("go/ links" at Google — e.g., go/cpp) help establish a document as the canonical source of truth on a topic. Placing documentation under source control next to the code it documents also promotes canonical status and establishes de facto ownership. (Google's g3doc framework embeds Markdown documentation directly in the codebase so engineers can update code and docs in the same change.)

### Know your audience

The most important mistake engineers make is writing only for themselves. Writing for yourself has some value, but a widely read document written on self-serving assumptions loses readers, and as an organization grows those losses compound. Before writing, identify the audience(s) the document must satisfy, pick a **primary audience**, and write to that audience.

Good documentation need not be polished or perfect. Your audience is standing where you once stood but without your new domain knowledge — you just need to get someone like your past self as familiar with the domain as you now are. Get a stake in the ground; you can improve the document over time.

**Audience dimensions:**
- **Experience level** — expert programmers versus junior engineers who may not even know the language.
- **Domain knowledge** — team members versus engineers who only know the API endpoints.
- **Purpose** — end users who need to accomplish a task quickly versus maintainers responsible for gnarly internals.

Writing for the expert lets you cut corners but confuses the novice; explaining everything to the novice annoys the expert. The best tool for serving both is keeping documents **short**: write the long version to get everything down, then edit out duplication. (Blaise Pascal: "If I had more time, I would have written you a shorter letter.")

**Seekers versus stumblers** — a distinction based on how a user encounters a document:
- **Seekers** know what they want and are checking whether what they found fits. The key device for seekers is **consistency** — e.g., reference comments in a uniform format so readers can scan quickly.
- **Stumblers** have only a vague idea of what they need. The key device for stumblers is **clarity** — overviews and introductions that explain the purpose of the code, plus explicit signals when a document is *not* for them (many Google docs open with a line like "TL;DR: if you are not interested in C++ compilers at Google, you can stop reading now").

**Customers versus providers.** Keep documents for API users (customers) separate from documents for the project team (providers). Implementation details matter to maintainers; end users should not have to read them. Design reasoning belongs in design documents or hidden implementation comments, not in a published API reference.

### Documentation types

A document should have a singular purpose and stick to it — just as an API should do one thing well. Do not mix types. The main types engineers write:

1. **Reference documentation** (including code comments) — anything that documents the usage of code in the codebase. The most common type; engineers write some form of it nearly every day. Code comments split into **API comments** (cannot assume the reader knows the API as well as the author; must not leak implementation details or design decisions) and **implementation comments** (can assume more domain knowledge, but be methodical about *why* code was written a certain way — people leave projects). Reference documentation should be **single-sourced**: generated from comments in the codebase itself (Javadoc, PyDoc, GoDoc; header files for C++). Google keeps reference docs alongside code definitions because its Code Search browser makes them discoverable there.
2. **Design documents** — most Google teams require an approved design doc before major work begins, written from a team-approved template and often collaboratively (e.g., in Google Docs). Design discussions act as a form of code review before any code is written. Templates force consideration of security, internationalization, storage, and privacy, with those sections reviewed by domain experts. A good design doc covers the goals, the implementation strategy, and key design decisions with emphasis on trade-offs; the best also cover alternative designs with their strong and weak points. After approval, the design doc serves as a historical record and a yardstick — review it before launch to check whether the stated goals still hold.
3. **Tutorials** — get a newcomer up to speed fast. Most projects deserve a "Hello World" document that assumes nothing and gets the engineer to make something real happen. The best time to write (or debug) a tutorial is when you first join a team, while you still lack the domain knowledge the tutorial must not assume. Number every user step explicitly; number only actions the *user* takes, not system responses; state prerequisites up front; put user-visible input and output on separate lines in monospaced font.
4. **Conceptual documentation** — overviews for code that needs deeper explanation than a reference can provide (library overviews, life-of-a-data-record documents). Conceptual docs augment, never replace, reference docs. They deliberately duplicate some information for clarity and may sacrifice completeness and even strict accuracy — they should focus on common usage and leave edge cases to the reference, whose job is to cover them religiously. The main point of a conceptual document is to impart understanding. They must serve experts and novices alike, are the hardest type to write, and are therefore the most neglected. Memorable framing: **if comments are the unit tests of documentation, conceptual documents are the integration tests.**
5. **Landing pages** — a team or product home page should do nothing but act as a **traffic cop**: state its purpose clearly and contain only links to other pages. If a landing page is doing more than directing traffic, it is not doing its job. Keep it to one screen; break up an overgrown page by taxonomy into sections. Do not let one page serve both API customers and the team — create a separate internal team page.

### Documentation reviews

Documentation, like code, needs review. A technical document benefits from three different types of review, each emphasizing a different aspect:

- **Technical review, for accuracy** — done by a subject matter expert, often a teammate, often as part of code review.
- **Audience review, for clarity** — done by someone unfamiliar with the domain, such as a new team member or an API customer.
- **Writing review, for consistency** — done by a technical writer or volunteer.

High-profile or externally published documents deserve all three; even one reviewer is far better than none. When documentation is tied into the engineering workflow, it improves over time on its own — readers become an implicit audience review by filing bugs when documents do not work.

### Documentation philosophy (technical writing best practices)

**WHO, WHAT, WHEN, WHERE, and WHY.** Most technical documentation answers HOW, and engineers tend to jump straight to it. Frame the document by answering the other questions in the first two paragraphs:
- **WHO** — the audience; sometimes call it out explicitly ("This document is for new engineers on the Secret Wizard project").
- **WHAT** — the purpose ("This document is a tutorial designed to start a Frobber server in a test environment"). Writing the WHAT helps you frame the document; content that does not fit the WHAT belongs in a separate document.
- **WHEN** — creation/review/update date. Source control notes this implicitly; otherwise date the document.
- **WHERE** — where the document lives; prefer version control, ideally next to the code. Collaborative tools (Google Docs) suit active discussion, but once a document becomes a stable historical record, move it somewhere permanent with clear ownership and version control.
- **WHY** — what you expect the reader to take away. Establish the WHY in the introduction; verify it in the summary and revise accordingly.

**Beginning, middle, and end.** Almost every document should have at least these three sections, because very few documents have only one thing to say. Sections break the flow into logical pieces and give readers a roadmap. Redundancy — normally loathed by engineers — is useful in documentation: introduce and summarize the key point in the introduction, then make the detailed case in the body, so the reader grasps both the importance and the context.

**The parameters of good documentation: completeness, accuracy, clarity.** You rarely get all three in one document; they trade off. Documenting every use case wrecks clarity; chasing clarity on a complicated topic can cost accuracy. A "good document" is one that does its intended job — so decide each document's focus and tune the trade-off to its type: a reference should be complete even at some cost to clarity; a conceptual doc should be clear even at some cost to completeness and strict accuracy; a landing page should focus on organization with minimal discussion. To quickly improve quality, focus on the audience's needs — often **less is more**. A classic mistake is putting design decisions or implementation details in an API document; users don't need them, so put them in a design doc instead (mirroring interface/implementation separation in API design).

**Deprecating documents.** Old documents cause problems just like old code. When a document no longer serves a purpose, remove it or mark it obsolete and point to the replacement. Even for unowned documents, a note saying "This no longer works!" beats silence from something that looks authoritative but is broken. Google attaches **freshness dates** — metadata recording the owner and last-review date — and the documentation system emails reminders when a document has not been touched for, say, three months. Adding a visible "Last reviewed by..." byline increased adoption, because named owners have an incentive to keep the date current.

### When do you need technical writers?

Most engineering teams can document things for *their own team* perfectly well: the feedback loop is immediate, the shared domain knowledge is clear, and the needs are obvious. Teams need help when writing for *another audience*, because writing to an unfamiliar audience is hard. Assigning technical writers to "important" projects regardless of need turned out to be a bad idea — it doesn't scale, and it creates the perverse incentive that becoming important means your engineers stop writing docs, which is the opposite of what you want. Technical writers, as a scarce specialized resource, should focus on documentation that **crosses API boundaries** — where a writer's unfamiliarity with the domain is an asset, and where one of their critical roles is to challenge the team's assumptions about the project's utility.

### Conclusion perspective

Documentation at Google is still not a first-class citizen the way testing is: tests are atomic, automatable, and follow prescribed form; documents mostly cannot be, and their quality is judged by the reader, not the writer, asynchronously. Engineers and their organizations must accept that they are both the problem and the solution: producing quality documentation is part of the job, and for any code expected to live more than a few months, documenting it helps the author maintain it as much as it helps everyone else.

## Actionable Guidance

- Treat docs as code: put them under source control next to the code, give them named owners, review changes, and track doc bugs in the bug tracker.
- Update documentation in the same change as the code it documents.
- Designate one canonical document per topic; consolidate or deprecate competitors. Use memorable short links to reinforce canonical status.
- Before writing, name the primary audience and write to it; state WHO/WHAT/WHY in the first two paragraphs.
- Serve seekers with consistent formats they can scan; serve stumblers with clear overviews and explicit "this doc is/isn't for you" statements.
- Keep API-user documentation separate from team/implementation documentation.
- Give every document one purpose; when content stops fitting, split it into another document.
- Write the long draft first, then edit it short; a short clear document serves experts and novices at once.
- Start file comments with what the file contains and who it's for; if the API can't be summarized in a paragraph or two, the API probably needs to be split.
- "Noun" class comments (describe the object); start function comments with an indicative verb (Merges, Deletes, Creates) so seekers can scan by verb alone; prefer a single prose comment over Returns:/Throws: boilerplate sections.
- Write the project tutorial when you join the team; number only user actions; state prerequisites; show commands and output in monospace on their own lines.
- Get three reviews when a document matters — technical (accuracy), audience (clarity), writing (consistency) — and at least one reviewer always.
- Attach freshness metadata (owner + last-reviewed date) with automated staleness reminders; add a visible "Last reviewed by" byline.
- Delete or clearly mark obsolete documents, pointing readers to the replacement.
- Deploy technical writers on cross-API-boundary documentation, not as scribes for single teams.

## TL;DRs (the chapter's own summary, verbatim)

- Documentation is hugely important over time and scale.
- Documentation changes should leverage the existing developer workflow.
- Keep documents focused on one purpose.
- Write for your audience, not yourself.
