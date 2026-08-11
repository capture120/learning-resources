# Chapter 8: Delivering Software

You should understand how your code winds up in front of users, even if release engineers or automation handle the mechanics — the steps between `git commit` and live traffic should never be a mystery. Software is delivered only when it is running stably in production and customers are using it: not when code is committed, and not even when it is rolled out. Delivery breaks into four phases — build, release, deploy, rollout — and each phase has best practices that make shipping fast, safe, and predictable.

## Core Concepts

### The Four Delivery Phases

Delivery terminology is not standardized across the industry; words like "release" and "deploy" mean completely different things on different teams, so learn your team's vocabulary. The working model has four phases:

1. **Build** — software is compiled, tested, and packaged. Packages should be immutable and versioned.
2. **Release** — packages are published to a centralized repository; release notes and changelogs are updated.
3. **Deploy** — published artifacts are installed into preproduction and production environments. Deployed software is installed but not yet accessible to users.
4. **Rollout** — users are shifted onto the new software. Only when rollout completes is the software delivered.

Delivery sits inside a larger product development cycle: after rollout, feedback is gathered, bugs are detected, new requirements arrive, and the next build kicks off. Understanding the pipeline helps you troubleshoot problems and control when changes land. The right branching strategy makes delivery easy and predictable; the wrong one turns delivery into a fight against the process itself.

### Branching Strategies

Release packages are built from version control. **Trunk** (also called main or mainline) holds the main version of the codebase with its history; **branches** are cut from trunk so developers can work in parallel and merge back when ready. Branching strategies define how long branches live, how they relate to released versions, and how changes propagate to multiple branches. They determine when changes go out, what testing is expected, what your bug-fix options are, and how many versions you must port fixes to. Understand and follow your team's strategy; many companies build internal tools that branch, merge, and tag automatically.

**Trunk-based development:** everyone works off trunk. Branches exist only for a single small feature, bug fix, or update; they merge back within hours or days and are never shared between developers. Frequent merging is **continuous integration (CI)**. CI reduces risk because changes propagate to all developers quickly, keeping codebases in sync, preventing last-minute integration hurdles, and surfacing bugs and incompatibilities early. The trade-off: a bug in trunk slows everyone down, so fast automated tests gate every merge, teams keep explicit processes for reacting to a broken trunk, and the general expectation is that trunk is always releasable. Releases tend to be frequent. Release branches can still be cut, with important fixes cherry-picked into them.

**Feature branch–based development:** many developers work simultaneously on long-lived feature branches, one per product feature. Because branches live long, developers must **rebase** — pull in changes from trunk — so branches don't diverge too far; stability is managed by controlling when rebases happen. To prepare a release, feature branches are pulled into a release branch, which is tested and stabilized while feature branches keep evolving; packages build off the stable release branch. This style is common when trunk is too unstable to release and teams want to avoid feature freezes (banning feature commits while trunk stabilizes). It suits shrink-wrapped software where different customers run different versions; service-oriented systems usually use trunk-based development.

**Gitflow** is the most popular feature-branch approach (described by Vincent Driesen in 2010). It uses a develop branch (the base that feature branches merge and rebase with), release branches (cut from develop when preparing a release, stabilized, then merged into trunk), and a hotfix branch. Trunk only ever contains stabilized releases, so it is always considered production-ready; critical bugs in trunk are fixed immediately with hotfixes merged into both trunk and develop, rather than waiting for the normal release cadence.

**The recommendation: stick with trunk-based development unless you truly need long-lived feature branches.** Managing feature branches gets complicated. Even Driesen amended his original Gitflow post to discourage Gitflow for software that can be continuously integrated and delivered.

### Build Phase: Packages

Building involves resolving and linking dependencies, running linters, compiling, testing, and finally packaging. The build's output is the **package**: software is built once per release rather than on every machine it runs on, because prebuilt packages are more consistent than letting each machine compile with its own idiosyncratic environment and tools. Builds often produce multiple packages — one per operating system, CPU architecture, or language runtime.

