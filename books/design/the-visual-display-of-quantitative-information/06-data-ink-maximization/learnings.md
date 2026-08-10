# Chapter 6: Data-Ink Maximization and Graphical Design

The data-ink principles from the preceding chapters can do more than edit existing graphics — they can derive entirely new graphical forms. This chapter applies maximizing data-ink and erasing to standard designs (box plots, bar charts, histograms, scatterplots) and produces new ones: the quartile plot, the white grid, the range-frame, the dot-dash-plot, and the rugplot. Tufte's test of a real theory of graphics is exactly this generative power: "Is it possible to do what a theory of graphics is supposed to do, that is, to derive new graphical forms?" (p. 123).

## The Method: Erase, Then Redesign

- Take a conventional design, identify every mark that does not carry information, and erase it. What remains either is data-ink or can be converted into data-ink (p. 123-124).
- The procedure is one of *reasonable* data-ink maximizing: the principle generates a variety of candidate designs, but "the choice of the best overall arrangement naturally also rests on statistical and aesthetic criteria" (p. 124). Maximization proposes; statistics and aesthetics dispose.
- A practical side benefit: erased designs are far faster to draw. This matters in informal, exploratory data analysis, "where the research worker's time should be devoted to matters other than drawing lines" (p. 125).

## Redesign of the Box Plot → the Quartile Plot (p. 123-125)

- Spear's range bar and Tukey's box plot each encode only five numbers (minimum, lower quartile, median, upper quartile, maximum) yet spend ink on boxes, caps, and double lines. They "can be mostly erased without loss of information" (p. 124).
- The **quartile plot** shows the same five numbers with a line broken at the quartiles and a dot (or gap) at the median. It is easy to draw by hand or computer, needs one placing of the straightedge versus six for the box plot, and — most importantly — can replace the conventional scatterplot frame (p. 124).
- To give special emphasis to the middle half of the distribution, change line weights, or better, **offset the middle half** sideways. The offset version is the preferred form of the quartile plot: "It uses the ink effectively and looks good" (p. 124).
- Actionable rule: when a design encodes few numbers, draw only what those numbers require; reject variants (like the dots-at-the-extremes design, with a line through the middle of the distribution) that cannot double as a frame or that look poor (p. 124).

## Redesign of the Bar Chart / Histogram (p. 126-129)

The standard journal-endorsed bar chart differs little in architecture from Playfair's 1781 original. Erasing improves it step by step:

1. **Erase the box** (the full frame around the plot) (p. 127).
2. **Erase the vertical axis**, keeping only the ticks (p. 127).
3. **Erase part of the data measures themselves** to make a **white grid**: thin white lines running through the bars at each labeled level. The white grid "shows the coordinate lines more precisely than ticks alone" (p. 127).
4. The white grid then **eliminates the tick marks**, since the numerical labels tie directly to the white lines (p. 128).
5. **The baseline can be erased**, since the bars define the end-point at the bottom — though the thick-bar/thin-baseline intersection is attractive (it also produces an optical illusion of gray dots), and "a thin baseline looks good" (p. 128). Aesthetic judgment may retain it.

Final redesigned bar chart: no frame, no vertical axis, no ticks, a white grid, optionally a thin baseline. These techniques transfer to other designs, e.g. the variable-width notched box plot (p. 129).

## Redesign of the Scatterplot (p. 130-135)

### The Range-Frame (p. 130-131)
- Key insight: "the frame of a graphic can become an effective data-communicating element simply by erasing part of it" (p. 130).
- Rule: **frame lines should extend only to the measured limits of the data**, not to an arbitrary next round number. Trim off the part of the frame exceeding the observed data (p. 130).
- The resulting **range-frame** explicitly shows the maximum, minimum, and range of both variables — information the conventional design gives only by extrapolation and visual estimation. The erased non-data-ink is gone, and the remaining frame "has gone over to the side of data-ink" (p. 130).
- Only the tails of the frame change; the design needs no viewing or decoding instructions — it is not a graphical puzzle. "The range-frame should replace the non-data-bearing frame in many graphical applications" (p. 131).
- Range-frames also work along a single dimension: in a time-series, let the vertical frame line span the historical high and low. "This is an excellent practice and should be used widely in all sorts of displays, both scientific and unscientific" (p. 132).

