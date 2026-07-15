# Chapter 18: Build Systems and Build Philosophy

*Software Engineering at Google* — written by Erik Kuefler, edited by Lisa Carey.

## Chapter Thesis

A build system is the machinery that turns source code into executable binaries, and it is one of the most important pieces of infrastructure an engineering organization owns, because every developer touches it dozens or hundreds of times a day. The chapter's central and counterintuitive lesson is that **restricting engineers' power and flexibility makes builds faster, more correct, and more scalable**. Google achieved this by moving from "task-based" build systems (where engineers write arbitrary scripts) to an "artifact-based" build system (Blaze internally, open-sourced as Bazel), in which engineers declaratively state *what* to build and the system fully controls *how*. That constraint is what unlocks safe parallelism, reliable incremental builds, remote caching, and fully distributed builds — and the same declarative discipline extends to dependency management through fine-grained modules, minimal visibility, explicit versioning, and the One-Version Rule.

## Core Principles and Ideas

### What a build system is for

- A build system transforms source code written by engineers into executable binaries that machines can run.
- A good build system optimizes for two properties:
  - **Fast** — a developer types one command and gets a binary back, ideally in seconds.
  - **Correct** — every build of the same inputs produces the same result on any machine.
- Older build systems trade correctness for speed via shortcuts. Bazel's design goal is to refuse that trade-off and deliver both.
- Build systems serve machines as much as humans. Most builds at Google are triggered automatically: continuous delivery pipelines, pre-review and pre-merge testing, whole-codebase testing of low-level library changes, and large-scale changes (automated edits touching tens of thousands of files) all sit on top of the build system.

### Why a compiler or shell scripts are not enough

- Invoking a compiler directly (e.g. `javac *.java`) works only while all code lives in one directory, uses one language, and has no external dependencies.
- Shell scripts that sequence compiler calls are a primitive build system, and they break down predictably as a project scales: scripts become their own maintenance burden, full rebuilds are slow, releases require more scripts, environments cannot be reproduced after a disaster, every new hire needs painful manual setup, "works on my machine" failures multiply, automated nightly builds break constantly, and there is no way to use idle machines.
- The core insight: managing your **own** code is easy; managing **dependencies** is the hard part. A dependency is any "I need that before I can have this" relationship — on a task, on an artifact, on internal code, or on external third-party code. Managing dependencies is the most fundamental job of a build system.

### Task-based build systems

- In a **task-based build system** the fundamental unit of work is the *task*: a script that can execute arbitrary logic and declares other tasks as prerequisites. Tasks form a directed acyclic graph (a dependency graph with no cycles), and the tool runs tasks in dependency order. Ant, Maven, Gradle, Grunt, and Rake are all task-based.
- Task-based systems are strictly better than raw shell scripts: buildfiles are modular, tasks compose, and the tool computes execution order for you.
- Their fatal flaw is that they give **too much power to engineers and not enough to the system**. Because a task can do anything, the system cannot know what any task actually does, which causes three structural problems:
  - **Cannot parallelize safely.** Two tasks with no declared dependency between them might still touch the same file, so the system must either risk hard-to-debug conflicts or run everything serially on one thread — and distributed builds become impossible.
  - **Cannot do reliable incremental builds.** The system cannot prove a task's output is still valid (the task might download files or write timestamps), so it must rerun everything, or trust hand-written staleness rules that engineers inevitably get wrong. Engineers then habitually run `clean` before every build, defeating incrementality entirely.
  - **Hard to maintain and debug.** Build scripts are code with less scrutiny than production code, and they breed classic bugs: hidden dependencies on another task's output location, breakage when an intermediate task drops a dependency someone else relied on transitively, machine-specific assumptions, nondeterminism (downloads, timestamps), and race conditions between tasks that modify the same file.
- These problems have no general fix inside the task-based model. The fix is to reconceive the build system's job: not running tasks, but **producing artifacts**.

### Artifact-based build systems

