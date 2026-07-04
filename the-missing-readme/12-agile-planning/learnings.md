# Chapter 12: Agile Planning

Software development should be planned and tracked: teammates need to know what you're working on to collaborate, and teams need to track progress to plan future work and course-correct as new information surfaces. Without a deliberate process, projects drag on, outside demands steal focus, and operational issues distract developers. Agile development — especially Scrum, the most common framework — provides lightweight rituals (sprint planning, stand-ups, reviews, retrospectives) that deliver quality software quickly, as long as you treat the process as a means to an end rather than dogma.

## Core Concepts

### The Agile Manifesto

Agile was born in 2001 from a collaboration between leaders of earlier methodologies such as Extreme Programming, Scrum, Feature-Driven Development, and Pragmatic Programming. The Agile Manifesto (agilemanifesto.org) states four value pairs:

- **Individuals and interactions** over processes and tools
- **Working software** over comprehensive documentation
- **Customer collaboration** over contract negotiation
- **Responding to change** over following a plan

The items on the right have value, but the items on the left are valued more. The manifesto's core points: collaborate with teammates and customers; recognize, accept, and incorporate change; favor iterative improvement over big-bang releases. Agile is usually contrasted with Waterfall, an out-of-fashion practice where projects are exhaustively planned at inception.

Ironically, once Agile became popular, certifications, "black-belt ninjas," and process consultants overran some organizations. Obsessing over the "right" way to "do Agile" violates the very first principle — individuals and interactions over processes and tools.

### Agile Planning Frameworks: Scrum and Kanban

**Scrum**, the most popular framework, uses short iterations with frequent checkpoints to adjust plans. Work is broken into *sprints* (length varies; two weeks is most common). Each sprint starts with a *sprint planning* meeting that divvies up work captured as user stories or tasks. Progress is tracked in a ticketing or issue system. A brief daily *stand-up* shares updates and surfaces problems. After each sprint, the team holds a *retrospective* to review finished work, discuss new findings, look at key metrics, and fine-tune the process. Retros feed the next planning session, creating a feedback cycle: plan → development → retrospective → plan.

**Kanban** has no fixed-length sprints. It defines workflow stages all work items transition through (for example: backlog, planning, implementation, testing, deployment, rollout); teams customize stages to fit their needs. Kanban limits *work in progress (WIP)* by capping the number of tasks per stage, forcing teams to finish existing tasks before taking on new ones. Kanban boards are dashboards with a vertical column per stage; tasks (titled boxes) move between columns as status changes. Boards visualize in-flight work and expose problems like work piling up in one stage — if lots of work is stuck in testing, the team can push some development work back to the backlog and free engineers to help test. Kanban works best for teams handling a large stream of incoming requests — support engineers, SREs — rather than longer-term projects.

Teams rarely implement the "platonic ideal" of either framework; they pick and choose practices, alter them, or ignore them. *Scrumban* (a real thing) mashes the two together. Whatever the variant, the planning process exists to deliver useful software to happy customers. Stay focused on goals rather than mechanics. Experiment and measure results; keep what works, drop the rest.

### Scrum Prework

Most software teams practice some form of Scrum. Planning begins with prework: developers and product managers create user stories, and backlog tickets are triaged. Stories get story points to estimate complexity and are broken into tasks. Larger, ambiguous stories are designed and researched with spike stories. During sprint planning, the team chooses which stories to complete in the next sprint, using story points to prevent overcommitting.

### User Stories

A user story is a ticket that defines a feature request from a user's perspective, in the format: "As a \<user\>, I \<want to\> \<so that\>." For example: "As an administrator, I want to grant viewer permissions to my accountants so that they can see incoming billing statements." User-centric descriptions keep the focus on delivering user value.

A common misuse is jamming a regular task description into story format ("As a developer, I need to upgrade the shader plugin to version 8.7"). This misses the whole point — why does the plugin need updating, what value does it bring, who wants it? If you're going to write stories instead of tasks, write good ones.

Stories carry attributes beyond title and description; the two most common are **estimates** (a guess at implementation effort) and **acceptance criteria** (the definition of when a story is complete). Acceptance criteria keep developers, product managers, QA, and users on the same page. Try to write explicit tests for each acceptance criterion.

