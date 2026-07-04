# Chapter 8: Data Density and Small Multiples — Detailed Account

This file is the deep reference layer for Chapter 8 of Edward Tufte, *The Visual Display of Quantitative Information* (2nd ed.), printed pages 160–175. It reproduces the chapter's full argument, every number, every figure (described), and every footnote and sidenote. Page citations are to the printed book.

The chapter belongs to Part II, "Theory of Data Graphics" (the running head on every left-hand page reads "THEORY OF DATA GRAPHICS"; right-hand pages read "DATA DENSITY AND SMALL MULTIPLES"). It follows Chapter 7, "Multifunctioning Graphical Elements," and precedes Chapter 9, "Aesthetics and Technique in Data Graphical Design."

## Epigraph (p. 160)

The chapter is preceded by a single epigraph, set alone on the otherwise blank verso page facing the chapter opening:

> "I want to reach that state of condensation of sensations which constitutes a picture."
> — Henri Matisse

The epigraph announces the chapter's theme before any argument begins: a picture is, at its best, a *condensation* — many sensations (data) compressed into a small space. The entire chapter is an operationalization of Matisse's remark: measure the condensation (data density), maximize it (high-information graphics), compress further (the Shrink Principle), and repeat the compressed result (small multiples).

## The Eye's Resolving Power (pp. 161–162)

The chapter opens not with graphics at all but with human perception. Tufte's strategy is to establish first how much the eye *can* see, so that the later empirical findings about how little published graphics actually show land as an indictment of design practice rather than a concession to perceptual limits.

The opening sentences (p. 161):

> "Our eyes can make a remarkable number of distinctions within a small area. With the use of very light grid lines, it is easy to locate 625 points in one square inch or, equivalently, 100 points in one square centimeter."

He then escalates: "Or consider how an 80 by 80 grid over a square inch — about 30 by 30 over a square centimeter — divides the space" (p. 161). The accompanying figure is a small printed square, roughly one inch on a side, filled with an extremely fine crosshatched gray grid; its sidenote label reads "25,281 distinctions."

**Footnote 1 (p. 161)** supplies the combinatorial arithmetic behind the 25,281 figure: "A square grid formed on each side by n parallel black and n−1 parallel white lines contains n² intersections of two black lines (corners of squares), (n−1)² intersections of two white lines (white squares), and 2n(n−1) intersections of a black and white line (sides of squares), for a total of (2n−1)² line intersections or distinct locations." With n = 80, (2·80 − 1)² = 159² = 25,281 distinct locations in one square inch.

Tufte then qualifies and broadens the claim (p. 161): "With the help of considerable redundancy and context, our eyes make fine distinctions of this sort all the time." The qualification matters — the eye achieves such resolution not in isolation but aided by redundancy and context, which is exactly what a well-designed graphic provides. Three everyday demonstrations follow:

1. **Engraved measurement scales.** "Measurement instruments used in engineering, architectural, and machine work are engraved with scales of 20 increments to the centimeter and 50 to the inch" (p. 161). People read these routinely.

2. **Fine print.** "The type in the U.S. *Statistical Abstract* is set at 12 lines per vertical inch, with each line running about 23 characters per inch for a maximum density of 276 characters per square inch. The actual density, given the white space, is in this case 185 characters per square inch or 28 per square centimeter" (p. 161). Note the careful distinction between *maximum* density (12 × 23 = 276) and *actual* density (185), the latter accounting for white space — the same gross-versus-net care Tufte applies later when counting data-matrix entries.

   The figure for this point (p. 161, bottom of page, full text-width) reproduces an actual table from the *Statistical Abstract*: "No. 1450. Steel Products — Net Shipments, by Market Classes: 1960 to 1978," with the bracketed headnote "[In thousands of short tons. Comprises carbon, alloy, and stainless steel. 'N.e.c.' means not elsewhere classified]." The table has nine year-columns (1960, 1965, 1970, 1973, 1974, 1975, 1976, 1977, 1978) and roughly two dozen market-class rows: Total; Steel for converting and processing; Independent forgers, n.e.c.; Industrial fasteners; Steel service centers, distributors; Construction, incl. maintenance; Contractors' products; Automotive; Rail transportation (freight cars, passenger cars, locomotives); Rails and all other; Shipbuilding and marine equip.; Aircraft and aerospace; Oil and gas industries; Mining, quarrying, and lumbering; Agricultural, incl. machinery; Machinery, industrial equip., tools; Electrical equipment; Appliances, utensils, and cutlery; Other domestic commercial equip.; Containers, packaging, shipping; Cans and closures; Ordnance and other military; Exports (reporting companies only). The Total row runs 71,149 (1960); 92,666 (1965); 90,798 (1970); 111,430 (1973); 109,472 (1974); 79,957 (1975); 89,447 (1976); 91,147 (1977); 97,935 (1978) thousands of short tons. Three table footnotes: (1) the total includes nonclassified shipments and, beginning 1970, the data include estimates for a relatively small number of companies that report raw steel production but not shipments; (2) "Industrial fasteners" comprises bolts, nuts, rivets, and screws; (3) "Rails and all other" includes railway and rapid-transit systems, railroad rails, track work, and equipment. The table's role in the argument is purely typographic: ordinary government typesetting routinely delivers ~185 readable characters per square inch, so the eye plainly handles such densities. **Sidenote citation:** U.S. Bureau of the Census, *Statistical Abstract of the United States: 1979* (Washington, D.C., 1979), p. 822.

