# Hierarchy is Everything — Core Learnings

## Chapter overview

Visual hierarchy means controlling how important each element *appears* relative to the others. It is the single biggest lever for making a UI feel "designed" — more than color schemes, fonts, or layout. The chapter opens with a reframe: design only feels like it demands innate artistic talent if you equate it with superficial styling, but one of the biggest factors in "looking good" has nothing to do with superficial styling at all — which is why hierarchy is a learnable skill rather than a gift. The first-principles insight: when every element shouts at equal volume, the result reads as noise; the eye has no path through the page. Deliberately amplifying what matters and muting what doesn't gives the same content a clear reading order, and it instantly looks better even when nothing else changes.

The driving intuition: hierarchy is relative. You can raise an element by emphasizing it, or — when there's nothing more you can add to it — by de-emphasizing everything around it. Your tools are size, font weight, and color/contrast, and they trade off against each other. The element's semantic role (h1 tag, "delete" meaning, label/value structure) should never dictate its visual treatment; visual importance to the user should.

---

## Not all elements are equal

**Principle.** Decide which elements are primary, secondary, and tertiary, then style them so that ranking is visible. An interface where everything competes for attention feels chaotic even when the content is fine.

**Why it works.** The viewer's eye needs a guided path. De-emphasizing supporting information makes the important parts pop without adding anything new — the demo in the book improves a dashboard dramatically while keeping the same color scheme, typeface, and layout.

**Guidance.**
- Audit every element: is it primary, secondary, or tertiary to the user's task?
- Don't just boost the important things — actively mute secondary and tertiary information (smaller, lighter, lower contrast).
- Hierarchy alone can make a design feel finished; treat it as the first fix, not styling.

---

## Size isn't everything

**Principle.** Don't lean on font size alone to express hierarchy. Doing so forces primary text too large and secondary text too small. Use font weight and color as co-equal tools.

**Why it works.** A bold weight or a darker color signals importance just as strongly as size, so you can keep sizes in a readable range. Softer color de-emphasizes supporting text while sacrificing less readability than shrinking it.

**Guidance — specific values from the book:**
- Bolding a primary element lets you shrink it: a 30px regular-weight title works better at **24px with weight 700**; a 24px regular price works at **18px with weight 700**.
- For supporting text, prefer a softer color over a tiny size: e.g. secondary text at **18px in hsl(201, 23%, 34%)** and fine print at **16px in hsl(203, 15%, 47%)** instead of cramming sizes down.
- Stick to **two or three text colors**:
  - a dark color for primary content (e.g. an article headline) — book example: **hsl(202, 57%, 15%)**
  - a grey for secondary content (e.g. publish date) — example: **hsl(201, 23%, 34%)**
  - a lighter grey for tertiary content (e.g. footer copyright) — example: **hsl(203, 15%, 47%)**
- **Two font weights** are usually enough for UI work:
  - normal (**400 or 500**, depending on the typeface) for most text
  - heavier (**600 or 700**) for emphasis
- **Never use weights under 400 for UI text.** They can work for large headings but become unreadable at small sizes. To de-emphasize, use a lighter color or smaller size instead of a thinner weight.

---

## Don't use grey text on colored backgrounds

**Principle.** Light grey de-emphasizes text on white because it *reduces contrast with the background*. On a colored background, grey doesn't move the text toward the background color, so it doesn't read as secondary — it just doesn't look good.

**Why it works.** What actually signals "secondary" is closeness to the background color. On white, grey is closer to white. On teal, a desaturated light teal is closer to teal; grey is not.

**Guidance.**
- On colored backgrounds, **don't use grey** (e.g. hsl(0, 0%, 78%)) for de-emphasized text.
- **Don't use white at reduced opacity** (e.g. hsla(0, 0%, 100%, 0.6)) either: it reduces contrast but reads as dull, washed out, or disabled — and on an image or patterned background, the background bleeds through the letterforms.
- Instead, **hand-pick a new color**: keep the **same hue as the background**, then adjust **saturation and lightness** until it reads as secondary. Tune it **by eye** until it looks right — the book gives no formula. Example: on a teal background, de-emphasized text becomes **hsl(183, 70%, 84%)**.
- Hand-picking this way reduces contrast **without the text looking faded** — the failure mode of both grey and translucent white.

