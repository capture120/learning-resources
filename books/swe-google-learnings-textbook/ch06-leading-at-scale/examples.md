# Chapter 6 "Leading at Scale" — Examples, Case Studies, and Anecdotes

*From "Software Engineering at Google" (Ben Collins-Sussman). Each example is retold in plain language with the lesson the book draws from it.*

## The Parable of the Airplane (trade-offs with unforeseen consequences)

**Setup.** Lindsay Jones, a professional theatrical sound designer and frequent flyer, tells a true story from a 6 a.m. flight. Ground crew had somehow overfilled the plane's fuel tank by 10,000 gallons. The captain offered two options: wait over an hour for a truck to pump the fuel back out, or have twenty passengers get off immediately to even out the weight.

**What happened.** Nobody moved. An indignant first-class passenger who "could not be late for this meeting" pulled out a wad of cash and paid twenty people $40 each ($800 total) to leave the plane. The lightened plane taxied out — and then its computer failed for unrelated reasons, forcing a tow back to the gate. The furious passenger demanded another flight. The only earlier option, the 8 a.m. flight, had just filled up: twenty suspiciously happy passengers had shown up out of nowhere and taken every open seat. He ended up on the 9:30 flight, too late for his meeting, sitting quietly with the narrator.

**Lesson.** Trade-offs apply to human behavior, not just engineering systems. As a leader you decide every week what your teams should do. Some trade-offs are obvious ("if we work on this project, it delays that other one"). Others have unforeseeable consequences that come back to bite you, exactly like paying passengers off the plane only to find them occupying your backup flight.

## Case Study: Addressing the "Latency" of Web Search (blinders, trade-offs, iteration)

**Setup.** Google Web Search is Google's oldest product. For years, thousands of engineers improved the "quality" of the results page: what began as ten blue links grew images, videos, Wikipedia fact boxes, and interactive elements. Each quality improvement made servers do more work and sent more bytes to (usually mobile) clients. Despite faster networks and computers, the page got slower and slower — its latency increased. Latency directly affects user engagement in aggregate; even 10-millisecond increases in rendering time matter. No single team was at fault; the book calls it "a long, collective poisoning of the commons." Eventually the accumulated latency began canceling out the engagement gains from the quality improvements.

