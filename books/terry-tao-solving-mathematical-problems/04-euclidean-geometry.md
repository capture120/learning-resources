# Chapter 4: Euclidean geometry

> This is the chapter about **classical, synthetic geometry** — points, lines, triangles, circles, and no coordinates. Every problem in it looks the same from the outside: you are handed a configuration (a triangle in a circle, a rectangle with a line through it, a square cut into five pieces), given one or two scraps of data, and asked to prove something that seems to have nothing to do with them. The transferable content is not the geometry facts; it is the **translation discipline**. Tao's whole chapter is organized around a small set of currencies — angles, lengths, ratios, areas, transformations, degrees of freedom — and the technique is knowing which currency your data is denominated in, which currency your objective is denominated in, and what the exchange rate is. Alongside that sits the chapter's second big theme: the **forward vs. backward** decision (grind the data forwards into something that looks like the goal, versus rewrite the goal backwards into something the data can reach), and its third: **"solve for" your unknown like an algebra variable**, which is how all the construction problems fall. He also makes the case for geometry as a discipline: "the true beauty of geometry is in how a non-obvious looking fact can be shown to be undeniably true by the repeated application of obvious facts" (p. 49). Coordinate geometry is available throughout and Tao treats it as a *last resort* — "a quadratic mess of coordinates, crudely converting geometry into algebra" (p. 49) — which itself is a technique choice worth studying.

**The chapter's epigraph** (p. 49), which the book prints before any mathematics:

> "Archimedes will be remembered when Aeschylus is forgotten, because languages die and mathematical ideas do not."
> — *G.H. Hardy*, 'A Mathematicians Apology'

(That is the book's own rendering of the title; Hardy's 1940 essay is *A Mathematician's Apology*.) Aeschylus was a Greek tragedian, Archimedes a Greek mathematician. Hardy's point — and presumably Tao's reason for putting it here — is that mathematical results are permanent in a way that nothing expressed in a language is. Which is exactly why a theorem Euclid wrote down 2300 years ago (Thales, Euclid III.31) is still a live, load-bearing tool in every problem below.

**Tao's own framing of the chapter** (p. 49), which is worth quoting because it sets up the coordinate-geometry judgement call: "Euclidean geometry was the first branch of mathematics to be treated in anything like the modern fashion (with postulates, definitions, theorems, and so forth); and even now geometry is conducted in a very logical, tightly knit fashion. **There are several basic results which can be used to systematically attack and resolve questions about geometrical objects and ideas. This idea can be taken to extremes with coordinate geometry**, which transforms points, lines, triangles, and circles into a quadratic mess of coordinates, crudely converting geometry into algebra. But the true beauty of geometry is in how a non-obvious looking fact can be shown to be undeniably true by the repeated application of obvious facts."

Two things to notice in that passage that are easy to skim past. (i) The claim is that a *small, fixed* toolkit ("several basic results") is enough to attack the whole subject systematically — which is what makes "inventory your theorems and chain them" a viable default strategy rather than wishful thinking. (ii) Coordinate geometry is not presented as a *different kind* of method; it is the same systematising impulse "taken to extremes". So the choice between synthetic and coordinate geometry is a choice about *how far* to mechanise, not about which subject you are in. That is a much more useful way to hold the distinction than "clever vs. brute force".

Pages covered: pp. 49–68 (chapter opener p. 49; Problems 4.1–4.6; Exercises 4.1–4.4; Theorems 4.1 and 4.2).
Contents: Problem 4.1 (p. 50), Problem 4.2 (p. 52), Problem 4.3\* (p. 55), Problem 4.4 (p. 58), Exercises 4.1–4.2 (p. 61), Exercise 4.3\* (p. 62), Problem 4.5 (p. 62), Exercise 4.4 (p. 66), Problem 4.6 (p. 66). A `(*)` in the book marks a harder problem.

---

## The techniques at a glance

| # | Technique | Trigger — what makes you reach for it | Where Tao uses it in this chapter |
|---|---|---|---|
| 1 | **Chain obvious facts** — a long chain of trivial steps beats one clever step | Any synthetic geometry claim | p. 49, the whole chapter's thesis; Thales' theorem proved from "isosceles ⇒ equal base angles" + "angles sum to 180°" |
| 2 | **Draw a picture, and label everything you can** | Always, first move | p. 50 "The first step, of course, is to draw a picture and label what we can"; p. 59; p. 66 "As always, we begin by drawing a picture" |
| 3 | **Name the unnamed points** — especially intersections and centres | Your objective mentions two objects that cross, or a special point is implicit | p. 50: labels the incentre $I$ ("likely to be important") and $M=AD\cap EF$ |
| 4 | **Convert the objective into an equation** | The goal is stated in words ("is perpendicular", "is a square", "is isosceles") | p. 51: "$AD\perp EF$" becomes "$\angle AMF = 90^\circ$" |
| 5 | **Triage: judge the problem's difficulty from the diagram before choosing a method** | You have a picture | p. 51: "the diagram is easy to draw, the conclusion is quite evident from the figure. With such a problem, a direct approach would probably work quite nicely" |
| 6 | **Angle chasing** — compute everything in angles and never touch a length | No side lengths in the statement; lots of triangles and circles | Problems 4.1, 4.6 |
| 7 | **Pick a reference frame: the "main figure"** and express all quantities in it | The configuration is built up from one basic object | p. 51 ($\alpha,\beta,\gamma$ of triangle $ABC$); p. 52 "It is a logical reference frame"; p. 64 (rectangle $R_1$ as "main figure") |
| 8 | **Flood-fill the easy quantities first**, even without a plan | You have a diagram with many derivable angles | p. 51: "In fact we can get virtually all relevant angles—except those at $M$" |
| 9 | **Express the obscure quantity in terms of the non-obscure ones** | The thing you must compute sits at an "unremarkable" point | p. 51: "we must somehow represent our angle at $M$ in terms of angles that are not related to $M$" |
| 10 | **Angle-sum as an escape hatch**: an unknown angle of a triangle $=180^\circ-$ the other two | An angle you can't reach sits in a triangle with two angles you can | p. 51: $\angle IMF = 180^\circ-\angle AIF-\angle CFE$ |
| 11 | **Cheat the diagram: draw the special case** you're being asked to prove | The data is hard to realize by hand | p. 52: make $ABC$ isosceles or $\angle BAC=60^\circ$ "since we know that is what is supposed to happen anyway" |
| 12 | **Draw several configurations**, not one | The data can be satisfied in genuinely different ways | p. 52: two side-by-side pictures |
| 13 | **Read the objective to decide the currency of the solution** | You don't know whether to work with lengths or angles | p. 52: both alternatives in the conclusion are angle-facts, "so one can assume this to be an angle problem" |
| 14 | **Enumerate the length↔angle exchange rates and eliminate them by suitability** | Data in lengths, objective in angles (or vice versa) | p. 53: basic trig / similar triangles / isosceles & equilateral / sine rule / cosine rule, each screened against the configuration |
| 15 | **Abandon the most obvious translation when it doesn't connect** | Your first rewrite produces quantities that touch nothing else | p. 52: $|OD|=|OE| \Rightarrow \angle ODE=\angle OED$ dropped — "it is quite hard to equate the angles … to any other angles" |
| 16 | **Always look for connections; prefer configurations that share something** | Two quantities are known equal | p. 53: pick triangles $AOE$, $AOD$ because they share side $OA$. "Knowing that two quantities are equal would not help unless you connect them in some way" |
| 17 | **Draw a reduced diagram** — delete everything irrelevant, and rotate/rescale it | The full figure has more points than your current sub-argument needs | p. 53: "why should one have to deal with useless clutter?"; the four-point figure "rotated and blown up for clarity" |
| 18 | **Eliminate the shared unknown** (the geometric analogue of eliminating a variable) | The same quantity appears in both of your equations | p. 54: $|OA|$ appears in both sine-rule chains, so put $|OD|,|OE|$ in terms of it and divide |
| 19 | **Watch out for degenerate cases** and dispose of them separately | You divided by something, or took a ratio | p. 54: "something silly could happen such as $\sin(\alpha/2)=0$ … always remember to watch out for these things" |
| 20 | **Track progress signals**: does the *shape* of your expression now match the goal's shape? | Mid-derivation, needing to know whether to continue | p. 54: "the sines are gone, and we have also for the first time gotten a statement that involves an 'or'" |
| 21 | **Exploit multivaluedness deliberately**: $\sin X=\sin Y \Rightarrow X=Y$ **or** $X=180^\circ-Y$ | Your objective is a disjunction ("either … or …") | p. 54: this single step is what produces the two alternatives |
| 22 | **The direct / forward approach** — hammer the data into something resembling the objective | The objective is a simple relation among easily calculable parts | Named on p. 55; used in Problems 4.1, 4.2 |
| 23 | **The backward approach** — transform the *objective* until the data can reach it | The objective is obscure | Named on p. 55; used in Problem 4.3 |
| 24 | **Draw the figure by peeking at the conclusion** | The hypothesis is hard to satisfy by hand | p. 55: trial and error plus "taking a peek at the conclusion … eventually allows one to draw a decent picture" |
| 25 | **Rank your heavy machinery and hold it in reserve** | You're tempted by brute force | p. 55: coordinate geometry is "long and boring … prone to abysmal complications and huge errors. Let us try that as a last resort"; vector geometry poorly suited to $|DC|=|DG|$ but "neater than the coordinate counterparts" |
| 26 | **Pseudo-coordinate geometry** — drop perpendiculars and use Pythagoras: "coordinate geometry without the axes" | You need brute force but want less mess | p. 58 |
| 27 | **Let the *form* of the objective name the tool** | Three equal ratios; a product of two lengths; an equality of angles | p. 56: equal ratios ⇒ similar triangles; p. 57: $|FC|\times|BC|$ ⇒ power of a point |
| 28 | **Substitute an equal quantity so the object joins a triangle** | The length you want isn't a side of any useful triangle | p. 56: $AB$ is in no useful triangle, but $|FE|=|AB|$ and $FE$ is |
| 29 | **Reformulate the objective into a symmetric form with fewer equalities** | Your goal is a chain of several equalities | p. 56: prove $|FC|/|GA| = |GB|/|BC|$ instead of two other equalities — "more symmetric and involves only one equality" |
| 30 | **Algebraically massage the objective** (cross-multiply, swap ratios) to match a theorem's shape | You're one syntactic step from something recognizable | p. 56: $|FC|/|GA|=|GB|/|BC| \Rightarrow |FC|\times|BC|=|AG|\times|BG|$ |
| 31 | **"Look for things that vaguely trigger a memory"** — recall a specific named theorem | An expression looks *familiar* rather than tractable | p. 57–58: Theorem 4.2 (power of a point) |
| 32 | **Construct the object your theorem needs** | A theorem almost applies but a circle/line is missing | p. 57: build the circle through $F,B,A$; notice by Thales that $D$ is its centre |
| 33 | **Keep an equivalence dictionary** of swaps between statement types | Any stuck proof | p. 58: $\angle ABC=\angle ADC \Leftrightarrow ABDC$ cyclic; $|AB|>|AC| \Leftrightarrow \angle ACB>\angle ABC$; area facts |
| 34 | **Do NOT spam constructions** | You're tempted to draw every auxiliary line | p. 58: "This does not mean that you should construct every possible extension … (unless you are really stuck)" |
| 35 | **Test special / extreme / degenerate cases to suggest the way** | You're stuck and have a free parameter | p. 58: consider $ABEF$ square, $ABEF$ degenerate, $|DC|=|DG|=0$ |
| 36 | **Every piece of data must be invoked — steer towards the unusual data** | You have an odd-looking hypothesis you haven't used | p. 58: "each piece of data must be invoked in some way"; here the strange $DC=DG$ |
| 37 | **Constructions: "solve for" the unknown, like algebra** | Straightedge-and-compass problems | p. 61: "the idea is to 'solve for' one's unknowns … just like in algebra" |
| 38 | **Determine a locus** for the unknown | Construction problems | p. 59: "the standard way to solve construction questions is to take one of the unknowns … and determine a locus or other easily constructible property" |
| 39 | **Use the problem's own freedom to spend a degree of freedom for free** | The configuration can be slid/scaled/rotated without breaking any condition | p. 59: the triangle slides along the parallels, so put $A$ anywhere on $l_1$ — and then $l_1$ is no longer needed |
| 40 | **Count degrees of freedom against anchors (constraints)** | You need to know whether the problem is even determined | p. 59: triangle has 2 d.o.f. (orientation, size) and 2 anchors ($B\in l_2$, $C\in l_3$) |
| 41 | **Shift the unknown to a simpler unknown** — ideally a single point | The unknown object is complicated | p. 59: "The simplest geometrical object is a point. So, we could work out $B$ … instead of the entire triangle" |
| 42 | **Replace a relation by a transformation** (rotation / reflection / translation) | Two points are rigidly related | p. 60: $C$ is the image of $B$ under a $60^\circ$ rotation about $A$ |
| 43 | **Invert the condition so the unknown is the subject** | A condition reads "the image of my unknown lies on $X$" | p. 60: (b) "the rotation of $B$ lies on $l_3$" → (b′) "$B$ lies on the inverse rotation of $l_3$"; then intersect the two loci |
| 44 | **Eliminate variables one at a time** | A system with several unknowns | p. 61: the little algebra analogy with $b+1$ even, $bc=48$, $c$ a power of 2 |
| 45 | **Audit what you didn't use — spot the red herring** | The solution never touched one of the hypotheses | p. 61: "the parallelism was in fact a red herring!" |
| 46 | **Qualitative exploration: try to break the configuration to see why it is rigid** | You suspect a hypothesis over- or under-determines the answer | p. 63: "wriggling" the five rectangles; the figure of what goes wrong |
| 47 | **Introduce notation / parametrize** | You've exhausted what pictures can tell you | p. 64: "To progress any further, we need notation" — $R_1$ is $a\times b$, square has side 1 |
| 48 | **Name the sledge-hammer, then look for something better** | Brute force is available but ugly | p. 64: the single equation in $a,b$ "works, but is a bit messy algebraically, so let us try for a simpler, more intuitive … approach" |
| 49 | **Isolate an intermediate goal (a stepping stone) and prove the implication chain** | Your objective is about the object that is hardest to parametrize | p. 65: `equal areas ⇒ a+b=1 ⇒ R₀ is a square`; prove the easy link first |
| 50 | **Restate the goal about the object you *can* parametrize** | The goal names an awkward object | p. 64–65: prove something about $R_1$ instead of about $R_0$ |
| 51 | **Go backwards: contrapositive, or proof by contradiction — and know the trade-off** | The data reduces to formulas easily but the formulas don't reduce to the objective | p. 65: "with a proof by contradiction, one has more data to begin with, but the end result is very open-ended and indefinite" |
| 52 | **Match the proof method to your qualitative intuition** | You have a picture-level reason but no formal one | p. 65: contradiction "fits well with our earlier, qualitative approach" |
| 53 | **Inequalities instead of equalities; a monotone chain around a cycle** | Equal products related by additive equations, going nowhere | pp. 65–66: each rectangle strictly more lopsided than the last, so $R_1$ differs from itself. "sometimes inequalities are easier and more efficient to use than equalities" |
| 54 | **A picture is worth a thousand equations** | Any geometry problem | p. 66, explicitly |
| 55 | **Rewrite obscure angles as "friendly"/"mainstream" angles** | Your objective mentions angles that touch nothing | pp. 66–67: $\angle DAF$ and $\angle EAF$ both rewritten in terms of $\angle ABF$ |
| 56 | **Choose between decompositions by which leaves friendlier pieces** | An angle can be split several ways | p. 67: $\angle EAF=\angle BAF-\angle BAE$ vs. $\angle DAB-\angle DAF-\angle BAE$; the second wins because $\angle DAB=90^\circ$ and $\angle DAF$ is already done |
| 57 | **When both sides land in the same sub-figure, focus there** | Your two expressions now involve the same triangle | p. 67: "it is clearly time to start focusing on this triangle" $ABE$ |
| 58 | **Recognize trigger configurations** | A triangle inscribed in a semicircle; a right angle on a circle | p. 67: "This should remind one of Thales' theorem" |
| 59 | **Work from both ends and meet in the middle** | An equality of two obscure quantities | p. 68: "Working out $\angle DAF$ and $\angle EAF$ and hoping that they meet somewhere in between is not all that foolish, if you know what you are doing" |
| 60 | **"Simplify and connect"** — the default heuristic when nothing else applies | Any stuck moment | p. 68 |
| 61 | **Discovery ≠ presentation** — tidy the messy search into a clean chain afterwards | You've found the answer | p. 68: "we would probably do some long chain of equations like so: $\angle DAF = \dots = \angle EAF$" |
| 62 | **Trust the problem** | You're doubting a solution exists | p. 68: "most problems are not trying to pull your leg" |
| 63 | **"Good problems usually look simple and straightforward"** — don't be lulled | A one-line problem statement | p. 58 |
| 64 | **A small fixed toolkit, applied systematically, is enough** — so inventory it rather than hunting for cleverness | Starting any synthetic problem | p. 49: "There are several basic results which can be used to systematically attack and resolve questions"; p. 51: "there are heaps of theorems just waiting to be used" |
| 65 | **Coordinates are the *same* method taken to extremes**, not a different subject | Deciding how far to mechanise | p. 49: "This idea can be taken to extremes with coordinate geometry" |
| 66 | **Draw a figure and guess the conclusion from it** — the zeroth-order method, and notice when it fails | Before any real work | p. 55: "Simply drawing a figure and guessing conclusions is helpful sometimes, but a figure is quite hard to draw in this case" |
| 67 | **Forward = hill-climbing**: keep transforming the data into things that *look more and more like* the objective | You've chosen the forward approach and need a step rule | p. 55: "by gradually simplifying and transforming our data into things that look more and more like our objective" |
| 68 | **Announce your own progress out loud** ("this is progress because …") | Mid-derivation | p. 51: "This is progress because the two angles $\angle AIF$ and $\angle CFE$ are much more easily worked out"; p. 54 |
| 69 | **Choose the sub-figure with the most already-known quantities**, not just the one containing your target | Several triangles contain your unknown side | p. 53: "we need a triangle or two, preferably those that contain $OD$ and $OE$ **and have a lot of angles that we already know**" |
| 70 | **Measure the diagram to generate candidates** — use the drawing as a cheap oracle | You need to guess which sub-figures matter | p. 53: "Looking at the diagram, and measuring out angles, we can guess that the triangles $AOD$, $COD$, $AOE$, $BOE$ could be useful" |
| 71 | **Experiment first, then conclude "something special is needed"** | A construction resists freehand drawing | p. 58: "After experimenting with circles, $60^\circ$ angles, and the like, we should see that something special is needed"; and the instruction "(try it, but draw the parallel lines first)" |
| 72 | **Check that spending a degree of freedom loses no solutions** | You just fixed something arbitrarily | p. 59: "we can place $A$ wherever we like **and not worry about missing anything**" |
| 73 | **Proceed provisionally — you are allowed not to know yet** | You've made a reduction but can't see whether it will close | p. 59: "Perhaps this restriction could force $B$ and $C$ into a limited number of positions. **We do not know yet.**" |
| 74 | **Let the wriggling tell you which object generates the others** — the qualitative pass chooses your variables | You need to pick what to parametrize | p. 64: "From our discussion of 'wriggling' … it is apparent that one rectangle, for example $R_1$, will determine the positions of all the other rectangles" |
| 75 | **"Flush fitting" — count the closure conditions, not just the local ones** | A tiling / cyclic configuration | p. 63: "because of needs of equal area, as well as the difficulties of 'flush fitting', the only possibile way this can work is if the inner rectangle is a square" |
| 76 | **Restate "prove X" as "characterize which configurations are allowed"** | The objective is a shape/rigidity claim | p. 64: "not just any dimensions of $R_1$ will work: in fact we have to prove that the only formations of $R_1$ allowed are those that produce a square in the middle" |
| 77 | **The same equation read from a different object gives a different equation** | You have one messy relation | p. 64: "two equations concerning rectangle $R_3$ (or perhaps $R_1$, $R_2$, or $R_4$ if we interpret the equations differently)" |
| 78 | **Keep the purpose of a tool in view while using it** | Deep in a computation | p. 54: "To get a workable expression for $|OD|$ and $|OE|$ (which was why we wanted the sine rule in the first place)" |
| 79 | **A named theorem's free parameter is yours to instantiate conveniently** | A theorem says "for any point $P$ …" | p. 67: "$\angle DAF=\angle APF$, where $P$ is any point on $k$ … For example, we could say $\angle DAF=\angle ACF$" |
| 80 | **Collect surprising-but-checkable elementary facts as a personal stock** | Long-term preparation | p. 50: the midpoints of a quadrilateral form a parallelogram — "These facts—they have a certain something about them" |

---

## Background you need first

You need almost no prerequisites beyond high-school geometry, but the chapter uses about a dozen facts fluently that a CS undergraduate may never have seen named. Here they are, each with a concrete instance.

**Notation.** $|AB|$ means *the length of the segment from $A$ to $B$* (a number). $\angle ABC$ means *the angle at vertex $B$ in the path $A\to B\to C$* (also a number, in degrees). Greek letters conventionally denote angles: "it is traditional to use Greek letters to denote angles" (p. 51).

**Angle sum of a triangle $=180^\circ$.** This is the single most-used fact in the chapter. It is the escape hatch: if you know two angles of a triangle you know the third.

**Isosceles triangles have equal base angles.** If $|OA|=|OP|$ then $\angle OAP = \angle OPA$. (This is the length→angle exchange rate you get for free.)

**Angle bisector.** The ray from a vertex that splits its angle into two equal halves. If $\angle BAC = \alpha$ and $AD$ bisects it, then $\angle BAD = \angle DAC = \alpha/2$.

**The incentre.** The three angle bisectors of a triangle all pass through one common point (they are *concurrent*). That point is the incentre — the centre of the circle tangent to all three sides. Tao uses only the concurrency, which is why he can call one point $I$ and say it lies on $AD$, $BE$ *and* $CF$ simultaneously (p. 51).

**Inscribed angle theorem (two forms).** Take a circle and a chord $QR$ (a chord is just a segment joining two points of the circle).
  - *Same-arc form:* if $P_1$ and $P_2$ are two points of the circle on the same side of $QR$, then $\angle QP_1R = \angle QP_2R$. Tao states it as "the angle subtended by a chord on an arc is always the same" (p. 51). Concretely: on the unit circle take $Q=(-1,0)$, $R=(1,0)$; every point $P$ on the upper semicircle sees $QR$ at exactly $90^\circ$.
  - *Central-angle form:* the angle subtended at the centre is **twice** the angle subtended at any point of the far arc: $\angle QOR = 2\angle QPR$. Concretely: $Q$ at angle $0^\circ$, $R$ at angle $60^\circ$ on a circle centred at $O$; then $\angle QOR=60^\circ$ and from any point $P$ on the major arc, $\angle QPR = 30^\circ$.

**Thales' theorem (Theorem 4.1, Euclid III.31).** "The angle subtended by a diameter is a right angle." If $AB$ is a diameter of a circle and $P$ is any other point of the circle, $\angle APB = 90^\circ$. *Diagram:* a circle with centre $O$; $A$ and $B$ diametrically opposite (so $A$, $O$, $B$ are collinear); $P$ somewhere on the upper arc; segments $PA$, $PB$, and (for the proof) $PO$ drawn.

```
              P
             /|\
            / | \
           /  |  \
          /   |   \
     A---------O---------B
```

Tao's proof is the chapter's model of technique #1, *chaining obvious facts*: draw $OP$, which splits triangle $APB$ into two triangles $APO$ and $OPB$, each isosceles because $|OP|=|OA|$ and $|OP|=|OB|$ (all are radii). So $\angle APO=\angle PAO$ and $\angle OPB=\angle PBO$. Then
$$\angle APB = \angle APO+\angle OPB = \angle PAO+\angle PBO = \angle PAB+\angle PBA = 180^\circ - \angle APB,$$
where the last equality is the angle sum in triangle $APB$. So $2\angle APB = 180^\circ$, i.e. $\angle APB=90^\circ$. Nothing in that proof is clever; every step is a one-liner. That's the point.

The **converse of Thales** is equally useful and is what makes two of the exercises work: if $\angle APB=90^\circ$ then $P$ lies on the circle whose diameter is $AB$. In other words, *"the set of points that see the segment $AB$ at a right angle" is a circle* — a locus you can draw with a compass.

**Cyclic quadrilateral.** Four points are *cyclic* (or "$ABCD$ is cyclic") if a single circle passes through all four. The inscribed angle theorem says: if $B$ and $D$ are on the same side of line $AC$, then $ABDC$ is cyclic **iff** $\angle ABC=\angle ADC$. That "iff" is the swap Tao recommends on p. 58: an angle equality and a concyclicity are the same statement wearing different clothes. *(Textual note: p. 58 prints the side condition as "if $B$, $D$ are on the same side of $AB$", which cannot be right — $B$ is one of the two points. The line that matters is $AC$, the chord whose two subtended angles you are comparing.)*

**Cevian.** A segment from a vertex of a triangle to a point on the opposite side. Both bisectors in Problem 4.2 ($BD$ and $CE$) are cevians. The word isn't Tao's, but it is the standard name and it is what the two crossing segments in that problem are.

**Pythagoras' theorem.** In a right triangle with legs $a,b$ and hypotenuse $c$, $a^2+b^2=c^2$. It is the engine of both "pseudo-coordinate geometry" (technique #26) and the second half of Theorem 4.2.

**A tangent is perpendicular to the radius at the point of contact.** Used twice, and both times silently: in the proof of Theorem 4.2 ($\angle OTP=90^\circ$, which is what lets Pythagoras in), and — crucially — in Problem 4.6, where it runs *backwards*: because $AD\perp AB$ and $AB$ is a radius of $k$, the side $AD$ of the square **is** the tangent to $k$ at $A$. Tao does not spell that out; it is the hidden hypothesis that makes the tangent–chord theorem applicable.

**An isosceles triangle with a $60^\circ$ apex is equilateral.** If $|AB|=|AC|$ and $\angle BAC=60^\circ$ then the two base angles are equal and sum to $120^\circ$, so all three angles are $60^\circ$ and all three sides are equal. This one-liner is what makes Problem 4.4's construction produce an *equilateral* triangle rather than merely an isosceles one.

**Diagonals of a rectangle bisect each other and are equal.** So the crossing point $D$ of the diagonals in Problem 4.3 is the midpoint of both, and $|DA|=|DB|=|DF|=|DE|$ — i.e. $D$ is automatically the centre of a circle through all four vertices. That is the fact that turns "we need a circle through $F$, $B$, $A$" into "we already have one".

**Tangent–chord angle (Euclid III.32).** A *tangent* is a line touching the circle at exactly one point. Tao calls this "the odd little theorem … that the angle a chord subtends in a circle is the same as the angle the chord subtends in the tangent" (p. 67). Precisely: if a chord $AF$ starts at $A$ and $t$ is the tangent at $A$, then the angle between $t$ and $AF$ equals the inscribed angle $\angle APF$ for $P$ on the arc on the *other* side of the chord. Concrete check: unit circle, $A=(1,0)$, tangent at $A$ is the vertical line; take $F$ at angle $90^\circ$, i.e. $F=(0,1)$. The tangent-chord angle between the upward vertical and $AF$ is $45^\circ$; and from $P=(-1,0)$ on the far arc, $\angle APF = 45^\circ$. ✓

**Similar triangles.** Two triangles with the same three angles have proportional sides. So an angle fact converts into a *ratio* fact. In practice: if two right triangles share one acute angle, they are similar, hence corresponding leg ratios are equal.

**The sine rule.** In any triangle with vertices $A,B,C$ and opposite sides $a,b,c$,
$$\frac{a}{\sin A}=\frac{b}{\sin B}=\frac{c}{\sin C}.$$
This is *the* dictionary between sides and angles: it says "side over sine of the opposite angle is the same for all three corners". Tiny example: a triangle with angles $30^\circ,60^\circ,90^\circ$ and hypotenuse $2$ has $\frac{2}{\sin 90^\circ}=2$, so the side opposite $30^\circ$ is $2\sin 30^\circ=1$ ✓.

**The cosine rule.** $c^2=a^2+b^2-2ab\cos C$. It relates *three* lengths and one angle. Tao rejects it in Problem 4.2 because it "usually complicates rather than simplifies, and it just creates more unknown lengths" (p. 53) — a useful heuristic: the sine rule trades one length for one angle; the cosine rule drags two extra lengths in with it.

**$\sin X=\sin Y$ has two solution families.** For angles in $(0^\circ,180^\circ)$, $\sin X=\sin Y$ means $X=Y$ **or** $X=180^\circ-Y$. E.g. $\sin 30^\circ=\sin 150^\circ=1/2$. Tao turns this into a proof technique in Problem 4.2: it is the *source* of the "either/or" in the conclusion.

**Power of a point (Theorem 4.2).** Tao states it for $P$ outside a circle with centre $O$ and radius $r$: if a ray from $P$ cuts the circle at $Q$ and $R$, then
$$|PQ|\times|PR| = |PT|^2 = |PO|^2-r^2,$$
where — in Tao's exact words — "$T$ is a point where **one of the two tangents** from $P$ meets the circle." (There are two tangents from an external point and they touch at two different places; the theorem doesn't care which one you pick, because $|PT|^2=|PO|^2-r^2$ either way. That indifference is itself informative: the quantity $|PO|^2-r^2$ is the real object, and $T$ is just one way of naming it.) *Diagram (p. 57):* a circle centred $O$; a point $P$ well outside on the left; a ray from $P$ passing through the circle, entering at the near point $Q$ (just left of centre) and leaving at the far point $R$ (upper right); the tangent line from $P$ touching the circle at $T$ at the top; segments $PO$, $OT$, $QT$, $TR$ all drawn (they are what make the two similar triangles $PQT$ and $PTR$ visible).

