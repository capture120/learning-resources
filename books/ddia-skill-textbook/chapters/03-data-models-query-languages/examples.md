# Chapter 3: Data Models and Query Languages — Examples

All examples below are from the chapter, retold in plain language.

## The impedance mismatch analogy (electronics)

The term "impedance mismatch" for the object-relational gap is borrowed from circuits: every circuit has an input and output impedance, and power transfer between two connected circuits is maximized when the impedances match. A mismatch causes signal reflections and other trouble. By analogy, object-oriented application code and relational tables are two "circuits" whose shapes don't match, requiring an awkward translation layer between them.

**Demonstrates:** why ORM frameworks exist — the object and relational models genuinely have different shapes.

## The N+1 query problem

You want to display a page of user comments. One query fetches N comments, each carrying its author's ID. To show author names, handwritten SQL would join against the users table and return names alongside the comments in one query. An ORM, however, may issue a separate users-table lookup for each of the N comments — N+1 queries total, much slower than the single join. The fix is telling the ORM to fetch author data eagerly along with the comments.

**Demonstrates:** ORMs make it easy to accidentally write inefficient queries; know what queries your abstraction generates.

## A LinkedIn résumé: relational tables vs. one JSON document

A profile (the chapter uses Barack Obama's) has fields that appear once per user (first_name, last_name) plus one-to-many data: multiple positions, multiple education entries, contact info. Relationally, the one-to-many parts become separate tables (positions, education, contact_info), each with a foreign key to users; fetching a profile then needs multiple queries or a messy multiway join. As a single JSON document, the whole tree lives in one place: positions and education are arrays inside the document, so the fetch is one query with better locality, and the structure mirrors the application's object model. The one-to-many relationships form a tree, which JSON makes explicit.

A caveat in the text: one-to-many here is really "one-to-few" (a résumé has a handful of positions). For genuinely large collections — thousands of comments on a celebrity's post — embedding everything in one document becomes unwieldy and the relational split is better.

**Demonstrates:** tree-shaped, self-contained data fits the document model; the relational technique of shredding it into tables adds complexity.

## Storing a region as an ID vs. a string

The résumé stores `region_id: "us:91"` instead of the text "Washington, DC, United States". Standardized region IDs give: consistent spelling across profiles; no ambiguity between identically named places (Washington the city vs. the state); one place to update if a name changes; localization (display the region in the viewer's language); and better search (the regions list can record that Washington, DC is on the East Coast, so an "East Coast" search matches — the raw string can't support that). The ID itself never has to change because it carries no human meaning. The cost: every display requires a join (or extra lookup) to resolve the ID back into text.

**Demonstrates:** normalization — store human-meaningful data once and reference it by ID; the trade is extra read-time lookups for update safety and consistency.

## Organization logos: when denormalized strings bite

In the same résumé, organization and school names are stored as plain strings — denormalized; many people worked at the same company with no shared ID. Now suppose you want to show each school's or employer's logo. Denormalized, you'd copy the logo URL into every individual profile; changing the logo later means finding and updating every copy. Normalized, you'd create an organization entity holding the name, logo URL, and other attributes once, and have résumés reference its ID; updating the logo is then a single write. This change also converts the data into a many-to-many relationship (a person worked at several organizations; an organization has many past employees), which in a relational model becomes an associative join table (positions rows linking user_id to org_id) and in a document model becomes ID references between documents.

**Demonstrates:** the normalization decision recurs per field; adding requirements (a logo) can flip the right answer, and many-to-many data resists self-contained documents.

## X (Twitter) home timelines: selective denormalization at scale

Continuing Chapter 2's case study: joining posts against follows at read time was too expensive, so timelines are precomputed (materialized) — a denormalized cache of that join, kept consistent by fanning out each new post into followers' timelines. But the materialized timeline does NOT store post text. Each entry holds only the post ID, sender ID, and a little repost/reply metadata — effectively a precomputed result of "select followees' post IDs and sender IDs, newest first, LIMIT 1000." At read time the service still performs two application-level joins: resolve post IDs to fetch content plus like/reply counts, and resolve sender IDs to fetch username and profile photo — a process called "hydrating" the IDs.

Why leave that data normalized? It changes fast: a popular post's like count changes many times per second, and users change usernames and photos. Denormalizing it into the materialized timelines would not make sense — the timeline should show the latest values when viewed — and would significantly increase storage cost. Hydration scales fine: it parallelizes well and costs the same regardless of follower/followee counts.

**Demonstrates:** the scalable design mixes both approaches — denormalize the slow-changing join structure, keep fast-changing data normalized; read-time joins are not inherently a scalability problem.

## Star schema for a grocery retailer

A data warehouse centers on a fact table, fact_sales, where each row is one event: a customer's purchase of one product (for web analytics it would be a page view or click). Fact columns mix attributes (sale price, supplier cost — enabling profit-margin calculation) with foreign keys into dimension tables describing the who/what/where/when/how/why: dim_product (SKU, description, brand, category, fat content, package size), dim_store (services offered, in-store bakery, square footage, opening date, distance to highway), even dim_date (so holidays can be distinguished from regular days). Drawn out, the fact table sits in the middle with dimensions radiating like a star. Facts are kept at individual-event granularity for analysis flexibility, so fact tables grow to petabytes and are often over a hundred columns wide. A multi-item purchase isn't modeled explicitly: each product bought becomes its own fact row sharing the same customer, store, and timestamp. Variants: the snowflake schema normalizes dimensions further into subdimensions (brand and category as their own tables) — more normalized but harder for analysts; one big table (OBT) goes the other way, folding dimensions into the fact table itself — more storage, sometimes faster queries.

**Demonstrates:** analytics-side data modeling conventions, and why heavy denormalization is acceptable when data is an immutable historical log.

## Splitting full name into first/last: schema-on-read vs. schema-on-write

An application stored each user's full name in one field and now wants separate first and last names. Document-database route: just start writing new documents with first_name, and add read-side code like "if the document has name but no first_name, derive first_name by splitting name" — but every reader must handle old formats forever. Relational route: run a migration — `ALTER TABLE users ADD COLUMN first_name text DEFAULT NULL` (fast even on big tables), then `UPDATE users SET first_name = split_part(name, ' ', 1)` (PostgreSQL; `substring_index` in MySQL). The UPDATE rewrites every row and is slow on large tables; column type changes typically copy the whole table. Online schema-change tools help but large migrations stay operationally hard. A hybrid avoids the pain: add the column with NULL default (fast) and backfill at read time, exactly as the document approach does.

**Demonstrates:** the practical difference between schema-on-read and schema-on-write when data formats evolve.

## Shark sightings: the same aggregation in SQL and MongoDB

A marine biologist logs an observation record each time they sight ocean animals, and wants monthly shark-sighting totals. PostgreSQL: SELECT with `date_trunc('month', observation_timestamp)`, a WHERE filter on family = 'Sharks', and GROUP BY month with sum(num_animals). MongoDB aggregation pipeline: `$match` on family, then `$group` keyed by `$year`/`$month` of the timestamp with `$sum` of numAnimals. The pipeline language is similar in expressiveness to a subset of SQL, but uses JSON syntax rather than SQL's English-sentence style — perhaps a matter of taste.

**Demonstrates:** document databases can offer declarative aggregation similar to a subset of SQL; the models have converged.

## Lucy and Alain: the running graph example

Lucy was born in Idaho; Alain was born in Saint-Lô, France; they are married and live in London. People and locations are vertices, relationships (BORN_IN, LIVES_IN, MARRIED_TO, WITHIN) are edges. The graph easily represents things a fixed relational schema would struggle with: different regional hierarchies per country (France has départements and régions; the US has counties and states), historical quirks like a country within a country, and varying granularity (Lucy's residence is a city; her birthplace only a state). The chapter also notes you could extend the graph with allergen vertices, person-to-allergen allergy edges, and food-to-allergen content edges, then query what each person can safely eat — graphs extend gracefully as the application grows.

**Demonstrates:** graphs handle irregular, evolving, highly connected data that rigid schemas cannot.

## "Who emigrated from the US to Europe?" in four languages

The same query — find people with a BORN_IN edge leading (through any number of WITHIN edges) to the United States and a LIVES_IN edge leading to Europe — is shown in four languages:

- **Cypher:** 4 lines. `MATCH (person) -[:BORN_IN]-> () -[:WITHIN*0..]-> (:Location {name:'United States'})`, similarly for LIVES_IN/Europe, `RETURN person.name`. `:WITHIN*0..` means "follow WITHIN zero or more times," like a regex `*`. The optimizer may scan all people, or start from the indexed location vertices and traverse backward.
- **SQL with recursive CTEs:** 31 lines. WITH RECURSIVE builds in_usa and in_europe vertex sets by repeatedly following incoming `within` edges, then derives born_in_usa and lives_in_europe sets, then joins them. Needed because each traversed edge is a join and the number of joins isn't known in advance. Still ignores complications like cycle handling and traversal order.
- **SPARQL:** equally concise as Cypher: `?person :bornIn / :within* / :name "United States".` SPARQL predates Cypher and inspired its pattern matching; RDF's uniform predicates let one syntax match both properties and edges.
- **Datalog:** builds the answer rule by rule. Rule 1 and recursive Rule 2 define within_recursive (every place each location is transitively within); Rule 3 defines migrated(person, bornIn, livingIn); Rule 4 instantiates it with "United States" and "Europe". The chapter walks the derivation: Idaho is in the US, the US is in North America, so within_recursive eventually contains (Idaho-ID, "North America"), etc. Rules compose like functions and can recurse.

**Demonstrates:** variable-length graph traversal is the killer feature; the right model and language shrink the query by roughly 8x versus emulating a graph in SQL.

## Facebook's single graph and search-engine knowledge graphs

Graphs need not be homogeneous. Facebook keeps one graph whose vertices are people, locations, events, check-ins, and comments, with edges for friendships, which check-in happened where, who commented on what, and who attended which event. Search engines build knowledge graphs of entities (organizations, people, places) extracted from crawled web text, plus structured sources like Wikidata, to answer entity queries.

**Demonstrates:** a graph can store completely different object types uniformly in one database.

## Turtle triples and RDF for the same location data

The Idaho/USA/North America fragment is rewritten as triples: `_:idaho :within _:usa`, `_:usa :name "United States"`, etc. Names like `_:idaho` mean nothing outside the file — they exist only so different triples can refer to the same vertex (much like the symbolic names in a Cypher CREATE statement, which are used to wire up edges within the query but never stored). When the object is a vertex the predicate acts as an edge; when it's a literal the predicate acts as a property. Turtle's semicolon syntax compacts multiple statements about one subject. The same data in RDF/XML is far more verbose; tools like Apache Jena convert between encodings. RDF makes subjects/predicates/objects URIs so independently published datasets can combine without word-meaning collisions ("within" in your namespace vs. someone else's); the URIs are namespaces and need not resolve. Real systems often extend triples: AWS Neptune uses quads (adds a graph ID), Datomic 5-tuples (adds transaction ID and a deletion flag).

**Demonstrates:** the triple-store model expresses the same graphs as property graphs with different vocabulary, designed for internet-wide data merging.

## A reorderable to-do list

An issue tracker or to-do app lets users drag and drop tasks into a custom order. In a document model, the items (or their IDs) simply live in a JSON array whose order is the user's order. Relational databases have no standard representation for reorderable lists; workarounds include an integer sort column (inserting in the middle forces renumbering), a linked list of IDs, or fractional indexing.

**Demonstrates:** user-controlled ordering is a concrete case where the document model is naturally better.

## GraphQL for a group chat app (Discord/Slack style)

A client queries for all channels the user can access, each with its name and 50 most recent messages; for each message, the timestamp, content, and sender's name and avatar URL; and if it's a reply, the replied-to message's content and sender name (to render as context above the reply). The JSON response mirrors the query exactly — no more, no less — so the server never needs to know what the UI displays; if the UI later wants the replied-to sender's avatar, the client just adds imageUrl to the query, with zero server changes. The response deliberately duplicates data (a sender's name repeats in every message they sent; replyTo embeds the original content rather than an ID, which would force a second round-trip if the original fell outside the latest 50). The server can store everything normalized — message rows with sender ID and reply-to ID — and join at query time, but clients can request only the joins declared in the GraphQL schema, and no recursion or arbitrary search, because queries come from untrusted devices and must not enable expensive denial-of-service queries.

**Demonstrates:** GraphQL trades query power for client flexibility and safety, and accepts response duplication to simplify UI rendering.

## Conference management with event sourcing

A conference system is a messy domain: individuals register and pay by card; companies bulk-order seats by invoice and assign them to people later; seats are reserved for speakers, sponsors, and volunteers; reservations get canceled; the organizer changes capacity by switching rooms. Even "how many seats are left?" becomes a hard query. With event sourcing, every state change is first appended as an immutable event (registrations opened, seats booked, booking canceled). Materialized views are then derived from the log: one collecting each booking's status, one computing dashboard charts for the organizer, one generating badge-printer files. A user request is a command; only after validation (enough seats were available) does it become an event in the log, so views must accept every event. Events are named in the past tense because they record facts: even a canceled booking really existed — the cancellation is a separate, later event. Chained behavior is natural: a cancellation event can trigger offering the seat to the next waitlisted person. The chapter's intent contrast: "the booking was canceled" is far easier to understand than "the active column on row 4001 of bookings was set to false, three seat_assignments rows were deleted, and a refund row was inserted into payments" — the same row modifications may still happen in a materialized view, but the event makes the reason for them clear.

**Demonstrates:** event sourcing plus CQRS — one write-optimized source of truth, many read-optimized derived views — for complex business domains.

## The currency-conversion determinism trap

Suppose an event records a price in one currency, and a materialized view must show it in another. If the view-maintenance code fetches the current exchange rate when processing the event, rebuilding the view on a different date produces different numbers — replays are no longer reproducible. The fix: embed the exchange rate in the event itself, or query a historical-rate service keyed by the event's timestamp so the same timestamp always returns the same rate.

**Demonstrates:** event processing must be deterministic for the rebuild-from-log guarantee to hold; external lookups break it.

## GDPR deletion vs. immutable logs (crypto-shredding)

Users can demand deletion of their personal data, but event-sourced logs are immutable. If logs are per-user, delete the user's whole log; that fails when one log mixes many users' events. Alternatives: store personal data outside the events, or encrypt each user's data with a per-user key and delete the key on request (crypto-shredding). Both make later recomputation of derived state harder. Relatedly, replaying events must not repeat externally visible side effects — rebuilding a view shouldn't resend confirmation emails.

**Demonstrates:** the failure modes of immutability — privacy law and side effects need explicit design.

## Movie ratings: pivoting a table into a sparse matrix

A relational table holds user ratings of movies (1–5). For machine learning — say, movie recommendations — a DataFrame transforms it into a matrix: one row per user, one column per movie, ratings as cell values (like a spreadsheet pivot table). The matrix is sparse (most user–movie pairs unrated) and may have thousands of columns, far too many for a relational table, but fine for DataFrames and sparse-array libraries like NumPy. Nonnumeric data gets numeric encodings: dates scaled to floats; categorical fields like genre via one-hot encoding (a 0/1 column per genre, which also handles multi-genre movies). Once numeric, the data supports the linear algebra underlying many ML algorithms.

**Demonstrates:** DataFrames bridge relational data and the matrix representations ML expects, going beyond what relational operators offer.

## Codd's nonsimple domains

Codd's original 1970 relational-model paper already allowed a row value to be not just a primitive but a nested relation — an arbitrarily nested tree inside a table cell. This anticipates the JSON and XML support added to SQL over 30 years later.

**Demonstrates:** the relational and document models were never strictly opposed; convergence was latent from the start.
