# Chapter 25: Strategy Resources

This appendix is an annotated reading list for going deeper on engineering strategy. Larson's framing problem: engineering strategy is hard to learn because "so much is kept private" — most real strategies never get published. The single most important takeaway: a small set of public resources can substitute for that missing corpus, and the most helpful book among them is Richard Rumelt's *Good Strategy, Bad Strategy*, which Larson calls "the most helpful strategy book that I have ever read, because it actually provides a usable definition of strategy."

## Core ideas

### Public strategy material is scarce, so curate deliberately

Every discussion of engineering strategy includes "a weary remark about how few strategies are publicly documented." The why: so much of this material is kept private, so learners cannot simply read a library of real examples. The remedy is to assemble the few genuine public case studies plus the best general-strategy books, and to expect the set to keep growing ("by the time you read this, many more excellent writeups will exist").

### Strategy is "mapping plus guiding policies" — and that widens what counts as a strategy book

Larson notes his definition of strategy has evolved to "mapping plus guiding policies." This reframing changes which books qualify: *The Phoenix Project* (a retelling of Goldratt's *The Goal*), which he previously would not have considered a strategy book, now reads as a demonstration of a useful **mapping strategy** — modeling and resolving problems via constraint optimization. The why: if exploration/mapping is half of strategy, then any rigorous technique for modeling a system (constraint theory, systems thinking, Wardley mapping) is strategy tooling, even when the source never uses the word "strategy."

### Two paths into strategy work, depending on your authority

Larson's own prior writing splits the topic by role:

- **"Writing an engineering strategy"** (in *The Engineering Executive's Primer*) — setting engineering strategy **as an executive**, i.e., with positional authority.
- **"Write five, then synthesize"** (in *Staff Engineer*) — driving engineering strategy **without executive authority**, primarily through documentation.

The why: the mechanics of strategy creation differ fundamentally based on whether you can mandate adherence or must earn it through written influence.

### The mapping toolkit: multiple complementary lenses

The recommended books collectively supply distinct mapping/exploration tools:

- **Wardley mapping** — *Wardley Maps* (Simon Wardley) explains how to use the maps "to understand and improve strategy"; *The Value Flywheel Effect* introduces them through Liberty Mutual's serverless rationale.
- **Systems thinking** — *Thinking in Systems* (Donella Meadows) provides "a useful mapping mechanism" applicable to software even though it is not a software book; for a long time it was Larson's sole mapping tool.
- **Constraint optimization** — *The Phoenix Project* / *The Goal* show how to model and resolve problems by finding and managing constraints.

The why: no single modeling lens fits every problem; strategists should hold several.

### Evaluating guiding policies with benchmarking

*How Big Things Get Done* (Flyvbjerg and Gardner) examines why some megaprojects fail resoundingly while others finish under budget and ahead of schedule. It connects to many strategy-adjacent topics; the one Larson names is that **benchmarking can help evaluate guiding policies within a strategy**.

### Rumelt as the structural backbone

- *Good Strategy, Bad Strategy* — the most helpful strategy book Larson has ever read, because it actually provides a usable definition of strategy. Per the comparison with *The Crux*, it is the more structurally focused of the two on documenting strategies.
- *The Crux* — oriented on **how to create strategies and why strategy creation often fails**; it is "less structurally focused on documenting strategies" than its predecessor. Read it for the creation process rather than the document format.

### Engineering-strategy-specific books fill different niches

- *Technology Strategy Patterns* (Eben Hewitt) — **method-focused**: how to create and communicate engineering strategy.
- *Architecture Modernization* (Nick Tune with Jean-Georges Perrin) — covers much the same ground as *Technology Strategy Patterns* and *The Value Flywheel Effect* but with **more recent examples and references**.
- *Enterprise Architecture as Strategy* (Ross, Weill, Robertson) — the evolution of software ("IT" in that era's vernacular) and maturity within businesses, and **deciding among strategies for coupling and integration across business units**; useful for multi-business-unit integration questions.

### Real strategies are often defined late — and that's normal

Anna Shipman's Financial Times writeup describes a tech strategy "that wasn't really defined until somewhat late in the lifecycle." Larson's gloss: "This is extremely common, even if we don't admit it." The why: this normalizes retrofitting strategy onto an existing system rather than treating late-defined strategy as failure.

### Strategies above and below the engineering altitude still teach

- **BoringTechnology.club** (Dan McKinley) offers a single **guiding principle** "that many engineering strategies include" — an example of how one policy can be reused across many strategies.
- The **GitLab strategy** is a company strategy, not an engineering strategy, but because GitLab is "a technology company that builds technology for technologists," reading it at "a slightly higher altitude" still informs engineering strategy work.

## Actionable guidance

- Start with Rumelt's *Good Strategy, Bad Strategy* to get a usable definition of strategy.
- Pick your entry point by role: read "Writing an engineering strategy" (*The Engineering Executive's Primer*) if you hold executive authority; read "Write five, then synthesize" (*Staff Engineer*) if you must drive strategy without authority, via documentation.
- Build a multi-lens mapping toolkit: learn Wardley mapping (*Wardley Maps*, *The Value Flywheel Effect*), systems thinking (*Thinking in Systems*), and constraint optimization (*The Phoenix Project* / *The Goal*).
- Use benchmarking, per *How Big Things Get Done*, to help evaluate guiding policies within a strategy.
- When you need creation process rather than document structure, read *The Crux*.
- For more recent examples and references on these topics, *Architecture Modernization* covers much the same ground as *Technology Strategy Patterns* and *The Value Flywheel Effect*.
- Study the public case studies as your stand-in for the private strategies you can't see: Stripe ("Magnitudes of Exploration"), Liberty Mutual plus A Cloud Guru, Workgrid, and BBC (*The Value Flywheel Effect*), Intercom ("Run Less Software"), Slack ("How Big Technical Changes Happen at Slack"), and the Financial Times ("The Difficult Teenage Years").
- Mine adjacent-altitude documents too: a reusable single principle (BoringTechnology.club) and a company-level strategy at a tech company (GitLab) both inform engineering strategy.
- Keep scanning for new writeups; the public corpus grows continuously.

## Pitfalls and misconceptions

- **Misconception: a strategy book must say "strategy" on the cover.** Books on constraint optimization or systems thinking become strategy tooling once you accept that mapping is half of strategy work.
- **Misconception: a strategy defined late in a system's lifecycle is a failure.** Late-defined strategy is "extremely common, even if we don't admit it" (the Financial Times case).
- **Misconception: scarce public examples means you can't learn from examples.** A workable case-study corpus exists; it just takes curation.
- **Warning: most general strategy books lack a usable definition.** Rumelt stands out precisely because most strategy writing does not give you something you can apply.
