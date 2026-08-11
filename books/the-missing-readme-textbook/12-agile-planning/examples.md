# Chapter 12 Examples: Agile Planning

### The Agile Manifesto and its four values
In 2001, leaders from earlier methodologies such as Extreme Programming, Scrum, Feature-Driven Development, and Pragmatic Programming collaborated to write the Agile Manifesto. It declares four preferences: individuals and interactions over processes and tools, working software over comprehensive documentation, customer collaboration over contract negotiation, and responding to change over following a plan — noting that the right-hand items have value, but the left-hand ones are valued more. Agile is usually contrasted with Waterfall, the out-of-fashion practice of exhaustively planning a project at its inception. **Lesson:** Agile's essence is collaboration, embracing change, and iterative improvement — not any specific ritual.

### The Agile-industrial complex
Once Agile became popular, "black-belt ninjas," certifications, and process consultants overran some organizations. People became obsessed with the "right" way to "do Agile," ironically violating the manifesto's very first principle: individuals and interactions over processes and tools. **Lesson:** Treating Agile as rigid doctrine defeats its founding value.

### Unclogging a Kanban testing bottleneck
A Kanban board shows a column for each workflow stage — for example: backlog, planning, implementation, testing, deployment, rollout — with task cards moving across them. If the board reveals a pile of work stuck in the testing column, the team can respond by pushing some development work back to the backlog, freeing engineers to help with testing until the clog clears. **Lesson:** Kanban boards make in-flight work visible so teams can spot bottlenecks and rebalance effort.

### A good user story: accountants viewing billing statements
The chapter's model story reads: "As an administrator, I want to grant viewer permissions to my accountants so that they can see incoming billing statements." It names the real user (an administrator), the want (granting viewer permissions), and the value (accountants can see billing statements). **Lesson:** A well-formed user story keeps the team focused on who benefits and why.

### Bad user stories: the shader plugin and the privacy-policy footer
Two anti-examples show task descriptions jammed into story format: "As a developer, I need to upgrade the shader plugin to version 8.7" and "As a user, I want the privacy policy to show up in the footer." The first hides the actual motivation — why upgrade, what value, who wants it? The second misattributes the want: the compliance officer wants the footer, not "a user." **Lesson:** If you bother writing stories instead of tasks, write honest ones that capture real users and real value.

### Acceptance criteria for the billing-statements story
The billing-statements story comes with explicit acceptance criteria: the administrator permission page lists a "billing statements" option; a nonadministrator granted viewer permission can see all of the account's billing statements; the Edit button is hidden for nonadministrator accounts; viewers cannot edit statements; and nonadministrators holding both editor and viewer permissions can see and edit them. The chapter advises writing an explicit test for each criterion. **Lesson:** Detailed acceptance criteria define "done" and keep developers, product managers, QA, and users aligned.

### Discovering tasks inside the postProfile retry description
To break a story into tasks, write a very detailed description and then mine it for tasks. The example: a `retry` parameter must be added to a `postProfile` call because profiles don't update when a network timeout occurs; retries should be capped with exponential backoff so calls don't block too long; product must be consulted on acceptable wait time; unit and integration tests are needed, with integration tests simulating real network timeouts to verify backoff; then deployment to a testing environment, then production, where traffic should be split and the retry behavior ramped slowly because `postProfile` is sensitive. A "simple" parameter addition expands into spec work, coding, two kinds of testing, deployment, and a careful ramp. **Lesson:** Detailed descriptions expose the many hidden subtasks inside seemingly small work.

### Sprint capacity arithmetic
A sprint's capacity is the number of developers multiplied by points per developer: a team with 4 engineers at 10 points each has a 40-point capacity, and the sum of story points planned into the sprint should not exceed it. **Lesson:** Capacity math turns story points into a concrete guard against overcommitting.

### The four-hour workday
Many teams use time-based points where one point equals one workday — but they define the workday as only four hours, deliberately accounting for nontask work like meetings, interruptions, and code reviews. **Lesson:** Realistic estimation budgets for the overhead that eats half an engineer's day.

### T-shirt sizes and the Fibonacci sequence
Complexity-based teams size stories like T-shirts: one point is extra small, two is small, three is medium, five is large, eight is extra large — the Fibonacci sequence. Fibonacci increments kill quibbling over 3 versus 3.5 points; the gaps force a hard call between big and small rather than "mediumish"; and the widening gaps for larger tasks absorb the estimation inaccuracy inherent in bigger work. **Lesson:** Coarse, gapped point scales make estimates faster, more honest, and tolerant of uncertainty.

