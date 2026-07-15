# Chapter 12: Unit Testing

*Software Engineering at Google, written by Erik Kuefler, edited by Tom Manshreck.*

## Chapter Thesis

Unit tests (tests of narrow scope, such as a single class or method) are the workhorse of Google's testing strategy because they are fast, deterministic, easy to write, and give clear failure signals. But because engineers run thousands of them daily, the dominant concern is **maintainability**: a maintainable test "just works" after it is written, never needs attention until it fails, and when it fails it points to a real bug with a clear cause. Unmaintainable tests drain productivity instead of improving it. The chapter identifies the two failure modes of unmaintainable tests, **brittleness** (breaking on harmless changes) and **unclarity** (being hard to diagnose when they fail), and lays out concrete practices to prevent both.

## Core Principles and Ideas

### Why unit tests dominate

- Unit tests are usually **small** in Google's size classification, so they are fast and deterministic and can run constantly during development.
- They are easy to write alongside the code they test, without setting up a larger system.
- Their speed and ease drive high test coverage, which lets engineers change code with confidence.
- When they fail, the cause is usually easy to locate because each test is narrow and focused.
- They act as documentation and usage examples for the system under test.
- Google's rule of thumb: aim for roughly **80% unit tests, 20% broader-scoped tests**.

### The two enemies of maintainability

1. **Brittle tests** fail in response to a harmless, unrelated production change that introduces no real bug. (Distinct from a *flaky* test, which fails nondeterministically with no code change at all.) At scale, where a single large refactoring can trigger hundreds of thousands of tests, even a small brittleness rate wastes enormous engineering time. A suite that must be hand-tweaked on every change barely qualifies as "automated."
2. **Unclear tests** are hard to diagnose when they fail: the engineer cannot tell what the test was checking, why it broke, or how to fix it. Unclear tests often outlive their authors; unlike unclear production code (whose purpose you can infer from callers), an unclear test's purpose may be unrecoverable, and such tests frequently just get deleted, silently opening coverage holes after having provided zero value for years.

### The ideal test is unchanging

The ideal test never needs modification after it is written unless the *requirements* of the system under test change. The framework: there are exactly **four kinds of changes** engineers make to production code, and only one should require touching existing tests.

