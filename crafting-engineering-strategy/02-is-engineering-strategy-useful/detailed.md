# Chapter 2: Is Engineering Strategy Useful? — Detailed Reference

## Introduction

Larson frequently hears engineers bemoan a missing strategy, but their complaints rarely articulate *why* the missing strategy matters. Instead the complaint functions as a truism, in the same family as "the economy used to be better" and "children used to respect their parents": engineering organizations used to have an engineering strategy.

The chapter opens from a position Larson holds quite strongly: **there is always an engineering strategy, even if there's nothing written down.** From that starting point, it argues why strategy—especially *written* strategy—is such a valuable opportunity for organizations that take it seriously.

The chapter's stated agenda:

- Why there's always a strategy, even when people say there isn't
- How strategies have changed companies Larson has encountered
- How inappropriate strategies create significant organizational pain without much compensating benefit
- How written strategy drives organizational learning
- The costs of not writing strategy down
- How strategy supports personal learning and development, even when you're not empowered to "do strategy" yourself

The chapter's goal: by its end, the reader should agree that strategy is an undertaking worth investing your time in—and your organization's.

## There's Always a Strategy

Every company Larson has worked in has had at least one engineer who felt the company didn't have an engineering strategy. Once Larson became an executive and could document and distribute an engineering strategy himself, the complaints about missing strategy didn't go away—they simply shifted to focus on a missing *product* or *company* strategy. The complaint is persistent and migratory, not evidence of an actual absence.

This happened even at companies that definitively had engineering strategies, such as the payment provider Stripe. When Larson joined Stripe in 2016, it had a clear engineering strategy with numerous guiding policies, including:

- **Maintain backwards API compatibility, at almost any cost.** Example of the boundary: force an upgrade from TLS 1.2 to TLS 1.3 to retain PCI compliance, but don't force upgrades from the `/v1/charges` endpoint to the `/v1/payment_intents` endpoint.
- **Work in Ruby within a monorepo**, unless it's the PCI environment, data processing, or data science work.
- **Engineers are fully responsible for the usability of their work**, even when product or engineering managers are involved.

Larson found it generally clear what Stripe's engineering strategy was on any given topic—even if finding it sometimes required asking around. Over time, however, certain decisions became sufficiently contentious that it became hard to definitively answer what the strategy was. For example, the question of whether to adopt Ruby or Java became contentious enough that Larson distributed a strategy document attempting to mediate the disagreement. It wasn't a particularly successful effort, for reasons obvious in hindsight—particularly the lack of any enforcement mechanism.

Larson cites William Gibson: "The future is already here—it's just not very evenly distributed." In the same sense, there is always a strategy embedded in an organization's decisions—even if that strategy is only visible to a small group and is quickly forgotten.

Larson has simply never found an organization with no engineering strategy at all. His advice if you find yourself thinking your organization doesn't have one: seek out where the strategy might live *in practice*, even if it isn't codified in documentation. The operational rule: **whatever you find practitioners doing is their strategy.** Repeated decisions are always made according to some rule or set of rules—"even if the only rule is a powerful disregard for prior decisions."

## Strategy Changes Companies

In Chapter 21, Larson discusses the meditation app **Calm's** engineering strategy to address pervasive friction within its engineering team. The core of that strategy was clarifying how Calm makes major technology decisions, along with documenting the motivating goal steering those decisions: **maximize the time and energy Calm spent on creating its product rather than on investing in platform changes.**

The strategy eliminated the cause of ongoing friction by:

- Increasing the burden of proof required to adopt new technologies
- Canceling a planned service decomposition
- Narrowing innovation efforts to those that directly improved the product

It was successful in resetting the team's focus. It also caused several engineers to leave the company, because experimenting with new technologies was more important to them than making progress on Calm's product. A clear, documented strategy made it clear to everyone involved what sort of game the team was playing and what the rules of that game were, so that for the first time they could make an *informed* decision about whether they wanted to play that game with the wider team. (Implication: the departures were a consequence of the alignment the strategy created, not a defect of it.)

Creating alignment is one of the ways strategy makes an impact, but certainly not the only one. Other ways strategies support organizations:

