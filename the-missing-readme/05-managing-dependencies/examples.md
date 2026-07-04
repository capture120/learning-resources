# Chapter 5 Examples: Managing Dependencies

### The left-pad disappearance
In March 2016, thousands of JavaScript projects suddenly stopped compiling when a single package called left-pad vanished from NPM, JavaScript's Node Package Manager. The library held one method that left-padded a string to a specified character width. Several foundational JavaScript libraries depended on it, and many projects depended on those libraries, so through the viral nature of transitive dependencies, thousands of open source and commercial codebases had a critical dependency on a fairly trivial library. When the package was removed, a lot of programmers had a rough day. **Lesson:** Transitive dependency chains turn even a trivial library into a single point of failure for entire ecosystems.

### Declaring dependencies in a Gradle build file
A Java project's `build.gradle` declares two compile-scoped dependencies, roughly:

```
dependencies {
    compile 'org.apache.httpcomponents:httpclient:4.3.6'
    compile 'org.slf4j:slf4j-api:1.7.2'
}
```

The project depends on version 4.3.6 of an HTTP client library and 1.7.2 of the SLF4J logging API, each needed to compile the code. The same job is done by `setup.py` or `requirements.txt` in Python and `package.json` in JavaScript. **Lesson:** Dependencies are declared in build or package files as explicitly named, versioned, scoped entries, and the versions exist to control change and resolve conflicts.

### Dessert names, alliterative animals, git hashes, and plain counters
Git commit hashes and "marketing" versions like Android's dessert series (Cupcake, Froyo) or Ubuntu's alliterative animals (Trusty Tahr, Disco Dingo) satisfy the uniqueness property of a versioning scheme, but humans and tools can't order them or learn anything about stability from them. A monotonically increasing counter (1, 2, 3) is unique and comparable but still says nothing about compatibility. **Lesson:** A good versioning scheme must be unique, comparable, and informative — most naming schemes fail at least one of the three.

### Reading a SemVer number: httpclient 4.3.6
The httpclient version 4.3.6 decomposes into major 4, minor 3, patch 6. Semantic versions compare left to right, so 2.13.7 precedes 2.14.1, and the position of a change encodes its meaning: patch bumps are backward-compatible bug fixes, minor bumps are backward-compatible features, major bumps are breaking changes. Major version 0 is "prerelease," where developers may break APIs freely — adding a required parameter or deleting a public method — with no compatibility guarantees. **Lesson:** A semantic version is unique, comparable, and informative, encoding compatibility expectations directly in the number.

### Release candidates, prerelease tags, and build numbers
A project preparing version 3.0.0 ships prerelease builds as 3.0.0-rc.1, 3.0.0-rc.2, and so on, letting early adopters find bugs before the official release; the final release candidate is promoted by re-releasing it without the suffix, and 3.0.0 supersedes all prereleases. Prerelease identifiers are dot-separated alphanumerics after a hyphen (2.13.7-alpha.2), and prereleases may make breaking changes without a major bump. Build numbers append after everything else (2.13.7-alpha.2+1942) so developers and tools can find the build logs for any compiled artifact. **Lesson:** SemVer's prerelease and build-metadata syntax lets teams stage risky releases and trace every artifact back to its build.

### A simple dependency tree: what httpclient really pulls in
Running `gradle dependencies` on the two-dependency project above prints a tree several layers deep: httpclient 4.3.6 pulls in httpcore, commons-logging, and commons-codec as transitive dependencies, alongside the directly declared slf4j-api. The project never declared those three libraries, but through httpclient it depends on them. Adding one library that depends on 100 others means your code now depends on 101 libraries. **Lesson:** Direct dependencies are only a subset of what your build actually uses; learn your build system's dependency report so you can see and debug the full tree.

### Borrowing httpclient's dependencies without declaring them
The project that depends only on httpclient should not explicitly use classes from httpcore, commons-logging, or commons-codec, even though those libraries sit on its classpath and using them seems to work. Libraries are free to change their own dependencies even in patch-level version bumps, so the code will stop working the moment httpclient drops or swaps one of them during an upgrade. If the project does use classes from those libraries, it should declare a direct dependency on each of them. **Lesson:** Explicitly declare as a dependency every library your code actually uses; a transitive dependency's availability is an accident, not a contract.

### A diamond dependency: two versions of slf4j-api
A more realistic dependency report shows a project with three direct dependencies — findbugs annotations 3.0.1, zookeeper 3.4.10, and an internal `com.mycompany.util:util` 1.4.2 — where two versions of slf4j-api appear: util needs 1.7.21 but zookeeper needs 1.6.1. The graph forms a diamond: the project at top, zookeeper and util in the middle, slf4j-api at the bottom required at different versions. A build can't use two versions of one library simultaneously, so Gradle annotates `slf4j-api:1.6.1 -> 1.7.21`, force-upgrading the whole project to 1.7.21. Zookeeper might not work with the swapped version — especially since its companion library slf4j-log4j12 was not upgraded — and although SemVer says a same-major upgrade should be safe, compatibility is aspirational: projects bump versions without compatibility checks, and breaking changes slip into minor and patch releases. **Lesson:** Diamond dependencies force the build system to arbitrate versions, and the arbitrated winner can silently break a library that SemVer claims should still work.

### The accidental NLP–utility cycle
A natural language processing library depends on a utility library for a string-parsing function. Later, another developer — unaware of that edge — adds the NLP library as a dependency of the utility library to get a word-stemming method. Now A depends on B depends on C depends on A: the library transitively depends on itself, and upgrading either side breaks the other in a chicken-and-egg loop. **Lesson:** Circular dependencies arise innocently, usually through shared utility projects, and create upgrade deadlocks — never introduce them, and use build-tool cycle detectors to catch them.

