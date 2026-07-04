# Chapter 1: Graphical Excellence — Examples

### Anscombe's quartet (pp. 13–14)

Four small data sets constructed by statistician F. J. Anscombe (published 1973 in *American Statistician*). All four share exactly the same summary statistics: N = 11, mean of X's = 9.0, mean of Y's = 7.5, regression line Y = 3 + 0.5X, standard error of slope 0.118, t = 4.24, sum of squares X − X̄ = 110.0, regression sum of squares = 27.50, residual sum of squares of Y = 13.75, correlation coefficient .82, r² = .67 — the same linear model "at least until the residuals are examined." Yet when plotted, they differ vividly: one is a normal linear scatter, one a clean curve, one a perfect line with a single outlier, and one a vertical stack with one extreme point. Tufte's lesson: graphics reveal data and can be more precise and revealing than conventional statistical computations — identical numbers can hide completely different structures, so always plot the data.

### The wildshot outlier scatterplot (p. 14)

A scatterplot from Brier and Fienberg's work on econometric modeling of crime and punishment (1980). It contains a point A, a "wildshot" observation that would dominate standard statistical calculations. Crucially, point A hides in the marginal distributions (the tick marks along each axis look unremarkable) but shows up as clearly exceptional in the bivariate scatter. Lesson: only a two-variable display exposes outliers that one-variable summaries conceal.

### Solar radiation and stock prices (p. 15)