- **Concentrating company investment into a smaller space.** For example, deciding *not* to decompose a monolith (see Chapter 20) allows you to invest the majority of your tooling efforts into one language, one test suite, and one deployment mechanism.
- **Making many interesting properties only available through universal adoption.** Moving to an "N-1 policy" on backfilled roles (discussed in Document 18-2) is a significant opportunity for managing costs, but it only works if it's consistently adopted. As another example, many strategies for disaster recovery and multiregion availability are only viable if *all* infrastructure has a common configuration mechanism.
- **Focusing execution on what truly matters.** Stripe's Sorbet strategy (Document 22-3) allowed a team of 10 engineers to push the company's Ruby monolith toward static typing incrementally, without distracting the larger organization. This was a difficult project that could have consumed the entire organization for many months; the focus allowed a small team to accomplish the majority of the early work.
- **Creating a knowledge repository of how your organization thinks.** Onboarding new hires—particularly senior new hires—is much more effective with a documented strategy. For example, the strategy for accessing user data (Document 19-1) requires that all access to user data must be supported by a clear, user-understandable rationale. While this might be obvious to new hires coming from larger companies, people with only small-company experience are likely to be completely unaware that such a rule is even necessary. If the rule isn't documented, compliance with the policy will quickly decline.

There are some things that a strategy—even a cleverly written one—cannot do. It cannot:

- Guarantee business growth
- Hire a particular individual
- Guarantee that lobbying will change an existing legal framework like the General Data Protection Regulation (GDPR)

However, Larson's experience has always been that developing a strategy creates progress, **even if that progress consists of understanding the inherent disagreement.**

## Inappropriate Strategy Is Especially Impactful

While good strategy can accomplish many things, it sometimes feels like inappropriate strategy is far more impactful—in all the wrong ways.

**Digg V4** remains the worst-considered strategy Larson has personally participated in. It involved:

- Completely rewriting the Digg V3.5 codebase from a PHP monolith into a PHP frontend and a backend composed of a dozen Python services
- Moving the database from sharded MySQL to an early version of Cassandra
- Perhaps worst of all, replacing the nuanced algorithms developed over a decade with a hack implemented a few days before launch

Digg would likely have struggled to become profitable anyway: it relied on search engine optimization for traffic, and in that era Google's search algorithm changed frequently. However, the engineering strategy ensured that Digg *died quickly*, closing off any opportunity to rebuild before the money ran out.

Importantly, this isn't just about Digg. Almost every engineering organization you drill into will have its share of unused platform projects that captured decades of engineering-years, to the detriment of an important opportunity. A shocking number of senior leaders join new companies and initiate a grand migration that attempts to entirely rewrite the architecture, switch programming languages, or otherwise shift their new organization to resemble a prior organization where they understood things better.

### Sidebar: Inappropriate Versus Bad

When Larson first wrote this section, he labeled this sort of strategy as "bad." The problem with that term is that the same strategy might well have been very effective in a different set of circumstances. For example, if Digg had been a three-person company with no revenue, rewriting from scratch could have been the right decision.

He has therefore tried to favor the term **inappropriate** rather than *bad*, to avoid getting caught up in whether a given approach might work in other circumstances. **Every approach undoubtedly works in some organization.** (The judgment is always relative to circumstances, never absolute.)

## Written Strategy Drives Organizational Learning

When Larson joined **Carta**, he noticed an inconsistent approach to a number of important problems:

- Teams had distinct "standard kits" that defined which technologies could be used in new projects.
- The company was inconsistent about adopting existing internal platforms and about funding new ones.
- There was widespread agreement that Carta was in the process of decomposing its monolith, but no agreement on *how* it was doing it.

Carta was a **permissive strategy environment**: there was explicit guidance, but individual teams were allowed to interpret that guidance according to their own beliefs. Over time, the variation in interpretation across teams resulted in many strongly differing perspectives on the ideal path forward.

