# Chapter 9 — Aesthetics and Technique in Data Graphical Design: Detailed Reference

This file is the deep, page-by-page record of Chapter 9 of Edward Tufte, *The Visual Display of Quantitative Information* (2nd ed.), printed pages 177–190, plus the book's Epilogue (p. 191), which immediately follows and closes the volume. It captures every argument, figure, number, footnote, and sidenote. Printed page numbers are cited throughout.

Chapter 9 is the last numbered chapter of the book and the final chapter of Part II, "Theory of Data Graphics" (the running head on left-hand pages reads THEORY OF DATA GRAPHICS; right-hand pages read AESTHETICS AND TECHNIQUE). Where earlier chapters of Part II built the analytic machinery — data-ink, chartjunk, multifunctioning elements, data density, small multiples — this chapter turns to aesthetics: what makes a graphic *beautiful*, and what workaday techniques of format choice, word/picture integration, line weight, and shape move routine graphics toward elegance. The chapter directly continues from the conclusion of Chapter 8 (p. 175), which ended with the paired aphorisms "For non-data-ink, less is more. For data-ink, less is a bore" (credited in Chapter 8's footnote 6 to Ludwig Mies van der Rohe and to Robert Venturi, *Complexity and Contradiction in Architecture*, New York, second edition, 1977, p. 17).

## Opening: Minard's Second Carte Figurative and the Nature of Graphical Elegance (pp. 176–177)

The chapter opens opposite a full-page color plate (p. 176) reproducing a sheet from Charles Joseph Minard's portfolio. The sheet carries two maps, each signed "Dressée par M. Minard, Inspecteur Général des Ponts et Chaussées en retraite" and both dated "Paris, le 20 Novembre 1869":

- **Top: "Carte Figurative des pertes successives en hommes de l'armée qu'Annibal conduisit d'Espagne en Italie en traversant les Gaules (selon Polybe)"** — Hannibal's army crossing from Spain through Gaul into Northern Italy (according to Polybius). A flow-band whose width is proportional to the army's strength snakes eastward across a lightly drawn map labeled with regions (ESPAGNE, GAULE TRANSALPINE, GAULE CISALPINE, LIGURIE) and tribes (Solitériens, Hergètes, Bargusiens), thinning as the army fades; a boxed Légende at upper right explains the scale (the widths of the colored zones represent, at a rate of one millimeter per ten thousand men, the successive strengths of the army). The band is rendered in a light, transparent tan so the map type beneath remains legible.
- **Bottom: the famous "Carte Figurative des pertes successives en hommes de l'Armée Française dans la campagne de Russie 1812–1813"** — Napoleon's Russian campaign, with the tan advance band to Moscow, the black retreat band returning, and beneath it the "Tableau Graphique de la température en degrés du thermomètre de Réaumur au dessous de zéro" (the temperature graph in degrees Réaumur below zero, with readings such as the Berezina crossing annotations).

The sidenote on p. 177 cites the source: Charles Joseph Minard, *Tableaux Graphiques et Cartes Figuratives de M. Minard, 1845–1869*, a portfolio of his work held by the Bibliothèque de l'École Nationale des Ponts et Chaussées, Paris.

Tufte's opening paragraph (p. 177): "Along with the amazing graphic of the French losses in the Russian invasion, Minard includes a second 'Carte Figurative.' It portrays Hannibal's fading elephant campaign in Spain, Gaul, and Northern Italy. Minard uses a light transparent color for flow-lines, allowing the underlying type to show through. This refined use of color to depict more information contrasts with the garish tones too often seen in modern graphics."

He then poses the chapter's framing question: "What makes for such graphical elegance? What accounts for the quality of Minard's graphics, of those of Playfair and Marey, and of some recent work, such as the new view of the galaxies?" (The galaxies map was praised in Chapters 1 and 8; Playfair and Marey are the book's other recurring exemplars.) The answer — "Good design has two key elements" — is set off as a displayed principle (p. 177):

> "Graphical elegance is often found in simplicity of design and complexity of data."

The two key elements are thus *simplicity of design* and *complexity of data*.

Tufte immediately adds a claim about content: "Visually attractive graphics also gather power from content and interpretations beyond the immediate display of some numbers. The best graphics are about the useful and important, about life and death, about the universe. Beautiful graphics do not traffic with the trivial." (p. 177)

Next comes a deliberate limit on what aesthetic theory can deliver: "On rare occasions graphical architecture combines with the data content to yield a uniquely spectacular graphic. Such performances can be described and admired but there are no easy compositional principles on how to create that one wonderful graphic in millions. As Barnett Newman once said, 'Aesthetics is for the artist like ornithology is for the birds.'" (p. 177) The structure of the argument: masterpieces cannot be generated by rule, but the visual quality of "routine, workaday designs" *can* be systematically enhanced — and that is what the rest of the chapter supplies.

The chapter's agenda is then stated as a bulleted list (p. 177): "What can be suggested, though, are some guides for enhancing the visual quality of routine, workaday designs. Attractive displays of statistical information

- have a properly chosen format and design
- use words, numbers, and drawing together
- reflect a balance, a proportion, a sense of relevant scale
- display an accessible complexity of detail
- often have a narrative quality, a story to tell about the data
- are drawn in a professional manner, with the technical details of production done with care
- avoid content-free decoration, including chartjunk."

These seven bullets map onto the chapter's sections: format choice (sentences/tables/graphics), word-number-picture integration, the friendly graphic, line weight, and shape; chartjunk was treated in Chapter 6 and is here only restated as a requirement.

## The Choice of Design: Sentences, Text-Tables, Tables, Semi-Graphics, and Graphics (pp. 178–180)

This section asks the prior question of format: before designing a graphic, should the data be a graphic at all?

Opening framework (p. 178): "The substantive content, extensiveness of labels, and volume and ordering of data all help determine the choice of method for the display of quantitative materials. The basic structures for showing data are the sentence, the table, and the graphic. Often two or three of these devices should be combined."

### Sentences fail; text-tables succeed (p. 178)

"The conventional sentence is a poor way to show more than two numbers because it prevents comparisons within the data. The linearly organized flow of words, folded over at arbitrary points (decided not by content but by the happenstance of column width), offers less than one effective dimension for organizing the data." (p. 178) Note the precision of the claim: a sentence has *less than one* effective organizing dimension, because even its single linear order is broken arbitrarily by line wraps.

Tufte demonstrates with a deliberately clumsy set sentence (typeset as a narrow justified block whose last line is crammed together, making the arbitrariness of folding visible):

> Nearly 53 percent of the type A group did something or other compared to 46 percent of B and slightly more than 57 percent of C.

Then the same content rearranged "to facilitate comparisons, as in this *text-table*":

> The three groups differed in how they did something or other:
>
> | | |
> |---|---|
> | Group A | 53% |
> | Group B | 46% |
> | Group C | 57% |

And then a further improvement: "There are nearly always better sequences than alphabetical — for example, ordering by content or by data values" (p. 178), shown by re-sorting:

| | |
|---|---|
| Group B | 46% |
| Group A | 53% |
| Group C | 57% |

### Tables, and the verdict on pie charts (p. 178)

"Tables are clearly the best way to show exact numerical values, although the entries can also be arranged in semi-graphical form. Tables are preferable to graphics for many small data sets." (p. 178) Footnote 1 attaches to this sentence: "On the design of tables, see A.S.C. Ehrenberg, 'Rudiments of Numeracy,' *Journal of the Royal Statistical Society*, A, 140 (1977), 277–297."

Then the book's most quoted condemnation: "A table is nearly always better than a dumb pie chart; the only worse design than a pie chart is several of them, for then the viewer is asked to compare quantities located in spatial disarray both within and between pies, as in this heavily encoded example from an atlas. Given their low data-density and failure to order numbers along a visual dimension, pie charts should never be used." (p. 178)

The "heavily encoded example" is reproduced in the right margin spanning most of the page: a map of Israel from the *Atlas of Israel* (sidenote citation: Department of Surveys, Ministry of Labour, *Atlas of Israel*, Jerusalem, 1956–, vol. 8, p. 8) covered with dozens of pie charts of varying diameters, each divided into wedges distinguished by dark shadings and patterns keyed to a legend in Hebrew at upper left. The pies sit scattered over the country's geography, so wedge-to-wedge comparison requires hunting across the map and decoding the shading scheme — exactly the "spatial disarray both within and between pies" of the text.

Footnote 2 attaches to the final sentence: "This point is made decisively in Jacques Bertin, *Graphics and Graphic Information Processing* (Berlin, 1981). Bertin describes multiple pie charts as 'completely useless' (p. 111)."

### The supertable (p. 179)

"Tables also work well when the data presentation requires many localized comparisons." (p. 179) The demonstration occupies most of p. 179: a 410-number table Tufte designed himself, reproduced from the *New York Times*, November 9, 1980, p. A-28 (sidenote citation at lower left), headed **"How Different Groups Voted for President."** Its subhead: "Based on 12,782 interviews with voters at their polling places. Shown is how each group divided its vote for President and, in parentheses, the percentage of the electorate belonging to each group." Source line at bottom: "Source: 1976 and 1980 election day surveys by The New York Times/CBS News Poll and 1976 election day survey by NBC News."

Structure: four numeric columns — CARTER, REAGAN, ANDERSON, and CARTER–FORD in 1976 (the 1976 column gives paired percentages like "77–22"; a dash means no 1976 figure). Each row is a voter group with its share of the electorate in parentheses. Thin horizontal rules divide the rows into topical panels.

Tufte's text explains the reading design: "In this 410-number table that I designed for the *New York Times* to show how different people voted in presidential elections in the United States, comparisons between the elections of 1980 and 1976 are read across each line; within-election analysis is conducted by reading downward in the clusters of three to seven lines. The horizontal rules divide the data into topical paragraphs; the rows are ordered so as to tell an ordered story about the elections. This type of elaborate table, a *supertable*, is likely to attract and intrigue readers through its organized, sequential detail and reference-like quality. One supertable is far better than a hundred little bar charts." (p. 179)

The table's topical panels, in order, with their row labels (group share of electorate in parentheses):

1. Party identification: Democrats (43%), Independents (23%), Republicans (28%)
2. Ideology: Liberals (17%), Moderates (46%), Conservatives (28%)
3. Democrats by ideology/activity: Liberal Democrats (9%), Moderate Democrats (22%), Conservative Democrats (8%), Politically active Democrats (3%), Democrats favoring Kennedy in primaries (13%)
4. Independents by ideology: Liberal Independents (4%), Moderate Independents (12%), Conservative Independents (7%)
5. Republicans by ideology/activity: Liberal Republicans (2%), Moderate Republicans (11%), Conservative Republicans (12%), Politically active Republicans (2%)
6. Region: East (32%), South (27%), Midwest (20%), West (11%)
7. Race: Blacks (10%), Hispanics (2%), Whites (88%)
8. Sex and equal-rights stance: Female (49%), Male (51%), Female, favors equal rights amendment (22%), Female, opposes equal rights amendment (15%)
9. Religion: Catholic (25%), Jewish (5%), Protestant (46%), Born-again white Protestant (17%)
10. Age: 18–21 years old (6%), 22–29 years old (17%), 30–44 years old (31%), 45–59 years old (23%), 60 years or older (18%)
11. Family income: Less than $10,000 (13%), $10,000–$14,999 (14%), $15,000–$24,999 (30%), $25,000–$50,000 (24%), Over $50,000 (5%)
12. Occupation: Professional or manager (40%); Clerical, sales or other white-collar (11%); Blue-collar worker (17%); Agriculture (3%); Looking for work (3%)
13. Education: High school or less (39%), Some college (28%), College graduate (27%)
14. Union: Labor union household (26%), No member of household in union (62%)
15. Family finances: Better off than a year ago (16%), Same (40%), Worse off than a year ago (34%)
16. Family finances and political party (the printed panel header): Democrats, better off than a year ago (7%); Democrats, worse off than a year ago (13%); Independents, better off (3%); Independents, worse off (9%); Republicans, better off (4%); Republicans, worse off (11%)
17. More important problem: Unemployment (39%), Inflation (44%)
18. Foreign policy: Feel that U.S. should be more forceful in dealing with Soviet Union even if it would increase the risk of war (54%), Disagree (31%)
19. Equal rights amendment: Favor (46%), Oppose (35%)
20. When decided about choice: Knew all along (41%), During the primaries (13%), During conventions (8%), Since Labor Day (8%), In week before election (23%)

Representative rows as printed (Carter / Reagan / Anderson / Carter–Ford in 1976):

| Group | Carter | Reagan | Anderson | Carter–Ford in 1976 |
|---|---|---|---|---|
| Democrats (43%) | 66 | 26 | 6 | 77–22 |
| Independents (23%) | 30 | 54 | 12 | 43–54 |
| Republicans (28%) | 11 | 84 | 4 | 9–90 |
| Liberals (17%) | 57 | 27 | 11 | 70–26 |
| Moderates (46%) | 42 | 48 | 8 | 51–48 |
| Conservatives (28%) | 23 | 71 | 4 | 29–70 |
| East (32%) | 43 | 47 | 8 | 51–47 |
| South (27%) | 44 | 51 | 3 | 54–45 |
| Midwest (20%) | 41 | 51 | 6 | 48–50 |
| West (11%) | 35 | 52 | 10 | 46–51 |
| Blacks (10%) | 82 | 14 | 3 | 82–16 |
| Hispanics (2%) | 54 | 36 | 7 | 75–24 |
| Whites (88%) | 36 | 55 | 8 | 47–52 |
| Female (49%) | 45 | 46 | 7 | 50–48 |
| Male (51%) | 37 | 54 | 7 | 50–48 |

(The full newspaper table carries the same four columns for every row listed above — 410 numbers in all.)

The design lessons embedded in the example: rules used sparingly as paragraph dividers (not as a grid imprisoning every cell), row order chosen to narrate (party → ideology → demographics → issues → timing of decision), clusters sized three to seven lines for downward scanning, and a built-in cross-election comparison on every line.

### The wordy data graphic (p. 180)

"For sets of highly labeled numbers, a wordy data graphic — coming close to straight text — works well. This table of numbers is nicely organized into a graphic:" (p. 180)

The example, reproduced at near-full page width, is **"Some Winners and Losers in the Forecasting Game"** from the *New York Times*, January 2, 1979, p. D-3 (sidenote citation). Its construction: a horizontal black band across the middle of the graphic lists the actual (probable) 1978 results for five economic indicators, white type on black:

| Indicator (black panel) | Actual 1978 result |
|---|---|
| Real G.N.P. growth | +3.8% |
| Industrial Production growth | +5.8% |
| Change in Consumer Prices | +7.7% |
| Corporate Profits growth (after taxes) | +13.3% |
| Unemployment Rate | 6% |

An explanatory note printed inside the graphic reads: "About a year ago, eight forecasters were asked for their predictions on some key economic indicators. Here's how the forecasts stack up against the probable 1978 results (shown in the black panel)." The eight forecasters are the Council of Economic Advisers, Data Resources, the National Association of Business Economists, Wharton Econometric Forecasting, the Congressional Budget Office, the Conference Board, the I.B.M. Economics Department, and Chase Econometrics. Each forecaster's prediction is printed as a small labeled box ("Wharton Econometric Forecasting: +4.5%") placed in the column of its indicator, *above* the black band if the forecast exceeded the actual outcome and *below* if it fell short, ordered by distance from the actual value. For example, in the Real G.N.P. column seven forecasters over-predicted growth (Council of Economic Advisers +4.7%, Data Resources +4.5%, National Association of Business Economists +4.5%, Wharton +4.5%, Congressional Budget Office +4.4%, Conference Board +4.2%, I.B.M. +4.1%) and only Chase Econometrics under-predicted (+2.8%); in the Unemployment column every forecaster sits above the band (predictions running from Chase's 7.4% down to 6.3%, against the actual 6%); in the Corporate Profits column Wharton's +21% sits alone above the band while the rest under-predicted the actual +13.3% (e.g., Data Resources +10.5%, I.B.M. +10.4%); in the Industrial Production column only the National Association of Business Economists (+6.2%) and I.B.M. (+5.9%) sit above the band (actual +5.8%), with the rest below, bottoming at Chase Econometrics' +1.9%; and in the Change in Consumer Prices column every forecaster under-predicted the actual +7.7% inflation, so all the boxes hang below the band. A corner note states: "Forecasters are not listed in categories for which they did not make a prediction," with the asterisked qualifier "After taxes." The graphic is thus literally a sorted table whose spatial arrangement (above/below, distance from the band) encodes sign and size of forecast error — text doing graphical work.

