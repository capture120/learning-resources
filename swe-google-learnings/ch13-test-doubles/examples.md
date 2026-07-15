# Chapter 13: Test Doubles — Examples and Case Studies

All examples come from Chapter 13 of *Software Engineering at Google*. Each is retold with its setup, what the example shows, and the lesson the book draws. A **test double** is an object or function that stands in for a real implementation in a test.

## 1. The credit card PaymentProcessor (Examples 13-1 to 13-3)

**Setup.** An ecommerce site charges credit cards through a `PaymentProcessor` class that delegates to a `CreditCardService`:

```java
class PaymentProcessor {
  private CreditCardService creditCardService;
  boolean makePayment(CreditCard creditCard, Money amount) {
    if (creditCard.isExpired()) { return false; }
    return creditCardService.chargeCreditCard(creditCard, amount);
  }
}
```

Using the real credit card service in tests is infeasible — every test run would incur real transaction fees.

**What happened.** A trivial test double implements the same interface and just returns `true`:

```java
class TestDoubleCreditCardService implements CreditCardService {
  @Override
  public boolean chargeCreditCard(CreditCard creditCard, Money amount) {
    return true;
  }
}
```

Even this near-useless double enables a real test: passing an expired card and asserting `makePayment` returns `false`, because that code path never reaches the credit card service.

**Lesson.** A test double stands in for an implementation that is unusable in tests, and even a minimal one unlocks testing of the logic around the dependency.

## 2. Dependency injection as a seam (Examples 13-4 and 13-5)

**Setup.** A **seam** is a point where a test can substitute a different dependency than production uses. **Dependency injection** creates seams by passing dependencies in rather than constructing them internally.

**What happened.** `PaymentProcessor` is changed to accept its `CreditCardService` through the constructor:

```java
PaymentProcessor(CreditCardService creditCardService) {
  this.creditCardService = creditCardService;
}
```

Production passes a real service that talks to an external server; the test passes `new TestDoubleCreditCardService()`. The book notes Google uses Guice and Dagger to automate this wiring in Java, and that dynamic languages (Python, JavaScript) need dependency injection less because tests can override individual methods at runtime.

**Lesson.** Testability must be designed in. The later you retrofit seams, the more refactoring it costs.

## 3. Creating a mock with Mockito (Example 13-6)

**Setup.** A **mocking framework** is a library that creates test doubles inline in a test, without writing a new class each time. Mockito is Google's Java mocking framework.

**What happened.** One annotation creates the double and one line gives it behavior:

```java
@Mock CreditCardService mockCreditCardService;
...
when(mockCreditCardService.chargeCreditCard(any(), any())).thenReturn(false);
boolean success = paymentProcessor.makePayment(CREDIT_CARD, AMOUNT);
assertThat(success).isFalse();
```

**Lesson.** Mocking frameworks remove boilerplate — which is exactly why they are easy to overuse. Google's historical experience: mock-heavy tests were easy to write but demanded constant maintenance while rarely finding bugs.

## 4. The three techniques side by side (Examples 13-7 to 13-9)

**Setup.** An `AccessManager` checks user access via an `AuthorizationService`. The same scenario is tested three ways.

**Faking** — a `FakeAuthorizationService` is a real, working, in-memory implementation. The test adds a user to the fake and observes access flip from denied to granted. No behavior needs to be scripted; the fake behaves like the real service.

**Stubbing** — a mock's `lookupUser()` is scripted per call: return `null` (assert no access), then return a user (assert access). The test hand-feeds every behavior.

**Interaction testing** — the test calls `accessManager.userHasAccess(USER_ID)` and then asserts `verify(mockAuthorizationService).lookupUser(USER_ID)`: it checks only that the lookup call happened, not that access logic is correct.

**Lesson.** The three techniques answer different questions. Fakes simulate the dependency; stubs script specific return values; interaction testing observes calls. Knowing the distinction is what lets an engineer pick the right one.

## 5. Case study: the @DoNotMock annotation (Example 13-10)

**Setup.** Google saw so many tests over-relying on mocking frameworks that they built the `@DoNotMock` Java annotation into the ErrorProne static-analysis tool.

