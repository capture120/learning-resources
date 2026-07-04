# Chapter 22: Developer, API, and Acquisition Strategy at Stripe — Detailed Reference

## Chapter Introduction

The hypergrowth companies of the 2010s adopted a number of techniques to balance the constraints of running a rapidly growing business without being overwhelmed by the technical complexity created by quick expansion. Two common techniques were:

- Decomposing their monoliths
- Acquiring existing companies that had missing functionality

Both techniques are conceptually simple, but they went wrong for many of the companies that adopted them.

This chapter focuses on Stripe's somewhat atypical approaches to three specific challenges it encountered during that period:

1. API deprecation
2. Managing a large monolithic codebase
3. Integrating the Index acquisition

As an example of the atypical approach: Stripe did not decompose its monolithic Ruby codebase. It stuck with a centralized codebase as it grew past three thousand engineers. Even in 2025, Stripe has relied on techniques such as creating the Sorbet static type checker rather than migrating to a statically typed language or decomposing into isolated codebases.

Larson frames these documents as a particular testament to two things:

- **How much the details matter in strategy.** He imagines these approaches would not consistently work if adopted elsewhere.
- **The value of enduring strategy.** Almost all the impact of these strategies would have been undermined if they'd only lasted a year or two, but they've been remarkably effective over the course of a consistent decade of application.

## Reading These Documents

The chapter contains four documents:

**Document 22-1: How Should Stripe Deprecate APIs?**

While Stripe is widely admired for things like its creation of the Sorbet typer project, Larson personally thinks its most interesting strategy work is also among its most subtle: its willingness to significantly prioritize API stability. This strategy is almost invisible externally. Internally, discussions around it were frequent and detailed, but mostly confined to dedicated API design conversations. API stability isn't just a technical design quirk; it's a foundational decision in an API-driven business, and Larson believes it is one of the unsung heroes of Stripe's business success.

**Document 22-2: A Systems Model of API Deprecation**

While there was internal data to correlate deprecation with churn, this model was built to help decide whether to believe that correlation and causation were aligned in this case. A full implementation of the model is available on GitHub.

**Document 22-3: Why Did Stripe Build Sorbet?**

This strategy explains why Stripe chose to delay decomposition for so long, and how the Product Infrastructure team invested in developer productivity to deal with the challenges of a large Ruby codebase managed by a large software engineering team with low average tenure caused by rapid hiring.

Sorbet is a custom static and runtime type checker for Ruby, initially designed and implemented by Stripe engineers on their Product Infrastructure team. Stripe's Product Infrastructure team had similar goals to other companies' Developer Experience or Developer Productivity teams, but it focused on preventing errors and improving productivity through changes in the internal architecture of the codebase itself, rather than relying solely on external tooling or processes.

Larson explicitly acknowledges that this strategy was spearheaded by Stripe's Product Infrastructure team, not by him. Although he ultimately became responsible for that team, he can't take credit for the strategy's thinking. He was initially skeptical, preferring an incremental migration to an existing strongly typed programming language — either Java for library coverage or Golang for Stripe's existing familiarity. Despite his initial doubts, the Sorbet project eventually won him over with its "indisputable results."

**Document 22-4: How to Integrate Stripe's Acquisition of Index?**

Discussions around acquisitions often focus on technical diligence and deciding whether to make the acquisition. However, the integration that follows afterward can be even more complex. There are few irreversible trapdoor decisions in engineering, but decisions made early in an integration tend to be surprisingly durable.

This engineering strategy explores Stripe's approach to integrating its 2018 acquisition of Index. While a business book would focus on the rationale for the acquisition itself, here that rationale is merely part of the diagnosis that defines the integration tradeoffs. The integration itself is the area of focus.

Like most acquisitions, the team responsible for the integration only learned about the project after the deal closed, which means early efforts are a scramble to apply strategy testing to distinguish between optimistic dates and technical realities.

**How to read the documents:** To apply a strategy, start at the top with Policy. To understand the thinking behind a strategy, read the sections in reverse order, starting with Explore. More detail on this structure is in Chapter 11 of the book, as well as in "Making Engineering Strategies More Readable."

