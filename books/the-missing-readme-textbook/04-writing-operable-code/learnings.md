# Chapter 4: Writing Operable Code

Code behaves strangely when exposed to the real world: users are unpredictable, networks are unreliable, and production software must keep working anyway. Operable code has three built-in capabilities: protection (defensive programming that prevents failures and recovers from them), diagnostics (logging, metrics, and traces that show what is happening), and controls (configuration and tools that let you steer a system without rewriting code). Mastering these makes your code easier to run in production and improves the code-review feedback you give and receive, since operability comments are common in reviews.

## Core Concepts

### Defensive Programming

Well-defended code is an act of compassion for anyone who runs it, including you. Defensive code fails less often and recovers more gracefully when it does fail. It has two halves: **safe code** uses compile-time validation (immutability, restricted scope via access modifiers, static type checking) to prevent runtime failures and validates input at runtime to avoid surprises; **resilient code** follows exception-handling best practices and handles failures gracefully.

#### Avoid Null Values

Unset variables default to null (or nil/None) in many languages, and null pointer exceptions are among the most common bugs — they trigger head-scratching "how could this variable not be set?" investigations. Defenses:

- Perform null checks at the beginning of methods; use `NotNull` annotations and similar language features when available. Validating up front lets all later code safely assume real values, keeping it cleaner and more legible.
- Use the **null object pattern**: return a real but empty object instead of null (e.g., a search method returns an empty list when nothing matches, so callers can iterate without special-casing empty results).
- Use **option types** (`Optional`, `Maybe`) where the language provides them; they force developers to consciously handle empty responses.

#### Make Variables Immutable

Immutable variables cannot change after they are set, which prevents unexpected modification bugs. Declare immutability explicitly whenever your language allows (`final` in Java, `val` over `var` in Scala, `let` over `let mut` in Rust). Far more variables can be immutable than you'd expect at first blush. Bonuses: immutability simplifies parallel programming, and compilers/runtimes optimize better when they know a value won't change.

#### Use Type Hinting and Static Type Checking

Constrain the values a variable can take. Use the most specific type possible — an `Enum` rather than a `String` when only a few values are valid — so unexpected values fail immediately (or fail to compile) instead of becoming bugs. Dynamically typed languages now have robust type hints and static checkers (Python 3.5+, Ruby via Sorbet, JavaScript via TypeScript). Type hints can be adopted gradually in an existing codebase, and paired with a static type checker they catch bugs before the code ever runs.

#### Validate Inputs

Never trust input. Developers, faulty hardware, and human error all mangle data. Reject bad input as early as possible:

- Validate method inputs with preconditions and postconditions; use library helpers (`checkNotNull`, annotations like `@Size(min=0, max=100)`) when types alone can't capture validity. Be as constrained as possible.
- Check that strings match expected formats; remember leading/trailing whitespace. Check numeric ranges (a parameter that must be positive actually is; an IP address is a valid IP).
- Hardware lies too: networks and disks corrupt data. Use checksums when you need strong durability guarantees.
- Treat external input as a security threat. Malicious users inject code or SQL and overrun buffers. Use mature libraries/frameworks to prevent cross-site scripting; always escape inputs to prevent SQL injection; set explicit size parameters when manipulating memory (`strncpy`, never bare `strcpy`) to prevent buffer overflows; use widely adopted security and cryptography libraries or protocols instead of writing your own. Study the OWASP (Open Web Application Security Project) Top 10 report to bootstrap security knowledge quickly.

#### Use Exceptions, Not Special Return Values

Don't signal errors with magic return values (null, 0, -1). They're invisible in method signatures, so developers don't know error conditions exist or need handling, and it's hard to remember which value maps to which failure. Exceptions carry far more information: a name, a message, a stack trace, line numbers. In many languages, error conditions appear right in the signature (Go's `(file *File, err error)` return, Java's `throws IOException`), clearly signaling that callers must handle failure.

#### Be Precise with Exceptions

Precise exceptions make code easier to use:

- Prefer built-in exception types (`FileNotFoundException`, `AssertionError`, `NullPointerException`, etc.); developers already know what they mean. Don't create custom exceptions when a built-in type describes the problem.
- When you must create custom exceptions, don't make them generic. Without a precise signal of what went wrong, developers can't react appropriately and are forced into the drastic action of failing the whole application.
- Use exceptions for failures only, never for application logic. Code should be unsurprising, not clever — using exceptions to break out of a method or "return" a successful result is confusing and hard to debug.

