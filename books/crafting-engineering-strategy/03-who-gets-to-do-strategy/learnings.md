# Chapter 3: Who Gets to Do Strategy?

This chapter dismantles the widespread belief that you must be promoted into a senior role before you can work on engineering strategy. Larson argues that anyone in an organization can make meaningful progress on strategy; what changes by role is not whether you can do strategy, but which tactics are available to you. The single most important takeaway: strategy is accessible from anywhere in the organization, particularly if you are honest about the tools you actually have and thoughtful about how to use them — waiting until you're an executive to start is "a recipe for disaster."

## Core ideas

### The central claim: authority is not a prerequisite for strategy

Aspiring leaders commonly believe they need to be promoted before they can work on strategy. Larson calls this idea "fundamentally incorrect": you can work on strategy from anywhere in an organization; it just requires different tactics depending on where you sit. The chapter's frame is that everyone operates within constraints — engineers lack mandate power, executives are hemmed in by budgets, CEOs, peers, and teams — so the question is never "am I allowed to do strategy?" but "which mechanisms work from my position?"

### "Take five, then synthesize" (strategy for engineers without explicit authority)

Larson opens with why engineers miss their own options: it's easy to get so distracted by an executive's top-down approach to strategy that you convince yourself there aren't other approachable mechanisms. There are. The first is a two-stage approach introduced in Larson's earlier book *Staff Engineer*:

1. **Exploration**: document how five related current and historical decisions have actually been made in your organization.
2. **Synthesis**: combine those five documents into a diagnosis and a policy.

The why: this works without authorization because you are *naming the implicit strategy* — merely describing what's already happening — so "it's impossible for someone to reasonably argue that you're not empowered to do strategy." Once written, one of two things happens: the organization is comfortable with it (which means it *is* their current strategy), or it isn't, in which case you've forced a conversation about revising the approach. Creating awareness is often enough to drive strategic change, and it requires no executive sign-off.

