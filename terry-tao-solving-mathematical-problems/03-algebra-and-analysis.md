# Chapter 3: Examples in algebra and analysis

> This is the chapter where Tao works with the least raw material and gets the most out of it. Its problems are all of the form "here are one, two, or three facts about an object — now pin the object down completely." Section 3.1 does this for *functions* (you are told an equation or an inequality that $f$ satisfies, and you must determine $f$ exactly); Section 3.2 does it for *polynomials* (you are told a structural fact, and you must prove a factorization exists, or prove that none can). Tao calls the first kind "pocket mathematics": "instead of the three dozen axioms and countless thousands of theorems, one only has a handful of 'axioms' (i.e. data) to use" (p. 36). That scarcity is exactly what makes the chapter useful for learning technique — with only two or three facts available, every move you make is forced to be a deliberate choice about *which* fact to use and *what to substitute into it*, and Tao narrates each choice as he makes it. The transferable content is a small, sharp toolkit: strengthen an inequality by exploiting integrality, substitute pertinent values, squeeze a quantity from both sides, put the fact you actually need *into* the induction hypothesis, and — for polynomials — convert every question about values into a question about roots, then count degrees. The chapter's epigraph states the theme better than any summary: Hertz's remark that with mathematical formulae "we get more out of them that was originally put into them" (p. 35) is precisely what every problem here demonstrates.

Pages covered: chapter opener p. 35, §3.1 "Analysis of functions" pp. 36–41, §3.2 "Polynomials" pp. 41–48.
Contents: Problems 3.1–3.4, Exercises 3.1–3.8. (There is no Problem 3.5; the chapter has four worked problems.)
Attributions as printed: Problem 3.1 = Greitzer 1978, p. 19 ($*$); Problem 3.2 = Australian Mathematics Competition 1984, p. 7; Problem 3.3 = Australian Mathematics Competition 1987, p. 13; Problem 3.4 = unattributed ($**$); Exercise 3.3 ($*$); Exercise 3.4 = 1986 International Mathematical Olympiad, Q5 ($**$). The one outside reference Tao gives in the chapter is Hardy 1975, pp. 33–34, for the classical inequalities (Cauchy–Schwarz, AM–GM) — offered as a pointer at the exact moment he decides *not* to use them.

---

## The techniques at a glance

| # | Technique | Trigger — what makes you reach for it | Where Tao uses it in this chapter |
|---|---|---|---|
| 1 | **Read the fine print; find the one unusual feature** | The problem looks like a standard type but resists standard handling | p. 36: Problem 3.1's $f$ maps integers to integers, "unlike most questions involving functional equations, which usually map onto the real numbers" |
| 2 | **Integrality upgrade: turn $a>b$ into $a\ge b+1$** | A *strict* inequality between two integers | p. 36, eq. (10): $f(n+1)>f(f(n))$ becomes $f(n+1)\ge f(f(n))+1$ |
| 3 | **Substitute pertinent values** | Any functional equation or functional inequality | p. 37: "The standard method of dealing with these equations is by substituting pertinent values into the variables", starting at $n=1$ |
| 4 | **Small cases first, to get a feel** | You don't yet know what the general pattern is | p. 37 ($f(2)$, then $f(3)$, then $f(4)$); p. 39 "with functional equations we should try small examples first to get a 'feel' of the question" |
| 5 | **Aim at the objective; go sideways only as a last resort** | You have several possible next moves | p. 37: "Always try to use tactics that get you closer to the objective, unless all available direct approaches have been exhausted." |
| 6 | **Use the expected answer as a compass, never as a premise** | You can guess the answer but not prove it | p. 37: "we 'secretly' know that $f(n)$ should eventually equal $n$ … but we cannot use that fact yet" |
| 7 | **"Reeks of induction": case $n$ built from case $n-1$** | Your small-case argument reused the previous small case | p. 37 "the general proof reeks of induction"; p. 40 "smells heavily on induction" |
| 8 | **Choose the flavour of induction: ordinary vs. *strong*** | You leaned on *several* earlier cases, not just the last one | p. 40: "because we are not just using one previous result, but several previous results, we probably need *strong* induction" |
| 9 | **Strengthen the induction hypothesis — prove more, so you can prove it** | The naive induction hypothesis isn't strong enough to feed the next step | p. 37: replace "$f(n)\ge n$" by Lemma 3.1, "$f(m)\ge n$ for all $m\ge n$" |
| 10 | **Specialize the general lemma back to what you wanted** | You proved something stronger than the goal | p. 38: set $m=n$ in Lemma 3.1 to get $f(n)\ge n$ |
| 11 | **Substitute derived expressions into your own formula — after checking they're legal** | Your formula holds "for all $n$" and you have a handy non-obvious value of $n$ | p. 37: plug $f(2)-1$ into the $n$ slot; "This works because we already know that $f(2)-1$ is at least 1" |
| 12 | **Recombine each new result with the old data** | You just proved something new and don't know what to do next | p. 38: "once we have a new result, we should just play around with it and try to recombine it with previous results" |
| 13 | **Feed a function into its own inequality** | The inequality holds for all $n$, and $f(n)$ is itself a legal input | p. 38: replace $n$ by $f(n)$ in $f(n)\ge n$ to get $f(f(n))\ge f(n)$ |
| 14 | **Upgrade a computation into a structural property, then use it to cancel** | You derived monotonicity, injectivity, positivity, etc. | p. 38: $f(n+1)>f(n)$ means $f$ is increasing, so $f(n+1)>f(f(n))$ collapses to $n+1>f(n)$ |
| 15 | **Squeeze: prove $\ge$ and $\le$ separately** | Your goal is an equality but your data are inequalities | p. 38: $f(n)\ge n$ and $n+1>f(n)$ together give $f(n)=n$ |
| 16 | **Integer squeeze: nothing lives strictly between $k$ and $k+2$** | An integer quantity is trapped strictly between two integers two apart | p. 39: $2<f(3)<4\Rightarrow f(3)=3$; p. 40: $2n<f(m)<2n+2\Rightarrow f(m)=2n+1$ |
| 17 | **Manufacture the bound you're missing** | Your squeeze needs a neighbouring value you don't have yet | p. 40: to squeeze $f(5)$ you need $f(6)$; get it from $6=2\times3$ and multiplicativity |
| 18 | **Generalize the question: compute everything, not just what was asked** | You're asked for one specific value of an unknown object | p. 39: "The best way is to try to evaluate all of $f$, not just $f(1983)$" |
| 19 | **Mine the problem statement itself for information** | The problem says "Find X" | p. 39: a unique answer is *implied*; and "because of the ordinariness of 1983 we might reasonably conjecture that there is only one solution to $f$" |
| 20 | **Guess a solution, verify it, then reduce "find" to "prove unique"** | You spot a pattern in your small cases | p. 39: $f(2^n)=2^n$ suggests $f(x)=x$; check it against (a),(b),(c); then prove uniqueness |
| 21 | **Prove the more general but clearer statement** | The literal question is a special case of a cleaner one | p. 39: prove "the only such $f$ is the identity" instead of "find $f(1983)$" |
| 22 | **Bootstrap from generators** | Your data pins the function on a multiplicative or additive generating set | p. 39: $f(2)=2$ plus multiplicativity gives $f(2^n)=2^n$; Exercise 3.1's hint: integers $\to$ rationals $\to$ reals |
| 23 | **Case split on parity inside an induction** | The even and odd cases have genuinely different available data | p. 40, Lemma 3.2: $m=2n$ (use multiplicativity) vs. $m=2n+1$ (use monotonicity) |
| 24 | **Notice cross-problem analogies** | A move that just worked has a familiar shape | p. 40: "see how this is similar to the previous question, $f(n+1)>f(f(n))$?" — both hinge on integrality |
| 25 | **Recall/assemble the toolkit before attacking a family of problems** | You're about to enter a new domain | pp. 41–43: Tao pauses for two pages of polynomial definitions and facts before Problem 3.3 |
| 26 | **Try the direct approach, then formally declare it dead** | Anything | p. 43: raise (12) to the fifth power $\Rightarrow$ "a whole lot of messy terms". "So much for the direct approach." |
| 27 | **Treat suspicion as a signal: a fishy hypothesis is a strong hypothesis** | A given equation looks like a schoolboy error | p. 43: (12) "looks suspect… This gives us our first real clue: the first equation should restrict $a$, $b$, and $c$ quite a bit" |
| 28 | **Normalize the data into its simplest equivalent form** | Your hypothesis has fractions, radicals, or nesting | p. 43: common denominator, cross-multiply, reach the reciprocal-free polynomial (14) |
| 29 | **Screen candidate tools against the hypotheses before using them** | You're tempted by a big-name theorem | p. 43–44: AM–GM and Cauchy–Schwarz need positivity; in fact (12) *forces* $a,b,c$ not all positive |
| 30 | **Only two general ways to derive one equation from others** | You must get equation B out of equation A | p. 44: "proving an intermediate result, or by doing some useful substitution" |
| 31 | **Prefer a parameterization as your intermediate result** | You need an intermediate result and have a choice | p. 44: "The best kind of intermediate result is a parameterization, as this can be substituted directly into the desired equation" |
| 32 | **Stick with the easy options first** | An exotic method (calculus on a contour) suggests itself | p. 44, parenthetical: "it is best to stick with the easy options first" |
| 33 | **Solve for a variable using whichever form is easiest** | Two equivalent equations, one nastier | p. 44: (14) won't solve for $a$ nicely; (12) does |
| 34 | **Recast a constraint as "the roots of a polynomial", then factorize** | Your constraint is a polynomial equation | p. 44: "The best way to deal with roots of polynomials is to factorize the polynomial (and vice versa)" |
| 35 | **Guess factors from structure: homogeneity, symmetry, degree** | You believe a factorization exists but not which one | p. 44: homogeneous $\Rightarrow$ homogeneous factors; symmetric $\Rightarrow$ factors permute each other; cubic $\Rightarrow$ a linear factor exists |
| 36 | **Try the "nice" candidates first, uglier ones later** | A search space of candidate factors | p. 44: try $a+b,\ a-b,\ a,\ a+b+c,\ a+b-c$; "Things like $a+2b$ … are not as 'nice'" |
| 37 | **Reason backwards from the target to constrain the intermediate form** | You know where you must end up | p. 44: since (14) must imply (13), a usable rewritten form of (14) must exist, and for a polynomial that means a factorization |
| 38 | **Factor theorem as a test** | You have a candidate linear factor | p. 43 & 44: $x-a$ divides $f$ iff $f(a)=0$ — used to confirm $a+b$, $b+c$, $c+a$ |
| 39 | **Case analysis on a factored condition** | Your hypothesis reduces to "$P=0$ or $Q=0$ or $R=0$" | p. 44: substitute each of $a+b=0$, $b+c=0$, $c+a=0$ into the goal |
| 40 | **Proof by contradiction: assume the factorization exists** | You must prove something *cannot* be done | p. 45: "suppose that $f(x)$ is factorizable into two non-trivial integer polynomials, $p(x)$ and $q(x)$" |
| 41 | **Plug in the values that make factors vanish** | Your object is built from explicit linear factors | p. 45: "the nicest factor one can have is 0" — set $x=a_i$, get $f(a_i)=1$ |
| 42 | **Escalate from real information to integer information** | A product of *integers* equals a small number | p. 45–46: $p(a_i)q(a_i)=1$ with integers $\Rightarrow$ both $+1$ or both $-1$ |
| 43 | **Degrees of freedom vs. constraints; pigeonhole on degrees** | A polynomial is pinned at many points | p. 46: $\deg p+\deg q=2n$, so one of them has degree $\le n$, yet it is pegged at $n$ points |
| 44 | **No roots $\Rightarrow$ no sign change** | A real polynomial is known to be nowhere zero | p. 46: $f\ge1$ has no real roots $\Rightarrow$ $p$ has none $\Rightarrow$ $p$ never changes sign |
| 45 | **WLOG via a symmetry of the *situation*** | Two cases, one obviously convertible into the other | p. 46: $f=pq$ gives $f=(-p)(-q)$, so assume $p>0$ |
| 46 | **Shift to make it a root statement** | You know a polynomial takes a *constant value* at many points | p. 46: "$p(x)$ and $q(x)$ are forced to take on the value of $+1$ at least $n$ times… $p(x)-1$ … has at least $n$ roots" |
| 47 | **Reconstruct a polynomial from its full root list plus leading coefficient** | You know all its roots and its degree | p. 46–47: $p(x)-1=r(x-a_1)\cdots(x-a_n)$ |
| 48 | **Integrality of the leading coefficient** | An integer polynomial written in factored form | p. 47: "the leading coefficient of $p(x)-1$ is $r$ … $r$ and $s$ have to be integers" |
| 49 | **Compare coefficients of two explicit polynomials** | You have an identity between two fully written-out polynomials | p. 47: "The best thing to do now is to compare coefficients"; the $x^n$ coefficients give $rs=1$ |
| 50 | **Derive an absurdity from an "identity" that can't hold for all $x$** | You reach an equation with a free variable | p. 47: $2(x-a_1)\cdots(x-a_n)=0$ "is ridiculous (it must hold for all $x$)" |
| 51 | **"The other case is similar" — symmetric case reduction** | Two cases differ by a sign flip | p. 47: "The case $r=s=-1$ is similar" |
| 52 | **Bookkeeping discipline: sum up what you know; be careful with notation** | Long multi-stage argument | p. 46 "To sum up what we know so far"; and the warning that $\pm$ is *not* uniform across different $a_i$ |
| 53 | **Zero-product principle** | Your data mixes products of function values with statements about being zero | p. 41, Exercise 3.4 hint: "what can one say when a product equals 0?" |
| 54 | **Robustness testing: weaken your own hypotheses and see if the proof survives** | You just finished a proof | Exercises 3.2 and 3.3: re-solve Problem 3.2 with $f(2)=2$ weakened, and with integer values relaxed to reals |
| 55 | **A strategy that cracks one problem may be ineffective on its cousin** | You want to reuse a trick | p. 47–48, Exercise 3.7's note: the $p-q$ trick "could also be applied to Problem 3.4, but turns out to be somewhat ineffective in that case" |
| 56 | **Scarcity of data is a *navigational* asset: few hypotheses ⇒ few directions** | You feel lost in a problem with two or three givens | p. 36: "there is only one or two pieces of data that can be used, so there should be a clear direction in which to go"; p. 43: "There is really only one piece of information given, so there should be a straightforward sequence of logical steps" |
| 57 | **A formula returns more than you put in — read off its unrequested consequences** | You have an identity | p. 35, chapter epigraph (Hertz): "we get more out of them that was originally put into them"; the cubes identity's free corollary "the sum of the first few cubes will always be a square" |
| 58 | **Recognize that an identity is about a *structure*, not about numbers** | An algebraic manipulation used only $+,-,\times,\div$ | p. 35: matrix algebra "does much the same but with groups of numbers"; $(I-A)^{-1}=I+A+A^2+\cdots$ holds "under special conditions" |
| 59 | **Filter your recombinations — most are junk; keep the one that resembles the goal** | You have just combined old and new facts several ways | p. 38: "The only useful result we get is $f(n+1)\ge f(f(n))+1\ge f(n)+1$" |
| 60 | **Escalate a trivial bound by analogy with the bound one level down** | You used "$f(\text{anything})\ge1$" and it wasn't enough | p. 37: "Earlier we said $f(f(1))$ was at least 1. Perhaps $f(f(2))$ is at least 2." |
| 61 | **Deliberately replay the move that just worked on the next case** | A case just fell to a specific tactic | p. 40: "Using (c) in the hope of doing what we did to $f(3)$"; p. 40: "Let us see if we can use this clue more often" |
| 62 | **Track and announce your progress; use "how far have I got" as a decision signal** | Mid-exploration | p. 40: "This seems to be going well; we have now worked out all the values of $f(n)$ up to $n=6$" |
| 63 | **Name the difficulty of the induction before doing it** | You are about to write an induction you suspect is awkward | p. 37: "The induction is just a little tricky though." |
| 64 | **The direct approach can die twice — re-test it after simplifying** | You just normalized your hypothesis | p. 44: after reaching (14), "Again, the direct approach is not feasible" |
| 65 | **Experimentation is a legitimate, nameable step** | Structure has narrowed the candidates but not chosen one | p. 44: "But to find out what they are, we have to experiment." |
| 66 | **Guessing is part of the official method: "guess *and prove* an intermediate result"** | You need a lemma and have no derivation for it | p. 44: "So we will try to guess and prove an intermediate result." |
| 67 | **Use "roots of a factor ⊆ roots of the whole" as a divisibility *test*** | You want to know whether $p$ divides $f$ | p. 43: "this can be a useful piece of information in deciding whether one polynomial divides another" |
| 68 | **Read whether the problem promises existence** | The wording is "Find …" | p. 41, Exercise 3.4: "Find all (**if any**) functions" — contrast p. 38's "Find $f(1983)$", which *does* promise |
| 69 | **State the arena you are arguing in (reals vs. complexes)** | You just said "no roots" | p. 46: "There are none! (Well, none on the real line, at least.)" |
| 70 | **WLOG is a labour-saving device — count the work it saves** | You face two cases | p. 46: "we can save a little bit of work by observing that one case implies the other" |
| 71 | **Hedge honestly when your knowledge is partial** | You have narrowed a value but not fixed it | p. 46: "We have found, **more or less**, the value of $p(a_0),\ldots,p(a_n)$" — the hedge is what keeps the $\pm$ bookkeeping honest |

