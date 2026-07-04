# Chapter 15: Wardley Maps

This chapter teaches Wardley mapping as a strategy-refinement technique for "zooming out": understanding the broader ecosystem your organization operates in and how it will evolve. Where systems thinking and strategy testing often zoom in on details, Wardley maps build **situational awareness** — a grounded view of your constraints and circumstances. The single most important takeaway: any strategy that needs to last more than a year or two is built on an evolving foundation, even when things look stable, and Wardley maps are very effective for plotting the potential futures your strategy must survive, so you can tune it to excel in the likely ones and weather the rest.

Of the three core strategy-refinement techniques, this is the one Larson has personally used the least — he includes it to show how many different techniques can refine strategy and that it's never too late to keep expanding your toolkit. It took him years to try mapping; once he did, it was simpler than he'd feared, and he now maps somewhat frequently.

## Core ideas

### What a Wardley map is and why it exists

A Wardley map (created by Simon Wardley in 2005) is a technique to ensure your strategy is grounded in reality — what practitioners call creating **situational awareness**. All successful strategy begins with understanding the constraints and circumstances within which the strategy needs to work; creating that situational awareness is the foremost goal of mapping. Unlike most refinement tools, it is remarkably effective at zooming out to ecosystem-level dynamics rather than zooming in on internal details.

### The three foundational concepts for reading a map

Although maps can get quite complex, three concepts are generally sufficient to decode one:

**1. Components: users, needs, capabilities.**
- *Users* sit at the top and represent a cohort who will use your product.
- Each user has *needs* — generally tasks they need to accomplish. Any box connecting directly to a user is a need.
- Fulfilling each need requires *capabilities*. Any box connecting to a need is a capability. A capability can connect to any number of needs but can **never connect directly to a user** — only indirectly, via needs.

**2. X-axis: evolution / commoditization.** Four segments, left to right:
- *Genesis* — a brand-new capability that hasn't existed before.
- *Custom* — requires specialized expertise and operation to function (e.g., a web application that needs software engineers to build and maintain).
- *Product* — something that can generally be bought.
- *Commodity* — so standard and expected it's unremarkable, like flipping a switch and electricity flowing.

Most items on a map fall in custom or product. Example: in a knowledge-base (wiki) product, document reading is commoditized — it's unremarkable that users can read content — while document editing sits on the custom/product border because you might build it or buy it.

