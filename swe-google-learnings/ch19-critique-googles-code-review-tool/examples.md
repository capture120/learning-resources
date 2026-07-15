# Chapter 19 Examples: Critique: Google's Code Review Tool

These are the concrete examples, case studies, and anecdotes the chapter uses. Context: Critique is Google's in-house web-based code review tool, and a "change" is a proposed edit to the codebase that must pass review before it is committed.

## The rejected "Code Central" tool

**Setup.** Critique's designers valued both simplicity and integration with other developer tools (code editing, code search, test results). Those two values pull in opposite directions.

**What happened.** Google considered building a single "Code Central" tool that would combine code editing, reviewing, and searching in one product. The team ultimately decided against it. Critique instead keeps code review as its one primary focus and links out to features implemented in separate subsystems (the Cider web editor, Code Search, and others).

**Lesson.** A review tool should stay focused on review. Integration should mean touchpoints and links, not absorption of every adjacent workflow. Simplicity wins the tension when adding a capability would dilute the tool's core purpose.

## The Chrome extension for turn notifications

**Setup.** Critique publishes event notifications as a change moves through review stages, and other tools consume those events rather than Critique implementing every feature itself.

**What happened.** Users can install a Chrome extension that listens to those events. When a change needs the user's attention, for example because it is their turn to review or a presubmit check failed, the extension pops a Chrome notification with a button to jump straight to the change or silence the alert. Some developers love the immediate notification; others refuse to use the extension because interruptions break their flow.

**Lesson.** An event-notification model lets a review tool stay focused while an ecosystem of optional tools grows around it. It also respects individual working styles: developers who want interrupts opt in, and developers who want focus opt out, without the core tool taking a position.

## The side-by-side diff design effort

**Setup.** Understanding the code change is the core of review, so Critique's team treated the quality of the diff view as a core requirement.

**What happened.** The team decided side-by-side diffs (old code on the left, new code on the right) were important for easier review, but side-by-side layout consumes a lot of horizontal space. To make it fit, they stripped the view to nothing but the diff and line numbers, with no borders and no padding, and experimented with fonts and sizes until Java's 100-character line limit fit on the typical 1,440-pixel screen width of the launch era.

**Lesson.** Good review tooling requires sweating pixel-level details. The team spent significant design effort so that the most information-dense view of a change would physically fit on real screens without horizontal scrolling.

## The linter finding with a two-click fix

**Setup.** Uploading a snapshot of a change triggers automatic static analyzers, whose results appear as colored status chips on the change page.

**What happened.** The chapter walks through a linter that finds a style violation: extra spaces at the end of a line. The change page shows a chip for that linter. From the chip, the author reaches the offending code in the diff within two clicks. Most linter findings include a fix suggestion; one click previews the fix (remove the extra spaces) and one more click applies the fix to the change.

**Lesson.** Machine-detectable problems should be resolvable in a couple of clicks, before any human reviewer spends time on them. Attaching one-click fixes to findings turns static analysis from nagging into acceleration.

## GwsQ: team-alias reviewer assignment

**Setup.** Even within a small team, picking a reviewer involves distributing load evenly and working around vacations. At Google's scale the problem is worse.

**What happened.** Teams provide an email alias for incoming code reviews. A tool named GwsQ (after the Google Web Server team, which first used the technique) watches those aliases. An author assigns a review to something like `some-team-list-alias`, and GwsQ picks a specific member of that alias to perform the review based on the team's configuration.

**Lesson.** Reviewer assignment is a load-balancing problem that tooling can solve. Letting authors target a team rather than a person removes the burden of knowing who is available and spreads review work fairly.

## Reviewer suggestion at monorepo scale

**Setup.** Google's codebase is enormous and modified by many people, so an author changing code outside their own project often has no idea who is qualified to review it. Finding reviewers becomes a genuine scaling problem.

**What happened.** Critique built a reviewer-selection utility that proposes sets of reviewers sufficient to approve the change. It weighs who owns the changed code, who is most familiar with it (recent modifiers), who is actually available (not out of office, preferably in the same time zone), and any GwsQ team-alias setup. The conclusion section notes this matters especially for large-scale changes such as API migrations touching many files, where the author cannot possibly map the ownership landscape by hand.

**Lesson.** Past a certain codebase size, "who should review this?" must be answered by the tool, not by the author's personal network.

## The attention set: "how did we get along without this?"

**Setup.** A change often has multiple reviewers, for example a software engineer plus the user-experience person responsible for the feature plus the SRE (site reliability engineer) carrying the pager for the service. With several people involved, it is easy for a change to stall because nobody knows whose turn it is.