## Document 22-1: How Should Stripe Deprecate APIs?

### Policy and Operation

Stripe's policies for managing API changes:

**1. Design for long API lifetime.**

- APIs are not inherently durable. Durability must be designed in thoughtfully so the API can support change.
- When designing a new API, the prescribed steps are:
  1. Build a test application that doesn't use this API.
  2. Migrate that application to the new API.
  3. Consider how integrations might evolve as applications change.
  4. Perform these migrations yourself, so you understand the potential friction with your API.
  5. Then think about the future changes Stripe might want to implement on its end: how would those changes impact the API, and how would they impact the application you've developed?
- At this point, take the API to API Review for initial approval (as described in the next policy).
- Following that approval, identify a handful of early adopter companies who can place additional pressure on the API design, and test with them before releasing the final, stable API.

**2. All new and modified APIs must be approved by API Review.**

- API changes may not be enabled for customers prior to API Review approval.
- Change requests should be sent to the `api-review` email group.
- For examples of prior reviews, search the `api-review` archive for prior requests and the feedback they received.
- All requests must include a written proposal.
- Most requests will be approved asynchronously by a member of API Review. Complex or controversial proposals will require live discussions to ensure API Review members have sufficient context before making a decision.

**3. Never deprecate APIs without an unavoidable requirement to do so.**

- Even if it's technically expensive to maintain support, Stripe incurs that support cost.
- Explicit definition: **API deprecation is any change that would require customers to modify an existing integration.**
- If a deprecating change were to be approved as an exception to this policy, it must first be approved by API Review, followed by the CEO.
- One example of a granted exception: the deprecation of TLS 1.2 support, due to PCI compliance obligations.

**4. When significant new functionality is required, add a new API.**

- Example: Stripe created `/v1/subscriptions` to support subscription workflows rather than extending `/v1/charges` to add subscriptions support.
- Footnote (with the benefit of hindsight): a good example of this policy in action was the introduction of the Payment Intents API to maintain compliance with Europe's Strong Customer Authentication requirements. Even in that case, the charge API continued to work as it did previously, albeit only for non–European Union payments.

**5. Manage this policy's implied technical debt via an API translation layer.**

- Changed APIs are released into versions, tracked in the API version changelog.
- Only one implementation is maintained internally: the implementation of the latest version of the API.
- On top of that implementation, a series of version transformations are maintained, which allow Stripe to support prior versions without maintaining them directly.
- This approach doesn't eliminate the overhead of supporting multiple API versions, but it significantly reduces complexity by enabling Stripe to maintain just a single, modern implementation internally.
- All API modifications must also update the version transformation layers, to allow the new version to coexist peacefully with prior versions.

**6. In the future, SDKs may allow softening this policy.**

- While a significant number of customers have direct integrations with the APIs, that number has dropped significantly over time. Instead, most new integrations are performed via one of the official API SDKs.
- Stripe believes that in the future, it may be possible to make more backward-incompatible changes because the complexity of migrations can be absorbed into the SDKs Stripe provides. That is "certainly not the case yet today."

### Diagnosis

Stripe's diagnosis of the impact of API changes and deprecation on the business:

- **Difficulty varies sharply by customer type.** If you are a small startup composed of mostly engineers, integrating a new payments API seems easy. However, for a small business without dedicated engineers — or a larger enterprise involving numerous stakeholders — handling external API changes can be particularly challenging.
- **The case is robust even under a weak assumption.** Even if the previous point is only marginally true, the impact of minimizing API changes on long-term revenue growth has been modeled (Document 22-2), and it has a significant impact: it unlocks the ability to benefit from other churn reduction work.
- **Stability both prevents churn and retains customers.** Stripe believes API instability directly creates churn, and also believes that API stability directly retains customers by increasing the migration overhead even if they wanted to change providers. Without an API change forcing them to change their integration, hypergrowth customers are believed to be particularly unlikely to change payments API providers absent a concrete motivation like an API change or a payment plan change.
- **Competitors' deprecations reflect a real tradeoff, not ignorance.** Stripe is aware of relatively few companies that provide long-term API stability in general, and particularly few for complex, dynamic areas like payments APIs. One can't assume that companies that make API changes are ill-informed. Rather, it appears they experience a meaningful technical debt tradeoff between the API provider and API consumers, and aren't willing to consistently absorb that technical debt internally.
- **Future external requirements may force changes.** Future compliance or security requirements — along the lines of the upgrade from TLS 1.2 to TLS 1.3 for PCI — may necessitate API changes. There may also be new tradeoffs exposed as Stripe enters new markets with their own compliance regimes. However, Stripe has limited ability to predict these changes at this point.

