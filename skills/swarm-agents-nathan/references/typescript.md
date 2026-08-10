- Typescript
    
    ```markdown
    Current task statement
    
    PROBLEM
    
    [Insert the exact TypeScript software engineering or coding task here.]
    
    —-
    Assume for purposes of this task that a complete correct implementation exists. A complete
    solution must implement exactly the behavior above while using TypeScript’s type system to
    make invalid operations difficult to express and important assumptions visible to callers.
    
    Partial progress does not count unless it implies exactly the resolution above. A patch that
    passes the immediate tests but relies on accidental any, unchecked assertions, incomplete
    union handling, inaccurate declarations, unvalidated external data, or types that do not match
    the runtime behavior is insufficient.
    
    Use multiagent v2 aggressively and dynamically. Do not use a fixed assignment such as
    “N agents for implementation and N agents for type review.” Instead, manage the search using
    the following heuristics:
    
    - Begin with a genuinely diverse portfolio of approaches. Agents should explore substantially
    different root-cause hypotheses, type-first API designs, data models, discriminated unions,
    generic relationships, immutable representations, error models, runtime validation boundaries,
    asynchronous flows, protocol definitions, and minimal implementation strategies.
    
    - Do not tell most agents the currently favored diagnosis, type design, or implementation.
    Preserve independence during early rounds so that agents do not all converge to the first
    compiler-accepted but weakly typed patch.
    
    - Maintain an explicit registry of approach families. Group agents by the underlying runtime
    and type-level mechanism they are using, not by superficial differences in syntax. If many
    agents converge to one family, redirect some of them toward underexplored data models,
    function signatures, error representations, or boundary-validation strategies.
    
    - Do not allow one approach to dominate merely because it produces an elegant conditional
    type, overload, generic abstraction, or small diff. A type-level solution is valuable only when
    it accurately describes runtime behavior. Widening a type, making fields optional, adding a
    catchall overload, or asserting that an unsafe value has the desired type is not close to
    completion merely because the compiler becomes silent.
    
    - Lead with types for important interfaces. Sketch the inputs, outputs, state transitions,
    variants, and expected failures before finalizing the implementation. Let TypeScript infer
    local types when it can do so accurately, but explicitly type public contracts and places where
    an annotation usefully constrains the implementation. Prefer narrow types, literal types, and
    discriminated unions for closed sets of possibilities, and require exhaustive handling of those
    possibilities.
    
    - Treat any as a last resort. Use unknown for values whose types are not yet known, then prove
    their types through refinement, type guards, parsing, or validation before use. Remember that
    TypeScript’s types are erased and cannot validate network responses, stored data, environment
    variables, user input, or messages from another process at runtime. When an approach depends
    on repeated type assertions, nonnull assertions, definite-assignment assertions, ignored
    compiler errors, or an unverifiable declaration file, mark that route as blocked. Only continue
    assigning agents to it if someone proposes a materially safer boundary, representation, or
    validation mechanism.
    
    - Use generics to preserve real relationships between inputs and outputs and to remove genuine
    duplication, not merely to make code appear reusable. Keep generic constraints as specific as
    the implementation requires, and keep overload implementations narrow enough to be checked
    meaningfully. Prefer immutable data most of the time, use readonly types when callers should
    not mutate a value, keep ordinary arrays homogeneous, and use tuples when positions and
    lengths carry distinct meaning.
    
    - Keep several incompatible type and implementation designs alive through multiple rounds.
    Compare them by runtime correctness, strength and honesty of their contracts, quality of
    inference at call sites, handling of invalid states, implementation complexity, compatibility
    with existing callers, and the usefulness of resulting compiler errors.
    
    - Use adversarial agents throughout: every candidate implementation must be checked for null
    and undefined errors, leaked any types, unsafe assertions, type widening, accidental structural
    compatibility, nonexhaustive unions, invalid state combinations, mutation and aliasing bugs,
    variance mistakes, misleading overloads, stale type declarations, runtime data that violates
    its declared type, unhandled promise rejections, unsafe message passing, and mismatches among
    the configured target, libraries, modules, and actual runtime.
    
    - Require agents to return concrete type signatures, inferred types, compiler errors, file paths,
    call chains, runtime schemas, type guards, failing tests, counterexamples, or patches. Reject
    status reports, vague claims of type safety, and assertions that a value is “known” to have a
    type without evidence establishing the invariant.
    
    - The root agent should repeatedly synthesize, challenge, redirect, implement, and launch new
    rounds. Do not stop after the first patch that compiles. Produce a complete implementation only
    when the runtime behavior and type-level contract agree and the result survives adversarial
    audit.
    
    Do not return merely because the visible examples pass or the compiler reports no errors.
    Continue launching new rounds when the implementation still hides expected failures, permits
    invalid states that can reasonably be excluded, exposes unsafe values beyond a narrow boundary,
    or requires callers to use assertions to recover information the API should preserve.
    
    Return only when a complete correct implementation has been produced and survives both
    runtime and type-safety audit. Do not return a plan, reproduction, partial patch, isolated type
    definition, unverified declaration, “best effort” summary, or explanation of why TypeScript
    cannot express the desired behavior.
    
    Before returning, run the applicable tests, strict type checking, linting, builds, and other
    repository verification. Confirm that compiler safety settings were not weakened, no unexpected
    any types were introduced, nullable values are handled, union cases are exhaustive where
    appropriate, external values are validated before being trusted, asynchronous failures are
    handled, and exported types or declaration files accurately describe the emitted JavaScript.
    
    Use TypeScript naturally. Do not add explicit annotations that merely repeat reliable inference,
    and do not introduce classes, inheritance, enums, brands, overloads, conditional types, mapped
    types, Option or Either containers, or other advanced machinery merely to appear typesafe.
    Use the simplest representation that accurately expresses the contract. Choose among nullable
    results, thrown exceptions, returned error unions, and composable error containers according
    to whether callers need failure details, must be forced to handle known failures, or need to
    compose multiple fallible operations.
    
    Public search may be used only for ordinary technical background, official TypeScript or
    library documentation, runtime semantics, specifications, and standard APIs, not to search for
    a solution to this exact task or benchmark. Do not copy a public solution to the exact problem.
    ```