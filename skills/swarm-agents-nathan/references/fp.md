- FP
    
    ```markdown
    Current task statement
    
    PROBLEM
    
    [Insert the exact software engineering or coding task here.]
    
    —-
    Assume for purposes of this task that a complete correct implementation exists. A complete
    solution must implement exactly the behavior above while keeping the program’s core logic
    pure, composable, and locally understandable, with unavoidable effects isolated at explicit
    boundaries.
    
    Partial progress does not count unless it implies exactly the resolution above. A patch that
    passes the immediate tests but depends on hidden mutation, ambient state, undocumented
    exceptions, sentinel values, order-sensitive side effects, or duplicated logic is insufficient.
    
    Use multiagent v2 aggressively and dynamically. Do not use a fixed assignment such as
    “N agents for implementation and N agents for testing.” Instead, manage the search using
    the following heuristics:
    
    - Begin with a genuinely diverse portfolio of approaches. Agents should explore
    substantially different pure-core and effect-boundary decompositions, immutable data
    models, explicit error representations, state transitions, higher-order functions, generic
    transformations, evaluation strategies, and ways to separate computation from execution.
    
    - Do not tell most agents the currently favored design. Preserve independence during early
    rounds so that agents do not all converge to the first concise but effectful implementation.
    
    - Maintain an explicit registry of approach families. Group agents by the underlying
    functional mechanism they are using, not by superficial differences in code. If many agents
    converge to one family, redirect some of them toward underexplored data models, error
    models, state representations, or effect boundaries.
    
    - Do not allow one approach to dominate merely because it produces an elegant one-liner
    or uses familiar functional vocabulary. A route that merely hides observable mutation,
    failure, or environmental dependencies inside a closure, object, helper, or callback is not
    close to completion.
    
    - Prefer functions whose results depend only on their explicit inputs. Treat shared domain
    data as immutable, construct new values instead of modifying caller-owned values, and keep
    I/O, persistence, clocks, randomness, logging, and network access at the outer edges of the
    program.
    
    - When an approach requires callers to coordinate hidden state, remember execution order,
    catch undocumented exceptions, interpret magic return values, or repeat the same state and
    error-handling logic, mark that route as blocked. Only continue assigning agents to it if
    someone proposes a materially more explicit and composable mechanism.
    
    - Keep several incompatible designs alive through multiple rounds. Cross-pollinate ideas
    only after independent agents have developed them far enough to expose their actual
    behavior, type signatures, effect boundaries, and failure modes.
    
    - Use adversarial agents throughout: every candidate implementation must be checked for
    violations of referential transparency, leaked mutation, aliasing bugs, hidden inputs,
    unrepresented failure, incorrect state threading, order dependence, repeated evaluation,
    unnecessary traversals, and abstractions that obscure rather than clarify the computation.
    
    - Require agents to return concrete function signatures, input-output examples, immutable
    data representations, tagged error cases, state-transition rules, execution traces, tests, or
    counterexamples. Reject status reports, vague claims of purity, and assertions that a hidden
    side effect is “harmless” without demonstrating that it cannot affect observable behavior.
    
    - The root agent should repeatedly synthesize, challenge, redirect, implement, and launch
    new rounds. Do not stop after the first working patch. Produce a complete implementation
    whose behavior can be understood primarily by following values from explicit inputs to
    explicit outputs.
    
    Do not return merely because the implementation passes narrow tests. Continue launching
    new rounds when behavior still depends on hidden context, mutable shared state, implicit
    control flow, or failures that are absent from the function’s visible contract.
    
    Return only when a complete correct implementation has been produced and survives both
    behavioral and functional-design audit. Do not return a plan, partial patch, isolated
    refactor, unverified abstraction, “best effort” summary, or explanation of why a pure
    implementation is inconvenient.
    
    Before returning, run the applicable tests, type checks, linters, builds, and other repository
    verification. Confirm that pure expressions may be reasoned about locally; unavoidable
    effects occur at clear boundaries; expected failures are represented with explicit result,
    optional, or tagged-union values rather than nulls, sentinels, or undocumented exceptions;
    and state changes are explicit transitions or are safely encapsulated behind an interface
    whose observable behavior remains referentially transparent.
    
    Use the target language naturally. Do not mechanically translate Scala syntax, force
    recursion where it harms clarity or stack safety, or introduce functors, monads, typeclasses,
    effect systems, or other advanced abstractions merely to appear functional. Prefer ordinary
    functions, explicit inputs and outputs, immutable values, higher-order functions, and
    discriminated or tagged data types available in the language.
    
    Public search may be used only for ordinary technical background, official documentation,
    language or framework semantics, specifications, and standard APIs, not to search for a
    solution to this exact task or benchmark. Do not copy a public solution to the exact
    problem.
    ```