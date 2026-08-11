# Chapter 9 Examples: Minimize Operational Burden

### Instagram's 13-person team scaling to 40 million users
Instagram launched on the App Store on October 6, 2010, was downloaded over 10,000 times within hours, and reached 40 million users by the time Facebook acquired it for over $1 billion in April 2012. At acquisition it had only 13 employees — a users-to-employees ratio above 3 million to one — and its engineering team never exceeded five engineers in the early years. Co-founder and CTO Mike Krieger said scarcity forced focus: they could not afford systems that broke frequently or needed constant maintenance, and their most valuable lesson was to minimize operational burden. Krieger likened himself to the chief of a small fire department, where every new feature is another house the team might have to firefight.
**Illustrates:** Operational costs accrue after launch; a small team stays effective by minimizing them.

### Instagram choosing boring technology over trendy NoSQL
While many startups adopted fashionable NoSQL data stores and then struggled to operate them, Instagram stuck with stable, well-understood options: PostgreSQL, Memcache, and Redis. Krieger warned that every additional technology is mathematically guaranteed to go wrong over time, and enough of them will consume the entire team with operations. They also avoided reinventing the wheel with custom software they would have to maintain.
**Illustrates:** Prefer proven, boring technology to reduce operational burden.

### Instagram's "do the simple thing first" tenet
Simplicity was a core engineering tenet at Instagram, applied to product, hiring, and engineering — they even had posters saying it. In design reviews the team asked questions like "Is this the simplest thing?" and whether building an entirely new system for one feature was really the simplest option; if not, they reconsidered the approach.
**Illustrates:** Embrace operational simplicity as an explicit, enforced value.

### Steve Jobs on designing the iPod
Asked what he learned from the iPod, Jobs said the first solutions to a problem are usually complex and most people stop there, but if you keep living with the problem and peeling layers away, you can often reach elegant, simple solutions — most people just don't invest the time to get there.
**Illustrates:** Simplicity requires deliberate, sustained effort.

### Burbn becoming Instagram
Krieger and co-founder Kevin Systrom spent over a year building Burbn, a location check-in app competing with Foursquare and Gowalla that awarded points for check-ins, hanging out with friends, and posting pictures. They finished a full iPhone version but judged it cluttered and overrun with features. They cut everything except photos, comments, and likes — the one activity users flocked to — and what remained was Instagram.
**Illustrates:** Do the simple thing first, even when it means cutting a year of work.

### Pinterest's over-complex data architecture
Growing from zero to tens of billions of page views per month in two years, Pinterest engineers Yashwanth Nelapati and Marty Weiner described (in a talk called "Scaling Pinterest") how the team kept adding complexity to handle scaling. At one point the database and caching layers alone used seven technologies — MySQL, Cassandra, Membase, Memcache, Redis, Elastic Search, and MongoDB — far more than their three-person engineering team could handle. By January 2012 they had simplified to just MySQL, Memcache, Redis, and Solr, and afterward grew more than 4x by only adding machines to existing services rather than introducing new ones.
**Illustrates:** A good architecture scales by adding more of the same components, not more kinds of systems.

### Three ways software fails slowly
The chapter's illustrations of slow failure: a web server that reads a misspelled max_database_connections parameter and silently defaults it to 5 — the program runs, but in production everyone hunts for why database queries are slow; an application that silently fails to save user state, so the program is far removed from the failure by the time the expected data doesn't read back; and an analytics program that skips corrupted log data and keeps generating reports, until customers complain days later that their numbers are inconsistent.
**Illustrates:** Masking errors keeps software running at the cost of indecipherable bugs far from the source.

### The shared MySQL connection data-corruption bug
Lau's team hit a bug where a web application's reads returned completely unrelated data a few times a day — requesting one type and receiving another, or one value and getting a list of different objects. They suspected the caching layers, the open source caching services, and thread interference; multiple team members spent over a week on it. The real cause: on request timeout, the app failed to reset a MySQL connection in a shared pool, so the next request's first query received the timed-out request's response, which then spread through the caching layer. The web application was under more intense load that week, which made the latent bug surface more often than usual. Failing fast — killing the connection on timeout or asserting connections were clean at request start — would have saved many collective hours.
**Illustrates:** Fail fast to surface errors near their source instead of letting them propagate.

### The Memcached 40-day expiration mistake
To reduce database load, Lau raised a cache key's expiration from 10 days to 40. After deploying, database load spiked higher than before and alerts fired, so he reverted. Investigation revealed that Memcached treats expiration values over 30 days (2,592,000 seconds) as UNIX timestamps, so his "40 days" was read as a 1970 timestamp and values expired immediately — as if nothing were cached. If Memcached had failed fast on the invalid input instead of silently reinterpreting it, the error would have been caught in development.
**Illustrates:** Interfaces that fail fast on invalid input keep errors out of production.

