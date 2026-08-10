# Chapter 7: Multifunctioning Graphical Elements — Detailed Reference

This file is a maximally complete account of Chapter 7 of Edward Tufte, *The Visual Display of Quantitative Information* (2nd ed.), printed pages 139–159. It preserves the chapter's full argument structure, every example and figure, all quoted definitions, all numbers, and all footnotes. Page citations are to the printed book pages. Chapter 7 is the second chapter of Part II, "Theory of Data Graphics," and follows directly from Chapter 6 ("Data-Ink Maximization and Graphical Design"), whose closing pages (pp. 136–137) had conceded that maximizing data-ink "is but a single dimension of a complex and multivariate design task" and that other considerations remain — "not only of efficiency, but also of complexity, structure, density, and even beauty." Chapter 7 takes up the complexity-and-structure side of that agenda. The chapter has no opening epigraph of its own.

## Chapter Opening and the Core Principle (p. 139)

The chapter opens with its thesis stated in three sentences and then the formal definition of its subject (p. 139):

> "The same ink should often serve more than one graphical purpose. A graphical element may carry data information and also perform a design function usually left to non-data-ink. Or it might show several different pieces of data. Such *multifunctioning graphical elements*, if designed with care and subtlety, can effectively display complex, multivariate data."

So a multifunctioning element earns its name in either of two ways: (1) it does data work *and* design/architectural work at once (the work usually delegated to non-data-ink such as frames, ticks, and grids), or (2) it encodes several distinct pieces of data simultaneously. The qualifying clause — "if designed with care and subtlety" — already foreshadows the chapter's closing problem of puzzles.

A footnote attached to this opening paragraph traces the idea's intellectual lineage outside statistics (p. 139, footnote 1): "The idea of double-functioning elements appears in architectural criticism; see Robert Venturi, *Complexity and Contradiction in Architecture* (New York, second edition, 1977), ch. 5. Venturi in turn cites Wylie Sypher, *Four Stages of Renaissance Style* (Garden City, N.Y., 1955)."

**The model case: the blot of the blot map** (p. 139). Tufte's first concrete example is the "multifunctioning blot of the blot map" (the blot map and its data measure were introduced in Chapter 6). The single blot "simultaneously locates the geographic unit on a two-dimensional surface, describes the shape of the geographic unit, and indicates the level of the variable displayed by color or intensity of shading." Three functions in one mark. Tufte's appraisal: "That is a great deal of information for a small patch of ink — and the different pieces of information are not confounded and mixed together." The non-confounding clause is the design standard the rest of the chapter elaborates: multifunctioning is only a virtue when the several encodings stay separable to the eye.

**The contrast case: the conventional frame** (p. 139). Against the hard-working blot Tufte sets the idle conventional graphical frame, which "performs only a modest design function, the separation of the grid and data measures from the labels. And it is a place to hang the grid ticks." His conclusion: "With all that ink doing so little, it is a prime candidate for mobilization as a double-functioning graphical element. Hence the range-frame, the quartile frame, and the dot-dash-plot." (All three are Chapter 6 inventions: the range-frame makes the frame line span exactly the data range; the quartile frame/quartile plot makes the frame show quartile summaries; the dot-dash-plot turns the frame into marginal-distribution dashes.)

**The principle of the chapter**, set off typographically as a display (p. 139):

> "Mobilize every graphical element, perhaps several times over, to show the data."

**The danger, stated up front** (p. 139): "The danger of multifunctioning elements is that they tend to generate graphical puzzles, with encodings that can only be broken by their inventor. Thus design techniques for enhancing graphical clarity in the face of complexity must be developed along with multifunctioning elements." This sentence is the chapter's road map: the first three sections (data-built data measures, data-based grids, double-functioning labels) develop the mobilization techniques; the final section ("Puzzles and Hierarchy in Graphics") develops the accompanying clarity techniques.

## Data-Built Data Measures (pp. 139–144)

### Definition and the simplest case (p. 139)

The section begins with the definition of its key term: "The graphical element that actually locates or plots the data is the *data measure*." Tufte enumerates instances: "The bars of a bar chart, the dots of a scatterplot, the dots and dashes of a dot-dash-plot, the blots of a blot map are data measures." Then the first level of mobilization: "The ink of the data measure can itself carry data; for example, the dots of the scatterplot can take on different shadings in response to a third variable." That is, before any exotic construction, the mere rendering of an existing data measure (shading, intensity) is free encoding capacity for additional variables.

### The stem-and-leaf plot: the distribution built from the numbers themselves (p. 140)

The next escalation: "Building data measures out of the data increases the quantitative detail and dimensionality of a graphic. The stem-and-leaf plot constructs the distribution of a variable with numbers themselves" (p. 140).

**Figure (p. 140):** A stem-and-leaf display captioned "Stem-and-leaf displays: heights of 218 volcanoes, unit 100 feet." Two key-annotations flank the display: at top left, "0|9 = 900 feet"; at bottom left, "19|3 = 19,300 feet." Stems run from 0 to 19 (hundreds of feet, i.e., 0 to 19,000+ feet), each stem followed by a string of leaf digits, one digit per volcano. The shape of the digit-strings *is* the histogram: long rows at stems 2–7 (heights of roughly 2,000–8,000 feet are most common), thinning rapidly above stem 10, with a small cluster again at stem 19 (the few volcanoes over 19,000 feet). As transcribed from the reproduction (individual leaf digits may be imperfect in the scan, but row lengths — the distributional shape — are faithful):

| Stem | Leaves |
|---|---|
| 0 | 98766562 |
| 1 | 97719630 |
| 2 | 69987766544422211009850 |
| 3 | 876655412099551426 |
| 4 | 9998844331929433361107 |
| 5 | 97666666554422210097731 |
| 6 | 898665441077761065 |
| 7 | 98855431100652108073 |
| 8 | 653322122937 |
| 9 | 377655421000493 |
| 10 | 0984433165212 |
| 11 | 4963201631 |
| 12 | 45421164 |
| 13 | 47830 |
| 14 | 00 |
| 15 | 676 |
| 16 | 52 |
| 17 | 92 |
| 18 | 5 |
| 19 | 39730 |

The point of the figure: each digit simultaneously (a) is one observation, (b) gives that observation's value to three significant figures when read with its stem, and (c) contributes one unit of length to the bar that shows the distribution's shape. Nothing in the display is non-data-ink except the stems and the rule separating stems from leaves.

