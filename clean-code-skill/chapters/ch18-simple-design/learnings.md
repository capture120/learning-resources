# Chapter 18: Simple Design

The best design is the simplest one that supports all required features while affording the greatest flexibility for change. Simple does not mean easy: simple means untangled, and untangling things is hard. The chapter centers on Kent Beck's four rules of simple design — covered by tests, reveals intent, minimizes duplication, minimizes size — applied in that strict priority order, plus the YAGNI discipline that guards against overdesign.

## Simple Means Untangled

The most expensive entanglements convolve high-level policies with low-level details: SQL mixed with HTML, frameworks fused with core values, report formatting tangled with the business rules that compute the values. These entanglements are easy to write but make features hard to add, bugs hard to fix, and the design hard to improve. A simple design is one in which high-level policies are ignorant of low-level details, so that changes to details have no impact on policy.

## Abstraction and the Dependency Inversion Principle (DIP)

Abstraction is "the amplification of the essential and the elimination of the irrelevant." One physical mechanism for this abstraction is polymorphism: high-level policies use polymorphic interfaces, and low-level details implement those interfaces. This points all source code dependencies from low-level details toward high-level policies, so details can change without touching policy. This is the essence of the Dependency Inversion Principle.

## YAGNI — "What if you aren't gonna need it?"

When tempted to add a speculative hook or generalization, ask what happens if you leave it out. If the cost of omitting it is tolerable, or the cost of carrying it year after year is high while the odds of needing it are low, you probably shouldn't add it. Thinking of the future is wise and some hooks are worth it — but count the costs on both sides. With a good test suite and refactoring skill, adding a feature later and reshaping the design to support it is usually cheaper than implementing and maintaining every hook you might one day need.

## Rule 1: Covered by Tests

The only reasonable coverage goal is 100% — anything less means you don't know whether part of your code works. Treat 100% as an asymptotic goal: you may never reach it (it may even be impractical in some situations), but get closer with every check-in. Martin testifies this is realistic: he has worked on projects that grew to many tens of thousands of lines while constantly holding coverage in the very high 90s. Coverage is the first rule of *design* because **testable code is decoupled code**: to test each part in isolation, each part must be decoupled enough to be invoked alone, so writing isolated tests is an act of design. A trusted, fast test suite also vastly reduces the fear of change, which is what makes the other three rules (all refactoring rules) practical at all.

## Rule 2: Reveals Intent (Maximize Expression)

Modern languages are expressive enough that, with discipline, code can read like "well-written prose" — deeply descriptive names for variables, functions, and types, with the structure of the algorithm easy to see. But expressiveness is not just naming: it also requires **separation of levels and exposition of the underlying abstraction**. Each line, function, and module should live in a well-defined partition that clearly depicts its level. Separating high-level policy from low-level detail is the most fundamental part of making a design simple and expressive.

### Tests: The Other Half of the Problem

Beck's original phrasing: "The system (code and tests) must communicate everything you want to communicate." Production code, however expressive, cannot communicate the context in which it is used — that is the job of tests. Well-written, isolated tests are example use cases demonstrating how the code is intended to be used. Code and tests together express what each element does and how it should be used, which serves design's primary goal: making the system easy for other programmers to understand, improve, and upgrade.

## Rule 3: Minimize Duplication

Duplication leads to fragility: similar stretches of code must often be modified together, finding them is hard, and modifying them correctly is harder because they live in different contexts. The default fix is to reduce similar stretches to a single instance — abstract the code into a function with arguments that communicate the contextual differences. When that doesn't work (e.g., duplicated traversal of a complex data structure), encapsulate the traversal in one place and pass the operations in via lambdas, Command objects, the Strategy pattern, or the Template Method pattern.

### Accidental Duplication

Not all duplication should be eliminated. Two stretches of code may be similar or even identical yet change for very different reasons — this is **accidental duplication**, and it should be allowed to persist; as requirements change the duplicates evolve separately and the duplication dissolves. The test: **real duplications have convergent intent; accidental duplications have divergent intent**. Telling them apart depends on how well the code expresses its intent, and eliminating the real ones requires refactoring backed by tests — which is why this rule comes third, after tests and expression.

## Rule 4: Minimize Size

A simple design is composed of as few simple elements as possible — and simple elements are small. Only after the tests pass, the code is as expressive as possible, and duplication is minimized should you work to decrease the number of modules, classes, functions, and lines. Never reduce size at the expense of test coverage or expression.

## The Four Rules and Other Design Principles

Beck claimed that following coverage, expression, singularization, and reduction diligently satisfies all other design principles. Martin is not sure that is literally true — he can't prove a perfectly covered, expressed, singularized, reduced program necessarily conforms to OCP or SRP — but he is certain that knowing and studying the principles of good design (e.g., SOLID) makes it much easier to create well-partitioned, simple designs.

## In practice

- Apply Beck's four rules in strict order: tests first, then expression, then deduplication, then size reduction.
- Before adding a hook, abstraction layer, or generalization "for later," ask: what if I'm not gonna need it? Weigh carrying cost against likelihood of need.
- Treat 100% test coverage as the asymptotic goal; improve coverage with every check-in rather than settling at a target like 80%.
- When code is hard to test, treat that as a design signal: decouple it until it can be tested in isolation.
- Keep high-level policy ignorant of low-level detail; use interfaces/polymorphism so dependencies point from details to policy (DIP).
- Make code read like prose with descriptive names, and make each module's level of abstraction obvious.
- Write isolated tests that double as example use cases of the code.
- Before deduplicating, check intent: convergent intent means extract a shared abstraction; divergent intent means leave the duplication alone.
- For duplicated structure traversal, encapsulate the traversal once and inject the varying operation (lambda, Command, Strategy, Template Method).
- After everything else is satisfied, actively shrink the code: fewer modules, classes, functions, lines.
