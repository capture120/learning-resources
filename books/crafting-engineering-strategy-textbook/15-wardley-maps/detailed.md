# Chapter 15: Wardley Maps — Detailed Reference

## Chapter Introduction

Of the three core strategy-refinement techniques covered in this part of the book, Wardley mapping is the one Larson has personally used the least. He includes it in the book despite that, for two reasons: it highlights how many different techniques can be used for refining strategy, and it shows that it's never too late to keep expanding your toolkit.

The defining contrast with the other refinement techniques: whereas techniques like systems thinking and strategy testing often zoom in, Wardley mapping is remarkably effective at zooming out. It is particularly effective at looking at the broader ecosystems in which your organization exists.

The chapter's structure: it starts with a 10-minute primer on Wardley mapping, then provides:

- Tool recommendations
- When Wardley maps are an ideal strategy refinement tool, and when they're not
- The process Larson uses to map
- How to integrate a Wardley map into your strategy creation process
- Breadcrumbs to example Wardley maps
- How to document a Wardley map in the context of a strategy writeup

The promise: after working through this chapter and digging into some of this book's examples of Wardley maps, you'll have a good background to start your own mapping practice.

## Wardley Mapping: A 10-Minute Primer

Wardley maps are a technique to ensure your strategy is grounded in reality — or, as mapping practitioners would say, for creating "situational awareness." The technique was created by Simon Wardley in 2005. If you have a few days, the recommended starting point is Wardley's own book on the topic, *Wardley Maps*, available online for free on Medium. If you only have 10 minutes, this primer section is enough to get you up to speed on *reading* Wardley maps.

The primer's practical running example: creating a Wardley map that aims to understand a knowledge-base management product — along the lines of a wiki, like Confluence or Notion. The walkthrough starts from an initial map of this application (Figure 15-1, "Wardley map for a knowledge-base management application").

You need to know three foundational concepts to read a Wardley map: its components, its x-axis, and its y-axis.

### Components of a Wardley Map

Maps are populated with three kinds of components: users, needs, and capabilities.

- **Users** exist at the top of the map, and represent a cohort of users who will use your product.
- **Needs**: each kind of user has a specific set of needs, generally tasks that they need to accomplish. The structural rule: any box connecting directly to a user is a need.
- **Capabilities**: fulfilling each need requires certain capabilities. The structural rule: any box connecting to a need is a capability. A capability can be connected to any number of needs, but can never connect directly to a user; capabilities connect to users only indirectly, via needs.

### X-axis

The x-axis is divided into four segments, representing how commoditized a capability is:

1. **Genesis** (far left): a brand-new capability that hasn't existed before.
2. **Custom**: something that requires specialized expertise and operation to function, such as a web application that requires software engineers to build and maintain.
3. **Product**: something that can generally be bought.
4. **Commodity** (far right): something so standard and expected that it's unremarkable, like turning on a switch causing electricity to flow.

Custom and product, the two middle categories, are where most items fall on the map.

Applied to the knowledge-base example:

- *Document reading* is commoditized: it's unremarkable if your application allows its users to read content.
- *Document editing* is somewhat on the border of product and custom. You might integrate an existing vendor for document editing needs, or you might build a tool yourself — but in either case, document editing is less commoditized than document reading.

### Y-axis

The y-axis represents visibility to the user. In the knowledge-base map:

- Reading documents is extremely visible to the user (high on the y-axis).
- Search indexing is the opposite: even though users depend on new documents being indexed for search, they generally have no visibility into the indexing process and often don't even know that you have a search index to begin with (low on the y-axis).

Although maps can get quite complex, those three concepts (components, x-axis, y-axis) are generally sufficient to allow you to decode one.

### Mapping evolution over time: arrows, pipelines, and overlays

In addition to mapping the current state, Wardley maps are also excellent for exploring how circumstances might change over time.

**Arrows indicating future change.** A second iteration of the knowledge-base map (Figure 15-2, "Mapping AI-enhanced document editing as the future state of document editing") uses a red arrow to indicate capabilities that are expected to change in the future. The updated map indicates that the current document-creation experience will be superseded by an AI-enhanced editing process. Critically, it also predicts that the AI-enhanced process will be *more* commoditized than the current authoring experience — perhaps because the enhancement will be driven by commoditized foundational models from providers like Anthropic and OpenAI.