## Making Complexity Accessible: Combining Words, Numbers, and Pictures (pp. 180–182)

### Words and pictures belong together (p. 180)

"Explanations that give access to the richness of the data make graphics more attractive to the viewer." (p. 180) Tufte diagnoses why words and pictures are so often separated: "Words and pictures are sometimes jurisdictional enemies, as artists feud with writers for scarce space. An unfortunate legacy of these craft-union differences is the artificial separation of words and pictures; a few style sheets even forbid printing on graphics. What has gone wrong is that the techniques of production instead of the information conveyed have been given precedence." (p. 180) The separation is a production artifact, not an information-design principle.

The positive doctrine: "Words and pictures belong together. Viewers need the help that words can provide. Words on graphics are data-ink, making effective use of the space freed up by erasing redundant and non-data-ink. It is nearly always helpful to write little messages on the plotting field to explain the data, to label outliers and interesting data points, to write equations and sometimes tables on the graphic itself, and to integrate the caption and legend into the design so that the eye is not required to dart back and forth between textual material and the graphic." (p. 180) Note the explicit tie-back to Chapters 4–6: annotation is *data-ink*, occupying space that erasing principles freed.

A practical parenthesis carries over to p. 181: "(The size of type on and around graphics can be quite small, since the phrases and sentences are usually not too long — and therefore the small type will not fatigue viewers the way it does in lengthy texts.)" (pp. 180–181)

