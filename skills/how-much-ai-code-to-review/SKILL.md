---
name: how-much-ai-code-to-review
description: guideline for how much of PR code to review. also when to review PRs made by AI
---
"my hot take on how much AI code we should review -

you should review as much code from AI as your engineering director reviewed your code before AI

here’s the chain of thought:

- why do we even use AI to code? it’s to allow us to ship more

- how much more should a single developer be able to ship now, compared to pre-AI? i see us going from 1-10x in the past 3 years, and on a trajectory to hit the 100x magnitude soon

- that means every developer is going to own as much scope as a pre-AI director of engineering

- i haven’t met a single eng director who said their team’s codebases were perfect and exactly how they would like it to be. why? because people who try to achieve that will fail to become a director

- how do directors handle that level of complexity? it’s absolutely not by reviewing and micro-managing every engineer’s code. it’s through managing the culture, workflows, resource allocation, guardrails and measurable outcomes 

- when a director sees the team struggle on productivity or quality, they might lean in and try to understand the state of the codebase to develop some intuition for how to improve things systematically. even this is often done with the help from their principal engineers - i believe this is the right balance for how we should manage AI

so, if we want to get a massive boost from AI, we must be prepared to operate in a way that allows us to manage much higher complexity, which requires that we remove ourselves as a bottleneck and manage the outcome at a different level

shape your AI agents’ workflows - are they doing adversarial review? are there good automated tests? are they presenting evidence before shipping? are they doing phased rollout? are there good metrics to catch problems?

survey your agents for feedback - ask them to reflect on their past sessions and report biggest problems causing them to struggle, and allocate enough tokens to get those problems fixed

focus on outcomes - are your agents doing busy work? do you truly understand customer requirements and what work is worth doing? are your agents’ work generating the business outcome you expect?

that’s how we truly scale"