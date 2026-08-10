# Creating Depth — Examples

Every figure from the chapter, paraphrased with enough context to stand alone.

## Emulate a light source

**Raised vs inset in one screen.** A real-estate search app with a dark sidebar of filters next to white property cards. Callout lines mark the price-range slider track and the Features checkbox group as appearing *inset* into the dark panel, and the lighter "Residential" select dropdown as appearing *raised*. Look at the color values: the inset controls are *darker* than the dark sidebar they sit in, while the raised select is *lighter* than it — the lighter-equals-raised / darker-equals-inset cue from "Creating depth with color" later in the chapter is already at work here, cooperating with edge lighting in the same components. The figure motivates the section: both effects come from one rule about light.

**Blue door panels (photo).** A flat photograph of a paneled door still obviously shows raised panels. The diagram beside it explains why: with the light source above, the top edge of a raised panel angles toward the light and is lighter, while the bottom edge angles away and is darker. The only physical shape consistent with those edge colors is a raised panel, so that's what the brain perceives.

**Grey cabinet panels (photo).** The inverse case: cabinet doors with recessed panels. A shadow sits along the top inner edge (the lip above blocks the light) and the bottom edge is lighter (it angles up toward the light). Same overhead light, opposite edge pattern, and the brain reads "inset."

**Raised button, step 1 — top highlight.** A flat blue "Create Account" button on a grey panel, with a profile diagram showing the target shape: a slab raised off the page with flat top and bottom edges. Flat top and bottom edges can never both be visible at once; since users look slightly downward at screens, the natural pick is to show the top edge and hide the bottom. The after version adds `box-shadow: inset 0 1px 0 hsl(224, 84%, 74%)` — a one-pixel lighter blue line across the top — and the button starts to look dimensional. The book stresses choosing that lighter color by hand: overlaying semi-transparent white would wash the saturation out of the blue.

**Raised button, step 2 — cast shadow.** The same button then gets a small dark shadow underneath: `box-shadow: 0 1px 3px hsla(0, 0%, 0%, .2)`. The vertical offset keeps the shadow below the element only, matching a raised object blocking light from the surface beneath it. The book warns against big blur radii here — real small-scale shadows (under a wall outlet or a window frame) are sharp, so a couple of pixels of blur is plenty.

**Inset "well", step 1 — bottom lip.** A drag-and-drop file-upload well in a dark UI, with a profile diagram of a recessed slab. Looking slightly downward, only the bottom inner lip would be visible, and it faces the sky, so it gets a slightly lighter edge: an inset shadow with a negative vertical offset (shown as `box-shadow: 0 -2px 0 hsla(0, 0%, 100%, .15)`), or equivalently a lighter bottom border.

**Inset "well", step 2 — top inner shadow.** The surface above the well blocks light from reaching its top, so the well gets a small dark inset shadow with a slight downward offset and a little blur — `box-shadow: inset 0 2px 2px hsla(0, 0%, 0%, 0.1)` — the downward offset keeps the shadow from poking through at the bottom of the well. Combined with step 1, the well now reads as genuinely recessed.

**Newsletter form.** A dark "Join our newsletter" signup with an email text input and a promotional-emails checkbox. The before version is flat; the after applies the same well treatment to the input and the checkbox, and both now read as cut into the surface. Lesson: the inset recipe generalizes to any control that should feel recessed.

**Don't get carried away (prose).** Once you can simulate light it's tempting to keep tweaking toward realism. The book's caution: borrowing a few real-world cues adds useful depth, but photo-realistic interfaces become busy and unclear.

## Use shadows to convey elevation

**Front view vs profile view.** Two white cards on a grey page: one with a tight small shadow, one with a large soft shadow. A profile diagram plots them on a z-index axis — the tight-shadow card sits just above the page, the soft-shadow card floats well above it. The closer an element feels to the user, the more it attracts focus.

**Publish button.** A toolbar with "Preview" and a blue "Publish" button. The bad version leaves Publish with no shadow at all, so it sits flat on the page. The good version adds a small shadow, `box-shadow: 0 1px 3px hsla(0, 0%, 0%, .2)` — enough for users to notice the button without letting a mere button dominate the page.

**Account dropdown.** A user menu (profile, status, preferences, sign out) opened from an avatar. The bad version has a barely-there shadow, so the floating menu looks painted onto the page. The good version uses a medium shadow, `box-shadow: 0 4px 6px hsla(0, 0%, 0%, .1)`, appropriate for an element that sits a step above the rest of the UI.

**Password-protected modal.** A modal dialog ("The page is password protected") over a settings form. With a small shadow it doesn't separate from the page behind it. With a large shadow — `box-shadow: 0 15px 35px hsla(0, 0%, 0%, .2)` — it clearly floats above everything and captures attention, which is exactly what a modal should do.

**Five-shadow elevation scale.** Five white squares on grey, smallest to largest elevation, annotated:
`0 1px 3px hsla(0,0%,0%,.2)` → `0 4px 6px hsla(0,0%,0%,.2)` → `0 5px 15px hsla(0,0%,0%,.2)` → `0 10px 24px hsla(0,0%,0%,.2)` → `0 15px 35px hsla(0,0%,0%,.2)`.
Method: define the smallest and largest, fill the middle so steps grow about linearly. Five options is usually plenty for a whole product.

