# Chapter 13 Examples: Working with Managers

### The Lost 1:1 (Dmitriy's Forgotten Report)

Coauthor Dmitriy was once caught in a reorganization that jumbled teams and left him with almost twenty direct reports — some new, some people he had been friendly with for years. With so much to do (meeting new people, building a roadmap, improving old systems, creating new ones), he discovered a full year later that, because they were on friendly terms, he had never established a regular check-in with one of his reports. He only learned of the gap when that employee booked time to say they wanted to switch teams — partly because they wanted a manager who would be more involved in their career development. An existing friendly relationship is not a substitute, and a manager too busy to do 1:1s might be too busy to be a manager.
**Lesson:** Friendship does not replace regular 1:1s; career development requires deliberate, scheduled investment from a manager.

### A Sample PPP Status Report

The chapter shows a dated weekly PPP from an engineer working on notification and spam-detection services, roughly:

- **Progress:** debugged a performance issue in the notification service; code review up for email templating; spam-detection design circulated and the milestone-zero service written.
- **Plans:** add metrics and monitoring to the spam-detection service; work with the tools team to support PyPI artifacts in the secure build environment; onboard a new hire with a code walk-through; work with a database administrator to add an index preemptively before holiday load increases.
- **Problems:** trouble getting the team to review pull requests (several pending); Redis stability issues; interview load feels high at four per week.

**Lesson:** A good status update is a few short bullets per section that surface problems and needs your manager can act on — not an accounting of your time.

### OKRs for Stabilizing an Order Service

An engineer working on stabilizing an order service writes the objective "Stabilize order service" with four key results: 99.99 percent uptime as measured by health checks, 99th-percentile latency under 20 milliseconds, a 5XX error rate below 0.01 percent of responses, and the support team able to execute a regional failover in under five minutes.
**Lesson:** Key results are concrete, measurable signals that an objective has been reached.

### The OKR Cascade: Engineer to Team to Company

The order-service engineer's stability OKR might feed into a team OKR to improve stability, which in turn feeds into a company OKR to improve customer satisfaction. Ideally OKRs flow from the top of the company through teams down to each individual, with each layer's goals contributing to the layer above.
**Lesson:** Individual OKRs should chain upward so personal work visibly advances team and company goals.

### Grandma's Birthday Party

To show why key results must not become to-do lists, the authors use a deliberately silly example: if your objective is to make it to Grandma's birthday party, the key result is "be in Los Angeles by the 20th," not "drive down I-5 on the 19th." Taking the scenic coastal route or flying are perfectly acceptable alternative ways to get there. A well-formulated OKR gives you the freedom to choose the right method at the moment you need to make that choice, not when the OKR was set.
**Lesson:** Key results define how you'll know you succeeded, never which plan you must follow.

### "Get Better with Testing" vs. "What Can I Do Better?"

To show how to ask for feedback, the chapter contrasts two phrasings of the same request: "What can I do to get better with testing?" is better than "What can I do better?" Pair this with sending your questions to your manager before the 1:1, since producing feedback extemporaneously is hard, and extend the asks beyond technical topics to communication, career growth, leadership, and learning opportunities.
**Lesson:** Specific feedback questions get usable answers; vague ones yield little.

### The Engineering Reading Group (Feedback on Feedback)

The chapter scripts two ways to close the loop on a manager's suggestion to join an engineering reading group. Positive: "I joined the engineering reading group, like you suggested, and it's been really fun to read papers and discuss them with engineers from other teams! Thanks so much for the idea. I'm learning a ton." Honest negative: "I joined the engineering reading group, like you suggested, and to be honest, it's not working for me. They are discussing papers that aren't super relevant to my work. Can you suggest other ways for me to develop connections to different teams?"
**Lesson:** Feedback can feel like a black hole, so report results back — positive outcomes encourage more feedback, and negative ones let the manager offer better ideas.

### "How Could I Have Prevented the Production Incident?"

Asking your manager "How could I have prevented the production incident last week?" might draw the answer "We need to build a test environment." By asking for feedback instead of proposing a solution, you expose a gap in the team's processes while letting the manager reach the conclusion themselves.
**Lesson:** Asking for feedback is itself a way to give feedback — questions about how to do something surface process gaps without confrontation.

