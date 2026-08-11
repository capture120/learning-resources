# Chapter 11: Writing Readable Engineering Strategies — Detailed Reference

## Chapter Introduction

By this point in the book, a complete engineering strategy has been established as having five components: explore, diagnose, refine, set policy, and operate. That sequence is effective for *creating* a strategy. It is, however, challenging for people who are trying to quickly read and apply a strategy without necessarily wanting to understand the complete thinking behind each decision. The chapter's framing premise: "The order in which you write your strategy isn't necessarily the order in which your audience should read it."

The chapter covers four things:

1. Why the order used for writing a strategy is hard to read
2. How to organize a strategy document for reading
3. How to refactor and merge components for improved readability
4. Additional tips for writing effective strategy documents

The stated outcome: after reading the chapter, you should be able to take a written strategy and rework it into a version that is much easier for others to read.

## Why Writing Structure Inhibits Reading

Most software engineers learn to structure documents as students. Academic essays present evidence to support a clear thesis and generally build an argument forward toward a conclusion. Some business consultancies are the exception in that they train new hires in business writing — for instance, McKinsey teaches Barbara Minto's *The Pyramid Principle: Logic in Writing and Thinking* (Prentice Hall, 2010) — but that kind of training is the exception, not the rule.

While academic essays want to develop an argument, professional writing is different. Professional writing typically has one of three distinct goals, illustrated with the same database topic phrased three ways:

1. **Refining thinking about a given approach.** Example question: "How do we select databases for our new products?" This is an area where the academic structure can be useful, because it focuses on the thinking behind the proposal rather than the proposal itself.
2. **Seeking approval from stakeholders or executives.** Example question: "What database have we selected for our new analytics product?" Here the academic structure creates a great deal of confusion, because it focuses on the thinking rather than the specific proposal — and stakeholders view the proposal as the primary topic to review.
3. **Communicating a policy to your organization.** Example statement: "Databases are allowed for new products." This type of writing is about helping engineers at your company understand the permitted options for a given problem, as well as explaining the rationale behind the decision for those who want to understand or challenge the current policy.

The ideal format for the first case (refining thinking) is generally at odds with the other two. That mismatch is a frequent reason why strategy documents struggle to graduate from brainstorming to policy. Most strategy writers resist the idea that it is worth their time to restructure their initial documents, so Larson expands on three challenges he has personally encountered when trying to make progress without restructuring. These are the three subsections that follow.

### Too Long, Didn't Read

Thinking-oriented structures leave the policy recommendations at the very bottom of the document. But the vast majority of strategy readers are simply trying to understand the policy so they can apply it to their specific problem. Many — perhaps most — of those readers give up before they reach the sections that answer their questions. They then assume that the document doesn't provide clear direction, because finding that direction takes too long.

This is very much akin to the core lesson of Steve Krug's classic book on web usability, *Don't Make Me Think* (Peachpit, 2013): users (and readers) don't understand, they muddle through. It is "an act of hubris" to assume that readers will invest significant time to deeply understand your document.

### Approval Meeting to Nowhere

There are roughly three types of approval meetings:

1. **No feedback.** You go in and no one has any feedback. Maybe someone gripes that "this meeting could've been an email," but your document is approved.
2. **Tie-breaking between incompatible stakeholders.** Two sets of stakeholders with incompatible goals need a senior decision-maker to mediate between them. This is a very useful meeting, because you generally can't make progress without that senior decision-maker breaking the tie.
3. **Early derailment.** The meeting gets derailed early with questions about the research, whether you'd considered another option, and whether this is even relevant.

For the third type, you might think it happens because your strategy is wrong, but in Larson's experience, it's usually because you failed to structure the document to present the policy up front. Stakeholders might disagree with many elements of your thinking, yet still agree with your ultimate policy. It's only useful for them to dig into your rationale if they actually disagree with the policy itself.

The decision rule: avoid getting stuck debating the details when you agree on the overarching approach. Present the policy first, and only dig into the details when there's disagreement.

### Transient Alignment

Sometimes you'll see two distinct strategy documents: the first covering the full thinking, and the second including only the policy and operations sections. This tends to work quite well initially, but over time team members depart and new people are hired. At some point, a new member will challenge the thinking behind a strategy as obviously wrong — generally because it's a different set of policies than they used at their previous employer. If you omit the diagnosis and exploration sections entirely, they can't trace through the reasoning to understand the decision. Instead, they often leap to simplistic conclusions, like the ever-popular "I guess the previous engineers here were just dumb."

As annoying as each of these three challenges is, the solution is simple: use the writing structure for writing, and invert that structure for reading.

## Inverting the Document Structure for Reading

The section opens by reiterating a point from Chapter 5: it's always appropriate to change the structure you use to develop or present a strategy, as long as you are making a deliberate, informed decision.

