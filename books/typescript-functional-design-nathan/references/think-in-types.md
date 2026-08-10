# Think in Types

Suppose we need to calculate a fee.

We could start with the body. We could also start by asking what the calculation knows and what it produces.

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

The signature tells us almost everything that matters at the boundary. The function needs two facts. It returns two facts. The signature leaves no room for a database query or a clock read unless the implementation hides one.

Thinking in types means designing this boundary before filling in the control flow.

## 1. Types describe possibilities

A type is a set of values. The type also tells us which operations are safe for those values.

```ts
type CurrencyCode = "USD" | "EUR" | "GBP"

interface Money {
  readonly currency: CurrencyCode
  readonly amountCents: number
}
```

`string` admits every string. `CurrencyCode` admits three strings.

A narrower type is useful when the domain is narrow. It removes cases that the rest of the program would otherwise need to check.

Do not make a type narrow for decoration. Make it narrow when the excluded values are not valid values of the domain.

## 2. Start with the function signature

A signature describes the information that flows into and out of a function.

```ts
function calculateOutstandingBalance(
  invoicedCents: number,
  paidCents: number
): number {
  return invoicedCents - paidCents
}
```

Before writing the body ask:

- What facts are required?
- What result should the caller receive?
- Can the function fail for an admitted input?
- Does the result omit anything the caller needs?
- Would the body need a fact that is absent from the signature?

A good signature does not guarantee a good implementation. TypeScript does not stop the body from reading global state or writing to a database. The signature still gives us a standard against which to judge the body.

## 3. Use products for facts that exist together

An object or tuple is a product type. A value of the type contains all of its parts.

```ts
interface DateRange {
  readonly startMs: number
  readonly endMs: number
}
```

A `DateRange` has a start and an end. The two values belong to one concept.

A tuple can express the same idea when position is enough.

```ts
type Coordinate = readonly [x: number, y: number]

function moveRight(
  coordinate: Coordinate,
  distance: number
): Coordinate {
  return [
    coordinate[0] + distance,
    coordinate[1]
  ]
}
```

Use an object when field names matter at the call site. Use a tuple when the grouping is small and local and positional meaning is clear.

A product type is also useful for returning several results instead of hiding work.

```ts
interface Allocation {
  readonly acceptedCents: number
  readonly remainingCents: number
}

function allocatePayment(
  paymentCents: number,
  balanceCents: number
): Allocation {
  const acceptedCents = Math.min(
    paymentCents,
    balanceCents
  )

  return {
    acceptedCents,
    remainingCents: paymentCents - acceptedCents
  }
}
```

## 4. Use sums for closed alternatives

A value may be one of several forms. A union describes the alternatives.

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

Each member is a product. The union is a sum.

The design says more than a collection of optional fields would say. A posted payment cannot exist without `postedAtMs`. A voided payment cannot exist without a reason.

Use a discriminated union when the cases are closed. Use an open interface when other code should be free to add new implementations.

## 5. Make handling total

A function is total when it produces a result for every input admitted by its type.

A closed union gives us a closed set of cases.

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

The return type and `noImplicitReturns` help TypeScript report a missing branch.

A `Record` can perform the same check for a complete lookup table.

```ts
type PaymentKind =
  | "pending"
  | "posted"
  | "void"

const paymentLabels: Record<PaymentKind, string> = {
  pending: "Pending",
  posted: "Posted",
  void: "Void"
}
```

`Record` is a TypeScript tool. The design principle is complete handling of a closed set.

## 6. Make partial functions honest

A function is partial when some admitted inputs do not have a normal result.

There are two common repairs.

### Narrow the input

```ts
interface NonEmptyNumbers {
  readonly first: number
  readonly rest: readonly number[]
}

function maximum(values: NonEmptyNumbers): number {
  let current = values.first

  for (const value of values.rest) {
    current = Math.max(current, value)
  }

  return current
}
```

The type excludes the empty case.

### Widen the output

```ts
function maximum(
  values: readonly number[]
): number | undefined {
  const [first, ...rest] = values

  if (first === undefined) {
    return undefined
  }

  let current = first

  for (const value of rest) {
    current = Math.max(current, value)
  }

  return current
}
```

The input remains broad. The output now includes absence.

Choose based on the caller. If emptiness is a programming error then narrow the input. If emptiness is normal data then represent the possibility in the output.

An exception-based repository may still throw. Treat that choice as a compatibility rule. Do not call the throwing function total or strictly pure.

## 7. Give a function the smallest complete input

A function should not know more than it needs.

