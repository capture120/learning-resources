# Chapter 1: Strategies in problem solving

> This chapter is the book's control panel. It contains almost no mathematics of its own — one triangle problem, worked slowly — but it lays out the complete list of *moves* Tao will use for the rest of the book, in the order he actually performs them: understand the problem, understand the data, understand the objective, choose notation, dump everything you know onto paper, perturb the problem in small ways, perturb it in violent ways, prove small side-results just to have something to do, and only then start computing. The mathematics (a triangle whose three side lengths form an arithmetic progression) is deliberately mundane. It is there as a specimen on the dissecting table. Read this chapter as a checklist you run *before* you are allowed to start algebra, and as a description of what to do in the state every problem solver actually spends most of their time in: stuck, with no idea what to try next.

Pages covered: Preface to the first edition (pp. viii–x), Preface to the second edition (pp. xi–xii), Chapter 1 (pp. 1–7).

---

## The techniques at a glance

| # | Technique | Trigger — what makes you reach for it | Where Tao uses it here |
|---|---|---|---|
| 0 | **Prefer elegance over force; a long computation is a bad smell** | You notice your solution is turning into "a ravening monster of an equation" | Preface, p. viii–ix: perpendicular bisectors by coordinate geometry vs. the four-line synthetic proof |
| 0b | **Chain obvious facts to reach a non-obvious fact** | You cannot see the destination but you can see one small true step | Preface, p. ix: concurrency of perpendicular bisectors from three uses of "equidistant" |
| 0c | **Backtracking is free — exploit it** | You have an idea that might be wrong | Ch. 1, p. 1: "one can always restart from scratch, try new avenues of attack, or backtrack at an instant's notice" |
| 0d | **All the data is there for a reason (the gold-nugget premise)** | You have a candidate solution that never used some hypothesis | Preface, p. viii; used as a *confidence signal* on p. 6: Heron's formula is promising precisely because it involves both $d$ and $t$ |
| 0e | **Score your solution against an explicit rubric: short, understandable, elegant, fun to discover** | You have finished and want to know whether to look for a better route | p. ix: "A solution should be relatively short, understandable, and hopefully have a touch of elegance. It should also be fun to discover." Plus the moral: "solving the problem is not everything" |
| 0f | **Reduce a problem into successively simpler sub-problems** | The problem as posed is too big to attack in one move | p. viii, named by Tao as one of the two categories of learnable trick: "There are systematic ways of reducing a problem into successively simpler sub-problems" (the other category: "ways of looking at a problem that make it easier to find a feasible attack plan") |
| 0g | **Hunt for *the* trick — treat the problem as a designed lock with one key** | You are working on a competition-style puzzle (as opposed to research) | 2nd-ed. preface, p. xi: as a high-schooler Tao "enjoyed mathematics as a sport, taking cleverly designed mathematical puzzle problems (such as those in this book) and searching for the right 'trick' that would unlock each one." This is the register the whole book is written in |
| 0h | **Know the book's own difficulty grading and stay inside your level** | Choosing what to attempt | p. viii: unstarred = baseline; `(*)` = "an additional level of difficulty, either because some higher mathematics or some clever thinking are required"; `(**)` = "similar, but to a greater degree". Also: "Some problems have additional exercises at the end that can be solved in a similar manner or involve a similar piece of mathematics" |
| 0i | **Deliberately keep the toolkit elementary** | You know a heavyweight theorem that would flatten the problem | 2nd-ed. preface, p. xii: "several of the problems here could be handled more quickly and cleanly by more 'high-tech' mathematical tools; but the point of this text is not to present the slickest solution… but rather to show how one approaches a mathematical problem for the first time" |
| 1 | **Classify the problem type** ("Show that…" / "Find a…" / "Is there a…") | Always, first thing | p. 1–2: Problem 1.1 is an "Evaluate…" problem ⇒ algebraic attack, clear target |
| 2 | **Understand the data** — list the objects and how the constraints interact | Always, second | p. 2: triangle + area + arithmetic progression ⇒ pull in sine rule, cosine rule, area formulas; invent notation for the progression |
| 3 | **Understand the objective** — and convert it into *tactical goals* | Always, third; especially when you have no idea what to compute | p. 2: objective "all sides and angles" ⇒ tactical goal "find equations involving the sides and angles" |
| 3b | **Name which *species* of objective you have** | Right after stating the objective | p. 2: "One may need to find an object, prove a statement, determine the existence of an object with special properties, or whatever" — the objective side mirrors the problem-type taxonomy of Technique 1 |
| 4 | **Select good notation** — minimal, symmetric | Once data and objective are clear, before any calculation | p. 3: sides $a, a+d, a+2d$ improved to $b-d,\ b,\ b+d$; angles kept as $\alpha,\beta,\gamma$ rather than $\alpha,\beta,180^\circ-\alpha-\beta$ |
| 4b | **Turn a notational drawback into extra data** | Your notation seems to impose a restriction | p. 3: "$b>d$" looks like a cost of the symmetric notation; it is actually a free fact |
| 5 | **Write everything down; draw a diagram** | Always; especially when stuck and staring | p. 3–4: the seven-item bullet list of constraints; the labelled triangle on p. 4 |
| 5b | **Triage the dump: highlight the promising, quarantine the crazy** | Your page of facts is getting long | p. 4: equalities beat inequalities *because the data and objective are equalities*; Heron's formula flagged because $s$ collapses to $3b/2$ |
| 5c | **Admit when a standard technique doesn't help here** | You applied a technique and got nothing | p. 4: "in this case the picture does not seem to add much" |
| 6 | **Modify the problem slightly** (7 sub-moves: special case, simplify, find a stronger conjecture, find a consequence, reformulate, imitate similar problems, generalize) | You cannot get started at all | p. 4–5: try $d=0$ (equilateral triangle) |
| 6b | **Read the *shape* of an answer off a special case** | The special case is solvable but doesn't reveal a method | p. 5: $d=0$ gives $b=2t^{1/2}/3^{1/4}$ ⇒ expect square/fourth roots in the general answer |
| 6c | **Warning: special cases can be *too* special** | Your special case admitted a cute trick | p. 4: "start with modest assumptions first" |
| 7 | **Modify the problem significantly** — break it deliberately | You want to know where the difficulty lives and which data are load-bearing | p. 5–6: swap triangle for quadrilateral; delete positional information; delete objectives; delete $d$; delete $t$; reverse data and objective |
| 7b | **Delete an objective — maybe the rest comes free** | Multiple things to find | p. 5: only $b$ is needed; sine/cosine rules then hand you $\alpha,\beta,\gamma$ |
| 7c | **Delete a datum — if the problem dies, that datum is essential** | You don't know what matters | p. 5: without $d$, many solutions; without $t$, no solution |
| 7d | **Partially weaken data (equality → inequality)** — but only after the simple options | You have exhausted clean deletions | p. 5, parenthetical: "Stick with the simple options first." |
| 7e | **Reverse the problem: swap data with objective** | Direct attack stalls | p. 5–6: deform a triangle with fixed $d$ until its area is $t$; or mould a fixed-area triangle until its sides are in progression |
| 7f | **Negate the objective — try to *disprove* it** | You suspect the statement may be false, or you want to find the obstruction | p. 5, listed as a major modification |
| 8 | **Prove small results about the question; play with the data** | You are stuck and need *something* to do | p. 6: treat $b$ as a function $b(d,t)$ |
| 8b | **Notice functional dependence explicitly** | The answer depends on parameters | p. 6: "$b$ is really a function: $b=b(d,t)$" |
| 8c | **Symmetry mini-result** | A parameter has a sign or a labelling ambiguity | p. 6: $b(d,t)=b(-d,t)$ |
| 8d | **Scaling / dimensional-analysis mini-result** | The problem is scale-covariant (lengths, areas) | p. 6: $b(kd,k^2t)=k\,b(d,t)$ by dilating the triangle by $k$ |
| 8e | **Normalize using a scaling law** | You have one parameter too many | p. 6: set $t=1$ or $d=1$ |
| 8f | **Differentiate with respect to a parameter** | Continuous parameters present | p. 6: "We could even try differentiate $b$ with respect to $d$ or $t$" (mentioned, not used) |
| 9 | **Simplify / exploit data / reach the tactical goals** — the long grind | Setup is done | p. 6–7: Heron ⇒ quartic ⇒ quadratic in $b^2$ ⇒ $b$ |
| 9b | **Look ahead before committing to a technique** | You are about to start a long computation | p. 6: think where a technique "could hope" to take you, to prune unprofitable directions early |
| 9b-ii | **Hold three things in working memory while grinding: theorems, data, objective** | You are deep in algebra and losing your bearings | p. 6: "one can avoid getting lost if one remembers the relevant theorems, the data and how they can be used, and most importantly the objective" |
| 9g | **For the grind itself, use the standard, boring, learnable toolkit** | You have reached the computation phase | p. 6: "In simple problems, there are usually standard ways of doing this. (For example, algebraic simplification is usually discussed thoroughly in high-school level textbooks.)" The creative work happened earlier; here you want fluency, not inspiration |
| 9c | **Reduce to a single unknown** | Several unknowns, some determined by others | p. 5: everything reduces to finding $b$ |
| 9d | **Spot the disguised quadratic** | An equation is degree 4 in $x$ but degree 2 in $x^2$ | p. 7: $3b^4-12d^2b^2-16t^2=0$ |
| 9e | **Discard roots using physical constraints** | You get $\pm$ and only one is meaningful | p. 7: "Because $b$ has to be positive" |
| 9f | **Check the final answer against your special case** | You have an answer | p. 7: setting $d=0$ reproduces $b=2t^{1/2}/3^{1/4}$ |
| 9h | **Plug an actual number into your finished formula** | You have a closed form and want it exercised end-to-end | Not in Tao — supplied here. $d=1,t=6$ gives the $3,4,5$ triangle, which checks Heron, the cosine rule, the angle sum and the triangle inequality in one go |
| 10 | **Accept that there are many solutions and no canonical best** | You found *a* solution | p. 6: "a question can be solved in more than one way, and no particular way can really be judged the absolute best" |
| 11 | **Diagnose *which* faculty has failed when you are stuck: direction, stride length, or vision** | You are stuck | p. 1: progress needs "a firm, clear direction, with long strides and sharp vision" — three separable assets |
| 12 | **Enjoy it, because enjoyment is what funds the failed experiments** | Always | p. viii: "But I just like mathematics because it is fun." Puzzles are to real mathematics "just as fables, stories, and anecdotes are important to the young in understanding real life" |

---

## Background you need first

You need six pieces of school geometry that a CS curriculum skips, plus two logical idioms. All of them appear in this chapter. Nothing else in the chapter is beyond Calculus 1.

**1. Arithmetic progression.** A list where each term exceeds the previous by a fixed amount $d$, called the common difference. $3, 7, 11$ is an arithmetic progression with $d=4$. Saying "the triangle's side lengths are in arithmetic progression with difference $d$" means the three sides can be written $a,\ a+d,\ a+2d$ — or, as Tao prefers, $b-d,\ b,\ b+d$ (same thing, with $b = a+d$ being the middle one).

**2. Naming convention for triangles.** Sides get lower-case letters, angles get Greek letters, and an angle is said to be *opposite* the side that does not touch it. In the chapter's diagram the angle $\alpha$ sits opposite the side of length $b-d$, $\beta$ sits opposite $b$, and $\gamma$ sits opposite $b+d$.

**3. The angles in a triangle sum to $180^\circ$.** So $\alpha+\beta+\gamma = 180^\circ$. Consequence Tao uses: if you know two angles, the third is free. (This is why he *could* have named the angles $\alpha,\beta,180^\circ-\alpha-\beta$.)

