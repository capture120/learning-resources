# Bootstrapping Culture — Core Learnings

## What this chapter is about

When you become a senior engineering leader (CTO, VP, head of engineering), part of your job is deliberately setting the culture, structure, and processes of your function. First-time CTOs commonly underestimate this; neglecting team culture makes the job harder whether you are growing a new team or reforming an existing one. As the team grows and evolves, attend to culture the way you attend to any other important piece of infrastructure you rely on. The chapter covers when and how to add structure, how to define and apply core values, how to write a career ladder, how to organize cross-functional teams, and how to introduce engineering processes that manage risk without crushing speed.

## Core principles and mental models

### Reframe "structure" as learning, and "process" as transparency
Startup people often see structure and process as slow, bureaucratic, and innovation-crushing. Fournier reframes: systems are not set up because structure has inherent value, but because organizations want to learn from successes and mistakes and encode those lessons transparently. Learning and sharing are how organizations become more stable and scalable. When introducing structure to skeptics, talk about learning and transparency instead.

### Develop a personal philosophy of culture, and test it scientifically
Beyond mechanics, develop a personal philosophy on company culture: know what is important to you, to your company, and to your growing group of colleagues — and consider how to scale that knowledge and effort as the company evolves. You will be trying out structures and processes and learning from them, but it is hard to learn without a basic theory to test; set out to prove or disprove hypotheses about that theory, approaching culture creation scientifically.

### Cultivate decisiveness in the early days
Early startups face enormous uncertainty: unproven markets, unwritten code, no established business rules. They attract people who can handle extremely high uncertainty and risk in exchange for equally high freedom to operate. The most important thing for leaders — meaning everyone in the company, not just founders — is to pick a strategy and run with it. You do not need the perfect solution, just something that gets you to the next milestone (release, growth spurt, funding round, hire). Many initial decisions will be undone a couple of times before they settle — not just technology frameworks but vacation policy, core office hours, even company values; that is normal. "Deciding not to decide" (for example, foregoing titles) is a legitimate option at small scale because it avoids building decision-making apparatus that does not matter yet.

### The Tyranny of Structurelessness
Jo Freeman's essay (written about feminist/anarchist collectives) applies directly to startups: pretending to lack structure creates hidden power structures, because of how human communication works and fails to scale. Freeman identifies the conditions under which truly unstructured groups can work:

1. **Task-oriented** — a narrow, specific function structures the group itself.
2. **Small and homogeneous** — everyone shares a "common language"; diversity without shared context creates constant misunderstanding.
3. **High degree of communication** — everyone is involved in every relevant decision, which only works for roughly five people (or 10–15 organized into overlapping subgroups).
4. **Low skill specialization** — everything can be done by more than one person; people are interchangeable parts.

Early startup engineering teams match this profile: full-stack hires sourced from the current team's networks (homogeneous, low specialization), collocation (high communication), and acting as the execution arm of the product or founder (task-oriented). Even when the overall company grows beyond the small group, the engineering team often pushes itself to stay unstructured. Such teams are either less self-directed than members believe, or run by hidden hierarchies and power dynamics — often both. The same logic explains spaghetti code: task-driven work by interchangeable people in one codebase yields hacks, not thoughtful structure, and refactoring is precisely the act of drawing structure out explicitly.

### Structure is how you scale
Structure is how teams scale, diversify, and take on complex long-term tasks. Just as strong system designers identify and shape underlying system structures, strong leaders identify and shape team structures and dynamics in a way that supports the team's long-term goals and equips individuals to achieve their best.

Structure can come too early — a five-person team with a rigid reporting chain is absurd, and premature process slows a group that should be focused elsewhere. But in small companies it more commonly comes too late. The classic failure: one person makes all decisions and changes his mind frequently. That works with two or three people; at 10, 20, or 50 it produces confusion and wasted effort, and the cost of each change of mind keeps growing.

### The race car / commercial flight / spaceship analogy (On Freud)
The earliest startup is like driving a race car: close to the ground, you feel every move, you can turn quickly, and a crash takes down only you. As you grow you graduate to a commercial flight: farther from the ground, more lives depend on you, movements need more care, but you can still turn relatively quickly. Eventually you fly a spaceship: no quick moves, course set long in advance, but you can go very far and carry many people.

### Gall's law: evolve structure, don't design it from scratch
From John Gall's *Systemantics*: a complex system that works invariably evolved from a simple system that worked; a complex system designed from scratch never works and cannot be patched into working. Your company started as a simple system and evolved complexity. Do not overdesign structure while the team is small and functioning well.

