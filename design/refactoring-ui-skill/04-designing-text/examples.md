# Designing Text — Examples

Every figure in the chapter, paraphrased with enough context to stand alone.

## Establish a type scale

**Furniture product page with unsystematic sizes (bad).** An e-commerce detail page for a "Brooklyn Leather Sofa (82")" priced at $1,500 is annotated with the font size of each element: title 18px, details link 13px, color selector label 11px, price 26px, warranty text 15px, add-to-cart button 13px, shipping status 12px, "Delivery Calculator" heading 17px, calculator helper text 14px. Nine elements span eight nearly-random sizes with no system behind them. Lesson: without a scale, every value from ~10–24px ends up used somewhere, producing annoying inconsistencies.

**Same page on a scale (good).** The fixed version maps each element to scale values: title 18px, link 14px, selector label 14px, price 24px, warranty 16px, button 14px, shipping status 14px, calculator heading 16px, helper text 14px. The payoff: nine elements that previously used eight different sizes now collapse onto just four scale steps (14, 16, 18, 24px), with 14px alone covering five of the nine. Note that fitting to the scale snaps values in both directions — some shrink (price 26px → 24px, calculator heading 17px → 16px), others grow (warranty 15px → 16px, selector label 11px → 14px). This is what success looks like when applying a scale: most UI text converges on a small handful of sizes, each value rounded to the nearest step, and decisions come from a short menu instead of guesswork.

**Golden-ratio modular scale (questionable).** A scale built by scaling 16px up and down by factors of 1.618: 0.618em (9.88875px), 1em (16px), 1.618em (25.888px), 2.618em (41.8868px), 4.236em (67.7728px), 6.854em (109.656px). Marked with a "?" — mathematically elegant, but values are fractional (browsers round subpixels inconsistently) and the jumps leave gaps where UI work needs intermediate sizes.

**Hand-crafted scale (good).** The recommended interface scale rendered at every step: 12, 14, 16, 18, 20, 24, 30, 36, 48, 60, 72 px. Small steps at the bottom where precision matters, big steps at the top where it doesn't.

**Em-based scale pitfall.** A scale defined as .75em, .875em, 1em, 1.25em, 1.5em. Because em is relative to the parent, a .875em element nested inside a 1.25em (20px) parent computes to 17.5px — a size not on the scale at all. Lesson: define sizes in px or rem.

## Use good fonts

**Font-directory grid.** A wall of typeface cards (Freight Sans, Harmonia Sans, Work Sans, Proxima Nova, Aktiv Grotesk, Avenir Next, Roboto, Museo Sans, Akagi Pro, Din Pro, Meta Serif, Encode Sans, Futura, Franklin Gothic, Freight Text, Jubilat...) illustrating how overwhelming raw choice is — motivating the filtering tricks that follow.

**System font stack.** The safe fallback shown as code: `-apple-system, Segoe UI, Roboto, Noto Sans, Ubuntu, Cantarell, Helvetica Neue`. Users already see these fonts everywhere, so nothing looks off.

**Filtering by number of styles.** A font directory's filter panel with "Number of styles" cranked to 10+ while browsing sans-serifs. The surviving result shown is Acumin Pro with 90 styles. On Google Fonts this filter removes about 85% of fonts, leaving fewer than 50 sans-serifs — a tractable shortlist of families likely crafted with care.

**Headline font vs. small-size font anatomy.** "Hello World" set in Futura PT and Proxima Nova with annotations: Futura PT has tighter letter-spacing and a shorter x-height (built for headlines); Proxima Nova has wider letter-spacing and a taller x-height (built to stay legible small). Lesson: don't use condensed short-x-height faces for main UI text.

**Sorting by popularity.** A directory sorted by popularity surfacing EB Garamond, Alegreya, and Cormorant Garamond (each with 10 styles) — showing how crowd preference shortcuts the hard task of judging a personality serif yourself.

**Inspecting a well-designed site.** Browser dev tools open on a polished marketing card ("Citywide Delivery"), revealing `font-family: "Graphik", -apple-system, ...` in the Styles pane. Lesson: steal typeface choices from design teams with strong opinions.

## Keep your line length in check

**120-character lines (bad).** The opening of Moby-Dick set full-width at roughly 120 characters per line. The text is visibly fatiguing; the eye loses its place returning to each line start.

**Width comparison series.** The same passage (from Jane Eyre) set at 45–55, 55–65, and 65–75 characters per line — all comfortable. Accompanying rule: 45–75 characters is the target; 20–35em width achieves it on the web; going slightly past 75 can work but is risky.

**Wide content area, full-width intro (bad).** A marketing section titled "The one-size-fits-all platform": a three-column feature grid needs the full container width, and the intro paragraph above it was given `max-width: none`, so it stretches across the whole area in two very long lines.

**Same section with capped paragraph (good).** Identical layout but the intro paragraph gets `max-width: 34em`, wrapping into three short centered lines while the feature grid below stays full-width. Mixing widths inside one content area feels counterintuitive but looks more polished.

## Baseline, not center

