# Chapter 1: Trade-Offs in Data Systems Architecture — Examples

Every meaningful example, scenario, and illustration from the chapter, retold compactly.

## Commercial transactions as the origin of "transaction"

In early business data processing, a database write typically corresponded to money changing hands: making a sale, placing an order with a supplier, paying an employee's salary. Databases later expanded to social media posts, game moves, address book contacts, and much more, but the term "transaction" stuck for a group of reads and writes forming a logical unit, and the access pattern stayed the same — look up a few records by key (a point query), then insert, update, or delete based on user input. Because these applications are interactive, the pattern became known as online transaction processing (OLTP).

Demonstrates: where the OLTP term and access pattern come from — business transactions whose shape persisted long after the money left the picture.

## Supermarket analyst's queries

A business analyst at a supermarket chain wants answers like: total revenue per store in January; how many more bananas than usual sold during the latest promotion; which brand of baby food is most often bought together with brand X diapers. Each query scans a huge number of records and computes aggregates (counts, sums, averages) rather than returning individual records, and the results feed business intelligence reports that guide management decisions.

Demonstrates: the OLAP access pattern — scan-and-aggregate over history — versus OLTP's key-based point queries.

## Recommendation, risk scoring, and spam filtering as data-science output

Data scientists build user-facing features powered by analysis and ML: "people who bought X also bought Y" recommendations on an ecommerce site, predictive risk scoring, spam filtering, and search-result ranking. Later in the chapter the recommendation example returns: a model trained on analytical-system data gets deployed into production to serve end users, illustrating reverse ETL (analytics outputs flowing back into operational systems), with tools like TFX, Kubeflow, and MLflow handling deployment.

Demonstrates: analytics is not only internal reporting; its outputs can become operational features via reverse ETL.

## The enterprise with hundreds of OLTP systems

A large enterprise runs dozens or hundreds of separate OLTP systems: the customer-facing website, point-of-sale checkout in physical stores, warehouse inventory tracking, vehicle route planning, supplier management, employee administration. Each is complex, has its own maintaining team, and runs mostly independently. Analysts cannot usefully query these directly — the data sits in silos, the schemas suit transactions rather than analytics, heavy queries would hurt production, and the systems may be network-isolated for security. So data from all of them is ETL'd into a single data warehouse where analysts can combine it in one query.

Demonstrates: why data warehouses exist, and why one warehouse serves many operational databases.

## ETL from external SaaS products

Some ETL sources are not your own databases but external SaaS systems — CRM, email marketing, credit card processing — accessible only through the vendor's API. Copying that data into your own warehouse enables analyses the SaaS API alone cannot support. Specialist connector services such as Fivetran, Singer, and Airbyte implement this kind of ETL.

Demonstrates: ETL generalizes beyond in-house databases; warehouse centralization unlocks analyses across vendor boundaries.

## Fraud detection as an HTAP workload

Fraud detection can require both analytical queries that scan many rows (finding patterns of abuse) and low-latency reads and updates of individual records. This is the kind of single application where hybrid transactional/analytical processing (HTAP) is genuinely useful — though HTAP still does not replace the warehouse, whose job is combining data from many systems.

Demonstrates: the niche where HTAP fits — one application needing both OLTP and OLAP access patterns.

## Data scientists' work that doesn't fit SQL

Two tasks show why a relational warehouse poorly serves data scientists: (1) feature engineering — turning table rows and columns into numerical vectors or matrices to train an ML model, which needs custom code awkward to express in SQL; (2) extracting structured information from unstructured data, such as sentiment and topics from product review text via NLP, or information from photos via computer vision. Data scientists therefore prefer Pandas, scikit-learn, R, and Spark, which led organizations to build data lakes holding raw files in any format.

Demonstrates: the motivation for data lakes — schemaless, file-based storage for workloads SQL can't express.

## The cache as the classic derived data system

A cache serves data when present; on a miss, you fall back to the underlying database and can repopulate the cache. If the cache is lost entirely, nothing is gone — it can be rebuilt from the source. Indexes, materialized views, denormalized values, and trained ML models share this property. The database the data was first written to is the system of record; the cache and friends are derived.

