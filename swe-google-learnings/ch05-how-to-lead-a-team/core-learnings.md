# Chapter 5: How to Lead a Team

*From "Software Engineering at Google" (written by Brian Fitzpatrick, edited by Riona MacNamara)*

## Chapter Thesis

Every software team needs a leader, but leading a team is a fundamentally different job from being a software engineer, and the skills that make a great engineer do not automatically make a great leader. The chapter argues that the best leaders reject the traditional command-and-control notion of "managing" and instead practice servant leadership: serving their team, removing obstacles, building an atmosphere of humility, respect, and trust, and worrying about *what* gets done while trusting the team to figure out *how*. It lays out the leadership roles Google uses (engineering manager, tech lead, and tech lead manager), catalogs the antipatterns that destroy teams, describes the positive patterns that great leaders share, and closes with a model of motivation built on autonomy, mastery, and purpose.

## Core Principles and Ideas

### The two leadership roles (and the hybrid)

Google recognizes two distinct leadership roles because they require very different people skills even though both require similar planning skills:

- **Engineering Manager**: a leader of *people*. Responsible for the performance, productivity, and happiness of every person on the team (including the tech lead) while making sure the business needs of the product are met. Because business needs and individual needs do not always align, the manager often sits in a difficult position. Google deliberately requires its engineering managers to have an engineering background, either by hiring former software engineers as managers or by training engineers to become managers.
- **Tech Lead (TL)**: a leader of *technology*. Responsible for the technical aspects of the product: technology choices, architecture, priorities, velocity, and general project management. The TL usually reports to the engineering manager and works with them on staffing and matching engineers to tasks. Most TLs are also individual contributors, which forces a recurring choice: do a task quickly themselves or delegate it to a team member who may do it more slowly. Delegating is usually the correct choice because it grows the team's size and capability.
- **Tech Lead Manager (TLM)**: a single person who fills both roles at once. Common on small or new teams that need a manager with strong technical skills. The TLM role is tricky because it demands balancing individual work, delegation, and people management, so new TLMs should seek out senior mentors. On larger, established teams Google prefers a *pair* of leaders (one TL, one engineering manager) because doing both jobs well at the same time is a recipe for burnout.

### Influence without authority

One of the most powerful leadership traits is the ability to get people who do not report to you to do work you believe needs to be done. The way to do it: identify a strategic need for the company, show how it links to the company's mission and existing priorities, and build tools that make it easy for others to join the effort. (See the Jeff Dean and Data Liberation Front examples in examples.md.)

### Why engineers resist becoming leaders, and why they should consider it

Common fears:
- **You write much less code.** True for both TLs and managers.
- **The "I didn't do anything today" feeling.** An engineer ends the day with visible output (code, a design doc, closed bugs). A manager's output is harder to quantify. The book's metaphor: after switching from picking apples to growing bananas, do not lament "I didn't pick any apples today" while ignoring the flourishing banana trees. Making the team happy and productive *is* the output, and management work typically pays off over a longer timeline.
- **The Peter Principle**: "In a hierarchy every employee tends to rise to his level of incompetence." Google mitigates this by requiring people to already be performing above their current level (rated "exceeds expectations") before promoting them to that level.
- **Bad-manager scar tissue.** Many people have only ever worked for bad managers and therefore want nothing to do with the role.

Reasons to lead anyway:
- **Leadership scales you.** There is an upper limit to the code one person can write; a team of great engineers under your leadership can accomplish far more.
- **You might be genuinely good at it.** Many people pulled into a project's "leadership vacuum" discover they excel at providing guidance, help, and air cover. Someone has to lead.

A related warning for organizations: never force a great engineer who has no desire to manage into a management or TL role. You lose a great engineer and gain a bad manager, which is actively harmful. Effective organizations offer productive career paths for both individual contributors and people managers.

### Servant leadership: the central mental model

New managers catch a "disease": they forget the awful things their own managers did and start doing the same things to their reports (micromanaging, ignoring low performers, hiring pushovers). The best advice for a new manager: **"Above all, resist the urge to manage."**

The cure is **servant leadership**: the most important thing you can do as a leader is *serve* your team, like a butler tending to the health and well-being of a household. Concretely, that means:
- creating an atmosphere of humility, respect, and trust
- removing bureaucratic obstacles team members cannot remove themselves
- helping the team reach consensus
- filling in the cracks to smooth the way, while not being afraid to get your hands dirty

