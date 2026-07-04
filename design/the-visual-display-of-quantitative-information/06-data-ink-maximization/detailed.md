# Chapter 6: Data-Ink Maximization and Graphical Design — Detailed Reference

This file is a complete, page-by-page account of Chapter 6 of Edward Tufte, *The Visual Display of Quantitative Information* (2nd edition), printed pages 122–137. The chapter is the third and final chapter of the book's data-ink trilogy (after Chapter 4, "Data-Ink and Graphical Redesign," and Chapter 5, "Chartjunk"), and it closes Part II, "Theory of Data Graphics," with a conclusion covering all three chapters. Quotations are verbatim from Tufte; page citations use the printed book page numbers.

## Epigraph: Ad Reinhardt (p. 122)

The chapter opens with a full-page epigraph, set in italics on the otherwise blank page facing the chapter title. It is a statement by the abstract painter Ad Reinhardt — an artist famous for stripping painting down to near-nothing — and it stands as the aesthetic credo behind the chapter's program of erasing:

> "Painting is special, separate, a matter of meditation and contemplation, for me, no physical action or social sport. As much consciousness as possible. Clarity, completeness, quintessence, quiet. No noise, no schmutz, no schmerz, no fauve schwärmerei. Perfection, passiveness, consonance, consummateness. No palpitations, no gesticulation, no grotesquerie. Spirituality, serenity, absoluteness, coherence. No automatism, no accident, no anxiety, no catharsis, no chance. Detachment, disinterestedness, thoughtfulness, transcendence. No humbugging, no button-holing, no exploitation, no mixing things up."

Source line as printed: "Ad Reinhardt, statement for the catalogue of the exhibition, 'The New Decade: 35 American Painters and Sculptors,' Whitney Museum of American Art, New York, 1955."

The epigraph carries intellectual weight: Reinhardt's litany of "no noise... no mixing things up" prefigures the chapter's method (erase everything that is not data) and its closing concession that design also involves "even beauty" (p. 137). It also echoes the end of Chapter 5, whose final injunction was "Forgo chartjunk, including moiré vibration, the grid, and the duck" (p. 121).

## Chapter Opening: Can the Theory Derive New Forms? (p. 123)

Tufte frames the chapter as a test of whether his data-ink principles constitute a genuine *theory* rather than merely an editing checklist. The opening paragraph in full (p. 123):

> "So far the principles of maximizing data-ink and erasing have helped to generate a series of choices in the process of graphical revision. This is an important result, but can the ideas reach beyond the details and particularities of editing? Is it possible to do what a theory of graphics is supposed to do, that is, to derive new graphical forms? In this chapter the principles are applied to many graphical designs, basic and advanced, including box plots, bar charts, histograms, and scatterplots. New designs result."

The argument structure of the chapter follows directly from this question. Tufte takes three canonical statistical designs in sequence — the box plot, the bar chart/histogram, and the scatterplot — and for each one runs the same procedure: identify the non-data-ink, erase it, and then ask whether the surviving ink can be reorganized to carry *more* information. Each run of the procedure yields a named new design: the **quartile plot**, the **white-grid bar chart**, the **range-frame**, the **quartile-plot frame**, the **dot-dash-plot**, and the **rugplot**. The chapter then closes with a four-part defense of the new designs and a final caveat about the limits of the maximization principle.

## Redesign of the Box Plot (p. 123–125)

### Starting material: Spear's range bar and Tukey's box plot (p. 123)

Tufte begins with two existing designs that summarize a distribution with five numbers (minimum, lower quartile, median, upper quartile, maximum):

- **Mary Eleanor Spear's "range bar"** — shown as a horizontal design: a thin line spanning the full range ("Range from lowest to highest amount," as the figure's own annotation reads), with a cross-hatched rectangular box covering the interquartile range and a short vertical tick marked "Median." The figure carries arrowed annotations labeling the range and "← Interquartile Range →."
- **John Tukey's "box plot"** — shown vertically: a rectangular box from quartile to quartile, a horizontal line through the box at the median, and single-line whiskers extending up to the maximum and down to the minimum. The figure is labeled at each landmark: "maximum," "quartile," "median," "quartile," "minimum."

Sidenote citation (p. 123): "Mary Eleanor Spear, *Charting Statistics* (New York, 1952), p. 166; and John W. Tukey, *Exploratory Data Analysis* (Reading, Massachusetts, 1977)."

