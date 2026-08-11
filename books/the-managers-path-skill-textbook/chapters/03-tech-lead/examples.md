# Chapter 3: Tech Lead — Examples and Anecdotes

## Fournier becomes tech lead without being the most senior

**Situation:** Early in her career, Fournier was promoted to senior engineer on a small team that included several other senior engineers. To her surprise, she — not the most senior person by title or years — was made tech lead.

**What happened / what was done:** In retrospect she identifies the advantages that earned her the role: she was a strong communicator who could write clear documents, give presentations without melting down, and explain status to people on different teams and in different roles; she was good at prioritizing; she was eager to push work forward and decide what needed to happen next; and she was willing to pick up whatever pieces were needed to make progress. She believes that pragmatic urgency was the deciding factor. Her job as tech lead was to continue writing code, with the added responsibilities of representing the group to management, vetting the team's plans for feature delivery, and dealing with many details of the project management process. She could be tech lead despite not being the most senior person because she was willing and able to take on those responsibilities, while the rest of the team preferred to stay purely focused on the software they were writing.

**Lesson:** Tech lead is a leadership position even when it is not a management position. Communication, prioritization, and willingness to do whatever moves the project forward matter more than being the most senior or most technically accomplished engineer.

## The floundering tech lead who hid in refactoring

**Situation:** Fournier watched a tech lead struggle: an amazing engineer who wrote great code but hated talking to people and frequently got distracted by technical details.

**What happened / what was done:** He went down rabbit hole after rabbit hole. While he was absent from the leadership conversation, the product manager railroaded the rest of the team into committing to feature delivery that was both poorly designed and far too aggressive. The project became a mess — and the tech lead responded by chasing the next refactoring, convinced the problems were entirely in how the code was structured.

**Lesson:** This failure happens everywhere because of a common misconception, one that even experienced managers fall for: that the tech lead role should automatically go to the most experienced engineer, the one who handles the most complex features or writes the best code. Tech lead is not the job for a person who wants the freedom to focus deeply on the details of her own code; a tech lead who does that is not doing her job, and the team pays the price.

## Rent the Runway's definition of the tech lead role

**Situation:** When Fournier's team at Rent the Runway created their engineering career ladder, they had to decide where tech lead fit.

**What happened / what was done:** They consciously defined tech lead not as a point on the ladder but as a set of responsibilities any engineer may take on once they reach senior level — recognizing that as teams evolve, the role may be held by engineers at many different stages and passed from one engineer to another without either person changing functional level. Their description specified that if the tech lead manages people, they must do so to the organization's full management standards: regular weekly 1-1 touchbases; regular feedback on career growth, progression toward goals, areas for improvement, and praise as warranted; and working with reports to identify areas for learning and growth through project work, external learning, or additional mentoring. A tech lead who is not managing directly is still expected to mentor and guide the other members of the team.

**Lesson:** Treating tech lead as a temporary set of responsibilities rather than a title or promotion reflects how the role actually works in evolving teams — and holding tech leads who manage people to real management standards prevents second-class management.

## Caitie McCaffrey: selling a technical-debt initiative (guest contribution, "Being a Tech Lead")

**Situation:** As a tech lead, McCaffrey led a team where everyone, herself included, reported to the same engineering manager — leadership purely by influence, with no authority. One of her first projects in the role was a hard sell: stop all feature development and focus on technical debt. The debt had been kicked down the road too long — deploying new code was difficult, operating the existing services was expensive, and the on-call rotation was hellish. She believed the team needed to go slow in order to go fast later. The other developers wanted to write fun new features, and her manager faced a constant stream of customer requests.

**What happened / what was done:** She sold the idea by tailoring the pitch to each audience. For individual team members she emphasized whichever benefit they personally cared about: a more reliable service for some, faster iteration speed for others, and for others a lighter on-call burden so they could sleep through the night. With her manager she emphasized reduced operational overhead, which would let the team accomplish more feature work in the future. She also notes the personal shift: becoming tech lead meant the work was no longer about her tackling the most technically challenging or fun project (a rewrite would have shown off more technical prowess), but about empowering the team and removing obstacles.

