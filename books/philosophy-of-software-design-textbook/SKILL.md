---
name: philosophy-of-software-design-textbook
description: Distilled knowledge from A Philosophy of Software Design 2nd edition (John Ousterhout) — complexity, deep modules, information hiding, abstraction layers, and strategic programming. Use when designing, reviewing, or refactoring module boundaries and APIs.
---

# A Philosophy of Software Design — Skill Overview

This skill distills John Ousterhout's *A Philosophy of Software Design* (2nd ed.) into routable
reference files for design, review, and refactoring tasks. The book's single driving idea: the
greatest limit on software is our ability to understand it, so **every design decision should be
judged by whether it reduces complexity** — either by eliminating it or by encapsulating it inside
deep modules.

**How to use these files**

1. Read this overview to find the chapter(s) matching your situation.
2. Follow the route to `chapters/<slug>/learnings.md` — the authoritative statement of that
   chapter's principles, nuances, and limits.
3. Pull `chapters/<slug>/examples.md` when you need concrete worked illustrations (code, case
   studies) to apply or explain a principle.
4. Use `principles.md` (the book's 16 numbered design principles) and `red-flags.md` (its 14 named
   red flags) as one-page global indexes when you need a quick cross-cutting checklist rather than
   chapter depth.

## Core philosophy

Complexity — anything that makes a system hard to understand or modify — is the enemy, and it
accumulates incrementally from small decisions, so it demands zero tolerance. Its symptoms are
change amplification, cognitive load, and unknown unknowns; its causes are dependencies and
obscurity. Working code isn't enough: program strategically, investing ~10–20% of development time
in design, because tactical shortcuts compound into technical debt that is rarely repaid. The
central structural tool is the deep module: lots of functionality behind a simple, somewhat
general-purpose interface, with complexity pulled down into the implementation rather than pushed
to callers via exceptions and configuration knobs. Comments and names are design tools, not
afterthoughts — if a method is hard to describe simply or hard to name, the design itself is
suspect. Design is never done: sketch at least two radically different alternatives for every
major decision, and leave every piece of code you touch slightly better designed than you found
it. Finally, apply all of this with moderation; any principle taken to its extreme leads to a bad
place.

## Routing guide

### Framing a design or review task (meta)

- `chapters/ch01-introduction/` — Introduction — establishes minimizing complexity as the goal and design as a continuous, incremental, never-done process.
- `chapters/ch02-the-nature-of-complexity/` — The Nature of Complexity — defines complexity precisely (its three symptoms, two causes) and gives the criteria for comparing alternative designs.
- `chapters/ch22-conclusion/` — Conclusion — the unifying frame; use to justify design investment versus quick-and-dirty coding.

### Deciding how much to invest vs. ship

- `chapters/ch03-working-code-isnt-enough/` — Strategic vs. Tactical Programming — when tempted to take a shortcut or kludge, or weighing design time against feature velocity.
- `chapters/ch16-modifying-existing-code/` — Modifying Existing Code — when deciding whether to refactor properly or patch minimally under deadline pressure.

### Designing a new module, class, or API

- `chapters/ch04-modules-should-be-deep/` — Modules Should Be Deep — judging interface cost vs. functionality; whether a wrapper, helper, or small class earns its keep.
- `chapters/ch05-information-hiding/` — Information Hiding (and Leakage) — drawing module boundaries so each piece of knowledge lives in exactly one place.
- `chapters/ch06-general-purpose-modules-are-deeper/` — General-Purpose Modules are Deeper — deciding how general or caller-specific an interface should be.
- `chapters/ch08-pull-complexity-downwards/` — Pull Complexity Downwards — whether the module should absorb a hard case internally or expose it via exceptions, knobs, or representation-shaped APIs.
- `chapters/ch11-design-it-twice/` — Design it Twice — before committing to any major interface, implementation, or decomposition decision.
- `chapters/ch15-write-the-comments-first/` — Write The Comments First — starting a new class or API; using comments to design and to gauge interface complexity.
- `chapters/ch21-decide-what-matters/` — Decide What Matters — choosing what to expose, default, emphasize, or hide in an interface.

### Splitting, merging, and layering code

- `chapters/ch09-better-together-or-better-apart/` — Better Together Or Better Apart? — whether to merge or split functions, methods, classes, or services; extracting helpers; long methods.
- `chapters/ch07-different-layer-different-abstraction/` — Different Layer, Different Abstraction — adjacent layers with similar APIs, pass-through methods, decorator/wrapper temptations, pass-through variables.
- `chapters/ch06-general-purpose-modules-are-deeper/` — General-Purpose Modules are Deeper — where to push specialized code (up or down) and how to remove special-case branches.

### Error handling

- `chapters/ch10-define-errors-out-of-existence/` — Define Errors Out Of Existence — whether to throw, return, retry, mask, aggregate, crash, or redefine semantics so the error can't occur.
- `chapters/ch08-pull-complexity-downwards/` — Pull Complexity Downwards — exceptions and config parameters as punted complexity callers shouldn't pay for.

### Writing comments and documentation

