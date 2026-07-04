# Chapter 14: Systems Modeling — Detailed Reference

## Introduction

Larson opens with a personal framing: while he was "probably late" to learn the concept of strategy testing, he may have learned systems modeling "too early," stumbling on Donella Meadows's *Thinking in Systems: A Primer* (Chelsea Green, 2008) before he had a clear set of problems to apply its techniques against. Fortunately, he remembered those lessons as he began his software career, and over time discovered a number of ways to use systems modeling. His overall assessment: systems modeling isn't perfect, but it remains "the most effective, flexible tool I've found to debug complex problems."

The chapter's structure, as he lays it out:

- It starts with a two-minute primer on the basics of systems modeling.
- It then covers how to implement these approaches, drawing examples from a number of systems models created to refine the strategies discussed throughout the book.
- It ends with resources for those looking for a deeper exploration.

The topics covered:

1. When systems modeling is (or isn't) the right technique
2. Tooling
3. How to build a systems model
4. How to document and communicate what you learn from a systems model
5. What systems modeling can and can't do

After working through the chapter's overview, the reader can see the approaches implemented in a number of systems models created to refine the strategies throughout the book. Larson notes that the theory of systems modeling is certainly interesting, but hopes that seeing real models in support of concrete engineering strategies will be even more useful.

## A Two-Minute Primer

For an exceptional introduction to systems thinking, Larson says there is "no better place to go" than *Thinking in Systems*. For a worse but shorter introduction, he points to his own essay "Introduction to Systems Thinking," which is also available in his book *An Elegant Puzzle: Systems of Engineering Management* (Stripe Press, 2019). For something even shorter, he offers Figure 14-1 — a diagram of requests succeeding and failing between a user, a load balancer, and a server — as "the briefest summary I can manage."

The two foundational definitions:

- **Stock**: in systems modeling, anything that can accumulate is called a stock. Each of the boxes in the Figure 14-1 systems model (Requests, Server, and so on) represents a stock.
- **Flow**: changes to stocks are called flows. Every arrow between stocks (like "OK" or "Error in server") represents a flow.

**Systems modeling** is defined as "the practice of using various configurations of stocks and flows to understand circumstances and behaviors that might otherwise be surprising or too slow to understand from measurement."

Worked example (Figure 14-2, "Successful and errored requests in two different scenarios"): the model can be used to explore the tradeoffs between a load balancer that caps throughput to a load-sensitive service behind it and one that does not. Without a model, you might get into a philosophical debate about how ridiculous it is that the downstream server is load-sensitive. With the model, it's immediately obvious that the downstream server is worth protecting, even if it is concerningly sensitive.

This example carries the chapter's core claim about what models do: "they create a cheap way to understand reality when fully understanding it would be too cumbersome."

### More systems thinking resources (sidebar)

- *Thinking in Systems: A Primer* by Donella Meadows (Chelsea Green, 2008)
- *Business Dynamics: Systems Thinking and Modeling for a Complex World* by John D. Sterman (McGraw-Hill, 2000)
- *An Introduction to Systems Thinking* by Barry Richmond (Isee Systems, 2004)

## When Is Systems Modeling Useful?

Although refinement is an important step in developing any strategy, some refinement techniques work better for a given strategy than others. Systems modeling is extremely useful in three distinct scenarios:

1. **When you're unsure where the leverage points might be in a complex system.** Modeling allows you to cheaply test which levers might be meaningful. Example: modeling Uber's strategy for onboarding new drivers (Document 17-4) showed that improving onboarding was less important than reengaging departed drivers.
2. **When you have significant data to compare against.** Having lots of data allows you to focus on the places where the real data and your model are in tension. Example: Larson modeled the impact of hiring on Uber's engineering productivity, then compared that with internal data.
3. **When stakeholders' disagreements are based on their unstated intuitions.** Models can turn those intuitions into something structured that can be debated more effectively.

In all three categories, modeling makes it possible to iterate your thinking much faster than running a live process or technology experiment with your team.

On the objection that modeling is slow: Larson sometimes hears concerns that modeling slows things down, but says "this is just an issue of familiarity." Once you get some practice, modeling can be faster than asking for advice from industry peers. The models he developed for this book took less than an hour each — with one notable exception: modeling LLMs' impacts on developer experience took much longer, because he deliberately used an impractical tool (a spreadsheet) to reveal the importance of good tooling.

**Counterintuitive insights.** Systems modeling often exposes counterintuitive dimensions to the problem you're working on. Example from the LLM model: his experience suggests that effective LLMs might cause us to spend *more* time writing and testing code, but *less* time fixing issues discovered after that code goes to production. You might imagine LLMs would reduce testing time, but the model shows that reducing testing time is only valuable to the extent that the issues identified in production remain at worst constant. If any issues found in production increase, then reducing testing time does not contribute to increased productivity.

**The praxis qualification.** "Modeling without praxis creates unsubstantiated conviction: true understanding comes from applying ideas to real situations." However, in combination with learning from applying your models, Larson has encountered few other techniques that can similarly accelerate learning.

**When systems modeling is not the ideal refinement technique:**

- If you're already sure about your general approach and want to refine the narrow details, then **strategy testing** is a better option.
- If you're trying to understand the evolution of a wider ecosystem, you may prefer **Wardley mapping**.

## Tooling

While the idea of systems modeling is quite intuitive, its tools "are a real obstacle to wider adoption." The tooling ecosystem has been fragmented for some time, perhaps because many of the tools that were popular early on were quite expensive. A mix of three factors — complex requirements, patent consolidation, and a perceived small market size — has also discouraged a modern solution from consolidating the tooling market.

Larson revisits the speed question: he said earlier that systems modeling is extremely quick, yet many folks find it slow and laborious. Part of that is an issue of practice, but he suspects that tooling quality is "at least as big a part of the challenge."

**The spreadsheet cautionary tale.** In the LLM impact model in Chapter 17, he went through the steps of building the model in an increasingly messy spreadsheet. This was slow, challenging, and extremely brittle. Even after finishing the model, he couldn't extend it effectively to test new ideas, and he inadvertently introduced a number of bugs into the implementation.

**Simpler toolchains.** Going in the opposite direction, he explored some potentially simpler toolchains than the one he typically relies on, including SageModeler and Insight Maker. There are many of these introductory toolchains for systems modeling, but he generally finds that they have at least one of three problems: they're constrained in their capabilities, have a fairly high learning curve, or make it difficult to share your model with others.

**His chosen toolchain.** In the end, he wound up back at a toolchain he wrote some years ago: `lethain/systems`. It's "far from perfect," but he considers it a relatively effective mechanism for demonstrating systems modeling for five reasons:

- It's a quick way to create and iterate on models.
- It's an easy way to share models.
- It leaves relatively little surface area for bugs in your models.
- It's a free, open source, and self-hosted toolchain.
- It integrates well with the Jupyter ecosystem for diagramming, modeling, and so on.

**The decisive guidance on tools:** you should absolutely pick any tool that feels right to you and practice with it until you feel confident modeling scenarios quickly. After that, Larson wouldn't recommend spending too much time thinking about tools at all: "the most important thing is to build models and learn from them quickly, and almost any tool will be sufficient for that goal with some deliberate practice."

## How to Model

Learning to model systems takes practice, so Larson approaches the details from two directions: first, by documenting a general approach; second, by providing breadcrumbs for deeper exploration of the models developed in the book.

The systems modeling structure he finds effective is a five-step sequence:

1. **Sketch** the stocks and flows on paper or in a diagramming application (like Excalidraw, Figma, or Whimsical). Use whatever you're comfortable with.
2. **Reason** about how you would expect a potential change to shift the flows through the diagram. Which flows do you expect to go up and which go down, and how would that movement help you evaluate whether your strategy is working?
3. **Model** the stocks and flows in your spreadsheet tool of choice. Start by modeling the flows from left to right (the "happy path" flows). Once you have that fully working, then start modeling the right-to-left flows (the "exception path" flows).
4. **Exercise** the model by experimenting with a number of different starting values and determining how the rates influence the model's values. This is essentially performing sensitivity analysis.
5. **Document** your work in a standalone writeup. You can then link to that writeup from any other strategies that benefit from a given model's insights. You might link to any section of your strategy, depending on what topic the particular model explores. Larson recommends decoupling models from specific strategies, because generally the details of any given model are a distraction from understanding a strategy. It's best to avoid that distraction unless a reader is surprised by the conclusion, in which case the link lets them drill into the details.

This is the sequence of steps he generally follows, and he encourages the reader to do the same, but you should adapt them to solve the particular problems at hand. Over time, most of these steps — excluding documentation — turn into a single iterative process. He documents everything after several iterations.

## Deeper Exploration

Having covered the overarching approach, the chapter gives breadcrumbs to specific models elsewhere in the book that go deeper on particular elements:

- **Document 17-4** explores how the driver lifecycle at Theoretical Ride Sharing might be improved with LLMs, and introduces using the `lethain/systems` library for modeling.
- **Document 17-2** looks at how LLMs might impact developer experience at Theoretical Ride Sharing, and demonstrates "(the downsides of)" modeling with a spreadsheet.
- **Document 18-1** studies the financial consequences of various policies for how departed engineers are backfilled in an engineering organization, and introduces further `lethain/systems` features.
- **Document 16-2** determines whether it's possible to optimize an existing service provisioning workflow or if it instead needs to be replaced with a self-service workflow.

Beyond these models, other systems models Larson has written can be found in his blog's systems-thinking category.

## How to Document a Model

Communicating with models in a professional setting is challenging. The core problem is that there are many distinct groups of model readers:

- Some will lack familiarity with the tooling you use to develop models.
- Others will try to refine — or invalidate — your model by digging into the details.

Larson navigates those mismatches by focusing first on the audience that is *least* likely to dig into the model. He still wants to keep all the details handy — ideally in the rawest form possible, to allow others to manipulate the model themselves — but that's very much his secondary goal when documenting a model.

He recommends the following document order, which he used for the models in this book:

1. **Learning section**, with charts showing what the model has taught you
2. **Sketch and explain** the stocks and flows
3. **Reason** about what the sketch itself teaches you
4. **Explain how you developed the model**, with an emphasis on any particularly complex portions
5. **Exercise the model** by testing how changing the flows and stocks leads to different outcomes

The single rule to retain if nothing else: "most people don't care how you built the model—they just want the insights." Your document should reflect that reality. Give readers the insights early, and assume no one will trust your model nearly as much as you do. "Models are an input into a strategy, but never a reliable sole backer."

## What Systems Modeling Isn't

Although Larson finds systems modeling a uniquely powerful way to accelerate learning, he has also encountered many practitioners who believe that their models *are* reality rather than reflecting reality. Over time, he developed a short list of cautions to help would-be modelers avoid overcommitting to their model's insights:

1. **When your model and reality conflict, reality is always right.** At Stripe, the team developed a model to guide their reliability strategy. The model was intuitively quite good, but its real-world results were mixed. Their attachment to the early model distracted them: they spent too much time collecting and classifying data and were slow to engage with the most important problems — maximizing the impact of scarce mitigation bandwidth, and growing that mitigation bandwidth. They would have been more impactful if they'd engaged directly with the lessons reality was teaching them rather than looking for reasons to disregard them.

2. **Models are immutable, but reality isn't.** Larson once joined an organization that was investing tremendous energy into hiring, yet struggling to hire. Their intuitive model pushed them to spend years investing into optimizing the top of their funnel, and later steered them to improve the closing process. What they weren't able to detect was that the largest hurdle in their hiring process was a misalignment among their own interviewers' expectations.

3. **Every model omits information; some omit critical information.** The service migration at Uber (Document 16-1) is a great example: modeling clarified that the team had to adopt a more aggressive approach to succeed. They did succeed, but the model didn't study the consequences of *completing* the migration, which included a very challenging development environment. The model captured everything Larson's team cared about as the team responsible for running the migration, but did nothing to evaluate whether the migration was a good idea overall.

In each of those situations, two things are true: the model was extremely valuable, *and* the model subtly led the team astray. The teams would have been led astray even without a model. The key thing to remember isn't that models are inherently misleading: "the real risk is being overly confident about your model." Modeling is a powerful tool to use in tandem with judgment — not a replacement for judgment.

## Summary

Systems modeling isn't perfect. As noted earlier in the chapter: if you've already determined your strategy and want to refine the details, strategy testing is probably a better choice; if you're trying to understand the dynamics of an evolving ecosystem, try Wardley mapping.

However, if you have the general shape but lack conviction on how the pieces fit together, systems modeling is "a remarkable tool." After this chapter, the reader knows how to select appropriate tooling and use that tooling to model their problem. In Part IV of the book, Larson models a handful of detailed problems to provide concrete examples of applying this technique.
