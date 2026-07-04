# Chapter 4: Data-Ink and Graphical Redesign — Detailed Reference

This file is a maximally complete account of Chapter 4 of Edward Tufte, *The Visual Display of Quantitative Information* (2nd ed.), printed pages 91–105, plus the chapter's facing epigraph (p. 90) and the epigraph that bridges into Chapter 5 (p. 106). Chapter 4 opens Part II of the book, "Theory of Data Graphics" (the running header on even pages throughout the chapter reads "THEORY OF DATA GRAPHICS"; on odd pages it reads "DATA-INK"). Where exact phrasing matters, Tufte is quoted verbatim. Every figure is described in detail, since the figures *are* much of the argument.

## Chapter Arc

The chapter builds Tufte's theory of data graphics from a single foundation — "Above all else show the data" — and derives from it an operational measure (the data-ink ratio), an optimization principle (maximize that ratio), two erasing principles (erase non-data-ink; erase redundant data-ink), and a working method (revise and edit, like a prose editor). The argument proceeds almost entirely by paired before/after graphics: Playfair correcting himself (pp. 91–92); four benchmark graphics spanning the ratio from 1.0 down to a "graphical absolute zero" (pp. 93–95); the principles stated (p. 96); redundancy anatomized and then partially rehabilitated (pp. 96–100); and two extended redesign case studies — a psychology bar chart pruned by erasing alone (pp. 100–102), and Pauling's atomic-volume chart taken through a full cycle of erasing, testing, and reinvestment (pp. 102–105). The chapter closes with the five principles listed together (p. 105).

## Epigraph (p. 90, facing the chapter opening)

The page facing the chapter title carries a single quotation, set in italics:

> "Everyone spoke of an information overload, but what there was in fact was a non-information overload."
>
> — Richard Saul Wurman, *What-If, Could-Be* (Philadelphia, 1976)

The epigraph frames the chapter's diagnosis in advance: the problem with most graphics is not too much information but too much ink that carries none.

## Above All Else Show the Data: Playfair's Self-Correction (pp. 91–92)

The chapter opens (p. 91) with a statement of purpose for the whole theory:

> "Data graphics should draw the viewer's attention to the sense and substance of the data, not to something else. The data graphical form should present the quantitative contents. Occasionally artfulness of design makes a graphic worthy of the Museum of Modern Art, but essentially statistical graphics are instruments to help people reason about quantitative information." (p. 91)

Three claims are packed in here: (1) attention belongs on the data, not on the apparatus or the design; (2) form serves quantitative content; (3) art is an occasional bonus, not the point — graphics are *instruments for reasoning*.

Tufte's first evidence is historical and self-correcting: William Playfair, the inventor of the statistical time-series chart, got it wrong at first and fixed it himself within a year.

**Figure: Playfair's 1785 chart (p. 91).** "Playfair's very first charts devoted too much of their ink to graphical apparatus, with elaborate grid lines and detailed labels" (p. 91). The figure reproduces, in color, a time-series engraved in August 1785 from the early pages of *The Commercial and Political Atlas*: "CHART of IMPORTS and EXPORTS of ENGLAND to and from all NORTH AMERICA From the Year 1770 to 1782 by W. Playfair." Its visual construction: a dense ruling of fine horizontal grid lines covers the entire plot, with the right-hand edge carrying an extremely detailed scale labeled in tenths of millions of pounds (4,200,000 / 4 Millions at the top, down through 3,200,000 / 3 Millions, 2,200,000 / 2 Millions, 1,100,000 / 1 Million, to 100,000 at the bottom — with every intermediate tenth labeled, e.g. 3.9, 3.8, 3.7 …). Years 1770–1782 run along the bottom. Two hand-colored curves cross the field — a "Line of Exports to N. America" and a "Line of Imports from America" — with the regions between them shaded and labeled "BALLANCE in FAVOUR of ENGLAND" (large yellow areas at upper left and lower right) and, in a small pink lens around 1775–76 where the lines cross during the American Revolution, "Ballance against England." Beneath the frame the engraved caption reads "The Bottom Line is divided into Years the right-hand Line into HUNDRED THOUSAND POUNDS," with the engraver's credit "J. Ainslie Sculp.t" at lower left and "Publish'd as the Act directs 20.th Aug.t 1785" at lower right. The chart's problem is exactly what the caption advertises: the fine-grained grid and exhaustive right-edge labels — apparatus for reading off precise values — dominate the ink.

