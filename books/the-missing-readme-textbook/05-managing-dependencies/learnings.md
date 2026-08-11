# Chapter 5: Managing Dependencies

Adding a dependency looks like a simple, DRY-friendly decision, but every dependency brings risk: incompatible changes, version conflicts, circular dependencies, and loss of control over your own build. This chapter teaches the mechanics of dependency management — versioning schemes, transitive dependencies, and dependency hell — and a set of defensive practices (skepticism, pinning, scoping, isolation) that keep other people's code from breaking yours.

## Core Concepts

### Dependencies, Scope, and Declarations
A dependency is code your code relies on. The time at which a dependency is needed — during compilation, testing, or runtime — is called its scope. Dependencies are declared in package-management or build files: Gradle or Maven configs for Java, `setup.py` or `requirements.txt` for Python, NPM's `package.json` for JavaScript. A declaration names the package, its version, and its scope (for example, `compile` scope means the dependency is needed to compile the code). Versioned packages exist to control when dependencies change and to resolve conflicts when different versions of the same package appear in a build.

### Properties of a Good Versioning Scheme
A good versioning scheme produces versions that are:

- **Unique** — never reuse a version. Artifacts get distributed, cached, and pulled by automated workflows; never republish changed code under an existing version number.
- **Comparable** — versions should let humans and tools reason about precedence. Precedence is what resolves conflicts when a build depends on multiple versions of the same artifact.
- **Informative** — versions should distinguish prereleased from released code, associate build numbers with artifacts, and set stability and compatibility expectations.

Git hashes and "marketing" version names (Android's dessert series, Ubuntu's alliterative animals) are unique but neither comparable nor informative. A monotonically increasing counter (1, 2, 3) is unique and comparable but not informative. Semantic versioning satisfies all three properties.

### Semantic Versioning (SemVer)
SemVer is one of the most widely used versioning schemes (spec at semver.org). It combines three numbers into MAJOR.MINOR.PATCH (patch is sometimes called the micro version). Versions are used once and compare left to right (2.13.7 precedes 2.14.1), and they encode compatibility expectations:

- **Patch** increments for backward-compatible bug fixes.
- **Minor** increments for backward-compatible features.
- **Major** increments for backward-incompatible changes.

Major version 0 is considered "prerelease": it exists for fast iteration, makes no compatibility guarantees, and developers may break APIs freely (add required parameters, delete public methods). The guarantees above apply starting with major version 1.

SemVer also defines:
- **Prerelease versions** — a hyphen after the patch, with dot-separated alphanumeric identifiers (2.13.7-alpha.2). Prereleases may make breaking changes without bumping the major version. Release candidate (RC) builds let early adopters find bugs before the official release; RCs get incremental identifiers (3.0.0-rc.1), and the final RC is promoted by re-releasing it without the suffix. The final release supersedes all prereleases.
- **Build metadata** — a build number appended after version and prerelease metadata (2.13.7-alpha.2+1942), which helps developers and tools find the build logs for any compiled version.
- **Wildcard ranges** (2.13.*) — because SemVer promises compatibility across minor and patch versions, builds should keep working as updated versions with bug fixes and features are pulled in automatically.

### Transitive Dependencies
Build files show only your direct dependencies, which are a subset of what the build actually uses. Dependencies depend on other libraries, which become your transitive dependencies. A dependency report shows the fully resolved dependency tree (or dependency graph); most build and packaging systems can produce one (for example, `gradle dependencies`).

Understanding transitive dependencies is critical: adding a single dependency seems like a small change, but if that library depends on 100 others, your code now depends on 101 libraries, and a change in any one of them can affect your program. Know how to generate a dependency report in your build system so you can debug conflicts.

### Dependency Hell
Dependency hell is every engineer's nightmare: conflicting versions of the same library, or an incompatible library upgrade, break builds and cause runtime failures. The most common culprits:

- **Version conflicts.** Two parts of the dependency tree require different versions of the same library. A project can't use two versions of a library simultaneously, so the build system must pick one — typically upgrading the older requirement across the whole project. The losing library may not work correctly with the version it was forced onto, especially when a related companion dependency was not upgraded along with it.
- **Diamond dependencies.** The shape that produces version conflicts: your project depends on two libraries, and both depend (at different versions) on a common third library — a diamond in the dependency graph.
- **Circular (cyclic) dependencies.** Even nastier than the other two: a library transitively depends on itself (A depends on B, B on C, C on A). This creates a chicken-and-egg problem: upgrading one library breaks the other. Utility and helper projects commonly end up in cycles because they get depended on from both directions.

A key warning: SemVer's compatibility promise is aspirational. Projects often set version numbers without compatibility checks, automation can't fully guarantee compatibility, and incompatible changes slip into minor and patch releases, wreaking havoc on your codebase. Don't assume an automatic within-major upgrade is safe.

### Avoiding Dependency Hell: Be Skeptical First
You will absolutely stumble into dependency hell. Dependencies are unavoidable — there are many libraries you should not write from scratch, like database drivers, application frameworks, and machine learning packages — but every new one comes with a cost; only add it when its value outweighs that cost. Ask:

- Do you really need the functionality?
- How well maintained is the dependency?
- How easy would it be for you to fix the dependency if something went wrong?
- How mature is the dependency?
- How frequently does it introduce backward-incompatible changes?
- How well do you, your team, and your organization understand the dependency?
- How easy is it to write the code yourself?
- How is the code licensed?
- What is the ratio of code you use versus code you don't use in the dependency?

### Isolate Dependencies (Copy, Vendor, Shade)
You don't have to leave dependency management to build and package systems; dependent code can be copied, vendored, or shaded.

- **Copying** code into your project trades dependency-management automation for isolation (stability). You pick exactly the code you use, but you must manage the copying yourself. DRY discourages duplication, but be pragmatic: don't be afraid to copy code if it lets you avoid a big or unstable dependency — provided the software license allows it. Copying works best on small, stable fragments; manually copying entire libraries loses version history and forces you to recopy on every update.
- **Vendoring** embeds complete library copies in vendor folders, using vendor tools (such as `git-subtree` or `git-vendor`) to manage history and updates. Some packaging systems, like Go's, have built-in vendor-folder support.
- **Shading** automatically relocates a dependency into a different namespace (`some.package.space` becomes `shaded.some.package.space`) to avoid conflicts — a friendly way to keep libraries from forcing their dependencies onto applications. It comes from the Java ecosystem but the concept applies broadly (Rust uses similar techniques). Shading is an advanced technique to use sparingly: never expose a shaded dependency's objects in public APIs (users would have to construct objects in the shaded namespace, which is tricky or sometimes impossible, and shading is meant to hide the dependency's existence), and beware that shaded package names differ in the build artifact, which confuses developers. Shade only when you are creating a library with widely used dependencies that are likely to create conflicts.

### Deliberately Add Dependencies
Explicitly declare as dependencies all libraries you use. Don't use methods or classes from transitive dependencies, even when it seems to work: libraries are free to change their own dependencies even in patch-level version bumps, and your code will stop working when a transitive dependency you relied on gets dropped during an upgrade. If you use classes from a sub-dependency, declare a direct dependency on that library.

Don't rely solely on the IDE for dependency management. IDEs often store dependencies in their own project configuration, which the build machinery doesn't look at. Inconsistency between IDE and build files makes code work in the IDE but not in the actual build, or vice versa. Declare dependencies explicitly in build files.

### Pin Versions
Explicitly set every dependency's version number — a practice called version pinning. Unpinned versions are decided by the build or package-management system, and leaving your fate to the build system is a bad idea: your code destabilizes when dependency versions change between consecutive builds. Unpinned versions pull in more than the latest bug fixes; they pull in the latest bugs, behavior changes, and even incompatible changes.

