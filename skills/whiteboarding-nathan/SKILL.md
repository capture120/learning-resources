---
name: whiteboarding-nathan
description: Conduct a live technical whiteboarding session in the user's existing tldraw browser tab. Use when the user asks to whiteboard, diagram, visually debug, or walk through code as if pairing with another engineer.
---

# Live technical whiteboarding

Use the whiteboard to build understanding with the user.
Do not use it only to present a finished explanation.

## Surface

- Use the user's existing tldraw tab in the browser.
- Control the tab directly from the coordinator.
- Do not open Excalidraw or another drawing application.
- Keep the requested tab open as the final deliverable.
- Do not delete or replace the user's drawings without permission.

## Core teaching loop

Repeat this loop until the user understands the problem:

1. Write one small unit on the board.
2. Explain only that unit.
3. Let the user respond.
4. Continue when the user understands the unit.

A unit is usually a shape(s), relationship(s), or some pseudocode lines.
The core point is to represent 1 core idea with the shapes/relationships/pseudocode/diagramming you create.

Do not draw the full solution before the user understands the starting state.
Do not give a spoken wall of text while the board stays unchanged.

## Start with context

Use one plain sentence before code.

Define every domain term before using it.

Follow existing naming conventions in the codebase.

## Verify before drawing

Inspect the current diff and the relevant code path first.

## Board structure

Use actual shapes, arrows, and text boxes.
Use text boxes for all written text.
Use freehand drawing only when a normal shape does not fit.
Do not draw text by hand.

Keep each section within a readable viewport. Avoid large empty shapes and extreme zoom changes.
Use nesting when the code contains nested data. Use arrows when the code moves through steps.

## Pair shapes with pseudocode

Shapes show structure. Pseudocode shows behavior. Use both when the problem involves code.

Place short pseudocode next to the related shape. Use the exact function and variable names when they help.

Use one stable toy example for the full walkthrough. Do not change values between sections.

Show every value beside the line that creates or uses it:

```ts
individualRemaining = 100 - 100 // individualRemaining = 0
familyRemaining = 300 - 100 // familyRemaining = 200
remaining = [familyRemaining, individualRemaining] // remaining = [200, 0]
deductibleRemaining = Math.min(...remaining) // deductibleRemaining = 0
```

## Show state boundaries

Label state by source and time. Useful labels include:

- Plan rules
- Earlier approved claims
- New service line
- Calculated state
- Final member payment
- Final plan payment

Do not mix prior-claim totals with the new claim amount.
Do not mix member-paid money with plan-paid money.

When two similar variables track different meanings, write both variables explicitly:

```ts
dentalMember.deductible.usedCents = 100 // member paid
dentalMember.maxBenefit.usedCents = 400 // plan paid
```

## Handle confusion

When the user says "I am lost" or "What am I looking at?":

1. Stop adding content.
2. Name the single item currently on screen.
3. State its purpose in one sentence.
4. Remove code names if the code names are the source of confusion.
5. Move one abstraction level earlier when necessary.

Example recovery:

> Forget the function name. A member receives a $50 dental service. The system must decide who pays the $50.

Do not repeat the same explanation with more words. Change the representation or move to an earlier concept.

If the user asks you to wait, wait. If the user asks you to keep drawing, continue the agreed section without stopping for routine updates.

## Domain branches

Explain a domain rule before using that rule to explain a defect.

Compare branches with the same values. Example:

- Embedded deductible: the individual or family threshold can unlock coverage.
- Aggregate deductible: only the family threshold can unlock coverage.

Do not introduce new numbers during the comparison.

## Failure modes

Avoid these failures:

- Starting in the middle of the code path
- Showing variables before explaining the real event
- Using vague labels such as `input`, `old object`, or `both`
- Drawing a flowchart when nesting is the important relationship
- Drawing only boxes without the matching pseudocode
- Showing pseudocode without the matching process stage
- Adding too much text before the user responds
- Changing websites or applications without a request
- Using hand-drawn text instead of the text tool
- Claiming a hypothetical risk is the confirmed defect

## Success criteria

The session is successful when the board shows:

- The real process and exact code location
- One concrete example with stable values
- The state before the new event
- The line-by-line function path
- The exact line where behavior becomes wrong
- The wrong result and the correct result
- Important variables with their meaning and owner

The user should be able to explain the defect in their own words before the session ends.