**4. The sine rule.** In any triangle, each side divided by the sine of its opposite angle gives the same number:
$$\frac{\text{side}_1}{\sin(\text{angle opposite side}_1)} = \frac{\text{side}_2}{\sin(\text{angle opposite side}_2)} = \frac{\text{side}_3}{\sin(\text{angle opposite side}_3)}.$$
Tiny example: a right triangle with sides $3,4,5$. The angle opposite the $5$ is $90^\circ$, $\sin 90^\circ = 1$, so the common ratio is $5/1 = 5$; therefore the angle opposite the side $3$ has $\sin = 3/5 = 0.6$, i.e. about $36.87^\circ$. **What it buys you:** knowing all three sides lets you recover all three angles.

**5. The cosine rule.** A generalisation of Pythagoras that works for non-right triangles: for a side $c$ opposite angle $C$, with the other two sides $a,b$,
$$c^2 = a^2 + b^2 - 2ab\cos C.$$
When $C = 90^\circ$, $\cos C = 0$ and this collapses to $c^2=a^2+b^2$. Tiny example: sides $a=b=1$ with the angle between them $60^\circ$ gives $c^2 = 1+1-2\cdot\frac12 = 1$, so $c=1$ — the equilateral triangle, as expected. **What it buys you:** solve it for $\cos C$ and you get every angle from the three side lengths alone. This is the fact that lets Tao drop the angles from his objective entirely.

**6. Two area formulas.**
- *Two-sides-and-the-included-angle*: area $= \tfrac12 \cdot (\text{side}) \cdot (\text{side}) \cdot \sin(\text{angle between them})$. Sanity check: for a right triangle the angle is $90^\circ$, $\sin = 1$, and you get the familiar $\tfrac12\times\text{base}\times\text{height}$.
- *Heron's formula*: area purely from the three sides. Let the sides be $x,y,z$ and let the **semiperimeter** be $s = (x+y+z)/2$ (half the perimeter). Then
$$\text{area}^2 = s(s-x)(s-y)(s-z).$$
Tiny example: the $3,4,5$ triangle has $s = 6$, so area$^2 = 6\cdot3\cdot2\cdot1 = 36$, area $=6$. Correct ($\tfrac12\cdot3\cdot4$). **Why Heron matters here:** it connects *area* to *sides* with no angles anywhere. Since Tao's data are an area and a fact about sides, and his (reduced) objective is a side, Heron's formula is exactly the bridge between what he has and what he wants.