The only "managing" a servant leader does is managing the team's technical *and* social health. The social health of the team matters just as much as the technical health and is usually far harder to manage.

### The manager as a historical anachronism

The pointy-haired-boss concept of a manager is a carryover from military hierarchy and the Industrial Revolution, when unskilled and easily replaceable factory workers needed supervisors and motivation came from the **carrot and stick** (reward and punishment). That model survived into the modern office, but it is ineffective and harmful for creative work. Unlike an assembly-line worker who can be trained in days and replaced at will, a software engineer working on a large codebase can take months to get up to speed and needs nurturing, time, and space to think and create.

The single most important line of the chapter:

> Traditional managers worry about *how* to get things done, whereas great managers worry about *what* things get done (and trust their team to figure out how to do it).

Trust is self-reinforcing: if a manager makes it obvious they trust an employee, the employee feels positive pressure to live up to that trust. Managers who act like parents get employees who act like children. If your employees genuinely need babysitting to be convinced to work, *that* is your real problem.

### Psychological safety and failure

**Psychological safety** means team members feel they can be themselves without fear of negative repercussions from the leader or from each other. It is the foundation for risk taking. Most humans are terrible at evaluating risk and most companies avoid risk at all costs, so teams default to conservative work and small successes even when a bigger risk could produce exponentially greater success. A Google saying: if you try to achieve an impossible goal and fail, you will most likely accomplish far more than if you had attempted something you knew you could complete.

Rules for failure:
- It is OK to fail. Failure is a way of learning a lot really quickly, provided you are not repeatedly failing at the same thing.
- Failing fast is good because little is at stake. Failing slowly is more painful because more engineering time is lost. Failing in a way that affects customers is the least desirable failure, but it is the one with the most structure for learning.
- After every major production failure Google performs a **postmortem**: a document recording the events that led to the failure and a series of steps to prevent recurrence. A postmortem must not point fingers or assign blame, and must not introduce needless bureaucratic checks; its goal is to fix the core problem once and for all.
- Fail *as a team* and learn together. Praise individual success in front of the team; give constructive criticism for individual failure in private. Public criticism of an individual is ineffective (it triggers defensiveness), rarely necessary, and usually just cruel; the team already knows when someone failed.

### Antipatterns: what not to do

1. **Hire pushovers.** An insecure manager hires people they can push around (less smart, less ambitious, or more insecure than themselves) to cement their authority. The result: a team that cannot move without the leader, no possibility of vacation, and productivity that halts the moment the leader leaves the room. Instead, hire people smarter than you who could replace you. They will challenge you and point out your mistakes, but they will also direct themselves, make great things happen, and free you to grow.