#### Throw Exceptions Early, Catch Exceptions Late

**Throw early**: raise the exception as close to the error as possible so developers can quickly find the relevant code. If other code runs between the error and the throw, a second error can fire first and hide the real root cause — you fix a bug only to discover the actual problem was upstream, which is maddening to track down.

**Catch late**: propagate exceptions up the call stack until they reach the level that can actually decide what to do. The right reaction to a failure (block and retry, retry asynchronously, write elsewhere, alert a human, even crash) depends on application context that low-level code doesn't have; intermediate layers must propagate the exception upward and not attempt premature remediation. The worst form of premature remediation is **swallowing** an exception you can't address — catching it and doing nothing, so it's never logged, rethrown, or acted on. The failure is hidden, possibly disastrously. Either handle an exception completely or propagate it up the stack.

#### Retry Intelligently

The right reaction to an error is often simply trying again — plan on retries when calling remote systems — but when and how often to retry takes know-how. Naive immediate retries make things worse: a disk that's full now is almost certainly still full ten milliseconds from now, and banging away slows the system's recovery.

- Use **backoff**: increase the sleep between retries nonlinearly (commonly exponential, like retry-number squared), and cap it at a maximum so it doesn't grow unbounded.
- Add **jitter**: a random, bounded addition to each backoff. Without it, clients that all saw the same blip back off identically and retry in synchronized waves — a **thundering herd** that can knock a recovering service back down. Randomness spreads the requests out.
- Don't blindly retry every failed call, especially ones that write data or trigger business processes. When the application hits an error it wasn't designed to handle, it's better to **fail fast** — crash rather than continue, so no further damage is done and a human can figure out the right course of action. Fail loudly too: make relevant information visible so debugging is easy.

#### Write Idempotent Systems

After a failure it's often unknowable what state the system landed in. If the network fails during a remote write, did the write succeed? Retrying risks double-writing (a billing system might double-charge a customer); giving up risks losing the data (never charging at all). Sometimes you can read the remote system to check, but not always. Local state has the same problem: nontransactional in-memory mutations can leave the system inconsistent. The best answer is **idempotency** — operations that yield the same outcome no matter how many times they're applied (adding a value to a set is idempotent: the value exists once regardless). Make remote APIs idempotent by letting clients attach a unique ID to each request; a retry reuses the same ID, and the server de-duplicates requests it has already processed. Idempotent operations greatly simplify system interactions and eliminate a large class of errors.

#### Clean Up Resources

Release memory, data structures, network sockets, and file handles when failures occur. Operating systems have fixed space for file handles and network sockets; once exceeded, all new handles and sockets fail to open. Leaked sockets keep useless connections alive and fill connection pools. A bare `open(...)` ... `close()` sequence is dangerous because any failure in between skips the close. If your language doesn't auto-close, wrap cleanup in `try/finally`; prefer language features that close automatically — Python's `with` statement, Rust destructors invoked when objects leave scope.

### Logging

Printing messages is simple and fine for small programs, but complex applications need logging frameworks: they control what gets logged and when, let operators modulate volume through log levels, control formats, inject contextual information (thread names, hostnames, IDs) useful in debugging, and integrate with log management systems that aggregate, filter, and search messages. Use a framework, set levels so operators can control volume, and keep logs atomic, fast, and secure.

#### Use Log Levels

Levels let operators filter messages by importance: setting a level emits everything at or above it and silences the rest, usually via a global setting plus per-package or per-class overrides. Levels aren't completely standard across frameworks, but the following are common — and they only work if each message uses the appropriate criticality:

- **TRACE** — extremely fine detail (line-by-line logs, data structure dumps), turned on only for specific packages or classes, rarely used outside development. If you use TRACE frequently, consider stepping through with a debugger instead.
- **DEBUG** — useful during a production issue but not during normal operations. Don't overuse it to the point the output is unusable when debugging; save that volume for TRACE.
- **INFO** — the default level. Nice-to-have application state ("Service started", "Listening on port 5050"), not indicative of any problem. No frivolous "just in case" logging — that belongs in TRACE or DEBUG. INFO should say something useful during normal operations.
- **WARN** — potentially problematic situations, like a resource nearing capacity. Every warning should carry a concrete action you want the reader to take; if it isn't actionable, log it at INFO.
- **ERROR** — an error needing attention is occurring (e.g., an unwritable database). Include enough detail to diagnose: explicit specifics, relevant stack traces, and the resulting actions the software is taking.
- **FATAL** — "last gasp" messages when the program hits a condition so severe it must exit immediately. Log the cause, relevant program state, and the locations of recovery or diagnostic data.

