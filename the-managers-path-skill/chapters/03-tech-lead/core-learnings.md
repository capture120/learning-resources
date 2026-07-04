# Chapter 3: Tech Lead — Core Learnings

## What this chapter is about

The tech lead role is the first leadership step on the engineering path: a senior engineer who takes responsibility for a team's overall output while still writing code. The chapter defines what the role actually demands (project management, communication, balance), why it is harder than it looks, and how to decide whether to take it.

## What a tech lead is

- "Tech lead" has no industry-standard definition, and the role may differ from company to company and even from team to team within a company — but the title always implies **both a technical position and a leadership role**. At Rent the Runway, Fournier's team deliberately defined it as **a set of responsibilities any engineer can take on once they reach senior level, not a rung on the ladder**. The role can be passed from one engineer to another without either person changing job level, and it is often temporary.
- Fournier's own tech lead job: continue writing code, plus represent the group to management, vet the team's plans for feature delivery, and deal with many details of the project management process. She could be tech lead despite not being the most senior person because she was willing and able to take on those responsibilities while the rest of the team preferred to stay purely focused on the software they were writing.
- If the tech lead manages people, they must do so to full management standards: regular weekly 1-1s, regular feedback on career growth and areas for improvement, and active work on each report's learning and growth. If not managing directly, they still owe the team mentorship and guidance.
- A tech lead is learning to be a strong technical project manager: scaling themselves by delegating without micromanaging, focusing on the whole team's productivity and striving to increase the impact of the team's work product, making independent decisions for the team, learning to handle difficult management and leadership situations, and partnering with product, analytics, and other parts of the business.
- Patrick Kua's shorthand (from *Talking with Tech Leads*): a leader responsible for a software development team who spends **at least 30 percent of their time writing code** with the team.
- Career relevance (from the Rent the Runway ladder description): working as a tech lead is not strictly required to progress, but on that ladder it is the most common way to grow from senior engineer 1 to senior engineer 2, and it **is** required to grow from senior engineer 2 to engineering lead. The description adds that realistically it is very hard to grow past senior engineer 2 without ever having acted as tech lead — **even on the individual contributor track** — because senior levels demand leadership and responsibility.

## The biggest misconception

The tech lead role should **not** automatically go to the most experienced engineer or the best coder. You cannot lead without engaging other people; people skills, not technical depth, are the new stretch. The role is wrong for someone who wants the freedom to focus deeply on their own code — a tech lead who does that is not doing the job. The one genuinely new technical skill is project management, and breaking down a project resembles designing systems, so it is worth learning even for engineers who never want to manage.

## The "one weird trick": balance

- The defining skill of a good tech lead is **the willingness to step away from the code** and balance personal technical commitments against what the whole team needs. You must stop relying entirely on old skills and learn new ones, which feels uncomfortable because humans prefer activities they have already mastered.
- **Balance is not a tech-lead-only problem.** From now on, wherever you go in your career, balancing is likely to be one of your core challenges — the tech lead role is just the first place you learn the art of balance.
- To keep autonomy over your work, you must gain mastery over your time. Some days you are on a maker's schedule, some days a manager's schedule; learn through trial and error to carve out appropriately sized blocks.
- **The worst scheduling mistake is letting yourself get pulled randomly into meetings.** You cannot get into a coding groove when interrupted every hour.
- Accept that you will rarely get multi-day stretches of focus. Break your own work down so you do not need them.
- Protect the team's focus too: part of your leadership is helping your boss and the product manager respect the team's need for long uninterrupted development time and keep individual contributors' calendars from being overwhelmed.

## The main roles of a tech lead

The highest priority is taking a wide view of the work so the project keeps moving. On a typical multiweek initiative with a product manager and a handful of engineers, you rotate through several roles:

### Systems architect and business analyst
- Identify the critical systems that need to change and the critical features that need to be built. The goal is structure for estimates and ordering work, not perfect upfront identification of every element.
- Spend time thinking through externalities and issues. This requires a good sense of the overall architecture, solid understanding of designing complex software, and the ability to translate business requirements into software.