```ts
interface OrderRecord {
  readonly id: string
  readonly customerId: string
  readonly subtotalCents: number
  readonly discountCents: number
  readonly createdAtMs: number
}

interface PricingFacts {
  readonly subtotalCents: number
  readonly discountCents: number
}

function calculateTotal(facts: PricingFacts): number {
  return facts.subtotalCents - facts.discountCents
}

const order: OrderRecord = {
  id: "order-1",
  customerId: "customer-1",
  subtotalCents: 5_000,
  discountCents: 500,
  createdAtMs: 1_700_000_000_000
}

calculateTotal(order)
```

TypeScript is structurally typed. The larger record satisfies the smaller contract.

The pure calculation does not depend on a persistence type. It depends on the facts named by the domain operation.

`Pick` is useful when the source record should remain authoritative.

```ts
interface OrderRecord {
  readonly id: string
  readonly subtotalCents: number
  readonly discountCents: number
}

type PricingFacts = Pick<
  OrderRecord,
  "subtotalCents" | "discountCents"
>

function calculateTotal(facts: PricingFacts): number {
  return facts.subtotalCents - facts.discountCents
}
```

Use `Pick` for a projection of an existing contract. Use a named domain interface when the operation should own the contract.

## 8. Treat runtime input as untrusted

TypeScript types disappear at runtime. A request body does not become safe because a TypeScript interface exists.

Start with `unknown`.

```ts
interface PaymentRequest {
  readonly paymentId: string
  readonly amountCents: number
}

function parsePaymentRequest(
  input: unknown
): PaymentRequest {
  if (
    typeof input !== "object" ||
    input === null
  ) {
    throw new Error("Expected an object")
  }

  const record = input as Record<string, unknown>
  const paymentId = record.paymentId
  const amountCents = record.amountCents

  if (typeof paymentId !== "string") {
    throw new Error("Expected paymentId")
  }

  if (
    typeof amountCents !== "number" ||
    !Number.isSafeInteger(amountCents)
  ) {
    throw new Error("Expected integer cents")
  }

  return {
    paymentId,
    amountCents
  }
}
```

The assertion to `Record<string, unknown>` follows a runtime object check. The code still validates every property before use.

A schema library can perform the same job. The important boundary is the change from untrusted input to a trusted domain value.

## 9. Let validation strengthen a type

A validation step should return a value that records what was proved.

```ts
class EmailAddress {
  private constructor(
    private readonly normalized: string
  ) {}

  static parse(input: string): EmailAddress {
    const normalized = input.trim().toLowerCase()

    if (!normalized.includes("@")) {
      throw new Error("Invalid email address")
    }

    return new EmailAddress(normalized)
  }

  get value(): string {
    return this.normalized
  }
}
```

The constructor is private. Callers must use `parse`.

After parsing the rest of the program can ask for `EmailAddress` instead of asking for a string and repeating the same check.

The class is one possible representation. A branded value or validated object can serve the same role.

## 10. Use generics to preserve relationships

A generic parameter is useful when one unknown type appears in several positions.

```ts
function mapValues<Input, Output>(
  values: readonly Input[],
  transform: (value: Input) => Output
): readonly Output[] {
  return values.map(transform)
}
```

`Input` connects the array element with the callback parameter. `Output` connects the callback result with the returned array element.

The generic parameters do not mean “accept anything and forget what it was.” They mean “accept many types while preserving the relationship between the positions.”

Consider property access.

```ts
function getProperty<
  ObjectType,
  Key extends keyof ObjectType
>(
  object: ObjectType,
  key: Key
): ObjectType[Key] {
  return object[key]
}
```

The key must belong to the object. The return type changes with the key.

Use a generic parameter only when it relates at least two parts of the signature or constrains a type in a useful way.

## 11. Follow generic signatures toward implementations

A polymorphic signature limits what the body can do.

### Partial application

```ts
function partial<A, B, C>(
  value: A,
  functionOfTwo: (first: A, second: B) => C
): (second: B) => C {
  return second => functionOfTwo(value, second)
}
```

The function must return `(second: B) => C`.

Inside that returned function we have an `A` and a `B`. The supplied function is the only source of a `C`.

### Composition

```ts
function compose<A, B, C>(
  second: (value: B) => C,
  first: (value: A) => B
): (value: A) => C {
  return value => second(first(value))
}
```

The implementation is not clever. It is the path described by the signature.

This is the practical value of thinking in types. The signature reduces the number of plausible implementations before we write the body.

## 12. Separate stable structure from changing policy

Two functions often differ in one operation while sharing the same traversal or workflow.

```ts
function formatResult(
  name: string,
  value: number,
  calculate: (value: number) => number
): string {
  return `${name} of ${value} is ${calculate(value)}`
}

function absolute(value: number): number {
  return value < 0 ? -value : value
}

function square(value: number): number {
  return value * value
}

formatResult("absolute value", -4, absolute)
formatResult("square", 4, square)
```

The formatting is stable. The calculation is a parameter.

Look for this pattern after concrete examples show real duplication. Premature generalization makes a signature harder to understand rather than more reusable.

