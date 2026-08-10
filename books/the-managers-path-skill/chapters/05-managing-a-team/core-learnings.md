# Chapter 5: Managing a Team — Core Learnings

## What this chapter is about

Managing a whole team is a different job from managing a person or two; it is not just individual management multiplied. The chapter focuses deliberately on the parts of the job beyond people management — staying technical, debugging team dysfunction, driving good decisions, taming conflict, removing toxic dynamics, and doing higher-level project planning — because new managers tend to over-focus on the people tasks and neglect the technical, strategic, and leadership work.

## The engineering lead role

Fournier's job description for a first-level team manager ("engineering lead") sets the expectations:

- Spends less time writing code but still ships small technical deliverables (bug fixes, small features) without blocking or slowing the team.
- Owns identifying bottlenecks and roadblocks for the team and clearing them.
- Identifies the highest-value projects and keeps the team focused on them, partnering with the product lead on scope.
- Identifies headcount needs and plans/recruits to fill them.
- Manages people with skill sets different from their own; communicates expectations clearly; solicits *and* delivers individual feedback frequently, not just at review time.
- Acts as leader of the technical roadmap for the product group: communicates timeline, scope, and risk; leads delivery of major initiatives; identifies strategic technical debt, does the cost/benefit analysis for fixing it, and proposes timelines to management.

Key framing: at every step up the management ladder, the job changes substantially. Management is not a natural extension of senior-engineer skills; it is a new skill set.

## Staying Technical

Engineering management is a technical discipline, not a generic people job.

- Even when you stop writing much code, you must guide technical decision making and hold senior technical staff (architects, tech leads) accountable — making sure decisions pass the "technical smell test" and are balanced against team and business context.
- Technical credibility is required to command an engineering team's respect. Without it you face an uphill battle, and your options for leadership roles beyond one company will be limited.
- At the single-team level, stay in the code via small features and bug fixes. Why bother with small stuff:
  - You feel bottlenecks and process problems (slow builds, painful deploys, on-call nightmares) directly instead of inferring them from metrics. That builds empathy for your team's frustrations and makes it easier to spot and prioritize technical debt.
  - You can evaluate feasibility when the product manager proposes something ambitious, and identify the shortest path through the systems to implement features (though beware overconfidence in off-the-cuff estimates).
- Balance is a genuine struggle. Manager responsibilities — more meetings, planning, administrative tasks — don't lend themselves to focused coding time, and it's hard to stay in the code while pulled in a million directions. But at this level, if you don't stay in the code, you risk making yourself technically obsolete too early in your career; a management track doesn't mean washing your hands of technical responsibilities.
- Company-size/context qualification: some companies have no "manager who codes a little" role — they split tracks so cleanly that managers start with large teams and a purely administrative job. With large teams reporting directly to them from day one, these managers end up grabbing technical time on nights and weekends, if ever — and it's hard to make up lost time once you stop writing code. If your company is like that, **stay technical** (stay an engineer) until you feel you have truly mastered what you want to learn about writing code and designing systems, then decide whether to switch to management. Stop coding too early and you may never build enough technical savvy to get beyond middle management.
- This advice is level-specific: later in the career there is a point where staying in the code stops making sense. At this level, staying in it a little makes the job easier.

## Debugging Dysfunctional Teams: The Basics

Warning signs of a dysfunctional team: missed deliverables, unhappy people, people quitting, a frustrated product manager (or a team frustrated with the product manager), or just low energy and enthusiasm for current projects. You can tell something is wrong without being sure what. Four common dysfunctions, how to recognize them, and what to do.

### Not shipping
- Even research-mode teams need goals and deliverables; humans feel good setting small goals and meeting them regularly. A team that never marks work as done is dysfunctional.
- The common managerial failure mode: worrying about pushing the team too hard and therefore letting them miss deadlines without a fuss. The trick is to balance pushing versus holding back. If you still code, roll up your sleeves to help meet deliverables, or dig into the slipping part of the project with the responsible engineers.
- Often the cause is tooling/process friction. Infrequent releases (weekly or less) hide pain: poor release tooling, heavy manual testing, oversized features, developers who can't break work down. Push to remove these bottlenecks — releases are a scarce, contended resource, and scarcity breeds conflict; making shipping cheap and frequent improves morale directly.

