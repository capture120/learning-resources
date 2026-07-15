# Chapter 9: Code Review — Examples, Case Studies, and Anecdotes

All examples come from *Software Engineering at Google*, Chapter 9 ("Code Review"). Each is retold in plain language. Domain terms: **LGTM** ("looks good to me") is the approval mark a reviewer places on a change; an **owner** is an engineer with approval rights over a directory of the codebase; **readability** is Google's per-language certification that an engineer knows that language's style and best practices.

## The airplane-fuel analogy: code is a liability

**Setup.** The chapter opens its "Code Is a Liability" argument with an analogy. Engineers tend to see new code as pure progress.

**What happens.** The book compares code to the fuel an airplane carries: the fuel is necessary for the plane to fly, but it has weight, and every pound of it must be carried. Likewise, every line of code is a maintenance task for someone somewhere down the line. Duplicated code is worse than no code, because a change that fits one pattern must be repeated everywhere the duplication exists.

**Lesson.** Verify that a new feature is warranted before writing it. Search for existing utilities first. Google engineers even have a saying: "If you're writing it from scratch, you're doing it wrong!"

## The tech lead and the intern: how permission bits combine

**Setup.** Google requires three approvals on every change: an LGTM from a peer, approval from a directory owner, and approval from someone with language readability. This sounds heavyweight.

**What happens.** The book contrasts two engineers submitting the *same* change to the *same* codebase. A tech lead who owns the project and holds readability in the language already carries two of the three bits, so they need only a single LGTM from any other engineer. An intern with no ownership and no readability needs the same LGTM *plus* approval from an owner who has readability. In practice most reviews have one person filling all three roles at once.

**Lesson.** Separating approval into combinable bits makes the process both rigorous and fast. Control scales because seniority and expertise reduce the number of people who must sign off, without ever dropping the second set of eyes.

## The two-step review: peer first, owner second

**Setup.** Some changes genuinely need more than one approver — for example, adding a function to a utility library owned by another team.

**What happens.** The typical flow is two-step. First the author iterates with a teammate over several rounds (perhaps several days) until the peer grants an LGTM for correctness and comprehension. Then the author takes the change to the library's owner, who usually holds readability too. The owner doesn't re-review every line; they check that the peer reviewer did due diligence and focus on their own questions: "Will this code be easy or difficult to maintain? Does it add to my technical debt? Do we have the expertise to maintain it within our team?"

**Lesson.** Splitting roles lets each reviewer focus on a different aspect, which saves total review time and keeps owners from becoming a bottleneck.

## OWNERS files: two decades of decentralized stewardship (Hyrum Wright sidebar)

**Setup.** A small team in its own repository can give everyone access to everything — the members know each other, the domain is narrow, and small numbers limit the damage of mistakes. As an organization grows, that stops scaling; the alternatives are a messy repository split or a way to record who is responsible for what.

**What happens.** Google's answer is plain text OWNERS files. Each directory can hold one listing the usernames responsible for that directory and its children; ownership is hierarchically additive up the tree (a file is owned by the union of all OWNERS files above it). Creating a new project requires no central authority — a new OWNERS file suffices. The people in the root OWNERS file can approve large-scale changes across the whole codebase without bothering local teams, and anyone can find who is responsible for a piece of code just by walking up the directory tree. The book stresses that ownership means *stewardship* — acting in the company's interest for that code — not possession; the authors say "stewards" would have been a better name. Teams are urged to keep OWNERS lists small, not to use ownership as a rite of initiation, and to yield ownership when leaving.

**Lesson.** A simple decentralized mechanism has let tens of thousands of engineers work efficiently on billions of lines in a single repository for over twenty years.

## The IBM defect study: catch bugs early, keep the process light

**Setup.** The chapter wants evidence that review actually prevents bugs, not just folklore.

**What happens.** It cites a study at IBM ("Advances in Software Inspection," IEEE Transactions on Software Engineering, 1986) which found that discovering defects earlier in the process meant less time spent fixing them later. The time invested in review paid for itself in reduced testing, debugging, and regression work — *provided* the review process itself stayed streamlined and lightweight. Heavyweight review processes that don't scale become unsustainable.

**Lesson.** Code review is part of a "shift left" strategy — finding issues as early as possible so they don't demand escalated cost later. But the benefit is conditional on keeping the process nimble.

## Critique as the "bad cop": the tool's name does the emotional work

**Setup.** Engineers are naturally proud of their craft and reluctant to open their code to criticism. Unsolicited critique can be an emotionally charged interaction.

