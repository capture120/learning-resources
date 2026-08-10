---
name: learning
description: thoughts about learning
---

- Find an interesting problem to solve.
- Ask questions endlessly to build foundation. Explain it in my own words.
- Try it myself → Don’t get stuck. Reach 80%
- Look at solution → Learn the intuition & pattern
    - **“How could I make the insight that leads to discovering the solution?”**
- Play with the problem
    - Re-solve
    - Modify the problem
- Learn and Relearn fields. Ask dumb questions. Solve smaller problems
    - reading the literature, working through examples, building intuition by actually solving smaller problems — before you can reliably attack the big one.
    - you have to build up the skills and understanding the slow way, through sustained effort, before the problem becomes tractable.
    - “By reading through Jean’s papers, I was able to add these tools to my own “basic” toolkit, which then became a fundamental starting point for much of my own research. Indeed, a large fraction of my early work could be summarised as ‘take one of Jean’s papers, understand the techniques used there, and try to improve upon the final results a bit’”.


# Terry
    
    **Try simpler cases first.** If one is completely stuck on a problem, try making the problem simpler (while still capturing at least one of the difficulties of the problem that you cannot currently resolve). The problem should not be made so simple that it becomes trivial, as this doesn’t really gain you any new insight about the original problem; instead, one should try to keep the “essential” difficulties of the problem while throwing away those aspects that you think are less important (but are still serving to add to the overall difficulty level). On the other hand, if the simplified problem is unexpectedly easy, but one cannot extend the methods to the general case (or somehow leverage the simplified case to the general case), this is an indication that the true difficulty lies elsewhere.
    
    Decompose or approximate data into a simpler one.
    
    The test examples should be as basic as possible.
    
    Transforming Problems - “By changing the language of your problem, you are activating different areas of your brain”.
    
    If it is difficult to work globally, work locally instead. Work locally on smaller sub-domains “then figure out how to patch things together later”.
    
    Draw pictures and try to build counterexamples. A common mistake is to try to draw a picture in which both the hypotheses and conclusion of the problem hold. This is actually not all that useful, as it often does not reveal the causal relationship between the former and the latter.  One should try instead to draw a picture in which the hypotheses hold but for which the conclusion does not – in other words, a counterexample to the problem.  Of course, you should be expected to fail at this task, given that the statement of the problem is presumably true. However, the way in which your picture fails to accomplish this task is often very instructive, and can reveal vital clues as to how the solution to the problem is supposed to proceed.
    
    **Abstract away any information that you believe or suspect to be irrelevant.** Sometimes one is faced with an embarrassment of riches when it comes to what choice of technique to use on a problem; there are so many different facts that one knows about the problem, and so many different pieces of theory that one could apply, that one doesn’t quite know where to begin. When this happens, abstraction can be a vital tool to clear away some of the conceptual clutter.  Here, one wants to “forget” part of the setting that the problem is phrased in, and only keep the part that seems to be most relevant to the hypotheses and conclusions of the problem (and thus, presumably, to the solution as well). For instance, if one is working in a problem that is set in Euclidean space {\bf R}^d, but the hypotheses and conclusions only involve measure-theoretic concepts (e.g. measurability, integrability, measure, etc.) rather than topological structure, metric structure, etc., then it may be worthwhile to try abstracting the problem to the more general setting of an abstract measure space, thus forgetting that one was initially working in {\bf R}^d. **The point of doing this is that it cuts down on the number of possible ways to start attacking the problem.**  For instance, facts such as outer regularity (every measurable set can be approximated from above by an open set) do not hold in abstract measure spaces (which do not even have a meaningful notion of an open set), and so presumably will not play a role in the solution; similarly for any facts involving boxes.  Instead, one should be trying to use general facts about measure, such as countable additivity, which are not specific to {\bf R}^d. It is worth noting that sometimes this abstraction method does not always work; [INTERJECTION] he says that youll find out parts of the details you abstracted way are still important - underlying implementation may actually be important to the problem. expect it not to always work [END-INTERJECTION]
    
    Reduce a problem into successively simpler sub-problems
    
    **If the conclusion and hypotheses look particularly close to each other, just expand out all the definitions and follow your nose.** This trick is particularly useful when building the most basic foundations of a theory.  Here, one may not need to experiment too much with generalisations, abstractions, or special cases, or try to marshall a lot of possibly relevant facts about the objects being studied: sometimes, all one has to do is go back to first principles, write out all the definitions with their epsilons and deltas, and start plugging away at the problem. Knowing when to just follow one’s nose, and when to instead look for a more high-level approach to a problem, can require some judgement or experience.  A direct approach tends to work best when the conclusion and hypothesis already look quite similar to each other (e.g. they both state that a certain set or family of sets is measurable, or they both state that a certain function or family of functions is continuous, etc.).  But when the conclusion looks quite different from the hypotheses (e.g. the conclusion is some sort of integral identity, and the hypotheses involve measurability or convergence properties), then one may need to use more sophisticated tools than what one can easily get from using first principles.
    
    **Lex Fridman**(01:16:34) I have to ask about how do you approach solving difficult problems if it’s possible to go inside your mind when you’re thinking, are you visualizing in your mind the mathematical objects, symbols, maybe what are you visualizing in your mind? Usually when you’re thinking?
    
    **Terence Tao**(01:16:57) A lot of pen and paper. One thing you pick up as a mathematician is I call it cheating strategically. So the beauty of mathematics is that you get to change the problem and change the rules as you wish. You don’t get to do this by any other field. If you’re an engineer and someone says, “Build a bridge over this river,” you can’t say, “I want to build this bridge over here instead,” or, “I want to put it out of paper instead of steel,” but a mathematician, you can do whatever you want on. It’s like trying to solve a computer game where there’s unlimited cheat codes available. And so you can set this, there’s a dimension that’s large. I’ve set it to one. I’ll solve the one-dimensional problem first. So there’s a main term and an error term. I’m going to make a spherical call assumption [inaudible 01:17:45] term is zero. 
    
    And so the way you should solve these problems is not in this Iron Man mode where you make things maximally difficult, but actually the way you should approach any reasonable math problem is that if there are 10 things that are making your life difficult, find a version of the problem that turns off nine of the difficulties, but only keeps one of them and solve that. And then so you solve nine cheats. Okay, you solve 10 cheats, then the game is trivial, but you solve nine cheats. You solve one problem that teaches you how to deal with that particular difficulty. And then you turn that one-off and you turn someone else something else on, and then you solve that one. And after you know how to solve the 10 problems, 10 difficulties separately, then you have to start merging them a few at a time.
    
    Mostly pen and paper actually. So in my office I have four giant blackboards and sometimes I just have to write everything I know about the problem on the four blackboards and then sit my couch and just see the whole thing.
    
    It's always a combination of thinking inside your head and speaking out loud and working on the board. You do try to isolate sort of the simplest metaphor or something for for your problem. How how can I explain it? So you know for instance, I do a lot of estimates, say I always want $X$ is less than $Y$ and sometimes it helps to think of this as sort of economics problem, like you have a budget of $Y$ and can you afford $X$? And then and that way you you start thinking economically, like like so the way you prove inequalities, like $X$ is less than $Y$, is that normally you you maybe try to first bound $X$ by $Z$, and then $Z$ by $W$, and then $W$ by $Y$, and so forth. And this is like, you know, trading in one item for another item, and you get a sense of sort of what inequalities are sort of good deals for you, that you're getting your bang for your buck, and which ones are really sort of wasting your money. Sometimes utilizing sort of your financial intuition can be helpful
    
    One of the secrets to mathematical problem solving is that one needs to place a high value on partial progress, as being a crucial stepping stone to fully solving the problem. This can be a rather different mindset than what one commonly sees in more “real world” situations such as business, sports, engineering, or politics, where actual success or failure often matters much more than what one can salvage from a partial success. I think the basic reason for this is that in the purely theoretical world of mathematics, there is basically a zero cost in taking an argument that partially solves a problem, and then combining it with other ideas to make a complete solution; but in the real world, it can be difficult, costly, or socially unacceptable to reuse or recycle anything that is (or is perceived to be) even a partial failure. Software engineering is one of the few exceptions to this general rule, as it is almost as easy to reuse software code as it is to reuse a mathematical argument.
    
    For beginning maths students, who have not yet adopted the partial progress mindset, it is common to try a technique to solve a problem, find out that it “fails”, and conclude that one needs to try a completely different technique (or to give up on the problem altogether). But in practice, what often happens is that one’s first solution attempt is able to solve some portion of the problem, and one needs to then look to combine that argument with techniques that can solve complementary portions of the problem in order to reach the final solution. 
    
    For instance, recently a graduate student came to me with an integral on the real line he was trying to estimate. He had tried integration by parts, and found that the resulting terms from that integration behaved well on one side of the real line, but diverged on the other. A beginner might have given up on this method at this point; but having already had some mathematical experience, he realised that this was a partial success, and split the real line into two pieces, using integration by parts to control the integral on one piece, and a different technique (Taylor expansion of the integrand) to control the other integral. Unfortunately, when he added up the estimates, he found that no matter how where he divided the real line into two, the total estimate still fell short of what he wanted, at which point he came to me for help. But actually, this failure was in fact further partial progress; he had discovered one method (integration by parts) that handled the integral for large positive values of the integration parameter, and another (Taylor expansion) that handled large negative values, and all that remained was to add a third technique (which, in this case, was crude estimation by replacing everything by its absolute value) to treat the intermediate values which were not well handled by the previous two techniques. Thus the first two “failures” were in fact crucial advances that were needed to solve the full problem, by resolving at least some of the difficulties present of the problem, and in focusing attention on the remaining issues that needed resolution.
    
    I believe that the optimal way to develop one’s talents is to invest in the middle ground between these two extremes, thus adding new challenges and difficulties to your research program in carefully controlled amounts. Examples of such research objectives include
    
    1. Looking at the easiest problems of interest that you can’t quite completely handle with your existing tools, for instance by taking an unsolved problem and making various assumptions to “turn off” all but one of the difficulties;
    2. Taking a known result and reproving it by “tying one hand behind your back”, by forbidding yourself to use a method which is effective for that result, but does not extend well to more difficult problems; or
    3. Taking a known result and generalising it to a situation in which most of the steps in the standard proof of the existing result look like they will extend, but which have just one or two parts which look tricky and will require some modest new idea, trick or insight.
    
    when trying to solve a challenging problem using a given set of techniques, I recommend first replacing the problem with a simpler problem (such as a special case, or a toy model of the problem, or an informal version of the problem in which various non-rigorous “cheats” are enabled, e.g., ignoring any terms that you believe to be negligible, that certain probabilistic heuristics are in fact theorems, or assuming that any plausible algebraic identity that you could in principle work out, is in fact true), with the aim of moving to the simplest version of the problem that isn’t immediately solvable by the techniques you have in mind, but which you believe should still be amenable to those techniques.  This tends to focus one’s attention on exactly what one needs to extend the reach of these techniques, and then one can work backwards back up to the original problem.  A particularly good model problem to apply this method to is a problem which seems just out of reach of your intended technique, but can still be solved by a different method; in such cases the proof by the other method can provide valuable clues about how to proceed with your intended method, and can also save time by ruling out proof strategies that cannot possibly work because they contradict the conclusions coming from that other method.
    
    **Terence Tao**(02:55:31) Yeah, it works for me. But there are also people who are very productive and they focus very deeply. I think everyone has to find their own workflow. One thing which is a shame in mathematics is that mathematics has a sort a one-size-fits-all approach to teaching mathematics, and so we have a certain curriculum and so forth. Maybe if you do math competitions or something, you get a slightly different experience. But I think many people, they don’t find their native math language until very late or usually too late. So they stop doing mathematics and they have a bad experience with a teacher who’s trying to teach them one way to do mathematics that they don’t like it.
    
    (02:56:12) My theory is that humans don’t come, evolution has not given us a math center of a brain directly. We have a vision center and a language center and some other centers, which evolution has honed, but we don’t have an innate sense of mathematics. But our other centers are sophisticated enough that we can repurpose other areas of our brain to do mathematics. So some people have figured out how to use the visual center to do mathematics, and so they think things very visually when they do mathematics. Some people have repurposed their language center and they think very symbolically. Some people, if they are very competitive and they’re gaming, there’s a part of your brain that’s very good at solving puzzles and games, and that can be repurposed.
    
    (02:57:02) But when I talk about the mathematicians, they don’t quite think that, I can tell that they’re using some other different styles of thinking, not disjoint, but they may prefer visual. I don’t actually prefer visual so much. I need lots of visual aids myself. Mathematics provides a common language, so we can still talk to each other even if we are thinking in different ways.
    
    **Lex Fridman**(02:57:26) But you could tell there’s a different set of subsystems being used in the thinking process?
    
    **Terence Tao**(02:57:32) Yeah, they take different paths. They’re very quick at things that I struggle with and vice versa, and yet they still get to the same goal.
    
    **Lex Fridman**(03:09:15) Is there something our human mind will never be able to comprehend?
    
    **Terence Tao**(03:09:21) Well, as a mathematician, [inaudible 03:09:23]. There must be some large number that you can’t understand. That was the first thing that came to mind.
    
    **Lex Fridman**(03:09:31) So that, but even broadly, is there something about our mind that we’re going to be limited even with the help of mathematics?
    
    **Terence Tao**(03:09:41) Well, okay, how much augmentation are you willing. Like for example, if I didn’t even have a pen and paper, if I had no technology whatsoever, so I’ve not allowed blackboard, pen and paper-
    
    **Lex Fridman**(03:09:52) You’re already much more limited than you would be.
    
    **Terence Tao**(03:09:55) … Incredibly limited. Even language, the English language is a technology. It’s one that’s been very internalized.
    
    **Lex Fridman**(03:10:03) So you’re right, the formulation of the problem is incorrect ’cause there really is no longer just a solo human already augmented in extremely complicated intricate ways, right?
    
    **Terence Tao**(03:10:17) Yeah. Yeah.


