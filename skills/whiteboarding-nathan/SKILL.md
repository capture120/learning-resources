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

A unit is usually a single shape, relationship, or line of pseudocode (conrete values, variables, function names, etc).
The core is to do this as a human would. where you explain what you are doing write a single thing on the whiteboard, explain what is, and continue all of this building towards a high level explanation.

Do not draw the full solution before the user understands the starting state.
Do not give a spoken wall of text while the board stays unchanged.
For each iteration it's helpful to look at the style guidelines in the AGENTS.md

REMEMBER THE THING YOU MUST DO IS
-> talk out loud 
-> draw 1 thing on whiteboard
-> talk out loud
...
and loop this. all of this simulating how a human would talk about a topic, whiteboard it out, explain how that item relates to what they are referring to. then continue iteratively building the explanation and whiteboard over time. 

## Coding explanations
when you pseudocode / whiteboard code the most improtant thing to stay the same (not abstracted) are function signatures, function names, class names, variable names, types, interfaces.
the parts that can be abstracted in pseudocode is more likely to be functions, but if im debugging an issue step by step for example then the actual code values is important.
when giving examples always tell me what type it is, and when giving example values the values need to be concrete with types.
WHEN YOU TALK ABOUT DB TABLES YOU MUST USE THE EXACT TABLE VALUES AND DB VALUES. DO NOT MAKE ANYTHING UP.

## Verify before drawing

Inspect the current diff and the relevant code path first.

## Board structure

Use actual shapes, arrows, and text boxes.
Use text boxes for all written text.
Use freehand drawing only when a normal shape does not fit.
Do not draw text by hand.

Keep each section within a readable viewport. Avoid large empty shapes and extreme zoom changes.
Use nesting when the code contains nested data. Use arrows when the code moves through steps.

# tldraw specifics

- When the user asks for a new section, check whether the current view has enough empty space. If the current view does not have enough empty space, move to an empty area. Take a screenshot and confirm that the area is empty before drawing.
- Use Undo only when the change you want to reverse is certainly the latest tldraw history entry. Creating, deleting, editing, resizing, or moving a shape can create that entry, and some actions can share one entry. If another board change happened later, repair or delete only the shapes you changed.
- Whenever you write, Shift + L your objects so they do not get deleted. that way i can annotate over your shapes. 
- sometimes you'll need to reference existing items on the whiteboard while explaining. when you do this, annotate red lines to indicate what you are pointing at. THESE SHOULD NOT BE LOCKED. you should do the same flow where you reference an item and draw a red arrow to point to ti, explain it out loud, then continue on and erase the old arrow and use a new one if necessary (referencing a new thing on the whiteboard). the goal is to have this be a continous easy flow as if a real person was whiteboarding.
- DO NOT MAKE ANY OF HTE MAIN SHAPES OR LINES OR TEXT YOU ARE WRITING ON THE WHITEBOARD RED. RED IS ONLY FOR TEMPORARY ANNOTATIONS LIKE A RED LASER POINTER.
- DO NOT DESCRIBE WHAT YOU WILL DO ON WHITEBOARDING. JUST DO THE WHITEBOARDING. SAVE YOUR VOICE FOR EXPLAINING STUFF ON THE WHITEBOARD, AND WHAT YOU WHITEBOARDED MEAN. DONT DESCRIBE ANY MECHANICS OF TLDRAW