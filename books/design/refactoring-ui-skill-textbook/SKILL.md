---
name: refactoring-ui-textbook
description: Practical UI design guidance distilled from Refactoring UI (Wathan & Schoger). Use when designing or improving user interfaces — starting a new app/feature/screen, fixing visual hierarchy, choosing spacing/layout, typography, color palettes, shadows/depth, handling images and icons, or polishing a structurally sound but plain-looking UI.
---

# Refactoring UI — Skill Overview

Tactical design rules for developers. Each chapter directory contains `core-learnings.md` (principles and rules, with exact values) and `examples.md` (paraphrased demonstrations). Route to the chapter that matches your task; read this file in full, then open only the chapters you need.

## Core philosophy

Five values drive every rule in the book:

1. **Systems over judgment calls.** Pre-define constrained scales — type sizes, spacing, color shades, shadows, radii — and pick from them by elimination. Never make the same minor decision twice; never nudge arbitrary pixels.
2. **Hierarchy over layout.** What makes a UI look designed is controlling what the eye sees first. Rank everything primary/secondary/tertiary and mute the lower ranks; size, weight, and color/contrast are interchangeable levers.
3. **Low fidelity first, working software fast.** Design a real feature in grayscale before chrome, color, or detail. Design a little, build it, iterate on the real thing.
4. **Content determines size.** Elements get the space their content needs — not what the screen, a grid, or a proportional ratio dictates. Start with too much white space and remove.
5. **Style by role, not semantics or defaults.** An h1 can be 16px; a destructive button can be a quiet link; a default border can be a shadow or a background shift. Visual treatment follows importance to the user.

## Routing guide

### 01 — Starting from Scratch
**Open when:** beginning a new app, feature, or screen from a blank canvas; stuck on where to start; deciding personality (fonts, colors, radius, tone); setting up design systems/scales before work begins.
**Key topics:** feature-first design (defer the shell/nav), Sharpie wireframes, grayscale-first, short design-build cycles, shipping the smallest version, personality levers, constrained value systems, design by elimination.
**Files:** `01-starting-from-scratch/core-learnings.md` · `01-starting-from-scratch/examples.md`

### 02 — Hierarchy is Everything
**Open when:** a UI feels noisy, flat, or unpolished; everything competes for attention; styling text emphasis, labels, headings, icons, borders, or button sets (including destructive actions).
**Key topics:** primary/secondary/tertiary ranking, size vs weight vs color, 2–3 text colors and 2 weights, de-emphasized text on colored backgrounds, emphasize by de-emphasizing, label:value alternatives, visual vs semantic hierarchy, weight-contrast balancing, button action hierarchy.
**Files:** `02-hierarchy-is-everything/core-learnings.md` · `02-hierarchy-is-everything/examples.md`

### 03 — Layout and Spacing
**Open when:** deciding white space, padding, margins, or widths; a UI feels cramped or stretched too wide; layout breaks on resize; related elements don't read as grouped; choosing responsive strategy.
**Key topics:** over-space then reduce, 16px-base spacing scale (≥25% steps), don't fill the screen, mobile-first ~400px canvas, fixed vs fluid widths, max-width over grid columns, non-proportional scaling, proximity and grouping (more space around a group than within).
**Files:** `03-layout-and-spacing/core-learnings.md` · `03-layout-and-spacing/examples.md`

### 04 — Designing Text
**Open when:** making any typography decision — type scale, typeface choice, paragraph width, line-height, alignment, link styling, letter-spacing.
**Key topics:** hand-crafted type scale (px/rem, never em), font-quality proxies and system stack, 45–75 char line length, baseline alignment, line-height proportional to width and inverse to size, link styling in link-dense UIs, alignment rules, letter-spacing for headlines and all-caps.
**Files:** `04-designing-text/core-learnings.md` · `04-designing-text/examples.md`

### 05 — Working with Color
**Open when:** choosing or systematizing colors — building a palette or shade scale, picking greys, meeting WCAG contrast, or fixing washed-out, garish, or colorblind-unfriendly color use.
**Key topics:** HSL over hex, palette structure (greys + primaries + accents), 9-step shade scales defined up front, saturation compensation at lightness extremes, hue rotation for brightness, saturated cool/warm greys, contrast flipping for badges, never color alone.
**Files:** `05-working-with-color/core-learnings.md` · `05-working-with-color/examples.md`

