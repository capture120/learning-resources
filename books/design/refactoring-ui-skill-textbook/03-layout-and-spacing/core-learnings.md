# Layout and Spacing — Core Learnings

## Chapter overview

Simply giving every element a bit more breathing room is one of the easiest ways to clean up a design, and spacing also signals which elements belong together, making a UI understandable. The chapter's driving intuition:

- **Generosity by default.** Designers habitually add white space only until things stop looking cramped, which lands at the bare minimum. Great-looking UIs almost always have more space than feels necessary when you stare at a single element.
- **Systems over judgment calls.** Pixel-by-pixel tweaking of arbitrary values is slow and produces inconsistency. A predefined, non-linear scale makes every sizing decision a fast multiple-choice question.
- **Content determines size, not the container.** Screens, grids, and proportional formulas are containers and abstractions. Elements should get exactly the space their content needs, fixed where it should be fixed, fluid only where fluidity is genuinely wanted.
- **Spacing carries meaning.** Relative distances between elements tell the user what belongs together. Ambiguous spacing forces the user to work to parse the interface, and interfaces that are hard to understand always look worse.

## Start with too much white space

**Principle:** Begin with far more white space than you think you need, then remove it until the design feels right — instead of adding space to a cramped design until it stops looking bad.

**Why it works:** The additive habit is a property of designing for the web: the starting state is cramped by default, so white space is almost always *added* — a bit of margin or padding wherever something looks too tight — until things merely look better. Adding space reactively stops at "not actively bad," the minimum breathing room. Subtracting from excess converges on "actually great." What feels like "a little too much" space on one isolated element usually turns out to be "just enough" in the context of a full UI.

**Guidance:**
- Default move when a design looks messy: give every element more room to breathe.
- Workflow: over-space first, then dial back. It is much easier to notice space that needs removing than space that needs adding.
- Dense UIs are legitimate — e.g., dashboards where a lot of information must be visible on one screen without scrolling. But density must be a deliberate decision, never the default you drifted into.

## Establish a spacing and sizing system

**Principle:** Never deliberate between values like 120px and 125px. Pick all spacing and sizing from a small, predefined scale.

**Why it works:** Arbitrary values slow you down and produce inconsistent designs. A constrained scale turns every decision into "try a value; if it's not enough, the next one up is probably perfect," and yields subtle visual consistency for free. The book ranks these benefits: workflow speed is probably the biggest one; the subtle consistency is a secondary bonus you notice afterward. The authors close the section by rating a spacing/sizing system as about as valuable as design advice gets — better designs, with less effort, in less time.

**Guidance — building the scale:**
- A linear rule like "everything is a multiple of 4px" fails: it still doesn't help you choose between near-identical values. The scale must be defined by the *relative* difference between adjacent steps.
- At the small end (icon sizes, button padding), a few pixels matter enormously: 12px → 16px is a 33% jump. At the large end (card widths, hero spacing), pixels are imperceptible: 500px → 520px is only 4% — eight times less significant than 12px → 16px.
- Rule of thumb: **no two adjacent values in the scale should be closer than about 25% apart.**
- Build the scale from a base value using factors and multiples. The reason is the same anti-arbitrariness principle that bans nitpicking individual element sizes: just as you shouldn't toil over 120px vs 125px for one element, you shouldn't build the scale itself out of hand-picked arbitrary values. Deriving every step as a factor or multiple of one sensible base is what makes the scale principled rather than a list of eyeballed numbers. **16px is an excellent base**: it divides cleanly and is the default font size in every major browser.
- The book's example scale (base 16): **4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 384, 512, 640, 768** (px) — i.e., 16 × 0.25, 0.5, 0.75, 1, 1.5, 2, 3, 4, 6, 8, 12, 16, 24, 32, 40, 48. Values sit close together at the small end and spread progressively further apart going up.

