# Chapter 9: Setting Policy — Examples

## Private equity ownership: policy that acknowledges uncertainty (Document 18-1)

A company under new private-equity ownership diagnosed that the owners would likely demand R&D headcount cost reductions, but no concrete targets existed yet. Rather than guessing, the policy stated the belief that explicit operating-expense targets would arrive during financial-year planning, committed to revising the policies once targets were known, and deliberately delayed reduction planning to avoid running two overlapping processes.
Illustrates: a valid policy can explicitly acknowledge ambiguity in the diagnosis and commit to revisiting when specific information arrives.

## The N-1 backfill policy: context makes the policy (Document 18-1)

The same private-equity strategy adopted an "N-1" backfill policy — departures are backfilled at one level less senior — plus a strict maximum of one Principal Engineer per business unit. This policy makes sense under new private-equity ownership but wouldn't work well in a rapidly expanding organization. Larson also notes it's likely hiring managers would simply ignore the backfill rule if it were stated more softly — though sometimes less forceful policies are useful.
Illustrates: policy is only meaningful in the context of its diagnosis, and misaligned incentives sometimes require unambiguous direction rather than soft guidance.

## Private equity: the policy leadership would have overridden (Document 18-1)

The same strategy could have argued that the new owners should not hold engineering accountable to a new standard on spending. But the owners would simply have invalidated that strategy in the next financial planning period — your leadership is never bound to honor a policy you write that they disagree with.
Illustrates: a third example of an impractical policy — one that contradicts what leadership wants is erased at the next planning cycle, however well-argued.

## Monolith decomposition: four policies, not one (Document 20-1)

A strategy for (not) decomposing a monolithic application needed four policies to cover its diagnosis: (1) business units always operate in their own code repository and monolith; (2) new integrations across business-unit monoliths use gRPC; (3) no new services are allowed except new business-unit monoliths; (4) merge existing services into business-unit monoliths where you can. Four wasn't a magic number — it was simply what the diagnosis required.
Illustrates: most strategies need a set of policies sized to the diagnosis, and effective policies can feel inevitable rather than novel.

## "Merge services where you can": guidance in action (Document 20-1)

The fourth decomposition policy deliberately deferred to teams: each choice to fold a service back into the monolith should be made "in the details," not top-down, so teams are encouraged to wind down outside services but decide based on local context. Ask five engineers whether a given service can merge back and you'll get five answers — and that's fine.
Illustrates: guidance enables incremental progress where concrete direction would cause confusion.

## Index acquisition: paired-lead escalations (Document 22-4)

After Stripe acquired Index, the integration strategy required all escalations to go jointly to Stripe's Head of Traffic Engineering and Index's Head of Engineering, because the teams had limited shared context. Consulting both sides before finalizing any decision let the acquired and acquiring organizations build mutual trust.
Illustrates: an approval policy, where the approval mechanism itself is designed to produce trust, not just decisions.

## Index acquisition: minimize tokenization-environment changes (Document 22-4)

The same strategy said the point-of-sale API must live inside the secured environment holding payment details, but any other functionality must stay out of that tokenization environment. It reads like direction, yet it cannot articulate which complexity is "necessary," so interpreting it requires significant judgment — making it guidance.
Illustrates: the dividing line between direction and guidance is whether the policy can be followed without judgment.

## User data access: CISO-approved exceptions (Document 19-1)

A strategy controlling access to customer data carved out an exception to the company's usual advisory architecture process (which followed the book *Facilitating Software Architecture*): exceptions to the data-access policy had to be explicitly approved in writing by the CISO, starting in a designated channel. Where the Index approval process aimed at trust, this one aimed at managing corporate risk — different goals, different tradeoffs among safety, productivity, and trust.
Illustrates: approval policies encode tradeoffs; the right mechanism depends on the goal.

## User data access: the rejected "manual approval of everything" policy (Document 19-1)

The same strategy could have required a second person to manually approve every single access to customer data. It would have gone nowhere: it would have harmed the customer experience by drastically slowing internal workflows.
Illustrates: a policy you cannot realistically operate is a bad policy, however safe it sounds.

## Uber service migration: explicit allocation policy (Document 16-1)

Uber's service-provisioning team fixed exactly one full-time engineer on manual provisioning tasks and moved everyone else to building self-service automation. Manual provisioning got worse in the short term, but the alternative was permanent degradation as newly hired product engineers flooded the team with service requests.
Illustrates: allocation policies are the most concrete statement of priority and accept explicit short-term pain for long-term capacity.

## Uber service migration: implicit higher-altitude allocation (Document 16-1)

