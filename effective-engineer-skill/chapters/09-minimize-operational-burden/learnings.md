# Chapter 9: Minimize Operational Burden

Every feature and system you ship keeps costing time after launch: keeping it running, scaling it, fixing bugs, and teaching it to new engineers. These recurring costs tax the time you could spend on higher-leverage work, so effective engineers deliberately minimize them. The chapter's model is Instagram, which supported 40 million users with 13 employees by embracing simplicity and proven technology; the chapter then adds fail-fast design, automating mechanical tasks, idempotent batch processes, and practiced recovery as further strategies for cutting operational burden.

## Core Principles

- **Operational costs start at launch, not end there.** Development cost does not stop when a feature ships; maintenance, scaling, bug fixing, and knowledge transfer keep accruing. Mike Krieger compared each new feature or system to an extra house a small fire department must be ready to firefight. Internalizing this cost changes what you choose to build in the first place.

- **Do the simple thing first.** Simple solutions are easier to understand, maintain, and modify, so they carry a lower ongoing burden. Instagram made this a core engineering tenet applied to product, hiring, and engineering, and design reviews explicitly asked "Is this the simplest thing?" When teams skip this discipline, upkeep costs erode their effectiveness until they are forced to simplify anyway (as Pinterest was).

- **Prefer proven, boring technology over shiny new tools.** Every additional technology you adopt is, in Krieger's words, mathematically guaranteed to go wrong over time; enough of them and operations consumes the whole team. Instagram stuck with PostgreSQL, Memcache, and Redis instead of trendy NoSQL stores, and avoided writing custom software it would have to maintain.

- **Complexity that outgrows the team destroys productivity.** Too many systems splinters expertise, adds single points of failure (only one person knows a critical component), steepens the learning curve for new engineers, and dilutes tooling effort across systems. A well-designed architecture grows by adding more of the same components, not by introducing new kinds of systems.

- **Fail fast to make errors findable.** Masking errors with defaults, catch-all handlers, and swallowed return values makes software fail slowly: it keeps running but produces indecipherable bugs far from their source. Failing immediately and visibly sounds fragile but actually makes software more robust, because bugs get found and fixed before production. The more complex the system, the more time fail-fast techniques can save — prioritize the investment where complexity is highest.

- **Time is your most valuable resource; automate what machines can do.** Manual band-aids are faster in the moment, but automating repetitive work scales your impact and eliminates avoidable interruptions like 3 AM pages for tasks a script could run. The judgment call: will you save more time overall doing the task by hand or paying the upfront cost of automation? The upfront cost (including learning to automate) may exceed the manual cost at first, but the skill compounds and pays for itself as you apply it to more problems.

- **Automate mechanics before decision-making.** Automating a fixed sequence of steps is straightforward and testable; automating decisions (self-healing systems) is hard, rarely well tested, and runs in exactly the unusual circumstances where it can run amok and cause worse outages. Facebook heavily automated the mechanics of moving database shards but kept a human deciding which shards to move for years.

- **At some point, recovering quickly beats preventing failure.** No amount of care eliminates unexpected failures, and prevention hits diminishing returns. Investing in tools, processes, and rehearsed contingency plans for recovery lowers stress, raises confidence, and lets you move faster. Netflix, Google, and Dropbox all deliberately trigger failures in controlled conditions to build this ability.

- **Teams systematically underinvest in recovery.** Simulating failures accurately is difficult, and because failures happen infrequently, handling them better seems lower-payoff than pressing product work. So recovery processes for server failures, database failovers, and other failure modes tend to be inadequate at best — and when finally needed, engineers bumble through them at peak stress with subpar results. Scripting for success and failure drills exist to correct this bias.

## Key Concepts & Frameworks

- **Operational burden**: the recurring cost of operating and maintaining what you build — uptime, scaling, bug fixes, and transferring institutional knowledge — which taxes time that could go to higher-leverage activities.

- **Fail fast** (Jim Shore, IEEE Software): when a problem occurs, the system fails immediately and visibly rather than limping along. Counterintuitively, this makes software more robust because bugs are easier to find and fix, so fewer reach production.

- **Slow failure**: workarounds like defaulting misconfigured parameters, catch-all exception handlers, and swallowing unexpected return values keep programs running but push errors far downstream, where root causes are hard to trace. Examples: a web server that silently defaults a misspelled max_database_connections parameter to 5 (queries mysteriously slow in production), an app that silently fails to save user state (missing data surfaces far from the failure), an analytics job that skips corrupted log data (customers complain days later about inconsistent numbers).

- **Hybrid fail-fast approach**: individual components fail fast close to the error source, while a global exception handler logs the error for engineers and degrades gracefully for the user (e.g., skip rendering one broken page component, or prompt a reload). Aggregate logged errors in a dashboard sorted by frequency to fix them in priority order.

- **Automating mechanics vs. automating decision-making** (Bobby Johnson, Facebook): mechanics — a fixed chain of steps — is straightforward and testable to automate. Decision automation (self-healing, auto-failover) tends to run amok because it executes in untested, unusual circumstances. Example failure mode: a load balancer that reroutes traffic from failed servers works with one failure, but if half the servers fail from overload, rerouting takes down the whole cluster — worse than shedding half the requests.

