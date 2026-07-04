# Chapter 4 Examples: Writing Operable Code

### "No Word Allowed": the genomics lab that blamed its users
In college, Dmitriy worked part-time at a comparative genomics lab whose web service let scientists upload DNA sequences (long strings of A, C, T, G) and run the lab's tools on them. A constant source of errors: biologists pasted sequences into Microsoft Word documents instead of plain text files, the parsers broke, and the site reported "no matching sequence found" — so users filed bug reports claiming the search was broken because it couldn't find sequences that had to be in the database. The team blamed users since the directions said "plaintext file." Tired of answering support emails, Dmitriy didn't add a Word parser, file-format checking, or proper error instrumentation; he added a big Microsoft Word icon with a red line through it, and support volume dropped. Fifteen years later he uploaded a Word document of a well-studied gene to the still-running site: no results, no errors — decades of silently misleading results for anyone who made the same mistake. The authors' verdict: don't be 20-year-old Dmitriy; he might have sabotaged a cure for cancer.
**Lesson:** Validate inputs and fail with clear errors instead of blaming users — silent rejection of bad input produces misleading results indefinitely.

### A type-hinted Python method
A Python 3.5+ function can declare types in a normally dynamic language, e.g. a method annotated to take a `str` and return a `str`:
```python
def say(something: str) -> str:
    return "You said: " + something
```
Hints like this can be added gradually to an existing codebase, and a static type checker uses them to find bugs before the code ever runs.
**Lesson:** Type hints plus a static checker turn would-be runtime failures in dynamic languages into pre-execution errors.

### Precondition annotations and helpers
Languages have libraries to validate inputs when the type alone can't: methods like `checkNotNull` and annotations like `@Size(min=0, max=100)` constrain values at method boundaries. The advice is to be as constrained as possible — check string formats, strip-aware whitespace handling, numeric ranges (greater than zero when required), and validity of structured values like IP addresses.
**Lesson:** Express valid input as explicit, enforced preconditions so bad data is rejected at the door.

### The search that returns an empty list
An example of the null object pattern: a search method returns an empty list instead of `null` when nothing matches. Callers can then iterate over results without writing special code for the empty case, eliminating an entire family of null pointer exceptions.
**Lesson:** Returning real-but-empty objects instead of null keeps caller code simple and crash-free.

### ZeroDivisionError beats None
Python's division-by-zero failure produces a traceback naming the exception (`ZeroDivisionError: integer division or modulo by zero`) with file, line, and context. A function that instead signaled the failure by returning `None` would convey almost none of that. The comparison shows why exceptions — named, with stack traces, line numbers, and messages — beat special return values.
**Lesson:** Exceptions carry rich diagnostic information that sentinel return values like None or -1 cannot.

### Error-revealing signatures in Go and Java
Go's file-open function returns a pair including an error value — roughly `func Open(name string) (file *File, err error)` — and Java's equivalent declares `throws IOException` in the signature. In both, the possibility of failure is visible to every caller at the call site, so handling it can't be forgotten the way a magic return code can.
**Lesson:** Declare errors in method signatures so callers can see, and must confront, the failure modes.

### FoundNodeException: using an exception to return a result
A Python graph search raises a custom `FoundNodeException(node)` to "return" the node it found while recursively walking neighbors, instead of just returning the node:
```python
def find_node(start_node, search_name):
    for node in start_node.neighbors:
        if search_name in node.name:
            raise FoundNodeException(node)   # don't do this
        find_node(node, search_name)
```
The authors' response: don't do this — just return the node. Exceptions for control flow make code surprising, confusing, and hard to debug.
**Lesson:** Use exceptions only for failures, never as a clever way to implement application logic.

### The full disk: why exceptions are caught late
An application tries to write to a full disk. Possible reactions include blocking and retrying, retrying asynchronously, writing to a different disk, alerting a human, or crashing — and the right one depends on the application: a database's write-ahead log must be written, while a word processor's background save can simply wait. The code able to make that decision sits several layers above the low-level library that hit the full disk, so every intermediate layer must propagate the exception upward without attempting premature fixes.
**Lesson:** Only a high-level layer knows the right response to a failure, so intermediate code should propagate exceptions rather than remediate prematurely.