The proof is two obvious facts: triangles $PQT$ and $PTR$ are similar (they share the angle at $P$, and the tangent–chord angle gives $\angle PTQ=\angle PRT$), so $|PQ|/|PT|=|PT|/|PR|$; and $\angle OTP=90^\circ$ (a tangent is perpendicular to the radius), so Pythagoras gives $|PO|^2=|PT|^2+r^2$.

The content worth memorizing is the *shape*: **the product of the two distances from $P$ along any line through the circle depends only on $P$, not on the line.** That is why it is the right tool whenever your objective contains a product of two collinear lengths measured from a common point. Tiny example: unit circle centred at the origin, $P=(3,0)$. Along the horizontal line, $Q=(1,0)$ and $R=(-1,0)$, so $|PQ|\times|PR| = 2\times 4 = 8$. And $|PO|^2-r^2 = 9-1=8$ ✓. Take instead the line through $P$ at a slight angle: the two intersection distances still multiply to 8.

Tao notes the theorem "is usually in high-school textbooks but rarely used there" (p. 57) — i.e. it is exactly the sort of tool that is dormant in your memory and needs an explicit *trigger* attached to it.

**Rotations, and inverses of rotations.** A rotation by $\theta$ about a point $A$ is a rigid motion: it maps lines to lines and circles to circles, and it's undone by rotating by $-\theta$ about the same point. That invertibility is the entire content of technique #43.

**Locus.** The set of all points satisfying some condition. "The locus of points at distance $r$ from $O$" is a circle. Construction problems get solved by writing your unknown point's constraints as two loci and intersecting them — exactly like solving two simultaneous equations.

**Degrees of freedom.** How many independent numbers it takes to specify your object. A point in the plane: 2. A point constrained to a line: 1. A line: 2. An equilateral triangle: 4 (position 2, orientation 1, size 1). Each constraint ("this vertex is on that line") typically removes 1. This is the same accounting a programmer does with "unknowns vs. equations".

**Straightedge and compass.** The allowed operations in a construction problem: draw the line through two known points; draw the circle with known centre through a known point; take intersections. Notably you *can* construct a $60^\circ$ rotation of a given line about a given point (equilateral triangles are compass-constructible), which is what legitimizes Problem 4.4's answer.

---

## Technique 1: Chain obvious facts (and don't reach for coordinates)

- **What it is.** Solve a non-obvious problem by composing a long sequence of individually trivial deductions, each licensed by a named elementary theorem.
- **When to reach for it.** Always, in synthetic geometry — it's the default mode.
- **Tao's own words.** "the true beauty of geometry is in how a non-obvious looking fact can be shown to be undeniably true by the repeated application of obvious facts" (p. 49). And of the alternative: coordinate geometry "transforms points, lines, triangles, and circles into a quadratic mess of coordinates, crudely converting geometry into algebra" (p. 49).
- **The precondition that makes it work, stated on p. 49 and easy to miss.** "There are several basic results which can be used to systematically attack and resolve questions about geometrical objects and ideas." *Several* — a handful, not hundreds. The reason "chain obvious facts" is a strategy and not a hope is that the toolkit is small enough to enumerate at the start of a problem. Tao does exactly that enumeration out loud in Problem 4.1: "there are heaps of theorems just waiting to be used: the sum of angles in a triangle add up to $180^\circ$; the angle subtended by a chord on an arc is always the same; the angle bisectors are concurrent" (p. 51). Three items. That is the whole arsenal for that problem, and it suffices.
- **And the framing of the alternative.** Coordinate geometry is introduced on p. 49 not as a rival method but as "this idea … taken to extremes" — the same systematising impulse, pushed until the geometry disappears. So when you later decide to hold coordinates in reserve (technique #25), you are not choosing between insight and mechanism; you are choosing *how much* mechanism to buy, and paying for it in "quadratic mess".
- **Seen in action.** Theorem 4.1 (Thales): draw one radius, get two isosceles triangles, apply equal base angles twice, apply angle sum once, done. Theorem 4.2 (power of a point): one similarity plus Pythagoras.
- **Why it works.** The elementary theorems are *closed* in a useful way: angle facts produce angle facts, so a chain never leaves your comfort zone. Programmer's analogy: you're composing small pure functions with matching type signatures, rather than dropping into assembly.
- **Failure mode.** Chains can be long ("you usually have to work out a heck of a lot of other angles first", p. 52), and the chapter's harder problems (4.3, 4.5) show that sometimes no chain of *routine* facts closes the gap — you need one recalled special theorem or one change of tactic entirely.

Tao also flags a related class of facts as worth collecting for their own sake — results you can verify by drawing and measuring but that aren't obvious. His example is the theorem that **the midpoints of the four sides of any quadrilateral form a parallelogram** (p. 50; this is Varignon's theorem). "These facts—they have a certain something about them." The technique buried here: *maintain a personal stock of surprising elementary facts*, because technique #31 (recall a result that a form vaguely triggers) can only fire on things you have stocked.

---

## Technique 2: Draw it, label it, and name the points the problem forgot to name

- **What it is.** Before any reasoning: draw the configuration, mark every quantity you can, and *invent names* for the important points the problem statement leaves anonymous.
- **When to reach for it.** Universally. Tao says it three times in this chapter alone (pp. 50, 59, 66).
- **Tao's own words.** "The first step, of course, is to draw a picture and label what we can" (p. 50). "As always, we begin by drawing a picture" (p. 66).
- **Seen in action.** Problem 4.1: the problem never mentions the incentre or the point where the two lines cross, but Tao adds both: "I have taken the liberty of labelling the incentre $I$ (the intersection of all the bisectors, and likely to be important), as well as the intersection $M$ of $AD$ and $EF$ (which is where we want to establish our right-angle)" (p. 50).
- **Why it works / what it buys you.** Two things. (a) **Naming makes the objective expressible as an equation**: with $M$ named, "$AD$ is perpendicular to $EF$" becomes "$\angle AMF=90^\circ$" (p. 51), and an equation is something you can transform, whereas a sentence is not. (b) The named points are the ones that will appear in your triangles; unnamed points can't be reasoned about. The heuristic for *which* points to name is stated inline: the ones "likely to be important" (special centres, concurrency points) and the ones where the conclusion lives.
- **Failure mode.** Adding too much: see technique #34, don't construct every possible extension. Name what the *objective* needs, plus the obvious distinguished points.

---

## Technique 3: Triage the problem from the diagram, then choose forward or backward

