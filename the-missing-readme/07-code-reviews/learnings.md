# Chapter 7: Code Reviews

Most teams require code changes to be reviewed before they're merged, and a high-quality review culture helps engineers of all levels grow, spreads understanding of the codebase, and catches problems early. A poor review culture does the opposite: it inhibits innovation, slows development, and builds resentment. This chapter explains why reviews are worth doing well and gives concrete techniques for both sides of the exchange — getting your code reviewed and reviewing others' code.

## Core Concepts

### Why Review Code?

Reviews have obvious surface benefits — catching bugs and keeping code clean — but their real value goes far beyond having humans stand in for automated tests and linters:

- **Teaching and learning.** Feedback teaches you about useful libraries and coding practices you didn't know. Reading senior teammates' review requests teaches you the codebase, how production-grade code is written, and your team's coding style.
- **Shared understanding.** Reviews ensure more than one person is familiar with every line of production code. The team can evolve code more cohesively, you're not the only person who can answer questions when things go wrong, on-call engineers know what changed when, and you can take a vacation without being the sole support for your code.
- **Documentation.** Review comment threads form a written archive explaining *why* code was written the way it was — implementation decisions that aren't obvious from the code itself. Older reviews give developers a written history to consult.
- **Security and compliance.** Many policies require reviews so no single developer can maliciously modify the codebase; reviews provide change records for audits.

### Reviews Require a High-Trust Environment

All of these benefits apply only when participants work in "high trust": reviewers are intentional about providing useful feedback, and reviewees are open to input. Poorly executed reviews become toxic impediments — thoughtless feedback adds no value and slows people down, slow turnaround grinds changes to a halt, and without the right culture, disagreements escalate into knock-down-drag-out fights that can ruin a team. A review is neither an opportunity to prove how smart you are nor a rubber-stamping bureaucratic hurdle.

Reviews also surface impostor syndrome (review anxiety) and the Dunning–Kruger effect (overconfidence). Both reactions are natural and can be overcome with the right context and skills.

### Getting Your Code Reviewed

The lifecycle: code is prepared, submitted (creating a "review request" that notifies reviewers), discussed and revised through back-and-forth feedback, then approved and merged.

#### Prepare Your Review

A well-prepared request makes it easy for reviewers to understand what you're doing and give constructive feedback:

- Keep individual changes small. Separate feature work and refactoring into different reviews. Write descriptive commit messages. Include comments and tests.
- Make sure tests and linters pass before requesting review.
- Add a title and description, add reviewers, and link to the issue the change resolves. The title and description are *not* the same as a commit message — they should add context: how the changes were tested, links to related resources, and callouts on open questions or implementation details.
- Use a standard formatting convention for issue references (e.g., an issue ID in the title) so tooling can automatically link issue trackers to code reviews — helpful when referring back to older issues later.
- Fill out the repository's review description template if one exists; templates surface context reviewers need (for example, flagging that a change modifies a public-facing API, which warrants extra scrutiny).
- Don't get attached to the code you submit. Expect it to change, sometimes significantly, as it goes through the process.

#### De-risk with Draft Reviews

Many developers think best by coding. A draft review is an informal review request intended to get quick, cheap feedback from teammates on a change before you invest in tests, polish, and documentation — it significantly reduces the risk of going too far down the wrong path. Be explicit that it's a draft or work-in-progress: teams conventionally prepend "DRAFT" or "WIP" to the title, and some platforms have built-in support (GitHub's "draft pull requests"). Once the draft is on the right track, transition it out of the draft state by finishing the implementation, tests, and documentation and adding polish — then clearly mark it ready for a real, nondraft review.

#### Don't Submit Reviews to Trigger Tests

