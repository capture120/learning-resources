# Chapter 19: Customer Data Access Strategy

This chapter is a Part IV case study: a complete strategy document ("How Should We Control Access to User Data?", 2022) written by a CISO at a company preparing for an IPO within 18 months. The company has strong baseline controls (RBAC, audit logs) but a history of failed security initiatives, and must meaningfully improve resource-level access controls before going public. The single most important takeaway: security initiatives fail when they trade security against usability, because teams doing essential work will subvert friction-heavy controls over time; durable security comes from mechanisms that improve security and internal efficiency simultaneously, enforced by a metric that only moves when both improve.

## Core ideas

### Why security initiatives fail: the friction-then-subversion pattern

The diagnosis identifies a recurring failure mode. Past security investments caused "temporary spikes in our security posture," but a year later showed, in many cases, "a pattern of increased scrutiny followed by a gradual repeal or avoidance of the new mechanisms." The root cause: most initiatives added friction to essential work performed by other internal teams (e.g., customer support). In the natural course of doing their jobs, those teams subtly subverted the improvements because the controls interfered with immediate goals like resolving customer requests.

The conclusion drawn is stated with explicit epistemic honesty: the company has "high conviction" from its track record that the historical approach creates "optical wins internally," and "limited conviction" that it creates long-term improvement absent unlikely internal changes (e.g., colleagues being markedly less busy a year from now). The conclusion: it "seems likely" a genuinely new approach is needed, not a harder push on the old one.

### Refuse the security-versus-usability framing

A load-bearing policy principle: "Good security discussions don't frame decisions as a compromise between security and usability." The strategy commits to "multi-dimensional tradeoffs to simultaneously improve security and efficiency," and treats the framing itself as a diagnostic signal: "Whenever we frame a discussion as trading off between security and utility, it's a sign that we are having the wrong discussion, and that we should rethink our approach."

Why this matters: the diagnosis showed that one-dimensional security wins get reverted by the people they burden. Only solutions that make internal workflows better at the same time will survive contact with busy teams.

### User-comprehensible rationales as the alignment mechanism

The strategy commits to building a user-accessible log of every company access of user data, with the bar that the company must "be comfortable explaining each and every access" and that "each rationale for access must be comprehensible and reasonable from a user perspective." The why: it aligns the company's internal access practices with the users' point of view. Users can evaluate how their data is accessed and decide whether to keep using the product based on whether they agree. This converts an internal compliance exercise into an externally accountable commitment, which forces rationale quality in a way batch manual review never did.

### Automate both authorization and rationale

Prioritize mechanisms that "can both automatically authorize and document the rationale for access to customer data." The canonical example: a customer support agent automatically gains access to a user's data while that user's open ticket is assigned to the agent, and loses it when the ticket is reassigned or resolved. Automation solves both diagnosed problems at once: it removes the manual copying that produces low-quality rationales, and it removes the friction that drives subversion.

### Metric design that forbids one-dimensional progress

Progress is measured as the percentage of customer data access requests justified by a user-comprehensible, automated rationale. The metric is deliberately constructed so that neither failure mode registers as progress:

- Only expanding requirements for accessing customer data does not count, because it is not automated and "is likely to encourage workarounds as teams try to solve problems quickly."
- Only improving usability does not count, because the number of supported (justified) requests has not increased.

This is the chapter's most transferable technique: encode the multi-dimensional tradeoff directly into the success metric so the organization cannot claim victory by optimizing one dimension at the other's expense.

### Least privilege through automatic expiration

The policy expires roles automatically after 90 days of non-use. The diagnosis behind it: individuals who change teams or roles accumulate unused permissions over years of tenure, and existing mechanisms for ensuring least privilege are limited. The single exception to the automated pruning is engineers in an active on-call rotation.

### Executive-led strategy testing to resolve organizational friction

The operational backbone is a weekly sync between Security Engineering, the teams working on customer data access, and the CISO, explicitly framed as "a forum for ongoing strategy testing, with the CISO serving as the meeting's sponsor, and the Principal Security Engineer serving as the meeting's guide." It runs until there is clarity on the path to 100% coverage of automated, user-comprehensible rationales. Separately, a monthly review samples actual accesses to verify rationale quality and to identify automated ways of flagging high-risk accesses in the future.

Larson's summary calls executive-led strategy testing "the most effective mechanism I've found for working through persistent organizational friction" across misaligned teams. The cadence matters: both meetings start immediately and run in parallel. The weekly sync is temporary, ending once the path to the target is clear; the monthly access review continues "in perpetuity."

### Policy as a tool to constrain a team into alignment

The second lesson Larson highlights: policy can "explicitly constrain a team into alignment." This strategy effectively outlawed the Security team's prior behaviors (friction-first initiatives, manual rationale regimes), "creating a path to a more effective mode of working." Policy here is not just guidance for others; it redirects the team that owns the problem.

A concrete instance: although the company's broader engineering strategy follows an advisory architecture process (per Andrew Harmel-Law's *Facilitating Software Architecture*), the customer data access policy is carved out as an exception. Deviations require explicit written approval from the CISO. Where the stakes justify it, a generally permissive process can have a deliberately authoritarian exception.

### Compliance theater versus real security

