# Chapter 4 Examples: Invest in Iteration Speed

### Quora's continuous deployment

The author's team at Quora released new versions of the web product to users 40 to 50 times on a given day. Any committed code was automatically shipped to production: each change was vetted by thousands of tests in about seven minutes, then rolled out to millions of users with no human intervention, while most other companies shipped weekly, monthly, or quarterly with releases that took hours or days. New engineers added themselves to the team page as one of their first tasks, so code written on an engineer's first day went to production — exhilarating and frightening to the author when he joined in August 2010. Infrastructure investments made this possible — automatic versioning and packaging, a testing framework parallelizing thousands of tests across worker machines, canary web servers validating new builds before full rollout, health dashboards and alerts, and easy rollback tools. During the author's last year at Quora, new user registrations and engagement metrics grew more than 3x, with continuous deployment and other iteration-speed investments contributing heavily.
**Illustrates:** Investing in iteration speed is high-leverage; small automated releases enable fast, confident shipping.

### Bug fix in one sitting vs. spread over weeks

With continuous deployment, an engineer who finds a bug can implement the fix, deploy it, and verify it works in a single sitting. Under a traditional workflow, the same fix waits days to be packaged with the week's release and must then be validated alongside many unrelated changes, forcing context switching and mental overhead.
**Illustrates:** Small, incremental deploys eliminate release overhead and context switching.

### Live database schema migration

Migrating a production database table requires five sequential steps: create the new schema, deploy code writing to both schemas, copy existing data over, deploy code reading from the new schema, then remove writes to the old schema. Spread across 4–5 weekly releases this is laborious; with continuous deployment an engineer can do all 4–5 deploys within a few hours and be done.
**Illustrates:** Fast release cycles turn multi-week sequential work into hours.

### Debugging a metric drop: hundreds of changes vs. a handful

When a bug or a performance or business metric drop follows a release, a team on a weekly cycle must dig through hundreds of changes from the past week to find the cause. With continuous deployment, the culprit sits among the handful of changes deployed in the past few hours.
**Illustrates:** Small batches make debugging and root-causing dramatically easier.

### Settling product debates and performance regressions with quick deploys

In a product debate over whether to keep a feature, the Quora team could log the relevant interaction, deploy, and see initial usage data within minutes instead of letting opinions or politics decide or waiting for the next release cycle. Likewise, facing a page performance regression, they could deploy a logging change in minutes to get a live breakdown of where time was spent instead of scanning code for the cause.
**Illustrates:** Fast iteration enables data-driven workflows that slow release cycles make impossible.

### Facebook: "Move fast and break things"

Facebook's headquarters posters proclaim its move-fast mantra, and the culture helped it reach over 1 billion users in 8 years. New employees go through Bootcamp, a 6-week onboarding program, and many — including engineers who have never used PHP — ship production code within their first few days. Facebook may not use continuous deployment in production, but it has scaled its workflow so that over a thousand engineers deploy to facebook.com twice a day. Zuckerberg's IPO letter argued that moving fast enables building more and learning faster, that growing companies slow down because they fear mistakes more than lost opportunities, and that never breaking anything means you're not moving fast enough.
**Illustrates:** Move fast to learn fast; iteration speed as cultural priority drives growth.

### Facebook Beacon

Beacon, an early Facebook advertising product, automatically broadcast users' activity on external websites onto Facebook. It caused an uproar and was shut down. The point: not every fast iteration succeeds, but each one sharpens your sense of which changes point in the right direction.
**Illustrates:** Fast iteration means some failures, but each attempt improves future judgment.

### Facebook's worst outage

Over a four-year period, Facebook's worst outage lasted only 2.5 hours — shorter than outages at larger, slower-moving companies.
**Illustrates:** Moving fast does not mean moving recklessly.

### Wealthfront: continuous deployment in regulated finance

Wealthfront, a Palo Alto financial advisory service replacing human advisors with software, managed over a billion dollars in customer assets as of June 2014. Despite the high cost of breakage and heavy SEC regulation, it ships to production over 30 times per day via continuous deployment. Former CTO Pascal-Louis Perez said its primary advantage is risk reduction: small batches of changes let the team quickly pinpoint problems.
**Illustrates:** Small-batch deployment reduces risk even in high-stakes, regulated domains.

