# Chapter 7 Examples: Code Reviews

### A model review request: the missing menu link

The chapter's example review request fixes a bug where the "About Us" option in a site's main menu header does nothing because it lacks a link. Re-sketched:

```
Reviewers: agupta, csmith, jshu, ui-ux
Title: [UI-1343] Fix missing link in menu header
Description:

# Summary
The main menu header is missing a link for the About Us menu option.
Clicking the menu button does nothing right now. Fixed by adding a
proper href.

Added a Selenium test to verify the change.

# Checklist
This PR:
- [x] Adds new tests
- [ ] Modifies public-facing APIs
- [ ] Includes a design document
```

It bundles several best practices: both individual reviewers and the entire UI/UX team are added; the title references the issue (UI-1343) in a standard format so integrations can automatically link the issue tracker to the review, which helps when consulting older issues later; the summary states the bug, the fix, and how it was tested; and the description fills out the repository's review template, whose checklist flags context that changes the level of scrutiny needed (a public-API change, for instance, deserves extra attention). **Lesson:** A well-prepared review request gives reviewers the context to understand the change quickly and provide constructive feedback.

### "DRAFT"/"WIP" titles and GitHub draft pull requests

Developers who think best by coding can submit a rough change as a draft review — an informal request for quick, cheap feedback before investing in tests, polish, and documentation. To avoid confusion, teams conventionally prepend "DRAFT" or "WIP" to the title, and some platforms support the state natively: GitHub has "draft pull requests." Once the draft feels like it's on the right track, the author finishes the implementation, tests, and documentation and clearly marks it ready for a real review. **Lesson:** Clearly labeled draft reviews significantly reduce the risk of going too far down the wrong path.

### The new developer who submits reviews to run CI

Large projects often have complex test tooling, and a new developer who can't figure out how to run the tests may submit a code review just to trigger the continuous integration system. The chapter walks through why this backfires: the request fills the test queue and blocks reviews that genuinely need their tests run before merging, teammates mistake it for something they should review, and CI runs the entire suite when only the tests related to the change matter. The alternative is to invest up front in a local test setup — locally you can attach debuggers and get debug information that remote CI machines won't give you, and a fast local code-and-test cycle reveals breakage immediately. **Lesson:** Using CI as your personal test runner wastes shared resources and your teammates' attention; learn to run targeted tests locally instead.

### Running a code walk-through

For a large change, the chapter describes holding a walk-through: an in-person meeting where the author shares their screen and guides teammates through the change. The author circulates design documents and code well in advance (not an hour before), opens with background and perhaps a quick design-doc review, then navigates the code in an IDE while narrating — ideally following the execution flow from a starting point like a page load, API call, or application startup all the way to where execution terminates, explaining new models and abstractions along the way. Crucially, attendees are not supposed to review the code in the meeting; they save comments for the review itself. **Lesson:** A walk-through exists to convey why a change is proposed and to build reviewers' mental model, so they can do the detailed review effectively on their own.

### The port-validation comment: pairing "what" with "why"

To show what a good review comment looks like, the chapter gives a re-sketched example along these lines: "Check that `port` is greater than or equal to zero and raise an InvalidArgumentException if not. Ports can't be negative." The comment is written the way you'd speak if reviewing side by side: polite, concrete about the requested action, and explicit about the reason. **Lesson:** Good review comments avoid terseness and always include both a "what" (the change to make) and a "why" (the justification).

### Praising the change you disagree with: the queuing-library migration

The chapter illustrates positive, encouraging feedback with a comment on a change the reviewer actually opposes — migrating homegrown queuing code to a third-party library. The reviewer opens by calling the change interesting and saying they completely understand the desire to migrate, then explains their reservation (aversion to adding a new dependency when the existing code is simple and does its job), and closes by inviting the author to speak up if the motivation was misunderstood and offering to talk more. **Lesson:** Even when you disagree with a change, you can acknowledge intent and effort and keep the door open for discussion.