## Document 22-2: A Systems Model of API Deprecation

### Learnings

- In an initial model that has a 10% baseline for customer churn per round, reducing the share of customers experiencing API deprecation from 50% to 10% per round only increases the steady state of integrated customers by about 5% (shown in Figure 22-1).
- However, if the baseline for customer churn is eliminated entirely (Figure 22-2), there is a massive difference between a 10% and a 50% rate of API deprecation.
- **Biggest takeaway:** eliminating API-deprecation churn alone won't significantly increase the number of integrated customers. However, you also can't fully benefit from reducing baseline churn without simultaneously reducing API deprecations. Meaningfully increasing the number of integrated customers requires lowering both types of churn in tandem.

### Sketch

The model is sketched starting with the happiest path (Figure 22-3): potential customers flow into engaged customers, and engaged customers become integrated customers. This represents a customer who decides to integrate with Stripe's APIs and successfully completes that integration process.

Business would be good if that were the entire problem space. Unfortunately, customers occasionally churn. Churn is represented in two ways:

- **Baseline churn:** integrated customers leave Stripe for any number of reasons, including things like dissolution of their company.
- **Experience deprecation followed by Deprecation-influenced churn:** the scenario where a customer decides to leave after an API they use is deprecated.

There is also a **Reintegrated** flow, where a customer impacted by API deprecation can choose to update their integration to comply with the API changes.

Pulling things together, the final sketch (Figure 22-4) shows **five stocks and six flows**.

Additional dynamics could be modeled, such as recovery of churned customers, but it seems unlikely that this would significantly influence the understanding of how API deprecation impacts churn — so it was deliberately left out.

### Reason

- In terms of acquiring customers, the most important flows are customer acquisition and initial integration with the API. Optimizing those flows will increase the number of existing integrations.
- The flows driving churn are baseline churn and the combination of API deprecation plus deprecation-influenced churn.
- It's difficult to move baseline churn for a payments API: many churning customers leave due to company dissolution. From a revenue-weighted perspective, baseline churn is largely driven by non-technical factors, primarily pricing. In either case, it's challenging to impact this flow without significantly lowering margin.
- Engineering decisions, on the other hand, have a significant impact on both the number of API deprecations and the ease of reintegration after a migration.
- Because the same work to support reintegration also supports the initial integration experience, that's a promising opportunity for investment (one investment serving two flows).

### Model

The full implementation of the model is available on GitHub for those who want to see more than the emphasized snippets.

Having identified the most interesting avenues for experimentation, the model is developed to evaluate which flows are most impactful. The initial model specification:

```
# User Acquisition Flow
[PotentialCustomers] > EngagedCustomers @ 100
# Initial Integration Flow
EngagedCustomers > IntegratedCustomers @ Leak(0.5)
# Baseline Churn Flow
IntegratedCustomers > ChurnedCustomers @ Leak(0.1)
# Experience Deprecation Flow
IntegratedCustomers > DeprecationImpactedCustomers @ Leak(0.5)
# Reintegrated Flow
DeprecationImpactedCustomers > IntegratedCustomers @ Leak(0.9)
# Deprecation-Influenced Churn
DeprecationImpactedCustomers > ChurnedCustomers @ Leak(0.1)
```

On whether these values are reasonable:

- It depends largely on how you think about the length of each round. If a round were a month, then assuming half of integrated customers would experience an API deprecation would be quite extreme. If a round were a year, the rate would still be high, but there are certainly some API providers that routinely deprecate at that rate.
- From Larson's personal experience: Facebook's Ads API deprecated at least one important field on a quarterly basis in the 2012–2014 period.
- Admittedly, for a payments API a 50% rate would be high; it is intended primarily as a contrast with more reasonable values in the Exercise section.

### Exercise

The goal of exercising this model is to understand how much API deprecation impacts customer churn. The approach: chart the initial baseline (Figure 22-5), then compare it with a variety of scenarios until intuition develops for how the lines move.

**Baseline run:** The initial chart stabilizes in about 40 rounds, maintaining about 1,000 integrated customers and 400 customers dealing with deprecated APIs.

**Scenario 1 — reduce deprecation exposure.** Change the Experience deprecation flow to impact significantly fewer customers:

```
# Initial setting with 50% experiencing deprecation per round
IntegratedCustomers > DeprecationImpactedCustomers @ Leak(0.5)

# Less deprecation, only 10% experiencing per round
IntegratedCustomers > DeprecationImpactedCustomers @ Leak(0.1)
```

Comparing the two scenarios (Figure 22-6): lowering the deprecation rate significantly reduces the number of companies dealing with deprecations at any given time, but it has a relatively small impact on increasing the steady state for integrated customers. This must mean another flow is significantly impacting the size of the Integrated customers stock.

**Scenario 2 — zero out baseline churn.** Since there's only one other flow impacting that stock — Baseline churn — that's the next one to exercise. Set the Baseline churn flow to zero and compare with the initial model:

```
# Initial Baseline Churn Flow
IntegratedCustomers > ChurnedCustomers @ Leak(0.1)

# Zeroed out Baseline Churn Flow
IntegratedCustomers > ChurnedCustomers @ Leak(0.0)
```

These results make a compelling case that baseline churn is dominating the impact of deprecation. With no baseline churn, the number of integrated customers stabilizes at around 1,750, as opposed to around 1,000 for the initial model (Figure 22-7).

**Scenario 3 — no baseline churn, varying deprecation.** Compare two scenarios without baseline churn (Figure 22-8): one with high API deprecation (50%) and one with low API deprecation (10%).

- With a 10% API deprecation rate, integrated customers reach about 6,000, versus about 1,750 for a 50% deprecation rate.
- More importantly, in the 10% scenario the integrated customers line shows no sign of flattening: it continues to grow over time rather than stabilizing.

**Takeaways:** Significantly reducing either baseline churn or API deprecation magnifies the benefits of reducing the other. These results also reinforce the value of treating churn reduction as a system-level optimization, not merely a collection of discrete improvements.

## Document 22-3: Why Did Stripe Build Sorbet?

### Policy and Operation

The Product Infrastructure team is investing in Stripe's developer experience as follows.

**Operating model:**

- Every six months, Product Infrastructure selects its three highest-priority areas to focus on, and invests a significant majority of its energy into those. It provides minimal support for other areas.
- The team commits to refreshing its priorities every half, after running the developer productivity survey.
- Results and priorities are shared in each Quarterly Business Review.

**The three highest-priority areas for this half:**

1. Add static typing to the highest-value portions of the Ruby codebase, such that the type checker can run locally and on the test machines to identify errors more quickly.
2. Support selective test execution such that engineers can quickly determine and run the most appropriate tests on their machine rather than delaying until tests run on the build server.
3. Instrument test failures such that there is better data to prioritize future efforts.

**Priority 1 — static typing (Sorbet):**