### SBI Feedback: The Stalled Permissions Service

A critical-feedback example using the Situation-Behavior-Impact framework. Situation: "I finished all the code changes to the new permissions service in January and handed it off to the operations team for rollout, but it still isn't deployed at the beginning of March." Behavior: "The 'upcoming releases' dashboard has moved the expected release date every week for five weeks, and the database upgrade has been pending for several weeks." Impact: "We're in danger of missing our deadlines, and dependent projects are also delayed — is there anything we can do?" Note that no solution is proposed; the speaker ends with a question.
**Lesson:** SBI sticks to facts and observable impact, avoids character judgments and assumed motives, and steers the conversation toward mitigation rather than blame.

### SBI Feedback: The Design Doc Template (Positive Version)

The same framework applied to praise. Situation: "We needed to write a design doc for proposed changes to the sign-up workflow last week, and I used the new design doc template you created." Behavior: "The section on rollout and communication plans made us realize we had completely forgotten to loop in the user support team." Impact: "They gave us a bunch of helpful feedback once we reached out, and the document was much faster to write because we didn't need to think about structure. Thanks for working on this!"
**Lesson:** SBI works for positive feedback too, and positive feedback matters because managers can't otherwise tell which of their changes helped — their work has no unit tests.

### The Career-Paths Conversation Script

For an engineer without fixed goals, the chapter scripts a 1:1 opener: "Can we talk about career paths today? I'm honestly not sure where I see myself in five years or what my options even are. What are some of the common career paths you see and how do they differ? I'm enjoying my current project, but I am also curious about security. Are there opportunities coming up that might let me do something security-related?"
**Lesson:** You don't need a finished career plan to discuss goals — naming your uncertainty and your curiosities lets your manager steer relevant opportunities your way.

### Establish Your Support Network (PyLadies and /dev/color)

A sidebar notes that it can be hard to give feedback, handle difficult situations, or even know what is normal. Trusted peer groups inside and outside your organization help you sanity-check things — doubly so for members of underrepresented groups. The authors point to organizations like PyLadies and /dev/color as communities where people can talk through situations and share stories and experiences.
**Lesson:** Build a peer support network to calibrate what's normal and get advice, especially if you're from an underrepresented group.

### The Programmer in the Mirror (Dmitriy Nearly Quits Tech)

Dmitriy's first software job almost drove him out of the industry. His tech lead for several years was well-meaning, a very good programmer, and friendly — and, in retrospect, an absolutely terrible manager. He made comments like "I thought UC Berkeley [Dmitriy's alma mater] was supposed to be a good school" and "A real programmer would instead...," joked about firing people, and even installed a bicycle mirror on his monitor to watch Dmitriy's screen. The kicker: by then he had good reason to watch — after years in that environment, Dmitriy was completely unmotivated, had lost faith in his abilities, and was slacking off a lot. He seriously considered quitting to become a chiropractor. After soul-searching, he tried a different company with the opposite culture: low-ego, highly skilled teammates convinced he could solve any problem given the right support. His confidence, motivation, focus, and skills grew, and his career rebounded — but it almost didn't happen because of one very good programmer who was a very bad manager.
**Lesson:** Dysfunctional management can destroy motivation and self-belief even in capable engineers; technical excellence doesn't make someone a good manager, and changing environments can revive a career.

### Level Up: Read What Managers Read

The chapter closes with a named reading list for understanding managers: *The Manager's Path* by Camille Fournier (the phases from staff engineer to VP of engineering and how each operates — the recommended starting point), *An Elegant Puzzle* by Will Larson (the problems managers face and their frameworks), *Thanks for the Feedback* by Douglas Stone and Sheila Heen (tools for processing feedback even when it's off base, unfair, or poorly delivered), *Managing Up* by Mary Abbajay (manager personas, tough managers, and when to move on), and Andy Grove's *High Output Management* (the 1983 classic from Intel that shaped modern engineering management — your manager has probably read it, so it doubles as a common reference point).
**Lesson:** Reading engineering-management books builds empathy for your manager, explains their behavior, and gives you shared vocabulary for better feedback.
