# Chapter 16 Examples: Version Control and Branch Management

Every substantive example, case study, and anecdote from the chapter, retold in plain language. Domain terms are defined on first use.

## "Presentation v5 - final - redlines - Josh's version v2": life without version control

**Setup.** Imagine a small distributed team collaborating on a project with no Version Control System (VCS), a tool that tracks file revisions over time. The lowest-infrastructure option is to email or pass copies of the project back and forth.

**What happened.** This works only while edits never overlap in time. As soon as two people might edit simultaneously, nobody knows which copy is the most current. Everyone has lived this horror with documents named things like "Presentation v5 - final - redlines - Josh's version v2." Upgrading to a shared network drive helps a little but introduces new failures: with no file locking and no merge tracking, people overwrite each other's work, and anyone mid-edit breaks the build for everyone else working directly against the shared copy. Teams respond with out-of-band coordination ("I'm working on that file, don't touch it"), then encode that locking in software, then want line-level tracking.

**Lesson.** Each step of that response reinvents an early-generation VCS such as RCS. Structured version control is nearly inevitable for collaboration, so use an off-the-shelf tool instead of rebuilding one badly. The book returns to this file-naming image later: a distributed VCS (DVCS) community that refuses to name a Source of Truth risks a conceptual return to exactly this world.

## The new hire who has never needed version control

**Setup.** Version control can seem alien to people who have only done short-lived solo programming. Even at Google, a new hire may never have worked on code touched by more than one person or lasting more than a couple of weeks.

**What happened.** To that person, version control looks like an "undo button for a whole project": a weird, high-overhead luxury solving a problem they have never experienced. The same skepticism appears in organizations whose management views the job as "software development" (sit down and write code) rather than "software engineering" (produce code and keep it working over an extended period).

**Lesson.** Resistance to version control comes from conflating programming with software engineering. Once time and multiple developers enter the picture, version control becomes the primary tool for managing the interplay between source code and time.

## Scenario: a team with no clear Source of Truth

**Setup.** A team embraces the distributed VCS philosophy so fully that it refuses to declare any particular branch in any particular repository as the ultimate Source of Truth (the single place where a change counts as officially done).

**What happened.** After you pull from a teammate's repository, you cannot easily tell which changes you have and which you lack. The DVCS tracks patch merges at fine granularity, but the tool knowing what is merged is not the same as every engineer being sure they have everything relevant. Now try to cut a release containing all features developed over the past few weeks: without a central Source of Truth, someone must keep a hand-maintained list of which features are ready, and that bookkeeping just recreates a centralized Source of Truth with extra steps. There is no mechanism that stays sublinear in human effort as the team grows. And a new developer joining the team has no obvious place to get a fresh, known-good copy of the code.

