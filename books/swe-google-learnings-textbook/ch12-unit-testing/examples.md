# Chapter 12: Unit Testing — Examples and Case Studies

Every substantive example the chapter uses, retold with its setup, what happens, and the lesson drawn. Terms: a *unit test* is a test of narrow scope (a single class or method); a *brittle test* is one that fails on a harmless production change that introduces no real bug; the *system under test* is the code a test exercises.

## Mary's check-in nightmare (motivating scenario)

**Setup.** Mary adds a simple feature — a couple dozen lines of code — and goes to check it in.

**What happened.** The automated testing system returns a screen full of failures. None of the failures reflect a real bug; her change merely broke assumptions the tests had made about the code's *internal structure*. She spends the rest of the day fixing tests one by one, often unable to tell what a test was even trying to verify, and the hacks she adds make those tests harder to understand for the next person. A quick job becomes days of busywork.

**Lesson.** This is testing producing the *opposite* of its intended effect: draining productivity without improving quality. The failures fall into the chapter's two categories — the tests were **brittle** (broke on a harmless unrelated change) and **unclear** (hard to diagnose and understand). Nothing Mary did was wrong; the fault lies with whoever checked in bad tests. Bad tests must be fixed before check-in.

## The transaction API: testing implementation vs. public API (Examples 12-1 to 12-3)

**Setup.** A transaction processor exposes a public method `processTransaction(Transaction)` that validates a transaction and saves it. Validation (`isValid`) and persistence (`saveToDatabase`, which serializes the transaction as a comma-joined string) are *private* methods. Public helpers `setAccountBalance` / `getAccountBalance` read and write balances via the database.

```java
public void processTransaction(Transaction transaction) {
  if (isValid(transaction)) {
    saveToDatabase(transaction);
  }
}
private boolean isValid(Transaction t) {
  return t.getAmount() < t.getSender().getBalance();
}
private void saveToDatabase(Transaction t) {
  String s = t.getSender() + "," + t.getRecipient() + "," + t.getAmount();
  database.put(t.getId(), s);
}
```

**The naive approach.** Remove the `private` modifiers and test the internals directly: assert `isValid(...)` returns false for an empty account, and assert that `saveToDatabase` produced exactly the string `"me,you,100"` in the database.

**Why it fails.** These tests interact with the processor in a way no real user ever would: they peer into internal state and call methods that are not part of the API. Almost any refactoring — renaming methods, extracting a helper class, changing the serialization format — breaks the tests even though real users would notice nothing.