A 1929 chart (after Garcia-Mata and Shaffner, reproduced from Dewey and Dakin's *Cycles: The Science of Prediction*, 1947) overlaying New York stock prices, inverted solar radiation, and London stock prices by month, implying sunspots drive markets. Tufte uses it as a negative example: graphics are only as good as what goes into them. An ill-specified or preposterous model cannot be rescued by a graphic. "A silly theory means a silly graphic."

### The cancer atlas maps (pp. 16–19)

Six maps from the *Atlas of Cancer Mortality for U.S. Counties: 1950–1969* (Mason, McKay, Hoover, Blot, and Fraumeni, U.S. Public Health Service, 1975; redesigned and redrawn by Lawrence Fahey and Edward Tufte). Each map shows age-adjusted cancer death rates for all 3,056 U.S. counties using a five-level shading scheme that combines magnitude (decile) with statistical significance — about 21,000 numbers per map (each county's rate is located in two dimensions, and at least four more numbers would be needed to reconstruct each county's size and shape, so a 7 × 3,056-entry data matrix suffices to reproduce a map). Readers can see national patterns (high rates in the Northeast and around the Great Lakes), regional bands (a low east-west band across the middle of the country), sex differences (higher male rates in the South, probably occupational asbestos exposure in shipyards), hot spots (northern Minnesota; Iowa and Nebraska counties along the Missouri River), and cancer-type geography (high north-central stomach cancer, probably Scandinavian smoked-fish consumption). The maps generated real etiologic leads: investigation of Salem County, New Jersey — the national leader in white-male bladder cancer, where about 25 percent of employed persons worked in the chemical industry — uncovered at least 330 workers with bladder tumors at a single chemical plant over 50 years. Tufte also uses the maps to teach two cautions: shaded "blot maps" wrongly equate a county's visual importance with its geographic area rather than its population, and the underlying death-certificate data carry diagnostic fads that may create spurious regional clustering.

### The Yü Chi Thu (Map of the Tracks of Yü the Great) (pp. 20–21)

A Chinese map carved in stone in 1137 A.D. (probably dating from before 1100), with a full cartographic grid at a scale of 100 li per division, showing coastlines and river systems with remarkable precision. Joseph Needham called it the most remarkable cartographic work of its age in any culture, far ahead of contemporary European religious cosmography; Europe had nothing like it until about 1550. Tufte's point: sophisticated geographic mapping existed centuries before anyone drew a data map — the grid existed, but not the idea of plotting measured quantities on it.

### Apianus's Cosmographia map frame (p. 22)

The 1546 edition of Petrus Apianus's *Cosmographia* included map designs with numbered coordinate borders and crossed threads to locate cities — visually very close to a bivariate scatterplot. But no one had yet made the quantitative abstraction of placing a measured quantity at the intersection of the threads instead of a city name, let alone replacing latitude and longitude with dimensions like time and money. The first economic time-series was not plotted until 1786. Lesson: the conceptual leap from geographic to abstract coordinates took centuries.

### Halley's trade winds and monsoons map (p. 23)

Edmond Halley's 1686 world chart, one of the first data maps, showing trade winds and monsoons. Short stroke symbols cover the oceans; as Halley wrote, the sharp end of each little stroke points out the direction from which the wind continually comes, and where monsoons blow the rows of strokes run alternately backwards and forwards, making them denser. An early example of encoding measured phenomena (wind direction and regime) onto geographic space.

### John Snow's cholera dot map (p. 24)

Dr. John Snow's famous 1854 map plotting cholera deaths in central London as dots and the area's eleven water pumps as crosses. The scatter showed deaths concentrated around the Broad Street pump; Snow had the pump handle removed, ending an epidemic that had killed more than 500 people. Tufte notes the link could have been found by computation without graphics, "with some good luck and hard work," but here graphical analysis testified about the data far more efficiently than calculation. A landmark of a data map driving a causal discovery and a life-saving intervention.

### Minard's map of French wine exports (pp. 24–25)

Charles Joseph Minard's flow map of 1864 French wine exports by sea (from his *Tableaux Graphiques et Cartes Figuratives*, 1845–1869). Tan flow-lines spread from France across the world's oceans, with the width of each band proportional to the quantity of wine shipped. Tufte's point: Minard gave quantity as well as direction to data measures located on a world map — an advance over maps that only marked position.

### The Lick galaxy map (pp. 26–27)

A 1977 map (Seldner, Siebers, Groth, and Peebles) of 1.3 million galaxies in the northern galactic hemisphere. The sky is divided into 1,024 × 2,222 rectangles; the galaxy count in each of the 2,275,328 cells is shown in ten gray tones, darker meaning more galaxies. Computerized cartography increased information density about 5,000-fold over Halley's pioneering map. The map revealed an unanticipated clustered texture of the universe. But its producers warn that the apparent filamentary patterns may mislead: the eye picks out linear patterns even in random noise, and similar patterns appear in simulated catalogs with no built-in linear structure. Tufte concludes that the most extensive data maps "place millions of bits of information on a single page before our eyes. No other method for the display of statistical information is so powerful."

### The tenth-century planetary movements graph (p. 28)

A reputed tenth- or possibly eleventh-century illustration of the inclinations of planetary orbits as a function of time, apparently from a text for monastery schools. It is the oldest known attempt to show changing values graphically, and a mysterious, isolated wonder: the next extant plotted time-series appears some 800 years later. Funkhouser notes its astronomical content is confused — the wavy path ascribed to the sun is particularly disconcerting, and the graph shows an erasure and correction.

### Lambert's soil temperature curves (p. 29)

A drawing by Johann Heinrich Lambert (from *Pyrometrie*, 1779), one of a long series, showing the periodic variation of soil temperature in relation to depth below the surface: the greater the depth, the greater the time-lag in temperature response. Tufte notes that modern graphics of time-series periodicities differ little from Lambert's, though today's data bases are far larger. Time-series charts began appearing in scientific writing only in the late 1700s.

### Voyager 2 Jupiter radio emissions (p. 29)

A plot of radio emissions from Jupiter recorded by Voyager 2 in July 1979 (Gurnett, Kurth, and Scarf). Three radio bands plus spacecraft latitude are stacked as multiple time-series; radio intensity cycles every ten hours as Jupiter rotates, peaking when the north magnetic pole tips toward the spacecraft. The horizontal axis carries dual labels — date and distance in Jupiter radii — and the bottom latitude panel doubles as an axis label describing the spacecraft's changing orientation. The display compresses 453,600 eight-bit instrument samples (3.6 million bits) into 18,900 plotted points. Lesson: multiple time-series enforce comparisons within and between series, and axes can be made to carry extra variables.

### New York City's weather for 1980 (p. 30)

A *New York Times* graphic (January 11, 1981) summarizing New York City's 1980 weather in 1,888 numbers: daily high and low temperatures against the long-run normal band, plus precipitation and relative humidity panels. The normal-temperature path even forecasts expected change (in mid-February, warming of about 1.5 degrees per week until the July peak). Tufte contrasts it with wasting graphics on simple linear changes better stated as one or two numbers: this graphic "successfully organizes a large collection of numbers, makes comparisons between different parts of the data, and tells a story."

### Marey's graphical train schedule, Paris–Lyon (p. 31)

E. J. Marey's published train schedule (from *La méthode graphique*, 1885; method attributed to the French engineer Ibry). Stations run down the vertical axis, spaced in proportion to actual distance; time of day runs horizontally. Each train is a diagonal line: slope shows speed (more vertical = faster), horizontal segments show stop length, and intersections show where and when opposing trains pass. Tufte overlays the path of the 1981 TGV, which cut the trip from over nine hours to under three — the modern train's nearly vertical red line dramatizes a century of progress on the same design.

### Playfair's imports and exports of England chart (p. 32)

From William Playfair's *The Commercial and Political Atlas* (London, 1786), the first known time-series of economic data. Import and export curves for England, 1700–1782, with the area between them colored to show the shifting balance of trade — "graphical arithmetic" displaying the difference between two series. Playfair argued charts beat tables because a studied table leaves only "a very faint and partial idea" soon erased, while a chart leaves a "simple and complete" impression including both duration and amount. For Playfair, graphics showed the shape of data in a comparative perspective.

### Playfair's first bar chart: Scotland's trade (p. 33)

The one chart of 44 in the first *Commercial and Political Atlas* that is not a time-series: imports and exports of Scotland to and from 17 countries for one year (1781), ordered by volume of trade — the first known bar chart. Playfair invented it only because year-to-year data were missing, and he was skeptical of it: lacking the time dimension, it "does not compare the same branch of commerce with itself at different periods." Tufte agrees: "small, noncomparative, highly labeled data sets usually belong in tables." Details noted: zero values shown both by absent bars and a "0"; the scale mistakenly repeats "200"; Playfair's right-side vertical labels suggest he plotted left-handed.

### Playfair's wheat prices versus wages chart (p. 34)

From Playfair's last book (*Letter on our agricultural distresses...*, data 1565–1821): three parallel time-series showing the price of the quarter of wheat, the weekly wages of a good mechanic, and the reigns of British kings and queens across 250 years. Playfair's argument: never before had wheat been so cheap relative to mechanical labor. An early model of putting multiple series in one frame so the viewer can compare proportions across eras.

### Marey's chart of English rulers, peace and war (pp. 34–35)

E. J. Marey's construction (from *La Méthode Graphique*, 1885) combining several sets of facts about English rulers — reign spans from the 1660s to the 1860s plus the relative durations of periods of peace and war — into one time-series that "conveys a sense of the march of history." An example of the long graphical tradition of royal history and genealogy done well.

### Marey's motion studies (pp. 35–36)

Marey (1830–1904) pioneered graphical methods in human and animal physiology: time-series of horse gaits recorded by hoof tracks (ordinary walk, long-stride walk, quick walk, amble, jog-trot, gallop), a starfish turning itself over, the undulating dorsal fin of a descending sea-horse, the advance of a gecko, and a man in black velvet photographed as stick-figure images — which became the time-series forerunner of Marcel Duchamp's *Nude Descending a Staircase*. These show time-series extended to recording motion itself.

### Congressional franked mail (p. 37)

A time-series of monthly outgoing mail from the U.S. House of Representatives, 1967–1972. The volume peaks every two years, in October just before election day — a rare case where descriptive chronology does testify about causality, because a clear mechanism (incumbents exploiting free mailing privileges for re-election) drives the Y-variable. Tufte pairs it with the roughly 700-word news report needed to say the same thing: "the graphic is worth at least 700 words."

### Decomposition of U.S. retail sales (p. 38)

Julius Shiskin's decomposition of total U.S. retail sales, 1960–1971 (1,296 numbers): the unadjusted series broken into holiday, trading-day, seasonal, and irregular components to reveal the trend-cycle and inflation-adjusted series at the bottom. It shows how time-series move toward causal explanation by smuggling additional variables into the design. Tufte flags a defect: the vertical grid conceals the height of the December peaks.

### The magnetic monopole candidate (p. 39)

Blas Cabrera's February 14, 1982 detector record (reported in *Science*): magnetic flux through a superconducting loop holds flat, then jumps abruptly by exactly the magnitude a passing magnetic monopole would cause, and stays stable afterward. Tufte's example of the vivid "before-after" time-series design — when the data have a genuine discontinuity.

### Minard's bridge collapse drawing (p. 39)

Charles Joseph Minard's 1856 before-and-after drawing of the Pont de Bourg-St. Andéol on the Rhône, which collapsed in 1840: the bridge shown tilting as the riverbed scoured beneath a pier. Another before-after design, here explaining a structural failure.

### Minard's map of Napoleon's march on Moscow (pp. 40–41)

Charles Joseph Minard's 1869 *Carte Figurative* of the French Army's losses in the Russian campaign of 1812–1813 — described by Marey as seeming to defy the historian's pen by its brutal eloquence, and by Tufte as possibly "the best statistical graphic ever drawn." A combined data map and time-series: a thick tan band starting at the Polish-Russian border shows the Grand Army of 422,000 invading in June 1812, its width proportional to army size at each location; the army reaches Moscow with 100,000; a darker band traces the retreat, tied to a temperature scale with dates along the bottom; the Berezina River crossing is a visible disaster; only 10,000 men return to Poland. Auxiliary troop movements are also shown. Six variables are plotted: army size, location in two dimensions, direction of movement, and temperature on the dates of the retreat. The lesson: multivariate data woven gently into one design tells a far richer, more enlightening story than "a single number bouncing along over time."

### Los Angeles air pollution small multiples (p. 42)

A computer-drawn graphic (*Los Angeles Times*, 1979, based on Gregory McRae's work) showing three pollutants — nitrogen oxides, carbon monoxide, reactive hydrocarbons — over a map of six southern California counties at four times of day: twelve time-space-pollutant slices, each summarizing 2,400 spatial locations, about 28,800 readings in all. The display reveals sources (refineries' post-midnight peaks, the steel plant, morning traffic, the five-freeway convergence downtown). Tufte uses it to define the **small multiple**: the same design repeated for every slice, so once viewers understand one slice they have immediate access to all; design constancy lets attention go to changes in the data, not changes in design.

### The Japanese beetle life cycle (p. 43)

An illustration from L. Hugh Newman's *Man and Insects* (1965) showing the beetle's year: the vertical axis is position relative to the ground surface (above ground among plants, below ground in the soil) and the horizontal axis ingeniously mixes time (January through December) and space. The grub burrows, overwinters, pupates, emerges, feeds, and lays eggs across the panel. An example of a space-time narrative that moves beyond the conventional time-series through a clever plotting field.

### Playfair's Statistical Breviary chart (pp. 44–45)

A plate from Playfair's *The Statistical Breviary* (1801), his most theoretical book, where he broke free of physical analogies and drew "graphics as designs-in-themselves." Fifteen years earlier, in the preface to the *Atlas*, Playfair had still justified his charts by analogy to the physical world: the Navy's yearly expense imagined as guineas laid touching each other in straight lines on a table, the charts being "a representation of the real money laid down in different lines," with the same exactness "that a square inch upon a map may represent a square mile of country" (pp. 43–44). For each European state, a circle's area shows the country's extent, a left vertical line shows population in millions, a right vertical line shows tax revenue in millions of pounds, and a dotted line connects the two; this plate is apparently the first use of area to depict quantity and the first pie chart. Tufte notes the dotted line's slope is uninformative — it depends on circle diameter as well as the two heights — though its sign meaningfully shows whether a country is over-taxed relative to population (Playfair's point about Britain). Playfair championed the multivariate arrangement because the eye can compare similar forms easily, dissimilar forms (like irregular nations on maps) only poorly.