**Lesson:** Being a tech lead is an exercise in influencing without authority — influencing peers and influencing upward. The initiative was incredibly successful: critical paging alerts dropped 50 percent, and the team nearly doubled its number of deploys the following quarter. Framing the same initiative in terms of each stakeholder's own pain is how you win support without authority.

## Fournier's first project plan, with her boss Mike

**Situation:** As a first-time tech lead, Fournier's team had scaled an existing system to its breaking point. After trying every hack available, they decided to run it across several machines — in the very early days of distributed systems, when best practices were not widely known. The team spent a long time on design and on breaking up the computations sensibly. Then her boss Mike pulled her into his office and told her she needed to make a project plan.

**What happened / what was done:** She calls it one of the worst experiences ever. She had to take an incredibly complicated set of tasks and work out the dependencies: how it would work in their complex testing framework, how they would deploy it, when hardware needed to be ordered for testing, how long integration testing would take. She would sit across the big wooden desk from Mike going over task descriptions, dates, and breakdowns; he would help with some of it and send her off to redo the parts that needed more work. She had to push through uncertainty, fear of making mistakes, and fear of missing pieces to produce a plan that would pass his judgment — then endure another round of tedious work formatting it for the leadership team. It almost killed her, and it became one of the most important learning experiences of her career. The project did not run perfectly — there were bumps, bugs, unexpected delays, and missed items — but the team delivered fairly close to on time with no string of sleepless nights, converting the complex system into a distributed deployable artifact while working against the master branch alongside 40 other developers making concurrent changes. It worked because they had a great team and a plan: they had thought through what success looked like and identified risks that could cause failure.

**Lesson:** The value of planning is not perfect prediction. It is the enforced self-discipline of thinking the project through in depth before diving in. The plan's accuracy matters less than the act of planning, and a good manager who refuses to accept a half-done plan is doing you a favor.

## Passing the planning discipline on: Carlo, Alicia, and Tim

**Situation:** Years after those frustrating sessions with Mike, Fournier sat on the other side of the desk, running the same kind of project-planning meetings with engineers she led — Carlo, Alicia, Tim.

**What happened / what was done:** Each of them felt the same frustration at being told their plan lacked detail, and each went away and did the uncomfortable work of thinking about things that are not code and cannot be perfectly predicted.

**Lesson:** Each of them went on to lead complex projects to successful outcomes, and each is better equipped to build bigger systems and lead larger teams because they learned what breaking down a project really means. The discomfort of planning is a teachable, transferable discipline.

## Michael Marçal: the thesis defense (guest contribution, "Take the Time to Explain")

**Situation:** Marçal earned a PhD from one of the most prestigious applied mathematics programs in the United States. One judge on his defense panel was a renowned mathematician in numerical analysis. Marçal had assumed that such a world-class expert would simply "know all about it" and just watch how the thesis turned out.

**What happened / what was done:** After the successful defense, the judge told him his thesis was one of the most lucid and clear he had read in many years — and explained that he could follow it only because Marçal had taken the trouble to explain the basic ideas of the problem space and the motivations behind his ideas.

**Lesson:** Even world-class experts depend on you explaining fundamentals and motivation. Marçal never forgot it, and years in software and large organizations deepened his appreciation: technologists wrongly assume management "gets" what they do ("just read the code, man!"), but technology managers hire excellent people to solve hard problems without understanding it all. Senior technical managers are notably grateful when basic modern ideas (for example, what NoSQL is and why it matters) are explained in a nonthreatening, noncondescending way.

## Michael Marçal: the business manager and the platform migration

**Situation:** A senior business manager privately asked Marçal why it was important to migrate their traditional deployed fat-client architecture to a hosted platform. The manager was under heavy internal pressure to fund the effort, had no idea why it was necessary, and was probably too embarrassed to ask publicly.

**What happened / what was done:** Marçal spent two very fruitful hours explaining — without PowerPoint. He now never hesitates to take the opportunity to explain basics and motivation to senior or junior colleagues.

**Lesson:** Taking the time to explain educates people without making them feel small, builds their trust in your judgment and advice, and is how you bring about change. Decision-makers often quietly lack context they cannot admit to needing; offering the explanation privately and respectfully converts confusion into sponsorship.