### People drama
- Don't hang onto the "brilliant asshole" too long, and act fast on the milder drama-stirrer who dwells on negatives, gossips, and plays us-against-them.
- Be brave; nip drama in the bud quickly. It's fine to ask your manager for help, especially your first time handling this, but know she may have a *harder* time seeing the problem than you — she sees a productive person, not the day-to-day damage to team dynamics. Expect a series of conversations with both the employee and your boss; sometimes a team move resolves it.
- For the negative (non-brilliant-jerk) person: state clearly that the behavior must change, bring concrete examples, and give corrective feedback quickly after incidents. Sometimes the person is simply unhappy and the kindest move is helping him leave on good terms; sometimes he has no idea of his impact and one chat curtails it.
- Don't let vocal negativity linger — these "energy vampires" are hard for even great managers to combat. The best defense is a good offense: quick action.

### Unhappiness due to overwork
- Usually addressable at the root. If overwork comes from production instability, slow the product roadmap and focus on stability; set clear measures for alerts, downtime, and incidents and drive them down. In every planning session, dedicate 20% of the team's time to system "sustainability" work (Fournier's preferred term over "technical debt").
- For a time-critical crunch:
  1. Be the cheerleader. Help with the work yourself, order dinner, say thank you, promise and deliver explicit break time afterward, make it as fun as possible. A crunch handled this way can even become a bonding experience. The team will remember whether you were present during the push or off doing your own thing.
  2. Learn from the crunch so it doesn't recur: cut features, push back on unrealistic dates. Crunches happen, but they should be rare.

### Collaboration problems
- When your team clashes with product, design, or another tech team: no quick fix, but visible willingness to improve collaboration goes a long way. Hold regular touch-bases with your peer leads, gather actionable feedback from your team, and discuss improvements.
- Never undermine your peers in front of your team; stay positive and supportive of their efforts in public even when privately frustrated.
- If the team isn't working well together internally, create low-stakes social opportunities: team lunch, leaving early on a Friday for a fun event, light PG-rated humor in chat, asking about people's lives. Even most introverts want relatedness with their team. (Assuming no underlying people-drama problems, small bonding efforts warm a group considerably.)

## Ask the CTO: Managing a Former Peer

Question: promoted to manage a team that includes a senior-engineer peer who also wanted the job.

- Acknowledge the awkwardness openly. Be honest and transparent: you'll do your best, you need his help, and you need his honesty about what's working and what isn't. Accept being a little vulnerable — you won't be perfect at first.
- Use your new authority over decisions very cautiously. Overriding technical decisions with managerial power is usually a bad idea. Resist micromanaging, especially of former peers — they're sensitive to the feeling that you were "rewarded" even if they didn't want the job, and questioning their every move makes it worse.
- Let go of some of your old work. Every step up means new responsibilities and giving up old ones. Turn that into an advantage: openly hand former peers more control over technical work you used to own, and give new challenges to junior members. Expect your own coding to shrink to small features, bug fixes, and enhancements.
- Show the team your new role takes nothing away from them — it adds responsibilities that were neglected or belonged to someone else, and shifts some of your old work to them.
- Your team fails if your former peers all quit because they can't stand working for you. They may be extra-sensitive to perceived power grabs or even try to undermine you. Pick your battles; handle the transition with maturity.

## The Shield — and its limits

Standard advice says the manager is a shield (a "bullshit umbrella") keeping company drama and politics off the team. Fournier holds this with reservations:

- Yes, shield the team from toxic drama that doesn't concern them (e.g., interpersonal incidents in another org). Teams that function while the world burns are valuable; workplace drama is mostly an ego-entertaining drain. Help people focus on what they can impact and ignore what they can't.
- But you cannot and should not shield from everything. The goal is not zero stress; it is appropriate context. Humans need to know *why* goals were set and what problems they're solving. If a system being late means operational pain in November, the team deserves to understand that consequence. Context is what lets the team make good decisions about where to focus — you should not make all those decisions alone.
- Don't deny that outside drama exists. If layoffs happen elsewhere in the company and the team hears it through the grapevine, they feel something bad is happening that no one will admit. Communicate such events straightforwardly and with low emotion; that neutralizes gossip.
- You are a shield, **not a parent**. Combining shield and mentor roles can slide into treating the team like fragile children to protect, nurture, and chide. They are adults who deserve respect. The parental framing is bad for your sanity too: you take their mistakes personally, view them as extensions of yourself, and get over-invested in every disagreement.

