# Chapter 18 Examples: Build Systems and Build Philosophy

Every substantive example, case study, and anecdote from the chapter, retold. Context: the chapter argues that build systems (the machinery that turns source code into runnable binaries) should be *artifact-based* — engineers declare what to build and the system controls how — rather than *task-based*, where engineers write arbitrary build scripts.

## Googlers love their build system

**Setup.** The chapter opens by asking what Google engineers like most about working at Google.

**What happened.** A surprising common answer is the build system. In an internal survey, 83% of Googlers reported satisfaction with the build system, making it the fourth most satisfying tool of 19 surveyed (the average tool scored 69%). Blaze, Google's internal build tool, has been reimplemented multiple times by ex-Googlers after leaving the company — that is how the open-source tools Buck (Facebook) and Pants came to exist. Google itself open-sourced an implementation of Blaze as Bazel in 2015.

**Lesson.** A build system done well is not plumbing that engineers tolerate; it is infrastructure they actively miss when it is gone, and worth heavy investment.

## `javac *.java`: when a bare compiler is enough — and when it stops being enough

**Setup.** Most programmers start their careers without a build system, invoking a compiler like `gcc` or `javac` directly.

**What happened.** `javac *.java` compiles every Java file in a directory and works perfectly for a small single-directory project. But the compiler cannot find code elsewhere on the filesystem (like a library shared across projects), cannot build other languages, and knows nothing about external dependencies. The best a build-system-less team can do with third-party libraries is download JAR files from the internet into a `lib` folder — and then slowly forget what is in there, where each file came from, whether it is still used, and how to update it.

**Lesson.** A compiler alone handles only single-language, single-directory, dependency-free code. Everything past that needs dependency management, which is a build system's real job.

## The hobby-project shell-script death spiral

**Setup.** A hypothetical developer outgrows the bare compiler and automates the build with shell scripts. The chapter walks through the escalating failures.

**What happened.**
1. The scripts grow hacks on hacks; the developer spends nearly as much time debugging build scripts as writing real code.
2. To stay safe from stale outputs the script rebuilds everything every time, so builds are slow; hand-writing staleness detection looks too error-prone to attempt.
3. Release day requires memorizing `jar` arguments, upload steps, documentation pushes, and user notifications — so more scripts get written.
4. A hard-drive crash reveals that while the source was in version control, the downloaded libraries, tool locations, and long-forgotten environment variables were not, and the build environment cannot be reconstructed.
5. Hiring reveals the same problem without any disaster: every new engineer endures hours of debugging tool paths and library versions because every machine differs slightly.
6. Automating the build on a cron machine removes the human who used to paper over environment drift, so the nightly build breaks constantly from changes that "worked on my machine."
7. As the project grows, builds crawl while a vacationing coworker's powerful desktop sits idle — computational power the script-based build has no way to use.

**Lesson.** This is a classic scaling problem. Scripts can stretch a compiler-only workflow slightly, but the moment multiple developers and machines must coordinate, machine-to-machine differences overwhelm even a perfect build script. That is the point where a real build system becomes necessary.

## The Ant buildfile: how a task-based build works

**Setup.** The chapter reproduces a sample buildfile from the manual of Ant, a task-based build tool released in 2000, to show the anatomy of task-based builds. The XML file defines tasks — `init`, `compile`, `dist`, `clean` — where `dist` depends on `compile`, which depends on `init`.

**What happened.** When a user runs `ant dist`, Ant parses the buildfile into a dependency graph (a directed acyclic graph), walks from `dist` back through `compile` and `init`, then executes the tasks in dependency order. The net effect is equivalent to a five-line shell script (make a timestamp, make a build directory, run `javac`, make a dist directory, run `jar`). The gain over the raw script: buildfiles in different directories can link together, new tasks can depend on existing ones arbitrarily, and the user only ever names one task on the command line. Successors like Maven and Gradle improved on Ant (automatic external-dependency management, no XML) but kept the same task-based nature.

**Lesson.** Task-based systems are a principled, modular improvement over ad-hoc scripts — but the unit of work is still an arbitrary script, which is exactly what limits them.

## Tasks B and C: why task-based builds cannot parallelize

**Setup.** Task A depends on tasks B and C; B and C do not depend on each other. A modern multi-core workstation should be able to run B and C simultaneously.

**What happened.** Maybe B and C are safe to run together — but maybe both write to the same status file, and running them concurrently corrupts it. The build system has no way to know, because tasks are opaque scripts. So it must either gamble (producing rare, brutal-to-debug failures) or serialize the entire build on a single thread — wasting the machine and ruling out distributing the build across many machines.

**Lesson.** When the system cannot see inside its units of work, it must be maximally conservative. Opacity is the root cause of slow task-based builds.

## The `clean` habit: why task-based incremental builds fail

**Setup.** Incremental builds — rebuilding only what changed — are essential for fast iteration. Some task-based systems let engineers hand-specify when a task needs rerunning.

