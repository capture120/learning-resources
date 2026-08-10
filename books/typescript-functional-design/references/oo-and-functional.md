# Object-Oriented and Functional TypeScript

Functional programming does not require every program to become a collection of standalone functions.

A class can hold an immutable value. A class can own a resource. A class can represent a database entity. A class can coordinate effects around pure functions.

The important question is not “class or function?”

The important question is “what kind of thing does this class represent?”

## 1. Immutable value objects

A value object is identified by its contents.

Money is a familiar example.

```ts
class Money {
  constructor(
    readonly currency: "USD" | "EUR",
    readonly amountCents: number
  ) {}

  add(other: Money): Money {
    if (this.currency !== other.currency) {
      throw new Error(
        "Cannot add different currencies"
      )
    }

    return new Money(
      this.currency,
      this.amountCents + other.amountCents
    )
  }

  equals(other: Money): boolean {
    return (
      this.currency === other.currency &&
      this.amountCents === other.amountCents
    )
  }
}
```

`add` returns a new `Money`. It does not change either operand.

The method is ordinary object-oriented syntax. The behavior is functional because the value is immutable and the result depends only on the two values.

JavaScript compares class instances by reference. Define value equality when the domain needs it.

A plain object may be simpler when methods add little value.

```ts
interface Money {
  readonly currency: "USD" | "EUR"
  readonly amountCents: number
}

function addMoney(left: Money, right: Money): Money {
  if (left.currency !== right.currency) {
    throw new Error(
      "Cannot add different currencies"
    )
  }

  return {
    currency: left.currency,
    amountCents:
      left.amountCents + right.amountCents
  }
}
```

Choose the representation that makes the public operations clear.

## 2. Immutable snapshots

Requests and view models often represent facts at one point in time.

Transform them by returning another snapshot.

```ts
interface DraftInvoice {
  readonly description: string
  readonly lineItems: readonly LineItem[]
}

interface LineItem {
  readonly description: string
  readonly amountCents: number
}

function addLineItem(
  invoice: DraftInvoice,
  lineItem: LineItem
): DraftInvoice {
  return {
    ...invoice,
    lineItems: [
      ...invoice.lineItems,
      lineItem
    ]
  }
}
```

The original invoice remains valid.

The spread is shallow. The types of nested values must also be readonly if callers should not mutate them.

## 3. Database-backed entities

A database entity is different from a value object.

The entity has stable identity. Its stored state may change.

```ts
interface LedgerTransactionData {
  readonly id: string
  readonly status: "pending" | "posted" | "void"
}

interface LedgerTransactionRepository {
  load(id: string): Promise<LedgerTransactionData>
  markPosted(
    id: string,
    postedAtMs: number
  ): Promise<void>
}

class LedgerTransaction {
  constructor(
    readonly id: string,
    private readonly repository:
      LedgerTransactionRepository
  ) {}

  async getStatus(): Promise<
    LedgerTransactionData["status"]
  > {
    const data = await this.repository.load(this.id)
    return data.status
  }

  async post(postedAtMs: number): Promise<void> {
    const status = await this.getStatus()

    if (status !== "pending") {
      throw new Error(
        "Only pending transactions can be posted"
      )
    }

    await this.repository.markPosted(
      this.id,
      postedAtMs
    )
  }
}
```

The class is not an immutable value. It is a handle to durable state.

That is not a failure of functional design. The method belongs in the effectful shell.

The useful improvement is to keep substantial business decisions outside the database operations when possible.

## 4. Pure decisions inside class commands

Suppose posting rules become more complicated.

Keep the decision separate from the write.

```ts
interface PostingFacts {
  readonly status: "pending" | "posted" | "void"
  readonly amountCents: number
}

interface PostingDecision {
  readonly canPost: boolean
  readonly reason: string | undefined
}

function decidePosting(
  facts: PostingFacts
): PostingDecision {
  if (facts.status !== "pending") {
    return {
      canPost: false,
      reason: "Transaction is not pending"
    }
  }

  if (facts.amountCents === 0) {
    return {
      canPost: false,
      reason: "Transaction has no amount"
    }
  }

  return {
    canPost: true,
    reason: undefined
  }
}
```

The class method can load facts and apply the decision.

```ts
interface TransactionData {
  readonly status: "pending" | "posted" | "void"
  readonly amountCents: number
}

interface TransactionStore {
  load(id: string): Promise<TransactionData>
  markPosted(
    id: string,
    postedAtMs: number
  ): Promise<void>
}

function decidePosting(facts: TransactionData): {
  readonly canPost: boolean
  readonly reason: string | undefined
} {
  if (facts.status !== "pending") {
    return {
      canPost: false,
      reason: "Transaction is not pending"
    }
  }

  if (facts.amountCents === 0) {
    return {
      canPost: false,
      reason: "Transaction has no amount"
    }
  }

  return {
    canPost: true,
    reason: undefined
  }
}

class Transaction {
  constructor(
    readonly id: string,
    private readonly store: TransactionStore
  ) {}

  async post(postedAtMs: number): Promise<void> {
    const data = await this.store.load(this.id)
    const decision = decidePosting(data)

    if (!decision.canPost) {
      throw new Error(
        decision.reason ?? "Cannot post transaction"
      )
    }

    await this.store.markPosted(
      this.id,
      postedAtMs
    )
  }
}
```

