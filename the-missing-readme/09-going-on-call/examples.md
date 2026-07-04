# Chapter 9 Examples: Going On-Call

### Saving the pager number in your contacts
The authors note that "paging" is an anachronism from before cell phones — alerts now arrive by chat, email, phone call, or text. They admit that they, like many people, don't answer calls from unknown numbers, so they advise entering the alerting service's phone number into your contacts before your rotation. **Lesson:** Remove every obstacle between an alert firing and you noticing it.

### "Follow the sun" rotations
Some on-call developers are expected to be near a computer 24/7 — which means reachable and able to react, not awake all night. Larger companies avoid overnight duty by running rotations that shift to developers in different time zones as the day goes on, so someone is always in daylight hours. **Lesson:** Availability expectations vary by company; learn yours so you're never caught unable to respond.

### "Can I get back to you in 15 minutes?"
Being available doesn't mean instantly dropping whatever you're doing. The chapter offers a model reply for a request that arrives mid-task: acknowledge it and give an approximate time — "I am currently assisting someone else; can I get back to you in 15 minutes?" **Lesson:** A fast response is expected from the on-call engineer, but not necessarily a fast resolution.

### Google Cloud's support priority ladder
As an example of company-defined priority categories, the chapter cites Google Cloud's ladder: P1 is Critical Impact (service unusable in production), P2 is High Impact (service use severely impaired), P3 is Medium Impact (partially impaired), and P4 is Low Impact (service fully usable). **Lesson:** Priority categories turn vague urgency into shared, impact-based tiers everyone can prioritize against.

### The SLI → SLO → SLA chain for error rate
The chapter illustrates service levels with one metric: error rate is an SLI (an indicator of application health); an SLO sets a target like "request error rate below 0.001 percent"; and an SLA states what happens if the SLO is missed — companies that violate customer SLAs usually must return money and may face contract termination. **Lesson:** SLIs point you to the most important metrics, while SLOs and SLAs tell you how urgently to react when they degrade.

### Restating a confusing 503 report
A model acknowledgment message: the on-call thanks the reporter, then restates the problem to verify understanding — confirming the login service is getting 503 response codes from the profile service, and explicitly checking the reporter doesn't mean the auth service, since profile and auth are separate services that are confusingly named. **Lesson:** Respond quickly by confirming you've seen and understood the request; a response doesn't have to be a solution.

### A status update with a fresh time estimate
A model periodic update: the on-call reports having looked at the login service, seeing no spike in error rate, planning to check the logs next, and promising an update within an hour. **Lesson:** Every status update should say what you found since the last update, what you'll do next, and when to expect the next update.

### Redirecting a chat request into a ticket
The chapter scripts a polite redirection for requests that arrive through the wrong channel: "I'll start looking into this right now. Could you open a ticket so this is counted when we evaluate our support workload?" **Lesson:** You can help immediately and still insist on proper tracking, because untracked support work skews the team's workload metrics.

### The 1 PM restart and the 1:05 PM latency reports
To show why notes need timestamps, the chapter points out that knowing a service was restarted at 1 PM becomes critical when customers begin reporting latency at 1:05 PM — the two events can be correlated only because someone wrote down the time. **Lesson:** Timestamps let operators correlate events across systems when debugging.

### The data warehouse incident: the setting
The chapter's running real-world incident: data stops loading into a data warehouse — a database serving analytical queries for reports and machine learning. The warehouse is kept current by a stream of updates flowing through a real-time messaging system; connector processes read messages from the streams and write them into the warehouse. Teams across the company depend on this data for internal and customer-facing reports, machine learning, and application debugging. **Lesson:** The five incident phases are easiest to understand traced through one concrete production failure.

### Warehouse incident, triage: acknowledge and prioritize, don't solve
The operations team gets paged when monitors detect data in the messaging system that isn't in the warehouse. The on-call engineer acknowledges the page and investigates only enough to determine priority: since the missing data feeds tables used to generate customer reports, they deem the issue high priority. Triage ends there — the engineer acknowledged the alert and determined priority but did not try to solve the problem; they simply looked to see which tables were impacted. **Lesson:** Triage is acknowledging the issue and understanding its impact so it can be prioritized — troubleshooting comes later.

### Warehouse incident, coordination: announce, escalate, inform customers
The on-call posts an announcement in the operations chat channel describing the data gap in customer-facing tables. A cursory check shows the connector is running and its logs show no faults, so the on-call asks connector developers for help and pulls in another engineer with connector experience. The engineering manager steps in as incident manager. The team emails the company that warehouse data is missing for several tables, and the incident manager works with account management and operations to post a notice on the customer-facing status page. **Lesson:** Coordination means establishing who's in charge, then notifying everyone needed to fix the problem and everyone affected by it.

