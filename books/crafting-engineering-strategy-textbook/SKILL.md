---
name: crafting-engineering-strategy-textbook
description: Distilled knowledge from Crafting Engineering Strategy (Will Larson) — diagnosis, guiding policy, and operations; the Explore, Diagnose, Refine, Set Policy, Operate process; strategy testing, systems modeling, Wardley maps, and worked case studies. Use for questions about creating, evaluating, or driving adoption of engineering strategy, with or without formal authority.
---

# Crafting Engineering Strategy — Will Larson (O'Reilly, 2026)

Larson's thesis: engineering strategy is simply making thoughtful decisions about engineering, and every organization already has one — the only choice is whether it's written and deliberate or implicit and accidental. A real strategy is Rumelt's three parts adapted for engineering: an honest **diagnosis** of constraints, a **guiding policy** that makes genuine tradeoffs, and **coherent actions (operations)** that change behavior. Strategies fail mundanely — skipped steps, no rollout owner, unvalidated details — not from unsound thinking, so the cure is structure: Explore → Diagnose → Refine → Set Policy → Operate, with cheap refinement (testing, systems modeling, Wardley mapping) before expensive commitment. Anyone can do this work; authority changes tactics, not access.

Written for anyone in or adjacent to an engineering org: engineers without authority, new executives, and leaders rescuing strategies that aren't sticking. The book is honest about real-world constraints — low-trust cultures, fake deadlines, missing upstream decisions, top-down mandates — and gives workarounds for each.

