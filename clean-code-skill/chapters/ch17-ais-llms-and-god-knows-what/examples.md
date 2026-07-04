# Chapter 17 Examples

## The history of abstraction leaps and doom predictions
Martin opens with Grace Hopper's first code in the late 1940s: rows of holes punched in paper tape, each row one instruction for the Harvard Mark I (e.g., "Add Register 10 to Register 12"). Within a few years it became clear that a program could generate such codes from abstract text like `add 10, 12` — Hopper called this *automatic programming*. From there: Fortran (`a = b + c`), Algol, Simula-67, C, Smalltalk, C++, Java/C#, Ruby/Python, Clojure. Productivity gains shrank at each step — Fortran was shown to be 45x machine code; C probably doubled Fortran; later languages likely added roughly 10–20% each. At *every* transition, books predicted programming's doom and that programmers would go extinct like dodo birds; every time, demand for programmers grew instead. Martin's explanation for the recurring panic: each time programming got easier, those invested in the current complexity feared the unwashed masses would take their jobs, and so predicted the profession's doom. Lesson: AI is the same pattern — another abstraction increase, another wave of unfounded extinction panic.

## The Markov-walk prompt to Grok (the "horrible prompt")
Martin gives Grok (Grok 3 beta, March 2025) a natural-language prompt: find all sentences in a file containing a substring, pick one at random, take the word following the substring (or "." if none), append it, slide a three-word window, repeat until hitting a period or 50 words, then return the accumulated text. Grok produces a working-after-a-fashion Clojure program — impressive at first glance.

But Martin dissects the prompt itself: it never defines *sentence* or *word*, "the found word" is ambiguous, it's unclear whether dots are punctuation or nouns, and "accumulate" is vague. The generated program makes "lots of dumb little mistakes" traceable directly to those ambiguities — a sample run against the book's own manuscript emits output with mysterious double spaces. Lesson: the danger is not the AI's power but the imprecision of natural-language specification; the LLM resolves every ambiguity invisibly and plausibly.

## Patching the prompt and the regeneration problem
To fix the double spaces, Martin adds one clarifying line:

```
Make sure all accumulated words are separated by just one space.
```

He flags two problems. First, he never diagnosed *why* the double spaces appeared, so the line is a patch on a symptom. Second, he can't be sure "all accumulated words" binds to the return value. And testing the change exposes a deeper issue: Grok regenerates the entire program from scratch rather than modifying the existing one. The two programs "look like they were written by two different programmers" — different function names (`sentence-walk` becomes `walk-sentences`), different parsing strategy. It fixes the double spaces but introduces a new bug at sentence ends and handles case badly. Lesson: with a statistical, fuzzy generator, every prompt edit risks reinterpreting *everything*; nothing guarantees the old behavior survives regeneration.

## The SWAG: a formal, overloaded prompt language
Martin sketches his "Scientific Wild-Axx Guess" at the future: a prompt formalism combining explicit definitions and constraints with BDD-style Given-When-Then scenarios. He tries it on a simpler problem, noting it looks uncomfortably like COBOL:

```
Language: Clojure
Name: Markov
Definitions:
  Word: A string of alphabetic characters.
  Sentence: One or more words separated by spaces and ending with
  a period, question mark, or exclamation mark.
Constraints:
  Ignore case in all comparisons.
Description:
  Find all sentences in f that contain s.
  Choose a sentence c at random with equal probability.
  Return the word in c that immediately follows s;
    if none return a period.

Scenarios to be tested with speclj:
Given f contains [sample lines with "hello there Bob/Bill/John"...]
When s is "hello"        Then return "there"
When s is "are well"     Then return "."
When s is "hello there"  Then return "Bob", "Bill", or "John".
  Assert a uniform distribution after 100 iterations.
```

Grok happily generates both the implementation and speclj tests from the scenarios. Lesson anchor: this is what "overloading" a specification looks like — the formal description and the test scenarios state the same intent two ways, so each checks the other (the same strategy as double-entry bookkeeping and the testing disciplines of earlier chapters).

## Grok's tests fail against Grok's own code
The punchline: the tests Grok wrote from the scenarios do not pass against the code Grok wrote from the same prompt. Three failures — searching "hello" returns "." instead of "there"; "are well" returns "i" instead of "."; the distribution test finds 1 name instead of 3. Debugging shows Grok apparently ignored the prompt's own definition of "word" and did not properly interpret the case-insensitivity constraint.

Martin draws two lessons. First, this drives home how important it is to overload prompts with test scenarios. Second, it exposes the core limitation: the model could *write* the tests but could not *use* them to infer the required behavior. LLMs work by probability, not real-time inference, and "if LLMs do not actively infer, then LLMs do not reason." You can debug code; you cannot reliably debug a prompt, and even a "fixed" prompt may not generate passing code twice in a row.

## Closing prophecy: programmers as the lawyers of AI
Not an example so much as the chapter's resolution: Martin expects LLMs to eventually consume long formal specifications, and expects programmers to design those formal, overloaded specification languages. Programmers will supply the reasoning AIs lack — becoming "the lawyers of AI," drawing up precise, accurate formal requirements and contracts for clients, as they always have.