Choose the level by required operator action: a failed request the application automatically retries is INFO, not ERROR, because no operator action is needed.

#### Keep Logs Atomic

If information is only useful together with other data, log it all atomically in one message. Atomic logs work better with log aggregators. Never assume logs will be seen in order — operational tools reorder and even drop messages — and don't rely on system clock timestamps for ordering, because clocks reset and drift between hosts. Avoid newlines in messages: many aggregators treat each line as a separate message, which splits multiline output and interleaves it with other threads' messages. Stack traces often print with newlines, so take extra care to log them as a single message. If atomic output is impossible, embed a unique ID in the related messages so they can be stitched together later.

#### Keep Logs Fast

Excessive logging hurts performance — logs must be written somewhere, and strings must be concatenated and formatted first. A concatenated string passed into a log call is built even when the level is disabled, because arguments are evaluated before the method runs; in performance-sensitive loops this is devastating. Use **parameterized logging** (or frameworks that wrap messages in closures) so the message is only constructed when the line will actually be written. Manage write cost with **appenders**, which route logs to destinations (console, file, remote aggregator): default appenders run in the caller's thread like a print; **asynchronous appenders** write without blocking execution threads; **batching appenders** buffer messages in memory before writing, improving throughput (the OS page cache buffers as well). Trade-off: asynchronous and batching appenders can lose log messages if the application crashes, since not all logs are guaranteed flushed to disk. Also beware that changing log verbosity or configuration can eliminate race conditions by slowing the application — if you enable verbose logging to debug an issue and the bug disappears, the logging change itself might be why.

#### Don't Log Sensitive Data

Log messages shouldn't include private data: passwords, security tokens, credit card numbers, emails. This seems obvious but is easy to get wrong — simply logging a URL or an HTTP response can expose information that log aggregators are not set up to safeguard. Most frameworks support rule-based string replacement and redaction; configure them, but don't rely on them as your only defense. Be paranoid: logged sensitive data creates security risks and violates privacy regulations.

### Metrics

Instrument your application with metrics to see what it is doing. Metrics are the numerical equivalent of logs: they measure application behavior (how long a query took, how many elements are in a queue, how much data was written) to detect problems and aid debugging. Three common metric types (the names are similar but not consistent across monitoring systems):

- **Counters** measure the number of times an event happens; they only increase, resetting to zero on process restart (monotonically increasing). Combine them for rates — a cache hit counter plus a request counter yields the cache hit rate.
- **Gauges** are point-in-time measurements that can go up or down — think of a speedometer or fuel gauge. Use them for sizes of queues, stacks, and maps.
- **Histograms** break events into ranges by magnitude, incrementing a counter for whichever range each event falls into; they commonly measure request durations and data payload sizes.

System performance is often judged at threshold **percentiles** derived from histograms — a P99 latency of 2 milliseconds means 99 percent of requests complete in 2 ms or less. To cut down on the data they must track, some systems make you configure which percentiles you care about; if the default is P95 but your service level objective (SLO) is P99, change the settings accordingly.

Application metrics aggregate into centralized **observability systems** (Datadog, LogicMonitor, Prometheus). Observability — a concept from control theory — is how easily a system's state can be determined by looking at its outputs; these systems provide dashboards (showing operators what's going on) and monitoring tools (alerts triggered on metric values). Metrics also drive **autoscaling**: cloud hosts adjust running instance counts by watching load metrics, adding capacity when needed and shedding it to save money. Tracking SLOs, using observability systems, and exploiting autoscaling all require measuring everything — and exposing the important metrics is the developer's job.

#### Use Standard Metrics Libraries

Counters, gauges, and histograms are easy to calculate, but don't roll your own metrics library — nonstandard libraries are a maintenance nightmare, while standard ones integrate with everything out of the box. Your company probably has a preferred library; use it. If not, start a discussion to adopt one. Most observability systems offer client libraries in many languages, and they all look similar (a StatsD-style client offers `incr` for counters, `gauge` for gauges, `timer` for timing histograms), so knowledge transfers between them. Web application frameworks compute many metrics for you — most count every HTTP status code per method and time all requests — so configure the framework to output to your observability system: tons of metrics for free, and cleaner code because measurement happens underneath.