### The swallowed exception
The worst form of premature remediation is the catch block that ignores an exception it can't address:
```java
try {
  // ...
} catch (Exception e) {
  // ignoring since there's nothing I can do about it
}
```
Nothing is logged, rethrown, or acted on; the failure is hidden, possibly to disastrous effect. The rule: handle exceptions completely or propagate them up the stack.
**Lesson:** Silently swallowing an exception hides failures — if you can't handle it, pass it up.

### Retrying a full disk every 10 milliseconds
The naive retry strategy — catch the exception and immediately try again — runs into the reality that a disk that's out of space will still be out of space 10 milliseconds later, and 10 milliseconds after that. Banging away in a tight retry loop slows everything down and makes it harder for the system to recover. The remedy is backoff: nonlinearly increasing sleep between attempts (e.g., retry-number squared), capped at some maximum.
**Lesson:** Immediate retries against a persistent failure add load exactly when the system can least afford it; back off instead.

### The thundering herd and jitter
If a network server has a brief blip and all clients experience it simultaneously, then back off using the same algorithm, they all reissue their requests at the same moment — a thundering herd that can knock the recovering service right back down. The fix is jitter: each client adds a random, bounded amount of time to its backoff, spreading the retries out and reducing the chance of a stampede.
**Lesson:** Backoff schedules must be randomized with jitter, or synchronized retries will re-crash a recovering service.

### The billing system's retry dilemma
A network failure interrupts a remote write and you don't know whether it succeeded. In a billing system, retrying risks double-charging the customer, while giving up risks never charging them at all. Sometimes you can read the remote system to check what happened — but not always, and local nontransactional in-memory mutations can leave the same ambiguity.
**Lesson:** Without idempotency, every retry of a write is a gamble between duplicating an action and losing it.

### Idempotency: sets and unique request IDs
Adding a value to a set is idempotent — add it once or fifty times, the set contains it once. Remote APIs achieve the same property by letting clients supply a unique ID with each request: on retry, the client reuses the failed attempt's ID, and the server de-duplicates requests it has already processed. This makes retries safe and eliminates a whole class of errors.
**Lesson:** Design operations so repeating them yields the same outcome, using client-supplied request IDs to de-duplicate on the server.

### The leaked file handle
Plain open-then-close code is dangerous:
```python
f = open('foo.txt', 'w')
# ... anything that fails here leaks the handle ...
f.close()
```
Any failure before `close()` leaks the file pointer; operating systems have fixed space for handles and sockets, and leaked network sockets keep useless connections alive until connection pools fill. The fixes: `try/finally` where needed, or language features that auto-close — Python's `with open('foo.txt') as f:` block, or Rust's destructors that run when objects leave scope.
**Lesson:** Clean up resources even on failure paths, preferably with language constructs that make cleanup automatic.

### Tuning verbosity per package in log4j
A Java `log4j.properties` snippet sets the root logger to ERROR (writing to a file appender) while overriding one package to INFO:
```
log4j.rootLogger=ERROR,fout
log4j.logger.com.foo.bar=INFO
```
This shows how operators control log volume globally while turning up detail only where they need it.
**Lesson:** Log levels with global settings plus per-package overrides let operators dial log volume to the situation.

### "Failed request, retrying" is INFO, not ERROR
A Rust log line — `info!("Failed request: {}, retrying", e);` — records a failed request at INFO level even though it describes a failure. The level is right because the application is automatically retrying; no operator action is needed, and levels should reflect the action expected of the reader.
**Lesson:** Choose log levels by the action required of the operator, not by how alarming the words sound.