### "Nit:" comments in practice

The chapter shows the customary convention for flagging low-importance feedback — prepending "Nit:" to the comment — with three re-sketched examples: a double space ("Nit: Double space."), a naming-convention note ("Nit: Here and throughout, use snake_case for methods and PascalCase for classes."), and a subjective naming suggestion ("Nit: Method name is weird to me. What about maybeRetry(int threshold)?"). The "here and throughout" phrasing also models flagging a repeated issue once rather than commenting on every instance. **Lesson:** Labeling nitpicks explicitly tells the submitter which comments are superficial style points rather than blocking issues.

### Google's rule for approving imperfect changelists

The chapter quotes Google's public "Engineering Practices Documentation" on reviewing a changelist (CL, Google's internal term for a proposed code change): in general, reviewers should favor approving a CL once it reaches a state where it definitely improves the overall code health of the system, even if the CL isn't perfect. **Lesson:** Insist on quality, but approve changes that make the system better instead of becoming an impassible barrier in pursuit of perfection.

### A review summary that separates nits from the blocking request

When concluding a review with many comments, the chapter shows a summary along these lines: the change looks good, there are a few minor nits, but the main request — the one required for approval — is to fix the port handling, where the code looks brittle, with a pointer to the detailed comment. **Lesson:** When requesting changes, a summary should state exactly which fixes are required for approval so the submitter isn't left guessing.

### The multithousand-line change

The chapter describes how developers get rolling and end up with a multithousand-line change, and notes that the urge to rubber-stamp such a review is itself a signal: it's unreasonable to expect a huge change to be adequately reviewed in one shot. The remedies are to ask the submitter to split the work into smaller sequential chunks, or to request a code walk-through if that would be more efficient. **Lesson:** When a change is too big to review honestly, push back on its size rather than approving it blind.

### The dangling approved review and the logic-breaking rebase

The chapter sketches what happens when an author wins approval but doesn't merge: teammates wait on the changes or hold back their own edits, and as the codebase moves on, the stale branch needs rebasing and fixing. In the extreme case, the rebase can break the code's logic, which forces yet another review of the same change. **Lesson:** Merge promptly after approval — leaving an approved review dangling is inconsiderate and creates rework.

### Impostor syndrome and the Dunning–Kruger effect in reviews

The chapter names the two psychological phenomena (covered earlier in the book) that code reviews tend to bring out: impostor syndrome, the anxiety of feeling judged and inadequate when your code is critiqued, and the Dunning–Kruger effect, the overconfidence of inexperience that resists feedback. Both review anxiety and overconfidence are presented as natural reactions that can be overcome with the right context and skills. **Lesson:** Emotional reactions to reviews are normal and manageable, not a sign something is wrong with you.

### The OWASP Top Ten as a security checklist

When describing comprehensive feedback, the chapter points reviewers to the OWASP Top Ten — the standard published list of the most critical web application security risks — and names concrete violations to look for in a change: SQL injection attacks, sensitive data leaks, and cross-site scripting vulnerabilities. **Lesson:** Security review doesn't require improvisation; check changes against a known catalog of common vulnerabilities.

### Google's Code Review Developer Guide

As a level-up resource, the chapter recommends Google's public "Code Review Developer Guide" as a good example of one company's code review culture — with the caveat that it was written specifically for Google. A company's tolerance for risk, investment in automated quality checks, and preference for speed versus consistency can all lead to a legitimately different review philosophy. **Lesson:** Study mature review cultures for ideas, but adapt them to your own organization's values rather than copying wholesale.

### *Thanks for the Feedback* by Stone and Heen

The chapter closes by framing code reviews as a specialized form of giving and receiving feedback, and recommends *Thanks for the Feedback: The Science and Art of Receiving Feedback Well* by Douglas Stone and Sheila Heen (Penguin Books, 2014) as an excellent resource for becoming both a better reviewer and a better reviewee. **Lesson:** General feedback skills transfer directly to code reviews on both sides of the exchange.