The text bridging pages 123–124 makes the key claim about both designs: they "can be mostly erased without loss of information" (p. 124). Both spend ink on box outlines, hatching, and caps while encoding only five numbers.

### The quartile plot (p. 124)

The first erased design is shown as a small figure: a horizontal line running from the minimum to the lower quartile, then a blank gap across the interquartile range with a single **dot at the median**, then a line resuming from the upper quartile out to the maximum. Tufte names and assesses it:

> "The revised design, a *quartile plot*, shows the same five numbers. It is easy to draw by hand or computer and, most importantly, can replace the conventional scatterplot frame. The straightedge need only be placed on the paper once to draw the quartile plot, compared to six separate placings for the box plot." (p. 124)

Three things to note in this passage: (1) the definition — a quartile plot encodes min, lower quartile, median, upper quartile, max using only line-presence, line-absence, and a dot; (2) the drawing-economy argument — one straightedge placement versus six; and (3) the forward-looking architectural argument — "most importantly," this design can serve as a scatterplot *frame*, which sets up the range-frame and quartile-plot-frame designs later in the chapter (p. 130–132).

### A rejected alternative (p. 124)

Tufte then shows an alternative erased design — a dot at each extreme with a line through the middle of the distribution (the inverse coding: dots mark the extremes, ink fills the middle). He rejects it on two grounds:

> "but this design will not work effectively to frame a scatterplot. Nor does it look very good." (p. 124)

This rejection is methodologically important: erasing generates multiple candidate designs that all satisfy the data-ink criterion equally, so the criterion alone cannot pick the winner. Function (framing) and aesthetics break the tie.

### Emphasizing the middle half: line weights vs. offset (p. 124)

Tufte raises a statistical objection to his own quartile plot: "Perhaps special emphasis should be given to the middle half of the distribution, however, as in the box plot." (p. 124). He answers it with two further variants:

1. **Changing line weights** — shown as a continuous line from min to max with the interquartile segment drawn in a heavier weight.
2. **Offsetting the middle half** — "or, even better, by offsetting the middle half:" shown as a line whose interquartile segment is displaced slightly upward (parallel to but offset from the tails).

His verdict: "This latter design is the preferred form of the quartile plot. It uses the ink effectively and looks good." (p. 124)

### The principle restated: *reasonable* data-ink maximizing (p. 124)

The box-plot section closes with the chapter's central methodological qualification, in full:

> "In these revisions of the box plot, the principle of maximizing data-ink has suggested a variety of designs, but the choice of the best overall arrangement naturally also rests on statistical and aesthetic criteria — in other words, the procedure is one of *reasonable* data-ink maximizing." (p. 124)

The word "reasonable" is italicized in the original. This is the chapter's answer-in-advance to the objection that maximization is mechanical: the principle generates and directs; statistics and aesthetics select.

### The parallel schematic plot (p. 125)

Tufte extends the logic to multiples: "The same logic applies to many similar designs, such as this 'parallel schematic plot.'" (p. 125). The figure shows **ten conventional box plots side by side** (boxes with median lines, dashed whisker lines, and dashed end-caps), comparing ten distributions. The drawing-effort accounting:

> "The original required 80 separate placings of the straightedge, 50 horizontals and 30 verticals." (p. 125)

> "An erased version requires only 10 verticals to show the same information." (p. 125)

The erased version is shown as a second figure: ten vertical quartile plots — broken vertical lines with a dot at each median — displaying the identical ten five-number summaries. The reduction is from 80 straightedge placements to 10, an eight-fold saving.

The closing paragraph of the section states why this matters:

> "The large reduction in the amount of drawing is relevant for the use of such designs in informal, exploratory data analysis, where the research worker's time should be devoted to matters other than drawing lines." (p. 125)

Note the audience shift: the argument here is not about the *reader's* ink but the *analyst's* labor — data-ink maximization pays off in production economics as well as in communication. (This anticipates conclusion point (1) on p. 136, where the history of communication devices "is written in terms of increases in efficiency of communication and production.")

## Redesign of the Bar Chart / Histogram (p. 126–129)

### The standard model and its ancestry (p. 126)

The section opens under the heading "Redesign of the Bar Chart/Histogram":

