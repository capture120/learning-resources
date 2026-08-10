# Working with Images — Core Learnings

## Chapter overview

Images are not decoration you can swap in later; they are first-class design elements with their own quality bar and their own intended dimensions. The chapter's driving intuition: a single weak photo, a stretched icon, or an uncontrolled user upload can undermine an otherwise polished interface. Two root causes explain most image problems: (1) photos can be very dynamic — often containing both very light and very dark regions — so nothing placed on top of them has reliable contrast; and (2) every raster image, vector icon, and screenshot was drawn for a specific display size, and rendering it at a different size destroys its proportions and detail. The fixes are about regaining control: flatten the dynamics under text, present assets at (or redraw them for) the size they were designed for, and constrain user content so it cannot break your layout.

## Use good photos

**Principle:** A bad photo ruins a design even when everything else is excellent.

**Why:** Great photography is a skill — lighting, composition, color — not a camera spec, so amateur shots read as amateur regardless of the surrounding UI quality. The book stresses these skills take years to develop, which is why its answer is sourcing the photos (hire a pro or buy stock) rather than trying to shoot better ones yourself.

**Guidance:**
- If the design needs photography and you are not a skilled photographer, you have two options:
  1. Hire a professional photographer for project-specific shots.
  2. Use high-quality stock photography for generic needs. The book frames this option around paying: there are tons of great resources where you can purchase quality stock, and free sites like Unsplash that offer beautiful photography are called out as a bonus exception ("there are even sites…"), not the default plan.
- Never design with placeholder images planning to swap in smartphone snapshots later — it never works. The polished mockup will collapse the moment real low-quality photos go in.

## Text needs consistent contrast

**Principle:** When text over a hero image is unreadable, the problem is the image, not the text. Photos can be very dynamic, with lots of really light areas and lots of really dark areas, so any single text color fails somewhere. Fix it by reducing the image's dynamics so the text-to-background contrast becomes consistent.

Four tactics, with the book's exact values:

1. **Add a semi-transparent overlay.** A black overlay darkens the light areas so white text works everywhere; a white overlay brightens the dark areas for dark text. Book's example value: `background-color: hsla(0, 0%, 0%, .55)` (black at 55% opacity) under white text. Trade-off: it lightens/darkens the entire image, not just the problem spots.
2. **Lower the image contrast itself.** Gives finer control than an overlay. Lowering contrast shifts the overall lightness feel, so compensate with brightness. Book's example values: contrast −70%, brightness +40% (producing a washed-out light image that supports dark text).
3. **Colorize the image.** Tint the whole photo a single color so text pops and the image matches brand colors. Three steps if your editor lacks a built-in duotone/colorize feature:
   1. Lower the image contrast to even things out.
   2. Desaturate the image to strip existing color.
   3. Add a solid color fill with the "multiply" blend mode. Book's example: fill #035581 (a deep brand blue), multiply, white text on top.
4. **Add a text shadow.** Preserves more of the image's dynamics by boosting contrast only where the text sits. Make it read as a subtle glow, not a drop shadow: large blur radius, zero offset. Book's example: `text-shadow: 0 0 50px hsla(0, 0%, 0%, .4)`. Still reduce overall image contrast a bit — the shadow just lets you reduce it less.

## Everything has an intended size

**Principle:** Every asset is drawn for a particular display size. Rendering it larger or smaller than intended degrades it — even vectors, which scale without pixelation but not without losing design quality.

**Don't scale up bitmaps.** Enlarging a raster image past its original size makes it fuzzy immediately. (Common knowledge, but the baseline for the rest.)

**Don't scale up icons.** Icons drawn at 16–24px look unprofessional blown up to 3x–4x: they lack detail and feel disproportionately "chunky," even though SVG scaling is technically lossless. Options:
- Best: use icons actually drawn for the large size (e.g., a 48px slot gets art designed at 48px, with the extra detail that size affords).
- If you only have small icons: keep the icon near its intended size and enclose it in a larger shape with a background color (e.g., a 24px-ish icon centered in a 48px tinted circle). The shape fills the space while the icon stays close to the size it was drawn for, so its proportions and detail still look right.

