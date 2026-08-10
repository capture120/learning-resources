# Chapter 14: Doing the Right Thing — Learnings

## Central thesis

Every data system is built for a purpose, and engineers bear ethical responsibility for both its intended and unintended consequences. Many datasets are about people — their behavior, interests, and identity — and must be treated with humanity and respect. Ethics is not a compliance checklist; it is a participatory, iterative process of reflection, in dialog with the people affected, with accountability for the results.

## Foundational stance

- A technology is not good or bad in itself; what matters is how it is used and how it affects people (true of a search engine in the same way as a gun).
- Ethical concepts are not fixed or precisely defined the way technical concepts are; they require interpretation and may be subjective. That makes the reasoning hard, but it is too important to ignore.
- Guidelines exist (e.g., the ACM Code of Ethics and Professional Conduct) but are rarely discussed, applied, or enforced in practice — engineers and product managers sometimes take a cavalier attitude toward privacy and harm.
- It is not sufficient to focus exclusively on the technology and ignore its consequences. "If we don't consider the societal impact of our work, we're not doing our job."

## Predictive analytics

Predicting the weather or disease spread is one thing; predicting whether a convict will reoffend, a loan applicant will default, or an insurance customer will make expensive claims is another — these directly affect individual lives.

**The asymmetric-cost trap.** For an organization, the cost of a missed opportunity (rejecting a good applicant) is low; the cost of a bad loan or a bad hire is high. So organizations rationally say "no" when in doubt. But when algorithmic decision making is widespread, a person labeled risky (accurately or falsely) accumulates "no" decisions across jobs, air travel, insurance, housing, and financial services — an "algorithmic prison." Unlike criminal justice, which presumes innocence, automated systems can systematically exclude someone from society without proof of guilt and with little chance of appeal.

### Bias and discrimination

- Algorithmic decisions are not inherently better or worse than human ones. There is genuine hope that data-based decisions could be fairer than subjective human judgment, which is itself biased and can institutionalize discrimination.
- With predictive analytics we are not merely automating a human's decision by writing software rules for when to say yes or no; we leave the rules themselves to be inferred from data. If the input carries systematic bias, the system will most likely learn and **amplify** that bias. The learned patterns are opaque: a correlation may exist without anyone knowing why.
- The chapter's epigraph (Prabhu & Birhane): "Feeding AI systems on the world's beauty, ugliness, and cruelty, but expecting it to reflect only the beauty is a fantasy."
- Anti-discrimination law prohibits using protected traits (ethnicity, age, gender, sexuality, disability, beliefs), but **proxy features defeat this**: in segregated neighborhoods, postal code or IP address strongly predicts race. Excluding the protected attribute does not remove the bias.
- The belief that an algorithm can take biased data and produce fair output has been satirized as "machine learning is like money laundering for bias."
- Predictive analytics extrapolate from the past; if the past is discriminatory, they codify and amplify that discrimination. Making the future better than the past requires moral imagination, which only humans provide. Data and models should be tools, not masters.

### Responsibility and accountability

- If a human errs, they can be held accountable and the affected person can appeal. Who is accountable when an algorithm errs (a self-driving car crash, a credit algorithm that discriminates by race or religion)? Can you explain the decision to a judge under judicial review? People must not evade responsibility by blaming an algorithm.
- **Credit scores vs. ML scoring** — a key distinction worth remembering:
  - A traditional credit score answers "How did *you* behave in the past?" It is based on relevant facts about your own borrowing history, and errors can (in principle) be corrected.
  - Predictive analytics answer "Who is *similar to you*, and how did *people like you* behave?" This is stereotyping by construction (e.g., by where you live — a close proxy for race and class). People put in the wrong bucket have almost no recourse, especially when the decision rests on erroneous data, because the inputs are wide-ranging and opaque.
- **Statistical outputs are wrong in individual cases even when the distribution is correct.** An 80-year average life expectancy says almost nothing about when one particular person will die. Prediction systems are probabilistic; individual errors are inevitable. Blind belief in data supremacy is delusional and dangerous.
- Open problems the industry must solve: avoid reinforcing existing biases, make algorithms accountable and transparent, and fix them when they inevitably err.
- Dual-use risk: the same analytics that could target aid to those who need it most are used by predatory businesses to find vulnerable people and sell them high-cost loans or worthless degrees.

### Feedback loops

- Recommendation systems that predict what users want to see can create echo chambers where stereotypes, misinformation, and polarization breed — with documented impact on elections.
- **Self-reinforcing spirals**: employers using credit scores for hiring → a misfortune hurts your score → you can't find work → poverty worsens the score further. A downward spiral built on poisonous assumptions, camouflaged by mathematical rigor.
- **Emergent algorithmic collusion**: German gas stations adopting algorithmic pricing led to reduced competition and *higher* consumer prices, because the algorithms learned to collude — no one programmed that outcome.
- Mitigation: **systems thinking** — analyze the entire system including the humans interacting with it, not just the computerized parts. Ask: does the system reinforce and amplify existing differences (rich get richer, poor get poorer), or does it counteract injustice? Even with good intentions, expect unintended consequences.