> "Here is the standard model bar chart, with the design endorsed by the practices and the style sheets of many statistical and scientific publications:" (p. 126)

The figure shows the conventional form: a full rectangular frame (box) around the plotting region, a vertical axis with tick marks, and roughly a dozen solid gray vertical bars of varying heights rising from a baseline.

Tufte then makes a historical point: "Its architecture differs little from Playfair's original design:" (p. 126), followed by a full-width reproduction of **William Playfair's 1786 chart of Scotland's trade** (from *The Commercial and Political Atlas*). The reproduction's printed title reads: "Exports and Imports of SCOTLAND to and from different parts for one Year from Christmas 1780 to Christmas 1781." It is a horizontal bar chart with a numerical scale across the top running 10, 20, 30, ... up toward "L300,000" (pounds sterling, with major divisions at 10,000-pound intervals), a vertical grid, and seventeen trading partners listed down the right side under "Names of Places": Jersey &c., Ireland [sic — Iceland in some printings], Poland, Isle of Man, Greenland, Prussia, Portugal, Holland, Sweden, Guernsey, Germany, Denmark and Norway, Flanders, West Indies, America, Russia, Ireland. Each place gets paired horizontal bars. The engraved caption beneath reads: "The Upright divisions are Ten Thousand Pounds each. The Black Lines are Exports the Ribbed lines Imports," with the imprint "Published as the Act directs June 7th 1786 by Wm. Playfair" and "Neele sculpt. 352 Strand, London."

The rhetorical role of the Playfair chart: the "standard model" endorsed by modern style sheets is essentially a two-century-old design that has never been re-derived from first principles. That licenses the redesign sequence that follows.

### Step 1 — erase the box (p. 127)

"The box can be erased:" (p. 127). The figure shows the same bar chart with the surrounding frame removed; the vertical axis line (with ticks) and the baseline remain.

### Step 2 — erase the vertical axis, keep the ticks (p. 127)

"And the vertical axis, except for the ticks:" (p. 127). The figure now shows only three small free-floating tick marks at the left, the baseline, and the bars.

### Step 3 — erase part of the data measures: the white grid (p. 127)

> "Even part of the data measures can be erased, making a *white grid*, which shows the coordinate lines more precisely than ticks alone:" (p. 127)

The figure shows the bars with thin horizontal **white lines cut through them** at the 5%, 10%, and 15% levels; the labels "5%," "10%," "15%" with small ticks sit to the left. This is the chapter's most radical erasing move: ink is removed from the *data measures themselves*, and the absence of ink becomes the grid. The white grid is superior to ticks because it marks the coordinate level across the entire width of the display, exactly where the bars are, rather than only at the margin. (The bars in the example run from roughly 3% to about 18%, with the tallest bar near the middle of the sequence.)

### Step 4 — the white grid eliminates the ticks (p. 128)

> "The white grid eliminates the tick marks, since the numerical labels on the vertical are tied directly to the white lines:" (p. 128)

The figure repeats the white-grid chart with the ticks now gone: just the labels 5%, 10%, 15% aligned to the white lines, the bars, and the baseline.

### Step 5 — the baseline question (p. 128)

Tufte weighs erasing the baseline, acknowledging both a virtue and a defect of keeping it:

> "Although the intersection of the thicker bar with the thinner baseline creates an attractive visual effect (but also the optical illusion of gray dots at the intersections), the baseline can be erased since the bars define the end-point at the bottom:" (p. 128)

The figure shows the chart with no baseline at all — bars hanging free, aligned at their bottoms. Then a final concession and figure:

> "Still, a thin baseline looks good:" (p. 128)

The closing figure restores a thin baseline under the white-grid bars. The sequence thus ends not with the maximally erased version but with the *reasonably* maximized one — a live demonstration of the p. 124 principle that aesthetic criteria pick among the erasure-generated candidates. The parenthetical about "gray dots at the intersections" is a perceptual-psychology aside (a Hermann-grid-type illusion produced where thick bars cross a thin line) of the kind treated at length in Chapter 5's discussion of moiré vibration.

### Summary of the redesigned bar chart and its generalization (p. 129)

> "Erasing and data-ink maximizing have induced changes in the plain old bar chart. The techniques — no frame, no vertical axis, no ticks, and the white grid — apply to other designs:" (p. 129)