**Where techniques 56–71 are discussed below** (they are folded into the sections whose material they belong to rather than given their own numbered headings): 56, 57, 58 in *The openers*; 59 in *Technique 11–13*; 60–63 in *The micro-moves of the small-case phase*; 64 in *Technique 26*; 65, 66 in *Technique 30–33* and *Technique 34–39*; 67 in *Background* item 8; 68 in *Does the problem promise that an answer exists?*; 69, 70, 71 in *Technique 40–52*.

---

## The openers (p. 35 and p. 36): what Tao says algebra and analysis *are*

Easy to skip, and worth not skipping — the chapter's epigraph is a one-sentence statement of the whole chapter's method, and the two section openers tell you why these particular problems are good practice.

**The epigraph** (p. 35), Heinrich Hertz quoted by F. J. Dyson:

> "One cannot escape the feeling … that these mathematical formulae have an independent existence and an intelligence of their own … that they are wiser than we are, wiser even than their discoverers … that we get more out of them that was originally put into them."

That last clause *is* the chapter. Every problem here hands you one or two facts and asks for a conclusion that looks far too strong for the input — an inequality that yields an equality, one value of $f$ that yields all of them, a fifth-power identity out of a first-power one. Hertz's claim is that this is normal: a formula, once written down, contains consequences its author never intended. The practical corollary for you is Technique 57: **after you write down an identity, interrogate it for facts you did not ask for.**

**Tao's framing of algebra** (p. 35). "Algebra is what most people associate with mathematics. In a sense, this is justified. Mathematics is the study of abstract objects, numerical, logical, or geometrical, that follow a set of several carefully chosen axioms. And basic algebra is about the simplest meaningful thing that can satisfy the above definition of mathematics. There are only a dozen or so postulates, but that is enough to make the system beautifully symmetric."

Note the connection to "pocket mathematics" below: Tao likes algebra *for the same reason* he likes functional-equation problems — a tiny axiom set with rich consequences. The chapter is the small-axiom-set aesthetic applied twice, once to a subject and once to individual problems.

**His favourite algebraic identity** (p. 35), given as an illustration:
$$1^3+2^3+3^3+\cdots+n^3=(1+2+3+\cdots+n)^2.$$
"This means, in part, that the sum of the first few cubes will always be a square; for example, $1+8+27+64+125=225=15^2$."

Two things to take from this. (i) The hand computation. Tao does not merely assert the identity, he *evaluates a case*: $n=5$ gives $1+8+27+64+125=225$ on the left and $(1+2+3+4+5)^2=15^2=225$ on the right. That reflex — check the identity at a small value before trusting it — is Technique 4, appearing before the chapter has formally begun. (ii) The corollary he points at is one *nobody asked for*: the identity was a statement about a sum of cubes, and it hands you for free the fact that such a sum is always a perfect square. This is Hertz's point cashed out on a concrete example.

(For a reader who has not seen it: $1+2+\cdots+n = n(n+1)/2$, so the identity says $\sum_{k=1}^n k^3 = \big(n(n+1)/2\big)^2$. Nothing in this chapter depends on it; it is here as an example of the aesthetic.)

**"There is more than one algebra"** (p. 35). "Algebra is the study of numbers with the operations of addition, subtraction, multiplication, and division. Matrix algebra, for example, does much the same but with groups of numbers instead of using just one. Other algebras use all kinds of operations and all kinds of 'numbers' but they, sometimes surprisingly, tend to have much of the same properties as normal algebra. For example, a square matrix $A$ can, under special conditions, satisfy the algebraic equation
$$(I-A)^{-1}=I+A+A^2+A^3+\cdots.$$"

This is Technique 58, and it is the most CS-relevant remark on the page. The formula is the geometric series $\frac{1}{1-x}=1+x+x^2+\cdots$ with the number $x$ replaced by a matrix $A$, the number $1$ replaced by the identity matrix $I$, and "reciprocal" replaced by "matrix inverse". The point is that a derivation which used only the ring operations does not care what it is operating on — so a scalar identity often transfers verbatim to matrices, to polynomials, to functions, to anything with $+$ and $\times$. In programming terms it is the difference between a function typed `float -> float` and the same function written against an interface: the algebra was always generic; you just wrote it monomorphically.

The words "under special conditions" carry a warning that is worth unpacking, because it is exactly the kind of fine print Technique 1 tells you to read. For real numbers, $1+x+x^2+\cdots$ converges only when $|x|<1$; for matrices the analogous requirement is that $A$ be small in the right sense (all eigenvalues of absolute value less than 1). So the transfer of an identity across structures is not automatic — the *algebra* transfers, the *convergence* has to be re-earned. (This series is called the Neumann series; you will not need it again in this chapter.)

**Why algebra still has problems in it** (p. 35). "Algebra is the basic foundation of a large part of applied mathematics. Problems of mechanics, economics, chemistry, electronics, optimization, and so on are answered by algebra and differential calculus, which is an advanced form of algebra. In fact, algebra is so important that most of its secrets have been discovered—so it can be safely put into a high-school curriculum. However, a few gems can still be found here and there."

The methodological content of that last sentence: a *thoroughly explored* subject is a good hunting ground for competition problems precisely because the tools are all elementary and universally known, so the difficulty has to live in the *cleverness of the assembly* rather than in the machinery. That is why this chapter needs almost no prerequisites and is still hard.

**§3.1's opener — what "analysis" means, and why these problems are good practice** (p. 36). "Analysis is also a heavily explored subject, and it is just as general as algebra: essentially, analysis is the study of functions and their properties. The more complicated the properties, the 'higher' the analysis. The lowest form of analysis is studying functions satisfying simple algebraic properties, for instance one can consider a function $f(x)$ such that
$$f \text{ is continuous},\quad f(0)=1,\quad f(m+n+1)=f(m)+f(n)\ \text{ for all real } m,n \tag{9}$$
and then deducing properties of the function."

Tao's grading of analysis by the complexity of the property being assumed is a useful orientation: §3.1 sits at the very bottom of that ladder — the properties assumed are pure algebra (one equation, one value), with at most a single analytic hypothesis (continuity) bolted on at the end. So you should expect the *algebraic* hypotheses to do nearly all the work and the analytic one to be a finishing move. That prediction is correct for Exercise 3.1, and it is a good default for any problem that mixes the two kinds of hypothesis.

Then the "pocket mathematics" passage, in full: "These problems are a good way to learn how to think mathematically, because there is only one or two pieces of data that can be used, so there should be a clear direction in which to go. It is sort of a 'pocket mathematics', where instead of the three dozen axioms and countless thousands of theorems, one only has a handful of 'axioms' (i.e. data) to use. **And yet, it still has its surprises.**"

