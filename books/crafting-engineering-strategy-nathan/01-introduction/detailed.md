# Chapter 1: Introduction — Detailed Reference

## Opening (untitled): Strategy Is Accessible to Everyone

Larson opens by recalling the many talented people he has worked alongside who spent years waiting for a chance to finally "do strategy." His stated hope is that the book convinces the reader — and maybe those colleagues — that **waiting is optional**. The core claims of the opening:

- Strategy is not reserved for executives.
- Strategy is "the practice of making thoughtful decisions," and it is accessible to everyone — "including you."
- Even if you would prefer to avoid strategy, it is still happening all around you. (Avoidance does not exempt you from strategy; it is occurring regardless of your participation.)

He then grounds this with autobiographical evidence that strategy appears everywhere, drawn from his career:

- His **first big dose of strategy** came when he was managing the team responsible for **Uber's service migration** (presented later in the book as Document 16-1), while the team "desperately tried to survive an accelerating avalanche of inbound support requests." Strategy arrived in the middle of an operational crisis.
- Since then he has seen strategy everywhere he worked, citing:
  - **Stripe's acquisition of Index** (Document 22-4).
  - **Calm's focus on being a product engineering company** (Document 21-1).
- Some strategy problems he has encountered **again and again at every company he has joined** — the named example is **deciding how to decompose monolithic codebases** (Document 20-1).

### Definition and scope of engineering strategy

The book is focused on **engineering strategy** — defined as "making thoughtful decisions about engineering." "Engineering" carries a deliberately dual definition:

1. The **discipline of writing software**.
2. The **concerns of the Engineering department or organization** within your company.

Larson acknowledges the breadth directly: "If this seems like a hopelessly broad topic, then we agree on the scope of my definition. However, I would never agree that it's hopeless." The scope is broad by design, but tractable.

### Strategy skill is learned, not innate

Larson states that his decision making has significantly improved over the course of his career, and he believes "very strongly" that this improvement:

- had **very little to do with his intrinsic ability**, and
- had **a lot to do with his learning to engage in structured thinking**.

He further believes that the lessons he learned slowly are "eminently teachable in the next few hundred pages." This is the book's foundational premise: structured thinking, not talent, is the lever for better strategy, and that structure can be taught.

## Grounded in My Direct Experience

Strategy is a broad topic, and many strategy books become "awkwardly abstract." To avoid falling into that trap, Larson has anchored this book in:

1. His **personal experiences doing strategy**, and
2. The **strategy work of colleagues that he had the opportunity to witness directly**.

### Named versus anonymized strategies

- As much as possible, the examples are ones Larson worked on **in real companies, mentioned by name**. This is true for **more than half** of the strategies included in the book, which describe strategies he collaborated on during his time at **Stripe, Uber, and Calm**.
- For the **other half** of the strategies, he has abstracted away from naming specific companies, for two reasons:
  - They cover **sensitive topics** — example: how to work with **private equity ownership** (Document 18-1).
  - They would **expose internal information better kept private** — example: how to manage **access to customer data** (Document 19-1).
- In **both** sorts of examples (named and anonymized), Larson has "worked hard to remain honest," even when he had to omit some details, out of respect for the companies and individuals involved.

### Why the book is positive about its strategies

The reader will notice that Larson tries to be **positive about all of these strategies**. His explanation for any apparent excess of positivity:

- **All strategies age.** "Even the best eventually turn sour."
- It is **most interesting to understand strategies in the context they were originally conceived** — not by how they look after time has degraded them.
- Evaluation still matters, but it is treated separately: covered in **Chapter 23**.

## Adapting Rumelt for Engineering

In addition to Larson's own experience, the **second-largest influence on the book** is **Richard Rumelt's *Good Strategy, Bad Strategy***. Larson describes it as a quick read and "a life-changing discovery" for him. Rumelt describes **three pillars of effective strategy**, which Larson paraphrases:

### Diagnosis

- **A theory describing the nature of the challenge.**
- This involves identifying the **root cause(s)** at play.
- Example of a good diagnosis: "high work-in-progress is preventing us from finishing any tasks, so we are increasingly behind each sprint." (It names a root cause and the mechanism by which it produces the problem.)

### Guiding policy

- **A series of general policies which will be applied to grapple with the challenge.**
- Guiding policies are typically **implicit or explicit tradeoffs**.
- Example of a genuine guiding policy: "only hire for the most urgent team; do not spread hires across all teams."
- Decision rule / warning: **if a guiding policy doesn't imply a tradeoff, you should be suspicious of it.**
- Counterexample: "Working harder to get it done" isn't really a guiding policy. The relevant (honest) guiding policy there might be "work folks hard and expect high attrition" — that version makes the tradeoff explicit.

### Coherent actions

