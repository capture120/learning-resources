# Chapter 13: Clean Classes

The chapter (by Jeff Langr) scales the advice of "Clean Functions" up one level: group small, discrete concepts into small, cohesive, well-named classes (or modules), each with one reason to change. Class quality is only truly revealed by change — clean class design exists to keep the cost of adding features flat as a system grows and ages.

## Classes/modules versus files
Generally stick to one class or module per source file, even when your language allows more. It creates fewer headaches for you and your team. Exceptions exist (everything in software is a trade-off): very closely related types like small structs/records or exception types may live in the same file — perhaps they're consumed only by other types in that file, or always appear in client code alongside the file's primary type. File deployment matters less than how concepts are grouped.

## Why organize into classes at all
Without sensible organization, you'll struggle to find code, bloat the system with redundancy (doubling its size is a likely possibility), create defects from inconsistent duplicated behavior and rising complexity, and spend excessive time on tests. "Clean" is not an insult — "unclean" simply characterizes code that demands more effort from the average developer to understand or maintain. Translate "clean class design" to "doing all the things that should make our development lives easier."

## Design is judged by change
The quality of a design can only truly be assessed in the face of change. Ask: is it getting costlier to add features as the system ages? Are defects increasing? Seven decades of experience — from von Neumann/Goldstine's subroutine premise (1947) to EDSAC (1951) onward — back the bet that modularization lowers the cost of software development.

## Design perspectives: heuristics and characteristics
Codified guidance comes in four flavors, collectively called "design perspectives":
- **Positive heuristics** (steps to take): Kent Beck's four rules of emergent design — keep all code testable, eliminate logical redundancies, name everything clearly and concisely, minimize the number of elements.
- **Negative heuristics** (steps to avoid): antipatterns, e.g. copy-paste programming — don't habitually create new logic by duplicating existing code and tweaking it.
- **Positive characteristics** (desired traits): the SOLID class-design principles, which apply to functional code too.
- **Negative characteristics** (undesired traits): Martin Fowler's code smells, e.g. shotgun surgery — simple changes forcing updates to numerous classes.

The major perspectives (SOLID, simple design, code smells) overlap and all foster small, cohesive modules and functions — choose the perspective(s) you like, and focus on the outcome: code that's easy to maintain. Virtually no principle is absolute: Beck's rule 4 (minimize elements) warns you can over-fragment into tiny classes that add nothing. Most systems have erred far in the *opposite* direction, so this rarely needs worrying about — but remember every choice trades off something.

## The ideal class: small, cohesive, single-responsibility
An ideally sized class is small; its name concisely summarizes the few behaviors inside; its methods are closely related and focused, performing a single well-defined task (or set of related tasks) effectively. That gives it the Single Responsibility Principle (SRP) characteristic: **one reason to change**. Single-responsibility classes are easier to locate by name, genuinely reusable, more likely to satisfy the Open–Closed Principle, easier to test, and make the system more flexible. Tiny classes with one to three methods are fine ("Just do it" — creating a new class takes moments in an IDE and has few downsides); only an extreme "ravioli" of one-method-everything classes goes too far.

## Don't speculate about the nexus of change
The SRP tells you to be picky, but not to guess where change will come from. Your system probably rampantly violates the SRP — don't go hunting for code to fix. Wait for the next demand for change, then use that opportunity to reshape the code toward compliance. Speculative cleanup creates unnecessary risk from improvements no one yet needs.

## Reasons to change hide inside method bodies
The public interface (or a UML view) won't show all SRP violations; you must read the code. Change reasons often lurk in single lines of implementation detail buried in long methods — e.g. an inline conditional encoding a business policy. Such detail slows readers, who must mentally assemble it into a concept.

## Extract, then move: comments become method names
If you feel you need a comment to guide readers through a line or five of code, consider extracting those lines into a method — the guiding comment often provides the basis for the method's name. A clear, concise method name obviates the comment. "Comments are the distracting footnotes of code." Predicates are particularly ripe for extraction: complex conditionals like `if (x(a) && y || !z(c, d))` don't say *why* you're branching; an extracted predicate's name can impart immediate understanding — and understanding the paths through a long, daunting method is one of the best first steps you can take toward grasping it. ("Extract till you drop!")

## Feature envy: move methods to the data they interrogate
After extraction, watch for the feature envy code smell: a method that asks another class multiple questions to compute a result, while ignoring its own class. Move it to the class it envies, where it can talk directly to its peers. Then re-examine the destination: does *it* now have too many reasons to change? Keep asking these questions with every change — this is continuous design. Moving a problem isn't passing the buck: you removed a reason to change from the source class and replaced detail with an abstraction.

