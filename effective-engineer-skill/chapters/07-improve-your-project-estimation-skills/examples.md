# Chapter 7 Examples: Improve Your Project Estimation Skills

### Ooyala's Flash player rewrite (Edmond Lau)
In August 2008, Ooyala's 8-person engineering team began a full rewrite of its Flash-based video player, which had accumulated heavy technical debt with no automated tests over the company's first 18 months. Three senior engineers estimated 4 months for the whole team, with parallel work on playback, analytics, ads, and UI, plus one week of integration at the end; new feature development was paused for the duration. Lau noticed schedule overlaps and the aggressive assignment of the same engineer to two projects at once, but brushed off the worry. Unplanned problems piled up: a Thrift analytics migration budgeted at a few days required Lau to spend over a week writing a C++ compiler extension because Thrift lacked ActionScript support; third-party ad modules were buggy; an Adobe low-level interface didn't reliably report buffering state and needed painstaking heuristics. The player, ironically named "Swift," shipped in May 2009 — 5 months late, nearly 9 months after starting — during the 2009 recession, when the slip threatened the startup's survival. Had the team known it would take 9 months, they would have scoped down, rewritten incrementally, or cut other obligations. Ooyala stayed afloat, the launch opened up many other business opportunities, and the company went on to deliver over 1 billion videos to nearly 200 million unique viewers per month.
**Illustrates:** How estimates made by people not doing the work, unbudgeted unknowns, and rewrite risk compound into massive schedule slips.

### Famous industry slips: Vista, Netscape 5.0, Daikatana
Windows Vista slipped more than 3 years. Netscape 5.0 slipped 2 years while the browser's market share fell from 80% to 20%. The game Daikatana, aggressively scheduled for 7 months, slipped repeatedly, launched two and a half years past its original date, ran millions of dollars over budget, and destroyed the company.
**Illustrates:** Large-project slippage is common and its business costs can be existential.

### Standish Group study (2009)
After studying over 50,000 software projects, the Standish Group found 44% were delivered late, over budget, or missing requirements; 24% failed to complete; and the average slipped project overran its time budget by 79%.
**Illustrates:** Poor estimation is the industry norm, not an exception — which is why the skill is high-leverage.

