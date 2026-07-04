# Chapter 04: Meaningful Names — Examples

### `int d` — the name that needs a comment
The chapter opens with `int d; // elapsed time in days`. The name `d` reveals nothing; the comment is doing the name's job. Renaming to `elapsedDays`, `daysSinceCreation`, `daysSinceModification`, or `fileAgeInDays` makes the comment unnecessary. The authors add a counterpoint: `int d = getElapsedTimeInDays();` is perfectly clear in a small scope, because the right-hand side supplies the context. Lesson: clear beats unclear, which is not the same as long beats short.

### The Minesweeper refactoring — building a system of names
A function called `getThem()` loops over `theList`, collecting every `int[] x` where `x[0] == 4` into `list1`. The code is structurally trivial — no complex expressions, three variables — yet unreadable, because it answers none of the implicit questions: what is in `theList`, what does subscript 0 mean, what is 4, what is the returned list for. The context turns out to be the Minesweeper game. Renaming alone fixes it:

```java
public List<int[]> getFlaggedCells() {
    List<int[]> flaggedCells = new ArrayList<int[]>();
    for (int[] cell : gameBoard)
        if (cell[STATUS_VALUE] == FLAGGED)
            flaggedCells.add(cell);
    return flaggedCells;
}
```

Same operators, same constants, same nesting — only the clarity changed. A further step replaces the int array with a `Cell` class exposing `cell.isFlagged()`, hiding the magic numbers entirely. The authors note that a reader meeting this one function for the first time would already know the application has a game board of cells with statuses, one of which is "flagged": a good system of names teaches the whole application.

### The optical illusion — disinformative near-twins
Two long names, `XYZControllerForEfficientHandlingOfStrings` and `XYZControllerForEfficientStorageOfStrings`, differ in one word buried mid-name; the reader is challenged to spot that `XYZController...` vs `XXZController...` differ at all. A companion snippet mixes lowercase L and uppercase O with 1 and 0 (`if ( O == l ) a = O1; else l = 01;`), which some fonts render indistinguishably. Lesson: similar shapes for different things is disinformation; spell similar concepts similarly and different concepts visibly differently.

### `copyChars(a1, a2)` — number-series names
```java
public static void copyChars(char a1[], char a2[]) { ... }
```
The names `a1` and `a2` are uninformative — they satisfy the compiler while giving no clue to intent. Renaming the parameters `source` and `destination` makes the function read naturally. The authors note that while `X1, X2, X3` patterns often beg for an array or structure, here it was just lazy naming and better names are the whole fix: not all problems are deep.

### `getActiveAccount` and friends — distinctions without meaning
A real application contained `getActiveAccount()`, `getActiveAccounts()`, and `getActiveAccountInfo()`. No caller can know which to use: how many active accounts exist, which does the first return, and what distinguishes the third from the second? This anchors the rule that if names must differ, they must mean something different — `Info` and `Data` are noise words, like `ProductInfo` vs `ProductData` or `Customer` vs `CustomerObject`.

### `genymdhms` — the unpronounceable name war story
A company had a variable `genymdhms` (generation date: year, month, day, hour, minute, second). Saying "gen why emm dee aich emm ess" was so awkward it degraded into the spoken nickname "gen-yah-mudda-hims." Everyone was in on the joke, but new developers had to have the variables explained and then discuss them in made-up words. The before/after contrasts `class DtaRcrd102` with `genymdhms`, `modymdhms`, `pszqint` against `class Customer` with `generated`, `modified`, `recordId` — after which a normal sentence becomes possible: "Hey, Mikey, the generation timestamp is set to tomorrow's date!" Lesson: programming is social; names must support conversation.

### `s += (t[j]*4)/5` — searchable names
A terse loop (`for (int j=0; j<34; j++) { s += (t[j]*4)/5; }`) is rewritten with `realDaysPerIdealDay`, `WORK_DAYS_PER_WEEK`, `NUMBER_OF_TASKS`, `realTaskDays`, `realTaskWeeks`, and `sum`. The rewrite is longer, but finding `WORK_DAYS_PER_WEEK` with grep is trivial, while finding the right `5` among every 5 in the codebase is not. Even the mediocre name `sum` is at least searchable. Counterexample given: `e` as a caught-exception name in Python/Go is acceptable — familiar convention, tiny scope, no search needed.

