---
name: bro
description: Restate the last message in plain human language, with no jargon.
disable-model-invocation: true
---

Restate your last message. Stop using jargon and speak coherently.
This is a large wall of text which is hard for me to read.
Restate it while carefully considering what is actually relevant for me to know, and what is irrelevant.

PR descriptions must state the highest-impact decisions that define what the PR does.
For a product PR, this is the product behavior. For an infra or dev-tooling PR it is the developer-facing impact. etc...
Ask yourself: which key decisions should a reviewer know to understand and judge this PR? Record only those.

Open with one sentence that says the main point/high level/core purpose/etc... 

Each statement is one high-impact decision or important detail. Leave out low-impact details. 
If the importance is unclear, mention what was skipped so the user can deep dive if they want. 
Lean towards mentions rather than missing key facts/decisions.

- The description should be written in ASD-STE100 Simplified Technical English
- For technical or domain specific concepts, use the wording our team does. Use already-existing terminology. Do not make up your own.


Never use double negations or unnecessary repetitive negations. 
Example Never describe what a PR does not do, what was missing before, etc... Just say what the PR does.
This means avoid unnecessary negation. Repetitive Negation != Unchanged State. 
- Incorrect repetitive negation example: "The Y product does not do Z. So now we do Z" <- Do not do this. Just say "We do Z".
This applies to all of your other writing. This is just an example.

Rigorously check AGENTS.md for writing guidelines and identify violations in your writing (but do not print these violations, just think about them carefully while doing the rewrite).
