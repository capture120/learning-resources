# Testing and Review

Pure functions make tests small because the test supplies the inputs and inspects the returned value.

Effectful shells need a different kind of test. Those tests verify coordination with the outside world.

Keep the two kinds of test separate.

## 1. Test pure behavior directly

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

const result = calculateFee({
  amountCents: 10_000,
  rateBasisPoints: 250
})

if (result.feeCents !== 250) {
  throw new Error("Wrong fee")
}

if (result.netCents !== 9_750) {
  throw new Error("Wrong net amount")
}
```

The test needs no database and no clock and no mock server.

Use the repository test framework in real code. The example only shows the shape of the test.

## 2. Test the boundary cases in the type

A function should be tested across the cases its signature admits.

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

if (maximum([]) !== undefined) {
  throw new Error("Empty input should have no maximum")
}

if (maximum([3, 1, 2]) !== 3) {
  throw new Error("Wrong maximum")
}
```

The empty case matters because the return type includes `undefined`.

## 3. Test laws as well as examples

An example checks one input. A law checks a relationship that should hold for many inputs.

### Identity

```ts
interface Money {
  readonly cents: number
}

function addMoney(left: Money, right: Money): Money {
  return {
    cents: left.cents + right.cents
  }
}

const zero: Money = {
  cents: 0
}

const value: Money = {
  cents: 500
}

if (addMoney(value, zero).cents !== value.cents) {
  throw new Error("Right identity failed")
}

if (addMoney(zero, value).cents !== value.cents) {
  throw new Error("Left identity failed")
}
```

### Associativity

```ts
interface Money {
  readonly cents: number
}

function addMoney(left: Money, right: Money): Money {
  return {
    cents: left.cents + right.cents
  }
}

const first: Money = { cents: 100 }
const second: Money = { cents: 200 }
const third: Money = { cents: 300 }

const left = addMoney(
  addMoney(first, second),
  third
)

const right = addMoney(
  first,
  addMoney(second, third)
)

if (left.cents !== right.cents) {
  throw new Error("Associativity failed")
}
```

### Reversal

```ts
interface Balance {
  readonly cents: number
}

function applyDelta(
  balance: Balance,
  deltaCents: number
): Balance {
  return {
    cents: balance.cents + deltaCents
  }
}

const start: Balance = {
  cents: 1_000
}

const changed = applyDelta(start, 250)
const restored = applyDelta(changed, -250)

if (restored.cents !== start.cents) {
  throw new Error("Reversal law failed")
}
```

Property-based testing is useful when a law should hold over a large input space. A small table of representative values is still a good first test.

## 4. Test immutability promises

When a function claims to return a new value make sure the input did not change.

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

const original: Cart = {
  itemIds: ["item-1"]
}

const updated = addItem(original, "item-2")

if (original.itemIds.length !== 1) {
  throw new Error("Input was mutated")
}

if (updated.itemIds.length !== 2) {
  throw new Error("Output is missing the item")
}
```

Test object identity only when structural sharing is part of the contract. Most value tests should compare the values.

## 5. Test effect coordination separately

A shell test should verify which effect was requested.

```ts
interface Charge {
  readonly cardId: string
  readonly amountCents: number
}

interface Payments {
  charge(charge: Charge): Promise<void>
}

async function submitCharge(
  charge: Charge,
  payments: Payments
): Promise<void> {
  await payments.charge(charge)
}

async function testSubmitCharge(): Promise<void> {
  const received: Charge[] = []

  const payments: Payments = {
    async charge(charge) {
      received.push(charge)
    }
  }

  const expected: Charge = {
    cardId: "card-1",
    amountCents: 500
  }

  await submitCharge(expected, payments)

  if (received.length !== 1) {
    throw new Error("Expected one charge")
  }

  if (received[0]?.amountCents !== 500) {
    throw new Error("Wrong charge")
  }
}
```

The pure calculation that produced the charge should have its own test. The shell test should not repeat that business rule.

## 6. Test runtime boundaries with bad data

Boundary tests should include malformed values.

```ts
function parseAmount(input: unknown): number {
  if (
    typeof input !== "number" ||
    !Number.isSafeInteger(input)
  ) {
    throw new Error("Expected integer cents")
  }

  return input
}

const invalidValues: readonly unknown[] = [
  "500",
  1.5,
  Number.NaN,
  Number.POSITIVE_INFINITY,
  null
]

for (const value of invalidValues) {
  let threw = false

  try {
    parseAmount(value)
  } catch {
    threw = true
  }

  if (!threw) {
    throw new Error("Invalid value was accepted")
  }
}
```

Also test the smallest and largest valid values that matter to the domain.

## 7. Review the signature before the body

Start a review with the boundary.

Ask:

- Does the function receive every fact it needs?
- Does the return type include every meaningful result?
- Does the signature admit invalid states?
- Is failure normal data or an exceptional condition?
- Does a generic parameter preserve a real relationship?
- Does an input type expose more of the system than the function needs?

Then read the body.

Ask:

- Does the body read hidden state?
- Does the body mutate caller-owned data?
- Does the body perform effects not visible in the design?
- Does the function do more than one coherent job?
- Can a decision be separated from loading or writing?

## 8. Review classes by role

For a value object ask:

- Are the fields immutable?
- Do changing methods return new values?
- Does equality follow the domain meaning?

For a database entity ask:

- Is identity stable?
- Are commands named after domain transitions?
- Are complex decisions separated from persistence?

For a resource owner ask:

- Is mutable state private?
- Is the lifecycle explicit?
- Does business logic live outside the resource management code?

For a service ask:

- Does the service mainly coordinate effects?
- Can deterministic rules move into pure functions?
- Are dependencies narrower than the whole application container?

## 9. Report findings through one concrete example

A useful review finding has four parts:

1. The current signature or code.
2. The hidden effect or invalid state or duplicated rule.
3. The smallest useful change.
4. The revised TypeScript.

Do not begin with abstract labels such as “not functional enough.” Show the behavior that makes the code hard to reason about.

For teaching work use the same sequence:

1. Explain what the code does now.
2. Show where input or output is hidden.
3. Extract one pure rule.
4. Show how the shell uses the rule.
5. Explain what improved.

## 10. Final review questions

Before approving the design ask:

- Can the core rule run without the database or network?
- Can a call be replaced by its result without changing behavior?
- Are closed cases modeled as closed types?
- Are state changes explicit?
- Are value inputs protected from mutation?
- Are runtime values validated before use?
- Are effects concentrated near the boundary?
- Are laws tested where the types stop?
- Does every abstraction remove real duplication or hidden knowledge?
