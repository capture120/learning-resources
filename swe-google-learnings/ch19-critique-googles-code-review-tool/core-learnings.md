# Chapter 19: Critique: Google's Code Review Tool

## Chapter Thesis

A well-defined code review process is only half of the code review story; the tooling that supports the process is the other half. This chapter examines Critique, Google's dominant in-house code review tool, to show what makes code review tooling successful. Critique's success comes from a small set of design values (simplicity, a foundation of trust, generic communication, and workflow integration), explicit support for each stage of the review flow, and small workflow innovations such as the "attention set" that make it always clear whose turn it is to act. The overarching lesson is that trust and communication are core to code review; a tool can enhance them but never replace them, and time saved in review is productivity gained for the whole company because review sits on the critical path to committing code.

## Core Principles and Ideas

### What Critique is

- Critique is Google's in-house, web-based code review tool. It is the most popular review tool at Google by a large margin.
- Critique supports the primary motivations of code review: it gives authors and reviewers a shared view of a change, lets anyone comment, and gatekeeps what code enters the codebase through a scoring mechanism.
- Reviews in Critique are "precommit reviews," meaning they happen before a change is committed to the codebase.
- Beyond review, Critique serves as a "code archaeology" tool: review comments and change history explain technical decisions long after commit, especially when inline code comments are lacking.
- Critique is not externally available because it depends tightly on Google's monolithic repository (called Piper) and other internal tools.

### The four guiding design principles

Critique was shaped by Google's development culture, where code review is a core part of the workflow. That culture produced four guiding principles:

1. **Simplicity.** The user interface makes review easy without unnecessary choices. It loads fast, supports keyboard-driven navigation, and shows clear visual markers for review state. Simplicity had the single biggest impact on the tool: many interesting features were rejected because they would complicate the model for the benefit of only a few users.
2. **Foundation of trust.** Code review exists to empower colleagues, not to slow them down. The tool trusts people as much as possible. For example, it trusts authors to address minor comments without requiring an extra re-review phase, and it makes all changes openly viewable and reviewable across Google.
3. **Generic communication.** Communication problems are rarely solved by tooling. Critique deliberately offers plain free-form comments instead of complicated structured protocols. Users spell out what they want in comments or suggest edits; the data model stays simple because the users are humans and communication can go wrong with any tool.
4. **Workflow integration.** Critique links to code search, a web-based editor, test results, release tooling, and static analysis, so review sits naturally inside the developer workflow.

Simplicity and workflow integration are in tension. Google considered building a single "Code Central" tool combining editing, reviewing, and searching, and decided against it. Critique keeps code review as its one primary focus; related features are linked from Critique but implemented in separate subsystems.

### The code review flow (six stages)

1. **Create a change.** The author writes a change in their workspace and uploads a snapshot (a patch at a point in time) to Critique. Uploading triggers automatic code analyzers.
2. **Request review.** Once satisfied with the diff and analyzer results, the author mails the change to one or more reviewers.
3. **Comment.** Reviewers draft comments on the diff. Comments default to "unresolved," meaning the author must address them; reviewers can instead mark comments "resolved" for optional or informational feedback. Drafted comments are published atomically as one batch, so a reviewer can deliver a complete thought after seeing the whole change. Anyone at Google can comment on any change ("drive-by review").
4. **Modify change and reply to comments.** The author uploads new snapshots and replies. The author must address every unresolved comment by changing the code or by replying and marking the comment resolved. Diffs between any pair of snapshots are viewable. Stages 3 and 4 repeat as needed.
5. **Change approval.** Happy reviewers mark the change "looks good to me" (LGTM). A ready-to-commit change shows a prominent green state in the UI.
6. **Commit a change.** With approval in place and presubmits (precommit hooks) passing, the author commits directly from a button in Critique, avoiding a context switch to the command line.

The flow is flexible: reviewers can un-assign themselves or reassign the review, authors can postpone review, and in emergencies an author can force-commit and get the review after commit.

### Notifications as separation of concerns

