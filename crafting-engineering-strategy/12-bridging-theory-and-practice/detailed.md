# Chapter 12: Bridging Theory and Practice — Detailed Reference

## Introduction (chapter opening)

The chapter opens by acknowledging a real audience of skeptics: some people the author has worked with have lost hope that engineering strategy actually exists within any engineering organization. He imagines them reading unimpressed through the book's steps to build engineering strategy, or through the strategy for resourcing Engineering-driven projects, seeing these ideas as "theoretical at best." In less polite company, they might even describe them as "fake constructs."

The author's response is not to argue back but to engage: "Let's talk about it! Because they're right." The skeptics are right in two different ways:

1. The book explains how to create clean, refined, and definitive strategy documents — but most real strategy artifacts initially look rather messy.
2. Applying these techniques can require a fair amount of creativity. It might sound easy, but it's quite difficult in practice.

The chapter exists to close this gap between theory and practice. Its stated agenda:

- Why strategy documents need to be clear and definitive, especially when strategy development has been messy
- How to iterate on strategy when there are demands for unrealistic timelines
- Using strategy as a nonexecutive
- Handling dynamic, quickly changing environments where the diagnosis can change frequently
- Working with indecisive stakeholders
- Surviving other people's bad strategy work

The framing sentence: the chapter dives into "the many ways that praxis doesn't quite line up with theory."

## Clear, Definitive Documents

This section explains why strategy documents must be clear and definitive even though their development was messy.

The starting premise carries over from the previous chapter (Chapter 11): documents that feel intuitive to write are often fairly difficult to read. The reason is that thinking tends to be a linear-ish journey from a problem to a solution, so a document that mirrors the author's thinking narrates that journey. Most readers, however, usually just want to know the solution and then move on.

The underlying claim about reading patterns: good strategies are read for direction (for example, when a team wants to understand how to solve a specific issue) far more frequently than they are read to build agreement (the way you build stakeholder alignment during initial strategy development). Direction-seeking is the common case; agreement-building is the rare case tied to the development phase.

Two organizational failure patterns follow:

1. **Writer-oriented-only organizations.** Many organizations only produce writer-oriented strategy documents and have no reader-oriented documents at all. If you've predominantly worked in those organizations, the first reader-oriented documents you encounter may seem superficial, because they present decisions before explaining how those decisions were reached. The author concedes the observation is accurate ("That's true") but rejects the conclusion: it's not superficial; "it's simply prioritizing what most readers care about: the decision itself."

2. **Reader-oriented documents that omit rationale.** There are also organizations with many reader-oriented documents that omit the rationale for the strategy. Those documents feel prescriptive and heavy-handed, for two reasons:
   - The infrequent readers who do want to understand the thinking can't find it.
   - Anyone who wants to propose an alternative has to do so without knowing the rationale behind the current policies. "The absence of that context often transforms a collaborative problem-solving opportunity into a political conflict."

The section's closing encouragement: see the frequent absence of reader-oriented, fully justified documents as a major opportunity to drive strategy within your organization, rather than as evidence that these documents don't work. The author's experience is that they do work.

## Doing Strategy Despite Unrealistic Timelines

The most frequent failure mode the author sees for strategy is when it's rushed. Authors often accept that they must stop thinking when the artificial deadline is reached.

**Claire Hughes Johnson's planning-window argument.** Stripe executive Claire Hughes Johnson, in her book *Scaling People: Tactics for Management and Company Building* (Stripe Press, 2023), argues that planning expands to fit any timeline, and consequently sets a short annual planning timeline of several weeks. The observed split among teams:

- Some teams accepted that as a fixed timeline and stopped planning when the timeline ended.
- Effective teams never stopped planning, either before or after the planning window.

**The recommended reframe.** When strategy work is given an artificial or unrealistic timeline, you should deliver the best draft you can. Afterward, rather than being "finished," you should view yourself as starting the refinement process. Supporting reasoning: it's an open secret that many strategies never leave the refinement phase and are tweaked throughout their lifespans. The rhetorical question that completes the argument: why should a strategy with an early deadline be any different?

**The acknowledged problem with this reframe.** The executive who imposes the unrealistic timeline often intends it to force people into action and quick thinking. Even if you privately know that the executive's artificial deadline denotes when refinement starts rather than when strategy development ends, your colleagues who are also working on strategy might believe that all decisions must be finalized by that deadline. The private reinterpretation is not enough on its own.

**How to resolve the mismatch:**

- Ideally, appeal directly to the executive to clarify what their timeline means.
- Sometimes having the conversation with the responsible executive is quite difficult. In that case, you do have to work with individuals who take the strategy literally and as unalterable, until one of two things happens: you eventually get to have the conversation, or something goes wrong badly enough that the executive starts paying attention again.
- Usually, though, you can find someone who has a communication path to the executive, as long as you can articulate the issue clearly.

## Using Strategy as a Nonexecutive

This section addresses the objection that strategy is only possible with executive authority.

**The objection, in two mirrored forms:**

1. Some engineers argue that the only valid strategy altitude is the highest one — the executive level — because any other strategy can be invalidated by a new, higher-altitude strategy. They claim teams simply cannot do strategy, because executives might invalidate it.
2. Some engineering executives argue the same thing in mirror image: they claim they can't work on an engineering strategy because the missing product strategy or business strategy might introduce new constraints.

