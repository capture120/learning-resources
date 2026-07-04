# Leveling Up — Examples

## Look for decisions you wouldn't have made

### Inverted datepicker background
**Context:** A light-themed table of invoices (dates, due dates, amounts) with a date-range filter at the top. Clicking the filter opens a calendar dropdown for picking a range (July 9–19, 2018).
**The unintuitive decision:** Instead of matching the light UI around it, the datepicker dropdown uses a dark, inverted background — near-black panel, light text, blue circular markers on the selected start/end dates and a tinted band across the in-between dates.
**Why it works:** The inverted panel makes the temporary overlay visually distinct from the page content beneath it, so the calendar reads instantly as a floating control rather than part of the table. It's the kind of choice most people wouldn't default to — which is exactly why spotting it teaches something.
**Figure detail:** Only the background flips — the surrounding invoice page stays neutral grayscale, so the dark panel and its blue date markers are the figure's only color departure. (The book offers no rationale in prose; the figure itself is the lesson.)
**Bonus decisions in the background table:** The invoice table behind the dropdown models the same hunt at smaller scale. Its DUE DATE column uses relative, human-friendly phrasing — "In 2 days", "Yesterday", "16 days ago" — instead of raw absolute dates (the neighboring DATE column keeps the literal 2018 dates). And the column headers (DATE, DUE DATE, AMOUNT — the last cropped by the figure edge) are small gray all-caps labels, the same uppercase-label treatment the chapter's final card annotates with letter-spacing. Practicing "look for decisions you wouldn't have made" on this very figure turns up stealable moves beyond the headline dark-dropdown lesson.

### Button inside the text input
**Context:** A newsletter signup bar on a dark navy band: heading "Join our newsletter" above a single email field.
**The unintuitive decision:** The blue "Join" submit button sits *inside* the white input's bounds (right edge), with an envelope icon on the left of the field — rather than the conventional layout of a separate button next to the input.
**Figure detail:** The full left-to-right anatomy of the component: envelope icon, muted gray placeholder reading "Enter your email address", then the blue Join button. The whole thing reads as one white rounded bar on the navy band, and the button sits inset with a visible gap from the field's right border rather than flush against it — that breathing room is what makes the placement look deliberate instead of broken.
**Why it works (inferred):** The input and action fuse into one compact, self-explanatory unit. It looks more polished and saves horizontal space. Again, it's a placement most designers wouldn't instinctively try. (The book offers no rationale in prose; the figure itself is the lesson.)

### Two-color headline
**Context:** A landing-page hero for a chat product ("ChitChat"): headline "A better way to speak / with your customers" over muted supporting copy. That copy reads "An easy to use chat button on your website that allows you to answer questions from" — the sentence is cut off by the figure's crop — and it's what establishes the product context (an embeddable chat widget) behind the two-color headline.
**The unintuitive decision:** The headline's first line is dark gray/near-black; the second line is the brand's blue. One headline, two font colors.
**Figure detail:** The second line's blue sits in the same color family as the two-tone ChitChat logo mark in the nav above, though it isn't an exact match to either logo tone.
**Why it works (inferred):** Cheap visual interest without adding any elements — the color split creates hierarchy and emphasis inside a single heading. Trivially simple once seen, but easy to never think of. (The book offers no rationale in prose; the figure itself is the lesson.)

**Section takeaway:** Each example answers the question "what did the designer do that I never would have thought to do?" Collecting these unintuitive moves is how you grow your toolbox.

## Rebuild your favorite interfaces

### Annotated marketing card (the tricks rebuilding reveals)
**Context:** A small marketing card: heading "Powering businesses all over the globe", a dotted world map with blue location pins, supporting copy ("offices in 6 different countries... support 24 hours a day, 7 days a week"), and an uppercase "CREATE ACCOUNT" link in a footer strip. The book annotates the four non-obvious details that make it look polished — the kind of details you only notice when your from-scratch rebuild looks "off" and you have to ask why:
1. **Reduced line height for the heading** — `line-height: 1.2`. Multi-line headings set at body-text line height look loose; tightening them is a trick you'd discover when your heading looks subtly wrong.
2. **Cropped image** — the dotted map is clipped with `overflow: hidden` rather than resized to fit, keeping its scale and texture intact.
3. **Multiple shadows** — the card layers two box-shadows rather than one: a tight `0 4px 6px hsla(0,0%,.7)` plus a larger, softer `0 5px 15px hsla(0,0%,.1)` (the printed `hsla()` values are missing an argument, so what the `.7`/`.1` mean is ambiguous). The figure's label is simply "Multiple shadows". Note the print also omits the comma between the two value lines (only one trailing semicolon) — valid CSS needs a comma so both layers apply in a single declaration.
4. **Letter spacing on uppercase text** — the "CREATE ACCOUNT" label gets extra tracking (annotated `letter-spacing: 0.8rem` in the figure). All-caps text reads cramped at default spacing.
**The lesson:** None of these would surface from passively looking at the card. They surface when you rebuild it without peeking at dev tools, your version looks different, and you investigate the gap. That self-derived diagnosis ("reduce line height for headings", "add letter-spacing to uppercase text", "combine multiple shadows") is the highest-yield form of design practice the book recommends.
