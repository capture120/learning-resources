# Pure Core and Effect Boundaries

A function becomes hard to reuse when it calculates a result and performs an external action at the same time.

The coffee example develops the repair in three stages. The classes stay in place. The effect moves.

## 1. Begin with the effectful method

The first version puts payment processing on `CreditCard`.

```ts
class CreditCard {
  charge(price: number): void {
    console.log(`charging ${price}`)
  }
}

class Coffee {
  readonly price = 2
}

class Cafe {
  buyCoffee(card: CreditCard): Coffee {
    const cup = new Coffee()
    card.charge(cup.price)
    return cup
  }
}
```

`Cafe.buyCoffee` returns a `Coffee`. It also charges the card.

The return type does not mention the charge. Payment is hidden behavior.

That makes `buyCoffee` harder to test. It also makes the method harder to reuse. Calling it twelve times performs twelve charges.

## 2. Extracting a dependency is not the functional step

The next version moves payment processing behind a `Payments` interface.

```ts
class CreditCard {}

interface Payments {
  charge(card: CreditCard, price: number): void
}

class SimulatedPayments implements Payments {
  charge(card: CreditCard, price: number): void {
    console.log(`charging ${price} to ${card}`)
  }
}

class Coffee {
  readonly price = 2
}

class Cafe {
  buyCoffee(
    card: CreditCard,
    payments: Payments
  ): Coffee {
    const cup = new Coffee()
    payments.charge(card, cup.price)
    return cup
  }
}
```

This version is easier to substitute in a test. It is still effectful.

The caller still receives only the coffee. `buyCoffee` still processes the payment before it returns.

Dependency injection changes where the effect is implemented. Dependency injection does not remove the effect from the method.

## 3. Return the charge instead of processing it

The functional version keeps `Cafe` and `Coffee` as classes. It changes the return value of `buyCoffee`.

```ts
class CreditCard {}

class Coffee {
  readonly price = 2
}

class Charge {
  constructor(
    readonly card: CreditCard,
    readonly amount: number
  ) {}

  combine(other: Charge): Charge {
    if (this.card !== other.card) {
      throw new Error(
        "Cannot combine charges for different cards"
      )
    }

    return new Charge(
      this.card,
      this.amount + other.amount
    )
  }
}

type CoffeePurchase = readonly [
  coffee: Coffee,
  charge: Charge
]

class Cafe {
  buyCoffee(card: CreditCard): CoffeePurchase {
    const cup = new Coffee()
    return [
      cup,
      new Charge(card, cup.price)
    ]
  }
}
```

The tuple mirrors the pair returned by the source example.

`buyCoffee` now returns both results:

```text
CreditCard -> Coffee and Charge
```

The method creates a coffee and describes the intended charge. It does not contact a payment system.

`Charge` is an immutable value. `combine` returns another `Charge` instead of changing either input.

The exception in `combine` matches the early chapter example. A later chapter develops returned error values as a more complete functional treatment.

## 4. Reuse the same method for several coffees

The original effectful method could not be called repeatedly without also charging repeatedly.

The functional method can be reused because each call returns data.

```ts
class CreditCard {}

class Coffee {
  readonly price = 2
}

class Charge {
  constructor(
    readonly card: CreditCard,
    readonly amount: number
  ) {}

  combine(other: Charge): Charge {
    if (this.card !== other.card) {
      throw new Error(
        "Cannot combine charges for different cards"
      )
    }

    return new Charge(
      this.card,
      this.amount + other.amount
    )
  }
}

type CoffeePurchase = readonly [
  coffee: Coffee,
  charge: Charge
]

type CoffeesPurchase = readonly [
  coffees: readonly Coffee[],
  charge: Charge
]

class Cafe {
  buyCoffee(card: CreditCard): CoffeePurchase {
    const cup = new Coffee()
    return [
      cup,
      new Charge(card, cup.price)
    ]
  }

  buyCoffees(
    card: CreditCard,
    count: number
  ): CoffeesPurchase {
    const purchases = Array.from(
      { length: count },
      () => this.buyCoffee(card)
    )

    const coffees = purchases.map(
      ([coffee]) => coffee
    )

    const charges = purchases.map(
      ([, charge]) => charge
    )

    const combinedCharge = charges.reduce(
      (left, right) => left.combine(right)
    )

    return [coffees, combinedCharge]
  }
}
```

