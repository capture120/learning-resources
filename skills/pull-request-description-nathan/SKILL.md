---
name: pull-request-description-nathan
description: Instructions for writing easy to read PR descriptions.
---

PR descriptions must state the highest-impact decisions that define what the PR does.
For a product PR, this is the product behavior. For an infra or dev-tooling PR it is the developer-facing impact. etc...
Ask yourself: which key decisions should a reviewer know to understand and judge this PR? Record only those.

Rules:
- Open with one sentence that says what the PR does. Never describe what the PR does not do, what was missing before, etc... Just say what the PR does.
- No code: no function names, file names, type names, column names, slugs, or pseudocode in the description. Reviewers who want code will read the diff.
- Use bullet lists with a short bold lead-in per bullet (e.g. "**No out-of-pocket maximum.** The member always pays coinsurance."). Do not add markdown headers inside the template sections.
- Each bullet is one high-impact decision. Leave out low-impact details. If the importance is unclear, clarify with the user. Lean towards clarification rather than missing a key change.
- "How did you verify" and "Risks" are one or two sentences each.
- Any PR with UI changes should include screenshots or a video of the changed UI in the description.

Style:
- The description should be written in ASD-STE100 Simplified Technical English
- Do not invent labels for concepts. Use plain words for what happens.
- For technical or domain specific concepts, use the wording our team does. Use already-existing terminology. Do not make up your own.
- Use soft wrapping in markdowns.

PR Description Structure. Each one is a header:
1. Why this PR?
2. How did you verify this works?
3. What are the risks of releasing this PR?