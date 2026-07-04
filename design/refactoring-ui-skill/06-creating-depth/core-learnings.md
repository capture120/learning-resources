# Creating Depth — Core Learnings

## Chapter overview

Screens are flat, but a UI doesn't have to feel flat. The chapter's core idea: you create depth by borrowing cues from how light behaves in the physical world, and you use that depth deliberately — to signal what's interactive, what's elevated above the page, and what's recessed into it. The driving intuition:

- The human visual system infers 3D shape from lighting. If you mimic where light and shadow would fall on a raised or sunken object, the brain reads the element as raised or sunken — no perspective tricks needed.
- One rule generates everything: **light comes from above.** Every highlight and shadow follows from asking "what would an overhead light do to this profile?"
- Depth is hierarchy on the z-axis. The closer an element feels to the user, the more attention it attracts, so shadow size should be a deliberate statement about importance, not decoration.
- Realism is a means, not the goal. Borrow just enough physical cues to communicate; chasing photo-realism produces busy, unclear interfaces.
- Light simulation isn't the only tool: color value (lighter = closer, darker = further) gives even flat designs depth, and overlapping elements creates layers in any design.

## Emulate a light source

**Principle:** Light comes from above. To make an element look raised or inset, decide the physical profile you want, then shade its edges the way an overhead light would.

**Why it works:** On a real raised panel (like door paneling), the top edge angles toward the sky and catches more light, while the bottom edge angles away and falls into shadow. On a real inset panel (like a cabinet door), it inverts: the lip above casts a shadow on the top inner edge, and the bottom edge angles upward and catches light. Brains decode these edge cues into 3D shape automatically, even in a flat image.

**Raised elements (e.g. buttons):**
1. With flat top and bottom edges, both can never be visible at once — the viewing angle picks one. Users look slightly downward at screens, so the natural choice is to reveal a sliver of the top edge and hide the bottom edge.
2. Lighten the top edge — make it *slightly* lighter than the face of the button. The anchor is the element's own surface color, and the step is subtle: a soft edge, not a bright line (overdo it and you get a cartoonish bevel). Implement with a top border or an inset box-shadow with a small positive vertical offset — e.g. `box-shadow: inset 0 1px 0 hsl(224, 84%, 74%)` on a blue button.
3. **Hand-pick the highlight color.** Don't use semi-transparent white — overlaying white sucks the saturation out of the underlying color. The PDF typesets "suck the saturation" as a link to the color chapter's "Don't let lightness kill your saturation" section (p. 152): in HSL, saturation reads weaker as lightness approaches 100%, so a white overlay — which pushes lightness up without touching saturation — washes the color out. Hand-picking lets you raise saturation as you raise lightness, the same compensation that section prescribes for light shades generally.
4. Add the cast shadow below — a raised element blocks some light from reaching the surface just beneath it: a small dark box-shadow with a slight vertical offset so it shows only below the element — e.g. `box-shadow: 0 1px 3px hsla(0, 0%, 0%, .2)`.
5. **Keep the blur radius tiny — a couple of pixels is plenty.** Small-scale real-world shadows (under a wall outlet or window frame) have sharp edges.

**Inset elements (wells, text inputs, checkboxes):**
1. Looking slightly downward, only the bottom inner lip of a recessed element is visible, and it faces the sky — so give it a *slightly* lighter color than the well's surface (the same subtle, surface-anchored step as the raised top edge) with a bottom border or an inset shadow with a negative vertical offset, e.g. `inset 0 -2px 0 hsla(0, 0%, 100%, .15)` (the figure's printed annotation omits the `inset` keyword; the prose's "inset shadow" and the rendered bottom-lip highlight imply it).
2. The surface above the well blocks light from its top inner edge — add a small dark inset shadow with a slight positive vertical offset, which keeps the shadow from poking through at the bottom of the well, e.g. `box-shadow: inset 0 2px 2px hsla(0, 0%, 0%, .1)`.
3. The same two-step treatment works on any element that should read as recessed: text inputs, checkboxes, sliders, upload wells.

**Restraint:** Once you can simulate light it's tempting to tweak endlessly toward realism. Don't — a few borrowed cues add depth; full skeuomorphism makes interfaces busy and unclear.

