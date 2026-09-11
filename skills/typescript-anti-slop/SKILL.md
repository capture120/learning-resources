---
name: typescript-anti-slop
description: Review or write TypeScript/JavaScript against the anti-slop rules (dmmulroy/anti-slop). Use when reviewing agent-generated TypeScript or JavaScript, when checking a diff or PR for "slop", when writing new TypeScript, or when the user says anti-slop, low-evidence code, unknown leakage, type assertion abuse, or module mocking. Includes Effect-specific rules for repositories that depend on Effect.
---

# anti-slop

Source: [dmmulroy/anti-slop](https://github.com/dmmulroy/anti-slop) (MIT). Every rule description, violation example, and diagnostic message below is quoted from that repository's `README.md`, `src/rules/*.ts`, `src/effect/rules/*.ts`, and `skills/install-anti-slop/SKILL.md`.

Opinionated Oxlint rules that reject low-evidence and low-signal TypeScript and JavaScript patterns.

The upstream author writes: "Anti-slop is first and foremost the ruleset I use with my work, projects, and team. It reflects my preferences and taste rather than attempting to be a universal coding standard."

This skill is that ruleset as a review checklist. Apply it where the linter does not run: while writing code, and while reviewing code another agent wrote. Each rule below carries the upstream description, the diagnostic message the rule emits, the upstream violation example, and the scope the rule's tests establish, where the repository provides them. Report findings in the rule's own words.

This skill omits upstream's `require-readable-spacing` rule on purpose. Whitespace is left to the linter's autofix.

## How to use this skill

### When writing code

Follow every rule by default. When a rule blocks the only reasonable design, write the code and state which rule you broke and why. Do not suppress rules, weaken rule severity, add unsafe casts, or mechanically launder types to make lint pass.

### When reviewing code

1. Read the diff or file set.
2. Read the repository's Oxlint config (`jsPlugins`, `rules`), or the `lint` block of a Vite+ config, and the vendored plugin's `UPSTREAM.md`. Apply only the enabled rules, and apply any recorded intentional deviations over the wording below.
3. Walk each rule below. Search the code for the rejected pattern.
4. Check each hit against the rule's scope before you report it.
5. Report findings with the format below, grouped by tier.
6. If findings appear in owned project source, report them and fix them only when the user asked for migration/cleanup.

The rules use Oxlint's ESTree and lexical-scope APIs rather than a TypeScript type checker. They resolve same-file aliases—including block-scoped aliases, forward references, and transparent generic aliases—but do not infer imported type definitions or cross-file call signatures. You can read imported types and follow call sites. When you flag something the linter would not, say so.

### Report format

```
[TIER] anti-slop/rule-name — path/to/file.ts:LINE
  <the rule's diagnostic message, with placeholders filled in>
```

Generic rules use the plugin name `anti-slop`. Effect rules use `anti-slop-effect`, for example `anti-slop-effect/prefer-effect-match`. The native rule is `oxc/no-accumulating-spread`.

End with a one-line count per tier. If you find nothing, say so.

### Severity tiers

Upstream enables every rule at `"error"`. The tiers below are this skill's triage order, not upstream severity.

- **BLOCK** — discarded or fabricated type evidence, quadratic accumulator copies, and, in Effect repositories, manual `_tag` handling and service-constructor imports. Fix before merge.
  `no-chained-type-assertions`, `no-widen-then-assert`, `no-known-value-widening`, `no-unknown-parameters`, `no-unknown-returns`, `no-unknown-type-aliases`, `no-unsafe-dictionary-type`, `no-object-parameters`, `no-reduce-accumulator-copy`, `oxc/no-accumulating-spread`, `require-safety-comment-for-type-assertion`, all Effect rules.
- **POLICY** — architectural positions. Report them. The team decides.
  `no-runtime-typeof`, `no-module-mocking`, `no-reflect-apply`, `no-reflect-get`, `no-conditional-empty-object-spread`, `no-array-filter-map`.
- **STYLE** — naming. Report in one line at the end.
  `no-shape-in-symbol-names`.

---

## Generic rules

### no-array-filter-map

Rejects adjacent eager array filter/map passes while allowing lazy iterator pipelines.

**Diagnostic:** Avoid consecutive array `filter` and `map` passes. Prefer `.values().filter(...).map(...).toArray()` where iterator helpers are supported, or a single `flatMap`/mutating reducer. Preserve callback ordering, indexes, and filtering semantics.

For `map().filter()` the two method names swap; the order follows the source chain.

**Rejected:**

```ts
const users: User[] = loadUsers();
const emails = users.filter(user => user.active).map(user => user.email);
const found = users.map(lookup).filter(value => value !== undefined);
```

Prefer lazy iterator helpers where the target runtime supports them:

```ts
const emails = users.values()
  .filter(user => user.active)
  .map(user => user.email)
  .toArray();
```

A single `flatMap(user => user.active ? [user.email] : [])` or a reducer that pushes into a fresh local array is also allowed. Iterator helpers avoid intermediate arrays and per-item wrapper arrays, but are not guaranteed to be faster. Check runtime support; TypeScript library declarations do not polyfill them.

This AST/scope rule recognizes array literals, direct array/tuple annotations, immutable local aliases, and supported array-preserving method chains. Unknown receivers (including imported factory results and unannotated parameters), type aliases, and property-based array types are not inferred. Iterator pipelines are not flagged. Both `filter().map()` and `map().filter()` are covered, regardless of predicate. There is no autofix: callback ordering, indexes, `thisArg`, sparse arrays, and truthiness filtering must be reviewed before changing APIs.

**Scope notes:**
- Array annotations include `T[]`, `readonly T[]`, `Array<T>`, `ReadonlyArray<T>`, and tuples, including on parameters. A union annotation such as `User[] | undefined` is not array evidence.
- `.map().map()` and `.filter().filter()` are not filter/map passes. They are outside the rule.
- Unknown receiver types are deliberately not inferred by this AST/scope rule. As a reviewer you may read the receiver's type and flag it anyway; say the linter would not.
- Only a `const` binding is traced through its initializer. `let users = []` is never a known receiver, even when never reassigned. A `let` binding with an array annotation (`let users: User[] = load()`) counts only when never reassigned.
- The supported array-preserving chain methods are `map`, `filter`, `flatMap`, `slice`, `concat`, `toSorted`, `toReversed`, and `toSpliced`. `users.slice().filter(active).map(email)` is rejected when `users` is known.
- Each adjacent filter/map pair reports once. `users.filter(active).map(email).filter(Boolean)` reports twice.

### no-reduce-accumulator-copy

Rejects non-spread accumulator copies inside reducers; complements native `oxc/no-accumulating-spread`.

**Diagnostic:** Do not copy the reducer accumulator on every iteration; growing copies can cause quadratic work. Mutate a fresh, locally owned accumulator and return it, or use an iterator pipeline/flatMap.

**Rejected:**

```ts
items.reduce((acc, item) => Object.assign({}, acc, { [item.id]: item }), {});
items.reduce((acc, item) => acc.concat([item]), []);
items.reduce((acc, item) => {
  const next = acc.slice();
  next.push(item);
  return next;
}, []);
```

Instead, mutate a fresh, locally owned accumulator and return it:

```ts
items.reduce((acc, item) => {
  acc.push(item);
  return acc;
}, []);
```

`Object.assign(acc, item)` is also allowed. Copying individual input items is not copying accumulated state.

The rule covers inline `reduce`/`reduceRight` callbacks, including index parameters, and immutable local accumulator aliases. It detects global `Object.assign` with an object-literal target and the accumulator as a source, global `Array.from(acc)`, and array accumulator calls to `concat`, `slice`, `toSpliced`, `toSorted`, `toReversed`, and `with`. Array copy methods require local array evidence for the initial value so string concatenation and unknown custom collections are not flagged. Like the native rule, reducer method names are syntactic evidence, not proof of the receiver's runtime type. Named callbacks, nested functions, indirect copy helpers, nested accumulator properties, and reassigned aliases are outside its scope. Copying a bounded accumulator is not necessarily quadratic, but these patterns are rejected because growing accumulators can be.

Enable native `oxc/no-accumulating-spread` alongside it for array/object spreads in reducers and supported loops. Neither rule proves that every possible quadratic reduction is absent. No automatic mutation rewrite is provided because accumulator ownership cannot be established syntactically.

**Scope notes:**
- Local array evidence for the initial value means an array literal, an array or tuple annotation, or an immutable local alias of one. `acc.concat(item)` with a string initial value, an unknown collection, or no initial value is not flagged.
- Only a `const` binding is traced through its initializer, so a `let initial = []` alias is never evidence. An annotated binding counts when never reassigned: `const init: Item[] = load()` and `let init: Item[] = load()` both count. A chain such as `seed.slice()` counts only when `seed` is itself known.
- `Object.assign({}, acc, ...)` and `Array.from(acc)` are flagged regardless of the initial value. Only the array copy methods (`concat`, `slice`, `toSpliced`, `toSorted`, `toReversed`, `with`) need array evidence.
- An immutable local alias of the accumulator (`const alias = acc; return alias.concat(item);`) is flagged as the accumulator.
- A copy inside a nested function or arrow within the reducer body is outside its scope. Only the reducer's own body counts.
- A shadowed local `Object` or `Array` is not the global.

### oxc/no-accumulating-spread

Native Oxlint companion rule. Rejects array/object spreads (`[...acc, item]`, `{ ...acc, [key]: value }`) in reducers and supported loops. Same remedy as `no-reduce-accumulator-copy`.

The diagnostic message for this rule lives in Oxlint, not in the anti-slop repository; report it under `oxc/no-accumulating-spread` with a one-line description of the spread.

### no-chained-type-assertions

Rejects nested `as` and angle-bracket assertions that fabricate evidence; chains made only of `as const` remain valid.

**Diagnostic:** This assertion chain discards type evidence. Keep the original precise type, or parse untrusted input at its boundary before narrowing it.

**Rejected:**

```ts
const user = input as object as User;
```

**Scope notes:**
- Parenthesized chains are included.
- A `!` or `satisfies` between two assertions breaks the chain for the linter; `(x as unknown)! as User` passes. Report the chain anyway as a reviewer, and say the linter does not flag it.

### no-conditional-empty-object-spread

Reports object spreads that use a conditional `{}` branch to omit fields. It intentionally has no autofix because omission is not equivalent to assigning `undefined`.

**Diagnostic:** This conditional spread hides property omission behind an empty object. Build the object in separate statements and add the property only when present.

**Rejected:**

```ts
const options = {
  ...(timeout !== undefined ? { timeout } : {}),
};
```

**Scope notes:**
- The `{}` may sit in either branch of the conditional. The other branch may be any expression. `...(skip ? {} : extras)` is rejected.
- `...(cond && { field })` and `...(cond ? { field } : undefined)` are outside the rule.
- Only spreads inside an object literal count. Array spreads (`[...(cond ? [v] : [])]`) and call-argument spreads (`f(...(cond ? [v] : []))`) are outside the rule.
- A cast empty object (`{} as Partial<X>`) is not recognized; the linter allows it. As a reviewer flag it anyway and say the linter would not.
- Only the direct branches of the outer conditional are checked. `...(a ? { v } : b ? { w } : {})` passes the linter because the `{}` sits in a nested conditional.

### no-known-value-widening

Rejects known expressions flowing into explicit `unknown`, `object`, anonymous-object, or open-dictionary targets, including known arguments passed to local `unknown` type predicates. Empty dictionary accumulators and finite-key `Record` targets remain valid.

**Diagnostic:** The explicit open dictionary type on binding `handlers` discards known type evidence. Keep inference, validate with `satisfies`, or use a named owner contract.

**Rejected:**

```ts
const handlers: Record<string, Handler> = {
  start: startHandler,
};
```

This discards the known `start` key. Preserve inference or use `satisfies Record<string, Handler>` instead.

Known values must not be widened back to `unknown` through a local type predicate:

```ts
function isUser(value: unknown): value is User {
  return UserSchema.safeParse(value).success;
}

declare const user: User;
isUser(user);
```

Call the predicate at the unparsed boundary, while the argument is still `unknown`.

**Scope notes:**
- The diagnostic's target word is one of `unknown`, `object`, `anonymous object`, `open dictionary`, or `generic container`. The subject is `binding \`x\``, `property \`x\``, `return value of \`fn\``, `assertion`, or `argument for parameter \`p\` of \`fn\``.
- A known expression is an object, array, function, class, `new`, literal, template, or unary expression, or a `const` that chains to one of those. A call result, a parameter, or a `let` binding is not known, so `const h: Record<string, Handler> = make()` passes the linter.
- Unary expressions count as known: `const value: unknown = -1;`, `const value: unknown = !flag;`, and `const value: unknown = typeof flag;` are rejected.
- For the type-predicate flow, annotated bindings, parameters, and local call results with an informative type also count as known. An argument asserted to an informative type, such as `isUser(x as User)`, also counts. An informative type is any annotation other than `unknown`, `any`, `object`, `{}`, a union containing one of those, or a same-file alias to one; `Record<string, string>` is informative.
- Targets: `unknown`, `object`, a non-empty anonymous object type, and an open dictionary (`Record` over `string`, `number`, `symbol`, or `PropertyKey`, or a key union that contains one of those such as `Record<string | 'start', Command>`; an index signature; an inline mapped type over any key). Same-file aliases resolve to these, through default type parameters and `Readonly`/`Partial`/`Required`/`NonNullable`. `type Open = Record<string, Command>` is still an open dictionary. `any` and `{}` are not targets of this rule.
- A mapped type reached through an alias counts only when its key is wide. `type Levels = { readonly [L in Permission]: number }` with a finite `Permission` key is not a target.
- A generic alias counts only when its body resolves to an open dictionary, and the diagnostic then names the target `generic container`. `type Box<T> = unknown; const x: Box<number> = {};` is not a target.
- Flows: a variable annotation, a class field or accessor initializer, a later `=` assignment to an annotated binding, a `return` or arrow body against a declared return type, an `as` or `<T>` assertion, and the argument of a local `unknown` type predicate or assertion function (`asserts value is T`). Ordinary call arguments are not flows.
- The empty dictionary accumulator exemption (`const acc: Record<string, Item> = {}`) applies to dictionary targets only. `const value: unknown = {}` is rejected.
- The exempt `{}` must be written inline in the flow. `const empty = {}; const acc: Record<string, Command> = empty;` is rejected.
- A named owner contract is an `interface` or an alias to a closed object type, such as `type Handlers = { readonly start: Handler }`. Finite-key targets such as `Record<"a" | "b", Handler>` remain valid.

### no-module-mocking

Rejects Vitest and Jest `mock`, `doMock`, and `unstable_mockModule` calls in favor of real dependency seams.

**Diagnostic:** Replace module mocking with dependency injection through a real interface, service layer, or faithful test implementation.

**Rejected:**

```ts
vi.mock("./user-store");
```

**Scope notes:**
- The receiver is the global `vi` or `jest`, or a named-import specifier `{ vi }` from `vitest` or `{ jest }` from `@jest/globals`, under any import alias. `import { vi as testApi } from "vitest"; testApi.mock("./x")` is rejected. A local re-binding of the import (`const v = vi; v.mock("./x")`) is outside the rule.
- Namespace imports (`import * as vitest from "vitest"; vitest.vi.mock(...)`), default imports, `const { vi } = await import("vitest")`, and `jest` imported from `vitest` are outside the rule.
- Only `mock`, `doMock`, and `unstable_mockModule` count. `vi.fn`, `vi.spyOn`, `vi.stubGlobal`, `vi.importMock`, `jest.requireMock`, and `jest.createMockFromModule` are outside the rule. Do not flag them by analogy.
- `vi["mock"]` with a string literal counts the same as `vi.mock`.
- A locally declared `vi` or `jest`, or one imported from another module, is outside the rule.

### no-object-parameters

Rejects `object`, unions containing it, and scoped or transparent generic aliases that resolve to it on function inputs.

**Diagnostic:** Parameter `value` uses the broad `object` type. Accept a named owner type; parse external input at its boundary before calling this function.

**Rejected:**

```ts
function save(value: object) {}
```

**Scope notes:**
- Function inputs include function declarations, function expressions, arrows, class methods and constructors, overload signatures, function type aliases, interface and type-literal method signatures, call and construct signatures, constructor types, `declare function`, and constructor parameter properties.
- Generic constraints such as `<Value extends object>` are allowed.
- Only the `object` keyword counts. `{}`, `Object`, `object[]`, `object & Owner`, and `object` nested inside a generic such as `Readonly<object>` are outside the rule. `object | null` is reported.

### no-reflect-apply

Rejects global `Reflect.apply` in favor of typed function calls.

**Diagnostic:** Replace `Reflect.apply` with a typed function call. Model dynamic dispatch behind a named interface.

**Rejected:**

```ts
const value = Reflect.apply(operation, owner, args);
```

**Scope notes:**
- `Reflect["apply"]` counts. Only the bare identifier `Reflect` is checked: a locally declared `Reflect` is not the global, and `globalThis.Reflect.apply(...)` or a local alias (`const R = Reflect; R.apply(...)`) passes the linter. Flag those anyway and say the linter would not.

### no-reflect-get

Rejects global `Reflect.get` in favor of typed property access or boundary parsing.

**Diagnostic:** Replace `Reflect.get` with typed property access. Parse dynamic input into a named domain type before reading it.

**Rejected:**

```ts
const value = Reflect.get(owner, key);
```

**Scope notes:**
- `Reflect["get"]` counts. Only the bare identifier `Reflect` is checked: a locally declared `Reflect` is not the global, and `globalThis.Reflect.get(...)` or a local alias (`const R = Reflect; R.get(...)`) passes the linter. Flag those anyway and say the linter would not.

### no-runtime-typeof

Requires boundary parsing instead of ad hoc `typeof` narrowing. Existence probes against the string `"undefined"` are allowed, and type predicates can be enabled explicitly.

**Diagnostic:** A `typeof` check narrows a representation without establishing its contract. Parse input at its I/O boundary, then branch on the domain value.

**Rejected:**

```ts
if (typeof input === "string") {
  useName(input);
}
```

Schema-free projects can permit `typeof` checks directly inside type predicate and assertion functions while continuing to reject ad hoc checks elsewhere:

```json
{
  "anti-slop/no-runtime-typeof": [
    "error",
    { "allowInTypeGuards": true }
  ]
}
```

The option defaults to `false`. Existence probes such as `typeof document === "undefined"` are always allowed because they establish whether a binding exists rather than narrow its representation.

**Scope notes:**
- Every runtime `typeof` expression is checked, including `switch (typeof x)`, `const kind = typeof x`, and `log(typeof x)`.
- Type-level `typeof` (`type T = typeof x`, `ReturnType<typeof fn>`) is a type query and is never reported.
- An existence probe is `typeof X` compared with `===`, `!==`, `==`, or `!=` to the string literal `"undefined"`, in either operand order. `X` may be any expression. The comparison must be a plain string literal; a template literal `` `undefined` `` does not count. Comparing to the identifier `undefined` is not an existence probe.
- `allowInTypeGuards` covers only the nearest enclosing type predicate or assertion function. A nested arrow inside the guard is still rejected. Check the repository's lint config before you assume the option is on.

### no-shape-in-symbol-names

Rejects the case-insensitive substring `shape` in locally owned symbol names while allowing static member names such as Zod's `schema.shape` that cannot be renamed locally.

**Diagnostic:** Rename symbol "UserShape" for its domain role; "shape" describes structure rather than ownership.

**Rejected:**

```ts
interface UserShape {
  id: string;
}
```

Static member reads such as `schema.shape` are allowed because the member name belongs to the value's owner and cannot be renamed locally.

**Scope notes:**
- Locally owned symbol names include JavaScript, TypeScript, private, and JSX symbol names: variables, functions, parameters, types, interfaces, class members, `#private` fields, property keys in object and type literals, import specifiers, and destructuring bindings.
- Only a non-computed member access in value position is exempt: `s.shape`, `s?.shape`, `this.shape`, `outer.inner.shape`. `schema["shape"]` passes because a string literal is not a symbol. `owner[shape]` with an identifier is flagged at the declaration of `shape` and at the use.
- Qualified type names (`z.ZodRawShape`), imported names even when aliased (`import { shape as fields }`), JSX attribute names (`<Box shape="round" />`), and JSX member elements (`<Box.Shape />`) are flagged.
- `const { shape } = schema` and `const { shape: fields } = schema` both flag `shape`; the destructuring key is a symbol. Assign via a member read instead: `const fields = schema.shape`.

### no-unknown-parameters

Rejects `unknown` and unions containing it on function inputs except the explicit `cause` convention and the exact subject of a type predicate.

**Diagnostic:** Parameter `input` leaves input unparsed. Accept a named domain type; run the expected schema or parser at the I/O boundary before calling this function.

**Rejected:**

```ts
function handle(input: unknown) {}
```

A type predicate may accept `unknown` for the parameter it narrows; other `unknown` parameters on the same function remain rejected.

**Scope notes:**
- Function inputs include function declarations, function expressions, arrows, class methods and constructors, overload signatures, function type aliases, interface and type-literal method signatures, call and construct signatures, constructor types, `declare function`, and constructor parameter properties.
- The rule reads the annotation literally and does not resolve aliases. `type Input = unknown; function f(value: Input)` is outside this rule; `no-unknown-type-aliases` reports the alias.
- `unknown` inside a structure is outside the rule: `unknown[]`, `Promise<unknown>`, and `...rest: unknown[]`.
- The `cause` exemption matches only the binding name `cause`, in any function. `error: unknown` or `err: unknown` in a wrapping helper is rejected.
- Assertion functions (`asserts value is User`, and bare `asserts value`) count as type predicates for their subject.
- A `this: unknown` parameter is reported as Parameter `this`. A `this is X` predicate does not exempt it.
- For destructured parameters the diagnostic names the pattern text, for example Parameter `{ value }`.

### no-unknown-returns

Rejects explicit function contracts that resolve to `unknown`, `Promise<unknown>`, or `PromiseLike<unknown>`, including scoped and transparent generic aliases.

**Diagnostic:** This function exposes `unknown` to its caller. Parse the value at its boundary and return a named domain type.

**Rejected:**

```ts
function loadUser(): unknown {
  return input;
}
```

**Scope notes:**
- Unions containing `unknown`, and nesting such as `Promise<string | unknown>`, resolve to `unknown`. Every signature kind is covered: function declarations, arrows, function type aliases, interface and type-literal methods, call and construct signatures, constructor types, `declare function`, and overload signatures.
- `unknown` inside a structure is not an `unknown` contract: `(): { cause: unknown }` and `(): unknown[]` are outside the rule. Unresolved type parameters such as `<Value>(): Value` are outside the rule.
- `(): Result<Data, unknown>` is outside the rule when `Result` is imported or wraps its argument in a structure. A local transparent alias such as `type Either<L, R> = L | R` resolves, so `(): Either<Data, unknown>` is reported.

### no-unknown-type-aliases

Rejects scoped and transparent generic aliases whose resolved type is `unknown`.

**Diagnostic:** Type alias `ExternalValue` hides `unknown`. Keep `unknown` explicit at the parsing boundary or on an allowed `cause` field; otherwise use the parsed owner type.

**Rejected:**

```ts
type ExternalValue = unknown;
```

**Scope notes:**
- Unions containing `unknown` resolve to `unknown`. Every alias whose resolved type is `unknown` is reported, so a re-alias of a rejected alias is a second finding: `type UnknownValue = unknown; type Alias = UnknownValue;` reports both.
- A transparent generic such as `type Identity<T> = T` is not itself reported; `type Payload = Identity<unknown>;` reports `Payload`.
- A generic that wraps its argument in a structure is outside the rule: `type Box<T> = { readonly value: T }; type Payload = Box<unknown>;`.
- No alias name is exempt; `type Cause = unknown;` is reported. The diagnostic's `cause` wording refers to the exemptions in `no-unknown-parameters` (a parameter named `cause`) and `no-unknown-returns` (`unknown` nested inside a structure such as `{ cause: unknown }`).

### no-unsafe-dictionary-type

Rejects dictionary value contracts based on `unknown`, `any`, `object`, `{}`, and semantic equivalents. Generic constraints such as `T extends Record<string, unknown>` are allowed.

**Diagnostic:** This dictionary's unknown value type gives callers no concrete value contract. Use an owner/schema-derived value type; parse external payloads before insertion.

**Rejected:**

```ts
type Metadata = Record<string, unknown>;
type OtherMetadata = { [key: string]: object };
```

**Scope notes:**
- The diagnostic placeholder is one of `unknown`, `any`, `object`, `empty-object`, or `union`. An intersection reports `any` when any member is `any`; otherwise an intersection is reported only when every member is unsafe, using the first member's token. `unknown & string` and `unknown & ImportedOwner` are outside the rule.
- Dictionary contracts include `Record` with any key type, index signatures, and mapped types. The key type does not matter; `Record<"a" | "b", unknown>` is rejected.
- Semantic equivalents: `Readonly<unknown>`, `Partial<unknown>`, `Required<unknown>`, `NonNullable<unknown>`; `Pick` or `Omit` of an unsafe dictionary; an empty type literal, or a top-level interface with a single declaration and no `extends` whose members are absent or only optional `never` brands; and `any & Owner`.
- Only the direct value type is checked. `Record<string, { payload: unknown }>` and `Record<string, Result<Data, unknown>>` are outside the rule. `unknown & Owner` or `object & Owner` is a contract when `Owner` has real members, has any `extends` clause, is declared more than once, is imported or undeclared, or is an interface declared inside a function body.
- `type Index<T> = Record<string, T>` is allowed at its declaration; `Index<unknown>` is reported at the instantiation. `Index<Command>` is allowed.
- An unsafe default such as `type Index<T = unknown> = Record<string, T>` is reported at each bare `Index` use inside a type alias, not at the declaration.
- `Map`, `ReadonlyMap`, and `WeakMap` are outside the rule. A local declaration or import named `Record`, `Readonly`, and so on shadows the built-in.
- The alias is reported once at its declaration. Any use of that alias inside another `type` declaration (`type B = Unsafe`, `type W = { data: Unsafe }`) is a second finding; a bare use outside a type declaration (interfaces, variables, parameters, class fields, return types) is not. An applied generic use such as `Index<unknown>` is reported wherever it appears, including parameters and variables.

### no-widen-then-assert

Rejects immutable local flows that widen known evidence to `unknown`, `any`, `object`, or a broad record and later assert it back to a narrower type.

**Diagnostic:** Binding "stored" discards type evidence and later recreates it with an assertion. Keep the precise type from initialization through use; parse boundary input once.

**Rejected:**

```ts
const loaded: User = loadUser();
const stored: unknown = loaded;
const user = stored as User;
```

**Scope notes:**
- Known evidence on the source is one of: a non-broad annotation (not `unknown`, `any`, `object`, or a broad record) on the binding or parameter in the same function; a non-broad `as T`; an object, array, function, class, `new`, literal, or template expression; or an unannotated, never-reassigned `const` in the same function that chains to one of those. An unannotated call result is not evidence. In the example, the `: User` annotation on `loaded` supplies the evidence.
- The rule's only invalid test has no annotation: `const source = { id: 'second' }; const widened: unknown = source; const parsed = widened as { readonly id: string };` flags because `source` chains to an object literal.
- The rule does not resolve aliases. `type Json = unknown; const stored: Json = loaded;` is not a widening target here, unlike in no-known-value-widening.
- Widening through an `as` initializer (`const stored = loaded as unknown;`) counts.
- A broad record is a wide key (`string`, `number`, `symbol`, `PropertyKey`) with an `unknown` or `any` value. `Record<string, Handler>` is not broad for this rule. A key union counts only when every member is wide; `Record<string | 'a', unknown>` is not broad here, the opposite of `no-known-value-widening`.
- The widened binding must be `const`, never reassigned, and the later assertion must be on the bare identifier, not a member such as `stored.value`, within the same function.
- For `unknown` or `any` widening, any non-broad assertion counts as narrower. For `object` or broad-record widening, a named type counts only when its text matches the source annotation or the source `as T` text. Otherwise, for `object` widening the assertion must be an array, tuple, function, constructor, mapped, or non-empty object literal type, or an intersection of those. For broad-record widening it must be an object literal type with a named member, a `Record<K, V>` whose value is not `unknown` or `any`, or `Readonly<>` of one of those.

### require-safety-comment-for-type-assertion

Requires each non-const assertion to have a nearby, non-empty invariant justification. Marker prefixes are configurable and default to `SAFETY`.

**Diagnostic:** This type assertion has no `SAFETY:` justification. State the checked invariant immediately before the assertion or its containing statement.

**Rejected:**

```ts
const userId = value as UserId;
```

Add a specific justification immediately before a necessary assertion:

```ts
// SAFETY: parseUserId validated the identifier before branding it.
const userId = value as UserId;
```

`SAFETY` remains the default marker. Comments immediately above exported declarations are recognized. Repositories with an established convention can configure one or more alternatives; every marker must still be followed by a colon and a non-empty justification:

```json
{
  "anti-slop/require-safety-comment-for-type-assertion": [
    "error",
    { "markers": ["INVARIANT", "SAFETY"] }
  ]
}
```

**Scope notes:**
- The comment may sit directly before the assertion, before any enclosing expression, before the containing statement (variable, expression, return, throw, class field), or before the wrapping `export`. Blank lines or other comments between the marker and the assertion do not disqualify it.
- An assertion inside an `if`, `for`, `while`, or `switch` test has no owner statement. There a marker above any ancestor counts, including one above the enclosing function or above the top-level declaration that contains the function.
- A trailing comment on the same line after the assertion does not count. `const id = value as UserId; // SAFETY: Too late.` is rejected.
- The marker is case-sensitive and may appear mid-comment. `UNSAFETY:` and `safety:` do not match. Whitespace before the colon is allowed. An empty justification counts as missing.
- Non-null `!` and `satisfies` are not assertions for this rule.
- Configured markers replace the default. A repository with `markers: ["INVARIANT"]` rejects a `SAFETY:` comment. Check the repository's lint config first.
- First try to remove the assertion by parsing. The linter accepts any non-empty text after the colon. As a reviewer, still ask for a checked invariant; a comment that restates the cast is not one.

---

## Effect rules

Effect-specific rules live in a separate plugin so projects that do not use Effect do not inherit Effect architecture policy. When writing code, apply them if the repository declares `effect` in a package manifest, or the user explicitly requests Effect rules. When reviewing, apply them only if `anti-slop-effect` is registered in the lint config (step 2 above) or the user asks. Upstream: "Do not enable the Effect plugin merely because Effect appears transitively in a lockfile; require a direct package-manifest dependency or an explicit user request."

These rules are syntactic. They recognize direct `Effect.catch*` and `Match.when`/`Match.not` calls under those exact identifiers and do not resolve import aliases or verify that similarly named objects came from Effect. `prefer-effect-match` compares the source text of the repeatedly tested expression; it does not infer its type or prove exhaustiveness.

### no-manual-tag-comparison

Rejects direct `_tag` comparisons and `_tag` switches in favor of `Match`, `Predicate.isTagged`, or tagged-enum matching.

**Diagnostic (comparison):** Use Match.tag/Match.tags for tagged-value branching, or Predicate.isTagged for a simple reusable predicate.

**Diagnostic (switch):** Use Match.value(value).pipe(Match.tag/Match.tags/Match.tagsExhaustive) or the tagged enum `$match` helper instead of switching on `_tag`.

**Rejected:**

```ts
if (result._tag === "Ready") useReady(result);
```

Use `Predicate.isTagged` for a predicate or `Match` for branching:

```ts
if (Predicate.isTagged("Ready")(result)) useReady(result);
```

**Scope notes:**
- All four operators count: `==`, `===`, `!=`, `!==`. The literal may be on either side. `x["_tag"]` counts the same as `x._tag`.
- The comparison must be against a string literal. `a._tag === b._tag` and `x._tag === READY_TAG` are outside the rule. A destructured bare `_tag` identifier is outside the rule.
- A `_tag` check directly inside an inline `Effect.catch`, `Effect.catchAll`, or `Effect.catchIf` handler belongs to `no-manual-effect-error-tag`. A `_tag` check inside `Effect.catchTag` or any other function is reported by this rule.

### no-manual-effect-error-tag

Rejects manual `_tag` comparisons and switches inside broad `Effect.catch`, `Effect.catchAll`, and `Effect.catchIf` handlers in favor of tagged error handlers.

**Diagnostic (tag):** Use Effect.catchTag or Effect.catchTags instead of manually discriminating a tagged error in a broad Effect catch handler.

**Diagnostic (reason):** Use Effect.catchReason or Effect.catchReasons instead of manually discriminating a tagged `reason` in a broad Effect catch handler.

The `reason` diagnostic applies when the compared or switched member is `x.reason._tag` or its bracket forms. Every other `_tag` member gets the `tag` diagnostic.

**Rejected:**

```ts
program.pipe(
  Effect.catch((error) =>
    error._tag === "NotFound" ? recover : Effect.fail(error)
  )
);
```

Use the selective error operator:

```ts
program.pipe(Effect.catchTag("NotFound", () => recover));
```

For a tagged `error.reason`, use `Effect.catchReason` or `Effect.catchReasons`.

**Scope notes:**
- The handler must be an inline arrow or function expression passed directly to `Effect.catch`, `Effect.catchAll`, or `Effect.catchIf`. A named handler function, or a nested inner arrow or function expression, is reported by `no-manual-tag-comparison` instead. A nested `function` declaration inside the inline handler is still attributed to the broad handler and reported by this rule.
- Any inline function argument counts, including the predicate argument of `Effect.catchIf((e) => e._tag === "X", recover)`.

### no-manual-tagged-construction

Rejects literal `_tag` object construction in favor of Schema, tagged class/error, or `Data.taggedEnum` constructors. `Match.when` and `Match.not` patterns remain allowed.

**Diagnostic:** Use the existing Schema tagged `.make`, tagged class/error constructor, or Data.taggedEnum variant constructor instead of writing a literal `_tag` object.

**Rejected:**

```ts
const result = { _tag: "Ready", value };
```

Use the existing Schema, tagged class/error, or `Data.taggedEnum` constructor instead, such as `Ready.make({ value })`. Object patterns passed directly to `Match.when` and `Match.not` remain allowed.

**Scope notes:**
- Quoted `"_tag":` and computed `["_tag"]:` keys count the same as `_tag:`.
- The `_tag` value must be a string literal. `{ _tag: tag, value }` with a variable is outside the rule. `{ _tag: "Ready" as const }` and a template-literal tag also pass the linter because the value node is an assertion or template. Flag those anyway as a reviewer and say the linter would not.
- There is no test-file exemption. `expect(x).toEqual({ _tag: "Ready" })` is rejected.
- Only the top-level pattern object passed to `Match.when` or `Match.not` is exempt. A nested `{ _tag: "..." }` inside the pattern (`Match.when({ error: { _tag: "X" } }, ...)`), or a pattern passed to `Match.whenOr` or `Match.whenAnd`, is rejected.
- Type-level `_tag` literals (`type Ready = { _tag: "Ready" }`, interface members) are outside the rule. The rule visits object expressions only.

### no-service-constructor-imports

Rejects named `make<CapabilityName>` imports from relative project modules outside `*.test.*` and `*.spec.*` files. Runtime callers should import the owning Layer and yield the contextual service instead. Package and path-alias imports, default imports, and static constructors such as `WorkspaceName.make` are outside the rule.

**Diagnostic:** Do not import Effect service constructor "makeIssueService" into runtime code. Import the owning Layer, yield the contextual service, and allow its requirements to propagate to the composition root.

**Rejected:**

```ts
import { makeIssueService } from "./issue-service.ts";
```

Import the owning Layer and yield `IssueService` instead. Focused `*.test.*` and `*.spec.*` files may import the constructor directly.

**Scope notes:**
- `make<CapabilityName>` means `make` followed directly by a capital letter.
- Renamed imports still count: `import { makeIssueService as create }` is rejected. Namespace imports (`import * as`) and re-exports are outside the rule.
- Type-only imports (`import type { makeIssueService }`, `import { type makeIssueService }`) are reported the same as value imports.
- The test exemption is by filename suffix only: `.test.` or `.spec.` followed directly by a js/ts extension. A `__tests__/` directory or `service.test.helpers.ts` is not exempt.
- The rule covers relative project imports. Report package-alias imports as a current limitation rather than pretending they are enforced.

### prefer-effect-match

Rejects chained literal ternaries over the same value in favor of Effect's `Match` API.

**Diagnostic:** Use Match from Effect instead of a chained literal ternary.

**Rejected:**

```ts
const label = kind === "a" ? "A" : kind === "b" ? "B" : "Other";
```

Use `Match`:

```ts
const label = Match.value(kind).pipe(
  Match.when("a", () => "A"),
  Match.when("b", () => "B"),
  Match.orElse(() => "Other")
);
```

**Scope notes:**
- The outermost test and every `else`-position link must each be an equality (`==`, `===`, `!=`, `!==`) between a literal and the same source text. Literals include strings, numbers, booleans, `null`, and template literals with no `${}`.
- A single ternary is outside the rule. A chain where any link compares a different expression, or is not a literal equality, is outside the rule. A ternary whose direct parent is another ternary is never examined, in any position: `flag ? (kind === "a" ? x : kind === "b" ? y : z) : w` passes. A chain wrapped in any other expression inside a ternary, such as `flag ? foo(kind === "a" ? x : kind === "b" ? y : z) : w`, is still reported.

---

## Rule index

| Rule | Tier | One-line test |
|---|---|---|
| no-unknown-parameters | BLOCK | `unknown` on a function input? Not `cause`, not the predicate subject? |
| no-unknown-returns | BLOCK | Explicit return contract resolves to `unknown`, `Promise<unknown>`, or `PromiseLike<unknown>`? |
| no-unknown-type-aliases | BLOCK | Alias resolves to `unknown`? |
| no-object-parameters | BLOCK | Function input is `object`, a union containing it, or a local alias resolving to it? Not a generic constraint? |
| no-unsafe-dictionary-type | BLOCK | Dictionary value contract is `unknown`/`any`/`object`/`{}`? Not a generic constraint? |
| no-known-value-widening | BLOCK | Known expression into `unknown`, `object`, anonymous object, or open dictionary? Not an empty accumulator, finite-key `Record`, or named owner contract? |
| no-widen-then-assert | BLOCK | `const` widened to `unknown`/`any`/`object`/broad record, then asserted narrower in the same function? |
| no-chained-type-assertions | BLOCK | `as X as Y`? Not all `as const`? |
| require-safety-comment-for-type-assertion | BLOCK | Non-const assertion with no `SAFETY:` justification? |
| no-reduce-accumulator-copy | BLOCK | Reducer body copies `acc`? Array copy methods need local array evidence for the initial value. |
| oxc/no-accumulating-spread | BLOCK | `[...acc]` or `{...acc}` in a reducer or supported loop? |
| no-runtime-typeof | POLICY | Any runtime `typeof` expression? Not an existence probe against the string `"undefined"`? |
| no-reflect-apply | POLICY | Global `Reflect.apply`? |
| no-reflect-get | POLICY | Global `Reflect.get`? |
| no-conditional-empty-object-spread | POLICY | `...(c ? x : {})` or `...(c ? {} : x)`? |
| no-array-filter-map | POLICY | Adjacent `.filter().map()` or `.map().filter()` on a known array? |
| no-module-mocking | POLICY | `mock`, `doMock`, or `unstable_mockModule` on `vi` or `jest`? |
| no-shape-in-symbol-names | STYLE | Locally owned symbol name contains `shape`? Not a static member read? |
| Effect: no-manual-tag-comparison | BLOCK | `_tag` compared to a string literal, or `switch (x._tag)`, outside a broad catch handler? |
| Effect: no-manual-effect-error-tag | BLOCK | `_tag` branching inside `Effect.catch`, `catchAll`, or `catchIf`? |
| Effect: no-manual-tagged-construction | BLOCK | Literal `{ _tag: "..." }`? Not a `Match.when`/`Match.not` pattern? |
| Effect: no-service-constructor-imports | BLOCK | Relative `make<CapabilityName>` import outside `*.test.*`/`*.spec.*`? |
| Effect: prefer-effect-match | BLOCK | Chained literal ternary over the same value? |

Vendored copies are the team's to change; drop or re-tier rules to match the team.
