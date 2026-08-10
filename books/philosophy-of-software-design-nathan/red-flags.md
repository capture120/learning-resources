# Summary of Red Flags

From *A Philosophy of Software Design* (2nd ed.), John Ousterhout. Any of these symptoms suggests a design problem. Order follows the book.

1. **Shallow Module** — A class or method's interface isn't much simpler than its implementation, so it adds interface cost without hiding meaningful complexity.

2. **Information Leakage** — The same design decision is reflected in multiple modules, so changing it requires coordinated edits across all of them.

3. **Temporal Decomposition** — Code structure mirrors the order in which operations execute rather than grouping by information hiding, scattering knowledge of one decision across sequential steps.

4. **Overexposure** — An API forces callers to learn about rarely used features just to use the common ones, taxing every caller for edge cases.

5. **Pass-Through Method** — A method does almost nothing except forward its arguments to another method with a similar signature, signaling muddy class responsibilities and shallow layering.

6. **Repetition** — A nontrivial snippet of code appears over and over, indicating a missing abstraction that should capture it once.

7. **Special-General Mixture** — Special-purpose code is tangled into a general-purpose mechanism, leaking upper-layer details downward and making the general code harder to reuse.

8. **Conjoined Methods** — Two methods are so interdependent that you can't understand one's implementation without reading the other's; they should be separable or merged.

9. **Comment Repeats Code** — A comment conveys nothing beyond what's immediately obvious from the adjacent code, adding clutter instead of information.

10. **Implementation Documentation Contaminates Interface** — An interface comment describes implementation details users don't need, breaking the abstraction and bloating what callers must read.

11. **Vague Name** — A variable or method name is so imprecise that it conveys little useful information, hinting the underlying design or purpose may itself be unclear.

12. **Hard to Pick Name** — You can't find a precise, intuitive name for an entity, which usually means the entity's design is muddled (it does too much or lacks a clean identity).

13. **Hard to Describe** — Completely documenting a variable or method requires a long comment, suggesting its interface is too complex and needs a simpler design.

14. **Nonobvious Code** — The behavior or meaning of a piece of code can't be understood easily, forcing readers into slow, error-prone deduction; restructure or document it.