The same strategy's diagnosis recorded an allocation set above it: the four-engineer provisioning team would receive none of the organization's headcount growth, and that wasn't expected to change. The team's strategy had to work within that inherited allocation.
Illustrates: allocation policies in higher-altitude strategies constrain lower-altitude strategies, often implicitly.

## Uber service migration: the unfundable staffing alternative (Document 16-1)

The strategy could have demanded more staffing for infrastructure engineering, but the authors knew that wasn't going to happen, so proposing it would have been meaningless.
Illustrates: policies that ignore known resource constraints sound good and accomplish nothing.

## Calm: "We write all code in the monolith" (Document 21-1)

At Calm, it was ambiguous whether new code belonged in the JavaScript monolith or in new services, and individuals kept making incompatible choices. The policy removed personal judgment entirely: all new code must be written in the monolith, with a defined exception process for rare functional requirements that make the monolith implausible. Larson also notes Calm's overall engineering strategy was particular in its details but industry-common in its approach.
Illustrates: direction works when consistency matters more than individual judgment — and truly novel policies are rare.

## Stripe Sorbet vs. Calm roadmaps: two altitudes (Documents 22-3 and 21-2)

Stripe's Sorbet (Ruby typing) strategy only worked because the organization enforced a single programming language across essentially all teams — an organization-altitude policy that removed team freedom but unlocked centralized investment. Calm's strategy for resourcing engineering-driven projects went the other way: only teams managed their roadmaps, because solving it at a higher level would just mean someone talking directly to the team to rewrite priorities anyway — executives were more senior, but in practice frequently overridden by other executives' out-of-band instructions. Both altitudes make sense; both have consequences.
Illustrates: choosing strategy altitude deliberately, trading flexibility against centralized leverage.

## Talent density: "world-class" vs. "strong yes" hiring policies

Compare "We only hire world-class engineers" with "We only hire engineers who get at least one 'strong yes' in scorecards." The first is not applicable — no mutually agreeable definition of "world-class" exists — so it can't be consistently enforced. The second has a clear definition and is enforceable, provided the organization will actually reject otherwise-good candidates lacking a strong yes.
Illustrates: the applicable-and-enforced test separating slogans from policies.

## Don't Repeat Yourself: shifting judgment to the author

"We follow a strict DRY policy" is broadly applicable, but since whether two pieces of code are truly duplicative is debatable, enforcing it is a very context-specific determination. "Code authors are responsible for determining if their contributions violate DRY, and rewriting them if they do" is more applicable (one person's judgment) and clearer to enforce (no ambiguity about who decides) — but now effectiveness depends on holding individuals accountable for the quality of their judgment.
Illustrates: rewriting a policy to assign judgment improves applicability but moves the enforcement burden onto accountability for judgment.

## Same policy, different outcomes: services at Uber vs. Calm and Carta

Larson believed adopting service-oriented architecture was absolutely the best available choice at Uber, yet he immediately paused service rollouts after joining Calm and later Carta. One policy, very different outcomes depending on circumstances. An organization unwilling to make that distinction — and to hold decision-makers accountable for reflecting it — gets no value from the policy.
Illustrates: policy effectiveness is contextual; enforcement means judging judgment, not just compliance.

## LLM driver reactivation: abstracting away the new technology (Document 17-1)

A strategy for adopting LLMs proposed an "LLM-backed process for reactivating departed and suspended drivers in mature markets," after lifecycle modeling showed improving onboarding time would have little impact on active-driver counts. Replace "LLM-backed" with "data-driven" and the policy is equally readable.
Illustrates: policy can sidestep uncertainty about new technology by staying one level of abstraction up.

## Sorbet vs. Golang/Java: competing proposals resolved by diagnosis (Document 22-3)

When Stripe developed Sorbet, two policies competed: build a Ruby-typing tool so a centralized team could gradually migrate the company, or migrate the codebase to an existing strongly typed language like Golang or Java. Initially both were equally valid. Only after clarifying the diagnosis around resourcing — they wanted to prioritize short-term product-engineering velocity, accepting a longer migration, by concentrating costs in a central team rather than spreading them across many — did the choice become clear.
Illustrates: competing policy bundles expose diagnosis gaps; sharpen the diagnosis until one option wins.

## The offsite: wishing for an executive strategy that doesn't exist

At a company offsite, leaders debated how to stop annual plans from derailing within a month. Someone observed it would all be easier if the executive team committed to a written strategy about which business units to prioritize. They were right — it would have been much easier. But the empowering move was to include that absence in the diagnosis and proceed, rather than waiting for a peer function's clarity that might never come.
Illustrates: treat missing upstream strategies as diagnosis inputs, not blockers; meaningful leadership means deciding without complete information.
