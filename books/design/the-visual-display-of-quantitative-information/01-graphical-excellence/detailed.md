# Chapter 1: Graphical Excellence — Detailed Reference

This file reconstructs the full content of Chapter 1 (printed pp. 13–51, plus the epigraph page 52 that faces Chapter 2) of Edward Tufte, *The Visual Display of Quantitative Information*, 2nd edition. The chapter is the opening of Part I, "Graphical Practice." Everything below is paraphrased except data tables, numbers, and a handful of short defining phrases. Figures are described, not reproduced. Page citations refer to printed book pages.

## Chapter role and overall argument structure

The chapter defines what excellence in statistical graphics is, then demonstrates it. The argument runs in five movements:

1. A definitional opening: excellence means complex ideas conveyed with clarity, precision, and efficiency, unpacked into nine operational requirements (p. 13).
2. A demonstration that graphics genuinely *reveal* data — they can outperform numerical statistical summaries (Anscombe's quartet; the hidden outlier) (pp. 13–14).
3. A limiting counterpoint: graphics cannot rescue bad content (the sunspots-and-stocks chart) (p. 15).
4. The body: a tour of excellence across the four fundamental design families — data maps, time-series, space-time narrative designs, and relational graphics — which doubles as a compressed history of data graphics from an eleventh-century Chinese stone map to 1970s computer cartography (pp. 16–50).
5. A closing summary box, the "Principles of Graphical Excellence" (p. 51).

The historical examples are chosen deliberately to serve three purposes Tufte states explicitly (p. 15): they supply a stock of high-quality graphics that later chapters can discuss and sometimes redraw while constructing a theory of data graphics; they help establish a descriptive terminology; and they sketch the history of graphical development. Above all they show how good statistical graphics can be — the chapter sets the ceiling that the rest of the book measures practice against.

## The definition and the nine requirements (p. 13)

The chapter opens with the core definition: excellence in statistical graphics consists of complex ideas communicated with clarity, with precision, and with efficiency. Tufte then lists what graphical displays should do (p. 13). Paraphrased, the nine requirements are:

1. Show the data themselves.
2. Lead the viewer to think about the substance of the data, not about the methodology, the graphic design, the production technology, or anything else extraneous.
3. Not distort what the data have to say.
4. Present many numbers in a small space.
5. Make large data sets coherent.
6. Encourage the eye to compare different pieces of the data.
7. Reveal the data at several levels of detail, from a broad overview down to the fine structure.
8. Serve a reasonably clear purpose — description, exploration, tabulation, or decoration.
9. Be closely integrated with the statistical and verbal descriptions of the data set.

These nine points function as the chapter's working checklist; nearly every example that follows is praised or criticized against one or more of them (information density against point 4, the cancer maps' multi-level readability against point 7, the blot-map distortion against point 3, and so on).

## Graphics reveal data: Anscombe's quartet (pp. 13–14)

Tufte's first substantive claim is that graphics *reveal* data — indeed that they can be more precise and more revealing than conventional statistical computations (p. 13). The proof is Anscombe's quartet: four data sets that are described by exactly the same linear model, at least until one examines the residuals.

Source: F. J. Anscombe, "Graphs in Statistical Analysis," *American Statistician*, 27 (February 1973), 17–21 (margin citation, p. 14).

The full data table as printed (p. 13):

| I: X | I: Y | II: X | II: Y | III: X | III: Y | IV: X | IV: Y |
|------|------|-------|-------|--------|--------|-------|-------|
| 10.0 | 8.04 | 10.0 | 9.14 | 10.0 | 7.46 | 8.0 | 6.58 |
| 8.0 | 6.95 | 8.0 | 8.14 | 8.0 | 6.77 | 8.0 | 5.76 |
| 13.0 | 7.58 | 13.0 | 8.74 | 13.0 | 12.74 | 8.0 | 7.71 |
| 9.0 | 8.81 | 9.0 | 8.77 | 9.0 | 7.11 | 8.0 | 8.84 |
| 11.0 | 8.33 | 11.0 | 9.26 | 11.0 | 7.81 | 8.0 | 8.47 |
| 14.0 | 9.96 | 14.0 | 8.10 | 14.0 | 8.84 | 8.0 | 7.04 |
| 6.0 | 7.24 | 6.0 | 6.13 | 6.0 | 6.08 | 8.0 | 5.25 |
| 4.0 | 4.26 | 4.0 | 3.10 | 4.0 | 5.39 | 19.0 | 12.50 |
| 12.0 | 10.84 | 12.0 | 9.13 | 12.0 | 8.15 | 8.0 | 5.56 |
| 7.0 | 4.82 | 7.0 | 7.26 | 7.0 | 6.42 | 8.0 | 7.91 |
| 5.0 | 5.68 | 5.0 | 4.74 | 5.0 | 5.73 | 8.0 | 6.89 |

All four data sets share, identically (summary list printed to the right of the table, p. 13):

| Statistic | Value |
|---|---|
| N | 11 |
| Mean of X's | 9.0 |
| Mean of Y's | 7.5 |
| Equation of regression line | Y = 3 + 0.5X |
| Standard error of estimate of slope | 0.118 |
| t | 4.24 |
| Sum of squares X − X̄ | 110.0 |
| Regression sum of squares | 27.50 |
| Residual sum of squares of Y | 13.75 |
| Correlation coefficient | .82 |
| r² | .67 |

Yet the graphical display makes vividly clear how different the four sets are (p. 14). The figure is a 2×2 array of small scatterplots labeled I–IV, drawn on identical axes (x to 20, y past 10):

- **I**: an ordinary noisy linear scatter — what the regression summary implies.
- **II**: a smooth, clean arch (a quadratic curve) — no linear model belongs here at all.
- **III**: eleven points on a nearly perfect straight line of a different slope, except one outlier sitting high — the outlier drags the fitted line away from the line the other ten points define.
- **IV**: ten points stacked vertically at a single x value (8.0), plus one extreme point far to the right (19.0, 12.50) — the entire regression is manufactured by that one point.

The lesson: identical summary statistics can conceal radically different structures, so the data must be plotted. Graphics are not an ornamental supplement to analysis; they are part of the analysis, and here more diagnostic than the numbers.

## The wildshot outlier (p. 14)

A second demonstration follows immediately: a graphic easily exposes a "wildshot" observation — point A — that will dominate standard statistical calculations. The crucial detail is that point A hides in the marginal distributions but is plainly exceptional in the bivariate scatter (p. 14).

The figure is a scatterplot of roughly thirty points trending upward from lower left to upper right. Along both axes, tick marks show each variable's one-dimensional (marginal) distribution. Point A sits at the lower right — a high x value paired with a low y value, far off the trend. Two small arrows point at A's positions in the margins: in the x-axis rug and the y-axis rug, A's ticks look completely unremarkable, buried among the others. Only the two-dimensional view reveals it.

Source: Stephen S. Brier and Stephen E. Fienberg, "Recent Econometric Modelling of Crime and Punishment: Support for the Deterrence Hypothesis?" in Stephen E. Fienberg and Albert J. Reiss, Jr., eds., *Indicators of Crime and Criminal Justice: Quantitative Studies* (Washington, D.C., 1980), p. 89.

The lesson extends Anscombe's: one-variable summaries (and one-variable displays) can conceal exactly the observations that most distort multivariate analysis.

## The content limit: silly theory, silly graphic (p. 15)

Having shown what graphics can do, Tufte states the limit. Statistical graphics, just like statistical calculations, are only as good as their inputs. An ill-specified or preposterous model, or a puny data set, cannot be rescued by a graphic any more than by a calculation, however clever or fancy the display. A silly theory yields a silly graphic (p. 15).

