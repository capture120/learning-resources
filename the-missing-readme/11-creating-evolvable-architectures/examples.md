# Chapter 11 Examples: Creating Evolvable Architectures

### Ousterhout's definition of complexity
Stanford computer science professor John Ousterhout, in *A Philosophy of Software Design* (Yaknyam Press, 2018), defines complexity as "anything related to the structure of a system that makes it hard to understand and modify the system," and identifies two characteristics of complex systems: high dependency and high obscurity. The chapter adopts this framework and adds a third characteristic, high inertia — software's tendency to stay in use — arguing that since complexity's cost accrues over time, high-inertia, high-change systems should be simplified while low-inertia or low-change systems can be left complex (as long as you discard them or leave them alone). **Lesson:** Complexity is structural difficulty in understanding and modifying a system, and simplification effort should target code that will live long and change often.

### KISS and the US Navy
The "keep it simple, stupid" mnemonic is credited to the US Navy's penchant for acronyms and tough love. It's offered as the antidote to the two tactics engineers reach for when facing unknown future requirements — guessing what they'll need, or building abstractions as an escape hatch — both of which lead to complexity. **Lesson:** Build with simplicity in mind; simple code lets you add complexity later, when the need is clear and the change unavoidable.

### The premature optimization that never gets removed
In the classic scenario, a developer sees code that could be made faster or more scalable and adds complex logic or architectural layers — caches, sharded databases, queues — before the code has shipped or anyone has used it. After shipping, the developer discovers the optimization wasn't needed, but removing it never happens, so the complexity accrues permanently. The cache illustrates the hidden cost of such machinery: it's fast, but it can become inconsistent with the underlying data. **Lesson:** Most performance and scalability improvements carry a high complexity cost; don't pay it before need is proven, because unneeded optimizations are rarely removed.

### The IDistributedQueue wrapper dilemma
A generic queue interface looks innocently simple:

```java
interface IDistributedQueue {
  void send(String queue, Object message);
  Object receive(String queue);
}
```

You just send and receive messages — until real implementations diverge: Apache Kafka supports keys *and* values for a message, while Amazon's Simple Queue Service supports message ACKing. The designer now faces a losing choice: make the interface the union of all features (no single implementation works for all methods) or the intersection (too limited to be useful). The better move is to use an implementation directly and refactor later if you decide you need to support another one. **Lesson:** Flexible wrapper abstractions box implementations into rigid boundaries; don't abstract over implementations you don't yet need.

### Muntzing
The chapter names a technique for keeping code flexible by having less of it: for everything you build, ask yourself what is absolutely necessary, and throw away the rest. This practice is called Muntzing, and it keeps software trim and adaptable. **Lesson:** The best way to keep code flexible is ruthless removal of everything nonessential.

### The cool-feature pitfall
Developers talk themselves into adding "cool" product features for predictable reasons: they mistake their own usage for what most users want, they think the feature will be easy to add, or they simply think it's neat. Each feature takes time to build and maintain, and you don't know whether it will actually be useful. Building a minimum viable product — the bare-minimum feature set needed to get user feedback — keeps you honest about what's really needed and lets you test an idea without a full-fledged implementation. **Lesson:** Resist neat-sounding features; let an MVP and user feedback decide what gets built.

### The file-format header shim
As a caveat to YAGNI, the chapter suggests placing interface shims where you suspect future needs without implementing them. Example: you're creating a new file format and suspect you'll need compression or encryption later. Provide a header that specifies the encoding, but implement only the uncompressed encoding. When compression is added in the future, the header makes it easy for new code to read older files. **Lesson:** When you genuinely suspect a future need, reserve a cheap extension point rather than building the feature now.

### pontoonWorples and the hidden ordering requirement
A common API surprise: method A must be called before method B, but the API lets you call B first, producing a runtime error. The fix shown is to have the method invoke its prerequisite submethod itself:

```
pontoonWorples() {
  if (!flubberized) {
    flubberize()
  }
  // ...
}
```

Alternatives: combine the methods into one, use the builder pattern, or use the type system — have pontoonWorples operate only on FlubberizedWorples rather than all Worples. If nothing else, rename the method pontoonFlubberizedWorples() so developers get a heads-up. The chapter adds a counterintuitive note: short method and variable names actually increase cognitive load; specific, longer names are more descriptive and easier to understand. **Lesson:** Eliminate ordering requirements structurally rather than documenting them, and use names that surface what the code needs.

