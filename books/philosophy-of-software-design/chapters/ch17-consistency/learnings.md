# Chapter 17: Consistency

## Central idea

Consistency reduces complexity by making behavior obvious: similar things are done in similar ways, and dissimilar things are done in different ways. This creates cognitive leverage — learn how something is done once, and you can immediately understand every other place that uses the same approach. It also reduces mistakes: in a consistent system, assumptions based on familiar-looking patterns are safe.

## Key concepts

- **Cognitive leverage.** Knowledge gained in one part of a consistent system transfers directly to other parts. Without consistency, developers must learn each situation separately, which takes more time.
- **Mistake reduction.** In an inconsistent system, two situations may look the same but actually differ. A developer who recognizes a familiar pattern will make incorrect assumptions. Consistency makes pattern-based assumptions safe, so developers work faster with fewer errors.
- **Levels where consistency applies:**
  - **Names** — use names consistently (covered in Chapter 14).
  - **Coding style** — style guides restrict program structure beyond compiler rules: indentation, brace placement, declaration order, naming, commenting, restrictions on dangerous language features. Style guidelines make code easier to read and can reduce some kinds of errors.
  - **Interfaces** — an interface with multiple implementations is itself a form of consistency: once you understand one implementation, every other implementation is easier to understand because you already know the features it must provide.
  - **Design patterns** — generally accepted solutions to common problems (e.g., model-view-controller). Using an existing pattern makes implementation faster, more likely to work, and more obvious to readers.
  - **Invariants** — a property of a variable or structure that is always true (e.g., every stored line of text ends with a newline). Invariants reduce the special cases code must handle and make behavior easier to reason about.

## Actionable principles

Consistency is hard to maintain, especially when many people work on a project over a long time: one group may not know about conventions established in another group, and newcomers don't know the rules, so they unintentionally violate existing conventions and create new ones that conflict. The following tips exist to counter that drift.

- **Document conventions.** Write down the most important project-wide conventions (e.g., a coding style guide) and put the document where developers will see it, such as a conspicuous spot on the project wiki. Have newcomers read it and existing members review it periodically. Consider starting from a published style guide rather than writing one from scratch. For localized conventions like invariants, document them at an appropriate spot in the code. If conventions aren't written down, it's unlikely other people will follow them.
- **Enforce conventions automatically.** Documentation alone is not enough — developers can't remember every rule. Write a tool that checks for violations and block commits that fail the check. Automated checkers work especially well for low-level syntactic conventions. A checker eliminates violations instantly and also trains new developers.
- **Use code reviews to enforce and teach.** Code reviews are a second enforcement channel and educate newcomers. The more nit-picky reviewers are about conventions, the faster the whole team learns them and the cleaner the code becomes.
- **"When in Rome, do as the Romans do."** This is the most important convention. Before writing code in a file, look at how existing code is structured: declaration order, alphabetization, camelCase vs. snake_case. Treat anything that looks like it might be a convention as one, and follow it. Before making a design decision, ask whether a similar decision was made elsewhere in the project; if so, find an existing example and copy its approach.
- **Don't change existing conventions.** Resist the urge to "improve" them. **Having a "better idea" is not a sufficient excuse to introduce inconsistencies.** Your idea may genuinely be better, but the value of consistency over inconsistency is almost always greater than the value of one approach over another. Before deviating, require "yes" to both questions, with organizational agreement:
  1. Do you have significant new information that wasn't available when the old convention was established?
  2. Is the new approach so much better that it is worth updating **all** old uses?

  If you do upgrade, finish the job: when done, there should be no sign of the old convention. Even then, other developers may not know about the change and may reintroduce the old approach. Overall, reconsidering established conventions is rarely a good use of developer time.

## Nuances and counterpoints

- **Taking it too far.** Consistency means dissimilar things should be done in *different* ways, not just that similar things be done alike. Forcing dissimilar things into the same approach — reusing a variable name for things that are really different, or applying a design pattern to a task that doesn't fit it — creates complexity and confusion. Consistency only pays off when developers can trust that "if it looks like an x, it really is an x."
- **Consistency is another example of the investment mindset.** It costs extra work: deciding on conventions, building automated checkers, hunting for similar situations to mimic in new code, and using code reviews to educate the team. The return is more obvious code — developers understand behavior faster and more accurately, so they work faster with fewer bugs.

## Red flags

The chapter defines no boxed red flag, but it teaches these implicit warning signs:

- Code that deviates from the surrounding file's style or structure (mixed naming conventions, different declaration ordering) — a sign someone ignored "when in Rome."
- A new approach introduced alongside an old one for the same problem, justified only as "better" — inconsistency without the two-question test being passed.
- A convention "upgrade" that left old uses in place, so two conventions now coexist.
- Conventions that exist only in someone's head — undocumented and unenforced conventions will be violated, especially by newcomers.
- The same name or design pattern stretched to cover genuinely different things — false consistency that breaks the "if it looks like an x, it is an x" guarantee.
- Two situations that look identical but behave differently — the exact condition that causes developers to make wrong assumptions.