Small stories often double as work tickets; larger stories are linked to implementation tickets or subtasks. Ambiguous stories or those needing design get *spiked*: a spike is a time-bounded investigation that enables other stories to be completed, delivering a design doc, a build-versus-buy decision, an assessment of trade-offs, and so on.

### Tasks

A single story may need to be broken into smaller tasks to estimate duration, share work among developers, and track implementation progress. A good trick for breaking down work: write a very detailed description, then read it over and extract all the tasks. Even something as simple as adding a retry parameter to an API call expands into many steps — solidifying the spec with product managers, coding, unit testing, integration testing, deploying, and ramping. Breaking work into subtasks helps track and coordinate every step.

### Story Points

A team's work capacity is measured in story points, an agreed-upon sizing unit (hours, days, or "complexity"). Sprint capacity = number of developers × points per developer (a team of 4 engineers at 10 points each has 40-point capacity). Story estimates are also in points; the sum of points in a sprint should not exceed capacity.

Two common point definitions:

- **Time-based**: one point equals one workday. Day-based estimates usually account for nontask work — meetings, interruptions, code reviews — by defining a workday as four hours.
- **Complexity-based (T-shirt sizing)**: 1 point = extra small, 2 = small, 3 = medium, 5 = large, 8 = extra large — the Fibonacci sequence. Fibonacci increments remove quibbling over 3 versus 3.5 points; gaps between values force harder big-or-small decisions instead of "mediumish"; the widening gaps for larger tasks absorb estimation inaccuracy in bigger work.

Agile doctrine frowns on time-based estimation: practitioners claim dates carry emotional attachment and don't represent complexity. Nontime units can make uncertainty easier to express — changing a single method might look like little work, but if the method is incredibly complex it may take great effort, and it's mentally easier to say "this is a medium-complexity task" than "this will take me three full days." People get passionate about time versus complexity, and about whether points are useful at all; the arguments aren't very productive. Adopt whatever works best for your team.

Estimating is subjective, and people tend to be poor estimators. **Relative sizing** improves accuracy: assign points to tasks already finished, then compare an unestimated task against a finished one — less work means fewer points, more work means more points, similar work means the same value. Processes like *planning poker* are sometimes used; even if you don't take part, studying finished work gives you a feel for your team's story point values.

### Backlog Triage

Backlog triage or *grooming* (in the tree-trimming sense) usually happens before planning meetings. The backlog is a list of candidate stories; triage keeps it fresh, relevant, and prioritized. Product managers read over the backlog with the engineering manager and sometimes the developers: new stories are added, outdated stories closed, incomplete stories updated, and high-priority work moved to the top. A well-groomed backlog drives planning meeting discussions.

### Sprint Planning

Sprint planning happens once prework is done. Planning meetings are collaborative: engineering teams work with product managers to decide what to work on, discussing prioritized stories and determining what fits within the sprint's capacity. Capacity is derived from how much was completed in previous sprints, then refined as team members join or leave, take vacation, or enter or exit on-call rotations.

The most important feature of a sprint is that it's **short** — usually two weeks. Short sprints make pushing work out tolerable (it slips at most a week or two) and force teams to break large tasks into smaller ones. Small tasks are better: easier to understand and estimate, and they let multiple developers work on a project simultaneously. Smaller development cycles with frequent touch points (stand-ups, reviews) surface problems earlier.

Sprints are **locked** once planning is done. New work that surfaces mid-sprint should not be pulled in; push it to the backlog and plan it for a future sprint. Locking sprints lets developers focus and brings predictability. When unplanned work does get pulled in, the team should examine the reasons during the retrospective, with an eye to reducing unplanned work in the future.

Strict adherence to sprint planning practice is uncommon. Some teams do prework inside the planning meeting; some have no product managers and developers define all work; many skip user stories for open-ended task or bug tickets. Expect variation from team to team.

### Stand-ups

After sprint planning, work begins and the team holds daily stand-up meetings (also called scrum meetings or huddles). Stand-ups keep everyone apprised of progress, keep you accountable and focused, and give the team a chance to react to anything endangering sprint goals.

