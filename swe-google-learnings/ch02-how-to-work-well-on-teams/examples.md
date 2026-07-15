# Chapter 2 Examples: How to Work Well on Teams

Every substantive example, case study, and anecdote from Chapter 2 of *Software Engineering at Google*, retold in plain language.

## "Help Me Hide My Code" — the Google Code requests

**Setup.** The author (Brian Fitzpatrick) and his colleague Ben Collins-Sussman launched Google's open source Project Hosting service (Google Code) in 2006 and fielded user requests at conferences and online.

**What happened.** By mid-2008 a pattern emerged in the requests: users wanted the ability to hide specific Subversion branches, to create open source projects that start hidden and are revealed only "when they're ready," and to wipe all version history so they could rewrite code from scratch.

**Lesson.** The common theme is insecurity. People fear others seeing and judging unfinished work. The authors treat this insecurity as a symptom of a deeper problem in software development culture — the instinct to hide work until it looks perfect.

## The Genius Myth: Linus, Guido, Gates, Jobs

**Setup.** Engineers idolize figures like Linus Torvalds, Guido van Rossum, and Bill Gates as lone heroes who changed the world.

**What happened.** The reality behind each legend is collective. Linus wrote only the beginnings of a proof-of-concept Unix-like kernel and posted it to an email list; modern Linux is hundreds of times bigger and was built by thousands of contributors, so Linus's real achievement was leading and coordinating them. (Unix itself was not written solely by Ken Thompson and Dennis Ritchie but by a group at Bell Labs.) Guido wrote the first version of Python, but hundreds of others contributed ideas, features, and fixes to later versions. Steve Jobs led an entire team that built the Macintosh. Bill Gates wrote a BASIC interpreter, but his bigger achievement was building a company around MS-DOS.

**Lesson.** The Genius Myth is the human need to ascribe a team's success to a single leader. These figures became symbols of their communities' collective achievements, not solo miracle workers.

## Michael Jordan and Phil Jackson

**Setup.** The same idolization happens outside software: basketball fans credit Michael Jordan personally with his championships.

**What happened.** Jordan did not win games by himself. Coach Phil Jackson recognized that one player never wins a championship alone and assembled a "dream team" around Jordan. Jordan's true genius was how he worked with that team, which was as impressive a machine as Jordan himself.

**Lesson.** Even the most celebrated individual performers succeed through teams built deliberately around them.

## The solo-genius fantasy script

**Setup.** The chapter spells out the daydream many engineers secretly hold.

**What happened.** The fantasy: you are struck by an awesome concept, vanish into your cave for weeks or months building a perfect implementation, then "unleash" the software on the world; peers are astonished, users line up, and fame and fortune follow.

**Lesson.** Reality check: you are probably not a genius, actual geniuses are rare, and even geniuses make mistakes. The fantasy drives hiding behavior, and hiding is exactly what puts projects at risk. What makes or breaks a career is collaboration, since 100% of the work requires social skill.

## The bicycle gear-shifter inventor

**Setup.** A thought experiment: you are a bicycle-design enthusiast with a brilliant idea for a completely new gear shifter.

**What happened.** You spend weeks holed up alone in your garage building a prototype, telling no one — not even your bike-advocate neighbor — because you want the reveal to be perfect. Months pass and the prototype still doesn't work, but secrecy means you can't ask mechanically inclined friends for advice. Then the neighbor rolls out his bike with a radical new gear-shifting mechanism: he had been building something very similar with help from friends at the bike shop. When you finally show him your work, he points out simple design flaws that could have been fixed in the first week if you had shared it.

**Lesson.** Hiding work forfeits early error detection, slows you down relative to people who collaborate, and risks being overtaken. Feedback solicited early lowers the high risk of early missteps.

## Case study: engineers and offices

**Setup.** Twenty-five years ago conventional wisdom said a productive engineer needed a private office with a door, to guarantee big uninterrupted slabs of concentration time.

