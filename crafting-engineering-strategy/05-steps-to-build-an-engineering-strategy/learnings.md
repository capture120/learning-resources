# Chapter 5: Steps to Build an Engineering Strategy

This chapter introduces Larson's repeatable five-step structure for drafting engineering strategy — Explore, Diagnose, Refine, Set Policy, Operate — and explains how the steps feed into one another. The single most important takeaway: strategies fail more often from avoidable errors (busy people skipping steps they dislike or have failed at before) than from fundamentally unsound thinking, so the value of the structure is that it prevents skipping, not that it guarantees brilliance. The structure itself is not sacrosanct; the thinking behind each section is what matters.

## Core ideas

### Why most "strategies" feel like no strategy

A disorganized collection of ideas often gets labeled a "strategy." Even when dense with ideas, such documents are hard to parse. This is a major reason engineers claim their company has no clear strategy — even though (per Chapter 1) every company follows some strategy, documented or not. The chapter responds with a repeatable, structured approach to drafting strategy.

### The five steps

Each step is an input that flows into the next: exploration is the foundation of a solid diagnosis; the diagnosis lets you search "the infinite space of policy" for what you currently need; operational mechanisms turn policy into "an active force supporting your strategy, rather than an abstract treatise."

#### Step 1: Exploring

Exploration is "the deliberate practice of searching through a strategy's problem and solution spaces before allowing yourself to commit to a given approach." It means studying the wider industry's ideas and practices: how other companies and teams have approached similar questions, whether their approaches would work for you, what recent research might change your approach, and how the state of the art has changed since you last tackled a similar problem. Critically, it includes learning why what brought you success at a former employer isn't necessarily the best solution for your current organization. (Detailed in Chapter 6; Wardley mapping deep dive in Chapter 15.)

#### Step 2: Diagnosing

Diagnosis is "your attempt to correctly recognize the context that the strategy needs to solve before deciding on the policies to address that context." It builds on what exploration taught you plus your understanding of current circumstances. Why it's a separate step: it forces you to delay thinking about solutions until you fully understand the problem's nuances. It's hard to slow down and understand a problem before solving it, but even harder to solve anything well without a clear diagnosis. A diagnosis can be largely data-driven (e.g., decomposing headcount cost growth into its causes) or a qualitative summary of known and unknown elements of a problem. (Detailed in Chapter 7.)

#### Step 3: Refining

Refinement is "taking a raw, unproven set of ideas and testing them against reality" — a toolkit to identify which parts of your diagnosis are most important and to verify that your approach to solving the diagnosis actually works. Three techniques support this validation: strategy testing (Chapter 13), systems modeling (Chapter 14), and Wardley mapping (Chapter 15). (Overview in Chapter 8.)

#### Step 4: Setting policy

Setting policy is "interpreting your diagnosis into a concrete plan that works." Policy makes the tradeoffs and decisions that solve your diagnosis — ranging from how software is architected, to how pull requests are reviewed, to how headcount is allocated. It requires careful study of what has worked within your company plus the new ideas discovered while exploring. Policies can take varied forms: directional guidance (principles that shape future decisions) or an explicit decision to defer a contentious choice until later. (Detailed in Chapter 9, including evaluating policies, handling ambiguity, and developing novel policies.)

#### Step 5: Operations

Operations are "the concrete mechanisms that translate policy into an active force within your organization." Why they're necessary: even the best policies have to be interpreted — new circumstances will arise that the authors never imagined, and policies may remain in effect long after their authors have left the organization. Examples: nudges reminding you about code changes without associated tests, or weekly meetings studying progress on a migration. The simplest mechanism is an explicit escalation path for exceptions; from that starting point, mechanisms can get far more complex. (Detailed in Chapter 10, covering evaluating mechanisms, composing an operational plan, and the most common mechanisms across strategies.)

### Why refinement sits in the middle (sequencing rationale)

Common objections: refinement should come before diagnosis; mapping and modeling should be split into separate steps (mapping before diagnosis, modeling after policy); refinement should be the final step, making the process a loop. Larson's rationale for placing it third: the biggest risk for most strategies is not modeling too early or mapping too late, but skipping both entirely. His foremost concern is minimizing the required investment in mapping and modeling so more people do them at all. Refining after exploring and diagnosing lets you concentrate effort on a smaller number of load-bearing areas. In practice, refinement happens at many points — three small refinement passes are as likely as one big one.

