# Chapter 11: Writing Readable Engineering Strategies

This chapter explains why the order in which you *write* a strategy (explore, diagnose, refine, set policy, operate) is a poor order for others to *read* it, and how to restructure a finished draft so people can approve and apply it. The single most important takeaway: **use the writing structure for writing, and invert that structure for reading** — lead with policy and operations, because applying the strategy is by far the most common task readers have.

## Core ideas

### The writing order is not the reading order

The five-component sequence — explore, diagnose, refine, set policy, operate — is an effective sequence for *creating* a strategy. But readers who want to quickly apply a strategy don't want to retrace the complete thinking behind each decision. "The order in which you write your strategy isn't necessarily the order in which your audience should read it."

### Three distinct goals of professional writing

Most engineers learned document structure as students, where academic essays present evidence to support a thesis and build an argument forward toward a conclusion. Professional writing differs because it serves one of three goals, each wanting a different structure:

1. **Refining thinking about an approach** ("How do we select databases for new products?") — the academic, argument-building structure can be useful here, because it focuses on the thinking behind the proposal rather than the proposal itself.
2. **Seeking approval from stakeholders or executives** ("What database have we selected?") — the academic structure creates confusion, because it foregrounds the thinking when stakeholders view the specific proposal as the primary thing to review.
3. **Communicating a policy to the organization** ("Databases are allowed for new products.") — readers need to understand the permitted options, with rationale available for those who want to understand or challenge the policy.

The ideal format for the first goal is generally at odds with the other two. This mismatch is a frequent reason strategy documents "struggle to graduate from brainstorming to policy."

### Why thinking-first structure fails (three failure modes)

**Too long, didn't read.** Thinking-oriented structures put the policy at the bottom, but the vast majority of readers just want the policy so they can apply it. Many — perhaps most — give up before reaching the answer and assume the document provides no clear direction. This echoes Steve Krug's *Don't Make Me Think*: readers "don't understand, they muddle through." It is hubris to assume readers will invest significant time deeply understanding your document.

**Approval meeting to nowhere.** There are roughly three kinds of approval meetings: (1) no feedback, document approved; (2) two stakeholder groups with incompatible goals need a senior decision-maker to break the tie — a genuinely useful meeting; (3) the meeting derails early into questions about research, alternatives, and relevance. In the author's experience, the third usually happens not because the strategy is wrong, but because the document failed to present the policy up front. Stakeholders may disagree with many elements of your thinking yet still agree with the policy itself — and digging into rationale is only useful when they actually disagree with the policy.

**Transient alignment.** Splitting into two documents — one with full thinking, one with only policy and operations — works initially but decays. As people leave and new hires arrive, a newcomer will eventually challenge the thinking behind the strategy as obviously wrong (usually because their previous employer did it differently). With the diagnosis and exploration omitted, they can't trace the reasoning, so they leap to simplistic conclusions like "I guess the previous engineers here were just dumb." Keep the reasoning in the document; just put it last.

### The inverted reading structure

Reiterating a principle from Chapter 5: it's always appropriate to change the structure you use to develop or present a strategy, as long as you're making a deliberate, informed decision. The recommended presentation order, mostly inverting the writing order:

1. **Policy** — What does the strategy require or allow?
2. **Operation** — How is the strategy enforced and carried out? How are exceptions granted?
3. **Refine** — What load-bearing details informed the strategy?
4. **Diagnose** — What general trends and observations steered the thinking?
5. **Explore** — What high-level, wide-ranging context fed into the strategy?

The key rule: **prioritize what readers most likely care about — if you know what they care about most, put that first.** Seeking executive approval? Lead with Policy. Rolling out to the organization? Emphasize Operation. Either way, those go right up front. The least motivated readers — the majority, who only want to know how the strategy affects them — must get their answer before they stop reading. Someone who genuinely wants the full thinking will read through regardless; someone who just wants an answer will frequently give up and *make up* an answer instead.

The underlying failure is a classic lack of user empathy: authors are so deep in the details that they can't see how overwhelming the document is to someone trying to pop in, get an answer, and pop out.

### Strategy refactoring

Inverting the structure is only the first step of optimizing for readability. **Strategy refactoring** means discarding structure wherever it interferes with usability. The five-section structure excels at separating concerns *while reasoning*, but most readers benefit from engaging with the full implications at once. Examples of refactors: merge Refine into Diagnose so maps and models sit next to the topics they explore; eliminate the Operation section entirely and place operational details alongside the policies they apply to. The principle: "Once you're done thinking, refactor away the thinking tools" — the best tools for one workflow (creating) are not the best for a different workflow (reading and applying).

## Actionable guidance

- After drafting in the writing order, restructure the document into the reading order: Policy, Operation, Refine, Diagnose, Explore.
- Put whatever your specific readers care about most at the very top — Policy for approvers, Operation for the organization at rollout.
- Present the policy first in approval meetings; only dig into rationale and research details when someone actually disagrees with the policy itself. Don't debate details when you agree on the overarching approach.
- Keep the diagnosis and exploration sections in the document (at the end) rather than publishing a policy-only document, so future hires can trace the reasoning.
- Refactor aggressively: merge sections (e.g., Refine into Diagnose) or dissolve sections (e.g., fold Operation details into Policy) when that lets readers see the full implications in one place.
- Before wide release, have someone entirely uninvolved with the strategy read it and flag anything hard to understand — involved readers gloss over inscrutable passages.
- Roll out every strategy with an explicit commenting period inviting discussion, plus office hours where you explain correct application. Beyond aiding adoption, these surface dissenters so you can follow up on their concerns.
- Maintain a company-internal engineering strategy template with consistent metadata: creation date, current approval status, and — most important, because it extends the document's life — a clear, durable place to ask questions. Consider baking some of this chapter's material into the template itself.
- After release, disable in-document commenting. Move discussion outside the document; this doesn't suppress debate.
- To build empathy quickly, read someone else's academically structured strategy document you're unfamiliar with and notice how hard it is to find the actual proposal.

## Pitfalls and misconceptions

- **Refusing to restructure.** Most strategy writers resist spending time restructuring their draft. "Deliberately refusing to structure documents for readers' benefit causes a surprising number of good strategies to fail utterly."
- **Assuming derailed approval meetings mean the strategy is wrong.** They usually mean the policy wasn't presented up front.
- **Assuming readers will muddle through to the end.** Unmotivated readers give up and invent their own answers.
- **Publishing policy-only documents.** They work at first but produce "transient alignment" that breaks as staff turns over.
- **Keeping the thinking structure out of habit.** Don't let the best tools for the creation workflow mislead you into using them for the reading workflow.
- **Leaving comments open after release.** A long string of open comments makes a strategy look unapproved and unfinished, and distracts readers.