## Privacy and tracking

Beyond automated decisions, data **collection itself** raises ethical problems. The key question: what is the relationship between the data collector and the person?

- When a system stores only data the user explicitly entered, because the user wants it stored and processed, the system serves the user; the user is the customer.
- When activity is tracked as a side effect, the service takes on interests of its own that may conflict with the user's.
- Some tracking genuinely benefits users: click-through data improves search ranking, purchase co-occurrence powers recommendations, A/B tests improve UIs.
- But under an advertising-funded business model, **advertisers are the actual customers** and users' interests come second. Tracking gets more detailed, analysis further-reaching, retention longer — building per-person marketing profiles. The accurate word for this relationship is *surveillance*.

### Surveillance

- Thought experiment: replace "data" with "surveillance" in your company's phrases ("surveillance-driven organization," "surveillance warehouse," "surveillance scientists") and see whether they still sound good.
- In the attempt to make software "eat the world," we have built **the greatest mass surveillance infrastructure ever seen** — the industry's own framing of ambition produced the outcome.
- Digitization made mass data collection cheap. Location, movements, relationships, communications, purchases, and health data are now collected near-unavoidably. A surveillance organization may know more about a person than the person knows about themselves (e.g., detecting illness or financial trouble first).
- Past totalitarian regimes could only dream of a microphone in every room and a tracking device in every pocket; we accepted this voluntarily because the benefits are great — the difference being that corporations collect the data to provide services, rather than governments seeking control.
- Not all data collection necessarily qualifies as surveillance, but examining it as surveillance clarifies your relationship with the collector. Why do people accept it? The "nothing to hide" rationale only works if you are aligned with existing power structures, not a marginalized minority, and need not fear persecution — not everyone is so fortunate. The "purpose seems benign" rationale (merely better recommendations, not coercion) erodes once the same data feeds predictive decisions.
- Surveillance feels benign ("just better recommendations") until it drives consequential decisions: driving-behavior data collected without consent affecting insurance premiums; health insurance conditioned on wearing a fitness tracker. Sensor data is more revealing than it appears — smartwatch motion sensors can reconstruct what you type, including passwords. Accuracy will only improve.

### Consent and freedom of choice

The "users consented" defense fails on several grounds:

1. **Necessity is questionable.** Tracking that improves search ranking serves users; tracking that builds advertising profiles serves users only in the sense that ads pay for the service.
2. **Consent is not informed.** Users don't know what data they provide, how it is retained, or how it is processed; privacy policies obscure more than they illuminate. Derived datasets that combine the whole user base with external sources are precisely what users cannot meaningfully understand. One user's data also reveals things about non-users who never agreed to anything.
3. **No reciprocity.** Data extraction is one-way; there is no negotiation over how much data for what service. The terms are set entirely by the service.
4. **Opting out is not a free choice.** When a service is "essential for basic social participation" (smartphones, social networks, search), opting out carries social and professional costs — especially with network effects. Services are deliberately engineered for engagement using gambling-style game mechanics. Only the privileged have the time, knowledge, and slack to decline; for everyone else, surveillance is inescapable.

**GDPR's consent standard** (worth knowing as the regulatory bar): consent must be "freely given, specific, informed, and unambiguous"; users must be able to refuse or withdraw "without detriment"; requests must use "clear and plain language"; silence, pre-ticked boxes, and inactivity do not constitute consent. Consent is the most common lawful basis for processing in internet services, but not the only one — others include legal compliance, protecting someone's life, and "legitimate interest" (e.g., fraud prevention, which fraudsters would never consent to).

### Privacy and use of data

- **Privacy is not secrecy.** "Privacy is dead" arguments misunderstand the word. Privacy is a *decision right*: the freedom to choose what to reveal to whom, what to make public, and what to keep secret, in each situation. Someone with a rare illness may gladly give medical data to researchers, yet withhold it from insurers and employers — the point is that *they* choose.
- Surveillance does not erase privacy rights so much as **transfer them from the individual to the data collector**. Companies acquiring data essentially say "trust us to do the right thing with your data" — the decision right itself changes hands. The company decides what is revealed to whom — to maximize profit, not per the person's preferences. Even users who can't be reidentified in an ad-targeting bucket (e.g., "people with illness X") have lost agency over disclosure of intimate information.
- Companies manage perceptions of creepiness rather than reducing actual intrusiveness. Expect any data to possibly be wrong, undesirable, or inappropriate, and build mechanisms for handling those failures; algorithms are oblivious to human needs unless explicitly programmed to respect them. Be humble: plan for these failings.
- Privacy settings controlling what *other users* see are only a start: the service itself retains unfettered internal access, usually with self-granted rights going far beyond what is visible to users.
- This large-scale transfer of privacy rights to corporations is historically unprecedented. Surveillance always existed, but it used to be expensive and manual, not scalable and automated. Trust relationships (doctor–patient, attorney–client) always existed, but were strictly governed by ethical, legal, and regulatory constraints; internet-scale data collection has no equivalent governance.