Demonstrates: the system-of-record vs. derived-data distinction — derived data is redundant but rebuildable, and it exists for read performance.

## "Most companies don't fabricate their own CPUs"

As an extreme illustration of build-vs-buy, companies buy CPUs from semiconductor manufacturers rather than fabricating their own, because buying is cheaper. The rule of thumb: keep in-house what is a core competency or competitive advantage; outsource the routine and commonplace.

Demonstrates: the build-vs-buy principle that frames the entire cloud vs. self-hosting decision.

## Self-hosting MySQL as the middle of the outsourcing spectrum

Downloading MySQL and installing it on a server you control exemplifies the middle ground between bespoke in-house software and fully managed cloud services: off-the-shelf software, self-deployed. The server could be your own hardware ("on premises," even if it's a rented datacenter rack) or a cloud VM (IaaS). Running a modified version of open source software is yet another point on the spectrum.

Demonstrates: outsourcing is a spectrum over two separate decisions — who writes the software and who operates it.

## Variable-load analytics as the cloud's best economic case

A large interactive analytical query needs a lot of parallel computing resources for a short burst; once it finishes, those resources idle until the next query. Scheduled report queries can be queued to smooth load, but interactive queries get spikier the faster you want answers. If you bought machines for peak load they would sit idle most of the time; in the cloud you return unused resources to the provider. For smaller datasets the difference is less significant.

Demonstrates: elasticity pays off in proportion to load variability; cloud economics favor spiky workloads.

## High-frequency trading needs its own hardware

Very latency-sensitive applications like high-frequency trading require full control over hardware, which no cloud service provides. Such specialist requirements — along with pre-cloud legacy systems — are why in-house systems will persist even as cloud adoption grows.

Demonstrates: the limit of cloud services — loss of control is unacceptable for some workloads.

## Snowflake built on S3, and services built on Snowflake

Object storage services (Amazon S3, Azure Blob Storage, Cloudflare R2) expose a limited file API but hide physical machines, distribute data automatically, and lose nothing when disks or machines fail. Snowflake, a cloud data warehouse, stores its data in S3 rather than managing disks itself; other services in turn build on Snowflake. Higher layers are more use-case specific: use an existing high-level service if it fits, compose lower-level ones if not.

Demonstrates: cloud native layering — higher-level services built from lower-level cloud services.

## Virtual disks vs. purpose-built storage

Cloud virtual disks (Amazon EBS, Azure managed disks, GCP persistent disks) are not physical disks but services on separate machines emulating a block device (typically 4 KiB blocks). They let traditional disk-based software run unmodified in the cloud, but every I/O becomes a network call, making applications sensitive to network glitches, and emulation adds overhead. Cloud native databases avoid them: since database rows are far smaller than the hundreds-of-KB-to-GB files object stores are built for, they keep small values in a dedicated service and pack many values into large blocks stored in an object store.

Demonstrates: separation of storage and compute, and why software designed for the cloud beats disk-era software run on emulated disks.

## Metered cloud storage replaces capacity planning

Traditional ops monitored disk space and added disks before running out. Cloud storage presents an API that hides machines: you store data without planning capacity and pay for what you use. The same shift reaches code execution with serverless/FaaS — no provisioning, billing by execution time. But the work doesn't vanish: capacity planning becomes financial planning, performance optimization becomes cost optimization, and quotas (e.g., maximum concurrent processes) still need planning before you hit them.

Demonstrates: the cloud transforms rather than eliminates operations work.

## A single-threaded program beating a 100+ core cluster

Cited research ("Scalability! But at What COST?") found cases where a simple single-threaded program on one computer significantly outperformed a cluster with over 100 CPU cores; in the same passage the chapter notes that calling another service over the network is vastly slower than calling a function in the same process. Combined with ever-larger, faster, more reliable CPUs, memory, and disks — and single-node databases like DuckDB, SQLite, and KùzuDB — many workloads should simply stay on one machine.

Demonstrates: more nodes are not always faster; prefer single-node until you have a concrete reason to distribute.

## Hardware specialization across services

Different parts of a distributed system can run on hardware matched to their workload: an object store uses machines with many disks and few CPUs; a data analysis system uses machines with abundant CPU and memory and no disks; an ML system uses GPU machines, which are far more efficient than CPUs for training deep neural networks.

Demonstrates: specialized hardware as a legitimate reason to distribute a system.

## Data residency laws force geographic distribution

Some countries legally require that data about their residents be stored and processed within the country. Scope varies — sometimes only medical or financial data, sometimes broader. A service with users in several such jurisdictions must distribute data across servers in multiple locations regardless of technical preference.

Demonstrates: legal compliance as a non-technical driver of distributed architecture.

## Chasing renewable power

If jobs are flexible in time and place, they can run where and when renewable electricity is plentiful and avoid times when the grid is strained — cutting carbon emissions and exploiting cheap power.

Demonstrates: sustainability as an emerging reason to distribute workloads geographically and temporally.

## S3 as a microservice with one purpose

In a microservices architecture each service has one well-defined purpose; S3's purpose is file storage. Each service exposes a network API and has one owning team. The chapter uses S3 as the model example of a sharply scoped service.

Demonstrates: the microservice ideal — one purpose, one API, one team.

## Shared databases break service independence

If two services share a database, the database structure effectively becomes part of each service's API and becomes very hard to change; one service's queries can also degrade the other's performance. Hence the practice of giving each service its own database — which in turn makes cross-service consistency the application's problem, since distributed transactions are rarely used with microservices (they recouple services and many databases lack support).

Demonstrates: why service-per-database is standard, and the consistency cost it imposes.

## API field changes breaking clients late

Developers add or remove fields in a microservice API as business needs change, but clients expect specific fields and fail when they change. Worse, the failures often surface only when the updated API reaches staging or production. API description standards (OpenAPI, gRPC) help manage client/server compatibility.

Demonstrates: API evolution is a major hidden cost of microservices.

## Supercomputer failure handling vs. cloud failure handling

A supercomputer runs large batch jobs (weather forecasting, climate modeling, molecular dynamics, optimization, PDE solving) that periodically checkpoint state to disk. When a node fails, a common solution is to stop the entire cluster, repair the node, and restart from the last checkpoint. For a cloud service, stopping the entire cluster is usually not desirable, since it needs to continually serve users with minimal interruption. The two worlds also differ in networking (trusted shared-memory/RDMA vs. mutually untrusting tenants needing VMs, encryption, authentication), topology (meshes/toruses vs. Clos/IP/Ethernet), and geography (co-located vs. multi-region).

Demonstrates: fault-tolerance strategy follows workload — batch jobs can restart; always-on services must degrade gracefully.

## Social media, elections, and automated decisions

Even where no regulation applies, data systems affect people and society. Social media changed how individuals consume news, which influences their political opinions and hence may affect election outcomes. Automated systems increasingly make decisions with profound consequences for individuals: who gets a loan or insurance coverage, who is invited to a job interview, who is suspected of a crime.

Demonstrates: why everyone working on data systems shares responsibility for ethical impact, beyond mere legal compliance.

## Location data revealing criminalized behavior

Where behavior is criminalized — homosexuality in several Middle Eastern and African countries, abortion-seeking in several US states — stored data becomes dangerous. A visit to an abortion clinic could be revealed by location data or even a log of a user's IP addresses over time, which indicates approximate location. Governments and police can compel companies to hand data over. This is why the true cost of data includes user safety risk, and why some data is simply not worth storing.

Demonstrates: data minimization (Datensparsamkeit) — delete or never collect data whose risks exceed its value.

## Right to be forgotten vs. append-only logs

GDPR grants individuals the right to have their data erased on request. But many data systems are built on immutable constructs like append-only logs — how do you delete a record from the middle of a file designed never to change? And how do you delete data already incorporated into derived datasets, such as ML training data? The regulation deliberately names no technologies, only principles, so these remain open engineering problems.

Demonstrates: legal requirements reach into core data-structure design choices and create unsolved engineering challenges.

## PCI and SOC 2 audits

Credit card companies require payment processors to meet Payment Card Industry (PCI) standards, verified by frequent independent audits. Software buyers increasingly require vendors to meet SOC 2 standards, also verified by third-party audits.

Demonstrates: beyond government regulation, industry compliance regimes with recurring audits shape data system requirements.