#### Measure Everything

Measurements are cheap; use them extensively. Measure resource pools, caches, data structures, CPU-intensive operations, I/O-intensive operations, data size, exceptions and errors, and remote requests and responses. Specifically:

- Gauge resource pool sizes, with special attention to thread pools and connection pools — large pools indicate a system that is stuck or unable to keep up.
- Count cache hits and misses; shifts in the hit-to-miss ratio impact application performance.
- Gauge the size of key data structures; abnormal size indicates something strange is going on.
- Time CPU-intensive operations, especially data serialization, which is surprisingly expensive — a simple JSON encode is often the costliest operation in code.
- Disk and network I/O are slow and unpredictable: time them, and measure the size of the data involved. Track RPC payload sizes, and use histograms for I/O data sizes so you can see 99th-percentile sizes. Large data impacts memory footprint, I/O speed, and disk usage.
- Count every exception, error response code, and bad input; measured errors make it easy to trigger alerts when things go wrong.
- Count requests to your application — abnormally high or low counts signal something amiss — and time all responses, because users want fast systems and you need to know when yours is slow.

Take time to understand how your metrics library works: it's not always obvious how a metric is calculated, and many libraries sample measurements. Sampling keeps performance fast and reduces disk/memory usage, but makes measurements less accurate.

### Traces

Beyond familiar stack traces are **distributed call traces**. A single call to a frontend API might trigger hundreds of downstream RPC calls to different services; distributed traces stitch all of them into one graph. They're useful for debugging errors, measuring performance, understanding dependencies, and analyzing system cost (which APIs are most expensive to serve, which customers cost the most). Mechanics: the RPC client uses a tracing library to attach a **call-trace ID** to its request; downstream RPC calls attach the same ID; services report the invocations they receive along with the ID and other data (metadata tags, processing time); a dedicated system records the reports and stitches traces back together by ID into full distributed call graphs. Call-trace IDs are usually propagated automatically through RPC client wrappers and service meshes — but verify you're propagating any required state when you call other services.

### Configuration

Applications and services should expose settings so developers and site reliability engineers (SREs) can configure runtime behavior. The guiding principles: don't get too creative, use a standard format, provide sensible defaults, validate configuration inputs, and avoid dynamic configuration when possible.

Configuration can be expressed as plain human-readable files (INI, JSON, YAML), environment variables, command line flags, a custom domain-specific language (DSL), or code in the language the application is written in. The first three are most common: files suit many values or a desire to version control the configuration; environment variables are easy to set in scripts and easy to examine and log; command line flags are easy to set and visible in process lists like `ps`. DSLs help when configuration needs programmable logic (loops, conditionals) and are common when the application is written in a DSL-friendly language (like Scala); a DSL can provide shortcuts for complex operations and limit configuration to safe values and types — important for security and startup performance — but DSLs are hard to parse with standard tools, hurting interoperability. Configuring in the application's own language usually happens with scripting languages like Python; generating configuration with code is powerful but dangerous, because customizable logic obscures the configuration the application actually sees.

#### Don't Get Creative with Configuration

Configuration systems should be boring — an operator paged at 3 AM shouldn't need to remember Tcl syntax to change a timeout value. Innovating is tempting: configuration is familiar to everyone, and simple systems seem to miss useful features (variable substitution, if statements). Many creative, well-meaning people have spent incredible amounts of time building fancy configuration systems — and the cleverer the scheme, the more bizarre the bugs. Use the simplest possible approach that works; a static configuration file in a single standard format is ideal.

#### Static over Dynamic Configuration

Most applications use a static configuration file: changing it while the application runs has no effect, and a restart picks up changes. Dynamic configuration systems reconfigure without restart — typically a dedicated configuration service that the application polls or that pushes changes, or periodic re-checking of a local file — but they're usually not worth the complexity. You must think through the implications of every configuration changing midflight; it's harder to track when configuration changed, who changed it, and what the value used to be (information that can be critical when debugging operational issues); and it can add external dependencies on other distributed systems. Restarting a process to pick up new configuration sounds rudimentary but is usually operationally and architecturally superior. The common legitimate dynamic setting is log verbosity: operators raise the level to DEBUG when something strange is going on, because restarting the process might change the very behavior they're trying to observe — flipping a running process's log level lets you peek without restarting.

