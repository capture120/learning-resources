# Chapter 10: Technical Design Process

Jumping straight into code works at first, but eventually you'll get a task too big to jump into; it needs deliberate technical design. The technical design process helps everyone agree on a design for a large change by alternating solitary deep-thought work (research, brainstorming, writing) with collaborative work (discussions and design-document feedback), with a design document as the tangible output. The full process described here suits large changes; it can look slow and intimidating — some engineers are traumatized by heavyweight design processes gone awry — so scale it down for smaller changes. You'll develop a feel for the right amount of input and collaboration a problem needs; early in your career err on the side of caution — ask your tech lead or manager for guidance and share your design widely. Done correctly, participating in and leading technical design work is rewarding and valuable.

## Core Concepts

### The Technical Design Process Cone

Designing software is not a linear march from research to documentation to approval. It is a spiral that alternates between independent work and collaborative work, clarifying and refining the design at every step. Picture an inverted cone: the spiral starts narrow at the bottom and widens as it climbs. Width is the amount of work done (split between independent and team work); height is certainty and clarity; the circle of people involved grows from a teammate, to your team, to multiple teams.

With every iteration the design document becomes clearer and more detailed. Your confidence grows, as does the body of work behind the design — experiments, proofs of concept, benchmarks — and the number and variety of people consulted.

The progression:

1. **Base of the cone.** You're unclear about the problem space, requirements, and possible solutions. So early on, a confident solution is impossible.
2. **Research.** Bounce between independent work and discussion with a small group of teammates or domain experts. Brainstorm and experiment. The goal is to learn — to increase certainty and clarity.
3. **Preferred design emerges.** Sanity-check it with the people you've been working with, then write a design document. Writing surfaces more unknowns. Build small prototypes to validate designs, answer questions, and choose between viable alternatives. Do more research; ask experts for input. Flesh out a draft.
4. **Circulate to your team.** You're now more certain you understand the problem space; prototypes give increasing confidence in the solution. Share the proposal with your team, gather feedback, and research, discuss, and update the document.
5. **Circulate across the organization.** Significant work is now invested and you're confident in the approach. Security, operations, adjacent teams, and architects all need to be made aware — not just to give feedback, but to update their mental model of how the system works.
6. **Implementation.** After approval, implementation begins, but design isn't over. Implementation surfaces surprises; update the design document if the code deviates significantly from the plan.

### Thinking About Design (Exploration)

The base of the design funnel is exploration: understanding the problem space and requirements before developing a design. Exploration requires thinking, research, experimentation, and discussion — it is both an individual and a team sport.

#### Define the Problem

Your first task is to define and understand the problem(s) you're solving. Understanding the problem's boundaries tells you how to solve it and keeps you from building the wrong thing. You might even discover there is no problem, or that the problem isn't worth solving.

- Ask stakeholders (manager, teammates, product managers, tech leads) what they perceive the problem to be. Not everyone perceives it the same way.
- Restate the problem in your own words back to stakeholders and ask whether your understanding matches theirs. If there are multiple problems, ask which have the highest priority.
- Ask "What happens if we don't solve this problem?" — a powerful question. When stakeholders answer, ask whether that outcome is acceptable. Many problems don't actually need to be solved.
- Synthesize the collected feedback into a clear problem statement. Don't take problem descriptions at face value; think critically about what you've been told.
- Pay particular attention to scope — what's included, and what could be included but isn't. Don't take the union of all problems from all stakeholders; that gets unwieldy. Don't be afraid to trim low-priority changes.
- Write the problem statement — both what's in and out of scope — and circulate it to validate your understanding and get feedback.

A well-refined problem statement focuses on the problem and its priorities rather than presupposed solutions, and it often leads to a very different (and better) solution than the original feature request implied.

#### Do Your Research

Don't go straight from problem definition to a "final" design. Consider relevant research, alternative solutions, and trade-offs. Your design should be not your first idea but your best.