**The author's position:** he doesn't agree with this line of thinking at all. To do strategy at any altitude, you have to come to terms with the certainty that new information will show up and you'll need to revise your strategy to deal with it. This applies at every altitude, executives included.

**Counterexample: the user-data access strategy (Document 19-1).** The strategy for controlling access to user data is presented as a good counterexample against the premise that effective strategy requires executive support. In that case, the Security team had framed their lack of progress as the result of limited executive engagement, which had led to a disengaged team. However, as the author dug into the ergonomics of the problem with the Security team, they came to realize that they could significantly reduce unnecessary access to user data without any top-down support at all, by making the workflows easier to use. What looked like a missing-authority problem was a misdiagnosis hiding a lever the team already controlled.

**The section's core principle:** "effective diagnosis trumps authority." Supporting claim: at least as many executives' strategies are "ravaged by reality's pervasive details" as are overridden by higher-altitude strategies — so executives enjoy no special immunity that would make their altitude uniquely "valid." Closing warning: the only way to be certain your strategy will fail is to wait until you're certain that no new information might show up.

## Doing Strategy in Chaotic Environments

Chapter 17 (referenced here as a forward pointer) discusses how a company should plot a path through the rapidly evolving LLM ecosystem. Periods of rapid technological evolution are one reason your strategy might encounter a "pocket of chaos," but there are many others. The chapter enumerates sources of chaos:

- Rapid technological evolution (e.g., the LLM ecosystem)
- Pockets of rapid hiring or layoffs
- Load-bearing senior leaders departing, which can change a company quickly
- Slowing revenue in the company's core business, which can initiate chaotic actions in pursuit of a new business

**The principle:** strategies don't require stable environments; they require awareness of the environment they're operating in. The contrast drawn:

- In a stable period, you might expect a strategy to run for several years with relatively little deviation from the initial approach.
- In a dynamic period, the strategy authors might know that they can only protect capacity in two-week chunks before a new critical initiative pops up.

It's possible to execute good strategy in either scenario, but it's impossible to execute good strategy if you don't diagnose the context effectively. Stability is not the prerequisite; accurate diagnosis of how stable or unstable the context is becomes the prerequisite.

## Unreliable Information

This section covers working with indecisive stakeholders — situations where the way forward would be very obvious if only a few key decisions could be made. You know who is supposed to make those decisions, but you simply cannot get them to decide.

**The author's most visceral example.** He was conducting a layoff where the CEO wouldn't define a target cost reduction or specify how much various functions (like Engineering, Marketing, and Sales) should contribute to those reductions. Those two decisions would have made Engineering's approach obvious; without that clarity, things felt impossible. Although he was frustrated at the time, he has since come to appreciate that missing decisions are the norm rather than the exception.

**How a strategy can handle a missing decision: the private equity strategy (Document 18-1).** The strategy on navigating private equity ownership deals with this problem by acknowledging a missing decision and expressly blocking one part of the strategy's execution until that decision is made. Other parts of its plan, like changing how roles are backfilled, went ahead to address the broader cost problem.

**The decision rule:** rather than blocking on missing information, your strategy should acknowledge what's missing and move forward where you can. Two forms this can take:

- Sometimes that means moving forward by taking risks.
- Sometimes it means delaying for clarity.

But it never means accepting that you're stuck without options other than pointing a finger.

## Surviving Other People's Bad Strategy Work

Sometimes you will be told to follow something described as a strategy, but it's really just a policy without any strategic thinking behind it. This is an unavoidable element of working in organizations, and it happens for all sorts of reasons. Two named causes:

1. **Leaders who don't believe explaining is valuable.** Some leaders don't believe it's valuable to explain their thinking to others, because they see themselves as the one important decision-maker.
2. **Leaders rolling out a policy they disagree with.** Other times, your leader doesn't agree with a policy they've been instructed to roll out. The example: adopting "high-hype" technologies, like blockchain during the crypto boom, often happens through top-down direction from company leadership. Engineering might disagree with the decision, but is obligated to align with it. Such leaders find that it's hard to explain a strategy that they themselves don't understand.

The author names the situation directly: it is frustrating.

**The most effective response he has found: a private strategy of your own.** Write a strategy that acknowledges the broader strategy you disagree with in its diagnosis, treating it as "a static, unavoidable truth." From there, you can make practical decisions that recognize the context, even if it's not a context you'd have selected for yourself.

**Sharing rule:** the author generally doesn't share this private version unless a colleague raises the concern that they don't understand his decision making — at which point he talks them through the thinking in his private strategy.

## Summary

The chapter closes by restating its arc. It started by acknowledging that the steps to building engineering strategy are a theory of strategy, one that can get messy in practice. By the end, the reader knows why strategy documents often come across as overly pristine: because they're trying to communicate clearly about a complex topic.

The reader also knows how to navigate the many ways reality pulls you away from perfect strategy:

- Unrealistic timelines
- Higher-altitude strategies invalidating your own strategy work
- Working in a chaotic environment
- Dealing with stakeholders who refuse to align with your strategy

Finally, sometimes strategy work done by others is really just unsupported policy, with neither a diagnosis nor an operational approach. The closing assurance: "That's all stuff you're going to run into and overcome on your path to doing good strategy work."
