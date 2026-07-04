# Chapter 2: Graphical Integrity — Examples

### Day Mines disappearing baseline (p. 54)

The 1974 annual report of Day Mines, Inc. showed three bar charts (operating revenues, net income/loss, exploration expenditures) drawn over photographs of miners. In the net income panel, the company had a *negative* income in 1970, but the bars all start at the bottom of the frame at approximately minus $4,200,000 with no visible baseline. The loss year looks like just another short bar. Lesson: a hidden or shifted baseline lets a company visually erase a bad year — the case of the disappearing baseline.

### Airline commission payments pseudo-decline (p. 54)

A New York Times chart (August 8, 1978) showed commission payments to travel agents by four airlines (Delta, Eastern, TWA, United). The final bar for each airline covered only the first six months of 1978, plotted next to full-year totals for 1976 and 1977, making payments appear to fall. Fine print and hatching do mark the last bar as "First Half '78," but the eye compares bar heights regardless, so the lie was "repeated four times over," once per airline. Lesson: comparing a partial period against full periods manufactures a fake decline.

### Pittsburgh asylum cost-per-capita buildings (p. 55)

A 1911 Pittsburgh Civic Commission report compared annual cost per capita for care of the insane at five institutions ($147 to $214) by drawing five hospital buildings. The building sizes bear no proportional relationship to the dollar values — the $214 building dwarfs the $147 one far beyond a 1.46:1 ratio. Lesson: "the fact that numbers have a magnitude as well as an order is simply forgotten" — pictures used as ordinal decoration, not quantity.

### Perception experiments and the New Yorker cartoon (pp. 55–56)

Psychophysical experiments ask people to judge lines of varying length and circles of different areas. They find rough power laws: reported perceived area of a circle ≈ (actual area)^x with x = .8 ± .3. People differ, perception changes with experience and context, and (per Asch's conformity studies) even reported line length depends on what others have already said. A 1961 New Yorker cartoon by CEM (a teacher's drawing perceived wildly differently by each child) illustrates that misperception is not special to statistical graphics. Lesson: since you cannot design for every perceiver, seek uniformity in the graphic itself; for about 20 numbers or fewer, a table beats a graphic.

### Fuel economy standards "road" chart and its redesign (pp. 57–59)

The New York Times (August 9, 1978) displayed congressionally mandated automobile fuel economy standards — 18 mpg in 1978 rising to 27.5 mpg in 1985, a 53% increase — as a road receding in perspective, with horizontal lines for each year's standard. The 1978 line is 0.6 inches long; the 1985 line is 5.3 inches, a 783% change. Lie Factor = 783/53 = 14.8. Perspective adds further trouble: the road convention is reversed (future at the viewer's feet) to exaggerate severity; the date labels stay constant size while supposedly receding; and the right-side numbers shrink from both data change and perspective at once, which viewers cannot separate.

Tufte's redesign (p. 58) is a plain line chart of the standards, adding context: the actual mileage achieved by cars on the road (13.7 mpg average in 1978; 19.1 mpg expected for 1985). The honest version reveals what the original hid — the standards require gradual improvement at first, a doubled rate from 1980 to 1983, then flattening. A second redesign (p. 59) wraps the same honest chart in elaborate Egyptian-revival ornament: "many decorations but no lies." Lesson: decoration is permissible; distorting the ink that locates values is not — that is the mark of the Graphical Hack.

### Nobel Prize pseudo-decline (p. 60)

A National Science Foundation chart (Science Indicators, 1974) plotted Nobel Prizes in science won by selected countries, 1901–1974, with seven decade-wide intervals on the horizontal axis followed by a final interval covering only four years (1971–1974). All curves appear to plunge at the right, especially the United States. The corrected chart with full 1971–1980 data shows the U.S. curve turning sharply *upward*. Lesson: an irregular axis interval violates the visual expectation of a uniform scale and concocts a pseudo-decline; show data variation, not design variation.

### OPEC oil prices with shifting scales (p. 61)

A New York Times chart (December 19, 1978) of OPEC oil prices switched from yearly data (1973–1978) to quarterly data (1979) mid-graphic, with a fan of perspective lines joining the two halves. Five different vertical scales operate across the chart (one vertical inch equals $8.00, then $4.73, $4.37, $4.16, $3.92) and two horizontal scales (one inch equals 3.8 years, then 0.57 years). A price of $10 for one year occupies 0.31 square inches at the left and 4.69 square inches at the right — the same quantity drawn 15.1 times larger depending on position. Lesson: this is design variation in its purest form, with simultaneous scale shifts multiplying the distortion. The chart also missed the real news (see Business Week entry below).

