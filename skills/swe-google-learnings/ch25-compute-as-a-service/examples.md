# Chapter 25: Compute as a Service — Examples, Case Studies, and Anecdotes

All examples below come from Chapter 25 of *Software Engineering at Google*, retold in plain language. Each entry is self-contained.

## Jeff Dean's 2002 "logistical nightmare" and the Global WorkQueue

**Setup.** In 2002 Google ran an automated data-processing task as part of its release process the way a university student of that era would: copy the binary to each machine, log in, start it, and watch it. Jeff Dean, one of Google's most senior engineers, described the process in a design document.

**What happened.** Running the task required getting a list of 50+ machines, starting a process on each of the 50+ machines by hand, and monitoring progress on each of the 50+ machines individually. Nothing migrated the computation elsewhere if a machine died, monitoring was ad hoc, and because processes on shared machines interfered with each other, a complicated human-maintained "sign-up" file throttled machine use — producing poor scheduling and contention for scarce machines.

**Lesson.** The naive SFTP-and-SSH deployment model that works for one machine becomes unmaintainable at the scale of dozens, and the pain points it creates (manual deployment, manual monitoring, manual failure migration, human-mediated machine reservation) are exactly the feature list of a compute service. This document was the trigger for the Global WorkQueue, Google's early internal Compute-as-a-Service system for batch workloads, and the starting point of the road to Borg.

## Automating away each piece of toil (deployment, monitoring, restart, scheduling, repair)

**Setup.** The chapter walks through how each manual step in the naive model gets automated in sequence, as a template any organization follows.

**What happened.** Deployment to 50+ machines becomes a parallel deployment script. Monitoring becomes exported metrics ("process is alive," "documents processed") flowing to a dashboard — today's equivalents are Prometheus or Grafana. The manual fix ritual (SSH in, kill the process, restart it) becomes an on-machine agent that detects anomalies ("no liveness report for five minutes") and kills the process, plus a `while true; do run && break; done` wrapper to restart it — the cloud equivalent is an autohealing policy that re-creates a VM or container after a failed health check. Machine assignment becomes a central scheduler that knows every machine and picks free ones on demand, replacing the sign-up file. Failure handling extends the scheduler: scan machine logs for signals like mass disk-read errors, stop scheduling onto sick machines, try automated fixes (reboot, disk scan) before paging a human, and reschedule lost work onto fresh machines.

**Lesson.** Each automation step systematically removes a class of toil that grows with fleet size; at one machine SSH is perfect, at thousands automation must take over or the organization collapses under the load.

## The million-document batch job (architecting for failure)

**Setup.** An engineer must validate one million documents, at one second each. One machine would take about 12 days, so the work is sharded across 200 machines, cutting the runtime to roughly 100 minutes. But in a managed compute world, the scheduler (Borg) may unilaterally kill any of the 200 workers and move it to another machine.

**What happened.** With static sharding (each worker owns 1/200th of the documents), every worker death costs up to 50 minutes of lost progress, and with 200 machines such deaths are likely, possibly repeatedly. The fix is to restructure: divide the million documents into 1,000 chunks of 1,000 documents; each worker finishes a chunk, reports the result, and grabs another. A worker death now loses at most one chunk (the one finished but not yet reported). This dynamic-assignment pattern matched Google's data-processing standard of the era (MapReduce, later Flume).

**Lesson.** Making servers "cattle" (automatically replaceable) is necessary but not sufficient; the application architecture itself must tolerate a steady failure rate, which for batch work means small dynamically-assigned work chunks.

## Draining serving jobs before rescheduling

**Setup.** For a user-facing service, a rescheduled container should not translate into errors served to users.

**What happened.** Borg's scheduler signals its intent to a container before rescheduling it for maintenance. The container reacts by refusing new requests while finishing the requests already in flight; the load-balancing layer must in turn understand the "I cannot accept new requests" response and steer traffic to other replicas.

**Lesson.** Graceful failure handling for serving jobs is a contract spanning scheduler, application, and load balancer — all three must cooperate.

## The duplicated "replica072" (split-brain after a network partition)

**Setup.** The scheduler monitors machines over the network and reschedules work from machines it believes are dead.

**What happened.** The scheduler lost contact with a machine due to a network problem, declared its work lost, and rescheduled it elsewhere — then the original machine came back online. Two programs on two machines both believed they were "replica072," performing the same work and serving the same role.

**Lesson.** Disambiguate via the address-resolution (service discovery) system — whichever instance the resolver points at is real and the other must terminate — and design for idempotency, because duplicated replicas are one more source of duplicated requests. Relatedly, the chapter recommends client-assigned identifiers for mutating requests (e.g., the client names its pizza-delivery order, so a server seeing the same order ID twice reports success instead of creating a duplicate order).

## The 1 GB vs. 1 TB log analysis (one-off code needs big compute)

**Setup.** An engineer wants to check whether a suspicious log line A always precedes error line B.