### The Quartile-Plot Frame (p. 132)
- A small shift of the remaining frame ink turns each range-frame line into a quartile plot. The scatterplot frame then displays **ten extra numbers**: minimum, maximum, both quartiles, and median for each of the two variables.
- Useful for analytical and exploratory work and for published graphics where the marginal distributions matter. "The design is nearly always better than the conventionally framed scatterplot" (p. 132).

### The Dot-Dash-Plot (p. 133-134)
- The entire frame can be turned into data by framing the bivariate scatter with the full **marginal distribution** of each variable as a fringe of dashes (one dash per observation projected onto each axis).
- The **dot-dash-plot** "combines the two fundamental graphical designs used in statistical analysis, the marginal frequency distribution and the bivariate distribution," making routine what good data analysts already do — plotting marginal and joint distributions together (p. 133).
- (The name follows tradition: scatterplots were once called "dot diagrams," e.g. in R. A. Fisher's *Statistical Methods for Research Workers*, 1925.)

### The Rugplot (p. 135)
- The fringe of dashes can connect a series of bivariate scatters into a **rugplot** ("since it resembles a set of fringed rugs — and covers the statistical ground").
- The shared dashes reflect the one-dimensional projections and let the eye follow how each plot filters and translates the data into the next adjacent plot. Each bivariate scatter can be read as the imperfect empirical representation of an underlying curve transforming one variable into another.
- The sequence of variables can wander as needed; the quantitative history of a single observation can be traced through a series of one- and two-dimensional contexts.

## Conclusion: Is the Theory Right, and Are the New Designs Better? (p. 136-137)

The first part of a theory of data graphics is in place: **most of a graphic's ink should vary in response to data variation.** The gains are large: in several cases the data-ink ratio rose from .1 or .2 to nearly 1.0, and the transformed designs are less cluttered and shrink more readily (p. 136).

Are the transformed designs *better*? Tufte's four answers (p. 136):

1. **Necessarily better within the theory**, since more information is displayed per unit of space and per unit of ink — and "the history of devices for communicating information is written in terms of increases in efficiency of communication and production."
2. **Graphics almost always improve through editing**, revision, and testing against design options. The principles of maximizing data-ink and erasing both generate alternatives and point the direction revisions should move.
3. **Do not underestimate the audience.** Some designs (range-frame) are self-explanatory; the dot-dash-plot is harder but still shows everything a scatterplot shows — "Nothing is lost to those puzzled by the frame of dashes, and something is gained by those who do understand." Rule: "why not assume that if you understand it, most other readers will, too? Graphics should be as intelligent and sophisticated as the accompanying text."
4. **Oddness is just unfamiliarity.** Conventional designs have been seen thousands of times; the range-frame, dot-dash-plot, white grid, quartile plot, rugplot, and half-face only a few. With use the new designs will come to look as reasonable as the old.

Final caveat (p. 137): "Maximizing data ink (within reason) is but a single dimension of a complex and multivariate design task." The principle conducts experiments in graphical design; some succeed. Other considerations remain — not only efficiency, but also complexity, structure, density, and even beauty.

## Designer's Checklist Derived from This Chapter

- Erase frames, axes, and ticks that carry no information; keep only what encodes data.
- Extend frame lines only to the data's actual min and max (range-frame), never to round numbers.
- Consider promoting the frame to a quartile plot or full marginal distribution (dot-dash-plot).
- In bar charts: drop the box, the vertical axis, and ticks; use a white grid through the bars at labeled levels.
- Prefer the offset quartile plot over the box plot for distribution summaries.
- Show historical high/low as the span of the vertical frame in time-series.
- Apply the maximization principle within reason — let statistical and aesthetic criteria pick among the designs it generates.
