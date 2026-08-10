# Chapter 29: No Defect in Behavior or Structure

This chapter expands the second promise of The Programmer's Oath: "The code that I produce will always be my best work. I will not knowingly allow code that is defective either in behavior or in structure to accumulate." Getting code to work is only the first and easiest step; the harder, professional step is cleaning the code — and structure ultimately matters more than behavior, because structure is what lets behavior stay valuable as requirements change.

## "First, make it work. Then, make it right." (Kent Beck)
Working code is not done code. Too many programmers declare victory once the program works, move on, and leave behind tangled, unreadable code that slows the whole team. Making it work is the easy half; making it right is the harder, obligatory half.

## Rushing comes from inside, not from the boss
Programmers rush because they tie speed of delivery to their own self-worth: they feel they're paid a lot, software takes a long time, so they feel like they're failing and try to go faster. Martin observes students rushing even on throwaway class exercises he doesn't care whether they finish. Manager pressure ("the constant tapping of the project manager's foot") doesn't help, but the real driver is internal.

## Structure is more valuable than behavior
Software has two values: the value of its behavior and the value of its structure. Structure is the more critical because long-term value requires the system to react to changing requirements. Good structure enables good behavior; bad structure impedes it — the value of behavior depends critically on the structure. Professionals therefore put a higher priority on structure than on behavior, keeping the system clean from the project's very beginning to its very end.

## Clean structure matters from day one
Requirements are most volatile at the start of a project, just after users see the first features work and discover what the system actually does versus what they imagined. So the structure must be clean at the very start; a mess made early slows down even the very first release.

## What good structure is
Good structure makes the system easy to test, easy to change, and easy to reuse. Changes to one part don't break other parts; changes to one module don't force massive recompiles and redeployments; high-level policies stay separate and independent from low-level details.

## The design smells: Rigidity, Fragility, Immobility
Poor structure makes a system rigid, fragile, and immobile:
- **Rigidity**: minor changes force large portions of the system to be recompiled, rebuilt, and redeployed; the effort to integrate a change far exceeds the change itself.
- **Fragility**: a small behavior change forces changes in many modules, risking silent breakage of other behaviors that get inadvertently deployed — making managers and customers believe the team has lost control.
- **Immobility**: a useful behavior is so tangled in the existing system that you can't extract it for reuse elsewhere.

A system can pass all its tests and meet all functional requirements yet be close to **worthless** because it's too difficult to manipulate. When developers demand "the grand redesign in the sky" and managers agree, both have judged the current system worthless.

## Dependencies cause the smells; principles cure them
The design smells are caused by source code and data dependencies. The fix is dependency management, and dependency management derives from design principles such as the SOLID principles. Therefore the overall value of the system depends on proper application of those principles.

## Eisenhower's Matrix — "the engineer's motto"
Eisenhower: "I have two kinds of problems, the urgent and the important. The urgent are not important, and the important are never urgent." Martin says we might even call this "the engineer's motto": **"The greater the urgency, the less the relevance."** Urgency is about time; importance is not. Structure is long term, therefore important; behavior is short term, therefore merely urgent. The important comes first: structure first, behavior secondary. Your boss might not agree with this priority, but that's because worrying about structure is not the boss's job — it's yours; the boss simply expects you to keep structure clean while implementing the urgent behaviors.

## Squaring the circle: the Red-Green-Refactor cycle
"Make it work first" seems to contradict "structure has higher priority." Resolution: structure must support behavior, so you implement a behavior first, then immediately give it the right structure — at a tiny granularity. Stories are too big; **tests are the perfect size**. Get a test to pass, fix the structure of the code that passes it, and only then get the next test to pass. The structure of the current story/test is higher priority than the behavior of the next one. This is the moral foundation of the Red-Green-Refactor cycle of a good testing discipline like test-driven development (TDD), and why a testing discipline is really a **design technique**, not a testing technique.

## Programmers Are Stakeholders
You have a stake in the project's success — it directly affects your career and reputation — so you have a say in how the system is developed and structured. Beyond stakeholder, you are an **engineer**: hired because you know how to build systems that last, with the duty to ensure your systems do no harm through bad behavior or bad structure. Programmers who would rather just be told what to do are being unprofessional — Martin says they should be paid minimum wage, because that's what their work output is worth. Your boss likely doesn't know SOLID, design patterns, object-oriented design, dependency inversion, or TDD — or testing patterns like the self-shunt, test-specific subclass, and humble object — or that things that change together belong together and things that change for different reasons should be separated. If you don't take responsibility for structure, no one will.

## Refuse orders to ignore structure
If your boss tells you to ignore structure and focus entirely on behavior: refuse. You have rights as a stakeholder and responsibilities as an engineer that a boss cannot override. Refusing probably won't get you fired — most managers expect to fight for what they need and respect those who do the same. The confrontation will be uncomfortable, but backing down and acquiescing is unprofessional. Learning to fight for what you know is right is part of the job.

## Do Your Best — the promise is not black and white
The promise is to do your best and never *knowingly* release harmful code. It allows trade-offs:
- Structure may sometimes bend to schedule — a quick-and-dirty fix to make a trade show is acceptable.
- You may ship with less-than-perfect structure if it's close and the customer expects the release tomorrow.

What the promise forbids is **accumulation**: you must address known defects of behavior and structure before adding more behavior. Never pile new behavior on top of known bad structure.

## In practice
- After making code work, clean its structure before moving to the next task; "it works" is not "done."
- Work at test-size granularity: pass a test, refactor, then write the next test (Red-Green-Refactor).
- Do not start a new feature, story, or test while known structural mess remains from the last one.
- Treat slowdowns in change as design smells: diagnose rigidity, fragility, and immobility, and fix the underlying dependencies using design principles (SOLID).
- Keep structure clean from the very first commit — early requirements churn is highest, so early mess is costliest.
- When pressured to skip cleanup, push back: explain that skipping cleanup slows feature delivery, and negotiate (feature tomorrow, cleanup tonight) rather than acquiesce.
- Accept rare, deliberate schedule-driven shortcuts, but schedule their cleanup immediately; never let defects accumulate.
- Notice when your own sense of self-worth is making you rush, and slow down.