One of Larson's first projects was therefore writing down an explicit engineering strategy along with the newly formed **Navigators** team—itself a part of Carta's new engineering strategy. The Navigators program explicitly named individuals as technical leaders who would represent key parts of the engineering organization in a small leadership group of about **10 engineers**. This group made it possible to iterate on strategy without taking on the impossible task of negotiating with **400 engineers** directly.

The writing process and its learning loop:

1. The process of writing the strategy made it possible to describe the observed problems explicitly and discuss how the organization wanted to navigate them.
2. They could iterate on the strategy within the small group.
3. Then they shared the artifact widely for feedback from teams the small group might have missed.
4. They talked about it frequently in engineering all-hands meetings.
5. They came back to it each year—or whenever things stopped making much sense—and revised it.

Example of revision in practice: the initial strategy didn't talk about artificial intelligence (AI) at all. A few months later, they extended it to mention a very conservative approach to using large language models (LLMs). They recently revised the AI portion again, as the team dives deeply into agentic workflows.

A lot of people have disagreed with parts of the strategy, which Larson considers great: **making it possible to disagree more precisely is one of the key benefits of having a written strategy.** From those disagreements, they've been able to evolve the strategy—sometimes in response to new information (like the current rapid evolution of AI practices), and other times to improve the initial approach (like changing how members were selected for the Navigators team over time).

New hires can disagree too, and when strategy is written down, they can do so from an informed place rather than coming across as too attached to their prior company's practices. In particular, they can understand the thinking that motivated past decisions, even when that context is no longer obvious. Concrete example: when Carta paused the decomposition of its monolith, there was significant friction in service provisioning—but since that's far less true today, the decision might now seem a bit arbitrary. Only a written document can consistently communicate that context across a growing, shifting organization.

The underlying principle: with **oral history**, what you believe about the past and the present depends heavily on who you talk with. With **written history**, it's far more possible to agree at scale—which is a prerequisite for *growing* at scale, rather than isolating growth within small pockets of senior leadership.

## Implicit Strategy Comes at a Cost

Larson's emphasis on written strategy (Chapter 11 is devoted entirely to it) isn't just because of the positives written strategy creates, but also because of the damage *unwritten* strategy does. When your strategy isn't written down:

### It's vulnerable to misinterpretation

In organizations that rely foremost on verbal communication, information flow depends on an individual being in a given room for a decision, then accurately repeating that information to others who need it. However, those individuals often fail to repeat the information at all, or they repeat it incorrectly to some degree. Both failures create significant problems.

#### Sidebar: Two-Headed Organizations

Some years ago, Larson shifted toward a model where most engineering organizations he worked with had **two leaders: a manager and a senior engineer**. This was partially to ensure that engineering context would be included in decision making at the senior level, but it was also intended to **reduce communication errors**. Having two leaders where one might be sufficient sounds like an expensive investment—and it is—but Larson has always found it worth the price.

Errors in one-to-one communication are so prevalent, and the cost of communication errors is so high, that Larson now structures organizations and communication mechanisms to ensure he always conveys important updates (like those related to strategy) to **at least two people in each area of the organization**.

### It creates inconsistency across teams

At one company Larson worked in, promotions to Staff-plus roles happened at a much higher rate in the infrastructure engineering organization than in the product engineering team. This created a constant drain on product engineering to work on infrastructure-shaped problems, even when those problems weren't particularly valuable to the business.

New leaders had no idea that this informal policy of preferring infrastructure work for Staff-plus promotions existed, and they would routinely run into trouble in calibration discussions. They also weren't aware they needed to go argue for a better policy. Worse, no one was sure whether this was a *real* policy or not, so whether the preference for infrastructure work was represented in any given promotion was ultimately random. Sometimes good promotions would be blocked; sometimes borderline cases would be approved.

### It creates inconsistency over time

Implementing a new policy tends to be a mix of **persistent and one-time actions**. Worked example: suppose you want to standardize all HTTP operations on the same library across your codebase, to avoid dealing with the nuances of error handling across numerous HTTP clients. You add a linter check to reject known alternatives (persistent action) and do a one-time pass across your codebase to standardize on that library (one-time action).

