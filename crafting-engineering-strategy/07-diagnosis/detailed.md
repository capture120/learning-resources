# Chapter 7: Diagnosis — Detailed Reference

## Introduction

Once you've written your strategy's exploration (the prior step in the strategy process), the next step is working on its diagnosis. Diagnosis is about understanding the constraints and challenges your strategy needs to address. In particular, it's about slowing yourself down from jumping to solutions before fully understanding the nuances and constraints of the problem.

You may find yourself wanting to skip the diagnosis phase — the urge of "let's get to the solution already!" Larson counters this directly: every strategy he has seen fail did so due to a lazy or inaccurate diagnosis. "It's very challenging to fail once you have a proper diagnosis, and it's almost impossible to succeed without one."

The chapter covers, in order:

- Why diagnosis forms the foundation of an effective strategy, and why effective policies depend upon it
- Why skipping the diagnosis phase consistently ruins strategies
- How to diagnose your strategy's circumstances, step by step
- How to incorporate data into your diagnosis effectively
- Where to focus on adding data
- How to deal with controversial elements of your diagnosis, such as pointing out that your own executive is one of the challenges
- Why it's more effective to view difficulties as part of the problem to be solved than as obstacles blocking forward progress
- Why humility and self-awareness are crucial to making an effective diagnosis

## Diagnosis Is Strategy's Foundation

One of the challenges in evaluating strategy is that, after the fact, many effective strategies are so obvious that they're boring. Similarly, most ineffective strategies are so clearly flawed that their authors look lazy. The reason for both: as you operate a strategy, the reality around it becomes clear. While you're writing your strategy, you don't know if you can convince your colleagues to adopt a new approach to specifying APIs; a year later, though, you know very definitively whether it's possible. (This example — adopting a new approach to specifying APIs — illustrates the kind of uncertainty that resolves through operating the strategy.)

Definition: diagnosis is your attempt to correctly recognize the problem that the strategy needs to solve *before* deciding on the policies to address that problem. Done well, the subsequent steps of writing strategy often feel like an afterthought — which is why Larson thinks of diagnosis as strategy's foundation.

A key contrast with the preceding phase: where exploration was an evaluation-free activity, diagnosis is all about evaluation. The kinds of evaluative questions diagnosis asks:

- How do teams feel today?
- Why did that project fail?
- Why did the last strategy go poorly?
- What distractions must you overcome to make this new strategy successful?

That said, not all evaluation is equal. If you state your judgment directly, it's easy to dispute. An effective diagnosis is hard to argue against because it's "a web of interconnected observations, facts, and data." Even those who dislike your conclusions will find the weight of evidence hard to shift.

Note (cross-reference): strategy testing, explored in Chapter 8, takes advantage of the reality that it's easier to diagnose by doing than by speculating. It proposes using a recursive diagnosis process until you have real-world evidence that the strategy is working.

## How to Develop Your Diagnosis

Your strategy is almost certain to fail unless you start from an effective diagnosis — but how to build that diagnosis is often left unspecified. That's because, for most people, diagnosis is a dark art: "unspecified, undiscussed, and uncontrollable." Larson admits he has been guilty of this himself: his earlier book *The Engineering Executive's Primer* contains a chapter on strategy that is notably silent on how to perform diagnosis.

He concedes there is some truth to the idea that diagnosis is an emergent, organic process rather than a structured, mechanical one. However, over time he has come to adopt a fairly structured approach, in five steps:

### Step 1: Braindump

Starting from a blank sheet of paper, write down your best understanding of the circumstances that inform your current strategy. Then set that piece of paper aside for the moment.

### Step 2: Summarize exploration

On a new piece of paper, review the contents of your exploration. Pull in every piece of diagnosis from similar situations — internal or external — that resonates with you. For each diagnosis, tag whether it fits your current circumstances perfectly or needs to be adjusted. Then, once again, set the piece of paper aside.

### Step 3: Mine for distinct perspectives

Devote yet another blank page to talking to different stakeholders and colleagues who you know are likely to *disagree* with your early thinking. Your goal is not to agree with this feedback; it's to understand their views. *The Crux* by Richard Rumelt (PublicAffairs, 2022) anchors diagnosis in this approach, emphasizing the importance of "testing, adjusting, and changing the frame, or point of view."

### Step 4: Synthesize views into one internally consistent perspective

