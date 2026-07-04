# Chapter 31: Small Cycles — Examples

This chapter has no code examples. Its argument is carried by a historical narrative and personal war stories from the author's career. Each one anchors the same value: shrink cycle time so you never make teammates wait.

### Source control by desk drawer (1950s–60s punch cards)

In the punch-card era, source code was literally a deck of cards in your hand. The "source code control system" was your desk drawer: checkout meant taking the cards from the cabinet, commit meant putting them back. There were no merge problems because it was physically impossible for two programmers to change the same module at once. The lesson the author draws later: the cycle time was the whole project — you held the code until you were completely done. Physical possession was the original, and slowest, form of pessimistic locking.

### Editing tapes and keeping the master in your possession

In the '70s, source moved to magnetic tape. Edits were punched as add/change/delete directives on cards; an editor program read the old source tape and wrote a new one. (Side note from the author: 6,000 lines of code on cards weighed 30 pounds — drop the deck and you were in trouble; drop a tape and you just pick it up.) Because editing produced a *new* tape while the old one still existed, someone could accidentally edit the stale master and create a merge problem. The fix was process: keep the master tape in your possession until your edits and tests were done, then put a new master on the rack. Source code control had become a human convention, separate from the code itself — but still a long, exclusive checkout.

### The bulletin board and colored thumbtacks

As teams grew, hogging the whole master tape became a nuisance, so modules were extracted and a bulletin board tracked who was editing what. Each programmer had a thumbtack color (the author was blue, Ken was red, CK was yellow). To edit the "Trunk Manager" module, you checked the board, put your pin in, copied the master, edited only that module, tested, then wrote a new master with your module swapped in and removed your pin.

The author stresses *why* this worked: everyone knew each other, sat in the same office, and talked constantly ("Ken, I'm going to change the Trunk Manager module." "Put a pin in it." "I already did."). The pins were just reminders; shared awareness was the real system. It let them help each other, warn each other about problems, and avoid merges — which, back then, "were not fun." The era ended in the '80s, when big, always-online disks, screen editors, and multiple terminals meant more than one person could be editing at exactly the same time — and teams hit 20–30 programmers with hundreds of modules: not enough thumbtack colors, not enough board space.

### The tool lineage: SCCS, RCS, CVS, Subversion, git

The chapter walks the evolution of tools as evidence for its thesis:

- **SCCS** (1972, Marc Rochkind, first written in SNOBOL, later C): one file at a time, with locks — pessimistic locking, a software version of the thumbtack.
- **RCS** (1982, Walter Tichy): still file-based, still pessimistic, but became the standard.
- **CVS** (1986): handled whole projects and introduced *optimistic locking* — two programmers could edit the same file concurrently; CVS would try to merge nonconflicting changes and alert you when it couldn't. Developers still committed only when a project was done, but concurrent work made the average time between commits on the project shrink drastically; the cost was merges, which everyone hated, especially without unit tests.
- **Subversion** (2000): vastly improved CVS, drove the industry away from pessimistic locking, and was the first source control used "in the cloud" (SourceForge).
- **git** (2005, presaged by BitKeeper and Monotone): eliminated the "master tape" concept entirely. The full history lives on your machine; peers push and pull as equals; the authoritative release location is just another peer. You can commit every 30 seconds — every time a unit test passes.

The point of the whole history: viewed end to end, every step was driven, perhaps unconsciously, by one imperative — shorter cycles. From cycle-time-equals-the-whole-project down to commit-per-passing-test.

### The author's branch dogmatism, and the FitNesse move to git

Under CVS and Subversion, the author forbade branches on his teams: a branch is just a long-term checkout, and long-term checkouts impede others. When he moved the open-source FitNesse project (about a dozen contributors) from Subversion on SourceForge to git on GitHub, branches suddenly appeared everywhere, and for a few days he wondered whether to abandon his stance and continuous integration with it.

Then he realized the git "branches" weren't true named branches — they were just each developer's stream of local commits between pushes. Git had merely recorded what developers were already doing between integration cycles. So he kept his rule, redefined for git: it's *pushes*, not commits, that must return immediately to the main line. Continuous integration was preserved. The lesson: tools change, the discipline doesn't — measure cycle time by how long your work stays unintegrated.

### The FitNesse parser rewrite — the legitimate long-lived branch

The author's own counterexample to his no-branches rule. The FitNesse team completely rewrote the parser: a few person-weeks of work with no way to do it incrementally ("the parser is the parser"). They created a branch and kept it isolated until the parser was ready. The final merge wasn't too bad, because the parser was well isolated from the rest of the system and they had a very comprehensive suite of unit and acceptance tests. The lesson: when a feature is so isolated that a big merge is unlikely, it might be better to let developers work in peace on a branch — but most of the time, prefer the main line with toggles.

### Toggles without flags: hiding the button

As an example of keeping unfinished features safely on the main line, the author notes that toggles are often not flags at all. His teams more often use the Command pattern, the Decorator pattern, and special versions of the Factory pattern to make partially written features unexecutable in production — and most of the time they simply don't expose the feature: if the button isn't on the web page, you can't run the feature. The lesson: the simplest toggle is withholding the entry point.

### The slippery slope of the ignored failing build

A cautionary mini-story about culture rather than a specific incident. If you let the build keep failing, you get used to the failures. Used to them, you start ignoring them. The alerts become annoying, so you're tempted to turn the failing tests off "until you can fix them — later. You know. Later?" With the failing tests removed, the build goes green and everyone feels good again — "but it's a lie." That's when the tests become lies. The author's prescription: a build failure triggers sirens, emails to everyone, "a flashing red light on the CEO's desk" — everyone stops and fixes it. And it's preventable: run the build and all tests locally before pushing, and only push on green.