- **Idempotent process**: produces the same result whether run once or many times, so it can be retried freely without side effects like double-counting.

- **Retryable / reentrant process**: when idempotence is impossible, a process that can complete successfully after an interrupted run — it handles leftover state such as held global locks or partial output. Aim for each process to fail entirely or succeed entirely.

- **Dry runs of infrequent jobs**: idempotence lets you run a monthly script daily or weekly as a dry run, narrowing the window of possible causes when it breaks and giving ample time to fix it before the real run.

- **Scripting for success** (Bill Walsh, San Francisco 49ers): write contingency plans in advance so decisions get made in calm conditions rather than under game-time pressure. Walsh scripted the first 20-25 plays of each game as an if-then tree and won 3 Super Bowls. Engineers can go further and programmatically script their responses and test them for robustness — increasingly important as an organization grows and any infrastructure that can fail begins to fail.

- **Why engineers automate less than they should (five reasons)**: (1) no time right now — deadline and managerial pressure trade automation's long-term benefit for shipping sooner, and consistently deferring it erodes productivity; (2) tragedy of the commons — when manual work is spread across many engineers (e.g., rotating pager duty on a growing team), no individual has enough incentive to automate, so everyone applies quick patches and punts to the next person on call; (3) unfamiliarity with automation tools — command-line scripting, UNIX primitives, and gluing services together are systems skills that get easier with practice; (4) underestimating the task's future frequency — requirements change and mistakes get made, and updating a script beats redoing the task by hand; (5) not internalizing savings over a long horizon — small per-task savings compound into days per year.

## Actionable Practices

- Audit your own operational burden: how much time each day or week goes to maintaining systems and fixing bugs rather than building new things? How often do operational and product issues interrupt you and force context switches away from your priorities? Shaving time off these recurring costs frees you for what matters most.
- Before adopting anything new, ask: "What's the simplest solution that gets the job done while reducing our future operational burden?" Revisit existing sources of complexity and trim them.
- Experiment with new languages on prototypes and toy projects, but before using one in production, ask: do teammates know it, is it easy to learn, can you hire for it?
- Before adopting a new data store, research whether other teams have run it at similar scope with genuinely lower operational burden than MySQL or PostgreSQL.
- Prefer repurposing an existing abstraction or tool over building custom. "Right tool for the job" can add moving parts; weigh that against the simplicity of standardization.
- For large data processing, check whether a single powerful machine suffices before reaching for a distributed cluster; clusters are harder to manage and debug.
- Make software fail fast: crash on startup config errors; validate inputs early (especially ones consumed much later); bubble up unhandled external-service errors instead of swallowing them; throw immediately when a mutation invalidates dependent structures (e.g., modifying a collection under an iterator); throw on corrupted key data structures rather than propagating corruption; assert key invariants around complex logic with descriptive failure messages; alert engineers to invalid or inconsistent state as early as possible.
- Pair component-level fail-fast with a global exception handler that logs for engineers and fails gracefully for users; pipe logged errors into a frequency-sorted dashboard.
- Whenever you do something a machine could do, ask whether automating it is worthwhile. Candidates: validating behavior of code or systems, ETL and data summarization, detecting error-rate spikes, build and deploy to new machines, database snapshot capture/restore, periodic batch computations, restarting a web service, style checking, training ML models, managing user accounts/data, adding or removing servers from a service group.
- Do not dismiss small savings: 10 seconds saved on a task done 10 times a day is nearly a full workday per year.
- Automate mechanics first — collapse a 12-command chain into one unambiguous script. Only attempt decision automation after all mechanical low-hanging fruit is picked.
- Make batch processes idempotent. Example: instead of incrementing weekly counters per log line (re-runs double-count), compute daily counters from logs and derive weekly totals by summing days; retries just overwrite the day. Use hourly counters if a day is too much data.
- If idempotence is impossible, make processes retryable/reentrant: design them to handle held locks and partial output so each run fails or succeeds entirely.
- Schedule infrequent scripts as frequent dry runs; even schedule manual-only scripts (user-state fixes, diagnostics) to run regularly to detect breakage early (Rajiv Eranki's Dropbox practice).
- Reduce false alarms by increasing check frequency: a check every 5-10 minutes fires spurious alerts on transient glitches; running it every 60 seconds and alerting only on consecutive failures dramatically cuts false positives.
- Ask "what if" questions and write contingency plans: bad deploy (how fast can you roll back?), database server failure (failover and data recovery), server overload (scale up or shed load), corrupted staging environment (rebuild), urgent customer issue (support-to-engineering latency).
- Apply the same rehearsal to non-technical failures: a stakeholder objecting at a review, a key teammate leaving (knowledge sharing), user revolt over a feature, a slipping deadline (early detection and response).
- Practice failure scenarios in controlled conditions — kill services during work hours, simulate extra production load — rather than firefighting real emergencies at night or on weekends.

## Key Takeaways

- Do the simple thing first: simpler systems are easier to understand, extend, and maintain.
- Fail fast to pinpoint error sources: don't mask errors or defer failures, and debugging gets easier.
- Automate mechanics over decision-making: aggressively automate manual tasks, but think twice before automating decisions, which are hard to get right.
- Aim for idempotence and reentrancy so actions can be retried safely after failures.
- Plan and practice failure modes: confidence in your ability to recover lets you move more boldly.