The generalization is demonstrated on a published computer graphic, reproduced in full: **"Variable Width Notched Box Plot"** from the statistical literature. Sidenote citation (p. 129): "Robert McGill, John W. Tukey, and Wayne A. Larsen, 'Variations of Box Plots,' *American Statistician*, 32 (1978), 12–16."

The original, as reproduced: a machine-lettered plot titled "Variable Width Notched Box Plot," with the y-axis labeled "1 Month's Telephone Bill ($)" on a logarithmic scale (gridless axis labeled at values up to 100), a full vertical axis, frame elements, and six notched boxes of varying width plotted against categories of "Years Lived in Chicago" (groups running from under 1 year up to "over 15"). Its all-caps machine caption reads: "Telephone Bill vs Years Lived in Chicago / Non-overlapping Notches Indicate Significant Difference at Rough 95% Level / Width of Box Proportional to Root Group Size / NOTE — Y Axis Scale is Logarithmic." So the original is itself a sophisticated multivariate design (location, spread, group size via width, and significance via notches), but rendered with heavy non-data apparatus and clotted computer lettering — the same fabrication defects diagnosed in Chapter 5's "We-Used-A-Computer-To-Build-A-Duck Syndrome" (p. 120).

Below it Tufte presents his redesign, unlabeled, applying the bar-chart techniques: no frame, no vertical axis line, no ticks; the y-scale reduced to bare numerals 5, 10, 20, 40, 80 (preserving the logarithmic spacing); each group drawn as a thin vertical line spanning its full data range, a short horizontal dash at the median, and a **gray band of varying width** over the middle half of the distribution — the width still proportional to the square root of group size, so no statistical content is lost. The "over 15" group, which in the original is the widest box with a low median, appears in the redesign as a wide but vertically compact gray mark near the bottom. The redesign demonstrates that the erasing techniques are portable: they were derived on the bar chart but immediately improve an entirely different, more advanced design.

## Redesign of the Scatterplot: The Range-Frame (p. 130–131)

### The standard bivariate scatterplot (p. 130)

Under the heading "Redesign of the Scatterplot": "Consider the standard bivariate scatterplot:" (p. 130). The figure shows roughly thirteen points with a positive association (a cluster in the lower left, a few points running up to the upper right), framed by a conventional vertical axis line and horizontal axis line that extend beyond the data in both directions.

### The key insight and the trimming rule (p. 130)

The central paragraph, in full:

> "A useful fact, brought to notice by the maximization and erasing principles, is that the frame of a graphic can become an effective data-communicating element simply by erasing part of it. The frame lines should extend only to the measured limits of the data rather than, as is customary, to some arbitrary point like the next round number marking off the grid and grid ticks of the plot. That part of the frame exceeding the limits of the observed data is trimmed off:" (p. 130)

The figure repeats the scatterplot with the axis lines now starting exactly at the minimum observed value and stopping exactly at the maximum observed value of each variable.

### Naming and assessing the range-frame (p. 130)

> "The result, a *range-frame*, explicitly shows the maximum and minimum of both variables plotted (along with the range), information available only by extrapolation and visual estimation in the conventional design. The data-ink ratio has increased: some non-data-ink has been erased, and the remainder of the frame, now carrying information, has gone over to the side of data-ink." (p. 130)

Note the two distinct mechanisms by which the data-ink ratio rises: (a) erasure shrinks the denominator (total ink), and (b) *conversion* — the surviving frame ink switches categories from non-data-ink to data-ink, growing the numerator. The range-frame is the chapter's purest example of conversion rather than mere deletion.

### The annotated diagram (p. 131)

Page 131 opens with an explanatory diagram: the same scatterplot with dashed guide lines and labels showing that the top of the vertical frame line aligns with the highest point ("max Yᵢ"), the bottom with the lowest ("min Yᵢ"), and the ends of the horizontal frame line align with "min Xᵢ" and "max Xᵢ." Bracket marks beneath the horizontal frame emphasize that the line itself spans exactly the x-range of the data. The diagram is the design's complete decoding key — four labels suffice.

### How small the change is (p. 131)

> "Nothing but the tails of the frame need change:" (p. 131)

This introduces a stacked two-panel comparison: the same scatter of about twenty points drawn twice, the upper panel labeled "Conventional Scatterplot" (axes with ticks, extending past the data) and the lower labeled "Range-Frame" (identical except the frame lines stop at the data extremes). The visual point: the difference between the conventional design and the information-bearing design is nearly invisible as a matter of drawing effort, yet the informational difference is categorical.

