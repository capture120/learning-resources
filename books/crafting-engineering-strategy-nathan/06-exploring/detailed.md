# Chapter 6: Exploring — Detailed Reference

## Chapter Introduction

A surprising number of strategies are doomed from inception because their authors get attached to one particular approach without considering alternatives that would work better for their current circumstances. Larson gives two concrete instances of how this happens:

- Engineers wanting to pick tools solely because they are trending.
- Executives insisting on adopting the tech stack from their prior organization, where they felt comfortable.

Exploration is presented as "the antidote to early anchoring." It forces you to consider the problem widely before evaluating any of the possible paths forward. Larson gives three framings of what exploration is for:

1. It forces wide consideration of the problem before any path forward gets evaluated.
2. It is about verifying that your prior experience remains relevant, rather than assuming the industry has been stagnant since you last worked on a given problem.
3. It is "continuing to believe that things can get better when you're not watching."

The chapter covers:

- The goals of the exploration phase of strategy creation.
- When to explore — "always first!" — and when it makes sense to stop exploring.
- How to explore a topic, including common mechanisms like mining for internal precedent, reading industry papers and books, and leveraging your external network.
- Why you must avoid making judgments while exploring.

Stated outcome: by the end of the chapter, you'll be able to conduct an exploration for your current strategy or the next one you work on.

## What Is Exploration?

### The Grand Migration antipattern

One of the frequent antipatterns Larson has encountered among senior leadership is the Grand Migration: a new leader declares that a massive migration to a new technology stack — typically the stack used by their former employer — will solve every pressing problem.

What distinguishes the Grand Migration is not the initially bad selection, but the single-minded ferocity with which the senior leader pushes for their approach, even when it becomes abundantly clear to others that it doesn't solve the problem at hand.

The failure mechanism, as Larson describes it: these senior leaders are very intelligent, but have allowed themselves to be trapped by their initial thinking from prior experiences. Accepting those early thoughts as the foundation of their strategy, they build the entire strategy on top of those ideas, and eventually so much weight rests on those early assumptions that it becomes impossible for the leader to acknowledge the errors.

### Definition

Exploration is "the deliberate practice of searching through a strategy's problem and solution spaces before allowing yourself to commit to an approach." It's understanding how others have approached the same problem:

- Recently and in the past.
- Both in trendy companies you admire and in practical companies that actually resemble yours.

### Internal versus external proportion

Exploration is usually more external than internal, but the proportion depends on the size of your company:

- In a massive engineering organization of 100,000, there are likely existing internal solutions to your problem that you've never heard of.
- Conversely, in an organization of 50 engineers, it's likely that much of your exploration will be external.

## When to Explore

Exploration is the first step of good strategy work. You will always regret skipping it, because you'll inadvertently box yourself into whatever approach you focus on first. This is especially true for problems you've solved previously: exploration is the only thing preventing you from overindexing on your prior experiences.

