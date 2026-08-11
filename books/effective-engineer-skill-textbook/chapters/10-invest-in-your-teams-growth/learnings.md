# Chapter 10: Invest in Your Team's Growth

Your effectiveness is bounded by the strength of the team around you, so investing in your team — hiring, onboarding, shared code ownership, post-mortems, and culture — is among the highest-leverage work you can do, even as an individual contributor. The higher you rise on the engineering ladder, the more you are measured by your impact on others rather than by your personal output. Making the people around you succeed is the most reliable path to your own success.

## Core Principles

- **Help the people around you be successful.** Career success depends largely on your company and team succeeding, and that depends on more than your individual contributions. Yishan Wong's thought experiment: if you could wave a magic wand and make every single person in your company succeed at their job by 120%, the company would probably be a huge success and you would be swept along in that tide. Andy Rachleff makes the complementary point: you get more credit than you deserve at a successful company and less than you deserve at an unsuccessful one. So focus primarily on making everyone around you succeed.

- **Seniority is measured by impact on others.** Companies like Google and Facebook tie higher engineering levels to broader expected impact. Marc Hedlund's framing: a staff engineer makes a whole team better than it would otherwise be, a principal engineer makes the whole company better, and a distinguished engineer improves the industry. Building habits of helping co-workers succeed early in your career leads to your own advancement.

- **Hiring is extremely high-leverage in aggregate.** Individual interviews feel like poor time investments — they interrupt work and most don't yield hires — but a single strong hire contributes 2,000+ hours of output per year, dwarfing the interviewing cost. The smaller the company, the greater the leverage, because the candidate is more likely to be your immediate co-worker. Make hiring everyone's responsibility, not just recruiters' or managers'.

- **Onboarding quality is a powerful leverage point.** First impressions shape a new engineer's perception of the culture, her ability to deliver impact, and how her learning aligns with team priorities. Training a new engineer an hour or two a day in her first month generates more organizational impact than spending those hours on product work, and onboarding resources are a one-time investment that pays dividends with every additional hire. Poor onboarding loses output, degrades code quality, obscures whether struggling hires are bad hires or just under-trained, and stresses out good engineers. Ad hoc onboarding stops working as a team grows: the surface area of things to learn expands until a new hire can't tell what to learn first, different employees explain different subsets of concepts so useful information gets omitted among scattered explanations, an engineer may never learn a key abstraction because his starter projects touch only peripheral features, and unclear expectations leave a hire reading design documents or language guides instead of fixing bugs and building features. Ramping up others also pays you back personally: a stronger and larger team means easier code reviews, more people available to fix bugs, increased resources for on-call rotations and support, and greater opportunities to tackle more ambitious projects — more flexibility to choose higher-leverage activities.

- **Share ownership of code.** Being the sole expert on a system feels like job security but actually makes you a bottleneck: high-priority bugs route to you, you're the only line of defense in outages, and maintenance eats the time you'd use to learn and build new things. Shared ownership raises the bus factor above one, makes engineers fungible so anyone can step in for anyone, spreads unpleasant maintenance across the team, and frees you for higher-leverage work.

- **Optimize for collective learning.** Teams routinely move from project to project without reflecting on what worked. Post-mortems — on incidents and on projects and launches — convert individual experience into documented collective wisdom, so lessons aren't isolated in a few heads, costly mistakes aren't repeated, and knowledge doesn't leave when people do. The goal is never to assign blame; blame is counterproductive. Three frictions keep project post-mortems from happening: no clear goal or metric was defined upfront so success can't be assessed, teams don't want to publicly declare months of work a failure so it's tempting to close the discussion, and teams overwhelmed with new projects can't make time for reflection. Honest project conversations require acknowledging that months of effort may have resulted in failure and viewing that failure as an opportunity for growth. An uncomfortable hour-long honest conversation is high-leverage if it raises the odds that the next month-long project succeeds.

- **A great engineering culture compounds.** Culture is the set of values and habits shared by the team. A strong culture makes engineers empowered, happier, and more productive; improves retention; provides a shared framework for decisions; and attracts the best engineers — whose hiring further strengthens the culture in a positive feedback loop. Culture isn't built in a day; every engineer shapes it through decisions, stories, and habits.

