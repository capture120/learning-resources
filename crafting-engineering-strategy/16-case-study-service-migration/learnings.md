# Chapter 16: Service Migration Strategy

This chapter is a full worked case study: the strategy Uber's four-person service provisioning team used in 2014 to migrate 1,000+ services out of a Python monolith onto a new service platform, while the company's 2,000+ engineers doubled every six months. The single most important takeaway: a small team can drive company-wide strategy without any executive sponsor by solving a pressing user problem with good ergonomics — and when you lack the authority to mandate compliance, you must "get the details right," because compliance is rooted in effectiveness. The chapter presents three recreated internal documents (the strategy itself, a systems model of service onboarding, and a Wardley map of the orchestration ecosystem) showing how rigorous diagnosis and modeling led to the conclusion that self-service provisioning was the only viable path.

## Core ideas

### Bottom-up strategy without executive sponsorship

The provisioning team had no executive mandate, yet its strategy reshaped how 2,000+ engineers worked. The mechanism: focus on solving a pressing user problem (engineers desperately wanted out of the monolith and couldn't get services provisioned fast enough) and provide effective ergonomics while doing so. Larson's footnote makes the principle explicit: "when you don't have the authority to mandate compliance, you have to get the details right. The best way to do that is a prolonged strategy testing phase." Because adoption depends on the strategy actually working for users, Larson's experience is that "nonexecutive strategy developers can never stop refining their approach." This is why the strategy includes a standing weekly review of queue size and provisioning time — continuous testing substitutes for authority.

### Diagnosis: growth makes the manual process structurally unworkable

The why behind the whole strategy is a structural mismatch, not an efficiency problem:

- Product teams were leaving the monolith, generating 2–3 provisioning requests per week, expected to grow roughly linearly with product engineering headcount. With the org doubling every six months, that meant 8–12 requests per week within a year.
- The provisioning team was fixed at four engineers, with no expectation of additional headcount. SREs could absorb some nuanced work but were already heavily constrained.
- There was no practical counter-proposal to offer engineers: no team owned the monolith's extensibility, and the monolith was the number one source of developer frustration. Even if infrastructure disagreed with the shift to services, they couldn't redirect it.
- Provisioning took about a week of calendar time, but only 3–4 hours of actual work when all information was present and correct. Missing and incorrect information — the round trips between teams — was the largest source of delay.
- The toolchain (Puppet, Clusto, a wiki page for port allocation) had few safeguards; a careless provisioning step could cause a production outage. Training the whole org on the unsafe toolchain was impractical: with doubling headcount, "even if we train the entire organization perfectly today, there will be just as many untrained individuals in six months."
- It was widely agreed across infrastructure engineering that essentially every component should be replaced, but no team was accountable for replacing them — so the provisioning team had to work around or replace the tooling itself.
- Urgency was asymmetric: unblocking development of a new service was urgent (with escalations to management); moving it to production was rarely urgent. This shaped where to optimize.

### Refinement by systems model: prove which lever actually works

Rather than arguing intuitions, the team built a systems model of the onboarding pipeline and exercised it against candidate solutions. The model produced three load-bearing conclusions:

1. The team was increasingly falling behind — the backlog grows even in the best case.
2. Hiring onto the provisioning team is not a viable solution — even a 500% capacity increase leaves the backlog extremely high, because throughput is capped by the manual pipeline's structure.
3. Moving to self-service is the only option — removing the manual-capacity cap is the only intervention that holds the backlog steady.

Critically, even modeling a 100% success rate (zero errors) still showed an ever-growing backlog. This proved "the problem to be solved is not the service provisioning team's efficiency in running their current process, but rather that the fundamental approach is not working." The model also refined the hiring conclusion: new hires may benefit the team if pointed at building self-service, and if they ramp faster than incoming request growth.

Even before the full model existed, reasoning over the sketch exposed the shape of the problem: product-engineer hiring drives requests up with no counterbalancing infrastructure hiring, creating an "implicit, but very real, deadline" to scale the process independently of the infrastructure team's size. That left exactly three options — stop hiring product engineers, turn provisioning into self-service, or find a new mechanism to discourage service provisioning.

### Exercising models overturns intuition: early errors compound

During sketching, the team assumed Puppet-generation errors mattered most because they caused a long trip backward in the pipeline. Exercising the model (raising each error rate independently from 20% to 50%) showed the opposite: a very high error rate early in the process matters even more, because multiple other potential errors later in the process compound on its increase. This is the chapter's argument for why you must exercise a model rather than just sketch it — the sketch encoded a wrong assumption that only simulation exposed. A related reasoning refinement: error costs differ by coordination boundary. Missing-information errors are more expensive than the model implies because resolving them requires cross-team coordination; Puppet testing errors are probably cheaper than modeled because they should be solvable within one team, benefiting from a quick iteration loop.

### The guiding policies

The strategy's policies (with the Operation section folded into Policy):

1. **Constrain manual provisioning to maximize investment in self-service.** Exactly one full-time engineer on manual provisioning; everyone else builds automation. This deliberately degrades manual provisioning in the short term, because "the alternative is permanently degrading provisioning" under the influx of requests from new hires. Accept a known short-term cost to avoid a permanent structural failure.
2. **Self-service must be safely usable by a new hire without company context.** The existing tooling let a provisioning change break production; the self-service replacement must make that impossible. The why: with headcount doubling, training can never keep up, so safety must live in the tool, not in the operator.
3. **Move to structured requests, out of tickets.** A schema of required fields aims to eliminate the majority of the missing/incorrect-information round trips that dominate delay. This way the team can "get paid twice": it reduces errors in the manual process today and simultaneously becomes the interface for the self-service workflow tomorrow.
4. **Prefer good defaults over required user input.** Teams requesting services are under timeline pressure with little certainty about long-term needs; they cannot accurately predict future requirements, and forcing them to creates friction. Suggest defaults, make settings easy to change later, and use the development-to-production gate as the natural checkpoint where settings get refreshed.

### Explore: position your choice within the ecosystem's evolution

The Explore section (and the Wardley map) situates Uber's decision in industry evolution. Cluster orchestration problems — request routing, service-to-server mapping, deployment, autoscaling — all anchor on cluster metadata and resource scheduling, so that's where investment should concentrate. The industry was solving scheduling via two paths: cloud providers (closed off at Uber by CEO-level opposition to cloud) and open source frameworks (Mesos/Aurora, Kubernetes). The evolutionary pattern: companies with 5+ years of physical infrastructure were near-unanimously adopting open source schedulers (also as a bridge to eventual cloud migration); newer companies skipped the problem by going straight to cloud; only the extraordinarily large (Google, Microsoft) or the change-averse did neither. Conclusion: continuing with Clusto and Puppet meant expensive investment misaligned with where the industry was going.

Evidence-gathering for the bet was concrete: read the foundational papers (Google's Borg paper, the Mesos paper), and canvass people with real operating experience. Uber had ex-Twitter engineers who could "speak with confidence" to running Mesos/Aurora at scale; nobody could be found with production Kubernetes experience on a 10,000+ server fleet. Even Mesos/Aurora's absolute deployment count remained quite small, with no large-scale industry backer outside Twitter — how the two would evolve was an acknowledged unknown. Serverless was noted as a likely future evolution but rejected for now because canvassing found insufficient real-world usage. The heuristic: weight technologies by accessible, verifiable production experience, not by promise or backing alone.

### Strategy is tradeoffs: even successful strategies carry deferred costs

The Summary is candid: this strategy "worked exceptionally well, solving a series of complex problems with a very small team," yet it also "facilitated the introduction of a very difficult developer experience" for engineers building on the resulting service architecture. Larson developed the concept of strategy phases (Chapter 23) specifically to reckon with this legacy — a strategy can work extremely well initially and run into issues later. Acknowledging such tradeoffs is "part of why looking at real strategy documents is so much more valuable than reading press releases."

### Document-craft points

- The standard strategy structure (Chapter 11) can be adapted: this document folds Operation into Policy where that reads better.
- Read order depends on goal: top-to-bottom to apply the strategy; reverse (Explore, then Diagnose, then Policy) to understand the thinking behind it.
- Tools belong where they fit, not where the template says: Wardley mapping is nominally a Refine technique, but here the map fit naturally in Explore because it was used to explore a dynamic ecosystem. "Assembling each strategy requires exercising judgment on how to compile the pieces together most usefully."
- Modeling involves purity tradeoffs: the sketch connects links to stocks rather than flows (technically wrong) because the readable sketch served the audience better; the modeler must "decide what choices best serve your needs in the moment."
- Wardley maps may use artificial aggregates of real teams (e.g., folding the Traffic team into Service Provisioning) when the simplification clarifies the distinctions that matter to the question at hand.

## Actionable guidance

- When demand grows with company headcount but your team's capacity doesn't, treat manual service as structurally doomed: build self-service rather than optimizing the manual process.
- Sketch the system as stocks and flows before modeling: the sketch surfaces the stages, where things can go wrong, and what you can measure to evaluate whether the approach is working.
- Before committing, model the pipeline and test every candidate solution against it (eliminate errors, hire 5x, go self-service). Adopt only the intervention that actually fixes the backlog in simulation.
- Model the zero-error case first. If the backlog still grows with a 100% success rate, stop investing in error reduction as the primary fix.
- Test error sensitivity by raising each error rate independently and comparing throughput; expect early-stage errors to dominate because downstream errors compound on them.
- Adjust modeled error costs for coordination boundaries: cross-team rework is more expensive than the flow suggests; same-team rework is cheaper.
- Stop elaborating the model once it can teach you what you need: "there are more nuances we could introduce, but there's already enough complexity here for us to learn quite a bit."
- Cap manual work explicitly (one engineer) and redirect everyone else to automation. Accept visible short-term degradation to escape permanent degradation.
- Require that self-service tooling be safely usable by a new hire with zero company context. Put safety in the tool because training cannot outpace hiring.
- Replace ticket-driven intake with a structured request schema of required fields. Sequence it first: it cuts round-trip delays immediately and becomes the automation interface later. Prefer moves that "get paid twice."
- Automate the highest-blast-radius step first (here, port allocation, which could break production routing). Move shared registries out of wiki pages into databases so access can be guarded with checks.
- Default everything you can; require user input only where users genuinely know the answer. Place a settings-refresh checkpoint at the development-to-production gate.
- Generate configuration (Puppet scaffolding) from request data instead of having humans tweak templates; this removes typo-class errors.
- Sequence tasks so each step delivers standalone value while building toward the end state: structured intake → generated scaffolding → automate riskiest step → automate placement → migrate to the target platform (Mesos/Aurora) when it's production-ready.
- Define a weekly check (queue size, provisioning time) to test whether the strategy is working, and keep refining indefinitely — bottom-up strategies live or die on effectiveness.
- Before betting on a technology, read the primary sources and canvass your network for people with real production experience at your scale. Prefer the option where verifiable operating experience exists over the one with better marketing or backing.
- Map your value chain to find the anchor problem (here, resource scheduling) and align your investment with the industry's evolutionary direction; avoid sinking money into components the industry is commoditizing past you.
- Optimize for the genuinely urgent path (unblocking development) and relax on the non-urgent one (production promotion); let observed escalation patterns tell you which is which.
- If no team is accountable for tooling everyone agrees is broken, plan to work around it or replace it yourself — don't wait for ownership to materialize.

## Pitfalls and misconceptions

- **"We can hire our way out."** The model shows even 500% more manual-provisioning capacity barely dents the backlog. Hiring may help if hires build self-service and ramp faster than request growth.
- **"We can fix this by reducing errors / running the process better."** Even a zero-error manual process falls behind. Efficiency tuning on a structurally broken approach wastes the window you have to replace it.
- **"We can train everyone on the existing tools."** With headcount doubling every six months, a perfectly trained org is half-untrained in six months. Also, product leadership won't divert their teams to provisioning training.
- **Trusting sketch-stage intuition about which errors matter.** The team's assumption (long-trip-back errors are worst) was wrong; only exercising the model revealed that early errors compound worst.
- **Asking users to predict long-term requirements.** Requesters under deadline pressure can't; demanding it creates friction and bad data. Use defaults plus later checkpoints.
- **Relying on understaffed adjacent teams (SREs) as the solution.** Their bandwidth is already committed; they can absorb edge cases, not the load.
- **Betting on unproven technology because of hype or backing.** Kubernetes had Google's backing but no findable large-scale production deployments in 2014; serverless had excitement but not enough findable real-world usage. The strategy targeted Mesos/Aurora, where verifiable operating experience existed in-house.
- **Judging a strategy only by its initial success.** This one succeeded brilliantly and still bequeathed a difficult developer experience. Expect phases; account for deferred costs as part of the tradeoff.
