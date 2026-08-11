# Chapter 6: Managing Multiple Teams — Core Learnings

## What this chapter is about

This chapter covers the shift from managing one team to managing several, typically at the engineering director level, where you are no longer writing much (if any) production code. Fournier covers managing multiple teams before managing managers because, while related, the two don't necessarily coincide — at this stage you probably have tech leads (not managers) reporting to you. The job becomes managing your time deliberately, delegating to develop your teams' independence, learning to say no, watching technical health signals instead of writing the code yourself, and building team identity around company purpose rather than tribal cliques.

- The concrete workload signal: juggling the work of directly managing more than three or four people with keeping up on details about what's happening across a couple of teams probably means one important thing — you're not writing (much, any, production) code.

## The role: what an engineering director is

Drawn from Fournier's own career ladder (written at Rent the Runway), the director:

- Leads engineers across multiple product areas or technology functions; both tech leads and individual contributors report in.
- Is not generally expected to write code day to day, but remains responsible for the organization's overall technical competence, growing it through training and hiring.
- Keeps a strong technical background: researches new technologies, stays abreast of industry trends, can help debug and triage critical systems, and understands the systems well enough to do code reviews and help research problems.
- Contributes to architecture and design mainly by being the technically savvy voice asking business and product questions of the engineers, ensuring code matches product and business needs and can scale as those needs grow.
- Is primarily concerned with smooth execution of complex deliverables: continually evaluating and refining development and infrastructure standards and processes, creating high-performance, high-velocity organizations, owning recruiting, headcount planning, career growth, training, retention goals, and sometimes vendor management and budgeting.
- Creates and grows the next generation of leadership and management talent, and helps that talent learn to balance technical and people leadership.
- Strategically balances immediate product/business work against technical debt and strategic technical development.
- Sets the example for cross-functional collaboration, and communicates both ways: simplifying technical concepts for nontechnical partners and explaining business direction to engineers in a way that inspires them. The goal of that collaboration is a strategic and tactical tech roadmap tackling business needs, efficiencies and revenue, and fundamental technology innovation. Directors also help create a positive public presence for the engineering brand and can sell the company and their area to candidates.
- Guides goal-setting for all teams in the organization, so team goals support both business initiatives and technology/organizational quality.

## Staying technical without writing much code

- Be realistic: between 1-1s, planning sessions, and peer meetings, your schedule has moved from "maker" to "manager." Without solid blocks of dedicated time at least a few days a week, any code you write will be very slow-going.
- Ways to stay hands-on that don't require much production code:
  - Code reviews, at least as a secondary reviewer — especially on systems you built, where you remember details better than most.
  - Debugging and production support, if you were a strong debugger before management; if not, jumping into incidents may be more annoying than useful.
  - Pair programming, or fixing minor bugs and small features.
- Don't dismiss these small efforts. They keep you in tune with the feel of software development and show your teams you're willing and able to help with the day-to-day.
- The risk of going hands-off is amplified if you never got deeply, fluently comfortable with at least one programming language. Fournier strongly advocates gaining mastery of programming before moving into management (it took her about 10 years, including degrees). The test: could you productively contribute to a good codebase in that language after a limited ramp-up, using standard tools, frameworks, and libraries? Deep knowledge atrophies, but language fluency sticks for a long time.
- Fluency also means an ingrained sense of what it's like to work productively on a team building production software. Without that sense of the rhythms of building software, you will struggle with a critical part of this job: debugging team issues and keeping teams producing quality software smoothly.
- Protect at least one solid half-day a week completely free of meetings, and spend part of it on a creative pursuit: engineering blog posts, conference talks, open source. Scratch the creative itch that management otherwise leaves unscratched.

### Ask the CTO: "I miss code — should I quit management?"

