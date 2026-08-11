# Chapter 21: Decide What Matters

## Central idea

Good software design separates what matters from what doesn't. Structure the system around the things that matter — emphasize them and make them obvious — and hide or minimize the impact of everything else. This separation underlies most ideas in the book: abstraction, naming, information hiding, and performance-driven design are all instances of it.

## Key concepts

- **What matters vs. what doesn't**: every design has a small set of aspects that are genuinely important to users of a module and a larger set that aren't. An interface should reflect only what matters to a module's users; everything else belongs in the implementation, where it is less visible. Names work the same way: pick the few words that convey the most information about the variable — those are the aspects that matter most.
- **Leverage**: the primary test for whether something matters. A design element has leverage when solving one problem also solves many other problems, or when knowing one piece of information makes many other things easy to understand. A general-purpose interface has more leverage than a special-purpose one because it solves many problems at once. An invariant is a leverage point: once you know an invariant for a variable or structure, you can predict its behavior in many situations.
- **Two kinds of mistakes** (Section 21.4):
  1. **Treating too many things as important.** Unimportant things clutter the design, add complexity, and increase cognitive load. Symptoms: method arguments that are irrelevant to most callers; forcing every caller to make a choice that almost never matters (Java I/O's buffered/unbuffered distinction). Shallow classes are often the result of this mistake.
  2. **Failing to recognize that something is important.** Important information gets hidden, or important functionality is missing so developers continually recreate it. This impedes productivity and creates unknown unknowns.
- **Good taste**: the ability to distinguish what is important from what isn't. Ousterhout calls having good taste an important part of being a good software designer. The chapter's hypothesis-and-reflection loop (Section 21.1) is how that judgment is built through experience.

## Actionable principles

- **Look for leverage when deciding what matters.** Prefer the design element that solves many problems or explains many behaviors. Prefer a general-purpose interface (insert/delete ranges of characters) over a collection of special-purpose methods (`backspace`) because the general one provides leverage; at the interface level it doesn't matter *why* text is being deleted, only that it is.
- **Generate multiple options before choosing** ("design it twice"). It is much easier to judge what is most important when comparing alternatives. For a name: list candidate words related to the variable, then pick the few that convey the most information.
- **When unsure, form a hypothesis and commit.** If it isn't obvious what matters most (common for less experienced developers), state "I think this is what matters most," build under that assumption, and observe the outcome. If right, ask why and what clues predicted it; if wrong, ask what clues you missed. Either way you train your judgment — this is how good taste is built.
- **Minimize what matters** (Section 21.2). Make as little matter as possible; this produces simpler systems. Concretely:
  - Minimize the parameters required to construct an object, or supply defaults that reflect common usage.
  - For things that do matter, minimize the number of places where they matter. Information hidden inside a module doesn't matter to code outside it.
  - Handle an exception entirely at a low level so it stops mattering to the rest of the system.
  - Compute a configuration parameter automatically from system behavior instead of exposing it; then it no longer matters to administrators.
- **Emphasize what matters** (Section 21.3), using three tools:
  - **Prominence**: put important things where they will be seen — interface documentation, names, parameters of heavily used methods.
  - **Repetition**: let key ideas appear over and over.
  - **Centrality**: put the most important things at the heart of the system, where they determine the structure of what surrounds them (e.g., a device-driver interface in an OS, which hundreds or thousands of drivers depend on).
  - The converse is a diagnostic: if an idea is highly visible, recurs often, or shapes the system's structure, it matters — design accordingly.
- **De-emphasize what doesn't matter.** Hide it as much as possible, ensure it is not encountered frequently, and keep it from impacting the system's structure.
- **External constraints don't decide for you.** Sometimes importance is imposed externally (e.g., a hard performance requirement), but even then the designer must figure out what matters most in achieving that constraint — for performance, that meant structuring the critical path with as few method calls and special-case checks as possible while staying clean, simple, and obvious.

## Nuances and counterpoints

- Deciding what matters is mostly judgment, not rule-following. External constraints are the exception; usually the designer must determine importance, and there is no formula — hence the hypothesis-and-feedback loop for building taste.
- The two mistakes pull in opposite directions, so this principle can be overcorrected both ways: stripping the design so aggressively that important information becomes hidden or unavailable (mistake 2) is as harmful as cluttering interfaces with rarely relevant choices (mistake 1). Aim for the small set of things with real leverage, not the smallest possible set.
- The principle generalizes beyond code: in technical writing, identify a few key concepts up front, structure the document around them, and tie details back to them. As life philosophy: spend your energy on the few things that matter most to you.

## Red flags

The chapter has no boxed red flags; these are implicit warning signs it teaches:

- Method arguments that are irrelevant to most callers — a sign of treating too many things as important.
- Interfaces that force every caller to make a decision that almost never matters (e.g., Java I/O requiring an explicit choice between buffered and unbuffered streams when callers almost always want buffering).
- Shallow classes — often the result of treating too many things as important.
- Special-purpose methods that each solve a single problem where one general-purpose method would solve them all (low leverage).
- Important information hidden, or important functionality missing so developers repeatedly recreate it — leads to unknown unknowns.
- Many required constructor parameters with no defaults for common usage.
- Configuration knobs exposed to administrators that the system could compute automatically.
- Unimportant details that are highly visible, frequently encountered, or shaping system structure — emphasis spent on the wrong things.
