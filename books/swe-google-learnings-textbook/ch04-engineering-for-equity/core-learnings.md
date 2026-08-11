# Chapter 4: Engineering for Equity

*Software Engineering at Google* — written by Demma Rodriguez, edited by Riona MacNamara.

## Chapter thesis

Engineers who build products used by billions of people carry a unique responsibility: their design decisions can empower or harm entire populations, and because every person carries unconscious bias, harm happens by default unless teams actively work against it. The chapter argues that "engineering for equity" — deliberately designing products that work for users of all races, genders, abilities, ages, languages, and socioeconomic backgrounds — is not a side concern but a core mark of engineering excellence. Google wrote the chapter from a position of humility: the company has publicly failed its most vulnerable users (the Google Photos "gorillas" incident being the most famous example), and the path to more equitable products begins with owning those failures. The central prescriptions are: recognize that bias is the default state; build diverse and representative teams; measure equity rather than assume it; design first for the users least like you; and be willing to trade short-term velocity for products that do not harm some of their users.

## Core principles and ideas

### Bias is the default

- **Unconscious bias** is the tendency, documented by social scientists over decades, for most people to enforce and promulgate existing stereotypes without intending to or even noticing. It is more insidious and harder to mitigate than intentional acts of exclusion.
- Because all people carry bias, even the most talented engineers will inadvertently fail users of different nationalities, ethnicities, races, genders, ages, socioeconomic statuses, abilities, and belief systems unless they focus on those users explicitly.
- Organizations, not just individuals, must recognize that bias exists and address it in their workforce, product development, and user outreach.
- When a homogeneous workforce builds products (Google's engineering population is mostly male and mostly White or Asian), the team often lacks the lived perspective needed to see how products affect underrepresented or vulnerable users. Missing representation translates directly into product blind spots.
- When products fail underrepresented users, usually the technology itself is not "to blame" — for example, autocomplete was never designed to discriminate — but the design was not resilient enough to prevent discriminatory outcomes. The harm to users is real either way, and the company also pays a price in lost user trust and engagement.

### Programming skill alone is not enough

- A computer science degree plus work experience produces someone who can write code, establish theories of change, and apply problem-solving methodologies — but that alone does not make an exceptional engineer, and it is insufficient for inclusive and equitable engineering.
- Engineers must frame all work within the **complete ecosystem** they seek to influence: at minimum, understanding the population demographics of their users.
- Engineers should focus on people who are different from themselves — including people who might use the product to cause harm — and especially on users disenfranchised by the processes and environments through which they access technology.

### Multicultural capacity

- **Multicultural capacity** is the ability to understand how products can advantage and disadvantage different groups of human beings. The chapter names it as a mark of an exceptional engineer.
- Technical aptitude must be paired with **discernment**: knowing when to build something and when *not* to, including identifying and rejecting features or products that drive adverse outcomes.
- Engineers wield more power than they realize — tools used by billions influence how people think about the value of human lives, monitor human activity, and capture sensitive data. Exercising that power without causing harm starts with recognizing one's own default bias.
- Historically, companies choosing between a strategic objective that drives market dominance and one that slows momentum have chosen speed and shareholder value. Companies also reward individual performance while failing to drive accountability on product equity. Engineering for global equity is framed as necessary to remain competitive, not just as ethics.
- Biased data produces invalid results: if both the training data and the people creating the software represent only a small subsection of humanity, the output cannot be expected to be valid. In such cases teams should be willing to **delay development** to obtain more complete and accurate data. Google now offers statistical training in the AI context to help ensure datasets are not intrinsically biased.
- Building multicultural capacity is a shared duty: individuals should expand their education into race, gender, and cultural studies, and employers must fund continuous, multidisciplinary professional development. No single person is expected to learn about all other cultures alone.

### Making diversity actionable

- Everyone is accountable for the systemic discrimination visible in the technology sector. **Deferring or abstracting away personal accountability is ineffective and can be irresponsible.**
- The rhetorical move "how can we possibly combat hundreds of years of historical discrimination?" is a detour into philosophy that pulls focus away from concrete improvements to working conditions and outcomes. Acknowledge the systemic context, then move to quantifiable, actionable steps.
- Every technology lead and engineering manager already has the means to augment equity on their own team — balanced candidate slates, equitable distribution of growth opportunities, and so on. "We are all part of the system. It is our problem to fix."

### Reject singular approaches

- Inequity in the technology sector is complex and multifactorial; no single philosophy or methodology fixes it, even when promoted by admired or powerful people.
- The most common singular narrative is that underrepresentation can be solved solely by **fixing the hiring pipeline**. Pipeline work is fundamental but insufficient: systemic inequity also lives in **progression and retention**. (At Google, attrition among Black+ employees outpaces all other groups, which confounds representation goals regardless of hiring.)
- Fully understanding the entire problem space before fixing it applies equally to a data migration and to building a representative workforce.
- The common methodology of **building for the majority use case first** and deferring "edge cases" is flawed: it gives already-advantaged users a head start and increases inequity. Deferring consideration of all user groups until design is nearly complete *lowers* the bar for engineering excellence.
- **Inclusive design from the start** — making tools delightful and accessible for people who struggle to access technology — enhances the experience for *all* users.
- **Designing for the user who is least like you is a best practice**, not merely a nice-to-have.

### Challenge established processes

- Building equitable systems sometimes means challenging established organizational processes that drive invalid results — not just writing more inclusive product specs.
- Requirements handed down by a "core user group" can encode inequity (see the hiring-requisition case study in examples.md). Ask whether the data a feature surfaces is actually *valid* for the decision it will inform: Is it predictive? Is it free of individual bias? Is it standardized across organizations? If any answer is no, surfacing it drives inequitable and therefore invalid results.
- Rigorous equity review costs project time, but the trade-off can be a fundamentally fairer process.

### Values versus outcomes

- Good values, intentions, policies, and investments do not guarantee equitable outcomes. Google's failure point "is not in the values, intentions, or investments of the company, but rather in the application of those policies at the implementation level." Equity is won or lost in implementation.
- The chapter's five-point "way out":
  1. **Take a hard look in the mirror.** A brand promise like "Build For Everyone" is impossible without a representative workforce and an engagement model that centralizes community feedback first.
  2. **Don't build *for* everyone. Build *with* everyone.** Engage users across the spectrum of humanity and intentionally put the most vulnerable communities at the center of design rather than treating them as an afterthought.
  3. **Design for the user who will have the most difficulty using your product.** Building for those with additional challenges makes the product better for everyone. Corollary: don't trade equity for short-term velocity.
  4. **Don't assume equity; measure it throughout your systems.** Decision makers are themselves subject to bias and may lack the expertise to identify or measure an equity issue. Catering to one userbase can disenfranchise another, and these trade-offs can be hard to spot and impossible to reverse. Partner with subject-matter experts in diversity, equity, and inclusion.
  5. **Change is possible.** Surveillance, disinformation, and online harassment cannot be solved with the failed approaches of the past or with only the skills engineers already have.

## Actionable guidance

For individual engineers:
- Recognize your own default bias as the first step; then look for forgotten use cases and users who could benefit from or be harmed by what you build.
- Design first for the most difficult or least represented use case, not the majority case.
- Question whether the data your feature surfaces is valid for the decision it informs; escalate an equity review when it is not.
- Invest in your own multidisciplinary education (race, gender, and cultural studies alongside technical skills).

For managers and leads:
- If you interview or hire, learn how biased outcomes happen in hiring.
- Ensure candidate slates are balanced across underrepresented groups.
- After hiring, track whether growth opportunities are distributed equitably.
- Look beyond the pipeline: audit recruiting, retention, and progression for inclusivity, and check whether recruiters can identify strong candidates from underrepresented groups.
- On diverse teams, invest in psychological safety and team-wide multicultural capacity so new members feel welcome.

For product teams and organizations:
- Do user-experience research with groups that are multilingual and multicultural and that span countries, socioeconomic classes, abilities, and age ranges.
- Build inclusive design in from the start rather than bolting it on late.
- Be willing to delay a launch to gather more complete and less biased data — slowing down beats shipping harm.
- Measure equity in systems continuously instead of assuming it; bring in diversity, equity, and inclusion experts when the team lacks that expertise.
- Fund continuous, multidisciplinary professional development for employees.

## TL;DRs (the chapter's own summary, verbatim)

- Bias is the default.
- Diversity is necessary to design properly for a comprehensive user base.
- Inclusivity is critical not just to improving the hiring pipeline for underrepresented groups, but to providing a truly supportive work environment for all people.
- Product velocity must be evaluated against providing a product that is truly useful to all users. It's better to slow down than to release a product that might cause harm to some users.