#### Log and Validate All Configuration

Log all nonsecret configuration immediately at startup to show what the application is seeing. Developers and operators occasionally misunderstand where a configuration file is supposed to go or how multiple files merge; logging the effective values shows whether the application sees what's expected. Always validate configuration values when they're loaded — once, as early as possible, right after loading. Check types (a port should be an integer) and logical sense (boundaries, string lengths, valid enum values): -200 is an integer but not a valid port. Take advantage of configuration systems with robust type systems for expressing acceptable values.

#### Provide Defaults

If users must set a large number of parameters, your system is hard to run. Set good defaults so the application works well for most users out of the box: default to network ports above 1024 if none is configured (lower ports are restricted), and use the system temp directory or the user's home directory when paths are unspecified.

#### Group Related Configuration

Configuration easily grows unmanageable, especially in key-value formats that don't support nesting. Use a standard format that allows nesting, like YAML, and group related properties to keep configuration organized and maintainable. Combine tightly coupled parameters into a single structure so the relationship is clear and the operator must declare the values atomically: `timeout=10s` or `timeout: { duration: 10, units: second }` rather than separate `timeout_duration=10` and `timeout_units=second` keys.

#### Treat Configuration as Code (CAC)

The configuration-as-code philosophy says configuration deserves the same rigor as code, because configuration mistakes are disastrous — a single incorrect integer or missing parameter can break an application. Keep configuration version controlled (in a VCS like Git, for change history), reviewed (just like code reviews), tested, built, and published. Validate that configuration is properly formatted and conforms to expected types and value bounds; build and publish configuration packages.

#### Keep Configuration Files Clean

Clean configuration is easier for others to understand and change. Delete unused configuration, use standard formatting and spacing, and don't blindly copy configuration from other files — an example of **cargo culting**, copying things without understanding what they do or how they work. Tidy configuration is hard to maintain when you're iterating quickly, but misconfiguration causes production outages.

#### Don't Edit Deployed Configuration

Avoid hand-editing configuration on a specific machine: one-off changes are overwritten on subsequent deployments, it's unclear who made them, and machines with similar configuration end up diverging. Resisting the temptation is difficult and sometimes a manual edit is unavoidable — if you edit configuration during a production incident, make sure the changes get committed to the source of truth (the VCS) later.

### Tools

Operable systems come with tools that help operators run the application: bulk-loading data, running a recovery, resetting database state, triggering a leadership election, shifting a partition assignment from one machine to another. Systems should ship with tools for common operations. Tool writing is collaborative: sometimes you'll be expected to write and supply operations tools, and organizations with strong SRE teams might also write tools for your systems — either way, work with your operations team to understand what they need. SREs usually prefer CLI-based tools and self-describing APIs because they're easily scriptable, and scriptable tools are easy to automate; if you build UI-based tools, abstract the logic into a shared library or service that CLI tools can use too. Treat your system's tools as code like any other: follow clean coding standards and test rigorously — operational tools that lack input validation and safeguards have caused some of the industry's biggest outages. Your company may already have a standard toolset (an internal web tools framework, existing CLI tools); integrate with it, and look for **single panes of glass** (unified management consoles) — companies that have them expect all tools to be integrated, and everyone is used to the existing interfaces, so integrating makes your tools easier to work with.

### Where to Go Deeper

Few books are dedicated to operable code; the subjects appear in chapters across software engineering books: Steve McConnell's *Code Complete* (defensive programming chapter), Robert C. Martin's *Clean Code* (error handling and boundaries chapters), Amazon's online *Amazon Builders' Library*, and from Google's SRE group, *Building Secure & Reliable Systems* (a treasure trove, particularly on security) and *Site Reliability Engineering* (the canonical site-reliability book — less focused on writing operable code but a must-read glimpse into running production software; both are free online).

## Actionable Practices

The authors' own Do's and Don'ts summary:

- DO prefer compilation errors to runtime errors.
- DO make things immutable whenever possible.
- DO validate inputs and outputs.
- DO study the OWASP Top 10.
- DO use bug-checking tools and types or type hinting.
- DO clean up resources after exceptions (especially sockets, file pointers, and memory).
- DO instrument your code with metrics.
- DO make your application configurable.
- DO validate and log all configuration.
- DON'T use exceptions for application logic.
- DON'T use return codes for exception handling.
- DON'T catch exceptions that you can't handle.
- DON'T write multiline logs.
- DON'T write secrets or sensitive data to logs.
- DON'T manually edit configuration on a machine.
- DON'T store passwords or secrets in configuration files.
- DON'T write custom configuration formats.
- DON'T use dynamic configuration if you can avoid it.

Further imperatives from the chapter:

- Check for null at the start of methods; return empty objects or option types instead of null.
- Use the most specific type possible (an enum over a string); add type hints gradually and run a static type checker.
- Reject bad input as early as possible; validate formats, ranges, and whitespace; use checksums when durability matters.
- Escape inputs against SQL injection; use mature frameworks against cross-site scripting; set explicit sizes in memory operations; never write your own cryptography.
- Use built-in exception types; make custom exceptions precise, not generic.
- Throw exceptions as close to the error as possible; propagate them to the layer that can decide; never swallow an exception.
- Retry remote calls with capped exponential backoff plus jitter; don't blindly retry writes; fail fast and loudly on errors you didn't design for.
- Design operations to be idempotent; let API clients supply unique request IDs so servers can de-duplicate retries.
- Use a logging framework with log levels; pick each level by whether and how an operator must act.
- Log related information atomically in one line; never rely on log ordering or system-clock timestamps; add correlation IDs when atomicity is impossible.
- Use parameterized log messages; use asynchronous or batching appenders for throughput, knowing crashes can drop buffered logs.
- Use your company's standard metrics library; enable framework-provided metrics and route them to your observability system.
- Measure resource pools, caches, data structure sizes, CPU-heavy operations (especially serialization), I/O timings and payload sizes, all errors and bad inputs, request counts, and response latency.
- Make sure the percentiles you track match your SLOs.
- Verify call-trace IDs and required state propagate when you call other services.
- Use a static configuration file in a single standard nesting format; provide working defaults; group coupled parameters into one structure.
- Version-control, review, test, and validate configuration like code; log effective nonsecret configuration at startup; validate it once, immediately after loading.
- If you must hand-edit production configuration during an incident, commit the change to version control afterward.
- Build CLI-first, scriptable operational tools; share logic between UI and CLI tools; test tools rigorously; integrate with existing company tooling and management consoles.

## Pitfalls & Anti-patterns

- **Returning null** breeds null pointer exceptions and forces every caller to special-case emptiness.
- **Magic return values for errors** (null, 0, -1) hide failure modes from method signatures, so callers don't know to handle them and can't remember what each value means.
- **Generic or clever exceptions**: vague custom exceptions give callers no precise signal, leaving them no option but to fail the whole application; exceptions used as control flow make code surprising and hard to debug.
- **Throwing late**: code that runs between the error and the throw can trigger a second error that masks the first, sending you on a maddening hunt that fixes a symptom while the upstream cause survives.
- **Premature remediation and swallowed exceptions**: intermediate layers "handling" failures they can't actually fix — worst of all the empty catch block — hide failures, possibly to disastrous effect.
- **Naive immediate retries** hammer a struggling dependency and slow its recovery; identical backoff without jitter creates a thundering herd that brings a recovering service back down.
- **Blindly retrying writes** can double-execute business actions (double-charging a customer); never retrying can lose them — the dilemma idempotency exists to remove.
- **Leaking resources** (sockets, file handles, memory) exhausts fixed OS limits and fills connection pools until all new opens fail.
- **Wrong log levels**: frivolous "just in case" INFO noise, non-actionable WARNs, and overused DEBUG make logs useless exactly when you need them.
- **Multiline and nonatomic logs** get split, reordered, dropped, and interleaved with other threads' messages by log aggregators.
- **Unparameterized log strings** pay concatenation cost even when the level is disabled — devastating in performance-sensitive loops.
- **Logging that changes timing** can mask race conditions: enable verbose logging and the bug "disappears" because the app slowed down.
- **Logging secrets**, even accidentally via URLs or HTTP responses, creates security risks and violates privacy regulations.
- **Rolling your own metrics library** is a maintenance nightmare with none of the integrations standard libraries get for free.
- **Unexamined metric sampling**: many libraries sample measurements for speed, trading away accuracy; know how your numbers are computed.
- **Clever configuration systems**: the cleverer the scheme, the more bizarre the bugs; a 3 AM operator shouldn't need exotic syntax to change a timeout.
- **Dynamic configuration** introduces midflight-change hazards, audit gaps (when/who/what changed), and external distributed-system dependencies that a simple restart avoids.
- **Cargo-culted and messy configuration**: copying settings without understanding them and leaving unused config around invites the misconfigurations that cause production outages.
- **Hand-editing deployed configuration** gets overwritten by the next deployment, hides who changed what, and makes similar machines diverge.
- **Untested, unguarded operational tools**: a tool that accepts one fat-fingered parameter without validation can cascade into a massive outage.

