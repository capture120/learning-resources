# Chapter 3: Who Gets to Do Strategy? — Detailed Reference

## Introduction

If you talk to enough aspiring leaders, you become familiar with a prevalent idea: that they need to be promoted before they can work on strategy. The idea is widely accepted as true, but Larson has found it "fundamentally incorrect." You can work on strategy from anywhere in an organization; it just requires different tactics to do so.

The chapter's purpose is to explain Larson's belief that anyone within an organization can make meaningful progress on strategy, particularly if you meet two conditions:

- You are honest about the tools actually accessible to you.
- You are thoughtful about how to use those tools.

The themes the chapter digs into, in order:

1. How to do strategy as an engineer, particularly an engineer who hasn't been given explicit authority to do strategy.
2. Doing strategy as an engineering executive who is responsible for the organization's decision making.
3. How to develop engineering strategy even in difficult situations, such as when there is no existing strategy, when acknowledging certain problems is politically sensitive, or when misaligned incentives make consensus challenging.
4. If the book's argument is that everyone should do strategy, is there anyone who, nonetheless, really should not do strategy?

The intended conclusion: by the end, the reader should agree that engineering strategy is accessible to everyone, even though you are always operating within constraints.

## Doing Strategy as an Engineer

It is easy to get so distracted by an executive's top-down approach to strategy that you convince yourself there aren't other approachable mechanisms for doing strategy. There are.

### "Take five, then synthesize"

Larson's earlier book *Staff Engineer* introduces an approach he calls "take five, then synthesize," which does strategy in two stages:

1. **Exploration stage**: Document how five related current and historical decisions have been made in your organization. This is an extended exploration phase.
2. **Synthesis stage**: Synthesize those five documents into a diagnosis and a policy.

The reasoning for why this works without authority: you are *naming the implicit strategy*. Because you are just describing what is already happening, "it's impossible for someone to reasonably argue that you're not empowered to do strategy."

Once you have written it, one of two outcomes follows:

- The organization feels comfortable with what you've written — in which case that document *is* their current strategy.
- The organization does not feel comfortable with it — in which case you have forced a conversation about how to revise the approach.

Creating awareness is often enough to drive strategic change, and doing so does not require any explicit authorization from an executive.

### "Model, document, and share"

When awareness is insufficient, the other pattern Larson has found highly effective in low-authority scenarios is one he wrote about in *An Elegant Puzzle*, called "model, document, and share":

1. **Model** the approach you want others to adopt. Make it easy for them to observe how you've changed the way you're doing things.
2. **Document** the approach, the thinking behind it, and how to adopt it.
3. **Share** the document around. If people see you succeeding with the approach, then they're likely to copy it from you.

Larson anticipates skepticism because this is an influence-based approach. His preemptive answer: as discussed in the next section, even executive-driven strategies are highly dependent on influence.

### Sidebar: Strategy Archaeology

Vernor Vinge's novel *A Deepness in the Sky* (Tor Books, 1999) introduced the term *software archaeologists*, meaning people who create functionality by cobbling together millennia of scraps of existing software.

Although it is a somewhat different usage, Larson sometimes thinks of the "take five, then synthesize" approach as performing *strategy archaeology*: simply by recording what has happened in the past, we make it easier to understand the present — and influence the future.

## Doing Strategy as an Executive

The biggest misconception about executive roles — frequently held by nonexecutives and by new executives who are about to make a series of regrettable mistakes — is that executives operate without constraints. That is false. Executives operate under an extremely high number of constraints:

- budgets to meet
- CEO visions to fulfill
- peers to satisfy
- a team to motivate

They can disappoint any of these temporarily, but in the long term they have to satisfy all of them.

Nonetheless, it is true that executives have more latitude to mandate and cajole participation in the strategies they sponsor. Larson notes that the strategy chapter of *The Engineering Executive's Primer* is a brief summary of this entire book, but it doesn't say much about how executive strategy differs from nonexecutive strategy — which this section addresses.

How the executive's approach to strategy differs from the engineer's boils down to three points:

1. **Mandates only matter if there are consequences.** Executives have the advantage that they can mandate adherence to their strategy, which gives them more options for making effective policy. The concrete contrast: an engineer can't prevent the promotion of someone who refuses to follow their policy, but an executive can. The qualification: if an executive can't or won't enforce consequences for not complying with a mandate, it isn't a meaningful mandate.
2. **Visibility and access.** Even if an executive doesn't have sufficient support or is unwilling to use mandates, they have significant visibility and access to their organization to advocate for their preferred strategy.
3. **Neither access nor mandates improve an executive's ability to diagnose problems.** However, both often create the *appearance* of progress. This is why executive strategies can fail so spectacularly and endure so long despite failure.

The net result, in Larson's experience: executives have an easier time *doing* strategy, but a much harder time *learning how to do strategy well*. They also have fewer guardrails to help them avoid serious mistakes, and the consequences of an executive's poor strategy tend to reach much further than an engineer's. Therefore: waiting to do strategy until you are an executive is a recipe for disaster, even if it looks easier from a distance.

## Doing Strategy in Other Roles

Even if you are neither an engineer nor an engineering executive, you can still do engineering strategy. It will just require an even more influence-driven approach.