### Hidden argument requirements
A method signature can imply a wider range of valid inputs than the method accepts: accepting an `int` while only allowing the numbers 1 through 10, or requiring that a certain value field be set inside a plain JSON object. Both force callers to rely on implicit knowledge. The remedies: use specific types that accurately capture constraints, describe expected JSON objects with JSON Schema, and at the least advertise the requirements in documentation when they can't be made programmatically visible. **Lesson:** Make argument constraints visible in the API itself, not in the caller's tribal knowledge.

### Rolling your own square root
Implementing your own square root method is surprising; using the language's built-in sqrt() is not. The same rule extends to development patterns: use idiomatic code style and standard patterns rather than exotic constructions. **Lesson:** Standard libraries and idioms eliminate surprise; custom versions of solved problems create obscurity.

### Layered tiers versus business domains
Developers often organize software in technical layers — frontend, middle tier, backend — with all UI code in one place and all object persistence in another. This works great within a single business domain but grows messy as businesses grow: separate teams form around each tier, so every business logic change slices through all tiers and coordination cost climbs; shared horizontal layers also make it too easy to mix business logic between domains, producing complex code. Grouping by business domain instead — accounting, billing, shipping — keeps changes focused, with high cohesion and low coupling shrinking the blast radius. The chapter points to Domain-Driven Design (DDD) as a full architectural approach for mapping business concepts to software, noting full-blown DDD is necessary only for the most complex situations but familiarity improves design decisions. **Lesson:** Encapsulate by business domain, not just technical tier, so changes stay localized as the business grows.

### The gRPC Greeter service in Protocol Buffers
The chapter's compatibility walkthrough starts with a simple gRPC Hello World API defined in Protocol Buffers: a Greeter service with one method, SayHello, that takes a HelloRequest (a string `name` and an int32 `favorite_number`) and returns a HelloReply (a string `message` with a fun note about the favorite number). The numbers next to each field are field ordinals — Protocol Buffers internally refers to fields by number rather than string. **Lesson:** A typed IDL service makes compatibility reasoning concrete: schemas, fields, and ordinals define exactly what client and server expect.

### Adding a required email field breaks old clients
Suppose the greeting should be sent over email, so a `required string email = 3;` field is added to HelloRequest. This is a backward-incompatible change: old clients don't supply an email, so when they invoke the new SayHello the field is missing and the service can't parse the request. Removing the `required` keyword and skipping emails when no address is supplied maintains backward compatibility. **Lesson:** Adding a required field breaks every existing client; new fields must be optional with handled absence.

### "Required is forever" — Kenton Varda on Protocol Buffers
Required fields proved such an evolvability problem that they were removed entirely from Protocol Buffers v3. Kenton Varda, the primary author of Protocol Buffers v2, said: "The 'required' keyword in Protocol Buffers turned out to be a horrible mistake." Many other systems still have required fields, so the chapter warns: be careful, and remember, "Required is forever." **Lesson:** Once a field is required, every future version must supply it; treat required-ness as a permanent, nearly irreversible commitment.

### The int32-to-sint32 type change that breaks both directions
To accommodate negative favorite numbers, the Protocol Buffer documentation advises using sint32 for fields likely to hold negative values, so `favorite_number` is changed from int32 to sint32. This change is both backward- and forward-incompatible: a client with the new HelloRequest encodes the field with a different serialization scheme than the old Greeter expects, so the old service fails to parse it — and the new Greeter fails to parse messages from old clients. **Lesson:** Changing a field's wire type silently breaks parsing in both directions even when the field name stays the same.

### Fixing the type change with a deprecated field
The sint32 change becomes forward compatible by adding a new field instead of mutating the old one. Protocol Buffers permits renaming fields as long as the field number stays the same, so the message becomes: `int32 _deprecated_favorite_number = 2; sint32 favorite_number = 3;`. The server handles both fields for as long as old clients are supported; once rolled out, the team monitors how often clients use the deprecated field and cleans it up after clients upgrade or a deprecation schedule expires. The chapter notes the same problems occur in "simple" REST services — whenever client and server content expectations diverge, errors crop up regardless of format — and that changes in message *semantics* can be incompatible too. **Lesson:** Evolve incompatible field changes by adding new fields and deprecating old ones on a monitored schedule, and remember semantics changes count as compatibility changes.