### Time magazine oil barrels (pp. 62, 71)

Time (April 9, 1979) showed the price per barrel of Saudi light crude, 1973–1979, as a row of barrels growing in two dimensions. A data increase of 454% is drawn as a 4,280% increase in area: Lie Factor = 9.4. Revisited on p. 71: if one takes the barrel metaphor seriously and reads *volume*, the shown increase is 27,000% against the 454% data change — Lie Factor = 59.4, "which is a record." Lesson: areas, and worse volumes, puff up one-dimensional data uncontrollably.

### Washington Post oil derricks (p. 62)

The Washington Post (March 28, 1979) showed OPEC benchmark prices 1970–1979 as oil derricks of growing size. A 708% data increase is drawn as 6,700%: Lie Factor = 9.5. Both this and the Time chart made a second error: prices in inflated current dollars, so the changing value of the dollar acts as a hidden, shifting vertical scale.

### The honest oil charts: Business Week, Sunday Times, The Economist (p. 63)

Three publications plotted oil prices in inflation-adjusted terms and avoided design variation. The Sunday Times's "The price of crude oil" (London, December 16, 1979) plotted nominal and 'real' price indices (1972 = 100) as two labeled lines. The Economist's "Soft touch" (December 29, 1979) showed nominal price, real price, real price of energy to final users, and the ratio of energy use to GDP. Business Week's "The real price of oil is soaring again..." (April 9, 1979) plotted the crude price adjusted for inflation (1972 dollars) back to 1958. These honest charts reveal what the decorated ones missed: the real price of oil had *declined* in the four years before the 1979–1980 increases. "Busy with decoration, the graphic had missed the news."

### Playfair's chart of the National Debt of Britain (pp. 64–65)

William Playfair published this in 1786 with his polemic against the "ruinous folly" of financing colonial wars through debt: the national debt from the 1688 Revolution to the end of the American war, climbing to about 250 million pounds, with wars and royal accessions labeled along the curve. It is surely the first "skyrocketing government debt" chart, beginning a 200-year tradition. Playfair deliberately made it taller than wide to emphasize rapid growth — fewer than one-tenth of his roughly 90 charts are vertical — and the figures are not inflation-adjusted. But Playfair had the integrity to publish an alternative a few pages later in The Commercial and Political Atlas: the *interest* on the national debt on a broad horizontal scale, noting "This is in real and not in nominal millions," which diminishes the skyrocket effect. Lesson: shape and unit choices are rhetorical; an honest author shows the alternative reading.

### Fiorina's federal spending chart (p. 66)

A chart from Morris Fiorina's Congress: Keystone of the Washington Establishment (1977) shows federal spending in selected domestic areas, 1930s–1970s. It helps its political point along by not deflating for inflation, not adjusting for population growth, and using a shape 2.7 times taller than wide. Lesson: even modern scholars repeat the skyrocketing-spending tricks Playfair already knew to correct in 1786.

### New York State budget: the Graph of the Magical Parallelepipeds (pp. 66–68)

A New York Times chart (February 1, 1976) showed New York State total budget expenditures and aid to localities, fiscal 1966–1976, as three-dimensional bars ($4.0 billion rising to $10.8 billion). Tufte dissects its mutually reinforcing gimmicks: the three most recent bars sit on an optical plane *in front* of the other eight, towering over them; a stretched cluster of type and horizontal arrows emphasize the low 1966–67 starting value; a squeezed-down block of type suggests small, squeezed budgets in the old days; vertical arrows under the newest bars emphasize recent growth. Stripping the chartjunk yields a calmer view, but two statistical lapses remain: the state's population grew by 1.7 million (10%), and inflation meant $1.00 of government purchases in 1967 cost $2.03 in 1977. Replotting expenditures in constant dollars per capita shows the budget rose about 20% from 1967 to 1970, stayed roughly constant through 1976 (within a 5% band), and *declined* in 1977 — "the real news story of these data," completely missed by the original. "Of course no small set of numbers is going to capture the complexities of a large budget — but, at any rate, why tell lies?"

### French auto exports as sized figures (p. 69)

From R. Satet, Les Graphiques (Paris, 1932): growth of French automobile exports 1927–1929 to Indochina, Morocco, Tunisia, and Algeria, shown as human figures in national dress whose heights (and therefore areas) grow with the numbers. Lesson: using two-dimensional figures for one-dimensional data confuses data variation with design variation.

