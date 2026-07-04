# Chapter 14: Choosing Names — Learnings

## Central idea

Names are a form of documentation: a good name tells the reader what an entity is (and what it is not) without consulting anything else — it reduces the need for other documentation and makes errors easier to detect — while a vague name creates ambiguities and false assumptions that produce bugs. Name choice is an instance of "complexity is incremental": one mediocre name barely matters, but a system has thousands of names, so consistently good naming has a large effect on complexity and manageability.

## Key concepts

- **Names create an image.** The goal of a name is to create an image in the reader's mind of the entity's nature. Test a candidate name with: "If someone sees this name in isolation — without its declaration, documentation, or surrounding code — how closely can they guess what it refers to? Is there another name that paints a clearer picture?"
- **Names are abstractions.** A name is a simplified way of thinking about a more complex underlying entity. Like all abstractions, the best names emphasize what is most important about the entity and omit less important details. Names become unwieldy past two or three words, so the challenge is finding the few words that capture what matters most.
- **The two properties of good names: precision and consistency.**
  - *Precision*: the name is specific enough that readers cannot mistake it for something else. The most common naming failure is being too generic or vague, which invites readers to assume the name means something different from reality.
  - *Consistency*: for each concept used repeatedly in a program, pick one name for that purpose and use it everywhere. Consistent naming reduces cognitive load the same way reusing a common class does — readers transfer knowledge from one context to another and make instant, safe assumptions.
- **Naming difficulty is a design signal.** If you cannot find a name that is precise, intuitive, and short, the underlying entity probably lacks a clear definition or purpose. The act of naming doubles as a design check.

## Actionable principles

