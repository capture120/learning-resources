# Chapter 03: First Principles — Examples

### getPreviousDayOfWeek (JCommon library)

The chapter's Functions section uses a function adapted from the JCommon library that finds the date of a given weekday before a given date. The original is one ~20-line function containing two commented snippets — `// check arguments…` and `// find the date…` — plus fiddly adjustment arithmetic with `Math.min`/`Math.max`.

Martin's rule: if a snippet of lines does something you can reasonably name, move it into a function named for what it does. Extracting the two snippets yields:

```java
public static Date getPreviousDayOfWeek(int weekday, Date from) {
    checkWeekdayArgument(weekday);
    return addDays(-daysBefore(weekday, from), from);
}
```

with `checkWeekdayArgument` and `daysBefore` as small private helpers (and the extraction itself simplified the date math). The top function is now short and obvious: you read it, agree with it, and move on. If you need more, the extracted functions are right below — but most often you won't need to look.

A "Future Bob" aside adds a finer point: he dislikes the leading minus sign and says a `subtractDays` function would have been better. "That's a small thing, but small things matter."

Lesson: extract nameable snippets into small, verb-named functions so the calling code reads like well-written prose.

### The Uncle Bob Conference Room system

The chapter's centerpiece: a single `Statement` class for a conference-center rental business. Customers rent small rooms ($100/day), large rooms ($150/day), projectors ($50/day), coffee ($10/day), and cookies ($15/day). Rooms get a 10% discount for a 5-day week; nonfood items carry 5% tax; renting a large room plus coffee for a week earns a day of free cookies.

The original `Statement` class works and is "not too hard to understand, but you can tell that it was slapped together": the `rent` method mixes unit prices, discount eligibility, price, and tax in inline `switch` statements, and `getItems` hides the cookie-bonus rule. Martin's framing: this program *grew* — it started renting one small room, then large rooms, then coffee, then discounts, then the bonus. After a CEO speech promising new markets, new tax laws, and new promotions, you know it will keep growing and "degrade, like a piece of rotting meat" — so tidy it up first. The refactoring proceeds in deliberate stages, each driven by a named principle:

**Stage 1 — Extract method (SRP).** Pull `rent` apart into `getUnitPrice`, `calculatePrice`, `isEligibleForDiscount`, and `getTax`: gather what's related, separate what's different. Yes, it's more code — but not more *executable* code, just more names and structure, and that structure makes room for growth: tax-rule changes will now grow `getTax`, not `rent`. The stakeholder argument: tax stakeholders will most probably be the only ones touching `getTax`; discount stakeholders most likely the only ones touching `calculatePrice`/`isEligibleForDiscount`. Violating SRP risks *fragility* — changing taxes breaks discounts — which terrifies stakeholders into concluding the team has lost control of the system.

**Stage 2 — Replace switches with data (OCP).** The switches mean adding a new item (`NotePads`) requires edits in up to five places. Moving `unitPrice` and `taxRate` into the enum constructors — `SMALL_ROOM(100, .05)`, `COFFEE(10, 0)` — cuts that to two. Then the enum moves into its own `CatalogItem.java` file so adding an item leaves the `Statement` module untouched: keep new changes out of old modules.

**Stage 3 — Invert dependencies (DIP).** Adding `NotePads` would still probably recompile `Statement.java` (the safe bet is to assume so), even though `rent` needs to know nothing about notepads — high-level policy depending on a low-level detail. First the class is split (SRP again): `RentalItem` becomes its own record, and an `ItemList` class takes the list plus the cookie-bonus logic. Then `CatalogItem` becomes an *interface* (`getUnitPrice`, `getTaxRate`, `isEligibleForDiscount`, `getName`) with one small class per item — `SmallRoom`, `LargeRoom`, `Coffee`, `Cookies` — each holding its own price, tax rate, and discount rule. Switches give way to polymorphic calls. To the worry that this chops the code into too many pieces, Martin answers twice: the assumption is growth, and the resulting directory structure is "a nice road map that will help anyone understand the organization." Trade-off acknowledged: the record's `type` field becomes a `String` token, sacrificing a bit of static type safety — a loss that "always accompanies" isolating low-level details from high-level policy.

**Stage 4 — Extract the bonus and rename (SRP + naming).** `getItems` "gives me the willies" — the cookie bonus hiding inside it smells of an SRP violation. A `Bonus` interface is created, `CookieBonus` implements it, and the list class iterates all bonuses to finalize the order. That insight forces renames: `ItemList` becomes `RentalReceipt` (it finalizes the order) and `Statement` becomes `RentalOrder`. The point about naming: when the problem was small, vague names were affordable; as it grows, names keep the concepts straight. Discount logic also moves fully into the items (`getDiscountedPrice`), so virtually all business rules flee `RentalOrder` — only tax and total arithmetic remain.

**Result.** A dependency diagram shows a "curvy border line" — an architectural boundary — between a high-level component (`RentalOrder`, `RentalReceipt`, `CatalogItem`, `Bonus`, `RentalItem`) and a low-level component (the item classes and `CookieBonus`). All dependencies cross toward the high-level side. The details are now a plug-in: changing the price of cookies, the tax on coffee, or adding `NotePads` never recompiles or redeploys the policy. The two components can ship as separate jars; in a JavaScript/browser setting, if the browser caches the components, only the changed one re-downloads — which could be a big advantage on slow networks. One concern is left open: the concrete `RentalItem` record forces broad recompiles if it changes; a hash map could fix that, but it's "a battle for another day."

Lesson: the whole arc shows SRP, OCP, and DIP applied in sequence to make room for expected growth, with every trade-off (more pieces, lost type safety, indirection) counted and accepted on purpose.

### YAGNI, answered

When a first-edition commenter calls plug-in-style code like this "just dreadful," Martin anticipates the charge of violating YAGNI. He corrects the acronym's folklore: it was never the verdict "You Aren't Going to Need It" but the question "What if you aren't going to need it?" — an instruction to count the cost before building room for things you might not need. Given the CEO's expansion plans, the team answers: "Yes, we are going to need it." Lesson: YAGNI is a cost-benefit question, and growth evidence can legitimately answer it yes.

### The tests behind the refactoring

The reader may wonder where all the item classes get instantiated — the answer is the tests. `RentalOrderTest` builds a `RentalOrder`, registers a `CookieBonus`, and checks receipts and totals across the pricing rules (one room one day, the week discount, no tax on coffee, the free-cookies bonus). These tests were written *before* the refactoring began and were kept passing at every step. Test churn stayed small because the tests were decoupled from production details — e.g., final fields named like the old enum constants (`SMALL_ROOM = new SmallRoom()`) absorbed the enum-to-class change "without too much fuss." Lesson: refactor under a green test suite, and design tests so production restructuring barely touches them.

### Future Bob on Grok3

Two asides track an LLM's performance on the same problem. Asked to improve the original `rent` function, Grok3 produced nearly the same extract-method cleanup Martin did — unsurprising. But it never inverted the dependencies or separated high-level policy from low-level detail. Martin's conclusion: LLMs have their uses, but they "are not adept at understanding higher architectural goals." Lesson: mechanical cleanup can be automated; LLMs are not adept at the higher architectural judgment about where a system is heading.
