# Terence Tao, *Solving Mathematical Problems: A Personal Perspective* — Overview and Master Technique Index

> **What this file is.** The navigation layer and synthesis for a six-file extraction of Tao's book. It answers the question the extraction was made for — *how does Tao actually solve problems, and what are his fundamental techniques?* — and then routes you to the chapter file where each technique is shown working.
>
> **Audience calibration.** Written for a reader with college maths for CS: Calculus 1 and basic linear algebra. No real analysis, no abstract algebra, no olympiad background assumed. Every chapter file has its own "Background you need first" section supplying the school geometry, modular arithmetic, and game vocabulary the book takes for granted; this file tells you which of those you will need and when.

**Link convention used in the index below.** Each citation is a live link whose text names the chapter file and the problem, e.g. [02-number-theory.md — Problem 2.4](02-number-theory.md). The six chapter files are:

| File | Chapter | What's in it |
|---|---|---|
| [01-strategies-in-problem-solving.md](01-strategies-in-problem-solving.md) | Ch. 1 + both Prefaces | The framework itself, demonstrated on one triangle problem |
| [02-number-theory.md](02-number-theory.md) | Ch. 2 | Digits, Diophantine equations, sums of powers (P2.1–2.7, Ex 2.1–2.6) |
| [03-algebra-and-analysis.md](03-algebra-and-analysis.md) | Ch. 3 | Functional equations, polynomials (P3.1–3.4, Ex 3.1–3.8) |
| [04-euclidean-geometry.md](04-euclidean-geometry.md) | Ch. 4 | Synthetic geometry, no coordinates (P4.1–4.6, Ex 4.1–4.4, Thm 4.1–4.2) |
| [05-analytic-geometry.md](05-analytic-geometry.md) | Ch. 5 | Geometry solved by *other* branches (P5.1–5.4, Ex 5.1–5.3) |
| [06-sundry-examples.md](06-sundry-examples.md) | Ch. 6 | Invariants, hidden data, games (P6.1–6.4, Ex 6.1–6.8) |

---

## 1. What this book actually is

Tao wrote it at 15, published it at 16 (1992), and reissued it at 30 (2006) with a new preface and almost no changes to the mathematics. It is not a textbook, not a theory of problem solving, and not a collection of slick solutions. It is **roughly thirty competition-style problems worked out loud**, in real time, with the wrong turns left in.

Four things follow from that, and they determine how you should read it:

1. **The narration is the content; the answers are almost worthless.** Every problem in the book has a short printed solution somewhere in a competition anthology. What you cannot get elsewhere is the transcript of a strong solver's search: which of five candidate tools he screens out and why, which reformulation he tries third, at what point he decides an approach is dead, and what he does in the state you will actually spend most of your time in — stuck, with no idea what to try next. In [Chapter 2](02-number-theory.md), roughly half the text is spent on approaches that got abandoned, each with a stated reason. In [Chapter 1](01-strategies-in-problem-solving.md), the six pages of exploration on Problem 1.1 produce four lines of algebra, and Tao says explicitly in the second-edition preface that the point is "not to present the slickest solution… but rather to show how one approaches a mathematical problem for the first time, and how the painstaking, systematic experience of trying some ideas, eliminating others, and steadily manipulating the problem can lead, ultimately, to a satisfying solution."

2. **The problems are deliberately "sanitized."** Tao's own word (Preface, p. viii). A competition problem is one "where an elegant solution has already been found (by someone else, of course), the question is stripped of all superfluousness and posed in an interesting and (hopefully) thought-provoking way." His metaphor is gold prospecting: you are told a nugget exists, that you would recognise it, that it is not buried too deep, and that you have been handed exactly the right equipment. Each of those four guarantees is a licence to abandon an approach that violates it — and each of them **is false in research mathematics**, which Tao says outright in the 2nd-edition preface. Keep that boundary in mind: the book's most useful heuristic ("an unused hypothesis means your solution is wrong") is a property of *designed* problems.

3. **The mathematics is deliberately elementary.** Tao notes at 30 that "several of the problems here could be handled more quickly and cleanly by more 'high-tech' mathematical tools" and refuses to use them, because the elementary route is where the transferable technique lives. Practical consequence for you: nothing in the book needs more than high-school algebra, high-school geometry, and modular arithmetic. The difficulty is entirely in the *assembly*, which is precisely why it works as a problem-solving text and not a mathematics text.

4. **It is a book by a 15-year-old, preserved on purpose.** Tao declined to rewrite it: "my younger self was almost certainly more attuned to the world of the high-school problem solver than I am now," and he kept the text's "certain innocence, or even naivety." So the exposition occasionally fumbles, and the printed book contains a number of small slips — the chapter files flag each one inline (see the [errata table in Chapter 4](04-euclidean-geometry.md), and the four slips catalogued in [Chapter 6](06-sundry-examples.md)). Those slips are useful: they always occur exactly where the text moves fast, which is a general lesson about where to distrust any text, including your own.

**What the book is not.** It is not a systematic taxonomy — Tao names Pólya's *How to Solve It* as the fuller catalogue and says only "**some** of these strategies are discussed below." It does not teach the two weapons he says matter most: "experience and knowledge — [they] are not easy to put into a book: they have to be acquired over time." And it is not a course: the chapters are independent, the problems are graded (unstarred / `(*)` / `(**)`), and most problems carry a follow-up exercise deliberately within transfer distance of the technique just demonstrated.

---

## 2. Tao's core loop

This is **Tao's own stated method**, laid out in [Chapter 1](01-strategies-in-problem-solving.md) as numbered strategies 1–9 and then performed in that order on Problem 1.1. It is not a synthesis by me — the ordering, the names, and the transitions are his. He inherits the frame from Pólya and says so.

The shape of it: **there is a fixed opening sequence and it contains no calculation.** Steps 1–5 are all cheap, all skippable, and all costly to skip. Steps 6–8 are what you do when steps 1–5 leave you with a blank page. Step 9 is the algebra, and it comes last.

### The checklist you can actually run

**Phase A — Set up (do this before you are allowed to compute).**

1. **Classify the problem.** Which of these is it? *"Show that…" / "Evaluate…"* (a clearly visible objective you can approach deliberately — generally the easiest); *"Find a… / Find all…"* (hit-and-miss; guess something that nearly works and tweak it, or relax the requirements until they are checkable); *"Is there a…"* (hardest — you must gamble on the answer before you can even choose a proof style). Then name the *species of objective* to match: find an object / prove a statement / determine existence / "or whatever." If the question type and the deliverable disagree, you have mis-read one of them.
   *Tao's illustration:* "find a hotel in this city to sleep in for the night" is unmanageable as posed; convert it to "find a vacant hotel within 5 km under \$100" and use pure elimination. **You get to choose which type of problem to solve.**

2. **Understand the data.** A problem is "a number of objects which satisfy some special requirements," so split the data into two lists — objects and requirements — and then, crucially, "see how the objects and requirements react to each other." Two payoffs: the data is a *lookup key into your theorem library* (the nouns present are {sides, angles, area} ⇒ fetch the sine rule, the cosine rule, the area formulas), and it tells you what your notation has to encode.

3. **Understand the objective**, then **convert it into tactical goals** — intermediate targets with a definite done-condition. You cannot "find the angles" by an act of will; you can "write down equations involving the sides and angles." Later Tao sharpens the same tactical goal all the way down to "solve for $b$."

4. **Select good notation.** After 2 and 3, before any equation. Aim for **minimal and symmetric**, and let the notation *absorb* your structural hypotheses so they can never be violated. Tao's chain: sides $a,b,c$ → $a,\,a+d,\,a+2d$ (absorbs the arithmetic progression) → $b-d,\,b,\,b+d$ (symmetric — and this is the move that wins the problem). He then *rejects* a further symbol-saving substitution ($\alpha,\beta,180^\circ-\alpha-\beta$) as "ugly and unsymmetrical": **when minimality and symmetry conflict, symmetry usually wins — keep the redundant symbol and carry the relation as a remembered side-constraint.** And if the notation seems to impose a restriction ($b>d$), check whether it was true anyway; if it was, you have just *discovered a hypothesis you did not know you had*.