## Use shadows to convey elevation

**Principle:** Shadow size positions an element on a virtual z-axis. Small, tight-blur shadows read as slightly raised; large, soft shadows read as floating close to the user. Closer = more user focus.

**Match shadow to role:**
- **Buttons — small shadow:** noticeable without dominating the page. `box-shadow: 0 1px 3px hsla(0, 0%, 0%, .2)`.
- **Dropdowns, popovers — medium shadow:** they sit a step above the page. `box-shadow: 0 4px 6px hsla(0, 0%, 0%, .1)`.
- **Modal dialogs — large shadow:** they should grab full attention. `box-shadow: 0 15px 35px hsla(0, 0%, 0%, .2)`.

**Build an elevation system.** Like color, typography, spacing, and sizing scales, define a fixed set of shadows up front — it speeds up your workflow and keeps your designs consistent, and **five options is usually plenty**. Define the smallest and the largest, then fill the middle so sizes increase roughly linearly. The book's scale:

1. `0 1px 3px hsla(0, 0%, 0%, .2)`
2. `0 4px 6px hsla(0, 0%, 0%, .2)`
3. `0 5px 15px hsla(0, 0%, 0%, .2)`
4. `0 10px 24px hsla(0, 0%, 0%, .2)`
5. `0 15px 35px hsla(0, 0%, 0%, .2)`

Notice the construction pattern: all five steps use the identical color — 20% black — and only the geometry changes; offset and blur grow roughly linearly while opacity stays fixed. That's a recipe for building your own scale: hold the shadow color and alpha constant, scale the offset and blur.

The chapter's own worked examples all draw from this scale rather than inventing new values: the Publish button is step 1 exactly, the modal is step 5 exactly, and the dropdown uses step 2's geometry (`0 4px 6px`, at a lighter 10% black).

**Combine shadows with interaction.** Elevation changes are interaction feedback:
- Add a shadow to a list item the moment the user grabs it — it pops above its siblings and signals "you can drag this."
- On button press, shrink the shadow (e.g. `0 4px 6px` → `0 1px 3px`) or remove it entirely, so the button feels pressed into the page.
- Note that the press example is exactly a move from scale step 2 down to step 1 — interaction feedback is a transition between existing elevation steps, not a newly hand-tuned shadow. Implement press and drag states by re-assigning scale steps, and every shadow in the design stays on-system.

**Selection heuristic:** Don't think about the shadow itself. Decide where the element should sit on the z-axis, then assign the shadow from your scale that matches that elevation.

## Shadows can have two parts

**Principle:** The best shadows combine two box-shadows, each doing a distinct physical job.

- **Direct-light shadow:** larger and softer — considerable vertical offset, large blur radius. Simulates the shadow an overhead light casts behind the object (like the soft shadow a potted plant throws onto the table behind it).
- **Ambient-occlusion shadow:** tighter and darker — small vertical offset, small blur radius. Simulates the dark area directly underneath an object where even ambient light can't reach (the dark line under a pot sitting on a table).

The book's card example combines them as `box-shadow: 0 4px 6px hsla(0,0%,0%,.7), 0 5px 15px hsla(0,0%,0%,.1)`. Two quirks of the printed figure: the first alpha reads ".7" but the rendered shadow is subtle — treat it as ~.07–.1, in line with the tight-shadow alphas at similar elevations in the scale below — and the tight ambient shadow (`0 4px 6px`) is listed first even though the prose introduces the soft direct-light shadow first. The order of the two box-shadows is irrelevant; what matters is each one's job.

**Why two beats one:** independent control. You can keep the big cast shadow soft and subtle while the tight shadow keeps the element's edges crisp and defined.

**Account for elevation.** In the real world, the dark ambient shadow under an object fades as the object lifts off the surface — the book suggests verifying this yourself by lifting something off your desk. So in a two-part elevation scale, make the tight shadow quite distinct at the lowest elevation and almost (or completely) invisible at the highest. The book's two-part scale:

1. `0 1px 3px hsla(0,0%,0%,.12), 0 1px 2px hsla(0,0%,0%,.24)`
2. `0 3px 6px hsla(0,0%,0%,.15), 0 2px 4px hsla(0,0%,0%,.12)`
3. `0 10px 20px hsla(0,0%,0%,.15), 0 3px 6px hsla(0,0%,0%,.10)`
4. `0 15px 25px hsla(0,0%,0%,.15), 0 5px 10px hsla(0,0%,0%,.05)`
5. `0 20px 40px hsla(0,0%,0%,.2)` — the ambient shadow is gone entirely at the top elevation.

(The figure legibly prints the level-4 ambient alpha as `.5` — likely a typo for the `.05` shown above, since the book wants this shadow nearly or fully invisible at the top of the scale.)

## Even flat designs can have depth

**Principle:** "Flat design" as commonly meant bans shadows, gradients, and any other effect that mimics how light behaves in the real world — but it forbids the lighting effects, not depth itself. The best flat designs still convey depth through color and solid (zero-blur) shadows.

**Depth with color:** lighter objects feel closer; darker objects feel further away — especially among shades of the same color.
- Make an element **lighter than its background** to raise it off the page (a white card on a light grey page).
- Make it **darker than the background** to sink it in like a well (a grey strip on a lighter page, inputs darker than their card).
- This works in non-flat designs too — color value is always available as a depth channel.

**Solid shadows:** use a short, vertically offset shadow with **zero blur radius**, e.g. `box-shadow: 0 3px 0 hsl(220, 7%, 83%)`. The hard edge keeps the flat aesthetic while still lifting a card or button slightly off the page. (The book's example color is an opaque grey, not semi-transparent black.)

## Overlap elements to create layers

**Principle:** Overlapping elements is one of the most effective depth cues — it makes the design read as multiple stacked layers without any lighting effects.

**Tactics, with the book's values:**
- **Cross a background transition.** Instead of containing a card fully inside a section, offset it so it straddles the boundary between two backgrounds — e.g. pull a hero search card down over the next section with `margin-bottom: -60px`.
- **Exceed the parent's height.** Make a card taller than the banner it sits in so it overlaps above and below: `margin: -60px 0 -60px 0`.
- **Overlap small components too.** Carousel prev/next controls half-overlapping the card edges (`margin-left: -24px; margin-right: -24px`) add depth at a small scale.
- **Overlapping images need an invisible border.** Images overlapping other images (an avatar over a cover photo, stacked avatar rows) easily clash visually. Give each image a border that matches the background it sits on — e.g. `border: 4px solid #FFFFFF` — to force a gap. You keep the layered look without the clash.

## Quick-reference rules

- Assume one light source, above the UI; derive every highlight and shadow from it.
- Raised element: make the top edge slightly lighter than the element's own face (`inset 0 1px 0` highlight) and cast a small dark shadow below (`0 1px 3px` at ~20% black).
- Hand-pick edge-highlight colors; semi-transparent white desaturates.
- Keep cast shadows on small elements sharp — a couple pixels of blur max.
- Inset element: light bottom lip (`inset 0 -2px 0` white at ~15%) plus dark top inner shadow (`inset 0 2px 2px` black at ~10%).
- Treat inputs, checkboxes, and wells as inset; buttons and cards as raised.
- Bigger, softer shadow = higher elevation = more user attention; assign by z-axis intent, not aesthetics.
- Small shadow for buttons, medium for dropdowns, large for modals.
- Define a fixed shadow scale up front; five steps is usually plenty, increasing roughly linearly.
- Build the scale by holding shadow color and alpha constant (the book uses 20% black throughout) and scaling only offset and blur.
- Add a shadow on drag to signal "picked up"; shrink or remove it on press to signal "pushed in" — implemented as moves between existing scale steps, not new shadows.
- Prefer two-part shadows: a large soft direct-light shadow plus a tight dark ambient shadow.
- Fade the tight ambient shadow as elevation rises; drop it entirely at the top step.
- In flat designs: lighter = closer, darker = recessed; use color value as the depth channel.
- For flat-friendly elevation, use solid zero-blur shadows (e.g. `0 3px 0` grey).
- Overlap elements across background transitions or beyond parent edges (negative margins like -24px to -60px) to create layers.
- Give overlapping images an invisible border matching the background to prevent clashing.
- Don't chase photo-realism; a few light cues are enough.
