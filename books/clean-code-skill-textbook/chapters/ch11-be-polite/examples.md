# Chapter 11: Be Polite — Examples

### The polite `makeStatement` function (video-rental statement, refactored)

The chapter's central positive example is the `makeStatement` function on the `RentalStatement` type, carried over from the previous chapter's refactoring of a video-rental example (shown in Go):

```go
func (statement *RentalStatement) makeStatement() string {
    statement.clearTotals()
    return statement.makeHeader() +
        statement.makeDetails() +
        statement.makeFooter()
}
```

The name is abstract: it says what the function does, not how. Its four lines call private functions extracted from it, each named one level of abstraction lower. The author calls this polite because a reader can glance at it, see exactly what it does at this level, and leave — escaping early without reading any detail they don't care about.

### Walking the call tree down: `makeDetails` and `clearTotals`

The book descends the tree to show what "one level down" looks like. `makeDetails` is mid-level — its name says what it does at its level, and its body is a loop that calls the next function down, `makeDetail`:

```go
func (statement *RentalStatement) makeDetails() string {
    rentalDetails := ""
    for _, rental := range statement.rentals {
        rentalDetails += statement.makeDetail(rental)
    }
    return rentalDetails
}
```

`clearTotals` is the bottom of the chain — two assignments that state how the totals are cleared "in excruciating detail", with no meaningful lower level to descend to:

```go
func (statement *RentalStatement) clearTotals() {
    statement.totalAmount = 0.0
    statement.frequentRenterPoints = 0
}
```

Lesson: every public function should create a tree of calls to private functions, each call descending exactly one level of abstraction (The Stepdown Rule). Martin notes that had he inlined `makeDetail`'s body into `makeDetails`, that function would have held at least two levels of abstraction — which he generally considers rude.

### The rude original `statement` function

The "before" code that `makeStatement` evolved from: a single ~30-line `Customer.statement()` function that zeroes `totalAmount` and `frequentRenterPoints`, builds a header string, loops over rentals with a `switch` on movie type computing per-rental charges, accumulates frequent-renter points, formats each detail line, and finally appends the footer — all inline.

The author calls this code rude and its author inconsiderate: to understand the high-level intent you must process every low-level detail. It also anchors the "abstraction roller coaster": the very first line of a high-level function drops you to the lowest-level detail (zeroing totals), pops up to building the result, then dives into a `switch` — up and down through abstraction levels. Even the name is rude: `statement` is a noun describing no action, so you must infer that it builds the statement.

### The "does the statement include the footer?" thought experiment

A paired scenario demonstrating the cost of rudeness. You're reading code elsewhere and hit a call to the polite `makeStatement()`; you wonder whether the statement includes the footer. You click into the implementation, see four simple lines (one of them `makeFooter()`), get your answer, and click back two seconds later with no sense of interruption.

Now do the same with the rude `statement()`: you face 30 lines of dense detail, spend a minute or two verifying the footer is built and called at the right time — and by then you've forgotten why you cared. You click back, having lost your train of thought, and spend several more minutes backtracking to rebuild it. Martin compares this to the guy who bursts into your cubicle and throws a question at you without waiting to be acknowledged. Lesson: polite code answers high-level questions in seconds; rude code taxes the reader's working memory.

### The newspaper article metaphor

Not code but the chapter's governing analogy. A well-written article has a headline that lets you decide whether to read, a first paragraph that gives the synopsis while hiding detail, and increasing detail downward. Readers stay in the loop `while (interested) readMore;` and quit as soon as they're bored — the article politely lets them out early. A newspaper made of one long disorganized story would never be read, and an article mixing two stories would be an abomination (the code analogue of violating the Single Responsibility Principle). Modules should read the same way: explanatory name as headline, high-level concepts on top, detail increasing downward. Footnote-level nuance: languages like Clojure invert this order because declarations must precede use.

### The mental-stack failure and writing on the roller coaster

Two short anecdotes that explain *why* the rules exist. First: each time code drops from a high-level line to a low-level one, the reader must push their mental model onto a mental stack and pop it later — but "we do not have a mental stack", so the train of thought is usually lost. Second: Martin reconstructs how the rude `statement` function was probably written — the author wrote the loop, then remembered to zero `totalAmount`, then after the `switch` realized they needed frequent-renter points and went back to add a line at the top. We all write code this way; first drafts inevitably look like the roller coaster. That's why Kent Beck's advice is critical: "First, make it work. Then, make it right." You are done when the code reads well, not when it works.