5. **Write down everything you know, in that notation, and draw a diagram.** His three reasons, quoted because the third is the non-obvious one: "(a) you have an easy reference later on; (b) the paper is a good thing to stare at when you are stuck; (c) the physical act of writing down of what you know can trigger new inspirations and connections." Then **triage the dump**: highlight the promising facts, exile "questionable, redundant, or crazy ideas" to separate scratch paper. Two stated selection criteria — *match the logical form of your tools to your goal* (equalities to pin down a value, inequalities to bound or to eliminate cases) and *prefer the formula that collapsed under your new notation* (Heron's semiperimeter becomes exactly $3b/2$). A third arrives later: **prefer the tool that consumes all of your data.** Draw the diagram — and be willing to say, as he does, "in this case the picture does not seem to add much."

**Phase B — When you cannot get started (this is the phase the book is really about).**

6. **Modify the problem slightly.** Tao's menu of seven, to be worked down when the page is blank:
   (a) a special case, including extreme or degenerate cases; (b) a simplified version; (c) a *stronger* conjecture that would imply the problem; (d) a *weaker* consequence, proved first; (e) a reformulation (contrapositive, contradiction, substitution); (f) solutions of similar problems; (g) a generalization.
   Note (c)/(g) and (b)/(d) point in opposite directions on purpose — you do not know in advance which direction has traction. **Dosage rule:** perturb as little as possible, because "special cases are, by their nature, special… This tends to happen when the special case is *too* special. Start with modest assumptions first."

7. **Modify the problem significantly — break it on purpose.** "Basically, we try to push the problem until it breaks, and then try to identify where the breakdown occurred; this identifies what the key components of the data are, as well as where the main difficulty will lie." The moves: change the object; delete data the answer cannot depend on; **delete an objective** (maybe the rest comes free); **delete a datum** (if the problem dies, that datum is load-bearing); partially weaken a datum (equality → inequality — but "stick with the simple options first"); **swap the data with the objective**; **negate the objective** and try to disprove it.

8. **Prove small results; play with the data.** "Data is there to be used, so one should pick up the data and play with it. Can it produce more meaningful data?… However small the result, do not forget it… Besides, it gives you something to do if you are stuck." On Problem 1.1 this produces: make the dependence functional ($b = b(d,t)$); a symmetry mini-result ($b(d,t)=b(-d,t)$, so the answer is even in $d$); a scaling/dimensional mini-result ($b(kd,k^2t)=k\,b(d,t)$, which licenses normalizing $t=1$); and the option to differentiate. **None of these solved the problem — and three of them became the checks on the final answer.**

**Phase C — The grind.**

9. **Simplify, exploit the data, reach the tactical goals.** Entry condition, stated explicitly: notation chosen, a few equations written, a tactical goal named. Then:
   - **Look ahead before committing**: "think ahead and see where one could hope such a technique to take one; this can allow one to save enormous amounts of time by eliminating unprofitable directions of inquiry before sinking lots of effort into them."
   - **Hold three things in working memory**: the relevant theorems, the data and how it can be used, and — flagged as most important — **the objective**. In a long computation the failure mode is not forgetting a theorem; it is forgetting what you were trying to produce and simplifying aimlessly.
   - **The grind itself is standard, learnable craft**, and that is good news: "In simple problems, there are usually standard ways of doing this. (For example, algebraic simplification is usually discussed thoroughly in high-school level textbooks.)" If you cannot factor a quartic, that is a fluency gap you close by practice, not an insight gap you close by staring.

**Phase D — After you have an answer.**

10. **Cash the checks you built in Phase B.** Special case ✓, symmetry ✓, dimensional consistency ✓, and one concrete numerical instance run end to end.
11. **Score the solution, don't just check it.** The rubric (Preface, p. ix): a solution should be **short**, **understandable**, have **a touch of elegance**, and be **fun to discover**. Only the first is objective. Tao treats aesthetic failure as grounds for discarding a *correct* proof — "solving the problem is not everything."
12. **Accept that there is no canonical best solution.** "A question can be solved in more than one way, and no particular way can really be judged the absolute best." He leaves an entire alternative (deformation/continuity) approach to Problem 1.1 on the table.

### Two framing facts about the loop

- **Backtracking is free, so be aggressive.** "Mathematics, being abstract, has no physical constraints; one can always restart from scratch, try new avenues of attack, or backtrack at an instant's notice." Since a discarded attempt costs one paragraph, the optimal strategy is to launch many speculative attempts and kill them fast. That is why Phase B is a catalogue of deliberate perturbations, most of which are *expected* to fail.
- **Diagnose which faculty failed when you are stuck.** Progress needs "a firm, clear direction, with long strides and sharp vision" — three separable assets: **direction** (you know which way the answer is), **stride length** (each step invokes a theorem instead of re-deriving it), **vision** (you can see far enough ahead to know the direction is still right). Being stuck is usually the failure of exactly one of the three, and it is worth asking which.

---

## 3. The master technique index

Every distinct technique found across the six chapter files, deduplicated and grouped into thirteen families. Where the same move appears in several chapters, the citations are merged into one row — that merging *is* the evidence for §4, so the multi-citation rows are the important ones.

Read a family's table as: **Technique** (what to do) / **Trigger** (what should make you reach for it) / **Where** (chapter file + problem where you can watch it work).

Families:
[A. Frame the problem](#a-frame-the-problem-before-touching-it) ·
[B. Understand the data](#b-understand-the-data) ·
[C. Understand the objective](#c-understand-the-objective) ·
[D. Notation and bookkeeping](#d-notation-and-bookkeeping) ·
[E. Reformulation and translation](#e-reformulation-and-translation) ·
[F. Simplification and reduction](#f-simplification-and-reduction) ·
[G. Search, experiment, guessing](#g-search-experiment-and-guessing) ·
[H. Exploiting structure: invariants, symmetry, modular arithmetic](#h-exploiting-structure-invariants-symmetry-modular-arithmetic-monovariants) ·
[I. Working backwards and indirect proof](#i-working-backwards-and-indirect-proof) ·
[J. Rigidity and squeezing](#j-rigidity-and-squeezing-exact-answers-out-of-inequalities) ·
[K. Managing the search](#k-managing-the-search-progress-dead-ends-morale) ·
[L. Verification and checking](#l-verification-and-checking) ·
[M. Domain toolkits](#m-domain-toolkits)

---

### A. Frame the problem before touching it

| Technique | Trigger | Where |
|---|---|---|
| **Classify the question type**: "Show that / Evaluate" vs "Find a / Find all" vs "Is there a" | Always, first thing | [01 — Problem 1.1](01-strategies-in-problem-solving.md); [02 — Problem 2.7](02-number-theory.md); [05 — Problem 5.1](05-analytic-geometry.md) |
| **Name the species of objective** (find object / prove statement / determine existence / "or whatever") and check it agrees with the question type | Right after stating the objective | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Read whether the problem promises existence and uniqueness.** "Find $X$" grants both; "Find all (**if any**)" grants neither | The wording is "Find …" | [03 — Exercise 3.4 vs Problem 3.2](03-algebra-and-analysis.md) |
| **Mine the statement's pragmatics**: an implied unique answer; an "ordinary" constant (1983) is decoration | "Find $f(1983)$"-shaped questions | [03 — Problem 3.2](03-algebra-and-analysis.md) |
| **Read the genre / provenance** — competition, recreational, cited vs uncited source — and predict which features will be discarded | Before starting | [02 — Problem 2.1, Problem 2.2](02-number-theory.md); [01 — Prefaces](01-strategies-in-problem-solving.md) |
| **File the new problem under the genre of the last one it resembles**, and use that as your retrieval key | A problem looks like the previous one | [02 — Problem 2.7 (as a "sums of reciprocals" case of Problem 2.6)](02-number-theory.md) |
| **Calibrate difficulty against the depth of the subject** — "this needs the deep end" is a legitimate diagnosis, not a confession | A problem resists every elementary tool | [02 — chapter opener, Lagrange's four squares](02-number-theory.md) |
| **Recognize a scary-looking problem as mild** (superficial resemblance to a famous hard theorem) | The statement looks like Fermat's Last Theorem | [02 — Problem 2.5](02-number-theory.md); [02 — Problem 2.4](02-number-theory.md) |
| **Situate the problem in the literature, name the sledgehammer, then decline it** | You recognize the problem type and know a heavy tool | [02 — Problem 2.6 (Bernoulli polynomials)](02-number-theory.md); [02 — Problem 2.4 (Pell's equation)](02-number-theory.md); [04 — Problem 4.5](04-euclidean-geometry.md); [01 — 2nd-ed. preface](01-strategies-in-problem-solving.md) |
| **Deliberately keep the toolkit elementary**: note the heavyweight theorem, then solve it the elementary way anyway | You spot a theorem that would flatten the problem | [01 — 2nd-ed. preface](01-strategies-in-problem-solving.md); [03 — Problem 3.3 (AM–GM, Cauchy–Schwarz declined)](03-algebra-and-analysis.md) |
| **Try elementary tools first; look for the elegant (i.e. lazy) way out** | Heavy machinery is visible on the horizon | [02 — Problem 2.4](02-number-theory.md); [06 — Problem 6.1](06-sundry-examples.md) |
| **Triage the problem's difficulty from the diagram / first look, then choose a method** | You have a picture, or a first impression | [04 — Problem 4.1](04-euclidean-geometry.md) |
| **Decide which way the answer goes *before* looking for a proof** — guess from meta-evidence about the problem's source | "Is it possible?" / yes-no questions | [06 — Problem 6.1](06-sundry-examples.md); [05 — Problem 5.4](05-analytic-geometry.md); [02 — Problem 2.2](02-number-theory.md) |
| **Choose the branch of the dichotomy with the cheaper proof obligation** (existence needs one witness; impossibility must defeat everything) | Yes-no question where both sides are open | [05 — Problem 5.4](05-analytic-geometry.md) |
| **Size up the search space first**: a finite problem gives you a guaranteed grim fallback, which frees you to gamble on cleverness | The problem is finite or nearly so | [02 — Problem 2.1](02-number-theory.md) |
| **Meta-guess how nasty the final answer will be** (integrality of small cases as grounds for hope) | You want to know whether to expect a clean closed form | [05 — Problem 5.1](05-analytic-geometry.md) |
| **Aesthetic heuristic: a pleasant-looking problem should have a pleasant solution** | Short, surprising statement | [05 — Problem 5.2](05-analytic-geometry.md) |
| **Ask what is *odd* about the conclusion before trying to prove it** | You do not yet believe the statement | [05 — Problem 5.2](05-analytic-geometry.md) |
| **Ask what success would look like, and reject approaches whose success would prove too much** | Before investing in a computation | [02 — Problem 2.4 (mod 7 and mod $x$ were doomed a priori)](02-number-theory.md) |
| **Score the finished solution against a rubric**: short, understandable, elegant, fun to discover — and be willing to reject a *correct* proof | You have finished | [01 — Preface, perpendicular bisectors](01-strategies-in-problem-solving.md); [06 — Problem 6.1, Problem 6.3](06-sundry-examples.md) |
| **Know the difficulty grading and stay near your level**; end-of-problem exercises are deliberately within transfer distance | Choosing what to attempt | [01 — 1st-ed. preface](01-strategies-in-problem-solving.md) |
| **"Good problems usually look simple and straightforward"** — a one-line statement is not evidence of easiness | You are about to underestimate a problem | [04 — Problem 4.3](04-euclidean-geometry.md) |
| **"Most problems are not trying to pull your leg"** — trust that a solution exists | You are doubting the problem | [04 — Problem 4.6](04-euclidean-geometry.md) |
| **Hunt for *the* trick: treat a competition problem as a designed lock with one key** — and know this premise fails in research | You are working a sanitized puzzle | [01 — 2nd-ed. preface](01-strategies-in-problem-solving.md) |

---

### B. Understand the data

| Technique | Trigger | Where |
|---|---|---|
| **Inventory the objects and the requirements separately, then ask how they react to each other** | Always, second | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Retrieve theorems by keyword from the nouns present in the data** | You have listed the data | [01 — Problem 1.1](01-strategies-in-problem-solving.md); [04 — Problem 4.1](04-euclidean-geometry.md) |
| **Assemble/recall the domain toolkit before attacking a family of problems** — enumerate a *closed* list so "be clever" becomes "screen five candidates" | Entering a new domain | [03 — §3.2 opener, before Problem 3.3](03-algebra-and-analysis.md); [04 — Problem 4.1, Problem 4.2](04-euclidean-geometry.md) |
| **Absorb a structural hypothesis into the parameterisation** so it can never be violated or re-checked | A hypothesis is structural ("in arithmetic progression") | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Read the fine print — hunt for the one unusual feature of the statement** | The problem looks standard but resists standard handling | [03 — Problem 3.1 (integer codomain)](03-algebra-and-analysis.md) |
| **Interrogate every constant in the statement** ("why 18? why $p>3$? why 1985?") | A specific number appears for no obvious reason | [02 — Problem 2.1, Problem 2.7](02-number-theory.md); [06 — Exercise 6.2](06-sundry-examples.md) |
| **Suspect and test for red herrings**, including the "obvious first algebraic step" | Data that resists all use; a tempting expansion | [02 — Problem 2.1, Problem 2.2](02-number-theory.md); [04 — Problem 4.4 (the parallelism)](04-euclidean-geometry.md) |
| **Mine the problem for hidden data**: integrality, positivity, distinctness, ordering — and the *English wording* | "There is not enough information" | [06 — Problem 6.2, Problem 6.4](06-sundry-examples.md); [03 — Problem 3.1](03-algebra-and-analysis.md) |
| **Treat the semantics of the question as usable data — then verify you did not need it** | A case is arithmetically fine but absurd for the story | [06 — Problem 6.2 ($N=1$, $N=13$)](06-sundry-examples.md) |
| **Ask what each hypothesis is load-bearing for** ("what breaks without this?") | Any fussy-looking condition | [05 — Problem 5.3](05-analytic-geometry.md); [01 — Problem 1.1 (delete $d$, delete $t$)](01-strategies-in-problem-solving.md) |
| **Unpack the idealizing hypothesis before using it** ("infinitely manoeuvrable" is what licenses the instantaneous 90° turn) | The statement contains an idealization | [05 — Problem 5.4](05-analytic-geometry.md) |
| **Every piece of data must be invoked — steer towards the *unusual* hypothesis** | You have an odd-looking hypothesis still unused | [04 — Problem 4.3 ($\lvert DC\rvert=\lvert DG\rvert$)](04-euclidean-geometry.md); [01 — the gold-nugget premise](01-strategies-in-problem-solving.md) |
| **Prefer the tool that consumes *all* of your data** — a formula touching every hypothesis could plausibly be the whole solution | Choosing among candidate formulas | [01 — Problem 1.1 (Heron uses both $d$ and $t$)](01-strategies-in-problem-solving.md) |
| **Audit unused hypotheses after finishing** — either you found a red herring or you can strengthen the theorem for free | You are done | [04 — Problem 4.4](04-euclidean-geometry.md) |
| **Audit which data has not been used *fully*** (not merely which is unused); sums and totals are the usual culprits | You are stuck and every fact "has been used" | [06 — Problem 6.2 (individual total scores)](06-sundry-examples.md) |
| **Cross-match one piece of data against another** — facts are useful in *pairs*, and $k$ facts give only $\binom{k}{2}$ pairs to sweep | You have several unrelated-looking facts | [06 — Problem 6.2](06-sundry-examples.md) |
| **Diagnose when hypothesis and conclusion share no vocabulary** ("they do not mix") — that diagnosis is what calls for a stepping stone | Direct attack has no purchase | [02 — Problem 2.1](02-number-theory.md) |
| **Treat suspicion as a signal: a fishy hypothesis is a very *restrictive* hypothesis** — so characterize its whole solution set | A given equation looks like a schoolboy error | [03 — Problem 3.3](03-algebra-and-analysis.md) |
| **Scarcity of data is a navigational asset**: few hypotheses ⇒ few directions. Contrapositive: if you are lost in a two-hypothesis problem, you failed to *read* something | You feel lost in a sparse problem | [03 — Problem 3.1, Problem 3.3](03-algebra-and-analysis.md) |
| **Read the statement for hidden redundancy** (an apparently specific choice is one of two interchangeable ones, so it carries no information) | A statement names a specific configuration | [05 — Problem 5.3](05-analytic-geometry.md) |
| **Discard unusable data deliberately**: "why burden yourself with data that cannot be used?" | Your description is exact but unmanipulable | [02 — Problem 2.2](02-number-theory.md); [05 — Problem 5.4](05-analytic-geometry.md) |
| **Delete the data the answer cannot depend on** — if your method tracks it, your method is too heavy | You are choosing between a light and a heavy method | [01 — Problem 1.1 (position of the triangle ⇒ no coordinates)](01-strategies-in-problem-solving.md) |

---

### C. Understand the objective

| Technique | Trigger | Where |
|---|---|---|
| **State the objective, then convert it into tactical goals** with definite done-conditions | Always, third; especially when you don't know what to compute | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Give the objective a short name / symbol** | The thing to compute has a long English description | [05 — Problem 5.1 ("$X$")](05-analytic-geometry.md) |
| **Convert the verbal objective into an equation** ("divisible by the sum of its digits", "$AD\perp EF$", "is a square") | The goal is stated in words | [02 — Problem 2.1, Problem 2.7](02-number-theory.md); [04 — Problem 4.1](04-euclidean-geometry.md); [05 — Problem 5.1](05-analytic-geometry.md); [06 — Problem 6.4](06-sundry-examples.md) |
| **Turn a *described* object into an equation** ("the numerator of…" → something you can solve) — progress is a change of *type*, not of size | The target is phrased as a description | [02 — Problem 2.7](02-number-theory.md) |
| **Set explicit numbered tactical objectives from the shape of the question, and announce when each is met** | The question names an awkward object | [02 — Problem 2.7 (objectives (a), (b))](02-number-theory.md); [06 — Problem 6.2](06-sundry-examples.md) |
| **Generate objectives mechanically**: list what makes the problem hard, negate each into a "we would like to…" wish; that list *is* your plan | You have no plan | [02 — Problem 2.7](02-number-theory.md) |
| **Reduce to a single unknown / a minimal generating set** — count how many unknowns are genuinely free before solving for any | Several unknowns, some determined by others | [01 — Problem 1.1 (six unknowns → one)](01-strategies-in-problem-solving.md); [04 — Problem 4.4](04-euclidean-geometry.md); [06 — Problem 6.4](06-sundry-examples.md) |
| **Delete an objective — the rest may come for free from theorems you already have** | Multiple things to find | [01 — Problem 1.1 (angles come from the cosine rule)](01-strategies-in-problem-solving.md) |
| **Separate independent from dependent variables; name the dependent one you want, then demand an equation tying it to the independent one** | Many unknowns, unclear what to solve for | [06 — Problem 6.4](06-sundry-examples.md) |
| **Generalize the question: determine the whole object instead of the one requested value** | You are asked for one specific value | [03 — Problem 3.2 (evaluate all of $f$, not $f(1983)$)](03-algebra-and-analysis.md) |
| **Restate the current target in one sentence before the final push** | Mid-chain | [02 — Problem 2.2](02-number-theory.md); [06 — Problem 6.2](06-sundry-examples.md) |
| **Reduce the objective, then discard the data it has already consumed** | Part of the hypothesis has served its purpose | [05 — Problem 5.4 (escape = reach the edge ⇒ running speed now irrelevant)](05-analytic-geometry.md) |
| **Solve only what was asked; accept partial determination of the system** | Some unknowns stay undetermined | [06 — Problem 6.4 (penknife pinned, herd not)](06-sundry-examples.md) |
| **Read the objective to decide the *currency* of the solution** (lengths vs angles vs areas vs ratios) | You don't know which quantities to work in | [04 — Problem 4.2](04-euclidean-geometry.md) |
| **Let the form of the objective name the tool** (equal ratios ⇒ similar triangles; a product of collinear lengths ⇒ power of a point; sums of *squares* ⇒ dot products) | Your objective has a recognizable syntactic shape | [04 — Problem 4.3](04-euclidean-geometry.md); [05 — Problem 5.1](05-analytic-geometry.md); [02 — Problem 2.6 (product form for divisibility)](02-number-theory.md) |
| **Diagnose which *word* in the statement makes it hard** | The statement contains an unbounded generality | [05 — Problem 5.2 ("partition")](05-analytic-geometry.md) |

---

### D. Notation and bookkeeping

| Technique | Trigger | Where |
|---|---|---|
| **Select good notation: minimal and symmetric** — and do it *after* data and objective, before any equation | Setup complete | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Symmetrise the notation** ($b-d,\,b,\,b+d$ instead of $a,\,a+d,\,a+2d$) | A structure has a natural centre | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Keep a redundant symbol plus a remembered relation rather than destroy symmetry** | Minimality and symmetry conflict | [01 — Problem 1.1 ($\alpha,\beta,\gamma$ kept, $\alpha+\beta+\gamma=180^\circ$ remembered)](01-strategies-in-problem-solving.md) |
| **Turn an apparent notational drawback into an extra piece of data** | Your representation seems to impose a condition | [01 — Problem 1.1 ($b>d$ was true anyway)](01-strategies-in-problem-solving.md) |
| **Notation hygiene and housekeeping substitutions** ($\overline{abc}_{10}$ vs $abc$; set $n=2m$ so you never write $n/2$) | Ambiguous or messy symbols will breed errors | [02 — Problem 2.1, Problem 2.6](02-number-theory.md) |
| **Get notation — "numbers and equations" — as early as possible** | The problem is stated in words and objects | [06 — Problem 6.1, Problem 6.3, Problem 6.4](06-sundry-examples.md) |
| **Strip the state down to what matters; decide explicitly what to forget** | The problem mentions features that cannot affect the answer | [06 — Problem 6.1 (only colour *counts*), Problem 6.3 (only the bar's *size*)](06-sundry-examples.md) |
| **Introduce exactly enough variables — parsimony over confusion** | Risk of drowning in unknowns | [06 — Problem 6.4](06-sundry-examples.md) |
| **Invent convenient terminology** for a phrase you keep writing | You keep writing the same phrase | [05 — Problem 5.2 ("an integer side")](05-analytic-geometry.md) |
| **Coin a word for what you cannot yet measure — then immediately give the word an operational test** | You can see the phenomenon but not quantify it | [05 — Problem 5.3 ("outeredginess")](05-analytic-geometry.md) |
| **Introduce notation / parametrize when pictures run out** | Diagrams have stopped producing information | [04 — Problem 4.5](04-euclidean-geometry.md) |
| **Write down everything you know, on paper** — reference, something to stare at, and a trigger for connections | Always; especially when stuck | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Two-tier note-taking**: highlight the promising facts, quarantine the crazy ones on separate scratch paper | Your page of facts is getting long | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Triage the fact-dump by matching logical form** — equalities for equality goals, inequalities for bounds and case-elimination | The dump is long and undifferentiated | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Look for the formula that *collapsed* under your new notation** — collapse is the signal that formula and problem are aligned | Just after choosing notation | [01 — Problem 1.1 ($s=3b/2$)](01-strategies-in-problem-solving.md) |
| **Write down every fact however trivial — collect "iotas"** ("even shallowly dug gold has to be held on to") | Early exploration | [02 — Problem 2.2](02-number-theory.md); [06 — Problem 6.4 (the closing checklist)](06-sundry-examples.md) |
| **Restate the reformulated problem cleanly, in a box** | Your reformulation has drifted from the original wording | [05 — Problem 5.1](05-analytic-geometry.md) |
| **Periodic inventory: stop and list exactly what has been established** — both an error check and the thing that reveals the next move | Long multi-stage argument | [03 — Problem 3.4](03-algebra-and-analysis.md); [06 — Problem 6.2](06-sundry-examples.md) |
| **Notational vigilance about non-uniform symbols** (a $\pm$ that is *not* the same sign at every index) | A sign or index varies silently | [03 — Problem 3.4](03-algebra-and-analysis.md) |
| **Reuse one worked example throughout so you can reuse the arithmetic** | Repeated numeric sanity checks | [02 — Problem 2.7 ($p=5$ over and over)](02-number-theory.md); [05 — Problem 5.1](05-analytic-geometry.md) |
| **Choose the granularity of your table so the *cause* of a pattern is visible, not just the pattern** | You are about to tabulate | [02 — Problem 2.5 (tabulate $1^n,2^n,3^n,4^n$ separately)](02-number-theory.md) |
| **Tabulate; let row and column sums force entries and yield new equations** | Multi-dimensional bookkeeping with partial information | [06 — Problem 6.2](06-sundry-examples.md); [02 — Problem 2.2](02-number-theory.md); [05 — Problem 5.1](05-analytic-geometry.md) |
| **The final checklist, in two columns**: plain English on the left, algebra on the right — writing the English first stops you dropping facts you cannot yet symbolize | Any information-starved puzzle | [06 — Problem 6.4](06-sundry-examples.md) |
| **Defer a routine lemma to the end to keep the narrative clean** | A sub-fact is obvious but needs saying | [02 — Problem 2.7](02-number-theory.md) |
| **Discovery is not presentation — tidy the messy search into a clean chain afterwards** | You have found the answer | [04 — Problem 4.6](04-euclidean-geometry.md); [05 — Exercise 5.1](05-analytic-geometry.md) |
| **Isolate a sub-step in its own minimal "reduced diagram" (factor out a lemma)** | A step of your proof needs its own proof | [01 — Preface, perpendicular bisectors](01-strategies-in-problem-solving.md); [04 — Problem 4.2](04-euclidean-geometry.md) |

---

### E. Reformulation and translation

| Technique | Trigger | Where |
|---|---|---|
| **Reformulate a predicate into one that *composes*** (line-membership → equal distances, because equality is transitive) | Your objects can't be chained | [01 — Preface, perpendicular bisectors](01-strategies-in-problem-solving.md) |
| **Recast the problem into a different branch of mathematics entirely** | The statement is geometric (or verbal) but no in-branch theorem fits | [05 — all four problems](05-analytic-geometry.md); [06 — Problem 6.3](06-sundry-examples.md) |
| **Rewrite geometry as vectors, coordinates, or complex numbers** | Lengths, midpoints, centroids, sums over symmetric configurations | [05 — Problem 5.1, Exercise 5.1](05-analytic-geometry.md) |
| **Reinterpret the algebra in physics; import an outside theorem** | Your expression matches a physical quantity | [05 — Problem 5.1 (moment of inertia, Steiner's theorem)](05-analytic-geometry.md) |
| **Recognize that an identity is about a *structure*, not about numbers** — a derivation using only $+,-,\times,\div$ transfers to matrices/polynomials/anything with a ring structure (convergence, order and sign must be re-earned) | Your derivation used only ring operations | [03 — chapter opener (Neumann series)](03-algebra-and-analysis.md) |
| **Move every "$a$ divides $b$" statement into modular arithmetic** | Any divisibility statement | [02 — Problems 2.2, 2.4, 2.5, 2.6, 2.7, Exercises 2.2, 2.3, 2.6](02-number-theory.md); [06 — Problem 6.4](06-sundry-examples.md) |
| **Choose the representation that suits the goal** (product form, not sum form, when the goal is divisibility) | The same object can be written two ways | [02 — Problem 2.6 ($n(n+1)/2$, not $1+2+\cdots+n$)](02-number-theory.md) |
| **Recast a constraint as the root set of a polynomial, then factorize** | Your constraint is a polynomial equation | [03 — Problem 3.3](03-algebra-and-analysis.md) |
| **Shift by a constant to convert a value statement into a root statement** | You know a polynomial takes a fixed value at many points | [03 — Problem 3.4 ($p(x)-1$ has $n$ roots)](03-algebra-and-analysis.md) |
| **Normalize the data into its simplest equivalent form** (clear denominators) — and certify the equivalence | Your hypothesis has fractions, radicals, nesting | [03 — Problem 3.3](03-algebra-and-analysis.md) |
| **Restate the problem in several equivalent forms, hoping one matches a theory you know** | You have a model but no theory | [06 — Problem 6.3 (chocolate → lattice walk → two-row counters ≈ Nim)](06-sundry-examples.md) |
| **Model the moves as vectors and describe the whole reachable set** | "Start here, apply these operations, can you reach that?" | [06 — Problem 6.1](06-sundry-examples.md) |
| **Reduce a real-world problem to mathematics by formalizing the legal moves** | The problem is about chocolate, sheep, chameleons | [06 — Problem 6.1, Problem 6.3, Problem 6.4](06-sundry-examples.md) |
| **Encode unknown binary choices as a two-colouring** | Each object independently has one of two properties | [05 — Problem 5.2 (green/red rectangles)](05-analytic-geometry.md) |
| **Change variables to make the terminal position clean** | An off-by-one is polluting every formula | [06 — Problem 6.3 (subtract 1 from each coordinate)](06-sundry-examples.md) |
| **Choose a canonical representative to kill a "distinct values" condition** | You must count each value once | [05 — Problem 5.1 (only diagonals from $A_1$, restricted to a semicircle)](05-analytic-geometry.md) |
| **Introduce a prettier auxiliary quantity and compute *that* instead; then recover the original** | Your target has case splits or ugly endpoints | [05 — Problem 5.1 (compute $Y$, recover $X$)](05-analytic-geometry.md) |
| **Symmetrize / "double up" an asymmetric sum, and add a zero term for the sake of symmetry** | A sum stops at an unnatural index, or is missing one | [05 — Problem 5.1](05-analytic-geometry.md); [02 — Problem 2.7](02-number-theory.md) |
| **Treat symmetry as a *compatibility* property, not an aesthetic one** — a sum over the full range is one that standard formulas and bijections will accept as input | You are deciding whether to fold or extend a sum | [02 — Problem 2.7](02-number-theory.md) |
| **Algebraically massage the objective** (cross-multiply, swap ratios) until it matches a theorem's shape | You are one syntactic step from something recognizable | [04 — Problem 4.3](04-euclidean-geometry.md) |
| **Reformulate the objective into a symmetric form with fewer equalities** | Your goal is a chain of several equalities | [04 — Problem 4.3](04-euclidean-geometry.md) |
| **Substitute an equal quantity so the object joins a usable configuration** | The length you want is in no useful triangle | [04 — Problem 4.3 ($\lvert FE\rvert = \lvert AB\rvert$)](04-euclidean-geometry.md) |
| **Rewrite obscure quantities as "friendly"/"mainstream" ones**, and choose between decompositions by which leaves friendlier pieces | Your objective mentions things that touch nothing else | [04 — Problem 4.6](04-euclidean-geometry.md) |
| **Express the obscure quantity in terms of the non-obscure ones** | Your target sits at an unremarkable point | [04 — Problem 4.1 (the angle at $M$)](04-euclidean-geometry.md) |
| **Restate the goal about the object you can actually parametrize** | The goal names an awkward object | [04 — Problem 4.5 (prove things about $R_1$, not $R_0$)](04-euclidean-geometry.md) |
| **Restate "prove $X$" as "characterize which configurations are allowed"** | The objective is a shape or rigidity claim | [04 — Problem 4.5](04-euclidean-geometry.md) |
| **The same equation read from a different object gives a different equation — pick the most tractable face** | You have one messy relation | [04 — Problem 4.5](04-euclidean-geometry.md) |
| **Turn "why can't this happen?" into positive structure** (blocking implies there is a *barrier*, and the barrier is itself a chain) | You assumed something is impossible | [05 — Problem 5.2](05-analytic-geometry.md) |
| **Audit every reformulation for logical validity** — "one cannot just jump from one form to another without care" | You replaced object A with object B | [02 — Problem 2.7 (reduced vs unreduced numerator; legality of dividing mod $n$)](02-number-theory.md); [03 — Problem 3.3](03-algebra-and-analysis.md) |
| **Track the logical direction of every weakening** — which way does the answer transfer? | You have just weakened a statement | [02 — Problem 2.2 ("But the reverse is far from true")](02-number-theory.md) |
| **Re-read your own reformulation and grade it before improving it** | You just produced a new version of the question | [02 — Problem 2.2](02-number-theory.md) |

---

### F. Simplification and reduction

| Technique | Trigger | Where |
|---|---|---|
| **Reduce the problem into successively simpler sub-problems** — named by Tao as one of the two categories of learnable trick, and as an overall strategy in its own right ("we keep reducing… until it just collapses into nothing") | The problem is too big to attack in one move | [01 — 1st-ed. preface](01-strategies-in-problem-solving.md); [02 — Problem 2.7](02-number-theory.md) |
| **Consider a special case — including extreme and degenerate cases** | You cannot get started at all | [01 — Problem 1.1 ($d=0$)](01-strategies-in-problem-solving.md); [04 — Problem 4.3](04-euclidean-geometry.md); [05 — Problem 5.1 ($n=2$, flagged as suspect)](05-analytic-geometry.md); [03 — Problem 3.1](03-algebra-and-analysis.md) |
| **Try small cases first, to get a "feel"** | You do not yet know the general pattern | [03 — Problem 3.1, Problem 3.2](03-algebra-and-analysis.md); [05 — Problem 5.1](05-analytic-geometry.md); [06 — Problem 6.3](06-sundry-examples.md) |
| **Do the simplest *non-trivial* case** | The general configuration is unmanageable | [05 — Problem 5.2 (two-rectangle partition)](05-analytic-geometry.md) |
| **Skip the expensive data point** | One small case costs far more than its neighbours | [05 — Problem 5.1 (skip $n=5$, do $n=6$)](05-analytic-geometry.md) |
| **Dosage rule: start with modest assumptions; beware the case that is *too* special** | You are choosing how hard to perturb | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Solve a simplified version, or the lower-dimensional analogue** | A complication can be dropped | [05 — Problem 5.2 (segments instead of rectangles)](05-analytic-geometry.md); [01 — sub-move 6(b)](01-strategies-in-problem-solving.md) |
| **Harvest the essential *ingredient* from a failed analogue** | The analogue doesn't generalize | [05 — Problem 5.2 ("a sum of integers is an integer" is all you get)](05-analytic-geometry.md) |
| **Solve the easier analogue first as necessary reconnaissance** | Your target is a strengthened version of something familiar | [02 — Problem 2.7 (mod $p$ before mod $p^2$)](02-number-theory.md) |
| **Characterize the easier of two coupled objects first** | The problem couples object A with object B | [02 — Problem 2.2 ("let us tackle powers of 2 first")](02-number-theory.md) |
| **Prove something *stronger* because it is *simpler*** — drop the unusable baggage | The literal statement carries baggage you can't use | [02 — Problem 2.1 (multiples of 18), Problem 2.2](02-number-theory.md); [06 — Problem 6.1](06-sundry-examples.md); [01 — sub-move 6(c)](01-strategies-in-problem-solving.md) |
| **Strengthen the induction hypothesis** — put exactly the missing fact into the statement being proved, then specialize back at the end | Your induction step wishes it had one more fact | [03 — Problem 3.1 (Lemma 3.1)](03-algebra-and-analysis.md) |
| **Derive a weaker consequence and prove that first; reduce the strength of what must be proved** | The full statement is out of reach | [02 — Problem 2.7 ($p^2$-divisibility down to $p$-divisibility)](02-number-theory.md); [01 — sub-move 6(d)](01-strategies-in-problem-solving.md) |
| **Trade a locally uglier expression for a globally weaker obligation** — expressions are yours to complicate; obligations are what you must discharge | You can extract a factor at the cost of a mess | [02 — Problem 2.7](02-number-theory.md) |
| **Stepping stones: insert an intermediate statement so that data ⇒ B ⇒ goal** | Hypothesis and conclusion "do not mix" | [02 — Problem 2.1](02-number-theory.md); [04 — Problem 4.5 (equal areas ⇒ $a+b=1$ ⇒ square)](04-euclidean-geometry.md) |
| **Judge a stepping stone by its *second* arrow, and test it numerically before investing** | You have a candidate intermediate | [02 — Problem 2.1](02-number-theory.md) |
| **Upgrade a stepping stone that works but costs too much** | Your stone is valid but leaves loose ends | [02 — Problem 2.1 (multiples of 9 → multiples of 18)](02-number-theory.md) |
| **Generalize the problem** | The specific case hides the pattern under coincidences | [03 — Problem 3.2](03-algebra-and-analysis.md); [06 — Problem 6.1](06-sundry-examples.md); [01 — sub-move 6(g)](01-strategies-in-problem-solving.md) |
| **Recognize over-generalization and pull back** ("let us reel ourselves in again") | Your weakened question now has the *wrong answer* | [02 — Problem 2.2](02-number-theory.md) |
| **Modify the problem significantly: push it until it breaks, then locate the breakdown** | You want the problem's architecture, not its answer | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Change the object in the problem** (triangle → quadrilateral, circle) | Structural curiosity; you suspect the shape is incidental | [01 — Problem 1.1 (tried; dead end, reported)](01-strategies-in-problem-solving.md) |
| **Delete a datum: if the problem dies, that datum is load-bearing** | You don't know what matters | [01 — Problem 1.1 (delete $d$: many solutions; delete $t$: none)](01-strategies-in-problem-solving.md) |
| **Partially weaken data** (equality → inequality) — but only after the simple options | Clean deletions are exhausted | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Reverse the problem: swap the data with the objective** (a deformation / continuity argument instead of an equation) | Direct attack stalls | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Negate the objective: try to *disprove* the statement** | You suspect it is false, or you want to see the obstruction | [01 — sub-move 7(f)](01-strategies-in-problem-solving.md); [05 — Problem 5.2](05-analytic-geometry.md) |
| **Robustness testing: weaken your own hypotheses and see which parts of the proof were load-bearing** | You just finished a proof | [03 — Exercises 3.2, 3.3](03-algebra-and-analysis.md) |
| **Relax constraints safely when proving a negative** | You are proving impossibility | [06 — Problem 6.1](06-sundry-examples.md) |
| **Alter or relax the requirements the object must satisfy, then use pure elimination** | A "Find a…" problem with unmanageable requirements | [01 — Technique 1, the hotel example](01-strategies-in-problem-solving.md) |
| **Normalize using a scaling/dimensional law to delete a parameter; normalize units** | The problem is scale-covariant | [01 — Problem 1.1 (set $t=1$)](01-strategies-in-problem-solving.md); [05 — Problem 5.4 (pool side = 1)](05-analytic-geometry.md) |
| **Spend a degree of freedom the configuration gives you free (WLOG), and certify that nothing is lost** | The configuration can slide/scale/rotate/relabel without breaking a condition | [04 — Problem 4.4](04-euclidean-geometry.md); [05 — Problem 5.4 (teacher starts at corner $A$)](05-analytic-geometry.md); [06 — Problem 6.2 (impose an ordering)](06-sundry-examples.md); [03 — Problem 3.4 (flip both signs)](03-algebra-and-analysis.md) |
| **WLOG is a labour-saving device — name the size of the saving rather than overclaiming** | You face two cases, one convertible into the other | [03 — Problem 3.4](03-algebra-and-analysis.md) |
| **Symmetric case reduction ("the case $r=s=-1$ is similar")** | Two cases differ only by a sign flip | [03 — Problem 3.4](03-algebra-and-analysis.md) |
| **Use symmetry to cut the case count** | The object is symmetric under swapping coordinates | [06 — Problem 6.3](06-sundry-examples.md); [05 — Problem 5.4](05-analytic-geometry.md) |
| **Eliminate variables one at a time; eliminate the shared unknown** | A system with several unknowns; the same quantity in two equations | [04 — Problem 4.2 ($\lvert OA\rvert$ divides out), Exercise 4.1](04-euclidean-geometry.md) |
| **Eliminate a nuisance variable by taking a modulus** | An unknown appears only as a multiple of a fixed number | [06 — Problem 6.4 (mod 20 deletes $n$)](06-sundry-examples.md) |
| **Split a composite divisor into coprime factors and prove each separately** | The divisor factors as $d_1d_2$ with $\gcd=1$ | [02 — Problem 2.6](02-number-theory.md) |
| **Case analysis on parity; or multiply through by 2 to clear an inconvenient fraction** | An unavoidable "/2" or a $(-1)^n$ | [02 — Problem 2.6, Problem 2.3](02-number-theory.md); [03 — Problem 3.2 (Lemma 3.2)](03-algebra-and-analysis.md) |
| **Case analysis with an immediate-win branch** | An unknown binary choice, one branch of which finishes | [05 — Problem 5.2](05-analytic-geometry.md) |
| **Case analysis on a factored condition** (a product is zero, so some factor is zero) | Your hypothesis reduces to "$P=0$ or $Q=0$ or $R=0$" | [03 — Problem 3.3](03-algebra-and-analysis.md) |
| **Reduce a variant to the version you already solved by a change of variable** (a misère game becomes the normal game by setting aside one counter) | You solved the cousin, not this | [06 — Exercise 6.6](06-sundry-examples.md) |
| **Recognize an already-solved sub-problem inside the new one — possibly with the players' roles reversed** | The position after your move looks familiar | [06 — Problem 6.3 ($3\times3 \to 2\times3$)](06-sundry-examples.md) |

---

### G. Search, experiment and guessing

| Technique | Trigger | Where |
|---|---|---|
| **Generate data, tabulate it, and stare at it** | You have no idea what is going on | [02 — Problems 2.1, 2.2, 2.5, 2.7](02-number-theory.md); [05 — Problem 5.1](05-analytic-geometry.md); [06 — Problem 6.3](06-sundry-examples.md) |
| **Read data for density and absence-of-structure, not only for structure** | Your table shows no pattern | [02 — Problem 2.2](02-number-theory.md) |
| **Two-stage pattern reading**: notice the fact you *need* ("they are far apart"), then the stronger structural fact you can *prove* ("they are regularly spaced") | You spotted something vague | [02 — Problem 2.2](02-number-theory.md) |
| **Admit openly when the data is inconclusive** | Your table shows nothing | [05 — Problem 5.1](05-analytic-geometry.md) |
| **Conjecture from data, then prove** | A pattern is visible | [05 — Problem 5.1 ($Y=2n$)](05-analytic-geometry.md); [06 — Problem 6.3](06-sundry-examples.md) |
| **Small cases are for *generating* conjectures, and one data point is not a pattern** | You want to commit to a conjecture | [06 — Problem 6.3](06-sundry-examples.md) |
| **A pattern from small cases can generalize the wrong way** — commit slowly | The 2-D rule looks like a law | [06 — Exercise 6.7 (squares vs nim-sum zero)](06-sundry-examples.md) |
| **Mine the special case for *mechanism*, not for the answer** — the test is whether you can describe the intermediate numbers in words | You solved a case and want the general proof | [05 — Problem 5.2](05-analytic-geometry.md); [02 — Problem 2.7 ($p=5$ mod 25 is a fluke; $p=5$ mod 5 shows the way)](02-number-theory.md) |
| **Read the *shape* of the answer off a special case even when it gives no method** | Your special case is solvable but uninstructive | [01 — Problem 1.1 ($d=0$ predicts fourth roots)](01-strategies-in-problem-solving.md) |
| **Guess the answer first from circumstantial evidence** (competition provenance; a "yes" would be merely computational) | Yes/no question | [02 — Problem 2.2](02-number-theory.md); [06 — Problem 6.1](06-sundry-examples.md) |
| **Guess a solution, verify it against all hypotheses, then reduce "find" to "prove uniqueness"** | You spot a pattern in your small cases | [03 — Problem 3.2](03-algebra-and-analysis.md) |
| **Intelligent guess + verification, not trial and error** — the existence branch is only cheap if you can generate good guesses | An existence question | [05 — Problem 5.4](05-analytic-geometry.md) |
| **Guessing is part of the official method: "guess *and prove* an intermediate result"** — you may write down a lemma you cannot derive, provided you discharge it | You need a lemma and have no derivation | [03 — Problem 3.3](03-algebra-and-analysis.md) |
| **Experimentation is a legitimate, nameable step**: structure narrows the candidate list, trial-and-error picks off it | Structure narrowed but did not choose | [03 — Problem 3.3](03-algebra-and-analysis.md) |
| **Experiment first, then conclude "something special is needed" — and order the experiment so it is informative** | A construction resists freehand drawing | [04 — Problem 4.4 ("try it, but draw the parallel lines first")](04-euclidean-geometry.md) |
| **A model is not yet a grip — after formalizing, go and experiment** | You finished formalizing and feel no closer | [06 — Problem 6.3](06-sundry-examples.md) |
| **Test-drive the mechanism on a concrete number to check you understood the rules** | The rules are procedural | [06 — Problem 6.4 (try 64 rubles)](06-sundry-examples.md) |
| **Explore first so that you end up with "something definite to prove"** — if you cannot start, you may lack a *claim*, not a proof | Open-ended question, nothing to attack | [06 — Problem 6.1](06-sundry-examples.md) |
| **Prove small results and play with the data, especially when stuck** — it gives you something to do, and the space of consequences is where the answer lives | Stuck | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Make functional dependence explicit** ($b = b(d,t)$); read a theorem as a function signature | The answer depends on parameters | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Derive a symmetry mini-result and a scaling/dimensional mini-result; consider differentiating with respect to a parameter** | You have a parameterized answer | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Look ahead: simulate where a technique could *hope* to take you before investing in it** | About to start a long computation | [01 — Problem 1.1 (Heron will leave a polynomial in $b$)](01-strategies-in-problem-solving.md) |
| **Cost out and rank candidate tools before committing** ("slow-but-steady" vs "promising") | Two or three methods all look viable | [05 — Problem 5.1](05-analytic-geometry.md); [04 — Problem 4.2](04-euclidean-geometry.md) |
| **Screen candidate tools against your hypotheses before investing** (AM–GM and Cauchy–Schwarz need positivity) | Tempted by a big-name theorem | [03 — Problem 3.3](03-algebra-and-analysis.md); [04 — Problem 4.2 (five length↔angle mechanisms, four crossed off)](04-euclidean-geometry.md) |
| **Enumerate the remaining routes explicitly** ("only two ways: an intermediate result, or a useful substitution") | You are out of ideas but not out of structure | [03 — Problem 3.3](03-algebra-and-analysis.md) |
| **Prefer a parameterization as your intermediate result, since it substitutes directly into the goal** | You need an intermediate result and have a choice | [03 — Problem 3.3](03-algebra-and-analysis.md) |
| **Stick with the easy options before the exotic ones** | An exotic method suggests itself | [03 — Problem 3.3 (contour calculus deferred)](03-algebra-and-analysis.md); [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Prune the strategy space with common sense before computing anything — and don't over-prune** | A huge space of strategies | [05 — Problem 5.4](05-analytic-geometry.md) |
| **Throw out the obviously bad move first** — nearly free, and it orients the search | A game with an evident non-starter | [05 — Problem 5.4 (heading straight for the teacher)](05-analytic-geometry.md) |
| **Test candidate strategies numerically and kill them with arithmetic** | You have a first guess | [05 — Problem 5.4 (0.707 vs 0.667)](05-analytic-geometry.md) |
| **Read a near-miss or an exact tie as a signal about the problem's constants** | A strategy fails by a hair | [05 — Problem 5.4](05-analytic-geometry.md) |
| **Perturb the given constant to see which regime you are in** | A knife-edge case | [05 — Problem 5.4, Exercise 5.2](05-analytic-geometry.md) |
| **Stop hand-waving and compute when common sense is split** | Intuition gives no verdict | [05 — Problem 5.4](05-analytic-geometry.md) |
| **Guess simple candidate quantities first and kill them fast; build a counterexample to eliminate one** | You need an invariant/monovariant and have no idea which | [05 — Problem 5.3 (points, lines, intersections)](05-analytic-geometry.md); [06 — Problem 6.1 (total population)](06-sundry-examples.md) |
| **Widen the candidate list before you narrow it — you are licensed to *invent* a scoring function** | Hunting for a measure | [05 — Problem 5.3 ("like a dart board")](05-analytic-geometry.md) |
| **Self-prompt with an explicit written question when stuck** | You have run out of moves | [02 — Problem 2.2, Problem 2.4](02-number-theory.md) |
| **Search your recent toolbox by name** ("fresh from Problem 2.6, we know symmetry can be exploited") | You need a non-random first idea | [02 — Problem 2.7](02-number-theory.md) |
| **Deliberately replay the move that just worked, on the next case** | A case just fell to a specific tactic | [03 — Problem 3.2](03-algebra-and-analysis.md) |
| **Escalate a trivial bound by analogy with the bound one level down** | "$f(\text{anything})\ge1$" wasn't enough | [03 — Problem 3.1](03-algebra-and-analysis.md) |
| **Notice cross-problem analogies and deliberately reuse a clue that just worked** | A move has a familiar shape | [03 — Problem 3.2 vs Problem 3.1](03-algebra-and-analysis.md); [06 — Problem 6.3](06-sundry-examples.md) |
| **Examine solutions of similar problems; cite your own earlier success as evidence of tractability** | You need a bearing | [01 — Problem 1.1](01-strategies-in-problem-solving.md); [06 — Problem 6.4](06-sundry-examples.md) |
| **Look for things that vaguely trigger a memory** — trawl on weak signals (fires late, "usually only after all other means have failed") | An expression looks *familiar* rather than tractable | [04 — Problem 4.3 (power of a point)](04-euclidean-geometry.md) |
| **Maintain a personal stock of surprising-but-elementary facts, so memory-triggers have something to fire on** | Long-term preparation | [04 — Problem 4.1](04-euclidean-geometry.md) |
| **Draw a diagram and label everything you can — and honestly assess when it adds nothing** | Always, first move | [04 — every problem](04-euclidean-geometry.md); [01 — Problem 1.1 ("does not seem to add much")](01-strategies-in-problem-solving.md); [05 — Problem 5.1](05-analytic-geometry.md) |
| **Label the picture for the *general* case** (indexed labels $A_1,\dots,A_n$, not $A,B,C$) | A configuration with a free parameter | [05 — Problem 5.1](05-analytic-geometry.md) |
| **Name the unnamed points, especially intersections and special centres** | Your objective mentions objects that cross | [04 — Problem 4.1 (incentre $I$, $M = AD\cap EF$)](04-euclidean-geometry.md) |
| **Draw several configurations, not one** | The data can be satisfied in genuinely different ways | [04 — Problem 4.2](04-euclidean-geometry.md) |
| **Cheat the diagram: draw the special case you are being asked to prove; draw the figure by peeking at the conclusion** | The data is hard to realize by hand | [04 — Problem 4.2, Problem 4.3](04-euclidean-geometry.md) |
| **Draw a reduced diagram — delete the clutter, rotate and enlarge** | The full figure has more points than your sub-argument needs | [04 — Problem 4.2](04-euclidean-geometry.md) |
| **Measure the diagram to generate candidates — use the drawing as a cheap fallible oracle** | You need to guess which sub-figures matter | [04 — Problem 4.2](04-euclidean-geometry.md) |
| **Draw a figure and guess the conclusion from it — the zeroth-order method — and notice when it fails, because the failure is a diagnosis** | Before any real work | [04 — Problem 4.3](04-euclidean-geometry.md) |
| **Flood-fill all the cheap quantities first, even without a plan** | A diagram with many derivable quantities | [04 — Problem 4.1](04-euclidean-geometry.md) |
| **Choose the sub-figure with the most already-known quantities, not just the one containing your target** | Several sub-figures contain your unknown | [04 — Problem 4.2](04-euclidean-geometry.md) |
| **When both sides land in the same sub-figure, focus there** | Your two expressions now share a triangle | [04 — Problem 4.6](04-euclidean-geometry.md) |
| **Wriggle the configuration to see why it is rigid; let the wriggling tell you which object generates the others** | You suspect a hypothesis over- or under-determines things | [04 — Problem 4.5](04-euclidean-geometry.md) |
| **Count degrees of freedom against anchors/constraints** | You need to know whether the problem is determined | [04 — Problem 4.4](04-euclidean-geometry.md); [03 — Problem 3.4](03-algebra-and-analysis.md); [05 — Problem 5.4](05-analytic-geometry.md) |
| **Constructions: "solve for" the unknown, just like algebra; determine a locus for it** | Straightedge-and-compass problems | [04 — Problem 4.4, Exercises 4.1–4.3](04-euclidean-geometry.md) |
| **Shift the unknown to a simpler unknown — ideally a single point, but only one that determines the rest** | The unknown object is complicated | [04 — Problem 4.4, Exercise 4.3](04-euclidean-geometry.md) |
| **Construct the object your theorem needs** (create the circle) | A theorem almost applies but an object is missing | [04 — Problem 4.3](04-euclidean-geometry.md) |
| **Do NOT spam constructions — unless you are really stuck** | Tempted to draw every auxiliary line | [04 — Problem 4.3](04-euclidean-geometry.md) |
| **Write down a deliberately vague strategy** | You have aims but no proof | [05 — Problem 5.2 (the boxed "find either a chain of…")](05-analytic-geometry.md) |
| **Speculate in plain words, then say "to be specific" and convert to (in)equalities** | You have a hunch you can't justify | [06 — Problem 6.2](06-sundry-examples.md); [05 — Problem 5.3](05-analytic-geometry.md) |
| **Use a computer for facts that are not part of the proof — and know which facts are load-bearing** | Optimality / sanity claims | [02 — Problem 2.1 ("I used a computer for that")](02-number-theory.md) |

---

### H. Exploiting structure: invariants, symmetry, modular arithmetic, monovariants

| Technique | Trigger | Where |
|---|---|---|
| **Hunt for a conserved quantity (an invariant), starting with the obvious ones** | You want to prove something is *unreachable* / impossible | [06 — Problem 6.1](06-sundry-examples.md); [02 — Problem 2.2 (invariants of digit-switching)](02-number-theory.md) |
| **Diagnose an invariant as too coarse when it fails to separate start from target — then refine it, don't discard it** | Your invariant doesn't distinguish the states | [06 — Problem 6.1](06-sundry-examples.md); [02 — Problem 2.2](02-number-theory.md) |
| **Patch a partially-working idea instead of binning it; let the *shape of the failure* specify the fix** | An idea handles some cases and breaks on others | [06 — Problem 6.1 (cyclic failure ⇒ cyclic arithmetic)](06-sundry-examples.md) |
| **Check the direction of your implication before banking an invariant** — the gap the weakening opens must be narrow | You found an invariant | [02 — Problem 2.2](02-number-theory.md) |
| **Estimate the base rate of accidental agreement before trusting an invariant** (small-valued invariants collide by luck) | Your invariant takes few values | [02 — Problem 2.2 (the 9.5% birthday-paradox calculation)](02-number-theory.md) |
| **Assign weighted point scores (a linear functional) as a candidate invariant** | Objects come in a few types and operations swap types | [06 — Problem 6.1, Exercise 6.1](06-sundry-examples.md) |
| **Use an everyday physical analogy as an idea generator** | You need a candidate and have no lead | [06 — Problem 6.1 (water levels; coloured light beams)](06-sundry-examples.md) |
| **Focus on the *operation*, not just the state — ask what the problem's verb is** | The state has no obvious structure but the moves do | [06 — Problem 6.1 ("merging can be focussed on")](06-sundry-examples.md); [05 — Problem 5.3](05-analytic-geometry.md) |
| **Go modular to make a cyclic structure literal; try successive moduli, and pick the one matching the problem's symmetry** | Operations cycle; a quantity is "almost" conserved | [06 — Problem 6.1 (mod 2 fails, mod 3 works — three colours)](06-sundry-examples.md) |
| **Choose the modulus to *annihilate* a term** — enumerate the terms and try to kill each | An equation with one awkward term | [02 — Problem 2.4](02-number-theory.md); [06 — Problem 6.4](06-sundry-examples.md) |
| **Choose the modulus to *constrain* the survivors** (mod 2 → mod 4, because squares are rigid mod 4) | Killing a term left the rest unrestricted | [02 — Problem 2.4](02-number-theory.md) |
| **Use a variable modulus containing the unknown** ($n \equiv -c \bmod (n+c)$ collapses polynomials) | A polynomial in $n$ must be divisible by something in $n$ | [02 — Exercise 2.2](02-number-theory.md) |
| **Know "what is rigid mod what"** — squares are $0,1$ mod 4; fourth powers are $0,1$ mod 5; squares mod 20 are only $0,1,4,5,9,16$ | A square or a fixed power appears in a congruence | [02 — Problem 2.4, Exercise 2.3](02-number-theory.md); [06 — Problem 6.4](06-sundry-examples.md) |
| **Where you need square roots modulo a *composite*, write out the table of squares — do not trust $\pm\sqrt{\ }$** | Composite modulus | [06 — Problem 6.4 (the slip on p. 97)](06-sundry-examples.md) |
| **Periodicity of powers: find $T$ with $a^T\equiv1$, then check one period — and combine periodicity with a growth rate to force a contradiction** | An exponent is a free parameter | [02 — Problem 2.2, Problem 2.5](02-number-theory.md) |
| **Factorization into (factor)×(factor) = something rigid; the difference of two squares** | Diophantine equation | [02 — Problem 2.4](02-number-theory.md) |
| **Growth / gap arguments** (gaps between consecutive squares exceed 4; six doublings is a factor of 64) | Two integer quantities must be equal but grow differently | [02 — Problem 2.3, Problem 2.2](02-number-theory.md) |
| **Quadratic formula ⇒ the discriminant must be a perfect square** | Two integer unknowns appear quadratically | [02 — Problem 2.3](02-number-theory.md) |
| **Re-classify your own finished solution** ("the algebra was a factorization technique in disguise") | You finished and want to file the method | [02 — Problem 2.3](02-number-theory.md) |
| **Spot the disguised quadratic** (a quartic in $b$ that is a quadratic in $b^2$) | Degree 4 in $x$, degree 2 in $x^2$ | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Symmetry, anti-symmetry, and pairwise cancellation** ($p-j \equiv -j$; $(-a)^k = -a^k$ for odd $k$); "symmetry is nice to keep, anti-symmetry is nice to cancel"; "doubling up" to restore symmetry | A sum runs symmetrically over a modulus | [02 — Problem 2.6, Problem 2.7](02-number-theory.md) |
| **When cancellation leaves an unpaired middle term, compute its residue rather than abandoning** | An odd-length sum won't fold cleanly | [02 — Problem 2.6](02-number-theory.md) |
| **Rearrangement / bijection: a sum is invariant under a permutation of its index set** | A map permutes the index set | [02 — Problem 2.7, Exercise 2.6](02-number-theory.md) |
| **Kill a surviving sum with a closed-form formula** | A sum of standard shape survives | [02 — Problem 2.7 ($\sum i^2 = n(n+1)(2n+1)/6$)](02-number-theory.md) |
| **Compute one total two different ways and equate the results** | A quantity is summable along two axes | [06 — Problem 6.2 ($N(x+y+z)=39$)](06-sundry-examples.md); [02 — Problem 2.7](02-number-theory.md) |
| **Find a single local obstruction (one prime, one modulus) rather than global control** | You need to prove "no solutions" | [02 — Exercise 2.3](02-number-theory.md) |
| **Ask whether your quantity has macroscopic or microscopic structure, and match it to the question** | Choosing an invariant's granularity | [02 — Problem 2.2](02-number-theory.md) |
| **Heuristic / probabilistic plausibility check on whether an approach *can* work** | Before investing | [02 — Problem 2.2](02-number-theory.md) |
| **Exploit symmetry — and then upgrade the hand-waving symmetry argument to a rigorous one** | Any configuration invariant under a rotation/reflection | [05 — Problem 5.1 (rotate by $360^\circ/n$; a fixed vector must be zero)](05-analytic-geometry.md) |
| **A symmetry that *negates* a quantity forbids that quantity from being monotone** | Ruling out a monovariant candidate | [05 — Problem 5.3 (reflect the plane: orientations flip, lengths don't)](05-analytic-geometry.md) |
| **Monovariant + finiteness ⇒ termination**; and a *decreasing* quantity is a monovariant too — direction is a convention, monotonicity is the content | "Can this go on forever?" | [05 — Problem 5.3](05-analytic-geometry.md); [06 — Problem 6.3 (the bar's size decreases)](06-sundry-examples.md) |
| **Distinguish invariants (useless here) from monovariants** | You need to prove a process halts, not that a state is unreachable | [05 — Problem 5.3](05-analytic-geometry.md) |
| **Prefer the computable quantity over the most meaningful one** | Two candidates both capture the intuition | [05 — Problem 5.3 (sum of *lengths*, not inter-segment distances)](05-analytic-geometry.md) |
| **Narrow the search by matching the measure to what the operation touches** | Hunting for an invariant/monovariant | [05 — Problem 5.3](05-analytic-geometry.md) |
| **Enumerate exhaustively the few properties available** (length, position, orientation) | You want a complete candidate list | [05 — Problem 5.3](05-analytic-geometry.md) |
| **Prove monotonicity with the triangle inequality** | Segments get swapped or rerouted | [05 — Problem 5.3](05-analytic-geometry.md) |
| **Find what stays fixed across all the unknown configurations** | Many possible arrangements, none pinned down | [06 — Problem 6.2 (per-exam total is always $x+y+z$)](06-sundry-examples.md) |
| **Parity of a permutation as an invariant — track the *ordering*, not the positions** | Objects hop over each other | [06 — Exercise 6.2](06-sundry-examples.md) |
| **An invariant need not be a number — it can be membership of a set** (staying in $\mathbb{Z}^2$, then in $(2\mathbb{Z})^2$) | Lattice-preserving moves | [06 — Exercise 6.3](06-sundry-examples.md) |
| **Exploit reversibility: attack from whichever end has the stronger invariant** | The process runs both ways | [06 — Exercise 6.3](06-sundry-examples.md) |
| **Find a modulus that no legal move is divisible by — its multiples are exactly the losing positions** | Subtraction games | [06 — Exercise 6.5](06-sundry-examples.md) |
| **Nim-sum (XOR) as the invariant for multi-heap games** | Several independent heaps | [06 — Exercise 6.7](06-sundry-examples.md) |
| **Pairing / complete-to-a-fixed-round-total strategy** | A game where you can always answer a move | [06 — Exercise 6.4](06-sundry-examples.md) |
| **Recognize a known combinatorial pattern** ("either A connects left–right or B connects top–bottom" is Hex duality) | Your dichotomy has a famous shape | [05 — Problem 5.2](05-analytic-geometry.md) |
| **Analogy from other games** (Sprouts' exit count as a model for a monovariant) | You need a framework for a process | [05 — Problem 5.3](05-analytic-geometry.md) |
| **A formula returns more than you put in — interrogate every identity for consequences you did not ask for** | You have an identity | [03 — chapter epigraph and the sum-of-cubes identity; Problem 3.1](03-algebra-and-analysis.md) |
| **Upgrade a numerical estimate into a structural property (monotonicity), then use it to cancel $f$ from both sides** | You derived a pointwise bound | [03 — Problem 3.1](03-algebra-and-analysis.md) |
| **Feed the function into its own derived inequality** (replace $n$ by $f(n)$) | The inequality holds for all $n$ and $f(n)$ is a legal input | [03 — Problem 3.1](03-algebra-and-analysis.md) |
| **Substitute pertinent values into a functional equation, starting with the smallest; then substitute *derived expressions*, after auditing that they are in the domain** | Any functional equation or inequality | [03 — Problem 3.1, Exercise 3.4](03-algebra-and-analysis.md) |
| **Recombine every new result with all previously established data — then filter, because most recombinations are junk** | You proved something and don't know what next | [03 — Problem 3.1](03-algebra-and-analysis.md) |
| **Diagnose induction: if case $n$ reused case $n-1$, the proof "reeks of induction"; count how many earlier cases you used to choose ordinary vs strong** | Your small-case argument reused the previous one | [03 — Problem 3.1, Problem 3.2](03-algebra-and-analysis.md) |
| **Name the difficulty of an induction *before* walking into it, so failure reads as a located obstruction** | You suspect the induction is awkward | [03 — Problem 3.1](03-algebra-and-analysis.md) |
| **Reject induction/recursion for a stated structural reason** (consecutive divisors share only one factor, so the step has nothing to grip) | Induction is the obvious move | [02 — Problem 2.6](02-number-theory.md) |
| **Bootstrap from generators, and climb through number systems** (integers → rationals → reals via continuity) | Your data pins the function on a generating set | [03 — Problem 3.2, Exercise 3.1](03-algebra-and-analysis.md) |
| **Zero-product principle** — match "products plus zeros" in the hypotheses to the principle | Your data mixes products with statements about being zero | [03 — Exercise 3.4](03-algebra-and-analysis.md) |
| **Recast values as roots, then use the polynomial toolkit**: factor theorem as a cheap test; roots-of-a-factor ⊆ roots-of-the-whole as a divisibility test; reconstruct a polynomial from its full root list plus leading coefficient; compare coefficients; integrality of the leading coefficient; derive absurdity from an identity that cannot hold for all $x$ | Polynomial problems | [03 — Problem 3.3, Problem 3.4, Exercise 3.7](03-algebra-and-analysis.md) |
| **Guess factors from structure — homogeneity, symmetry and degree constrain the candidates — and search them in order of niceness** | You believe a factorization exists | [03 — Problem 3.3, Exercise 3.5](03-algebra-and-analysis.md) |
| **Plug in the values that make factors vanish** ("the nicest factor one can have is 0") — with the caveat that sometimes a zero factor is unwanted | Your object is built from explicit linear factors | [03 — Problem 3.4](03-algebra-and-analysis.md) |
| **No real roots ⇒ no sign change** (the intermediate value theorem in disguise) | A real polynomial is known to be nowhere zero | [03 — Problem 3.4](03-algebra-and-analysis.md) |
| **Take the difference of two unknown objects whose relationship you know** ($p(x)-q(x)$) | Two unknowns constrained relative to each other | [03 — Exercise 3.7](03-algebra-and-analysis.md) |
| **Constrain an integer by making it divide something small** ($a-b$ divides $f(a)-f(b)$) | An integer polynomial at two integer points | [03 — Exercise 3.8](03-algebra-and-analysis.md) |
| **Exploit multivaluedness deliberately**: $\sin X = \sin Y$ gives two cases, producing an "or" | Your objective is a disjunction | [04 — Problem 4.2](04-euclidean-geometry.md) |
| **Angle chasing: compute everything in angles, never touch a length; pick a reference frame ("main figure") and express all quantities in it; use the angle-sum escape hatch** | No side lengths in the statement | [04 — Problem 4.1, Problem 4.6](04-euclidean-geometry.md) |
| **Enumerate the length↔angle exchange rates and eliminate them by suitability** | Data in one currency, objective in another | [04 — Problem 4.2](04-euclidean-geometry.md) |
| **Keep an equivalence dictionary of statement-type swaps** (angle equality ⇔ cyclic quadrilateral; side comparison ⇔ angle comparison; area facts) | Any stuck proof | [04 — Problem 4.3](04-euclidean-geometry.md) |
| **Recognize trigger configurations** (a triangle in a semicircle ⇒ Thales) | A right angle on a circle | [04 — Problem 4.6, Theorem 4.1](04-euclidean-geometry.md) |
| **A named theorem's free parameter is yours to instantiate at something the problem already names** | "for any point $P$…" | [04 — Problem 4.6](04-euclidean-geometry.md) |
| **Replace a rigid relation by a transformation (rotation/reflection/translation), then invert the condition so your unknown becomes the subject, and intersect loci** | Two points are rigidly related | [04 — Problem 4.4, Exercises 4.1–4.2](04-euclidean-geometry.md) |
| **"Flush fitting": count the *closure* conditions of a tiled or cyclic configuration, not just the local ones** | A tiling or cyclic configuration looks under-determined | [04 — Problem 4.5](04-euclidean-geometry.md) |
| **Prove a strategy *exists* first** (any finite game of skill has a winning-or-drawing strategy, by induction on game length) | "Who has a winning strategy?" | [06 — Problem 6.3](06-sundry-examples.md) |
| **Backward induction: label positions sure-winner / sure-loser from the terminal position** (N- and P-positions). Note the asymmetry: proving a *winner* needs one good child, proving a *loser* needs an exhaustive check — which is why losers are the sparse, interesting set | Any finite two-player game with no draws | [06 — Problem 6.3](06-sundry-examples.md) |
| **Tabulate the labelled positions, spot the pattern, conjecture the general rule — in a layout where the answer would be obvious if true** | You have a slow systematic method and want a fast one | [06 — Problem 6.3](06-sundry-examples.md) |
| **Pragmatic verification of a strategy instead of proving the underlying theorem** ("we do not even have to prove it… we just have to apply it") | You have a candidate strategy | [06 — Problem 6.3](06-sundry-examples.md) |
| **Turn a solved small case into an explicit induction template, using hypothetical labels on a case you have *not* solved** | One small case fell to another small case | [06 — Problem 6.3 (the $3\times4$ illustration)](06-sundry-examples.md) |
| **Strategy stealing** (non-constructive contradiction: the first player cannot be worse off) | Prove the first player is not losing | [06 — Exercise 6.8](06-sundry-examples.md) |
| **Land the abstraction back in intuition** (chess players' "favourable"/"unfavourable" positions) | You want the technique reusable outside the puzzle | [06 — Problem 6.3](06-sundry-examples.md) |
| **Use a *threat* to force the adversary's moves — and never cash a threat you can keep** | A move the opponent must answer | [05 — Problem 5.4](05-analytic-geometry.md) |
| **Retry a failed move in a better configuration** | An idea failed once | [05 — Problem 5.4 (the dash for the edge)](05-analytic-geometry.md) |
| **Two-phase strategy with quantitative verification of each phase; maintain a preserved relation as a pursuit strategy; find the invariant region / critical threshold** | Pursuit and evasion | [05 — Problem 5.4, Exercises 5.2–5.3](05-analytic-geometry.md) |
| **Assume a competent adversary** | Any two-player problem | [05 — Problem 5.4 ("the teacher is no pushover")](05-analytic-geometry.md) |
| **Notice when the target is symmetric — a corner hands the pursuer two equally good routes; an off-centre edge point commits him to one** | Computing the adversary's travel time | [05 — Problem 5.4](05-analytic-geometry.md) |

---

### I. Working backwards and indirect proof

| Technique | Trigger | Where |
|---|---|---|
| **The forward / direct approach: hammer the data into things that look more and more like the objective** (hill climbing) | The objective is a simple relation among calculable parts | [04 — Problem 4.1, Problem 4.2](04-euclidean-geometry.md); [03 — Problem 3.1](03-algebra-and-analysis.md) |
| **The backward approach: transform the *objective* until the data can reach it** — objectives are cheaper to rewrite than data, because rewriting them loses nothing | The objective is obscure | [04 — Problem 4.3](04-euclidean-geometry.md) |
| **Work backwards from the target to a *sufficient* claim** | Your expression almost equals the conjectured answer | [05 — Problem 5.1 (it suffices that $A_1+\cdots+A_n = 0$)](05-analytic-geometry.md); [03 — Problem 3.3](03-algebra-and-analysis.md) |
| **Reason backwards from the target to constrain the intermediate form** — the promised implication guarantees a usable form exists | You know where you must end up | [03 — Problem 3.3](03-algebra-and-analysis.md) |
| **Work from both ends and meet in the middle (bidirectional search)** | An equality of two obscure quantities | [04 — Problem 4.6](04-euclidean-geometry.md) |
| **Isolate an intermediate goal and prove the implication chain, easiest link first** | Your objective is about the least tractable object | [04 — Problem 4.5](04-euclidean-geometry.md); [02 — Problem 2.1](02-number-theory.md) |
| **Proof by contradiction as the fallback when no direct proof appears** | No direct construction presents itself | [05 — Problem 5.2](05-analytic-geometry.md); [03 — Problem 3.4](03-algebra-and-analysis.md); [04 — Problem 4.5](04-euclidean-geometry.md) |
| **Contrapositive** | "If $P$ then $Q$" is hard; "if not $Q$ then not $P$" may not be | [01 — sub-move 6(e)](01-strategies-in-problem-solving.md); [04 — Problem 4.5](04-euclidean-geometry.md) |
| **Know the trade-off of contradiction: "one has more data to begin with, but the end result is very open-ended and indefinite"** | Choosing between contrapositive and contradiction | [04 — Problem 4.5](04-euclidean-geometry.md) |
| **Write the competing logical forms down as objects (a boxed contrapositive next to a boxed contradiction) and compare them on the page, not in your head** | You cannot decide which form to use | [04 — Problem 4.5](04-euclidean-geometry.md) |
| **Match the proof method to your qualitative intuition** | You have a picture-level reason but no formal one | [04 — Problem 4.5 (contradiction fits the "wriggling" picture)](04-euclidean-geometry.md) |
| **The two-question rhythm for starting a contradiction proof from an inequality hypothesis: "what do I have? what does it do?"** | You have assumed the negation and are staring at it | [04 — Problem 4.5](04-euclidean-geometry.md) |
| **Don't prove that $n$ things coincide — define the meeting point of two and show the third contains it** | A concurrency / "all $n$ share a property" statement | [01 — Preface, perpendicular bisectors](01-strategies-in-problem-solving.md) |
| **Negate the objective: spend real effort trying to build a counterexample; the obstruction that blocks all of them is usually the proof** | You suspect the statement may be false | [01 — sub-move 7(f)](01-strategies-in-problem-solving.md) |

---

### J. Rigidity and squeezing (exact answers out of inequalities)

| Technique | Trigger | Where |
|---|---|---|
| **Integrality upgrade: turn a strict integer inequality $a>b$ into $a \ge b+1$** | A strict inequality between integers | [03 — Problem 3.1](03-algebra-and-analysis.md) |
| **Two-sided squeeze: prove $\ge$ and $\le$ separately to force an equality** | Your goal is an equality but your data are inequalities | [03 — Problem 3.1, Problem 3.2](03-algebra-and-analysis.md) |
| **Integer squeeze: an integer strictly between $k$ and $k+2$ must be $k+1$** | An integer trapped between two integers two apart | [03 — Problem 3.2](03-algebra-and-analysis.md) |
| **Manufacture the missing wall of a squeeze from a *different* hypothesis** | Your squeeze needs a value you don't have yet | [03 — Problem 3.2 (get $f(6)$ from $6=2\times3$)](03-algebra-and-analysis.md) |
| **Inequalities instead of equalities; a monotone chain around a cycle contradicts itself** | Equalities in a consistent configuration say nothing locally | [04 — Problem 4.5](04-euclidean-geometry.md) |
| **Extremal bounding from an ordering with a fixed sum** | Ordered integers summing to a constant | [06 — Problem 6.2 ($13 = x+y+z \ge 3z+3$)](06-sundry-examples.md) |
| **Check a bound is sharp by exhibiting a witness** | You derived an inequality and don't know whether to push | [06 — Problem 6.2](06-sundry-examples.md) |
| **Sharpen bounds using data not yet used** | Your bound isn't tight enough to finish | [06 — Problem 6.2 (Betty's total forces $x\le8$)](06-sundry-examples.md) |
| **Crude estimation to kill many candidate cases at once** | A long list of candidates, most obviously out of range | [06 — Problem 6.2](06-sundry-examples.md) |
| **Bound a quantity and enumerate its small range instead of solving the equation** | A quantity has a small range | [02 — Problem 2.1 (digit sum of a 3-digit number is in $[1,27]$)](02-number-theory.md) |
| **Factorization plus integrality to reduce an equation to finitely many cases** | (integer)×(integer) = constant | [06 — Problem 6.2 (factors of 39)](06-sundry-examples.md); [02 — Problem 2.4](02-number-theory.md) |
| **Escalate real information to integer information** — a product of *integers* equal to a small number gives a short case list | Reals would give nothing; integers give a list | [03 — Problem 3.4](03-algebra-and-analysis.md) |
| **Combine a congruence with an inequality bound to pin a unique value** | A congruence gives a list; you need one answer | [06 — Problem 6.4 ($p \equiv 0,2,8 \bmod 10$ plus $0<p<5$)](06-sundry-examples.md) |
| **Prune congruence solutions by parity** | Too many residues survive | [06 — Problem 6.4](06-sundry-examples.md) |
| **Eliminate cases — including on semantic / common-sense grounds — and pair a soft argument with a hard numeric one** | A case is arithmetically fine but absurd | [06 — Problem 6.2 ("a suicidal number of exams" *and* the arithmetic)](06-sundry-examples.md) |
| **Discard spurious roots using physical constraints (positivity)** | You have $\pm$ and only one is meaningful | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **"Find all solutions" means eliminate all but finitely many possibilities, then check the survivors** | The problem says *find all* | [02 — Problem 2.4](02-number-theory.md) |
| **Elimination is not the same as solving, and it is often all you need** | A variable is killed but never determined | [06 — Problem 6.4 ($n$ killed by a modulus, $s$ by quadratic residues)](06-sundry-examples.md) |
| **Two-sided bounds to evaluate an optimal constant** (escape strategies give one bound, pursuit strategies the other) | "What is the minimum speed such that…?" | [05 — Exercise 5.3](05-analytic-geometry.md) |
| **Two-sided attack on an optimum: a counting lower bound, then an explicit construction meeting it** | An optimisation with a combinatorial flavour | [06 — Exercise 6.1](06-sundry-examples.md) |
| **Bound a design by counting the requirements it must satisfy** ($6\times5 = 30$ listening pairs, at most $9$ per concert) | A design/covering problem | [06 — Exercise 6.1](06-sundry-examples.md) |
| **Dimension counting as circumstantial evidence** | Two agents with different freedom | [05 — Problem 5.4](05-analytic-geometry.md) |
| **Degrees of freedom versus constraints; pigeonhole on degrees** | A polynomial pinned at many points | [03 — Problem 3.4](03-algebra-and-analysis.md) |
| **Solve the resulting small Diophantine system** | You have reduced to a handful of integer equations | [06 — Problem 6.2, Problem 6.4](06-sundry-examples.md) |
| **Bank partial victories** (infinitely many suspects reduced to three) | You cut the possibilities down but not to zero | [02 — Problem 2.2](02-number-theory.md) |

---

### K. Managing the search: progress, dead ends, morale

| Technique | Trigger | Where |
|---|---|---|
| **Backtracking is free — exploit it.** Launch speculative attempts and kill them fast | You have an idea that might be wrong | [01 — Chapter 1 opener](01-strategies-in-problem-solving.md) |
| **Diagnose *which* faculty has failed when stuck: direction, stride length, or vision** | Stuck | [01 — Chapter 1 opener](01-strategies-in-problem-solving.md) |
| **Track progress signals: does the *shape* of your expression now match the goal's?** | Mid-derivation, needing to know whether to continue | [04 — Problem 4.2 ("the sines are gone, and we have an 'or'")](04-euclidean-geometry.md) |
| **Announce your own progress out loud** ("this is progress because…") as a correctness check on strategy | Mid-derivation | [04 — Problem 4.1](04-euclidean-geometry.md); [03 — Problem 3.2](03-algebra-and-analysis.md); [06 — Problem 6.2](06-sundry-examples.md) |
| **Spiral, not circle — check which intermediate results are on the critical path** | Your new goal resembles an old one | [02 — Problem 2.7 ("we are going around in spirals")](02-number-theory.md) |
| **Keep an explicit running list of what you still do not know — and of what *partially* settles each item** | Mid-problem, unclear what to do next | [06 — Problem 6.2](06-sundry-examples.md) |
| **Announce the next sub-goal out loud before doing the work, and state when a sub-goal is finished and cannot be improved** | A long problem where you could drift | [06 — Problem 6.2](06-sundry-examples.md) |
| **Report partial progress in the units of the *question*** (three names narrowed to two) | You want to know whether you are closing in | [06 — Problem 6.2](06-sundry-examples.md) |
| **Abandon a fruitless approach *temporarily* and keep it in reserve** | You are circling | [02 — Problem 2.3 ("re-apply number theory later")](02-number-theory.md) |
| **Try the direct approach, then formally declare it dead and read the diagnosis of its failure — and note that it can die *twice***, so re-test it after every reformulation | Anything; and again after normalizing | [03 — Problem 3.3 ("So much for the direct approach"; then "Again, the direct approach is not feasible")](03-algebra-and-analysis.md) |
| **Abandon a translation that is true but connects to nothing** | Your rewrite produced quantities that touch nothing else | [04 — Problem 4.2](04-euclidean-geometry.md) |
| **Always look for connections; prefer configurations that share something** — "knowing that two quantities are equal would not help unless you connect them" | Two quantities are known equal | [04 — Problem 4.2](04-euclidean-geometry.md) |
| **Reject a *correct* proof that will not generalize — "find a block that is more round"** | The proof of the easy case is too special | [02 — Problem 2.7](02-number-theory.md) |
| **Keep every proof you find; a discarded one may finish the next step** | You built a second proof of the same lemma | [02 — Problem 2.7 (the rejected rearrangement proof finishes objective (8))](02-number-theory.md) |
| **Accept that a trick which cracks one problem may be ineffective on a near-identical cousin** | You want to reuse a trick | [03 — Exercise 3.7 vs Problem 3.4](03-algebra-and-analysis.md) |
| **Diagnose being stuck by counting your facts against a problem you already solved** | You feel you have nothing | [02 — Problem 2.2](02-number-theory.md) |
| **Keep two parallel formulations alive and apply each new idea to both** | Two formulations both stalled for the same reason | [06 — Problem 6.1](06-sundry-examples.md) |
| **Proceed provisionally — write down "we do not know yet" / "if possible" rather than resolving or suppressing it** | You made a reduction but can't see whether it closes | [04 — Problem 4.4, Problem 4.5](04-euclidean-geometry.md) |
| **Hedge honestly when your knowledge is partial — let the precision of your prose track the precision of your knowledge** | You narrowed a value but did not fix it | [03 — Problem 3.4 ("more or less, the value of $p(a_0),\dots$")](03-algebra-and-analysis.md) |
| **Grade your own evidence honestly** ("Circumstantial evidence is a bit uncertain") so you know which claims you still owe | You are using a heuristic, not a proof | [05 — Problem 5.4](05-analytic-geometry.md) |
| **Separate the intuitive core from the formal write-up, and flag the gap** | Your key step is obvious but topological | [05 — Problem 5.2](05-analytic-geometry.md) |
| **Sweep up the leftover edge cases explicitly** | Your chain argument has fiddly configurations | [05 — Problem 5.2](05-analytic-geometry.md) |
| **Watch for degenerate cases and dispose of them separately** | You divided by something, or took a ratio | [04 — Problem 4.2 ($\sin(\alpha/2)=0$)](04-euclidean-geometry.md); [05 — Problem 5.1](05-analytic-geometry.md) |
| **Hold three things in working memory while grinding: theorems, data, and — most importantly — the objective** | Deep in algebra, losing your bearings | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Keep the purpose of a tool in view mid-computation** ("which was why we wanted the sine rule in the first place") | Deep in a computation | [04 — Problem 4.2](04-euclidean-geometry.md) |
| **Use the expected answer as a compass for choosing subgoals, never as a premise** | You can guess the answer but not prove it | [03 — Problem 3.1](03-algebra-and-analysis.md) |
| **Where a problem is genuinely ambiguous, pick the reading under which it is a good problem, and say that you did** | The statement admits two readings | [06 — Exercise 6.5](06-sundry-examples.md) |
| **Narrate your position constantly — the four-part loop: inventory / audit / name the sub-goal / measure progress** | Any long problem where no single step is hard | [06 — Problem 6.2, Problem 6.4](06-sundry-examples.md); [02 — Problem 2.7](02-number-theory.md) |
| **Accept that a problem has many solutions and no absolute best one** | You found *a* solution | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Enjoy it, because enjoyment is what funds the failed experiments** | Always | [01 — 1st-ed. preface](01-strategies-in-problem-solving.md) |

---

### L. Verification and checking

| Technique | Trigger | Where |
|---|---|---|
| **Check the final answer against the special case you computed earlier** | You have an answer | [01 — Problem 1.1 ($d=0$ reproduces $2t^{1/2}/3^{1/4}$)](01-strategies-in-problem-solving.md) |
| **Verify the final formula on a case you did *not* use to guess it** | You conjectured from a table, then proved | [05 — Problem 5.1 (the skipped $n=5$ gives $X=5$)](05-analytic-geometry.md) |
| **Plug an actual number into your finished formula and run it end to end** | You have a closed form | [01 — Problem 1.1 ($d=1,t=6$ gives the 3-4-5 triangle)](01-strategies-in-problem-solving.md) |
| **Use symmetry, scaling and dimensional consistency as free answer-checks — established during exploration, cashed at the end** | You derived mini-results in Phase B | [01 — Problem 1.1](01-strategies-in-problem-solving.md) |
| **Run the degenerate case of your own final formula** | You have a formula with a parameter | [01 — Problem 1.1 ($t=0$ gives sides $d,2d,3d$)](01-strategies-in-problem-solving.md) |
| **Check degenerate and extreme cases of a *claim* before trusting a proof sketch** | You have a plausible sketch | [05 — Exercise 5.1](05-analytic-geometry.md) |
| **Test a stepping stone numerically before investing in it** | You have a candidate intermediate statement | [02 — Problem 2.1](02-number-theory.md) |
| **Distinguish an example that *verifies* from one that *shows the mechanism*** | You just computed a case | [02 — Problem 2.7](02-number-theory.md) |
| **Audit every "easily shown" / "clearly" / "obviously" — that is where errors hide** | Reading any text, including your own | [05 — Problem 5.4](05-analytic-geometry.md); [06 — Problem 6.1](06-sundry-examples.md) |
| **When figure and prose disagree, diagnose the collision of two naming conventions and believe whichever the arithmetic confirms** | A printed text with inconsistent labels | [05 — Problem 5.4](05-analytic-geometry.md); [04 — errata table](04-euclidean-geometry.md) |
| **Expect to find mistakes where a text moves fast** — four slips in fifteen pages, none damaging a conclusion | Any "investigation shows" / "as we have shown above" | [06 — closing lesson 11](06-sundry-examples.md); [02 — closing notes](02-number-theory.md) |
| **Check the process is well defined before analysing it, and ask what each hypothesis is *for*** | The problem defines an operation | [05 — Problem 5.3](05-analytic-geometry.md) |
| **Check that spending a degree of freedom loses no solutions — the "no-loss certificate"** | You just fixed something arbitrarily | [04 — Problem 4.4 ("not worry about missing anything")](04-euclidean-geometry.md) |
| **Check whether your guessed answer is the *only* answer before you start proving uniqueness** | You guessed and verified a candidate | [04 — Exercise 4.3](04-euclidean-geometry.md); [03 — Problem 3.2](03-algebra-and-analysis.md) |
| **State the arena you are arguing in** ("no roots — well, none on the real line, at least") | You just said "no roots", "no solutions" | [03 — Problem 3.4](03-algebra-and-analysis.md) |
| **Be loose while exploring; be strict about the logical skeleton** — conjecture and estimate freely, but audit every reformulation | Always | [02 — closing lesson 13](02-number-theory.md) |
| **Do the verification yourself when the author waves it through** ("try it yourself") | The text skips a check | [06 — Problem 6.1](06-sundry-examples.md) |
| **A feeling that an answer is the wrong *size* is a legitimate prompt to hunt for an unused constraint** | Your answer looks implausibly large or small | [06 — Problem 6.4](06-sundry-examples.md) |

---

### M. Domain toolkits

Not techniques so much as the small closed lists Tao enumerates before entering each subject. Each chapter file has the full version with worked examples; this is the map.

| Domain | The closed toolkit Tao names | Where |
|---|---|---|
| **Number theory** | Modular arithmetic (choose the modulus to annihilate, or to constrain); periodicity of powers; integral factorization; integer division/divisibility; growth-and-gap arguments; symmetry and anti-symmetry of sums; closed forms for $\sum k$ and $\sum k^2$; "what is rigid mod what" | [02 — §2.1–2.3 openers](02-number-theory.md) |
| **Functional equations** | Substitute pertinent values, then derived expressions; integrality upgrades; squeezes; induction (ordinary/strong/strengthened); bootstrap from generators; upgrade estimates to structural properties | [03 — §3.1](03-algebra-and-analysis.md) |
| **Polynomials** | Factor theorem; roots ↔ factors; degree counting; comparing coefficients; integrality of coefficients; reconstruct from roots + leading coefficient; the negatively-used fact that there is *no* general root formula (which is why nobody in the chapter ever solves for a root) | [03 — §3.2 opener, Problem 3.3, Problem 3.4](03-algebra-and-analysis.md) |
| **Synthetic geometry** | Angle sum; angle subtended by a chord (Thales / Euclid III.31); tangent ⊥ radius; the tangent–chord angle; power of a point (Theorem 4.2); similar triangles; sine and cosine rules; concurrency of bisectors; cyclic-quadrilateral criteria — plus the *currencies* (angles, lengths, ratios, areas, transformations, degrees of freedom) and the exchange rates between them | [04 — Background, Theorems 4.1–4.2](04-euclidean-geometry.md) |
| **Vectors / analytic methods** | Dot product for sums of squares; unit vectors and perpendicularity; choose the origin to maximize simple relations; complex numbers as an alternative; moment of inertia and Steiner's theorem as imported physics | [05 — Problem 5.1, Exercise 5.1](05-analytic-geometry.md) |
| **Combinatorial games** | Finite games of skill always have a winning-or-drawing strategy; P- and N-positions by backward induction; normal vs misère play; nim-sum; pairing strategies; strategy stealing; monovariants for termination | [06 — Problem 6.3, Exercises 6.4–6.8](06-sundry-examples.md) |
| **Invariant hunting** | Weighted point scores; modular reduction; permutation parity; set membership; counting one total two ways; reachable-set descriptions | [06 — Problem 6.1, Exercises 6.1–6.3](06-sundry-examples.md) |

---

## 4. Cross-cutting patterns — how Tao actually solves problems

This is the direct answer to the question the extraction was made for. These are the moves that appear in **every** chapter regardless of subject. If you internalize only this section, you have most of the transferable content of the book.

### 4.1 Reformulation is the primary activity; "solving" is what happens at the end

The single most consistent observation across all six files. Tao spends the overwhelming majority of his text *changing the question*, and the final mathematical step is usually a one-liner.

- [Problem 2.2](02-number-theory.md) passes through **five** successive versions of its own statement; [Problem 2.7](02-number-theory.md) passes through **eight**. His own summary: "We keep reducing the equation to simpler and simpler formulations, until it just collapses into nothing."
- In [Problem 5.1](05-analytic-geometry.md) the actual computation is four lines; the preceding three pages convert "sum of squares of the distinct lengths" into a plain sum $Y$ over all vertices — via naming the target, expressing it as an equation, choosing canonical representatives, symmetrizing, adding a zero term, and changing variable.
- In [Problem 1.1](01-strategies-in-problem-solving.md) six pages of preparation produce four lines of algebra, and Tao says so.
- In [Problem 3.2](03-algebra-and-analysis.md) he converts "Find $f(1983)$" into "determine $f$ entirely" into "prove $f$ is unique," because general claims can be inducted and verification is easier than search.

The skill is not deduction. It is **manufacturing a statement that is equivalent enough and tractable enough**, plus the discipline to prove each link. Which is why he audits reformulations far more strictly than he audits anything else (see §4.9).

### 4.2 The tool is chosen by matching the *shape* of the objective, not the subject of the problem

- [Chapter 5](05-analytic-geometry.md) is the extreme case: four geometry problems, zero geometry theorems. "Sum of **squares** of lengths" ⇒ dot products ⇒ vectors. "Can this go on forever?" ⇒ monovariant. "Each object has one of two properties" ⇒ two-colouring. "Two agents with speeds" ⇒ arithmetic plus strategy.
- [Chapter 4](04-euclidean-geometry.md) makes the same move inside geometry, as *currency matching*: read what currency the data is in and what currency the objective is in, enumerate the exchange rates (basic trig / similar triangles / isosceles / sine rule / cosine rule), and screen each against the configuration's preconditions. In [Problem 4.2](04-euclidean-geometry.md) he lists five mechanisms and crosses off four.
- [Chapter 2](02-number-theory.md) converts every divisibility statement into modular arithmetic, and chooses the *representation* (product, not sum) that the goal's tools accept.
- [Chapter 3](03-algebra-and-analysis.md) converts "$p$ takes the value 1 at these points" into "$p-1$ has these roots," because he owns tools for roots and none for values.

**The general form: restate the problem in the form for which you already own a tool.** And its corollary — enumerating a *closed* list of candidate tools turns "be clever" into "screen five candidates against preconditions," which is a task you can actually perform.

### 4.3 Perturb the problem to find out what is load-bearing; every hypothesis must be spent

- [Chapter 1](01-strategies-in-problem-solving.md) states the method: "push the problem until it breaks, and then try to identify where the breakdown occurred." Delete $d$ ⇒ infinitely many solutions. Delete $t$ ⇒ none. Both hypotheses are load-bearing, therefore the winning formula must touch both — which is *why* he trusts Heron's formula.
- [Chapter 4](04-euclidean-geometry.md) runs it in both directions. Forwards: "each piece of data must be invoked in some way," so steer toward the strange hypothesis ($\lvert DC\rvert = \lvert DG\rvert$ in [Problem 4.3](04-euclidean-geometry.md) was the key). Backwards, after finishing: audit what you *didn't* use — which is how the parallelism in [Problem 4.4](04-euclidean-geometry.md) was exposed as "a red herring" and the theorem strengthened for free.
- [Chapter 5](05-analytic-geometry.md) asks it hypothesis by hypothesis: "at most one segment per point" prevents degeneracy; "no three collinear" makes the triangle inequality *strict*, which is the only reason the monovariant works.
- [Chapter 6](06-sundry-examples.md) runs the *converse* move: when a problem seems under-determined, the missing constraints are the ones you did not bother to write down — integrality, positivity, distinctness, ordering, and the English of the question. In [Problem 6.2](06-sundry-examples.md), one equation plus integrality plus distinctness plus "two exams are named" collapses an apparently hopeless problem to four cases.
- [Chapter 3](03-algebra-and-analysis.md) does the post-hoc version as deliberate practice: [Exercises 3.2 and 3.3](03-algebra-and-analysis.md) re-solve a finished problem with hypotheses weakened, to find out which parts of the proof were load-bearing.

### 4.4 Cheap experiments first, in a fixed order — and dead ends are budgeted, narrated, and mined

The order is stable across the book: guess the answer from circumstantial evidence → generate data and tabulate → interrogate the constants → try the elementary tools → look for the lazy way → only then reach for machinery. The justification is explicitly cost-benefit: "If you are right, you have saved a lot of time by not pursuing the hard ways. If you are wrong, you were doomed to a long haul anyway" ([Chapter 2](02-number-theory.md)).

And the dead ends are the majority of the text:

- [Chapter 2](02-number-theory.md) abandons at least a dozen approaches — including a **correct and complete proof** of an intermediate result, discarded because its mechanism could not survive the move from mod $p$ to mod $p^2$. Three habits follow: abandonment is *temporary* ("re-apply number theory later"); failures leave *residue* (the failed reformulation still proved a useful bound); failures are *diagnostic*.
- [Chapter 5](05-analytic-geometry.md) keeps the receipts on eight rejected candidates, and each rejection narrows the search: the far-corner failure says "head for edges, not corners"; the exact tie says "the constant 3 is critical"; the intersection-count failure says "measure segments, not intersections."
- [Chapter 1](01-strategies-in-problem-solving.md) records that three *independent failed* experiments — the problem type, deleting the position data, and imitating similar problems — all voted for algebra over geometry. Several weak, cheap, agreeing signals are how an expert justifies committing to a direction.
- [Chapter 3](03-algebra-and-analysis.md) announces every death ("So much for the direct approach") and reads the diagnosis: the fifth-power expansion fails *because of cross-terms*, which is the clue that the solution must make terms cancel — which is what the factorization delivers.

**A well-diagnosed failure is data.** And because backtracking costs one paragraph, the correct response is to be *more* speculative, not less.

### 4.5 Notation and representation are where the first insight is installed

- [Chapter 1](01-strategies-in-problem-solving.md): $b-d,\,b,\,b+d$ versus $a,\,a+d,\,a+2d$ is the entire difference between Heron's formula being tractable and being a mess. Symmetric, minimal, hypothesis-absorbing notation is a mathematical act, not a clerical one.
- [Chapter 6](06-sundry-examples.md): "every problem here is solved shortly after it is turned into numbers," and part of the translation is deciding what to **forget** (chameleon identities; the bar's position on the table). "Let us have some decent notation first" and "let us reduce the problem from chocolate to Mathematics" are the same instruction.
- [Chapter 5](05-analytic-geometry.md): choose the origin to maximize the number of simple relations; choose which vertex to sum from; coin a word for the thing you cannot yet measure, then give the word a test.
- [Chapter 2](02-number-theory.md): housekeeping *is* technique — define $\overline{abc}_{10}$ so it cannot be confused with $abc$; substitute $n=2m$ so you never write $n/2$; choose the table's granularity so the pattern's *cause* is visible.

### 4.6 Throw information away deliberately, and keep only what has theorems attached

The most counter-intuitive lesson in the book, and it appears in at least three chapters.

- [Chapter 2](02-number-theory.md), stated outright: "Why burden yourself with data that cannot be used? It will just be a distraction." Exact descriptions (which digits; the reduced numerator; *which* of 18 consecutive numbers) are traded for coarse invariants (digit count; digit sum mod 9; *any* multiple of 18). And the criterion for what to keep is explicit: prefer "**conventional weapons**" — concepts that theorems already attach to. "'Set of digits' is not a very useful mathematical object… the *sum of digits* is a more conventional weapon."
- [Chapter 6](06-sundry-examples.md): strip the state down to what matters; a coarse invariant that is too weak should be *refined*, not discarded.
- [Chapter 5](05-analytic-geometry.md): prefer the computable quantity over the most meaningful one — "sum of distances between line segments is not easy to do," so use the sum of *lengths*.

The cost is that you now have to prove *more*; the benefit is that you now *can*.

### 4.7 Discreteness and rigidity are resources; squeeze the answer out of two inequalities

- [Chapter 3](03-algebra-and-analysis.md): almost every solution turns on the fact that nothing lives between $k$ and $k+1$. Rewrite strict integer inequalities with an explicit $+1$; an integer trapped strictly between $k$ and $k+2$ *is* $k+1$; a product of *integers* equal to 1 gives a two-case enumeration where the reals would give nothing.
- [Chapter 6](06-sundry-examples.md): factorization plus integrality reduces an equation to four cases; a congruence plus an inequality pins a unique value; ordered integers with a fixed sum give extremal bounds.
- [Chapter 2](02-number-theory.md): squares are $0$ or $1$ mod 4 — one line that kills an infinite family. Gaps between consecutive squares exceed 4, so two things that must be equal cannot be.
- [Chapter 1](01-strategies-in-problem-solving.md): positivity of a length is what selects the right root of the final quadratic — a constraint noticed during *notation selection* and cashed three pages later.

**Reflex to install: ask whether your quantity is an integer, and if it is, exploit the rigidity immediately.** And: if your goal is an equality but your data are inequalities, do not conclude the data are insufficient — ask what the other bound would have to be, and go get it.

### 4.8 Look ahead before committing; ask what success would imply

- [Chapter 1](01-strategies-in-problem-solving.md): "think ahead and see where one could hope such a technique to take one; this can allow one to save enormous amounts of time by eliminating unprofitable directions of inquiry before sinking lots of effort into them." Before expanding Heron's formula he asks what he will be left with — "a polynomial equation in $b$" — and only then starts.
- [Chapter 2](02-number-theory.md) sharpens this into the book's most predictive single idea: mod 7 and mod $x$ were doomed in [Problem 2.4](02-number-theory.md) not because of any computation, but because *if they had worked they would have proved too much* — they would have eliminated every case, contradicting the known existence of a solution. **Before you compute, ask what a successful computation would imply. If the implication is false, skip the computation.**
- [Chapter 5](05-analytic-geometry.md) costs out tools before committing ("slow-but-steady trigonometric sums" vs "promising"), and prunes a strategy space with common sense before doing any arithmetic.
- [Chapter 4](04-euclidean-geometry.md) ranks the brute-force options *in advance* — coordinates last, vectors better, pseudo-coordinates in between — precisely so that the decision is made before desperation sets in.

### 4.9 Be loose while exploring, strict about the logical skeleton

- [Chapter 2](02-number-theory.md) states the split: Tao freely conjectures, freely estimates ("highly probable (though not proven!)"), and freely computes with a machine — but he **marks each as what it is**, and draws a hard line at reformulations, where he audits every link. "One cannot just jump from one form to another without care."
- [Chapter 5](05-analytic-geometry.md) keeps intuition and rigour in visibly separate columns: the picture-argument first, labelled as hand-waving, then the real proof (rotate by $360^\circ/n$); the Hex-style blocking argument, then the connected-components formalization; and the leftover edge cases listed out loud.
- [Chapter 3](03-algebra-and-analysis.md) enforces the hardest version of the line: the expected answer may be used as a **compass** for choosing subgoals but never as a **premise**, and he flags the temptation aloud.
- [Chapter 4](04-euclidean-geometry.md) makes provisionality explicit: "we do not know yet," "if possible" — marking a belief as provisional is what lets you use it without being trapped by it. (In [Problem 4.5](04-euclidean-geometry.md) the hedge "if possible" is literally the seed of the final contradiction.)

### 4.10 Narrate your own position, constantly

The most visible habit in the book and the easiest to dismiss because it is not mathematics. [Chapter 6](06-sundry-examples.md) isolates it as a four-part loop repeated on nearly every page: **inventory** what you know → **audit** what you have not used *fully* → **name** the next sub-goal → **measure** progress against the actual question. That loop is what carries a nine-page problem in which no single step is hard. The same habit appears in [Chapter 2](02-number-theory.md) as numbered tactical objectives with announcements when each is met (which is how Tao notices he is spiralling rather than circling), in [Chapter 3](03-algebra-and-analysis.md) as periodic inventory mid-proof, and in [Chapter 4](04-euclidean-geometry.md) as "this is progress because…".

### 4.11 Build your checks before you have an answer

In [Chapter 1](01-strategies-in-problem-solving.md), the evenness in $d$, the scaling law, and the $d=0$ special case were all derived during the *exploration* phase, for no immediate purpose, and all three became independent verifications of the final formula. [Chapter 5](05-analytic-geometry.md) does the same in reverse by *skipping* $n=5$ during data generation and then using it to verify the proved formula on a case that could not have influenced the guess. **Small results are cheap, they give you something to do when stuck, and they pay for themselves: "however small the result, do not forget it."**

### 4.12 Strengthen the thing you are proving

Counter-intuitive and recurrent. [Chapter 2](02-number-theory.md): prove that *every multiple of 18* works, which is more than asked and much simpler, because it drops the unusable baggage. [Chapter 3](03-algebra-and-analysis.md): when an induction stalls, look at exactly which fact the step *wished it had*, put that fact into the statement being inducted, and specialize back at the end. [Chapter 6](06-sundry-examples.md): describe the whole reachable set rather than one target state; a too-coarse invariant should be refined until the induction closes. For a programmer this is one idea in three costumes: strengthening a loop invariant.

### 4.13 Elegance is a pruning heuristic, not a decoration

- [Chapter 1](01-strategies-in-problem-solving.md): "Strip-mining the neighbourhood with bulldozers is clumsier than doing a careful survey, a bit of geology, and a small amount of digging." Because a competition problem is *guaranteed* to have a short solution, ugliness is genuine evidence of a wrong turn. A one-line question that has become a page of algebra is a bug report.
- [Chapter 6](06-sundry-examples.md) gives the practical reasons, twice, walking past a complete-but-grinding route: the elegant version is **shorter to check, easier to generalize, and states the actual reason the result is true.** "The grinding version answers the question; the elegant version teaches you something you can use tomorrow."
- [Chapter 2](02-number-theory.md) prices the same trade in extensibility: a valid short proof gets thrown away because its mechanism cannot survive the next step — "it is better to find a block that is more round."

---

## 5. Tao's stated attitudes and mindset

Quoted or closely paraphrased, with the file where the full passage lives. This is the part of the book that is *not* technique, and it is the part that makes the technique usable.

**Enjoyment is the funding mechanism.** He opens the first-edition preface with a florid Proclus quotation about mathematics purifying the intellect, then punctures it in a one-line paragraph: "But I just like mathematics because it is fun." This is not decoration. Someone who enjoys the exploration will cheerfully run twenty cheap experiments that fail, which is exactly what six pages of [Chapter 1](01-strategies-in-problem-solving.md) consist of. If the only reward is the answer, the dead ends feel like waste; if the process is the reward, they don't.

**Persistence, and what it actually looks like.** Not staring harder. In Tao's practice, persistence is *having another cheap move available* — which is the whole point of the seven-item "modify the problem slightly" menu and the "prove small results" strategy, whose stated justification is "besides, it gives you something to do if you are stuck." He also names the diagnostic question for the stuck state: which of direction, stride length, or vision has failed?

**Willingness to abandon an approach — and to abandon it *temporarily*.** Roughly half of [Chapter 2](02-number-theory.md) is abandoned approaches, each with a reason. The discipline has three parts: abandonment is provisional ("re-apply number theory later if algebra failed"); the abandoned attempt usually left a usable residue; and you keep both proofs when you have two, because "two proofs of a lemma are two tools for the next lemma." He will also abandon a *correct* proof for lack of extensibility, and a correct proof for lack of elegance.

**Tolerance for mess — bounded by two-tier discipline.** The exploratory page is allowed to be a mess: crazy ideas, unproven guesses, strict-vs-non-strict slips, hedges like "more or less" and "we do not know yet." What is *not* allowed to be a mess is the logical skeleton — every reformulation is audited, every arbitrary choice gets a no-loss certificate, every substitution is checked to be in the domain. Two standards of care for two different activities, and knowing which one you are in is itself the skill. ([Chapter 2](02-number-theory.md) closing lesson 13; [Chapter 4](04-euclidean-geometry.md) closing lesson 15.)

**"Strip-mining vs. careful survey."** His central image for brute force, from the first-edition preface: mathematics is prospecting for gold, and "strip-mining the neighbourhood with bulldozers is clumsier than doing a careful survey, a bit of geology, and a small amount of digging." Applied: "Transforming a nice, short little geometry question into a ravening monster of an equation by textbook coordinate geometry does not have the same taste of victory as a two-line vector solution." For a CS reader the analogy is exact — an $O(n^3)$ triple loop that terminates versus an $O(n\log n)$ algorithm that shows you *why* the answer is what it is. Both work; only one is reusable. Note that [Chapter 4](04-euclidean-geometry.md) refines the picture rather than repeating it: coordinate geometry is not a *different* method, it is "this idea taken to extremes," so the real decision is **how far to mechanise** — and the brute-force option should be ranked and held in reserve *before* you are desperate.

**Why elegance matters, operationally.** The rubric: "A solution should be relatively short, understandable, and hopefully have a touch of elegance. It should also be fun to discover." Two of the four criteria are about the reader and the solver, not about logical validity — and "solving the problem is not everything" licenses the genuinely startling move of rejecting a correct proof. The practical payoffs, spelled out in [Chapter 6](06-sundry-examples.md): an elegant proof is shorter to check, easier to generalize, and states the reason the result is true.

**What he says cannot be taught from a book.** "Two of the main weapons — experience and knowledge — are not easy to put into a book: they have to be acquired over time." The book teaches the cheap tricks, of which he claims exactly two categories: "There are ways of looking at a problem that make it easier to find a feasible attack plan. There are systematic ways of reducing a problem into successively simpler sub-problems." Everything in the framework is one or the other, and it is worth knowing which you are reaching for. The corollary appears in [Chapter 4](04-euclidean-geometry.md): memory is a technique, but it "can only fire on what you have stocked," so maintaining a personal stock of surprising-but-elementary facts is itself part of the method.

**Trust, and its counterweight.** "Most problems are not trying to pull your leg" — so do not read difficulty as evidence that no solution exists. And: "Good problems usually look simple and straightforward" — so do not read a one-line statement as evidence of easiness. Both are calibration advice about the *prior* you bring to a new problem.

**No canonical best solution.** "A question can be solved in more than one way, and no particular way can really be judged the absolute best." He leaves an entire alternative approach to [Problem 1.1](01-strategies-in-problem-solving.md) (a continuity/deformation argument that would have proved existence and uniqueness instead of producing a formula) explicitly on the table.

### What the 2nd-edition preface says changed

Written at 30 about the book he wrote at 15, and the most useful two pages in the book for placing everything else.

He lists **five stages of what made mathematics attractive to him**, and each stage had a different answer:

1. *Primary school* — "the abstract beauty of formal manipulation, and the remarkable ability to repeatedly use simple rules to achieve non-trivial answers."
2. *High school, competing* — "I enjoyed mathematics as a sport, taking cleverly designed mathematical puzzle problems (such as those in this book) and searching for the right 'trick' that would unlock each one." **This is the stage the book is written from**, and it explains why the whole method is a search for a single unlocking move.
3. *Undergraduate* — "awed by my first glimpses of the rich, deep, and fascinating theories and structures which lie at the core of modern mathematics."
4. *Graduate student* — "the pride of having one's own research project, and the unique satisfaction that comes from creating an original argument that resolved a previously open question."
5. *Professional* — "I began to see the intuition and motivation that lay behind the theories… and was delighted when realizing how even very complex and deep results are often at heart guided by very simple, even common-sensical, principles."

His verdict on the book: "Clearly, my perspective on life and on mathematics is different now than it was when I was 15… if I were to write a book now on the subject it would be very different from the one you are reading here." And the reason he did **not** rewrite it: "in many places the exposition has a certain innocence, or even naivety. I have been reluctant to tamper too much with this, as my younger self was almost certainly more attuned to the world of the high-school problem solver than I am now." A striking editorial decision — he preserves the less expert text *because* it is closer to the reader's state, since the pedagogical value of a solution written by someone who does not yet know the slick answer is exactly the value of watching a search rather than reading a result.

**The boundary condition, and it matters.** The 2nd-edition preface is where the competition frame gets its limits drawn. In research there is no guarantee that a nugget exists, that it is reachable, or that you were handed the right equipment — so the book's most powerful heuristic, *"an unused hypothesis means your solution is wrong,"* evaporates. And on tools: "several of the problems here could be handled more quickly and cleanly by more 'high-tech' mathematical tools; but the point of this text is not to present the slickest solution… but rather to show how one approaches a mathematical problem for the first time." **Practical rule: if you spot the heavy theorem, note it, then solve it the elementary way anyway.**

---

## 6. Routing table — "if you are stuck on a problem that looks like X"

| Your problem looks like… | Read | Why |
|---|---|---|
| **You cannot get started at all. Blank page.** | [01-strategies-in-problem-solving.md](01-strategies-in-problem-solving.md), Techniques 6–8 | The seven "modify slightly" sub-moves, the five demolitions, and "prove small results just to have something to do" — the whole chapter is about this state |
| **You do not know how to *set up* a problem** — what to name, what to write down | [01-strategies-in-problem-solving.md](01-strategies-in-problem-solving.md), Techniques 1–5 | Classify, inventory data, state the objective, choose notation, dump everything on paper |
| **"Prove $a$ divides $b$" / anything with integers, digits, primes, remainders** | [02-number-theory.md](02-number-theory.md) | Modular arithmetic, choosing the modulus, periodicity, factorization, rigidity mod $m$ |
| **A Diophantine equation — integers only, several unknowns** | [02-number-theory.md](02-number-theory.md) §2.2 (Problems 2.3, 2.4, Ex 2.2) | The named toolkit: integer division, modular arithmetic, integral factorization; plus "find all" = eliminate all but finitely many |
| **A sum you must evaluate or prove divisible** | [02-number-theory.md](02-number-theory.md) §2.3 (Problems 2.5–2.7) | Symmetry/anti-symmetry, doubling up, rearrangement bijections, closed forms |
| **"Here is one equation about $f$ — find $f$"** (functional equations) | [03-algebra-and-analysis.md](03-algebra-and-analysis.md) §3.1 | Substitute pertinent values, integrality upgrades, squeezes, strengthened induction |
| **Your goal is an equality but all your data are inequalities** | [03-algebra-and-analysis.md](03-algebra-and-analysis.md), Techniques 15–17 | Two-sided squeeze; integer squeeze; manufacturing the missing wall |
| **An induction that stalls** | [03-algebra-and-analysis.md](03-algebra-and-analysis.md), Techniques 7–10 | Diagnose it, choose ordinary vs strong, strengthen the hypothesis, specialize back |
| **Polynomials: factorize this, or prove it cannot be factorized** | [03-algebra-and-analysis.md](03-algebra-and-analysis.md) §3.2 (Problems 3.3, 3.4) | Values → roots, degree counting, coefficient comparison, integrality of coefficients |
| **Triangles, circles, angles — prove a synthetic geometry fact** | [04-euclidean-geometry.md](04-euclidean-geometry.md) | Chain obvious facts; angle chasing; currency matching; forward vs backward |
| **A geometric construction ("construct the triangle such that…")** | [04-euclidean-geometry.md](04-euclidean-geometry.md), Problem 4.4 + Exercises 4.1–4.3 | "Solve for" the unknown; determine a locus; relations → transformations → invert and intersect |
| **A configuration that feels under-determined but the claim says it is rigid** | [04-euclidean-geometry.md](04-euclidean-geometry.md), Problem 4.5 | Wriggling; counting closure conditions ("flush fitting"); monotone chains around a cycle |
| **A geometric statement where no geometry theorem seems to apply** | [05-analytic-geometry.md](05-analytic-geometry.md) | The whole chapter is about escaping the subject the problem is filed under |
| **Sums of squares of lengths, or anything with symmetric configurations** | [05-analytic-geometry.md](05-analytic-geometry.md), Problem 5.1 | Dot products, origin choice, symmetry made rigorous, imported physics |
| **"Can this process go on forever?" / "must this terminate?"** | [05-analytic-geometry.md](05-analytic-geometry.md), Problem 5.3 | Monovariants: how to *derive* the right quantity instead of guessing it |
| **Every object independently has one of two properties** | [05-analytic-geometry.md](05-analytic-geometry.md), Problem 5.2 | Two-colouring, blocking arguments, Hex duality |
| **Pursuit, evasion, "can he escape?"** | [05-analytic-geometry.md](05-analytic-geometry.md), Problem 5.4 + Ex 5.2–5.3 | Prune strategies by common sense, then compute; threats; near-misses as signals |
| **"Prove this state is unreachable" / "prove this is impossible"** | [06-sundry-examples.md](06-sundry-examples.md), Problem 6.1 | Invariants: candidates, refinement, going modular, patching a half-working idea |
| **"There is not enough information to solve this"** | [06-sundry-examples.md](06-sundry-examples.md), Problem 6.2 and Problem 6.4 | Hidden data — integrality, positivity, distinctness, ordering, the wording — plus the closing two-column checklist |
| **A two-player game: who wins?** | [06-sundry-examples.md](06-sundry-examples.md), Problem 6.3 + Exercises 6.4–6.8 | Existence of a strategy first, then backward induction, then conjecture the pattern, then verify |
| **A word problem that resists formalization** | [06-sundry-examples.md](06-sundry-examples.md), Problem 6.4 | Independent vs dependent variables; turn every sentence into an (in)equality; test-drive the rules on a number |
| **You have an answer and want to know whether to keep looking** | [01-strategies-in-problem-solving.md](01-strategies-in-problem-solving.md) (the rubric) + [06-sundry-examples.md](06-sundry-examples.md) (closing lesson 13) | Score it: short, understandable, elegant, fun. Then ask whether an elegant version would generalize |

---

## 7. Reading order for a CS undergraduate (Calculus 1 + basic linear algebra)

**Short version: 1 → 6 → 5 → 2 → 3 → 4.** That is deliberately *not* the book's order, and the reason is prerequisites, not difficulty.

### Stage 1 — Read this first, in full

**[01-strategies-in-problem-solving.md](01-strategies-in-problem-solving.md)** — non-negotiable, and read it twice: once now, once after you have done a chapter of problems. It is the control panel for everything else, and its only mathematical prerequisites are in its own Background section (six pieces of school geometry: arithmetic progressions, the sine and cosine rules, two area formulas including Heron's, the triangle inequality, plus WLOG and contrapositive as logical idioms). Nothing beyond Calculus 1. **Budget:** an evening for the read, plus an hour on the six self-set exercises at the end — they are cheap and each drills a chapter technique on the chapter's own problem.

### Stage 2 — Most approachable, most technique per page

**[06-sundry-examples.md](06-sundry-examples.md)** — start here after Chapter 1, not at Chapter 2. Reasons: it needs the *least* mathematics of any chapter (modular arithmetic, permutation parity, integer lattices, and two-player game vocabulary, all supplied in its Background section); its material is closest to things a CS student already thinks about (state machines, reachability, invariants ≈ loop invariants, game trees ≈ minimax, backward induction ≈ dynamic programming); and because it has "no theory to lean on," it is the purest chapter for technique. Tao's own closing checklist is here, and he flags it as the one paragraph he most wants you to leave with.

**[05-analytic-geometry.md](05-analytic-geometry.md)** — second, for the same reason. Its Background section says outright that Calculus 1 plus basic linear algebra is "nearly enough": you need the dot product (you have it), a little vector arithmetic, and nothing else. The four problems are a monovariant/termination argument, a colouring/connectivity argument, a pursuit game, and one genuinely vector-algebraic computation — three of the four are essentially discrete mathematics wearing a geometric costume. It also teaches the single most transferable meta-lesson in the book: *the branch a problem is filed under is not the branch that solves it.*

### Stage 3 — Needs a little machinery, but it is all supplied

**[02-number-theory.md](02-number-theory.md)** — the richest chapter for technique count, and the one that most rewards slow reading, but you must first absorb its Background section: divisibility notation, modular arithmetic (including the surprising fact that division mod $n$ is usually legal), the digit-sum rule mod 9, squares mod 4, fourth powers mod 5, difference of two squares, and the two closed-form sums. All of it is a page or less each, and if you have written `x % n == y % n` you already have the mental model. **Read Problems 2.1–2.4 first** (digits and Diophantine equations — short, self-contained, and where the "throw away information deliberately" lesson lands hardest). **Problem 2.7 is the hardest thing in the chapter** — eight successive reformulations over seven pages — and is best saved for a second pass; it is also the single best demonstration in the book of §4.1.

**[03-algebra-and-analysis.md](03-algebra-and-analysis.md)** — fourth. §3.1 (functional equations, [Problems 3.1–3.2](03-algebra-and-analysis.md)) is genuinely accessible with no prerequisites beyond induction, and it is where the "discreteness is a resource" and "strengthen the induction hypothesis" lessons live — both directly useful to a programmer. §3.2 (polynomials) needs the two pages of definitions Tao supplies and the chapter file expands: degree, factor theorem, roots vs factors, integer vs real coefficients. Note that "analysis" here means only the very bottom of the analysis ladder — the one continuity hypothesis in the chapter ([Exercise 3.1](03-algebra-and-analysis.md)) is used as a finishing move, not as machinery, so **you do not need real analysis**.

### Stage 4 — Approachable, but the background is the largest

**[04-euclidean-geometry.md](04-euclidean-geometry.md)** — last, not because the reasoning is harder but because it is the chapter whose *prerequisites are furthest from a CS curriculum.* You will need, fluently: the angle subtended by a chord (Thales / Euclid III.31), the tangent–chord angle, tangent ⊥ radius, power of a point, similar-triangle criteria, cevians, and the cyclic-quadrilateral tests. The chapter file supplies all of them with concrete instances, and none is deep — but there are about a dozen, they must be *fluent* rather than merely known (Tao's whole method here is rapid retrieval and chaining), and reading the chapter without them is a slog. **Read the Background section as its own session before touching a problem.** The payoff is worth it: this is the chapter with the richest material on *forward vs. backward* attack, on translating between currencies, and on "solve for your unknown like an algebra variable," and those three ideas are entirely subject-independent.

### Practical notes for this reader

- **Do not read the chapters as mathematics; read them as transcripts.** For each problem, before reading Tao's chain of moves, spend ten minutes trying it. You do not need to solve it. You need to have a position, so that watching his search means something.
- **The exercises are the transfer test.** Per the first-edition preface, an exercise attached to a problem is deliberately within transfer distance of the technique just shown — the intended move is *reuse what you watched*, not invent something new. If you can do the exercise, the technique is yours.
- **Ignore the difficulty stars at first, then respect them.** `(*)` and `(**)` mark problems needing "higher mathematics or some clever thinking." The starred items ([Problem 2.6](02-number-theory.md), [Problem 3.4](03-algebra-and-analysis.md), [Exercise 3.4](03-algebra-and-analysis.md), [Problem 4.3](04-euclidean-geometry.md), [Exercise 4.3](04-euclidean-geometry.md), [Problem 5.2](05-analytic-geometry.md), [Exercise 5.1](05-analytic-geometry.md), [Exercise 5.2](05-analytic-geometry.md), [Exercise 5.3](05-analytic-geometry.md), [Problem 6.2](06-sundry-examples.md), [Exercise 6.8](06-sundry-examples.md)) are worth reading for the narration even if you skip attempting them.
- **Every chapter file ends with a "What this chapter teaches about problem solving in general" section.** If you only have an hour, read those six sections plus §2 and §4 of this file. They are the compressed version of everything above.
- **Expect the printed book to be wrong occasionally**, and treat that as part of the training. [Chapter 4](04-euclidean-geometry.md) has a consolidated errata table (seven slips in twenty pages); [Chapter 5](05-analytic-geometry.md) and [Chapter 6](06-sundry-examples.md) flag four each inline; [Chapter 1](01-strategies-in-problem-solving.md) catches two typographical slips in the final quadratic of Problem 1.1. In every case the slip is at a point where the text moves fast, and in no case does it damage a conclusion — which is itself the lesson.

---

*Source: Terence Tao, "Solving Mathematical Problems: A Personal Perspective", 2nd edition, Oxford University Press, 2006. This file synthesizes the six per-chapter extraction files in this directory; all quotations are short excerpts from the book, and every technique in §3 is traceable to the chapter file cited beside it. Where a technique is an addition rather than something Tao states (a check he never runs, a background gloss, a self-set exercise), the chapter file marks it as such inline.*
