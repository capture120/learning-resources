# Chapter 09: The Clean Method — Examples

The chapter is one long worked example: Martin builds a "Tax Calculator" for the mythical state of Bobolia, in Python, using TDD, refactoring, design principles, and design patterns. The point is to *watch* clean code being written — every design decision happens incrementally inside the work-then-clean loop. The stages below follow his narrative.

### The two writing loops (then and now)

Martin opens by contrasting the modern loop (write a small bit of code, compile and test, repeat — five seconds to an hour) with the loop of programming's earliest days (hand-write a large batch, desk-check it, submit it to be encoded by hand into machine-readable form, then compile — one to three days). When cost per line was enormous, people planned heavily up front; now that cost is trivial, we explore by failing fast. The lesson: in *both* eras, cleaning the code got ignored — in the past because editing paper was painful, today because the tight loop makes progress so fast that pausing to clean feels like wasted time. Modern tooling has removed the excuse.

### The sushi chef

A one-line image anchoring the chapter's discipline: be like the sushi chef who never stops making sushi and never stops cleaning the implements and the environment. Cleaning is interleaved with the work, not deferred to a "cleanup phase."

### Degenerate first pass: fail, then hard-code the answer

The first test asserts that a 50,000-bobble salary owes 7,500 in tax (Bobolia's 15% base rate). Martin makes it pass with a `get_tax` that literally returns `7500` — after first making it fail by returning 0. "First we see the test fail, and then we make it pass. If that sounds like a waste of time... this simple practice has saved me a lot of debugging time." Lesson: start degenerate; let tests force real logic into existence.

### Early design churn is normal

Adding the second rule (no tax at or below 30,000) prompts immediate design changes: the `tax_return` moves from the constructor into the `get_tax` argument, and names are fixed to follow PEP 8. Later, test names are improved too ("name improvement is something that often takes place once you know more about the application"). Lesson: revisit interface and naming decisions continuously as understanding grows.

### The fairness rule

A citizen earning 30,001 shouldn't pay 4,500 in tax, so no after-tax income may fall below 30,000. The test asserts tax of 1 on a 30,001 salary. The implementation computes the tax, then caps it so after-tax income stays at 30,000. Lesson: each new rule arrives as a test first, and the production code is reshaped (not just appended to) to absorb it.

### The `make_return` test builder

Adding "badbobs" (social-demerit points) to the tax return would have forced edits to every existing test. Martin stops: "Anytime you have to go back and change a bunch of tests, it means there's a flaw in the design of your tests." He introduces a builder:

```python
def make_return(args):
    tax_return = {"income": {"salary": 0}, "badbobs": 0}
    tax_return.update(args)
    return tax_return
```

Omitted fields get sensible defaults, so new fields no longer break old tests. This is the chapter's clearest demonstration of decoupling tests from production-code data expectations.

### From mess to extracted methods to a class that earns its keep

After class-1 badbobs (alcohol purchases taxed at 50%) land, `get_tax` is "getting messy," so Martin extracts `determine_base_tax` and `determine_badbob_adjustment`. He then questions the class itself ("the class is just forcing me to add self everywhere") but keeps it for the namespace and so methods can communicate through instance variables instead of arguments. Lesson: small extractions happen the moment mess appears, and design doubts are voiced and tested rather than suppressed.

### The class-2 if/elif chain becomes a table

Class-2 badbobs (gas-car purchases) add tax per a four-row rate table. The first passing implementation is an if/elif chain full of magic numbers (`if class2 < 1001 ... elif class2 < 10001 ...`). Martin calls it "pretty awful": the numbers and even the number of rows will change, so maintaining the chain is labor intensive and error prone. He replaces it with a data table plus a lookup loop:

```python
class2_table = ((1001, 0), (10001, 0.05), (50001, 0.1), ("max", 0.15))
```

He also peels badbob logic into its own `BadBobAdjuster` class for the namespace. This is where he states the chapter's central observation: the production code is evolving to become more generic while the tests grow linearly and become more specific — which keeps the tests from knowing too much about the production code.

### The negative-tax bug

A new rule (badbobs may not push after-tax income below 20,000) produces a surprise: the test returns a tax of −9,000 bobbles. Negative tax — citizens would love it, the Bobolia Revenue Service would not. The bug is in `determine_base_tax`, fixed with a guard returning 0 for incomes at or below 30,000. Lesson, in Martin's words: "TDD is not a magic bullet. You will still write some bugs. Fortunately... other tests are likely to uncover those bugs." He then cleans the two ugly guards into `max(0, ...)` expressions.

### Tax brackets: rewriting the rules without rewriting every test

Bobolia adopts progressive tax brackets, invalidating most expected values. Since most tests used a 50,000 salary, Martin creates a constant `tax_50K = 3000` and uses it everywhere, so future rate changes touch one line. He also moves `make_return` into the test class, adds `make_simple_return` and `get_tax` helpers, then cleans the tests further with composed assertions:

```python
def assert_tax_for(self, income, tax):
    self.make_simple_return(income)
    self.assertEqual(tax, self.get_tax())
```

The bracket logic itself, first an if/elif chain, becomes a `tax_brackets` table with a loop — "any new bracket can be added easily." He notes the tests are now positioned to become parametric (table-driven) but declines: "I don't think we're there yet." Lesson: production code gets table-driven eagerly; tests only when actually needed.

### Why the tests don't share the production table

Asked whether tests should use the same `tax_brackets` table, Martin declines: he's "usually not in favor" of letting tests know the details of the production code, because tests are "a second statement of intent," and it makes little sense to use the production code to test the production code. So he prefers to compute expected values manually and enter them into the tests.

### The final architecture: SRP, DIP, Strategy, and the "classitis" defense

Stepping back, Martin dislikes the reciprocal relationship (BadBobAdjuster reaching into TaxCalculator's fields) and the asymmetry (badbobs got a class; brackets didn't). He refactors into four components — main, `TaxCalculator`, `TaxBracketter`, `BadBobAdjuster` — plus a `TaxReturn` class that hides the raw dict structure from the rest of the application. This cleanup requires only minor changes to the tests, "so our test design is holding up." He preempts the "classitis" accusation: the new classes "do not add any complexity that wasn't already there. They just move that complexity into nicely named places." ("A place for everything, and everything in its place!")

He then draws an architectural boundary around the core classes, applying the Single Responsibility Principle and Dependency Inversion Principle so every arrow crossing the boundary points inward (the Dependency Rule): high-level policy inside, details outside. `TaxCalculator` uses the Strategy pattern, receiving `TaxBracketter` and `BadBobAdjuster` from main — and in this case the tests *play the role of main*, constructing and injecting the strategies in `setUp`. Because Python is duck-typed, the "interfaces" are just the method signatures TaxCalculator expects; no separate interface entities are needed.

### Closing self-assessment

Martin admits he's not a Python programmer and has likely violated conventions, and that the names (`TaxBracketter` — spelling error and all — `BadBobAdjuster`) could be improved by others. But the goals stand: four components behind boundaries, tests that survived heavy change, algorithms isolated from each other, and flexibility via tables. He also praises the tooling — IntelliJ's Python plug-in and Copilot helped someone who hadn't written Python in over 20 years — and the test speed: used to JVM startup times, he finds it "a joy to have the test results pop up on the screen before my fingers have left the test button." The summary line of the whole exercise: "As the tests grew in specificity, the production code grew in generality."
