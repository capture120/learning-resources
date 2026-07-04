# Chapter 5 Examples: Measure What You Want to Improve

### Google Search Quality and user happiness
Lau joined Google's Search Quality team, where algorithms evaluated over 200 signals (PageRank, anchor text, freshness, keyword proximity, synonyms, location) to return the top 10 results in a few hundred milliseconds. The team needed to know whether changes actually made users happier, but intuition about interfaces or signal weights couldn't answer that reliably. With 100+ million monthly active users, a behavior-based metric was needed rather than guesswork.
**Illustrates:** Without a reliable metric, you can't tell whether a change is forward progress.

### Dan Russell's field studies on search delight
Dan Russell, a Google tech lead for search quality and user happiness, interviewed users directly to learn why they query what they do. He linked happiness to the sense of delight in successful searches — a weather query showing a forecast cartoon, or "28 euro to usd" auto-converting currency. But delight can't be collected and monitored as an operational, day-to-day guide, so Google needed a quantifiable behavioral metric instead.
**Illustrates:** A goal metric must be measurable and operational, not just conceptually right.

### Google's long click metric
Raw click-through rate misleads: a user can click a plausible-looking snippet, land on a low-quality page, and pogostick through several results or queries. Steven Levy's 2011 book In the Plex revealed Google's guarded key metric: the "long click" — the user clicks a result and doesn't come back, or stays a long time — signaling the query was fulfilled, while a "short click" (immediate bounce back) signals unhappiness. Result sets with a higher percentage of long clicks mean happier users, and Google runs thousands of live traffic search experiments per year against such metrics.
**Illustrates:** Pick the metric that captures what you actually want (satisfied users), not a convenient proxy (raw clicks).

### Amit Singhal's name detection system
In a multi-year effort to build a name detection system, Amit Singhal, head of Google's ranking team, noticed the query "audrey fino" returned piles of Italian pages about Audrey Hepburn (fino means fine in Italian) but nothing about the Maltese attorney Audrey Fino — a big deal since 8% of Google queries were names. Licensing the White Pages gave millions of names but couldn't resolve intent, like whether "houston baker" meant a Texan bread baker or a person's name. Millions of long clicks and short clicks supplied the missing intent signal, letting the classifier learn that intent depended on whether the searcher was in Texas.
**Illustrates:** A well-chosen metric is versatile — long-click data solved problems far beyond ranking evaluation.

### David Bailey and universal search
Building universal search — one query across images, videos, news, locations, products — Bailey had to weigh apples-against-oranges result types: "cute puppies" wants images, "us china relations" wants news, "palo alto restaurants" wants reviews and maps. Analyzing historical long-click data decoded query intent (did puppy searchers dwell on images or web results?), enabling data-driven cross-corpus ranking. This capability didn't exist for more than ten years after Google's founding.
**Illustrates:** The power of a well-chosen metric to tackle a wide range of problems.

### Box's performance ratchet
Box's dedicated performance team spent three months shaving seconds off the main page, only to watch other teams' new features add those seconds right back. VP of Engineering Sam Schillace described their fix, "performance ratcheting": a metric threshold that blocks any deploy pushing latency past it until the change is optimized or counterbalanced elsewhere, with the ratchet lowered after every system-level improvement. Performance can then only trend in the right direction.
**Illustrates:** Good metrics can actively drive progress, not just record it.

### Crunch-mode 70-hour weeks at startups
In his first five years at startups, Lau went through crunch periods where managers pushed 70-hour weeks to ship faster, and never concluded afterward that it was right. Near that load, marginal productivity per extra hour drops steeply, hourly productivity falls, errors and bugs rise, burnout and turnover intensify, and overtime is followed by an equal period of "undertime." Measuring productivity per week (product quality, site speed, user growth) beats measuring hours worked.
**Illustrates:** The wrong metric (hours worked) incentivizes unsustainable, counterproductive behavior.

### Adobe QA rewarding bugs fixed
A friend on Adobe quality assurance described a scheme rewarding developers per bug fixed. It backfired: developers tested less rigorously when building features, leaving themselves easy bugs to fix later and rack up points. Tracking bugs outstanding instead of bugs fixed would have removed the perverse incentive.
**Illustrates:** Metric choice shapes behavior — a reward metric can incentivize exactly the wrong thing.

