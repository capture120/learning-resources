---
name: typescript-functional-design-nathan
description: >-
  Design or write or refactor or review or teach TypeScript through foundational functional programming. Use this skill when work involves pure functions or referential transparency or function signatures or higher-order functions or immutable data or explicit state transitions or closed alternatives or effect descriptions or a thin effectful shell. Keep the TypeScript idiomatic. Preserve useful object-oriented and framework conventions unless they hide effects or allow invalid states.
---

# Functional Programming in TypeScript

Start with a function.

Ask what the function needs. Ask what the function returns. Then ask what the function does besides return a value.

The last question usually reveals the hard part of the design.

## Begin with a pure calculation

A pure function has one observable result. The result depends only on the arguments.

```ts
interface FeeFacts {
  readonly amountCents: number
  readonly rateBasisPoints: number
}

interface FeeSummary {
  readonly feeCents: number
  readonly netCents: number
}

function calculateFee(facts: FeeFacts): FeeSummary {
  const feeCents = Math.round(
    facts.amountCents * facts.rateBasisPoints / 10_000
  )

  return {
    feeCents,
    netCents: facts.amountCents - feeCents
  }
}
```

The function reads no clock. It writes no row. It sends no request. The arguments contain everything needed to calculate the result.

Use substitution as a quick test. Replace a call with the value it returns. If program behavior changes then the call was not referentially transparent.

## Move effects to the edge

The coffee example keeps the object-oriented design. `Cafe` stays a class. `buyCoffee` stays a method. The functional change is that the method stops performing the payment.

The first version creates a coffee and charges the card in the same method.

```ts
class Cafe {
  buyCoffee(card: CreditCard): Coffee {
    const cup = new Coffee()
    card.charge(cup.price)
    return cup
  }
}

class CreditCard {
  charge(price: number): void {
    console.log(`charging ${price}`)
  }
}

class Coffee {
  readonly price = 2
}
```

`buyCoffee` returns a `Coffee`. It also performs a payment. The return type does not describe the payment.

The book next moves payment processing behind an interface.

```ts
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
```

The dependency is now replaceable. `buyCoffee` is still effectful because it still calls `payments.charge`.

The functional version removes payment processing from `Cafe`. The method returns the charge as a value alongside the coffee.

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
        "Can't combine charges with different cards"
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
    return [cup, new Charge(card, cup.price)]
  }
}
```

The classes remain. The method becomes reusable because every result is returned. `Charge` is an immutable value. `combine` creates a new charge instead of changing either input.

The book then reuses `buyCoffee` to buy several coffees and combine their charges before any payment is processed.

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
        "Can't combine charges with different cards"
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

type CoffeePurchases = readonly [
  coffees: readonly Coffee[],
  charge: Charge
]

class Cafe {
  buyCoffee(card: CreditCard): CoffeePurchase {
    const cup = new Coffee()
    return [cup, new Charge(card, cup.price)]
  }

  buyCoffees(
    card: CreditCard,
    count: number
  ): CoffeePurchases {
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

Like the source example this method assumes `count` is positive. The source also postpones functional error handling. Its `Charge.combine` throws for different cards. Preserve that detail when teaching the example. Explain that the later error-handling chapter replaces expected exceptions with returned values.

The payment system can still exist. It belongs outside `Cafe`. The central lesson is not to remove classes. The lesson is to return the intended effect as data so another part of the program can inspect it or combine it or process it.

## Pass behavior as a value

Functions are values. They can be passed to other functions and returned from functions.

Use a higher-order function when several operations share the same structure but differ in one decision.

```ts
function findFirst<A>(
  values: readonly A[],
  matches: (value: A) => boolean
): number | undefined {
  const index = values.findIndex(matches)
  return index === -1 ? undefined : index
}
```

The traversal belongs to `findFirst`. The caller supplies the matching rule.

Do not introduce a higher-order function merely because a callback is possible. First find a stable process and a changing policy.

## Let the signature lead

Write the important input and output types before the body.

```ts
function compose<A, B, C>(
  second: (value: B) => C,
  first: (value: A) => B
): (value: A) => C {
  return value => second(first(value))
}
```

The signature gives us an `A`. The first function turns the `A` into a `B`. The second function turns the `B` into a `C`. The implementation follows the only direct path through those types.

Use generic parameters when the same unknown type must appear in more than one position. A generic parameter should preserve a relationship. It should not exist only to make the declaration look abstract.

Read [references/think-in-types.md](references/think-in-types.md) when the design depends on types or signatures.

## Return new values when state changes

Value-like data should not change under another part of the program.

```ts
interface Cart {
  readonly itemIds: readonly string[]
}

