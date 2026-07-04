# Summary of Design Principles

From *A Philosophy of Software Design* (2nd ed.), John Ousterhout. Numbering follows the book.

1. **Sweat the small stuff — complexity is incremental.** Complexity accumulates from many small decisions, not one big mistake; no single shortcut seems harmful, so you must hold the line on every one.

2. **Don't stop at working code.** Code that merely works ("tactical programming") leaves behind complexity; invest in a clean design, not just a passing test.

3. **Make continual small investments to improve system design.** Spend a steady fraction of development time (roughly 10-20%) on design improvements; the payoff compounds and quickly outruns the upfront cost.

4. **Make modules deep.** A module should hide a lot of functionality behind a small, simple interface; depth maximizes benefit (functionality) while minimizing cost (interface complexity).

5. **Design interfaces to make the most common usage as simple as possible.** Optimize for the frequent case; rare or advanced cases can be harder to invoke, but everyday callers shouldn't pay for them.

6. **Prefer a simple interface over a simple implementation.** A module's complexity should be absorbed internally rather than exported; many callers face the interface, but only one implementer faces the internals.

7. **Make modules somewhat general-purpose.** A slightly more general module is usually simpler and deeper than one tailored to today's exact need, and it serves future uses without modification.

8. **Separate general-purpose and special-purpose code.** Keep mechanism (general) apart from policy (special-case); mixing them leaks information and shallows out both halves.

9. **Give different layers different abstractions.** If adjacent layers have similar abstractions, the layering adds complexity without adding value (e.g., pass-through methods).

10. **Pull complexity downward.** It's better for a module's implementer to suffer than its many users; handle hard cases internally instead of pushing them to callers via configuration or exceptions.

11. **Define errors out of existence.** Redesign APIs so error cases simply can't occur (or are handled as normal behavior); exception handling is a major source of complexity.

12. **Design it twice.** Sketch at least two distinct designs for any major decision and compare them; your first idea is rarely the best, and the comparison sharpens your sense of what matters.

13. **Write comments that describe what isn't obvious from the code.** Comments should add precision (low-level detail) or intuition (high-level rationale) the code itself can't express; restating code is worthless.

14. **Design software for ease of reading, not ease of writing.** Code is read far more often than it's written; never save writing time with a shortcut (vague names, clever tricks) that costs every future reader.

15. **Make the increments of development abstractions, not features.** When you need a new capability, build the clean abstraction it implies rather than bolting the feature on; abstractions accumulate into a better system.

16. **Separate what matters from what doesn't, and emphasize what matters.** Good design (and good code formatting, naming, and documentation) makes the important things prominent and hides or downplays the rest.