However, two years later, there are another three random HTTP libraries in your codebase, creeping into the cracks surrounding your linting. If the standardization policy is written down and a few people have read it, there are a number of ways this drift could be prevented. If it's not written down, it's much less likely anyone will remember the policy—let alone the rationale—well enough to argue about it.

### It poses a hazard to new leaders

When a new Staff-plus engineer or executive joins a company, it's common for the current team to blame them for failing to understand the existing context behind past decisions. That's fair: a big part of senior leadership is uncovering and understanding context. It's also unfair: explicit documentation of the thinking that led to the prior decision would make this much easier for them.

Every particularly bad new-leader onboarding Larson has seen has involved a new leader coming into an unfilled role that the new leader's manager didn't know how to do. These leaders' success depended entirely on their learning ability (and interest).

### Documentation as succession planning

The practice of documenting strategy has a lot in common with succession planning: the full benefits accrue to the *organization* rather than to the individual doing the planning. It's possible to maintain the status quo while the original authors are present, but appreciating the value of documentation requires stepping outside yourself for a moment to consider what will matter most to the organization when you're no longer a member.

### Sidebar: Information Herd Immunity

A frequent objection to writing strategy down is that "no one reads anything." There's some truth to this: it's extremely hard to get everyone in an organization to know something. However, Larson has never found that goal to be particularly important.

He views information dispersal in an organization as being a lot like **herd immunity**: you don't need *everyone* to know something; you just need *enough* people to know it that any confusion doesn't propagate too far.

It may be impossible for all engineers to know the details of your strategy, but you certainly can make sure **every Staff-plus engineer and engineering manager** knows them.

## Writing Strategy Supports Personal Learning

While Larson believes the biggest beneficiary of written strategy is the organization, he also believes that creating strategy is an **underrated avenue for individual self-development**—even when you're not empowered to "do strategy" yourself.

The ways he has seen strategy support personal development:

- **Building self-awareness.** Larson has worked with several engineers who viewed themselves as extremely senior but frequently demanded that projects be implemented using new programming languages or technologies because they personally wanted to learn that technology. Their internal strategy was clear—they wanted to work on something fun—but following the steps to build an engineering strategy (discussed in Chapter 5) would have produced a strategy that *even they* agreed didn't make sense. (Writing forces hidden, self-serving motivations into the open.)
- **Supporting situational awareness in new environments.** Wardley mapping (covered in Chapter 15) talks a lot about situational awareness as a prerequisite to good strategy. This is about ensuring you understand the realities of your circumstances—the lack of which is **the most destructive failure of new senior engineering leaders**. If you explicitly state the diagnosis to which a strategy should be applied, it's easier to see why reusing a prior strategy in a new team or company might not work.
- **Serving as your personal archive.** Just as documented strategy is institutional memory, it also serves as *personal* memory, helping you understand the impact of your prior approaches. Each of us is an archivist of our prior work, pulling out the most valuable pieces to address the problem at hand. Over a long career, memory fades—and motivated reasoning creeps in—but explicit documentation persists.

Indeed, part of the reason Larson started working on this book *now* rather than later is that he realized he was starting to forget the details of the strategy work he did earlier in his career. To preserve the wisdom of that era and ensure he didn't have to relearn the same lessons in the future, he had to write it now.

## Summary

The chapter covered why strategy can be a valuable learning mechanism for both your engineering organization and for you personally. It showed how strategies have helped organizations deal with service migrations, monolith decomposition, and right-sizing backfilling. It also discussed how inappropriate strategy contributed to Digg's demise.

If Larson had to pick two things to emphasize as the chapter ends, it would be two themes he finds are frequently ignored:

- **There's always a strategy, even if it isn't written down.**
- **The single biggest action you can take to further strategy in your organization is to write strategy down**, so that the organization can debate it, agree upon it, and explicitly evolve its approach.

Discussions around topics like strategy often get caught up in high-prestige activities like making controversial decisions, but the most effective strategists Larson has seen make more progress by actually performing the basics:

- Writing things down
- Exploring widely to see how other companies solve the same problem
- Incorporating feedback into their draft from people who disagree with them

Strategy is useful—and *doing* strategy can be simple, too.
