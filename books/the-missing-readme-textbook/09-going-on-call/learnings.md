# Chapter 9: Going On-Call

On-call engineers are the first line of defense for unplanned work — production incidents and ad hoc support requests — so the rest of the team can focus on development. The chapter teaches how rotations work, the core on-call skills (availability, attention, prioritization, clear communication, tracking work), a five-phase incident-handling process illustrated by a real production incident, support best practices, and a warning against becoming the team's burned-out hero. These skills apply in any urgent situation, even for engineers whose roles have no formal rotation. Effective on-call engineers are prized by their teammates and managers, and they grow quickly from the relationship-building and learning the rotation provides.

## Core Concepts

### How On-Call Works
- On-call rotates on a schedule, typically a week or two (sometimes as short as a day). Every qualified developer participates. New or under-skilled team members "shadow" a few primary rotations first to learn the ropes.
- Many schedules pair a primary with a secondary on-call who steps in when the primary is unavailable. Routinely forcing the secondary to step in damages your reputation.
- Some organizations use tiered response: a support team is alerted first, escalates to operations engineers, then to the development team.
- Most on-call time goes to ad hoc support requests (bug reports, questions about how the team's software behaves, usage questions); the on-call triages these and responds to the most urgent. But every on-call eventually faces an operational incident — a critical problem with production software — reported by an automated monitoring alert or by a support engineer who notices a problem. The on-call must triage, mitigate, and resolve it.
- On-calls get "paged" when critical alerts fire. Paging predates cell phones; today alerts arrive via chat, email, phone calls, or texts. Add the alerting service's phone number to your contacts so you don't screen the page as an unknown caller.
- Every rotation begins and ends with a handoff: the outgoing on-call summarizes open incidents and gives context on open tasks. If you tracked your work well, handoff is a nonevent.

### Important On-Call Skills
On-call is rapid-fire and high stress, but one common skill set handles both incidents and support: make yourself available, pay attention, prioritize work, communicate clearly, and track your work.

#### Make Yourself Available
- "Your best ability is availability." The on-call's job is to respond to requests and alerts. Don't ignore requests or hide. Expect interruptions and accept that you'll do less deep work during your rotation.
- Some rotations expect you near a computer 24/7 — not awake all night waiting for alerts, but reachable, able to react, and willing to adjust non-work plans. Larger companies run "follow the sun" rotations that pass on-call across time zones as the day progresses. Learn your team's expectations before you're caught unable to respond.
- Available does not mean dropping everything instantly. For many requests it's fine to acknowledge receipt and give an approximate time ("I'm currently assisting someone else; can I get back to you in 15 minutes?"). A fast response is expected from the on-call; a fast resolution is not.

#### Pay Attention
- Relevant information flows through many channels: chat, email, phone calls, texts, tickets, logs, metrics, monitoring tools, and meetings. Watching them gives you context for debugging and troubleshooting.
- Proactively read release notes and channels that announce operational information like deployments and configuration changes. Watch the chat rooms where operations teams discuss unusual observations and announce adjustments. Read meeting notes, especially operational scrum digests tracking ongoing incidents and the day's maintenance.
- Keep operational dashboards visible (background window or a nearby TV) to build a baseline of normal behavior, so during an incident you can tell which graphs look odd.
- Build an emergency resource list: direct links to critical dashboards and runbooks for your services, log-access instructions, important chat rooms, and troubleshooting guides. A dedicated, up-to-date "on-call" bookmark folder works well. Share it with the team so others can use and improve it.

#### Prioritize Work
- Work the highest-priority task first, then move down the list as tasks finish or become blocked. When alerts and questions interrupt, triage quickly: set the interruption aside, or start on it if it's an emergency. If a new request outranks your current task but isn't critical, finish the task or reach a good stopping point before context switching.
- Some requests are extremely urgent; others are fine getting done in a week. If you can't tell how urgent a request is, ask about its impact — impact determines priority. If you and the requestor disagree about priority, discuss it with your manager.
- Companies categorize operational work by priority (P0, P1, P2, ...); names and meanings vary, but P0-level tasks are the big ones. Google Cloud's support ladder is a useful model: P1 critical impact (service unusable in production), P2 high impact (severely impaired), P3 medium impact (partially impaired), P4 low impact (fully usable).
- Service level indicators (SLIs) — error rate, request latency, requests per second — are the easiest way to see whether an application is healthy. Service level objectives (SLOs) define SLI targets for healthy behavior (e.g., error rate below 0.001 percent). Service level agreements (SLAs) specify what happens when an SLO is missed; companies that violate customer SLAs usually owe money back and may face contract termination. Learn the SLIs, SLOs, and SLAs for your applications: SLIs point you at the most important metrics, and SLOs and SLAs help you prioritize incidents.

#### Communicate Clearly
- Operational work moves fast, and miscommunication causes major problems. Be polite, direct, responsive, and thorough.
- Under a barrage of operational tasks, developers get stressed and grumpy — it's human nature. Stay patient and polite: it may be your tenth interruption of the day, but it's the requestor's first interaction with you.
- Use concise sentences. Being direct can feel uncomfortable, but direct isn't rude; brevity ensures your message gets read and understood. If you don't know an answer, say so. If you do, speak up.
- Respond quickly even when you have no solution yet. Tell the requestor you've seen their request and confirm you understand the problem by restating it and asking clarifying questions.
- Post periodic status updates: what you found since the last update, what you plan to do next, and a fresh time estimate every time.

#### Track Your Work
- Write down what you're doing as you work. Every item you touch on-call belongs in an issue tracker or the team's on-call log, with progress updates written in each ticket and the final steps that mitigated or resolved the issue documented for when it recurs.
- Tracking reminds you where you left off after interruptions, lets the next on-call see the state of ongoing work, lets anyone you ask for help catch up by reading the log, and builds a searchable knowledge base for future on-calls.
- Chat channels (like Slack) are good for communicating during incidents, but transcripts are hard to read later — always summarize into a ticket or document. Redirect support requests to the right channels without guilt: help right away, but ask the requestor to open a ticket so the work counts toward the team's support workload.
- Close finished issues so dangling tickets don't clutter on-call boards and skew support metrics. Ask the requestor to confirm the fix before closing; if they don't respond, announce you'll close in 24 hours for lack of response, then do it.
- Always timestamp your notes. Timestamps let operators correlate events across systems when debugging — knowing a service restarted at 1 PM is useful when customers start reporting latency at 1:05 PM.

### Handling Incidents
Incident handling is the on-call's most important responsibility, and most developers misunderstand it: they think it's about fixing a production problem. In a critical incident, the top objective is to mitigate the impact and restore service. The second is to capture information so the problem can be analyzed later. Determining the cause, proving it's the culprit, and fixing the underlying problem is only the third priority.

Incident response has five steps:
1. **Triage** — find the problem, decide its severity, and determine who can fix it.
2. **Coordination** — notify teams (and potentially customers); if the on-call can't fix it, alert those who can.
3. **Mitigation** — get things stable as quickly as possible; "stop the bleeding," not a long-term fix.
4. **Resolution** — with breathing room, investigate and fix the immediate underlying problem.
5. **Follow-up** — investigate the root cause, run a postmortem for severe incidents, and create tasks that prevent recurrence; look for gaps in process, tooling, and documentation. The incident isn't done until all follow-up tasks are completed.

#### Triage
- Determine priority by impact: how many people are affected and how badly? Use your company's priority categories and SLO/SLA definitions, helped by SLIs and the metric that triggered the alert.
- Triage means acknowledging the issue and understanding its impact so it can be prioritized properly — nothing more. Don't try to solve the problem during triage.
- If you're having trouble determining severity, ask for help. Triage is not the time to prove you can figure things out on your own; time is of the essence.
- Don't troubleshoot during triage either — your users keep suffering while you dig. Save troubleshooting for the mitigation and resolution phases.

#### Coordination
- Coordination starts by figuring out who's in charge. For lower-priority incidents, the on-call is in charge and coordinates. For larger incidents, an incident commander takes charge, tracking who is doing what and the current state of the investigation.
- Once someone takes charge, notify all relevant parties: everyone needed to mitigate or resolve (other developers, SREs), internal stakeholders (technical account managers, product managers, support specialists), and impacted users via status pages, emails, social media alerts, and so on.
- Large incidents spawn many parallel conversations that are hard to follow. War rooms — virtual or physical spaces where all interested parties gather — coordinate the response.
- Track communication in written form in one central place (ticketing system or chat). This helps everyone track progress, saves you from constantly answering status questions, prevents duplicate work, and lets others offer helpful suggestions. Share both observations and actions, and state what you're about to do before doing it — even when working alone, because someone may join later and find the log helpful, and a detailed record reconstructs the timeline afterward.

#### Mitigation
- The goal is to reduce the problem's impact, not fix it. Mitigation is about reducing severity; fixing can take a long time, while mitigating can usually be done quickly.
- Common mitigations: roll back to a "last known good" release, shift traffic away from the problem, fail over to another environment, turn off a feature flag or misbehaving feature, remove a machine from a pool, add hardware, or roll back a just-deployed service.
- Ideally a runbook exists — predefined step-by-step instructions for mitigating common problems and performing actions like restarts and rollbacks. Know where your runbooks and troubleshooting guides live before you need them.
- Capture what data you can while mitigating: telemetry, stack traces, heap dumps, logs, dashboard screenshots. Once mitigated, the problem may be hard to reproduce, and this data fuels debugging and root-cause analysis later.
- You'll often find gaps in metrics, tooling, and configuration while mitigating — missing metrics, incorrect permissions, misconfigured systems. Quickly write down anything that would have made your life easier, and open tickets for these gaps during follow-up.

#### Resolution
- Once mitigation is complete, the incident is no longer an emergency; priority drops and you get breathing room to troubleshoot and resolve underlying issues. Focus on the immediate technical problems — what's needed to recover without the temporary mitigation measures. Set aside larger technical and process problems for follow-up.
- Troubleshoot with the scientific method, the hypothetico-deductive model: examine the problem, make a diagnosis, then test and treat. If the treatment succeeds, the problem is cured; if not, reexamine and start again.
- Ideally, quarantine a misbehaving program instance and examine its misbehavior. The resolution goal is to understand the symptoms and make the problem reproducible, using all operational data at your disposal: metrics, logs, stack traces, heap dumps, change notifications, issue tickets, and communication channels.
- Diagnosis is a search, so use search algorithms. Linear search (examining components front to back) works for small problems. For bigger systems use divide and conquer — binary search, also called half-splitting: pick a point halfway through the call stack, determine whether the problem is upstream or downstream, pick a new halfway point in that direction, and iterate until you isolate the component where the problem occurs.
- Test your theory before treating. Testing isn't treatment — you're not fixing yet; you're seeing whether you can control the bad behavior. Can you reproduce it? Can a configuration change make it go away? If so, you've located the cause. If not, you've eliminated one potential cause — go back, reexamine, and form a new diagnosis.
- After a successful test, decide the best treatment. Sometimes a configuration change suffices; often a bug fix must be written, tested, and applied. Apply the treatment, verify it works as expected, and keep an eye on metrics and logs until you're convinced everything is stable.

#### Follow-Up
- Incidents are a big deal, so they need follow-up. The goal is to learn from the incident and prevent recurrence: a postmortem document is written and reviewed, and tasks are opened to prevent the problem from happening again. ("Postmortem" is borrowed from medicine; "retrospective" is a fine alternative term.)
- The on-call who dealt with the incident drafts the postmortem, capturing what happened, what was learned, and what must be done to prevent recurrence. Many templates exist; Atlassian's is a good example, with sections for lead-up, fault, impact, detection, response, recovery, timeline, root cause, lessons learned, and corrective actions.
- The critical section is root-cause analysis (RCA), performed with the five whys: take the problem, ask why it happened, then ask why again about each answer until you reach the root cause. "Five" is anecdotal — most problems take about five iterations. RCA is a popular but misleading term: incidents are rarely caused by a single issue, and the five whys may branch into many causes. That's fine — document everything.
- After the document is written, a manager or tech lead schedules a review meeting with all interested parties. The author leads the review, participants discuss each section in detail, and the author adds missing information and new tasks as they're discovered.
- Keep blame out of postmortems. High-stress situations make it easy to get upset and cast blame. Give constructive feedback and point out areas for improvement without blaming individuals or teams ("message header config changes aren't going through code review," not "Peter didn't disable message headers"). Don't let postmortems turn into unhealthy vent fests.
- Keep "solutioning" — figuring out how to solve a problem — out of the review meeting too. It takes a long time and distracts from the meeting's purpose: discussing problems and assigning tasks. A statement of the problem belongs in the meeting; designing the fix belongs in follow-up tasks.
- Follow-up tasks must be completed; the incident can't be closed until all remaining tasks are finished. If tasks are assigned to you, work with your manager and the postmortem team to prioritize them properly.
- Old postmortems are a great way to learn. Some companies share them publicly as a community resource; teams run postmortem reading groups, review documents with wider audiences, and even use old postmortems to simulate production issues for training new engineers.

### Providing Support
- When not handling incidents, on-calls handle support requests from inside the organization and from external customers — everything from simple "how does this work?" questions to difficult troubleshooting. Most are bug reports, business-logic questions, or technical questions about using the software.
- Standard flow: acknowledge that you've seen the request; ask questions until you understand the problem; give a time estimate for your next update ("I'll get back to you by 5 PM with an update"); investigate, updating the requestor as you go, using the same mitigation and resolution strategies as incidents; when you think it's resolved, ask the requestor to confirm; then close the request.
- Support can feel like a distraction from your "real" programming job. Treat it as a learning opportunity: you see how your team's software is used in the real world and the ways it fails or confuses users, you're taken into unfamiliar parts of the code where you must think hard and experiment, and you notice the patterns that cause problems — which helps you build better software. Support rotations make you a better engineer, and you build relationships and reputation; fast, high-quality support responses do not go unnoticed.

### Don't Be a Hero
- The opposite extreme of shirking on-call is doing too much. On-call work is gratifying — colleagues thank you, managers praise efficient incident resolution — but overdoing it leads to burnout.
- As some engineers gain experience, jumping into "firefighting" mode becomes a reflex. A talented firefighter feels like a godsend — when things get tough, everyone just asks the firefighter — but depending on one is not healthy: firefighters pulled into every issue effectively become permanently on-call, and the long hours and high stakes cause burnout.
- Firefighters also struggle with their own programming and design work because they're constantly interrupted. Teams that rely on a firefighter never develop their own expertise and troubleshooting abilities. And firefighter heroics can cause fixes for serious underlying problems to be deprioritized, because the firefighter is always around to patch things up.
- If you feel you're the only one who can fix a problem, or you're routinely firefighting when not on-call, you might be becoming a "hero." Talk to your manager or tech lead about finding better balance and getting more people trained and available to step in.
- If your team has a hero, learn from them and pick up some of their burden. Let them know when you're okay struggling a bit: thank them, say you want to figure it out yourself for a while to skill up, and set a checkpoint to ask for their help later if it's still a mystery.

## Actionable Practices

The authors' own Do's and Don'ts:
- DO add known "pager" numbers to your phone's contacts.
- DO use priority categories, SLIs, SLOs, and SLAs to prioritize incident response.
- DO triage, coordinate, mitigate, resolve, and follow up on critical incidents.
- DO use the scientific method to troubleshoot.
- DO ask "the five whys" when following up on an incident.
- DO acknowledge support requests.
- DO give time estimates and periodic updates.
- DO confirm a problem is fixed before closing a support request ticket.
- DO redirect support requests to the appropriate communication channels.
- DON'T ignore alerts.
- DON'T try to troubleshoot during triage.
- DON'T leave a problem unmitigated while you search for the root cause.
- DON'T cast blame during postmortems.
- DON'T hesitate to close nonresponsive support requests.
- DON'T ask support requestors what their priority is; ask about the impact of the problem.
- DON'T be a hero who has to fix all the things.

Additional practices from the chapter:
- Learn your rotation's availability expectations (reachability, response time) before it starts, and adjust non-work plans accordingly.
- Shadow a few primary rotations before taking primary duty if you're new to the team.
- Start and end every rotation with a handoff summarizing open incidents and tasks.
- Respond fast even without a solution: acknowledge, restate the problem to confirm understanding, and give an ETA for the next update; include a fresh time estimate with every subsequent update.
- Maintain and share an up-to-date "on-call" bookmark folder of dashboards, runbooks, log-access instructions, chat rooms, and troubleshooting guides.
- Watch operational dashboards routinely so you know what normal looks like before incidents happen.
- Log all on-call work in tickets with timestamps; summarize chat threads into tickets or documents; document final mitigation/resolution steps for recurrences.
- Ask for help with severity calls during triage instead of proving self-sufficiency.
- State what you're about to do before doing it during incidents, even when working alone.
- During mitigation, capture telemetry, stack traces, heap dumps, logs, and dashboard screenshots before the evidence disappears.
- Write down every metric, tooling, permission, or configuration gap you hit while firefighting; open tickets for them in follow-up.
- Quarantine misbehaving instances to study them; use linear search for small problems and half-splitting for big systems.
- Test theories by trying to control the bad behavior before writing a fix; after treating, watch metrics and logs until convinced of stability.
- Frame postmortem findings as areas for improvement, never as individual blame; keep solution design out of the review meeting and in follow-up tasks.
- Complete all postmortem follow-up tasks before considering the incident closed.
- Read old postmortems — your company's and public collections — to learn how systems fail.

## Pitfalls & Anti-patterns

- **Hiding from or ignoring alerts and requests.** The on-call's whole job is responding; routinely forcing the secondary to step in for you destroys trust.
- **Missing pages because the alerting number is unknown.** If you screen unknown callers, the page never reaches you.
- **Troubleshooting during triage.** Users keep suffering while you debug; triage exists only to assess severity and route the issue.
- **Proving you can figure it out alone during triage.** Time is of the essence — ask for help with severity calls.
- **Root-causing before mitigating.** Restoring service comes first, capturing data second; cause-finding and the underlying fix are only third priority.
- **Asking requestors for their priority instead of their impact.** Impact is the objective input; priority follows from it. Escalate prioritization disagreements to your manager.
- **Leaving work untracked or only in chat.** Untracked work makes handoffs painful, loses solutions to recurring issues, forfeits the searchable knowledge base, and chat transcripts are unreadable later.
- **Missing timestamps.** Without them, events can't be correlated across systems.
- **Leaving tickets dangling.** Unclosed tickets clutter on-call boards and skew support metrics; close nonresponsive requests after a stated 24-hour warning.
- **Casting blame in postmortems.** Naming culprits turns postmortems into unhealthy vent fests and kills learning; frame findings as process improvements.
- **Solutioning in postmortem review meetings.** Designing fixes mid-review takes long and derails the meeting's purpose of discussing problems and assigning tasks.
- **Treating "root cause" as singular.** Incidents rarely have one cause; expect the five whys to branch, and document everything.
- **Hero firefighting.** Jumping into every fire makes you permanently on-call: burnout, stalled project work, a team that never builds its own troubleshooting muscle, and serious underlying problems that stay deprioritized because you keep patching them.

## Key Terms

- **On-call** — rotation in which an engineer is the first responder for unplanned operational work and support requests.
- **Shadowing** — accompanying a primary on-call through rotations to learn before taking primary duty.
- **Primary / secondary on-call** — the first responder and the backup who steps in when the primary is unavailable.
- **Tiered response** — escalation structure where support is alerted first, then operations engineers, then the development team.
- **Paging** — being alerted of a critical issue (a pre-cellphone anachronism; now chat, email, calls, texts).
- **Handoff** — start/end-of-rotation summary of open incidents and tasks passed to the next on-call.
- **Operational incident** — a critical problem with production software.
- **Triage** — acknowledging an issue, determining its severity and impact, and identifying who can fix it.
- **Incident commander (incident manager)** — the person in charge of a large incident, tracking who is doing what and the investigation's current state.
- **War room** — a virtual or physical space where all interested parties coordinate incident response.
- **Mitigation** — quickly reducing an incident's impact ("stop the bleeding") without fixing the underlying problem.
- **Resolution** — fixing the immediate underlying problem after mitigation so temporary measures can be removed.
- **Follow-up** — post-incident phase of root-cause analysis, postmortem, and recurrence-prevention tasks.
- **Runbook** — predefined step-by-step instructions for mitigating common problems and performing actions like restarts and rollbacks.
- **SLI (service level indicator)** — a health metric such as error rate, request latency, or requests per second.
- **SLO (service level objective)** — a target value for an SLI that defines healthy application behavior.
- **SLA (service level agreement)** — an agreement about what happens when an SLO is missed (often refunds or contract termination).
- **P0/P1/P2... priorities** — categories that define a task's urgency by impact.
- **Postmortem / retrospective** — a written, reviewed analysis of an incident: what happened, what was learned, and what prevents recurrence (term borrowed from the medical after-death examination).
- **Root-cause analysis (RCA)** — the postmortem section explaining why the incident happened, typically produced with the five whys.
- **Five whys** — repeatedly asking "why?" (about five times in practice) until reaching root causes.
- **Solutioning** — figuring out how to solve a problem; belongs in follow-up tasks, not postmortem review meetings.
- **Hypothetico-deductive model** — scientific troubleshooting loop: examine, diagnose, test, treat; reexamine on failure.
- **Half-splitting** — binary-search diagnosis: repeatedly halve the system to isolate the faulty component.
- **Data warehouse** — a database meant to serve analytical queries for reports and machine learning.
- **APM (application performance management) tool** — software that sits inside applications and reports runtime behavior such as memory usage, CPU usage, and stack traces.
- **Firefighter / hero** — an engineer who reflexively jumps into every operational fire, effectively becoming permanently on-call.
- **Follow-the-sun rotation** — an on-call schedule that shifts to developers in different time zones as the day goes on.