## Key Concepts & Frameworks

- **Signal-to-noise ratio (interviews):** the amount of useful information about a candidate revealed per minute spent, versus irrelevant data. Optimize interview questions for high signal-to-noise; good questions let you confidently differentiate candidates of varying ability.

- **Two goals of a good interview process:** (1) screen for the type of people likely to succeed on the team; (2) get candidates excited about the team, mission, and culture — ideally even rejected candidates leave with a good impression and refer friends.

- **Layered interview problems:** problems with multiple difficulty levels you tailor by adding or removing variables and constraints (e.g., a search interface made harder by requiring distribution across machines, or easier by assuming size limits). Layered problems give finer-grained signal than binary ones the candidate either solves or doesn't.

- **Hands-on interviews:** practical exercises (debugging and extending a real codebase on a laptop, building end-to-end systems, refactoring, pair programming) that reveal whether an engineer gets things done — terminal fluency, navigating unfamiliar libraries, tight development loops, clean code — signals whiteboard algorithm questions miss. They cost more upfront to design but many teams find the payoff worth it.

- **Four goals of onboarding (Quora's framework):** (1) ramp up new engineers as quickly as possible; (2) impart the team's culture and values; (3) expose new engineers to the breadth of fundamentals needed to succeed; (4) socially integrate them onto the team.

- **Four pillars of Quora's onboarding program:** (1) codelabs — documents explaining why a core abstraction was designed, how it's used, walking through its internals, with exercises; (2) onboarding talks — ten talks by senior engineers in the first three weeks; (3) mentorship — a dedicated mentor per hire with daily check-ins the first week, then weekly 1:1s; (4) starter tasks — ship real code in week one.

- **Bus factor:** the number of key people who could be incapacitated before the team can no longer keep a project going. A bus factor of one means any absence — sickness, vacation, departure — hurts the team. Increase it above one through shared ownership.

- **Fungibility:** when no engineer is uniquely positioned to do one thing and any task can be done by multiple people (Nimrod Hoofien, Facebook). Fungibility gives more degrees of freedom, flexibility in development, and fewer on-call and support constraints.

- **Flight Rules (NASA):** a compendium built since the early 1960s capturing missteps, disasters, and solutions from 200+ space flights — extremely detailed, scenario-specific standard operating procedures with the rationale for each step. The model for building team playbooks: document what to do and why for recurring operational and project situations.

- **Five Whys (Toyota; used by Amazon and Asana):** repeatedly asking "why" (about five times) to move from a symptom to a root cause — e.g., site crash → overloaded servers → skewed traffic → one customer's data hosted only on those machines. Also usable to facilitate productive discussion of a project's success or failure.

- **Ten traits of great engineering cultures** (from 500+ interviews asking what engineers like/dislike about their culture): optimize for iteration speed; push relentlessly toward automation; build the right software abstractions; focus on high code quality via code reviews; maintain a respectful work environment; build shared ownership of code; invest in automated testing; allot experimentation time (20% time or hackathons); foster learning and continuous improvement; hire the best.

## Actionable Practices

Interviewing and hiring:
- Treat interviewing as a core responsibility, not an interruption; evaluate its value in aggregate, not per interview.
- With your team, identify which qualities matter most (coding aptitude, algorithms, product skills, debugging, communication, culture fit) and coordinate so an interview loop covers all key areas.
- Periodically meet to assess whether the interview process actually predicts success on the team; keep iterating.
- Design layered problems with multiple difficulty levels rather than binary pass/fail questions.
- Control interview pace: don't let candidates ramble, stay stumped, or get sidetracked — give hints or move on to preserve signal.
- Fire rapid short-answer questions (e.g., how parameter passing works in a language, how a core library works) to scan a wide surface area for red flags in seconds.
- Shadow or pair with teammates during interviews to calibrate ratings and exchange feedback.
- Use unconventional approaches when they surface signals you care about — Airbnb devotes at least two interviews to culture fit.
- Draw on existing literature to get started designing questions (e.g., Gayle Laakmann McDowell's *Cracking the Code Interview*, covering standard patterns at larger tech companies) — but beware that interviewees have access to the same question banks.
- Make interviews both fun and rigorous so even rejected candidates leave impressed.

Onboarding:
- Define onboarding goals first, then build mechanisms to achieve them (fast ramp-up, culture transmission, fundamentals, social integration).
- Write codelabs for core abstractions: why it was designed, how it's used, code walkthroughs, exercises. Build the first one as a model, then recruit teammates to scale the effort. The cost is mostly an upfront, one-time investment in reusable resources, plus a small recurring cost of updating stale materials.
- Run onboarding talks by senior engineers covering the codebase, architecture, dev tools, engineering values (e.g., expectations around unit testing), and the team's key focus areas; schedule the most critical (like "Introduction to the Codebase") for every hire, batch the rest.
- Pair every new hire with a mentor — because each hire's background is different, onboarding can't be one-size-fits-all. Mentors do daily check-ins the first week, then weekly 1:1s. Mentors review code, discuss design tradeoffs, plan priorities, and make introductions. Hold mentoring workshops and meetings so mentors exchange tips and improve.
- Explicitly tell mentees that ramping them up outranks the mentor's other work, and seat mentees next to mentors.
- Have new hires push a commit on day one (e.g., adding themselves to the team page) and ship a starter task — a bug fix, small feature, or experiment — by the end of week one. Reduce environment-setup friction so a change can be made, tested, committed, and deployed on day one. The aggressive week-one target is deliberate: it conveys the team's value of getting things done and moving fast, and it forces the team to remove enough onboarding friction that new hires build momentum quickly.
- Pick starter tasks from the mentor's own list, sized so the mentor could finish in a day — leaving margin for the hire to still ship in week one.
- Iterate: survey new hires and mentors, note where people struggle, list what you wish you'd learned earlier, implement the most valuable ideas, and repeat. Start minimal — maybe just a document on setting up a development environment so a new engineer can write code on day one — then escalate on triggers: articulate guiding principles for picking good starter projects once you notice not all provide equal ramp-up benefit, and when you catch yourself giving the same codebase or architecture walkthrough repeatedly, turn it into a prepared talk or recorded video. Anyone at any seniority can contribute — recent hires give the freshest feedback and can update wikis directly.

Sharing ownership:
- Avoid one-person teams.
- Review each other's code and software designs.
- Rotate tasks and responsibilities (including on-call) across the team.
- Keep code readable and quality high.
- Give tech talks on software decisions and architecture.
- Document software in design docs or code comments, and document complex workflows and non-obvious workarounds.
- Invest time teaching and mentoring teammates.
- Remove yourself from the critical path to free yourself for growth.

Collective wisdom:
- Hold blameless post-mortems after outages and high-priority bugs: write up what happened, how and why, and how to prevent it; if not preventable, build recovery tools or step-by-step guides. Share write-ups across teams.
- Extend post-mortems to projects and launches, not just incidents: define clear goals or metrics upfront so success can be assessed, then debrief against them.
- Compile step-by-step operational playbooks in the style of NASA's Flight Rules (e.g., how to fail over a database, which scripts to run under traffic overload) and project-level lessons (overtime outcomes, past A/B test hypotheses and results).
- Use Five Whys to reach root causes instead of stopping at symptoms.
- Start small with your immediate team's projects, then gradually establish post-mortems for larger projects.

## Key Takeaways

- Help the people around you be successful: the top rungs of the engineering ladder go to those who make co-workers more effective, and others' success carries you along.
- Make hiring a priority: keep a high bar and play an active role in growing the team.
- Invest in onboarding and mentoring: the faster new members ramp up, the more effective the team — and the more freedom you gain to tackle other projects.
- Build shared ownership of code: push the bus factor above one so you're not a bottleneck, freeing you for higher-leverage work.
- Debrief and document collective wisdom: reflect on projects, learn what did and didn't work, and share the lessons so they aren't lost.
- Create a great engineering culture: it boosts productivity, streamlines decisions, and attracts strong engineers, and it grows from the same habits that make you effective.