The usual format: a 15-minute meeting every morning (quick enough to stand through, though standing is optional). Teammates go around a circle and report what they've worked on since the last stand-up, what they plan to work on next, and any issues that could delay or derail the sprint. Some teams run asynchronous stand-ups, submitting the same update to a chatbot or group email daily.

Stand-ups are a regular system check — like glancing at your car's dashboard to confirm you have gas and the "check engine" light is off. Updates should be fast; stand-up is not the place for troubleshooting. Limit progress comments to the bare essentials and raise any issues you have. Announce discoveries too — bugs you found, unexpected behavior — and move the discussion of them to the *parking lot*: a post-meeting conversation among only the interested parties. "Save it for the parking lot" means stop the discussion now and pick it up after stand-up. This keeps stand-ups brief and discussions relevant to everyone attending.

Etiquette: be on time for synchronous stand-ups; if your team updates ticket statuses at stand-up, update your tickets beforehand. When listening to others' updates, look for opportunities to de-risk sprint completion — if someone's ticket is running long, volunteer to help if you have spare time. Skipping a stand-up over a scheduling conflict is acceptable; ask your manager how to provide and get updates when you miss one. Asynchronous stand-ups are skipped less often.

Variations exist: *scrum of scrums* selects a leader from each team's scrum to attend a second scrum where all teams report progress and call out interdependencies — common in operations, where each team sends an engineer (usually the on-call) to an operations scrum. The important thing is to understand how your team and organization work and to work within that framework.

### Reviews

A review happens between each sprint, usually in two parts: demonstrations and project review. During demonstrations everyone shows the progress they made; afterward the sprint is evaluated against its goal. Successful sprints meet their goals and have a high story-completion rate.

Review structures vary widely — some teams emphasize demos, some only do status review, and many teams skip reviews entirely. If your team holds them, take them seriously: provide real feedback and take pride in your work. The value you get from reviews matches the effort you put in.

Keep reviews to no more than one hour per sprint week (a two-week sprint gets a two-hour review). The meeting is informal — teammates take turns showing what they worked on, then sprint goals are reviewed and evaluated for completion. Don't overprepare: spend a few minutes deciding what to show and make sure your ticket statuses are accurate. Avoid formal presentations or speeches.

Reviews celebrate team wins, create unity, give feedback opportunities, and keep teams honest about progress. Since not everyone works on the same projects, reviews keep teammates in sync, let everyone recognize great work, and create cohesion. Status reviews also force agreement on what is truly "done" and how the team is progressing toward goals. Issues discovered in review can be discussed in retrospectives.

### Retrospectives

One of the twelve principles behind the Agile Manifesto: "At regular intervals, the team reflects on how to become more effective, then tunes and adjusts its behavior accordingly." Retrospectives implement this principle: the team discusses what has and hasn't gone well since the last retrospective.

A retro has three phases: **sharing, prioritization, and problem solving**. The leader (or *scrum master*) asks everyone to share what worked and what didn't during the last sprint, keeping the list on a whiteboard or shared document — everyone participates. The team then discusses priority among the items that aren't working: which cause the most pain? Finally, the team brainstorms ways to address the highest-priority problems.

Don't be afraid to change things. Agile practices are meant to be malleable — it's in the manifesto: individuals and interactions over process and tools. Spend a few minutes before each retrospective thinking about what would make your team better, and share your thoughts at the meeting.

Reviews and retrospectives often get confused: reviews focus on the work done in a sprint; retrospectives focus on process and tooling. Retros normally take place between sprints, often right after review meetings. Many teams combine review, retro, and sprint planning into a single meeting at the start of each sprint — fine, as long as each step is discretely addressed. Retrospectives are one reason Agile comes in so many flavors: teams are encouraged to reevaluate and adjust their processes frequently, so no two teams practice Agile quite the same way.

### Roadmaps

Two-week sprints handle small and medium work, but larger projects need more advanced planning: customers have delivery dates developers must hit, the business needs to know which teams need more engineers, and large technical projects must be broken down, planned, and coordinated.

