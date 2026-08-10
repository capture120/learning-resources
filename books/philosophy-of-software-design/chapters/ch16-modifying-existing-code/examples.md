# Chapter 16 Examples: Modifying Existing Code

This chapter is light on extended case studies; its examples are short, concrete scenarios that illustrate strategic modification and comment maintenance.

## The 3-month refactoring vs. the 2-hour quick fix

**Design problem:** A needed change would, done "the right way," require refactoring the system — an effort of roughly three months. A quick-and-dirty fix takes two hours, and a deadline looms. A related variant: the proper refactoring would create incompatibilities affecting many other people and teams.

**Bad approach:** Defaulting to the quick fix every time pressure appears, treating "working" as the standard. Each minimal change adds special cases and dependencies, and the design degrades step by step.

**Good approach:** Accept the compromise only when genuinely forced, and even then minimize it. Ask "is this the best I can possibly do for a clean design, given my current constraints?" Look for a middle path — an alternative almost as clean as the 3-month refactoring but doable in a couple of days. If the large refactoring truly can't happen now, get your boss to allocate time to come back to it after the current deadline.

**Lesson:** Demonstrates "stay strategic" under real commercial constraints. Compromises with the investment mindset should be explicit, minimized, and scheduled for repayment — never the silent default. Organizations should budget a small fraction of total effort for cleanup and refactoring; it pays for itself.

## Interface comments in C/C++ header files

**Design problem:** In languages with separate code and header files (C, C++), where should a method's interface comment live — next to the declaration in the `.h` file, or next to the method body in the code file?

**Bad approach:** Putting interface comments in the header file. The header is a long way from the implementation: developers modifying the method body never see those comments, and updating them means opening a different file and hunting for the right block. The comments go stale. The common defense — "users can learn the abstraction from the header without reading code" — doesn't hold, because users shouldn't read code or header files at all; they should get documentation from tools like Doxygen or Javadoc, or from IDEs that display a method's documentation as its name is typed.

**Good approach:** Put the interface comment in the code file, right next to the method body. Any change to the method passes through that code, so the developer sees the comment and updates it if needed. Since tooling delivers documentation to users regardless of where it lives, locate it where it's most convenient for the developers maintaining the code.

**Lesson:** "Keep the comments near the code" — proximity is the single best predictor that a comment will stay accurate.

## The three-phase method comment

**Design problem:** A method's implementation has three major phases. How should implementation comments be organized?

**Bad approach:** One comment at the top of the method describing all three phases in detail. It sits far from most of the code it describes, so changes deep in the method are unlikely to trigger updates to it.

**Good approach:** Write a separate comment for each phase, placed just above the first line of code in that phase. A brief top-of-method comment describing the overall strategy is still helpful:

```
// We proceed in three phases:
// Phase 1: Find feasible candidates
// Phase 2: Assign each candidate a score
// Phase 3: Choose the best, and remove it
```

Additional details then live just above the code for each phase.

**Lesson:** Push each comment down to the narrowest scope that includes all the code it refers to. Corollary: the farther a comment is from its code, the more abstract it should be, so code changes are less likely to invalidate it.

## The subtle bug fix documented only in a commit message

**Design problem:** A code change is motivated by a subtle problem. Where should that motivation be recorded?

**Bad approach:** Writing a detailed explanation in the commit message and nothing in the code. A developer needing that information later is unlikely to think of scanning the repository log, and even if they do, finding the right message is tedious. Worse, a later developer may see the odd-looking code, "clean it up" by undoing the change, and silently re-create the bug.

**Good approach:** When writing a commit message, ask whether developers will need that information in the future. If so, document it in the code at the relevant spot. Copying it into the commit message as well is fine, but the code copy is the one that matters.

**Lesson:** Place documentation where developers are most likely to see it; the commit log is rarely that place.

## Tricky variable behavior documented at its declaration

**Design problem:** A variable has tricky behavior that affects several different places where the variable is used. Documenting it at every use site duplicates the explanation; some copies will inevitably go stale.

**Good approach:** Document the behavior exactly once, in the comment next to the variable's declaration. That's the natural place a developer checks when puzzled by code that uses the variable.

**Lesson:** Avoid duplicated documentation by finding the most obvious single place for each design decision.

## Cross-references instead of copies ("See the comment in xyz")

**Design problem:** A piece of documentation has no single "obvious" home where every affected developer will find it.

**Good approach:** Either create a designNotes file (per Section 13.7), or pick the best available place for the master comment and add short pointers elsewhere: "See the comment in xyz for an explanation of the code below."

**Why references beat copies:** If the master comment is later moved or deleted, the stale reference is self-evident — the reader won't find the comment at the indicated place and can use revision control history to track it down and fix the reference. A stale duplicated copy, by contrast, gives no signal that the reader is consuming outdated information.

**Lesson:** Duplication fails silently; references fail loudly. Prefer the failure mode that announces itself.

## Comments that re-explain a called method

**Design problem:** A developer is tempted to put a comment before a method call explaining what the called method does.

**Bad approach:** Writing that comment. It re-documents another module's design decision, creating a duplicate that will drift from the method's real behavior.

**Good approach:** Let readers consult the method's own interface comment. Good development tools surface it automatically — for example, displaying the interface comment when you select or hover over the method's name.

**Lesson:** Make documentation easy to find, but never by repeating it.

## The HTTP-implementing class

**Design problem:** A class implements the HTTP protocol. Should the code explain the protocol?

**Good approach:** No — HTTP is already extensively documented on the Web. Add a short comment containing a URL to one of those sources.

**Lesson:** If information is already documented outside your program, reference it rather than repeating it.

## Commands documented in a user manual

**Design problem:** A program implements a collection of commands, one method per command, and a user manual already describes each command's behavior.

**Good approach:** Don't duplicate the manual's content in the code. Each command method's interface comment carries a short note:

```
// Implements the Foo command; see the user manual for details.
```

**Lesson:** Readers must be able to easily find all documentation needed to understand your code — but that doesn't mean you have to write all of it.

## The pre-commit diff scan

**Design problem:** Code changes routinely invalidate comments, and the drift goes unnoticed at commit time.

**Good approach:** Take a few minutes before each commit to scan every change in the diff and confirm each one is properly reflected in the documentation. The same scan catches other slips: debugging code accidentally left in, and TODO items that were never fixed.

**Lesson:** A cheap, habitual checkpoint keeps documentation synchronized with code and catches unrelated commit hygiene problems for free.
