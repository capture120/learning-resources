# Chapter 18: Code Should be Obvious

## Central idea

Obscurity — important information about a system not being apparent to new developers — is one of the two main causes of complexity (the other is dependencies, Section 2.3). The cure is to write code so that it is obvious: a reader can read it quickly, without much thought, and their first guesses about its behavior and meaning will be correct. Nonobvious code forces readers to spend time and energy reconstructing missing information, which slows them down and breeds misunderstandings and bugs.

## Key concepts and definitions

- **Obvious code**: code a reader can understand from a quick read, where first guesses about behavior are correct. The reader doesn't need to gather extra information to work with the code. Obvious code needs fewer comments than nonobvious code.
- **Obviousness lives in the reader's mind, not the writer's**: it is far easier to notice that someone else's code is nonobvious than to see problems in your own. Therefore the authoritative test for obviousness is a code review. If a reader says your code is not obvious, it is not obvious — no matter how clear it seems to you. Investigate *what* confused them; that is how you learn to write better code.
- **Obviousness as information**: nonobvious code usually means the reader is missing a piece of information they need (e.g., that a constructor spawns threads, or what a pair's `getKey()` returns). Framing obscurity as "missing information" tells you exactly what the fix must supply.

## Principles and decision rules

### Things that make code more obvious

Ousterhout names the first two below as two of the *most important* techniques for making code obvious (both covered in earlier chapters); white space and comments are additional general-purpose techniques.

1. **Choose good names (Chapter 14).** Precise, meaningful names clarify behavior and reduce the need for documentation. A vague or ambiguous name forces readers to read the implementation to deduce what the entity means — time-consuming and error-prone.
2. **Be consistent (Chapter 17).** Do similar things in similar ways. Readers then recognize familiar patterns and draw safe conclusions immediately, without analyzing the code in detail.
3. **Use white space judiciously.**
   - Format documentation so its structure is visible: separate each parameter's description, indent continuation lines. Squeezed-together doc comments hide where one parameter ends and the next begins — readers can't even tell how many parameters exist.
   - Use blank lines to separate major blocks within a method. This works especially well when the first line after each blank line is a comment describing the next block: the blank lines make those comments more visible.
   - Use white space within statements (around operators, after semicolons) to clarify statement structure.
4. **Use comments to compensate when nonobvious code is unavoidable.** Sometimes you cannot make the code itself obvious. Then supply the missing information with comments. To do this well, put yourself in the reader's position: ask what is likely to confuse them and what information would clear up that confusion.

### Things that make code less obvious

Many things can make code nonobvious; the chapter gives only a few examples — treat the list as illustrative, not exhaustive. Some of these constructs are genuinely useful in certain situations, so you may use them anyway — when you do, add extra documentation to minimize reader confusion.

1. **Event-driven programming obscures control flow.** Handler functions are never invoked directly; the event module invokes them indirectly via function pointers or interfaces, and which handler runs depends on runtime registration. This makes it hard to follow the flow of control or convince yourself the code works. Compensate: in each handler's interface comment, state when (under what conditions) the handler is invoked.
2. **Avoid generic containers (`Pair`, `std::pair`, tuples) for passing grouped values.** They are tempting because they are easy to write, but the grouped elements get generic names (`getKey()`, `getValue()`) that obscure their meaning at every use site. Instead, define a small class or struct specialized for the purpose: its fields get meaningful names and its declaration can carry documentation, which a generic container cannot.
3. **Match the declared type to the allocated type.** Declaring a variable as a supertype (`List`) while allocating a subtype (`ArrayList`) is legal but misleads readers who see the declaration without the allocation. The concrete type can matter (performance, thread-safety properties), so the declaration should reflect it.
4. **Don't violate reader expectations — or document loudly when you must.** Code is most obvious when it conforms to conventions readers expect. If behavior departs from convention (e.g., an application that keeps running after `main` returns because a constructor spawned threads), document the surprise both at the source (the constructor's interface comment) and at the point of surprise (a short comment at the end of `main`).

### The governing rule

**Software should be designed for ease of reading, not ease of writing.** Generic containers and similar shortcuts are expedient for the person writing the code, but they create confusion for all the readers that follow. It is better for the writer to spend a few extra minutes (e.g., defining a specific container structure) so the resulting code is more obvious.

### Three ways to ensure readers have the information they need

To make code obvious, guarantee readers always have the information required to understand it, in this order of preference:

1. **Reduce the amount of information needed** — use design techniques such as abstraction and eliminating special cases.
2. **Leverage information readers already have** — follow conventions and conform to expectations, so readers need not learn anything new for your code.
3. **Present the needed information in the code itself** — with good names and strategic comments.

## Nuances and counterpoints

- Obviousness cannot be self-certified. Your own code always looks obvious to you because you already hold the missing information. Use code reviews as the measurement instrument and treat reader confusion as ground truth.
- Nonobvious constructs are not banned. Event-driven programming is useful and sometimes the right design; the rule is to recognize the obscurity cost and pay it down with documentation, not to avoid the technique entirely.
- Obvious code still benefits from comments — it just needs fewer of them. When the code can't carry all the needed information (and per Chapter 13, often it can't), comments are the designed mechanism for delivering it.

## Red flags

- **Nonobvious Code (explicit red flag box):** if the meaning and behavior of code cannot be understood with a quick reading, it is a red flag. Often this means important information is not immediately clear to someone reading the code.
- Implicit warning signs from the chapter:
  - A reviewer says the code isn't obvious (this alone settles the question).
  - Use of generic containers (`Pair`, tuples) to bundle values, exposing meaningless accessors like `getKey()`/`getValue()`.
  - A variable's declared type differs from its allocated type.
  - Code whose behavior departs from the conventions readers will assume, without prominent documentation of the departure.
  - Event handlers with no comment stating when they are invoked.
  - Doc comments or code blocks with whitespace squeezed out, hiding their structure.
