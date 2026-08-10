# Working with Images — Examples

## Use good photos

### Apartment listing card: amateur vs. professional photo
A vacation-rental card ("Modern Studio in Central San Francisco", $120 USD per night, 5-star rating) shown twice with identical layout, typography, and content. The weak version uses a dim, flat amateur snapshot of a bed taken from a doorway: poor lighting, dull gray walls, cluttered framing. The good version swaps in a professionally shot photo of a staged bedroom — bright, well-composed, with coordinated colors and wall art. Nothing else changes, yet the first card feels like a sketchy listing and the second feels premium. Lesson: photo quality alone determines whether the same UI reads as polished or cheap.

## Text needs consistent contrast

All examples in this section use the same hero: a "Roommate" landing page with the headline "Meeting Room Scheduling Made Easy", a subtitle, and a "Book a Demo" button, set over a photo of three people meeting at a table near a bright window.

### The failure case: raw photo behind text
White headline text sits directly on the unedited photo. The photo has very bright zones (the window, light walls, white laptops) and dark zones (a dark green wall, shadows). The white headline is legible over the dark wall but disappears over the bright window; the white subtitle is nearly invisible. Two cropped callouts demonstrate both failure modes: a "Too light" crop where the white text vanishes against a bright region, and a "Too dark" crop with the headline and subtitle switched to dark text, which vanishes against the dark green wall. Lesson: no single text color can survive an image that spans the full lightness range; the image's dynamics are the problem.

### Fix 1: semi-transparent overlay
The same hero with a black overlay at 55% opacity (`background-color: hsla(0, 0%, 0%, .55)`) between photo and text. The bright window and walls are toned down enough that white headline, subtitle, and button all read clearly everywhere. Trade-off noted: the whole image darkens, not just the problem spots. The inverse works too: a white overlay brightens dark areas to support dark text.

### Fix 2: lower the image contrast
Instead of an overlay, the photo itself is edited: contrast −70%, brightness +40%. The image becomes a pale, washed-out backdrop, and the text switches to dark gray, which now reads cleanly across the whole image. The brightness boost is required because dropping contrast alone changes how light or dark the image feels overall.

### Fix 3: colorize the image
The photo is converted to a single-color duotone-style treatment: contrast lowered, image desaturated, then a solid fill of #035581 (deep blue) applied with the "multiply" blend mode. The result is a uniformly dark blue image where white text pops everywhere. Side benefit: the image now harmonizes with the product's brand blue instead of fighting it.

### Fix 4: text shadow as a glow
To keep more of the photo's natural dynamics, the image is only mildly adjusted and the white text gets `text-shadow: 0 0 50px hsla(0, 0%, 0%, .4)` — zero offset, large blur, 40% black. The shadow reads as a soft glow that locally darkens whatever sits behind each letter, so contrast is added exactly where needed. The book advises still reducing image contrast somewhat; the shadow just means you can reduce it less.

## Everything has an intended size

### "Playback" logo: bitmap scaled up
A small play-button logo with the wordmark "Playback" shown at its native size, then enlarged. The enlarged copy is visibly fuzzy and soft-edged. Baseline demonstration that raster images displayed above their original size immediately go fuzzy and lose their definition.

### Feature row with scaled-up SVG icons
A landing-page features strip (investing app: "Automatic rebalancing", "Dividend reinvesting", "Advice from experts") uses standard small (16–24px-style) SVG icons blown up to fill large slots. Marked with a "?" rather than an outright X: technically sharp because they're vectors, but they look crude. A three-way comparison of a megaphone icon makes the point: at its intended 24px it looks right; the same art scaled to 48px looks chunky and detail-starved (X); a different icon actually drawn for 48px, with more internal detail, looks professional at 48px (check).

### Small icon in a colored shape
For teams that only have small icons: side-by-side 48px treatments of the megaphone. The scaled-up-to-48px version fails. The winning version keeps the icon near its intended size and centers it inside a 48px light-blue circle. The shape fills the layout slot while the icon stays at a size where its proportions work. The figure labels the winner "Larger but not scaled (48px)" — the element grows, the icon art doesn't. The features strip is then re-shown with each icon inside a soft tinted circle (green, purple, yellow) — the row now looks balanced and intentional. A figure-only detail: each icon sits in a pale circle of a coordinated (same or adjacent) hue — dark green icon in a pale green circle, purple in lavender, red-orange in pale yellow — so every icon-and-circle pair reads as one coherent element rather than an icon dropped on a random swatch.