The middle clause is Technique 56 and it is actionable, not decorative: *few data implies few directions*, so if you are lost in a problem with two hypotheses, you have not run out of ideas — you have failed to notice something in the statement. (Tao's own next move in Problem 3.1 is exactly that: re-read and notice the codomain.) The closing sentence is the counterweight: small data does not mean easy.

**§3.2's opener** (p. 41). "Many algebra questions concern polynomials of one or more variables, so let us pause for a bit to recall some definitions and results concerning these polynomials." Two pages of definitions follow, then: "Now let us tackle some questions involving polynomials." That deliberate pause is Technique 25.

**And one framing line before Problem 3.4** (p. 45): "The factorization of polynomials, or impossibility thereof, is a fascinating piece of mathematics. The following question is instructive because it uses just about every trick in the book to find a solution." Note that *impossibility* is billed as being as interesting as possibility — a signal that "prove this cannot be done" problems are a first-class genre, not a curiosity.

---

## Background you need first

This chapter needs less exotic background than the number-theory or geometry chapters, but it does assume several things a CS-plus-Calculus-1 reader may not have met.

**1. "$a$ divides $b$", written $a \mid b$.** It means: $b$ is an exact integer multiple of $a$, with no remainder. $3 \mid 12$ because $12 = 3\times 4$. $3 \nmid 13$. In code: `b % a == 0`. The chapter uses the same word for polynomials: $p$ divides $f$ means $f = p\cdot q$ for some polynomial $q$, i.e. the polynomial division leaves no remainder.

**2. Induction, and *strong* induction.** Ordinary induction: prove the statement $S(1)$, then prove "$S(n)$ implies $S(n+1)$", and you get $S(n)$ for every $n$. This is exactly a recursive function whose recursive call is on $n-1$ — the base case is the `if n == 1: return` branch. *Strong* induction is the version where, when proving $S(m)$, you are allowed to assume $S(1), S(2), \ldots, S(m-1)$ *all at once*, not just $S(m-1)$. The programming analogue is memoized recursion: the value at $m$ may depend on several smaller entries of the table, not only the previous one. Tao uses ordinary induction in Lemma 3.1 and strong induction in Lemma 3.2, and says explicitly why each.

**3. A "functional equation".** A constraint on an unknown *function* rather than an unknown number. E.g. $f(m+n+1)=f(m)+f(n)$ is one equation, but it must hold for every pair $(m,n)$ — so it is really infinitely many equations at once. Your only lever is to choose particular values of $m,n$ and read off what falls out. This is the whole game in §3.1.

**4. Multiplicative functions.** A function with $f(mn)=f(m)f(n)$. Not the same as linear. Its consequence: if you know $f$ on prime powers, you know it everywhere, because every integer factors into primes. Problem 3.2 uses only the weak version of this: $f(6)=f(2)f(3)$, and $f(2^n)=f(2)^n$.

**5. Monotone (increasing) functions and what they buy you.** If $f(m)>f(n)$ whenever $m>n$, then the map "input $\to$ output" preserves order, and — crucially — the implication runs *both ways*: $f(m)>f(n)$ **if and only if** $m>n$. That biconditional is what lets you "cancel" $f$ from both sides of an inequality, which is the punchline of Problem 3.1. (An increasing function is in particular injective: different inputs give different outputs.)

**6. Polynomial vocabulary** (Tao's own recap, pp. 41–43, condensed):
- A polynomial of one variable is $f(x)=a_nx^n+a_{n-1}x^{n-1}+\cdots+a_1x+a_0$, or in Tao's compact form $f(x)=\sum_{i=0}^n a_i x^i$, with $a_n\neq 0$; $n$ is its **degree**. The coefficients $a_i$ are constants, and Tao states a blanket convention: "in this book they will always be real numbers." (Problem 3.4 then adds the *extra* hypothesis that they are integers — that is data, not the default.)
- A polynomial in several variables is $f(x,y,z)=\sum_{k,l,m}a_{k,l,m}x^ky^lz^m$, the sum running over non-negative exponents with $k+l+m\le n$, where at least one non-zero coefficient has $k+l+m=n$ exactly. Then $n$ is the degree — i.e. **the degree is the largest total exponent that actually appears with a non-zero coefficient.** Degree 2 = quadratic, 3 = cubic, and so forth. Degree 0 is called **trivial** or **constant**. (Tao's phrase "non-trivial factors" in Problem 3.4 therefore means "factors of degree $\ge1$" — you are not allowed to cheat by writing $f=1\cdot f$.)
- **Homogeneous** means *every* term has the same total degree. Example: $x^2y+z^3$ is homogeneous of degree 3, but $x^2y+z^3+xz$ is *not*, because $xz$ has degree 2. Homogeneous polynomials of degree $m$ satisfy the scaling law $f(tx_1,\ldots,tx_m)=t^m f(x_1,\ldots,x_m)$ — scale all inputs by $t$ and the output scales by $t^m$. (Concretely: $f(x,y)=x^2+xy$ is homogeneous of degree 2, and $f(3x,3y)=9x^2+9xy=9f(x,y)$.)
- $f$ is **factored** into $p$ and $q$ if $f(x_1,\ldots,x_m)=p(x_1,\ldots,x_m)q(x_1,\ldots,x_m)$ for *all* inputs (an identity, not an equation to be solved); $p$ and $q$ are then **factors** of $f$. Tao notes "it is easily proven that the degree of a polynomial is equal to the sum of the degrees of the factors" — $\deg f=\deg p+\deg q$ — and this one line is the budget that Problem 3.4 spends. (Sketch of the easy proof: the top-degree terms of $p$ and $q$ multiply to give the top-degree term of $f$, and cannot cancel because there is nothing else of that degree.) **Irreducible** means it admits no factorization into non-trivial (i.e. non-constant) pieces.
- **Roots** are the inputs where the polynomial evaluates to 0. A degree-$n$ polynomial of one variable has at most $n$ real roots (exactly $n$ if you count complex roots with multiplicity). Polynomials in $\ge 2$ variables typically have infinitely many roots.
- The **quadratic formula**: $ax^2+bx+c=0$ has roots $x=\dfrac{-b\pm\sqrt{b^2-4ac}}{2a}$. Cubics and quartics have formulas too, "much messier and not very useful in practice"; from degree 5 on, "there is no elementary formula at all!" (p. 42). This is *why* the chapter works with roots indirectly, through factoring and counting, rather than solving.

**7. The factor theorem** (p. 43, the single most-used fact in §3.2). $x-a$ divides $f(x)$ **if and only if** $f(a)=0$. Reason: $a$ is a root of $x-a$, and roots of a factor must be roots of the whole. Tiny example: $f(x)=x^2-5x+6$ has $f(2)=0$, so $x-2$ divides it — indeed $f=(x-2)(x-3)$. The corollary Tao states and later reuses in Exercise 3.8: for any polynomial $f$ and any number $t$, **$x-t$ divides $f(x)-f(t)$** (because the polynomial $g(x)=f(x)-f(t)$ has $g(t)=0$).

**8. "Roots of a factor are a subset of the roots of the whole."** If $f=pq$ and $p(c)=0$, then $f(c)=p(c)q(c)=0$. Contrapositive, used hard in Problem 3.4: if $f$ has *no* roots, neither does any factor of $f$. Tao states this fact with an explicit statement of what it is *for* (p. 43): "this can be a useful piece of information in deciding whether one polynomial divides another." That is Technique 67 — the fact is a cheap **divisibility test**, usable in both directions. Forwards: find a root of the candidate divisor $p$, evaluate $f$ there; if $f\neq0$ then $p\nmid f$, and you have ruled out a candidate in one arithmetic step. Backwards (the factor theorem, item 7): if $f$ *does* vanish there, you have found a factor. Both of Tao's uses in §3.2 are one of these two readings.

**9. Two named inequalities Tao mentions and then discards** (p. 43). **AM–GM**: for non-negative numbers, the arithmetic mean is at least the geometric mean, e.g. $\frac{x+y}{2}\ge\sqrt{xy}$ (check: $x=1,y=9$ gives $5\ge3$). **Cauchy–Schwarz**: $(x_1y_1+x_2y_2)^2\le(x_1^2+x_2^2)(y_1^2+y_2^2)$. You do not need either one to follow this chapter — the point of the passage is that Tao *rejects* them, because both want positivity and Problem 3.3 cannot supply it.

**10. "Without loss of generality" (WLOG).** A logical shortcut: you have two (or more) cases, and you show that one case can be *converted into* the other, so you only need to handle one. It is not hand-waving — you owe an actual conversion. Tao supplies one on p. 46.

**11. Density of the rationals, and continuity.** Every real number is a limit of rationals ($\pi = \lim 3, 3.1, 3.14,\ldots$). If $f$ is continuous and you know $f$ on all rationals, you know it everywhere, because you can take limits. This is the mechanism behind Exercise 3.1's three-stage hint.

---

## Technique 1: Read the fine print — hunt for the one unusual feature

**What it is.** Before doing anything, compare the problem to the standard specimens of its type and identify what is *different*. That difference is almost always where the solution lives.

**When to reach for it.** When a problem looks like a familiar type but the familiar method visibly cannot work.

**Tao's own words** (p. 36, on Problem 3.1), quoted at fuller length because the middle sentence is the part that names the standard type: "This equation looks insufficient to prove what we want. After all, how can an inequality prove an equality? **Other problems of this type (such as Exercise 3.1) involve functional *equations*, and are easier to handle because one can apply various substitutions and the like and gradually manipulate our original data into a manageable form. This question seems entirely different.** However, if the question is read carefully, we see the function takes integer values, unlike most questions involving functional equations, which usually map onto the real numbers."

Notice the shape of the reasoning: (i) name the standard type and say *why* it is tractable ("substitute, then gradually manipulate"); (ii) observe that the present problem is outside that type; (iii) therefore go looking for the compensating feature. Step (i) is the one beginners skip, and without it step (iii) has nothing to compare against.

**Seen in action.** Problem 3.1. The data is an *inequality*, $f(n+1)>f(f(n))$, but the goal is an *equality*, $f(n)=n$. Tao names the mismatch out loud — that naming is the technique. Then he asks what is special here versus the usual functional-equation problem, and the answer is: the codomain is $\mathbb{Z}^+$, not $\mathbb{R}$.

**Why it works.** Problem setters do not include odd restrictions decoratively. In Chapter 1's language, all the data is there for a reason. The domain/codomain of a function is data.

**Failure mode.** If you skim the statement and start substituting, you will spend a long time producing true-but-useless inequalities, because without integrality there is genuinely no way to get an equality out of an inequality.

---

## Technique 2: The integrality upgrade — turn $a>b$ into $a\ge b+1$

**What it is.** For integers, "strictly greater" and "greater by at least one" are the same statement. So rewrite every strict inequality between integers with an explicit $+1$.

**When to reach for it.** Whenever a strict inequality holds between two integer-valued quantities. This is one of the highest-yield moves in all of discrete mathematics and it costs nothing.

**Seen in action.** Immediately, on p. 36. Problem 3.1's data
$$f(n+1) > f(f(n))$$
becomes
$$f(n+1) \ge f(f(n)) + 1. \tag{10}$$
Tao's phrasing: "One immediate way to capitalize on this is to make the inequality 'stronger'."

**Why it works / what it buys you.** The $+1$ is a *quantitative* handle. It is the thing that will eventually be summed up $n$ times to produce the bound $f(n)\ge n$. Tao points at it explicitly on p. 37: "the $+1$ on the right-hand side hints that the $f(2)$ cannot be too small." A bare $>$ gives you no arithmetic to do; a $+1$ gives you a ladder.

Programming analogue: integers give you a discrete metric. Between `x` and `x+1` there is nothing. Real numbers have no such gaps, which is precisely why the real-valued version of these problems (Exercise 3.3) is harder and needs a different mechanism.

**Failure mode.** It only works one direction and only for integers. Do not write $f(n+1)\ge f(f(n))+1$ if $f$ maps to the reals — there $f(n+1)$ could exceed $f(f(n))$ by $0.0001$.

---

## Technique 3: Substitute pertinent values

**What it is.** A functional equation valid "for all $n$" is an infinite family of ordinary statements. Pick specific values of the variables and read off the consequences. Start with the smallest/simplest.

**Tao's own words** (p. 37): "The standard method of dealing with these equations is by substituting pertinent values into the variables, so let us start with $n=1$."

**Seen in action.**
- Problem 3.1: $n=1$ in (10) gives $f(2)\ge f(f(1))+1$.
- Problem 3.2, p. 39: put $m=2, n=1$ into $f(mn)=f(m)f(n)$ to get $f(2)=f(1)f(2)$, hence $2=2f(1)$, hence $f(1)=1$. Note how surgical this is: one substitution, one new value.
- Problem 3.4, p. 45: substitute $x=a_i$, the value that annihilates a factor.

**The refinement that matters — substitute *derived* expressions, not just constants** (Technique 11). On p. 37, Tao substitutes $n = f(2)-1$ into (10). That is not a number he was handed; it is a quantity he constructed because it is exactly what makes the resulting inequality say what he wants. And he immediately audits legality: "This works because we already know that $f(2)-1$ is at least 1" — i.e. $f(2)-1$ is inside the domain (the positive integers). Substituting an out-of-domain expression is the classic way to produce a fake proof.

**A second refinement — substitute the function into its own result** (Technique 13). On p. 38, having proved $f(n)\ge n$ for all positive integers $n$, Tao replaces $n$ by $f(n)$ to get $f(f(n))\ge f(n)$. Legal because $f(n)$ is itself a positive integer. This is the step that unlocks the whole problem.

**Failure mode.** Aimless substitution. Notice that Tao's substitutions are all chosen to move toward the objective (Technique 5), not to see what happens.

---

## Technique 4: Small cases first, to get a feel

**What it is.** Compute the first few instances by hand before attempting any general argument.

**Tao's own words** (p. 39): "with functional equations we should try small examples first to get a 'feel' of the question."

**Seen in action.** In Problem 3.1 he works out $f(2)\ge2$, then $f(3)\ge3$, then attempts $f(4)\ge4$ — and it is the *failure* of the fourth case in the naive form that reveals what the induction hypothesis must be. In Problem 3.2 he determines $f(1),f(2),f(3),f(4),f(5),f(6)$ one at a time, and only then writes down a lemma.

**The actual table Tao builds by hand in Problem 3.2** — worth writing out, because the *column on the right* is the whole content of the later induction. (Recall (a) $f(2)=2$, (b) $f(mn)=f(m)f(n)$, (c) $m>n\Rightarrow f(m)>f(n)$.)

| value | how it is obtained | which hypothesis did the work |
|---|---|---|
| $f(2)=2$ | given | (a) |
| $f(4)=f(2)f(2)=4$ | multiplicativity | (b) |
| $f(8)=f(4)f(2)=8$ | multiplicativity | (b) |
| $f(2^n)=2^n$ | "an easy induction" | (b) + induction |
| $f(1)=1$ | $f(2)=f(1)f(2)\Rightarrow2=2f(1)$; also $f(1)<f(2)=2$ | (b), cross-checked by (c) |
| $f(3)=3$ | $f(2)<f(3)<f(4)$, i.e. $2<f(3)<4$, and $f(3)\in\mathbb{Z}$ | (c) + integrality |
| $f(6)=f(2)f(3)=6$ | multiplicativity, once $f(3)$ is known | (b) |
| $f(5)=5$ | $f(4)<f(5)<f(6)$, i.e. $4<f(5)<6$, and $f(5)\in\mathbb{Z}$ | (c) + integrality + the manufactured $f(6)$ |

Tao then says, out loud: "This seems to be going well; we have now worked out all the values of $f(n)$ up to $n=6$." That sentence is Technique 62 — *state where you have got to*, because the statement is what tells you the exploration is converging rather than wandering, and it is what makes the pattern ($f(n)=n$ for $n\le6$, each new value obtained from earlier ones) visible enough to induct on.

Read the right-hand column top to bottom and the parity split of Lemma 3.2 writes itself: every even entry came from (b), every odd entry came from (c) plus integrality.

**Why it works.** Small cases do three jobs at once: they tell you whether the claim is even true, they reveal the pattern to conjecture, and — most importantly here — the *reasoning* used in the small cases is the template for the induction step. Tao's inductions in both problems are literally transcriptions of what he did for $n=3$ and $n=4$.

**Failure mode.** None warned of here, but note that in Problem 3.1 the small cases were *not enough*: the $n=4$ case required a genuinely new idea (Technique 9). Small cases diagnose; they don't always cure.

---

## Technique 5: Aim at the objective; sideways and backwards are last resorts

**What it is.** Among the available moves, prefer the one whose output most resembles the thing you are trying to prove.

**Tao's own words** (p. 37, one of the chapter's key metacomments): "Always try to use tactics that get you closer to the objective, unless all available direct approaches have been exhausted. Only then you should think about going sideways, or—occasionally—backwards."

**Seen in action.** After deriving $f(2)\ge2$, Tao immediately remarks "Now, we have to show that $f(2)$ is actually 2, so we may be on the right track" — he is using resemblance-to-goal as a *confidence signal*, then asking the parallel question "can we show that $f(3)$ is at least 3?" rather than exploring what else (10) might yield.

Compare Problem 3.3, where the direct approach *is* exhausted (p. 43, "So much for the direct approach") and Tao then goes sideways: he rewrites the hypothesis into an equivalent but structurally different form, which is a lateral move, not a forward one.

**Why it works.** It is best-first search with "distance to goal" as the heuristic. It prunes the enormous tree of true-but-irrelevant deductions.

**Failure mode.** The clause "unless all available direct approaches have been exhausted" is the important half. Problems 3.3 and 3.4 both *require* sideways moves. Goal-directedness is a default, not a law.

---

## Technique 6: The expected answer is a compass, not a premise

**What it is.** You may use your guess about the answer to decide what to try. You may not use it as a step in the proof.

**Tao's own words** (p. 37): "Indeed, since we 'secretly' know that $f(n)$ should eventually equal $n$, we know that $f(f(2))$ *is* 2—but we cannot use that fact yet, since we cannot actually use what we are trying to prove."

**Seen in action.** Tao wants a lower bound on $f(f(2))$. He knows from the goal that the truth is $f(f(2))=2$, so he sets himself the target "prove $f(f(2))\ge2$" and then finds an independent argument for it. The guess set the target; it did not justify it.

**Why it works.** In search terms, the conjectured answer is an admissible heuristic: it tells you which subgoals are worth attempting, so you don't waste effort trying to prove something false.

**Failure mode.** Circularity. The whole discipline of this technique is keeping the compass out of the proof. Tao flags the temptation explicitly rather than silently avoiding it — which is why it's worth quoting.

---

## Technique 7: "Reeks of induction" — when a small case reuses the previous one

**What it is.** A structural diagnosis. If the argument for case $n$ consumed the conclusion of case $n-1$, then you are already doing induction; formalize it.

**Tao's own words.** p. 37: "Because we used the fact that $f(2)$ was at least 2 to prove that $f(3)$ was at least 3, the general proof reeks of induction." p. 40: "Because we seem to be relying on past results to attain the new ones, the general proof smells heavily on induction."

**Seen in action.** Both Problem 3.1 and Problem 3.2, at exactly the moment the small-case exploration starts repeating itself.

**Why it works.** Induction is recursion. If your hand computation of case $n$ makes a "call" to case $n-1$, the proof is a recursive function and induction is just writing down its contract.

---

## Technique 8: Choose the flavour of induction by counting which earlier cases you used

**What it is.** If case $n$ needs only case $n-1$: ordinary induction. If it needs several earlier cases, or an earlier case you can't predict: **strong** induction (assume the statement for *all* smaller values).

**Tao's own words** (p. 40): "because we are not just using one previous result, but several previous results, we probably need *strong* induction."

**Seen in action.** Lemma 3.1 (Problem 3.1) is ordinary induction on $n$. Lemma 3.2 (Problem 3.2) is strong induction, because computing $f(m)$ for odd $m=2n+1$ uses both $f(2n)$ and $f(n+1)$ — two different smaller values, neither of which is $m-1$ in a predictable way.

**Why it works.** Same reason memoization beats a single-step recurrence when the dependency graph is not a chain.

---

## Technique 9: Strengthen the induction hypothesis — prove more so that you can prove it at all

**What it is.** The most important technique in §3.1. When the obvious induction stalls because the hypothesis $S(n)$ is too weak to feed the step, replace $S(n)$ by a *stronger* statement $S'(n)$ that is (a) still provable and (b) strong enough to feed itself.

**When to reach for it.** When you can see precisely which extra fact the induction step needs. Tao's rule of thumb (p. 37): "The easiest way to do that is to put that kind of fact into the induction we are trying to prove."

**Seen in action** (Problem 3.1, p. 37). The naive target is $f(n)\ge n$. To push from $f(3)\ge3$ to $f(4)\ge4$, you use $f(4)\ge f(f(3))+1$ and want $f(f(3))\ge3$. You know $f(3)\ge3$. So what you need is a fact of the form: **"if $n\ge3$ then $f(n)\ge3$"** — a statement about $f$ at *all* large arguments, not just at $3$. The naive hypothesis doesn't provide it. So Tao proves instead:

> **Lemma 3.1.** $f(m)\ge n$ for all $m\ge n$.

which is exactly the needed fact, uniformly in $n$. It is strictly stronger than $f(n)\ge n$ (Technique 10: specialize to $m=n$ and you recover the original goal).

**Why it works.** Counterintuitive but standard: a stronger statement gives you a stronger induction *hypothesis*, and the hypothesis is an asset. Asking for more in the conclusion means being given more in the assumption. In code terms: a recursive function with a richer return type can be easier to write, because the recursive call hands back more usable information.

**Failure mode.** Over-strengthening: if $S'$ is too strong it will be false, and you will burn time. The discipline is to strengthen by *exactly* the fact the step demanded — read the gap in your argument, and patch that.

---

## Technique 10: Specialize the general lemma back to the original goal

Having proved Lemma 3.1 ("$f(m)\ge n$ whenever $m\ge n$"), Tao writes (p. 38): "If we specialize Lemma 3.1 to the case $m=n$, we obtain our subgoal: $f(n)\ge n$." The generalization was instrumental; the specialization collects the payment. Worth stating as its own move because beginners often prove the general lemma and then forget to close the loop.

---

## Technique 11–13: Keep recombining new results with old data

**What it is.** After every new result, systematically feed it back into everything you already have.

**Tao's own words** (p. 38): "as with all functional equation questions, once we have a new result, we should just play around with it and try to recombine it with previous results. Our only previous result is (10), so we can put our new equation into (10)."

**Seen in action** (Problem 3.1, p. 38). Inventory: (10) $f(n+1)\ge f(f(n))+1$, and (11) $f(n)\ge n$. Substituting $n\mapsto f(n)$ in (11) gives $f(f(n))\ge f(n)$. Chain that into (10):
$$f(n+1) \;\ge\; f(f(n))+1 \;\ge\; f(n)+1,$$
i.e. $f(n+1)>f(n)$.

**The filtering half of the technique (Technique 59).** Tao does not present this as "combine and win". His sentence is: "**The only useful result we get** is $f(n+1)\ge f(f(n))+1\ge f(n)+1$." The word *only* is doing real work — it tells you that he generated several combinations of (10) and (11) and most of them were true but inert. (For instance: substituting (11) into itself gives $f(f(n))\ge f(n)\ge n$, which is no stronger than what you had; and using (11) to bound the left side of (10) rather than the right gives $f(n+1)\ge n+1$, which is just (11) again.) So the routine has two halves — generate exhaustively, then *discard by resemblance to the goal* (Technique 5). Expect a low hit rate and do not be discouraged by it.

**Why it works.** With only two facts on the table the combination space is tiny — you can be exhaustive. This is why Tao likes these problems pedagogically ("pocket mathematics"). It also demonstrates that you should treat your *derived* results as first-class data, not as one-off milestones.

---

## Technique 14: Upgrade a computation into a structural property, then use it to cancel

**What it is.** The single most beautiful move in the chapter. A pointwise inequality, once recognized as *monotonicity*, becomes a licence to strip $f$ off both sides of any inequality.

**Tao's own words** (p. 38): "This is a very useful formula: this means that $f$ is an increasing function! (not obvious from (10), is it?) This means that $f(m)>f(n)$ if and only if $m>n$."

**Seen in action.** $f(n+1)>f(n)$ for all $n$ means $f$ is strictly increasing. For a strictly increasing function the order comparison is *reversible*: $f(m)>f(n) \Leftrightarrow m>n$. So the original hypothesis
$$f(n+1)>f(f(n))$$
— which compares $f$ at $n+1$ with $f$ at $f(n)$ — collapses to a comparison of the *arguments*:
$$n+1>f(n).$$
All the function symbols on the right disappear. Combined with $f(n)\ge n$ from (11), we get $n\le f(n)<n+1$, so $f(n)=n$. Done.

**Why it works.** The "if and only if" is doing the work. A merely increasing (non-strict) function gives one direction only. Being able to run the implication backwards is what turns a statement *about $f$'s values* into a statement *about $f$'s inputs*, which is a completely different and much simpler kind of statement.

**Generalizable form:** whenever you can prove your unknown function is injective, monotone, positive, multiplicative, or continuous, stop and ask what that structural property lets you *cancel*.

---

## Technique 15–17: Squeezing

Three related moves, all about trapping a quantity.

**15. Two-sided squeeze.** Your goal is an equality; your data are inequalities. Prove $\ge$ and $\le$ separately. Problem 3.1 ends exactly this way: $f(n)\ge n$ (from Lemma 3.1) plus $f(n)<n+1$ (from monotonicity) forces $f(n)=n$.

**16. Integer squeeze — "there is no room".** If an integer is strictly between $k$ and $k+2$, it *is* $k+1$. Problem 3.2 uses this twice:
- $f(2)<f(3)<f(4)$ with $f(2)=2$, $f(4)=4$ gives $2<f(3)<4$, so $f(3)=3$ (p. 39).
- In Lemma 3.2's odd case, $2n<f(m)<2n+2$ gives $f(m)=2n+1$ (p. 40).

Tao then draws the moral explicitly (p. 40): "$f(3)$ was 3 only because it was an integer (see how this is similar to the previous question, $f(n+1)>f(f(n))$?). Without this restriction, $f(3)$ could have been 2.1, or 3.5, or whatever. Let us see if we can use this clue more often." Two techniques in one sentence — the integrality clue (Technique 2 again, in its other guise) and the deliberate decision to *reuse a clue that just worked* (Technique 24).

**17. Manufacture the missing bound.** A squeeze needs both walls. To pin $f(5)$ Tao writes $f(4)<f(5)<f(6)$ — but he doesn't have $f(6)$. He gets it from a *different* axiom: "Never fear: 6 is 2 times 3, so $f(6)=f(2)f(3)=2\times3=6$" (p. 40). The lesson: when a squeeze is missing a wall, look at your other hypotheses and *build* the wall rather than abandoning the squeeze.

---

## Technique 18–21: Reshaping the question itself

Four moves Tao makes at the *start* of Problem 3.2, before any algebra. They are the chapter's clearest demonstration that choosing what to prove is part of the work.

**18. Generalize: compute everything, not just what was asked.** p. 39: "Now we have to find out a particular value of $f$. The best way is to try to evaluate all of $f$, not just $f(1983)$." A general answer is often *easier* than a specific one, because a general claim can be attacked by induction while "$f(1983)=?$" cannot.

**19. Mine the statement itself.** Two distinct inferences on p. 39:
- The question says "Find $f(1983)$", which *presupposes* the answer is unique — "implicit in the question is the fact that there is only one possible value of $f(1983)$ (otherwise there would be more than one answer)."
- And 1983 is not special: "because of the ordinariness of 1983 we might reasonably conjecture that there is only one solution to $f$." (He also deflates the number: "1983 is just the year of the question anyway.") Big arbitrary-looking constants in competition problems are usually decoration; treat them as a generic $n$.

This is reading the *pragmatics* of the problem, not just its content. It's not a proof step — it's a licence to conjecture uniqueness, which then tells you what to try to prove.

**20. Guess, verify, then reduce "find" to "prove unique".** p. 39: from $f(2)=2$ and multiplicativity, $f(4)=f(2)f(2)=4$, $f(8)=f(4)f(2)=8$, and "an easy induction shows that $f(2^n)=2^n$". Pattern: perhaps $f(x)=x$. Now *check the guess against all three hypotheses* — the identity function does satisfy (a), (b), (c). So a solution exists; the remaining work is uniqueness. This converts an open-ended search problem into a closed verification problem.

**21. Prove the more general but clearer statement.** p. 39, boxed in the book:

> "The only function from the positive integers to the integers satisfying (a), (b), and (c) is the identity function (i.e. $f(n)=n$ for all $n$)."

Tao's justification: "So we might want to prove the more general, but clearer question." *Clearer* is the operative word — the generalization is easier to think about, not merely stronger.

---

## Technique 22: Bootstrap from generators, and climb through number systems

**What it is.** Data that pins your function on a small generating set extends, via the function's structural law, to the whole domain.

**Seen in action.**
- Problem 3.2: $f(2)=2$ + multiplicativity $\Rightarrow$ $f$ known on all powers of 2 (p. 39); then multiplicativity plus monotonicity fills in everything else.
- Exercise 3.1's hint (p. 36): "first prove this for integer $x$, then for rational $x$, then finally for real $x$." Integers come from iterating the additive law; rationals come from integers by division; reals come from rationals by *continuity* — which is precisely why continuity was listed among the hypotheses (9). That hypothesis was not decoration either.
- Exercise 3.3's hint (p. 41): once real values are allowed, compare $f(2^n)$ with $f(3^m)$ — i.e. use two *different* multiplicative generating sequences and interleave them. This replaces the lost integer-squeeze with an approximation argument.

**Why it works.** It is the mathematical version of "define the function on a basis and extend by linearity" — or, in code, of defining a recursive function on constructors and getting the whole datatype for free.

---

## Technique 23: Case split by parity inside an induction

In Lemma 3.2 (p. 40) Tao writes: "Looking at a few examples we will soon see that we have to divide into cases: $m$ even and $m$ odd." The reason is that different hypotheses are available in each branch:
- **$m$ even**, $m=2n$: multiplicativity applies directly. $f(m)=f(2)f(n)=2n=m$.
- **$m$ odd**, $m=2n+1$: multiplicativity is useless (an odd number isn't $2\times$ anything), so use monotonicity to sandwich $f(m)$ between $f(2n)$ and $f(2n+2)$, both computable by multiplicativity.

The generalizable point: split into cases along the line that separates "which of my hypotheses applies". Not along an arbitrary line.

---

## Technique 24: Notice cross-problem analogies

Small but repeated. p. 40: "see how this is similar to the previous question, $f(n+1)>f(f(n))$?" Both problems ultimately turn on the same pivot — an integer trapped in an interval too small to contain another integer. Tao then says "Let us see if we can use this clue more often", and does. Keeping a mental index of *why* your last problem worked is what makes the next one fast.

---

## Technique 25: Build the toolkit before entering the domain

Between Exercise 3.4 and Problem 3.3, Tao stops for two full pages (pp. 41–43). His announcement of the pause is worth quoting because it is the technique stated as a policy: "Many algebra questions concern polynomials of one or more variables, so **let us pause for a bit to recall some definitions and results** concerning these polynomials." He then recites, in order: the definitions (one variable, several variables, degree, quadratic/cubic, trivial/constant, homogeneous and its scaling law, factored/factors, irreducible, roots), and then five facts —

1. degree adds under multiplication ("it is easily proven");
2. a one-variable polynomial has at most as many roots as its degree, and exactly that many counting multiplicity and complex roots;
3. the root formulas: quadratic formula explicitly, cubic and quartic "much messier and not very useful in practice", quintic and beyond "there is no elementary formula at all!";
4. roots of a factor are a subset of the roots of the whole — offered with its use case, "in deciding whether one polynomial divides another" — and the factor theorem, $x-a \mid f(x)$ iff $f(a)=0$;
5. the corollary $x-t \mid f(x)-f(t)$ for any $t$.

Then, simply: "Now let us tackle some questions involving polynomials."

Facts 1, 2 and 4 all get used in Problem 3.4; fact 5 is the entire content of Exercise 3.8; fact 3 is used *negatively* — it is why nobody in this chapter ever tries to solve for a root (Problem 3.3 mentions the quadratic formula only to avoid it), and therefore why the whole section works through factoring and counting instead. So even the fact that looks like background trivia is load-bearing: it tells you which door is locked.

The lesson is not "memorize polynomial facts" — it is that a deliberate inventory of the domain's cheap facts is a *prerequisite step*, because you cannot reach for a tool you have not laid out. In Chapter 1's language, this is "understand the data" applied at the level of a whole subject. Note also that the inventory is written *before* he knows which problems he will pose, so it is not retro-fitted; it is genuinely "everything cheap I know about polynomials."

---

## Technique 26: Try the direct approach, then formally declare it dead

Tao *always* tries the obvious thing first, and always announces when it fails. Problem 3.3, p. 43: "an initial attempt to deduce the second equation from the first may be to raise both sides of (12) to the fifth power, which gets something similar to the desired result, but with a whole lot of messy terms on the left-hand side. There seems to be no other obvious manipulation. **So much for the direct approach.**"

Note the two sentences that bracket the attempt. Before it, p. 43: "**At first this question looks simple.** There is really only one piece of information given, so there should be a straightforward sequence of logical steps leading to the result we want." After it: "There seems to be no other obvious manipulation. So much for the direct approach." So the direct attempt is not a random flail — it is the prediction that scarcity of data implies a short path (Technique 56), tested and found wanting.

Why this matters as technique: (i) sometimes the direct approach works and you've saved yourself cleverness; (ii) when it fails, *how* it fails tells you what the real difficulty is (here: cross-terms — so you need something that kills cross-terms, which is what the factorization ultimately does); (iii) explicitly closing the branch stops you from drifting back into it.

**And it can die twice (Technique 64).** This is easy to miss and is one of the more honest moments in the chapter. Having simplified (12) into the reciprocal-free (14), Tao does *not* assume the simplification has fixed anything — he re-tries the direct route on the new form and reports (p. 44): "Since (14) is equivalent to (12), and is algebraically simpler ((14) contains no reciprocals), we could try to deduce (13) from (14). **Again, the direct approach is not feasible.**" Only *then* does he enumerate the indirect options. The habit: after any reformulation, re-run the cheap attack before reaching for the expensive one — and if it fails again, say so, so that "I already tried that on both forms" is on the record.

---

## Technique 27: Treat suspicion as a signal — a fishy hypothesis is a strong hypothesis

**Tao's own words** (p. 43): "On second glance, the first equation looks suspect, like one of the equations that high-school students are warned not to use because they are usually fallacious. This gives us our first real clue: the first equation should restrict $a$, $b$, and $c$ quite a bit. It may be worth reinterpreting the equation (12)."

The hypothesis of Problem 3.3 is $\frac1a+\frac1b+\frac1c=\frac{1}{a+b+c}$, which looks like the classic student error "$\frac1a+\frac1b=\frac{1}{a+b}$". Tao's inference: an equation that is *almost never* true is a very informative constraint. Rather than treating the weirdness as an obstacle, he treats it as a promise that $a,b,c$ are heavily restricted — which turns out to be exactly right (they satisfy $(a+b)(b+c)(c+a)=0$, a codimension-1 condition, essentially "two of them are negatives of each other").

Generalizable: measure how *rarely* your hypothesis holds. The rarer, the more it tells you, and the more aggressively you should try to characterize its solution set completely.

---

## Technique 28: Normalize the data into its simplest equivalent form

Before doing anything clever, put your hypothesis into the cleanest algebraic shape. In Problem 3.3, combine reciprocals over a common denominator and cross-multiply:
$$\frac{ab+bc+ca}{abc}=\frac{1}{a+b+c} \quad\Longrightarrow\quad ab^2+a^2b+a^2c+ac^2+b^2c+bc^2+3abc=abc. \tag{14}$$
Tao's justification (p. 44): "Since (14) is equivalent to (12), and is algebraically simpler ((14) contains no reciprocals), we could try to deduce (13) from (14)."

Two things to note. First, he certifies *equivalence* — no information lost, so he can work with (14) instead of (12) freely. Second, "simpler" has an operational meaning here: no reciprocals means it is a polynomial, which means the entire polynomial toolkit from §3.2 becomes applicable. Normalizing isn't cosmetic; it moves the problem into a domain where you have tools.

---

## Technique 29: Screen candidate tools against your hypotheses before using them

p. 43–44: "At this point one may think of the various inequalities one could use here: Cauchy-Schwarz, arithmetic mean-geometric mean, etc. (Hardy 1975, pp. 33–34). That would not be so bad if $a$, $b$, and $c$ were constrained to be positive, but there is no such constraint: in fact the condition cannot hold if $a$, $b$, and $c$ are positive as $1/(a+b+c)$ would then be smaller than all three reciprocals on the left-hand side of (12)."

(The parenthetical citation is Hardy, Littlewood and Pólya's *Inequalities* — the standard reference. Tao gives you the page numbers *at the moment he decides not to use the tools*, which is a small piece of good practice in itself: record where the tool lives even when you reject it, so that the rejection is a filed decision rather than a forgotten one.)

Unpack that little argument, because it is a technique in itself. If $a,b,c>0$ then $a+b+c>a$, so $\frac{1}{a+b+c}<\frac1a$. Same for $b$ and $c$. So the right side of (12) is smaller than *each* of the three positive terms on the left, hence certainly smaller than their sum. Contradiction. Concretely with $a=b=c=1$: left side $=3$, right side $=1/3$. So positivity is not just unavailable — it is *impossible*.

Two lessons: (i) check a tool's hypotheses before investing in it; (ii) when you notice a hypothesis is missing, spend thirty seconds seeing whether it is actually *false*, because that itself is information about your object.

---

## Technique 30–33: How to get one equation out of another

**30. The taxonomy.** p. 44: "Usually the only other way to deduce an equation from some others are by proving an intermediate result, or by doing some useful substitution." Having killed the direct approach, Tao enumerates the remaining categories rather than casting about. Enumerate your options; there are usually few.

**30a. Guessing is officially part of the method (Technique 66).** Tao's transition sentence is "So we will try to **guess and prove** an intermediate result." Not *derive* — guess, then prove. The two-step licence matters: you are permitted to write down a lemma you have no derivation for, provided you then discharge it. In this problem the guessed lemma is the factorization, and the "prove" half is the factor-theorem check. Compare Problem 3.2, where the guessed object was the identity function and the "prove" half was verification against (a),(b),(c). Guess-then-verify is the same shape at both scales.

**31. Prefer a parameterization.** "The best kind of intermediate result is a parameterization, as this can be substituted directly into the desired equation." A parameterization describes the *entire* solution set of your hypothesis explicitly, so you can plug it into the goal and just compute. It is the strongest possible form of intermediate result. Tao also tells you the standard *way* to get one: "One way of parameterizing is to solve for one of the variables, say $a$" — i.e. express the solution set as "$b,c$ free, $a$ determined by them".

**32. Easy options before exotic ones.** In a parenthetical: "(There are more exotic alternatives, like considering (12) as a contour of the function $(1/a)+(1/b)+(1/c)-(1/a+b+c)$ and then using calculus to find the shape and properties of that contour, but it is best to stick with the easy options first.)" Note he *does* mention the exotic option — it is on the menu, just not first. This mirrors Chapter 1's "stick with the simple options first."

**33. Solve for a variable in whichever form is easiest.** p. 44: "The equation (14) will not solve for $a$ easily (unless you are willing to use the quadratic formula). The equation (12) *does* solve for $a$." So the simplification in Technique 28 was not monotone progress — the *original* form is better for one purpose and the normalized form better for another. Keep both. (Tao notes this route does work and yields an equivalent answer, then chooses a different one for variety: "which incidentally is equivalent to the result I will give below. But it would have to be, would not it?")

---

## Technique 34–39: The polynomial-factorization playbook

This cluster is the heart of §3.2.

**34. Recast a constraint as "roots of a polynomial", then factorize.** p. 44: "Failing a parameterization, one could simply recast (14) into a better form. Solutions of (14) are essentially the roots of the polynomial $a^2b+b^2a+b^2c+c^2b+c^2a+a^2c+2abc$. **The best way to deal with roots of polynomials is to factorize the polynomial (and vice versa).**" (The $2abc$ comes from moving the right-hand $abc$ of (14) across, turning $3abc$ into $2abc$.) The mental shift is from "an equation my variables satisfy" to "a geometric object — the zero set of a cubic — that my variables lie on".

**35. Guess factors from structure.** Three structural constraints, each pruning the search (p. 44):
- "The polynomial is homogeneous, so its factors should be too." (All terms have degree 3; so each factor must have all its terms of one degree.)
- "The polynomial is symmetric, so the factors should be symmetries of each other." (Swapping any two of $a,b,c$ leaves the polynomial unchanged, so the *set* of factors must be preserved by such swaps — if $a+b$ is a factor, so are $b+c$ and $c+a$.)
- "The polynomial is cubic, so there should be a linear factor." (Degrees add to 3; the only partitions are $3=1+1+1$ or $3=1+2$ — either way there is a factor of degree 1.)

**35a. Structure narrows; experiment chooses (Technique 65).** The sentence that introduces the three structural constraints is: "What are the factors? … But to find out what they are, **we have to experiment.**" Tao is explicit that homogeneity, symmetry and degree do not hand you the answer — they hand you a short list, and you then test the list one entry at a time. Worth internalizing because it licenses trial-and-error as a *named step* rather than something you do guiltily when the clever idea fails to arrive. The discipline is only that the trials must be cheap (one substitution each, per Technique 38) and ordered (Technique 36).

**36. Nice candidates first.** "We should now try factors of the form $a+b$, $a-b$, $a$, $a+b+c$, $a+b-c$, and so on. (Things like $a+2b$ might also work, but are not as 'nice' and in any case can be tried afterwards.)" An explicitly ordered search: symmetric, small-coefficient candidates before asymmetric or large-coefficient ones.

Worth noticing what each rejected candidate would have cost and why it is on the list at all: $a$ alone is on the list because a monomial factor is the cheapest possible thing to check (it divides the cubic iff every term contains $a$ — visibly false here, since $b^2c$ does not); $a+b+c$ is there because it is the *most* symmetric linear form (and it is the one that wins in Exercise 3.5); $a-b$ and $a+b-c$ are the sign-variants you try once the all-plus versions fail. The list is generated by a rule — *linear forms with coefficients in $\{0,\pm1\}$, most symmetric first* — not by inspiration.

**37. Reason backwards from the target.** "Because we know that (14) must somehow imply (13), we should be pretty confident that there is some workable form of (14) that will lead to [the goal], and the only workable form of a polynomial is a breakup into factors." That is: *the problem promises the implication, therefore a usable rewriting must exist, therefore keep looking for it.* Trusting the problem setter is a legitimate source of confidence when deciding how long to persist. (Note: the printed text here reads "will lead to $5ab$", both in this sentence and at the end of the solution. In context this appears to be a typesetting error for the target equation "(13)"; the argument is unaffected.)

**38. Factor theorem as the test.** "It is soon apparent (from the factor theorem) that $a+b$, and similarly $b+c$ and $c+a$ are roots of the cubic." I.e. substituting $b=-a$ into the cubic gives zero, so $(a+b)$ divides it. Check by hand: with $b=-a$, the cubic $a^2b+ab^2+b^2c+bc^2+c^2a+a^2c+2abc$ becomes $-a^3+a^3+a^2c-ac^2+c^2a+a^2c-2a^2c=0$. ✓

**39. Case analysis on a factored condition.** Once you know the hypothesis is equivalent to $(a+b)(b+c)(c+a)=0$, a product of three things being zero means at least one of them is zero. Handle each case.

---

## Technique 40–52: The Problem 3.4 machinery

Tao introduces Problem 3.4 with (p. 45): "The following question is instructive because it uses just about every trick in the book to find a solution." Treat this problem as the chapter's capstone; the moves are listed individually in the table above and narrated in the worked-problem section below. The headline ones:

- **40. Contradiction on a factorization.** To prove something cannot be factored, assume it can and derive nonsense.
- **41. Plug in the values that kill factors.** "Well the nicest factor one can have is 0, because that makes the entire expression 0." With the important caveat Tao adds in parentheses: "(Actually, there are also occasions where having a 0 factor is the last thing one wants to have, because one may wish to cancel this factor.)" — the same feature is an asset or a liability depending on the goal.
- **42. Escalate real information to integer information.** $p(a_i)q(a_i)=1$ says nothing much over the reals ($2\times\frac12$ works). Over the integers, the only factorizations of $1$ are $1\times1$ and $(-1)\times(-1)$. Tao is explicit that the integrality of both the coefficients *and* the $a_i$ is what makes $p(a_i)$ an integer at all. **Trigger to remember: a product of integers equal to a small number gives you a finite, short list of cases.**
- **43. Degrees of freedom versus constraints.** "each polynomial is 'pegged' by $n$ points. But polynomials only have as many degrees of freedom as their degree." Then a pigeonhole on degree: $\deg p+\deg q=2n$, so at least one of them has degree $\le n$.
- **44. No roots means no sign change.** "What does it mean when a polynomial has no roots? It means that it never crosses 0, that is, it never changes sign." (This is the intermediate value theorem in disguise: a continuous function that changes sign must pass through zero. Concretely: if $p(1)<0<p(2)$ then somewhere between 1 and 2 the graph must cross the axis, so $p$ has a root there.)
  - **44a. Say which arena you are in (Technique 69).** Tao's answer to "What are the roots of $f$?" is "There are none! **(Well, none on the real line, at least.)**" That parenthetical is not pedantry: over the complex numbers $f$ has exactly $2n$ roots (every degree-$d$ polynomial does), so the sentence "$f$ has no roots" is *false* unless you say where you are looking. The whole sign argument that follows — "never crosses 0, never changes sign" — is a statement about the real line, because "sign" and "crossing" are real notions; $\mathbb{C}$ is not ordered. Habit to steal: whenever you assert "no solutions", finish the sentence with "…over $\mathbb{R}$" / "…in the integers". Many false proofs are exactly this sentence left unfinished.
- **45. WLOG with an actual conversion.** "if we have one factorization $f(x)=p(x)q(x)$, we automatically have another factorization $f(x)=(-p(x))(-q(x))$. So if $p$ is always negative, we can always flip the factorization." Tao frames the move by its *economics* first (Technique 70): "This gives us two cases, but we can save a little bit of work by observing that one case implies the other." So WLOG is not primarily a logical nicety, it is a labour cut, and the honest thing to do is name the size of the cut ("a little bit of work") rather than pretend the second case was hard.
- **46. Shift to make it a root statement.** "$p(x)$ and $q(x)$ are forced to take on the value of $+1$ at least $n$ times. This can be rephrased in terms of roots, as follows: $p(x)-1$ and $q(x)-1$ have at least $n$ roots." Root counting is the only quantitative tool available for polynomials, so *convert every value statement into a root statement.*
- **47–48. Reconstruct from roots, then read off integrality.** Knowing all $n$ roots and that the degree is exactly $n$ determines the polynomial up to a constant: $p(x)-1=r\prod(x-a_i)$. And $r$ is the leading coefficient of an integer polynomial, hence an integer.
- **49–50. Compare coefficients, then find the absurdity.** "This equation compares two explicitly defined polynomials. The best thing to do now is to compare coefficients." Two polynomials are equal as functions iff all coefficients match — an infinite family of equations from one identity. And when you reach $2\prod(x-a_i)=0$: "which is ridiculous (it must hold for all $x$)". A polynomial identity with a free variable must hold for *every* value; one counterexample kills it.
- **51. Symmetric case reduction.** "The case $r=s=-1$ is similar, and we are done."
- **51a. Hedge where your knowledge is partial (Technique 71).** When Tao summarizes the $\pm1$ result he writes: "We have found, **more or less**, the value of $p(a_0),\ldots,p(a_n)$ and $q(a_0),\ldots,q(a_n)$." The hedge "more or less" is the audit trail for the sign ambiguity — he has *not* found the values, he has found each of them up to sign. Writing "we have found the values" would have been the first step of a wrong proof. Small verbal discipline, large payoff: let the precision of your prose track the precision of your knowledge.
- **52. Bookkeeping.** Two habits worth stealing. (i) Periodic inventory: "To sum up what we know so far: We have assumed that $f(x)=p(x)q(x)$. $p$ and $q$ are both positive integer polynomials of degree $n$, and $p(a_i)=q(a_i)=1$…". (ii) Notational vigilance: "One should be a little careful with the $\pm$ notation here; we know that $p(a_1)$ and $q(a_1)$, for instance, are equal to each other, but $p(a_1)$ and $p(a_2)$ could have the same sign or the opposite sign, for all we know right now." Sloppy $\pm$ notation is one of the most common sources of false proofs.

---

## Technique 53: The zero-product principle

From Exercise 3.4's hint (p. 41): "The first condition involves products of values of the function, and the other two conditions involve a function having a value of zero (or non-zero). Now, what can one say when a product equals 0?" Answer: at least one factor is 0. This is the entire strategy for that exercise. The technique on display is *matching the shape of your hypotheses to a principle*: products + zeros $\Rightarrow$ zero-product principle. Tao is teaching hypothesis-shape pattern matching.

---

## Technique 54–55: Two meta-techniques from the exercises

**54. Robustness testing.** Exercises 3.2 and 3.3 both say "show that Problem 3.2 can still be solved if…" — first with $f(2)=2$ weakened to "$f(n)=n$ for at least one $n\ge2$", then with integer values relaxed to real values. This is deliberately re-running your own proof against weakened hypotheses to find out which parts were load-bearing. It is unit testing for proofs, and it is how you discover that the *real* engine of Problem 3.2 was multiplicativity + monotonicity, with $f(2)=2$ serving only as a seed.

**55. Transfer is not guaranteed.** Exercise 3.7's parenthetical (pp. 47–48): the $p(x)-q(x)$ strategy "could also be applied to Problem 3.4, but turns out to be somewhat ineffective in that case." An honest warning: a trick that cracks one problem may merely make partial progress on a near-identical one. Keep several attacks per problem type.

---

## Technique 60–63: The micro-moves of the small-case phase

These four are one-sentence remarks scattered through pp. 37 and 40. Individually trivial; collectively they are most of what Tao actually *does* between "I have read the problem" and "here is a lemma", so they are worth isolating.

**60. Escalate a trivial bound by analogy with the level below.** On p. 37, the bound $f(3)\ge2$ came from "$f(\text{anything})\ge1$", the cheapest fact available. Tao's next thought is: "Earlier we said $f(f(1))$ was at least 1. Perhaps $f(f(2))$ is at least 2." The move is to look at the *shape* of the bound you just used and ask whether it has a stronger sibling one index up. He is not guessing at random — he is guessing along a pattern he has already instantiated once. This is how you generate a subgoal when you have no idea what to prove next: take the last thing you proved, add one to it, and see whether it is provable.

**61. Deliberately replay the move that just worked.** Two instances, both on p. 40. First, immediately after $f(3)=3$ falls to the integer squeeze: "This gives us a clue: $f(3)$ was 3 only because it was an integer… **Let us see if we can use this clue more often.**" Second, when starting on $f(5)$: "Using (c) **in the hope of doing what we did to $f(3)$**, we get $f(4)<f(5)<f(6)$." Note the phrasing — the hypothesis is chosen *because* of which tactic he wants to reach, not the other way round. The generalizable habit is to maintain a one-item cache: after a case falls, write down the mechanism that felled it, and try that mechanism first on the next case. When it *nearly* works (here: no $f(6)$ in hand), repair the gap rather than switching mechanisms (Technique 17).

**62. Track and announce your progress.** "This seems to be going well; we have now worked out all the values of $f(n)$ up to $n=6$" (p. 40). Two functions. As a *decision signal*: "up to $n=6$ with no exceptions and no extra ideas needed" is evidence that the pattern is real and the induction will close, which is what justifies stopping the exploration and writing the lemma. As an *error check*: stating the scope of what you have ("up to 6", not "in general") keeps you from quietly promoting a finite check into a theorem.

**63. Name the difficulty before you walk into it.** p. 37: "**The induction is just a little tricky though.** Consider the next case…". Tao flags that the induction will not go through naively *before* attempting it, and then spends a paragraph showing exactly where it breaks. The value of the announcement is that it converts "my proof failed" into "here is the specific obstruction I predicted", and an obstruction with a location is a thing you can patch (which is precisely what Technique 9 then does). Contrast the beginner behaviour of trying the induction, watching it fail, and concluding the *conjecture* is wrong.

---

## Technique 68: Does the problem promise that an answer exists?

A one-word observation with real consequences. Compare the two "find" problems in this chapter:

- **Problem 3.2** (p. 38): "**Find** $f(1983)$ (with reasons, of course)." This wording promises that a value exists and is unique — Tao mines exactly that (Technique 19).
- **Exercise 3.4** (p. 41): "**Find all (if any)** functions $f$ taking the non-negative reals onto the non-negative reals, such that…" The parenthetical "(if any)" withdraws the promise. The problem is explicitly telling you that the answer may be "no such function exists", so you may *not* run the Problem 3.2 manoeuvre of guessing a solution and then proving uniqueness — you have to establish existence yourself, or discover the contradiction.

So before you decide on a strategy, read the quantifiers in the question and note which of {existence, uniqueness} the wording gives you for free. "Find $X$" gives you both. "Find all" gives you neither, but tells you the answer set may have several elements. "Find all (if any)" gives you neither and warns that it may have none. "Show that there is exactly one…" gives you a target but no gift.

(Two other pieces of wording worth reading closely in Exercise 3.4: "taking the non-negative reals **onto** the non-negative reals" — Tao's phrasing, which if read strictly asserts surjectivity, though the intended and standard reading of the IMO problem is simply that $f$ is defined on $[0,\infty)$ and takes values in $[0,\infty)$; and the difficulty marker $(**)$, the chapter's hardest, shared only with Problem 3.4.)

---

# Worked problems

### Exercise 3.1 — Find every continuous $f:\mathbb{R}\to\mathbb{R}$ with $f(0)=1$ and $f(m+n+1)=f(m)+f(n)$ for all reals $m,n$ (p. 36)

**The data / the objective.** Three facts: continuity, one value, one functional equation (together labelled (9) in the book). Objective: show $f(x)=1+x$ is the only possibility.

**Note that Tao gives the answer away in the running text before posing the exercise** (p. 36): "For example in this case, there is exactly one function $f$ that obeys the above properties, namely $f(x)=1+x$; we would leave this as an exercise." He also uses (9) as his illustration of what "the lowest form of analysis" looks like, and later cites this exercise as the *standard*, easier type against which Problem 3.1 is anomalous ("Other problems of this type (such as Exercise 3.1) involve functional *equations*, and are easier to handle…"). So this exercise is the chapter's calibration point: solve it and you know what "normal" feels like, which is what makes Problem 3.1's abnormality visible.

**The chain of moves** (Tao states the answer and gives only the three-stage hint; the sketch below follows that hint).
1. `[read the data]` Notice the hypotheses are of three different *kinds*: a value (algebraic), an identity (algebraic), and continuity (analytic). Continuity is the odd one out, so it is presumably needed only at the very end.
2. `[substitute pertinent values]` Set $m=n=0$: $f(1)=f(0)+f(0)=2$. Set $n=0$: $f(m+1)=f(m)+1$ — a recurrence. That plus $f(0)=1$ gives $f(k)=1+k$ for all non-negative integers $k$ by induction, and running the recurrence backwards gives it for negative integers too.
3. `[bootstrap through number systems]` Integers $\to$ rationals: the equation lets you split a rational into equal pieces (e.g. from $f(m+n+1)=f(m)+f(n)$ you can relate $f$ at $x$ and at $x/q$), yielding $f(x)=1+x$ for every rational $x$.
4. `[use the analytic hypothesis last]` Rationals $\to$ reals: two continuous functions agreeing on all rationals agree everywhere, because every real is a limit of rationals and continuity commutes with limits. So $f(x)=1+x$ for all real $x$.

**Transferable lesson.** Sort your hypotheses by type and spend the algebraic ones first, the analytic ones last. Continuity is the tool that upgrades "true on a dense set" to "true everywhere" — and if a problem hands you continuity, that is almost certainly the job it is there to do.

---

### Problem 3.1 — $f$ maps positive integers to positive integers and satisfies $f(n+1)>f(f(n))$ for every $n$. Prove $f(n)=n$ for all $n$. (Greitzer 1978; pp. 36–38, difficulty $*$)

**The data / the objective.** One inequality, holding for all positive $n$, plus the domain/codomain restriction. Objective: an exact identity. Tao's framing of the difficulty: "This equation looks insufficient to prove what we want. After all, how can an inequality prove an equality?"

**The chain of moves.**
1. `[read the fine print]` Compare with the standard type. Usual functional-equation problems give an *equation* over the *reals*, where you substitute and manipulate. Here it's an *inequality* over the *integers*. So the standard machinery is unavailable — and the integrality is the compensating gift.
2. `[integrality upgrade]` Rewrite $f(n+1)>f(f(n))$ as (10): $f(n+1)\ge f(f(n))+1$. Free, and now there is arithmetic to do.
3. `[substitute pertinent values: n=1]` $f(2)\ge f(f(1))+1$. Tao's reading of this line is worth copying verbatim: "This does not tell us much about $f(2)$ or $f(1)$ **at first glance**, but the $+1$ on the right-hand side hints that the $f(2)$ cannot be too small." So: look at a formula that seems to say nothing, and ask which *piece* of it is informative — here the constant term, because it is the only thing that survives when you throw away all knowledge of $f$. Since $f$ lands in the positive integers, $f(f(1))\ge1$, so $f(2)\ge2$.
4. `[aim at the objective]` Tao notes this resembles the goal ($f(2)$ should be $2$), so "we may be on the right track" — and states the general rule about preferring goal-directed tactics.
5. `[repeat at n=2]` $f(3)\ge f(f(2))+1$. "By using the same argument as above, we can say that $f(3)$ is at least 2. **But can we say something stronger?**" Naively this only gives $f(3)\ge2$. Not enough.
6. `[escalate the trivial bound by analogy]` "Earlier we said $f(f(1))$ was at least 1. Perhaps $f(f(2))$ is at least 2." — the subgoal is generated by taking the bound he just used and shifting it up one index. `[expected answer as compass]` And he cross-checks the guess against what he expects the answer to be: we *believe* $f(f(2))=2$, but can't assume it, so $f(f(2))\ge2$ becomes a subgoal rather than a step.
7. `[substitute a derived expression, checking legality]` Apply (10) with $n=f(2)-1$, which is a legal input because $f(2)\ge2$ so $f(2)-1\ge1$. This gives $f(f(2))\ge f(f(f(2)-1))+1\ge 2$, and chaining:
   $$f(3)\ \ge\ f(f(2))+1\ \ge\ f(f(2)-1)+1+1\ \ge\ 3.$$
8. `[conjecture]` The pattern suggests $f(n)\ge n$ in general.
9. `[reeks of induction]` "Because we used the fact that $f(2)$ was at least 2 to prove that $f(3)$ was at least 3, the general proof reeks of induction."
10. `[name the difficulty first, then walk into it]` `[dead end — the naive induction stalls]` Tao announces the obstruction before meeting it: "**The induction is just a little tricky though.** Consider the next case, showing that $f(4)\ge4$." From (10), $f(4)\ge f(f(3))+1$, and we know $f(3)\ge3$. To conclude we need $f(f(3))\ge3$ — but the hypothesis "$f(3)\ge3$" says nothing about $f$ *at* the point $f(3)$, which could be any integer $\ge3$. **The induction hypothesis is too weak.** This is the crucial failure, and Tao displays it rather than hiding it. (The pre-announcement matters: because he expected trouble, the failure reads as a located obstruction rather than as evidence against the conjecture.)
11. `[strengthen the induction hypothesis]` Identify exactly the missing fact: "we would like to have in hand a fact of the form 'if $n\ge3$, then $f(n)\ge3$'." Then: "The easiest way to do that is to put that kind of fact into the induction we are trying to prove." Hence **Lemma 3.1: $f(m)\ge n$ for all $m\ge n$.**
12. `[ordinary induction on n]`
    - *Base $n=1$:* $f(m)$ is a positive integer, so $f(m)\ge1$. Trivially true for every $m$.
    - *Step:* assume $f(m)\ge n$ whenever $m\ge n$; prove $f(m)\ge n+1$ whenever $m\ge n+1$. Given such an $m$: by (10), $f(m)\ge f(f(m-1))+1$. Now $m-1\ge n$, so the hypothesis gives $f(m-1)\ge n$. Apply the hypothesis a *second time*, now at the point $f(m-1)$ (which is $\ge n$): $f(f(m-1))\ge n$. Therefore $f(m)\ge n+1$. ∎
    Notice the double application of the hypothesis — that is precisely what the stronger form made possible, and precisely what the weak form could not do.
13. `[specialize]` Set $m=n$: $f(n)\ge n$ for all $n$. This is equation (11).
14. `[recombine new with old, then filter]` Inventory is now (10) and (11) — "**our only previous result is (10)**, so we can put our new equation into (10)." Replacing $n$ by $f(n)$ in (11) gives $f(f(n))\ge f(n)$, hence
    $$f(n+1)\ \ge\ f(f(n))+1\ \ge\ f(n)+1,$$
    i.e. $f(n+1)>f(n)$. Tao's own label for this is "**the only useful result we get**" — several other combinations of (10) and (11) exist and are inert; the selection criterion is resemblance to the goal.
15. `[upgrade to a structural property]` So $f$ is strictly increasing — "not obvious from (10), is it?" Consequently $f(m)>f(n)$ **iff** $m>n$.
16. `[cancel f using monotonicity]` The original hypothesis $f(n+1)>f(f(n))$ compares $f$ at $n+1$ against $f$ at $f(n)$. By the biconditional, this is equivalent to comparing the arguments: $n+1>f(n)$.
17. `[two-sided squeeze]` $n\le f(n)<n+1$ with $f(n)$ an integer forces $f(n)=n$. ∎

**The resolution, in one breath.** Integrality turns the strict inequality into a $+1$ ladder; the ladder plus a *strengthened* induction gives the lower bound $f(n)\ge n$; feeding that lower bound back into the hypothesis reveals that $f$ is increasing; being increasing lets you delete $f$ from both sides of the hypothesis, which produces the matching upper bound $f(n)<n+1$; the two bounds meet.

**Transferable lessons.**
- An inequality *can* prove an equality — if the objects are discrete, or if you can get inequalities in both directions.
- When an induction stalls, do not look for a cleverer step; look at *what fact the step wanted* and put that fact into the statement being inducted.
- Derived facts are data. The moment you prove something, substitute it into everything you already have — including into itself.
- The highest-value single move is converting a numerical estimate into a structural property (here: monotonicity), because structural properties let you cancel and simplify in ways estimates cannot.

---

### Problem 3.2 — $f$ maps positive integers to integers, $f(2)=2$, $f(mn)=f(m)f(n)$, and $f$ is strictly increasing. Find $f(1983)$. (Australian Mathematics Competition 1984; pp. 38–40)

**The data / the objective.** Three hypotheses: (a) a single value, (b) multiplicativity, (c) strict monotonicity ($f(m)>f(n)$ if $m>n$). Objective as printed: one number. Objective as Tao reframes it: identify $f$ completely.

**The chain of moves.**
1. `[generalize the question]` "Now we have to find out a particular value of $f$. The best way is to try to evaluate all of $f$, not just $f(1983)$." And immediately, the honesty clause: "**This is, of course, assuming there is only one solution of $f$.**" The generalization is a bet, and he says so before placing it.
2. `[mine the statement]` A well-posed "Find X" implies X is unique — "implicit in the question is the fact that there is only one possible value of $f(1983)$ (otherwise there would be more than one answer)"; and 1983 is an ordinary number ("1983 is just the year of the question anyway"), so conjecture that $f$ itself is unique. Note the two-step inference: uniqueness of *the answer* is guaranteed by the wording; uniqueness of *the function* is a conjecture licensed by the answer's arbitrariness.
3. `[bootstrap from generators]` (b) repeatedly: $f(4)=f(2)f(2)=4$, $f(8)=f(4)f(2)=8$, and by induction $f(2^n)=2^n$.
4. `[guess and verify]` "So $f(x)=x$ when $x$ is a power of 2. **Perhaps $f(x)=x$ for all $x$.** Plugging this back into (a), (b), and (c) shows that this works: $f(x)=x$ is one solution of (a), (b), and (c). So, if we think that there is only one solution of $f$, then this one has to be it." So *a* solution exists; the remaining work is uniqueness. (The verification is not a formality — it is what converts a pattern spotted in a handful of powers of 2 into a candidate answer, and it is cheap: three substitutions.)
5. `[prove the more general, clearer statement]` Boxed claim: the only function from the positive integers to the integers satisfying (a), (b), (c) is the identity. Tao then translates the boxed claim into the concrete to-do list he will actually work through: "So we have to prove that if $f$ satisfies (a), (b), and (c), then $f(1)=1$, $f(2)=2$, $f(3)=3$, and so on." Unpacking a general statement into its first few instances is what makes step 6 possible.
6. `[small cases first]` "with functional equations we should try small examples first to get a 'feel' of the question."
7. **$f(1)$.** From (c), $f(1)<f(2)=2$. From (b) with $m=2,n=1$: $f(2)=f(1)f(2)$, i.e. $2=2f(1)$, so $f(1)=1$. (Two hypotheses used together; (c) alone would only bound it.)
8. **$f(3)$ — the pivotal case.** `[audit which hypotheses help]` (a) is silent. (b) "only gives $f(3)$ in terms of other numbers like $f(6)$ or $f(9)$, which is also of not much help" — a *dead end, named*. (c) gives $f(2)<f(3)<f(4)$, i.e. $2<f(3)<4$.
9. `[integer squeeze]` The only integer strictly between 2 and 4 is 3. So $f(3)=3$.
10. `[extract and reuse the clue]` "$f(3)$ was 3 only because it was an integer… Without this restriction, $f(3)$ could have been 2.1, or 3.5, or whatever. Let us see if we can use this clue more often." Plus the cross-problem analogy to Problem 3.1.
11. **$f(5)$.** `[deliberately replay the move that just worked]` "Using (c) **in the hope of doing what we did to $f(3)$**" gives $f(4)<f(5)<f(6)$. We have $f(4)=4$ but not $f(6)$. `[manufacture the missing bound]` "Never fear: 6 is 2 times 3, so $f(6)=f(2)f(3)=2\times3=6$." Hence $4<f(5)<6$, so $f(5)=5$.
11a. `[track progress]` "This seems to be going well; **we have now worked out all the values of $f(n)$ up to $n=6$.**" Stating the scope is both the evidence that the pattern is real and the guard against mistaking six checks for a theorem. (See the value table under Technique 4 for the full ledger and which hypothesis paid for each entry.)
12. `[smells of induction — and of the strong kind]` "Because we seem to be relying on past results to attain the new ones, the general proof smells heavily on induction. And because we are not just using one previous result, but several previous results, we probably need *strong* induction."
13. **Lemma 3.2: $f(n)=n$ for all $n$.** Base: $f(1)=1$, done. Step: fix $m\ge2$ and assume $f(n)=n$ for every $n<m$. `[case split by parity — along the line of which hypothesis applies]`
    - *$m$ even, $m=2n$.* Here $n<m$, so $f(n)=n$ by hypothesis, and by (b): $f(m)=f(2n)=f(2)f(n)=2n=m$. ✓
    - *$m$ odd, $m=2n+1$.* (b) is useless. By (c): $f(2n)<f(m)<f(2n+2)$. Both $2n$ and $n+1$ are less than $m$, so $f(2n)=2n$ and $f(n+1)=n+1$ by the strong hypothesis; then (b) gives $f(2n+2)=f(2)f(n+1)=2(n+1)=2n+2$. So $2n<f(m)<2n+2$, and integrality forces $f(m)=2n+1=m$. ✓ ∎
14. `[answer the literal question]` $f(1983)=1983$.

**Why the parity split is exactly right.** Multiplicativity gives you information about *composite* inputs by decomposing them; it says nothing about a number you cannot factor usefully. Monotonicity gives you information about a number from its *neighbours*. Even numbers are reachable by the first mechanism, odd numbers only by the second. The split follows the hypotheses, not the arithmetic.

**Transferable lessons.**
- Converting "find this one value" into "determine the whole object" usually makes the problem *easier*, because general claims are inductable.
- The presence of an answer is information. Uniqueness is often implicit in the wording.
- A guess that survives verification converts an existence question into a uniqueness question — a completely different and usually more tractable kind of proof.
- Case-split along the boundary between "which of my hypotheses bites here".
- Integrality is a resource; use it every time a quantity is trapped in an interval of length 2.

---

### Exercise 3.2 — Re-solve Problem 3.2 with (a) weakened to: $f(n)=n$ for at least one integer $n\ge2$ (p. 41)

**Objective.** Show the proof does not really need $f(2)=2$; any single fixed point $\ge2$ suffices.

**The chain of moves** `[robustness testing]` (sketch, following the structure of Problem 3.2 — the book gives no solution).
1. Let $N\ge2$ with $f(N)=N$. From (b) with $m=N,n=1$: $f(N)=f(1)f(N)$, so $f(1)=1$.
2. `[bootstrap from generators]` (b) gives $f(N^k)=f(N)^k=N^k$ for every $k$.
3. `[a "no room" counting argument]` (c) says $f$ is strictly increasing and integer-valued, so each step up increases $f$ by at least 1: $f(m+1)\ge f(m)+1$. Between $m=1$ and $m=N^k$ there are $N^k-1$ steps, and the total rise is $f(N^k)-f(1)=N^k-1$. Every step must therefore rise by *exactly* 1. Hence $f(m)=m$ for all $m\le N^k$.
4. Since $k$ was arbitrary and $N\ge2$, the numbers $N^k$ are unbounded, so $f(m)=m$ for every $m$.

**Transferable lesson.** A strictly increasing integer-valued function pinned at two points, with just enough total rise to cover the gap, has no slack at all. "Count the steps, count the total rise, compare" is a general discrete technique. And more broadly: when you finish a proof, ask which hypotheses were only *seeds* and which were *engines*. Here $f(2)=2$ was a seed; (b) and (c) were the engines.

---

### Exercise 3.3 — Re-solve Problem 3.2 allowing $f(n)$ to be a *real* number rather than an integer (p. 41, difficulty $*$)

**Hint given.** "first try to prove that $f(3)=3$, by comparing $f(2^n)$ with $f(3^m)$ for various integers $n,m$." Additional challenge: do it with (a) also weakened to (a′).

**Why this is harder.** Dropping integrality destroys the engine of Problem 3.2. The squeeze $2<f(3)<4$ no longer forces $f(3)=3$ — it permits $2.1$, $3.5$, anything. So the integer-squeeze must be replaced.

**The chain of moves** `[find the replacement mechanism]` (sketch; the book gives only the hint).
1. `[keep what survives]` (b) still gives $f(2^n)=2^n$ and $f(3^m)=f(3)^m$. Write $t=f(3)$.
2. `[use two generating sequences and interleave them]` Monotonicity (c) compares $f$ at $2^n$ and $3^m$ whenever we know how $2^n$ and $3^m$ compare. So: whenever $3^m<2^n$ we get $t^m<2^n$, and whenever $2^n<3^m$ we get $2^n<t^m$.
3. `[squeeze by approximation instead of by integrality]` Suppose $t>3$. Then $(t/3)^m\to\infty$, so for large $m$ the gap between $3^m$ and $t^m$ is huge, and one can choose $n$ with $3^m<2^n<t^m$. The first inequality forces $t^m<2^n$; the second says $2^n<t^m$. Contradiction. A symmetric argument rules out $t<3$. Hence $t=3$.
4. From $f(3)=3$ the earlier squeezes can be rerun; with enough multiplicative generators (powers of 2 and 3, then products) the values of $f$ are pinned densely enough that monotonicity forces $f(n)=n$ everywhere.

**Transferable lesson.** When you remove a hypothesis, identify precisely which step it powered, then find a *different* mechanism for that step. Here the replacement for "no integers between 2 and 4" is "powers of 2 and powers of 3 interleave arbitrarily finely" — an approximation/density argument standing in for a discreteness argument. This substitution (discrete rigidity $\to$ approximation) is one of the most common upgrades in analysis.

---

### Exercise 3.4 — Find all $f$ from the non-negative reals to the non-negative reals with (a) $f(xf(y))f(y)=f(x+y)$ for all $x,y\ge0$, (b) $f(2)=0$, (c) $f(x)\neq0$ for every $0\le x<2$ (IMO 1986 Q5; p. 41, difficulty $**$)

**The data / the objective.** One functional equation whose left side is a *product* of two function values, plus one place where $f$ vanishes and a guarantee that it vanishes nowhere earlier.

**Read the wording first** `[does the problem promise existence?]`. Tao's printed statement is "Find all **(if any)** functions $f$ taking the non-negative reals **onto** the non-negative reals, such that…". The "(if any)" explicitly withdraws the existence guarantee that Problem 3.2's "Find $f(1983)$" hands you for free — so the Problem 3.2 tactic (guess the answer, verify it, then prove uniqueness) is not available as a shortcut; you have to construct or refute. And "onto" is Tao's wording for the codomain; read strictly it asserts surjectivity, but the standard reading of IMO 1986 Q5 — and the one the solution below uses — is simply that $f$ is defined on $[0,\infty)$ with values in $[0,\infty)$. Difficulty $(**)$: joint hardest in the chapter with Problem 3.4.

**Tao's hint, and the technique it encodes.** "The first condition involves products of values of the function, and the other two conditions involve a function having a value of zero (or non-zero). Now, what can one say when a product equals 0?" — i.e. `[match hypothesis shape to a principle]` products + zeros $\Rightarrow$ **the zero-product principle**: if $AB=0$ then $A=0$ or $B=0$. Conditions (b) and (c) exist to tell you *exactly which* inputs make $f$ zero, so every appearance of a zero in the equation becomes a hard constraint on an argument.

**The chain of moves** (sketch; the book supplies only the hint).
1. `[substitute pertinent values: x=y=0]` $f(0\cdot f(0))f(0)=f(0)$, i.e. $f(0)^2=f(0)$, so $f(0)\in\{0,1\}$. By (c), $f(0)\neq0$, so $f(0)=1$.
2. `[substitute to exploit the known zero: y=2]` $f(xf(2))f(2)=f(x+2)$. Since $f(2)=0$, the left side is $0$, so $f(x+2)=0$ for every $x\ge0$: **$f$ vanishes on all of $[2,\infty)$.**
3. `[engineer a zero on the right, then apply the zero-product principle]` For $0\le y<2$ put $x=2-y\ge0$. Then $f((2-y)f(y))\,f(y)=f(2)=0$. By (c), $f(y)\neq0$, so the other factor must vanish: $f\big((2-y)f(y)\big)=0$. By step 2 combined with (c), $f$ vanishes exactly on $[2,\infty)$, so $(2-y)f(y)\ge2$, giving the lower bound $f(y)\ge\dfrac{2}{2-y}$.
4. `[close the squeeze by contradiction]` Suppose $f(y)>\frac{2}{2-y}$ for some $0\le y<2$. Put $x=2/f(y)$, which is $\ge0$ and satisfies $x<2-y$, so $x+y<2$ and therefore $f(x+y)\neq0$ by (c). But $xf(y)=2$, so the equation gives $f(x+y)=f(xf(y))f(y)=f(2)f(y)=0$. Contradiction.
5. `[conclude]` $f(y)=\dfrac{2}{2-y}$ for $0\le y<2$, and $f(y)=0$ for $y\ge2$. (Sanity check: $f(0)=1$ ✓, $f(2)=0$ ✓, $f>0$ on $[0,2)$ ✓.)

**Transferable lesson.** A hypothesis that says "$f$ is zero exactly here" turns every zero appearing in your manipulations into an *equation about arguments*. So look for substitutions that deliberately create zeros. And note the shape of step 4: to prove $A\le B$ when you already have $A\ge B$, assume $A>B$ and use the surplus to construct a specific input that violates a hypothesis.

---

### Problem 3.3 — If $a,b,c$ are reals with $\frac1a+\frac1b+\frac1c=\frac1{a+b+c}$ (all denominators non-zero), prove $\frac1{a^5}+\frac1{b^5}+\frac1{c^5}=\frac1{(a+b+c)^5}$ (Australian Mathematics Competition 1987; pp. 43–44)

**The data / the objective.** One equation, (12); one target, (13). Tao's framing: "**At first this question looks simple.** There is really only one piece of information given, so there should be a straightforward sequence of logical steps leading to the result we want." Read that as a prediction derived from Technique 56 (few data $\Rightarrow$ short path) — a prediction that the next paragraph falsifies. The value of making the prediction explicitly is that its failure is informative.

**The chain of moves.**
1. `[direct approach, then declared dead]` Raise both sides of (12) to the fifth power. You do get $\frac{1}{(a+b+c)^5}$ on the right, but the left becomes $(\frac1a+\frac1b+\frac1c)^5$ — the three desired fifth powers plus a swarm of cross-terms. "There seems to be no other obvious manipulation. So much for the direct approach."
2. `[suspicion as signal]` (12) "looks suspect, like one of the equations that high-school students are warned not to use because they are usually fallacious." Inference: it must restrict $a,b,c$ severely, so *characterize the restriction* rather than manipulate the equation.
3. `[normalize into the simplest equivalent form]` Common denominator, then cross-multiply:
   $$\frac{ab+bc+ca}{abc}=\frac{1}{a+b+c}\ \Longrightarrow\ ab^2+a^2b+a^2c+ac^2+b^2c+bc^2+3abc=abc.\tag{14}$$
   Reciprocal-free, hence a polynomial condition. And equivalent to (12), so nothing is lost.
4. `[screen and reject tools]` The classical inequalities (Cauchy–Schwarz, AM–GM; Tao points at Hardy 1975, pp. 33–34) would need $a,b,c>0$. Not given — and in fact impossible, since for positive $a,b,c$ we would have $\frac{1}{a+b+c}<\frac1a$ (and likewise for $b,c$), making the right side smaller than any one term on the left, let alone their sum. **Dead end, and instructively so: it tells us at least one of $a,b,c$ is negative.**
4a. `[re-test the direct approach on the new form — it dies a second time]` "Since (14) is equivalent to (12), and is algebraically simpler ((14) contains no reciprocals), we could try to deduce (13) from (14). **Again, the direct approach is not feasible.**" Simplifying did not open the direct route; only after this second closure does he go looking for indirect ones.
5. `[enumerate the remaining routes]` "Usually the only other way to deduce an equation from some others are by proving an intermediate result, or by doing some useful substitution." Exotic option (treat (12) as a *contour* — a level set — of the function $\frac1a+\frac1b+\frac1c-\frac1{a+b+c}$ and use calculus to find the shape and properties of that contour) noted and postponed: "it is best to stick with the easy options first." Two things about this parenthetical: he *does* put the exotic option on the record, so it is available if the easy ones fail; and the exotic option is a genuine method (studying the geometry of the solution surface), not a joke — it is deferred on cost grounds only.
6. `[reject substitution, with a reason]` "Substitutions do not seem appropriate: the equations (12) or (14) are simple enough as they are, and substitutions would not make them much simpler." Note the criterion — a substitution is worth making only if it simplifies; there is nothing to eliminate here.
7. `[guess and prove an intermediate result]` "So we will try to **guess and prove** an intermediate result. The best kind of intermediate result is a parameterization, as this can be substituted directly into the desired equation. **One way of parameterizing is to solve for one of the variables, say $a$.**" `[choose the easier form]` (14) does not solve for $a$ nicely (you'd need the quadratic formula), but (12) does — "and you can prove our question by solving for $a$, $b$, and $c$ in turn and deducing an intermediate result (which incidentally is equivalent to the result I will give below. But it would have to be, would not it?)". So the route *works*; Tao abandons it only in favour of a different illustration. His aside "but it would have to be, would not it?" is a small consistency check worth internalizing: two complete descriptions of the same solution set must agree, so if your two routes disagree, one is wrong.
8. `[recast as roots of a polynomial]` Move the $abc$ across: (14) is equivalent to
   $$a^2b+ab^2+b^2c+bc^2+c^2a+ca^2+2abc=0,$$
   so the admissible $(a,b,c)$ are exactly the zero set of this cubic. "The best way to deal with roots of polynomials is to factorize the polynomial (and vice versa)."
9. `[reason backwards from the target]` Since (14) must imply (13), some usable rewriting of (14) exists; for a polynomial, "usable form" means factored form. So a factorization should be findable — persist.
10. `[guess factors from structure, then experiment]` "What are the factors? … But to find out what they are, **we have to experiment.**" Homogeneous (all terms degree 3) $\Rightarrow$ factors homogeneous. Symmetric under permuting $a,b,c$ $\Rightarrow$ the factors permute among themselves. Cubic $\Rightarrow$ at least one linear factor. Candidates, nicest first: $a+b$, $a-b$, $a$, $a+b+c$, $a+b-c$; things like $a+2b$ are "not as 'nice'" and can wait. Structure produced the list; trial and error picks the winner off it, and Tao says so rather than pretending the factorization was seen at a glance.
11. `[test with the factor theorem]` Set $b=-a$ in the cubic:
    $$a^2(-a)+a(a^2)+a^2c+(-a)c^2+c^2a+ca^2 - 2a^2c = -a^3+a^3+a^2c-ac^2+ac^2+a^2c-2a^2c=0.$$
    So $a+b$ divides it; by symmetry so do $b+c$ and $c+a$. Degrees match ($1+1+1=3$), and checking the leading coefficient confirms
    $$a^2b+ab^2+b^2c+bc^2+c^2a+ca^2+2abc=(a+b)(b+c)(c+a).$$
12. `[case analysis on the factored condition]` Therefore (12) holds **if and only if** $a+b=0$ or $b+c=0$ or $c+a=0$. Substitute each possibility into the target.

**The resolution.** Take the case $a+b=0$, i.e. $b=-a$ (the other two cases are identical after relabelling). Then $a+b+c=c$, and:
$$\frac1a+\frac1b+\frac1c=\frac1a-\frac1a+\frac1c=\frac1c=\frac{1}{a+b+c}\quad\checkmark$$
$$\frac1{a^5}+\frac1{b^5}+\frac1{c^5}=\frac1{a^5}+\frac1{(-a)^5}+\frac1{c^5}=\frac1{a^5}-\frac1{a^5}+\frac1{c^5}=\frac1{c^5}=\frac{1}{(a+b+c)^5}\quad\checkmark$$
The whole problem turns on the fact that **5 is odd**, so $(-a)^5=-a^5$ and the two terms cancel exactly as they did in the original equation. The same statement would be false with exponent 4. (In the book this last step reads "Substituting each of these possibilities into $5ab$ does the trick" — as noted above, "$5ab$" appears to be a typesetting error for the target equation (13).)

**Transferable lessons.**
- When a hypothesis looks absurd, do not fight it — *solve* it. Determining the exact solution set of your hypothesis can be far easier than manipulating the hypothesis, and it makes the goal a routine substitution.
- The best intermediate result is a complete description of the constraint set (a parameterization or a factorization), because it can be substituted directly.
- Structural features — homogeneity, symmetry, degree — massively prune a search for factors. Use them before brute force.
- Simplifying is not monotone. Keep both the original and the normalized form; each is better for a different sub-task.
- Rejecting a tool for a stated reason can itself produce information (here: not all of $a,b,c$ are positive).

---

### Exercise 3.5 — Factorize $a^3+b^3+c^3-3abc$ (p. 44)

**Technique targeted.** Exactly the Problem 3.3 factor-hunting playbook. `[guess factors from structure]` The polynomial is homogeneous of degree 3 and fully symmetric, so expect a symmetric linear factor; the most symmetric linear form is $a+b+c$. `[factor theorem test]` Set $c=-(a+b)$: $a^3+b^3-(a+b)^3+3ab(a+b)=a^3+b^3-a^3-3a^2b-3ab^2-b^3+3a^2b+3ab^2=0$ ✓. So $a+b+c$ divides it, and dividing out gives
$$a^3+b^3+c^3-3abc=(a+b+c)(a^2+b^2+c^2-ab-bc-ca).$$
(Check at $a=b=c=1$: left $=3-3=0$; right $=3\times0=0$ ✓. At $a=2,b=1,c=0$: left $=8+1+0-0=9$; right $=3\times(4+1+0-2-0-0)=3\times3=9$ ✓.)

**Transferable lesson.** For symmetric homogeneous polynomials, always test the fully symmetric linear form first. It costs one substitution.

---

### Exercise 3.6 — Find all integers $a,b,c,d$ with $a+b+c+d=0$ and $a^3+b^3+c^3+d^3=24$ (p. 45)

**Tao's hint.** "it is not hard to guess *some* solutions to these equations, but to show that you have *all* of them, substitute the first equation into the second and factorize."

Two techniques flagged in one line: `[guess first — existence is cheap]` and `[eliminate a variable, then factorize — completeness is the hard part]`. Note the explicit distinction between finding solutions and *proving you have them all*; the second is what factorization buys.

**The chain of moves** (sketch; the book gives no solution).
1. `[substitute to eliminate]` $d=-(a+b+c)$, so the second equation becomes $a^3+b^3+c^3-(a+b+c)^3=24$.
2. `[factorize]` Use the identity $(a+b+c)^3-a^3-b^3-c^3=3(a+b)(b+c)(c+a)$ (verify at $a=b=c=1$: $27-3=24$ and $3\cdot2\cdot2\cdot2=24$ ✓). So the condition is $-3(a+b)(b+c)(c+a)=24$, i.e.
   $$(a+b)(b+c)(c+a)=-8.$$
3. `[change variables to something symmetric]` Since $a+b+c+d=0$, we have $a+b=-(c+d)$, $b+c=-(a+d)$, $c+a=-(b+d)$. So the condition becomes $(a+d)(b+d)(c+d)=8$.
4. `[finite case list from a small product]` Set $p=a+d,\ q=b+d,\ r=c+d$: three integers with $pqr=8$, so each is a divisor of 8. Also $p+q+r=(a+b+c)+3d=-d+3d=2d$ must be even.
5. Running through the divisor triples of 8 with even sum yields exactly two solution multisets:
   $$\{a,b,c,d\}=\{-1,-1,-1,3\}\quad\text{or}\quad\{-4,-4,3,5\}$$
   in any order. (Checks: $-1-1-1+3=0$ and $-1-1-1+27=24$ ✓; $-4-4+3+5=0$ and $-64-64+27+125=24$ ✓.)

**Transferable lesson.** "Find all" problems have two halves, and they need different tools: guessing for existence, factorization plus a finite divisor list for completeness. Reducing to "a product of integers equals 8" is the same move as Problem 3.4's "a product of integers equals 1" — small products over the integers give short case lists.

---

### Problem 3.4 — Prove that $f(x)=(x-a_0)^2(x-a_1)^2\cdots(x-a_n)^2+1$, with all $a_i$ integers, cannot be factorized into two non-trivial polynomials with integer coefficients (p. 45–47, difficulty $**$)

**The data / the objective.** $f$ is "a square plus one", where the square is a square of a product of *integer* linear factors. Objective: irreducibility over the integers. Tao's own advertisement (p. 45): "The factorization of polynomials, or impossibility thereof, is a fascinating piece of mathematics. The following question is instructive because it uses just about every trick in the book to find a solution."

**Concrete instance he gives.** Tao's own framing is "This is a rather general statement: it says for example, that the polynomial … cannot be factorized into other integer polynomials. How can we prove that?" With $n=1$, $a_0=1$, $a_1=-2$:
$$(x-1)^2(x+2)^2+1=x^4+2x^3-3x^2-4x+5$$
cannot be written as a product of two integer polynomials of smaller degree. (Check the expansion: $(x-1)(x+2)=x^2+x-2$, and $(x^2+x-2)^2=x^4+2x^3-3x^2-4x+4$; add 1.) Having a specific case in hand before attacking the general one is itself standard practice — and note *why* Tao picks it: the general claim is abstract enough that you need one instance just to feel the force of it.

**A note on indices.** The statement lists $a_0,\ldots,a_n$ (that's $n+1$ numbers, giving degree $2n+2$), but the worked solution counts "$n$ given points" and "degree $2n$", and writes the reconstruction using $a_1,\ldots,a_n$. This is an off-by-one inconsistency in the book's indexing; the argument is entirely unaffected once you fix a single convention. Below I follow the solution's convention: **$n$ integers $a_1,\ldots,a_n$, so $\deg f=2n$.**

**The chain of moves.**
1. `[proof by contradiction]` Suppose $f=pq$ with $p,q$ non-trivial integer polynomials. "Big deal." — i.e. the assumption alone gives nothing; you must feed it the structure of $f$.
2. `[dead end #1: use only positivity]` $f(x)\ge1$ for all real $x$ (a square is $\ge0$, plus 1). So $p$ and $q$ have the same sign at each point — "but that does not say much." Abandoned, though it will be resurrected in step 9.
3. `[find the unused data]` "we have another piece of data; $f$ is not just any old square plus one; the square is a square of a combination of linear factors. Can we use these $(x-a_i)$'s to our advantage?"
4. `[plug in the values that kill factors]` "the nicest factor one can have is 0, because that makes the entire expression 0." (With the caveat: "there are also occasions where having a 0 factor is the last thing one wants to have, because one may wish to cancel this factor.") Setting $x=a_i$ makes the whole squared product vanish:
   $$f(a_i)=0+1=1 \qquad\text{for every }i.$$
5. `[transfer to the factors]` Hence $p(a_i)q(a_i)=1$ for every $i$.
6. `[escalate real information to integer information]` "What does this mean? **Very little**, unless one remembers that $p$ and $q$ have integer coefficients, and that the $a_i$ are integers too. The upshot of this is that $p(a_i)$ and $q(a_i)$ are both integers." Two integers with product 1 must both be $1$ or both be $-1$ ("This can only occur when the integers are either both 1, or both $-1$"):
   $$p(a_i)=q(a_i)=\pm1\qquad\text{for all } i=0,1,\ldots,n.$$
7. `[notational vigilance]` The $\pm$ is *not* uniform: $p(a_1)$ and $q(a_1)$ share a sign, but $p(a_1)$ and $p(a_2)$ need not. Tao stops to say so, because collapsing this would be a false step. `[hedge honestly]` And when he summarizes, the hedge stays in: "We have found, **more or less**, the value of $p(a_0),\ldots,p(a_n)$ and $q(a_0),\ldots,q(a_n)$" — *more or less*, because they are pinned only up to sign.
8. `[degrees of freedom vs. constraints; pigeonhole on degree]` Each of $p,q$ is now "pegged" at $n$ points, while "polynomials only have as many degrees of freedom as their degree." Since $\deg p+\deg q=\deg f=2n$, at least one of them — call it $p$ — has degree $\le n$. Tao restates the position before continuing: "**In summary, we have a polynomial with degree at most $n$ but restricted to lie on $n$ given points.** Hopefully this can be exploited to a contradiction, which is what we are searching for." (Note that this is a *second* explicit inventory, distinct from the one in step 15 — Tao pauses to restate the position twice in one proof.)
9. `[root counting + roots of a factor ⊂ roots of the whole]` The question he asks is deliberately open: "What do we know about a polynomial that has degree at most $n$?" Answer: it has at most $n$ roots. Then: "Do we know anything about the roots of $p$?" $p$ divides $f$, so every root of $p$ is a root of $f$. And what are the roots of $f$? "**There are none! (Well, none on the real line, at least.)** $f$ is always positive (in fact, it is always at least 1), and hence can have no roots." Hence $p$ has none. `[state the arena]` The parenthetical matters: over $\mathbb{C}$, $f$ has $2n$ roots, so the claim is a claim about $\mathbb{R}$ — which is the right arena, because the next step is about *sign*, and the complex numbers have no notion of sign.
10. `[no roots ⇒ no sign change]` "What does it mean when a polynomial has no roots? It means that it never crosses 0, that is, it never changes sign. In other words, $p$ is either always positive or always negative." So there are two cases.
11. `[WLOG with an explicit conversion]` "This gives us two cases, but **we can save a little bit of work** by observing that one case implies the other. Indeed, if we have one factorization $f(x)=p(x)q(x)$, we automatically have another factorization $f(x)=(-p(x))(-q(x))$. So if $p$ is always negative, we can always flip the factorization and end up with a new factorization where $p$ is always positive." So assume $p>0$ throughout. Note the framing: WLOG is introduced as a *saving*, and the size of the saving is named ("a little bit") — no overclaiming.
12. `[collapse the ±]` Since $p(a_i)\in\{+1,-1\}$ and $p>0$: $p(a_i)=+1$ for all $i$. And $q(a_i)=p(a_i)=1$ too.
13. `[shift to make it a root statement]` "$p(x)$ and $q(x)$ are forced to take on the value of $+1$ at least $n$ times. This can be rephrased in terms of roots: $p(x)-1$ and $q(x)-1$ have at least $n$ roots."
14. `[force the degree]` $p(x)-1$ has degree $\le n$ but has $\ge n$ roots, so its degree is exactly $n$ — hence $\deg p=n$, and therefore $\deg q=2n-n=n$ as well.
15. `[inventory]` "To sum up what we know so far: We have assumed that $f(x)=p(x)q(x)$. $p$ and $q$ are both positive integer polynomials of degree $n$, and $p(a_i)=q(a_i)=1$, or alternatively $p(a_i)-1=q(a_i)-1=0$, for all $i$."
16. `[reconstruct from roots + leading coefficient]` $p(x)-1$ has degree exactly $n$ and its roots are exactly $a_1,\ldots,a_n$ (it can have no others, since $n$ is the maximum). So
    $$p(x)-1=r(x-a_1)(x-a_2)\cdots(x-a_n),\qquad q(x)-1=s(x-a_1)\cdots(x-a_n)$$
    for some constants $r,s$.
17. `[integrality of the leading coefficient]` $r$ is the leading coefficient of $p(x)-1$ and $s$ that of $q(x)-1$; both polynomials have integer coefficients, so **$r$ and $s$ are integers.**
18. `[substitute back and compare coefficients]` Write $P(x)=(x-a_1)\cdots(x-a_n)$ for brevity. Then $f=pq$ becomes
    $$P(x)^2+1=\big(rP(x)+1\big)\big(sP(x)+1\big).$$
    "This equation compares two explicitly defined polynomials. The best thing to do now is to compare coefficients." The leading term on the left is $x^{2n}$ with coefficient 1; on the right the top term is $rs\,x^{2n}$. (Tao says "comparing the $x^n$ coefficients", meaning the coefficients arising from the $x^n$ terms of the two factors.) So $rs=1$, and since $r,s$ are integers, either $r=s=1$ or $r=s=-1$.
19. `[the r=s=1 case]` Then $P^2+1=(P+1)(P+1)=P^2+2P+1$, so $2P(x)=0$, i.e.
    $$2(x-a_1)(x-a_2)\cdots(x-a_n)=0.$$
    "which is ridiculous (it must hold for all $x$)" — a non-zero polynomial cannot vanish identically. Contradiction.
20. `[symmetric case reduction]` "The case $r=s=-1$ is similar, and we are done." (Indeed: $(-P+1)(-P+1)=P^2-2P+1$, forcing $2P(x)=0$ again.) ∎

**Transferable lessons.**
- To prove a factorization is impossible, assume it exists and squeeze the hypothetical factors from every side: their values at special points, their degrees, their roots, their signs, their leading coefficients. Any one of these alone says little; the intersection is empty.
- Convert every statement about *values* into a statement about *roots*. Root counting is the only sharp quantitative tool available for polynomials, so shift by a constant to turn "$p=1$ here" into "$p-1$ has a root here."
- Constraint counting is a proof technique. "Degree $\le n$" is a budget; "$n$ prescribed values" is a bill. When the bill exceeds the budget the object is over-determined, and over-determination either pins it down exactly or kills it.
- The integers are rigid where the reals are floppy. $p(a_i)q(a_i)=1$ is nearly no information over $\mathbb{R}$ and almost total information over $\mathbb{Z}$. Whenever you can argue that a quantity is an integer, do so immediately.
- WLOG is legitimate only with a construction. Tao supplies the sign-flip that converts one case into the other.
- Keep an explicit running inventory in a long proof. Tao does it twice, and both times the inventory is what shows him the next move.

---

### Exercise 3.7 — Prove that $f(x)=(x-a_1)(x-a_2)\cdots(x-a_n)+1$ cannot be factorized into two smaller integer polynomials, the $a_i$ being integers (pp. 47–48)

**Tao's hint.** "if $f(x)$ factors into two polynomials $p(x)$ and $q(x)$, look at $p(x)-q(x)$. Note that this particular strategy could also be applied to Problem 3.4, but turns out to be somewhat ineffective in that case."

**The technique.** `[reuse the special-values move, then take a difference]`. Steps 1–7 of Problem 3.4 carry over verbatim: substituting $x=a_i$ gives $f(a_i)=1$, so $p(a_i)q(a_i)=1$, so $p(a_i)=q(a_i)=\pm1$ — and in particular $p(a_i)-q(a_i)=0$ for every $i$. `[shift to a root statement]` So the polynomial $p-q$ has $n$ distinct roots. `[degree count]` But $\deg p+\deg q=n$ with both non-trivial, so both degrees are $\le n-1$, hence $\deg(p-q)\le n-1$. A polynomial of degree $\le n-1$ with $n$ roots must be the zero polynomial. Therefore $p=q$, and $f=p^2$.

**Honest caveat (my observation, not the book's).** That conclusion — any factorization must be a perfect square — is strong, but it does not always close: genuine counterexamples to the exercise as literally stated exist. $x(x-2)+1=(x-1)^2$, and $x(x+1)(x+2)(x+3)+1=(x^2+3x+1)^2$ (set $u=x^2+3x$; the left side is $u(u+2)+1=(u+1)^2$). So the exercise needs an extra hypothesis to be true as printed; what the hint's argument actually establishes is the "$f=p^2$" conclusion above, which is the instructive part. Flagging this rather than papering over it, since the technique is what matters.

**Why the same trick is weak for Problem 3.4.** There $\deg f=2n$, so the two factors can each have degree up to $n$, and $\deg(p-q)\le n$ with only $n$ known roots — not a contradiction, merely the possibility $p-q=c\prod(x-a_i)$. The degree budget is exactly one unit too loose. This is a precise illustration of Tao's warning: the *same* move, applied to a structurally similar problem, is one degree short of working.

**Transferable lesson.** Taking the difference (or sum, or ratio) of two unknown objects that are individually hard to pin down but whose *relationship* you know is a general tactic. And: when reusing a trick, redo the counting — the arithmetic of degrees is what decides whether it bites.

---

### Exercise 3.8 — Let $f$ be a polynomial with integer coefficients and $a,b$ integers. Show $f(a)-f(b)$ can equal 1 only when $a,b$ are consecutive (p. 48)

**Tao's hint.** "factorize $f(a)-f(b)$."

**The chain of moves.**
1. `[recall the toolkit]` From p. 43: for any polynomial $f$ and any $t$, $x-t$ divides $f(x)-f(t)$. Evaluating that divisibility at $x=a$ with $t=b$: **$(a-b)$ divides $f(a)-f(b)$.**
   Concretely, $a^k-b^k=(a-b)(a^{k-1}+a^{k-2}b+\cdots+b^{k-1})$, so every term of $f(a)-f(b)$ carries a factor of $a-b$; and because the coefficients are integers, the cofactor is an integer.
2. `[a small product forces a short list]` If $f(a)-f(b)=1$, then $a-b$ is an integer dividing 1, so $a-b=\pm1$. That is exactly the statement that $a$ and $b$ are consecutive integers. ∎

**Transferable lesson.** The divisibility $a-b \mid f(a)-f(b)$ is one of the highest-leverage facts about integer polynomials, and it is just the factor theorem read at integer points. Whenever you see the *difference of two values* of an integer polynomial, immediately write down what divides it. Same shape as Problem 3.4's key move and Exercise 3.6's endgame: constrain an integer by making it divide something small.

---

## What this chapter teaches about problem solving in general

**1. Discreteness is a resource; spend it.** Almost every solution in §3.1 turns on the fact that there is nothing between $k$ and $k+1$. Concretely: rewrite strict integer inequalities with an explicit $+1$; whenever an integer is trapped strictly between $k$ and $k+2$, you have determined it. In §3.2 the same principle wears a different costume — a *product of integers* equal to 1 (or 8) yields a finite, short case list, where over the reals it would yield nothing. Tao returns to this so many times that it deserves the status of a reflex: **ask whether your quantity is an integer, and if it is, exploit the rigidity immediately.**

**2. An inequality can prove an equality — squeeze from both sides.** Problems 3.1 and 3.2 both end by trapping the unknown between bounds that leave exactly one possibility. If your goal is an equality and your data are inequalities, do not conclude the data are insufficient; ask what the *other* bound would need to be, and go get it.

**3. When an induction stalls, strengthen what you are proving.** This is the chapter's deepest technical lesson and its most counterintuitive. Tao's rule: look at exactly which fact your induction step wished it had, and *put that fact into the statement being inducted*. A stronger conclusion buys a stronger hypothesis, and the hypothesis is what you actually work with. Then specialize back at the end. Corollary: also choose the right *flavour* of induction, by counting how many earlier cases your hand computation consumed.

**4. Reshape the question before answering it.** Tao almost never answers the question as asked. He converts "Find $f(1983)$" into "determine $f$ entirely", and then into "prove $f$ is unique" — because general claims can be inducted and verification is easier than search. He converts "prove (12) implies (13)" into "describe the complete solution set of (12)". He converts "$p$ takes the value 1 at these points" into "$p-1$ has these roots". The pattern is: **restate the problem in the form for which you own a tool.**

**5. Escalate the type of information you hold.** The chapter repeatedly gains power by upgrading a fact's *kind*, not its strength: a pointwise estimate ($f(n+1)>f(n)$ for each $n$) becomes a structural property (monotone), which becomes a licence to cancel $f$ from both sides. A real-valued equation ($p(a_i)q(a_i)=1$) becomes an integer statement, which becomes a two-case enumeration. A value statement becomes a root statement, which becomes a degree count. When you get a new fact, ask what *category* of fact it could be promoted to.

**6. Try the direct approach, name its failure, and let the failure inform the next attempt.** Tao's dead ends are all announced ("So much for the direct approach"; "Big deal"; "(b) … is also of not much help") and all instructive. The fifth-power expansion in Problem 3.3 fails because of cross-terms, which is a clue that the solution must make terms *cancel* — which is what the factorization ultimately delivers. Similarly, rejecting AM–GM for lack of positivity produces the genuine new fact that $a,b,c$ cannot all be positive. **A well-diagnosed failure is data.**

**7. Prune search with structure, and search in order of niceness.** Guessing a factorization looks like an unbounded search, but homogeneity, symmetry and degree cut it to a handful of candidates, and Tao orders those candidates from nicest to ugliest, explicitly deferring $a+2b$. The general habit: before enumerating, extract every invariant of the object that constrains the answer; then order your enumeration by expected likelihood, not arbitrarily.

**8. Scarcity of data is a navigational asset, not a handicap.** Twice — p. 36 for functional equations, p. 43 for Problem 3.3 — Tao converts "there is almost nothing given" into "therefore the path should be short and there should be a clear direction in which to go." That inference is worth making explicitly at the start of any sparse problem, because it has a sharp contrapositive: *if you are lost in a two-hypothesis problem, you have not run out of ideas, you have failed to read something.* Tao's own next move after saying it in Problem 3.1 is to re-read the statement and notice the codomain. And the counterweight is stated just as plainly — "And yet, it still has its surprises" — so short path does not mean easy path. Note also that Tao makes the prediction and then *reports when it fails*: in Problem 3.3 the "straightforward sequence of logical steps" does not exist, and the recorded failure is what motivates the sideways move.

**9. Interrogate your formulas for consequences you did not ask for.** The chapter's epigraph (Hertz, p. 35) claims that formulae "are wiser than we are… we get more out of them that was originally put into them", and Tao's very first example cashes it: the identity $1^3+\cdots+n^3=(1+\cdots+n)^2$ was written to describe a sum of cubes and it hands you, unrequested, the fact that such a sum is always a perfect square. The habit is to re-read every result you derive and ask what *else* it says. Problem 3.1's turning point is exactly this: $f(n+1)\ge f(n)+1$ was derived as a numerical bound, and reading it again says "$f$ is monotone" — which is a different and far more useful fact than the one he was chasing.

**10. An argument that used only $+,-,\times,\div$ is not about numbers.** Tao's opener notes that matrix algebra "does much the same" as ordinary algebra with "groups of numbers instead of using just one", and that other algebras with other operations and other 'numbers' "sometimes surprisingly, tend to have much of the same properties as normal algebra" — with $(I-A)^{-1}=I+A+A^2+\cdots$ as the illustration. Two transferable points. First, if your derivation only used the ring axioms, it transfers to anything satisfying them, so check whether your problem is secretly an instance of a more general one you already solved. Second, the transfer is only of the *algebra*: Tao's "under special conditions" is a warning that convergence, ordering, sign, and cancellation are extra structure that must be re-earned in the new setting. §3.2 lives inside exactly that gap — polynomials support degree and factorization (algebra) but polynomials over $\mathbb{Z}$ support far more than polynomials over $\mathbb{R}$ (extra structure), and Problem 3.4 is won entirely on the extra structure.

**11. Keep your books straight, and hold the line between compass and premise.** Two disciplines that make the long proofs safe. First, periodic inventory — Tao stops mid-Problem-3.4 to list exactly what has been established — which is both an error check and the thing that reveals the next move. Second, the strict separation between using your expected answer to *choose* subgoals and using it as a step; he flags the temptation aloud ("we cannot actually use what we are trying to prove"). Add to these: notational care (the non-uniform $\pm$), certifying equivalence when you rewrite a hypothesis, and checking that a substituted expression is actually in the domain. Every one of these is a place where a plausible-looking proof silently becomes wrong.
