# Chapter 10: Operations — Examples

## N-1 backfill policy under private equity ownership (Document 18-1)

A strategy for working with a new private equity owner sets an "N-1" backfill policy — departures are backfilled one level less senior — and caps each business unit at one Principal Engineer, with any exception approved in writing by the CTO (covering both promotions and external hires). The CTO escalation is an explicit operational mechanism, but the policy leaves an implicit gap: nothing says how down-leveling of backfills is enforced. Candidate mechanisms include the CTO approving levels in a group chat with recruiting, making the Recruiting team responsible for enforcement, or trusting hiring managers to comply.
Illustrates: policies carry both explicit and implicit mechanisms, and operations is choosing the right enforcement option for your circumstances.

## Recoding America: government policy without operations

Jennifer Pahlka's book *Recoding America* (Metropolitan Books, 2023) examines how well-intended government legislation often isn't feasible to implement, producing policies that demand massive IT investment while delivering little benefit to constituents.
Illustrates: policy divorced from implementation feasibility wastes enormous effort — operations matters far beyond software companies.

## Calm's written CTO exception process (Chapter 21)

Calm's product engineering strategy uses the simplest approval forum: exceptions to deliberately restrictive policies are granted by the CTO and must be in writing. The reasoning is spelled out — the policies will sometimes be wrong, but exceptions must be deliberate and grounded in agreed-upon problems, because everyone scattering toward preferred solutions creates negative leverage. If there's no written record of CTO approval, the exception doesn't exist. The author notes a common weakness even here: the policy never specifies *how* to request approval (such as a #cto-approvals Slack channel) or how to research prior requests and approvals.
Illustrates: the canonical approval forum, the written-record rule that kills ambiguity, and the typical gap of unspecified request workflow.

## LLM adoption strategy: loaned authority to an ML review (Document 17-1)

A strategy standardizes on Anthropic models via AWS Bedrock, declining to adopt a broad set of LLMs at this point to avoid maintaining multiple implementations, since the underlying model quality is viewed as somewhat undifferentiated (anchored in a Wardley map of the LLM ecosystem). Rather than routing exceptions to an executive, exceptions are reviewed by the Machine Learning Review in a #ml-review channel.
Illustrates: senior leadership can loan its approval authority to a delegated group instead of bottlenecking on an executive.

## Carta's Navigators program

At Carta, the Navigators program experimented with granting executive authority for technical decisions to named engineers in each area. The author's takeaway from such variations: the right participants and a good executive sponsor matter a lot; the remaining design details matter much less. He points to Andrew Harmel-Law's *Facilitating Software Architecture* (O'Reilly, 2024) for deeper discussion.
Illustrates: approval forums vary widely across companies, and arguing the fine details is less valuable than getting participants and sponsorship right.

## User-data access inspection metric (Document 19-1)

A user-data access strategy measures progress as the percentage of customer data access requests justified by a user-comprehensible, automated rationale. The metric is deliberately two-sided: merely expanding access requirements doesn't count (it isn't automated and likely encourages workarounds), and merely improving usability doesn't count (it doesn't increase supported requests). The strategy also creates a private channel giving security and compliance visibility into all manual access rationales, with managers notified when someone repeatedly uses manual justifications. The author notes a fully realized version would add a dashboard link and a committed review cadence.
Illustrates: an inspection mechanism with a game-resistant composite metric — and that inspection isn't complete until data location and review schedule are concrete.

## Asynchronous dashboard review via recurring invite

For a recent inspection mechanism, the author created a recurring invite for working group members who had agreed to review the data. The invite linked the relevant dashboard and a dedicated chat channel. It wasn't a synchronous meeting — it was a commitment to independently review the data and discuss anything surprising.
Illustrates: inspection mechanisms don't require meetings; a structured asynchronous commitment can prevent silent failure cheaply.

## Stripe's cloud-spend nudge

