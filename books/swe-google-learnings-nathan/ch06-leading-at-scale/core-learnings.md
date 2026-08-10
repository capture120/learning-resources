# Chapter 6: Leading at Scale

*From "Software Engineering at Google" (written by Ben Collins-Sussman). This chapter continues from Chapter 5 ("How to Lead a Team"), which covered moving from individual contributor to team leader. Chapter 6 covers the next step: leading a team of teams.*

## Chapter Thesis

As you move from leading one team to leading a set of related teams, all the servant-leadership basics still apply, but the scope of your problems becomes larger and more abstract. You are forced to go "broad" rather than "deep": you lose touch with technical details, your prior engineering expertise matters less, and your effectiveness comes to depend on general technical intuition and your ability to galvanize engineers to move in good directions. This transition is frustrating and often demoralizing — until you notice you are having far more impact as a leader than you ever did as an individual contributor. The chapter organizes leadership at scale around "the three Always of leadership": **Always Be Deciding** (ambiguous problems are about iterating on trade-offs, not finding perfect answers), **Always Be Leaving** (build an organization that solves the problem without you), and **Always Be Scaling** (success brings more responsibility, so you must defensively protect your time, attention, and energy).

## Core Principles and Mental Models

### The nature of the job at this level

- A leader of teams guides people toward solving difficult, **ambiguous problems** — problems with no obvious solution that might even be unsolvable, and that must be explored, navigated, and wrestled into a controlled state.
- The forest metaphor: if writing code is chopping down trees, the leader's job is to "see the forest through the trees" — find a workable path through the forest and direct engineers toward the important trees.
- Effective leadership at this level is more about organizing people than being a technical wizard.

### Always Be Deciding

Managing a team of teams means making ever more decisions at ever-higher levels, mostly about finding the correct set of trade-offs. The process has three steps:

1. **Identify the Blinders.** People who have wrestled with a problem for years wear "blinders": unexamined assumptions, "this is how we've always done it" thinking, and coping mechanisms or rationalizations that justify the status quo. A leader with fresh eyes can see the blinders, ask questions, and consider new strategies. (Unfamiliarity with a problem is not required for good leadership, but it is often an advantage.)
2. **Identify the Key Trade-Offs.** Important, ambiguous problems have no "silver bullet" solution that works forever in all situations. There is only the best answer *for the moment*, and it always involves trade-offs. The leader's job is to call out the trade-offs, explain them to everyone, and help decide how to balance them.
3. **Decide, Then Iterate.** Once you understand the trade-offs, make the best decision *for this particular month*, then reevaluate and rebalance next month. If you do not frame the process as continuous rebalancing, teams fall into searching for the perfect solution — "analysis paralysis." Lower the stakes by saying: "We're going to try this decision and see how it goes. Next month we can undo the change or make a different decision." This keeps people flexible and learning from their choices.

Key supporting model: the **Good / Fast / Cheap — pick two** trade-off triangle. In the Web Search case study these map to Quality, Latency, and serving Capacity: improving any one trait deliberately harms at least one of the other two.

### Always Be Leaving

The phrase comes from Bharat Mediratta, a former Google engineering director. It means: your job is not just to solve an ambiguous problem, but to get your organization to solve it *by itself, without you present*. Then you are free to move on to a new problem, leaving a trail of self-sufficient success behind you.

- The antipattern is making yourself a **single point of failure (SPOF)**. The related term is the **bus factor**: the number of people who need to get hit by a bus before the project is completely doomed.
- Litmus tests for being an SPOF: If you disappeared, would your team keep succeeding? On your last week-long vacation, did you keep checking work email? If things fall apart when you stop paying attention, you are an SPOF and need to fix it.
- Your mission is a **"self-driving" team**: an organization with a strong set of leaders, healthy engineering processes, and a positive, self-perpetuating culture that persists over time. Building it has three parts:

1. **Dividing the problem space.** Challenging problems are composed of difficult subproblems; the obvious move is one team per subproblem. But subproblems change over time, and rigid team boundaries cannot adapt. Prefer a looser structure in which subteams can change size, individuals can migrate between subteams, and assigned problems can morph. Walk the line between "too rigid" (no adaptability) and "too vague" (no clear sense of problem, purpose, and steady accomplishment).
2. **Delegating subproblems to leaders.** Delegation is the main mechanism for building self-sufficient leaders: give them an assignment, let them fail, and have them try again and again — "failing fast and iterating" applies to human learning, not just engineering design. Delegation fights your instincts for efficiency ("if you want something done right, do it yourself"), which is exactly why it is hard.
3. **Adjusting and iterating.** Once the machine is self-sustaining, direct it with a gentle touch. Good management is **95% observation and listening, and 5% making critical adjustments in just the right place** (the "chalk mark" wisdom — see the Master and the chalk mark parable). Micromanaging turns you back into an SPOF; "Always Be Leaving" is a call to **macromanagement**.

Two critical daily questions:
- Before doing a task yourself: **"Am I really the only one who can do this work?"** If not, delegate it — even if the other person will take much longer — because otherwise you fail to train your leaders and you stay in the critical path.
- Each day: **"What can I do that nobody else on my team can do?"** Good answers include protecting teams from organizational politics, giving encouragement, ensuring a culture of humility, trust, and respect, and "managing up" (keeping your management chain informed and connected). The most common and important answer is defining high-level strategy — a blueprint for both technical direction and organizational structure. You continuously map the forest and assign the tree-cutting to others.

**Anchor team identity to a problem, not a product.** A product is a solution to a problem; solutions have short life expectancies and get replaced. A well-chosen problem is evergreen. A team whose identity is a specific solution ("we are the team that manages the Git repositories") will dig in, defend the solution, and resist change even when change is best for the organization — the solution has become part of the team's self-worth. A team that owns the problem ("we are the team that provides version control to the company") is free to experiment with different solutions over time.

### Always Be Scaling

This section treats scaling **defensively and personally**, not offensively: your most precious resource is your limited pool of **time, attention, and energy**. If you grow your teams' responsibilities without protecting your personal sanity, the scaling is doomed.

**The Cycle of Success** — the standard pattern when a team tackles a hard problem:
1. **Analysis** — receive the problem, identify the blinders, find the trade-offs, build consensus on managing them.
2. **Struggle** — start the work before the team feels ready; expect failures, retries, iteration; herd cats; encourage leaders and experts to form opinions, listen carefully, and devise a strategy even if you have to "fake it" at first. (Against imposter syndrome: pretend some expert knows exactly what to do and is on vacation, and you are temporarily subbing in — it removes personal stakes and gives you permission to fail and learn.)
3. **Traction** — the team figures things out, real progress happens, morale improves, the organization starts driving itself.
4. **Reward** — the reward for success is *more work and more responsibility*: a new, equally difficult, usually adjacent problem — typically with no additional people.

That forces the **compression stage**: managing the original problem with half the people in half the time so the other half can tackle the new work. The cycle is really a **spiral**: over months and years the organization scales by tackling new problems and compressing them to take on parallel struggles. Hiring rarely keeps pace. Compressing a problem means both maximizing team efficiency and scaling your own time and attention to the new breadth of responsibility. (Google founder Larry Page would call this spiral "uncomfortably exciting.")

**Important Versus Urgent.** As an individual contributor, work is proactive and methodical. As a leader, work becomes reactive firefighting — you are the "finally" clause in a long list of code blocks, and email, chat, and meetings feel like a Denial-of-Service attack on your time and attention. Eisenhower's 1954 formulation (popularized by management author Stephen Covey): "I have two kinds of problems, the urgent and the important. The urgent are not important, and the important are never urgent." Slipping into pure reactive mode happens almost automatically; then you spend every moment on urgent things that almost never matter in the big picture. Strategy is incredibly important but almost never urgent.

