# Chapter 17: Consistency — Examples

## Line-termination war story: enforcing a convention with a pre-commit checker

**Design problem.** On one of Ousterhout's projects, developers worked on both Unix (lines end with newline) and Windows (lines end with carriage-return + newline). When a developer on one system made a small edit to a file last edited on the other system, the editor would sometimes rewrite every line terminator in the file to its platform's style. Every line then appeared modified, which made the meaningful changes impossible to track in version control.

**Bad approach (insufficient).** The team established a convention: files must contain newlines only. But documentation alone failed — it was hard to ensure that every tool used by every developer respected the rule, and each time a new developer joined, a rash of line-termination problems followed while they adjusted.

**Good approach.** The team wrote a short script that ran automatically before any commit. It checks every modified file and aborts the commit if any contains carriage returns. The script can also be run manually to repair damaged files by replacing carriage-return/newline sequences with newlines. This instantly eliminated the problem and also trained new developers in the convention.

**Lesson.** Conventions must be *enforced*, not just documented. Automated checkers that gate commits are the most reliable enforcement mechanism, and they work especially well for low-level syntactic conventions. (Principle: **Enforce.**)

## Invariant example: newline-terminated text lines

**Context.** A data structure that stores lines of text can enforce an invariant: every line is terminated by a newline character.

**Why it matters.** Because the property is *always* true, code that operates on the lines never has to handle the "line without trailing newline" special case. Invariants reduce the number of special cases code must consider and make behavior easier to reason about.

**Lesson.** Invariants are consistency applied to data: a guarantee that holds everywhere lets every reader and every piece of code rely on it. (Principle: consistency at the level of **invariants**.)

## Interfaces with multiple implementations

**Context.** An interface implemented by several classes is itself a consistency mechanism.

**Why it matters.** Once you understand one implementation of the interface, every other implementation is easier to understand, because you already know the features it must provide. The shared contract gives you cognitive leverage across implementations.

**Lesson.** Consistency is not just about style — shared abstractions transfer knowledge from one piece of code to another. (Principle: cognitive leverage via consistent **interfaces**.)

## Design patterns: model-view-controller

**Context.** Design patterns are generally accepted solutions to common problems; the chapter's example is the model-view-controller approach to user interface design.

**Why it matters.** Using an existing pattern means the implementation proceeds more quickly, is more likely to work, and is more obvious to readers who already know the pattern. (The book discusses design patterns in more detail in Section 19.5; this chapter's Section 17.3 warns against forcing a pattern onto a task that doesn't fit it.)

**Lesson.** A well-known pattern is a convention shared across the whole industry — reuse it when it fits. (Principle: consistency via **design patterns**; counterpoint: don't force a pattern onto a task it doesn't fit.)

## "When in Rome": reading a file for its conventions

**Context.** Before writing code in an unfamiliar file, examine how the existing code is structured. The chapter's concrete checks: Are public variables and methods declared before private ones? Are methods in alphabetical order? Do variables use camel case (`firstServerName`) or snake case (`first_server_name`)?

**Good approach.** When you see anything that even *might* be a convention, follow it. When making a design decision, ask whether a similar decision was made elsewhere in the project; if so, find an existing example and use the same approach in your new code.

**Lesson.** Matching surrounding code preserves the system-wide guarantee that similar things look similar. (Principle: **"When in Rome, do as the Romans do."**)

## Overzealous consistency: forcing dissimilar things to look alike

**Context.** Section 17.3's cautionary examples: using the same variable name for things that are really different, or applying an existing design pattern to a task that doesn't fit the pattern.

**Why it fails.** Consistency requires that dissimilar things be done in *different* ways. Faking similarity creates complexity and confusion, because readers will assume the familiar meaning and be wrong. Consistency only provides benefits when developers can trust that "if it looks like an x, it really is an x."

**Lesson.** Consistency is a promise about meaning, not a surface aesthetic. Breaking the promise is worse than visible variety. (Counterpoint: **taking it too far**.)