**Don't scale down screenshots.** Shrinking a full-size screenshot by ~70% to fit a feature section crams too much detail into too little space: 16px app text becomes roughly 4px. The harm the book describes is behavioral, not aesthetic — visitors end up squinting with their eyes two inches from the screen, actively struggling to make out what the tiny text says. The shrunken detail still looks readable enough to invite reading attempts; it doesn't fade into the background. That active struggle is what unifies the three fixes: the first two restore legibility, and the third removes the reading temptation entirely. Three alternatives:
- Take the screenshot at a smaller screen size (e.g., your tablet layout) and reserve a generous slot for it in the design, so it needs far less shrinking.
- Use a partial screenshot of just the relevant region, displayed near actual size.
- If you must show the whole app small, draw a simplified illustration of the UI: strip the detail and replace small text with plain lines. It communicates the big-picture design without inviting people to squint at unreadable text.

**Don't scale down icons either.** Large-size artwork shrunk to small sizes turns choppy and muddy. The extreme case is favicons: a logo drawn at 128px shrunk to 16px renders as mush. Instead, redraw a heavily simplified version of the logo at the target size — fewer details, thicker forms — so you choose the compromises instead of letting the browser's downscaler choose them.

## Beware user-uploaded content

**Principle:** You can't art-direct user uploads — no contrast tuning, color grading, or perfect crops. But you can constrain shape, size, and edges so user content can't wreck the design. The book is explicit that this is damage control, not a cure: you stay at your users' mercy to some extent, and the goal is only to keep their content from completely undermining the design.

**Control the shape and size.** Displaying uploads at their intrinsic aspect ratios produces a ragged, broken grid when many images appear together. Center each image inside a fixed-size container and crop whatever doesn't fit. In CSS: render it as a background image with `background-size: cover` (today, `object-fit: cover` on an `img` does the same).

**Prevent background bleed.** When an upload's background color matches your UI background (e.g., a light portrait on a white chat UI), the image edge disappears and it loses its shape. Fixes:
- Don't reach for a solid border — borders often clash with colors inside the photo. (The rejected border example was `border: 2px solid hsl(212, 12%, 72%)`, which clashed with the avatars.)
- Use a subtle inner box shadow instead; viewers barely notice it, but it defines the edge against any image. Book's example: `box-shadow: inset 0 0 0 1px hsla(0, 0%, 0%, .1)` — a 1px inner ring of 10% black.
- Equivalent alternative if you dislike the slight inset look: a semi-transparent inner border. The book gives no separate CSS for it. (Note: the PDF's figure captions are inconsistent across both pages — page 216 repeats the border code under both comparison figures, and the box-shadow code appears only once in the chapter, as the caption of the page-217 check figure that immediately follows the inner-border paragraph. The `inset 0 0 0 1px` value cited above is therefore sourced from that page-217 caption, not the page-216 comparison, and that caption belongs to the box-shadow technique even though the figure sits under the inner-border discussion.)

## Quick-reference rules

- Bad photos ruin good designs: hire a pro or buy quality stock (Unsplash is the noted free exception); never plan to swap in phone photos later.
- Text over photos fails because the image is dynamic; flatten the image, don't fiddle with text color.
- Overlay tactic: semi-transparent black (~55% opacity) for white text; white overlay for dark text.
- Contrast tactic: lower image contrast (e.g., −70%) and compensate brightness (e.g., +40%).
- Colorize tactic: lower contrast → desaturate → solid brand-color fill with multiply blend.
- Text-shadow tactic: large blur, zero offset (e.g., 0 0 50px, 40% black) so it reads as a glow; still reduce image contrast somewhat.
- Never scale 16–24px icons up 3x–4x; use icons drawn for the target size.
- Small icon in a big slot: keep it near intended size inside a colored shape (e.g., tinted circle).
- Don't shrink full screenshots ~70%; 16px app text becomes ~4px, and visitors squint two inches from the screen struggling to read it.
- Instead: screenshot a smaller layout (and give it ample space), crop to a partial region, or draw a simplified UI illustration with lines for text.
- Don't shrink large logos to favicon size (128px → 16px = mush); redraw a simplified version at 16px.
- Force user uploads into fixed containers, center and crop (`background-size: cover`; `object-fit: cover` is a modern editorial equivalent, not in the book).
- Fix image/background bleed with a subtle inner box shadow (e.g., inset 0 0 0 1px, 10% black) or semi-transparent inner border — not a solid border.