**What happened.** An API owner annotates a type:

```java
@DoNotMock("Use SimpleQuery.create() instead of mocking.")
public abstract class Query { ... }
```

Any attempt to mock that type produces a compile-time error pointing at the better alternative (a real implementation or a fake). It is used most for value objects and for APIs with well-engineered fakes.

**Why owners care.** Every mock of an API duplicates that API's behavior inside a test. When an API has been mocked thousands or tens of thousands of times across Google's codebase — often with contract-violating behavior like returning null where the real method never does — the owner cannot change the implementation without first fixing thousands of flawed tests.

**Lesson.** Mocks freeze APIs. Real implementations and fakes keep the API owner free to evolve the implementation.

## 6. The impossible constructor (dependency-construction trade-off)

**Setup.** Using a real implementation means constructing its whole dependency tree.

**What happened.** The book contrasts two lines:

```java
Foo foo = new Foo(new A(new B(new C()), new D()), new E(), ..., new Z());
```

versus

```java
@Mock Foo mockFoo;
```

The first is time-consuming to figure out and breaks whenever any constructor signature changes. The second is one line.

**Lesson.** Construction pain tempts engineers toward mocks, but the right fix is neither: reuse the production construction code (a factory method or automated dependency injection) in tests, made flexible enough to accept doubles where needed.

## 7. The fake file system (Example 13-11)

**Setup.** A **fake** is a lightweight working implementation unsuitable for production. Tests shouldn't do disk I/O.

**What happened.** `FakeFileSystem` implements the same `FileSystem` interface as the real implementation but stores files in an in-memory `HashMap`. Crucially, `readFile` throws `FileNotFoundException` for a missing file *because the real implementation does* — the fake replicates the API contract, including its error behavior.

**Lesson.** A fake's fidelity target is the API contract: same inputs, same outputs, same state changes and errors — not the storage medium.

## 8. The hashing-API fidelity thought experiment

**Setup.** How much fidelity does a fake need?

**What happened.** A fake for a hashing API does not need to produce the same hash values as the real implementation. Tests care only that a given input yields a unique, stable value; if the API's contract makes no promise about specific hash values, the fake still conforms to the contract. The same logic exempts latency and resource consumption — though if a test explicitly measures latency, a fake cannot be used at all.

**Lesson.** "Perfect fidelity from the perspective of the test": match what the contract guarantees, not incidental properties of the real implementation.

## 9. The transaction-counter stub (Example 13-12)

**Setup.** A `TransactionCounter` counts transactions fetched from a credit card server.

**What happened.**

```java
when(mockCreditCardServer.getTransactions()).thenReturn(
    newList(TRANSACTION_1, TRANSACTION_2, TRANSACTION_3));
assertThat(transactionCounter.getTransactionCount()).isEqualTo(3);
```

**Lesson.** This is *appropriate* stubbing: the stub exists solely to drive the system under test into a needed state (a non-empty transaction list), and it maps directly onto the assertion.

## 10. The stubbed calculator (contract duplication)

**Setup.** What a stub actually encodes.

**What happened.**

```java
when(stubCalculator.add(1, 2)).thenReturn(3);
```

This line hardcodes a piece of the calculator's contract ("1 + 2 returns 3") into the test with no way to guarantee that duplication is correct. The book also notes stubs hold no state: with a real database or fake, `database.save(item)` followed by `database.get(item.id())` works; with a stub, it cannot.

**Lesson.** Stubbing is a poor choice when the system under test depends on the real contract, because the test author must duplicate that contract by hand.

## 11. Overused stubbing vs. the refactored test (Examples 13-13 and 13-14)

**Setup.** A test wants to verify a credit card gets charged.

**What happened (bad version).** The test stubs five interactions — `isServerAvailable()`, `beginTransaction()`, `initTransaction()`, `pay()`, `endTransaction()` — and then, because the doubles cannot actually carry out a payment, its only possible assertion is `verify(mockCreditCardServer).pay(transaction, creditCard, 500)`. The test's intent drowns in setup that mirrors the production implementation.

