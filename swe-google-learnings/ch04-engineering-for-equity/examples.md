# Chapter 4: Engineering for Equity — Examples and Case Studies

Every substantive example, case study, and anecdote from the chapter, retold in plain language.

## Case study: Google Photos labels Black people as "gorillas"

**Setup.** Google Photos uses image-recognition algorithms (machine-learning models that classify what appears in a photo) to automatically tag pictures. Like all such systems, the algorithm learns from a training dataset — a large collection of labeled example images — and its accuracy depends on that dataset representing the full range of people it will encounter.

**What happened.** In 2015, software engineer Jacky Alciné publicly pointed out on Twitter that Google Photos was classifying photos of his Black friends as "gorillas." Google was slow to respond and its fixes were incomplete; a 2018 Wired article reported that the underlying problem still had not been adequately addressed years later.

**Why it happened.** The chapter identifies three compounding causes:
1. The photo data fed into the algorithm was incomplete — it did not represent the population, particularly Black people.
2. Google (and the tech industry broadly) had little Black representation in its workforce, and that gap shaped the subjective design decisions behind the algorithm and the collection of the dataset. The organization's own unconscious bias likely left a more representative product on the table.
3. Google's target market and testing for image recognition did not adequately include underrepresented groups, so Google's tests never caught the failure — users caught it instead, which both harmed those users and embarrassed the company.

**Lesson.** A product built by an unrepresentative team, trained on unrepresentative data, and tested against an unrepresentative market will fail underrepresented users — even when every individual engineer is highly skilled and well-intentioned. Bias is the default; only deliberate representation in data, teams, and testing prevents it.

## Related product failures: autocomplete, ads, and YouTube hate speech

**Setup.** The chapter lists sibling failures across Google products to show the Photos incident was not an isolated fluke.

**What happened.** Search autocomplete could return offensive or racist suggested completions. Google's advertising system could be manipulated to show racist or offensive ads. YouTube sometimes failed to catch hate speech even though its policies technically outlaw it.

**Lesson.** In these cases the technology was not designed to discriminate — autocomplete was never built to target anyone. But the designs were not resilient enough to exclude discriminatory outcomes, and the harm to users was real regardless of intent. The harm rebounds on the company too: reduced user trust and engagement. For instance, Black, Latinx, and Jewish job applicants could lose faith in Google as a platform or as an inclusive workplace, undermining Google's own goal of improving representation in hiring. Intent does not excuse outcome; resilience against misuse and harm is part of the design requirement.

## Facial recognition and biased law-enforcement databases

**Setup.** AI-driven facial-recognition software is deployed at ever-increasing rates, but its accuracy varies by skin tone because research and training data have not covered a wide enough range of skin tones. Most technologists lack the perspective of underrepresented groups needed to understand the impact of this racial variance.

**What happened.** A 2016 study by the Center on Privacy & Technology at Georgetown Law ("The Perpetual Lineup") found that more than 117 million American adults appear in a law-enforcement facial-recognition database. Because Black communities are disproportionately policed and experience disparate arrest outcomes, a facial-recognition system built on such a database can carry racially biased error rates. Meanwhile, independent testing of these systems has not kept pace with their deployment.

**Lesson.** Even with representative teams, a training set can still be biased and produce invalid results — data science outputs are hard for humans to evaluate. When training data and the people building the software represent only a small subsection of humanity, teams should have the integrity to slow down, delay development, and gather more complete and accurate data. Google's response included offering statistical training within the AI context to help ensure datasets are not intrinsically biased.

## Case study: the global hiring requisition system and performance ratings

**Setup.** Several Google engineering teams built a global hiring requisition system supporting both external hiring and internal transfers. The teams did a genuinely good job of classic product work: they listened closely to their identified core user group — recruiters — who wanted to minimize wasted time for hiring managers and applicants and presented use cases focused on scale and efficiency.

**What happened.** To speed up evaluation, recruiters asked for a feature that would highlight an internal candidate's performance ratings — specifically *low* ratings — to the hiring manager and recruiter as soon as the candidate expressed interest in a job. On its face this looked like a win: faster evaluations, less wasted time for everyone. But reviewers raised three equity questions:
- Are developmental assessments a predictive measure of performance?
- Are the performance assessments free of individual bias?
- Are performance assessment scores standardized across organizations?

If the answer to any of these is "no," surfacing the ratings would drive inequitable — and therefore invalid — hiring results. An engineer questioned whether past performance actually predicts future performance, and the team ran a thorough review. The review found that employees who had received a poor performance rating and then moved to a new team were just as likely to earn a satisfactory or exemplary rating as employees who had never received a poor rating at all.

**Outcome.** Performance ratings turned out to indicate only how a person performs in their *current* role at the time of evaluation. They are not predictive of future performance and should not gauge readiness for a future role or qualify an internal candidate for a different team. (They remain useful for checking whether an employee is well-slotted on their current team and how to better support them.) The analysis consumed significant project time, but the trade-off was a more equitable internal mobility process.

**Lesson.** Building equitable systems sometimes means challenging established processes and stakeholder requests — even reasonable-sounding ones from your core users — when the data they rely on would produce invalid, inequitable results. Spending project time on an equity review is a worthwhile trade against shipping a process that unfairly penalizes people.

## Recurring product examples: wearables and video conferencing

**Setup.** The chapter illustrates the "values versus outcomes" gap — good intentions failing at the implementation level — with a pattern seen across the industry.

**What happened.** Wearable devices were shipped that do not work properly for women's bodies. Video-conferencing software was shipped that works poorly for people with darker skin tones.

**Lesson.** Old habits are hard to break: the users teams are used to designing for and getting feedback from are often not representative of all the users the product must reach. Company values, policies, and investments do not prevent these failures; the failure point is in applying those values at the implementation level. Teams must design for and test with users unlike themselves.

## The hiring-pipeline narrative and Black+ attrition at Google

**Setup.** A widely held single-cause narrative in the technology industry says underrepresentation in the workforce can be fixed solely by improving hiring pipelines — the flow of candidates from education into tech jobs.

**What happened.** Google's own data undercut that narrative: attrition (the rate at which employees leave) among Black+ Google employees outpaced attrition of every other group, confounding progress on representation goals no matter how much hiring improved. People from underrepresented groups were also being passed over daily for opportunities and advancement.

**Lesson.** Reject singular approaches to complex, multifactorial problems. Hiring is a fundamental step but not the immediate bottleneck; retention and progression matter just as much. A manager who wants to hire more women should not only build a pipeline but also examine whether recruiters can identify strong women candidates, whether the team is psychologically safe, and whether growth opportunities are distributed equitably — the whole hiring, retention, and progression ecosystem.

## Anecdote: the "hundreds of years of discrimination" detour

**Setup.** The chapter quotes a favorite line used by both diversity proponents and detractors: "We are working hard to fix (insert systemic discrimination topic), but accountability is hard. How do we combat (insert hundreds of years) of historical discrimination?"

**What happened.** This line of inquiry routinely derails workplace equity efforts into philosophical or academic conversation and away from focused, practical improvement of work conditions and outcomes.

**Lesson.** Deferring to the scale of historical discrimination is a useful academic exercise but an ineffective operating posture. Managers and engineers should move past it to quantifiable, actionable steps within their control — balanced candidate slates, equitable opportunity distribution, inclusive team practices. Everyone is part of the system, so fixing it is everyone's problem, not an abstraction to defer.
