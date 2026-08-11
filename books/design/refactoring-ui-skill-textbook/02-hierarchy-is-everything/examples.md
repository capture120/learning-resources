# Hierarchy is Everything — Examples

Every figure from the chapter, paraphrased with enough context to stand alone.

## Not all elements are equal

### Investment dashboard, before/after
**Context.** A brokerage web app: top nav (Dashboard, Quote, Buy/Sell, Orders, Transfers, Watchlists), an "Overview" header with an as-of timestamp, three summary figures (Total Balance $16,412.92, Investments $15,606.14, Cash $806.78), tabs (Holdings, Activity, Performance, Gain & Loss), and a holdings table with columns for name, quantity, price, average cost, market value, gain/loss, percent of portfolio, and Buy/Sell buttons.

**Weak version.** Every piece of text sits at roughly the same size, weight, and color. The summary figures render as plain "label: value" lines in a thin-bordered box. Each table row carries a solid blue Buy button and a solid red Sell button. Nothing recedes, so the page reads as one undifferentiated wall.

**Change.** Same layout, fonts, and palette, but hierarchy added: the "Overview" page heading itself is demoted — large and dark in the weak version, small and light in the improved one, reading as a quiet page label rather than a headline (the "app titles act as labels" rule from the document-hierarchy section, already at work here); the three summary figures move into a solid blue panel with small uppercase labels and large white values (a change figure, +$648.83, shown small beneath) — and inside that panel the labels and change figures are de-emphasized with a lighter blue-tinted color in the panel's own hue, not grey or translucent white, quietly applying the chapter's later colored-background rule; the as-of timestamp leaves the "Overview" heading and shrinks into the far right corner; the active nav item gets bolded while the active tab sits in a small filled pill; table headers become small uppercase grey; the weak version's crammed one-line fund names ("TDB900 - TD CDN INDX -E...") split into two tiers, dark ticker over a small grey description; the separate Gain/Loss% column disappears, its percentage demoted to a small green line stacked under the dollar gain; Buy/Sell become quiet outlined/ghost buttons.

**Lesson.** De-emphasizing secondary and tertiary information, while highlighting the few numbers users actually came for, makes the design immediately more pleasing without touching color scheme, font choice, or layout. Two reusable figure-only micro-moves: split a crammed equal-emphasis line into a primary/secondary stack, and merge related columns by demoting one value to a small line under the other.

## Size isn't everything

### Tour booking card, size-only hierarchy
**Context.** A card for an "Amsterdam Walking Tour": photo, title, one-line description, "$17 per person" price, star rating with "28 reviews", fine print ("Prices may vary depending on selected date"), and a Book now button.

**Weak version.** Hierarchy attempted purely with font size, all at weight 400: title 30px, description 16px, price 24px, fine print 14px. The title balloons, the fine print squints, and importance still reads muddily.

**Change 1 — weight instead of size.** Title becomes 24px at weight 700; price becomes 18px at weight 700. Both shrink yet communicate importance better.

**Change 2 — color instead of tiny sizes.** Supporting text takes softer colors and gets *bigger*, not just recolored: the grey secondary tier sits at 18px in hsl(201, 23%, 34%) (up from 16px in the size-only version), and the light-grey fine print at 16px in hsl(203, 15%, 47%) (up from 14px). Once color carries the de-emphasis, sizes can climb back into a comfortable range — the concrete meaning of "sacrifices less on readability". Across both changes the card's type-size spread compresses from 14–30px down to 16–24px.

**Final version.** A small system: bold (700) dark title in hsl(202, 57%, 15%); normal-weight (400) body; grey hsl(201, 23%, 34%) secondary text; light grey hsl(203, 15%, 47%) tertiary text. Two weights, three colors, sizes all within a readable band.

**Lesson.** Weight and color carry hierarchy better than size extremes; constrain yourself to 2 weights and 2–3 text colors.

## Don't use grey text on colored backgrounds

### Testimonial card, all on one teal footer
**Context.** A quote card: testimonial text on white, then a teal footer band with an avatar, the person's name ("TINA VANSTONE"), and their company ("21 INDUSTRIES") as de-emphasized text.

**Weak version.** The company name uses literal grey, hsl(0, 0%, 78%) — the same trick that works on white. On teal it looks muddy and wrong, because grey isn't "low contrast" against teal.