The strategic implication that follows from this prediction: the only place left in the map for meaningful differentiation is in search indexing. Either the knowledge-base company needs to accept the implication that it will increasingly be a search company, or it needs to expand the set of user needs it serves to find a new avenue for differentiation.

**Pipelines.** Some maps show the evolution of a given capability using a *pipeline*: a box that describes a series of expected improvements in a capability over time (Figure 15-3, "A pipeline showing the evolution of document editing"). With a pipeline, instead of simply indicating that the authoring experience may be replaced by an AI-enhanced capability over time, the map expresses a sequence of steps: from the starting place of a typical editing experience, the next expected step is AI-assisted creation, and then finally AI-led creation, where the author only provides high-level direction to a machine-learning–powered agent.

**Overlays.** For completeness, some Wardley maps have an *overlay*: a box used to group capabilities or requirements together by some common denominator (Figure 15-4, "A map overlay showing which teams own which capabilities"). This usually happens to indicate the teams responsible for various capabilities, but the technique can be used to emphasize any interesting element of a map's topology.

Maps you encounter in the wild might appear significantly more complex than these initial examples, but they'll be composed of the same fundamental elements.

### More Wardley Mapping Resources (sidebar)

- *The Value Flywheel Effect* by David Anderson
- *Wardley Maps* by Simon Wardley on Medium, also available as a PDF
- *Learn Wardley Mapping* by Ben Mosior
- WardleyMaps.com's resources and @WardleyMaps on YouTube

## Tools for Wardley Mapping

Chapter 14 established that systems modeling has a serious tooling problem, which often prevents would-be adopters from developing their systems modeling practice. Fortunately, Wardley mapping doesn't suffer from that problem:

- You can simply print out a Wardley map and draw on it by hand.
- You can use OmniGraffle, Miro, Figma, or whatever diagramming tool you're already familiar with.
- More focused tools exist as well; Ben Mosior has pulled together an excellent writeup on Wardley mapping tools as of 2024.

Larson's strong recommendation: start with **Mapkeep**, a simple, free, and intuitive tool for your initial mapping needs. After you've gotten some practice, you may want to move back into your familiar diagramming tool to make it easier to collaborate with colleagues. Initially, though, prioritize the simplest tool you can, to avoid losing learning momentum as you deal with configuration, setup, and so on.

## When Are Wardley Maps Useful?

All successful strategy begins with understanding the constraints and circumstances within which the strategy needs to work. Wardley mapping labels that understanding as *situational awareness*, and creating situational awareness is the foremost goal of mapping.

Situational awareness is always useful, but it's particularly essential in highly dynamic environments — where the industry around you, the competitors you're selling against, and/or the capabilities powering your product are shifting rapidly. The past several decades have included a number of these dynamic contexts:

- The rise of web applications
- The proliferation of mobile devices
- The expansion of machine learning techniques

When you're in such environments, it's obvious that the world is changing rapidly. What's sometimes easy to miss is the subtler case: any strategy that needs to last longer than a year or two is built on an evolving foundation, *even if things seem very stable at the time*. The chapter's example: in the early 2010s, startups like Facebook, Uber, and Digg were all operating in physical datacenters with their own hardware. Over the next five years, as cloud-based infrastructure rapidly expanded, having a presence in a physical datacenter went from the default approach for startups to a relatively unconventional solution. Any strategy written in 2010 that imagined the world of hosting as static was destined to be invalidated.

The limits: no tool is universally effective, and that's true here as well. While Wardley maps are extremely helpful at helping people understand broad change, they're less helpful in the details. If you're looping to optimize your onboarding funnel, then something like systems modeling or strategy testing is likely going to serve you better.

## How to Wardley Map

Learning Wardley mapping is a mix of reading others' maps and writing your own. Larson recommends skimming all of the maps collected in the chapter's "Breadcrumbs" section as well. This section gives the concrete steps he encourages you to follow as you create your first map:

