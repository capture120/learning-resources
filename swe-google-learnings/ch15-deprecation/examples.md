# Chapter 15: Deprecation — Examples, Case Studies, and Anecdotes

All examples come from *Software Engineering at Google*, Chapter 15 ("Deprecation," by Hyrum Wright). "Deprecation" here means the orderly migration away from, and eventual removal of, an obsolete software system.

## LaTeX: old does not mean obsolete

**Setup.** The chapter warns against equating a system's age with obsolescence.

**What happened.** The LaTeX typesetting system has been improved over the course of decades. Changes still happen, but they are few and far between. It remains a finely crafted, valuable system.

**Lesson.** Age alone never justifies deprecation. Deprecation is only appropriate for systems that are *demonstrably obsolete* and for which a replacement with comparable functionality already exists.

## The road-paving analogy: limits on concurrent deprecation

**Setup.** Deprecation is useful, but organizations can only absorb so much of it at once — both the teams doing the deprecation and their customers have limited capacity.

**What happened.** The book's analogy: everybody appreciates freshly paved roads, but if the public works department closed every road for paving simultaneously, nobody could go anywhere. By focusing effort, paving crews finish specific jobs faster while other traffic keeps moving.

**Lesson.** Choose deprecation projects carefully, limit how many run at once, and commit to finishing the ones you start.

## "I like this code!": emotional attachment to old systems

**Setup.** One surprising source of resistance to deprecation is emotional: engineers are attached to systems they helped build.

**What happened.** When systematically removing old code at Google, deprecation teams occasionally hit resistance of the literal form "I like this code!" Engineers found it hard to let others tear down something they had spent years building. Google partly defused this by making its source repository searchable not just at trunk (the current state) but *historically* — deleted code can always be found again.

**Lesson.** The attachment is understandable but self-defeating: an obsolete system is a net cost to the organization and should be removed. Guaranteeing that removed code remains recoverable lowers the emotional barrier to deleting it.

## The Google joke: "deprecated" vs. "not yet ready"

**Setup.** In a complex, fast-paced technology environment, replacements are often "almost" done while the old system is already marked for removal.

**What happened.** An old joke inside Google says there are two ways of doing things: the one that's deprecated, and the one that's not-yet-ready. Google engineers have grown used to living in that gap, but it is still disconcerting.

**Lesson.** The uncomfortable in-between state is a normal cost of fast evolution. Good documentation, plenty of signposts, and expert teams helping with deprecation and migration make it easier to decide between the old thing (with all its warts) and the new one (with all its uncertainties).

## Nuclear power plants: designing for decommissioning

**Setup.** The idea of designing a software system so it can eventually be removed sounds radical in software, but it is standard practice in other engineering disciplines.

**What happened.** A nuclear power plant — an extremely complex piece of engineering — is designed with its eventual decommissioning in mind from the start, even to the point of allocating funds for the decommissioning up front. Knowing the plant must one day be taken apart shapes many of its design choices. (The book cites an IAEA technical report on designing plants to facilitate decommissioning.)

**Lesson.** Software teams should likewise consider end-of-life at design time. Google encourages designers to ask: How easily can my consumers migrate to a replacement? How can parts of my system be replaced incrementally? Software culture — which rewards building and shipping new things and makes it psychologically hard to plan a creation's demise — works against this, so the discipline must be deliberate.

## "Hope is not a strategy": the SRE maxim applied to advisory deprecation

**Setup.** Advisory deprecation is deprecation without a deadline, without dedicated resources, and without enforcement — the owning team merely hopes clients migrate.

**What happened.** The chapter borrows the maxim of Google's Site Reliability Engineering organization — "Hope is not a strategy" — to characterize the weakness of advisory deprecation. Google's experience: putting a deprecation warning on an old system and walking away leads to slightly fewer *new* uses, but rarely to teams actively migrating away. Worse, a heavily used old system exerts a conceptual and technical pull: it keeps attracting a large share of new uses no matter how much the owners say "please use the new system."

**Lesson.** Advisory deprecation is a tool for advertising a new system and recruiting early adopters — and it only encourages self-service migration when the new system's benefits are *transformative*, not incremental. It should never be counted on to accomplish the majority of a migration.

## The critical-infrastructure veto: politics defeating a "compulsory" deadline

**Setup.** Compulsory deprecation sets a hard removal deadline, backed by the power to break users who have not migrated after sufficient warning.

**What happened.** The chapter poses a thought experiment drawn from real dynamics: imagine the last remaining user of the old system is a critical piece of infrastructure that your entire organization depends on. How willing would you be to break that infrastructure — and, transitively, everyone depending on it — just to hit an arbitrary deadline?

**Lesson.** A deprecation is not credibly compulsory if one important team can veto its progress. Enforcement power must be real, and political hurdles must be anticipated even when policy formally backs the deadline.

## Planned outages and DiRT-style testing: flushing out unknown dependencies

**Setup.** Even with Google's monolithic repository and full dependency graph, some teams do not know they depend on an obsolete system, and static analysis cannot find every dynamic dependency.

**What happened.** When a system is slated for removal, Google teams frequently announce planned outages of increasing duration in the months and weeks before turndown — deliberately switching the old system off for progressively longer windows. Modeled on Google's Disaster Recovery Testing ("DiRT") exercises, these events routinely discover previously unknown dependencies between running systems. Dependent teams then either plan for the removal or negotiate a timeline adjustment with the deprecating team. (For static code dependencies, static-analysis tooling usually finds everything without this trick.)

**Lesson.** Intentional, escalating breakage is a practical mechanism for discovering unintended runtime dependencies before the final removal breaks them for real.

