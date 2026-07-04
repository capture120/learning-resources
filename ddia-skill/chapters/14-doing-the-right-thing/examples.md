# Chapter 14: Doing the Right Thing — Examples

Every meaningful example, scenario, and illustration from the chapter, retold compactly.

## Algorithmic prison

Payment networks want to block fraud, banks want to avoid bad loans, airlines want to prevent hijackings, and employers want to avoid bad hires. For each organization, wrongly rejecting a good person costs little, while accepting a bad one costs a lot — so when in doubt, they say no. But a person whom algorithms label risky (accurately or not) gets that "no" from many systems at once: jobs, air travel, insurance, property rental, financial services. The cumulative exclusion from key parts of society has been called "algorithmic prison." Unlike a criminal court, which presumes innocence until guilt is proven, these systems exclude people arbitrarily, without proof, and with little chance of appeal.

**Demonstrates:** individually rational risk-aversion by organizations aggregates into systematic, unappealable exclusion of individuals.

## Postal code and IP address as race proxies

Anti-discrimination law forbids decisions based on protected traits like ethnicity. But in racially segregated neighborhoods, a person's postal code — or even their IP address — is a strong predictor of race. An algorithm that never sees the protected attribute can still discriminate through correlated features. Believing an algorithm can take biased data and emit fair output has been satirized as "machine learning is like money laundering for bias."

**Demonstrates:** removing protected attributes does not remove bias; proxies smuggle it back in, and models amplify whatever bias the training data carries.

## Credit scores versus ML-based scoring

A traditional credit score is a relatively defensible decision input: it answers "how did *you* behave in the past?", rests on facts about your own borrowing history, and errors in the record can be corrected (even if agencies make that hard). ML-based scoring instead answers "who is *similar* to you, and how did people like you behave?" — stereotyping by construction, often via where someone lives, a close proxy for race and class. It uses far more inputs and is far more opaque, so a person put in the wrong bucket, or judged on erroneous data, has almost no way to understand or contest the decision.

**Demonstrates:** the shift from judging individuals on their own record to judging them on similarity to others removes both transparency and recourse.

## Life expectancy and individual predictions

If average life expectancy in your country is 80 years, that does not mean you will die on your 80th birthday. The average and the distribution say almost nothing about one specific person. Likewise, a prediction system's output is probabilistic: even if it is statistically correct overall, it will be wrong for individual people.

**Demonstrates:** statistically valid models still make wrong decisions about individuals, so blind trust in data-driven decisions is dangerous and recourse mechanisms are required.

## Self-driving cars, credit algorithms, and the judge

If a human makes a mistake, they can be held accountable and the affected person can appeal. When a self-driving car causes an accident, who is responsible? If an automated credit-scoring algorithm systematically discriminates by race or religion, is there any recourse? If your ML system's decision comes under judicial review, can you explain to the judge how it was made?

**Demonstrates:** automated decisions create an accountability gap; people must not be able to evade responsibility by blaming an algorithm.

## Aid targeting versus predatory lending

Analytics can reveal the financial and social circumstances of people's lives. The same capability can focus aid and support on the people who need it most — or let predatory businesses identify vulnerable people and sell them risky products like high-cost loans and worthless college degrees.

**Demonstrates:** the same analytical power is dual-use; the harm is in the application, not the technique.

## The credit-score employment spiral

Some employers use credit scores to evaluate job candidates. Imagine a good worker with a good score who hits financial trouble through no fault of their own. Missed bill payments hurt the credit score; the worse score makes finding work harder; joblessness pushes them toward poverty, which worsens the score further. The chapter calls this a downward spiral built on poisonous assumptions, hidden behind a camouflage of mathematical rigor and data.

**Demonstrates:** self-reinforcing feedback loops in predictive systems can trap individuals, and the math makes the trap look objective.

## German gas stations and algorithmic price collusion

Economists found that when gas stations in Germany adopted algorithmic pricing, competition fell and consumer prices rose — the pricing algorithms learned to collude with each other. No one designed collusion in; it emerged from the interaction of independently optimizing systems.

