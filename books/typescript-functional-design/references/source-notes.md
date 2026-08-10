# Source Notes

The skill draws its programming model from two books.

## Functional programming

*Functional Programming with Scala. Second Edition* supplies the functional principles.

The most important chapters for this skill are:

- Chapter 1 for pure functions and side effects and referential transparency and the coffee purchase example
- Chapter 2 for higher-order functions and polymorphic functions and following types to implementations
- Chapter 3 for immutable data and algebraic data types and pattern matching and structural sharing
- Chapter 4 for representing expected failure as data
- Chapter 5 for separating a program description from its evaluation
- Chapter 6 for explicit state transitions
- Chapters 7 and 9 for designing data types and operations before choosing a representation
- Chapters 8 through 12 for laws and reusable composition patterns
- Chapters 13 and 14 for effect boundaries and capabilities and local mutation

The book uses Scala as a vehicle. The skill keeps the principles and rewrites the examples in TypeScript.

### Coffee example fidelity

When translating the chapter 1 coffee example preserve its design progression.

- Keep `Cafe` and `CreditCard` and `Coffee` as classes.
- Begin with `CreditCard.charge` as the hidden side effect inside `Cafe.buyCoffee`.
- Show the intermediate `Payments` dependency-injection version and state that the method remains effectful.
- Make the functional change by returning a pair of `Coffee` and `Charge`.
- Represent `Charge` as an immutable value with `combine` returning a new value.
- Show that `buyCoffees` reuses `buyCoffee` and combines charges before payment processing.
- Do not replace `Cafe.buyCoffee` with a standalone function unless the change is clearly marked as a separate adaptation.

## TypeScript

*Programming TypeScript* supplies the TypeScript forms used by the examples.

The most important sections for this skill are:

- The preface and Chapter 2 for strict checking and type inference
- Chapter 3 for types as sets of values and literal types and unions and readonly data and `unknown`
- Chapter 4 for functions as first-class values and call signatures and contextual typing and polymorphism and type-driven development
- Chapter 5 for classes and interfaces and structural typing
- Chapter 6 for refinement and totality and discriminated unions and type operators
- The error-handling chapter for the limits of exception typing
- The asynchronous programming chapter for promises and `async` functions

The TypeScript book guides syntax and type-system usage. It does not define the functional model.

## Translation choices

Several TypeScript tools express ideas that the functional programming book presents in another language.

- A discriminated union represents a closed algebraic data type.
- A `switch` over the tag replaces pattern matching.
- `readonly` and readonly arrays express immutable public contracts.
- Generic parameters express relationships between positions in a signature.
- `unknown` marks a runtime value that has not been validated.
- `Record` can require complete handling of a closed key set.
- `Pick` can project the facts a function needs from a larger type.

These tools are not functional programming principles by themselves. Their value depends on the design they express.

## Limits

TypeScript cannot prove that a function is pure.

TypeScript cannot guarantee deep runtime immutability.

TypeScript types disappear at runtime and therefore cannot validate JSON or network input.

A type signature does not define every domain law.

The skill uses runtime validation and tests and code review where the type system stops.