Tufte then quotes the inventor's own rationale (p. 140): "The idea of making every graphical element effective was behind the design of the stem-and-leaf plot. In presenting his invention, John Tukey wrote: 'If we are going to make a mark, it may as well be a meaningful one. The simplest — and most useful — meaningful mark is a digit.'" Footnote 2 gives the source: "Some Graphic and Semigraphic Displays," in T. A. Bancroft, ed., *Statistical Papers in Honor of George W. Snedecor* (Ames, Iowa, 1972), p. 296.

### The living histogram (p. 140)

"Here, too, the data form the data measure. Note the bimodal distribution in the histogram of college students arranged by height." (p. 140)

**Figure (p. 140):** A photograph of a college lawn (a large columned campus building in the background) with dozens of students standing in single-file columns ordered by height — each column one height class — so that the crowd itself forms a histogram. The bimodality (two humps, women's heights and men's heights) is visible in the human bar heights. The people are at once the observations and the marks that plot them.

Sidenote citation (p. 140): Brian L. Joiner, "Living Histograms," *International Statistical Review*, 43 (1975), 339–340. The second edition adds a qualification to the bimodality reading: "But, for further developments, see Mark F. Schilling, Ann E. Watkins, and William Watkins, 'Is Human Height Bimodal?' *The American Statistician*, 56 (August 2002), 223–229." (That later paper shows mixing two normal distributions of male and female heights does not generally produce a visibly bimodal combined distribution — the photographed bimodality reflects the arrangement by sex-conscious students more than the underlying mixture.)

### Ayres' chart of American divisions in France (p. 141)

The section's centerpiece, introduced as a historical exemplar (p. 141): "A distinguished graphic that builds data measures out of data was designed by Colonel Leonard P. Ayres for his statistical history of World War I, a book with several notable graphics all done by typewriter and rule. Constructing the data measures out of each American division's name (a numerical designation) turns what might have been a routine time-series into an elegant display."

A parenthetical design caveat: "(Note that the cumulative design depends on the fact that none of the divisions returned before October 1918.)" — i.e., the stacking trick of letting each division's number persist column-to-column only works because the set of divisions in France grows monotonically over the charted period; departures would break the clean cumulative profile.

The three functions, enumerated by Tufte (p. 141): "The triple-functioning data measure shows: (1) the number of divisions in France for each month, June 1917 to October 1918; (2) what particular divisions were in France in each month; and (3) the duration of each division's presence in France."

**Figure (p. 141):** A typewritten chart. The X-axis lists months "Jun Jul Aug Sep Oct Nov Dec | Jan Feb Mar Apr May Jun Jul Aug Sep Oct" with year labels 1917 (first seven months) and 1918 (last ten), separated by a vertical rule at the year break. Each month's column is a vertical stack of two-digit (and one-digit) division numbers, one number per division then in France. A division's number enters at the month it arrived and repeats in every subsequent column, so each division's number forms a horizontal row whose length is its duration of stay, while the column height is the count of divisions and the rising staircase profile of the column tops is the cumulative time-series. June 1917 has a single entry ("1" — the 1st Division); the columns grow slowly through 1917 (divisions 2, 26, 41, 42 appearing in the autumn), accelerate through spring–summer 1918, and the final October 1918 column stacks roughly 42 division numbers (reading down from the top, as legible in the reproduction: 8, 38, 31, 34, 86, 84, 87, 40, 39, 88, 81, 7, 85, 36, 91, 79, 76, 29, 37, 90, 92, 89, 83, 78, 80, 30, 33, 6, 27, 4, 28, 35, 82, 77, 3, 5, 32, 41, 42, 26, 2, 1 — newest arrivals at top, the 1st Division at the bottom of every column). Sidenote citation: Leonard P. Ayres, *The War with Germany* (Washington, D.C., 1919), p. 102. (Tufte returns to this chart on p. 155 as the exemplar of multiple viewing angles; see below.)

### Chernoff faces: elaborate encodings (p. 142)

"Encoding of data measures can be far more elaborate. The plotted points here are Chernoff faces, which reduce well, maintaining legibility even with individual areas of .05 square inches as shown." (p. 142) The faces are cartoon faces whose features (eyes, brows, mouth, face shape, etc.) encode further variables of each observation, so each plotted point is itself a multivariate display.

Tufte describes the intended analytical workflow: "The analyst would observe the standard X-Y scatterplot and then turn to the within-scatter detail, seeking clusters of similar observations over the X-Y plane. Outlying faces and those inconsistent with others in the neighborhood — they are, of course, *strangers* — should be identified by observation number or name." (p. 142) Note the two-pass reading: macro scatter first, micro face-detail second — an early instance of the layered-viewing idea formalized at the chapter's end. "Strangers" is the term of art for faces inconsistent with their local neighborhood.

Footnote 3 (p. 142): "Herman Chernoff, 'The Use of Faces to Represent Points in k-Dimensional Space Graphically,' *Journal of the American Statistical Association* 68 (June 1973), 361–368. For an application of faces located over two dimensions, see Howard Wainer and David Thissen, 'Graphical Data Analysis,' *Annual Review of Psychology*, 32 (1981), 191–241."

**Figure (p. 142):** A frameless X-Y plot (axes labeled only "X" and "Y," a single vertical line at left and horizontal line at bottom) containing roughly 35 small cartoon faces scattered over the plane, each with slightly different features. The faces in the upper-right region mostly share one expression family, those lower-left another; one face in the mid-upper region, visibly unlike its neighbors, is singled out with a leader line and the label "A stranger."

**The limit, and the pivot** (p. 142): "With cartoon faces and even numbers becoming data measures, we would appear to have reached the limit of graphical economy of presentation, imagination, and, let it be admitted, eccentricity." This self-aware sentence both caps the escalation (shading → digits → people → typewritten division numbers → faces) and admits its eccentricity — then is immediately overturned by the next example, which pushes 350 years further back.

### "Easter Wings": shaped poetry as proto-graphics (p. 143)

