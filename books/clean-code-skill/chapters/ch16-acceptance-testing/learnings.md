# Chapter 16: Acceptance Testing

The true requirements of a system are the tests that decide whether it ships. The discipline of acceptance testing recognizes this fact and recommends that all requirements be specified as tests — authored (or at least blessed) by business analysts and QA, automated and run by programmers, and treated as the definition of done. This is the clean-code discipline programmers control least, because it requires the business to participate — and many businesses have, so far, proven unwilling to properly engage.

## The tests are the requirements
Whatever the requirements document says, deployment is actually decided by the tests QA runs before signing off. If QA's tests pass, the system ships — therefore those tests *are* the requirements. The discipline simply recognizes this and makes the tests explicit, formal, and automated instead of manual and implicit.

## The Acceptance Testing Discipline
Specify every requirement as a test, written feature by feature, at the same time as or shortly before each feature is implemented. In the strictest form, BA and QA author the tests: BA focuses on happy-path scenarios, QA focuses on exploring the myriad ways the system can fail. In an Agile sprint, the tests are written in the first few days of the sprint and should all pass by its end.

## Programmers run the tests, so programmers automate them
QA does not run the tests; programmers do. No programmer in their right mind wants to manually test the system over and over — programmers automate things. If programmers are responsible for running the tests, they will automate them.

## The automation language must be readable by BA and QA
Because BA and QA author the tests but programmers automate them, programmers must be able to prove the automation performs the authored tests. So the automation language must be one BA and QA understand — ideally one they can write tests in themselves. Tools exist (FitNesse, JBehave, SpecFlow, Cucumber), but tools are not the issue; a spreadsheet or text editor works too.

## Every behavior spec is input, action, expected output
Specifying software behavior is always a simple function of input data, the action to perform, and the expected output. This is the AAA pattern — Arrange/Act/Assert (credited to Bill Wake) — or the Given-When-Then discipline of behavior-driven development (BDD). The easiest format is a simple table. These formalisms are relatively easy to automate regardless of tool.

## Acceptance tests are the definition of done
A feature is not complete until all its acceptance tests pass; when they all pass, the feature is done. This places a huge responsibility on BA and QA: their tests must be full specifications of the features, and the suite of acceptance tests is the requirements document for the entire system. By writing them, BA and QA certify that passing means done and working.

## Exception: when BA and QA can't yet write tests
If BA and QA are not accustomed to writing such formal, detailed documents, programmers may write the acceptance tests with guidance from BA and QA. The intermediate goal is tests that BA and QA can read and bless; the ultimate goal is BA and QA comfortable enough to write them.

## The Continuous Build
Once an acceptance test passes, it joins the suite run by the continuous build — an automated procedure triggered within minutes of every check-in that builds the system from source and runs all unit tests and all acceptance tests, with results visibly posted to everyone. This continuous running ensures later changes don't break working features. If a previously passing acceptance test fails, the team must immediately stop and repair it before making any other changes: "Allowing failures to accumulate in the continuous build is suicidal."

## The state of the practice must change
Acceptance testing is one of the weakest aspects of software development in the first half of the twenty-first century. Business and developers must learn to collaborate on a shared language and procedure so BA and QA can formally specify requirements and programmers can quickly verify they are satisfied. The advent of AI makes this need doubly important.

## In practice
- Treat the acceptance test suite as the system's real requirements document; resolve conflicts with prose docs in favor of the tests.
- Before implementing a feature, get (or write, with BA/QA guidance) acceptance tests that fully specify it — happy paths and failure paths.
- Express each test as input data, action, expected output (Arrange/Act/Assert or Given-When-Then), preferring tabular or plain-language formats non-programmers can read.
- Automate every acceptance test; never rely on repeated manual test runs.
- Don't call a feature done until all its acceptance tests pass; once they pass, stop — it's done.
- Add passing acceptance tests to the continuous build that runs on every check-in.
- If a previously passing test breaks in the continuous build, fix it immediately before doing any other work.
- Keep BA and QA engaged: make the test automation provably match what they authored.
