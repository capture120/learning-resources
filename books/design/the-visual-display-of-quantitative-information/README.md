# The Visual Display of Quantitative Information — Edward Tufte (2nd ed.)

Knowledge base extracted from Tufte's foundational book on statistical graphics. Each chapter directory contains `learnings.md` (core principles, definitions, page-cited rules, and a designer's checklist) and `examples.md` (the chapter's examples retold). This README is the routing layer: read it, then go to the chapter directories you need.

**Core thesis:** Data graphics are instruments for reasoning about quantitative information, not decoration. Above all else, show the data. Maximize the share of ink that carries data-information. Graphical excellence is that which gives the viewer the greatest number of ideas in the shortest time with the least ink in the smallest space — complex ideas communicated with clarity, precision, and efficiency, while telling the truth about the data.

## The fundamental principles

1. **Above all else show the data.** Induce the viewer to think about substance, not methodology or design.
2. **Tell the truth.** Visual representation, as physically measured on the surface, must be directly proportional to the numbers. Lie Factor = (effect shown) / (effect in data); keep it between 0.95 and 1.05.
3. **Maximize the data-ink ratio, within reason.** Every bit of ink requires a reason, nearly always that it presents new information. Erase non-data-ink; erase redundant data-ink.
4. **Forgo chartjunk.** No moiré vibration, dark grids, fake 3D, or decorative "ducks." Content, not ornament, makes a graphic interesting.
5. **Show data variation, not design variation.** Keep scales, intervals, and encodings constant; don't use more information-carrying dimensions than the data has (no areas/volumes for 1-D data).
6. **Answer "Compared to what?"** Show enough context and comparison data; data-thin graphics are suspect. Graphical excellence is nearly always multivariate.
7. **Maximize data density and the size of the data matrix, within reason.** The eye resolves far more than typical graphics offer; shrink graphics and use small multiples with constant design for comparison.
8. **Mobilize every graphical element to show data**, perhaps several times over: data-based grids, data-based labels, double-functioning marks.
9. **Integrate words, numbers, and pictures.** Label data directly on the graphic; graphics are paragraphs about data.
10. **Match form to data size.** Sentences for 1-2 numbers, tables for ~20 numbers or fewer, graphics for large datasets. Never use pie charts.
11. **Revise and edit.** Graphics improve through cycles of revision, like prose.
12. **Design is choice.** It is better to violate any principle than to place graceless marks on paper. Reveal the complex; never complicate the simple.

## Routing guide

### `00-introduction/` — Introduction
Why graphics exist: instruments for reasoning about numbers, usually the simplest and most powerful way to describe, explore, and summarize them. Sets the book's philosophy, definitions, and history (Playfair, Tukey).
**Consult when:** framing why a visualization should exist at all, setting an overall design philosophy, or needing the book's definitions and scope.

### `01-graphical-excellence/` — Graphical Excellence
What makes a graphic worth making: the four fundamental designs (data maps, time-series, space-time narratives, relational graphics), why you must always plot the data (Anscombe's quartet), and the canon of great graphics (Minard, Snow, Playfair, Marey).
**Consult when:** choosing a fundamental chart type → here. Judging whether data deserve a graphic versus a table or sentence. Designing multivariate displays. Needing exemplary graphics to emulate. Suspecting summary statistics or eye-found patterns are misleading.

### `02-graphical-integrity/` — Graphical Integrity
How graphics lie and how to stop them: the Lie Factor, six principles of integrity, proportionality, labeling, deflated/per-capita money units, context.
**Consult when:** you suspect a chart exaggerates an effect → here. Choosing baselines, axis scales, or aspect ratio. Plotting money over time (inflation/population adjustment). Tempted by pictorial, area, volume, or perspective encodings. Deciding how much context to show. Auditing a published graphic.

### `03-sources-of-graphical-integrity-and-sophistication/` — Sources of Integrity and Sophistication
Why bad graphics get made: artists without quantitative skill, the doctrines that statistics are boring and audiences are stupid. Remedy: combine substantive, statistical, and artistic expertise; prefer relational (scatterplot) designs.
**Consult when:** diagnosing why a team or publication produces poor charts. Deciding who owns chart design. Tempted to decorate "boring" data or dumb a chart down. Choosing between a scatterplot and simpler bar/time-series forms.

### `04-data-ink-and-graphical-redesign/` — Data-Ink and Graphical Redesign
The theory's core machinery: data-ink, the data-ink ratio, the two erasing principles, when redundancy earns its keep, and editing graphics like prose. The five summary principles live here.
**Consult when:** auditing a draft for clutter, redundant encodings, or grids → here. Deciding whether a non-data element (reference curve, repeated cycle) earns its ink. Running an editing pass on any chart.

### `05-chartjunk/` — Chartjunk: Vibrations, Grids, and Ducks
The taxonomy of decoration to forgo: moiré vibration (hatching), dark grids, and "ducks" (design that promotes itself over the data), including fake 3D and computer-default junk.
**Consult when:** choosing fill patterns versus gray tints. Styling or suppressing gridlines. Considering 3D effects or themed chart styles. Evaluating software default output. A few numbers might be better as a table.

### `06-data-ink-maximization/` — Data-Ink Maximization and Graphical Design
Erasing as a generative tool: redesigning standard forms into the quartile plot, white grid, range-frame, dot-dash-plot, and rugplot. Frames and axes become data-ink.
**Consult when:** redesigning box plots, bar charts, histograms, scatterplots, or time-series → here. Deciding how to draw frames, axes, and ticks. Judging whether a novel minimal form will confuse readers (it usually won't).

### `07-multifunctioning-graphical-elements/` — Multifunctioning Graphical Elements
Making one mark do several jobs: data-built data measures (stem-and-leaf), data-based grids and labels, double-functioning ID codes, gray over color for ordered data, viewing depths and viewing angles, and avoiding puzzle graphics.
**Consult when:** designing dense or multivariate displays. Deciding whether grids, labels, or codes can carry data. Choosing color versus gray for ordered quantities. A complex graphic risks becoming a verbal-decoding puzzle. Evaluating slopegraphs or stem-and-leaf plots.

### `08-data-density-and-small-multiples/` — Data Density and Small Multiples
How much data a graphic should carry: data density as a performance measure, the Shrink Principle, and small multiples (constant-design repeated frames indexed by a changing variable).
**Consult when:** designing a dashboard or faceted layout → here. A chart looks too sparse or too crowded. Choosing graphic size. Building comparisons across time, categories, or groups.

### `09-aesthetics-and-technique/` — Aesthetics and Technique
Final craft decisions: sentence vs text-table vs table vs supertable vs graphic, why pie charts never, words-as-data-ink, friendly graphics (direct labels, serif type, color-blind-safe palettes), line weights, and shape (roughly 50% wider than tall).
**Consult when:** choosing between sentence, table, and graphic for given data. Writing labels, captions, and annotations. Picking typography and colors (including accessibility). Setting line weights or aspect ratio. Laying out text and figures together.

### `10-epilogue/` — Epilogue: Designs for the Display of Information
The closing stance: design is choice. Principles generate and guide options but never bind; elegance outranks rule-compliance.
**Consult when:** Tufte's rules conflict with each other or with grace, or you need the book's overall purpose stated: the revelation of the complex.

## Task index

Read the listed directories in order. Start with `learnings.md`; open `examples.md` when you need concrete models to emulate.

| Task | Read in order |
|---|---|
| Designing a new chart from scratch | `01-graphical-excellence`, `04-data-ink-and-graphical-redesign`, `09-aesthetics-and-technique` |
| Reviewing a chart for honesty | `02-graphical-integrity`, `01-graphical-excellence` |
| Stripping a busy or cluttered chart | `04-data-ink-and-graphical-redesign`, `05-chartjunk`, `06-data-ink-maximization` |
| Deciding table vs graph (or sentence) | `09-aesthetics-and-technique`, `02-graphical-integrity`, `01-graphical-excellence` |
| Designing a dashboard or faceted display | `08-data-density-and-small-multiples`, `07-multifunctioning-graphical-elements`, `04-data-ink-and-graphical-redesign` |
| Visualizing multivariate data | `01-graphical-excellence`, `07-multifunctioning-graphical-elements`, `08-data-density-and-small-multiples` |
| Choosing axes, frames, grids, and ticks | `06-data-ink-maximization`, `05-chartjunk`, `07-multifunctioning-graphical-elements` |
| Labeling, typography, color, aspect ratio | `09-aesthetics-and-technique`, `07-multifunctioning-graphical-elements` |
| Plotting money or rates over time | `02-graphical-integrity`, `01-graphical-excellence` |
| Auditing software default chart output | `05-chartjunk`, `04-data-ink-and-graphical-redesign` |
| Improving a team's graphics culture | `03-sources-of-graphical-integrity-and-sophistication`, `00-introduction` |
| Resolving conflicts between principles | `10-epilogue`, `09-aesthetics-and-technique` |
