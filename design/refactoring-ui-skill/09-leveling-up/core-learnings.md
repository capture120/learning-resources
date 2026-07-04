# Leveling Up

## Chapter overview

This closing chapter is about how to keep improving after the book ends. The authors' framing: by now you should feel far more confident making things look good without relying on a designer, but no book can contain every idea — there will always be more to learn. So they offer two of the best ways to keep honing your skills and adding tools to your toolbelt (the chapter — and the book — closes with the authors' signed farewell: "— Adam Wathan & Steve Schoger"). The core idea: design skill compounds through deliberate observation and deliberate practice. You get better not by passively consuming inspiration, but by interrogating it — noticing the specific, unintuitive decisions behind work you admire, and forcing yourself to reproduce them. The WHY: most polish lives in small, non-obvious details (line heights, letter spacing, layered shadows, unconventional placements). Those details are invisible until you either actively hunt for them or fail to replicate them and have to figure out why. Both habits turn other people's finished work into a permanent source of new techniques.

## Look for decisions you wouldn't have made

**Principle:** When you encounter a design you like, ask one question: "Did the designer do anything here that I never would have thought to do?"

**Why it works:** Your instincts are bounded by your current toolbox. Designs you admire usually contain decisions outside that toolbox — and those unintuitive choices are exactly where new ideas come from. Generic admiration teaches nothing; spotting the specific surprising move gives you a reusable technique.

**Actionable guidance:**
- Treat every design you like as a study object, not just inspiration.
- Hunt for choices that feel counter to your defaults. Examples the book gives:
  - Inverting the background color of a component (a dark datepicker dropdown over a light page).
  - Placing a button *inside* a text input instead of beside it.
  - Using two different font colors within a single headline.
- Note the deliberate range of those three examples — a whole-component color-scheme inversion, a layout/placement choice, and what the book introduces as "something as simple as" a second font color. Collectible decisions exist at every scale; don't hunt only for big structural moves.
- When you find one, name it explicitly and add it to your own toolbox for future work.

## Rebuild your favorite interfaces

**Principle:** The single best way to notice the little details that make a design look polished is to recreate it from scratch — without inspecting it in developer tools.

**Why it works:** When your copy looks worse than the original and you can't peek at the answer, you're forced to diagnose the gap yourself. That diagnosis is where the learning happens; the tricks you discover this way stick because you derived them.

**Actionable guidance:**
- Pick an interface you love and rebuild it pixel-by-pixel from observation alone.
- No dev tools, no "view source" — the constraint is the point.
- Tricks you'll discover this way (with the values from the book's example card):
  - Reduce line height on headings: `line-height: 1.2` (vs. the looser default used for body text).
  - Add letter-spacing to uppercase text (the example annotates `letter-spacing: 0.8rem` on the card's uppercase "CREATE ACCOUNT" footer link; the principle is that all-caps text needs extra tracking).
  - Combine multiple box-shadows instead of one: a tight shadow plus a larger, softer one (the figure annotates `0 4px 6px hsla(0,0%,.7)` layered with `0 5px 15px hsla(0,0%,.1)`; the larger shadow carries the smaller value, .1 vs .7 — likely lower opacity, but each printed `hsla()` is missing an argument, so the figure is ambiguous). A second transcription trap: the figure prints the two shadow values on separate lines with no comma between them and a single semicolon after the second, but a real two-layer `box-shadow` declaration requires a comma between the layers. Copied verbatim, the snippet is invalid CSS and could be misread as two alternative shadows; a faithful reconstruction adds the comma so both layers apply as one declaration.
  - Crop decorative images with `overflow: hidden` rather than scaling them to fit.
- Of those four tricks, the book's prose names three ("reduce your line height for headings", "add letter-spacing to uppercase text", "combine multiple shadows"); the cropped-image trick exists only as a figure annotation.
- These tricks are the book's own earlier rules resurfacing — typography (tighter line-height on large text, tracking on all-caps), depth (layered two-part shadows), images (crop, don't distort). That's the implicit proof of the method: rebuilding lets you re-derive real principles yourself, including ones no book has written down.
- Make this a continual habit: studying inspiring work with a careful eye keeps yielding new tricks indefinitely ("for years to come").

## Quick-reference rules

- For every design you admire, ask: "What did they do that I wouldn't have thought of?"
- Collect unintuitive decisions (inverted component backgrounds, buttons inside inputs, two-color headlines) as reusable techniques.
- Hunt at every scale — a stealable decision can be as small as a second font color.
- Rebuild interfaces you love from scratch, without opening dev tools.
- Use the gap between your copy and the original as the diagnostic — figure out *why* yours looks different.
- Headings: tighten line-height to ~1.2.
- Uppercase text: add letter-spacing.
- Depth: layer multiple box-shadows (a tight one + a larger, softer one).
- Images: crop with overflow: hidden instead of distorting/scaling.
- Keep studying inspiring work carefully; the technique pipeline never runs dry.
