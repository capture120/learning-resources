---
name: code-quality-nathan
description: skill to evaluate code quality. function names, code comments, variable names, etc.
---

<code_quality>
I care a lot about clean abstractions, readability, maintainability, code quality, and extendibility of code.

A function should not have to know about other functions. Same with files.

Adhere strongly to the single responsibility principle. 

Every file, function, class, and directory name should have a single purpose.

Code names should be self-documenting. 

A dev should be able to only read file/function/class names and immediately understand the purpose.

If it's not immediately obvious to understand what a file does, that is a sign that SRP is being violated.

Function names must describe what the function does or the purpose of the function.

Function names should be clear enough where a developer understands the purpose without reading any code. 

!!! A name can be long if that's what it takes for the purpose to be immediately obvious.

Do not use single letter variables.

Reuse existing functionality.

Adhere to established patterns.

Don't introduce new patterns without discussion.

Prefer dependency injection and composition over static coupling or hidden globals.

Assume the reader reads code from top to bottom.

Structure code so that a user reading from top to bottom can understand the file/function/class easily.

The code structure should accomodate for developers that read code linearly.

The logical flow of code must be from top to bottom.

All code should read like a paragraph and be intuitive from top to bottom

Every file reads like a paragraph. 

Put the main most important function in the file near the top (global constants above, function specific constants below, function specific interfaces above their respective functions, interfaces types at top). 

Put the functions it calls below it, in the order they are called. 

Put low-level details at the bottom. A reader should never encounter a function before they understand why it exists.

The same principles apply at the class and function level.

</code_quality>

<comments>
*Comments should be readable 6 months from now with no context and should be intuitive and easily understandable.*

Do not assume a user has context onto what is going on with your comments.

If a dev reads the comment and never reads the code, they'd still understand what is going on.

Do not focus on how the code is implemented. 

Focus on the impact of WHAT the code does.

NAME THE SUBJECT: when a comment refers to something, call it by its name. 

NEVER use vague words ("this", "that part", "it", "such cases") or second person ("you", "your").

EXPLAIN THE FEATURE AND HOW THE USER USES IT: a comment on a core state variable, type, or function explains the feature in product terms first.

State what the user does and what the user sees first.

Open with the user-facing purpose.

ASSUME ZERO CONTEXT: write every comment for a dev who knows nothing about the file, the feature, or the domain.

A new dev who reads the variable must understand what the feature is from the comment alone, without reading other code.

Define each domain term the first time the comment uses it.

Comments should be as small as possible, while still retaining core meaning.

Comments should follow the same principles of a good function name.

Comments should be easy to read.

Comments should tell a dev what code does without them needing to read implementation code.

Quick test - read only the comment:
- If the comment tells you the impact of the code, keep it
- If the comment tells you why, or sets up context first, rewrite starting with the most important impact.
</comments>