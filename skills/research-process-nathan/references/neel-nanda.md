# Explore Understand Distill
https://www.alignmentforum.org/posts/hjMy4ZxS5ogA9cTYK/how-i-think-about-my-research-process-explore-understand

## Introduction

Research, especially in a young and rapidly evolving field like mechanistic interpretability (mech interp), can often feel messy, confusing, and intimidating. Where do you even start? How do you know if you're making progress? When do you double down, and when do you pivot?

These are far from settled questions, but I’ve supervised 20+ papers by now, and have developed my own mental model of the research process that I find helpful. This isn't the definitive way to do research (and I’d love to hear other people’s perspectives!) but it's a way that has worked for me and others.

My goal here is to demystify the process by breaking it down into stages and offering some practical advice on common pitfalls and productive mindsets for each stage. I’ve also tried to be concrete about what the various facets of ‘being a good researcher’ actually mean, like ‘research taste’ (see post 3). I’ve written this post for a mech interp audience, but hopefully it is useful for any empirical science with short feedback loops, and possibly even beyond that.

This guide focuses more on the strategic (high-level direction, when to give up or pivot, etc) and tactical (what to do next, how to prioritise, etc) aspects of research – the "how to think about it" rather than just the "how to do it." Some of skills (coding, reading papers, understanding ML/mech interp concepts) are vital for how to do it, but not in scope here (I recommend the ARENA curriculum and my paper reading list if you need to skill up).

How to get started? Strategic and tactical thinking are hard skills, and it is rare to be any good at them when starting out at research (or ever tbh). The best way to learn them is by trying things, making predictions, seeing what you get right or wrong (i.e., getting feedback from reality), and iterating. Mentorship can substantially speed up this process by providing "supervised data" to learn from, but either way you ultimately learn by doing.

I’ve erred towards making this post comprehensive, which may make it somewhat overwhelming. You do not need to try to remember everything in here! Instead think of it more as a guide for the high level things to keep in mind, and a source of advice for what to do at each stage. And, obviously, this is massively flavoured by my own subjective experience and may not generalise to you - I’d love to hear what other researchers think.

A cautionary note: Research is hard. Expect frustration, dead ends, and failed hypotheses. Imposter syndrome is common. Focus on the process and what you're learning. Take breaks, the total change to productive time is typically positive. Find sustainable ways to work. Your standards are likely too high.

## The key stages

I see research as breaking down into a few stages:

1. Ideation - Choose a problem/domain to focus on
2. Exploration - Gain Surface area
   - North star: Gain information
3. Understanding - Test Hypotheses
   - North star: Convince yourself of a key hypothesis
4. Distillation - Compress, Refine, Communicate
   - North star: Compress your research findings into concise, rigorous truth that you can communicate to the world

### Ideation (Stage 1): Choose a problem

- This can vary from a long, high-effort exploration across areas looking for a promising angle, to just being handed a problem by a mentor.
    - Replicating and extending an existing paper can be a good starting point, especially if you don’t have an existing mentor.
- This stage is crucial, but if you have a mentor (or other high quality source of suggestions, like someone else’s research agenda) it can be quick to just lean on them.
- It's important to understand how your work fits into the existing literature: what is already known about the problem and what remains open.
    - Where possible, for your first project or two, lean on a mentor for guidance and just read a few key papers. Building deep knowledge of a literature takes time, and is easier once you have some hands-on experience.
    - Google/OpenAI Deep Research is invaluable for literature reviews, especially in unfamiliar domains.
- Doing this well yourself and choosing a good problem often requires "research taste", and is the most commonly discussed aspect, but is just one facet of what research taste means - research taste also covers the following:
    - Exploration: Noticing when an anomaly is interesting and should be investigated, vs boring and to be ignored
    - Understanding: Designing great experiments that precisely distinguish hypotheses. This often stems from having a deep enough conceptual understanding to intuit why a hypothesis is true
    - Distillation: Having the taste to identify the most interesting and defensible narrative, and what to deprioritise.
    - On a broader level, I see research taste as being about an intuitive understanding of what good research looks like, to both guide high level strategy and tactical decisions in practice, informed by a deep understanding of the domain, familiarity with what good and bad research looks like, and the high level strategic picture of which problems actually matter.

### Exploration (Stage 2): Gain surface area

- Examples: My research streams, and my Othello research process write-up
- At the start, your understanding of the problem is often vague. Naively, it’s easy to think of research as being about testing specific hypotheses, but in practice you often start out not even knowing the right questions to ask, or the most promising directions. The exploration stage is about moving past this.
    - E.g. starting with “what changes in an LLM during chat fine-tuning?” or even “I’m sure there’s something interesting about how chat models behave, let’s mess around and find out”
