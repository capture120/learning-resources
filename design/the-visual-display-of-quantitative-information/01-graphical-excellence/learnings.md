# Chapter 1: Graphical Excellence

The chapter's central argument is simple: well-designed data graphics are the most powerful way to communicate quantitative information, and excellence in them means giving the viewer the greatest number of ideas in the shortest time with the least ink in the smallest space. Tufte argues this through history's best graphics — data maps, time-series, space-time narratives, and relational graphics — showing that excellence is nearly always multivariate and always truthful.

## What graphical displays should do (p. 13)

Excellence in statistical graphics consists of "complex ideas communicated with clarity, precision, and efficiency." Graphical displays should:

- show the data
- induce the viewer to think about the substance rather than about methodology, graphic design, the technology of graphic production, or something else
- avoid distorting what the data have to say
- present many numbers in a small space
- make large data sets coherent
- encourage the eye to compare different pieces of data
- reveal the data at several levels of detail, from a broad overview to the fine structure
- serve a reasonably clear purpose: description, exploration, tabulation, or decoration
- be closely integrated with the statistical and verbal descriptions of a data set

## Graphics reveal data (pp. 13–14)

> "Graphics *reveal* data." (p. 13)

Graphics can be more precise and revealing than conventional statistical computations. Anscombe's quartet proves this: four data sets share identical summary statistics (same means, same regression line Y = 3 + 0.5X, same r² = .67) yet are wildly different when plotted. Actionable rule: always plot the data; never trust summary statistics alone.

A scatterplot also exposes outliers ("wildshot" observations) that would dominate statistical calculations but hide in the marginal distributions — they show up only in the bivariate view (p. 14).

## Graphics are only as good as their content (p. 15)

A graphic cannot rescue an ill-specified or preposterous model, or a puny data set, any more than a calculation can.

> "A silly theory means a silly graphic." (p. 15)

Actionable rule: fix the substance before polishing the display. The quality of a graphic is first a question of the quality of the data and the thinking behind it.

## The four fundamental graphical designs (p. 15)

Tufte illustrates excellence — "nearly always of a multivariate sort" — through four fundamental design families:

1. **Data maps**
2. **Time-series**
3. **Space-time narrative designs**
4. **Relational graphics**

The example set serves three stated purposes: providing high-quality graphics that can be discussed (and sometimes even redrawn) in constructing a theory of data graphics, helping to demonstrate a descriptive terminology, and telling in brief the history of graphical development (p. 15).

## Data maps (pp. 16–27)

- Data maps achieve the highest information density of any display. The cancer atlas maps each show ~21,000 numbers; the galaxy map encodes 1.3 million galaxies. "No other method for the display of statistical information is so powerful." (p. 26)
- A good data map works at many levels of analysis at once: overall national patterns, regional bands, local hot spots, and single-county detail (p. 16). Design displays that reward inspection at several levels.
- Good maps generate hypotheses about causes — the cancer maps gave epidemiologists leads (e.g., shipyard asbestos, smoked fish) and even led to discovering a bladder-cancer cluster at a chemical plant (p. 16).
- Known defect of shaded-in-area "blot maps" or "patch maps": they wrongly equate the visual importance of each region with its geographic area rather than with its population or case count. Visual impression gets entangled with the accidents of boundary shapes and areas (p. 20). Beware this when designing choropleth maps.
- Data quality caveat: apparent spatial patterns may partly reflect measurement artifacts (here, diagnostic fashions in death certificates), not only real differences (p. 20). Always ask whether the data source could generate the pattern.
- Historical lesson: data maps appeared only in the seventeenth century, ~5,000 years after the first geographic maps. The hard intellectual step was the quantitative abstraction of placing a measured quantity (not a city name) at the intersection of grid coordinates (p. 22).
- Terminology: data maps are usually described as "thematic maps" in cartography (p. 20, footnote).
- Eye-pattern caveat from the galaxy map: the eye tends to pick out linear patterns even in random noise; similar filaments appear in simulated random catalogs. Treat visually detected texture with statistical skepticism (p. 26).

## Time-series (pp. 28–39)

