# Managing Managers — Core Learnings

## What this chapter is about

Managing managers looks like managing multiple teams, but the difference in magnitude changes the job. Information now arrives through an extra layer of abstraction, you may oversee functions you have never done yourself, and problems can fester invisibly for months. The chapter covers how to get real information (skip-levels), how to hold managers accountable, how to handle new and experienced managers, how to hire managers, how to debug dysfunctional organizations, and how to stay technically relevant.

## Core principles and mental models

**This level is a new game, not more of the same.** People who were good at managing one team or a couple of related teams can fall apart here. Common failure modes: retreating into individual-contributor work, or playing project manager instead of training managers to do that themselves. Why they fall apart: they can't balance the ambiguities inherent in the new role, so they fall back into things they find easy — that is what the retreat into IC work or project management really is. Expect this level to give you a whole new sense of your own strengths and weaknesses. Treating the role as "what I did before, but bigger" is the central mistake. This is the entry point into senior leadership and demands a new set of skills.

**Follow up on everything until your instincts tell you what to skip.** Early on you have no intuition for where to dive deep. So check the little things: Is recruiting happening? Are your managers coaching their teams? Are quarterly goals written and reviewed? Did the postmortem for that incident happen, and did you read it? Over time you learn what you can stop following up on. Honing those instincts requires following through on things you're not sure are important but just sense are off — this is a place to find your discomfort, chase it down, and sit with it unblinking. For teams doing work outside your skill set, step in even more frequently, even when things seem to be going well; as a first-timer you won't detect problems there until they're far gone.

