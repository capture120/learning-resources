---
name: the-missing-readme-textbook
description: Distilled knowledge from The Missing README (Riccomini & Ryaboy) — the unwritten professional knowledge for software engineers: working with existing code, shipping safely, on-call, design docs, and teamwork. Use for questions about engineering practices and early-career growth.
---

# The Missing README — Knowledge Base

Extracted from *The Missing README: A Guide for the New Software Engineer* by Chris Riccomini & Dmitriy Ryaboy (No Starch Press, 2021). The book teaches new software engineers the unwritten knowledge of the profession: how to work with existing code, ship safely, operate production systems, design well, and work with managers and teams. This directory holds the book's full content reorganized for retrieval: 14 chapter directories, each with distilled learnings and retold examples.

## How to Use This Knowledge Base

Start here. Find the situation or topic you're facing in the Routing Guide (or scan the Chapter Index), then open that chapter's files:

- `NN-chapter-name/learnings.md` — core concepts, actionable practices, pitfalls & anti-patterns, key terms. Read this for rules, principles, and "how should I handle X."
- `NN-chapter-name/examples.md` — every example from the chapter retold. Read this when you want concrete cases, stories, or illustrations of a concept.

Every chapter follows this two-file layout. Paths below are relative to this directory. Most questions need only one or two chapters; the Routing Guide maps situations to the right one.

## Chapter Index

- `01-the-journey-ahead/` — **The Journey Ahead.** Defines the first career milestone (safely deliver code, work seamlessly with a team) and a five-stage map from new hire to competent engineer. Topics: four competencies, onboarding, first tasks, stages of growth.
- `02-getting-to-conscious-competence/` — **Getting to Conscious Competence.** How to learn deliberately and ask questions effectively without irritating people; how to beat the two confidence traps. Topics: learning techniques, asking questions, timeboxing, impostor syndrome, Dunning–Kruger.
- `03-working-with-code/` — **Working with Code.** Why existing code is messy and how to change it safely; the case against rewrites, rogue tech, and forks. Topics: software entropy, technical debt, legacy code change algorithm, refactoring, commit hygiene, boring technology.
- `04-writing-operable-code/` — **Writing Operable Code.** Code that survives production needs protection, diagnostics, and controls. Topics: defensive programming, exceptions, retries/idempotency, logging, metrics, traces, configuration, ops tools.
- `05-managing-dependencies/` — **Managing Dependencies.** Every dependency is a risk; manage versions defensively. Topics: semantic versioning, transitive dependencies, dependency hell, pinning, lockfiles, vendoring/shading.
- `06-testing/` — **Testing.** What tests are for, the main test types, and how to keep suites deterministic and valuable. Topics: unit/integration/system tests, mocks, coverage, flaky tests, risk-based prioritization.
- `07-code-reviews/` — **Code Reviews.** Both sides of review done well: preparing reviewable changes and giving useful feedback. Topics: review prep, draft reviews, walk-throughs, feedback etiquette, nits vs. blockers, rubber-stamping.
- `08-delivering-software/` — **Delivering Software.** The path from commit to live traffic: build, release, deploy, rollout. Topics: branching strategies, packaging, immutable releases, deployment automation, feature flags, canary/blue-green, dark launches.
- `09-going-on-call/` — **Going On-Call.** On-call skills and the five-phase incident process; support work and avoiding hero burnout. Topics: triage, mitigation before root cause, postmortems, SLIs/SLOs/SLAs, support requests, firefighter trap.
- `10-technical-design-process/` — **Technical Design Process.** Design as an iterative spiral of solo thought and collaboration, with a design document as output. Topics: problem definition, research, prototypes, design doc template, design reviews, brainstorming.
- `11-creating-evolvable-architectures/` — **Creating Evolvable Architectures.** Complexity is the enemy of change; keep systems simple and compatible. Topics: complexity (dependency/obscurity/inertia), KISS/YAGNI, least astonishment, API compatibility & versioning, schemas, migrations, isolated databases.
- `12-agile-planning/` — **Agile Planning.** Scrum and Kanban as means, not dogma. Topics: user stories, story points, sprint planning, stand-ups, reviews, retrospectives, roadmaps.
- `13-working-with-managers/` — **Working with Managers.** What managers do and how to manage up. Topics: 1:1s, PPP status updates, OKRs, performance reviews, SBI feedback, handling bad management.
- `14-navigating-your-career/` — **Navigating Your Career.** Growth beyond the basics is your own responsibility. Topics: career ladders, T-shaped skills, steering promotion, glue work, job changes, pacing and burnout.

