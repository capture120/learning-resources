# Chapter 30: Repeatable Proof — Examples

This chapter argues through history and anecdote rather than code refactorings. Its examples are stories and demonstrations that trace a line from Dijkstra's formal proofs to modern test suites.

### Dijkstra's biography: the first programmer who wanted a science

The book sketches Edsger Wybe Dijkstra's life: born in Rotterdam in 1930, he survived the bombing of Rotterdam and the German occupation, and in 1952, at age 21, became the Netherlands' very first programmer at the Mathematical Center of Amsterdam. When he married in 1957, the authorities refused to accept "programmer" as a profession on the marriage record — they had never heard of it — so he listed "theoretical physicist." In 1955 he chose programming over theoretical physics because it was the greater intellectual challenge, but worried no one would take him seriously since programming had no discipline or science. His boss, Adriaan van Wijngaarden, replied that Dijkstra might be one of the people to make it a science. The anecdote anchors the chapter's theme: the discipline of proving code correct had to be invented, and Dijkstra set out to make software a formal system like Euclid's *Elements* — postulates, theorems, lemmas, and proofs.

### The handwritten proof of a remainder algorithm

The book shows a simple Java program that calculates the remainder of an integer division, followed by the author's full handwritten correctness proof of that algorithm (translated from a demonstration in Dijkstra's own work). The author says he doesn't expect readers to read the proof — only to get a feel for what such a proof entails. Even a trivial function demands hard formal reasoning via enumeration, induction, and abstraction. Dijkstra himself complained that if programmers had to supply such a proof for every simple loop, they "could never write a program of any size at all." Lesson: formal mathematical proof of software does not scale, which is why something else had to take its place.

### The Fortran remainder program with GOTOs

The book prints a short 1950s-style Fortran program implementing the same remainder algorithm, full of numbered labels and GOTO statements. Its core logic (the full listing also includes WRITE/READ/FORMAT I/O lines):

```fortran
1      IF(NDD-NR)2,2,3
2      NDD=NDD*2
       GOTO 1
3      IF(NDD-ND)4,10,4
4      NDD=NDD/2
       IF(NDD-NR)5,5,6
5      NR=NR-NDD
6      GOTO 3
```

The point is the jumps: a GOTO can jump into or out of the middle of an enumerated sequence, violating the rule that every enumerated statement have a single entry and a single exit, so enumeration — and therefore proof, and therefore reasoning — becomes intractable. This concretely motivates Dijkstra's 1968 letter "Go To Statement Considered Harmful" (published by editor Niklaus Wirth, who bypassed normal review because he found it so profound) and explains why most modern languages no longer have GOTO statements like that.

### The structured programming flame war, 1968-style

After Dijkstra's letter, the debate raged for years — not on social media, but in letters to the editors of the major software journals. Some claimed Dijkstra was a god, others a fool; "just like social media today, except slower." In time his position won: most of today's languages simply don't have a GOTO, so "we are all structured programmers, because our languages don't give us a choice." Lesson: structured programming wasn't obvious or popular at first; the debate raged for years before Dijkstra's position gained more and more support.

### Betting your life on unproven theories

To answer Dijkstra's objection that tests can only prove a program wrong, never right, the author draws an analogy from science. Evolution, relativity, the Big Bang, Newton's laws — none has been mathematically proven. Yet every time you get into a car or an airplane you bet your life on Newton's laws, and every time you use a GPS you bet on Einstein's relativity. Lack of mathematical proof does not mean lack of sufficient proof to depend upon, even with our lives. That is exactly the kind of proof TDD provides: experimental, empirical proof built from a superstructure of theories validated by passing tests. The tests are the theory, and a green suite earns the same kind of practical trust — belief within limits — that we grant the laws of physics.