### Lambert's graphical calculus of evaporation (pp. 45–46)

J. H. Lambert's 1765 statement anticipated relational graphics 35 years before *The Statistical Breviary*: two variable quantities x and y collated by observation, with a line drawn "as near as possible to its true position... through the middle of the given points" — the fitted line. Lambert's 1769 evaporation analysis works as a graphical calculus: two time-series (water height in a capillary tube falling over time, and temperature) yield, via slopes taken at many points, the evaporation rate, which is then plotted against temperature in a relational graphic. With Lambert and Playfair, graphical design no longer depended on direct analogy to the physical world: any variable could be placed in relationship to any other.

### Smoking and lung cancer scatterplot (p. 47)

From the 1964 Surgeon General's report *Smoking and Health* (based on R. Doll's work): crude male lung-cancer death rates in 1950 plotted against per capita cigarette consumption in 1930 for eleven countries, with a fitted line (r = 0.73 ± 0.30). Great Britain sits high, the U.S.A. below the line. Tufte's exemplar of why the relational graphic — the scatterplot in its barest form — "is the greatest of all graphical designs": it confronts the causal theory that X causes Y with empirical evidence about the actual relationship.

### Phillips curve small multiples (p. 48)

Nine connected scatterplots (from McCracken et al., *Towards Full Employment and Price Stability*, 1977) tracing inflation against unemployment year by year for nine countries. The tangled, looping paths demonstrate the collapse of what was once thought to be a stable inverse relationship between the two variables. A small-multiple relational design used to test (and reject) an economic theory across countries.