## The Open–Closed Principle: seek to close classes
Minimize "opening up" existing classes to make changes; instead enhance the system by adding new, single-purpose classes (the OCP). Open classes introduce risk and cost — every edit risks breaking existing behavior. Closed classes go "out of sight, out of mind": less code you must concern yourself with. A switch statement over a type enum is a classic open spot with multiple reasons to change (new types, new schemes, new rates).

## Prefactor when change arrives, using pluggable patterns
When a real new requirement lands, first factor ("prefactor") the code so the change effort is smooth and low-impact — e.g. extract each switch-branch calculation into a Strategy class behind a common interface, then let the type carry its own strategy. Future variants become a new small class plus one registration line — and with configuration externalized (e.g. a database), no existing class changes at all. Prefer the simple mechanism; don't add Singletons or reflection — "why make things more complicated?"

## Don't mix policy with implementation detail
A well-defined SRP-compliant service should either contain *only* orchestration logic that declares policy and delegates specifics to other classes, or *only* implementation specifics for related domain/utility behaviors. Mixing them is costlier to understand, navigate, and maintain — a policy change and a step's implementation change are two different reasons to change.

## SRP and OCP are ideals, not destinations
Taken to the extreme (every route, every conditional branch, every workflow step its own class), a fully SRP/OCP-compliant "plug and play" system isn't ridiculous — all new behavior arrives by dropping in a new, easily tested class. It's initially disorienting to newcomers but dramatically streamlines change long term (Smalltalk systems approached this 30 years ago: most methods one to three lines; "life was bliss"). Treat SRP and OCP as directions: almost always move toward them; it may be fine never to arrive. Forgive your system's existing flaws, but assess every change — how many classes did you have to open? — and expend at least some effort moving the system toward extension over modification.

## Simpler testing: small closed units document themselves
Retaining and extending the larger service's existing tests is one acceptable route; alternatively, distribute the testing: extracted, closed policy classes can be tested directly in isolation, even though they were "private behavior" of the larger service — they're reusable "sub-behavioral units" a different client could consume. Clean, focused unit tests are better documentation than doc comments: you can trust them while they pass, and they show exactly how to use the class. Test outcomes of small behavioral concepts, not implementation details. **Corollary:** if an extracted class isn't useful in any other context, don't make it public — test it indirectly through higher-level tests, and test private details directly only as a last resort.

## Enter AI: clean design is how you steer code generators
LLMs generate roughly 80%-correct code at the class level. Help them by providing examples and a simple style: small single-purpose classes and functions, more-functional solutions with less state and fewer side effects, and an emphasis on clarity — exactly the style we've been told to write all along. Because AI *will* be wrong, comprehensive testing for behavioral intent is essential: have it generate tests from your examples, vet the tests for fidelity, run them. Clean SRP design makes fixing AI mistakes easier (pinpoint one small class; sometimes extract a "method object" — a class embodying one troubled method) and makes whole-module regeneration practical: update the examples, regenerate tests and code, drop it in. As AI generates at the modular level, human focus shifts to architecture — pluggable designs via patterns like Strategy, Command, Factory, Decorator, Composite, Chain of Responsibility, Bridge, and Functional Pipeline. Clean code at the line level stays important only for the near future: ultimately the contents of any well-composed function are irrelevant once we generate wholesale modules, and at some point AI will implement an entire system from a set of examples/tests — the durable human role is designing and delivering a system as an orchestration of well-tested, AI-implemented pieces.

## In practice
- Keep one class/module per file unless tiny, tightly coupled helper types justify co-location.
- When adding behavior, prefer creating a new small class over growing an existing one; don't resist "New Class."
- Check each class: does its name summarize its few behaviors? Does it have exactly one reason to change?
- Don't refactor speculatively toward SRP/OCP; reshape code when a real change request touches it (and prefactor before implementing the change).
- Replace guiding comments with extracted, well-named methods; extract complex predicates first.
- When an extracted method mostly interrogates another class, move it there (fix feature envy), then re-evaluate its new home.
- Replace type-switching conditionals with Strategy/polymorphic dispatch when they accumulate reasons to change.
- Keep orchestration (policy) classes free of implementation detail, and detail classes free of policy.
- After each change, count how many existing classes you opened; aim for designs where new features are new classes.
- Test small extracted classes directly only if they're genuinely reusable/public; otherwise keep them private and test through higher levels.
- When using AI to generate code, supply examples plus a small-class/small-function low-side-effect style, and always vet and run generated tests.
