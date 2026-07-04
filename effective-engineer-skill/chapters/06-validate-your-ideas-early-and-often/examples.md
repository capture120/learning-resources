# Chapter 6 Examples: Validate Your Ideas Early and Often

### Cuil's failed Google-killer launch

Joshua Levy was Director of Engineering at Cuil, a stealth search engine that launched July 28, 2008 with a 120-billion-page index — claimed to be three times Google's size at a tenth of the infrastructure cost. The launch was a disaster: the thousand-machine infrastructure buckled as users typed distinct queries like their own names, overwhelming the in-memory cache of common query results; index shards crashed leaving holes in results; and press reviews called the product buggy, slow, and lackluster. Levy: "It felt like being in a car knowing you're going off a cliff, and thinking, 'Well, maybe if we hit on the gas, we can make it across.'" Users found it lacked basics like spelling correction and, despite the bigger index, returned fewer results than Google for most queries. Because Cuil wanted a big splash and feared press leaks, it had no alpha testers and got zero external feedback before launch — so nobody flagged that search quality was poor or that index size didn't matter to users. It also had no one working full-time on spam, while Google had entire teams. The company burned over $33 million in venture capital and decades of engineering person-years. This was not incompetence: Levy called it "a very solid set of engineers," and two founders came with decorated pedigrees from Google's own search team — the book asks "So what went wrong?" to show that elite talent and insider credentials don't substitute for external validation.
**Illustrates:** The cost of not validating early — years of effort invested in the wrong priorities (index size over quality) with no feedback loop, even by a strong team.

### BloomReach's four-month beta

Levy carried the Cuil lesson to BloomReach, where he was the second hire. Facing deep uncertainty about what their e-commerce marketing product should be, the team shipped a minimal but functional system to beta customers within four months and let customer feedback drive what to build next. The company grew to over 135 people, serves brands like Nieman Marcus and Crate & Barrel, and on average helps online brands generate 80% more non-branded search traffic. Levy's advice: get feedback and figure out what's working, because you can't get everything right by trusting your own plan.
**Illustrates:** Optimizing for feedback as soon as possible instead of building for years on unvalidated assumptions.

### The MASLab robot that drifted off course

In the author's MIT robotics competition, his team's robot initially aimed at a red ball and drove straight toward it at full power. Tiny variances in motor speed, tire tread, and field bumps compounded over distance, so the robot drifted and missed. The fix: move a little, re-check the camera, correct orientation, repeat. Short cycles with correction between them beat one long uncorrected run.
**Illustrates:** Iterative approaches with frequent course correction prevent small errors from compounding — the model for how to work.

### Zach Brock's "do the scariest part first"

Brock, an engineering manager at Square, tells his team to identify the scariest part of a project — the part with the most unknowns and risk — and do it first. This surfaces problems while the plan can still change.
**Illustrates:** Tackling the riskiest areas first to avoid late surprises that invalidate work.

### Dropbox's 4-minute video MVP

Drew Houston needed to validate that users would prefer Dropbox's seamless experience over the many existing file-sharing tools. Instead of building everything, he made a short 4-minute video demoing files syncing across a Mac, a Windows PC, and the web. Overnight, the beta mailing list jumped from 5,000 to 75,000 users. As of February 2014, Dropbox had over 200 million users and a $10 billion valuation.
**Illustrates:** A creative MVP can validate a product premise with minimal effort.

### 42Floors' faked redesigns

42Floors, a search engine for office rentals, had a listings map that took up to 12 seconds to load. Engineers spent three months building a faster view with big photos, infinite scrolling, and a mini-map — and no metric moved at all. Unwilling to gamble months on another redesign, they made 8 Photoshop mockups, had them converted to HTML with static pre-populated data, and drove real visitors to the fake pages via a Google AdWords campaign for "new york office space." Measuring tour-request conversion across the 8 fakes let them pick a winner at a fraction of the cost; shipping it finally produced the conversion gains.
**Illustrates:** Faking a full implementation to validate ideas cheaply after an expensive unvalidated attempt failed.

### Asana's fake Google Signup button

Asana wanted to know whether a Google Signup button on its home page would increase signups. Rather than building the whole signup flow, they added a fake button that popped up "Thanks for your interest — the feature is coming soon." After a few days of click-through data confirmed demand, they built the real flow.
**Illustrates:** Validating demand with a minimal fake before investing in the full implementation.

### Obama 2012's "I will be outspent" email

