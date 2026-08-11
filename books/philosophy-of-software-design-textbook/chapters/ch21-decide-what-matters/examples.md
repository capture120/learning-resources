# Chapter 21 Examples: Decide What Matters

## Text editor: general-purpose text API vs. `backspace` (leverage)

Context (revisits Section 6.2): students building a GUI text editor needed a class to store the underlying text. The bad approach gave the text class special-purpose methods tied to user actions, such as `backspace` — each method solved exactly one problem. The good approach exposed a general-purpose interface for inserting and deleting arbitrary ranges of characters, which could solve many problems at once.

The chapter uses this to define **leverage**: the general-purpose interface mattered more because one solution served many needs. At the level of the text class interface, it didn't matter *whether* deletion was triggered by the backspace key; all that mattered was that text needed to be deleted. The trigger is a thing that doesn't matter and should not appear in the interface.

**Principle demonstrated**: decide what matters by looking for leverage; general-purpose interfaces have more of it than special-purpose ones.

## Invariants as leverage points

An invariant on a variable or data structure is a single piece of knowledge that predicts how that variable or structure will behave in many different situations. Knowing one fact explains many behaviors — the second form of leverage (one piece of information makes many other things easy to understand).

**Principle demonstrated**: things with high explanatory leverage are the things that matter; identify and emphasize them.

## Choosing a variable name from candidate words (design it twice)

When naming a variable, make a mental list of words that relate to the variable, then pick the few that convey the most information and form the name from them. Those words are the aspects of the variable that matter most. Generating several candidates before choosing is an application of the "design it twice" principle: comparing options makes it much easier to see what is most important.

**Principle demonstrated**: having multiple options to choose among makes importance visible; names should carry only what matters most.

## Performance-critical path design (revisits Section 20.4)

When performance really matters for a module, performance becomes an externally imposed constraint — but the designer still has to decide what matters most in meeting it. In the Section 20.4 example, that meant finding a design where the performance-critical path had as few method calls and special-case checks as possible, while remaining clean, simple, and obvious. The structure of the module was organized around the performance goal.

**Principle demonstrated**: structure modules around the things that matter; even with external constraints, the designer must identify what matters most in achieving them.

## Minimizing what matters: four micro-examples (Section 21.2)

Each shows how to make something stop mattering, or matter in fewer places:

1. **Object construction**: minimize the parameters required to construct an object, or provide defaults reflecting common usage — fewer decisions matter to the caller.
2. **Information hiding**: information hidden inside a module doesn't matter to any code outside that module.
3. **Exception handling**: if an exception can be handled entirely at a low level, it doesn't matter to the rest of the system.
4. **Configuration parameters**: if a configuration parameter can be computed automatically from system behavior instead of being exposed for an administrator to set manually, it no longer matters to administrators.

**Principle demonstrated**: make as little matter as possible; for things that do matter, minimize the number of places where they matter.

## Device-driver interface: centrality (Section 21.3)

The interface for device drivers in an operating system is a central idea: hundreds or thousands of drivers depend on it, and it determines the structure of the code around it. Putting the most important things at the heart of the system like this is one of the three ways to emphasize what matters (alongside prominence — appearing in documentation, names, and parameters of heavily used methods — and repetition).

**Principle demonstrated**: emphasize what matters through centrality; conversely, if an idea shapes a system's structure, that is evidence it matters.

## Java I/O: buffered vs. unbuffered streams (treating too many things as important)

Revisiting the Java I/O critique from earlier in the book (page 26): to read a file with buffering, Java forces developers to explicitly wrap a `FileInputStream` in a `BufferedInputStream`. The interface makes every developer aware of the buffered/unbuffered distinction, even though that distinction is almost never important — developers almost always want buffering and shouldn't have to ask for it explicitly.

This is the chapter's prime example of the first mistake: treating too many things as important. The unimportant choice clutters the interface and adds cognitive load for every caller. Related symptoms named alongside it: methods with arguments irrelevant to most callers, and shallow classes, which often result from this same mistake.

**Principle demonstrated**: don't surface choices that don't matter; default to the common case and hide the rest.

## The hypothesis approach for inexperienced designers

Sometimes it isn't obvious which things matter most — particularly hard for younger developers without much experience. Ousterhout's recommendation: make a hypothesis ("I think this is what matters most"), commit to it, build the system under that assumption, and watch the outcome. If the hypothesis was right, reflect on why and what clues signaled it. If wrong, that's still OK — reflect on why it was wrong and whether there were clues you could have used to avoid the choice. Either way you learn, and your choices gradually improve. The explicit permission to be wrong is part of the advice: it makes committing to a hypothesis safe.

**Principle demonstrated**: judgment about what matters ("good taste") is trained through deliberate hypothesis and reflection, not acquired passively.

## Beyond software: technical writing and life philosophy (Section 21.5)

Technical writing: the best way to make a document easy to read is to identify a few key concepts at the beginning and structure the rest of the document around them, tying details back to the overall concepts. Life: identify the few things that matter most to you and spend as much of your energy as possible on them rather than frittering time on things you don't find important or rewarding.

**Principle demonstrated**: separating what matters from what doesn't is a general skill — the chapter names the ability to make this distinction "good taste," an essential part of being a good software designer.