### Steve McConnell's definition of a good estimate
In Software Estimation, McConnell defines a good estimate as one that gives project leadership a clear enough view of reality to make good decisions about controlling the project toward its targets. This separates estimates (the engineer's best guess) from targets (a desired business goal).
**Illustrates:** Estimates should inform planning; don't let targets alter estimates.

### Tom DeMarco on optimistic estimates
In Controlling Software Projects, DeMarco notes we treat an estimate as the most optimistic prediction with non-zero probability of coming true — estimation becomes a game of naming the earliest date nobody can prove you'll miss.
**Illustrates:** Think of estimates as probability distributions spanning best and worst cases, not best-case dates.

### Dan Ariely's wine-price anchoring experiment
Ariely, a Duke behavioral economist, had students write the last two digits of their social security number before estimating wine bottle prices. Students with higher digits estimated significantly higher prices, sometimes more than twice as high — arbitrary numbers subconsciously anchored their estimates. The same happens when a manager tosses out a casual ballpark for a project.
**Illustrates:** Beware anchoring bias; never commit to a number before outlining the tasks.

### Frederick Brooks and the mythical man-month
Brooks explains that measuring projects in person-months breeds the myth that people and time are interchangeable — but nine women can't produce a baby in one month. Communication overhead grows quadratically with team size, and new members need ramp-up time before they're productive.
**Illustrates:** Adding people doesn't proportionally shorten a project timeline.

### Joel Spolsky on data-driven estimates
The Stack Exchange co-founder argues for backing estimates with historical evidence: if you know you historically underestimate by 20%, scale your estimate up by 25%; if user or revenue growth rose 25% last quarter, that grounds this quarter's expectation.
**Illustrates:** Validate estimates against historical data.

### The Python-to-Scala port spreadsheet
On a project porting a Python application to Scala, Lau set up a simple spreadsheet where team members logged estimated versus actual hours per task. Most initially underestimated, often by a factor of two. Within a week or two, the visibility calibrated everyone's sense of how many lines of code they could migrate per week, which later produced more accurate milestone estimates.
**Illustrates:** Measuring estimated vs. actual time quickly improves estimation accuracy.

### Ooyala's unbudgeted work list
Ooyala's rewrite team didn't lack effort — people worked 70-80 hour weeks for months, coding even over the holidays. The excessive slip came from entirely unestimated work: building a unit testing harness with custom mocking and assertion libraries, writing style guidelines, high-priority customer deals each pulling engineers off for a week or two, debugging video corruption crashes on Internet Explorer, firefighting scalability problems, losing an engineer mid-project, resuming product development after 4 months, rewriting UI components from scratch to shrink the binary, and migrating from Subversion to Git. Each was survivable alone; compounded, they wrecked the schedule. Brooks's line applies: disaster comes from termites, not tornadoes. And because new feature development had been deferred for 4 months, when that budget expired the team suddenly had to finish the player rewrite while also addressing the customer requests that had been queuing — so development speed slowed down even more after the original delivery date was missed.
**Illustrates:** Budget for the unknown — small unplanned tasks compound into large slips.

### Jack Heart at Asana
Heart, an engineering manager at Asana, explained that his team maps each ideal engineering day to 2 workdays to account for daily interruptions.
**Illustrates:** Separate estimated work time from calendar time and build in buffer.

### Alex Allain at Dropbox
Allain, who leads Dropbox's internal platforms and libraries teams, sometimes lays out a week-by-week project schedule in a spreadsheet, annotating who works on what each week and blocking off holidays and vacations, as a lightweight sanity check.
**Illustrates:** Explicitly accounting for competing time investments and absences when scheduling.

### Tamar Bercovici's database sharding at Box
In late 2012, Box's entire application database had lived on a single MySQL instance for 7 years, and traffic had grown to nearly 1.7 billion queries per day, with folder and file tables at tens and hundreds of millions of rows; capacity would run out within months. Bercovici's team sharded the two tables — a risky project touching much of an 800K-line codebase with no downtime allowed. She set a clear goal (migrate to sharded architecture as soon as possible without downtime), which let the team reject scope additions: she herself initially pushed to rewrite the data access layer to ban arbitrary SQL snippets, but against the goal the team agreed it would lengthen the project and could be worked around. Bercovici also stressed building alignment: "[I]t's very, very important to understand what the goal is, what your constraints are, and to call out the assumptions that you're making … [M]ake sure that you build alignment on that … with any other stakeholders you might have in your project." They defined measurable milestones: (1) refactor code so queries can be sharded, converting single-database joins into application-level joins; (2) logically shard while still hitting one database; (3) move a single shard to another database; (4) fully shard all file and folder data. Each milestone introduced verifiable value, letting the team ask of every task, "Is this a prerequisite for this milestone?" The migration succeeded, growing to billions of files across tens of shards despite bugs along the way (like duplicate folders appearing while a shard copied).
**Illustrates:** Specific goals and measurable milestones defend scope, build alignment, and keep a risky project on track.

### The Ooyala analytics format decision
While rewriting the player's analytics module, the team switched to a more extensible logging format up front, reasoning it would soon be needed anyway and would save work long-term. Well-intentioned decisions like this created costly delays because success was fuzzily defined — reducing total work versus shipping a working product sooner.
**Illustrates:** Without a specific goal, locally rational tradeoffs delay the global outcome (tragedy of the commons).

### To-do comments discovered at integration
On one project, the team realized only at integration time that comments with unfinished to-dos were scattered throughout the codebase. The time to finish these punted tasks wasn't in the integration budget, forcing a scramble to meet the deadline.
**Illustrates:** Integration almost always takes longer than planned; front-load end-to-end scaffolding and system testing.

### Sam Schillace on rewrites
When Lau asked Schillace — who ran Gmail and Google Apps for four years — about the costliest mistake he'd seen engineers make, he answered that trying to rewrite from scratch is "the cardinal sin."
**Illustrates:** Rewrite projects are the riskiest projects.

### Phil Crosby's Flash-to-HTML5 migration at Ooyala
After the player rewrite, tech lead Phil Crosby migrated Ooyala's large Flash-based content management system to HTML5. A big-bang rewrite risked forcing new features to be built in both Flash and HTML5 if the schedule slipped. Instead the team invested up front in infrastructure for a hybrid application that embedded HTML5 components inside the Flash app, letting them port and launch components one at a time and write new features solely in HTML5. It was more total work, but it increased flexibility and greatly reduced time pressure.
**Illustrates:** Incremental rewrites trade extra work for dramatically lower risk.

### Harry Zhang's API rewrite at Lob
Zhang's team at Lob (an API for printing and mailing documents) rewrote their messy API services in Node.js. Rather than switching all at once, they built a proxy server that selectively routed traffic per endpoint between old and new API servers. Preserving the interface let them deploy new endpoints incrementally and roll back on errors, giving leeway to finish the rewrite while still handling customer issues.
**Illustrates:** Deploying old and new systems side by side de-risks a rewrite.

### Schillace's Writely-to-Google port (Google Docs)
Schillace's four-person startup Upstartle built Writely, an online documents product that grew to half a million users before Google acquired it. Writely was in C#, which Google's data centers didn't support, and thousands of users kept signing up daily. A co-founder wanted to rewrite disliked parts of the codebase during the Java translation — why translate to Java only to immediately throw parts away? Schillace refused ("We're not doing that because we'll get lost"), insisting on two phases: first translate to Java and get it standing, then refactor what bothers you. The goal was the shortest path to running in Google's data centers. Even that was brutal — integrating 12 internal Google technologies, a week of regex-driven code conversion, then fixing tens to hundreds of thousands of compile errors — but the disciplined approach finished the port in 12 weeks, the fastest acquired-team port into Google infrastructure at the time, paving the way for Google Docs.
**Illustrates:** When incremental deployment isn't possible, break the rewrite into separate targeted phases with a minimal first-phase goal.

### Ooyala's rewrite in hindsight
Lau concludes that a two-phase approach like Schillace's is the single most effective change that would have maximized Ooyala's chances of delivering on time. A specific goal — such as "as soon as possible, build a drop-in replacement for the player that supports dynamically loadable modules, is unit tested, and can later be extended with ad integrations, analytics reports, and video controls" — would have meant aggressively deferring everything unnecessary: the Thrift analytics migration, additional ad modules, a sleeker player skin, and performance work beyond the minimally viable. Those improvements could then be prioritized against the roadmap after launch. The result: fewer 70-80 hour weeks, fewer features duplicated between old and new players, and more flexibility to absorb surprises.
**Illustrates:** A specific goal plus a phased rewrite turns a runaway project into a deliverable one.

### Two sprints in the middle of marathons
Lau was on two multi-month projects where a well-intentioned manager pushed the team from roughly 60 to 70 hours per week to hit an aggressive deadline, both teams convinced a slip would break the business. After several months of sprinting, neither project was finished — the teams had started sprinting in the middle of a marathon, not the home stretch.
**Illustrates:** Overtime doesn't rescue a project whose remaining work is underestimated.

### A century of overtime research
Employers in the 1890s got higher total output per worker when they tried 8-hour days. Sidney Chapman found in 1909 that overtime productivity declines rapidly as fatigued workers make mistakes, borrowing against later days' output. Henry Ford instituted the 40-hour week in 1922 after years of experiments showed it increased total worker output. A 1980 study found that sustained 60+ hour weeks beyond about two months produce enough cumulative productivity loss to delay completion past what a 40-hour week would have achieved.
**Illustrates:** Hourly productivity decreases with added hours; extended overtime can make projects finish later.

### DeMarco and Lister's "undertime" (Peopleware)
DeMarco and Lister document that overtime is almost always followed by an equal period of compensatory undertime as workers catch up on their lives, and that overtime's upside is exaggerated while its downsides — errors, burnout, accelerated turnover — are substantial.
**Illustrates:** The limits of overtime as a scheduling tool.
