# Chapter 12 Examples: Why Write Comments? The Four Excuses

This chapter is mostly argumentative rather than case-study-driven, but it works through several concrete illustrations.

## The substring method: a declaration is not an abstraction

**Design problem.** Suppose a method extracts a substring and takes two arguments, `start` and `end`, indicating the range of characters to extract:

```
substring(start, end)
```

**Why the code alone fails.** From the declaration alone — name, argument names, types — a caller cannot tell whether the extracted substring includes the character at `end` (inclusive vs. exclusive), or what happens if `start > end`. The declaration is missing too much essential information to serve as a useful abstraction by itself.

**The good approach.** An interface comment captures the additional information callers need (inclusivity, edge-case behavior), completing the simplified view while keeping implementation details hidden.

**Principle demonstrated.** Comments are fundamental to abstraction. Without them, the only abstraction of a method is its declaration, which is too thin; if users must read the code to use the method, there is no abstraction at all.

## "Just read the code" and the cascade of shallow methods

**Design problem.** Some developers argue that anyone wanting to know what a method does should read its implementation — that's more accurate than any comment.

**The bad approach and its consequences.** A reader could in principle deduce a method's abstract interface from its code, but it would be time-consuming and painful. Worse, designing code on the assumption that users will read implementations pushes you to make every method as short as possible: anything nontrivial gets broken into several smaller methods, producing a large number of shallow methods. This doesn't actually make code easier to read — to understand the top-level method, readers must understand the behavior of all the nested methods too. For large systems, learning behavior by reading code is simply impractical.

**Principle demonstrated.** "Good code is self-documenting" is a myth ("like a rumor that ice cream is good for your health"). Interface comments exist precisely so that reading the implementation is unnecessary.

## The 10% time-budget argument

**Design problem.** Developers claim they don't have time to write comments; given a choice between a new feature and documenting an existing one, the feature seems to win — and under constant time pressure, something will always outrank documentation, so deferring it means never doing it.

**The counter-calculation.** Ask how much of your development time is spent literally typing code (versus designing, compiling, testing): probably no more than 10%. Even if you spent as much time typing comments as typing code — a safe upper bound — good comments add at most about 10% to total development time. The maintainability benefits quickly offset this cost. Moreover, the most important comments (top-level class and method documentation) should be written during design, where the act of writing them improves the design and pays for itself immediately.

**Principle demonstrated.** The investment mindset applied to documentation: small up-front cost, fast payback.

## Clean Code's `isLeastRelevantMultipleOfNextLargerPrimeFactor`

**The opposing school.** In *Clean Code*, Robert Martin writes that comments are "at best, a necessary evil" and "always failures" — needed only because we fail to express ourselves in code. He advocates replacing comments with code: instead of commenting a block inside a method, pull the block out into a separate comment-free method and let the method's name serve as the comment.

**Why the approach fails.** This produces long names like `isLeastRelevantMultipleOfNextLargerPrimeFactor`. Even with all those words, such names are cryptic and provide less information than a well-written comment would. And developers end up effectively retyping the method's documentation every time they invoke it, since the name is the documentation.

**The deeper harm.** Ousterhout worries Martin's philosophy breeds a bad attitude: programmers avoid comments so as not to seem like failures, and good designers face false criticism ("What's wrong with your code that it requires comments?").

**Principle demonstrated.** Comments carry information qualitatively different from what code can express; well-written comments are not failures but increase the value of code and are fundamental to defining abstractions and managing complexity. Good design reduces the need for comments (especially in method bodies) but cannot replace interface comments.