Managers use product roadmaps for long-term planning, typically broken into quarters. Planning happens before each quarter begins: engineering managers, product managers, engineers, and other stakeholders convene over a series of meetings and multiple rounds of discussion.

Eisenhower said, "In preparing for battle I have always found that plans are useless, but planning is indispensable" — and this applies to roadmaps. No yearly or even quarterly roadmap is 100 percent accurate, and that isn't the point. Roadmaps should encourage everyone to think long-term about what the team is building; they are not static, reliable documents about what the team will build nine months out. Farther quarters should be fuzzier; closer quarters more accurate. Don't fool yourself into thinking any quarter is 100 percent accurate.

Unlike sprints, which are locked, roadmaps are meant to **evolve**. Customer requirements change and new technical problems arise; sprint planning, reviews, and retrospectives let you adjust the plan based on new information. Communication is critical when changing roadmaps — notify dependent teams early that work is getting shuffled or dropped.

Many companies run yearly planning cycles: managers spend the last quarter of each year planning the next four quarters. Yearly planning is mostly theater — horse-trading and negotiating — but it often drives "resource allocation" or "head count numbers," corporate speak for where newly hired engineers end up. Annual planning focuses on large projects consuming a significant percentage of a team's time. Don't stress if a project you're excited about isn't mentioned; ask your manager where it stands at the end of the planning process.

### Going Deeper

Most Agile books are overkill for working engineers — extremely detailed, covering many variants, targeted at project and program managers. Stick to online resources: the "Principles Behind the Agile Manifesto" page (agilemanifesto.org/principles.html) for philosophy, and Atlassian's Agile articles (atlassian.com/agile/) for practical guidance from project management and roadmap planning to DevOps; Atlassian's Kanban article is invaluable if your team uses Kanban.

## Actionable Practices

The authors' own summary:

- DO keep stand-up updates short.
- DO write detailed acceptance criteria for stories.
- DO only commit to work in a sprint that you can actually finish.
- DO break up large chunks of work if you can't finish them in a sprint.
- DO use story points to estimate work.
- DO use relative sizing and T-shirt sizing to help with estimation.
- DON'T obsess over the "right way" to do Agile.
- DON'T be afraid to change Agile processes.
- DON'T force regular task descriptions into "stories."
- DON'T forget to track planning and design work.
- DON'T add work after sprints begin if committed work is not yet done.
- DON'T follow processes blindly.

Additional guidance from the chapter:

- Write very detailed task descriptions, then read them back to discover all the subtasks hiding inside.
- Write explicit tests for each acceptance criterion.
- Use spike stories for ambiguous work that needs research or design before implementation.
- Push mid-sprint work to the backlog instead of pulling it in; investigate recurring unplanned work at the retrospective.
- Be on time for stand-ups; update your tickets beforehand if status updates are part of the meeting.
- Move stand-up discussions to the parking lot; raise discoveries (bugs, surprises) but don't troubleshoot in the meeting.
- Listen to teammates' stand-up updates for chances to de-risk the sprint — volunteer to help if a ticket runs long and you have spare time.
- Take reviews seriously when your team holds them, but don't overprepare — informal demos, accurate ticket statuses, no speeches.
- Think before each retrospective about what would make your team better, and say it at the meeting.
- Notify dependent teams early when roadmap work gets shuffled or dropped.
- Experiment with process, measure results, keep what works, and drop the rest.
- Ask your manager where a project you care about stands at the end of annual planning rather than stressing about its absence.
- Skip Agile books; learn from online resources like the manifesto principles page and Atlassian's articles.

## Pitfalls & Anti-patterns

