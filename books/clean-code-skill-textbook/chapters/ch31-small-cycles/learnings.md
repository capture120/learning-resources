# Chapter 31: Small Cycles

Everything in this chapter serves one promise: "I will make frequent, small releases so that I do not impede the progress of others." A small release means a small change — the system may be large, but each change to it is small. The entire history of source code control, from punch cards to git, has been driven, perhaps unconsciously, by a single underlying imperative: shrink the cycle time, because long cycles make the rest of the team wait for you.

## Short Cycles

Rule: shrink the time between integrations at every level — not just production releases, but iterations, sprints, the edit/compile/test cycle, and the time between commits. "It's about everything." The reasoning: the longer the time between commits, the greater the chance that someone else on the team — perhaps the whole team — has to wait for you, which violates the promise not to impede others. Holding code privately (the old "master tape" / pessimistic-locking pattern) prevented merges, but at the cost of locking everyone else out — a long, exclusive checkout that makes the team wait.

## Continuous Integration

Discipline: commit and integrate to the main line every few minutes — with git, push every hour or so. The rationale is simple: the more frequently you commit, the less likely you are to face a merge, and any merge you do face will be trivial. This depends critically on a very reliable suite of unit tests; without them, a merge error can silently break someone else's code. Continuous integration goes hand in hand with a good testing discipline. Merges are awful — tedious, time-consuming, and dangerous — especially without unit tests.

## Branches versus Toggles

Rule: a branch is simply a long-term checkout, and long-term checkouts impede others by prolonging the time between integrations. With git, the unit that must return promptly to the main line is the push (local commits between pushes are fine — they are just a recorded stream of work, not true named branches). Keeping a branch off the main line for days or weeks likely means a big merge — and certainly an impeded team.

Exception the author allows: when a feature is so isolated from the rest of the code that branching is not likely to cause a big merge, it might be better to let developers work in peace on a branch without continuously integrating (his FitNesse parser rewrite is the example — there, good isolation plus a fortunately comprehensive test suite kept the final merge from being too bad).

Default preference: keep new feature development on the main line and use toggles to keep unfinished features off. Toggles can be flags, but more often the Command pattern, the Decorator pattern, and special versions of the Factory pattern — or simply not exposing the feature (if the button isn't on the web page, the feature can't run). Nuance: you only need a toggle if you will release to production while features are unfinished; features finished within the current iteration or before the next release need none.

## Continuous Deployment

Goal: be able to release to production several times per day — comfortable enough to release on every push. This depends on automated testing: programmer tests covering every line of code, plus business-analyst and QA tests covering every desired behavior. Those tests are the scientific proof that everything works.

Heuristic for test quality: your tests are good enough if, when they pass, you feel comfortable deploying. If passing tests don't allow you to deploy, your tests are deficient.

Nuance: being ready to deploy does not mean the business is ready to deploy. The development team's standard is to always be ready, and to help the business remove deployment impediments — ceremony and ritual make deployment expensive. The ultimate goal is continuous, safe, ceremony-free deployment: deployment as close to a nonevent as possible. Automate the deployment procedure, and since deployment scripts are part of the system, write tests for them. If continuous deployment seems inconceivable today, still keep shortening the cycle month after month — you may arrive there eventually.

## Continuous Build

Rule: if you deploy in short cycles, you must build in short cycles. Slow builds have no excuse on modern hardware — speeding them up is a design challenge. Use a continuous build tool and kick off a build at every push.

A build failure is a red alert, an emergency: everyone stops what they are doing and deals with it. Prevention is simple: run the build and all tests locally before you push, and only push when everything passes. A failure after that signals an environmental issue to resolve immediately.

Never let the build go on failing. If you allow it to fail, you get used to it; if you get used to it, you start ignoring it; then you're tempted to turn failing tests off and fix them "later." That's when the tests become lies — the build passes and everyone feels good, but it's a lie.

## In practice

- Make each change small; integrate it to the main line frequently (push at least every hour or so).
- Run the full build and all tests locally before every push; push only when green.
- Treat a broken shared build as an emergency — stop work and fix it; never disable failing tests to make the build pass.
- Prefer the main line plus toggles (flags, Command/Decorator/Factory patterns, or hidden UI entry points) over long-lived feature branches.
- Reserve long-lived branches for work so isolated that a big merge is unlikely (e.g., a rewrite that can't be done incrementally).
- Maintain a test suite trustworthy enough that passing tests mean "safe to deploy"; if it isn't, fix the tests.
- Keep builds fast; treat slowness as a design defect.
- Automate deployment, and write tests for the deployment scripts themselves.
- Always be deployment-ready as a team, even if the business deploys less often; keep working to shorten every cycle.