### `n` in a two-line loop, `open`, and `spacewar.ui.tactical-scan` — name length scales with scope
For variables, length is proportional to scope: in `for (int n=0; n<20; n++) System.out.println("" + n + " " + n*n);` the name `n` is appropriately short — `theNumberToBeSquared` would be annoying — but an *instance variable* named `n` is opaque, especially alongside instance variables `m`, `p`, `i`, and `j`. For functions, the rule inverts: the widely used, general file-opening function should be `open`, not `openFileAndThrowExceptionIfNotFound`; private methods called from one place may need many words; tests get the longest names of all. For namespaces, Uncle Bob's space war game uses the descriptive hierarchy `spacewar.ui.tactical-scan`, and it is the *alias* that scales with scope: `ts` in a very short module, `tac-scan` in a longer one, `tactical-scan` in a very long (and rare) one.

### `m_dsc` vs `description` — member prefixes
A `Part` class with `private String m_dsc; // The textual description` (note the comment propping up the encoded name) is contrasted with a version using plain `description` and `setDescription`. Modern editors colorize members, and small classes make declarations visible, so the `m_` crutch only adds noise. The related cautionary line `PhoneNumber phoneString; // name not changed when type changed!` shows how type-encoded names rot into lies.

### `IShapeFactory` — don't brand interfaces
Building an Abstract Factory for shapes: should the interface be `IShapeFactory` and the class `ShapeFactory`? The authors say leave the interface unadorned as `ShapeFactory` — the whole point of an interface is that users don't need to know it's one. If something must be encoded, suffix the implementation (`ShapeFactoryImp`) instead.

### `Complex.FromRealNumber(23.0)` — named factories over constructors
Because constructors must take the class name, overloads can't describe themselves. `Complex fulcrumPoint = Complex.FromRealNumber(23.0);` is generally better than `new Complex(23.0)` because the factory name says what the argument is. The authors suggest making constructors private to enforce factory use.

### Python `sort` — keyword parameters
`sort(iterable, *, key=None, reverse=False)` shows keyword-only parameters in Python: call sites like `sort(pets, reverse=True)` and `sort(pets, key=lambda x: x.birthdate())` name their own variations instead of relying on positional mystery arguments.

### `HolyHandGrenade` — cuteness
A function named `HolyHandGrenade` is cute but opaque; `DeleteItems` might be a better name. Likewise `whack()` for `kill()` and `eatMyShorts()` for `abort()` — colloquialisms and culture-dependent jokes only work for readers who share the joke, and only while they remember it.

### `state` in an `Address` — adding context
Variables `firstName`, `lastName`, `street`, `houseNumber`, `city`, `state`, `postcode` obviously form an address when seen together — but `state` alone in some method could just as easily mean a finite-state-machine state. Wrapping them in an `Address` class removes the ambiguity for both readers and the compiler. A related point: prefer two `GlobalLocations` objects over twelve similarly named floating-point latitude/longitude components (avoiding Primitive Obsession).

### `printGuessStatistics` → `GuessStatisticsMessage` — context enables decomposition
A function `printGuessStatistics(char candidate, int count)` sets three locals — `number`, `verb`, `pluralModifier` — through an if/else chain, then formats "There are no x's"-style messages. The variables' meaning must be inferred by reading the whole function; their context is implicit. The fix creates a `GuessStatisticsMessage` class with the three variables as fields, giving them a definitive home, and that context then allows the algorithm to be split into small intention-named methods: `createPluralDependentMessageParts`, `thereAreNoLetters`, `thereIsOneLetter`, `thereAreManyLetters`. Lesson: adding context via a class improves both the names and the structure.

### `GSD` prefixes — gratuitous context
In an imaginary app called Gas Station Deluxe, prefixing every class with `GSD` defeats autocomplete (type G, get every class in the system) and pollutes names: `GSDAccountAddress` reused for a customer-contact mailing address carries 10 of 17 redundant or irrelevant characters. `Address` is a fine class name; `accountAddress` and `customerAddress` are fine instance names; if MAC, port, and Web addresses need differentiating, consider `PostalAddress`, `MAC`, `URI`.

### The authors' own renaming habit — closing anecdote
The chapter ends with the admission that the authors, despite writing volumes on naming, often give a variable an intentionally bad name temporarily until a better one comes to mind, then rename. They cite Josh Kerievsky: all good writing is based on revision. They are grateful, not annoyed, when others rename things for the better, and they don't memorize names — tools handle that. The value underneath: naming is iterative writing for an audience, not a one-shot decision.