**Explanatory figure.** The footer reappears with the teal stripped out to a near-white band, plus a white-to-black gradient bar: there the grey text de-emphasizes correctly, because grey sits close to white. What creates hierarchy is moving the text color toward the *background* color — grey approaches white, never teal.

**Second weak attempt.** White text at 60% opacity, hsla(0, 0%, 100%, 0.6). Contrast does drop, but the text looks dull, washed out, even disabled. A zoomed figure shows the worse failure: over the teal's wave pattern, the pattern shows through the translucent letterforms.

**Change.** Hand-pick the color: keep the background's hue, adjust saturation and lightness — hsl(183, 70%, 84%) on the teal. The company name now reads clearly secondary without looking faded.

**Lesson.** On colored backgrounds, de-emphasize by picking a same-hue, lighter, appropriately saturated color, never grey or translucent white.

## Emphasize by de-emphasizing

### Active nav item that won't pop
**Context.** A store admin's top navigation: Dashboard, Orders, Products, Discounts, with Orders active.

**Weak version.** Orders gets an accent color (purple/blue) but all items share the same dark bold styling, so the active item still doesn't stand out.

**Change.** Instead of decorating Orders further, the inactive items take a softer grey so they recede into the background. Orders, unchanged, now clearly dominates.

**Lesson.** When you can't add more emphasis, subtract it from the competition.

### Sidebar competing with main content
**Context.** A flight-booking wizard: a "Step 1 of 5" progress sidebar (Your Itinerary, Cabin Selection, Passenger Details, Order Confirmation, Completion) beside the main "Your Itinerary" form.

**Weak version.** The sidebar sits in its own white card, visually equal to the form card, so the two panels compete.

**Change.** The sidebar loses its background and sits directly on the page background. The form, the only carded element, becomes the obvious focus.

**Lesson.** The de-emphasis principle scales from text up to whole layout regions: strip backgrounds/containers from supporting panels.

## Labels are a last resort

### Employee contact card
**Context.** A directory card with photo plus four data points: name, job title, email, phone.

**Weak version.** Rendered as "Name: Erin Lindford / Job Title: Customer Support / Email: erinlindford@example.com / Phone: (555) 765-4321". Every datum gets identical emphasis; the card looks like a raw database row.

**Change.** Labels deleted entirely. The name becomes the large dark headline; the job title takes an accent color (purple); email and phone become quiet grey lines. Format and context identify everything: the email looks like an email, the phone like a phone, and a role under a name in a directory is obviously the department.

**Lesson.** Without labels you can finally style each datum by importance, and the card looks designed.

### Inventory count on a product card
**Context.** An e-commerce card: "Maple Planter, USD $29", plus stock information.

**Weak version.** "In stock: 12" — a label:value pair.

**Change.** "12 left in stock", with the number bolded. The label content merged into a natural phrase around the value.

**Lesson.** When a bare value would be ambiguous, fold the label words into the value instead of prefixing a label.

### Real estate listing card
**Context.** A property card: photo, "DETACHED HOUSE · 3,426 SQFT", price $1,250,000, address, agent, and bedroom/bathroom counts.

**Weak version.** "Bedrooms: 3" and "Bathrooms: 2" with the label words bold and the values regular — the emphasis sits on the labels, not the data.

**Change.** "3 Bedrooms" and "2 Bathrooms" with small icons (bed, bath) and the numbers bolded.

**Lesson.** Combined label-value units plus icons keep clarity while letting the data carry the emphasis.

### Heart-rate dashboard tile (labels are secondary)
**Context.** A fitness dashboard card showing a heart-rate metric with a sparkline; on dashboards with many similar metrics, labels are genuinely needed for scanning.

**Weak version.** "Heart rate" in bold dark text with "82 BPM" small beneath it — the label outranks the data.

**Change.** Label becomes small uppercase grey "HEART RATE"; the value "82" becomes large and bold; the unit "BPM" stays small beside it.

**Lesson.** Keep the label, but demote it via smaller size, lower contrast, and/or lighter weight; the measurement is the content.

### Phone spec sheet (when to emphasize the label)
**Context.** A technical specifications page: "Dimensions — Height: 2.31 inches (58.6 mm), Width: 4.87 inches (123.8 mm), Depth: 0.30 inch (7.6 mm); Power and Battery — Talk time: ...".

**Treatment shown.** Section names and labels ("Height:", "Width:", "Depth:") are bold and dark; values sit in slightly lighter text.