### The principle of data/text integration (p. 181)

Set off as a displayed principle:

> "Data graphics are paragraphs about data and should be treated as such."

The argument for it: "Words, graphics, and tables are different mechanisms with but a single purpose — the presentation of information. Why should the flow of information be broken up into different places on the page because the information is packaged one way or another? Sometimes it may be useful to have multiple story-lines or multiple levels of presentation, but that should be a deliberate design judgment, not something decided by conventional production requirements. Imagine if graphics were replaced by paragraphs of words and those paragraphs scattered over the pages out of sequence with the rest of the text — that is how graphical and tabular information is now treated in the layout of many published pages, particularly in scientific journals and professional books." (p. 181) The thought experiment (scattering *prose* paragraphs out of sequence) is the section's central rhetorical move: it makes the standard treatment of figures look absurd by symmetry.

Practical consequences (p. 181):

- "Tables and graphics should be run into the text whenever possible, avoiding the clumsy and diverting segregation of 'See Fig. 2,' (figures all too often located on the back of the adjacent page)." Footnote 3 attaches here: "'Fig.,' often used to refer to graphics, is an ugly abbreviation and is not worth the two spaces saved."
- "If a display is discussed in various parts of the text, it might well be printed afresh near each reference to it, perhaps in reduced size in later showings."
- "The principle of text/graphic/table integration also suggests that the same typeface be used for text and graphic and, further, that ruled lines separating different types of information be avoided."

