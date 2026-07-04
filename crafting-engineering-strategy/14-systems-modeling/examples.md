# Chapter 14: Systems Modeling — Examples

## The load balancer and load-sensitive server

The chapter's primer model: requests flow from a user through a load balancer to a server, with flows for successful ("OK") and failed ("Error in server") requests. The model compares two scenarios: a load balancer that caps throughput to the load-sensitive server behind it versus one that passes everything through. Without the model, the discussion would devolve into a philosophical debate about how ridiculous it is that the downstream server is load-sensitive at all. With the model, it is immediately obvious that protecting the server with a throughput cap is worthwhile, even though its sensitivity is concerning.
Illustrates: models create a cheap way to understand reality and replace philosophical debate with visible system dynamics.

## Uber driver onboarding versus reengagement

Modeling Uber's strategy for onboarding new drivers (Document 17-4 in the book) revealed that improving the onboarding funnel mattered less than reengaging drivers who had already departed. Modeling made it cheap to test which levers might be meaningful.
Illustrates: using a model to find the true leverage point in a complex system when you are unsure where it is.

## Modeling hiring's impact on Uber engineering productivity

Larson modeled how hiring affected Uber's engineering productivity, then compared the model's output against internal data. The value came from focusing on the places where the real data and the model were in tension.
Illustrates: the second scenario where modeling shines — when you have significant data, model-versus-data tension is where learning happens.

## The counterintuitive LLM developer-experience model

A model of how LLMs affect developer experience (Document 17-2) suggested that effective LLMs might increase time spent writing and testing code while decreasing time spent fixing issues found in production. The naive expectation is that LLMs reduce testing time, but the model showed reducing testing time only adds productivity if production-discovered issues stay at worst constant; if production issues rise, cutting testing time gains nothing.
Illustrates: models expose counterintuitive coupling between flows that intuition misses.

## Building the LLM model in a spreadsheet (deliberately bad tooling)

Every model for the book took under an hour except the LLM impact model, which Larson deliberately built in an increasingly messy spreadsheet to show the cost of poor tooling. It was slow, challenging, and extremely brittle; after finishing, he could not extend it effectively to test new ideas and had inadvertently introduced several bugs.
Illustrates: tooling quality, at least as much as practice, shapes whether modeling feels fast or laborious; spreadsheets are a poor fit for nontrivial models.

## The lethain/systems toolchain

After trying introductory tools like SageModeler and Insight Maker (which he generally found either limited, steep to learn, or hard to share), Larson returned to his own open source toolchain, lethain/systems. Its virtues: fast model creation and iteration, easy sharing, relatively little surface area for bugs, free and self-hosted, and good Jupyter integration. His conclusion is still that almost any tool works with deliberate practice — pick one and stop thinking about tooling.
Illustrates: the tool matters less than fluency; optimize for iterating and sharing quickly.

## Stripe's reliability model that fought reality

At Stripe, the team built a model to guide reliability strategy. It was intuitively good, but real-world results were mixed. Attachment to the early model distracted the team: they spent too much time collecting and classifying data, and were slow to engage with the actual key problems — maximizing the impact of scarce mitigation bandwidth and growing that bandwidth. They would have had more impact by engaging directly with what reality was teaching them instead of looking for reasons to disregard it.
Illustrates: when your model and reality conflict, reality is always right.

## The hiring organization optimizing the wrong funnel

Larson joined an organization pouring energy into hiring while struggling to hire. Their intuitive model pushed them to spend years optimizing the top of the funnel, then the closing process. They were not able to detect that the largest hurdle was actually misalignment among their own interviewers' expectations — a factor outside the model entirely.
Illustrates: models are immutable but reality isn't; a stale model steers effort toward levers that no longer (or never did) matter.

## Uber's service migration model and its blind spot

Modeling the service migration at Uber (Document 16-1) clarified that the team had to adopt a more aggressive approach to succeed, and they did succeed. But the model never studied the consequences of *completing* the migration, which included a very challenging development environment. The model captured everything the migration team cared about while doing nothing to evaluate whether the migration was a good idea overall.
Illustrates: every model omits information, and some omit critical information — especially second-order consequences of success and concerns outside the modeling team's scope.

## The book's worked-model breadcrumbs

The chapter points to four models elsewhere in the book as deeper exploration: Document 17-4 (improving the driver lifecycle at "Theoretical Ride Sharing" with LLMs; introduces lethain/systems), Document 17-2 (LLM impact on developer experience; demonstrates the downsides of spreadsheet modeling), Document 18-1 (financial consequences of policies for backfilling departed engineers; further lethain/systems features), and Document 16-2 (whether to optimize an existing service provisioning workflow or replace it with self-service). Beyond these, Larson publishes more systems models in his blog's systems-thinking category.
Illustrates: the chapter's techniques applied to concrete engineering strategies in Part IV of the book.