**Figure: Playfair's 1786 chart (p. 92).** "Within a year Playfair had eliminated much of the non-data detail in favor of cleaner design that focused attention on the time-series itself. He then began working with a new engraver and was soon producing clear and elegant displays" (p. 92). The figure reproduces "Exports and Imports to and from DENMARK & NORWAY from 1700 to 1780." Its construction: a sparse grid of horizontal lines at intervals of £10,000 (right edge labeled 10 through 190, with a heavier line at 100,000) and vertical lines at each decade 1700–1780; two curves, the "Line of Imports" and "Line of Exports," with the region where imports exceed exports (roughly 1700 to the mid-1750s) shaded pink and labeled "BALANCE AGAINST," and the region after the crossover (mid-1750s to 1780, where exports surge) shaded yellow-green and labeled "BALANCE in FAVOUR of ENGLAND." Caption beneath: "The Bottom line is divided into Years, the Right hand line into L10,000 each." Imprints: "Published as the Act directs, 1st May 1786, by Wm. Playfair" and "Neele sculpt 352, Strand, London." Compared with the 1785 chart, the grid is far lighter, the labels far fewer, and the eye goes straight to the two curves and the colored balance between them.

The pair yields the foundation of the entire theory (p. 92):

> "This improvement in graphical design illustrates the fundamental principle of good statistical graphics:
>
> Above all else show the data.
>
> The principle is the basis for a theory of data graphics." (p. 92)

Note the rhetorical move: the founder of the genre is shown editing himself, so the chapter's later insistence on revision and editing is grounded in the very origin of statistical graphics.

## Data-Ink (p. 93)

The section headed "Data-Ink" defines the chapter's central term and measure:

> "A large share of ink on a graphic should present data-information, the ink changing as the data change. *Data-ink* is the non-erasable core of a graphic, the non-redundant ink arranged in response to variation in the numbers represented." (p. 93)

Two operational tests are embedded in the definition: data-ink (1) *changes as the data change* and (2) is *non-erasable* — removing it loses data-information. "Non-redundant" is also built into the definition, which is what later licenses the second erasing principle.

Then the measure, given in three equivalent formulations exactly as printed (p. 93):

> Data-ink ratio = data-ink / total ink used to print the graphic
>
> = proportion of a graphic's ink devoted to the non-redundant display of data-information
>
> = 1.0 − proportion of a graphic that can be erased without loss of data-information.

The third formulation is the practical one: it converts the ratio into an erasing test. Whatever can be erased without losing data-information is, by definition, not data-ink.

## The Data-Ink Ratio in Practice: Five Benchmark Graphics (pp. 93–95)

Tufte calibrates the ratio with five real published graphics spanning its full range — approximately 1.0, roughly 0.8–0.9, roughly 0.7, near 0.0, and exactly 0.0. The last three are the *same data* published three times, which isolates design as the only variable.

### Ratio ≈ 1.0: the electroencephalogram (p. 93)

> "A few graphics use every drop of their ink to convey measured quantities. Nothing can be erased without losing information in these continuous eight tracks of an electroencephalogram. The data change from background activity to a series of polyspike bursts. Note the scale in the bottom block, lower right." (p. 93)

**Figure (p. 93):** Three stacked blocks of EEG traces, eight channels each, reading continuously in time across the blocks. The first block carries channel labels at left — LF-LM, RF-RM, LM-LO, RM-RO, LT-LM, RT-RM, LT-LO, RT-RO (left/right frontal, mid, occipital, temporal electrode pairs) — and a marker "M 7." The first block shows low-amplitude background activity; the second and third blocks show progressively larger, spikier waveforms — the polyspike bursts. A small scale mark sits in the lower right of the bottom block; even the scale earns Tufte's note because it is the only non-trace ink present. Source (margin note): Kenneth A. Kooi, *Fundamentals of Electroencephalography* (New York, 1971), p. 110. The EEG is the limiting case: essentially every mark is a measurement, so the data-ink ratio is at or near 1.0.

### Ratio ≈ 0.8–0.9: Bonner's size-and-cycle scatterplot (p. 94)

> "Most of the ink in this graphic is data-ink (the dots and labels on the diagonal), with perhaps 10–20 percent non-data-ink (the grid ticks and the frame)." (p. 94)

**Figure (p. 94):** A double-logarithmic scatterplot. Vertical axis "LENGTH," scaled 1μ, 10μ, 100μ, 1mm, 1cm, 10cm, 1M, 10M, 100M (microns to 100 meters); horizontal axis "GENERATION TIME," scaled 1 hour, 1 day, 1 week, 1 month, 1 year, 10 years, 100 years. Each point is a labeled organism, and the points run up the diagonal from bacteria to trees: B. Aureus, Pseudomonas, E. Coli at the lower left; then Spirochaeta, Euglena, Didinium, Tetrahymena, Paramecium, Stentor, Daphnia, Drosophila, House Fly, Horse Fly, Bee, Clam, Oyster, Snail, Chameleon, Frog, Scallop, Newt, Starfish, Turtle, Mouse, Crab, Lemming, Salamander, Horseshoe Crab, Rat, Fox, Beaver, Snake, Deer, Bear, Man, Elk, Rhino, Elephant, Dog-wood, Balsam, Kelp, Whale, Birch, Fir, Sequoia at the upper right. An interior caption reads: "The length of an organism at the time of reproduction in relation to the generation time, plotted on a logarithmic scale." Source (margin note): John Tyler Bonner, *Size and Cycle: An Essay on the Structure of Biology* (Princeton, 1965), p. 17. Here the labels count as data-ink — they identify each observation — so nearly all ink is data; only the tick marks and frame are not.