Sometimes the different perspectives you've gathered don't mesh well. People might explicitly differ in what they believe the underlying problem even is — as is typical of the common tension between platform and product engineering teams. The goal is to represent each of these perspectives competently in the diagnosis, *even the ones you disagree with*, so that later on you can evaluate your proposed approach against each of them.

When synthesizing feedback goes poorly, it tends to fail in one of two ways:

1. **The author's opinion shines through so strongly that it renders the diagnosis suspect.** Your goal isn't to agree with every perspective, nor should your diagnosis crown one viewpoint as correct: readers should see detailed perspectives without clearly sensing the author's biases.
2. **A group tries to own the synthesis jointly, but creates fractured perspectives rather than a unified one.**

Larson generally finds that holding one author accountable for representing all views works best to address both of these failure modes.

### Step 5: Test drafts across perspectives

Once you've written your initial diagnosis, sit down with the people you expect to disagree most fervently. Iterate with them until they agree that you've accurately captured their perspectives.

Even if they disagree with some viewpoints, they should be able to agree that others hold those views — the bar is accurate representation, not consensus on each view.

If a stakeholder argues that the data you've included doesn't capture their full reality, you have to pick between two options: collect more data to address their concern, or document their disagreement that the data presented is comprehensive. Collecting more data to address concerns is the preferred option, but you have to be careful not to allow requests for data to prevent forward progress indefinitely: fulfill one or two requests per stakeholder, but hold the line at delaying further.

### Calibration: directionally correct, not perfectly correct

Don't worry about getting the details perfectly right in your initial diagnosis. You're trying to get "the right crumbs" to feed into the next phase, strategy refinement. Allowing yourself to be directionally correct rather than perfectly correct makes it possible to cover a lot of territory quickly. Getting caught up in perfecting the details is an easy way to anchor yourself in one perspective prematurely.

### Adapting the recipe

As with any of Larson's recipes for strategy creation: if these steps feel overly mechanical to you, adjust them to something that feels more natural and authentic. There's no perfect way to understand complex problems. That said, if you feel uncertain or are skeptical of your own track record, he encourages you to start with the structured approach above.

## Incorporating Data into Your Diagnosis

Example: the diagnosis behind Stripe's creation of Sorbet (discussed in Document 22-3) includes data to help readers understand the author's reasoning — such as staffing numbers for relevant teams and the extent of test coverage in the Ruby codebase.

Why data matters: if everyone has the same data and the same assumptions about how that data is likely to change going forward, then evaluating the strategy becomes vastly simpler. Data is also your mechanism for supporting or critiquing the various views that you've gathered when drafting your diagnosis; to an impartial reader, "data will speak louder than passion."

Decision rules for where to add data:

- If you're confident that a perspective is true, include a data narrative that supports it.
- If you believe another perspective is overstated, include any data that the reader will require to come to the same conclusion themselves.

Presentation rule: do your best to include data *analysis*, with a link out to the full data, rather than requiring readers to interpret the raw data themselves while reading. As your strategy document travels further, there will be inevitable requests for different cuts of data to help readers understand your thinking; you can prevent this somewhat by linking to your original sources.

Expect missing data: in strategy work, it's common to find that much of the data you want doesn't currently exist. After all, if you already had the data to make the decision easy, you probably would have already made a decision rather than needing to run a structured thinking process. (The next chapter, Chapter 8 on refining strategy, covers tools for building confidence in low-data environments.)

## Whisper the Controversial Parts

### The bar-raiser story

Larson once worked for a company that rolled out a "bar-raiser" program, styled after Amazon's, that aimed to improve the quality of new hires by requiring an interviewer from outside the team to approve every hire. He spent some time arguing against adding this additional step: he didn't understand the problem the company was solving for, and management seemed surprisingly uninterested in learning whether the new process actually improved hiring outcomes.

What he didn't realize until much later: most of the senior leadership distrusted one of their peers and felt that the CTO wasn't holding that leader accountable. They had rolled out the bar-raiser program *solely* to create a mechanism to control that manager's hiring decisions. (Larson also learned that these leaders didn't care much about implementing the policy, resulting in hiring managers frequently ignoring the bar-raisers' rejections — a topic deferred to Chapter 10.)

What this demonstrates: it's a good example of a strategy that makes sense when you have the full diagnosis but makes little sense without it. It's also a case where stating part of the diagnosis out loud is nearly impossible: even senior leaders are not generally allowed to write a document that says, "The Director of Product Engineering is a bad hiring manager."