- Your north star is just to gain information - do exploratory experiments, visualise data, follow your curiosity, prioritise moving fast.
- Junior researchers often get stuck in the early stages of a project and don’t know what to do next. In my opinion this is because they think they are in the understanding stage, but are actually in the exploration stage.
    - That is, they think they ought to have a clear goal, and hypothesis, and obvious next step, and feel bad when they don’t. But this is totally fine and normal!
    - The solution is to have a toolkit of standard ways to gain surface area, brainstorm experiments that might teach something interesting, and be comfortable exploring a bunch and hoping something interesting happens.
- Not having a clear goal/next step doesn’t mean that you don’t need to prioritise! Prioritise for information gain.
    - Try to do a lot of experiments (and don’t be a perfectionist about finding the ‘best’ experiments!), visualise things in many different ways, ensure you’re always learning.
    - Frequently ask yourself “am I getting enough information per unit time?” If you haven’t learned anything recently, shake it up.
    - Having fast feedback loops and powerful, flexible tooling is absolutely crucial here.
- Note: In the long-term exploration should feel like play - be fascinated by a problem, follow your curiosity, try to understand it deeply, zooming out when you get bored, etc (though it's still worth checking in on whether you're in a rabbit hole). But this isn't something you should worry about at first, as it needs well calibrated intuitions, which take time.
- Note: often most of the work in the exploration was about discovering the right kinds of questions to be asking, e.g. that where information was stored is an important and interesting question, crystallising that into a precise hypothesis is often easy after that.
    - This both means ‘identify the right questions to ask’, but also gain a deeper understanding and intuition of the domain so you can design experiments that make sense, and build a more gears-level model of why a certain question may or may not be true.
- A key practical tip is to keep a highlights doc of particularly interesting results, this makes it easier to spot connections

### Understanding (Stage 3): Test Hypotheses

- This stage begins when you understand the problem domain enough to have some specific hypotheses that you think are interesting - hypotheses you can write down, and have some idea of what evidence you could find to show if they’re true or false.
    - E.g. “do chat models store summarised information about the user prompt in the `<end_of_turn>` special token?”
- Your north star is to gain evidence for and against these hypotheses
    - Here the prioritisation is a mix of goal-directed and exploratory - you often need to briefly dip back into explore mode as you realise your hypothesis was ill-posed, your experiment didn’t make sense, you get weird and anomalous results, etc.
    - This stage is much closer to what people imagine when thinking about research.
    - Frequently ask yourself “what am I learning and is it relevant?”
- The mark of a good researcher is a deep commitment to skepticism of your results.
    - You’ll have hypotheses that are wrong, experiments that are inconclusive, beautiful methods that lose to dumb baselines, etc. This is totally fine and normal, and a part of the natural process of science, but emotionally can be pretty hard to accept.
    - This sounds obvious, but in practice this requires constant active effort, and if you are not actively doing this you’ll inevitably fall into traps. Always seek alternative explanations, seek and implement strong baselines, check for bugs, etc.
- A surprisingly deep and nuanced skill is designing good experiments. I think of this as one facet of “research taste”
    - A great experiment elegantly, and conclusively distinguishes between several plausible hypotheses, validates non-trivial predictions made by one hypothesis, and is tractable to implement in practice.
        - This is an ideal rarely reached in practice but helpful to have in mind
    - My internal experience when generating good experiments is often that I try to simulate the world where hypothesis X is true, think through what this would mean and all the various implications of this, and notice if any can be turned into good experiments.
    - When reading papers, pay attention to the key experiments that their core claims hinge upon and ask yourself what made it important and how you might've thought of that experiment.

### Distillation (Stage 4): Compress, Refine, Communicate

- This stage begins when you have enough evidence for you to be fairly convinced that your hypotheses are true/false
- The north star here is to distill your research findings into concise, rigorous truth that you can communicate to the world
    - Compress your work into some concrete, well-scoped claims - something you could list in a few bullet points. Compress it as far as you can without losing the message. Readers will not take away more than a few claims.
        - How would you explain your work to a peer? How would you write a lightning talk?
    - Refine your evidence into a rigorous case for each key claim, enough to be persuasive to a skeptical observer
        - This is persuasive in the sense of “actually provide strong evidence”, not just writing well enough that people don’t notice flaws! This means sanity checks, statistical robustness, and strong baselines.
        - Note that this is a higher bar than convincing yourself, both since you’re aiming for a more skeptical observer and you need to make all the key evidence you’ve seen legible to an outsider.
        - You should spend a lot of time on red-teaming here - what could you be missing? What alternative hypotheses could explain your observations? What experiments could distinguish between them? Etc
    - Communicate these with a clear and concise write-up - make clear what your points are, what evidence you provide, and its limitations. Write to inform, not persuade - if you are clear (a high bar), and your results are interesting, people will likely appreciate your work.
        - The form of write-up doesn’t really matter - Arxiv paper, blog post, peer-reviewed paper, etc. It doesn’t need to be polished, it just needs to present the evidence clearly, and to have strong enough evidence to meaningfully inform someone’s opinion