### Project planner
- Break work into rough deliverables and find breakdowns that let the team work in parallel. Agreed-upon abstractions enable parallelism: for example, agree on a JSON format so the frontend can develop against dummy objects before the API is finished.
- Getting as much work done in parallel as possible can be tough because you are probably used to thinking about only your own work, not the work of groups of people. If you are lucky, you have seen this happen before and are simply pattern-matching your previous work.
- Gather input from the experts on your team; talk to the people who know the affected parts deeply.
- Start identifying priorities: which pieces are critical, which optional, and how to get critical items done early.

### Software developer and team leader
- Keep writing code, **but not too much**. Resist the temptation to play hero and push through obstacles alone with excessive overtime.
- Communicate obstacles early. The product manager should know about challenges as soon as possible; enlist your engineering manager as needed. In a healthy organization there is no shame in raising issues early — teams often fail by overworking on a feature the product manager would happily have compromised on.
- As the delivery date nears and compromises arrive, look for opportunities to **delegate**, especially parts of the system you expected to build yourself but no longer have time for.

You do not wear all of these hats at once; balance comes with time and practice.

## Managing projects: why and how

### Why project management still matters
- Agile development does not eliminate project management. Agile is excellent for breaking work into small chunks and delivering incrementally, but some projects cannot fit in one or two sprints, management will want length estimates with justification, and infrastructure/platform/system projects that require architecture or significant advance planning, with their many unknowns and relatively hard deadlines, do not fit well into the standard agile process.
- As you move forward in your career, you must learn to break down work whose complexity is beyond the scope of what you can do as an individual. Fournier admits she finds this tedious and sometimes scary — she wants to be building and getting value, and fears being held accountable for missing something that makes the project fail — but that discomfort is not a reason to skip it.
- Project management is not needed in detail for every effort, and some organizations overuse it. Fournier dislikes hiring dedicated project managers because they become a crutch: engineers stop learning to think through future work and ask real questions about what they are doing and why, and the organization drifts toward waterfall. When deep project management is needed — especially on deeply technical projects — the tech lead should do it.
- **The value of planning is not that you execute the plan perfectly, catch every detail, or predict the future. It is that it forces the self-discipline to think the project through in some depth before diving in.** The goal is a degree of forethought, applied in places where you can reasonably make predictions and plans. The plan itself, however accurate it turns out, matters less than the act of planning. The alternative to planning is not avoiding failure — it is the project failing slower.

### What project management actually is

Project management is the act of breaking a complex end goal down into smaller pieces, putting those pieces in roughly the most effective order, identifying which pieces can be done in parallel and which must be done in sequence, and attempting to tease out the unknowns that may cause the project to slow down or fail completely. You are addressing uncertainty, trying to find the unknowns, and recognizing that you will make mistakes and miss some unknowns despite your best efforts.

### The five guidelines for managing a project
1. **Break down the work.** Use a spreadsheet, Gantt chart, whatever works. Start from the big deliverable, break into large pieces, then smaller and smaller. You need not do it alone — ask the people who understand the parts you don't. Then order the work: what can start immediately? Hand tasks to people who can turn them into ticket-sized work.
2. **Push through the details and the unknowns.** The trick is not stopping when you feel stuck or tired. It is tedious; keep pushing through irritation, boredom, and pain. A good manager will sit with you, point out where the plan isn't good enough, prompt with questions, or even work through parts of it with you — managers find it tedious too, but it is part of the teaching exercise. Work the unknowns until there is genuinely no more value in spending time on them.
3. **Run the project and adjust the plan as you go.** A good plan tells you roughly how far the project has come and how far remains. As things slip — they always do — keep everyone apprised, pointing to milestones hit and the expected remaining work instead of guessing.
4. **Use the planning insights to manage requirements changes.** When requirements change midflight, apply what you learned in the breakdown. If changes add significant risk, force replanning, or add lots of work, be explicit about the cost. Against a hard deadline, knowing rough effort helps you prioritize, cut, and simplify for the best compromise of features, quality, and delivery date.
5. **Revisit the details as you near completion.** The tedium returns at the end. Attend to finishing details: what's missing, what testing, what verification. Run a **premortem** — walk through everything that could fail at launch. Decide where the "good enough" line is, socialize it, commit to it, and cut what falls below it. Make a launch plan and a rollback plan. Then celebrate.