The diagnosis distinguishes literal compliance from actual security benefit. The company does provide rationales and audits of those rationales, "but it's unclear if the majority of these audits increase the security of our users' data." Rationale quality is "consistently low because it depends on busy people manually copying over significant information many times a day," which makes verification "somewhat arbitrary." Notably, no actual misuse of user data was found; every audited access had a clear, reasonable basis. The problem is not bad actors but a process that generates evidence nobody can meaningfully verify.

### The exploration: two standardized dimensions, one divergent

Surveying peer companies (through private networks, since firms avoid discussing this publicly, plausibly due to liability and compliance exposure), the strategy found:

- **RBAC** is highly standardized: users map to roles, roles carry permissions (e.g., a support agent role can deactivate an account; a sales engineer role can configure a new one).
- **Audit logs** are standardized: every access and mutation tied durably to a human, accumulated in a centralized, queryable store. The open challenge is using them proactively to detect issues rather than reactively after an incident surfaces elsewhere.
- **Resource-level access controls** (which rows, not which tables, someone may access) are highly divergent, with three patterns and little cross-company consistency:
  1. **Third-party enrichment**: manage access inside a vendor platform like Zendesk, enriching its objects with product data and implementing actions there. Downsides: tight vendor coupling, the platform's inherent limits, and the overhead of teams fluent in both stacks.
  2. **First-party tool implementation**: build everything in the core product. Most common at earlier-stage companies or where support leadership "grew up" internally without exposure to peer approaches. Advantage: a single, tightly integrated, infinitely extensible platform. Downside: you build and maintain all of it instead of leveraging a vendor's deeper investment.
  3. **Hybrid**: a third-party platform handles most actions and also gates resource-level access in the first-party system (e.g., you can access a user's data only while their open ticket is assigned to you). Advantages: supports complex workflows that exceed the platform's limits, and avoids deep product-vendor coupling.

In the authors' experience, companies generally all implement RBAC, audit logs, and one resource-level pattern. Most choose either third-party enrichment (with a sizable, long-standing platform team) or hybrid (which lets the work fold into existing teams without a dedicated one). This strategy continues the hybrid approach as the fastest available option, consistent with prior investment.

### Document structure can be refactored for readability

The document deviates from the book's default strategy structure: Operation is folded into Policy, and Refine is embedded in Diagnose. The structure serves the reader, not the template. Reading guidance (the separation of reading from thinking explained in Chapter 11): read top to bottom to apply the strategy; read in reverse (Explore, then Diagnose, then Policy) to understand the thinking behind it.

## Actionable guidance

- When anyone frames a security decision as security versus usability, stop the discussion and rethink the approach. Find an option that improves both.
- Before launching a new security initiative, diagnose why prior ones failed. Look specifically for the pattern of a temporary posture spike followed by gradual repeal, and for friction imposed on other teams' essential work.
- Prefer access mechanisms that grant and revoke permission automatically based on legitimate work state (an assigned open ticket), and that generate the access rationale as a byproduct rather than requiring manual entry.
- Require every data access rationale to be comprehensible and reasonable from the end user's perspective, and build toward exposing the access log directly to users.
- Measure progress with a metric that cannot improve through one-dimensional wins: percentage of accesses justified by a user-comprehensible, automated rationale.
- Expire unused RBAC roles automatically after 90 days of non-use. Exempt engineers in active on-call rotations.
- Make manual rationales visible: give security and compliance a channel showing all manual justifications, and notify the manager of anyone who repeatedly relies on them. Treat manual rationale as an escalating exception, not a norm.
- Run a weekly strategy-testing sync, sponsored by the accountable executive and guided by a senior IC, until the path to the target (here, 100% automated rationale coverage) is clear.
- Separately and in parallel, start a monthly review that runs indefinitely: sample real accesses for rationale quality and appropriateness, and use what you learn to build automated identification of high-risk accesses.
- For policies where stakes are high, carve out an exception to your normal advisory process: require written executive (CISO) approval for deviations, with a defined intake path.
- State conviction levels honestly in the diagnosis ("high conviction" the old approach yields optical wins; "limited conviction" it yields lasting change) and do not bet on unlikely changes such as people becoming less busy.
- When public best practices are scarce on a sensitive topic, explore through private peer networks instead.

## Pitfalls and misconceptions

- **Friction-heavy controls get subverted, not obeyed.** Teams blocked from essential work will work around controls in the natural course of doing their jobs. The result is an optical win that, in many cases, decays within a year.
- **Expanding manual requirements is not progress.** More mandatory steps without automation are likely to encourage workarounds as teams try to solve problems quickly.
- **Literal compliance is not security.** Producing rationales and auditing them satisfies the checkbox while the audits may add nothing, because low-quality manual rationales make review arbitrary.
- **Audit logs that are only consulted after incidents are underused.** Durable, pervasive logs still leave a gap if nothing proactively detects anomalous usage.
- **Role grants silently violate least privilege over time.** Without automatic expiry, tenure and team changes accumulate unused permissions.
- **Absence of misuse does not mean the controls work.** This company found no evidence of misuse, yet verification of its rationales was still somewhat arbitrary, and it was unclear whether the majority of the audits increased the security of users' data.
- **Don't assume a uniform industry standard exists.** RBAC and audit logging are standardized; resource-level access control is not, so peer practice varies and must be explored deliberately.
