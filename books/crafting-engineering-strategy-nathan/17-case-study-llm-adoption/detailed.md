# Chapter 17: LLM Adoption Strategy — Detailed Reference

## Chapter Introduction

Whether you're a product engineer, a product manager, or an engineering executive, you've probably been pushed to consider using LLMs to extend your product or enhance your processes. LLM capabilities transitioned into the mainstream starting around 2023, and even though most integrations appear superficial, many companies worry that they're falling behind. That context makes LLM adoption a great topic for a strategy case study.

The chapter contains engineering strategy documents written to determine how a hypothetical company, called **Theoretical Ride Sharing**, should adopt LLMs. The company's profile:

- 2,000 employees, of whom 300 are software engineers
- $400 million raised
- $50 million in annual revenue
- Operating in 200 cities across North America and Europe
- A ride-sharing business similar to Uber or Lyft, but its innovation is to use larger vehicles — essentially, reinventing public transit

## Reading These Documents

The chapter contains four documents:

- **Document 17-1: How Should We Adopt Large Language Models?** — A strategy document that considers how adopting LLMs might impact the company's developer experience.
- **Document 17-2: Modeling LLMs' Impact on the Developer Experience** — A systems model of the software development process at this company.
- **Document 17-3: Wardley Mapping the LLM Ecosystem** — A map of the LLM space focusing on how product companies should address the proliferation of model providers (such as Anthropic, Google, and OpenAI) and LLM product patterns like agentic workflows and retrieval-augmented generation (RAG). It also discusses running evaluations to maintain performance as models change.
- **Document 17-4: Modeling Driver Onboarding** — A model examining whether LLMs might improve a core product and business problem: maximizing active drivers on the company's ride-sharing platform.

Reading order guidance:

- If your goal is **applying** the strategies, start at the top and read to the end.
- If your goal is **understanding the thinking** behind them, read the sections in reverse order: starting with Explore, then Diagnose, and so on. (Chapter 11 covers this structure in more detail.)

As with the other chapters in Part IV, "Case Studies," this chapter reproduces a set of documents, provides context and commentary in footnotes, and concludes by drawing out key takeaways.