Almost everyone moving from a heavily hands-on role has a transition period of questioning the decision and worrying about losing skills. Check whether you've internalized the industry's contempt for management: management *is* a job, a necessary and important one, and right now it's yours. Code offers constant quick wins (tests pass, features compile, bugs die); management has few obvious quick wins for new managers, so nostalgia for simpler times is natural. But you can't do everything at once: becoming a great manager requires giving up some technical focus. It's a tradeoff you must consciously decide whether you're willing to make.

## Managing your time: importance versus urgency

Time management is personal; Fournier recommends David Allen's *Getting Things Done* as useful to think about even if you don't adopt the whole process. Her general philosophy: every task sits on a 2x2 of importance and urgency.

| | Not urgent | Urgent |
|---|---|---|
| **Important** | Strategic: make time | Obvious work |
| **Unimportant** | Obvious avoid | Tempting distractions |

- Important-and-urgent work (an outage, reviews due tomorrow, a candidate with a competing offer expiring) takes care of itself — you feel it.
- Meetings aren't your only output: you still have deliverables that require more than sitting in a meeting — setting team goals, helping product put details on roadmaps, and making sure assigned tasks actually got finished. That last one, following up on task completion, can become one of the biggest time sinks and distractions in your day if you aren't careful.
- The danger is losing the sense of *importance*, because urgency is felt more clearly. Email feels urgent but almost never is; it's perhaps the worst vehicle for genuinely urgent information — hence the common tip to read and respond to email only at set times of day. The whole internet (news, Facebook, Twitter) feels urgent the same way. Chat (Slack and the like) is nearly as bad, at least for a collocated team — moving communication into chat is not eliminating communication, and the ever-moving trickle can be even more distracting.
- We also substitute "obvious" for "urgent": a meeting on your calendar is obviously where you should be, but is it really the best use of your time, or are you using it to avoid thinking about that question?
- You are probably spending too much time on urgent-but-only-slightly-important work and sacrificing important-but-not-urgent work. Examples of important-but-not-urgent: preparing for meetings so you can guide them well, writing job descriptions, building a hiring plan, reviewing project work for creeping problems, resolving a simmering cross-team disagreement, and simply thinking about the future. Also on the list: cultivating the list of things that are important but that you haven't thought about in a while, so you know what to focus on. If you don't set aside some time to focus on these issues, they'll sneak up on you in negative ways.
- Win back time by pushing an efficient meeting culture down to your teams: hold people accountable for preparation, ask for agenda items up front, and give every standard meeting (planning, retrospective, postmortem) a clear procedure and expected outcomes.
- At this level your boss expects you to manage yourself and your teams independently — to handle important-but-not-urgent matters before they become urgent, especially before they become urgent *for your manager*. No one will teach you to manage your calendar; managers fail here because they cannot juggle the workload in an organized fashion.
- Meetings can land in the urgent-but-unimportant quadrant, and you may decide to skip those where you're not clearly needed — but be very careful about over-deploying that strategy at this level, because keeping your teams moving forward and happily engaged rests on your shoulders. Your attendance is partly to read team dynamics and morale: a happy team is energized and engaged; an unhappy one looks drained or bored. Skipping meetings means missing early clues — including the clue that there are too many boring meetings.
- You are responsible for balancing breadth and depth: knowing your teams' details today while also looking at where you need to go and what it takes to get there.
- Standing questions to ask yourself: How important is what I'm doing right now? Does it seem important only because it's urgent? How much of this week went to urgent things? Have I carved out enough time for the non-urgent?

### Cate Huston's lesson (guest contribution)

If your team needs a manager more than it needs an engineer, being that manager means you by definition cannot be that engineer. Some people manage both, but you must decide which one you're willing to be bad at. Being a bad engineer feels bad to you; being a bad manager is a choice inflicted on *other people*, which isn't fair. At the end of a day with no code written and nothing quantifiable achieved, "I was as good a manager as I know how to be" has to be enough.

## Decisions and delegation