**Learn to Drop Balls.** Dropping some balls is inevitable, so drop them *deliberately* rather than accidentally. Apply Marie Kondo's decluttering philosophy (from "The Life-Changing Magic of Tidying Up") to your task pile: roughly the bottom 20% is neither urgent nor important (easy to ignore), the middle 60% is a mixed bag, and the top 20% is critically important. The true work is identifying the **top 20% that only you can do** and focusing strictly on it — not tossing the bottom 20% and staying overwhelmed by the rest. Give yourself explicit permission to drop the other 80%. Two things then happen: subleaders often notice and pick up the middle 60% automatically, and anything truly critical in that middle bucket comes back to you and migrates into the top 20%.

**Protecting Your Energy.** Stamina builds naturally over a career (like marathon training), but leaders must also learn deliberate energy management: constant awareness of current energy level plus deliberate choices to recharge at specific moments in specific ways.

## Actionable Guidance

- Frame every big decision as "the best trade-off for this month," and tell the team the decision can be undone or changed next month — this prevents analysis paralysis.
- When entering a long-standing problem, actively hunt for the blinders: unquestioned assumptions and rationalizations around the status quo.
- Make hidden trade-off dimensions explicit first-class goals with metrics (as Google did by measuring exactly how much latency hurt user engagement, enabling quantitative launch decisions).
- Assign teams to own problems, never specific solutions or products.
- Split big problems into teams addressing **causes** and teams addressing **symptoms** in parallel (as with Search latency).
- Before fixing something yourself, ask "Am I really the only one who can do this?" Unless the task is truly time sensitive and on fire, assign it to someone who can do it, even if slower, and coach them.
- Each day ask "What can I do that nobody else on my team can do?" and spend your time there: strategy, politics shielding, culture, managing up.
- Manage by watching and listening most of the week, then make one small precise adjustment — 95% observation, 5% critical adjustment. Listen to your leaders, your skip-reports (the people who report to your direct reports), and your customers — for infrastructure teams, the customers are coworkers, and their happiness needs just as much intense listening.
- Techniques for staying on important rather than urgent work:
  - **Delegate** urgent items back to other leaders — it trains them and frees you.
  - **Schedule dedicated time**: regularly block two or more hours for important-but-not-urgent work (team strategy, career paths for your leaders, cross-team collaboration plans).
  - **Find a tracking system that works for you**: software to-do tools, the pen-and-paper Bullet Journal method, or David Allen's "Getting Things Done" — try systems until one clicks; anything beats Post-It notes on your monitor.
- Deliberately drop the bottom 80% of your task pile and work only the top 20% that only you can do.
- Energy management practices:
  - **Take real vacations** — at least a week; it takes three-plus days just to forget work; checking work email or chat ruins the recharge entirely. This is only possible with a self-driving organization, and you should plan around the assumption that your work will not get done while you are away.
  - **Make it trivial to disconnect** — leave the work laptop at the office; remove work apps from your phone or put them in a disableable "work profile" so one button grays them all out.
  - **Take real weekends** — sign out Friday night, back in Monday morning.
  - **Take breaks during the day** — the brain runs in natural 90-minute cycles (the basic rest-activity cycle); a 10-minute walk is a tiny recharge that meaningfully lowers stress for the next two hours.
  - **Give yourself permission to take a mental health day** — a leader's bad mood sets the tone for everyone and causes damage (regrettable emails, overly harsh judgments); better to get nothing done than to do active damage.
- Useful vocabulary: a "code yellow" is Google's term for an emergency hackathon in which affected teams suspend all work and focus 100% on a critical problem until the emergency is declared over.

## Chapter TL;DRs (verbatim)

- Always Be Deciding: Ambiguous problems have no magic answer; they're all about finding the right trade-offs of the moment, and iterating.
- Always Be Leaving: Your job, as a leader, is to build an organization that automatically solves a class of ambiguous problems—over time—without you needing to be present.
- Always Be Scaling: Success generates more responsibility over time, and you must proactively manage the scaling of this work in order to protect your scarce resources of personal time, attention, and energy.