### Ratio ≈ 0: the grid sea (p. 94)

> "In this display with nearly all its ink devoted to matters other than data, the grid sea overwhelms the numbers (the faint points scattered about the diagonal)." (p. 94)

**Figure (p. 94):** The original publication of "Relationship of Actual Rates of Registration to Predicted Rates (104 cities 1960)." Vertical axis "PREDICTED" (letters stacked vertically), horizontal axis "ACTUAL," both running roughly 30.0 to 100.0 in increments of 5. The entire plotting field is filled with a dense, dark cross-hatched mesh of grid lines — the "grid sea." A 45° diagonal line crosses the field (with a small arc-and-arrow marking the 45° angle near the lower left), and the 104 data points are barely visible as faint specks near the diagonal. Nearly all the ink is grid.

### Ratio ≈ 0.7: the same data, replotted (p. 95)

> "Another published version of the same data drove the share of data-ink up to about 0.7, an improvement." (p. 95)

**Figure (p. 95):** The identical scatter — actual versus predicted registration rates for 104 cities in 1960 — redrawn with no grid at all: plain horizontal and vertical axes with tick marks, "PREDICTED" on the vertical axis labeled 30–100 by tens, "ACTUAL" on the horizontal labeled 40–100 by tens, the cloud of points plotted as solid dots clustered about the diagonal (mostly in the 60–95 range), the 45° line drawn through them with a small "45°" arc-and-arrow annotation at its foot. Caption beneath: "Relationship of Actual Rates of Registration to Predicted Rates (104 cities 1960)." With the grid gone, the points and diagonal carry most of the ink.

### Ratio = 0: the graphical absolute zero (p. 95)

> "But a third reprint publication of the same figure forgot to plot the points and simply retraced the grid lines from the original, including the excess strip of grid along the top and right margins. The resulting figure achieves a graphical absolute zero, a null data-ink ratio." (p. 95)

**Figure (p. 95):** Labeled "Figure 19.1 Relationship of Actual Rates of Registration to Predicted Rates (104 cities, 1960)." A clean rectangular grid at intervals of 5 from 30.0 to 100.0 on both axes ("Predicted" vertical, "Actual" horizontal), the 45° diagonal line with its little arc-and-arrow annotation — and *no data points whatsoever*. The retracing even preserved the original's accidental extra strip of grid beyond the data region along the top and right margins, evidence of mechanical copying without looking at the data. This is the reductio of low-data-ink design: a "data graphic" containing zero data.

**Margin note (p. 95)** giving the publication history of all three versions: "The three graphics were published in, respectively, Stanley Kelley, Jr., Richard E. Ayres, and William G. Bowen, 'Registration and Voting: Putting First Things First,' *American Political Science Review*, 61 (1967), 371; then reprinted in Edward R. Tufte, ed., *The Quantitative Analysis of Social Problems* (Reading, Mass., 1970), p. 267; and reprinted again in William J. Crotty, ed., *Public Opinion and Politics: A Reader* (New York, 1970), p. 364." (The 0.7 version is thus from Tufte's own 1970 edited volume; the null version is Crotty's reprint.)

## Maximizing the Share of Data-Ink (p. 96)

With the measure calibrated, Tufte states the optimization principle:

> "The larger the share of a graphic's ink devoted to data, the better (other relevant matters being equal):
>
> Maximize the data-ink ratio, within reason.
>
> Every bit of ink on a graphic requires a reason. And nearly always that reason should be that the ink presents new information." (p. 96)

Note the two qualifications built into the statement: "other relevant matters being equal" and "within reason" — the principle is a default, not an absolute, and the chapter itself will later demonstrate the exceptions (Marey's repeated half-cycle, Pauling's reference curves).

Tufte then bounds the principle's scope honestly (p. 96): "The principle has a great many consequences for graphical editing and design. The principle makes good sense and generates reasonable graphical advice — for perhaps two-thirds of all statistical graphics. For the others, the ratio is ill-defined or is just not appropriate. Most important, however, is that other principles bearing on graphical design follow from the idea of maximizing the share of data-ink." So: (1) the principle applies to roughly two-thirds of statistical graphics; (2) for the remaining third the ratio is ill-defined or inappropriate; (3) its chief value is generative — other design principles (the erasing principles here, the chartjunk critique of Chapter 5, the data-density and multifunctioning-element ideas of later chapters) derive from it.

## Two Erasing Principles (pp. 96–100)

### First erasing principle: erase non-data-ink (p. 96)

> "The other side of increasing the proportion of data-ink is an erasing principle:
>
> Erase non-data-ink, within reason." (p. 96)