**Guidance — using the scale:**
- Sticking to the system is easiest when you type numbers (designing in the browser/code) rather than dragging with a mouse.
- Need space under an element? Pick a scale value and try it; if it's not quite enough, jump to the next step rather than nudging pixels.

## You don't have to fill the whole screen

**Principle:** Just because the canvas is 1200–1400px wide doesn't mean the interface should span it. If the content only needs 600px, use 600px. (Context: 960px was once the de facto desktop layout width; today even phones beat that resolution, so designers on high-resolution displays open tools with at least 1200–1400px of tempting space to fill.)

**Why it works:** Spreading content out, or making elements unnecessarily wide, makes an interface harder to interpret (related items drift apart). Extra empty space around the edges never hurts anything.

**Guidance:**
- Apply this to individual sections too: a full-width navigation bar doesn't obligate the content below it (e.g., a login card) to be full-width. Give each element just the space it needs; never make one element worse purely to match another.
- **Shrink the canvas:** if designing a small interface on a large canvas is hard, make the canvas small so the constraint is real. For responsive web apps, start on a **~400px canvas and design the mobile layout first**, then bring it to larger screens and fix only what felt like a compromise. You'll change less than you expect.
- **Think in columns:** when a component works best narrow but looks unbalanced inside a wide page, split it into columns instead of widening it — e.g., move a form section's heading and supporting text into a left column while inputs keep their optimal width on the right.
- **Don't force it:** the inverse mistake is cramming everything into a small area unnecessarily. If the design genuinely needs lots of space, take it — just never fill space out of obligation.

## Grids are overrated

**Principle:** Column grids (e.g., 12-column) are useful for simplifying layout decisions and can bring a satisfying sense of order to a design. But treating the grid like a religion — outsourcing *all* layout decisions to it — does more harm than good. Many elements should have fixed widths, not fluid percentage widths.

**Why it works:** A grid is fundamentally a constrained menu of fluid percentage widths (12-column → multiples of 8.33%, so 3 cols = 25%, 6 cols = 50%). Percentage widths make every element scale with the viewport, but in many situations an element is better served by a fixed, content-driven width than by a relative one.

**Guidance:**
- Sidebar layouts: a 25%/75% grid split fails at both extremes — on wide screens the sidebar bloats and steals space the content could use; on narrow screens it shrinks below its minimum usable width, causing wrapping and truncation. Instead, **give the sidebar a fixed width optimized for its content and let the main area flex** to fill the rest, using its own internal grid for its children.
- Same inside components: don't use percentage sizing unless you genuinely want the element to scale — e.g., a comment card's avatar should keep a fixed width whether the card is wide or narrow.
- **Don't shrink an element until you need to.** Sizing a login card as "6 of 12 columns" (then 8 columns at medium breakpoints to compensate) produces absurdities: because columns are fluid, there are viewport ranges where the card renders *wider on medium screens than on large ones*. If 500px is the card's optimal width, it should never be smaller while space exists.
- The fix: **give such elements a max-width and let them shrink only when the viewport is narrower than that max-width.** Don't be a slave to the grid; components keep the space they need until compromise is truly forced.

## Relative sizing doesn't scale

**Principle:** Don't assume size relationships (em ratios, proportional padding) hold across contexts. Resist the tempting intuition that if element A must shrink 25% on smaller screens, element B should shrink 25% too. Things that are large on big screens must shrink *faster* than things that are already small.

**Why it works:** Ratios that look right at one size are wrong at another. A 45px headline over 18px body (2.5em) is balanced on desktop; on mobile, with body reduced to 14px, 2.5em yields a 35px headline — far too big. A good mobile headline is **20–24px, only about 1.5–1.7× the body** — a different ratio entirely. Since the ratio itself changes, there's no stable relationship worth encoding; the gap between small and large elements should compress on small screens.

