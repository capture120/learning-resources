# Chapter 8: Pull Complexity Downwards

## Central idea

When you discover a piece of unavoidable complexity while building a module, and that complexity is related to the functionality the module provides, it is usually right to handle it inside the module rather than expose it to the module's users. Most modules have more users than developers, so it is better for the developer to suffer than the users. The corollary, stated in bold by Ousterhout: **it is more important for a module to have a simple interface than a simple implementation.**

## Key concepts

- **Pulling complexity downward**: absorbing unavoidable complexity into a module's implementation so callers never see it. This is another way of thinking about how to create deeper classes (Chapter 4's deep modules).
- **Pushing complexity upward (the anti-pattern)**: solving the easy problems yourself and punting the hard ones to callers. Two common forms:
  - Throwing an exception whenever a condition arises that you're not sure how to handle, forcing every caller to deal with it.
  - Exporting configuration parameters when you're unsure what policy to implement, forcing every system administrator at every installation to figure out the right values.
- **Why pushing up is worse — complexity amplification**: short-term shortcuts that move a problem upward make *many* people deal with it instead of *one*. One exception in a class burdens every caller; one exported parameter burdens every admin of every installation. Handling it once, internally, reduces total system complexity even if the implementation gets harder.
- **Complete solutions**: ideally each module solves its problem completely. Configuration parameters represent an incomplete solution — the module did part of the job and left the rest to someone else — which adds to system complexity.

## Actionable principles

- Given unavoidable complexity related to a module's functionality, handle it inside the module rather than in the interface, because internal complexity costs one developer while interface complexity costs every user.
- Strive to make life as easy as possible for your module's users, even at the cost of extra work for yourself. Trade a simple implementation for a simple interface, not the reverse.
- Resist the temptation to throw an exception just because you're not certain how to handle a condition. That is punting the hard problem to every caller. (Chapter 10 expands on this.)
- Avoid configuration parameters as much as possible. Before exporting one, ask: "Will users (or higher-level modules) be able to determine a better value than we can determine here?" Export the parameter only if the answer is genuinely yes — for example, when users know domain facts (like which requests are time-critical) that low-level infrastructure code cannot know.
- Prefer computing values automatically over exposing knobs. With a little extra implementation work, the right value can often be derived at runtime (e.g., a transport protocol measuring response times to derive its retry interval). Computed values also adapt automatically when operating conditions change, whereas static configuration parameters easily become out of date.
- When you must create a configuration parameter, provide a reasonable default so users only need to supply a value under exceptional conditions.

## Nuances and counterpoints

- **The case for configuration parameters is real but narrow.** Advocates argue parameters let users tune for their requirements and workloads, and sometimes low-level code genuinely cannot know the best policy while users know their domain (e.g., flagging certain requests as higher priority). In those situations parameters can yield better performance across a broader variety of domains. But in many cases users and administrators cannot determine the right values either, or the values could have been computed automatically — then the parameter is just an excuse to avoid an important issue and pass it to someone else.
- **Taking it too far.** Use discretion: pulling complexity downward can easily be overdone. The extreme — pulling all of an application's functionality into a single class — is obviously wrong. Pulling complexity down makes the most sense when all three hold:
  1. The complexity is closely related to the class's existing functionality.
  2. Pulling it down produces simplifications elsewhere in the application.
  3. Pulling it down simplifies the class's interface.
- If those conditions fail, "pulling down" becomes information leakage instead: e.g., adding a backspace-key method to a text class pulls UI knowledge into a class whose core function has nothing to do with the user interface, and barely simplifies the higher-level code.
- **The real goal is global, not local.** Pull complexity down to minimize *overall system* complexity, not to make any one layer look clean. Use this principle in service of that goal, not as a ritual.

## Red flags

The chapter has no boxed red flag, but it teaches these warning signs:

- A module throws exceptions for conditions it could have handled itself, exporting hard cases to every caller.
- A module exports configuration parameters because the developer didn't want to decide a policy, not because users genuinely know better.
- Configuration parameters without sensible defaults, forcing every user to supply values.
- Static configuration values standing in for quantities the system could measure and compute dynamically (these go stale as conditions change).
- A module's interface mirrors its internal representation (e.g., line-oriented text API from a line-based store) — simple implementation purchased with a complex interface.
- "Pulling down" complexity that is unrelated to the module's core function and doesn't simplify its interface — that is information leakage, not encapsulation.