Packages vary in content and form: binary or source code, dependencies, configuration, release notes, documentation, media, licenses, checksums, even virtual machine images. Libraries ship in language-specific formats (JARs, wheels, crates — mostly zipped directories arranged to match a spec); applications ship as zips, tarballs, or installation packages (.dmg, setup.exe); container and machine packages include not just the software but the environment it runs in. Packaging determines what gets released, and bad packaging makes software hard to deploy and debug. Two rules prevent most headaches:

**Version packages.** Every package needs a unique identifier. Versions tie a running application back to specific source code, feature sets, and documentation; without one, you don't know how a package will behave. If unsure what scheme to use, semantic versioning is a safe bet — most packages follow some form of it.

**Package different resources separately.** Software is not just code: configuration, schemas, images, and language packs (translations) are all part of it, and each has its own release cadence, build time, and testing/verification needs. Packaging resources separately lets each type have its own release lifecycle and roll forward or backward independently, without rebuilding the entire software package. If you ship a complete application to customers, the final artifact becomes a meta-package — a package of packages. If you ship a web service or self-upgrading app, ship the pieces separately so configuration and translations can upgrade independently of code.

Packaging options form nested layers — raw source files, library packages, bundles that include compiled dependencies, bundles that include the runtime, then images, containers, virtual machines, and even preloaded hardware. The outer layers are language-agnostic. Understand your packaging system's assumptions and conventions; it prevents deployment issues.

### Release Phase

Release publication makes software available to users and enables deployment. The process varies with software type, size, and user sophistication: an internal web service release might be one step — publish the package to a shared repository — while user-facing releases require artifact publication, documentation updates, release notes, and user communication. **Release management** is the art of publishing stable, well-documented software at a predictable cadence; complex software with multiple committing teams often has a release manager role coordinating tests, feature validation, security procedures, and documentation. Take ownership of your software's publication: release immutable packages frequently, be clear about schedules, and publish changelogs and release notes.

**Don't throw releases over the fence.** Take responsibility for your software's release even if your organization has release engineering or operations teams. Those teams help set up tools, advise on best practices, and automate drudgery and bookkeeping, but they do not know your code as well as you do; it is ultimately your responsibility to ensure the software is appropriately deployed and well-functioning. Make sure your code works in test environments, keep track of release schedules, understand the available options, and choose the right approach for your application. If only half the application ships, or a critical bug reaches production, you need to be involved in understanding how it happened and preventing a recurrence.

**Publish packages to a release repository.** Use a purpose-built package repository (Docker Hub, GitHub Release Pages, PyPI, and Maven Central are public examples; many companies stage releases in private repositories) rather than just tagging code in version control. Release repositories serve release artifacts to end users; act as archives so previous artifacts stay available for debugging, rollback, and phased deployments; index package contents and metadata for browsing and search (dependencies, version information, publication dates — invaluable when troubleshooting); and are built for deployment demands, handling thousands of simultaneous downloads. Version control systems *can* work as release repositories (Go expresses dependencies as Git URIs rather than using a central repository), but they aren't built for it: fewer search and deployment features, and they get overwhelmed by large deployments. Production deployments suffer if the same VCS machines handle developer checkouts, tooling requests, and deployment fan-out. Development and deployment demands differ fundamentally — developers make frequent small commits and few checkouts, while deployments check out code from many machines at once — so sharing one system causes operational issues. If you must release from a VCS, make sure it can handle the load.

**Keep releases immutable.** Once published, never change or overwrite a release package. Immutability guarantees every application instance running a given version is byte-for-byte identical, which lets developers reason about exactly what code is in an application and how it should behave. A versioned package that changes is no better than an unversioned one.

**Release frequently.** Slow release cycles give a false sense of security: long gaps between releases feel like ample time to test changes, but in practice rapid cycles produce more stable software that is easier to repair. Fewer changes go out per cycle, so each release carries less risk; when a bug reaches production there are fewer changes to inspect, and the code is fresh in developers' minds, making the bug easier and faster to fix. With automated package publication and deployment, releasing on every commit is possible. For larger software that is harder to deploy, balance release frequency against the cost of release, deployment, maintenance, and users' rate of adoption.

**Be transparent about release schedules.** Release schedules define how frequently software is released: time-based (quarterly, yearly), milestone-based (when specific features complete), ad hoc, or per-commit for internal systems. Whatever the style, be clear about it — publish schedules and notify users when new releases are published.