**What happened.** Because a task can do anything (download a file, stamp a timestamp), the system cannot prove its previous output is still valid, so correctness demands rerunning everything. Hand-written staleness rules are subtler than they look — in C++, where files textually include other files, you cannot even enumerate the files to watch without parsing the sources. Engineers take shortcuts, the shortcuts occasionally reuse stale results, and after being burned engineers adopt the habit of running `clean` before every build — which throws away all incremental state and defeats the entire purpose.

**Lesson.** Deciding when work must be redone is a job for machines with complete input/output information, not for humans writing heuristics.

## Five classic task-based build bugs

**Setup.** Build scripts are code, but they get less scrutiny than production code. The chapter catalogs recurring bug patterns.

**What happened.**
1. Task A silently relies on the file location where task B writes output; B's owner moves the output and A breaks with no warning until someone runs it.
2. A depends on B, B depends on C, and A actually consumes a file produced by C. B's owner correctly removes B's dependency on C — and A breaks, even though B never cared about C.
3. A task author bakes in an assumption about their machine (a tool path, an environment variable); the task works for them and fails for everyone else.
4. A task includes nondeterminism — an internet download, a timestamp — so different runs produce different results, and engineers cannot reproduce one another's failures or CI's failures.
5. Tasks B and C both modify the same file, and task A depends on both; A's result depends on which finishes first — a race condition.

**Lesson.** None of these have a general fix inside the task-based model. As long as engineers write arbitrary build code, the system lacks the information to be fast and correct. The fix is structural: take power from the scripts and give it to the system.

## `bazel build :MyBinary`: the artifact-based build walkthrough

**Setup.** The chapter shows a Bazel `BUILD` file defining two targets: `MyBinary` (a `java_binary` built from `MyBinary.java`) and `mylib` (a `java_library` built from two source files, with dependencies on two other packages and an external Guava JAR). Targets declare their name, sources (`srcs`), and dependencies (`deps`).

**What happened.** On `bazel build :MyBinary` in a clean repository, Bazel parses all BUILD files into an artifact dependency graph, computes MyBinary's full transitive dependency set, builds (or downloads) each dependency as soon as its own dependencies are done, then links the final binary. Superficially this resembles the Ant flow — but because Bazel *knows* each target only runs the Java compiler, it can safely build independent targets in parallel, yielding order-of-magnitude speedups on multicore machines. Run the same command a second time with no changes and Bazel exits in under a second: "target up to date." Change `MyBinary.java` and only `MyBinary` rebuilds while `mylib` is reused; change a file in a low-level library and exactly the affected chain rebuilds while unrelated siblings are reused — with a guarantee of no stale results.

**Lesson.** Declaring artifacts instead of scripting tasks looks like a subtle reframing but is the foundation for parallelism, minimal rebuilds, and eventually distributed builds. Less flexibility for the engineer means more knowledge — and more power — for the system.

## The Guava hash: taming external dependencies

**Setup.** The example BUILD file's `@com_google_common_guava_guava//jar` dependency downloads the Guava library JAR from Maven, a public artifact repository. Files fetched from outside the workspace can change at any time, silently breaking reproducibility — and if an attacker compromises the third-party server, they can substitute a malicious artifact and take control of your build output (a software supply-chain attack).

**What happened.** Bazel requires a workspace-wide manifest listing a cryptographic hash for every external dependency. On each build, Bazel compares its cached copy's hash to the manifest and re-downloads only on mismatch; if a downloaded artifact's hash disagrees with the manifest, the build fails until the manifest is updated via a reviewed source-control change. So dependency updates are always deliberate, recorded, and rollback-able, and checking out last week's commit builds with last week's dependencies. (Go later adopted essentially the same hash-manifest scheme for its modules.) The chapter adds the availability caveat: hashes cannot save you if the remote server goes down or serves corrupt data, so any nontrivial project should mirror its dependencies onto servers it controls.

**Lesson.** Determinism plus security for external dependencies comes from content hashes checked into source control; availability comes from mirroring. You need both.

## ObjFS and Forge: Google's distributed build system

**Setup.** Google's codebase exceeds two billion lines of code; even simple binaries depend on tens of thousands of build targets. No single machine can build at that scale, so since 2008 Google has run a distributed build combining remote caching and remote execution.