2. **Ignore low performers.** "Hope is not a strategy" (the motto of Google's Site Reliability Engineering team) and nowhere is hope more overused than with a low performer. While the leader hopes the problem fixes itself, high performers waste time carrying the low performer, morale leaks away, high performers leave, new high performers refuse to join, and eventually the team consists only of people who cannot leave. Keeping a struggling person on the team also does *them* no favors; they might have real impact elsewhere. Deal with low performance immediately so you can help the person **up or out**.

3. **Ignore human issues.** A manager has two areas of focus: the social and the technical. Managers promoted from technical roles tend to over-invest in the technical side and ignore the human side at their peril. A little empathy in personal situations goes a very long way (see the Jake/Pablo example in examples.md).

4. **Be everyone's friend.** New leads promoted from within a team often work hard to preserve friendships with former peers. Do not confuse friendship with leading with a soft touch; when you hold power over someone's career they may feel pressure to artificially reciprocate friendship. You can lead and build consensus without being either a close friend or a hard-ass. Lunch with the team is a good way to stay socially connected without discomfort. Avoid managing a close friend who is not self-managing if at all possible.

5. **Compromise the hiring bar.** Steve Jobs: "A people hire other A people; B people hire C people." The tempting shortcut, hiring the best 5 of 50 applicants regardless of whether they actually meet the bar, is one of the fastest ways to build a mediocre team. The cost of finding the right person is trivial next to the cost of a bad hire: lost productivity, team stress, time managing the person up or out, and the pain of firing. If you have no say over hiring and keep receiving substandard engineers, fight hard for better ones or consider leaving; without the raw materials for a great team you are doomed.

6. **Treat your team like children.** People tend to act the way you treat them. Micromanaging and disrespecting people's abilities signals distrust; if you *permanently* need to micromanage people, you have a hiring failure. Trust extends to mundane things: Google leaves office supplies and self-service "Tech Stop" electronics freely available because trusting employees to check items out makes them feel responsible, and the cost of a few "stolen" pens is far less than the cost of a workforce that behaves like children or wastes time formally requesting cheap supplies.

### Positive patterns: what great leaders do

1. **Lose the ego.** Humility is not lacking confidence and it is not being a doormat; you can hold opinions and self-confidence without being an egomaniac. Cultivate a strong *collective team* ego and identity instead of a personal one. Trust the team: the people in the trenches know the details better than you, so let them decide the nuts and bolts, which gives them ownership and accountability. Do not pretend to know everything or have all the answers; the team can smell insecurity a mile away. Encourage inquiry, treat questions about your decisions as attempts to understand you, and accept constructive criticism openly. Finally, **apologize sincerely when you make a mistake**. Your team will know you screwed up whether or not you admit it. Apologizing costs nothing, does not make you vulnerable, and earns enormous respect because it signals level-headedness, good judgment, and humility.

2. **Be a Zen master.** Mediate your reactions and maintain calm, because the team consciously and unconsciously mirrors the leader. The **gears metaphor**: the org chart is a chain of gears with the individual contributor as a tiny gear and the CEO as a huge one; a small movement high up sends the small gears at the bottom spinning wildly, whether intended or not. The **leader is always on stage**: peers read your body language, reactions, and mood constantly, and your visible attitude about everything spreads infectiously to the team. The second Zen trick: when someone asks for advice, resist leaping into solution mode. **Ask questions** to help the person refine and explore the problem so they reach *their own* answer, which preserves their ownership and responsibility. (Related idea: rubber duck debugging.)

3. **Be a catalyst.** In chemistry a catalyst accelerates a reaction without being consumed, often by bringing reactants together. A leader's version is **building consensus**: sometimes driving the process end to end, sometimes just nudging it. Consensus building works even without formal authority, which is why unofficial leaders rely on it. With authority you *can* dictate, but dictating is less effective than consensus. Caveat: chasing 100% consensus is also harmful; a leader must be able to proceed even when not everyone agrees or some uncertainty remains.

4. **Remove roadblocks.** When the team agrees on direction but is stuck on a technical or organizational obstacle, jump in. Many roadblocks that are nearly impossible for team members are easy for a leader, usually because the leader knows the right person. You do not need to know all the answers; **knowing the right person is often more valuable than knowing the right answer**.

5. **Be a teacher and a mentor.** One of the hardest things for a TL is watching a junior engineer spend 3 hours on something the TL could do in 20 minutes, but letting people learn is vital to scaling the team. A mentor needs three things: experience with the team's processes and systems, the ability to explain things, and the ability to gauge how much help the mentee needs. The last is the most important; overexplaining makes mentees tune out.

6. **Set clear goals.** Obvious but widely ignored. The **truck metaphor**: every team member holds a rope tied to the front of the product-truck and pulls in their own direction; without a shared direction, energy cancels out. Set clear priorities and help the team decide how to make trade-offs. The easiest mechanism is a **concise team mission statement**; after the direction is defined, step back, grant autonomy, and check in periodically. Teams can succeed without clear goals but waste enormous energy doing so.

7. **Be honest.** Promise the team: "I won't lie to you, but I will tell you when I can't tell you something or if I just don't know." Saying "I know but can't share" or "I don't know" is fine; it proves only that you are human, not weak. For hard feedback, **avoid the compliment sandwich** (praise, criticism, praise): it softens the blow so much that most people never hear that something must change. Deliver criticism directly but with kindness and empathy, because a defensive recipient thinks about how to argue with you rather than how to change. (See the Tim and Dean examples in examples.md.)

8. **Track happiness.** The best leaders are amateur psychologists: they check on team members' welfare, ensure recognition, and spread grungy thankless tasks evenly. A simple technique: end every one-on-one meeting by asking **"What do you need?"**; over time team members come prepared with what would make them more productive and happy. Pay attention to life outside the office too (one colleague opens one-on-ones with a happiness rating from 1 to 10 that covers work and life). Unrealistic expectations about time commitment cause lost respect and burnout; cutting slack to someone having a rough time at home earns willingness to push hard later. **Track careers**: most people privately want the same four things (get promoted, learn something new, launch something important, work with smart people), so make those implicit goals explicit and evaluate opportunities against them.

### People Are Like Plants: motivation and direction

Like children in a family or plants in a garden (a cactus needs sun and little water, an African violet needs diffuse light and moist soil, a tomato thrives on fertilizer), team members need *different* things. Giving everyone identical treatment guarantees that almost no one gets what they actually need. The leader's job is to determine, per person, the right mix of **motivation** and **direction**:

- People in a rut need motivation.
- People who are distracted or uncertain need stronger direction.
- People who are adrift need both.
- People who need neither will just be annoyed if you supply them anyway.

Direction is straightforward: understand what needs to be done, organize it, and break it into manageable tasks. Motivation is subtler.

### Intrinsic versus extrinsic motivation

- **Extrinsic motivation** originates from outside forces, such as money.
- **Intrinsic motivation** comes from within.

Drawing on Dan Pink's book *Drive*: piling on extrinsic rewards does not make people happiest and most productive; increasing intrinsic motivation does. Intrinsic motivation grows from three things (assuming pay is already good enough that income is not a source of stress):

1. **Autonomy**: the ability to act without being micromanaged. Give autonomous engineers the general direction and let them decide how to get there. This deepens their relationship with the product and their sense of ownership; the bigger their stake, the greater their interest in its success.
2. **Mastery**: the opportunity to improve existing skills and learn new ones. Skills are like a knife blade: you can pay dearly to hire the sharpest people, but years of use without sharpening leaves a dull, inefficient knife. Opportunities for mastery keep people motivated and make the team stronger over time.
3. **Purpose**: a reason for the work. Many people are kept at arm's length from the positive effects of their products. Find the reason for the team's efforts and make it explicit. One Google manager forwards customer emails praising her (small-impact) product straight to the engineering team; this motivates them and inspires product improvements.

## Actionable Guidance

- Resist the urge to "manage." Serve the team instead: clear obstacles, build consensus, manage social as well as technical health.
- Worry about *what* gets done; trust the team to decide *how*.
- Hire people smarter than you who could replace you. Never lower the hiring bar to fill seats.
- Deal with low performers immediately. Concretely: set a specific time frame (about two months) with small, incremental, measurable goals; meet weekly to check progress; set explicit expectations for each milestone. The person will either quit once the gap is obvious to both of you or rise to meet expectations; either way you catalyzed a necessary change. Temporary micromanagement plus lots of humility, respect, and especially respect.
- Treat failure as fast learning. Run blameless postmortems for significant failures. Praise publicly, criticize privately.
- Apologize sincerely when you screw up.
- Stay calm; the team mirrors you and amplifies your reactions.
- Answer requests for advice with questions so the asker owns the solution.
- Give the team a concise mission statement, then step back and check in periodically.
- Skip the compliment sandwich. Be direct, kind, and empathetic so the message lands without triggering defensiveness.
- End every one-on-one with "What do you need?" Track each person's career goals explicitly.
- Delegate, but get your hands dirty: new leads must force themselves to delegate; veteran leads should pick up a grungy task nobody wants, because nothing earns a team's respect like humble hard work.
- Seek to replace yourself: hire people capable of doing your job, then give them chances to take on responsibility or lead. Remember some people prefer to remain high-performing individual contributors, and that is OK.
- Know when to make waves: the problems your instincts tell you to sit on (the under-skilled engineer, the person who fights every decision, the unmotivated 30-hour employee) almost never fix themselves. Act quickly; waiting only compounds the damage.
- Shield your team from chaos: the world outside the team is full of uncertainty and organizational insanity that individual contributors never see when they are well led.
- Give your team air cover: share as much information as you can, but do not distract them with organizational craziness that is unlikely to ever affect them.
- Let people know when they do well, not just when they screw up; celebrate the big wins publicly.
- Say "yes" to things that are easy to undo (a two-day experiment with a new tool); reserve scrutiny for hard-to-undo commitments (a product you must support for 10 years). More things are undoable than you think, both technical and nontechnical.
- Calibrate motivation and direction per person, like watering different plants differently.
- Build intrinsic motivation through autonomy, mastery, and purpose.

## The Chapter's Own TL;DRs

- Don't "manage" in the traditional sense; focus on leadership, influence, and serving your team.
- Delegate where possible; don't DIY (Do It Yourself).
- Pay particular attention to the focus, direction, and velocity of your team.
