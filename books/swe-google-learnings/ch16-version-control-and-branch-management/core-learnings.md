# Chapter 16: Version Control and Branch Management

*Software Engineering at Google, written by Titus Winters.*

## Chapter Thesis

Version control is the engineer's primary tool for managing the interplay between source code and time, and it is near-universally adopted because it lets teams scale collaboration beyond a single developer. But the technology of a Version Control System (VCS) is only half the story: the policies layered on top of it matter at least as much. The chapter's central claim is that removing choice is what makes version control scale. An organization should designate exactly one repository and one branch as the Source of Truth, follow a "One-Version Rule" (developers must never have a choice of which version of a component to depend on), and practice trunk-based development with minimal long-lived branches. Dev branches used as a stability crutch create unbounded merge-coordination overhead; the better solution to instability is testing, Continuous Integration, and keeping trunk green. Whether you use a literal monorepo (one giant repository, as Google does) matters far less than adhering to the One-Version principle by whatever means.

## Core Principles and Ideas

### What a VCS is

- A **Version Control System (VCS)** tracks revisions (versions) of files over time. The managed files plus their metadata form a **repository** (repo).
- Mental model: a filesystem maps *filename → contents*. A VCS extends this to *(filename, time, branch) → contents*. Version control makes time an explicit part of every operation.
- The default branch input is called **head**, **default**, or **trunk** (the main branch).
- **Atomicity** means a commit touching multiple files is treated as one indivisible unit. Systems without atomic commits (like CVS, a popular 1990s VCS) suffered corruption and lost changes.
- A developer's local copy of the repository is called a **client** or **workspace** when it holds reduced metadata; in some systems the local copy is a full repository itself.
- Version control matters because software engineering is "programming integrated over time." A VCS is a project-wide undo, an arbiter of "which is newer," and the coordination mechanism between multiple developers and between one developer at multiple points in time. It also provides audit trails and provenance tracking that legal and regulatory practice increasingly requires.
- Hesitation toward version control almost always comes from conflating programming (write code now) with software engineering (keep code working over time). Someone who has only ever written short-lived solo code sees VCS as high-overhead luxury.
- The commit ritual has non-technical value: it forces a moment of reflection and is a natural hook for checklists, static analysis, and tests.

### Centralized versus distributed VCS

- All modern VCSs are functionally equivalent at the core: given atomic multi-file commits, everything else is user experience, naming, edge-case features, and performance. Choosing a VCS is like choosing a filesystem format; what you put in it and how you use it matters more.
- **Centralized VCS** (RCS, CVS, Subversion, Perforce): one central repository; commits go to the central server. The earliest systems (SCCS in the 1970s, RCS in the 1980s) used exclusive file locking, which falls apart when locks become contended. Later systems (CVS, Subversion) dropped locking and instead required your edit to be based on the current version of every file in the commit.
- **Distributed VCS (DVCS)** (Git, Mercurial, mid-2000s onward): any clone is a full repository you can commit to. Centrality is purely a matter of policy, not technology. DVCS enables offline work and suits the open source world's distributed, low-coordination model.
- Git is the dominant system today; when in doubt use it, because there is value in doing what everyone else does.
- The DVCS model assumes downloading the whole codebase locally. At large scale this transmission is almost entirely waste, because each developer touches a shrinking fraction of files and versions. Google finds centrality and in-the-cloud storage critical to scaling.

### Source of Truth

- Centralized VCSs bake Source of Truth into the design: whatever is most recently committed at trunk is current. DVCS has no inherent Source of Truth, so it requires more explicit policy and norms.
- Well-managed DVCS projects declare one specific branch in one specific repository as the Source of Truth (for example, the trunk branch of the primary GitHub repository). Work is "done" when it lands there.
- Without a Source of Truth, someone ends up hand-maintaining a list of which changes are included in a release; that bookkeeping just reinvents centralization with linear (or worse) human effort. A scalable system needs sublinear human effort as the team grows.
- Source of Truth is relative to the organization. A Red Hat engineer's Source of Truth for Linux kernel patches differs from Linus Torvalds's, and that is fine as long as the hierarchy is unambiguous: there must be no choice or uncertainty about where a change gets pushed.
- Technology is only part of version control; there is always an equal amount of policy and usage convention on top.

### Branch management