## Key Terms

- **Operable code** — code with built-in protection, diagnostics, and controls so it can be run in production.
- **Safe code** — code that exploits compile-time validation (immutability, scope restriction, static types) plus runtime input validation to prevent failures.
- **Resilient code** — code that recovers gracefully from failures via exception-handling best practices.
- **Null object pattern** — returning a real but empty object (e.g., an empty list) instead of null.
- **Option types** — types like `Optional`/`Maybe` that force explicit handling of absent values.
- **Type hinting** — declaring variable types in a normally dynamically typed language; a **static type checker** uses the hints to find bugs before execution.
- **Preconditions/postconditions** — validations on a method's inputs and outputs.
- **Checked exceptions** — error conditions declared in method signatures, visible to callers.
- **Throw early, catch late** — raise exceptions at the error site; handle them only at the layer that can decide the response.
- **Swallowing an exception** — catching and ignoring an exception you can't address, hiding the failure.
- **Backoff** — nonlinearly increasing (usually exponential) sleep between retries, capped at a maximum.
- **Jitter** — a random, bounded addition to backoff that desynchronizes clients.
- **Thundering herd** — many clients issuing retries simultaneously, which can bring a recovering service back down.
- **Failing fast** — letting the application crash on errors it wasn't designed to handle, so no further damage occurs and a human decides next steps.
- **Idempotent operation** — an operation that yields the same outcome no matter how many times it's applied.
- **Log levels** — TRACE, DEBUG, INFO, WARN, ERROR, FATAL: importance tiers operators filter on.
- **Atomic log** — a single log message containing all related information in one line.
- **Parameterized logging** — log templates whose arguments are formatted only if the line will actually be emitted.
- **Appender** — a component routing logs to a destination (console, file, remote aggregator); **asynchronous appenders** don't block the calling thread, **batching appenders** buffer messages before writing.
- **Counter** — a monotonically increasing count of events (resets to zero on restart).
- **Gauge** — a point-in-time measurement that can go up or down.
- **Histogram** — counts of events bucketed into magnitude ranges; the basis for percentiles.
- **P99 (threshold percentile)** — the value 99 percent of measurements fall at or under; a 2 ms P99 latency means 99 percent of requests take 2 ms or less.
- **SLO (service level objective)** — a target performance level, often expressed as a percentile.
- **Observability** — a control-theory concept: how easily a system's state can be determined by looking at its outputs.
- **Observability system** — centralized metric aggregation with dashboards and alerting (Datadog, LogicMonitor, Prometheus).
- **Autoscaling** — automatically adjusting server capacity based on load metrics.
- **Distributed call trace** — a stitched graph of all downstream RPC calls triggered by a single request.
- **Call-trace ID** — the identifier attached to a request and propagated through downstream calls so a trace can be stitched together.
- **RPC (remote procedure call)** — a request from one service to another; payload sizes and timings should be measured.
- **DSL (domain-specific language)** — a small custom language, sometimes used (cautiously) when configuration needs logic.
- **Dynamic configuration** — configuration changeable without a restart; usually to be avoided, with log verbosity the main exception.
- **Configuration as code (CAC)** — subjecting configuration to the same rigor as code: version control, review, testing, building, publishing.
- **Cargo culting** — copying configuration (or code) without understanding what it does or how it works.
- **SRE (site reliability engineer)** — operations-focused engineer; prefers scriptable CLI tools and self-describing APIs.
- **Single pane of glass** — a unified management console that all tools integrate into.
- **OWASP Top 10** — the Open Web Application Security Project's list of top security risks; a fast way to bootstrap security knowledge.
