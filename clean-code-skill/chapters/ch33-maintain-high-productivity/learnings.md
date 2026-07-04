# Chapter 33: Maintain High Productivity

The chapter's epigraph: "6. I will do all that I can to keep the productivity of myself and others as high as possible. I will do nothing that decreases that productivity." Clean code, clean design, and good tests are the *indirect* route to speed ("The only way to go fast is to go well"); this chapter covers the *direct* routes: removing viscosity from the development environment, managing distractions, and disciplining your time.

## Viscosity: the code-writing myopia

Programmers are often myopic about productivity: they see writing code quickly as its primary component. Writing code is a small slice of the process — building, testing, debugging, deploying, plus requirements, analysis, design, meetings, research, infrastructure, and tooling dominate. Making code-writing infinitely fast would barely move overall productivity. Attack the slow parts of the whole loop instead.

## Fast builds

There is no reason, in the third and subsequent decades of the twenty-first century, for a build to take more than a minute or two. A 30-minute build after a 5-minute edit destroys productivity. Are you utterly certain, in this age of cloud computing, that there is no way to dramatically speed up your build? Find whatever makes it slow and fix it — treat it as a design challenge.

## Fast tests: never execute the same thing twice

A modest laptop executes ~10 billion instructions per second; unless your system has more instructions than that, a full test run should take under a second — unless you execute instructions repeatedly. The discipline:

- Test each behavior **once**. How many times must you test login to know it works? Generally speaking, once should be sufficient. More than one test going through login is waste.
- Short-circuit login for tests via mocking patterns, or remove login from test builds if you must.
- Don't make tests walk the UI navigation/menu chain to reach a state. Build a **special testing API** that forces the system directly into the needed state, without logging in and without navigating. More than once per navigation pathway is waste.
- Execute each query once; mock out databases for the majority of tests.
- Peripheral devices, disks, web sockets, and UI screens are slow; even SSDs can be slow. Mock them out, bypass them, get them off the critical path of the tests.
- "Don't tolerate slow tests. Keep your tests running fast!"

## Fast debugging comes from test discipline

If debugging is slow, ask why. With a testing discipline — unit tests, acceptance tests, coverage measured with a good analysis tool, and semantic stability periodically proven with a mutation tester — debug time can shrink to insignificance. Even doing only some of these helps.

## One-click deployment

Deployment is a procedure; you are programmers, so automate it — and write tests for that procedure too. Never deploy manually. You should be able to deploy the system, every time, with a single click.

## Meetings: when the meeting gets boring, leave

Rule: "When the meeting gets boring, leave." Be polite — wait for a lull, say your input is no longer required, and excuse yourself to your large backlog of work. Never be afraid to leave; some meetings will keep you forever otherwise. Better still, decline most invitations: don't be seduced by fear of missing out — if you're truly needed, they'll come get you. When you do accept, make the organizer convince you you're needed, state up front you can only afford a few minutes and may leave early, and sit close to the door. If you're a leader or manager, a primary duty is defending your team's productivity by keeping them out of meetings.

## Music divides attention

Martin found that music while coding only *feels* like it aids concentration; it actually divides attention (he found song lyrics scattered as comments in his year-old code). His theory: programming and music are both arrangements of sequence, selection, and iteration, so music may consume the same mental machinery programming uses. He concedes you must test this yourself — maybe music genuinely helps you — but advises trying a week without it to see if you produce more and better code.

## Mood: act on the root of the emotion

Emotional stress can kill your ability to code and keep you perpetually distracted. The fix: **Act.** Act on the root of the emotion — don't try to code through it, and don't paper over feelings with music or meetings; it won't work. After a fight with your spouse, call them and attempt resolution. You don't have to actually solve the problem — taking enough appropriate action, even an unsuccessful attempt, is usually enough to clear the mind and redirect your thoughts to code.

## Resist The Flow

The hyper-focused "flow" state feels euphoric and superhuman, but Martin finds the code produced in it tends to be pretty bad — far less well considered than code written in a normal state of attention and focus. So resist entering flow. Pairing keeps you out of it (communication and collaboration seem to interfere with flow); avoiding music keeps the real environment grounding you. If you notice yourself starting to hyper-focus, break away and do something else for a while.

## Time management: the Pomodoro Technique

The technique's aim is managing your time and focus during a regular workday; it doesn't concern itself with anything beyond that. Set a timer for 25 minutes, work until it rings, then break for 5; repeat. Nothing is magic about 25 — anything from 15 to 45 minutes is reasonable — but once chosen, stick with it for a while. Small flexibility is allowed (finish a test you're 30 seconds from passing), but don't run more than a minute over; the discipline matters.

Where it shines is interruptions: **Defend the Tomato!** Tell interrupters you'll get back to them within one tomato, dispatch the interruption as quickly as possible, return to work, and handle the interruption after your break. Gaps between tomatoes will sometimes get long — that's fine and is the technique's beauty: at day's end the count of completed tomatoes measures your productivity. Once skilled, plan your day by allocating tomatoes, estimate tasks in tomatoes, and schedule meetings and lunches around them.

## In practice

- Profile the whole development loop (build, test, debug, deploy), not just code-writing speed; fix the slowest part first as a design challenge.
- Keep builds under a minute or two; treat anything longer as a defect.
- Make the full test suite run in seconds: test each behavior once, mock databases and peripherals, and build a testing API that jumps the system straight into any needed state.
- Reduce debugging time by maintaining unit tests, acceptance tests, coverage analysis, and mutation testing.
- Automate deployment into a single tested click; never deploy manually.
- Decline most meetings; leave politely when one stops needing you; sit by the door. Managers: shield the team from meetings.
- Try a week of coding without music and compare the quality of what you produce.
- When emotionally distressed, take action on the root cause before trying to code; don't mask feelings with music or meetings.
- Avoid the flow state; pair, stay grounded, and step away when you catch yourself hyper-focusing.
- Work in fixed timer intervals (Pomodoro), defend each tomato from interruptions, count completed tomatoes, and plan/estimate in tomatoes.