A structural note (the chapter's footnote 1): relative to the book's default strategy structure, Document 17-1 has been refactored in two ways to improve readability. First, **Operation has been folded into Policy**; second, **Refine has been embedded in Diagnose**.

## Document 17-1: How Should We Adopt Large Language Models?

### Policy

The combined policy for using LLMs at Theoretical Ride Sharing:

1. **Develop an LLM-backed process for reactivating departed and suspended drivers in mature markets.** Through modeling the driver lifecycle, the company determined that improving onboarding time will have little impact on the total number of active drivers. Instead, the focus is on mechanisms to reactivate departed and suspended drivers, which is "the only opportunity to meaningfully impact active drivers."
   - *Operation:* Report on progress monthly in the Exec Weekly Meeting, coordinated in #exec-weekly.

2. **Start with Anthropic.** The company uses Anthropic models, which are available through its existing cloud provider via AWS Bedrock. To avoid maintaining multiple implementations — where the underlying foundational model quality is viewed as somewhat undifferentiated — the company is not looking to adopt a broad set of LLMs at this point. This decision is anchored in the Wardley map of the LLM ecosystem (Document 17-3).
   - *Operation:* Exceptions will be reviewed by the Machine Learning Review in #ml-review.

3. **The Developer Experience team (DX) must offer at least one LLM-backed developer productivity tool.** This tool should enhance the experience, speed, or quality of writing software in TypeScript. It should help develop the company's thinking for next year, such that there is conviction about increasing — or decreasing — the investment. The tool should be available to all engineers. Adopting one tool is the required baseline; if DX identifies further interesting tools (e.g., GitHub Copilot), they are empowered to bring the request to the Engineering Exec team for review. Review will focus on balancing three criteria: **rate of learning, vendor cost, and data security**. Options for measuring LLMs' impact on developer experience have been modeled (Document 17-2).
   - *Operation:* Vendor approvals to be reviewed in the #cto internal chat channel.

4. **The Internal Tools team (INT) must offer at least one LLM-backed ad hoc prompting tool.** This tool should support arbitrary non-engineering use cases for LLMs, such as text extraction, rewriting notes, and so on. It must be usable with customer data while also honoring the company's existing data-processing commitments. The tool should be available to all employees.
   - *Operation:* Vendor approvals to be reviewed in #coo.

5. **Refresh the policy in six months.** The primary goal is to quickly learn about this unfamiliar domain where the company has limited internal expertise, then review whether to increase the investment afterward.

6. **Flag questions and suggestions in the #cto internal chat channel.**

### Diagnose

A summary of the challenges Theoretical Ride Sharing faces in adopting LLMs:

- **There are, at minimum, three distinct needs** that people internally are asking to be solved (either separately or with a shared solution):
  - Productivity tools for non-engineers — e.g., ad hoc document rewriting, document summarization
  - Productivity tools for engineers — e.g., advanced autocomplete tooling like GitHub Copilot
  - Product extensions — e.g., high-quality document extraction in driver onboarding workflows

- **Only product extensions are potential strategic differentiation.** The other two are workflow optimizations that improve productivity but don't necessarily differentiate the company from the broader industry. The opportunities for strategic differentiation identified:
  - **Reactivating departed and suspended drivers** is the largest lever to increasing active drivers, as explored in the driver lifecycle model (Figure 17-4 / Document 17-4).
  - **Faster driver onboarding with less human involvement** will not increase active drivers, but there is a clear opportunity for LLMs to reduce operating costs — which may be worthwhile even if it doesn't address the core problem of active drivers.
  - **Improved customer support** by increasing the response speed and quality of responses to customer inquiries.

- **The company currently has limited experience or expertise in using LLMs — and so does the industry.** Prolific thought leadership to the contrary, there are very few companies or products using LLMs in scaled, differentiated ways. That's currently true for Theoretical as well.

- **The company wants to develop its expertise without making an irreversible commitment.** Internal expertise is seen as a limiter for effective problem selection and utilization of LLMs; developing expertise will make the company more effective in iterative future decisions on this topic. Conversely, making a major investment now, prior to developing in-house expertise, would be relatively high risk and low reward, given that no other industry players appear to have identified a meaningful advantage at this point.

- **Switching across foundational models and foundational model providers is cheap.** This is true both economically (low financial commitment) and from an integration cost perspective (APIs and usage are largely consistent across providers).

- **Foundational models and providers are evolving rapidly, and it's unclear how the space will evolve.** It's likely that current foundational model providers will train one or two additional generations of foundational models with larger datasets, but at some point training will become cost prohibitive (e.g., the next major versions of OpenAI or Anthropic models seem likely to cost $500M+ to train). Differentiation might move into developer experience at that point. Open source models like LLaMa might become significantly cost-advantaged. Or something else entirely — "the future is wide open." A Wardley map (Document 17-3) was built to understand the possible evolution of the foundational model ecosystem.

- **Training a foundational model is prohibitively expensive for the company's needs.** The company has raised $400M; training a competitive foundational model would cost somewhere between $3M and $100M to match the general models provided by Anthropic or OpenAI.

### Explore

**Foundational model training economics.** LLMs operate on top of a foundational model. Training these foundational models is exceptionally expensive, and growing more expensive over time as competition for more sophisticated models accelerates:

- Meta allegedly spent $20–30 million training LLaMa 2, up from about $3 million in training costs for LLaMa 1.
- OpenAI's GPT-4 allegedly cost $100 million to train.

With some nuance related to the quality of corpus and its relevance to the task at hand, larger models outperform smaller models. There's therefore not much incentive to train a smaller foundational model unless you have a large, unique dataset to train against — and even in that case you might be better off fine-tuning or using in-context learning (ICL).

**Inference pricing.** Anthropic charges between $0.25 and $15 per million tokens of input, and a bit more for output tokens. OpenAI charges between $0.50 and $60 per million tokens of input, and a bit more for output tokens. The average English word is about 1.3 tokens — which means "you can do a significant amount of LLM work while spending less than most venture-funded startups spend on snacks."

**Will performance improvements slow?** There's significant debate on whether LLMs have reached a point where their performance improvements will slow. Much like the ongoing debate around whether Moore's law has died, it's unclear how much LLM performance will improve going forward. From a cost-to-train perspective, it's unlikely that companies can continue to improve foundational models merely by spending more money on compute: few companies can tolerate a $1B training cost, fewer will tolerate a $10B training cost, and it's hard to imagine a world where any companies are building $100B models. However, algorithmic improvements and investment in datasets may well drive improvements without driving up compute costs. The only high-confidence prediction available: model improvement will likely double one or two more times over the next three years, after which it might continue doubling at that rate or it might plateau at that level of performance — **either outcome is plausible**.

**Reversibility of the provider decision.** For some decisions, there's a strategic imperative to get it right from the beginning. For example, migrating from AWS to Azure is very expensive due to the degree of customization and lock-in. LLMs don't appear to be in this category. Talking with industry peers, the majority of companies are experimenting with a variety of models from Anthropic, OpenAI, and elsewhere (e.g., Mistral). Behaviors do vary across models, but the behavior of existing models also varies over time (e.g., GPT-3.5 allegedly got "lazier" over time) — which means the overhead of dealing with model differences is unavoidable even if you adopt only one model. Vendor lock-in for models is low from a technical perspective. However, regulatory requirements — like updating data processing agreements — introduce some friction when switching providers.

**Industry adoption state.** Although there's an ongoing investment boom in AI, most scaled technology companies are still looking for ways to leverage these capabilities beyond the obvious, widespread practices like adopting GitHub Copilot. For example, Stripe is investing heavily in LLMs for internal productivity, presumably including relying on them to perform some internal tasks that would previously have been performed by an employee — such as verifying a company's website matches details the company supplied in its onboarding application — but it's less clear that Stripe has yet found an approach to meaningfully shift its product, or its product's user experience, using LLMs.

Looking at ride-sharing companies specifically, there don't appear to be any breakout industry-specific approaches either. Uber is similarly adopting LLMs for internal productivity and some operational efficiency improvements, as documented in its August 2023 post describing internal developer and operations productivity investments using LLMs, and its May 2024 post describing those efforts in more detail.

## Document 17-2: Modeling LLMs' Impact on the Developer Experience

### Learnings

This model's insights can be summarized in three charts:

1. **Baseline chart (Figure 17-1):** shows an eventual equilibrium between errors discovered in production and tickets closed by shipping to production. The equilibrium is visible because tickets continue to get opened, but the total number of closed tickets stops increasing.
2. **Reduced error rate chart (Figure 17-2):** the equilibrium can be shifted by reducing the error rate in production. The first chart models 25% of closed tickets in production experiencing an error; the second models only a 10% error rate. The equilibrium returns, but at a higher value of shipped tickets. (Caption: "Reduced error rates delay, but don't prevent, reaching equilibrium of closed tickets.")
3. **Tripled start/test rate chart (Figure 17-3):** even tripling the rate of starting and testing tickets doesn't meaningfully change the total number of completed tickets. (Caption: "Starting or testing tickets faster creates noise but not progress.")

**The constraint on this system is errors discovered in production**, and any technique that changes something else doesn't make much of an impact. This is just a model, not reality — there are many nuances that models miss — but it helps focus on what probably matters most, and in particular highlights that **any approach that increases development velocity while also increasing production error rate is likely net-negative**.

### Sketch

Modeling in a spreadsheet is labor intensive, so iterate as much as possible in the sketching phase before moving to the spreadsheet. Here the sketch is done in Excalidraw.

Five stocks represent a developer's workflow (Figure 17-4):

1. **Open Tickets** — tickets opened for an engineer to work on.
2. **Started Coding** — tickets an engineer is working on.
3. **Tested Code** — tickets that have been tested.
4. **Deployed Code** — tickets that have been deployed.
5. **Closed Tickets** — tickets closed after reaching production.

There are four flows representing tickets progressing left to right through this development process. Additionally, three exception flows move right to left:

1. **Testing found error** — testing finds an error in a ticket, moving it backward to Started Coding.
2. **Deployment exposed error** — a ticket encounters an error during deployment and is moved backward to Started Coding.
3. **Error found in production** — a ticket encounters a production error, causing it to move all the way back to the beginning as a new ticket.

One of your first reactions to this model might be that it's **embarrassingly simple** — the author admits that was his reaction too when he first looked at it. The instruction: recognize that feeling, then dig into whether it matters. The model is quite simple, but it reveals several counterintuitive insights that help avoid erroneously viewing the tooling as a failure if time spent testing increases. **The value of a model is in refining our thinking, and simple models are usually more effective at refining thinking across a group than complex models, simply because complex models are fairly difficult to align a group around.**

### Reason

The first question to ask of the sketch: how might LLM-based tooling show an improvement? The most obvious options:

1. **Increasing the rate at which tasks flow from Started Coding to Tested Code.** Presumably these tools might reduce the amount of time spent on implementation.
2. **Increasing the rate that Tested Code follows the Testing found error flow back to Started Coding**, because more comprehensive tests are more likely to detect errors. This is probably the first interesting learning from this model: if the adopted tool works well, it's likely that **more time will be spent in the testing loop**, with a long-term payoff of spending less time solving problems in production where it's more expensive. This means that **slower testing might be a successful outcome rather than a failure**, contrary to how it might first appear.
   - A skeptic of these tools might argue the opposite: that LLM-based tooling will cause more issues to be identified "late," after deployment, rather than early in the testing phase. In either case, there is now a clear goal to measure to evaluate the tool's effectiveness: **reducing the Error found in production flow**. We also know **not to focus on the Testing found error flow, which should probably increase**.
3. **Zoom out and measure the overall time from Started Coding to Closed Tickets** — for tasks that don't experience the Error found in production flow for at least the first 90 days after being completed.

These observations capture what the author finds remarkable about systems modeling: even a very simple model can expose counterintuitive insights — in particular, the sort of insights that build conviction to push back on places where intuition might lead you astray.

### Model

The model is built directly in a spreadsheet, specifically Google Sheets (the completed spreadsheet model is available online). As discussed in Chapter 14, spreadsheet modeling is brittle, slow, and hard to iterate on. The author's general recommendation: attempt to model something in a spreadsheet once or twice to get an intuitive sense of the math happening in models, but almost always choose any tool other than a spreadsheet for a complex model.

(The chapter notes the spreadsheet walkthrough is fairly tedious; readers are "entirely excused" to open the sheet, look around, and skip the section.)

The spreadsheet has three important worksheets:

- **Model** — the model itself
- **Charts** — charts of the model
- **Config** — configuration values held separately from the model to ease exercising the model after it's built

On the Model worksheet, start by initializing each column to its starting value (Figure 17-5). While subsequent rows use formulae, **the first row should contain literal values**. The author often starts with a positive value in the first column and zeros in the others, but that isn't required — start with whatever values are most useful for studying the model you're building.

The model is implemented in two passes: first the left-to-right flows (the standard development process), then the right-to-left flows (exceptions in the process).

#### Modeling left-to-right

**Open Tickets → Started Coding.** Open tickets increase over time at a fixed rate: add a Config value `TicketOpenRate`, starting with 1. Work starts on open tickets as long as there are at most `MaxConcurrentCodingNum` tickets in progress; if more than `MaxConcurrentCodingNum` tickets are being worked on, no new tickets are started. This requires an intermediate calculation column (represented with an italicized column name) that determines how many tickets to start by checking whether the current number of started tickets is at the configured maximum, or whether to increment by one:

```
// Config!$B$3 is max started tickets
// Config!$B$2 is rate to increment started tickets
// $ before a row or column, e.g., $B$3 means that the row or column
//   always stays the same -- not incrementing -- even when filled
//   to other cells
= IF(C2 >= Config!$B$3, 0, Config!$B$2)
```

The first column, Open Tickets, is then decremented by the number of tickets started:

```
// This is the definition of `Open Tickets`
=A2 + Config!$B$1 - B2
```

This yields the Open Tickets, StartCodingMore?, and Started Coding columns (Figure 17-6).

**Started Coding → Tested Code.** Create a calculation column `NumToTest?`:

```
// Config$B$4 is the rate we can start testing tickets
// Note that we can only start testing tickets if there are tickets
// in `Started Coding` that we're able to start testing
=MIN(Config!$B$4, C3)
```

Add that value to the previous number of tickets being tested:

```
// E2 is prior size of the Tested Code stock
// D3 is the value of `NumToTest?`
// F2 is the number of tested tickets to deploy
=E2 + D3 - F2
```

(Result shown in Figure 17-7: Started Coding, NumToTest?, and Tested Code columns.)

**Tested Code → Deployed Code.** Keep things simple: assume every tested change gets deployed, so `NumToDeploy?` is simply:

```
// E3 is the number of tested changes
=E3
```

The Deployed Code stock:

```
// G2 is the prior size of Deployed Code
// F3 is NumToDeploy?
// H2 is the number of deployed changes in prior round
=G2+F3-H2
```

(Result shown in Figure 17-8.)

**Deployed Code → Closed Tickets.** Add the `NumToClose?` calculation, assuming all deployed changes are now closed:

```
// G3 is the number of deployed changes
=G3
```

The Closed Tickets stock:

```
// I2 is the prior value of Closed Tickets
// H3 is the NumToClose?
=I2 + H3
```

That completes the left-to-right flow (Figure 17-9). The left-to-right flows are simple — a few constrained flows and a few very scalable flows — with things progressing evenly through the pipeline. "All that is about to change."

#### Modeling right-to-left

After the happy path, model all the exception paths flowing right to left — for example, an issue found in production causes a flow from Closed Tickets back to Open Tickets. **This tends to be where models get interesting.**

The three right-to-left flows:

1. **Closed Tickets → Open Tickets** — a bug discovered in production.
2. **Deployed Code → Started Coding** — a bug discovered during deployment.
3. **Tested Code → Started Coding** — a bug discovered in testing.

Add configuration values defining the rates of those flows (Figure 17-10). These are **percentage flows**: a certain percentage of the target stock triggers the error condition rather than proceeding — for example, perhaps 25% of Closed Tickets are discovered to have a bug each round. These are starter values; the Exercise section experiments with adjusting them.

**Errors found in production (Closed Tickets → Open Tickets).** Add an `ErrorsFoundInProd?` column:

```
// I3 is the number of Closed Tickets
// Config!$B$5 is the rate of errors
=FLOOR(I3 * Config!$B$5)
```

The use of `FLOOR` avoids moving partial tickets. You can skip it if you're comfortable with the concept of fractional tickets, fractional deploys, and so on — it's an aesthetic consideration, and generally only impacts the model if you choose overly small starting values.

Closed Tickets must be updated to reduce by the prior row's `ErrorsFoundInProd?`:

```
// I2 is the prior value of ClosedTickets
// H3 is the current value of NumToClose?
// J2 is the prior value of ErrorsFoundInProd?
=I2 + H3 - J2
```

And the prior row's `ErrorsFoundInProd?` must be added into Open Tickets, representing the errors' flow from closed back to open tickets:

```
// A2 is the prior value of Open Tickets
// Config!$B$1 is the base rate of ticket opening
// B2 is prior row's StartCodingMore?
// J2 is prior row's ErrorsFoundInProd?
=A2 + Config!$B$1 - B2 + J2
```

The full errors-in-production flow is now represented (Figure 17-11).

**Errors found in deployment (Deployed Code → Started Coding).** Add the errors-in-deploy calculation:

```
// G3 is deployed code
// Config!$B$6 is deployed error rate
=FLOOR(G3 * Config!$B$6)
```

Update Deployed Code to decrease by that value:

```
// G2 is the prior value of Deployed Code
// F3 is NumToDeploy?
// H2 is prior row's NumToClose?
// I2 is ErrorsFoundInDeploy?
=G2 + F3 - H2 - I2
```

Increase Started Coding by the same value, representing the flow of errors discovered in deployment:

```
// C2 is the prior value of Started Coding
// B3 is StartCodingMore?
// D2 is prior value of NumToTest?
// I2 is prior value of ErrorsFoundInDeploy?
=C2 + B3 - D2 + I2
```

(Figure 17-12 shows the DeployedCode, NumToClose?, and ErrorsFoundInDeploy? columns.)

**Errors found in testing (Tested Code → Started Coding).** This is much the same as the prior flow. Add an `ErrorsFoundInTest?` calculation:

```
// E3 is tested code
// Config!$B$7 is the testing error rate
=FLOOR(E3 * Config!$B$7)
```

Update Tested Code to reduce by this value:

```
// E2 is prior value of Tested Code
// D3 is NumToTest?
// G2 is prior value of NumToDeploy?
// F2 is prior value of ErrorsFoundInTest?
=E2 + D3 - G2 - F2
```

Update Started Coding to increase by this value:

```
// C2 is prior value of Started Coding
// B3 is StartCodingMore?
// D2 is prior value of NumToTest?
// J2 is prior value of ErrorsFoundInDeploy?
// F2 is prior value of ErrorsFoundInTest?
= C2 + B3 - D2 + J2 + F2
```

(Figure 17-13 shows ErrorsFoundInTest? instrumented.)

With that, the model is complete and ready to exercise. The exercise demonstrated that it's quite possible to represent a meaningful model in a spreadsheet — and also the challenges of doing so. **While developing this model, a number of errors became evident.** Some were fixed relatively easily; even more were left unfixed because fixing them would make the model harder to reason about. This is a good example of why the author encourages developing one or two models in a spreadsheet but ultimately doesn't believe it's the right mechanism for most people: **even very smart people make errors in their spreadsheets, and catching those errors is exceptionally challenging**.

### Exercise

Exercising the model is "the fun part." Start by creating a simple bar chart showing the size of each stock at each step. Expressly do **not** show the intermediate calculation columns such as `NumToTest?` — those are implementation details rather than being particularly interesting.

**Baseline (Figure 17-14).** The most interesting observation: the current model doesn't actually increase the number of closed tickets over time. The system just gets further and further behind, which isn't too exciting.

**Experiment 1 — reduce production error rate.** Model the first way LLMs might help: shift `ErrorsInProd` from 0.25 down to 0.1 (Figure 17-15). This allows more progress on closing tickets, although at some point equilibrium is established between closed tickets and the production error rate, preventing further progress. This validates that **reducing error rate in production matters**. It also suggests that **as long as error rate is a function of everything previously shipped, "we are eventually in trouble."**

**Experiment 2 — triple the testing rate.** Test the idea that LLMs allow faster testing by tripling `TicketTestRate` from 1 to 3. **Increasing the testing rate doesn't change anything at all**, because the current constraint is in starting tickets (Figure 17-16).

**Experiment 3 — also triple the start-coding rate.** Maybe LLMs make starting tickets faster because overall speed of development goes down: increase `StartCodingRate` from 1 to 3 as well (Figure 17-17). This is a fascinating result: tripling development and testing velocity has changed **how much work is started**, but ultimately **the real constraint in the system is the error discovery rate in production**.

**Conclusion from exercising the model.** To the extent that error rate is a function of the volume of things shipped to production, shipping faster doesn't increase velocity at all. **The only meaningful way to increase productivity in this model is to reduce the error rate in production.**

Models are imperfect representations of reality, but this one gives a clear sense of what matters most: to increase velocity, the rate of discovering errors in production must be reduced. That might mean reducing the error rate as implied in the model, or it might mean ideas that exist outside the model. For example — the model doesn't represent this well — perhaps it would be better to **iterate more on fewer things**: if you make multiple changes to one area, it still represents just one implemented feature, not many implemented features, and the overall error rate wouldn't increase.

## Document 17-3: Wardley Mapping the LLM Ecosystem

### How Things Work Today

If retrieval-augmented generation (RAG) was the trending LLM pattern of 2023, and you could reasonably argue that agents — or agentic workflows — are the pattern of 2024, then it's hard to guess what tomorrow's patterns will be, but it's likely that more, new patterns are coming. **LLMs are a proven platform today, and are now being applied widely to discover new patterns** (Figure 17-18, the current-state map). It's a safe bet that validating these patterns will continue to drive product companies to support additional infrastructure components (e.g., search indexes to support RAG).

This proliferation of patterns has created a significant cost for product companies — a problem that market forces are likely to address as offerings evolve.

### Transition to Future State

Two questions will define the evolution of the space:

1. **Will LLM framework platforms for agents, RAG, and so on remain bundled with model providers such as OpenAI and Anthropic?** Or will they instead split, with models and platforms offered separately?
2. **Which elements of LLM frameworks will be productizable in the short term?** For example, running evals seems like a straightforward opportunity for bundling, as would providing some degree of agent support. Conversely, bundling RAG might seem straightforward, but most production use cases would require real-time updates, incurring the full complexity of operating scaled search clusters.

Depending on the answers, you might draw a very different map. The map drawn (Figure 17-19, "Pipeline of LLM platform bundling") answers the first question by imagining that **LLM platforms will decouple from model providers**, while also allowing you to license with the platform for model access rather than needing to individually negotiate with each model provider. It answers the second question by imagining that **most non-RAG functionality will move into a bundled platform provider**. Given the richness of investment in the current space, it seems safe to believe that **every plausible combination will exist to some degree until the ecosystem eventually stabilizes in one dominant configuration**.

The key drivers of this configuration: the LLM ecosystem is investing in new patterns every year, and companies are spinning up haphazard internal solutions to validate those patterns, but ultimately **few product companies are able to effectively fund these sorts of internal solutions in the long run**.

If this map is correct, it means eventual headwinds for both:

- **Model providers**, who are inherently limited to providing their own subset of models, and
- **Narrow LLM platform providers**, who can only service a subset of LLM patterns.

**The likely best bet for a product company in this future: adopt the broadest LLM pattern platforms today, and explicitly decouple pattern platform from model provider.**

### User and Value Chains

The LLM landscape is evolving rapidly, with some techniques getting introduced and reaching widespread adoption within a single calendar year. Sometimes those widely adopted techniques are actually being adopted; other times it's closer to **"conference-talk-driven development,"** where folks with broad platforms inflate the maturity of industry adoption.

The three primary users attempting to navigate that dynamism:

1. **Product Engineers** — looking for faster, easier solutions to deploying LLMs across the many evolving parameters: new models, support for agents, solutions to offload the search dimensions of RAG, and so on.
2. **The Machine Learning Infrastructure team** — responsible for the effective usage of the mechanisms and for steering product developers toward effective adoption of these tools. Also responsible, in tandem with other infrastructure engineering teams, for supporting common elements for LLM solutions, such as search indexes to power RAG implementations.
3. **Security and Compliance** — how to ensure models are hosted safely and securely, and that only approved information is being sent? How to stay in alignment with rapidly evolving AI risks and requirements?

To keep the map focused on evolution rather than organizational dynamics, the author consolidated a number of teams in slightly artificial ways and omitted teams certainly worth considering:

- **Finance** needs to understand the cost and volume of LLM usage.
- **Security and Compliance** are really different teams, with both overlapping and distinct requirements.
- **Machine Learning Infrastructure** could be split into two distinct teams with somewhat conflicting perspectives on who should own things like search infrastructure.

Depending on what you want to learn from the map, you might prefer to combine, split, and introduce a different set of combinations than the ones selected here.

## Document 17-4: Modeling Driver Onboarding

### Learnings

An obvious assumption: making driver onboarding faster would increase the long-term number of drivers in a market. However, the model shows that **even doubling the rate at which applicant drivers are qualified as eligible has little impact on active drivers over time** (Figure 17-20: "Speeding up onboarding doesn't impact active drivers in the long term").

Conversely, **efforts to reengage departed drivers have a significant impact on active drivers**. There are potential LLM applications that could encourage departed drivers to return to active driving — for example, mapping their rationale for departing against recent product changes and driver retention promotions could generate high-quality, personalized emails (Figure 17-21: "Improving driver reengagement does increase active drivers").

Finally, the model shows that **increasing reactivation of either departed or suspended drivers is significantly less impactful than increasing both**. If either rate is low, an increasingly large number of drivers is lost over time (Figure 17-22: "Increasing the reactivation rate of suspended drivers has the highest impact").

**The only meaningful opportunities to increase active drivers with LLMs are improving those two reactivation rates.**

### Sketch

The first step in modeling a system is sketching it (using Excalidraw). The model is of onboarding and retaining drivers for a ride-sharing application **in one city** (Figure 17-23).

The seven stocks:

1. **City Population** — the total population of a city.
2. **Applied Drivers** — the number of people who've applied to be drivers.
3. **Eligible Drivers** — applied drivers who meet eligibility criteria (e.g., provided a current driver's license, etc.).
4. **Onboarded Drivers** — eligible drivers who have successfully gone through an onboarding program.
5. **Active Drivers** — onboarded drivers who are actually performing trips on a weekly basis.
6. **Departed Drivers** — were active drivers, but voluntarily stopped performing trips (e.g., took a different job).
7. **Suspended Drivers** — were active drivers, but involuntarily stopped performing trips (i.e., are no longer allowed to drive on the platform).

Left-to-right flows: there is a flow from each stock to the following stock in the pipeline. These are all simple one-to-one flows, with the exception of those coming from Active Drivers, which leads to **two** distinct stocks: Departed Drivers and Suspended Drivers, representing voluntary and involuntary departures.

Right-to-left (exception path) flows:

1. **Request missing information** — a driver who can't be moved from Applied Drivers to Eligible Drivers because their provided information proved insufficient in a review process.
2. **Re-engage** — Departed Drivers who have decided to start driving again, perhaps because of a bonus program for drivers who start driving again.
3. **Remove suspension** — drivers who were involuntarily removed but are now allowed to return to driving.

A fairly basic model — but worth seeing what can be learned from it.

### Reason

With the system sketched, the next step is thinking about which flows will have the largest impact, and where an LLM might increase those flows. Observations from reasoning about it:

- **If a city's population is infinite**, what really matters in this model is how many new drivers can be encouraged to join the system. **If a city's population is finite**, onboarding new drivers will be essential in the early stages of coming online in any particular city, but long term, **reengaging departed drivers is probably at least as important**.
- **LLM tooling could speed up validating eligible drivers.** If sped up enough, the rate of the Request missing information flow could be greatly reduced by identifying missing information in real time, rather than requiring a human to review the information later.
- **LLM tooling could craft personalized messaging to departed drivers** explaining which company changes since their departure might be most relevant to their reasons for stopping. This could increase the rate of the Re-engage flow.
- **An LLM likely shouldn't approve the removal of suspensions**, but it could look at requests to be revalidated and identify promising requests, focusing human attention on those with the highest potential for approval.
- **LLM-powered tooling could help a city resident decide whether they should apply to become a driver** by answering questions they might have.

As the model is exercised later, the assumptions about whether the city has already exhausted potential drivers will quickly steer toward a specific subset of these options: **if all potential drivers are already tapped, only work to reactivate prior drivers will matter; if there are more potential drivers, then activating them will likely be a better focus**.

### Model

This model uses the **`lethain/systems`** library, written by the author. For a more detailed introduction, the recommendation is to work through the tutorial in the repository; the basics are introduced here. While `systems` is far from a perfect tool, compared with other modeling techniques like spreadsheet-based modeling and **SageModeler**, its emphasis on **rapid development and reproducible, sharable models** is somewhat unique.

The finished model and visualizations are in the JupyterHub notebook in **`lethain/eng-strategy-models`**.

Implementation steps:

Create a stock for the city's population, with an initial size of 10,000:

```
# City population is 10,000
CityPop(10000)
```

Initialize the Applied Drivers stock with a constant rate of 100 people in the city applying to become drivers each round. This only happens until the 10,000 potential drivers are exhausted, at which point no one is left to apply:

```
# 100 folks apply to become drivers per round
# the @ 100 format is called a "rate" flow
CityPop > AppliedDrivers @ 100
```

Initialize Eligible Drivers: 25% of the people in Applied Drivers advance to become eligible each round. Where `@ 100` specified a fixed rate, `@ Leak(0.25)` specifies that 25% of the stock advances:

```
# 25% of applied drivers become eligible each round
AppliedDrivers > EligibleDrivers @ Leak(0.25)
```

**Leak versus Conversion.** You could write this as `@ 0.25`, but you'd get different behavior: `@ 0.25` is actually shorthand for `@ Conversion(0.25)`, which is similar to a leak but **destroys the unconverted portion**. Illustrating the difference with 100 applied drivers and 100 eligible drivers:

- `Leak(0.25)` would end with 75 applied drivers and 125 eligible drivers.
- `Conversion(0.25)` would end with 0 applied drivers and 125 eligible drivers.

Depending on what you're modeling, you might need leaks, conversions, or both.

The first right-to-left flow — Request missing information, with 10% of eligible drivers moving backward each round:

```
# This is "Request missing information", with 10%
# of folks moving backward each round
EligibleDrivers > AppliedDrivers @ Leak(0.1)
```

Note that **the syntax for left-to-right and right-to-left flows is identical** — no distinction is made.

25% of Eligible Drivers become Onboarded Drivers each round:

```
# 25% of eligible drivers onboard each round
EligibleDrivers > OnboardedDrivers @ Leak(0.25)
```

50% of Onboarded Drivers become Active Drivers, actually providing rides:

```
# 50% of onboarded drivers become active
OnboardedDrivers > ActiveDrivers @ Leak(0.50)
```

The Active Drivers stock is drained by two flows — voluntary departures to Departed Drivers, and suspensions to Suspended Drivers — each taking 10% of active drivers per round:

```
# 10% of active drivers depart voluntarily and involuntarily
ActiveDrivers > DepartedDrivers @ Leak(0.10)
ActiveDrivers > SuspendedDrivers @ Leak(0.10)
```

Finally, 5% of Departed Drivers return to driving each round, and 1% of Suspended Drivers are unsuspended:

```
# 5% of DepartedDrivers become active
DepartedDrivers > ActiveDrivers @ Leak(0.05)
# 1% of SuspendedDrivers are reactivated
SuspendedDrivers > ActiveDrivers @ Leak(0.01)
```

Although the model was already sketched earlier, `systems` can export models via **Graphviz** (Figure 17-24). These generated diagrams are generally harder to read than a custom-drawn one, but it's certainly possible to use this toolchain to combine sketching and modeling into a single step.

### Exercise

**Baseline (Figure 17-25).** The base model acquires initial drivers quickly, then slows as the city population is exhausted, **stabilizing around 800 active drivers**.

**Experiment 1 — double eligibility speed.** Imagine an LLM-powered tool speeds up qualifying eligible drivers, doubling the rate of moving applied drivers to eligible: 50% per round instead of 25%.

```
# old
AppliedDrivers > EligibleDrivers @ Leak(0.25)
# new
AppliedDrivers > EligibleDrivers @ Leak(0.50)
```

Even doubling the speed of onboarding drivers to eligibility has **minimal impact** (Figure 17-26).

**Experiment 2 — eliminate the missing-information flow.** To finish testing this hypothesis, eliminate the Request missing information flow entirely (commenting out that line). Even eliminating the missing-information error rate has **little impact** on the number of active drivers (Figure 17-27). So the opportunity for LLM solutions to increase active drivers will need to focus on **reactivating existing drivers**.

**Experiment 3 — quadruple departed-driver reactivation.** Go from 5% of departed drivers reactivating to 20%:

```
# 20% of DepartedDrivers become active
# DepartedDrivers > ActiveDrivers @ Leak(0.05)
# DepartedDrivers > ActiveDrivers @ Leak(0.2)
```

For the first time, there is a **significant shift in impact**: a much higher percentage of drivers at peak, and even after all drivers in the city are exhausted, the total number of active drivers reaches a **higher equilibrium** (Figure 17-28).

**Experiment 4 — raise suspended-driver reactivation.** Presumably, increasing the rate of reactivating suspended drivers from 1% to 2.5% would have a similar, meaningful but smaller impact on active drivers over time. Modeling that change:

```
# 2.5% of SuspendedDrivers are reactivated
#SuspendedDrivers > ActiveDrivers @ Leak(0.01)
SuspendedDrivers > ActiveDrivers @ Leak(0.025)
```

**Surprisingly, the impact of increasing the reactivation rate of suspended drivers is actually much higher than reengaging departed drivers** (Figure 17-29). This is an interesting and somewhat counterintuitive result. Increasing the rate for **both** suspended and departed drivers is more impactful than increasing either alone, because ultimately **there's a growing population of drivers in the slower-deflating stock**. This means, surprisingly, that a tool that helps quickly determine which drivers could be unsuspended might matter more than the small size of the flow indicates.

At this point, the model's primary story has been found: **focus efforts on reactivating departed and suspended drivers**. Changes elsewhere might reduce the business's operational costs, but they won't solve the problem of increasing active drivers.

## Summary

When these strategies were written in 2024, dreams of LLM adoption were everywhere, but there was no certainty about how LLMs would actually evolve over time. Similarly, there were extremely few teams or leaders with meaningful experience adopting these technologies, but a great deal of pressure from the industry to incorporate them as quickly and broadly as possible.

These documents show how strategy — particularly the refinement techniques — can support leaders in finding a reasonable path forward despite **the impossible combination of urgency and uncertainty**.
