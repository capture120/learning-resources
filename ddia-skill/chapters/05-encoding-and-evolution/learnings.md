# Chapter 5: Encoding and Evolution — Core Learnings

## Central Thesis

Old and new versions of code and data formats inevitably coexist in a running system (rolling upgrades, slow-updating clients, old data on disk). Every byte that crosses a process boundary — to disk, over the network, through a queue — must therefore be encoded in a way that preserves **backward compatibility** (new code reads old data) and **forward compatibility** (old code reads new data). The choice of encoding format determines how easy this is, and it shapes the architecture and evolvability of the whole application. The chapter's closing verdict: with a bit of care, backward/forward compatibility and rolling upgrades are quite achievable.

## Compatibility: The Two Directions

- **Backward compatibility**: newer code can read data written by older code. Usually easy — you know the old format and can handle it explicitly.
- **Forward compatibility**: older code can read data written by newer code. Harder — old code must tolerate and ignore additions it doesn't understand.
- For APIs: an **old client → new service** needs backward compatibility on the request and forward compatibility on the response. A **new client → old service** needs the reverse.
- Why both directions matter: rolling upgrades (server-side) mean mixed versions run simultaneously; client-side apps may not be updated for a long time.
- Why rolling upgrades are worth the trouble: new versions deploy without downtime (encouraging frequent small releases over rare big ones) and deployments are less risky — a faulty release can be detected and rolled back before it affects many users. Mechanics (a.k.a. **staged rollout**): deploy to a few nodes, monitor, gradually work through the rest.
- **Critical gotcha (the read-modify-write trap)**: if old code reads a record containing a new field, decodes it into a model object that drops unknown fields, then writes the record back, the new field is silently lost. Preserve unknown fields through read-modify-write cycles. The same hazard exists when a consumer republishes messages to another topic.

## Formats for Encoding Data