**Lesson.** When users scan for the label word ("depth", not "7.6mm"), emphasize the label — but only lighten the value slightly, since the data still matters.

## Separate visual hierarchy from document hierarchy

### "Manage Account" page title
**Context.** A settings page: h1 title "Manage Account", tabs (Account, Applications, Billing, Password, Notifications), then a Profile form section.

**Weak version.** Trained to expect h1s to be big, the designer styles the title at 24px, where it visually outranks the actual settings content, which is what the user came for.

**Change.** Same h1 element, styled down to 16px. The title now reads as a quiet page label and the form takes focus.

**Lesson.** Section titles in apps act like labels, not headlines. Choose the element for semantics, the size for hierarchy — even hide titles visually (keeping them in markup for accessibility) when the content speaks for itself.

## Balance weight and contrast

### Surface-area illustration
**Context.** Two letter "A" glyphs at the same point size, one bold, one regular, with their inked area annotated: roughly 90px² bold vs 50px² regular.

**Lesson.** Bold feels emphasized purely because it covers more surface area. This surface-area/hierarchy link extends beyond text to other UI elements, which sets up the two compensation tricks below.

### Music app sidebar icons
**Context.** A streaming app: left sidebar nav ("BROWSE: Charts, Genres, New Releases, Recommended; YOUR LIBRARY: Recently Played"), each item with a solid icon; main pane shows a playlist ("Vibes").

**Weak version.** Icons share the text's dark color, hsl(212, 20%, 13%). Being solid shapes, they cover far more area than the text and dominate the sidebar.

**Change.** Icon color softens to hsl(212, 20%, 68%) while the labels keep hsl(212, 20%, 13%). Icons and text now feel balanced.

**Lesson.** You can't reduce an icon's weight, so reduce its contrast — lower contrast counterbalances heavy weight.

### Feed divider borders
**Context.** A social feed of employee posts separated by horizontal borders.

**Weak versions.** Two failed 1px attempts: a dark border, 1px solid hsl(206, 16%, 74%), feels harsh and noisy; a light border, 1px solid hsl(210, 23%, 95%), is too subtle to register.

**Change.** Keep the light color but double the thickness: 2px solid hsl(210, 23%, 95%). The divider is now visible yet soft.

**Lesson.** The inverse compensation: add weight (thickness) to emphasize a low-contrast element instead of darkening it.

## Semantics are secondary

### Marketplace listing actions
**Context.** A seller's listing card: "Beige Wooden Bar Stool, $40, Greater Toronto Area", description, and three actions — Delete Listing, Edit, Publish.

**Weak version.** All three styled purely by semantics as solid buttons: red Delete Listing, blue Edit, green Publish. Three loud buttons, no guidance on which matters.

**Change.** Hierarchy-first styling: Publish (the primary action) becomes the lone solid dark button; Edit becomes a soft low-contrast secondary button; Delete Listing becomes a link-style tertiary action set off to the left.

**Lesson.** Rank actions first (one primary, some secondary, some tertiary), then style by rank; semantic color is a secondary concern.

### Primary/secondary/tertiary button matrix
**Context.** A figure showing one button ("Save Draft" / "Sign up" / "Learn More") across three backgrounds (white, dark, purple gradient) in three treatments.

**Treatments.** Primary: solid high-contrast fill (solid blue; solid green on dark; solid white on purple). Secondary: outline or low-contrast fill (blue outline; white outline on dark; translucent white on purple). Tertiary: link-like plain text in each context.

**Lesson.** A consistent three-tier action vocabulary works on any background. A figure-only detail: the primary fill is whatever contrasts most with the backdrop — blue on white, bright green on dark, solid *white* on the purple gradient, where the button inverts to white with colored text.

### Destructive "Unpublish" and the confirmation modal
**Context.** A destructive action, Unpublish, shown in three treatments, then a "Deactivate account" confirmation dialog.

**Weak instinct.** Making every destructive button big, red, solid, and bold regardless of importance.

**Change.** Unpublish styled by its place in hierarchy: solid red only if it's the page's primary action; otherwise a secondary button with red label text (white fill, light grey border) or quiet link-style text (tertiary). The big solid red treatment moves to the confirmation modal, where "Deactivate" genuinely is the primary action, paired with a quiet Cancel button.

**Lesson.** Destructive severity doesn't override hierarchy; reserve maximal red emphasis for the step where the destructive choice is the primary action.
