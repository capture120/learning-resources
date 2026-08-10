# Chapter 05: Comments — Examples

### The orphaned regex comment (lying by drift)
From FitNesse: a comment `// Example: "Tue, 02 Apr 2003 22:18:49 GMT"` was written to explain the `HTTP_DATE_REGEXP` constant. Other instance variables, probably added later, were interposed between the constant and its comment, leaving the example stranded next to an unrelated `saveLocale` field. Demonstrates how code moves while comments don't: comments become orphaned blurbs of ever-decreasing accuracy. The fix isn't more discipline maintaining comments — it's writing code clear enough not to need them.

### Intent in code beats intent in comments
The chapter's central before/after:

```java
// Check to see if the employee is eligible for full benefits
if ((employee.flags & HOURLY_FLAG) && (employee.age > 65))
```

versus

```java
if (employee.isEligibleForFullBenefits())
```

It takes only seconds to create a function that says what the comment was going to say. Anchors "Explain Your Intent in Code."

### FitNesse license header (good: legal comment)
Every FitNesse source file starts with a two-line copyright/GPL notice, which the IDE auto-collapses so it doesn't clutter. Lesson: legal comments are necessary and reasonable, but where possible should reference a standard license or other external document, not embed full terms.

### `responderInstance()` (good: informative comment, pattern trumps renaming)
`// Returns an instance of the Responder being tested.` above an abstract method. Normally the fix would be renaming to `responderBeingTested` — but the author was following the Singleton pattern, whose canonical accessor name ends in `Instance`. When a design pattern's canonical form constrains naming, a comment is the right fallback.

### The timestamp regex (good comment that still lies)
`// format matched kk:mm:ss EEE, MMM dd, yyyy` above a `Pattern.compile` call. Worth keeping, because regular expressions are always a nightmare to understand. But the comment is a lie — or at least significantly misinformative: the regex would also match `":: , , "`, which is definitely no timestamp. Martin's response: fix the regex and let the comment remain. Even good comments must be checked against the code.

### `return 1; // we are greater because we are the right type` (good: intent)
In a `compareTo`, the author chose to sort objects of the containing class above all other types and documented that interesting decision inline.

### The 25,000-thread race-condition test (good: intent — with a twist)
A test spawns 25,000 threads with the comment "This is our best attempt to get a race condition by creating large number of threads." Martin calls it an even better example: you might not agree with the programmer's solution, but at least you know what he was trying to do. He would keep the comment in review, but would be tempted to eliminate it by extracting the loop into a function named `attemptRaceCondition`. A "Future Bob" aside adds that the technique itself is terrible: mass-started threads line up single file instead of racing; real race forcing needs semaphores or random delays. Two lessons: intent comments earn their keep, and a well-named extracted function can replace even a good comment.

### `assertTrue(a.compareTo(b) != 0); // a != b` (clarification, and its risk)
Martin's own FitNesse test had a long wall of `assertTrue` calls comparing `WikiPagePath` objects, so he added comments like `// a < b` to spare readers' eyes. But one of those clarifying comments is wrong (`assertTrue(b.compareTo(a) == 1); // b < a` — the code asserts b is *greater*), and it's hard to spot. The very difficulty that makes clarification necessary also makes it risky.

### `_testWithReallyBigFile` (good: warning of consequences)
`// Don't run unless you have some time to kill.` above a test that writes ten million lines. Flippant, but it makes the point. Today you'd use `@Ignore("Takes too long to run")` instead — prefer platform mechanisms when they exist.

### `SimpleDateFormat` is not thread safe (good: warning)
A factory method carries the comment "SimpleDateFormat is not thread safe, so we need to create each instance independently." There may be better solutions, but the comment is perfectly reasonable: it stops an eager programmer from "optimizing" with a static initializer.

### `// the trim is real important` (good: amplification)
A `trim()` call on parsed list-item content looks frivolous, but the comment explains it removes the starting spaces that could cause the item to be recognized as another list. Amplifies something that would otherwise be ignored.

### The mumbling catch block (bad: mumbling)
From FitNesse:

```java
catch(IOException e)
{
    // No properties files means all defaults are loaded
}
```

Who loads the defaults? Before this call? Inside it? Or is this a note-to-self to write that code later? The reader must search other modules to find out — and any comment that forces you to look elsewhere for its meaning has failed. Better: make the code say it, e.g. `LoadedProperties.loadDefaults();` in the catch.

### `waitForClose` header (bad: redundant AND misleading)
A header comment reads "Utility method that returns when this.closed is true. Throws an exception if the timeout is reached." It tells you nothing the code doesn't, takes longer to read than the code, and is less precise — the method does not return *when* closed becomes true; it returns *if* closed is already true; otherwise it waits a blind timeout and then throws if closed is still not true. A caller trusting the comment would expect prompt return and end up in a slow-code debugging session. Martin's image: a used-car salesman assuring you that you don't need to look under the hood.

### Tomcat's `ContainerBase` Javadocs (bad: redundancy and imprecision)
A wall of fields each with a Javadoc like "The processor delay for this component." above `backgroundProcessorDelay`. Every comment restates the variable name, and the prose is sloppily imprecise: the author seems to use "component" and "container" interchangeably, capitalization wanders. Code is precise; imprecise comments confuse, mislead, and make the reader wonder whether the imprecision carries into the code.

### `addCD` mandated Javadoc (bad: mandated comments)
A rule of "every function gets a Javadoc" produces `@param title The title of the CD` and friends — pure restatement. Run the Javadoc tool with and without these comments and the generated docs are nearly identical. Mandated comments add only clutter and the potential for misdirection.