**What happens.** Google's review process channels criticism through a prescribed, neutral mechanism — and the company literally named its review tool "Critique." Because the process itself *requires* critical review, an author can't fault a reviewer for doing their job. The process plays the "bad cop" so the reviewer can remain the "good cop." New Googlers are often intimidated by review at first and can read critique as a judgment on their job performance, but over time nearly all come to expect challenges and to value the questions and advice (the book admits this sometimes takes a while).

**Lesson.** A mandated review process buffers interpersonal friction and gently socializes engineers into team expectations. Review also supplies validation: even strong engineers suffer imposter syndrome, and a review is a concrete mechanism for recognition of one's work.

## "I'll write the tests later": review as a forcing function

**Setup.** Most engineers are not perfectionists; code that "gets the job done" beats perfect code that ships late, and without external pressure many would cut corners with every intention of fixing things later — "Sure, I don't have all of the unit tests done, but I can do that later."

**What happens.** Knowing a change must go before a reviewer forces the author to resolve those shortcuts *before* sending it. Assembling the change for review creates a small moment of reflection — the perfect time to read through your own diff and catch what's missing.

**Lesson.** The mere existence of precommit review raises the quality bar authors hold themselves to, independent of anything a reviewer says.

## "Meeting" colleagues through code review

**Setup.** The knowledge-sharing section notes that review is Google's primary channel for engineers to exchange coding techniques.

**What happens.** An engineer may not read every email sent to them, but they tend to respond to every code review. Reviews cross time zones and projects, reviewers can attach "FYI" comments that require no action, and reviewers can even share suggested edits directly in the tool. The book notes that many Google engineers "meet" other engineers for the first time through code reviews. And because every change lands in the codebase with its review attached, any engineer can later dig up when a pattern was introduced and read the original review — archeology that teaches far more people than the original author and reviewer.

**Lesson.** Review is timely, actionable knowledge transfer at organizational scale, and it doubles as a permanent historical record.

## The numbers behind small changes

**Setup.** The most important practice for keeping review nimble is keeping changes small, but "small" needs definition.

**What happens.** The book gives concrete figures from Google's own study of its review practice ("Modern Code Review: A Case Study at Google" by Sadowski et al.): small changes should generally stay around 200 lines of code; most changes receive initial review feedback within about a day; roughly 35% of all changes at Google touch a single file; and almost all reviews have exactly one reviewer. The book also notes the trade-off honestly: some Google engineers dislike the small-change preference because a stream of incremental changes can be harder to comprehend as a whole, and workarounds (integration branches, diffing against a base other than HEAD) add overhead.

**Lesson.** Small changes are what make one-reviewer reviews, fast turnaround, easy bug isolation, and safe rollbacks possible — but treat the preference as an optimization and accommodate the occasional large change.

## "Bug fix": the useless change description

**Setup.** The first line of a change description is prime real estate — it becomes the review summary, the email subject, and the visible line in code-history tools.

**What happens.** The book holds up the description "Bug fix" as the anti-example: it helps neither the reviewer today nor the "future code archeologist" who, while tracking down a defect, drills into the original change to understand what was intended and why.

**Lesson.** Descriptions must say what changed and why, enumerate related modifications as a list, and be updated if the review reaches a new decision. A review is not just for the present; it records what you did for posterity.

## Rollbacks: developers depend on new code within hours

**Setup.** In a codebase as large as Google's, a change sometimes breaks a downstream dependency that tests didn't catch, or exposes an untested corner of the codebase. Google lets affected downstream customers "roll back" the change — a new change that reverts the previous one to a known state. Rollbacks can be created in seconds but still require review.

**What happens.** Google has observed developers starting to depend on newly submitted code very quickly — quickly enough that rolling a change back sometimes breaks *those* developers in turn, creating tangles that are hard to undo.

**Lesson.** Every change (since any change might need a rollback) should be as small and atomic as possible, so a revert doesn't cascade into further breakage. Small changes also get re-reviewed fast when the rollback happens.

## Reviewing machine-generated changes: don't veto the robot

**Setup.** Many changes at Google are generated by tools rather than people, as part of the large-scale change (LSC) process — for example, a codebase-wide refactoring. Low-risk generated changes go to designated reviewers with whole-codebase approval rights, but risky ones or ones needing local expertise are routed to individual engineers.

**What happens.** The book warns reviewers to treat these differently from normal reviews. Flag only concerns specific to *your* code, not objections to the underlying tool or the LSC process — that process was already reviewed, and if individual teams could veto it, changes could never scale across the organization (concerns about the tool go out of band to an LSC oversight group). Also resist expanding scope: with a teammate's change it's fine to ask for related cleanups, but the human operating an LSC tool may have hundreds of changes in flight, and even a small percentage picking up unrelated comments cripples their throughput.

**Lesson.** Review norms must adapt to the change's origin. For automated changes, the reviewer's job narrows to local correctness and applicability, so the organization can keep moving at machine speed.