### The incredible Shrinking Family Doctor (p. 69)

The Los Angeles Times (August 5, 1979) showed the percentage of California doctors devoted solely to family practice — 27% in 1964, 16.0% in 1975, a projected 12.0% in 1990 — as three doctor figures of shrinking size. The Lie Factor is 2.8 from area alone, before counting extra exaggeration from overlaid perspective and the incorrect horizontal spacing of the dates (1964, 1975, 1990 evenly spaced).

### The shrinking dollar fallacy (p. 70)

The Washington Post (October 25, 1978) ran "Purchasing Power of the Diminishing Dollar": dollar bills shrinking in both dimensions from Eisenhower 1958 ($1.00) through Kennedy, Johnson, Nixon, to Carter 1978 (44 cents). The value of money is one-dimensional, but the bills shrink in two dimensions, so area falls as the square. If area honestly reflected purchasing power, the 1978 dollar should be about twice as big as shown. Tufte calls this "one of hundreds of such charts" — the archetypal area-for-line error.

### Oil derrick models in three dimensions (p. 71)

A New York Times photo (January 27, 1981) shows a man pointing at physical model oil derricks labeled 1,257 (1980) and 1,686 (1981) — a three-dimensional representation puffing up one-dimensional data. This prompts the dimensional principle: information-carrying dimensions depicted should not exceed the dimensions in the data.

### Gabaglio's Italian postal savings spiral (p. 72)

From Antonio Gabaglio, Teoria Generale della Statistica (Milan, 2nd ed., 1888): a circular, multivariate display of Italian postal savings banks, 1876–1881, with months around the circle and one red rectangle per month spiraling outward by year. The two dimensions of each rectangle carry real data — the number of savings books issued and the average deposit size — which multiply up to total deposits (the rectangle's area). Lesson: a rare, nearly correct use of two-dimensional marks, because the data themselves are two-dimensional.

### Playfair's circles of city populations (p. 73)

Playfair's early chart of the cities of Europe represents each city's population (one-dimensional data) by the area of a circle, London's 1.1 million largest. Lesson: even a pioneer violated the dimensional principle; areal measures for one-dimensional data are inconsistent with it.

### The 4,340-pound chicken (p. 73)

From the Scientific American Reference Book (New York, 1909): a fantastical still-life of giant foodstuffs — including a 4,340-pound chicken, a colossal wine bottle, 33 tons of ice, and an ocean liner — drawn at scale beside tiny human figures. Tufte allows that "graphics that border on cartoons should be exempt from the principle," since no one reads them as measured quantity.

### Connecticut traffic deaths and the speeding crackdown (pp. 74–75)

A two-point chart shows Connecticut traffic deaths before (1955, ~324) and after (1956, ~284) stricter police enforcement against speeding — a dramatic plunge implying the crackdown worked. Adding the full 1951–1959 series shows 1955 was an unusual peak, so part of the drop is regression toward normal levels. Tufte then sketches three hypothetical surrounding time-paths (oscillating, one-year spike, permanent step down) that would each give the same two points entirely different meanings. Finally, plotting traffic deaths per 100,000 persons for Connecticut alongside New York, Massachusetts, and Rhode Island reveals that other states also saw declines in 1956 — the effect was not unique to the crackdown state. (Data from Campbell and Ross's quasi-experimental analysis.) Lesson: this is the chapter's demonstration that "graphics must not quote data out of context" and must answer "Compared to what?"

### The Pravda industrial production chart (p. 76)

Pravda (May 24, 1982) charted Soviet industrial production growth with circled index numbers (1922 = 1, 1940 = 24, 1970 = 279, 1981 = 514, 1982 plan = 537) riding an upward arrow over factory art, with the circle sizes bearing no relation to the values. Tufte names this "the Pravda School of Ordinal Graphics": every chart has a crystal clear direction coupled with fantasy magnitudes. It embodies the failed defense that getting the direction right excuses lying about magnitude.

### Other examples mentioned

- John Tukey's work (late 1960s) cited as the turning point that made statistical graphics instruments for reasoning rather than decoration (p. 53).
- The New Yorker classroom cartoon by CEM, 1961, on variable perception (p. 56) — described above with the perception experiments.
- General observation that a lying New York Times chart "lies 900,000 times over" and a TV chart tens of millions of times, about budgets, medical care, prices, and fuel standards (p. 76).