**Directory layout:** one directory per chapter (`NN-slug/`). Each contains `learnings.md` (core ideas and actionable guidance), `examples.md` (retold examples; for Part IV chapters, the full worked case study), and `detailed.md` (the exhaustive long-form reference mirroring the chapter's own section structure). Route with the guide below, then open the chapter's `learnings.md` first; go to `examples.md` when you need the concrete document, model, or story, and `detailed.md` when you need complete coverage with every qualification, number, and reasoning chain.

## How to route

### "Is strategy even worth doing here?" — skepticism, buy-in, timing
- `02-is-engineering-strategy-useful/` — the case that strategy always exists (implicit vs written), why writing it down is the highest-leverage act, what unwritten strategy costs; ammunition for convincing skeptics.
- `04-when-and-how-much-strategy/` — timing test (strategic state, trend, context), why to run one strategy at a time, the altitude/permissiveness dial; for "is now the moment, and how much?"
- `01-introduction/` — base definitions: Rumelt's three pillars, the tradeoff test for policies, why most strategies fail mundanely; start here for vocabulary.
- `12-bridging-theory-and-practice/` — strategy in chaotic environments (layoffs, fast-moving tech) when it feels pointless.

### "I don't have the authority" — strategy from below
- `03-who-gets-to-do-strategy/` — tactics by role: "take five, then synthesize" for engineers, mandate constraints for executives, low-trust and poor-judgment workarounds.
- `10-operations/` — driving adoption via nudges, advice forums, and data instead of mandates.
- `16-case-study-service-migration/` — the proof: a four-person Uber team migrated 1,000+ services with zero executive sponsorship, earning adoption through ergonomics.
- `12-bridging-theory-and-practice/` — effective diagnosis trumps authority; surviving top-down mandates with a private shadow strategy.
- `24-how-to-get-better-at-strategy/` — if your role seems to forbid strategy, lower the altitude (team, or yourself).

### "I'm writing a strategy from scratch" — the crafting pipeline
- `05-steps-to-build-an-engineering-strategy/` — the five-step process (Explore, Diagnose, Refine, Set Policy, Operate) and why skipped steps, not bad thinking, kill strategies. Start here.
- `06-exploring/` — avoid anchoring on your first idea (or your last employer's stack); stopping rules: 3 internal teams + 3 companies, under a week.
- `07-diagnosis/` — building the factual diagnosis: mining dissenters, whispering controversial truths as precise facts, reframing blockers as conditions.
- `09-setting-policy/` — turning diagnosis into policy: four kinds (approvals, allocations, direction, guidance), the applicable + enforced test, handling competing proposals.
- `11-writing-readable-strategies/` — restructuring the draft for readers (policy first, reasoning last), rollout mechanics, templates.
- `12-bridging-theory-and-practice/` — when the clean process meets fake deadlines, indecisive stakeholders, or missing upstream strategy.

### "I want to derisk before committing" — refinement tools
- `08-refining/` — the routing chapter: which technique fits which problem, why refinement gets skipped (incentives), antipatterns like manufactured consent.
- `13-strategy-testing/` — for ambiguous problems or any pre-rollout validation: narrowest-deepest slice, impact (not adoption) metrics, weekly debugging meeting, sponsor/guide roles.
- `14-systems-modeling/` — for unknown leverage points or intuition-based stakeholder fights: stock-and-flow models, five-step process, cautions against model overconfidence.
- `15-wardley-maps/` — for shifting ecosystems or 5+ year horizons: mapping evolution, build-vs-buy timing, scenario forking.

### "My strategy isn't sticking" — rollout, enforcement, rescue
- `10-operations/` — the main rescue toolkit: mechanism rubric, nudges + inspection, why announcements/trainings/culture memos fail, anti-cargo-culting.
- `13-strategy-testing/` — two-question audit for untested strategies; face-saving pause-and-retest for a failing mandate.
- `09-setting-policy/` — debugging an ignored policy: applicability, enforcement, wrong altitude.
- `11-writing-readable-strategies/` — when the document itself is the problem: readers can't find the policy or misapply it.
- `01-introduction/` — the two mundane failure modes: no rollout owner, unvalidated details.

### "Is this strategy any good? Should we kill it?" — evaluation
- `23-is-this-strategy-any-good/` — Speed/Cost/Impact rubric (0–9), per-phase scoring, why abandoning can be skilled strategy, why you can't judge other companies' strategies from outside, failed-strategy post-mortems.
- `13-strategy-testing/` — judging an in-flight strategy whose numbers aren't moving.
- `02-is-engineering-strategy-useful/` — inappropriate vs bad strategy; judge by circumstances (Digg V4).

### "I need a worked example" — match the case study to your situation
- Platform team drowning in demand; migration without sponsorship; sequencing automation: `16-case-study-service-migration/` (Uber).
- Hyped-technology adoption (AI/LLMs) under uncertainty; reversibility analysis; finding the real constraint: `17-case-study-llm-adoption/`.
- Cost pressure, PE/investor ownership, headcount and seniority-mix policy: `18-case-study-private-equity-ownership/`.
- Security/compliance controls teams keep subverting; refusing security-vs-usability framing; metric design: `19-case-study-customer-data-access/`.
- Monolith vs microservices; default-deny service creation with exceptions: `20-case-study-service-architecture/`.
- New executive refocusing a scattered team; protecting tech-debt work from delivery pressure; boring-technology defaults: `21-case-study-product-engineering/` (Calm).
- API deprecation/versioning; investing in a monolith at scale (Sorbet); acquisition integration under deadline: `22-case-study-stripe-developer-api-acquisition/` (Stripe).

### "I want to get better at this long-term"
- `24-how-to-get-better-at-strategy/` — personal practice: learning circles, strategy archaeology, accountability mechanisms, the "too busy" trap.
- `25-strategy-resources/` — annotated bibliography (Rumelt, Wardley, Meadows, Flyvbjerg) and the few genuine public strategy case studies.

## Book map

**Part I — Introducing Engineering Strategy.** The thesis: what strategy is, why it matters, who can do it, when to do it.
- `01-introduction` — Engineering Strategy Is Accessible, Structured, and Iterative: defines strategy as thoughtful decisions, introduces diagnosis/policy/actions and the mundane failure modes.
- `02-is-engineering-strategy-useful` — Is Engineering Strategy Useful?: strategy always exists; writing it down is the highest-leverage act.
- `03-who-gets-to-do-strategy` — Who Gets to Do Strategy?: anyone can; tactics differ by role, and waiting for the executive level is a recipe for disaster.
- `04-when-and-how-much-strategy` — When and How Much?: timing test, one strategy at a time, altitude framework; more leaders fail from too much strategy than too little.

**Part II — Steps for Building Engineering Strategies.** The step-by-step crafting process.
- `05-steps-to-build-an-engineering-strategy` — the five-step structure (Explore, Diagnose, Refine, Set Policy, Operate) and why it prevents skipped-step failures.
- `06-exploring` — surveying problem and solution spaces before committing, to defeat early anchoring.
- `07-diagnosis` — building an evidence-backed diagnosis, including politically hard truths.
- `08-refining` — cheaply validating the load-bearing assumptions before commitment; routing among the three techniques.
- `09-setting-policy` — converting diagnosis into applicable, enforced policies; good policies feel inevitable, even boring.
- `10-operations` — mechanisms that make policies change behavior instead of fading away.
- `11-writing-readable-strategies` — restructuring drafts for readers and rolling documents out.
- `12-bridging-theory-and-practice` — keeping strategy good under deadlines, chaos, missing decisions, and bad mandates.

**Part III — Refinement Tools.** Deep dives on the most valuable, most neglected step.
- `13-strategy-testing` — validating the narrowest deepest slice before rollout, with impact metrics and debugging meetings.
- `14-systems-modeling` — stock-and-flow models to find leverage points and structure gut-feel disagreements.
- `15-wardley-maps` — mapping ecosystem evolution for strategies that must survive a shifting landscape.

**Part IV — Case Studies.** Seven complete worked strategies from Larson's career; `examples.md` holds the full case document.
- `16-case-study-service-migration` — Uber: bottom-up self-service provisioning migration with no executive sponsor.
- `17-case-study-llm-adoption` — LLM adoption under hype: optimize for rate of learning, model the real constraint.
- `18-case-study-private-equity-ownership` — engineering cost strategy before PE targets arrive: no-regret policies, explicit deferrals.
- `19-case-study-customer-data-access` — CISO strategy making security and usability improve together so controls stop being subverted.
- `20-case-study-service-architecture` — monolith decomposition decided from business mechanics, not technical taste.
- `21-case-study-product-engineering` — Calm: restrictive defaults plus a mechanism protecting engineering-driven work.
- `22-case-study-stripe-developer-api-acquisition` — Stripe: never-deprecate APIs, Sorbet over decomposition, acquisition integration under deadline.

**Part V — Going Forward.** Evaluating strategies and improving your practice.
- `23-is-this-strategy-any-good` — Speed/Cost/Impact rubric, per-phase quality, when abandonment is skill.
- `24-how-to-get-better-at-strategy` — a strategy for getting better at strategy: sources, learning circles, habits.
- `25-strategy-resources` — annotated reading list and public strategy examples.

## Reading paths

1. **Quick-start crafting path** — you need to write a strategy now: `05` → `06` → `07` → `09` → `11`, dipping into `08` before any big commitment and `10` before rollout. Add `12` when reality diverges from the process.
2. **Refinement deep-dive** — you know the process but your bets keep going wrong: `08` (which tool when) → `13` → `14` → `15`. Pair each with its Part IV application: `13`→`19`, `14`→`16`/`18`/`22`, `15`→`16`/`17`.
3. **Skeptic's path** — you doubt strategy work pays off: `02` (it already exists, written wins) → `04` (right dose, right time) → `23` (how you'd know it's working) → `03` (you specifically can do it).
4. **Case-study-first path** (Larson's own alternative ordering) — pick the Part IV case matching your situation from the routing table above, read its `examples.md`, then backfill whichever Part II chapter explains the step that surprised you.