### 3 AM pager duty for a five-command fix
From his own on-call experience, Lau describes traveling with a laptop and wireless data card, an unpredictable schedule, and the particular frustration of being woken at 3 AM only to run five commands a machine could have executed. Deadline pressure the next day makes it easy to skip building the long-term fix.
**Illustrates:** Relentlessly automate mechanical tasks to eliminate avoidable interruptions.

### Facebook's manual MySQL load balancing
Facebook ran one of the world's largest MySQL installations — many thousands of servers across data centers, with user profiles assigned to thousands of shards, and tens or hundreds of server failures on a given day. Bobby Johnson, then Director of Engineering over infrastructure, recalled conference attendees describing their magical MySQL failover and load-balancing systems while companies with just 20 servers wrote self-healing scripts — yet Facebook "still just had a guy who did that." The mechanics of moving a shard between servers were heavily automated, but a human ran scripts to find overloaded machines and decided which shards to move where. Only years later did Facebook deploy MySQL Pool Scanner to automate rebalancing decisions.
**Illustrates:** Automate mechanics first; decision automation is much harder and can wait.

### The load balancer that could take down a cluster
Johnson explained that self-healing systems tend to run amok because they operate in unusual, rarely tested circumstances, and some of Facebook's worst outages came from them. Example: a rule that reroutes a failed server's traffic to the rest of the group works for one failure, but if half the servers fail from overload, the rule dumps all their traffic onto the surviving half and takes down the entire cluster — worse than simply dropping half the requests.
**Illustrates:** Automated decision-making can amplify failures; think twice before building it.

### Idempotent log counting
The chapter's worked example: a script updating weekly database counts of user actions from daily logs. Incrementing counters per log line is not idempotent — a crash and re-run double-counts some entries. The robust design computes per-day counters from the logs, then derives weekly totals by summing the daily values; a retry simply overwrites that day's counters. Hourly counters can substitute if a day's data is too large.
**Illustrates:** Make batch processes idempotent so retries are safe.

### Rajiv Eranki's Dropbox dry-run practice
Eranki, a former Dropbox engineer responsible for scaling infrastructure from 4,000 to 40 million users, suggested scheduling even manual-only scripts — like user-state fixers or diagnostics — to run regularly so errors surface early instead of at the moment the script is urgently needed.
**Illustrates:** Run infrequent processes frequently to expose problems sooner.

### Frequent checks reduce false alarms
A system check running every 5 to 10 minutes can raise spurious alarms when a transient network glitch makes it fail once. Running the check every 60 seconds and alerting only on consecutive failures dramatically cuts false positives, and many temporary failures resolve within a minute without manual intervention.
**Illustrates:** Higher-frequency automation handles glitches transparently.

### Netflix's Chaos Monkey
Netflix built Chaos Monkey, a system that randomly kills services in its own infrastructure, configured to strike on weekdays during work hours so engineers find architectural weaknesses at their desks rather than during nights and weekends. Their blog's stance: the best defense against major unexpected failures is to fail often. When Amazon Web Services suffered major outages, Netflix escaped with little disruption while Airbnb, Reddit, Foursquare, Hootsuite, and Quora were down for hours.
**Illustrates:** Practicing failure builds the ability to recover quickly.

### Bill Walsh's "scripting for success"
In The Score Takes Care of Itself, former 49ers coach Bill Walsh describes writing contingency plans for game scenarios in advance — being down two touchdowns after the first quarter, losing a key player, needing a touchdown on the final play from 25 yards out. Scripting moved decisions out of the roaring-stadium pressure of game time; eventually the first 20 to 25 plays of every game were scripted as an if-then tree. Walsh won 3 Super Bowls and was twice NFL Coach of the Year.
**Illustrates:** Plan responses to failure in calm conditions, not under pressure.

### Google's Disaster Recovery Testing (DiRT)
Google runs annual multi-day DiRT events simulating disasters such as earthquakes or hurricanes cutting power to entire data centers and offices, then verifies that teams, communications, and critical systems keep functioning. The exercises expose single points of failure, unreliable failovers, and outdated emergency plans in a controlled setting.
**Illustrates:** Rehearse failure scenarios to find weaknesses before real disasters do.

### Dropbox's simulated production load
Dropbox engineers often add artificial load to production systems to trigger limit-related issues sooner. When errors appear, they switch off the simulated load and investigate with ample time — far less stressful than firefighting the same problem under real traffic they cannot turn off.
**Illustrates:** Deliberately triggering failures on your own schedule beats reacting to them on theirs.