### Data as assets and power

- "Data exhaust" framing (worthless byproduct, analytics as recycling) is backwards: if targeted advertising pays for the service, user activity generating behavioral data is a form of **labor**; the application can be seen as bait to feed the surveillance infrastructure. The human creativity and social relationships expressed in online services are cynically exploited by the data-extraction machine.
- Personal data is a valuable asset: data brokers buy, aggregate, and resell it in secrecy; startups are valued by "eyeballs" — i.e., surveillance capability.
- Because it is valuable, everyone wants it: companies, and governments via secret deals, coercion, legal compulsion, or theft. In bankruptcy, collected personal data is sold off as an asset. Breaches are frequent because data is hard to secure.
- Hence the reframing: data is a **"toxic asset"** or **"hazardous material"** — not the new gold or oil but "the new uranium." Every collection decision must weigh benefit against the risk of the data falling into the wrong hands: criminals, hostile intelligence, insider leaks, unscrupulous future management, or a future repressive government.
- Design for **all possible future governments**, not just today's. Schneier: "It is poor civic hygiene to install technologies that could someday facilitate a police state."
- Knowledge is power; "to scrutinize others while avoiding scrutiny oneself is one of the most important forms of power." Tech companies are not overtly seeking political power, but their surreptitiously accumulated data gives them enormous power over people's lives.

### The Industrial Revolution analogy

The information age parallels the Industrial Revolution: huge long-run gains in living standards, accompanied at first by terrible side effects (pollution, unsafe workplaces, child labor) that took a long time to regulate. Regulation raised the cost of doing business, yet society as a whole benefited hugely and few would want to go back. Schneier's framing: **"Data is the pollution problem of the information age, and protecting privacy is the environmental challenge."** Almost all computers produce information; it stays around, festering — how we contain it and how we dispose of it is central to the health of the information economy. Our grandchildren will judge us on how we handled data collection and misuse, as we judge industrial-age ancestors on pollution. Schneier's exhortation: "We should try to make them proud."

### Legislation and self-regulation

- GDPR principles: data must be "collected for specified, explicit and legitimate purposes," not further processed incompatibly, and be "adequate, relevant and limited to what is necessary" — i.e., **purpose limitation and data minimization**.
- **The core tension**: data minimization runs directly counter to the big-data philosophy of maximize collection, combine datasets, and explore for unforeseen insights. Exploration *is* use for unforeseen purposes, the opposite of "specified and explicit."
- GDPR has had some effect on online advertising but has been weakly enforced and has not changed broader tech-industry culture.
- The opposition to regulation is partly justified: sharing medical data risks privacy but could save lives via better diagnostics and treatments; overregulation may prevent such breakthroughs. Balancing opportunity against risk is genuinely difficult.
- Needed culture shift: stop treating users as metrics to optimize; treat them as humans deserving respect, dignity, and agency. Self-regulate to maintain trust; educate users about how their data is used.
- Privacy as commons: individual control over data is like a national park — destroyed unless explicitly protected (tragedy of the commons). Ubiquitous surveillance is not inevitable; it can still be stopped.

## Actionable rules of thumb

- **Don't retain data forever; purge it as soon as it is no longer needed, and minimize collection in the first place.** Data you don't have cannot be leaked, stolen, or compelled by a government.
- Run the substitution test: would your data pipeline still sound acceptable if "data" read "surveillance"?
- Distinguish tracking that serves the user (search-ranking signals, related-product suggestions) from tracking that serves advertisers; only the former is easily justified as "necessary."
- For any decision system: ask who can appeal, how an erroneous record gets corrected, and whether you could explain a specific decision to a judge.
- Check for proxy variables that reconstruct protected attributes (postal code, IP address ≈ race/class).
- Apply systems thinking: model the humans in the loop and look for self-reinforcing feedback loops before deployment.
- Assume probabilistic outputs will be wrong for individuals even when statistically correct; build recourse mechanisms.
- When deciding to collect, weigh value against the full threat model: breach, insider leak, acquisition, bankruptcy sale, government compulsion — under any future regime.

## How this connects

- Builds directly on **Chapters 11-13** (batch processing, stream processing, dataflow integration): the derived datasets and combined data sources those chapters teach you to build are exactly what users cannot meaningfully consent to, and what this chapter asks you to question.
- **Chapter 1**'s framing of balancing business needs against user needs is the seed this chapter grows: under ad-funded models the two diverge sharply.
- **Chapter 2**'s nonfunctional requirements (reliability, maintainability) gain an implicit sibling here: harm avoidance, privacy, and accountability as system requirements.
- Data retention and deletion practices touch storage and encoding choices (**Chapters 4-5**); breach risk connects to durability and replication of data across systems (**Chapters 6-8**) — every copy is another place data can leak from.
- The chapter closes the book: after thirteen chapters on *how* to build data-intensive systems, this one asks *whether and for whom* you should.
