# Chapter 21: Continuous Design — Examples

The chapter's running example is "Czecher," a flash card application for learning Czech nouns and grammar. Most examples are before/after refactorings judged against the four Cs (Clarity, Conciseness, Confirmability, Cohesion), plus two war stories about duplication and fear.

### Translating a goal into behaviors: the flash card sequence
The chapter's first example is not code but decomposition. The end goal "present a random list of flash cards for learning Czech nouns" becomes a sequence of small behaviors: retrieve a random subset of nouns; for each, present a fill-in-the-blank question with four multiple-choice noun forms, capture the user's choice, show the correct answer if wrong; then repeat the missed questions. The book stresses there are many alternative behavior sets (retry until correct, hints on failure, graduating to fill-in-the-blank) — and orders of magnitude more (in fact infinite) choices for the underlying code, most suboptimal. Lesson: developers must first translate end goals into smaller software behaviors, and every choice along the way is design.

### Refactoring `retrieveWords` for clarity
The book opens with a working but unclean function: `retrieveWords` builds an LLM prompt by looping over words with index arithmetic to quote and comma-join them, computes a "word"/"words" prefix with a ternary, sends the prompt, and slices JSON out of the response with `indexOf('[')`/`lastIndexOf(']')`. Deciphering it takes a half minute or two — "not necessarily bad code, but it could easily be better," hence unclean: it wastes reader time.

The refactor extracts three tiny intention-revealing helpers — `sliceJSONArrayFrom(response)`, `joinQuoted(words)` (`words.map(word => `"${word}"`).join(',')`), and `pluralizeIfMany(word, list)` — leaving `retrieveWords` a short statement of policy readable in about fifteen seconds. Each helper is one to three lines of hidden detail you can ignore "for now and maybe forever," and if one must change, you can edit it without considering any other code. Lesson: extract implementation detail into named functions so policy-level code reads fast.

### The idiomatic loop that hides a defect
Addressing the objection that seasoned developers instantly digest short phrases anyway, the book shows two loop headers:

```js
for (let i = 0; i <= words.length; i++)   // likely a defect
for (let i = 0; i < words.length; i++)    // the actual idiom
```

Many readers don't pause at the first one because it *looks* idiomatic. Lesson: even familiar-looking detail demands careful token-by-token reading and can hide off-by-one defects; replacing detail with named declarations (like a functional pipeline) removes the opportunity for such defects to hide.

### Streamlining a pipeline: `mostExpensiveHighlyRatedBookInEachCategory`
A functional pipeline chains `flatMap`, two `filter`s with inline lambdas, a `sort` comparator, a `map`, and `slice(0, 1)`. The inline lambdas break the flow and force stepwise reading. The refactor names every lambda — `hasTitle`, `highlyRated`, `byPrice`, `categoryAndTitle` — so readers scan past the one-liner declarations and read the return statement as pure abstracted flow.

Two follow-on nuances: the remaining `.slice(0, 1)` idiom (first element, or empty array) stays — idioms are kept unless they bring readers to a grinding halt, in which case you abstract them (e.g., a `firstOrDefault` function). And extracting functions exposed misplaced logic: some helpers probably belong in a `book` module — extraction routinely reveals cohesion improvements.

### `generateCard`: clear-but-not-concise, then three passes of cleanup
A flash card generator is presented that many developers would call fine: a top-to-bottom function with clear variable names and guiding comments ("// Select a random adjective and noun...", a comment-laden `randomInt` spread over four lines). "The code appears typical to us, and that's not a good thing" — it reads only by mentally assembling statement groups into behaviors.

Pass 1 compresses helpers to one-liners (`randomInt = n => Math.floor(Math.random() * n)`), adds `randomElement`, and extracts `generateRandomCardData` and `formatCard`, distilling `generateCard` into three policy chunks: generate random elements, determine correct answers, return the formatted card. No statement now demands a comment — comments would only add development, comprehension, and maintenance cost.

Pass 2 extracts `selectNoun`/`selectAdjective` for one more ounce of isolation. But parameters proliferate, muddling the solution. Pass 3 introduces better data groupings — a `phrase` object (adjective + noun) and a `caseAgreement` object (grammatical case + number) — so each step emphasizes its key elements. Reworking `selectAdjective` to take a `gender` parameter instead of a whole noun deliberately emphasizes that gender, specifically, drives adjective selection. Lesson: conciseness and clarity are reached iteratively; introducing the right small abstractions tames "a haphazard bustle of wayward local variables."

