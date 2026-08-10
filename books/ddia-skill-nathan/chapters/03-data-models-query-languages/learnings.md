# Chapter 3: Data Models and Query Languages — Core Learnings

**Central thesis:** The data model you choose shapes how you write software and how you think about the problem. (The chapter's epigraph is Wittgenstein: "The limits of my language mean the limits of my world.") Each model (relational, document, graph, event log, DataFrame) makes some data and queries natural and others awkward; the deciding factor is the shape of your data's relationships — one-to-many favors documents, many-to-many favors relational or graph — and whether you read data in the same form you write it. Models can emulate each other (graphs in SQL, documents in relational JSON columns), but emulation is usually clumsy, so pick the model that fits, or use a hybrid database that supports several.

## Layered data models

Applications stack data models: application objects → general-purpose model (JSON / tables / graph) → bytes on disk → hardware. Each layer hides the complexity below it behind a clean abstraction — which is what lets different groups of people (database-vendor engineers vs. application developers) work together effectively. Complex applications may add more intermediate layers (APIs built on APIs). This chapter is about the second layer; Chapter 4 covers the storage layer beneath it.

## Declarative query languages

SQL, Cypher, SPARQL, and Datalog are declarative: you specify what data you want (conditions, transformations), not how to get it. Benefits:

- More concise than hand-written algorithms.
- Hides query-engine internals, so the database can change execution strategy (indexes, join algorithms, ordering) and add optimizations like parallel execution across cores/machines without query changes.

GraphQL and MongoDB's aggregation pipeline are also query languages but with different design goals (see below). DataFrames are the notable non-declarative exception: imperative step-by-step transformation.

## Relational vs. document models

### Historical context (why it matters)

The relational model (Codd, 1970) organizes data into relations (tables), each an **unordered** collection of tuples (rows). It began as a theoretical proposal many doubted could be implemented efficiently, yet by the mid-1980s RDBMSs and SQL were the default for regularly structured data. It outlasted every challenger: network and hierarchical models (1970s–80s), object databases (late 80s–90s; not to be confused with object storage, the cloud service for large files), XML databases (2000s). NoSQL (2010s) — not one technology but a loose set of ideas around new data models, schema flexibility, scalability, and open source licensing — didn't replace it either, nor did "NewSQL" (NoSQL-style scalability with relational data models and transactional guarantees). Both terms faded as their ideas were absorbed — relational databases added JSON types, query operators, and indexing of properties inside documents; document databases (originally popularized by MongoDB and Couchbase; also RethinkDB) added joins, secondary indexes, and declarative query languages. Expect convergence, not replacement. Convergence is good news: relational–document hybrids are a powerful combination, because many document databases need relational-style references to other documents, and many relational databases have sections where schema flexibility helps. Codd's original paper even allowed nested relations ("nonsimple domains"), essentially JSON-in-rows 30 years early.

### Object-relational mismatch and ORMs

The "impedance mismatch": application objects vs. tables/rows/columns require a translation layer. ORMs (ActiveRecord, Hibernate) reduce boilerplate but:

- Can't fully hide the relational model; you must still understand both representations.
- The relational schema still matters for analytics consumers, even if the app only sees objects.
- Often relational-OLTP-only; poor support for search engines, graph DBs, NoSQL.
- Auto-generated schemas can be awkward and inefficient; customizing them can negate the ORM's value.
- **N+1 query problem:** fetching N comments then issuing one author lookup per comment = N+1 queries instead of one join. Configure the ORM to fetch related data eagerly when you know you need it.

ORM upsides: less boilerplate for the inevitable translation, query-result caching, schema-migration management. Caveat: the ORM helps with simple, repetitive cases; complicated queries may still need to be written outside it.

### One-to-many: where documents win

Tree-shaped data (a résumé with positions, education, contact info) maps naturally to one JSON document. The relational alternative — "shredding" into multiple tables with foreign keys — needs multiway joins or multiple queries to reassemble, and produces cumbersome schemas and code.

Caveat: one-to-many is often really "one-to-few". If the "many" side is genuinely large (thousands of comments on a celebrity post), embedding in one document is unwieldy; use separate tables/documents instead.

### Normalization vs. denormalization

- **Normalized:** human-meaningful data stored once; everything else references it by ID. IDs never need to change because they mean nothing to humans. Reads require joins.
- **Denormalized:** human-meaningful data duplicated into each record. Reads are self-contained; updates must find and fix every copy — more code, more writes, more disk, and risk of inconsistency if copies diverge.

Rule of thumb: **normalized = faster writes, slower reads; denormalized = faster reads, costlier writes.** Treat denormalized copies as derived data — you must own the process that keeps them in sync. Watch for crashes mid-update: without multi-document atomic transactions (Ch. 8) or stream processing (Ch. 12), partial updates leave inconsistent state.

Decision guidance:

- OLTP, small-to-moderate scale: prefer normalized — joins are affordable and you avoid consistency bookkeeping.
- Analytics: denormalize freely — data is historical and rarely updated, so consistency/write costs don't bite.
- Very large scale: join cost can become the problem; selectively denormalize. The right answer is usually a mix (see the X/Twitter timeline example): denormalize slow-changing data, keep fast-changing data (like counters, usernames) normalized and "hydrate" IDs at read time. Joins-at-read are not inherently unscalable — ID hydration parallelizes well.
- Decide per field based on (a) how often the value changes, (b) read vs. write cost, including outliers (e.g., users with very many follows or followers).

Why prefer IDs over free-text strings (region example): consistent spelling, no name ambiguity, single place to update, localization, and richer search (the regions list can encode facts like "DC is on the East Coast").

Document databases can store data either way, but are associated with denormalization for two reasons: the JSON model makes it easy to tack on denormalized fields, and weak join support in many document DBs makes normalization inconvenient. Normalization and denormalization aren't inherently good or bad — just trade-offs in read/write performance and implementation effort.

### Many-to-one and many-to-many

Many-to-one: many records reference one shared entity (many people live in the same region; each person lives in one region at a time). Many-to-many arises when both sides multiply (a person worked at several organizations; each organization has many past employees). Neither fits in one self-contained document; both lend themselves to normalization. Options:

- Relational: associative/join table (e.g., positions linking user_id ↔ org_id), with indexes on both columns to query in both directions.
- Document: store ID references to other documents; index fields inside documents (many document DBs and relational DBs with JSON support can do this). Storing the relationship on both sides is denormalized and can drift inconsistent.
- Some document DBs lack joins entirely, forcing application-level joins (fetch document, then resolve its IDs with more queries). MongoDB has `$lookup` in its aggregation pipeline.

### Star and snowflake schemas (analytics)

Data warehouses are usually relational; ETL processes translate data from operational systems into the chosen schema. Widely used conventions — star schema, snowflake schema, dimensional modeling, one big table — are optimized for business analysts:

- **Star schema:** central fact table (one row per event, e.g., one product purchase) with attribute columns plus foreign keys into dimension tables (who/what/where/when/how/why). Even dates get a dimension table so you can attach facts like public holidays.
- **Snowflake schema:** dimensions further normalized into subdimensions (brand, category tables). More normalized, but star is usually preferred — simpler for analysts.
- **One big table (OBT):** fold dimensions into denormalized fact-table columns (precomputed join). More storage, sometimes faster queries.

A star/snowflake schema consists almost entirely of many-to-one relationships (many sales → one product/store; fact → dimension, dimension → subdimension); other relationship types are usually denormalized away to simplify queries. Facts are captured at maximum granularity (individual events) for analysis flexibility; fact tables reach petabytes. Tables are wide: fact tables often have 100+ columns, sometimes several hundred; dimension tables are also wide, holding all metadata potentially relevant for analysis. Multi-item purchases are denormalized into one fact row per item sharing customer/store/timestamp. Denormalization is unproblematic here because the data is an immutable historical log.

### When to use which model

Use the **document model** when:

- Data is a self-contained tree of one-to-many relationships, typically loaded whole.
- You need user-defined ordering of items (to-do lists, drag-and-drop): a JSON array stores order naturally. Relational has no standard answer (rows are an unordered collection by definition) — tricks include integer sort columns (renumbering on insert), linked lists of IDs, or fractional indexing.
- Records are heterogeneous: many object types impractical to give each its own table, or structure dictated by external systems that change without notice.

Use the **relational model** when:

- You have many-to-one/many-to-many relationships and need real joins.
- You must reference nested items directly. In a document you can only say "the 2nd item in user 251's positions list"; relational rows have their own IDs.

**Schema-on-read vs. schema-on-write:**

- Document DBs are not "schemaless" — the schema is implicit, enforced by reading code, not the database. Most document DBs and relational JSON columns enforce no schema at all (arbitrary keys/values can be added; readers get no guarantees); XML support in relational DBs usually offers optional schema validation. Schema-on-read ≈ dynamic typing; schema-on-write ≈ static typing. No clear winner in general, but when all records share the same structure, an explicit schema is a useful mechanism for documenting and enforcing it.
- Format changes: document DBs just start writing the new shape and handle old documents in read code — but every reader forever must handle all historical formats. Relational DBs migrate: `ALTER TABLE ADD COLUMN ... DEFAULT NULL` is fast even on large tables, but `UPDATE` rewriting every row is slow, and type changes typically copy the whole table. Online schema-change tools exist (pt-online-schema-change, gh-ost, pg-osc, pgroll) but big migrations stay operationally hard. Hybrid trick: add a NULL-default column fast, backfill lazily at read time.

**Data locality:**

- A document is stored as one contiguous string (JSON/XML/BSON). Reading the whole document is fast (one lookup, no joins/seeks). The advantage vanishes if you need only a small part — the DB loads the whole document anyway — and updates usually rewrite the entire document. Therefore: **keep documents small; avoid frequent small updates to large documents.**
- Locality isn't document-exclusive: Spanner interleaves child table rows within parents; Oracle has multi-table index cluster tables; the Bigtable wide-column model (HBase, Accumulo) groups related data via column families.

**Query languages:** relational ≈ SQL everywhere; document DBs vary from key-only access to rich languages. MongoDB's aggregation pipeline matches a subset of SQL's expressiveness with JSON syntax (`$match`, `$group`, `$lookup`). XML has XQuery/XPath (designed for complex queries, including joins across multiple documents); JSON has JSON Pointer/JSONPath as the equivalent.

## Graph-like data models

When many-to-many relationships dominate and connections are complex, model data as a graph: vertices (nodes/entities) and edges (relationships). Examples: social graphs, the web graph, road networks — with classic algorithms (shortest path, PageRank).

Graphs aren't only for homogeneous data: a single graph can hold many vertex/edge types (Facebook: people, locations, events, check-ins, comments in one graph; search-engine knowledge graphs).

Representations: adjacency list (good for traversals) vs. adjacency matrix (good for ML; see DataFrames).

### Property graph model

(Neo4j, Memgraph, KùzuDB, Amazon Neptune.) Each vertex: unique ID, label (type), in/out edge sets, key-value properties. Each edge: unique ID, tail (start) vertex, head (end) vertex, label, properties. Key characteristics:

- No schema restricts which vertices can connect — any vertex to any vertex.
- Efficient traversal both forward and backward (index both tail_vertex and head_vertex if emulating in SQL: two tables, vertices + edges, properties as jsonb). Indexes on labels and properties let you find specific vertices/edges efficiently.
- Multiple relationship types in one structure ⇒ great **evolvability**: new features = new vertex/edge types, no migration.
- Handles irregular structure that defeats fixed schemas: different regional hierarchies per country, varying data granularity.
- Limit: an edge connects exactly two vertices. A relational join-table row can express 3-way+ relationships; in a graph you need an extra vertex per such row, or a hypergraph.

### Cypher

Declarative property-graph language (Neo4j origin, openCypher standard; also supported by Memgraph, KùzuDB, Amazon Neptune, and Apache AGE with storage in PostgreSQL; basis of the 2024 ISO **GQL** standard, which is not yet widely adopted). Pattern syntax: `(person) -[:BORN_IN]-> ()`. Variable-length traversal: `-[:WITHIN*0..]->` = "follow WITHIN zero or more times" (like regex `*`). The optimizer picks execution strategy (scan people vs. start from indexed locations and work backward). Trivia: named after the character in The Matrix, not cryptographic ciphers.

### Graph queries in SQL

Possible but painful. Each traversed edge is a join, and in graph queries the number of joins isn't known in advance — a LIVES_IN edge may point to a street, city, district, region, or state, so the target vertex may be any number of WITHIN hops up the hierarchy (in relational queries you normally know the needed joins upfront). SQL expresses variable-length traversal with recursive CTEs (`WITH RECURSIVE`): a 4-line Cypher query became 31 lines of SQL, before even handling cycles or traversal order. **The right data model + query language can be ~an order of magnitude less code.** Oracle has separate "hierarchical" query syntax. Other graph query languages exist beyond those covered here: Gremlin, TigerGraph's GSQL, PGQL.

### Triple stores, RDF, SPARQL

Triple store model ≈ property graph with different vocabulary (implemented by Datomic, AllegroGraph, Blazegraph; some databases, like Amazon Neptune, support both models). Everything is (subject, predicate, object):

- Object = primitive value ⇒ predicate/object act as a property key/value on the subject vertex.
- Object = another vertex ⇒ predicate is an edge label, subject = tail, object = head.

In practice many "triple" stores use quads or 5-tuples (Neptune adds graph ID; Datomic adds transaction ID + deletion flag). Turtle is a readable encoding; RDF is the underlying data model (also encodable as XML). RDF uses URIs as namespaces for subjects/predicates/objects so independently published datasets can merge without name collisions; the URIs need not resolve.

SPARQL: query language for RDF (recursive acronym: SPARQL Protocol and RDF Query Language, pronounced "sparkle"), predates Cypher (which borrowed its pattern matching). `?person :bornIn / :within* / :name "United States"` — same expressiveness, similarly concise. One syntax for both properties and edges since RDF doesn't distinguish them. Supported by Amazon Neptune, AllegroGraph, Blazegraph, OpenLink Virtuoso, Apache Jena, and other triple stores. The Semantic Web vision failed, but its legacy (JSON-LD, knowledge graphs, Wikidata, Schema.org, Open Graph link unfurling, biomedical ontologies) and triple stores remain useful.

### Datalog

1980s academic language; subset of Prolog; used by Datomic, LogicBlox, CozoDB, LinkedIn's LIquid. Relational, not graph, but excels at recursive queries. Facts = rows: `born_in(100, 3)`. Rules derive virtual tables (like SQL views) from facts; rules can reference and recurse into other rules, composing like functions. More verbose for simple one-shot queries, but the strongest of the bunch for complex, layered, recursive queries.

### GraphQL

Deliberately restrictive query language for OLTP, letting untrusted clients (mobile/web UIs) request exactly the JSON shape they need. Properties:

- Response mirrors query structure; clients add fields without server changes — fast UI iteration.
- **No recursion and no arbitrary search conditions**, by design: queries come from untrusted sources and must not enable denial-of-service via expensive queries. Only joins declared in the GraphQL schema are queryable.
- Accepts duplication in responses (sender name repeated per message) to simplify client rendering — a deliberate denormalize-on-read choice.
- Backend-agnostic: implementable over relational, document, or graph storage; the server can store normalized data and join at query time.
- Costs: tooling to translate queries into internal REST/gRPC calls; authorization, rate limiting, performance challenges.

## Event sourcing and CQRS

All previous models query data in the same form it's written. When no single representation serves all read patterns, split them:

- **Event sourcing:** the source of truth is an append-only log of immutable events (self-contained, timestamped, e.g., JSON; events can carry arbitrary properties). The framing question: how would you model data optimized purely for writing, with queries no concern? An event log is perhaps the simplest, fastest, most expressive answer. Never update or delete; later events supersede earlier ones. Name events in past tense ("seats were booked") — they record facts that happened.
- **CQRS (command query responsibility segregation):** derive read-optimized **materialized views** (a.k.a. projections / read models) from the write-optimized log. A user request is a *command*; once validated and executed it becomes a fact appended as an *event*. The log contains only valid events; view-building consumers may not reject events.

Both terms originated in the domain-driven design (DDD) community; the underlying idea is older (e.g., state machine replication), and ETL into a warehouse is the same derive-other-representations pattern.

Vs. a fact table: both are collections of past events, but fact-table rows share one column set and are unordered; event-sourced events have heterogeneous types and **order matters** (booking then cancellation can't be processed in reverse).

Advantages:

- Events capture intent ("booking canceled") vs. opaque row mutations across several tables.
- Views are reproducibly derived: delete and rebuild from the log with fixed code; bugs in view logic are fixable by recompute, and debuggable by replay.
- Multiple views per query pattern, any data model, denormalized freely, stored in the same database as the events or a different one, even memory-only if recomputable on restart.
- New views/features from existing history; new event types and properties added without touching old events; chain behaviors off events (cancellation → offer seat to waitlist).
- Mistakes are reversed by appending a compensating deletion event — fewer irreversible actions than direct UPDATE/DELETE.
- Built-in audit log (valuable in regulated industries).
- Higher write throughput from sequential appends; the log absorbs bursts while view-maintainers catch up at their own pace.

Downsides / gotchas:

- **Determinism with external data:** if processing an event needs an exchange rate, fetching the current rate makes replays nondeterministic. Embed the rate in the event, or query a historical rate keyed by the event's timestamp.
- **Immutability vs. GDPR deletion:** can't delete personal data from an immutable log. Per-user logs allow deleting the whole log, but that fails when one log mixes multiple users' events. Alternatives: store personal data outside events, or **crypto-shredding** (encrypt with a key you can later delete) — both make recomputing derived state harder.
- **Side effects on replay:** rebuilding a view must not resend confirmation emails etc.

Implementation: any database works; purpose-built options include EventStoreDB, MartenDB, Axon Framework; or Kafka as the log with stream processors maintaining views (Ch. 12). The one hard requirement: **all materialized views must process events in exactly the same log order** — hard in distributed systems (Ch. 10).

## DataFrames, matrices, and arrays

Analytics/science-only models (rare in OLTP). DataFrames (R, Pandas, Spark, ArcticDB, Dask): table-like, with relational-style bulk operations (filter, group/aggregate, join — called *merge*), but manipulated imperatively, step by step, matching data scientists' iterative "wrangling" workflow on private local copies. Used not only for ML data prep but also data exploration, statistical analysis, and visualization.

DataFrames go beyond relational: a common use is pivoting relational data into a matrix/multidimensional array for ML (e.g., user × movie ratings matrix). Such matrices can have thousands of columns and be sparse — fine for DataFrames/NumPy, a poor fit for relational tables. Nonnumeric data is converted: dates scaled to floats; categorical values via **one-hot encoding** (one 0/1 column per possible value; generalizes to multi-category items). Once numeric, linear algebra (the basis of much ML) applies.

Array databases (TileDB) specialize in large multidimensional numeric arrays: geospatial raster data, medical imaging, astronomy. DataFrames also serve financial time series (asset prices, trades).

## Models not covered in depth

- Genome sequence-similarity search (long fuzzy string matching) needs specialized software (GenBank).
- Double-entry accounting ledgers: representable relationally, but specialist DBs exist (TigerBeetle); blockchains are distributed ledgers with value transfer built in.
- Full-text search / information retrieval: effectively its own data model, usually alongside a database (Ch. 4 touches on search indexes and vector search).

## How this connects

- **Chapter 1:** systems of record vs. derived data frames denormalization and CQRS; the OLTP vs. analytics distinction drives normalize-vs-denormalize guidance.
- **Chapter 2:** the social-network timeline case study (normalized vs. materialized timelines) is the running denormalization example.
- **Chapter 4 (storage):** how these models map to bytes on disk; append-only logs are write-friendly; secondary indexes make bidirectional relationship queries efficient; full-text/vector search.
- **Chapter 5 (encodings/evolution):** problems with JSON as an encoding; explicit schemas and schema evolution; REST/gRPC behind GraphQL gateways.
- **Chapter 8 (transactions):** atomicity makes it easier to keep multi-copy denormalized updates consistent (not all databases offer atomicity across multiple documents).
- **Chapter 10 (distributed consistency):** guaranteeing identical event order across consumers is hard.
- **Chapters 11–12 (batch/stream processing):** DataFrames in Spark/Flink; Kafka + stream processors maintaining materialized views; consistency via stream processing.