- **Don't settle for "reasonably close" names.** Most developers grab the first roughly-matching name. Spend extra time to find names that are precise, unambiguous, and intuitive — the time pays for itself quickly (fewer bugs, less re-reading), and with practice good naming becomes nearly free. This is the investment mindset (Chapter 3) applied to names.
- **Prefer specific over generic when the name could plausibly mean several things.** `getCount()` → `numActiveIndexlets`; `x`/`y` for character positions → `charIndex`/`lineIndex`; `block` → `fileBlock`/`diskBlock`. A reader should be able to guess the meaning without reading the documentation.
- **Make boolean names predicates.** A boolean's name should make clear what true means. `blinkStatus` says nothing about what true/false means; `cursorVisible` does. As a general rule, boolean variable names should always be predicates.
- **Name special/sentinel values for their meaning, not their specialness.** `VOTED_FOR_SENTINEL_VALUE` says only that the value is special; `NOT_YET_VOTED` says what it means.
- **Reserve `result` for actual return values.** In a method with no return value, `result` is misleading and carries almost no information — name what the value actually is (`mergedLine`, `totalChars`). In a method that does return it, `result` is acceptable: still a bit generic, but readers know the value becomes the return value and can check the method docs.
- **When two related types/variables could be confused, choose names that distinguish them and clarify their relationship.** Linux's `struct socket` vs. `struct sock` are nearly indistinguishable; names like `sock_base` and `inet_sock` would be easy to tell apart and would express the subclass-like relationship.
- **Don't make names *too* specific either.** Precision can overshoot: a `delete(Range selection)` argument named `selection` falsely implies the text must be the current UI selection, when the method works on any range. Name it `range`. The name should match the entity's actual generality.
- **Generic loop variables are fine in small scopes.** `i` and `j` are acceptable when the loop spans only a few lines, because the entire usage range is visible and the meaning is obvious from the code. If the loop grows so long you can't see it all, or the variable's meaning is hard to infer, use a descriptive name. General rule (from Gerrand, which Ousterhout endorses): the greater the distance between a name's declaration and its uses, the longer the name should be.
- **Consistency has three requirements:** (1) always use the common name for the given purpose; (2) never use that name for anything else; (3) make sure the purpose is narrow enough that every variable with the name behaves the same way. Violating (3) caused the Sprite `block` bug: one name covered two behaviors (file blocks and disk blocks).
- **When several variables share the common concept, keep the common name and add distinguishing prefixes:** `srcFileBlock` and `dstFileBlock` for a copy operation.
- **Apply consistency to loop variables too:** if you use `i` and `j`, always use `i` for the outermost loop and `j` for nested loops, so readers can make instant safe assumptions.
- **Cut words that add no information.** Every word in a name must clarify meaning; the rest is clutter (and causes line wraps). Drop generic nouns like `Object` or `field` (`fileObject` → `file` — are there files that aren't objects?). Don't repeat the class name in instance variables (`fileBlock` inside class `File` → `block`, unless the class holds multiple blocks of different types).
- **Don't encode type information in names.** Styles like `filePtr` or Hungarian Notation (`arru8NumberList` = array of unsigned 8-bit ints; used for many years in C programming at Microsoft) are no longer worth it: modern IDEs jump to declarations or show types automatically. Ousterhout used to include type info and now recommends against it.
- **When naming gets hard, refactor.** If no precise, intuitive, short name exists, consider alternative factorings — e.g., one variable may be representing several things; splitting it into multiple variables can give each a simple definition. Naming difficulty is a tool for finding design weaknesses.
- **Prefer distinct types over distinct names when feasible.** Different names (`fileBlock` vs. `diskBlock`) would likely have prevented the Sprite bug; distinct types for the two kinds of blocks would be even better, making them impossible to interchange.

## Nuances and counterpoints

- **Disagreement with the Go style guide (short names).** Some Go developers argue names should be very short, often a single character; Andrew Gerrand claims "long names obscure what the code does" and shows a `RuneCount` function with `b`, `i`, `n` as more readable than a version with `buffer`, `index`, `count`. Ousterhout disagrees: he found the long-name version no harder to read, and `count` gave a better clue than `n`, which he had to puzzle out. He concedes that if `n` is used consistently system-wide for counts and nothing else, it will probably be clear. But Go culture also reuses the same short name for multiple different things (`ch` for character or channel; `d` for data, difference, or distance), which he expects to cause confusion and errors exactly like the `block` bug.
- **Readability is decided by readers, not writers.** If your short names draw no complaints from readers, fine; if readers say your code is cryptic, use longer names. (Web searches for "go language short names" turn up such complaints.) Symmetrically, if long names drew complaints, Ousterhout would consider shortening. Don't defend a naming style against the evidence of your actual readers.
- **Overcorrection warning: too-specific names mislead** just as too-generic names do (the `selection` vs. `range` example). Precision means matching the entity, not maximizing detail.
- **Names have a hard length budget.** More than two or three words makes a name unwieldy; pick the few words that capture what's most important and accept that secondary information (e.g., *why* the cursor blinks, dropped when `blinkStatus` became `cursorVisible`) moves to documentation.
- **The payoff compounds.** Well-chosen names make code obvious: a reader's first unthinking guess about a variable's behavior is correct. Naming skill itself is an investment — frustrating and slow at first, nearly free with experience.

## Red flags

- **Vague Name (explicit red flag).** If a variable or method name is broad enough to refer to many different things, it conveys little information to the developer, and the underlying entity is more likely to be misused.
- **Hard to Pick Name (explicit red flag).** If it's hard to find a simple name that creates a clear image of the underlying object, that hints the object itself may not have a clean design.
- *Implicit:* a boolean whose name doesn't tell you what true means (`blinkStatus`).
- *Implicit:* the same name used for entities with different behaviors (`block` for both disk and file block numbers), or near-identical names for distinct types (`socket` vs. `sock`).
- *Implicit:* `result` in a method that returns nothing.
- *Implicit:* names padded with information-free words (`fileObject`, class name repeated in members) or with type encodings (`filePtr`, Hungarian Notation).
- *Implicit:* a generic name like `i` whose declaration is far from its uses.
