# Chapter 8: Data Density and Small Multiples

Most published graphics waste the eye's enormous capacity. The human eye can resolve hundreds of distinctions per inch, yet the average published graphic shows only about ten numbers per square inch. Tufte's answer: measure how much data a graphic carries per unit area (its data density), then push that density up — by showing more data, by shrinking the graphic, and ultimately by repeating shrunken graphics into small multiples, the design form that embodies the whole theory of data graphics.

The chapter opens with a Matisse epigraph (p. 160): "I want to reach that state of condensation of sensations which constitutes a picture."

## The Eye's Resolving Power (pp. 161-162)

Our eyes can make a remarkable number of distinctions within a small area. Evidence Tufte assembles:

- With very light grid lines, the eye can easily locate 625 points in one square inch (100 per square centimeter) (p. 161).
- An 80 × 80 grid over a square inch yields 25,281 distinct locations. Footnote formula: a square grid formed on each side by n parallel black and n−1 parallel white lines contains n² intersections of two black lines (corners of squares), (n−1)² intersections of two white lines (white squares), and 2n(n−1) intersections of a black and white line (sides of squares) — a total of (2n−1)² line intersections or distinct locations (p. 161).
- With redundancy and context, the eye makes fine distinctions all the time: engineering and machine-work instruments are engraved with scales of 20 increments to the centimeter, 50 to the inch (p. 161).
- Fine print: type in the U.S. *Statistical Abstract* runs 12 lines per vertical inch, about 23 characters per inch per line — a maximum density of 276 characters per square inch; the actual density, given white space, is 185 characters per square inch (28 per square centimeter) (p. 161).
- Maps go finer still. Cartographer D. P. Bickmore: "the resolving power of the eye enables it to differentiate to 0.1 mm where provoked to do so. Clearly, therefore, conciseness is of the essence and high resolution graphics are a common denominator of cartography." Distinctions at 0.1 mm mean 254 per inch (p. 162).

Design implication: the limiting factor in graphics is almost never the eye; it is the designer's failure to provoke and exploit the eye's capacity.

## Data Density in Graphical Practice (p. 162)

The numbers that go into a graphic can be organized into a **data matrix** of observations by variables. Relating the size of the graphic to the amount of data displayed gives Tufte's empirical measure of graphical performance, the **data density**:

> data density of a graphic = (number of entries in data matrix) / (area of data graphic)

Densities observed in practice span nearly six orders of magnitude (pp. 162-166):

| Graphic | Numbers per square inch |
|---|---|
| OMB *Social Indicators* bar chart (4-entry data matrix on 26.5 sq in) | 0.15 |
| JASA style-sheet exemplar histogram (32-entry matrix) | 3.8 |
| New York City weather history for 1980 (reduced version) | 181 |
| Annual sunshine record (Monkhouse and Wilkinson) | ~1,000 |
| Bertin's map of the 30,000 communes of France | ~9,000 |
| Map of the galaxies (2,275,328 encoded rectangles × 3 numbers each on 61 sq in) | 110,000 — "the current record" |

Counting rule illustrated by the galaxies map: each plotted mark counts for as many numbers as it encodes (each rectangle = two numbers by its location, one by its shading). The France map counts the numbers needed to recreate the data (30,000 latitudes, 30,000 longitudes, ~6 shape numbers per commune = at least 240,000 entries).

A side principle from the sunshine record: density alone is not enough — the visual metaphor should correspond to the data. Tufte reverses the printed image (dark ink for sunshine in the original) so that the light areas are the times when the sun shines (p. 165).

## Data Density and the Size of the Data Matrix: Publication Practices (pp. 167-168)

Tufte sampled at least 20 graphics from each of 21 scientific and news publications, circa 1979-1980, recording data density and data-matrix size. Median densities (numbers per square inch): Nature 48, Journal of the Royal Statistical Society B 27, Science 21, Wall Street Journal 19, Fortune 18, The Times (London) 18, Journal of the American Statistical Association 17, Asahi 13, New England Journal of Medicine 12, The Economist 9, Le Monde 8, Psychological Bulletin 8, JAMA 7, New York Times 7, Business Week 6, Newsweek 6, Annuaire Statistique de la France 6, Scientific American 5, Statistical Abstract of the U.S. 5, American Political Science Review 2, Pravda 0.2.

The table's other half, size of data matrix: median matrices run from 5 numbers (Pravda) and 16 (American Political Science Review) up to 200 (Journal of the Royal Statistical Society B) and 177 (Nature), with observed maxima of 3,780 (Nature) and 3,600 (New England Journal of Medicine) — proof that several-thousand-number graphics do get published (p. 167).

