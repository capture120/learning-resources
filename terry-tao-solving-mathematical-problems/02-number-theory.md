# Chapter 2: Examples in number theory

> This chapter is a workshop, not a lecture. The mathematical subject matter is elementary number theory — digits, divisibility, Diophantine (integer-only) equations, and sums of powers — but the actual content is a catalogue of *moves*. Number theory is chosen precisely because, as Tao puts it in the opening pages, it "seems to derive its results from a source unknown": the equations look simple, but because you are locked to the integers, "the rules of algebra fail" (p. 9). That failure is what forces technique. Across seven worked problems and six exercises Tao shows the same small set of manoeuvres over and over: *translate the goal into a formula you can push around; generate data and stare at it; interrogate every constant in the problem statement; throw away information you cannot use and keep only invariants; find a stepping stone between the hypothesis and the conclusion; move the whole problem into modular arithmetic; pick the modulus so that a term disappears; exploit periodicity, symmetry and anti-symmetry; and above all keep reducing the question to a weaker, uglier, but more tractable question until it collapses.* He is unusually candid about the failures — roughly half the text of this chapter is spent on approaches that got abandoned — and he narrates *why* each one was dropped. That narration is the real payload.

**The chapter's epigraph**, which sets the tone of "number theory is spooky":

> "There is divinity in odd numbers, either in nativity, chance, or death."
> — *William Shakespeare*, The Merry Wives of Windsor

**How the chapter is actually organized.** The file below is arranged by *technique*, but the book is arranged by *object*, in three named sections. Which section you are in tells you which toolkit to reach for first, and Tao opens each section by naming that toolkit. It is worth knowing the map:

| Section | Printed pages | Objects | Contents | The toolkit Tao names up front |
|---|---|---|---|---|
| **2.1 Digits** | 10–19 | base-10 digit expansions | Problem 2.1, Exercise 2.1, Problem 2.2 | none — and that is the point (see the warning below) |
| **2.2 Diophantine equations** | 19–22 | integer-only algebraic equations | Problem 2.3, Problem 2.4, Exercise 2.2 | "integer division, modular arithmetic, and integral factorization" (p. 19); narrowed on p. 21 to "the most elementary methods are modular arithmetic and factorization" |
| **2.3 Sums of powers** | 23–34 | $1^k+2^k+\cdots+n^k$ and its variants | Problems 2.5, 2.6, 2.7, Exercises 2.3–2.6 | modular arithmetic + periodicity + (anti-)symmetry |

Two structural remarks the sectioning makes visible:

- **Tao's own warning about section 2.1 (pp. 10–11), which is easy to miss and worth taking seriously.** Digit-summing "is not particularly important" in higher mathematics — "it has proven far more effective to study numbers directly, rather than via their digit expansion" — "but it is quite popular in recreational mathematics and has even been given mystical connotations by some! Certainly, digit summing appears fairly often in mathematics competition problems, such as this one." So the very first section is deliberately about a *low-value* object. This is not filler: it is why the digits turn out to be a red herring in **both** Problem 2.1 and Problem 2.2, and why in both cases the winning move is to trade digits for something conventional (a bound; a residue mod 9). **Reading the genre of a problem tells you in advance which of its features will not survive to the end of the proof.**
- **Problem 2.7 is introduced as a sub-genre of Problem 2.6**: "Now let us turn to a special type of 'sums of powers' problem, namely sums of reciprocals" (p. 26). That framing is *load-bearing*, because it is the reason Tao's first idea for the hard problem is "if we are fresh from solving Problem 2.6, we know that symmetry, or anti-symmetry can be exploited" (p. 30). Filing a problem under a genre you have just worked in is how you get a non-random first guess.

---

## The techniques at a glance

