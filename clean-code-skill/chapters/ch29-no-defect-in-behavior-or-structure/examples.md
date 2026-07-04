# Chapter 29: No Defect in Behavior or Structure — Examples

This chapter has no code examples. Its evidence comes as anecdotes and one extended dialogue, which carry the chapter's values.

### Students rushing on throwaway code
Martin teaches classes where he gives programmers small projects purely so they can practice new techniques and disciplines. He explicitly doesn't care whether they finish — all the code will be thrown away. Yet he still watches students rush, some staying past the end of class "hammering away at getting something utterly meaningless to work." The lesson: the pressure to rush is not really the project manager's tapping foot; it comes from inside us. Programmers equate development speed with self-worth, feel they're failing when software takes the time software takes, and rush to compensate.

### The grand redesign in the sky
Referring back to the tale from Chapter 1: developers tell management that the only way to make progress is to redesign the whole system from scratch. Martin reframes what this moment actually means — the developers have assessed the current system as *worthless*, and when managers agree to the redesign, they are agreeing with that assessment. This anchors the claim that "worthless is not too strong a word" for a system that passes all its tests and meets all functional requirements but is too rigid, fragile, and immobile to change. Behavior alone could not save its value; poor structure negated it.

### Eisenhower's decision matrix
Martin borrows General Dwight D. Eisenhower's quote: "I have two kinds of problems, the urgent and the important. The urgent are not important, and the important are never urgent." He presents the classic two-axis matrix (urgency vertical, importance horizontal, four quadrants) and maps software's two values onto it: structure is long term and therefore important; behavior is short term and therefore merely urgent. He distills this into what he says we might even call "the engineer's motto": *the greater the urgency, the less the relevance*. The example anchors the rule that structure — the important thing — comes first, and that this prioritization is the programmer's job, not the boss's.

### Tests as the unit for "make it work, then make it right"
Not a code example, but a worked resolution of an apparent contradiction. Beck's law says make it work first; Martin says structure outranks behavior. He squares the circle by shrinking the unit of work. At story granularity: get a story working, then fix its structure, and don't start the next story until the structure is right — the structure of the current story outranks the behavior of the next. But stories are too big; tests are "the perfect size." Pass a test, refactor the code that passes it, then write the next test. This is presented as the moral foundation of the Red-Green-Refactor cycle of a good testing discipline like TDD, and the reason such a testing discipline is a design technique rather than a testing technique.

### The boss-versus-programmer dialogue ("Danny")
The chapter's centerpiece example: a scripted confrontation showing how a professional handles an order to skip structural cleanup.

The boss demands a new feature by tonight. The programmer refuses: there's structural cleanup to do first. The boss says do the cleanup tomorrow; the programmer answers that this is exactly what happened with the last feature, which is why the mess is now bigger — the cleanup must come first. The boss escalates to business rhetoric ("Either we have a business or we don't have a business") and then to a firing threat ("Maybe I should fire you"). The programmer holds the line, on these grounds:

- Acknowledging the boss's goal as shared: "I want to go fast, just like you do."
- Predicting the consequence: skip the cleanup and the team slows down, delivering fewer and fewer features — "I've seen it before. And so have you."
- Drawing the safety line: "I don't feel safe letting the mess get any worse."
- Claiming professional authority: "You hired me because I know how to do that. You have to let me do my job."

The negotiation ends with a compromise: cleanup tonight, feature tomorrow — and the feature will be easier to build once the structure is clean. The punchline is the boss's aside: "I like that kid. He's got guts... He didn't back down even when I threatened to fire him. He's gonna go far."

Lessons anchored: refusing an order to ignore structure usually doesn't get you fired; managers expect to fight for what they need and respect those who do the same; and the schedule can be negotiated (feature tomorrow, cleanup tonight), but the principle of never piling new behavior on known bad structure cannot.

### The permitted shortcuts (trade-show fix, ship-tomorrow release)
Two brief counter-examples that keep the promise honest. If a quick-and-dirty fix is needed to make a trade show, "then so be it." If structure is close-but-not-quite-right and customers expect the release tomorrow, shipping it is allowed. The promise is to do your best and not *knowingly* let defects accumulate — not to achieve perfection. The non-negotiable part: those known issues must be addressed before adding more behavior.