- People often under-rate this stage and think doing the write-up is wasting time better spent on research, and can be left to the last minute. I think it’s actually a great use of time, at least for the first draft! I typically recommend my scholars make a start on distillation a month before conference deadlines.
    - Writing things up forces you to clarify your understanding to yourself. You also often notice holes and missing experiments. A common anecdote is that people didn’t really understand their project until they wrote it up.
    - If you don’t communicate your research well, it’s very hard to have an impact with it! (or to get recognition and career capital)
- Conversely, people often over-rate this stage and default to writing a paper with the main goal of getting accepted to a conference. This has obvious advantages, but can also lead to warped thinking if you’re thinking about it from the start.
    - E.g. choosing questions that look good rather than being important, or focusing on forms of evidence that reviewers will like or understand, rather than ruthlessly focusing on actually establishing what’s true.
- Sometimes you’ll discover that actually things are way messier than thought. It’s important to acknowledge this, rather than denying inconvenient truths! Your ultimate goal is to find truth, not to produce an exciting paper. You may need to go back to understanding or even exploration - this is totally fine and normal, and does not mean you’ve screwed anything up.


# Truth-Seeking, Prioritisation, Moving Fast
https://www.alignmentforum.org/posts/cbBwwm4jW6AZctymL/my-research-process-key-mindsets-truth-seeking

I think the most important mindsets are:

- Truth-seeking: By default, many research insights will be false - finding truth is hard. It’s not enough to just know this, you must put in active effort to be skeptical and resist bias, lest you risk your research being worthless.
- Prioritisation: You have finite time, and a lot of possible actions. Your project will live or die according to whether you pick good ones.
- Moving fast: You have finite time and a lot to do. This doesn’t just mean “push yourself to go faster” - there’s a lot of ways to eliminate inefficiency without sacrificing quality.
    - In particular, you must learn to act without knowing the “correct” next step, and avoid analysis paralysis.

Warning: It is extremely hard to be anywhere near perfect on one of these mindsets, let alone all three. I’m trying to describe an ideal worth aiming towards, but you should be realistic about the amount of mistakes you will make - I certainly am nowhere near the ideal on any of these! Please interpret this post as a list of ideals to aim for, not something to beat yourself up about failing to meet.

## Truth Seeking

Our ultimate goal in doing research is to uncover the truth about what’s really going on in the domain of interest. The truth exists, whether I like it or not, and being a good researcher is about understanding it regardless.

- This sounds pretty obvious. Who doesn't like truth? It’s easy to see this section, dismiss it as obvious and move on. But in practice this is extremely hard to achieve.
    - We have many biases that cut against finding truth
    - Insufficient skepticism doesn't feel like insufficient skepticism from the inside. It just feels like doing research.
- This means that you must be putting in constant active effort into ensuring your results are robust. This must be integrated into part of your research process - if you’re not, then there’s a good chance your results are BS.
    - “Just try harder to be skeptical” is empirically a fairly ineffective strategy
    - One of the most common reasons I dismiss a paper is because I see a simple and boring explanation for the author’s observations, and they didn’t test for it - this often renders the results basically worthless.
        - I’d estimate that at least 50% of papers are basically useless due to insufficient skepticism

What does putting in active effort actually mean?

This takes different forms for the different stages:

- For exploration, the key failure mode is not being creative enough when thinking about hypotheses, getting attached to one or two ideas, and missing out on what’s actually going on.
    - Resist the urge to move on to the understanding stage the moment you have a plausible hypothesis - are there any unexplained anomalies? Could you do more experiments to gain more surface area first? What other hypotheses could explain your results? Etc
    - The standard hypothesis testing framework can be misleading here, because it has an implicit frame of being able to list all the hypotheses. But actually, most of your probability mass should normally be on “something I haven’t thought of yet”
        - You should regularly zoom out and look for alternative hypotheses for your observations. Asking another researcher, especially a mentor is a great source of perspective, asking LLMs is very cheap and can be effective.
        - That said, I still often find it helpful to think in a Bayesian way when doing research - if I have two hypotheses, how likely was some piece of evidence under each, and how should I update? Exploration often finds scattered pieces of inconclusive evidence, and there’s a skill to integrating them well.
    - It’s not too bad if you end up believing false things for a bit, the key thing is to move fast and reflexively try to falsify any beliefs you form, so you don’t get stuck in a rabbit hole based on false premises. This means it’s totally fine to investigate case studies and qualitative data, e.g. a deep dive into a single prompt.
        - If you’re getting lots of (diverse) information per unit time you’ll notice any issues.
    - It is also an issue if you are too skeptical and don’t let yourself explore the implications of promising but unproven hypotheses, as this is crucial to designing good experiments
