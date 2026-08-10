# Working with Color — Examples

Every figure from the chapter, paraphrased with enough context to stand alone.

## Ditch hex for HSL

**Donut chart in hex vs HSL.** A "Tasks" card shows a donut chart with three segments — Completed, Assigned, Due — in dark, medium, and light blue. Labeled in hex (#03369E, #507DD7, #9FB9ED), the three values look like unrelated strings even though the colors are obviously one family. The same chart labeled in HSL — hsl(220, 95%, 34%), hsl(220, 65%, 61%), hsl(220, 69%, 80%) — makes the relationship explicit: identical hue 220, differing mainly in lightness. Lesson: HSL keeps visually related colors related in code.

**Hue wheel.** A color wheel marked in 30° steps shows hue as an angle: 0° red, 120° green, 240° blue.

**Saturation strip.** Five swatches all at hue 210, lightness 50%, with saturation stepping 0% → 25% → 50% → 75% → 100%. The 0% swatch is pure grey; each step is visibly more vivid blue.

**Hue is meaningless at zero saturation.** Two pairs: hue 210 at 100% saturation (vivid blue) and hue 320 at 100% (vivid pink) each collapse to the identical grey when saturation drops to 0%, despite different hue values.

**Lightness strip.** Five swatches at hue 210, 100% saturation, lightness 0% → 25% → 50% → 75% → 100%: black, dark blue, pure blue, light blue, white. 50% is the pure hue.

**HSB vs HSL pickers.** Two picker panels have the same vivid blue selected, but the handle lands in different spots: the top-right corner in HSB (100% saturation, 100% brightness) versus the middle of the right edge in HSL (100% saturation, 50% lightness). The two models are not interchangeable.

## You need more colors than you think

**Five-swatch palette taken literally.** A palette-generator output of five hex colors (#173F5F, #20639B, #3CAEA3, #F6D55C, #ED553B). A chat application built strictly from these five — medium-blue sidebar, mustard-yellow message pane, red error banner, navy input bar (navy also marks the selected channel row) — looks garish and toy-like (marked bad). Lesson: generator palettes are seductive but unusable as-is.

**The same chat app done right.** The corrected version (marked good) uses a white message pane, a navy sidebar, and subtle tinted elements. Callout lines map roughly 17 distinct swatches in use: a green, several blues, teals, a red, five-plus greys, and a range of yellows for the warning banner. Lesson: a real screen consumes a comprehensive palette. A second figure-only lesson: in the bad version the five saturated colors fill large surfaces (a yellow message pane, a solid red banner with white text); in the good version large surfaces go white/grey and vivid color survives only in small accents and pale tints — the connection-error banner becomes dark text on a light yellow tint.

**Greys all over a settings form.** A profile/billing settings page annotated with five grey roles: darkest grey (form field labels), dark grey (secondary description text), grey (control borders), light grey (card background tint), lightest grey (page background). Even a plain form needs many grey levels, and the book notes three or four shades quickly proves too few — you want 8–10.

**A 10-step grey ramp.** Ten swatches from near-black to near-white in steady increments, starting from very dark grey rather than true black, which looks unnatural.

**Primary blue scale in a checkout flow.** A 7-shade blue ramp mapped onto a checkout progress bar: the mid/base blue colors the "Continue" button and the step dots (completed and active), the darkest shades serve text such as the tooltip label, and ultra-light blues tint the tooltip background. Demonstrates why a primary color needs 5–10 shades: dark for text, ultra-light for tinted backgrounds.

**Teal accent for a "NEW" badge.** A nav bar (Dashboard, Orders, Products, Discounts) uses a teal "NEW" pill next to Discounts, drawn from a 7-shade teal ramp. An eye-grabbing accent hue highlights a new feature.

**Red for destructive actions.** A "Deactivate account" confirmation dialog: red top border, red-tinted Deactivate button with dark red text, supported by a 7-shade red ramp.

**Yellow for warnings.** A warning banner ("You must be an administrator to access this page") with pale yellow background, darker yellow border and icon, dark yellow-brown text — drawn from a 7-shade yellow ramp.

**Green for positive trends.** A stock card (DOW J, +190.87) with a green sparkline and a light-green tinted gain badge, from a 7-shade green ramp. Together these show every semantic accent needs its own shade scale even when used sparingly. Figure-only pattern: the Deactivate button, warning banner, and gain badge all pair dark colored text with a pale tint of the same hue — the "flip the contrast" technique the accessibility section formalizes later.

## Define your shades up front

**A complete predefined palette.** A swatch sheet: one Primary row of 7 blues, one Neutral row of 7 greys, three Accent rows (teals, yellows, reds — 7 shades each). This fixed set replaces on-the-fly lighten()/darken(), which breeds dozens of near-duplicate blues.

**Picking the base via a button.** Three "GET STARTED" buttons in the same indigo hue: very dark (bad — heavy, near-black), medium (good — reads as a confident button color), very light (bad — washed out, weak text contrast). Rule of thumb: the base shade is the one that works as a button background; there is no universal lightness number.

**Picking the edges via an alert.** A notification banner ("Our privacy policy has changed") uses the darkest indigo for its heading text and the lightest indigo for its tinted panel background. One alert component exercises both extremes, making it an ideal test bed for choosing the darkest and lightest shades.

**Filling a 9-step scale.** Three stages shown: (1) only 900 (darkest), 500 (base), 100 (lightest) placed, gaps empty; (2) 700 and 300 chosen as the perceptual midpoint of each gap; (3) 800, 600, 400, 200 filled the same way, yielding a balanced 9-shade indigo ramp.

**Grey scale, same method.** A 9-step grey ramp (900–100) built edges-first: 900 chosen as the darkest text color, 100 as a subtle off-white background, gaps interpolated by eye.

## Don't let lightness kill your saturation

**Flat saturation looks washed out.** A saturation-vs-lightness chart with seven blue dots in a flat horizontal line (constant saturation across the lightness range): the lightest and darkest dots look drained of color compared to the mid ones.

**The U-curve fix.** The same chart with saturation increased toward both lightness extremes — high saturation at low lightness, dipping at 50%, rising again near 100%. All seven shades now read as equally colorful.

**Yellow vs blue at identical lightness.** Two swatches, hsl(60, 100%, 50%) yellow and hsl(240, 100%, 50%) blue. Everyone perceives the yellow as lighter, yet both have 50% HSL lightness — proof that each hue carries inherent perceived brightness. The formula sqrt(0.299r² + 0.587g² + 0.114b²)/255 quantifies it.

**Perceived brightness across the wheel.** A luminosity-vs-hue scatter of fully saturated, 50%-lightness samples: not a smooth curve but three valleys at red, green, blue and three peaks at yellow, cyan, magenta. Figure detail: the peaks and valleys are far from equal. Yellow is the global maximum and blue (240°) the global minimum; magenta's peak sits well below yellow's and cyan's, and the dip at green (120°) still reads brighter than magenta's peak. The minima and maxima are *local* — a hue is dark or bright relative to its neighbors on the wheel, not on an absolute ranking. So the rotate-toward-0°/120°/240°-to-darken rule works within a region of the wheel (green is not "a dark hue" overall), and the size of the brightness gain varies by region — the steep drop from yellow toward red is why yellow-to-orange darkening is so effective.

**The default lever: adjusting lightness.** Three swatches at hue 210, 100% saturation, lightness 25% / 50% / 75% show the usual way to lighten or darken a color. It works, but the color also drifts toward black or white instead of just reading darker or lighter.

**Lightening by lightness loses intensity.** A blue play-button app icon at hsl(210, 100%, 50%) lightened to hsl(210, 100%, 75%): lighter, but visibly closer to white — the color's punch is gone.

**Lightening by hue rotation keeps intensity.** The same icon instead rotated from hue 210 to 190 — a 20° rotation toward cyan, the nearest bright hue — at unchanged 100%/50%: lighter-feeling, still fully vivid.

**Darkening yellow by rotating toward orange.** A yellow icon at hsl(50, 100%, 50%) rotated to hsl(32, 100%, 50%) — an 18° rotation: darker-feeling without dropping lightness.

**Two yellow palettes compared.** A bad ramp darkens yellow by lightness alone — the dark end turns dull olive-brown. The good ramp rotates hue toward orange as lightness falls — dark shades stay warm and rich. Marked bad/good respectively.

**Combining both levers.** A testimonial card: dark navy background hsl(221, 49%, 33%) with a light cyan-blue attribution line ("— TINA LANNIN, 121 CAPTIONS") at hsl(194, 49%, 73%); the quote itself is near-white. The attribution gains brightness partly from higher lightness and partly from a 27° hue rotation toward cyan, right at the top of the safe budget. Caveat from the prose: this works best in small doses — keep rotations within 20–30° or the shade reads as a different color rather than a lighter/darker one.

## Greys don't have to be grey

**True grey strip.** Five swatches at 0% saturation (lightness 0–100%): by definition no color at all, and the hue value is irrelevant.

**"Greys" that are secretly saturated.** An invoice dashboard whose greys are annotated: heading text hsl(212, 56%, 16%), secondary text hsl(212, 18%, 35%), page background hsl(210, 32%, 93%), table-header background hsl(210, 38%, 97%). What reads as tasteful grey is blue-saturated throughout — up to 56% saturation on the darkest text.

**Neutral vs cool greys.** Two five-step ramps at matching lightness (28/43/58/76/88%): the neutral ramp at 0% saturation, the cool ramp at hue ~207–210 with saturation 15/12/12/16/21%. The cool ramp feels crisper and bluer.

**Warm greys.** The same lightness ramp at hue ~39–41 (yellow-orange), saturation 15/12/12/16/21%: the greys feel warm and tan. Note in both ramps the end shades carry more saturation than the middle — compensating for lightness diluting saturation, keeping temperature consistent across the scale.

## Accessible doesn't have to mean ugly

**Contrast grade tables.** Grey text samples on white graded against WCAG. Normal text: hsl(0,0%,54%) → 3.45:1 Fail; 42% → 5.41:1 AA; 33% → 7.57:1 AAA. Large text: 59% → 2.96:1 Fail; 54% → 3.45:1 AA; 42% → 5.41:1 AAA. Establishes the targets: 4.5:1 for text under ~18px, 3:1 for large text. Cross-table lesson: the tables deliberately reuse the same greys to show that the grade belongs to the color-size *pair*, not the color — 54% grey at 3.45:1 fails as normal text yet earns AA as large text, and 42% grey at 5.41:1 is AA for normal text but AAA for large. A mid-grey that is non-compliant in body copy can be perfectly legitimate in a large heading, so a favorite light grey can be kept by reserving it for large text instead of being discarded as inaccessible.

**Status badges, three ways.** A people table with Approved / Awaiting Approval / Declined status pills.
1. *Bad:* white text on mid-tone green/yellow/pink pills — contrast 2.25, 1.56, 3.14, all failing.
2. *Questionable:* backgrounds darkened until white text passes (5.97, 5.07, 5.34 AA) — accessible, but the dark saturated pills now dominate a page where status is secondary information.
3. *Good (flipped contrast):* dark green/yellow/red text on pale tinted pills of the same hue — 9.01, 9.78, 12.32, all AAA. Color still communicates status, but the badges recede to their proper place in the hierarchy.

**Secondary text in a dark purple panel.** A CTA card ("Here every step of the way") on background hsl(240, 34%, 34%).
- *Bad:* body text at hsl(240, 44%, 89%) — same hue lightened until it passes (8.37:1), but it lands so close to white that secondary text is indistinguishable from the white heading.
- *Good:* rotate the text hue toward cyan — hsl(188, 100%, 85%) — 8.71:1 AAA. Because cyan is an inherently bright hue, the text passes contrast while staying visibly colorful and clearly secondary to the white heading. Figure-only detail: this rotation is about 52°, well past the 20–30° shade-variant cap — fine here, since the text only needs to be colorful and legible, not to read as a shade of the background.
- *The mechanism, from the two figures' numbers:* the fix is more than a hue swap. Against the same-hue version, the rotated text jumps from 44% to 100% saturation and drops from 89% to 85% lightness — less light and far more colorful — yet its contrast ratio *rises* (8.71:1 vs 8.37:1). Landing on an inherently bright hue creates contrast headroom, which is then spent on fully re-saturating and slightly darkening the text. That simultaneous gain in color and contrast is why the result looks vivid instead of near-white; rotating the hue while keeping the original low saturation would still look washed out.

## Don't rely on color alone

**Metric cards under red-green color blindness.** Two revenue cards use a green badge (1.4%, good) and a red badge (11.1%, bad). Note the percentages carry no plus/minus sign, so color is the *only* channel encoding direction. Simulated red-green color blindness renders both badges the same olive tone — the user cannot tell improvement from decline. *Fix (good):* add an up arrow to the positive badge and a down arrow to the negative one; the direction now reads without color.

**Donut chart under blue-yellow color blindness.** A "Leads" donut uses blue, green, and orange segments with matching legend dots. Simulated blue-yellow color blindness collapses blue and green into the same teal, leaving segments ambiguous. Figure-only detail: the simulation does more than merge neighbors — the orange "Direct Mail" segment and its legend dot come back as *pink*. Hues are remapped unpredictably, not just blurred together, so you cannot reason about which distinct hues will stay distinguishable; even the one segment that survived as "different" changed identity entirely. *Fix (good):* recolor all segments as shades of a single blue — light, medium, dark. Under the same simulation the lightness differences survive intact, because colorblind users distinguish light-vs-dark far more reliably than hue-vs-hue. Closing rule: color should reinforce information the design already conveys, never be its only carrier.