---

## Emphasize by de-emphasizing

**Principle.** When the main element won't stand out and you can't add anything more to it, mute its competitors instead.

**Why it works.** Hierarchy is relative. Lowering the volume of surrounding elements raises the relative prominence of the one you care about, with zero added visual noise.

**Guidance.**
- For an active nav item that won't "pop" despite an accent color: give the **inactive items a softer grey** so they recede, rather than further decorating the active one.
- At layout scale: if a sidebar competes with the main content, **remove the sidebar's background color/card** and let it sit directly on the page background. Fewer boxed regions means the real content wins by default.
- General move: scan for elements you can quiet (color, contrast, background fills, borders) before adding emphasis anywhere.

---

## Labels are a last resort

**Principle.** This applies to *displaying* data, not to forms — form inputs still get labels; no accessibility rule is being broken here. Displaying data as "Label: value" pairs flattens hierarchy — every datum gets equal emphasis and the interface looks like a database dump. Prefer formats, context, and composition over labels.

**Why it works.** Users usually recognize data by its format or position, so labels are redundant; removing them frees you to style each piece of data by its actual importance. The trap is most tempting when rendering database records, where every column invites a name: value line. The payoff is double: the interface gets *easier to use* (identifying information stands out) and feels more designed.

**Guidance.**
- **You might not need a label at all.** Format identifies the data: janedoe@example.com is an email, (555) 765-4321 is a phone number, $19.99 is a price. Context covers the rest: "Customer Support" beneath a name in an employee directory clearly means the department the person works in.
- **Combine label and value into one phrase** when format alone is ambiguous: "In stock: 12" → "**12 left in stock**"; "Bedrooms: 3" → "**3 Bedrooms**". The figures style these phrases at two levels: the number is bold and dark, while the surrounding words — and any icons — are set in a lighter grey. Muting the words is half the technique; bolding the number alone (with regular-dark words) loses the hierarchy. The chapter's tour card does the same with "**$17** per person". Small icons can reinforce the meaning (a bed icon beside "3 Bedrooms"); they take the same muted grey as the words.
- **When you truly need labels** (dashboards, many similar metrics that must be scannable): treat the label as supporting content. De-emphasize it with **smaller size, lower contrast, lighter weight, or a combination** (e.g. small uppercase grey "HEART RATE" above a large bold "82" with a small "BPM" unit). The data is the star.
- **When users scan for the label, flip the emphasis.** On information-dense pages like product spec sheets, users hunt for words like "depth", not values like "7.6mm". Bold/darken the label, set the value in a slightly lighter color — but don't over-mute the data; a darker label and slightly lighter value is usually enough.

---

## Separate visual hierarchy from document hierarchy

**Principle.** Choose HTML elements (h1–h6, etc.) for semantics; choose their styling for visual hierarchy. Never let the tag's default size dictate how big something renders.

**Why it works.** Browser defaults (big h1, small h6) suit documents, not application UIs. In an app, a page or section title usually acts as a *label* — supporting content — while the content beneath it is the real focus.

**Guidance.**
- App page titles can be small: the book shrinks an h1 "Manage Account" title from **24px to 16px** and the page improves because the content takes focus.
- Section titles should often be visually quiet or, taken to the extreme, **kept in the markup for accessibility but visually hidden entirely** when the content speaks for itself.
- Rule: pick the element for meaning, then style it however the hierarchy demands.

---

## Balance weight and contrast

**Principle.** Visual emphasis comes from two levers: weight (how many pixels an element covers) and contrast (how far its color sits from the background). The levers are interchangeable — use one to compensate for the other.

**Why it works.** Bold text feels emphasized because it covers more surface area: in the same space, more pixels go to text than to background (the book illustrates a bold "A" at ~90px² of ink vs ~50px² regular). Icons — especially solid ones — cover even more area, so at full contrast they overpower adjacent text. Reducing contrast acts as a counterbalance: the heavy element *feels* lighter even though its weight never changed.