- Static typing is not a typical solution to developer productivity, so it requires explanation as the highest-priority area for investment — doubly so given the acknowledgment that it will take 12–24 months of much of the team's time to get the type checker to an effective place.
- The type checker, planned to be named Sorbet, will allow Stripe to continue developing within the existing Ruby codebase. It will further allow product engineers to remain focused on developing new functionality rather than migrating existing functionality to new services or programming languages. Instead, the Product Infrastructure team will centrally absorb both the development of the type checker and the initial rollout to the codebase.
- It's possible for Product Infrastructure to take on both, despite its fixed size, by relying on a hybrid approach: deep-dives to add typing to particularly complex areas, and scripts to rewrite the code's Abstract Syntax Trees (AST) for less complex portions.
- Bounded downside: in the relatively unlikely event that this approach fails, the cost to Stripe is of a small, known size — approximately six months of half the Product Infrastructure team, which is what is anticipated to be required to determine if the approach is viable.
- Performance expectation: based on knowledge of Facebook's Hack project, the team believes it can build a static type checker that runs locally and is significantly faster than the test suite. It's hard to make a precise guess now, but the expectation is that it will take less than 30 seconds to type the entire codebase, despite the codebase being quite large. This will allow for a highly productive local development experience, even if local testing cannot be sped up.
- Even if local testing is sped up, typing would help eliminate one category of errors that testing has been unable to eliminate: the passing of unexpected types across code paths that have been tested for expected scenarios but not for entirely unexpected scenarios.
- Incremental value: once the type checker has been validated, typing can be incrementally prioritized into the highest-value places across the codebase. The codebase does not need to be wholly typed before meaningful value starts accruing.
- In support of the static-typing efforts, the team will advocate for product engineers at Stripe to begin development using the Command Query Responsibility Segregation (CQRS) design pattern, which is believed to provide high-leverage interfaces for incrementally introducing static typing into the codebase.

**Priority 2 — selective test execution:**

- Selective test execution will allow developers to quickly run appropriate tests locally, letting engineers stay in a tight local development loop and speeding up development of high-quality code.
- Given that the codebase is not currently statically typed, inferring which tests to run is rather challenging. With very high test coverage, and the fact that all tests will still be run before deployment to the production environment, the team believes it can rely on statistically inferring which tests are likely to fail when a given file is modified.

**Priority 3 — instrumenting test failures:**

- This is the third and lowest-priority project for this half.
- The focus this half is purely on annotating errors for which there is high conviction about their source, whether infrastructure or test issues.

**Escalations and issues:** reach out in the `#product-infra` channel.

### Diagnose

**Company context (2017):**

- Stripe is a company of about 1,000 people, including 400 software engineers.
- The organization aims to grow by about 70% year-over-year to meet increasing demand for a broader product portfolio and to scale existing products and infrastructure to accommodate user growth.
- As production stability has improved over the past several years, focus has now turned toward improving developer productivity.

**The current diagnosis of developer productivity:**

- Developer productivity for Ruby-authoring software engineers is primarily funded via the Product Infrastructure team. The Ruby-focused portion of that team has about 10 engineers today and is unlikely to significantly grow in the future. (If it does expand, it is likely to staff non-Ruby ecosystems like Scala or Golang.)
- There are two primary mechanisms for understanding engineers' developer experience:
  1. Standard productivity metrics around deploy time, deploy stability, test coverage, test time, test flakiness, and so on.
  2. A twice-a-year developer productivity survey.
- **Productivity metrics findings:** test coverage remains extremely high — above 99% of lines — and tests are quite slow to run locally. They run quickly in Stripe's infrastructure because they are multiplexed across a large fleet of test runners.
- **Local-testing failure mode:** tests have become slow enough to run locally that an increasing number of developers run an overly narrow subset of tests, or skip running tests entirely until after pushing their changes. They instead rely on the test servers to run against their pull request's branch. This works well enough, but it significantly slows down developer iteration time because the merge, build, and test cycle takes 20 to 30 minutes to complete. By the time their build-test cycle completes, they've lost their focus and may take several hours to return to addressing the results.
- **Flakiness dispute:** there is significant disagreement about whether tests are becoming flakier due to test infrastructure issues or due to quality issues in the tests themselves. At this point, there is no trustworthy dataset that allows distinguishing between those two causes.
- **Survey findings:** feedback from the twice-a-year developer productivity survey supports the above diagnosis and adds nuance. Most concerning: although long-tenured Stripe engineers find themselves highly productive in the codebase, the survey increasingly reports that newly hired engineers with long tenures at other companies find themselves unproductive in the codebase. Specifically, they find it very difficult to determine how to safely make changes.
- **Codebase shape:** the product codebase is entirely implemented in a single Ruby monolith, with one narrow exception — a Golang service handling payment tokenization — which is considered out of scope for two reasons:
  1. It is kept intentionally narrow in order to absorb Stripe's SOC1 compliance obligations.
  2. Developers in that environment have not raised concerns about their productivity.