The negative example is a 1929 chart reproduced from Edward R. Dewey and Edwin F. Dakin, *Cycles: The Science of Prediction* (New York, 1947), p. 144, titled "Solar Radiation and Stock Prices" (after Garcia-Mata and Shaffner). It overlays three monthly series for 1929: curve A, New York stock prices (Barron's average), dashed; curve B, solar radiation, *inverted*, solid; curve C, London stock prices, dash-dotted. The left axis is calories per square centimeter per minute (running from −.012 at top through "Normal" to +.002 at bottom — i.e., plotted upside down to force the fit); the right axes are New York (650, 700…) and London (148–168) price scales. All three curves rise to a September peak and crash together in the autumn — visually persuasive, scientifically meaningless. The chart insinuates that sunspot activity drives stock markets. The graphical craftsmanship is irrelevant: the underlying model is absurd, so the display is too.

This establishes the first term of the closing summary: excellence is a matter of *substance* first.

## Transition: the four fundamental designs (p. 15)

Tufte then turns from principle to practice — the efficient communication of complex quantitative ideas. He announces that excellence, which is nearly always multivariate in character, will be illustrated for the fundamental graphical designs: **data maps**, **time-series**, **space-time narrative designs**, and **relational graphics** (p. 15). He states the three purposes of the example set (a discussable/redrawable corpus for theory-building, a vehicle for descriptive terminology, and a brief history) and the overarching aim: to see just how good statistical graphics can be.

## Data Maps (pp. 16–27)

### The cancer atlas (pp. 16–19)

The section opens with six maps reporting age-adjusted death rates from various types of cancer for the 3,056 counties of the United States. Each map portrays some 21,000 numbers, and only a picture can carry such a volume of data in so small a space (p. 16).

Footnote 1 (p. 16) justifies the 21,000 count: each county's rate is located in two dimensions, and at least four more numbers would be needed to reconstruct the size and shape of each county; thus 7 × 3,056 entries in a data matrix would be needed to reproduce a map.

The shading legend (printed in the margin, p. 16) has five categories combining magnitude with statistical significance:

| Shade | Meaning |
|---|---|
| Darkest (solid black, widest swatch) | In highest decile, statistically significant |
| Black (narrower swatch) | Significantly high, but not in highest decile |
| Dark gray hatch | In highest decile, but not statistically significant |
| Light gray | Not significantly different from U.S. as a whole |
| White | Significantly lower than U.S. as a whole |

The six maps, printed two per page on pp. 17–19, each a full U.S. county-outline map with counties filled per the legend:

- All types of cancer, white females; age-adjusted rate by county, 1950–1969 (p. 17, top).
- All types of cancer, white males (p. 17, bottom).
- Trachea, bronchus, and lung cancer; white females (p. 18, top).
- Trachea, bronchus, and lung cancer; white males (p. 18, bottom).
- Stomach cancer, white females (p. 19, top).
- Stomach cancer, white males (p. 19, bottom).

Beyond density, the maps' virtue is that all the data can be thought about in many different ways at many different levels of analysis — from contemplating broad overall patterns to detecting very fine county-by-county detail (p. 16). Tufte's worked examples of readings at different levels:

- High cancer death rates in the northeastern United States and around the Great Lakes.
- Low rates in an east-west band across the middle of the country.
- Higher rates for men than women in the South, particularly Louisiana — probably occupational cancers from asbestos exposure in shipyard work.
- Unusual hot spots, including northern Minnesota and a few Iowa and Nebraska counties along the Missouri River.
- Regional differences by cancer type — e.g., high stomach-cancer rates in the north-central states, probably from smoked-fish consumption among people of Scandinavian descent.
- And, inevitably, the rates where the reader happens to have lived (p. 16).

The maps also generate leads into the causes — and avoidance — of cancer. Tufte quotes the atlas authors' report (p. 16, paraphrased here): a county's unusual experience can warrant investigation. Salem County, New Jersey, led the nation in bladder-cancer mortality among white men; the authors attributed the excess to occupational exposure, since about 25 percent of the county's employed persons worked in the chemical industry, particularly the manufacture of organic chemicals, which may cause bladder tumors. After the finding was communicated to New Jersey health officials, a company in the area reported that at least 330 workers at a single plant had developed bladder cancer over the preceding 50 years; the authors urged cancer-risk surveys and control programs for workers and former workers there.

Footnote 2 (p. 16): Robert Hoover, Thomas J. Mason, Frank W. McKay, and Joseph F. Fraumeni, Jr., "Cancer by County: New Resource for Etiologic Clues," *Science*, 189 (September 19, 1975), 1006. The maps themselves come from *Atlas of Cancer Mortality for U.S. Counties: 1950–1969*, by Thomas J. Mason, Frank W. McKay, Robert Hoover, William J. Blot, and Joseph F. Fraumeni, Jr. (Washington, D.C.: Public Health Service, National Institutes of Health, 1975). The six maps shown were redesigned and redrawn by Lawrence Fahey and Edward Tufte.

### Flaws of the cancer maps (p. 20)

Tufte explicitly models critical reading. The maps repay careful study, and notice how quickly attention has gone to the substantive content rather than to methodology and technique — exactly requirement 2 from p. 13. Nonetheless the maps have two flaws:

1. **A graphical-composition flaw.** They wrongly equate the visual importance of each county with its geographic area rather than with the number of people living there (or the number of cancer deaths). The visual impression of the data is entangled with the circumstance of geographic boundaries, shapes, and areas. Tufte calls this the chronic problem afflicting shaded-in-area designs, naming them "blot maps" or "patch maps" (p. 20). (This is the standard critique of choropleth maps: sparsely populated big counties dominate the eye.)
2. **A data flaw, not a composition flaw.** The maps rest on a suspect source: death-certificate reports of cause of death. These reports fall under the influence of diagnostic fashions prevailing among doctors and coroners in particular places and times — a troublesome adulterant of evidence that already concerns the sometimes ambiguous matter of the primary cancer's exact bodily site. So part of the regional clustering, and some of the hot spots, may reflect varying diagnostic customs and fads along with real differences in cancer rates between areas (p. 20).

Both cautions generalize: ask whether the encoding gives visual weight proportional to what matters, and ask whether the measurement process itself could generate the visible pattern.

### The curious history of data maps (pp. 20–22)

Data maps, Tufte observes, have a curious history: the combination of cartographic and statistical skills required to construct them came together only in the seventeenth century — fully 5,000 years after the first geographic maps were drawn on clay tablets. Many highly sophisticated geographic maps were produced centuries before the first map containing any statistical material (p. 20).

Footnote 3 (p. 20): in cartography, data maps are usually called "thematic maps." For a thorough account, see Arthur H. Robinson, *Early Thematic Mapping in the History of Cartography* (Chicago, 1982). On the history of statistical graphics: H. Gray Funkhouser, "Historical Development of the Graphical Representation of Statistical Data," *Osiris*, 3 (November 1937), 269–404; and James R. Beniger and Dorothy L. Robyn, "Quantitative Graphics in Statistics: A Brief History," *American Statistician*, 32 (February 1978), 1–11.

**The Yü Chi Thu** (pp. 20–21). The exhibit for pre-statistical cartographic sophistication is a detailed eleventh-century Chinese map with a full grid: the Yü Chi Thu, or Map of the Tracks of Yü the Great. Tufte quotes Joseph Needham's description (paraphrased): it is the most remarkable cartographic work of its age in any culture, carved in stone in 1137 but probably dating from before 1100. The grid scale is 100 *li* to the division; the coastal outline is relatively firm and the precision of the river-network rendering extraordinary. The stone original, about 3 feet square, is in the Pei Lin Museum at Sian. The geographer's name is unknown. Anyone comparing it with contemporary European religious cosmography must be amazed at how far Chinese geography was then ahead of the West; Europe had nothing like it until the Escorial manuscript map of about 1550 (p. 20).

Footnote 4: Joseph Needham, *Science and Civilisation in China* (Cambridge, 1959), vol. 3, 546–547. The full-page reproduction (p. 21) shows a dense square lattice grid overlaid with river systems (drawn in heavy lines), a coastline at the right, and hundreds of small Chinese place-name labels; a text block of characters sits at top left. Image source: E. Chavannes, "Les Deux Plus Anciens Spécimens de la Cartographie Chinoise," *Bulletin de l'École Française de l'Extrême Orient*, 3 (1903), 1–35, Carte B.

**Apianus's Cosmographia** (p. 22). The 1546 edition of *Cosmographia* by Petrus Apianus contained map designs showing how close European cartography had come to statistical graphicacy — even approaching the bivariate scatterplot. The reproduced woodcut page (Latin heading announcing the form, use, and structure of Ptolemy's tables, with places where the geography student can exercise) shows a square map frame with numbered coordinate divisions (28–37 across top and bottom; 46–52 down the sides), compass directions labeled on each side (Septentrio/north at top, Meridies/south at bottom, Occidens/west left, Oriens/east right), and engraved hands at the edges holding crossed threads whose intersection locates a city. Inside the frame are city names — Lyptzich (Leipzig), Erforde (Erfurt), Nurenberch (Nuremberg), Ingolstadt, Praga, Monachiu Munchen (Munich), Vienne (Vienna), Venize (Venice), and the region label Bavaria.