- **What it is.** Before committing to a method, read off from the picture how hard the problem is and how visible the conclusion is, and pick your approach accordingly.
- **When to reach for it.** Immediately after drawing.
- **Tao's own words.** "This is a feasible-looking problem: the diagram is easy to draw, the conclusion is quite evident from the figure. With such a problem, a direct approach would probably work quite nicely" (p. 51). Conversely: "a figure is quite hard to draw in this case. How do you force it so that $|DC|=|DG|$?" (p. 55) — and Problem 4.3 ends up needing the backward approach.
- **Why it works.** Diagram difficulty is a proxy for constraint rigidity. If a hypothesis is easy to *satisfy by hand*, it isn't doing much work, and the conclusion is probably a short computation away. If you can't even draw the hypothesis, the hypothesis is a strong, non-local constraint, and no amount of local angle-measuring will find it — you'll need to reshape the goal until it touches that constraint directly.
- **Tao's explicit statement of the dichotomy** (p. 55): "With geometry problems, one can either work forward (measuring sides and angles systematically), or backward (turning the end result into something equivalent but simpler to work with)." And the rule for choosing: the forward approach "works well when the objective is a simple relation involving easily calculable parts of the problem … When the objective is obscure, we may have to transform the objective before we know which directions to try."
- **The zeroth-order method, and its explicit failure.** Before either of those, p. 55 records the cheapest thing you can do: "**Simply drawing a figure and guessing conclusions is helpful sometimes**, but a figure is quite hard to draw in this case. How do you force it so that $|DC|=|DG|$?" So the triage has three tiers, not two: (0) draw it and read the answer off; (1) forward; (2) backward. And the *reason* tier 0 fails here — you cannot realize the hypothesis freehand — is precisely the signal that pushes you past tier 1 as well. Difficulty-of-drawing is a single diagnostic that resolves both choices.
- **The mechanism inside the forward approach.** Tao spells out *why* forward works when it works, and the clause is the operational content of the whole method: it works "because then we can have an idea how to approach the problem, **by gradually simplifying and transforming our data into things that look more and more like our objective**" (p. 55). That is hill-climbing with an explicit objective function — "syntactic resemblance to the goal". It also tells you the step rule: at every stage, prefer the rewrite whose output looks more like the target. (Compare Problem 4.2, where the progress signals are exactly "the sines are gone" and "an 'or' has appeared" — both purely syntactic resemblances to the goal, not semantic ones.) Forward fails exactly when the objective is so obscure that "looks more like the objective" is not a computable comparison — which is the definition Tao gives for switching to backward.

---

## Technique 4: Angle chasing, with a chosen reference frame

- **What it is.** Introduce names for the base angles of the "main" figure, then express *every* angle in the diagram in terms of them, and read off the objective.
- **When to reach for it.** Tao gives an explicit trigger list (p. 52): "They are best for questions which have no reference to side lengths, and have lots of triangles and circles to play with, and maybe even an isosceles triangle to work with."
- **Tao's own words.** "This is a lovely way to solve some geometrical questions: by simply working out angles. They are usually easier to work out than sides (which have all kinds of nasty sine and cosine rules to plough through), and the rules are easier to remember" (p. 52).
- **Seen in action.** Problems 4.1 and 4.6 are pure angle chases; Problem 4.2 becomes one after a length→angle translation.
- **Why it works.** Angles compose additively and are constrained by cheap universal identities ($180^\circ$ in a triangle, $360^\circ$ around a point, inscribed angle theorem). Lengths need multiplicative machinery. Also: angles are *scale-invariant*, so an angle-only argument automatically ignores the one degree of freedom (size) you don't care about.
- **Failure mode.** Stated bluntly by Tao: "But to get some of the more obscure angles, you usually have to work out a heck of a lot of other angles first" (p. 52). And in Problem 4.2, the direct isosceles→equal-base-angles translation of $|OD|=|OE|$ produces angles that connect to nothing.

**The sub-technique that makes it work: pick a reference frame.** In Problem 4.1: "With the 'main' triangle being $ABC$, and with all the angle bisectors and circles and stuff revolving about this triangle, it might be best to start with the angles $\alpha=\angle BAC$, $\beta=\angle ABC$, $\gamma=\angle BCA$" (p. 51). Restated even more explicitly in Problem 4.2: "$ABC$ is the 'main' triangle: all other points stem from that triangle. It is a logical reference frame; all quantities should be in terms of the main triangle" (p. 52). This is exactly *choosing a basis*: pick the minimal set of independent quantities that generate everything else (here $\alpha,\beta,\gamma$ with the one relation $\alpha+\beta+\gamma=180^\circ$), and express all derived quantities in that basis so that they can be compared.

**The sub-technique that unblocks it: represent the obscure in terms of the non-obscure.** "In fact we can get virtually all relevant angles—except those at $M$, which are the ones we really want. So, we must somehow represent our angle at $M$ in terms of angles that are not related to $M$" (p. 51). The mechanism is the angle sum: an angle you cannot compute directly, sitting in a triangle whose other two angles you *can* compute, equals $180^\circ$ minus their sum.

---

## Technique 5: Translate between currencies — and screen the exchange rates

- **What it is.** When your data and your objective are denominated in different quantities (lengths vs. angles vs. ratios vs. areas), list every available translation mechanism and **eliminate the ones the configuration can't support**, rather than trying them at random.
- **When to reach for it.** Whenever data-type ≠ objective-type. In Problem 4.2 the data is a length equality $|OD|=|OE|$ and the objective is about angles.
- **Tao's own words.** "There are several ways to relate sides and angles: basic trigonometry, similar triangles, isosceles and equilateral triangles, sine and cosine rules, to mention a few. Basic trigonometry requires right angles and circles, and we do not have many of them. We have few similar triangles either, and we have already considered the isosceles triangle approach. The cosine rule usually complicates rather than simplifies, and it just creates more unknown lengths. This only leaves the sine rule as a feasible alternative. After all, it relates sides to angles quite directly" (p. 53).
- **Why it works.** This is *screening candidates against preconditions* before spending effort — the same discipline as checking a library function's requirements before calling it. Each tool has an entry condition (basic trig needs right angles; similar triangles need equal angles; the sine rule needs a triangle containing your side and angles you know), and most are visibly absent from the figure. Elimination is cheaper than trial.
- **Failure mode / dead end recorded.** The *most obvious* translation is tried first and dropped: "The obvious way is to say that, because $ODE$ is isosceles, $\angle ODE=\angle OED$. That may look promising, but it is quite hard to equate the angles $\angle OED$ and $\angle ODE$ to any other angles" (p. 52). The lesson: a translation is only useful if the resulting quantities *connect to your reference frame*. A correct-but-isolated rewrite is a dead end.

**Companion technique: pick the sub-figure with the most known quantities.** Once the sine rule is chosen, Tao states two criteria for *where* to apply it, and the second one is easy to skip past: "to use the sine rule, we need a triangle or two, preferably those that contain $OD$ and $OE$ **and have a lot of angles that we already know**" (p. 53). Criterion 1 (contains your target) is obvious; criterion 2 (is already mostly filled in) is the one that decides. This is the payoff of the earlier flood-fill: the value of a sub-figure is measured in how much of it you already have for free.

**Companion technique: measure the drawing to generate candidates.** How does he find the four candidate triangles? "**Looking at the diagram, and measuring out angles**, we can guess that the triangles $AOD$, $COD$, $AOE$, $BOE$ could be useful" (p. 53). The diagram is used as a cheap, fallible oracle: measure it, notice what looks equal or convenient, and let that *propose* the sub-figures — then prove things properly afterwards. Guessing from measurement is not cheating; it is how the candidate list gets built.

**Companion technique: look for connections.** "always try to look for connections. Knowing that two quantities are equal would not help unless you connect them in some way" (p. 53). Operationally, this is why Tao picks triangles $AOD$ and $AOE$ out of the four candidates ($AOD$, $COD$, $AOE$, $BOE$): they "have a common side, which should make the problem simpler". The shared side $OA$ is the variable he will later eliminate. So the selection criterion is *anticipating the elimination step*.

**Companion technique: keep the tool's purpose in view.** When he finally writes the sine rule down: "To get a workable expression for $|OD|$ and $|OE|$ (**which was why we wanted the sine rule in the first place**)" (p. 54). A one-clause reminder of the goal, inserted at the moment of maximum notational distraction. Small habit, large effect — most derailments in long computations are goal-amnesia, not algebra errors.

**Companion technique: reduced diagram.** "Since we are only looking at four of the six points $(A,D,E,O)$ we could draw a reduced diagram to deal with them (after all, why should one have to deal with useless clutter?)" (p. 53) — and the reduced figure is redrawn "rotated and blown up for clarity". Deleting irrelevant structure from a diagram is the visual equivalent of narrowing scope.

---

## Technique 6: The backward approach — reshape the objective

- **What it is.** Instead of pushing the data forwards, rewrite the *goal* — into an equivalent, more symmetric, more recognizable, or algebraically massaged form — until the data can reach it.
- **When to reach for it.** "When the objective is obscure" (p. 55); when forward attempts have visibly stalled.
- **Seen in action.** Problem 4.3 is the case study: a three-way ratio equality is (i) recognized as a similar-triangles signature, (ii) partially proved, (iii) restated as a *different, more symmetric* single equality, (iv) cross-multiplied into a product of lengths, (v) matched against a remembered theorem.
- **Why it works.** Objectives, unlike data, can be freely rewritten in *equivalent* form — you don't lose information. So they're the cheap end of the problem to manipulate. Each rewrite is a chance to hit a form that a known theorem's left-hand side matches syntactically.
- **Tao's rule for choosing among rewrites** (p. 56): prefer the one that "is more symmetric and involves only one equality."

**The equivalence dictionary (p. 58).** Tao's list of goal-rewrites worth memorizing:
- To prove $\angle ABC=\angle ADC$, prove instead that $ABDC$ is **cyclic**, "which is equivalent (if $B$, $D$ are on the same side of $AB$)". *The printed side condition is a typo — the relevant line is $AC$, the chord subtending the two angles being compared; $B$ obviously lies on $AB$.* Worth flagging because the side condition is not optional: if $B$ and $D$ are on **opposite** sides of $AC$, concyclicity gives $\angle ABC + \angle ADC = 180^\circ$ instead of equality.
- To prove $|AB|>|AC|$, prove instead $\angle ACB>\angle ABC$ "(provided $A,B,C$ are not collinear)" — the bigger side faces the bigger angle. Note that this is an *inequality* swap, and it is the only inequality tool Tao names before Problem 4.5 makes inequalities the whole method.
- For area questions, Tao's exact suggestions: "use facts like triangles with equal base and equal height have equal area, or perhaps if the base of a triangle was halved, then the area would also be halved." Both are consequences of $\text{area}=\tfrac12\,\text{base}\times\text{height}$; the reason he lists them separately is that the first converts an area equality into a *parallelism/collinearity* fact (equal heights means the apexes lie on a line parallel to the base) and the second converts it into a *ratio of lengths*. Different exchange rates out of the same currency.

And the master heuristic behind the dictionary: **"Look for things that vaguely trigger a memory"** (p. 58). Note the epistemics here — the signal is *familiarity*, not tractability. $|FC|\times|BC|$ isn't easier than $|FC|/|GA|$; it just *looks like* something. Tao is explicit that this is experience-gated and late-firing: "With enough geometrical experience these things can come to mind after one has looked at every part of the problem and has 'grasped' the nature of the problem (these things also come to mind usually only after all other means have failed)" (p. 58).

---

## Technique 7: Rank your brute-force options and keep them in reserve

- **What it is.** Explicitly decide, up front, that coordinates/vectors/algebra are available but will be used only if nothing else works — and know which brute-force flavour is least painful.
- **Tao's own words.** On coordinates: "Hack-and-slash coordinate geometry is one long and boring way that is prone to abysmal complications and huge errors. Let us try that as a last resort (although the right angle at $A$ looks like a tempting location to place the origin and coordinate axes)" (p. 55). On vectors: "Vector geometry is also not suited too well with equations like $|DC|=|DG|$ (but the vector versions are still usually neater than the coordinate counterparts)" (p. 55). In Problem 4.4: "One obvious guess is to use coordinate geometry. Well, this is possible, but messy. You will end up using the quadratic formula … As usual, we save that as a last resort" (p. 59).
- **The middle option — pseudo-coordinate geometry.** "Without such inspiration, one should stick to coordinate geometry or perhaps pseudo-coordinate geometry (drop perpendiculars from $D$ to $AB$ and $AC$, say, and use Pythagoras to represent $|DC|$ and $|DG|$—essentially coordinate geometry without the axes)" (p. 58). This is a genuinely useful intermediate: you get the computational power of coordinates without the bookkeeping of axes and signs.
- **Why the ranking matters.** Brute force in geometry *always* works in principle (that's Descartes' point), so the decision is purely about error rate and time. Tao's criterion is: how many extra unknowns does the method introduce, and how many chances to slip? Note he still records the *best* place to put the origin (the right angle at $A$) — reserving a method is not the same as forgetting how you'd do it.
- **Failure mode of avoiding brute force.** If you have no flash of memory, you must fall back — and Tao says so explicitly. The reserve plan is not optional.

---

## Technique 8: Constructions — "solve for" the unknown

- **What it is.** Treat a straightedge-and-compass construction problem as a system of equations in geometric unknowns. Reformulate every condition into the form "*my unknown* is in *this constructible set*", then intersect.
- **When to reach for it.** Any "construct X such that …" problem.
- **Tao's own words.** "With construction questions, the idea is to 'solve for' one's unknowns, in this case $B$, just like in algebra. We kept reformulating the data until it was in the form '$B$ is …'" (p. 61). And the textbook version: "the standard way to solve construction questions is to take one of the unknowns (a point, line, triangle, or maybe something else) and determine a locus or other easily constructible property" (p. 59).
- **The four sub-moves**, all visible in Problem 4.4:
  1. **Spend the free degrees of freedom — with a certificate.** If the whole configuration can be slid/scaled without violating anything, fix that freedom arbitrarily — and then notice a constraint has become vacuous. (Placing $A$ anywhere on $l_1$ kills $l_1$ entirely.) The certificate is Tao's clause "we can place $A$ wherever we like **and not worry about missing anything**" (p. 59): the symmetry that lets you slide is what guarantees no solution is lost. Never spend a degree of freedom without being able to name that symmetry.
  2. **Count degrees of freedom against anchors** to check the problem is determined before hunting. Tao's word for a constraint is an **anchor**, and he asks "What is the anchor on $B$?" as a separate, explicit question (p. 59) — worth copying, because the answer ("the equilateral triangle with base $AB$ must have its third vertex on $l_3$") is what reveals that the anchor is still phrased in terms of the object you were trying to eliminate, which is what triggers sub-move 4. Also note what the count does and doesn't buy: 2 d.o.f. against 2 anchors "theoretically should be enough to restrict the triangle" — plausibility, not a method — and Tao says so ("it is hard to see where to go next").
  3. **Shift to the simplest unknown.** "But what we can do is to shift the unknown into another unknown more easily evaluated. Currently the unknown is the equilateral triangle. What about something simpler? The simplest geometrical object is a point" (p. 59).
  4. **Invert the condition** so your unknown is the subject of the sentence: rather than "the image of $B$ lies on $l_3$", say "$B$ lies on the pre-image of $l_3$" (p. 60). This is the single sharpest move in the chapter and it generalizes far beyond geometry: *when a condition constrains $f(x)$, apply $f^{-1}$ to the constraint so it constrains $x$.*
- **The algebraic analogy Tao gives** (p. 61) for why this works. Solve for $b,c$ given: $b+1$ is even; $bc=48$; $c$ is a power of 2. Solve each for $b$ and eliminate $c$: $b$ is odd; and $b\in\{48,24,12,6,3,1.5,\dots\}$. Intersect the two sets: $b=3$. "It is often easier to solve questions with several variables by eliminating them one by one, and the same holds in constructional geometry." Each geometric locus is exactly one of those sets; the construction is the intersection.
- **Failure mode.** Solving for the wrong unknown. Exercise 4.3's hints say so directly: solving for the square is very hard, solving for a *single vertex* is "only a little better: the vertex can be confined to a fixed circle, but that is about it", and what works is solving for a *diagonal*, because "the diagonal will determine the square uniquely, while a single vertex cannot do that easily" (p. 62). So the criterion for choosing the unknown is not just simplicity but **whether pinning it down pins down everything else.**

---

## Technique 9: Wriggle the configuration — qualitative rigidity analysis