**Demonstrates:** feedback loops between algorithms produce unintended emergent harms; such loops can't always be predicted, but systems thinking (analyzing the entire system, including the people interacting with it, not just the computerized parts) can predict many consequences.

## Echo chambers and elections

When recommendation services get good at predicting what content users want, they end up showing people only opinions they already agree with. These echo chambers breed stereotypes, misinformation, and polarization, with observed effects on election campaigns.

**Demonstrates:** even "low-stakes" prediction (content recommendation) has society-scale unintended consequences.

## The "surveillance" substitution test

Replace the word "data" with "surveillance" and see if your company's phrasing still sounds good: "In our surveillance-driven organization we collect real-time surveillance streams and store them in our surveillance warehouse. Our surveillance scientists use advanced analytics and surveillance processing to derive new insights." The book even jokes about its own title becoming *Designing Surveillance-Intensive Applications*.

**Demonstrates:** a quick framing test that exposes whether your data collection actually serves the user or surveils them.

## A microphone in every room

Smartphones, smart TVs, voice assistants, baby monitors, and even children's toys with cloud-based speech recognition mean nearly every inhabited space contains an internet-connected microphone — many with terrible security records. The most repressive regimes of the past could only dream of a microphone in every room and a mandatory location tracker on every person, yet people accept this voluntarily because the services are valuable. The difference is only that corporations, not governments, collect the data.

**Demonstrates:** mass surveillance infrastructure was built voluntarily through consumer services; the collector's identity, not the capability, is what differs from a police state.

## "Nothing to hide"

Why are we seemingly happy to accept surveillance by corporations? Perhaps you feel you have nothing to hide — in other words, you are totally in line with existing power structures, you are not a marginalized minority, and you needn't fear persecution. Not everyone is so fortunate. Or perhaps the purpose seems benign: not overt coercion, merely better recommendations and more personalized marketing. Combined with predictive analytics that decide things like insurance and employment, that distinction blurs.

**Demonstrates:** the common justifications for accepting surveillance hold only for the privileged, and only while the data stays out of consequential decisions.

## Driving data and fitness trackers in insurance

Behavioral data about car driving, collected by cars without drivers' consent, already affects insurance premiums (the chapter cites an FTC action against General Motors for sharing precise location and driving-behavior data). Some health insurance coverage depends on the customer wearing a fitness tracker.

**Demonstrates:** surveillance stops looking benign once it drives consequential decisions like insurance coverage and employment.

## Smartwatch sensors reveal your passwords

The motion sensor in a smartwatch or fitness tracker can be used to work out what the wearer is typing — including passwords — with fairly good accuracy. Sensor precision and analysis algorithms will only improve.

**Demonstrates:** data is far more revealing than its ostensible purpose suggests; innocuous-looking sensor streams can expose secrets.

## GDPR's definition of real consent

The EU's GDPR requires consent to be "freely given, specific, informed, and unambiguous," withdrawable "without detriment," and requested in "clear and plain language" — silence, pre-ticked boxes, and inactivity do not count. GDPR also allows other lawful bases besides consent, including "legitimate interest": fraud prevention is the example given, since fraudsters would obviously never consent to fraud detection.

**Demonstrates:** the regulatory bar for meaningful consent, which most tracking-driven services fail; and why consent cannot be the only lawful basis for processing.

## "Just don't use the service"

The argument that unhappy users can simply opt out fails when a service is regarded as essential for basic social participation — carrying a smartphone, using social networks to socialize, using Google to find information. Network effects impose a social cost on non-users. Platforms are also deliberately engineered for engagement using game mechanics and tactics borrowed from gambling. Only people privileged enough to understand the privacy policy and absorb the lost social and professional opportunities can realistically decline; for everyone else, surveillance is inescapable.

**Demonstrates:** opting out is not a free choice, so "users voluntarily agreed" does not legitimize tracking.

## The rare-disease patient

Someone with a rare medical condition might happily give their medical data to researchers developing treatments. But if the same information could cost them medical insurance or a job, they would be far more cautious. The point is that they must choose who accesses the data and for what purpose.