### Use failure to guide structural evolution
Failure is the best place to identify where structure needs to change. When failures occur, examine all contributing aspects of reality; the patterns are opportunities to evolve structure — by adding more, adding different, or removing it. Weigh frequency and cost of the failure. Apply structure at the right level: if failure occurs in only one team, fix that team's structure rather than the whole organization.

Success is a poor teacher. Humans attribute failure to bad luck and success to their own actions, so failure rarely tempts you to overstructure, while success tempts you with silver bullets ("one weird trick"). If you learn from success, identify the actual improvement you expect and the context required to repeat it.

Examples of failures caused by lack of structure:
- Every new hire slows the team for months → no onboarding process.
- People regularly leave because there is no advancement or growth path → no career ladder.
- A third production outage from someone logging into the database and dropping a table → no access controls or operational process.

A single quit over a missing career path may not justify building one; multiple quits or failed hires might. Weigh the value the lack of structure gives the team against the cost of losing people you want to employ.

### Match structure investment to company age and risk
Assess the size of the vessel you are steering along four dimensions:
- **People** — more people require more thoughtful structure to move in the same direction. Leaders wanting tight control need more decision-enforcing structure; modern companies focus structure on goal setting instead, but goal setting and communication require real structure too.
- **Age** — older companies have entrenched habits, but are also more likely to keep surviving.
- **Existing infrastructure** — few business rules and little code mean less need for structure; the more rules and infrastructure exist, the more clarity you need on handling them.
- **Risk tolerance** — regulated industries and high-stakes mistakes demand more structure; generally, the more people depend on you and the larger the business, the less risk you will accept even without regulation.

If the value of your future time is less than the value of your current time (an early startup that may not exist next year), do not invest heavily in saving future time. Conversely, a big, old, stable company benefits from structure that improves efficiency even when it costs something up front — learning rarely comes free. But beware unconditional attachment to old structures: technology change can make formerly risky moves safer than the slow alternative (frequent releases in a SaaS world are far less risky than they were in shipped software, and slower than competitors is the bigger risk).

## Creating your culture

Frederick Laloux's definition (from *Reinventing Organizations*): "Culture is how things get done, without people having to think about it."

- Culture is real, incredibly important, and widely misunderstood. It arises naturally from a company's evolution and becomes a problem if untended. Consciously guiding culture is part of a leader's job.
- Culture is the generally unspoken shared rules of a community. It does not mean everyone holds identical values; it guides a general overlap and provides interaction rules you do not need to think about when deeply ingrained.
- Everyday illustration: American culture dictates shaking hands as a greeting, while in some other cultures touching strangers is considered very odd. The way you address people of different standings or different relationships to you is likewise part of your culture.
- People also decide via contracts and data analysis, but in complex environments where group needs must override individual needs, cultural values are the glue that lets a team work together and decide under uncertainty.
- In a new company, do not expect a planned healthy culture to fall out automatically. Reality is a race for survival, with culture as afterthought or post hoc justification; early employees form the culture for good or bad — likely a mix.
- Not every person fits at every company, and realizing that early is healthy. Thoughtfully created values that are actually *values* reduce surface discrimination: "engineers who graduated from MIT" is not a culture and admits only a narrow slice of humanity, while "people who value technology innovation, hard work, intellect, scientific process, and data" admits a much broader set while ensuring genuinely shared values.
- If you join a company with existing core values, those reflect the founders' culture, and you will be measured against them whether you realize it or not. People who naturally embody all the core values do well easily; those who do not match every value face more friction and must work harder to fit in — not necessarily failure, but real cost.
- This matters most at the executive level. A CTO or cofounder whose values differ sharply from the company's will feel friction in everything, because senior work is negotiation, collaboration, and cross-functional teamwork. Perfect agreement with every value of every senior teammate is rare and unnecessary; what matters is the overlap between the traits you value most and the traits the company values most.

## Applying core values

