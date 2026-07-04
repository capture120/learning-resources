# Chapter 8 Examples: Balance Quality with Pragmatism

### Google's coding standards and readability reviews

Google enforces style guides for C++, Java, Python, JavaScript, and other languages, covering everything from whitespace to which language features are allowed. Every change must be reviewed by another engineer before check-in, and engineers must pass a formal readability review before an internal committee for each language they use; without it, every change needs approval from someone who has passed. This rigor let an organization of over 45,000 employees across offices in 60+ countries scale effectively — Google ended 2013 with the world's fourth-highest market capitalization — and quality self-propagates because new engineers pattern-match on excellent code. The author, who joined Google's Search Quality Team out of college, learned best practices faster there than he could have elsewhere.
**Illustrates:** High quality standards enable organizational scaling and create a positive feedback loop of good code.

### The cost of Google's uniform standard

Because every change is held to the same bar whether it serves 100 users or 10 million, experimental code at Google carries heavy overhead. Most experiments fail, so effort spent making experimental code high-quality, performant, and scalable is largely wasted, making nimble prototyping hard. Impatient engineers who want to build products faster leave for startups that trade some rigor for iteration speed.
**Illustrates:** It is possible to over-invest in quality; the same practices that help a giant would be overkill at a startup.

### Bobby Johnson on "works vs. doesn't work"

Bobby Johnson, a former Director of Engineering at Facebook, rejects "right and wrong" as a framework for engineering decisions, preferring to evaluate whether something works or doesn't work for the goal. He finds this brings more clarity and makes decisions more effective.
**Illustrates:** Pragmatism, not dogma, is the right lens for reasoning about quality.

### Evan Priestley on speed and quality

Early Facebook engineer Evan Priestley observed that you must move quickly to build quality software, because otherwise you cannot react when things — or your understanding of them — change; and you must build quality software to move quickly, because otherwise you lose more time dealing with the mess than you gained by building poorly.
**Illustrates:** Speed and quality are mutually reinforcing, so the balance point between them is high-leverage.

### The 2008 code review study

A 2008 study of software quality across 12,500 projects from 650 companies found that a pass of design and code reviews removes, on average, 85% of remaining bugs.
**Illustrates:** Code reviews catch bugs early, when they are far cheaper to fix than in production.

### Dropbox's four years without code reviews

Dropbox, founded in 2007, did not formally require code reviews for its first four years, yet still built a strong engineering team and a product with tens of millions of users. Only later did it institute reviews to help scale code quality.
**Illustrates:** Code review is a tradeoff against short-term productivity, and the right answer changes as a team grows.

### Lightweight review processes at Instagram, Square, Twitter, Ooyala, and Quora

Early Instagram engineers did over-the-shoulder reviews on a shared monitor. Square and Twitter often use pair programming instead of reviews. Ooyala started with emailed comments cc'ed to the team, reviewed only the trickier core functionality, and reviewed post-commit to keep moving fast. Quora required review only for model and controller business logic (not view code), reviewed most code after it shipped, reviewed risky infrastructure changes pre-commit, and reviewed new hires' code sooner and more closely.
**Illustrates:** Code review is a continuum that can be tuned to keep benefits while cutting friction.

### Evolution of code review tooling

At early Google, reviews went over email with manually referenced line numbers; other companies read code off projectors in conference rooms. Modern tools like GitHub and Phabricator offer lightweight web interfaces, git hooks auto-send review requests when a commit message mentions a teammate, inline comments show what changed since the last round, and lint checkers enforce style automatically. At Ooyala, teammates even built an open-source review tool called Barkeep to streamline the process further.
**Illustrates:** Tooling reduces review overhead so human time goes to valuable feedback.

### MapReduce vs. the author's MIT distributed database

At Google, the author wrote a C++ MapReduce program that computed word frequencies across billions of web pages in about half an hour — roughly 20 lines of custom code — with no distributed-systems expertise required. For his 2005 MIT Master's thesis, by contrast, he spent weeks writing thousands of lines of plumbing (query trees, communication protocols, serialization, failure recovery) just to run queries on a 4-machine distributed database. Rather than reasoning about reliability and fault tolerance, engineers using MapReduce deal with just two much simpler concepts — a Map function that transforms inputs from one form to another, and a Reduce function that combines intermediate data and produces output — and many complex problems can be expressed as a sequence of Map and Reduce transformations. Within 4 years of MapReduce's internal release, Google engineers had written over 10,000 unique applications on it; Sawzall later let scripts compile to MapReduce with tenfold less code than equivalent C++, and Google's design inspired the open-source Hadoop.
**Illustrates:** The right abstraction reduces complexity to simple primitives, eliminates plumbing, and amplifies engineering output by an order of magnitude.

### Daniel Jackson on choosing abstractions

MIT Professor Daniel Jackson, in his book Software Abstractions, writes that with the right abstractions programming flows naturally from design, modules get small simple interfaces, and new functionality fits without reorganization — while the wrong ones make interfaces baroque and clumsy and turn even simple changes into nasty surprises.
**Illustrates:** Abstraction choice determines whether future development is smooth or painful.

### Company-built abstraction catalogs