Some developers submit review requests just to get the continuous integration (CI) system to run tests, because large projects have complex test tooling that's hard for newcomers to run. This is a poor practice: it fills the CI queue and blocks reviews that genuinely need test runs before merging, teammates mistake the request for something they should review, and CI runs the full suite when you only need tests related to your change. Instead, invest in learning to run tests locally — debugging a failed test is far easier locally than in CI (you can attach debuggers and get debug information), and a fast local code-test cycle tells you immediately when your changes break something. It's an up-front cost that saves time in the long run and is friendlier to teammates.

#### Walk Through Large Code Changes

For large changes, hold a walk-through: an in-person meeting where you share your screen and guide teammates through the change. Walk-throughs trigger ideas and make the team comfortable with big changes.

- Circulate relevant design documents and the code in advance, and ask teammates to look before the meeting. Give them adequate time — don't schedule the walk-through an hour after sending materials.
- Start with background on the change (a quick design-doc review may be warranted), then share your screen and navigate the code in your IDE while narrating. Walk-throughs work best when you follow the code's execution flow from a starting point — a page load, API call, or application startup — all the way to the termination of execution. Explain the main concepts behind new models and abstractions, how they're meant to be used, and how they fit into the overall application.
- Don't ask attendees to actually review the code during the meeting; they should save comments for the review itself. The walk-through's job is to convey *why* the change is proposed and to give reviewers a good mental model for working through the detailed review on their own.

#### Don't Get Attached

Critical comments can be tough to receive. Keep emotional distance: the review is of the code, not of you — and it isn't even really *your* code, because the whole team will own it in the future. Getting a lot of suggestions doesn't mean you failed a test; it means the reviewer is engaging with your code and thinking about how it can be improved. Lots of comments are completely normal, especially for less experienced developers. Reviewers may ask for changes that seem unimportant or deferrable because they have different priorities and timelines — keep an open mind, try to understand where they're coming from, be receptive, and expect to revise your code based on feedback.

#### Practice Empathy, but Don't Tolerate Rudeness

Everyone communicates differently, but rudeness should not be tolerated. One person's "short and to the point" can be another's "brusque and rude." Give reviewers the benefit of the doubt, but let them know if comments seem off base or rude. If a discussion drags on or feels off, a face-to-face conversation helps clear the air and reach resolution. If you're uncomfortable, talk to your manager.

When you disagree with a suggestion, try to work the disagreement out. Examine your own reaction first: are you instinctively protecting the code just because you wrote it, or is your way in fact better? Explain your viewpoint clearly. If you still can't agree, ask your manager what the next step is. Teams resolve review conflicts differently — some defer to the submitter, some to a tech lead, some to group quorum — so follow your team's convention.

#### Be Proactive

Don't be shy about asking others to review your code. Reviewers are bombarded with review and ticket notifications, and reviews get lost on high-velocity projects. If you get no feedback, check in with the team without being pushy. When comments arrive, be responsive — everyone's memory fades, and the faster you respond, the faster you get responses; you don't want a review dragging on for weeks. After approval, merge promptly. A dangling approved review is inconsiderate: others may be waiting on your changes or want to change code once you merge. Waiting too long forces rebasing and fixes, and in extreme cases a rebase can break your code's logic and require another review.

### Reviewing Code

Good reviewers break a review request into stages: triage the request for urgency and complexity, set aside time, begin by reading code and asking questions to understand the change's context, then give feedback and drive the review to a conclusion.

#### Triage Review Requests

Your work as a reviewer begins when the notification arrives. Triage it: some changes are critical and need immediate review; most are less pressing. If urgency is unclear, ask the submitter. Weigh size and complexity too — a small, straightforward change deserves a quick review to unblock your teammate, while larger changes need more time. On high-velocity teams with overwhelming review volume, you don't need to review every change — focus on changes you can learn from and changes touching code you're familiar with.

#### Block Off Time for Reviews

Reviews resemble operational work: their size and frequency are somewhat unpredictable. Don't drop everything whenever a request arrives — left unchecked, review interruptions torpedo productivity. Block off review time on your calendar; scheduled time lets you continue other tasks knowing you'll have focused review time later, and it keeps review quality high because you won't feel pressure to rush back to other work. For reviews that will take more than an hour or two, create an issue to track the review itself and work with your manager to allocate dedicated time in sprint planning.