# Andrej
"The field is too large to know everything. You'll try to pack it all in and then forget it all. I'd advise picking the research area you want to go into (in as much detail as you can afford) and start digging in depth-wise by reading the cutting edge papers, recursing backwards through citations and learning the specific tools that you see coming up again and again.

In retrospect I think that my failure case was that I tried to get a broad "base" of knowledge and went breadth-wise (e.g. reading books, doing well on courses), which took a lot of time but I'm not so sure it was a good idea because research (which is ultimately what matters) is about a lot of depth. So what happened was that I learned 100 topics and then only 5 really mattered, and the other 95 I promptly forgot due to lack of use.

You could argue that to do good research you should have a good overview of the field to combine ideas across. This was my motivation too, except empirically I don't think it turned out very well. I probably went a little too deep in breadth. Anyway, it seems to me that you're already thinking about it all wrong by asking "what topics you'd review". Guess at a very specific work you'd want to do, work backwards, and focus as much as possible.

My mental model is that knowledge is like a triangle. Up top you have arithmetic, basics etc. School up to undergrad is somewhat like doing horizontal scanlines down towards the bottom, but PhD is about reaching to the very bottom of the triangle in any particular x-coordinate of your choosing. In this analogy the critical tradeoff is how you pace yourself around the triangle, because you have finite time so there is a finite area you can "color", or visit in your life.