3. **Cartography.** Maps "routinely present even finer detail" (p. 162). Tufte quotes a cartographer: "the resolving power of the eye enables it to differentiate to 0.1 mm where provoked to do so. Clearly, therefore, conciseness is of the essence and high resolution graphics are a common denominator of cartography." He adds the conversion: "Distinctions at 0.1 mm mean 254 per inch" (p. 162). **Footnote 2:** D. P. Bickmore, "The Relevance of Cartography," in John C. Davis and Michael J. McCullagh, eds., *Display and Analysis of Spatial Data* (London, 1975), p. 331. Bickmore's phrase "where provoked to do so" carries the design moral: the eye delivers high resolution when the graphic provokes it; thin graphics never ask.

The section closes by turning the perceptual evidence into the chapter's two driving questions (p. 162):

> "How many statistical graphics take advantage of the ability of the eye to detect large amounts of information in small spaces? And how much information should graphics show? Let us begin by considering an empirical measure of graphical performance, the data density."

## Data Density in Graphical Practice (pp. 162–166)

### Definition (p. 162)

> "The numbers that go into a graphic can be organized into a *data matrix* of observations by variables. Taking into account the size of the graphic in relation to the amount of data displayed yields the *data density*:"

> **data density of a graphic = (number of entries in data matrix) / (area of data graphic)**

Two terms of art are defined here. The **data matrix** is the underlying table of observations by variables from which the graphic is drawn; its **size** is its number of entries. **Data density** divides that count by the graphic's printed area. Both quantities are measured for real published graphics throughout the rest of the chapter, making the index empirical rather than hypothetical. Tufte immediately notes: "Data matrices and data densities vary enormously in practice" (p. 162) — and the next four pages document that variation across nearly six orders of magnitude, from 0.15 to 110,000 numbers per square inch, in a deliberately ascending sequence.

### The low extreme: an overwrought bar chart at 0.15 numbers per square inch (pp. 162–163)

> "At one extreme, this overwrought display (originally printed in five colors) presents a data matrix of four entries, the names and the numbers for the two bars on the right. The left bar is merely the total of the other two. The graph covers 26.5 square inches (171 square centimeters), resulting in a data density of .15 numbers per square inch (.02 numbers per square centimeter), which is thin indeed." (p. 162)

The figure occupies nearly all of p. 163: a bar chart of adult-education participation with a vertical "Percent" scale from 0 to 35, full-width horizontal grid lines at every 5 percentage points, and three solid black bars — "TOTAL PARTICIPATION" (about 16 percent), "In college or university" (about 7–8 percent), and "In adult education" (about 8–9 percent) — clustered in the lower-left quarter of an otherwise empty field. The vast majority of the 26.5 square inches is blank or grid. **Sidenote citation:** Executive Office of the President, Office of Management and Budget, *Social Indicators, 1973* (Washington, D.C., 1973), p. 86.

Note the counting discipline: although the chart shows three bars, Tufte credits it with only **four** data-matrix entries — the names and numbers for the two right-hand bars — because the left bar is redundant, "merely the total of the other two." Redundant data do not count toward the matrix. This is the chapter's first counting rule.

### The profession's own exemplar: 3.8 numbers per square inch (p. 164)

> "The exemplar from the JASA style sheet comes in at a lightweight 3.8 numbers per square inch (0.6 numbers per square centimeter) and a small data matrix of 32 entries." (p. 164)

The figure is the model graphic from the style sheet of the *Journal of the American Statistical Association*: a histogram labeled "AVERAGE PROBABILITY" on the vertical axis (tick marks at 0.05, 0.10, 0.15) against ω on the horizontal axis (0 to beyond 15), drawn as many narrow open vertical bars declining steeply from a peak near zero in a roughly exponential decay. The rhetorical sting is that this thin graphic is the *statistics profession's own published exemplar* — the model authors are told to imitate.

### A data-rich newspaper graphic, even when shrunk: 181 numbers per square inch (p. 164)

> "In contrast, the New York weather history, in this reduced version, does very well at 181 numbers per square inch (28 per square centimeter)." (p. 164)

The figure is a deliberately reduced reproduction of "NEW YORK CITY'S WEATHER FOR 1980" (the *New York Times* design also praised in Chapter 1): a year-long panel, months January through December across the top, showing each day's actual high–low temperature range as a vertical band against smooth curves labeled "LINE INDICATES NORMAL HIGH" and "LINE INDICATES NORMAL LOW," with an inset legend comparing 1980 annual temperature to normal, an annotation flagging the year's high ("HIGH July 21: 102°") and another flagging the year's low of −1° in late December; below it, a "PRECIPITATION IN INCHES" panel of monthly actual-versus-normal paired bars (with the year's total and normal precipitation stated), and beneath that a relative-humidity strip in percent. The example does double duty in the argument: it shows that data-rich design exists in journalism, and — because Tufte computes the 181/sq in figure on the *reduced* version — it quietly previews the Shrink Principle: dense designs survive shrinking.