## Routing Guide

### Learning & growth
- Just joined a company / onboarding → `01-the-journey-ahead/learnings.md` (Peak Newb, Ramp-Up River), then `02-getting-to-conscious-competence/learnings.md` (front-loaded learning)
- How to learn a new codebase or technology → `02-getting-to-conscious-competence/learnings.md` (read code, experiment, debuggers)
- When and how to ask for help without annoying people → `02-getting-to-conscious-competence/learnings.md` (research, timebox, show your work, async multicast)
- Feeling like a fraud, or a teammate who rejects all feedback → `02-getting-to-conscious-competence/learnings.md` (impostor syndrome, Dunning–Kruger)
- Wondering what "good" looks like at your level → `01-the-journey-ahead/learnings.md` (four competencies, five stages)

### Working with code
- Modifying messy/legacy code you didn't write → `03-working-with-code/learnings.md` (legacy code change algorithm)
- Arguing for (or against) paying down technical debt → `03-working-with-code/learnings.md` (debt quadrant, written proposal framework)
- Tempted to rewrite a system, adopt a shiny tool, or ignore a standard → `03-working-with-code/learnings.md` (10x bar, innovation tokens, boring technology)
- Adding a library, version conflicts, broken builds after an upgrade → `05-managing-dependencies/learnings.md` (skepticism checklist, pinning, lockfiles)
- Writing code that must survive production → `04-writing-operable-code/learnings.md` (defensive programming, exceptions, retries, idempotency)
- Deciding what to log or measure, designing configuration → `04-writing-operable-code/learnings.md` (log levels, counters/gauges/histograms, static config)