- **A set of specific actions to address the challenge, directed by guiding policy.**
- Larson calls this **the most important part**, and the most exciting, because it clarifies that **a strategy is only meaningful if it leads to aligned action**.

### Why adaptation was necessary

- The first time Larson read Rumelt's definition was eye-opening: it answered strategy questions he had carried for a long time, and gave him his **first framework for thinking about strategy**.
- However, despite being grateful to Rumelt, he kept noticing **how little deliberate strategy existed in the engineering organizations he joined**.
- Eventually he recognized the implication: **if applying Rumelt's work to engineering were trivial, we would see a lot more disciplined engineering strategy in practice** — and, one hopes, fewer obviously flawed engineering strategies.
- The book is therefore "the culmination of a decade spent understanding how to adapt Rumelt's approach to something that not only could work, but **concretely has worked** in the organizations that I've joined."

## Iterative, Intellectual, and Mechanical

Beyond being anchored in personal experience and building on Rumelt, the book has two further methodological commitments: it takes an **iterative approach**, and it embraces **both the intellectual and the mechanical aspects** of strategy.

### Iterative: strategy refinement

- Even Larson's **proudest strategy work eventually becomes obsolete**.
- For some time, he was **embarrassed** by this realization.
- Eventually he came to recognize that **entropy is natural in strategy work; good strategy embraces change rather than fighting it**.
- This realization solidified into the concept of **strategy refinement** (Chapter 8): ideas are **deliberately validated and improved** rather than being treated as immutable.

### Intellectual versus mechanical

- Setup observation from executive hiring: anyone who has participated in executive hiring has probably interviewed a candidate who described **strategic thinking as a personal strength**. Those candidates often draw a distinction between **directing how work should be done** and **being in the weeds of doing the work itself**.
- This happens often enough that you start to appreciate that **many people view strategy as a fundamentally intellectual endeavor about how things ought to work**, rather than **a mechanical endeavor that studies how things actually do work in practice**.
- Larson's correction: while strategy does indeed have intellectual elements, **effective strategy is at least as dependent on the mechanical nuances of reality as it is on intellectual frameworks**.
- The two symmetric failure modes:
  1. **Even the best policies will fail without attention to whether the team is actually adopting the policy's guidance** (good intellectual content, no mechanical follow-through).
  2. **Very effective operational mechanisms to roll out a strategy won't help your company if the policy being rolled out is a bad one** (good mechanical execution of a flawed intellectual core; see Chapter 10).
- As obvious as these ideas seem, **many organizations expect their strategies to manifest perfectly into existence from the very beginning**.
- The book's stated purpose here: to discuss **how to bridge the gap** between that pressing expectation of perfection and the reality that **effective strategy development is grounded in iterative work that is both intellectual and mechanical**.

## This Book's Ambition

### The "too obvious" worry and its refutation

- While working on the book, one of Larson's lingering concerns was that its ideas are **perhaps too obvious to write down**.
- Each time he was tempted to set the project aside, he would see a new example, or be reminded of an old experience, where **some of the smartest people he has ever known struggled unsuccessfully with a strategy problem that others would describe as quite simple**. This repeatedly re-justified writing the book.

### Strategies fail for mundane reasons

- **The belief that strategy is complex often gets people in trouble.**
- It is appealing to believe that strategies fail due to **intricate errors in decision making** or **the unanticipated moves of an adversary**. Larson hedges: maybe that is common when it comes to **grand strategy**.
- However, his experience is that **engineering strategies fail for very mundane reasons**:
  1. **Most common:** executives assume their strategy will **roll itself out**.
  2. **Second most common:** forgetting to **spend time validating the details**.
- **Both are avoidable with a bit of structure.**

### Synthesis, not creed

- The book's framework is **not an attempt to discredit all other approaches**.
- Rather, it is a **synthesis of the various approaches Larson has encountered**, along with **a few dimensions he has not seen addressed in much detail elsewhere**.
- Even if the reader does not agree with his framework, Larson hopes it helps them **refine their own framework**. "Either way, our industry will be much better for it."

## Cross-references introduced in this chapter

| Reference | Subject |
|---|---|
| Document 16-1 | Uber's service migration |
| Document 18-1 | Working with private equity ownership (anonymized) |
| Document 19-1 | Managing access to customer data (anonymized) |
| Document 20-1 | Decomposing monolithic codebases (recurring problem at every company) |
| Document 21-1 | Calm's focus on being a product engineering company |
| Document 22-4 | Stripe's acquisition of Index |
| Chapter 8 | Strategy refinement |
| Chapter 10 | Rollout of a bad policy / operational mechanisms |
| Chapter 23 | Evaluating strategies |
| Richard Rumelt, *Good Strategy, Bad Strategy* | Source of the three-pillar framework (diagnosis, guiding policy, coherent actions) |