### An annual sunshine record: ~1,000 numbers per square inch, and a lesson about visual metaphor (p. 165)

> "An annual sunshine record reports about 1,000 numbers per square inch (160 per square centimeter)." (p. 165)

**Sidenote citation:** F. J. Monkhouse and H. R. Wilkinson, *Maps and Diagrams* (London, third edition, 1971), pp. 242–243.

The original figure (top of p. 165) is a wide chart, months January through December across the bottom, hour of day on the vertical scale, with curved envelope lines labeled "Sunset" and "Sunrise" bounding the possible daylight hours (the envelope bulges in midsummer). Within the envelope, dense dark vertical strips mark when the sun actually shone, day by day through the year — dark ink encodes sunshine.

Tufte then prints a second version of the same image (bottom of p. 165), photographically reversed — a black field in which white marks show the sunshine, the sunrise/sunset envelope traced as light dashed curves:

> "The visual metaphor corresponds appropriately to the data if the image is reversed, so that the light areas are the times when the sun shines." (p. 165)

This is a deliberate aside within the density sequence: density alone is not sufficient. Even at 1,000 numbers per square inch, the encoding should be semantically apt — light should depict light. The redesign costs nothing in density and gains in meaning.

### Bertin's map of the communes of France: ~9,000 numbers per square inch (p. 166)

The figure fills most of p. 166: the outline of France rendered entirely as the boundary mesh of its communes — tens of thousands of tiny irregular polygons, denser and finer in some regions than others, forming the national shape with no other linework. **Sidenote citation:** Jacques Bertin, *Semiologie Graphique* (Paris, second edition, 1973), p. 152.

> "This map (27 square inches, 175 square centimeters) shows the location and boundaries of 30,000 communes of France. It would require at least 240,000 numbers to recreate the data of the map (30,000 latitudes, 30,000 longitudes, and perhaps six numbers describing the shape of each commune). Thus that data density is nearly 9,000 numbers per square inch, or 1,400 numbers per square centimeter." (p. 166)

Here is the chapter's second counting rule: for a map, count the numbers needed to *recreate* the displayed data — each commune contributes its latitude, its longitude, and roughly six shape-describing numbers, hence 30,000 × 8 = 240,000 entries on 27 square inches ≈ 8,900/sq in.

### The map of the galaxies: 110,000 numbers per square inch — "the current record" (p. 166)

> "The new map of the galaxies locates 2,275,328 encoded rectangles on a two-dimensional surface of 61 square inches (390 square centimeters). Each rectangle represents three numbers (two by its location, one by its shading), yielding a data density of 110,000 numbers per square inch or 17,000 numbers per square centimeter. That is the current record." (p. 166)

The accompanying figure (small, lower-right of p. 166) is a detail patch of the galaxy map: a grainy field of dark specks and clotted clusters — the texture of millions of encoded rectangles. (The full map is the one presented in Chapter 1.) The counting rule here generalizes the previous one: each plotted mark counts for as many numbers as it independently encodes — two coordinates by position plus one value by shading, so 2,275,328 × 3 = 6,825,984 numbers ÷ 61 sq in ≈ 110,000/sq in.

The ascending sequence is now complete: 0.15 → 3.8 → 181 → ~1,000 → ~9,000 → 110,000 numbers per square inch. The five-to-six-order-of-magnitude span is itself the argument: published practice occupies the bottom of a range whose top is demonstrably readable.

## Data Density and the Size of the Data Matrix: Publication Practices (pp. 167–168)

Having defined the measure and shown its range, Tufte reports an empirical survey of publication practice — his own study of statistical graphics in 21 scientific and news publications:

> "The table shows the data density and the size of the data matrix for graphics sampled from scientific and news publications. At least 20 graphics from each publication were examined." (p. 167)

The table (p. 167), reproduced in full:

**Data Density and Size of Data Matrix, Statistical Graphics in Selected Publications, Circa 1979–1980**

| Publication | Data Density (numbers per sq in): median | min | max | Size of Data Matrix: median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| *Nature* | 48 | 3 | 362 | 177 | 15 | 3780 |
| *Journal of the Royal Statistical Society, B* | 27 | 4 | 115 | 200 | 10 | 1460 |
| *Science* | 21 | 5 | 44 | 109 | 26 | 316 |
| *Wall Street Journal* | 19 | 3 | 154 | 135 | 28 | 788 |
| *Fortune* | 18 | 5 | 31 | 96 | 42 | 156 |
| *The Times* (London) | 18 | 2 | 122 | 50 | 14 | 440 |
| *Journal of the American Statistical Association* | 17 | 4 | 167 | 150 | 46 | 1600 |
| *Asahi* | 13 | 2 | 113 | 29 | 15 | 472 |
| *New England Journal of Medicine* | 12 | 3 | 923 | 84 | 8 | 3600 |
| *The Economist* | 9 | 1 | 51 | 36 | 3 | 192 |
| *Le Monde* | 8 | 1 | 17 | 66 | 11 | 312 |
| *Psychological Bulletin* | 8 | 1 | 74 | 46 | 8 | 420 |
| *Journal of the American Medical Association* | 7 | 1 | 39 | 53 | 14 | 735 |
| *New York Times* | 7 | 1 | 13 | 35 | 6 | 580 |
| *Business Week* | 6 | 2 | 12 | 32 | 14 | 96 |
| *Newsweek* | 6 | 1 | 13 | 23 | 2 | 96 |
| *Annuaire Statistique de la France* | 6 | 1 | 25 | 96 | 12 | 540 |
| *Scientific American* | 5 | 1 | 69 | 46 | 14 | 652 |
| *Statistical Abstract of the United States* | 5 | 2 | 23 | 38 | 8 | 164 |
| *American Political Science Review* | 2 | 1 | 10 | 16 | 9 | 40 |
| *Pravda* | 0.2 | 0.1 | 1 | 5 | 4 | 20 |