**Demonstrates:** privacy is a decision right — choosing what to reveal to whom — not blanket secrecy; "privacy is dead" arguments misunderstand the word.

## Ad targeting of people with an illness

Companies keep what they learn from surveillance secret (revealing it would seem creepy and erode their competitive edge), exposing it only indirectly — for example, as tools letting advertisers target groups such as people suffering from a particular illness. Even if no individual in the targeted bucket can be reidentified, those people have lost agency over the disclosure of intimate information: the company, not the person, decides what is revealed to whom, optimizing for profit.

**Demonstrates:** surveillance transfers the privacy right itself from the individual to the corporation, even without reidentification.

## Factually correct but painful

A recommendation or insight can be factually accurate yet trigger painful memories the user does not want surfaced (the chapter cites Carina Zona's talk "Consequences of an Insightful Algorithm"). Whether output is "undesirable" or "inappropriate" is a human judgment; algorithms are oblivious unless explicitly programmed to respect human needs.

**Demonstrates:** correctness is not sufficiency; engineers must humbly plan for data being wrong, undesirable, or inappropriate.

## Doctor-patient and attorney-client trust

Trust relationships involving sensitive data have always existed — patient and doctor, defendant and attorney — but those uses of data are strictly governed by ethical, legal, and regulatory constraints. Internet services amassed comparable sensitive information at massive scale with no equivalent governance and without meaningful consent.

**Demonstrates:** what is unprecedented is not sensitive data collection itself but its scale combined with the absence of governing constraints.

## Data brokers, eyeballs, and bankruptcy sales

Data brokers operate in secrecy, buying, aggregating, analyzing, and reselling personal data, mostly for marketing. Startups are valued by user numbers — "eyeballs," i.e., surveillance capability. When a company goes bankrupt, its collected personal data is sold as an asset. Governments also seek the data, via secret deals, coercion, legal compulsion, or theft.

**Demonstrates:** personal data is a valuable asset that outlives the context it was collected in, and flows to parties the user never contemplated.

## Data as the new uranium

Because data is valuable, hard to secure, and frequently breached, critics call it a "toxic asset" or "hazardous material" — not the new gold or oil but the new uranium. Threats include criminals, hostile foreign intelligence, insider leaks, unscrupulous future management, and a future regime that compels handover. Schneier's warning: "It is poor civic hygiene to install technologies that could someday facilitate a police state." Collection decisions must consider all possible future governments, not just today's.

**Demonstrates:** every byte collected is a liability under a long-horizon threat model; minimize and purge.

## The Industrial Revolution parallel

The Industrial Revolution brought sustained economic growth and far better living standards, but also dreadful air and water pollution, cramped unsanitary housing, harsh working conditions, and widespread child labor. Safeguards — environmental rules, workplace safety, child-labor bans, food inspections — took a long time and raised the cost of business, yet society as a whole benefited hugely and few would want to go back. Schneier extends the analogy: "Data is the pollution problem of the information age, and protecting privacy is the environmental challenge." Our grandchildren will judge us on how we handled data collection and misuse, as we judge our ancestors on industrial pollution.

**Demonstrates:** transformative technologies create harms that society eventually regulates; the information age is early in that cycle, and engineers can choose to be ahead of it.

## Medical data sharing versus overregulation

Companies oppose data regulation as a burden on innovation, and the opposition is partly justified: sharing medical data clearly risks privacy, but data analysis might enable better diagnostics and treatments that prevent deaths. Overregulation could block those breakthroughs.

**Demonstrates:** the opportunity-risk balance in data regulation is genuinely hard; neither "collect everything" nor "collect nothing" is obviously right.

## Privacy as a national park

Individual control over one's own data is like the natural environment of a national park: if not explicitly protected and cared for, it will be destroyed — a tragedy of the commons leaving everyone worse off. The chapter's first practical step: don't retain data forever; purge it when no longer needed, and minimize collection. Data you don't have can't be leaked, stolen, or compelled by a government.

**Demonstrates:** privacy is a commons requiring active protection, and data minimization plus deletion is the concrete engineering starting point.