Tufte's point: the look of a scatterplot existed, but according to the historical record no one had yet made the *quantitative abstraction* of placing a measured quantity on the map's surface at the intersection of the two threads instead of the name of a city — let alone the more difficult abstraction of replacing latitude and longitude with other dimensions such as time and money. Indeed, the first economic time-series was not plotted until 1786 (p. 22). This sentence is the hinge of the chapter's whole historical thesis: the conceptual leap, not the drafting technique, was what took centuries. It is picked up again at p. 43.

### Halley's chart of trade winds and monsoons (p. 23)

One of the first data maps was Edmond Halley's 1686 chart showing trade winds and monsoons on a world map. The page shows two reproductions: the full chart (a long horizontal strip world map spanning Florida and America on the left across the Atlantic, Africa, and the Indian Ocean to China at right, with the tropical oceans covered in fine directional stroke symbols), and below it an enlarged detail of the Atlantic between South America and Africa showing the cartographic symbolization at readable scale (labels include North Sea or Atlantick Ocean, the Canary Isles, C. Verd, Gambia, Guiana, Brasil, the Æthiopick Ocean, St. Helena, Ascension, and a region marked "Calms and Tornado's").

Halley's own explanation of the symbology (quoted by Tufte; paraphrased): the sharp end of each little stroke points toward the part of the horizon from which the wind continually blows; where monsoons occur, the rows of strokes run alternately backwards and forwards, which makes them denser there than elsewhere (p. 23).

Citations: footnote 5, Norman J. W. Thrower, "Edmond Halley as a Thematic Geo-Cartographer," *Annals of the Association of American Geographers*, 59 (December 1969), 652–676; and, for the chart itself, Edmond Halley, "An Historical Account of the Trade Winds, and Monsoons, Observable in the Seas Between and Near the Tropicks; With an Attempt to Assign the Phisical Cause of Said Winds," *Philosophical Transactions*, 183 (1686), 153–168.

The role in the argument: the first true data maps encoded a measured phenomenon (wind direction and regime) onto geographic coordinates — position plus one measured variable.

### John Snow's cholera map (p. 24)

An early and most worthy use of a map to chart disease patterns: Dr. John Snow's famous dot map of deaths from cholera in central London for September 1854. Deaths were marked by dots; the area's eleven water pumps were located by crosses. Examining the scatter over the map's surface, Snow observed that cholera occurred almost entirely among those who lived near — and drank from — the Broad Street water pump. He had the handle of the contaminated pump removed, ending the neighborhood epidemic, which had already taken more than 500 lives (p. 24). Tufte notes the pump's position for the reader: at the center of the map, just to the right of the D in the BROAD STREET label.

Tufte then raises and answers an objection himself: of course the pump-disease link might have been found by computation and analysis without graphics, with some good luck and hard work. But here graphical analysis testifies about the data far more efficiently than calculation (p. 24). The example thus establishes that graphics can drive causal discovery and life-saving intervention, while conceding graphics are not the only possible route — efficiency is the claim, not exclusivity.

The figure: a redrawn street map of Soho with a yards scale bar (0–200), a key (× = pump, dot = deaths from cholera), street names (Oxford Street, Regent Street, Conduit Street, New Bond Street, Savile Row, Piccadilly, Regents Quadrant, Golden Square, Broad Street), and dense stacks of death-dots clustering around the Broad Street pump.

Footnote 6: E. W. Gilbert, "Pioneer Maps of Health and Disease in England," *Geographical Journal*, 124 (1958), 172–183 — the version shown is a redrawing of Snow's map. For a reproduction and detailed analysis of the original, see Tufte, *Visual Explanations: Images and Quantities, Evidence and Narrative* (Cheshire, Connecticut, 1997), Chapter 2. Ideally, see John Snow, *On the Mode of Communication of Cholera* (London, 1855).

### Minard's wine-export flow map (pp. 24–25)

Charles Joseph Minard advanced the data map another step: he gave *quantity* as well as direction to the data measures located on a world map, in his portrayal of the 1864 exports of French wine by sea (p. 24). The full-page color reproduction (p. 25, rotated sideways) shows the world's continents in gray (labeled in French: Amérique du Nord, Amérique du Sud, France, Allemagne, Afrique, Inde, Chine, Australie) with tan flow-bands streaming out of France across the oceans — a thick trunk leaving French ports, branching to North and South America, around Africa, to India, China, and Australia — the width of each band proportional to the quantity of wine shipped along that route. A text cartouche at upper left explains the carte figurative; an inset line chart with annotations sits at upper right.

Source note (p. 25): Charles Joseph Minard, *Tableaux Graphiques et Cartes Figuratives de M. Minard, 1845–1869*, a portfolio of his work held by the Bibliothèque de l'École Nationale des Ponts et Chaussées, Paris. (This portfolio reappears for the Napoleon map, p. 40.)

### The Lick galaxy map (pp. 26–27)

The data-map section closes in the present. Computerized cartography and modern photographic techniques have increased the information density of the best current data maps roughly 5,000-fold compared with Halley's pioneering effort (p. 26). The example maps the distribution of 1.3 million galaxies (including some overlaps) in the northern galactic hemisphere. Construction details, all stated in the text (p. 26):

- The sky is divided into 1,024 × 2,222 rectangles — 2,275,328 cells.
- The number of galaxies counted in each cell is represented by ten gray tones; the darker the tone, the more galaxies counted.
- The north galactic pole is at the center of the circular map.
- The sharp edge on the left side results from the earth blocking the observatory's view.
- Near the perimeter, the view is obscured by the interstellar dust of our own galaxy, since the line of sight there passes through the flattened disk of the Milky Way.

The figure (p. 27, full page) is a large circle filled with mottled gray stippling — the clustered texture of the universe — with a graduated tick border and, along the bottom, the ten-step gray scale from white to black. A rectangular detail strip excerpted from the same map also runs across the bottom of p. 26, beneath the text.

Two intellectual points ride on this map. First, the curious texture of local galaxy clusters visible in this genuinely new view was *not anticipated* by students of galaxies, even though they had microscopically examined millions of photographs of individual galaxies before seeing this macroscopic view (p. 26) — a case of a graphic producing discovery that piecemeal inspection of the same data never did. Second, a caution about visual inference: the clusters are real (and accounted for by a theory of galactic origins), but the seemingly random filaments may be happenstance. Tufte quotes the map's producers (paraphrased): there is a strong temptation to conclude the galaxies are arranged in a remarkable filamentary pattern on scales of roughly 5° to 15°, but the impression may mislead because the eye tends to pick out linear patterns even in random noise; roughly similar patterns appear in maps built from simulated catalogs containing no built-in linear structure (p. 26, with footnote 7).

Footnote 7: Michael Seldner, B. H. Siebers, Edward J. Groth, and P. James E. Peebles, "New Reduction of the Lick Catalog of Galaxies," *Astronomical Journal*, 82 (April 1977), 249–314. See also Gillian R. Knapp, "Mining the Heavens: The Sloan Digital Sky Survey," *Sky & Telescope* (August 1997), 40–48; and Margaret J. Geller and John P. Huchra, "Mapping the Universe," *Sky & Telescope* (August 1991), 134–139.

The section's closing verdict (p. 26): the most extensive data maps — the cancer atlas, the galaxy count — place millions of bits of information on a single page before our eyes, and no other method for displaying statistical information is so powerful.

## Time-Series (pp. 28–39)

### Why time-series work (p. 28)

The time-series plot is the most frequently used form of graphic design. Footnote 8 supplies the evidence: a random sample of 4,000 graphics drawn from 15 of the world's newspapers and magazines published 1974–1980 found that more than 75 percent of all graphics published were time-series (Chapter 3 reports more on this study). The design's power comes from one dimension marching along to the regular rhythm of seconds, minutes, hours, days, weeks, months, years, centuries, or millennia: the natural ordering of the time scale gives the design a strength and efficiency of interpretation found in no other graphic arrangement (p. 28).