The conclusions Tufte draws from the table, in his own words (pp. 167–168):

> "The table records an enormous diversity of graphical performances both within and between publications. A few data-rich designs appear in nearly every publication. The opportunity is there but it is rarely exploited: the average published graphic is rather thin, based on about 50 numbers shown at the rate of 10 per square inch." (pp. 167–168)

Points to notice in the table itself:

- **Diversity within publications**: maxima dwarf medians everywhere. The *New England Journal of Medicine*'s median density is 12 but its maximum is 923; *Nature*'s maximum matrix is 3,780 numbers and NEJM's is 3,600 against medians of 177 and 84. Graphics carrying several thousand numbers *do* get published — the data-rich design is feasible everywhere, just rare.
- **Diversity between publications**: median densities span 48 (*Nature*) down to 0.2 (*Pravda*) — a factor of 240; median matrix sizes span 200 (*JRSS-B*) down to 5 (*Pravda*).
- **Newspapers versus journals** (p. 168): "Among the world's newspapers, the *Wall Street Journal*, *The Times* (London), and *Asahi* publish data-rich graphics, with data densities equal to those of the *Journal of the American Statistical Association*." (Their medians — 19, 18, 13 — bracket JASA's 17.)
- **A national comparison with an edge** (p. 168): "Most of the American papers and magazines, along with *Pravda*, publish less data per graphic than the major papers of other industrialized countries." (The *New York Times*, *Business Week*, *Newsweek*, *Scientific American*, and the *American Political Science Review* all sit at median 7 or below; the pairing of American outlets with *Pravda* is a pointed jab.)

The section then sets an upper benchmark from cartography (p. 168):

> "Very few statistical graphics achieve the information display rates found in maps. Highly detailed maps portray 100,000 to 150,000 bits per square inch. For example, the average U.S. Geological Survey topographic quadrangle (measuring 17 by 23 inches) is estimated to contain over 100 million bits of information, or about 250,000 per square inch (40,000 per square centimeter). Perhaps some day statistical graphics will perform as successfully as maps in carrying information."

**Footnote 3:** Morris M. Thompson, *Maps for America* (Washington, D.C., 1979), p. 187. (Note the unit shift: the map benchmark is in *bits*, not data-matrix numbers — an information-theoretic estimate rather than the entry count used elsewhere; 17 × 23 = 391 sq in, and 100 million ÷ 391 ≈ 250,000 bits/sq in.)

## High-Information Graphics (pp. 168–169)

This section converts the empirical findings into doctrine. Its full argument (p. 168):

> "Data graphics should often be based on large rather than small data matrices and have a high rather than low data density. More information is better than less information, especially when the marginal costs of handling and interpreting additional information are low, as they are for most graphics. The simple things belong in tables or in the text; graphics can give a sense of large and complex data sets that cannot be managed in any other way."

The structure of the claim: (1) a normative default — large matrices, high density — hedged with "often"; (2) an economic justification — more information beats less *when marginal costs of handling and interpreting it are low*, which for graphics they are; (3) a division of labor — simple data belong in tables or sentences, and graphics earn their place only by doing what nothing else can: conveying "a sense of large and complex data sets that cannot be managed in any other way."

Tufte then raises and answers the obvious objection — overcrowding (p. 168):

> "If the graphic becomes overcrowded (although several thousand numbers represented may be just fine), a variety of data-reduction techniques — averaging, clustering, smoothing — can thin the numbers out before plotting. Summary graphics can emerge from high-information displays, but there is nowhere to go if we begin with a low-information design."

Two moves here. First, the parenthesis pre-empts a too-quick cry of clutter: several thousand numbers may be "just fine." Second, the asymmetry argument: from a high-information display you can always derive summaries (by averaging, clustering, smoothing), but a low-information design is a dead end — "there is nowhere to go." Information loss is irreversible; start rich. **Footnote 4** cites the data-reduction literature: Paul A. Tukey and John W. Tukey, "Summarization: Smoothing; Supplemented Views," in Vic Barnett, ed., *Interpreting Multivariate Data* (Chichester, England, 1982), ch. 12; and William S. Cleveland, "Robust Locally Weighted Regression and Smoothing Scatterplots," *Journal of the American Statistical Association*, 74 (1979), 829–836 (the LOWESS paper).

Two further arguments for data-richness (p. 168):

> "Data-rich designs give a context and credibility to statistical evidence. Low-information designs are suspect: what is left out, what is hidden, why are we shown so little?"

This is an epistemic/rhetorical argument: density is a credibility signal, thinness an invitation to suspicion (three suspicious questions, verbatim: what is left out, what is hidden, why are we shown so little?).

> "High-density graphics help us to compare parts of the data by displaying much information within the view of the eye: we look at one page at a time and the more on the page, the more effective and comparative our eye can be."

This is a perceptual-mechanics argument: the page is the unit of viewing, so packing one page enables within-eye-span comparison instead of memory-burdened page-flipping. **Footnote 5** supports it from radiology: "It is suggested in the analysis of x-ray films to 'search a reduced image so that the whole display can be perceived on at least one occasion without large eye movement.' Edward Llewellyn Thomas, 'Advice to the Searcher or What Do We Tell Them?' in Richard A. Monty and John W. Senders, eds., *Eye Movements and Psychological Processes* (Hillsdale, N.J., 1976), p. 349."

The section culminates in the chapter's central principle, set off as a display line (p. 168):

> **"Maximize data density and the size of the data matrix, within reason."**

The qualifier "within reason" is part of the principle. And the principle carries a price, stated immediately (pp. 168–169):

> "High-information graphics must be designed with special care. As the volume of data increases, data measures must shrink (smaller dots for scatters, thinner lines for busy time-series). The clutter of chartjunk, non-data-ink, and redundant data-ink is even more costly than usual in data-rich designs."

Two design corollaries: (1) data measures must scale down as data volume scales up — smaller dots, thinner lines; (2) the Chapter 4–6 doctrine (erase non-data-ink, erase redundant data-ink, banish chartjunk) binds *more* tightly, not less, in dense designs, because clutter's cost rises with density.

## The Shrink Principle (p. 169)

The density formula has two levers — numerator and denominator — and the chapter has so far worked the numerator. Now the denominator:

> "The way to increase data density other than by enlarging the data matrix is to reduce the area of a graphic. The Shrink Principle has wide application:"

> **"Graphics can be shrunk way down."**

> "Many data graphics can be reduced in area to half their currently published size with virtually no loss in legibility and information. For example, Bertin's crisp and elegant line allows the display of 17 small-scale graphics on a single page along with extensive text. Repeated application of the Shrink Principle leads to a powerful and effective graphical design, the small multiple." (p. 169)

The quantitative claim: half the published area, "virtually no loss in legibility and information" — consistent with the earlier evidence (the reduced New York weather graphic still delivering 181 numbers per square inch, and the eye's 0.1 mm resolving power from p. 162).

The demonstration figure (p. 169, right two-thirds of the page) reproduces a page from Bertin: **sidenote citation** Jacques Bertin, *Semiologie Graphique* (Paris, second edition, 1973), p. 214. The page is headed "PROBLEMES GRAPHIQUES POSES PAR LES CHRONIQUES" ("graphical problems posed by time-series") and contains 17 numbered thumbnail graphics arranged in problem→solution pairs down the left, each pair flanked by a paragraph of French explanatory text on the right. The thumbnails include: a bar series whose two-year totals must be halved, the converse rule being that a six-month total is multiplied by two when placed in annual boxes (1→2); a too-spiky curve fixed by reducing the quantity scale (angular sensitivity is best in a middle zone around 70°) or, if not reducible, by using filled columns (3→4, 5); a too-flat curve fixed by enlarging the quantity scale (6→7); very small variations relative to the total — the total losing its importance — where the zero may be suppressed provided the reader sees the suppression, or, if fine study of the variations is needed, a logarithmic scale used so the graphic reads as an acceleration (8→9, 10, with little ×1.05/×1.01/×1.005 slope guides and a cross-reference to Bertin's p. 240); very large amplitude between extreme values, with three admissible treatments — forgo the smallest variations, use a log scale of relative differences, or stack different periods above a common scale (11→12, with "échelle ×10 / ×5" insets); strongly marked cycles, decomposed and superposed for phase comparison, with a polar construction permitted — preferably in spiral form, not begun from too small a circle — that is spectacular but less effective than the orthogonal one (13→14, 15, a spider-web polar plot); and annual rain/temperature curves where one cycle possesses two phases, so the display should offer both to perception rather than one (16→17). The figure's argumentative role: seventeen legible graphics plus extensive text on a single page proves the Shrink Principle in practice — what makes it work is Bertin's "crisp and elegant line," i.e., high-quality, data-ink-dominant drawing.

The section's last sentence is the hinge of the whole chapter: repeated shrinking does not merely save space — it *creates a design form*, the small multiple.

## Small Multiples (pp. 170–174)

### Definition and the Los Angeles air-pollution display (p. 170)

> "Small multiples resemble the frames of a movie: a series of graphics, showing the same combination of variables, indexed by changes in another variable." (p. 170)

This is the canonical definition. Its three components: (1) a *series* of graphics; (2) each showing the *same combination of variables*; (3) the series *indexed* by changes in another variable (time, sex, year, species, car model...).

The first exemplar: "Twenty-three hours of Los Angeles air pollution are organized into this display, based on a computer-generated video tape. Shown is the hourly average distribution of reactive hydrocarbon emissions" (p. 170). Then the design rule that makes small multiples work:

> "The design remains constant through all the frames, so that attention is devoted entirely to shifts in the data." (p. 170)

Constancy of design is the operative mechanism: because scales, layout, color encoding, and geography are identical in every frame, every perceptible difference between frames *is* data. The viewer's attention is spent entirely on data variation, never on decoding a new format.

The figure fills the lower two-thirds of p. 170: a grid of eight rows by three columns of identical black-background frames, twenty-three of them maps and the twenty-fourth (bottom-right) a legend. Each frame shows the Los Angeles basin with the hourly average reactive-hydrocarbon emission distribution as nested color fields — green at the low periphery, through yellow, into red and white-hot cores. The legend, titled "REACTIVE HYDROCARBONS," gives twelve classes in kg/hr: 1–5, 6–10, 11–20, 21–60, 61–150, 151–300 (the green-to-yellow range) and 301–450, 451–600, 601–700, 701–800, 801–999, 1000+ (the red-to-white range). Read like frames of a movie, the display shows the pollution cloud growing, intensifying, drifting, and decaying over the day. **Sidenote citation:** "From video tape by Gregory J. McRae, California Institute of Technology. The model is described in G. J. McRae, W. R. Goodin, and J. H. Seinfeld, 'Development of a Second-Generation Mathematical Model for Urban Air Pollution. I. Model Formulation,' *Atmospheric Environment*, 16 (1982), 679–696." (The video-tape provenance underlines the movie metaphor: a small multiple is literally a film laid out in space instead of time.)

### Melanoma sites: decomposition by sex and "data graphical arithmetic" (p. 171)

> "These grim small multiples show the distribution of occurrence of the cancer melanoma. The sites of 269 primary melanomas are recorded, along with the distribution between men and women. Note the data graphical arithmetic, similar to that of the multiwindow plot." (p. 171)

The figure stacks three panels, each a pair of human-head outline drawings (left profile and right profile) with the head and neck divided into anatomical regions by light lines and each melanoma site marked by a dot. The original German captions are reproduced: "Abb. 1. Verteilung von 269 primären Melanomen auf Kopf und Hals" (distribution of 269 primary melanomas on head and neck — the combined panel); "Männer" labels the second panel (men); "Frauen" the third (women); "Abb. 2 u. 3. Differenzierung der Melanomverteilung nach Geschlechtern" (differentiation of the melanoma distribution by sex). The dots cluster heavily on the face, ears, and other sun-exposed areas — apt, since the source paper concerns melanoma genesis through chronic light exposure.

"Data graphical arithmetic" names the property that the combined panel visibly equals the sum of the men's and women's panels: panel 1 = panel 2 + panel 3. The cross-reference "similar to that of the multiwindow plot" points back to Chapter 7's multiwindow design, where component windows likewise sum to a total. Here the index variable is sex, and the small multiple performs *decomposition*, not just sequence. **Sidenote citation:** Arthur Wiskemann, "Zur Melanomentstehung durch chronische Lichteinwirkung," *Der Hautarzt*, 25 (1974), 21.

### Twelve samples of random normal deviates: sampling error made visible (p. 172)

> "The effects of sampling errors are shown in these 12 distributions, each based on a sample of 50 random normal deviates." (p. 172)

The figure: two rows of six small solid-black silhouette histograms, each with a tiny "CASES" axis running 0 to 15. All twelve are draws of n = 50 from the same normal distribution, yet their silhouettes vary wildly — some look skewed, several look bimodal. The statistical lesson (and the point of the source paper) is how much apparent structure — even apparent bimodality — sampling error alone can produce. The small multiple is the natural form for showing a *distribution of distributions*: only repetition under a constant design reveals the variability. **Sidenote citation:** Edmond A. Murphy, "One Cause? Many Causes? The Argument from the Bimodal Distribution," *Journal of Chronic Diseases*, 17 (1964), 309.

### Herring catches 1908–1913: a cohort narrative (p. 172)

> "These six distributions show the age composition of herring catches each year from 1908 to 1913. A tremendous number of herring were spawned in 1904, and that class began to dominate the 1908 catch as four-year-olds, then the 1909 catch as five-year-olds, and so on." (p. 172)

The figure: six horizontal panels stacked vertically, labeled 1908 through 1913, sharing a common horizontal age axis numbered 3 4 5 6 7 8 9 10 11 12 13 14 15 16 (printed along both the top and bottom edges of the stack — a multifunctioning frame). Each panel is a frequency polygon of the catch's age composition. The 1908 panel peaks sharply at age 4 (with a secondary bump among older ages); in 1909 the peak sits at age 5; and so on — the dominant peak marches one age-step rightward in each successive frame, the single 1904 year-class aging through the fishery. The small multiple here is *narrative*: the index variable (year) carries a story, and the constant design lets the cohort's movement read as motion. **Sidenote citation:** Johan Hjort, "Fluctuations in the Great Fisheries of Northern Europe," *Rapports et Proces-Verbaux*, 20 (1914), in Susan Schlee, *The Edge of an Unfamiliar World* (New York, 1973), p. 226.

### Chromosomes of man and the great apes: complex comparison (pp. 172–173)

> "This next design compares a complex set of data: shown are the chromosomes of (from left to right) man, chimpanzee, gorilla, and orangutan. The similarities between humans and the great apes are to be noted." (p. 172)

The figure occupies the whole of p. 173: for every chromosome — numbered 1 through 22, plus X and Y — a group of four banded ideograms stands side by side, man, chimpanzee, gorilla, orangutan in fixed left-to-right order. The 24 groups are arranged in four rows of six (1–6; 7–12; 13–17 plus X; 18–22 plus Y). Each ideogram is drawn with its characteristic G-banding pattern (alternating black, gray, and white bands), with p (short) and q (long) arm scales and band-number annotations along the leftmost member of each group. The repeated structure makes the near-identity of banding patterns across the four species read at a glance — the visual case for common ancestry that the source paper ("The Origin of Man") argues. Here the small multiple is doubly indexed: by chromosome (24 groups) and by species (4 ideograms within each group) — a genuinely complex comparative data set handled without strain. **Sidenote citation:** Jorge J. Yunis and Om Prakash, "The Origin of Man: A Chromosomal Pictorial Legacy," *Science*, 215 (March 19, 1982), 1527.

### Consumer Reports frequency-of-repair records: small multiple as table-graphic (p. 174)

> "And, finally, a visually similar small multiple, the *Consumer Reports* frequency-of-repair records for automobiles built from 1976 to 1981. This is a particularly ingenious mix of table and graphic, portraying a complex set of comparisons between manufacturers, types of cars, year, and trouble spots." (p. 174)

The figure (redrawn by Tufte; **sidenote citation:** *Consumer Reports*, 47 (April 1982), 199–207. Redrawn.) shows twelve car-model panels in two rows of six, with a shared "Trouble Spots" label column placed centrally in each row. A legend across the top defines a five-step circle code: open circle = "Much better than average"; progressively filled circles = "Better than average," "Average," "Worse than average"; solid black circle = "Much worse than average." Each panel is headed by the model name — top row: Chevrolet Malibu, Chevelle 6, V6; Chevrolet Monza 4; Datsun 210, B210; Ford Granada 6; Ford pickup truck 6 (2WD); Honda Accord; bottom row: Mercedes-Benz 300D (diesel); Plymouth Volare 6; Subaru (except 4WD); Toyota Corolla (except Tercel); Volkswagen Rabbit (diesel); Volvo 240 series — and contains a grid of circles with model-year columns 76 77 78 79 80 81 and rows for each trouble spot: Air-conditioning; Body exterior (paint); Body exterior (rust); Body hardware; Body integrity; Brakes; Clutch; Driveline; Electrical system (chassis); Engine cooling; Engine mechanical; Exhaust system; Fuel system; Ignition system; Suspension; Transmission (manual); Transmission (automatic); plus summary rows for Trouble Index and Cost Index. (Visibly, the Chevrolet Monza and Plymouth Volare panels are peppered with black circles; the Mercedes, Toyota, and Volvo panels are nearly all open circles.)

The example closes the small-multiples sequence by showing the form's reach: it need not be a repeated *chart* at all. A repeated semi-graphic panel — circles in a table lattice — still earns the name, and supports a four-way comparison (manufacturer × car type × year × trouble spot) within one eye span.

## Conclusion (p. 175)

The chapter ends with a characterization of the form it has built up to. Verbatim (p. 175):

> "Well-designed small multiples are
> - inevitably comparative
> - deftly multivariate
> - shrunken, high-density graphics
> - usually based on a large data matrix
> - drawn almost entirely with data-ink
> - efficient in interpretation
> - often narrative in content, showing shifts in the relationship between variables as the index variable changes (thereby revealing interaction or multiplicative effects)."

Each bullet gathers a thread of the chapter (and of Part II as a whole): comparison (the within-eye-span argument, p. 168); multivariateness (the LA pollution, chromosome, and Consumer Reports examples); shrinking and density (the Shrink Principle and the density doctrine); the large data matrix (the maximization principle); data-ink dominance (Chapters 4–6); interpretive efficiency (design constancy — decode once, read many); and narrative (the herring cohort), with the parenthetical statistical payoff that frame-to-frame shifts in relationships reveal interaction or multiplicative effects.

The final lines condense the theory into a pair of aphorisms:

> "Small multiples reflect much of the theory of data graphics:
>
> For non-data-ink, less is more.
> For data-ink, less is a bore."

**Footnote 6:** "The two aphorisms on the meaning of 'less' are, respectively, credited to Ludwig Mies van der Rohe and to Robert Venturi, *Complexity and Contradiction in Architecture* (New York, second edition, 1977), p. 17." (Mies's modernist "less is more" governs the non-data-ink; Venturi's post-modernist retort "less is a bore" governs the data-ink. The joke is that the two architects' opposed slogans are *both* right, each about a different kind of ink — and the small multiple is the design in which both hold simultaneously: minimal frame, maximal data.)

(The page facing the conclusion, p. 176, carries Minard's double "Carte Figurative" plate — Hannibal's campaign and Napoleon's Russian campaign — but that plate belongs to Chapter 9, which opens by discussing it on p. 177.)

## Consolidated Footnotes and Sidenote Citations

Numbered footnotes:

1. (p. 161) The (2n−1)² grid-intersection formula: n² black-black intersections (corners), (n−1)² white-white (white squares), 2n(n−1) black-white (sides of squares).
2. (p. 162) D. P. Bickmore, "The Relevance of Cartography," in John C. Davis and Michael J. McCullagh, eds., *Display and Analysis of Spatial Data* (London, 1975), p. 331.
3. (p. 168) Morris M. Thompson, *Maps for America* (Washington, D.C., 1979), p. 187.
4. (p. 168) Paul A. Tukey and John W. Tukey, "Summarization: Smoothing; Supplemented Views," in Vic Barnett, ed., *Interpreting Multivariate Data* (Chichester, England, 1982), ch. 12; William S. Cleveland, "Robust Locally Weighted Regression and Smoothing Scatterplots," *Journal of the American Statistical Association*, 74 (1979), 829–836.
5. (p. 168) X-ray search advice ("search a reduced image so that the whole display can be perceived on at least one occasion without large eye movement"): Edward Llewellyn Thomas, "Advice to the Searcher or What Do We Tell Them?" in Richard A. Monty and John W. Senders, eds., *Eye Movements and Psychological Processes* (Hillsdale, N.J., 1976), p. 349.
6. (p. 175) The "less" aphorisms credited to Ludwig Mies van der Rohe and to Robert Venturi, *Complexity and Contradiction in Architecture* (New York, second edition, 1977), p. 17.

Unnumbered sidenote (source) citations, in page order:

- p. 161: U.S. Bureau of the Census, *Statistical Abstract of the United States: 1979* (Washington, D.C., 1979), p. 822 (steel table); sidenote label "25,281 distinctions" beside the grid figure.
- p. 163: Executive Office of the President, Office of Management and Budget, *Social Indicators, 1973* (Washington, D.C., 1973), p. 86.
- p. 165: F. J. Monkhouse and H. R. Wilkinson, *Maps and Diagrams* (London, third edition, 1971), pp. 242–243.
- p. 166: Jacques Bertin, *Semiologie Graphique* (Paris, second edition, 1973), p. 152.
- p. 169: Jacques Bertin, *Semiologie Graphique* (Paris, second edition, 1973), p. 214.
- p. 170: video tape by Gregory J. McRae, California Institute of Technology; model in G. J. McRae, W. R. Goodin, and J. H. Seinfeld, "Development of a Second-Generation Mathematical Model for Urban Air Pollution. I. Model Formulation," *Atmospheric Environment*, 16 (1982), 679–696.
- p. 171: Arthur Wiskemann, "Zur Melanomentstehung durch chronische Lichteinwirkung," *Der Hautarzt*, 25 (1974), 21.
- p. 172: Edmond A. Murphy, "One Cause? Many Causes? The Argument from the Bimodal Distribution," *Journal of Chronic Diseases*, 17 (1964), 309; Johan Hjort, "Fluctuations in the Great Fisheries of Northern Europe," *Rapports et Proces-Verbaux*, 20 (1914), in Susan Schlee, *The Edge of an Unfamiliar World* (New York, 1973), p. 226; Jorge J. Yunis and Om Prakash, "The Origin of Man: A Chromosomal Pictorial Legacy," *Science*, 215 (March 19, 1982), 1527.
- p. 174: *Consumer Reports*, 47 (April 1982), 199–207. Redrawn.

## The Chapter's Argument in One Paragraph

The eye resolves hundreds of distinctions per inch — 625 easily located points per square inch, 25,281 grid locations, 185 readable characters of fine print, 254 cartographic distinctions per inch (pp. 161–162) — so perceptual capacity is never the binding constraint on graphics. Define data density as data-matrix entries per unit area (p. 162); practice then spans 0.15 (an overwrought federal bar chart) to 110,000 (the galaxies map) numbers per square inch (pp. 162–166), while a 21-publication survey shows the average published graphic carries only about 50 numbers at 10 per square inch (pp. 167–168) — far below maps' 250,000 bits per square inch. The remedy is doctrinal: maximize data density and the size of the data matrix, within reason (p. 168), because more information costs little, simple things belong in tables, summaries can always be derived later but never recovered from a thin design, density confers credibility, and a full page empowers the comparing eye. Density rises two ways: enlarge the matrix, or shrink the graphic — and graphics can be shrunk way down, typically to half size without loss (p. 169). Shrink repeatedly and you obtain the small multiple: movie-frame graphics, same variables in every frame, indexed by one changing variable, design constant so attention goes wholly to the data (p. 170) — a form that decomposes wholes (melanoma by sex), exposes sampling variation (twelve normal samples), narrates (the 1904 herring cohort), compares the complex (four primates' chromosomes; twelve cars × six years × seventeen trouble spots), and embodies the whole theory: for non-data-ink, less is more; for data-ink, less is a bore (p. 175).