1. **Define your culture.** Map company values onto your team; add team-specific values or interpret company values for your context. (Rent the Runway's tech team explicitly valued diversity — potential over checkbox screening — and layered a learning culture on top of company values.) Expect every subteam to have a slightly distinct culture: some regimented and professional, some looser with social time.
2. **Reinforce values by rewarding them visibly.** Share core-value stories at all-hands meetings; give shoutouts for living the values. If public praise feels uncomfortable, push through the shyness — the stories a community tells bond it together, and they can be shared without being forced or fake.
3. **Use values in performance reviews.** Evaluate alignment between a person's values and the company's; call out when and how people exhibit core values. This reinforces desired behavior and shows you who exhibits the values and who does not.
4. **Spot values conflicts and coach with the values.** The teammate who always pushes work onto others violates "roll up your sleeves and get involved"; the one who pooh-poohs every idea conflicts with "happiness and positivity is a choice." People can adopt values over time — Fournier herself came from a critical, professional culture and learned (imperfectly) to value positivity without losing her critical eye. Naming the value turns ambiguous friction into coachable specifics.
5. **Use values in interviewing.** Remind interviewers of the team's values and have them look explicitly for matches and collisions. Reject "friendship markers" like "would I enjoy being stuck in an airport with this person?" — cultural fit is not hiring friends. Friendship tests are almost certainly discriminatory, because friendships form around shared background experiences that correlate with schooling, race, class, and gender. The caveat: you certainly do not want to hire people your team can't stand to be around — the objection is to selecting for friendship, not to basic team compatibility.
6. **Be specific about fit, never vague.** A very smart engineer who values independence may not fit a team requiring extensive collaboration; someone who believes the most analytical argument always wins may struggle in a company valuing empathy and intuition. These values are compatible in some contexts and incompatible in others — that is what makes explicit values powerful. Understand your company's values, your team's values, and what you personally value. Write the values down if they are not already written, and use them to evaluate candidates, praise team members, and inform reviews.

## Creating cultural policy: the career ladder

Starting policy documents from scratch is hard, and fewer documents now require it — companies publicly share career paths, pay scales, incident management processes. But copying a template is not enough: what works at one company will not always translate to another, even when the companies look similar. Fournier copied a friend's lightweight eight-level ladder and it flopped, because her team (diverse backgrounds, no shared work culture) needed far more detail than her friend's team (a strong core all from the same large tech company, with shared implicit understanding). The vague ladder caused the level-obsession it was meant to prevent.

The trigger for building a ladder is usually a failure: in her case, an HR salary review revealing no salary structure at all — pay was a function of previous salary plus negotiating skill — and no shared definition of what "senior" meant for hiring.

### Guidance for writing a ladder

- **Solicit participation from your team.** Enlist senior managers and engineers for feedback, rewrites, and details; have subgroups own the parts they care most about (senior individual contributors writing the technical expectations for IC levels). The best processes reflect the team as a whole, not just your current bias, and at a small company you can involve many people without bureaucracy.
- **Look for examples.** Collect ladders from other companies. The best detail tends to come from bigger employers with strong technical reputations, especially for describing the scope of work at very senior technical levels.
- **Be detailed, and match your company.** Aim for inspirational *and* descriptive. Do not expect a director over a 50-person startup org to manage an entire division as at a multinational. Include the details you would actually look for when deciding to hire or promote at a level.
- **Write both a summary and a long form.** A spreadsheet shorthand shows attributes side by side and how they evolve across levels; a long-form version reads like a performance review of a person operating well at each level, showing how the skills combine into a complete role.
- **How many levels? Two questions decide it:** how you pay people, and how you recognize achievement.
- **Tie the ladder to salary deliberately.** Each level gets a salary band. Few levels require very wide bands (people in one level perform very differently, and early-career engineers expect frequent raises).
- **Provide many early advancement opportunities.** Consider promoting early-career engineers roughly every year for their first two to three years: create several levels within "software engineer" with relatively narrow bands, expecting fast promotion or departure.
- **Narrow bands for early career, wide overlapping bands for fewer levels.** Many levels with narrow bands let you promote quickly and keep pay at a level close together — good for fairness and avoiding bias such as paying men more than women at the same level — but it is very hard to write meaningful distinctions between close levels. Fewer, widely spaced levels make the skill distinctions between levels clearer and make it easier to tell who is operating at which level, but they need large overlapping bands (for example, software engineer $50–100K, senior $80–150K) so a strong engineer can out-earn a senior one; that wiggle room retains people performing well who are not ready for the next level, and lets you hire borderline candidates into the lower level expecting quick promotion.
- **Identify your breakpoint level.** The lowest level where someone can stay forever without underperforming — for many companies, around senior engineer; below it, roles are implicitly "up or out." It is good to know where this level is; you may even want to make the ladder harder to climb past it. Expect the team to cluster there, with fewer people above or below.
- **Recognize achievement with keystone levels.** Keeping levels fully secret is impossible (people talk), though you can emphasize some levels and keep others quiet — possibly even from the employees in them. Designate keystone promotions that are shared and celebrated: senior engineer, staff engineer, principal engineer; director and VP on the management track. Keystones spaced apart give people a bigger achievement to strive for beyond the next pay increase. (Fournier does not advocate the HR practice of pay-grade numbers disconnected from the ladder.)
- **Split management and technical tracks** — typically above senior engineer — so management is not the only advancement path. Do not expect symmetric populations: management need is volume-driven (enough managers for the people you have), while senior technical need depends on the complexity and scope of technical leadership your products require. Imbalance in either direction is normal.
- **Consider making people-management skills a mid-career requirement.** Encourage management or mentorship experience before promotion above the track split. For most companies the tracks should split at the point where people start to exhibit leadership — whether that leadership involves managing humans or designing software. Even pure software design involves humans; great senior ICs can manage projects and mentor juniors, so consider requiring leadership experience (such as a tech lead stint) for promotion to senior IC levels.
- **Be wise about years of experience.** It feels like an artificial barrier, but keystone levels carry maturity expectations that correlate with years in industry. Staff engineer, for example, requires the maturity to think through large projects and a track record of completing and supporting long-running work — brilliant programming alone is not enough. Use rules of thumb rather than strict requirements, especially for a first ladder.
- **Evolve the ladder over time.** It is a living document and you will miss things. (Her infrastructure-focused ladder was hard for frontend developers to interpret and needed tweaks to describe senior performance in that world.)

A good ladder feeds hiring, performance reviews, and promotions.

## Cross-functional teams

"Who do you work with, who do you report to, who do you collaborate with" has obvious answers at the extremes — in a tiny company the answer is everyone, and in a very large one the structure was set before you joined. As a leader at a growing company you must answer these questions yourself, at least once and probably multiple times. Cross-functional product development teams — call them pods, squads, or pillars — put everyone needed to make a project successful (frontend and backend engineers, product manager, designers, analysts, even customer service) in one group focused on that project. Benefits: members focus on the shared project, communication across the whole group becomes far more effective, and "us versus them" thinking between functions gives way to seeing the whole group as "us."

**Conway's Law:** organizations design systems that copy their communication structures. Choosing cross-functional teams declares that the most important communication — the kind to favor above all else — is the kind that produces effective product development and iteration. Accept the tradeoff explicitly: this structure will probably *not* produce the most effective technology and will carry some systems-design inefficiencies compared to engineering-centered structures. Decide where you are willing to take system design hits in order to create product effectively.

### Structuring the pods

- Keep management structures intact: engineers report to engineering managers, product managers to the head of product. The pod's roadmap determines day-to-day work; the engineering manager still provides technical guidance and oversight.
- Keep core functions out of pods: someone must oversee critical core systems, and specialists (core web platform, mobile, data engineering) can live in a small infrastructure organization not assigned to product work.
- Engineers in product pods still need time for engineering-specific work: on-call, interviewing, sustaining engineering (technical debt). **Reserve roughly 20% of all engineering time** for this — a rule of thumb from Fournier's experience and that of her peers.
- This structure is not a startup novelty: banks attach technology teams to business areas with centralized infrastructure groups for shared systems, and many large tech companies do the same with former engineers running the "business units."

### Cultural implication: who becomes a leader changes
In technology-focused structures, the role models are the best engineers by engineering excellence — designers of complex systems, masters of the platform. In product-focused structures, the emerging leaders are the engineers with the best product sense, the fastest efficient feature delivery, and the best cross-functional communication. Neither is wrong, but know which one your company's success actually requires: business-spanning product evolution calls for leaders with business sense; rock-solid or cutting-edge technology areas call for engineering-focused teams led by people who can design complex systems. One focus will lead the company as a whole — if you are in senior management, align your own skill set with the one the company values most, and hire in for the other.

## Developing engineering processes

Engineering processes are where structure meets daily reality. Career ladders, values, and team structures are easy compared to the angst caused by wrong engineering processes. Without any process, teams will struggle to scale; with the wrong process, they are slowed down. The essence of guiding good development and operations is balancing the team's current size and risk tolerance against the processes in use. Forcing heavy process on a team all at once, without explaining why, breeds resentment.

### Ask the CTO: process as risk management
*Question:* A head of engineering at a small, fast-growing startup has almost no process — no code reviews, loosely used task tracking, architecture decided by whoever is working on the project. Engineers are complaining about bad code being checked in and want required reviews; meanwhile one engineer built a far-along new system in Scala in an otherwise Ruby shop, and is the only one who knows Scala. How to add process without going from zero to bureaucracy?

*Answer:* **Think of process as risk management.** As teams and systems grow, no one person can keep everything in their head; processes evolve around work coordination to make risks obvious. A process's complexity should be a proxy for how hard or rare the underlying action should be. Two implications:

1. Do not put complicated process on activities where you want people to move quickly and risk is low or obvious. If you adopt code review for all changes, keep it light enough that minor changes are not slowed, or the whole group's productivity suffers.
2. Actively hunt for hidden risk and draw it into the open (a lone-wolf Scala system is exactly such hidden risk).

Note that "complicated" does not just mean long — a process is complicated when it requires sign-off from very busy people or meeting a very high standard. And borrow the political saying that "a good political idea is one that works well in half-baked form": good engineering processes deliver value even when followed imperfectly, and most of that value lies in socializing change and risk to the team.

## Practical advice: depersonalize decision making

Three processes worth adding as the team grows. All work best when you set behavioral expectations around them, not just technical mechanics.

### Code review
A modern standard; at sufficient team and codebase size it protects stability and long-term quality. It sits on the critical path, so keep it straightforward and efficient — and watch for engineers using it to behave badly, criticizing colleagues or enforcing unrealistic standards.
- **Be clear about expectations: code reviews mostly do not catch bugs — tests catch bugs.** Reviews catch missing comment/documentation updates, missing changes to related features, and sometimes inadequate testing. Code review is largely a socialization exercise ensuring multiple people have seen and are aware of the change.
- **Use a linter for style.** Decide a style once and automate its enforcement. Letting style be debated in review wastes absurd time and invites nitpicking that is unproductive at best, bullying at worst.
- **Watch the review backlog.** Some companies cap outstanding review requests per person and block new requests beyond the cap. However you do it, make sure requests flow through and everyone gets adequate time in their own code.

### The outage postmortem (learning review)
Many now say "learning review" instead of "postmortem" to signal that the purpose is learning from the incident, not determining cause of death. Critical elements, especially for small teams:
- **Resist fingerpointing and blame.** After a stressful outage it is tempting to ask why someone ran that command, didn't test, or ignored the alert. Blame only makes people afraid to make mistakes.
- **Examine circumstances and context.** Identify contributing factors — tests that would have caught the problem, tools that would have smoothed incident management. The list of circumstantial contributors reveals patterns and constitutes the actual learning.
- **Be realistic about takeaways.** Learning reviews tend to end in laundry lists of possible improvements. Attempting all of them usually means doing none. Pick the one or two items that are truly high-risk and likely to cause future problems, and explicitly acknowledge the ones you are letting go for now.

### Architecture review
Covers major systems and tools changes. The goal is to socialize big changes to the right group and make their risks clear. Have proposers come prepared to answer:
- How many people on the team are comfortable using this new system or writing this new language?
- Do we have production standards in place for it?
- What is the rollout and training process?
- Are there other new operational considerations?

Guidelines:
- **Be specific about what requires review:** new languages, frameworks, storage systems, developer tooling. Do not try to use architecture review to catch poor feature design — that is unrealistic to catch early in a small company (hard even in large ones), slows everything down, and puts heavy process in front of a common activity.
- **The value is in the preparation.** Requiring people to prepare forces them to think about why they want the change and surfaces risks they had not considered. You may not even need an explicit "why do this at all" question — when someone is willing and able to get through the requirements, the why is usually obvious.
- **Choose the review board wisely.** Include the people who will be most affected by the change, not a static panel of gurus. The goals are to get yourself out of the hot seat for every technical decision and to ensure those who must live with the outcome help evaluate it. Keep the deciding group scoped to those closely impacted — never company-wide. Nothing is more demoralizing than a veto from someone in a completely unrelated area.

## Pitfalls and anti-patterns

- Pretending to have no structure while hidden hierarchies and power dynamics actually run the team.
- Imposing rigid hierarchy or heavy process on a small, well-functioning team (structure too early).
- One leader continuing to make every decision and change course freely as the team grows past a handful of people (structure too late).
- Copying another company's policy document (such as a career ladder) and assuming it will work without adapting it to your team's backgrounds and needs.
- Learning the wrong lessons from success — chasing silver bullets without identifying the real improvement and its required context.
- Unconditional attachment to old structures after technology has made the risk calculus obsolete.
- Defining culture fit by friendship markers ("airport test"), which is nearly always discriminatory.
- Letting code review become a venue for style nitpicking, unrealistic standards, or bullying.
- Blame-driven postmortems that teach people to fear mistakes.
- Postmortem laundry lists where attempting every fix results in fixing nothing.
- Architecture review as a guru panel or company-wide veto body, or as a gate on everyday feature design.
- Going from zero process to full bureaucracy at once, without explaining why the changes are happening.

## Assessing your own experience

- What policies do you have now? What practices? Have you written any of them down? When did you last revisit them?
- Do you have company values? What are they? How do you recognize them in your team?
- Do you have a career ladder? Does it accurately reflect the team today — and the team you want in the future? If not, can you improve it?
- What risks most concern you for your team? For your company? How can you mitigate those risks without burdening the team with unnecessary process and bureaucracy?