### Thermal conductivity of copper (p. 49)

A chart from Ho, Powell, and Liley (1974) plotting hundreds of laboratories' measurements of copper's thermal conductivity against temperature, each publication's points connected and tagged with an identification number, with a "recommended" curve marked. The wide divergence among studies stems mainly from impurities in the copper samples. Tufte praises how the graphic organizes a vast amount of data — hundreds of studies on a single page — while enforcing comparisons of the varying results.

### Data points that are themselves data (p. 50)

Two relational designs where the plotted marks carry data. First, Zeeman's catastrophe-theory diagram (after Konrad Lorenz): dog faces drawn across a fear-by-rage plotting field, each face showing the behavioral expression produced by that combination of the two variables. Second, H. L. Mitchell's 1939 white pine seedlings: actual drawings of seedlings, roots and all, arrayed by the calcium concentration (0 to 900 parts per million) in which each grew for a season — the seedling images are the data points.

### Other examples mentioned

- Closing epigraphs (p. 52): Playfair on the propriety of representing money and time by space (1786); the State Statistical Bureau of the People's Republic of China on wall charts rousing enthusiasm in production (1979); James Thurber, "Get it right or let it alone. / The conclusion you jump to may be your own." (1956).
- A bare dashed upward-sloping line (p. 30) as the anti-example of wasting graphics on simple linear change.
- Footnote survey (p. 28): a random sample of 4,000 graphics from 15 of the world's newspapers and magazines, 1974–1980, found more than 75 percent were time-series.