- **Process worship**: obsessing over the "right" way to do Agile — certifications, consultants, rigid ceremony — betrays the first Agile value, individuals and interactions over processes and tools.
- **Fake user stories**: forcing task descriptions into story format ("As a developer, I need to upgrade the shader plugin to 8.7") strips the format of its purpose. A story should identify the real user, the real want, and the real value; a privacy-policy footer is wanted by the compliance officer, not "a user."
- **Overcommitting in sprint planning**: committing beyond demonstrated capacity. Use historical completion and story points to bound the sprint.
- **Pulling new work into a locked sprint**: mid-sprint additions while committed work is unfinished destroy focus and predictability; recurring unplanned work is a retro topic.
- **Untracked planning and design work**: research and design effort is real work — track it (spikes exist for this).
- **Troubleshooting in stand-up**: long debugging discussions waste everyone's time; save them for the parking lot.
- **Overpreparing review demos**: formal presentations and speeches defeat the informal purpose of reviews.
- **Confusing reviews with retrospectives**: reviews evaluate the sprint's work; retros evaluate process and tooling. Combining meetings is fine only if each step is discretely addressed.
- **Treating roadmaps as commitments**: no quarterly or yearly roadmap is 100 percent accurate; planning has value even though the plan changes. Conversely, changing a roadmap silently — without telling dependent teams early — causes downstream damage.
- **Quibbling over estimates and methodology**: arguments about time-based versus complexity-based points are unproductive; pick what works for your team. Fibonacci gaps exist precisely to stop debates over 3 versus 3.5 points.
- **Following processes blindly**: every team's Agile differs; understand the goals (useful software, happy customers) and adapt the mechanics.

## Key Terms

- **Agile development**: methodology valuing individuals/interactions, working software, customer collaboration, and responding to change; iterative delivery with frequent course correction.
- **Waterfall**: out-of-fashion practice of exhaustively planning a project at its inception; the usual contrast to Agile.
- **Scrum**: the most popular Agile framework — short fixed-length sprints with planning, daily stand-ups, reviews, and retrospectives.
- **Kanban**: Agile framework without sprints; work flows through customizable stages with limits on work in progress; visualized on a Kanban board.
- **Scrumban**: a real, named mashup of Scrum and Kanban practices.
- **Sprint**: a short, fixed-length development iteration (commonly two weeks), locked once planned.
- **Sprint planning**: collaborative meeting where engineers and product managers select stories that fit the sprint's capacity.
- **User story**: ticket describing a feature from the user's perspective: "As a \<user\>, I \<want to\> \<so that\>."
- **Acceptance criteria**: story attribute defining when the story is complete; aligns developers, product, QA, and users.
- **Estimate**: story attribute guessing the effort required to implement it.
- **Task**: a smaller unit of work a story is broken into for estimation, parallel work, and progress tracking.
- **Spike**: a time-bounded investigation that unblocks other stories, delivering a design doc, build-versus-buy decision, or trade-off assessment.
- **Story points**: agreed-upon sizing unit (hours, days, or complexity) for measuring work and team capacity.
- **Sprint capacity**: how much a team can complete in a sprint — developers × points per developer, calibrated from prior sprints.
- **T-shirt sizing**: complexity-based pointing using Fibonacci values (1=XS, 2=S, 3=M, 5=L, 8=XL).
- **Relative sizing**: estimating by comparing unfinished tasks against already-finished tasks with known points.
- **Planning poker**: a group process for estimating story points.
- **Backlog**: prioritized list of candidate stories.
- **Backlog triage (grooming)**: pre-planning cleanup — add new stories, close outdated ones, update incomplete ones, move high-priority work to the top.
- **Stand-up (scrum meeting, huddle)**: daily ~15-minute meeting: what you did, what you'll do, what's blocking; synchronous or asynchronous.
- **Parking lot**: post-stand-up discussion among interested parties, keeping the stand-up itself brief.
- **Scrum of scrums**: a second-level scrum attended by a representative of each team to report progress and surface interdependencies.
- **Scrum master**: the leader who facilitates retrospectives (and Scrum rituals generally).
- **Review**: between-sprint meeting of demonstrations plus evaluation of the sprint against its goal.
- **Retrospective (retro)**: between-sprint meeting on process and tooling, in three phases — sharing, prioritization, problem solving.
- **Work in progress (WIP)**: the count of in-flight tasks per stage, deliberately capped in Kanban.
- **Roadmap**: quarterly long-term plan meant to encourage long-term thinking and to evolve, not to be a static commitment.
- **Ticketing/issue system**: the tracker where sprint work and progress are recorded.
