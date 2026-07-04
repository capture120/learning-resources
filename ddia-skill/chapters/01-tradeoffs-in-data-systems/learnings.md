# Chapter 1: Trade-Offs in Data Systems Architecture — Learnings

## Central Thesis

There are no solutions in data systems architecture, only trade-offs (the chapter's epigraph, from Thomas Sowell: "you try to get the best trade-off you can get, and that's all you can hope for"): no approach is fundamentally better than another, and every choice has pros and cons. The job of an engineer is to ask the right questions to evaluate and compare data systems for a particular application's needs. This chapter establishes four foundational trade-off axes: operational vs. analytical systems, cloud vs. self-hosting, distributed vs. single-node, and business needs vs. legal/societal obligations.

Context for the whole book: applications are built by taking several software systems or services (databases, APIs) and gluing them together with application code. If you use each system exactly as designed, this is easy; challenges arise when your ambitions exceed what any single tool can do and tools must be combined. Many of the ideas originate in enterprise software (big corporations, governments), because historically only large organizations had data volumes requiring sophisticated solutions — small enough data can simply live in a spreadsheet — though startups now build data-intensive systems too. A key organizational challenge: different teams have entirely different priorities for the same dataset, and those goals are often not explicitly articulated, which breeds misunderstanding and disagreement about the right approach.

## Key Terminology

- **Data-intensive application**: data management (volume, change, consistency under failure and concurrency, availability) is a primary development challenge — as opposed to compute-intensive, where the challenge is parallelizing a large computation.
- **Standard building blocks**: databases (store and retrieve), caches (remember expensive results), search indexes (keyword search/filter), stream processing (react to events as they occur), batch processing (periodically crunch accumulated data).
- **Frontend/backend**: frontend handles one user's data on their device; backend manages data for all users. Backend application code is usually stateless; anything that must persist across requests lives in the client or in server-side data infrastructure (databases, caches, message queues).

## Operational Versus Analytical Systems

### Who works with data (three roles, plus two newer ones)

- **Backend engineers** build services that handle requests to read and update data, serving external users directly or via other services.
- **Business analysts** generate reports on the organization's activities so management can make better decisions (**business intelligence, BI**).
- **Data scientists** look for novel insights in data or build user-facing, data/ML-powered product features (recommendations, risk scoring, spam filtering, search ranking).
- Analysts and data scientists differ in tools, but both perform **analytics**: they look at data that users and backend services generated, and generally do not modify it (beyond fixing mistakes), though they may create derived datasets.
- Two newer specialized roles: **data engineers** integrate the operational and analytical sides and own the organization's data infrastructure broadly; **analytics engineers** model and transform data to make it more useful for analysts and data scientists.

### Definitions

- **Operational (OLTP) systems**: backend services and data infrastructure where data is created. Application code reads and modifies data based on user actions. "Transaction" originated when each database write was a commercial transaction (a sale, a supplier order, a salary payment); the term stuck as databases spread to non-monetary data, now meaning a group of reads/writes forming a logical unit. This chapter uses it loosely for low-latency reads/writes (rigorous definition deferred to Ch. 8). Because these applications are interactive, the pattern is called *online* transaction processing.
- **Analytical (OLAP) systems**: serve business analysts and data scientists. Hold a read-only copy of operational data, optimized for analytic processing. (The "online" in OLAP is less clear; it probably means analysts use the system interactively for explorative queries, not just predefined reports.)

### OLTP vs. OLAP characteristics (memorize this table)

| Property | OLTP | OLAP |
|---|---|---|
| Read pattern | Point queries (fetch records by key) | Aggregate over many records |
| Write pattern | Create/update/delete individual records | Bulk import (ETL) or event stream |
| Human user | End user of web/mobile app | Internal analyst (decision support) |
| Machine use | Checking if an action is authorized | Detecting fraud/abuse patterns |
| Query types | Fixed, predefined in application code | Arbitrary, ad hoc exploration |
| Query volume | Many small queries | Few complex queries |
| Data represents | Latest current state | History of events over time |
| Dataset size | Gigabytes to terabytes | Terabytes to petabytes |

### Why OLTP systems run fixed queries only

End users are not allowed to write custom SQL against operational databases because (1) they could read or modify data without permission, and (2) expensive ad hoc queries degrade performance for everyone. Exception: one-off custom queries are still run against OLTP systems occasionally, for maintenance or troubleshooting. Analytical databases do the opposite: they invite arbitrary SQL, often generated by BI tools (Tableau, Looker, Power BI).

### Product / real-time analytics

A third category: analytical-style queries (aggregations) embedded in user-facing products. Systems: **Pinot, Druid, ClickHouse**. They ingest in real time and optimize for low query latency, whereas traditional OLAP ingests in batches and optimizes for query throughput.

### Data warehousing

- History: at first the same databases served both transaction processing and analytics (SQL works well for both query types). In the late 1980s and early 1990s, companies began moving analytics off their OLTP systems onto a separate database — the data warehouse.
- A **data warehouse** is a separate read-only database holding copies of data from all OLTP systems, queryable by analysts without affecting operations.
- Do not let analysts query OLTP systems directly because: data is spread across silos; OLTP schemas suit transactions, not analytics; analytic queries are expensive and hurt OLTP performance; OLTP systems may be network-isolated for security/compliance.
- **ETL** (extract–transform–load): periodic dump or continuous stream out of OLTP databases, transform into an analysis-friendly schema, clean, load. **ELT** swaps the last two steps (transform after loading, inside the warehouse).
- ETL sources can be external SaaS products (CRM, email marketing, payments) reachable only via vendor APIs; connector services like **Fivetran, Singer, Airbyte** handle this. Pulling SaaS data into your warehouse enables analyses the SaaS API alone cannot.
- Structural asymmetry: an enterprise has potentially hundreds of operational databases (one per service is good practice) but usually **one** data warehouse, so analysts can join across systems in a single query.

### HTAP — and why it does not kill the warehouse

**Hybrid transactional/analytical processing (HTAP)** systems aim to serve both workloads without ETL. But many HTAP systems are internally an OLTP engine coupled to a separate analytical engine behind one interface, so the OLTP/OLAP distinction still matters. HTAP is useful when one application needs both large scans and low-latency point updates (e.g., fraud detection). It does not replace the warehouse, because the warehouse's role is combining data from many separate operational databases. Broader trend: the bigger the scale, the more specialized systems become; general-purpose systems suffice only at small data volumes.

### Data lakes

- A **data lake** is a centralized repository of files — any data that might be useful for analysis, copied from operational systems via ETL — with **no imposed file format, data model, or schema**.
- Motivation: data scientists' work (feature engineering for ML, NLP/computer vision extraction) needs custom code that is hard to express in SQL, so they prefer Pandas, scikit-learn, R, Spark over a relational warehouse. (Efforts exist to add ML operators to the SQL data model and build efficient ML systems on relational foundations, but data scientists' preference persists anyway.)
- Files may be Avro/Parquet record collections, but also text, images, video, sensor readings, sparse matrices, feature vectors, genome sequences.
- Cheaper than relational storage because it can sit on commodity object storage.
- In some cases the lake becomes an intermediate stop between operational systems and the warehouse: keep raw data, let each consumer transform it to their own needs (the **sushi principle**: "raw data is better").
- ETL has generalized to **data pipelines**.