Three pinning strategies, from loosest to tightest:
- **Unbounded ranges** (`>=0.9.1`) — maximum flexibility, maximum exposure to breakage.
- **Bounded ranges** (`>=1.1.2,<3.0.0`, possibly excluding specific known-bad versions) — a compromise: the resolver can still resolve conflicts and update dependencies, but exposure to breaking changes is limited.
- **Exact pins** (`==1.1.0`) — full determinism for that dependency.

Even if you pin your direct dependencies, transitive dependencies might still have wildcards. Pin them by generating a complete manifest of all resolved dependencies and their versions — lockfiles, by many names: frozen requirements in Python, `Gemfile.lock` in Ruby, `Cargo.lock` in Rust. Build systems use manifests to produce identical results on every execution; developers regenerate them explicitly when they want to change a version. Commit manifests alongside your code so you can explicitly track changes to any dependency, giving you the opportunity to prevent problems.

### Scope Dependencies Narrowly
Scope defines when in the build lifecycle a dependency is used, and scopes form a hierarchy: compile-time dependencies are also used during runtime, but runtime dependencies are not used to compile code, only to run it; test dependencies are pulled in only for test execution and aren't necessary for normal use of the published code. Use the narrowest possible scope for each dependency. Declaring everything with compile-time scope will work, but it's bad practice: narrow scoping helps avoid conflicts and reduces runtime binary sizes.

### Protect Yourself from Circular Dependencies
Never introduce circular dependencies. They lead to strange build-system behavior and deployment-ordering problems: builds appear to work and then fail suddenly, and applications develop elusive, sporadic bugs. Protect yourself with build tools — many build systems have built-in circular-dependency detectors that alert you when a cycle is detected, and plug-ins usually exist for those that don't.

### Going Deeper
Dependency conflicts and incompatible changes are so pervasive that ecosystems have their own names for the problem: DLL hell, JAR hell, "any time I have to touch pip." There are few books on dependency management, but ecosystem-specific discussions are plentiful online, and the Wikipedia article on dependency hell gives historical perspective. The SemVer spec (semver.org) and Python's similar scheme (PEP 440) are both in heavy use and worth learning; many other schemes exist, and different versioning schemes commonly coexist within one project. Following the Pareto principle, don't dig deep into version semantics when starting out unless it's explicitly part of your job or you need it to solve a concrete problem — the fundamentals cover most day-to-day work. The same versioning concepts apply to both libraries and service APIs.

## Actionable Practices

- Use semantic versioning. Don't use Git hashes as version numbers.
- Never reuse a version number or republish changed code under an existing version.
- Be skeptical when adding new dependencies. Don't add a dependency unless the value exceeds the cost — walk the cost checklist (need, maintenance, fixability, maturity, compatibility track record, team understanding, build-vs-borrow effort, license, used-vs-unused code ratio).
- Pin dependency version ranges. Prefer exact pins or bounded ranges; explicitly exclude known-bad versions.
- Generate and commit dependency manifests (lockfiles) so transitive versions are frozen, builds are reproducible, and every dependency change shows up in review.
- Use dependency report tools to see the fully resolved transitive tree; learn the command in your build system before you need it to debug a conflict.
- Don't use transitive dependencies directly. Declare a direct dependency on every library your code actually calls.
- Declare dependencies in build files, not IDE configuration; build files are the source of truth.
- Scope your dependencies as narrowly as possible (test scope for test-only code, runtime scope for run-only code).
- Don't introduce circular dependencies. Enable your build system's cycle detector or install a plug-in that provides one.
- Copy or vendor small, stable code fragments when that avoids a big or unstable dependency — if the license allows.
- Shade dependencies only when creating a library whose widely used dependencies are likely to conflict, and never expose shaded objects in public APIs.

## Pitfalls & Anti-patterns