| Kind of change | Should existing tests change? |
|---|---|
| **Pure refactoring** (internals change, interface doesn't) | No. Tests exist to verify the refactoring preserved behavior. Tests that break indicate either the change wasn't a pure refactoring or the tests were written at the wrong level of abstraction. |
| **New features** | No. Write *new* tests for the new behavior; existing behavior (and tests) stay intact. Breakage suggests unintended side effects of the feature or inappropriate tests. |
| **Bug fixes** | No. The bug reveals a *missing* test case; the fix adds that case without touching existing tests. |
| **Behavior changes** | Yes. This is the only case where updating tests is expected. It is also inherently the most expensive kind of change because it breaks the system's explicit contract with its users. |

This property is what makes working at scale possible: extending a system requires writing a few new tests rather than revisiting every test ever written.

### Test via public APIs

The single most important brittleness-prevention practice: invoke the system under test the same way its real users would, through its **public API**, never through implementation details (private methods, internal state, serialization formats). Then, by definition, a change that breaks a test would also break a real user, so every test failure is meaningful. This is sometimes called the **"use the front door first" principle**.

"Public API" here means the API a **unit** exposes to third parties outside the owning team, which does not necessarily match language-level visibility (Java `public`, Python conventions, Bazel visibility rules can all differ). Defining the unit's scope is more art than science, but the chapter gives rules of thumb:

- A **helper class** that exists only to support one or two other classes is not its own unit; test it through those classes.
- A package or class designed to be used by anyone without consulting its owners is definitely a unit; test it directly the way users would.
- A **support library** (owner-only access but general-purpose functionality) should also be tested directly, even though this creates redundant coverage with its users' tests. The redundancy is valuable: it prevents coverage gaps if a user and its tests are later deleted.

Testing via public APIs takes more upfront effort than testing the code you just wrote, but it pays for itself many times over in reduced maintenance.

### Test state, not interactions

Two ways to verify a system's behavior:

- **State testing**: observe the system itself after invoking it (what does it look like now?).
- **Interaction testing**: verify the system performed an expected *sequence of calls* on its collaborators (how did it get there?).

Interaction tests are more brittle for the same reason testing private methods is brittle: they pin down *how* the system arrived at a result when you should usually only care *what* the result is. Interaction tests can both fail when they should pass (an equivalent refactoring changes which API call is made) and pass when they should fail (the record was written then immediately deleted by a bug).

The most common cause of problematic interaction tests is **overreliance on mocking frameworks**, which make it trivially easy to record and verify every call. Google prefers **real objects over mocks** whenever the real objects are fast and deterministic. (Chapter 13, Test Doubles, covers this in depth.)

### Clear tests: completeness and conciseness

Test failures happen for exactly two reasons: the system under test is broken/incomplete (the desired outcome), or the test itself is flawed (a brittle test). A **clear test** is one whose purpose for existing and reason for failing are immediately obvious to the diagnosing engineer.

Two properties drive clarity:

- A test is **complete** when its body contains all the information a reader needs to understand how it arrives at its result.
- A test is **concise** when it contains no distracting or irrelevant information.

These can pull against each other; the resolution is to hide *irrelevant* details in helpers while surfacing *relevant* ones in the test body, even if that means violating DRY.

### Test behaviors, not methods

Do not mirror production structure with one test method per production method. Methods grow, and method-driven tests grow convoluted with them. Instead write **one test per behavior**, where a *behavior* is any guarantee the system makes about how it responds to a series of inputs while in a particular state. Behaviors map many-to-many onto methods, and a product feature is a collection of behaviors.

Behaviors are naturally expressed as **given/when/then** (also called arrange/act/assert): *given* a system state, *when* an action is taken, *then* a result is verified. Behavior-driven tests read like natural language, express cause and effect crisply, and make it obvious what is already covered.

Structural guidance:

- Make the given/when/then structure explicit via whitespace or comments (some frameworks like Cucumber and Spock bake it in).
- The pattern lets a reader work at three granularities: test name → given/when/then comments → actual code.
- Do not intersperse assertions among multiple calls (merging "when" and "then") — that obscures which action produces which result.
- Multi-step validations may alternate when/then blocks, and long blocks can be split with "and," but the vast majority of unit tests should have exactly one "when" and one "then" and cover exactly **one behavior**.

### Name tests after the behavior being tested

The test name is often the first or only token visible in a failure report, so it is the best chance to communicate the problem. A good name states the action taken and the expected outcome (and sometimes the initial state). Verbose names like `multiply_positiveAndNegative_returnsNegative` are fine because test methods are never called by hand-written code but are constantly read by humans. Any consistent strategy works within a test class. A useful trick: start the name with "should" so class name + test name read as a sentence ("BankAccount should not allow withdrawals when balance is empty"). If a test name needs the word "and," it probably tests multiple behaviors and should be split.

### Don't put logic in tests

Clear tests are **trivially correct upon inspection**. Test code can achieve this because each test handles only one fixed set of inputs, whereas production code must generalize. Production code gets tests to verify its complex logic; tests have no such safety net — *if you feel you need a test for your test, something has gone wrong*. Logic means operators, loops, conditionals — anything requiring mental computation to evaluate. Even one string concatenation can hide a bug that a fully written-out literal exposes. Prefer straight-line code and tolerate duplication when it makes the test more descriptive.

### Write clear failure messages

Ideally an engineer diagnoses a failure from the message alone, without opening the test. A good failure message states the **desired outcome**, the **actual outcome**, and **relevant parameters** — clearly distinguishing expected from actual. Assertion libraries that receive the subject of the assertion (e.g., Google's Truth library: `assertThat(colors).contains("orange")`) produce far better messages than boolean-only asserts (`assertTrue(colors.contains("orange"))`, which can only say "expected true but was false"). Where no library helps (e.g., Go), write the message manually: `t.Errorf("Add(2, 3) = %v, want %v", result, 5)`.

### DAMP, not DRY

**DRY** ("Don't Repeat Yourself") says every concept should live in one canonical place; it optimizes for ease of change at the cost of readability (readers must chase references). That trade-off inverts for test code: tests are *supposed* to be stable and to break on system changes, so DRY's benefit shrinks, while the cost of complexity grows because tests have no tests of their own and must be self-evidently correct.

Test code should instead be **DAMP** — promote **"Descriptive And Meaningful Phrases."** Some duplication is fine when it makes the test simpler and clearer. DAMP **complements** DRY rather than replacing it: helpers and shared infrastructure remain useful for factoring out *irrelevant* repetitive detail, but refactor tests to make them more descriptive and meaningful, never solely to reduce repetition.

## Actionable Guidance

- Aim for ~80% unit tests / ~20% broader-scoped tests.
- Fix bad tests before check-in; they otherwise tax every future engineer.
- On every failing test, first classify: real bug in the system, or flawed (brittle) test?
- Write tests so refactorings, new features, and bug fixes never require editing existing tests; only deliberate behavior changes do.
- Test through the unit's public API; never remove visibility modifiers to reach internals.
- Assert on resulting state, not on the sequence of calls made to collaborators; use real objects instead of mocks when they are fast and deterministic.
- One behavior per test; one "when" and one "then" in almost every test.
- Make given/when/then blocks visible with whitespace or comments.
- Start test names with "should" when stuck; split any test whose name needs "and."
- Keep test bodies straight-line: no loops, conditionals, or computed expected values; write literals out in full.
- Prefer assertion libraries that capture the assertion subject (Truth-style) for informative failure output.
- **Shared values**: avoid ambiguous shared constants (`ACCOUNT_1`, `ACCOUNT_2`) defined far from the tests. Instead use **helper methods with reasonable defaults** (named parameters, or the Builder pattern in languages without them) so each test specifies only the values it cares about. Slightly randomizing unspecified defaults helps prevent accidental equality and hardcoded dependence on defaults.
- **Shared setup** (`setUp`/`@Before` methods): good for constructing the object under test and collaborators in default states; bad when tests silently depend on specific values buried in setup. If a test cares about a value, it should set or restate that value in its own body, overriding the setup default.
- **Shared validation helpers**: avoid catch-all `validate()` methods called at the end of every test — they blur intent and make bugs fail many tests at once. Focused helpers that assert a *single conceptual fact* are fine, especially when the concept is simple but the check needs a loop or conditional.
- **Test infrastructure** (code shared across multiple test suites) is effectively production code: treat it as its own product, and give it its own tests. Standardize on well-known third-party testing libraries organization-wide as early as possible (Google mandated Mockito as the only mocking framework for new Java tests; the initial grumbling gave way to universal approval).

## The Chapter's TL;DRs (verbatim)

- Strive for unchanging tests.
- Test via public APIs.
- Test state, not interactions.
- Make your tests complete and concise.
- Test behaviors, not methods.
- Structure tests to emphasize behaviors.
- Name tests after the behavior being tested.
- Don't put logic in tests.
- Write clear failure messages.
- Follow DAMP over DRY when sharing code for tests.