- **Data infrastructure:** implemented in Scala. These developers have concerns — primarily slow build times — but they manage their build and deployment infrastructure independently, and the group remains relatively small.
- **Why Ruby stays:** Ruby is not a highly performant programming language, but it has been found sufficiently efficient for Stripe's needs. Similarly, other languages are more cost-efficient from a compute resources perspective, but a significant majority of Stripe's spend is on real-time storage and batch computation. For these reasons alone, Stripe would not consider replacing Ruby as its core programming language.
- **The leverage math:** the Product Infrastructure team is about 10 engineers supporting about 250 product engineers. This group is anticipated to grow modestly over time, but certainly sublinearly to the overall growth of product engineers.
- **Language-fragmentation pressure:** developers working in Golang and Scala routinely ask for more centralized support, but it's challenging to prioritize those requests when forced to consider the return on improving the experience for 240 product engineers working in Ruby versus 10 in Golang or 40 data engineers in Scala.
- **Conclusion on new languages:** if more programming languages were introduced, this prioritization problem would become increasingly difficult — and Stripe is already failing to support the additional languages it has.

## Document 22-4: How to Integrate Stripe's Acquisition of Index?

### Policy and Operation

Starting context: there is little shared context between the acquired and acquiring engineering teams, and there is a six-month timeline to launch a joint product. The starting policy is therefore **a mix of a commitment to joint refinement and several provisional architectural policies**:

- **Meet at least weekly until the initial release is complete.** The involved leadership from Stripe and Index will hold a weekly sync meeting to refine the approach until the initial release timeline is fulfilled. This meeting is jointly owned by Stripe's Head of Traffic Engineering and Index's Head of Engineering.
- **Minimize changes to the tokenization environment.** Because point-of-sale devices directly work with customer payment details, the API that directly supports the point-of-sale device must live within the secured environment where payment details are stored. However, any other functionality must not be added to the tokenization environment.
- **All other functionality must exist in standard environments.** Except for the minimum necessary functionality moving into the tokenization environment, everything else must be operated in the standard, non-tokenization environments. In particular, any software that requires frequent changes, or introduces complex external dependencies, should exist in the standard environments.
- **Defer making a decision regarding the introduction of Java to a later date.** The introduction of Java is incompatible with Stripe's existing engineering strategy, but at this point stakeholders also could not be aligned on how to address this decision. Further, attempting to address this issue is seen as a distraction from the timely goal of launching a joint product within six months. The discussion will be taken up after launching the initial release.
- **Escalations come to paired leads.** Given limited shared context across teams, all escalations must come to both Stripe's Head of Traffic Engineering and Index's Head of Engineering.
- **Security review of changes impacting the tokenization environment.** The team needs to move quickly to launch the combined point-of-sale and payments product, but must not cut corners on security to launch faster. Security must be included and must explicitly sign off on any integration decisions that involve the tokenization environment.

### Diagnose

**Taxonomy of acquisitions.** There are generally four categories:

1. **Talent acquisitions** — to bring on a talented team.
2. **Business acquisitions** — to buy a company's revenue and product.
3. **Technology acquisitions** — to add a differentiated capability that would be challenging to develop internally.
4. **Time-to-market acquisitions** — where you could develop the capability internally but can develop it meaningfully faster by acquiring a company.

While most acquisitions have a flavor of several of these dimensions, this acquisition is primarily a **time-to-market acquisition**, aimed at addressing these constraints:

- Several of Stripe's largest customers are pushing for a point-of-sale device integrated with Stripe's API-driven payments ecosystem. At least one has implied that Stripe either provides this functionality on a committed timeline or they may churn to a competitor.
- Stripe currently has no homegrown expertise in developing or integrating with hardware such as point-of-sale devices. Based on other zero-to-one efforts internally, the belief is it would take about a year to hire the team and develop and launch a minimum viable product for a point-of-sale device integrated into the platform.
- Where Stripe has taken a horizontal approach to supporting web payments via an API, at least one competitor — Square — has taken a vertically integrated approach. While Square's API ecosystem is less developed than Stripe's, they are a plausible destination for customers threatening to churn.
- Stripe believes that at least one of its enterprise customers will churn if the best commitment is launching a point-of-sale solution 12 months from now.
- Stripe has decided to acquire a small point-of-sale startup, which it will use to commit to a six-month timeframe for supporting an integrated point-of-sale device with its API ecosystem.
- The acquired startup will need to be rapidly integrated to meet this timeline. Only a small number of details are known about what this will entail. It is known that point-of-sale devices directly operate on payment details (i.e., the point-of-sale device knows the credit card details of the card it reads).
- Compliance obligations restrict such activity to the "tokenization environment": a highly secured and isolated environment with direct access to payment details. This environment converts payment details into a unique token that other environments can utilize to operate against payment details without the compliance overhead of having direct access to the underlying payment details.
- Going into the technical integration, few details are known about the acquired company's technology stack. What is known: they are primarily a Java shop running on AWS, whereas Stripe is primarily a Ruby (with some Go) shop running on AWS.

### Explore

Prior to this acquisition, Stripe had done several small acquisitions. None of those acquisitions had a meaningful product to integrate with Stripe's, so there isn't much of an internal playbook in which to anchor the approach.

There is limited experience integrating technical acquisitions from prior companies the team members worked in, along with conversations with peers at other companies to mine their experience. Synthesizing those experiences, the recurring patterns are:

1. **Hidden deal commitments.** Usually, deal teams have made certain commitments, or the acquired team has understood certain commitments, that will be challenging to facilitate. This is doubly true when you are unaware of what those commitments might be. If folks seem to be behaving oddly, it might be one such misunderstanding, and it's worth engaging directly to debug the confusion.
2. **Executive sponsor.** There should be an executive sponsor for the acquisition, and the sponsor is typically the best person to ask about the company's intentions. If you can't find the executive sponsor, or they are not engaged, try to recruit a new executive sponsor rather than trying to make things work without one.
3. **Culture gap.** Close the culture gap quickly where there's little friction, and cautiously where there's little trust. The acquired company does need to be brought into the acquirer's culture, but there are years to do that. The most successful stories of doing this leaned on a mix of moving folks into and out of the acquired team rather than applying force.
4. **Technology stack.** The long-term cost of supporting a new technology stack is high, and in conflict with Stripe's technology strategy of consolidating on as few programming languages as possible. This is not the place to be flexible, as each additional feature in the new stack takes you further from your desired outcome.
5. **Derisk key departures.** Things can go wrong quickly. One of the easiest starting points is consolidating infrastructure immediately, even if the product or software takes longer.

Altogether, this was not the most reassuring exploration: it was a bit abstract, and much of the research returned strongly held, conflicting perspectives. Perhaps acquisitions, like starting a new company, are among those places where there's simply no right way to do it well.

## Summary

Reiterating the chapter introduction, what Larson finds most valuable about these documents is that they're a great example of not following the standard patterns of the time they were written:

- API deprecations were viewed as essential for maintaining developer velocity, but Stripe largely eschewed them.
- Decomposing monolithic codebases into isolated services and reusable libraries was viewed as a foundational strategy for both reliability and developer velocity, but Stripe didn't do it.
- Integrating acquisitions is always tricky, especially when there's a tight timeline to bring the product to market, but Stripe found a path forward.

One way to frame the successes here is around thinking from first principles, and Larson thinks that's a useful framing. However, he thinks an even more useful framing is that **the extremely detail oriented, enduring first-principles thinking was the deciding factor between these strategies' success and failure.**

## Footnote

1. With the benefit of hindsight, a good example of the "add a new API for significant new functionality" policy in action was the introduction of the Payment Intents API to maintain compliance with Europe's Strong Customer Authentication requirements. Even in that case, the charge API continued to work as it did previously, albeit only for non–European Union payments.