- **Trusting SemVer's compatibility promise.** Compatibility is aspirational: projects set version numbers without compatibility checks, automation can't fully verify compatibility, and incompatible changes slip into minor and patch releases. Forced upgrades during conflict resolution can break a library, especially when a companion dependency isn't upgraded in lockstep.
- **Leaving versions unpinned.** The build system decides your versions, so consecutive builds silently pull in new bugs, new behavior, and incompatible changes.
- **Using transitive dependencies directly.** Works until the intermediate library drops or changes that dependency — which it may do even in a patch release — and then your code breaks with no change on your side.
- **Reflexively adding dependencies in the name of DRY.** A trivial library can sit at the base of a huge transitive graph; its removal or breakage cascades through thousands of projects. Weigh value against cost first.
- **Circular dependencies.** Chicken-and-egg upgrade problems, sudden build failures, deployment-ordering issues, and elusive sporadic bugs. They commonly arise accidentally through shared utility libraries.
- **Running unrelated code on one shared, unisolated classpath.** Different versions of the same classes collide, producing confusing failures such as "missing" methods that visibly exist in the source.
- **Forked or renamed library ancestors.** An older library and its renamed successor can both end up in a build; the build system can't tell they're the same library at different versions, so both get included and conflict.
- **Declaring everything compile-scoped.** It works but invites conflicts and bloats runtime binaries.
- **Managing dependencies through the IDE.** IDE-only configuration diverges from build files, so code works in the IDE but fails in the real build, or vice versa.
- **Overusing shading.** Shaded package names confuse developers, and shaded types exposed in public APIs are nearly unusable for consumers.
- **"Temporary" copy-paste dependency workarounds.** Sometimes necessary skulduggery, but they tend to outlive their justification by years; track them and revert when the upstream fix ships.

## Key Terms

- **Dependency** — code that your code relies on.
- **Scope** — the time at which a dependency is needed: compilation, testing, or runtime. Compile scope implies runtime use; test scope is test-only.
- **Direct dependency** — a library your project declares explicitly in its build or package file.
- **Transitive dependency** — a library pulled in by your dependencies (a dependency of a dependency).
- **Dependency tree / dependency graph** — the fully resolved set of all direct and transitive dependencies, shown by a dependency report.
- **Semantic versioning (SemVer)** — the MAJOR.MINOR.PATCH scheme: patch = backward-compatible fixes, minor = backward-compatible features, major = breaking changes; major version 0 makes no guarantees.
- **Micro version** — another name for the patch version.
- **Precedence** — version ordering used to resolve conflicts when a build depends on multiple versions of the same artifact.
- **Prerelease version** — a hyphen-suffixed version (2.13.7-alpha.2) that may break compatibility; all prereleases are superseded by the final release.
- **Release candidate (RC)** — a prerelease build (3.0.0-rc.1) that early adopters test for bugs; the final RC is promoted by re-releasing it without the suffix.
- **Build metadata** — a build number appended to a version (2.13.7-alpha.2+1942) that links an artifact to its build logs.
- **Wildcard version range** — a spec like 2.13.* that lets the resolver pull newer compatible releases automatically.
- **Version conflict** — different parts of the dependency tree requiring different versions of the same library, forcing the build system to choose one.
- **Diamond dependency** — your project depends on two libraries that both depend, at different versions, on a shared third library.
- **Circular (cyclic) dependency** — a library that transitively depends on itself (A→B→C→A).
- **Dependency hell** — the pervasive misery of version conflicts and incompatible changes; known per-ecosystem as DLL hell, JAR hell, and so on.
- **Version pinning** — explicitly setting every dependency's version number instead of letting the build system choose.
- **Dependency manifest (lockfile)** — a generated list of all resolved dependencies and exact versions (frozen requirements, Gemfile.lock, Cargo.lock), committed so builds are identical and changes are tracked.
- **Vendoring** — embedding complete copies of dependency libraries in vendor folders in your codebase, managed by vendor tools that preserve history and updates.
- **Shading** — automatically relocating a dependency into a different namespace inside your artifact so it can't conflict with consumers' versions.
- **Classpath** — the set of locations Java searches at runtime to locate classes; multiple JARs containing different versions of the same class cause conflicts.