**Step 1. Commit to starting small and iterating.**
Simple maps are the foundations of complex maps. Even the smallest Wardley map will have enough detail to reveal something interesting about the environment you're operating in. Conversely, if your map is complex from the start, it's easy to get caught up in all of its imperfections. At worst, this will cause you to lose momentum in creating the map; at best, it will accidentally steer your attention rather than facilitating discovery of which details are important to focus on.

**Step 2. List users, needs, and capabilities.**
Identify the first one or two users for your product by function. In the knowledge management example, your two initial users might be an author and a reader. From there, identify those users' needs, such as authoring content, finding content, and providing feedback on which content is helpful. Finally, write down the underlying technical capabilities necessary to support those needs, like indexing content in a search index or creating a customer-support process to deal with frustrated users.

Remember to start small: on your first pass, it's fine to focus on a single user. As you iterate on your map, bring in more users, needs, and capabilities until the map conveys something useful. Tooling for this step can be a piece of paper or wherever you keep notes.

**Step 3. Establish value chains.**
Take your list and connect each of the components into chains, from user to need to capability. For example, you'd connect the reader of the knowledge-base example to the need to discover content; then you could connect that need to the capability to index for search. That sequence — from reader, to discovering content, to search index — represents one value chain.

Convergence across chains is a good thing. As your chains get more comprehensive, any given capability is likely to be referenced by multiple different needs. Similarly, it's expected that multiple users might have a shared need.

**Step 4. Plot your value chains on a Wardley map.**
You can do this using any of the tools discussed in the "Tools for Wardley Mapping" section, including a piece of paper. Because you have already created the value chains, what you're focused on in this step is placing each component relative to its visibility to users and its maturity: higher up is more visible to the user, lower down is less visible; leftward represents more custom solutions, rightward represents most commoditized solutions.

**Step 5. Study the current state of the map.**
With the value chains plotted, your map will begin to reveal where your organization's attention should be focused and what complexity you can delegate to vendors. Jot down any realizations you have as you study this topology.

**Step 6. Predict how the map will evolve.**
Create a second version of your map that includes your predicted changes. Keep the previous version so you can better see the evolution of your thinking.

It can be helpful to create multiple maps that contemplate different scenarios. Thinking about the knowledge-base example: you might first contemplate a future where AI-powered tools become the dominant mechanism for authors creating content; then you could explore another future where AI has been regulated out of most tools, and imagine how that would shape your approach differently.

Your time frame for these changes will vary, depending on the environment you're mapping. Always prefer a time frame that makes it easy to believe the changes will happen — whether that's five years or one. If you're caught up wondering whether change might take longer than a certain time frame, simply extend your time frame to sidestep that issue.

**Step 7. Study the future state of the map.**
Now that you've predicted the future, study this new map. Write down any unexpected implications of this evolution, and note how you may need to adjust your approach as a result.

**Step 8. Share the map with others for feedback.**
It's impossible for anyone to know everything, which is why the best maps tend to be communal creations. That's not to suggest that you should perform every step in a broad community, or that your map should be the consensus of a working group. Instead, you should test your map against other people: see what they find insightful and what they find artificial in it, and include that in your map's topology.

**Step 9. Document what you've learned.**
This is discussed in the later documentation section. You should also connect your Wardley map writeup with your overall strategy document, typically in the Refine or Explore sections.

A closing caveat on the steps: one downside of presenting steps for doing something is that the sequence can become a fixed recipe. The method presented here is far from the canonical way. These are simply the steps Larson has found most useful, and he encourages you to try them if mapping is a new tool in your toolkit. Start here, then experiment with other approaches until you find the best approach for you and the strategies that you're working on.

## Breadcrumbs for Wardley Map Examples

With the foundation in place, the best way to build on Wardley mapping is to write your own maps. The second-best way is to read existing maps that others have made, a number of which exist within Part IV of this book. For instance, Chapter 17 studies the evolution of the LLM ecosystem, and how that will impact product engineering organizations attempting to validate and deploy new paradigms like agentic workflows and retrieval augmented generation.