### The case for adoption (p. 131)

> "A range-frame does not require any viewing or decoding instructions; it is not a graphical puzzle and most viewers can easily tell what is going on. Since it is more informative about the data in a clear and precise manner, the range-frame should replace the non-data-bearing frame in many graphical applications." (p. 131)

This paragraph pre-answers the "audience confusion" objection that the conclusion takes up generally (p. 136, point 3), and it foreshadows the "graphical puzzle" worry that opens Chapter 7's discussion of multifunctioning elements.

## The Quartile-Plot Frame and One-Dimensional Range-Frames (p. 132)

### From range-frame to quartile plot (p. 132)

> "A small shift in the remaining ink turns each range-frame into a quartile plot:" (p. 132)

Here the box-plot redesign from p. 124 pays off exactly as promised. The figure shows the scatterplot with each frame line redrawn as an offset quartile plot: the vertical frame line is broken with its middle half offset, and the horizontal frame line likewise. The accounting:

> "Erasing and editing has led to the display of ten extra numbers (the minimum, maximum, two quartiles, and the median for both variables). The design is useful for analytical and exploratory data analysis, as well as for published graphics where summary characterizations of the marginal distributions have interest. The design is nearly always better than the conventionally framed scatterplot." (p. 132)

"Ten extra numbers" counts five summary statistics × two variables. The progression so far on the scatterplot frame: conventional frame (0 numbers) → range-frame (4 numbers: two minima, two maxima) → quartile-plot frame (10 numbers).

### One-dimensional range-frames on time-series (p. 132)

> "Range-frames can also present ranges along a single dimension. Here the historical high and low are shown in the vertical frame. This is an excellent practice and should be used widely in all sorts of displays, both scientific and unscientific:" (p. 132)

The figure (updated for the second edition) is a time-series line chart of a percentage-like quantity over roughly a decade, with x-axis tick marks at fine intervals and year labels 1996, 1998, 2000, 2002, 2004, 2006. Identical vertical scales appear on both the left and right, labeled 4.0, 6.0, 8.0, 10.0. The data line starts near 4, climbs to a plateau around 6–6.5 by 1998–2000, dips, spikes to a peak near 9 in 2002–2003, then declines with small oscillations to about 6 by the end. The crucial design feature: the vertical frame lines on each side span only from the series' historical low to its historical high — so the frame itself reports the record extremes — and the 10.0 label sits beyond the end of the frame line with only a detached tick, because the data never reached it. The reader can see at a glance that the 2002–2003 peak is the all-time high of the plotted period.

## The Dot-Dash-Plot (p. 133–134)

### Turning the entire frame into data (p. 133)

> "Finally, the entire frame can be turned into data by framing the bivariate scatter with the marginal distribution of each variable. The *dot-dash-plot* results.¹" (p. 133)

Footnote 1, verbatim: "The terminology follows tradition, for scatterplots were once called 'dot diagrams' — for example, in R. A. Fisher's *Statistical Methods for Research Workers* (Edinburgh, 1925)." (So "dot" = the scatter points, "dash" = the marginal tick-marks.)

The figure: a scatter of roughly fifty points with positive correlation. Along the left edge runs a vertical **fringe of short horizontal dashes**, one dash at the y-value of every observation; along the bottom edge runs a horizontal fringe of short vertical dashes, one at every x-value. Where observations bunch, the dashes pile into dense bands, so each fringe is a visible one-dimensional frequency distribution. One point is labeled "(xᵢ, yᵢ)," with dashed projection lines running left to its dash at "yᵢ" on the vertical fringe and down to its dash at "xᵢ" on the horizontal fringe — showing that every dot generates exactly one dash on each axis. This completes the frame progression: 0 numbers → 4 → 10 → the *entire marginal distribution* of both variables (2n numbers for n observations).

### What the design accomplishes (p. 133)

> "The dot-dash-plot combines the two fundamental graphical designs used in statistical analysis, the marginal frequency distribution and the bivariate distribution. Dot-dash-plots make routine what good data analysts do already — plotting marginal and joint distributions together." (p. 133)