The justification: "Ink that fails to depict statistical information does not have much interest to the viewer of a graphic; in fact, sometimes such non-data-ink clutters up the data, as in the case of a thick mesh of grid lines. While it is true that this boring ink sometimes helps set the stage for the data action, it is surprising, as we shall see in Chapter 7, how often the data themselves can serve as their own stage." (p. 96) — a forward reference to Chapter 7 ("Multifunctioning Graphical Elements"), and an explicit concession that some non-data-ink legitimately "sets the stage," with the counter-claim that this is needed less often than designers assume.

### Redundant data-ink: the six-fold bar (pp. 96–97)

Tufte then defines the second category of erasable ink:

> "*Redundant data-ink* depicts the same number over and over." (p. 96)

**Figure (p. 96):** A single bar chart bar — shaded with a stipple pattern, standing on a horizontal baseline, with the number "35.9" printed above its top. Tufte enumerates how this one bar "unambiguously locates the altitude in six separate ways (any five of the six can be erased and the sixth will still indicate the height): as the (1) height of the left line, (2) height of shading, (3) height of right line, (4) position of top horizontal line, (5) position (not content) of number at bar's top, and (6) the number itself. That is more ways than are needed." (pp. 96–97). Note the precision of item (5): the *position* of the number encodes the value independently of its *content* — two encodings riding on one printed numeral.

> "Gratuitous decoration and reinforcement of the data measures generate much redundant data-ink." (p. 97)

**Figure (p. 97):** A specimen of decoration-driven redundancy: a series of ten bars for biennial periods labeled 1939-40, 1943-44, 1947-48, 1951-52, 1955-56, 1959-60, 1963-64, 1967-68, 1971-72, 1975-76 along the baseline, vertical axis labeled 20 through 120 by twenties. The values decline steadily from about 120 to about 25, but each "bar" is drawn with heavy dark shading and an ornamental concave swooping top — each one curving down like a sail or breaking wave into the next — so the data measure is reinforced and decorated far beyond need. (Tufte presents it without redesign, purely as a specimen.)

### Bilateral symmetry as redundancy (p. 97)

> "Bilateral symmetry of data measures also creates redundancy, as in the box plot, the open bar, and Chernoff faces." (p. 97)

**Figure (p. 97):** Side by side: a vertical box plot (box with median line and whiskers), an open (outline-only) bar, and two full Chernoff faces — cartoon faces whose feature parameters (eye size, brow slant, nose, mouth curvature, ear size, head shape) encode variables. To the right, two *half*-faces (left halves only: one eye, one brow, half a nose, half a mouth, one ear) demonstrate the alternative. In each of these designs the left half mirrors the right half, so half the ink repeats the other half.

The argument for halving (p. 97): "Half-faces carry the same information as full faces. Halves may be easier to sort (by matching the right half of an unsorted face to the left half of a sorted face) than full faces. Or else an asymmetrical full face can be used to report additional variables." So symmetry costs twice the ink and space for the same information, and abolishing it offers two distinct gains: easier sorting of half-faces, or doubled variable capacity in asymmetric full faces. **Footnote 1:** Bernhard Flury and Hans Riedwyl, "Graphical Representation of Multivariate Data by Means of Asymmetrical Faces," *Journal of the American Statistical Association*, 76 (December 1981), 757–765.

The perceptual evidence (p. 97): "Bilateral symmetry doubles the space consumed by the design in a graphic, without adding new information. The few studies done on the perception of symmetrical designs indicate that 'when looking at a vase, for instance, a subject would examine one of its symmetric halves, glance at the other half and, seeing that it was identical, cease his explorations. . . . The enjoyment of symmetry . . . lies not with the physical properties of the figure. At least eye movements suggest anything but symmetry, balance, or rest.'" **Footnote 2:** Leonard Zusne, *Visual Perception of Form* (New York, 1970), pp. 256–257. The point of the eye-movement evidence: viewers do not actually look at both halves, so the second half is wasted ink even perceptually.

### When redundancy earns its keep (pp. 98–99)

Before stating the second erasing principle, Tufte raises and answers the obvious objection — sometimes repetition helps:

> "Redundancy, upon occasion, has its uses: giving a context and order to complexity, facilitating comparisons over various parts of the data, perhaps creating an aesthetic balance. In cyclical time-series, for example, parts of the cycle should be repeated so that the eye can track any part of the cycle without having to jump back to the beginning." (p. 98)

Three legitimate uses, then, plus one design rule for cyclical data. Two examples follow.

**Figures: Marey's train schedule, original and extended (p. 98).** "Such redundancy possibly improves Marey's 1880 train schedule. Those people leaving Paris or Lyon in the evening find that their trains run off the right-hand edge of the chart, to be picked up on the left again." (p. 98). The first figure is É.-J. Marey's graphical Paris–Lyon timetable (introduced in Chapter 2 of the book): stations down the left margin spaced by distance — Paris, Montereau, Laroche, Tonnerre, Les Laumes, Dijon, Chagny, Mâcon, down to Lyon — and time of day across the top and bottom, running 6 (a.m.) through MIDI (noon) through MINUIT (midnight) back to 6, against a fine vertical ruling of hours and minutes; each train is a diagonal line whose slope shows its speed, descending lines for Paris→Lyon, ascending for Lyon→Paris. Evening trains hit the right edge mid-journey and must be re-found at the left edge. The second figure shows the cure: "Attaching an extra half cycle makes every train in the first 24 hours of the schedule a continuous line (as would mounting the original on a cylinder)." (p. 98). The redrawn schedule is half again as wide — 24 hours plus an appended 12-plus hours — so every train departing within the original day runs unbroken to its destination. The cylinder remark gives the geometric insight: the repetition is flat paper's substitute for the true topology of cyclic time.