### Quality & shipping
- Deciding what tests to write (or skip) → `06-testing/learnings.md` (test types, risk matrix, don't overdo it)
- Flaky/intermittent test failures → `06-testing/learnings.md` (determinism: seeded RNGs, injected clocks, port zero, cleanup)
- Preparing code for review / receiving harsh feedback → `07-code-reviews/learnings.md` (prep, drafts, don't get attached)
- Reviewing someone else's change → `07-code-reviews/learnings.md` (understand first, nits vs. blockers, no rubber-stamping, drive to conclusion)
- Choosing a branching strategy or fixing a slow release process → `08-delivering-software/learnings.md` (trunk-based development, release frequently)
- Rolling out a risky change → `08-delivering-software/learnings.md` (feature flags, canary, blue-green, dark launch, monitor SLIs)
- Deployments breaking or needing ordering → `08-delivering-software/learnings.md` (atomic deploys, backward/forward compatibility)

### Operations & incidents
- First on-call rotation → `09-going-on-call/learnings.md` (availability, attention, prioritization, tracking) plus `09-going-on-call/examples.md` for a real incident walkthrough
- Production incident right now → `09-going-on-call/learnings.md` (triage → coordinate → mitigate → resolve → follow up; mitigate before root-causing)
- Writing a postmortem → `09-going-on-call/learnings.md` (five whys, blameless, no solutioning in review)
- Handling support requests / becoming the team's overworked firefighter → `09-going-on-call/learnings.md` (support flow, don't be a hero)
- Debugging a live system → `09-going-on-call/learnings.md` (scientific method, half-splitting) with `04-writing-operable-code/learnings.md` (logs, metrics, traces)

### Design & architecture
- Task too big to just start coding → `10-technical-design-process/learnings.md` (define the problem, research, prototype)
- Writing a design document → `10-technical-design-process/learnings.md` (when to write one, full template, keep it updated)
- Getting buy-in for a design across teams → `10-technical-design-process/learnings.md` (don't surprise people, socialize early, review processes)
- Designing APIs that won't break clients → `11-creating-evolvable-architectures/learnings.md` (small APIs, compatibility, versioning, IDLs)
- Schema changes, shared databases, data migrations → `11-creating-evolvable-architectures/learnings.md` (isolate databases, explicit schemas, automated migrations)
- Tempted to add flexibility, caching, or features "for later" → `11-creating-evolvable-architectures/learnings.md` (YAGNI, premature optimization, MVP)

### Planning & process
- Sprint planning, estimating, story writing → `12-agile-planning/learnings.md` (user stories, story points, relative sizing, locked sprints)
- Stand-ups dragging or sprints derailing → `12-agile-planning/learnings.md` (parking lot, unplanned work, retrospectives)
- Quarterly/annual roadmap planning → `12-agile-planning/learnings.md` (roadmaps evolve; planning > the plan)
- Team process feels broken → `12-agile-planning/learnings.md` (retros, adapt the process) and raise it via `13-working-with-managers/learnings.md` (1:1s, SBI)

### Managers & career
- Making 1:1s useful / manager keeps canceling them → `13-working-with-managers/learnings.md` (you set the agenda, no status updates)
- Writing status updates → `13-working-with-managers/learnings.md` (PPP format, roll forward)
- Setting goals/OKRs → `13-working-with-managers/learnings.md` (key results aren't to-dos, stretch goals 60–80%)
- Performance review coming up → `13-working-with-managers/learnings.md` (track work year-round, never be surprised) plus `14-navigating-your-career/learnings.md` (self-assessment against the ladder)
- Giving difficult feedback to a manager or peer → `13-working-with-managers/learnings.md` (SBI: situation, behavior, impact; solutions last)
- Wanting a promotion → `14-navigating-your-career/learnings.md` (learn the ladder, visible finished impact, start conversations early, glue-work trap)
- Considering switching teams or companies → `14-navigating-your-career/learnings.md` (good vs. FOMO reasons, ossification) and `13-working-with-managers/learnings.md` (when management is failing, 3–6 month rule)
- Overworked, burning out → `14-navigating-your-career/learnings.md` (pace yourself, sleep, vacations) and `09-going-on-call/learnings.md` (hero trap)

## Cross-Cutting Themes

- **Incrementalism.** Small steps beat big bangs everywhere: continuous refactoring over rewrites (ch. 3), small reviewable changes (ch. 7), frequent releases and gradual rollouts (ch. 8), short locked sprints (ch. 12), iterative design spirals (ch. 10).
- **Boring over clever.** Mature technology, standard libraries, plain configuration, and idiomatic patterns break predictably; cleverness creates obscurity (ch. 3 innovation tokens, ch. 4 config, ch. 11 least astonishment, ch. 2 "pump the brakes on Hacker News ideas").
- **Write it down.** Documents do the heavy lifting: refactor proposals in writing (ch. 3), design docs (ch. 10), tracked on-call work and postmortems (ch. 9), PPPs and recorded accomplishments (ch. 13), commit messages and changelogs (ch. 3, 8).
- **Communication over heroics.** Ask questions early, socialize designs before formal review, give blameless feedback, and don't become the firefighter everyone depends on (ch. 2, 9, 10, 13).
- **Own your work end to end.** You're responsible for tests (ch. 6), releases (ch. 8), production behavior (ch. 4, 9), and your own career growth and promotion (ch. 14) — never throw anything over the fence.
- **Pragmatism over dogma.** Reserve "technical debt" for real debt, don't chase coverage numbers, adapt Agile to the team, version APIs only where it pays — every chapter prefers judgment and trade-offs to rules followed blindly (ch. 3, 6, 11, 12).