### Repetitive error handling in `postItem`
A controller repeats the same four-line error block (set status 400, build message, log, send) for each failed lookup, obscuring the controller's essence by mixing implementation detail into policy flow. Extracting `sendRequestError(response, message)` shrinks each guard to one readable line. Eliminating duplication by replacing details with abstraction is a "win-win-win-win": conciseness, clarity, easier confirmability, and a springboard to cohesion. Counter-nuance: chase duplicated *concepts*, not two incidentally identical lines.

### War story: five lines of date logic, fifty-plus copies
An operating room scheduling system — date/timestamp work by definition — contained one five-line chunk of old-school Java date handling repeated in over fifty places. When the team tried to replace it with a modern library, costs exploded. The authors report systems two-to-three times their necessary size due to rampant duplication. Lesson: duplication multiplies every future cost; extract-and-move pays for itself.

### War story: fear-driven copy-paste in a famous C++ system
In a high-performance, historically famous large system where shipping a defect could cost millions of dollars per minute, developers needing variants of behaviors inside 100+ line C++ member functions habitually copy-pasted the entire function and modified the copy. Nobody touched the original — no one wanted to be the one who broke working code ("Why did you even touch that code?"). Lesson anchoring "Fear Degrades Design": without fast tests, fear drives developers to do the worst possible thing to a system rather than the best thing they know, and "fear significantly increases code duplication and costs."

### `postCheckoutTotal`: conflated unit vs. testable units
A ~90-line checkout controller does everything inline: validate the checkout, loop items applying member discounts with exemption logic, format receipt line items with manual rounding/padding (the same rounding-formatting code repeated three times), append total and "You saved" lines, and send the response. Writing tests covering all its nuances would take hours, and missed cases would ship defects.

The refactor splits it into layers:
- `postCheckoutTotal` becomes a policy declaration (retrieve checkout, guard with `sendErrorResponse`, delegate to `createReceipt`, send response) coverable by a couple of end-to-end tests.
- `receipt.js` holds formatting (`lineItem`, `formatAmount`, `round2`, `createReceiptMessages`, `createReceipt`) and is directly unit-testable.
- `checkout-model.js` holds pure calculations (`calculateTotal`, `calculateTotalSaved`, `calculateTotalOfDiscountedItems`).

Six unit tests for `calculateTotal` (empty cart, single item, member discount applied, exempt item, no member, mixed cart) took ten minutes to write — and then gave the confidence to fearlessly refactor `calculateTotal` itself into filter/reduce form with `memberDiscountPct`, `shouldApplyDiscount`, and `calculateDiscountedPrice` helpers. That refactor grew `calculateTotal`'s line count but shrank the module overall once siblings got the same treatment. Lessons: small isolated units imply simple tests; tests enable fearless refactoring; judge size at module scope.

### `words.js`: passing three Cs but failing Cohesion
The Czecher word-management module stores definitions in an in-memory JavaScript object, with `addWord` calling `retrieveWord` (an OpenAI-backed lookup) unless the word already exists. Jest tests using `jest-when` mocks drove all of it into existence. The continuous design report card: Clarity pass, Confirmability pass, Conciseness pass — Cohesion **fail**. Definition-management logic is conflated with storage logic (an SRP violation), so replacing the in-memory object with real persistence would mean poking through most of the module's functions.

The refactor extracts a `database.js` module exposing `add`, `get`, `containsKey`, `deleteAll`, `allValues` — nothing exported betrays the underlying data structure — and `words.js` calls those abstractions. The storage can now become a list, key/value store, or relational database without touching the words module. Lessons: code can look clean and tested yet still fail a design criterion; cohesive separation from the start avoids having to "prefactor" before a change fits.

### Decomposing the adverbs feature
A planning example, not code: to "add support for adverbs" to Czecher, the work splits into slices — add a single adverb, bulk-load a CSV of adverbs, add flash cards containing adverbs — and the first slice splits again into technical pieces (LLM prompt format for adverbs, persistence support, card-building rework). Lesson: breaking work into thin behavioral slices is itself a design act requiring awareness of the current design, and it surfaces design discussions before coding starts.