- Look at how others solved similar problems. Company engineering blogs describe real solutions, though they're partially marketing and often present simplified architectures that elide the tricky bits; use them to get a general sense, and consider contacting authors via email or social networks for details that didn't make the post.
- Check industry conferences — slide decks and recordings are usually posted online.
- Read academic research and white papers; mine the references section for further reading.
- Talk to experts in the problem space, inside and outside your company. Many blog and paper authors and conference presenters are eager to discuss their work — just don't divulge proprietary company information to outsiders.
- Think critically: not everything you read online is a good idea. A particularly common misstep is copying wholesale a solution to a problem that is similar but not identical to yours. Your problems aren't Google's — possibly even if you work for Google — even when they look similar.

#### Conduct Experiments

Experiment with your ideas by writing draft code and running tests: draft APIs, partial implementations, performance tests, even A/B user tests to learn how systems and users behave. Experiments give you confidence in your ideas, expose design trade-offs, and clarify the problem space; you also get a feel for how your code will be used. Circulate prototypes with your team for feedback.

Don't get attached to experimental code. Proof-of-concept code exists to illustrate an idea and be thrown away or rewritten. Don't write tests for it or polish it — you're trying to learn as much as you can as quickly as possible.

#### Give It Time

Good design takes creativity; don't expect to bang out a design in one sitting. Give yourself large chunks of time, take breaks, change your scenery, and be patient.