### Biderman on the segregation of graphics (p. 181)

Historical support: "Albert Biderman notes that illustrations were once well-integrated with text in scientific manuscripts, such as those of Newton and Leonardo da Vinci, but that statistical graphics became segregated from text and table as printing technology developed:" (p. 181), followed by the block quotation:

> "The evolution of graphic methods as an element of the scientific enterprise has been handicapped by their adjunctive, segregated, and marginal position. The exigencies of typography that moved graphics to a segregated position in the printed work have in the past contributed to their intellectual segregation and marginality as well. There was a corresponding organizational segregation, with decisions on graphics often passing out of the hands of the original analyst and communicator into those of graphic specialists — the commercial artists and designers of graphic departments and audio-visual aids shops, for example, whose predilections and skills are usually more those of cosmeticians and merchandisers than of scientific analysts and communicators."

Footnote 4: Albert D. Biderman, "The Graph as a Victim of Adverse Discrimination and Segregation," *Information Design Journal*, 1 (1980), 238. The quote adds a second mechanism to Tufte's production-artifact diagnosis: typographic segregation caused *organizational* segregation, handing graphic decisions from analysts to "cosmeticians and merchandisers."

### Leonardo's manuscript page (p. 182)

"Page after page of Leonardo's manuscripts have a gentle but thorough integration of text and figure, a quality rarely seen in modern work:" (p. 182). The reproduced facsimile page (sidenote citation: Leonardo da Vinci, *Treatise on Painting* [Codex Urbinas Latinus 1270], vol. 2, facsimile, Princeton, 1956, p. 234, paragraph 827) shows Leonardo's mirror-written Italian flowing around two small embedded diagrams: an optical diagram (a small triangle with labeled points m, n, a, b, o marking eye and picture-plane geometry, set directly into the middle of a paragraph with the text wrapping on both sides) and, lower on the page, a sketch of mountain profiles with lettered atmospheric gradations (points a–k marking degrees of air thickness above the peaks), again with the handwriting running tight around the drawing. The page demonstrates physically what the principle demands: figures as in-line clauses of the argument, not segregated plates. The folio number "234" appears at top right of the facsimile.

### Caveat: words must match the graphic's purpose (p. 182)

The section closes with a qualification: "Finally, a caveat: the use of words and pictures together requires a special sensitivity to the purpose of the design — in particular, whether the graphic is primarily for communication and illustration of a settled finding or, in contrast, for the exploration of a data set. Words on and around graphics are highly effective — sometimes all too effective — in telling viewers how to allocate their attention to the various parts of the data display. Thus, for graphics in exploratory data analysis, words should tell the viewer *how* to read the design (if it is a technically complex arrangement) and not *what* to read in terms of content." (p. 182)