| # | Technique | Trigger — what makes you reach for it | Where Tao uses it |
|---|---|---|---|
| 1 | **Size up the search space first** | Problem is finite, or nearly so | P2.1 ("only 900 or so three-digit numbers... but let us see if we can save ourselves some work", p. 11) |
| 2 | **Translate the objective into a formula** | The goal is stated in words ("divisible by the sum of its digits") | P2.1 → $(a+b+c)\mid \overline{abc}_{10}$; P2.7 objective (a) |
| 3 | **Notation hygiene / housekeeping substitutions** | Ambiguous or messy symbols will breed errors | $\overline{abc}_{10}$ vs $abc$ (p. 11); $n=2m$ to avoid "$n/2$" (p. 25) |
| 4 | **Generate data; tabulate; stare** | You have no idea what is going on | P2.1 (list of solutions), P2.2 (three tables), P2.5 (table mod 5), P2.7 (test $p=5,7,11$) |
| 5 | **Interrogate the constants in the statement** | A specific number (18, 7, 4, $p>3$) appears with no obvious reason | "what is the significance of the 18 anyway?" (p. 11) |
| 6 | **Suspect / test for red herrings** | Data in the problem that resists all use | 18 might be padding (p. 11); digits themselves are a red herring (p. 14); expanding $100a+10b+c$ is a red herring (p. 13) |
| 7 | **Stepping stones** — insert an intermediate statement | Hypothesis and conclusion "do not mix" | P2.1: 18 consecutive ⟹ a multiple of 18 ⟹ a solution (p. 12) |
| 7b | **Judge a stepping stone by the *second* arrow** | You have a valid but awkward intermediate | P2.1 (p. 12): the multiples-of-9 stone "does work, but a bit of extra work is needed to cover all the cases" |
| 8 | **Prove something stronger because it is simpler** | The literal statement carries unusable baggage | P2.1 (multiples of 18); P2.2 ("we have to prove more: but in terms of clarity and simplicity we are gaining ground", p. 14) |
| 9 | **Bound instead of solve** | A quantity has a small range | digit sum of a 3-digit number lies in $[1,27]$ ⟹ it is 9, 18 or 27 (p. 13) |
| 10 | **Guess the answer before proving it** | Yes/no question, competition provenance | P2.2: "the first sneaky thing to be done is to guess the answer" (p. 14) |
| 11 | **Discard unusable data; keep only invariants** | A transformation (digit-switching) is too complicated to describe exactly | P2.2: digit count, then digit sum, then digit sum mod 9 |
| 12 | **Prefer "conventional weapons"** | Your current concept has no theorems attached to it | P2.2: "'set of digits' is not a very useful mathematical object... the *sum of digits* is a more conventional weapon" (p. 16) |
| 13 | **Recognize over-generalization and pull back** | Your weakened question now has the wrong answer | P2.2: "we have generalized too far... Let us reel ourselves in again" (pp. 15–16) |
| 14 | **Bank partial victories** | You cut the possibilities down but not to zero | P2.2: infinitely many suspects → at most three per power of 2 (p. 15) |
| 15 | **Move to modular arithmetic** | Any statement of the form "$a$ divides $b$" | P2.2, P2.4, P2.5, P2.6, P2.7, Ex 2.2, Ex 2.3, Ex 2.6 |
| 16 | **Choose the modulus to annihilate a term** | An equation with several terms, one of which is awkward | P2.4: try mod $x$, mod 7, then mod 2 to kill $2^n$ (pp. 21–22) |
| 17 | **Choose the modulus to constrain the survivors** | Killing a term left the rest unrestricted | P2.4: mod 2 → mod 4, because squares are $0,1 \pmod 4$ (p. 22) |
| 18 | **Periodicity of powers** | An exponent is a free parameter | P2.2 ($2^n \bmod 9$, period 6), P2.5 ($a^n \bmod 5$, period 4) |
| 19 | **Factorization into (factor)×(factor) = something rigid** | Diophantine equation; a difference of squares is visible | P2.4: $7=(x-2^m)(x+2^m)$ (p. 21); P2.3's discriminant trick "is actually a factorization technique in disguise" (p. 21) |
| 20 | **Quadratic formula ⟹ discriminant must be a perfect square** | Two integer unknowns appear quadratically | P2.3 (p. 20) |
| 21 | **Growth / gap arguments** | Two integer quantities must be equal but grow at different rates | P2.3 (gaps between squares exceed 4); P2.2 (six doublings = factor 64) |
| 22 | **Split a modulus into coprime factors** | The divisor factors as $d_1 d_2$ with $\gcd(d_1,d_2)=1$ | P2.6: $m(2m+1)$ → mod $m$ and mod $2m+1$ (p. 25) |
| 23 | **Case analysis on parity** | An unavoidable "/2" or a $(-1)^n$ | P2.6 ($n$ even/odd, then $m$ even/odd); P2.3 (Case $n=0$, Case $n=4$) |
| 24 | **Choose the *representation* that suits the goal** | The same object can be written as a sum or as a product | P2.6: use $n(n+1)/2$, not $1+2+\cdots+n$, because "it is always easier if the divisor is expressed as a product" (p. 24) |
| 25 | **Symmetry / anti-symmetry and pairwise cancellation** | A sum runs symmetrically over a modulus | P2.6 ($2m \equiv -1$, etc.), P2.7 ((7) proof #2) |
| 26 | **"Symmetry is nice to keep; anti-symmetry is nice to cancel"** | You must decide whether to fold a sum or expand it | P2.7 "doubling up" (p. 32) |
| 27 | **Solve an easier analogue first** | The target is a strengthened version of a familiar statement | P2.7: prove (7) mod $p$ before attacking mod $p^2$ (p. 29) |
| 28 | **Trade complexity for a weaker modulus** | You need divisibility by $p^2$ | P2.7: extract a factor $p$, so mod $p^2$ becomes mod $p$ (p. 31) |
| 29 | **Reject a *successful* proof that does not generalize** | The proof of the easy case is too special | P2.7: "it is better to find a block that is more round" (p. 30) |
| 30 | **Rearrangement / bijection** | A sum over a set that a map permutes | P2.7: $1/1,\dots,1/(p-1)$ is a permutation of $1,\dots,p-1$ (mod $p$); Ex 2.6 |
| 31 | **Kill the sum with a closed form** | A sum of a standard shape survives | P2.7: $1^2+\cdots+n^2 = n(n+1)(2n+1)/6$ (p. 33) |
| 32 | **Audit each reformulation for logical validity** | You replaced object A with object B | P2.7: unreduced vs reduced numerator; "one cannot just jump from one form to another without care" (p. 29) |
| 33 | **Classify the question type** | Before starting | P2.7: "a 'Prove that' question, not a 'Find a' or 'Show there exists' question, so it should not be completely impossible" (p. 27) |
| 34 | **Set explicit tactical objectives from the *shape* of the question** | The question names an awkward object | P2.7 objectives (a) and (b) (p. 27) |
| 35 | **Temporarily abandon a fruitless approach; keep it in reserve** | You are circling | P2.3 (p. 20): drop number theory, do algebra, "re-apply number theory later" |
| 36 | **Try elementary techniques first / look for the lazy way** | Heavy machinery is visible on the horizon | P2.4: continued fractions and Pell's equation "can be done; but we will look for the elegant (i.e. lazy) way out" (p. 21) |
| 37 | **"Find all solutions" = eliminate all but finitely many** | The problem says *find all* | P2.4 (p. 22) — and this is why mod 7 and mod $x$ were doomed |
| 38 | **Spiral, not circle — check you are making progress** | Your new goal resembles an old one | P2.7 (p. 32): "we are going around in spirals" |
| 39 | **Write down every fact, however trivial** | Early exploration | P2.2 (p. 15): "Even shallowly dug gold has to be searched—and held on to" |
| 40 | **Heuristic / probabilistic plausibility check** | You want to know whether an approach *can* work | P2.2 (p. 16–17): digit-sums are small, so collisions are likely — bad luck for us |
| 41 | **Reuse one worked example throughout** | Repeated numeric sanity checks | P2.7 keeps returning to $p=5$ "so we can reuse some previous work" (p. 32) |
| 42 | **Defer a routine lemma** | A sub-fact is obvious but needs saying | P2.7 (p. 33): the permutation lemma is proved at the very end |
| 43 | **Use a computer for facts that are not part of the proof** | Optimality / sanity claims | P2.1 (p. 13): 17 consecutive numbers fail at 559–575 — "I used a computer for that" |
| 44 | **Multiply through to clear an inconvenient fraction** | A "/2" blocks a modular argument | P2.6 footnote (p. 25) |
| 45 | **Recognize a scary-looking problem as mild** | Superficial resemblance to a famous hard theorem | P2.5 (p. 23): looks like Fermat's Last Theorem, "But our question is much milder" |
| 46 | **Step-by-step reduction as a named strategy** | Nothing else is working | P2.7 (p. 33): "We keep reducing the equation to simpler and simpler formulations, until it just collapses into nothing." |
| 47 | **Read the genre / provenance of the problem** | Before starting; when deciding which features are real | Digit-summing is "quite popular in recreational mathematics" and appears "fairly often in mathematics competition problems", not in higher mathematics (pp. 10–11) — so expect the digits to be discardable |
| 48 | **Situate the problem in the literature, then decline the machinery** | You recognize the problem type | P2.6 (p. 24): "a standard exercise in Bernoulli polynomials (or some astute applications of the Remainder Theorem), an interesting portion of mathematics that has many applications" — named, then refused |
| 49 | **File the new problem under a genre you have just worked in** | A problem resembles the previous one | P2.7 is introduced as "a special type of 'sums of powers' problem, namely sums of reciprocals" (p. 26) — which is why anti-symmetry is his first idea on p. 30 |
| 50 | **Characterize the easier of two coupled objects first** | The problem couples object A with object B | P2.2 (p. 14): "Now let us tackle powers of 2 first; they are easier to handle" |
| 51 | **Upgrade a stepping stone that *works* but costs too much** | Your stone is valid but the proof has loose ends | P2.1 (p. 12): multiples of 9 "does work, but a bit of extra work is needed to cover all the cases. It is actually better to use multiples of 18" |
| 52 | **Check the direction of your implication before banking it** | You found an invariant | P2.2 (p. 15): same digit count is preserved by rearranging, "But the reverse is far from true" — hence one invariant alone cannot finish |
| 53 | **Turn a described object into an equation** | The target is phrased as "the numerator of…", "the number of…" | P2.7 (p. 28): "This is better than the other numerator because now we have an equation to solve" |
| 54 | **Distinguish an example that *verifies* from an example that *shows the mechanism*** | You just computed a case | P2.7: $p=5$ mod 25 is a fluke you cannot read (p. 29) vs. $p=5$ mod 5 where "The way it works when $p=5$ shows the way for the general case" (p. 33) |
| 55 | **Notice when your own earlier reduction has neutralized a new observation** | You spot a pattern late | P2.2 (p. 17): digit sums drift upward with $n$, "But also remember that we are confining ourselves to powers of 2 with the same number of digits, so this idea will not be of much help" |
| 56 | **Self-prompt with an explicit question when stuck** | You have run out of moves | P2.2 (p. 17): "Is there another reduction of the problem that will leave us with something we can really work with?"; P2.4 (p. 22): "can we eliminate the $2^n$ term instead?" |
| 57 | **Collect "iotas" — name and keep each single small fact** | Early exploration | P2.2 (pp. 15–16): "with this iota of information…", "So we have another iota of information: digit-switching preserves the digit-sum" |
| 58 | **Restate the current target in one sentence, out loud** | Mid-chain, before the final push | P2.2 (p. 18): "What we have to prove is that no two powers of 2 have the same remainder (mod 9) and the same number of digits" |

---

## Background you need first

You need almost nothing beyond arithmetic, but you do need the *notation*, and this chapter uses it relentlessly. Everything below is either stated by Tao on pp. 10–11 or is a standard fact he assumes.

**First, why Tao thinks the subject is worth your time (p. 10).** He is blunt that the *problems* in this chapter are small: "Basic number theory is a pleasant backwater of mathematics." What justifies the backwater is where its two basic concepts lead:

- *Divisibility* → primes → "the detailed nature of factorization" → **the prime number theorem**, "one of the jewels of mathematics in the last part of the previous century", which "can predict the number of primes less than a given number to a good degree of accuracy". *(For orientation: it says the count of primes below $N$ is close to $N/\ln N$. Nothing in this chapter needs it.)*
- *Integer operations* → modular arithmetic → "the algebra of finite groups, rings, and fields" → **algebraic number theory**, "when the concept of 'number' is expanded into irrational surds, elements of splitting fields, and complex numbers". *(A "surd" is just an irrational root like $\sqrt2$; a "splitting field" is a number system enlarged until a chosen polynomial factors completely in it. Again, not needed here.)*

His verdict: "Number theory is a fundamental cornerstone which supports a sizeable chunk of mathematics. And, of course, it is fun too." The reason this matters for a *problem-solving* reader is calibration: the chapter's tools (mod 9, squares mod 4, periodicity) are the shallow end of a genuinely deep subject, so when a problem resists them the honest diagnosis may be "this needs the deep end", not "I am stupid" — exactly the diagnosis he gives for Lagrange's four-squares theorem on p. 9.

**Divisibility, and the bar `|`.** `a | b` is read "**a divides b**", meaning $b$ is an exact multiple of $a$: there is an integer $q$ with $b = aq$. So $3 \mid 12$ (because $12 = 3\times 4$) and $3 \nmid 13$. Warning: the bar is *not* division. `3 | 12` is a true/false statement; `12 / 3` is a number. Tao introduces it on p. 11.

**Natural numbers, primes, coprime.** Tao's conventions (p. 10): a *natural number* is a positive integer, and 0 is not one; the set of them is written $\mathbf{N}$. A *prime* has exactly two factors, itself and 1, so 1 is not prime. Two natural numbers are **coprime** if their only common factor is 1 — e.g. 8 and 15 are coprime even though neither is prime.

**Modular arithmetic.** This is the single tool the chapter runs on. The statement
$$x = y \pmod n$$
(Tao writes `=`; most modern texts write $\equiv$) means "**$x$ and $y$ differ by a multiple of $n$**". So $15 = 65 \pmod{10}$ because $65-15=50=5\times 10$. The mental model Tao gives is: *arithmetic in which $n$ has been declared equal to 0*. Working mod 10, $65 = 15+10+10+10+10+10 = 15+0+0+0+0+0 = 15$.

For a programmer: `x % n == y % n`. The reason it is useful is that it is a *homomorphism* — addition and multiplication survive the reduction, so you can reduce first and compute afterwards. $17\times 23 \bmod 5$: reduce to $2 \times 3 = 6 = 1 \pmod 5$; and indeed $391 = 78\times 5 + 1$.

Tao's one-line advertisement for the whole apparatus (p. 9): modular arithmetic "gives you the power of algebra but limited to a finite number of integers." That is the trade in a sentence — you keep $+$, $-$, $\times$ and (usually) $\div$, and in exchange the universe becomes finite, so exhaustive checking becomes an option.

Two quirks Tao flags on p. 10:
- **No inequalities, and all numbers are integers.** "$x < y \pmod n$" is meaningless. Losing order is the price of the convenience.
- **Division is weird but usually legal.** $7/2 \neq 3.5 \pmod 5$; instead $7 = 12 \pmod 5$, so $7/2 = 12/2 = 6 \pmod 5$. Every result is an integer. Tao's reassurance and its limit: "It may seem strange to divide in this round-about way, but in fact one can find that there is no real contradiction, although some divisions are illegal, just as division-by-zero is illegal within the traditional field of real numbers." The rule: *"As a general rule, division is OK if the denominator is coprime with the modulus $n$."* Concretely, $1/2 \pmod 5$ means "the number which, doubled, gives 1", i.e. 3, since $2\times3=6=1 \pmod 5$. This exact manoeuvre is the engine of Problem 2.7, where expressions like $1/3 \pmod{49}$ are ordinary integers.

**The digit-sum rule mod 9.** Because $10 = 1 \pmod 9$, every power of 10 is also $1 \pmod 9$, so a number is congruent to its digit sum mod 9. Tao's worked instance (p. 17):
$$3297 = 3\times10^3 + 2\times10^2+9\times10^1+7\times10^0 = 3\times1+2\times1+9\times1+7\times1 = 3+2+9+7 \pmod 9.$$
Consequence: $9 \mid N$ if and only if 9 divides $N$'s digit sum. (Same works for 3.)

**Squares mod 4.** Used in Problem 2.4. Any integer is even or odd. $(2k)^2 = 4k^2 = 0 \pmod 4$; $(2k+1)^2 = 4k^2+4k+1 = 1 \pmod 4$. So **a perfect square is always 0 or 1 mod 4 — never 2 or 3.** This one line kills an infinite family of possibilities.

**Fourth powers mod 5** (used in Exercise 2.3). $1^4=1$, $2^4=16=1$, $3^4=81=1$, $4^4=256=1$, $0^4=0$ (all mod 5). So a fourth power is 0 or 1 mod 5. This is a special case of **Fermat's little theorem**: if $p$ is prime and $a$ is not a multiple of $p$, then $a^{p-1} = 1 \pmod p$. Concretely for $p=5$: $2^4=16=1 \pmod 5$. You do not need the general theorem for this chapter — checking the four cases by hand is enough — but it is the reason the pattern exists.

**Difference of two squares.** $x^2 - y^2 = (x-y)(x+y)$. Tao calls this "a vital factorization in Diophantine equations" (p. 21).

**Factorials.** $(p-1)! = 1\times 2 \times \cdots \times (p-1)$. So $4! = 24$. Key fact used repeatedly in Problem 2.7: if $p$ is prime then $(p-1)!$ is **coprime to $p$**, because every factor in the product is smaller than $p$ and hence not a multiple of the prime $p$.

**Closed forms for sums.** $1+2+\cdots+n = n(n+1)/2$ and $1^2+2^2+\cdots+n^2 = n(n+1)(2n+1)/6$. Both provable by induction (which, for a programmer, is exactly recursion with a base case).

**Two facts quoted only in exercise hints:**
- **Bertrand's postulate** (Ex 2.5): for any positive integer $n$ there is at least one prime between $n$ and $2n$. (Named a "postulate" for historical reasons; it is a theorem.)
- **A generator of $\mathbf{Z}/p\mathbf{Z}$** (Ex 2.6). $\mathbf{Z}/p\mathbf{Z}$ is just notation for "the integers mod $p$" — the set $\{0,1,\dots,p-1\}$ with mod-$p$ arithmetic. A *generator* (also called a primitive root) is a number $a$ whose powers $a^1,a^2,\dots,a^{p-1}$ run through *all* of $1,2,\dots,p-1$ in some order. Example $p=5$, $a=2$: $2,4,3,1$ — all four nonzero residues. The relevant consequence: $a^k = 1 \pmod p$ happens *only* when $(p-1)\mid k$. Such an $a$ exists for every prime; that existence is the one fact in this chapter genuinely beyond the book's elementary toolkit.

**Diophantine equation** (p. 19, opening section 2.2): "an algebraic equation (the classic one is $a^2+b^2=c^2$) with the constraint that all variables are integers. The usual objective is to find all solutions to the equation. Generally, there is more than one solution, even if everything is integral." Note the last clause — it is the seed of the p. 22 moral that a correct approach must leave survivors. And note the toolkit Tao names at the section level, which is *three* items, one more than the pair he lists on p. 21: "These equations can be solved algebraically, but one also can use the number-theoretical methods of **integer division, modular arithmetic, and integral factorization**." "Integer division" here means divisibility reasoning of the $ab \mid (a+b)^2$ kind — the first thing he tries, and abandons, in Problem 2.3.

---

## The chapter's opening menu (pp. 9–10)

**The framing.** Tao's opening contrast is between algebra and number theory: "Unlike algebra, which has as its backbone the laws of manipulating equations, number theory seems to derive its results from a source unknown." His illustration is **Lagrange's theorem** (every positive integer is a sum of four perfect squares, e.g. $30 = 4^2+3^2+2^2+1^2$) — and he notes it was "first conjectured by Fermat". Algebraically it is trivially simple; "but because we are restricted to the integers, the rules of algebra fail. The result is infuriatingly innocent-looking and experimentation shows that it does seem to work, but offers no explanation why." Verdict: it "cannot be easily proved by the elementary means covered in this book: an excursion into Gaussian integers or something similar is needed." *(Gaussian integers are the numbers $a+bi$ with $a,b$ integers — a bigger number system in which the four-squares statement acquires structure it does not have over $\mathbf{Z}$. You do not need them anywhere in this chapter.)*

**The "not as deep" menu.** Then, to make a point about *depth* — the difficulty of a number-theory statement is not visible from its surface — he lists five innocent-looking statements about a natural number $n$:

- (a) $n$ always has the same last digit as its fifth power $n^5$. *(A mod-10 statement.)*
- (b) $n$ is a multiple of 9 if and only if its digit sum is a multiple of 9. *(The rule below; used in Problem 2.1.)*
- (c) **Wilson's theorem**: $(n-1)!+1$ is a multiple of $n$ if and only if $n$ is prime.
- (d) If $k$ is a positive odd number then $1^k+2^k+\cdots+n^k$ is divisible by $n+1$. *(A close relative of Problem 2.6, which proves divisibility by $1+2+\cdots+n = n(n+1)/2$. Note that (d) and Problem 2.6 together give divisibility by both $n+1$ and $n(n+1)/2$ — Problem 2.6's Part A is essentially (d).)*
- (e) There are exactly four numbers that are $n$ digits long (zero-padding allowed) and have the same last digits as their square; for $n=3$ they are 000, 001, 625, 876. *(Check: $625^2 = 390625$, ending in 625 ✓; $876^2 = 767376$, ending in 876 ✓.)*

His verdict on the five: "These statements can all be proved by elementary number theory; all revolve around the basic idea of *modular arithmetic*, which gives you the power of algebra but limited to a finite number of integers." And then a warning that shallow-looking things have deep continuations: (e), pushed hard enough, "can eventually lead to the notion of *p-adics*, which is sort of an infinite-dimensional form of modular arithmetic." *(Very roughly: instead of working mod $p$, or mod $p^2$, you work mod $p^k$ for every $k$ at once, and the four numbers in (e) are the beginning of an infinite string of digits. Nothing in the chapter uses this — but note that Problem 2.7's move from mod $p$ to mod $p^2$ is the first step of exactly that ladder.)*

**The transferable move here is a diagnostic one:** before committing effort, ask *is this shallow or deep?* Tao's own signals are provenance and phrasing — a competition problem is shallow by construction (he uses this explicitly in Problem 2.2), and a *genre* can be shallow too (digit-summing is "recreational", pp. 10–11); whereas a statement that "experimentation shows does seem to work, but offers no explanation why" may be deep. Notice that this last signal is double-edged: Tao uses the very same words to *reject* an approach mid-problem, when his own experiments verify a case without explaining it ("Perhaps it is a fluke", p. 29).

---

## Technique 1: Size up the search space, then try to avoid searching it

- **What it is.** Notice whether the problem is finite. If it is, you have a guaranteed (if grim) fallback, which frees you to gamble on cleverness. Then look for the shortcut.
- **When to reach for it.** Bounded digits, bounded range, a small modulus.
- **Tao's own words.** Problem 2.1: "This is a finite problem: there are only 900 or so three-digit numbers, so theoretically we could evaluate the problem manually. But let us see if we can save ourselves some work." (p. 11)
- **Seen in action.** P2.1 (900 candidates); P2.5 ("Because we are using such small numbers, we can evaluate some of the values... manually", p. 23).
- **Why it works.** Knowing brute force exists converts "can I solve this?" into "how cheaply can I solve this?" — a much less paralysing question. It is the same psychological trick as knowing you have an $O(n!)$ baseline before hunting for a polynomial algorithm.
- **Failure mode.** Tao is explicit (p. 13) that finite problems reward *different* tactics: "with finite problems, the strategies are not like those in higher mathematics." In P2.1 the winning move was to *bound* a quantity (digit sum $\le 27$), which is meaningless in an infinite setting.

---

## Technique 2: Translate the objective into a formula — and keep your notation clean

- **What it is.** Rewrite the verbal goal as symbols you can manipulate, and invent notation that prevents collisions.
- **Tao's own words.** "Let us first write down the objective as a mathematical formula, so that we can manipulate it more easily." (p. 11)
- **Seen in action.** P2.1: "divisible by the sum of its digits" becomes $(a+b+c)\mid \overline{abc}_{10}$. He also stops to define $\overline{abc}_{10} = 100a+10b+c$ *specifically to avoid confusion with* $abc = a\times b\times c$. In P2.6 he sets $n=2m$ rather than carry $n/2$ around — "little housekeeping things like this help a solution run smoothly" (p. 25). In P2.7, objective (a) is literally "Express the numerator as a mathematical expression, so that we can manipulate it."
- **Why it works.** You cannot apply an algebraic identity to an English sentence. Notation is the interface between the problem and your toolbox.
- **Failure mode — and this is the surprising one.** Formalizing does not guarantee tractability. Of the very formula he just wrote, Tao says: "In fact (1) is a horrendous thing to manipulate, even after one substitutes $100a+10b+c$ for $\overline{abc}_{10}$." And later, decisively: "we never even had to expand out $\overline{abc}_{10}$ algebraically as $100a+10b+c$; while that may have seemed like the logical first step, it turns out that it is sort of a red herring and does not make the problem any clearer to solve." (p. 13) **Write the formula; do not assume the obvious next algebraic step is progress.**

---

## Technique 3: Generate data and stare at it

- **What it is.** Compute instances. Make a table. Look for pattern, periodicity, or the *absence* of pattern.
- **When to reach for it.** Immediately, whenever you do not know what is going on.
- **Seen in action.** Every single problem in this chapter.
  - P2.1: he lists the actual solutions of $(a+b+c)\mid\overline{abc}_{10}$: $100, 102, 108, 110, 111, 112, 114, 117, 120, 126, \dots, 990, 999$.
  - P2.2: three successive tables — powers of 2, their digit sums, then their remainders mod 9. Each table is built *after* a conceptual reformulation, and each is the tool that reveals the next step.
  - P2.5: a 5-column table of $1^n,2^n,3^n,4^n$ and their sum mod 5, for $n=0..8$ — with the deliberate choice to "work out $1^n$, $2^n$, $3^n$, and $4^n$ (mod 5) individually before adding", because the periodicities are visible per-column and invisible in the sum alone.
  - P2.7: he evaluates the target sum for $p=5$, then $p=7$, then $p=11$.
- **Why it works.** Twice in this chapter a table is the *entire* proof strategy: the mod-9 table in P2.2 exposes period 6, and the mod-5 table in P2.5 *is* the case check once periodicity is proved.
- **Two refinements Tao demonstrates.**
  1. **Reuse the same example.** P2.7 returns to $p=5$ three separate times, once explicitly "so we can reuse some previous work" (p. 32). Cheaper, and lets you compare stages of the argument directly.
  2. **Read negative information too.** In P2.1 the data look "haphazard and random" — but they also "occur often enough so that any run of 18 consecutive numbers should have one." Density, not structure, was the usable signal.
  3. **Grade each example: does it verify, or does it explain?** This is the sharpest use of examples in the chapter, and it is visible because Tao computes *the same case twice at different stages*. At p. 29 the case $p=5$ mod 25 gives 1, 13, 17, 19 — opaque, and his verdict is "Perhaps it is a fluke." At p. 33 the case $p=5$ mod 5 gives 1, 3, 2, 4 — transparently a shuffle of $1,2,3,4$ — and his verdict is "**The way it works when $p=5$ shows the way for the general case.**" The operational test: *can you describe the intermediate numbers in words?* "A permutation of the nonzero residues" is a description you can turn into a proof; "1, 13, 17, 19" is not.
  4. **Choose the granularity of the table** so the cause is visible, not just the effect (P2.5: tabulate $1^n,2^n,3^n,4^n$ separately, not only the sum).
- **Failure mode.** Data can look flukey and stay flukey. P2.7, p. 29: after verifying $p=5$ and $p=7$ he says of the numbers 1, 13, 17, 19 that they "seem to be random, but 'magically' add up to the right amount. Perhaps it is a fluke." Verification is not explanation, and he says so.
- **Second failure mode — quantify how cheap an accidental match is.** In P2.2 the data *do* show matches, and Tao computes that this is expected: if 10 people pick random two-digit numbers there is a 9.5% chance of a collision, versus one in a million for 10-digit numbers. An invariant whose values are small collides by luck, so its collisions carry no information. **Before you take agreement as evidence, estimate the base rate of agreement.**

---

## Technique 4: Interrogate every constant in the problem statement

- **What it is.** Ask, for each specific number in the problem, *why that number?* The answer usually points at the mechanism.
- **Tao's own words.** "And what is the significance of the 18 anyway? Assuming it is not a red herring, (perhaps only 13 consecutive numbers are needed, but the 18 is there to throw you off the track) why have 18?" (p. 11)
- **Seen in action.** P2.1: 18 → related to 9 → digit sums are related to 9 → *therefore start looking for 9s everywhere*. This is the hinge of the whole solution: "Now that we are on the lookout for anything related to the number 9, we should notice that most numbers which actually do satisfy (1) are multiples of 9" (p. 12). He had already seen that data set once without noticing; the constant told him what to look for on the second pass.
- Elsewhere: P2.7's hypothesis "$p$ greater than 3" is unexplained for six pages, and turns out to be exactly what makes $(p-1)(2p-1)/6$ an integer at the very last step (p. 33). The chapter also shows the reverse: in P2.4, the constant 7 tempts you to work mod 7 — and mod 7 is a dead end.
- **Why it works.** Problem setters do not choose constants at random; the constant is a fingerprint of the intended mechanism. In P2.1 the choice of 18 over 9 even survives into the final solution: Tao argues you should use multiples of 18 partly *because* "if we use multiples of 9 to solve the problem, the question would only need 9 consecutive numbers instead of 18" (p. 12). The problem's own numbers told him which stepping stone was intended.
- **Failure mode.** A constant can be deliberate misdirection, and Tao says so in the same breath ("perhaps... the 18 is there to throw you off the track"). Treat the reading as a hypothesis.

---

## Technique 5: Stepping stones — insert an intermediate statement between hypothesis and goal

- **What it is.** When the given data and the desired conclusion have nothing in common, do not try to connect them directly. Find a third statement $B$ such that data $\Rightarrow B$ is easy *and* $B \Rightarrow$ goal is easy.
- **When to reach for it.** Tao's diagnostic: "consecutive numbers and divisibility do not mix. It seems that we have to reformulate the question or propose a related one to have a hope of solving it." (p. 11)
- **Tao's own words.** "This route seems to 'break the ice' between our data (18 consecutive numbers) and the objective (a number satisfying (1))... This 'stepping stone' approach is the best way to reconcile two unfriendly statements." (p. 12)
- **Seen in action.** P2.1. The book literally draws the chain as a diagram of three boxes joined by double arrows:

```
  ┌──────────────────────┐      ┌────────────────┐      ┌────────────────────┐
  │ 18 consecutive       │ ==>  │ a multiple     │ ==>  │ a solution to (1)  │
  │ numbers              │      │ of 18          │      │                    │
  └──────────────────────┘      └────────────────┘      └────────────────────┘
```

  Left arrow: any 18 consecutive integers contain exactly one multiple of 18 (obvious). Right arrow: every three-digit multiple of 18 is divisible by its digit sum (the thing to prove). Neither arrow mentions the other's vocabulary.
- **Why it works.** It is decomposition — the same reason you split a function into two. Each half can be attacked with tools appropriate to its own vocabulary.
- **Choosing *which* stepping stone.** This is the subtle part, and Tao spends a full page on it. His first candidate was "multiples of 9", justified on two grounds — "from numerical evidence, and the heuristic properties of the number 9". Then comes the upgrade, and *his exact assessment of the first stone matters*: "Now this particular stepping stone (considering multiples of 9) does work, but a bit of extra work is needed to cover all the cases. It is actually better to use multiples of 18." So the 9 stone is **not** broken — it is *valid but expensive*. He upgrades for two stated reasons:
  1. **Fit with the problem's numbers.** 18 consecutive numbers contain exactly one multiple of 18 but two multiples of 9. "It seems neater, and more appropriate, to use multiples of 18 than to use multiples of 9. After all, if we use multiples of 9 to solve the problem, the question would only need 9 consecutive numbers instead of 18."
  2. **A stronger hypothesis is easier to work with.** "It should be easier to prove (1) for multiples of 18 than for multiples of 9, since multiples of 18 are nothing more than a special case of multiples of 9. Indeed, it turns out that multiples of 9 do not always work (consider for instance 909), but multiples of 18 will, as we shall see."
- **Read the two claims apart — this is the trap.** The *stepping stone* "any 18 consecutive numbers contain a multiple of 9 that solves (1)" is **true**. The *convenient lemma* "every multiple of 9 solves (1)" is **false**: 909 is a multiple of 9, its digit sum is $9+0+9=18$, and $18 \nmid 909$. With the 9 stone you would therefore have to argue about *which* of the two available multiples of 9 works — the "extra work to cover all the cases" — whereas with the 18 stone the clean lemma "every multiple of 18 solves (1)" is true and the case analysis disappears. **A stepping stone can be reachable and sufficient and still be the wrong one, because the arrow out of it needs case-work that a slightly stronger stone would eliminate.**
- **Failure mode.** A badly chosen stone is unreachable from the data, or false, or — the common case — true but attached to a messy second arrow. Test the *second arrow's lemma* numerically before investing: had Tao written down 909 first, he would have skipped the 9 stone immediately.

---

## Technique 6: Prove something *stronger* because it is *simpler*

- **What it is.** Deliberately replace the goal with a more demanding claim that has less irrelevant structure attached.
- **Tao's own words (P2.2, p. 14).** "we have to simplify the problem by generalizing the digit-switching process. From a purely logical viewpoint we are worse off because we have to prove more: but in terms of clarity and simplicity we are gaining ground. (Why burden yourself with data that cannot be used? It will just be a distraction.)"
- **Seen in action.** P2.1: replacing "one of these 18 consecutive numbers" by "any multiple of 18". P2.2: replacing "digit-rearrangement of each other" by "same number of digits", then "same digit sum", then "same remainder mod 9" — each a *necessary condition* for the real relation. P2.7: replacing "the reduced numerator" with "the unreduced numerator".
- **Why it works.** Extra hypotheses are extra things you must carry and cannot use. A "clean" strong statement often has a short proof where the "true" weak statement has none. For a programmer: you are proving a more general lemma because the general lemma has fewer special cases to handle.
- **The logic you must get right.** In P2.2 the direction matters enormously. Every reformulation goes *original relation ⟹ weaker relation*. So a **"no" answer for the weaker question forces "no" for the original**; a "yes" answer tells you nothing. Tao flags exactly this: "Note that a 'yes' answer to this question does not necessarily yield a 'yes' answer to the original problem." (p. 15) His plan throughout is to prove the weakened question has answer *no*.
- **Note on Tao's wording.** On p. 13 he describes the P2.1 substitution as one "which was weaker, but simpler and more relevant to the question". Read "weaker" as *less informative about the original 18 numbers* — logically the claim "every multiple of 18 satisfies (1)" is a stronger claim, as he himself says one page later in P2.2 ("we have to prove more"). The tactical point is identical either way: trade logical economy for manipulability.
- **Failure mode: over-generalizing.** See Technique 7.

---

## Technique 7: Recognize over-generalization and pull back

- **What it is.** Each time you weaken a problem you may weaken it past the point of truth. When the weakened question's answer flips, you have gone too far — retreat one step and add back a *different* piece of information.
- **Tao's own words.** "We were too general." (p. 15) And the line worth memorizing: "This means that we have generalized too far and pushed our luck too much. Let us reel ourselves in again." (pp. 15–16)
- **Seen in action.** P2.2, in three beats:
  1. Weaken to "same number of digits". Answer: *yes* (2048 and 4096). Dead — but not worthless (see Technique 8).
  2. Reel in: find a second invariant (digit sum) and weaken to "same digit count *and* same digit sum". Still hard.
  3. Reel in again: mainstream digit sum into digit sum mod 9. Now it works.
- **The diagnostic he gives.** He compares against P2.1 to see what is missing: "Merely knowing 'the sum of digits of a multiple of 18 has to be a multiple of 9' is not sufficient to solve the problem: we also needed the fact that 'the sum of digits of a three-digit number is at most 27'. In short, we have not found enough facts about our problem to solve it." (p. 15) **When stuck, count your facts against a problem you already solved.**
- **Why it works.** Weakening is a dial, not a switch. The right setting is the weakest statement that is still *true*.
- **Failure mode.** Tao's own summary of the risk (p. 19): "there is always the danger of oversimplification, or mis-simplification (simplifying into a red herring)... There is a chance that maneuvering and simplifying may land you into a wild goose chase, but if you are really stuck anyway, anything is worth a try."

---

## Technique 8: Bank partial victories

- **What it is.** An approach that fails to finish may still shrink the problem permanently. Record the gain and keep it.
- **Tao's own words.** "A partial victory: only three or fewer suspects left to eliminate for each power of 2, instead of the infinite number we had before. Perhaps with a bit of extra work we can eliminate those suspects as well." (p. 15)
- **Seen in action.** P2.2: the failed "same digit count" reformulation nonetheless proves that at most four powers of 2 share a digit count — because the fifth consecutive power is 16 times the first and must therefore be longer. So each power of 2 has at most three candidate partners rather than infinitely many. In P2.4, factorization fails to solve the problem but yields "we do now know that $n$ must be odd" (p. 21).
- **Why it works.** Reducing an infinite search to a finite one is a qualitative change even when it is not a solution — exactly as in algorithms, where cutting an unbounded space to $O(1)$ candidates per item is the whole ballgame.
- **Failure mode.** Tao is honest that in P2.2 the partial victory was *not* enough on its own: "this lone property will not solve the problem on its own." Bank it, do not stop.

---

## Technique 9: Discard unusable data; hunt for invariants of the transformation

- **What it is.** When an operation is too complicated to describe exactly (here: rearranging digits), stop describing it and instead ask *what does it preserve?* Then work only with the preserved quantities.
- **When to reach for it.** The problem features a transformation with combinatorially many outcomes.
- **Seen in action.** P2.2 is one long invariant hunt. Tao's diagnosis of the difficulty: "(a) digit rearrangement has so many possibilities; (b) it is not easy to determine individual digits of a power of 2." His plan: "pick out the main properties of powers of 2 and digit-switching – hopefully, we will find properties of one that are incompatible with the other." The invariants he finds, in order:
  1. **Number of digits.** Discovered by a Socratic self-interrogation worth reproducing: could 4096 be rearranged into $2^{4256}$? "'Of course not!' you would say. Why? 'Because it's far too big!'. So, does size count? 'Yes—There would be thousands of digits in $2^{4256}$, and only four digits in 4096.' Aha—so rearranging digits cannot change the total number of digits." (p. 15) He extracted a usable theorem by asking himself why an obviously absurd case was absurd.
  2. **Set of digits** — rejected, see Technique 10.
  3. **Digit sum** — same set of digits forces the same digit sum.
  4. **Digit sum mod 9** — equivalently the number's own remainder mod 9.
- **Payoff.** "Note that the pesky notions of 'rearranging digits', 'set of digits', and 'sum of digits' have been completely eliminated, which looks promising." (p. 17) The final question mentions only digit *counts* and residues mod 9 — both standard number theory.
- **For a programmer.** This is exactly a loop invariant. You cannot reason about every path through the loop, so you find the property that survives every iteration and reason about that instead.
- **Supporting habit — hoard trivia.** "Write down any facts which could be of use to your problem, even if they are simple—do not assume that 'obvious' facts will always spring to mind when needed. Even shallowly dug gold has to be searched—and held on to." (p. 15) The digit-count invariant *is* trivial; it is also half the proof.

---

## Technique 10: Prefer "conventional weapons" — concepts with theorems attached

- **What it is.** Given two ways to encode the same information, pick the one that the rest of mathematics already knows how to handle.
- **Tao's own words.** "the 'set of digits' is not a very useful mathematical object (not many theorems and tools use this concept). However, the *sum of digits* is a more conventional weapon." (p. 16) And later, on why digit sum still is not good enough: "the only real way digit-sums can be successfully 'mainstreamed' is by considering the digit-sum modulo 9." (p. 17)
- **Seen in action.** P2.2's whole chain: set of digits (unusable) → digit sum (semi-usable) → digit sum mod 9 (fully usable). Also P2.6, where "$1+2+\cdots+n$" is discarded in favour of "$n(n+1)/2$" because divisibility arguments want products (Technique 13). Also P2.7, where the "numerator of a reduced fraction" — not a standard object at all — is converted into an algebraic expression.
- **Why it works.** Mathematical progress is largely about arriving at a representation for which someone has already built machinery. Choosing an unconventional encoding means you must reprove everything yourself.
- **Tao's own quality assessment of the intermediate step.** He does not pretend digit sums are great: "We mentioned earlier that 'set of digits' was unwieldy: now it seems that 'digit-sum' is not so flash either." (p. 17) The two-stage upgrade — first to something better, then to something good — is normal.
- **A related judgement call: macroscopic vs microscopic structure.** P2.2, p. 17: digit sums "have an easily appreciable macroscopic structure (slowly increasing with $n$; in fact it is highly probable (though not proven!) that the digit-sum of $2^n$ is approximately $(4.5\log_{10}2)n \approx 1.355n$ for large $n$) but a lousy microscopic structure. The digits just fluctuate too much." **Ask which scale your problem lives on.** Here the problem needed an exact match between two specific numbers — a microscopic question — so a quantity with only macroscopic structure could never settle it, and he moved on.
- **Related: heuristic plausibility checks.** Before committing, he estimates whether the approach *could* work. Digit sums are small (the digit sum of $2^{17}$ is only 14) and "small numbers are more likely to match than are big numbers. (If 10 people each randomly pick one two-digit number, there is a sizeable (9.5%) chance of a match, but if they each pick 10-digit numbers, then there is a one in a million chance of a match...)" (p. 16) He calls this "a small bit of bad luck" — the invariant he found is one whose collisions are common, which is bad if you are trying to rule collisions out. But he notes the compensation: "the smallness of the numbers also aids in picking out patterns."

---

## Technique 11: Guess the answer first

- **What it is.** For a yes/no question, commit to a guess before proving anything, using evidence *about the problem* rather than evidence *inside* it.
- **Tao's own words.** "The first sneaky thing to be done is to guess the answer. Circumstantial evidence (this problem is from a mathematics competition) suggests that this is not a trial-and-error question, and so the answer should probably be 'no'." (p. 14)
- **The full reasoning, which is a decision-theory argument, not a mathematical one.** "Guess the easy options first. If you are right, you have saved a lot of time by not pursuing the hard ways. If you are wrong, you were doomed to a long haul anyway. This does not mean that you should forget about a promising but hard way to solve the problem: but rather, to take a sensible look around before plunging into deep water." (p. 14)
- **Why it works.** Proving "no such object exists" and constructing "here is one" are completely different projects. Choosing the wrong one wastes all your effort. The expected-cost calculation above is genuinely sound: the cheap branch is worth trying first because its downside is bounded.
- **Failure mode.** He explicitly keeps the other branch alive — "some exceptionally ingenious construction could pull off a clever rearrangement of digits—but such a construction is probably not easy to find." A guess is a search-order heuristic, never a conclusion.

---

## Technique 12: Move everything into modular arithmetic

- **What it is.** Convert "$d$ divides $N$" into "$N = 0 \pmod d$", and then use the fact that mod arithmetic lets you replace any number by any other number congruent to it.
- **Tao's own words.** P2.6, p. 24: "using modular arithmetic (which is the most flexible way to prove that one number divides another)". P2.7, p. 28: "we have switched over to modular arithmetic, which is usually the best way to show that one number divides another."
- **When *not* to.** He supplies the exception in the same parenthesis: "However, if the question involves more than one divisibility, for example, something involving all divisors of a certain number, other techniques are sometimes better." (p. 28)
- **What it buys you (three distinct things, all used in this chapter).**
  1. **Substitution freedom.** You may replace $2m$ by $-1$ when working mod $2m+1$, or $p-j$ by $-j$ when working mod $p$. This is what makes cancellation possible (Technique 16).
  2. **Legal division.** $1/2$, $1/3$, $\dots$ become honest integers whenever the denominator is coprime to the modulus. Problem 2.7 is unthinkable without this.
  3. **Finiteness.** Infinitely many integers collapse to $n$ residues, so exhaustive checking becomes possible.
- **Failure mode.** In P2.1 he points out that a modular attack was *not* the right instrument: the formula $a+b+c \mid \overline{abc}_{10}$ "was not treated like typical mathematics (e.g. application of modular arithmetic), but instead we placed bounds on $a+b+c$" (p. 13). The default tool is not always the right one.

---

## Technique 13: Choose the modulus deliberately — first to annihilate, then to constrain

This is the most concretely useful technique in the chapter, and Tao lays it out as a systematic search.

- **The general strategy (P2.4, p. 21).** "With Diophantine equations, the most elementary methods are modular arithmetic and factorization. Modular arithmetic transfers the entire equation to a suitable modulus, sometimes constant (e.g. (mod 7), or (mod 16)) or sometimes variable (e.g. (mod $pq$))."
- **Step A — annihilate a term.** "The strategy is to use the modulus to get rid of one or more of the terms." (p. 21) For $2^n+7=x^2$ there are three terms, so there are three things to try:
  - kill $x^2$: work mod $x$, giving $2^n+7 = 0 \pmod x$;
  - kill the 7: work mod 7, giving $2^n = x^2 \pmod 7$;
  - kill $2^n$: work mod 2, giving $7 = x^2 \pmod 2$ (for $n>0$).
  He tries them in that order and reports failure on the first two. The third is the good one, found by the explicit question: "We tried eliminating the '7' and the '$x^2$' terms; can we eliminate the $2^n$ term instead?" (p. 22) **Enumerate the terms; try to kill each.**
- **Step B — constrain what is left.** Mod 2 kills $n$'s role almost entirely, but achieves nothing, "as the $x^2$ term on the right-hand side could be 0 or 1, so we have not really excluded any possibilities." The fix: "To restrict the values of $x^2$, we have to choose a different modulus. With this line of thought—to restrict the values on the right-hand-side—one now thinks to try modulus 4 instead of 2." (p. 22) Mod 4 still annihilates $2^n$ for $n>1$, *and* squares are restricted to $\{0,1\}$ mod 4. Both goals at once.
- **Why 4 and not 3 or 5.** Because 4 is a power of 2 (so it keeps killing $2^n$) *and* it is a modulus with respect to which squares are rigid. Choosing a modulus is choosing which of the equation's structures to expose.
- **Failure mode / the deeper lesson.** He explains retrospectively why mod 7 and mod $x$ were *guaranteed* to fail: "The main idea, when solving Diophantine equations of the form 'find all solutions', is to eliminate all but a finite number of possibilities. This is another reason why the (mod 7) and (mod $x$) would not work; for if they did, they would have eliminated all the cases, unlike the (mod 4) approach, which eliminated all but a handful." (p. 22) **If the problem has solutions, no single congruence can rule everything out — so aim for a modulus that leaves survivors you can check by hand.** This is a genuinely predictive criterion: before computing, ask "would success here prove too much?"

---

## Technique 14: Periodicity — check one period instead of all values

- **What it is.** A quantity like $a^n \bmod m$, viewed as a function of $n$, must eventually repeat, because there are only finitely many residues. Prove the period, then verify the statement for one period only.
- **Tao's own words.** "Whenever trying to prove equations involving a parameter (in this case $n$), periodicity is always handy, as one no longer needs to check all values of the parameter to verify the equation. Checking one period (e.g. $n=0,1,2$, and 3) will be sufficient." (p. 24)
- **How he proves a period — "just fiddle with the definition".** Period 4 for $3^n$ mod 5 *means* $3^{n+4} = 3^n \pmod 5$. And $3^{n+4} = 3^n \times 81 = 3^n \pmod 5$ because $81 = 1 \pmod 5$. That is the entire proof. Likewise in P2.2: $2^{n+6} = 2^n 2^6 = 2^n \times 64 = 2^n \pmod 9$ because $64 = 1 \pmod 9$. **Find a $T$ with $a^T = 1$ modulo your modulus, and $T$ is a period.**
- **Seen in action.** P2.5 (period 4 mod 5, reducing infinitely many $n$ to four cases already in the table). P2.2 (period 6 mod 9 — used not to check cases but to prove a *spacing* result: two powers of 2 with equal residue mod 9 must be at least six apart).
- **The combination move in P2.2 is worth isolating:** periodicity gives a lower bound on the *gap* between two matching indices; a growth estimate then converts that gap into an impossibility. Period 6 ⟹ indices differ by $\ge 6$ ⟹ one number is $\ge 64$ times the other ⟹ they cannot have the same digit count. **Periodicity + growth rate = contradiction.**
- **For a programmer.** The residue sequence is a finite state machine with a deterministic transition (multiply by $a$), so it must enter a cycle; you are just detecting the cycle and then unit-testing one lap.

---

## Technique 15: Factorization into (factor) × (factor) = something rigid

- **What it is.** Rearrange a Diophantine equation so one side is a product and the other is a number with very few factorizations. Then enumerate.
- **Tao's own words.** "Factorization alters the problem into the form (factor) $\times$ (factor) = (something nice), where the right-hand side could be a constant (the best possible result), a prime, a square, or something else that has a limited choice of factors." (p. 21)
- **Seen in action.** P2.4, when $n=2m$ is even:
  $$7 = x^2 - 2^n = (x-2^m)(x+2^m).$$
  Since 7 is prime, its only integer factorizations are $1\times7$, $7\times1$, $(-1)\times(-7)$, $(-7)\times(-1)$ — so $x-2^m$ and $x+2^m$ "must be $-7, -1, 1$, or 7", and a short case check kills them all. Also P2.4's use of the difference of two squares, "a vital factorization in Diophantine equations".
- **Why it works.** Integer factorizations of a fixed number are finite; that is the only real leverage the integers give you over the reals.
- **Failure mode / what it does *not* buy you.** "But that is about as much as the factorization method can tell us; it does not tell us where the actual solutions are and how many of them there are." (p. 21) It settles a sub-case (even $n$) and hands you a partial victory (so $n$ is odd), no more.
- **The disguised version.** Tao points out that Problem 2.3's quadratic-formula manoeuvre "is actually a factorization technique in disguise (remember we eventually got $(n-2)^2-4 = $ (square)?)" (p. 21) — you are asking for the factorizations of a *difference of squares* $(n-2)^2 - k^2 = 4$.

---

## Technique 16: Symmetry, anti-symmetry, and pairwise cancellation

- **What it is.** In a sum running over a full range of residues, rewrite the top half as negatives of the bottom half. If the summand is odd (anti-symmetric), the terms cancel in pairs and the sum vanishes.
- **Seen in action.** P2.6, mod $2m+1$: since $2m = -1$, $2m-1 = -2$, ..., the sum $1^k+2^k+\cdots+(2m)^k$ becomes
  $$1^k+2^k+\cdots+m^k+(-m)^k+\cdots+(-2)^k+(-1)^k \pmod{2m+1}.$$
  Because $k$ is **odd**, $(-a)^k = -a^k$, so $2^k$ cancels $(-2)^k$, $3^k$ cancels $(-3)^k$, and everything collapses to 0. "We have done this so that we can do some nice cancelling." (p. 25)
- **Also.** P2.7's second proof of (7): rewrite $1/(p-1)$ as $1/(-1)$, $1/(p-2)$ as $1/(-2)$, and pair off. He notes the parity check: "there is no 'middle term' that does not pair off, as $p$ is an odd prime". P2.5's aside: for odd $n$, $1^n+2^n+3^n+4^n$ can be handled by "simply pair up and cancel terms" without any periodicity argument, since $4 = -1$ and $3 = -2$ mod 5.
- **The polarity rule, stated explicitly (P2.7, p. 32).** "Symmetry is nice to keep—until it can be used to its full effect—while anti-symmetry, is nice to cancel." Anti-symmetric sums collapse; symmetric sums should be *kept and exploited*, e.g. by "doubling up".
- **Doubling up (the reverse move).** In P2.7 the surviving sum $1/1^2+\cdots+1/((p-1)/2)^2$ "ends in an obscure spot". Using $(-a)^2 = a^2$ he writes it as one half of the sum over the *full* range $1$ to $p-1$ — deliberately making the expression bigger to make it *tidier*, and tidiness is what lets him apply the closed-form formula later.
- **Failure mode, stated twice.**
  - When $k$ is even the trick dies. Exercise 2.6's hint: "since $k$ could be even, we cannot always use the cancelling trick."
  - When the range has a middle term. P2.6, mod $m$ with $m=2p$ even: "there is a middle term, $p^k$, which does not cancel with anything." (p. 26) He does not abandon the method — he computes what *does* survive, gets $2p^k \pmod{2p}$, and observes that this "is, of course, equal to 0" anyway. **When cancellation leaves a residue, compute the residue; it may still be zero.**
  - When the summand is symmetric rather than anti-symmetric. P2.7, p. 32: cancellation of pairs fails on (8) "mainly because of the squares in the denominators, which produce symmetry rather than anti-symmetry."

---

## Technique 17: Split a composite divisor into coprime factors

- **What it is.** To show $d_1 d_2 \mid N$ where $\gcd(d_1,d_2)=1$, show $d_1 \mid N$ and $d_2 \mid N$ separately.
- **Tao's own words (P2.6, p. 25).** Having reached the shape "(factor 1) $\times$ (factor 2) | (expression)": "If the two factors are coprime, then our objective is equivalent to proving both of (factor 1)|(expression) and (factor 2)|(expression) separately. This should be simpler to prove: it is easier to prove divisibility if the divisors are smaller."
- **The coprimality condition is essential, and here is why in one example.** $6 = 2\times3$ with $\gcd(2,3)=1$: indeed $6\mid N \iff 2\mid N$ and $3 \mid N$. But $4 = 2\times2$ is not coprime-split: $2\mid 2$ and $2 \mid 2$, yet $4 \nmid 2$. In P2.6 the split is $m(2m+1)$, and $\gcd(m, 2m+1)=1$ because any common divisor also divides $(2m+1) - 2m = 1$.
- **Seen in action.** P2.6: prove $1^k+\cdots+(2m)^k = 0 \pmod{2m+1}$ and $= 0 \pmod m$, by two different arguments. The two halves genuinely need different treatments — the first is a clean anti-symmetric cancellation, the second needs a further parity case split.
- **Why it works.** Smaller moduli mean smaller sums to manipulate and more terms that reduce to 0. It is divide-and-conquer.
- **Handling the leftover "/2".** The divisor is $n(n+1)/2$, which is not literally a product of two integers until you know the parity of $n$. Tao's fix: "To deal with that we will just break up into cases, depending on whether $n$ is even or odd." Plus a footnoted alternative: "Another way is to multiply both sides by 2, so that we now want to prove $2(1^k+2^k+\cdots+n^k) = 0 \pmod{n(n+1)}$. This ends up being more or less equivalent."

---

## Technique 18: Choose the representation that suits the goal

- **What it is.** The same object usually has several formulas. Pick by what you intend to *do* with it, not by beauty.
- **Tao's own words (P2.6, p. 24).** On whether to write the divisor as $1+2+\cdots+n$ or $n(n+1)/2$: "The former is more aesthetic, but a bit useless in a divisibility question. (It is always easier if the divisor is expressed as a product, rather than a sum.)"
- **Seen in action.** P2.6 (product form chosen so the coprime split of Technique 17 becomes available). P2.7 (the "numerator of a reduced fraction" rewritten first as an explicit sum of products, then as $\sum (p-1)!/i$, then factored as $(p-1)!\sum 1/i$ — three representations of one quantity, each unlocking a different move). P2.2 (four successive representations of the digit relation).
- **Why it works.** Divisibility arguments consume products; summation formulas consume sums; modular arguments consume residues. Matching representation to tool is most of the work.

---

## Technique 19: Turn messiness to advantage — the quadratic-formula / discriminant trick

- **What it is.** Solve an integer equation as if it were a real quadratic. The formula contains $\sqrt{\text{discriminant}}$; since the answer must be an integer, **the discriminant must be a perfect square**. That is often a brutally restrictive condition.
- **Tao's own words (P2.3, p. 20).** "This looks very messy, but actually we can turn this messiness to our advantage. We know that $a$, $b$, and $n$ are integers, but there is a square root in the formula. Now this can only work if the term inside the square root, $(n-2)^2-4$, is a perfect square."
- **Seen in action.** P2.3, in full. $(a+b)^2 = nab$ expands to $a^2 + (2-n)ab + b^2 = 0$; treating this as a quadratic in $a$ gives
  $$a = \frac{b}{2}\Big[(n-2) \pm \sqrt{(n-2)^2-4}\Big].$$
  Requirement: $(n-2)^2 - 4$ is a perfect square, i.e. "4 less than a square is a square." Then the growth argument: "Because the gaps between the squares get higher than 4 after the first few squares, we only need to test low numbers of $n$." The squares are $0,1,4,9,16,25,\dots$ with gaps $1,3,5,7,9,\dots$; only the pair $(0,4)$ differs by exactly 4. So $(n-2)^2 = 4$, giving $n = 0$ or $n = 4$.
- **Why it works.** It converts a two-variable integer problem into a one-variable integer problem about squares, and squares are rigid.
- **Tao's honest verdict / failure mode.** "our answer was $n=4$, but it was obtained by the rather inelegant method of the quadratic formula. Using it is usually clumsy, but as it introduces a square root term, which implies that the term inside the square root must be a perfect square, it occasionally comes in useful." (p. 20) It is a tool of last resort that you should nonetheless know.

---

## Technique 20: Reduce the strength of what you must prove

- **What it is.** Divisibility by $p^2$ is far harder than divisibility by $p$. If you can factor a $p$ out of the expression by hand, the remaining task drops a whole power.
- **Tao's own words (P2.7, p. 27, as a stated objective).** "Aim to reduce the problem from a $p^2$-divisiblity problem to something simpler, perhaps a $p$-divisibility problem."
- **The mechanism (p. 31).** Instead of proving (expression) $= 0 \pmod{p^2}$, arrange the expression as $p \times$ (something), because
  $$p \times \text{expression} = 0 \pmod{p^2} \iff \text{expression} = 0 \pmod{p}.$$
- **Seen in action.** P2.7: pairing $1/j$ with $1/(p-j)$ gives $1/j + 1/(p-j) = p/(j(p-j))$ — every pair manufactures a factor of $p$. So the whole sum equals $p$ times a new sum, and the target modulus halves in exponent.
- **The judgement call, stated explicitly.** "Now this, at first, looks like a complication rather than a simplification. But we have gained a very important factor of $p$." And: "we are now reduced to a (mod $p$) question instead of a (mod $p^2$) question... reduced the question to that of a smaller modulus, which is well worth the slight increase in complexity." Then the twist: "the apparent increase in expression complexity is just illusionary, as the (mod $p$) can get rid of a lot more terms than (mod $p^2$) can." (p. 31)
- **Transferable form.** *Accept a uglier expression in exchange for a weaker obligation.* The expression is something you control; the obligation is something you must satisfy.

---

## Technique 21: Solve the easier analogue first — and reject a proof that will not generalize

- **What it is.** Two moves that belong together. First: attack a strictly easier version of the problem, to learn the mechanism. Second: if the easy version's proof is too special, *throw it away and find another proof of the same easy statement* — one built to scale.
- **Tao's own words on the first move (P2.7, p. 29).** Having failed to see why the mod-$p^2$ identity works, he drops to mod $p$: "If nothing else, it will give us something to do. (Besides, if we can not solve this (mod $p$) problem, there is no way that we will be able to solve the (mod $p^2$) problem.)" The parenthesis is a triage argument: the easy version is a *necessary* milestone, so time spent on it is never wasted.
- **Tao's own words on the second move (P2.7, p. 30).** The rearrangement proof of (7) "works neatly for (mod $p$), but it does not generalize easily to (mod $p^2$). Instead of floundering around trying to fit a square block into a round hole (although it can be done if you push hard enough), it is better to find a block that is more round. So what we have to do now is find another proof of the fact that $1/1+1/2+\cdots+1/(p-1) = 0 \pmod p$; one that generalizes, at least partially, to the (mod $p^2$) case."
- **This is a genuinely counter-intuitive instruction.** He has a *correct, complete, short* proof and discards it, because its mechanism is a dead end. **A proof's value includes its extensibility, not just its validity.** In software terms: the working solution with no path to the next requirement is technical debt.
- **How he finds the replacement.** "Now it is time to use experience with these sorts of problems. For example, if we are fresh from solving Problem 2.6, we know that symmetry, or anti-symmetry can be exploited, especially in modular arithmetic." (p. 30) — i.e. he searches his *recent* toolbox, deliberately, by name.
- **Payoff.** Two proofs of (7) exist (rearrangement; pairwise cancellation). When he reaches the harder identity (8), he checks both against it: cancellation now fails (squares are symmetric, not anti-symmetric) but rearrangement works. **Having two proofs of a lemma means having two tools for the next lemma.**

---

## Technique 22: Audit every reformulation for logical validity

- **What it is.** Each time you swap object A for object B, stop and prove that a result about B really does give you a result about A.
- **Seen in action — three careful audits in P2.7 alone.**
  1. **Unreduced vs reduced numerator (p. 27).** He can easily write down *a* numerator (over the common denominator $(p-1)!$), but the problem asks about the *reduced* one. His check: reducing means cancelling with the denominator; that could only destroy $p^2$-divisibility if a factor of $p$ were cancelled; but $(p-1)!$ is coprime to $p$, so no factor of $p$ can ever cancel. "Aha! This means that we only need to prove that the ugly-looking numerator above is divisible by $p^2$."
  2. **Dividing out a factor in modular arithmetic (p. 28).** From $(p-1)!\big[\sum 1/i\big] = 0 \pmod {p^2}$ he wants $\sum 1/i = 0 \pmod{p^2}$. "If it were not for the modular arithmetic, then we could quickly say that one of the factors is 0. With modular arithmetic, we can say nearly the same thing, but we have to be careful. Luckily, the first factor, $(p-1)!$, is coprime to $p^2$... so we can divide it out." (Why care: mod 12, $3\times4 = 0$ though neither factor is 0. Coprimality to the modulus is exactly what licenses cancellation.)
  3. **Noticing you have arrived somewhere suspiciously familiar (p. 28–29).** The reduced target looks almost identical to the original question. He flags it: "Note that this looks very similar to our original question, the only difference being that we are considering the entire fraction, not just the numerator of it. But one cannot just jump from one form to another without care. The above complications were necessary."
- **Why it matters.** These reformulations are where wrong proofs come from. In a long chain of "it suffices to show...", one invalid link destroys everything downstream.

---

## Technique 23: Spiral, not circle

- **What it is.** A self-check. When your new goal resembles a goal you already had, decide whether you have looped (bad) or descended (good).
- **Tao's own words (P2.7, p. 32).** "But we are not going around in circles. Our current goal (8) will imply the original question, whereas (7) was just a side-problem, a simpler version of the question. Rather than going around in circles, we are going around in spirals, heading towards a solution."
- **The test he applies.** For each statement in your chain, ask: *does proving this actually imply the original?* (8) does; (7) did not — (7) was reconnaissance. Both were worth doing, but only one is load-bearing. **Track which of your intermediate results are on the critical path and which are exploration.**
- **Related discipline.** P2.3, p. 20: "One thing to keep in mind when problem-solving is to be prepared to abandon temporarily one interesting—but fruitless—approach and try a more promising one. One could try algebra to attack the problem, then re-apply number theory later if algebra failed to work." Note *temporarily* and *re-apply* — abandonment is a scheduling decision, not a deletion.
- **And the closing statement of the whole method (P2.7, p. 33).** "So that is it. We keep reducing the equation to simpler and simpler formulations, until it just collapses into nothing. A bit of a long haul, but sometimes it is the only way to resolve these very complicated questions: step-by-step reduction."

---

## Technique 24: Read the question type, and set tactical objectives from its shape

- **What it is.** Before mathematics, classify. "Prove that X" / "Find all X" / "Show there exists X" / "Is there an X?" have different difficulty profiles and different winning strategies.
- **Tao's own words (P2.7, p. 27).** "This question is a 'Prove that' question, not a 'Find a' or 'Show there exists' question, so it should not be completely impossible." A "prove that" question comes with a guarantee that the statement is true — you are being handed the answer and asked for the reason.
- **And then, from the shape of the statement, an explicit plan (p. 27).** "So by looking at the shape of the question, we have the following objectives to keep in mind: (a) Express the numerator as a mathematical expression, so that we can manipulate it. (b) Aim to reduce the problem from a $p^2$-divisiblity problem to something simpler, perhaps a $p$-divisibility problem." He then spends six pages executing exactly those two objectives, and announces when each is achieved ("Now we have achieved objective (b)", p. 31; "we have achieved all our tactical goals", p. 32).
- **Other type-readings in the chapter.**
  - "Find all solutions" (P2.4) ⟹ the goal is to *eliminate all but finitely many possibilities* (p. 22).
  - "Is there...?" (P2.2) ⟹ guess yes/no first (Technique 11).
  - "Show that among any 18..." (P2.1) ⟹ existence within a range, so a stepping stone that pins down *which* member of the range is natural.
  - A superficially frightening equation (P2.5) ⟹ check whether the difficulty is real: "equations like the above may remind one of Fermat's last theorem, which is notorious for its insolvability. But our question is much milder." (p. 23)
  - **Genre-level readings, one scale up from the individual question.** *(a)* Which *kind of object* is the problem about? Tao's own sectioning answers this — digits, or a Diophantine equation, or a sum of powers — and each section opens by naming its toolkit (see the map at the top of this file). *(b)* Is the object itself a serious one? Digit-summing "is not particularly important" in higher mathematics and is "quite popular in recreational mathematics"; that alone predicts the digits will be traded away. *(c)* Which problem does this one most resemble? "A special type of 'sums of powers' problem, namely sums of reciprocals" (p. 26) is the label that makes Problem 2.6's toolbox retrievable on p. 30. *(d)* And the anti-rule: genre does **not** determine difficulty. "Diophantine problems can get extremely difficult when one of the variables appears in the exponent; the most notorious of these is Fermat's last theorem... Fortunately, there are other problems involving exponents which are easier to handle." (p. 20)
- **Why it works.** Writing down two objectives converts an open-ended struggle into a checklist. This is the closest thing in the chapter to a project plan, and it appears on the hardest problem.
- **How to generate the objectives, mechanically (p. 27).** Tao's list is not inspired; it is produced by a rule. He names each thing that makes the problem hard, and immediately writes the corresponding wish. Hard thing (i): "a numerator of a reduced fraction—not something easily dealt with!" → wish: "This numerator will need to be transformed into something more standard, like an algebraic expression." Hard thing (ii): "divisibility by the square of a prime... significantly harder" → wish: "We would like to somehow reduce the problem to mere prime divisibility." The two wishes *are* objectives (a) and (b). **List your obstacles; negate each one; that is your plan.**

---

## Technique 25: Try elementary tools first; look for the lazy way; do not reach for sledgehammers

- **Tao's own words (P2.4, p. 21).** "Now it is best to try elementary techniques first, as it may save a lot of dashing about in circles later." And, about the analytic approach via $x = \sqrt{2^n+7} \approx 2^{n/2}$, which leads to "continued fractions, Pell's equation, and recursion relations": "It can be done; but we will look for the elegant (i.e. lazy) way out."
- **Also (P2.6, p. 24).** The problem "is a standard exercise in Bernoulli polynomials (or some astute applications of the Remainder Theorem)... But without the sledgehammer of Bernoulli polynomials (or the Riemann $\zeta$ function) we will just have to use plain old number theory."
- **Why it works.** Elementary tools are cheap to try and cheap to abandon. And "elegant" and "lazy" really are the same thing here: the shortest path is usually the one with the fewest moving parts.
- **Failure mode.** Sometimes the heavy road is the only road — Tao says of the analytic approach "It can be done", and of Lagrange's four-squares theorem that it genuinely needs Gaussian integers (p. 9). The instruction is about *ordering* your attempts, not about refusing hard tools forever.

---
---

# Worked problems

> Notation used below: $\overline{abc}_{10}$ means the three-digit number with digits $a,b,c$, i.e. $100a+10b+c$ — as opposed to $abc$, which would mean the product $a\times b\times c$. Tao introduces this convention on p. 11 precisely to avoid the confusion.

## Problem 2.1 (p. 11; source: Taylor 1989, p. 7) — Among any 18 consecutive three-digit numbers, at least one is divisible by the sum of its own digits

*Example to fix ideas: 216 has digit sum $2+1+6=9$, and $216 = 9\times 24$, so 216 is such a number. The claim is that you cannot walk 18 steps along the three-digit numbers without stepping on one.*

**How Tao introduces it, and why that is a hint (pp. 10–11).** This is the first problem of section 2.1, "Digits", and he prefaces it by explicitly downgrading the whole topic: digit-summing "is not particularly important" in higher mathematics — "it has proven far more effective to study numbers directly, rather than via their digit expansion" — "but it is quite popular in recreational mathematics and has even been given mystical connotations by some! Certainly, digit summing appears fairly often in mathematics competition problems, **such as this one**." `[read the genre of the problem]` Two predictions follow before you have done any work: (i) the digits are probably not the mechanism, so expect to trade them for something else; (ii) the problem is a competition problem, so a short solution exists.

**The data / the objective (Tao's framing).** Data: 18 consecutive three-digit numbers. Objective: one of them satisfies $(a+b+c)\mid \overline{abc}_{10}$, labelled equation (1). Tao's opening observation is that this is a *finite* problem — "there are only 900 or so three-digit numbers" — so brute force is available in principle, "But let us see if we can save ourselves some work."

**The chain of moves.**

1. Note finiteness; decide to look for a shortcut anyway. `[size up the search space]`
2. Note that "the objective looks a little weird", and formalize it: write the number as $\overline{abc}_{10}$, define the notation to avoid ambiguity with $a\times b\times c$, and state the goal as $(a+b+c)\mid \overline{abc}_{10}$. `[translate the objective into a formula]` `[notation hygiene]`
3. **Dead end.** Try to simplify (1) into "a useful equation connecting $a$, $b$, and $c$ directly". Verdict: "it is not simplifiable to anything halfway decent... In fact (1) is a horrendous thing to manipulate, even after one substitutes $100a+10b+c$." Abandoned. `[try to simplify; abandon if it does not]`
4. Generate the data: list the numbers satisfying (1) — $100, 102, 108, 110, 111, 112, 114, 117, 120, 126, \dots, 990, 999$. `[generate data]`
5. Read the data twice, for two different signals. Structure: "They seem to be haphazard and random." Density: "However, they do seem to occur often enough so that any run of 18 consecutive numbers should have one." The second reading is the useful one. `[read negative information too]`
6. Interrogate the constant: "what is the significance of the 18 anyway?" Consider that it might be padding ("perhaps only 13 consecutive numbers are needed, but the 18 is there to throw you off the track"), but proceed on the assumption it is meaningful. Chain of association: digit sums are related to 9 (a number has the same remainder as its digit sum on division by 9); 18 is related to 9; "so there could be a vague connection." `[interrogate the constants]`
7. Diagnose the structural mismatch: "consecutive numbers and divisibility do not mix. It seems that we have to reformulate the question or propose a related one to have a hope of solving it." `[recognize that data and goal do not mix]`
8. Re-examine the data *with 9 in mind* — and now see what was invisible before: almost every solution is a multiple of 9, or at least of 3. "In fact there are only three exceptions on the list above (100, 110, and 112), and practically all of the multiples of 9 satisfy (1)." `[generate data + interrogate constants, combined]`
9. Replace the goal with a stepping stone. Instead of *"For any 18 consecutive numbers, at least one solves (1)"*, aim for *"For any 18 consecutive numbers, there is a multiple of 9 which solves (1)."* Justification: 18 consecutive numbers always contain a multiple of 9 (in fact two), and numerical evidence says multiples of 9 satisfy (1). "This route seems to 'break the ice' between our data and the objective." `[stepping stone]`
10. **Refine the stepping stone from 9 to 18.** First his verdict on the 9 stone, which is *not* a rejection: "Now this particular stepping stone (considering multiples of 9) does work, but a bit of extra work is needed to cover all the cases. It is actually better to use multiples of 18." Then the two stated reasons for the change:
    - *Fit with the problem's own constants.* 18 consecutive numbers contain exactly one multiple of 18 but two multiples of 9 — "It seems neater, and more appropriate, to use multiples of 18 than to use multiples of 9. After all, if we use multiples of 9 to solve the problem, the question would only need 9 consecutive numbers instead of 18."
    - *A stronger hypothesis is easier to use.* Multiples of 18 are a special case of multiples of 9, so proving (1) for them is easier — "Indeed, it turns out that multiples of 9 do not always work (consider for instance 909), but multiples of 18 will, as we shall see." *(909: digit sum $9+0+9=18$, and $18\nmid 909$. So the clean lemma "every multiple of 9 solves (1)" is false; the stepping-stone statement "some multiple of 9 in the run solves (1)" is still true, but proving it means arguing about which of the two available multiples works — that is the "extra work to cover all the cases" he is buying his way out of.)* `[prove something stronger because it is simpler]` `[judge a stepping stone by its second arrow]`
11. The final chain, drawn in the book as three boxes: `18 consecutive numbers ⟹ a multiple of 18 ⟹ a solution to (1)`.
12. Experiment on the second arrow. 216 is a multiple of 18, digit sum 9, and $9\mid216$ because $18\mid216$. 882 is a multiple of 18, digit sum 18, so divisibility is immediate. "Messing around with a few more examples shows that the sum of digits of a multiple of 18 is always 9 or 18, which divides the original number almost by default." `[generate data to form the key conjecture]`

**The resolution (Tao's proof, p. 13, expanded).**

Take any 18 consecutive three-digit numbers. Exactly one is a multiple of 18; call it $N = \overline{abc}_{10}$.

- Since $18 \mid N$ and $9 \mid 18$, we have $9 \mid N$.
- By the digit-sum rule, $9 \mid N$ forces $9 \mid (a+b+c)$. *(Why: $10 \equiv 1 \pmod 9$, so $N = 100a+10b+c \equiv a+b+c \pmod 9$.)*
- Now **bound** the digit sum instead of solving anything. Three digits, each at most 9, and $N \ge 100$ so not all digits are 0: therefore $1 \le a+b+c \le 27$. Combined with "$a+b+c$ is a multiple of 9", the only options are $a+b+c \in \{9, 18, 27\}$. `[bound instead of solve]`
- Eliminate 27: the only three-digit number with digit sum 27 is 999, and 999 is not a multiple of 18 ($999 = 18\times55.5$). So $a+b+c \in \{9,18\}$.
- Both 9 and 18 divide 18. So $(a+b+c) \mid 18$. And $18 \mid N$ by construction. Divisibility is transitive, so $(a+b+c)\mid N$. $\square$

*Transitivity check for the reader: if $18 = (a+b+c)\cdot s$ and $N = 18 t$, then $N = (a+b+c)\cdot st$.*

**Tao's own moral (p. 13), in three parts.**

1. > "Remember that with questions involving things like digits, a direct approach is not usually the answer. A cumbersome formula should be simplified into something more manageable."

   And then, naming the exact substitution and grading it: > "In this case, the phrase 'one number out of any 18 consecutive numbers must be' was replaced by 'any multiple of 18 must be' which was weaker, but simpler and more relevant to the question (which was related to divisibility). **It turned out to be a good guess, though.**"

   That last sentence is worth pausing on. Tao classifies his own central reformulation as a **guess** — it was not derived, it was gambled on, on the strength of a numerical pattern and a hunch about the number 9, and it happened to pay. Reformulation is not a deductive step; it is a bet whose expected value you estimate and whose outcome you then have to verify.
2. Finite problems reward different instincts: > "with finite problems, the strategies are not like those in higher mathematics." The formula $a+b+c \mid \overline{abc}_{10}$ "was not treated like typical mathematics (e.g. application of modular arithmetic), but instead we placed bounds on $a+b+c$ (9, 18, or 27) due to the fact that all numbers had only three digits, leaving us with the much simpler $9\mid\overline{abc}_{10}$, $18\mid\overline{abc}_{10}$, or $27\mid\overline{abc}_{10}$."
3. The obvious first step was a trap: > "we never even had to expand out $\overline{abc}_{10}$ algebraically as $100a+10b+c$; while that may have seemed like the logical first step, it turns out that it is sort of a red herring and does not make the problem any clearer to solve."

**A final aside worth copying (p. 13).** 18 is optimal — 17 consecutive numbers can fail, e.g. the run 559 to 575. And he tells you how he knows: "(I used a computer for that, not some tricky mathematics.)" Then: "Of course, one does not need to know this fact in order to solve the problem." **Two lessons: computation is a legitimate way to learn facts about a problem; and know which facts are load-bearing and which are just satisfying.**

**Transferable lesson.** When the hypothesis and the conclusion share no vocabulary, do not force a connection — manufacture a middle statement that each side can reach. And when a quantity is confined to a small range, *enumerate the range* instead of solving the equation.

---

## Exercise 2.1 (pp. 13–14) — The parlour-game magician

**Statement.** A "magician" asks a participant to think of a three-digit number $\overline{abc}_{10}$. The magician then asks for the sum of the five *other* arrangements of those digits — $\overline{acb}_{10}, \overline{bac}_{10}, \overline{bca}_{10}, \overline{cab}_{10}, \overline{cba}_{10}$ — and is told the sum is 3194. What was the original number?

**Tao's hint (all he supplies).** "Get a better expression for the sum of the five numbers, something more mathematical. Then use modular arithmetic to get some bounds on $a$, $b$, and $c$."

**The chain of moves** *(the hint is Tao's; the execution below is my working-out, not the book's text)*.

1. `[translate the objective into a formula]` Sum all **six** arrangements. Each of $a,b,c$ appears exactly twice in the hundreds place, twice in the tens, twice in the units, so the six-fold sum is $2(100+10+1)(a+b+c) = 222(a+b+c)$. Let $s = a+b+c$ and let $N$ be the original number. Then the five-fold sum is
   $$222s - N = 3194, \qquad\text{i.e.}\qquad N = 222s - 3194.$$
   This is the "something more mathematical": one clean equation replacing five unknown permutations. `[prefer conventional weapons]`
2. `[bound instead of solve]` $N$ is a three-digit number, so $100 \le 222s - 3194 \le 999$, giving $3294 \le 222s \le 4193$, i.e. $14.8 \le s \le 18.9$. So $s \in \{15,16,17,18\}$.
3. `[move to modular arithmetic]` Use the digit-sum rule: $N \equiv s \pmod 9$. Substituting $N = 222s-3194$ and reducing ($222 \equiv 6$, $3194 \equiv 3+1+9+4 = 17 \equiv 8$, both mod 9):
   $$6s - 8 \equiv s \pmod 9 \implies 5s \equiv 8 \pmod 9 \implies 10s \equiv 16 \pmod 9 \implies s \equiv 7 \pmod 9.$$
   *(Multiplying by 2 is legal because 2 is coprime to 9; and $10s \equiv s$.)*
4. Intersect the two constraints: the only $s$ in $\{15,\dots,18\}$ with $s \equiv 7 \pmod 9$ is $s = 16$.
5. Therefore $N = 222\times16 - 3194 = 3552 - 3194 = \mathbf{358}$.

**Verification.** $3+5+8=16$ ✓. The five other arrangements are 385, 538, 583, 835, 853, and $385+538+583+835+853 = 3194$ ✓.

**Transferable lesson.** Exactly the Problem 2.1 pattern: get one equation, bound the unknown by size, cut the survivors with a congruence, check the single candidate. Two weak constraints (a range and a residue) intersect to a unique answer — neither alone would do. This is the "eliminate all but finitely many, then check" recipe of Technique 13 in miniature.

---

## Problem 2.2 (p. 14; source: Taylor 1989, p. 37) — Can the digits of one power of 2 be rearranged into another power of 2?

*Restated: is there a pair of powers of 2, say $2^i$ and $2^j$ with $i \ne j$, such that one is a digit-permutation of the other? (Leading zeros forbidden: 0032 does not count as a rearrangement of 3200.) For instance 4096 has digits $\{4,0,9,6\}$; is any arrangement of those four digits also a power of 2?*

**The data / the objective (Tao's framing).** He opens by diagnosing why this looks hopeless: "This seems like an unsolvable combination: powers of 2, and digit rearranging. This is because (a) digit rearrangement has so many possibilities; (b) it is not easy to determine individual digits of a power of 2. This probably means that something sneaky is needed."

**The chain of moves.**

1. `[guess the answer first]` "The first sneaky thing to be done is to guess the answer. Circumstantial evidence (this problem is from a mathematics competition) suggests that this is not a trial-and-error question, and so the answer should probably be 'no'." He keeps the other branch alive but deprioritized, with the full cost-benefit argument: "Guess the easy options first. If you are right, you have saved a lot of time by not pursuing the hard ways. If you are wrong, you were doomed to a long haul anyway."
2. `[recognize the red herring]` "Like in Problem 2.1, the digits are really sort of a red herring." In P2.1 only two facts about the digit sum were ever needed — a divisibility condition and a size restriction — never an exact equation. Expect the same here.
3. `[prove something stronger because it is simpler]` Plan: "simplify the problem by generalizing the digit-switching process. From a purely logical viewpoint we are worse off because we have to prove more: but in terms of clarity and simplicity we are gaining ground. (Why burden yourself with data that cannot be used? It will just be a distraction.)"
4. `[hunt for invariants]` Strategy statement: "pick out the main properties of powers of 2 and digit-switching – hopefully, we will find properties of one that are incompatible with the other."
5. `[characterize the easier object first]` `[generate data]` "Now let us tackle powers of 2 first; they are easier to handle." — of the two coupled objects (powers of 2; digit-switching) he deliberately profiles the tractable one before the intractable one. List them: $1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,\dots$ Honest verdict: "Well, there is not very much you can say about the digits here. The last digit of a power of 2 is obviously even (except for the number 1), but the other digits are quite random-looking."
6. `[hunt for invariants, via self-interrogation]` He picks a concrete specimen and pushes on it: "Suppose you took the number 4096, for instance. An odd digit, a few even digits, and even a 0 digit here. **What is stopping it being rearranged into another power of 2?**" Then the pivotal micro-dialogue: could 4096 be rearranged into $2^{4256} = 1523\ldots936$? "'Of course not!' you would say. Why? 'Because it's far too big!'. So, does size count? 'Yes—There would be thousands of digits in $2^{4256}$, and only four digits in 4096.' Aha—so rearranging digits cannot change the total number of digits." **Invariant #1: digit count.** Notice the shape of the move: he asks an *absurd* question, notes that the absurdity is obvious, and then refuses to let the obviousness pass unexamined until it has yielded a theorem. He immediately adds the meta-advice: "Write down any facts which could be of use to your problem, even if they are simple—do not assume that 'obvious' facts will always spring to mind when needed. Even shallowly dug gold has to be searched—and held on to."
7. **First replacement question:** "Well, with this **iota** of information, can we proceed with our generalizing plan?" — *Is there a power of 2 such that there is another power of 2 with the same number of digits as the first power of 2?* **Dead end** — "the answer to this question is quickly seen to be 'yes'; 2048 and 4096, for example. We were too general." He also flags the logical asymmetry: "Note that a 'yes' answer to this question does not necessarily yield a 'yes' answer to the original problem." `[recognize over-generalization]` `[collect iotas]` (*"Iota" is Tao's own word for a single small usable fact; he uses it twice in two pages. Having a name for the unit of progress makes it easier to notice that you have acquired one.*)
8. `[count your facts against a solved problem]` Diagnose *why* it failed by comparison with P2.1: "Again, look to Problem 2.1. Merely knowing 'the sum of digits of a multiple of 18 has to be a multiple of 9' is not sufficient to solve the problem: we also needed the fact that 'the sum of digits of three-digit number is at most 27'. In short, we have not found enough facts about our problem to solve it."
9. `[bank partial victories]` "Yet, we are still partially successful, because we have restricted the possibilities of digit rearranging." Consecutive powers of 2 double, so "they can not stay in the same 'tax bracket' for too long": at most four powers of 2 share a digit count, "(The fifth consecutive power of 2 would be 16 times that of the first, and hence would have to have more digits than the first power of 2)". Four-digit powers of 2: exactly 1024, 2048, 4096, 8192. So each power of 2 has **at most three candidate partners** — "A partial victory: only three or fewer suspects left to eliminate for each power of 2, instead of the infinite number we had before. Perhaps with a bit of extra work we can eliminate those suspects as well."
10. `[check the direction of your implication]` `[reel yourself in]` The precise diagnosis of why one invariant is not enough: "We have said that when we switch the digits, the number you end up with has the same number of digits as the original. **But the reverse is far from true**, and this lone property of digit-switching will not solve the problem on its own. This means that we have generalized too far and pushed our luck too much. Let us reel ourselves in again. Something else could be preserved when we switch digits." **The invariant is a one-way street: rearranging ⟹ same digit count, but same digit count ⟹ almost nothing. A weakening is only useful if the gap it opens is narrow, and "far from true" is the measure of that gap.**
11. `[generate data — reuse the same specimen]` List all digit-rearrangements of 4096 — "let us take 4096 again, since we have already got some experience with this number" `[reuse one worked example]`: 4069, 4096, 4609, 4690, 4906, 4960, 6049, 6094, 6409, 6490, 6904, 6940, 9046, 9064, 9406, 9460, 9604, 9640. (Eighteen of them — the $4! = 24$ orderings minus the six that start with the 0.) "What do they have in common? They have the same set of digits."
12. `[prefer conventional weapons]` Reject the set of digits: "That is all very well and good, but the 'set of digits' is not a very useful mathematical object (not many theorems and tools use this concept). However, the *sum of digits* is a more conventional weapon." And same set ⟹ same digit sum: "So we have another **iota** of information: digit-switching preserves the digit-sum." **Invariant #2: digit sum.**
13. **Second replacement question:** *Is there a power of 2 such that there is another power of 2 with the same number of digits **and** the same digit-sum as the first power of 2?* Better: "Now this question is a bit easier to cope with than the original, because 'number of digits' and 'digit-sums' are standard number-theory stuff." `[bank partial victories: two invariants combine]` **Note the accumulation principle** — the second invariant does not replace the first, it is *conjoined* with it. Each reel-in adds a clause; the weakened question gets progressively more constrained, so its answer gets progressively closer to "no".
    - *A caution about the book's own wording here.* At this point (p. 16) Tao writes "Again, if this question is true, the original question is true." Taken literally that is the reverse of the implication he needs, and it contradicts his own careful note one page earlier ("a 'yes' answer to this question does not necessarily yield a 'yes' answer to the original problem"). Read it as the intended "if the answer to this question is *no*, the answer to the original is *no*" — the direction he actually uses in the final proof. **Flagged rather than silently corrected, because getting this direction wrong is precisely the mistake the technique invites.**
14. `[generate data]` Table of digit sums (p. 16):

| $2^n$ | digit sum | $2^n$ | digit sum | $2^n$ | digit sum |
|---|---|---|---|---|---|
| 1 | 1 | 256 | 13 | 65,536 | 25 |
| 2 | 2 | 512 | 8 | 131,072 | 14 |
| 4 | 4 | 1,024 | 7 | 262,144 | 19 |
| 8 | 8 | 2,048 | 14 | 524,288 | 29 |
| 16 | 7 | 4,096 | 19 | 1,048,576 | 31 |
| 32 | 5 | 8,192 | 20 | | |
| 64 | 10 | 16,384 | 22 | | |
| 128 | 11 | 32,768 | 26 | | |

15. `[heuristic plausibility check]` Read the table (Tao's exact phrase: "From this we note that…") for whether this invariant *can* work, in two bullets.
    - **First bullet — collisions are cheap, and that is bad news for us.** "The digit-sums tend to be quite small. For instance, the digit-sum of $2^{17}$ is a mere 14. This is actually a small bit of bad luck, because small numbers are more likely to match than are big numbers. (If 10 people each randomly pick one two-digit number, there is a sizeable (9.5%) chance of a match, but if they each pick 10-digit numbers, then there is only a one in a million chance of a match: something about as lousy as the chances of winning the lottery.) But the smallness of the numbers also aids in picking out patterns, so perhaps it is not all bad news." *(This is the birthday paradox: with 10 people and 90 two-digit values, the chance of some pair colliding is $1 - \prod_{i=0}^{9}(1-i/90) \approx 9.5\%$. He is computing the base rate of accidental agreement, and noticing it is high — which is fatal for an argument whose whole purpose is to show two numbers cannot agree.)* **The transferable form: before adopting an invariant as your obstruction, estimate how often it collides by chance. An invariant with a high collision rate cannot separate things, no matter how clever you are.**
    - **Second bullet — a pattern that your own earlier reduction has already made useless.** "Some digit-sums match: for example, 16 and 1024. But it seems that the digit-sums slowly climbs higher anyway: you would expect that a 100-digit power of 2 would have a higher digit-sum than a 10-digit one. But also remember that we are confining ourselves to powers of 2 with the same number of digits, so this idea will not be of much help." `[notice when your own reduction has neutralized a new observation]` The upward drift *would* separate far-apart powers of 2 — but he has already restricted attention to powers with equal digit counts, i.e. to powers that are close together, which is exactly the regime where the drift is invisible. **A reduction you made earlier can silently invalidate an observation you make later. Re-check each new idea against the constraints you have already imposed.**
16. `[macroscopic vs microscopic]` Verdict, and the self-prompt that follows it: "The upshot of these observations is this: digit-sums have an easily appreciable macroscopic structure (slowly increasing with $n$; in fact it is highly probable (though not proven!) that the digit-sum of $2^n$ is approximately $(4.5\log_{10}2)n \approx 1.355n$ for large $n$) but a lousy microscopic structure. The digits just fluctuate too much. We mentioned earlier that 'set of digits' was unwieldy: now it seems that 'digit-sum' is not so flash either. **Is there another reduction of the problem that will leave us with something we can really work with?**" `[self-prompt with an explicit question]` *(Where the $1.355n$ comes from: $2^n$ has about $n\log_{10}2 \approx 0.301n$ digits, and if those digits behaved like independent uniform random digits their average would be 4.5 — hence $4.5 \times 0.301n$. It is a heuristic, and Tao marks it as unproven. It is also a nice miniature of "estimate, then label the estimate as an estimate".)* The question at hand is microscopic — an exact match between two specific numbers — so a quantity with only macroscopic structure can never settle it.
17. `[prefer conventional weapons — final upgrade]` He re-reads his own reformulation before improving it: "Hmm. We mentioned earlier that 'digit-sum' was a 'conventional weapon' in mathematics. Take a look at the preceding question for instance. But the only real way digit-sums can be successfully 'mainstreamed' is by considering the digit-sum modulo 9." Justification, worked out in the book for 3297:
    $$3297 = 3\times10^3+2\times10^2+9\times10^1+7\times10^0 \equiv 3\times1^3+2\times1^2+9\times1+7\times1 = 3+2+9+7 \pmod 9$$
    "because 10 is equal to 1 (mod 9)." **Invariant #3: the number's own remainder mod 9.**
18. **Third and fourth replacement questions:** *same digit count and same digit-sum modulo 9* — and then, since a number equals its digit sum mod 9, simply *same digit count and same remainder mod 9*. Payoff: "the pesky notions of 'rearranging digits', 'set of digits', and 'sum of digits' have been completely eliminated, which looks promising."
19. `[generate data]` Table of $2^n \bmod 9$ (p. 18):

| $2^n$ | mod 9 | $2^n$ | mod 9 | $2^n$ | mod 9 |
|---|---|---|---|---|---|
| 1 | 1 | 256 | 4 | 65,536 | 7 |
| 2 | 2 | 512 | 8 | 131,072 | 5 |
| 4 | 4 | 1,024 | 7 | 262,144 | 1 |
| 8 | 8 | 2,048 | 5 | 524,288 | 2 |
| 16 | 7 | 4,096 | 1 | 1,048,576 | 4 |
| 32 | 5 | 8,192 | 2 | | |
| 64 | 1 | 16,384 | 4 | | |
| 128 | 2 | 32,768 | 8 | | |

20. `[restate the current target in one sentence]` Before reading the table he says out loud exactly what is left to do: "What we have to prove is that no two powers of 2 have the same remainder (mod 9) and the same number of digits." *(Cheap, and it is what makes the next paragraph's observations recognizable as relevant.)* Then read it. Same remainder does happen — 1, 64, 4096, 262144 all give remainder 1 — "But none of these four have the same number of digits. Indeed, powers of 2 with the same remainder (mod 9) seem to be so separated that there is no hope of them having the same number of digits. In fact, the powers of 2 with the same remainder seem to be quite **regularly spaced** … and one can quickly see that the remainders (mod 9) repeat themselves every six steps." **Two observations in sequence, not one: first "they are far apart" (which is what he needs), then "they are regularly spaced" (which is what he can prove). The provable statement is the stronger, more structural one — pattern-hunting often finds the usable fact by over-shooting the needed fact.**
21. `[periodicity]` Prove it by fiddling with the definition:
    $$2^{n+6} = 2^n 2^6 = 2^n \times 64 = 2^n \pmod 9 \quad\text{because } 64 = 1 \pmod 9.$$
    So the residue sequence is the repeating block $1,2,4,8,7,5,\ 1,2,4,8,7,5,\ \dots$ — "like a repeating decimal" — and, critically, **the six values in one period are all different**, so two powers of 2 with the same residue must have exponents differing by a multiple of 6, hence by at least 6.
22. `[periodicity + growth = contradiction]` Six steps apart means one is at least $2^6 = 64$ times the other. A number 64 times larger cannot have the same number of digits (64 > 10). Contradiction.

**The resolution (Tao's proof, p. 18).**

> Suppose two powers of 2 are related by digit-switching. Then they have the same number of digits, and also the same digit-sum (mod 9). But the digit-sums (mod 9) are periodic with a period of 6, with no repetitions within any given period, so the two powers are at least six steps apart. But then it is impossible for them to have the same number of digits, a contradiction. $\square$

So the answer to the original question is **no**. Note the logical shape: he proved the *weakest* question in the chain has answer "no", and since being a digit-rearrangement *implies* every condition in that weakest question, the original has answer "no" too. He also flags the write-up move: "we can work backwards until we reach our original question, and write out the full answer" — the discovery order was reductions downward; the presentation order is implications upward.

**Tao's own moral (p. 19).**

> "This problem was simplified repeatedly until the more unusable and unfriendly parts of the problem were exchanged with more natural, flexible, and co-operative notions. This simplification can be a bit of a hit-and-miss affair; there is always the danger of oversimplification, or mis-simplification (simplifying into a red herring). But in this question, almost anything was better than playing around with digit-switching, so simplification could not do much more harm. There is a chance that maneuvering and simplifying may land you into a wild goose chase, but if you are really stuck anyway, anything is worth a try."

**Transferable lesson.** When a transformation is too complicated to describe, describe only what it *preserves*, and keep upgrading your choice of preserved quantity until it is one that standard theory can attack. Track the logical direction of each weakening, because it determines which answer ("yes" or "no") is transferable. And when a weakening overshoots, the fix is not to go back to the original — it is to add a *second, independent* invariant.

---

## Problem 2.3 (p. 19; source: Australian Mathematics Competition 1987, p. 15) — Find all integers $n$ for which $1/a + 1/b = n/(a+b)$ has a solution in nonzero integers

*Constraints: $a,b$ nonzero integers, $a+b \ne 0$ (otherwise the right-hand side is undefined). We want the set of all $n$ that are achievable.*

**The data / the objective.** A "standard Diophantine equation", so Tao's default opening applies: clear the denominators.

**The chain of moves.**

1. `[translate / clear denominators]` $\frac1a+\frac1b = \frac{a+b}{ab}$, so the equation is $(a+b)/ab = n/(a+b)$, and cross-multiplying gives
   $$(a+b)^2 = nab. \tag{2}$$
2. **Dead end #1 — number theory.** Eliminate $n$ to get the pure divisibility statement $ab \mid (a+b)^2$; or concentrate on the fact that $nab$ is a perfect square. Verdict: "These techniques are good, but they do not seem to work on this problem. The relationships of the left and right sides of (2) are not strong enough. One side is a square, the other is a product." `[abandon temporarily]`
3. `[abandon temporarily and switch toolbox]` The explicit meta-rule: "One thing to keep in mind when problem-solving is to be prepared to abandon temporarily one interesting—but fruitless—approach and try a more promising one. One could try algebra to attack the problem, then re-apply number theory later if algebra failed to work."
4. `[algebra: treat as a quadratic in one variable]` Expand and collect (2):
   $$a^2 + (2-n)ab + b^2 = 0.$$
   Read this as a quadratic in $a$ with coefficients $1$, $(2-n)b$, $b^2$. "if one is brave enough to use the quadratic formula we get"
   $$a = \frac{b}{2}\Big[(n-2) \pm \sqrt{(n-2)^2-4}\Big].$$
   *(Check: standard formula $a = \frac{-(2-n)b \pm \sqrt{(2-n)^2b^2 - 4b^2}}{2} = \frac{b}{2}[(n-2)\pm\sqrt{(n-2)^2-4}]$.)*
5. `[turn messiness to advantage — discriminant must be a perfect square]` "This looks very messy, but actually we can turn this messiness to our advantage. We know that $a$, $b$, and $n$ are integers, but there is a square root in the formula. Now this can only work if the term inside the square root, $(n-2)^2-4$, is a perfect square. But this means that 4 less than a square is a square. This is very restrictive."
6. `[growth / gap argument]` "Because the gaps between the squares get higher than 4 after the first few squares, we only need to test low numbers of $n$." *(Concretely: the squares are $0,1,4,9,16,25,\dots$ and consecutive gaps are $1,3,5,7,9,\dots$. Two squares differing by exactly 4 must both be small; the only such pair is $4-0$. So $(n-2)^2 = 4$.)* Hence "$(n-2)^2$ has to be 4, and hence $n$ is either 0 or 4."
7. `[case analysis]` "Now we can work each case separately, finding either an example of each or a proof that no such example exists."
   - **Case $n=0$.** (2) becomes $(a+b)^2 = 0$, so $a+b = 0$. "But this is impossible as in our original equation we now have a 0/0, which is illegal. Hence $n$ cannot be 0."
   - **Case $n=4$.** (2) becomes $(a+b)^2 = 4ab$, i.e. $a^2 - 2ab + b^2 = 0$, i.e. $(a-b)^2 = 0$, so $a = b$. "This is not a contradiction, but an example: $a=b$, $n=4$, works when put into the original equation."

**The resolution.** $n = 4$ is the only answer, realized by any $a = b \ne 0$. *(Sanity check with $a=b=1$: $1/1+1/1 = 2$ and $n/(a+b) = 4/2 = 2$ ✓.)*

**Tao's own verdict — the technique is ugly but keep it (p. 20).**

> "our answer was $n=4$, but it was obtained by the rather inelegant method of the quadratic formula. Using it is usually clumsy, but as it introduces a square root term, which implies that the term inside the square root must be a perfect square, it occasionally comes in useful."

**And a reclassification one page later (p. 21).** The "algebraic" solution was never really non-number-theoretic: "in Problem 2.3, both methods were considered early on, but discarded in favour of an algebraic approach, which is actually a factorization technique in disguise (remember we eventually got $(n-2)^2-4 = $ (square)?)." **Lesson: after solving, re-classify your own solution. You may find you used the tool you thought you had rejected — which tells you the tool was right and only your first application of it was wrong.**

**Aside on difficulty, and the transition into Problem 2.4 (p. 20).** "Diophantine problems can get extremely difficult when one of the variables appears in the exponent; the most notorious of these is *Fermat's last theorem*, which asserts that there are no natural number solutions to $a^n+b^n=c^n$ with $n>2$. **Fortunately, there are other problems involving exponents which are easier to handle.**" `[classify the question type]` That last sentence is how he hands you Problem 2.4: he has just told you that the *genre* (variable in the exponent) spans everything from trivial to 350-years-unsolved, so the genre alone predicts nothing and you must judge the individual problem. He then makes the same point in the opposite direction at the start of Problem 2.5, where a problem that *looks* like Fermat is "much milder". **A superficial resemblance to a famous hard theorem is evidence of nothing; check the actual difficulty yourself.**

**Transferable lesson.** Integrality is a constraint you can *weaponize*. Solve as if over the reals, then demand that every intermediate quantity that must be an integer actually is one — square roots, in particular, force perfect squares, and perfect squares are rare. Also: switching toolboxes (number theory → algebra) is a legitimate move, and the switch is temporary.

---

## Problem 2.4 (p. 20; source: Taylor 1989, p. 7) — Find all integer solutions of $2^n + 7 = x^2$

*We want every pair $(n,x)$ of integers making this true. E.g. $n=1$ gives $2+7=9=3^2$ ✓.*

**The data / the objective.** "This kind of question really needs trial and error to find the right track." He then states the toolkit for Diophantine equations in general (p. 21):

- **Modular arithmetic**: "transfers the entire equation to a suitable modulus, sometimes constant (e.g. (mod 7), or (mod 16)) or sometimes variable (e.g. (mod $pq$))."
- **Factorization**: "alters the problem into the form (factor) $\times$ (factor) = (something nice), where the right-hand side could be a constant (the best possible result), a prime, a square, or something else that has a limited choice of factors."

**The chain of moves.**

1. `[try elementary techniques first]` "Now it is best to try elementary techniques first, as it may save a lot of dashing about in circles later."
2. **Dead end #0 — the analytic route, refused before it is entered.** One could write $x = \sqrt{2^n+7} \approx 2^{n/2}$ and study the approximation, "which can get into some serious number theory involving topics such as continued fractions, Pell's equation, and recursion relations. It can be done; but we will look for the elegant (i.e. lazy) way out." `[look for the lazy way]`
3. `[factorization]` "Obtaining a useful factorization is next to impossible, except when $n$ is even." If $n = 2m$ then $2^n = (2^m)^2$ and we get a difference of two squares — "a vital factorization in Diophantine equations":
   $$7 = x^2 - 2^n = (x-2^m)(x+2^m).$$
   Since 7 is prime, each factor is one of $-7,-1,1,7$; "further breakup into cases soon shows that there are no solutions (if we assume $n$ is even)."
   *(Working: the two factors multiply to 7 and differ by $2^{m+1} > 0$. Options: $(x-2^m, x+2^m) = (1,7)$ gives $2^{m+1}=6$, not a power of 2; $(-7,-1)$ gives $2^{m+1}=6$ again. So no solutions.)*
4. `[bank the partial victory / know the tool's limits]` "But that is about as much as the factorization method can tell us; it does not tell us where the actual solutions are and how many of them there are. (Although we do now know that $n$ must be odd.)"
5. `[choose the modulus to annihilate a term]` "The strategy is to use the modulus to get rid of one or more of the terms." Three terms, so three attempts:
   - **Dead end #1 — mod $x$** (kills $x^2$): $2^n + 7 = 0 \pmod x$.
   - **Dead end #2 — mod 7** (kills the 7): $2^n = x^2 \pmod 7$.
   "Unfortunately, these methods do not work well at all."
6. `[enumerate the terms; try to kill each]` "But before we give up, there is one more modulus to try. We tried eliminating the '7' and the '$x^2$' terms; can we eliminate the $2^n$ term instead? Yes, by choosing, say, mod 2." This gives $0+7 = x^2 \pmod 2$ for $n>0$, and $1+7=x^2 \pmod 2$ for $n=0$. Assessment: "This is not too bad as we have almost eliminated the role of $n$ completely."
7. **Dead end #3 — mod 2 is too coarse.** "But it still does not work, as the $x^2$ term on the right-hand side could be 0 or 1, so we have not really excluded any possibilities."
8. `[choose the modulus to constrain the survivors]` "To restrict the values of $x^2$, we have to choose a different modulus. With this line of thought—to restrict the values on the right-hand-side—one now thinks to try modulus 4 instead of 2." Mod 4 is still a power of 2 (so it still annihilates $2^n$, now for $n>1$) *and* it pins squares down.
9. `[case split on small $n$]` Writing $2^n+7 = x^2 \pmod 4$ splits into three cases because $2^n \bmod 4$ behaves differently for tiny $n$ ($2^0=1$, $2^1=2$, $2^n \equiv 0$ for $n\ge2$), and $7 \equiv 3 \pmod 4$:
   $$0+3 = x^2 \pmod 4 \quad\text{when } n>1, \tag{3}$$
   $$2+3 = x^2 \pmod 4 \quad\text{when } n=1, \tag{4}$$
   $$1+3 = x^2 \pmod 4 \quad\text{when } n=0. \tag{5}$$
10. `[squares are rigid mod 4]` "Because $x^2$ must be 0 (mod 4) or 1 (mod 4), possibility (3) is eliminated." *(Recall: even${}^2 = 4k^2 \equiv 0$, odd${}^2 = 4k^2+4k+1 \equiv 1$. So $x^2 \equiv 3$ is impossible.)* Hence $n \le 1$ — i.e. $n$ is 0 or 1. (Note (4) says $x^2 \equiv 5 \equiv 1$ and (5) says $x^2\equiv 4 \equiv 0$; both are *allowed* mod 4, so mod 4 alone does not settle them.)
11. `[check the finitely many survivors by hand]` "A quick check then shows that only $n=1$ can work, and $x$ must be $+3$ or $-3$." *(Indeed $n=1$: $2+7=9=(\pm3)^2$ ✓. $n=0$: $1+7=8$, not a perfect square ✗. Negative $n$ do not give integers.)*

**The resolution.** The only integer solutions are $n=1$, $x = \pm 3$.

**Tao's own moral (p. 22) — the most predictive single sentence in the chapter.**

> "The main idea, when solving Diophantine equations of the form 'find all solutions', is to eliminate all but a finite number of possibilities. This is another reason why the (mod 7) and (mod $x$) would not work; for if they did, they would have eliminated all the cases, unlike the (mod 4) approach, which eliminated all but a handful."

Unpack it: solutions *exist* here, so no congruence can possibly be inconsistent for every $n$. Therefore any modulus that "works" in the sense of forbidding everything is a modulus you have misapplied. The right modulus leaves a short list. **Before you compute, ask what success would look like — and reject approaches whose success would contradict the known existence of a solution.**

**Transferable lesson.** Congruences are filters, and you choose the filter. Choose it so that (i) the term you cannot control disappears, and (ii) the term you want to constrain is rigid modulo your choice. Powers of 2 disappear mod any power of 2; squares are rigid mod 4 (and mod 8, and mod 3); cubes are rigid mod 9. Build a small mental table of "what is rigid mod what".

---

## Exercise 2.2 (p. 22) — Find the largest positive integer $n$ such that $n+10$ divides $n^3+100$

**Tao's hint (all he supplies).** "use (mod $n+10$). Get rid of the $n$ by using the fact that $n = -10 \pmod{n+10}$."

**The chain of moves** *(hint is Tao's; the working below is mine)*.

1. `[choose a variable modulus]` This is Tao's "sometimes variable (e.g. mod $pq$)" case from p. 21 — the modulus contains the unknown. Work mod $n+10$.
2. `[choose the modulus to annihilate a term]` By construction $n + 10 \equiv 0$, i.e. $n \equiv -10 \pmod{n+10}$. Substituting kills every occurrence of $n$:
   $$n^3 + 100 \equiv (-10)^3 + 100 = -1000 + 100 = -900 \pmod{n+10}.$$
3. So the condition "$(n+10) \mid (n^3+100)$" is *equivalent* to "$(n+10) \mid 900$" — an unknown-free divisibility statement. `[the whole point: eliminate the parameter]`
4. `[bound / enumerate]` $900$'s largest divisor is 900 itself, so the largest possible value is $n+10 = 900$, i.e. $n = 890$.

**Verification.** $890^3 + 100 = 704{,}969{,}000 + 100 = 704{,}969{,}100$, and $704{,}969{,}100 / 900 = 783{,}299$ exactly ✓.

**Transferable lesson.** When the modulus is allowed to contain the unknown, the substitution $n \equiv -c \pmod{n+c}$ collapses any polynomial in $n$ to a constant. This is the Remainder Theorem in modular clothing: dividing $f(n)$ by $n+c$ leaves remainder $f(-c)$. An infinite family of divisibility conditions becomes a single finite question: *which divisors does this one constant have?*

---

## Problem 2.5 (p. 23, opening section 2.3 "Sums of powers"; source: Hajós et al. 1963, p. 74) — Show that $1^n+2^n+3^n+4^n$ is divisible by 5 exactly when $n$ is *not* divisible by 4

*($n$ a non-negative integer. E.g. $n=1$: $1+2+3+4=10$, divisible by 5 ✓ and $4\nmid1$ ✓. $n=4$: $1+16+81+256=354 = 5\times70+4$, not divisible ✓ and $4\mid4$ ✓.)*

**The data / the objective.** First move is a *threat assessment*: "This problem looks a bit daunting at first: equations like the above may remind one of Fermat's last theorem, which is notorious for its insolvability. But our question is much milder. We wish to show that a certain number is (or is not) divisible by 5." `[recognize a scary problem as mild]`

**The chain of moves.**

1. `[move to modular arithmetic]` "Unless a direct factorization is evident, we will have to use the modulus approach." Both directions written out explicitly: show $1^n+2^n+3^n+4^n = 0 \pmod 5$ when $4 \nmid n$, and $\ne 0 \pmod 5$ otherwise. **Note he states both halves of the "if and only if" before starting — an iff has two obligations and it is easy to forget one.**
2. `[generate data — and choose the granularity of your table]` "Because we are using such small numbers, we can evaluate some of the values... manually. The best way to do this is to work out $1^n$ (mod 5), $2^n$ (mod 5), $3^n$ (mod 5), and $4^n$ (mod 5) *individually before adding*." The table (p. 23), all entries mod 5:

| $n$ | $1^n$ | $2^n$ | $3^n$ | $4^n$ | sum |
|---|---|---|---|---|---|
| 0 | 1 | 1 | 1 | 1 | 4 |
| 1 | 1 | 2 | 3 | 4 | 0 |
| 2 | 1 | 4 | 4 | 1 | 0 |
| 3 | 1 | 3 | 2 | 4 | 0 |
| 4 | 1 | 1 | 1 | 1 | 4 |
| 5 | 1 | 2 | 3 | 4 | 0 |
| 6 | 1 | 4 | 4 | 1 | 0 |
| 7 | 1 | 3 | 2 | 4 | 0 |
| 8 | 1 | 1 | 1 | 1 | 4 |

   **This is a deliberate methodological choice.** The pattern in the *sum* column is a bare $4,0,0,0,4,0,0,0,4$; the per-column view shows *why* — each of the four columns is separately periodic with period 4. The finer-grained table carries the explanation, not just the phenomenon.
3. `[periodicity]` "Now it is obvious that some periodicity is evident. In fact $1^n$, $2^n$, $3^n$, and $4^n$ are all periodic with period 4. To prove this conjecture, we can just fiddle with the definition of periodicity." For $3^n$: periodicity with period 4 *means* $3^{n+4} = 3^n \pmod 5$, and
   $$3^{n+4} = 3^n \times 81 = 3^n \pmod 5 \quad\text{because } 81 = 1 \pmod 5.$$
   Similarly $1^{n+4}=1^n$ trivially, $2^{n+4} = 2^n\times16 = 2^n$ (as $16 \equiv 1$), $4^{n+4} = 4^n \times 256 = 4^n$ (as $256 \equiv 1$).
4. `[check one period]` Sum of four period-4 functions is period-4. "This in turn implies that we only need to prove our question for $n = 0,1,2,3$, because periodicity will take care of all the other cases of $n$. But we have already shown the question to be true in these cases (see the above table). So we are done."

**The resolution.** From the table: the sum is $0 \pmod 5$ for $n \equiv 1,2,3 \pmod 4$ and is $4 \pmod 5$ (so *not* divisible by 5) for $n \equiv 0 \pmod 4$. Since $n \equiv 0 \pmod 4$ is exactly "$4$ divides $n$", both directions of the iff are proved simultaneously. $\square$

**Tao's aside — a second, cheaper proof of half the statement (p. 24).** "there is a more elementary method available if we assume that $n$ is odd: simply pair up and cancel terms." *Unpacked:* mod 5, $4 \equiv -1$ and $3 \equiv -2$. So the sum is $1^n + 2^n + (-2)^n + (-1)^n$. For odd $n$, $(-a)^n = -a^n$, so $1^n$ cancels $(-1)^n$ and $2^n$ cancels $(-2)^n$, leaving 0. `[symmetry / anti-symmetry]` This foreshadows Problem 2.6 exactly.

**Tao's own moral (p. 24).**

> "Whenever trying to prove equations involving a parameter (in this case $n$), periodicity is always handy, as one no longer needs to check all values of the parameter to verify the equation. Checking one period (e.g. $n=0,1,2$, and 3) will be sufficient."

**Transferable lesson.** An exponent ranging over infinitely many values, viewed modulo a fixed number, only takes finitely many values — so it must cycle. Find the cycle length $T$ by finding $T$ with $a^T \equiv 1$, then the infinite claim reduces to a finite check. The programmer's version: the state space is finite and the transition deterministic, so the trajectory is eventually periodic; test one lap.

---

## Exercise 2.3 (p. 24) — Show that $x^4 + 131 = 3y^4$ has no integer solutions

**No hint given.** But the chapter has just taught the method: `[choose the modulus to constrain the survivors]` — find a modulus for which fourth powers are rigid.

**The chain of moves** *(my working, following the chapter's method)*.

1. `[what is rigid mod what?]` Fourth powers are extremely restricted mod 5. Check all five residues: $0^4=0$; $1^4=1$; $2^4=16\equiv1$; $3^4=81\equiv1$; $4^4=256\equiv1$. So **any fourth power is $0$ or $1$ mod 5.** *(This is the $p=5$ case of Fermat's little theorem: $a^{p-1}\equiv1$ for $a$ not divisible by $p$.)*
2. `[reduce the equation]` $131 = 130+1$ and $130 = 26\times5$, so $131 \equiv 1 \pmod 5$. The equation becomes
   $$x^4 + 1 \equiv 3y^4 \pmod 5.$$
3. `[enumerate both sides]` Left side: $x^4 \in \{0,1\}$, so $x^4+1 \in \{1, 2\}$. Right side: $y^4 \in \{0,1\}$, so $3y^4 \in \{0, 3\}$.
4. `[contradiction]` $\{1,2\} \cap \{0,3\} = \varnothing$. The two sides can never agree mod 5, so the equation has no integer solutions. $\square$

**Why mod 5 and not something else.** The exponent is 4, and $5 = 4+1$ is prime, so mod 5 is precisely where fourth powers collapse to $\{0,1\}$ — the same reasoning that made mod 4 right for squares in Problem 2.4 (squares collapse to $\{0,1\}$ there). **Rule of thumb extracted: to make $k$-th powers rigid, look at moduli $m$ where $k$ divides $m-1$ or $k$ shares structure with $m$.** Note also that mod 5 leaves *no* survivors here, which is legitimate precisely because the answer is "no solutions" — contrast Problem 2.4, where such a modulus had to fail.

**Transferable lesson.** "Prove no solutions exist" is the one case where you *want* a congruence that forbids everything. This is called a local obstruction: if an equation is unsolvable modulo some $m$, it is unsolvable over the integers. Cheap, mechanical, and the first thing to try on any "no solutions" Diophantine problem.

---

## Problem 2.6 (p. 24; source: Shklarsky et al. 1962, p. 14) (\*\*) — For natural $k, n$ with $k$ odd, show that $1+2+\cdots+n$ divides $1^k+2^k+\cdots+n^k$

*Example: $n=4$, $k=3$. Then $1+2+3+4 = 10$ and $1^3+2^3+3^3+4^3 = 100$, and $10 \mid 100$ ✓. The exercise is marked (\*\*) — Tao's hardest difficulty tier in this chapter.*

**The data / the objective.** Tao first situates the problem in the wider literature, then explicitly declines to use it: "This question, by the way, is a standard exercise in Bernoulli polynomials (or some astute applications of the Remainder Theorem), **an interesting portion of mathematics that has many applications**. But without the sledgehammer of Bernoulli polynomials (or the Riemann $\zeta$ function) we will just have to use plain old number theory." `[no sledgehammers]` `[situate the problem in the literature, then decline the machinery]`

*Two notes for a reader who has only Calculus 1 and basic linear algebra, since Tao name-drops three things and uses none of them:*
- **Bernoulli polynomials.** There is a family of polynomials $B_m(x)$ for which $1^k+2^k+\cdots+n^k$ has an exact closed form as a polynomial in $n$ of degree $k+1$ (you already know two instances: $n(n+1)/2$ for $k=1$ and $n(n+1)(2n+1)/6$ for $k=2$). If you had the general formula you could read the divisibility off the factorization directly. That is the "sledgehammer".
- **The Remainder Theorem** (the school algebra one): dividing a polynomial $f(x)$ by $x-c$ leaves remainder $f(c)$. This is the same fact that powers Exercise 2.2 in modular clothing ($n \equiv -10 \pmod{n+10}$), which is why Tao calls it an alternative route to the same result. The **Riemann $\zeta$ function** is a red herring for our purposes — it is mentioned only because Bernoulli numbers show up in its values at negative integers.

**Why naming the sledgehammer is itself a technique.** He identifies the problem's standard home in the literature *first*, which tells him what kind of object the answer is, and only then chooses to walk instead of drive. Knowing that a heavy tool would work is reassurance that the problem is true and structured; refusing it is a decision about *your* budget, not about the tool's quality.

**The chain of moves.**

1. `[choose the representation that suits the goal]` The divisor can be written $1+2+\cdots+n$ or $n(n+1)/2$. "Which form shall we use? The former is more aesthetic, but a bit useless in a divisibility question. (It is always easier if the divisor is expressed as a product, rather than a sum.)"
2. **Dead end #1 — a factorization.** "It might have been useful if there was some nice factorization of $1^k+2^k+\cdots+n^k$ which involved $1+2+\cdots+n$, but there is not (at least, not an obvious one)."
3. **Dead end #2 — induction.** "If there was some way to relate divisibility by $1+2+\cdots+n$ to divisibility by $1+2+\cdots+(n+1)$ then induction might be a way to go, but that does not seem likely either. **So we will try the $n(n+1)/2$ formulation instead.**" **Note the *reason* induction is rejected: the two divisors are unrelated, so the inductive step has nothing to grip. Rejecting induction for a stated structural reason is much better practice than rejecting it because it "feels hard".** *(Concretely, why the step has nothing to grip: going from $n$ to $n+1$ adds $(n+1)^k$ to the sum, but changes the divisor from $n(n+1)/2$ to $(n+1)(n+2)/2$ — a different number sharing only the factor $n+1$. Knowing the old divisibility tells you almost nothing about the new one. Contrast a well-behaved induction, where the divisor is fixed and only the sum grows.)* Note also that the two dead ends are the two directions of the same idea: first he looks for a factorization that *contains* the divisor, then for a recursion that *relates consecutive* divisors. Both fail for the same underlying reason — $\sum i^k$ has no visible structural relationship to $\sum i$ — and only after both fail does he give up on the sum form and commit to the product form.
4. `[move to modular arithmetic]` "using modular arithmetic (which is the most flexible way to prove that one number divides another), our objective is to show that"
   $$1^k+2^k+\cdots+n^k = 0 \pmod{n(n+1)/2}.$$
5. `[split a composite modulus into coprime factors]` "Let us ignore for the moment the '2' in the $n(n+1)/2$." The shape is (factor 1) × (factor 2) | (expression). "If the two factors are coprime, then our objective is equivalent to proving both of (factor 1)|(expression) and (factor 2)|(expression) separately. This should be simpler to prove: it is easier to prove divisibility if the divisors are smaller."
6. `[case analysis on parity]` "But there is an annoying '2' in the way. To deal with that we will just break up into cases, depending on whether $n$ is even or odd." Footnote alternative: "Another way is to multiply both sides by 2, so that we now want to prove $2(1^k+2^k+\cdots+n^k) = 0 \pmod{n(n+1)}$. This ends up being more or less equivalent to the approach given below." `[multiply through to clear a fraction]`
7. Tao does only the case $n$ **even** ("The cases are quite similar and I will only do the case when $n$ is even"), leaving the odd case as Exercise 2.4.
8. `[housekeeping substitution]` "we can write $n=2m$ (so as to avoid staring at messy '$n/2$' terms in the following equations—little housekeeping things like this help a solution run smoothly)." Then $n(n+1)/2 = 2m(2m+1)/2 = m(2m+1)$, and the target becomes
   $$1^k+2^k+\cdots+(2m)^k = 0 \pmod{m(2m+1)}.$$
9. `[coprimality check]` "since $m$ and $2m+1$ are coprime" — *(true because any common divisor of $m$ and $2m+1$ divides $(2m+1)-2m = 1$)* — the target splits into two independent targets:
   $$1^k+\cdots+(2m)^k = 0 \pmod{2m+1} \qquad\text{and}\qquad 1^k+\cdots+(2m)^k = 0 \pmod{m}.$$

**Part A: mod $2m+1$.** "It is quite similar to Problem 2.5 but is a bit easier, because we know that $k$ is odd."

`[symmetry / anti-symmetry]` Modulo $2m+1$: $2m \equiv -1$, $2m-1 \equiv -2$, ..., $m+1 \equiv -m$. So the sum becomes
$$1^k+2^k+\cdots+m^k+(-m)^k+\cdots+(-2)^k+(-1)^k \pmod{2m+1}.$$
"We have done this so that we can do some nice cancelling. $k$ is odd, so $(-1)^k$ is equal to $-1$. Therefore $(-a)^k = -a^k$." Hence $2^k$ cancels $(-2)^k$, $3^k$ cancels $(-3)^k$, and so on, and the whole thing is $0 \pmod{2m+1}$. ✓

*(Sanity check, $m=2$ so $n=4$, $k=3$, modulus 5: $1+8+27+64 = 100 \equiv 0 \pmod 5$ ✓. And the rewriting: $1^3+2^3+(-2)^3+(-1)^3 = 1+8-8-1=0$ ✓.)*

**Part B: mod $m$.** More delicate.

1. `[reduce every term]` Modulo $m$: $m \equiv 0$ and $2m \equiv 0$, while $m+1 \equiv 1$, $m+2 \equiv 2$, etc. So
   $$1^k+2^k+\cdots+(m-1)^k + 0^k + 1^k + \cdots + (m-1)^k + 0 \pmod m.$$
2. `[recombine]` "several terms appear twice, so recombining (and ditching the 0s) we get"
   $$2\big(1^k+2^k+3^k+\cdots+(m-1)^k\big) \pmod m.$$
3. `[sub-case: $m$ odd]` "Now we can almost do the same thing as for the (mod $2m+1$) case, except there is a small hitch when $m$ is even. If $m$ is odd, we can reformulate the above expression as" — i.e. rewrite anti-symmetrically as
   $$2\Big(1^k+2^k+\cdots+\big(\tfrac{m-1}{2}\big)^k + \big(-\tfrac{m-1}{2}\big)^k + \cdots + (-2)^k + (-1)^k\Big) \pmod m$$
   and cancel in pairs exactly as in Part A. Result 0. ✓
4. `[sub-case: $m$ even, $m = 2p$ — cancellation leaves a residue]` "if $m$ is even (so $m=2p$, say) there is a middle term, $p^k$, which does not cancel with anything. In other words, in this case the expression does not collapse to 0 immediately, but instead cancels to $2p^k \pmod{2p}$." *(Why $p$ is the odd one out: the terms run $1$ to $m-1 = 2p-1$, an odd count, and pairing $j$ with $m-j \equiv -j$ leaves the self-paired middle $j = p$ alone.)*
5. **And it does not matter.** "But this, of course, is equal to 0." *(Because $2p \mid 2p^k$ — the leftover already contains the modulus as a factor. The factor of 2 out front, which was pure nuisance in step 2, is exactly what rescues this case.)* ✓

**The resolution.** "Regardless of whether $m$ is odd or even, we have proved that $1^k+2^k+3^k+\cdots+n^k$ is divisible by $n(n+1)/2$ if $n$ is even."

**Transferable lesson (three of them).**
- *Represent your divisor as a product, split it into coprime pieces, and prove each piece separately.* Small moduli annihilate more terms, and annihilated terms are free.
- *A "/2" in a divisor is handled by a parity case split, or by multiplying through by 2.* Both are cheap; neither is clever; pick one and move on.
- *When pairwise cancellation leaves an unpaired middle term, compute it rather than abandoning the method.* Here the residue $2p^k$ was zero anyway. The near-miss case is often still fine.

---

## Exercise 2.4 (p. 26) — Complete Problem 2.6 by doing the case $n$ odd

**Tao's statement.** "Complete the proof of the above problem by working out what happens when $n$ is odd." *(He has already told us "the cases are quite similar".)*

**The chain of moves** *(my completion, following Tao's own template for $n$ even; only the substitution changes)*.

1. `[housekeeping substitution]` $n$ odd means $n+1$ is even, so write $q = (n+1)/2$, i.e. $n = 2q-1$. Then the divisor is
   $$\frac{n(n+1)}{2} = (2q-1)\cdot q .$$
   Note the parallel with the even case: there the "/2" was absorbed by $n$, here it is absorbed by $n+1$.
2. `[coprimality check]` $\gcd(2q-1, q) = 1$, because any common divisor divides $2q - (2q-1) = 1$. So `[split a composite modulus]` it suffices to prove
   $$1^k+2^k+\cdots+n^k \equiv 0 \pmod{2q-1} \quad\text{(i.e. mod } n) \qquad\text{and}\qquad \equiv 0 \pmod{q}.$$
3. **Part A: mod $n$.** The last term is $n^k \equiv 0$. The remaining terms run $1$ to $n-1$, an *even* count ($n-1 = 2q-2$). `[anti-symmetry]` Pair $j$ with $n-j \equiv -j$; since $k$ is odd, $(-j)^k = -j^k$, so each pair cancels. Total: 0 ✓.
4. **Part B: mod $q$.** Reduce the terms $1,\dots,2q-1$ modulo $q$: they are $1,\dots,q-1$, then $q\equiv0$, then $q+1\equiv1,\dots,2q-1\equiv q-1$. So the sum is
   $$2\big(1^k+2^k+\cdots+(q-1)^k\big) \pmod q,$$
   which is *literally the same expression* as step 2 of Part B in Problem 2.6, with $q$ in place of $m$. So the same sub-case analysis finishes it: if $q$ is odd, pair off and cancel → 0; if $q = 2r$ is even, the unpaired middle term leaves $2r^k \pmod{2r}$, which is 0. ✓

**Verification of a case.** $n=3$, $k=3$: divisor $1+2+3 = 6$; sum $1+8+27 = 36 = 6\times6$ ✓. Here $q=2$ (even), so it is the "middle term" sub-case: mod 2 the sum is $1^3+0+1^3 = 2 \equiv 0$ ✓; mod 3 it is $1^3+2^3+0 = 1 + (-1)^3 = 0$ ✓.

**Transferable lesson.** The point of Tao's "the cases are quite similar" is not laziness — it is that a good decomposition makes the second case *structurally identical*. If your second case requires a brand-new idea, your decomposition was probably wrong. When you do the omitted case, first look for the substitution that makes it the same problem.

---

## Problem 2.7 (p. 27; source: Shklarsky et al. 1962, p. 17) — For a prime $p>3$, the numerator of the reduced fraction $1/1+1/2+\cdots+1/(p-1)$ is divisible by $p^2$

*Tao's example: $p=5$ gives $1+\tfrac12+\tfrac13+\tfrac14 = \tfrac{25}{12}$, and the numerator 25 is divisible by $5^2$ ✓. This is the longest and hardest development in the chapter — seven pages — and it is essentially a masterclass in one technique: step-by-step reduction.*

**How Tao files it before starting (p. 26).** The problem arrives with a one-sentence classification: "Now let us turn to a special type of 'sums of powers' problem, namely **sums of reciprocals**." `[file the new problem under a genre you have just worked in]` This is not decoration. It is why, four pages later, his first idea for finding a better proof is "if we are fresh from solving Problem 2.6, we know that symmetry, or anti-symmetry can be exploited" (p. 30) — the genre label is what makes the previous problem's toolbox reachable. **Label a new problem with the name of the last problem it resembles; that label is your search key when you get stuck.**

**The data / the objective (Tao's framing, p. 27).**

1. `[classify the question type]` "This question is a 'Prove that' question, not a 'Find a' or 'Show there exists' question, so it should not be completely impossible."
2. Name the two obstacles, **and in each case name the remedy in the same breath**. (i) "we have to prove something about a numerator of a reduced fraction—not something easily dealt with! **This numerator will need to be transformed into something more standard, like an algebraic expression, so that we can manipulate it better.**" (ii) "the question does not just need divisibility by a prime, it needs divisibility by the square of a prime. This is significantly harder. **We would like to somehow reduce the problem to mere prime divisibility to make the problem more solvable.**" Each obstacle is immediately converted into a wish, and the two wishes become the two numbered objectives below. **The mechanical recipe: for each thing that makes the problem hard, write the sentence "we would like to…". Your objectives list is then just that list of wishes.**
3. `[set tactical objectives from the shape of the question]` "So by looking at the shape of the question, we have the following objectives to keep in mind:
   > (a) Express the numerator as a mathematical expression, so that we can manipulate it.
   > (b) Aim to reduce the problem from a $p^2$-divisiblity problem to something simpler, perhaps a $p$-divisibility problem."

### Stage 1 — Objective (a): get an algebraic numerator, and check it is the right one

4. `[translate into a formula]` Put everything over the common denominator $(p-1)!$. The numerator is
   $$2\times3\times\cdots\times(p-1) \;+\; 1\times3\times\cdots\times(p-1) \;+\;\cdots\;+\; 1\times2\times3\times\cdots\times(p-2),$$
   i.e. one term per omitted factor.
5. `[audit the reformulation]` But that is the *unreduced* numerator. Does proving $p^2 \mid$ (unreduced numerator) prove the theorem? "what is the reduced numerator? It is the original numerator after some cancellation with the denominator. Can cancelling destroy the property of $p^2$-divisibility? Yes, if a multiple of $p$ is cancelled. But multiples of $p$ cannot be cancelled, because the denominator is coprime to $p$ ($p$ is prime, and $(p-1)!$ can be expressed as a product of numbers less than $p$). Aha! This means that we only need to prove that the ugly-looking numerator above is divisible by $p^2$." Objective (a) is met, *and* the substitution is certified valid.
6. `[move to modular arithmetic]` `[turn a described object into an equation]` Target: that sum $\equiv 0 \pmod{p^2}$. And here is the crisp statement of *why* objective (a) counted as progress: "**This is better than the other numerator because now we have an equation to solve.**" **You have not made the quantity smaller or nicer — you have changed its type, from "an object described in English" to "an equation", and equations are the type your toolbox accepts as input.** With the caveat noted: "Again, we have switched over to modular arithmetic, which is usually the best way to show that one number divides another. However, if the question involves more than one divisibility, for example, something involving all divisors of a certain number, other techniques are sometimes better." He also grades the current state honestly: "Although we have got an equation now, it is a mess. Our next task is to simplify it."

### Stage 2 — Compress the expression

7. `[prefer a compact representation]` The left side is "an indefinite sum of indefinite products. (Indefinite just means that there are 'dot dot dots' in the expression.)" Each product is $(p-1)!$ with one factor $i$ removed, so it equals $(p-1)!/i$. Legality: "it is legitimate to divide by $i$ modulo $p^2$ because $i$ is coprime to $p^2$" — every $i$ satisfies $1 \le i \le p-1 < p$, so no $i$ shares a factor with $p$. Target becomes
   $$\frac{(p-1)!}{1}+\frac{(p-1)!}{2}+\frac{(p-1)!}{3}+\cdots+\frac{(p-1)!}{p-1} = 0 \pmod{p^2}.$$
8. `[factorize]`
   $$(p-1)!\left[\frac11+\frac12+\frac13+\cdots+\frac1{p-1}\right] = 0 \pmod{p^2}. \tag{6}$$
   Reminder from Tao: "we are dealing with modular arithmetic, so that a number like 1/2 will be equivalent to an integer. For example, $1/2 = 6/2 = 3 \pmod 5$."
9. `[audit the reformulation — dividing out a factor]` Shape is (factor) × (factor) $= 0 \pmod{p^2}$. "If it were not for the modular arithmetic, then we could quickly say that one of the factors is 0. With modular arithmetic, we can say nearly the same thing, but we have to be careful. Luckily, the first factor, $(p-1)!$, is coprime to $p^2$ (because $(p-1)!$ is coprime to $p$) so we can divide it out." Hence (6) is *equivalent to*
   $$\frac11+\frac12+\frac13+\cdots+\frac{1}{p-1} = 0 \pmod {p^2}.$$
   *(Why care: mod 12, $3\times4=0$ though neither factor is 0. Coprimality to the modulus is exactly the licence to cancel.)*
10. `[notice you are somewhere familiar, and justify the detour]` "Note that this looks very similar to our original question, the only difference being that we are considering the entire fraction, not just the numerator of it. But one cannot just jump from one form to another without care. The above complications were necessary."

### Stage 3 — Experiment, then drop to the easier modulus

11. `[generate data]` `[reuse one worked example]` "Now we have reduced the question to proving a rather benign-looking modular arithmetic equation. But where to go on from here? Perhaps an example will help. **Let us take the same example as the one given in the question**: namely, $p=5$." — note that he does not invent a fresh case; he reuses the one the problem statement handed him, so the arithmetic is already half done. $p=5$: $\tfrac11+\tfrac12+\tfrac13+\tfrac14 \equiv 1 + 13 + 17 + 19 = 50 \equiv 0 \pmod{25}$ ✓. *(Check: $2\times13 = 26 \equiv 1$; $3\times17=51\equiv1$; $4\times19=76\equiv1$ — all mod 25.)* Then $p=7$: $1+25+33+37+10+41 = 147 = 3\times49 \equiv 0 \pmod{49}$ ✓. *(Check a couple: $2\times25=50\equiv1$; $5\times10=50\equiv1$; $6\times41=246=5\times49+1\equiv1$ — all mod 49.)*
12. **The honest assessment.** "The numbers 1, 13, 17, and 19 seem to be random, but 'magically' add up to the right amount. Perhaps it is a fluke... This has the same 'flukiness' about it. How does this work? It is not clear how everything manages to cancel out modulo $p^2$." **Verification without mechanism is not progress; say so and change tack.**
13. `[solve an easier analogue first]` "Perhaps, keeping objective (b) in mind, we can prove it (mod $p$) first, that is, let us first prove
    $$\frac11+\frac12+\frac13+\cdots+\frac1{p-1} = 0 \pmod p. \tag{7}$$
    If nothing else, it will give us something to do. (Besides, if we can not solve this (mod $p$) problem, there is no way that we will be able to solve the (mod $p^2$) problem.)"
14. `[generate data]` $p=5$: $1+3+2+4 = 10 \equiv 0 \pmod5$ ✓. $p=7$: $1+4+5+2+3+6$, which rearranges to $1+2+3+4+5+6 = 21 \equiv 0 \pmod 7$ ✓. $p=11$: $1+6+4+3+9+2+8+7+5+10$, which rearranges to $1+2+\cdots+10 = 55 \equiv 0 \pmod{11}$ ✓. *(Typographical note: the printed line on p. 30 writes the left-hand side as "$1/1+1/2+\cdots+1/11$", but the ten listed residues correspond to $1/1$ through $1/10$; the last term should read $1/10$. The numbers are right.)*

### Stage 4 — First proof of (7): rearrangement — then reject it

15. `[rearrangement / bijection]` "Now we have a pattern emerging: the reciprocals $1/1, 1/2, \dots, 1/(p-1)$ (mod $p$) seem to cover all the residues $1,2,\dots,(p-1)$ (mod $p$) exactly once." Given that, the sum equals $1+2+\cdots+(p-1) = p(p-1)/2$, which is $\equiv 0 \pmod p$ because $p$ is odd so $(p-1)/2$ is a whole number. (7) proved.
16. `[reject a successful proof that will not generalize]` "This tactic, showing that the reciprocal numbers can be rearranged in this orderly fashion, works neatly for (mod $p$), but it does not generalize easily to (mod $p^2$). Instead of floundering around trying to fit a square block into a round hole (although it can be done if you push hard enough), it is better to find a block that is more round. So what we have to do now is find another proof of the fact that $1/1+1/2+1/3+\cdots+1/(p-1) = 0 \pmod p$; one that generalizes, at least partially, to the (mod $p^2$) case."

### Stage 5 — Second proof of (7): anti-symmetric pairing — then push it to mod $p^2$

17. `[search your recent toolbox by name]` "Now it is time to use experience with these sorts of problems. For example, if we are fresh from solving Problem 2.6, we know that symmetry, or anti-symmetry can be exploited, especially in modular arithmetic."
18. `[anti-symmetry]` Rewrite $p-1$ as $-1$, $p-2$ as $-2$, etc.:
    $$\frac11+\frac12+\frac13+\cdots+\frac1{p-1} = \frac11+\frac12+\frac13+\cdots+\frac1{-3}+\frac1{-2}+\frac1{-1} \pmod p.$$
    "And now we can pair off and cancel easily (there is no 'middle term' that does not pair off, as $p$ is an odd prime)." *(There are $p-1$ terms, an even number.)* Second proof of (7) done.
19. `[trade complexity for a weaker modulus]` "Can we do the same in (mod $p^2$)? The answer is 'sort of'." Pair $1/j$ with $1/(p-j)$ — but now, instead of cancelling, *add the pair honestly*: $\frac1j+\frac1{p-j} = \frac{p}{j(p-j)}$. There are $(p-1)/2$ such pairs, so
    $$\frac11+\frac12+\cdots+\frac1{p-1} = p\left[\frac{1}{1\times(p-1)}+\frac{1}{2\times(p-2)}+\cdots+\frac{1}{\frac{p-1}{2}\times\frac{p+1}{2}}\right] \pmod{p^2}.$$
20. **The key judgement (p. 31).** "Now this, at first, looks like a complication rather than a simplification. But we have gained a very important factor of $p$." Because
    $$(p\times\text{expression}) = 0 \pmod{p^2} \iff \text{expression} = 0 \pmod p,$$
    "we are now reduced to a (mod $p$) question instead of a (mod $p^2$) question. Now we have achieved objective (b)... reduced the question to that of a smaller modulus, which is well worth the slight increase in complexity." And the complexity was illusory: "the (mod $p$) can get rid of a lot more terms than (mod $p^2$) can."

### Stage 6 — Tidy the surviving mod-$p$ sum

21. New goal: $\displaystyle\sum_{j=1}^{(p-1)/2}\frac{1}{j(p-j)} = 0 \pmod p$. `[substitute negatives]` Since $p-j \equiv -j$, each denominator $j(p-j) \equiv -j^2$, giving
    $$\frac{1}{-1^2}+\frac{1}{-2^2}+\cdots+\frac{1}{-\left(\frac{p-1}{2}\right)^2} = 0 \pmod p,$$
    equivalently (multiply by $-1$)
    $$\frac{1}{1^2}+\frac{1}{2^2}+\frac{1}{3^2}+\cdots+\frac{1}{\left(\frac{p-1}{2}\right)^2} = 0 \pmod p.$$
22. `[symmetry is nice to keep — "double up"]` "This equation is not too bad, except that the series on the left-hand side ends in an obscure spot (at $1/((p-1)/2)^2$, rather than the more natural $1/(p-1)^2$)." Using $(-a)^2 = a^2$, the sum equals half of the *doubled* list:
    $$\sum_{j=1}^{(p-1)/2}\frac1{j^2} = \frac12\left[\sum_{j=1}^{(p-1)/2}\frac1{j^2} + \sum_{j=1}^{(p-1)/2}\frac1{(-j)^2}\right] = \frac12\left[\frac1{1^2}+\cdots+\frac{1}{(p-1)^2}\right] \pmod p.$$
    *(The bracket now runs over all of $\pm1, \pm2, \dots, \pm\frac{p-1}{2}$, and those residues are exactly $1,2,\dots,p-1$ mod $p$ in some order.)* His stated criterion for preferring the longer expression: "**The latter is more desirable because of its more symmetrical format.**" Then the rule: "(Symmetry is nice to keep—until it can be used to its full effect—while anti-symmetry, is nice to cancel.)" **"More symmetrical" is being used here as a *tactical* virtue, not an aesthetic one: a sum over the full range $1..p-1$ is one that standard formulas and standard bijections accept as input, whereas a sum stopping at $(p-1)/2$ is not. Symmetry is a compatibility property.**
23. So the whole problem now reduces to
    $$\frac1{1^2}+\frac1{2^2}+\cdots+\frac1{(p-1)^2} = 0 \pmod p. \tag{8}$$
    "This is tactically a much better formulation than the original one involving numerators and $p^2$ divisibility, which is a lot stronger (hence harder to prove) than mere $p$-divisiblity."
24. `[spiral, not circle]` "So now we have achieved all our tactical goals, **and reduced the question down to decent proportions**. But where do we go from here? Well, the question seems very closely related to the other problem (7) that we were considering. But we are not going around in circles. Our current goal (8) will imply the original question, whereas (7) was just a side-problem, a simpler version of the question. Rather than going around in circles, we are going around in spirals, heading towards a solution."

### Stage 7 — Finish (8), reusing the discarded tool

25. `[audit both tools against the new target]` "there were two methods we used to solve (7): one was the rearrangement of reciprocals, and the other was cancellation of pairs. Cancellation of pairs unfortunately does not work as well with (8) as it did with (7), mainly because of the squares in the denominators, which produce symmetry rather than anti-symmetry. But the rearrangement method is promising." **The proof he discarded in Stage 4 is the one that finishes the job. Nothing is wasted; the tools were held in reserve.**
26. `[reuse the same example]` Take $p=5$ again "so we can reuse some previous work": $\tfrac1{1^2}+\tfrac1{2^2}+\tfrac1{3^2}+\tfrac1{4^2} \equiv 1^2+3^2+2^2+4^2 = 1^2+2^2+3^2+4^2 = 30 \equiv 0 \pmod5$ ✓. *(Because $1/1\equiv1, 1/2\equiv3, 1/3\equiv2, 1/4\equiv4$ mod 5, and squaring preserves the rearrangement.)*
    - **`[an example that shows the mechanism vs. an example that only verifies]` This is the single most instructive contrast in the chapter, and it is easy to read past.** Tao's verdict on this computation is: "**The way it works when $p=5$ shows the way for the general case.** Based on the above examples it looks like the residue classes $1/1, 1/2, 1/3, \dots, 1/(p-1)$ (mod $p$) are just a rearrangement of the numbers $1, 2, 3, \dots, (p-1)$ (mod $p$)." Compare his verdict on the *structurally identical* computation four pages earlier, at $p=5$ mod 25 (step 12): "The numbers 1, 13, 17, and 19 seem to be random, but 'magically' add up to the right amount. Perhaps it is a fluke… It is not clear how everything manages to cancel out modulo $p^2$." Same problem, same prime, same act of computing a case — and opposite value. The difference is that mod 25 the intermediate numbers are opaque, whereas mod 5 they are visibly a *shuffle of $1,2,3,4$*, and a shuffle is a mechanism you can name and then prove. **When you compute a case, ask which one you have got: a case that confirms the claim, or a case in which you can see the reason. Only the second kind advances you, and the way to tell is whether you can describe the intermediate numbers in words.**
27. `[rearrangement / bijection]` Since $1/1, 1/2, \dots, 1/(p-1)$ is a permutation of $1,2,\dots,p-1$ mod $p$ — "a proof of this fact will be given at the end of this discussion", `[defer a routine lemma]` — the squares $1/1^2, 1/2^2, \dots, 1/(p-1)^2$ are a permutation of $1^2, 2^2, \dots, (p-1)^2$. So
    $$\frac{1}{1^2}+\frac{1}{2^2}+\cdots+\frac{1}{(p-1)^2} = 1^2+2^2+\cdots+(p-1)^2 \pmod p.$$
    "This is an easier expression to deal with, because we have removed the reciprocals, which are a nuisance when trying to sum things."
28. `[kill the sum with a closed form]` "we can now get rid of the sum altogether, using the standard formula $1^2+2^2+\cdots+n^2 = \frac{n(n+1)(2n+1)}{6}$ (which is easily proven by induction)". With $n = p-1$, (8) reduces to
    $$\frac{(p-1)p(2p-1)}{6} = 0 \pmod p.$$
29. `[use the hypothesis you have been carrying]` "And one can easily show that this is true when $p$ is a prime greater than 3 (because $(p-1)(2p-1)/6$ is an integer in this case)." *(Why: $p>3$ prime means $p$ is divisible by neither 2 nor 3. $p$ odd ⟹ $2 \mid p-1$. Mod 3, $p \equiv 1$ or $2$: if $p\equiv1$ then $3\mid p-1$; if $p\equiv2$ then $2p-1 \equiv 3 \equiv 0$, so $3 \mid 2p-1$. Either way $6 \mid (p-1)(2p-1)$, so the whole expression is $p \times$ an integer, hence $\equiv 0 \pmod p$.)* **This is where the "greater than 3" in the problem statement finally cashes out — seven pages after it was stated.** $\square$

**Tao's own moral (p. 33).**

> "So that is it. We keep reducing the equation to simpler and simpler formulations, until it just collapses into nothing. A bit of a long haul, but sometimes it is the only way to resolve these very complicated questions: step-by-step reduction."

**The deferred lemma (p. 33).** `[defer a routine lemma]` Only at the very end does he prove the permutation fact he had been using: the reciprocals $1/1, 1/2, \dots, 1/(p-1)$ mod $p$ really are a permutation of $1, 2, \dots, p-1$. His proof: "This is equivalent to saying that each non-zero residue (mod $p$) is the reciprocal of one and only one non-zero residue (mod $p$), which is obvious." *(Unpacked: "$x$ is the reciprocal of $y$" means $xy \equiv 1$; the relation is symmetric, and for each $y$ there is exactly one such $x$ because $p$ is prime. So reciprocation is a bijection of $\{1,\dots,p-1\}$ onto itself — and a sum over a set does not care about the order of its terms.)* Note the presentation choice: an obvious lemma stated in the middle of the argument would have interrupted the narrative, so it goes at the end.

**The full reduction chain, for reference.** Each line implies the one above it:

```
p² | numerator of reduced 1/1+…+1/(p−1)
  ⇑  (cancellation cannot remove a factor of p, since (p−1)! is coprime to p)
p² | unreduced numerator  =  Σ (p−1)!/i
  ⇑  (factor out (p−1)!, then divide it out — legal, coprime to p²)
1/1 + 1/2 + … + 1/(p−1) ≡ 0  (mod p²)
  ⇑  (pair 1/j with 1/(p−j); each pair yields p /(j(p−j)) — extract the factor p)
Σ_{j=1..(p−1)/2}  1/(j(p−j)) ≡ 0  (mod p)          ← modulus dropped from p² to p
  ⇑  (p−j ≡ −j, so j(p−j) ≡ −j²)
Σ_{j=1..(p−1)/2}  1/j² ≡ 0  (mod p)
  ⇑  ("double up" using (−a)² = a²)
1/1² + 1/2² + … + 1/(p−1)² ≡ 0  (mod p)                                   … (8)
  ⇑  (reciprocals are a permutation of the residues)
1² + 2² + … + (p−1)² ≡ 0  (mod p)
  ⇑  (closed form)
(p−1)p(2p−1)/6 ≡ 0  (mod p)    — true because 6 | (p−1)(2p−1) when p > 3
```

**Transferable lesson.** A hard target can be reached by a long chain of *equivalences and implications*, each individually easy to justify, provided you (i) audit every link, (ii) keep a written list of your tactical objectives so you can tell progress from wandering, (iii) accept locally ugly steps that buy globally weaker obligations, and (iv) keep every proof you have found even after discarding it, because the discarded one may be the one that scales.

---

## Exercise 2.5 (p. 33) — For $n \ge 2$, show that $1/1+1/2+\cdots+1/n$ is *not* an integer

**Tao's hint.** "You will need *Bertrand's postulate* (actually a theorem), which shows that given any positive integer $n$ there is at least one prime between $n$ and $2n$."

*Check the claim on small cases: $1+\tfrac12 = 1.5$; $1+\tfrac12+\tfrac13 = \tfrac{11}{6}$; $1+\tfrac12+\tfrac13+\tfrac14 = \tfrac{25}{12}$. None is an integer.*

**The chain of moves** *(hint is Tao's; the argument below is my working)*.

1. `[find the obstruction — one bad prime is enough]` A fraction fails to be an integer as soon as *one* prime survives in its reduced denominator. So look for a prime that appears in exactly one of the $n$ denominators — it will have nothing to cancel against.
2. `[use the given tool]` Let $p$ be the **largest** prime with $p \le n$. (One exists since $n \ge 2$ and 2 is prime.) By Bertrand's postulate there is a prime $q$ with $p < q < 2p$. Since $p$ is the largest prime $\le n$, we must have $q > n$, and therefore $2p > q > n$, i.e. $2p > n$.
3. `[consequence]` Because $2p > n$, the only multiple of $p$ in the list $1, 2, \dots, n$ is $p$ itself. So $p$ divides exactly one denominator, once.
4. `[clear denominators and count factors of p]` Let $M = \mathrm{lcm}(1,2,\dots,n)$. Since $p \le n < 2p \le p^2$ (as $p\ge2$), $M$ contains the prime $p$ to exactly the first power. Now
   $$M\left(\frac11+\frac12+\cdots+\frac1n\right) = \sum_{k=1}^{n} \frac{M}{k}.$$
   For every $k \ne p$, the integer $M/k$ still contains that single factor of $p$, so $p \mid M/k$. For $k = p$, the factor of $p$ is consumed, so $p \nmid M/p$.
5. `[contradiction]` The sum on the right is therefore ($p$ times something) $+$ (something not divisible by $p$), so it is **not** divisible by $p$. But if $H_n = 1/1+\cdots+1/n$ were an integer, then $M \cdot H_n$ would be a multiple of $M$, hence of $p$. Contradiction. So $H_n$ is not an integer. $\square$

**Where Bertrand is really used.** Only to guarantee $2p > n$ — i.e. that the largest prime below $n$ is more than half of $n$, so that its double has already escaped the range. Without that, $p$ might divide two denominators and cancel.

**Transferable lesson.** To prove a rational number is not an integer, do not compute it — find a *single* prime whose behaviour is anomalous, and show it cannot cancel. This is the "one obstruction suffices" pattern, structurally the same as the mod-5 obstruction in Exercise 2.3: you never need global control, only one place where things go wrong.

---

## Exercise 2.6 (p. 34) (\*) — For prime $p$ and positive integer $k$ **not** divisible by $p-1$, show that $p$ divides $1^k+2^k+3^k+\cdots+(p-1)^k$

**Tao's hint (unusually detailed — effectively a proof sketch).** "since $k$ could be even, we cannot always use the cancelling trick. However, the rearranging trick will be effective. Let $a$ be a generator of $\mathbf{Z}/p\mathbf{Z}$, so that $a^k \neq 1 \pmod p$ when $k$ is not a multiple of $p-1$. Now compute the expression $a^k+(2a)^k+\cdots+((p-1)a)^k \pmod p$ in two different ways."

**Background the hint assumes.** $\mathbf{Z}/p\mathbf{Z}$ is the integers mod $p$. A **generator** (primitive root) is an $a$ whose powers $a, a^2, \dots, a^{p-1}$ run through all of $1,2,\dots,p-1$ mod $p$. Example $p=5$, $a=2$: $2, 4, 3, 1$ — all four nonzero residues, so 2 is a generator mod 5. The consequence used here: $a^k \equiv 1 \pmod p$ happens **only** when $(p-1) \mid k$. Such an $a$ exists for every prime.

**The chain of moves** *(hint is Tao's; the execution is my working)*.

Write $S = 1^k + 2^k + \cdots + (p-1)^k$, and consider $T = a^k + (2a)^k + \cdots + ((p-1)a)^k \pmod p$.

1. `[compute one thing two ways — the classic counting move]` **Way 1: factor out $a^k$.** Each term is $(ja)^k = j^k a^k$, so
   $$T = a^k\big(1^k+2^k+\cdots+(p-1)^k\big) = a^k S \pmod p.$$
2. `[rearrangement / bijection]` **Way 2: multiplication by $a$ permutes the nonzero residues.** For $a \not\equiv 0$, the map $j \mapsto ja \bmod p$ is a bijection of $\{1,2,\dots,p-1\}$ onto itself. *(Injective because $ja \equiv j'a$ implies $j \equiv j'$ — we may divide by $a$ since $a$ is coprime to the prime $p$; and an injective map of a finite set to itself is a bijection.)* So the multiset $\{a, 2a, \dots, (p-1)a\}$ *is* $\{1, 2, \dots, p-1\}$ mod $p$, just shuffled — and a sum does not care about order:
   $$T = 1^k + 2^k + \cdots + (p-1)^k = S \pmod p.$$
3. `[equate and cancel]` Therefore $a^k S \equiv S \pmod p$, i.e.
   $$(a^k - 1)\,S \equiv 0 \pmod p.$$
4. `[use the hypothesis]` Because $(p-1) \nmid k$ and $a$ is a generator, $a^k \not\equiv 1$, so $a^k - 1 \not\equiv 0 \pmod p$. Since $p$ is prime, a product is $0$ mod $p$ only if a factor is — so $S \equiv 0 \pmod p$. $\square$

**Concrete instance.** $p=5$, $a=2$, $k=1$: $S = 1+2+3+4 = 10 \equiv 0 \pmod 5$ ✓, and $T = 2+4+6+8 = 20 = 2^1\times10$, which is also $2+4+1+3 \equiv 10$ mod 5. $k=2$: $S = 1+4+9+16 = 30 \equiv 0$ ✓ ($4 \nmid 2$). $k=4$: now $4 \mid k$, the hypothesis fails, and indeed $S = 1+16+81+256 = 354 \equiv 4 \not\equiv 0$ — this is exactly the "not divisible" half of **Problem 2.5**, which is the $p=5$ case of this exercise. The chapter's easiest sums-of-powers problem is a special case of its last exercise.

**Transferable lesson.** *Compute a single quantity in two different ways and equate the answers.* One computation exposes algebraic structure (factoring out $a^k$), the other exposes combinatorial structure (the shuffle). The equation between them contains information neither computation had alone. This is one of the most broadly reusable moves in all of mathematics, and it is also why Tao insisted on keeping the *rearrangement* proof in Problem 2.7: rearrangement survives the loss of anti-symmetry, cancellation does not.

---
---

# What this chapter teaches about problem solving in general

**1. Reformulation is the primary activity; solving is what happens at the end.** Across seven problems, Tao spends the overwhelming majority of the text *changing the question*. Problem 2.2 passes through five successive versions of its own statement; Problem 2.7 passes through eight. In both cases the final mathematical step is a one-liner. The skill being taught is not deduction — it is the manufacture of a statement that is *equivalent enough* and *tractable enough*, and the discipline to prove each link. His summary line is the chapter's thesis: "We keep reducing the equation to simpler and simpler formulations, until it just collapses into nothing... step-by-step reduction."

**2. Throw away information deliberately.** The single most counter-intuitive lesson here is that *having less information can make a problem easier*. "Why burden yourself with data that cannot be used? It will just be a distraction." (p. 14) Tao repeatedly replaces exact descriptions (which digits, the reduced numerator, one of 18 consecutive numbers) with coarse invariants (digit count, digit sum mod 9, any multiple of 18). What you keep must be *usable* — a concept with theorems attached — even if it is far weaker than what you discarded. The cost is that you must now prove more; the benefit is that you now *can*.

**3. Dead ends are the majority of the work, and they should be narrated, budgeted, and mined.** In this chapter Tao abandons: direct manipulation of the digit formula (P2.1); expanding $100a+10b+c$ (P2.1); the "same digit count" reformulation (P2.2); the "digit sum" reformulation (P2.2); pure number theory on $(a+b)^2=nab$ (P2.3); the analytic/Pell's-equation route (P2.4); factorization for odd $n$ (P2.4); mod $x$ and mod 7 (P2.4); mod 2 (P2.4); a factorization of $\sum i^k$ (P2.6); induction (P2.6); the sum form of the divisor (P2.6); and — most strikingly — a *correct and complete proof* of (7) (P2.7). Every one of these is accompanied by a reason. Three habits follow: **abandonment is temporary** ("re-apply number theory later if algebra failed", p. 20); **failures leave residue** (the failed digit-count step still proved "at most four powers of 2 per digit count"); and **failures are diagnostic** (comparing your fact-count against a problem you already solved tells you what is missing).

**4. Choose your tools by asking what success would look like.** The sharpest predictive idea in the chapter: mod 7 and mod $x$ were doomed in Problem 2.4 not because of any computation, but because if they had worked they would have proved too much — they would have eliminated every case, contradicting the known existence of a solution (p. 22). The same reasoning in reverse licenses the total obstruction in Exercise 2.3, where "no solutions" *is* the answer. **Before you compute, ask what a successful computation would imply. If the implication is false, skip the computation.**

**5. Cheap moves come first, in a fixed order.** Guess the answer from circumstantial evidence. Generate data. Tabulate. Interrogate the constants. Try elementary tools. Look for "the elegant (i.e. lazy) way out". Only then reach for machinery. The justification is explicitly a cost-benefit one, not an aesthetic one: "If you are right, you have saved a lot of time by not pursuing the hard ways. If you are wrong, you were doomed to a long haul anyway." (p. 14) The whole chapter is an argument that expected-cost reasoning about *which attempt to make next* is a mathematical skill.

**6. Accept a locally worse expression for a globally weaker obligation.** Problem 2.7's pivot — pairing terms to manufacture a factor of $p$ — makes the formula uglier and the goal easier, dropping the modulus from $p^2$ to $p$: "Now this, at first, looks like a complication rather than a simplification. But we have gained a very important factor of $p$." (p. 31) Learn to price these trades. Expressions are yours to complicate; obligations are what you must discharge.

**7. Keep a written list of tactical objectives, and use it to distinguish spiralling from circling.** Problem 2.7 opens with two numbered objectives and reports when each is met. That bookkeeping is what lets Tao notice that his new goal (8) *resembles* an earlier goal (7) but *implies the original*, whereas (7) did not: "we are going around in spirals, heading towards a solution." (p. 32) Without the list, the resemblance would have read as evidence of futility. **Track which of your results are on the critical path.**

**8. Value a proof for its extensibility, not only its correctness.** Tao throws away a valid, short proof of (7) because its mechanism cannot survive the move to mod $p^2$: "Instead of floundering around trying to fit a square block into a round hole... it is better to find a block that is more round." (p. 30) Then, having built a second proof, he keeps *both* — and when he needs to finish (8), it is the discarded first proof (rearrangement) that works, because the second (cancellation) needs anti-symmetry that (8) does not have. **Two proofs of a lemma are two tools for the next lemma.**

**9. Small structural facts do the heavy lifting.** The finishing blows in this chapter are all one-liners: squares are $0$ or $1$ mod 4; a number is congruent to its digit sum mod 9; $64 \equiv 1 \pmod 9$; $(-a)^k = -a^k$ for odd $k$; $\gcd(m, 2m+1)=1$; multiplication by a nonzero residue permutes the nonzero residues; $n \equiv -c \pmod{n+c}$. None is deep. Tao's instruction is to *collect* them and *write them down*, because you will not recall them under pressure: "Write down any facts which could be of use to your problem, even if they are simple... Even shallowly dug gold has to be searched—and held on to." (p. 15)

**10. Housekeeping is technique.** Define $\overline{abc}_{10}$ so it cannot be confused with $abc$. Substitute $n = 2m$ so you never write $n/2$. Reuse $p=5$ so you can reuse the arithmetic. Tabulate $1^n, 2^n, 3^n, 4^n$ separately rather than only their sum, so the pattern's *cause* is visible. Defer the obvious lemma to the end so it does not interrupt the narrative. "little housekeeping things like this help a solution run smoothly" (p. 25) — the friction you remove is friction you would otherwise have spent attention on.

**11. Read the genre before you read the problem.** Tao classifies constantly, at three different scales, and each classification pays. *Chapter scale:* the three sections (Digits / Diophantine equations / Sums of powers) each come with a named toolkit, and in the Digits section he warns in advance that the object is a recreational one that higher mathematics does not use — which correctly predicts that the digits will be discarded in both digit problems. *Problem scale:* "a 'Prove that' question, not a 'Find a'" (p. 27); "find all solutions" means "eliminate all but finitely many" (p. 22); "this problem is from a mathematics competition" means guess the cheap answer (p. 14). *Sub-genre scale:* Problem 2.7 is announced as "a special type of 'sums of powers' problem, namely sums of reciprocals" (p. 26), and that label is the retrieval key he uses on p. 30 when he needs a new idea ("if we are fresh from solving Problem 2.6…"). **Classification is not bureaucracy; it is how you get a non-random first guess and a prediction about which features are real.** The counterweight is on p. 20: genre never settles difficulty — Diophantine equations with a variable exponent include both Problem 2.4 (two pages) and Fermat's Last Theorem, so "Fortunately, there are other problems involving exponents which are easier to handle."

**12. Distinguish an example that verifies from an example that explains.** The same computation — the case $p=5$ of Problem 2.7 — appears twice, and Tao's reaction is opposite each time. Mod $p^2$ it produces the numbers 1, 13, 17, 19, which "seem to be random, but 'magically' add up to the right amount. Perhaps it is a fluke" (p. 29) — and he changes tack. Mod $p$ it produces 1, 3, 2, 4, which are visibly a shuffle of $1,2,3,4$, and now "the way it works when $p=5$ shows the way for the general case" (p. 33) — and he proves the general theorem straight from it. **The test is whether you can describe the intermediate numbers in words. If you can, the example contains the proof; if you cannot, the example contains only reassurance, and reassurance is not progress.** The same discipline shows up as a *rejection* criterion in Problem 2.2, where he estimates that his invariant collides by accident about 9.5% of the time and concludes it is too weak to separate anything: quantify the base rate of accidental agreement before you trust an agreement.

**13. Finally, calibrate how much rigour a step needs, and be honest when a step is guesswork.** Tao freely conjectures ("experimentation shows that multiples of 18 seem to work. But why?"), freely estimates ("highly probable (though not proven!)"), and freely computes with a machine ("I used a computer for that, not some tricky mathematics") — but he marks each as what it is, and he draws a hard line at reformulations, where he audits every single link. **Be loose while exploring; be strict about the logical skeleton.**

---

*Sources: Terence Tao, "Solving Mathematical Problems: A Personal Perspective", 2nd ed., OUP 2006, Chapter 2 "Examples in number theory" (printed pages 9–34), comprising sections 2.1 Digits (pp. 10–19), 2.2 Diophantine equations (pp. 19–22), and 2.3 Sums of powers (pp. 23–34). All quotations are short excerpts from that chapter, cited by printed page number. Problem attributions as printed: 2.1 and 2.4 Taylor 1989 (pp. 7 and 7), 2.2 Taylor 1989 (p. 37), 2.3 Australian Mathematics Competition 1987 (p. 15), 2.5 Hajós et al. 1963 (p. 74), 2.6 and 2.7 Shklarsky et al. 1962 (pp. 14 and 17). Difficulty stars as printed: Problem 2.6 is (\*\*), Exercise 2.6 is (\*); nothing else in the chapter is starred.*

*Solutions to Exercises 2.1–2.6 are my own working, following Tao's stated hints; the book supplies hints only (and Exercise 2.3 has no hint at all).*

*Two places where the printed text appears to slip are flagged inline rather than silently corrected, because in both cases the slip is exactly the kind of mistake the surrounding technique invites: (i) p. 30 writes the $p=11$ sum as "$1/1+1/2+\cdots+1/11$" where the ten listed residues correspond to $1/1$ through $1/10$; (ii) p. 16 writes "Again, if this question is true, the original question is true", which is the reverse of the implication he needs and of his own note on p. 15 that "a 'yes' answer to this question does not necessarily yield a 'yes' answer to the original problem".*

*One correction to an earlier draft of this file: the multiples-of-9 stepping stone in Problem 2.1 is **not** false. Tao's actual verdict (p. 12) is "Now this particular stepping stone (considering multiples of 9) does work, but a bit of extra work is needed to cover all the cases. It is actually better to use multiples of 18." What is false is the convenient lemma "every multiple of 9 satisfies (1)", the counterexample being 909.*