### The mysterious tenth-century planetary graph (p. 28)

The oldest known example of an attempt to show changing values graphically is a reputed tenth- (possibly eleventh-) century illustration of the inclinations of the planetary orbits as a function of time, apparently part of a text for monastery schools. It appears as a mysterious and isolated wonder in the history of data graphics, since the next extant graphic of a plotted time-series shows up some 800 years later (p. 28). According to Funkhouser, the astronomical content is confused, and there are difficulties reconciling the graph and its accompanying text with the actual movements of the planets; particularly disconcerting is the wavy path ascribed to the sun. An erasure and correction of a curve occur near the middle of the graph.

Footnote 9: H. Gray Funkhouser, "A Note on a Tenth Century Graph," *Osiris*, 1 (January 1936), 260–262.

The figure: a hand-drawn lattice grid with seven star-burst symbols stacked down the left margin labeling the bodies (Venus, Mercury, Saturn, Sol, Mars, Jupiter, Luna), and seven wavy curves snaking across the grid, crossing one another — visibly a time-series plot in everything but era.

### Lambert's soil-temperature curves (p. 29)

Time-series charts began to appear in scientific writings only in the late 1700s. The example is a drawing by Johann Heinrich Lambert — one of a long series he made — showing the periodic variation in soil temperature in relation to depth under the surface: the greater the depth, the greater the time-lag in temperature responsiveness (p. 29). Tufte adds that modern graphic designs showing time-series periodicities differ little from Lambert's, although today's data bases are far larger. The small margin figure shows a family of offset sinusoidal curves with vertical drop lines. Source: J. H. Lambert, *Pyrometrie* (Berlin, 1779).

### Voyager 2 at Jupiter (p. 29)

A modern counterpart: a plot of radio emissions from Jupiter based on data collected by Voyager 2 during its July 1979 close pass. The figure stacks four panels over a shared horizontal axis: three electric-field intensity bands (labeled 56.2 kHz, 31.1 kHz, and 17.8 kHz, each on a logarithmic V/m scale) shown as dense black spiky traces, and a bottom panel of spacecraft latitude (±20°) showing two smooth oscillating curves labeled "magnetic" and "jovigraphic." Annotations at top mark "Northern source," "Voyager 2," and "Southern source." The horizontal axis carries dual labels: distance from the planet in Jupiter radii (R), running 106.5, 95.1, 83.4, 71.5, 59.2, 46.5, 33.1, 19.3, and the dates July 2 through July 8, 1979.

Everything Tufte says about it (p. 29):

- Radio intensity increases and decreases in a ten-hour cycle as Jupiter rotates.
- Maximum intensity occurs when the Jovian north magnetic pole tips toward the spacecraft, indicating a northern-hemisphere source.
- A southern source was detected on July 7, as the spacecraft neared the equatorial plane.
- Note the use of dual labels on the horizontal axis to indicate both date and distance from Jupiter — the axis itself carries an extra variable.
- The entire bottom panel also serves to label the horizontal scale, describing the spacecraft's changing orientation relative to Jupiter during the approach — a panel doing double duty as data and axis annotation.
- Multiple time-series enforce not only comparisons within each series over time (as all time-series plots do) but also comparisons *between* the three radio bands.
- The display is richly multivariate, based on 453,600 instrument samples of eight bits each; the resulting 3.6 million bits were reduced by peak and average processing to the 18,900 points actually plotted.

Sources: D. A. Gurnett, W. S. Kurth, and F. L. Scarf, "Plasma Wave Observations Near Jupiter: Initial Results from Voyager 2," *Science* 206 (November 23, 1979), 987–991; and a letter from Donald A. Gurnett to Edward R. Tufte, June 27, 1980.

### Reserve graphics for rich data: the New York City weather chart (p. 30)

Tufte states a usage principle: time-series displays are at their best for big data sets with real variability. He asks rhetorically why one would waste the power of data graphics on simple linear changes that can usually be better summarized in one or two numbers (p. 30). The anti-example is drawn right into the page: a content-free sketch of a single dashed straight line rising gently across an empty plotting frame — a "graphic" whose entire content is one slope.

Graphics should instead be reserved for the richer, more complex, more difficult statistical material. The positive example: a New York City weather summary for 1980 depicting 1,888 numbers (*New York Times*, January 11, 1981, p. 32). The figure is a wide three-panel chart titled "New York City's Weather for 1980":

- **Top panel (temperature):** for each day of the year, a vertical black bar spans the day's low to high temperature, forming a dark band that swells through summer; a smooth white path through the band marks the normal high and normal low (labeled "line indicates normal high" / "line indicates normal low"). An inset legend compares 1980 against normal annual temperature. Annotations flag the year's extremes: high of 102° on July 21; low of −1° on December 25. Scale 0°–100° on both edges.
- **Middle panel (precipitation):** monthly bars of actual versus normal precipitation in inches, with totals printed: total precipitation for 1980 = 44.54 inches; normal = 40.19.
- **Bottom panel (humidity):** relative humidity as of noon, percent, daily.

Tufte's reading: the daily highs and lows are shown in relation to the long-run average, and the path of normal temperatures also provides a *forecast* of expected change over the year — in mid-February a New Yorker can look forward to warming at about 1.5 degrees per week all the way to July, the yearly peak. The graphic is distinguished because it successfully organizes a large collection of numbers, makes comparisons between different parts of the data, and tells a story (p. 30).

### Marey's graphical train schedule and the TGV (p. 31)

A design with similar strengths: E. J. Marey's graphical train schedule for Paris to Lyon in the 1880s. Construction (p. 31):