**3. Y-axis: visibility to the user.** Higher means more visible (reading documents is extremely user-visible); lower means less visible (users depend on search indexing but generally have no visibility into the indexing process and often don't even know an index exists).

### Mapping evolution over time

Maps are excellent not just for current state but for exploring how circumstances might change. Conventions:
- An **arrow** marks a capability expected to change (e.g., move rightward toward commodity).
- A **pipeline** is a box describing a series of expected improvements in a capability over time — a sequence of steps rather than one jump (e.g., typical editing → AI-assisted creation → AI-led creation).
- An **overlay** is a box grouping capabilities by a common denominator — usually team ownership, but usable to emphasize any interesting element of the map's topology.

The strategic payoff of evolution mapping: when a capability you differentiate on commoditizes, the map shows where remaining differentiation lives — and forces a choice between accepting that implication or expanding the user needs you serve to find a new avenue for differentiation.

### When Wardley maps are the right tool — and when not

Situational awareness is always useful but **particularly essential in highly dynamic environments**, where the industry, competitors, or capabilities powering your product are shifting rapidly (historic examples: the rise of web applications, mobile proliferation, machine learning expansion).

The subtler case: even in seemingly stable environments, any strategy lasting longer than a year or two sits on an evolving foundation. A hosting strategy written in 2010 that treated physical datacenters as static was destined to be invalidated by the cloud shift within five years.

The limit: Wardley maps help people understand **broad change** but are less helpful in the details. For detail-level optimization (e.g., iterating on an onboarding funnel), systems modeling or strategy testing will likely serve better.

### Tooling

Wardley mapping has no tooling problem (unlike systems modeling, Chapter 14). Paper works; so does any diagramming tool (OmniGraffle, Miro, Figma). Larson strongly recommends starting with **Mapkeep** — simple, free, intuitive; after some practice you may want to move back to your familiar diagramming tool for collaboration. The principle: prioritize the simplest tool to avoid losing learning momentum to configuration and setup. For a survey of more focused tools, Ben Mosior maintains a writeup on Wardley mapping tools (as of 2024).

### Documenting a map: write for readers, not for your process

Don't structure the document around your creation process. Write in two steps: first a **writing-optimized** version that facilitates your thinking (the nine-step process below), then rework it into a **reading-optimized** version. The recommended reading structure has three sections, in this order:

1. **How things work today** — open with the current-state map, explain interesting rationales or controversies behind placements, highlight the most interesting parts.
2. **Transition to future state** — a second map showing the transition; multiple maps are fine, each covering one potential evolution or one step of a longer evolution.
3. **Users and value chains** — last, even though it's where creation starts, because the map itself implicitly explains the value chains well enough that readers can go straight to the interesting implications. Generally, cover users and value chains jointly rather than as separate sections to eliminate redundancy (a sufficiently complex map can justify splitting them).

Why this ordering: most readers read until they agree with the conclusion, then stop; they only want details if they disagree. The format differs from systems-model documentation because Wardley maps tend to be more self-explanatory and often can stand on their own with relatively less written description, whereas a systems model diagram omits flow magnitudes and needs an accompanying output chart to be understood.

### Doctrine and gameplay (Wardley's broader system) — and why they're omitted

Wardley's full approach is a complete strategy system that could be viewed as competing with Rumelt's (which structures this book). Two components Larson deliberately leaves out:
- **Doctrine**: universally applicable practices — knowing your users, biasing toward data, designing for constant evolution.
- **Gameplay**: context-dependent moves rather than universal ones — talent raiding (hiring from knowledgeable competitors), bundling (selling products together), exploiting network effects.

He omits them because he finds them lightly specialized for the needs of business strategy and consequently a bit messy to apply to engineering strategy problems. The deeper stance: Rumelt and Wardley are not competing camps. Keep a broad toolkit and pull the tool that fits — Wardley maps excel at enhancing exploration, diagnosis, and refinement for ecosystem-driven problems; Rumelt's playbook fits shorter-duration or more internally oriented problems; the combination beats anchoring in either camp.

## Actionable guidance

The nine-step mapping process (Larson's, not canonical — start here, then experiment):

1. **Commit to starting small and iterating.** Simple maps are the foundations of complex maps; even the smallest map reveals something interesting. A complex first map traps you in its imperfections — at worst killing momentum, at best steering attention instead of facilitating discovery of what matters.
2. **List users, needs, and capabilities.** Identify one or two users by function (e.g., author, reader). List their needs (authoring content, finding content, giving feedback). Then list the technical capabilities supporting those needs (search indexing, customer-support process). A single user is fine on the first pass; paper or a notes app is fine for tooling.
3. **Establish value chains.** Connect components into chains from user → need → capability (reader → discover content → search index). Convergence is a good sign: as chains get comprehensive, expect capabilities referenced by multiple needs and needs shared by multiple users.
4. **Plot the value chains on the map.** Place each component by user visibility (vertical) and maturity (horizontal): higher = more visible, leftward = more custom, rightward = more commoditized.
5. **Study the current state.** The topology reveals where your organization's attention should focus and what complexity you can delegate to vendors. Jot down realizations as you go.
6. **Predict how the map will evolve.** Create a second map with predicted changes; keep the previous version to see the evolution of your thinking. It can be helpful to create multiple maps for different scenarios (e.g., AI dominates authoring vs. AI is regulated out of most tools). Pick a time frame that makes the changes easy to believe — if you're stuck wondering whether change might take longer, simply extend the time frame to sidestep the debate.
7. **Study the future state.** Write down unexpected implications and how your approach must adjust.
8. **Share the map for feedback.** No one knows everything; the best maps tend to be communal creations. This doesn't mean mapping by committee or seeking working-group consensus — test the map against others, note what they find insightful versus artificial, and fold that into the topology.
9. **Document what you've learned** and connect the writeup to your overall strategy document, typically in the Refine or Explore sections.

Additional decision rules:
- Reach for Wardley maps when the strategy is impacted by an evolving ecosystem; reach for systems modeling or strategy testing when optimizing internal details.
- Learn by both reading others' maps and writing your own; the best way to build skill is writing, the second-best is reading existing maps.
- Start with the simplest tool available (Mapkeep or paper) and only graduate to collaborative tooling after you have practice.

## Pitfalls and misconceptions

- **Assuming stability.** The easy-to-miss failure: treating the foundation as static because it seems stable today. Strategies outliving a year or two always sit on shifting ground.
- **Starting complex.** A detailed first map costs momentum and hijacks attention away from discovering which details actually matter.
- **Connecting capabilities directly to users.** Structurally invalid — capabilities reach users only through needs.
- **Documenting in creation order.** Tempting but reader-hostile; the writing-optimized sequence muddles reading. Lead with the current-state map and conclusions, put users/value chains last.
- **Treating the nine steps as a fixed recipe.** It's one practitioner's method, not the canonical way; experiment toward what fits your strategies.
- **Expecting prediction.** No refinement technique reliably predicts the future. Maps plot the *potential* futures so you can tune strategy to excel in the likely ones and weather the undesirable ones.
- **Camp loyalty.** Treating Rumelt vs. Wardley as a contest wastes both; combine the toolkits per problem.
- **Tool fiddling.** Losing learning momentum to configuration and setup of sophisticated tooling before you've built the practice.