- `chapters/ch12-why-write-comments/` — Why Write Comments? The Four Excuses — when tempted to skip comments ("self-documenting", "no time", "they'll go stale").
- `chapters/ch13-comments-describe-nonobvious/` — Comments Should Describe Things that Aren't Obvious — what a comment should say, interface vs. implementation docs, cross-module documentation.
- `chapters/ch15-write-the-comments-first/` — Write The Comments First — when in development to write docs, and using them as a design gauge.
- `chapters/ch16-modifying-existing-code/` — Modifying Existing Code — keeping comments accurate and well-placed as code changes.

### Choosing names

- `chapters/ch14-choosing-names/` — Choosing Names — naming variables, methods, types, and parameters; treating hard-to-name entities as design signals.

### Making code obvious and consistent

- `chapters/ch18-code-should-be-obvious/` — Code Should be Obvious — readability, formatting, generic containers, declared-vs-allocated types, reader-judged obviousness.
- `chapters/ch17-consistency/` — Consistency — matching existing conventions, when deviation is justified, documenting and enforcing team conventions.

### Modifying existing code

- `chapters/ch16-modifying-existing-code/` — Modifying Existing Code — refactor vs. patch; leave the system as if it had been designed for the change from the start.
- `chapters/ch03-working-code-isnt-enough/` — Strategic vs. Tactical Programming — resisting the patch-around-it reflex when a design problem surfaces.
- `chapters/ch17-consistency/` — Consistency — fitting new code into the surrounding codebase's style and patterns.

### Performance

- `chapters/ch20-designing-for-performance/` — Designing for Performance — optimizing slow code, choosing naturally efficient designs, measuring before tuning, designing around the critical path.

### Evaluating methodologies, patterns, and trends

- `chapters/ch19-software-trends/` — Software Trends — judging inheritance, agile/TDD, design patterns, getters/setters by one criterion: does it reduce complexity?
- `chapters/ch11-design-it-twice/` — Design it Twice — forcing comparison of alternatives instead of adopting the first or most popular idea.

## Red flags quick scan

The book's 14 named red flags (full one-line definitions in `red-flags.md`), plus key symptom
patterns. Jump from symptom to the chapter that holds the remedy.

| Red flag / symptom | Looks like | Remedy in |
|---|---|---|
| Change amplification, cognitive load, unknown unknowns | One small change touches many places; correct use needs nonlocal knowledge | `ch02-the-nature-of-complexity` |
| Tactical patches / kludges | "Small kludge to ship faster"; patching around known design problems | `ch03-working-code-isnt-enough` |
| Shallow Module | Interface nearly as complex as the functionality it hides; classitis | `ch04-modules-should-be-deep` |
| Information Leakage | Same knowledge (format, encoding) understood by multiple modules | `ch05-information-hiding` |
| Temporal Decomposition | Code structure mirrors execution order, not knowledge boundaries | `ch05-information-hiding` |
| Overexposure | Common-case callers forced to learn rare features | `ch05-information-hiding` |
| Special-purpose interface | API mirrors one caller's features; new features force new lower-level methods | `ch06-general-purpose-modules-are-deeper` |
| Pass-Through Method / variable | Method just forwards args to a near-identical API; threaded unused params | `ch07-different-layer-different-abstraction` |
| Punted complexity | Exceptions or config knobs for decisions the module could make itself | `ch08-pull-complexity-downwards` |
| Repetition | Same nontrivial snippet appears repeatedly | `ch09-better-together-or-better-apart` |
| Special-General Mixture | Use-case-specific code tangled into a general mechanism | `ch09-better-together-or-better-apart` |
| Conjoined Methods | Can't understand one method without reading another | `ch09-better-together-or-better-apart` |
| Error-ful API | Many exceptions; catch-and-ignore at call sites; untested handlers | `ch10-define-errors-out-of-existence` |
| First-idea design | Only one design ever considered; alternatives are minor variations | `ch11-design-it-twice` |
| Comment Repeats Code | Comment adds nothing beyond the adjacent code or the entity's name | `ch13-comments-describe-nonobvious` |
| Implementation contaminates interface | Interface docs describe internals callers don't need | `ch13-comments-describe-nonobvious` |
| Vague Name / Hard to Pick Name | Generic, ambiguous, or impossible-to-choose names | `ch14-choosing-names` |
| Hard to Describe | A simple yet complete comment can't be written for it | `ch15-write-the-comments-first` |
| Smallest-possible-change mindset | Edits framed as minimal diffs; design never re-evaluated | `ch16-modifying-existing-code` |
| Inconsistency / false consistency | New code deviates from conventions, or dissimilar things forced to look alike | `ch17-consistency` |
| Nonobvious Code | A quick read produces wrong guesses about behavior | `ch18-code-should-be-obvious` |
| Intuition-driven tuning | Optimizing without before/after measurements; layered pass-throughs on hot paths | `ch20-designing-for-performance` |

## Authority of files

For any principle, the chapter's `learnings.md` is authoritative — it carries the full statement,
nuances, and limits that this overview compresses. The matching `examples.md` holds the worked
illustrations (code samples and case studies) for when you need to demonstrate or apply a
principle concretely. `principles.md` and `red-flags.md` are summaries for quick scanning, not
substitutes for the chapter files.
