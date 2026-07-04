# Starting from Scratch — Core Learnings

## Chapter overview

This chapter is about how to begin a design without stalling. The core insight: open-ended decisions are what make design hard. Every technique here removes degrees of freedom at the moment you don't need them — defer the app shell, defer visual detail, defer edge cases, pre-commit to a personality, and pre-pick a constrained set of values. Work flows from real functionality outward, in tight design-then-build loops, so your imagination never has to carry the whole product at once. The underlying value is momentum: a shippable simple thing beats a fully imagined complex one.

## Start with a feature, not a layout

**Principle:** Don't begin by designing the app shell (nav placement, sidebar vs. top nav, container vs. full-width, logo position). Begin with one piece of actual functionality.

**Why:** An app is a collection of features. Until you've designed a few features, you lack the information needed to make navigation and layout decisions — that's why starting with the shell feels frustrating and stuck.

**How:**
- Pick a single feature (e.g. "search for a flight") and enumerate only the elements it needs (fields, a button).
- Design those elements alone, with no surrounding chrome.
- Add navigation and shell later, once features exist to inform them. You may discover you barely need a shell at all (Google's homepage is essentially one feature).

## Detail comes later

**Principle:** In the earliest stage of a feature, skip low-level decisions — typefaces, shadows, icons, exact colors. They matter eventually, not now.

**Why:** Detail decisions consume energy and anchor you before the fundamental layout and hierarchy are settled. Low fidelity keeps exploration cheap and fast.

**How:**
- If high-fidelity environments tempt you into detail — the browser counts as one, not just design tools — sketch on paper with a thick Sharpie (a trick from Jason Fried of Basecamp). The medium physically prevents fussing over small things, so you can explore many layout ideas quickly.
- **Hold the color:** even when refining in higher fidelity, design in grayscale first. This forces spacing, contrast, and size to carry the entire hierarchy. It's harder, but you get a clearer interface with strong hierarchy that color can later enhance rather than rescue.
- **Don't over-invest:** sketches and wireframes are disposable; users can't do anything with static mockups. Use them to decide, then leave them behind. The whole point of low fidelity is speed toward building the real thing.

## Don't design too much

**Principle:** Don't design every feature and edge case before implementing. Design a little, build it, repeat.

**Why:** Predicting every interaction and edge case in the abstract (2000-contact lists, error message placement, overlapping calendar events) using only a design tool and imagination sets you up for frustration. It's far easier to fix design problems in an interface you can actually use.

**How:**
- **Work in cycles:** design a simple version of the next feature, then make it real. Expect to hit unexpected complexity — that's the point. Iterate on the working version until no problems remain, then return to design mode for the next feature. Build the real thing early so imagination doesn't do all the heavy lifting.
- **Be a pessimist:** never imply functionality in a design you aren't ready to build. When designing a feature, expect it to be hard to build; design the smallest useful version you can ship. If part of a feature is a nice-to-have, design it later — build the simple version first so you always have something to fall back on.

## Choose a personality

**Principle:** Every design communicates a personality (secure/professional, fun/playful, elegant, plain). Pick one deliberately — it may sound handwavy, but much of it comes down to a few concrete, controllable factors.

**The concrete levers:**
- **Font choice:**
  - Serif typeface → elegant, classic (e.g. a bookkeeping site in Freight Text).
  - Rounded sans serif → playful (e.g. Proxima Soft).
  - Neutral sans serif → plain look, or lets other elements carry the personality (e.g. Freight Sans).
- **Color:** color psychology is less useful in practice than how a color feels to you, but it helps explain why a color fits:
  - Blue → safe, familiar; nobody complains about blue.
  - Gold → expensive, sophisticated.
  - Pink → fun, not serious.
- **Border radius:** it sounds like a trivial detail, but whether — and how much — you round corners has a big impact on the overall feel:
  - Small radius → neutral; communicates little personality on its own.
  - Large radius → playful.
  - No radius → serious, formal.
  - Stay consistent: mixing square and rounded corners in one interface almost always looks worse than committing to one.
- **Language:** not a visual design technique per se, but words appear everywhere in an interface, so choosing the right ones influences personality as much as (or more than) color or typeface. Less personal, formal tone ("To confirm your identity, please provide a phone number…") → official, professional. Casual, friendly tone ("Sweet, thanks Steve! Just to make sure this is really you…") → friendly. One concrete, reusable knob is how you address the user: honorific plus surname ("Thank you Mr. Benson.") reads formal, while the bare first name ("Sweet, thanks Steve!") reads casual — name register shifts tone as directly as sentence phrasing does.

**Deciding what you want:** if you have no gut feeling, look at other sites your target audience already uses and match the register (serious business vs. playful). Don't borrow too heavily from direct competitors or you'll look like a second-rate copy.

## Limit your choices

**Principle:** Unlimited options (millions of colors, thousands of fonts, any pixel value) are a paralyzing curse. Pre-define constrained systems of values and choose only from those.

**Why:** Without constraints there is always more than one "right" choice — 12px vs. 13px text, 10% vs. 15% shadow opacity, 24px vs. 25px avatar, medium vs. semibold, 18px vs. 20px margin. Adjacent values are nearly indistinguishable (e.g. buttons in #3381B8 vs. #2F7DB3 vs. #2D78AD look identical), so no decision can feel confident.

**How:**
- **Define systems in advance:**
  - Colors: pick a set of 8–10 shades per hue up front; never reach for the color picker ad hoc.
  - Type: define a restrictive type scale (e.g. 12, 14, 16, 18, 20, 24, 32, 48px) instead of nudging sizes one pixel at a time.
  - You pick the hard initial values once, instead of re-deciding for every new piece of UI. More work up front, far less decision fatigue later.
- **Design by process of elimination:** with a constrained scale (e.g. icon sizes 12, 16, 24, 32px), guess the best value (say 16px), then compare it against its neighbors (12px and 24px). If both outer options are obviously bad, the middle one wins — done. If an outer option looks best, repeat with that value as the new middle (16, 24, 32) until the neighbors confirm it. Works for any systematized property because options differ noticeably.
- **Systematize everything:** build systems for font size, font weight, line height, color, margin, padding, width, height, box shadows, border radius, border width, opacity — and anything else where you find yourself laboring over a low-level decision. The more systems you have in place, the faster you work and the less you second-guess your own decisions. You don't need every system defined ahead of time; adopt a system-focused mindset, introduce a system whenever you make a new kind of decision, and try to avoid repeating the same minor decision.
- **A recurring theme:** designing with systems runs through the entire book; later chapters build many of these specific systems in finer detail.

## Quick-reference rules

- Design a real feature first; design the nav/shell last, once features inform it.
- List the minimal elements a feature needs (fields, button) and design only those.
- Defer typefaces, shadows, icons, and color in early stages.
- Sketch layouts with a thick Sharpie on paper to force low fidelity.
- Design in grayscale first; let spacing, contrast, and size carry hierarchy; add color later.
- Treat sketches and wireframes as disposable; stop refining once a decision is made.
- Design only a simple version of the next feature, then build it for real.
- Fix design problems in working software, not in imagined edge cases.
- Alternate short design and build cycles; don't design the whole app up front.
- Never show functionality in a mockup you aren't ready to build.
- Expect every feature to be hard to build; design the smallest shippable version.
- Defer nice-to-have parts of a feature; ship the simple version first.
- Pick a personality deliberately: serif = elegant, rounded sans = playful, neutral sans = plain.
- Blue feels safe, gold feels expensive/sophisticated, pink feels fun.
- Corner rounding looks like a trivial detail but strongly shifts the overall feel.
- Small radius = neutral, large radius = playful, no radius = serious/formal.
- Keep corners consistent: mixing square and rounded in one interface almost always looks worse.
- Match language tone to personality: formal = professional, casual = friendly.
- Name register is a copy lever: honorific + surname ("Mr. Benson") = formal; bare first name ("Steve") = casual.
- If unsure of personality, mirror the register of sites your audience uses; don't clone competitors.
- Pre-pick 8–10 shades per color instead of using the color picker ad hoc.
- Define a fixed type scale (e.g. 12/14/16/18/20/24/32/48px); never nudge sizes by 1px.
- Choose values by elimination: guess, compare with both neighbors, keep the middle winner; re-center if an edge wins.
- Build systems for font size/weight, line height, color, margin, padding, width, height, shadows, radius, border width, opacity.
- Add a new system whenever a low-level decision recurs; avoid having to make the same minor decision twice.
- More systems in place = faster work and less second-guessing.
