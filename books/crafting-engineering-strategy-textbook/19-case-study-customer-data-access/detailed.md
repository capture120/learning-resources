# Chapter 19: Customer Data Access Strategy — Detailed Reference

## Chapter Introduction

At some point in a startup's lifecycle, its leaders decide that they need to be ready to go public in 18 months, and a flurry of IPO-readiness activity kicks off. This strategy focuses on a company working on IPO readiness that has identified a gap in internal controls for managing user data access.

The company wants to meaningfully improve its security posture around user data access, but it has had a number of failed security initiatives over the years. Most of those initiatives failed because they significantly degraded internal workflows for teams like customer support, reverting and subverting the initial progress over time and eventually resulting in little long-term effect.

This strategy represents the Chief Information Security Officer's (CISO's) attempt to:

1. Acknowledge and overcome those historical challenges,
2. While meeting the company's IPO readiness obligations, and
3. Most importantly, doing right by its users.

## Reading This Document

This chapter contains just one document, Document 19-1: How Should We Control Access to User Data?, from 2022. Security topics are always sensitive, and as such this document is not from any given company; it is rather the amalgamation of experiences at several distinct companies.

Reading guidance:

- If you are reading the document with the goal of applying the strategies it puts forward, start at the top and read to the end.
- If, on the other hand, your main goal is to understand the thinking behind it, read the sections in reverse order, starting with Explore, then Diagnose, and so on.

Chapter 11 explains this approach to separating reading from thinking and details the general structure of strategy documents. Larson's commentary appears in the footnotes.

## Document 19-1: How Should We Control Access to User Data?

Structural note (Larson's footnote 1, anchored to the opening of Policy and Operations): relative to the default strategy document structure, this document has been refactored in two ways to improve readability. First, Operation has been folded into Policy. Second, Refine has been embedded in Diagnose.

### Policy and Operations

The document opens: "Our new policies, and the mechanisms to operate them, are:" — followed by the full policy set below.

**1. Controls for accessing user data must be significantly stronger prior to our IPO.**

- Senior leadership, legal, compliance, and security have decided that they are not comfortable accepting the status quo of the company's user data access controls as a public company.
- The company must meaningfully improve the quality of resource-level access controls as part of its pre-IPO readiness efforts. Resource-level access controls are defined by example: how the company determines which rows, rather than which tables, a user has permission to access.
- The Security team is accountable for the exact mechanisms and approach to addressing this risk.

**2. We will continue to prioritize a hybrid solution to resource-access controls.**

- This has been the company's approach thus far, and it is the fastest available option. (The hybrid pattern itself is defined in the Explore section: a third-party platform handles most actions and also gates resource-level access within the first-party system.)

**3. Directly expose the log of our resource-level accesses to our users.**

- The company will build toward a user-accessible log of all company accesses of user data, and ensure it is comfortable explaining each and every access.
- In addition, this means that each rationale for access must be comprehensible and reasonable from a user perspective.
- Why this matters: it aligns the company's approach with its users' perspectives. Users will be able to evaluate how the company accesses their data, and make decisions about continuing to use the product based on whether they agree with that use.

**4. Good security discussions don't frame decisions as a compromise between security and usability.**

- The company will pursue multi-dimensional tradeoffs to simultaneously improve security and efficiency.
- Diagnostic rule: "Whenever we frame a discussion as trading off between security and utility, it's a sign that we are having the wrong discussion, and that we should rethink our approach."

**5. We will prioritize mechanisms that can both automatically authorize and document the rationale for access to customer data.**

- The most obvious example: automatically granting access to a customer support agent for users who have an open support ticket assigned to that agent, and removing that access when that ticket is reassigned or resolved.

**6. Measure progress on percentage of customer data access requests justified by a user-comprehensible, automated rationale.**

- This metric will anchor the approach on simultaneously improving the security of user data and the usability of colleagues' internal tools.
- If the company only expands requirements for accessing customer data, it won't view this as progress, because it's not automated — and consequently is likely to encourage workarounds as teams try to solve problems quickly.
- Similarly, if the company only improves usability, the charts won't represent this as progress, because the number of supported requests will not have increased.
- As part of this effort, the company will create a private channel where the security and compliance team has visibility into all manual rationales for user data access, and will notify the manager of anyone who repeatedly uses a manual justification for accessing user data.

**7. Expire unused roles to move toward the principle of least privilege.**

- Today the company has a number of roles granted in its role-based access control (RBAC) system to users who do not use the granted permissions.
- To address that issue, roles will be automatically removed from colleagues after 90 days of not using the role's permissions.
- Exception: engineers in an active on-call rotation are exempt from this automated permission pruning.

**8. Weekly reviews until we see progress; monthly access reviews in perpetuity.**

- Starting now, there will be a weekly sync between the Security Engineering team, the teams working on customer data access initiatives, and the CISO. This meeting will focus on rapid iteration and problem solving.
- This is explicitly a forum for ongoing strategy testing, with the CISO serving as the meeting's sponsor, and the Principal Security Engineer serving as the meeting's guide.
- The weekly sync will continue until there is clarity on the path to 100% coverage of user-comprehensible, automated rationales for access to customer data.
- Separately, the company is also starting a monthly review of sampled accesses to customer data to ensure the proper usage and function of the rationale-creation mechanisms being built.
- The monthly meeting's goal is to review access rationales for quality and appropriateness, both by reviewing sampled rationales in the short term, and by identifying more automated mechanisms for identifying high-risk accesses to review in the future.

**9. Exceptions must be granted in writing by the CISO.**

- The company's overarching Engineering Strategy states that it follows an advisory architecture process as described in *Facilitating Software Architecture* (Andrew Harmel-Law, O'Reilly, 2024).
- The customer data access policy is an exception to that advisory process: deviations must be explicitly approved, with documentation, by the CISO.
- The intake path for that approval process is the #ciso channel.