**Drag-to-sort list.** A music playlist table (title, artist, date added) where one row is being dragged. The grabbed row ("Blush" by Leon Vynehall) gets a shadow and visually pops above its neighbors — instant feedback that it's been picked up and can be dragged. Detail worth copying: the grabbed row also shows a grip handle (a vertical-dots icon) to the left of its plus icon that the resting rows lack, so the elevation shadow is paired with an explicit drag affordance rather than carrying the signal alone.

**Subscribe button press.** A "Subscribe" button at rest has `box-shadow: 0 4px 6px hsla(0,0%,0%,.2)`; on click it switches to `box-shadow: 0 1px 3px hsla(0,0%,0%,.2)`. The shrinking shadow makes the button feel physically pressed into the page. The takeaway heuristic: pick shadows by deciding where the element sits on the z-axis, not by styling taste.

## Shadows can have two parts

**Agile Mornings event card.** A white calendar-event card whose polished shadow turns out to be two box-shadows combined (annotated `box-shadow: 0 4px 6px hsla(0,0%,.7), 0 5px 15px hsla(0,0%,.1)` in the figure — the rendered shadow is subtle, so read the first alpha as roughly .07–.1 rather than a literal 70%; the code also lists the tight ambient shadow first while the prose describes the soft direct-light shadow first — the order of the two doesn't matter). Each shadow has a specific job rather than being random experimentation.

**Plant photos analogy.** A "ChitChat" notification card paired with photos of a potted plant on a table. The first photo highlights the large soft shadow the plant casts onto the table behind it — that's the *direct light* shadow: big vertical offset, large blur. The second highlights the thin dark line right under the pot where even ambient light can't reach — the *ambient* shadow: small offset, tight blur, darker.

**Direct, ambient, combined.** Three versions of the notification card: with only the direct-light shadow (soft, floaty, edges undefined), only the ambient shadow (crisp edge, no sense of height), and both combined. Two shadows give independent control: the big one stays subtle while the tight one keeps the card's edges defined.

**Two-part elevation scale.** Five squares again, now with paired shadows, and the ambient part fading as elevation rises (just as the dark line under a real object disappears when you lift it):
1. `0 1px 3px hsla(0,0%,0%,.12)` + `0 1px 2px hsla(0,0%,0%,.24)`
2. `0 3px 6px hsla(0,0%,0%,.15)` + `0 2px 4px hsla(0,0%,0%,.12)`
3. `0 10px 20px hsla(0,0%,0%,.15)` + `0 3px 6px hsla(0,0%,0%,.10)`
4. `0 15px 25px hsla(0,0%,0%,.15)` + `0 5px 10px hsla(0,0%,0%,.5)` — the `.5` is as printed in the figure, almost certainly a typo for `.05`, since the rule below wants the ambient shadow nearly invisible this close to the top
5. `0 20px 40px hsla(0,0%,0%,.2)` — ambient gone entirely.
Rule: the ambient shadow should be quite distinct at the lowest elevation and almost or completely invisible at the highest.

## Even flat designs can have depth

**KiteTail social feed.** A flat-styled social app: white cards on a light grey background, no shadows or gradients anywhere. It still reads as layered — the white cards lift off the grey page and the grey search pill sinks into the white header purely through color. The most effective flat designs convey depth through other means, which the next figures show.

**Login card — depth from color.** A login screen on a grey page. The white "Log in to your account" card is lighter than the background, so it feels raised. The username/password inputs are slightly darker panels inside the card, reading as inset. Below the card, a "Don't have an account? Get Started" strip is darker grey than the page, so it feels recessed and secondary. Callouts state the rule directly: lighter = closer element, darker = further away. The book adds that this applies to non-flat designs too — color value is always a depth tool.

**Shopping cart — solid shadows.** A cart list (chair, night stand, lamp as white line-item cards) where each card has a short, hard-edged shadow with zero blur: `box-shadow: 0 3px 0 hsl(220, 7%, 83%)`. A magnified inset shows the crisp solid edge. The cards lift off the page without violating the flat aesthetic.

## Overlap elements to create layers

**Travel-site hero.** A flight-search hero ("Where do you want to go?") with a white search card. The bad version contains the card entirely within the blue hero image, so hero and content read as two separate flat bands. The good version pulls the card down with `margin-bottom: -60px` so it straddles the boundary between the hero and the white content section — the card now reads as a layer floating above both.

**License-renewal banner.** A dark "Special offer for existing customers" banner with a white "Renew your license" card on its right. The card is taller than the banner (`margin: -60px 0 -60px 0`), poking out above and below it, which makes the composition feel like stacked layers rather than boxes in boxes.

**Testimonial carousel.** A quote card with circular previous/next arrow buttons. The buttons hang halfway off the card's left and right edges (`margin-left: -24px; margin-right: -24px`), showing the overlap trick works at small component scale too.

**Profile cards — invisible borders.** A profile card where a circular avatar overlaps the bottom edge of a landscape cover photo, with a row of seven follower avatars below. The bad figure shows two distinct failing variants, not one: in the left card the follower avatars sit flush side by side and clash where they touch; in the right card they overlap each other with no borders and clash worse. The fix: give each image an "invisible border" matching the background it sits on — `border: 4px solid #FFFFFF` — so a gap always separates overlapping images. Note that the good version keeps the follower avatars *overlapping* in a stack; the white borders insert the gaps. The invisible border is what makes the overlapping avatar-stack (facepile) pattern viable at all — the point is to keep the layered stack, not avoid it. The layered effect remains, the clashing disappears.