Stopping rule: try to continue exploring until you know how three similar teams within your company (if it's a large company) and three similar companies have recently solved the same problem. Make sure you can explain the thinking behind those decisions. At that point, you should be ready to stop exploring and move on to the diagnosis step of strategy creation (covered in the next chapter, Chapter 7).

Time bounds: exploration should always come with a minimum and maximum time frame. Less than a few hours is very suspicious, and more than a week is questionable as well.

## How to Explore

While the details of each exploration will differ a bit, the overarching approach tends to be pretty similar across strategies. Larson's general approach, performed after opening up the draft strategy document he's working on, has five steps:

1. **Gather every resource you can think of related to that problem.** Example: in the Uber service migration strategy, Larson started by collecting recent papers on Mesos, Kubernetes, and Aurora to understand the state of the industry on orchestration.
2. **Do some web searching and foundational-model prompting, and check with a few current and prior colleagues about what topics and resources you might be missing.** Example: for the Calm engineering strategy, Larson focused on talking with industry peers about tools they had used to focus a team with diffuse goals.
3. **Summarize the list of resources you've gathered, separating those you want to explore from those you won't spend time on but which are worth mentioning.** Example: the LLM adoption strategy's exploration section documents the variety of resources the team explored before completing it.
4. **Work through the list one by one, continuing to collect notes in the strategy document. When you're done, synthesize those into a concise, readable summary of what you've learned.** Example: the monolith decomposition strategy synthesizes the exploration of a broad topic into four paragraphs, with links to references.
5. **Once you generally understand how a handful of similar internal and external teams have recently approached this problem, stop.**

Of all the steps in strategy creation, exploration is the most inherently open-ended, and you may find that a different approach works better for you. If so, go ahead and try that instead — as long as it's not skipping exploration. If you're not sure what to do, though, try following the preceding steps closely.

**Note (Wardley mapping):** You can also use techniques like Wardley mapping, covered in Chapter 8, to support your exploration phase. Wardley mapping is a tool designed within a different strategy tradition, and categorizing it as solely either an exploration tool or a refinement tool ignores some of its potential uses. There's no perfect way to do strategy: take what works for you and use it.

### Mine Your Organization for Internal Precedent

One of the most powerful forms of strategy is simply documenting how similar decisions have been made internally: it's often enough to steer how your organization makes similar decisions in the future. This approach is documented in *Staff Engineer*'s "Write five, then synthesize", and it is also the most valuable step of exploration for those working in established companies.

If you are a tenured engineer, it's somewhat safe to assume that you are aware of your organization's typical internal approaches. Even so, it's worth poking around to see if there are any related experiments happening internally. This is doubly true if you've joined the organization recently or if your work is distant from the codebase itself.

Sometimes the internal approach isn't ideal, but it's still superior because it's already been implemented and there's someone else maintaining it. In the long run, your strategy can ride along as someone else addresses the issues that aren't a perfect fit.

### Using Your Network

There are some topics you can't learn much about without talking directly to practitioners — especially:

- Security
- Compliance
- Operating at truly large scales
- Competitive processes like optimizing advertising spend

Further, people often publicly describe solving a problem very differently from how they actually approach the problem.

This is why having a broad personal network is exceptionally powerful: it makes it possible to quickly understand the breadth of possible solutions, and it also provides access to the practical downsides of various approaches, which people often omit when speaking publicly.

Example: in a recent strategy session, a proposal came up that seemed off to Larson. He was able to text industry peers and get answers to those texts before the meeting ended — answers that invalidated the room's assumptions about what was and was not possible. A disagreement that might have taken weeks to resolve was resolved in a few minutes, and the group was able to figure out next steps then and there.

Caveat: it's also important to evaluate information from your network with skepticism rather than accepting it without question. Larson has certainly had his network be wrong, and the people in your network never know how your current circumstances differ from theirs.

For more detailed coverage on building your network, the topic also comes up in *Staff Engineer*'s chapter "Build a network of peers" and *The Engineering Executive's Primer*'s chapter "Building your executive network". Larson notes it feels silly to cover the same topic a third time, but networking is a foundational technique for effective decision making.

### Read Widely; Read Narrowly

Reading has always been an important part of Larson's strategy work. There are two distinct motions within this approach: read widely on an ongoing basis to broaden your thinking, and read narrowly on the specific topic you're working on.

**Reading widely:** Larson makes an effort each year to read 10 to 20 industry-relevant works. These are not necessarily new releases, but they're new to him. Importantly, he tries to read on topics he doesn't know much about, or arguments he initially disagrees with. Recent reads he cites:

- Chris Miller's *Chip War* (Scribner, 2022)
- Curry, Hsu, and Bergman's *Building Green Software* (O'Reilly, 2024)
- Kent Beck's *Tidy First?* (O'Reilly, 2023)
- Flyvbjerg and Gardner's *How Big Things Get Done* (Crown Currency, 2023)

From each of these books, he learned something or stored away ideas that might apply to new problems.

**Reading narrowly:** when Larson recently started working on a strategy related to AI agents, the first thing he did was read through Chip Huyen's "exceptionally helpful survey" *AI Engineering* (O'Reilly, 2024). Similarly, when the team at Uber started thinking about Uber's service migration (Document 16-1), they read a number of industry papers, including "Large-scale Cluster Management at Google with Borg" and "Mesos: A Platform for Fine-Grained Resource Sharing in the Data Center".

None of these readings had all the answers to the problems being worked on, but they did an excellent job at helping understand the range of options and identify other references to consult in the exploration.

Two further pieces of advice:

1. Get comfortable with skimming books. Even tightly edited books will have a lot of content that isn't particularly relevant to your current goals, and you should skip that content liberally.
2. What you read doesn't have to be books. It can also be blog posts, essays, interview transcripts, or even nontext sources like conferences and talks. Larson got a lot out of Dan Na's "excellent talk" "Pushing Through Friction".

### Each Job Is an Education

Experience — spending time working on the details of meaningful problems — is the most effective, and the slowest, mechanism for exploring. You probably shouldn't pick every job to prioritize learning, when there are so many other things to optimize for, like financial stability. But doing so occasionally allows you to explore complex problems over time — recognizing that some of your prior knowledge will have gone stale along the way — which is uniquely valuable.

## Save Judgment for Later

The point of exploration is to go broad, with two goals:

1. Understanding approaches you might not have considered.
2. Invalidating things you initially think are true.

Both of those things are only possible if you save judgment for later. If you're passing judgment about whether approaches are "good" or "bad," then your exploration is probably going astray.

Soft rule: if no one involved in a strategy has changed their mind about something they believed when you started the exploration step, then you're not done exploring. This is especially true when it comes to strategy work by senior leaders. Their beliefs are often well-justified by years of experience, but even they begin each exploration unclear whether their prior experiences have gone stale over time.

## Summary

At this point, the reader should feel comfortable exploring as the first step of strategy work, and understand the likely consequences of skipping this step. Larson states it is not an overstatement to say that every one of the worst strategic failures he has encountered would have been prevented if its primary author had taken a few days to explore the space before anchoring on a particular approach. A few days of feeling slow are always worth avoiding years of misguided efforts.