- Stations are listed down the vertical axis (Paris at top; then Montereau, Laroche, Tonnerre, Nuits-s-Ravières, Les Laumes, Dijon, Chagny, Chalon-sur-Saône, Mâcon, St-Germain-au-Mont-d'Or, Lyon at bottom), separated in proportion to their actual distance apart.
- Time of day runs along the horizontal, from 6 a.m. through noon, midnight, and back to 6 a.m.
- Each train is a diagonal line: arrivals and departures at a station are located along the horizontal; the length of a stop is the length of the horizontal segment at that station.
- The slope of the line reflects the train's speed: the more nearly vertical, the faster the train.
- The intersection of two lines locates the time and place at which trains going in opposite directions pass each other.

The full-page figure shows dozens of criss-crossing diagonals over a fine vertical hour grid. Source: E. J. Marey, *La méthode graphique* (Paris, 1885), p. 20; the method is attributed to the French engineer Ibry.

Tufte then updates the chart: in 1981 a new express train, the TGV (*train à grande vitesse*), cut the Paris–Lyon trip to under three hours, compared with more than nine hours when Marey published the schedule. The TGV's path is overlaid in red on the century-old schedule in a second, smaller panel: a strikingly steep, nearly straight red diagonal slicing across the shallow old train lines — a hundred years of progress legible as slope (p. 31).

### Lambert and Playfair; the first economic time-series (p. 32)

Tufte names the two great inventors of modern graphical design: J. H. Lambert (1728–1777), a Swiss-German scientist and mathematician, and William Playfair (1759–1823), a Scottish political economist (p. 32). Footnote 10: Laura Tilling, "Early Experimental Graphs," *British Journal for the History of Science*, 8 (1975), 193–213.

The first known time-series using economic data was published in Playfair's remarkable book *The Commercial and Political Atlas* (London, 1786). The reproduced color chart, titled as a chart of all the imports and exports to and from England from 1700 to 1782, shows two curves — exports (red-brown) and imports (yellow) — over an eight-decade horizontal axis, with the area between them tinted and labeled "BALANCE in FAVOUR of ENGLAND" (and labeled against England where imports exceeded exports early in the century). The caption notes the bottom divisions are years and the right-hand divisions millions of pounds. Tufte directs attention to the *graphical arithmetic*: the shifting balance of trade is shown by the difference between the import and export time-series — the chart computes a third series (the difference) visually from two plotted ones (p. 32).

Playfair's own case for graphics over tables is quoted at length from pages 3–4 of the *Atlas* (paraphrased): information imperfectly acquired is imperfectly retained; a man who has carefully studied a printed table finds he retains only a faint, partial idea of it, soon erased like a figure drawn in sand. Amounts of money and profit or loss can be represented in drawing as readily as any portion of space, though no one had attempted it before. The charts, while giving a simple and distinct idea, are as accurate as is useful; attentive inspection of one leaves a sufficiently distinct impression that endures, remaining simple and complete, carrying both the duration and the amount. Tufte's gloss: for Playfair, graphics were preferable to tables because graphics showed the *shape* of the data in a *comparative* perspective (pp. 32–33).

### Playfair's first bar chart — and his own skepticism about it (p. 33)

Time-series plots delivered that comparative shape, and all but one of the 44 charts in the first edition of *The Commercial and Political Atlas* were time-series. The single exception is the first known bar chart, which Playfair invented under duress: year-to-year data were missing for Scotland, and he needed a design to portray the one-year data he had (p. 33).

Playfair was skeptical of his own innovation. His assessment (quoted from page 101 of the *Atlas*; paraphrased): this chart differs in principle from the others, since it does not encompass any portion of time, and it is much inferior in utility to those that do; though it shows the extent of the different branches of trade, it does not compare the same branch of commerce with itself at different periods, nor does it impress upon the mind the lasting distinct idea that is the chief advantage of charts — lacking the dimension formed by duration, no shape is given to the quantities. Tufte's verdict: Playfair was right — small, noncomparative, highly labeled data sets usually belong in tables (p. 33).

The figure: "Exports and Imports of Scotland to and from different parts for one Year from Christmas 1780 to Christmas 1781." Seventeen trading partners are listed down the right side (from small traders such as Jersey, Iceland, Poland, the Isle of Man, Greenland, Prussia, Portugal, and Holland down to the largest, the West Indies, America, Russia, and Ireland), each with paired horizontal bars; the caption explains the upright divisions are ten thousand pounds each, with black solid lines for exports and ribbed (cross-hatched) lines for imports. The countries are ordered by volume of trade.

Tufte reads the chart's fine details as evidence about practice (p. 33):

- The horizontal scale sits at the top of the chart, possibly to make plotting the points by hand more convenient.
- Zero values are nicely indicated twice over — by the absence of a bar and by a printed "0."
- An error: the horizontal scale mistakenly repeats "200."
- In nearly all his charts, Playfair placed the vertical-scale labels on the right side of the page — suggesting, Tufte conjectures, that he plotted his data points with his left hand.

### Playfair's wheat prices, wages, and monarchs (p. 34)

Playfair's last book asked whether the price of wheat had risen relative to wages. Its full title: *Letter on our agricultural distresses, their causes and remedies; accompanied with tables and copper-plate charts shewing and comparing the prices of wheat, bread and labour, from 1565 to 1821*. Playfair's address to his readers (quoted from pages 29–31; paraphrased): before you is a chart of wheat prices for 250 years, made from official returns; on the same plate is traced, as nearly as possible, a line for the wages of good mechanics — smiths, masons, carpenters — so the proportion between wages and wheat prices can be compared at every period; the main fact deserving consideration is that wheat had never before been so cheap in proportion to mechanical labor as it was at present.

So Playfair plotted three parallel time-series: prices, wages, and the reigns of British kings and queens (p. 34). The color figure: an oval cartouche reads "CHART Shewing at One View The Price of The Quarter of Wheat, & Wages of Labour by the Week, from The Year 1565 to 1821, by William Playfair." Across the top run brackets for the 16th through 19th centuries and a band of monarchs' reigns (Elizabeth, James I, Charles I, Cromwell, Charles II, James II, William and Mary, Anne, George I, George II, George III, George IV). The body shows wheat prices as a stepped black bar profile (shillings per quarter, right axis) and weekly wages as a smooth red line over a light-blue filled area along the bottom, rising slowly over the centuries. The gridded field is divided at 5- and 10-year intervals.

The chart's argumentative role: an early model of placing several series in one frame so a viewer can compare their proportion across eras — multivariate, comparative, and built to make one substantive point.

### Marey's chart of English rulers, peace and war (pp. 34–35)

The history and genealogy of royalty was long a graphical favorite. E. J. Marey produced a superb construction bringing together several sets of facts about English rulers into a time-series conveying a sense of the march of history (p. 34). The figure (p. 35): a horizontal time axis ticked by decade from 1660 to 1860; each ruler (Georges I, II, III, IV, Guillaume IV, Victoria — with the Régence noted) occupies a horizontal band placed stepwise down the chart in order of accession, the band's extent marking the reign; below, a strip labeled (in French) with the relative durations of the periods of peace and war shows alternating black and hatched segments along the same time axis. Source: E. J. Marey, *La Méthode Graphique* (Paris, 1885), p. 6.

### Marey's motion studies (pp. 35–36)

Tufte introduces Marey (1830–1904) as a pioneer of graphical methods in human and animal physiology. Four motion studies follow, all from E. J. Marey, *Movement* (London, 1895) — the source note (p. 35) lists the originals at pages 191, 224, 222, 265, 60, and 61, beginning with the horse tracks:

- **Horse gaits** (p. 35): six vertical columns of hoofprint marks, one per gait — ordinary walk, walk (long stride), quick walk, amble, jog-trot, gallop — with dotted lines connecting the print sequences; time runs along each track, so the pattern of prints encodes the rhythm of each pace.
- **A starfish turning itself over** (p. 36): a vertical stack of seven black silhouettes against horizontal baselines, to be read from the bottom upwards, showing the animal arching and flipping.
- **The undulations of the dorsal fin of a descending sea-horse** (p. 36): five successive engraved images in a horizontal strip.
- **The advance of a gecko** (p. 36): a horizontal strip of about a dozen silhouettes showing the limb cycle.

Finally, Marey's man in black velvet (p. 36): a subject dressed in black velvet with white stripes along the limbs, photographed as stick-figure images — the figure shows the resulting fan of white skeletal lines sweeping across a black field (with a small inset of the suited man). Tufte notes this became the time-series forerunner of Marcel Duchamp's *Nude Descending a Staircase*. The motion studies collectively extend the time-series idea from plotted numbers to recorded movement itself.

### Chronology is not causality — and an exception (p. 37)

Tufte now states the central analytical weakness of the form: the problem with time-series is that the simple passage of time is not a good explanatory variable; descriptive chronology is not causal explanation (p. 37). There are occasional exceptions, especially when a clear mechanism drives the Y-variable.

The exception shown: a time-series that *does* testify about causality. The figure plots monthly outgoing mail workload of the U.S. House of Representatives in millions of units, 1967–1972 (y-axis to 60), as a filled silhouette. The series spikes every two years — peaks labeled October 1968, October 1970, October 1972 — immediately before each election day, then collapses after. The mechanism is obvious: incumbents exploiting free mailing ("franking") privileges to advance their re-election campaigns.

Below the chart, Tufte reproduces the alternative: a wire-service news story ("Franked Mail Tie to Voting Shown," reporting court testimony that mail volume rises before elections) running to roughly 700 words in eight dense columns. His point, stated in the text: the graphic is worth at least 700 words — the number used in the news report to describe the same phenomenon (p. 37).

### Moving time-series toward explanation: decomposition (p. 38)

Time-series plots can be moved toward causal explanation by smuggling additional variables into the graphic design (p. 38). The example: a decomposition of economic data arraying 1,296 numbers — "Systematic and Irregular Components of Total Retail Sales, United States," 1960–1971. The figure stacks nine aligned panels over a shared monthly axis:

| Panel | Scale |
|---|---|
| Unadjusted data | billions of dollars (20–44) |
| Holiday variation | percent (95–105) |
| Trading-day variation | percent (95–105) |
| Seasonal variation | percent (90–120) |
| Irregular component | percent (95–105) |
| Trend-cycle component | billions of dollars |
| MCD curve | billions of dollars |
| Seasonally adjusted series | billions of dollars |
| Deflated retail sales | billions of dollars (20–32) |

The top series is broken into seasonal and trading-day fluctuations (which dominate short-term changes) to reveal the long-run trend adjusted for inflation at the bottom. Tufte notes the analytic logic: the next step would be to bring in additional variables to explain the transformed and improved series at the bottom. He also flags a significant design defect: the vertical grid conceals the height of the December peaks (p. 38).

Citations: footnote 11, William S. Cleveland and Irma J. Terpenning, "Graphical Methods for Seasonal Adjustment," *Journal of the American Statistical Association* 77 (March 1982), 52–62; figure source, Julius Shiskin, "Measuring Current Economic Fluctuations," *Statistical Reporter* (July 1973), p. 3.

### The before-after time-series (p. 39)

Finally — Tufte's word — a vivid design, *given appropriate data*: the before-after time-series. Two examples:

1. **The magnetic monopole candidate.** Blas Cabrera's detector record of February 14, 1982: a strip chart of magnetic flux (in units of Φ₀) against time of day (PST, 3 to 24). The trace sits flat near zero all morning (with a small marked disturbance from a liquid-nitrogen transfer, labeled "LN₂ transfer"), then at about 2 p.m. jumps instantaneously to about 8 and stays rock-steady. The reproduced caption (headed with the question whether this is a monopole; paraphrased) explains: the jump in magnetic flux through the superconducting detector loop — equivalently, the jump in the loop's supercurrent — is just the right magnitude to be a monopole, and the current remained stable for many hours afterward. Source: M. Mitchell Waldrop, "In Search of the Magnetic Monopole," *Science* (June 4, 1982), p. 1087.
2. **A bridge collapse on the Rhône, 1840.** Minard's engineering drawing of the Pont de Bourg-St. Andéol: an elevation of the bridge with one pier undermined, the superstructure visibly tilted; below the waterline, the drawing shows the riverbed profile before and after the flood scoured beneath the pier (the flood crest of November 1840 is marked). Before and after are superimposed in one image, explaining the structural failure at a glance. Source: Charles Joseph Minard, "De la Chute des Ponts dans les grandes Crues" (October 24, 1856), Figure 3, in Minard, *Collection de ses brochures* (Paris, 1821–1869), held by the Bibliothèque de l'École Nationale des Ponts et Chaussées, Paris.

## Narrative Graphics of Space and Time (pp. 40–43)

### The idea (p. 40)

An especially effective device for enhancing the explanatory power of time-series displays is to add spatial dimensions to the design, so that the data move over space (in two or three dimensions) as well as over time. Three excellent space-time-story graphics illustrate how multivariate complexity can be subtly integrated into graphical architecture — integrated so gently and unobtrusively that viewers are hardly aware they are looking into a world of four or five dimensions. Tufte contrasts this with graphics that are belligerently multivariate, advertising their technique rather than their data — but not these three (p. 40).

### Minard's map of Napoleon's march (pp. 40–41)

The first is the classic by Charles Joseph Minard (1781–1870), the French engineer: the graphic showing the terrible fate of Napoleon's army in Russia. E. J. Marey described it as seeming to defy the historian's pen by its brutal eloquence (footnote 12: E. J. Marey, *La méthode graphique*, Paris, 1885, p. 73; for more on Minard see Arthur H. Robinson, "The Thematic Maps of Charles Joseph Minard," *Imago Mundi*, 21 (1967), 95–108).

This combination of data map and time-series, drawn in 1869, portrays the sequence of devastating losses in Napoleon's Russian campaign of 1812. The narrative as Tufte tells it (p. 40):

- Beginning at the left, on the Polish-Russian border near the Niemen River, a thick tan flow-line shows the size of the Grand Army — 422,000 men — as it invaded Russia in June 1812.
- The width of the band indicates the army's size at each place on the map.
- In September the army reached Moscow, by then sacked and deserted, with 100,000 men.
- The path of the retreat from Moscow is depicted by a darker (black), lower band, which is linked to a temperature scale and to dates at the bottom of the chart.
- The winter was bitterly cold; many froze on the march out of Russia.
- The crossing of the Berezina River was a disaster, visible as a sudden thinning of the black band.
- The army finally struggled back into Poland with only 10,000 men remaining.
- The movements of auxiliary troops, protecting the rear and flank of the advancing army, are also shown as branch bands.

Tufte's analytical summary: Minard's graphic tells a rich, coherent story with its multivariate data, far more enlightening than just a single number bouncing along over time. **Six variables are plotted**: the size of the army; its location on a two-dimensional surface (two variables); the direction of the army's movement; and temperature on various dates during the retreat from Moscow (p. 40).

The verdict, set as its own paragraph: it may well be the best statistical graphic ever drawn (p. 40).

Page 41 reproduces the graphic twice: at top, Minard's French original — printed as a two-color (tan/black) lithograph in the form of a small poster, titled *Carte Figurative des pertes successives en hommes de l'Armée Française dans la campagne de Russie 1812–1813*, dated Paris, November 20, 1869, with Minard's explanatory text block beneath the title and the temperature chart (in degrees of the Réaumur thermometer below zero) running along the bottom, tied by vertical lines to positions of the retreat band; at bottom, an English translation. Margin notes (p. 40): the original is item 28 in the Bibliothèque de l'École Nationale des Ponts et Chaussées portfolio (62 by 25 cm, or 25 by 10 in); the English translation is by Dawn Finley with redrawing by Elaine Morse, completed August 2002.

### Los Angeles air pollution — and the definition of small multiples (p. 42)

The next time-space graphic, drawn by a computer, displays the levels of three air pollutants over a two-dimensional surface — six counties in southern California — at four times during the day (*Los Angeles Times*, July 22, 1979; based on work of Gregory J. McRae, California Institute of Technology).

The figure: a 3 × 4 grid of three-dimensional perspective surface plots, with a small key map at top identifying the terrain (Santa Barbara, Ventura, Los Angeles, San Bernardino, Orange, and Riverside counties, with the boundary of the air basin marked). Rows are pollutants — nitrogen oxides, carbon monoxide, reactive hydrocarbons. Columns are time slices — midnight to 3 a.m., 6 a.m. to 9 a.m., noon to 3 p.m., 3 p.m. to 6 p.m. Pollution concentration rises as spiky peaks off each county map.

Tufte's substantive reading (p. 42):

- Nitrogen oxides (top row) come from power plants, refineries, and vehicles. Refineries along the coast and Kaiser Steel's Fontana plant produce the post-midnight peaks in the first panel; traffic and power plants (with their heavy daytime demand) push levels up during the day.
- Carbon monoxide (second row) is low after midnight except out at the steel plant; morning traffic then begins generating each day's ocean of carbon monoxide, with the greatest concentration at the convergence of five freeways in downtown Los Angeles.
- Reactive hydrocarbons (third row), like nitrogen oxides, come from refineries after midnight and increase with daytime traffic.
- Quantities: each of the 12 time-space-pollutant slices summarizes pollutant levels at 2,400 spatial locations (squares five kilometers on a side), so 28,800 pollutant readings are shown — except those masked by peaks in the perspective views.

This display introduces a term of art that recurs throughout the book: the air pollution display is a **small multiple**. The same graphical design structure is repeated for each of the twelve slices. Small multiples are economical: once viewers understand the design of one slice, they have immediate access to the data in all the others. As the eye moves from slice to slice, the constancy of the design allows the viewer to focus on changes in the *data* rather than changes in the graphical design (p. 42).

### The Japanese beetle's year (p. 43)

The third space-time-story graphic ingeniously mixes space and time on the horizontal axis. The design moves well beyond the conventional time-series through its clever plotting field: the vertical axis is location relative to the ground surface; the horizontal axis is time/space combined. The subject is the life cycle of the Japanese beetle (p. 43).

The figure: a wide panel divided by vertical month lines, January through December. The upper portion shows the scene above ground (grass, then a leafy plant with adult beetles feeding on leaves and fruit in summer); the lower portion is a soil cross-section in which the grub's burrow winds along — the larva shown overwintering deep in the soil through the cold months, rising near the surface in spring, pupating, emerging as an adult around June–July, then new grubs descending again in autumn. Source: L. Hugh Newman, *Man and Insects* (London, 1965), pp. 104–105.

The design lesson: axes need not be literal single variables; a plotting field can be built from a physical cross-section and a hybrid time/space dimension and still read naturally.

## More Abstract Designs: Relational Graphics (pp. 43–50)

### The great abstraction, taken in stages (pp. 43–44)

The invention of data graphics required replacing the latitude-longitude coordinates of the map with more abstract measures not based on geographical analogy. Moving from maps to statistical graphics was a big step, and thousands of years passed before Lambert, Playfair, and others took it in the eighteenth century (p. 43). This resumes the thread from the Apianus discussion (p. 22).

Even then, the break was gradual: analogies to the physical world served as the conceptual basis for early time-series. Playfair repeatedly compared his charts to maps, and in the preface to the first edition of *The Commercial and Political Atlas* argued that his charts corresponded to a physical realization of the data. His thought experiment (quoted from pages iii–iv; paraphrased): suppose the money paid each year for Navy expenses were in guineas, laid on a large table in a straight line with the coins touching, and the next year's payment laid in another line, and so on for a number of years; the lines would have different lengths and would form a shape whose dimensions agreed exactly with the sums, a guinea's value being represented by the space it covered. The charts are exactly this at small scale — one division stands for the breadth or value of ten thousand or a hundred thousand guineas, with the same exactness that a square inch on a map may represent a square mile of country; the charts are therefore a representation of the real money laid down in lines, just as it was originally paid away (pp. 43–44).

### The Statistical Breviary: graphics as designs-in-themselves (pp. 44–45)

Fifteen years later, in *The Statistical Breviary* — his most theoretical book about graphics — Playfair broke free of analogies to the physical world and drew graphics as designs-in-themselves (p. 44). The title page is reproduced in the margin: *The Statistical Breviary; shewing, on a principle entirely new, the resources of every state and kingdom in Europe; illustrated with stained copper-plate charts, representing the physical powers of each distinct nation with ease and perspicuity. By William Playfair.* (London, 1801; with an added similar exhibition of the ruling powers of Hindoostan.)

One of the four plates in the *Breviary* is shown (p. 44): a color chart titled as a statistical chart showing the extent, population, and revenues of the principal nations of Europe in the order of their magnitude. Tufte singles it out for three distinctions: its multivariate data; its use of *area* to depict quantity; and the *pie chart* — apparently the first application of these devices (p. 44).

Construction, as Tufte explains it (pp. 44–45):

- Each country is a circle whose **area** represents the country's extent; the circles are arranged left to right in descending size order (the largest, the Russian Empire, shown as nested rings distinguishing European and Asiatic dominions; the Turkish Empire sliced into wedge-shaped sectors for its Asiatic, European, and African parts — the wedge-cut Turkish circle is the first true pie chart, and these subdivided circles together mark the device's debut).
- A vertical line rises from each circle's left edge: the country's **population in millions**, read on the vertical scales (the horizontal rulings across the plate).
- A vertical line rises from each circle's right edge (in a different color, yellow vs. red): the country's **revenue from taxes in millions of pounds sterling**, also read on the vertical scale.
- Playfair's own caption text (quoted from *Breviary* pages 13–14; paraphrased): dotted lines drawn between the population and revenue lines merely connect the lines belonging to the same country, and the ascent of those lines — right-to-left or left-to-right — shows whether the country is burdened with heavy taxes in proportion to its population, or otherwise.

