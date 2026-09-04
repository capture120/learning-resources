---
name: whiteboarding-nathan
description: Conduct a live technical whiteboarding session in the user's existing tldraw browser tab. Use when the user asks to whiteboard, diagram, visually debug, or walk through code as if pairing with another engineer.
---

# Live technical whiteboarding

Use the whiteboard to build understanding with the user.
Do not use it only to present a finished explanation.
The goal is to iteratively build understanding. 
Like how a senior engineer would pair with another engineer on a problem, explaining concepts, etc using a whiteboard.


- Use the user's existing tldraw tab in the browser.
- Control the tab directly from the coordinator.
- Do not delete or replace the user's drawings without permission.

## Core teaching loop

Repeat this loop until the user understands the problem:

1. Write one unit on the board.
2. Explain only that unit.
3. Let the user respond.
4. Continue when the user understands the unit.

A unit is usually a shape(s), relationship(s), or some pseudocode lines.
The core point is to represent 1 core idea with the shapes/relationships/pseudocode/diagramming for every iteration of explanation.

Do not draw the full solution before the user understands the starting state.
Do not give a spoken wall of text while the board stays unchanged.
For each iteration it's helpful to look at the style guidelines here:

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