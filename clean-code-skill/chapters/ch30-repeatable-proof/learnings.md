# Chapter 30: Repeatable Proof

This chapter defends the third promise of the Programmer's Oath: "I will produce, with each release, a quick, sure, and repeatable demonstration that every element of the code works as it should." Dijkstra's dream of formal mathematical proofs of correctness failed at scale, but it left behind structured programming, functional decomposition, and ultimately test-driven development — and a passing test suite is the practical, scientific form of proof every professional owes for their code.

## The Promise of Repeatable Proof

With each release, produce a quick, sure, and repeatable demonstration that every element of the code works as it should. The author calls this the only standard that makes sense: when a customer pays you to develop software, you are honor bound to prove, to the best of your ability, that it does what they paid for. You owe this proof to customers, employers, teammates, business analysts, testers, project managers — and mostly to yourself, because you cannot consider yourself a professional if you cannot prove your work is the work you were paid to do.

## Quick, Sure, and Repeatable — Defined

- **Quick**: the test suite runs in a very short time — minutes instead of hours.
- **Sure**: when the suite passes, you know you can ship.
- **Repeatable**: anybody can run the tests at any time to confirm the system works; they produce the same clear pass/fail result every time. Run them many times per day.

## Dijkstra's Three Proof Techniques

Dijkstra identified only three techniques for proving an algorithm correct: **enumeration** (proving statements in sequence, or statements selected by a boolean, are correct), **induction** (proving loops correct — a special form of enumeration: assume true for x, prove for x + 1), and **abstraction** (breaking groups of statements into smaller provable chunks). Writing such proofs by hand is so hard that even Dijkstra said a programmer who supplied one for every loop "could never write a program of any size at all." His hoped-for library of theorems never materialized: software became so prevalent and pervasive that the library itself would have been far too vast for any human to grasp.

## "Go To Statement Considered Harmful"

Avoid unconstrained jumps; they destroy your ability to reason about code. Enumeration requires every statement to have a single entry point and a single exit point — otherwise you cannot be sure of its inputs or outputs. A GOTO can jump into or out of the middle of a sequence, making enumeration intractable and proof by enumeration or induction impractical. This is why Dijkstra's 1968 letter killed the GOTO and why most modern languages omit it.

## Structured Programming

Build all code from three building blocks: **Sequence** (statements ordered in time), **Selection** (statements chosen by a predicate — if/else, switch/case), and **Iteration** (a statement repeated under a predicate's control — while/for loops). Dijkstra knew — thanks to the work of Böhm and Jacopini — that any program, however complicated, can be composed from just these three, and that programs so structured are provable. Why this matters even if you never write a proof: if something is provable, you can reason about it; if it is unprovable, you cannot reason about it — and if you can't reason about it, you can't properly test it.

## Functional Decomposition

Start at the top level of the program and recursively break it down into smaller and smaller provable units. This was the unintended side effect of structured programming and the reasoning process behind it — structured programmers reason top-down through recursive decomposition into small provable functions. It powered the structured analysis and design movement of the '70s and '80s (Yourdon, Constantine, DeMarco, Page-Jones).

## TDD Is Functional Decomposition; Tests Are the Proof

Test-driven development — the **red → green → refactor** cycle — *is* functional decomposition: writing tests against small bits of the problem forces you to decompose it into testable elements. Every system built with TDD therefore conforms to structured programming and is provable. The tests are the proof — or rather, "the tests are the theory."

## Software Is a Science, Not a Mathematics

Dijkstra famously said tests can only prove a program wrong, never right — and here, the author argues, Dijkstra missed it. Software turned out to be a science, not a mathematics: we validate it with experiments and build a superstructure of theories based upon passing tests, just like every other science. We have never mathematically proven relativity or Newton's laws, yet we bet our lives on them every time we board a plane or use a GPS. TDD gives the same kind of proof: not formal mathematical proof, but experimental, empirical proof — the kind we depend on every day. What you owe is not Dijkstra's formal proof, but a scientific suite of tests that covers all required behavior, runs in seconds or minutes, and gives the same clear pass/fail result every run.

## In practice

- Maintain a test suite that covers all required behavior of the code you ship.
- Keep the suite fast: seconds or minutes, never hours.
- Make a passing suite mean "safe to ship" — fix flaky or unsure tests so the green bar carries that authority.
- Make tests runnable by anyone, anytime, with deterministic pass/fail output; run them many times per day.
- Decompose problems top-down into small, independently testable (provable) units; TDD's red → green → refactor cycle enforces this.
- Build code only from sequence, selection, and iteration; keep blocks single-entry/single-exit so you can reason about them. Avoid unconstrained jumps.
- If you can't reason about a piece of code, treat it as untestable — restructure it until you can.
- Never release without your repeatable demonstration that the code works; this is owed to customers, teammates, and yourself.