Tufte's design critique (p. 45): the **slope** of the dotted line is uninformative, because it depends on the circle's diameter as well as on the heights of the two verticals — the magnitude of the slope is an artifact of layout geometry. However, the **sign** of the slope does make sense, and it carries Playfair to his familiar point about excessive taxation in Britain: Britain is the sixth circle from the right, with its connecting line sloping opposite to most countries (population small relative to a very tall revenue line). The general caution: do not let an encoding's apparent meaning depend on incidental geometry.

Why did Playfair plot three variables together? Tufte quotes his rationale (from *Breviary* page 15; paraphrased): the author had applied lines to matters of commerce and finance about fifteen years earlier with great success, his mode being generally approved as not only facilitating study but rendering it clearer and more easily retained by memory. The present charts likewise aim to aid statistical studies by showing the sizes of different countries to the eye in *similar forms* — for where forms are not similar, the eye cannot compare them easily or accurately. That is why we have a more accurate idea of the sizes of the planets, which are spheres, than of the nations of Europe seen on maps, which are all irregular and mutually unlike forms. Size, population, and revenue being the three principal objects of attention in statistical studies, whether from curiosity or interest, he represented all three in one view (p. 45).

Two general principles emerge: similar forms enable visual comparison (dissimilar irregular shapes defeat it), and multivariate arrangement is valuable precisely because it fosters comparisons.

