---
name: implementation-walkthrough
description: Guide a discussion before implementation. Clarify user requirements and interface behavior, define tests and invariants, survey relevant code with snippets, compare designs through pseudocode and diagrams, and question the user to confirm shared understanding.
---

This will take place in multiple parts. Do one part a time.

PART 1
first we will discuss on understanding the user problem and the requirements, from a user perspective. we're not talking about any code rn and are only talking about the requirements from the user perspective and how itd finally look on the UI.

PART 2
*responded to questions regarding implementation details and user requirements*
this is the plan so far. we should also think about unit tests to implement. lets start discussing what tests we'll have via pseudo code
we want to discuss what the invariants are. we want to capture edge cases. we want to capture core tests that will satisfy the user requirements

PART 3
*finished writing tests*

before pseudocode, lets discuss all the possible relevant files. without any implementation show me all relevant files and code you think may be possible. do not just show for one implementation show for multiple possible implementations if relevant

show me the relevant types, interfaces, functions, classes, etc that you think would be related to this. the goal is getting a survey of how things exist

you must show me relevant files AND the relevant files must be paired with code snippets. 
first give a high level overview of the files.
then for each file provide the relevant code snippets.
be exhaustive in this survey.

PART 4
now we will discuss this via pseudocode. reference the /show-me styling purely for how you will use pseudocode and diagrams.
some main focuses we care about (non-exhaustive):
- types
- interfaces
- invariants
- core functions / abstractions (especially pure functions / methods if any). signatures + pseudo
- signatures of all relevant functions / methods and how they are connected / call each other / pass data between each other
- data model (database)
- server actions/load
- high risk boundaries
- performance

i will send you the above message. while you are generating, i will generate my own approach and thinking. this will likely be wrong but it is me trying to generate my initial thinking. do not consider it to be the first approach.

i will then compare my approach with your generation, and we will discuss and agree on a 1st approach.

Step 5
Record our first approach in an MD file. 
Then run an adversarial review subagent with the focus on critiquing our approach.
Explain the results of the critique and we will discuss in depth.
For every new approach we come across and discuss, record into the MD file as a possible approach with benefits and tradeoffs.

A flow may look like this:
- Run critique on approach
- Detect and discuss gaps identified by adversarial review
- Come up with new approaches to possibly address gaps + understand tradeoffs. Record these approaches and also record the tradeoffs with the first approach.
- Loop with the adversarial review (default 1 additional time 2 times total to not get stuck)
- Choose a final approach accounting for the tradeoffs

Step 6
Run /grill-me on the final approach we choose so i understand to ensure we are aligned on everything.


TLDR:
# User needs & requirements
Before using an LLM, I write my thinking about what the user requirements are. Then, I have the LLM generate its thoughts without my answer. I compare LLM's answer to mine -> debate until we agree. It's def important to discuss it from the user perspective for LLMs.

# Unit tests / Invariants
Similar process as above but for unit tests. I write my thoughts first -> have LLM generate answer independently -> compare and discuss. Syntax of the unit tests does not matter (use pseudocode). Thinking through the edge cases and core behaviors is most important.

# File Exploration
I tell the agent to exhaustively find all possibly relevant files. Not doing this tends to result in issues where agent misses existing functions, types, etc. Having a chat pass for the agent to exclusively search gives it better context imo

# Pseudocode
I then have AI generate pseudocode focusing on these things:
- Types
- Interfaces
- Invariants
- Core functions implementation
- Function signatures of all new or edited functions (ask AI to show on diagram how data passes between them)
- Data model (database)
- Server load / actions
- High risk boundaries (where will things blow up)
- Performance
I'll review the plan and critique it. I don't create this myself first for velocity sake.

# Adversarial Review
I'll have an agent with fresh context critique my entire plan, explain alternative approaches I didn't consider, and give a bullet point list of all the approaches and their tradeoffs. 
I only do this once for velocity.