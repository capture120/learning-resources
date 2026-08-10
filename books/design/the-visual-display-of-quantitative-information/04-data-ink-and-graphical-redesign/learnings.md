# Chapter 4: Data-Ink and Graphical Redesign

The chapter's central argument: a data graphic exists to show data, so most of its ink should represent data. Tufte defines *data-ink* and the *data-ink ratio*, then derives editing rules from them: maximize the share of ink that carries information, and erase ink that does not. Graphical design, like writing, improves through ruthless revision and editing.

## The Fundamental Principle (pp. 91–92)

Data graphics are "instruments to help people reason about quantitative information" (p. 91). The form should present the quantitative content, not draw attention to itself. Playfair's own evolution — from his cluttered 1785 chart to his cleaner 1786 design — illustrates the foundation of the whole theory:

> "Above all else show the data." (p. 92)

This principle is the basis for Tufte's theory of data graphics.

## Data-Ink Defined (p. 93)

**Data-ink** is "the non-erasable core of a graphic, the non-redundant ink arranged in response to variation in the numbers represented" (p. 93). It is the ink that would change if the data changed.

**Data-ink ratio** (p. 93):

```
Data-ink ratio = data-ink / total ink used to print the graphic

              = proportion of a graphic's ink devoted to the
                non-redundant display of data-information

              = 1.0 − proportion of a graphic that can be erased
                without loss of data-information
```

Benchmarks from the chapter:
- An electroencephalogram uses every drop of ink for data; nothing can be erased without losing information — ratio near 1.0 (p. 93).
- A good scientific scatterplot (Bonner's size-and-cycle chart) is mostly data-ink, with only 10–20% non-data-ink in ticks and frame (p. 94).
- A grid-dominated chart can have a ratio near zero, and a reprint that omitted the data points entirely achieved "a graphical absolute zero, a null data-ink ratio" (p. 95).

## Maximizing the Share of Data-Ink (p. 96)

> "Maximize the data-ink ratio, within reason." (p. 96)

- "Every bit of ink on a graphic requires a reason. And nearly always that reason should be that the ink presents new information." (p. 96)
- The principle generates reasonable design advice for perhaps two-thirds of all statistical graphics; for the rest the ratio is ill-defined or not appropriate. Its main importance is that other design principles follow from it (p. 96).

## Two Erasing Principles (pp. 96–100)

**Erasing Principle 1** (p. 96):

> "Erase non-data-ink, within reason."

- Non-data-ink rarely interests the viewer and often clutters the data (e.g., a thick mesh of grid lines). Though such ink sometimes "sets the stage" for the data, the data can often serve as their own stage (p. 96; foreshadowing Chapter 7).

**Redundant data-ink** (pp. 96–97): ink that depicts the same number over and over.
- A labeled, shaded bar locates its height in six separate ways — (1) height of the left line, (2) height of shading, (3) height of right line, (4) position of the top horizontal line, (5) position of the number at the bar's top, (6) the number itself. Any five can be erased and the sixth still indicates the height (pp. 96–97). That is more ways than needed.
- "Gratuitous decoration and reinforcement of the data measures generate much redundant data-ink" (p. 97) — decoration is a *source* of redundancy, not just ornament (the seed of Chapter 5's chartjunk critique).
- Bilateral symmetry creates redundancy: box plots, open bars, and Chernoff faces all mirror information. Half-faces carry the same information as full faces and may even be easier to sort; the freed half can encode additional variables (p. 97).
- "Bilateral symmetry doubles the space consumed by the design in a graphic, without adding new information" (p. 97). Perception studies show viewers examine one symmetric half, confirm the other matches, and stop looking — symmetry wastes their attention (p. 97, citing Zusne).

**When redundancy IS justified** (pp. 98–99): redundancy occasionally has uses — "giving a context and order to complexity, facilitating comparisons over various parts of the data, perhaps creating an aesthetic balance" (p. 98). In cyclical time-series, repeat part of the cycle so the eye can track any portion without jumping back to the beginning (Marey's train schedule with an extra half-cycle; ocean-current map shown one-and-two-thirds times around the world).

**Erasing Principle 2** (p. 100): most data representations show a single uncomplicated number and need little repetition. Unless redundancy has a distinctly worthy purpose:

> "Erase redundant data-ink, within reason."

## Application in Editing and Redesign (pp. 100–105)

- "Just as a good editor of prose ruthlessly prunes out unnecessary words, so a designer of statistical graphics should prune out ink that fails to present fresh data-information" (p. 100).
- Editing and revision are as essential to graphical work as to writing; nothing replaces a good graphical idea applied to interesting numbers, but the critical labor of "sifting, combining, constructing, expunging, correcting, testing" completes it (p. 100, quoting T. S. Eliot on criticism in creation).
- Practical test for each element: would it change if the data or the experimental design changed? If yes, it carries information and stays (e.g., the horizontals marking paired comparisons in the bar-chart redesign). If a mark says the same thing everywhere (e.g., asterisks on every bar because every comparison was significant), erase it and state the fact once in the caption (p. 101).
- Erasing alone can transform a graphic: the psychology bar chart kept all its data after about 65 percent of its ink was erased (p. 101). The arithmetic: original design = erased part + good part (p. 102).
- Erasing also reveals: decluttering Pauling's atomic-volume chart "brings out another aspect of the data" — several elements visibly deviate from the theoretical curves (p. 103).
- Erasing is not mindless minimization. The reference curves in Pauling's chart prove essential: "The curves create a structure, giving an ordering, a hierarchy, to the flow of information from the page" (p. 104). Keep non-data ink that genuinely organizes the data; the data points alone failed to show the periodicity.
- Test additions the same way: restoring the grid ticks failed to organize the data, added "a disconcerting visual vibration," and made the reference curves even more necessary (p. 104).
- Reinvest the space freed by erasing: add direct labels on the data (alkali elements marking each period's start, the rare-earths anomaly) and rotate axis labels to read left-to-right, making the graphic "a little more friendly" (p. 105).

## Conclusion: The Five Principles (p. 105)

> "Five principles in the theory of data graphics produce substantial changes in graphical design. The principles apply to many graphics and yield a series of design options through cycles of graphical revision and editing.
>
> Above all else show the data.
> Maximize the data-ink ratio.
> Erase non-data-ink.
> Erase redundant data-ink.
> Revise and edit." (p. 105)

## Designer's checklist derived from this chapter

1. For every mark, ask: does this ink change when the data change? If not, it is non-data-ink — erase it unless it demonstrably stages or organizes the data.
2. Count how many times each number is encoded; one clear encoding usually suffices. Erase the rest unless redundancy aids comparison, gives context, or completes a cycle.
3. Avoid bilaterally symmetric encodings; mirrored halves cost space without adding information.
4. If a symbol appears on every data point identically, delete it and say it once in the caption.
5. Mute or remove grids; if structure is needed, prefer reference curves or other elements that order the data.
6. Treat the first draft of a graphic as a draft: revise and edit through repeated cycles, like prose.
7. Use the space recovered by erasing for direct data labels and more readable type.
