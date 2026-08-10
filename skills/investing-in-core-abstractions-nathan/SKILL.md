---
name: investing-in-core-abstractions-nathan
description: on why to invest heavily into core abstractions
---

"Even if all of your code is written with agents, you should invest time in thoughtfully curating your core abstractions, your third party dependencies, and the organization of your repository. 

This review should be done "by hand", though you can (and should) use agents to make any changes.

My experience is that the time spent doing this work yields far higher ROI than dumping yet-more blobs of markdown into skills, plugins or agent configuration.

Good abstractions and hierarchical organization of data exist because they optimize the human "context window", and they have the same effect on agents.

Agents are pretty good at pattern matching, and so establishing strong interface boundaries and code organization norms is a very token-efficient way to get agents to do the right thing. It also means that your skills/config can be more efficient, containing hints/pointers to help the agent leverage the code and structure you establish.

Agents change a lot, but many good practices remain just as good as they always were"