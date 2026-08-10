# Chapter 2: Graphical Integrity — Detailed Reference

This file is a full reconstruction of Chapter 2 of Edward Tufte, *The Visual Display of Quantitative Information* (2nd ed.), printed pages 53–77. It preserves the chapter's argument structure, every example with its numbers, every quoted principle, every figure (described), and every footnote. Page citations are to the printed book. The chapter sits in Part I, "Graphical Practice" (the running header on left-hand pages), following Chapter 1's catalog of graphical excellence: having shown what the best graphics do, Tufte now turns to how graphics lie and how to stop them.

## Opening: Lies, the Deception-Obsessed Decades, and Tukey's Turn (p. 53)

The chapter has no epigraph; it opens directly on the popular suspicion of charts: "For many people the first word that comes to mind when they think about statistical charts is 'lie'" (p. 53). Tufte concedes the suspicion has a basis — "No doubt some graphics do distort the underlying data, making it hard for the viewer to learn the truth" — but immediately levels the playing field: "data graphics are no different from words in this regard, for any means of communication can be used to deceive. There is no reason to believe that graphics are especially vulnerable to exploitation by liars; in fact, most of us have pretty good graphical lie detectors that help us see right through frauds" (p. 53).

He then gives a short intellectual history of why the field stagnated. Much of twentieth-century thinking about statistical graphics "has been preoccupied with the question of how some amateurish chart might fool a naive viewer," while "other important issues, such as the use of graphics for serious data analysis, were largely ignored" (p. 53). At the core of this preoccupation was "the assumption that data graphics were mainly devices for showing the obvious to the ignorant. It is hard to imagine any doctrine more likely to stifle intellectual progress in a field" (p. 53). That assumption, Tufte argues, "led down two fruitless paths in the graphically barren years from 1930 to 1970":

1. "First, that graphics had to be 'alive,' 'communicatively dynamic,' overdecorated and exaggerated (otherwise all the dullards in the audience would fall asleep in the face of those boring statistics)" (p. 53).
2. "Second, that the main task of graphical analysis was to detect and denounce deception (the dullards could not protect themselves)" (p. 53).

Note the rhetorical structure: both bad paths flow from the same contemptuous premise about the audience ("the dullards"). The first path produces the chartjunk and exaggeration this chapter catalogs; the second produces sterile lie-policing instead of data analysis.

The turn came "in the late 1960s," when "John Tukey made statistical graphics respectable, putting an end to the view that graphics were only for decorating a few numbers. For here was a world-class data analyst spinning off half a dozen new designs and, more importantly, using them effectively to explore complex data. Not a word about deception; no tortured attempts to construct more 'graphical standards' in a hopeless effort to end all distortions. Instead, graphics were used as instruments for reasoning about quantitative information. With this good example, graphical work has come to flourish" (p. 53).

Footnote 1 (p. 53) cites the Tukey work: John W. Tukey and Martin B. Wilk, "Data Analysis and Statistics: Techniques and Approaches," in Edward R. Tufte, ed., *The Quantitative Analysis of Social Problems* (Reading, Mass., 1970), 370–390; and John W. Tukey, "Some Graphic and Semigraphic Displays," in T. A. Bancroft, ed., *Statistical Papers in Honor of George W. Snedecor* (Ames, Iowa, 1972), 293–316.

The opening closes by setting the chapter's task and its most quoted line: "Of course false graphics are still with us. Deception must always be confronted and demolished, even if lie detection is no longer at the forefront of research. Graphical excellence begins with telling the truth about the data" (p. 53). So the chapter is positioned not as a return to the old lie-detection obsession but as the truth-telling foundation beneath the excellence of Chapter 1.

## Three Graphics That Fail to Tell the Truth (pp. 54–55)

Tufte opens the evidence with three quick failures before any theory: "Here are several graphics that fail to tell the truth" (p. 54). Each illustrates a distinct mode of lying — hidden baseline, mismatched periods, and pictures with no quantitative scale at all.

### The disappearing baseline: Day Mines, Inc. (p. 54)

"First, the case of the disappearing baseline in the annual report of a company that would just as soon forget about 1970. A careful look at the middle panel reveals a negative income in 1970, which is disguised by having the bars begin at the bottom at approximately minus $4,200,000" (p. 54).

