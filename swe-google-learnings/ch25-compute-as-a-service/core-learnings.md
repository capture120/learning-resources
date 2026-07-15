# Chapter 25: Compute as a Service

*Software Engineering at Google* — written by Onufry Wojtaszczyk, edited by Lisa Carey.

## Chapter Thesis

After you write code you need hardware to run it, and "Compute as a Service" (CaaS) is the idea of turning that hardware into a service: an engineer says "just give me the resources to run my stuff" and a managed system handles machine assignment, failure recovery, isolation, and scaling. The chapter traces how Google evolved from manually SSHing into lab machines to Borg (Google's internal cluster manager and the precursor of Kubernetes and Mesos), and argues that surviving organizational growth requires progressively automating toil, packing many isolated workloads onto shared machines, and — critically — changing how engineers write software so that individual servers are replaceable "cattle" rather than hand-nursed "pets." It closes with the trade-offs an organization faces when choosing its own compute service: centralization versus customization, containers versus serverless, and public versus private cloud, all under the shadow of heavy lock-in.

## Core Principles and Ideas

### Automation of toil

- The naive deployment model — copy a binary to each machine over SFTP, SSH in, compile, run, and watch it by hand — works for one machine but collapses at scale. Deployment, monitoring, restart-on-failure, and health checking must all be automated as the fleet grows.
- **Automated scheduling** is the first true "service" in CaaS: a central service that knows the full list of available machines, picks unoccupied ones on demand, and deploys binaries to them. It replaces hand-maintained "sign-up files" for machine reservations. It also enables automatic reaction to machine failure: detect a broken machine (e.g., by scanning logs for disk errors), stop scheduling onto it, attempt automated fixes (reboot, disk scan) before involving a human, and reschedule lost work onto healthy machines.
- Organizations grow along three axes: the number of different applications, the number of copies of each application, and the size of the largest application. Automation must cover all three, and the automation itself must keep growing in sophistication (e.g., Borg later had to learn GPU/TPU scheduling; Google moved datacenter turn-up from a weeks-long manual specialist process to a fully automated one).

### Containerization and multitenancy

- **Multitenancy** means running many different teams' workloads on the same shared pool of machines. A one-to-one mapping of programs to machines wastes resources, so programs declare their resource needs (CPU, RAM, disk) and a scheduler **bin-packs** replicas onto machines.
- Sharing machines requires **isolation**: a guarantee that one tenant's process cannot disturb another's. Without it, a job that exceeds its declared resources causes latency blips (CPU) or out-of-memory kills (RAM) for its neighbors; programs also collide on dependency versions, shared paths like /tmp, and security boundaries.
- Virtual machines (VMs) provide isolation but carry heavy overhead: each runs a full operating system, costing resources and startup time. Borg's designers (2003) instead built **containers** — a lightweight isolation mechanism based on cgroups (contributed to the Linux kernel by Google engineers in 2007), chroot jails, bind mounts, and union/overlay filesystems. Docker and LMCTFY are open source container implementations.
- Isolation is never finished. New isolation failures keep being discovered over time (the canonical example is process-ID space exhaustion, covered in examples.md).
- **Rightsizing and autoscaling**: asking humans to specify resource requirements is flawed because humans don't naturally reason about those numbers, the numbers rot as programs grow, and the eroding slack eventually causes an outage during a spike. Automating these parameters is surprisingly hard — Google only recently crossed the point where more than half of Borg fleet resource usage is set by rightsizing automation — but it covers the majority of *configurations*, freeing most engineers from the chore. This embodies "easy things should be easy, and complex things should be possible."

### Cattle, not pets — architecting for failure

- **Pets vs. cattle** (metaphor attributed to Bill Baker, popularized by Randy Bias): a *pet* server is unique and hand-configured; when it breaks a human diagnoses and nurses it back to health. *Cattle* servers are named replica001–replica100; when one fails, automation removes it and stamps out an identical replacement with no human involvement. The defining trait of cattle is that a new instance can be created fully automatically.
- Pets make maintenance burden grow linearly or superlinearly with fleet size. Cattle enable **self-healing**: the system returns to a stable state after failure on its own. The book calls the cattle/flexible-scheduling model fundamental to Google's success over the past 15 years.
- Cattle alone are not enough — the *architecture* must tolerate a moderate ongoing failure rate. For batch work: split the job into many small chunks assigned dynamically, so a killed worker loses at most one chunk instead of forcing a restart of its whole static share. For serving work: the scheduler warns a container before rescheduling it, the container drains (finishes in-flight requests, refuses new ones), and the load balancer understands the "not accepting requests" response.

### Batch versus serving jobs

- **Batch jobs** run to completion (log analysis, ML model training); they care about throughput, are short-lived (minutes to hours), and can usually be killed without warning since lost processing can be redone. Google's canonical batch frameworks were MapReduce and later Flume.
- **Serving jobs** run indefinitely and answer incoming requests (e.g., serving search queries); they care about per-request latency, are long-lived, and often have long startup times. Serving work is naturally chunked into individual requests, which suits the cattle model — but serving jobs need throttled rescheduling (killing 50% of a batch job's replicas is a blip; killing 50% of a serving job's replicas is an outage) and advance warning before termination.
- Serving anti-patterns that break the cattle model: a singleton "leader" holding system state that a replacement cannot re-create; static sharding of data across N servers so one server's death loses part of the data; and being addressed by hardcoded hostname.

### Managing state

- Treat all in-process and local state as **transient**; "real" storage lives off-machine in durable, persistent storage systems. If all local state is immutable, failure resistance is nearly free.
- The persistent storage systems themselves should also be cattle, achieved through **state replication** — typically 3–5 replicas of each piece of data with consensus for writes. RAID is the same concept at the disk level. This is hard to build, which is why Google built specialized storage systems (GFS, Bigtable, Spanner) that let everyone else treat state as transient.
- Legitimate uses of local storage by cattle: caches (transient state kept for latency wins), warm-up data pulled from external storage at startup, and batched writes (for data that can tolerate partial loss or can be re-created, e.g., monitoring samples). Long computations can be made restartable via periodic checkpointing to persistent storage.
- Key caching lesson from Google production: **provision the cache to meet latency goals, but provision the core application to carry the total load** — so losing the cache layer degrades latency instead of causing an outage. This redundancy has a real cost and is a conscious trade-off.

### Connecting to a service

- Since replicas move between machines, clients must not hardcode hostnames. **Service discovery** adds a layer of indirection: clients resolve a durable identifier that the scheduler updates when it places the job; load balancing further decouples clients from specific backends.
- Requests must sometimes be retried because a backend may be killed mid-request — even for "internal" calls like server-to-database. Retries need backoff and jitter and belong in the RPC library, not hand-rolled per developer.
- Mutating requests need **idempotency**: issuing a request twice must equal issuing it once. A useful tool is **client-assigned identifiers** — the client names the thing it is creating, so a duplicate request with the same identifier is recognized and reported as success.
- A scheduler can lose contact with a machine, reschedule its work, and then the machine returns — leaving two live instances both believing they are "replica072." The address-resolution system arbitrates which is real; this is another reason idempotency matters.

### One-off code

- Engineers also need compute for one-off analyses, prototypes, and ad hoc pipelines. A distributed run over a few hundred cores can turn a day-long analysis into minutes; for iterative work this is the difference between done today and never done.
- A thousand core-hours costs far less than a day of engineering time, so gatekeeping compute behind approval processes usually destroys more value than it saves (the book compares compute to office markers). But compute differs from markers: it's easy to grab a thousand machines by accident, so quotas are warranted. Google's variant: near-unlimited quota for *low-priority batch*, which runs effectively for free in serving jobs' slack.

### Containers as an abstraction

- Beyond isolation, containers form an **abstraction boundary between the software and the machine**. When machines change, only the container layer (owned by one team) adapts; application software across the whole organization stays untouched.
- A **filesystem abstraction** lets an organization onboard software it didn't write (open source, acquisitions) without customizing machine configurations fleet-wide, and lets software prepackage its dependencies at pinned versions instead of leaking dependency choices onto every machine.
- Containers also virtualize **named resources**, canonically network ports. Borg initially didn't, so Google's C++ codebase accumulated 20,000+ calls to PickUnusedPortOrDie; Docker gave each container a virtual-private network interface; Kubernetes gives each pod a real IP so every app can listen on any port.
- **Hyrum's Law** (any observable behavior of a system will be depended upon by somebody) hits container abstractions especially hard, because every production program is a user and users don't think of the filesystem or PID space as an API. Lesson: prefer a container system built and battle-tested by a broad community, where these leaks have already been found and fixed.

### One service to rule them all

- Unifying all workloads — batch and serving — into a single shared pool under one compute service (Borg; the open source analog is one large Kubernetes cluster per location rather than a cluster per workload) yields two big wins:
  1. **Management does not scale with team count.** Machines become anonymous ("programs don't care which machine they run on as long as it has the right characteristics"), and there is one management practice instead of N diverging ones, keeping org-wide changes (new server architecture, datacenter moves) feasible.
  2. **Batch and serving needs are complementary.** Serving jobs must be overprovisioned to absorb spikes and outages, so their machines sit underutilized (e.g., 30% real use). Batch jobs soak up the reserved-but-idle capacity, and get reclaimed (CPU frozen, RAM killed) the moment serving jobs need it. Batch cares only about aggregate throughput and its replicas are cattle, so it tolerates this happily. At Google, batch effectively runs for free.

### Submitted configuration

- Drive the scheduler from **configuration checked into a repository in a dedicated configuration language**, not from CLI invocations remembered in docs or heads (documentation and tribal knowledge rot), and not from ad hoc wrapper scripts.
- A real service sprawls over time: multiple datacenters, staging/dev/prod variants, attached companion services (e.g., a memcached). A standardized configuration language expresses this and standard operations ("update to the new binary taking down at most 5% of capacity at a time"), enables shared reusable config across teams (so org-wide swaps like replacing the memcache implementation stay possible), and is a prerequisite for automated deployment / continuous delivery.

### Choosing a compute service

- Almost no organization should build its own; choose among open source (Kubernetes, Mesos; higher-level: OpenWhisk, Knative) and public cloud managed offerings (VM autoscaling like GCE Managed Instance Groups / EC2 autoscaling, managed containers like GKE / AKS, serverless like AWS Lambda / Cloud Functions).
- **Compute choices have a very high lock-in factor**, for two reasons: Hyrum's Law (code will come to depend on every observable property of the chosen system — if the architecture permits treating VMs as pets, teams will) and the **ecosystem of helper tools** (logging, monitoring, debugging, alerting, config languages, UIs) that accretes around the choice and would all need rewriting.
- **Centralization vs. customization**: one CaaS for the whole fleet with one shared toolset is cheapest to manage and most resource-efficient, but a growing organization has genuinely divergent needs (Google's examples: Cloud VMs that are customer pets, and the Search long-tail index that needed to survive disk failure in place). Each accommodation bifurcates the platform and bloats the API surface until behavior combinations become untestable; the recurring hard question is "expand the API for this user, or inconvenience the user and keep coherence?" Whitelisting/allow-listing power-user features limits the spread. Also: track feature usage — Borg's cleanup found features nobody used at all.
- **Serverless**: in a serverless offering the *framework servers themselves* are multitenant — teams write only stateless handlers/actions, and the provider dynamically loads action code onto shared framework servers and routes requests; no team runs servers. Fair comparison is against persistent containers (Borg/Kubernetes), not against pet VMs. Pros: scale-to-zero (cost scales with traffic at the low end), finer and more reactive scaling, far less management for a single small team. Cons: requires truly stateless code (no local state across requests, everything set up request-scoped — most organizations have workloads this cannot serve), and loss of control over the environment. Google chose *not* to invest heavily in serverless: Borg already delivers most serverless benefits, overprovisioning small services is cheap, and one unified architecture that can also run stateful giants (GCE, BigQuery, Spanner) beats a split stack. For a small team, though, a public serverless offering is far simpler and cheaper than standing up an unshared cluster — shared-cluster costs only amortize when the cluster is truly shared. Prefer serverless options with a break-out path (Knative → Kubernetes) since growing organizations tend to outgrow pure serverless.
- **Public vs. private**: a public cloud outsources management overhead to a provider with pooled expertise, and raises the abstraction level of scaling (from signing colocation leases, to CLI-provisioned VMs, to autoscaling) — especially valuable when resource needs are unpredictable. The lock-in fear is real (the serverless provider Zimki shut down in 2007 with three months' notice). Mitigations, in increasing strength: run on open source architecture (e.g., managed Kubernetes) so a migration path exists (imperfect, per Hyrum's Law); run an open source higher-level stack on a low-level cloud offering (e.g., Knative on EC2) so your tooling and tweaks move with you; run **multicloud** (the same open source stack on two providers, e.g., GKE + AKS); or run **hybrid cloud** (private infrastructure plus public-cloud overflow). Multicloud and hybrid both require direct network connectivity between environments and common APIs on both sides.

## Actionable Guidance

- Automate deployment, monitoring, health-checking, restart, and machine assignment before fleet growth forces it; replace any hand-maintained machine sign-up list with a scheduler.
- Design every service so a new replica can be stamped out with zero human setup; if creating an instance requires manual steps, you have a pet.
- Split batch work into many small dynamically-assigned chunks; never statically partition work across workers.
- Handle the scheduler's termination warning: drain in-flight requests, refuse new ones, and make your load balancer honor that signal.
- Keep all durable state in replicated external storage; treat local disk and memory as ephemeral. Checkpoint long computations.
- Provision caches for latency but the uncached path for total load, so cache loss degrades rather than breaks the service.
- Never hardcode hostnames; use service discovery and load balancing. Make mutating APIs idempotent, ideally via client-assigned identifiers. Put retry logic (with backoff and jitter) in the RPC library.
- Give engineers generous compute for one-off work — a quota-guarded free tier of low-priority batch beats an approval process, because engineer time costs far more than core-hours.
- Declare per-program resource requirements and pursue rightsizing/autoscaling automation; automating even just the easy majority of configurations pays off.
- Keep service configuration in a standardized configuration language in version control; build shared config templates for common companions (caches, etc.) so org-wide changes stay possible.
- Consolidate onto a single shared compute platform per organization (or per region) covering batch and serving; co-schedule batch into serving slack with reclamation.
- Gate power-user platform features behind allow-lists, and monitor feature usage so you can prune dead API surface.
- When choosing a platform, weigh lock-in explicitly; prefer widely adopted community systems (Kubernetes) and serverless products with a break-out path.

## The Chapter's TL;DRs (verbatim)

- Scale requires a common infrastructure for running workloads in production.
- A compute solution can provide a standardized, stable abstraction and environment for software.
- Software needs to be adapted to a distributed, managed compute environment.
- The compute solution for an organization should be chosen thoughtfully to provide appropriate levels of abstraction.