**Guidance:**
- Relative units like em aren't forbidden, but never trust a ratio defined at one screen size to stay correct at others. Set sizes per context.
- The same applies *within* a component. A button with 16px font and 12px/16px (vertical/horizontal) padding shouldn't scale padding proportionally with font size. The temptation is single-knob convenience: define padding relative to the font and every button size falls out of changing one font-size value. That does work mechanically, but the result just looks like zoom. Better: padding grows disproportionately generous at large sizes and disproportionately tight at small sizes:
  - Proportional (feels like zoom): 20px font → 15×20 padding; 16 → 12×16; 14 → 10.5×14; 12 → 9×12.
  - Independent tuning (large feels large, small feels small): 20px font → 15×30 padding; 16 → 12×16; 14 → 8×10; 12 → 6×8.
  - Note the pivot: the 16px size keeps 12×16 padding in both schemes. Tuning means diverging from the reference size — extra padding above it, less below it.
- Let go of proportional scaling everywhere; tuning each size independently is what makes multi-context design easy.

## Avoid ambiguous spacing

**Principle:** When grouping relies on spacing rather than explicit separators (borders, background changes), there must always be **more space around a group than within it**.

**Why it works:** Users infer relationships from proximity. If the gap between a label and its own input equals the gap to the previous field, nothing reads as connected — at best the user works harder to parse the form; at worst they type data into the wrong field. Interfaces that are hard to understand always look worse.

**Guidance with the book's values:**
- Stacked form fields: bad — 20px below each input and 20px below each label (uniform). Good — keep ~20px between groups but only **10px between a label and its input**, so each label visibly belongs to the field beneath it.
- Article section headings: bad — 24px above and 24px below the heading. Good — **36px above, 12px below**, attaching the heading to the section it introduces.
- Bulleted lists with wrapping items: bad — 24px between bullets when the line-height inside a bullet is also 24px, so items blur together. Good — keep 24px line spacing but **36px between items**.
- Horizontal layouts too: in a row of icon+count actions, 16px on both sides of a count is ambiguous. Good — **6px between an icon and its count, ~36px between action groups**.

## Quick-reference rules

- When a design looks messy, first try giving everything more white space.
- Start with way too much white space, then remove until it looks right; never add until it stops looking bad.
- Dense layouts are fine for data-heavy dashboards, but only as a deliberate choice.
- Pick all spacing/sizing values from a predefined scale; never tweak arbitrary pixels.
- Build the scale so adjacent values differ by at least ~25%; linear scales (all multiples of 4px) don't work.
- Use 16px as the base; example scale: 4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 384, 512, 640, 768.
- If a scale value isn't quite enough space, jump to the next value instead of nudging.
- Don't fill the screen; if content needs only 600px, use 600px and center it.
- A full-width section (like nav) doesn't obligate other sections to be full-width.
- Struggling with a small UI on a big canvas? Shrink the canvas; start responsive design at ~400px, mobile first.
- If a narrow component looks unbalanced on a wide page, split it into columns instead of widening it.
- Don't cram into small areas either; take the space you actually need.
- Give sidebars and similar chrome fixed widths; let the main content area flex.
- Inside components, avoid percentage widths unless you truly want the element to scale (e.g., fixed avatar sizes).
- Give elements like login cards a max-width; force them to shrink only when the screen is narrower than that max-width.
- Never let an element render smaller than its optimal size while free space exists.
- Don't encode size relationships as ratios (em); ratios that work on desktop break on mobile.
- Large elements shrink faster than small ones at small screen sizes; the size gap compresses.
- For headlines: ~2.5× body on desktop can become ~1.5–1.7× body (20–24px over 14px) on mobile.
- Scale button padding non-proportionally: extra generous at large sizes, extra tight at small sizes.
- Always put more space around a group than within it.
- Labels sit closer to their own input (e.g., 10px) than to the previous field (e.g., 20px).
- Headings sit closer to the text below them (e.g., 12px) than the text above (e.g., 36px).
- List item gaps must exceed the line-height inside a wrapped item (e.g., 36px gap vs 24px line spacing).
- Check horizontal spacing too: an icon belongs to its count (6px) not its neighbor group (36px).