## 13. Model state transitions in the signature

A state transition receives the current state and returns the next state.

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

The signature exposes the state that an imperative object might hide.

A reducer is one common TypeScript form of the same idea.

## 14. Return effect descriptions before executing them

A pure function can decide what should happen without performing the action.

```ts
interface WelcomeEmail {
  readonly recipient: string
  readonly subject: string
  readonly body: string
}

function planWelcomeEmail(
  email: string,
  firstName: string
): WelcomeEmail {
  return {
    recipient: email,
    subject: "Welcome",
    body: `Hello ${firstName}`
  }
}
```

An outer component can interpret the returned value.

```ts
interface WelcomeEmail {
  readonly recipient: string
  readonly subject: string
  readonly body: string
}

interface Mailer {
  send(message: WelcomeEmail): Promise<void>
}

async function sendWelcomeEmail(
  message: WelcomeEmail,
  mailer: Mailer
): Promise<void> {
  await mailer.send(message)
}
```

The description is ordinary data. It can be inspected or combined or tested without a mail server.

## 15. Use small capability contracts at effect boundaries

A component should receive the operations it needs rather than the whole application.

```ts
interface Clock {
  nowMs(): number
}

interface IdGenerator {
  nextId(): string
}

interface PaymentRecord {
  readonly id: string
  readonly createdAtMs: number
}

function createPaymentRecord(
  clock: Clock,
  ids: IdGenerator
): PaymentRecord {
  return {
    id: ids.nextId(),
    createdAtMs: clock.nowMs()
  }
}
```

The function is not strictly pure because the capabilities may return different values. The dependencies are still explicit. The function no longer knows which clock or identifier service the application uses.

When possible call the capabilities in the shell and pass their returned facts into a pure constructor.

```ts
interface PaymentRecord {
  readonly id: string
  readonly createdAtMs: number
}

function makePaymentRecord(
  id: string,
  createdAtMs: number
): PaymentRecord {
  return {
    id,
    createdAtMs
  }
}
```

## 16. Use inference without losing the contract

TypeScript is good at local inference.

```ts
function calculateNet(
  amountCents: number,
  feeCents: number
): number {
  const netCents = amountCents - feeCents
  return netCents
}
```

The type of `netCents` is obvious. An annotation would repeat work.

Annotate parameters because the body usually cannot supply their types. Annotate public return types when the contract matters or when an accidental widening would be costly. Let local variables and inline callbacks use contextual inference.

A standalone call-signature type is useful when the contract exists apart from one implementation.

```ts
interface FeeFacts {
  readonly amountCents: number
}

interface FeeSummary {
  readonly feeCents: number
  readonly netCents: number
}

type FeeCalculator = (
  facts: FeeFacts
) => FeeSummary

const noFee: FeeCalculator = facts => ({
  feeCents: 0,
  netCents: facts.amountCents
})
```

For one ordinary named function a declaration is often simpler. Both forms are valid TypeScript.

## 17. Types do not define the whole meaning

This type permits many implementations:

```ts
function combine(
  left: number,
  right: number
): number {
  return left + right
}
```

The signature does not tell us whether addition or subtraction or multiplication is correct.

The domain supplies laws.

For money addition useful laws might include:

- Adding zero changes nothing
- Grouping additions differently does not change the result

For a state transition useful laws might include:

- Applying the same idempotent event twice has the same effect as applying it once
- Applying a reversal after an original event restores the prior balance

Types rule out invalid shapes. Laws describe relationships between valid values.

## 18. Know what TypeScript cannot prove

TypeScript cannot prove that a function is pure.

```ts
let auditCount = 0

function calculateTotal(
  subtotalCents: number,
  discountCents: number
): number {
  auditCount += 1
  return subtotalCents - discountCents
}
```

The signature looks like an ordinary calculation. The body mutates external state.

TypeScript also cannot prove deep immutability. `readonly` prevents assignment through the declared property. It does not freeze every referenced object.

TypeScript cannot validate network input after the types have been erased. Runtime checks are still required.

TypeScript cannot state every domain law. Tests and review still matter.

## A practical type-first pass

Work through these questions before the implementation grows large.

1. What values are valid in the domain?
2. Which facts must exist together?
3. Which alternatives form a closed set?
4. What does the function need to know?
5. What should the function return?
6. Is the function defined for every admitted input?
7. Which relationships should generics preserve?
8. Which inputs arrive from an untrusted runtime boundary?
9. Which state changes can become explicit transitions?
10. Which effects can become returned descriptions?
11. Which laws complete the meaning of the types?

Then read the body against the signature.

If the body needs hidden information then change the boundary or move the work.

If the type admits invalid combinations then redesign the data.

If the implementation has many unrelated branches then the input type may be too broad.

If several implementations repeat the same structure then pass the changing part as a function or generalize the type relationship.