**"Who to follow" card, center-aligned (questionable, then bad).** A social card whose header pairs a large "Who to follow" title (top left) with smaller "Refresh · See all" links (top right), set with `align-items: center`. With generous space between the two, the misalignment is easy to miss; a second version with the texts closer together makes the offset baselines visibly awkward.

**Baseline diagram.** The word "typography" with its baseline drawn in — the imaginary line letters rest on, which the eye already perceives as the alignment reference.

**Same card, baseline-aligned (good).** Identical header set with `align-items: baseline`. The title and links now sit on one shared line; the result is plainly cleaner than the centered version with its offset baselines.

## Line-height is proportional

**Anatomy of line-height 1.5.** A magnified view of body text showing 16px font size inside a 24px line box — i.e., line-height 1.5 — as the familiar starting-point advice.

**Tight lines on wide text (bad).** A wide Moby-Dick paragraph with cramped line spacing, annotated with arrows showing the eye returning from the right edge and being unsure which line comes next. The wider the line, the worse this gets.

**Width-proportional line-height (good).** Stacked in one panel: a narrow column at line-height 1.5 above a wide block at line-height 2, both comfortable. Line-height should grow with paragraph width.

**Small text at 1.25 vs 1.75.** The same small-font passage at line-height 1.25 (dense, hard to track — bad) and 1.75 (easy to follow — good). Small text needs more spacing help.

**Headline at 1.5 vs 1 ("Team communication optimized for deep work.").** A large two-line serif headline at line-height 1.5 looks gappy and disconnected (bad); at line-height 1 the two lines read as one unit (good). Large text needs no extra spacing — line-height is inversely proportional to font size.

## Not every link needs a color

**Links in prose (fine as-is).** An article paragraph where "The Right Way" and "boutique framework" are underlined links inside non-link text — here the loud treatment is correct, because links must be discoverable among plain prose.

**Video grid with blue links (bad).** A YouTube-style card grid where every video title and channel name is bright link-blue. Since nearly everything is clickable, the link styling overwhelms the page and creates no hierarchy.

**Video grid with subtle emphasis (good).** Same grid with titles in heavy dark text (emphasis via weight and darker color) and channel/metadata in quiet gray. Everything is still clickable; nothing screams.

**Hover-only links (good).** Same grid where the ancillary channel-name link ("Bread Masters") shows an underline only when the cursor hovers it. Users who try discover it; it never competes with the primary action (the video itself).

## Align with readability in mind

**Left-aligned post (baseline good practice).** A social feed post (Amanda Wagner announcing a Dribbble meetup) set `text-align: left` — the default for English and most languages: align with the reading direction.

**Centered feature cards (fine when short).** A three-column row of icon + heading + two-line blurb ("Beautiful templates", "Sell online", "Grow your Audience") — centering works for short, independent blocks.

**Centered long block vs left-aligned (bad/good).** A card ("The one-size-fits-all solution") with a six-line centered paragraph looks ragged and hard to read; the same card left-aligned reads cleanly. Anything beyond 2–3 lines should be left-aligned.

**Fixing an overlong centered block by editing copy (bad/good).** In a three-column centered row, the middle blurb ("Sell online") runs four lines while its neighbors run two, breaking the rhythm. The fix is editorial, not typographic: rewrite the blurb shorter so all three blocks match. This repairs alignment and makes the design feel consistent.

**Table numbers, left vs right aligned (bad/good).** A stock table (AAPL, GOOGL, AMZN, MSFT with price, change, market cap). Left-aligned numbers put decimals at random horizontal positions, making comparison hard; right-aligned numbers stack the decimals so values compare at a glance. Importantly, the fix is per-column, not table-wide: in the good version only the three numeric columns (price, change, market cap) become right-aligned, while the ticker-symbol text column stays left-aligned. Text columns and number columns get different alignments within the same table.

**Justified text without vs with hyphenation (bad/good).** A justified blog paragraph with `hyphens: none` shows large awkward gaps between words; with `hyphens: auto` words break across lines and the gaps shrink. Rule: justification requires hyphenation. Justified text suits print-like designs, but left alignment is always a safe alternative.

## Use letter-spacing effectively

**Three spacing settings on one paragraph.** The same body passage at `letter-spacing: -0.05em` (tight), `0` (normal), and `0.05em` (wide) — establishing the control, with the default rule: trust the typeface designer and leave it alone.

**Open Sans vs Oswald headlines.** "Team Communication Made Easy" set in Open Sans (a legibility font with wide built-in spacing) next to Oswald (a purpose-built condensed headline font). Open Sans looks loose as a headline by comparison.

**Tightening Open Sans for headlines (good).** The same Open Sans headline with `letter-spacing: -0.05em` applied — it now mimics the condensed headline look. Caveat: the reverse fails; headline fonts rarely work at small sizes even with added spacing.

**Letterform anatomy diagram.** "typography" annotated with ascender line, x-height, baseline, and descender line — showing how lowercase variety (ascenders in b/f/t, descenders in y/g/p, x-height letters like n/v/e) helps the eye tell letters apart.

**All-caps label spacing (bad/good).** "FULL STACK DEVELOPER" at default spacing is harder to read because uniform-height capitals lack distinguishing features; with `letter-spacing: 0.05em` the label becomes notably more legible. Rule: widen letter-spacing on all-caps text.