### Diagnose

(Per the footnote, the Refine section has been embedded into this Diagnose section.)

**Baseline strengths and their limits:**

- The company has a strong baseline of RBAC and audit logging.
- However, it has limited mechanisms for ensuring assigned roles follow the principle of least privilege. This is particularly true in cases where individuals change teams or roles over the course of their tenure at the company: some individuals have collected numerous unused roles over five-plus years at the company.
- Similarly, the audit logs are durable and pervasive, but there are limited proactive mechanisms for identifying anomalous usage. Instead, the logs are typically used to understand what occurred after an incident has already been identified by other mechanisms.

**Current state of resource-level access controls:**

- For resource-level access controls, the company relies on a hybrid approach between a third-party platform for incoming user requests, and approval mechanisms within its own product.
- Providing a rationale for access across these two systems requires manual work, and those rationales are later manually reviewed for appropriateness in a batch fashion.
- There are two major ongoing problems with the current approach:
  1. The teams making requests view them as a burdensome obligation without much benefit to them or on behalf of the user.
  2. Because the rationale review steps are manual, there is no verifiable evidence of the quality of the review.

**No misuse, yet low-quality verification:**

- No evidence of misuse of user data has been found. When colleagues do access user data, the company has uniformly and consistently found that there is a clear and reasonable rationale for that access. Example: a ticket in the user support system where the user has raised an issue.
- However, the quality of the documented rationales is consistently low, because it depends on busy people manually copying over significant information many times a day.
- Because the rationales are of low quality, the verification of these rationales is somewhat arbitrary.
- From a literal compliance perspective, the company does provide rationales and auditing of these rationales, but it's unclear if the majority of these audits increase the security of users' data.

**The historical failure pattern:**