The method assumes `count` is positive just as the source example assumes a nonempty list of charges before reducing it.

No payment has occurred. The returned charge can be tested or combined or processed later.

## 5. Keep interpretation outside the cafe

The `Cafe` no longer knows how charges are sent or persisted.

A separate outer layer can submit the final `Charge` to a payment system. The exact payment implementation is no longer part of buying coffee.

The resulting shape is:

```text
Cafe
  creates Coffee
  creates Charge
  returns both

Outer layer
  receives Charge
  interprets Charge through a payment system
```

The important transformation is not a move from classes to standalone functions.

The transformation is:

```text
perform an effect inside the operation
  ->
return a value that describes the effect
```

This separation makes the core easier to test and reuse. It also lets callers combine work before effects occur.

## 6. Extract a pure decision from an ordinary service method

The same pattern applies outside payment examples.

Suppose a service loads an invoice and decides whether to send a reminder.

```ts
interface Invoice {
  readonly id: string
  readonly dueAtMs: number
  readonly paidAtMs: number | null
  readonly customerEmail: string
}

interface InvoiceRepository {
  getById(id: string): Promise<Invoice>
}

interface Mailer {
  sendReminder(email: string): Promise<void>
}

async function remindCustomer(
  invoiceId: string,
  nowMs: number,
  invoices: InvoiceRepository,
  mailer: Mailer
): Promise<void> {
  const invoice = await invoices.getById(invoiceId)

  if (
    invoice.paidAtMs === null &&
    invoice.dueAtMs < nowMs
  ) {
    await mailer.sendReminder(invoice.customerEmail)
  }
}
```

The method performs two effects and one decision.

Name the decision first.

```ts
interface ReminderFacts {
  readonly dueAtMs: number
  readonly paidAtMs: number | null
  readonly nowMs: number
}

function shouldSendReminder(
  facts: ReminderFacts
): boolean {
  return (
    facts.paidAtMs === null &&
    facts.dueAtMs < facts.nowMs
  )
}
```

The shell becomes smaller.

```ts
interface Invoice {
  readonly id: string
  readonly dueAtMs: number
  readonly paidAtMs: number | null
  readonly customerEmail: string
}

interface InvoiceRepository {
  getById(id: string): Promise<Invoice>
}

interface Mailer {
  sendReminder(email: string): Promise<void>
}

function shouldSendReminder(facts: {
  readonly dueAtMs: number
  readonly paidAtMs: number | null
  readonly nowMs: number
}): boolean {
  return (
    facts.paidAtMs === null &&
    facts.dueAtMs < facts.nowMs
  )
}

async function remindCustomer(
  invoiceId: string,
  nowMs: number,
  invoices: InvoiceRepository,
  mailer: Mailer
): Promise<void> {
  const invoice = await invoices.getById(invoiceId)

  if (!shouldSendReminder({
    dueAtMs: invoice.dueAtMs,
    paidAtMs: invoice.paidAtMs,
    nowMs
  })) {
    return
  }

  await mailer.sendReminder(invoice.customerEmail)
}
```

The pure function now owns the business rule. The shell owns loading and sending.

## 7. Return a plan when the decision has several outputs

A boolean is not always enough.

Suppose the decision needs to explain what message to send.

```ts
interface ReminderFacts {
  readonly invoiceId: string
  readonly customerEmail: string
  readonly dueAtMs: number
  readonly paidAtMs: number | null
  readonly nowMs: number
}

interface ReminderPlan {
  readonly recipient: string
  readonly subject: string
  readonly body: string
}

function planReminder(
  facts: ReminderFacts
): ReminderPlan | undefined {
  if (
    facts.paidAtMs !== null ||
    facts.dueAtMs >= facts.nowMs
  ) {
    return undefined
  }

  return {
    recipient: facts.customerEmail,
    subject: `Invoice ${facts.invoiceId} is overdue`,
    body: "Please review the outstanding balance."
  }
}
```

