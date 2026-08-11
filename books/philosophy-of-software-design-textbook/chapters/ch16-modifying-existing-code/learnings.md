# Chapter 16: Modifying Existing Code

## Central idea

A system's design is determined more by the changes made during its evolution than by any initial conception, so the strategic mindset must apply to modifications, not just new code. Every change should leave the system with the structure it would have had if it had been designed from the start with that change in mind. The chapter's second half gives concrete techniques for keeping comments accurate as code evolves, since stale comments are one of the main ways complexity creeps in during modification.

## Key concepts

- **Strategic modification.** Tactical programming during maintenance means asking "what is the smallest possible change that does what I need?" Each minimal change adds a few special cases, dependencies, or other complexity; the design degrades a little with every step, and the problems accumulate. Strategic modification means asking instead: "is the current design still the best one, given this change?" If not, refactor so the system ends up with the best possible design.
- **The design-improvement target.** Ideally, after each change, the system has the structure it would have had if designed from the start with that change in mind. Hitting this target means the design improves with every modification.
- **Investment mindset applied to maintenance.** Extra time spent refactoring while modifying code produces a cleaner system, which speeds future development and pays back the investment. This is the same investment argument from Chapter 3, applied to existing code.
- **Comment proximity.** The farther a comment sits from the code it describes, the less likely a developer will see it when changing that code, and the less likely it gets updated. Distance breeds staleness.
- **Comment abstraction vs. distance.** The farther a comment is from its code, the more abstract it should be, so code changes are less likely to invalidate it. Higher-level comments are intrinsically easier to maintain: they don't reflect code details, so only changes in overall behavior affect them.
- **Single source of documentation.** Document each design decision exactly once, in the most obvious place developers will look. Duplicated documentation rots silently because some copies inevitably miss updates.

## Actionable principles

- **Resist the smallest-possible-change instinct.** Developers justify minimal edits because they fear that larger changes risk new bugs in unfamiliar code. But the result is tactical programming: special cases and dependencies pile up and the design gets steadily worse. "Working" isn't a high enough standard.
- **Before every change, re-evaluate the design.** Ask whether the current system design is still the best one in light of the desired change. If not, refactor first so you end up with the best possible design, then make the change.
- **Improve something every time you touch code.** Even when the change itself doesn't require refactoring, look for design imperfections to fix while you're in the code. Find a way to make the design at least a little better with every modification. **If you're not making the design better, you are probably making it worse** — there is no neutral.
- **When constraints force compromise, minimize it deliberately.** If the "right way" takes three months and a quick-and-dirty fix takes two hours against a tight deadline, or if refactoring would create incompatibilities affecting many teams, the compromise may be unavoidable. But resist as much as possible: ask "is this the best I can possibly do to create a clean design, given my current constraints?" Look for an alternative nearly as clean as the big refactoring but doable in days. If a large refactoring is unaffordable now, get time allocated to return to it after the deadline.
- **Budget for cleanup organizationally.** Every development organization should plan to spend a small fraction of its total effort on cleanup and refactoring; the work pays for itself over the long run.
- **Put comments next to the code they describe.** A method's interface comment belongs in the code file, right next to the method body, because anyone changing the method will see it there and update it. In C/C++, putting interface comments in the `.h` file separates them from the code; developers modifying the body won't see them, and updating them requires opening another file.
- **Don't justify header-file comments by reader convenience.** The argument "interface comments belong in headers so users can learn the abstraction without reading code" fails because users shouldn't read code or header files at all — they should get information from tooling-compiled documentation (Doxygen, Javadoc) or IDE pop-ups. Since tools deliver docs to users, locate the documentation wherever is most convenient for developers working on the code.
- **Push implementation comments down to the narrowest scope.** Don't write one big comment at the top of a method describing every phase in detail. Write a separate comment for each phase, placed just above that phase's first line. A short top-of-method comment sketching the overall strategy is fine; details go with the code they describe.
- **Put lasting information in the code, not the commit log.** If developers will need the information in the future, document it in the code. A subtle problem explained only in a commit message will not be found; a later developer may undo the change and re-create the bug. Copying the information into the commit message too is fine, but the code is what matters. General rule: place documentation where developers are most likely to see it, and the commit log is rarely that place.
- **Document each design decision exactly once.** When a decision affects multiple places in the code, don't repeat the explanation at each point. Pick the most obvious single location (e.g., tricky variable behavior goes in a comment at the variable's declaration). If no obvious place exists, use a designNotes file (Section 13.7) or pick the best available spot and add short pointers elsewhere: "See the comment in xyz for an explanation of the code below."
- **Prefer references over copies because references fail loudly.** If a master comment moves or is deleted, a stale pointer is self-evident — the reader won't find the comment and can use revision history to track it down. A stale duplicated copy gives no signal that the information is wrong.
- **Don't re-document another module's design decisions.** Don't put comments before a method call explaining what the called method does; readers should consult the method's interface comment, which good tooling surfaces automatically (hover, autocomplete). Make documentation easy to find, but not by repeating it.
- **Reference external documentation instead of duplicating it.** If something is already documented outside the program (a Web spec, a user manual), add a short comment with a pointer rather than restating it. Readers must be able to find all documentation needed to understand your code; you don't have to write all of it.
- **Scan the diff before every commit.** Spend a few minutes reviewing all changes in the commit and verify each is reflected in the documentation. This pre-commit scan also catches leftover debugging code and unfixed TODOs.
- **Write higher-level comments where possible.** Abstract comments survive minor code changes; only behavioral changes invalidate them. The most useful comments (those that don't merely repeat the code) are also the easiest to maintain.

## Nuances and counterpoints

- **Keeping comments accurate is not expensive.** Ousterhout explicitly rejects the assumption that comment maintenance is a heavy burden: with a little discipline and a couple of guiding rules, comments stay up to date without huge effort. The two guiding rules are the chapter's core techniques — keep comments near the code, and avoid duplication — with the pre-commit diff scan and a preference for abstract comments rounding out the toolkit.
- **Pragmatism is acknowledged, not endorsed.** Ousterhout concedes that deadlines and cross-team incompatibilities sometimes make the quick fix the only realistic option. The discipline is to treat this as an explicit, minimized compromise — with a plan to return — not as the default mode.
- **Detail still has its place.** Spreading comments to narrow scopes and preferring abstraction does not mean all comments should be vague; Chapter 13's point stands that some comments must be detailed and precise. The claim is only that, in general, useful comments are abstract ones and abstract ones are cheaper to maintain.
- **Top-of-method strategy comments are still good.** The rule against one big top comment targets detailed phase-by-phase description, not a brief overview of the overall approach.

## Red flags

(The chapter defines no boxed red flags; these are implicit warning signs.)

- A change framed as "the smallest possible edit that works" — symptom of tactical programming during maintenance.
- A modification that adds a special case or dependency without anyone asking whether the design should change instead.
- Stale or inaccurate comments — readers begin to distrust all comments once a few are wrong.
- Interface comments far from the code (e.g., in header files) where modifiers won't see them.
- One detailed comment at the top of a method covering all of its internal phases.
- Important rationale that exists only in a commit message, not in the code.
- The same design decision documented in multiple places.
- Comments that explain what a called method does, duplicating that method's own interface comment.
- Comments restating documentation that already exists externally (specs, manuals).
- Committing without scanning the diff for documentation drift, leftover debug code, or open TODOs.
