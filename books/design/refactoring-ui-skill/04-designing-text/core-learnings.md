# Designing Text — Core Learnings

## Chapter overview

Typography decisions should serve reading, not layout. The chapter's underlying values:

1. **Systems beat ad-hoc choices.** Picking font sizes (or anything else) freehand produces inconsistency and slows you down. A constrained, predefined scale makes decisions fast and designs coherent.
2. **Optimize for the reader's eye.** Line length, line height, alignment, and letter-spacing all exist to reduce the physical work of reading: tracking a line, finding the next one, distinguishing letters. Every rule here follows from how eyes actually move across text.
3. **Typography variables are interdependent.** Line-height depends on line length and font size; letter-spacing depends on case and the font's intended size; alignment depends on content type. There is no universally correct single value — proportionality is the rule.
4. **Respect intent, then adjust.** Typeface designers bake purpose into their fonts (headline vs. body). Use fonts for what they were built for, and only override defaults (letter-spacing, etc.) when you understand why.

---

## Establish a type scale

**Principle:** Define a fixed set of font sizes in advance instead of choosing values per-element.

**Why:** Without a system, every pixel value from 10px to 24px ends up somewhere in the UI. That creates visible inconsistency and forces a fresh decision for every label.

**Guidance:**

- A **linear scale won't work** — the same lesson as the book's spacing-and-sizing system: small steps matter at small sizes but are wasted at large sizes (nobody should deliberate between 46px and 48px headlines).
- **Modular scales** (multiply by a ratio): common ratios are 4:5 ("major third"), 2:3 ("perfect fifth"), 1:1.618 (golden ratio). Start from a base of 16px (the browser default) and multiply repeatedly. These can work well for long-form content like articles, but for interface design they have drawbacks:
  - **Fractional values.** 16px base × 4:5 yields 31.25px, 39.063px, 48.828px, etc. Browsers round subpixels differently, causing off-by-one rendering. If you use a modular scale, round the values yourself when defining it.
  - **Too few sizes.** A rounded 3:4 scale gives 12, 16, 21, 28px — in practice you'll want sizes between 12 and 16 and between 16 and 21. Tightening the ratio (e.g. 8:9) just means reverse-engineering the sizes you already wanted.