- Historically, the company has made significant security investments that caused temporary spikes in its security posture.
- However, looking at those initiatives a year later, in many cases there is a pattern of increased scrutiny followed by a gradual repeal or avoidance of the new mechanisms.
- The company found that most of those initiatives involved increased friction for essential work performed by other internal teams. In the natural order of performing work, those teams would subtly subvert the improvements because the improvements interfered with their immediate goals (e.g., supporting customer requests).

**Conclusion, with calibrated conviction:**

- From its track record, the company has high conviction that the historical approach can create optical wins internally.
- It has limited conviction that the historical approach can create long-term improvements, outside of significant, unlikely internal changes (e.g., colleagues being markedly less busy a year from now than they are today).
- It therefore seems likely the company needs a new approach to meaningfully shift its stance on these kinds of problems.

### Explore

**Availability of best practices:**

- The company's experience is that best practices around managing internal access to user data are widely available through its networks, and otherwise hard to find.
- The exact rationale for this scarcity is hard to determine, but it seems possible that it's a topic folks are generally uncomfortable discussing in public on account of potential future liability and compliance issues.

**Findings:** the exploration found two standardized dimensions (role-based access controls, audit logs) and one highly divergent dimension (resource-specific access controls).

- **Role-based access controls (RBAC)** are a highly standardized approach at this point. The core premise: users are mapped to one or more roles, and each role is granted a certain set of permissions. Example: a role representing the customer support agent might be granted permission to deactivate an account, whereas a role representing the sales engineer might be able to configure a new account.
- **Audit logs** are similarly standardized. All access and mutation of resources should be tied in a durable log to the human who performed the action. These logs should be accumulated in a centralized, queryable solution. One of the core challenges is determining how to utilize these logs proactively to detect issues, rather than reactively once an issue has already been flagged.
- **Resource-level access controls** are significantly less standardized than RBAC or audit logs. The exploration found three distinct patterns adopted by companies, with little consistency across companies on which pattern is adopted.

**The three patterns for resource-level access control:**

1. **Third-party enrichment**: access to resources is managed in a third-party system such as Zendesk.
   - This requires enriching objects within those systems with data and metadata from the product(s) where those objects live.
   - It also requires implementing actions on the platform, such as archiving or configuration, allowing them to live entirely in that platform's permission structure.
   - Downsides: tight coupling with the platform vendor, any limitations inherent to that platform, and the overhead of maintaining engineering teams familiar with both the internal technology stack and the platform vendor's technology stack.
2. **First-party tool implementation**: all activity, including creation and management of user issues, is managed within the core product itself.
   - This pattern is most common in earlier-stage companies, or companies whose customer support leadership "grew up" within the organization without much exposure to the approach taken by peer companies.
   - Advantage: a single, tightly integrated and infinitely extensible platform for managing interactions.
   - Downside: you have to build and maintain all of that work internally, rather than pushing it to a vendor that ought to be able to invest more heavily into their tooling.
3. **Hybrid solutions**: a third-party platform is used for most actions and is also used to permit resource-level access within the first-party system.
   - Example: you might be able to access a user's data only while there is an open ticket created by that user, and assigned to you, in the third-party platform.
   - Advantages: this allows the support of complex workflows that don't fit within the platform's limitations, and allows you to avoid complex coupling between your product and the vendor platform.

**Overall industry pattern:**

- Generally, the company's experience is that all companies implement RBAC, audit logs, and one of the resource-level access control mechanisms.
- Most companies pursue either third-party enrichment, with a sizable, long-standing team owning the platform implementation, or rely on a hybrid solution, where they are able to avoid creating a longstanding dedicated team by lumping that work into existing teams.

## Summary

Larson finds two dimensions of this strategy document particularly interesting:

1. It is a concrete example of using strategy testing led by an executive to work through misalignment across teams. This is the most effective mechanism he has found for working through persistent organizational friction.
2. It shows how policy can be used to explicitly constrain a team into alignment. With this strategy, the Security team's prior behaviors were effectively outlawed, creating a path to a more effective mode of working.