**What happened.** The author argues private offices are not just unnecessary but dangerous, because software is written by teams and a high-bandwidth connection to your team matters more than uninterrupted time — all the focus in the world is wasted if you're building the wrong thing. But modern companies (including Google in places) swung to the opposite extreme: open floor plans with a hundred-plus people and no walls, where every tiny conversation is public and people stop talking to avoid annoying dozens of neighbors — just as bad as private offices. The recommended middle ground: rooms of four to eight people, where spontaneous conversation is easy and non-embarrassing.

Teams also need interruption-filtering conventions. One team used a vocal interrupt protocol: to talk to Mary you would say "Breakpoint Mary"; if Mary could stop she would swing her chair around, and if she was too busy she would just say "ack" and you'd return later. Other teams use tokens or stuffed animals on monitors to mean "emergencies only," or noise-canceling headphones, which double as a widely understood do-not-disturb signal. Living in headphones-only mode all day, though, is as isolating as an office with a closed door.

**Lesson.** Balance focus and availability. Engineers need uninterrupted coding time and a low-friction connection to teammates; if less-knowledgeable teammates feel a barrier to asking you questions, that is a problem. Finding the balance is an art. (A footnote concedes that serious introverts may genuinely benefit from quieter environments.)

## Richard Hamming and the secretary

**Setup.** Richard Hamming was a famous Bell Labs researcher whose lecture "You and Your Research" the chapter quotes.

**What happened.** Hamming made a habit of telling jokes to the secretaries and being friendly. One day all the document-reproduction services at his site (Murray Hill) were tied up and he needed something reproduced. His secretary called a contact at another site (Holmdel), took the company car on an hour-long trip, got the job done, and came back — extra effort she volunteered because of the goodwill Hamming had built.

**Lesson.** Do not underestimate the social game. It is not manipulation; it is building relationships to get things done, and relationships always outlast projects. Coworkers with whom you have real relationships will go the extra mile.

## Hamming on John Tukey's ego (the cost of asserting your way)

**Setup.** A second Hamming quote, about the statistician John Tukey.

**What happened.** Tukey always dressed very casually, and in important meetings it took a long time before others realized he was a first-class mind worth listening to; he constantly had to overcome that initial hostility. Hamming's point: you need not conform, but "the appearance of conforming gets you a long way." If you insist on asserting your ego — "I am going to do it my way" — you pay a small steady price throughout your entire career that adds up to an enormous amount of needless trouble, like fighting a lifelong undeclared war against the system instead of learning to make the system do your work.

**Lesson.** Ego creates friction that slows you down. Study how to work with the system rather than against it.

## The Apache Software Foundation's collective ego

**Setup.** An example of channeling ego productively.

**What happened.** The Apache Software Foundation has a long history of building communities around software projects. Those communities develop incredibly strong shared identities and reject people who care more about self-promotion than the group.

**Lesson.** Replace personal ego with a "collective" ego: invest in team accomplishment and group pride instead of personal awesomeness.

## Joe and the unwelcome code reviews

**Setup.** Joe started a new job as a programmer and, caring about the codebase, began gently questioning teammates' contributions in his first weeks — emailing simple code reviews that politely asked about design assumptions or pointed out improvable logic.

**What happened.** After a couple of weeks Joe was summoned to the director's office and told there had been many complaints: teammates felt he was harshly criticizing them left and right, and they were upset. Joe was baffled — he expected the reviews to be welcomed.

**Lesson.** Joe misread the team's widespread insecurity. Introducing a practice like code review into a culture that lacks it requires a subtler approach — for example, discussing the idea with the team first and asking them to try it for a few weeks. Criticism lands differently depending on the trust already in place.

## The wrong way and right way to critique code

**Setup.** A worked example of phrasing feedback to an insecure collaborator.

**What happened.** The wrong version: "Man, you totally got the control flow wrong on that method there. You should be using the standard xyzzy code pattern like everyone else." This packs in three antipatterns — declaring the person "wrong" as if the world were black and white, demanding a change, and implying they are stupid for deviating from what everyone else does. The collaborator goes on the defensive and responds emotionally. The better version: "Hey, I'm confused by the control flow in this section here. I wonder if the xyzzy code pattern might make this clearer and easier to maintain?" Humility makes the question about you rather than them, the suggestion is framed as helping the project's long-term maintainability, and nothing is demanded — the collaborator can peacefully decline.