- The first several months of managing multiple teams can feel like a death march even on reasonable hours — your attention is sliced and diced across meetings all day. The only way out is through. If you don't feel at least a little overwhelmed in this transition, you are probably missing something that needs your attention.
- The defining metaphor from here on: plate spinning. Your plates are the people and projects you oversee; the job is judging how much attention each needs, and when. Approach it with a student's mind — you will drop plates by neglecting them too long; honing your instincts about when to touch which plate is the game.
- You improve with time: you start recognizing early warning signs of failing projects, people about to quit, and underperforming teams. Meetings are where you learn what healthy and unhealthy dynamics look like — another reason not to drop out of them.
- Keep regular, reliable 1-1s with everyone reporting directly to you. With many reports, shorten them or go biweekly — but skipping 1-1s because you're busy is a great way to miss the warning signs of someone about to quit.

### The delegation matrix

Delegation is the primary way to claw yourself out of the feeling of too many plates spinning at once. Ask of every incoming task: do I need to be the person who does this? Decide by frequency and complexity:

| | Frequent | Infrequent |
|---|---|---|
| **Simple** | Delegate | Do it yourself |
| **Complex** | Delegate (carefully) | Delegate for training purposes |

- **Simple and frequent — delegate.** Running standups, writing the weekly team progress summary, minor code reviews. Tech leads and senior engineers can take these on with little or no training.
- **Simple and infrequent — just do it.** If doing it is faster than explaining it and it rarely recurs (booking a conference ticket, running the quarterly report script), roll up your sleeves even if it feels beneath you.
- **Complex and infrequent — yours alone, but use as training.** Performance reviews and hiring plans are your job, but they're also skills rising managers need. Have a tech lead sit with you to write an intern's review; ask a senior engineer to estimate staffing for next year's project. Get help from above until you're comfortable, then start pulling rising leaders in to learn.
- **Complex and frequent — delegate carefully to develop your team.** Project planning, systems design, being the key person during an outage: these are the biggest opportunities to grow talent while making the team run better. The goal is teams that operate at a high level without much input from you.
- Audit yourself: list the tasks only you know how to do. Some are appropriately yours, but many — project management, onboarding, breaking product roadmap goals into technical deliverables, production support — are skills your teams need to learn. Teaching costs time up front and saves it long term; building talent is part of your job.
- Delegation starts slow but becomes the essential element of your own career growth: if your teams can't operate without you, you'll find it hard to be promoted. Push decisions down so you can pick up new plates.

### Ask the CTO: warning signs of trouble and quiet quitting

Signals worth learning to spot:

- A usually chatty, happy, engaged person suddenly leaves early, arrives late, goes quiet in meetings, and disappears from chat: either a major personal issue or preparing to quit. People usually tell someone when it's a personal issue (sick relative, relationship problems, health) — but not always. If it follows a promotion round, reorg, or similar event, they may feel overlooked. Have an honest conversation before the resignation arrives.
- A tech lead who insists everything is fine but frequently skips 1-1s and gives vague status updates is often hiding something — usually slower-than-expected progress, or building outside the project's scope. Help them build a clear project plan early and set expectations for adjusting it, so hiding a lack of progress is harder. Help them clarify goals and scope. Related patterns: new hires in over their heads, and the person who spends their time advocating new languages/platforms/processes instead of finishing work.
- Team meetings with no energy at all — the product manager and tech lead do all the talking while everyone else sits silent or speaks only when called on — mean the team isn't engaged with the work or doesn't feel it has a say in decisions.
- A project list that changes weekly with customers' whims means the team hasn't thought about goals beyond pleasing customers and may need better product or business direction.
- A small team whose engineers profess ignorance about systems they don't personally work on, with no curiosity to learn, identifies more with its day-to-day systems than with the wider team or company — and may resist changing those systems for the larger organization's needs.

## Strategies for saying no

A manager creates fertile environments and acts as enabler, coach, and champion — but doing that requires saying no: to the team, to peers, and to the boss. Strategies:

- **"Yes, and"** (the technique from improvisational comedy). With your boss especially, no rarely looks like "no." It looks like "Yes, we can do that project, and all we need to do is delay this other project on the roadmap." Positivity plus the boundaries of reality is a senior-leadership skill; engineers' knee-jerk habit is articulating downsides. "Yes, and" often turns contentious disagreements into realistic priority negotiations.
- **Create policies.** When you find yourself repeating the same no with the same reasons (for example, to requests for a new programming language: "we need more people who know it, production experience with it, logging standards, a testing story"), turn the repeated reasons into a policy: the hard requirements for a yes plus guidelines for thinking it through. A policy tells the team in advance the cost of getting to yes.
- **"Help me say yes."** For one-off cases without a policy, dig into the questionable parts with curious questioning. Often the person realizes on their own that the idea is weak; sometimes they surprise you. Either way you say no and teach at the same time.
- **Appeal to budget.** Lay out the current workload plainly and show there's no room. Often paired with "not right now" — which is somewhat passive-aggressive, because it implies you'll do it later. Only say "not right now" if later can actually happen.
- **Work as a team.** Act jointly with peers, especially cross-functional ones: lend your technical authority to a product no, or call in finance to back a budget no. Good cop/bad cop is slightly dishonest, so use it sparingly, but it builds favors you can call in when you need backing for your own no.
- **Don't prevaricate.** When you know the answer is no and you have the authority, say it quickly rather than dragging out the process. You'll sometimes be wrong — apologize when you were too quick. You won't have time to deeply analyze every decision, so practice the quick no (and quick yes) on low-risk, low-impact calls.

### Ask the CTO: "my tech lead isn't managing"

When a tech lead fails to oversee a junior engineer (no project plan, ignored design feedback), don't step in directly. First ask the tech lead why it hasn't happened. Usually it's some mix of: (1) she's busy with her own work and forgot — remind her that mentoring and oversight must be scheduled alongside coding; and (2) she doesn't know how to push someone who won't commit — ask what she's tried and suggest approaches. New tech leads often hesitate to push because they don't feel they have authority and get flustered when asked-for work never arrives. Coach the tech lead to ask for reports herself. It's slower than doing it yourself, but it teaches the team to respect her requests and teaches her to lead independently.

## Technical elements beyond code

Assuming this job is essentially nontechnical is a mistake. The new skills are easiest to learn if you understand the practice and discipline of software engineering. Your technical focus turns to observing and improving the *systems of work* your developers operate within, and developing an eye for the team's technical health signals.

*First, Break All the Rules* (Buckingham and Coffman) discusses several questions that predict team productivity and satisfaction; Fournier highlights three: Do I know what's expected of me? Do I have the materials and equipment to do my work right? Do I have the opportunity to do what I do best every day? For engineers, the answers show up in how fast and how often they push code: if the work they need to do is clear, they know what code to write; if the tools, tickets, automation, and process are available and easy to use, they can get the code written; and if they aren't distracted by excessive meetings or drowning in support and incident management, they get a chance to write code every day. The key health signals — frequency of code releases, frequency of code check-ins, and *infrequency* of incidents — are the indicators of a team that knows what to do, has the tools to do it, and has the time to do it every day.

## Measuring the health of your development team

Put your technical hat on to design systems and processes that keep things moving. Build the tools developers need, help them focus, interrogate every process for the value it provides, and always ask whether it can be automated further.

### Frequency of releases