#### Understand the Change

Don't begin a review by leaving comments — first read and ask questions. Reviews are most valuable when the reviewer really takes time to understand the proposed changes. Aim to understand why the change is being made, how the code behaved before, and how it behaves after. Consider the long-term implications of API design, data structures, and other key decisions. Understanding the motivation explains implementation choices — and you might discover the change isn't even needed. Comparing code before and after the change helps you check correctness and triggers alternative implementation ideas.

#### Give Comprehensive Feedback

Give feedback on correctness, implementation, maintainability, legibility, and security:

- Point out code that violates style guides, is hard to read, or is confusing. Read the tests and look for bugs to verify correctness.
- Ask yourself how *you* would implement the change — this triggers alternative ideas and trade-off discussions.
- For public API changes, think about compatibility effects and the planned rollout.
- Consider ways a future programmer might misuse or misunderstand the code, and how it could be altered to prevent that.
- Think about available libraries and services that might help; suggest design patterns that keep code maintainable.
- Look for OWASP Top Ten security violations: SQL injection attacks, sensitive data leaks, and cross-site scripting vulnerabilities.
- Don't be overly terse. Write comments the way you'd say them if you were reviewing side by side. Comments should be polite and include both a "what" (the requested action) and a "why" (the reason it matters).

#### Acknowledge the Good Stuff

It's natural to focus on finding problems, but a review doesn't have to be all negative — comment on the good stuff too. If you learned something new from reading the code, tell the author. If a refactoring cleans up problematic areas or new tests make future changes less risky, recognize it with a positive, encouraging comment. Even a change you hate probably has something you can say something nice about — if nothing else, acknowledge the intent and the effort.

#### Distinguish Between Issues, Suggestions, and Nitpicks

Not all review comments have the same level of importance; major issues need more attention than neutral suggestions and superficial nitpicks. Don't shy away from stylistic feedback, but make it clear you're nitpicking — a "Nit:" prefix on the comment is customary. If the same style issue occurs repeatedly, don't keep harping on it: point out the first instance and indicate it should be fixed across the board; nobody likes being told the same thing over and over. If you find yourself nitpicking style often, ask whether the project has adequate linting tools — ideally tooling does that work for you. If your reviews are mostly nitpicks with few substantial comments, slow down and do a deeper reading: pointing out cosmetic changes is part of a review, but not its main goal. Call out suggestions that seem better to you but aren't required for approval by prefixing them with "optional," "take it or leave it," or "nonblocking" — otherwise the submitter can't tell suggestions from required changes.

#### Don't Rubber-Stamp Reviews

You will feel pressure to approve a review without really looking at it — from an urgent change, peer pressure, a seemingly trivial change, or a change that's too large. Even empathy pushes you toward fast approval, because you know what it's like to wait on a review. Resist the temptation. Rubber-stamping is harmful: teammates will think you know what the change is and why it's applied, and you might be held responsible later; the submitter will think you actually looked at and approved their work. If you can't prioritize a review adequately, don't review the change at all. The temptation to rubber-stamp is often a signal that the change is too big for one request — don't be afraid to ask teammates to split large reviews into smaller sequential chunks. It's easy for developers to get rolling and end up with a multithousand-line change, and it's unreasonable to expect a huge change to be adequately reviewed in one shot. If a walk-through would be more efficient, ask for that.

#### Don't Limit Yourself to Web-Based Review Tools

Reviews are usually handled in a dedicated web UI like GitHub's pull request interface, but code reviews are just code: you can check out or download the proposed changes and play with them locally. A local checkout lets you examine changes in your IDE — large changes are hard to navigate in a web interface, and IDEs and desktop review tools make browsing easier. Local code is also runnable: write your own tests to verify things work as expected, attach a debugger to running code to understand its behavior, and even trigger failure scenarios to better illustrate the comments in your review.

