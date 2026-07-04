# Chapter 04: Meaningful Names

Names are everywhere in software, so do them well. Code is written for an audience — the people who will work in the codebase — and their experience of reading the code matters more, and lasts longer, than your experience of writing it. Choosing good names takes time but saves more than it takes; take care with names and change them when you find better ones.

## Use Intention-Revealing Names
A name should answer the big questions: why the thing exists, what it does, how it is used. If a name requires a comment to communicate its intent (`int d; // elapsed time in days`), the name has failed — prefer `elapsedDays` or `fileAgeInDays`. The lesson is not that long names beat short names, only that clear names beat unclear ones; `int d = getElapsedTimeInDays();` is fine in a small scope because the context defines it.

## Build a System of Names
Code is often hard to read not because it is complex but because it provides no context — readers must already know what the values mean. Naming the implicit concepts (`gameBoard`, `STATUS_VALUE`, `FLAGGED`, `isFlagged()`) leaves the code's simplicity unchanged while transforming its clarity. A good system of names communicates a great deal about the whole application: a reader landing on one function for the first time learns the domain from the names alone.

## Avoid Disinformation
Do not leave false clues. Don't call a group of accounts `accountList` unless it is actually a List — and even then, prefer not to encode the container type at all; `accountGroup`, `bunchOfAccounts`, or just plain `accounts` may be shorter and more honest. Avoid names that vary in small ways (`XYZControllerForEfficientHandlingOfStrings` vs `...StorageOfStrings`): long names with similar shapes are hard to distinguish. Spelling similar concepts similarly is information; inconsistent spellings are disinformation and confound autocomplete. Beware lowercase L and uppercase O, which can look like 1 and 0.

## Make Meaningful Distinctions
If names must be different, they should also mean something different. Don't distinguish names arbitrarily just to satisfy the compiler (misspellings, `klass`). Number-series names (`a1, a2, ... aN`) are not dis-informative but uninformative — `copyChars(a1, a2)` reads much better as `source` and `destination`. When you see `X1, X2, X3`, consider whether a structure or array is wanted — but not all problems are deep; sometimes it's just lazy naming and better names suffice. Noise words (`ProductInfo`, `ProductData`, `NameString`, `CustomerObject`) make names different without making them mean anything different: every class contains data and info. The word `variable` should never appear in a variable name nor `table` in a table name. `getActiveAccount()` / `getActiveAccounts()` / `getActiveAccountInfo()` side by side give callers no way to know which to call.

## Use Pronounceable Names
A huge portion of the human brain is dedicated to words, and words are by definition pronounceable — exploit that. If you can't pronounce a name (`genymdhms`, `DtaRcrd102`), you can't conveniently discuss it, and programming is a social activity. Unpronounceable names force new developers to have variables explained and replace intelligent conversation with made-up jargon.

## Use Searchable Names
Single-letter names and raw numeric constants are hard to grep for: `MAX_CLASSES_PER_STUDENT` is findable, the digit 7 is noise, and the letter `e` appears everywhere; worse, a transposed digit in a long numeric constant creates a bug that evades the programmer's search. For searchability, longer names can trump shorter ones, and any searchable name trumps a raw constant. Exception: short names in limited, well-known scopes (like `e` for a caught exception) generally don't confound searches. Rule of thumb: single-letter names only as locals inside very short scopes; anything seen or used in multiple places deserves a search-friendly name.