**What happened.** **ObjFS** is the remote cache: build outputs live in Bigtable (Google's distributed storage system) across the production fleet, and a FUSE daemon called `objfsd` on each workstation exposes those outputs as if they were ordinary local files — downloading content on demand only for files the user actually opens. On-demand serving cut network and disk usage so much that builds run twice as fast as when all outputs were written to the developer's local disk. **Forge** is the remote execution system: a Blaze client called the Distributor sends each build action to a datacenter Scheduler, which keeps a cache of action results and can answer instantly if *any* user has already run that action; misses go into a queue consumed by a large pool of Executor jobs, which write results straight into ObjFS's Bigtables for other executors and end users. The combined system runs millions of builds and millions of test cases and produces petabytes of build outputs from billions of lines of code every day.

**Lesson.** The artifact-based guarantees — self-describing environments, self-contained steps, deterministic outputs — are exactly what make a shared cache and a shared worker pool trustworthy. Open-source equivalents now exist, and the chapter judges the deployment effort "truly magical" for engineers and usually worth it.

## Strict transitive dependencies: a multiyear Google refactor

**Setup.** Internal dependency question: if target A depends on B, and B depends on library C, may A use classes from C directly? The linker happily allows it — C's symbols are linked into A anyway — and Blaze permitted it for years.

**What happened.** As Google grew, the permissiveness backfired. When B was refactored to no longer need C and dropped that dependency, A — and every other target that reached C through B — broke. In effect, every target's dependency list had become part of its public contract; nobody could ever safely remove a dependency, so dependencies only accumulated, and builds across Google slowed down. Google introduced a "strict transitive dependency mode" in Blaze: if a target references a symbol without directly depending on the target that provides it, the build fails with an error message that includes a shell command to auto-insert the missing dependency. Rolling this out — refactoring millions of build targets to explicitly list their dependencies — took multiple years. The payoff: much faster builds (targets carry fewer unnecessary dependencies) and engineers can now delete unused dependencies without fear. The cost: more verbose BUILD files, which Google mitigated with tools that auto-detect and add missing dependencies. Bazel enforces this mode for Java by default.

**Lesson.** Explicitly declaring a dependency is a one-time cost; implicit transitive dependencies impose an ongoing tax for the life of the target. At scale, strictness wins decisively.

## The diamond dependency problem and the One-Version Rule

**Setup.** Nothing technically prevents declaring multiple versions of the same external library under different names and letting each target pick one. Google tried the equivalent and found it disastrous, so it enforces a strict One-Version Rule: exactly one version of each third-party library exists in the entire codebase.

**What happened.** The failure mode is the diamond dependency problem. Target A depends on target B and also on version 1 of an external library. Later, B is refactored to depend on version 2 of that same library. Now A transitively requires both v1 and v2 simultaneously and breaks — through no change of its own. Generalized: when multiple versions are allowed, adding a dependency on *any* third-party library is never safe, because some existing consumer may already depend on a different version. Under the One-Version Rule, any new third-party dependency is guaranteed to match every existing one, so the conflict cannot occur.

**Lesson.** Version multiplicity turns every dependency edge into a latent conflict. One version per library per repository makes the whole class of failures impossible.

## Gradle's `1.+` and Maven's transitive downloads: automatic dependency management as a trap

**Setup.** Some build tools manage external-dependency versions automatically. Gradle lets a buildfile declare a version as `"1.+"`, meaning "any 1.x release"; Maven Central lets artifacts declare their own dependencies, and tools like Maven and Gradle recursively download those transitive dependencies, so adding one library can pull in dozens of artifacts.

**What happened.** With automatic versions, you never control when a version changes. External maintainers ship breaking updates (even under the banner of semantic versioning), so a build that worked yesterday fails today with no obvious cause and no clean rollback — or worse, behavior and performance shift subtly with nothing to diff. With automatic transitive downloads, different libraries pull different versions of the same underlying dependency, violating the One-Version Rule and triggering diamond conflicts; updating one library can break seemingly unrelated code across the repository. Bazel therefore requires manual versions for everything and refuses to auto-download transitive dependencies, instead requiring one global file that pins every external dependency's version — with a tool that can generate that file from a set of Maven artifacts and then be hand-maintained.

**Lesson.** Automatic dependency management is convenient at toy scale and a "recipe for disaster" beyond it. Pinned, source-controlled versions cost a little convenience and buy discoverability, rollback, and reproducibility.

## Google's `third_party` directory: vendoring at monorepo scale

**Setup.** The chapter surveys defenses against third-party risk: mirroring artifacts onto servers you control (fixes availability and security), pinning hashes (fixes security only), and a third option — vendoring, meaning checking external dependencies' code or binaries directly into your own repository.

**What happened.** Google vendors everything: every third-party library used anywhere at Google is checked into a `third_party` directory at the root of Google's single source tree, converting all external dependencies into internal ones that build from source at a single revision. The chapter is explicit about the caveat: this works because Google's source-control system is custom-built to handle an extremely large monorepo (one repository holding the whole company's code); most organizations' version control could not absorb it.

**Lesson.** Vendoring is the most complete answer to external-dependency risk, but it presumes infrastructure that can carry the weight. Mirroring plus hash-pinning is the practical route for most teams.

## Publishing internal artifacts versus remote caching

**Setup.** Some organizations package their own slow-to-build components as versioned binary artifacts in an artifact repository, so other teams depend on them like third-party libraries instead of building them from source — trading consistency for speed.

**What happened.** The chapter argues the overhead is worse than it looks: someone must own building and uploading every artifact, clients drift behind the latest version, and debugging degrades because different parts of the running system were built from different points in the repository's history, destroying the single consistent view of the source tree. The better answer to "this takes too long to build" is a remote build cache: every build's outputs are saved to shared storage, so anyone depending on something a colleague recently built downloads it automatically — the speed of prebuilt artifacts with the consistency of building everything from one revision. This is what Google does internally, and Bazel supports it.

**Lesson.** Do not solve slow builds by fragmenting your source of truth into versioned internal artifacts; solve them with caching that preserves one consistent tree.
