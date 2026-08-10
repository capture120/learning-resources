- General eng
    
    ```
    Current task statement
    
    PROBLEM
    
    [Insert the exact software engineering or coding task here.]
    
    —-
    Assume for purposes of this task that a complete correct implementation exists. A complete
    solution must implement exactly the behavior above.
    
    Partial progress does not count unless it implies exactly the resolution above. Design
    documents, partial patches, reproductions without fixes, passing only visible examples,
    tests without an implementation, implementations without verification, and changes that
    move or conceal the failure are insufficient.
    
    Use multiagent v2 aggressively and dynamically. Do not use a fixed assignment such as
    “N agents for debugging and N agents for implementation.” Instead, manage the search
    using the following heuristics:
    
    - Begin with a genuinely diverse portfolio of approaches. Agents should explore
    substantially different root-cause hypotheses, control-flow and data-flow analyses,
    minimal patches, architectural corrections, test strategies, API contracts, state
    transitions, concurrency issues, performance implications, security boundaries, and
    computational reproductions.
    
    - Do not tell most agents the currently favored diagnosis or implementation. Preserve
    independence during early rounds so that agents do not all converge to the same attractive
    but incomplete patch.
    
    - Maintain an explicit registry of approach families. Group agents by the underlying
    technical mechanism they are investigating, not by superficial wording. If many agents
    converge to one family, redirect some of them toward underexplored diagnoses or designs.
    
    - Do not allow one approach to dominate merely because it gives an elegant refactor or a
    small diff. A route that replaces the original failure with an unverified assumption,
    new abstraction, or hidden dependency is not close to completion unless it establishes
    that mechanism completely.
    
    - When an approach stalls at a missing contract, unknown runtime behavior, unavailable
    dependency, or unverified global assumption, mark that route as blocked. Only continue
    assigning agents to it if someone proposes materially new evidence, a different mechanism,
    or a way to eliminate the dependency.
    
    - Keep several incompatible diagnoses and implementation routes alive through multiple
    rounds. Cross-pollinate ideas only after independent agents have developed them far enough
    to expose their real strengths and gaps.
    
    - Use adversarial agents throughout: every candidate implementation must be checked for
    incorrect assumptions, regressions, unhandled inputs, race conditions, API incompatibility,
    security failures, performance cliffs, and tests that pass for the wrong reason.
    
    - Require agents to return concrete file paths, call chains, failing tests, traces, patches,
    commands, counterexamples, or invariants. Reject status reports, vague optimism, and claims
    that an unverified integration detail is “routine.”
    
    - The root agent should repeatedly synthesize, challenge, redirect, implement, and launch
    new rounds. Do not stop after the first plausible diagnosis or patch. Produce a complete
    implementation if one survives audit; otherwise continue searching.
    
    Do not return merely because current approaches fail or agents report major blockers.
    Continue launching new rounds, reopening blocked approaches only when there is genuinely
    new evidence or a new mechanism, and searching for fresh formulations of the problem.
    
    Return only when a complete correct implementation has been produced and survives
    adversarial audit. Do not return a plan, reproduction, partial patch, isolated test,
    suggested fix, unverified implementation, “best effort” summary, or explanation of why
    the task is difficult.
    
    Before returning, run the applicable tests, type checks, linters, builds, and other
    repository verification. Do not weaken or remove tests, suppress errors, hard-code the
    provided examples, or claim that a command passed unless it was actually run. Preserve
    unrelated user changes and avoid modifications outside the scope of the task.
    
    Public search may be used only for ordinary technical background, official documentation,
    language or framework semantics, specifications, and standard APIs, not to search for a
    solution to this exact task or benchmark. Do not copy a public solution to the exact
    problem.
    ```