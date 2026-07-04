# Chapter 17: AIs, LLMs, and God Knows What

AI code generation is just the next rise in language abstraction, not the end of programming. Like every prior leap (machine code to Fortran to OO languages), it will raise productivity and demand for programmers — but only once we replace ambiguous natural-language prompts with precise, overloaded, verifiable specifications. The programmer's enduring job is to supply the reasoning and formality that LLMs lack.

## AI is another abstraction leap, not extinction
Treat AI as one more step away from Grace Hopper's holes in the paper tape. Every prior abstraction increase (Fortran, C, C++, Java, Ruby/Python, Clojure) triggered predictions that programming was doomed, and every time the opposite happened: projects and demand for programmers grew. Martin's verdict on "programming is dead": "Baloney!" Also note the diminishing returns: Fortran was shown to be a 45x productivity leap over machine code; C probably doubled Fortran; each later language likely added only ~10–20%.

## "Programming by Prompt" is in its infancy
We do not yet know how to use this technology well — exactly like the early bumbling years of Java applets, Ruby, and Python. Expect mistakes, and don't mistake current clumsy practice (one-shot natural-language prompts) for the mature discipline that will emerge. To program large systems by prompt we will need AI tools that allow **incremental changes** and ways to **eliminate ambiguity** in prompts.

## Natural-language prompts are dangerously ambiguous
An impressive-looking generated program is not a production-ready one. The terror is not the AI's power but "the structure of that horrible prompt": undefined terms (what is a *sentence*? a *word*?), ambiguous references ("the found word"), unstated constraints. The LLM fills the gaps plausibly, producing code with "lots of dumb little mistakes" rooted in those ambiguities. Be impressed and terrified at the same time.

## Don't patch symptoms in the prompt
Adding a clarifying sentence to a prompt to fix an observed bug is just patching a symptom when you haven't diagnosed the cause. Worse: you can't be sure the new phrasing binds to what you intend ("am I sure that the clause *all accumulated words* will properly refer to the return value?"). Debug understanding first; you cannot reliably "debug the prompt."

## Regeneration is not modification
Each prompt change makes the LLM regenerate the whole program from scratch rather than modify the existing one. Two runs of nearly the same prompt yield programs that "look like they were written by two different programmers," with different interpretations of the same ambiguous terms. Given the statistical, fuzzy nature of LLMs, regeneration can silently break what previously worked — there is no stability guarantee across runs.

## We need a formal prompt language
Programming is formal. To say precisely what we mean, prompts must become a formalism: unambiguous, precise, immune to misinterpretation by a statistical algorithm. Martin's sketch ("A SWAG" — Scientific Wild-Axx Guess): a prompt language with explicit **Definitions**, **Constraints**, and a **Description**, overloaded by BDD-style **Given-When-Then** test scenarios. He notes wryly that it looks like COBOL — "That similarity might give us pause."

## Overloading: say your intent at least two ways
Even a perfectly precise language lets you precisely say something wrong. To "mean what we say," state intent in at least two different forms so an error in either statement is detected by the other. This **overloading** is the same strategy behind double-entry bookkeeping and the testing disciplines described in earlier chapters. "It would be supremely irresponsible to trust a single set of precise statements written by a human if those statements aren't overloaded." Specification + executable tests = the minimum responsible pairing. We also need a way to **quickly verify consistency** between the two. Martin: "It seems obvious, at least to me, that without overloaded formality, the prospect of using AIs to write our systems is doomed to spectacular failure. After all, programming is formal, and humans require overloading."

## LLMs do not reason
LLMs are statistical: they produce responses through probability, not inference. Many inferences are baked into the trained model, but prompt evaluation does not infer in real time — and "inference is the primary operation of reason. If LLMs do not actively infer, then LLMs do not reason!" Evidence: Grok wrote tests from the scenarios yet generated code that failed them; debugging showed it apparently ignored the prompt's own definition of "word" and did not properly interpret its case-insensitivity constraint. Never assume the model has understood your constraints just because it can restate them.

## Programmers as the lawyers of AI
The endgame: AIs will eventually handle long formal specifications, and programmers will design the formal, overloaded specification languages they consume. The humans who learn and apply those formalisms — who supply the reasoning AIs lack and draw up "the precise and accurate formal requirements and contracts" for clients — are programmers. The responsibility doesn't move; the medium does.

## In practice
- Treat AI-generated code as unverified draft work, never production-ready output; review and test it as skeptically as code from an unknown contractor.
- Before prompting, define your terms (what exactly is a "word," a "record," a "session"?) and state constraints explicitly; hunt your prompt for ambiguous references.
- Overload every specification: pair the prose/formal description with concrete Given-When-Then scenarios or executable tests, and verify the generated code against them.
- When generated tests fail, suspect the generated code's interpretation of your spec — don't just reword the prompt to patch the symptom; understand the cause first.
- Never assume regeneration preserves prior behavior; re-run the full test suite after every prompt change, because the model may reinterpret everything from scratch.
- Don't outsource reasoning to the model; you supply the inference, the model supplies the typing.
- Ignore "programming is dead" panic; invest instead in the new discipline — precise specification and verification skills transfer directly to the AI era.
