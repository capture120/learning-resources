---
name: agent-dev-nathan
description: advice for building agents. prompting, tool calls, multi-agent, etc.
---

"""
Give [your agent] as little instruction as possible. Give it the tools to load context instead.

A few lessons:
→ Start with a basic prompt and give the agent tools to find the context it needs
→ Nail one or two use cases first, then expand based on how people actually use the agent
→ Prove out a core workflow with the best model, then optimize for cost
"""

Give agents goals so they can hill climb in the right direction
Do not be over-precise with implementation details.
Let agents loop until they reach the goal.
The success criteria should be very precise and detailed so the agent doesn't exit prematurely.
You must give the agents away to verify their work and confirm the success criteria. Otherwise the goals will not be as useful.