**Lesson.** Constructive criticism keeps the discussion on the code, never on anyone's value or skill. Tactful phrasing is a skill acquired with practice and is itself an expression of respect.

## The $10 million mistake

**Setup.** A well-known business urban legend (attributed to various famous managers).

**What happened.** A manager makes a mistake that loses the company $10 million. The next day he packs up his desk, and when the CEO summons him he slides his resignation across the desk, assuming he is being fired. The CEO responds: "Fire you? Why would I fire you? I just spent $10 million training you!"

**Lesson.** Firing the person would not undo the loss — it would compound it by losing an executive who will now never make that mistake again. Failure is training; treat it as a golden opportunity to learn rather than a cause for punishment. (Related Edison quote: finding 10,000 ways something won't work is not failure but progress. Related footnote: failing the same way repeatedly is not failure, it's incompetence.)

## Google X's incentive to kill ideas fast

**Setup.** Google X is the Google division that pursues "moonshots" such as self-driving cars and balloon-delivered internet access.

**What happened.** Failure is deliberately built into the incentive system. People propose outlandish ideas and coworkers are actively encouraged — and rewarded, even competitively — to disprove or invalidate as many ideas as possible in a fixed period. Only a concept that no peer can debunk at a whiteboard proceeds to an early prototype.

**Lesson.** Institutionalizing cheap fast failure filters ideas before they consume real resources. "Failure is an option": if you're not failing sometimes, you're not taking enough risks.

## The CVS conversion tool: Fitz and Karl's pairing conflict

**Setup.** The author was writing a tool to convert CVS version-control repositories to Subversion (and later Git). CVS's quirks kept surfacing bizarre bugs, and his longtime friend and coworker Karl knew CVS intimately, so they decided to fix the bugs together.

**What happened.** Pair programming broke down. The author is a bottom-up engineer who dives into the muck and tries many things quickly while skimming details; Karl is a top-down engineer who wants the full lay of the land and reads the implementation of nearly every method on the call stack before touching the bug. The mismatch caused epic conflicts and heated arguments until they simply could not pair-program anymore. But their long history of trust and respect, combined with patience, let them improvise a new method: sit together to identify the bug, split up to attack it from both directions at once (top-down and bottom-up), then reconvene with findings.

**Lesson.** Working-style clashes are real even between people who trust each other. Patience and willingness to invent a new collaboration style saved both the project and the friendship. Know your own preferred working style and that of others.

## Politicians never admit error

**Setup.** A contrast case for the value of vulnerability.

**What happened.** Professional politicians are notorious for never admitting error or ignorance even when obviously wrong, because they are under constant attack by opponents. As a result most people don't believe a word politicians say.

**Lesson.** Engineers don't need that defensive posture: teammates are collaborators, not competitors, sharing the same goal. Admitting mistakes or saying "I don't know" demonstrates humility, accountability, and trust — and increases your status and credibility over the long run.

## "Googley" and the bias problem

**Setup.** From Google's earliest days, employees described actions as "Googley" or "not Googley" — an undefined shorthand for "do the right thing" or "be good to each other" — and the term crept into interview assessments and performance reviews ("coded well, but didn't seem to have a very Googley attitude").

**What happened.** Google realized the undefined term was overloaded and risked becoming a source of unconscious bias: if "Googley" means something different to everyone, it drifts toward meaning "is just like me," which is the opposite of hiring for diverse backgrounds and viewpoints. An interviewer wanting to have a beer with a candidate is not a valid signal of ability. Google fixed the problem by defining an explicit "Googleyness" rubric of attributes exemplifying humility, respect, and trust: thrives in ambiguity; values feedback; challenges the status quo; puts the user first; cares about the team; does the right thing. Google then began moving away from the word "Googley" itself.

**Lesson.** Vague culture-fit labels invite bias. Always be specific about behavioral expectations.