## Ask the CTO advice, distilled

### "I hate being a tech lead!"
The role is the "Stone of Triumph": recognition that comes with a heavy price. Tech leads rarely get a raise or title bump, yet the scope is far wider than a senior IC's — architect the project, plan the work, ensure the team understands requirements and performs well — without necessarily having any management responsibilities, usually without any specific training, and while managers still expect nearly the same code output as before. It is a pure increase in responsibility. The consolation: carrying the burden builds the skills needed to move forward, and it will not always feel this heavy.

### "I'm not sure I want to be a tech lead"
Do not let anyone push you into management-type responsibilities before you are ready. There is nothing wrong with staying deep in the technology, especially while you still have a lot to learn before becoming an expert. Pushing people away from coding too early can hurt them: at senior levels, people seen as "not technical enough" struggle to be promoted into management roles with more responsibility. It is easier to finish your technical learning as a focused IC than to learn it while also learning management. At some point you will probably need to do the tech lead job to keep progressing, even on the IC track — but not necessarily now. If plenty of purely technical learning remains and you would rather work as an individual, decline. If the individual work would not challenge you technically, that is the signal to push into new skills, and tech lead skills are good ones to try.

## Decision point: technical track vs. management

Fournier refuses to give a universal answer — it is deeply context-specific — but contrasts the imagined versions of each role with reality (both are admitted caricatures):

- **Senior IC, imagined:** mostly deep technical work you choose, attendance only at the right meetings, an unbroken upward trajectory, industry fame from talks and open source, deference despite weak people skills.
- **Senior IC, real:** great when the right project is in the right phase, but every project includes a selling phase and an adoption-evangelism phase. The upward trajectory is slow because career-proving projects are scarce and your manager expects *you* to find them; picking the wrong one can mean years on something that gets cancelled. Peers are a mix of admirers and rivals; your manager may forget to include you in new initiatives until it is too late, and the meetings holding the information you need are boring and cost focus time. Still: you build things most of the time, can move between teams, and may even out-earn your manager.
- **Manager, imagined:** control, decisions, a team that respects your authority, fast promotions, quick visible coaching impact, plenty of time left for talks and writing.
- **Manager, real:** getting people to do things is harder than telling them; your calendar fills with meetings; you lose touch with the code as the team grows — with a small team you could still balance both, but checking in code you can't support becomes irresponsible; you facilitate decisions more than you make them; you set the culture for better and worse — the team mirrors your faults too; authority requires far more than a title; motivating people through raises withheld and promotions denied is draining; when the company is stressed you discover how little power you have to make people happy; and the politics of leading without undermining peers or your boss is trickier than expected. The sustaining force is the small wins of seeing people succeed because of your coaching.

**You can switch tracks.** It is common to try management, decide you don't enjoy it, and return to the technical track. Nothing is permanent — go in with eyes wide open and feel out what you enjoy.

## Good manager, bad manager: the process czar