- The time-series plot is the most frequently used graphic form: a sample of 4,000 published graphics (1974–1980) found more than 75 percent were time-series (p. 28). The natural ordering of the time scale gives the design "a strength and efficiency of interpretation found in no other graphic arrangement."
- **Reserve graphics for rich data.** Time-series displays are at their best for big data sets with real variability. "Why waste the power of data graphics on simple linear changes, which can usually be better summarized in one or two numbers?" (p. 30). Save graphics for "the richer, more complex, more difficult statistical material."
- Small, noncomparative, highly labeled data sets usually belong in tables, not charts — a conclusion Playfair himself reached about his own bar chart invention (p. 33).
- Graphics show the shape of the data in a comparative perspective; that comparative power is what made Playfair prefer them to tables (pp. 32–33). Graphics also make data memorable in a way tables are not (Playfair quote, p. 32).
- **Chronology is not causality.** "The simple passage of time is not a good explanatory variable: descriptive chronology is not causal explanation." (p. 37). Exceptions exist when a clear mechanism drives the Y-variable (e.g., the congressional franked-mail series peaking before every election).
- Time-series can be moved toward causal explanation by smuggling additional variables into the design — e.g., decomposing a series into seasonal, trading-day, irregular, and trend components (p. 38). The next analytical step is adding variables that explain the cleaned-up series.
- The before-after time-series is a vivid design when the data warrant it (p. 39).
- Multiple stacked time-series enforce comparisons both within each series over time and between series (Jupiter radio emissions, p. 29). Dual labels on an axis (date and distance) can carry extra variables.
- Watch grid interference: in the retail-sales decomposition, the vertical grid conceals the height of the December peaks — a design defect (p. 38).
- A good time-series "organizes a large collection of numbers, makes comparisons between different parts of the data, and tells a story" (the New York City weather chart, p. 30). It can even support forecasting by showing the normal path.

## Narrative graphics of space and time (pp. 40–43)

- Adding spatial dimensions to a time-series, so data move over space as well as time, greatly enhances explanatory power (p. 40).
- The best multivariate designs integrate complexity "so gently and unobtrusively that viewers are hardly aware that they are looking into a world of four or five dimensions." Avoid graphics that are "belligerently multivariate, advertising the technique rather than the data" (p. 40).
- Minard's map of Napoleon's 1812 Russian campaign plots six variables — army size, location (two dimensions), direction of movement, and temperature on dates of the retreat — and "may well be the best statistical graphic ever drawn" (p. 40). It tells a rich, coherent story "far more enlightening than just a single number bouncing along over time."
- **Small multiples** (defined here, p. 42): the same graphical design structure repeated for each slice of the data. "Small multiples are economical: once viewers understand the design of one slice, they have immediate access to the data in all the other slices." The constancy of the design lets the viewer focus on changes in the data rather than changes in graphical design.
- Axes need not be literal: time and space can share an axis (the Japanese beetle life cycle, p. 43).

## More abstract designs: relational graphics (pp. 43–50)

- The decisive invention in data graphics was replacing latitude-longitude with abstract, non-geographic measures. Lambert and Playfair took this step in the eighteenth century; the first economic time-series was plotted only in 1786 (pp. 22, 43, 46).
- "The two great inventors of modern graphical designs were J. H. Lambert (1728–1777), a Swiss-German scientist and mathematician, and William Playfair (1759–1823), a Scottish political economist" (p. 32). Lambert was the forerunner and thought more clearly about the abstract problems of graphical design than Playfair, who lacked mathematical skills (p. 45).
- The break from geography happened in stages: analogies to the physical world served as the conceptual basis for early time-series. Playfair defended his Atlas charts as a physical realization of the data — money imagined as guineas laid in lines on a table, just as "a square inch upon a map may represent a square mile of country" (pp. 43–44). Only fifteen years later, in *The Statistical Breviary* (1801), did he break free of such analogies and draw graphics as designs-in-themselves (p. 44).
- By the early 1800s, graphical design was "no longer dependent on direct analogy to the physical world," meaning "any variable quantity could be placed in relationship to any other variable quantity, measured for the same units of observation" (p. 46). This made data graphics relevant to all quantitative inquiry.
- In modern scientific literature about 40 percent of published graphics are relational — two or more variables, none of which is latitude, longitude, or time (p. 47).
- > "The relational graphic — in its barest form, the scatterplot and its variants — is the greatest of all graphical designs." (p. 47)
  It links at least two variables and encourages, even implores, the viewer to assess possible causal relationships. It confronts causal theories that X causes Y with empirical evidence about the actual relationship between X and Y.
- Lambert stated the theory of the fitted line in 1765: draw the line "as near as possible to its true position," passing "through the middle of the given points" (p. 45).
- Design caution from Playfair's Statistical Breviary chart: a visual element whose slope depends on arbitrary layout choices (circle diameter plus two verticals) is uninformative in magnitude even if its sign means something (pp. 44–45). Don't let encodings depend on incidental geometry.
- Playfair's reason for multivariate display: the eye cannot easily or accurately compare dissimilar forms; representing sizes "by similar forms" fosters comparison (p. 45).
- Data points may themselves be data — drawings (faces showing fear × rage, seedlings by calcium dose) can serve as the plotted points, encoding extra dimensions (p. 50).

## Principles of Graphical Excellence (p. 51)

Tufte's closing summary box, preserved faithfully:

- Graphical excellence is the well-designed presentation of interesting data — a matter of *substance*, of *statistics*, and of *design*.
- Graphical excellence consists of complex ideas communicated with clarity, precision, and efficiency.
- Graphical excellence is that which gives to the viewer the greatest number of ideas in the shortest time with the least ink in the smallest space.
- Graphical excellence is nearly always multivariate.
- And graphical excellence requires telling the truth about the data.
