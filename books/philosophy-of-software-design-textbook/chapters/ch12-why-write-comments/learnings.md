# Chapter 12: Why Write Comments? The Four Excuses

## Central idea

Comments are essential to software design, not an afterthought: without them you cannot hide complexity, because code alone cannot express a complete abstraction. The overall purpose of comments is to capture information that was in the mind of the designer but couldn't be represented in the code. Done correctly, the process of writing comments actually improves a system's design, and a good design loses much of its value if poorly documented.

The stakes are real: a significant fraction of production code contains essentially no comments — some developers think comments are a waste of time, others see the value but never get around to writing them — and inadequate documentation creates a huge and unnecessary drag on software development. Ousterhout aims to convince you of three things: good comments make a big difference in the overall quality of software; it isn't hard to write good comments; and (hard to believe) writing comments can actually be fun.

## Key concepts

- **The four excuses.** Developers who skip comments justify it with one or more of: (1) "Good code is self-documenting," (2) "I don't have time to write comments," (3) "Comments get out of date and become misleading," (4) "All the comments I have seen are worthless; why bother?" Each excuse fails under scrutiny; the fourth probably has the most merit, and it is solvable by learning to write good comments.

- **Comments complete abstractions.** An abstraction is a simplified view that preserves essential information while omitting ignorable detail. A method's declaration (name, argument names and types, result type) is too thin to be a useful abstraction by itself. Comments capture the additional information callers need (semantics, edge cases, rationale), completing the simplified view while hiding implementation details. **If users must read the code of a method in order to use it, then there is no abstraction**: all the method's complexity is exposed.

- **What code cannot express.** Significant design information cannot be represented in code: high-level descriptions of what a method does, the meaning of its result, the rationale for a design decision, and the conditions under which it makes sense to call a method. Only the informal medium of comments can carry this.

- **Why human language matters.** Comments are written in English (or another natural language), which makes them less precise than code but far more expressive. That expressive power lets you create simple, intuitive descriptions — exactly what abstractions need.

- **Comments and the symptoms of complexity.** Of the three manifestations of complexity from Chapter 2 (change amplification, cognitive load, unknown unknowns), good documentation directly attacks the last two. It reduces cognitive load by giving developers the information they need and letting them ignore what is irrelevant; it reduces unknown unknowns by clarifying system structure so it's clear what code and information matter for a given change. It also targets complexity's root causes: documentation clarifies dependencies and fills gaps to eliminate obscurity.

## Actionable principles and decision rules

- **Reject "self-documenting code" as a complete strategy.** Good names and structure reduce the need for comments but cannot eliminate it, because informal interface information (semantics, rationale, preconditions) has no representation in code. Write comments for everything code cannot say.

- **Don't design for "just read the implementation."** If you expect callers to read method bodies, you'll be pushed toward making every method tiny, producing many shallow methods. That doesn't actually help readability: to understand the top-level method, readers must still understand all the nested ones. For large systems, reading code to learn behavior is impractical. Write interface comments so reading the body is unnecessary.

- **Apply the investment mindset to documentation.** Projects are always under time pressure, so something will always seem higher priority than comments; if you let documentation be de-prioritized, you'll end up with none. Treat comments as up-front investment that pays back in maintainability.

- **The cost is bounded and small.** Typing code is rarely more than ~10% of development time; even spending equal time typing comments adds at most ~10% to development time. The payoff in maintainability quickly offsets this.

- **Write abstraction comments during design, not after.** The most important comments document abstractions (class and method interfaces). Written as part of the design process, the act of writing them is itself a design tool that improves the design — those comments pay for themselves immediately (developed further in Chapter 15).

- **Keep comments fresh with cheap mechanics, not heroics.** Stale comments need not be a major problem: large documentation changes are only needed when there are large code changes, and the code changes dominate the cost. Avoid duplicated documentation, keep documentation close to the corresponding code (Chapter 16), and use code reviews to detect and fix stale comments.

- **Comment for the future reader — including yourself.** Without documentation, future developers must rederive or guess the original designer's knowledge, which is slow and risks bugs from misunderstanding intent. This applies to the original author too: after a few weeks away from code, you forget the details of your own design.

- **Document low-level and high-level information alike.** Useful comment content ranges from low-level details (e.g., a hardware quirk motivating tricky code) up to high-level concepts (the rationale for a class).

## Nuances and counterpoints

- **The excuse with the most merit.** "All comments I've seen are worthless" is partially true — most existing documentation is mediocre, often because comments are treated as drudge work and developers don't know how to write them. The fix is skill, not abandonment: writing solid documentation is not hard once you know how (Chapters 13+).

- **Disagreement with Clean Code (Robert Martin).** Martin holds that comments are "at best, a necessary evil" and "always failures" — compensation for our inability to express ourselves in code. Ousterhout agrees good design reduces the need for comments (particularly in method bodies) but rejects the failure framing: comments carry information that is qualitatively different from code and cannot be represented in code today; code and comments are each suited to what they represent. Even if comment information could be moved into code, it's unclear that would be an improvement.

- **Against replacing comments with method extraction.** Martin's substitute — pull a code block into a separate, comment-free method whose name serves as the comment — yields long, cryptic names like `isLeastRelevantMultipleOfNextLargerPrimeFactor` that carry less information than a well-written comment. Worse, callers effectively retype the method's documentation at every invocation site.

- **The cultural harm of "comments are failures."** This philosophy encourages programmers to avoid comments so as not to seem like failures, and can subject good designers to false criticism ("What's wrong with your code that it requires comments?"). Well-written comments are not failures: they increase the value of code and play a fundamental role in defining abstractions and managing system complexity.

- **One purpose of comments is to make reading code unnecessary.** A short interface comment should give a developer everything needed to invoke a method without reading its body. Martin takes the opposite tack; Ousterhout's position is that hiding the body is the point.

## Red flags

Ousterhout marks no boxed red flags in this chapter, but it teaches these implicit warning signs:

- **Excuse-driven omission.** Hearing (or thinking) any of the four excuses — "self-documenting," "no time," "they'll go stale," "comments are worthless" — as justification for skipping documentation.
- **Interfaces understandable only by reading the implementation.** If callers must read a method's body to use it, there is no abstraction.
- **Declaration-only documentation.** Relying on a signature alone (e.g., `substring(start, end)` — is `end` inclusive? what if `start > end`?) leaves callers guessing at semantics.
- **Many shallow methods produced to avoid comments.** Splitting code into tiny methods so each "reads easily" forces readers to traverse all of them anyway.
- **Long cryptic method names standing in for comments** (the `isLeastRelevantMultipleOf...` pattern): less informative than a comment and re-typed at every call site.
- **Documentation perpetually de-prioritized.** A team where comments always lose to "higher priority" work will end up with no documentation.
- **Duplicated or far-from-code documentation.** Structural choices that make comments expensive to keep current.
- **A culture that treats comments as failures or drudge work** — it produces mediocre documentation and shames good designers.