**The better approach.** Test only through the public API: set two account balances, call `processTransaction`, then assert the resulting balances. One test verifies a valid transfer moves the money (`150/20` becomes `50/120` after a `$100` transfer); a second verifies an invalid transfer (amount exceeding the sender's balance) leaves balances unchanged.

**Lesson.** Public-API tests form explicit contracts: if such a test breaks, a real user would break too. You can then refactor internals freely. This is the *"use the front door first"* principle and the chapter's single most important brittleness defense.

## Brittle interaction test vs. state test (Examples 12-4 and 12-5)

**Setup.** A test needs to verify that creating a user persists that user. The interaction version uses a mock database (a *test double* — a stand-in object that records calls made to it):

```java
@Test
public void shouldWriteToDatabase() {
  accounts.createUser("foobar");
  verify(database).put("foobar");
}
```

**What goes wrong.** Two failure modes in opposite directions:

- If a bug deletes the record right after writing it, the test *passes* when it should fail (the `put` call did happen).
- If a refactoring writes an equivalent record through a slightly different API, the test *fails* when it should pass.

**The better approach.** Assert on resulting state through the public API:

```java
@Test
public void shouldCreateUsers() {
  accounts.createUser("foobar");
  assertThat(accounts.getUser("foobar")).isNotNull();
}
```

**Lesson.** Interaction tests check *how* a system arrived at a result; state tests check *what* the result is, which is what you actually care about. Overreliance on mocking frameworks is the most common source of brittle interaction tests; prefer real objects when they are fast and deterministic.

## The cluttered calculator test (Examples 12-6 and 12-7)

**Setup.** A test of a calculator's addition:

```java
@Test
public void shouldPerformAddition() {
  Calculator calculator = new Calculator(new RoundingStrategy(),
      "unused", ENABLE_COSINE_FEATURE, 0.01, calculusEngine, false);
  int result = calculator.calculate(newTestCalculation());
  assertThat(result).isEqualTo(5); // Where did this number come from?
}
```

**What's wrong.** The test is neither *complete* nor *concise*. The constructor call floods the reader with six irrelevant arguments (not concise), while the actually important input — what calculation produces 5 — is hidden inside the `newTestCalculation()` helper (not complete).

**The fix.** Invert what's hidden and what's shown:

```java
@Test
public void shouldPerformAddition() {
  Calculator calculator = newCalculator();
  int result = calculator.calculate(newCalculation(2, Operation.PLUS, 3));
  assertThat(result).isEqualTo(5);
}
```

**Lesson.** Hide irrelevant details in helpers; surface relevant ones in the test body. A test body should contain everything needed to understand it and nothing that distracts. Achieving this may mean violating DRY (the "Don't Repeat Yourself" principle).

## Method-driven vs. behavior-driven tests (Examples 12-8 to 12-10)

**Setup.** A method displays transaction results and conditionally warns about low balance:

```java
public void displayTransactionResults(User user, Transaction transaction) {
  ui.showMessage("You bought a " + transaction.getItemName());
  if (user.getBalance() < LOW_BALANCE_THRESHOLD) {
    ui.showMessage("Warning: your balance is low!");
  }
}
```

**The method-driven test.** A single `testDisplayTransactionResults` asserts both messages in one body. History likely: the test originally covered only the item-name message, then an engineer *modified* it when the warning was added — violating the unchanging-tests ideal and setting a precedent where the test grows ever more convoluted as the method grows.

**The behavior-driven rewrite.** Two tests, one per behavior: `displayTransactionResults_showsItemName` and `displayTransactionResults_showsLowBalanceWarning`, each setting up only what its behavior needs.

**Lesson.** A *behavior* is a guarantee about how the system responds to inputs in a given state; methods map many-to-many onto behaviors. Behavior-per-test costs a little boilerplate but reads like natural language, isolates cause and effect, and shows at a glance what is covered — so new cases become new tests rather than additions to old ones.

## The well-structured given/when/then test (Example 12-11)

**Setup.** A bank transfer test structured with explicit comments:

```java
@Test
public void transferFundsShouldMoveMoneyBetweenAccounts() {
  // Given two accounts with initial balances of $150 and $20
  Account account1 = newAccountWithBalance(usd(150));
  Account account2 = newAccountWithBalance(usd(20));

  // When transferring $100 from the first to the second account
  bank.transferFunds(account1, account2, usd(100));

  // Then the new account balances should reflect the transfer
  assertThat(account1.getBalance()).isEqualTo(usd(50));
  assertThat(account2.getBalance()).isEqualTo(usd(120));
}
```

**Lesson.** Explicit given/when/then structure (also called arrange/act/assert) lets a reader understand the test at three levels of zoom: the name alone, the comments, or the full code. Trivial tests can rely on whitespace instead of comments. The most common violation is interleaving assertions among multiple system calls, which blurs action and expectation.

## The connection-pool timeout test: alternating when/then (Example 12-12)

**Setup.** A test validates each step of a multistep process: two users connect to a pool with a 10-minute timeout; the test asserts two connections exist; a fake clock advances 20 minutes; the test then asserts the pool is empty *and* each user reports disconnected.

**Lesson.** When a multistep process genuinely needs per-step validation, alternating when/then blocks are acceptable, and long blocks can be subdivided with "and." But this is the exception: the vast majority of unit tests need exactly one "when" and one "then," and a test must still cover only a single behavior.

## Test naming patterns (Examples 12-13 and 12-14)

**Setup.** Jasmine (a JavaScript test framework) allows nested string-named tests: `describe("multiplication") → describe("with a positive number") → it("is negative with a negative number")`. Languages without nesting encode the same information in method names:

```
multiplyingTwoPositiveNumbersShouldReturnAPositiveNumber
multiply_positiveAndNegative_returnsNegative
divide_byZero_throwsException
```

**Lesson.** Test names are read by humans in failure reports and never called by hand-written code, so verbosity that would be unacceptable in production names is warranted here. Any consistent scheme works. Trick: start with "should" so class + test name reads as a sentence. A name needing "and" signals a test covering multiple behaviors that should be split.

## The URL concatenation bug: logic concealing a bug (Examples 12-15 and 12-16)

**Setup.** A navigation test builds its expected value with string concatenation:

```java
String baseUrl = "http://photos.google.com/";
Navigator nav = new Navigator(baseUrl);
nav.goToAlbumPage();
assertThat(nav.getCurrentUrl()).isEqualTo(baseUrl + "/albums");
```

**What happened.** The test looks correct at a glance. But write the expected value out as a full literal and the bug jumps out:

```java
assertThat(nav.getCurrentUrl())
    .isEqualTo("http://photos.google.com//albums"); // Oops!
```

The base URL ends in `/` and the concatenation adds another, so the test expects a double slash. If production made the same mistake, the test would never catch it.

**Lesson.** Even one string concatenation — the mildest possible logic — can hide a bug; loops and conditionals are far worse. In tests, prefer straight-line code with fully written-out literals, and accept the duplication (here, repeating the base URL) as the price of a test that is trivially correct on inspection.

## Failure messages: bad, good, and library-assisted (Examples 12-17 and 12-18)

**The bad message.** `Test failed: account is closed` — ambiguous. Did the test fail *because* the account was closed, or because it was expected to be closed and wasn't?

**The good message.** Distinguishes expected from actual and shows the object:

```
Expected an account in state CLOSED, but got account:
    <{name: "my-account", state: "OPEN"}>
```

**Library comparison.** JUnit's `assertTrue(colors.contains("orange"))` receives only a boolean, so it can only report "expected <true> but was <false>." Google's Truth assertion library receives the subject itself — `assertThat(colors).contains("orange")` — and reports `<[red, green, blue]> should have contained <orange>`.

**Go convention.** Without such a library, write the message by hand:

```go
result := Add(2, 3)
if result != 5 {
  t.Errorf("Add(2, 3) = %v, want %v", result, 5)
}
```

**Lesson.** A good failure message alone should let an engineer diagnose the problem without opening the test: desired outcome, actual outcome, relevant parameters.

## The forum tests: too DRY vs. DAMP (Examples 12-19 and 12-20)

**Setup.** Forum registration tests are aggressively factored: `createUsers(boolean... banned)`, `createForumAndRegisterUsers(users)`, and a shared `validateForumAndUsers(forum, users)` do all the work, leaving three-line test bodies.

**What's wrong.** The bodies are concise but not complete — everything important lives in helpers elsewhere in the file. The helpers contain loops and conditionals that resist at-a-glance verification, and they conceal an actual bug: the validation helper asserts

```java
assertThat(forum.hasRegisteredUser(user))
    .isEqualTo(user.getState() == State.BANNED);
```

which is backwards — it asserts banned users ARE registered and normal users are NOT.

**The DAMP rewrite.** Each test constructs its own users inline, registers them directly, and asserts explicitly: `shouldAllowMultipleUsers` registers two normal users and asserts both are registered; `shouldNotRegisterBannedUsers` registers one banned user (catching the expected `BannedUserException`) and asserts the user is not registered.

**Lesson.** DAMP — "Descriptive And Meaningful Phrases" — beats DRY in test code. The rewrite has more duplication and longer bodies, but each test is understandable without leaving its body and cannot quietly hide an inverted assertion. DAMP complements DRY; refactor tests for descriptiveness, not merely to remove repetition.

## Shared constants with ambiguous names (Example 12-21)

**Setup.** A test file defines file-level constants — `ACCOUNT_1` (open, balance 50), `ACCOUNT_2` (closed, balance 0), `ITEM` (a $1.00 cheeseburger) — then, hundreds of lines later, tests reference them: `canBuyItem_returnsFalseForClosedAccounts` uses `ACCOUNT_1` and `canBuyItem_returnsFalseWhenBalanceInsufficient` uses `ACCOUNT_2`.

**What's wrong.** The reader must scroll to the definitions to check whether the constant fits the scenario — and in fact the constants are *swapped* relative to the test names (the "closed account" test uses the open account). Descriptive names like `CLOSED_ACCOUNT` help only somewhat, and easy reuse tempts engineers to grab a constant that doesn't quite match their test's needs.

**Lesson.** Shared constants trade completeness for conciseness and rot as the suite grows.

## Helper methods with defaults instead of shared constants (Example 12-22)

**Setup.** Rather than shared constants, define a construction helper that supplies reasonable defaults for every field and lets each test override only what it cares about. Python (named parameters):

```python
def newContact(firstName="Grace", lastName="Hopper", phoneNumber="555-123-4567"):
  return Contact(firstName, lastName, phoneNumber)

def test_fullNameShouldCombineFirstAndLastNames(self):
  contact = newContact(firstName="Ada", lastName="Lovelace")
  self.assertEqual(contact.fullName(), "Ada Lovelace")
```

Java emulates named parameters with the Builder pattern (often via tools like AutoValue): `newContact()` returns a builder pre-populated with defaults; the test overrides `setFirstName("Ada").setLastName("Lovelace")` and calls `build()`.

**Lesson.** Each test states exactly the values it cares about and nothing else, with no cross-test coupling. A footnote adds: slightly *randomizing* the unspecified defaults is often useful — it prevents two instances from accidentally comparing equal and stops engineers from hardcoding dependence on default values.

## Hidden dependence on setup values (Examples 12-23 and 12-24)

**Setup.** A `setUp` method (a framework hook that runs before each test) creates a `NameService`, seeds it with `"user1" → "Donald Knuth"`, and builds a `UserStore` on top. Hundreds of lines later a test asserts:

```java
@Test
public void shouldReturnNameFromService() {
  UserDetails user = userStore.get("user1");
  assertThat(user.getName()).isEqualTo("Donald Knuth");
}
```

**What's wrong.** The test is incomplete — the reader must hunt for where "Donald Knuth" came from. The test silently depends on a value buried in setup.

**The fix.** The test overrides the setup value in its own body:

```java
nameService.set("user1", "Margaret Hamilton");
UserDetails user = userStore.get("user1");
assertThat(user.getName()).isEqualTo("Margaret Hamilton");
```

**Lesson.** Setup methods are best for constructing the object under test and its collaborators in default states. Any value a test actually *cares about* should be stated (or overridden) directly in the test body, even at the cost of slight repetition.

## The focused validation helper (Example 12-25)

**Setup.** The chapter warns against general-purpose `validate()` helpers called at the end of every test: they make tests less behavior-driven, obscure each test's intent, and cause one bug to fail many tests at once. But it contrasts them with a *focused* helper asserting a single conceptual fact:

```java
private void assertUserHasAccessToAccount(User user, Account account) {
  for (long userId : account.getUsersWithAccess()) {
    if (user.getId() == userId) {
      return;
    }
  }
  fail(user.getName() + " cannot access " + account.getName());
}
```

**Lesson.** A validation helper earns its keep when the fact it checks is conceptually simple but implementing the check requires a loop or conditional that would clutter the test body. One conceptual assertion per helper; never a grab-bag of fixed checks.

## Google mandates Mockito (test infrastructure case study)

**Setup.** *Test infrastructure* is test code shared across multiple test suites — effectively a product of its own, with many dependents, needing its own tests. Most of it comes from third-party libraries, and the chapter argues organizations should standardize on those libraries early and universally.

**What happened.** Years ago Google mandated Mockito as the *only* mocking framework allowed in new Java tests and banned new tests from using any other. Engineers comfortable with other frameworks grumbled.

**Lesson.** Today the mandate is universally seen as a good move: one standard framework made Google's tests easier to understand and work with across the whole codebase. Consistency in test infrastructure beats individual preference.