#### Don't Forget to Review Tests

Reviewers often gloss over tests, especially when the change is long — but tests should be reviewed just like the rest of the code. It's often useful to *start* a review by reading the tests: they illustrate how the code is used and what's expected. Check tests for maintainability and cleanliness, and look for bad test patterns: dependence on execution ordering, lack of isolation, and remote system calls.

#### Drive to a Conclusion

Don't be the reason improvements wither on the vine. Help submitters get their code approved quickly: don't insist on perfection, don't expand the scope of the change, clearly describe which comments are critical, and don't let disagreements fester. Insist on quality without becoming an impassible barrier — the guiding principle (from Google's engineering practices) is that reviewers should favor approving a change once it's in a state where it definitely improves the overall code health of the system, even if it isn't perfect. Respect the scope of the change: as you read you'll find ways to improve adjacent code and ideas for new features, but don't insist they be made in the existing review — open a ticket and save the work for later. Tight scope increases velocity and keeps changes incremental. Conclude reviews explicitly by marking "Request Changes" or "Approved"; if you left many comments, add a review summary, and when requesting changes, specify exactly which changes are required for approval. If there's significant disagreement you and the author can't resolve, proactively propose taking the matter to other experts who can help settle it.

### Level Up

Google's public "Code Review Developer Guide" is a good example of one company's review culture — but it's written for Google specifically; your company's risk tolerance, investment in automated quality checks, and preference for speed versus consistency may lead to a different philosophy. Ultimately, code reviews are a specialized form of giving and receiving feedback; *Thanks for the Feedback: The Science and Art of Receiving Feedback Well* by Douglas Stone and Sheila Heen is an excellent resource for becoming both a better reviewer and a better reviewee.

## Actionable Practices

The chapter's own Do's and Don'ts:

- DO make sure tests and linters pass before requesting a review.
- DO set aside time for code reviews and prioritize them just like you do other work.
- DO speak up if comments seem rude, unconstructive, or inappropriate.
- DO help the reviewer by providing appropriate context for the change.
- DO look beyond superficial style issues when doing a review.
- DO use all your tools — not just the code review interface — to understand tricky changes.
- DO review tests.
- DON'T make review requests just to get the CI system to run.
- DON'T rubber-stamp code reviews.
- DON'T fall in love with your code or take feedback personally.
- DON'T review code minutiae before understanding the big picture of the change.
- DON'T nitpick excessively.
- DON'T let perfect be the enemy of the good.

Additional rules from the chapter:

- Keep changes small; split feature and refactoring work into separate reviews; write descriptive commit messages; include comments and tests.
- Write a review title and description that add context beyond the commit message: testing notes, links to resources, open questions, implementation callouts. Link the issue using a standard reference convention so tooling can connect trackers and reviews.
- Use draft/WIP reviews to validate direction cheaply before polishing; label drafts clearly and announce when the review becomes real.
- Learn to run tests locally and make your code-test cycle fast instead of leaning on CI.
- For big changes, run a walk-through: circulate materials in advance, narrate the execution flow in your IDE, and keep actual review comments out of the meeting.
- If you disagree with feedback, examine your own defensiveness first, explain your view clearly, then escalate per team convention (submitter, tech lead, or group quorum decides).
- Nudge stalled reviews politely; respond to comments fast; merge promptly after approval.
- Triage incoming reviews by urgency, size, and complexity; quick-turn small changes to unblock teammates; on busy teams, prioritize reviews you can learn from or that touch code you know.
- Block calendar time for reviews; create a tracking issue and plan sprint time for reviews longer than an hour or two.
- Read and ask questions before commenting; understand motivation, before-behavior, and after-behavior first.
- Make comments polite, specific, and explanatory — state both what to change and why.
- Praise good work: new things you learned, cleanups, risk-reducing tests — or at least the intent and effort.
- Prefix style nits with "Nit:" and optional ideas with "optional"/"nonblocking"; flag repeated issues once with a request to fix throughout; push recurring style enforcement into linters.
- Check out tricky changes locally; run them, test them, attach a debugger, reproduce failures.
- Start by reading tests; verify they're isolated, order-independent, and don't call remote systems.
- End every review with an explicit verdict ("Approved" or "Request Changes"), a summary when comments are numerous, and a clear list of what blocks approval.
- File tickets for out-of-scope improvements instead of demanding them in the current review.

## Pitfalls & Anti-patterns

- **Toxic review culture.** Thoughtless feedback, slow turnaround, and ego-driven arguments turn reviews from a multiplier into an impediment that can ruin a team. Reviews aren't a stage for proving how smart you are, nor a bureaucratic formality.
- **Rubber-stamping.** Hasty approval under pressure misleads teammates about what was vetted, leaves you accountable for code you never read, and often masks a change that should have been split into smaller chunks.
- **Using CI as your test runner.** Submitting review requests to trigger tests clogs the queue, blocks reviews that need test runs to merge, confuses teammates, and wastes resources running the full suite — while keeping you from learning fast local debugging.
- **Getting attached to your code.** Taking feedback personally turns useful engagement into conflict; the review is of the code, and the team owns the code.
- **Excessive nitpicking.** A review that's mostly cosmetic comments with little substance means you read too shallowly — and frequent style policing signals missing lint tooling.
- **Repeating the same comment.** Harping on every instance of a recurring style issue annoys the author; flag it once and ask for a global fix.
- **Reviewing minutiae before the big picture.** Commenting line by line before understanding the change's motivation produces low-value feedback and misses the chance to question whether the change is needed at all.
- **Scope creep in review.** Insisting that adjacent-code improvements or new feature ideas land in the current review stalls it; open tickets instead.
- **Perfectionism.** Letting perfect be the enemy of the good blocks changes that already improve overall code health.
- **Skipping tests in review.** Glossing over test code lets bad patterns (ordering dependence, poor isolation, remote calls) into the codebase.
- **Letting reviews and merges linger.** Slow responses make everyone's memory fade; an unmerged approved change blocks others, forces rebases, and a rebase can even break the code's logic and require re-review.
- **Tolerating rudeness — or assuming it.** Letting rude comments slide corrodes trust, but so does reading terseness as hostility; clarify face-to-face and involve your manager when needed.
- **Scheduling a walk-through with no prep time.** Sending materials an hour before the meeting wastes everyone's time; circulate them well in advance.

## Key Terms

- **Review request** — the submitted unit of proposed changes that notifies reviewers and hosts the feedback discussion (a pull request on GitHub).
- **Draft review / WIP** — an informal, clearly labeled review request seeking quick, cheap directional feedback before the code is polished; GitHub supports this natively as "draft pull requests."
- **Walk-through** — an in-person screen-sharing meeting where the author narrates a large change's execution flow end to end to build reviewers' mental model; comments are saved for the review itself.
- **Rubber-stamping** — approving a review without genuinely examining it.
- **Nit / nitpick** — a superficial or stylistic comment, conventionally prefixed "Nit:" to signal low importance.
- **Nonblocking / optional comment** — a suggestion the reviewer would like but does not require for approval ("optional," "take it or leave it," "nonblocking").
- **Triage** — assessing an incoming review request's urgency, size, and complexity to decide when (or whether) to review it.
- **CI (continuous integration)** — the shared automated system that runs the test suite on submitted changes.
- **CL (changelist)** — Google's internal term for a proposed code change, equivalent to a pull request.
- **High-trust environment** — a culture where reviewers give intentional, useful feedback and reviewees stay open to input; the precondition for reviews to deliver value.
- **OWASP Top Ten** — a standard list of the most critical web application security risks (e.g., SQL injection, sensitive data leaks, cross-site scripting) that reviewers should check changes against.
- **Impostor syndrome / Dunning–Kruger effect** — the two natural emotional traps of reviews: anxiety that feedback proves inadequacy, and overconfidence that resists feedback.