## How to Drive Good Decisions

The product manager owns the product roadmap, the tech lead owns technical details, but the engineering manager is accountable for the team's progress through all of it. You may only guide decisions rather than dictate them, yet you'll be judged by how they turn out. Five practices:

1. **Create a data-driven team culture.** Product/business leaders justify decisions with business and customer data; add engineering data to the mix — team productivity (time to complete features), quality measures (time spent on outages, bugs found in QA or post-release). Use these to evaluate both product features and technical changes.
2. **Flex your own product muscles.** Whoever consumes your output — external customers, other engineers, a supported team — treat them as your customer. Customer empathy lets you give engineers context for their work and shows which parts of the technology most affect customers, guiding where you invest engineering effort.
3. **Look into the future.** Think two steps ahead on both product and technology. Knowing where the product roadmap is going shapes the technical roadmap (e.g., rewriting checkout to enable new payment types, or adopting a framework that enables a more interactive experience). Ask the product team about the future; keep up with technological developments that could change how you build or operate.
4. **Review the outcomes of your decisions and projects.** Check whether the hypotheses that motivated projects came true: did the rewrite actually make the team faster? Did customers behave as product predicted? What did the A/B tests teach? Reviewing assumptions after completion is easy to forget; make it a habit and you'll always learn from your decisions.
5. **Run retrospectives for processes and the day-to-day.** Agile processes usually hold one at the end of each two-week sprint, but whatever your methodology, regular retrospectives (pick a few good/bad/neutral events to discuss) detect patterns and force a reckoning with decision outcomes. Is the team feeling good about how they get requirements? About code quality? This teaches you how your decisions affect the team's day-to-day over time. This is more subjective than health metrics but arguably more valuable, because it surfaces what the team itself notices, struggles with, or celebrates.

## Good Manager, Bad Manager: Conflict Avoider vs. Conflict Tamer

A conflict-avoidant manager favors artificial harmony over functional working relationships, won't say no, and offloads hard calls to the group — which leaves no one feeling secure. A conflict tamer makes the hard calls herself, explains the why, and creates safe structure for disagreement. Constant bickering is dysfunctional, but pretending disagreement doesn't exist is worse than creating a safe environment for it to work itself out.

### Dos and don'ts of managing conflict

- **Don't rely exclusively on consensus or voting.** Consensus looks morally authoritative but assumes impartial participants with equal stakes and equal context — rarely true on teams with varied roles and expertise. Don't set up votes you know will fail as a way of dodging your responsibility to deliver bad news yourself; that's cruel.
- **Do set up clear processes to depersonalize decisions.** Group decision making needs shared standards: agree on goals, risks, and the questions to answer before deciding. When you assign decision ownership, make explicit who must be consulted for feedback and who must be informed of the result.
- **Don't turn a blind eye to simmering issues.** Negative feedback in a performance review should never be a major surprise. Nuances you only think through while writing the review are fine, but major problems with someone's work must be raised as soon as you notice them. If you only learn of problems through peer feedback at review time, you're not paying attention and not making room in 1-1s for people to raise colleague issues.
- **Do address issues without courting drama.** Distinguish letting off steam from real interpersonal problems. Ask: Is it ongoing? Have I personally observed it? Are many people struggling with it? Is there a power dynamic or potential bias at play? Your goal is to resolve things that make the team work less effectively together — not to become the team's therapist.
- **Don't take it out on other teams.** Conflict-avoidant managers often pick fights externally instead: identifying strongly with their own team, bullying other teams after cross-team incidents, blaming outsiders. Sometimes this is displaced frustration with their own team that they were afraid to voice.
- **Do remember to be kind, not nice.** Wanting to be liked is natural and human, and many of us believe being seen as nice is how to be liked — that niceness is itself the goal. It isn't. "Nice" is polite-society language for strangers; managerial relationships go deeper and demand kindness. Kind: telling someone she isn't ready for promotion and exactly what work would get her there. Unkind: saying "maybe you could get promoted" and watching her fail. Kind: telling someone his meeting behavior disrupts the group, however awkward. Difficult conversations are part of the job.
- **Don't be afraid.** Conflict avoidance is usually fear — of the responsibility of deciding, of seeming demanding, of people quitting, of being disliked, of failing. Some fear is natural; sensitivity to conflict outcomes is wise. But don't let it run you.
- **Do get curious.** Interrogate your own motives to combat fear: Am I delegating this decision because the team is genuinely best placed to make it, or because I fear being blamed for an unpopular call? Am I avoiding my peer because she's truly difficult, or hoping the issue resolves itself so I don't risk being wrong? Am I withholding feedback because it really was a one-off bad day, or because I'm afraid he won't like me? Thoughtfulness about your own behavior prevents both avoidance and unnecessary conflict.