- The process czar believes one true process, correctly implemented and followed, will solve all the team's biggest problems — whether that process is agile, Kanban, scrum, lean, or waterfall. They may have a very precise idea of how on-call should work, how code reviews must be done, or how the release process has to operate. They are organized, detail-comfortable, and excellent at knowing and following rules, which makes them genuinely valuable for making sure no task is forgotten and everything is wrapped up properly.
- They struggle because most people are not as good at following processes as they are. They blame every problem on failure to follow the process instead of accepting the need for flexibility and the inevitability of unexpected change, and they fixate on easy-to-measure things (like hours in the office) while missing what is hard to measure.
- Engineers who believe in "the right tool for the job" sometimes become process czars as new tech leads: hunting for the perfect tool to fix all planning, focus, time-management, and prioritization issues, stopping all work to search for the perfect process, or pushing a stream of new tools and processes as solutions to messy human problems.
- The healthy opposite is not abandoning process but fitting process to the needs of the team and the work. The Agile Manifesto's principles, ironically given how rigidly "agile" is often implemented, summarize healthy process leadership: individuals and interactions over processes and tools; working software over comprehensive documentation; customer collaboration over contract negotiation; responding to change over following a plan.
- As a new tech lead: do not use process to paper over communication or leadership gaps; process change is rarely a silver bullet, and no two great teams look alike in process, tools, or work style. Prefer **self-regulating processes**: if you find yourself playing rules cop, change the process to be easier to follow instead — automation can make the rules obvious, and policing wastes your time.
- If you manage a process czar: help them get more comfortable with ambiguity. Their obsession is often fear of failure and a desire to control the unexpected; honestly making it clear that it is safe to fail and be imperfect is often enough to get them to relax and let some ambiguity in. Keep them from endlessly seeking the perfect tool, and above all keep them from punishing the team for not following processes.

## How to be a great tech lead

- **Understand the architecture.** If you don't fully understand the architecture you are supporting, take the time to learn it: visualize it, know its connections, where the data lives, how it flows between systems, and how it reflects the products it supports. It is almost impossible to lead projects well on an architecture you don't understand.
- **Be a team player.** If you are doing all the interesting work yourself, stop. Pick up the tricky, boring, or annoying areas — they often contain something obvious an experienced person can spot and fix, and they teach you where the process is broken. But if you are doing *only* boring work, stop that too: you are a talented senior engineer and it is reasonable to take some hard tasks. Give others chances to stretch and learn the whole system, without being endlessly self-sacrificing — take a fun task occasionally when you know you have time to do it well.
- **Lead technical decisions.** Be involved in most major technical decisions, but "involved" does not mean making them all alone. Make every decision yourself without team input and the team will resent you and blame you when things go wrong; make none and easy decisions drag on unresolved. Sort decisions into three buckets — ones you must make, ones to delegate to people with more expertise, and ones the whole team should resolve — and in every case state clearly what is being decided and communicate the outcome.
- **Communicate.** Your personal productivity now matters less than the team's, and you pay the price of communication overhead: represent the team in meetings rather than dragging everyone along, and bring information back. The one universal talent separating successful leaders is communication: they write well, read carefully, can speak to a group, and pay attention in meetings, constantly testing the limits of their own knowledge and the team's. Practice now — write design docs and get feedback from better writers, write blog posts, speak at team meetings and meetups. And listen: let others speak, repeat things back to confirm understanding, rephrase in your own words, and become a good note taker. Whether you go deep technical or into management, poor communication and listening will cap your career growth from here on.

## Pitfalls and anti-patterns

- Giving the tech lead role automatically to the most experienced engineer or best coder.
- Taking the role to keep doing only your own deep technical work — the team drifts while you focus on your code.
- Hiding in technical rabbit holes (endless refactoring) while product steamrolls the team into bad commitments.
- Hero mode: silently absorbing obstacles with overtime instead of surfacing them early for compromise.
- Letting meetings randomly fragment your (and the team's) maker time.
- Becoming a process czar: treating process or tooling as the fix for human communication and leadership problems, and policing compliance.
- Skipping planning because it is tedious or because "we're agile" — the project then fails slower, not faster.
- Letting a manager push you out of coding before you are technically ready, which can later block promotion to senior management roles.

## Assessing your own experience

- Does your organization have tech leads? Is there a written job description? If so, what does it say? If not, how would you define the role — and how would a current tech lead define it?
- If you are considering becoming a tech lead: are you ready to push yourself? Are you comfortable spending some of your time outside the code? Do you feel enough of an expert in your codebase to successfully lead others working in it?
- Have you asked your manager what they expect from the tech lead?
- Who is the best tech lead you ever worked with? What did that person do that made them great?
- Have you worked with a frustrating tech lead? What did they do that frustrated you?
