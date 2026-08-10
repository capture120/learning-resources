# Chapter 9: Code Review

*Software Engineering at Google* — written by Tom Manshreck and Caitlin Sadowski.

## Chapter Thesis

Code review is the process of having someone other than the author review code, at Google always before the code is committed to the codebase (a "precommit review"). Although catching bugs is the obvious and well-established benefit, the chapter argues that the more important benefits at scale are subtler: code review ensures code is comprehensible to others, enforces consistency across a shared codebase, psychologically reinforces collective ownership, spreads knowledge across the organization, and creates a historical record. Because review is one of the few blanket mandates at an otherwise process-light company, it must be kept lightweight to be sustainable — hence Google's emphasis on small changes, a single reviewer, fast turnaround, and heavy automation.

## Core Principles and Ideas

### The code review flow at Google

1. The author writes a change in their workspace and uploads a snapshot (a patch plus description) to the code review tool, producing a diff against the codebase.
2. The author can apply automated review comments or self-review, then "mails" the change to one or more reviewers.
3. Reviewers comment on the diff. Some comments require explicit resolution; some are merely informational.
4. The author revises, uploads new snapshots, and replies. Steps 3–4 repeat as needed.
5. When satisfied, a reviewer marks the change **LGTM** ("looks good to me"). Only one LGTM is required by default.
6. The author may commit once all comments are resolved and the change is approved.

Google's custom review tool is called **Critique** (Gerrit is used for open source Git projects), but the process predates the tool and adapts to any tooling.

### The three approval "bits"

Every change at Google needs three kinds of approval, which act as combinable permission bits:

1. **LGTM** — a correctness and comprehension check from any other engineer that the code is appropriate and does what the author claims. When an engineer marks LGTM they are saying the code does what it says *and* is understandable.
2. **Owner approval** — approval from a **code owner** of the directory being changed, confirming the change is appropriate for that part of the codebase. Owners are gatekeepers for their directories; ownership is hierarchical through the directory tree.
3. **Readability approval** — approval from someone holding **language readability**, a company-wide certification (per programming language) that the holder knows that language's style and best practices. At Google, "readability" means not just comprehension but the set of styles and best practices that keep code maintainable by other engineers.

Key scaling insight: one person can hold all three roles, and the author can hold the latter two themselves. A tech lead who owns the code and has readability needs only a peer LGTM. An intern can land the same change by additionally getting owner + readability approval. This flexibility is why the process scales: separating the roles lets each reviewer focus on a different question. A peer reviewer asks "is this correct and comprehensible?" An owner/approver asks "will this be easy to maintain? Does it add to my technical debt? Do we have the expertise to maintain it?"

### Ownership (sidebar by Hyrum Wright)

- **Ownership** is stewardship, not possession — the responsibility to act in the company's best interest for a section of the codebase. ("Stewards" would have been a better word.)
- **OWNERS files** list the usernames responsible for a directory and its children. Files are hierarchically additive: a file is owned by the union of all OWNERS files above it in the tree. Keep lists small and focused so responsibility stays clear.
- Ownership conveys approval rights but also responsibilities: understand the code you own, or know who does. Don't use ownership as a rite of initiation; yield it when you leave.
- The structure is decentralized: creating a project needs only a new OWNERS file, no central registrar. Root OWNERS members can approve large-scale changes globally. OWNERS files double as documentation of who is responsible for what. This simple mechanism has let tens of thousands of engineers work in one repository of billions of lines for two decades.

### Code is a liability

Code by itself is a maintenance burden — like fuel on an airplane: necessary, but it has weight. New code should solve a real problem, not add another alternative. Duplicated code costs more than no code, because changes that fit one pattern take extra effort wherever duplicates exist. Google saying: "If you're writing it from scratch, you're doing it wrong!" Research for existing utilities (via code search tools) should happen before writing new code. Also: a code review is *not* the place to rehash or debate past design decisions — design happens earlier, through design docs, API reviews, and prototypes.

### The six benefits of code review

1. **Checks code correctness** — proper testing, sound design, correct and efficient function. A study at IBM found that catching defects earlier costs far less than fixing them later, provided the review process itself stays lightweight. Correctness checking is part of a "shift left" strategy (finding problems as early as possible) and one layer of defense-in-depth — the review need not be perfect to be valuable. Notably, correctness is *not* the primary benefit Google gets from review.
2. **Ensures comprehension** — the review is the first test of whether a change is understandable to a broader audience. Code is read far more often than written. For comprehension questions, "the customer is always right": every question a reviewer asks now will be multiplied many-fold by future readers, so treat each as valid (you may not change the code, but you may need to explain it better).
3. **Enforces consistency** — consistent, simple code is easier to understand, easier for tools to refactor automatically, and lets outside experts review effectively. Consistency can trump functionality: a readability reviewer may prefer a less "clever" but easier-to-understand change. This is why readability approval is a separate bit from LGTM.
4. **Psychologically promotes team ownership** — review reinforces that code is not "yours" but the team's. The process acts as the "bad cop" so the reviewer can be the "good cop": criticism arrives through a prescribed, neutral channel rather than as unsolicited personal critique. Review also provides validation and recognition (an antidote to imposter syndrome), and the act of preparing a change for review forces authors to get their ducks in a row instead of cutting corners.
5. **Enables knowledge sharing** — reviewers impart domain knowledge; authors and reviewers both learn techniques and patterns. Reviewers can mark comments "FYI" (no action needed). Engineers respond to every review sent to them even if they don't read every email, so review is a timely, actionable knowledge-transfer channel across time zones and projects.
6. **Provides a historical record** — any engineer can trace when a pattern entered the codebase and pull up the original review; that archeology helps far more engineers than the original participants.