- **Work in progress is akin to a branch.** Uncommitted local changes are conceptually no different from committed changes on a branch, just harder to find and diff against. Any branch-policy discussion must acknowledge this. It matters especially for refactoring: "rename Widget everywhere" can mean trunk only, all branches, or all branches plus everyone's outstanding edits.
- **Dev branches** (development branches) are a halfway point between "done but not committed" and "what new work is based on." Teams adopt them to keep trunk stable, but the chapter argues this is inherently misguided. The instability problem is real, but tests, Continuous Integration (CI), and thorough code review solve it far better.
- Why dev branches fail: the same commits must merge to trunk eventually. Small merges beat big ones. Merges done by the change's author beat batched merges of unrelated work. When a big merge breaks, isolating and fixing the responsible change is much harder.
- **Dev branches are a time bomb / addiction pattern.** Organizations see "merging this long-lived branch reduced stability," conclude "branch merges are risky," and respond by slowing down and coordinating merges instead of fixing testing. Branches stack on branches, a Build Master or Merge Coordinator role appears, and regularly scheduled merge-strategy meetings consume the organization. All that merge-and-retest effort is pure overhead that does not scale.
- The alternative paradigm: **trunk-based development**. Everyone commits small increments to trunk, relies heavily on testing and CI, keeps the build green, and disables incomplete or untested features at runtime (feature gating). No merge-strategy meetings, no large expensive merges, no debates about which library version to use.
- **Release branches** are generally benign. A release branch snapshots the exact code in a release; critical fixes are **cherry-picked** (minimal targeted merges) from trunk. The key difference from a dev branch is the expected end state: a dev branch is expected to merge back to trunk; a release branch is expected to be abandoned. Organizations that achieve Continuous Deployment (releasing from trunk many times a day) tend to skip release branches entirely, since redeploying a fix is easier than cherry-picking.
- **DORA research** (DevOps Research and Assessment, published in the Accelerate book and State of DevOps reports) finds trunk-based development and the absence of long-lived dev branches predictive of high-performing software organizations. Branches are a drag on productivity; complex branch-and-merge strategies are a perceived safety crutch.

### Version control at Google

- Google keeps almost all its source in a single **monorepo** (one shared repository) used by roughly 50,000 engineers, holding over 80 TB of content and metadata, receiving 60,000–70,000 commits per workday. Big open source projects like Chromium and Android live outside it.
- The monorepo runs on **Piper**, an in-house centralized VCS built as a distributed microservice on Google's production infrastructure. Operations stay cheap at human scale (about 15 seconds to create a client, add a file, and commit).
- Owning the VCS lets Google enforce policy in the tool itself. **OWNERS files** at every level of the file hierarchy list engineers allowed to approve commits in that subtree. Ownership is just a text file, so reorganizations are trivial; a many-repo setup would need filesystem permissions or commit hooks to approximate this.
- Attempts to migrate to standard tools like Git have been stymied by codebase and userbase size, plus Hyrum's Law effects (hidden dependencies on the existing VCS interface, such as scripts assuming monotonically increasing commit numbers).

### The One-Version Rule