**Lesson.** Even in a DVCS world, one repository and one branch must be defined as the Source of Truth. Centralization crept back into DVCS practice (GitHub's single primary repository per project) precisely because nothing else scales.

## Red Hat, Linus, and the Linux kernel: hierarchical Sources of Truth

**Setup.** Source of Truth is relative to the organization. The Linux kernel is developed across many companies, with Linus Torvalds as the overall maintainer.

**What happened.** A Red Hat engineer commits kernel patches to Red Hat's own Source of Truth repository. Red Hat periodically pushes changes upstream. Linus maintains a completely different notion of the Source of Truth. Engineers at Google or Red Hat legitimately hold different Sources of Truth for kernel patches than Linus does.

**Lesson.** DVCS works fine when organizations and their Sources of Truth form a hierarchy that is invisible from outside. The requirement is not one global truth but zero ambiguity: as long as no engineer ever faces choice or uncertainty about where a change gets pushed, the chaotic scaling problems of the DVCS model are avoided.

## Perforce's two revision numbers: work in progress is a branch

**Setup.** Perforce is a commercial centralized VCS. The chapter argues that every piece of uncommitted work in progress is conceptually a branch, even in centralized systems.

**What happened.** Perforce makes this explicit by giving every change two revision numbers: one marking the implicit branch point where the change was created, and one marking where it was recommitted. Perforce users can query who has outstanding changes to a given file and inspect other users' pending, uncommitted edits.

**Lesson.** Uncommitted local changes are not conceptually different from committed changes on a branch; they are just harder to find and diff against. Branch-management policy discussions must account for all work in progress, not just named branches.

## "Rename Widget to OldWidget": what does a refactoring actually cover?

**Setup.** A developer is told to rename a class called Widget to OldWidget. Because work in progress is akin to a branch, the instruction is ambiguous.

**What happened.** The task has at least three interpretations: rename Widget on the trunk branch of the Source of Truth repository; rename it on all branches of that repository; or rename it on all branches *and* chase down every developer with outstanding uncommitted changes referencing Widget. The authors speculate that supporting the third interpretation is why commercial centralized VCSs track "which engineers have this file open for editing" (though they do not consider that a scalable way to refactor).

**Lesson.** An organization's branch-management policy determines what "everywhere" means for a refactoring. The more long-lived branches and hidden work in progress exist, the more expensive and ill-defined codebase-wide changes become.

## The pending-edits anecdote: 27 outstanding changes to one file

**Setup.** (Footnote anecdote by the author, Titus Winters.) To illustrate why lock-based coordination cannot scale, he checked how many pending, unsubmitted edits Googlers had outstanding for one semi-popular file in his recent project.

**What happened.** Twenty-seven changes were pending: 12 from his own team, 5 from related teams, and 10 from engineers he had never met. This was normal and working as expected.

**Lesson.** Technical systems or policies that require out-of-band coordination (like exclusive file locks) cannot scale to round-the-clock software engineering across distributed locations where dozens of strangers legitimately edit the same file concurrently.

## How organizations become addicted to dev branches

**Setup.** In the era before consistent unit testing, any change carried high regression risk, so teams protected trunk: "We don't commit to trunk until changes pass a full round of testing; we use feature-specific development branches instead." A development branch (dev branch) parks work between "done but not committed" and "what new work is based on."

**What happened.** The organization observes that merging a long-lived dev branch reduced stability and draws the wrong conclusion: "branch merges are risky." Instead of fixing the real cause with better testing and abandoning branch-based development, it slows down and coordinates the symptom. Teams start branching off other in-flight branches. Long-lived branches sync with the main branch irregularly. As the organization grows, dev branches multiply and merge coordination consumes ever more effort. Some unlucky engineer becomes the dedicated Build Master / Merge Coordinator, the single point through which all branch merges flow. Regularly scheduled meetings "work out the merge strategy for the week," and teams not chosen to merge must re-sync and retest after each big merge. (A footnote adds informal polling data: about 25% of software engineers report having been subjected to regularly scheduled merge-strategy meetings.)

**Lesson.** All of that merging and retesting is pure overhead with no product value. The alternative paradigm is trunk-based development: rely heavily on testing and Continuous Integration, keep the build green, disable incomplete features at runtime, and have everyone sync to trunk and commit small changes. Small merges by the change's author are strictly easier to write, test, and debug than batched merges of unrelated work.

## Google's Piper monorepo by the numbers

**Setup.** Google stores almost all of its source code (Search, Gmail, ads, Google Cloud Platform, and supporting infrastructure; excluding large open source projects like Chromium and Android) in a single shared repository, a monorepo, used by roughly 50,000 engineers.

**What happened.** The monorepo runs on Piper, an in-house centralized VCS built as a distributed microservice on Google's standard production storage and compute. It holds more than 80 TB of content and metadata and absorbs 60,000 to 70,000 commits per workday from humans and semi-automated processes. Despite the scale, human-facing operations stay cheap: creating a new client at trunk, adding a file, and committing takes about 15 seconds. Because Piper is in-house, Google enforces policy inside the VCS itself: OWNERS files at every level of the file hierarchy list the engineers allowed to approve commits in that subtree, and because ownership is just a text file, reorganizations require no repository surgery. Attempts to migrate to common external tools like Git have been stymied by the sheer size of the codebase and userbase plus Hyrum's Law (users depending on incidental properties of the interface; for example, internal scripts assume commit numbers increase monotonically in time order, which Git's hashes would break).

**Lesson.** Massive-scale centralized version control is viable if designed for scale from the start, and owning the VCS turns policy (ownership, approval) into enforced mechanism. Cloud-centric centrality avoids the waste of the DVCS model, in which every developer downloads a whole codebase they will barely touch.

## Scenario: the forked Abseil library (multiple available versions)

**Setup.** Abseil (Google's common C++ infrastructure library; Guava is the Java analog) has a bug. A team, instead of fixing the bug in place, forks the library inside the monorepo and tweaks its copy to work around the bug, without renaming the library or its symbols. The team tells nearby teams, "We have an improved version of Abseil checked in over here," and other teams build libraries on top of the fork.

**What happened.** The codebase is now silently partitioned into an "original flavor" side and a "fork" side. Any project whose transitive dependencies pull in both versions at once will, at best, fail to build; at worst it links two mismatched versions of the same library and suffers baffling runtime bugs. Every target's transitive dependency set must contain exactly one copy of the library, so adding a single innocent-looking dependency edge can violate the partition. Verifying that a new dependency is safe could require running every test in the entire codebase. Technical escape hatches exist in some languages—Java's shading practice renames a library's internal dependencies to hide them from the rest of the application—but shading only works for functions. For types that pass between packages (vocabulary types), no efficient shading-like trick works in theory or practice.

**Lesson.** This is why the letter of "single repository" is not enough; the One-Version Rule is the real principle: developers must never have a choice of which version of a component to depend on. Any policy allowing multiple versions in one codebase invites expensive incompatibilities, and workarounds like shading are lost labor spent servicing technical debt.

## The new Widget on a parallel branch: choice creeping back

**Setup.** An infrastructure team builds a new Widget, better than the old one. Excitement spreads and newly started projects ask, "Can we depend on your new Widget?" But the new Widget exists only on a long-lived parallel dev branch.

**What happened.** If projects are allowed to depend on the branch-only Widget, choice has crept back into the ecosystem: new development now picks between old Widget on trunk and new Widget on a branch, recreating the multiple-versions problem.

**Lesson.** New development must never face a version choice when adding a dependency. The new Widget should be committed to trunk, disabled at runtime until ready, and hidden from other developers via visibility controls if possible; or the old and new Widgets should be designed to coexist in the same linked program. This is the One-Version Rule applied to branches, and one more reason long-lived dev branches should be rare.

## Google's rare legitimate long-lived branches and the six-month build horizon

**Setup.** Across the roughly 1,000 teams working in the Google monorepo, only a couple (fewer than 10) maintain a long-lived dev branch in parallel with trunk.

**What happened.** Each such branch exists for a very specific, unusual compatibility-over-time requirement. Typical cases: readers and writers of a stored file format must agree on that format across versions even as implementations change (data-at-rest compatibility), or an API promises that an old microservice client keeps working with a newer server or vice versa. Google limits how bad version skew can get with a "build horizon": every job in production must be rebuilt and redeployed at least every six months, and usually far more often. Internally, Google production services make relatively few compatibility-over-time promises (cloud-facing interfaces are the exception).

**Lesson.** Dependency across time is far more costly and complicated than time-invariant code. Long-lived dev branches can be justified, but only rarely, only for explicit compatibility requirements, and only with active effort to keep the compatibility window from growing. Tooling that works great at trunk and poorly on branches usefully pressures developers to stay current.

## Release branches at Google, and why CD teams skip them

**Setup.** A release branch snapshots the exact code that went into a release build; critical fixes are cherry-picked (minimally, surgically merged) from trunk onto it. Many Google teams use release branches with limited cherry-picks.

**What happened.** Teams that ship monthly releases or physical devices find release branches valuable: it pays to know exactly what version is in the field. In Google's experience these branches cause no widespread cost beyond the inherent VCS overhead, because unlike dev branches they are never merged back; they are abandoned when their release dies. Meanwhile, DORA (DevOps Research and Assessment, Google's research group behind the State of DevOps reports and the book Accelerate) finds that the highest-performing organizations it studies have practically no release branches, because they have achieved Continuous Deployment: they release from trunk many times a day, so adding the fix to trunk and redeploying beats cherry-picking. The same DORA research finds trunk-based development and the absence of long-lived dev branches strongly correlated with, and predictive of, high organizational performance.

**Lesson.** The technology of branches is not the problem; the usage is. Release branches are benign because their end state is abandonment; dev branches are harmful because their end state is a merge. And the better your deployment velocity, the less you need branches at all.

## Monorepo versus many filesystems: the storage-format analogy

**Setup.** After publishing its much-cited 2016 paper "Why Google stores billions of lines of code in a single repository" (Potvin and Levenberg, Communications of the ACM), Google asks whether the monorepo is the One True Way, given that the open source world thrives on countless uncoordinated repositories.

**What happened.** The chapter answers no, via an analogy: choosing repository layout is like choosing between one very large logical filesystem spanning ten drives versus ten smaller filesystems accessed separately. Each has trade-offs in resilience, size limits, performance, cross-boundary references, and synchronization. Similarly, Git submodules, Bazel external dependencies, and CMake subprojects let organizations stitch fine-grained repositories into a "virtual monorepo" (VMR): a federated view with an agreed commit ordering and dependency graph. Fine-grained repositories scale more easily (Git struggles after a few million commits and clones slowly with big binary artifacts) and isolate secret or experimental projects while still honoring One Version. Microsoft, Facebook, Netflix, and Uber also publicly rely on monorepo approaches, which the chapter takes as evidence the model is not a Google-only quirk.

**Lesson.** If every project in the organization shares the same secrecy, legal, privacy, and security requirements, a true monorepo is fine; otherwise aim for monorepo functionality through a virtual monorepo. Your choice of filesystem format matters less than what you write to it; the non-negotiable part is the One-Version principle.

## The predicted future: a virtual monorepo for open source

**Setup.** The chapter closes by extrapolating version control's direction over the next 10 to 20 years.

**What happened (the projection).** Large Linux distributions already discover and publish mutually compatible revisions of thousands of packages. Add unit tests, Continuous Integration, and automatic version bumping for new submissions, and a package owner could update "trunk" for their package in a nonbreaking way inside a published virtual-monorepo view of the open source ecosystem. Once someone assembles a big enough nugget of compatible interdependent projects and publishes such a VMR, the authors expect open source developer practices to shift toward it. They also note, self-critically, that even though Piper served Google well, investing in a highly scaling VMR with per-repository policy customization might have been the better investment.

**Lesson.** Version numbers are really timestamps, and allowing version skew adds a whole costly dimension (time) to software development. A virtual monorepo with a One-Version Rule removes that dimension, which is why the industry keeps reinventing lightweight inter-repository linkage and why the authors expect the model to spread.