**Open-door policies do not surface problems.** Expecting people to bring problems to you requires an extremely brave engineer willing to take the risk of telling the boss (or the boss's boss) about trouble — and assumes the engineer can even articulate it. Some problems will never be escalated to you, even on teams you built and that trust you. Ferreting out problems proactively is part of your job. The risk grows with distance from the team; the classic clueless executive move is relying on office hours instead of one-on-ones and direct contact, then wondering why retention and delivery are bad. You ultimately evaluate your managers on the performance of their teams — which is why you need information about those teams that doesn't come only through the manager. Predicting problems is part of your job; being blindsided by a team falling apart, major attrition, or a major project shipping late reflects poorly on you as the higher-level manager.

**Your managers should make your life easier — but not by hiding problems.** The universal goal for manager reports is that they free you for the bigger picture. The trap: some managers "make life easier" by telling you what you want to hear until things fall apart. Making your life easier means bringing you clear problems before they become raging fires, not hiding information.

**Great engineering managers are great debuggers.** Both relentlessly pursue "why." Teams are complex black boxes interacting with other black boxes; when outputs look wrong you have to open them up, and like systems, teams can resist yielding their inner workings. Without the drive to understand why, you rely on charm and luck and have a huge blind spot for learning from your mistakes.

**Andy Grove's cultural-values insight (High Output Management):** people use cultural values to make decisions in complex, uncertain, ambiguous situations where group interest must beat self-interest. New hires act in self-interest until they know their colleagues, so a new manager dropped into a complex job tends to fail unless she quickly settles into the company's cultural norms. Screen for managers who naturally gravitate toward values you already hold.

## Skip-level meetings

Skip-levels are meetings with the people who report to your direct reports. Their purpose is perspective on the health and focus of your teams. Many managers skip or undervalue them; don't.

**Format 1 — quarterly 1-1s with everyone in your org.** Creates at least a surface-level personal relationship (which stops you treating people as "resources"), and gives individuals room for questions they would never schedule a meeting to ask. Works best when you provide prompts and remind people the meeting is largely for their benefit. Suggested prompts:

- What do you like best/worst about your current project?
- Who on your team has been doing really well recently?
- Any feedback about your manager — what's going well, what isn't?
- What changes could we make to the product? Opportunities we're missing?
- How is the organization doing overall? Anything we could do better/more/less?
- Any areas of business strategy you don't understand?
- What's keeping you from doing your best work right now?
- How happy (or not) are you at the company? What would make working here more fun?

This doesn't scale forever: at 60 people you're doing one per working day; at 1,000 it's all you would do.

**Format 2 — skip-level lunches with whole teams**, a couple of times per quarter, for larger organizations. You get group dynamics and direct feedback, and become familiar to teams (and they to you). You lose individual career coaching, and people are reluctant to complain about their manager in front of others. Group prompts:

- What can I, your manager's manager, provide for you or your team? Anything I should be helping with?
- Is this team working poorly with any other teams, from your perspective?
- Any questions about the larger organization I can answer?

**Why skip-levels matter beyond trust:** they detect managers who manage up well to the detriment of their teams. Those managers reach you first, so you're predisposed to take their side; skip-levels are your reality check from the ground.

**Tradeoffs:** you are constantly balancing expensive engagements (1-1s: deep value, high time cost) against casual ones (efficient, less detail). You won't get it perfectly right — sometimes you'll hear too late about a suffering project, a failing manager, or a problem team member. Invest anyway.

**Don't skip them with teams you used to manage directly.** Relationships decay as teams change, and even unchanged team members won't always come to you with problems they have with their manager.

## Manager accountability

You can't just expect managers to magically make things better — you have to hold them accountable, and learning how is one of your biggest learning opportunities at this level. Accountability on complex teams is muddled: tech leads own technical direction, product managers own the roadmap, other teams impinge. Despite that, **the manager is accountable for the health and productivity of the team — full stop.** You measure the manager on the output of his team, and it is his responsibility to fix things that are not going well. Three common scenarios, all of which the manager owns:

- **Unstable product roadmap** (constantly changing goals, everything urgent, attrition): the manager should identify the damage, work with product to refocus, and escalate to you if that fails.
- **Errant tech lead** (down a redesign rabbit hole, design doc stalled, work piling up): the manager must pull him out, make the design process transparent, and bring in senior people from other teams as mentors or collaborators.
- **Full-time firefighting mode** (inherited legacy systems, crushing support burden, stalled migration roadmap): the manager should build a plan for tackling the causes of fires, triage the support burden, refuse some requests, or ask for more people.

Your role: provide the clout your managers lack — back them against product, find senior partners, approve hires, shift support load. They identify and surface problems clearly; you help find solutions.

Managers need coaching just like individual contributors. Don't let 1-1s become pure schedule-and-planning sessions; make time for feedback, get to know them as people, and attend to their strengths and growth areas. These people have the biggest impact on your organization's success or failure.

## Good manager, bad manager: the people pleaser

The people pleaser has a deep aversion to making people he cares about unhappy, so he says yes to everything and burns out. Signs:

- Team loves her as a person but is frustrated with her as a manager; she hides problems and shields the team from the outside world.
- More interested in a smooth-running, mistake-free team than in pushing the team toward excellence.
- Wears bad moods on her face, draining team confidence.
- Never pushes back on work, yet has many unfinished tasks and excuses.
- Overpromises and underdelivers, and never learns to promise less.
- Says yes to everyone, sending contradictory messages and creating widespread confusion.
- Knows about all the problems but hasn't directly addressed any of them.

**Two variants:**

- **The team pleaser (therapist):** engages everyone's emotions, listens endlessly, inspires loyalty — but amplifies drama and negativity and disappoints the team with promises he can't keep. He doesn't play favorites, but those willing to pour their hearts out to him end up getting most of his time.
- **The external pleaser:** terrified of revealing team problems to her boss and partners; manages up and out, significantly overcommits the team, agrees to every incoming request — yet gives little praise or feedback internally because she avoids all difficult conversations. External pleasers are a dangerous blind spot for *you*: you don't learn of problems until it's too late, and you probably like them. They're very nice. They're also good at distracting you from your concerns — plenty of excuses, promises to do better next time, even genuine contrition when you give corrective feedback — but doing things that visibly make others unhappy remains very hard for them.

**Counterintuitive point:** people pleasers do not create safe-to-fail teams — the opposite. The manager's own fear of failure and rejection prevents healthy failure. The external pleaser shuts down honest conversation through evasion or emotional manipulation that rests on being universally liked; the team pleaser sets the team up to fail with unrealistic promises, breeding bitterness toward the manager or company.

**What to do:** Help the person feel safer saying no, and externalize decisions so failure isn't personal. Give him strong partners who own the work roadmap. Agile-style processes help because the team owns work planning instead of the manager's discretion. Structured promotion criteria let the pleaser point to a process outside her control. Show the person the behavior and its downsides — sometimes awareness alone fixes it. The behavior usually comes from genuine values of selflessness and caring; honor those values while correcting the unhealthy habits.

## Managing new managers

Management is a career change, so first-timers need heavy coaching — an up-front cost that pays long-term dividends. Don't assume people skills translate automatically (the new manager may believe this too). Expect cluelessness on basics: running 1-1s is intimidating the first time (What do you talk about? How do you give feedback? How do you keep track of takeaways?). No book or training replaces spending time seeing what questions or challenges she needs help with. Ask how her 1-1s are going; sometimes you just need to remind her to hold them at all.

When a new manager slips on management details, her team suffers, which means you suffer — people quitting because their manager gave them no career path or inspiration is ultimately your responsibility. Use skip-levels to detect where she needs support, and tell her up front you'll be holding frequent skip-levels while you guide her.

**Warning signs:**

- **Overwork** usually means she hasn't handed off her old responsibilities and is doing two jobs. Make clear you expect the handoff and help her find opportunities to do it.
- **The control freak / power-tripper:** believes the title is the key to authority, makes every decision, assigns specific work, domineers. Overwork is often a sign of this danger too, not only of a failed handoff. Skip-levels with senior team members will reveal their frustration at having no decision-making power. Related to (but distinct from) the micromanager who demands excessive detail. Control freaks fight peers in product and other teams instead of collaborating, and often hide what they're doing from *you* for fear of losing control — skipped 1-1s and evaded questions are the tell. Managers who neglect the job are bad; managers who seize it as a license for authority can be worse.
- **Learned helplessness about delivery:** some new managers don't realize they now own the team's performance and delivery, and feel helpless before challenging goals or roadmaps. Don't nag or permanently hand-hold, but coach through team planning at first and set the expectation up front that you'll hold her accountable for the team.

**If the person lacks willingness or aptitude:** making the wrong person a manager is a mistake; keeping her there once you realize it is a critical error. Baby steps into management (mentoring, then very small teams) are valuable but don't surface every problem — control freaks often suppress the impulse until they have title authority. Watch new managers closely; be prepared to give strong corrective feedback within the first six months.

Supplement your coaching with external training: HR new-manager curricula, technology-leadership conferences, and programs run by current or former engineering managers.

## Managing experienced managers

The right experienced manager handles the job without your help — but management is a deeply culture-specific skill. Best practices don't transfer to a bad culture fit, which is why young companies seed management with early employees who know the company's DNA. They get the culture, understand deeply what is important, and already have the internal networks built to get things done.

- **Culture fit beats domain expertise.** Managers create subcultures, and an incompatible subculture poisons cross-team work. Don't let product-area expertise blind you to cultural and process mismatch. For a dynamic, product-centric engineering org, you need managers who can work with frequent shipping, modern development practices, and creative product-minded engineers — those skills matter far more than industry knowledge. Industry information is easier to acquire than a working style is to retrain. Don't compromise on culture fit, especially for managers.
- **Work out differences actively.** Experienced managers will have their own ideas. That's healthy, but it differs from letting them do whatever they want. Even (especially) if he's been managing longer than you, learn from him *and* give your own feedback. Collaborate on areas of difference.
- **You own the culture.** Ensure managers respect and nurture the culture you want: if you value transparency, make sure the manager shares information; if you value exploration, make sure he schedules space for it. Respect that every team will differ slightly and every manager has strengths and weaknesses to account for.
- **Inspiring them:** coaching shifts from nuts-and-bolts to strategy and direction-setting for their area. Delegate real tasks, treat them as advisors on organizational direction, and help them expand their network inside and outside the company (peer programs help).

## Hiring managers

The typical trigger for hiring a manager from outside: the organization is struggling (say, ten engineers each with under three years' experience), no existing engineer who might be qualified wants the role, and none has enough management experience to take it on without heavy training. People resist hiring managers from outside for good reason: we can barely evaluate engineers, and management is harder to demonstrate. But you *can* get worthwhile signal. The process has two parts, like a good engineering loop: skills, then culture fit.

**The core hazard:** management skills are almost entirely communication-based, so managers can bullshit an interview more easily than engineers can. But engineers who code well in interviews also sometimes fail to ship; separate your fear of what happens post-hire from what you can actually evaluate.

**Skills interview techniques:**

- **Role-play 1-1s.** Have the people who would report to the candidate interview her by asking for help with problems they have right now or had recently. Like asking a senior engineer to debug an issue you just solved: a good manager, even without full context, shows good instincts for which questions to ask and what next steps might help. Extend to role-playing an underperformer or delivering a negative performance review.
- **Test team debugging.** Ask her to describe running a project that was behind schedule and what she did. Role-play an employee thinking about quitting. Ask how she's coached struggling employees and grown great ones.
- **Ask for a management philosophy.** A new manager may not answer well, but an experienced manager with no philosophy at all is a red flag. What does she think the manager's job is? How does she stay hands-on, and how does she delegate?
- **Group presentation (senior candidates).** The point isn't the content but whether she can command a room, structure her thoughts, and field group questions. These are skills a senior manager should possess; if she lacks them, take that into consideration when deciding whether to hire her. Don't overvalue this: speaking skills serve some leadership styles, not all, and plenty of excellent managers dislike presenting to strangers.
- **Technical screen.** Enough to confirm she can establish credibility with the team she'll manage. Coding managers get an abbreviated version of the standard technical interview. Non-coding managers get design/architecture questions about systems they've built or managed — make sure she can discuss the tradeoffs and why they were made. A strong option: have her mediate a staged technical debate between engineers; good technical managers know which questions tease out the core issues and guide the group to consensus.

**Culture fit screening:** Understand your own company's values first. Informal versus strictly hierarchical structures each break managers used to the other. Servant-leadership cultures clash with marching-orders managers; collaborative cultures clash with loudest-voice-wins managers. Big-company people *can* succeed at startups and vice versa (the author did), but you must evaluate the fit explicitly.

Culture fit matters more in managers than anyone else because **managers shape their teams to their own culture and hire to their cultural ideas.** Hire a mismatched manager and one of two things happens: she fails and you fire her, or most of the team quits and you may still fire her. Sometimes culture change is the goal — growing startups hire seasoned managers and executives to add experience, which sometimes works brilliantly and is sometimes a massive failure. Either way, expect attrition around the bearers of a new culture, and proceed with caution.

**Always do thorough reference checks**, even for people you've worked with before. Ask references how the person succeeds *and* how she fails, whether they'd work with or for her again, what they love about her and what drives them crazy. Even candidate-chosen references reveal a lot. Skipping references on a management hire is a massive disservice to your team.

## Ask the CTO: the fallacy of the open-door policy (distilled)

Question: "I have an open-door policy and office hours, but no one brings me problems and I keep getting blindsided." Answer: the open-door policy basically never works. It takes a brave engineer to risk telling the boss about problems, and assumes she can even articulate them. Proactively ferreting out problems is your job; the further you are from a team, the worse passive availability works. Keep 1-1s open for real conversation and hold skip-levels with your managers' reports. Predicting problems is part of your job, and being blindsided by major attrition or a blown project reflects on you; these problems get more expensive the longer they go undetected.

## Ask the CTO: managing outside your skill set (distilled)

Question: "I now manage operations and QA teams, which I've never run before." Answer: be careful — this is not a small leap. Each function tracks different important details, and you won't know which to watch, so problems in unfamiliar areas surface late — especially long-timeline projects that hide lack of progress, and especially when you've hired a manager you can't independently evaluate. Antidote: the mentorship mindset — be openly curious. Ask the manager to teach you her work as if she were your mentor; make clear the goal is appreciating what she does. And deliberately overweight your time toward the unfamiliar areas, especially early. Pure trust-and-delegate misses problems for far too long, and if you secretly view an area as uninteresting, guilt and aversion will keep you from facing its issues even when people wave flags. Grit your teeth, learn each area, and practice asking for details until you develop a sense for what the team actually does.

## Debugging dysfunctional organizations

Worked like debugging a system. Example problem: a team "feels slow" — business partners and the product manager complain, and the team lacks energy.

- **Have a hypothesis.** Find a plausible explanation for how the system entered the failed state, and investigate as minimally invasively as possible so your meddling doesn't obscure the problem. Team problems resemble performance bugs more than hard failures: the system runs but slows down sometimes; people seem happy but attrition is too high.
- **Check the data.** The equivalent of reading logfiles: team chats, emails, tickets, code reviews, commits, calendars. Are production incidents eating time? Lots of sickness? Bickering over coding style in reviews? Tickets vague, too big, or too small? Is chat upbeat and human or purely transactional? Too many meeting hours? Is the manager skipping 1-1s? None are smoking guns; all are pointers.
- **Observe the team.** Sit in their meetings. Boring meetings are a sign — of inefficient planning by the organizers, of over-scripting, of too many meetings for the information covered, or of members who don't feel they can shape the team's direction or choose its work. Good meetings have healthy conflict; opinions and ideas get drawn out. Fear of disagreement, or managers who shut conflict down, signals unhealthy culture. Caveat: like Schrödinger's cat, observation changes the outcome. Your presence alters behavior and may hide the very problem you're hunting, the way a log statement can make a concurrency bug vanish.
- **Ask questions.** Can the team state their goals and why those are the goals? If not, their leaders (manager, tech lead, product manager) aren't connecting them to purpose — and nearly every model of motivation requires connection to purpose. Probe the connection concretely: who are they building these systems for, and what is the potential impact on the customer, the business, the team? Did they have any part in choosing the goals and the projects to achieve them? If not, why not? A team spending all its time on engineering-sponsored projects while neglecting product work probably doesn't understand the product work's value, and so lacks motivation for it.
- **Check team dynamics.** Do people like each other, banter, collaborate? Are relations with adjacent teams and product managers good? People who never talk and work only on independent projects aren't really a team — fine if output were good, but it isn't.
- **Jump in to help.** Yes, the manager owns fixing the team — but just as you might help debug a complex outage without writing code daily, it's fine to help debug team issues, especially with a struggling manager. It teaches the manager, and can reveal foundational problems (like missing senior business leadership) that even great managers can't fix alone.
- **Be curious.** Repeatedly pursuing "why" builds your pattern library: which areas break first, which indicators matter. Without it you rely on charm and luck, and never learn from mistakes.

## Setting expectations and delivering on schedule

"Why is it taking so long?" gains new intensity at this level because you're no longer embedded in details. Ideally it's asked because something truly is far over plan; often it's asked when nothing is wrong, because leadership didn't like — or never requested — the original estimate.

- **Be aggressive about sharing estimates and updates, even unasked**, especially for critical projects or anything likely to exceed a few weeks. Be equally aggressive about *getting* estimates; negotiating how and when your teams estimate may now be part of your job.
- **Push past the "no estimates beyond a sprint" philosophy.** It rests on assumptions (estimates must be accurate, requirements always churn, work fits in sprints) that are rarely all true. Imperfect estimates still help escalate complexity to the rest of the organization. Up-front work can drastically reduce unknowns — and even granting that it sometimes makes the overall process slower than going sprint by sprint, businesses legitimately need cost forecasts. Estimation is also goal-setting and a way to teach teams to hone instincts about complexity. Experiment with methods, find what fits your company, and make it a habit.
- **Learn from misses, agile-style.** When estimates are wrong: what did we learn about hidden complexity, about what's worth estimating and when, about how we communicated and who was disappointed?
- **Define "long" yourself.** Provide your best view of the timescale and proactively update it when it changes — especially when it gets slower.
- **When blamed unfairly** (nothing is late, or delays were outside your control): there's no easy answer. It usually means someone is stressed or being pushed to deliver faster than you ever promised. Patiently restate that things are on schedule; blame under stress isn't rational. Empathy for the person under pressure, plus offers to help in other ways, shifts the focus from blame to action.
- **Cut scope near the end to hit important deadlines.** As the senior manager, play tiebreaker on which features are cuttable versus essential, and take the fall for cutting someone's favorite idea if the larger project requires it. Be smart about what you give up: if you sacrifice only technical quality, you'll slow the team down after launch — cut product features too, not just technical nice-to-haves.

## Challenging situations: roadmap uncertainty

Changing roadmaps hit every company: especially in smaller companies it's hard to get anyone to commit a year in advance, and even at big companies market shifts cause sudden strategy changes that abandon projects and cancel planned work. Changing product and business roadmaps are where middle management feels worst: you can't push back much on strategy from above, you sometimes must break promises you made to your team, and the team feels like cogs while you feel powerless. The secondary problem: product roadmaps never include technical debt, so engineering-focused work has no natural slot.

Strategies:

- **Be realistic about how likely plans are to change given your company's size and stage.** If your startup rewrites the year's plan every summer, expect that, and never promise the team anything requiring continuity past that point.
- **Break big projects into smaller deliverables** so you bank some results even if the grand vision dies. Work closely with product/business managers on prioritizing the pieces, and re-examine repeatedly for what's most valuable right now.
- **Don't overpromise a future of technical projects.** The "later" roadmap doesn't exist yet; promising exciting technical work later raises hopes and then disappoints. If a project is important, schedule it now or as close to now as possible. If it sits on the backlog, accept that "later" will arrive with a long list of competing priorities, and unarticulated value loses to clearly valuable work.
- **Dedicate 20% of every planning cycle to sustaining engineering**: refactoring, bug fixes, process improvements, minor cleanup, ongoing support. Twenty percent isn't enough for big rewrites — those need their own planning — but without it you get missed delivery goals and unplanned, unpleasant cleanup.
- **Subject technical projects to product-style rigor.** When an engineer pitches a project, ask: How big is it? How important? Can you articulate its value to anyone who asks? What would successful completion mean for the team? Big technical projects should have advocates, goals, and schedules like product initiatives. This is uncomfortable — sometimes you "know" something matters but can't yet say why in business terms; gather data and describe what becomes possible when the work is done. A project on a rarely changed system that enables no core improvement probably isn't worth it. There is never enough time for all the cleanup and exploration your team wants; this process picks your battles.

**When the change lands anyway** — and change can go beyond cancelled projects to teams being disbanded or moved around in ways you don't understand or agree with: help people tie up loose ends, stabilize in-flight work, and ease into the new projects in a controlled fashion — push back to get adequate wind-down time. Push for engineering involvement in early planning of the new work so people get excited about it. Understand the reasons for the change yourself; even if you disagree, make the reasons clear to the team. The calmer you are, and the better you can show (or fake) enthusiasm for the new direction, the easier the transition. Faced with waves, you can be pulled under or learn to surf.

## Staying technically relevant

First clarify what technical relevance is *for* at this level — your technical responsibilities:

- **Oversee technical investment.** Development time is finite; you're accountable for the team placing technical bets in the right places, matched to where the product and customers are heading. You see the whole portfolio; focus effort where need and opportunity are greatest.
- **Ask informed questions.** You don't personally find every technical project; you guide investment by asking. What surprises and bottlenecks have current projects uncovered? How is the team thinking about the future of its systems? Which teams want more engineers, and why? Which slow teams *don't* want more people? Why this project now? Know enough to sniff out misguided efforts.
- **Analyze and explain engineering/business tradeoffs.** Raise concerns when a feature is technically difficult or a technical idea has business implications; ensure engineers decide with business context; explain R&D uncertainty to nontechnical partners; advise which technical projects can hit goals in reasonable time frames.
- **Make specific requests.** Know enough about progress and bottlenecks to filter infeasible ideas and map new initiatives onto in-flight work without pestering senior engineers with basic questions.
- **Use experience as a gut check.** This is a highly technical job; it can't be done by someone who doesn't appreciate software tradeoffs. If your teams invest time poorly, it reflects on you. Don't neglect your technical instincts just because people and organizational problems keep you busy.

**Anti-pattern:** managers who lose technical grounding become go-betweens — relaying requests from senior management down and team responses back up. That is not a value-add role.

**How to invest your time:**

- **Read the code** occasionally — including code reviews and pull requests — to stay aware of what's really there and where things have gotten ugly.
- **Pick an unknown area and have an engineer teach it to you**: a couple of hours at a whiteboard or pairing on a small change.
- **Attend postmortems.** Outage debriefs reveal the development and deployment realities you miss when not coding daily — neglected standards, broken inter-team communication, tooling that hurts more than it helps. Failure shows where your attention is needed.
- **Keep up with industry trends in development processes** — building, testing, deploying, monitoring. Not every trend deserves pursuit, but learn how other teams deliver software so yours can keep evolving.
- **Foster a network of technical people outside your company.** Trusted peers give you the real experience behind the blog posts, talks, and sales pitches.
- **Never stop learning.** Read, watch talks, dig into curiosities even when they're irrelevant to your team, and ask your own team questions. Learning is a skill you practice.

## Assessing your own experience

- How often do you talk to your skip-level reports — one-on-one or in groups? How much time do you spend proactively seeking information versus passively handling what arrives? When did you last sit in on a team meeting?
- Without looking at existing documentation, write your own job description for the engineering managers reporting to you: what are they responsible for, how do you evaluate them, and which areas matter most for success?
- Compare that to the company's official description. Where do they differ, and what might you be overlooking when evaluating your managers?
- Do a quick mental performance review of each manager. What needs coaching and development? Cover it in your next 1-1.
- If you manage an area outside your technical comfort zone: how often do you check in? Have you learned from that manager what success in the role takes? What have you learned about that team in the past three months?
- If one team runs more smoothly than the others: what differs in its processes and interactions? What does its manager do differently, and how does that manager interact with the team and with you?
- What is your manager interview process? Do you probe personal values and management philosophy? Does the team interview their prospective manager? Do you check references?
- What are your organization's goals this quarter and this year? How are you merging product goals with technical goals? Does your organization have a mandate the teams understand?