Stripe let teams self-authorize new cloud hosting costs, which worked well almost all the time — but sometimes teams accidentally introduced large cost increases, almost always without realizing it; even telling them not to wouldn't have helped, since they simply didn't perceive they'd done it. Rather than forcing all teams through spend approval, Stripe added a nudge that informed teams when their cloud spend accelerated month over month, directed them to charts explaining the acceleration, and told them where to ask questions. The Efficiency Engineering team paired this with inspection, reviewing spikes monthly and reaching out where necessary. The nudge required no authoritative mandate and focused advisory time only on teams that actually overspent, not every team that might.
Illustrates: nudges deliver information at the moment it's useful, scale without authority, and pair naturally with inspection.

## Carta's untested pull request notification

Some Carta managers said they didn't know when or why their team members merged untested pull requests. A working group added a nudge notifying a manager whenever this happened. It made detection easy while respecting attention: notifications fired only for a new untested pull request, never otherwise.
Illustrates: a well-scoped nudge — explicit trigger, relevant recipient, no noise — solves an information gap that policy announcements can't.

## Uber's service migration: tickets to structured requests (Document 16-1)

Uber's service migration strategy replaced a slow, manual ticket-based provisioning process with structured requests. Missing or incorrect information in tickets caused significant delays, and collecting structured information was also the first step toward self-service — so the change "got paid twice": fewer manual provisioning errors now, plus the interface for future self-service workflows. Users who couldn't fill in the form still existed, but they became rare exceptions who could be given a good manual experience.
Illustrates: automation as a scalable operational mechanism, contingent on good user experience, with humans reserved for edge cases.

## Deferring the Java decision in the Index acquisition (Document 22-4)

Stripe's strategy for integrating the Index acquisition explicitly deferred deciding whether to introduce Java. Java was incompatible with the existing engineering strategy, stakeholders couldn't be aligned on a resolution, and litigating it would distract from launching a joint product within six months. The strategy committed to taking up the discussion after the initial release.
Illustrates: explicit deferral with a stated revisit point beats letting an intractable debate churn and derail nearer goals.

## Deferring R&D maintenance cuts under private equity (Document 18-1)

The private equity strategy believed significant opportunities existed to reduce R&D maintenance investment but lacked conviction about which efforts to prioritize. Instead of guessing, it kicked off a working group to identify the features with the highest support load.
Illustrates: deferral can take the form of commissioning the work needed to make the decision well, rather than forcing a premature choice.

## Reporting LLM progress in the Executive Weekly Meeting (Document 17-1)

The LLM adoption strategy chose to build an LLM-backed process for reactivating departed and suspended drivers in mature markets — driver lifecycle modeling showed onboarding improvements would have little impact on total active drivers, making reactivation the only opportunity to meaningfully impact active drivers. Operationally, the strategy committed to reporting progress monthly in the Executive Weekly Meeting, coordinated in a #exec-weekly channel.
Illustrates: the reporting meeting as the most common meeting-based mechanism, with a named forum and cadence.

## Return-to-office mandates as top-down pronouncement

Some return-to-office policies simply dictate that teams must work from a central office, but driving a real change requires motivating those individuals to actually return.
Illustrates: the top-down pronouncement antipattern — declaration alone doesn't drive real change.

## Annual training that no one remembers

Mandatory recurring trainings, usually driven by compliance laws requiring annual hours, suffer twin failures: trainers make little effort because attendance is guaranteed, and trainees tune out because they expect low quality. It's not uncommon to hear people trained on a policy every year for years claim they've never heard of it.
Illustrates: the mandatory-training antipattern — adequate for shifting legal obligation, ineffective for changing real outcomes.

## The toddler's theory of driving

Cargo-culting sometimes works: you can kick a ball without understanding physics. But it's often disastrous: how the author's toddler thinks driving a car works is very different from how driving actually works.
Illustrates: copying a process without understanding the circumstances that made it effective fails exactly when the underlying mechanics matter.