It is also important to consider the dynamics of the process: your knowledge is not permanent, so it's as if the area you "colored in" slowly fades away in that triangle, with the fun additional component that broad knowledge fades away much more quickly than deep knowledge. As if the rate of fading of a pixel is proportional to the amount of stuff colored in below it (this is the knowledge you keep reusing and doesn't fade quickly).

So what I did is too many horizontal scanlines, then I dug into a vertical, and all the stuff that wasn't immediately above me slowly faded away.

Makes sense? No? Okay :) https://www.reddit.com/r/MachineLearning/comments/5rww3k/comment/ddc0xoi/?context=3
"

"
In retrospect I quite enjoyed writing my first AI short story and will probably continue to write more a bit on a side as I did the first time (though nothing specific is in works right now). I actually consider it a relatively good exercise for research because you're forcing yourself to hypothesize consistent and concrete outcomes. Pushing these in your mind to their conclusions is one way to achieve fun insights into what approaches to AI are more or less plausible.
https://www.reddit.com/r/MachineLearning/comments/404r9m/comment/cysijkg/?context=3
"

* Math for AI
imo, basic multivariable calculus, basic convex optimization, medium linear algebra, mostly statistics.
I didn't take enough statistics in undergrad and regretted it several times. Instead I did a bunch of partial differential equations, chaos theory, numerical analysis, group theory, mathematical logic (incompleteness theory etc), and all of these ended up being quite useless. And after ~5-8 years I only just barely remember any of it :(