**Publish changelogs and release notes.** Changelogs list every ticket fixed or commit made in a release; they are read primarily by support and development teams. Release notes summarize new features and bug fixes for users. Automate changelog creation by tracking changes in commit messages or issue-tracker labels.

### Deployment Phase

Deployment is the act of getting software packages where they need to be to run. Mechanisms vary wildly — mobile apps deploy differently from nuclear reactors — but the same underlying principles apply.

**Automate deployments.** Deploy with scripts, not manual steps. Automated deployments are more predictable: script behavior is reproducible and version-controlled, so operators can reason about deployment behavior when things go wrong. Scripts make fewer mistakes than humans and remove the temptation to hand-tweak systems, log in to machines, or manually copy packages. Mutating state on an existing machine is hard to get right; two different deployments of the same software can lead to inconsistent behavior that's tough to debug. Prefer off-the-shelf tools (Puppet, Salt, Ansible, Terraform) over custom scripts — custom deployment scripts are easy to start with but grow unwieldy fast, while off-the-shelf solutions integrate with existing tooling and are purpose-built for deployment automation. Highly evolved automation becomes **continuous delivery**: humans are completely removed from deployment, with packaging, testing, release, deployment, and even rollout all automated, running as frequently as desired — daily, hourly, or continuously. Continuous delivery lets teams deliver features quickly and get feedback, but it requires a commitment to automated testing, automated tooling, and a customer base able to absorb rapid change. If full automation is impossible (deployments depending on physical actions or third parties), that's okay — shrink the boundary of the blocking tasks by automating everything around them.

**Make deployments atomic.** Installation scripts involve multiple steps; do not assume each step succeeds on every execution. Machines run out of disk, get restarted at the wrong time, and have unexpected file permissions. A partially deployed application can cause *future* deployments to fail when scripts assume installation locations are empty. Make deployment all-or-nothing: a partially deployed install should never partially replace the previous successful install, and it should be possible to install the same package to the same machine multiple times, even if previous attempts terminated abruptly. The easiest technique: install each version into a different location than the old one — don't overwrite anything — then flip a single shortcut or symbolic link atomically. This also makes rollbacks much easier (point the link back at the old version), and in some cases different versions of the same software can run simultaneously on one machine.

**Deploy applications independently.** Deployment ordering — when one application's deployment requires another application to be upgraded first — is a common problem in systems with many communicating applications or services. These requests take the form of developers asking operations to deploy one application before another, or to bring several systems offline to perform an upgrade. Avoid deployment ordering requests. Ordering slows deployment because applications must wait for each other, and it leads to conflicts where two applications each depend on the other being upgraded first. Build applications that deploy independently: software that doesn't depend on deployment ordering must be backward and forward compatible — communication protocols must interoperate with both newer and older versions. When a dependency is unavoidable, use rollout techniques to deploy safely out of order: deploy everywhere with your changes turned off, then turn them on in the needed order later. That is faster and simpler than enforcing deployment ordering.

### Rollout Phase