"But let us consider this shaped poem, 'Easter Wings' by George Herbert (1593–1633), which uses space — the length of each line — to depict quantity, all done 150 years before Playfair. The lines double-function: the longer lines describe wealth, plenty, largesse, and rising to flight; shorter lines tell of poverty and becoming 'most thinne'; and lines of intermediate length indicate transition and change (decaying, rising, combining, becoming)" (p. 143). The double-function: each line is simultaneously the verbal content and a graphical mark whose length quantifies the spiritual state the words describe. (The "150 years before Playfair" remark connects to Chapter 1's history, where Playfair, 1759–1823, is credited with inventing or improving nearly all the standard statistical graphics in the 1780s.)

Footnote 4 (p. 143): "For a remarkable OTSOG-like tour of the many typographical variant shapes of 'Easter Wings' in its long publication history, see the essay 'FIAT fLUX,' by 'Random Cloud,' in Randall McLeod, ed., *Crisis in Editing: Texts of the English Renaissance* (New York, 1994), 61–172." ("OTSOG" = *On the Shoulders of Giants*, Robert Merton's digressive scholarly classic; "Random Cloud" is McLeod's anagrammatic pen name.)

**Figure (p. 143):** The poem set under the italic heading "Easter-wings.", two ten-line stanzas, each centered so that line lengths shrink to a waist and grow again — each stanza forming an hourglass/wings shape. The full text as printed:

> Lord, who createdst man in wealth and store,
> Though foolishly he lost the same,
> Decaying more and more,
> Till he became
> Most poore:
> With thee
> O let me rise
> As larks, harmoniously,
> And sing this day thy victories:
> Then shall the fall further the flight in me.
>
> My tender age in sorrow did beginne:
> And still with sicknesses and shame
> Thou didst so punish sinne,
> That I became
> Most thinne.
> With thee
> Let me combine
> And feel this day thy victorie:
> For, if I imp my wing on thine,
> Affliction shall advance the flight in me.

In each stanza the longest lines (wealth/store; flight advanced) bound the shortest ("Most poore: / With thee"; "Most thinne. / With thee") exactly at the semantic nadir — the line-length curve tracks the narrative of decay and recovery.

### Youden's typographical normal curve (p. 143)

Introduced with a single line: "And the typographical delight of the statistician W. J. Youden:" (p. 143).

**Figure (p. 143):** A block of centered all-capitals type whose successive lines grow in length so that the block's silhouette is the bell of the normal distribution, the final long line forming the baseline. The text reads: "THE NORMAL LAW OF ERROR STANDS OUT IN THE EXPERIENCE OF MANKIND AS ONE OF THE BROADEST GENERALIZATIONS OF NATURAL PHILOSOPHY ◆ IT SERVES AS THE GUIDING INSTRUMENT IN RESEARCHES IN THE PHYSICAL AND SOCIAL SCIENCES AND IN MEDICINE AGRICULTURE AND ENGINEERING ◆ IT IS AN INDISPENSABLE TOOL FOR THE ANALYSIS AND THE INTERPRETATION OF THE BASIC DATA OBTAINED BY OBSERVATION AND EXPERIMENT." The encomium to the normal curve is itself shaped as the normal curve: words about the thing double-function as a picture of the thing.

### The lane-stripe chart: the graphical pun (p. 144)

The section closes at its logical extreme (p. 144): "Finally, this graphical pun: the visual data as the data measure, as in the living histogram. The chart shows how states once differed in their engineering standards for painting lane stripes on road pavement. Some states marked the road lanes with short dashes and long gaps; others used only solid lines. Portrayed in the graphic is the actual physical pattern painted on the road, with 48 U.S. states ordered by the length of the painted mark." The term "graphical pun" names the case where the mark on the page is not a symbol for the data but a (scaled) replica of the physical phenomenon itself.

Sidenote citation (p. 144): "Redrawn from A. R. Lauer, 'Psychological Factors in Effective Traffic Control Devices,' *Traffic Quarterly*, 5 (January 1951), 94."

**Figure (p. 144):** A horizontal scale labeled "feet" with ticks at 50, 100, 150, 200, 250, 300, 350. Down the left, 48 state names; beside each, a horizontal line reproducing that state's actual painted lane-marking pattern (dash length and gap length to scale). The states are ordered from the shortest painted marks (sparse short dashes) at top to unbroken solid lines at bottom. The order as printed: California, Missouri, Minnesota, Alabama, Arizona, Colorado, Florida, Georgia, Kentucky, Louisiana, Maine, Massachusetts, Mississippi, Nebraska, Nevada, New Hampshire, New Mexico, New York, North Carolina, Oregon, Pennsylvania, Washington, Delaware, Iowa, Wyoming, Connecticut, Vermont, Wisconsin, Rhode Island, Kansas, West Virginia, Idaho, Michigan, Arkansas, North Dakota, Maryland, Montana, Virginia, South Carolina, New Jersey, Illinois, Indiana, Ohio, Oklahoma, South Dakota, Tennessee, Texas, Utah. A large group near the top (Alabama through Washington) shares a similar medium-dash standard; the final eight (Illinois, Indiana, Ohio, Oklahoma, South Dakota, Tennessee, Texas, Utah) used only solid, unbroken lines. The visual lesson: the chart needs no symbolic data measure at all — the engineering standard is its own display, and ordering the rows by mark length turns the collection into a distribution.

## Data-Based Grids (pp. 145–148)

This section transfers the mobilization question from data measures to the grid: can grid ink itself carry data? The answer is "very occasionally" — and the section's four examples form a sequence of progressively stronger grid–data fusions: grid as measurement record, data arrangement as grid, grid as the very object of study, and grid lines keyed to events.

### Grid formed by measurement locations (p. 145)

"Very occasionally the grid can report directly on the data. This grid is formed by the location of measurement instruments; the plain dots register a zero reading, in contrast with the white background where no readings were taken. Erasing the grid would erase measured data (rather uneventful, to be sure). Such is not the case for most grid dots, ticks, and lines." (p. 145) The parenthetical concedes that a zero reading is unexciting data — but it is data, and that distinguishes this grid categorically from ordinary grids, where erasure costs nothing (the Chapter 6 erasing test applied to grids).

Sidenote citation (p. 145): K. V. Roberts and D. E. Potter, "Magnetohydrodynamic Calculations," in Berni Alder, et al., eds., *Methods in Computational Physics: Volume 9, Plasma Physics* (New York, 1970), p. 402.

**Figure (p. 145):** Two stacked horizontal panels from a plasma-physics computation. In each, a dark cross-hatched horizontal bar (the plasma column) sits at the left, surrounded by a rectangular field of fine, regularly spaced dots — the computational/measurement lattice. Where the field shows motion (near the right end of the bar), the dots are replaced by small arrows (vectors) indicating measured flow direction and magnitude; the second panel shows the flow pattern further developed, with a burst of vectors at the bar's right tip. Plain dot = instrument present, zero reading; white gap = no instrument; arrow = nonzero reading. Every grid mark is a datum.

### Data as grid: Galton's table-graphic (p. 145)

"The arrangement of data in this table-graphic yields an internal grid, a rare example of data as grid" (p. 145).

**Figure (p. 145):** Francis Galton's celebrated cross-tabulation of parents' and children's heights — the table from which regression and correlation emerged. Structure: row block headed "MID-PARENTS," with two columns "Heights in inches" (72 down to 66) and "Deviates in inches" (+3 down to −2); column block headed "ADULT CHILDREN, their Heights, and Deviations from 68¼ inches," with heights 64 through 73 inches and deviations −4 through +4. The body cells contain the counts of families at each height combination (e.g., values like 1, 2, 3, 5, 7, 9, 10, 12, 14 in the dense center, thinning toward the corners). Drawn over the numeric field: the correlation ellipse (a contour of equal frequency), its major and minor axes, the "locus of vertical tangential points" and "locus of horizontal tangential points" (the two regression lines), tangent lines, and labeled points O (center), X, Y, M, N. The arrangement of the counts in their height-by-height lattice *is* the grid on which the geometric analysis is drawn — no separate grid is needed because the data table supplies it. Sidenote citation: Karl Pearson, *The Life, Letters and Labours of Francis Galton* (Cambridge, 1930), vol. III-A, 14.

### The grid as the element of interest: the Mitchell map (p. 146)

**Figure (p. 146, full page):** A comparison from the *Atlas of Early American History*. The dominant image is "1783 — The United States in North America (Mitchell Map)": a re-drawing of John Mitchell's famous mid-eighteenth-century map of eastern North America (simplified and reproduced at about one-third the width of the original), on which the original boundary of the United States was marked in 1783 (a heavy line keyed "Boundary line, Treaty of Paris, 1783"). Over the entire map lies a checkerboard grid of alternating shaded and white squares, columns numbered 1–36 across the top and rows lettered down the side — but the grid is warped: squares stretch, compress, and twist as they track the map. An inset at lower right shows the control: "1975 — The United States in North America," a modern Mercator-projection map showing the configuration of the eastern portion of North America with major drainage features, with the same labeled grid drawn perfectly rectangular, plus the modern boundary between Canada and the United States. The embedded caption (from the Atlas itself) explains the construction: the labeled grid on the modern map is arbitrary, designed to facilitate comparison between present-day geographic knowledge and the state of knowledge when Mitchell made the map; "in order to show the deformation of earth surface that Mitchell incorporated into his map (from either ignorance or error), a grid has been constructed on Mitchell's map that corresponds, square by square, with the rectangular grid on today's map. Since each labeled square on the Mitchell map has a counterpart on the modern map, the relative stretching, compressing, and twisting of the earth surface on the Mitchell map can be perceived."

Tufte's one-line commentary beneath (p. 146): "Here the grid is the element of interest, rather than the map." The grid's distortion field *is* the data — a quantitative display of eighteenth-century cartographic error. Sidenote citation: Lester J. Cappon, Barbara Bartz Petchenik, and John Hamilton Long, *Atlas of Early American History* (Princeton, 1976), p. 58.

### The data-carrying surface grid: Converse's election surfaces (p. 147)

"The grid that follows presents the data on the surface of the rock; on the sides, the grid is conventional. The two displays compare the effect of religion, taking into account party affiliation, on a person's vote for president in 1956 and in 1960 (when a Catholic ran for president). Note there is no reliable slope associated with religion in 1956, once party is controlled; in 1960, a systematic effect is found. Reading the slopes in the other direction shows the persistent effect of party in both elections" (p. 147). The metaphor: the 3-D surface is a "rock" whose top face carries the data grid (each grid intersection is a data point, each grid-line slope a comparison), while the rock's visible side faces carry ordinary reference grids. One grid object, two functions, and — anticipating the chapter's final section — two analytical questions answered by reading slopes in two different directions.

Sidenote citation (p. 147): Philip E. Converse, "Religion and Politics: The 1960 Election," in Angus Campbell, Philip E. Converse, Warren E. Miller, and Donald E. Stokes, *Elections and the Political Order* (New York, 1966), 102–103.

**Figure (p. 147):** Two three-dimensional fishnet surface plots, labeled 1956 (upper left) and 1960 (lower right). Each has: vertical axis "Democratic percentage of the two-party vote," labeled 0%, 25%, 50%, 75%, 100% on both the left front edge and the right rear frame; a horizontal axis "Party Identification" with categories Strong Democrat, Weak [Democrat], Independent, Weak Republican, Strong [Republican]; and a depth axis for religion running S(trong) Protestant, W(eak) Protestant, W(eak) Catholic, S(trong) Catholic. The surfaces are stippled; the front-left cut faces are shaded dark, showing the surface's cross-section against a conventional side grid. In the 1956 surface, height falls steadily from Strong Democrat (~90%+) to Strong Republican (near 0%) and the religion direction is essentially flat — ridges run level across Protestant/Catholic. In the 1960 surface the same party gradient persists, but the surface visibly tilts upward toward the Catholic side (Catholics at every party identification voting more Democratic — the Kennedy effect), so slopes along the religion direction are now systematic.

### Playfair's debt chart: grid lines keyed to events (p. 148)

"Playfair tied the grid to the data in his skyrocketing debt graphic. Although the implicit plotting coordinates are based on regular intervals, the vertical grid lines in the published version are irregularly spaced, keyed to significant events. The data-based grid is a shrewd graphical device, serving rather than fighting with the data. It is a technique underused in contemporary graphical work." (p. 148) The distinction drawn: the *coordinate system* remains a regular time scale (the data are plotted at their true dates), but the *drawn* vertical grid lines are placed only where history warrants them — so each grid line is an annotation, not wallpaper.

**Figure (p. 148, full page, reproduced in color):** William Playfair's "CHART of the National Debt of BRITAIN from the REVOLUTION to the End of the War with AMERICA" (title in an ornate engraved oval cartouche at upper left). The right-hand vertical scale is labeled "Millions," ruled in horizontal lines every 10 millions from 10 up to 300 (10, 20, … 290, 300). The bottom axis carries the years 1688, 1701, 1714, 1727, 1739, 1748, 1755, 1762, 1775, 1784 — irregular intervals. Each vertical grid line is labeled in slanted script with its event: "Revolution at the Accession of K. William," "Accession of Queen Ann," "Accession of George 1st," "Accession of George 2nd," "Beginning of the Spanish War," "End of the Spanish War," "Beginning of Continental War," "End of Continental War," "Beginning of American War," "End of American War." The debt itself is a heavy red stair-stepped line with the area beneath filled yellow: rising from near zero at the 1688 Revolution, climbing through each war, easing slightly after war-ends (a plateau/dip after the Spanish War around 1748, and a dip from about 145 to 135 millions before the American War), then rocketing during the American War to roughly 250 millions by its end in 1784. The chart thus reads as cause-and-effect: every steep rise of the red line is bracketed by a "Beginning of…" and "End of…" grid line.

## Double-Functioning Labels (pp. 149–152)

The section opens by chaining from the previous one: "Data-based coordinate lines lead to *data-based labels*, as, for example, at the bottom of Playfair's debt graphic. Again, the issue is the same: why not use the ink to show data?" (p. 149). (Playfair's bottom labels — the years of accessions and wars — already double-function as data-based labels.) The section then develops four label mobilizations: range-labels, order-encoding identification numbers, coordinate labels relocated onto the data, and fully data-labeled scatterplots.

### From frame to range-frame to range-frame with range-labels (p. 149)

Tufte builds the redesign in three displayed steps, each shown as a small axis figure:

1. **Conventionally labeled frame** (figure): a horizontal axis with a continuous frame line from end to end, downward ticks and labels at 0, 10, 20, 30, 40.
2. **Erased to the range-frame** (figure): the frame line now spans only the range of the data (starting somewhat right of 0 and ending short of 40); the labels 0, 10, 20, 30, 40 remain in place, so the 0 and 40 ticks now float detached beyond the line's ends. Tufte's reading of this intermediate state: erasing "leaves those lonely ticks and numbers out on the tails, working to help the eye get a better reading on where the line of the range-frame ends" (p. 149).
3. **Range-frame with range-labels** (figure): "But that job can be done better by investing the same ink in data: rather than showing the minimum round number and the maximum round number at the ends of the frame, show the actual minimum and maximum realized in the data" (p. 149). The final axis runs exactly from the data minimum to the data maximum and is labeled 4, 10, 20, 30, 37 — the ends carrying the true extremes (4 and 37) instead of round numbers (0 and 40), with no end ticks needed since the line's terminus is itself the mark.

The verdict (p. 149): "With its greater precision and two tick-marks less of non-data-ink, the range-frame with range-labels is superior to the range-frame with round number labels. Both improve on the standard, passive frame." Two gains are claimed: precision (exact extremes reported for free) and ink (two ticks erased).

### Identification numbers that encode an ordering: the tungsten chart (pp. 149–150)

The general principle first: "Numbers also double-function when used both to name things (like an identification number) and to reflect an ordering" (p. 149). Then the negative example: "In this graphic (in which the circled numbers fail to double-function), each number identifies a particular study of the thermal conductivity of tungsten, ordered alphabetically by the last name of the first author" (p. 149). Alphabetical order by author is information-free for the chart's purposes — the code numbers merely name.

The counterfactual redesign (pp. 149–150): "If that list were ordered by date of publication instead, then the code would also indicate the time order in which the various conductivity determinations were made. Thus '1' would indicate the earliest study, and so on — or, alternatively, '61c' would be the third study published in 1961. Such information has interest, since we could see which of the early studies got the right answer. In addition, the movement of the studies toward the 'correct' recommended values could be tracked. This extra information requires no additional ink." (p. 150) Note the two alternative encodings offered (pure rank order "1, 2, 3, …" vs. year-plus-letter "61c") and the two analytical payoffs (judging early studies against the eventual answer; watching the scientific literature converge). The closing sentence — "This extra information requires no additional ink" — is the section's recurring economic argument: double-functioning is free.

Sidenote citation (p. 150): C. Y. Ho, R. W. Powell, and P. E. Liley, *Thermal Conductivity of the Elements: A Comprehensive Review*, supplement no. 1, *Journal of Physical and Chemical Reference Data*, 3 (1974), 1–692.

**Figure (p. 150, full width):** A dense technical chart titled "THERMAL CONDUCTIVITY OF TUNGSTEN." Y-axis: "THERMAL CONDUCTIVITY, W cm⁻¹ K⁻¹," from 0.5 to 1.9; X-axis: "TEMPERATURE, K," from 0 to 4000 (labeled every 200). Dozens of thin curves, each a published study's measurements, each tagged with a small circled identification number (numbers visible across the plot: 7, 9, 14, 18, 21, 35, 44, 63, 76, 78, 100, 154, and many more); the curves disagree wildly, especially below ~600 K where several spike toward 1.9 and in the 1400–2800 K region where they crisscross chaotically. A heavy bold curve labeled "RECOMMENDED" runs through the cloud, descending from the low-temperature peak and flattening near 0.9 at high temperatures; past the melting point (marked "M.P. 3660 K") it continues as a heavy dashed segment labeled "PROVISIONAL (liquid)" with a step down near 3700 K. The chart embodies the missed opportunity: with date-ordered codes the same picture would also narrate the history of measurement.

### Coordinate labels as data measures: the JASA histogram redesign (pp. 150–151)

The general problem (p. 150): "In most graphics, the coordinate labels are far from the data measures. Consequently the eye of the viewer must move back and forth between the path formed by the data and the coordinate positions arrayed along the margins of the graphic. Sometimes this eye-work can be eliminated entirely by turning the coordinate labels into data measures, another double-functioning maneuver. Take the example from the style sheet of the *Journal of the American Statistical Association*:"

**Figure (p. 150, margin):** The starting point — the JASA style sheet's exemplar histogram: a right-skewed probability distribution drawn as many thin vertical bars, Y-axis labeled .05, .10, .15, X-axis labeled 0, 5, 10, 15 (the variable is ω; the full version with axis titles "AVERAGE PROBABILITY" appears again on p. 164 in Chapter 8, where Tufte computes its data density). The mode is at 0 (height ≈ .177) and the tail runs out past 15.

**Redesign step 1 (figure, p. 151):** "The grid increments of the X-axis are relocated upward to mark the path of the data" (p. 151). The bars vanish entirely. Each integer label 0, 1, 2, 3, … 15 is printed *at the position its bar-top occupied*: "0" floats high (at probability ≈ .177), "1" lower (≈ .114), "2," "3," "4," "5" stepping down, and "6 7 8 9 10 11 12 13 14 15" settling along the bottom as the probabilities approach zero. The conventional Y-labels .15, .10, .05, .00 remain at the left margin. The number-labels now do triple duty: they name the integer values, locate the data path (replacing the bars), and their descending arc draws the distribution's shape.

**Redesign step 2 (figure, p. 151):** "And since the issue in this display is the probability at each integer value, the round-number Y-scale is replaced by exact values" (p. 151). The left margin now reads, from top to bottom at the corresponding data heights: .177, .114, .075, .052, .034, .025, .004, .002 — each number printed at exactly the height of the X-integer it belongs to (.177 across from "0," .114 across from "1," .075 across from "2," .052 across from "3," .034 across from "4," .025 across from "5," with .004 and .002 near the bottom for the tail values). The redesign's interpretation (p. 151): "The Y-scale now resembles the dashes of the dot-dash-plot, with the vertical column of data-positioned numbers serving as the dashes to indicate the marginal distribution." The Y-labels thereby quadruple-function: exact value report, scale, data-path marker, and marginal-distribution display.

### The fully data-labeled scatterplot (p. 152)

"The method of data-based markers for the marginal distributions suggests a further enhancement of the dot-dash-plot:" (p. 152).

**Figure (p. 152):** A frameless scatterplot of seven points. There is no frame, no range-frame, no ticks. Down the left margin, the exact Y-values of the seven observations are printed at their own heights: 20.3, 15.2, 14.6, 11.3, 10.1, 8.4, 5.1. Along the bottom margin, the exact X-values are printed (rotated vertically) at their own horizontal positions: 81, 123, 182, 227, 255, 291, 357. Each plotted dot sits at the intersection of one Y-number and one X-number.

The summary of what the marginal numbers accomplish (p. 152): "Now the numbers in the margin eliminate the standard frame and even a range-frame, replace the coordinate ticks, show the marginal distribution of both variables, and record the exact values of the two measurements made on each unit of observation." Four functions itemized. Then the scope qualification: "This graphical arrangement performs better for smaller data sets (say 30 observations or less) and when a fine level of detail is required." (p. 152) — an explicit boundary condition: with many observations the marginal number-columns would collide and clutter.

### Carol Moore's annual-report design (p. 152)

"Finally, a striking design with data-based labels:" (p. 152).

**Figure (p. 152):** A reversed (white-on-black) square panel from a corporate annual report. A family of thin white curves sweeps from labels at the left edge rightward and downward across the black field; each curve terminates in a comb of fine vertical fringe lines descending to the bottom, so the curves and their fringes form nested, waterfall-like profiles (taller, longer curves at top; progressively shorter, denser ones toward the bottom-left, ending in a packed vertical-line texture along the bottom). Small numeric labels sit at the data. The example's role: proof that data-based labeling is compatible with — indeed can produce — graphic elegance. Sidenote citation: "Designed by Carol Moore, Corporate Annual Reports, Inc., in Walter Herdeg, *Graphis/Diagrams* (Zurich, 1976), p. 23."

## Puzzles and Hierarchy in Graphics (pp. 153–159)

The final section returns to the danger announced on p. 139 and converts it into a positive design theory: how to be complex without being cryptic.

### The puzzle diagnosis (p. 153)

"The complexity of multifunctioning elements can sometimes turn data graphics into visual puzzles, crypto-graphical mysteries for the viewer to decode. A sure sign of a puzzle is that the graphic must be interpreted through a verbal rather than a visual process." (p. 153) This is the operational test: watch whether comprehension proceeds by seeing or by silently reciting decoding rules.

### The two-variable color map as puzzle graphic (p. 153)

The test is applied to a showpiece: "For example, despite its clever and multifunctioning data measure, formed by crossing two four-color grids, this is a puzzle graphic. Deployed here, in a feat of technological virtuosity, are 16 shades of color spread on 3,056 counties, a monument to a sophisticated computer graphics system." (p. 153) Note the rhetorical structure: Tufte concedes everything the map's makers would claim (clever, multifunctioning, virtuosic, technologically sophisticated) before applying the verbal-process test: "But it is surely a graphic experienced verbally, not visually. Over and over, the viewers must run little phrases through their minds, trying to maintain the right pattern of words to make sense out of the visual montage: 'Now let's see, purple represents counties where there are both high levels of male cardiovascular disease mortality *and* 11.6 to 56.0 percent of the households have more than 1.01 persons per room. . . . What does that mean anyway? . . . And the yellow-green counties. . . .'" (p. 153) The staged interior monologue — including the trailing bafflement — is itself the evidence.

The contrast principle: "By contrast, in a non-puzzle graphic, the translation of visual to verbal is quickly learned, automatic, and implicit — so that the visual image flows right *through* the verbal decoder initially necessary to understand the graphic." (p. 153) So a verbal decoder is permitted, even necessary at first — but in a good graphic it is learned once and then becomes transparent. The point is sealed with the quotation: "As Paul Valéry wrote, 'Seeing is forgetting the name of the thing one sees.'" (p. 153)

Footnote 5 (p. 153): "The technique is described in Vincent P. Barabba and Alva L. Finkner, 'The Utilization of Primary Printing Colors in Displaying More than One Variable,' in Bureau of the Census, Technical Paper No. 43, *Graphical Presentation of Statistical Information* (Washington, D.C., 1978), 14–21. The maps are assessed in Howard Wainer and C. M. Francolini, 'An Empirical Inquiry Concerning Human Understanding of Two-Variable Color Maps,' *American Statistician*, 34 (1980), 81–93." (The Wainer–Francolini study empirically confirmed viewers' difficulty with these maps — the footnote supplies the experimental backing for Tufte's verdict.)

**Figure (p. 153, in color):** The Census Bureau's two-variable color map of the United States by county. Every one of the 3,056 counties is filled with one of 16 colors generated by crossing a four-level color scale for male cardiovascular death rate with a four-level color scale for household crowding. The legend at lower right is a 4 × 4 matrix of color chips: one axis labeled "DEATH RATE PER 100,000 PERSONS" with four brackets (running from 0.00–718.94 at the bottom up to 938.52–2306.86 at the top, with intermediate brackets near 718.95–827.78 and 827.79–938.51 as legible in the reproduction), the other axis labeled "PERCENT" with four brackets of households having more than 1.01 persons per room (the top bracket being the 11.6-to-56.0-percent range quoted in Tufte's text). The map surface is a mosaic of reds, maroons, purples, golds, and yellow-greens: dark maroon/near-black saturating the Southeast (high on both variables), reds across much of the interior, yellows and purples scattered through the Plains and Mountain West. Striking as a poster; undecodable as data, county by county, without continuous verbal rehearsal.

### Why color puzzles: no natural visual ordering (p. 154)

"Color often generates graphical puzzles. Despite our experiences with the spectrum in science textbooks and rainbows, the mind's eye does not readily give a visual ordering to colors, except possibly for red to reflect higher levels than other colors, as in the hot spots of the cancer map." (p. 154) Two details matter: the explicit rejection of spectral ordering as perceptually available (book-learning about rainbows does not make wavelength order *visible*), and the single conceded exception — red as "more," as used for the high-rate "hot spots" in the cancer-atlas map shown earlier in the book.

"Attempts to give colors an order result in those verbal decoders and the mumbling of little mental phrases again — indeed, even mnemonic phrases *about* the phrases required for graphical decoding:" (p. 154). The historical exhibit is then block-quoted from Funkhouser:

> "A method of coloring ingenious in idea but not very satisfactory in practice was used by L. L. Vauthier. It was called the mountain-to-the-sea method. White was used for the representation of the greatest intensity of the fact because it indicated the summit of a mountain with its eternal snow, next came green representing the forests farther down the slopes, then yellow for the grain of the plains, and finally for the minimum the blue of the waters at sea level." (p. 154)

The mountain-to-the-sea scheme (white → green → yellow → blue for greatest → least intensity) is exactly a "mnemonic phrase about the phrases": one must memorize the mountain story to remember the color order, and recite the color order to read the map — two layers of verbal apparatus. Footnote 6 (p. 154): "H. Gray Funkhouser, 'Historical Development of the Graphical Representation of Statistical Data,' *Osiris*, 3 (1937), 326, who cites É. Cheysson, 'Les méthodes de statistique graphique à l'Exposition universelle de 1878,' *Journal de la Société de Statistique de Paris*, 19 (1878), 331."

### Gray's natural hierarchy: the galaxies map (p. 154)

The positive alternative: "Because they do have a natural visual hierarchy, varying shades of gray show varying quantities better than color. Ten gray shades worked effectively in the galaxies map:" (p. 154).

**Figure (p. 154):** A wide horizontal strip from the map of over a million galaxies (shown in full earlier in the book, Chapter 1): a mottled gray field in which each tiny cell's gray level encodes the count of galaxies there, darker for more. Filaments, clusters, and voids read instantly as texture and tone — no legend rehearsal required, because lighter-to-darker *is seen as* less-to-more.

### The key principle: organize and order the flow (p. 154)

The section's pivot from criticism to theory (p. 154): "The success of gray compared to the visually more spectacular color gives us a lead on how multifunctioning graphical elements can communicate complex information without turning into puzzles. The shades of gray provide an easily comprehended order to the data measures. This is the key. Central to maintaining clarity in the face of the complex are graphical methods that *organize and order the flow of graphical information* presented to the eye."

Then the research questions, posed directly (p. 154): "How can graphical architecture promote the ordered, sequenced, hierarchical flow of information from the graphic to the mind's eye? How can the data-information be arranged so that the viewer is able to peel back layer after layer of data from a graphic?" And the two-part answer that organizes the rest of the chapter: "Multiple layers of information are created by *multiple viewing depths* and *multiple viewing angles*." (p. 154)

### Multiple viewing depths: the Census population map (pp. 155–157)

The definition, with its three-level enumeration (p. 155): "Graphics can be designed to have at least three viewing depths: (1) what is seen from a distance, an overall structure usually aggregated from an underlying microstructure; (2) what is seen up close and in detail, the fine structure of the data; and (3) what is seen implicitly, underlying the graphic — that which is behind the graphic."

The exemplar (p. 155): "Look at all the different levels of detail created by this population density map of the United States, a glory of modern cartography prepared by the Bureau of the Census. Each dot, except in urban centers, represents 500 people. Note the corridors connecting the major urban complexes; the effects of landforms on the population distribution (the central valley of California, the valleys and ridges of Appalachia, and the clusters along rivers); and the small towns along the highways, linked like a string of pearls. The map arrays, in effect, some 400,000 points on its implicit grid."

**Figure (pp. 156–157, two-page color spread):** "Population Distribution, Urban and Rural, in the United States: 1970." The conterminous United States rendered as a dark mass on a tan ground, built from hundreds of thousands of fine dots (rural population, one dot per 500 people), with urban places shown as white/bright marks that blaze out of the dark field — the great metropolitan corridors (Boston–Washington, the Midwest industrial belt, California's coast and central valley) reading as constellations. Alaska and Hawaii appear as insets at lower left. A legend at right distinguishes URBAN POPULATION (urbanized areas, plus places outside urbanized areas in graduated size classes) from RURAL POPULATION (the 500-person dots). The map demonstrates the three depths: at arm's length, the macrostructure of American settlement (the dense East, the abrupt thinning at roughly the 100th meridian, the empty intermountain West); close up, the fine structure Tufte itemizes (corridors, valley and ridge lines, river clusters, highway towns "like a string of pearls"); and implicitly, the third layer behind the graphic — the continent's physical geography and transportation network, nowhere drawn yet everywhere visible as the shape the dots take.

### Multiple viewing angles: Ayres revisited (p. 155)

"Different visual angles for different aspects of the data also organize graphical information. Each separate line of sight should remain unchanging (preferably horizontal or vertical) as the eye watches for data variation off the flat of the line of sight. For multivariate work, several clear lines can be created." (p. 155) The design rule: assign each variable or comparison its own fixed scanning direction, so the eye holds one line of sight steady and reads variation against it; horizontal and vertical lines of sight are preferred.

The exemplar is the chart from p. 141, reproduced again on p. 155: "Recall Ayres' display of American divisions in France. Even with its complex, interwoven data, the graphic is not a puzzle. Three separate visual angles make the flow of information coherent: the profile of the horizon for the upward-moving time-series, the vertical for the composition of the bar, and the horizontal for each division's stay. Thus while every drop of ink serves three different data display functions, each of the three comes to the eye with its own independence and integrity." (p. 155) This closes the loop on the chapter's opening standard (information "not confounded and mixed together"): Ayres' triple-functioning ink avoids puzzlement precisely because each function owns a distinct viewing angle — scan the silhouette for the time-series, scan down a column for a month's roster, scan along a row for a division's tenure.

### The slopegraph: several viewing directions in one table-graphic (pp. 158–159)

**Figure (p. 158, full page):** "Current Receipts of Government as a Percentage of Gross Domestic Product, 1970 and 1979." Two vertical columns of country names with values, headed 1970 (left) and 1979 (right), each country's two entries joined by a thin straight line; vertical position is proportional to the percentage, so the columns are simultaneously scaled number lines and ranked lists. The complete data:

| Country | 1970 | 1979 |
|---|---|---|
| Sweden | 46.9 | 57.4 |
| Netherlands | 44.0 | 55.8 |
| Norway | 43.5 | 52.2 |
| Britain | 40.7 | 39.0 |
| France | 39.0 | 43.4 |
| Germany | 37.5 | 42.9 |
| Belgium | 35.2 | 43.2 |
| Canada | 35.2 | 35.8 |
| Finland | 34.9 | 38.2 |
| Italy | 30.4 | 35.7 |
| United States | 30.3 | 32.5 |
| Greece | 26.8 | 30.6 |
| Switzerland | 26.5 | 33.2 |
| Spain | 22.5 | 27.1 |
| Japan | 20.7 | 26.6 |

(In the 1979 column the printed order is Sweden 57.4, Netherlands 55.8, Norway 52.2, France 43.4, Belgium 43.2, Germany 42.9, Britain 39.0, Finland 38.2, Canada 35.8, Italy 35.7, Switzerland 33.2, United States 32.5, Greece 30.6, Spain 27.1, Japan 26.6 — the re-ranking is visible as line crossings. Britain's line is the only one sloping downward, 40.7 → 39.0; the three Scandinavian-bloc leaders pull far above the rest; Belgium and Switzerland make the largest rank gains.)

Tufte's analysis of the design (p. 159): "Similarly, this table-graphic organizes data for viewing in several directions. The chart, when read vertically, ranks 15 countries by government tax collections in 1970 and again in 1979, with the names spaced in proportion to the percentages. Across the columns, the paired comparisons show how the numbers changed over the years. The slopes are also compared by reading down the collection of lines, and lines of unusual slope stand out from the overall upward pattern. The information shown is both integrated and separated: integrated through its connected content, separated in that the eye follows several different and uncluttered paths in looking over the data:"

So this single chart supports at least four readings: (1) vertical, within either column — the ranking and the proportional spacing of the countries in that year; (2) horizontal, along each line — one country's change over the decade; (3) down the collection of slopes — the distribution of changes, with the overall upward drift (governments everywhere taking a larger share of GDP) as the norm against which Britain's lone decline stands out; and (4) the exact values themselves, since every number is printed. The phrase "both integrated and separated" names the resolution of the chapter's central tension — multifunctioning ink (integration) with unconfounded readings (separation).

**Figure (p. 159):** A small abstract schema of the slopegraph's viewing architecture: two vertical double-headed arrows (the two column-reading directions) crossed by a stack of horizontal double-headed arrows (the country-by-country comparisons) — a diagram of the several independent, uncluttered eye-paths through the same display.

### Closing sentence (p. 159)

The chapter ends by naming the analytical tool it has just demonstrated: "Such an analysis of the *viewing architecture* of a graphic will help in creating and evaluating designs that organize complex information hierarchically." (p. 159) "Viewing architecture" — the designed structure of depths and angles through which a viewer's eye moves — is the chapter's final term of art and its bequest to the rest of the book (Chapter 9's "Aesthetics and Technique" and the epilogue's friends-of-data ideas build on it).

## Position in the Book and Transitions

- **Backward links:** The chapter assumes Chapter 6's vocabulary throughout — data-ink, non-data-ink, erasing, the range-frame, quartile frame, dot-dash-plot, and the blot map. Its opening move (mobilize the under-employed frame) is a restatement of Chapter 6's erase-and-redesign program in constructive form: instead of erasing idle ink, give it a job. The galaxies map (Chapter 1) and the cancer maps (Chapters 1 and 2) are recalled as touchstones on p. 154.
- **The escalating sequence of Data-Built Data Measures** is itself an argument: shaded scatterplot dots (one extra variable) → stem-and-leaf digits (data as marks) → living histogram (people as marks) → Ayres (names as marks, triple-functioning) → Chernoff faces (k-dimensional marks) → declared "limit of graphical economy… and, let it be admitted, eccentricity" (p. 142) → then the deliberate surprise that the supposed limit was reached by a 17th-century poet (Easter Wings) and a statistician's typography (Youden), → finally the pure "graphical pun" where mark and phenomenon are identical (lane stripes, p. 144). The sequence demonstrates that data-built measures are not a computer-age novelty but a recurring design discovery.
- **Forward link:** The chapter's last page (p. 159) faces the epigraph page (p. 160) that opens Chapter 8 ("Data Density and Small Multiples"): "I want to reach that state of condensation of sensations which constitutes a picture. — Henri Matisse." The Matisse line belongs to Chapter 8, but it is the natural sequel to Chapter 7's program: multifunctioning elements are exactly the means of condensation, and Chapter 8 immediately quantifies the payoff (data density), using Chapter 7's JASA histogram again on p. 164 as its low-density example (3.8 numbers per square inch).

## Checklist of Terms of Art Introduced or Centrally Used in Chapter 7

- **multifunctioning graphical elements** (p. 139) — ink serving more than one graphical purpose: data + design function, or several data pieces at once.
- **data measure** (p. 139) — "The graphical element that actually locates or plots the data."
- **double-functioning element** (p. 139, footnote 1) — the Venturi/architectural ancestor of the idea.
- **strangers** (p. 142) — outlying/inconsistent faces (observations) in a Chernoff-face scatter, to be identified by number or name.
- **graphical pun** (p. 144) — the visual data as the data measure (lane stripes; living histogram).
- **data-based grid** (pp. 145–148) — grid ink that reports on the data (instrument-location grids, data-as-grid, event-keyed grid lines).
- **data-based labels** (p. 149) — labels carrying data: range-labels, order-encoding ID numbers, data-positioned coordinate labels.
- **range-frame with range-labels** (p. 149) — range-frame whose end labels are the realized data minimum and maximum.
- **puzzle graphic / crypto-graphical mystery** (p. 153) — a graphic interpretable only through a sustained verbal process.
- **verbal decoder** (p. 153) — the recited rule-set for reading a graphic; legitimate only if it becomes automatic and implicit.
- **multiple viewing depths** (pp. 154–155) — at least three: distant overall structure; close fine structure; the implicit layer behind the graphic.
- **multiple viewing angles / lines of sight** (pp. 154–155) — fixed (preferably horizontal/vertical) scanning directions, one per aspect of the data.
- **integrated and separated** (p. 159) — the dual character of well-organized complex display: connected content, uncluttered separate eye-paths.
- **viewing architecture** (p. 159) — the overall designed structure of depths and angles; the analytic frame for "designs that organize complex information hierarchically."