### Routing API versions through a gateway
API versions are usually managed with an API gateway or a service mesh: a v2 request is routed to a v2.X.X service instance, while a v3 request goes to a v3.X.X instance. Absent a gateway, clients invoke RPC calls directly against version-specific service hosts, or a single service instance runs multiple versions internally. The chapter also catalogs versioning pragmatics: semantic versioning is common but many companies use dates or other numeric schemes; version numbers can live in URI paths, query parameters, or HTTP Accept headers; defer to your company's standard or ask your manager and tech leads if there isn't one. **Lesson:** Versioning lets old clients keep working while the API moves on, but pick the mechanics pragmatically and follow existing company conventions.

### Shared versus isolated databases (Figures 11-1 and 11-2)
Two diagrams contrast data architectures. In the shared-database figure, App 1 and App 2 both point at a single database. In the isolated figure, App 1 and App 2 each have their own database and talk to each other via remote procedure calls. The shared arrangement breeds problems: apps depend directly on each other's data; you can't apply business logic to raw data before it's served or redirect queries during a migration because queries bypass your application; multiple writers make data semantics diverge; data can be mutated unexpectedly; one app's schema change impacts others; one app's load degrades everyone's performance; and security boundaries may be violated. Isolated databases have a single reader and writer, so schema changes concern only your own application and performance is governed by your own usage. **Lesson:** Give each application its own database; shared databases turn schemas into entrenched unofficial APIs and destroy team autonomy.

### Sharing a database while breaking up a monolith
The chapter allows occasional shared-database use: when breaking a monolith apart, sharing the database is a useful intermediate step before data has been migrated to a new isolated database. Similarly, because managing many databases has high operational cost, it can make sense early on to co-locate many databases on the same machines. But any shared databases should eventually get isolated and split up or replaced. **Lesson:** Shared databases are acceptable only as a temporary, transitional state with a plan to separate.

### Fred, Li, and Willa — the schemaless data hodgepodge
A data scientist faces three JSON records: one user has `"location": [37.33, -122.03]` (a coordinates array) and `"enabled": true` (a boolean); the next has no location at all and `"enabled": "false"` (a string); the third has `"location": "Boston, MA"` (a city string) and `"enabled": 0` (a number). The same logical fields appear as different types or go missing entirely, making the data nearly unusable — "a tough day" for whoever has to parse it. **Lesson:** Without explicit schemas, data degrades into an unintelligible mix of record types that developers, analysts, and data scientists struggle to read.

### The explicit users table
The schema-forward counterpart to the messy JSON is a SQL table that pins down every field and type — id as an auto-incrementing BIGINT primary key, name as a non-null VARCHAR(100), latitude and longitude as DECIMALs, and enabled as a non-null BOOLEAN. Explicit schemas like this sanity-check data as it's written, speed up parsing, help detect forward- and backward-incompatible changes, and tell data consumers exactly what to expect. The rigidity is by design: schemas force you to slow down and think through how existing data will be migrated and how downstream users will be affected. **Lesson:** Explicit schemas trade away easy mutation for data integrity, clarity, and deliberate evolution — data is written once and read many times, so optimize for reads.

### The JSON-in-a-"data"-field anti-pattern
It's tempting to be lazy and stuff a JSON string into a column called "data," or define a map of strings to hold arbitrary key-value pairs inside an otherwise schematized table. The chapter calls hiding schemaless data inside schematized data self-defeating: you get all the pain of explicit schemas and none of the gain. It then lists when schemaless is legitimately warranted: moving fast before you know what you need, rapid iteration, old data with little value, genuinely nonuniform records, or temporarily flipping data to an implicit schema as a trick to ease migration to a new explicit schema. **Lesson:** Don't smuggle schemaless blobs into schematized stores; go schemaless only deliberately and in the narrow cases where it earns its keep.

