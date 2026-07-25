# Chapter 1: Strategies in problem solving

> The journey of a thousand miles begins with one step.
> — Lao Tzu

This chapter contains almost no mathematics of its own. There is one triangle, and it is a dull triangle. What it contains instead is the list of moves, in the order one actually performs them, and the triangle is there only so that each move has something to be performed upon. Read it as what one does *before* one is allowed to start computing, and as a description of the state in which one spends most of one's time: stuck, with nothing obvious to try.

Pages covered: Preface to the first edition (pp. viii–x), Preface to the second edition (pp. xi–xii), Chapter 1 (pp. 1–7).

A note on the presentation. Tao's own section headings are the nine bold run-in heads below — *Understand the problem*, *Understand the data*, and so on. They are his names, not numbers assigned afterwards, and this document keeps them. Where he has a phrase for something ('sanitized' mathematics, the gold nugget, modifying the problem slightly), that phrase is used. Where he performs a move without naming it, a name is supplied here and marked as such.

---

## The strategies at a glance

| Strategy (Tao's heading, where he gives one) | When one reaches for it | Where he does it |
|---|---|---|
| **Understand the problem** — which of the three types is it? | Always, first | pp. 1–2: 'Evaluate…' ⇒ an algebraic attack |
| **Understand the data** — what objects, what requirements, how do they react to each other? | Always, second | p. 2: triangle + area + progression ⇒ sine rule, cosine rule, area formulas |
| **Understand the objective** — and turn it into tactical goals | Always, third | p. 2: "find all the sides and angles" ⇒ "find equations involving the sides and angles" |
| **Select good notation** | Once data and objective are clear, before any calculation | p. 3: $a,a+d,a+2d$ improved to $b-d,\ b,\ b+d$ |
| — *a drawback that is really data* (unnamed by Tao) | Your notation seems to impose a restriction | p. 3: $b>d$ turns out to be a free fact |
| **Write down what you know in the notation selected; draw a diagram** | Always; especially when stuck and staring | pp. 3–4: the seven-item list; the labelled triangle |
| — *triage the dump* (unnamed) | The page of facts is getting long | p. 4: equalities beat inequalities; Heron flagged because $s=3b/2$ |
| — *admit when a technique does not pay* (unnamed) | You ran one and got nothing | p. 4: "the picture does not seem to add much" |
| **Modify the problem slightly** — special case, simplify, stronger conjecture, consequence, reformulate, imitate, generalize | You cannot get started at all | pp. 4–5: try $d=0$ |
| **Modify the problem significantly** — remove data, swap data with objective, negate the objective | You want to know where the difficulty lives | pp. 5–6: quadrilateral; delete position; delete objectives; delete $d$; delete $t$; reverse |
| **Prove results about our question** — pick up the data and play with it | You are stuck and need something to do | p. 6: $b=b(d,t)$, its symmetry and its scaling |
| **Simplify, exploit data, and reach tactical goals** — the long grind | Setup is done | pp. 6–7: Heron ⇒ quartic ⇒ quadratic in $b^2$ ⇒ $b$ |
| — *look ahead before committing* | You are about to start a long computation | p. 6: see where a technique "could hope" to take you |
| — *the four guarantees of the gold nugget* | Deciding whether to abandon an approach | Preface, p. viii |
| — *the rubric: short, understandable, elegant, fun* | You have finished and want to know whether to look again | Preface, p. ix |
| — *chain obvious facts* | You cannot see the destination but can see one small true step | Preface, p. ix: the perpendicular bisectors |
| — *keep the toolkit elementary* | You know a heavyweight theorem that would flatten the problem | 2nd-ed. preface, p. xii |

Every entry is developed below.

---

## Background one needs first

Six pieces of school geometry that a computing education skips, and two logical idioms. Nothing else in the chapter goes beyond first-year calculus.

**Arithmetic progression.** A list in which each term exceeds the last by a fixed amount $d$, the common difference; $3,7,11$ has $d=4$. That the sides are in arithmetic progression with difference $d$ means they may be written $a,\ a+d,\ a+2d$ — or, as Tao prefers within half a page, $b-d,\ b,\ b+d$, which is the same three numbers with $b=a+d$.

**Naming triangles.** Sides take lower-case letters, angles take Greek letters, and an angle is *opposite* the side it does not touch. In the chapter's diagram $\alpha$ is opposite $b-d$, $\beta$ opposite $b$, and $\gamma$ opposite $b+d$.

**The angles sum to $180^\circ$**, so $\alpha+\beta+\gamma=180^\circ$, and two angles determine the third. This is why one *could* name them $\alpha,\ \beta,\ 180^\circ-\alpha-\beta$, and why Tao decides not to.

**The sine rule.** Each side over the sine of its opposite angle gives the same number:
$$\frac{\text{side}_1}{\sin(\text{angle opposite side}_1)}=\frac{\text{side}_2}{\sin(\text{angle opposite side}_2)}=\frac{\text{side}_3}{\sin(\text{angle opposite side}_3)}.$$
Try it on the $3,4,5$ triangle. Opposite the $5$ is the right angle, $\sin 90^\circ=1$, so the common ratio is $5$; the angle opposite the $3$ therefore has sine $0.6$, about $36.87^\circ$. What it buys: three sides give three angles.

**The cosine rule.** Pythagoras with a correction term, for a side $c$ opposite an angle $C$:
$$c^2=a^2+b^2-2ab\cos C.$$
At $C=90^\circ$ the correction vanishes and one is back to Pythagoras. What it buys: solve for $\cos C$ and every angle follows from the three sides alone. This is the fact that later lets Tao drop the angles from his objective altogether.

**Two area formulas.** First, half the product of two sides times the sine of the angle between them. Second, Heron's formula, which mentions no angles at all: with sides $x,y,z$ and semiperimeter $s=(x+y+z)/2$,
$$\text{area}^2=s(s-x)(s-y)(s-z).$$
On the $3,4,5$ triangle, $s=6$ and area$^2=6\cdot3\cdot2\cdot1=36$, so the area is $6$, which is right. Heron matters here for exactly one reason: the data are an area and a fact about sides, the objective is a side, and Heron is the only tool in the list that connects area to sides with nothing else in between.

**The equilateral case.** Tao calls it "a standard matter to compute" and shows no work; here it is, since the special case $d=0$ turns on it. Drop a perpendicular from the apex of an equilateral triangle of side $b$; by symmetry it bisects the base, so the height is $\sqrt{b^2-(b/2)^2}=\tfrac{\sqrt3}{2}b$ and the area is $\tfrac{\sqrt3}{4}b^2$. Setting that equal to $t$,
$$\frac{\sqrt3}{4}b^2=t\ \Longrightarrow\ b^2=\frac{4t}{\sqrt3}\ \Longrightarrow\ b=\frac{2\sqrt t}{3^{1/4}},$$
which is the $b=2t^{1/2}/3^{1/4}$ he quotes. The fourth root appears because $\sqrt{1/\sqrt3}=3^{-1/4}$ — a square root of a square root — and that single observation is the entire content of the prediction he draws from it.

**The triangle inequality.** No side exceeds the sum of the other two. For $1,2,10$ there is no triangle, since the two short sides cannot reach across.

**Two logical idioms.** *Without loss of generality*: the case being excluded is the same as one being kept, by relabelling or symmetry, so excluding it costs nothing — here $d\ge0$, since a progression with difference $-d$ is the same three numbers read backwards. *Contrapositive*: "if $P$ then $Q$" is the same statement as "if not $Q$ then not $P$", and sometimes the second is far easier to prove.

**Degenerate case.** A configuration that has collapsed: a triangle of zero area, a circle of zero radius. Cheap to check, and usually marking the boundary of a formula's validity.

**For the Preface example only.** The *perpendicular bisector* of $AB$ is the line through its midpoint at right angles to it. Lines are *concurrent* if all pass through one point. Triangles are *congruent* if one lies exactly on the other; the cheapest test, and the one the Preface uses, is **SAS** — two sides and the angle between them. The *circumcentre* is the centre of the unique circle through all three vertices.

---

## The frame: what a problem is, and what counts as a good answer

Before any of the strategies, the two prefaces install a disposition, and it silently governs every later decision.

The first-edition preface opens with Proclus on mathematics — she "reminds you of the invisible forms of the soul", she "awakens the mind and purifies the intellect" — and then punctures him with a paragraph of one line:

> "But I just like mathematics because it is fun."

That is not ornament. Someone who enjoys the searching will cheerfully run twenty experiments that fail, which is precisely what pp. 4–6 consist of. If only the answer is rewarding then the dead ends are waste; if the process is rewarding then they are the work.

Why puzzles at all? The answer is an analogy: mathematical problems are important to real mathematics "just as fables, stories, and anecdotes are important to the young in understanding real life." A puzzle is a fable — artificially clean, pointed, and rehearsing a manoeuvre one will later need somewhere messier. Tao calls such problems 'sanitized' mathematics, "where an elegant solution has already been found (by someone else, of course), the question is stripped of all superfluousness and posed in an interesting and (hopefully) thought-provoking way."

Then the image the whole book runs on. If mathematics is likened to prospecting for gold, solving a good problem is akin to a 'hide-and-seek' course in gold-prospecting:

> "you are given a nugget to find, and you know what it looks like, that it is out there somewhere, that it is not too hard to reach, that it is unearthing within your capabilities, and you have conveniently been given the right equipment (i.e. data) to get it. It may be hidden in a cunning place, but it will require ingenuity rather than digging to reach it."

Count the guarantees packed into that sentence, because each one licenses abandoning an approach that violates it. The nugget exists. One would recognise it. It is not too far down. One is personally strong enough to lift it. And the equipment is *right* — which is to say every hypothesis is there because it is needed. So unused data is evidence of a wrong or incomplete solution, and conversely a formula that consumes all the data at once is a promising formula. Tao cashes this in on p. 6 in so many words: Heron's formula "involves $d$ and $t$—in essence, it uses all our data."

He is precise about what can and cannot be taught. "Two of the main weapons—experience and knowledge—are not easy to put into a book: they have to be acquired over time." What remains are the cheaper tricks, of which he names two kinds: "There are ways of looking at a problem that make it easier to find a feasible attack plan. There are systematic ways of reducing a problem into successively simpler sub-problems." The first four strategies below are the first kind, re-framing before one computes; the perturbation strategies are the second. It is worth knowing which one is being reached for.

And then the clause on which everything turns: "solving the problem is not everything." It licenses the otherwise astonishing move of rejecting a *correct* solution. Strip-mining the neighbourhood with bulldozers, he says, "is clumsier than doing a careful survey, a bit of geology, and a small amount of digging." A correct answer arrived at by bulldozer is still the wrong answer to have. Hence the rubric: a solution "should be relatively short, understandable, and hopefully have a touch of elegance. It should also be fun to discover." Two of those four criteria are about the reader and the solver rather than about logical validity, and that is the point. For anyone trained to think *it passes the tests, ship it*, this is the most alien idea in the chapter and the one that travels furthest.

**Housekeeping that tells one how to calibrate.** Unstarred problems are the baseline. Starred problems $(*)$ "indicate an additional level of difficulty, either because some higher mathematics or some clever thinking are required"; double-starred $(**)$ are "similar, but to a greater degree." Some problems carry additional exercises at the end "that can be solved in a similar manner or involve a similar piece of mathematics" — so an exercise sits deliberately within transfer distance of the problem it follows, and the intended move is to reuse the technique one has just watched rather than to invent a new one.

**Why the book was not rewritten.** The second-edition preface is written by the professional about the fifteen-year-old, and it is the only place Tao steps outside the problem-solving frame to say what frame he is in. He lists five stages of a mathematical life: the formal beauty of manipulation in primary school; mathematics "as a sport" in high school, "searching for the right 'trick' that would unlock each one"; the deep structures glimpsed as an undergraduate; the pride of one's own research project as a graduate student; and at last seeing that even very complex and deep results "are often at heart be guided by very simple, even common-sensical, principles." The book is written wholly from the second stage, which is why the method is a hunt for a single unlocking move and why 'sanitized' problems are the right material for it.

He declines to modernise it, because his younger self "was almost certainly more attuned to the world of the high-school problem solver" than he now is. That is a striking editorial choice — preserving a less expert text precisely because it is nearer the reader's state. A solution written by someone who does not yet know the slick answer has exactly the value of showing a search rather than a result.

And the rule that follows. Several of the problems "could be handled more quickly and cleanly by more 'high-tech' mathematical tools; but the point of this text is not to present the slickest solution… but rather to show how one approaches a mathematical problem for the first time." So when one spots a heavyweight theorem that would flatten a problem in a line, note it, and then solve the problem the elementary way regardless. The elementary route is where the transferable technique lives.

### Chaining obvious facts: the perpendicular bisectors

The Preface's worked example is not part of the chapter's framework, but it is a technique demonstration, and the best one in the book.

> **Show that the perpendicular bisectors of a triangle are concurrent.**

Tao calls this "this neat little one-liner", and the shortness of the *statement* is being used as evidence about the expected shortness of the *solution*. He invites the reader to attack it by coordinate geometry — assign coordinates, write down three line equations, intersect two and substitute into the third — with the instruction to "try to do so for a few minutes (hours?), then look at this solution". The parenthetical is doing real teaching: brute force here is not merely slower, it is slower by an order of magnitude, and one cannot tell that from the outside without trying.

The proof chains two facts, each individually obvious. A point on the perpendicular bisector of $AB$ is equidistant from $A$ and $B$. Let $P$ be the point where the bisectors of $AB$ and $AC$ meet — two non-parallel lines always meet, so $P$ exists — and the fact gives $|AP|=|PB|$ from the first bisector and $|AP|=|PC|$ from the second. Transitivity, which is pure logic and no geometry, gives $|BP|=|PC|$. And the same fact read backwards says a point equidistant from $B$ and $C$ lies on the perpendicular bisector of $BC$. So $P$ is on the third bisector, and all three pass through it.

The move that makes it work is the reformulation of "lies on the perpendicular bisector" into "is equidistant from the endpoints". Membership of a line is an awkward thing to manipulate; equality of two lengths is trivial to manipulate, because equality is transitive. Note also the second structural trick, easy to miss: one does not prove that three lines coincide. One defines $P$ as the meeting point of two of them and *deduces* the third — reducing three conditions to two plus a derivation. The figure on p. ix encodes this by deliberately omitting the bisector of $BC$; a diagram showing three concurrent lines would be assuming the conclusion.

Having finished, he adds a second and smaller figure for the sub-fact — the segment $AB$, a point $P$ above the midpoint $M$, a right angle marked at $M$, tick marks showing the two halves equal — and remarks that "congruent triangles will pull it off nicely", naming the tool without writing the argument out. Two right triangles share the leg $PM$, have $|AM|=|MB|$, and have equal right angles at $M$; that is SAS, so they are congruent, so $|AP|=|PB|$. The technique, worth naming: when a step of a proof needs its own proof, isolate it in its own minimal picture with everything else deleted. And note the judgement about which steps deserve the reader's page-space — the same judgement one is asked to make about one's own scratch paper two strategies later.

A free by-product, in passing: $P$ is equidistant from all three vertices, so it is the circumcentre. Small results are worth recording, which is itself a strategy further down.

His summary is the sentence the preface is built to reach: "This kind of solution—and the strange way that obvious facts mesh to form a not-so-obvious fact—is part of the beauty of mathematics."

---

## The specimen

Chapter 1 opens against Lao Tzu, and agrees with half of him. "Like and unlike the proverb above, the solution to a problem begins (and continues, and ends) with simple, logical steps." Every step of a finished proof is elementary; there is never a step that is a leap. What he rejects is the implied count: "as long as one steps in a firm, clear direction, with long strides and sharp vision, one would need far, far less than the millions of steps needed to journey a thousand miles."

Three separate assets are named there, and they are not the same thing — **direction** (one knows which way the answer lies), **stride length** (each step covers real ground, invoking a theorem rather than re-deriving it), and **vision** (one can see far enough ahead to know the direction is still right, which is the look-ahead strategy appearing in the chapter's first paragraph). Being stuck is usually the failure of exactly one of the three, and it is worth asking which.

Then the observation the rest of the chapter depends on: "mathematics, being abstract, has no physical constraints; one can always restart from scratch, try new avenues of attack, or backtrack at an instant's notice. One does not always have these luxuries in other forms of problem-solving (e.g. trying to go home if you are lost)." Since an abandoned attempt costs nothing but time, the sensible strategy is to launch speculative attempts early and kill them quickly — which is why what follows is a catalogue of deliberate perturbations, most of which are expected to fail. He does not oversell it: "Of course, this does not necessarily make it easy; if it was easy, then this book would be substantially shorter. But it makes it possible."

He names his source and declines to claim completeness — "(Polya 1957) is a classic reference for many of these. Some of these strategies are discussed below" — and announces the format in advance: one problem, every strategy demonstrated upon it. So when a strategy yields nothing on the triangle, that is the format working as designed, not the author running out of ideas.

> **Problem 1.1.** A triangle has its lengths in an arithmetic progression, with difference $d$. The area of the triangle is $t$. Find the lengths and angles of the triangle.

Notice what the statement does not say. It does not say the sides are $a,a+d,a+2d$; it does not say $d\ge0$; it does not say where the triangle is, nor promise that a solution exists or is unique. Every one of those becomes a decision to be made explicitly over the next six pages, and watching the decisions get made is most of the value of the chapter.

---

## Understand the problem

What kind of problem is it? There are three main types, and the type matters "because it determines the basic method of approach."

'Show that…' or 'Evaluate…' questions, in which a statement has to be proved true or an expression worked out, are generally the most tractable, because there is a clearly visible objective that can be deliberately approached: one may push forward from the data and pull backward from the goal and hope to meet somewhere in the middle. 'Find a…' or 'Find all…' questions, which require one to find something (or everything) satisfying certain requirements, are more hit-and-miss; generally one has to guess an answer that nearly works and then tweak it, or else alter the requirements so that they become easier to satisfy. 'Is there a…' questions are typically the hardest, because one must first decide whether the object exists before one can even choose a proof style, and getting that gamble wrong costs the whole attempt. Of course not all questions fall into these neat categories, but the general format of any question will still indicate the basic strategy to pursue.

The clearest statement of the idea is not mathematical at all. Take the problem of finding a hotel in this city to sleep in for the night. As posed it is unmanageable. Alter the requirements to something concrete and checkable — a vacant hotel within five kilometres with a room costing less than \$100 a night — and one can then use pure elimination, enumerating candidates and filtering. That is better than trying to prove such a hotel does or does not exist, which converts an already awkward question into the hardest type; and it is probably better than picking a handy hotel and trying to prove one can sleep in it. The transferable point is that **one may choose which type of problem to solve.** Reformulating a search into a decidable filter is a strategic act, not a cosmetic one.

Applied to Problem 1.1: this is an 'Evaluate…' problem, several unknowns to be found in terms of given variables. The first conclusion is drawn purely from that classification, before any geometry is touched — it "suggests an algebraic solution rather than a geometric one, with a lot of equations connecting $d$, $t$, and the sides and angles of the triangle, and eventually solving for our unknowns." That single judgement determines the shape of the next six pages.

## Understand the data

What is given? Usually a question talks about a number of objects which satisfy some special requirements, so the data always splits into two lists — the objects, and the requirements they satisfy. And then the part that is easy to skip past: "one needs to see how the objects and requirements react to each other." Not merely what one has, but how the pieces interact. The payoff is double, and Tao names both halves: it focuses attention on the proper techniques, and on the proper notation.

Here the data are a triangle, its area, and the fact that the sides are in arithmetic progression with separation $d$. The consequences are read off almost mechanically. Because we have a triangle and are considering the sides and area of it, we would need theorems relating sides, angles, and areas — so: the sine rule, the cosine rule, the area formulas. This is retrieval by keyword; the nouns present are {sides, angles, area}, so fetch every theorem whose statement mentions them. And we are dealing with an arithmetic progression, so we would need some notation to account for that; for example, the side lengths could be $a$, $a+d$, and $a+2d$. Observe what has just happened: a piece of *data* has generated a *notational* requirement, which is why notation is the next strategy but one.

The transferable version. List the nouns and fetch the theorems that mention them; then, for each unusual structural hypothesis, look for a parameterisation that makes the hypothesis automatic. The second half is the powerful one. Writing the sides as $a,a+d,a+2d$ means the arithmetic-progression hypothesis can never be violated and never has to be checked again — it has been absorbed into the notation, in the same way one would rather encode an invariant in a type than assert it at runtime.

## Understand the objective

The flip side of understanding the data. Data tells one what may be pushed forward from; the objective tells one what may be pulled back from. One may need "to find an object, prove a statement, determine the existence of an object with special properties, or whatever" — four kinds and an explicit escape hatch, mirroring the three problem types from the other end. The mirroring is the point: the first strategy classifies the question, this one classifies the deliverable, and the two ought to agree. If the question looks like 'Show that…' and the deliverable is an object, one of the two has been misread.

Knowing the objective helps focus attention on the best weapons to use, and it also "helps in creating tactical goals which we know will bring us closer to solving the question." Here the objective is to find all the sides and angles of the triangle. Two consequences: we shall need theorems about sides and angles, which agrees with what the data analysis said and is worth treating as confirmation; and the tactical goal becomes **find equations involving the sides and angles of the triangle.**

That is the useful part, because it is a target one can act on immediately. One cannot find the angles by an act of will, but one can certainly write down equations. And by p. 6 the tactical goal has been sharpened all the way down to a single scalar: solve for $b$.

## Select good notation

Now that we have our data and objective, we must represent them in an efficient way, so that both are expressed as simply as possible. This usually involves the thoughts of the past two strategies — which is why notation comes fourth and not first.

Watch the refinements, each with its reason. One could choose the sides to be $a$, $b$, $c$ and the angles $\alpha,\beta,\gamma$: six symbols and no structure. But we can use the data to simplify the notation — the sides are in arithmetic progression, so instead of $a,b,c$ we can have $a$, $a+d$, $a+2d$. Three symbols have become one, and the hypothesis is now unfalsifiable by construction. But the notation can be even better if we make it more symmetrical, by making the side lengths $b-d$, $b$, and $b+d$. The same triples, now centred — and this is the pivotal move of the entire solution.

There is a slight drawback, in that $b$ is forced to be larger than $d$; we shall come back to it in a moment. And one could trim further by labelling the angles $\alpha$, $\beta$, and $180^\circ-\alpha-\beta$, eliminating a symbol via the angle sum — "but this is ugly and unsymmetrical—it is probably better to keep the old notation, but bearing in mind that $\alpha+\beta+\gamma=180^\circ$."

Why does the symmetric choice matter so much? Because symmetric notation makes symmetric structure visible. With $a,a+d,a+2d$ the semiperimeter is $(3a+3d)/2$; with $b-d,b,b+d$ the two $\pm d$ terms cancel and the semiperimeter is exactly $3b/2$ — and that cancellation is the entire reason Heron's formula becomes tractable two pages later. The worse notation would not have been *wrong*. It would merely have hidden the opportunity. Notation is not bookkeeping; it is where the first real insight of a problem gets encoded.

Note too the failure mode that the rejected trimming illustrates. Minimality and symmetry can conflict, and fewer symbols is not automatically better: dropping $\gamma$ reduces the symbol count but destroys the symmetry among the three angles, so every subsequent formula would have to treat one angle as a special case. The resolution is the professional one — keep the redundant symbol, and carry the relation between them as a remembered side-constraint.

**A drawback that is really data.** The constraint $b>d$ looks like a wart, and the reaction to it is the small lesson of the page: "on further thought, we see that this is actually not a restriction; in fact the knowledge that $b>d$ is an extra piece of data for us." When a representation seems to impose a condition, ask whether the condition was true anyway. Here the side lengths must be positive, so $b-d>0$ regardless; nothing has been lost, and a hypothesis one did not know one had is now written down where it can be used. It closes the problem three pages later, when two roots must be told apart and only one gives a positive $b$.

(A small inconsistency in the book, worth noticing rather than worrying about: the prose on p. 3 says $b$ is forced to be larger than $d$ and writes $b>d$, while the fact-dump on the same page writes $b\ge d$. Since $b=d$ would give a side of length zero, which is not a triangle, the strict inequality is the true one — and the triangle inequality supersedes both with $b\ge2d$ a few lines later anyway. A strict-versus-non-strict slip costs nothing in an exploratory dump and would be a real error in a final answer. Exploration and write-up have different standards of care.)

## Write down what you know in the notation selected; draw a diagram

Putting everything down on paper helps in three ways:

> "(a) you have an easy reference later on; (b) the paper is a good thing to stare at when you are stuck; (c) the physical act of writing down of what you know can trigger new inspirations and connections."

The first is bookkeeping. The second is about the state one will actually be in — stuck, and needing an external memory to scan rather than an internal one to thrash. The third is the interesting claim: that translation is *generative*. Rewriting the sine rule in the new notation forces one to look at the expression $(b-d)/\sin\alpha$, and an expression one has looked at is an expression whose structure one can notice.

Be careful, though, of writing superfluous material, and do not overload your paper with minutiae; an undifferentiated wall of true facts is as useless as a blank page. One compromise is to highlight those facts which you think will be most useful, and to put the more questionable, redundant, or crazy ideas in another part of your scratch paper. Two-tier note-taking: a working set and a spillover area. Nothing speculative is ever thrown away, but it is not allowed to clutter the thing one is staring at.

Here are some equations and inequalities one can extract from the example question:

| Fact | In symbols |
|---|---|
| physical constraints | $\alpha,\beta,\gamma,t>0$, and $b\ge d$; we can also assume $d\ge0$ without loss of generality |
| sum of angles in a triangle | $\alpha+\beta+\gamma=180^\circ$ |
| sine rule | $\dfrac{b-d}{\sin\alpha}=\dfrac{b}{\sin\beta}=\dfrac{b+d}{\sin\gamma}$ |
| cosine rule | $b^2=(b-d)^2+(b+d)^2-2(b-d)(b+d)\cos\beta$, etc. |
| area formula | $t=\tfrac12(b-d)b\sin\gamma=\tfrac12(b-d)(b+d)\sin\beta=\tfrac12 b(b+d)\sin\alpha$ |
| Heron's formula | $t^2=s(s-b+d)(s-b)(s-b-d)$, where $s=\big((b-d)+b+(b+d)\big)/2$ is the semiperimeter |
| triangle inequality | $b+d\le b+(b-d)$ |

Two things there are left implicit and are worth pausing on. The sine-rule and area-formula lines each pack three equations into one, purely by exploiting the symmetric notation — the payoff from the previous strategy, visible on the page. And the last line quietly upgrades $b\ge d$ to $b\ge 2d$, which is exactly the condition making $b^2-4d^2\ge0$, i.e. the condition making the area in the final formula real. The geometry and the algebra agree, and that is a free consistency check.

**Triage.** This is the highest-value half-page in the chapter, because it shows the reasoning by which a mass of true statements is reduced to a single line of attack. "Many of these facts may prove to be useless or distracting. But we can use some judgement to separate the valuable facts from the unhelpful ones."

Two criteria are given, and a third arrives later. First, match the logical form of the tools to the logical form of the goal: "the equalities are likely to be more useful than the inequalities, since our objective and data come in the form of equalities." An inequality can bound an answer; only an equality can pin it down. So the triangle inequality and the positivity constraints are demoted to a background role — they will be used at the very end, and only to select a root. Second, prefer the tool that the notation has already simplified: "Heron's formula looks especially promising, because the semiperimeter simplifies to $s=3b/2$." Check it — $s=\frac{(b-d)+b+(b+d)}{2}=\frac{3b}{2}$, the $d$'s cancelling exactly. A four-factor product that looked forbidding has just lost its ugliest ingredient. After choosing notation it is always worth re-scanning the candidate formulas for the ones that collapsed; collapse is the signal that a formula and a problem are aligned. And third, the gold-nugget premise in operational form: prefer the tool that consumes all the data. A formula touching every hypothesis could plausibly be the whole solution; a formula touching half of them cannot be.

**And the diagram.** One draws it — a scalene triangle, the apex angle $\gamma$ opposite the base $b+d$, the angles $\beta$ and $\alpha$ at the base, the left side $b-d$ and the right side $b$, with the area $t$ marked inside:

```
            /\  γ
      b-d  /  \
          /    \  b
         /  area \
        /    t    \
    β  /___________\  α
           b + d
```

And here it does not earn its keep. Drawing a picture "is often quite helpful for geometry questions, though in this case the picture does not seem to add much." The reason is visible once stated: the picture displays only relationships already captured by the labels. There are no auxiliary points, no hidden circle, no congruent sub-triangles to spot, so its information content beyond the algebra is nil.

That sentence is worth as much as any technique in the chapter. A standard move was applied, it produced nothing, and the nothing is *reported*. Most write-ups delete the moves that failed, which is exactly what makes them useless as models of how the work is done. The lesson is not "always draw a diagram" — it is "always try, and be able to tell whether it paid." Compare the Preface, where the picture, and especially the reduced picture, was doing all the work.

## Modify the problem slightly

If one cannot even get started on a problem, one perturbs it. There are many ways to vary a problem into one which may be easier to deal with, and this is the one strategy in the chapter with an explicit menu — when stuck, one works down the list:

| | Sub-move | In practice |
|---|---|---|
| (a) | Consider a special case, such as extreme or degenerate cases | Set a parameter to $0$, $1$, or $\infty$; take the smallest $n$; collapse the shape |
| (b) | Solve a simplified version | Drop a complication — fewer variables, integers instead of reals, a square instead of a general quadrilateral |
| (c) | Formulate a conjecture which would imply the problem, and prove that first | Deliberately prove something *stronger*; a stronger statement often has more structure to grip, and induction in particular frequently only works once strengthened |
| (d) | Derive some consequence of the problem, and prove that first | Prove something *weaker*; it does not finish the job, but it tests whether the statement is even true and often exposes the mechanism |
| (e) | Reformulate the problem | Take the contrapositive, argue by contradiction, try a substitution — same content, a different surface, and the new surface may be manipulable where the old one was not |
| (f) | Examine solutions of similar problems | Pattern-match against one's library; this is where the Preface's "experience and knowledge" cash in |
| (g) | Generalize the problem | Introduce a parameter $n$ where there was a specific number; sometimes the general case is *easier*, the special one having hidden the pattern under coincidences |

Note that (c) and (g) point one way and (b) and (d) point the other — strengthen against weaken. Both directions are on the list deliberately, because one does not know in advance which has the traction.

There is a dosage rule attached, and it is stated at length because it matters: "be warned that special cases are, by their nature, special, and some elegant technique could conceivably apply to them and yet have absolutely no utility in solving the general case. This tends to happen when the special case is *too* special. Start with modest assumptions first, because then you are sticking as closely as possible to the spirit of the problem." Perturb by the smallest amount that changes something. A special case that trivialises the problem teaches one nothing about the problem, only about the trivialisation — the mathematical equivalent of a test case so degenerate that the wrong algorithm passes it.

In Problem 1.1 we can try a special case such as $d=0$. In this case we need to find the side length of an equilateral triangle of area $t$, and it is a standard matter to compute the answer, which is $b=2t^{1/2}/3^{1/4}$. What does that buy? Not a method — the equilateral computation uses a formula that does not generalise. It "indicates that the general answer should also involve square roots or fourth roots, but does not otherwise suggest how to go about the problem." One has learnt the *shape* of the answer and nothing else, which is still worth the thirty seconds it cost, and which will serve at the end as a check. Consideration of similar problems draws little as well, "except one gets further evidence that a gung-ho algebraic attack is what is needed."

That is a partial success, and the precision about *how* partial is the teachable part. No method; a prediction about the form of the answer, which in turn hints that a quadratic — or a quadratic in a square — is lurking; and a test case to be used on p. 7.

One case Tao does not run, and it is free: the genuinely *degenerate* choice $t=0$, a triangle of zero area. Put $t=0$ into the final equation $3b^4-12d^2b^2=0$ and one gets $b^2=4d^2$, so $b=2d$ and the sides are $d,2d,3d$ — precisely the equality case of the triangle inequality, a flattened triangle. So the degenerate case recovers the boundary constraint $b\ge2d$ as the $t=0$ end of the answer. It is exactly the kind of free confirmation the chapter is trying to train one to look for.

## Modify the problem significantly

In this more aggressive type of strategy, we perform major modifications to a problem such as removing data, swapping the data with the objective, or negating the objective — trying to disprove a statement rather than prove it. "Basically, we try to push the problem until it breaks, and then try to identify where the breakdown occurred; this identifies what the key components of the data are, as well as where the main difficulty will lie." These exercises also help in getting an instinctive feel for which strategies are likely to work and which are likely to fail.

Watch how much this yields on a problem where it is not even the main line of attack.

One could replace the triangle with a quadrilateral, circle, and so forth. Not much help there: the problem just gets more complicated. Generalising the shape adds degrees of freedom without adding structure. But on the other hand, one can see that one does not really need a triangle in the question, but just the *dimensions* of the triangle — we do not really need to know the position of the triangle. So here is further confirmation that we should concentrate on the sides and angles and not on coordinate geometry or similar approaches. Notice the form of that argument: one asks what information the answer cannot possibly depend on, and concludes that any method carrying that information is doing wasted work. If a method tracks quantities the answer cannot depend on, the method is too heavy. This is the Preface's complaint about coordinate geometry, now derived rather than asserted — and it is the third independent vote for algebra.

We could omit some objectives. Instead of working out all the sides and angles we could work out just the sides; but then one can notice that by the cosine and sine rules, the angles of the triangle will be determined anyway. So it is only necessary to solve for the sides — and we know the sides have lengths $b-d$, $b$, and $b+d$, so we only need to find what $b$ is to finish the problem. Six unknowns have become one, and this happened by *deleting* things rather than by any cleverness. Two compressions are stacked here: the cosine rule, rearranged as $\cos C=\frac{a^2+b^2-c^2}{2ab}$, is a function from three sides to three angles, so the angles were never independent unknowns; and the symmetric notation had already made the three sides one unknown. Before solving for $n$ unknowns, it is worth checking how many are genuinely free.

We can also omit data. Omit the arithmetic difference $d$ and we seem to have several possible solutions, and not enough data to solve the problem — true, since infinitely many triangles have area $t$. Similarly, omitting the area $t$ will not leave enough data to clinch a solution, since any valid triangle can be scaled to give another with the same progression structure and a different area. Both hypotheses are therefore load-bearing; there is no fat to trim, and any correct solution must use both. This is precisely *why* Heron's formula is trusted on the next page — it is the formula that touches both.

Sometimes one can *partially* omit data, for instance by only specifying that the area is larger or smaller than some threshold $t_0$; but this is getting complicated. Stick with the simple options first. A datum need not be deleted wholesale — it can be weakened from an equation to an inequality — but the cheap experiments come before the expensive ones.

Reversal of the problem, swapping data with objective, leads to some interesting ideas though. Suppose you had a triangle with arithmetic difference $d$, and you wanted to shrink it (or whatever) until the area becomes $t$. One could imagine the triangle shrinking and deforming while preserving the arithmetic difference of the sides. Similarly, one could consider all triangles with a fixed area, and mould the triangle into one with the sides in the correct arithmetic progression. What has been invented, in effect, is a continuity argument — instead of solving equations, move through the space of triangles holding one constraint fixed until the other is met, the unstated engine being the intermediate value theorem. That is a genuinely different proof style, topological rather than algebraic, and it would give existence and uniqueness rather than a formula.

And then the honest sentence: "These ideas could work in the long run: but I will solve this question by another approach." A promising direction is identified, credited, and not taken. He adds the reason it costs nothing to leave it there: "Do not forget, though, that a question can be solved in more than one way, and no particular way can really be judged the absolute best."

Negating the objective is on the list of major modifications but has no purchase on an 'Evaluate…' problem, where there is no statement to disbelieve. It will matter later in the book. The idea is worth stating anyway: spend a serious effort trying to build a counterexample, and either one is found — in which case the question was the wrong way round — or the failed attempts show precisely which obstruction blocks every counterexample, and that obstruction is usually the proof.

## Prove results about our question

"Data is there to be used, so one should pick up the data and play with it. Can it produce more meaningful data?" Proving small results could be beneficial later on, when trying to prove the main result or to find the answer. However small the result, do not forget it — it could have bearing later on. And, decisively for a reader who is stuck: "Besides, it gives you something to do if you are stuck." That last sentence is not a joke. Having a mechanical, guaranteed-to-produce-something activity is what keeps one in contact with a problem instead of staring at it, and aimless-but-legal manipulation is a legitimate search strategy, because the space of consequences of one's hypotheses is where the answer lives.

In an 'Evaluate…' problem like the triangle question, this tactic is not as useful. But one can try. The tactical goal is to solve for $b$, which depends on the two parameters $d$ and $t$; in other words, $b$ is really a function: $b=b(d,t)$. If this notation looks out of place in a geometry question, "then that is only because geometry tends to ignore the functional dependence of objects" — Heron's formula, after all, is nothing but an explicit form for the function $A(a,b,c)$. That reframing is worth more than it looks: once $b$ is a function, everything one knows about functions becomes available to ask about it.

Two mini-results follow at once. First, $b(d,t)=b(-d,t)$, because an arithmetic progression has an equivalent arithmetic progression with inverted arithmetic difference — the sides $b-d,b,b+d$ read backwards are the same triangle. So the answer must be an *even* function of $d$, containing only even powers, which is a genuine prediction and a free error check. Second, $b(kd,k^2t)=kb(d,t)$, obtained by dilating the triangle by $k$: every length multiplies by $k$, so $d\mapsto kd$ and $b\mapsto kb$, while area is two-dimensional, so $t\mapsto k^2t$. That is dimensional analysis, and it is the cheapest bug-catcher in mathematics. One could even try differentiating $b$ with respect to $d$ or $t$.

For this particular problem these tactics allow us to perform some normalizations, for instance setting $t=1$ or $d=1$, and they also provide a way to check the final answer. The scaling relation says the two-parameter family of problems is really a one-parameter family: solve the case $t=1$ and every other case follows by dilation. Any exact symmetry of a problem lets one delete a variable.

And then the assessment: "in this problem these tricks turn out to only give minor advantages and we will not use them here." A whole paragraph of legitimate technique, developed and then set aside — except that the checking function does get used, twice, at the end. That is not padding. It is what the search actually looks like, and a chapter showing only the productive moves would be a chapter about a solution rather than about problem solving.

## Simplify, exploit data, and reach tactical goals

Now we have set up notation and have a few equations, we should seriously look at attaining the tactical goals that we have established. Note the three preconditions in that sentence — notation, a few equations, and a stated tactical goal. Start computing before all three exist and one is flailing.

In simple problems there are usually standard ways of doing this; algebraic simplification, for example, is usually discussed thoroughly in high-school level textbooks. Generally this part is the longest and most difficult part of the problem. That remark is more reassuring than it looks: the creative work has already happened, and what remains is craft, which is drilled rather than invented. Being unable to expand Heron's formula and factor a quartic is a fluency gap, closed by practice — not an insight gap, closed by staring.

Two pieces of advice attach, and both are about not getting lost. One can avoid getting lost "if one remembers the relevant theorems, the data and how they can be used, and most importantly the objective" — three things to hold in working memory, with the objective ranked first, because in a long computation the failure mode is not forgetting a theorem (one can look it up) but forgetting what one was trying to produce and simplifying aimlessly. And:

> "It is also a good idea to not apply any given technique or method blindly, but to think ahead and see where one could hope such a technique to take one; this can allow one to save enormous amounts of time by eliminating unprofitable directions of inquiry before sinking lots of effort into them, and conversely to give the most promising directions priority."

Simulate the computation cheaply before performing it expensively. Before expanding Heron's formula, ask what one will be left with if it works — the answer is a polynomial equation in $b$, which is a thing one certainly knows how to solve, so the direction is worth the effort. That prospective check is the difference between purposeful algebra and flailing.

We are already concentrating on Heron's formula, and we have already noted that the sine and cosine rules can determine $\alpha,\beta,\gamma$ once $b$ is known. As further evidence that this is going to be a step forward, note that Heron's formula involves $d$ and $t$ — in essence, it uses all our data, the progression having already been incorporated into the notation. So the plan is fully specified before the algebra starts: Heron gives $b$, the notation gives the other two sides, the sine and cosine rules give the three angles. Nothing after this point is exploratory.

Heron's formula in terms of $d,t,b$ becomes
$$t^2=\frac{3b}{2}\left(\frac{3b}{2}-b+d\right)\left(\frac{3b}{2}-b\right)\left(\frac{3b}{2}-b-d\right),$$
and the three later brackets are $\frac b2+d$, $\frac b2$, and $\frac b2-d$. The first and last multiply by difference of two squares, so this simplifies to
$$t^2=\frac{3b^2(b-2d)(b+2d)}{16}=\frac{3b^2(b^2-4d^2)}{16}.$$

Now we have to solve for $b$. The right-hand side is a polynomial in $b$, treating $d$ and $t$ as constants, and in fact it is a quadratic in $b^2$ — there are no odd powers of $b$ anywhere. That recognition is the last real move in the problem, and it is exactly what the $d=0$ special case predicted when it produced a fourth root. Now quadratics can be solved easily. Clearing denominators and putting everything on the left-hand side,
$$3b^4-12d^2b^2-16t^2=0, \tag{1}$$
so, by the quadratic formula applied to (1) as a quadratic in $b^2$,
$$b^2=\frac{12d^2\pm\sqrt{144d^4+192t^2}}{6}=2d^2\pm\sqrt{4d^4+\frac{16}{3}t^2}.$$
(The second form comes of dividing inside the root by $6^2=36$, since $144/36=4$ and $192/36=16/3$. Two typographical slips are worth flagging here, because a reader checking the algebra against the printed page will trip on them: p. 7 prints the discriminant as $\sqrt{144d^4+196t^2}$, where $B^2-4AC=144d^4+4\cdot3\cdot16\,t^2=144d^4+192t^2$; and it prints $4d^2$ rather than $4d^4$ under the second root. The final displayed answer on the same page is correct.)

Because $b$ has to be positive we take the plus sign — the other root is negative, since $\sqrt{4d^4+\tfrac{16}{3}t^2}>2d^2$ whenever $t>0$ — and here at last the constraint noticed back during *notation selection* pays for itself:
$$b=\sqrt{2d^2+\sqrt{4d^4+\tfrac{16}{3}t^2}}.$$
Once we compute the sides $b-d,\ b,\ b+d$, the evaluation of the angles $\alpha,\beta,\gamma$ then follows from the cosine rule — concretely $\cos\beta=\frac{(b-d)^2+(b+d)^2-b^2}{2(b-d)(b+d)}$, and similarly for the others, with the angle sum as a check — and we are done.

**As a check**, we can verify that when $d=0$ this agrees with our previous computation. At $d=0$, $b=\sqrt{\sqrt{16t^2/3}}=\sqrt{4t/\sqrt3}=2\sqrt t/3^{1/4}$, which is the equilateral answer found earlier. Observe also that the formula contains only $d^2$ and $d^4$ — even in $d$, as the symmetry mini-result predicted — and that it is dimensionally consistent, since $d^4$ and $t^2$ both carry units of length$^4$ and may therefore be added, the inner root gives length$^2$ to match $2d^2$, and the outer root gives a length. Three independent checks, all of them established during the exploration, before there was an answer to check.

**And one should put an actual number through it**, which the chapter never does. Take $d=1$ and $t=6$. Then $4d^4+\tfrac{16}{3}t^2=4+192=196$, so $b^2=2+14=16$ and $b=4$; the sides are $3,4,5$. That triangle really does have sides in arithmetic progression of difference $1$, and its area really is $\tfrac12\cdot3\cdot4=6$. Recovering the angles from the cosine rule: opposite the side $3$, $\cos\alpha=\frac{16+25-9}{40}=0.8$, so $\alpha\approx36.87^\circ$; opposite the side $4$, $\cos\beta=\frac{9+25-16}{30}=0.6$, so $\beta\approx53.13^\circ$; opposite the side $5$, $\cos\gamma=\frac{9+16-25}{24}=0$, so $\gamma=90^\circ$ — Pythagoras falling out of the cosine rule, as it must. The angles sum to $180^\circ$, and $b=4\ge2d=2$. One case, two minutes, and every tool in the fact-dump has been exercised at once; an algebra slip anywhere in the six pages would have shown up here.

---

## Exercises one can set oneself

Chapter 1 has no exercises, and Problem 1.1 has none attached — the first-edition preface says *some* problems have additional exercises, not all, and the chapter is pure methodology plus one specimen. But each of the following is a strategy from the chapter applied to the chapter's own problem, and each is cheap.

1. Run the degenerate case $t=0$ on the final formula and check that $b=2d$, giving sides $d,2d,3d$ — the flattened triangle at the equality case of the triangle inequality.
2. Verify by inspection that the answer is even in $d$, and confirm that this rules out any candidate answer containing a bare $d$ or a $d^3$.
3. Cash the scaling law. Set $t=1$, solve for $b(d,1)=\sqrt{2d^2+\sqrt{4d^4+16/3}}$, then recover the general formula from $b(d,t)=\sqrt t\,b(d/\sqrt t,1)$ — take $k=\sqrt t$ in $b(kd,k^2t)=kb(d,t)$ — and confirm Tao's answer comes back. This is the normalization he mentions and declines to use.
4. Try $d=2$, $t=6$: one should get $b^2=8+\sqrt{64+192}=24$, so $b=2\sqrt6\approx4.899$ and sides about $2.899,\ 4.899,\ 6.899$. Check that $b\ge 2d=4$ still holds.
5. Carry out the reversal he left on the table. Fix $d$, let $b$ range over $[2d,\infty)$, note that the area $\tfrac14 b\sqrt{3(b^2-4d^2)}$ is continuous, vanishes at $b=2d$, and increases without bound, and apply the intermediate value theorem to prove existence and uniqueness. Then compare the two proofs: one yields a formula, the other yields existence and uniqueness. Which is the better answer by the rubric on p. ix?
6. Do the coordinate-geometry proof of the perpendicular-bisector theorem, and time yourself. Then re-read the four-line proof. The point of this exercise is the felt difference, not the result.

---

## The moral

The chapter demonstrates nine strategies on one problem, and it is worth counting what they actually produced. The diagram added nothing. The special case gave the shape of the answer and no method. Similar problems gave nothing beyond a vague encouragement to be gung-ho. The quadrilateral gave nothing. Differentiation was raised and dropped. Normalization was available and unused. The reversal was interesting and was not taken. What solved the problem was a symmetric choice of notation made on p. 3, which collapsed a semiperimeter, which made one formula out of seven tractable.

That ratio is the lesson rather than an embarrassment to be tidied away. One cannot know in advance which perturbation will be the one that pays, and the only way to find out costs a few minutes each — which is affordable exactly because, as the chapter's first paragraph says, backtracking in mathematics is free. The strategies are cheap lottery tickets bought in bulk, and the discipline is to buy many and discard fast.

Two habits are worth carrying out of the chapter above the rest. The first: the preparation is where the problem is solved. Four lines of algebra were preceded by six pages of setting up, and the six pages are not a preamble to the solution — they *are* the solution, with the algebra as a formality. The second: build the checks before there is anything to check. Evenness in $d$, dimensional consistency, and the $d=0$ case were all established while exploring, and all three were waiting when the formula finally arrived.

And the single most valuable sentence in the chapter is the admission that the picture does not seem to add much — because it is the one sentence that tells the reader what the other twenty minutes looked like.