- For understanding, you want to be careful and precise about what your experiments actually show you, alternative explanations for your results, whether your experiments make sense on a conceptual level, etc.
    - Here the Bayesian frame is often helpful. It’s generally overkill to put explicit numbers on everything, but it reminds me to ask the question “was this observation more likely under hypothesis A or B”, not just whether it was predicted by my favourite hypothesis
    - In exploration it’s OK to be somewhat qualitative and case study focused, but here you want to be more quantitative. If you must do qualitative case studies, do them on randomly sampled things, (or at least several examples, if your sampling space is small) )since it’s so easy to implicitly cherry-pick
        - The one exception is if your hypothesis is “there exists at least one example of phenomenon X”, e.g. ‘we found multidimensional SAE latents’.
- For distillation, in addition to the above, it’s important to avoid the temptations of choosing a narrative that looks good, rather than the best way to communicate the truth.
    - E.g. publishing negative results
        - While it can be emotionally hard to acknowledge to myself that my results are negative, mechanistic interpretability has a healthy culture and I’ve gotten nothing but positive feedback for publishing negative results.
    - E.g. exaggerating results or stating an overconfident narrative to seem more publishable.
        - I find it pretty easy to tell when a paper is doing this - generally you should care more about impressing the more experienced researchers in a field, who are least likely to be fooled by this! So I don’t even think it’s a good selfish strategy.
    - E.g. not acknowledging and discussing key limitations.
        - If I notice a key limitation that a paper has not addressed or acknowledged, I think far less of the paper.
        - If a paper discusses limitations, and provides a nuanced partial rebuttal, I think well of it.

## Prioritisation

Ultimately, time is scarce. The space of possible actions you can take when doing research is wide and open ended, and some are far more valuable than others. The difference between a failed and a great research project is often prioritisation skill. Improved prioritisation is one of the key sources of value I add as a mentor

- Fundamentally, good prioritisation is about having a clear goal (north star) in mind.
    - You need good judgement about how well different actions achieve this goal
        - You need to actually make the time to think about how well actions achieve this goal!
    - You need to be ruthless about dropping less promising directions where necessary.
        - But beware switching costs - if you switch all the time without exploring anything properly you’ll learn nothing!
- The goals at each stage are:
    - Ideation: Choose a fruitful problem
    - Exploration: Gain information and surface area on the problem
    - Understanding: Find enough evidence to convince you of some key hypotheses
    - Distillation: Distill your research into concise, well-supported truth, and communicate this to the world.
- Being great at prioritisation is pretty difficult, and requires good research taste, which will take a lot of time to develop. But there’s often basic mistakes and low-hanging fruit to improve, if you just try.
    - The first step is just making time to stop and ask yourself “do I endorse what I’m doing, and could I be doing something better?”
        - This advice may seem obvious, but is deceptively hard to put into practice! You need regular prompts  Often it’s very easy to think of a better idea, but by default nothing prompts you to think.
    - I like to explicitly write goals down and regularly check in that they’re being achieved - it sounds obvious, but you would be shocked at how effective it is to ask people if they’re doing the best thing for the project goals. I think in 3 tiers of goals:
        - Goal: What is the overall north star of the project? (generally measured in months)
        - Sub-goal: What is my current bit of the project working towards (measured in weeks)
        - Objective: What is the concrete short-term outcome I am aiming for right now (measured in days, e.g. 1 week)
    - I recommend actually writing a plan, and estimate how long each step will take, at least for the current research stage you’re in.
        - You don’t need to take it very seriously, and you’ll totally deviate a ton.
        - But it forces you to think through the project, notice uncertainties you could ask someone about, question if parts are really necessary to achieve your goals.
        - This is most important for understanding & distillation, though can be useful for exploration
        - If you feel stuck, set a 5 minute timer and brainstorm possible things you could do!
        - I typically wouldn’t spend more than a few hours on this
            - Unless you have a mentor giving high quality feedback - then it’s a great way to elicit their advice!
            - But even then, feel free to deviate - mentors typically have good research priors, but you know way more about your specific problem than them, which can be enough to make better decisions than even a very senior researcher
- You need to prioritise at many different layers of abstraction, from deciding when to move on from an experiment to deciding which hypothesis to test first to deciding when to give up on testing a hypothesis and pivot to something else (or just back to exploration)
- Prioritising and executing are different mental modes and should not be done simultaneously. Keep them separate, and make time to regularly reflect, and time to lock-in and execute on a plan without stressing about if it’s the best plan
    - Concrete advice: Work to a schedule where you regularly (ideally at least once a day, and with extended reflection at least once a week), zoom out and check that what you’re doing is your highest priority. E.g. work in pomodoros
    - Having a weekly review can be incredibly useful -  where you zoom out and check in on what’s going on, any current issues, etc. Some useful prompts:
        - What is my goal right now?
        - What progress have I made towards that goal?
        - What’s consumed the most time recently?
        - What’s blocked me?
        - What mistakes have I made, and how could I systematically change my approach so it doesn’t happen again in future?
        - What am I currently confused about?
        - Am I missing something?
