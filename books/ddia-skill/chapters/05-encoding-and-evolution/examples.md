# Chapter 5: Encoding and Evolution — Examples

## The read-modify-write data loss scenario (Figure 5-1)

A new version of an application adds a field to a record schema and writes records containing that field to a database. Later, an old version of the code — which doesn't know the new field exists — reads one of those records, updates it, and writes it back. If the old code decoded the record into a model object that silently drops unknown fields, the new field vanishes from the database even though the old code never intended to touch it. The desirable behavior is for old code to carry unknown fields through unchanged. The same hazard recurs later in the chapter when a message consumer republishes events to another topic.

**Demonstrates**: forward compatibility requires not just ignoring unknown fields but preserving them through read-modify-write cycles.

## X (Twitter) post IDs and JavaScript numbers

X identifies each post with a 64-bit number. JSON doesn't distinguish integers from floats or specify precision, so JavaScript clients parse JSON numbers as IEEE 754 doubles, which can only represent integers up to 2^53 exactly — larger post IDs get silently corrupted. X's API works around this by returning every post ID twice: once as a JSON number and once as a decimal string.

**Demonstrates**: textual formats are vague about numbers; large integers in JSON need a string fallback.

## JSON Schema for a map with integer keys (Example 5-1)

You want to model a map from integer IDs to strings, but JSON objects only allow string keys. The workaround is a JSON Schema that uses `patternProperties` to permit only keys matching `^[0-9]+$` (digit-only strings) with string values, and sets `additionalProperties: false` to close the content model. It works, but illustrates how quickly JSON Schema definitions become unwieldy: power features like pattern properties, open/closed models, conditionals, and remote references make schemas hard to reason about and evolve.

**Demonstrates**: JSON Schema's expressiveness comes at the cost of complexity and difficult compatible evolution.

## One record, four encodings (Example 5-2, Figures 5-2 to 5-4)

The chapter encodes the same record — `{"userName": "Martin", "favoriteNumber": 1337, "interests": ["daydreaming", "hacking"]}` — in several formats:

- **Textual JSON** (whitespace removed): 81 bytes.
- **MessagePack** (binary JSON): 66 bytes. The chapter walks the bytes: `0x83` = object with 3 fields (top four bits = type, bottom four = count; an object with more than 15 fields gets a different type indicator with the count in two or four bytes), `0xa8` = 8-byte string, then `userName` in ASCII, then `0xa6` plus `Martin`, etc. Length prefixes mean strings need no end marker and no escaping. Because there's no schema, every field name is embedded in the data — so the saving over text is small.
- **Protocol Buffers**: 33 bytes. Field names are replaced by numeric tags (1, 2, 3) from the schema; type and tag pack into one byte; 1337 fits in a two-byte varint; the list is repeated occurrences of tag 3.
- **Avro**: 32 bytes, the most compact. The encoding is values only — no field identifiers or type markers at all. Length-prefixed UTF-8 strings and varint integers concatenated in schema order. Decoding is only possible with the exact writer's schema. The chapter's Avro schema also illustrates explicit nullability: `favoriteNumber` is declared `union { null, long }` with default `null`, in both the human-oriented Avro IDL and the machine-oriented JSON schema representation.

**Demonstrates**: schemaless binary formats save little over text; schema-driven formats roughly halve the size by omitting field names, and Avro goes furthest by omitting all per-field metadata.

## Protocol Buffers int32 → int64 widening

You change a field from 32-bit to 64-bit integer. New code reading old data is fine: the parser zero-fills the missing high bits. But old code reading new data still stores the value in a 32-bit variable, so a 64-bit value that doesn't fit gets truncated.

**Demonstrates**: datatype changes can be one-directionally compatible; truncation is the forward-compatibility failure mode.

## Avro reader/writer schema resolution (Figures 5-5, 5-6)

An application encodes data with whatever schema version is compiled into it (the writer's schema). A decoding application may expect a different version (the reader's schema). Avro resolves the two side by side: fields are matched by name, so ordering differences don't matter; a field present only in the writer's schema is ignored; a field present only in the reader's schema is filled with the default declared there. This contrasts with Protocol Buffers, where there's only one schema lineage and tag numbers carry meaning across versions.

**Demonstrates**: Avro's evolution mechanism — compatibility comes from resolving two schemas at decode time, which is why every added or removed field must have a default.

## Three ways a reader learns the writer's schema

Including the full schema with every Avro record would dwarf the data, so the chapter gives three context-dependent solutions. (1) A large file of millions of same-schema records — a common Avro use case, discussed further in Chapter 11 — embeds the schema once at the top (Avro object container files). (2) A database where records are written at different times with different schemas prefixes each record with a version number and keeps a table of schema versions; Confluent's Schema Registry for Kafka and LinkedIn's Espresso work this way. (3) Two processes on a bidirectional connection negotiate the schema at connection setup and use it for the connection's lifetime (Avro RPC).

**Demonstrates**: schema distribution is a per-context design problem; a schema-version database doubles as documentation and a pre-deploy compatibility check.

## Dumping a relational database to Avro (dynamically generated schemas)

You want to export a relational database to a binary file. With Avro you mechanically generate a record schema per table — each column becomes a field, matched by name — and dump to an object container file. When the database schema changes (a column added, another removed), the export job just regenerates the Avro schema and keeps running; readers resolve new files against old expectations by field name. With Protocol Buffers, the column-to-tag mapping would need manual maintenance by an administrator on every schema change, and the generator would have to guarantee that no retired tag number is ever reused.