- Design requires deep thought and cannot be done in 15-minute increments; you need several hours of focus. Uninterrupted time is precious for "makers" (per Paul Graham's "Manager's Schedule, Maker's Schedule"). Figure out when you can best sustain deep concentration and block that time on your calendar — different people peak at different times of day.
- Interruptions kill deep work. Close chat, turn off email, disable phone notifications, and consider working from a different spot. If you switch locations, bring the tools you need — whiteboard, notebook, papers.
- You won't be actively "designing" the whole blocked time. Your brain needs room to breathe: take breaks, go for a walk, make tea, read, write, draw diagrams, and let your mind wander.
- Design is a 24-hour-a-day gig. Your brain keeps mulling ideas; thoughts arrive randomly through the day and even in sleep.
- A relaxed approach doesn't mean taking forever — you still have delivery dates. Design spikes manage the tension between creative work and predictable delivery: a spike is an Extreme Programming term for a time-bounded investigation. Allocating a spike task in a sprint gives you space for deep thought without other tasks hanging over you.

### Writing Design Documents

Design documents are a scalable way to clearly communicate ideas. The act of writing structures your thinking and highlights areas of weakness. Documenting doesn't always come naturally; to create useful design documents, focus on the most consequential changes, keep the goal and audience in mind, practice writing, and keep documents up to date.

#### Document Consequential Changes

Not every change needs a design document, much less a formal review. Follow your organization's guidelines; absent those, write a design document if any of these three criteria hold:

1. **The project will require at least a month of engineering work.** If implementation will take a while, up-front design time ensures you're not heading down the wrong path.
2. **The change has long-lasting implications for extending and maintaining the software.** Some changes are quick to introduce but carry long-term ramifications — new infrastructure like a caching layer, network proxy, or storage system; a new public API; a security measure. The fast way to add them solves an immediate problem but hides long-term costs. Writing the document and getting it reviewed gives concerns a chance to surface and be addressed, and ensures the whole team understands what is being added and why, avoiding surprises later.
3. **The change significantly impacts other teams.** Teams need to know what you're doing so they can give feedback and accommodate your changes. Broad-reach changes often force code reviews or refactoring elsewhere, and other designs might be impacted; the document notifies teams of your forthcoming changes.

#### Know Why You're Writing

Superficially, design documents tell others how a software component works, but their function exceeds simple documentation. A design document is a tool to:

- **Help you think.** Writing exposes what you don't know. Pushing yourself to write the design down forces you to explore the problem space, crystallize your ideas, and confront alternative approaches and gaps in understanding. The process is turbulent, but you come out understanding your design and its trade-offs far better, and that clarity makes design discussions more productive.
- **Get feedback.** It's easier to solicit feedback on a written design: documents circulate widely, and others can read and respond on their own time. Even when feedback is minimal, circulating the document keeps the team informed.
- **Keep your team informed.** Spreading design knowledge helps others maintain an accurate mental model of how the system works. The team makes better design and implementation decisions later, and on-call engineers correctly understand system behavior. Engineers also learn from teammates' documents.
- **Ramp up new engineers.** Without design documents, new engineers crawl through code, draw box diagrams, and tease knowledge out of senior engineers. Reading a trove of design documents is far more efficient.
- **Drive project planning.** Managers and tech leads use design documents for planning. Many include milestones or implementation steps, and a concrete written design eases coordination with other teams on cross-functional projects.

#### Learn to Write

Don't be intimidated if you feel you aren't a good writer. Writing is a skill developed through practice: take every opportunity — design documents, emails, code review comments — and try hard to write clearly.

Writing is a lossy method of information transfer: you write your ideas down, and teammates reconstitute them imperfectly in their minds. Good writing improves the fidelity of that transfer. It's also a career builder: well-written documents circulate easily to large groups, including executives, and strong writers don't go unnoticed.

Reread your writing from the target audience's perspective — it doesn't matter if *you* understand it; what matters is whether *they* do. Be concise. Read what others have written and think about how you'd edit it: what's extra, what's missing. Seek out good document writers in your company and ask them for feedback on your work.

Non-native speakers: don't let language barriers discourage you from writing design documents. Software engineering is a global trade, and it's rare for everyone on a team to share a native tongue. Perfect grammar doesn't matter; expressing your thoughts clearly does.

#### Keep Design Documents Up-to-Date

A design document starts as a proposal; once implementation begins, it morphs into a description of how the software is actually implemented — a living document. Two common pitfalls occur in this transition:

1. **The proposal is abandoned and never updated.** Implementation diverges, and the document misleads future readers.
2. **The document is updated but the proposal's history is lost.** Future developers can't see the discussions that led to design decisions and may repeat past mistakes.

Keep documents up to date as you go. If your organization separates design proposals from documentation (as Python separates PEPs from its documentation), keep documentation current with implemented proposals. Hold others to the same standard during code reviews.

Version control your design documents. A good trick is to keep them in the same repository as the code: code reviews then double as design-comment reviews, and documents can be updated as code evolves. Not everyone likes reviewing design docs in Markdown or AsciiDoc; if you prefer a wiki, Google Docs, or Word, keep the entire document history available, including discussions.

### Using a Design Document Template

A design document should describe the current code design, the motivation for a change, potential solutions, and the proposed solution — with details such as architectural diagrams, important algorithmic details, public APIs, schemas, trade-offs with alternatives, assumptions, and dependencies. There's no one-size-fits-all template; open source projects' design documents (Python Enhancement Proposals, Kafka Improvement Proposals, Rust RFCs) show how major changes get documented. Use your team's template if one exists; otherwise, try this structure:

- **Introduction.** Introduce the problem and say why it's worth solving. Give a paragraph-long summary of the proposed change and guidance pointing different readers — security engineers, operations engineers, data scientists — to the sections relevant to them.
- **Current State and Context.** Describe the architecture being modified and define terminology. Explain what systems with nonobvious names do. Cover how the issue is currently being addressed: what workarounds exist and what their drawbacks are.
- **Motivation for Change.** Teams have more projects than they can tackle at once — explain why this problem is worth solving and why now. Describe the benefits and tie them to business needs (a raw technical win is weaker than the same win connected to adoption, revenue, or another business outcome). Don't overpromise.
- **Requirements.** List what an acceptable solution must meet, broken into: **user-facing requirements** (usually the bulk — the nature of the change from the user's perspective), **technical requirements** (hard constraints from interoperability or strict internal guidelines; service level objectives can be defined here), **security and compliance requirements** (broken out separately so security needs are explicitly discussed; data retention and access policies often go here), and **other** (critical deadlines, budgets, other important considerations).
- **Potential Solutions.** There are usually multiple ways to solve a problem. Writing this section is as much a tool for you as for the reader: it forces you to think through alternatives and their trade-offs, not just your first idea. Describe reasonable alternatives and why you dismissed them. This preemptively answers "Why not do X?" comments; if you dismissed a solution for the wrong reasons, commenters can catch the misunderstanding; and readers might identify alternatives you hadn't considered.
- **Proposed Solution.** Describe the solution you settled on, in more detail than the introduction, possibly with diagrams highlighting changes. If the proposal has multiple phases, explain (here and in following sections) how the solution evolves from phase to phase.
- **Design and Architecture.** Normally the bulk of the document — all the technical minutiae worth discussing. Highlight implementation details of interest: key libraries and frameworks, implementation patterns, and any departures from common company practices. Include block diagrams of components, call and data flow, and UI, code, API, and schema mock-ups. Subsections:
  - **System Diagram.** Show the main components and how they interact. Make changes visible by highlighting new and changed components or using before-and-after diagrams, with prose walking the reader through the changes.
  - **UI/UX Changes.** Create mock-ups if the project changes user interfaces, and use them to walk through a user's activity flow. With no visual component, discuss developer experience — how someone will use your library or command line tool. The goal is to think through the experience of the people who interact with your change.
  - **Code Changes.** Describe the implementation plan: what, how, and when existing code will change, and any new abstractions to introduce.
  - **API Changes.** Document changes to existing APIs and any new APIs. Discuss backward/forward compatibility and versioning. Include error handling: the API should respond with useful information for malformed inputs, constraint violations, and unexpected internal errors.
  - **Persistence Layer Changes.** Explain storage technologies introduced or modified: new databases, file and filesystem layouts, search indices, data transformation pipelines. Include all schema changes with notes on their backward compatibility.
- **Test Plan.** Don't define every test in advance; explain how you plan to verify your changes. Discuss sourcing or generating test data, highlight use cases that need coverage, name libraries and testing strategies you expect to use, and explain how you'll validate that security requirements are met.
- **Rollout Plan.** Describe strategies for avoiding complicated deployment ordering requirements. Document the feature flags that will control the rollout and which deployment patterns you'll use. Think about how you would find out if changes are *not* working and how you'll roll back if problems are discovered.
- **Unresolved Questions.** Explicitly list pressing questions the design hasn't answered yet. This solicits input from readers and states your "known unknowns."
- **Appendix.** Extra details of interest, plus references to related work and further reading.

### Collaborating on Design

Constructive collaboration leads to better design, but it isn't easy — developers are opinionated, and condensing feedback into a coherent design takes work. Collaborate by working within your team's design processes, communicating early and often to avoid surprises, and using design discussions to brainstorm.

#### Understand Your Team's Design Review Process

Design reviews notify architects of large upcoming changes and give leads a chance to provide feedback. Some organizations have robust review policies; others are informal. Two common patterns:

- **Architectural reviews** are formal and heavyweight. Designs must be approved by outside stakeholders such as operations and security; a design document is required, and there may be multiple rounds of meetings or presentations. Because of the high time cost, architectural reviews are reserved for large or risky changes.
- **Request for decision (RFD)** is a fast intrateam review for decisions that need some discussion but not a full review (the term isn't common, but the pattern is; don't confuse it with the Internet Society's RFC). The requesting engineer circulates a quick write-up describing the decision to be made — a lightweight design document. Teammates whiteboard, discuss the options, provide input, and make a decision.

Don't wait on final approval before writing code: build prototypes and proof-of-concept "spikes" to increase confidence in the design and shorten the path to production. But don't go beyond proof-of-concept work — you'll probably have to change your code based on design feedback.

Other review patterns exist; what matters is understanding which processes your team follows. Missing a design review step can derail your project at the last moment. Find out who must be informed of or sign off on your design work, and who is empowered to make decisions.

#### Don't Surprise People

Gently and incrementally ease people into your design proposal. You're setting yourself up for failure if a formal design document is the first time other teams and tech leads learn of your work — each party has its own point of view and interests and may react strongly to a sudden document they had no say in.

Instead, get early feedback from other teams and tech leads during initial research. This leads to a better design, keeps them aware of your work, and gives them a stake in it; people involved early can become champions of your work later. Feedback sessions don't need to be formal or scheduled — casual conversations over lunch, in a hallway, or before meetings are fine, even preferred. The goal is simply to make people aware of what you're doing, give them a chance to comment, and get them thinking about your work.

Keep people up to date as you progress: give updates in status meetings and standups and continue casual conversations. Pay attention to the second-order effects your changes might have and whom they impact; notify affected teams — support, QA, and operational teams in particular. Be inclusive: pull people into brainstorming sessions and listen to their thoughts.

#### Brainstorm with Design Discussions

Design discussions help you understand a problem space, share knowledge, discuss trade-offs, and solidify a design. They are informal: conversation is free-flowing and whiteboards fill with ink. They happen early in the design cycle, when the problem is reasonably well understood but the design isn't settled — a draft design document should exist but may still have gaps and open questions. Break brainstorming into multiple sessions with different participants focusing on different aspects of the design.

- **Size:** two to about five people. Go larger and more inclusive when a problem is particularly multifaceted or controversial; keep invitee lists small for straightforward discussions so conversation flows easily.
- **Time:** schedule large chunks — around two hours. Ideas need time to develop. Don't cut discussions short; let people run out of ideas or simply get exhausted. You may need more than one session to reach a conclusion.
- **Before:** prepare a loose agenda covering the problem, scope, proposed design(s), potential trade-offs, and open questions. Keep it brief — participants are expected to read it beforehand, and its purpose is to provide just enough information to start a free-flowing discussion.
- **During:** don't impose too much structure; people need to jump around to explore ideas. Use a whiteboard rather than a slide deck, and speak extemporaneously if possible (referring to notes is fine).
- **Notes:** note-taking can distract from brainstorming. If your team designates a notetaker, make sure the role rotates evenly — a perpetual notetaker can't contribute. The whiteboard is itself a note keeper: photograph it as the discussion progresses, or save intermediate states of a virtual board. After the meeting, write a summary from recollection using the whiteboard images as a guide, and send it to attendees and other relevant teammates.

#### Contribute to Design

Contribute to your team's design work, not just your own. Like code reviewing, this can feel uncomfortable — you might think you have nothing to offer on a senior developer's design, and reading documents or attending brainstorming meetings might feel like a distraction. Do it anyway: your participation improves the team's designs and helps you learn.

When you join in, give suggestions and ask questions, applying the same guidance as for code reviews. Think holistically about the design — security, maintainability, performance, scale, and so on — and pay special attention to how designs impact your areas of expertise. Communicate clearly and respectfully.

Asking questions is as important as giving suggestions. Questions help you grow; as in a classroom, you're probably not the only person wondering about a design decision, so your questions help others grow too. Questions can also trigger new ideas or expose gaps in the design that no one had considered.

## Actionable Practices

The authors' own summary (their Do's and Don'ts):

- DO use a design document template.
- DO read blogs, papers, and presentations to get ideas.
- DO think critically about everything that you read.
- DO experiment with code during design.
- DO learn to write clearly, and practice often.
- DO version control design documents.
- DO ask questions about teammates' designs.
- DON'T get attached to experimental code; it will change.
- DON'T explore only one solution.
- DON'T let a non-native language deter you from writing.
- DON'T forget to update design documents if the implementation diverges from the plan.
- DON'T be reluctant to participate in team design discussions.

Additional rules of behavior from the chapter:

- Scale the design process to the change: a small change may need a three-sentence problem statement, fewer template sections, fewer feedback rounds, and no cross-team review. While new, err on the side of caution — ask your tech lead or manager for guidance and share your design widely.
- Define the problem before designing: interview stakeholders, restate the problem in your own words, ask "What happens if we don't solve this problem?", and write a problem statement that names what's in and out of scope.
- Don't take the union of all stakeholder problems; prioritize and trim low-priority items.
- Write a design document when a project needs a month or more of work, has long-lasting maintenance implications, or significantly impacts other teams.
- Block several-hour chunks of calendar time for design at your personal peak focus hours; eliminate interruptions (chat, email, phone notifications).
- Use a sprint spike task to time-box design investigation.
- Reread your documents from the target audience's perspective; cut what's extra and add what's missing. Ask strong writers for feedback.
- In the Potential Solutions section, document alternatives you rejected and why.
- In the Rollout Plan, plan feature flags, how you'd detect that the change is not working, and how you'd roll back.
- List unresolved questions explicitly to surface known unknowns and invite input.
- Prototype before design approval to build confidence and shorten the path to production — but only to proof-of-concept depth.
- Learn your team's review process: who must be informed, who signs off, who decides.
- Socialize designs early and casually; never let a formal document be someone's first exposure to your work.
- Notify teams affected by second-order effects of your change, especially support, QA, and operations.
- Run brainstorming sessions of two to five people, about two hours, with a brief pre-read agenda, a whiteboard instead of slides, rotated note-taking, and a written summary sent afterward.

## Pitfalls & Anti-patterns

- **Jumping straight into coding on a large change.** Works for small tasks; fails when the task is too big to hold in your head.
- **Treating design as linear.** Research-then-write-then-approve ignores that certainty and clarity only come from iterating between solo work and collaboration.
- **Taking problem descriptions at face value.** Stakeholders disagree, and feature requests often embed premature solutions. Critically synthesize; you may find the problem isn't worth solving.
- **Scope creep via stakeholder union.** Accepting every stakeholder's problem makes the design unwieldy.
- **Shipping your first idea.** The design you pick should be your best idea, not your first; explore alternatives and trade-offs.
- **Copying solutions wholesale.** A solution built for a similar-but-different problem (typically a giant company's architecture) likely doesn't fit yours.
- **Trusting engineering blogs uncritically.** They're partly marketing and elide tricky details.
- **Polishing or getting attached to proof-of-concept code.** It exists to teach you something fast and then be thrown away or rewritten; writing tests for it wastes time.
- **Designing in 15-minute increments.** Deep design work needs hours of uninterrupted focus.
- **Skipping the design document for "quick" infrastructure changes.** Caching layers, proxies, storage systems, public APIs, and security measures are fast to add but carry non-obvious long-term costs.
- **Abandoning the design doc after implementation starts.** The implementation diverges and the document misleads future readers.
- **Updating the doc but erasing proposal history.** Future developers can't see why decisions were made and repeat old mistakes.
- **Springing a formal design document on people with no warning.** Parties who had no say react strongly; the project can be derailed at the last moment by a missed review step.
- **Going beyond proof-of-concept before approval.** Design feedback will likely force code changes; deep pre-approval implementation is wasted work.
- **Over-structuring brainstorming or cutting it short.** Ideas need to wander and need time; let sessions run until people run out of ideas.
- **One person always taking notes.** The perpetual notetaker can't contribute; rotate the role and use whiteboard photos.
- **Staying silent on others' designs.** Believing you have nothing to offer senior engineers deprives the team of fresh questions that expose gaps — and stunts your growth.
- **Letting imperfect grammar or non-native language stop you from writing.** Clarity of thought matters; perfect grammar doesn't.
- **Overpromising in the motivation section.** Tie benefits to business needs, but don't oversell.

## Key Terms

- **Technical design process** — The combination of solitary deep-thought work and collaborative discussion that helps everyone agree on a design for a large change; its tangible output is a design document.
- **Design process cone (spiral)** — The mental model of design as a widening upward spiral alternating between independent and team work, where each loop increases certainty, clarity, invested work, and the circle of people consulted.
- **Problem statement** — A written synthesis of stakeholder input defining the problem, its priorities, and what's in and out of scope; circulated for validation before designing.
- **Design document** — A written artifact describing current state, motivation, requirements, alternatives, the proposed solution, and plans for testing and rollout; serves thinking, feedback, team awareness, onboarding, and planning.
- **Living document** — What a design document becomes after implementation begins: a maintained description of how the software actually works, not just the original proposal.
- **Spike** — An Extreme Programming term for a time-bounded investigation; scheduled as a sprint task to create room for deep design thought alongside delivery commitments.
- **Proof-of-concept (experimental) code** — Draft code written during design to illustrate or test an idea; intentionally unpolished, untested, and disposable.
- **Architectural review** — A formal, heavyweight design review requiring a design document and approval from outside stakeholders (e.g., operations, security), reserved for large or risky changes.
- **Request for decision (RFD)** — A fast, lightweight intrateam review: a short write-up of a decision to be made, followed by discussion and a decision (distinct from the Internet Society's RFC process).
- **Design discussion (brainstorming session)** — An informal, free-flowing, whiteboard-centric meeting of roughly two to five people held early in the design cycle to explore the problem and trade-offs.
- **Unresolved questions ("known unknowns")** — A design document section explicitly listing pressing unanswered questions to solicit reader input.
- **Maker's schedule** — The idea (from Paul Graham's essay) that people who create things need long uninterrupted blocks of time, unlike managers who work in hour increments.