- See Jacob Steinhardt’s excellent blog post on research prioritisation.
- Warning: Different people need to hear different advice! (An eternal issue of writing public advice…). Some get stuck in rabbit holes and need to get better at moving on. Others get caught in analysis paralysis and never do anything, because they’re always waiting for the (non-existent) perfect opportunity.
    - Real prioritisation is about a careful balance between exploration and exploitation.
    - You probably know which failure mode you tend towards. Please focus on the advice relevant to you, and ignore the rest!

## Moving Fast

A core aspect of taking action in general is being able to move fast. Researchers vary a lot in their rate of productive output, and it gets very high in the best people - this is something I value a lot in potential hires.

This isn’t just about working long hours or cutting corners - there’s a lot of skill to having fast feedback loops, noticing and fixing inefficiency where appropriate, and being able to take action or reflect where appropriate. In some ways this is just another lens onto prioritisation.

- Tight feedback loops are crucial: A key thing to track when doing research is your feedback loops.
    - Definition: A feedback loop is the process from having an experiment idea and to results. Tight feedback loops are when the time taken is short.
    - It will make an enormous difference to your research velocity if you can get your feedback loops as tight as possible, and this is a big priority.
        - This is because you typically start a project confused, and you need to repeatedly get feedback from reality to understand what’s going on. This inherently requires a bunch of feedback loops that can’t be parallelised, so you want them to be as short as possible.
        - This is one of the big advantages of mech interp over other fields of ML - we can get much shorter feedback loops.
    - A mindset that I often find helpful is a deep-seated sense of impatience and a feeling that something should be possible to do faster. Sometimes I just need to accept that it will take a while, but often there is a better way, or at least a way that things can be reduced.
    - Coding in a notebook is a lifesaver (eg Jupyter, VS Code Interactive Mode or Colab)
    - Tips for tight feedback loops in mech interp:
        - Putting your data in a data frame rather than in a rigid plotting framework like Weights and Biases allows you to try arbitrary visualizations rapidly.
        - De-risking things on the smallest model you can, such as writing code and testing it on a small model before testing it on the model you're actually interested in.
        - Train things on fairly small amounts of data just to verify that you're seeing signs of life.
        - Sometimes there’s irreducible length, e.g. you need to train a model/SAE and this takes a while, but you can still often do something - train on less data, have evals that let you fail fast, etc.
- Good tooling accelerates everything. All stages benefit from flexible exploration tools (e.g., interactive notebooks, libraries like TransformerLens or nnsight), efficient infrastructure for running experiments, and helpful utilities (e.g., plotting functions, data loaders).
    - Flexible tooling tightens feedback loops by shortening the time between an arbitrary creative experiment idea and results, even if it’s less efficient for any given idea.
    - The balance shifts: more flexibility needed early, more optimization/robustness potentially useful later e.g. during the distillation stage it can make sense to write a library to really easily do a specific kind of fine-tuning run that happens a ton
- A corollary of this is that you should (often) do fast experiments first. It is far better to do a quick and dirty experiment to get some preliminary signs of life than an extremely long and expensive experiment that will produce conclusive data but only after weeks of work.
    - Realistically you should be prioritising by information gain per unit time.
    - This is especially important in exploration where it's hard to have a clear sense of which experiments are the most useful while estimating their tractability is pretty easy. When distilling you may know enough to be comfortable implementing a long running but conclusive experiment.
- Audit your time. It's all well and good to talk about the importance of speed and moving fast, but how do you actually do this in practice? One thing that might be helpful is to log how you spend your time and then reflect on it, and ways you might be able to go faster next time.
    - For example, you could use a tool like Toggl to roughly track what you're doing each day and then look back on how long everything took you and ask, "How could I have done this faster? Was this a good use of my time?"
        - Often it’s easy to fix inefficiencies and the hard part is noticing them - e.g. making a util function for a common tedious task, or noticing things that an LLM could automate.
    - Note: It is not productive to look back and feel really guilty about wasting time. Nobody is perfect and you will always waste time. I am advocating for maintaining a mindset of optimism that you will be able to do even better next time.
- Fail fast. One of the largest time sinks possible is investing weeks to months of effort into a failed research direction. Thus, a key question to ask yourself is: if this direction is doomed, how could I discover this as fast as humanly possible?
    - I often try to think through what kind of confident predictions a hypothesis I care about makes in the understanding stage, or what fundamental assumptions make me think my domain is interesting at all in the exploration stage, and then think of the quickest and dirtiest experiments I can to test these.
        - It's often much better to have several quick and dirty experiments to attack different angles where you could fail fast than to put a lot of effort into one.
- Are you moving too fast? This is a natural pushback to the advice of ‘try hard to move fast’. It’s easy to e.g. be sloppy in the name of speed and introduce many bugs that cost you time in the long-run.
    - This is a hard balance, and I largely recommend just exploring and seeing how things go. But there are often things that can speed you up beyond ‘just push yourself to go harder in the moment’, which don’t have these trade-offs, like choosing the right experiments to run.
    - Make sure you still regularly take time to think and reflect, rather than feeling pressure to constantly produce results

### Taking action under uncertainty