### The curious case of Google Collections (LinkedIn's Azkaban)
LinkedIn ran Azkaban, a Java workflow engine that let developers upload code packages and schedule them on Hadoop. Azkaban didn't isolate its classpath, so uploaded jobs ran with Azkaban's dependencies layered on top of their own. One day jobs began crashing with NoSuchMethodError, even though the team could plainly see the "missing" methods in the uploaded packages — and every missing method traced to Google's popular Guava library. The confusing part: Azkaban didn't use Guava at all. It used google-collections, the older library Guava evolved from, for just two classes (ImmutableMap and ImmutableList); Java found classes in google-collections ahead of Guava on the classpath and tried to call methods that didn't exist in the older library. Isolating classpaths mostly fixed it, but some jobs still failed because they bundled both google-collections and Guava themselves — the build system couldn't tell one was an older version of the other, so it included both. Untangling it took a lot of careful refactoring and diverted many engineers; the authors pointedly ask whether some collection helper methods were worth all that. **Lesson:** Unisolated classpaths and renamed library ancestors create brutal version conflicts, and a convenience dependency can cost far more than the convenience was worth.

### Vendor folders and shaded namespaces
Dependency management doesn't have to be left to build and package systems; dependent code can be copied, vendored, or shaded. Vendoring embeds complete library copies in vendor folders inside the codebase, with tools like `git-subtree` and `git-vendor` managing history and updates; some packaging systems, like Go's, support vendor folders natively. Shading automatically relocates a dependency into a different namespace to avoid conflicts — `some.package.space` becomes `shaded.some.package.space` — a friendly way to keep a library from forcing its dependencies onto applications. The renamed namespace is also why shaded objects must never appear in public APIs: callers would have to construct `shaded.some.package.space.Class` themselves, which is tricky and sometimes impossible, and shading is meant to hide the dependency's existence entirely. **Lesson:** Vendoring and shading isolate dependencies — one embeds full copies with managed history, the other relocates namespaces — but shade only when building a library whose widely used dependencies are likely to conflict.

### Pinned versions in a Go require block
A Go project's dependency list pins every library to an explicit version, sketched as:

```
require (
    github.com/bgentry/speakeasy v0.1.0
    github.com/cockroachdb/datadriven v0.0.0-20190809...
    github.com/coreos/go-semver v0.2.0
    github.com/coreos/go-systemd v0.0.0-20180511...
    ...
)
```

Every entry carries an exact version, so the build system never silently chooses a different one between builds. **Lesson:** Pinning every dependency's version keeps consecutive builds stable instead of leaving your fate to the resolver.

### Airflow's three version strategies in one block
Apache Airflow's OAuth dependency block uses three different version-management strategies side by side, roughly:

```
flask_oauth = [
    'Flask-OAuthlib>=0.9.1',
    'oauthlib!=2.0.3,!=2.0.4,!=2.0.5,<3.0.0,>=1.1.2',
    'requests-oauthlib==1.1.0',
]
```

requests-oauthlib is exactly pinned to 1.1.0; Flask-OAuthlib accepts anything at or above 0.9.1 (unbounded); and oauthlib is extremely specific — at least 1.1.2 but below 3.0.0, excluding 2.0.3 through 2.0.5 because of known bugs and incompatibilities. A bounded range is the compromise position: the resolver can still settle conflicts and pick up updates, but exposure to breaking changes is limited, whereas unbounded versions pull in the latest bugs and incompatible changes along with the fixes. **Lesson:** Real-world dependency specs mix exact pins, bounded ranges, and explicit exclusions, trading flexibility against protection from breakage.

### Why Airflow's flask_oauth block is so messy
That elaborate block exists to fix a problem Airflow inherited: its dependency Flask-OAuthlib had its own unbounded dependencies on oauthlib and requests-oauthlib, which started causing breakage. The Flask-OAuthlib developers added bounded ranges upstream but were slow to release the fix, and Airflow couldn't wait, so Airflow copy-pasted Flask-OAuthlib's corrected dependency block into its own setup as a temporary fix, with a comment saying it could be unpinned once a new Flask-OAuthlib release shipped. Eighteen months later, the "temporary" change still had not been reverted. The authors call this the sort of skulduggery one has to resort to when fixing dependency issues. **Lesson:** Unpinned versions in your dependencies' dependencies can break you, the workarounds are ugly copy-paste hacks, and temporary fixes tend to become permanent.

### Lockfile manifests across ecosystems
Even with direct dependencies pinned, transitive dependencies may still carry wildcards. Every major ecosystem solves this with a generated manifest of all resolved dependencies and exact versions: Python freezes requirements, Ruby generates Gemfile.lock, Rust creates Cargo.lock. Build systems use the manifest to produce identical results on every execution, and developers regenerate it explicitly only when they intend to change a version. Committing the manifest alongside the code makes every dependency change visible and reviewable. **Lesson:** Lockfile manifests pin the entire transitive tree, making builds reproducible and dependency changes auditable.

### Dependency hell by many names
The problem of conflicting versions and incompatible changes is so pervasive that ecosystems coined their own names for it: DLL hell on Windows, JAR hell in Java, and the quip "any time I have to touch pip" in Python. Despite its ubiquity there are few books on the topic; ecosystem-specific discussion lives online, and the Wikipedia article on dependency hell collects the history. **Lesson:** Dependency hell is universal across ecosystems — expect to meet your platform's local variant and learn its tooling.