- **Hand-crafted scales** are more practical for interfaces: pick whole-pixel values directly. No subpixel rounding issues, and you control exactly which sizes exist instead of outsourcing that to a formula. Recommended scale (pairs well with the book's spacing/sizing scale):

  **12, 14, 16, 18, 20, 24, 30, 36, 48, 60, 72 px**

  Constrained enough to speed decisions, rich enough that no useful size is missing.
- **Avoid em units** for the scale. Ems are relative to the parent's font size, so nested elements compute to off-scale values (a .875em child inside a 1.25em/20px parent computes to 17.5px — not in your scale). Use **px or rem** so sizes always land on the system.

---

## Use good fonts

**Principle:** You can pick high-quality typefaces without years of trained taste by using proxies for quality.

**Tactics:**

- **Play it safe:** for UI work, a neutral sans-serif (Helvetica-like) is the safest choice. If unsure, use the **system font stack**: `-apple-system, Segoe UI, Roboto, Noto Sans, Ubuntu, Cantarell, Helvetica Neue` — not ambitious, but familiar to every user.
- **Ignore typefaces with fewer than five weights.** A heuristic, not a law — the book concedes it isn't always true — but families with many weights tend to be crafted with more care. On font directories, filter by "number of styles" (weights plus their italic variants) set to **10+** — five weights doubled to account for italics. On Google Fonts this eliminates ~85% of options, leaving under 50 sans-serifs to evaluate.
- **Optimize for legibility:** fonts are designed for a purpose. Headline fonts have tighter letter-spacing and shorter x-heights (e.g. Futura PT); fonts for small sizes have wider letter-spacing and taller x-heights (e.g. Proxima Nova). **Avoid condensed, short-x-height typefaces for main UI text.**
- **Trust the crowd:** sort directories by popularity — popular fonts are usually good. Especially useful when picking a personality font (e.g. a serif) where judging quality is harder.
- **Steal from people who care:** inspect the CSS of well-designed sites you admire. Teams with strong typographic opinions often choose excellent fonts that the safer tricks above (style-count filters, popularity sorting) would never surface.
- These tricks are stopgaps: once you start paying attention to typography on good sites, your own judgment develops quickly — the book expects you to outgrow them soon.

---

## Keep your line length in check

**Principle:** Size paragraphs for reading, not to fill the layout.

**Why:** Long lines (e.g. ~120 characters) are hard to read; the eye struggles to track and to return to the next line's start.

**Guidance:**

- Target **45–75 characters per line**.
- On the web, set paragraph width in em — em is relative to the current font size, so the character count holds: **20–35em** lands in that range.
- Slightly over 75 characters can sometimes work, but it's risky — stay in 45–75 to be safe.
- **Mixed-width content:** when paragraphs sit alongside wide images or components, still cap the paragraph width (e.g. `max-width: 34em`) even though the container is wider. Different widths inside one content area look counterintuitive but almost always read as more polished.

---

## Baseline, not center

**Principle:** Mixing font sizes on one line is a standard way to create hierarchy (large title, smaller actions). When you do it, align the text by **baseline** (the line letters sit on), not by vertical center — even though centering "for balance" is the instinctive choice.

**Why:** The eye already perceives the baseline as the reference line. Center-aligning two sizes offsets their baselines, which looks subtly off — especially when the texts sit close together (large gaps can hide it, proximity exposes it).

**Guidance:**

- Use `align-items: baseline` (flexbox) instead of `align-items: center` for rows that mix sizes, e.g. a card title next to smaller action links.
- Result is simpler and cleaner than centered text with offset baselines.

---

## Line-height is proportional

**Principle:** "Use 1.5 line-height" is only a starting point. The right line-height depends on **line length** and **font size** — there is no single correct value.

**Why:** Line spacing exists so the eye can find the next line after wrapping. Rereading or skipping a line means line-height was too short.

**Guidance:**

- **Line length:** the wider the text, the farther the eye travels back, the easier it is to lose the line. Line-height should scale with paragraph width — narrow columns can use ~**1.5**; wide content may need up to **2**.
- **Font size (inverse relationship):** small text needs more spacing help; large text needs less.
  - Small body text: a cramped 1.25 reads poorly; ~**1.75** reads well.
  - Large headline text: the eye needs no help; **line-height 1** is fine. A 1.5 line-height on a wrapping headline leaves it looking disconnected and gappy.
- Summary: line-height is **proportional to line length** and **inversely proportional to font size**.

---

## Not every link needs a color

**Principle:** The classic blue/underlined link treatment is for links embedded in non-link prose. In link-dense interfaces, it's overbearing.

**Guidance:**

- A link inside a paragraph of regular text should stand out and look clickable (color, underline).
- In UIs where nearly everything is clickable (e.g. a video-card grid), emphasize links subtly: a **heavier font weight** or **darker color** instead of blue.
- Truly **ancillary links** (off the main user path, e.g. metadata like a channel name) need no default emphasis at all — add an underline or color change **only on hover**. They stay discoverable for users who try, without competing with primary actions.

---

## Align with readability in mind

**Principle:** Align text to match the reading direction of the language — for English, left-aligned almost everywhere.

**Guidance:**

- **Don't center long-form text.** Centering works for headlines and short, independent blocks; anything longer than **2–3 lines** almost always looks better left-aligned.
- If you want a set of centered blocks but one runs long, the easiest fix is to **rewrite the copy shorter** — it fixes alignment and makes the design feel more consistent.
- **Right-align numbers in tables.** With the decimal point in a fixed position, values are far easier to compare at a glance.
- **Hyphenate justified text.** Justification without hyphenation creates awkward word gaps; pair `text-align: justify` with `hyphens: auto`. Justified text suits a print-like, more formal look (online magazine, newspaper), but even there left-aligned works just as well — it's preference.

---

## Use letter-spacing effectively

**Principle:** Designers fuss over weight, color, and line-height but forget letter-spacing is adjustable too. Default rule: trust the typeface designer and leave it alone. Adjust it mainly in two common situations where it can improve a design.

**Guidance:**

- **Tightening headlines:** legibility-focused families (e.g. Open Sans) ship with wide letter-spacing for small sizes. When using such a font for a large headline, **decrease letter-spacing** (e.g. `letter-spacing: -0.05em`) to mimic a purpose-built headline family (like Oswald). Don't do the reverse — headline fonts rarely work at small sizes even with added spacing.
- **All-caps text:** default spacing is tuned for sentence case (one capital, then mostly lowercase), where ascenders, descenders, and x-height variation help the eye distinguish letters. All-caps loses that variety, so **increase letter-spacing** (e.g. `letter-spacing: 0.05em`) for labels, tags, and headings in caps.

---

## Quick-reference rules

- Define a fixed type scale; never pick font sizes ad hoc.
- Don't use a linear type scale; steps must grow with size.
- If using a modular scale, round values to whole pixels.
- Prefer a hand-picked scale: 12, 14, 16, 18, 20, 24, 30, 36, 48, 60, 72 px.
- Define the scale in px or rem, never em (nesting breaks the system).
- For UI text, default to a neutral sans-serif or the system font stack.
- Skip typefaces with fewer than 5 weights; filter directories to 10+ styles.
- Avoid condensed, short-x-height fonts for body/UI text.
- Sort by popularity to shortlist fonts; inspect sites you admire to find good ones.
- Keep paragraphs at 45–75 characters per line (20–35em width).
- Cap paragraph width (e.g. max-width: 34em) even inside wider content areas.
- Align mixed font sizes on a line by baseline, not vertical center (`align-items: baseline`).
- Scale line-height up with line length: ~1.5 for narrow columns, up to 2 for wide text.
- Scale line-height down with font size: ~1.75 for small body text, 1 for large headlines.
- In link-heavy UIs, mark links with weight or darker color, not blue/underline.
- Show ancillary links' link styling only on hover.
- Left-align text in left-to-right languages by default.
- Text longer than 2–3 lines almost always looks better left-aligned; shorten copy if a centered block runs long.
- Right-align numbers in tables so decimals line up.
- Always enable hyphenation (`hyphens: auto`) on justified text.
- Leave letter-spacing alone by default.
- Tighten letter-spacing (~-0.05em) when using a body font for large headlines.
- Widen letter-spacing (~0.05em) on all-caps text.
- Avoid headline fonts at small sizes; they rarely work even with extra letter-spacing.