The class still owns the command. The pure function owns the rule.

This split is useful when the rule deserves direct tests or reuse in another workflow.

## 5. Resource-owning classes

Some objects exist to own mutable resources.

A cache is one example.

```ts
class UserCache {
  private readonly values = new Map<
    string,
    string
  >()

  get(userId: string): string | undefined {
    return this.values.get(userId)
  }

  set(userId: string, name: string): void {
    this.values.set(userId, name)
  }

  clear(): void {
    this.values.clear()
  }
}
```

The internal state changes. The class makes that state explicit and gives the mutation a boundary.

Do not rewrite a resource owner as a chain of copied objects merely to look functional.

Instead keep business calculations outside the resource owner. Keep the mutable surface small.

## 6. Small interfaces describe capabilities

A class often depends on one operation from another component.

Name that operation.

```ts
interface Clock {
  nowMs(): number
}

interface PaymentRecord {
  readonly createdAtMs: number
}

function createPaymentRecord(
  clock: Clock
): PaymentRecord {
  return {
    createdAtMs: clock.nowMs()
  }
}
```

TypeScript uses structural typing. Any object with a compatible `nowMs` method satisfies `Clock`.

A small capability interface keeps the caller independent of a concrete clock class.

The function is still effectful if `nowMs` changes between calls. To recover a pure boundary pass the returned value instead.

```ts
interface PaymentRecord {
  readonly createdAtMs: number
}

function makePaymentRecord(
  createdAtMs: number
): PaymentRecord {
  return {
    createdAtMs
  }
}
```

## 7. Factories can protect invariants

A class constructor can be private when callers must pass through validation.

```ts
class Percentage {
  private constructor(
    readonly value: number
  ) {}

  static from(value: number): Percentage {
    if (value < 0 || value > 100) {
      throw new Error(
        "Percentage must be between 0 and 100"
      )
    }

    return new Percentage(value)
  }
}
```

The factory turns an unchecked number into a checked value.

The private constructor controls construction. The private constructor alone does not make every property deeply immutable.

## 8. Preserve history by adding facts

Financial and audit domains often need append-only history.

A reversal should usually create a new event rather than erase the original event.

```ts
interface LedgerEntry {
  readonly accountId: string
  readonly amountCents: number
}

interface LedgerTransaction {
  readonly id: string
  readonly entries: readonly LedgerEntry[]
  readonly reverseOfId: string | undefined
}

function reverseTransaction(
  original: LedgerTransaction,
  reversalId: string
): LedgerTransaction {
  return {
    id: reversalId,
    entries: original.entries.map(entry => ({
      accountId: entry.accountId,
      amountCents: -entry.amountCents
    })),
    reverseOfId: original.id
  }
}
```

The original transaction remains part of the record. The reversal records a later fact.

The persistence layer still performs writes. The transformation that builds the reversal can remain pure.

## 9. Methods and standalone functions are both valid

Use a method when one value is the obvious primary operand.

```ts
class Money {
  constructor(readonly amountCents: number) {}

  add(other: Money): Money {
    return new Money(
      this.amountCents + other.amountCents
    )
  }
}
```

Use a standalone function when no operand owns the operation or when the operation belongs to a separate policy.

```ts
interface Money {
  readonly amountCents: number
}

function allocate(
  available: Money,
  requested: Money
): {
  readonly accepted: Money
  readonly remaining: Money
} {
  const acceptedCents = Math.min(
    available.amountCents,
    requested.amountCents
  )

  return {
    accepted: {
      amountCents: acceptedCents
    },
    remaining: {
      amountCents:
        requested.amountCents - acceptedCents
    }
  }
}
```

The choice is often aesthetic. Purity depends on behavior rather than invocation syntax.

## 10. A quick classification pass

Before changing a class ask:

- Is the object a value that should be compared by contents?
- Is the object a snapshot that should be copied when changed?
- Is the object a durable entity with stable identity?
- Is the object a resource owner with necessary internal mutation?
- Is the object a service that coordinates effects?

Then choose the rule:

- Value objects return new values.
- Snapshots return copied snapshots.
- Entities expose explicit commands and queries.
- Resource owners keep mutation private.
- Services move substantial deterministic rules into pure functions.

Do not apply immutable value semantics to every class. Apply the semantics that match the thing being modeled.