**Demonstrates**: Avro's lack of tag numbers makes it the right choice when schemas are generated from other schemas rather than hand-edited.

## ASN.1 and SSL certificates

The schema-evolution ideas in protobuf and Avro are not new: ASN.1, standardized in 1984, defined network protocols and supports tag-number-based evolution much like Protocol Buffers. Its DER binary encoding still encodes X.509 SSL certificates today. But ASN.1 is very complex and badly documented, so it's probably not a good choice for new applications.

**Demonstrates**: schema-driven binary encoding with tag-based evolution is a forty-year-old idea — but ASN.1's complexity and poor documentation make it probably not a good choice for new applications.

## Schema evolution inside a database: data outlives code

A new application version deploys in minutes, but a database holds values written five milliseconds ago next to values written five years ago, still in their original encoding. Rewriting the whole dataset is expensive, so databases avoid it: LSM-tree engines rewrite rows into the latest format opportunistically during compaction, and relational databases apply changes like adding a nullable column without touching existing rows, filling in nulls at read time. The database thus presents a single-schema appearance over storage containing many historical encodings. Harder changes — making a single-valued attribute multivalued, or moving data into a separate table — still require the data to be rewritten, often at the application level.

**Demonstrates**: "data outlives code" — backward compatibility with years-old encodings is unavoidable in databases, and schema evolution is how databases avoid expensive migrations.

## Ping/Pong service: OpenAPI definition plus FastAPI implementation (Examples 5-3, 5-4)

The chapter defines a trivial web service — GET /ping returns `{"message": "Pong!"}` — first as an OpenAPI YAML document specifying the endpoint, response schema, and documentation, then as a FastAPI implementation where a Pydantic response model and a decorated handler express the same contract in Python. FastAPI generates the IDL from the code; gRPC works the other way, generating server scaffolding from the service definition. Either direction enables generated client SDKs, documentation, compatibility verification, and test GUIs.

**Demonstrates**: service IDLs (OpenAPI, protobuf) are the contract artifact; frameworks let you derive code from contract or contract from code.

## The RPC graveyard

Enterprise JavaBeans and Java RMI only work from Java. DCOM only works on Microsoft platforms. CORBA is excessively complex and has no forward or backward compatibility story. SOAP and WS-* aimed at vendor interoperability but drowned in complexity and compatibility problems. All shared the RPC premise from the 1970s: make a network request look like a local function call (location transparency). The chapter then lists why the premise fails — unpredictable network failures, timeouts where you can't know if the request executed, duplicate execution on retry without idempotence, latency varying from sub-millisecond to seconds, no passing of memory references, and cross-language type mismatches. REST succeeds partly because it makes network communication look openly different from a function call.

**Demonstrates**: location transparency is a flawed abstraction; a network call is a fundamentally different thing from a local call.

## Payment processing workflow (Figure 5-7, Example 5-5)

A payment application charges a credit card and deposits funds into a bank account, with separate services for fraud detection, card integration, and bank integration. Processing one payment is a workflow: check fraud, debit the card, deposit the funds. A failure mid-workflow could charge the card without depositing the funds, and you can't wrap two services and a third-party payment gateway in one database transaction. The chapter shows the workflow in BPMN graphical notation and as a Temporal workflow definition in Python, where each step runs as an activity with a timeout. Temporal's durable execution logs every RPC and state change; on retry it skips completed calls and returns their logged results, giving exactly-once semantics.

**Demonstrates**: durable execution provides transaction-like guarantees across services where actual transactions are impossible.

## Why changing durable workflow code is brittle

Because a durable execution framework logs RPC calls in order and replays against that log, it expects re-executions to make the same calls in the same order. Simply reordering two function calls in workflow code can produce undefined behavior for workflows already in flight. Nondeterministic code — random number generators, system clocks — breaks replay the same way; frameworks supply deterministic substitutes and static analysis (Temporal's Workflow Check) to catch violations. The safe change procedure is versioning: deploy new workflow code separately so existing invocations replay on the old version and only new invocations use the new code. External APIs called from workflows must still be idempotent, with developers supplying unique request IDs.

**Demonstrates**: durable execution buys transaction-like guarantees at the cost of strict determinism and ordered-replay constraints on code changes.

## Brokers vs. direct RPC

The chapter contrasts sending a message via a broker with calling a service directly: the broker buffers messages when the recipient is down or overloaded, redelivers to crashed consumers, removes the need for service discovery, can fan one message out to many recipients, and decouples senders from whoever consumes. Two delivery patterns: a queue delivers each message to one of its consumers; a topic delivers each message to all subscribers. Messages are just bytes, so teams pair brokers with a schema registry (or AsyncAPI specs) to keep encodings compatible.

**Demonstrates**: asynchronous broker-mediated dataflow trades immediacy for reliability and decoupling, and still needs the same encoding compatibility discipline.

## Distributed actors and rolling upgrades

In actor frameworks (Akka, Orleans, Erlang/OTP), logic lives in actors with private state that exchange asynchronous messages, processing one at a time — and the model assumes messages can be lost even within a single process. Distributing actors across nodes uses the same message-passing, so the local/remote mismatch that dooms RPC is much smaller here. But a rolling upgrade still means a new-version node may message an old-version node and vice versa, so actor messages need forward- and backward-compatible encodings like any other dataflow.

**Demonstrates**: location transparency works better when the programming model already assumes lossy async messaging — but encoding compatibility requirements never go away.