### The structure is not sacrosanct

Templates are useful: they reduce the ambiguity of a broad project into something tractable. But well-meaning templates often degrade into "lumbering, callous documents that serve no one well" as organizations layer in more and more requirements (security, compliance, costs) until writing becomes prohibitively painful. The secret to a good template: someone must own it, and that owner must care about the template's user first, ahead of the constituencies wanting to insert requirements. The governing rule: "discard every element of strategy that gets in your way as long as you can explain what that element was intended to accomplish." The structure isn't sacrosanct; the thinking behind the sections is what matters. (Explored further in Chapter 11.)

### Steps as habit and community practice

Following the steps doesn't guarantee great strategy — you can't create effective strategy "through the rote incantation of a formula." But practicing them routinely builds habits and intuition about which approach fits the strategy at hand, and turns strategy into a community practice that you, your colleagues, and the wider engineering ecosystem can participate in together.

## Actionable guidance

- Follow the five steps in order: Explore → Diagnose → Refine → Set policy → Operate. Treat each step's output as the input to the next.
- Before committing to any approach, deliberately search the problem and solution spaces: read industry literature, study how other companies solved similar problems, and check how the state of the art has changed since you last faced this class of problem.
- Don't import your previous employer's solution by default; explicitly test whether it fits your current organization's context.
- Write the diagnosis before proposing any solution. Force yourself to delay solution thinking until the problem's nuances are fully understood.
- A diagnosis can be largely data-driven (quantifying and decomposing the drivers of the problem) or less data-driven, aiming instead to summarize the problem's known and unknown elements.
- Refine before committing: validate raw ideas against reality using strategy testing, systems modeling, or Wardley mapping. Keep the refinement investment small enough that you actually do it — several small refinement passes are fine.
- Use exploration plus diagnosis to focus refinement on the few load-bearing areas, rather than mapping and modeling everything.
- When setting policy, draw from two sources: what has demonstrably worked inside your company, and new ideas surfaced during exploration.
- Deliberately deferring a contentious decision is a legitimate policy — state explicitly that you're deferring, why, and when you'll revisit it.
- Pair policies with operational mechanisms (escalation paths, nudges, recurring review meetings) so the policy survives interpretation, novel circumstances, and author turnover.
- For restrictive policies, define a written exception path (e.g., exceptions granted by a named role, in writing) so exceptions are deliberate rather than scattered.
- Use a template if it helps reduce ambiguity, but assign it an owner who prioritizes the template's user over stakeholder requirements.
- Discard any section of the structure that doesn't fit your strategy — provided you can articulate what that section was intended to accomplish. (E.g., if no operational mechanisms fit, drop that section.)
- If you're skeptical of the steps, keep your skepticism but try them a few times before discarding them. (Chapter 12 covers bridging between theory and practice in strategy work.)
- To go deeper after this overview, either dive into the strategy case studies (Part IV) or stay at high altitude with the exploration chapter (Chapter 6) — Larson recommends eventually working through both for the full perspective.

## Pitfalls and misconceptions

- **Skipping steps you dislike.** Strategies fail more often from avoidable errors than unsound thinking; busy people skip the steps that feel awkward or that they've failed at before. The steps exist precisely to prevent this.
- **Treating the steps as a formula.** Rote execution doesn't produce good strategy; the steps build habits and focus thinking, they don't replace it.
- **Skipping refinement entirely.** The biggest risk isn't refining at the wrong point in the sequence — it's never mapping or modeling at all.
- **Template bloat.** Letting every constituency add required sections until the document is prohibitively painful to write, serving the process instead of the strategy's author and readers.
- **Policies without operations.** A policy with no operational mechanism becomes an abstract treatise rather than an active force — it won't survive unforeseen circumstances or its authors leaving.
- **Mislabeling idea collections as strategy.** A dense but disorganized pile of ideas isn't a usable strategy and fuels the perception that no strategy exists.