Once new code is deployed, you can turn it on (roll it out). Switching everything to the new code at once is risky: no amount of testing eliminates the potential for bugs, and rolling out to all users at once can break things for everyone simultaneously. Instead, roll changes out gradually and monitor health metrics. The main rollout strategies: **feature flags** (control what percentage of users receive one code path versus another), **circuit breakers** (automatically switch code paths when there's trouble), and parallel-version techniques — **dark launches**, **canary deployments**, and **blue-green deployments** — which run multiple deployed versions of your software simultaneously. These patterns mitigate the risk of dangerous changes when used appropriately, but don't go crazy with sophisticated rollout strategies: they add operational complexity, since operators and developers must support multiple code versions simultaneously and keep track of which features are toggled on or off. Keep fancy rollout strategies in your toolbox for bigger changes.

**Monitor rollouts.** Watch health metrics — error rates, response times, resource consumption — as new code is activated. Monitoring can be manual or automatic: advanced release pipelines automatically roll a change out to more users or roll it back based on observed statistics, but even in a fully automated process humans should keep an eye on the statistics and rollout progress. More commonly, the ramp-up-or-roll-back decision is made by humans looking at logs and metrics. Determine ahead of time what the health metrics are: **service level indicators (SLIs)** are metrics that indicate the health of your service — watch them for signs of degradation. Think about what you expect to see in metrics or logs that would tell you your change is functioning correctly, then verify that what you expected is actually happening. Your job is not done when code is committed, and it's still not done when the code is rolled out — hold the champagne until metrics and logs show your changes running successfully.

**Ramp up with feature flags.** Feature flags (also called feature toggles or code splits) let developers control when new code is released to users: code is wrapped in an `if` statement that checks a flag — set by static configuration or a dynamic service — to determine which branch of code runs. Flags can be on/off Booleans (toggle the feature for all users), allow lists (turn on features for specific users), percentage-based ramps (slowly turn on the feature for larger swaths of users), or even small functions that dynamically determine the flag from input parameters at request time. A common ramp: start with company-owned test accounts, then a single customer, then an incremental percent-based release. Feature-flagged code that mutates state needs special attention: databases are often not controlled by feature flags, so new and old code interact with the same tables, and your code must be forward and backward compatible. State doesn't go away when a feature is toggled off — if a feature is disabled then re-enabled, state changes made while it was disabled still exist. Some changes, like database alterations, don't lend themselves to gradual rollouts at all and must be coordinated with extra care. Isolate feature-flag data if possible, test your code in all flagged states, and write scripts to clean up rolled-back feature data. Clean up old flags that are fully ramped or no longer in use: flag-littered code is difficult to reason about and can even cause bugs — turning off a feature that's been on for a long time can create havoc. Cleaning takes discipline: create tickets to remove flags in the future, and do cleanup incrementally and opportunistically, like refactoring. Feature flags are sometimes used for **A/B testing** (measuring user behavior with a new feature); that's fine only if users are grouped in a statistically meaningful way — don't A/B test with flags unless the flagging system creates test buckets for you, and have a data scientist run the experiment.

**Protect code with circuit breakers.** Most feature flags are controlled by humans; circuit breakers are a special kind of feature flag controlled by operational events, like a spike in latency or exceptions. They have unique characteristics: binary (on/off), permanent, and automated. Circuit breakers protect against performance degradation — if a latency threshold is exceeded, certain features can be automatically disabled or rate limited, and circuits can break when logs show anomalous behavior (exceptions or a jump in log verbosity). They also protect against permanent damage: applications that take irreversible actions, such as sending an email or transferring money out of a bank account, use circuit breakers when it's unclear whether to proceed, and databases protect themselves by flipping to read-only mode — many databases and filesystems do this automatically when they detect disk corruption.

**Ramp service versions in parallel.** New versions of web services can be deployed alongside old versions, co-located on the same machine or on entirely new hardware. Parallel deployments let you ramp up slowly to mitigate risk and roll back fast if things go wrong: a percentage of incoming service calls is shifted from old to new using a switch similar to a feature flag, but located at the application entry point — usually a load balancer or proxy. The two most common patterns:

- **Canary deployments** suit services that process a lot of traffic and run many instances. The new version deploys to a limited set of machines, and a small user subset is routed to the canary (for example, 1 percent of inbound traffic). Like a canary in a coal mine (used to detect dangerous gases), the canary deployment is an early warning system for new application versions: a malfunctioning canary affects only a small portion of users, who can be quickly routed back to the old version when errors are encountered.
- **Blue-green deployments** run two different versions of the application, one active and one passive, kept as identical as possible. The new version deploys to the passive environment; when it's ready, traffic flips to the new version, which becomes active while the previous version becomes passive. If the new version has problems, flip the traffic back. Unlike canaries, traffic flips atomically. Use blue-green when traffic cannot easily be subset or when running different versions in parallel isn't feasible; each environment must be able to handle 100 percent of user traffic. In a cloud environment the passive environment is usually destroyed once the release is considered stable. In disaster scenarios where all users must be migrated off a misbehaving system, the ability to get a parallel environment up and running quickly is invaluable.

Like feature flags, parallel deployments that interact with database and cache state need special care: both versions of the application must play nicely with each other, and backward and forward compatibility for all schemas must be enforced.

**Launch in dark mode.** Dark launches (sometimes called traffic shadowing) expose new code to real-life traffic without making it visible to end users at all — even if the dark code is bad, no user is impacted. Dark-launched software is enabled and invoked, but its results are thrown away. This helps developers and operators learn about their software in production with minimal user impact. Mechanically, an application proxy sits between live traffic and the application: it duplicates requests to the dark system, responses to the identical requests from both systems are compared and differences recorded, and only the production system's responses go to users. A system is in **dark reads** mode when only read traffic is sent to it and no data is modified (it might share the production datastore); it is in **dark writes** mode when writes are also sent and it uses a completely independent datastore. Since operations happen twice per request — once in production, once in the dark — take care to avoid duplication-related errors: exclude dark traffic from user analytics and avoid side effects like double billing. Mark shadowed requests for exclusion by modifying headers. Some service meshes (Istio) and API gateways (Gloo) have built-in support for these operations. Take advantage of dark launches whenever you release particularly complex changes; the pattern is especially useful for validating system migrations.

## Actionable Practices

The authors' own Do's and Don'ts, plus the chapter's other imperatives:

- DO use trunk-based development and continuous integration if possible.
- DO use VCS tools to manage branches.
- DO work with release and operations teams to create the right processes for your application.
- DO publish release changelogs and release notes.
- DO notify users when a release is published.
- DO use off-the-shelf tooling to automate deployment.
- DO roll changes out gradually with feature flags.
- DO use circuit breakers to prevent applications from causing major damage.
- DO use traffic shadowing and dark launches for major changes.
- DON'T publish unversioned packages.
- DON'T package configuration, schema, images, and language packs together.
- DON'T blindly rely on release managers and operations teams.
- DON'T use VCSs to distribute software.
- DON'T change release packages once they're published.
- DON'T roll out without monitoring the results.
- DON'T depend on deployment ordering.

Further imperatives from the chapter body:

- Learn your team's delivery vocabulary and pipeline; the path from commit to live traffic should not be a mystery.
- Understand and follow your team's branching strategy; merge trunk-based branches back within hours or days.
- Use semantic versioning when no versioning scheme is mandated.
- Release as frequently as possible; balance frequency against deployment cost only for hard-to-deploy software.
- Be transparent about release schedules, whatever the cadence.
- Make every deployment atomic: install to a fresh location, flip a symlink, never partially overwrite a working install, and make re-installation always safe.
- Build applications that deploy independently in any order via backward and forward compatibility; if ordering is unavoidable, deploy with changes off and toggle them on in order.
- Determine health metrics (SLIs) before rolling out; state what you expect metrics and logs to show, then verify it.
- Test feature-flagged code in all flag states; isolate flag data; script cleanup of rolled-back feature data.
- Create tickets to remove old feature flags; clean them up incrementally and opportunistically.
- Only A/B test via feature flags if the system creates statistically valid test buckets, with a data scientist running the experiment.
- Keep sophisticated rollout strategies for bigger changes; they add operational complexity.

## Pitfalls & Anti-patterns

- **Throwing releases over the fence.** Assuming release engineering or operations owns your software's fate. They don't know your code; if half the app ships or a critical bug escapes, you must be involved in understanding and preventing it.
- **Long-lived feature branches without need.** Managing feature branches gets complicated; even Gitflow's creator discourages it where CI/CD is possible.
- **Unversioned packages.** Without a version you can't tie a running app to source, features, or docs, and you don't know how the package will behave.
- **Mutating published releases.** A versioned package that changes is no better than an unversioned one; it breaks the guarantee that all instances of a version are identical.
- **One giant package for everything.** Bundling code, config, schemas, images, and translations couples unrelated release cadences and forces full rebuilds for small changes.
- **Distributing software from the VCS.** Version control lacks release search and deployment features and gets overwhelmed; deployment fan-out and developer workflows degrade each other on shared infrastructure.
- **Slow release cycles.** Long gaps feel safe but pile up changes, raising per-release risk and making production bugs harder to trace; rapid cycles produce more stable, more repairable software.
- **Manual deployments.** Hand-run steps invite mistakes, ad hoc machine tweaks, and unreproducible state; mutating an existing install is hard to get right and produces machines that behave inconsistently.
- **Non-atomic installs.** Scripts that assume clean directories or always-successful prior steps create partial deployments that break future deployments.
- **Deployment ordering.** Sequenced deployments slow everything down, create circular dependencies, and force coordinated, stressful, error-prone release events.
- **Big-bang rollouts without monitoring.** Flipping all users at once turns any residual bug into an everyone-is-broken incident; never roll out without watching the results.
- **Declaring victory too early.** The job isn't done at commit or at rollout; it's done when metrics and logs confirm the change works in production.
- **Feature flag litter.** Stale flags make code hard to reason about and cause bugs — turning off a long-enabled feature can create havoc.
- **Ignoring state under flags and parallel versions.** Old and new code sharing tables without forward/backward compatibility, or leftover state from toggled-off features, causes subtle breakage; database alterations don't suit gradual rollout.
- **Casual A/B testing with flags.** Percentage flags without statistically meaningful bucketing produce invalid experiments.
- **Overusing sophisticated rollout strategies.** Every flag, canary, and shadow system adds operational complexity; reserve them for bigger changes.
- **Duplication side effects in dark launches.** Shadowed requests polluting analytics or triggering real side effects (double billing) cause damage from supposedly invisible traffic.

## Key Terms

- **Trunk (main, mainline):** the main version of a codebase in version control, with its history of changes.
- **Branch:** a line of development "cut" from trunk so work proceeds in parallel before merging back.
- **Trunk-based development:** branching strategy where everyone works off trunk and branches are small, short-lived, and unshared.
- **Continuous integration (CI):** merging changes frequently so codebases stay in sync and integration problems surface early.
- **Feature branch–based development:** strategy using long-lived per-feature branches, periodically rebased on trunk and pulled into release branches.
- **Gitflow:** the most popular feature-branch model — develop, release, and hotfix branches, with trunk holding only production-ready stabilized releases.
- **Rebase:** pulling trunk's changes into a branch so it doesn't diverge too far.
- **Feature freeze:** a period when feature commits are banned while trunk is stabilized.
- **Package / release artifact:** the immutable, versioned output of a build — code plus possibly dependencies, config, docs, checksums, and more.
- **Semantic versioning:** the common default versioning scheme; a safe choice when none is mandated.
- **Meta-package:** a package of packages, used when shipping a complete application to a customer.
- **Release repository:** purpose-built store (Docker Hub, GitHub Release Pages, PyPI, Maven Central) serving versioned artifacts for deployment, search, archive, and rollback.
- **Immutable release:** a published package that is never altered, guaranteeing byte-for-byte identical instances of a version.
- **Release schedule:** the cadence rule for releases — time-based, milestone-based, ad hoc, or per-commit.
- **Changelog:** complete list of tickets fixed or commits made in a release, aimed at support and development teams.
- **Release notes:** user-facing summary of a release's new features and bug fixes.
- **Release manager:** role coordinating tests, feature validation, security procedures, and documentation for a release.
- **Continuous delivery:** fully automated packaging, testing, release, deployment, and rollout, with humans removed from the loop.
- **Atomic deployment:** all-or-nothing installation that never partially replaces a working install; typically a fresh directory plus a symlink flip.
- **Deployment ordering:** the anti-pattern of requiring one application's deployment before another's.
- **Backward/forward compatibility:** protocols and schemas interoperating with both older and newer versions, enabling independent deployment.
- **Rollout:** turning deployed code on and shifting users onto it, ideally gradually.
- **Feature flag (feature toggle, code split):** a conditional controlling which code path runs — Boolean, allow list, percentage ramp, or function.
- **A/B testing:** measuring user behavior with a new feature; valid only with statistically meaningful bucketing.
- **Circuit breaker:** a binary, permanent, automated feature flag tripped by operational events to prevent degradation or irreversible damage.
- **Canary deployment:** routing a small traffic fraction to a few instances of a new version as an early warning system.
- **Blue-green deployment:** two environments, active and passive, kept identical; new code goes to the passive one and traffic flips atomically.
- **Dark launch (traffic shadowing):** duplicating real traffic to new code whose responses are discarded, observing it in production with zero user impact.
- **Dark reads / dark writes:** shadowing modes — read-only traffic (possibly sharing the production datastore) versus reads and writes (fully independent datastore).
- **Service level indicator (SLI):** a metric indicating service health, watched during rollouts for signs of degradation.
