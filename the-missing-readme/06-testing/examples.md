# Chapter 6 Examples: Testing

### The dishwasher that didn't fit the kitchen (sidebar: "It's Only Obvious in Retrospect")
Co-author Dmitriy shopped carefully for a new dishwasher: he read reviews, examined specs in the store, weighed trade-offs, and picked the best model. As the salesperson was about to enter the order, he paused and asked whether the dishwasher was going into a corner, and whether a cabinet drawer slid out at a 90-degree angle right in front of the dishwasher door. Both were true, so the salesperson refused to sell him that model: its protruding door handle would have completely blocked the drawer. A perfectly functioning dishwasher and a perfectly functioning cabinet were completely incompatible — and the salesperson had clearly watched this exact combination fail before. The fix was a similar model with an inset handle. **Lesson:** Integration testing exists because individually correct components can fail in combination, and such failures are only obvious in retrospect.

### Successful open source projects have messy test suites (sidebar: "Testing in the Real World")
While writing the chapter, the authors surveyed the test setups of many successful open source projects. Many were missing whole flavors of tests; others intermingled "unit" and "integration" tests with no clean separation. Their conclusion: know what the categories mean and the trade-offs between them, but don't get wrapped up in perfect categorization — successful projects make pragmatic real-world testing decisions. Improve tests when you get the opportunity, don't fixate on naming, and don't pass judgment on imperfect setups, because software entropy is a powerful force. **Lesson:** Pragmatism beats taxonomy purity in real-world testing.

### Synthetic monitoring: fake shoppers in production
Some organizations ship systems too large to test and release in lockstep, so passing a full system test before each release is unrealistic. They instead run extensive integration tests supplemented with continuous synthetic monitoring: scripts running in production that simulate a user registering, browsing, and purchasing an item. This requires instrumentation so billing, accounting, and other downstream systems can tell these production test transactions apart from real customer activity. **Lesson:** When end-to-end preproduction testing can't keep up with system scale, continuously test in production with simulated users that downstream systems know to ignore.

### Acceptance tests in enterprise contracts and ISO audits
In enterprise software, formal acceptance tests and criteria are commonly laid out as part of an expensive contract, and the customer (or a proxy) runs them to validate the delivery. The International Standards Organization requires acceptance tests that validate explicit business requirements as part of its security standard; certification auditors will ask for documented evidence of both the requirements and the corresponding tests. **Lesson:** Acceptance testing can be a contractual and regulatory obligation, not just a courtesy check.

### "I just changed a thing — does everything still look good?"
In less regulated organizations, acceptance testing is informal. It often amounts to a developer pinging someone after a change and asking them to confirm everything still looks right. **Lesson:** Even casual "can you check this?" requests are acceptance tests — the same activity as formal contract validation, minus the paperwork.

### The `isTest` boolean anti-pattern
The chapter calls out a specific bad habit: adding test-specific methods, parameters, or variables to application code — epitomized by a boolean `isTest` parameter on a method. Such test-specific changes are difficult to maintain, make code hard to read, and cause confusing bugs. Mocks solve the same problem cleanly, including accessing protected methods and variables without modifying regular code. **Lesson:** Never let test concerns leak into production code paths; use mocks instead.

### The risk matrix (Figure 6-1)
The chapter shows a grid for prioritizing test effort. Failure likelihood runs up the y-axis (Very Unlikely to Very Likely) and failure impact across the x-axis (Negligible, Minor, Moderate, Significant, Severe); each cell's label runs from Low risk (unlikely and negligible) to High risk (very likely and severe). Testing shifts code downward on the chart by making failures less likely. The guidance: focus on high-likelihood, high-impact areas first, and don't bother testing low-risk or throwaway code like a proof of concept. **Lesson:** Allocate testing effort by likelihood-times-impact, not uniformly.

### SimpleThrottler: throttling logic you can't test without an injectable clock
A Ruby class illustrates time-dependent nondeterminism. The broken version reads the system clock directly:

```ruby
class SimpleThrottler
  def initialize(max_per_sec=1000)
    @max_per_sec = max_per_sec
    @last_sec = Time.now.to_i
    @count_this_sec = 0
  end

  def do_work
    @count_this_sec += 1
    # ...
  end

  def maybe_throttle
    if Time.now.to_i == @last_sec and @count_this_sec > @max_per_sec
      throttle()
      @count_this_sec = 0
    end
    @last_sec = Time.now.to_i
  end

  def throttle
    # ...
  end
end
```

A test can't guarantee the throttle condition ever triggers: two consecutive operations can take unbounded time if the machine is degraded or the OS schedules the test process unfairly. The fix makes the clock a constructor parameter (`initialize(max_per_sec=1000, clock=Time)`) and uses `@clock.now.to_i` everywhere — dependency injection. Tests inject a mock clock returning whatever integers trigger `maybe_throttle`; production code defaults to the real system clock. **Lesson:** Static time calls make logic untestable; inject the clock so tests control the passage of time precisely.