While "explore, diagnose, refine, set policy, and operate" generally works well for writing policy, Larson has consistently found it a poor format for presenting strategy. He recommends a mostly inverted structure, with each section answering a characteristic question:

1. **Policy** — What does the strategy require or allow?
2. **Operation** — How is the strategy enforced and carried out? How are exceptions granted?
3. **Refine** — What load-bearing details informed the strategy?
4. **Diagnose** — What general trends and observations steered the thinking?
5. **Explore** — What is the high-level, wide-ranging context that we brought into creating this strategy?

The key rule for structuring a written strategy: prioritize what the readers are most likely to care about — if you know what they care about most, put that first. Two applications of the rule:

- When seeking approval from executives, you'll probably focus on the Policy section.
- When rolling a policy out to your organization, you'll probably focus more on the Operation section.

In both cases, those are the critical components, and you want them right up front.

The reasoning behind the rule: very few strategy readers want to understand the full thinking behind your strategy. The vast majority just want to understand how it will impact them or their function. These are your least motivated readers, so you need to provide the details they care about early in the document, before they stop reading. Someone who wants to really understand the thinking will invest time reading through the document even if it isn't perfectly structured for them. Someone who just wants an answer will frequently give up and make up an answer, rather than reading all the way through to where the document does in fact answer their question.

Zooming out, this is a classic "lack of user empathy" problem. The document's authors are so deep in the details that they can't put themselves in the readers' shoes. They don't see how overwhelming the document is to someone simply trying to pop in, get an answer, and then pop out. This lack of empathy also explains why most strategy writers refuse to structure their documents to support the large population of answer seekers.

Two suggestions for overcoming the resistance:

- Try inverting the structure a few times; Larson believes you'll see it helps a great deal.
- For an even faster perspective shift, go read someone else's strategy document that you aren't familiar with. If its authors have followed the academic structure, you'll quickly appreciate how challenging it can be to identify the actual proposal.

## Strategy Refactoring

Inverting the structure is the first step of optimizing a document for readability, a process Larson thinks of as **strategy refactoring**. You don't have to stop at inversion: even the inverted strategy structure can be somewhat confusing.

The worked example is the book's LLM adoption strategy (Document 17-1), which makes two refactors beyond the inverted format:

1. It **merges Refine into Diagnose**, which keeps the map and models closer to the specific topics it explores.
2. It **discards the Operation section entirely** and includes the relevant operational details alongside the policies to which they apply, inside the Policy section.

The principle: strategy refactoring is about discarding structure where it interferes with usability. The five-part strategy structure is very effective at separating concerns while reasoning through decision making, but most readers benefit more from engaging with the full implications of the strategy at once. Once you're done thinking, refactor away the thinking tools: don't let the best tools for one workflow mislead you into thinking they're the best ones for an entirely different workflow.

## Additional Tips for Writing Effective Strategy Documents

Beyond the structural advice above, the chapter offers a handful of smaller tips Larson has found helpful for creating readable strategy documents:

- **Fresh-eyes review before wide release.** Before releasing a document widely, find someone entirely uninvolved with the strategy thus far and have them read it. Ask them to point out any areas that are difficult to understand. Anyone who's been thinking about the strategy will gloss over areas that might be inscrutable to those approaching it with fresh eyes.
- **Explicit commenting period and office hours at rollout.** Every strategy document should be rolled out with an explicit commenting period where you invite discussion, as well as office hours where you are available to explain how to apply the strategy correctly. These steps help with adoption, but even more importantly, they help you identify dissenters, so you can follow up to better understand their concerns.
- **Maintain an internal strategy template.** Every company should maintain its own internal engineering strategy template. The template should include consistent metadata, particularly: when the document was created, the current approval status, and where to ask questions. Of these, a clear, durable place to ask questions is the most important, as it extends the life of the document. Consider incorporating some of this chapter's material into the template.
- **Disable in-document commenting after release.** This isn't intended to prevent further discussion, but rather to move the discussion outside of the document. Nothing creates the impression of an unapproved, unfinished strategy document faster than a long string of open comments. Open comments also distract readers from the strategy document itself.

## Summary

While it's helpful to impose rigid structures while creating a strategy, the chapter teaches how to escape those structures to create a readable document that is easier for others to both approve and apply. Beyond initially inverting the structure for easier reading, you also now understand how to refactor away sections that may have been essential for creating the strategy but interfere with understanding how to apply it. The closing reminder: applying the strategy is by far the most common task for strategy readers.

Larson hopes you finish the chapter agreeing that it's worth your time to rework your thinking-optimized draft. Deliberately refusing to structure documents for readers' benefit causes a surprising number of good strategies to fail utterly.