### Zappos refusing to measure call times
Most call centers grade reps on "average handle time" to cut costs, but Zappos CEO Tony Hsieh (in Delivering Happiness) rejected it because it makes reps focus on getting customers off the phone rather than serving them. Zappos didn't measure call times — its longest call ran almost six hours — caring only whether the rep went above and beyond for every customer. That choice underpinned a customer-service culture that took the company from zero revenue in 1999 to over $1 billion annually by its 2009 Amazon acquisition.
**Illustrates:** What you deliberately don't measure is as strategic as what you do.

### Lau's book-writing metric
Writing this book, Lau first set a goal of writing at least three hours per day, but found he spent much of that time re-reading and polishing sentences — some days ending with fewer words than he started with. Great writers like Stephen King and Mark Twain underscore the importance of revision, but Lau knew he was rewriting too much too early and would be better off drafting more chapters. He switched the metric to 1,000 words per day, which took anywhere from two to five hours. The new metric pushed him toward drafting new content instead of premature editing — sentence quality could be revisited later — and significantly increased his writing pace.
**Illustrates:** Picking the right metric applies to personal goals too; changing the metric changes the behavior.

### Airline pilots' cockpit instruments
Pilots' goal is flying passengers from A to B, but they never fly blind: the altimeter shows altitude via pressure differences, the attitude indicator shows orientation to the horizon, the vertical speed indicator shows climb or fall rate, and hundreds of other instruments let them cross-check the aircraft's health. Software teams need the equivalent to understand their systems' state.
**Illustrates:** Goal metrics and operational instrumentation are complementary — instrument everything.

### Twitter flying blind, then instrumenting
Jack Dorsey told a Stanford entrepreneurship lecture that for Twitter's first two years the team was flying blind — no idea what was happening with the network, the system, or usage — and the site went down constantly, making the "Fail Whale" graphic familiar to users. Only after engineers started monitoring and instrumenting their systems could they identify problems and build the reliable service used by over 240 million people monthly. Twitter later built Observability, a distributed platform handling 170 million individual metrics per minute.
**Illustrates:** Without instrumentation you can only guess at failures; with it you can fix them.

### The HealthCare.gov rescue
The 2013 HealthCare.gov launch cost nearly $292 million and failed: an estimated 1% of the 3.7 million people who tried to register in the first week succeeded; the rest hit errors, timeouts, or login failures, and contractors debugged by rebooting and guessing because there were no instruments. A team of Silicon Valley veterans first instrumented key parts of the system and built a dashboard showing usage, response times, and traffic flow. With visibility, they cut load times from 8 seconds to 2 via caching, reduced error rates from 6% to 0.5%, and scaled to over 83,000 simultaneous users; six weeks after they added monitoring the site worked reasonably, and over 8 million Americans signed up for insurance.
**Illustrates:** Instrumentation is the prerequisite for diagnosing and fixing problems.

### Diagnosing a login-error spike and a production outage
Two thought experiments show which metrics turn guessing into diagnosis. A spike in user login errors — new bug, network glitch in the authentication backend, or a malicious user programmatically guessing passwords? Answering requires knowing when the errors started, the time of the latest code deployment, the network traffic of the authentication service, and the maximum authentication attempts per account over various time windows. A web application suddenly failing in production — a Reddit traffic spike overloading the servers, the Memcached or MySQL layer running out of space or throwing errors, or an accidentally deployed broken module? Dashboards with tables of top referrers, performance graphs for the data stores, and application error graphs narrow the hypotheses. Without these metrics you're left guessing and may waste effort on non-problematic areas.
**Illustrates:** Supporting metrics convert open-ended debugging into fast hypothesis elimination.

### Etsy's "measure anything, measure everything"
Etsy's engineers release code and configuration over 25 times per day, enabled by heavy investment in metrics for servers, application behavior, and network performance. Using Graphite for flexible real-time graphing and StatsD for aggregation, a single line of code defines a new counter or timer and auto-generates a composable time-series graph. They measure new registrations, shopping carts, items sold, image uploads, forum posts, and application errors, and correlate graphs with deployment times to quickly spot bad releases.
**Illustrates:** Making instrumentation trivially easy means it actually happens, enabling fast, safe iteration.