In addition to the maps within this book, Larson also labels maps he created on his blog using the Wardley category. For example, the post "Measuring developer experience, benchmarks, and providing a theory of improvement" explores how Wardley mapping has helped him refine his understanding of how the developer experience ecosystem will evolve over time.

## How to Document a Wardley Map

As explored in Chapter 11, it's always tempting to structure documents around the creation process. However, it's essentially always better to write in two steps: first develop a *writing-optimized* version that's focused on facilitating your thinking; then rework it into a *reading-optimized* version that supports both readers who are interested in the details and those who are not.

The nine-step process in the previous section is the writing-optimized version. For a reading-optimized version, Larson recommends three sections, in this order:

1. **How things work today.**
   This section should begin with a map of the current environment, explain any interesting rationales or controversies behind placements on the map, and highlight the most interesting parts.

2. **Transition to future state.**
   This section should start with a second map showing the transition from the current state to a projected future state. It's very reasonable to have multiple distinct maps, each of which considers one potential evolution or one step of a longer evolution.

3. **Users and value chains.**
   Users and value chains are the first place you start when *creating* a Wardley map, but generally the least interesting part of *explaining* that map's implications. This isn't because the value chains are unimportant — it's because the map itself tends to implicitly explain the value chain enough that you can move directly to focusing on the map's most interesting implications.

   For a sufficiently complex map, you could certainly split users and value chains into two sections, but generally, covering users and value chains in one joint section rather than separately eliminates redundancy. This is a good example of the difference between reading and writing: splitting these two topics helps writers clarify their thinking, but muddles the experience of reading.

Why this ordering works: it may seem too brief or a bit counterintuitive to you, as the person who has the full set of details, but Larson's experience is that it will be simpler to read for most readers. That's because most readers read until they agree with the conclusion, then stop reading, and are only interested in the details if they disagree with the conclusion.

This format is also fairly different from the format recommended for documenting systems models. The reason: systems model diagrams exclude much of the relevant detail — they show the relationship between stocks but not the magnitude of the flows. You can only fully understand a systems model by seeing both the diagram and a chart showing the model's output. Wardley maps, on the other hand, tend to be more self-explanatory, and often can stand on their own with relatively less written description.

## What About Doctrines and Gameplay?

This book's components of strategy, as laid out in Chapter 5, are most heavily influenced by Richard Rumelt's approach. Simon Wardley's approach to strategy, built around Wardley mapping, could be viewed as a competing lens: for each problem that Rumelt's system solves, there is a Wardley solution as well. So it's worth mentioning some of the components the book hasn't included and why they were left out.

The two most important components not discussed thus far are Wardley's ideas of *doctrine* and *gameplay*:

- **Doctrine**, as Wardley uses it, refers to universally applicable practices, such as: knowing your users, biasing toward data, and designing for constant evolution.
- **Gameplay** is similar to doctrine, but context-dependent rather than universal. Some examples of gameplay: talent raiding (hiring from knowledgeable competitors), bundling (selling products together rather than separately), and exploiting network effects.

Larson decided not to spend much time on doctrine and gameplay because he finds them lightly specialized for the needs of business strategy, and consequently a bit messy to apply to the engineering strategy problems that this book is most interested in solving.

He doesn't personally view Rumelt's approach and Wardley's approach as competing efforts. What's most valuable is to have a broad toolkit and pull in the tools that feel most applicable to the problems at hand:

- Wardley maps are exceptionally valuable for enhancing exploration, diagnosis, and refinement in some problems.
- In other problems — typically those that are of a shorter duration or more internally oriented — the Rumelt playbook is more applicable.
- In all problems, the combination is more valuable than anchoring in one camp's perspective.

## Summary

No refinement technique will let you reliably predict the future, but Wardley mapping is very effective at helping you plot out the various potential futures in which your strategy might need to operate. With those futures in mind, you can tune your strategy to excel in those that are most likely, and to weather the less desirable ones.

It took Larson years to dive into Wardley mapping. Once he finally did, it was simpler than he'd feared, and he now finds himself creating Wardley maps somewhat frequently. The next time you're working on a strategy that's impacted by the ecosystem evolving around it, try your hand at mapping — and soon you'll start to build your own collection of maps.