**What happened.** For 1 GB of yesterday's logs, the workstation suffices: download, write a short Python script, wait a minute or two. For 1 TB spanning a year, the same approach takes about a day. A compute service running the analysis on a few hundred distributed cores returns the answer in minutes — and for iterative investigations where the query must be refined after seeing results, that is the difference between done today and never done.

**Lesson.** Give engineers easy access to distributed compute for one-off work; a thousand core-hours costs far less than a day of engineer time (the book compares hoarding compute to locking up office markers).

## Accidental thousand-machine jobs (why quotas exist)

**Setup.** Compute differs from office markers in one way: it's easy to take far too much by accident.

**What happened.** At Google this happened multiple times — someone left load-testing infrastructure occupying a thousand Google Compute Engine VMs while on vacation, and a new employee debugged a master binary on their workstation without realizing it was spawning 8,000 full-machine workers in the background.

**Lesson.** Generous access needs quota guardrails. Google's twist: since low-priority batch runs effectively for free in the slack of serving jobs, engineers get nearly unlimited quota for low-priority batch, which covers most one-off needs.

## PickUnusedPortOrDie: ports as an unmanaged named resource

**Setup.** A container can manage the machine's named resources — network ports being the canonical example — or leave applications to fight over them.

**What happened.** Borg's early container abstraction did not include network ports, so every binary had to hunt for a free port itself. The helper function `PickUnusedPortOrDie` accumulated more than 20,000 usages in Google's C++ codebase. Docker, built after Linux namespaces existed, gives each container a virtual-private network interface so applications can listen on any port, with the networking stack mapping machine ports to in-container ports. Kubernetes goes further and requires the network to treat each pod as a real IP address on the host network.

**Lesson.** Resources left outside the abstraction leak into every application (especially third-party software with inconsistent port configuration), and the debt shows up as tens of thousands of workaround call sites.

## PID exhaustion and Hyrum's Law inside the container abstraction

**Setup.** In Linux, process IDs are assigned in the range 0 to PID_MAX − 1, where PID_MAX defaults to 32,000. In 2011, Borg engineers found that a single thread-leaking job could exhaust the machine-wide PID space, breaking isolation for every neighbor.

**What happened.** The obvious fix — raise PID_MAX via a configuration change — failed because of Hyrum's Law (any observable behavior will be depended on): teams had come to rely on PIDs fitting in five digits, and log-storage processes broke on six-digit PIDs because record names exceeded a length limit. The fix became a multi-phase project: (1) cap the PIDs any single container may use, so one leaking job can't take down the machine; (2) split the PID space between threads and processes, since almost nobody depended on the 32,000 bound for thread IDs, allowing the thread limit to rise while processes kept 32,000. Phase (3), giving each container its own PID namespace, hit Hyrum's Law again: many systems assumed the triple {hostname, timestamp, PID} uniquely identifies a process, which PID namespaces would break. Eight years later the effort to find and fix those assumptions was still ongoing.