In June 2012 the Obama re-election campaign needed money and drafted a donor email with the subject "Deadline: Join Michelle and me." The team tested 17 candidate subject lines on small subscriber groups; "I will be outspent" projected to raise about 6x more than some alternatives — over $2 million extra — and the email sent to 4.4 million subscribers raised $2.6 million. Testing became systematic: the campaign hired an engineering team for email tooling and 20 writers just to draft variations, sent over 400 national fundraising emails in 2012, tested 10,000 variations, and tested each email on up to 18 groups, with best variants raising 5-7x the worst. Over 20 months these tested emails raised most of the campaign's $690 million in online donations.
**Illustrates:** Even reasonable-seeming ideas benefit enormously from data validation; systematic testing is high-leverage.

### Etsy's listing page redesign

Etsy's product listing pages got nearly 15 million views per day; 22% of visitors entered the site through them, but 53% of those bounced immediately. The redesign had three goals: reduce bounce rates, clarify to shoppers that they were purchasing from independent designers, makers, and curators, and make it easier to shop and check out quickly. Etsy's metrics-driven culture (Chapter 5) had prompted it to build its own A/B testing framework, and instead of fully building a redesign and hoping, the team worked hypothesis by hypothesis: for example, they hypothesized that showing more marketplace items would cut bounce rate, ran an A/B test adding similar-product images atop the page, and saw bounce drop nearly 10% — so that element went into the final design. The eight-month, rigorously A/B-tested redesign shipped with, per former SVP Marc Hedlund, far and away the best quantified performance of any project they'd shipped. Etsy topped $1 billion in sales in 2013, with its experiment-driven culture playing a large role.
**Illustrates:** Incremental, hypothesis-driven A/B testing versus building a full product and hoping metrics move.

### Quora's in-house A/B testing framework

At Quora, building an in-house A/B testing framework was among the highest-leverage investments: simple experiment-definition abstractions, tools to verify variants during development, push-button test deployment, and automated real-time analytics. It enabled hundreds of user experiments measuring signup flows, interface features, and ranking changes — replacing guessing with scientific measurement.
**Illustrates:** Investing in testing infrastructure optimizes the iteration loop for validating ideas against live traffic.

### Google's 41 shades of blue

Google tested 41 shades of blue for search result links; the winning shade netted about $200 million more in annual ad revenue. This works for Google because its traffic gives fast statistical significance and even a 0.01% revenue improvement is $3.1 million against $31 billion annual revenue. For most companies, the same test would cost prohibitive time and traffic for gains too small to matter.
**Illustrates:** Choose A/B tests by practical significance at your own scale; time is the limiting resource.

### The author's "ginormous" Google internship code review

Interning at Google on a search feature for Orkut, the author sanity-checked the initial design but showed no actual code all summer, then sent a multi-thousand-line review in his final week — flagged in his mentor's inbox as "ginormous." Other interns pointed out the risk: a design flaw found then would have been unfixable before he left, and the whole summer could have been scrapped. His mentor accommodated him and the feature shipped months later, but only luck prevented waste. Committing iteratively in chunks would have made review easy and delivered feedback along the way.
**Illustrates:** The one-person-team anti-pattern; commit early and often to force regular feedback.

### Steve Wozniak and Steve Jobs

Wozniak designed the Apple I and Apple II hardware and software alone, at home and in Jobs's garage. What turned hobbyist machines into pillars of the personal computer revolution was, in part, that Jobs gave the introverted Wozniak a counterbalance and a feedback loop for his ideas — he never worked in a vacuum.
**Illustrates:** Even solo builders succeed by attaching themselves to a feedback loop.

### Nimrod Hoofien's team experiments at Ooyala

Hoofien, later a Director of Engineering at Facebook, argued every decision — recruiting, team design, culture, compensation — needs a feedback loop or you're just guessing. As SVP of Engineering at Ooyala he experimented: varying team size and watching for dysfunction (most commonly a team splitting into two groups that only work their own side of the board); tying bonuses tightly to engineering-wide reliability metrics, which launched to positive sentiment but was rolled back after a quarter when engineers felt they lacked control over the metrics. He also tested whether tech leads should be managers (yes), whether SREs, designers, and product managers should embed in dev teams (yes for product managers), and when to adopt Scrum (it varied). Most experiments ran a few weeks with data gathered sometimes just by talking to people; a radical idea — doubling top engineers' salaries to build a superstar team — ran as a thought experiment with tech leads, who predicted non-top performers would quit in droves and be too hard to replace. The book cautions that what works varies by situation and people — Hoofien's learnings on team setup might differ from yours — so adopt the experiment methodology, not his specific conclusions.
**Illustrates:** Decisions about teams, process, and compensation are testable hypotheses; build feedback loops for every decision.