Two claims here: a structural one (the design unifies the two foundational displays of statistics in a single graphic, with no added apparatus — the marginals live where dead frame used to be) and a practice-based one (the design merely automates established best practice among skilled analysts, so it is not an eccentric novelty).

### Precedent 1: Cuthbert Daniel's residual plot (p. 133)

> "An empirical cumulative distribution of residuals on a normal grid shows the outer 18 terms plus the 30th term, with all 60 points plotted in the marginal distribution:" (p. 133)

The reproduced figure is a normal-probability plot: the horizontal axis is a cumulative-percentage scale with normal-grid spacing (labeled .01, .05, .1, .5, 1, 2, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 98, 99, 99.5), the vertical axis is the residual value (running from about −27 to about +35), a straight fitted line runs corner to corner, and the plotted points (the 9 largest and 9 smallest residuals plus the 30th-ranked one — 19 points) fall close to the line. Down the left margin, all 60 residuals appear as a fringe of dashes — the full marginal distribution accompanying the selective bivariate plot. Sidenote citation: "Cuthbert Daniel, *Applications of Statistics to Industrial Experimentation* (New York, 1976), p. 155."

### Precedent 2: the pulsar graphic (p. 134)

> "Similarly, this data-rich graphic of signals from pulsars shows both marginal distributions:" (p. 134)

Sidenote citation: "Timothy H. Hankins and Barney J. Rickett, 'Pulsar Signal Processing,' in Berni Alder, et al., eds., *Methods in Computational Physics, Volume 14: Radio Astronomy* (New York, 1975), p. 108."

The reproduced figure has three linked panels. The central panel is a dense stack of horizontal spectral traces — narrowband spectra of individual pulsar subpulses — with time (0 to 10 milliseconds, labeled "TIME (Msec)") running up the left side and frequency along the bottom (a bracket marking "125 kHz" of bandwidth centered at "111.5 MHz," labeled "FREQUENCY"); a small box labeled "RESOLUTION CELL" indicates the measurement granularity. The right panel plots, as a jagged vertical profile, the intensity summed across the receiver bandwidth at each moment of time (the time-marginal). The top panel plots the spectrum averaged over the whole pulse (the frequency-marginal). The figure's original caption is reproduced beneath it: "Narrowband spectra of individual subpulses. Each point of the intensity Iᵥ(t) plotted on the right is the sum of the distribution of intensities across the receiver bandwidth shown in the center. At the top is plotted the spectrum averaged over the pulse. In the limit of many thousands of pulses this would show the receiver bandpass shape."

The two precedents serve the argument symmetrically: Daniel shows the marginal-plus-joint idiom in statistics, Hankins–Rickett shows it in physical science — establishing that the dot-dash-plot formalizes a practice already proven in serious work.

## The Rugplot (p. 135)

> "The fringe of dashes in the dot-dash-plot can connect a series of bivariate scatters in a *rugplot* (since it resembles a set of fringed rugs — and covers the statistical ground):" (p. 135)

The figure: six rectangular scatterplot panels tiled edge-to-edge in a meandering, stair-stepping arrangement down the page (one panel at top right, two side-by-side below it, a tall panel at center with another at its left, and one at the bottom). Each adjacent pair of panels shares a variable along their common edge, and the dot-dash fringes of dashes sit along the shared and outer edges, carrying each panel's one-dimensional projections. Dashed lines inside the panels trace a single observation's coordinates from panel to panel, demonstrating that one case can be followed through the whole chain. The pun in the name is Tufte's own: it looks like fringed rugs *and* "covers the statistical ground."

The closing paragraph of the design sections, in full (p. 135):

> "Reflecting the one-dimensional projections from each scatter, the dashes encourage the eye to notice how each plot filters and translates the data through the scatter from one adjacent plot to the next. Sometimes it is useful to think of each bivariate scatter as the imperfect empirical representation of an underlying curve that transforms one variable into another. In the rugplot, the sequence of variables can wander off as appropriate. The quantitative history of a single observation can be traced through a series of one- and two-dimensional contexts."

Three conceptual points packed in here: (1) a *reading* model — each panel acts as a filter/translator of the data into the next variable; (2) a *statistical* model — each empirical scatter approximates an underlying functional transformation between variables; (3) a *flexibility* claim — unlike a fixed scatterplot matrix, the rugplot's chain of variables can meander freely, and any single observation's full multivariate history remains traceable.