### "Take control of your day" screenshot, scaled down
A marketing section pairs copy and checklist with a screenshot of a to-do app. The weak version shrinks a full-desktop screenshot by about 70% to fit the column: every label distorts, the app's 16px text becomes roughly 4px, and the figure annotation reads "details are distorted and hard to read." Three good alternatives follow:
1. **Smaller-device screenshot:** capture the app at a tablet-sized layout and give the image a roomy slot in the design, so it needs far less shrinking; text stays legible.
2. **Partial screenshot:** crop to just the task-list region (shown in a circular zoom detail) and display it near actual size — less space, no downscaling.
3. **Simplified illustration:** redraw the whole app as a stylized mock with detail removed and small text replaced by plain gray lines. It conveys the overall design without tempting viewers to read text that wouldn't be legible anyway. The figure is not a generic gray wireframe: it keeps the app's real layout and brand color accents — the dark top nav bar, the green/teal circular checkmarks, a solid blue primary button, and the row dividers all survive — while only the text is replaced by gray bars of varying width. The lesson is how much to keep when simplifying: enough structure and color that the illustration still reads as the actual product, not an anonymous mockup.

### Favicon: logo shrunk vs. redrawn
An app icon — a multi-petaled asterisk/flower mark on a blue rounded square, drawn at 128px — is shrunk to favicon size (16px). The browser's downscaling turns the fine petals into a blurry blob. The fix: redraw a simplified version of the mark at the target size — the same petals drawn thicker and rounder, filling more of the square, with fine detail removed — so the designer chooses which details to drop instead of the resampler. The simplified icon stays crisp and recognizable at 16px. A figure-only detail: the redrawn mark is also shown at full size next to the original, where it looks noticeably bolder and cruder. That trade-off is intentional — the redraw is designed for a 16px display size, so the chapter's intended-size rule applies to the redrawn asset itself: it is the right choice at 16px and would be the wrong choice at 128px. Don't hesitate to ship a simplified mark that looks worse at full size, because full size is not where it will live.

## Beware user-uploaded content

### Recipe grid with intrinsic aspect ratios
A burger-recipe browsing grid where each card shows a user-uploaded photo at its natural aspect ratio. Tall portraits, wide landscapes, and squares produce cards of wildly different heights; rows misalign and the page structure falls apart. The fixed version centers every photo inside an identical fixed-size container and crops the overflow — the grid becomes uniform and tidy. Implementation callout: set the photo as a background image with `background-size: cover` (a single card is shown with the crop visualized: the wide original photo extends past the container edges, and only the centered region displays).

### Chat avatars bleeding into the background
A messaging UI with circular user avatars on a white background. Avatars whose photos have light backgrounds visually merge with the page — the circle's edge vanishes and the avatar loses its shape (annotated "Poor Contrast"). The failure figure shows this in two chat surfaces at once: a conversation list with large circular avatars on the left, and a message thread with small inline avatars on the right, with annotation lines pointing to bleeding avatars in both. The bleed is not specific to one avatar size or layout — it recurs anywhere a light photo meets a light UI background. Two candidate fixes compared on the same avatars:
- **Solid border (rejected):** `border: 2px solid hsl(212, 12%, 72%)` draws a visible gray ring that clashes with the colors inside the photos and draws attention to itself.
- **Subtle inner shadow (accepted):** `box-shadow: inset 0 0 0 1px hsla(0, 0%, 0%, .1)` — a 1px ring of 10% black inside the circle. It defines the edge against any photo, but viewers barely register it as an element. The book notes a semi-transparent inner border achieves the same result if the slight inset look bothers you.

A figure-only lesson in the comparison: both treatments are applied uniformly to every avatar, including ones that never had a bleed problem — Rose Peterson's dark warm-red photo holds its shape against white on its own, yet the 2px gray border visibly clashes on it anyway, while the inset shadow is imperceptible there. This is why the shadow wins as a blanket default: applied globally, it costs nothing on avatars that don't need it, whereas a border harms every avatar it touches. You can apply the shadow to all avatars unconditionally instead of detecting which uploads bleed.