A difficulty worth emphasising when trying to move fast is that there are a lot of possible next steps when doing research. And it’s pretty difficult to predict how they’ll go. Prioritisation remains crucial, but this means it’s also very hard, and you will be highly uncertain about the best next step. A crucial mindset is being able to do something anyway, despite being so uncertain.

- As a former pure mathematician, this is something I’ve struggled a fair bit with - I miss doing things grounded in pure, universal truth! But it’s learnable
- Ultimately, you just need to accept on an emotional level that you don’t get to know the “right” answer for what to do next - in practice, there’s no such thing as the right answer.
    - The ideal is to strive to carefully evaluate the extremely noisy evidence, make a best guess for what to do next, and act on it, while also being self-aware enough to notice if it no longer seems the best action. This is a hard balance to achieve, but super useful if you can do it.
- Especially when you’re starting out, this can be very low stakes: the value of anything you do is dominated by the learning value! If you make bad decisions you will learn and can do better next time, so it’s hard to really have a bad outcome.


# Understanding and Cultivating Research Taste
https://www.alignmentforum.org/s/5GT3yoYM9gRmMEKqL/p/eJGptPbbFPZGLpjsp

## Introduction

Spend enough time around researchers, and you'll hear talk of "research taste." It's often presented as a somewhat mystical quality distinguishing the seasoned research from the novice – an almost innate sense for which research ideas will flourish and which will fail. While I believe research taste is very real, incredibly valuable, and a key differentiator I look for, I *don't* think it's mystical or innate. Talent plays an important role, but taste is largely learned, and with the right mindset you can learn faster.

**What is research taste?** As I define it, research taste is far broader than just picking the right problem at the outset. Research is full of key decisions that will affect the future of the project, without an obvious way to find the right answer: from choosing the research problem itself, to identifying which anomalies are and are not worth exploring, distinguishing an experiment that will be compelling from one that’ll have inconclusive results, etc. I think of taste as**the set of intuitions and good judgment that guide a researcher’s decisions*throughout* the research process**, any time an ambiguous or open-ended decision like this arises. This can just be gut feeling, but also having conceptual frameworks you reason through, having novel ideas spark in your mind, etc.

**Where does taste come from?** If you're new to research, feeling like you lack "taste" is completely normal and expected. You don't need perfect judgment to start. In fact, trying to force it early on can be counterproductive. Think of training your intuition like training a network. It starts poorly initialized and needs lots of diverse, high-quality training data (i.e., research experience). With time, people often develop fairly deep and sophisticated taste, as they see enough examples of research outcomes, but this generally isn’t something people start with.

**How to learn it?** In my opinion, research taste is one of the hardest skills to learn for being a good researcher. To see why, let's lean more into this analogy of training a neural network. The core problem is**you just don't get that much data**. Generally the shorter a feedback loop is the more data you will get. By definition research taste is about things that are not immediately obvious. For designing a good experiment, sometimes you can get results from hours to day, but feedback on whether a research idea was good can take months!

I think the main way to speed it up is by **getting more data**, and by**being more sample efficient** about the data that you have. To get more data the easiest way is to**lean on sources of supervised data:** ideally**a mentor**, or**seeing what worked in papers**. You can also get more from each data point - analyse it in detail before setting the feedback,**predict your mentor’s answers before they give them**, etc. When you have made a research decision and you eventually get feedback, do a post-mortem analyzing what did and did not work and why and what general themes you could look at in future.

But even with all that, **expect learning taste to take a while**, especially high level strategic things like choosing a project - learning speed depends on your feedback loops, and taste has very slow ones. Further, research taste often translates poorly from other fields, or comes with counter-productive habits

## What is Taste?

As discussed, I define **research taste** broadly:**it's the collection of intuitions and judgments that guide good decision-making throughout a research project,** especially where feedback loops are long, and the search space is large and open-ended.

I take such a broad definition, because I think that the ability to make good judgements is a fairly general skill, and improving at one facet often helps you improve at all of them, by e.g. getting better conceptual frameworks and domain knowledge.

While **Problem Selection** (strategic judgment about tractability and interest) is the most visible aspect, research taste also covers:

- **Exploration:** A tactical sense for which experiments yield the most insight, recognizing interesting anomalies versus noise, knowing when to dig deeper or move on from a thread.*Does this surprising result feel like a key insight or a distracting artifact?*
  - My internal experience here looks like a visceral science of excitement vs boredom or flinching away from messiness/ugliess. I tend to get excited about things that feel like unexpected structure, spark follow-up experiments, or relate to a deep curiosity I have.
- **Understanding:** Designing creative, elegant experiments that cleanly distinguish hypotheses, judging the plausibility and explanatory power of different theories, identifying crucial assumptions or potential confounds.*Is this experiment truly isolating the variable I care about? What's the simplest explanation for this data?*
  - My internal experience is that I may have a beautiful hypothesis I *want* to believe, but it feels uncertain, and this creates an uncomfortable sense of instability.
  - I try to probe at where the instability comes from, what predictions are made by that potential flaw, and design an experiment to target it.
  - A good experiment design feels very clean and reliable - I would trust the results - while for a bad one I still have this shifting sense of uncertainty and being able to generate many alternative explanations