Encoding (a.k.a. serialization/marshaling) translates in-memory structures (pointers, objects) into self-contained byte sequences; decoding (parsing/deserialization) reverses it. (The book avoids the word "serialization" because it means something else in transactions.) Sometimes encoding can be skipped entirely: zero-copy formats (Cap'n Proto, FlatBuffers) use the same layout in memory and on disk/network, and some databases operate directly on compressed data loaded from disk.

### Language-Specific Formats (Java Serializable, Python pickle, Ruby Marshal, Kryo)

Avoid for anything but transient, throwaway purposes. Four reasons:
1. Locks you into one programming language; blocks integration with other systems.
2. **Security**: decoding instantiates arbitrary classes — a classic remote-code-execution vector if an attacker controls the bytes.
3. Versioning/compatibility is an afterthought.
4. Efficiency is an afterthought (Java's built-in serialization is notoriously slow and bloated).

### JSON, XML, CSV (textual formats)

Strengths: language-independent, human-readable, universally supported. Good enough for many purposes — especially **data interchange between organizations**, where getting two parties to agree on anything outweighs format elegance.

Weaknesses to design around:
- **Numbers**: XML/CSV can't distinguish a number from a digit-string without a schema. JSON distinguishes strings from numbers but not integers from floats, and specifies no precision. Integers > 2^53 lose precision when parsed as IEEE 754 doubles (e.g., in JavaScript). Workaround: also send large IDs as decimal strings (X/Twitter does this with 64-bit post IDs).
- **Binary data**: not supported; Base64 workaround inflates size ~33% and relies on the schema to flag the encoding. Because correct interpretation (numbers, binary strings) depends on schema information, applications that don't use XML/JSON Schema may have to hardcode the encoding/decoding logic instead.
- **CSV**: supports only tabular data — no nesting. No schema at all, vague escaping rules (commas/newlines in values), parsers that don't follow the RFC. Schema changes must be handled by hand.
- **XML**: verbose and complicated.

### JSON Schema

Widely used (OpenAPI, Confluent Schema Registry, Apicurio, PostgreSQL pg_jsonschema, MongoDB $jsonSchema). Rich validation: types plus constraints (e.g., port between 1 and 65,535), conditional if/else logic, named types, remote schema references.
- **Open vs. closed content models**: `additionalProperties: true` (the default) permits any undeclared field — so JSON Schemas usually define what is *not* permitted rather than what is. Closed models allow only declared fields.
- Power has a cost: remote schema resolution, conditional rules, and open content models make JSON Schema (and XML Schema) hard to reason about and hard to evolve compatibly.

### Binary JSON variants (MessagePack, CBOR, BSON, Smile, ...)

Schemaless, so they must embed every field name in every record. Result: small savings only — MessagePack encodes the book's example record in 66 bytes vs. 81 bytes of compact textual JSON. Marginal space/parse gains usually don't justify losing human-readability. Some variants extend the datatype set (integers vs. floats, binary strings) but otherwise keep the JSON/XML data model unchanged; all have found only niche adoption — none is as widely used as textual JSON/XML. Schema-driven formats encode the same record in roughly half the bytes.

### Protocol Buffers (and Thrift)

- Developed at Google; Thrift, its close cousin (same principles apply), originated at Facebook.
- Schema required, written in a simple IDL: field names, **numeric field tags**, and types. No value-validation rules. Code generation produces encode/decode classes per language.
- Wire format: concatenated fields, each tagged with (field tag + wire type) packed into one byte where possible; variable-length integers (–64..63 in 1 byte, –8,192..8,191 in 2 bytes); strings are length-prefixed UTF-8; unset fields are simply omitted; lists are repeated occurrences of the same tag (`repeated`). Example record: **33 bytes**.
- Varint mechanism: the top bit of each byte says whether more bytes follow; the low seven bits carry data, least-significant group first (simplifies reconstruction while reading). Tags are best thought of as **aliases for field names** — a compact way to say which field without spelling out its name.
- **Evolution rules**:
  - Field *names* can change freely (the wire never carries names). Field *tags* can never change.
  - Add a field: must use a fresh tag. Old code skips unknown tags (the wire type tells it how many bytes to skip) *while preserving them* — which is how protobuf avoids the Figure 5-1 read-modify-write data loss → forward compatible. New code reading old data fills the missing field with a default (empty string, 0) → backward compatible.
  - Remove a field: same rules reversed. **Never reuse a removed tag number** — old data may still carry it. Use `reserved` to record retired tags.
  - Type changes: possible for some types but risky — widening int32 → int64 is fine for new readers (zero-fill), but old 32-bit readers will **truncate** 64-bit values that don't fit.

### Avro

- Schema required; two equivalent schema languages (Avro IDL for humans, a JSON form for machines). No tag numbers, no validation rules. Started in 2009 as a Hadoop subproject because Protocol Buffers didn't fit Hadoop's use cases.
- Wire format is the most compact shown: **32 bytes** for the example record. The encoding is just values concatenated — no field identifiers or type markers at all. Decoding walks the schema in order to know what each value is, so **the decoder needs the exact writer's schema or the data is garbage**.
- **Writer's schema vs. reader's schema**: the decoder takes both the writer's schema (the version used to encode) and the reader's schema (what the app expects) and resolves differences: fields are matched **by name**; field order doesn't matter; writer-only fields are ignored; reader-only fields get the reader's declared default.
- **Evolution rules**:
  - In Avro terms: *forward* compatibility = the writer uses a newer schema than the reader; *backward* compatibility = the writer uses an older schema than the reader.
  - You may add or remove only fields that have a **default value**. Adding a field without a default breaks backward compatibility; removing a field without a default breaks forward compatibility.
  - Nullable fields must be declared as a union, e.g. `union { null, long }`, with null first if it's the default. Explicit nullability prevents bugs; nothing is nullable by default.
  - Renames work via reader-schema **aliases** — backward compatible only, not forward.
  - Adding a branch to a union type: backward compatible only.
  - Type changes are allowed if Avro can convert.
- **How does the reader get the writer's schema?** Context-dependent:
  - *Large file, many records, same schema*: embed the schema once at the top (Avro object container files). A common Avro use case, discussed further in Chapter 11.
  - *Database, records written at different times*: prefix each record with a schema version number; keep a schema-versions table or registry (Confluent Schema Registry for Kafka, LinkedIn Espresso). Version = incrementing integer or schema hash.
  - *Bidirectional network connection*: negotiate the schema once at connection setup (Avro RPC).
  - A schema registry is worth having regardless: it documents schemas and lets you check compatibility before deploying.
- **Avro's killer advantage — dynamically generated schemas**: because there are no tag numbers, you can mechanically regenerate an Avro schema from, say, a relational schema every time you dump a database, and readers still resolve old and new files correctly by field name. With Protocol Buffers, someone (or some very careful tooling) must maintain the column-to-tag mapping across schema changes and never reuse a tag.

### The Merits of Schemas (why binary schema formats beat schemaless)

- More compact than any "binary JSON" (field names omitted).
- The schema is documentation that **cannot go stale** — it's required for decoding.
- A schema registry lets you check forward/backward compatibility of a change **before deployment**.
- Code generation gives compile-time type checking in statically typed languages.
- Their simplicity is itself an advantage: because protobuf/Avro schemas are far simpler to implement and use than XML/JSON Schema, they gained support across a wide range of programming languages.
- Downside of binary schema formats: data must be decoded before it's human-readable.
- Net: schema evolution gives the flexibility of schemaless/schema-on-read databases *plus* guarantees and tooling. Keep the number of concurrent schema formats small for operational sanity.
- Lineage note: these ideas date to ASN.1 (1984), whose DER encoding still underlies X.509 SSL certificates; ASN.1 has tag-number evolution like protobuf but is too complex and badly documented for new applications. Most databases also have their own proprietary wire protocol decoded by drivers (ODBC/JDBC).

## Decision Guide: Picking a Format

- **Inter-organization data exchange**: JSON/XML/CSV — agreement matters more than efficiency.
- **Internal services, high volume, statically typed languages, hand-maintained schemas**: Protocol Buffers/gRPC.
- **Schemas generated from other schemas (DB dumps, ETL), Hadoop/Kafka ecosystems, archival files**: Avro.
- **Need rich value validation**: JSON Schema (accept evolution pain) — protobuf/Avro schemas only define structure and types.
- **Never** language built-in serialization for stored or transmitted data (security, lock-in, no versioning).
- Watch numbers (> 2^53 in JSON), binary blobs (Base64 +33%), and unknown-field preservation in every choice.

## Modes of Dataflow

Compatibility is a relationship between the process that encodes and the process that decodes. Four main flows: databases, services (REST/RPC), workflow engines, event-driven messaging.

### Dataflow Through Databases

- Writing = encoding for your future self; backward compatibility is mandatory or you can't read your own old data. With multiple processes (rolling upgrades), an *older* reader may also read a *newer* writer's value — so forward compatibility is required too.
- **Data outlives code**: deploys replace code in minutes; five-year-old rows persist in their original encoding. Full-dataset rewrites (migrations) are expensive, so databases defer them: LSM engines rewrite during compaction; relational databases apply cheap changes like `ADD COLUMN ... NULL` without rewriting, filling nulls at read time. Schema evolution makes the database *appear* single-schema over storage that mixes historical encodings.
- Complex changes (single-valued → multivalued attribute, moving data to another table) still require the data to be rewritten, often at the application level; keeping compatibility through such migrations is still a research problem.
- **Archival/snapshots**: dumps are written once and immutable — encode with the latest schema, in Avro object container files or an analytics-friendly columnar format like Parquet.

### Dataflow Through Services: REST and RPC

- A service exposes an application-specific API; unlike a database's arbitrary queries, the API only permits inputs/outputs predetermined by business logic — that restriction is encapsulation.
- Service-oriented/microservices goal: each service owned by one team, independently deployable and evolvable, no cross-team release coordination. This *requires* cross-version compatibility of the API encoding.
- The payoff of keeping APIs compatible: behind a stable API, teams are free to change anything — internal migrations of data, services, or even entire systems become much easier.
- **Web services** (HTTP as the transport) appear in three contexts: a client app on a user's device (native mobile app, browser JavaScript) calling a service over the public internet; one service calling another within the same organization (microservices, usually a private network); and one organization's service calling another's over the internet — public APIs such as credit card processing or OAuth.
- **REST**: design philosophy on top of HTTP — simple formats, URLs for resources, HTTP features for caching/auth/content negotiation. IDLs document and evolve APIs: **OpenAPI/Swagger** for JSON web services, **Protocol Buffers** for gRPC. From the IDL you can generate client SDKs, docs, compatibility checks, and test UIs. Frameworks (Spring Boot, FastAPI, gRPC) handle routing/metrics/auth; some generate the IDL from code (FastAPI), others generate code from the IDL (gRPC).
- **Why RPC's location transparency is a flawed abstraction** (the graveyard: EJB, RMI — Java only; DCOM — Microsoft only; CORBA — excessively complex, no compatibility story; SOAP/WS-* — complexity and interop problems):
  1. Network requests fail unpredictably for reasons outside your control; you must retry.
  2. A request can time out — an outcome with **no local analog**: you don't know whether it executed (→ Chapter 9).
  3. Retrying a request whose response was lost executes the action twice unless the protocol is idempotent/deduplicated (→ Chapter 12).
  4. Latency is wildly variable: sub-millisecond to many seconds for the same call.
  5. You can't pass memory references; everything must be encoded — painful for large or mutable objects.
  6. Cross-language type mismatches (e.g., JavaScript and >2^53 integers).
  REST's appeal: it treats network state transfer as something openly different from a function call.
- **RPC evolution rule of thumb**: for internal services you can assume *servers update before clients* → you only need backward compatibility on requests and forward compatibility on responses. Compatibility properties are inherited from the encoding (protobuf rules for gRPC, Avro rules for Avro RPC; for REST+JSON, adding optional request parameters and new response fields is conventionally compatible).
- **Public APIs are harder**: you can't force clients to upgrade, so compatibility must hold possibly indefinitely; breaking changes mean running multiple API versions side by side. Versioning approaches (no standard): version in the URL, version in the Accept header, or per-API-key version stored server-side and changed via an admin interface (Stripe's approach).

### Load Balancing and Service Discovery

A client must find the service (service discovery) and requests must spread across instances (load balancing). Options, roughly in order of sophistication:
- **Hardcoded IP/port**: works until the server moves, dies, or saturates; manual reconfiguration.
- **Hardware load balancers**: datacenter appliances; one host:port in, traffic routed to live servers, failure detection built in.
- **Software load balancers** (NGINX, HAProxy): same behavior on commodity machines.
- **DNS**: multiple IPs per name; fine for stable sets, but caching/slow propagation serves stale addresses when instances churn.
- **Service discovery systems** (etcd, ZooKeeper): instances self-register host/port plus metadata (shard ownership, datacenter) and heartbeat; clients query the registry then connect directly. Handles dynamic environments; metadata enables smarter client-side balancing. (→ Chapter 10 coordination services.)
- **Service meshes** (Istio, Linkerd): discovery + balancing via sidecar/in-process proxies on both client and server; TLS handled entirely between the proxies (apps never touch certificates); rich observability (live call graphs, failures, traffic). Most complex option.
- Rule of thumb: Kubernetes-style dynamic environments → service mesh; specialized infrastructure (databases, brokers) → purpose-built balancers; simple deployments → software load balancer.

### Durable Execution and Workflows

- A **workflow** is a graph of **tasks** (Temporal calls them activities; also "durable functions") spanning multiple services — e.g., a payment touching fraud-check, card-debit, and bank-deposit services. Definitions may be written in a general-purpose programming language, a DSL, or a markup language like BPEL. A **workflow engine** (orchestrator schedules, executor runs) decides where each task runs, handles failures, and limits parallelism. Triggers: schedules, external services, humans.
- Engine flavors: ETL orchestration (Airflow, Dagster, Prefect); graphical/BPMN for non-engineers (Camunda, Orkes); **durable execution** (Temporal, Restate).
- **Durable execution = exactly-once semantics for workflows** where a database transaction is impossible (multiple services, third-party gateways). Mechanism: every RPC call and state change is logged to durable storage (like a write-ahead log). On retry after a task failure, the framework re-executes the task but *skips* already-completed calls, returning the logged results instead of re-calling.
- **Gotchas (memorize these)**:
  - External services must still expose idempotent APIs, and developers must pass unique IDs to prevent duplicate side effects.
  - Replay matches logged RPCs *in order* — merely **reordering function calls** in the code can cause undefined behavior for in-flight workflows. Safe practice: deploy changed workflow code as a **new version**; let existing invocations finish on the old code, route only new invocations to the new code.
  - Workflow code must be **deterministic**: random numbers and system clocks break replay. Use the framework's deterministic substitutes; static analyzers (e.g., Temporal's Workflow Check) catch violations. (Determinism resurfaces in Chapter 9.)