**Guidance.**
- **Lower contrast to compensate for heavy weight.** Icons can't be made "thinner", so soften their color instead: in the book's sidebar nav, icons drop from **hsl(212, 20%, 13%)** (same as the text) to **hsl(212, 20%, 68%)**, balancing them against the regular-weight labels.
- **Raise weight to compensate for low contrast.** A 1px border in a dark color (**1px solid hsl(206, 16%, 74%)**) feels harsh; the same 1px in a soft color (**1px solid hsl(210, 23%, 95%)**) disappears. The fix: keep the soft color and **double the width — 2px solid hsl(210, 23%, 95%)** — emphasized but still soft.
- This counterbalancing works anywhere elements of different intrinsic weights must coexist: icons vs text, borders vs content, dividers, badges.

---

## Semantics are secondary

**Principle.** Button design has two dimensions: what the action *means* (semantics: destructive, positive) and where it sits in the page's hierarchy of importance. Hierarchy comes first.

**Why it works.** The book's mental model is a **pyramid of importance** that every action on the page sits somewhere in: most pages have **one true primary action** at the apex, **a couple of secondary actions** below it, and **a few rarely used tertiary actions** at the base — a shape to audit any page's buttons against, not an arbitrary count. Styling every action by semantic color (red delete, blue edit, green publish, all solid) produces a noisy row of equally loud buttons that communicates nothing about what the user should do.

**Guidance.**
- **Primary actions: obvious.** Solid, high-contrast background color.
- **Secondary actions: clear but not prominent.** Outline styles or lower-contrast background fills.
- **Tertiary actions: discoverable but unobtrusive.** Style them like links.
- **Destructive ≠ big red bold.** If the destructive action isn't the page's primary action, give it secondary (e.g. a low-key button with red label text) or tertiary (quiet link-style text) treatment.
- Put the big, red, solid styling on the **confirmation step**, where the destructive action genuinely is the primary action of the dialog (e.g. a "Deactivate account" modal with a solid red Deactivate button next to a quiet Cancel).

---

## Quick-reference rules

- Rank every element primary/secondary/tertiary; mute the lower ranks, don't just amplify the top.
- Don't use font size alone for hierarchy; reach for weight and color first.
- Bold a title (600–700) so you can shrink it to a sane size (e.g. 30px/400 → 24px/700).
- De-emphasize supporting text with a softer color, not a tiny font size.
- Limit body text to 2–3 colors: dark (primary), grey (secondary), light grey (tertiary).
- Use only two font weights in UI: normal (400/500) and bold (600/700).
- Never use font weights under 400 in UI text; de-emphasize with color or size instead.
- Never put grey text on a colored background.
- Don't fake de-emphasis with reduced-opacity white; it looks washed out and bleeds on images.
- On colored backgrounds, hand-pick secondary text: same hue as the background, adjusted saturation/lightness.
- If something won't stand out, de-emphasize its competitors instead of decorating it further.
- Remove a competing sidebar's background; let secondary panels sit on the page background.
- Drop "Label: value" formatting; let format and context identify data.
- When a bare value is ambiguous, fold the label into it ("12 left in stock", "3 Bedrooms"): bold-darken the number, grey the words and icons.
- When labels are required for scanning, style them as small/light/low-contrast support under emphasized data.
- On spec-sheet-style pages where users scan for labels, emphasize the label and only slightly lighten the value.
- Pick HTML tags for semantics, sizes for hierarchy; an h1 can be 16px.
- App section titles act as labels: keep them small, or visually hide them while keeping them in markup.
- Soften icon color to balance icons against text (icons are heavy; you can't thin them).
- If a soft-colored 1px border is too subtle, thicken it to 2px instead of darkening it.
- Audit actions against a pyramid of importance: one primary at the apex, a couple secondary, a few tertiary.
- One primary action per page: solid, high contrast. Secondary: outline or low-contrast fill. Tertiary: link style.
- Figure-derived: the primary fill is a solid high-contrast color for its context — blue on white, bright green on the dark background, solid white on the purple gradient.
- Don't make destructive buttons big/red/bold unless they're the primary action; save that for the confirmation dialog.