### Beyond the lake

- **DataOps**: growing attention to management/operations of analytical systems and pipelines, driven by governance, privacy, GDPR/CCPA compliance.
- **Streams**: analytics data increasingly arrives as event streams, not just files/tables. File-based analysis reruns periodically (e.g., daily); stream processing responds in seconds — valuable for time-sensitive uses like blocking fraud/abuse.
- **Reverse ETL**: outputs of analytical systems flow back into operational systems — e.g., an ML model trained on warehouse data deployed to serve recommendations. Deployment tools: TFX, Kubeflow, MLflow.

### Systems of record vs. derived data

- **System of record (source of truth)**: holds the authoritative version; new data is written here first; each fact represented exactly once (typically normalized). On any discrepancy, the system of record is by definition correct.
- **Derived data**: result of transforming data from another system; losable and re-creatable from source. Examples: caches, denormalized values, indexes, materialized views, transformed representations, trained ML models.
- Derived data is technically redundant, but essential for read performance, and lets you view the same data from multiple angles.
- The distinction is about **usage, not tooling**: most databases can serve either role. Being explicit about which data derives from which brings clarity to a confusing architecture.
- Gotcha: when source data changes, derived data must be updated — yet most databases assume they are the only database, making cross-system propagation hard (data pipelines, Ch. 11, address this).
- Analytical systems are usually derived, since they consume data created elsewhere; operational services mix systems of record (primary DBs) with derived systems (indexes, caches).

## Cloud Versus Self-Hosting