### Event-Driven Architectures

- A request becomes an **event/message**; the sender doesn't wait, and delivery goes through a **message broker** (a.k.a. event broker, message queue, message-oriented middleware) that stores the message temporarily rather than a direct connection. (Synchronous request-response can still be layered on top via a reply channel.)
- Broker advantages over direct RPC: buffers when the recipient is down/overloaded (reliability); redelivers after consumer crashes (no loss); no service discovery needed; one message to many recipients; logical decoupling of sender from consumers.
- Landscape: old commercial middleware (TIBCO, IBM WebSphere, webMethods) → open source (RabbitMQ, ActiveMQ, HornetQ, NATS, Redpanda, Kafka) → cloud services (Kinesis, Azure Service Bus, Google Pub/Sub). Details in Chapter 12.
- Two distribution patterns: **queue** (named queue, one of the consumers gets each message) vs. **topic** (publish/subscribe, all subscribers get each message).
- Brokers don't enforce a data model — a message is just bytes plus metadata. Standard practice: protobuf/Avro/JSON plus a **schema registry** alongside the broker to store versions and check compatibility; AsyncAPI is the messaging counterpart of OpenAPI.
- Durability varies on two axes: many brokers write messages to disk so they survive a broker crash/restart, yet — unlike databases — automatically delete messages after consumption; some can retain indefinitely, which is required for event sourcing.
- Republishing consumers must preserve unknown fields (same trap as Figure 5-1 in databases).