Google built Protocol Buffers (extensible structured-data encoding), Sawzall (simpler distributed log processing), and BigTable (petabyte-scale structured storage). Facebook built Thrift (cross-language services), Hive (relational queries over semi-structured data), and Tao (graph queries over MySQL). Quora built WebNode and LiveNode, which made adding real-time updates to any feature easy. These tools often cut feature-building time from weeks or months to hours or days.
**Illustrates:** Strong teams invest heavily in core abstractions because the payoff compounds with every use.

### Asana's Luna and Lunascript

Asana spent nearly its entire first year building Luna, a web application framework, plus its own programming language, Lunascript. Engineering manager Jack Heart explained the reasoning: the abstraction's power was so great that, eventually, writing Lunascript and then a webapp on Asana's scale would have been faster than writing that webapp without it. The opportunity cost was massive: no public product demo until two years after founding. Unsolved research-level problems in generating performant code and weak tooling forced the team to abandon the compiler (reusing parts of the framework) and revert to JavaScript.
**Illustrates:** Over-investing in an abstraction up front, before the problem is understood, drains time from actually building the product.

### Joshua Bloch's API design lecture

The author attended a lecture by Joshua Bloch — architect of many of Java's core libraries and then a principal engineer at Google — titled "How to Design a Good API and Why it Matters." Bloch's characteristics of good interfaces apply to abstractions generally: easy to learn, easy to use without documentation, hard to misuse, powerful enough for requirements, easy to extend, appropriate to the audience.
**Illustrates:** What makes an abstraction good.

### Rich Hickey's "Simple Made Easy"

Rich Hickey, author of Clojure, explains that simple things take on one role, fulfill one task, accomplish one objective, or deal with one concept. Simple abstractions avoid interweaving concepts so each can be reasoned about independently — supported by techniques like avoiding mutable state, functional over imperative programming, composition over inheritance, and declarative data manipulation.
**Illustrates:** Good abstractions disentangle complexity into independent, simple parts.

### Dropbox's mysterious business-customer breakage

Alex Allain, an engineering manager at Dropbox, recalls user flows for business customers mysteriously breaking. Multiple teams scrambled to investigate before tracing it to a seemingly harmless change: a data-team engineer had tweaked object caching in the database layer, inadvertently changing an internal database API's behavior that Allain's team depended on. An automated test exercising the API dependency would have pointed the right person at the bug from the start.
**Illustrates:** Automated tests route breakage to whoever caused it, saving other teams wasted investigation.

### Kartik Ayyar and Cityville's first unit test

Kartik Ayyar led development of Zynga's Cityville, a social game that hit over 61 million monthly users within 50 days of launch — at one point the most-used Facebook application — while he grew from individual contributor to engineering director of the 50-person team. Testing seemed unjustifiable: many gameplay iterations never made it into the launched product — "How much do we invest in testing if you're actually throwing away so much of this gameplay?" Ayyar asked himself — content shipped almost three times a day post-launch, one map-item class constructor was around 3,000 lines, and each building carried 50-100 lines of configuration. The inflection point came when one engineer wrote a basic test verifying that a building's referenced image asset actually existed in the codebase and had not been dropped during a merge. It caught so many deployment bugs that it paid for itself many times over, and the visible time savings led the team to seek out more strategic tests. In Ayyar's words: "Well, we're checking this image, so why can't we check other parts of the configuration file? Once people really started running those unit tests and [integrated them] into the build, they really started seeing how much time it saved."
**Illustrates:** Start with one high-leverage test; visible time savings kick off a virtuous testing cycle.

### Ward Cunningham coins "technical debt"

Ward Cunningham, inventor of the wiki, introduced the debt metaphor in a 1992 conference paper: shipping first-time code is like going into debt — a little debt speeds development if repaid promptly with a rewrite, but every minute spent on not-quite-right code counts as interest, and danger comes when the debt is never repaid.
**Illustrates:** Technical debt is a deliberate tool that turns dangerous only when the principal goes unpaid.

### Martin Fowler on runaway debt

Martin Fowler, author of Refactoring, notes the all-too-common failure mode: development organizations let debt get out of control and spend most future development effort on crippling interest payments.
**Illustrates:** Debt must be repaid periodically or it consumes the capacity to build new value.

### Company strategies for repaying debt

Asana schedules a "Polish and Grease Week" at the end of every quarter to pay off UI and internal-tools debt. Quora devotes a day after every week-long hackathon to cleanup. Google holds themed Fixit days (Docs Fixit, Customer Happiness Fixit, Internationalization Fixit) as a lightweight repayment mechanism. LinkedIn paused all feature development for two months after going public to fix a broken deployment process — features had been taking a month to deploy — then resumed development much faster.
**Illustrates:** Organizations that schedule debt repayment keep it from compounding.

### The author's Code Purge Day

The author once organized a Code Purge Day where he and teammates deleted unused code, removing about 3% of the application-level code. The effort was small, focused, and low-risk, and it was easy to justify because it saved other engineers time otherwise wasted navigating stale, irrelevant code.
**Illustrates:** When debt payoff is hard to quantify, start small and incremental to prove the value with little risk.