### The WARNING that got scrambled
A non-atomic log example: a WARNING message containing a newline gets split, so its second half ("Unable to read from pipe") appears as a bare line several entries later, intermingled with INFO messages about user logins from another thread:
```
12:18:32,320 - WARNING - Request failed with:
12:18:32,348 - INFO - User login: 986
Unable to read from pipe
12:18:32,485 - INFO - User logout: 986
```
The warning should have been written atomically as one line; aggregators treat each line as a separate message, reorder or drop lines, and clocks can't be trusted for re-sorting.
**Lesson:** Log all related information in a single line, because multiline logs get split, interleaved, and reordered by log tooling.

### Three ways to log a message in Java, two of them slow
Inside a message-polling loop, three log calls look interchangeable but behave differently:
```java
log.trace("got message: " + m);           // concatenates even when TRACE is off
log.trace("got message: {}".format(m));   // also concatenates when TRACE is off
log.trace("got message: {}", m);          // builds the string only if TRACE is on
```
Because arguments are evaluated before the method runs, the first two pay string-building costs at every iteration regardless of log level — devastating in performance-sensitive loops. Only the parameterized form defers the work.
**Lesson:** Use parameterized log messages so disabled log levels cost nothing.

### The bug that disappears when you turn on logging
Changing log verbosity or configuration can eliminate race conditions and bugs because the extra logging slows the application down. If you enable verbose logging to debug an issue and the bug vanishes, the logging change itself may be the reason.
**Lesson:** Logging changes alter timing, so a bug that disappears under verbose logging may be a race condition masked by the instrumentation.

### Listing 4-1: a Flask key-value service instrumented with StatsD
A small Python Flask web app with `set`, `get`, `unset`, and `dump` endpoints demonstrates a standard metrics client:
```python
statsd = StatsClient()

# set/unset: gauge the map's current size
statsd.gauge('map_size', len(map))

# get: count hits and misses
statsd.incr('key_hit')      # on success
statsd.incr('key_miss')     # on KeyError

# dump: time the JSON encoding
with statsd.timer('map_json_encode_time'):
    return jsonify(map)
```
Counters track cache-style hits and misses; a timer measures JSON encoding because serialization is a costly, CPU-intensive operation worth measuring; a gauge tracks map size (increment/decrement counters could work but a gauge is less error prone). The authors add that frameworks like Flask compute many metrics for free — counting every HTTP status code per method and timing all requests — so configuring framework metrics yields lots of data while keeping your code clean. Metrics libraries all look similar, so the pattern translates nearly verbatim elsewhere.
**Lesson:** Instrument code with standard metric types — counters for events, gauges for sizes, timers/histograms for durations — and let frameworks provide baseline metrics for free.

### P99 latency and the P95 default trap
System performance is often stated at threshold percentiles: a system with 2-millisecond P99 latency answers 99 percent of requests in 2 ms or less. Percentiles are derived from histograms, and some monitoring systems require you to configure which percentiles to track — if the system tracks P95 by default but your service level objective is defined at P99, you must change the settings or you can't verify your SLO.
**Lesson:** Make sure the percentiles your metrics system tracks match the percentiles your SLOs are written against.

### One frontend call, hundreds of downstream calls
A single call to a frontend API might fan out into hundreds of downstream RPC calls across different services. Distributed call traces stitch them into one graph: the client attaches a call-trace ID, downstream calls propagate it, services report each invocation with the ID plus metadata and processing time, and a dedicated system reassembles full call graphs. Teams use these graphs to debug errors, measure performance, understand dependencies, and analyze cost — which APIs are most expensive to serve, which customers cost the most. Propagation is usually automatic via RPC wrappers and service meshes, but you must verify you're passing required state along.
**Lesson:** Distributed traces turn a fan-out of cross-service calls into one debuggable, measurable graph — as long as every hop propagates the trace ID.

### The operator paged at 3 AM
The argument against creative configuration is personified: an operator paged at 3 AM shouldn't have to remember Tcl syntax just to change a timeout value. Many clever, well-meaning people have spent incredible amounts of time building fancy configuration systems with variable substitution and `if` statements — and the cleverer the scheme, the more bizarre its bugs. A static configuration file in a single standard format is ideal.
**Lesson:** Configuration must be boring enough to edit safely under pressure; cleverness there breeds bizarre bugs.