### The dated change journal (bad: journal comments)
A module header listing dated entries from 2001-2005 ("11-Oct-2001: Re-organised the class…"). Once justified, before source control; now pure clutter. Let the source code control system keep the journal.

### `/** Default constructor. */` and `getDayOfMonth` (pure noise)
Three escalating noise comments: `/** Default constructor. */` above an empty `AnnualDateRule()` constructor ("No, really?"); `/** The day of the month. */` above `private int dayOfMonth;`; and the "paragon of redundancy" — a `getDayOfMonth()` Javadoc whose description *and* `@return` tag both restate the method name. We learn to skip such noise as we read, and then, as the code changes, fail to notice when the comments begin to lie.

### "Give me a break!" (bad: noise; fix the structure instead)
A `startSending` method whose nested catch contains the vent `//Give me a break!`. The first comment in the method (`// normal. someone stopped the request.`) seems appropriate — it explains why a catch is ignored. The vent is pure noise. The fix: extract the frustrating nested try/catch into `addExceptionAndCloseResponse(e)`. Replace the temptation to create noise with the determination to clean your code.

### `/** The version. */ private String info;` (scary noise)
From a well-known open source library: four fields, each with a `/** The name. */`-style Javadoc — and one is a copy-paste error labeling `info` as "The version." If the author wasn't reading the comments when writing them, why should readers profit from them?

### `//TODO-MdM these are not needed` (TODO means Don't Do)
A method stubbed to `return null` under a TODO saying it should go away "when we do the checkout model." In the first edition Martin endorsed checked-in TODOs; years of reading code changed his mind: TODO means Don't Do. His rule now: use TODOs while working, but never check them in — do the thing, eliminate the need, or move it to the backlog.

### The `<mod>` dependency check (use explanatory variables)
```java
// does the module from the global list <mod> depend on the
// subsystem we are part of?
if (smodule.getDependSubsystems().contains(subSysMod.getSubSystem()))
```
Martin extracted explanatory variables:
```java
ArrayList moduleDependants = smodule.getDependSubsystems();
String ourSubSystem = subSysMod.getSubSystem();
if (moduleDependants.contains(ourSubSystem))
```
The refactored `if` reads like prose and beats the comment — which he still doesn't understand.

### `// Actions //////////` (position markers)
A banner found in real code. Banners work only because they're startling; overused, they fade into background noise like the boy who cried "Wolf!" Use very sparingly, and drop the noisy trail of slashes.

### `/* Added by Rick */` (attributions are graffiti)
Bylines stay around for years getting less accurate while source control already records who changed what, when. Same verdict for PR numbers and JIRA tags: put them in commit messages, not source.

### Apache Commons commented-out PNG code (commented-out code)
Lines like `//hdrPos = bytePos;` sitting in live PNG-writing code. Nobody knows if they're important, reminders, or years-old cruft — so nobody dares delete them, and they gather "like dregs at the bottom of a bad bottle of wine." Source control remembers code; never check in commented-out code (commenting out *while debugging* is fine).

### The HTML-laden Javadoc (HTML comments)
A FitNesse Ant-task Javadoc stuffed with `<pre>`, `<p/>`, and `&lt;`/`&quot;` entities, unreadable in the source — the one place comments should be easiest to read. Formatting for rendered docs is the tool's responsibility, not the programmer's.

### "Defaults to 8082" (nonlocal information)
A Javadoc on `setFitnessePort` states the default port — but the setter has no control over that default, which lives elsewhere in the system. Nothing guarantees this comment changes when the real default does. Comments must describe nearby code only.

### The RFC 2045 excerpt (too much information)
A base64 test module containing a long quoted passage from RFC 2045 about bit-group encoding. Beyond perhaps the RFC number, readers need none of it. Don't put historical discussions or arcane detail in comments.

### "filter bytes" and the magic 200 (unobvious connection)
Apache Commons: a comment says the array is "big enough to hold all the pixels (plus filter bytes), and an extra 200 bytes for header info" above `new byte[((this.width + 1) * this.height * 3) + 200]`. What's a filter byte? Does it explain the `+1` or the `*3`? Why 200? It is a pity when a comment needs its own explanation.

### `generateNPrimes(int n)` (function headers)
Martin prefers the self-describing signature `public static int[] generateNPrimes(int n)` over a Javadoc-headed `generate(int n)`. A well-chosen name and signature for a small function that does one thing is usually better than a comment header.

### GeneratePrimes → PrimeGenerator (the capstone refactoring)
A Sieve of Eratosthenes module Martin wrote as a deliberate example of bad commenting for the first XP Immersion; Kent Beck refactored it live in front of students. The "before" was once considered "well documented": a header Javadoc with a biography of Eratosthenes, `@author`/`@version` tags, and inline comments on nearly every line (`// declarations`, `// bump count.`, `// return the primes`) compensating for names like `f`, `s`, `i`, `j`.

The "after" (`PrimeGenerator`) replaces every narrating comment with named functions: `uncrossIntegersUpTo`, `crossOutMultiples`, `notCrossed`, `putUncrossedIntegersIntoResult`. Exactly two comments survive, both explanatory:
1. A class header summarizing the algorithm — arguably redundant with the code, but Martin keeps it because it eases the reader into the algorithm.
2. A comment in `determineIterationLimit` explaining *why* the square root of the array size is a sufficient loop limit — he could find no variable name or code structure that made that mathematical rationale clear.

The capstone lesson: restraint plus expressive structure eliminates almost all comments, and the few that remain document rationale the code genuinely cannot express.