### Deference rules (who yields to whom)

- On **design/approach**: reviewers defer to authors. Reviewers shouldn't propose alternatives out of personal preference — only when the alternative improves comprehension (less complex) or functionality (more efficient). Approve changes that *improve* the codebase; don't hold out for a "perfect" solution.
- On **comprehension**: authors defer to reviewers ("the customer is always right").
- Owners responding to outside authors should be amenable: if the change improves the codebase, give the author deference that something could and should be improved.

## Actionable Guidance

### Be polite and professional
- Keep all feedback strictly professional; ask why something was done before assuming it's wrong.
- Respond to reviews within 24 working hours; if you can't finish, at least acknowledge you've seen it.
- Don't review piecemeal — dribbling in unrelated feedback after the author has addressed a round is one of the most annoying reviewer behaviors.
- Authors: "you are not your code." Treat every reviewer comment as a TODO — it need not be accepted, but it must be addressed. If you disagree, explain why and don't resolve the comment until both sides have offered alternatives. Offer an alternative and ask the reviewer to **PTAL** (please take another look).
- Many engineers LGTM with comments, trusting the author to make the changes and submit without another round.

### Write small changes
- Keep changes to roughly **200 lines of code**, focused on a single issue.
- Reviewers can rightfully reject changes that are too large for a single review.
- Small changes get faster reviews (initial feedback within about a day at Google; ~35% of changes touch a single file), make bug sources easier to isolate, keep rollbacks safe and atomic, and prevent expensive wasted effort on a wrong approach.
- Treat the small-change preference as an *optimization*, not an absolute — accommodate the occasional larger change (integration branches and non-HEAD diff bases exist but add overhead).

### Write good change descriptions
- The first line is prime real estate: a summary of the change type, used as the email subject and the visible line in history tools.
- The description must say *what* changed and *why*. "Bug fix" is useless to reviewers and future code archeologists. Enumerate related modifications as a list.
- If a reviewer doesn't understand why you did something — even correct code — that signals the code needs better structure or better comments.
- If the review reaches a new decision, update the description or add implementation comments. A review records what you did for posterity.

### Keep reviewers to a minimum
- Most Google reviews have exactly **one** reviewer. The first LGTM is the most valuable; additional reviewers yield rapidly diminishing returns and their cost quickly outweighs their value.
- When multiple reviewers are genuinely useful, have each focus on a *different aspect* of the change.
- The process is optimized around trusting engineers to do the right thing.

### Automate where possible
- Automate every mechanical task: automatic submit and sync on approval, and especially **presubmits** — automated static analysis, tests, linters, and formatters that run when a change is sent for review, rejecting broken changes before a human ever sees them.
- Automation frees reviewers to focus on concerns more important than formatting.

### Tailor the review to the change type
- **Greenfield reviews** (entirely new code): the rarest type and the key moment to evaluate whether code will stand the test of time. Require a prior design review — a code review is not the place to debate the design or introduce a proposed API. Check that the API matches the agreed design, every endpoint has unit tests that fail when assumptions change, an OWNERS file exists, the code is commented and documented, and CI is set up.
- **Behavioral changes, improvements, optimizations**: the bread and butter. Ask "is this necessary, and does it improve the codebase?" Some of the best changes are deletions of dead code. Behavioral changes need test revisions; optimizations may need benchmarks.
- **Bug fixes and rollbacks**: fix *only* the indicated bug plus its test — resist scope creep, which bloats the review and complicates regression testing and rollback. A bug usually means tests were inadequate, so reviewers should ask for updated unit tests. Rollbacks (changes that undo a previous change) can be created in seconds but still require review; keep all changes small and atomic because others start depending on new code very quickly.
- **Refactorings and large-scale changes (LSCs)**: machine-generated changes still get reviewed, but reviewers should flag only concerns specific to *their* code, not the underlying tool or process (escalate tool concerns out of band to the LSC oversight group — individual teams can't veto the process or it wouldn't scale). Don't expand scope on automated changes: the human operating the tool may have hundreds of changes in flight, and unrelated comments destroy their throughput.

## Chapter TL;DRs (verbatim)

- Code review has many benefits, including ensuring code correctness, comprehension, and consistency across a codebase.
- Always check your assumptions through someone else; optimize for the reader.
- Provide the opportunity for critical feedback while remaining professional.
- Code review is important for knowledge sharing throughout an organization.
- Automation is critical for scaling the process.
- The code review itself provides a historical record.
