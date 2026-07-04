# Chapter 7: Multifunctioning Graphical Elements

The same ink should often serve more than one graphical purpose. A graphical element can carry data information while also performing a design function usually left to non-data-ink, or it can show several different pieces of data at once. Such *multifunctioning graphical elements*, designed with care and subtlety, can effectively display complex, multivariate data — but they risk becoming graphical puzzles, so the designer must also build in methods that organize and order the flow of information to the eye (p. 139, 154).

## The Core Principle (p. 139)

> "Mobilize every graphical element, perhaps several times over, to show the data."

- A well-designed multifunctioning element packs several pieces of information into a small patch of ink **without confounding or mixing them together**. The blot of a blot map is the model: it simultaneously locates the geographic unit on a two-dimensional surface, describes the unit's shape, and indicates the level of a variable by color or shading intensity (p. 139).
- The conventional graphical frame does little (it merely separates grid and data from labels and holds the tick marks), making it a prime candidate for mobilization as a double-functioning element — hence the range-frame, the quartile frame, and the dot-dash-plot from Chapter 6 (p. 139).
- The idea of double-functioning elements comes from architectural criticism (Robert Venturi, *Complexity and Contradiction in Architecture*) (p. 139, footnote).
- **The danger:** multifunctioning elements "tend to generate graphical puzzles, with encodings that can only be broken by their inventor." Techniques for clarity in the face of complexity must be developed alongside multifunctioning elements (p. 139).

## Data-Built Data Measures (pp. 139–144)

**Definition:** the *data measure* is the graphical element that actually locates or plots the data — the bars of a bar chart, the dots of a scatterplot, the dots and dashes of a dot-dash-plot, the blots of a blot map (p. 139).

Actionable principles:

- **Let the ink of the data measure itself carry data.** For example, the dots of a scatterplot can take on different shadings in response to a third variable (p. 139).
- **Build data measures out of the data itself.** This increases the quantitative detail and dimensionality of a graphic. The stem-and-leaf plot constructs a distribution out of the digits themselves (p. 140). Tukey's rationale, quoted by Tufte:

  > "If we are going to make a mark, it may as well be a meaningful one. The simplest — and most useful — meaningful mark is a digit."

- **Numbers, names, and even physical objects can be data measures.** Ayres' WWI chart builds each column from division numbers, making one mark triple-function: count per month, identity of each division, and duration of each division's stay (p. 141). Living histograms (people sorted by their own heights) and the painted road-stripe chart (the actual stripe pattern as the bar) push this to the limit (pp. 140, 144).
- **Even typography can double-function.** George Herbert's shaped poem "Easter Wings" uses space — the length of each line — to depict quantity, 150 years before Playfair: long lines describe wealth, plenty, and rising to flight, short lines poverty and becoming "most thinne," intermediate lines transition and change. Youden set a statement praising the normal law of error in lines whose lengths form the normal curve itself (p. 143).
- Elaborate encodings such as Chernoff faces can pack many variables into each plotted point; outliers inconsistent with their neighbors ("strangers") should be identified by observation number or name. But Tufte cautions that with cartoon faces and numbers as data measures "we would appear to have reached the limit of graphical economy of presentation, imagination, and, let it be admitted, eccentricity" (p. 142).

## Data-Based Grids (pp. 145–148)

