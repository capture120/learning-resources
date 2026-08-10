# Chapter 14: Testing Disciplines — Examples

This chapter argues through anecdotes and war stories rather than code listings. Each one anchors a value about why testing disciplines exist.

### The melody-on-the-keyboard Timer test (mid-'90s)
Martin wrote a C++ embedded real-time timer with the signature:

```cpp
void Timer::ScheduleCommand(Command* theCommand, int milliseconds)
```

A scheduled Command's execute method would run in a new thread after the given delay. To test it, he cobbled together a driver that listened to the keyboard: each keypress scheduled a command that printed the same character five seconds later. He tapped out the rhythm of "I want a girl just like the girl who married dear old dad" on the "." key, sang it, waited five seconds, and sang along again as the dots replayed on screen. That was the whole test — and once it "worked" and he'd demoed it to colleagues, he threw the test code away.

**Lesson**: this is how the whole profession used to test — ad hoc, manual, throwaway. Today he would use test doubles to mock the OS timing functions, gain absolute control over time, schedule commands that set boolean flags, and step time forward in tests watching the flags flip. The contrast frames the entire chapter: the profession has come a long way, from throwaway drivers to disciplined, kept, cleaned test suites that live in the same source package as the code.

### The seconds-long TDD cycle
The book spells out the rhythm the Three Laws lock you into: write a line of test code (it doesn't compile), write a line of production code to make it compile, write another test line (doesn't compile), more production code, a test line that compiles but fails an assertion, production code that passes the assertion. The cycle is a few seconds long. **Lesson**: TDD is not "write tests first" as a phase — it is an intimate, line-by-line interleaving of test and production code.

### The pilot's checklists and memory items
Martin is a pilot. He takes the checklist discipline very seriously — checklists instead of memorizing complex procedures. But some procedures are too time-critical for pulling out a checklist; pilots commit those to memory as "memory items," and maintaining them is itself another discipline. **Lesson**: take disciplines seriously, but don't follow them blindly; know the legitimate exceptions and treat handling them as a discipline of its own.

### The room where everything worked a few minutes ago
Imagine a room of programmers all following a testing discipline. Walk up to any of them at any time: everything they're working on executed and passed its tests within the last few minutes — and that is always true, for everyone. How much debugging would happen in that room? Almost none; the most probable "debugging technique" is reverting to the last working version and trying again. Martin uses a debugger so rarely he forgets its hotkeys and must reacquaint himself each time. **Lesson**: the discipline's small green-to-green cycles, not debugger skill, are what shrink debugging time to almost nothing.

### The PDF manual's code appendix
Integrating a third-party package, you unzip it and find a PDF manual. Where do you go first? The ugly appendix of code examples at the back — because you hope the code tells more truth than the prose, and if you're lucky you can paste it in and fiddle it into working. A disciplined test suite is that appendix for your whole system: tests showing every way to create each object and call each API, each test isolated and understandable on its own, unambiguous, executable, and incapable of drifting out of sync. **Lesson**: tests are an almost perfect form of low-level documentation (though not high-level documentation).

### The programmer who walks away from the hard test
A programmer finishes a module, runs manual tests, and is satisfied. Told he must write unit tests, he sees them as redundant make-work and gives a half-hearted effort. Then he hits the module that's hard to test — hard because it wasn't designed to be testable, coupled to things that shouldn't run in a test. Redesigning would take time he doesn't think he has, and his manual tests "proved" it works, so he walks away. **Lesson**: test-after leaves holes; everyone leaves holes; everyone knows the suite is full of holes; so when the suite passes, everyone smiles knowingly and no decision can safely be made. A disciplined suite, by contrast, gives confidence high enough to deploy on green (Martin worked on systems that did exactly that) or to promote a build from DEV to QA.

### The Angel and the Devil
You scroll through code you must work on; the blood drains from your face — it's an ungodly mess. An angel on your right shoulder whispers, "You could clean it." A devil erupts on your left: "NO! Don't touch it! If you touch it, you will break it; and if you break it, it will become yours FOREVER." You back away, leaving the code to fester, rot, and drag the team's productivity down. **Lesson**: this is a fear reaction, and it is wildly unprofessional to have let code get so far out of control that you fear it — the creator has become a minion of the creation's whims. Feared code can only rot.

### Muzzling the Devil
The same scene replayed on a team with a good testing discipline and a trusted suite. The angel whispers "Clean it!" — and the devil simply does not appear; it has no power. You rename a variable; tests pass. You split a long function in two; tests pass. You move one new function to a different class; tests *fail* — so you revert, see green, realize the mistake, move it again correctly, and the tests pass. **Lesson**: with a trusted, fast suite, cleaning is virtually risk free, so everyone on the team will follow the Boy Scout Rule and continuously improve the code. This — not debugging, documentation, reliability, or design — is the real reason to follow a testing discipline.

### Experience report: the Java Swing application
Martin recently wrote a significant application using Java Swing. Code touching Swing was impractical to test, so he split the application into a tested component and an untested Swing component. The untested part grew fairly large because the Swing API forces construction of big, interconnected data structures full of callbacks, leaving the app at roughly 70% coverage. He could refactor the tested component easily, but touching the Swing component was always risky. His conclusion: "I won't use Swing again." **Lesson**: choose frameworks carefully — an untestable framework can wall off large swathes of your code from testing; push intelligence away from the framework and build an isolation layer between it and the code that needs testing.

### The team with "quick and dirty" tests
A team Martin coached explicitly decided test code didn't need production-quality standards: no need for good names, short functions, or thoughtful design — if it ran and covered the code, it was good enough. But tests must change as production code evolves, and the dirtier the tests, the harder the change. Release after release, maintaining the suite cost more; it became the developers' single biggest complaint and the excuse for ballooning estimates. Eventually they discarded the suite entirely — and then lost the ability to verify changes, their defect rate rose, fear of change took hold, they stopped cleaning, and the production code rotted. They ended with no tests, tangled bug-riddled code, frustrated customers, and the sense that testing had failed them. **Lesson**: dirty tests are equivalent to, or worse than, no tests. Test code is just as important as production code — not a second-class citizen — and must be kept just as clean.
