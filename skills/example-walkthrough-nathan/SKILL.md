---
name: example-walkthrough-nathan
description: walk through an example in code showing state. use to explain code
---

## Use the real code

When explaining existing code:

- Copy the function calls and function bodies from the current branch.
- Keep the code exactly as written. Do not rewrite or simplify it.
- Do not change any source files.
- Add the example values as comments in the response.
- Never add example values as executable code.
- If you skip part of the code, clearly mark where you skipped it.
- Check the response against the source before sending it.

Use this form:

```ts
const result = calculateTotal(items);
// items = [{ amountCents: 1000 }, { amountCents: 2000 }]
// result = 3000
```

Do not invent separate example code:

```ts
const items = [{ amountCents: 1000 }, { amountCents: 2000 }];
const result = 3000;
```

The example values belong in comments beside the real code.

## Walk through the full path

- Start with one sentence that explains why the code exists. Do not explain the implementation yet.
- Show the type signature.
- Give one small, concrete input and output.
- Show the complete function-call path before explaining individual lines.
- Use one continuous code block for the full walkthrough.
- Label each function and process stage inside that code block.
- Keep database values, submitted values, calculated values, and changed values clearly separated.

## Show concrete state

- Use the smallest example that still exercises the important logic.
- Keep each value in the same shape used by the running code.
- Put a concrete value beside every line that reads, creates, or changes a variable.
- Write values as comments, such as `// remainingCents = 2000`.
- Show the value before and after every mutation.
- Never use vague labels such as “the claim,” “the old object,” or “the result.”
- Name the exact claim, object, field, or result represented by each value.

Use the same approach for finance, health, mathematics, or any process with changing state.

Here's an issue I had in the past with the code example...
```
# my prompt
"""
somehow in this example i feel a little lost. i think it's because you didn't provide context for where these steps are taking place. what functions. what part of what process. etc. i lack a lot of context and the way you are representing the state overtime is getting confusing. you say just "the old object" when i told you to be concrete. do not make this mistake again please. 
"""

# issues you identified
"""
I did not show the full function call path first.
I did not label each step with its function and process stage.
I used vague names such as “the claim.”
I mixed database state, calculated state, and submitted state without clear boundaries.
"""
```

- Keep the walkthrough in one continuous code block.
- Put concrete values beside the corresponding source lines.