**What happened.** Critique added the attention set: the set of people a change is currently blocked on, each expected to respond promptly. Critique updates the set automatically when comments are published, users can adjust it manually, and members are shown in bold. Before the feature, authors and reviewers coordinated through side-channel chat to figure out who was dealing with a change. After launch, users had a hard time even imagining the old state; the prevailing reaction was "how did we get along without this?"

**Lesson.** Code review is turn-based, and it is always at least one person's turn. Making that turn explicit in the tool is a small workflow optimization that removes a large amount of friction. This example is significant enough that the chapter promotes it into a TL;DR.

## Dashboard customization as the exception to anti-customizability

**Setup.** Critique generally shies away from UI customizability in the name of simplicity.

**What happened.** The dashboard (Critique's landing page) is the deliberate exception. Each user's dashboard is divided into customizable sections, each defined by a query to Changelist Search, a system that indexes the latest state of every change at Google and answers regular-expression queries interactively. The default first section shows changes needing the user's attention. The team found users like arranging their dashboards differently, the way everyone organizes email differently, without harming the core review experience. A footnote adds that centralized "global" reviewers for large-scale changes customize their dashboards heavily to avoid being flooded during a migration.

**Lesson.** Customizability is acceptable where it shapes a personal work queue and forbidden where it would complicate the shared review model. Draw the line at whether the customization affects only the individual or the process everyone shares.

## Removing "Needs More Work" and "LGTM++"

**Setup.** Early versions of Critique had a richer rating scheme for reviewers, including a negative "Needs More Work" rating and an emphatic "LGTM++."

**What happened.** The team consciously simplified the scheme so that LGTM (looks good to me) and Approval are always positive signals. A reviewer who thinks a change needs another round simply adds comments without granting LGTM or Approval. A side effect on culture: reviewers can no longer thumbs-down a change without useful feedback, because all negative feedback must be tied to something specific and fixable, namely an unresolved comment. Even the phrase "unresolved comment" was chosen to sound relatively nice. The tool also stopped requiring repeated LGTMs after a change reaches a mostly-good state, trusting authors to handle small final edits.

**Lesson.** The shape of a rating scheme shapes review culture. Removing free-floating negative ratings forces criticism to be specific and actionable, and keeping approvals sticky expresses trust in authors.

## LGTM with unresolved comments across time zones

**Setup.** In Critique's scoring model, LGTM and Approval are hard requirements only reviewers can grant, while unresolved comments are soft requirements the author can mark resolved as they reply.

**What happened.** A reviewer can grant LGTM while leaving unresolved comments, trusting the author to address them without the reviewer ever re-checking. The chapter highlights that this saves a full round-trip when author and reviewer sit in very different time zones: the author fixes the comments and commits without waiting another day for re-approval.

**Lesson.** Deliberately building trust into the mechanics (soft versus hard requirements) saves real calendar time, and exhibiting trust also builds trust and strengthens teams.

## Case study: Gerrit

**Setup.** Critique cannot be used outside Google because it is interdependent with the monolithic internal repository and other internal tools. Google teams working on open source projects (including Chrome and Android) or projects hosted outside the monorepo need something else.

**What happened.** Those teams use Gerrit, a standalone open source code review tool tightly integrated with the Git version control system. Gerrit provides a web UI over Git features (code browsing, branch merging, cherry-picking) plus review, and a fine-grained permission model for restricting access to repositories and branches. Like Critique, Gerrit reviews each commit separately; unlike Critique, it supports stacking commits for individual review and committing the chain atomically. Because it serves many environments, Gerrit has a rich plug-in system and a more sophisticated, highly configurable scoring system, including a -2 score that lets a reviewer veto a change outright.

**Lesson.** The Critique-versus-Gerrit contrast shows the trade-off between an opinionated single-environment tool and a general-purpose configurable one. Critique's simple always-positive scoring works because Google controls its whole environment; Gerrit's configurable scoring and veto exist because open source projects have diverse governance needs.

## Test coverage as the one embedded integration

**Setup.** Critique's rule for integrating with other tools (the Cider editor, Code Search, the Rapid release tool, the Zapfhahn coverage calculator) is to favor links over embedding, so the review experience stays uncluttered.

**What happened.** Test coverage is the stated exception. Whether a line of code is covered by a test appears directly inside the file's diff view as different background colors on the line gutter, rather than behind a link. (Not all projects use the coverage tool.)

**Lesson.** Even a strict "link, don't embed" policy admits exceptions when the information directly informs the judgment the reviewer is making line by line. The test of whether to embed is whether the data belongs in the moment of review itself.
