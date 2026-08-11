# States and Runtime Boundaries

TypeScript can prevent many invalid states before the program runs. It cannot inspect a JSON request after types have been erased.

Good boundary design therefore has two parts:

1. Model valid states precisely.
2. Validate untrusted values before they enter the model.

## 1. Replace loose fields with real states

Consider a payment represented by a boolean and an optional date.

```ts
interface Payment {
  readonly isPosted: boolean
  readonly postedAtMs?: number
}
```

This type permits a posted payment without a posting time. It also permits an unposted payment with a posting time.

The fields describe four combinations. The domain needs two.

Model the two states directly.

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

type Payment =
  | PendingPayment
  | PostedPayment
```

The invalid combinations no longer exist in the type.

## 2. Use literal types for closed values

A literal union describes a small closed set.

```ts
type PaymentStatus =
  | "pending"
  | "posted"
  | "void"
```

Use a literal union when the application owns the complete set.

Use `string` when new values may arrive from external systems or plugins without a code change.

Do not use a narrow union and then cast unknown strings into it. Validate the string at the boundary.

## 3. Give every case its own fields

A discriminated union works best when each case has one stable literal tag.

```ts
interface PendingTransfer {
  readonly kind: "pending"
  readonly transferId: string
}

interface CompletedTransfer {
  readonly kind: "completed"
  readonly transferId: string
  readonly completedAtMs: number
  readonly confirmationId: string
}

interface FailedTransfer {
  readonly kind: "failed"
  readonly transferId: string
  readonly reason: string
}

type Transfer =
  | PendingTransfer
  | CompletedTransfer
  | FailedTransfer
```

The tag lets TypeScript narrow the value.

```ts
interface PendingTransfer {
  readonly kind: "pending"
}

interface CompletedTransfer {
  readonly kind: "completed"
  readonly confirmationId: string
}

interface FailedTransfer {
  readonly kind: "failed"
  readonly reason: string
}

type Transfer =
  | PendingTransfer
  | CompletedTransfer
  | FailedTransfer

function transferMessage(
  transfer: Transfer
): string {
  switch (transfer.kind) {
    case "pending":
      return "Transfer is pending"
    case "completed":
      return transfer.confirmationId
    case "failed":
      return transfer.reason
  }
}
```

Keep the tag field consistent across every member. Give each member a unique literal tag.

## 4. Make transitions explicit

A transition should show the old state and the new state.

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

function postPayment(
  payment: PendingPayment,
  postedAtMs: number
): PostedPayment {
  return {
    kind: "posted",
    paymentId: payment.paymentId,
    postedAtMs
  }
}
```

The function cannot accept an already posted payment. The input type records the precondition.

An effectful service can load the current state and persist the returned state.

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

interface PaymentStore {
  loadPending(id: string): Promise<PendingPayment>
  savePosted(payment: PostedPayment): Promise<void>
}

function postPayment(
  payment: PendingPayment,
  postedAtMs: number
): PostedPayment {
  return {
    kind: "posted",
    paymentId: payment.paymentId,
    postedAtMs
  }
}

async function postStoredPayment(
  paymentId: string,
  postedAtMs: number,
  store: PaymentStore
): Promise<void> {
  const pending = await store.loadPending(paymentId)
  const posted = postPayment(pending, postedAtMs)
  await store.savePosted(posted)
}
```

## 5. Use complete mappings for closed sets

A closed union often needs a complete lookup table.

```ts
type PaymentStatus =
  | "pending"
  | "posted"
  | "void"

const labels: Record<PaymentStatus, string> = {
  pending: "Pending",
  posted: "Posted",
  void: "Void"
}
```

Adding another status now creates a type error until the table handles it.

Use `Record` when the keys are closed and every key requires a value.

## 6. Start untrusted data as unknown

A request body and a parsed JSON value do not carry trustworthy TypeScript types.

```ts
function readAmount(input: unknown): number {
  if (
    typeof input !== "number" ||
    !Number.isSafeInteger(input)
  ) {
    throw new Error("Expected integer cents")
  }

  return input
}
```

`unknown` allows any value to arrive. It does not allow the program to use the value until runtime checks prove something about it.

Avoid `any` at the boundary. `any` disables the checks that the boundary needs.

## 7. Validate object shape one field at a time

```ts
interface TransferRequest {
  readonly transferId: string
  readonly amountCents: number
}