## Renaming implementation-only symbols

**Setup.** Related to the above: some users depend on internals they were never supposed to touch — the essence of Hyrum's Law (with enough users, every observable behavior gets depended on).

**What happened.** Within Google, teams occasionally rename implementation-only symbols — identifiers that were never part of the public interface — specifically to see which users break, revealing who was depending on them unawares.

**Lesson.** Controlled changes to non-guaranteed surfaces are a cheap way to smoke out hidden dependents ahead of a deprecation deadline.

## Alert fatigue: transitive deprecation warnings

**Setup.** It is tempting to mark everything deprecated and let build warnings do the migration work.

**What happened.** In practice warnings accumulate. The book gives the transitive example: library A depends on library B, which depends on library C; C issues a deprecation warning, and that warning shows up whenever A is built — for users several steps removed from the deprecated code. Warnings pile up until users ignore them altogether. Health care has a name for this phenomenon: "alert fatigue."

**Lesson.** Every deprecation warning must be *actionable* (an average engineer can practically act on it — e.g., "replace this call with X," or an email listing concrete data-migration steps) and *relevant* (surfaced at the moment the user performs the action — while writing the code, not weeks after check-in; months before a system's removal, not the weekend before).

## Targeted warning tooling: ErrorProne, clang-tidy, and new-lines-only surfacing

**Setup.** Google marks old functions deprecated very liberally, which would drown engineers in warnings if surfaced naively.

**What happened.** Google leverages static-analysis tooling — ErrorProne (for Java) and clang-tidy (for C++) — to surface deprecation warnings in targeted ways: warnings are limited to newly changed lines, catching *new* uses of a deprecated symbol rather than nagging about every existing one. More intrusive warnings, such as on deprecated targets in the build dependency graph, are reserved for compulsory deprecations where a team is actively migrating users away.

**Lesson.** Tooling that delivers the right warning to the right person at the right time lets an organization mark many things deprecated without fatiguing anyone.

## Abandoned projects "chugging along in the basement"

**Setup.** Every organization of reasonable size has projects that are still actively used but that nobody clearly owns or maintains; Google is no exception.

**What happened.** Projects often reach this state *because* they were deprecated: the original owners moved on to the successor project, leaving the obsolete system running — still a dependency of something critical — with everyone hoping it just fades away. Google found such projects do not fade away on their own; they require deprecation experts to remove them before they fail at an inopportune time.

**Lesson.** Deprecation needs explicit owners whose *primary* goal is removal. As a side project it always loses to competing priorities. The book notes these important-not-urgent cleanups are a great use of Google's "20% time" and give engineers exposure to other parts of the codebase.

## Milestones: "turning out the lights" is a bad sole metric

**Setup.** Building a new system offers natural incremental milestones ("launch the frobnazzer features by next quarter"), with users gaining value at each step. Deprecation feels different: the team can feel it has made no progress until it has "turned out the lights and gone home."

**What happened.** The chapter observes an irony: if the deprecation team did its job right, the final removal is the *least* noticed event — by that point the system has no users left. And total removal might not even happen in every deprecation project.

**Lesson.** Deprecation project managers should define concrete, measurable, incremental milestones (for example, deleting a key subcomponent) and celebrate them just as they would celebrate accomplishments in building a new product. Morale depends on it.

## Whack-a-mole: deprecation without backsliding prevention

**Setup.** An often-overlooked piece of deprecation infrastructure is tooling that prevents *new* uses of the system being removed.

**What happened.** Without backsliding prevention, deprecation becomes a game of whack-a-mole: users keep adding new uses of the system they are familiar with (or copy examples of it found elsewhere in the codebase), and the deprecation team keeps migrating those new uses — counterproductive and demoralizing. Google prevents this at two levels. Micro: the Tricorder static-analysis framework flags new calls into deprecated systems at code-review time, driven by compiler annotations such as Java's `@deprecated`, which let the owning team control the replacement messaging; in limited cases the tooling offers a push-button fix to the suggested replacement. Macro: visibility whitelists in the build system block any new dependency on the deprecated system, and automated tooling periodically prunes those whitelists as existing dependents migrate away.

**Lesson.** Stop the inflow before (or while) draining the pool. Backsliding prevention at both the code-review level and the build-graph level is essential for a deprecation to converge.

## Sidebar: code is a liability, not an asset

**Setup.** The chapter opens from the premise that code is a liability. A sidebar addresses the apparent contradiction: if code is a liability, why does the whole book teach how to build software that lives for decades?

**What happened.** The resolution: code itself does not bring value — the *functionality* it provides does. Functionality is an asset when it meets a user need; code is merely the means to that end. Given the same functionality, one line of maintainable code beats 10,000 lines of convoluted spaghetti. The right goal is maximizing functionality delivered per unit of code, and one of the easiest ways to improve that ratio is removing excess code and systems no longer needed — which is exactly what deprecation policies and procedures enable.

**Lesson.** Measure and optimize functionality per unit of code, not code volume. Deletion is a first-class engineering contribution.

## Closing image: cleaning up after the circus parade

**Setup.** The chapter's conclusion acknowledges how deprecation work *feels*.

**What happened.** The book likens deprecation to "the dirty work of cleaning up the street after the circus parade has just passed through town" — unglamorous, but the effort improves the whole software ecosystem by reducing maintenance overhead and engineers' cognitive burden.

**Lesson.** Scalably maintaining complex software over time means more than building and running systems; it requires the ability to remove obsolete ones. Organized, well-managed deprecation is an overlooked but essential source of long-term organizational sustainability.