- **Communication & Distillation:** Identifying the core, communicable claims within messy findings, structuring a compelling and*true* narrative, anticipating audience confusion, knowing what makes a result impactful*to others*.*What's the single most important takeaway here? How can I present this evidence most clearly and honestly?*
  - My internal experience of compression is about having a frustration and impatience with length and unnecessary conceptual detail - I want to distill the research down into what is truly important, and reach a point where I can cut no further without sacrificing something important.
  - If I’ve compressed too far, there’s a sense that there’s a missed opportunity - a really exciting thread that’s missed out.

### Decomposing Research Taste

Where does this "taste" come from? In my experience, it boils down to a few key ingredients:

1. **Intuition (System 1):** This is the fast, gut-level feeling - what people normally think of when they say research taste. A sense of curiosity, excitement, boredom, or skepticism about a direction, experiment, or result.
   1. "This feels promising," "This feels like a rabbit hole," "This anomaly seems *important*," "This explanation feels too simple/too complex."
   2. This is the part that feels most like "taste" and develops slowly through repeated exposure and feedback - when I refer to gathering data to train a network, I largely mean training your intuition.
   3. Empirically, my own recommendations based on this intuition have a decent hit rate, and experienced researchers are often fantastic (though not flawless!) at this, but this takes time.
2. **Conceptual Framework (System 2):** This is deep domain knowledge and understanding of underlying principles.
   1. This is crucial in mech interp, especially as it’s a pre-paradigmatic field, where you can’t just memorise and apply a standard method.
      1. I’d guess it’s still important in other domains, though I am less sure
   2. For mech interp, this includes:
      1. Understanding transformer mechanics and basic facts - they’re autoregressive, the residual stream is the central object, tokens are discrete while all activations are continuous vectors, etc
      2. Key results and heuristics: like superposition or the linear representation hypothesis, or the idea that features and circuits exist at all
      3. Common techniques and where to use them and what they can tell you: patching, SAEs, probing, prompting, etc.
         1. This can get pretty deep! See [my paper on how to think about activation patching](https://arxiv.org/abs/2404.15255).
      4. Foundational knowledge of relevant adjacent fields: linear algebra, ML theory, training ML models, basic software engineering, etc
   3. This conceptual framework allows you to generate hypotheses, evaluate plausibility *explicitly*, spot inconsistencies, design sensible experiments, and explain*why* your intuition feels a certain way. It provides the structured reasoning to back up or override gut feelings.
   4. Eventually, this conceptual framework should feel like [a gears-level model](https://www.alignmentforum.org/w/gears-level), where you can reason about the key moving parts, and what would make a project or experiment idea work vs fail vs be impractical.
3. **Strategic Big Picture:** Understanding the broader context of the field. What problems are important? What are the major open questions? What approaches have been tried? What constitutes a novel contribution?
   1. My motivations for doing mech interp partly stem from making AGI safe, so the main big picture is “what work translates into better outcomes for AGI”, and being able to break this down into near-term steps.
   2. But even for less goal directed fields, where the goal is just curiosity driven basic science, there’s often a useful big picture around what advances would unlock many future advances or be a dead end, what would people care about, etc.
   3. Ideally, you dwell on the big picture enough that your intuitive sense of curiosity and excitement starts to integrate it - it’s not about overriding your curiosity with strategic obligations, it’s about aligning them so you’re excited about what matters. I see this as one input to prioritisation, among many.
4. **Conviction & Confidence:** Research inevitably involves setbacks. A certain level of conviction – a belief in the direction, resilience to negative results – is often instrumentally useful for perseverance. It helps you push through the messy exploration phase or refine an idea that isn't working perfectly yet.
   1. Empirically, research taste also often leads to conviction - the intuitive feeling that an idea is exciting and important tends to also give motivation and focus.
   2. However, this is a **double-edged sword**. Your intuitions are not well calibrated.**Confidence doesn't mean correctness**. Generally people reach the level of having conviction far before they reach the level of having correct intuitions
   3. **The ideal is*strategic* conviction**: the ability to adopt a confident mindset to maintain momentum, while regularly zooming out to reflect and maintaining the capacity for zoomed-out skepticism and the willingness to update or abandon course based on evidence.
   4. **Track data**: Conviction is instrumentally useful, but so are correct beliefs. Generally, the best way to get calibrated is to pursue an exciting idea and see it fail in unexpected ways. Try to**write down prior predictions**, and*why* you think an idea is good, pursue it, and**reflect on what happened**.
      1. Corollary: **It’s fine to be uncalibrated at first**, this can help you get more research done and gather more data, if you’re paying attention you’ll often get over it.
         1. I often mentor people who start out by getting way too attached to flawed ideas, and don’t engage well with criticism. Seeing some of their exciting ideas fail tends to helps a lot.

**These components interact**. A strong conceptual framework sharpens intuition. Experience builds both intuition and framework knowledge. Strategic awareness helps channel conviction productively.

## Cultivating Research Taste

If taste is like an ML model, how can we speed up training? We want to improve the quantity (and quality) of data, and the sample efficiency of how much we learn from it.

- **Learning more from each data point**: You will learn something just from doing research. You'll get some feedback, some experience, and your intuitions and models will improve. But each data point is actually much richer than just a binary of success or failure!
  - My recommendation is to **make explicit predictions**,**review accuracy**, and make time to**reflect on what you missed** and how you could do better next time.
    - Keep a research log. Ask *why* things worked or failed. Was it luck, execution, or a fundamental judgment call (taste)?
  - **Reflect Deliberately:** After an experiment or project phase, ask: What worked? What didn't? What surprised me? What would I do differently next time? How does this update my model of this domain? ([Weekly reviews](https://www.neelnanda.io/blog/39-reflection) can be great for this).
- **Getting more data**: The obvious source of data is doing research. But there are other sources too!
  - **Leverage Mentors:** This is perhaps the biggest accelerator. A mentor provides high-quality, curated "labels", insights and feedback. You can think of this as supervised data, in contrast to the slow RL of doing research yourself.
    - **Predict their advice:** Before asking your mentor ("Should I run experiment A or B?", "Is this result interesting?"), predict their answer and reasoning.
    - **Analyze surprises:** When their answer differs from your prediction,*dig into why*. What perspective, heuristic, or piece of knowledge did they use that you lacked? This is incredibly valuable training data for your internal model.
      - **Strong recommendation**: Do this by**repeatedly paraphrasing their reasoning**. Try to repeat back their arguments in your own words, and ask what you’re missing. This is an excellent way to ensure you’ve processed correctly, and often highlights misunderstandings. This is one of my most effective tactics when learning from people.
    - **Absorb their frameworks:** Listen not just to*what* they advise, but*how* they reason. What questions do they ask? What principles do they seem to operate by?
  - **Learn Critically from Papers (Offline Data):** Papers are a biased dataset (publication bias!), but still useful.
    - Read actively: Predict methods, results, and limitations before revealing them.
    - Ask *why*: Why did the authors make these choices? What alternative approaches might they have considered? What makes this paper impactful (or not)?
    - Focus on *reasoning*: Try to reconstruct the authors' thought process, not just memorize the outcome.
    - Note: **Papers are*very* often flawed**! A common mistake in new researchers is assuming that everything in a paper was reasonable or done for principled reasons. Even in great papers, there’s a lot of janky crap or flaws in there. And many papers are just inherently flawed or outright false. Critically engaging with a paper’s flaws is also very educational
  - **Collaborate and Discuss:** Talk to peers. Explain your research plans and reasoning. Listen to theirs. Critique each other's logic. Explaining forces clarity and exposes flawed assumptions. Hearing others' perspectives provides diverse 'data points'.
  - **Prioritize Projects with Clearer Feedback:** Especially early on, projects where you can test intermediate hypotheses or get partial results relatively quickly can accelerate learning more than moonshots with year-long feedback loops.
- **Feedback loops**: The speed at which you complete each loop for each facet of taste determines how fast you learn that aspect.
  - **Short Loops/tactical taste:** Designing a specific experiment, debugging code, interpreting a single plot. Feedback is often quick (minutes to days). You'll likely improve*much* faster at skills with short feedback loops.
  - **Long Loops/strategic taste:** Choosing a research problem, deciding on a major strategic direction. Feedback might take months or even years.**Improvement here is inherently slower.**
  - **Implication:** Don't beat yourself up if your high-level strategic taste develops slower than your tactical experimental skills. This is expected.

I have less to say about other components of research taste like conceptual understanding or strategic picture - generally a similar mindset works there, though as it’s no longer really a black box I think it’s more straightforward, and is much easier to learn from reading papers and existing resources, and talking to mentors/experts. Conviction is more of a matter of personality and preference, in my experience.

## Conclusion: Patience and Process

Research taste isn't magic. It's a complex set of intuitions and frameworks built incrementally through experience, reflection, and learning from others. It governs the crucial, often implicit, decisions that shape a research project's success.

Because the feedback loops for high-level strategic taste are long and noisy, don't expect to master it quickly. It's perfectly normal, and indeed expected, to rely heavily on external guidance (like mentors or established research directions) early in your career. Focus first on mastering the skills with shorter feedback loops – coding, running experiments, analyzing data, clearly communicating simple results.

By actively engaging in research, deliberately reflecting on your decisions and their outcomes, and strategically leveraging the experiences of others, you can accelerate the development of your own research taste. Be patient with the process, especially the long-game aspects like problem selection. Trust that by doing the work and learning effectively from it, your intuition will improve over time.