The engineering organization is generally right to believe that they know the most about engineering — but that's not always true. Two counterexamples:

- Sometimes a product manager used to be an engineer and has significant relevant experience.
- Other times, such as with the early adoption of LLMs (covered in the book's Document 17-1), engineers don't know much either and benefit from outside perspectives.

## Doing Strategy in Challenging Environments

Good strategies accurately diagnose the circumstances and introduce policies that address those circumstances. You are likely to spend time in organizations where internal limitations make both of those challenging, so it's worth acknowledging that and discussing how to navigate those challenges. The chapter covers three such environments: low-trust environments, poor-judgment environments, and missing strategies.

### Low-Trust Environment

Diagnosing problems is a skill. Two distinct cases can block diagnosis:

1. **Inexperience.** Sometimes you may be too inexperienced to write an effective strategy for your current problem. In that case, the solution isn't easy, but it is straightforward: do more strategy work to build your expertise.
2. **Low trust.** In other cases, you may see the problems fairly clearly, but you know that your organization's culture would frown on acknowledging them. This is a diagnosis problem rooted in low trust, and it does make things more difficult.

The technique for the low-trust case: sometimes you have to *whisper the controversial parts of a strategy* — translate difficult messages into softer, less direct versions that are acceptable to state. If your goal is to hold people accountable, this can feel dishonest or like an ethical compromise. But the goal of strategy is to make better decisions, which is an entirely different concern than holding folks accountable for the past. Chapter 7 recognizes this problem and discusses it in more detail.

#### Sidebar: Karpman Drama Triangle

Sometimes, when the diagnosis seems particularly obvious to you and yet people don't agree with you, it's because you are wrong. When Larson has been obviously wrong about things he understands well, it has usually been because he fell into viewing the situation through the lens of the Karpman Drama Triangle, where all parties are mapped onto the roles of persecutor, rescuer, and victim.

### Poor-Judgment Environment

Even when you do an excellent job diagnosing challenges, it can be difficult to drive agreement within the organization about how to address them. There are two sources of such disagreement:

1. **Genuinely complex tradeoffs.** Example: in Stripe's acquisition of Index (discussed in the book's Document 22-4), there was debate about how to deal with Index's Java-based technology stack. It culminated in a compromise that didn't make anyone particularly happy: deferring the decision until after launching the initial release. That compromise is a good example of a difficult tradeoff: although parties disagreed with the approach, everyone understood the conflicting priorities that had to be addressed.
2. **Poor judgment.** In other cases, there are policy choices that simply don't make much sense, generally driven by poor judgment. Sometimes that's poor technical judgment; other times, people choose to prioritize their own interests at the expense of the company's needs. Example: Calm's strategy to focus on being a product engineering organization (discussed in the book's Document 21-1) dealt with some aspects of this, acknowledging in its diagnosis that "most of our disagreements stem around adopting new technologies or rewriting existing components into new technology stacks." In that situation, your strategy is an attempt to *educate* your colleagues about the tradeoffs they are making.

When people disagree with your strategy, remember that most interesting problems require iterative solutions. Writing your strategy down and sharing it will start a process that can change the organization's mind. Don't get discouraged, even if that change is initially slow.

### Dealing with Missing Strategies

The strategy laid out in the book's Document 18-1, for dealing with new private equity ownership, introduces a common problem: lack of clarity about what other parts of your own company want. In that case, a layoff seemed likely, but it was unclear how large that layoff would be. Many leaders encounter that sort of ambiguity and decide that they cannot move forward with a strategy of their own until that upstream decision is made. While it's inconvenient not to know the details, getting blocked by ambiguity is *always* the wrong decision.

Instead, do what the private equity strategy does: accept that ambiguity as a fact and work around it. Rather than giving up, that strategy adopted a series of new policies to reduce cost growth by changing the organization's seniority mix (the book's Document 18-2). The strategy also recognized that once there was clarity on reduction targets, additional actions would be needed.

The general principle: whenever you're working on challenging problems, you can always find justifications for not making progress. Leadership is about finding a way to move forward despite those issues. A missing strategy will always be part of your diagnosis, but it should never be a reason that you can't do strategy.

## Who Shouldn't Do Strategy?

In Larson's experience, there is almost never a reason why you *cannot* do strategy, but there are two particular scenarios where doing strategy probably doesn't make sense:

1. **A "when" problem, not a "who" problem** (the focus of the next chapter): sometimes there is so much strategy already happening that doing more would be a distraction. If another part of your organization is already working on the same problem, do your best to work with them directly rather than generating competing work.
2. **Trying to satisfy an emotional need to make a direct, immediate impact.** Sharing a thoughtful strategy always drives progress, but it's often the slow, incremental progress of changing your organization's beliefs. Even definitive, top-down strategies from executives are often ignored in pockets of an organization, and bottom-up strategies spread slowly, as they are modeled, documented, and shared. Embarking on strategy work requires a tolerance for winning in the long run, even when there's little progress this week or this quarter.

## Summary

The chapter's closing hopes: that you now believe you can work on strategy in your organization, whether you're an engineer, an executive, or in another role; and that you appreciate that the tools you use will vary greatly depending on who you are within your organization and the culture in which you work. Whether you need to model or can mandate, there's a mechanism that will work for you.