### The deceptively small one-method change
Agile doctrine argues against time-based estimates partly because nontime units express uncertainty better: changing a single method might seem like a small amount of work, but if that method is incredibly complex, it could require a lot of effort. It's mentally easier to call it "a medium-complexity task" than to commit to "three full days of work." The authors add that debates over time versus complexity points are unproductive — use whatever works for your team. **Lesson:** Complexity units decouple estimates from emotionally loaded dates and make uncertainty easier to admit.

### Relative sizing and planning poker
Because people are poor estimators, teams improve accuracy with relative sizing: assign points to tasks that are already finished, then compare each new task against a finished one — less work means fewer points, more work means more, similar work means the same value. Some teams formalize this with planning poker; even if you don't participate, studying finished work teaches you your team's point values. **Lesson:** Comparing against completed work anchors subjective estimates in reality.

### Stand-up as the car-dashboard glance
The chapter likens the daily stand-up to glancing at your car's dashboard: you confirm there's gas in the tank and the mysterious "check engine" light is off, then keep driving. Updates should be fast and essential; stand-up is not the place for troubleshooting, though you should announce discoveries like bugs and unexpected behavior. **Lesson:** Stand-ups are a quick system check on the sprint, not a working session.

### "Save it for the parking lot"
When a stand-up discussion grows beyond a quick update, someone says to "save it for the parking lot" — meaning stop now and continue after the meeting with only the interested parties (not a literal parking lot). This keeps stand-ups brief and ensures discussions stay relevant to everyone attending. **Lesson:** Deferring deep dives keeps the whole team's meeting short while still resolving issues.

### Scrum of scrums and the operations on-call
In a scrum of scrums, a leader from each team's scrum attends a second-level scrum where all the teams report progress and call out interdependencies. The pattern is common in operations: each team sends an engineer — usually the on-call — to an operations scrum to stay apprised of operational issues. **Lesson:** Layered stand-ups scale coordination across many teams.

### Scrumban
Teams rarely implement the platonic ideal of Scrum or Kanban; they mix practices, and the mashup even has a name — Scrumban, which the authors note is "a real thing." Whatever the variant, the process should serve delivering useful software to happy customers. **Lesson:** Frameworks are raw material to adapt, not recipes to follow exactly.

### One hour of review per sprint week
The standard cap on sprint reviews is one hour per week of sprint — so a two-week sprint gets a two-hour review. Everyone gathers around desks or in a conference room, teammates take turns informally showing what they've worked on, and afterward the sprint goals are reviewed and evaluated for completion. **Lesson:** Time-box reviews in proportion to sprint length and keep the demonstrations informal.

### The manifesto principle behind retrospectives
One of the twelve principles behind the Agile Manifesto states: "At regular intervals, the team reflects on how to become more effective, then tunes and adjusts its behavior accordingly." Retrospective meetings exist to implement this principle, running in three phases — sharing what worked and what didn't, prioritizing the painful items, and brainstorming fixes for the worst ones. Constant adjustment through retros is why no two teams practice Agile quite the same way. **Lesson:** Retrospectives are Agile's built-in mechanism for evolving the process itself.

### Eisenhower on plans versus planning
Quoting The Papers of Dwight David Eisenhower: "In preparing for battle I have always found that plans are useless, but planning is indispensable." The authors apply this to roadmaps — they have never seen a yearly or even quarterly roadmap be 100 percent accurate, and accuracy isn't the point; roadmaps exist to make everyone think long-term about what the team is building, with nearer quarters more accurate and farther ones fuzzier. **Lesson:** The value of a roadmap is the thinking it forces, not the prediction it records.

### Yearly planning as theater
Many companies run yearly planning cycles where managers spend the final quarter planning the next four. The authors call it mostly theater — horse-trading and negotiating — yet it drives "resource allocation" and "head count numbers," corporate speak for where newly hired engineers end up, and it focuses on large projects that consume significant team time. If a project you're excited about isn't mentioned, don't stress; ask your manager where it stands once planning ends. **Lesson:** Annual planning is political and imprecise, but it still determines staffing, so engage with it calmly rather than panicking.