## Ask the CTO: "I hate being a tech lead!" — the Stone of Triumph

**Situation:** An engineer who expected the tech lead role to be awesome instead finds their manager demanding project status details and delivery forecasts, and they hate it. Why did no one warn them?

**What happened / what was done:** Fournier names the problem the "Stone of Triumph" (a Simpsons reference): recognition that arrives carrying a heavy weight. Tech leads rarely get a salary increase or title bump; many companies treat it as a temporary set of responsibilities taken up and shed several times across a career — a stepping-stone to promotion, not a milestone with immediate tangible rewards. Meanwhile the scope is far wider than a senior IC's: architect the project, plan the work, make sure the team fully understands the requirements, keep the team effective and performing — without necessarily having any management responsibilities, usually without any specific training, and with a manager who still expects nearly as much code as before.

**Lesson:** The role is a pure increase in responsibility and scope, and first-time tech leads should expect to have their hands very full. The consolation is real: carrying the stone builds the strength and skills needed to move forward, and it will not always feel as heavy as it does at first.

## Ask the CTO: "I'm not sure I want to be a tech lead"

**Situation:** An engineer's manager keeps pushing her to take the tech lead role and run a big project. She knows it would mean much less coding time and many more meetings, and she does not think she wants it.

**What happened / what was done:** Fournier's answer: people should not be pushed into management-type roles, and you should not take one on before you are ready. There is nothing wrong with staying deep in the technology, especially if you still have a lot to learn before becoming an expert. Good managers scout for leadership talent but sometimes pull people away from coding too early, which can damage a career: at senior levels, people viewed as "not technical enough" find it hard to be promoted into management positions with more responsibility. It is much easier to complete your technical learning as a focused individual contributor than while simultaneously learning management skills.

**Lesson:** To keep progressing, you will probably need to do the tech lead job at some point even on the individual contributor track — but not necessarily now. If plenty of purely technical learning remains and you would rather work individually, decline. If the individual work no longer challenges you technically, that is the moment to push into new skills, and the tech lead's are good ones to try.

## The Being-a-Tech-Lead-101 scenario: a multiweek initiative

**Situation:** A hypothetical used to walk through the role: you are partnering with a product manager and a team of four other engineers on a big multiweek effort to launch a new initiative.

**What happened / what was done:** Depending on where the project is in its lifecycle, the tech lead rotates through roles: systems architect and business analyst (identify the critical systems and features that must change, providing structure for estimates and ordering); project planner (break work into rough deliverables that maximize parallel progress); and software developer and team leader (keep coding, but not too much; surface obstacles early; delegate).

**Lesson:** Writing code and making technical decisions is only one of the tech lead's roles in such a project — and likely not even the most important one. The highest priority is the wide view that keeps the project moving.

## The JSON dummy-object trick for parallel work

**Situation:** Within the project-planner role: a frontend needs to consume JSON objects from an API that does not exist yet. Done naively, the frontend team waits for the API to be finished.

**What happened / what was done:** Agree on the JSON format up front, and have the frontend developers code against dummy objects in that format while the API is built in parallel.

**Lesson:** Agreed-upon abstractions are the key to unlocking parallel work. A tech lead's planning job is to find these seams, with input from the team members who know the affected parts of the software deeply.

## Imagined versus real life on each career track

**Situation:** To inform the decision between staying technical and becoming a manager, Fournier — who has dreamed of and lived both tracks — contrasts the fantasy of each role with what she experienced and observed, offered explicitly as caricatures.