### Log verbosity: the one good dynamic setting
Dynamic configuration is usually not worth its complexity, but log verbosity is the standard exception. When something strange is happening, operators flip a running process's log level up to DEBUG to peek at its behavior — restarting the process to pick up a config change might alter or erase the very behavior they're trying to observe.
**Lesson:** Reserve dynamic configuration for cases like log verbosity, where a restart would destroy what you're investigating.

### −200 is an integer, but not a port
Configuration validation needs two layers: types and logic. A port setting should be an integer — but −200 passes the type check while being an invalid port. Validate once, as early as possible (right after loading), checking boundaries, string lengths, and valid enum values, and prefer configuration systems whose type systems can express acceptable values.
**Lesson:** Validate configuration for logical sense, not just correct types, immediately at load time.

### Defaults that work out of the box
If users must set many parameters before the system runs, the system is hard to operate. The book's concrete defaults: when no port is configured, default to ports above 1024 (lower ports are restricted), and when directory paths are unspecified, use the system temp directory or the user's home directory.
**Lesson:** Sensible defaults let an application run correctly for most users with no configuration at all.

### timeout=10s, not timeout_duration + timeout_units
Tightly coupled parameters should live in one structure so their relationship is explicit and operators must set them atomically. Instead of two flat keys, `timeout_duration=10` and `timeout_units=second`, define `timeout=10s` or a nested structure like `timeout: { duration: 10, units: second }` in a format such as YAML that supports nesting.
**Lesson:** Group related configuration into one atomic structure so coupled values can't drift apart.

### Inputs as attack vectors: strcpy, SQL injection, and the OWASP Top 10
Malicious users inject code or SQL into inputs and overrun buffers to take control of applications. The defenses named: use mature libraries and frameworks to prevent cross-site scripting, always escape inputs to block SQL injection, set explicit size parameters in memory operations (use `strncpy` rather than `strcpy`) to prevent buffer overflows, and use widely adopted security and cryptography libraries instead of writing your own. The OWASP (Open Web Application Security Project) Top 10 report is recommended as the fast way to bootstrap security knowledge.
**Lesson:** Treat every external input as hostile and lean on established security libraries and the OWASP Top 10 rather than inventing your own protections.

### Amazon brings down the internet
On February 28, 2017, Chris noticed Zoom stop working during a meeting, then saw major websites misbehaving; the operations team soon reported AWS S3 was having issues, and since much of the web depends on Amazon (and Amazon on S3), a huge slice of the internet was affected — Twitter filled with "Guess it's a snow day" and "Time to go home." Amazon's postmortem: an operations engineer investigating the billing subsystem ran a command to remove a small number of machines from the S3 billing pool but "fat-fingered" (typoed) the node-count parameter, removing far more machines than intended, which forced full restarts of other critical subsystems and cascaded into a multihour outage hitting many top-tier companies. Amazon's published response said the tool allowed too much capacity to be removed too quickly; they modified it to remove capacity slowly, added safeguards preventing removal below any subsystem's minimum required capacity, and audited their other operational tools for similar safety checks.
**Lesson:** Operational tools need the same rigor as production code — input safeguards and rate limits in a single tool can be all that stands between a typo and a global outage.

### Where to go deeper: the chapter's reading list
Few books are dedicated to operable code; the material lives in chapters of broader works. The chapter recommends: Chapter 8 of Steve McConnell's *Code Complete* for defensive programming; Chapters 7 and 8 of Robert C. Martin's *Clean Code* for error handling and boundaries; the *Amazon Builders' Library* online; Google's *Building Secure & Reliable Systems* for security-minded advice; and Google's *Site Reliability Engineering* — the canonical book on site reliability, less about writing operable code but still a must-read glimpse into running production software (both Google books are free online).
**Lesson:** Operability knowledge is scattered across classic texts — Code Complete, Clean Code, the Amazon Builders' Library, and Google's SRE books are the recommended starting points.