## Team Cohesion Destroyers

The foundation of a functional team is **psychological safety**: members willing to take risks and make mistakes in front of one another. Gelling starts with friendliness — know people as humans, ask about their kids' birthday parties, ski trips, marathon training. Let people share what they feel comfortable sharing — invite conversation about their extracurricular lives and interests rather than pressing for disclosure. That isn't empty small talk; it builds relatedness, the sense of people as individuals rather than anonymous cogs. You also want the team to build relatedness among themselves; friendly teams are happier, gel faster, and produce better results (this is the wise instinct behind "culture fit" hiring, despite its discrimination risks). Note: the old "pizza test" (do they stick around to socialize?) is flawed — people with hard stop times are no less engaged — but the underlying point about camaraderie stands.

"Toxic" employees are those who make everyone they touch less effective. They almost always behave in ways that make it hard for the rest of the team to feel safe around them — which is exactly why they destroy cohesion: they attack the psychological safety the team is built on. Deal with them quickly. Three types:

### The brilliant jerk
- Produces individually outsized results but is so ego-driven she creates fear and dislike around her. She has probably been rewarded for her brilliance for a very long time and clings to it like a life raft; admitting there's value beyond intelligence threatens her identity. So she bullies with intellect, harshly cuts down dissent, ignores those she believes are not her equal, and lets contempt for anything "stupid" seep out.
- Most companies claim they don't tolerate brilliant jerks; Fournier doesn't believe it. It's very hard to justify firing someone who produces great work, especially an irregular jerk. You'll run rings around the idea to keep her; feedback yields brief improvement, then worse behavior.
- **Best solution: don't hire one.** Once hired, removal requires unusual management confidence. Fortunately they often get rid of themselves — you may lack the guts to fire her, but you won't be stupid enough to promote her.
- If you have one: expect her to fight all feedback tooth and nail. If she doesn't see her behavior as a problem, she won't change, and you alone probably can't convince her — no evidence changes a person who doesn't want to change.
- Tactic: openly refuse to tolerate bad behavior. This is one of the few cases where "praise in public, criticize in private" is upended. When behavior is visibly harming the team in the moment and you don't want the culture to mimic it, set the standard publicly and immediately: "Please do not speak to people that way; it is disrespectful." Keep your reaction tightly controlled — neutral but to the point — because public delivery walks a fine line: seeming emotional lets the offender dismiss it as emotion, or makes you look like you're picking on her. Use public correction only for behavior detrimental to the whole group; if she's merely undermining *you*, handle it in private. Priority order: protect the team as a whole, then protect each individual, and protect yourself last.

### The noncommunicator
- Hides information from you, teammates, and the product manager; works in secret to unveil a "perfect" finished project; reverts others' commits or grabs their tickets instead of talking; avoids code review and design review.
- Nip the information-hiding habit immediately; if needed, state plainly that he is failing to meet expectations.
- Diagnose the cause: often fear of being found lacking or of being assigned uninteresting work; sometimes a belief that he deserves more responsibility and doesn't respect his manager. Whatever the cause, the secrecy breaks team cohesion and his fear can spread as an example.
- Address root causes where possible. If he fears criticism, ask whether the team's culture is harsh — does the team lack psychological safety in general? Is the team treating him as an outsider because of a different background or skill set? If the team is rejecting him, decide whether to correct the team or move the individual. Sometimes moving him is the kindest option; other times the right fix is changing the team's culture and breaking habits that exclude new people.

### The employee who lacks respect
- The person who simply doesn't respect you as manager, or doesn't respect her teammates. You may need your manager's help, but handling it yourself shows great character.
- The play is simple: ask if she wants to be working on your team. If yes, lay out your expectations clearly and calmly. If no, start moving her to another team or help her leave the company.
- That's the whole answer. You cannot keep someone who doesn't respect you or the team; it eats at team cohesion as everyone wonders whether she's right not to respect you. Pull the Band-Aid off fast.

## Advanced Project Management