### Monitoring platforms at Google, Twitter, LinkedIn
Google site reliability engineers use Borgmon to collect, aggregate, and graph metrics and alert on anomalies. Twitter's Observability platform collects, stores, and presents 170 million individual metrics per minute. LinkedIn's inGraphs lets engineers view dashboards, compare metrics over time, and set threshold alerts with a few lines of configuration — and open-source tools (Graphite, StatsD, InfluxDB, Ganglia, Nagios, Munin) or managed services (New Relic, AppDynamics) put the same capability within any team's reach.
**Illustrates:** Successful companies build flight-instrument equivalents; small teams can too.

### Percona's MySQL consultants
Percona consultants audit a customer's MySQL configuration, OS, hardware, architecture, and table design and within a day or two assess performance: which queries run slow, whether there are too many connections, how much runway remains before partitioning, what an SSD switch would gain. Consultant Baron Schwartz credits their collective experience across thousands of installations — tagging, friends, queues, click tracking, search, pagination "done a hundred different ways" — which lets them benchmark any system against internalized expected numbers instead of testing configurations one by one.
**Illustrates:** Internalized useful numbers are a shortcut for knowing where to invest effort.

### Jeff Dean's numbers and the storage-system estimate
Jeff Dean — the long-time Googler behind Protocol Buffers, MapReduce, BigTable, and core systems like search and indexing — shared 13 latency numbers every engineer should know, from a 0.5 ns L1 cache reference to a 150 ms California–Netherlands round trip. The chapter applies them: in a system with disk-persisted writes and memory-cached reads, 10 ms disk seeks cap writes at ~100/second, while 250 μs per 1 MB memory reads allow ≥4,000 object reads/second — reads roughly 40x faster than writes, so scaling means parallelizing or batching writes. Knowing that memory is ~120x faster than disk, or that 2x Snappy compression halves network traffic for ~50% more latency, lets you evaluate designs without building them.
**Illustrates:** Back-of-the-envelope math from internalized numbers replaces expensive experiments.

### Spotting anomalies in a Rails app
For an engineer on a standard stack like Ruby on Rails, baseline numbers — time to fetch a row, run an aggregation, join tables, hit the cache — make anomalies jump out. A development server taking 400ms for a simple static page suggests assets are served from disk instead of cache; a dynamic page spending over a second in the database suggests an unexpected expensive join. Baselines make such hypotheses quick to form.
**Illustrates:** Internalized numbers help you spot when measurements look wrong.

### MailChimp's email benchmarks
MailChimp published delivery data from hundreds of millions of emails, computing open and click-through rates by industry: emails to social networks and online communities average roughly 22% opens and 3.9% click-throughs. An engineer improving engagement for a social product can compare against these to judge whether their campaigns are poor, satisfactory, or excellent — and whether email work would be high-leverage.
**Illustrates:** Industry benchmark numbers clarify the scope and location of improvement opportunities.

### Sam Schillace on data abuse and skepticism
Schillace, who ran engineering for Google Apps before Box, warned that all data can be abused — people interpret it the way they want. Examples: attributing longer time-on-feature to engagement when users are actually confused; celebrating rising ad clicks after a search change when users click ads because results got worse; celebrating a page-view spike that's really one user's scraping bot. Trained as a mathematician, his defense is the good math student's habit: at the end of a problem, ask "does that roughly make sense?" — check numbers against intuition, re-derive them another way, and verify implied properties.
**Illustrates:** Skepticism and sanity checks are the best defense against misleading data.

### Netflix logging liberally
Eric Colson, former VP of Data Science and Engineering at Netflix, explained that Netflix throws reams of semi-structured logs into Cassandra, a scalable data store, deciding only later whether the data is useful for analysis.
**Illustrates:** Log data liberally in case it becomes useful later.

### Quora's logging inspection tools
Working on Quora's experiment and analytics frameworks, Lau's team built tools to easily inspect what was being logged by each interaction. The investment paid off in huge dividends.
**Illustrates:** Build tools that let you iterate on data accuracy sooner.