- In an **artifact-based build system** (Blaze, and its descendants Bazel, Pants, and Buck), buildfiles are not imperative scripts. They are **declarative manifests** listing the artifacts to build, their dependencies, and a limited set of options. Engineers specify the *what*; the system owns the *how* — configuring, scheduling, and running every compilation step.
- **The functional-programming analogy.** Task-based systems are like imperative languages (a list of statements executed in order). Artifact-based systems are like functional languages (declare the computation, let the system decide when and how to run it). A build is literally a mathematical function from inputs (source files plus tools) to outputs (binaries), so functional principles — pure steps, no side effects, referential transparency — fit it perfectly and enable trivial parallelization and strong correctness guarantees.
- **Bazel concretely.** `BUILD` files define *targets* such as `java_binary` and `java_library`. Each target names an artifact and declares `srcs` (the source files compiled into it) and `deps` (other targets that must be built first and linked in). Dependencies can point within a package, across packages, or at external artifacts. A source tree rooted by a `WORKSPACE` file is called a *workspace*. Because Bazel knows a `java_library` target only ever runs the Java compiler, it knows the steps are safe to parallelize (often an order-of-magnitude speedup) and it knows outputs depend only on declared inputs, so unchanged targets are never rebuilt. Rebuilds cascade only through the minimum affected subgraph, with no possibility of stale results.
- **Tools are dependencies too.** Each target implicitly depends on its compiler/tools, pinned at the workspace level; Bazel downloads them if absent, and a tool change invalidates everything built with it. *Toolchains* extend this to platform independence: targets depend on a toolchain *type*, and the workspace maps each host/target platform to a concrete toolchain.
- **Extensibility via rules and actions.** Custom *rules* declare their input attributes and fixed outputs and generate *actions* — the lowest-level composable unit, each declaring its exact inputs and outputs and running one executable. The system schedules and caches actions. Pushing arbitrary logic down to the narrow action level drastically shrinks the room for error, and rule definitions live in one central place so most engineers never touch them.
- **Sandboxing (environment isolation).** Every action runs in a filesystem sandbox (enforced with technology like LXC on Linux, the mechanism behind Docker) that exposes only its declared inputs; undeclared writes are discarded and network access is blocked. Conflicts between actions become *impossible* rather than merely unlikely. This is the enforcement mechanism behind what the industry calls **hermetic builds**: builds that are self-contained, insensitive to the host machine's state, and fully reproducible from declared inputs.
- **Deterministic external dependencies.** A workspace-wide manifest records a cryptographic hash for every external dependency. The build fails if a downloaded artifact's hash mismatches, so a dependency cannot change without a corresponding, reviewed source-control change — every dependency update is recorded, reversible, and checking out last week's commit builds with last week's dependencies. Hashes protect integrity but not availability, so mirror dependencies onto infrastructure you control for any nontrivial project.

### Distributed builds

- At Google's scale (2+ billion lines of code; simple binaries depending on tens of thousands of targets) no single machine can build in reasonable time, so the work must spread across many machines. Artifact-based guarantees are the prerequisite; task-based systems cannot support this reliably.
- **Remote caching** is the simplest distributed form: all builders (workstations and continuous-integration systems) share a remote cache keyed on the target plus a hash of its inputs. Hits are downloaded instead of rebuilt, so rarely-changing low-level dependencies are built once for everyone. This only works if builds are fully reproducible, and it only pays off if download is faster than rebuild — measure network latency before deploying.
- **Remote execution** is the full form: a build master decomposes requests into actions and schedules them across a scalable worker pool; workers exchange intermediate artifacts through the shared cache; the user's local source changes are exported to the workers; the final output is downloaded back. Requirements: self-describing build environments, self-contained build steps, and deterministic outputs.
- **Google's implementation** (since 2008): **ObjFS**, the remote cache — build outputs in Bigtable storage with a FUSE daemon (`objfsd`) on each workstation serving file contents on demand, which doubled build speed versus storing outputs on local disk; and **Forge**, the remote execution system — a Blaze client (the Distributor) sends actions to a Scheduler that caches action results and queues misses for a large pool of Executors. The combined system handles millions of builds and test cases and petabytes of output daily.

### Time, scale, trade-offs

- DIY scripts suit only the smallest short-lived projects (or languages like Go with a built-in build system).
- Task-based systems add structure and reproducibility at the cost of writing buildfiles — worth it for almost everything beyond a single source file.
- Artifact-based systems unlock distribution and organization-wide consistency at the cost of flexibility; migration from an entrenched task-based build is expensive, so Google's advice is to **start new projects on an artifact-based system like Bazel from day one**. Inside Google, everything from tiny experiments to Google Search builds with Blaze.

### Modules and dependencies