### Warehouse incident, mitigation: binary-searching 30 streams
The engineers bounce (restart) the connector hoping it becomes unwedged; the issue remains. A stack dump shows the connector deserializing messages, and the machine's CPU is saturated at 100 percent, so they guess it's stuck on a large or corrupt message that eats all the CPU during deserialization. To mitigate, they run a second connector with only known-good streams — but with 30 streams and no idea which are bad, they binary search: add half the streams, watch the connector's behavior, and adjust the set. They find the culprit stream, restart the connector with all healthy streams, and the table data catches up, limiting impact to a single stream and table. **Lesson:** Mitigation reduces severity quickly without fixing the root problem, and search algorithms can isolate a fault fast.

### Warehouse incident, resolution: the APM header epiphany
With one bad stream isolated, engineers remove all healthy streams from the original connector to reproduce the issue, find the stuck message, and read it manually with a command line tool — it looks fine. The epiphany: why can the CLI read what the connector can't? The connector contains code the CLI doesn't use — a fancy date deserializer that infers message header data types with complicated logic. Rerunning the CLI with headers enabled reveals the bad message has a header with a single key and an empty value, injected — unbeknownst to the engineers — by an application performance management (APM) daemon into all messages. Outside support confirms the CLI has a bug (it won't print headers containing a null-terminated byte string), and the engineers conclude header bytes are wedging the type inference. They test the theory by disabling header decoding in the connector: the last table loads, all monitors pass data quality checks, and the team notifies the support channel and updates the status page. **Lesson:** Resolution is hypothesis-driven detective work — reproduce the symptom, explain the discrepancy, test the theory with a controlled change, and verify with monitors.

### Warehouse incident, follow-up: postmortem and prevention tickets
The engineering manager responsible for the connector schedules follow-up work, and the on-call engineer drafts a postmortem document; a postmortem meeting is held. Through the process, tickets are opened to investigate why the APM was using message headers, why the connector couldn't deserialize them, and why the manual CLI consumer couldn't print headers containing null strings. **Lesson:** An incident isn't done at recovery — follow-up converts what was learned into tasks that prevent recurrence.

### The hypothetico-deductive model from Google's SRE book
The chapter borrows the troubleshooting model from Chapter 12 of Google's *Site Reliability Engineering*: examine the problem, make a diagnosis, then test and treat; if the treatment works the problem is cured, otherwise reexamine and start again. The warehouse team applied it when they hypothesized the connector had deserialization issues rather than dropped data, checked metrics, and ran their binary-search experiment — ready to reformulate if it came up empty. **Lesson:** Troubleshoot like a scientist: hypothesize, test, treat, and loop on failure.

### Half-splitting through the call stack
For diagnosing big systems, the chapter recommends binary search (also called half-splitting): pick a component halfway through the call stack and check whether the problem is upstream or downstream of it; then pick a new halfway point in that direction and iterate until you've isolated the component where the problem occurs. Linear front-to-back search remains fine for small problems. **Lesson:** Diagnosis is a search, so apply search algorithms to it.

### Atlassian's postmortem template
As a model for postmortem structure, the chapter points to Atlassian's publicly available template, which includes sections and examples describing the lead-up, fault, impact, detection, response, recovery, timeline, root cause, lessons learned, and corrective actions needed. **Lesson:** You don't have to invent postmortem structure — proven templates enumerate everything a good incident write-up should capture.

### The five whys applied to the warehouse incident
The chapter demonstrates root-cause analysis on its running example. Problem: data missing from the data warehouse. Why? The connector wasn't loading data. Why? It couldn't deserialize incoming messages. Why? The messages had bad headers. Why? The APM was inserting headers. Why? The APM defaulted to that behavior without developer knowledge — the root cause was the APM's accidental message header configuration. A note adds that "root cause" is misleading: incidents rarely have a single cause, and branching whys are fine — document everything. **Lesson:** Iterating "why?" about five times walks you from symptom to root cause(s).

### "Peter didn't disable message headers" vs. a process gap
To show blame-free postmortem language, the chapter contrasts two phrasings of the same finding: "Peter didn't disable message headers" assigns blame to a person, while "Message header config changes aren't going through code review" identifies an area for improvement. Blame turns postmortems into unhealthy vent fests. **Lesson:** Frame postmortem findings as process improvements, never as individual fault.

### A bad header vs. a dead letter queue
To separate problems from "solutioning," the chapter contrasts: "The message had a bad header" states a problem, while "We should put bad messages in a dead letter queue" proposes a solution. Solution design takes a long time and distracts from the review meeting's purpose — discussing problems and assigning tasks — so it belongs in follow-up tasks. **Lesson:** Postmortem meetings discuss problems and assign tasks; designing solutions happens afterward.

### Dan Luu's public postmortem collection
The chapter recommends learning from old postmortems and points to Dan Luu's public collection on GitHub (github.com/danluu/post-mortems), where companies share incident write-ups as a community resource. It adds that companies run postmortem reading groups, review documents with wider audiences, and even use old postmortems to simulate production issues when training new engineers. **Lesson:** Other people's incidents are free lessons — read postmortems to build operational judgment before your own pager fires.

### "I'll get back to you by 5 PM with an update"
Describing the standard support-request flow — acknowledge that you've seen the request, ask questions until you understand the problem, give a time estimate, investigate while updating the requestor, ask them to confirm the fix, then close — the chapter models the time-estimate step with this phrase, given once you've got a grasp on the problem. **Lesson:** As soon as you understand a request, commit to a concrete time for your next update, before you've solved anything.

### Sumeet and Janet: a model support exchange
A chat transcript shows a support request handled well. At 3:48 PM Sumeet reports customers saying page loads are slow. By 4:12 PM Janet thanks him and asks clarifying questions — specific customer IDs and pages — noting her dashboards show no widespread latency. Sumeet supplies two customer IDs and the affected pages (the ops main page and an APM chart) with loads over 5 seconds. Janet commits to an update by 10 the next morning. At 8:15 AM she explains the cause — database maintenance the previous afternoon on the database powering the APM dashboard, which also fed a roll-up on the ops main page, finished around 8 PM — and asks Sumeet to confirm the issue is gone. At 9:34 AM Sumeet confirms with customers that page loads are much better. The authors annotate how Janet pays attention, makes herself available (responding within a half hour), communicates clearly with clarifying questions so she can prioritize, posts an ETA, tracks her work by describing what happened, and confirms before closing. **Lesson:** A good support interaction strings together all the on-call skills: acknowledge fast, clarify, estimate, investigate, explain, and confirm the fix before closing.

### Support as a learning opportunity
The chapter addresses the feeling that support distracts from your "real" job of programming: answering requests shows you how your team's software is used in the real world and how it fails or confuses users, drags you into unfamiliar code where you must think hard and experiment, and surfaces recurring problem patterns that make you build better software. Fast, high-quality support responses also build relationships and reputation — they don't go unnoticed. **Lesson:** Support rotations make you a better engineer, not just a busier one.

### The firefighter who becomes permanently on-call
The chapter sketches the experienced engineer for whom firefighting becomes a reflex. The team loves having them — when things get tough, just ask the firefighter — but the dependence is unhealthy: pulled into every issue, the firefighter is effectively permanently on-call; long hours and high stakes burn them out; constant interruption stalls their programming and design work; the team never develops its own troubleshooting expertise; and fixes for serious underlying problems get deprioritized because the firefighter is always around to patch things up. **Lesson:** Heroics feel gratifying and earn praise, but they hurt the hero, the team's growth, and the system's long-term health.

### "Thanks, Jen" — weaning a team off its hero
For teams that already have a hero, the chapter scripts how to take on some of the burden while signaling you're okay struggling: "Thanks, Jen. I actually want to try to figure this out on my own for a bit so I can skill up... Can I ask for your help in 30 minutes if this is still a mystery?" **Lesson:** Politely deferring the hero's help — with a checkpoint — lets you build skills while reducing the team's dependence on one person.

### The Increment article behind the five phases
The chapter credits its five-phase incident-response breakdown (triage, coordination, mitigation, resolution, follow-up) to the *Increment* article "What Happens When the Pager Goes Off?", which contains more quotes and detail about how different companies handle incidents. **Lesson:** The five-phase model reflects real industry practice across companies, not just one team's process.

### Google's SRE book as the deeper reference
For going deeper, the chapter recommends Google's *Site Reliability Engineering* book: Chapter 4 if you must define SLIs and SLOs yourself in a nascent operations setting, and Chapters 11, 13, 14, and 15 for on-call, emergency response, incident handling, and postmortems. **Lesson:** This chapter distills the essentials for new engineers; the SRE book is the canonical next step for operational depth.