Figure: three side-by-side bar-chart panels printed over photographs of working miners (the photos fill the bars themselves), each covering 1970–1974, labeled "Operating Revenues," "Net Income (Loss)," and "Exploration & Development Expenditures." A dollar figure is printed above each bar (operating revenues climb to a 1974 bar labeled $7,302,599; the other panels' smaller figures are similarly labeled). Because every bar in the net-income panel rises from the same bottom edge of the photograph — an invisible baseline at roughly −$4,200,000 rather than zero — the 1970 loss reads as just another short positive bar. Source: Day Mines, Inc., *1974 Annual Report*, p. 1.

### The pseudo-decline: airline commission payments (p. 54)

"This pseudo-decline was created by comparing six months' worth of payments in 1978 to a full year's worth in 1976 and 1977, with the lie repeated four times over" (p. 54) — once for each airline shown.

Figure: a three-dimensional stepped bar chart titled "Commission Payments To Travel Agents" (in millions of dollars), with three bars per airline for Delta, Eastern, TWA, and United Airlines (each airline marked by its logo below). The first two bars per airline are full years 1976 and 1977; the third, hatched bar is labeled only in fine print as the first half of 1978. Legible bar labels: Delta $50, $57, $36; Eastern $70, $79, $50; TWA $84 rising to about $107, then $52; United $100, $109, $64. Every airline's series thus appears to crest and fall, when in fact the final bar covers half the time period. Source: *New York Times*, August 8, 1978, p. D-1.

### Magnitude forgotten entirely: the Pittsburgh asylum buildings (p. 55)

"And sometimes the fact that numbers have a magnitude as well as an order is simply forgotten" (p. 55) — a phrase that returns in the chapter's conclusion as the indictment of the "Pravda School of Ordinal Graphics."

Figure: five engraved drawings of hospital buildings under the heading "Comparative Annual Cost per Capita for care of Insane in Pittsburgh City Homes and Pennsylvania State Hospitals," labeled with institution and cost: South Mountain $147, Pittsburgh $172, Harrisburg $198, Norristown $213, Warren $214. The drawings grow from a small cottage to a sprawling multi-wing institution; the largest values ($213, $214) get buildings vastly larger than the $147 building, far beyond the actual 1.46:1 ratio of the extreme values — the picture sizes track rank, not quantity. Source: Pittsburgh Civic Commission, *Report on Expenditures of the Department of Charities* (Pittsburgh, 1911), p. 7.

## What is Distortion in a Data Graphic? (pp. 55–56)

Having shown lies, Tufte now asks what a lie even is. The section heading is a genuine question, and the answer is built dialectically. The definition: "A graphic does not distort if the visual representation of the data is consistent with the numerical representation" (p. 55). But this immediately raises a problem: "What then is the 'visual representation' of the data? As physically measured on the surface of the graphic? Or the *perceived* visual effect? How do we know that the visual image represents the underlying numbers?" (p. 55).

One way to answer is psychophysics: "to conduct experiments on the visual perception of graphics — having people look at lines of varying length, circles of different areas, and then recording their assessments of the numerical quantities" (p. 55). A small cartoon illustrates the setup: a stick-figure experimental subject peers along a dotted sight-line at a panel holding two white rectangles A and B, saying "I think I see that area B is 3.14 times bigger than area A. Is that correct?" (p. 55).

The experimental results are disappointing: "Such experiments have discovered very approximate power laws relating the numerical measure to the reported perceived measure. For example, the perceived area of a circle probably grows somewhat more slowly than the actual (physical, measured) area: the reported perceived area = (actual area)^x, where x = .8 ± .3, a discouraging result" (p. 55). The discouragement is in the error band: an exponent anywhere from 0.5 to 1.1 means there is no stable correction to design for. Worse, "Different people see the same areas somewhat differently; perceptions change with experience; and perceptions are context-dependent" (pp. 55–56). And: "Particularly disheartening is the securely established finding that the reported perception of something as clear and simple as line length depends on the context and what other people have already said about the lines" (p. 56) — Asch's conformity experiments.

Footnote 2 (p. 56): "The extensive literature is summarized in Michael Macdonald-Ross, 'How Numbers Are Shown: A Review of Research on the Presentation of Quantitative Data in Texts,' *Audio-Visual Communication Review*, 25 (1977), 359–409. In particular, H. J. Meihoefer finds great variability among perceivers; see 'The Utility of the Circle as an Effective Cartographic Symbol,' *Canadian Cartographer*, 6 (1969), 105–117; and 'The Visual Perception of the Circle in Thematic Maps: Experimental Results,' ibid., 10 (1973), 63–84."

Footnote 3 (p. 56): S. E. Asch, "Studies of Independence and Submission to Group Pressure. A Minority of One Against a Unanimous Majority," *Psychological Monographs* (1956), 70.

Tufte then generalizes with humor: "Misperception and miscommunication are certainly not special to statistical graphics" (p. 56), illustrated by a 1961 *New Yorker* cartoon by CEM (credited in the margin: "Drawing by CEM; copyright 1961, *The New Yorker*"): a teacher in a classroom holds up her drawing of a flower while every seated child's thought bubble shows something entirely different — a sailboat, fish, butterflies, a rocking horse, insects, and so on. One drawing, two dozen perceptions.

The dilemma, stated as rhetorical questions: "but what is a poor designer to do? A different graphic for each perceiver in each context? Or designs that correct for the visual transformations of the average perceiver participating in the average psychological experiment?" (p. 56).

Two practical answers follow:

1. **Use a table for small data sets.** "One satisfactory answer to these questions is to use a table to show the numbers. Tables usually outperform graphics in reporting on small data sets of 20 numbers or less. The special power of graphics comes in the display of large data sets" (p. 56).
2. **Standardize the graphic, since you cannot standardize the perceiver.** "At any rate, given the perceptual difficulties, the best we can hope for is some uniformity in graphics (if not in the perceivers) and some assurance that perceivers have a fair chance of getting the numbers right" (p. 56).

## The First Two Principles (p. 56)

"Two principles lead toward these goals and, in consequence, enhance graphical integrity" (p. 56). Both are set off as indented display text:

> "The representation of numbers, as physically measured on the surface of the graphic itself, should be directly proportional to the numerical quantities represented."

> "Clear, detailed, and thorough labeling should be used to defeat graphical distortion and ambiguity. Write out explanations of the data on the graphic itself. Label important events in the data."

Note how the first principle resolves the earlier definitional puzzle: since perceived measure cannot be pinned down, integrity is defined on the *physical* surface of the graphic. Proportionality is to be measured with a ruler, not a psychophysics lab.

## The Lie Factor (p. 57)

"Violations of the first principle constitute one form of graphic misrepresentation, measured by the

> Lie Factor = (size of effect shown in graphic) / (size of effect in data)" (p. 57).

(In the book this is typeset as a fraction: "size of effect shown in graphic" over "size of effect in data.") Interpretation, in Tufte's words: "If the Lie Factor is equal to one, then the graphic might be doing a reasonable job of accurately representing the underlying numbers. Lie Factors greater than 1.05 or less than .95 indicate substantial distortion, far beyond minor inaccuracies in plotting" (p. 57). Note the hedge "might be" — a Lie Factor of one is necessary, not sufficient, for honesty (later sections show charts that lie by omission or context while plotting accurately).

Two refinements: "The logarithm of the Lie Factor can be taken in order to compare overstating (log LF > 0) with understating (log LF < 0) errors. In practice almost all distortions involve overstating, and Lie Factors of two to five are not uncommon" (p. 57). The chapter itself documents Lie Factors of 2.8, 9.4, 9.5, 14.8, and 59.4. Size of effect is computed throughout as a percentage change: (second value − first value) / first value × 100.

## The Fuel Economy "Road" Chart: Lie Factor 14.8 (pp. 57–58)

"Here is an extreme example" (p. 57). The data: "A newspaper reported that the U.S. Congress and the Department of Transportation had set a series of fuel economy standards to be met by automobile manufacturers, beginning with 18 miles per gallon in 1978 and moving in steps up to 27.5 by 1985, an increase of 53 percent:

(27.5 − 18.0) / 18.0 × 100 = 53%" (p. 57).

Figure (p. 57): the *New York Times* graphic "Fuel Economy Standards for Autos. Set by Congress and supplemented by the Transportation Department. In miles per gallon." It draws a two-lane road in exaggerated perspective receding away from the viewer, striped with a dashed center line. Horizontal lines across the road mark each year's standard; year labels 1978, '79, '80, '81, '82, '83, '84, '85 run down the left edge while the values 18, 19, 20, 22, 24, 26, 27, 27½ run along the right edge, growing in type size toward the bottom. Tufte adds two measurement callouts to the reproduction: "This line, representing 18 miles per gallon in 1978, is 0.6 inches long" (pointing to the line at the road's vanishing point) and "This line, representing 27.5 miles per gallon in 1985, is 5.3 inches long" (pointing to the nearest, widest line). Source: *New York Times*, August 9, 1978, p. D-2.

The arithmetic of the lie (p. 58): "The magnitude of the change from 1978 to 1985 is shown in the graph by the relative lengths of the two lines:

(5.3 − 0.6) / 0.6 × 100 = 783%

Thus the numerical change of 53 percent is presented by some lines that changed 783 percent, yielding

Lie Factor = 783 / 53 = 14.8

which is too big" (p. 58).

Beyond the Lie Factor, "The display also has several peculiarities of perspective" (p. 58), given as three bullets:

- "On most roads the future is in front of us, toward the horizon, and the present is at our feet. This display reverses the convention so as to exaggerate the severity of the mileage standards" (p. 58). (The big 27½ looms at the viewer's feet; the small 18 recedes to the horizon.)
- "Oddly enough, the dates on the left remain a constant size on the page even as they move along with the road toward the horizon" (p. 58) — the perspective is applied selectively, only where it inflates the data.
- "The numbers on the right, as well as the width of the road itself, are shrinking because of two simultaneous effects: the change in the values portrayed and the change due to perspective. Viewers have no chance of separating the two" (p. 58).

That last sentence is the chapter's core perceptual argument against perspective on data: it confounds two sources of visual change, and the viewer cannot decompose them. This anticipates the design-variation/data-variation distinction formalized on p. 61.

## The Honest Redesign, and Decoration Without Lies (pp. 58–59)

"It is easy enough to decorate these data without lying" (p. 58). Tufte's redesign (p. 58) is a plain framed line chart titled "REQUIRED FUEL ECONOMY STANDARDS: NEW CARS BUILT FROM 1978 TO 1985": dots at 18, 19, 20, 22, 24, 26, 27, 27.5 over an x-axis of 1978–1985, each value labeled. Crucially it adds two context points plotted and annotated on the same field: "13.7 mpg, average for all cars on road, 1978" and "19.1 mpg, expected average for all cars on road, 1985."

The redesign does three jobs (p. 59): "The non-lying version, in addition, puts the data in a context by comparing the new car standards with the mileage *achieved* by the mix of cars *actually on* the road. Also revealed is a side of the data disguised and misrepresented in the original display: the fuel economy standards require gradual improvement at start-up, followed by a doubled rate from 1980 to 1983, and flattening out after that" (p. 59). The honest chart is not merely not-lying; it surfaces the policy's actual structure (slow start, accelerating middle, flat finish), which the perspective road completely obscured.

Then the chapter's key concession and its limit: "Sometimes decoration can help editorialize about the substance of the graphic. But it is wrong to distort the data measures — the ink locating values of numbers — in order to make an editorial comment or fit a decorative scheme. It is also a sure sign of the Graphical Hack at work. Here are many decorations but no lies" (p. 59).

Figure (p. 59): the identical honest fuel-economy chart re-set inside an elaborate Egyptian-revival ornamental frame — a spread-winged eagle/phoenix perched atop a classical entablature, flanking columns crowned with palmette finials, rosettes, decorative side panels, and at the base three pharaonic heads sprouting lotus-and-candelabra ornament. The decoration is outrageous, but every data measure inside the frame remains exactly proportional. The point: the sin is never ornament per se; it is ornament that bends "the ink locating values of numbers."

## Design and Data Variation (p. 60)

This section supplies the chapter's central theoretical idea. "Each part of a graphic generates visual expectations about its other parts and, in the economy of graphical perception, these expectations often determine what the eye sees. Deception results from the incorrect extrapolation of visual expectations generated at one place on the graphic to other places" (p. 60). The phrase "economy of graphical perception" carries the claim: viewers do not re-derive the scale at every point; they read part of the graphic and extrapolate.

### The Nobel Prize pseudo-decline (p. 60)

"A scale moving in regular intervals, for example, is expected to continue its march to the very end in a consistent fashion, without the muddling or trickery of non-uniform changes. Here an irregular scale is used to concoct a pseudo-decline. The first seven increments on the horizontal scale are ten years long, masking the rightmost interval of four years. Consequently the conspicuous feature of the graphic is the apparent fall of curves at the right, particularly the decline in prizes won by people from the United States (the heavy, dark line) in the most recent period. This effect results solely from design variation. It is a big lie, since in reality (and even in extrapolation, scaling up each end-point by 2.5 to take the four years' worth of data up to a comparable decade), the U.S. curve turned sharply upward in the post-1970 interval. A correction, with the actual data for 1971–80, is at the right" (p. 60).

Figures (p. 60), side by side: left, the original "Nobel Prizes Awarded in Science, for Selected Countries, 1901–1974" — y-axis "(Number of Prizes)" 0 to 30, x-axis intervals 1901–1910, 1911–1920, … 1961–1970, then 1971–1974; lines for the United States (heavy solid, climbing steeply from the 1930s to a peak near 30 in 1961–1970 then plunging to roughly half that in the truncated final interval), United Kingdom (dotted, also appearing to fall), Germany, U.S.S.R. (dashed), and France. Right, Tufte's correction, "Nobel Prizes Awarded in Science, for Selected Countries, 1901–1980," identical except the final interval is a true decade 1971–1980 — and the U.S. line now shoots upward past the top of the 0–30 frame, marked with a curly brace where it exits the plot. Source of the original: National Science Foundation, *Science Indicators, 1974* (Washington, D.C., 1976), p. 15. (Note the irony Tufte lets speak for itself: the National Science Foundation, of all agencies, manufactured a decline in American science.)

## The Principle: Show Data Variation, Not Design Variation (p. 61)

"The confounding of *design variation* with *data variation* over the surface of a graphic leads to ambiguity and deception, for the eye may mix up changes in the design with changes in the data. A steady canvas makes for a clearer picture. The principle is, then:

> Show data variation, not design variation." (p. 61)

These are the chapter's terms of art: **data variation** is change in the marks driven by change in the numbers; **design variation** is change in the marks driven by the design itself (shifting scales, perspective, changing units). A graphic with design variation makes the same number look different in different places.

### The OPEC oil-price chart: five vertical scales, two horizontal scales (p. 61)

"Design variation corrupts this display" (p. 61).

Figure: a *New York Times* chart, "OPEC Oil Prices: After 18 Months of Stability, Prices Are Due to Rise Again," in dollars per barrel. The left portion shows yearly stepped bars for '73–'78 (labeled "Yearly") against a left-hand axis marked $0–$12; then a fan of shaded perspective lines splays out to a much larger right portion showing the four quarters of 1979 (labeled "Quarterly"): Jan. 1, 5% increase → $13.34; April 1, 3.809% increase → $13.84; July 1, 2.294% increase → $14.16; Oct. 1, 2.691% increase → $14.54. Source: *New York Times*, December 19, 1978, p. D-7.

Tufte measures the chart's internal scales and presents two small tables (p. 61), reproduced in full:

"Five different vertical scales show the price:"

| During this time | one vertical inch equals |
|---|---|
| 1973–1978 | $8.00 |
| January–March 1979 | $4.73 |
| April–June 1979 | $4.37 |
| July–September 1979 | $4.16 |
| October–December 1979 | $3.92 |

"And two different horizontal scales show the passage of time:"

| During this time | one horizontal inch equals |
|---|---|
| 1973–1978 | 3.8 years |
| 1979 | 0.57 years |

The multiplicative consequence: "As the two scales shift simultaneously, the distortion takes on multiplicative force. On the left of the graph, a price of $10 for one year is represented by 0.31 square inches; on the right side, by 4.69 square inches. Thus exactly the same quantity is 4.69/0.31 = 15.1 times larger depending upon where it happens to fall on the surface of the graphic. *That* is design variation" (p. 61). The italicized "That" makes this the canonical demonstration of the concept: identical data, fifteenfold difference in ink, purely from position on the canvas.

## Oil Barrels and Derricks: Lie Factors of 9.4 and 9.5 (p. 62)

"Design variation infected similar graphics in other publications. Here an increase of 454 percent is depicted as an increase of 4,280 percent, for a Lie Factor of 9.4" (p. 62).

Figure: *Time* magazine's "IN THE BARREL… Price per bbl. of light crude, leaving Saudi Arabia on Jan. 1" — a row of drawn oil barrels growing in both width and height from 1973 to 1979, each tagged with an arrow-shaped price label (legible labels run $2.41 … $11.51, $12.09, $12.70, $13.34, ending in a boxed "April 1 $14.55" beside the hugely enlarged, darkened 1979 barrel). Because the barrels grow in two dimensions while price is one-dimensional, the drawn area grows as roughly the square of the data. Source: *Time*, April 9, 1979, p. 57. (This graphic returns on p. 71, where its volume reading yields the record Lie Factor of 59.4.)

"And an increase of 708 percent is shown as 6,700 percent, for a Lie Factor of 9.5" (p. 62).

Figure: the *Washington Post*'s "OPEC Benchmark Prices 1970–1979" — a row of eleven drawn oil derricks growing in two dimensions against a left axis marked in dollars per barrel (0–14), with price labels: $1.80 (Jan. 1, 1970), $2.18 (1971), $2.48 (1972), $2.59 (1973), then $10.95 (Jan. 1974, annotated "(March 1974—end of embargo)"), $10.46 (Jan. 1975), $11.51 (Jan. 1976), $12.09 (Jan. 1977), $12.70 (July 1977/78, annotated "prices frozen"), $13.34 (Jan. 1979), $14.54 (April 1, 1979). An annotation also marks the October 1973 start of the embargo tied to the Middle East war. A block of explanatory text about how OPEC "benchmark" prices are set runs across the top. The 708% data increase is from $1.80 to $14.54. Source: *Washington Post*, March 28, 1979, p. A-18. (Note the derricks chart has an honest arithmetic axis at the left — and the towers ignore it, growing areally.)

## The Inflation Error and the Honest Oil Charts (pp. 62–63)

A second, independent error infects all these oil charts: "All these accounts of oil prices made a second error, by showing the price of oil in inflated (current) dollars. The 1972 dollar was worth much more than the 1979 dollar. Thus in sweeping from left to right over the surface of the graphic, the vertical scale in effect changes — design variation — because the value of money changes over the years shown" (pp. 62–63). This is a conceptual extension of design variation: plotting nominal money makes the *unit* of the vertical axis silently shrink across the chart, even when the drawn scale is fixed. "The only way to think clearly about money over time is to make comparisons using inflation-adjusted units of money" (p. 63).

"Several distinguished graphic designers did express the price in real dollars — and they also avoided other sources of design variation. The stars were *Business Week*, the *Sunday Times* (London), and *The Economist*" (p. 63). Three honest charts are reproduced (p. 63):

- *Sunday Times* (London), December 16, 1979, p. 54: "The price of crude oil," an index chart (1972 = 100) with a vertical scale from 100 to 700, plotting two labeled lines, NOMINAL and 'REAL', from 1972 to 1979, decorated harmlessly with a silhouetted offshore oil rig at the right. The nominal line climbs to roughly 700 while the real line climbs far less, flattening and dipping mid-decade before the 1979 rise.
- *The Economist*, December 29, 1979, p. 41: "Soft touch," OECD area, 1972 = 100, right-hand scale 50–500, plotting four series 1972–78: "Nominal price of imported oil," "Real price of imported oil," "Real price of energy to final users," and "Ratio of energy use to gdp." The nominal line soars toward 450–500; the real price line sits far lower; the real price of energy to final users barely moves above 100; the energy/GDP ratio runs flat near the bottom.
- *Business Week*, April 9, 1979, p. 99: "The real price of oil is soaring again…," plotting the crude oil price adjusted for inflation (dollars per barrel in 1972 dollars) from 1958 to 1979 (estimated). It shows the real price *declining* gently through the 1960s to a low around 1972–73, the embargo spike of 1974, then a slow real decline through 1978 before turning up again in 1979.

The payoff of honesty is a finding: "In the graphic we saw first, the two sources of design variation covered up an intriguing, non-obvious aspect of the data: in the four years prior to the 1979–1980 increases, the real price of oil had *declined*. Busy with decoration, the graphic had missed the news" (p. 63). A small reproduction of the offending *New York Times* OPEC chart sits beneath this sentence for contrast. This is the chapter's recurring twist: distortion is not only unethical, it is journalistically incompetent — the dishonest charts literally missed the story.

## The Case of Skyrocketing Government Spending (pp. 64–66)

Page 64 is given over entirely to a full-page color reproduction of William Playfair's 1786 "CHART of the National Debt of BRITAIN from the Revolution to the End of the War with AMERICA" (from *The Commercial and Political Atlas*). Description: a tall vertical chart, title in an engraved oval cartouche, with years along the bottom (1688, 1701, 1714, 1727, 1739, 1748, 1755, 1762, 1775, 1784) and money on the right-hand axis ("Millions," gridded in steps of 10 up to 300). A red curve over a yellow-filled area traces the debt from near zero at the 1688 Revolution to roughly £250 million at the end of the American war. Historical events are lettered diagonally along the curve at the dates they occurred: "Revolution at the Accession of K. William," "Accession of Queen Ann," "Accession of George 1st," "Accession of George 2nd," "Beginning of the Spanish War," "End of the Spanish War," "Beginning of the Continental War," "End of the Continental War," "Beginning of American War," "End of American War." The debt visibly ratchets: it leaps during each war and barely recedes between them, with the steepest climbs in the Continental and American wars. Caption beneath: "The Divisions at the Bottom are Years, & those on the Right hand Money." (This chart exemplifies the second integrity principle — important events labeled directly on the data.)

The section text (p. 65) opens: "Probably the most frequently printed graphic, other than the daily weather map and stock-market trend line, is the display of government spending and debt over the years. These arrays nearly always create the impression that spending and debt are rapidly increasing" (p. 65).

"As usual, Playfair was the first, publishing this finely designed graphic in 1786. Accompanied by his polemic against the 'ruinous folly' of the British government policy of financing its colonial wars through debt, it is surely the first skyrocketing government debt chart, beginning the now 200-year history of such displays" (p. 65). Then the aspect-ratio observation: "This is one of the few Playfairs that is taller than wide; less than one-tenth of all his graphics (about 90, drawn during 35 years of work) are longer on the vertical. The tall shape here serves to emphasize the picture of rapid growth. The money figures are not adjusted for inflation" (p. 65). The implication: Playfair understood shape as rhetoric and reserved the vertical format for the rare case where he *wanted* the skyrocket effect — the chart is a polemic and is shaped like one.

"But Playfair had the integrity to show an alternative version a few pages later in *The Commercial and Political Atlas*. The interest on the national debt was plotted on a broad horizontal scale, diminishing the skyrocket effect. And, furthermore, 'This is in real and not in nominal millions' (page 129)" (p. 65). Three honest moves in one alternative: a different, less alarming variable (interest rather than principal), a wide flat shape, and inflation-adjusted units — in 1786.

Figure (p. 65): "Interest of the NATIONAL DEBT from the Revolution" — a wide horizontal chart, years 1688–1784 along the bottom, right-hand axis marked 1 through 20 (millions of pounds), the same war and accession events lettered vertically at their dates, a low red curve over yellow fill rising gently to roughly £9–10 million by 1784, with "INTEREST OF NATIONAL DEBT" lettered across the filled area. Caption: "The Bottom line is Years, those on the Right hand Millions of Pounds."

### Modern scholars do worse: the Fiorina chart (p. 66)

"Although Playfair deflated money units over time in his work of 1786, the matter has proved difficult for many, eluding even modern scholars. This display helps its political point along by failing to discount for inflation and population growth and by using a tall and thin shape (the area covered by the data is 2.7 times taller than wide)" (p. 66).

Figure: "Figure A3. The Growth of Government: Federal Spending in Selected Domestic Areas," y-axis "Billions of Dollars" up to $80, x-axis roughly 1930–1970, plotting five labeled lines: Defense (spiking to about $80 billion in the mid-1940s, collapsing after the war, then climbing back toward $80 by 1970), Income Security (dashed, rising steeply to about $45 billion), and low lines for Health, Veterans, and Education. Source: Morris Fiorina, *Congress: Keystone of the Washington Establishment* (New Haven, 1977), p. 92. The aside "eluding even modern scholars" sharpens the Playfair comparison: a 1977 Yale political scientist commits errors a 1786 pamphleteer knew to correct.

## The New York State Budget: The Graph of the Magical Parallelepipeds (pp. 66–68)

"Let us look, in detail, at another graphic on government spending" (p. 66). This is the chapter's longest single dissection, proceeding in four stages: the chart, its visual gimmicks, its statistical lapses, and the corrected picture.

Figure (p. 66): a *New York Times* chart, "New York State Total Budget Expenditures and Aid to Localities. In billions of dollars. Fiscal 1966–1976." Eleven three-dimensional parallelepiped bars for fiscal years 1966–'67 through '76–'77, each split into a shaded lower portion ("Total Aid to Localities*") and a white upper remainder ("Total Budget"), with totals printed above: $4.0, $4.6, $5.5, $6.2, $6.7, $7.4, $7.8, $8.5, $9.7, $10.7, $10.8. The last two bars are flagged "Estimated" and "Recommended" with small upward arrows. A footnote on the chart reads: "*Varying from a low of 56.7 percent of the total in 1970-71 to a high of 60.7 percent in 1972-73." Source: *New York Times*, February 1, 1976, p. IV-6.

The verdict first, then the dissection: "Despite the appearance created by the hyperactive design, the state budget actually did not increase during the last nine years shown. To generate the thoroughly false impression of a substantial and continuous increase in spending, the chart deploys several visual and statistical tricks — all working in the same direction, to exaggerate the growth in the budget" (p. 67). The phrase "all working in the same direction" carries an implicit statistical argument: random sloppiness would scatter; coordinated bias points.

### The graphical gimmicks (p. 67)

Page 67 reprints the chart with four annotation callouts, quoted here in full:

- "These three parallelepipeds have been placed on an optical plane *in front* of the other eight, creating the image that the newer budgets tower over the older ones" (p. 67).
- "This cluster of type emphasizes and stretches out the low value for 1966–1967, encouraging the impression that recent years have shot up from a small, stable base. Horizontal arrows provide similar emphasis" (p. 67) — referring to the stacked labels "Total Budget →" and "Total Aid to Localities* →" parked beside the first, smallest bar.
- "This squeezed-down block of type contributes to an image of small, squeezed-down budgets back in the good old days" (p. 67) — the cramped footnote text under the early bars.
- "Arrows pointing straight up emphasize recent growth. Compare with horizontal arrows at left" (p. 67) — the "Estimated"/"Recommended" arrows under the two newest bars.

"Leaving behind the distortion in the chartjunk heap at the left yields a calmer view" (p. 67). Figure: two redrawings side by side — at left, the discarded "chartjunk heap" (the skeletal 3-D outlines, arrows, and type-block markers of the original, shown as the junk being left behind); at right, the calm version: plain two-dimensional bars, shaded lower segment and white upper segment, evenly spaced on a single plane. (Note the early use of the word "chartjunk," fully developed in Chapter 4.)

### The statistical lapses (p. 68)

"Two statistical lapses also bias the chart. First, during the years shown, the state's population increased by 1.7 million people, or 10 percent. Part of the budget growth simply paralleled population growth. Second, the period was a time of substantial inflation; those goods and services that cost state and local governments $1.00 to purchase in 1967 cost $2.03 in 1977. By not deflating, the graphic mixes up changes in the value of money with changes in the budget" (p. 68). (Note the deflator is specific to what state and local governments buy, not general consumer inflation.)

### The corrected picture (p. 68)

"Application of arithmetic makes it possible to take population and inflation into account. Computing expenditures in *constant (real) dollars per capita* reveals a quite different — and far more accurate — picture" (p. 68).

Figure: "Per capita budget expenditures, in constant dollars" — a minimalist dot-and-line chart, y-axis labeled $300 to $400 in $20 steps, x-axis 1967 to 1977. The line rises from about $310 in 1967 to about $385 by 1970, then oscillates inside a narrow band through 1976; two dotted horizontal lines bracket that band, with a bracket at the right margin labeled "5%." The final 1977 point drops visibly below the band. (A small reproduction of the original parallelepiped chart sits in the margin of p. 68 for contrast.)

The reading: "Thus, in terms of real spending per capita, the state budget increased by about 20 percent from 1967 to 1970 and remained relatively constant from 1970 through 1976. And the 1977 budget represents a substantial *decline* in expenditures. That is the real news story of these data, and it was completely missed by the Graph of the Magical Parallelepipeds. Of course no small set of numbers is going to capture the complexities of a large budget — but, at any rate, why tell lies?" (p. 68). Again the double indictment: the lying chart was also a failure of journalism — the actual story (flat, then declining, real budgets) was the opposite of the visual story.

The section closes with the chapter's fourth principle, set as display text: "The principle:

> In time-series displays of money, deflated and standardized units of monetary measurement are nearly always better than nominal units." (p. 68)

## Visual Area and Numerical Measure (pp. 69–71)

"Another way to confuse data variation with design variation is to use areas to show one-dimensional data" (p. 69). The section runs through area-for-line abuses in escalating order: scaled human figures, the shrinking doctor, the shrinking dollar, and finally three-dimensional volumes.

### French auto exports as costumed figures (p. 69)

Figure: "Accroissement de nos exportations d'autos 1927–1929" ("Growth of our automobile exports") — four groups of three human figures in stereotyped national dress, one group per destination, each figure's height (and hence area) scaled to the export number printed above it:

| Destination | 1927 | 1928 | 1929 |
|---|---|---|---|
| Indochine | 1.969 | 2.352 | 2.248 |
| Maroc | 1.934 | 2.585 | 2.629 |
| Tunisie | 1.243 | 1.894 | 2.832 |
| Algérie | 6.646 | 8.217 | 11.610 |

(Period French style: the points are thousands separators.) The Algérie figures tower over the rest, their drawn areas exaggerating an already large difference. Source: R. Satet, *Les Graphiques* (Paris, 1932), p. 12.

### The incredible shrinking doctor: Lie Factor 2.8 (p. 69)

"And here is the incredible shrinking doctor, with a Lie Factor of 2.8, not counting the additional exaggeration from the overlaid perspective and the incorrect horizontal spacing of the data" (p. 69).

Figure: "THE SHRINKING FAMILY DOCTOR In California. Percentage of Doctors Devoted Solely to Family Practice" — three drawn doctors shrinking from left to right, headed by the data: 1964: 27%; 1975: 16.0%; 1990: 12.0%. Beneath each doctor, the underlying ratios: "1: 2,247 RATIO TO POPULATION / 8,023 Doctors" (1964); "1: 3,167 / 6,694" (1975); "1: 4,232 / 6,212" (1990). The figures shrink in two dimensions (the height encodes the percentage, so area falls as its square), the smaller doctors are drawn standing behind the large one on a receding ground plane (perspective compounding the shrinkage), and the three dates 1964, 1975, 1990 — intervals of 11 and 15 years — are spaced evenly. Three independent distortions stack. Source: *Los Angeles Times*, August 5, 1979, p. 3.

### The shrinking dollar fallacy (p. 70)

"Many published efforts using areas to show magnitudes make the elementary mistake of varying both dimensions simultaneously in response to changes in one-dimensional data. Typical is the shrinking dollar fallacy. To depict the rate of inflation, graphs show currency shrinking on two dimensions, even though the value of money is one-dimensional. Here is one of hundreds of such charts" (p. 70).

Figure: the *Washington Post*'s "Purchasing Power of the Diminishing Dollar" (Source: Labor Department) — five dollar bills, each shrinking in both width and height, each clutched at the right edge by a disembodied grasping hand, each bearing the portrait of the sitting president and labeled:

| Year | President | Purchasing power |
|---|---|---|
| 1958 | Eisenhower | $1.00 |
| 1963 | Kennedy | 94¢ |
| 1968 | Johnson | 83¢ |
| 1973 | Nixon | 64¢ |
| 1978 | Carter | 44¢ (August) |

Source: *Washington Post*, October 25, 1978, p. 1. The quantitative check: "If the area of the dollar is accurately to reflect its purchasing power, then the 1978 dollar should be about twice as big as that shown" (p. 70). (Drawn with both dimensions scaled by 0.44, the 1978 bill's area is 0.44² ≈ 0.19 of the original, versus the correct 0.44.)

### From areas to volumes: the record Lie Factor of 59.4 (p. 71)

The perceptual argument deepens: "There are considerable ambiguities in how people perceive a two-dimensional surface and then convert that perception into a one-dimensional number. Changes in physical area on the surface of a graphic do not reliably produce appropriately proportional changes in perceived areas. The problem is all the worse when the areas are tricked up into three dimensions" (p. 71). So area encodings fail twice — physically disproportionate by construction, and unreliably perceived even when proportionate.

The *Time* barrels chart (reproduced in the margin of p. 71) is re-scored: "By surface area, the Lie Factor for this graphic is 9.4. But, if one takes the barrel metaphor seriously and assumes that the *volume* of the barrels represents the price change, then the volume from 1973 to 1979 increases 27,000 percent compared to a data increase of 454 percent, for a Lie Factor of 59.4, which is a record" (p. 71).

"Similarly, a three-dimensional representation puffing up one-dimensional data" (p. 71): a news photograph of a man in glasses and a suit pointing up at two physical scale-model oil derricks built for display, the shorter labeled 1,257 (for 1980) and the taller 1,686 (for 1981) — actual constructed volumes encoding a single number each. Source: *New York Times*, January 27, 1981, p. D-1.

## The Dimensional Principle, a Near-Exception, and an Exemption (pp. 71–73)

The section's summary judgment and fifth principle (p. 71): "Conclusion: The use of two (or three) varying dimensions to show one-dimensional data is a weak and inefficient technique, capable of handling only very small data sets, often with error in design and ambiguity in perception. These designs cause so many problems that they should be avoided:

> The number of information-carrying (variable) dimensions depicted should not exceed the number of dimensions in the data." (p. 71)

Note the careful wording "information-carrying (variable) dimensions": a drawn barrel is not banned because it is a 2-D picture, but because both of its dimensions *vary with* a 1-D number.

### Nearly consistent: Gabaglio's Italian postal savings spiral (p. 72)

Page 72 is a full-page color plate: "CASSE POSTALI DI RISPARMIO ITALIANE. Numero dei Libretti, Libretto medio e Deposito totale al fine di ogni mese" (Italian postal savings banks: number of passbooks, average passbook, and total deposits at the end of each month). Description: a large circular display with the twelve months (GENNAIO through DICEMBRE) arrayed around the rim. One red rectangle is drawn per month, the rectangles spiraling outward year by year from 1876 at the center to 1881 at the rim, against concentric guide rings labeled 100,000 / 200,000 / 300,000 / 400,000. Each rectangle's two dimensions carry two real variables — the number of savings books (libretti) issued and the average deposit per book (libretto medio) — so the rectangle's *area* equals total deposits. A key box at the top decodes one sample rectangle: "Credito dei Depositanti L. 53,092,109; Libretti 382,042" with the average-deposit dimension marked. Tufte's text: "This multivariate history of the Italian post office uses two dimensions in a way nearly consistent with this principle, with the number of postal savings books issued and the average size of deposits multiplying up to total deposits at the end of each month from 1876 to 1881" (p. 72). Source: Antonio Gabaglio, *Teoria Generale della Statistica* (Milan, second edition, 1888). The point: two-dimensional marks are legitimate exactly when the data are two-dimensional and the dimensions multiply meaningfully.

### Not consistent: Playfair's circles (p. 73)

"But Playfair's circles, an early use of area to show magnitude, are not consistent with the principle, since the one-dimensional data (city populations) are represented by an areal data measure" (p. 73). Even the field's founder violated the dimensional rule.

Figure: Playfair's "STATISTICAL CHART shewing the Cities of Europe, that are or have been CAPITALS OF EMPIRES, KINGDOMS or REPUBLICS, Represented in the Order of their Population" — two rows of pink circles strung along horizontal baselines, sized by population and ordered largest to smallest: London first ("Inhabitants 1,100,000"), then Constantinople, Paris, Naples, Vienna, Moscow, Amsterdam, Dublin, and Venice across the top row; Petersburgh, Rome, Berlin, Madrid, Palermo, Lisbon, Copenhagen, Warsaw, and smaller capitals (Genoa, Florence, Stockholm, Edinburgh among them) across the bottom row, each circle labeled with its population.

### The cartoon exemption: the 4,340-pound chicken (p. 73)

"Perhaps graphics that border on cartoons should be exempt from the principle. We certainly would not want to forgo the 4,340 pound chicken" (p. 73). The exemption's logic: no viewer reads such images as measured quantity, so they cannot deceive about magnitude.

Figure: a fantastical engraved still-life from the *Scientific American Reference Book* (New York, 1909), p. 280 — colossal foodstuffs (representing aggregate consumption quantities) towering over tiny human figures: a giant fish, an enormous pear among heaped fruit, pyramids of cans and barrels, a vast wine bottle, a block labeled "Ice 33 Tons," a huge milk container, the famous 4,340-pound chicken, with an ocean liner steaming past in the background for scale.

## Context is Essential for Graphical Integrity (pp. 74–75)

The final integrity failure is not distortion of plotted numbers but omission of the numbers needed to judge them. "To be truthful and revealing, data graphics must bear on the question at the heart of quantitative thinking: 'Compared to what?' The emaciated, data-thin design should always provoke suspicion, for graphics often lie by omission, leaving out data sufficient for comparisons. The principle:

> Graphics must not quote data out of context." (p. 74)

The demonstration is a four-step crescendo built on one dataset — Connecticut traffic deaths around the 1955 police crackdown on speeding (data from Donald T. Campbell and H. Laurence Ross, "The Connecticut Crackdown on Speeding: Time Series Data in Quasi-Experimental Analysis," in Edward R. Tufte, ed., *The Quantitative Analysis of Social Problems* (Reading, Mass., 1970), 110–125 — the footnote on p. 75).

**Step 1 — the two-point chart (p. 74).** "Nearly all the important questions are left unanswered by this display" (p. 74). Figure: a steep line connecting just two dots, titled "Connecticut Traffic Deaths, Before (1955) and After (1956) Stricter Enforcement by the Police Against Cars Exceeding Speed limit." Y-axis 275–325; the 1955 point ("Before stricter enforcement") sits at about 324, the 1956 point ("After stricter enforcement") at about 284. In isolation the plunge looks like decisive proof the crackdown worked.

**Step 2 — extend the series (p. 74).** "A few more data points add immensely to the account" (p. 74). Figure: "Connecticut Traffic Deaths, 1951–1959," y-axis 225–325, the full nine-year series with the 1955→1956 segment drawn in a heavier line. Approximate values read from the plot: 1951 ≈ 265, 1952 ≈ 230, 1953 ≈ 275, 1954 ≈ 240, 1955 ≈ 324, 1956 ≈ 284, 1957 ≈ 285, 1958 ≈ 250, 1959 ≈ 245. The series reveals that 1955 was an unusual peak in a fluctuating series — so part of the 1956 drop is plausibly regression back toward typical levels, not a treatment effect.

**Step 3 — hypothetical contexts (p. 75).** "Imagine the very different interpretations other possible time-paths surrounding the 1955–1956 change would have" (p. 75). Figure: three small unlabeled sketch charts, each containing the identical thick 1955–1956 falling segment embedded in a different surrounding path: (1) a regular sawtooth oscillation, where the drop is just one of many routine down-swings; (2) a flat line with a single one-year spike at 1955, where the "effect" is merely the decay of an outlier; (3) a steady high plateau through 1955 followed by a permanent step down to a lower plateau, the only path that would suggest a genuine lasting intervention effect. Same two points, three opposite stories — context alone determines meaning.

**Step 4 — comparison groups (p. 75).** "Comparisons with adjacent states give a still better context, revealing it was not only Connecticut that enjoyed a decline in traffic fatalities in the year of the crackdown on speeding" (p. 75). Figure: "Traffic Deaths per 100,000 Persons in Connecticut, Massachusetts, Rhode Island, and New York, 1951–1959" — four labeled time-series on a y-axis running roughly 8 to 16, now rate-standardized per 100,000 persons (note the quiet methodological upgrade: per capita rates, echoing the p. 68 principle of standardized units). New York runs highest (about 13–14.5), Massachusetts next (about 11–12.5), Connecticut (solid line, its 1955–56 drop again thickened) starts near 12.8, peaks about 14.2 in 1955, and falls to about 10.3 by 1959; Rhode Island runs lowest (about 8–10.4). All four states decline after 1955–56, so the Connecticut drop is partly a regional trend, not purely a crackdown effect — though Connecticut's post-1955 decline is the steepest and most sustained.

## Conclusion: How Lies Multiply, and the Two Failed Defenses (pp. 76–77)

The conclusion scales up the stakes. "Lying graphics cheapen the graphical art everywhere. Since the lies often show up in news reports, millions of images are printed. When a chart on television lies, it lies tens of millions of times over; when a *New York Times* chart lies, it lies 900,000 times over to a great many important and influential readers. The lies are told about the major issues of public policy — the government budget, medical care, prices, and fuel economy standards, for example. The lies are systematic and quite predictable, nearly always exaggerating the rate of recent change" (p. 76). That last sentence is the chapter's empirical summary: graphical lying is not random noise but directional bias toward "things are changing fast right now."

### Defense 1: "approximately correct" (p. 76)

"The main defense of the lying graphic is … 'Well, at least it was approximately correct, we were just trying to show the general direction of change.'" Tufte's triple rebuttal (p. 76): first, "many of the deceptive displays we saw in this chapter involved fifteenfold lies, too large to be described as approximately correct"; second, "in several cases the graphics were not even approximately correct by the most lax of standards, since they falsified the real news in the data" (the OPEC charts missing the real-price decline, the New York budget chart missing the flat-then-falling real budget); third, the principled point: "It is the special character of numbers that they have a magnitude as well as an order; numbers measure *quantity*. Graphics can display the quantitative size of changes as well as their direction. The standard of getting only the direction and not the magnitude right is the philosophy that informs the Pravda School of Ordinal Graphics. There, every chart has a crystal clear direction coupled with fantasy magnitudes" (p. 76).

Figure (p. 76): the eponymous *Pravda* chart — over a black-and-white montage of factories, smokestacks, and industrial machinery, a broad arrow band rises diagonally carrying five circled numbers of arbitrarily increasing size: 1 (1922 г.), 24 (1940 г.), 279 (1970 г.), 514 (1981 г.), 537 (1982 г., marked "(план)" — plan). Caption: "Рост продукции промышленности (1922 г. = 1)" — Growth of industrial production (1922 = 1). The circle sizes bear no proportional relationship to the index values (537 is not visibly twice 279, and 24 is drawn far larger than 24 times the 1922 circle would warrant... the sizes simply ascend); direction is unmistakable, magnitude is fantasy. Source: *Pravda*, May 24, 1982, p. 2.

### Defense 2: "the real numbers are printed on it" (p. 77)

"A second defense of the lying graphic is that, although the design itself lies, the actual numbers are printed on the graphic for those picky folks who want to know the correct size of the effects displayed. It is as if not lying in one place justified fifteenfold lies elsewhere. Few writers would work under such a modest standard of integrity, and graphic designers should not either" (p. 77). (Many of the chapter's worst offenders — the road chart, the barrels, the parallelepipeds, the shrinking doctor — did print their true numbers; the printed truth never rescued the drawn lie.)

## The Six Principles of Graphical Integrity (p. 77)

The chapter ends by collecting its principles into one list: "Graphical integrity is more likely to result if these six principles are followed" (p. 77). Verbatim:

1. "The representation of numbers, as physically measured on the surface of the graphic itself, should be directly proportional to the numerical quantities represented."
2. "Clear, detailed, and thorough labeling should be used to defeat graphical distortion and ambiguity. Write out explanations of the data on the graphic itself. Label important events in the data."
3. "Show data variation, not design variation."
4. "In time-series displays of money, deflated and standardized units of monetary measurement are nearly always better than nominal units."
5. "The number of information-carrying (variable) dimensions depicted should not exceed the number of dimensions in the data."
6. "Graphics must not quote data out of context."

(Principles 1 and 2 were introduced on p. 56, principle 3 on p. 61, principle 4 on p. 68, principle 5 on p. 71, principle 6 on p. 74. The first defeats Lie-Factor distortion; the second defeats ambiguity; the third covers shifting scales and perspective; the fourth covers nominal money; the fifth covers areas and volumes for one-dimensional data; the sixth covers lies of omission.)

## Appendix: Every Quantified Claim in the Chapter

| Item | Value | Page |
|---|---|---|
| Day Mines hidden baseline | approx. −$4,200,000 | 54 |
| Airline chart lie repetitions | 4 (once per airline) | 54 |
| Asylum cost per capita range | $147 / $172 / $198 / $213 / $214 | 55 |
| Perceived circle area power law | (actual area)^x, x = .8 ± .3 | 55 |
| Table beats graphic threshold | data sets of about 20 numbers or less | 56 |
| Lie Factor distortion thresholds | > 1.05 or < .95 | 57 |
| Common Lie Factors in practice | two to five | 57 |
| Fuel standards | 18 mpg (1978) → 27.5 mpg (1985) = 53% | 57 |
| Road chart line lengths | 0.6 in → 5.3 in = 783% | 57–58 |
| Road chart Lie Factor | 783/53 = 14.8 | 58 |
| On-road mileage context | 13.7 mpg (1978); 19.1 mpg expected (1985) | 58 |
| Nobel chart axis intervals | seven 10-year increments, then 4 years | 60 |
| Nobel end-point extrapolation factor | × 2.5 | 60 |
| OPEC chart vertical scales | $8.00 / $4.73 / $4.37 / $4.16 / $3.92 per inch | 61 |
| OPEC chart horizontal scales | 3.8 years/inch, then 0.57 years/inch | 61 |
| OPEC 1979 quarterly increases | 5%, 3.809%, 2.294%, 2.691% → $13.34, $13.84, $14.16, $14.54 | 61 |
| Same quantity, two positions | 0.31 vs 4.69 sq. in. = 15.1× | 61 |
| Time barrels | 454% shown as 4,280%; LF 9.4 | 62 |
| Post derricks | 708% shown as 6,700%; LF 9.5 | 62 |
| Playfair's output | about 90 graphics over 35 years; <1/10 vertical | 65 |
| Playfair debt chart date/peak | 1786; debt to ~£250 million by 1784 | 64–65 |
| Skyrocketing-debt chart tradition | 200 years | 65 |
| Fiorina chart aspect ratio | data area 2.7× taller than wide | 66 |
| NY State budget totals (fiscal '66–'67 → '76–'77) | $4.0, 4.6, 5.5, 6.2, 6.7, 7.4, 7.8, 8.5, 9.7, 10.7, 10.8 billion | 66 |
| Aid-to-localities share | 56.7% (1970–71) to 60.7% (1972–73) | 66 |
| NY population growth | +1.7 million = 10% | 68 |
| Government purchase inflation | $1.00 (1967) = $2.03 (1977) | 68 |
| Real per-capita budget | +~20% 1967–1970; ~constant (±5% band) 1970–1976; decline 1977 | 68 |
| French auto exports (1927/28/29) | Indochine 1,969/2,352/2,248; Maroc 1,934/2,585/2,629; Tunisie 1,243/1,894/2,832; Algérie 6,646/8,217/11,610 | 69 |
| Shrinking doctor data | 27% (1964), 16.0% (1975), 12.0% (1990); ratios 1:2,247 (8,023 doctors), 1:3,167 (6,694), 1:4,232 (6,212); LF 2.8 | 69 |
| Shrinking dollar | $1.00 (1958), 94¢ (1963), 83¢ (1968), 64¢ (1973), 44¢ (Aug. 1978); shown 1978 bill should be ~2× bigger | 70 |
| Barrels by volume | 27,000% vs 454%; LF 59.4 ("a record") | 71 |
| Model derricks | 1,257 (1980), 1,686 (1981) | 71 |
| Gabaglio sample month | L. 53,092,109 deposits; 382,042 libretti; data 1876–1881 | 72 |
| Playfair's largest circle | London, 1,100,000 inhabitants | 73 |
| Cartoon chicken | 4,340 pounds; ice 33 tons | 73 |
| Connecticut deaths | ~324 (1955) → ~284 (1956); series 1951–1959 | 74 |
| Four-state rates | deaths per 100,000; CT peak ~14.2 (1955) → ~10.3 (1959) | 75 |
| NYT lie multiplier | 900,000 times over; TV: tens of millions | 76 |
| Pravda index | 1 (1922), 24 (1940), 279 (1970), 514 (1981), 537 (1982 plan) | 76 |