### Lambert, the clearer thinker (pp. 45–46)

But here Playfair had a forerunner — one who thought more clearly about the abstract problems of graphical design than Playfair did, for Playfair lacked mathematical skills (p. 45). A most remarkable and explicit early theoretical statement advancing the general (non-analogical) relational graphic was made by J. H. Lambert in 1765 — 35 years before *The Statistical Breviary*.

Lambert's 1765 statement (quoted via footnote 13; paraphrased): in general we have two variable quantities, x and y, collated with one another by observation, so that for each value of x — which may be considered an abscissa — we can determine the corresponding ordinate y. If the experiments or observations were completely accurate, the ordinates would give a set of points through which a straight or curved line should be drawn. But since they are not, the line deviates more or less from the observational points; it must therefore be drawn so that it comes as near as possible to its true position, passing, as it were, through the middle of the given points (p. 45). This is the theory of the fitted line, stated in 1765.

Footnote 13: Johann Heinrich Lambert, *Beyträge zum Gebrauche der Mathematik und deren Anwendung* (Berlin, 1765), as quoted in Laura Tilling, "Early Experimental Graphs," *British Journal for the History of Science*, 8 (1975), 204–205.

**Lambert's graphical calculus of evaporation** (p. 46). Following Tilling's account, Tufte describes Lambert's graphical derivation of the evaporation rate of water as a function of temperature. The analysis begins with two time-series plotted in one frame (reproduced as Lambert's Fig. 4): curve DEF, showing the decreasing height of water in a capillary tube as a function of time, and curve ABC, the temperature over the same period. The slope of curve DEF is then measured at a number of places — the figure shows the tangent line DEG drawn to take a slope — yielding the rate of evaporation at each moment. To complete the graphical calculus, the measured rate is plotted against the corresponding temperature in a relational graphic (Lambert's Fig. 5: a single curve rising from A at lower left steeply up to C at upper right, with vertical drop lines marking the plotted values; temperature on the horizontal to 60, rate on the vertical).

Source: J. H. Lambert, "Essai d'hygrométrie ou sur la mesure de l'humidité," *Mémoires de l'Académie Royale des Sciences et Belles-Lettres … 1769* (Berlin, 1771), plate 1, facing p. 126; reproduced from Tilling's article.

The intellectual content: Lambert literally manufactured a relational graphic from two time-series by graphical differentiation — slope-taking as computation — eliminating time as the middleman between the two substantive variables.

### The liberation and its consequence (pp. 46–47)

Thus by the early 1800s, thanks to Lambert and Playfair, graphical design was at last no longer dependent on direct analogy to the physical world. The meaning — simple but profound: *any* variable quantity could be placed in relationship to *any other* variable quantity, measured for the same units of observation. Because data graphics became relational, no longer tied to geographic or time coordinates, they became relevant to all quantitative inquiry (pp. 46–47).

The modern evidence for that relevance: in current scientific literature, about 40 percent of published graphics have a relational form — two or more variables, none of which is latitude, longitude, or time (p. 47).

This is no accident, Tufte argues, because the relational graphic — in its barest form the scatterplot and its variants — is the greatest of all graphical designs. It links at least two variables, encouraging and even imploring the viewer to assess the possible causal relationship between them. It confronts causal theories that X causes Y with empirical evidence about the actual relationship between X and Y (p. 47).

### Smoking and lung cancer (p. 47)

The exemplar of theory-meets-evidence: a scatterplot headed "Crude male death rate for lung cancer in 1950 and per capita consumption of cigarettes in 1930 in various countries." Eleven countries are plotted as labeled star-points: Iceland, Norway, Sweden, Denmark, Australia, Canada, Holland, Switzerland, Finland, Great Britain, and the U.S.A. The vertical axis is deaths per million (0–500); the horizontal axis is cigarette consumption (gridlines at 250, 500, 750, 1000, 1250, 1500). A heavy fitted line rises across the plot, annotated r = 0.73 ± 0.30. Great Britain sits at the top right (very high consumption, deaths near 470 per million); Iceland at the bottom left; the U.S.A. falls conspicuously below the fitted line (high consumption, around 190 deaths per million); Finland sits high (around 350).

Source: Report of the Advisory Committee to the Surgeon General, *Smoking and Health* (Washington, D.C., 1964), p. 176; based on R. Doll, "Etiology of Lung Cancer," *Advances in Cancer Research*, 3 (1955), 1–50.

Note the built-in causal logic of the design: consumption is measured in 1930 and death rates in 1950 — exposure before outcome, a twenty-year lag wired into the variables themselves.

### Phillips-curve small multiples (p. 48)

Relational graphics also *test and reject* theories. These small-multiple relational graphs show unemployment and inflation over time in "Phillips curve" plots for nine countries, demonstrating the collapse of what was once thought to be an inverse relationship between the variables (p. 48).

The figure, titled "Inflation and Unemployment Rates (Per cent)": a 3 × 3 grid of panels — Canada, United States, Japan; United Kingdom, France, Germany; Netherlands, Sweden, Italy. Each panel plots the yearly increase in the consumer price index (vertical, labeled "Increase in CPI") against the unemployment rate (horizontal, labeled in the panels as the male unemployment rate), with each year's point connected to the next in temporal order and labeled by year (mid-1950s through 1976). Where the old theory predicted a clean downward-sloping curve, the connected paths form tangled loops in the early years and then shoot up and to the right after the early 1970s (stagflation): for example, the United States path coils around 1956–1971 and then sweeps to high inflation and high unemployment by 1974–1976; Japan spikes to over 20 percent inflation in 1974.

Source: Paul McCracken, et al., *Towards Full Employment and Price Stability* (Paris, 1977), p. 106.

Design notes embedded in the example: a time sequence can live inside a relational plot (connect the dots in year order, label years), and the small-multiple grid lets one theory be checked against nine countries at a glance.

### Thermal conductivity of copper (p. 49)

Theory and measured observation diverge in the physical sciences too. The relationship between temperature and the thermal conductivity of copper is assessed across a series of measurements from many different laboratories. In the chart, the connected points from any single publication are tagged with that publication's identification number. The very different answers reported in the published literature result mainly from impurities in the copper samples (p. 49). Tufte's praise: note how effectively the graphic organizes a vast amount of data, recording the findings of hundreds of studies on a single page while at the same time enforcing comparisons of the varying results.

The figure: a dense log-log plot titled "Thermal Conductivity of Copper" — thermal conductivity (W cm⁻¹ K⁻¹) against temperature (K) — filled with scores of curves, each a chain of measured points labeled with a circled study number. Most curves rise to a peak somewhere between about 10 K and 100 K and then fall toward a common band at high temperature; the family of peaks spans roughly two orders of magnitude in height (the impurity effect). A heavy curve labeled "RECOMMENDED" threads through the upper envelope, and a separate "RECOMMENDED (liquid)" segment appears at the far right beyond the melting point.

Source: C. Y. Ho, R. W. Powell, and P. E. Liley, *Thermal Conductivity of the Elements: A Comprehensive Review*, supplement no. 1, *Journal of Physical and Chemical Reference Data*, 3 (1974), 1–244.

### Data points that are themselves data (p. 50)

Finally, two relational designs of a different sort, in which the plotted points are themselves data:

1. **Faces on a fear-by-rage field.** The effect of two interacting variables is portrayed by drawings placed on the plotting field: a 3 × 3 array of dog faces, with fear increasing up the vertical axis and rage increasing along the horizontal. Each face shows the behavioral expression produced by that combination — ears flattening and cowering as fear rises, teeth bared and muzzle wrinkled as rage rises, and blended threat-fear expressions in between. Source: E. C. Zeeman, "Catastrophe Theory," *Scientific American*, 234 (April 1976), 67; based on Konrad Z. Lorenz, *King Solomon's Ring* (New York, 1952).
2. **Pine seedlings by calcium dose.** Similarly, the varying sizes of white pine seedlings after growing for one season in sand containing different amounts of calcium, in parts per million, in nutrient-sand cultures. The figure: six botanical drawings of whole seedlings — shoots above and full root systems below a shared ground line — labeled 0, 50, 100, 300, 600, 900 (ppm calcium). Growth visibly improves from 0 up through about 300 ppm (the largest, bushiest seedling with the deepest roots) and then declines at 600 and 900. Source: H. L. Mitchell, *The Growth and Nutrition of White Pine Seedlings in Cultures with Varying Nitrogen, Phosphorus, Potassium and Calcium*, The Black Rock Forest Bulletin No. 9 (Cornwall-on-the-Hudson, New York, 1939), p. 70.

The shared idea: the plotting symbol need not be an abstract dot; an image can serve as the data point, carrying additional dimensions of information (expression, morphology) beyond the two coordinate variables.

## Principles of Graphical Excellence (p. 51)

The chapter ends with a boxed summary of five statements (paraphrased here; the original is a set of declarative one-liners):

1. Graphical excellence is the well-designed presentation of interesting data — a matter of *substance*, of *statistics*, and of *design*.
2. Graphical excellence consists of complex ideas communicated with clarity, precision, and efficiency.
3. Graphical excellence is what gives the viewer the greatest number of ideas, in the shortest time, with the least ink, in the smallest space.
4. Graphical excellence is nearly always multivariate.
5. Graphical excellence requires telling the truth about the data.

Statement 3 is illustrated with a small drawing: a stick-figure viewer whose eye projects a widening cone of sight onto a reproduction of Minard's Napoleon graphic; the cone's stages are labeled, in order from the eye outward, *ideas*, *time*, *ink*, *space* — a literal diagram of the maximization (ideas) and the three minimizations (time, ink, space).

The five statements map back onto the chapter's structure: substance (the sunspots counterexample), statistics and the revelation of data (Anscombe), efficiency (Snow versus computation; the 700-word franked-mail story), multivariateness (Minard's six variables; Playfair's three objects in one view), and truth-telling — the last pointing directly into Chapter 2, "Graphical Integrity."

## Bridge epigraphs (p. 52)

The page facing Chapter 2 carries three epigraphs, all bearing on truth and persuasion in charts (paraphrased):

- William Playfair, *The Commercial and Political Atlas* (London, 1786): most people readily accept the propriety and justness of representing sums of money and time by parts of space, yet a few suspect there may be some deception hidden in it that they cannot quite identify.
- State Statistical Bureau of the People's Republic of China, *Statistical Work in the New China* (Beijing, 1979): people said that with the chart on the wall and the figures published, they would emulate one another and rouse their enthusiasm for production — graphics as exhortation.
- James Thurber, *Further Fables for Our Time* (New York, 1956): a two-line moral warning to get it right or leave it alone, since the conclusion you jump to may be your own.

These set up Chapter 2's subject, graphical integrity, completing the arc begun by principle 5 of the summary box.

## Index of terms of art introduced in this chapter

- **Graphical excellence** — defined p. 13, formalized p. 51.
- **Anscombe's quartet** — pp. 13–14.
- **Wildshot observation** — an outlier that dominates calculations; p. 14.
- **Data maps** (cartographers' "thematic maps") — pp. 15–27, footnote 3 p. 20.
- **"Blot maps" / "patch maps"** — shaded-in-area maps whose visual weight follows area, not population; p. 20.
- **Time-series** — pp. 28–39.
- **Graphical arithmetic** — visual computation of a derived series (Playfair's trade balance as the gap between curves); p. 32.
- **Before-after time-series** — p. 39.
- **Narrative graphics of space and time / space-time-story graphics** — pp. 40–43.
- **Small multiple** — repeated constant design across data slices; defined p. 42.
- **Relational graphics** — displays linking two or more non-geographic, non-time variables; pp. 43–50.
- **Fitted line** (Lambert, 1765) — p. 45.
- **Graphical calculus** — deriving new variables by graphical operations such as slope-taking; p. 46.
- **Data points that are themselves data** — image-as-point designs; p. 50.