**Figures: ocean currents, one and two-thirds times around the world (p. 99).** "And, similarly, instead of once around the world in this display of surface ocean currents, one and two-thirds times around is better." (p. 99). The first figure: a world map of a numerical model of ocean circulation, land masses rendered as solid black blocky (grid-cell) shapes, the oceans filled with contour lines of the circulation (transport streamfunction), latitudes marked 84°, 60°, 30°, 0°, 30°, 60°, 80° down the left and longitudes 60°, 120°, 180°, 120°, 60°, 0° along the bottom. Current systems — most visibly the dense circumpolar band near 60°S (the Antarctic Circumpolar Current) — are sliced at the map's left and right edges. The second figure repeats the map extended to about one and two-thirds circumnavigations, so every gyre and the circumpolar current appear whole somewhere in the display. Source (margin note): Kirk Bryan and Michael D. Cox, "The Circulation of the World Ocean: A Numerical Study. Part 1, A Homogeneous Model," *Journal of Physical Oceanography*, 2 (1972), 330. The principle generalizes Marey's: any data cyclic in a plotted dimension (time of day, longitude) deserves a repeated partial cycle so no feature is split by an arbitrary edge.

### Second erasing principle: erase redundant data-ink (p. 100)

The exception acknowledged, Tufte returns to the rule:

> "Most data representations, however, are of a single, uncomplicated number, and little graphical repetition is needed. Unless redundancy has a distinctly worthy purpose, the second erasing principle applies:
>
> Erase redundant data-ink, within reason." (p. 100)

The burden of proof sits with redundancy: it must show a "distinctly worthy purpose" (context for complexity, cross-part comparison, aesthetic balance, cycle continuity) or be erased.

## Application of the Principles in Editing and Redesign (pp. 100–105)

### Graphical editing as critical labour (p. 100)

The section opens with the chapter's governing analogy:

> "Just as a good editor of prose ruthlessly prunes out unnecessary words, so a designer of statistical graphics should prune out ink that fails to present fresh data-information. Although nothing can replace a good graphical idea applied to an interesting set of numbers, editing and revision are as essential to sound graphical design work as they are to writing." (p. 100)

Two balanced claims: editing cannot substitute for a good idea and good data, but neither is the idea complete without editing. Tufte supports the analogy with T. S. Eliot: "T. S. Eliot emphasized the 'capital importance of criticism in the work of creation itself. Probably, indeed, the larger part of the labour of an author in composing his work is critical labour; the labour of sifting, combining, constructing, expunging, correcting, testing: this frightful toil is as much critical as creative.'" (p. 100). **Footnote 3:** T. S. Eliot, "The Function of Criticism," in *Selected Essays 1917–1932* (New York, 1932), p. 18. Eliot's six gerunds — sifting, combining, constructing, expunging, correcting, testing — map directly onto what the next two case studies do to graphics.

### Case study 1: the taste-papillae bar chart — erasing 65 percent (pp. 100–102)

> "Consider this display, which compares each long bar with the adjacent short bar to show the viewer that, under the various experimental conditions, the long bar is longer." (p. 100)

The sentence is already a critique: the graphic's entire message is a set of pairwise "longer than" comparisons, yet it spends heavily on apparatus.

**Figure: the original (p. 100).** A three-row, four-column array of paired bar charts from an experiment on taste. Each of the twelve panels contains a pair of open (outlined) bars — the left bar of each pair tall, the right short — labeled "S-C" and "H-C" beneath; the four column conditions are labeled along the bottom "pre GS," "post GS," "pre tea," "post tea" (each label underlined). Vertical axes: top row scaled 2–12 by twos; middle row 2–10 by twos; bottom row 10–40 by tens. Each tall bar carries an error-bar cap (a T across its top) and an asterisk above it marking statistical significance. Full frame lines box the rows, vertical rules separate the columns, and dense tick marks line the axes. Source (margin note): James T. Kuznicki and N. Bruce McCutcheon, "Cross-Enhancement of the Sour Taste on Single Human Taste Papillae," *Journal of Experimental Psychology: General*, 108 (1979), 76.

