# Chapter 28: Harm

The first promise of the software professional is **DO NO HARM**. Your code must not harm your users, your employers, your managers, your fellow programmers, or society. To keep that promise you must KNOW what your code does, KNOW that it works, and KNOW that it is clean — because the messier the code, the less you can know about it, and the less you know, the more harm you can do.

## Part IV framing: Craftsmanship and The Programmer's Oath

Part IV is an abridged excerpt from Martin's *Clean Craftsmanship*. The framing: Alan Turing, in his report on the ACE, laid the first stone of software professionalism — we should be "mathematicians of ability" who maintain "an appropriate discipline." Martin's guess is that the number of programmers now doubles roughly every five years, leaving the industry in **perpetual inexperience**: so long as that rate continues, half of all programmers always have less than five years of experience, with far too few mentors, so the same mistakes repeat endlessly. No new technology (Fortran, C, Unix, OO, Java, and the rest) ever reduced demand — if anything each accelerated it — and Martin warns against the delusion that AI will slow the rate. Meanwhile software now coordinates every aspect of civilization — "we rule the world" — and software catastrophes already destroy fortunes and kill people. One day a programmer's small mistake will kill tens of thousands, and politicians will demand an accounting. If the profession shows up without a statement of ethics, standards, and defined disciplines, "we will be found GUILTY."

**The Programmer's Oath** (offered to begin the definition of our ethics):

> In order to defend and preserve the honor of the profession of computer programmers, I promise that, to the best of my ability and judgment:
> 1. I will not produce harmful code.
> 2. The code that I produce will always be my best work. I will not knowingly allow code that is defective either in behavior or in structure to accumulate.
> 3. I will produce, with each release, a quick, sure, and repeatable demonstration that every element of the code works as it should.
> 4. I will make frequent, small releases so that I do not impede the progress of others.
> 5. I will fearlessly and relentlessly improve my creations at every opportunity. I will never degrade them.
> 6. I will do all that I can to keep the productivity of myself and others as high as possible. I will do nothing that decreases that productivity.
> 7. I will continuously ensure that others can cover for me and that I can cover for them.
> 8. I will produce estimates that are honest both in magnitude and precision. I will not make promises without reasonable certainty.
> 9. I will respect my fellow programmers for their ethics, standards, disciplines, and skill. No other attribute or characteristic will be a factor in my regard for my fellow programmers.
> 10. I will never stop learning and improving my craft.

This chapter covers promise 1.

## You must know what your code does

"It's our fingers on the keyboard. It's our code. We must know what it does!" Hiding behind requirements written by others is no excuse — the Volkswagen programmers who wrote EPA-cheating code should have known its purpose whether or not they were told. Accountability scales with seniority: juniors are held responsible to the level of their maturity and understanding, while senior developers are held to a very high standard and are ultimately responsible for the code of those they direct. But every programmer bears responsibility for the harm their code does.

## No Harm to Society

Never write software that benefits your employer at society's expense — that is the rule the VW programmers broke. For legal-but-questionable domains (weapons systems, gambling, violent or sexist video games, pornography), the author gives no rule: it is a matter for your own judgment and conscience. "Choose wisely!" Legality does not guarantee harmlessness.

Harm to society can also be unintentional, as with Healthcare.gov: blame falls on every programmer, lead, and manager who knew the system wasn't ready and remained silent. The passive-aggressive stance of "I'm just doing my job — it's their problem" is itself harmful. You were hired partly because you can identify trouble before it happens; therefore you have the responsibility to **speak up** before something terrible happens.

## Harm to Function

You must KNOW that your code works and that its functioning will not harm your company, users, or fellow programmers. The author does not demand perfect knowledge — a knowledge deficit always exists. The demand is to KNOW that there will be no harm, and to drive your knowledge as near to perfection as the stakes require: if lives are at stake, you must know your code won't kill; if fortunes are at stake, you must know it won't lose them.

Never assume your software is "not important enough" to do harm. A chat app can drop a "HELP ME. CALL 911" message; a simple website can leak identities; bad behavior can drive customers to a competitor; at minimum the development money is at stake. "There's almost always more at stake than you think."

## No Harm to Structure

You must not harm the structure of the code; you must keep it clean and well organized. Structural harm is anything that makes source code hard to read, hard to understand, hard to change, or hard to reuse — dead code left in the codebase, thousands of global variables, tangles of any kind. The reasoning is direct: the more tangled the structure, the harder it is to know what the code will do, and losing that knowledge undermines your ability to prevent harm. **"Messy software is harmful software."** Knight Capital lost $460M because dead code left in the system was accidentally reactivated; the team had lost the ability to know what their system would do.

Exception the author allows: a quick-and-dirty patch to fix a production crisis is fine — "A stupid idea that works is not a stupid idea." But you cannot *leave* the patch in place; the longer it remains, the more harm it can do. Clean it up after the crisis.

Every professional is responsible for knowing the disciplines of good structure: refactoring, writing tests, recognizing bad code, decoupling designs, creating appropriate architectural boundaries, and applying low- and high-level design principles. Every senior developer is responsible for making sure younger developers learn them.

## Soft

The first word in software is SOFT. Software exists to make machine behavior easy to change; code that is hard to change thwarts the very reason software exists. Software has two values: the value of its behavior, and the value of its softness. Softness wins. Thought experiment: a program that works perfectly but cannot be changed becomes useless forever the moment requirements change (and they always change); a program that does nothing right but is easy to change can be made to work and will keep working with minimal effort. Prioritize changeability in all but the most urgent situations — and "urgent" means a production disaster losing $10 million a minute, **not a startup**. A startup is the opposite case: "the one thing that is absolutely certain in a startup is that you are creating the wrong product," and "no product survives contact with the user," so the ability to change without making a mess is exactly what a startup needs to survive. Most of the time the mess starts slowing teams down before the first deployment. "When it comes to software, it never pays to rush" (Brian Marick).

## Tests

A comprehensive testing discipline — TDD, test && commit || revert (TCR), or small bundles — is how you come to KNOW, to a high degree of certainty, that the code works. Tests are the prerequisite for both halves of the promise: without tests you cannot prevent harm to behavior (nothing demonstrates the code works), and you cannot prevent harm to structure (you cannot safely clean code you cannot verify). The author asserts that a testing discipline is, or is rapidly becoming, part of the minimum set of disciplines that mark a professional developer — because too many lives and fortunes now depend on software for it to be written without one.

## In practice

- Before shipping, be able to state how you KNOW the change works and KNOW it causes no harm — proportional to the stakes.
- Never implement a requirement whose purpose you don't understand; if a requirement is deceptive or harms society, refuse. "Hiding behind requirements" is no defense.
- Speak up the moment you know something is wrong (a system isn't ready, a deadline forces broken releases). Silence makes you complicit.
- Delete dead code; never disable code with a flag and leave it in the codebase.
- Treat structural damage (globals, tangles, unreadable code) as harm, not as a style preference — it destroys your ability to predict behavior.
- Quick-and-dirty production fixes are allowed in a genuine crisis, but schedule their cleanup immediately; do not let the patch live on.
- Prioritize keeping code easy to change over getting behavior perfect, except in true emergencies. Especially in startups and new products, expect requirements to be wrong and preserve softness.
- Maintain a testing discipline (TDD/TCR/small bundles) so claims that "it works" rest on a repeatable demonstration, not hope.
- Calibrate diligence to risk: the higher the stakes (money, safety, privacy), the closer to certainty your knowledge must be.
- If you are senior, actively teach structure disciplines to junior developers and take responsibility for the code written under your direction.