### The dilemma and its resolution

When writing a strategy, you'll often find yourself choosing between two awkward options:

1. Say something awkward or uncomfortable about your company or someone working within it, or
2. Omit a critical piece of your diagnosis that's necessary to understanding your wider thinking.

Larson's advice whenever you encounter this dilemma: find a way to include the full diagnosis, but reframe the difficult part into a palatable statement that avoids casting blame too narrowly.

### Example 1: Private equity strategy (Chapter 18)

The strategy for navigating private equity ownership, discussed in Chapter 18, has a diagnosis that includes:

> Based on general practice, it seems likely that our new Private Equity ownership will expect us to reduce R&D headcount costs through a reduction. However, without concrete details, we cannot yet make structured decisions. Our strategy will depend significantly on the scale of any proposed reductions.

The authors of this strategy are probably upset about the likely possibility that their new private equity ownership will eliminate colleagues. They may also be upset that, with no clear plan for what they need to do, they are stuck preparing for a wide range of potential outcomes. However they feel, though, their diagnosis sticks to precise, factual statements.

### Example 2: Uber service migration strategy (Document 16-1)

> Within infrastructure engineering, there is a team of four engineers responsible for service provisioning today. While our organization is growing at a similar rate as product engineering, none of that additional headcount is being allocated directly to the team working on service provisioning. We do not anticipate this changing.

The team didn't agree that their headcount should not be growing, but it was the reality they were operating in. They acknowledged that reality with a factual statement, without any additional commentary.

### The lesson from both examples

In both examples, the authors found professional, nonjudgmental ways to acknowledge the circumstances that had created the problems they were solving. The authors would have preferred that the leaders behind those decisions take explicit accountability for them — but attempting to make that happen within their strategy writeup would have undermined the strategy work itself.

Excluding critical parts of your diagnosis makes your strategies particularly hard to evaluate, copy, or recreate. To make the strategy effective, find a way to say things politely. "Strategies are always more about realities than ideals."

## Reframe Blockers as Part of Your Diagnosis

When Larson works with early-career leaders, they often argue that a certain problem they've identified makes strategy work impossible. For example, they might argue that they can't do strategy work at their current company because the members of the executive team change their minds too often.

That core insight is almost certainly true, but it's much more powerful to reframe it as a diagnosis: "If we don't find a way to show concrete progress quickly and use that to excite the executive team, our strategy is likely to fail." This transforms the thing preventing your strategy into a condition your strategy needs to address.

The general rule: whenever you run into a reason why your strategy — or strategy overall — seems difficult or unlikely to work, you've found an important piece to include in your diagnosis. "There are never reasons why strategy simply cannot succeed — only diagnoses you've failed to recognize."

Example: in the strategy for resourcing Engineering-driven projects at Calm, discussed in Document 21-2, the authors knew that Calm's informal approach to prioritization wasn't going to change. Even if they convinced their peers in product management to change how they planned, the executive team's informal planning wasn't going to change. Rather than preventing them from implementing a strategy, those dynamics clarified what sort of approach could actually succeed.

## The Role of Self-Awareness

Every problem of today is partially rooted in the decisions of yesterday. If you've been with your organization for any duration at all, this means that you are — directly or indirectly — responsible for a portion of the problems that your diagnosis ought to recognize.

Recognizing the impact of your prior actions in your diagnosis is a powerful way to demonstrate self-awareness. It also suggests that your next strategy's success will be rooted in your self-awareness about your prior choices. Don't be afraid to recognize the failures in your past work.

The closing distinction: "changing your mind without new data is a sign of chaotic leadership," while "changing your mind with new data is a sign of thoughtful leadership."

## Summary

Because diagnosis is the foundation of effective strategy, Larson has always found it the most intimidating phase of strategy work. He considers that a somewhat unavoidable reality, but hopes the chapter has somewhat prepared the reader for the challenge.

The four most important things to remember:

1. Form your diagnosis before deciding how to solve it.
2. Try especially hard to capture perspectives you initially disagree with.
3. Supplement intuition with data where you can.
4. Accept that sometimes the data you need will be missing.

The last point in particular — accepting missing data — is why many good strategies never get shared. It is also the topic of the next chapter (Chapter 8, on refining strategy).