As manager you help set the team's schedule as the larger organization plans the quarter or year: estimating whether the team can take on projects, how big they are, whether you have the right people, whether you can absorb support for old systems, how many hires a new initiative needs. You'll be expected to do both off-the-cuff estimation and concrete project planning — and you'll likely be asked for rough estimates of when work will be done even for work that is planned and iterated in an agile fashion. You need a strong sense of the team's rhythm and pace. You may push planning detail to tech leads, but some of it stays with you — including deciding which projects to take on and when to push back.

### Rules of thumb

- **None of this replaces agile project management.** Don't go waterfall and plan everything up front. Agile collaboration is great for dividing and roughly estimating the small pieces day to day; don't disrupt or take over that execution process. Your job is the larger picture — accomplishments measured in months, not weeks.
- **You get about 10 productive engineering weeks per engineer per quarter.** A quarter is ~13 weeks, but vacations, meetings, review season, outages, and onboarding eat focus — don't expect more than 10 weeks of focused effort on the *main projects* per team member. Q1 (post-holidays) is typically the most productive quarter; Q4 (winter holidays) the least.
- **Budget 20% of time for generic sustaining engineering, across the board.** Testing, debugging, legacy cleanup, language/platform migrations — work that simply must happen. Done habitually, this lets you steadily improve midsize legacy code each quarter, keeping systems easy to work in and feature work fast. At worst, the slack absorbs unexpected feature delays. Schedule 100% feature work and expect feature development to slow down quickly from the overscheduling.
- **As deadlines approach, it is your job to say no.** Hitting goal dates requires cutting scope at the end. Partner with your tech lead and product lead to find which "must-haves" aren't actually must-haves — and say no to both sides. Sometimes engineering claims a feature is impossible without other technical work: decide when to push for a hack and when to hold out for the right implementation. Sometimes product wants features with heavy engineering complexity: work out the real must-haves while explaining the cost of their full vision. When push comes to shove, you're the one giving options for what can realistically ship, or how much more time everything would take.
- **Use the doubling rule for quick estimates, but demand planning time for longer tasks.** "Take your guess and double it" works for off-the-cuff asks. For anything you think exceeds a couple of weeks, double the estimate *and* make clear you need planning time before committing — long tasks can take far more than twice the guess, and careful planning is worth it before committing the team to a big unknown project.
- **Be selective about what you bring to the team to estimate.** Constant random estimate requests from a manager are distracting and stressful. You are responsible for absorbing uncertainty and limiting how much reaches the team. Don't be a telephone relaying every message from the rest of the company — but don't be a black hole either. Get a teamwide process for discussing new features and customer complaints, and keep estimation requests inside that process.

## Ask the CTO: Joining a Small Team

Question: experienced manager, newly hired to lead five engineers at a new company — new technology, new team. How to spend the first weeks?

- Coming in cold is harder than being promoted from within: there's a team to learn *and* a codebase to learn.
- Get into the software without annoying the team: have someone walk you through the systems, architecture, and the testing/release process. Go through the standard developer onboarding (checkout, deploy). Get comfortable in the codebases; watch code reviews/pull requests.
- Plan to work on at least a couple of features in your first 60 days. Take a specced-out feature and build it. Pair with an engineer on his feature, and have him pair with you on yours. Get your code reviewed by a team member. Perform a release. Do a support rotation for a couple of days if the team owns support.
- Yes, this slows down your management onboarding. The slowdown is worth it: knowing the code, the coding processes, and the daily tools gives you both the understanding needed to manage the team and the technical credibility needed for the team to see you as a capable leader.

## Assessing Your Own Experience

- What are your new responsibilities as a team manager? What have you stopped doing or handed off to make time for them?
- How well do you know the day-to-day challenges of writing, deploying, and supporting code on your team?
- How often does your team mark work as completed?
- When did you last write a feature, debug a problem, or pair with a team member on code they were struggling with?
- Are one or two team members causing the bulk of the negativity? What is your plan for resolving that problem?
- Do team members seem engaged with each other — smiling in meetings, joking in chat, getting coffee or lunch together? When did you last all sit down together without talking about work?
- How does your team make decisions? Is there a process for assigning decision-making responsibility? Which decisions do you hold yourself responsible for making?
- When did you last review a completed project against its goals?
- How well does your team understand why they're working on their current projects?
- When did you last cut scope on a project, and what criteria determined what to cut?