Conclusions Tufte draws:

- There is enormous diversity of graphical performance both within and between publications; a few data-rich designs appear in nearly every publication. "The opportunity is there but it is rarely exploited: the average published graphic is rather thin, based on about 50 numbers shown at the rate of 10 per square inch" (pp. 167-168).
- Among newspapers, the Wall Street Journal, The Times (London), and Asahi publish data-rich graphics with densities equal to those of JASA. Most American papers and magazines, along with Pravda, publish less data per graphic than the major papers of other industrialized countries (p. 168).
- Very few statistical graphics achieve the information display rates found in maps. Highly detailed maps portray 100,000 to 150,000 bits per square inch; the average U.S. Geological Survey topographic quadrangle (17 × 23 inches) contains over 100 million bits, about 250,000 per square inch. "Perhaps some day statistical graphics will perform as successfully as maps in carrying information" (p. 168).

## High-Information Graphics (pp. 168-169)

Actionable doctrine:

- Base data graphics on large rather than small data matrices, with high rather than low data density. More information is better than less, especially when the marginal costs of handling and interpreting additional information are low — as they are for most graphics (p. 168).
- Put the simple things in tables or in the text; reserve graphics for what only they can do: "graphics can give a sense of large and complex data sets that cannot be managed in any other way" (p. 168).
- If a graphic becomes overcrowded (although several thousand numbers represented may be just fine), use data-reduction techniques — averaging, clustering, smoothing — to thin the numbers out before plotting (p. 168).
- Start high-information: "Summary graphics can emerge from high-information displays, but there is nowhere to go if we begin with a low-information design" (p. 168).
- "Data-rich designs give a context and credibility to statistical evidence. Low-information designs are suspect: what is left out, what is hidden, why are we shown so little?" (p. 168).
- High-density graphics aid comparison by putting much information within the view of the eye: we look at one page at a time, and the more on the page, the more effective and comparative our eye can be (p. 168). (Footnote: x-ray analysts are advised to search a reduced image so the whole display can be perceived at least once without large eye movement.)

The chapter's central principle:

> **Maximize data density and the size of the data matrix, within reason.**

Care required: high-information graphics must be designed with special care. As the volume of data increases, data measures must shrink — smaller dots for scatterplots, thinner lines for busy time-series. The clutter of chartjunk, non-data-ink, and redundant data-ink is even more costly than usual in data-rich designs (pp. 168-169).

## The Shrink Principle (p. 169)

The way to increase data density other than enlarging the data matrix is to reduce the area of the graphic:

> **The Shrink Principle: Graphics can be shrunk way down.**

Many data graphics can be reduced in area to half their currently published size with virtually no loss in legibility and information. Bertin's crisp, elegant line lets 17 small-scale graphics share a single page with extensive text. Repeated application of the Shrink Principle leads to a powerful and effective graphical design: the small multiple.

## Small Multiples (pp. 170-174)

Definition (p. 170): "Small multiples resemble the frames of a movie: a series of graphics, showing the same combination of variables, indexed by changes in another variable."

The key design rule, stated via the Los Angeles air pollution display: "The design remains constant through all the frames, so that attention is devoted entirely to shifts in the data" (p. 170). Keep scales, layout, and encoding identical across frames; vary only the data.

What small multiples do well, shown through the chapter's examples:

- Decompose a total into parts that visibly sum (the melanoma plots: overall distribution = men + women — "data graphical arithmetic, similar to that of the multiwindow plot," p. 171).
- Reveal sampling variability (twelve histograms of 50 random normal deviates each, p. 172).
- Tell a narrative as a cohort moves through the frames (the 1904 herring class dominating successive annual catches, p. 172).
- Support complex cross-species or cross-category comparison (human and great-ape chromosomes side by side, pp. 172-173).
- Mix table and graphic to portray four-way comparisons (Consumer Reports auto frequency-of-repair charts: manufacturers × car types × years × trouble spots, p. 174).

## Conclusion (p. 175)

Well-designed small multiples are:

- inevitably comparative
- deftly multivariate
- shrunken, high-density graphics
- usually based on a large data matrix
- drawn almost entirely with data-ink
- efficient in interpretation
- often narrative in content, showing shifts in the relationship between variables as the index variable changes (thereby revealing interaction or multiplicative effects)

Small multiples reflect much of the theory of data graphics, condensed into two aphorisms (credited respectively to Mies van der Rohe and Robert Venturi):

> For non-data-ink, less is more.
> For data-ink, less is a bore.