### Mark vs. Sarah

Two engineers start separate projects. Mark dives straight into feature work for two months. Sarah spends her first two weeks fixing her workflow — incremental compilation, auto-reloading of newly compiled code on her web server, and scripts to set up test-user state — gaining a 33% speedup in her development cycles. After two months she has caught up (her six weeks of feature work match his eight), and she stays 33% faster from then on. The author notes the real version is iterative — fix your biggest bottleneck as you find it — and that 33% likely understates her advantage, since faster tools get used more often and unlock new workflows.
**Illustrates:** Time-saving tools pay off large and compounding dividends.

### Bobby Johnson and Raffi Krikorian on tools

Bobby Johnson, former Facebook Director of Infrastructure Engineering, told the author that almost all successful people write a lot of tools, and that reaching for a tool first was a very good predictor of future success. Raffi Krikorian, former VP of Platform Engineering at Twitter, constantly reminded his team that doing something manually more than twice means writing a tool for the third time.
**Illustrates:** Tools are the multipliers that scale impact beyond finite work hours.

### The San Francisco–New York travel analogy

When the only option was a week-long train ride, people rarely made the trip; since passenger airlines arrived in the 1950s, people travel between the cities multiple times a year. Similarly, a tool that halves a 20-minute task done 3 times a day saves more than 30 minutes daily, because the faster tool gets used more often.
**Illustrates:** Faster tools get used more often, so savings exceed the direct speedup.

### Google compile times

When the author joined Google in 2006, compiling the Google Web Server in C++ took upwards of 20 minutes even with distributed compilation, so engineers compiled only a few times a day and batched large chunks of code per cycle. Google has since cut compile times substantially, including open-source work shortening compilation 3–5x. Dropping from 20 minutes to 2 changes workflows drastically — engineers lean on the compiler instead of visual inspection and iterate on smaller chunks; dropping to seconds enables incremental compilation — saving a file triggers background recompilation, so warnings and errors surface as engineers edit — and engineers compile fifty or hundreds of times daily instead of ten or twenty.
**Illustrates:** Faster tools enable qualitatively new workflows; savings compound beyond the raw speedup.

### REPL languages vs. Java

Testing a small expression in Java requires writing, compiling, and running a whole program. Scala and Clojure, which also run on the Java Virtual Machine, offer a read-eval-print loop for quick interactive evaluation. The time savings come not just from a faster loop but because you end up interactively testing many more small expressions than you otherwise would.
**Illustrates:** Interactive environments multiply how often you validate your thinking.

### Tooling teams at scale

Google, Facebook, Dropbox, and Cloudera dedicate entire teams to internal developer tools. Cutting build time by one minute, across 1,000 engineers building a dozen times a day, saves nearly one person-year of engineering time every week.
**Illustrates:** Tool value scales with adoption across a team.

### The author's Python prototyping framework at Google

On Google's Search Quality team, engineers prototyped new search-result UIs in C++ — great for production performance, but slow compiles and verbosity made it poor for prototyping. During his 20% time, the author built a Python framework for prototyping search features. Once he and his immediate teammates churned out prototype after prototype and demoed them in meetings, others realized they'd be more productive on the framework too, even at the cost of porting existing work.
**Illustrates:** Proving a tool saves time is the best way to drive adoption.

### Ooyala's build system and the Eclipse integration

At Ooyala, the team compiled ActionScript for its Flash video player with an unreliable Eclipse plugin that sometimes silently failed to recompile changes, causing confusion and slow development. The author built a reliable command-line build system, but few teammates adopted it because it forced them off their Eclipse workflow. He then spent extra time hooking the build process into Eclipse, which lowered switching costs enough that the rest of the team changed over.
**Illustrates:** Lowering switching costs is often necessary to get a superior tool adopted.

### The server auto-restart break-even calculation

