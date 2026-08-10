# Chapter 33: Maintain High Productivity — Examples

This chapter has no code listings. Its examples are thought experiments, back-of-the-envelope arguments, and personal anecdotes that anchor the productivity disciplines.

### The 30-minute build after a 5-minute edit

Martin poses a scenario: you edit for 5 minutes, then wait 30 minutes for the build. Obviously you can't be productive that way. He challenges the reader's resignation directly — are you *utterly certain*, in the age of cloud computing, that the build can't be dramatically sped up? The lesson: slow builds are not facts of life; find the cause and fix it as a design challenge. Builds in the third decade of the twenty-first century and beyond should take a minute or two at most.

### Ten billion instructions per second

To demolish the excuse that test suites must be slow, Martin counts instructions: his "poor little laptop" has four cores at 2.8 GHz, roughly 10 billion instructions per second. Does your whole system even contain 10 billion instructions? If not, the entire system should be testable in under a second — unless you're executing the same instructions repeatedly. The lesson: slow suites come from repetition, not from system size.

### Testing login a thousand times

A concrete instance of test repetition: how many times must you test login to know it works? Once. Yet many suites run every test through the login flow. Any more than one pass is waste. The fix is to short-circuit login during testing — use a mocking pattern, or strip login out of test builds entirely. The same logic applies to UI navigation: tests that start at the top of the menu structure and click through a long chain of links to reach their target state waste a full navigation pathway per test. Build a special testing API that forces the system directly into the needed state, with no login and no navigation. Likewise databases: a query needs to run once to be proven; mock the database for the majority of tests. Peripherals — disks, web sockets, UI screens, even SSDs — are slow; get them off the tests' critical path.

### Song lyrics in the comments

Martin's anecdote about coding to music: he used to do it, believing it helped him concentrate. One day, reviewing year-old code, he found the lyrics of the songs he'd been listening to scattered through the code as comments — visible proof that the music had been "lashing" his code and dividing his attention. He stopped, and found himself happier with his code and his attention to detail. He offers a theory: programming arranges elements of procedure through sequence, selection, and iteration; music is tonal and rhythmic elements arranged the same way, so it may consume the very brain machinery programming needs. He admits readers must test this themselves, and suggests a one-week no-music experiment.

### Can't code after a fight with your spouse

To illustrate how mood destroys productivity: after a big fight with your significant other, you type a few random characters in the IDE that amount to nothing, or you fake productivity by sitting in a boring meeting. Martin's remedy is to act on the root of the emotion — call your spouse and attempt to resolve the issue. The key nuance: you don't have to actually resolve it; convincing yourself you've taken enough appropriate action is usually sufficient to clear the mind and redirect attention to the code. (A footnote quotes John Wayne in *The Comancheros* on marital fights: it doesn't matter who has the upper hand; in time you settle into being at ease with each other.)

### Flow-state code looks worse later

Martin describes the euphoric "flow" state — hyper-focused tunnel vision where code seems to pour out of you and you feel superhuman. His counter-experience: code produced in that altered state tends to be pretty bad, far less well considered than code written at normal attention. So he now deliberately resists flow, using pairing (the need to communicate interferes with flow) and the absence of music (the real environment keeps him grounded), and breaking away to do something else when he notices hyper-focus starting.

### Defending the Tomato

The Pomodoro Technique example: set a (traditionally tomato-shaped) kitchen timer for 25 minutes, work until it rings, break for 5, repeat. The technique's real power shows when the phone rings mid-tomato: "Defend the Tomato!" — tell the caller you'll get back to them within 25 minutes, dispatch the interruption as fast as possible, return to work, and deal with the interruption after the break. Between-tomato gaps grow long because interrupters demand real time, and that's the point: at day's end, the count of completed tomatoes is an honest measure of productive time versus everything else. Mature practitioners plan their day by allocating tomatoes, estimate tasks in tomatoes, and schedule meetings and lunches around them. Martin's flexibility note: 15–45 minutes is a fine tomato length (pick one and stick with it), and if a test is 30 seconds from passing when the timer rings, finish it — but never run more than a minute over.

### Leaving the boring meeting

Martin's meeting discipline as a playable script: when a meeting gets boring, wait a few minutes for a lull, tell participants you believe your input is no longer required, and ask if they'd mind you returning to your rather large pile of work. Before accepting an invitation, make the inviter convince you you're truly needed, warn them you can spare only a few minutes and will likely leave early — and sit close to the door. The guard against fear of missing out: if you're truly needed, they'll come get you.