- **One Version** extends Single Source of Truth: for every dependency in the repository, there must be only one version to choose. Third-party packages get a single checked-in version. Internal packages must not be forked without renaming/repackaging, so original and fork can always safely coexist in one program.
- The rule stated precisely: **"Developers must never have a choice of 'What version of this component should I depend upon?'"**
- Allowing multiple versions partitions the codebase: any target's transitive dependencies must contain exactly one copy of a library, so adding a single dependency edge can break builds or cause runtime bugs from linking mismatched versions. Verifying safety can require running all tests in the codebase, which does not scale.
- Technical workarounds like Java **shading** (renaming a library's internal dependencies to hide them) work for functions but fail for types passed between packages. No efficient trick exists for multiple versions of a library that provides a vocabulary type. These workarounds are lost labor spent patching around the real problem.
- One Version is not absolutely hard and fast (a library upgrade may temporarily have two versions checked in), but new dependencies must never have a choice of version.
- For individual developers the lack of choice feels like an arbitrary impediment; for the organization it is a critical component of efficient scaling. Consistency creates leverageable choke points.
- One Version implies **(nearly) no long-lived dev branches**, echoing Agile, DORA, and The Phoenix Project's "reduce work-in-progress." A better replacement component living only on a parallel branch reintroduces choice; instead commit it to trunk, disable it at runtime until ready, and hide it via visibility controls.
- Long-lived dev branches also tax **large-scale changes (LSCs)**: codebase-wide refactorings would have to chase an unbounded, possibly undiscoverable set of hidden branches.
- Legitimate long-lived dev branches are rare (fewer than about 10 among roughly 1,000 Google teams) and almost always stem from unusual compatibility-over-time requirements: data-at-rest format compatibility between readers and writers, or API compatibility promises between old clients and new servers. Dependency across time is far more costly than time-invariant code. Google caps version skew with a **build horizon**: every production job must be rebuilt and redeployed at least every six months.

### Monorepos and the future

- The monorepo's chief benefit is that One Version becomes trivial: violating it is harder than doing the right thing. There is no process for deciding which versions are official or which repositories matter, tooling has one place to look, and engineers can see what everyone else is doing.
- A monorepo is not the One True Way. The repository-layout question is like choosing one large filesystem versus ten small ones: debatable, organization-specific. What matters is adhering to the One-Version principle to the greatest extent possible.
- If every project shares the same secrecy, legal, privacy, and security requirements, a true monorepo works well. Otherwise, aim for monorepo *functionality* with different implementation: a **virtual monorepo (VMR)** federates fine-grained repositories under an agreed-upon commit ordering and dependency graph (Git submodules, Bazel external dependencies, CMake subprojects gesture at this). Fine-grained repos scale and isolate secret projects more easily.
- Main arguments against monorepos: technical limits of huge repositories (being eroded by Git improvements like shallow clones and sparse checkouts) and mismatch with open source practice (which reflects the OSS world's lack of coordination and shared compute, assumptions that do not hold inside one organization). The most legitimate concern is heterogeneous legal/compliance/privacy requirements across projects.
- Microsoft, Facebook, Netflix, and Uber also rely publicly on monorepo approaches.
- Predicted future: VCSs scale to larger repositories while also stitching small ones together; someone catalyzes a de facto standard virtual monorepo for open source; the industry recognizes that version numbers are timestamps and that version skew adds a costly time dimension that can be engineered away.

## Actionable Guidance

- Use version control for any project bigger than a one-developer toy that will never be updated. Experienced engineers instinctively use it for anything lasting more than a day or two.
- When in doubt about which VCS to pick, use Git; the differences among modern VCSs are mostly user experience, and doing what everyone else does has value.
- Declare exactly one branch in one repository as the Source of Truth. Define "done" as landed there. Make sure no engineer ever faces uncertainty about where a change should be pushed.
- Adopt trunk-based development: small increments, committed frequently to trunk, backed by strong tests, CI, and code review. Keep the build green. Gate incomplete features off at runtime rather than parking them on branches.
- Do not use dev branches as a stability mechanism. If merges hurt, invest in testing and CI rather than slowing down and coordinating merges. Treat the appearance of a Merge Coordinator role or recurring merge-strategy meetings as a red flag of pure overhead.
- Enforce the One-Version Rule: one version of each third-party package checked in; no forking internal code without renaming; new dependencies never get a version choice. During upgrades, allow a second version only transiently, block new users of the old one, and migrate incrementally.
- Avoid shading, separate compilation, linker hiding, and similar tricks to tolerate multiple versions; that effort is lost labor servicing technical debt.
- Release branches are fine when releases live longer than a few hours or ship to the field: keep cherry-picks minimal, never plan to remerge into trunk, and abandon the branch when its release dies. If you reach Continuous Deployment, drop release branches.
- Permit long-lived dev branches only for rare, explicitly understood, expensive cases (data-at-rest or API compatibility over time). Keep them few, keep the compatibility window from silently growing, and consider a build horizon (mandatory rebuild/redeploy cadence) to cap version skew.
- Remember that all work in progress is effectively a branch; account for outstanding changes when planning refactorings and policies.
- Choose monorepo versus many-repo on your organization's secrecy, legal, and workflow needs, but keep inter-repository dependencies unpinned and at head/trunk, synthesizing a virtual monorepo experience if needed.

## The Chapter's TL;DRs (verbatim intent, faithfully captured)

- Use version control for any software development project larger than "toy project with only one developer that will never be updated."
- There's an inherent scaling problem when there are choices in "which version of this should I depend upon?"
- One-Version Rules are surprisingly important for organizational efficiency. Removing choices in where to commit or what to depend upon can result in significant simplification.
- In some languages, you might be able to spend some effort to dodge this with technical approaches like shading, separate compilation, linker hiding, and so on. The work to get those approaches working is entirely lost labor—your software engineers aren't producing anything, they're just working around technical debts.
- Previous research (DORA/State of DevOps/Accelerate) has shown that trunk-based development is a predictive factor in high-performing development organizations. Long-lived dev branches are not a good default plan.
- Use whatever version control system makes sense for you. If your organization wants to prioritize separate repositories for separate projects, it's still probably wise for interrepository dependencies to be unpinned/"at head"/"trunk based." There are an increasing number of VCS and build system facilities that allow you to have both small, fine-grained repositories as well as a consistent "virtual" head/trunk notion for the whole organization.