## Conclusion to the Theory of Data Graphics, Chapters 4–6 (p. 136–137)

The section headed "Conclusion" closes not just this chapter but the three-chapter data-ink sequence.

### The theory and its scope (p. 136)

> "The first part of a theory of data graphics is in place. The idea, as described in the previous three chapters, is that most of a graphic's ink should vary in response to data variation. The theory has something to say about a great variety of graphics — workaday scientific charts, the unique drawings of Roger Hayward, the exemplars of graphical handbooks, newspaper displays, computer graphics, standard statistical graphics, and the recent inventions of Chernoff and Tukey." (p. 136)

(Roger Hayward's drawings, handbook exemplars, newspaper displays, Chernoff faces, and Tukey's box plots were all treated in Chapters 4–6; the list asserts the theory's breadth across that material.)

### The measured gains (p. 136)

> "The observed increases in efficiency, in how much of the graphic's ink carries information, are sometimes quite large. In several cases, the data-ink ratio increased from .1 or .2 to nearly 1.0. The transformed designs are less cluttered and can be shrunk down more readily than the originals." (p. 136)

Two distinct benefits: the five-to-ten-fold ratio improvement, and the practical consequence that high-data-ink designs miniaturize well (a thread Tufte develops further with small multiples and, in later books, sparklines).

### The central question and four answers (p. 136)

> "But, are the transformed designs *better*?" (p. 136)

**(1) Better by the theory's own standard, and the standard matters historically.**

> "They are necessarily better within the principles of the theory, for more information per unit of space and per unit of ink is displayed. And this is significant; indeed, the history of devices for communicating information is written in terms of increases in efficiency of communication and production." (p. 136)

Tufte concedes the circularity ("necessarily better *within* the principles") and then breaks out of it with the historical claim: efficiency is not an arbitrary criterion but the criterion by which communication technologies have always advanced.

**(2) The principles power revision, and revision powers quality.**

> "Graphics are almost always going to improve as they go through editing, revision, and testing against different design options. The principles of maximizing data-ink and erasing generate graphical alternatives and also suggest a direction in which revisions should move." (p. 136)

The claim is that the theory's value is procedural even where its outputs are debatable: it produces candidate designs (generation) and an improvement gradient (direction).

**(3) The audience objection, answered.**

> "Then there is the audience: will those looking at the new designs be confused? Some of the designs are self-explanatory, as in the case of the range-frame. The dot-dash-plot is more difficult, although it still shows all the standard information found in the scatterplot. Nothing is lost to those puzzled by the frame of dashes, and something is gained by those who do understand. Moreover, it is a frequent mistake in thinking about statistical graphics to underestimate the audience. Instead, why not assume that if you understand it, most other readers will, too? Graphics should be as intelligent and sophisticated as the accompanying text." (p. 136)

The argument has three layers: a dominance argument for the dot-dash-plot (the puzzled lose nothing, the perceptive gain something — the design weakly dominates the conventional one), an empirical charge that designers systematically underestimate readers, and the maxim that graphic and prose should be held to the same intellectual standard.

**(4) Oddness is mere unfamiliarity, and it decays with exposure.**

> "Some of the new designs may appear odd, but this is probably because we have not seen them before. The conventional designs for statistical graphics have been viewed thousands of times by nearly every reader of this book; on the other hand, the range-frame, the dot-dash-plot, the white grid, the quartile plot, the rugplot, and the half-face just a few times. With use, the new designs will come to look just as reasonable as the old." (p. 136)

(The "half-face" refers to Tufte's Chapter 4 redesign of Chernoff faces, where erasing the symmetric half of each face loses no information; its inclusion here confirms it belongs to the same family of erasure-derived designs.)

### The final caveat (p. 137)

The chapter and the conclusion end with a single paragraph, set alone on the page, that bounds the entire theory:

> "Maximizing data ink (within reason) is but a single dimension of a complex and multivariate design task. The principle helps conduct experiments in graphical design. Some of those experiments will succeed. There remain, however, many other considerations in the design of statistical graphics — not only of efficiency, but also of complexity, structure, density, and even beauty." (p. 137)

This is the formal limit-statement of the data-ink theory: the principle is an experiment-generator, not a complete decision procedure; "some" experiments succeed (not all); and four named considerations sit outside it — complexity, structure, density, beauty. The phrase "within reason" carries forward the "*reasonable* data-ink maximizing" of p. 124, and "complexity" and "structure" point ahead to Chapter 7 ("Multifunctioning Graphical Elements"), which opens by warning that multifunctioning elements "tend to generate graphical puzzles, with encodings that can only be broken by their inventor" and that "design techniques for enhancing graphical clarity in the face of complexity must be developed along with multifunctioning elements" (p. 139).

## Reference Tables

### New designs introduced in this chapter

| Design | Derived from | What the ink now encodes | Page |
|---|---|---|---|
| Quartile plot | Tukey box plot / Spear range bar | Min, lower quartile, median (dot), upper quartile, max; preferred form offsets the middle half | 124 |
| Erased parallel schematic plot | Parallel box plots | Ten five-number summaries with 10 straightedge placings instead of 80 | 125 |
| White-grid bar chart | Standard bar chart | Bars only; coordinate lines as white gaps through the bars; no frame, axis, or ticks; optional thin baseline | 127–128 |
| Redesigned variable-width notched box plot | McGill–Tukey–Larsen plot | Range line, median dash, gray middle-half band with width ∝ √(group size), bare log-scale numerals | 129 |
| Range-frame | Conventional scatterplot frame | Min, max, and range of both variables (4 numbers) | 130–131 |
| One-dimensional range-frame | Time-series vertical axis | Historical high and low of the series | 132 |
| Quartile-plot frame | Range-frame | Five-number summary of both variables (10 numbers) | 132 |
| Dot-dash-plot | Quartile-plot frame | Full marginal distribution of both variables as fringes of dashes | 133 |
| Rugplot | Dot-dash-plot fringes | Chains of bivariate scatters sharing variables; traceable observation histories | 135 |

### Quantities cited in the chapter

| Quantity | Value | Page |
|---|---|---|
| Straightedge placings, box plot vs. quartile plot | 6 vs. 1 | 124 |
| Straightedge placings, parallel schematic plot original | 80 (50 horizontals + 30 verticals) | 125 |
| Straightedge placings, erased version | 10 verticals | 125 |
| Playfair Scotland chart: period covered | Christmas 1780 to Christmas 1781 | 126 |
| Playfair chart: grid divisions | £10,000 each | 126 |
| White-grid labels in bar-chart example | 5%, 10%, 15% | 127–128 |
| Notched box plot: significance level of non-overlapping notches | rough 95% | 129 |
| Notched box plot: box width proportional to | square root of group size | 129 |
| Extra numbers shown by quartile-plot frame | 10 (min, max, two quartiles, median × 2 variables) | 132 |
| Daniel residual plot: points in bivariate plot | outer 18 terms + 30th term | 133 |
| Daniel residual plot: points in marginal distribution | all 60 | 133 |
| Pulsar plot: time span / bandwidth / center frequency | 0–10 msec / 125 kHz / 111.5 MHz | 134 |
| Data-ink ratio improvement across the three chapters | from .1 or .2 to nearly 1.0 | 136 |

### Sources cited (sidenotes and footnote)

| Source | Cited for | Page |
|---|---|---|
| Ad Reinhardt, statement for "The New Decade: 35 American Painters and Sculptors," Whitney Museum of American Art, New York, 1955 | Epigraph | 122 |
| Mary Eleanor Spear, *Charting Statistics* (New York, 1952), p. 166 | Range bar | 123 |
| John W. Tukey, *Exploratory Data Analysis* (Reading, Massachusetts, 1977) | Box plot | 123 |
| Robert McGill, John W. Tukey, and Wayne A. Larsen, "Variations of Box Plots," *American Statistician*, 32 (1978), 12–16 | Variable width notched box plot | 129 |
| R. A. Fisher, *Statistical Methods for Research Workers* (Edinburgh, 1925) | "Dot diagrams" terminology (footnote 1) | 133 |
| Cuthbert Daniel, *Applications of Statistics to Industrial Experimentation* (New York, 1976), p. 155 | Residuals plot with marginal distribution | 133 |
| Timothy H. Hankins and Barney J. Rickett, "Pulsar Signal Processing," in Berni Alder, et al., eds., *Methods in Computational Physics, Volume 14: Radio Astronomy* (New York, 1975), p. 108 | Pulsar graphic with both marginals | 134 |
