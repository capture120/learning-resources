# Chapter 11: Be Polite

Politeness is a way of treating the reader: a polite module is "pretty much what you expected" (Ward Cunningham's definition of clean code) and lets readers stop reading as soon as they have their answer. Rude code forces readers to wade through low-level detail to answer a high-level question, breaking their train of thought.

## Modules: narrow interface, deep implementation

A module is a bounded, cohesive set of functions and variables — one class, several classes, or no classes; one source file or several. The artificial boundaries don't matter; cohesion does (another common word is *component*). If you write code roughly via "Extract Till You Drop", a module ends up as a few public functions (the **interface**) plus many extracted private functions (the **implementation**) — both possibly organized into classes, so the module contains a few public classes and several private classes. Borrowing from John Ousterhout's *A Philosophy of Software Design*: such a module has a **narrow interface and a deep implementation** — and that's a good thing.

## Abstract names, descending trees of calls

A public function performs the module's highest-level task, and its name should state that task in abstract terms: what it does, not how. Inside, it calls private functions whose names are also abstract but one level lower. Every public function thus creates a tree of calls to private functions at successively lower levels of abstraction, ending at functions (like a two-line `clearTotals`) whose bodies state the "how" in full detail with no meaningful lower level left.

## The Stepdown Rule

Each descending call goes exactly one level of abstraction down — not two, not three. Every function has a name that defines what it does and a body whose lines are all at the same level of abstraction; any line not already at the lowest level calls a function one level down. How big is one level? Use your best judgment: if you can meaningfully extract, do the extraction and check that it makes sense. The author admits he sometimes allows two levels in one function, but generally considers that rude.

## The Newspaper Metaphor

Structure a module like a well-written newspaper article: headline (the module's name — simple, explanatory, sufficient by itself to tell you whether you're in the right module), then a synopsis paragraph (high-level concepts and algorithms at the top), with detail increasing downward to the lowest-level functions at the end. Readers stay in the loop `while (interested) readMore;` and stop as soon as the article becomes boring — articles (and modules) that let readers out early are polite; ones that force reading unnecessary detail are rude. A newspaper of one long disorganized story would go unread; so keep many short "articles". (Exception: languages like Clojure that require declaration-before-use invert the ordering — details at top, policy at bottom.)

## One topic per module (Single Responsibility Principle)

A newspaper article mixing two different stories would be an abomination; so is a module containing two or more topics. All classes and functions in a module should relate to a single topic — a single responsibility — structured from high-level policy down to low-level detail.

## Let the reader escape early

Functions that encapsulate a single level of abstraction let readers escape early: glance at the body, get the answer, click back in two seconds with no feeling of interruption. Rude code (a 30-line function full of detail, named with a noun like `statement` that describes no action) costs the reader minutes and, worse, destroys the train of thought they had when they arrived. It's as rude as the guy who bursts into your cubicle and throws a question at you without waiting to be acknowledged.

## The Abstraction Roller Coaster

Code that lurches between high-level lines (setting up a loop over rentals) and low-level lines (zeroing totals, switch cases) makes the reader ride an abstraction roller coaster. Each high-to-low drop forces readers to push their mental model onto a mental stack and pop it back later — but humans do not have a mental stack, so the train of thought is usually lost. Descending one level of abstraction at a time is a polite practice that helps avoid the roller coaster.

## We write on the roller coaster — so clean up before you're done

We all *write* code by rolling through abstractions and details (write the loop, remember to zero a total, go back and add a line), so first drafts naturally look like the roller coaster. Hence Kent Beck's advice: **"First, make it work. Then, make it right."** You are not done when the code works; you are done when the code reads well — when the tree of functions descending from the public functions has been extracted, organized, and laid out for the reader's convenience.

## Rules as defaults, not dogma

The author doesn't follow these rules religiously; there are situations where following them is inappropriate. But they are his default — followed unless there is a good reason not to.

## In practice

- Name public functions abstractly (verbs stating what, not how); avoid noun names that describe no action.
- Keep every function body at a single level of abstraction; extract anything one level lower into a named function (The Stepdown Rule).
- If you can meaningfully extract, extract — then check that the result makes sense.
- Order a module top-down like a newspaper: name as headline, high-level policy first, detail increasing downward (unless the language forces declaration-before-use).
- Keep each module to one topic / single responsibility; split modules that mix stories.
- After the code works, restructure it until it reads well — working is not done.
- Test politeness by reading: can someone answer a high-level question (e.g., "is the footer included?") in seconds without losing their place?
- Treat these as defaults: deviate only with a good reason, and recognize two levels of abstraction in one function as a (sometimes tolerated) rudeness.