Footnote 5 supports the "all too effective" claim with perceptual evidence: "Experiments in visual perception indicate that word instructions substantially determine eye movements in viewing pictures. See John D. Gould, 'Looking at Pictures,' in Richard A. Monty and John W. Senders, eds., *Eye Movements and Psychological Processes* (Hillsdale, N.J., 1976), 323–343."

The distinction is load-bearing for practice: annotation that pre-interprets content is appropriate for presentation graphics but biases exploration; in exploratory work, label the *mechanics* of the display, never the conclusions.

## Accessible Complexity: The Friendly Data Graphic (p. 183)

Definition (p. 183): "An occasional data graphic displays such care in design that it is particularly accessible and open to the eye, as if the designer had the viewer in mind at every turn while constructing the graphic. This is the *friendly data graphic*."

"There are many specific differences between friendly and unfriendly graphics:" — the full two-column inventory, reproduced verbatim:

| Friendly | Unfriendly |
|---|---|
| words are spelled out, mysterious and elaborate encoding avoided | abbreviations abound, requiring the viewer to sort through text to decode abbreviations |
| words run from left to right, the usual direction for reading occidental languages | words run vertically, particularly along the Y-axis; words run in several different directions |
| little messages help explain data | graphic is cryptic, requires repeated references to scattered text |
| elaborately encoded shadings, cross-hatching, and colors are avoided; instead, labels are placed on the graphic itself; no legend is required | obscure codings require going back and forth between legend and graphic |
| graphic attracts viewer, provokes curiosity | graphic is repellent, filled with chartjunk |
| colors, if used, are chosen so that the color-deficient and color-blind (5 to 10 percent of viewers) can make sense of the graphic (blue can be distinguished from other colors by most color-deficient people) | design insensitive to color-deficient viewers; red and green used for essential contrasts |
| type is clear, precise, modest; lettering may be done by hand | type is clotted, overbearing |
| type is upper-and-lower case, with serifs | type is all capitals, sans serif |

Specific quantitative and practical content worth flagging: color-deficient viewers are 5 to 10 percent of the audience; blue is the safe hue (distinguishable from other colors by most color-deficient people); red versus green is the canonical unsafe contrast.

The typography row is then defended by authority: "With regard to typography, Josef Albers writes:" followed by the block quotation (p. 183):

> "The concept that 'the simpler the form of a letter the simpler its reading' was an obsession of beginning constructivism. It became something like a dogma, and is still followed by 'modernistic' typographers. . . . Ophthalmology has disclosed that the more the letters are differentiated from each other, the easier is the reading. Without going into comparisons and details, it should be realized that words consisting of only capital letters present the most difficult reading — because of their equal height, equal volume, and, with most, their equal width. When comparing serif letters with sans-serif, the latter provide an uneasy reading. The fashionable preference for sans-serif in text shows neither historical nor practical competence."

Footnote 6: Josef Albers, *Interaction of Color* (New Haven, 1963, revised edition 1975), p. 4. The Albers argument: differentiation between letterforms, not simplicity of letterforms, drives legibility; all-capitals is worst (equal height, equal volume, mostly equal width); serif beats sans-serif.

## Proportion and Scale: Line Weight and Lettering (pp. 184–186)

### Visual balance: Stockhausen versus Tufte's own graphic (p. 184)

Principle first: "Graphical elements look better together when their relative proportions are in balance. An integrated quality, an appropriate visual linkage between the various elements, results." (p. 184)

Positive example: a strip from Karlheinz Stockhausen's musical score (sidenote: Karlheinz Stockhausen, *Texte*, vol. 2, Cologne, 1964, p. 82, from the score of "Zyklus für einen Schlagzeuger" — a percussion solo). The reproduced passage runs along a single horizontal line and mixes notation of many kinds and weights: a triangle symbol at far left, a circled dot, note-heads and stems on and off the line, dashed vertical drop-lines, a treble-clef cluster with curved slurs, boxed and half-boxed note groups at right with tied curves, an inverted-T and other percussion symbols, and a pair of long thin arrows converging on the handwritten word "Mischungen" (mixtures) below the line. Tufte's point: despite the heterogeneity, "this musical score of Karlheinz Stockhausen exhibits such a visual balance" — every element is delicately weighted, nothing shouts.

Negative example — Tufte critiques his own published work: "In contrast, this next design is heavy handed, with nearly every element out of balance: the clotted ink, the poor style of lettering, the puffed-up display of a small data set, the coarse texture of the entire graphic, and the mismatch between drawing and surrounding text:" (p. 184). The graphic is Figure 4, "Seats and Votes in 1968," from Edward R. Tufte, "The Relationship Between Seats and Votes in Two-Party Systems," *American Political Science Review*, 67 (June 1973), 551 (sidenote citation). Construction: a boxed scatterplot of about twenty heavy black dots; vertical axis "DEMOCRATIC SHARE OF SEATS" in all-capitals stacked type, ticked 50%, 60%, 70% (running 40% to 70%); horizontal axis "DEMOCRATIC SHARE OF VOTE" in all capitals, ticked 40%, 50%, 60%; heavy dashed lines at the 50%-votes and 50%-seats levels crossing in the field; a thick arrowed annotation "Actual result: Democrats received 50.9% votes, 55.4% seats" pointing at one dot, and "(50% votes, 50% seats)" labeling the dashed crossing; the caption "Figure 4. Seats and Votes in 1968" set beneath in journal style. The five named faults are an inventory of imbalance symptoms: clotted ink; poor lettering (mechanical all-caps); a puffed-up display of a small data set; coarse texture; mismatch between drawing and surrounding text. (Note the self-criticism is deliberate — the book elsewhere also reworks this same seats-votes material as a positive example of dot-dash plots in Chapter 6.)