### 06 — Creating Depth
**Open when:** making elements feel raised, inset, or layered — box-shadow values, an elevation scale, depth for buttons/inputs/dropdowns/modals, flat-design depth, or overlapping cards and images.
**Key topics:** light-from-above emulation, raised vs inset recipes, five-step shadow scale, interaction feedback via shadows, two-part shadows (direct + ambient), color value as depth cue, solid zero-blur shadows, overlap via negative margins, invisible borders on images.
**Files:** `06-creating-depth/core-learnings.md` · `06-creating-depth/examples.md`

### 07 — Working with Images
**Open when:** using photos, icons, screenshots, logos/favicons, or user uploads — especially text-over-image heroes, sizing icons or screenshots, or making layouts robust to arbitrary user content.
**Key topics:** photo quality, overlays/contrast-reduction/colorize/text-glow for text on images, intended sizes for icons (enclose small icons in shapes), screenshot alternatives, favicon redrawing, cover-cropping uploads, inner box shadows against bleed.
**Files:** `07-working-with-images/core-learnings.md` · `07-working-with-images/examples.md`

### 08 — Finishing Touches
**Open when:** a UI is structurally sound but feels plain, generic, or default-looking; or it feels busy from too many borders.
**Key topics:** supercharging defaults (icon bullets, styled links, custom controls), accent borders, background decoration (colors, gradients, patterns, spot graphics), empty states as first impressions, border alternatives, rethinking component conventions (dropdowns, tables, selectable cards).
**Files:** `08-finishing-touches/core-learnings.md` · `08-finishing-touches/examples.md`

### 09 — Leveling Up
**Open when:** advising on how to keep improving as a designer; studying or reverse-engineering designs you admire.
**Key topics:** hunting for unintuitive decisions, rebuilding interfaces without dev tools, plus concrete tricks: heading line-height ~1.2, letter-spacing on uppercase, layered box-shadows, cropping with overflow: hidden.
**Files:** `09-leveling-up/core-learnings.md` · `09-leveling-up/examples.md`

## Quick-start: highest-leverage rules

If you read nothing else, apply these:

1. Pick every value (font size, spacing, color shade, shadow, radius) from a pre-defined scale; choose by comparing a guess against its neighbors.
2. Rank every element primary/secondary/tertiary; mute the lower ranks instead of only amplifying the top.
3. Design in grayscale first so spacing, contrast, and size carry the hierarchy; add color later.
4. Use 2–3 text colors (dark/grey/light grey) and 2 weights (400–500, 600–700); never weights under 400, never grey text on colored backgrounds (use same hue, adjusted saturation/lightness).
5. Start with too much white space and remove until right; always put more space around a group than within it.
6. Don't fill the screen: content gets the width it needs (paragraphs 45–75 characters), with a max-width; design mobile-first at ~400px.
7. Use a fixed type scale in px/rem (e.g. 12, 14, 16, 18, 20, 24, 30, 36, 48, 60, 72); pick HTML tags for semantics and sizes for hierarchy — an h1 can be 16px.
8. Line-height scales with line length and inversely with font size: ~1.75 for small text, ~1 for headlines; tighten heading line-height to ~1.2.
9. One solid high-contrast primary button per page — fill with whatever contrasts most against the backdrop (e.g. white on a colored gradient, bright green on a dark background); secondary as outline/low-contrast fill; tertiary as links; big-red-solid only on the confirmation step.
10. Use HSL; define 8–10 shades per color up front (greys included, slightly saturated for temperature); never lighten()/darken() on the fly.
11. Prefer dark colored text on a light tinted background over white on dark (meets WCAG easily); never encode meaning in color alone.
12. Light comes from above: raised elements get a light top edge and small dark shadow below; inputs and wells get inset treatment; assign shadows from a five-step elevation scale by z-axis intent.
13. For text over photos, flatten the image (overlay, lower contrast, colorize, or glow shadow) instead of fiddling with text color; force user uploads into fixed cover-cropped containers.
14. Prefer box shadows, background-color differences, or spacing over borders; if backgrounds already differ, delete the border.
15. Design empty states as a priority: illustration, one line of benefit-oriented copy, and an emphasized call-to-action; hide tabs/filters/search until content exists.