If your team spends 3 hours a week responding to server crashes and you spend 12 hours building a tool that automatically restarts crashed servers, the investment breaks even after a month and pays dividends afterward. Unlike speculative projects (the chapter's hypothetical: Joe's for-fun Erlang deployment system of unclear business value), time-saving tools have measurable benefits you can use to justify the work — or to prove to yourself it wasn't worth it.
**Illustrates:** Tool investments are quantifiable, earning leeway for future exploration.

### iOS invite-flow bug shortcut

Debugging a bug in a social app's friend-invite flow, you could repeat the normal three-step user path each time — friends tab, pick a contact, craft the message — or spend a few minutes wiring the app to drop you directly into the buggy part of the flow on every launch.
**Illustrates:** Build minimal debugging workflows instead of replaying full user flows.

### Analytics report iteration via URL parameters

Iterating on an advanced report multiple clicks deep in an analytics web app, with filters and a date range to configure each time, you can instead expose the configuration through URL parameters to jump straight to the report — or build a test harness that loads just the reporting widget.
**Illustrates:** Shortcut normal navigation to tighten the validation loop.

### A/B test variant switching via cookie tool

To test variants of an A/B test keyed on a browser cookie, engineers hard-coded the variant-choosing conditional and kept editing it, sometimes recompiling each time. The shorter workflow: an internal tool that sets your cookie to reliably trigger a chosen variant. The chapter notes these scenarios come from real engineers at top tech companies, some of whom used the slow workflow for months before realizing a small investment would fix it.
**Illustrates:** Small workflow investments beat months of paying an iteration tax.

### Mike Krieger on tight feedback loops

Mike Krieger, co-founder and CTO of Instagram, told the author that effective engineers have an obsessive ability to create tight feedback loops: facing a bug in an iOS photo-posting flow, they instinctively spend the 20 minutes to wire things up so one button press reaches the exact state they need, every time.
**Illustrates:** The instinct to invest upfront in debugging loops distinguishes effective engineers.

### The Google engineer who moused through Finder

A Google engineer navigated to code files by mousing through Mac Finder's folder hierarchy. At roughly 12 seconds per file and 60 file switches a day, that's 12 minutes daily; keyboard shortcuts taking 2 seconds instead would save 10 minutes a day — about 40 hours, a full work week, every year.
**Illustrates:** Mastering your programming environment compounds small savings into major gains.

### People dependencies: the frontend/backend priority mismatch

Common people-dependency bottlenecks: a product manager slow at gathering the customer requirements you need, a designer not providing the Photoshop mocks for a key workflow, another engineering team not delivering a promised feature. Concretely: your frontend team is slated to deliver a user-facing feature this quarter that depends on critical functionality from a backend team — but the backend team has put that work at the bottom of its priority list, under a slew of scaling and reliability projects. While laziness or incompetence is possible, the cause is usually a misalignment of priorities rather than negative intention. The sooner you acknowledge you need to personally address the bottleneck, the more likely you can either adapt your goals or establish consensus on the functionality's priority.
**Illustrates:** People bottlenecks usually stem from misaligned priorities; acknowledge and address them early.

### Marissa Mayer's weekly UI review at Google

Every UI change to Google search results needed approval at a weekly review meeting with then-VP Marissa Mayer. Review slots were scarce, demand was high, and some changes needed multiple reviews. Teams that got things done used Mayer's occasional office hours to solicit early and frequent feedback rather than waiting for final approval. The chapter adds that building continuous deployment for search UI changes would have barely helped, since the weekly review was the much bigger bottleneck.
**Illustrates:** Secure decision-maker buy-in early; optimize the actual bottleneck, not the convenient one.

### Quora's growth team eliminating approval meetings

The author's user growth team at Quora initially needed design approval for most live-traffic experiments, and approval meetings were a bottleneck. Over time the team built mutual trust with the founders — who knew the team would use good judgment and seek feedback on controversial experiments — eliminating per-experiment approvals and letting the team iterate much faster and try many more ideas.
**Illustrates:** At smaller companies you can remove organizational bottlenecks directly, often by building trust.