The plan is a first-class value. A test can inspect the recipient and message without sending email.

An outer function interprets the plan.

```ts
interface ReminderPlan {
  readonly recipient: string
  readonly subject: string
  readonly body: string
}

interface Mailer {
  send(message: ReminderPlan): Promise<void>
}

async function executeReminder(
  plan: ReminderPlan,
  mailer: Mailer
): Promise<void> {
  await mailer.send(plan)
}
```

## 8. Make input effects explicit too

Effects are not only outputs. Reading information is also an effect.

A hidden clock makes a calculation depend on external state.

```ts
function isOverdue(dueAtMs: number): boolean {
  return dueAtMs < Date.now()
}
```

Pass the time as data when the clock is part of the calculation.

```ts
function isOverdue(
  dueAtMs: number,
  nowMs: number
): boolean {
  return dueAtMs < nowMs
}
```

The shell can read the clock once.

```ts
interface Clock {
  nowMs(): number
}

function checkOverdue(
  dueAtMs: number,
  clock: Clock
): boolean {
  return dueAtMs < clock.nowMs()
}
```

The second version makes the dependency explicit but remains effectful if the clock can change. The purest boundary accepts `nowMs` directly.

Choose the boundary that keeps the important rule easy to reason about.

## 9. Keep capabilities small

A component should not receive a full application object when it needs one operation.

```ts
interface UserWriter {
  insertUser(user: NewUser): Promise<string>
}

interface NewUser {
  readonly email: string
}

async function saveUser(
  user: NewUser,
  writer: UserWriter
): Promise<string> {
  return writer.insertUser(user)
}
```

The function does not know whether the writer uses PostgreSQL or an in-memory store.

A small interface expresses the required capability. Structural typing makes simple test implementations easy.

Do not create an interface for every class. Create a capability contract when code benefits from depending on an operation rather than one concrete implementation.

## 10. Keep independent work independent

Two effects can run together when neither needs the result of the other.

```ts
interface User {
  readonly id: string
}

interface Settings {
  readonly theme: string
}

declare function loadUser(id: string): Promise<User>
declare function loadSettings(id: string): Promise<Settings>

async function loadProfile(userId: string): Promise<{
  readonly user: User
  readonly settings: Settings
}> {
  const [user, settings] = await Promise.all([
    loadUser(userId),
    loadSettings(userId)
  ])

  return {
    user,
    settings
  }
}
```

Dependent work must wait.

```ts
interface User {
  readonly id: string
}

interface Order {
  readonly id: string
}

declare function loadUser(id: string): Promise<User>
declare function loadOrders(
  userId: string
): Promise<readonly Order[]>

async function loadUserOrders(
  externalId: string
): Promise<readonly Order[]> {
  const user = await loadUser(externalId)
  return loadOrders(user.id)
}
```

The distinction is about information flow. It is not a rule to use `Promise.all` everywhere.

## 11. Local mutation can remain inside a pure boundary

A pure function need not avoid every `let` or loop.

```ts
function sum(values: readonly number[]): number {
  let total = 0

  for (const value of values) {
    total += value
  }

  return total
}
```

The caller cannot observe the intermediate state. The function does not mutate the input. The same input produces the same result.

Avoid mutation that escapes through shared objects or module state.

## 12. A practical extraction pass

When a function feels difficult to test or reuse ask these questions:

1. What value is the function supposed to calculate?
2. Which facts determine that value?
3. Which lines read from the outside world?
4. Which lines change the outside world?
5. Can the decision return a value or plan before the action runs?
6. Can the shell load the facts and interpret the plan?
7. Does the pure function now have one coherent responsibility?

Do not split code until every line lives in a plausible place. A tiny pure helper that leaves the real decision tangled with database calls does not improve the design.

The goal is not the largest possible pure core. The goal is a boundary that makes the business rule independent of the machinery that supplies its inputs and handles its outputs.
