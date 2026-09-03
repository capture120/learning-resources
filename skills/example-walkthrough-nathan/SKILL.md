---
name: example-walkthrough-nathan
description: walk through an example in code showing state. use to explain code
---
- for the given toy snippet. give a one sentence high level idea of what the impact/purpose of the code does (NOTE: NOT HOW IT IS IMPLEMENETED). then, give me a simple toy example input and output + the type signature (it's okay if not actually a function)
- then, walk me through a specific toy example so i can get intuition about the code. do this for the full code path i selected (the prior was just giving me initial intuitions)
- in the toy example, show the state at each part of the code.
- the example should be inlined with comments and each part of the example is next to its corresponding code.
- for code walkthroughs still use variables, etc to represent the comments. 
- think of it similar to walking through state during a leetcode/dsa/algo interview. as if you were explaining your code flow to an interviewer.
- put the actual toy values in comments right next to every line that uses, creates, or changes them.
- every variable needs a concrete value in a comment right next to the line where the code uses it.
- Use a full concrete toy value beside every variable assignment, assignment, mutation, etc. NON-NEGOTIABLE SKIP THIS IDK WHY. do `// NAME_OF_VARIABLE = VALUE`

ensure the values are simple as possible while still maintaining full usefullness / relevance to the code.

toy examples simplify unneeded complexity while traversing all of the core logic.

toy examples lets one focus on the most improtant thinking.

make sure all toy examples are concrete values though.. eg in code use concrete values in the shape youd see them when running the code. the toy part for example is a list being smaller but the shape of the elements still exist.

if the example relevant goes beyond code, use similar principles. 
this should be general enough to be unviersally applicable for anything that would benefit from examples. 
eg. finance, health, maths etc. anything with multi-step thinking that has some state mutating over time and conditional logic.

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