- Projects on artifact-based systems decompose into **modules** (targets) connected via BUILD files. Module granularity trades performance against maintenance: one giant module cannot be parallelized, cached, or partially rebuilt; one module per file maximizes those benefits but multiplies dependency bookkeeping.
- Google favors **fine-grained modules** — production binaries commonly depend on tens of thousands of targets. For Java, the convention is one directory = one package = one target = one BUILD file, which Pants names the **1:1:1 rule**. Fine granularity also lets the system run only the subset of tests a change could affect. Google offsets the bookkeeping cost with tools that automatically manage BUILD files.
- **Visibility** is the mirror image of a dependency: target B must make itself visible to target A before A may depend on B. Minimize it like any API surface — public only for genuinely shared libraries, allowlists where coordination is required, private (the default posture) for internal implementation targets.
- **Internal dependencies** are built from source at the same repository revision, so they have no version. The key hazard is *transitive* use: if A depends on B and B depends on C, letting A use C's symbols turns B's dependency list into public contract, so dependencies can never be removed and accumulate forever. Blaze's **strict transitive dependency mode** fails the build when a target references a symbol it does not directly depend on (and prints the command to fix it). Rolling this out took Google years but made builds much faster and made dependency removal safe. Bazel enforces it for Java by default.
- **External dependencies** are prebuilt artifacts imported from outside the build, and unlike internal ones they have versions independent of your source.
  - **Manual over automatic versioning.** Automatic version ranges (e.g. Gradle's `"1.+"`) mean you never control when versions change; builds break or silently shift behavior with no discoverable cause and no rollback. Manually pinned versions live in source control and are discoverable, revertible, and time-travel-safe. Bazel mandates manual versions.
  - **The One-Version Rule.** Exactly one version of each third-party library may exist in the codebase. This eliminates the **diamond dependency problem**: A depends on B and on v1 of a library; B later adds a dependency on v2; A now implicitly needs two versions at once and breaks. With multiple versions permitted it is *never* safe to add a third-party dependency; with one version it always is.
  - **No automatic transitive downloads.** Maven/Gradle-style recursive fetching of a dependency's dependencies violates the One-Version Rule by construction. Bazel instead requires a single global file pinning every external dependency's version, with tooling to generate it from a set of Maven artifacts.
  - **Prefer remote caching over publishing internal artifacts.** Turning your own slow-to-build code into versioned binary artifacts fragments the source-of-truth and complicates debugging; a remote cache gives the same speed while everything still builds from one consistent source tree.
  - **Mirror or vendor.** Mirroring dependencies onto controlled servers addresses availability and security; pinned hashes address security alone. *Vendoring* — checking third-party code into your repository (Google's `third_party` directory) — converts external dependencies into internal ones entirely, but requires source control that can handle a very large monorepo.

## Actionable Guidance

- Adopt an artifact-based build system (e.g. Bazel) for new projects from the start; retrofitting later is far more expensive.
- Do not migrate an existing task-based build that shows no speed or correctness problems; migration is not always worth it.
- Keep build logic declarative. Never let arbitrary scripts run inside the build; if you must extend the system, write rules whose actions declare all inputs and outputs.
- Define fine-grained build targets. For Java-like languages follow the 1:1:1 rule: one directory, one package, one target, one BUILD file.
- Set every target's visibility as narrow as possible; make targets public only when they are intentionally shared libraries.
- Enforce strict transitive dependencies: every target explicitly lists everything it directly uses.
- Pin every external dependency to an explicit version in source control; never use "latest" or version ranges.
- Enforce the One-Version Rule for third-party libraries across the whole repository.
- Record a cryptographic hash for every external artifact and fail the build on mismatch.
- Mirror external dependencies onto servers you control (or vendor them) for any nontrivial project.
- Use remote caching to share build results across engineers and CI, keyed on target plus input hash — and benchmark that cache downloads actually beat local rebuilds.
- Invest in tooling that auto-maintains BUILD files and dependency lists so fine granularity does not become developer toil.
- Treat compilers and tools as pinned, versioned dependencies of the build rather than assuming what is installed on the machine.

## The Chapter's TL;DRs (verbatim)

- A fully featured build system is necessary to keep developers productive as an organization scales.
- Power and flexibility come at a cost. Restricting the build system appropriately makes it easier on developers.
- Build systems organized around artifacts tend to scale better and be more reliable than build systems organized around tasks.
- When defining artifacts and dependencies, it's better to aim for fine-grained modules. Fine-grained modules are better able to take advantage of parallelism and incremental builds.
- External dependencies should be versioned explicitly under source control. Relying on "latest" versions is a recipe for disaster and unreproducible builds.
