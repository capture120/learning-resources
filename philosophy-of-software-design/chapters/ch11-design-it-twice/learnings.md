# Chapter 11: Design it Twice

## Central idea

Software design is hard, so your first idea for how to structure a module or system is unlikely to be the best one. For every major design decision, deliberately produce at least two radically different designs, compare them, and only then choose. The comparison itself — not just the winner — is where the value lies.

## Key concepts

- **Design it twice**: consider multiple distinct options for each major design decision before committing. Rough sketches are enough; you do not need to pin down every feature of each alternative, just the most important methods or structures.
- **Radically different alternatives**: alternatives should differ fundamentally, not be minor variations. You learn more from contrasting genuinely different approaches.
- **Pros-and-cons comparison**: after sketching alternatives, list each one's strengths and weaknesses against explicit criteria, then pick — or synthesize — the best design.
- **Level-specific evaluation criteria**: what counts as "best" differs by what you are designing:
  - For an **interface**: the most important criterion is ease of use for higher-level software. Secondary criteria: Is one interface simpler than another? Is one more general-purpose? Does one enable a more efficient implementation?
  - For an **implementation** (behind a fixed interface): the most important criteria are simplicity and performance.
- **Multi-level application**: apply the principle at every level of the system — first to pick a module's interface, again to pick its implementation, and also at higher levels such as choosing user-interface features or decomposing a system into major modules.

## Actionable principles

- Before committing to any major design decision, sketch at least two alternatives that are radically different from each other. Sketch only the few most important methods or structures of each; full specs waste time at this stage.
- Do this even when you are certain only one reasonable approach exists. Sketch a second design no matter how bad you expect it to be: analyzing its weaknesses sharpens your understanding of why the favored design's features matter.
- After sketching, write out pros and cons for each alternative. When evaluating an interface, weight ease of use for callers above all else; also check relative simplicity, generality, and whether the interface permits an efficient implementation.
- Be open to combining alternatives. The best design may be one of the candidates, or a new design that combines features of multiple alternatives and is better than any of the original choices — comparison can reveal such hybrids.
- If none of the alternatives is attractive, do not settle. Come up with additional schemes, using the specific problems you identified in the rejected designs to drive the new design(s). (In the book's text-editor example: had you considered only the line- and character-oriented designs, noticing that both forced callers to do text manipulation themselves should lead you to a better, range-oriented API.)
- Design the interface twice, then design the implementation twice as a separate exercise with its own criteria (simplicity and performance rather than caller convenience).
- Budget the time and expect a return: for a class-sized module, an hour or two of design exploration is small compared with days or weeks of implementation, and it usually produces a significantly better design. Larger modules deserve longer exploration because both the cost of implementation and the payoff of a better design grow.
- Treat the exercise as skill training, not just decision-making. Repeatedly devising and comparing approaches teaches you which factors make designs better or worse, so over time you rule out bad designs faster and converge on great ones.

## Nuances and counterpoints

- **The smart-person trap**: the design-it-twice principle is sometimes hard for really smart people to embrace. Growing up, their first quick idea was always good enough, which builds a bad work habit. But as people get promoted into environments with harder and harder problems, everyone eventually reaches a point where first ideas are no longer good enough; to get really great results you have to consider a second possibility, or perhaps a third, no matter how smart you are. The design of large software systems is in that category: no one is good enough to get it right on the first try. Trying multiple designs is not an admission that you are not smart; it is recognition that the problems are genuinely hard.
- Engineers who insist on implementing their first idea underperform their true potential and are frustrating to work with. If you catch yourself (or a design under review) shipping the first idea that came to mind, stop and generate alternatives.
- Hard problems are a feature, not a bug: it is more fun to work on problems that demand careful thought than on problems where you don't have to think at all.
- The principle is cheap in practice. It does not require heavyweight up-front design — a couple of hours of sketching for a class, more for bigger components, always small relative to implementation cost.

## Red flags

This chapter has no boxed red flag, but it teaches these warning signs:

- **First idea implemented as-is**: a design that was never compared against an alternative — for a hard problem, the first idea is almost never the best.
- **Alternatives that are minor variations of each other**: you learn little; the candidates must be radically different.
- **Interface pushes the module's work onto callers**: a design that requires higher-level software to perform manipulation the module should own is a red flag (the chapter calls it out explicitly: "if there's going to be a text class, it should handle all of the text manipulation"). If every candidate shares this flaw, none is right — design new ones whose operations match more closely what higher-level software actually does.
- **Settling for an unattractive design**: choosing the least-bad of a weak set instead of using the identified problems to generate better candidates.
- **"Smart people get it right the first time" thinking**: in yourself or teammates, the refusal to explore a second design.