function addItem(cart: Cart, itemId: string): Cart {
  return {
    ...cart,
    itemIds: [...cart.itemIds, itemId]
  }
}
```

The original cart remains available. The returned cart represents the next state.

This rule applies to values and snapshots. A database-backed entity may still change. Keep that mutation in an effectful method or adapter. Do not pretend that every class must be an immutable value object.

Read [references/oo-and-functional.md](references/oo-and-functional.md) when classes or entities or resource owners are involved.

## Make the possible cases explicit

A value often has a fixed set of possible forms. Model each form with the fields that belong to it.

```ts
interface PendingPayment {
  readonly kind: "pending"
  readonly paymentId: string
}

interface PostedPayment {
  readonly kind: "posted"
  readonly paymentId: string
  readonly postedAtMs: number
}

interface VoidedPayment {
  readonly kind: "void"
  readonly paymentId: string
  readonly reason: string
}

type Payment =
  | PendingPayment
  | PostedPayment
  | VoidedPayment
```

A posted payment always has a posting time. A voided payment always has a reason. The type rules out the invalid combinations.

Handle the cases as a closed set.

```ts
interface PendingPayment {
  readonly kind: "pending"
}

interface PostedPayment {
  readonly kind: "posted"
  readonly postedAtMs: number
}

interface VoidedPayment {
  readonly kind: "void"
  readonly reason: string
}

type Payment =
  | PendingPayment
  | PostedPayment
  | VoidedPayment

function describePayment(payment: Payment): string {
  switch (payment.kind) {
    case "pending":
      return "Payment is pending"
    case "posted":
      return `Posted at ${payment.postedAtMs}`
    case "void":
      return payment.reason
  }
}
```

Read [references/states-and-boundaries.md](references/states-and-boundaries.md) when code receives untrusted data or models state changes or handles a closed set of cases.

## Make state an input and an output

Stateful logic becomes easier to reason about when the current state is an argument and the next state is the result.

```ts
interface Balance {
  readonly cents: number
}

interface Debit {
  readonly kind: "debit"
  readonly amountCents: number
}

interface Credit {
  readonly kind: "credit"
  readonly amountCents: number
}

type BalanceEvent = Debit | Credit

function applyBalanceEvent(
  balance: Balance,
  event: BalanceEvent
): Balance {
  switch (event.kind) {
    case "debit":
      return {
        cents: balance.cents - event.amountCents
      }
    case "credit":
      return {
        cents: balance.cents + event.amountCents
      }
  }
}
```

The function does not own a hidden balance. The caller decides where the current state comes from and where the next state goes.

## Build larger programs from smaller ones

Composition is more than writing short pipelines. The parts must have contracts that fit together.

Start with small operations. Give each operation one job. Keep the representation behind the public operations when callers do not need to know it.

Types are not enough to define meaning. State the laws that the operations should obey.

```ts
interface Money {
  readonly cents: number
}

const zeroMoney: Money = {
  cents: 0
}

function addMoney(left: Money, right: Money): Money {
  return {
    cents: left.cents + right.cents
  }
}
```

Useful laws include:

- `addMoney(value, zeroMoney)` equals `value`
- `addMoney(zeroMoney, value)` equals `value`
- Grouping additions differently does not change the result

Read [references/testing-and-review.md](references/testing-and-review.md) when adding tests or reviewing a design.

## Use this process when writing code

1. State the operation in one sentence.
2. List the facts the operation needs.
3. List the value the operation should return.
4. List every observable effect.
5. Write the important signatures.
6. Move deterministic rules into pure functions.
7. Represent closed alternatives with closed types.
8. Return new values for value-like state changes.
9. Keep effects in a small outer layer.
10. Test the pure rules and the laws directly.

Do not begin by adding abstractions. Begin with the domain operation. Generalize only after the same structure appears more than once.

## Respect the codebase

Do not force a new error model or effect library or class hierarchy into an established repository.

Preserve local conventions when they do not hide important behavior.

When a repository uses exceptions then keep the exception boundary unless the user asks for a different design. Do not call a throwing function strictly pure.

When a repository uses classes then decide what each class represents. A value class should return new values. An entity or resource owner may coordinate effects.

When local mutation cannot escape a function then judge the function by its observable behavior. A loop with a local accumulator can still present a pure interface.

## Explain the design through the code

When teaching or reviewing:

- Start with the operation the code performs.
- Show the current input and output path.
- Point out hidden inputs or hidden outputs.
- Extract one pure rule at a time.
- Show the revised TypeScript.
- Explain what became easier to reason about or test or reuse.
- Mark illustrative code that does not come from the repository.

Avoid abstract vocabulary until the example creates a need for it.

## References

- [references/think-in-types.md](references/think-in-types.md) develops type-driven design and function signatures.
- [references/pure-core-and-effects.md](references/pure-core-and-effects.md) shows how to separate calculation from effects.
- [references/oo-and-functional.md](references/oo-and-functional.md) covers classes and value objects and entities and resource owners.
- [references/states-and-boundaries.md](references/states-and-boundaries.md) covers closed states and runtime validation.
- [references/testing-and-review.md](references/testing-and-review.md) covers laws and tests and review work.
- [references/source-notes.md](references/source-notes.md) records the source material behind the skill.
