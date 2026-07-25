# Chapter 6: Sundry examples

> This is the chapter with no home. Tao opens it by describing mathematics as "a great entity, like a tree, branching off into several large chunks of mathematics, which themselves branch off into specialized fields, until you reach the very ends of the tree, where you find the blossoms and the fruit," then admits "it is not easy to classify all of mathematics into such neat compartments: there are always fuzzy regions in between branches **and also extra bits outside all the classical branches**" (p. 83). The four problems here live in those fuzzy regions and outside branches: a colour-changing-chameleon puzzle, a detective-style deduction about exam scores, a two-player chocolate-breaking game, and a word problem about two brothers, a herd of sheep, and a penknife. In his words they are "not quite game theory, not quite combinatorics, and not quite linear programming. They are just a bit of fun" (p. 83). Because there is no theory to lean on, this is the purest chapter in the book for *technique*. What you get instead of theorems is a toolkit: build an invariant to prove something is impossible; squeeze hidden data (integrality, positivity, distinctness, even the wording of the question) until an under-determined problem becomes determined; and for games, work backwards from the end position labelling everything a win or a loss. If Chapter 1 stated the strategies, this chapter is where you watch them do all the work with no safety net.

---

## The techniques at a glance

| # | Technique | Trigger — what makes you reach for it | Where Tao uses it |
|---|---|---|---|
| 1 | **Guess the answer before proving it** (meta-reasoning about the problem's *source*) | An "is it possible?" question with an open-ended "eventually" | Chameleons, p. 83: a YES answer would just be a procedure, "more computational than mathematical", so try NO |
| 2 | **Strengthen / generalize the conclusion** to get a more tractable target | Your goal is a single awkward statement; a bolder claim would be easier to see | Bishop-on-a-chessboard illustration, p. 84; then all-reachable-states for chameleons |
| 2b | **Explore first so that you end up with "something definite to prove"** | The question is open-ended and you have no statement to attack | "it is probably a good idea to know which systems the procedure can reach … Once we have found a pattern, we will have something definite to prove" (p. 83) |
| 3 | **Get decent notation first** — "numbers and equations" | The problem is stated in words/objects | Chameleon state as a 3-vector (p. 84); chocolate bar as $(6,10)$ (p. 90); sheep as $s$ (p. 95) |
| 4 | **Strip the state down to what matters** | The problem mentions features that clearly cannot affect the answer | Only *counts* of each colour matter (p. 84); only the bar's *size*, not its position (p. 90) |
| 5 | **Model the moves as vectors; describe the reachable set** | A puzzle is "start here, apply these operations, can you get there?" | Chameleon moves $a,b,c$; reachable $=(13,15,17)+la+mb+nc$ (p. 84) |
| 6 | **Hunt for a conserved quantity (an invariant)** | You want to prove something is *unreachable* | Total population (tried, too weak); "total amount of colour" (p. 84) |
| 7 | **Everyday physical analogy as an idea generator** | You need a candidate invariant and have no lead | Water levels merging in connected containers; red+green light = "anti-blue" (pp. 84–85) |
| 8 | **Weighted point-score as a candidate invariant** | Objects come in a few types and operations swap types | Colour scores $0,1,2$ (p. 84); the hint to Exercise 6.1 |
| 9 | **Patch a partially-working idea instead of dropping it** | An idea handles some cases and breaks on others | "A partially successful (or partially failed) attempt may be a piece of a truly successful approach" (p. 85) |
| 10 | **Go modular to make a cyclic structure literal** | The operations cycle through states; a quantity is "almost" conserved | Making blue $=$ anti-blue by working mod something (p. 85) |
| 11 | **Try successive moduli; pick the one matching the problem's symmetry** | You've decided to go modular but don't know the modulus | mod 2 fails; mod 3 works "after all, there are three cyclic colours" (p. 85) |
| 12 | **Keep two parallel attacks alive** | Two different formulations both stalled for the same reason | Both the vector approach and the point-score approach are rescued by mod 3 (p. 85) |
| 13 | **Mine the problem for hidden data** — integrality, positivity, distinctness, and the *wording* | "There is not enough information" | Problem 6.2 (pp. 86–89) and Problem 6.4 (pp. 95–97) |
| 14 | **WLOG / normalize by naming** | Symmetric labels you can order for free | "say that $x$ is the biggest and $z$ is the smallest ... We do not lose much, but we gain some simplicity" (p. 86) |
| 15 | **Find what stays fixed across all the unknown configurations** | Many possible arrangements, none pinned down | "Does anything stay fixed amid all these possibilities?" → per-exam total is always $x+y+z$ (p. 87) |
| 16 | **Count one total two different ways** | A quantity is summable along two axes (rows and columns) | $N(x+y+z)=39$ (p. 87) |
| 17 | **Factorization + integrality to reduce to finitely many cases** | An equation reads (integer)$\times$(integer) $=$ constant | Factors of 39 give exactly four cases (p. 87) |
| 18 | **Eliminate cases — including on semantic / common-sense grounds** | A case is arithmetically fine but absurd for the story | $N=1$ "contradicts the semantics of the question" since Algebra *and* Geometry are named; $N=13,39$ are "a suicidal number of exams" *and* die numerically (p. 87) |
| 19 | **Extremal bounding from an ordering** | Variables are ordered integers with a fixed sum | $13=x+y+z\ge 3z+3$ so $z\le3$; likewise $y\le5$, $x\le10$ (p. 88) |
| 20 | **Check your bound is sharp by exhibiting a witness** | You derived an inequality and want to know whether to keep pushing | $(6,4,3)$, $(7,5,1)$, $(10,2,1)$ (p. 88) |
| 21 | **Sharpen bounds with data you haven't used yet** | A bound is not tight enough to finish | Betty's total of 10 forces $x\le8$ (pp. 88–89) |
| 22 | **Crude estimation to kill many cases at once** | A long list of candidates, most obviously too small/large | $2x+z\le 2\times8+3=19<20$ (p. 89) |
| 23 | **Tabulate; let row and column sums force entries** | Multi-dimensional bookkeeping with partial information | The two exam tables (p. 89) |
| 24 | **Existence meta-theorem first** | A game question: "who has a winning strategy?" | Any finite game of skill has a winning-or-drawing strategy, by induction on game length (p. 90) |
| 25 | **Reduce a real-world problem to mathematics; formalize the legal moves** | The problem is about chocolate, sheep, chameleons | "let us reduce the problem from chocolate to Mathematics" (p. 90) |
| 26 | **Restate the problem in several equivalent forms** | One of them may match a theory you know | Chocolate → lattice-point walk → two-row counter game ($\approx$ Nim) (p. 91) |
| 27 | **Specialize: attack small cases first** | The stated case has too many branches to enumerate | $2\times3$, then $3\times3$ (pp. 91–92) |
| 28 | **Use symmetry to cut the case count** | The object is symmetric under swapping coordinates | "symmetry effectively eliminates the last two choices" (p. 92) |
| 29 | **Spot a previously solved sub-problem inside the new one — with roles reversed** | The position after your move is one you already analysed | $3\times3\to2\times3$: "we have reduced the problem to that of the last paragraph!" (p. 92) |
| 30 | **Backward induction: label positions sure-winner / sure-loser from the terminal position outwards** | Any finite two-player game with no draws | $1\times1$ loser, $1\times n$ winners, $2\times2$ loser, … (p. 92) |
| 31 | **Tabulate the labelled positions, spot the pattern, conjecture the rule** | You have a slow systematic method and want a fast one | "why do not we be more mathematical? There should be a pattern" (p. 93) |
| 32 | **Pragmatic verification instead of proof** | You have a candidate strategy and only need it to *work* | "we do not even have to prove it ... we just have to apply it" (p. 93) |
| 33 | **Termination via a strictly decreasing measure** | A strategy is a loop; you must show it halts | "because the size of the chocolate is decreasing" (p. 93) |
| 34 | **Connect the formal result back to intuition** | You want the technique to be reusable outside the puzzle | Chess players' "favourable"/"unfavourable" positions (p. 93) |
| 35 | **Strategy stealing** | Prove a first player can't be *worse off* than the second | Exercise 6.8 hint (p. 94) |
| 36 | **Separate independent from dependent variables** | Many unknowns; you must decide what to solve for | "the price of the penknife is ultimately dependent on the number of sheep, which is the only independent variable here" (p. 95) |
| 37 | **Test-drive the mechanism on a concrete number** | The rules are procedural and you're not sure you've understood them | Try 64 rubles; discover the last scraps go to the *older* brother, so 64 is impossible (p. 95) |
| 38 | **Introduce exactly enough variables** | Risk of drowning in unknowns | "enough equations to describe the situation but not enough to introduce confusion and superfluousness" (p. 95) |
| 39 | **Turn every qualitative sentence into an (in)equality** | Word-problem data that "feels" unusable | $s^2=10(2n+1)+a$, $0<a<10$, $a=10-2p$ (pp. 95–97) |
| 40 | **Eliminate a nuisance variable by taking a modulus** | An unknown appears only as a multiple of some fixed number | mod 20 deletes $n$ from $s^2=20(n+1)-2p$ (p. 96) |
| 41 | **Exploit that squares occupy few residue classes** | A square appears in a congruence | mod 20 the squares are only $0,1,4,5,9,16$ (p. 96) |
| 42 | **Combine a congruence with an inequality to pin a unique value** | A congruence gives a list; you need one answer | $p\equiv0,2,8\ (\mathrm{mod}\ 10)$ plus $0<p<5$ gives $p=2$ (p. 97) |
| 43 | **Solve only for what was asked; accept partial determination** | Some unknowns stay undetermined and that's fine | The penknife is pinned; the number of sheep is not (p. 97) |
| 44 | **The final checklist method: list every fact, convert each to an equation immediately, include the useless-looking ones** | Any information-starved puzzle | The closing summary of the chapter (p. 97) |
| 45 | **Prefer the elegant method even when a working one is already in hand** | You have a proof but it's grinding | Tao finishes the Diophantine sketch, then says "Let us try for a more elegant method, as outlined above" (p. 84) |
| 46 | **Focus on the *operation*, not just the state** | The state has no obvious structure but the moves do | "two different colour chameleons 'merge' into another colour. This merging can be focussed on" (p. 84) |
| 47 | **Do the verification yourself when the author waves it through** | A text says "clearly", "it is easily seen", "try it yourself" | "(because none of the three merging possibilities will change the total point score—try it yourself)" (p. 85) |
| 48 | **Cross-match one piece of data against another** | You have several unrelated-looking facts | "we can try to match it with our third piece of data, that Betty was first in Algebra" — combined with "each exam awards one $x$, one $y$, one $z$" it yields "Betty scored $x$" (p. 86) |
| 49 | **Keep an explicit running list of what you still do not know — and of what *partially* settles each item** | Mid-problem, after a breakthrough, when it's unclear what to do next | "we still do not know two things that should be important: we do not know the exact values of $x,y,z$; and we do not know how everyone scored in each exam" (pp. 87–88) |
| 50 | **Audit which data has not been used *fully*** (not just which is unused) | You are stuck and every fact "has been used" | "the one piece of data that has not been used fully is the individual total scores" (p. 88) |
| 51 | **Speculate in plain words first, then say "to be specific" / "can we put this speculation into solid mathematics?" and convert to (in)equalities** | You have a hunch you can't yet justify | Carol "would be scoring mostly $z$'s"; "$z$ cannot go too high, because then $x$ and $y$ will have to go high as well … To be specific: …" (p. 88) |
| 52 | **Announce the next sub-goal out loud before doing the work** | A long problem where you could drift | "So this is our next task: to limit $x$, $y$, and $z$ so we can eliminate several possibilities" (p. 88) |
| 53 | **Report partial progress: narrow the answer to a short list, then keep going** | You want to know whether you're closing in | "we know that it is either Betty or Carol that scored the second-place mark of $y$ in Geometry. But we are still not done yet" (p. 89) |
| 54 | **Turn a solved small case into an explicit induction template** | One small case fell to another small case | The $3\times4$ illustration: "We solved the $3\times3$ problem by looking at the $2\times3$ problem. This suggests an induction approach" (p. 92) |
| 55 | **Name the dependent variable you actually want, then demand an equation tying it to the independent variable** | Many symbols, unclear what to solve for | "The dependent variable which we want to solve is $p$ … We need an equation connecting $p$ with something else, preferably $s$, which is the independent variable" (p. 96) |
| 56 | **Get a "grip" on a model by experimenting with it** — a model is not yet an understanding | You have finished formalizing and feel no closer | "Now we have notation, and an abstract mathematical model. What we need now is a good grip on the problem" (p. 91) |

### Techniques the *exercises* drill (pp. 85–86, 94)

The eight exercises are not filler; each is a targeted drill, and several introduce a technique that the worked problems never use. Indexed here so the list is complete.

| # | Technique | Which exercise | Where it comes from |
|---|---|---|---|
| E1 | **Two-sided attack on an optimum**: a counting/point-scoring *lower* bound, then an explicit construction meeting it | Ex 6.1 (six musicians) | Tao's hint: "you will get a reasonable lower bound … Then find an example satisfying this lower bound—and you have solved it" (pp. 85–86) |
| E2 | **Bound a design by counting the requirements it must satisfy** ($6\times5=30$ listening pairs, at most $3\times3=9$ per concert) | Ex 6.1 | "more than one concert is needed to exhaust all the 'listening possibilities'" (p. 85) |
| E3 | **Parity of a permutation as an invariant** — track the *ordering*, not the positions | Ex 6.2 (grasshoppers) | No hint given; the technique is inherited from Problem 6.1 (p. 86) |
| E4 | **A large specific number in the question is advertising a modulus** (1985 $\Rightarrow$ parity) | Ex 6.2 | p. 86 |
| E5 | **The invariant need not be a number — it can be membership of a set** (staying in $\mathbb{Z}^2$, then in $(2\mathbb{Z})^2$) | Ex 6.3 (checkers) | "There is a particulary elegant solution … if you just think about it the right way" (p. 86) |
| E6 | **Exploit reversibility: attack from whichever end has the stronger invariant** | Ex 6.3 | p. 86 |
| E7 | **Pairing / "complete to a fixed round total"** strategy | Ex 6.4 (153 counters) | p. 94 |
| E8 | **Find a modulus no legal move is divisible by** — then its multiples are exactly the losing positions | Ex 6.5 (powers of $d$) | p. 94 |
| E9 | **Change of variable to reduce a variant to the version you already solved** ("set aside one counter as poison") | Ex 6.6 (misère) | "(If one happens to be thinking in the right way, the answer falls out easily.)" (p. 94) |
| E10 | **Warning: a pattern from small cases can generalize the wrong way** — "leave a cube" is *not* the 3-D analogue of "leave a square"; the real invariant is nim-sum zero | Ex 6.7 (3-D chocolate) | p. 94 |
| E11 | **Strategy stealing**, on top of the existence meta-theorem | Ex 6.8 (Gomoku) | Tao's hint: "argue by contradiction … Now make the first player 'steal' that strategy" (p. 94) |

Note the deliberate spread of difficulty markers: Problem 6.2 and Exercises 6.5(c), 6.5(d) are starred (\*), Exercise 6.8 is double-starred (\*\*), and everything else is unmarked. Tao's star convention from earlier chapters — harder than the surrounding material — tells you that a chapter of "just a bit of fun" still has a graded spine.

---

## Background you need first

Nothing here requires a course you haven't taken, but a handful of notational habits will appear constantly. If you have Calculus 1 and can multiply matrices, you have everything you need; the items below are the only pieces of number theory, combinatorics and game theory the chapter uses, and each is a page or less.

### Modular arithmetic ("clock arithmetic")

Working "mod $m$" means keeping only the remainder after dividing by $m$. Two numbers are the *same* mod $m$ if they differ by a multiple of $m$. So mod 3, the numbers $\dots,-2,1,4,7,10,13,\dots$ all count as "1", because each is $1$ plus a multiple of 3. In code this is just `n % m` (with the caveat that mathematicians always take the non-negative remainder, so $-1 \bmod 3 = 2$).

Tiny examples: $13 \bmod 3 = 1$, $15 \bmod 3 = 0$, $17 \bmod 3 = 2$, $45 \bmod 3 = 0$.

The key fact — the *only* fact you need — is that addition and multiplication respect this. If $a$ and $a'$ are the same mod $m$, and $b$ and $b'$ are the same mod $m$, then $a+b$ and $a'+b'$ are the same mod $m$, and so are $ab$ and $a'b'$. That means you can reduce early and often: to know $17 \times 2 \bmod 3$ you don't need $34$, you just need $2\times2=4\equiv1$.

Notation note: modern texts write $a \equiv b \pmod m$ with a triple bar. **Tao writes plain "=" followed by "(mod 3)"** — e.g. he writes "$13\times0+15\times1+17\times2 = 1$ (mod 3)" on p. 85. Read every such "=" as "has the same remainder as".

### An invariant

An **invariant** is a quantity that never changes, no matter which legal move you make. This is exactly a *loop invariant* in programming: a property true before the loop and preserved by every iteration, therefore true at the end. Its power is entirely negative and entirely decisive: if the invariant has value $V$ at the start and the target state has invariant value $\ne V$, the target is unreachable — and you never have to examine a single sequence of moves. Tao's own miniature illustration (p. 84), stated exactly as he states it: put **one bishop on a corner** of a chessboard (a bishop moves diagonally) and show that **it can never move onto an adjacent corner** — "i.e. either of the two corners not opposite it". His parenthetical "(The chessboard is checkered.)" is the whole proof: a diagonal step keeps the bishop on the same colour, so the *colour of its square* is invariant, and "no number of moves will ever leave that colour of square". You don't have to think about bishop routes at all.

Worth noticing that the invariant here is **exactly sharp**, which is why the problem is phrased with *adjacent* corners. On a standard board the two corners adjacent to a corner are the opposite colour (unreachable), while the *diagonally opposite* corner is the same colour — and is in fact reachable. So the invariant does not merely obstruct; it draws the correct dividing line. A good invariant tells you both what is impossible and what is left over.

A **monovariant** (a quantity that only ever moves one way, e.g. only decreases) is the cousin used for termination arguments; you'll see one in Problem 6.3.

### Parity of a permutation (needed for Exercise 6.2)

A **permutation** of three labelled objects is just an ordering of them: $ABC$, $ACB$, $BAC$, $BCA$, $CAB$, $CBA$ — six in all. A **transposition** (or swap) exchanges two of them and leaves the rest alone. Every permutation splits into one of two classes:

- **even**: reachable from $ABC$ in an even number of swaps — here $ABC$, $BCA$, $CAB$ (the cyclic rotations);
- **odd**: reachable in an odd number — here $ACB$, $BAC$, $CBA$.

The fact you need is that **one swap always changes the class**, so the class flips on every single swap, and after $k$ swaps you are in the starting class iff $k$ is even. For three objects you can just check this by hand: from $ABC$, swapping the first two gives $BAC$ (odd), swapping the last two gives $ACB$ (odd), swapping the outer two gives $CBA$ (odd) — all three swaps land in the odd class. From any odd ordering the same check lands you back in the even class. (In general the invariant is the number of *inversions* — pairs that appear out of alphabetical order — and a swap changes that count by an odd amount, hence flips its parity. If you have met determinants, this is exactly the $\pm1$ sign attached to each term of a determinant expansion, and it is why swapping two rows of a matrix negates the determinant.)

The point for problem solving: the parity class is an **invariant mod 2** of the *ordering*, computed without knowing any of the actual positions. That is the whole content of Exercise 6.2.

### Integer lattices and Diophantine equations

$\mathbb{Z}^3$ is just the set of triples of integers, e.g. $(13,15,17)$. A **Diophantine equation** is an equation you insist on solving in *integers only*. That restriction is a weapon, not a handicap: $3k = -47$ has a perfectly good real solution but no integer solution at all, because $47$ is not a multiple of $3$. Half the deductions in this chapter are of exactly that flavour.

**Cramer's rule** is mentioned once in passing (p. 84): it's the linear-algebra recipe that solves a square linear system by ratios of determinants. You don't need it; a cleaner route is given below.

### Squares mod $m$ (quadratic residues)

If you square every residue mod 20 you get a surprisingly short list:

$$0^2=0,\ 1,\ 4,\ 9,\ 16,\ 5^2=25\equiv5,\ 6^2=36\equiv16,\ 7^2=49\equiv9,\ 8^2=64\equiv4,\ 9^2=81\equiv1,\ 10^2=100\equiv0,$$

and from 11 to 19 it mirrors back (because $(20-k)^2 = 400 - 40k + k^2 \equiv k^2$). So **a perfect square is always one of $\{0,1,4,5,9,16\}$ mod 20** — only 6 of the 20 possible remainders. This is exactly the fact Tao uses on p. 96. It is worth internalizing as a general principle: *squaring throws away information, and a congruence involving a square is therefore a strong constraint.* (The CS analogue: hashing into a small set of buckets — if the target isn't in a reachable bucket, you're done.)

**The trap on the way back.** Going forwards ($s \mapsto s^2$) is safe. Going backwards is where people slip. If $s^2\equiv 16 \pmod{20}$ it is tempting to write $s \equiv \pm4$, but that rule only holds for a **prime** modulus. Mod 20 the value 16 has four square roots: $s \equiv 4, 6, 14, 16$. (Reason: $20 = 4\times5$, and $s$ is pinned only up to sign independently mod 4 and mod 5, giving $2\times2$ combinations.) Tao himself falls into this on p. 97 — see the note in Problem 6.4 — so the habit to build is: **when you need the square roots of something modulo a composite, write out the table of squares. Do not trust $\pm$.**

### Two-player game vocabulary (used in Problem 6.3 and Exercises 6.4–6.8)

Four terms, all of which the chapter uses without naming:

- **Finite game of perfect information.** Both players see everything, there is no chance, and the game must end. Every game in this chapter is of this kind. Tao's meta-theorem (p. 90) is that in such a game one player has a strategy guaranteeing at least a draw.
- **Normal play**: the player who cannot move **loses**. That is Problem 6.3 (you lose if you are handed the unbreakable $1\times1$) and Exercises 6.4, 6.5, 6.7.
- **Misère play**: the player who cannot move **wins** — equivalently, taking the last counter loses. That is Exercise 6.6, and flipping between the two is the whole content of that exercise.
- **Sure loser / sure winner** (Tao's terms) — modern names **P-position** and **N-position**. Both are always stated *relative to the player about to move*. A **sure loser** is a position from which the mover loses however they play (good for the **P**revious player); a **sure winner** is one from which the mover can force a win (good for the **N**ext player). The single most common bug, in maths and in code, is forgetting that the label refers to whoever's turn it is, so that "$2\times3$ is a win" means "handing your opponent a $2\times3$ bar hands them the game".

---

## Technique 1: Decide which way the answer goes *before* you try to prove it

- **What it is.** For a yes/no question, spend thirty seconds guessing the answer using evidence *outside* the mathematics — where the problem came from, what kind of answer would be satisfying, what a "computational" versus "mathematical" answer looks like — and then commit to proving that side.
- **When to reach for it.** Any "Is it possible…?" / "Can you always…?" question, especially with vague quantifiers like "eventually".
- **Tao's own words** (p. 83): "Heuristically, we should first try the possibility that the answer is NO. If the answer is YES, then there should be a specific procedure to reach our objective. That sounds more computational than mathematical, and given that this question occurred in a mathematics tournament there is good grounds that this is not the right answer."
- **Seen in action.** Chameleons (Problem 6.1). He never searches for a colour-equalizing sequence of meetings; he goes straight for impossibility.
- **Why it works.** YES and NO need completely different machinery — YES needs a construction, NO needs an obstruction (an invariant). Committing early stops you from oscillating and wasting both efforts. Guessing wrong costs you a few minutes; refusing to guess costs you the whole session.
- **Failure mode.** The heuristic is genuinely a heuristic. It leans on the sociology of competition problems ("this appeared in a tournament"), which is a legitimate signal for a contest but not a mathematical argument, and it can mislead. In Exercise 6.1 the answer *does* require a construction — you prove a lower bound and then must "find an example satisfying this lower bound".

## Technique 2: Prove something stronger than you were asked

- **What it is.** Replace your goal by a bolder statement that implies it. Instead of "state $T$ is unreachable", prove "*here is exactly the set of reachable states*" — and observe that $T$ isn't in it.
- **When to reach for it.** When the goal as stated gives you nothing to push against, and when the goal contains arbitrary-looking specifics (why *these* three target states?).
- **Tao's own words** (pp. 83–84): "As we saw in the previous chapters, to solve a problem in mathematics, you usually have to guess some intermediate result, which implies the conclusion but is not logically equivalent to it. Although from a logical point of view this leaves you with a problem that may be harder to prove, pragmatically it should provide an objective that is nearer to our data **and would concentrate our efforts in a more definite direction**. Generalizing the conclusion tends to remove superfluous information as well, a further bonus." (Note the explicit back-reference — he is telling you this is not a one-off trick but a recurring move from earlier chapters.)
- **Seen in action.** The bishop (p. 84): the task "the bishop, starting on a corner, can never move onto an adjacent corner" is replaced by "the bishop must stay on the same colour square". Tao's own gloss: "Logically, there is more to prove; but now it is very easy to see how to proceed (each move of the bishop keeps it in the same colour square; therefore, no number of moves will ever leave that colour of square)." Practically it's a one-line induction, because the stronger statement is closed under a single move and the weaker one isn't. Then the chameleons: "it is probably a good idea to know which systems the procedure can reach, and which ones it presumably cannot".

### Technique 2b: explore until you have "something definite to prove"

There is a separate, easily-missed sentence attached to the above (p. 83): after saying he wants to know which states are reachable, Tao adds **"Once we have found a pattern, we will have something definite to prove."**

This is a distinct instruction and worth naming, because it licenses a phase of work that looks like *not proving anything*. The open-ended question "can all chameleons eventually be one colour?" has no crisp statement to attack. So you first play with the object, generate data, and look for a pattern — and only then do you have a *proposition*. Strengthening the conclusion (Technique 2) and hunting for a pattern (Technique 2b) are two halves of the same manoeuvre: strengthening tells you the *kind* of statement you want (one closed under a single move), pattern-hunting tells you *which* such statement to write down.

The practical consequence: if you find yourself unable to start, the problem may not be that you lack a proof but that you lack a *claim*. Go compute something.
- **Why it works.** This is the single most counter-intuitive move in the book and worth staring at. A statement about the *end* of a process is hard to attack; a statement that is *preserved by one step* can be attacked by induction. Strengthening is how you convert a global claim into a local one. In programming terms: the specific claim is a post-condition; the strengthened claim is a loop invariant, and only the invariant is provable by looking at one iteration.
- **Failure mode.** You can over-strengthen into something false. That is exactly what happens next in the chameleon problem — the first candidate invariant (a fixed integer "colour score") is a statement he'd love to be true and isn't.

## Technique 3: Get notation — "numbers and equations" — as early as possible

- **What it is.** Convert the objects of the problem into tuples of numbers, and the operations into arithmetic on those tuples.
- **When to reach for it.** Immediately, always, in every problem in this chapter.
- **Tao's own words** (p. 84): "let us have some decent notation first (i.e. numbers and equations)"; and for the game (p. 90): "let us reduce the problem from chocolate to Mathematics".
- **Seen in action.** Chameleons: state $=(g,b,c)=(13,15,17)$. Chocolate: bar $=(6,10)$. Sheep: $s$ sheep, $s^2$ rubles, $p$ for the penknife, $n$ for the number of 10-ruble rounds, $a$ for the remainder.
- **Why it works.** Words support vague reasoning; equations don't. Once the chameleon move is "add $(-1,-1,2)$", the question "is $(45,0,0)$ reachable?" has a mechanical answer. Once the chocolate bar is a lattice point, the game becomes a walk on $\mathbb{Z}^2$ and you can *see* it.
- **Paired technique — strip the state (Technique 4).** Notation is also where you throw things away. Chameleons: individual lizards don't matter, only the three counts, and "the set-up of the problem does not permit the chameleons to take on any additional colours" (p. 84), so three numbers suffice. Chocolate: "the position of the chocolate is not relevant; only the size will be important" (p. 90). Deciding what to *forget* is as much of the modelling work as deciding what to record.

## Technique 5: Model the moves as vectors and describe the reachable set

- **What it is.** If each move adds a fixed vector to the state, then the set of reachable states is start $+$ (integer combinations of the move vectors). Now "is $T$ reachable?" becomes a linear Diophantine question.
- **When to reach for it.** Whenever the operations are additive/translation-like on a numeric state.
- **Seen in action.** Chameleons, p. 84. With $a=(-1,-1,2)$, $b=(-1,2,-1)$, $c=(2,-1,-1)$, every reachable state is $(13,15,17)+la+mb+nc$ for non-negative integers $l,m,n$.
- **Why it works / what it buys you.** It's a complete reformulation: no case analysis over move orderings, because addition commutes — *the order of the moves is irrelevant, only how many times each type happened.* That collapse of an exponentially branching search into three counters is the whole payoff.
- **Failure mode / caveat.** The model is slightly *looser* than the game (it allows $l,m,n$ to be any integers, and ignores the requirement that the counts never go negative and that the two chameleons actually exist to meet). That looseness is fine here, because we are proving impossibility: if the target is unreachable even in the looser model, it's unreachable in the real one. **Relaxing a constraint is safe when you're proving a negative.** It would be fatal if you were proving a positive.
- **Note how Tao packages this** (p. 84). The entire vector attack is delivered *inside a parenthesis*: "(For a brief sketch of the proof here, let $a=(-1,-1,2)$ …)". He states it, calls it "a simple matter in, say, Cramer's rule, or just elementary Diophantine manipulation", and then walks away from it. Which brings us to:

## Technique 45: Look for the elegant method even when you already have a working one

- **What it is.** Having found *a* proof, deliberately go back and look for a better one.
- **Tao's own words** (p. 84), immediately after finishing the vector sketch: "**Let us try for a more elegant method, as outlined above:** find all possible colour combinations of the chameleons."
- **Why this is not a luxury.** Three payoffs, all practical. (i) The elegant proof is the one you can *check* — the Diophantine route needs you to solve a $3\times3$ system correctly and get three separate arithmetic facts right; the invariant route is one line that a reader verifies at a glance. (ii) The elegant proof is the one that *generalizes* — the mod-3 invariant works instantly for any starting counts, whereas the Diophantine computation must be redone. (iii) Elegance is diagnostic: an ugly proof usually means you haven't found the real reason the statement is true. Here the real reason is "the colours cycle", and only the second proof says so.
- **The trade-off he doesn't hide.** The parenthetical Diophantine sketch is *complete*. Under exam pressure you would write it down and move on. Tao's point is that the exam answer and the understanding are different products, and this chapter is about the second one.

## Technique 46: Focus on the operation, not just the state

- **What it is.** When the state itself has no visible structure, look at what the *moves* do and ask what kind of quantity they respect.
- **Tao's own words** (p. 84), listing what he notices in order: "First of all, the total number of chameleons must remain the same. … Second, two different colour chameleons 'merge' into another colour. **This merging can be focussed on.**"
- **Why it matters.** The first observation is about the state (a total). The second is about the *verb*. The word "merge" is what triggers the water-container analogy, which triggers "total amount of colour", which becomes the point score, which becomes the invariant. The entire solution descends from choosing to stare at the operation rather than at the numbers $13,15,17$.
- **Transferable form.** Ask: *what is the English verb in this problem, and what real-world process does that verb name?* "Merge", "swap", "reflect", "break", "hop over" — each verb has its own conserved quantity (respectively: totals; permutation parity; a lattice; a decreasing size; ordering parity). Two of the exercises in this chapter ("hops over", "jumps over") are solved entirely by that question.

## Technique 6: Hunt for a conserved quantity, starting with the obvious ones

- **What it is.** Look for a number computed from the state that no legal move changes.
- **When to reach for it.** You suspect "impossible". Also: whenever a process "mixes" or "merges" things.
- **Seen in action** (p. 84). First candidate: the total number of chameleons. It *is* invariant (45 always) — and useless, since all three targets also have total 45. Tao doesn't hide this: "This is not overly helpful in this case (although considering total populations can be a good idea sometimes in similar questions)."
- **Why it works.** An invariant is a *certificate* of impossibility that a reader can check in a line.
- **Failure mode — the invariant can be too coarse.** An invariant that doesn't distinguish start from target tells you nothing. The diagnostic question is not "is this conserved?" but "is this conserved *and* different at the target?"

## Technique 7: Reach for a physical analogy when you have no lead

- **What it is.** Find a familiar real-world system whose behaviour resembles the operation, and ask what is conserved *there*.
- **Tao's own words** (p. 84): "When, say, two uneven containers of water are connected at the base, the levels of water 'merge' into the middle ground. But the total amount of water remains the same. So can we say that the 'total amount of colour' remains constant?"
- **Seen in action, twice.** (a) Water levels merging suggests "total amount of colour" is conserved. (b) When that half-fails, the primary colours of *light*: "If you think of a red light beam coinciding with a green light beam, we get a doubly bright purple beam, that is, an anti-blue beam. The primary colours are cyclic, too" (p. 85).
- **Why it works.** Analogy is a *generator*, not a proof. Its job is to produce a specific, checkable conjecture ("total colour is conserved") fast. Notice Tao's immediate follow-up (p. 84): "Obviously we have to define 'total amount of colour' to make this good mathematics." The analogy is metabolized into a definition within one sentence.
- **Failure mode.** The analogy is never exact, and the *place where it fails* is the interesting part. Light gives red+green = **anti**-blue, not blue. Rather than abandoning the analogy he zooms in on precisely that mismatch — which is what produces the winning idea.

## Technique 8: Assign point scores (a weighted count) as your candidate invariant

- **What it is.** Give each type of object a numeric weight and take the weighted total. Ask whether the operations preserve it.
- **When to reach for it.** Objects come in a small number of types and the operations convert types into each other. Tao also recommends it explicitly in the hint to Exercise 6.1 ("think upon these lines and also of 'point-scoring' ideas").
- **Seen in action** (p. 84). Grey $=0$, brown $=1$, crimson $=2$. Then grey $+$ crimson $\to$ two browns reads $0+2=1+1$: total colour preserved. Beautiful — and then it breaks: crimson $+$ brown $\to$ two greys reads $2+1=3$ but $0+0=0$. Tao's verdict: "No point scoring system, it seems, can cater for all three (or even two) possibilities of merging."
- **Why it works when it works.** A point score is a *linear functional* on the state vector. Preserving it means the functional kills every move vector. So the search for an invariant becomes: find weights $(w_g,w_b,w_c)$ with $w\cdot a=w\cdot b=w\cdot c=0$. Over the ordinary integers there's no useful solution — that is precisely the failure above. Over the integers mod 3 there is.

## Technique 9: A partial failure is a partial success — patch it, don't bin it

- **What it is.** When an idea works on some cases and breaks on others, treat the breakage as a *specification* for the missing ingredient rather than as a refutation.
- **Tao's own words** (p. 85): "The problem is due to the cyclic nature of the manoeuvres. But do not give up entirely! A partially successful (or partially failed) attempt may be a piece of a truly successful approach. (Then again, a measly amount of success is not something to be too enthusiastic about either.)"
- **Note the parenthesis.** He immediately undercuts his own encouragement. This is characteristic and worth copying: enthusiasm for a half-working idea has to be calibrated, or you will spend an hour polishing something with no future. The judgement call is *how much* of the problem the partial idea explains.
- **Seen in action.** The point-score idea handles one of the three merges. He diagnoses *why* it fails — "the cyclic nature of the manoeuvres" — and that diagnosis names the fix: you need arithmetic that is itself cyclic.
- **Transferable form.** "Diagnose the failure, then find the tool whose defining property is exactly that failure." Cyclic failure $\Rightarrow$ cyclic arithmetic $\Rightarrow$ modular arithmetic.

## Technique 10 and 11: Go modular; then hunt for the right modulus

- **What it is.** Work with remainders instead of integers, so that quantities you *want* to be equal become equal.
- **When to reach for it.** (i) The process is cyclic. (ii) A quantity is "almost" invariant, differing by a fixed multiple. (iii) You want to delete a variable (see Technique 40).
- **Tao's own words** (p. 85): "the only essential difference is that in light, red and green combine into anti-blue, not blue. But wait! We can make blue equal to anti-blue by a modular arithmetic approach."
- **Seen in action, including the failed attempt.** He tries **mod 2** first: the initial state $(13,15,17)$ becomes $(1,1,1)$ and the targets $(45,0,0),(0,45,0),(0,0,45)$ become $(1,0,0),(0,1,0),(0,0,1)$. "Unfortunately, this does not work." (Indeed: mod 2 the move vector $(-1,-1,2)$ is $(1,1,0)$, and from $(1,1,1)$ you *can* reach $(0,0,1)$ in one step — so mod 2 provides no obstruction at all.) Then: "But now the genie is out of the bottle: we can try other moduli. The modulus (mod 3) comes quickly to mind (after all, there are three cyclic colours)."
- **Why it works.** Two independent reasons for the modulus to be 3 here: the merge operation is a 3-cycle on colours, and the move vectors have coordinate changes $-1,-1,+2$, whose differences are all multiples of 3. When the number of types equals the modulus, the "cyclic shift" becomes "add a constant", which is invisible to differences.
- **Failure mode.** Don't fixate on mod 2. Parity is the reflex, and reflexes are sometimes wrong. The upgrade from "try mod 2" to "try *any* modulus" is the actual insight — "the genie is out of the bottle" — and it is a *widening of the search space*, not the discovery of a particular number.

## Technique 12: Keep two parallel formulations alive

- **What it is.** When you have two different framings of the same problem and both stall, apply your new idea to *both*; they may not be equally improved, and their agreement is a free correctness check.
- **Seen in action** (p. 85). Tao explicitly lays out the mod-3 argument twice — once as a vector argument, once as a point-score argument — under the heading "Now we can try either of our two tactics".
- **What it buys you.** Redundancy and insight: the two arguments turn out to be the same argument in different clothing (the point score is the linear functional whose kernel contains all three move vectors mod 3). Seeing that identity is how you learn which framing to reach for next time.
- **Exact wording of the two bullets** (p. 85), because the asymmetry between them is instructive. The vector bullet is *asserted*: "investigation shows that the exchanging of colours can only lead to the vectors $(1,0,2)$, $(0,1,2)$, and $(1,2,0)$" — the word "investigation" hides the work. The point-score bullet begins "Now that we know about moduli, **why not use a modulus point score?**", which is the honest description of the idea: take the tool you just acquired and re-run the attempt that failed.

## Technique 47: When the author waves a check through, do the check

- **What it is.** Texts (and your own drafts) are full of "clearly", "it is easily seen", "investigation shows", "try it yourself". Every one of those is a place where a step has not been verified in front of you. Verify it.
- **Tao's own words** (p. 85): the mod-3 point score "works: the total point score must remain constant (because none of the three merging possibilities will change the total point score—**try it yourself**)."
- **So do it.** There are exactly three merges and the check is nine additions; it is carried out in full in the Route B resolution below. It is worth doing by hand once, because the *pattern* of the check — each merge takes $u+v$ to $2w$ where $\{u,v,w\}=\{0,1,2\}$, and $0+1+2=3\equiv0$, so $u+v = -w \equiv 2w \pmod 3$ — is the actual reason the invariant exists, and you only see it by doing the arithmetic.
- **Why it matters.** In this chapter Tao ships at least three unverified assertions ("investigation shows"; "no point scoring system, it seems"; "it is easily seen that the only possibility for Alice's scores is $2x+y$"), and one outright slip in each of Problems 6.1, 6.2, 6.3 and 6.4 (all flagged below). The chapter is a good advertisement for the habit: **the places a text goes fast are exactly the places its errors live.**

---

## Technique 24: For a game, first prove a strategy *exists*

- **What it is.** Before hunting for the winning strategy, establish that one of the players has one.
- **Tao's own words** (p. 90): "it is easily shown that any finite game of skill must have a winning (or drawing) strategy for one of the players. This is done by induction on the maximum length of the game. Even chess has this restriction, although no-one has found the strategy, which most believe is extremely complicated. Since there are no draws in this game, one player must have a perfect winning strategy … But who?"
- **How the induction goes** (unpacked, since he only gestures). Take a position from which the game lasts at most $k$ more moves. If $k=0$ the game is over and someone has won, so the outcome is determined. If $k>0$, every move leads to a position with maximum length at most $k-1$, whose outcome is determined by induction. The player to move looks at the outcomes of all their options: if any is a win for them, the position is a win for them; if all are wins for the opponent, it's a loss; otherwise a draw. This is *exactly* recursive game-tree evaluation — minimax with memoization — and the induction is just the recursion's termination proof.
- **Why it matters.** It converts an open question ("does anyone have a strategy?") into a binary one ("which player?"), and it licenses proof by elimination: if you can show the second player *cannot* win, the first player must. Exercise 6.8's strategy-stealing argument depends on exactly this licence.
- **Failure mode.** It is non-constructive. Chess is the standing example: the theorem is a one-paragraph proof and the strategy is unknown.

## Technique 26: Restate the problem in several equivalent forms

- **What it is.** Rewrite the same problem in different clothes, hoping one version matches something you know.
- **Seen in action** (pp. 90–91). Three formulations of the chocolate game:
  1. **Chocolate:** break a $6\times10$ bar along grooves, discard the piece you broke off; whoever leaves the opponent with $1\times1$ wins.
  2. **Lattice walk:** "Two players take turns moving a point on a lattice either an integer number of steps to the left or an integer number of steps downward. The point cannot pass either of the axes, and starts at $(6,10)$. The winner is the one who reaches $(1,1)$."
  3. **Counters:** "Two players take turns removing counters from two rows … At the beginning there are five counters on the top row and nine on the bottom row (this represents the point $(6,10)$). The winner is one who takes the last counter."
- Formulation 3 comes from subtracting 1 from each coordinate, which moves the terminal position from $(1,1)$ to $(0,0)$ — a change of coordinates chosen purely to make the endpoint clean. Tao says it explicitly: "This formulation has been modified a bit by subtracting 1 from both the top and bottom row." And: "It should give strong hints to anyone familiar with the game of Nim; those people would solve the question easily now. But we can do the question without the knowledge of Nim **and related Game theory**."
- **Note his framing of the move to formulation 2** (p. 91): "Now that we have a nice mathematical model of the chocolate, we can restate the question mathematically **(but less deliciously)**." The joke matters: reformulation *costs* something. You give up the physical intuition that told you a break is a straight line, and in exchange you get a model you can compute with. Make the trade knowingly, and keep the discarded intuition available (he uses "anyone who has broken a chocolate probably knows…" to justify the rules in the first place).
- **Why it works.** Recognition is the cheapest form of problem solving. Reformulation is how you *maximize your chance of recognition* — you're rotating the problem until it lines up with something in your library. Note also his willingness to proceed without the library (see Technique 32): knowing the theory is a shortcut, not a prerequisite.

## Technique 56: A model is not yet a grip — go and experiment

- **Tao's own words** (p. 91), the sentence that joins the modelling half of the problem to the solving half: "Now we have notation, and an abstract mathematical model. **What we need now is a good grip on the problem.** The problem is that the $6\times10$ bar has so many possibilities. We should start with a much smaller bar to experiment."
- **Why it deserves naming.** It is very easy to mistake having formalized a problem for having understood it. The formalization tells you what the legal moves are; it tells you nothing about who wins. The next action is not more algebra, it is **playing the game by hand**. Notice that everything Tao does for the rest of the problem — $2\times3$, $3\times3$, the $3\times4$ template, the table — is experiment, not deduction. The deduction (the induction proof he says "you can" do) is never written down at all.

### The two diagrams on pp. 90–91 (described so you can redraw them)

**Figure 1 (p. 90), the breaking of the bar.** A $6\times10$ grid of unit squares — 6 rows tall, 10 columns wide, all gridlines drawn. One *dotted* vertical line runs top to bottom between the 7th and 8th columns. Everything left of the dotted line (a $6\times7$ block) is what remains; the $6\times3$ block to the right is eaten. The point of the picture: a legal break is a single straight cut all the way across, never a zig-zag, so the survivor is always a rectangle sharing one full dimension with the original.

**Figure 2 (p. 91), the game as motion in the plane.** First-quadrant axes (arrow up on the vertical axis, arrow right on the horizontal). A filled dot at $(6,10)$, labelled. From it, a horizontal arrow pointing **left** ending at a labelled point $(3,10)$; and a vertical arrow pointing **down** ending at a labelled point $(6,7)$. A second filled dot down near the origin labelled $(1,1)$ — the target. In ASCII:

```
  ^
  |
  |   (3,10)
  |     <-----------@ (6,10)
  |                 |
  |                 |
  |                 v (6,7)
  |
  |  @ (1,1)
  +------------------------->
```

So a move is: *decrease exactly one coordinate*, by any positive amount, never below 1.

## Technique 27 and 28: Specialize to small cases; use symmetry to cut them

- **What it is.** Replace the stated instance by the smallest instance you can still learn from, and solve that by hand.
- **Tao's own words** (p. 91): "The problem is that the $6\times10$ bar has so many possibilities. We should start with a much smaller bar to experiment."
- **Seen in action.** $2\times3$ first, then $3\times3$. And symmetry: from $3\times3$ the options are $1\times3,2\times3,3\times2,3\times1$, but "symmetry effectively eliminates the last two choices" — since only the multiset of dimensions matters, $3\times2$ *is* $2\times3$. That halves the work at every step.
- **Why it works.** Small cases produce *data*, and data produces conjecture. It also debugs your model: playing $2\times3$ by hand is how you confirm you've got the win condition right.
- **Failure mode Tao flags.** Small cases can be *too* small to be informative: "Not much information is gained, so let us move on to another example, say a $3\times3$ bar." One data point is not a pattern. He keeps escalating until the pattern is visible.

## Technique 29: Recognize an already-solved sub-problem — possibly with the roles swapped

- **What it is.** When your move leads to a position you have already fully analysed, quote your earlier result instead of re-deriving it — remembering that *the player whose turn it is has changed*.
- **Tao's own words** (p. 92): "$2\times3$ is equally bad, because we have reduced the problem to that of the last paragraph! Now the second player uses the strategy that the first player would have used in the last paragraph."
- **The full mechanism** (p. 92), because Tao spells out the role reversal move by move: "Now the second player uses the strategy that the first player would have used in the last paragraph: get a $2\times2$ bar, leaving the first player with no choice but to break off a $1\times2$ bar, which the second player then breaks into a $1\times1$ bar and wins. So the first player loses with a $3\times3$ bar."
- **Why it works.** This is the reduction step that turns brute-force analysis into induction. The subtle part is the role reversal: "first player wins from $2\times3$" is a statement about *whoever moves next*, so handing a $2\times3$ bar to your opponent is handing them a win.
- **Programming analogue.** Memoizing a recursive game evaluation, where the cached value is "value to the player to move" rather than "value to player 1". Getting that convention wrong is the classic bug, in maths as in code.

## Technique 54: Turn the solved small case into an explicit induction template

- **What it is.** After a small case falls to a smaller one, write down the *general shape* of that reduction before you generalize any further. Do it on a case you have not yet solved, using hypothetical knowledge, so the shape is visible without arithmetic getting in the way.
- **Tao's own words** (p. 92) — a paragraph the reader is likely to skim, and it is the hinge of the whole problem: "We solved the $3\times3$ problem by looking at the $2\times3$ problem. This suggests an induction approach for the general problem. For example, suppose we wanted to solve the $3\times4$ problem, and we already knew that, say, the $3\times1$, $3\times2$, $1\times4$, and $2\times4$ problems were all winners for the first player, while $3\times3$ was a loser for the first player. Then the strategy of the first player in the $3\times4$ problem would be to leave a $3\times3$ square with the second player, because that it is a sure loser for the second player."
- **Unpack the $3\times4$ illustration**, since it is the only place the induction is exhibited concretely. From $3\times4$ the legal moves are $3\times1,3\times2,3\times3$ (cutting the length) and $1\times4,2\times4$ (cutting the width) — five options. Suppose you have already labelled all five: four winners and one loser ($3\times3$). Then $3\times4$ is a winner, and the winning move is the unique one landing on the loser. **Nothing about chocolate is used** — only the labels of the five children. That is what makes it an induction: every position's label is determined by the labels of strictly smaller positions.
- **Then Tao states the induction in words** (p. 92): "So the strategy for the first player is to leave the second player with bars that are sure losers for the one who has to break them. And why are these bars sure losers? Because no matter how you break them, they become sure winners for the other player. And these bars are sure winners because one can break them into a sure loser for the other player, and so on. **So our strategy now is to find all the sure winners and sure losers.**"
- **Why the template step is worth doing separately.** It converts "I solved $3\times3$" (a fact) into "here is a procedure that labels any position given smaller ones" (an algorithm). Once you have the algorithm, the remaining work is bookkeeping, and bookkeeping is where a *pattern* becomes visible. Skipping the template is how people end up re-deriving each case from scratch.

## Technique 30: Backward induction — label every position sure-winner or sure-loser

- **What it is.** Start at the terminal position, whose value you know, and propagate labels backwards using two rules:
  - a position is a **sure winner** (for the player about to move) if *some* move leads to a sure loser;
  - a position is a **sure loser** if *every* move leads to a sure winner.
- **Tao's own words** (p. 92): "the strategy for the first player is to leave the second player with bars that are sure losers for the one who has to break them. And why are these bars sure losers? Because no matter how you break them, they become sure winners for the other player."
- **Seen in action, the actual chain** (p. 92):
  - $1\times1$: sure loser. "$1\times1$ is an obvious sure loser for the one who is stuck with it; it can not be broken, so the game is over."
  - $1\times n$ for $n>1$: sure winner — "the breaker can leave the other player with the sure loser, $1\times1$".
  - $2\times2$: sure loser — "the breaker must end up with a $1\times2$ bar, which is a sure winner for the other player".
  - $2\times n$ for $n>2$: sure winner — "we can land the other player with the sure loser, $2\times2$. And so forth."
  - And two general rules he records:
    - **Rule (i)** — *"If $a\times b$ is a sure loser, than $a\times c$ (with $c>b$) is a sure winner, because the person who breaks $a\times c$ should leave the other player with $a\times b$."* His worked example: "because we have shown that $3\times3$ is a sure loser, then $3\times4$, $3\times5$, $3\times6$, etc. are all sure winners." Note this is the cheap rule — **one** good child suffices, so one known loser generates an entire infinite family of winners in a line.
    - **Rule (ii)** — *"$a\times b$ is a sure loser only when all the possible moves from it are sure winners for the other player."* This is the expensive rule: you must check **every** child. His worked example: $1\times4$, $2\times4$, $3\times4$ and (by symmetry) $4\times3,4\times2,4\times1$ are all winners, hence $4\times4$ is a loser.
  - **The asymmetry between the two rules is the content.** Proving a *winner* costs one move; proving a *loser* costs an exhaustive check. That is why the losers are the interesting, sparse set (here: the squares), and why they are what you conjecture a formula for.
- **Erratum worth flagging.** In the second bullet on p. 92 the printed text reads "$1\times4$, $2\times4$, $3\times4$, and by symmetry $4\times3,4\times2,4\times1$ are all sure **losers**, as we have shown above, hence $4\times4$ must be a sure loser." The word should be **winners** — that is what was shown above (by rule (i), since $1\times1$, $2\times2$, $3\times3$ are losers), and it is what makes $4\times4$ a loser under rule (ii). The logic is right; the word is a slip.
- **Small subtlety to check for yourself.** Rule (ii) requires *every* move from $4\times4$ to be a winner. The moves are $4\times1,4\times2,4\times3$ and $1\times4,2\times4,3\times4$ — six positions, and Tao's list covers exactly those six. So the check really is complete; symmetry ($a\times b$ is the same bar as $b\times a$) is what lets him halve it.
- **Why it works.** The two rules are the AND/OR structure of a game tree (a win needs *one* good child; a loss needs *all* children bad). In modern language sure losers are "P-positions" (good for the *previous* player) and sure winners are "N-positions" (good for the player to move).
- **Failure mode.** It is exponential if you do it naively. Which is why:

## Technique 31 and 32: Tabulate, conjecture the pattern — then verify rather than prove

- **What it is.** Lay the computed labels out in a grid, read off the pattern, and then *use* the conjectured pattern as a strategy, checking as you go that it holds up.
- **Tao's own words** (p. 93): "One can continue this systematic method, eventually reaching $6\times10$. But why do not we be more mathematical? There should be a pattern to the sure winners and losers. **Well, what are the winners and losers we know so far?**"
- **The table he writes** (p. 93), reproduced literally. He lists the sure *winners* worked out so far, laid out so the hole in each row is impossible to miss:

```
        1×2  1×3  1×4  1×5  …
2×1          2×3  2×4  2×5  …
3×1  3×2          3×4  3×5  …
4×1  4×2  4×3          4×5  …
```

The same thing as a labelled grid (W = sure winner for the player about to move; the blank cells are the positions *not* in his winners list):

|  | $\times1$ | $\times2$ | $\times3$ | $\times4$ | $\times5$ | … |
|---|---|---|---|---|---|---|
| $1\times$ | — | W | W | W | W | … |
| $2\times$ | W | — | W | W | W | … |
| $3\times$ | W | W | — | W | W | … |
| $4\times$ | W | W | W | — | W | … |

and, quoting him, "the sure losers that we have identified are $1\times1$, $2\times2$, $3\times3$, and $4\times4$" — exactly the gaps, i.e. the diagonal. Verdict: "**This is pretty convincing evidence that the only sure losers are $n\times n$ bars: that is, square bars, and all others are sure winners.**"
- **Why the *layout* is doing the work.** The winners were derived one at a time by two different rules on two different pages; nothing in the derivations says "diagonal". Arranging them in a rectangular array is what makes the pattern a *visual* fact. This is the cheapest and most underrated technique in the chapter: **choose a layout in which the answer would be obvious if it were true.** For a CS reader: this is why you print a 2-D memo table rather than a list of `(key, value)` pairs.
- **Note also what the table is missing.** Four rows and five columns of a doubly infinite table, and one of the four losers ($4\times4$) was itself obtained by a rule rather than by playing. Tao calls this "pretty convincing evidence" — not proof — and the next sentence explains why he is content with evidence:
- **The metacommentary, which is the real content** (p. 93): "Once we have this conjectured strategy, we do not even have to prove it (although you can, with induction): we just have to apply it. **Remember we want to leave the opponent with losers. Once we guess what the losers are, we can make the strategy to always force them on the opponent.** If the strategy works all the time, then fine. If not, then the guess was wrong. **To summarize, if our guess is correct, the best strategy is to give the other player a square.**"
- **Why this is legitimate.** For a *strategy*, correctness is self-certifying. You don't need the theorem "squares are losers"; you need "my recipe never gets stuck and always terminates in a win". Checking that directly is easier than the induction: from a non-square you can always square down (cut the longer side to match the shorter), and from a square your opponent must produce a non-square. So the two facts he checks are exactly the two needed:
  - "whenever the opponent breaks the square, he gets a non-square that can be easily converted to a square again";
  - "because the size of the chocolate is decreasing, the square conversion must eventually lead to a $1\times1$ square" — **Technique 33, a strictly decreasing measure**, i.e. the loop terminates because the bar's area is a natural number that strictly drops each move.
- **Failure mode.** "If not, then the guess was wrong" is doing real work here — this is *fail-fast*, not hand-waving. You still have to actually check. And note the honest self-assessment: "with a bit of semi-rigorous maths we have ended up with a working strategy, which is what we were after." He knows what he's traded away and says so.

## Technique 34: Land the abstraction back in intuition

- **Tao's own words** (p. 93), in full, including the rhetorical question in the middle that carries the point: "Anyway, this is a standard approach in solving games of skill: determine all winning and losing positions, then always move to a winning position. Any decent skill-game player uses this method, except that they have an imprecise idea of winning and losing positions, only 'favourable' and 'unfavourable' positions. **After all, do not we say a move in, say, chess, is a 'good' or a 'bad' game because it creates a favourable or unfavourable position?** Few players of chess succeed by moving randomly, not trying to improve their position."
- **Why it matters.** The formal machinery of P- and N-positions is presented as the *rigorous version of ordinary good play*. That reframing is what makes the technique memorable and portable: you already know how to do this approximately; the mathematics is just doing it exactly. Note the direction of the argument: he is not saying "chess players are doing crude mathematics", he is saying "the mathematics is what your existing instinct would be if it were exact". That is a much more usable claim, because it tells you where to *get* candidate ideas — from your own rough sense of which positions feel good.
- **Bookend it against Technique 24.** The chapter opens the game section with a theorem that a strategy exists but says nothing about it (chess), and closes it with the observation that a human chess player's fuzzy heuristics *are* the missing content. Between those two poles sits the whole practical craft: the theorem gives you permission, the heuristic gives you candidates, and backward induction turns candidates into certainties on games small enough to compute.

## Technique 35: Strategy stealing

- **What it is.** To show the first player is not at a disadvantage, suppose the *second* player has a winning strategy; then let the first player make an arbitrary move and thereafter follow the second player's strategy, treating their extra stone as harmless. Contradiction.
- **Where.** The hint to Exercise 6.8 (p. 94): "you have to argue by contradiction. Show that if the first player cannot force at least a draw, then the second player has a winning strategy. Now make the first player 'steal' that strategy."
- **Why it works.** In a game where extra pieces on the board can never hurt you (Gomoku is such a game — an extra stone of your colour can only help make five in a row, and never blocks you), the first player can simulate the second player's play. The first step of the argument is the existence meta-theorem (Technique 24): "cannot force a draw" must mean "the opponent can force a win", and only a completeness result gives you that.
- **Failure mode.** Strategy stealing proves *existence* and reveals nothing about the strategy — it does not tell you how to play Gomoku. And the "extra piece never hurts" premise must genuinely hold; there are games where an extra move is a liability (zugzwang in chess), and there the argument collapses.

---

## Technique 13: Mine the problem for hidden data

This is the spine of Problems 6.2 and 6.4, so it deserves its own entry.

- **What it is.** When you "don't have enough information", enumerate the constraints you haven't written down: that unknowns are **integers**, that they're **positive**, that they're **distinct**, that they're **ordered**, and — crucially — whatever the *wording* of the problem implies.
- **Tao's own words** (p. 86): "There is precious little information in this question … But we may, because we have other data at our disposal." And (p. 87): "we must keep in mind that $N$, $x$, $y$, $z$ are positive integers, not just real numbers. Also, we have a fourth piece of data: $x$, $y$, and $z$ are distinct. These weapons will reduce the possibilities."
- **And the wording counts as data** (p. 87): $N=1$ is rejected because it "contradicts the semantics of the question, which implies that there are at least two exams (Algebra and Geometry)". Likewise (p. 97) "$p$ probably had to be positive (why mention a worthless penknife in the question)".
- **Why it works.** A real-valued equation in four unknowns has a continuum of solutions; the same equation in *positive integers* often has a handful, and with *distinctness* and *ordering* often exactly one. Integrality is not a technicality, it is the main hypothesis.
- **Failure mode.** Semantic inferences are softer than algebraic ones. Tao hedges them ("the wording of the problem seems to suggest that $a$ is non-zero", p. 95) and — best practice — later checks the answer survives without them: "(Note that this argument works even if we allow $a$ to be zero.)" (p. 97). **If you must lean on an interpretation, verify afterwards that you didn't need it.**

## Technique 48: Cross-match one piece of data against another

- **What it is.** Rather than processing your facts one at a time, deliberately pick up two of them and ask what they say *jointly*.
- **Tao's own words** (p. 86): having noticed the odd fact that each exam awards exactly one $x$, one $y$ and one $z$, he asks "How can we exploit it? First of all, **we can try to match it with our third piece of data**, that Betty was first in Algebra."
- **The payoff.** Neither fact alone says anything numeric. Together: the three Algebra marks are $\{x,y,z\}$, "first" means largest, therefore Betty's Algebra mark is $\max\{x,y,z\}$ — and once you also give yourself the labelling $x>y>z$ (Technique 14) that is the clean statement "Betty scored $x$ in Algebra", which is the fact the whole rest of the solution is built on.
- **Why it works.** Facts in a puzzle are almost never independently useful; they are useful in pairs. A checklist of data (Technique 44) is only step one — step two is the pairwise sweep. With $k$ facts there are only $\binom{k}{2}$ pairs, so this is a cheap, finite search that you can actually complete.

## Technique 49: Keep a running list of what you still do not know — and what partially settles each item

- **What it is.** After every breakthrough, stop and write down the remaining unknowns explicitly, together with whatever you already know that bears on each.
- **Tao's own words** (pp. 87–88), immediately after collapsing the four cases to one: "Now we have far fewer possibilities. **But we still do not know two things that should be important: we do not know the exact values of $x$, $y$, and $z$; and we do not know how everyone scored in each exam.** The first question is partially handled by the fact that $x$, $y$, and $z$ are distinct positive integers that add up to 13, while the second question is partially answered by the fact that we know Betty scored a $x$ in Algebra. **How can we improve on these partial results?**"
- **Why this is a technique and not just tidiness.** It does three things at once. (i) It converts a vague feeling of being stuck into a finite agenda ("two things"). (ii) It attaches to each item the constraint that already bites on it, so you can see which item is closer to falling. (iii) It generates the *next question* automatically — "how can we improve on these partial results?" is a well-posed thing to work on, whereas "what now?" is not.
- **CS analogue.** A `TODO` list with, next to each item, the tests that already pass. Progress becomes measurable, and you stop re-solving the parts that are done.

## Technique 50: Audit which data has not been used *fully*

- **What it is.** The stronger version of "which fact haven't I used?". Ask instead: which fact have I used only *partially*?
- **Tao's own words** (p. 88): "Well, **the one piece of data that has not been used fully is the individual total scores.**"
- **Why the distinction matters.** At that point in Problem 6.2 every fact has been used at least once: the totals produced $20+10+9=39$, the per-exam structure produced $N(x+y+z)=39$, distinctness killed two cases, and "Betty first in Algebra" is on the board. A naive audit would report "all data used" and stop. But the totals were used only in *aggregate* — as their sum 39 — and the fact that they are specifically $20$, $10$, $9$ (very unequal, with Alice far ahead) has not been touched at all. That unexploited asymmetry is exactly what produces the conjecture "Alice scored $2x+y$", and it is what later gives the decisive bound $x\le8$.
- **How to run the audit.** For each fact ask: *did I use the whole fact, or a consequence of it?* Sums, counts and totals are the usual culprits — collapsing several numbers into one throws away everything except the sum. Whenever you do that, note that the individual numbers are still on the table.

## Technique 51: Speculate in words, then make the speculation "solid"

- **What it is.** Allow yourself an explicitly unjustified guess in English, then immediately demand of yourself that it be converted into an inequality. Tao signposts the conversion with two stock phrases: "**To be specific:**" and "**Can we put this speculation into solid mathematics?**"
- **Seen in action, three times on p. 88.**
  1. The Alice/Carol speculation: "Alice did rather better than Betty and Carol, implying that she probably got high marks (i.e. $x$'s and $y$'s) in each subject … **Likewise, Carol would be unlikely to score the top mark of $x$ in any of the exams, and it is more than likely that she would be scoring mostly $z$'s. Can we put this speculation into solid mathematics?**" (The Carol half is often dropped in summaries; it is the reason he is willing to believe Alice is at the top of her range.)
  2. The answer he gives himself: "**The answer is at first, a 'maybe'.**" — i.e. the speculation is *not* yet mathematics, and he says so before proceeding.
  3. The bound on $z$: "$z$ cannot go too high, because then $x$ and $y$ will have to go high as well, and then $x+y+z$ will **probably** be forced to go higher than 13. **To be specific:** $y$ is at least $z+1$, and $x$ is at least $z+2$, so $13 = x+y+z \ge (z+2)+(z+1)+z = 3z+3$."
- **Why the two-step is better than either step alone.** Pure speculation is unusable; pure formalism gives you nothing to formalize. The speculation supplies the *target* ("$z$ is small", "Alice got mostly $x$'s") and the formalization supplies the *proof*. Note that in step 3 the word "probably" survives into the intuition and is *gone* from the inequality — that is the whole discipline in one sentence.
- **Failure mode.** Speculations that never get converted. Tao's "maybe" is a promissory note, and he pays it: the guess "$2x+y$" is only accepted three paragraphs later, after $x\le8$ makes every alternative arithmetically impossible.

## Technique 52: Announce the next sub-goal before doing the work

- **Tao's own words** (p. 88): "But to try to prove this rigorously, we need some decent upper bounds on $x$, $y$, and $z$. **So this is our next task: to limit $x$, $y$, and $z$ so we can eliminate several possibilities.**"
- **Why it earns a line.** The bounds on $x,y,z$ are not interesting in themselves and nobody asked for them; they are instrumental. Stating the sub-goal explicitly is what stops "find bounds" from turning into an aimless algebra session — he knows in advance exactly how good a bound has to be (good enough to push $2x+z$ below 20), and he stops as soon as it is.
- **Companion move.** He also states when a sub-goal is *finished and cannot be improved*: "Now this bound $z\le3$ is the best one can do without any further information, for there is the combination $x=6,y=4,z=3$" (Technique 20). Knowing when to stop is half of knowing what to do.

## Technique 53: Report your partial progress — narrow to a short list, then keep going

- **Tao's own words** (p. 89), after filling in the first table: "**We are getting closer to our goal; we know that it is either Betty or Carol that scored the second-place mark of $y$ in Geometry. But we are still not done yet.**"
- **What it is.** Convert your current knowledge into a statement about *the actual question asked*, even when it is not yet an answer. Here the question is "who was second in Geometry?", and the honest current answer is "Betty or Carol" — the answer set has gone from three names to two.
- **Why it is worth doing.** It measures progress in the units of the problem rather than in units of algebra. It also tells you how much more you need: one more bit. And in an exam it is the difference between a blank page and a partially credited one. Note the immediate self-correction — "But we are still not done yet" — which is the guard against declaring victory on a two-element answer set.

---

# Worked problems

## Problem 6.1 — Chameleons on an island (Taylor 1989, p. 25, Q5; book p. 83)

**Statement.** An island has 13 grey, 15 brown, and 17 crimson chameleons (45 in all). When two chameleons of *different* colours meet, both change to the third colour — e.g. a brown and a crimson both become grey. That is the only way they change. Can all 45 chameleons ever end up the same colour?

**The data / the objective.** The data are the three counts and one operation. The objective as stated is vague — "eventually" — and Tao's first move is to sharpen it: "we have to decide whether the set of all possible chameleon colour combinations includes a state where all chameleons are a single colour."

### The chain of moves

1. `[guess the answer first — Technique 1]` Bet on NO, because a YES would be a "specific procedure", which "sounds more computational than mathematical", and this was a tournament problem. "So let us try to prove NO."
2. `[strengthen the conclusion; explore for a pattern — Techniques 2, 2b]` Don't aim at "these three states are unreachable"; aim at "here is the set of reachable states". "Once we have found a pattern, we will have something definite to prove." Illustrated by the bishop: prove "the bishop must stay on the same colour square", not "the bishop starting on a corner cannot move onto an adjacent corner".
3. `[get notation; strip the state — Techniques 3, 4]` State $=(\text{grey},\text{brown},\text{crimson})$, initially $(13,15,17)$. Targets $(45,0,0)$, $(0,45,0)$, $(0,0,45)$. A move "consists of subtracting 1 from two of the coordinates and adding 2 to the third one". Justification for using only three numbers: "(The set-up of the problem does not permit the chameleons to take on any additional colours.)"
4. `[vector model — Technique 5]` The three possible moves are the vectors
$$a=(-1,-1,2),\qquad b=(-1,2,-1),\qquad c=(2,-1,-1),$$
so every reachable state is $(13,15,17)+la+mb+nc$ with $l,m,n$ integers. "Then all you need to show is that a number like $(45,0,0)$ cannot be represented in that form." Tao calls the vector formulation "actually one way of attacking the problem" and says the rest is "a simple matter in, say, Cramer's rule, or just elementary Diophantine manipulation." All of this is delivered inside a parenthesis labelled "For a brief sketch of the proof here".
5. `[go looking for a nicer proof anyway — Technique 45]` "Let us try for a more elegant method, as outlined above: find all possible colour combinations of the chameleons." He has a complete proof and abandons it on aesthetic grounds. That decision is what produces everything worth learning here.
6. `[first candidate invariant — Technique 6]` "First of all, the total number of chameleons must remain the same." Always 45. True, and useless — all three targets also total 45. Abandoned, with the note that "This is not overly helpful in this case (although considering total populations can be a good idea sometimes in similar questions)."
7. `[focus on the operation — Technique 46]` "Second, two different colour chameleons 'merge' into another colour. **This merging can be focussed on.**" The pivot from studying the state to studying the verb.
8. `[physical analogy — Technique 7]` "When, say, two uneven containers of water are connected at the base, the levels of water 'merge' into the middle ground. But the total amount of water remains the same. So can we say that the 'total amount of colour' remains constant?" Followed immediately by the demand for rigour: "Obviously we have to define 'total amount of colour' to make this good mathematics."
9. `[point-score invariant — Technique 8]` "Take, as an example, a grey chameleon and a crimson chameleon 'merging' into two brown chameleons." Define grey $=0$, brown $=1$, crimson $=2$; total colour $=$ sum of scores. Check: $0+2=2$ and $1+1=2$. ✔ ("A 0 and a 2 join into two 1's.")
8. **Dead end.** Check crimson $+$ brown $\to$ two greys: $2+1=3$ before, $0+0=0$ after. ✘ And no reassignment of three fixed integers can fix all three merges. Verdict: "No point scoring system, it seems, can cater for all three (or even two) possibilities of merging."
9. `[diagnose the failure — Technique 9]` "The problem is due to the cyclic nature of the manoeuvres." Don't discard: "A partially successful … attempt may be a piece of a truly successful approach."
10. `[second analogy — Technique 7]` Primary colours of *light*: red $+$ green $=$ "anti-blue", and the primaries cycle. The mismatch with the puzzle is exactly one sign: light gives anti-blue where we want blue.
11. `[go modular — Technique 10]` "We can make blue equal to anti-blue by a modular arithmetic approach."
12. **Dead end.** Try **mod 2**. Start $(13,15,17)\equiv(1,1,1)$; targets $\equiv(1,0,0),(0,1,0),(0,0,1)$. "Unfortunately, this does not work." (Mod 2 the move $a=(-1,-1,2)$ is $(1,1,0)$, so $(1,1,1)+(1,1,0)=(0,0,1)$ — a target is reachable in the mod-2 model, so mod 2 gives no obstruction whatsoever.)
13. `[widen the search — Technique 11]` "But now the genie is out of the bottle: we can try other moduli. The modulus (mod 3) comes quickly to mind (after all, there are three cyclic colours)."
14. `[apply the idea to both live formulations — Technique 12]` Redo *both* the vector attack and the point-score attack mod 3. Both go through.

### The resolution

**Route A — the vector/mod-3 route.** Reduce each move vector mod 3:
$$a=(-1,-1,2)\equiv(2,2,2),\quad b=(-1,2,-1)\equiv(2,2,2),\quad c=(2,-1,-1)\equiv(2,2,2)\pmod 3 .$$
All three are the *same* mod 3, namely $(-1,-1,-1)$. So **every move subtracts 1 from all three coordinates, mod 3.** Consequently the *differences* between coordinates are untouched mod 3.

Start: $(13,15,17)\equiv(1,0,2)\pmod 3$ — three *distinct* residues. Since every move shifts all three equally, they stay distinct forever. The reachable residue classes are just the three shifts
$$(1,0,2)\ \to\ (0,2,1)\ \to\ (2,1,0)\ \to\ (1,0,2)\ \to\cdots$$
Every target — $(45,0,0)$, $(0,45,0)$, $(0,0,45)$ — is $\equiv(0,0,0)$ mod 3, all three residues *equal*. Unreachable. **Answer: no.**

> *A note on the printed text.* On p. 85 the list of reachable vectors is given as "$(1,0,2)$, $(0,1,2)$, and $(1,2,0)$". The first is right; taking the reduction above, the cycle is $(1,0,2)\to(0,2,1)\to(2,1,0)$, so the second and third entries appear to be a misprint. Nothing in the argument depends on it — the operative fact, which the printed entries also satisfy, is that every reachable class has its three residues *all different*, while $(0,0,0)$ has them *all the same*.

**Filling in the "elementary Diophantine manipulation" (Route A′).** Tao only sketches this. Suppose $(13,15,17)+la+mb+nc=(45,0,0)$. Coordinate by coordinate:
$$-l-m+2n=32,\qquad -l+2m-n=-15,\qquad 2l-m-n=-17 .$$
(Only two are independent, since $a,b,c$ each have coordinates summing to zero — that's the useless total-population invariant showing up as a linear dependence.) Subtract the first from the second:
$$3m-3n=-47 .$$
The left side is a multiple of 3; $-47$ is not. **No integer solution.** For $(0,45,0)$ you get $3m-3n=43$, and for $(0,0,45)$ you get $3m-3n=-2$; neither is a multiple of 3 either. This is the mod-3 invariant in disguise — same content, different presentation.

**Route B — the mod-3 point score.** Keep the weights but read them mod 3: grey $\equiv0$, brown $\equiv1$, crimson $\equiv2 \pmod 3$. Total score $= 0\cdot(\text{grey}) + 1\cdot(\text{brown}) + 2\cdot(\text{crimson})$, mod 3.

Check invariance on all three merges:
- grey $+$ brown $\to$ two crimson: before $0+1=1$; after $2+2=4\equiv1$. ✔
- grey $+$ crimson $\to$ two brown: before $0+2=2$; after $1+1=2$. ✔
- brown $+$ crimson $\to$ two grey: before $1+2=3\equiv0$; after $0+0=0$. ✔

Initial score: $13\times0+15\times1+17\times2 = 0+15+34 = 49 \equiv 1 \pmod 3$.
Target scores: 45 grey $\to 45\times0=0$; 45 brown $\to 45\times1=45\equiv0$; 45 crimson $\to 45\times2=90\equiv0$. All $0$.

$1 \ne 0$ mod 3, so no target is reachable. **Answer: no, they can never all be the same colour.**

*Why the mod-3 score works when the integer score didn't:* over the integers you needed $w\cdot a=w\cdot b=w\cdot c=0$ with $w=(0,1,2)$, and $w\cdot a = 0\cdot(-1)+1\cdot(-1)+2\cdot 2 = 3 \ne 0$. But $3\equiv 0$ mod 3. The integer attempt missed by exactly a multiple of 3 in every case — which is precisely what "partially successful" meant, and precisely what the modulus repairs.

### Transferable lesson

To prove a process can't reach a state, find a quantity the process cannot change, and check it differs at the target. If your first candidate is conserved but doesn't separate start from target, it's too coarse — refine it. If your candidate almost works and fails by a consistent amount, work modulo that amount. And if the operations cycle through $k$ types, mod $k$ is your first guess for the modulus.

---

## Exercise 6.1 — Six musicians (book pp. 85–86)

**Statement, as printed:** "Six musicians gathered at a music festival. At each concert some musicians played in the concerts while the others listened, as part of the audience. What is the least number of concerts needed to be scheduled in order that each musician may listen, as part of the audience, to every other musician?"

**Tao's hint, in full** (the ellipsis is his): "Obviously not everyone can listen to everyone else in one concert, so more than one concert is needed to exhaust all the 'listening possibilities' … think upon these lines and also of 'point-scoring' ideas, and you will get a reasonable lower bound for the number of concerts needed. Then find an example satisfying this lower bound—and you have solved it."

**Read the hint as a three-part instruction**, because it is one: (1) *count the "listening possibilities"* — there are $6\times5=30$ ordered pairs to satisfy, and one concert can satisfy at most (players)$\times$(listeners) $\le 3\times3=9$ of them, which already forces at least $\lceil 30/9 \rceil = 4$ concerts; (2) *"point-scoring ideas"* — the same weighted-count device that solved Problem 6.1, now used to bound rather than to obstruct; (3) *"then find an example"* — the construction, which is a separate job. The hint is also telling you the answer is small: it says "find an example satisfying this lower bound", i.e. the naive bound is achieved.

**The technique this exercise is drilling.** The **two-sided attack on an optimum**: (i) a counting / point-scoring argument gives a lower bound "you need at least $k$"; (ii) an explicit construction gives "$k$ suffices". Together they pin the answer. This is the single most common shape of a combinatorial optimization proof, and it is worth noticing that it needs *both* a proof and a construction — Technique 1's advice to bet on "impossible" does not apply here.

**Sketch of a clean finish** *(not in the book — my own; included so you can see the shape of the argument).* Describe each musician by the **set of concerts in which they play**. Musician $i$ hears musician $j$ iff there is a concert where $j$ plays and $i$ does not — i.e. iff $S_j \not\subseteq S_i$. So we need six sets, none contained in any other, drawn from the $k$ concerts. With $k=3$ concerts, the largest family of mutually non-nested subsets of a 3-element set has size 3 — not enough for six musicians. With $k=4$, take the six *two-element* subsets of $\{1,2,3,4\}$: no 2-set contains another, so all $6\times5=30$ listening requirements are met. Hence **4 concerts**, with each concert having 3 players and 3 listeners.

**Transferable lesson.** "Least number of X" always means two proofs. And re-encoding people as *sets* (Technique 3: get notation) turns a scheduling puzzle into a statement about containment.

---

## Exercise 6.2 — Three grasshoppers (book p. 86)

**Statement, exactly as printed:** "Three grasshoppers are on a line. Each second, one (and only one) grasshopper hops over another. Prove that after 1985 s, the grasshoppers cannot be in their starting positions."

**Note what the book does *not* give you.** Unlike Exercises 6.1 and 6.3, this one comes with **no hint at all** — and it does not define "hops over". Both omissions are data of a kind. The absence of a hint, sitting between two hinted exercises, signals that Tao thinks the technique is already in your hands from Problem 6.1 (invariant, mod 2). The absence of a definition means you must fix one; the standard reading is that a grasshopper at $P$ hopping over one at $Q$ lands at $2Q-P$, i.e. it reflects through the other. Everything below assumes that.

**The technique.** A `[parity invariant — Techniques 6, 8, 10]` problem: the same shape as the chameleons, with modulus 2.

**Sketch.** Record only the **left-to-right order** of the three grasshoppers — a permutation of $\{A,B,C\}$. A hop over a neighbour interchanges exactly two of them in that order, i.e. applies a single swap. A single swap flips the *parity* of the permutation (the three orders $ABC, BCA, CAB$ are "even"; $ACB, BAC, CBA$ are "odd"). So the parity alternates every second: after an **odd** number of seconds the order must have the opposite parity to the start. $1985$ is odd, so the order is different — and if the order is different, the positions certainly are. Done, with no reference to where anybody actually landed.

*(Caveat, stated honestly: this argument reads "hops over another" as hopping over a single grasshopper, so that only two of the three exchange places. If a grasshopper were permitted to fly clear over both others in one hop — which the printed statement does not explicitly forbid — the order would change by a 3-cycle, which is even, and the argument would need repair. Since reflecting through a single grasshopper always lands you strictly between-or-beyond exactly that one, the natural reading is the one used here.)*

**Transferable lesson.** When a question mentions a specific large odd (or even) number like 1985, it is almost always advertising a parity invariant. (Compare Problem 6.1, where "13, 15, 17 chameleons" was advertising mod 3, and the tell was that there were *three* colours cycling.) Also: the *right state* to track is often much coarser than the literal state — here, the ordering rather than the positions. Note that this is Technique 4 (strip the state) applied ruthlessly: you throw away all the real-number coordinates and keep six possible values.

---

## Exercise 6.3 — Four checkers, from a unit square to a side-2 square (book p. 86)

**Statement, close to the printed wording:** "Suppose four checkerboard pieces are arranged in a square of sidelength one. Now suppose that you are allowed to make an **unlimited** amount of moves, where in each move one takes one of the checkerboard pieces and jumps over it, so that the new location of that piece is the same distance from the piece jumped over as the original location (but in the opposite direction, of course). **There is no limit as to how far two checkerboard pieces can be in order for one to jump over the other.** Is it possible to move these pieces so that they are now arranged in a square of sidelength two? (There is a particulary elegant solution to this problem, if you just think about it the right way.)"

*(The printed sentence "one takes one of the checkerboard pieces and jumps over it" is slightly garbled — it must mean: take one piece, and jump it over a second piece. The rest of the sentence makes the intent unambiguous: the mover's new position is the reflection of its old position in the piece jumped over.)*

**Two pieces of the statement that are load-bearing, and are the sort of thing readers skip.** (i) "unlimited amount of moves" — so no counting argument can help; you need an invariant. (ii) "no limit as to how far" — so you cannot use distance, adjacency, or any local structure; the only thing left is arithmetic. Tao's parenthetical "particulary elegant solution … if you just think about it the right way" is the hint, and what it points at is: *stop thinking geometrically.*

**The technique.** `[invariant — Technique 6]` plus `[reversibility]`.

**Sketch** *(the standard elegant solution; the book gives only the hint above).* Put the starting square at $(0,0),(1,0),(0,1),(1,1)$. Reflecting a point $P$ through a point $Q$ sends $P \mapsto 2Q-P$. If $P$ and $Q$ have integer coordinates, so does $2Q-P$. So **the integer lattice $\mathbb{Z}^2$ is invariant**: every checker stays at integer coordinates forever. That alone doesn't finish it, because a side-2 square also has integer corners.

Now use the fact that **the move is its own inverse** — reflecting back undoes it — so any sequence of moves can be run in reverse. Suppose you could get from the side-1 square to a side-2 square. Reverse the whole sequence: you would get from a side-2 square to a side-1 square. But start from a side-2 square, say $(0,0),(2,0),(0,2),(2,2)$: now *all* coordinates are even, and $2Q-P$ is even whenever $Q$ and $P$ are, so **every checker stays at even coordinates forever**. A square of side 1 needs two corners one unit apart, i.e. an odd coordinate difference. Impossible. Hence the forward journey is impossible too. **Answer: no.**

**Transferable lesson.** Two ideas worth stealing. First, the invariant needn't be a number — here it is *membership in a lattice*. Second, if the moves are reversible, you may attack the problem from whichever end has the stronger invariant. Reversibility is a hypothesis you should always check for and exploit.

---

## Problem 6.2 (\*) — Alice, Betty and Carol's exam scores (book pp. 86–89)

**Statement.** Three girls take the same series of exams. In *each* exam the three marks awarded are $x$, $y$, $z$ — three distinct positive integers, the same three every time, one to each girl. Over all exams Alice totals 20, Betty 10, Carol 9. Betty came first in Algebra. Who came second in Geometry?

**The data / the objective.** Tao's framing (p. 86): "There is precious little information in this question: it seems that we know little more than the final scores. And how can one determine partial scores from the total score? But we may, because we have other data at our disposal." Note that the number of exams, the values of $x,y,z$, and every individual mark are all unknown — and yet a *name* is demanded.

### The chain of moves

1. `[inventory the data — Technique 13]` Four pieces: (i) every exam distributes exactly one $x$, one $y$, one $z$ — "This is an unusual piece of data. How can we exploit it?"; (ii) the three totals 20, 10, 9; (iii) Betty first in Algebra; (iv) $x,y,z$ distinct positive integers. (Note the sequencing of his own numbering: (i) is "first of all", (iii) is called "our third piece of data", (iv) is called "a fourth piece of data" and is introduced two pages later, when he needs it. The inventory is built up as the problem demands, not all at once.)
2. `[cross-match two facts — Technique 48]` "First of all, we can try to match it with our third piece of data, that Betty was first in Algebra. Well, that means that Betty scored the highest of the three choices $x$, $y$, and $z$."
3. `[WLOG by naming — Technique 14]` Declare $x>y>z$ — "To make life easier, say that $x$ is the biggest and $z$ is the smallest: that is, $x>y>z$ (remembering that $x$, $y$, and $z$ are known to be distinct)." Then "Betty was first in Algebra" simply means Betty scored $x$ in Algebra. "We do not lose much, but we gain some simplicity." *(Why this is free rather than a genuine loss of generality: $x,y,z$ are just names we were handed for the three marks, and nothing in the problem attaches meaning to which is which. Renaming them into decreasing order costs nothing. Contrast a real WLOG, where you must check the symmetry actually exists.)*
4. `[try small cases of the unknown structure — Technique 27, in miniature]` What can a single exam look like? "For example, in Geometry, Alice could score $z$, Betty $x$, and Carol $y$, or perhaps Alice scores $x$, Betty $y$, and Carol $z$." Two concrete assignments, written out, purely to make the *extent of the ignorance* visible. This is a tiny move and easy to skip, but it is what sets up the next question: having seen two different arrangements side by side, you can ask what they have in common.
5. `[find what's fixed across all configurations — Technique 15]` "Does anything stay fixed amid all these possibilities? Well—the total score per exam remains the same. No matter how the $x$, $y$, and $z$ scores are handed out, the total score per exam must always be $x+y+z$." Then: "Do we know anything more about these total scores?"
6. `[count one total two ways — Technique 16]` "Well, we know that the total score for *all* exams is $20+10+9=39$." Sum over exams: $N(x+y+z)$ where $N$ is the number of exams. Therefore
$$N(x+y+z)=39 .$$
"Now we have a formula containing the number of exams, which we knew little about beforehand. **This should prove useful.**" — note the modest claim. He does not yet know why it will help; he knows only that a previously untouchable unknown ($N$) is now inside an equation.
7. `[integrality + factorization — Technique 17]` "But one lone equation does not seem enough. **However, we must keep in mind that $N$, $x$, $y$, $z$ are positive integers, not just real numbers.** Also, we have a fourth piece of data: $x$, $y$, and $z$ are distinct. **These weapons will reduce the possibilities of the above equation.**" (The word "weapons" is Tao's, and it is the right attitude: integrality and distinctness are offensive tools, not fine print.) The equation reads
$$(\text{positive integer})\times(\text{positive integer})=39,$$
and "the only factors of 39 are 1, 3, 13, and 39". Four cases:
   - (a) $N=1$ and $x+y+z=39$
   - (b) $N=3$ and $x+y+z=13$
   - (c) $N=13$ and $x+y+z=3$
   - (d) $N=39$ and $x+y+z=1$
   *(For a reader who hasn't seen this: 39 factors as $3\times13$ with both 3 and 13 prime, so its only positive divisors are $1,3,13,39$. If $39$ had been, say, $36$, there would have been nine cases — part of why the problem-setter chose 39.)*
8. `[eliminate cases, semantically and numerically — Technique 18]` "But not all these possibilities hold water." (a) "states that there was only one exam taken. This contradicts the semantics of the question, which implies that there are at least two exams (Algebra and Geometry)." (c) and (d), "apart from seeming like a **suicidal number of exams**, cannot work if $x$, $y$, $z$ are to be distinct, positive integers (that forces $x+y+z$ to be at least six)". **Only (b) survives: $N=3$ exams and $x+y+z=13$.**
   > *Note the two grades of argument stacked in one sentence.* "A suicidal number of exams" is a joke, and also a real semantic objection of the same kind that killed (a) — but Tao does not rely on it. He immediately supplies the airtight numeric reason ($1+2+3=6>3$). **When you use a soft argument, pair it with a hard one if you can.** Compare his later "(Note that this argument works even if we allow $a$ to be zero)" in Problem 6.4 — same instinct.
   > *Erratum:* the printed text on p. 87 says "the only possibility that has not been eliminated (c)" and then immediately says there were three exams with $x+y+z=13$ — which is case **(b)**. A slip of the letter; the conclusion is the intended one.
9. `[list the remaining unknowns — Technique 49]` "Now we have far fewer possibilities. But we still do not know two things that should be important: we do not know the exact values of $x$, $y$, and $z$; and we do not know how everyone scored in each exam. The first question is partially handled by the fact that $x,y,z$ are distinct positive integers that add up to 13, while the second question is partially answered by the fact that we know Betty scored a $x$ in Algebra. How can we improve on these partial results?"
10. `[audit for partially-used data — Technique 50]` "Well, the one piece of data that has not been used fully is the individual total scores." The totals were used only via their sum 39; the fact that they are $20, 10, 9$ — wildly unequal — has not been touched.
11. `[speculate, then demand solidity — Technique 51; plus the heuristic guess]` "Looking at those scores, we see that Alice did rather better than Betty and Carol, implying that she probably got high marks (i.e. $x$'s and $y$'s) in each subject. But Betty was first in one subject, so Alice could not have got straight $x$'s. At best she could have got 2 $x$'s and a $y$. **Likewise, Carol would be unlikely to score the top mark of $x$ in any of the exams, and it is more than likely that she would be scoring mostly $z$'s. Can we put this speculation into solid mathematics?**" — then the honest self-assessment: "**The answer is at first, a 'maybe'.**" So: conjecture Alice scored exactly $2x+y$, "after all, Alice scores a good deal more than any other girl; 20 is much larger than 10 or 9."
12. `[enumerate the alternatives to be killed]` "What are the other possibilities for Alice's scoring? They are $2x+z$, $x+2y$, $x+y+z$, $x+2z$, $3y$, $2y+z$, $y+2z$, and $3z$." (That is all 10 multisets of size 3 from $\{x,y,z\}$, minus $3x$ — killed because Betty beat her in Algebra — and minus the conjecture $2x+y$ itself.) "The last few in the list seem too low-scoring to possibly reach 20: hopefully, they could be eliminated. But to try to prove this rigorously, we need some decent upper bounds on $x$, $y$, and $z$."
13. `[announce the sub-goal — Technique 52]` "So this is our next task: to limit $x$, $y$, and $z$ so we can eliminate several possibilities."
14. `[extremal bounding from the ordering — Technique 19]` "All we know is that $x,y,z$ are integers, $x>y>z$ and that $x+y+z=13$. But this is enough to put quite good bounds on $x$, $y$, and $z$." The intuition first: "$z$ cannot go too high, because then $x$ and $y$ will have to go high as well, and then $x+y+z$ will probably be forced to go higher than 13." Then, in his words, "**To be specific:** $y$ is at least $z+1$, and $x$ is at least $z+2$, so
$$13=x+y+z\ \ge\ (z+2)+(z+1)+z=3z+3,$$
which forces $z\le 3$."
    For $y$: "We can do something similar to the above, bounding $x$ by $y+1$. But all we can say about $z$ is that it has a lower bound of 1. But this is enough: we get $13=x+y+z\ge(y+1)+y+1=2y+2$", so $y\le5$. For $x$: "$z$ is at least 1 and $y$ is at least 2, so $13=x+y+z\ge x+2+1$", so $x\le10$.
    *(Notice the pattern: to bound one variable you push the other two as low as the ordering permits. Each bound uses a different combination of the same two facts — the strict ordering and $z\ge1$ — which is why "positive integer" and "distinct" are doing all the work.)*
15. `[check the bounds are sharp — Technique 20]` Each is attained by an explicit triple, which Tao writes out: $z\le3$ is "the best one can do without any further information, for there is the combination $x=6,y=4,z=3$"; $y\le5$ — "Again, this is the best possible: consider $x=7,y=5,z=1$"; $x\le10$ — "And this is the best possible: for we have $x=10,y=2,z=1$." So don't waste time trying to improve them *from these hypotheses alone* — improvement must come from new data. (Check them yourself: $6+4+3=13$, $7+5+1=13$, $10+2+1=13$, all strictly decreasing, all positive. Sharpness is a two-line verification and it saves you an hour of pushing on a wall.)
16. `[sharpen with unused data — Technique 21]` "So we know this: $z\le3$, $y\le5$, and $x\le10$. **But we can do even better.** Remember that Betty scored an $x$ and two other scores. Since Betty only scored 10, we know that $x$ cannot be as high as 10. This would mean that Betty would have scored nothing for her other two exams, which is impossible: we know that all the scores are positive integers. In fact, $x$ cannot be as high as 9 either, for Betty would have only coughed up 1 mark for the other two exams: this would mean that one exam scored nothing, again a contradiction. So we have in fact **$x\le8$**."
17. `[crude estimation kills the rest — Technique 22]` "Now we can do some serious eliminating: in fact it is easily seen that the only possibility for Alice's scores is $2x+y$: all the other scoring possibilities cannot possibly reach 20. For example, $2x+z$ is at most $2\times8+3=19$." (This is one of the "it is easily seen" moments worth checking — Technique 47. The eight candidates, at their maxima under $x\le8,y\le5,z\le3$: $2x+z\le19$, $x+2y\le18$, $x+y+z\le16$, $x+2z\le14$, $3y\le15$, $2y+z\le13$, $y+2z\le11$, $3z\le9$. All below 20. And $2x+y$ can reach $2\times8+5=21\ge20$, so it is the only survivor. He only had to check the largest one, $2x+z$, because the list is essentially ordered — but you should confirm that it *is* the largest.)
18. `[tabulate — Technique 23]` "So Alice scored two $x$'s and a $y$. Since Betty scored an $x$ in Algebra, Alice must have scored a $y$ here. We can place this, together with the other information we know, into a table:"

| Exam | Alice | Betty | Carol | Total |
|---|---|---|---|---|
| Algebra | $y$ | $x$ | ? | 13 |
| Geometry | $x$ | ? | ? | 13 |
| Other | $x$ | ? | ? | 13 |
| **Total** | 20 | 10 | 9 | 39 |

Each row must contain one each of $x,y,z$, so Carol's Algebra mark is forced: "**We can now see that Carol must have scored a $z$ in Algebra, as it is the only mark remaining.**"
19. `[report partial progress — Technique 53]` "We are getting closer to our goal; we know that it is either Betty or Carol that scored the second-place mark of $y$ in Geometry. But we are still not done yet." The answer set is down from three names to two.
20. `[read a new equation off the table — Technique 23]` "Looking at Alice's column of the table, we have another piece of information, namely that $y+x+x=20$. Recalling that $x>y$ and $x\le8$, this gives us only two solutions: $x=8,y=4$ or $x=7,y=6$. But since $x+y+z=13$, we can not have $x=7$ and $y=6$, since that would force $z=0$. Thus we can only have $x=8,y=4$, which forces $z=1$. So we have made a major breakthrough by solving for $x,y,z$ completely."
    *(Check the enumeration: $2x+y=20$ with $x\le8$ and $x>y\ge1$ needs $y=20-2x$ even and positive, so $x\in\{8,9\}$ gives $y\in\{4,2\}$ — but $x\le8$ kills $x=9$ — and smaller $x$ gives $y=20-2x\ge6$, which needs $x\ge7$; so $x=7,y=6$ and $x=8,y=4$ are indeed the only two. The table's row-sum constraint then kills the first.)

| Exam | Alice | Betty | Carol | Total |
|---|---|---|---|---|
| Algebra | 4 | 8 | 1 | 13 |
| Geometry | 8 | ? | ? | 13 |
| Other | 8 | ? | ? | 13 |
| **Total** | 20 | 10 | 9 | 39 |

21. **Finish.** Tao's one-liner: "And now it is easy to see that Betty had to have scored $z=1$ in both Geometry and the other exam, and Carol had to have scored $y=4$ in those exams." Unpacked: Betty has $10-8=2$ left for two exams, and each mark is at least $z=1$, so she scored 1 in both Geometry and the third exam. Carol then gets $y=4$ in both (her total checks: $1+4+4=9$ ✔). In Geometry the marks are Alice 8 ($x$, first), **Carol 4 ($y$, second)**, Betty 1 ($z$, third). The completed table:

| Exam | Alice | Betty | Carol | Total |
|---|---|---|---|---|
| Algebra | 4 | 8 | 1 | 13 |
| Geometry | 8 | 1 | 4 | 13 |
| Other | 8 | 1 | 4 | 13 |
| **Total** | 20 | 10 | 9 | 39 |

**Answer: Carol was second in Geometry.**

### Transferable lesson

An "under-determined" problem is usually a problem whose constraints you haven't finished writing down. Integrality, positivity, distinctness, an ordering you may impose for free, and the plain English of the question are all constraints. Then the workflow is: get one equation by counting something two ways; use integrality to reduce to finitely many cases; kill cases; bound the survivors; tabulate; and read the next equation off the table. Notice too that Tao *ends up knowing far more than he was asked* — the full 3×3 table — which is the opposite of what happens in Problem 6.4.

Second lesson, about the *rhythm* of the solution. Look at how often Tao stops to say where he is: "This should prove useful"; "Now we have far fewer possibilities. But we still do not know two things"; "How can we improve on these partial results?"; "So this is our next task"; "But we can do even better"; "We are getting closer to our goal … But we are still not done yet"; "So we have made a major breakthrough". Nine pages of algebra are held together by about eight sentences of position-reporting. None of them is mathematics and the solution would be unreadable — and probably unfindable — without them. **Narrating your own state is a technique, not a stylistic tic.**

---

## Problem 6.3 — The chocolate-bar game (Taylor 1989, p. 16, Q3; book pp. 90–93)

**Statement, essentially as printed.** "Two people play a game with a bar of chocolate made of 60 pieces, in a $6\times10$ rectangle. The first person breaks off a part of the chocolate bar along the grooves dividing the pieces, and discards (or eats) the part he broke off. Then the second person breaks off a part of the remaining part and discards her part. The game continues until one piece is left. **The winner is the one who leaves the other with the single piece (i.e. is the last to move.)** Which person has a perfect winning strategy?"

*(The parenthetical "i.e. is the last to move" is the whole win condition and is easy to misread. The player who **hands over** the final $1\times1$ wins; the player stuck holding an unbreakable $1\times1$ loses. In game-theory jargon this is **normal play**: "the player unable to move loses". Exercise 6.6 later flips it to **misère play**.)*

**The data / the objective.** Tao's first move is an aside — literally, "**By the way**" — establishing that the question is even meaningful: `[existence meta-theorem — Technique 24]` "it is easily shown that any finite game of skill must have a winning (or drawing) strategy for one of the players. This is done by induction on the maximum length of the game. Even chess has this restriction, although no-one has found the strategy, which most believe is extremely complicated. Since there are no draws in ths game, one player must have a perfect winning strategy (as there are no draws). **But who?**"

*(He inserts a whole meta-theorem "by the way" before touching the problem. That ordering is deliberate: knowing a strategy exists turns "find the strategy or prove there isn't one" into "find out which of two players it belongs to" — a strictly smaller job, and one you can attack by elimination.)*

### The chain of moves

1. `[reduce to mathematics; formalize the moves — Technique 25]` "First, let us reduce the problem from chocolate to Mathematics. We can start by formalizing the process of breaking the bar." What *is* a legal break? "Anyone who has broken a chocolate probably knows that the only way to break a bar of chocolate is into two rectangles, not along some zig-zag or partial rectangle. Essentially we reduce the $6\times10$ bar into a smaller rectangle with one of the dimensions the same … that is, the chocolate breaks into a bar of equal width and less length, or equal length and less width." So a move takes an $a\times b$ bar to an $a\times b'$ with $b'<b$, or to an $a'\times b$ with $a'<a$. His illustration: "the $6\times10$ bar will be broken into a $6\times7$ bar (with the $6\times3$ piece being discarded or eaten)".
   *(Where does the formalization come from? Not from mathematics — from having eaten chocolate. Technique 7 again: physical experience is a legitimate source of a definition, as long as you convert it into one.)*
2. `[notation; strip the state — Techniques 3, 4]` "Now we need some notation for the rectangle, preferably in numbers. **How do we describe a rectangle of chocolate in terms of numbers?** The obvious candidate is to state the length and width of the bar." A bar is the pair $(6,10)$. "The position of the chocolate is not relevant; only the size will be important." Target: "Our aim is to leave the other player at $(1,1)$." Rules: "We can cut off some of the width or some of the length, though not to zero or a negative number." He then writes out the whole move list from $(6,10)$ by hand:
$$(6,1),(6,2),(6,3),\dots,(6,9),\ (1,10),(2,10),\dots,(4,10),(5,10).$$
   *(Fourteen positions, listed explicitly. Worth noting that he does this rather than saying "obviously there are 14 moves" — writing out a small set is how you catch an off-by-one in the rules. Note $(6,10)$ itself is excluded, since you must remove something.)*
3. `[reformulate, repeatedly — Technique 26]` "In short, we can move horizontally left or vertically downward." Version 2, after the diagram: "Now that we have a nice mathematical model of the chocolate, we can restate the question mathematically (but less deliciously)" — a point on a lattice moving left or down, never past the axes, starting at $(6,10)$, winner reaches $(1,1)$. "or we could have another formulation": Version 3 — two rows of counters, 5 and 9; each move removes counters "from either the top row or the bottom row, **but not both**"; whoever takes the last counter wins. "This formulation has been modified a bit by subtracting 1 from both the top and bottom row. It should give strong hints to anyone familiar with the game of Nim; those people would solve the question easily now. But we can do the question without the knowledge of Nim and related Game theory."
4. `[get a grip; specialize — Techniques 56, 27]` "Now we have notation, and an abstract mathematical model. What we need now is a good grip on the problem. The problem is that the $6\times10$ bar has so many possibilities. We should start with a much smaller bar to experiment. Let us have a $2\times3$ bar to begin with."
   - First player's options: $1\times3$, $2\times2$, $2\times1$.
   - $1\times3$ and $2\times1$ are "foolish moves because then the second player could take everything except the last $1\times1$ square and win."
   - "So the first player should leave behind a $2\times2$ square bar. Now the second player is forced to leave behind a $1\times2$ or a $2\times1$ bar, and then the first player just breaks the remaining bar in half, leaving the $1\times1$ bar, and therefore winning the game. **So the first player wins with a $2\times3$ bar.**"
5. `[escalate: one small case wasn't enough]` "Not much information is gained, so let us move on to another example, say a $3\times3$ bar."
6. `[symmetry — Technique 28]` "Now the first player has several options: $1\times3$, $2\times3$, $3\times2$, and $3\times1$. But symmetry effectively eliminates the last two choices." (Only the multiset of dimensions matters, so $3\times2$ *is* $2\times3$ and $3\times1$ *is* $1\times3$ — four options collapse to two.)
7. `[recognize the solved sub-problem, roles reversed — Technique 29]` "$1\times3$ is stupid, because the second player can grab everything except the last chunk and win. But $2\times3$ is equally bad, because **we have reduced the problem to that of the last paragraph!** Now the second player uses the strategy that the first player would have used in the last paragraph: get a $2\times2$ bar, leaving the first player with no choice but to break off a $1\times2$ bar, which the second player then breaks into a $1\times1$ bar and wins. **So the first player loses with a $3\times3$ bar.**" Both options lose, so the position is lost.
8. `[turn it into an induction template — Technique 54]` "We solved the $3\times3$ problem by looking at the $2\times3$ problem. **This suggests an induction approach for the general problem.**" His hypothetical: for $3\times4$, if you already knew $3\times1$, $3\times2$, $1\times4$, $2\times4$ are winners and $3\times3$ is a loser, then the first player's move is to leave $3\times3$. And the general form: "the strategy for the first player is to leave the second player with bars that are sure losers for the one who has to break them. And why are these bars sure losers? Because no matter how you break them, they become sure winners for the other player. And these bars are sure winners because one can break them into a sure loser for the other player, and so on. **So our strategy now is to find all the sure winners and sure losers.**"
9. `[backward induction — Technique 30]` Define sure losers / sure winners for the player about to move, and propagate from $1\times1$:
   - $1\times1$: **loser** (no move; game over).
   - $1\times n$, $n>1$: **winner** (break down to $1\times1$).
   - $2\times2$: **loser** (all moves give $1\times2$ or $2\times1$, both winners for the opponent).
   - $2\times n$, $n>2$: **winner** (break to $2\times2$).
   - Rule (i) (cheap — needs *one* good child): if $a\times b$ is a loser then $a\times c$ with $c>b$ is a winner, "because the person who breaks $a\times c$ should leave the other player with $a\times b$". Example he gives: since $3\times3$ is a loser, "$3\times4$, $3\times5$, $3\times6$, etc. are all sure winners".
   - Rule (ii) (expensive — needs *all* children): $a\times b$ is a loser "only when all the possible moves from it are sure winners for the other player". Example: $1\times4,2\times4,3\times4$ (and by symmetry $4\times3,4\times2,4\times1$) are all winners — that is all six moves from $4\times4$ — hence **$4\times4$ is a loser**. (Printed as "losers"; see the erratum in the Technique 30 section above.)
10. `[tabulate and conjecture — Technique 31]` "One can continue this systematic method, eventually reaching $6\times10$. **But why do not we be more mathematical? There should be a pattern to the sure winners and losers.** Well, what are the winners and losers we know so far?" He lays the winners out in rows (see the table in the Technique 31 section above); "the sure losers that we have identified are $1\times1$, $2\times2$, $3\times3$, and $4\times4$." Verdict: "This is pretty convincing evidence that the only sure losers are $n\times n$ bars: that is, square bars, and all others are sure winners."
11. `[verify rather than prove — Technique 32]` "Once we have this conjectured strategy, we do not even have to prove it (although you can, with induction): we just have to apply it. Remember we want to leave the opponent with losers. Once we guess what the losers are, we can make the strategy to always force them on the opponent. If the strategy works all the time, then fine. If not, then the guess was wrong. To summarize, if our guess is correct, the best strategy is to give the other player a square. So this means that for the $6\times10$ bar, the first player has the following strategy:"

### The resolution

$6\times10$ is not a square, so the **first player wins**. The strategy, as boxed on p. 93:

> Break the chocolate so that a $6\times6$ square is left (a sure loser to the second player). Then whatever the second player does, convert the bar back into a square. For example, if the second player leaves a $6\times4$ bar, you square it back to a $4\times4$ bar. Repeat this process, always leaving the other player with the square formation, until at last you leave the opponent with the $1\times1$ formation (making him/her lose).

*(Note the first move: from $6\times10$ you cut the **length** from 10 down to 6, not the width. The general recipe is "cut the longer side down to the shorter", which is why the illustration $6\times4 \to 4\times4$ cuts the width instead — the recipe is not "always cut the same dimension".)*

Why it works — and this is Tao's own two-line verification, "This strategy actually works, because whenever the opponent breaks the square, he gets a non-square that can be easily converted to a square again. And because the size of the chocolate is decreasing, the square conversion must eventually lead to a $1\times1$ square":
- **Squares are always reachable from non-squares.** If $a\ne b$, cut the longer side down to the shorter: $\min(a,b)\times\min(a,b)$. Always legal (you're strictly shrinking one dimension, never to 0).
- **Non-squares are all your opponent can produce.** A move changes exactly one dimension, so from $n\times n$ you must get $n\times m$ with $m\ne n$.
- `[termination via a decreasing measure — Technique 33]` "because the size of the chocolate is decreasing, the square conversion must eventually lead to a $1\times1$ square." The area is a positive integer that strictly drops every move, so the loop cannot run forever — and the only square you can be forced to stop at is $1\times1$, which is a loss for whoever holds it. That's your opponent.

Tao's own assessment: "with a bit of semi-rigorous maths we have ended up with a working strategy, which is what we were after."

`[land back in intuition — Technique 34]` "this is a standard approach in solving games of skill: determine all winning and losing positions, then always move to a winning position. Any decent skill-game player uses this method, except that they have an imprecise idea of winning and losing positions, only 'favourable' and 'unfavourable' positions."

### Transferable lesson

For any finite two-player game with no draws: (1) build a numeric model of a position; (2) find the terminal position and its value; (3) label positions backwards — a win needs *one* good move, a loss needs *all* moves bad; (4) compute enough labels to see the pattern; (5) conjecture the pattern and then *verify the resulting strategy is playable and terminating*, which is often easier and always sufficient. For a CS reader this is precisely minimax over a game DAG plus a guessed evaluation function — and the "verify the strategy, don't prove the labelling" move is the mathematical version of testing the policy rather than proving the value function.

---

## Exercise 6.4 — 153 counters, take 1 to 9 (book p. 94)

**Statement, as printed:** "Two players play a game starting with 153 counters. Taking turns, each player must remove between one and nine counters from the game. The person who removes the last counter wins. **Does either the first player or second player have a guaranteed winning strategy, and if so, what is it?**"

*(The "and if so, what is it?" is not decoration — it is the same two-part demand as Problem 6.3: identify the player *and* produce a playable recipe. Compare Technique 32: an existence claim without a recipe would not answer this exercise.)*

**Sketch.** `[backward induction — Technique 30]` Losing positions (for the player to move) are the multiples of 10: from a multiple of 10 you must leave a non-multiple; from a non-multiple you can always take $n \bmod 10$ counters and leave a multiple. So the **first player wins**: take $153 \bmod 10 = 3$ counters, leaving 150. Thereafter, if the opponent takes $k$, take $10-k$. Every round removes exactly 10, so you leave $140, 130, \dots, 10, 0$ — and you take the last counter.

**Transferable lesson.** The "complete to a fixed sum" strategy is the standard shape of a *pairing* strategy: you can't control your opponent's move but you can control the *round total*. Also note the modular structure: the losing positions form one residue class, and the winning move is exactly "reduce to residue 0".

---

## Exercise 6.5 — Remove a power of $d$ (book p. 94)

**Statement, as printed:** "Two players play a game with $n$ counters. Taking turns, each player must remove a number of counters which is a power of $d$. The person who removes the last counter wins. For the following values of $d$, **determine for which values of $n$ the first player has a winning strategy, and for which values of $n$ the second player wins.** (a) $d=2$. (b) $d=3$. (c) (\*) $d=4$. (d) (\*) The general case."

*(Two things to notice about the phrasing. First, the answer is not a player but a **classification of $n$** — this is the first exercise in the chapter whose answer is a set of residue classes rather than a name. Second, the book never says whether $d^0=1$ counts as "a power of $d$". Everything below assumes it does, which is the standard reading and the one that makes the problem come out cleanly; if 1 were banned, then for $d=2$ the legal removals $2,4,8,\dots$ are all even, every odd $n$ would be a position from which you can never reach 0, and the game would not even always terminate in a win. That degeneracy is itself evidence that $1$ is intended. **Where a problem is ambiguous, pick the reading under which it is a good problem — and say that you did.**)*

**The technique.** `[backward induction + look for the modular pattern — Techniques 30, 31, 11]` The trick is to find a modulus $m$ such that **no legal move is $\equiv 0 \pmod m$** — then the multiples of $m$ can never move to another multiple of $m$, and they become the losing positions.

**Sketches** *(the book gives no answers; these are mine, worked from the technique).*

- **(a) $d=2$.** Legal removals $1,2,4,8,16,\dots$ Mod 3 these are $1,2,1,2,1,\dots$ — never $0$. So from a multiple of 3 you must land on a non-multiple, and from a non-multiple you can always remove 1 or 2 to land on a multiple. **Losing positions: $n\equiv0\pmod3$**; the second player wins exactly then.
- **(b) $d=3$.** Legal removals $1,3,9,27,\dots$ — all **odd**. So parity flips every move, and $0$ is even. **Losing positions: $n$ even.**
- **(c) $d=4$.** Legal removals $1,4,16,64,\dots$; mod 5 these are $1,4,1,4,\dots$. Hand computation of small positions ($L$ = loss for the mover): $0\,L,\ 1\,W,\ 2\,L,\ 3\,W,\ 4\,W,\ 5\,L,\ 6\,W,\ 7\,L,\ 8\,W,\dots$ giving $L=\{0,2,5,7,10,12,\dots\}$. Pattern: **losing positions are $n\equiv 0$ or $2 \pmod 5$.** (Check: from $n\equiv0$ the moves land on $\equiv 4$ or $1$, both wins; from $n\equiv2$ they land on $\equiv1$ or $3$, both wins; and $1,3,4$ each have a move into $\{0,2\}$.)
- **(d) General $d$.** Work mod $d+1$, where $d\equiv-1$, so $d^k\equiv(\pm1)$: every legal removal is $\equiv +1$ or $-1 \pmod{d+1}$. So each move nudges the residue by one step around a cycle of length $d+1$, and you're playing a walk on that cycle. For **odd $d$** all powers are odd, $d+1$ is even, and parity alone decides: losing iff $n$ is even. For **even $d$** the losing residues mod $d+1$ are the even ones below $d$, i.e. $\{0,2,4,\dots,d-2\}$ — which reproduces $\{0\}$ mod 3 for $d=2$ and $\{0,2\}$ mod 5 for $d=4$.

**Transferable lesson.** In subtraction games, ask "is there a modulus that no legal move is divisible by?" If yes, the multiples of that modulus are the losing positions and you have a complete strategy in one line. Choosing $m=d+1$ because $d\equiv-1$ is the same instinct as choosing mod 3 for three cyclic colours: **pick the modulus that makes the move set degenerate.**

---

## Exercise 6.6 — The misère version (book p. 94)

**Statement.** Same as Exercise 6.5, but now the objective is *to lose the last counter* — you want to force the other player to take it. Tao's parenthetical: "(If one happens to be thinking in the right way, the answer falls out easily.)"

**Sketch of "the right way".** In the misère game you lose if you take the last counter, so the fatal position is "1 counter left, your turn" (you must remove at least one, so you must take it). In the normal game the fatal position is "0 counters left, your turn". Since $1$ is always a legal removal, the two games are literally the same game shifted by one counter: **position $n$ in the misère game behaves exactly like position $n-1$ in the normal game.** So every answer from Exercise 6.5 transfers by adding 1. For $d=2$: losing positions become $n\equiv1\pmod3$. For $d=3$: losing positions become $n$ odd. For $d=4$: $n\equiv1$ or $3\pmod5$.

**Transferable lesson.** Before re-solving a variant, look for a **change of variable** that turns it into the version you already solved. "Set aside one counter as poison" costs nothing and reuses all your work. This is the same manoeuvre as subtracting 1 from each coordinate to turn the chocolate bar into a Nim heap (p. 91).

---

## Exercise 6.7 — Chocolate in three dimensions (book p. 94)

**Statement.** A $3\times6\times10$ bar; a move breaks it straight across in any one of the three directions and discards the offcut. Who wins, and with what strategy?

**Sketch** *(the book gives no answer; this is mine, using the reformulation Tao himself suggested on p. 91).* Subtract 1 from every dimension: $3\times6\times10 \to$ heaps of sizes $2, 5, 9$. A move reduces exactly one heap by a positive amount, and the player who empties the last heap (reaches $1\times1\times1$) wins. That is exactly **three-heap Nim**.

The classical solution uses the **nim-sum**: write the heap sizes in binary and XOR them. A position is a loss for the player to move iff the XOR is 0. (Intuition for a CS reader: XOR $=0$ means every binary column has an even count, so the position is "perfectly paired". Any move breaks some column's parity; and from a broken position you can always restore all parities with one move.) The 2-dimensional case is the special case of two heaps, where XOR $=0$ means the heaps are equal — which is exactly Tao's "squares are losers".

Here $2 \oplus 5 \oplus 9$: in binary $010 \oplus 101 = 111 = 7$, and $7 \oplus 9 = 0111 \oplus 1001 = 1110 = 14 \ne 0$. So the **first player wins**. To find the move, look for a heap you can reduce to the XOR of the other two: $2\oplus5=7$, and the 9-heap can be reduced to 7. So play $9 \to 7$, i.e. cut the bar to $3\times6\times8$. (The other two heaps can't help: $5\oplus9=12>2$ and $2\oplus9=11>5$.) Thereafter keep restoring nim-sum 0.

**Transferable lesson.** Dimension-raising a solved problem is a standard exercise, and the honest answer is often "the 2-D pattern was a coincidence of small numbers". Here "leave a cube" is *not* the right generalization of "leave a square" — the correct invariant was hiding as the XOR all along, and the square rule was only its two-heap shadow. This is a good warning about Technique 31: patterns read off small tables can generalize the wrong way.

---

## Exercise 6.8 (\*\*) — Gomoku: the first player can force at least a draw (book p. 94)

**Statement.** On a $19\times19$ board, White and Black alternately place a stone of their colour. Five in a row (any orientation) wins; a full board with no five-in-a-row is a draw. Show the first player has a strategy guaranteeing at least a draw.

**Tao's hint, in full:** "you have to argue by contradiction. Show that if the first player cannot force at least a draw, then the second player has a winning strategy. Now make the first player 'steal' that strategy."

**Sketch of the argument** (unpacked from the hint).
1. `[existence meta-theorem — Technique 24]` The game is finite with no hidden information, so exactly one of these holds: first player can force a win, second player can force a win, or both can force a draw. If the first player cannot force at least a draw, the only remaining possibility is that the **second player has a winning strategy $S$**.
2. `[strategy stealing — Technique 35]` Now let the first player do this: place one stone anywhere ("a spare"), then *pretend to be the second player* and follow $S$, treating the opponent's moves as the "first player" moves that $S$ expects. If $S$ ever calls for a square already occupied by the spare, place a new spare somewhere arbitrary instead and carry on.
3. **Why the spare is harmless.** In Gomoku an extra stone of your own colour never hurts you — it can only help complete a line and it never blocks you. So the first player, following $S$ with an extra stone on the board, wins whenever $S$ would have won.
4. **Contradiction.** Both players cannot have winning strategies. So the assumption in step 1 fails, and the first player *can* force at least a draw. $\blacksquare$

**Transferable lesson.** Two big ideas. First, **proof by contradiction combined with a completeness theorem**: "cannot force a draw" is only usable as "the opponent can force a win", and that step needs Technique 24. Second, **strategy stealing** is a purely structural argument: it uses nothing about Gomoku except symmetry of the rules and the monotonicity of "extra stones don't hurt". It is also totally non-constructive — it tells you a drawing strategy exists and gives you no idea what it is. (Compare Technique 32's guessed-then-verified strategy for the chocolate game: that one you can actually play.)

---

## Problem 6.4 — The two brothers, the sheep, and the penknife (Shklarsky et al. 1962, p. 9; book pp. 95–97)

**Statement.** Two brothers sell a herd of sheep. Each sheep fetches as many rubles as there were sheep in the herd. They divide the money by alternately taking 10-ruble packets: older, younger, older, younger, … At the end it is the *younger* brother's turn and fewer than 10 rubles remain, so he takes what is left. To even things up, the older brother gives him a penknife worth a whole number of rubles. What is the penknife worth?

**The data / the objective.** Tao's own reaction (p. 95): "The first reaction should be that this question seems to have not enough information. Second, the question does not seem to be rigorous enough. But it is wrong to give up hope before any attempt has been made to solve it; take a look at Problem 6.2, which had even less information to begin with but could still be solved."

*(This cross-reference is itself a technique: use your own track record on a similar problem as evidence that the current one is tractable.)*

### The chain of moves

> **A note on labels, so the numbers below match the book.** Tao numbers only two displayed equations in the running text: **(1)** is $a = 10-2p$ and **(2)** is $s^2 = 20(n+1)-2p$. The equation $s^2 = 10(2n+1)+a$ is displayed but left unnumbered. Then in the closing checklist on p. 97 he relabels the *facts* as **(a)**, **(b)**, **(c)** — and there (a) is $s^2=10(2n+1)+a$, (b) is $0<a<10$, and (c) is $a=10-2p$. So Tao's "(1)" and his checklist's "(c)" are the same equation. Both labelling schemes are used below, tagged as the book tags them.

1. `[formulate in equations at all — Technique 44's first half]` "**We should start by trying to formulate the problem in terms of equation. For this we need some variables.**" Before any cleverness, the decision to translate. Note that this is the *first* thing he does after conceding the problem looks impossible — the response to "not enough information" is not to think harder, it is to start writing symbols.
2. `[independent vs dependent variables — Technique 36]` "First of all, we notice that the price of the penknife is ultimately dependent on the number of sheep, which is the only independent variable here. (that is, knowing the number of sheep determines everything.)" Let there be $s$ sheep; "Then they all sold for $s$ rubles, so the total windfall is $s^2$ rubles." `[Technique 39]` So checklist-fact (a): *the amount divided is a perfect square.*
   *(Why "independent variable" is the right idea and not jargon: the problem contains four unknowns $s, n, a, p$, but three of them are determined once you fix $s$ — the total is $s^2$, dividing it by 20 tells you $n$ and $a$, and fairness then fixes $p$. So the whole system is a one-parameter family. Recognizing that early tells you that any single extra constraint has a real chance of pinning things down.)*
3. `[test-drive the mechanism on a number — Technique 37]` "Now we have to see how this division system works. Suppose the number of rubles was 64." Older 10, younger 10, older 10, younger 10, older 10, younger 10 — that's 60 — then the older's turn with 4 left. "It transpires that the last four roubles go to the older brother, not the younger, so the problem cannot work here. **Remember that part of the data given is the fact that the younger brother was the last to get the cash. How can we say this mathematically?**" This does two jobs: it confirms he's read the rules right, and it reveals that **the condition "the younger brother was last" is real data that restricts $s$.**
   *(Note that 64 was chosen because it is a perfect square — the test case respects fact (a). A test case that violates your own constraints teaches you nothing. And note the payoff is a **negative** result: 64 doesn't work. A test case that fails is more informative than one that succeeds, because it tells you which condition is doing the excluding.)*
4. `[introduce exactly enough variables — Technique 38]` "To do this mathematically we need lots of equations and variables (enough equations to describe the situation but not enough to introduce confusion and superfluousness)." "Suppose that the younger brother already took $n$ lots of 10 roubles before he was shortchanged. Then the older brother also took $n$ lots of 10 roubles, plus another 10-rouble pack just before the younger brother came up short, say having only $a$ roubles remaining ($a$ being something between 1 and 9 inclusive; **the wording of the problem seems to suggest that $a$ is non-zero**)." So the older took $n+1$ packets:
$$s^2 = 10n+10+10n+a,\qquad\text{i.e.}\qquad s^2 = 10(2n+1)+a. \tag{checklist (a)}$$
*Reading it in plain language: the total is an odd multiple of 10 plus a remainder between 1 and 9.* The "odd multiple" is exactly what encodes "the older brother took one more packet than the younger". *(This is the answer to "how can we say this mathematically?" from step 3 — the whole point of introducing $n$ at all.)*
5. `[the constraint you'd forget to write down — Technique 44]` Checklist-fact (b): $0<a<10$. Trivial-looking. It is the fact that finishes the problem.
6. `[name the dependent variable and demand a link — Technique 55]` "But what has this to do with the penknife? **The dependent variable which we want to solve is $p$, the price of the penknife. We need an equation connecting $p$ with something else, preferably $s$, which is the independent variable.**" — i.e. he does not go hunting at random; he specifies in advance the *shape* of the equation he needs.
7. `[turn 'fair' into an equation — Technique 39]` "Now before the exchange of the penknife the older brother had $10n+10$ roubles and the younger brother had $10n+a$. Once the exchange of the penknife occurred the older brother had a **profit** of $10n+10-p$ and the younger brother had a profit of $10n+a+p$. For the exchange to be fair, these two profits have to be equal. Equating them leads eventually to the useful equation connecting $p$ to $a$:"
$$a = 10-2p. \tag{book (1) = checklist (c)}$$
*In words: the penknife has to cover half the shortfall, because handing over value $p$ moves the gap by $2p$. Worked out: $10n+10-p = 10n+a+p \Rightarrow 10-p=a+p \Rightarrow a=10-2p$.*
   *(An aside worth noticing: he got an equation connecting $p$ to $a$, not to $s$ as he had hoped in step 6. He takes it anyway. Specifying the ideal target does not mean rejecting a near-miss — it means you recognize a near-miss when it turns up.)*
8. `[substitute to eliminate a variable]` "Now we can plug back into an older equation and get an equation connecting $p$ and the other variables. We get (**cancelling $a$ in the process**)": put (1) into (a): $s^2 = 10(2n+1) + 10 - 2p = 20n + 20 - 2p$, that is
$$s^2 = 20(n+1) - 2p. \tag{book (2)}$$
9. `[eliminate a nuisance variable by taking a modulus — Technique 40]` "We have to somehow use these equations to solve for $p$. **It looks like there is not enough information here, because we are not given what $s$, $n$, or $a$ are. How do we narrow things down further? The root problem is that there are too many unknowns floating around here. We can eliminate some of them by modular arithmetic.** For instance, in (2) we can take (mod 20) to eliminate the $n$, obtaining"
$$s^2 \equiv -2p \pmod{20}.$$
*This is the key move of the whole problem, and it's a general one: if an unknown appears only multiplied by a constant $m$, working mod $m$ deletes it.* Note the diagnosis that precedes the move — "**the root problem is that there are too many unknowns**". He names the disease before reaching for the drug, which is why he picks the right modulus (20, the coefficient of $n$) rather than guessing.
10. `[squares occupy few residues — Technique 41]` "**This is getting us closer to our goal of working out $p$, but we still have this pesky $s$ to deal with.** Fortunately, we can capitalize on the fact that squares have a restricted choice of values in modular arithmetic. In fact, in (mod 20), the squares must take a value of 0, 1, 4, 5, 9, or 16." Hence
$$-2p \equiv 0,\ 1,\ 4,\ 5,\ 9,\ \text{or } 16 \pmod{20}.$$
*(Two variables were "pesky" and each got its own tool: $n$ was killed by the modulus, $s$ by the quadratic-residue restriction. Neither is solved for; both are simply removed from the problem. **Elimination is not the same as solving, and it is often all you need.**)*
11. **Prune by parity.** Tao's phrasing: "And solving for $p$ (**and remembering that $2p$ has to be even**) we have $p = 0, 2, 8$ (mod 10)." Unpacked: $-2p$ is even, so the odd options $1,5,9$ are impossible; only $0,4,16$ survive. Solving each:
    - $-2p\equiv0 \Rightarrow 2p\equiv0 \pmod{20} \Rightarrow p\equiv0\pmod{10}$;
    - $-2p\equiv4 \Rightarrow 2p\equiv16 \pmod{20} \Rightarrow p\equiv8\pmod{10}$;
    - $-2p\equiv16 \Rightarrow 2p\equiv4 \pmod{20} \Rightarrow p\equiv2\pmod{10}$.

    *(Why $2p\equiv c \pmod{20}$ becomes $p\equiv c/2 \pmod{10}$ and not $\pmod{20}$: dividing a congruence by 2 also halves the modulus. You cannot cancel a common factor from a congruence for free — that is a standard trap. E.g. $2p\equiv 4 \pmod{20}$ has solutions $p=2$ **and** $p=12$, so the right conclusion is $p\equiv2\pmod{10}$.)*

    So $p \equiv 0, 2, 8 \pmod{10}$. Tao's own reading of this: "So we have an equation concerning $p$, but we have not been able to pin it exactly. All this says that the penknife could be worth 0 rubles, 2 rubles, 8 rubles, 10 rubles, 12 rubles, …."
12. `[go back for the data you set aside — Techniques 42, 44]` Not finished — and the way back is a *plausibility* nudge, then a memory jog: "**But the penknife could not be too expensive, could it? after all, the younger brother only missed out on 10 rubles or less … thinking upon these lines eventually allows you to remember that $p$ is not only connected to $n$ and $s$, it is connected to $a$, and $a$ is restricted to between 1 and 9.**" From (1), $a=10-2p$ with $1\le a\le9$ gives $\tfrac12 \le p \le \tfrac92$, i.e. $0<p<5$.
    *(This is the most human paragraph in the chapter and worth reading twice. The route to the missing constraint is not deduction — it is a vague sense that the answer "12 rubles" is too big, which prompts a search of memory for anything that bounds $p$. Tao does not pretend he saw $0<a<10$ coming. **A feeling that an answer is the wrong size is a legitimate prompt to go looking for an unused constraint.**)*

### The resolution

Combine the congruence with the bound — Tao's sentence is "Recalling (1), this means that $0<p<5$, which, when coupled with the other equation concerning $p$, **nails the price of the penknife down to 2 rubles**." Explicitly: $p\in\{1,2,3,4\}$ and $p\equiv0,2,8\pmod{10}$ leaves exactly **$p=2$**. The penknife was worth **2 rubles** (and then $a = 10-2\cdot2 = 6$: the younger brother's last handful was 6 rubles).

*Smallest possible worked instance, to see it all at once:* $s=4$ sheep, so 16 rubles. Older takes 10; younger's turn, 6 rubles left, he takes 6. So $n=0$, $a=6$. Older has 10, younger has 6; the older hands over the 2-ruble penknife and both end on 8. Every equation checks: $16=10(2\cdot0+1)+6$ ✔, $0<6<10$ ✔, $6=10-2\cdot2$ ✔.

Robustness check, which Tao performs himself: "(Note that this argument works even if we allow $a$ to be zero.)" With $0\le a\le9$ the bound becomes $\tfrac12\le p\le5$, and $p=2$ is still the only survivor. The soft semantic assumption was not load-bearing.

### The sting in the tail: partial determination

`[solve only what was asked — Technique 43]` "Curiously, while there is enough information to determine the price of the penknife, there is not enough information to determine the price or number of the sheep."

We need $s^2 \equiv -2\cdot2 = -4 \equiv 16 \pmod{20}$. So $s$ must be even (that's $s^2\equiv0$ mod 4) and $s\equiv\pm1 \pmod 5$ (that's $s^2\equiv1$ mod 5) — which means $s\equiv4$ or $6\pmod{10}$: the herd could have $4, 6, 14, 16, 24, 26, 34, 36,\dots$ sheep.

> *A note on the printed text.* On p. 97 this is given as "In fact, all we can say about $s$ is that $s = \pm4$ (mod 20); thus the number of sheep could be $4,16,24,36,44,56,\dots$". That list is incomplete. Do the check by hand — squares mod 20, for $s=0,1,2,\dots,19$, are
> $$0,\ 1,\ 4,\ 9,\ 16,\ 5,\ 16,\ 9,\ 4,\ 1,\ 0,\ 1,\ 4,\ 9,\ 16,\ 5,\ 16,\ 9,\ 4,\ 1,$$
> so $s^2\equiv16 \pmod{20}$ happens for $s \equiv 4,\ 6,\ 14,\ 16 \pmod{20}$ — four residues, not two. Tao's "$\pm4$" catches $4$ and $16$ and misses $6$ and $14$. Sanity-check $s=6$ directly: 6 sheep at 6 rubles each is 36 rubles. Older takes 10 (has 10), younger 10 (has 10), older 10 (has 20), and 6 rubles remain on the younger's turn, so he takes 6 (has 16) — the younger brother is indeed last and short. Fairness: $20-p = 16+p \Rightarrow p=2$ ✔. So $s=6$ satisfies every condition, and the full answer is $s\equiv4$ or $6 \pmod{10}$, i.e. $4, 6, 14, 16, 24, 26, 34, 36, \dots$. The printed value of $p$ is unaffected — indeed the point Tao is making, that $s$ is *not* determined, is only reinforced.
>
> *Why this is a nice error to have found.* It comes from a very common slip: knowing $s^2 \equiv 16$ and reflexively concluding $s \equiv \pm 4$, which is the correct rule modulo a *prime* but not modulo 20. Mod a composite, a square can have more than two square roots — here 16 has four ($4, 6, 14, 16$), because $20 = 4\times5$ and you get independent choices mod 4 and mod 5. The safe habit is the one used above: **write out the table of squares rather than trusting $\pm$.**

### Tao's closing method — the checklist (p. 97)

This is the most directly copyable paragraph in the chapter.

> "With puzzles like these, you need all the information you can get. The best way is to spread out all the information in the puzzle and write each piece separately, for example, like so:"

His list of facts — note that they are stated in **plain English first**, with no symbols at all:
- (a) there was a square number of roubles divided;
- (b) the younger brother missed out a piece of his share;
- (c) the piece missing had to be balanced by the penknife.

"One should then reduce these facts to equations as quickly as possible":
- (a) $s^2 = 10(2n+1)+a$;
- (b) $0<a<10$;
- (c) $a = 10-2p$.

**The two-column shape is the technique.** English on the left, algebra on the right, one line each. Writing the English column first is what stops you from silently dropping a fact you don't yet know how to symbolize — "the younger brother missed out a piece of his share" is easy to write and only *then* becomes the innocuous $0<a<10$. If you go straight to symbols you write down the equations you know how to write down, which is not the same set.

And the punchline: "One should try to capture each piece of information, **no matter how useless-looking**. For example, I could have put in that $n$ was probably non-negative, or than $p$ probably had to be positive (**why mention a worthless penknife in the question**), that there were a positive integer number of sheep, and so on. Once everything is sealed into equations things become a lot easier to manipulate correctly."

The three extra constraints he mentions but does not use are worth writing out, because they are exactly the kind you'd omit:
- $n \ge 0$ — the younger brother took some non-negative number of full packets. (Needed if you want to conclude the *smallest* herd is 4; without it, $s^2 = 20(n+1)-4$ would admit nonsense.)
- $p > 0$ — semantic: "why mention a worthless penknife in the question". Soft, and Tao is upfront about that.
- $s$ a positive integer — the reason $s^2$ is a *perfect square* rather than just a real number, which is the entire basis of step 9.

Notice the specific irony: fact (b), $0<a<10$ — the most boring line on the page — is the one that converts "$p$ is one of infinitely many values" into "$p=2$". And notice the closing clause: "things become a lot easier to **manipulate correctly**". Not "easier to solve" — *easier to manipulate correctly*. The claim is about error rate. Symbols are a discipline as much as a tool.

### Transferable lesson

Three things. (1) *Never conclude "not enough information" before writing every fact as an equation.* (2) *If an unknown is a nuisance, kill it with a modulus* — mod $m$ erases anything that appears as a multiple of $m$. (3) *Not being able to solve for everything is not failure.* The question asked for the penknife, not the sheep. Extracting exactly the determined quantity from an under-determined system is a skill in itself, and the contrast with Problem 6.2 (where everything got pinned) is deliberate.

---

## What this chapter teaches about problem solving in general

1. **To prove something is impossible, don't search — find an invariant.** A conserved quantity is a certificate: one line to state, one line to check, and it kills an infinite search space. The workflow is always the same three questions: *what quantity might be conserved? is it actually conserved by every move? does it differ at the target?* If the answer to the third is no, your invariant is too coarse — refine it, don't discard it. (Programmers: this is a loop invariant, and "strengthen the conclusion" is the same trick as strengthening a loop invariant until the induction closes.)

2. **When an idea half-works, the *shape of the failure* names the fix.** The point-score invariant fails "due to the cyclic nature of the manoeuvres", so the repair is cyclic arithmetic. The light analogy fails by exactly one sign, so the repair is to work in a system where that sign is invisible. This is the chapter's most reusable move, and it is the opposite of the instinct to start over. Tao pairs it with a warning: "a measly amount of success is not something to be too enthusiastic about either" — you still have to judge how much of the problem your partial idea explains.

3. **"Not enough information" almost always means "I haven't written down all the constraints".** Integrality, positivity, distinctness, a free choice of ordering, and the *English of the question* are all data. In Problem 6.2 a single equation $N(x+y+z)=39$ plus integrality plus distinctness plus "two exams are named" collapses an apparently hopeless problem to four cases. In Problem 6.4 the throwaway line $0<a<10$ is what produces the answer. Write every fact as an (in)equality *immediately*, including the ones that look useless.

4. **Notation is not bookkeeping, it is the solution's first half.** Every problem here is solved shortly after it is turned into numbers, and part of that translation is deciding what to *forget*: chameleon identities, the bar's position on the table. "Let us have some decent notation first" and "let us reduce the problem from chocolate to Mathematics" are the same instruction, and the reformulations that follow (bar $\to$ lattice point $\to$ Nim heaps) each open a different door.

5. **For games: work backwards from the end, label positions, look for the pattern, then verify the strategy rather than proving the theorem.** The order matters. First establish that *some* strategy exists (so you know what you're hunting and can argue by elimination); then compute small cases; then conjecture; then check the recipe is playable and terminating. "We do not even have to prove it … we just have to apply it. If the strategy works all the time, then fine. If not, then the guess was wrong" is a licence to be pragmatic — and it is only sound because a strategy, unlike a theorem, certifies itself when you run it.

6. **Small cases are for generating conjectures, and you need more than one.** "Not much information is gained, so let us move on to another example" — one data point is not a pattern. And Exercise 6.7 is a planted warning about the other end of the same risk: the 2-D "squares are losers" rule looks like a law and is only the shadow of the real law (nim-sum zero), so a pattern from small cases can generalize the wrong way. Conjecture cheaply; commit slowly.

7. **Modular arithmetic is a general-purpose eraser.** Two distinct uses appear in this chapter. To make a *cyclic* structure literal (mod 3 for three colours), and to *delete a variable you don't care about* (mod 20 to kill $n$). In both cases you choose the modulus to make something degenerate — the move set, or an unwanted term. Ask "what would I like to be zero?" and take that as your modulus.

8. **Solve the question that was asked.** Problem 6.4's final twist is that the penknife is determined and the herd is not. A system can be under-determined overall and perfectly determined in the one quantity you were asked about — so aim at the target, and don't read "I can't find $s$" as "I can't solve the problem".

9. **Narrate your own position, constantly.** This is the most visible habit in the chapter and the easiest to overlook because it isn't mathematics. Tao interrupts himself on nearly every page to say where he is: "This should prove useful"; "we still do not know two things that should be important"; "the one piece of data that has not been used fully is…"; "So this is our next task"; "But we can do even better"; "We are getting closer to our goal … But we are still not done yet"; "So we have made a major breakthrough"; "This is getting us closer to our goal … but we still have this pesky $s$ to deal with"; "Now we have notation, and an abstract mathematical model. What we need now is a good grip on the problem". Each of these does one of four jobs: **inventory** what you know, **audit** what you have not used *fully*, **name** the next sub-goal, or **measure** progress against the actual question. That loop — inventory, audit, sub-goal, measure — is what carries you through a nine-page problem where no single step is hard.

10. **Ask what the problem's verbs mean.** Every problem in this chapter turns on the operation, not the state: chameleons *merge*, grasshoppers *hop over*, checkers *jump over*, chocolate *breaks*, brothers *take turns*. Tao says it outright — "this merging can be focussed on" — and each verb comes with its own conserved quantity: merging conserves a weighted total (mod 3); hopping-over flips permutation parity; jumping-over preserves a lattice; breaking strictly decreases area; alternating turns creates the win/loss labelling. Before looking for structure in the numbers, look for structure in the action.

11. **Do the checks the text skips, and expect to find mistakes.** Tao's exposition contains four separate slips in fifteen pages — the reachable residue vectors on p. 85, the case letter "(c)" for "(b)" on p. 87, "sure losers" for "sure winners" on p. 92, and $s\equiv\pm4$ instead of $s\equiv4,6,14,16 \pmod{20}$ on p. 97 — every one of them at a place where he moves fast ("investigation shows", "as we have shown above", "all we can say"). None of them damages a conclusion, which is itself instructive: a solid argument survives local errors, and the way you find out whether yours is solid is by redoing the arithmetic. When a text says "try it yourself", it is not being lazy; it is telling you where the learning is.

12. **Note where the chapter stops.** Problem 6.4 is the last thing in the chapter — there are no exercises after it, and no summary section. The checklist paragraph on p. 97 *is* the chapter's conclusion, which is Tao telling you which of the four problems carries the transferable lesson he most wants you to leave with: *spread out all the information in the puzzle, write each piece separately, reduce each to an equation as quickly as possible, and capture every piece no matter how useless-looking.* If you remember one paragraph from Chapter 6, that is the one he chose.

13. **Prefer the elegant proof, and know why.** Twice in this chapter a complete-but-ugly route is available and Tao walks past it: the Cramer's-rule/Diophantine computation in Problem 6.1 ("Let us try for a more elegant method"), and the full induction on winning positions in Problem 6.3 ("we do not even have to prove it … we just have to apply it"). The reasons are practical, not aesthetic — the elegant version is shorter to check, easier to generalize, and states the actual *reason* the result is true. The grinding version answers the question; the elegant version teaches you something you can use tomorrow. Both are legitimate outputs; know which one you are producing.