- Release frequency is the most direct measure of whether a team ships, and one of the leading indicators of a healthy engineering team. Moving fast requires breaking work into small chunks. Even if your company doesn't value frequent releases, work toward the best release frequency possible — and even non-releasable products (say, a database) have an equivalent: complete artifacts pushed to a beta/developer environment, measured for frequency and stability.
- Interrogate the release process: How long does it take? What's gone wrong recently? How often are releases delayed or rolled back, and at what cost? Who decides code is production-ready, and how long does that take?
- Teams that don't release frequently show predictable cracks: the release process is long; engineers don't own code quality and toss it to QA (adding back-and-forth communication delays); rollbacks are slow; the release process itself causes incidents or broken builds.
- When you hear "no time, the roadmap is full," "our systems weren't designed for it," or "it doesn't matter," test it: Is the team at full capacity? Are engineers challenged and growing? Is product excited about the pace? Do people spend most of their time writing new code? If yes to all, fine. If not, you have a problem, and ignoring it is at your peril.
- You're still responsible for the technical side of getting work done and for team productivity. The fix is rarely cheerleading, raises, or praise — it's enabling productivity, challenging the team to go faster and do better, and finding time to make the work more interesting. Advocate for technical process improvements even though you won't implement them yourself.
- Pushing on release frequency often surfaces the real engineering challenges — there is no one true way to increase it, since frequency problems are somewhat unique to each team — typically automation gaps, feature-toggle tooling, backward-compatible architecture, rolling upgrades, and small changes instead of giant patches. You lead this effort even if you don't do the work; push for time away from the product roadmap and set goals that inspire the team to move faster.

### Frequency of code check-ins

