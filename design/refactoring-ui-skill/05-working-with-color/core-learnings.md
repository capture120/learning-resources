# Working with Color — Core Learnings

## Chapter overview

Color in UI work is a system, not a vibe. The chapter's core idea: treat color as structured data you design up front — a fixed palette of hues and shades expressed in a color model (HSL) that matches human perception — rather than something you improvise per element. The driving intuition:

- A color model should expose the relationships your eye sees (same hue, lighter/darker) so you can reason about colors, not just store them.
- Real interfaces consume far more distinct colors than people expect; pretending five swatches is a palette guarantees compromise.
- Constraining yourself to predefined shades is what makes a color system a system — unlimited on-the-fly variations are equivalent to no system.
- Perception is non-linear: lightness dilutes saturation, and different hues have inherently different perceived brightness. Good palettes compensate for this instead of trusting the math.
- Color must serve hierarchy and accessibility. Contrast requirements are constraints to design within creatively, and color can never be the only channel carrying meaning.

## Ditch hex for HSL

**Principle:** Represent colors as HSL, not hex or RGB.

**Why:** Hex/RGB encode colors in a machine-friendly way that hides visual relationships. Three blues that are obviously siblings on screen look like unrelated strings in hex. HSL encodes the attributes the eye actually perceives, so related colors look related in code.

**The three components:**
- **Hue** — position on the color wheel in degrees: 0° red, 120° green, 240° blue (and back to red at 360°). Hue is what makes two different blues both read as "blue."
- **Saturation** — vividness, 0% to 100%. 0% is grey (no color at all); 100% is maximally vivid. At 0% saturation, hue has no effect — rotating it changes nothing.
- **Lightness** — distance from black/white. 0% is pure black, 100% is pure white, 50% is the pure color at that hue.

**HSL is not HSB.** In HSB, 0% brightness is always black, but 100% brightness is only white when saturation is 0%; at 100% saturation, 100% HSB brightness equals 50% HSL lightness. Design tools often default to HSB, but browsers only understand HSL — use HSL for web work.

## You need more colors than you think

**Principle:** A real interface needs a comprehensive palette, not the five swatches a palette generator hands you. You cannot build anything with five hex codes.

A good palette splits into three categories:

**Greys.** Almost everything in an interface is grey: text, backgrounds, panels, form controls. You need **8–10 shades** — enough that you never wish for something between shade 2 and shade 3, not so many you debate shade 77 vs 78. True black tends to look unnatural; start from a very dark grey and step up to white in steady increments.

**Primary color(s).** One, *maybe* two colors drive primary actions, active navigation, and the overall brand feel (the thing that makes Facebook "blue"). You need **5–10 shades** of each. Ultra-light shades work as tinted backgrounds (alerts, highlights); dark shades work for text.