**What happened (good version).** The same test with real (or fake) dependencies:

```java
paymentProcessor.processPayment(creditCard, Money.dollars(500));
assertThat(creditCardServer.getMostRecentCharge(creditCard)).isEqualTo(500);
```

No setup is needed because the credit card server "knows how to behave," and the assertion checks actual state. Since a live external server is off the table, a fake credit card server is the fit; failing that, a hermetic server instance (a real server whose lifecycle the test controls) works at the cost of speed.

**Lesson.** The book's signature before/after. Heavy stubbing produces long, implementation-mirroring tests that can only verify calls happened. State testing against a fake produces short tests that verify the outcome.

## 12. Sorting numbers: state testing vs. interaction testing (Examples 13-15 and 13-16)

**Setup.** A `NumberSorter` takes two sorting algorithms (quicksort and bubble sort) and sorts lists.

**What happened (state testing).** Call `sortNumbers(newList(3, 1, 2))` with real algorithm implementations and assert the result equals `newList(1, 2, 3)`. Which algorithm ran is irrelevant.

**What happened (interaction testing).** Pass in mock algorithms and assert `verify(mockQuicksort).sort(newList(3, 1, 2))`. This test *cannot* tell whether the numbers were sorted — the mocks don't know how to sort — only that the system under test attempted to use quicksort.

**Lesson.** Interaction testing validates assumptions about behavior; state testing validates the behavior itself. Google found emphasizing state testing more scalable and less brittle. Tests that overuse interaction testing earn the Google nickname **change-detector tests**: they fail on any refactor even when behavior is unchanged.

## 13. Verifying a cache with call counts

**Setup.** The legitimate second use case for interaction testing: when the number or order of calls *is* the behavior.

**What happened.** To verify a caching feature reduces database reads:

```java
verify(databaseReader, atMostOnce()).selectRecords();
```

State testing can't easily express "the database was not hit more than once," so interaction testing fits. The book still advises supplementing such unit tests with larger-scope tests (e.g., an integration test doing state testing against a real database).

**Lesson.** Interaction testing is warranted when state testing is impossible or when call count/order itself matters — and it is a supplement to state testing, never a replacement.

## 14. State-changing vs. non-state-changing verification (Example 13-17)

**Setup.** A `UserAuthorizer` grants permissions using a permission database. Dependency calls split into **state-changing** functions (side effects: `sendEmail()`, `saveRecord()`, `logAccess()`) and **non-state-changing** functions (pure reads: `getUser()`, `findResults()`, `readFile()`).

**What happened.** After calling `grantPermission(USER_ACCESS)`, the test verifies two things:

- `verify(mockPermissionDatabase).addPermission(FAKE_USER, USER_ACCESS)` — reasonable, because `addPermission` changes state and is the point of the method.
- `verify(mockPermissionDatabase).getPermission(FAKE_USER)` — unnecessary, because `getPermission` is a read. The book flags a telltale clue: `getPermission` was already stubbed earlier in the same test, so verifying the call adds nothing.

**Lesson.** Verify only state-changing interactions. Verifying reads is redundant (their return values flow into assertable output), brittle, and clutters the test.

## 15. The overspecified greeting test (Examples 13-18 and 13-19)

**Setup.** A `UserGreeter` displays a greeting prompt. The test's actual intent: verify the user's name appears in the greeting.

**What happened (overspecified).**

```java
verify(userPrompt).setText("Fake User", "Good morning!", "Version 2.1");
verify(userPrompt).setIcon(IMAGE_SUNSHINE);
```

The test fails if the greeting text changes, the version string changes, or the icon changes — none of which relate to the user's name.

**What happened (well-specified).** Split into one test per behavior, each verifying only what matters and wildcarding the rest:

```java
// Name test:
verify(userPrompter).setText(eq("Fake User"), any(), any());
// Morning-settings test:
verify(userPrompt).setText(any(), eq("Good morning!"), any());
verify(userPrompt).setIcon(IMAGE_SUNSHINE);
```

**Lesson.** One behavior per test; verify the minimum arguments needed. Well-specified interaction tests survive changes to unrelated behavior.