### Distributed Actor Frameworks

- Actor model: concurrency via actors that hold private state and exchange async messages; each actor typically represents one client or entity; one message processed at a time, so no thread/locking concerns and the framework can schedule each actor independently; **message loss is assumed even in-process**.
- Distributed actor frameworks (Akka, Orleans, Erlang/OTP) use the same message-passing across nodes, transparently encoding messages on the wire. Location transparency works *better* here than in RPC because the model already assumes lossy, async messaging — less local/remote mismatch.
- Rolling upgrades still require forward/backward-compatible message encodings: a distributed actor framework is essentially a message broker fused with the actor model, and mixed versions exchange messages.

## Numbers and Named Things Worth Remembering

- Example record sizes: textual JSON 81 bytes → MessagePack 66 → Protocol Buffers 33 → Avro 32.
- JSON integer safety limit: 2^53 (IEEE 754 double mantissa).
- Base64 overhead: ~33%.
- Protobuf varint: 1 byte covers –64..63; 2 bytes cover –8,192..8,191.
- Named: writer's/reader's schema resolution (Avro), object container files (Avro), field tags + `reserved` (protobuf), open/closed content models (JSON Schema), schema registry (Confluent, Apicurio, Espresso), zero-copy formats (Cap'n Proto, FlatBuffers), ASN.1/DER/X.509, OpenAPI/Swagger, AsyncAPI, BPMN/BPEL, durable execution (Temporal, Restate), service mesh (Istio, Linkerd), "data outlives code."

## How This Connects

- **Chapter 2**: evolvability — this chapter is the data-format mechanics behind it; rolling upgrades are the motivating operational practice.
- **Chapter 3**: schema-on-read document databases vs. schema migrations in relational databases; schema evolution gives schemaless flexibility with guarantees; event sourcing ("Event Sourcing and CQRS") — the use case that requires brokers to retain messages indefinitely.
- **Chapter 4**: LSM compaction as the moment old records get rewritten; columnar formats (Parquet) for archival dumps.
- **Chapter 7**: shard ownership metadata in service discovery registries.
- **Chapter 8**: "serialization" name clash with transaction serializability.
- **Chapter 9**: timeouts and not knowing whether a request executed; determinism for replay.
- **Chapter 10**: coordination services (ZooKeeper, etcd) used for service discovery.
- **Chapter 11**: Avro object container files and archival data in batch processing.
- **Chapter 12**: message brokers compared in depth; idempotence/deduplication.