**Figure: the redesign (p. 101).** "Vigorous pruning improves the graphic immensely, while still retaining all the data of the original. It is remarkable that erasing alone can work such a transformation." (p. 101). The redesigned figure keeps the same 3×4 layout but each bar pair is reduced to skeletal strokes: each bar is now a single thin vertical line topped by a short horizontal serif (a hook giving the bar's height, formed from what remains of the bar top), and each long–short pair is joined at the base by a short horizontal — bracket-like shapes. The frames, the vertical column rules, the asterisks, the error caps, the shading, the duplicate bar sides, and most ticks are gone; the y-axis numerals survive sparsely (12, 8, 4 in the top row; 8, 4 in the middle; 40, 30, 20, 10 in the bottom), and the rotated pair labels (S-C, H-C) remain along the bottom. No data values were altered or dropped — only ink removed. The redesign is an existence proof for the erasing principles: improvement *without* adding anything.

Tufte then justifies the two judgment calls (p. 101):

> "The horizontals indicate the paired comparisons and would change if the experimental design changed — so they count as information-carrying. All the asterisks are out since every paired comparison was statistically significant, a point that the caption can note." (p. 101)

Two reusable tests live in this passage. First, the *design-variation test*: ink that would change if the experimental design changed carries information (the horizontals encode which bars are compared with which — the pairing structure of the experiment), so it stays even though it is not, strictly, a plotted number. Second, the *uniform-symbol test*: a symbol appearing identically on every data point (asterisks everywhere, because everything was significant) distinguishes nothing; say it once in words in the caption and erase all the marks.

**Figure: the erased ink (p. 101).** "Here is the mix of non-data-ink and redundant data-ink that was erased, about 65 percent of the original." (p. 101). The figure shows, in the same 3×4 layout, exactly the ink that was removed and nothing else: the frame lines and column rules, all the asterisks, the error-bar caps, the redundant second sides and tops of the bars, the dense ticks and surplus axis numerals, and the underlines beneath the condition labels. The quantity matters: roughly 65 percent of the original graphic's ink communicated nothing that the remaining 35 percent did not. Note the explicit classification — the erasure was "the mix of non-data-ink and redundant data-ink," i.e., both erasing principles applied at once.

**Figure: the data graphical arithmetic (p. 102).** "The data graphical arithmetic looks like this — the original design equals the erased part plus the good part." (p. 102). The figure sets three miniature reproductions in an equation: the original chart, an "=" sign, the erased-ink chart, a "+" sign, and the pruned redesign (with its condition labels pre GS, post GS, pre tea, post tea restored beneath). The equation makes erasing auditable: every drop of the original's ink is accounted for in exactly one of the two parts.

### Case study 2: Pauling's atomic-volume chart — a full redesign cycle (pp. 102–105)

The second case study goes beyond pure erasing: it tests each erasure, discovers an erasure that fails, and reinvests the freed space. It demonstrates that the principles operate "within reason" — by experiment, not dogma.

**Figure: the original (p. 102).** "The next graphic, drawn by the distinguished science illustrator Roger Hayward, shows the periodicity of properties of chemical elements, exemplified by atomic volume as a function of atomic number. The data-ink ratio is less than 0.6, lowered because the 76 data points and the reference curves are obscured by the 63 dark grid marks arrayed over the data plane like a precision marching band of 63 mosquitoes." (p. 102). The figure: a fully framed plot, horizontal axis "Atomic Number" 0–90 labeled by tens, vertical axis "Atomic Volume" 0–70 labeled by tens (the axis title and numerals reading bottom-to-top, i.e., rotated). Inside: 76 solid dots (one per element), dashed reference curves sweeping up to sharp peaks at the alkali metals and down through the periods (peaks of increasing height toward cesium, then francium), and — superimposed across the whole data plane — a regular 9×7 array of 63 bold "+" grid marks. Source (margin note): Linus Pauling, *General Chemistry* (San Francisco, 1947), p. 64. The counts are exact and deliberate: 63 grid crosses versus 76 data points — nearly one piece of grid-furniture per datum.

**Step 1 — erase the grid (p. 103).** "The grid ticks compete with the essential information of the graphic, the curves tracing out the periods and the empirical observations. The little grid marks and part of the frame can be safely erased, removed from the denominator of the data-ink ratio." (p. 103). **Figure (p. 103, top):** the erased material shown by itself — the 9×7 field of "+" marks together with the top and right frame lines and the axis numerals as they stood (vertical-axis numbers 70, 50, 30, 10 set rotated; horizontal 10, 30, 50, 70, 90). The phrase "removed from the denominator" ties the edit back to the formula: erasing non-data-ink shrinks total ink while data-ink is unchanged, so the ratio rises.

**The result (p. 103, bottom).** "The uncluttered display brings out another aspect of the data: several of the elements do not fit the smooth theoretical curves all that well. The data-ink ratio has increased to about .9, with only the frame lines remaining as pure non-information." (p. 103). **Figure:** the chart redrawn with just dots, dashed curves, the two axis lines with sparse ticks (x: 0, 20, 40, 60, 80; y: 0, 20, 40, 60), and labels "Atomic Number" and "Atomic Volume" (the latter still rotated). The numbers: ratio up from under 0.6 to about 0.9. And the substantive payoff: erasing is not merely cosmetic — decluttering *reveals data behavior*, here the visible misfit of several elements (notably points off the smooth curve in the lanthanide region around atomic numbers 57–71) to the theoretical curves.

**Step 2 — test erasing the reference curves (p. 104).** A maximalist reading of the principles would erase the dashed curves too, since they are not observations. Tufte runs the test and reports failure: "The reference curves prove essential for organizing the data to show the periodicity. The curves create a structure, giving an ordering, a hierarchy, to the flow of information from the page." (p. 104). **Figure (p. 104, top):** the chart with dots only — 76 unconnected points against bare axes. Without the curves the periodic rise-and-fall is genuinely hard to see; the points read as scatter. The lesson is the chapter's most important qualification: some non-data-ink (or arguably theory-ink) organizes the data and must stay. This is what "within reason" means operationally — every erasure is an experiment to be checked against whether the reader can still see the structure.

**Step 3 — test restoring the grid instead (p. 104).** Could the grid have done the organizing work the curves do? "Restoring the grid fails to organize the data. The ticks are too powerful, and they also add a disconcerting visual vibration to the graphic. With the ticks, the reference curves become all the more necessary, since the eye needs some guidance through the maze of dots and crosses." (p. 104). **Figure (p. 104, bottom):** dots plus the 63 "+" marks, no curves. The grid marks visually rival the data points (similar size and weight), producing the "maze of dots and crosses" and a moiré-like vibration (anticipating Chapter 5's "unintentional optical art"). The comparison completes a controlled experiment across pages 103–104: data+curves works; data alone fails; data+grid fails worse. The curves are kept because they passed the test, not because curves are categorically good.

**Step 4 — reinvest the freed space (p. 105).** "The space opened up by erasing can be effectively used. Labels for the initial elements of each period, an alkali, show the beginning of each cycle in the periodic table of elements — and in the graphic. The unusual rare-earths are indicated. In addition, the label and numbers on the vertical axis are turned to read from left to right rather than bottom to top, making the graphic slightly more accessible, a little more friendly." (p. 105). **Figure (p. 105):** the final redesign. The dashed curves and dots remain; at each periodic peak the alkali element is labeled with symbol and atomic number — Li 3, Na 11, K 19, Rb 37, Cs 55, Fr 87 — each beside its peak, with the dashed peak lines rising to them; the anomalous plateau of points around atomic numbers 57–71 is labeled "the rare earths"; the vertical axis now reads "Atomic Volume" horizontally with horizontal numerals (20, 40, 60), and the x-axis keeps 20, 40, 60, 80 with "Atomic Number" beneath. The erasing dividend is spent on *more information* (direct data labels connecting the graphic to the periodic table; flagging the anomaly) and on *reader comfort* (left-to-right type). The closing words — "slightly more accessible, a little more friendly" — register that graphical editing serves the reader's experience, not an austerity aesthetic.

The complete Pauling cycle, in order: erase what competes (grid, excess frame) → check what the erasure reveals (misfit points) → test further erasure (curves: fails, restore) → test the alternative (grid back: fails, remove) → reinvest the space (labels, friendly type). This is "revise and edit" enacted.

## Conclusion: The Five Principles (p. 105)

The chapter ends with its principles gathered:

> "Five principles in the theory of data graphics produce substantial changes in graphical design. The principles apply to many graphics and yield a series of design options through cycles of graphical revision and editing.
>
> Above all else show the data.
> Maximize the data-ink ratio.
> Erase non-data-ink.
> Erase redundant data-ink.
> Revise and edit." (p. 105)

The fifth principle, "Revise and edit," is stated here for the first time as a principle, though the whole second half of the chapter has been demonstrating it. Note also the framing: the principles "yield a series of design options through cycles" — they generate candidate designs to be tested (as the Pauling sequence was), not a single mechanical answer.

## Bridge to Chapter 5 (p. 106)

The page following the conclusion carries the epigraph for Chapter 5 ("Chartjunk: Vibrations, Grids, and Ducks"), in verse:

> "With savage pictures fill their gaps
> And o'er unhabitable downs
> Place elephants for want of towns."
>
> — "Jonathan Swift's indictment of 17th-century cartographers" (p. 106)

Swift's cartographers, decorating empty map space with elephants, are the historical ancestors of chartjunk — Chapter 5 will catalogue the modern descendants (moiré vibration, the dreaded grid, the self-promoting duck), all of which are, in this chapter's vocabulary, non-data-ink or redundant data-ink. Chapter 4 supplies the theory; Chapter 5 prosecutes the offenders.

## Consolidated Footnotes and Margin Citations

| Page | Reference |
|------|-----------|
| p. 90 | Richard Saul Wurman, *What-If, Could-Be* (Philadelphia, 1976) — epigraph |
| p. 93 | Kenneth A. Kooi, *Fundamentals of Electroencephalography* (New York, 1971), p. 110 — EEG figure |
| p. 94 | John Tyler Bonner, *Size and Cycle: An Essay on the Structure of Biology* (Princeton, 1965), p. 17 — scatterplot |
| p. 95 | Stanley Kelley, Jr., Richard E. Ayres, and William G. Bowen, "Registration and Voting: Putting First Things First," *American Political Science Review*, 61 (1967), 371; reprinted in Edward R. Tufte, ed., *The Quantitative Analysis of Social Problems* (Reading, Mass., 1970), p. 267; reprinted again in William J. Crotty, ed., *Public Opinion and Politics: A Reader* (New York, 1970), p. 364 — the three registration graphics |
| p. 97, n. 1 | Bernhard Flury and Hans Riedwyl, "Graphical Representation of Multivariate Data by Means of Asymmetrical Faces," *Journal of the American Statistical Association*, 76 (December 1981), 757–765 |
| p. 97, n. 2 | Leonard Zusne, *Visual Perception of Form* (New York, 1970), pp. 256–257 — eye-movement evidence on symmetry |
| p. 99 | Kirk Bryan and Michael D. Cox, "The Circulation of the World Ocean: A Numerical Study. Part 1, A Homogeneous Model," *Journal of Physical Oceanography*, 2 (1972), 330 — ocean-currents maps |
| p. 100, n. 3 | T. S. Eliot, "The Function of Criticism," in *Selected Essays 1917–1932* (New York, 1932), p. 18 |
| p. 100 | James T. Kuznicki and N. Bruce McCutcheon, "Cross-Enhancement of the Sour Taste on Single Human Taste Papillae," *Journal of Experimental Psychology: General*, 108 (1979), 76 — taste-papillae bar chart |
| p. 102 | Linus Pauling, *General Chemistry* (San Francisco, 1947), p. 64 — atomic-volume chart, drawn by Roger Hayward |
| p. 106 | Jonathan Swift's verse on 17th-century cartographers — Chapter 5 epigraph |

## Key Numbers in the Chapter

| Quantity | Value | Page |
|----------|-------|------|
| Playfair's first chart engraved | August 1785 (published 20 Aug. 1785) | p. 91 |
| Playfair's improved chart published | 1 May 1786 | p. 92 |
| Data span, 1785 chart | imports/exports England–North America, 1770–1782 | p. 91 |
| Data span, 1786 chart | exports/imports Denmark & Norway, 1700–1780 | p. 92 |
| EEG data-ink ratio | ≈ 1.0 (nothing erasable); 8 continuous tracks | p. 93 |
| Bonner scatterplot non-data-ink | "perhaps 10–20 percent" | p. 94 |
| Registration data | 104 cities, 1960 | pp. 94–95 |
| Registration replot ratio | "about 0.7" | p. 95 |
| Registration third reprint ratio | 0 — "a graphical absolute zero, a null data-ink ratio" | p. 95 |
| Scope of maximize principle | reasonable advice for "perhaps two-thirds of all statistical graphics" | p. 96 |
| Encodings of one bar's height | 6 (any 5 erasable) | pp. 96–97 |
| Bar's labeled value | 35.9 | p. 96 |
| Decorated bar series span | 1939-40 to 1975-76, biennial | p. 97 |
| Flury–Riedwyl faces paper | JASA 76 (Dec. 1981), 757–765 | p. 97 n.1 |
| Marey schedule date | 1880 | p. 98 |
| Ocean map extension | 1⅔ times around the world (vs. once) | p. 99 |
| Taste-papillae ink erased | "about 65 percent of the original" | p. 101 |
| Pauling original ratio | "less than 0.6" | p. 102 |
| Pauling data points / grid marks | 76 points; 63 "+" marks ("a precision marching band of 63 mosquitoes") | p. 102 |
| Pauling cleaned ratio | "about .9" | p. 103 |
| Alkali labels in final redesign | Li 3, Na 11, K 19, Rb 37, Cs 55, Fr 87 | p. 105 |
| Principles in conclusion | 5 | p. 105 |

## Terms of Art Introduced in This Chapter

- **Data-ink** — "the non-erasable core of a graphic, the non-redundant ink arranged in response to variation in the numbers represented" (p. 93).
- **Data-ink ratio** — data-ink divided by total ink used to print the graphic; equivalently, 1.0 minus the erasable proportion (p. 93).
- **Non-data-ink** — ink that fails to depict statistical information (p. 96); e.g., grids, frames, ticks beyond need.
- **Redundant data-ink** — ink that "depicts the same number over and over" (p. 96).
- **Graphical absolute zero / null data-ink ratio** — a graphic containing no data-ink at all (p. 95).
- **The grid sea** — Tufte's epithet for a grid mesh that overwhelms the data (p. 94).
- **Data graphical arithmetic** — original design = erased part + good part (p. 102).
- The five principles: **Above all else show the data. Maximize the data-ink ratio. Erase non-data-ink. Erase redundant data-ink. Revise and edit.** (p. 105; the first stated at p. 92, the second at p. 96, the erasing principles at pp. 96 and 100.)