- Agile teams must break work into small chunks. Teach this to new college hires, and expect that even senior developers sometimes need a push. Fournier doesn't advocate a specific methodology, but observes that engineers who don't write tests often have a harder time breaking down work; learning test-driven development — even if they don't practice it daily — improves the skill.
- This conversation is uncomfortable: telling people who've coded as long as you (or longer) that their style needs updating triggers deep conflict avoidance, because it feels personal. But if your company expects fast-moving product development, engineers who go off for weeks writing code alone without pushing to shared version control slow the team and cause problems. You're not managing a research team (and if you are, this doesn't apply). It is OK to expect work in progress to be regularly updated.

### Frequency of incidents

- Decide the level of software quality the product actually needs, and adjust it over time — this is a technical judgment the manager helps make. A brand-new product at a small, growing business may rightly favor features over stability; mission-critical systems may make stability and incident minimization the top priority. The goal is balancing risk so that neither incident response nor incident prevention pulls developers away from writing code for days at a time.
- On developer on-call: frequent on-call nights and weekends is a huge contributor to burnout, but it puts the best-qualified people on fixing problems. If your team runs its own incident management, move yourself into escalation support — you'll manage fewer incidents directly but must be more available when the on-call person needs you.
- Ask of incident management: "Is our current setup enabling my team to do what they do best every day?" When incident management is merely *reacting* to incidents rather than working to reduce them, engineers cycle through on-call burned out, accomplish nothing but firefighting, and hand the misery to the next person on the rotation — and hate their jobs a little more each time. The leader's job then is to carve out time to design more stable systems and fix recurring incidents as they arise.
- The opposite failure is real too: overfocusing on defect-free systems or error prevention by slowing development — weeks of manual QA, excessive and slow code reviews, infrequent releases, drawn-out planning — leaves developers idle and restless without necessarily reducing incident risk.

## Good manager, bad manager: us-versus-them versus team player

New managers often default to building team identity around the team's function or technology — making the team feel special compared to everyone else. Taken too far, this creates a clique more invested in its own superiority than in the company's goals. This **shallow binding** produces predictable dysfunctions:

- **Fragile to the loss of the leader.** Cliques tend to dissolve and leave when their manager does — which also makes it harder to fix the problems that manager created.
- **Resistant to outside ideas.** In-groups reject ideas from outside, missing chances to learn and grow. The best members get bored (they think they're already on the best team) and leave the company rather than just switching teams.
- **Empire building.** Us-versus-them leaders grow their teams and mandates without regard to the wider organization, competing with peers for headcount and control of projects.
- **Inflexibility.** Reorganizations, cancelled projects, and shifting priorities break the core of the clique's identity and can devastate its fragile bond to the company.

The alternative is **purpose-based binding**: teams built on a shared purpose that comes from the company itself, aligned with company values (developed further in Chapter 9's "Applying Core Values"), that understand the company mission and how their team fits into it — and see that the mission requires many different types of teams, all sharing one set of values. Such teams are:

- **Resilient to loss of individuals**, including leadership, because their loyalty is to the larger organization's mission.
- **Driven to find better ways to achieve their purpose** — they care about an idea's merit, not its source, learn from outside their function, and seek broad collaboration.
- **First-team focused.** A strong team player knows their reports are not their first team; their first team is their peers across the company. This frame makes leaders weigh the whole company's needs before their own team's.
- **Open to changes that serve the purpose** — restructures and people moving to where the business needs them are understood as serving the wider vision.

Practical cautions:

- Even when you were hired explicitly to fix a team, the company got this far on real strengths. Before reshaping everything to your vision, take time to understand the company's culture and strengths, and build a team that works *with* that culture. Don't focus on what's broken; identify existing strengths and cultivate them.
- In startups especially, goals and even mission can be fuzzy. If so, do your best to understand the culture and set your teams up to work well within it. Cross-team and cross-functional collaboration helps teams see the bigger picture and value their mission as part of it.

## The virtues of laziness and impatience

Larry Wall's engineering virtues — laziness, impatience, and hubris — persist into leadership, and the first two should be deliberately channeled:

- Never direct impatience at individuals (rude), and never *appear* lazy (nothing is worse than a manager taking it easy while the team kills itself). But impatience paired with laziness, directed at *processes and decisions*, is the key to focus.
- As a leader, model two behaviors above all: **figuring out what's important, and going home.**
- Impatience: whenever something feels inefficient, question it. Why does this feel inefficient? What is the value of the thing we're doing? Can we deliver that value faster? Can we strip the project down to something simpler and finish it more quickly?
- The trap: "can we do this faster" is often heard (or meant) as "work longer hours." That's why laziness matters. "Faster" means the same value to the company in less *total time* — not the same hours compressed into fewer days. A team working 60-hour weeks to ship in one week what would take a week and a half hasn't worked faster; it has donated free time to the company. Cultures that encourage constant long hours are almost certainly using brute force in place of thought. Engineers automate so they can focus on the work that uses most of the brain — and that work can't be done for endless hours day after day.
- Go home, and stop emailing at all hours. Forcing yourself to disengage is essential for your mental health; nearly everyone who sustains excess hours hits some degree of burnout, which is terrible for individuals, families, and teams.
- Your hours set your team's norms. When you send email at midnight or on weekends — even if you expect no response — people see it and conclude it's important; the resulting overwork then makes them less effective at detailed knowledge work.
- If, as a newish manager, you genuinely need extra hours for a while, hide the footprint: queue weekend and overnight emails to send the next workday, set your chat status to away in off hours, take real vacations without answering email. And keep asking yourself the same questions you ask your team: Can I do this faster? Do I need to do this at all? What value am I providing?
- The closing principle: we focus so we can go home, and we encourage going home because it forces constant focus. This is how great teams scale.

## Assessing your own experience

- When did you last review your schedule for activities that aren't providing much value to you or your team? Looking back and forward a couple of weeks: what did you accomplish, and what do you hope to accomplish?
- If you're still writing code, how does it fit into your schedule? Are you doing it after hours? What's driving you to keep spending that time?
- What was the last task you delegated to a member of one of your teams? Was it simple or complex? How is that person handling it?
- Who are the rising leaders on your teams? What's your plan for coaching them into bigger leadership roles, and what tasks are you giving them to prepare them for more responsibility?
- Does the process of writing, releasing, and supporting code run smoothly on your teams? When was the last noticeable incident in that process, what happened, how did the team respond, and how often do such exceptions occur?
- When did you last push a team to cut a project's scope? When you cut scope, do you cut features, technical quality, or both — and how do you decide?
- When did you last send email after 8 p.m. or on a weekend? Did the recipient respond, and did you actually need them to?