### Liquibase changesets for the users table
The users table goes into a versioned migration file: a changeset tagged `criccomini:create-users-table` holds the CREATE TABLE statement with a rollback of DROP TABLE users; a second changeset tagged `dryaboy:add-email` holds `ALTER TABLE users ADD email VARCHAR(255);` with a rollback of DROP COLUMN email. Running `liquibase update` against an empty database executes both CREATE and ALTER; against a database where the CREATE already ran, it executes only the ALTER. Tools like Liquibase track the current schema version in metadata tables inside the database itself — don't be surprised to find tables named DATABASECHANGELOG or DATABASECHANGELOGLOCK. Migrations are usually run from the command line by a DBA, though some teams automate execution through a commit hook or web UI. **Lesson:** Migration tools keep the full schema history in versioned files and apply only the changes a database still needs, making schema evolution predictable and reviewable.

### The rollback that can't bring data back
Most migration tools support rollbacks that undo a migration's changes, but rollbacks only go so far: rolling back a column deletion recreates the column, but it will not recreate the data that used to be stored in that column. Backing up a table prior to deletion is prudent. Because such changes are permanent and large-scale, organizations often assign specific subteams — DBAs, ops or SREs, or senior engineers who know the tools, performance implications, and application concerns — to ensure changes are done correctly; they're a great resource to learn from. **Lesson:** Rollbacks restore structure, not data; back up before destructive migrations and lean on the specialists who own these changes.

### gh-ost, pt-online-schema-change, Skeema, and Shift
Beyond basic migration tools (Liquibase, Flyway, Alembic, and the migration managers bundled with many ORMs), more sophisticated database operations tooling exists: GitHub's gh-ost and Percona's pt-online-schema-change help DBAs run large schema changes without impacting performance, while Skeema and Square's Shift provide versioning that lets you "diff" database schemas and automatically derive changes. The chapter's standing advice: use whatever tool your company already has, and once one is selected, route all changes through it — circumventing it negates the benefit because reality diverges from what's tracked. **Lesson:** Mature tooling exists for safe, online, diff-driven schema changes; adopt one tool and never go around it.

### The ETL pipeline and the dropped column (Figure 11-3)
A diagram shows the flow: an application database feeds an Extract step, a Transform step (looping on itself), and a Load step into a data warehouse — the ETL pipeline organizations build for analytics and reporting. These pipelines depend heavily on database schemas: simply dropping a column in a production database can cause the entire data pipeline to grind to a halt. Even when the drop doesn't break the pipeline, downstream users might rely on the field for reporting, machine learning models, or ad hoc queries. **Lesson:** Your production schema is not private — analytics pipelines and downstream consumers break when you change it carelessly.

### Change data capture and the welcome email
Change data capture (CDC) converts database inserts, updates, and deletes into messages for downstream consumers: an insert into a "members" table might trigger a message that an email service uses to send a welcome email to the new user. Those messages are an implicit API, so making backward-incompatible schema changes can break other services that consume them. The chapter's protection plan: validate schema changes before production, run compatibility checks as early as possible — ideally at code commit time by inspecting DDL statements — and execute the DDL plus integration tests in a preproduction integration environment to verify downstream systems survive. **Lesson:** Database changes ripple through event streams; check compatibility at commit time and in preproduction before touching production.

### Data products as database views
To protect internal schemas, a team can export a data product that explicitly decouples internal schemas from downstream users: the data product maps internal schemas to separate user-facing schemas, and the development team owns both the production database and the published data products. The data product might simply be a database view. This lets teams maintain compatibility with data consumers without freezing their internal database schemas. **Lesson:** Publish a deliberate external schema — even just a view — so internal schemas can keep evolving without breaking consumers.

### Recommended deeper resources
The chapter closes with a reading list: *Building Evolutionary Architectures* by Neal Ford, Rebecca Parsons, and Patrick Kua (book-length treatment of evolvable architectures, APIs, and data); *Implementing Domain Driven Design* by Vaughn Vernon (the full DDD experience); John Ousterhout's *A Philosophy of Software Design* (complexity and how to manage it); Zach Tellman's *Elements of Clojure* (a lucid four-chapter discussion of Names, Idioms, Indirection, and Composition, valuable even if you never touch Clojure); Rich Hickey's talk "Simple Made Easy" (simplicity, complexity, and "easiness" — called a must-watch); Zhamak Dehghani's *Data Mesh* (deeper discussion of data products); and Martin Kleppmann's *Designing Data-Intensive Applications* (data evolution, schemas, IDLs, and change data capture — "an instant classic"). **Lesson:** Evolvability is a deep topic with a well-marked trail of canonical books and talks for going further.