**What happened.** For years, leaders wore blinders: the assumed fix was to declare a latency "code yellow" (Google's term for an emergency hackathon where affected teams drop everything to fix a critical problem) every two or three years. Speed improved temporarily, then latency crept back within a month or two. The breakthrough came from stepping back and reevaluating the trade-offs. Quality has two costs, not one: a cost to the user (more data sent means more latency) and a cost to Google (more work per query means more CPU, i.e., "serving capacity"). Leadership had long balanced quality against capacity but had never treated latency as "a full citizen in the calculus." The trade-offs form a triangle — Good (Quality), Fast (Latency), Cheap (Capacity), pick two. Improving any one deliberately harms at least one other: more data on the page improves quality but hurts capacity and latency; sending more traffic to a serving cluster improves hardware utilization (capacity) but resource contention worsens per-query latency; running a cluster "cooler" makes queries faster but wastes capacity. Once latency became a first-class goal, data scientists measured exactly how much latency hurt user engagement and built a metric pitting quality-driven short-term engagement gains against latency-driven long-term engagement damage. That let Google quantitatively decide whether a change that improves quality but hurts latency is worth launching — deciding and iterating every month.

**Lesson.** This is Always Be Deciding in full: identify the blinders (code-yellow-and-repeat thinking), identify all the trade-offs (quality vs. latency vs. capacity), then decide and iterate with data rather than hunting for a permanent fix.

## Subdividing the Latency Problem: Causes vs. Symptoms (dividing the problem space)

**Setup.** Having decided to control Search latency long-term, leadership needed an organizational structure for the work.

**What happened.** They split the problem into two spaces: work addressing the *symptoms* of latency (many projects optimizing the codebase for speed) and work addressing the *causes* (preventing latency in the first place). Speed work alone was insufficient because thousands of engineers kept adding quality and complexity, undoing speed improvements as fast as they landed. The causes-focused teams found gaps in metrics, in latency-analysis tools, and in developer education and documentation. Working both fronts simultaneously brought latency under systematic long-term control.

**Lesson.** Divide an ambiguous problem into subproblems and staff teams against them in parallel — and note that the teams owned *problems*, not specific solutions.

## The Master and the Chalk Mark (the 95/5 rule of adjustment)

**Setup.** A parable from "Debugging Teams" (Brian W. Fitzpatrick and Ben Collins-Sussman, O'Reilly, 2016). A retired Master of all things mechanical is called back because his former company has a machine problem nobody can fix.

**What happened.** The Master examined the machine, listened to it, then drew a small chalk X on its side and said a loose wire needed repair at that exact spot. The technician tightened the wire and the machine was fixed. The Master invoiced $10,000. The irate CEO demanded an itemized breakdown for a mere chalk mark. The Master sent one: $1 for the chalk, $9,999 for knowing where to put it.

**Lesson.** A single carefully considered adjustment can have gigantic effects. Applied to managing people via the accompanying blimp image: imagine your team as a great blimp heading slowly in a direction; instead of continuous micromanaged course corrections, spend most of the week watching and listening, then make one small precise "chalk mark" tap to adjust course. Good management is 95% observation and listening and 5% critical adjustments in just the right place. Regressing into micromanagement makes you a single point of failure again.

## The Git Repositories Team (anchoring identity to a solution vs. a problem)

**Setup.** A hypothetical but pointed example about team identity. A product is a solution to a problem; solutions can be short-lived, while a well-chosen problem is evergreen.

**What happened.** A team defines itself as "the team that manages the Git repositories." When a large share of the company's engineers want to switch to a new version control system, the team digs in, defends Git, and resists the change even when the change is best for the organization — the solution has become part of the team's identity and self-worth, and the team clings to its blinders. Had the team instead owned the problem — "the team that provides version control to the company" — it would have been free to experiment with different solutions over time.

**Lesson.** Anchor a team's identity to a general problem, not a specific product or solution.

## The Vacation Email Litmus Test (detecting that you are a single point of failure)

**Setup.** A single point of failure (SPOF) is a person whose absence dooms the work; the "bus factor" is the number of people who must be hit by a bus before a project is doomed.

**What happened.** The book offers two self-tests. First: imagine you, the leader, disappear — does your team keep going and keep succeeding? Second and simpler: on your last vacation of at least a week, did you keep checking work email? Most leaders do. If things would fall apart without your attention, you have made yourself an SPOF.

**Lesson.** Checking email on vacation is diagnostic evidence that you have not built a self-driving organization, and you need to fix that.

## The Cycle of Success and the Compression Stage (why success punishes you)

**Setup.** A recurring pattern the book observes whenever a team tackles a difficult problem: Analysis (wrestle with the problem, find blinders and trade-offs, build consensus), Struggle (start before you feel ready, herd cats, fake confidence at first), Traction (real progress, better decisions, rising morale), Reward.

**What happened.** The reward for success is not just congratulations from your manager — it is a whole new, equally difficult, usually adjacent problem, and usually no additional people. Now the original problem must be managed with half as many people in half the time so the other half can take the new work. The book calls this the compression stage, and the overall cycle is really a spiral: over months and years the organization scales by repeatedly tackling and compressing problems, with hiring rarely keeping pace. Google founder Larry Page would call the spiral "uncomfortably exciting."

**Lesson.** Scaling a team of teams runs on this spiral. Surviving it requires compressing problems (efficiency) and scaling your own time and attention to the widening breadth of responsibility.

## Eisenhower's Urgent vs. Important (the reactive-mode trap)

**Setup.** As an individual contributor, work is a calm, methodical list. As a leader, work turns reactive: escalations flow up, and email, chat, and meetings feel like a Denial-of-Service attack on your attention. The book quips that the leader is the "finally" clause in a long list of code blocks.

**What happened.** US President Dwight D. Eisenhower popularized the distinction in a famous 1954 quote: "I have two kinds of problems, the urgent and the important. The urgent are not important, and the important are never urgent." Management author Stephen Covey later made the idea famous in business writing. Without mindfulness, a leader slides into 100% reactive mode, spending all time on urgent things that almost never matter in the big picture, while the truly important work — like mapping strategy through the forest — is never urgent and always loses to the next email.

**Lesson.** Force yourself onto important work through three techniques: delegate urgent items to other leaders (it trains them), schedule dedicated two-plus-hour blocks for important-but-not-urgent work, and adopt a task-tracking system that actually works for you (to-do software, the Bullet Journal method, or David Allen's "Getting Things Done").

## Marie Kondo Applied to Your Task Pile (learning to drop balls)

**Setup.** Marie Kondo is an organizational consultant and author of "The Life-Changing Magic of Tidying Up," a book about decluttering physical possessions. Her model: about 20% of possessions are useless and easy to discard, 60% are a mixed middle, and 20% are exceedingly important — the things that "spark joy." Her thesis is that people declutter incorrectly by tossing the bottom 20%; the true work is identifying the top 20% and tossing the other 80%.

**What happened.** The book applies the same split to a leader's inbox and task list. Bottom 20%: neither urgent nor important, easy to ignore. Middle 60%: a mixed bag. Top 20%: critically important things only you can do. Do not try to work the top 80% — you will stay overwhelmed and stuck on urgent-but-unimportant tasks. Focus strictly on the top 20% and give yourself explicit permission to drop the rest. Two amazing things follow: subleaders often notice and pick up dropped middle-60% balls automatically, and anything truly critical comes back and migrates into your top 20%.

**Lesson.** Dropping balls is inevitable; dropping them deliberately gives you control and lets your time and attention scale with your group's growing responsibilities.

## The Work Profile Phone Trick (making disconnection trivial)

**Setup.** Real vacations recharge you only with total disconnection — a weekend is not a vacation, it takes at least three days to forget work and a week to feel refreshed, and one glance at work email floods worry back and destroys the psychological distance.

**What happened.** The book's concrete tactic: leave the work laptop at the office, and put work apps (for example G Suite — Gmail, Google Calendar) in a separate "work profile" on your phone. You get two Gmail apps, one personal and one work-badged. On Android, one button disables the entire work profile: all work apps gray out as if uninstalled, so you cannot "accidentally" check work messages until you re-enable it.

**Lesson.** Engineer your environment so disconnecting takes one action. Pair this with real weekends (sign out Friday night, sign in Monday), 10-minute breaks aligned with the brain's natural 90-minute rest-activity cycles, and mental health days — a leader in a foul mood sets the tone for everyone and does active damage, so going home beats staying.

## The Expert-on-Vacation Trick (fighting imposter syndrome in the Struggle phase)

**Setup.** In the Struggle phase of the cycle of success, the leader must devise strategy before anyone knows the answers, which invites imposter syndrome.

**What happened.** The book's footnoted technique: pretend some expert out there knows exactly what to do, that they are simply on vacation, and that you are temporarily subbing in for them.

**Lesson.** The pretense removes the personal stakes and gives you permission to fail and learn while still acting decisively.