- **What it is.** Before computing anything, try to *deform* the configuration while keeping the hypotheses true. Either you succeed (and learn the conclusion is false, or that you have a free parameter to exploit) or you fail in an instructive way (and the *reason* you fail is the proof).
- **When to reach for it.** When the hypothesis looks too weak to force the conclusion — Tao's "unusual objective" questions.
- **Seen in action.** Problem 4.5. "At first you might think there is too much freedom in the data: after all, a rectangle with a fixed area could be long and thin, or short or fat. Why cannot we maneuvre one rectangle out of shape, and distort the inner rectangle? A quick try shows why this does not work: each rectangle is constrained by its neigbouring rectangles" (p. 63). The wriggling reveals the mechanism: the constraints propagate around a cycle and cannot close. And the conclusion Tao draws from it is worth quoting in full, because it contains three deliverables at once: "**Light begins to dawn on how this question 'works': because of needs of equal area, as well as the difficulties of 'flush fitting', the only possibile way this can work is if the inner rectangle is a square. It should be impossible to move out of this symmetric swastika formation**" (p. 63). The three deliverables: a *belief* that the claim is true; a *decomposition of the constraints* into "equal area" plus "flush fitting" (Tao's own phrase for the requirement that the arms close up against the walls of the square with no gap and no overlap); and a *proof strategy* in embryo — "it should be impossible to move out of", i.e. a rigidity statement, i.e. a contradiction argument. Keep the term **flush fitting** in your vocabulary: in tiling and cyclic-configuration problems the constraints you forget are the closure conditions, not the local ones.

  A further payoff of the wriggling, easy to miss because it appears a page later: it is what tells him *which object to parametrize*. "From our discussion of 'wriggling' the formation it is apparent that one rectangle, for example rectangle $R_1$, will determine the positions of all the other rectangles" (p. 64). So the qualitative pass produces not one but four outputs: the belief, the mechanism, the strategy, and the choice of variables.
- **Why it works.** It converts "prove a rigidity statement" into "find the obstruction to flexibility" — and obstructions are concrete. It also *tells you the proof strategy*: because the insight is "you can't wriggle", the natural formalization is a contradiction argument with an inequality that propagates (technique #53). Tao says so: the contradiction strategy "fits well with our earlier, qualitative approach" (p. 65).
- **Companion move: draw the failure.** Tao includes a second figure showing a *broken* pinwheel where $R_3$ can match $R_2$ or $R_4$ but not both (p. 63). Drawing the counterexample-attempt is as informative as drawing the configuration.
- **Related move for the forward direction: special and extreme cases.** "Sometimes one can try using a special or extreme example to try to suggest a way (for instance, for the above problem, we could consider the case when $ABEF$ was square, or when $ABEF$ was degenerate, or when $|DC|=|DG|=0$)" (p. 58). Same idea, opposite direction: instead of deforming continuously, jump to the extreme points of the parameter space where everything simplifies.

---

## Technique 10: Intermediate goals, implication chains, and going backwards

- **What it is.** Insert a stepping-stone statement between data and objective, prove the *easy* link first, and then attack the remaining link with whatever method suits — including contrapositive or contradiction.
- **When to reach for it.** When your objective concerns an object that is awkward to parametrize, but there is a nearby statement in your *chosen variables*.
- **Seen in action (Problem 4.5).** The objective is about $R_0$, which "does not become a 'main figure' as easily as other rectangles" (p. 65). Everything is parametrized by $R_1$'s dimensions $a\times b$. So Tao guesses the intermediate goal from the picture — $a+b=1$ — and verifies the easy half by hand. He then writes the chain out as a diagram:

```
   R₁,…,R₄ equal area  ⟹   a + b = 1   ⟹   R₀ is a square
   \______ link 1 ______/   \______ link 2 ______/
      STILL TO PROVE            PROVED (3 lines, by hand)
```

(Tao draws each of the three statements in its own box. The direction of the work is worth noticing: he proves the *second* link first, because it is the one his chosen variables make trivial, and then spends the rest of the problem on the first. "To summarize, we have shown the second implication in the chain … and it now remains to prove the first implication.")

- **Tao's own words** on why the intermediate goal is the right one: "Heuristically, we hope this goal is easier to achieve because we can put everything in terms of $a$ and $b$, while it is not that easy to put everything in terms of rectangle $R_0$" (p. 65).
- **The backward step, with its cost/benefit stated.** Since "the given data is easily reducible to formula, [but] the formula is not easily reduced to objective" (p. 65), he flips to the contrapositive ($a+b\ne1 \Rightarrow$ areas not all equal) or to contradiction ($a+b\ne1$ **and** equal areas $\Rightarrow$ absurdity). And then the honest accounting: "Notice that with a proof by contradiction, one has more data to begin with, but the end result is very open-ended and indefinite" (p. 65). That is the cleanest one-sentence statement of the contradiction trade-off in the book: you gain an extra hypothesis, you lose a target.
- **Why it works.** Programmer's analogy: this is factoring a hard function into two functions with a well-chosen intermediate data type. Choosing the intermediate type well ($a+b=1$, expressed in the variables you actually have) is most of the work.

---

## Technique 11: Inequalities instead of equalities; monotone chains around a cycle

- **What it is.** When your equalities are a system of "equal products related by additive equations" and won't budge, replace them with inequalities, and look for a quantity that changes monotonically as you go around a cycle of the configuration. Returning to the start gives "$X$ is strictly greater than $X$" — a contradiction.
- **When to reach for it.** Cyclic/rotationally-structured systems; rigidity statements; anything where the natural argument is "you can't wriggle".
- **Tao's own words.** "While equal areas may seem to be a very nice and simple thing to work with, they are actually more of a hindrance in this question, because you just have a bunch of equal products whose terms are related by additive equations" (p. 65). And the moral: "keep in mind that sometimes inequalities are easier and more efficient to use than equalities" (p. 66).
- **Seen in action.** Problem 4.5's endgame, and (per the hint) Exercise 4.4.
- **Why it works.** Equalities in a cyclic system are *consistent* by assumption, so they give you nothing locally. A strict inequality, once established at one step, is *transported* by the same cyclic structure, and cyclicity guarantees it comes back and contradicts itself. This is the geometric cousin of a "no strictly decreasing infinite sequence" / well-ordering argument, and of the loop-invariant argument that a monotone loop counter cannot return to its initial value.

---

## Technique 12: Rewrite obscure angles as "friendly" angles, and meet in the middle

- **What it is.** Classify the angles in your figure as "mainstream" (attached to several triangles/circles you understand) or "obscure" (touching nothing). Push each side of your desired equality towards the mainstream ones until they collide.
- **When to reach for it.** An angle equality between two angles that each look isolated.
- **Tao's own words.** "these particular angles $\angle DAF$, $\angle EAF$ seem a bit remote. We will need to write these obscure angles in terms of more 'friendly' angles, so that we can then relate the two angles to each other" (p. 67). And on the destination: "The angle $\angle ABF$ seems to be a more 'mainstream' angle, connected to several triangles and circles, so this is a fairly satisfying result" (p. 67).
- **Seen in action.** Problem 4.6: both $\angle DAF$ and $\angle EAF$ are independently reduced to $\tfrac12\angle ABF$.
- **The selection rule between competing decompositions** (p. 67). $\angle EAF$ can be written as $\angle BAF-\angle BAE$ or as $\angle DAB-\angle DAF-\angle BAE$. "The first equation leaves us with one rather nice angle $\angle BAE$ and one slightly worse angle $\angle BAF$. The second formulation, however, has several advantages: $\angle DAB$ is $90^\circ$, and we have already worked out $\angle DAF$." So: prefer the decomposition whose pieces are (i) known constants, or (ii) already-computed results. Reuse beats freshness.
- **Meeting in the middle, defended.** "Working out $\angle DAF$ and $\angle EAF$ and hoping that they meet somewhere in between is not all that foolish, if you know what you are doing. As long as one always tries to simplify and connect, chances are that the solution will soon fall into place" (p. 68). This is bidirectional search: don't insist on a single directed derivation from hypothesis to conclusion; simplify both ends and let them meet. The invariant that makes it safe is the two-word heuristic **"simplify and connect"**: every step must either reduce complexity or link two previously unlinked objects.
- **Failure mode / caveat.** It only works if a solution exists — and Tao appends the reassurance "Assuming, of course, that there is one—and most problems are not trying to pull your leg" (p. 68).

---

## Technique 13: Discovery is not presentation

- **What it is.** Search messily; write up cleanly.
- **Tao's own words.** "Of course, we will want to tidy this up when presenting our proof: we would probably do some long chain of equations like so: $\angle DAF = \dots = \dots = \angle EAF$. But when we are looking for a solution, we do not have to be so formal" (p. 68).
- **Why it matters.** The exploratory record (two independent computations converging on $\tfrac12\angle ABF$) and the final artifact (one chain of equalities from $\angle DAF$ to $\angle EAF$) are different documents. Confusing them makes people believe proofs are found in the order they are written, which is the single most damaging misconception about how mathematics is done. Programmer's analogy: the commit history versus the final refactored function.

---

# Worked problems

## Theorem 4.1 (Thales) — the angle subtended by a diameter is a right angle

- **Statement.** If $AB$ is a diameter of a circle and $P$ is any other point on it, then $\angle APB=90^\circ$.
- **Chain of moves.**
  1. Draw the segment $OP$ from the centre to $P$. `[chain obvious facts: add the one line that makes known facts applicable]`
  2. Observe $|OP|=|OA|$ and $|OP|=|OB|$ — all radii — so triangles $APO$ and $OPB$ are isosceles. `[translate lengths to angles via the isosceles rule]`
  3. Hence $\angle APO=\angle PAO$ and $\angle OPB=\angle PBO$.
  4. Sum: $\angle APB = \angle APO+\angle OPB = \angle PAO+\angle PBO = \angle PAB+\angle PBA$.
  5. Apply the angle sum of triangle $APB$: $\angle PAB+\angle PBA = 180^\circ-\angle APB$. `[angle-sum escape hatch]`
  6. So $\angle APB=180^\circ-\angle APB$, giving $\angle APB=90^\circ$.
- **Transferable lesson.** The whole proof is *one auxiliary line* plus two lookups. Adding the segment $OP$ is the entire creative content, and it was chosen because it creates the objects (isosceles triangles) that the available facts talk about. When stuck, ask not "what's clever" but "what one addition would make my known theorems applicable?"

---

## Problem 4.1 (Australian Mathematics Competition 1987, p. 12) — bisectors in a circle

**Statement in full.** Triangle $ABC$ is inscribed in a circle. The angle bisector from $A$ is extended until it meets the circle again, at $D$; similarly the bisector from $B$ meets the circle again at $E$, and the bisector from $C$ at $F$. Prove that the line $AD$ is perpendicular to the line $EF$.

**The diagram (p. 50).** One circle. On it, six points: going roughly clockwise from the top, $E$ (top), $A$ (upper right), $F$ (lower right), $B$ (bottom), $C$ (left). Inside, the three bisectors $AD$, $BE$, $CF$ all pass through one point, the incentre $I$ (near the centre of the figure). $D$ is on the circle on the far side of $I$ from $A$, i.e. on the arc between $B$ and $C$. The chord $EF$ runs from the top down to the lower right, crossing $AD$ at a point $M$ between $A$ and $I$.

```
                 E
        _____--- * ---_____
      /                     \  A          α = ∠BAC, β = ∠ABC, γ = ∠BCA
     |                    M *  *          AD bisects α,  BE bisects β,  CF bisects γ
     |   C *                 \  |         I = incentre (all three bisectors meet)
     |       \        * I -----/ |        M = AD ∩ EF   ← the right angle lives here
     |        \      / \        * F
      \        \    /   \      /
        ---____ \  /     \ ___/
                 * B      (D on arc BC, on ray A→I)
```

- **The data / the objective.** Data: three angle bisectors, all chords of one circle. Objective as given: a perpendicularity. Objective after naming $M$: "$\angle AMF = 90^\circ$" — an equation (p. 51). `[name the unnamed point; convert objective to an equation]`
- **The chain of moves.**
  1. Draw and label; add $I$ (the incentre — "likely to be important") and $M$. `[technique 2, 3]`
  2. Triage: the diagram is easy to draw and the conclusion is visually obvious, so try the forward approach. `[technique: triage from the diagram]`
  3. Take stock of available theorems: angle sum in a triangle; the angle subtended by a chord on an arc is constant; the bisectors are concurrent. `[inventory the toolkit before starting]`
  4. Choose the reference frame: $\alpha=\angle BAC$, $\beta=\angle ABC$, $\gamma=\angle BCA$, with $\alpha+\beta+\gamma=180^\circ$. `[main figure / basis]`
  5. Flood-fill: fill in every angle you can. E.g. $\angle CAD=\alpha/2$ because $AD$ bisects $\angle A$; and in triangle $AIC$, whose angles at $A$ and $C$ are $\alpha/2$ and $\gamma/2$, the third angle is $\angle AIC=180^\circ-\alpha/2-\gamma/2$. Tao's aside: "It is best if you draw a sketch of the figure and fill in the angles yourself." `[flood-fill the cheap quantities]`
  6. **The obstruction.** "In fact we can get virtually all relevant angles—except those at $M$, which are the ones we really want" (p. 51). $M$ is an intersection of two chords with no special status.
  7. **The unblocking move.** Express the angle at $M$ using only angles away from $M$. Use the triangle $IMF$: its three angles sum to $180^\circ$, so
  $$\angle IMF = 180^\circ-\angle MIF-\angle IFM = 180^\circ - \angle AIF - \angle CFE.$$
  (Here $\angle MIF=\angle AIF$ because $M$ lies on segment $AI$, so the rays $IM$ and $IA$ are the same ray; and $\angle IFM=\angle CFE$ because $I$ lies on $FC$ and $M$ lies on $FE$, so those are literally the same angle.) `[angle-sum escape hatch; represent obscure in terms of non-obscure]`

     Tao then does something worth imitating: he *states, in the middle of the derivation, why this counts as progress.* "**This is progress because** the two angles $\angle AIF$ and $\angle CFE$ are much more easily worked out" (p. 51). Not "and now we compute", but an explicit justification that the rewrite moved the problem into cheaper territory. Making that claim out loud is a cheap correctness check on your own strategy: if you cannot say why a step is progress, it probably isn't. (He does it again on p. 54 — "we must be heading in the right direction" — and the two instances together are technique #68.)

     Note also the hedge "we could say, **for example**, that $\angle IMF$ … can be written as …" — there are four angles at $M$ and several triangles to route through; he picks one and moves on rather than searching for the best. Any of them would do, because all four angles at $M$ are $90^\circ$ or $180^\circ-90^\circ$ together.
  8. Compute the two replacements. First, $\angle AIF$ is supplementary to $\angle AIC$ (because $C$, $I$, $F$ are collinear — that's what "the bisector from $C$ meets the circle at $F$" means), so
  $$\angle AIF = 180^\circ-\angle AIC = \alpha/2+\gamma/2.$$
  9. Second, $\angle CFE$ and $\angle CBE$ are both subtended by the same chord $CE$, from two points ($F$ and $B$) on the same arc, so they are equal by the inscribed angle theorem. And $\angle CBE=\beta/2$ because $BE$ bisects $\angle B$. So
  $$\angle CFE=\angle CBE=\beta/2.$$
  (Tao phrases the licence as "because equal chords subtend equal angles"; the operative fact is that *the same* chord $CE$ subtends equal angles at $F$ and at $B$.) `[inscribed angle theorem as the circle↔angle exchange rate]`
- **The resolution.**
$$\angle IMF = 180^\circ-\frac{\alpha}{2}-\frac{\beta}{2}-\frac{\gamma}{2} = 180^\circ-\frac{\alpha+\beta+\gamma}{2}=180^\circ-\frac{180^\circ}{2}=90^\circ.$$
The half-angles of the three corners sum to $90^\circ$ — that's the whole engine. Since $\angle IMF$ is one of the four angles at $M$ formed by the crossing chords $AD$ and $EF$, having it equal $90^\circ$ means $AD\perp EF$.
- **Transferable lesson.** *When the quantity you need lives at a featureless point, don't attack it: surround it.* Put it in a triangle with two computable angles and let the angle sum deliver it. More generally: the reason the flood-fill was not wasted effort is that the flood-fill is what made step 7 possible — you compute everything cheap first precisely so that the expensive thing becomes a subtraction.

---

## Problem 4.2 (Taylor 1989, p. 8, Q1) — two equal bisector segments

**Statement in full.** In triangle $BAC$, the bisector of the angle at $B$ meets side $AC$ at $D$; the bisector of the angle at $C$ meets side $AB$ at $E$. The two bisectors cross at $O$ (the incentre). Given that $|OD|=|OE|$, prove that either $\angle BAC=60^\circ$, or triangle $ABC$ is isosceles (or both).

**The diagrams (p. 52).** Two side-by-side pictures of a triangle with $A$ at the bottom-left, $B$ at the bottom-right, $C$ at the top. $D$ sits on side $AC$ (upper left), $E$ sits on side $AB$ (bottom edge), and the two cevians $BD$ and $CE$ cross at $O$ inside. The left picture is drawn wide and flat, the right one tall and narrow; the book does **not** label which of the two illustrates which case, and neither drawing is obviously isosceles by eye. The point of printing two is only technique #12 — the data admits genuinely different-looking configurations, so draw more than one before forming any beliefs about the figure.

```
            C                        The two cevians:
            |\                         BD  (bisects ∠B)   D on AC
            | \                        CE  (bisects ∠C)   E on AB
          D *  \                     They meet at O.
            | \  \                   Given: |OD| = |OE|
            |  *O \                  α = ∠BAC, β = ∠ABC, γ = ∠ACB
            | /   \\
            |/      \\
        A --*---------* B
              E
```

- **The data / the objective.** Data: exactly one fact, $|OD|=|OE|$ — a length equality. Objective: a **disjunction** of two properties. Tao's framing: "We have only one piece of data … and we wish to prove a strange looking result: a choice of two properties about our triangle" (p. 52).
- **The chain of moves.**
  1. Draw the picture — but this is hard, because you must arrange $|OD|=|OE|$ by hand. **Cheat:** draw the special cases you're trying to prove. "we can cheat a bit by making $ABC$ isosceles or $\angle BAC=60^\circ$ (since we know that is what is supposed to happen anyway)" (p. 52). Draw both. `[cheat the diagram; draw several configurations]`
  2. Decide the currency by reading the objective: both alternatives ("$60^\circ$", "isosceles") are angle facts, since isosceles triangles are characterized by equal base angles. "so one can assume this to be an angle problem (at first, anyway)" (p. 52). `[objective determines the currency]`
  3. Fix the reference frame: $\alpha=\angle BAC$, $\beta=\angle ABC$, $\gamma=\angle ACB$; goal is $\alpha=60^\circ$ or $\beta=\gamma$. `[main figure]`
     - *Reader beware, a slip in the book:* on p. 52 the goal is written as "either $\beta=60^\circ$ or $\alpha=\gamma$", which swaps the roles of the letters he just defined. The version that matches his own definitions — and the one he actually derives on p. 54 — is **$\alpha=60^\circ$ or $\beta=\gamma$**.
  4. **Dead end #1.** Translate $|OD|=|OE|$ the obvious way: triangle $ODE$ is isosceles, so $\angle ODE=\angle OED$. Abandoned: "it is quite hard to equate the angles $\angle OED$ and $\angle ODE$ to any other angles" (p. 52), and in particular they don't express in terms of $\alpha,\beta,\gamma$. `[abandon a translation that doesn't connect]`
  5. Screen the other length↔angle exchange rates (p. 53). Basic trigonometry — needs right angles/circles, not present. Similar triangles — few available. Isosceles/equilateral — just tried. Cosine rule — "usually complicates rather than simplifies, and it just creates more unknown lengths". Sine rule — survives, and "it relates sides to angles quite directly". `[screen candidate tools against preconditions]`
  6. Choose the triangles to apply it in. Tao's stated requirements: a triangle that (i) contains $OD$ or $OE$ **and** (ii) "ha[s] a lot of angles that we already know". How the candidate list is generated: "**Looking at the diagram, and measuring out angles**, we can guess that the triangles $AOD$, $COD$, $AOE$, $BOE$ could be useful" (p. 53) — i.e. eyeball and measure the drawing to propose candidates. Then pick $AOD$ and $AOE$ **because they share the side $OA$** — a connection, and the future elimination variable. `[pick the sub-figure that is already mostly filled in; measure the diagram to generate candidates; look for connections]`
  7. Draw a reduced diagram of just $A,D,E,O$, rotated and enlarged, and fill in its angles. `[reduced diagram]`

     **The reduced figure (p. 53):** a kite-shaped quadrilateral $A$–$D$–$O$–$E$ with the diagonal $AO$ drawn horizontally: $A$ at the far left, $O$ at the far right, $D$ at the top, $E$ at the bottom.

     ```
                      D
                    /   \        at D:  ∠ADO = γ + β/2
                  /       \      at A:  ∠DAO = α/2   (above the diagonal)
                /           \           ∠EAO = α/2   (below the diagonal)
           A *---------------* O  at O: ∠AOD = (α+β)/2
                \           /            ∠AOE = (α+γ)/2
                  \       /        at E: ∠AEO = β + γ/2
                    \   /
                      E
     ```

     How those are computed: $\angle EAO=\angle DAO=\alpha/2$ since $AO$ is the bisector from $A$ (the third bisector — the incentre lies on all three). Then in triangle $AEC$: the angle at $A$ is $\alpha$, the angle at $C$ is $\gamma/2$, so $\angle AEC=180^\circ-\alpha-\gamma/2$; and since $O$ lies on $CE$, $\angle AEO$ is that same angle, which using $\alpha+\beta+\gamma=180^\circ$ equals $\beta+\gamma/2$. Symmetrically $\angle ADO=180^\circ-\alpha-\beta/2=\gamma+\beta/2$. The angles at $O$ then follow from the angle sums: $\angle AOD=180^\circ-\alpha/2-(\gamma+\beta/2)=(\alpha+\beta)/2$ and $\angle AOE=(\alpha+\gamma)/2$.
     - *Reader beware, a second slip:* the printed figure on p. 53 labels the angle at $D$ as "$(\gamma+\beta)/2$" and the one at $E$ as "$(\beta+\gamma)/2$" — which would make them equal and is not what the surrounding text or the subsequent algebra says. The body text (p. 53) and the sine-rule equations (p. 54) both use $\gamma+\beta/2$ and $\beta+\gamma/2$, which is what the angle sums give. Read the figure labels as $\gamma+\beta/2$ and $\beta+\gamma/2$.
  8. Apply the sine rule in each of the two triangles:
  $$\frac{|OD|}{\sin(\alpha/2)}=\frac{|OA|}{\sin(\gamma+\beta/2)}=\frac{|DA|}{\sin(\alpha/2+\beta/2)},\qquad
    \frac{|OE|}{\sin(\alpha/2)}=\frac{|OA|}{\sin(\beta+\gamma/2)}=\frac{|EA|}{\sin(\alpha/2+\gamma/2)}.$$
  (In triangle $AOD$: side $OD$ is opposite the angle $\alpha/2$ at $A$; side $OA$ is opposite the angle $\gamma+\beta/2$ at $D$; side $DA$ is opposite the angle $(\alpha+\beta)/2$ at $O$.) `[sine rule as the length↔angle dictionary]`
  9. **Eliminate the shared unknown.** "The length $|OA|$ appears in both of the above sets of equations, so we should perhaps put $|OD|$ and $|OE|$ in terms of $|OA|$" (p. 54):
  $$|OD|=|OA|\frac{\sin(\alpha/2)}{\sin(\gamma+\beta/2)},\qquad |OE|=|OA|\frac{\sin(\alpha/2)}{\sin(\beta+\gamma/2)}.$$
  Now $|OA|$ and $\sin(\alpha/2)$ cancel and the data becomes
  $$|OD|=|OE| \iff \sin(\gamma+\beta/2)=\sin(\beta+\gamma/2).$$
  `[eliminate the common variable]`
  10. **Guard the degenerate cases.** "Actually, something silly could happen such as $\sin(\alpha/2)=0$. It does not take long to see that these situations only exist in extremely degenerate cases, and these freak cases are easily dealt with separately. But always remember to watch out for these things" (p. 54). `[degenerate-case hygiene]`
  11. **Read the progress signals.** Two of them: the data is now an *angle* equality in exactly the variables the objective is about ("these angles are relevant to our objective … so we must be heading in the right direction"), and "The question is now almost completely algebraical." `[progress signals]`
- **The resolution.** Two angles have the same sine, and (both being between $0^\circ$ and $180^\circ$) this leaves exactly two possibilities:
$$\gamma+\beta/2=\beta+\gamma/2 \qquad\text{or}\qquad \gamma+\beta/2=180^\circ-(\beta+\gamma/2).$$
The first gives $\gamma/2=\beta/2$, i.e. $\beta=\gamma$ — the base angles at $B$ and $C$ are equal, so $|AB|=|AC|$ and the triangle is isosceles. The second gives $\tfrac32(\beta+\gamma)=180^\circ$, so $\beta+\gamma=120^\circ$ and hence $\alpha=180^\circ-120^\circ=60^\circ$. Exactly the two alternatives asked for. Tao's own reaction: "We are getting closer and closer to our objective; the sines are gone, and we have also for the first time gotten a statement that involves an 'or'. … And we have managed, strangely enough, to stumble onto our objective" (p. 54).
- **Transferable lesson.** Two lessons, both large.
  1. **The disjunction in the conclusion was a fingerprint of the technique.** A conclusion of the form "$P$ or $Q$" usually comes from a step in the proof that is genuinely two-valued — here, $\sin X=\sin Y$. If your objective is a disjunction, hunt for the multivalued step (a square root, an absolute value, a sine, a quadratic) that will manufacture it. Conversely, if you're mid-proof and an "or" appears for the first time, that is evidence you're on the right track.
  2. **Choose your translation for connectivity, not correctness.** The isosceles translation of $|OD|=|OE|$ was perfectly true and completely useless. The sine-rule translation was chosen because its output lands in the coordinate system ($\alpha,\beta,\gamma$) that the objective is written in.
- Tao closes by naming the method: "Sometimes, we can just leap on our given data and hammering it into an equation resembling our objective … and then applying simple algebra to change it to what we want. This is called the *direct* or *forward* approach" (pp. 54–55).

---

## Problem 4.3\* (Australian Mathematics Competition 1987, p. 13) — three ratios in a rectangle

**Statement in full.** $ABFE$ is a rectangle (so its sides are $AB$, $BF$, $FE$, $EA$), and $D$ is the point where its two diagonals $AF$ and $BE$ cross — i.e. the centre of the rectangle. A straight line is drawn through the vertex $E$; it meets the extension of the line $AB$ at a point $G$, and the extension of the line $FB$ at a point $C$. It is given that $|DC|=|DG|$. Prove that
$$\frac{|AB|}{|FC|}=\frac{|FC|}{|GA|}=\frac{|GA|}{|AE|}.$$
(Marked $(*)$ = harder.)

**The diagram (p. 55).** The rectangle has $B$ top-left, $A$ top-right, $E$ bottom-right, $F$ bottom-left, and $D$ at its centre. The top side extends rightwards past $A$ to $G$; the left side extends downwards past $F$ a long way to $C$. The straight line $C$–$E$–$G$ runs from bottom-left, through $E$, up to the top-right at $G$. Also drawn: both diagonals $AF$ and $BE$ (crossing at $D$), plus $DC$ and $DG$.

```
    B ________________ A ______ G
     |\             /  |     /
     |  \    D    /    |   /
     |    \  *  /      | /
    F|______\/_________|/            (F, B, C are collinear: C is far below F)
     |      /\        E              (A, B, G are collinear: G is right of A)
     |    /                          Line C–E–G is straight.
     |  /                            Given |DC| = |DG|.
     |/
    C
```

- **The data / the objective.** Data: a rectangle (four right angles) and the odd fact $|DC|=|DG|$. Objective: a three-term chain of equal ratios. Tao's assessment: "with seemingly barely enough data to go on, and something quite obscure to prove" (p. 57).
- **The chain of moves.**
  1. Try tier 0 first: "**Simply drawing a figure and guessing conclusions is helpful sometimes**, but a figure is quite hard to draw in this case. How do you force it so that $|DC|=|DG|$?" (p. 55). So the cheapest method — draw it and read the answer off the picture — is *attempted and reported as failing*, and the reason it fails (the hypothesis can't be imposed freehand) is the diagnostic that will send him past the forward approach too. Fix: work backwards from the answer. "A bit of trial and error (and taking a peek at the conclusion $|AB|/|FC|=|FC|/|GA|=|GA|/|AE|$) eventually allows one to draw a decent picture" (p. 55). `[try to guess conclusions from the figure; draw the figure by peeking at the conclusion]`
  2. **Dead end #1: coordinates.** Available, but "long and boring … prone to abysmal complications and huge errors. Let us try that as a last resort" — while noting the best origin would be the right angle at $A$. `[rank brute force, keep in reserve]`
  3. **Dead end #2: vectors.** "not suited too well with equations like $|DC|=|DG|$" (a vector formalism handles linear relations well and length equalities badly), though "the vector versions are still usually neater than the coordinate counterparts". `[same]`
  4. **Dead end #3: the forward approach.** "How about measuring lines and angles? We only know that we have four right angles on the rectangle, and we also know $|DC|=|DG|$. So, maybe $DCG$ is isosceles, but that does not say much. Dropping perpendiculars from $D$ to $CG$ or doing other similar constructions are not much help either" (p. 56). Tao then makes the honest confession that the eventual key construction is *not* findable this way: "(As we shall see later on, a certain construction does help, but it is definitely not intuitively obvious in the forward approach.)" `[forward approach explicitly declared dead]`
  5. **Switch to backward.** "Backwards we go then. We want to prove that three ratios are equal to each other. **This suggests similar triangles**" (p. 56). `[let the form of the objective name the tool]`
  6. Look for a triangle containing the sides in the ratios. $AB$ and $FC$ don't span a triangle. But **substitute an equal length**: $|FE|=|AB|$ (opposite sides of a rectangle) and $FE$, $FC$ *are* two sides of triangle $FCE$. `[substitute an equal quantity to join a triangle]`
  7. "Once we recognize one triangle, the other two should not be too hard." From the diagram, triangle $FCE$ is similar to $BCG$ and to $AEG$. (Reason: all three are right-angled — at $F$, at $B$, at $A$ respectively, since $FE\perp FC$, $BG\perp BC$, $AE\perp AG$ — and they all share the acute angle cut by the single straight line $C$–$E$–$G$. Two right triangles sharing an acute angle are similar.) Hence
  $$\frac{|EF|}{|FC|}=\frac{|GB|}{|BC|}=\frac{|GA|}{|AE|}.$$
  8. Convert using $|EF|=|AB|$, "keeping our goal in mind":
  $$\frac{|AB|}{|FC|}=\frac{|GB|}{|BC|}=\frac{|GA|}{|AE|}. \tag{15}$$
  Two of the three ratios in the objective — $|AB|/|FC|$ and $|GA|/|AE|$ — are now known equal, **without using the hypothesis $|DC|=|DG|$ at all**. So the whole content of that hypothesis must go into the remaining ratio.
  9. **Reformulate the remaining objective.** The missing ratio $|FC|/|GA|$ won't fit into a triangle. But notice the middle ratio of (15): "The pair of edges look vaguely related to $FC$ and $GA$. In fact $FC$ is a segment of $BC$ and $GA$ is a segment of $BG$." So instead of proving $|AB|/|FC|=|FC|/|GA|$ or $|FC|/|GA|=|GA|/|AE|$, prove
  $$\frac{|FC|}{|GA|}=\frac{|GB|}{|BC|}.$$
  "Besides, this formulation is more symmetric and involves only one equality" (p. 56). `[reformulate the objective: symmetric, single equality]`
  10. **Massage it algebraically.** Cross-multiply: $|FC|\times|BC|=|AG|\times|BG|$. Or swap: $|FC|/|BG|=|GA|/|BC|$. Tao's verdict on the second: "This does not seem to be much of an improvement." `[algebraic massage of the objective]`
  11. **The memory trigger.** "But the terms $|FC|\times|BC|$ and $|AG|\times|BG|$ might look a little familiar. In fact one might be reminded of the following result (which is usually in high-school textbooks but rarely used there)" — and out comes Theorem 4.2, the power of a point. `[look for things that vaguely trigger a memory]`

     What made it fire: each side is a product of **two lengths measured from a single point along a single straight line** ($C$ along the line $C$–$F$–$B$; $G$ along the line $G$–$A$–$B$). That is precisely the left-hand side of the power-of-a-point theorem.
  12. **Construct the object the theorem needs.** "To use Theorem 4.2, we first need to create a circle. We want to evaluate $|FC|\times|BC|$ and $|AG|\times|BG|$. The circle must hence include the points $F$, $B$, and $A$" — because those are the four intersection points appearing in the two products. Then the payoff: "Now it just so happens that the circle touching the points $F$, $B$, and $A$ has $D$ as its centre (Theorem 4.1!)" (p. 57). `[construct the object the theorem needs; recognize the trigger configuration]`

     Why $D$ is the centre: $\angle ABF=90^\circ$ (a corner of the rectangle), so by the *converse* of Thales, $B$ lies on the circle whose diameter is $AF$. The centre of that circle is the midpoint of $AF$ — which is $D$, since $D$ is where the diagonals cross and the diagonals of a rectangle bisect each other. So one circle, centre $D$, radius $r=|AF|/2$, passes through $A$, $B$, $F$ (and $E$ too).
- **The resolution.** Apply the power of the point $C$: the line through $C$ hitting the circle at $F$ and $B$ gives
$$|FC|\times|BC|=|DC|^2-r^2.$$
Apply the power of the point $G$: the line through $G$ hitting the circle at $A$ and $B$ gives
$$|AG|\times|BG|=|DG|^2-r^2.$$
"And as we are conveniently given the fact that $|DC|=|DG|$, our result is proved." The two right-hand sides are equal, so $|FC|\times|BC|=|AG|\times|BG|$, which is the reformulated objective, which combines with (15) to give the full chain of three equal ratios.

  *(Small typo to be aware of: on p. 58 Tao writes the objective as "$|FC|\times|BC| = |AG|\times|DG|$"; the $|DG|$ should be $|BG|$, as on p. 56.)*
- **Transferable lesson.** Several, and this is the richest problem in the chapter:
  1. **The hypothesis tells you where the hard part is.** Everything provable without $|DC|=|DG|$ came out in two lines from similar triangles. So the exotic hypothesis had to be the key to the one remaining piece. Tao states the principle generally: "try to steer your way towards unusual data or objectives … After all, one would presumably need all the data to deduce all the objectives, so each piece of data must be invoked in some way" (p. 58).
  2. **Rewriting the goal is cheap; rewriting the data is expensive.** Five successive rewrites of the objective (similar triangles → equation (15) → a different pairing → cross-multiplied → matched to a theorem) cost nothing and eventually produced a syntactic match to a stored theorem.
  3. **Distances-from-a-point that multiply ⇒ think circle.** That's the trigger to attach to Theorem 4.2 forever.
  4. **The theorem needed an object that wasn't in the problem.** The circle appears nowhere in the statement. This is why Tao says the construction "is definitely not intuitively obvious in the forward approach" — you find it by working backwards from the theorem you want to use, not forwards from the figure.

**Tao's metacommentary paragraph (p. 58) — unpacked.** This is the densest paragraph of advice in the chapter. It contains:
- **The general shape of hard synthetic problems:** "with seemingly barely enough data to go on, and something quite obscure to prove, one usually needs a special way to do it. A construction or something might make it clear."
- **The instruction to trawl memory on weak signals:** "Look for things that vaguely trigger a memory."
- **The equivalence dictionary** (angle equality ↔ cyclic; length inequality ↔ angle inequality; area facts) — see Technique 6 above.
- **A brake on brute-force construction:** "This does not mean that you should construct every possible extension to the diagram you can think of, and write down a barrage of facts (unless you are really stuck), but an educated guess and a few sketches can work." Note the parenthetical: when *really* stuck, barrage is sanctioned. It's a last resort, not a forbidden move.
- **Special/extreme cases as an idea generator:** try $ABEF$ square, or degenerate, or $|DC|=|DG|=0$. (Note the letters: the problem statement on p. 55 calls the rectangle $ABFE$, but p. 58 twice writes $ABEF$ for the same object. Same rectangle; the book is just inconsistent about the cyclic order of the vertices. Don't waste time looking for a second quadrilateral.) It's worth asking *what each special case buys*, since Tao doesn't: making $ABEF$ a square adds a symmetry that ties $|AB|$ to $|AE|$ so the three-term ratio chain collapses; the degenerate rectangle sends one dimension to $0$ and turns ratios into limits; and $|DC|=|DG|=0$ forces $C=G=D$, which is impossible here but is the kind of boundary probe that reveals *which* configurations the hypothesis really permits.
- **Keeping data and objective simultaneously in view** — the geometric version of working from both ends.
- **The honest admission that inspiration is experience-gated and late** ("these things also come to mind usually only after all other means have failed"), plus the fallback plan (coordinates, or pseudo-coordinates).

---

## Problem 4.4 — an equilateral triangle across three parallel lines

**Statement in full.** Three parallel lines $l_1,l_2,l_3$ are given. Using only straightedge and compass, construct an equilateral triangle with one vertex on each of the three lines.

**The diagram (p. 59).** On the left, three horizontal parallel lines $l_1$ (top), $l_2$ (middle), $l_3$ (bottom), with a "?" above an arrow pointing right. On the right, the answer: an equilateral triangle with vertex $A$ on $l_1$ (upper right), vertex $B$ on $l_2$ (left), vertex $C$ on $l_3$ (bottom right); the side $AC$ crosses $l_2$, and the triangle leans over so that $B$ sticks out well to the left.

```
   ______________ l₁          ___________ A ____ l₁
                                        /|\
   ______________ l₂    ?     ____ B __/_|_\___ l₂
                        ==>       \    /   \
                                    \ /     \
   ______________ l₃          _______\/______\_ l₃
                                             C
```

- **The data / the objective.** Data: three parallel lines. Objective: a construction — which means the answer is a *recipe*, not a proof.
- **The chain of moves.**
  1. Note the disguise: "At first glance this question looks simple and straightforward (good problems usually do)" (p. 58). Then try to draw it and discover it's hard — and note that Tao gives an *instruction with a trap in it*: "as soon as one tries to draw a picture (**try it, but draw the parallel lines first**) one can see how tricky it really is to fit a triangle with as many requirements as an equilateral triangle. It is just too rigid." The parenthetical is the whole experiment. If you draw the triangle first the problem feels trivial (any equilateral triangle has three vertices, and you can always draw three parallel lines through them); drawing the *lines* first is what exposes the difficulty. Ordering your experiment correctly is what makes it informative.
  2. Then explore before theorising: "**After experimenting with circles, $60^\circ$ angles, and the like, we should see that something special is needed.**" So there is a documented phase of unsuccessful poking around whose only output is the *judgement* that routine tools won't do it. That judgement is a real deliverable — it is what licenses the more expensive locus/transformation machinery, and it is exactly the phase most write-ups delete.
  3. Draw the picture anyway, backwards: "Nevertheless, let us try to draw a picture as best we can (perhaps by drawing the equilateral triangle first, and then erasing it), and labelling everything" (p. 58–59). `[draw by peeking at the conclusion; label everything]`
  4. **Dead end #1: coordinates.** "One obvious guess is to use coordinate geometry. Well, this is possible, but messy. You will end up using the quadratic formula to evaluate the positions of the points, and this is not the best (or most geometrical) way to do it. As usual, we save that as a last resort" (p. 59). Note the *specific* prediction of what the mess will be — a quadratic formula, i.e. two roots and a square root — and note that this prediction turns out to be exactly right: the finished construction really does have two solutions per choice of $A$ ("clockwise or anti-clockwise"). Predicting the *shape* of the brute-force answer is a cheap way to know what a good answer should look like. `[rank brute force]`
  5. Recall the standard method: "the standard way to solve construction questions is to take one of the unknowns (a point, line, triangle, or maybe something else) and determine a locus or other easily constructible property" (p. 59). `[locus]`
  6. **But first, just stare at the figure.** "But before we do that, let us just stare at the diagram and try to do what we can." Observation: "an equilateral triangle, if there was one, could be slid along the parallel lines and still satisfy all the requirements. So, if the triangle was $ABC$, then the location of $A$ is really arbitrary, as long as it is on line $l_1$." Then the crucial justification, which is the part usually skipped: "Of course, $B$ and $C$ will have to depend on the placing of $A$. So essentially we can place $A$ wherever we like **and not worry about missing anything**, and then worry about $B$ and $C$." That clause is a *no-loss-of-generality certificate*: because the whole configuration slides, fixing $A$ arbitrarily cannot destroy any solution — every solution is a slid copy of one with your chosen $A$. Spending a degree of freedom is only legitimate when you can say that sentence. Consequence: "A bit of thought now shows that the line $l_1$ is no longer relevant; it is only needed to constrain $A$, but once we pick $A$ to be an arbitrary point on $l_1$, we do not need $l_1$ any more" (p. 59). `[spend the free degree of freedom, with a no-loss certificate; a constraint becomes vacuous]`
  7. **Count — and tolerate not knowing.** "Now, with an anchor on $A$, the triangle is a bit more restricted. Perhaps this restriction could force $B$ and $C$ into a limited number of positions. **We do not know yet.**" Then the count: with $A$ fixed, the equilateral triangle has 2 degrees of freedom (orientation and size) and 2 anchors ($B\in l_2$, $C\in l_3$). "This theoretically should be enough to restrict the triangle, but with an object as complex as a triangle, it is hard to see where to go next" (p. 59). Two separate things to take from this: (a) a d.o.f. count gives you *plausibility*, not a method — 2 equations in 2 unknowns generically has finitely many solutions, and that is all you learn; (b) "we do not know yet" is written down rather than resolved. Being explicit about which of your beliefs are still provisional is what lets you keep making moves without either stalling or fooling yourself. `[degrees of freedom vs. anchors; proceed provisionally]`
  8. **Shift the unknown.** "But what we can do is to shift the unknown into another unknown more easily evaluated. Currently the unknown is the equilateral triangle. What about something simpler? The simplest geometrical object is a point. So, we could work out $B$, for example, instead of the entire triangle. $B$ has only one degree of freedom, as it is restricted to be on $l_2$" (p. 59). `[shift the unknown to a point]`
  9. **Replace the complicated anchor by a transformation.** Tao asks the question explicitly — "What is the anchor on $B$?" — and answers it: "The anchor is the fact that the equilateral triangle with base $AB$ must have its third vertex (i.e. $C$) on $l_3$. **This anchor is complicated and it still involves the equilateral triangle.**" That diagnosis (the constraint still mentions the object you were trying to get rid of) is what motivates the next move: "Is there an easier way to represent $C$ in terms of $A$ and $B$? Yes: $C$ is the image of $B$ after rotation of $60^\circ$ through $A$ (either clockwise or anti-clockwise)" (pp. 59–60). `[replace a relation by a transformation]`

     This is the key reframing. "Equilateral triangle $ABC$" is a relation among three points; "$C = R_{A,60^\circ}(B)$" is a *function applied to one point*. Functions can be inverted; relations can't.
  10. The problem is now reduced (Tao boxes the reduction, p. 60): *Given a point $A$ and two parallel lines $l_2,l_3$ not passing through $A$, find a point $B$ on $l_2$ such that the rotation of $B$ through $A$ by $60^\circ$ falls on $l_3$.* And he cashes the reduction in immediately: "We now have only one unknown—the point $B$. So there are less degrees of freedom, and the question should be simpler." `[modify the problem: reduce to a simpler equivalent]`
  11. Write the two conditions on $B$:
      - (a) $B$ lies on $l_2$.
      - (b) The rotation of $B$ by $60^\circ$ about $A$ lies on $l_3$.
  12. **Invert condition (b).** "Condition (b) is not in a usable form, unless you invert it: (b′) $B$ is on the inverse rotation of $l_3$ by $60^\circ$ through $A$" (p. 60). Write $l_3'$ for the image of $l_3$ under the *inverse* $60^\circ$ rotation about $A$ — "either clockwise or anti-clockwise", which is where the two solutions come from. `[invert the condition so the unknown is the subject]`
  13. Now both conditions have the form "$B$ is on …", so intersect the loci: **$B = l_2 \cap l_3'$.** "…or in other words $B$ is the intersection point of $l_2$ and $l_{3'}$. And that is it! We have constructed $B$ explicitly, so the triangle should easily follow."
- **The resolution (Tao's boxed construction, p. 60).** Prefaced by "**Just for completeness**, here is the entire construction:" — i.e. the box is a tidied-up restatement, not the discovery, which is technique #61 again in miniature. Verbatim: choose any point $A$ on $l_1$. Rotate the whole line $l_3$ about $A$ by $60^\circ$ (clockwise or anti-clockwise — "there are two solutions of $B$ for each given $A$"); let $B$ be where that rotated line crosses $l_2$. Rotate $B$ backwards by $60^\circ$ about $A$ to get $C$. Then $ABC$ is equilateral by construction ($|AB|=|AC|$ because rotation preserves distance, and $\angle BAC=60^\circ$, and an isosceles triangle with apex $60^\circ$ is equilateral), $A\in l_1$ by choice, $B\in l_2$ by construction, and $C\in l_3$ because $B$ was on the rotated copy of $l_3$.

  Diagram of the reduced problem (p. 60): $A$ marked with an $\times$ above $l_2$; on the right, the solved version shows $A$ above $l_2$, $B$ on $l_2$ to the left, $C$ on $l_3$ below, with the $60^\circ$ angle marked at $A$ between $AB$ and $AC$.
- **Post-mortem: the red herring.** "It can be noted that this construction also works if the lines were not parallel, so long as they are not at $60^\circ$ angles to each other. So the parallelism was in fact a red herring!" (p. 61) `[audit unused hypotheses]`

  Why parallelism was never used: the construction only ever needed $l_2$ and the rotated $l_3'$ to *intersect in one point*. Rotating $l_3$ by $60^\circ$ changes its direction by $60^\circ$; the construction fails only if $l_3'$ ends up parallel to $l_2$, i.e. if $l_3$ and $l_2$ were already at $60^\circ$. Note the technique: after solving, go back and check which hypotheses your solution actually consumed. Unconsumed hypotheses mean either (a) the problem was stated in a special case for the solver's convenience, or (b) you've made an error. Here it's (a) — and identifying it upgrades your result to a stronger theorem for free.
- **Transferable lesson.**
  1. **Solve for the simplest unknown that determines everything else.** Not the simplest unknown (a vertex, in Exercise 4.3, is too weak), and not the object you were asked for (too complex). The sweet spot is the simplest *determining* object.
  2. **Turn relations into functions, then invert.** "$B$'s image is in $S$" → "$B$ is in the preimage of $S$". This is the same move as `filter(x => S.contains(f(x)))` becoming `f_inverse(S).intersect(domain)` — you push the transformation onto the constraint instead of applying it to a candidate you don't have yet.
  3. **Constraints as sets, construction as intersection.** Tao's algebra analogy makes this exact: solve *each* equation for the *same* variable, then intersect the solution sets. Eliminate the other variables one at a time.

---

## Exercise 4.1 (p. 61) — a chord bisected by an intersection point

**Statement in full.** Two circles $k$ and $l$ meet at two points $P$ and $Q$. Construct a line $m$ through $P$ (not through $Q$) such that, if $m$ meets $k$ again at $B$ and meets $l$ again at $C$, then $|PB|=|PC|$. **Tao's hint: solve for $B$.**

**The figure (p. 61).** Left: two overlapping circles $k$ (left) and $l$ (right), meeting at $P$ (top) and $Q$ (bottom), with a "?" arrow. Right: the same two circles with a horizontal line $m$ drawn through $P$, hitting $k$ again at $B$ on the far left and $l$ again at $C$ on the far right, so that $P$ is the midpoint of $BC$.

```
        B ______ P ______ C          |PB| = |PC|,  i.e. P is the midpoint of BC.
      __/  __ __ \__      \          B on circle k,  C on circle l.
     /    /       \  \     \
    (  k (         )  )  l  )
     \    \       /  /     /
      \__  \__ __/__/     /
          \____ Q ____ ___/
```

- **What it exercises.** Exactly Problem 4.4's chain: shift the unknown to a point, express the awkward condition as a transformation, invert the transformation onto the constraint, intersect two loci.
- **The chain of moves** (following Tao's hint; the book gives no solution, so this is my working):
  1. `[shift the unknown]` The unknown is the line $m$; solve instead for the point $B$, since $B$ determines $m$ (the line $BP$).
  2. `[replace a relation by a transformation]` The condition $|PB|=|PC|$ with $B$, $P$, $C$ collinear and $P$ between them says exactly that $P$ is the *midpoint* of $BC$ — i.e. $B$ is the image of $C$ under the half-turn (rotation by $180^\circ$) about $P$. Call that map $\sigma_P$.
  3. The two conditions on $B$: (a) $B\in k$; (b) $\sigma_P(B)=C \in l$.
  4. `[invert the condition]` Rewrite (b) as: $B\in \sigma_P(l)$, the half-turn image of circle $l$ about $P$ — a circle of the same radius, constructible (reflect the centre of $l$ through $P$, keep the radius).
  5. `[intersect the loci]` $B$ is an intersection point of $k$ and $\sigma_P(l)$. Both circles pass through $P$ (since $\sigma_P(P)=P$), so their *other* intersection point is the $B$ we want. Draw $m = BP$, and $C$ is where $m$ meets $l$ again.
- **Transferable lesson.** "Midpoint" is not a length condition to be measured — it is a *half-turn* to be inverted. Recognizing a metric condition as a transformation is what converts an unsolvable search into a compass-and-straightedge recipe.

---

## Exercise 4.2 (p. 61) — a right triangle in a circle through two given points

**Statement in full.** A circle is given, and two points $A$ and $B$ inside it. If possible, construct a right-angled triangle inscribed in the circle (all three vertices on the circle) such that one of its two legs passes through $A$ and the other leg passes through $B$. **Tao's hint: solve for the right-angled vertex.**

**The figure (pp. 61–62).** Left: a circle with two $\times$'s marked inside, $A$ upper-middle and $B$ lower-left-of-centre. Right: the solved picture — an inscribed right triangle whose right-angle corner is at the top-left of the circle (marked with a small square), one leg running horizontally to the right along the top of the circle and passing through $A$, the other leg running vertically downwards and passing through $B$, and the hypotenuse running diagonally across the circle (it is a diameter).

- **What it exercises.** Solve for the determining unknown; find its locus; use the *converse* of Thales twice.
- **The chain of moves** (following Tao's hint; my working):
  1. `[shift the unknown]` Let $V$ be the right-angled vertex. Once $V$ is known, the whole triangle is: draw $VA$ and extend to meet the circle again (one vertex), draw $VB$ and extend to meet the circle again (the other vertex). So $V$ determines everything.
  2. `[translate the condition into an angle]` The two legs are perpendicular at $V$, one through $A$ and one through $B$. So $\angle AVB = 90^\circ$.
  3. `[find the locus — converse of Thales]` The set of points that see the segment $AB$ at $90^\circ$ is precisely the circle with $AB$ as diameter. So $V$ lies on that circle. Constructible: bisect $AB$ to find the centre, radius $|AB|/2$.
  4. `[intersect the loci]` $V$ is also on the given circle. So $V$ = an intersection of the given circle with the circle on diameter $AB$. (This is where "if possible" comes from: if $A$ and $B$ are too close to each other and too far from the boundary, the small circle sits entirely inside the given one and there is no intersection — no solution.)
  5. Finish: the third condition takes care of itself. The angle at $V$ is a $90^\circ$ inscribed angle, so by Thales' theorem the opposite side is automatically a diameter — you don't have to impose it.
- **Transferable lesson.** A perpendicularity condition on an unknown point is a *circle* — that's the locus form of Thales' converse, and it's the single most useful locus in elementary geometry. Also note step 5: after intersecting your loci, check which of the original requirements are now automatic. Constraints that become free are how you know you picked the right unknown.

---

## Exercise 4.3\* (p. 62) — a square with one given point on each side

**Statement in full.** Four points $A$, $B$, $C$, $D$ are given in the plane. If possible, construct a square such that each of its four sides contains one of the four points. (Marked $(*)$ = harder.)

**The figure (p. 62).** Left: four scattered $\times$'s labelled $A$ (upper left), $D$ (upper right), $B$ (lower left), $C$ (lower middle), with a "?" arrow. Right: an axis-aligned square with $A$ on the top side, $D$ on the right side, $C$ on the bottom side, $B$ on the left side.

- **Tao's hints (paraphrased from p. 62), and the technique content of each.**
  1. "it is very hard to solve for the square" — `[the object you were asked for is the wrong unknown]`
  2. "solving for a single vertex of the square … is only a little better: the vertex can be confined to a fixed circle, but that is about it" — `[the simplest unknown is not always the right unknown: it gives you a locus but doesn't determine the answer]`
  3. "One approach that does yield results is to solve for a diagonal of the square. A diagonal needs several anchors: the orientation, position, and endpoints. But the diagonal will determine the square uniquely, while a single vertex cannot do that easily." — `[choose the unknown by the criterion "does pinning it down pin down everything?", even at the cost of more degrees of freedom]`
  4. "If you are really stuck, try drawing a nice big diagram with the square first and the points second" — `[draw backwards from the answer, as in Problems 4.3 and 4.4]`
  5. "and then draw circles with $AB$, $BC$, $CD$, and $DA$ as diameters, and also draw the diagonals. Use the circles to their fullest advantage: calculate angles, similar triangles, and so on." — `[construct the circles that the converse of Thales suggests]`

     *Why those four circles:* the pairs $\{A,B\}$, $\{B,C\}$, $\{C,D\}$, $\{D,A\}$ are exactly the pairs of points lying on **adjacent** sides in the target figure. If $A$ is on one side and $B$ on the adjacent side, the corner $V$ between those two sides sees $AB$ at $90^\circ$, so by the converse of Thales $V$ lies on the circle with diameter $AB$. So the four corners of the unknown square lie on those four constructible circles — the square's corners get pinned to loci you can actually draw.
  6. "For a really big hint, look at the intersections of the diagonals and the circles." — `[hunt for a constructible distinguished point on the object you're solving for]`
  7. "There is also another solution, where one solves for a particular side, by using rotations, reflections, and translations to twist one side to nearly match another. In short, a solution of similar style to the above." — `[transformations again: the same invert-the-transformation move as Problem 4.4 and Exercise 4.1]`
- **Note.** The book gives no full solution and I will not manufacture one; the deliverable here is the *shape of the hint*, which is a compressed restatement of the entire construction methodology: choose the determining unknown, find loci for it via right-angle/Thales arguments, or transform one part of the figure onto another.
- **Transferable lesson.** When the naive "simplest unknown" gives you only a partial constraint, escalate to a *slightly* more complex unknown that is fully determining. More degrees of freedom is a fair price for determinacy.

---

## Problem 4.5 (Taylor 1989, p. 10, Q4) — five rectangles in a square

**Statement in full.** A square is divided into five rectangles in a pinwheel pattern: four around the outside ($R_1,R_2,R_3,R_4$) and one, $R_0$, in the middle. The four outer rectangles all have the same area. Prove that the inner rectangle $R_0$ is a square.

**The diagram (p. 63).** The big square is cut like a pinwheel (Tao calls it a "swastika formation" — the four arms wrap around the centre with 4-fold rotational symmetry):
- $R_1$: a tall rectangle occupying the **left** part of the **top** portion — its top-left corner is the square's top-left corner.
- $R_2$: a wide rectangle occupying the **top-right**, running from $R_1$'s right edge to the square's right edge.
- $R_3$: a tall rectangle on the **right**, below $R_2$, running down to the square's bottom edge.
- $R_4$: a wide rectangle along the **bottom-left**, running from the square's left edge rightwards.
- $R_0$: the small rectangle left in the middle.

```
   +---------+----------------+       R₁ hugs the top-left corner (tall)
   |         |                |       R₂ hugs the top-right (wide)
   |   R₁    |      R₂        |       R₃ hugs the bottom-right (tall)
   |         |                |       R₄ hugs the bottom-left (wide)
   |         +--------+-------+       R₀ is what's left in the middle
   |         |        |       |
   |         |   R₀   |  R₃   |       Each of R₁..R₄ has the same area.
   +---------+--------+       |       Claim: R₀ is a square.
   |          R₄      |       |
   |                  |       |
   +------------------+-------+
```

Each arm's "long" direction is rotated $90^\circ$ from the previous, and each arm is blocked at one end by its predecessor and blocks its successor — that cyclic structure is the entire content of the problem.

- **The data / the objective.** Data: four equal areas. Objective: an "unusual objective" — a shape claim about the fifth rectangle. Tao's classification: "This is another of these 'unusual objective' questions. **The fact that the outer four rectangles all have the same area does not seem to force the inner square to be equal, on first glance**" (p. 63). Note what that sentence is doing: it names the *feeling* of insufficiency as the diagnostic feature of the problem type, before doing anything about it.
- **The chain of moves.**
  1. **Confront the apparent under-determination.** "At first you might think there is too much freedom in the data: after all, a rectangle with a fixed area could be long and thin, or short or fat. Why cannot we maneuvre one rectangle out of shape, and distort the inner rectangle?" (p. 63) `[test whether the hypothesis really constrains]`
  2. **Wriggle it and watch it jam.** "A quick try shows why this does not work: each rectangle is constrained by its neigbouring rectangles. In the picture, rectangle $R_1$ … is 'stuck in place' by rectangles $R_2$ and $R_4$. To change rectangle $R_1$ would involve changing rectangles $R_2$ and $R_4$, which would then both change rectangle $R_3$. But rectangle $R_3$ cannot satisfy the demands of both rectangles $R_2$ and $R_4$, unless they are demanding the same thing." `[qualitative rigidity analysis]`
  3. **Draw the failure, and say precisely what fails.** A second figure (p. 63) shows a distorted pinwheel in which $R_3$ has pulled away from the right-hand edge, leaving a sliver. Tao's caption of it: "In the following picture, rectangle $R_3$ can fit rectangle $R_2$, **or** rectangle $R_4$, **but not both** (remember $R_3$ also has to have the same area as $R_2$ and $R_4$)." So the obstruction is named exactly: $R_3$ has one shape parameter but two flush-fitting demands plus an area demand. `[draw the counterexample attempt]`
  4. **Cash the exploration into a conjecture — the full quote.** The file-worthy sentence is longer than it is usually quoted: "**Light begins to dawn on how this question 'works': because of needs of equal area, as well as the difficulties of 'flush fitting', the only possibile way this can work is if the inner rectangle is a square. It should be impossible to move out of this symmetric swastika formation**; the figure below gives an example of what can go wrong" (p. 63). Three separate deliverables are packed in there: (i) the *belief* that the statement is true; (ii) an explicit two-part accounting of where the constraints come from — the areas, plus what Tao calls **"flush fitting"** (the requirement that the arms actually meet the walls of the square with no gap and no overlap, i.e. the closure conditions); and (iii) the eventual *proof strategy*, phrased as "it should be impossible to move out of" the symmetric configuration, which is a rigidity claim and therefore a contradiction argument in waiting. The term "flush fitting" is worth keeping: in any tiling or cyclic-configuration problem, the constraints you will forget are the closure ones, not the local ones. `[name the obstruction; convert exploration into a conjecture plus a strategy]`
  5. **Let the exploration choose your variables.** This is the step most likely to be dropped, and it is the reason the wriggling was not wasted: "**From our discussion of 'wriggling' the formation it is apparent that one rectangle, for example rectangle $R_1$, will determine the positions of all the other rectangles; $R_1$ will force $R_2$ and $R_4$ into fixed positions, which will in turn fix rectangle $R_3$, if possible**" (p. 64). The qualitative pass did not merely suggest that the answer is true — it identified *which single object generates the whole configuration*, and that is precisely what you must know before you can parametrize anything. (Note the "if possible" — he is still keeping open the possibility that $R_3$ cannot be fixed at all, which is exactly the contradiction he will later exploit.) `[the wriggling tells you the generating object]`
  6. **Introduce notation.** "To progress any further, we need notation: more specifically we need to express all the various sizes and dimensions of the geometrical objects in terms of a few variables" (p. 64). Choose the big square to have side $1$ and $R_1$ to be $a\times b$ (width $a$, height $b$). Everything else follows:
     - $R_2$ has width $1-a$ (the rest of the top edge), so to have area $ab$ its height must be $\dfrac{ab}{1-a}$.
     - $R_4$ has height $1-b$ (the rest of the left edge), so its width must be $\dfrac{ab}{1-b}$.
     - $R_3$ therefore has height $1-\dfrac{ab}{1-a}$ (the rest of the right edge) and width $1-\dfrac{ab}{1-b}$ (the rest of the bottom edge).

     This is exactly the labelled figure on p. 64, which is worth reproducing because every one of the eight labels is a piece of the argument:

     ```
             a              1 − a
       +-----------+--------------------+
       |           |                    |
       |           |        R₂          |  ab/(1−a)      ← R₂'s height, forced by area
     b |    R₁     |                    |
       |           +---------+----------+
       |           |         |          |
       +-----------+   R₀    |    R₃    |  1 − ab/(1−a)  ← what's left of the right edge
       |           |         |          |
   1−b |      R₄             |          |
       |                     |          |
       +---------------------+----------+
            ab/(1−b)           1 − ab/(1−b)
              ↑                    ↑
      R₄'s width, forced by area   what's left of the bottom edge
     ```
     `[introduce notation / parametrize; main figure = R₁]`
  7. **Name the sledge-hammer, then look for better.** $R_3$'s area must also be $ab$:
  $$\Big(1-\frac{ab}{1-a}\Big)\Big(1-\frac{ab}{1-b}\Big)=ab.$$
  Tao's own description of what this approach amounts to: "**This is the sledge-hammer approach: we will end up with two equations concerning rectangle $R_3$ (or perhaps $R_1$, $R_2$, or $R_4$ if we interpret the equations differently) and then we can solve for a relation between $a$ and $b$** (for not just any dimensions of $R_1$ will work: in fact we have to prove that the only formations of $R_1$ allowed are those that produce a square in the middle)." Two things worth extracting. (i) "*Two* equations … or perhaps $R_1$, $R_2$, or $R_4$ if we interpret the equations differently" — the point is that the closure of the pinwheel can be written down from any of the four arms' points of view, and the *same* relation wears four different faces. Which face you write it in changes how tractable the algebra looks; that is a free choice you should exploit rather than accept. (ii) The parenthetical is a restatement of the objective in the new variables: instead of "prove $R_0$ is a square", **"prove that the only formations of $R_1$ allowed are those that produce a square in the middle"** — i.e. turn a shape claim into a *characterization of the admissible parameter set*. That is the reframing that makes the whole rest of the proof possible. Verdict on the sledge-hammer itself: "This method works, but is a bit messy algebraically, so let us try for a simpler, more intuitive, and less coordinate-based approach (which is really all that approach is)" (p. 64). `[name the sledge-hammer, set it aside; restate the goal as "which configurations are allowed"]`
  8. **Change what you're trying to prove.** "We want to prove that the only way all our conditions are satisfied is when $R_0$ is a square. **But that is a bit hard to prove.**" $R_0$ is awkward: it "does not become a 'main figure' as easily as other rectangles". Whereas "we have already shown that we can put everything in terms of, say, rectangle $R_1$. In this sense, rectangle $R_1$ can be called the **main figure**: the ones that all the other constructions depend on. Once we have this reference point, **we can concentrate on one rectangle alone**" (pp. 64–65). So the payoff of choosing a main figure is dimensional: a statement about five rectangles becomes a statement about one. `[restate the goal about the parametrizable object]`
  9. **Guess the intermediate goal from the picture.** "The above picture seems to suggest that $a+b$ should equal 1" (p. 65). `[isolate an intermediate goal]`
  10. **Verify the easy implication.** Tao's own quick verification, which is a chain of "and so on" rather than a computation: "if $a+b$ equalled 1, then $R_2$ must have a horizontal length of $1-a=b$, by equal area must have had vertical length of $a$, so that rectangle $R_3$ must have had a vertical length of $1-a=b$, and so on." Written out: if $a+b=1$ then $b=1-a$, and:
     - $R_2$'s width $=1-a=b$, so (equal area) its height $=ab/b=a$.
     - $R_3$'s height $=1-a=b$, and $R_4$'s width $=ab/(1-b)=ab/a=b$, so $R_3$'s width $=1-b=a$.
     - $R_4$'s height $=1-b=a$.

     So all four arms are $a\times b$ rectangles arranged in a perfect pinwheel. $R_0$'s width is (distance from $R_1$'s right edge at $x=a$ to $R_3$'s left edge at $x=b$) $=b-a$; its height is (from $R_2$'s bottom at depth $a$ to $R_4$'s top at depth $b$) $=b-a$. Equal — so $R_0$ is a square of side $b-a$. Tao: "It fits very neatly into the above-mentioned 'swastika', and one sees that $R_0$ is a square with sidelength $b-a$" (p. 65).
  11. **Draw the chain and identify what's left.** Tao literally draws it as three boxes joined by arrows (p. 65):

      ```
      ┌───────────────────────┐     ┌───────────┐     ┌──────────────────┐
      │ R₁,…,R₄ equal area    │ ==> │ a + b = 1 │ ==> │ R₀ is a square   │
      └───────────────────────┘     └───────────┘     └──────────────────┘
             ↑                                ↑
             └── STILL TO PROVE ──────────────┘        └── just proved, step 10 ──┘
      ```
      In his words: "To summarize, we have shown the second implication in the chain … and it now remains to prove the first implication." Note which half you get for free: the *easy* direction (from the clean symmetric hypothesis to the conclusion) is the one that falls out in three lines, and the *hard* direction (from the messy real hypothesis to the clean symmetric one) is the one left over. That asymmetry is normal, and it is why inserting the stepping-stone is worth doing even though it appears to double the work. `[implication chain]`
  12. **Go backwards.** "We can see by the coordinate geometry approach that, while the given data is easily reducible to formula, the formula is not easily reduced to objective. While equal areas may seem to be a very nice and simple thing to work with, they are actually more of a hindrance in this question, because you just have a bunch of equal products whose terms are related by additive equations. **But we can work backwards:** we can try to prove that

      ```
      ┌───────────┐     ┌────────────────────────────────┐
      │ a + b ≠ 1 │ ==> │ R₁,…,R₄ do NOT have equal area │      (contrapositive)
      └───────────┘     └────────────────────────────────┘
      ```

      or we could try a proof by contradiction:

      ```
      ┌───────────┐   ┌──────────────────────────────┐     ┌───────────────┐
      │ a + b ≠ 1 │ & │ R₁,…,R₄ have equal area      │ ==> │ Contradiction │
      └───────────┘   └──────────────────────────────┘     └───────────────┘
      ```
      "(p. 65). Both of these are drawn as boxed diagrams in the book, side by side, which is itself a small technique: when you are choosing between logical forms, *write the forms down as objects* and compare them, rather than reasoning about them in your head. `[backward approach / contrapositive / contradiction]`
  13. **Weigh the two.** "Notice that with a proof by contradiction, one has more data to begin with, but the end result is very open-ended and indefinite. This strategy fits well with our earlier, qualitative approach: it would be impossible to wriggle from the symmetric solution because all the rectangles get unbalanced. **So let us focus a bit more on the proof by contradiction method**" (p. 65). Choose contradiction, because it matches the intuition. `[match method to intuition]`
  14. **Set it up in Tao's words.** "So suppose that $a+b$ is too large: that it is greater than 1, but the rectangles somehow manage to have the same area. Then we have to prove a contradiction. Well, what we have is a rather big rectangle $R_1$. What does that do? it forces rectangle $R_2$, say, to be narrow." Note the two-question rhythm — *what do I have? what does it do?* — which is how a contradiction proof gets started when the extra hypothesis is an inequality rather than an equation.
- **The resolution.** Suppose the four areas are all equal but $a+b>1$. Then chase the shapes around the pinwheel:
  - $R_2$'s long side is the top-edge remnant $1-a$. Since $a+b>1$ we get $1-a<b$: $R_2$'s long side is **shorter** than $R_1$'s long side $b$. Equal areas then force $R_2$'s short side to be **longer** than $R_1$'s short side: indeed $\frac{ab}{1-a}>a$ exactly when $b>1-a$. Tao: "the horizontal length of $R_2$ is $1-a$, and is smaller than $b$. Therefore, $R_2$ is narrower than $R_1$. Because of the equal areas restriction, $R_2$ has to be longer than $R_1$ in the vertical direction" (p. 65).
  - "But now look at rectangle $R_3$: by similar logic it must be more 'stretched out' than rectangle $R_2$. And applying the same reasoning again, rectangle $R_4$ must be stretched further out than rectangle $R_3$. And one last time: rectangle $R_1$ must be thinner and longer than rectangle $R_4$. But this means that rectangle $R_1$ is longer and thinner than itself, which is absurd. And here we have our contradiction" (pp. 65–66).
  - And symmetrically: "A similar condition occurs when $a+b$ is less than 1: the rectangles get fatter and shorter, and eventually one can show rectangle $R_1$ has to be more squashed than itself, which is the contradiction."

  Hence $a+b=1$, and by step 8, $R_0$ is a square. ∎

  **Making the chain precise (my own bookkeeping, since the book states it verbally).** Let $L_n$ be the length of $R_n$ along its own arm direction, so that its cross-dimension is $ab/L_n$ (from equal areas). The geometry of the pinwheel forces
  $$L_{n+1} = 1 - \frac{ab}{L_n},$$
  because each arm's long side is what's left of a side of the big square after the previous arm's cross-dimension is taken out. The map $g(L)=1-ab/L$ is strictly **increasing** ($g'(L)=ab/L^2>0$), so once $L_2<L_1$ the whole sequence strictly decreases: $L_3<L_2$, $L_4<L_3$, $L_5<L_4$. But the pinwheel closes up after four steps, so $L_5$ must literally equal $L_1$ — contradiction. And $L_2<L_1$ says $1-a<b$, i.e. $a+b>1$. If instead $a+b<1$ the sequence strictly increases and closure fails the other way. Only $a+b=1$ survives — and indeed $L=b=1-a$ is exactly the fixed point of $g$ (solving $L=1-ab/L$ gives $L^2-L+ab=0$, whose roots are $a$ and $b$ when $a+b=1$).

  Numerical illustration of the failure, with $a=0.45$, $b=0.6$ (so $a+b=1.05>1$, area $=0.27$): the arm lengths come out $L_1=0.6$, $L_2=0.55$, $L_3=0.509$, $L_4=0.470$, and then $L_5=0.425 \ne 0.6$. The pinwheel spirals inwards instead of closing.

  *(One presentational caution: the book's direction-words on p. 66 are loose — "more stretched out" and "thinner and longer" for the $a+b>1$ case, "fatter and shorter" for $a+b<1$. Whichever way you name it, the mathematical content is unambiguous and is the point: some shape parameter changes **strictly monotonically** at each of the four steps, so it cannot return to its starting value.)*
- **Transferable lesson.**
  1. **Cyclic structure + monotone step = contradiction.** This is a complete, reusable proof pattern. If your configuration is a cycle and you can show each step strictly increases some quantity, then no configuration with a strict inequality anywhere can exist. Programmer's analogy: a loop whose counter strictly decreases each iteration cannot return to its initial value, so a "loop invariant" of equality forces every step to be neutral.
  2. **Inequalities can be stronger tools than equalities.** Stated by Tao himself: "sometimes inequalities are easier and more efficient to use than equalities" (p. 66). Equalities in a consistent system are inert; a strict inequality *propagates*.
  3. **"A picture is worth a thousand equations"** (p. 66) — the wriggling picture told him the answer, told him the intermediate goal ($a+b=1$), and told him the proof method (contradiction via propagating imbalance). The algebra was only ever the write-up.
  4. **Choose your variables so that the *hypothesis* is easy to express and the *goal* is expressible at all.** Parametrizing by $R_1$ made the hypothesis a set of products and the goal a statement about $a,b$; parametrizing by $R_0$ would have made the goal easy and the hypothesis unusable.

---

## Exercise 4.4 (p. 66) — a cyclic system of equations (no geometry at all)

**Statement in full.** Find all positive reals $x,y,z$ and all positive integers $p,q,r$ such that
$$x^p+y^q = y^r+z^p = z^q+x^r.$$
**Tao's hint: "This question has no geometry in it, but it is still similar to Problem 4.5."**

- **What it exercises.** Purely the technique, stripped of the geometry: the three expressions form a **cycle** ($x\to y\to z\to x$ with the exponents shuffling around), exactly like the four rectangles. So the intended attack is the same: assume a strict inequality somewhere, propagate it around the cycle, and arrive back at a contradiction with itself. That is the entire point of the hint, and it is why Tao placed a non-geometric exercise in a geometry chapter — he is telling you the technique is **domain-independent**.
- **Notes for the reader.** The book gives no solution, and I won't fabricate one. Two things are worth recording, though, as they illustrate the chapter's own advice about checking your guesses:
  - The obvious symmetric candidates do work: $x=y=z=1$ satisfies the system for *any* positive integers $p,q,r$ (every expression becomes $1+1=2$); and $x=y=z=t$ works whenever $p=q=r$.
  - But the solution set is **larger than the symmetric one**, so "the answer is $x=y=z$" would be a wrong guess. Check (my own arithmetic): take $p=1$, $q=2$, $r=1$, and $x=0.75$, $y=z=0.5$. Then $x^p+y^q = 0.75+0.25 = 1$; $y^r+z^p = 0.5+0.5 = 1$; $z^q+x^r = 0.25+0.75 = 1$. All three agree, yet $x\ne y$. So the cyclic-inequality argument must be run carefully — the exponents being different is what breaks the naive symmetry.
- **Transferable lesson.** Recognize the *structure* (a cycle of constraints), not the *subject matter*. And, per the chapter's own advice (technique #35, special cases), always test whether your guessed answer is the *only* answer before committing to proving uniqueness.

---

## Problem 4.6 (AMOC Correspondence Problem, 1986–1987, Set One, Q1) — two equal angles at a square's corner

**Statement in full.** $ABCD$ is a square. Let $k$ be the circle centred at $B$ passing through $A$ (so $k$ has radius $|AB|$). Let $l$ be the semicircle drawn inside the square with $AB$ as its diameter. Let $E$ be any point on $l$, and extend the line $BE$ until it meets the circle $k$ at $F$. Prove that $\angle DAF=\angle EAF$ — i.e. that $AF$ bisects the angle $\angle DAE$.

**The diagram (p. 66).** The square has $A$ bottom-left, $B$ bottom-right, $C$ top-right, $D$ top-left. Circle $k$ is centred at $B$ with radius $|AB|$; only its quarter-arc inside the square is drawn, sweeping from $A$ (bottom-left) up and over to $C$ (top-right). The semicircle $l$ has $AB$ (the bottom side) as diameter, bulging upwards to a height of half the square. $E$ is a point on $l$ towards its right end; $F$ is on arc $k$ near the top, and $B$, $E$, $F$ are collinear (the ray from $B$ through $E$ exits at $F$). Drawn segments: $AF$, $AE$, $AB$, $BF$, and the square's sides.

```
   D +----------------------+ C
     |            ___*F___/ |     k: arc centred B, radius |AB|, from A to C
     |        _--/  /      \|     l: semicircle on diameter AB, bulging up
     |      /     /   ___ * |     E on l;  B, E, F collinear
     |    /   __--*--/     E|     Claim: ∠DAF = ∠EAF
     |  / __--   l    \    /|
     |/_--             \  / |
   A *------------------\/--* B
```

- **The data / the objective.** Data: a square (right angles), one circle centred at $B$ through $A$, one semicircle on diameter $AB$, and a collinearity ($B$, $E$, $F$). Objective: an equality of two angles. No side lengths anywhere.
- **The chain of moves.**
  1. Draw the picture. "As always, we begin by drawing a picture" (p. 66). `[technique 2]`
  2. Choose the currency: "Judging by the lack of side lengths and so on, it seems we can tackle the question entirely by angles. After all, circles are always very friendly towards angles" (p. 67). `[objective determines currency; angle chasing]`
  3. Diagnose the difficulty: "But these particular angles $\angle DAF$, $\angle EAF$ seem a bit remote. We will need to write these obscure angles in terms of more 'friendly' angles, so that we can then relate the two angles to each other" (p. 67). `[obscure → friendly]`
  4. **Handle $\angle DAF$.** It touches no triangle — but it *does* touch circle $k$: the side $AD$ is tangent to $k$ at $A$! (Because $k$ is centred at $B$, its radius to $A$ is $BA$, which lies along the square's bottom side, and $AD$ is perpendicular to $AB$ — and a line perpendicular to a radius at its endpoint is the tangent.) So the tangent–chord theorem applies: the angle between the tangent $AD$ and the chord $AF$ equals the inscribed angle that $AF$ subtends from the far arc. "we can say that $\angle DAF=\angle APF$, where $P$ is any point on $k$ which is on the arc of $AF$ containing $D$. For example, we could say $\angle DAF=\angle ACF$" (p. 67). `[recall the tangent–chord theorem; instantiate the free choice of P at a named point]`

     Two details in that sentence. First, the theorem is cited by Tao as "**the odd little theorem (Euclid III, 32) that the angle a chord subtends in a circle is the same as the angle the chord subtends in the tangent**" — note "odd little", i.e. he is flagging it as exactly the kind of dormant, rarely-used fact that technique #31 exists to retrieve. Second, the theorem hands you a *free parameter* ($P$ is **any** point on the relevant arc), and the move is to spend it on a point that already has a name in your figure. $C$ is a corner of the square and an endpoint of arc $k$, so choosing $P=C$ costs nothing and buys a labelled point. When a theorem quantifies over a set, always instantiate at something the problem already mentions.
  5. **Not satisfied yet — keep pushing towards "mainstream".** "The $\angle ACF$, though, is almost as boring as $\angle DAF$. But it is an angle subtended on a circle. This means it is half the angle subtended by the centre: that is, $\angle ACF=\frac12\angle ABF$" (p. 67). Since $B$ is the *centre* of $k$, the central-angle form of the inscribed angle theorem applies with $B$ as the centre. And $\angle ABF$ is a good destination: "The angle $\angle ABF$ seems to be a more 'mainstream' angle, connected to several triangles and circles, so this is a fairly satisfying result: $\angle DAF=\frac12\angle ABF$." `[keep converting until you reach a well-connected quantity]`
  6. **Handle $\angle EAF$.** Worse: "This angle is **even more ugly** than $\angle DAF$; it is not directly attached to anything else. But it shares its vertex with other, nicer angles like $\angle DAB$, $\angle EAB$, and the like, so we can represent $\angle EAF$ in terms of friendlier angles" (p. 67). Note the exchange rate being used here: an angle that touches nothing can still be *added to or subtracted from* neighbouring angles at the same vertex, because angles at a shared vertex compose additively. Sharing a vertex is the weakest possible connection, and it is enough. Two candidate decompositions:
  $$\angle EAF = \angle BAF - \angle BAE \qquad\text{or}\qquad \angle EAF = \angle DAB - \angle DAF - \angle BAE.$$
  7. **Choose between them by inspecting the pieces.** "The first equation leaves us with one rather nice angle $\angle BAE$ and one slightly worse angle $\angle BAF$. The second formulation, however, has several advantages: $\angle DAB$ is $90^\circ$, and we have already worked out $\angle DAF$" (p. 67). So take the second:
  $$\angle EAF = 90^\circ-\tfrac12\angle ABF-\angle BAE.$$
  `[choose the decomposition that reuses known constants and prior results]`
  8. **Notice the convergence and pivot.** "But $\angle BAE$ and $\angle ABF$ are in the same triangle $ABE$. Since we have written both $\angle DAF$ and $\angle EAF$ … in terms of angles from $ABE$, it is clearly time to start focusing on this triangle" (p. 67). `[when both ends land in the same sub-figure, focus there]`
  9. **Recognize the trigger configuration.** "Well, $ABE$ is inscribed in a semicircle. This should remind one of Thales' theorem (Theorem 4.1), which tells us that $\angle BEA=90^\circ$" (p. 67). $E$ is on the semicircle with diameter $AB$, so the angle at $E$ is a right angle. `[trigger configuration → named theorem]`
  10. **Close the loop.** In triangle $ABE$: $\angle ABF+\angle BAE+\angle BEA = 180^\circ$ (note $\angle ABE=\angle ABF$, since $E$ lies on segment $BF$), so with $\angle BEA=90^\circ$,
  $$\angle BAE = 90^\circ-\angle ABF.$$
- **The resolution.** Substitute:
$$\angle EAF = 90^\circ - \tfrac12\angle ABF - \angle BAE = 90^\circ - \tfrac12\angle ABF - (90^\circ-\angle ABF) = \tfrac12\angle ABF.$$
And from step 5, $\angle DAF = \tfrac12\angle ABF$ as well. So $\angle EAF=\angle DAF$. ∎

  Note the elegance of what happened: **both angles turned out to equal the same third quantity**, which was never mentioned in the problem. Neither was ever computed; only expressed.
- **The write-up remark (p. 68).** "Of course, we will want to tidy this up when presenting our proof: we would probably do some long chain of equations like so: $\angle DAF=\dots=\dots=\angle EAF$. But when we are looking for a solution, we do not have to be so formal. Working out $\angle DAF$ and $\angle EAF$ and hoping that they meet somewhere in between is not all that foolish, if you know what you are doing. As long as one always tries to simplify and connect, chances are that the solution will soon fall into place. (Assuming, of course, that there is one—and most problems are not trying to pull your leg.)"
- **Transferable lesson.**
  1. **Bidirectional search is legitimate.** Reduce both sides of a desired equality independently, towards whatever is most connected, and let them collide. You don't need to know the meeting point in advance.
  2. **"Friendly" is a real, usable criterion.** An angle's usefulness is a function of how many known objects it touches. Rank your quantities by connectivity and always push towards the well-connected ones. (Compare: in a codebase you route through the well-tested, widely-used function, not the one-off helper.)
  3. **Tangency is a hidden hypothesis in disguise.** "$ABCD$ is a square" plus "$k$ is centred at $B$ through $A$" secretly says "$AD$ is tangent to $k$", which is what unlocks the whole problem. Perpendicularity to a radius = tangency is a two-way street worth watching for.
  4. **The two-word heuristic.** "Simplify and connect" is the closest thing this chapter has to a universal rule for what to do next when you have no plan.

---

## What this chapter teaches about problem solving in general

1. **Know what currency your data is in and what currency your objective is in, and learn the exchange rates.** Almost every difficulty in this chapter is a mismatch: length data with an angle objective (4.2), a ratio objective with no available triangles (4.3), an area hypothesis with a shape objective (4.5). The productive move is never "try harder" but "translate" — and Tao's discipline is to *enumerate the translation mechanisms and screen them against the configuration's preconditions* rather than trying them at random (p. 53).

2. **Choose your direction of attack deliberately: forward or backward.** Forward (hammer the data into the shape of the goal) works when "the objective is a simple relation involving easily calculable parts". Backward (rewrite the goal until the data can reach it) is for when "the objective is obscure" (p. 55). Objectives are cheaper to rewrite than data, because rewriting them loses nothing — so when in doubt, work on the goal. And bidirectional search — reduce both ends, meet in the middle — is explicitly endorsed (p. 68).

3. **Pick a basis, then express everything in it.** "$ABC$ is the 'main' triangle … It is a logical reference frame; all quantities should be in terms of the main triangle" (p. 52). This appears again as $R_1$ being the "main figure" of Problem 4.5 (p. 64). And it dictates the choice of intermediate goal: prove $a+b=1$ (expressible in your basis) rather than "$R_0$ is a square" (not expressible). *The choice of variables is a strategic decision, not a notational one.*

4. **Solve for the right unknown — the simplest object that determines all the others.** Too complex (the whole triangle, the whole square) and you can't get a grip; too simple (a single vertex in Exercise 4.3) and pinning it down doesn't pin anything else. The construction problems are all won at the moment this choice is made, and the winning criterion is stated on p. 62: "the diagonal will determine the square uniquely, while a single vertex cannot do that easily."

5. **Turn relations into invertible transformations, then push them onto the constraints.** "$ABC$ is equilateral" becomes "$C = R_{A,60^\circ}(B)$" becomes "$B \in R^{-1}_{A,60^\circ}(l_3)$" (p. 60). This single pattern — replace a symmetric relation with a function, then apply the inverse function to the constraint rather than the function to your unknown candidate — solves Problem 4.4 and both of the first two exercises, and it is precisely the "reduction" idea from computer science: transform the problem into one whose answer you already know how to compute.

6. **Rigidity is proved by trying to break things.** When a hypothesis looks too weak, wriggle the configuration. Either you break it (and you've found a counterexample) or the mechanism that stops you *is* the proof. In Problem 4.5 the wriggling delivered three separate things: the belief that the statement is true, the intermediate goal $a+b=1$, and the choice of proof method (contradiction with a propagating imbalance). Related but discrete: special, extreme and degenerate cases as idea generators (p. 58).

7. **Inequalities and cycles beat equalities.** A system of equalities in a consistent configuration tells you nothing locally; a strict inequality *propagates*, and around a cycle it comes back to contradict itself. "sometimes inequalities are easier and more efficient to use than equalities" (p. 66). And the accompanying honest accounting of proof by contradiction: "one has more data to begin with, but the end result is very open-ended and indefinite" (p. 65).

8. **Every hypothesis must be spent, and every unspent hypothesis is information.** Forwards: "each piece of data must be invoked in some way" — so steer toward the unusual data (the weird $|DC|=|DG|$ in Problem 4.3 was the key to the one thing similar triangles couldn't give). Backwards, after you finish: audit what you *didn't* use — that's how the parallelism in Problem 4.4 was exposed as "a red herring" and the theorem was strengthened for free.

9. **Memory is a technique, and it needs triggers.** Theorem 4.2 is "usually in high-school textbooks but rarely used there" (p. 57) — knowing it is not enough; you need a *retrieval cue* attached ("a product of two collinear distances from a common point ⇒ circle ⇒ power of a point"). Tao's instruction is to trawl on weak signals: "Look for things that vaguely trigger a memory" (p. 58) — and he's candid that this fires late, "usually only after all other means have failed."

10. **Keep the brute-force option ranked and in reserve, and know its cheaper variants.** Coordinates always work and are always a last resort; vectors are neater than coordinates but poorly suited to length equalities; pseudo-coordinates (perpendiculars plus Pythagoras) sit in between. Deciding this *before* you're desperate is what stops you from burning an hour on a "quadratic mess".

11. **Discovery is messy; presentation is clean; don't confuse them.** The final proof of Problem 4.6 is a single chain $\angle DAF=\dots=\angle EAF$. The search was two independent reductions hoping to collide. "But when we are looking for a solution, we do not have to be so formal" (p. 68).

12. **The toolkit is small, so enumerate it.** The chapter's opening claim is that "there are several basic results which can be used to systematically attack and resolve questions about geometrical objects and ideas" (p. 49), and Tao acts on it: in Problem 4.1 he lists his three theorems out loud before starting ("there are heaps of theorems just waiting to be used: the sum of angles in a triangle …; the angle subtended by a chord on an arc …; the angle bisectors are concurrent", p. 51), and in Problem 4.2 he lists the five length↔angle mechanisms and crosses four off (p. 53). Enumerating a *closed* list turns "be clever" into "screen five candidates against preconditions", which is a task you can actually perform. The corollary: your list has to exist, which is why maintaining a stock of surprising-but-elementary facts (p. 50) is itself a technique.

13. **Do the cheap thing first, and let its failure be informative.** Before forward and backward there is tier zero: "Simply drawing a figure and guessing conclusions is helpful sometimes, but a figure is quite hard to draw in this case" (p. 55). Likewise in Problem 4.4: draw it (with the parallel lines first!), experiment "with circles, $60^\circ$ angles, and the like", and conclude "that something special is needed" (p. 58). In both cases the *output of the failed cheap attempt* is a diagnosis that determines the next method. Exploration whose only product is a judgement about difficulty is not wasted exploration.

14. **When you fix something arbitrarily, say why nothing is lost.** "we can place $A$ wherever we like **and not worry about missing anything**" (p. 59). A degree of freedom may only be spent when you can point at the symmetry (here: sliding along the parallels) that maps any solution to one with your choice made. Without that sentence, "assume without loss of generality" is a bluff. And note that spending the freedom paid a dividend: the constraint $l_1$ became vacuous, so the problem got *strictly smaller*.

15. **You are allowed to proceed while explicitly uncertain.** "Perhaps this restriction could force $B$ and $C$ into a limited number of positions. **We do not know yet**" (p. 59). "…which will in turn fix rectangle $R_3$, **if possible**" (p. 64). Tao writes his open questions down and keeps moving. Marking a belief as provisional is what lets you use it without being trapped by it — and in Problem 4.5 the hedge "if possible" is literally the seed of the final contradiction.

16. **In a cyclic or tiled configuration, the constraints you forget are the closure conditions.** Tao's name for them is **"flush fitting"** (p. 63): the arms of the pinwheel must meet the walls of the big square exactly. The area conditions are local and easy to write; the flush-fitting conditions are what make the system over-determined, and they are the entire source of the rigidity. Before concluding a configuration has "too much freedom", count the closure conditions too.

17. **Finally, a mindset note that recurs twice.** "Good problems usually look simple and straightforward" (p. 58) — so don't take the one-line statement as evidence of easiness. And its counterweight: "most problems are not trying to pull your leg" (p. 68) — so don't take difficulty as evidence that no solution exists. Both are calibration advice about the *prior* you bring to a new problem. The epigraph is the long-run version of the same encouragement: the theorems you are learning to chain (Thales, Euclid III.31; the tangent–chord angle, Euclid III.32; power of a point) are over two thousand years old and still doing work, because "languages die and mathematical ideas do not."

---

## Errata and textual oddities in this chapter

Collected in one place, because a reader working from the book will hit all of them:

| Page | What the book prints | What it should be |
|---|---|---|
| 52 | "we want to prove that either $\beta=60^\circ$ or $\alpha=\gamma$" | $\alpha=60^\circ$ or $\beta=\gamma$ — with his own definitions $\alpha=\angle BAC$, $\beta=\angle ABC$, $\gamma=\angle ACB$, and matching the derivation on p. 54 |
| 53 | figure labels the angle at $D$ as $(\gamma+\beta)/2$ and at $E$ as $(\beta+\gamma)/2$ | $\gamma+\beta/2$ and $\beta+\gamma/2$ — as the body text of p. 53 and the sine rules of p. 54 both have it. (As printed the two labels are equal, which would make the problem trivial and false.) |
| 55 vs. 58 | the rectangle is called $ABFE$ on p. 55 and $ABEF$ on p. 58 | same rectangle, inconsistent vertex order |
| 58 | "$|FC|\times|BC| = |AG|\times|DG|$" | $|FC|\times|BC| = |AG|\times|BG|$, as on p. 56 |
| 58 | "$ABDC$ is cyclic … (if $B$, $D$ are on the same side of $AB$)" | same side of **$AC$** — the chord subtending the two angles |
| 67 | "Since we have written both $\angle DAF$ and $\angle EAF$ are now written in terms of angles from $ABE$" | a dropped edit; read "Since both $\angle DAF$ and $\angle EAF$ are now written in terms of angles from $ABE$" |
| 49 | "G.H. Hardy, 'A Mathematicians Apology'" | *A Mathematician's Apology* |
| 63, 66 | "neigbouring", "maneuvre", "possibile" | neighbouring, manoeuvre, possible |
