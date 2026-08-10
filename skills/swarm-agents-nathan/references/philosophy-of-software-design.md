- Philosophy Software Design
    
    ```markdown
    Current task statement
    
    PROBLEM
    
    [Insert the exact software engineering or coding task here.]
    
    —-
    Assume for purposes of this task that a complete correct implementation exists. A complete
    solution must implement exactly the behavior above while minimizing the complexity future
    developers experience when understanding and modifying the system.
    
    Partial progress does not count unless it implies exactly the resolution above. A patch that
    passes the immediate tests but increases change amplification, cognitive load, or unknown
    unknowns; leaks design decisions; duplicates knowledge; overexposes rarely used features; or
    shifts avoidable complexity onto callers is insufficient.
    
    Use multiagent v2 aggressively and dynamically. Do not use a fixed assignment such as
    “N agents for implementation and N agents for review.” Instead, manage the search using
    the following heuristics:
    
    - Begin with a genuinely diverse portfolio of designs. Agents should explore substantially
    different module boundaries, abstractions, information-hiding strategies, data
    representations, somewhat general-purpose interfaces, error semantics, decompositions,
    layering choices, and ways to eliminate or encapsulate complexity.
    
    - Do not tell most agents the currently favored design. Preserve independence during early
    rounds so that agents do not all converge to the first workable but tactical patch.
    
    - Maintain an explicit registry of design families. Group agents by the knowledge each
    design encapsulates, its module boundaries, and its distribution of complexity, not by
    superficial differences in code. If many agents converge to one family, redirect some of
    them toward underexplored abstractions or representations.
    
    - Do not allow one approach to dominate merely because it produces the smallest diff,
    fewest lines, or most classes. A locally simple change that creates nonobvious dependencies,
    complicates common operations, or makes future changes touch more places is not close to
    completion.
    
    - Prefer deep modules that provide substantial functionality through simple interfaces.
    Make the common case simple and hide rarely needed features where possible. Organize
    modules around the knowledge they encapsulate, not merely the order in which operations
    occur. Do not split code solely to make classes or methods smaller. Avoid shallow modules,
    temporal decomposition, information leakage, pass-through methods and variables,
    duplicated interfaces, repeated special cases, and mixtures of general-purpose and
    special-purpose logic.
    
    - Apply these principles as design heuristics, not mechanical laws. A red flag requires
    investigation, not automatic rejection. Make modules somewhat general-purpose: their
    functionality should address current needs, while their interfaces should avoid unnecessary
    dependence on a single use case. Do not generalize speculatively, and do not hide information
    that callers genuinely need.
    
    - Pull complexity downward only when the complexity is closely related to the module’s
    responsibility, doing so simplifies other parts of the system, and the resulting interface
    becomes simpler. Otherwise, keep specialization at the layer where it naturally belongs.
    Bring code together when it shares important knowledge, simplifies an interface, or removes
    duplication; separate it when the pieces are genuinely independent.
    
    - When an approach requires callers to coordinate hidden state, remember invocation order,
    repeat policy decisions, interpret avoidable configuration, or handle the same low-level
    failure in many places, mark that route as blocked. Only continue assigning agents to it if
    someone proposes a materially deeper abstraction or eliminates the exposed complexity.
    
    - Keep several incompatible designs alive through multiple rounds. For each important
    module or design decision, develop at least two substantially different alternatives before
    committing. Compare them in terms of interface complexity, module depth, information
    hiding, common-case usage, dependencies, error surface, performance, and ease of future
    modification.
    
    - Use adversarial agents throughout: every candidate design must be checked for change
    amplification, excessive cognitive load, unknown unknowns, shallow modules, information
    leakage, overexposure, pass-through methods, repetition, conjoined methods, vague names,
    nonobvious behavior, false abstractions, scattered error handling, and comments that repeat
    the code or expose irrelevant implementation details.
    
    - Require agents to return concrete interfaces, module boundaries, hidden design decisions,
    call-site examples, invariants, dependency changes, failure behavior, tests, or
    counterexamples. Reject status reports, vague claims of simplicity, and assertions that
    exposed coordination or configuration is “easy.”
    
    - The root agent should repeatedly synthesize, challenge, redirect, redesign, implement,
    and launch new rounds. Do not stop after the first working patch. Prefer strategic
    improvements that leave the system easier to understand and modify over tactical changes
    that merely complete the immediate feature.
    
    Do not return merely because the implementation passes narrow tests. Continue launching
    new rounds when the change still requires readers to understand irrelevant details, leaves
    important knowledge duplicated, introduces nonobvious dependencies, or makes a simple
    future modification require changes in many places.
    
    Return only when a complete correct implementation has been produced and survives both
    behavioral and design audit. Do not return a plan, partial patch, isolated refactor,
    unverified abstraction, “best effort” summary, or explanation of why the existing design
    is difficult.
    
    Before returning, run the applicable tests, type checks, linters, builds, and other repository
    verification. Inspect the final design from the perspective of future readers and callers:
    the common case should be obvious, dependencies should be simple and discoverable,
    important information should be emphasized, and incidental details should be hidden or
    de-emphasized.
    
    For nontrivial new or changed abstractions, write or revise the interface documentation
    before finalizing the implementation. Use difficulty describing an abstraction simply as
    evidence that the design may need improvement. Comments should describe nonobvious
    behavior, invariants, units, preconditions, side effects, errors, and design rationale without
    repeating the code or contaminating the interface with unnecessary implementation details.
    Names should be precise and consistent, and the code should be optimized for ease of
    reading rather than ease of writing.
    
    Define errors out of existence where a cleaner API can make the condition normal. Where
    errors remain unavoidable, consider masking low-level conditions inside the responsible
    module or aggregating handling at an appropriate layer rather than scattering similar
    handlers throughout the system.
    
    For performance-sensitive work, measure before and after modifying the implementation.
    Design around the critical path and keep noncritical paths simple; do not introduce
    complexity for speculative or unmeasured performance gains.
    
    Public search may be used only for ordinary technical background, official documentation,
    language or framework semantics, specifications, and standard APIs, not to search for a
    solution to this exact task or benchmark. Do not copy a public solution to the exact
    problem.
    ```