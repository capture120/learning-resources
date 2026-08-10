# Chapter 25: Architectural Boundaries — Examples

### The BusinessRules / DatabaseInterface / DatabaseAccess diagram

The chapter's central illustration is a class diagram: `BusinessRules` use a `DatabaseInterface` to load and save data; `DatabaseAccess` implements that interface and drives the actual `Database`. The names are symbolic — a real application would have many business-rule classes, many interface classes, and many access implementations, all following roughly the same pattern.

The boundary line is drawn across the inheritance/implements relationship, just below `DatabaseInterface`. The key observation is the two arrows leaving `DatabaseAccess`: both point away from it, meaning no other class knows `DatabaseAccess` exists. "That's the line."

Pulling back to component level, the arrow between components points from `Database` to `BusinessRules`. The Database knows about the BusinessRules (its translation code converts business-rule calls into the database's query language), but the BusinessRules know nothing of the Database. So the interface classes live in the BusinessRules component and the access classes live in the Database component. Lesson: with the arrow pointing this way, the database could be Oracle, MySQL, Couch, Datomic, or flat files — the business rules don't care, so the database choice can be deferred while business rules are written and tested.

### The plug-in diagram (GUI and Database as plug-ins)

A second diagram shows two boundaries separating the Database and the GUI from the BusinessRules, with all arrows pointing from these lower-level components toward the high-level BusinessRules component. The GUI and DB are plug-ins to the business rules. Because the UI is a plug-in, it could be web based, client/server, SOA based, or console based; because the database is a plug-in, it could be any SQL database, a NoSQL database, or a file-system-based store.

The chapter is honest about the cost: if the first deployment is web based, writing a client/server UI plug-in could be challenging, and some communication between BusinessRules and the new UI would likely need rework. The plug-in structure doesn't make the change trivial — it makes it practical.

### Case Study: FitNesse and "Download and Go"

The chapter's main war story. In 2001, the author and his son Micah began FitNesse, a Java wiki wrapping Ward Cunningham's FIT acceptance-testing tool. The author imposed a rule he called **Download and Go**: users should never have to download more than one jar file. That rule drove many of their decisions.

First consequence: they wrote their own bare-bones web server rather than use an existing one. It sounds absurd, but a minimal web server is simple to write, and it let them postpone any web-framework decision until much later (years later, Velocity was slipped in).

Second consequence: they deliberately avoided deciding on a database. MySQL was in the back of their minds, but they made the decision irrelevant by putting an interface, `WikiPage`, between all data accesses and the data repository. The implementations evolved in stages, each deferring the decision further:

1. **MockWikiPage** — data-access methods stubbed out. For three months they worked purely on translating wiki text to HTML, which needed no storage.
2. **InMemoryPage** — a `WikiPage` derivative managing a hash table of pages in RAM. This carried them for a full year; the entire first version of FitNesse worked this way (pages, links, formatting, running FIT tests) — it just couldn't save anything.
3. **FileSystemWikiPage** — when persistence became necessary, they decided MySQL wasn't needed in the short term because it was really easy to write the hash tables out to flat files. Three months later they concluded flat files were good enough and abandoned MySQL altogether — they "deferred that decision into nonexistence."
4. **MySqlWikiPage** — the coda: a customer who needed MySQL was shown the WikiPage architecture and returned a day later with the whole system working in MySQL, simply by writing one derivative. FitNesse bundled that option for a while, but nobody used it (eventually not even him), so it was dropped.

Lessons the story anchors: the boundary let them defer the database choice for well over a year, try the file-system option, change direction when they saw a better solution — and yet it never prevented or impeded the original MySQL direction when someone wanted it. And for 18 months without a running database they had no schema, query, server, password, or connection-time issues, and all tests ran fast. Drawing boundary lines that delay and defer decisions saved enormous manpower and headaches — which is exactly what a good architecture should do.