- **Very occasionally the grid can report directly on the data.** When the grid is formed by the locations of measurement instruments, erasing the grid would erase measured data — unlike most grid dots, ticks, and lines, which carry no information (p. 145).
- Data can form an internal grid (Galton's parent/child height table-graphic), and sometimes the grid itself is the element of interest rather than the map or field it sits on (the 1783 Mitchell map comparison) (pp. 145–146).
- A grid can present data on a 3D surface while remaining conventional on the sides, letting slopes in two directions answer two different analytical questions (Converse's election surfaces) (p. 147).
- **Tie the grid to the data:** Playfair spaced the vertical grid lines of his national-debt chart irregularly, keyed to significant events, instead of at regular intervals (p. 148).

  > "The data-based grid is a shrewd graphical device, serving rather than fighting with the data. It is a technique underused in contemporary graphical work."

## Double-Functioning Labels (pp. 149–152)

Data-based coordinate lines lead to *data-based labels*. The question is always the same: why not use the ink to show data?

- **Label with the actual data range, not round numbers.** Progression: conventional fully-framed axis → range-frame (frame line spans only the data range, leaving lonely round-number ticks at the tails) → **range-frame with range-labels**, where the end labels are the actual minimum and maximum realized in the data (e.g., 4 and 37 rather than 0 and 40). "With its greater precision and two tick-marks less of non-data-ink, the range-frame with range-labels is superior to the range-frame with round number labels. Both improve on the standard, passive frame." (p. 149)
- **Make identification numbers double-function by encoding an ordering.** A code number can both name a thing and reflect an order. In the tungsten conductivity chart the study numbers are ordered alphabetically by author and thus fail to double-function; ordered by publication date ("1" = earliest, "61c" = third study published in 1961), the same labels would also reveal time order and let readers see which early studies got the right answer. "This extra information requires no additional ink." (pp. 149–150)
- **Turn coordinate labels into data measures.** In most graphics the coordinate labels sit far from the data, forcing the eye back and forth between data path and margin. Relocate the axis numbers to the data positions themselves: the X-axis increments mark the path of the histogram, and the round-number Y-scale is replaced by exact data values positioned at their heights, so the vertical column of numbers doubles as the dashes of a dot-dash-plot showing the marginal distribution (pp. 150–151).
- **The fully data-labeled scatterplot:** placing the exact values of each observation in the margins eliminates the frame and even the range-frame, replaces the coordinate ticks, shows the marginal distribution of both variables, and records the exact measurements for each observation. "This graphical arrangement performs better for smaller data sets (say 30 observations or less) and when a fine level of detail is required." (p. 152)

## Puzzles and Hierarchy in Graphics (pp. 153–159)

- The complexity of multifunctioning elements can turn data graphics into visual puzzles, "crypto-graphical mysteries for the viewer to decode" (p. 153).
- **Diagnostic rule:** "A sure sign of a puzzle is that the graphic must be interpreted through a verbal rather than a visual process" (p. 153). In a puzzle graphic viewers must repeatedly run little decoding phrases through their minds; in a non-puzzle graphic the visual-to-verbal translation is quickly learned, automatic, and implicit. Paul Valéry: "Seeing is forgetting the name of the thing one sees."
- **Color often generates graphical puzzles.** "The mind's eye does not readily give a visual ordering to colors, except possibly for red to reflect higher levels than other colors." Attempts to impose an order on colors (e.g., Vauthier's mountain-to-the-sea method) force verbal decoders and mnemonic phrases (p. 154).
- **Because they have a natural visual hierarchy, varying shades of gray show varying quantities better than color** (p. 154). Ten gray shades worked effectively in the galaxies map.
- **The key to complexity without puzzlement:** "Central to maintaining clarity in the face of the complex are graphical methods that *organize and order the flow of graphical information* presented to the eye" (p. 154). Multiple layers of information are created by *multiple viewing depths* and *multiple viewing angles*.

### Multiple viewing depths (p. 155)

Graphics can be designed to have at least **three viewing depths**:
1. What is seen from a distance — an overall structure, usually aggregated from an underlying microstructure.
2. What is seen up close and in detail — the fine structure of the data.
3. What is seen implicitly, underlying the graphic — that which is behind the graphic.

The Census Bureau's U.S. population density map exemplifies all three: roughly 400,000 dots on an implicit grid yield national patterns from afar and corridors, landforms, and towns up close.

### Multiple viewing angles (pp. 155, 158–159)

- **Give each aspect of the data its own clear line of sight.** "Each separate line of sight should remain unchanging (preferably horizontal or vertical) as the eye watches for data variation off the flat of the line of sight." For multivariate work, several clear lines can be created (p. 155).
- Ayres' divisions chart shows how: three separate visual angles — the profile of the horizon for the time-series, the vertical for the composition of each bar, the horizontal for each division's stay — make the flow of complex information coherent. "Every drop of ink serves three different data display functions, each of the three comes to the eye with its own independence and integrity" (p. 155).
- A well-designed table-graphic (the government-receipts slopegraph) organizes data for viewing in several directions at once: vertical reading ranks the countries (names spaced in proportion to the values), horizontal reading gives paired comparisons of change, and reading down the collection of slopes reveals the overall pattern and the deviant cases. "The information shown is both integrated and separated: integrated through its connected content, separated in that the eye follows several different and uncluttered paths in looking over the data" (p. 159).
- **Closing prescription:** "Such an analysis of the *viewing architecture* of a graphic will help in creating and evaluating designs that organize complex information hierarchically" (p. 159).
