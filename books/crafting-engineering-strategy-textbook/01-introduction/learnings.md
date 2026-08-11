# Chapter 1: Introduction

This chapter frames the entire book: engineering strategy is "making thoughtful decisions about engineering," it is accessible to everyone rather than reserved for executives, and it is happening around you whether or not you engage with it deliberately. The single most important takeaway: strategy skill is not innate — Larson attributes his own improvement largely to learning *structured thinking*, and the book's premise is that this structure is teachable. The chapter also plants the book's core structural framework (Rumelt's diagnosis / guiding policy / coherent actions, adapted for engineering) and its core methodological stance (strategy is iterative, and both intellectual and mechanical).

## Core ideas

### Strategy is accessible, not reserved for executives

Many talented people spend years waiting for a chance to finally "do strategy." Larson's claim: waiting is optional. Strategy is simply "the practice of making thoughtful decisions," and anyone can practice it. Why this matters: even if you'd prefer to avoid strategy, it is still happening all around you.

### Definition of engineering strategy

Engineering strategy = making thoughtful decisions about engineering, where "engineering" means both:

1. The discipline of writing software, and
2. The concerns of the Engineering department/organization within a company.

Larson concedes this scope is enormously broad ("if this seems like a hopelessly broad topic, then we agree on the scope of my definition") but flatly rejects that it is hopeless.

### Structured thinking is the lever, not intrinsic ability

Larson believes his decision making improved significantly over his career, and that this improvement "had very little to do with my intrinsic ability and a lot to do with my learning to engage in structured thinking." Why this matters: it reframes strategy from a talent you either have or lack into a learnable practice, which is the justification for the book existing at all.

### Grounding in direct experience (the anti-abstraction stance)

Many strategy books become "awkwardly abstract." To avoid that trap, the book anchors everything in strategies Larson personally worked on or directly witnessed — more than half name real companies (Stripe, Uber, Calm); the rest are anonymized because they either cover sensitive topics (private equity ownership) or expose internal information better kept private (customer data access). Two consequences for the reader:

- The book deliberately presents strategies positively, because "all strategies age. Even the best eventually turn sour." Strategies are most interesting understood in the context where they were originally conceived; evaluation is treated separately (Chapter 23).
- When studying any strategy (yours or others'), understand it in the context it was originally conceived, not by how it looks after it has aged.

### Rumelt's three pillars, adapted for engineering

After Larson's own direct experience, the second-largest influence on the book is Richard Rumelt's *Good Strategy, Bad Strategy* — a quick read Larson calls a life-changing discovery, and his first framework for thinking about strategy. He paraphrases its three pillars:

**Diagnosis** — "A theory describing the nature of the challenge," identifying the root cause(s) at play. Example: "high work-in-progress is preventing us from finishing any tasks, so we are increasingly behind each sprint."

**Guiding policy** — "A series of general policies which will be applied to grapple with the challenge." Guiding policies are typically implicit or explicit *tradeoffs*. Example: "only hire for the most urgent team; do not spread hires across all teams." Critical test: **if a guiding policy doesn't imply a tradeoff, be suspicious of it.** "Working harder to get it done" isn't really a guiding policy; the relevant guiding policy there might be "work folks hard and expect high attrition."

**Coherent actions** — "A set of specific actions to address the challenge, directed by guiding policy." Larson calls this the most important and most exciting pillar, because it clarifies that **a strategy is only meaningful if it leads to aligned action.**

Why adaptation was needed: if applying Rumelt to engineering were trivial, disciplined engineering strategy would already be common — and, one hopes, obviously flawed strategies would be rarer. The book is a decade's work adapting Rumelt's approach into something that has concretely worked in real engineering organizations.

### Strategy is iterative: strategy refinement

Even Larson's proudest strategy work eventually became obsolete. The lesson, after initial embarrassment: **entropy is natural in strategy work; good strategy embraces change rather than fighting it.** This crystallizes as "strategy refinement" (Chapter 8): ideas are deliberately validated and improved rather than treated as immutable. Anti-pattern named here: organizations expecting their strategies to "manifest perfectly into existence from the very beginning."

### Strategy is both intellectual and mechanical

Many people (notably executive candidates in interviews) frame strategy as a fundamentally intellectual endeavor — directing how work *ought* to work, distinct from being "in the weeds." Larson's correction: **effective strategy is at least as dependent on the mechanical nuances of reality as on intellectual frameworks.** The two failure modes are symmetric:

- Even the best policies fail without attention to whether the team is actually adopting the policy's guidance (intellectual work without mechanical follow-through).
- Very effective operational rollout mechanisms won't help if the policy being rolled out is bad (mechanical work serving a flawed intellectual core; see Chapter 10).

### Strategies fail for mundane reasons

The belief that strategy is complex often gets people in trouble. It's appealing to think strategies fail through intricate decision errors or adversaries' unanticipated moves — perhaps common in grand strategy, but Larson's experience is that engineering strategies fail for very *mundane* reasons. The two most common:

1. **Executives assume their strategy will roll itself out** (no rollout mechanism).
2. **Forgetting to spend time validating the details.**

Both are avoidable "with a bit of structure." This is the book's central justification: even very smart people fail at strategy problems others would call simple, so writing down the "obvious" structure has real value.

### The book is a synthesis, not a creed

The framework doesn't attempt to discredit other approaches; it synthesizes approaches Larson has encountered plus dimensions not addressed in detail elsewhere. Even a reader who disagrees should use it to refine their own framework.

## Actionable guidance

- Don't wait for a title or permission to do strategy. Treat strategy as the practice of making thoughtful decisions, and start practicing it where you are.
- Recognize that strategy is happening around you even when no one calls it strategy. Identify the implicit strategies in your organization rather than assuming none exist.
- Structure every strategy with Rumelt's three pillars: a diagnosis (theory of the challenge identifying root causes), guiding policies (the tradeoffs you'll apply), and coherent actions (specific actions directed by the policies).
- Apply the tradeoff test to every guiding policy: if it doesn't imply giving something up, rewrite it until the real tradeoff is explicit, or discard it. Translate motivational non-policies ("work harder") into their honest tradeoff form ("work folks hard and expect high attrition").
- Judge a strategy meaningful only if it produces aligned action. A document that changes no behavior is not a strategy.
- Plan for refinement from the start: deliberately validate and improve strategy ideas rather than treating the initial document as final and immutable.
- Do both halves of the work: verify the team is actually adopting each policy (mechanical), and verify the policy itself is sound before investing in rollout (intellectual).
- Explicitly own the rollout. Never assume a strategy will roll itself out — in Larson's experience, that is the most common cause of engineering strategy failure.
- Spend dedicated time validating the details of a strategy — the second most common cause of failure is skipping this.
- When studying past strategies (including your own), understand them in the context they were conceived, not by how they aged.

## Pitfalls and misconceptions

- **"Strategy is for executives."** False — it's accessible to everyone, and avoiding it doesn't stop it from happening all around you.
- **"Strategy is a fundamentally intellectual endeavor."** The interview-candidate framing that separates directing work from doing work misses that strategy depends at least as much on how things actually work in practice as on how they ought to work.
- **"Guiding policies without tradeoffs."** A policy that costs nothing is a slogan, not a policy. Be suspicious of any policy that doesn't imply a tradeoff.
- **"Strategies fail through intricate, sophisticated errors."** Engineering strategies fail mundanely: unrolled-out strategies and unvalidated details.
- **"Strategy should manifest perfectly from the beginning."** Expecting perfection up front conflicts with the reality that strategy development is iterative; entropy and obsolescence are natural, not signs of failure.
- **"These ideas are too obvious to write down."** Larson's own lingering doubt, refuted repeatedly by watching some of the smartest people he knows fail at strategy problems others would call simple.