### Build vs. buy rule of thumb

Do in-house what is core competency or competitive advantage; outsource the non-core, routine, commonplace (extreme example: most companies don't fabricate their own CPUs — buying from semiconductor manufacturers is cheaper).

The decision spectrum runs from bespoke software run in-house, through self-hosted off-the-shelf software (on premises or on cloud VMs/IaaS), to fully managed cloud services and SaaS accessed only via API. It reflects two separate decisions: who builds the software and who deploys/operates it. A related question — how you deploy services (e.g., whether to use an orchestration framework like Kubernetes) — has less influence on the architecture of data systems than these other factors.

### When self-hosting wins

- You already know how to deploy and operate the system, **and** your load is predictable (machine count doesn't fluctuate wildly) — then buying your own machines is often cheaper.
- You need workload-specific configuration and tuning; a cloud vendor won't customize for you.
- Specialist requirements no cloud service meets — e.g., high-frequency trading needs full hardware control for latency.
- Many older systems simply predate the cloud; the cloud will not subsume all in-house data systems (though hybrid approaches — cloud for some aspects of a system — are increasingly common).

### When cloud wins

- You don't already know how to operate the system; hiring/training ops staff is expensive, and a specialist provider serving many customers gains operational expertise you can't match.
- **Highly variable load** — the key economic case. Provisioning for peak leaves resources idle; the cloud returns unused resources. Analytical workloads are the canonical example: a big interactive query needs massive parallelism briefly, then nothing. For small datasets the difference is minor.

### Cloud risks (the biggest downside is loss of control)

- Missing feature: you can only ask the vendor; you cannot build it yourself.
- Outage: you can only wait.
- Bugs/performance problems: you lack OS metrics, internals, and server logs, so diagnosis is hard.
- Shutdown, price hikes, or unwanted product changes: you cannot keep running the old version; you must migrate. Without standard APIs across vendors, switching cost is high — **vendor lock-in**.
- Geopolitics: sanctions can lock you out of a foreign provider.
- You must trust the provider with data security, complicating privacy/compliance.

### Cloud native architecture

- **Cloud native** = designed from the ground up for cloud services, not merely self-hostable software run on VMs. Demonstrated advantages: better performance on the same hardware, faster failure recovery, rapid scaling, larger datasets.
- Why self-hosted software runs fine on IaaS: it mostly has generic system requirements — a conventional OS (Linux/Windows), data as files on a filesystem, TCP/IP networking; only a few systems need special hardware (GPUs for ML, RDMA network interfaces). Cloud instances provision faster and come in more sizes than physical machines, but are otherwise traditional computers: you can run anything on them, and you administer them yourself.
- Examples — self-hosted vs. cloud native: OLTP: MySQL/PostgreSQL/MongoDB vs. AWS Aurora, Azure SQL DB Hyperscale, Google Cloud Spanner. OLAP: Teradata/ClickHouse/Spark vs. Snowflake, BigQuery, Azure Synapse.
- **Layering**: cloud native services build higher-level services on lower-level ones. Object stores (S3, Azure Blob, Cloudflare R2) offer a limited file API but hide physical machines, auto-distribute data, and survive disk/machine failure. Snowflake builds on S3; other services build on Snowflake. Rule: higher abstractions are more use-case specific — if one fits, use it; if none fits, compose lower-level pieces yourself.

### Separation of storage and compute

- Traditional: same machine holds disk and CPU; RAID guards against single-disk failure, transparently to applications.
- Cloud native systems treat instance-local disks as **ephemeral cache**, not durable storage — the disk is lost when the instance fails or is resized onto another physical machine.
- Virtual disks (EBS, Azure managed disks, GCP persistent disks) emulate a block device (typically 4 KiB blocks) over the network; unlike local disks, they can be detached from one instance and attached to a different one. They let traditional disk software run in the cloud, but emulation adds overhead and **every I/O becomes a network call**, so apps become very sensitive to network glitches.
- Cloud native services therefore skip virtual disks and use purpose-built storage services. Object stores suit large files (hundreds of KB to several GB); database rows are far smaller, so cloud databases keep small values in a separate service and pack many values into large blocks in object storage (details in Ch. 4).
- Result: storage and compute are **disaggregated** — S3 stores files; analysis runs elsewhere, requiring data transfer over the network.
- **Multitenancy**: shared hardware across customers improves utilization, scalability, and provider manageability, but requires careful engineering so one customer cannot harm another's performance or security.

### Operations in the cloud era

- The role of operations: ensure services are reliably delivered to users (configuring infrastructure, deploying applications) and keep the production environment stable (monitoring, diagnosing anything affecting reliability). For self-hosted systems this traditionally means machine-level work: capacity planning (adding disks before space runs out), provisioning new machines, moving services between machines, installing OS patches.
- The DBA/sysadmin role evolved into shared dev+ops responsibility guided by the DevOps philosophy (SRE is Google's implementation of the idea). Emphases: automation over one-off manual work, ephemeral VMs over long-running servers, frequent deploys, learning from incidents, preserving organizational knowledge as people leave.
- Cloud APIs hide individual machines; metered billing replaces capacity planning. **Capacity planning becomes financial planning; performance optimization becomes cost optimization.**
- The cloud has bifurcated ops roles: operations teams at infrastructure providers specialize in delivering a reliable service to many customers, while customer teams aim to spend as little time and effort on infrastructure as possible.
- Cloud users still need ops, refocused on: choosing the right service, integrating services (a major pain point — no integration standards exist, so it's manual), migrating between services, tracking spend, and knowing service quotas/limits before hitting them.
- Cannot be fully outsourced: application/library security, inter-service interactions, load monitoring, root-causing performance degradations and outages.

## Distributed Versus Single-Node Systems

A **distributed system** = several machines communicating via a network; each participating process is a **node**.

### Valid reasons to distribute

1. **Inherent distribution** — multiple users on separate devices must communicate over a network anyway.
2. **Requests between cloud services** — data stored in one service, processed in another; cloud native and microservice systems are distributed by construction.
3. **Fault tolerance / high availability** — redundancy across machines (or datacenters) so another takes over on failure.
4. **Scalability** — data or compute exceeds one machine.
5. **Latency** — serve global users from geographically nearby servers.
6. **Elasticity** — scale with demand, pay for what you use; a single machine must be provisioned for peak.
7. **Specialized hardware** — match hardware to workload (object store: many disks, few CPUs; analytics: lots of CPU/RAM, no disks; ML: GPUs).
8. **Legal compliance** — data residency laws force storage/processing within particular countries; scope varies (sometimes only medical/financial data).
9. **Sustainability** — schedule flexible jobs where/when renewable power is plentiful and cheap.

These reasons apply both to services you write yourself (application code) and to off-the-shelf software such as databases.

### Problems with distribution (why single-node should be the default)

- Every network request can fail: interruption, overload, crash, timeout — and on timeout you **don't know if the request was received**, so retrying may not be safe (Ch. 9).
- A network call is vastly slower than an in-process function call. For big data, move the computation to the data rather than the data to the computation.
- **More nodes are not always faster**: a single-threaded program on one machine can beat a cluster of 100+ CPU cores ("Scalability! But at What COST?").
- Troubleshooting is hard; **observability** (metrics plus queryable per-event data) and tracing tools (OpenTelemetry, Zipkin, Jaeger) exist to localize problems.
- When each service has its own database, cross-service data consistency becomes the **application's** problem. Distributed transactions could help but are rarely used with microservices: they couple services together and many databases don't support them.
- Bottom line: a single machine is often much simpler and cheaper. Hardware keeps growing; single-node databases (DuckDB, SQLite, KùzuDB) now handle many workloads. Don't rush to distribute.

### Microservices and serverless

- Client/server over HTTP is the common distribution pattern; the same process may be both a server (handling incoming requests) and a client (calling other services). SOA refined into **microservices**: each service has one well-defined purpose, an API callable over the network, and one owning team. Cloud native systems use service decomposition heavily, but on-premises systems can be service-oriented too.
- Benefits: independent updates (less cross-team coordination), per-service hardware sizing, implementation hidden behind the API so it can change freely.
- Each service should own its database. Sharing a database makes the schema part of the API (hard to change) and lets one service's queries hurt another's performance.
- Costs: testing needs all dependency services running; each service needs deploy, scaling, logging, monitoring, and on-call infrastructure (Kubernetes provides a foundation); API evolution is risky — adding/removing fields breaks clients, often discovered only at staging/production. OpenAPI and gRPC schemas help (Ch. 5).
- **Decision rule**: microservices are a technical solution to a people problem (independent team progress). Valuable in a large company; in a small company with few teams they are unnecessary overhead — build the simplest thing.
- **Serverless / FaaS**: provider auto-allocates and frees resources per incoming request; metered billing for code execution, no advance provisioning. Limits: execution time caps, restricted runtimes, cold-start latency. "Serverless" is also marketing shorthand for autoscaling + usage billing (BigQuery, Kafka offerings). Each execution still runs on a server — possibly a different one each time.

### Cloud computing vs. supercomputing (HPC)

- HPC: compute-intensive scientific batch jobs (weather, climate, molecular dynamics, optimization, PDEs). Cloud: continuously available online services.
- Fault handling: HPC checkpoints to disk; on node failure, a common solution is to stop the whole cluster, repair, restart from checkpoint. For cloud services, stopping the whole cluster is usually not desirable — they need to continually serve users.
- Communication: HPC uses shared memory and RDMA (high bandwidth, low latency, assumes trusted users). Cloud shares networks/machines among mutually untrusting tenants, requiring isolation (VMs), encryption, authentication.
- Topology: cloud uses IP/Ethernet in Clos topologies for high bisection bandwidth (a common measure of a network's overall performance); HPC uses specialized meshes/toruses tuned to known communication patterns.
- Geography: cloud nodes span regions; supercomputer nodes are co-located.
- Large-scale analytics sometimes resembles supercomputing; the book focuses on continually available services.

## Data Systems, Law, and Society

- Architecture is shaped by regulation, not just business and technical goals. GDPR (since 2018) gives residents of many European countries control and legal rights over personal data; CCPA and others followed; AI regulation such as the EU AI Act further restricts how personal data can be used.
- Legal requirements create engineering problems: the GDPR **right to be forgotten** conflicts with immutable constructs like append-only logs, and with derived data (how do you delete data already baked into ML training sets?). No accepted blueprint for "GDPR-compliant architecture" exists — the law sets principles, not technologies.
- **True cost of storing data** = storage bill + liability and reputational risk if breached + legal fines if non-compliant + government/police compelled disclosure. Where data could reveal criminalized behavior (e.g., visiting an abortion clinic, inferred from location or IP logs), storage creates real safety risk for users.
- **Data minimization (Datensparsamkeit)**: if risks outweigh value, delete the data or never collect it. This directly opposes the "big data" instinct to hoard speculatively, but matches GDPR rules: collect only for a specified explicit purpose, never reuse for other purposes, never keep longer than needed.
- Industry compliance regimes: **PCI** standards for payment processors, **SOC 2** for software vendors — both enforced by recurring third-party audits.
- Even unregulated areas carry societal effects: social media changed how people consume news, influencing political opinions and potentially election outcomes; automated decisions (loans, insurance, job interviews, criminal suspicion) have profound consequences for individuals. Everyone building such systems shares responsibility for their ethical impact — basic legal/ethical awareness is as essential as distributed-systems fundamentals (deep dive in Ch. 14).

## Decision Cheat Sheet

- Analysts need to query production data → build a warehouse via ETL; avoid pointing BI tools at OLTP (usually undesirable: silos, schema mismatch, performance, network isolation).
- Data scientists need raw/unstructured data → data lake on object storage; transform per consumer (sushi principle).
- One app needs both scans and low-latency updates → consider HTAP (e.g., fraud detection), but keep the warehouse for cross-system joins.
- Predictable load + existing ops expertise → self-host. Spiky load or no expertise → cloud. Latency-critical hardware control → self-host.
- Default to a single node; distribute only for a concrete reason from the list above.
- Few teams → monolith. Many teams needing independence → microservices, and accept the operational overhead.
- Before storing personal data, weigh breach/legal/safety risk against value; prefer minimization.

## How This Connects

- Ch. 2 (referenced as pages 37, 43, 49): performance description, reliability/fault tolerance, scalability — the nonfunctional requirements behind several trade-offs here.
- Ch. 3: relational model and SQL underpinning warehouses; star/snowflake schemas for analytics.
- Ch. 4: OLTP vs. OLAP internal storage layouts; how cloud databases use object storage; single-node analytics.
- Ch. 5: data encoding (Avro, Parquet); API evolution (OpenAPI, gRPC); REST/RPC dataflow.
- Ch. 6: replication and consistency mechanisms.
- Ch. 8: rigorous definition of transactions; distributed transactions.
- Ch. 9: distributed system failure modes (timeouts, unsafe retries).
- Ch. 11: data pipelines for integrating multiple systems and propagating updates to derived data.
- Ch. 12: event streams for analytics.
- Ch. 14: ethics, legal compliance, bias and discrimination in depth.