Larson sometimes thinks of this as performing "strategy archaeology" (riffing on Vernor Vinge's "software archaeologists"): simply by recording what has happened in the past, you make it easier to understand the present and influence the future.

### "Model, document, and share" (when awareness alone is insufficient)

The second low-authority pattern, from *An Elegant Puzzle*:

1. **Model** the approach you want others to adopt. Make it easy for them to observe how you've changed the way you work.
2. **Document** the approach, the thinking behind it, and how to adopt it.
3. **Share** the document around. If people see you succeeding with the approach, they're likely to copy it.

This is explicitly an influence-based approach, and Larson preempts skepticism about that: even executive-driven strategies are highly dependent on influence.

### Strategy as an executive: more latitude, more constraints, fewer guardrails

The biggest misconception about executive roles — held by nonexecutives and by new executives "about to make a series of regrettable mistakes" — is that executives operate without constraints. In reality they operate under an extremely high number of constraints: budgets to meet, CEO visions to fulfill, peers to satisfy, a team to motivate. They can disappoint any of these temporarily but must satisfy all of them in the long term. Nonetheless, executives genuinely do have more latitude to mandate and cajole participation in the strategies they sponsor. (Larson notes that the strategy chapter of his *The Engineering Executive's Primer* is a brief summary of this entire book, but says little about how executive strategy differs from nonexecutive strategy — the gap this section fills.)

What genuinely differs for executives:

- **Mandates only matter if there are consequences.** Executives can mandate adherence to a strategy, which expands their policy options. An engineer can't block the promotion of someone who ignores their policy; an executive can. If an executive can't or won't enforce consequences for noncompliance, "it isn't a meaningful mandate."
- **Visibility and access.** Even without mandates, executives can use their access to the organization to advocate for their preferred strategy.
- **Neither mandates nor access improve diagnosis.** Both, however, often create the *appearance* of progress — which is why executive strategies can fail so spectacularly and endure so long despite failure.

The net effect, in Larson's experience: executives have an easier time *doing* strategy but a much harder time *learning to do it well*. They have fewer guardrails against serious mistakes, and the blast radius of a bad executive strategy reaches far beyond a bad engineer strategy. This is the why behind the chapter's warning: do not defer strategy practice until you reach the executive level.

### Strategy in other roles (product managers, etc.)

People outside engineering can still do engineering strategy, using an even more influence-driven approach. The engineering organization is generally right that it knows the most about engineering — but not always. A product manager may be a former engineer with deep relevant experience, and in genuinely novel areas (like the early adoption of LLMs), engineers don't know much either and benefit from outside perspectives.

### Strategy in challenging environments

Good strategies "accurately diagnose the circumstances and introduce policies that address those circumstances." Internal organizational limitations can undermine both halves, so the chapter names the failure environments and how to navigate each.

**Low-trust environments (diagnosis is blocked).** Two distinct cases:
- You're too inexperienced to diagnose well. The fix is not easy but is straightforward: do more strategy work to build expertise.
- You see the problems clearly, but the culture frowns on acknowledging them. This is a diagnosis problem rooted in low trust. The technique: *whisper the controversial parts* — translate difficult messages into softer, less direct versions that are acceptable to state. This can feel dishonest or like an ethical compromise if your goal is accountability, but the goal of strategy is to make better decisions, "an entirely different concern than holding folks accountable for the past." (Chapter 7 discusses this problem in more detail.)

**Poor-judgment environments (policy agreement is blocked).** Even with an excellent diagnosis, agreement may not follow. Distinguish two sources of disagreement:
- *Genuinely complex tradeoffs*: parties disagree with the chosen approach but everyone understands the conflicting priorities. These can culminate in compromises that don't make anyone particularly happy.
- *Poor judgment*: policy choices that simply don't make sense — sometimes poor technical judgment, sometimes people prioritizing their own interests over the company's. Here your strategy becomes an attempt to *educate* colleagues about the tradeoffs they're making.

When people disagree with your strategy, remember that most interesting problems require iterative solutions. Writing the strategy down and sharing it starts a process that can change the organization's mind, even if slowly.

**Missing strategies (ambiguity about what the rest of the company wants).** Leaders often decide they can't move forward until some upstream decision (e.g., layoff size under new ownership) is made. Larson is categorical: "getting blocked by ambiguity is always the wrong decision." Instead, accept the ambiguity as a fact in your diagnosis and work around it — adopt policies that are robust to the unknown now, and explicitly note that further action will follow once clarity arrives. "A missing strategy will always be part of your diagnosis, but it should never be a reason that you can't do strategy." Leadership means finding a way to move forward despite available justifications for not making progress.

### Who shouldn't do strategy?

In Larson's experience, there is almost never a reason you *cannot* do strategy, but there are two scenarios where doing it probably doesn't make sense:

1. **A "when" problem, not a "who" problem**: there's already so much strategy work happening that more would be a distraction. If another part of the organization is already working on the same problem, work with them directly rather than generating competing work. (This is the focus of the next chapter.)
2. **Wrong motivation**: you're trying to satisfy an emotional need for direct, immediate impact. Sharing a thoughtful strategy always drives progress, but often as slow, incremental change to the organization's beliefs. Even definitive top-down executive strategies get ignored in pockets of the organization, and bottom-up strategies spread slowly. Strategy work "requires a tolerance for winning in the long run, even when there's little progress this week or this quarter."

## Actionable guidance

- Don't wait for a title or explicit authorization to do strategy. Pick the tactics that match your actual position and trust level.
- As an engineer without authority, run "take five, then synthesize": document five related current and historical decisions, then synthesize them into a diagnosis and policy. Present it as a description of the existing implicit strategy. Let the organization either ratify it or be forced into a revision conversation.
- When awareness alone doesn't move people, run "model, document, and share": change your own way of working visibly, write up the approach and the reasoning and how to adopt it, then circulate it so others can copy your success.
- As an executive, only issue mandates you can and will enforce. A mandate without consequences is not a mandate.
- As an executive, don't mistake visibility and mandate power for diagnostic ability: neither improves your ability to diagnose problems — they only create the appearance of progress.
- Build strategy skill before reaching the executive level, where mistakes are larger and guardrails fewer.
- If your diagnosis skill is the bottleneck, do more strategy work; expertise comes from practice.
- In low-trust cultures, whisper the controversial parts: soften politically unacceptable statements until they can be said, because the purpose of the document is better future decisions, not assigning blame for the past.
- When colleagues disagree out of poor judgment or self-interest, treat the strategy document as an educational tool that makes the tradeoffs they're choosing explicit.
- Never let upstream ambiguity block you. Write the ambiguity into your diagnosis as a fact, adopt policies that work under that uncertainty, and recognize that additional actions will be needed once clarity arrives.
- Expect iteration. Write the strategy down, share it, and accept that changing organizational minds is a slow process; don't get discouraged by slow initial uptake.
- Before starting strategy work, check whether someone else is already working the same problem. If so, join them instead of competing.
- Self-check your motivation: if you need immediate, visible impact, strategy is the wrong outlet. Commit only if you can tolerate winning over quarters and years.
- When a diagnosis seems obvious to you and yet people don't agree, consider that you may be wrong — specifically, check whether you've mapped everyone onto the Karpman Drama Triangle roles of persecutor, rescuer, and victim, which distorts otherwise well-understood situations.

## Pitfalls and misconceptions

- **"I need to be promoted before I can do strategy."** The chapter's central target. False: every level has workable tactics; only the tactics differ.
- **"Executives operate without constraints."** They operate under an extremely high number of constraints (budgets, CEO visions, peers, team) and must eventually satisfy all of them.
- **Unenforced mandates.** Mandating a strategy without enforcing consequences produces a hollow mandate that changes nothing.
- **Mistaking access for accuracy.** Executive visibility and mandate power create the appearance of progress without improving diagnosis, which lets bad executive strategies fail spectacularly yet persist for a long time.
- **Waiting to learn strategy until you're an executive.** Easier-looking from a distance, but consequences are larger and guardrails fewer — "a recipe for disaster."
- **Getting blocked by ambiguity.** Treating a missing upstream strategy as a reason to do nothing is "always the wrong decision."
- **The Karpman Drama Triangle.** When Larson has been obviously wrong about things he understands well, it's usually because he's cast the parties as persecutor, rescuer, and victim.
- **Generating competing strategy work.** Adding more strategy when the same problem is already being worked is a distraction; collaborate instead.
- **Strategy as ego gratification.** Doing strategy to satisfy a need for immediate impact sets you up for discouragement, because even good strategies spread slowly and unevenly.