**Lesson.** The point is not "use PID namespaces" (they didn't exist when Borg was designed, and no 2003 designer could have foreseen them). The point is that container isolation is never complete, undiscovered leaks always remain, and therefore it pays to use a container system built and maintained by a broad community where these failures have already been hit and the lessons absorbed.

## Batch soaking up serving slack (why one shared pool wins)

**Setup.** Originally Google ran batch jobs in the shared WorkQueue pool while each serving job had its own dedicated machine pool. The Borg project (started 2003) merged everything into one pool per datacenter — the open source equivalent of one large Kubernetes cluster per location instead of a cluster per workload.

**What happened.** Two gains materialized. First, serving machines became cattle ("machines are anonymous: programs don't care which machine they run on as long as it has the right characteristics"), eliminating per-team pool administration and the divergence of management practices that makes company-wide changes ever harder. Second, serving jobs must be overprovisioned for spikes and outages, so a machine "full" of serving reservations may really use only 30% of its capacity; Borg schedules batch jobs into the idle 70% and reclaims resources when serving needs them — freezing batch tasks to take back CPU, killing them to take back RAM. Batch cares only about aggregate throughput and its replicas are cattle, so it absorbs this treatment happily.

**Lesson.** Batch and serving needs are complementary: in a shared pool, either batch runs effectively for free (Google's usual case) or serving pays only for what it uses. Unification also caps management overhead at one practice instead of one per team.

## Google Compute Engine on Borg: when cattle assumptions meet customer pets

**Setup.** When Google launched Google Compute Engine (its public "VM as a Service" cloud) in 2012, each customer VM ran inside a Borg container like everything else at Google.

**What happened.** Borg's cattle model — kill and reschedule containers at will — was wrong for this workload, because each container held a customer's VM, and customers treat their VMs as pets (one customer's mail server is not interchangeable with another's rendering job). Both sides had to change: the Cloud organization built live migration of VMs (copy a running VM to another machine, bring the copy into perfect sync, redirect traffic with no noticeable unavailability), while Borg learned to avoid at-will killing of VM-bearing containers and adapted its scheduling algorithms to minimize the chance rescheduling would ever be needed — since migration is expensive and some customer VMs opt out of live migration entirely. These modifications rolled out only on cloud-workload machines, creating a small but real bifurcation of Google's compute platform.

**Lesson.** A growing organization will hit workloads the centralized platform's assumptions genuinely don't fit; accommodating them costs engineering on both sides and fragments the platform.

## The Search long-tail index and self-managed disk failure

**Setup.** Around 2011, one of the replicated containers serving Google Search web traffic held a giant on-disk index of the less-frequently-accessed portion of the web (common queries were answered from in-memory caches in other containers). Building the index on a machine spanned multiple hard drives and took hours to fill.

**What happened.** Borg at the time assumed that if any disk holding a container's data failed, the container was unusable and must be rescheduled. Combined with spinning disks' relatively high failure rate and the hours-long index rebuild, containers were constantly being torn down and taking forever to come back — severe availability problems. The fix: Borg added an opt-out letting a container handle disk failure itself, and the Search team adapted their process to keep serving with partial data loss.

**Lesson.** Same as the GCE case, from another direction: real workloads force platform customization. Together with other bifurcations (filesystem shape and access, memory control, CPU/memory locality, special hardware, scheduling constraints), Borg's API surface grew large and unwieldy — nobody knew what would happen if a container requested both Cloud's eviction treatment and Search's disk-failure treatment. After 2012 the Borg team spent years cleaning up the API, finding features nobody used (a reminder to monitor feature usage) and features spread accidentally by config-file copying, which they contained via whitelisting for power users. Kubernetes, designed with these lessons but without Borg's legacy user base, started notably cleaner (e.g., its label system) — though it now faces the same pressures at broad adoption.

## The Bash-to-ash swap: lock-in in the smallest details

**Setup.** Borg lets users supply the command to run — usually a binary, but for convenience also a shell script. A binary can be launched with a simple fork-and-exec, but a script needs a shell, so Borg actually ran every command as `/usr/bin/bash -c $USER_COMMAND`.

**What happened.** At Google's scale, the memory consumed by that Bash wrapper was non-negligible, so the Borg team switched the process runner to the lighter shell ash: `/usr/bin/ash -c $USER_COMMAND`. Seemingly zero-risk — both binaries exist in the controlled environment. But some memory-conscious teams had already noticed Bash's overhead and had replaced the Bash binary in their custom filesystem overlays with a tiny "execute the second argument" program. When Borg switched to ash — which those teams had not overridden — their measured memory usage jumped (now including a real shell), alerts fired, the change was rolled back, and unhappiness ensued.

**Lesson.** By Hyrum's Law, users depend on even the most obscure observable details of a compute platform (down to which shell wraps their command), which is why compute choices carry such a high lock-in factor and why "safe" platform changes break people.

## Code Jam's artificial traffic spike (serverless loss of control)

**Setup.** Google Code Jam, a programming contest with thousands of participants, ran its frontend on Google AppEngine, a serverless platform that scales instances with traffic.

**What happened.** Contest traffic arrives as a sudden wall at the starting moment, faster than the platform's reactive autoscaling could handle. The team's workaround: a custom script that hammered the contest page with artificial traffic several minutes before the start, tricking the platform into warming up enough instances for the real load.

**Lesson.** Serverless trades away control of the environment. It worked, but this hand-tweaked hack is exactly the kind of thing choosing a serverless platform was supposed to eliminate — and when the framework lacks a feature you need (here, pre-warming), the problem becomes yours.

## Zimki's shutdown (public cloud lock-in risk)

**Setup.** A worry when adopting a public cloud provider: the provider could raise prices or disappear.

**What happened.** Zimki, one of the first serverless offerings — a Platform-as-a-Service for running JavaScript — shut down in 2007 with only three months' notice.

**Lesson.** Provider risk is real. Mitigations: build on open source architectures (e.g., managed Kubernetes) so a migration path exists; run an open source layer atop a low-level cloud offering (Knative on EC2) so your tooling moves with you; go multicloud (same open source stack on two providers); or run hybrid cloud with public-cloud overflow. None is perfect — Hyrum's Law makes provider-specific dependencies hard to avoid entirely.

## Datacenter turn-up: from weeks of manual work to automation

**Setup.** Ten years before the book, each Google datacenter was a separate, manually managed entity; bringing one up was a specialized, weeks-long, risky manual process even after all machines were physically ready.

**What happened.** As the number of datacenters grew, Google moved to a model where turning up a datacenter is an automated process requiring no human intervention (a transition still being completed as the book was written).

**Lesson.** Automation requirements never stop growing with scale; work that was reasonably manual at a smaller scale must be automated before growth turns it into a collapse point.