function parseTransferRequest(
  input: unknown
): TransferRequest {
  if (
    typeof input !== "object" ||
    input === null
  ) {
    throw new Error("Expected an object")
  }

  const record = input as Record<string, unknown>
  const transferId = record.transferId
  const amountCents = record.amountCents

  if (typeof transferId !== "string") {
    throw new Error("Expected transferId")
  }

  if (
    typeof amountCents !== "number" ||
    !Number.isSafeInteger(amountCents)
  ) {
    throw new Error("Expected integer cents")
  }

  return {
    transferId,
    amountCents
  }
}
```

The single assertion follows an object check. No property becomes trusted until its own check passes.

Use a schema library when the repository has one. The design remains the same:

```text
unknown input -> runtime validation -> trusted domain value
```

## 8. Parse once and pass the stronger value

Do not repeat the same validation in every function.

```ts
class AccountId {
  private constructor(readonly value: string) {}

  static parse(input: string): AccountId {
    const value = input.trim()

    if (value.length === 0) {
      throw new Error("Account id is required")
    }

    return new AccountId(value)
  }
}

function loadAccount(id: AccountId): string {
  return `loading ${id.value}`
}
```

`loadAccount` does not need to check for an empty string. The input type says that validation has already happened.

## 9. Use type guards for reusable refinements

A type guard can package a runtime check.

```ts
interface PostedPayment {
  readonly kind: "posted"
  readonly postedAtMs: number
}

function isPostedPayment(
  value: unknown
): value is PostedPayment {
  if (
    typeof value !== "object" ||
    value === null
  ) {
    return false
  }

  const record = value as Record<string, unknown>

  return (
    record.kind === "posted" &&
    typeof record.postedAtMs === "number" &&
    Number.isSafeInteger(record.postedAtMs)
  )
}
```

TypeScript trusts the predicate declared by a user-defined type guard. A wrong predicate creates false confidence.

Keep guards small. Test them with invalid values as well as valid values.

## 10. Preserve an established exception strategy honestly

The strict functional model represents expected failure as data.

```ts
interface ValidAmount {
  readonly kind: "valid"
  readonly amountCents: number
}

interface InvalidAmount {
  readonly kind: "invalid"
  readonly reason: string
}

type AmountResult =
  | ValidAmount
  | InvalidAmount

function parseAmount(input: unknown): AmountResult {
  if (
    typeof input !== "number" ||
    !Number.isSafeInteger(input)
  ) {
    return {
      kind: "invalid",
      reason: "Expected integer cents"
    }
  }

  return {
    kind: "valid",
    amountCents: input
  }
}
```

A repository may use exceptions instead.

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
```

Do not rewrite a whole codebase to introduce returned errors unless the user asks for it.

Also do not call the throwing version strictly pure. Throwing changes control flow outside the returned value.

## 11. Separate a transition decision from persistence

A status change often mixes a domain rule with a database update.

Name the transition first.

```ts
interface PendingTransfer {
  readonly kind: "pending"
  readonly transferId: string
}

interface CompletedTransfer {
  readonly kind: "completed"
  readonly transferId: string
  readonly completedAtMs: number
}

function completeTransfer(
  transfer: PendingTransfer,
  completedAtMs: number
): CompletedTransfer {
  return {
    kind: "completed",
    transferId: transfer.transferId,
    completedAtMs
  }
}
```

The shell loads a pending transfer and saves the completed value.

The pure transition is directly testable. The shell test only needs to verify coordination.

## 12. Boundary review

For every external boundary ask:

- Does the value begin as `unknown`?
- Which runtime checks establish the trusted type?
- Can invalid combinations be removed from the domain model?
- Is the set of alternatives closed or open?
- Does every closed case receive handling?
- Does validation return a stronger type?
- Does a state transition return the next state?
- Are exceptions part of repository policy or part of the domain model?

A good boundary makes the inside of the program simpler. The rest of the code should not keep wondering whether the data was valid.