**Accent colors.** Additional hues that communicate, each also needing multiple shades even though they are used sparingly. They serve distinct purposes:
- An eye-grabbing hue (yellow, pink, teal) for highlighting new features
- Colors that emphasize different **semantic states** (the book's term): red for confirming destructive actions, yellow for warning messages, green for highlighting positive trends

A third purpose is categorization: if you use color to distinguish similar elements (graph lines, calendar events, project tags), you need even more accents. Organizing the accent palette by these purposes — attention, semantic state, category — beats treating it as an undifferentiated list of extra hues. A complex UI can legitimately need **up to ten colors with 5–10 shades each**.

## Define your shades up front

**Principle:** Pick a fixed set of shades before you start designing. Never generate variants on the fly with preprocessor functions like `lighten()`/`darken()` — that is how you end up with 35 nearly identical blues.

**The process:**

1. **Choose the base color first** — the middle shade the scale hangs on. For primary and accent colors, the rule of thumb: pick a shade that would look right as a **button background**. There is no numeric shortcut (not "start at 50% lightness") — every hue behaves differently, so judge by eye.
2. **Find the edges.** Pick the darkest and lightest shades by imagining where they'll be used: the darkest shade is usually reserved for **text**; the lightest might be used as a **tinted background**. An alert component (dark text on a pale tinted panel) exercises both at once, so design one to choose these. Keep the hue of the base; tune saturation and lightness.
3. **Fill in the gaps.** You need at least 5 shades per color, realistically closer to 10. **Nine is ideal** because it divides cleanly: name the darkest **900**, the base **500**, the lightest **100**. First pick 700 and 300 as the perfect visual compromise between their neighbors, then fill 800, 600, 400, and 200 the same way.

**The success criterion:** a finished scale should feel balanced — just enough options to accommodate your design ideas without ever feeling limiting.

**Greys:** same process, but the base matters less — just set the edges and fill in. The darkest grey should be your darkest text color; the lightest grey should work as a subtle off-white page background.

**It's not a science.** Pure math won't produce a perfect palette. Once you use the colors in real designs, expect to nudge saturation or lightness on individual shades — trust your eyes over the numbers. But resist *adding* new shades; an unconstrained palette is no palette.

## Don't let lightness kill your saturation

**Principle:** Saturation loses visual impact as lightness approaches 0% or 100%, so compensate when building shade scales, and use perceived brightness when you can't raise saturation further.

**Why:** The same saturation value looks much more colorful at 50% lightness than at 90%. A scale with constant saturation produces washed-out light and dark shades.

**Tactic 1 — saturation curve:** As lightness moves away from 50% in either direction, *increase* saturation. Plotted on a saturation-vs-lightness chart, a good scale is a U shape, not a flat line. The effect is subtle per shade, but it compounds when a color covers a large area of the UI.

**Tactic 2 — perceived brightness via hue rotation.** If the base is already at 100% saturation, you can't compensate that way. But hues differ in inherent perceived brightness: yellow at hsl(60, 100%, 50%) and blue at hsl(240, 100%, 50%) share identical HSL lightness, yet yellow looks far lighter. Perceived brightness of an RGB color:

```
sqrt(0.299·r² + 0.587·g² + 0.114·b²) / 255
```

Across the wheel (at 100% S, 50% L) perceived brightness is not linear — it has three local minima at **red (0°), green (120°), blue (240°)** and three local maxima at **yellow (60°), cyan (180°), magenta (300°)**.

So you can change a color's brightness without touching lightness:
- **To lighten:** rotate hue toward the nearest bright hue — 60°, 180°, or 300°.
- **To darken:** rotate hue toward the nearest dark hue — 0°, 120°, or 240°.

This preserves intensity, where raising lightness drags the color toward white. It is especially valuable for inherently light hues like yellow: rotating toward orange as lightness decreases keeps dark shades warm and rich instead of dull and brown. You can combine both levers — part of the brightness change from hue, part from lightness.

**Limit: rotate hue no more than 20–30°**, or the result reads as a different color rather than a lighter/darker version. This technique works best in small doses. Note what the cap protects: the shade must still read as the *same color*. The book's own shade examples stay inside it (20°, 18°, 27° rotations); its accessibility example rotates ~52° without comment. (The book never reconciles the two; our reading is that the cap only governs shade variants of one color, not text that merely needs to be colorful and legible.)

## Greys don't have to be grey

**Principle:** Saturate your greys to give the interface a **color temperature** (the book's term). True grey (0% saturation) has no color in it at all by definition; in practice, though, a lot of the colors we read as grey carry real saturation — sometimes heavy (e.g. a near-black at 56% saturation). That hidden saturation is precisely what makes one UI's greys feel cool and another's feel warm. It works like picking light bulbs: warm-white bulbs cast yellowish light, cool-white bulbs cast bluish light.

**How:**
- **Cool greys:** saturate with blue — hue around 207–210, saturation roughly 12–21% across the scale.
- **Warm greys:** saturate with yellow/orange — hue around 39–41, same saturation range.

**Keep temperature consistent across the scale:** because lightness dilutes saturation, the lightest and darkest greys need *higher* saturation than the mid greys (the book's example scale runs S 15%, 12%, 12%, 16%, 21% from dark to light). Otherwise the extremes look washed out next to the mid-lightness greys.

**How much** is a taste decision: a touch of saturation tips the temperature subtly; heavy saturation makes the whole interface lean visibly cool or warm.

## Accessible doesn't have to mean ugly

**Principle:** Meet WCAG contrast without sacrificing the design — by flipping contrast and rotating hue, not by abandoning color.

**The numbers (the Web Content Accessibility Guidelines — WCAG — frame these as recommendations):**
- Normal text (under ~18px): contrast ratio **≥ 4.5:1**
- Large text: **≥ 3:1**

Reference points for grey text on white: hsl(0,0%,54%) fails normal text at 3.45:1; 42% lightness passes AA at 5.41:1; 33% hits AAA at 7.57:1. Plain dark text on a light background meets these targets easily; the difficulty starts once color is involved.

**Compliance depends on text size, not just the color.** The book's paired grade tables reuse the same greys to make this point: 54% grey (3.45:1) fails as normal text but earns AA as large text, and 42% grey (5.41:1) is only AA for normal text but AAA for large. So 4.5:1 is not a universal floor — a grey too light for body copy is perfectly legitimate in a large heading, which means you can use lighter secondary colors at large sizes instead of needlessly darkening headings.

**Tactic 1 — flip the contrast.** White text on a colored background needs a surprisingly dark background to reach 4.5:1, and dark saturated backgrounds shout for attention, wrecking hierarchy on elements that should be secondary (badges, pills). Instead, invert: **dark colored text on a light tinted background of the same hue**. Contrast jumps to AAA levels, color still communicates, and the element stops competing with primary actions.

**Tactic 2 — rotate the hue.** Hardest case: colored text on a colored background (e.g. secondary text inside a dark colored panel). Just raising lightness/saturation forces the text toward pure white, killing the distinction between primary and secondary text. Since some hues are inherently brighter, rotate the text hue toward a bright hue (**cyan, magenta, or yellow — 180°, 300°, 60°**) to gain contrast while staying visibly colorful. The book's example rotates 240° → 188° (about 52°) and keeps 8.7:1 (AAA) with vivid cyan-tinted text instead of near-white. (The book never squares this with its 20–30° cap; our inference is that the cap governs shade variants only, and this text isn't meant to read as a shade of the background.)

## Don't rely on color alone

**Principle:** Color may support meaning but never carry it alone — colorblind users won't receive the message.

**Tactics:**
- Pair color with a redundant cue. Red/green percentage badges are indistinguishable under red-green color blindness; adding up/down arrow icons makes the direction readable regardless.
- When color distinguishes categories (chart segments, trend lines), prefer **contrast within one hue** over distinct hues: a colorblind person can tell light from dark much more easily than they can tell two distinct colors apart, so light/medium/dark shades of the same color hold up where blue vs green vs orange can collapse.

Rule: color reinforces what the design already says through text, icons, or contrast — never the sole channel.

## Quick-reference rules

- Use HSL, not hex or RGB; browsers don't speak HSB.
- Hue anchors: 0° red, 120° green, 240° blue; 0% saturation = grey; 50% lightness = pure hue.
- Build a full palette: greys + 1–2 primaries + accents (highlight, red/destructive, yellow/warning, green/positive).
- Greys: 8–10 shades; true black tends to look unnatural, so start the ramp from a very dark grey; darkest grey = darkest text, lightest = off-white background.
- Primaries and accents: 5–10 shades each; complex UIs may need ~10 colors total.
- Define all shades up front; never lighten()/darken() on the fly.
- Pick the base shade as "would work as a button background."
- Pick edge shades from real use: darkest for text, lightest for tinted backgrounds (design an alert to find both).
- Use a 9-step scale (100–900, base at 500); fill 700/300 first, then 800/600/400/200.
- Tweak shades by eye afterward; avoid adding new shades too often — an unconstrained palette is no system.
- Increase saturation as lightness moves away from 50% to avoid washed-out shades.
- Lighten by rotating hue toward 60°/180°/300°; darken toward 0°/120°/240°.
- Never rotate hue more than 20–30° for a shade variant.
- Perceived brightness = sqrt(0.299r² + 0.587g² + 0.114b²)/255.
- Saturate greys: blue hue (~210) for cool, yellow-orange (~40) for warm; boost saturation at scale extremes.
- WCAG: ≥4.5:1 for text under ~18px, ≥3:1 for large text.
- Grades are size-dependent: the same grey can fail as body text yet pass AA as large text (54% grey, 3.45:1) — lighter colors are usable at large sizes.
- Prefer dark colored text on light tinted background over white on dark (flip the contrast).
- For colored-on-colored text, rotate the hue toward a bright hue instead of approaching white.
- Never encode meaning in color alone; add icons/text, or distinguish categories by lightness within one hue.