### Thin lines (p. 185)

"Lines in data graphics should be thin. One reason eighteenth- and nineteenth-century graphics look so good is that they were engraved on copper plates, with a characteristic hair-thin line. The drafting pens of twentieth-century mechanical drawing thickened linework, making it clumsy and unattractive." (p. 185) The historical mechanism: engraving technology enforced elegance; drafting pens removed the constraint and quality fell.

### Orthogonal intersections of differing weights: the Diller painting (p. 185)

"An effective aesthetic device is the orthogonal intersection of lines of different weights." (p. 185) The demonstration is a pair of images:

1. A reproduction of the poster for the exhibition "Mondrian and Neo-Plasticism in America," Yale University Art Gallery, October 18 to December 2, 1979 (sidenote, which adds: "The original painting was done in 1941 by Diller; see Nancy J. Troy, *Mondrian and Neo-Plasticism in America* (New Haven, 1979), p. 28."). The design, based on a 1941 painting by Burgoyne Diller: on a pale cream field, a sparse grid of black horizontal and vertical lines of conspicuously different thicknesses — some hairline, some medium, one very heavy short horizontal bar at lower right — with a single solid red rectangle filling one cell near the top.
2. Immediately below, a redrawn version of the same composition in which every line has been given the same constant width, the red rectangle and layout unchanged.

The text between them: "Nearly every intersection of the lines in this design (based on a painting by Burgoyne Diller) involves lines of differing weights, and it makes a difference, for the painting's character is diluted with lines of constant width." (p. 185) The before/after pair is itself a small-multiple argument: hold everything constant except line-weight variation, and watch the design die.

### Application to data graphics: the heavier line is a data measure (p. 186)

"Likewise, data graphics can be enhanced by the perpendicular intersections of lines of differing weights. The heavier line should be a data measure. In a time-series, for example:" (p. 186). The figure: a small step-chart (staircase time-series) of five horizontal segments at varying levels, drawn as thick black bars, joined by thin hairline vertical connectors. The horizontal segments are the data (the value during each period); the verticals are mere connectors.

The principle, stated and tied back to the book's core theory: "The contrast in line weight represents contrast in meaning. The greater meaning is given to the greater line weight; thus the data line should receive greater weight than the connecting verticals. The logic here is a restatement, in different language, of the principle of data-ink maximization." (p. 186) This sentence is the bridge between the chapter's aesthetics and Part II's theory: weight-hierarchy is data-ink maximization expressed as visual emphasis.

## Proportion and Scale: The Shape of Graphics (pp. 186–190)

### The rule and its first reason: the horizon (pp. 186–187)

"Graphics should tend toward the horizontal, greater in length than height:" (p. 186), illustrated by a schematic frame — a short vertical stroke labeled "lesser height" and a long horizontal baseline labeled "greater length."

"Several lines of reasoning favor horizontal over vertical displays." (p. 186) Tufte then gives five, numbered First through Fourth plus "finally":

**First, analogy to the horizon.** "Our eye is naturally practiced in detecting deviations from the horizon, and graphic design should take advantage of this fact. Horizontally stretched time-series are more accessible to the eye:" (p. 186) — illustrated by a wide, low frame containing a wiggly line chart.

A corollary on p. 187: "The analogy to the horizon also suggests that a shaded, high-contrast display might occasionally be better than the floating snake. The shading should be calm, without moiré effects." The figure pairs two renderings of the same jagged series: on the left, the area under the curve filled solid black down to the baseline, reading as a mountain-silhouette against sky (the horizon made literal); on the right, the same data as a thin unanchored line — the "floating snake." Two qualifications are packed in: this is only *occasionally* better, and the shading must be solid and calm (moiré-producing patterns, condemned in Chapter 6, would forfeit the gain).

**Second, ease of labeling** (p. 187). "It is easier to write and to read words that read from left to right on a horizontally stretched plotting-field." The figure: a wide axis sketch with "some labels" sitting comfortably beside the short vertical axis and "some other labels" lying along the long horizontal axis, set against ("instead of") a tall narrow sketch where "some / labels" and "some / other / labels" must stack in cramped broken lines beside the long vertical axis. The horizontal format gives words room to run their natural direction (linking back to the friendly-graphic rule that words run left to right).