**6b. The area of an equilateral triangle.** Tao calls this "a standard matter to compute" and does not show the work; here it is, because the special case $d=0$ turns on it. Take an equilateral triangle of side $b$. Drop a perpendicular from the apex to the base; by symmetry it lands at the midpoint, cutting the base into two halves of length $b/2$. Pythagoras on either half gives the height $h = \sqrt{b^2 - (b/2)^2} = \sqrt{3b^2/4} = \frac{\sqrt3}{2}b$. So
$$\text{area} = \tfrac12 \cdot b \cdot \tfrac{\sqrt3}{2}b = \frac{\sqrt3}{4}b^2.$$
(Cross-check with Heron: $s = 3b/2$, so area$^2 = \frac{3b}{2}\cdot(\frac{b}{2})^3 = \frac{3b^4}{16}$, area $=\frac{\sqrt3}{4}b^2$. ✔ — and notice this *is* Tao's Heron computation with $d=0$ substituted, which is why the check at the end of the chapter works.)

**7. The triangle inequality.** No side of a triangle can exceed the sum of the other two (otherwise the two short sides cannot reach across). For $1,2,10$: $10 > 1+2$, so no such triangle exists.

**8. Two logical idioms.**
- *Without loss of generality* (WLOG): "the case I'm about to exclude is really the same as one I keep, by a relabelling or symmetry, so excluding it costs nothing." Tao assumes $d \ge 0$ WLOG because a progression with difference $-d$ is the same three numbers listed backwards.
- *Contrapositive*: "if $P$ then $Q$" is logically identical to "if not $Q$ then not $P$". Sometimes the second is far easier to prove. Programmer's version: the same branch, read from the other end.

**9. Degenerate case.** A limiting configuration where the object collapses: a triangle with zero area (three collinear points), a circle of radius $0$, an empty list. Degenerate cases are cheap to check and often expose the boundary of a formula's validity.

**10. Perpendicular bisector, concurrent, circumcentre, congruent** (needed only for the Preface example). The *perpendicular bisector* of a segment $AB$ is the line through the midpoint of $AB$ at right angles to it. Three lines are *concurrent* if all three pass through one common point. Two triangles are *congruent* if one can be laid exactly on the other (same three sides, same three angles) — congruence is the standard way to prove two lengths are equal. The cheapest congruence test, and the one the Preface uses, is **SAS**: if two triangles agree on two sides and on the angle *between* those two sides, they are congruent. (Why: the cosine rule then forces the third sides to be equal too, and once all three sides agree the triangles are the same shape.) The *circumcentre* of a triangle is the centre of the unique circle passing through all three vertices.

**11. Named sources you will see referenced.** *(Polya 1957)* is George Pólya's *How to Solve It*, the book from which the strategy taxonomy of this chapter descends. *Proclus* (5th century AD) was a Neoplatonist philosopher and commentator on Euclid; Tao opens the first-edition preface with him. Neither is needed mathematically — they are there to place the chapter in a tradition.

---

## Technique 0: The frame — what a problem *is*, and what counts as a good answer

Before any of the numbered strategies, the two prefaces install a mindset. It is worth extracting because it silently governs every decision later.

**How the preface actually opens (p. viii), because the register matters.** Tao quotes Proclus:

> "This therefore, is mathematics: she reminds you of the invisible forms of the soul; she gives life to her own discoveries; she awakens the mind and purifies the intellect; she brings to light our intrinsic ideas; she abolishes oblivion and ignorance which are ours by birth…"

and then immediately punctures it with a one-line paragraph:

> "But I just like mathematics because it is fun."

That is not decoration. It is a statement about what motivates the search behaviour described in the rest of the chapter: someone who finds the exploration itself enjoyable will happily run twenty cheap experiments that fail, which is exactly what pp. 4–6 consist of. If the only reward is the final answer, the dead ends feel like waste; if the process is the reward, they don't.

**Why puzzles are worth doing at all (p. viii).** Tao's justification is an analogy: "Mathematical problems, or puzzles, are important to real mathematics (like solving real-life problems), just as fables, stories, and anecdotes are important to the young in understanding real life." A puzzle is a fable: artificially clean, morally pointed, and rehearsing a manoeuvre you will later need in a messier setting.

- **What it is.** A competition problem is not a research problem. Tao's word for it is **'sanitized' mathematics** — "where an elegant solution has already been found (by someone else, of course), the question is stripped of all superfluousness and posed in an interesting and (hopefully) thought-provoking way."
- **Tao's own words.** He likens mathematics to prospecting for gold, and a good problem to a hide-and-seek course in gold prospecting: "you are given a nugget to find, and you know what it looks like, that it is out there somewhere, that it is not too hard to reach, that it is unearthing within your capabilities, and you have conveniently been given the right equipment (i.e. data) to get it. It may be hidden in a cunning place, but it will require ingenuity rather than digging to reach it." (p. viii) Note the four separate guarantees packed into that sentence: (i) the nugget exists, (ii) you would recognise it, (iii) it is not too far down, (iv) you personally have the strength to lift it. Each one is a licence to abandon an approach that violates it.
- **Why it works / what it buys you.** Three operational consequences, all of which he actually uses:
  1. **The answer exists and is reachable.** So if you are 40 lines into an unbounded computation, you are probably in the wrong place. This licenses abandoning an approach on aesthetic grounds alone.
  2. **You have been given the right equipment.** Every hypothesis is there because it is needed. So *unused data is evidence of a wrong or incomplete solution*, and conversely, a formula that consumes all your data at once is a promising formula. Tao explicitly cashes this in on p. 6: Heron's formula is worth pursuing because it "involves $d$ and $t$ — in essence, it uses all our data."
  3. **Ingenuity, not digging.** The intended solution is short. Look for the trick.
- **The two kinds of cheap trick he claims to be able to teach (p. viii).** He is precise about the catalogue: "There are ways of looking at a problem that make it easier to find a feasible attack plan. There are systematic ways of reducing a problem into successively simpler sub-problems." Techniques 1–5 are the first kind (re-framing before you compute); Techniques 6–8 are the second kind (reduction by perturbation). Every strategy in the chapter is one or the other, and it is worth knowing which one you are reaching for.
- **"Solving the problem is not everything" (p. viii).** This clause is the hinge of the whole preface and easy to skim past. It licenses the astonishing move of *rejecting a correct solution*. A correct coordinate-geometry proof of the perpendicular-bisector theorem is still a bad answer.
- **The rubric for a good solution (p. ix), Technique 0e.** "A solution should be relatively short, understandable, and hopefully have a touch of elegance. It should also be fun to discover." Four criteria, and note that two of them (understandable, fun) are about the *reader and the solver*, not about logical validity. This is the closest thing in the book to an acceptance test you can run on your own work. Programmer's version: passing the tests is necessary and not sufficient — the code also has to be readable, short, and pleasant to have written.
- **Failure mode Tao names.** Brute force. "Strip-mining the neighbourhood with bulldozers is clumsier than doing a careful survey, a bit of geology, and a small amount of digging" (p. viii). And: "Transforming a nice, short little geometry question into a ravening monster of an equation by textbook coordinate geometry does not have the same taste of victory as a two-line vector solution" (p. ix). For a programmer: this is exactly the difference between an $O(n^3)$ triple loop that happens to terminate and an $O(n\log n)$ algorithm that shows you why the answer is what it is. Both "work"; only one teaches you anything reusable. (Note in passing that "a two-line vector solution" is a *third* method for the bisector problem, distinct from both coordinate geometry and the synthetic proof he actually gives — evidence for Technique 10, that no single solution is canonical.)
- **The honest caveat.** "Two of the main weapons — experience and knowledge — are not easy to put into a book: they have to be acquired over time" (p. viii). The book teaches the *cheap* tricks; the expensive ones you have to earn. And in the second edition preface (p. xii) he adds that his purpose is emphatically **not** to present the slickest solution but "to show how one approaches a mathematical problem for the first time, and how the painstaking, systematic experience of trying some ideas, eliminating others, and steadily manipulating the problem can lead, ultimately, to a satisfying solution." That sentence is the licence for everything in this document: the dead ends are the content.

### Technique 0h (first-edition preface): How to read the book — the difficulty markers and the exercises

Small but load-bearing housekeeping from p. viii, because it tells you how to calibrate:

- **Unstarred problems** are the baseline.
- **Starred problems** `(*)` "indicate an additional level of difficulty, either because some higher mathematics or some clever thinking are required."
- **Double-starred problems** `(**)` are "similar, but to a greater degree."
- **"Some problems have additional exercises at the end that can be solved in a similar manner or involve a similar piece of mathematics."** So the exercises are not a random appendix: each one is deliberately within transfer distance of the problem it follows. When you meet one later in the book, the intended move is *reuse the technique you just watched*, not invent a new one. (The second-edition preface, p. xii, adds: "I have also added some more exercises.")
- **Where the problems come from (p. x).** "Almost all of the problems in this book come from published collections of problem sets for mathematics competitions. These are sourced in the texts, with full details given in the reference section of the book. I also used a small handful of problems from friends or from various mathematical publications; these have no source listed." Practical consequence: a problem with no citation is not necessarily easier, but a cited one has a documented, sanitized, competition-vetted solution — which is the gold-nugget premise in its strongest form.

### Techniques 0g and 0i (second-edition preface): the five ages of a mathematician, and why the tools stay elementary

The second-edition preface (pp. xi–xii) is written by the 30-year-old professional about the 15-year-old author, and it is the only place in the book where Tao steps outside the problem-solving frame to say what frame he is in. It is worth having, because it tells you what this book is *not*.

- **Opening.** "This book was written 15 years ago; literally half a lifetime ago, for me." In between: left home, moved country, graduate school, taught classes, wrote research papers, advised graduate students, married, had a son. "Clearly, my perspective on life and on mathematics is different now than it was when I was 15. I have not been involved in problem-solving competitions for a very long time now, and if I were to write a book now on the subject it would be very different from the one you are reading here."
- **The thesis.** "Mathematics is a multifaceted subject, and our experience and appreciation of it changes with time and experience." He then lists five stages, each with a different thing that made mathematics attractive:
  1. **Primary school** — "the abstract beauty of formal manipulation, and the remarkable ability to repeatedly use simple rules to achieve non-trivial answers." (This is the Lao Tzu epigraph of Chapter 1, felt rather than argued.)
  2. **High school, competing** — "I enjoyed mathematics as a sport, taking cleverly designed mathematical puzzle problems (such as those in this book) and searching for the right 'trick' that would unlock each one." **This is the stage the book is written from.** It explains why the whole method is a search for a single unlocking move, and why "sanitized" problems are the right material.
  3. **Undergraduate** — "awed by my first glimpses of the rich, deep, and fascinating theories and structures which lie at the core of modern mathematics today."
  4. **Graduate student** — "the pride of having one's own research project, and the unique satisfaction that comes from creating an original argument that resolved a previously open question."
  5. **Professional** — "I began to see the intuition and motivation that lay behind the theories and problems of modern mathematics, and was delighted when realizing how even very complex and deep results are often at heart be guided by very simple, even common-sensical, principles. The 'Aha!' experience of grasping one of these principles, and suddenly seeing how it illuminates and informs a large body of mathematics, is a truly remarkable one."
  
  And even that is not the end: "it is only recently for me that I have grasped enough fields of mathematics to begin to get a sense of the endeavour of modern mathematics as a unified subject, and how it connects to the sciences and other disciplines."
- **Why he did not rewrite it.** "As I wrote this book before my professional mathematics career, many of these insights and experiences were not available to me, and so in many places the exposition has a certain innocence, or even naivety. I have been reluctant to tamper too much with this, as my younger self was almost certainly more attuned to the world of the high-school problem solver than I am now." A striking editorial decision: he preserves a less expert text *because* it is closer to the reader's state. The pedagogical value of a solution written by someone who does not yet know the slick answer is exactly the value of watching a search rather than reading a result.
- **What he did change.** "A number of organizational changes: formatting the text into LaTeX, arranging the material into what I believe is a more logical order, and editing those parts of the text which were inaccurate, badly worded, confusing, or unfocused. I have also added some more exercises."
- **The dating disclaimer, and Technique 0i.** "In some places, the text is a bit dated (Fermat's last theorem, for instance, has now been proved rigorously), and I now realize that several of the problems here could be handled more quickly and cleanly by more 'high-tech' mathematical tools; but the point of this text is not to present the slickest solution to a problem or to provide the most up-to-date survey of results, but rather to show how one approaches a mathematical problem for the first time…" (Fermat's Last Theorem — no positive integers satisfy $x^n+y^n=z^n$ for $n\ge3$ — was open when the first edition was written and was proved by Andrew Wiles in 1994/95.) **The operational rule for a reader: when you spot a heavyweight theorem that would flatten a problem in one line, note it, then solve the problem the elementary way anyway. The elementary route is where the transferable technique lives.**
- **Acknowledgements worth recording as sourcing.** First edition (pp. ix–x): Peter O'Halloran, Vern Treilibs, and Lenny Ng "for their contributions of problems and advice"; "special thanks to Basil Rennie for his corrections and ingenious short-cuts in solutions"; and his family, for "support, encouragement, spelling corrections, and put-downs when I was behind schedule." Second edition (p. xii): Tony Gardiner for encouraging the reprint, his parents, and "the Flinders Medical Centre computer support unit for retrieving a 15-year old electronic copy of this book from our venerable Macintosh Plus computer!" Signed *Terence Tao, Department of Mathematics, University of California, Los Angeles, December 2005*.

### Technique 0b: Chain obvious facts to reach a non-obvious fact

The Preface's worked example (p. ix) is not part of Chapter 1's framework, but it is a technique demonstration and belongs here.

Tao introduces it as "an example of elegance… a standard result in Euclidean geometry", and boxes the statement exactly as he boxes the numbered problems in the chapters:

> **Show that the perpendicular bisectors of a triangle are concurrent.**

He then calls it "this neat little one-liner" — a phrase worth noting, because the shortness of the *statement* is being used as evidence about the expected shortness of the *solution*. A one-line question that needs three pages of algebra is a mismatch, and mismatch is the smell Technique 0 is trained to detect.

**The problem, unpacked.** Show that the three perpendicular bisectors of a triangle all pass through a single point.

**The bad approach he explicitly invites you to try and fail at.** Coordinate geometry: put $A=(x_1,y_1)$, etc., write the three bisector lines as equations, solve two of them for the intersection, substitute into the third. It works. It is also an algebraic swamp, and Tao says the one-liner "*could* be attacked by coordinate geometry. Try to do so for a few minutes (hours?), then look at this solution" — a deliberate exercise in feeling the pain of brute force before seeing the alternative. The parenthetical "(hours?)" is doing real teaching: he is telling you in advance that the brute-force route does not merely take longer, it takes *an order of magnitude* longer, and that you will not be able to tell this from the outside without trying.

**The figure (p. ix), described so you can redraw it.** A triangle with $A$ at the bottom-left, $B$ at the bottom-right, $C$ at the top (roughly above the midpoint of $AB$, slightly left). A point $P$ sits inside the triangle, in the lower-middle-right region. From $P$: a short segment drops straight down to the base $AB$, meeting it at a right angle (marked with a small square) at the midpoint of $AB$; another segment goes up-left to meet side $AC$ at a right angle (small square) at its midpoint; and segments join $P$ to the three vertices, so you can see the three lengths $|PA|, |PB|, |PC|$ that the proof is about. **Note what is deliberately absent: the third perpendicular bisector, the one of $BC$, is not drawn.** That omission is the diagram encoding the proof strategy — you draw two bisectors, define $P$ as their meet, and *deduce* the third. A diagram that showed all three concurrent lines would be assuming the conclusion.

```
                C
               /|\
              / | \
        (mid)o  |  \
            /\  |   \
           /  \ |    \
          /    \|     \
         /      P      \
        /      /|\      \
       A------o-+--o-----B
             (mid, right angle)
```

**The proof, and the two facts it chains** (each individually obvious):
1. *Fact A:* a point on the perpendicular bisector of $AB$ is equidistant from $A$ and $B$. So $|AP| = |PB|$.
2. Apply the same fact to the bisector of $AC$: $|AP| = |PC|$.
3. Transitivity (pure logic, no geometry): $|BP| = |PC|$.
4. *Fact A read backwards (its converse):* a point equidistant from $B$ and $C$ lies on the perpendicular bisector of $BC$. So $P$ is on the third bisector. Done — all three pass through $P$.

**The move that makes it work.** Reformulate "lies on the perpendicular bisector" into "is equidistant from the endpoints." Membership in a line is a hard thing to manipulate; equality of two distances is a trivial thing to manipulate, because equality is transitive. He has replaced a geometric predicate with an *algebraic* one that composes. Programmer's analogy: he found the right interface. `on_bisector(P, A, B)` and `dist(P,A) == dist(P,B)` are the same predicate, but only the second one lets you chain three calls with `==`.

**Technique 0b-ii: the reduced diagram.** Having finished, Tao adds a *second, smaller* figure, introduced with: "The following reduced diagram shows why $|AP| = |PB|$ if $P$ is on the $AB$ perpendicular bisector: congruent triangles will pull it off nicely." The figure is just the segment $AB$ horizontally, a point $P$ a little above the midpoint $M$, the segments $AP$ and $PB$ drawn (so you see a shallow isosceles triangle), the drop from $P$ to $M$ marked with a right angle, and tick marks on the two halves $AM$ and $MB$ showing they are equal. Two right triangles $APM$ and $BPM$ share the leg $PM$, have $|AM|=|MB|$, and have equal (right) angles at $M$ — that is SAS — so they are congruent, so $|AP|=|PB|$.

The technique: **when a step of your proof needs its own proof, isolate it in its own minimal picture with everything else deleted.** That is factoring out a lemma — the same instinct as pulling a helper function out of a long routine so it can be tested alone. Note also that Tao does not write the congruence argument out; he names the tool ("congruent triangles will pull it off nicely") and moves on. That is a judgement about which steps are worth the reader's page-space, and it is the same judgement he asks you to make about your own scratch paper in Technique 5.

His summary of why this is the good solution is the sentence the whole preface is built to reach: "This kind of solution — and the strange way that obvious facts mesh to form a not-so-obvious fact — is part of the beauty of mathematics. I hope that you too will appreciate this beauty." (p. ix)

### Technique 0c: Backtracking is free, so be aggressive

Chapter 1 opens against the Lao Tzu epigraph ("The journey of a thousand miles begins with one step"). Tao's twist (p. 1) is signalled by the phrase **"Like and unlike the proverb above"** — he agrees with half of it and rejects the other half. The half he agrees with: "the solution to a problem begins (and continues, and ends) with simple, logical steps." Every single step of a finished proof is elementary; there is never a step that is a leap. The half he rejects: the implied *count*. "But as long as one steps in a firm, clear direction, with long strides and sharp vision, one would need far, far less than the millions of steps needed to journey a thousand miles."

Three separate assets are named in that sentence and they are not the same thing: **direction** (you know which way the answer is), **stride length** (each step covers real ground — you invoke a theorem rather than re-deriving it), and **vision** (you can see far enough ahead to know the direction is still right — this is Technique 9b, looking ahead, appearing in the very first paragraph of the chapter). Being stuck is usually the failure of exactly one of the three, and it is worth diagnosing which.

Then the key observation: "mathematics, being abstract, has no physical constraints; one can always restart from scratch, try new avenues of attack, or backtrack at an instant's notice. One does not always have these luxuries in other forms of problem-solving (e.g. trying to go home if you are lost)."

- **What it buys you.** Since an abandoned attempt costs nothing but time, the optimal search strategy is to launch speculative attempts early and kill them fast. This is why the entire rest of the chapter is a catalogue of *deliberate perturbations* — special cases, deletions, reversals — every one of which is expected to fail most of the time. Programmer's analogy: depth-first search with free rollback, or `git checkout -b experiment` where the cost of a discarded branch is zero. Compare a physical maze, where a wrong turn costs you real steps.
- **The realistic caveat, in his own words:** "Of course, this does not necessarily make it easy; if it was easy, then this book would be substantially shorter. But it makes it possible."

He also names his source for the framework, and — importantly — declines to claim the list is complete: "There are several general strategies and perspectives to solve a problem correctly; (Polya 1957) is a classic reference for many of these. **Some** of these strategies are discussed below, together with a brief illustration of how each strategy can be used on the following problem." Two things follow. (i) The nine-or-so strategies in this chapter are a *selection*, not a taxonomy — Pólya's *How to Solve It* is the fuller catalogue. (ii) The chapter's structure is announced in advance: one problem, and every strategy demonstrated on that one problem. So when a strategy produces nothing on the triangle question, that is the format working as designed, not Tao running out of ideas.

**The specimen, stated verbatim (p. 1), boxed as PROBLEM 1.1:**

> "A triangle has its lengths in an arithmetic progression, with difference $d$. The area of the triangle is $t$. Find the lengths and angles of the triangle."

("Its lengths" means its three side lengths. Note what the statement does *not* say: it does not say the sides are $a, a+d, a+2d$, it does not say $d\ge0$, and it does not say where the triangle is or promise that a solution exists or is unique. Every one of those becomes a decision Tao has to make explicitly over the next six pages, and watching him make them is most of the value of the chapter.)

---

## Technique 1: Understand the problem — classify it by type

- **What it is.** Before anything else, decide which of three species of question you are looking at, because the species dictates the search strategy.
  1. **"Show that…" / "Evaluate…"** — a statement must be proved, or an expression computed.
  2. **"Find a…" / "Find all…"** — you must produce an object (or every object) satisfying requirements.
  3. **"Is there a…"** — you must decide existence, then either prove or produce a counterexample. This reduces to one of the first two *once you have guessed which way it goes*.
- **When to reach for it.** Always, first, unconditionally. Tao's opening question is literally "What kind of problem is it?"
- **Why it works.** In his words: "The type of problem is important because it determines the basic method of approach." Each type has a different natural attack:
  - Type 1 is *generally easiest* because "there is a clearly visible objective, one that can be deliberately approached." You know where you are going, so you can work forwards from the data and backwards from the goal and try to meet in the middle.
  - Type 2 is "more hit-and-miss; generally one has to guess one answer that nearly works, and then tweak it a bit to make it more correct; or alternatively one can alter the requirements that the object-to-find must satisfy, so that they are easier to satisfy." Two named sub-strategies: **guess-and-repair**, and **relax the constraints**.
  - Type 3 is "typically the hardest, because one must first make a decision on whether an object exists or not" — you have to gamble on the answer before you can even choose a proof style. Getting the gamble wrong costs you the whole attempt.
- **The escape hatch.** "Of course, not all questions fall into these neat categories; but the general format of any question will still indicate the basic strategy to pursue."
- **The non-mathematical illustration (p. 2), which is the clearest statement of the idea in the chapter.** Take the problem "find a hotel in this city to sleep in for the night." That is a bare Type 2 problem and it is unmanageable as stated. Tao's advice: *alter the requirements* to something concrete and checkable — "find a vacant hotel within 5 kilometres with a room that costs less than 100\$ a night" — and then "use pure elimination," i.e. enumerate candidates and filter. He explicitly ranks the strategies: this beats trying to prove such a hotel does or does not exist (converting it to Type 3, the hardest type), and it is *probably* better than picking any handy hotel and trying to prove you can sleep in it (guess-then-verify with a bad guess). The transferable point: **you can choose which type of problem to solve.** Reformulating a search problem into a decidable filter is a strategic act, not a cosmetic one. Programmer's analogy: turning an open-ended "find a good configuration" into "enumerate this bounded candidate set and score each one" — you have traded generality for a finite, mechanical procedure.
- **Applied to Problem 1.1** (p. 2): this is an "Evaluate…" problem — several unknowns to find in terms of given variables. First conclusion drawn purely from the classification, before touching the geometry: "This suggests an algebraic solution rather than a geometric one, with a lot of equations connecting $d$, $t$, and the sides and angles of the triangle, and eventually solving for our unknowns." Note the reasoning: *"find numbers in terms of parameters" smells like "set up equations and solve them," not "find a clever synthetic configuration."* That single judgement call determines the shape of the next six pages.

---

## Technique 2: Understand the data

- **What it is.** Ask "What is given in the problem?" Tao's model of what a problem *is* comes out here: "Usually, a question talks about a number of objects which satisfy some special requirements." So the data always splits into two lists — a list of **objects** (a triangle, an integer, a function) and a list of **requirements** those objects satisfy (its area is $t$; its sides are in arithmetic progression). Then, crucially, "one needs to see how the objects and requirements react to each other." Not just *what* you have: how the pieces interact.
- **When to reach for it.** Second, always.
- **Why it works / what it buys you.** Two concrete payoffs, both of which Tao names: it focuses attention on (i) the **proper techniques** and (ii) the **proper notation**. The data are a lookup key into your library of theorems.
- **Seen in action** (p. 2). The data of Problem 1.1 are: a triangle; its area; and the fact that its sides form an arithmetic progression with separation $d$. He then reads off the consequences mechanically:
  - "Because we have a triangle, and are considering the sides and area of it, we would need theorems relating sides, angles, and areas" — so: sine rule, cosine rule, the area formulas. He is *retrieving from memory by keyword*: the objects present are {sides, angles, area}, so fetch every theorem whose statement mentions those.
  - "Also, we are dealing with an arithmetic progression, so we would need some notation to account for that; for example, the side lengths could be $a$, $a+d$, and $a+2d$." Notice: a piece of data has generated a *notation requirement*, which is why Technique 4 comes next.
- **Transferable version.** Make a list: nouns present → theorems that mention those nouns; unusual structural hypotheses → parameterisations that make the hypothesis automatic. The second half is the powerful one. Writing the sides as $a, a+d, a+2d$ means the arithmetic-progression hypothesis can never be violated and never has to be checked again — it has been absorbed into the notation. (Programmer's analogy: encoding an invariant in the type rather than asserting it at runtime.)

---

## Technique 3: Understand the objective

- **What it is.** Ask "What do we want?" — state exactly what you must produce — and then convert it into **tactical goals**: intermediate targets you are confident bring you closer.
- **Technique 3b — name the species of objective.** Tao's own enumeration (p. 2): "One may need to find an object, prove a statement, determine the existence of an object with special properties, **or whatever**." Four named kinds plus an explicit escape hatch, mirroring the three problem types of Technique 1 from the other end. The mirroring is the point: Technique 1 classifies the *question*, Technique 3 classifies the *deliverable*, and they should agree. If your question looks like "Show that…" but your deliverable is an object, you have mis-parsed one of the two.
- **When to reach for it.** Third. Tao calls it "the flip side" of understanding the data. Data tells you what you can *push forward* from; objective tells you what you can *pull backward* from.
- **Why it works.** Same two payoffs as Technique 2 — it "helps focus attention on the best weapons to use" — plus one more: "Knowing the objective also helps in creating tactical goals which we know will bring us closer to solving the question."
- **Seen in action** (p. 2). Objective of Problem 1.1: "find all the sides and angles of the triangle." Consequences: (i) he will need theorems about sides and angles (agreeing with the data analysis — a convergence he treats as confirmation); (ii) the tactical goal becomes **"find equations involving the sides and angles of the triangle."**
- **What the tactical goal buys.** It is a target you can act on immediately. You cannot "find the angles" by an act of will, but you *can* write down equations. Programmer's analogy: decomposing a vague ticket into subtasks that each have a definite done-condition. And later (p. 6) the tactical goal is sharpened all the way down to "solve for $b$" — one scalar unknown, one equation needed.

---

## Technique 4: Select good notation

- **What it is.** Choose symbols so that the data and the objective are both expressed as simply as possible.
- **When to reach for it.** After 2 and 3, before writing any equation. "This usually involves the thoughts of the past two strategies" — notation is downstream of data and objective, which is why it is fourth and not first.
- **Seen in action (p. 3) — the full chain of notation refinements, each with its reason.**
  1. *Naive*: sides $a,b,c$; angles $\alpha,\beta,\gamma$. Six symbols, no structure.
  2. *Absorb the data*: since the sides are in arithmetic progression, write them $a,\ a+d,\ a+2d$. Three symbols become one ($a$), and the hypothesis is now unfalsifiable-by-construction.
  3. *Symmetrise*: better still, $b-d,\ b,\ b+d$. Same set of triples, but now centred. **This is the pivotal move of the whole solution** and the reason it collapses so neatly, as Technique 5b will show.
  4. *Handle the apparent cost*: "The only slight drawback to this notation is that $b$ is forced to be larger than $d$" (else the short side $b-d$ would be negative). See Technique 4b.
  5. *Consider trimming further and reject it*: he could name the angles $\alpha,\ \beta,\ 180^\circ-\alpha-\beta$, eliminating a symbol via the angle-sum fact. He declines: "this is ugly and unsymmetrical — it is probably better to keep the old notation, but bearing in mind that $\alpha+\beta+\gamma=180^\circ$."
- **Why it works / what it buys you.** Symmetric notation makes symmetric structure visible. With $a, a+d, a+2d$ the semiperimeter is $(3a+3d)/2$; with $b-d, b, b+d$ the two $\pm d$ terms cancel and the semiperimeter is exactly $3b/2$ — and *that* cancellation is the entire reason Heron's formula becomes tractable. A worse-but-equivalent notation would not have been wrong; it would merely have hidden the opportunity. Notation is not bookkeeping, it is where the first real insight of the problem gets encoded.
- **Failure mode, stated as a principle in step 5.** Minimality and symmetry can conflict. Fewer symbols is not automatically better: the $180^\circ-\alpha-\beta$ substitution reduces the symbol count but destroys the symmetry between the three angles, so every subsequent formula would treat $\gamma$ as a special case. Tao's resolution is the professional one: **keep the redundant symbol and carry the relation between them as a remembered side-constraint.** Programmer's analogy: sometimes you store a derived field for readability instead of recomputing it inline everywhere, and just remember to keep it in sync.

### Technique 4b: A notational "drawback" can be a free piece of data

The $b>d$ constraint looks like a wart. Tao's reaction (p. 3): "on further thought, we see that this is actually not a restriction; in fact the knowledge that $b>d$ is an extra piece of data for us."

- **The move.** When a representation seems to impose a condition, ask whether the condition was true anyway. If it was, you have not lost generality — you have *discovered a hypothesis you didn't know you had*, and it is now written down where you can use it.
- **Why it's true here.** The side lengths must be positive, so $b-d>0$ automatically. The constraint was never a constraint. (In fact the triangle inequality will strengthen it to $b\ge 2d$ — see Technique 5.)
- **A small inconsistency in the book, worth noticing rather than worrying about.** The prose on p. 3 says "$b$ is forced to be larger than $d$" and writes $b>d$; the fact-dump on the same page writes $b\ge d$. Both are harmless: $b=d$ would give a side of length $0$, which is not a triangle, so the strict inequality is the true one — and the triangle inequality supersedes both with $b\ge2d$ a few lines later anyway. The lesson is that a *strict-vs-non-strict* slip in an exploratory fact-dump costs nothing, whereas the same slip in a final answer would be a real error. Exploration and write-up have different standards of care.
- **Where it pays off.** At the very end, on p. 7, he has to choose between two roots $b^2 = 2d^2 \pm \sqrt{\cdots}$; positivity of $b$ picks the right one. The constraint noticed during *notation selection* is what closes the problem three pages later.

---

## Technique 5: Write down what you know in the notation selected; draw a diagram

- **What it is.** Physically transcribe every relevant fact onto paper, in your chosen notation, plus a picture.
- **Tao's own words — the three reasons (p. 3), quoted because the third is the non-obvious one:**
  > "(a) you have an easy reference later on; (b) the paper is a good thing to stare at when you are stuck; (c) the physical act of writing down of what you know can trigger new inspirations and connections."
- **Why it works.** (a) is bookkeeping. (b) is about the state you will actually be in — stuck, needing an external memory to scan rather than an internal one to thrash. (c) is the claim that *translation is generative*: rewriting the sine rule in the notation $b-d,b,b+d$ forces you to look at the expression $(b-d)/\sin\alpha$, and expressions you have looked at are expressions whose structure you can notice.
- **Failure mode, stated immediately.** "Be careful, though, of writing superfluous material, and do not overload your paper with minutiae." An undifferentiated wall of true facts is as useless as a blank page. His compromise: **highlight the facts you think will be most useful, and exile the "questionable, redundant, or crazy ideas" to a separate part of the scratch paper.** Two-tier note-taking — a working set and a spillover area. This is the same discipline as keeping a scratch buffer separate from your main file: you never delete a speculative idea, but you don't let it clutter the thing you are staring at.

**The actual dump for Problem 1.1** (p. 3, all seven items, with glosses):

| Fact | In symbols | Plain reading |
|---|---|---|
| physical constraints | $\alpha,\beta,\gamma,t>0$, and $b\ge d$; and WLOG $d\ge0$ | angles and area are positive; the short side is non-negative; and we may assume the progression is increasing, since listing the sides in the other order just flips the sign of $d$ |
| angle sum | $\alpha+\beta+\gamma=180^\circ$ | the redundant-symbol side-constraint from Technique 4 |
| sine rule | $\dfrac{b-d}{\sin\alpha}=\dfrac{b}{\sin\beta}=\dfrac{b+d}{\sin\gamma}$ | each side over the sine of its opposite angle is the same number |
| cosine rule | $b^2=(b-d)^2+(b+d)^2-2(b-d)(b+d)\cos\beta$, etc. | Pythagoras-with-a-correction for the side $b$; "etc." means the two analogous equations for the other sides |
| area formulas | $t=\tfrac12(b-d)b\sin\gamma=\tfrac12(b-d)(b+d)\sin\beta=\tfrac12 b(b+d)\sin\alpha$ | three ways to write the area as half the product of two sides times the sine of the angle between them |
| Heron's formula | $t^2=s(s-b+d)(s-b)(s-b-d)$, where $s=\big((b-d)+b+(b+d)\big)/2$ | area from the three sides alone, no angles |
| triangle inequality | $b+d \le b + (b-d)$ | the longest side does not exceed the sum of the other two; simplifying, $2d\le b$ — a *stronger* version of the $b\ge d$ he wrote in line 1 |

Two things worth pausing on that Tao leaves implicit. First, the sine-rule and area-formula lines each pack three equations into one line by exploiting the symmetric notation — the payoff from Technique 4 is visible on the page. Second, the triangle inequality line quietly upgrades $b \ge d$ to $b \ge 2d$; this is precisely the condition that makes $b^2-4d^2 \ge 0$, i.e. that makes the area in the final formula real. The geometry and the algebra agree, which is a free consistency check.

### Technique 5b: Triage the dump — decide *which* facts are promising, and why

This is the highest-value half-page in the chapter, because it shows the reasoning by which a mass of true statements is reduced to one line of attack (p. 4).

> "Many of these facts may prove to be useless or distracting. But we can use some judgement to separate the valuable facts from the unhelpful ones."

Two explicit selection criteria:

1. **Match the logical form of your tools to the logical form of your goal.** "The equalities are likely to be more useful than the inequalities, since our objective and data come in the form of equalities." An inequality can bound an answer; only an equality can pin it down. So the triangle inequality and the positivity constraints get demoted to a background role (they will be used at the end, only to select a root). *Transferable rule: if you must output an exact value, prefer exact relations; save inequalities for when the objective is itself a bound, or for eliminating cases.*

2. **Prefer the tool that your notation has already simplified.** "Heron's formula looks especially promising, because the semiperimeter simplifies to $s=3b/2$." Check it: $s = \frac{(b-d)+b+(b+d)}{2} = \frac{3b}{2}$ — the $d$'s cancel exactly. A four-factor product that looked forbidding has just lost its ugliest ingredient. *Transferable rule: after choosing notation, re-scan your candidate formulas for ones that collapsed. Collapse is the signal that this formula and this problem are aligned.*

A third criterion arrives on p. 6 and is really the gold-nugget premise in operational form: **prefer the tool that consumes all your data.** "As further evidence that this is going to be a step forward, note that Herons formula involves $d$ and $t$ — in essence, it uses all our data (we have already incorporated the fact about the sides being in arithmetic progression into our notation)." A formula touching every hypothesis is a formula that could plausibly be the whole solution; a formula touching half of them cannot be.

### Technique 5c: Draw a diagram — and be honest when it doesn't help

- Tao draws the picture and immediately says: "This is often quite helpful for geometry questions, though in this case the picture does not seem to add much."
- **The figure (p. 4), described so you can redraw it.** A scalene triangle, apex near the top-left-of-centre, base horizontal. Apex angle labelled $\gamma$; bottom-left angle labelled $\beta$; bottom-right angle labelled $\alpha$. The left side (from the $\beta$ vertex up to the apex) is labelled $b-d$; the right side (from the apex down to the $\alpha$ vertex) is labelled $b$; the base (from $\beta$ to $\alpha$) is labelled $b+d$. Inside, the text "area $t$". Note the labelling is consistent: each Greek letter is opposite the side you'd expect from the sine rule line, and the longest side $b+d$ sits opposite the largest angle $\gamma$.

```
            /\  γ
      b-d  /  \
          /    \  b
         /  area \
        /    t    \
    β  /___________\  α
           b + d
```

- **Why it doesn't help here.** The picture displays relationships that are already fully captured by the labels; there are no auxiliary points, no hidden circle, no congruent sub-triangles to spot. The information content of the diagram is zero beyond the algebra.
- **Why the admission matters.** This is a small act of intellectual honesty with a large methodological payload: a technique's presence in your checklist does not obligate you to find it useful. Run it, cost is low, discard the result if empty. Compare it with the Preface, where the picture (and especially the *reduced* picture) was doing all the work. **The lesson is not "always draw a diagram"; it is "always try, and be able to tell whether it paid."**

---

## Technique 6: Modify the problem slightly

- **What it is.** Replace the problem with a nearby, easier problem, in the hope that solving the easier one teaches you how to solve the real one. Tao's framing: "There are many ways to vary a problem into one which may be easier to deal with" — note *many*, and note that what follows is a menu of seven, so this is the one strategy in the chapter with an explicit enumerated toolbox. When stuck, you work down the list.
- **When to reach for it.** Tao is precise: "This is useful when you cannot even get started on a problem." It is the technique for a *blank page*.
- **Tao's seven sub-moves, verbatim in substance (p. 4), each with a gloss:**

  | | Sub-move | What it means in practice |
  |---|---|---|
  | (a) | **Consider a special case, such as extreme or degenerate cases** | Set a parameter to $0$, $1$, or $\infty$; take the smallest $n$; collapse the shape. Cheap, and often reveals the mechanism |
  | (b) | **Solve a simplified version** | Drop a complication (fewer variables, integers instead of reals, a square instead of a general quadrilateral) |
  | (c) | **Formulate a conjecture which would imply the problem, and prove that first** | Deliberately prove something *stronger*. Counter-intuitive but common: a stronger statement can have more structure to grip, and induction in particular often only works when strengthened |
  | (d) | **Derive some consequence of the problem, and prove that first** | Prove something *weaker*. Doesn't finish the job, but tests whether the statement is even true and often exposes the key mechanism |
  | (e) | **Reformulate the problem** — e.g. take the contrapositive, argue by contradiction, or try a substitution | Same content, different surface; the new surface may be manipulable where the old one wasn't |
  | (f) | **Examine solutions of similar problems** | Pattern-match against your library. This is where "experience and knowledge" from the Preface cash in |
  | (g) | **Generalize the problem** | Introduce a parameter $n$ where there was a specific number, or prove the $d$-dimensional version. Sometimes the general case is *easier* because the special one hid the pattern under coincidences |

  Note that (c)/(g) and (b)/(d) point in opposite directions — strengthen vs. weaken. Both are on the list, deliberately. You do not know in advance which direction has the traction.

- **Why it works.** "Solving for a simpler related problem sometimes reveals the way to go on the main problem. Similarly, considering extreme cases and solving the problem with additional assumptions can also shed light on the general solution."
- **Failure mode — stated at length, and important (p. 4):** "be warned that special cases are, by their nature, special, and some elegant technique could conceivably apply to them and yet have absolutely no utility in solving the general case. This tends to happen when the special case is *too* special. Start with modest assumptions first, because then you are sticking as closely as possible to the spirit of the problem." So there is a **dosage rule**: perturb as little as possible. A special case that trivialises the problem teaches you nothing about the problem, only about the trivialisation. (Programmer's analogy: a test case so degenerate that the wrong algorithm passes it.)

### Technique 6b: Extract the *shape* of the answer from a special case, even when you get no method

Applied to Problem 1.1 (p. 5), with $d=0$:

- $d=0$ means all three sides are equal — "in this case we need to find the side length of an equilateral triangle of area $t$." "It is a standard matter to compute the answer, which is $b=2t^{1/2}/3^{1/4}$." Tao does not show the work; here it is in full, since it is one of only two concrete numerical computations in the chapter. An equilateral triangle of side $b$ has height $\frac{\sqrt3}{2}b$ (drop the perpendicular to the base, which lands at the midpoint; Pythagoras gives $\sqrt{b^2-b^2/4}$), hence area $\frac{\sqrt3}{4}b^2$. Set that equal to $t$:
$$\frac{\sqrt3}{4}b^2 = t \;\Longrightarrow\; b^2 = \frac{4t}{\sqrt3} \;\Longrightarrow\; b = \frac{2\sqrt t}{3^{1/4}} = 2t^{1/2}/3^{1/4}.$$
(The $3^{1/4}$ appears because $\sqrt{1/\sqrt3} = 3^{-1/4}$ — a square root of a square root, i.e. a fourth root. That single observation is the whole content of the prediction below.) Sanity check with a number: $t=1$ gives $b = 2/3^{1/4} \approx 2/1.3161 \approx 1.5197$, and indeed $\frac{\sqrt3}{4}(1.5197)^2 \approx 0.4330 \times 2.3095 \approx 1.000$. ✔
- **Note also what a degenerate case would have given.** Tao's sub-move (a) offers "extreme or degenerate cases", and $d=0$ is the extreme one he picks. The genuinely *degenerate* choice would have been $t=0$ — a triangle of zero area, i.e. three collinear points. Try it: $3b^4-12d^2b^2 = 0$ gives $b^2 = 4d^2$, so $b=2d$, and the sides are $d, 2d, 3d$ — exactly the equality case of the triangle inequality, a flattened triangle. So the degenerate case is not useless: it recovers the boundary constraint $b \ge 2d$ from Technique 5 as the $t=0$ end of the answer. This is a check Tao does not run, and it is the kind of free confirmation the chapter is trying to teach you to look for.
- **The verdict Tao records:** "This indicates that the general answer should also involve square roots or fourth roots, but does not otherwise suggest how to go about the problem."

This is a partial success, and Tao's precision about *how* partial is the teachable bit. He got:
- **no method** (the equilateral computation uses a special formula that doesn't generalise), but
- **a prediction about the form of the answer** — expect $\sqrt{\ }$ and $\sqrt[4]{\ }$, which in turn hints that a quadratic (or a quadratic-in-a-square) is lurking, and
- **a test case** he will actually use on p. 7 to validate the final formula.

Two more results from this stage:
- **Sub-move (f), examining similar problems, "draws little as well, except one gets further evidence that a gung-ho algebraic attack is what is needed."** Even a failed technique returns a *bearing*: three independent lines of enquiry (problem type, deleting the positional data, and imitation of similar problems) have now all voted for algebra over geometry. Tao is accumulating weak evidence into a confident decision. That is how experienced solvers commit to a direction: not from one insight but from several cheap ones agreeing.

---

## Technique 7: Modify the problem significantly — break it on purpose

- **What it is.** Not gentle perturbation but demolition: "we perform major modifications to a problem such as removing data, swapping the data with the objective, or negating the objective (e.g. trying to disprove a statement rather than prove it)."
- **Tao's own words on the purpose, which is the whole point:**
  > "Basically, we try to push the problem until it breaks, and then try to identify where the breakdown occurred; this identifies what the key components of the data are, as well as where the main difficulty will lie."
- **When to reach for it.** When you want to understand the problem's *architecture* rather than solve it — which parts are load-bearing and which are decoration. Also, per Tao, because "these exercises can also help in getting an instinctive feel of what strategies are likely to work, and which ones are likely to fail."
- **Programmer's analogy.** This is ablation testing, or fuzzing your own specification: delete a requirement, run the problem, see whether it still has a unique answer. If it does, the requirement was redundant; if the answer becomes non-unique, you have found a datum that is doing real work; if the answer becomes impossible, you have found the constraint that makes the problem well-posed.

**The five demolitions Tao runs on Problem 1.1** (pp. 5–6). All but the last are dead ends, and he reports every one.

1. **Change the object: triangle → quadrilateral, circle, etc.** Verdict: "Not much help there: the problem just gets more complicated." Generalising the shape adds degrees of freedom without adding structure. *Dead end, reported.*

2. **Delete data that isn't in the problem statement at all: the position of the triangle.** "One does not really need a triangle in the question, but just the dimensions of the triangle. We do not really need to know the position of the triangle." Verdict: "here is further confirmation that we should concentrate on the sides and angles (i.e. $a,b,c,\alpha,\beta,\gamma$) and not on coordinate geometry or similar approaches." *Success — a third independent vote against coordinate geometry.* Note how this move works: he asks what information the problem does **not** depend on, and concludes that any method which carries that information (coordinates carry position) is doing wasted work. **If your method tracks quantities the answer cannot depend on, your method is too heavy.** This is exactly the Preface's complaint about coordinate geometry, now derived rather than asserted.

3. **Delete an objective (Technique 7b).** "Instead of working out all the sides and angles we could work out just the sides. But then one can notice that by the cosine and sine rules, the angles of the triangle will be determined anyway. So it is only neccesary to solve for the sides. But we know that the sides have lengths $b-d$, $b$, and $b+d$, so we only need to find what $b$ is to finish the problem." *Major success.* The objective has collapsed from six unknowns to one scalar. Trace the two compressions: (i) the cosine rule, rearranged as $\cos C = \frac{a^2+b^2-c^2}{2ab}$, is a *function* from three sides to three angles, so the angles are not independent unknowns at all; (ii) the symmetric notation from Technique 4 means the three sides are one unknown $b$. **Transferable rule: before solving for $n$ unknowns, check how many are genuinely free. Solve for a minimal generating set and derive the rest.** (Programmer's analogy: don't store six fields when one determines the other five — compute them on demand.)

4. **Delete data (Technique 7c).** Two experiments:
   - Omit $d$: "we seem to have several possible solutions, and not enough data to solve the problem." (True: infinitely many triangles have area $t$.)
   - Omit $t$: "omitting the area $t$ will not leave enough data to clinch a solution." (True: scaling any valid triangle gives another with the same-ratio structure but a different area.)
   
   So both hypotheses are load-bearing; there is no fat to trim, and any correct solution must use both. This is *why* he trusts Heron's formula on p. 6 — it is the formula that touches both.
   - **Partial deletion (Technique 7d)**, in a parenthesis worth extracting: "Sometimes one can *partially* omit data, for instance, by only specifying that the area is larger or smaller than some threshold $t_0$; but this is getting complicated. Stick with the simple options first." A datum need not be deleted wholesale — it can be weakened from an equation to an inequality, from "exactly $t$" to "at least $t_0$." Powerful, but Tao explicitly deprioritises it: **exhaust the cheap experiments before the expensive ones.**

5. **Reverse the problem — swap data with objective (Technique 7e).** This one he calls interesting even though he doesn't use it: "Suppose you had a triangle with arithmetic difference $d$, and you wanted to shrink it (or whatever) until the area becomes $t$. One could imagine our triangle shrinking and deforming, while preserving the arithmetic difference of the sides. Similarly, one could consider all triangles with a fixed area, and mold the triangle into one with the sides in the correct arithmetic progression."
   - What he has invented, in effect, is a **continuity/deformation argument**: instead of solving equations, move through the space of triangles while holding one constraint fixed until the other constraint is met. (The unstated engine is the intermediate value theorem: as you deform continuously, the area passes through every value between its endpoints, so it hits $t$.) That is a genuinely different proof style — topological rather than algebraic — and it would prove existence and uniqueness rather than produce a formula.
   - His verdict: "These ideas could work in the long run: but I will solve this question by another approach. Do not forget, though, that a question can be solved in more than one way, and no particular way can really be judged the absolute best." *A viable path, consciously not taken.* Worth noting that this reversal is what an "Evaluate…" problem looks like when you convert it into an existence problem — a Type 1 → Type 3 conversion, the opposite of what the hotel example recommended.

6. **Negate the objective (Technique 7f)** is on his list of major modifications ("trying to disprove a statement rather than prove it") but has no purchase on an "Evaluate…" problem, where there is no statement to disbelieve. It will matter later in the book. The idea: spend a serious effort trying to build a counterexample; either you find one (and you were asked the wrong question), or your failed attempts show you precisely which obstruction blocks all counterexamples — and that obstruction is usually the proof.

---

## Technique 8: Prove small results about the question; play with the data

- **What it is.** Derive whatever minor consequences you can, without needing them to be on the path to the answer.
- **Tao's own words:**
  > "Data is there to be used, so one should pick up the data and play with it. Can it produce more meaningful data? Also, proving small results could be beneficial later on, when trying to prove the main result or to find the answer. However small the result, do not forget it — it could have bearing later on. Besides, it gives you something to do if you are stuck."
- **When to reach for it.** When stuck. The last sentence is not a joke: having a mechanical, guaranteed-to-produce-something activity is what keeps you in contact with the problem instead of staring at it. Aimless-but-legal manipulation is a legitimate search strategy, because *the space of consequences of your hypotheses is where the answer lives.*
- **Honest assessment for this problem.** "In an 'Evaluate…' problem like the triangle question, this tactic is not as useful. But one can try." He is candid that this is the weakest technique on the current problem, and he demonstrates it anyway.

**The mini-results he derives** (p. 6), which are individually small and collectively a nice demonstration of a professional habit:

- **8b — Make the functional dependence explicit.** The tactical goal is to find $b$, which depends on $d$ and $t$; "in other words, $b$ is really a function: $b=b(d,t)$." He anticipates the reader's discomfort: "(If this notation looks out of place in a geometry question, then that is only because geometry tends to ignore the functional dependence of objects. For example, Heron's formula gives an explicit form for the area $A$ in terms of the sides $a$, $b$, and $c$: in other words, it expresses the function $A(a,b,c)$.)" This is a genuinely useful reframing for a CS reader: a geometry theorem is a function signature, and asking "what are this function's symmetries?" is a question you can ask of any formula, in any field. Once $b$ is a function, all the machinery you know about functions — symmetry, scaling, differentiation — becomes available.

- **8c — Symmetry:** $b(d,t) = b(-d,t)$, "because an arithmetic progression has an equivalent arithmetic progression with inverted arithmetic difference." (The sides $b-d, b, b+d$ read backwards are $b+d, b, b-d$ — the same triangle. So the answer must be an *even* function of $d$, i.e. involve only even powers of $d$.) This is exactly the WLOG $d \ge 0$ from the fact-dump, restated as a property of the answer — and it is a real prediction: the final formula contains only $d^2$ and $d^4$, never an odd power. Free error check.

- **8d — Scaling:** $b(kd, k^2 t) = k\, b(d,t)$, "this is done by dilating the triangle that satisfies $b=b(d,t)$ by $k$." Enlarge a triangle by a factor $k$: every length multiplies by $k$, so $d \mapsto kd$ and $b \mapsto kb$; area is two-dimensional, so $t \mapsto k^2 t$. This is dimensional analysis: $b$ and $d$ carry units of length, $t$ carries units of length-squared, and the formula must be dimensionally consistent. Check against the final answer $b = \sqrt{2d^2 + \sqrt{4d^4 + \tfrac{16}{3}t^2}}$: inside the inner root, $d^4$ and $t^2$ both have units of length$^4$ — they are allowed to be added. Then the inner root has units length$^2$, matching $2d^2$, and the outer root gives length. Consistent. **Dimensional consistency is the cheapest bug-catcher in mathematics, and it costs one line.**

- **8f — Differentiate:** "We could even try differentiate $b$ with respect to $d$ or $t$." Mentioned as an available move; not pursued.

- **8e — Cash the scaling law as a normalization.** "For this particular problem, these tactics allow us to perform some normalizations, for instance setting $t=1$ or $d=1$, and also provide a way to check the final answer." The scaling relation says the two-parameter family of problems is really a one-parameter family: solve the case $t=1$ and you get every case by dilation. **Any exact symmetry of a problem lets you delete a variable.** (Programmer's analogy: canonicalising your input before processing it, so the core routine handles one representative per equivalence class.)

- **Final verdict, reported honestly:** "However, in this problem these tricks turn out to only give minor advantages and we will not use them here." Except — note — he *does* use the checking function, twice: the evenness in $d$ and the $d=0$ verification.

---

## Technique 9: Simplify, exploit data, and reach tactical goals — the grind

- **What it is.** The actual computation, aimed at the tactical goals established earlier. Tao's trigger for entering this phase is explicit: "Now we have set up notation and have a few equations, we should seriously look at attaining our tactical goals that we have established." Notation plus a few equations plus a stated tactical goal — those are the three preconditions. Start computing before all three exist and you are flailing.
- **When to reach for it.** Last. Everything above is preparation; this is where most of the time goes. "Generally, this part is the longest and most difficult part of the problem."
- **Technique 9g — the grind itself is standard technique, and that is good news.** "In simple problems, there are usually standard ways of doing this. (For example, algebraic simplification is usually discussed thoroughly in high-school level textbooks.)" This is a reassuring and much-neglected remark. The creative work has already happened in Techniques 1–8; what remains is *craft*, and craft is drilled, not invented. If you cannot expand Heron's formula and factor a quartic, that is a fluency gap you close by practice, not an insight gap you close by staring. Programmer's analogy: choosing the algorithm is the hard part; once chosen, the implementation is a matter of knowing your language's standard library well enough not to fumble.
- **How not to get lost.** "One can avoid getting lost if one remembers the relevant theorems, the data and how they can be used, and most importantly the objective." The three-item recall list is essentially "keep your fact-dump, your data inventory, and your goal in working memory" — which is what Technique 5's paper is for. Note the ranking: the objective is flagged as *most important*, because in a long computation the failure mode is not forgetting a theorem (you can look it up) but forgetting what you were trying to produce and simplifying aimlessly.
- **The two things Heron is being asked to do (p. 6).** Before starting, Tao states both: "We can use this to attain our tactical goal of solving for $b$. After all, we have already noted that the **sine and cosine rules** can determine $\alpha,\beta,\gamma$ once $b$ is known." (Note it is both rules, not just the cosine rule; the cosine rule gets you the angles from the sides directly, and the sine rule gives a second, cheaper route once you have one angle.) So the plan is fully specified in advance: Heron gives $b$; the notation gives the other two sides; the sine/cosine rules give the three angles. Nothing after this point is exploratory.
- **Technique 9b — look ahead before committing.** The most valuable sentence in the section:
  > "It is also a good idea to not apply any given technique or method blindly, but to think ahead and see where one could hope such a technique to take one; this can allow one to save enormous amounts of time by eliminating unprofitable directions of inquiry before sinking lots of effort into them, and conversely to give the most promising directions priority."
  
  In other words: **simulate the computation cheaply before performing it expensively.** Before expanding Heron's formula, ask "if this works, what will I be left with?" — the answer is "a polynomial equation in $b$," which is a thing you know how to solve, so the direction is worth the effort. That prospective check is what distinguishes purposeful algebra from flailing. (Programmer's analogy: estimating the complexity of an approach before implementing it.)

### The resolution of Problem 1.1

See the Worked Problems section below for the full narration; the techniques used in the endgame are 9c (reduce to a single unknown, already done), 9d (spot the disguised quadratic), 9e (discard a root by positivity), and 9f (check against the special case).

---

## Worked problems

### Preface example — Show that the three perpendicular bisectors of a triangle meet at a single point

(Preface to the first edition, p. ix. Not numbered by Tao; included because it is a full technique demonstration.)

- **The data / the objective.** Data: a triangle $ABC$ and its three perpendicular bisectors (the line through the midpoint of each side, at right angles to it). Objective: a "Show that…" problem (Type 1) — prove the three lines are *concurrent*, i.e. share a common point.
- **The chain of moves.**
  1. `[classify]` "Show that…" — clear objective, work forwards from the data.
  2. `[the tempting brute force, offered and declined]` Coordinate geometry: assign coordinates, derive three line equations, intersect. Tao invites you to spend "a few minutes (hours?)" on it. It is correct and it is horrible. *Rejected on grounds of elegance — Technique 0.*
  3. `[reformulate: replace a geometric predicate with an algebraic one]` "$P$ lies on the perpendicular bisector of $AB$" $\iff$ "$|AP| = |PB|$". This is the whole idea. Distances can be chained by transitivity; line-membership cannot.
  4. `[modify the problem: weaken it — don't prove three lines concur, define P as the meet of two and prove it's on the third]` Let $P$ be the intersection point of the bisectors of $AB$ and of $AC$. (Two non-parallel lines always meet, so $P$ exists.) The objective is now the single statement "$P$ lies on the third bisector."
  5. `[apply the reformulation]` $P$ on the $AB$ bisector gives $|AP| = |PB|$. $P$ on the $AC$ bisector gives $|AP| = |PC|$.
  6. `[chain obvious facts]` Therefore $|BP| = |PC|$ — pure transitivity of equality.
  7. `[apply the reformulation backwards]` $|BP| = |PC|$ means $P$ is equidistant from $B$ and $C$, hence lies on the perpendicular bisector of $BC$. All three bisectors pass through $P$. $\blacksquare$
  8. `[note the by-product]` "Incidentally, $P$ is the circumcentre of $ABC$" — the point equidistant from all three vertices is the centre of the circle through all three. A free extra theorem, and an instance of Technique 8: small results are worth recording.
  9. `[reduced diagram — factor out the lemma]` Step 5 used a fact that itself needs proof. Tao isolates it in a minimal second figure: segment $AB$, point $P$ above its midpoint $M$, right angle at $M$, tick marks showing $|AM|=|MB|$. Triangles $APM$ and $BPM$ share side $PM$, have $|AM|=|MB|$, and have equal (right) angles at $M$; hence they are congruent, hence $|AP|=|PB|$.
- **Transferable lesson.** Three of them. (i) *Don't prove that three things coincide; define the meeting point of two and show the third contains it* — a general trick for concurrency and for any "$n$ objects share a property" statement: reduce $n$ conditions to $n-1$ plus a derivation. (ii) *Find the reformulation under which your objects compose.* Equality of distances composes; incidence on a line doesn't. (iii) *A chain of individually trivial equalities can produce a non-trivial theorem* — Tao's "the strange way that obvious facts mesh."

---

### Problem 1.1 — A triangle's three side lengths form an arithmetic progression with common difference $d$, and its area is $t$. Find all three side lengths and all three angles, in terms of $d$ and $t$.

**Tao's exact wording (p. 1):** "A triangle has its lengths in an arithmetic progression, with difference $d$. The area of the triangle is $t$. Find the lengths and angles of the triangle."

(pp. 1–7. This is the specimen for the entire framework; Tao runs every strategy on it in sequence, and most of them fail.)

- **The data (Tao's framing, p. 2).** A triangle; the area of the triangle; the fact that the sides are in arithmetic progression with separation $d$. Reaction: fetch the theorems relating sides, angles, and areas — sine rule, cosine rule, area formulas — and invent notation for the progression.
- **The objective (p. 2).** "Find all the sides and angles of the triangle." Type: "Evaluate…". Tactical goal: "find equations involving the sides and angles of the triangle." Later sharpened to: **find $b$.**

**The chain of moves.**

1. `[understand the problem: classify]` "Evaluate…" — several unknowns in terms of given parameters. Conclusion: an **algebraic** attack (lots of equations, then solve), not a synthetic-geometry one.
2. `[understand the data]` Objects present are sides, angles, area ⇒ retrieve sine rule, cosine rule, area formulas, Heron. Structural hypothesis (arithmetic progression) ⇒ needs a parameterisation.
3. `[understand the objective]` All sides and angles ⇒ need side/angle theorems (agrees with step 2) ⇒ tactical goal: get equations.
4. `[select good notation, v1]` Sides $a$, $a+d$, $a+2d$: absorbs the progression hypothesis so it can never be violated.
5. `[select good notation, v2 — symmetrise]` Better: $b-d$, $b$, $b+d$. **The key preparatory move.**
6. `[turn a drawback into data]` The apparent restriction $b>d$ is automatic (side lengths are positive), so it costs nothing and is recorded as usable data. It will select the correct root at the very end.
7. `[reject an over-optimisation]` Naming the angles $\alpha,\beta,180^\circ-\alpha-\beta$ would remove a symbol but destroy symmetry: "ugly and unsymmetrical." Keep $\alpha,\beta,\gamma$ plus the remembered constraint $\alpha+\beta+\gamma=180^\circ$.
8. `[write down everything you know]` The seven-item list (physical constraints, angle sum, sine rule, cosine rule, three area formulas, Heron, triangle inequality) — see the table under Technique 5.
9. `[triage: form-matching]` Equalities over inequalities, because the data and objective are equalities.
10. `[triage: look for collapse]` Heron's formula is flagged as most promising because the semiperimeter collapses to $s = 3b/2$ in the symmetric notation.
11. `[draw a diagram]` Drawn, labelled, and honestly assessed: "the picture does not seem to add much." *Technique run, verdict negative, move on.*
12. `[modify slightly: special case $d=0$]` Equilateral triangle of area $t$ has side $b = 2t^{1/2}/3^{1/4}$. **Partial payoff**: predicts square/fourth roots in the general answer; gives no method; provides an end-of-problem check. *Not a dead end, not a solution.*
13. `[modify slightly: examine similar problems]` "Draws little as well, except one gets further evidence that a gung-ho algebraic attack is what is needed." *Dead end that nonetheless reinforces the bearing.*
14. `[modify significantly: change the object]` Triangle → quadrilateral / circle. "Not much help there: the problem just gets more complicated." **Dead end, abandoned because generalisation added freedom without structure.**
15. `[modify significantly: delete the position data]` The problem never referred to where the triangle is, only to its dimensions. Conclusion: coordinate geometry carries information the answer cannot depend on ⇒ third vote for pure algebra in the sides and angles. **Success.**
16. `[modify significantly: delete objectives]` Drop the angles from the objective — the sine and cosine rules recover them from the sides. Drop two of the three sides — the notation gives them from $b$. **Objective reduced from six unknowns to the single unknown $b$. Major success.**
17. `[modify significantly: delete data]` Delete $d$ ⇒ infinitely many solutions. Delete $t$ ⇒ no solution. Both data are load-bearing; therefore the winning formula must use both. **Success (as a diagnostic).**
18. `[modify significantly: partially delete data]` Replace "area $=t$" with "area $>t_0$"? Noted as possible, judged "getting complicated," deferred: "Stick with the simple options first." **Deliberately not pursued.**
19. `[modify significantly: reverse data and objective]` Deform a triangle of fixed arithmetic difference until its area is $t$; or mould a fixed-area triangle until its sides are in progression. A continuity/deformation argument. "These ideas could work in the long run: but I will solve this question by another approach." **Viable alternative path, consciously abandoned in favour of algebra.**
20. `[prove small results: make the dependence functional]` Write $b = b(d,t)$.
21. `[prove small results: symmetry]` $b(d,t)=b(-d,t)$, since reversing the progression flips the sign of $d$ without changing the triangle. ⇒ the answer must involve only even powers of $d$.
22. `[prove small results: scaling]` $b(kd,k^2t)=k\,b(d,t)$, by dilating the triangle by $k$ (lengths scale by $k$, areas by $k^2$).
23. `[prove small results: differentiate]` Mentioned ($\partial b/\partial d$, $\partial b/\partial t$), not pursued.
24. `[normalize]` Scaling permits setting $t=1$ or $d=1$ to kill a parameter. Noted, judged a minor gain here, not used — but the same relations are kept as answer-checks.
25. `[look ahead before committing]` Heron's formula uses both $d$ and $t$ (all the data) and, once expanded, will leave a polynomial equation in the single unknown $b$ — a thing that can definitely be solved. Direction confirmed *before* the algebra starts.
26. `[grind: substitute into Heron]` With $s = 3b/2$ and sides $b-d, b, b+d$:
$$t^2 = \frac{3b}{2}\left(\frac{3b}{2}-b+d\right)\left(\frac{3b}{2}-b\right)\left(\frac{3b}{2}-b-d\right).$$
27. `[grind: simplify]` The three brackets are $\frac b2+d$, $\frac b2$, $\frac b2-d$. Multiplying $(\frac b2 + d)(\frac b2 - d) = \frac{b^2}{4}-d^2$ (difference of two squares), so
$$t^2 = \frac{3b^2(b-2d)(b+2d)}{16} = \frac{3b^2(b^2-4d^2)}{16}.$$
28. `[spot the disguised quadratic]` Clear denominators and move everything to one side:
$$3b^4 - 12d^2b^2 - 16t^2 = 0.$$
"The right-hand side is a polynomial in $b$ (treating $d$ and $t$ as constants), and in fact it is a quadratic in $b^2$. Now quadratics can be solved easily." I.e. substitute $u=b^2$ to get $3u^2 - 12d^2u - 16t^2 = 0$, an ordinary quadratic. *This is the promised payoff of the $d=0$ prediction in step 12: a quadratic in $b^2$ is exactly what produces fourth roots.*
29. `[apply the quadratic formula]` With $A=3$, $B=-12d^2$, $C=-16t^2$:
$$b^2=\frac{12d^2\pm\sqrt{144d^4+192t^2}}{6}=2d^2\pm\sqrt{4d^4+\frac{16}{3}t^2}.$$
(The second form comes from dividing inside the root by $6^2=36$: $144/36=4$ and $192/36=16/3$. **Note two typographical slips in the printed book, p. 7:** it prints $\sqrt{144d^4+196t^2}$ where the discriminant $B^2-4AC = 144d^4 + 4\cdot3\cdot16\,t^2 = 144d^4+192t^2$, and it prints $4d^2$ instead of $4d^4$ under the second root. The final displayed answer on the same page has $4d^4$ and is correct.)
30. `[discard a root by physical constraint]` "Because $b$ has to be positive" — and because $\sqrt{4d^4+\frac{16}{3}t^2} > 2d^2$ whenever $t>0$, the minus sign would make $b^2$ negative. Take the plus sign:
$$\boxed{\,b=\sqrt{2d^2+\sqrt{4d^4+\tfrac{16}{3}t^2}}\,}$$
31. `[check against the special case]` "As a check, we can verify that when $d=0$ this agrees with our previous computation of $b=2t^{1/2}/3^{1/4}$." Indeed, at $d=0$: $b=\sqrt{\sqrt{16t^2/3}} = \sqrt{4t/\sqrt3} = 2\sqrt t/3^{1/4}$. ✔ Also observe the answer contains only $d^2$ and $d^4$ — even in $d$, as step 21 predicted. ✔ And it is dimensionally consistent, as step 22 predicted. ✔
32. `[recover the deleted objectives]` The sides are $b-d,\ b,\ b+d$. Then, as established in step 16, "the evaluation of the angles $\alpha,\beta,\gamma$ then follows from the cosine laws, and we are done!" Concretely, $\cos\beta = \frac{(b-d)^2+(b+d)^2-b^2}{2(b-d)(b+d)}$, and similarly for the other two, with the angle sum as a check.

**A concrete case worth computing by hand.** Tao never plugs a number into his answer beyond the $d=0$ check, and the chapter is poorer for it — "try small cases" is sub-move 6(a) and it applies to your own finished formula, not just to the problem. So: take $d=1$ and $t=6$.
$$b^2 = 2d^2+\sqrt{4d^4+\tfrac{16}{3}t^2} = 2+\sqrt{4+\tfrac{16}{3}\cdot36} = 2+\sqrt{4+192} = 2+\sqrt{196} = 2+14 = 16,$$
so $b=4$ and the sides are $b-d, b, b+d = 3, 4, 5$. **It is the 3-4-5 right triangle** — whose sides really are in arithmetic progression with difference $1$, and whose area really is $\tfrac12\cdot3\cdot4 = 6$. Now recover the angles from the cosine rule, exactly as step 32 promises, using $\cos C = \frac{(\text{other two sides squared, summed}) - c^2}{2\cdot(\text{product of other two})}$:
- $\alpha$, opposite the side $b-d=3$: $\cos\alpha = \frac{4^2+5^2-3^2}{2\cdot4\cdot5} = \frac{32}{40} = 0.8$, so $\alpha = 36.87^\circ$.
- $\beta$, opposite the side $b=4$: $\cos\beta = \frac{3^2+5^2-4^2}{2\cdot3\cdot5} = \frac{18}{30} = 0.6$, so $\beta = 53.13^\circ$.
- $\gamma$, opposite the side $b+d=5$: $\cos\gamma = \frac{3^2+4^2-5^2}{2\cdot3\cdot4} = \frac{0}{24} = 0$, so $\gamma = 90^\circ$ — Pythagoras falling out of the cosine rule, as it must.

Angle-sum check: $36.87+53.13+90 = 180$. ✔ Triangle-inequality check: $b=4 \ge 2d = 2$. ✔ This one case exercises every single tool in the chapter's fact-dump, and it takes two minutes. If you had made an algebra slip anywhere in the six pages, it would show up here.

**The resolution, in one paragraph for the reader.** Everything turned on two decisions made before any calculation. First, writing the sides as $b-d, b, b+d$ instead of $a, a+d, a+2d$: this makes the perimeter $3b$ exactly, so Heron's formula — the only tool that links *area* to *sides* without angles — loses its dependence on $d$ in the semiperimeter and becomes a clean product of two differences of squares. Second, realising that of the six things asked for, five are determined by the sixth: the cosine rule turns sides into angles, and the notation turns one side into three. So the six-unknown "evaluate everything" problem became the one-unknown equation $3b^4-12d^2b^2-16t^2=0$, which is a quadratic wearing a quartic's clothes. Solve it, throw away the negative root because lengths are positive, and read off everything else.

**Transferable lesson.** The solution is four lines of algebra preceded by six pages of preparation, and the preparation is where the problem was actually solved. Specifically: (i) symmetric notation is not cosmetic — it is where you install your first insight, and it is what makes the right formula visibly collapse; (ii) count your *genuinely free* unknowns before solving for anything; (iii) run cheap experiments (special cases, deletions, reversals) in parallel and treat their agreement as a bearing, even when each individually fails; (iv) predict the *form* of the answer early (fourth roots, even in $d$, dimensionally consistent) so that you have three independent checks when you finally get one; (v) look ahead before you commit to a long computation. And (vi), from the sheer number of abandoned branches recorded on pp. 4–6: **most of the moves an expert makes do not work, and they make them anyway, quickly, because the cost of a dead end is one paragraph.**

**Exercises.** Chapter 1 has none, and Problem 1.1 has none attached. This is the exception in the book: per the first-edition preface (p. viii), "*some* problems have additional exercises at the end that can be solved in a similar manner or involve a similar piece of mathematics" — some, not all — and the second-edition preface (p. xii) notes "I have also added some more exercises." Chapter 1 is pure methodology plus one specimen; the exercises begin in the later chapters.

**Exercises you can set yourself from this chapter** (not Tao's — but every one of them is a strategy from the chapter applied to the chapter's own problem, and they are cheap):

1. Run the *degenerate* special case $t=0$ on the final formula and check you get $b=2d$, i.e. sides $d,2d,3d$ — the flattened triangle at the equality case of the triangle inequality. (Sub-move 6(a); see Technique 6b.)
2. Verify the answer is an even function of $d$ by inspection, as Technique 8c predicted, and confirm that this rules out any candidate answer containing a bare $d$ or $d^3$.
3. Cash the scaling law: set $t=1$ and solve for the one-variable function $b(d,1) = \sqrt{2d^2+\sqrt{4d^4+16/3}}$, then recover the general formula from $b(d,t) = \sqrt{t}\; b\!\left(d/\sqrt t,\,1\right)$ (take $k=\sqrt t$ in $b(kd,k^2t)=k\,b(d,t)$). Confirm you get Tao's answer back. (Technique 8e. This is the normalization Tao mentions and declines to use.)
4. Run the formula on a concrete case and recover all six quantities by hand. Take $d=1$, $t=6$ (worked out in "A concrete case worth computing by hand" above — it is the $3,4,5$ triangle). Then try $d=2,\ t=6$: you should get $b^2 = 8+\sqrt{64+192} = 24$, so $b=2\sqrt6\approx4.899$ and sides $\approx 2.899,\ 4.899,\ 6.899$; check the triangle inequality $b\ge2d=4$ still holds. (Technique 9 + Technique 9f.)
5. Try the reversal Tao left on the table (Technique 7e): prove that for each $d\ge0$ and $t>0$ a valid triangle exists and is unique, by a continuity argument — fix $d$, let $b$ range over $[2d,\infty)$, note the area $\frac{1}{4}b\sqrt{3(b^2-4d^2)}$ is continuous, equals $0$ at $b=2d$, and increases without bound; apply the intermediate value theorem. Compare the two proofs: one gives a formula, one gives existence and uniqueness. Which is a better answer, by the p. ix rubric?
6. Do the coordinate-geometry proof of the perpendicular-bisector theorem that Tao invites you to attempt, and time yourself. Then re-read his four-line proof. (Technique 0 — the point of the exercise is the felt difference, not the result.)

---

## What this chapter teaches about problem solving in general

1. **There is a fixed opening sequence, and it contains no calculation.** Classify the problem type → inventory the data → state the objective and convert it to tactical goals → choose notation → write everything down. Five steps, all cheap, all skippable-but-costly. Tao performs them in this order on every problem in the book. The discipline is exactly that of not writing code until you know the data structures and the interface.

2. **Notation is where the first insight lives.** $b-d, b, b+d$ versus $a, a+d, a+2d$ is the difference between Heron's formula being tractable and being a mess. Symmetric, minimal, hypothesis-absorbing notation is a mathematical act, not a clerical one. Corollary from Tao's rejection of $180^\circ - \alpha - \beta$: minimality and symmetry can conflict, and symmetry usually wins — carry the redundant symbol plus a remembered relation.

3. **Count the free unknowns before you solve for any of them.** Six quantities were requested; one determined all six. Half the difficulty of a problem is often the illusion that its parts are independent.

4. **When stuck, perturb the problem systematically rather than staring harder.** Tao gives a menu: special/degenerate cases, simplifications, stronger conjectures, weaker consequences, reformulations, similar problems, generalisations; then the aggressive versions — delete data, delete objectives, swap data with objective, negate the objective. "Push the problem until it breaks, and then try to identify where the breakdown occurred." The breakage tells you which hypotheses are load-bearing and where the real difficulty is. Perturb by the smallest amount that changes something: a case that is *too* special teaches you only about itself.

5. **A failed experiment still returns information.** The equilateral case gave no method but predicted fourth roots and supplied a final check. Deleting the position of the triangle solved nothing but eliminated coordinate geometry. Examining similar problems drew a blank but confirmed the algebraic bearing. Several weak, cheap, independent signals agreeing is how you justify committing to a direction — and this is why free backtracking should make you *more* speculative, not less.

6. **Look ahead before you compute; use elegance as a pruning heuristic.** Ask where a technique could *hope* to take you before investing in it. If the destination is "a polynomial equation in one unknown," go; if it is "a ravening monster of an equation," you are strip-mining with bulldozers and there is almost certainly a survey-and-a-spade solution nearby. Because a competition problem is guaranteed to have a short solution, ugliness is genuine evidence of a wrong turn.

7. **Use all the data — and use it as a diagnostic in both directions.** The problem was assembled with exactly the equipment needed. So: a candidate method that touches every hypothesis is promising (Heron uses both $d$ and $t$); a finished solution that never used a hypothesis is suspect; and a quantity the answer cannot depend on (the triangle's position) should not appear in your method.

8. **Build checks into the solution before you have an answer.** Symmetry ($b$ even in $d$), scaling/dimensional consistency ($b \sim$ length), and the special case ($d=0$) were all established during the *exploration* phase and cashed in as three independent verifications of the final formula. Small results are cheap, they give you something to do when stuck, and they pay for themselves. "However small the result, do not forget it."

9. **"Solving the problem is not everything" — score your answer, don't just check it.** The preface hands you a four-part rubric (p. ix): a solution should be **short**, **understandable**, have **a touch of elegance**, and be **fun to discover**. Only the first is objective; the rest are aesthetic, and Tao treats aesthetic failure as grounds for throwing away a *correct* proof. This is the single most alien idea in the chapter for a reader trained to think "it passes the tests, ship it," and it is the one that generalises furthest. Corollary: when a one-line question turns into a page of algebra, the mismatch itself is the bug report.

10. **Know which register you are in.** From the second-edition preface (pp. xi–xii): this book is written from the "mathematics as a sport" stage — "taking cleverly designed mathematical puzzle problems… and searching for the right 'trick' that would unlock each one." That premise is what makes the methods here work, and it is also their boundary. In research (Tao's later stages) there is no guarantee a nugget exists, no guarantee it is reachable, and no guarantee you were handed the right equipment; the "unused hypothesis means wrong solution" heuristic evaporates. Tao is explicit that he preserved the book's "innocence, or even naivety" rather than modernising it, and that several problems "could be handled more quickly and cleanly by more 'high-tech' mathematical tools" — and refused to use them, because the elementary route is the one that shows how a problem is *approached for the first time*. **Practical rule: if you spot the heavy theorem, note it, then solve it the elementary way anyway.**

11. **There is no unique right solution, and the search itself is the skill.** "A question can be solved in more than one way, and no particular way can really be judged the absolute best" (p. 6) — Tao leaves a whole deformation-based approach on the table. And from the second-edition preface (p. xii), the point of the book is not the slickest proof but "how the painstaking, systematic experience of trying some ideas, eliminating others, and steadily manipulating the problem can lead, ultimately, to a satisfying solution." The takeaway for anyone learning from this book: study the abandoned branches, not just the printed answer.