Critique publishes event notifications as a change moves through the stages. Other tools consume those events, so Critique stays a focused review tool rather than a general-purpose hub. Examples include a Chrome extension that pops a notification when it is the user's turn, and email integration that sends important events and translates email replies back into comments. Many users ignore email entirely and manage reviews from the dashboard.

### Diffing as the core of review

Understanding the change is the heart of review, and larger changes are harder to understand, so optimizing the diff is a core requirement of a good review tool. Critique layers on top of a longest-common-subsequence diff algorithm:

- Syntax highlighting.
- Cross-references (powered by Kythe, Google's code-indexing system).
- Intraline diffing that shows character-level differences respecting word boundaries.
- Configurable whitespace ignoring.
- Move detection, so moved code shows as "moved" rather than removed-and-added.
- Custom artifact diffs, such as screenshot diffs of a UI change or diffs of generated configuration files.
- Side-by-side diff mode, made possible by stripping the view to bare essentials (no borders or padding) so long lines fit on real screens.
- Fast loading and prefetching even for large files, plus keyboard shortcuts to jump between modified sections.
- A snapshot-chain widget for each file that lets users drag-and-drop to compare any two versions, auto-collapsing similar snapshots to highlight important ones (which snapshots have test coverage, were reviewed, or have comments).

### Analysis results and binary actionability

Uploading a snapshot triggers analyzers (the static-analysis platform is called Tricorder). Results appear as status chips under the change description: red highlights for important findings, yellow for analyzers still running, gray otherwise. For simplicity, actionability is deliberately binary; there are no other severity gradations. Findings display inside the diff, styled differently from human comments, and often carry fix suggestions the author can preview and apply with one click. Reviewers can click a "Please fix" button on a finding to turn it into an unresolved comment.

### Reviewer selection at scale

In a large codebase, finding the right reviewer is a real problem. Critique proposes sets of reviewers sufficient to approve the change, weighing:

- Who owns the code being changed.
- Who is most familiar with the code (who changed it recently).
- Who is available (not out of office, preferably in the same time zone).
- Team alias configuration via GwsQ, a tool that takes a team email alias and assigns a specific team member as reviewer, distributing load and handling vacations.

### Presubmits

Requesting review triggers "presubmits" (precommit hooks) configured per project. Common presubmits: adding email lists to changes for transparency, running the project's automated test suite, and enforcing project invariants on code style and change descriptions. Because tests are resource intensive, they run at review request and at commit rather than on every snapshot. Failed presubmits block sending for review or committing, and Critique emails the author.

### The attention set ("whose turn" feature)

The attention set is the set of people a change is currently blocked on; whoever is in it is expected to respond promptly. Critique updates the set automatically when comments are published, and users can adjust it manually. The set is surfaced by bolding the relevant usernames. The feature encodes the turn-based nature of code review: it is always at least one person's turn to act. Before the feature existed, authors and reviewers coordinated by chat; after launch, users could not imagine working without it.

### Dashboard and Changelist Search

Critique's landing page is a per-user dashboard of customizable sections, each defined by a query to Changelist Search, a search system that indexes the latest state of every change (pre- and post-submit) across all of Google and answers regular-expression queries fast enough for interactive use. The default first section shows changes needing the user's attention. Google resisted customizability elsewhere in the UI but allowed it here, because people organize their work queues differently (like email) without harming the core experience.

### Scoring a change: LGTM, Approval, unresolved comments

Scoring at Google divides into three parts:

- **LGTM ("looks good to me")** means "I have reviewed this change, believe it meets our standards, and think it is okay to commit after addressing unresolved comments."
- **Approval** means "as a gatekeeper, I allow this change to be committed to the codebase."
- **Unresolved comment count**: comments the author must act on.

A change can commit when it has at least one LGTM, sufficient approvals, and zero unresolved comments. Every change requires an LGTM regardless of approval status, guaranteeing at least two pairs of eyes on every change. The tool shows readiness as a green page header, plus a scoring panel listing who has LGTM'ed, which approvals are still required and why, and how many unresolved comments remain.

Key design decisions in the scoring model:

- Google deliberately simplified the scheme. Early Critique had "Needs More Work" and "LGTM++" ratings; both were removed so LGTM/Approval are always positive.
- Negative feedback must be specific: a reviewer cannot thumbs-down a change without attaching actionable unresolved comments. Even the phrase "unresolved comment" was chosen to sound relatively nice.
- LGTM and Approval are hard requirements grantable only by reviewers (and revocable until commit). Unresolved comments are soft requirements the author can mark resolved when replying. This asymmetry deliberately relies on trust: a reviewer can LGTM with unresolved comments and trust the author to address them without re-checking. That trust saves time across time zones and strengthens teams, because exhibiting trust builds trust.
- Once a change is mostly good, the tool does not demand repeated LGTMs for small follow-up edits.

### After commit: change archaeology

Anyone at Google can browse the history and review comments of committed changes to generally viewable files. This enables auditing, understanding why changes were made or how bugs were introduced, learning how changes were engineered, and producing trainings from aggregate review data. Critique supports post-commit comments (for problems discovered later or added context), rollbacks, and visibility into whether a change was already rolled back.

### Gerrit as the contrast case

Gerrit is a standalone, open source code review tool tightly integrated with Git. Google teams working on open source projects (Chrome, Android) or projects outside the monolithic repository use Gerrit. Both tools review each commit separately; Gerrit additionally supports stacking commits for individual review and committing the chain atomically. Because Gerrit serves many environments, it offers a rich plug-in system, a fine-grained permission model, and a more sophisticated, configurable scoring system including a -2 veto score. The contrast illustrates the trade-off: Critique buys simplicity by serving one opinionated environment; Gerrit buys flexibility at the cost of a more complex model.

## Actionable Guidance (transferable tool-design lessons)

- Keep the review tool focused on review. Link out to editors, code search, and release tools rather than embedding everything; reject a "do-everything" tool.
- Make simplicity the default tiebreaker. Reject features that complicate the model for a small set of users.
- Design the tool to trust people. Do not add verification phases for minor comment follow-through; trust authors and make everything openly visible instead.
- Keep communication generic. Prefer free-form comments and suggested edits over structured protocols; tooling cannot fix human communication problems.
- Invest heavily in the diff: side-by-side view, intraline character-level diffing, move detection, whitespace controls, syntax highlighting, cross-references, artifact diffs, fast loading, and keyboard navigation.
- Run automated analysis before human review so machines catch mechanical issues first; surface quick analysis results before slow ones finish.
- Make analyzer findings binary (actionable or not) and attach one-click fix suggestions where possible.
- Let authors see their change exactly as reviewers will before sending it, including analyzer results and preliminary self-comments; this prevents misunderstanding and reduces reviewer time.
- Batch-publish draft comments atomically so reviewers deliver complete, considered feedback.
- Track "whose turn it is" explicitly (an attention set) so a change is never silently stalled; small workflow features like this remove large amounts of friction.
- Make negative review outcomes specific and actionable; forbid content-free rejection. Require every "no" to be tied to a concrete unresolved comment.
- Keep the commit gate simple and legible: one LGTM minimum, required approvals, zero unresolved comments, with a clear visual "ready" state and a panel explaining exactly what is still missing.
- Require at least two pairs of eyes on every change, but keep the usual reviewer count to two people total (author plus one reviewer) to keep velocity high.
- Use event notifications as an integration boundary so other tools build on review events without bloating the review tool.
- Allow customization only where it does not harm the core experience (dashboards yes, review model no).
- Distribute review load with team aliases and automated reviewer suggestion based on ownership, familiarity, and availability.
- Preserve review history as documentation; support post-commit comments and rollback tracking for future auditing and learning.
- Allow escape hatches for the real world: reviewer reassignment, postponed reviews, and emergency force-commit with post-commit review.

## The Chapter's TL;DRs (verbatim from the book)

- Trust and communication are core to the code review process. A tool can enhance the experience, but it can't replace them.
- Tight integration with other tools is key to great code review experience.
- Small workflow optimizations, like the addition of an explicit "attention set," can increase clarity and reduce friction substantially.