**Third, emphasis on causal influence** (p. 187). "Many graphics plot, in essence," — followed by a bare axis sketch with the vertical axis labeled "effect" and the horizontal axis labeled "cause" — "and a longer horizontal helps to elaborate the workings of the causal variable in more detail." (p. 187) Since convention puts cause on x and effect on y, stretching x gives the explanatory variable more resolution. (This echoes the book's earlier maxim from Chapter 1 that graphical excellence "is nearly always multivariate" and that displays should encourage causal thinking.)

**Fourth, Tukey's counsel** (p. 188). Block quotation from John W. Tukey:

> "Most diagnostic plots involve either a more or less definite dependence that bobbles around a lot, or a point spatter. Such plots are rather more often better made *wider* than tall. Wider-than-tall shapes usually make it easier for the eye to follow from left to right.
> Perhaps the most general guidance we can offer is that smoothly-changing curves can stand being taller than wide, but a wiggly curve needs to be wider than tall. . . ."

Footnote 7: John W. Tukey, *Exploratory Data Analysis* (Reading, Mass., 1977), p. 129. Tukey's refinement matters: the horizontal rule is strongest for wiggly, noisy displays; smooth curves can tolerate vertical formats.

**"And, finally, Playfair's example."** (p. 188) "Of the 89 graphics in six different books by William Playfair, most (92 percent) are wider than tall. Several of the exceptions are his skyrocketing government debt displays. This plot shows the dimensions of each of those 89 graphics:" (p. 188)

The full-width figure at the bottom of p. 188 is Tufte's own meta-scatterplot. Construction: vertical axis "Height (inches)" ticked at 4, 8, 12; horizontal axis "Length (inches)" ticked at 4, 8, 12, 16; a 45° diagonal line from the origin separates the field, with three region labels across the top: "Graphic is taller than wide" (above-left of the diagonal), "Graphic is square" (on the diagonal), "Graphic is wider than tall" (below-right). Each of the 89 points marks the upper right-hand corner of one Playfair graphic laid with its lower-left corner at the origin — so a point's coordinates *are* the graphic's length and height. An annotation reads "Each plotted point represents the upper right-hand corner of one of Playfair's graphics; for example" beside a small inset reproduction of a Playfair time-series chart (a gridded chart with a black silhouette data area and an oval cartouche title), and a dotted rectangle drawn on the plot (about 9.3 inches long by 4.5 high) shows that example graphic's footprint, its dotted corner landing on the corresponding plotted point. The mass of points clusters below the diagonal around lengths of 5–7 inches and heights of 2–4.5 inches (three dense clumps are visible, reflecting the standard page sizes of Playfair's books); a few points sit far right around 14–15 inches long by 10.5 high (large fold-out plates, still wider than tall); and a small number of points lie above the diagonal — taller than wide — including one near 11 inches wide by 12.5 high. Those exceptions are the "skyrocketing government debt displays," where the soaring data demanded a vertical format. The figure is itself a demonstration of the book's methods: an entire corpus summarized as a high-density scatter with a reference diagonal and an integrated explanatory example.

### How horizontal? The Golden Section examined (p. 189)

"If graphics should tend toward the horizontal rather than the vertical, then how much so? A venerable (fifth-century B.C.) but dubious rule of aesthetic proportion is the Golden Section, a 'divine division' of a line." (p. 189) Footnote 8: "The combination of geometry and mysticism surrounding the Golden Rectangle can be seen in Miloutine Borissavlièvitch, *The Golden Number and the Scientific Aesthetics of Architecture* (New York, 1958) and Tons Brunés, *The Secrets of Ancient Geometry* (Copenhagen, 1967), vols. 1 and 2." (Note the rhetorical positioning: "venerable . . . but dubious," and the footnote's pairing of "geometry and mysticism.")

The derivation, with figures: a line segment divided into parts labeled a and b ("A length is divided such that the smaller is to the greater part as the greater is to the whole"):

a/b = b/(a + b)

"Solving the quadratic when a = 1 yields b = (√5 + 1)/2 = 1.618 . . . ." (p. 189)

"In turn the Golden Rectangle is" — a drawn rectangle with height labeled 1.0 and length labeled 1.618. . . (p. 189)

The debunking move: "The nice geometry of the Golden Rectangle is not unique; Birkhoff points out that at least five other rectangles (including the square) have one simple mathematical property or another for which aesthetic claims might be made:" (p. 189) Footnote 9: George D. Birkhoff, *Aesthetic Measure* (Cambridge, 1933), pp. 27–30. The figure shows five rectangles in a row, each drawn with a light interior construction line revealing its "simple mathematical property" (a bisector or diagonal), labeled beneath with their length-to-height ratios:

| r = 1 | r = 1.414 | r = 1.618 | r = 1.732 | r = 2 |
|---|---|---|---|---|
| square | √2 (halves into two of itself) | golden | √3 (diagonal property) | double square |

If five different ratios each have a tidy geometric credential, geometry alone cannot privilege 1.618.

Empirical evidence from the master: "Playfair favored proportions between 1.4 and 1.8 in about two-thirds of his published graphics, with most of the exceptions moving more toward the horizontal than the golden prescription:" (p. 189). The margin figure repeats the Playfair dimensions scatterplot in miniature, now with the diagonal labeled "Golden Rectangle" (the line of points whose length/height ratio is 1.618): the dense cluster of points hugs that diagonal from below/right, and the outlying points fall on the more-horizontal side of it. So Playfair's practice loosely brackets the golden ratio but errs horizontal, not vertical.

### Psychological studies of rectangle preference (p. 190)

"Visual preferences for rectangular proportions have been studied by psychologists since 1860, but, even given the implausible assumption that such studies are relevant to graphic design, the findings are hardly decisive. A mild preference for proportions near to the Golden Rectangle is found among those taking part in the experiments, but the preferred height/length ratios also vary a great deal, ranging between" (p. 190) — two drawn rectangles: one with height 1.0 and length 1.2, "and" one with height 1.0 and length 2.2. So the experimental range of preferred shapes runs from 1.0 × 1.2 to 1.0 × 2.2.

"And, as is nearly always the case in experiments in graphical perception, viewer responses were found to be highly context-dependent." (p. 190) Footnote 10: "I have relied on Leonard Zusne, *Visual Perception of Form* (New York, 1970), ch. 10, for a summary of the immense literature." Note Tufte's two-layer skepticism: (1) the relevance of abstract rectangle-preference experiments to graphic design is itself an "implausible assumption"; (2) even taken at face value the results are indecisive and context-dependent. (The aside "as is nearly always the case in experiments in graphical perception" generalizes his skepticism about perceptual psychology as a foundation for design rules, consistent with Chapter 3's treatment of perception experiments.)

### The conclusions on shape (p. 190)

"The conclusions:

- If the nature of the data suggests the shape of the graphic, follow that suggestion.
- Otherwise, move toward horizontal graphics about 50 percent wider than tall:"

The final figure is a plain rectangle drawn at the recommended proportion, roughly 1.5 times wider than tall. Note the priority ordering: data-driven shape (Playfair's debt skyrockets, or a tall map of Israel) overrides the default; the 1.5:1 ratio is only the residual rule, sitting deliberately inside both Playfair's favored band (1.4–1.8) and the experimental range (1.2–2.2), and slightly below the golden 1.618 — a pragmatic synthesis rather than a mystical constant.

## Epilogue: Designs for the Display of Information (p. 191)

The Epilogue follows immediately and closes the book's argument in a single page of large-set text. Reproduced essentially in full because every clause is load-bearing:

"Design is choice. The theory of the visual display of quantitative information consists of principles that generate design options and that guide choices among options. The principles should not be applied rigidly or in a peevish spirit; they are not logically or mathematically certain; and it is better to violate any principle than to place graceless or inelegant marks on paper. Most principles of design should be greeted with some skepticism, for word authority can dominate our vision, and we may come to see only through the lenses of word authority rather than with our own eyes.

What is to be sought in designs for the display of information is the clear portrayal of complexity. Not the complication of the simple; rather the task of the designer is to give visual access to the subtle and the difficult — that is,

the revelation of the complex."

The final phrase, "the revelation of the complex," is set off alone, centered, as the book's last line of argument. The Epilogue retroactively frames everything in Chapters 4–9: the principles (maximize data-ink, erase, avoid chartjunk, maximize data density, integrate words and pictures, tend horizontal) are option-generators and choice-guides, not laws; aesthetic judgment — "graceless or inelegant marks" — outranks any single rule; and even the book's own "word authority" should be distrusted in favor of looking.

## Consolidated footnotes and sidenote citations for Chapter 9

1. (p. 178) A.S.C. Ehrenberg, "Rudiments of Numeracy," *Journal of the Royal Statistical Society*, A, 140 (1977), 277–297 — on the design of tables.
2. (p. 178) Jacques Bertin, *Graphics and Graphic Information Processing* (Berlin, 1981); multiple pie charts "completely useless" (p. 111).
3. (p. 181) "'Fig.,' often used to refer to graphics, is an ugly abbreviation and is not worth the two spaces saved."
4. (p. 181) Albert D. Biderman, "The Graph as a Victim of Adverse Discrimination and Segregation," *Information Design Journal*, 1 (1980), 238.
5. (p. 182) John D. Gould, "Looking at Pictures," in Richard A. Monty and John W. Senders, eds., *Eye Movements and Psychological Processes* (Hillsdale, N.J., 1976), 323–343 — word instructions substantially determine eye movements in viewing pictures.
6. (p. 183) Josef Albers, *Interaction of Color* (New Haven, 1963; revised edition 1975), p. 4.
7. (p. 188) John W. Tukey, *Exploratory Data Analysis* (Reading, Mass., 1977), p. 129.
8. (p. 189) Miloutine Borissavlièvitch, *The Golden Number and the Scientific Aesthetics of Architecture* (New York, 1958); Tons Brunés, *The Secrets of Ancient Geometry* (Copenhagen, 1967), vols. 1 and 2.
9. (p. 189) George D. Birkhoff, *Aesthetic Measure* (Cambridge, 1933), pp. 27–30.
10. (p. 190) Leonard Zusne, *Visual Perception of Form* (New York, 1970), ch. 10 — summary of the rectangle-preference literature.

Sidenote citations (uncounted margin notes): Minard portfolio, *Tableaux Graphiques et Cartes Figuratives de M. Minard, 1845–1869*, Bibliothèque de l'École Nationale des Ponts et Chaussées, Paris (p. 177); *Atlas of Israel*, Department of Surveys, Ministry of Labour (Jerusalem, 1956–), vol. 8, p. 8 (p. 178); *New York Times*, November 9, 1980, p. A-28 (p. 179); *New York Times*, January 2, 1979, p. D-3 (p. 180); Leonardo da Vinci, *Treatise on Painting* [Codex Urbinas Latinus 1270], vol. 2, facsimile (Princeton, 1956), p. 234, paragraph 827 (p. 182); Karlheinz Stockhausen, *Texte*, vol. 2 (Cologne, 1964), p. 82, from the score of "Zyklus für einen Schlagzeuger" (p. 184); Edward R. Tufte, "The Relationship Between Seats and Votes in Two-Party Systems," *American Political Science Review*, 67 (June 1973), 551 (p. 184); poster for "Mondrian and Neo-Plasticism in America," Yale University Art Gallery, October 18–December 2, 1979; original painting 1941 by Burgoyne Diller; Nancy J. Troy, *Mondrian and Neo-Plasticism in America* (New Haven, 1979), p. 28 (p. 185).

## Terms of art introduced or fixed in this chapter

- **Graphical elegance**: "simplicity of design and complexity of data" (p. 177).
- **Text-table**: type arranged to align numbers for comparison, replacing a number-laden sentence (p. 178).
- **Supertable**: an elaborate, ruled, story-ordered table supporting many localized comparisons; "one supertable is far better than a hundred little bar charts" (p. 179).
- **Data/text integration**: "Data graphics are paragraphs about data and should be treated as such" (p. 181).
- **Friendly data graphic**: a graphic "particularly accessible and open to the eye, as if the designer had the viewer in mind at every turn while constructing the graphic" (p. 183).
- **Floating snake**: a thin, unanchored time-series line, contrasted with a shaded high-contrast silhouette (p. 187).
- **Golden Section / Golden Rectangle**: the "venerable . . . but dubious" divine division, a/b = b/(a+b), giving 1.618. . . (p. 189).
- **The revelation of the complex**: the book's closing statement of the designer's task (p. 191).