**What happened / what was done:** The imagined senior individual contributor spends days in deep thinking on fun hard problems, attends only the right meetings, rises steadily, earns industry fame through books and talks, and is forgiven any awkwardness. Managers ask the imagined contributor for advice on how to approach development before it begins, so you know everything going on without dealing with the details of the people building it; and you are rarely called on to stay late or work weekends, because everyone knows it is impossible to do quality, thoughtful work for too many hours a week — when you do work late, it is only because you are so caught up in the flow. The real one is happy only when the right project is in the right phase; every project carries a selling phase and an adoption-evangelism phase spent convincing other teams to use the work; career-proving projects are rare and the manager expects you to find them yourself — the big projects that prove you to be an invaluable architect are hard to find because the team doesn't need a new programming language, a new database, or a new web framework, and discovering good projects seems to be a matter of luck; pick wrong and you spend months or years on something that gets cancelled; peers are a mix of admirers and rivals, new developers either want too much of your time or seem scared of you, and you are a little jealous of friends in management who seem to be promoted faster as their teams grow; the manager forgets to include you in initiatives until it is too late, yet the meetings with the information you need are boring and cost focus time; she is unsupportive of your open source ambitions, suggests using personal time for talks and books, and has little patience for your desire to be free of tedious work like email, interviewing, and prompt code reviews. Still, you build things most of the time, can choose and change projects — and you may discover you are paid more than your manager. The imagined manager has control, instant compliance ("Write more tests," and they do), grateful reports, fast promotions, and time left for talks. The imagined manager also makes sure everyone is treated fairly regardless of gender or race, firing anyone who crosses the line and creates an unhealthy environment; because you obviously care, reports give you the benefit of the doubt and come to 1-1s with open feedback, eager to receive feedback from you; you freely advise other managers the way you would help another engineer with a system design, and they welcome it; your own manager coaches you plentifully but rarely steps in to tell you what to do, hands you clear goals that rarely change, and expands your team the minute you feel ready; and blog posts and talks are encouraged because they help your team hire and improve your standing in the tech industry. The real manager discovers getting people to do anything is harder than telling them; lives in meetings; loses touch with the code as the team grows — with a small team they could balance things and still write code, but now snatched coding hours yield only scripts and debugging, since checking in code the team must support would be irresponsible; helps the team make decisions more than making them; explains the manager-above's flip-flopped goals to the team; learns the team mirrors their faults as much as their virtues; finds that authority requires far more than a title — some people do not bother to tell you they are unhappy; they get fed up and quit before you have noticed anything is wrong; sees in stressful times how little power they have to make people happy — and cannot even fire people without a drawn-out HR process; finds that other managers read feedback as meddling and turf encroachment, while their own manager's coaching is weak, he cannot explain why they are not ready for a bigger team (perhaps worried about being outshone), and he resents time spent out of the office giving talks; discovers a staff engineer who reports to them earns more than they do; and finds the politics of leading without undermining peers or boss trickier than expected. The sustaining force is the people who are happier and more successful because of the coaching.

**Lesson:** Neither track matches its fantasy, and the choice is intensely context-specific. The final advice: you can switch tracks. Many people try management, realize they do not enjoy it, and return to the technical track. Nothing about the choice is permanent — go in with eyes wide open and feel out what you enjoy most.

## The engineer who becomes a process czar

**Situation:** A recurring bad-manager archetype: the process czar believes there is one true process — agile, Kanban, scrum, lean, even waterfall — that, implemented correctly and followed as designed, will solve all of the team's biggest problems. The type is often found in QA, helpdesk, and product management groups, and in consulting agencies where measured work progress is highly rewarded. They may be operationally focused, yet in Fournier's experience relatively few process czars are found inside classic systems operations teams.

**What happened / what was done:** Engineers who believe in "the right tool for the job" sometimes turn into process czars when they become tech leads: seeking out the right tool to solve every issue of planning, focus, time management, and prioritization; stopping all work while they search for the perfect process; or constantly pushing new tools and processes onto the team as solutions to the messier problems of human interaction. Process czars blame all problems on failure to follow the best process, fixate on easy-to-measure things like hours in the office, and miss what is hard to measure. They can be incredibly valuable members of a project management team because they tend to make sure no task is forgotten and everything is wrapped up the way it should be. As the manager of a process czar, help them get more comfortable with ambiguity: the obsession with process can be related to a fear of failure and a desire to control things to prevent the unexpected, and honestly making it clear that it is safe to fail and be imperfect is often enough to get them to relax and let some ambiguity in.

**Lesson:** Process must serve the needs of the team and the work, not the reverse. A new tech lead should be wary of using process to fix communication or leadership gaps, should prefer self-regulating processes, and should change a process to be easier to follow rather than play rules cop — automation can make the rules obvious, and policing is a waste of the lead's time.