### The 500 ms wait that fails at 501 ms
Code that waits 500 ms for something to happen is brittle: the test passes when the operation completes in 499 ms and fails when it takes 501 ms. Network latency and CPU speed change how long operations take, and system clocks progress independently. Static clock methods like `now` or `sleep` are the telltale sign of this fragility. **Lesson:** Tests built on fixed time intervals fail on timing noise, not on real bugs.

### The 30-minute sleep that puts a floor on your suite
If a test sleeps for 30 minutes, the fastest your test suite will ever run is 30 minutes — slowing development and debugging for everyone. And tests with a very high (or no) timeout can get stuck indefinitely. The chapter's advice: if you're tempted to sleep or set a timeout, make an honest effort to restructure the test to run deterministically; if it's truly impossible (as with some concurrent or asynchronous code), that's acceptable. **Lesson:** Sleeps and loose timeouts trade away suite speed and reliability; design them out when you can.

### Port collisions: the test that can't bind
Two scenarios show why static network ports break tests. First, leaked sockets: frameworks reuse one process for many tests, so a test that doesn't close its socket blocks the next test from binding to the same port even when running serially. Second, hard-coded ports: a test passes on one machine and fails on another where the port is already taken, and a suite where every test binds the same port works serially but fails nondeterministically in parallel because execution order varies. The fix is binding to port zero so the OS picks an open port, then retrieving the assigned port for the rest of the test. **Lesson:** Close sockets and bind to port zero so tests never fight over network ports.

### The row-count test that only fails with neighbors
A test inserts a database record and asserts that exactly one row exists. Run alone against a clean database, it passes; run alongside another test that wrote to the same table, it fails. Nothing about the code under test changed — only the leftover state around it. Leftover state also fills disk space, destabilizing the whole test environment. Shared integration environments amplify the problem: they're expensive to set up and therefore shared, with parallel tests reading and writing the same datastores and disturbing each other's data and performance. **Lesson:** Tests must isolate their state and clean up after themselves — pass or fail — or their results depend on what else happened to run.

### Random numbers seeded by the system clock
By default, random number generators seed themselves from the system clock. Since the clock changes between runs, two runs of the same test produce different random sequences — nondeterminism. Seeding the generator with a constant forces the identical sequence every run, so the test always passes or always fails. **Lesson:** Constant-seed your RNGs in tests to make randomness deterministic.

### The unit test that calls a remote web service
The chapter's canonical nondeterministic test is a unit test that invokes a call to a remote web service on a network socket: if the network fails, the test fails. Network hops are unstable and calls can time out, so a test might pass hundreds of times and then fail once due to a network timeout. The remote systems themselves are also unreliable — they get shut off, restarted, or frozen, and if a remote system is degraded, the test fails. Such tests aren't portable either: the host machine running the test must have access to the remote system, and remote test systems often sit in internal integration test environments that aren't easily reachable. The fix is eliminating remote calls from unit tests with mocks, or refactoring so remote systems are required only in integration tests. **Lesson:** A unit test that crosses the network inherits the network's unreliability; keep remote systems out of unit tests.

### Don't handcraft tests for scaffolding and OpenAPI clients
Autogenerated code, like web framework scaffolding or OpenAPI clients, shows up as untested in coverage reports if the tools aren't configured to ignore it. The right response is fixing the coverage tool configuration, not writing tests — code generators are themselves thoroughly tested, so testing their output wastes time. Exceptions: if you manually modify generated files, test them; and if you find a genuine need to test generated code, add the tests to the generator instead. **Lesson:** Test the generator, not the generated code, and configure coverage tools to ignore generated output.

### Load testing at 10, 100, and 1,000 users
The chapter illustrates load testing as measuring how a system performs when 10, 100, or 1,000 users access it concurrently, while stress testing pushes load past those levels to the point of failure to learn how far the system can go and how it behaves under excess. Both feed capacity planning and SLO definitions. **Lesson:** Step through escalating load levels to characterize performance, then push to failure to find limits.

### Level Up: the chapter's recommended reading
Rather than exhaustive testing textbooks, the authors recommend targeting specific techniques: *Unit Testing* by Vladimir Khorikov (Manning, 2020) for testing philosophy, patterns, and anti-patterns (it covers integration testing too, despite the name); Kent Beck's *Test-Driven Development* (Addison-Wesley, 2002), a must if your organization practices TDD; the property-based testing section of *The Pragmatic Programmer* by Andrew Hunt and David Thomas (Addison-Wesley, 1999), a technique the authors cut from the chapter but endorse; and Elisabeth Hendrickson's *Explore It!* (Pragmatic Bookshelf, 2013) on exploratory testing for learning complex code. **Lesson:** Go deep on specific testing techniques rather than reading exhaustive textbooks.