## Use Names of Appropriate Length
- **Variables:** name length should be *proportional* to the scope that contains them. `n` is fine in a two-line loop; an instance variable named `n` is opaque. Locals and arguments get a word or two; instance variables longer; globals longer still.
- **Functions:** exactly the opposite — name length should be *inversely proportional* to scope. Widely used global functions are general and called often, so keep them short (`open`, not `openFileAndThrowExceptionIfNotFound`). Private methods are specific and called from few places, so they may need many words. Tests, with effectively zero scope, get the longest names of all.
- **Classes:** same rule as functions — the longer the scope, the shorter the name. Global classes get a word or two; derived, inner, and private classes get longer names.
- **Properties/attributes** (C++/C# elements that look like variables): follow the variable rule.
- **Namespaces:** descriptive and longish, often hierarchical (`spacewar.ui.tactical-scan`); the namespace name doesn't scale with scope, but its *alias* does (`ts` in a very short module, `tac-scan` in a longer one, `tactical-scan` in a very long one — which ought to be rare).

## Avoid Encodings
Encoding type or scope into names (Hungarian notation, `m_` member prefixes) adds a deciphering burden and forces newcomers to learn another "language." It was a crutch for ancient compilers that didn't check types; modern type systems, IDEs, and small classes make it unnecessary. Encodings make names harder to change, harder to read, and risk misleading the reader when the type changes but the name doesn't (`PhoneNumber phoneString;`). Don't prefix interfaces with `I` — the whole point of an interface is that users don't need to know it's one; if you must encode, suffix the implementation instead (`ShapeFactory` / `ShapeFactoryImp`).

## Use Appropriate Parts of Speech
- **Classes:** noun or noun-phrase names (`Customer`, `WikiPage`, `AddressParser`), singular unless the class holds many instances. Avoid noise words like `Manager`, `Processor`, `Data`, `Info` — we already know classes manage and process data.
- **Methods:** verb or verb-phrase names (`postPayment`, `deletePage`, `save`). Accessors, mutators, and predicates follow local convention (`get`/`set`/`is` in Java). Name mutators for the mutation they cause (`add`, `remove`, `sort`). Some languages have a de facto convention of naming a function after the value it returns (a noun); the authors don't prefer it but will follow it on teams that use it.
- **Constructors:** when overloaded, prefer static factory methods whose names describe the arguments (`Complex.FromRealNumber(23.0)` over `new Complex(23.0)`); consider making the constructors private to enforce it.

## Consider Keyword Parameters
In languages with keyword parameters (Python, C#, Ruby, Clojure), you may find it best to limit positional parameters and use explicit keyword-only parameters for most variations — the call site then names its own arguments (`sort(pets, reverse=True)`).

## Don't Be Cute
Clever names are memorable only to people who share the joke, and only while they remember it. `DeleteItems` might be a better name than `HolyHandGrenade`; don't use `whack()` for `kill()` or `eatMyShorts()` for `abort()`. Choose clarity over entertainment value. Say what you mean; mean what you say.

## Pick One Word per Concept
Pick one word for one concept and stick with it: don't use `amount`, `fee`, `price`, and `cost` for the same idea in different modules. Audit your names for consistency and harmonize them within a class, module, or test suite. A consistent lexicon (a Ubiquitous Language, from Domain-Driven Design) is a great boon to everyone who must use your code.

## Use Solution Domain Names
Your readers are programmers. Below the domain level, use CS terms, algorithm names, pattern names, and math terms (`AccountVisitor`, `JobQueue`, `FIFO`). Don't draw every name from the problem domain — coworkers shouldn't have to run to the customer to learn a concept they already know by a technical name. Programs are often best described using programming; use the level of abstraction that fits the algorithm and the audience.

## Use Problem Domain Names
Code that is about problem-domain concepts should use problem-domain names — they set context, and at worst a maintainer can ask a domain expert what one means. Separating solution-domain and problem-domain concepts is part of the job: don't force solution names onto the problem or problem names onto the solution.

## Add Meaningful Context
Few names are meaningful by themselves; most need context from well-named enclosing classes, functions, or namespaces. `state` alone could be part of an address or a finite-state machine; grouped into an `Address` class, even the compiler knows what it belongs to. Avoid the Primitive Obsession code smell (from *Refactoring*) — don't put off creating classes and structures; two `GlobalLocations` beat twelve similarly named floats. Creating a context class (e.g. `GuessStatisticsMessage`) also enables splitting long functions into small, intention-named pieces.

## Don't Add Gratuitous Context
Don't prefix every class in Gas Station Deluxe with `GSD` — you're working against your tools' autocomplete, and the prefix is redundant. `accountAddress` and `customerAddress` are fine instance names but could be poor class names; `Address` is a fine class name. If you need to differentiate MAC, port, and Web addresses, consider `PostalAddress`, `MAC`, `URI`. The resulting names are more precise — precision is the point of all naming.

## Final Words: Rename Freely
Good naming requires descriptive skill and a shared cultural background, and you must relearn the audience with every codebase change — it is not a learn-once, autopilot skill, and many programmers don't learn to do it very well: it requires contact with your user base, just as any good software development requires contact with real users. So iterate: the authors will deliberately use a temporary bad name until a better one comes to mind. Rename things without fear of surprising other developers; as Josh Kerievsky says, all good writing is based on revision. Don't memorize names — use tools for that — and judge code by whether it reads like prose, or at least like clear equations and tables.

## In practice
- Before naming anything, ask: who will read this, and what do they already know?
- Name so the reader learns why it exists, what it does, and how it's used — if you're about to write a comment explaining a name, fix the name instead.
- Replace magic numbers and opaque subscripts with named constants and intention-revealing functions.
- Scale variable-name length up with scope size; scale function and class-name length down with scope size.
- Never encode types or scope into names (no Hungarian notation, no `m_`, no `I`-prefixed interfaces).
- Use nouns for classes, verbs for methods; prefer named static factories over overloaded constructors.
- Grep-test your names: could someone find every use of this thing by searching for it?
- Pronounce-test your names: could two people discuss this code aloud?
- Keep one word per concept across the codebase; audit and harmonize names when they drift.
- Wrap related primitives in a context-giving class instead of letting bare variables float.
- When you find a better name, rename — immediately and without fear.
