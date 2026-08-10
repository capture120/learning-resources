# Chapter 5 — Chartjunk: Vibrations, Grids, and Ducks (Detailed Reference)

Printed pages 107-121, with an opening epigraph page (p. 106) and a closing epigraph page (p. 122). This chapter is the third of the book's Part II, "Theory of Data Graphics" (the running head on even pages). Where Chapter 4 built the quantitative apparatus (data-ink, the data-ink ratio, erasing principles), Chapter 5 applies that apparatus as a field guide: it names, classifies, and empirically measures the most common species of useless graphical ink, and ends with an outright prohibition. Chapter 6 then turns from prohibition to construction (deriving new graphical forms from data-ink maximization).

## Opening Epigraph (p. 106)

The chapter is prefaced by three lines of verse from Jonathan Swift, identified beneath the lines as his indictment of seventeenth-century cartographers. The verse mocks mapmakers who, lacking real geographic knowledge, filled the empty regions of their maps with pictures of savages, and who drew elephants across uninhabitable terrain because they had no towns to record. The epigraph states the chapter's thesis in miniature: decoration is what designers reach for when they lack data, and ornamental filler occupies exactly the space that evidence should.

## The Nature and Sources of Chartjunk (p. 107)

The chapter opens with a definition by function: the interior decoration of graphics produces a great deal of ink that tells the viewer nothing new (p. 107). Tufte lists the motives behind decoration — to make a graphic look more scientific and precise, to liven up the display, to give the designer a chance to show off artistic skill — and then declares the motives irrelevant: whatever its cause, decoration is all non-data-ink or redundant data-ink (the two categories targeted for erasure in Chapter 4), and it is frequently **chartjunk** (p. 107). He adds an economic observation: graphical decoration thrives in technical publications as much as in commercial and media graphics, because decorating is cheaper than the hard work of producing interesting numbers and sound evidence (p. 107).

Tufte then anticipates and answers the first defense of decoration (p. 107). Sometimes decoration is justified as the artist's fundamental design contribution — as a way of capturing the essential spirit of the data — so that principles of artistic integrity and creativity get invoked to defend, and even to promote, chartjunk. His reply is dismissive: there are better ways to portray spirits and essences than entangling them with statistical graphics (p. 107).

He immediately deflates the artistic framing further: most chartjunk involves no artistic consideration at all (p. 107). It is simply the conventional graphical paraphernalia routinely attached to every passing display:

- over-busy grid lines and excess tick marks;
- redundant representations of the simplest data;
- the debris of computer plotting;
- the many devices that generate design variation (the vocabulary of Chapter 4's data-variation versus design-variation distinction).

The chapter's plan (p. 107): like weeds, chartjunk comes in many varieties, and three widespread types found in scientific and technical research work are catalogued here — **unintentional optical art**, **the dreaded grid**, and **the self-promoting graphical duck**. Tufte notes a deliberate methodological choice: he has passed over a hundred available chartjunky examples from commercial and media graphics, precisely so that the critique cannot be brushed off as aimed at journalism — every indicted example comes from the professional scientific production of data graphics (p. 107).

## Unintentional Optical Art: Moiré Vibration (pp. 107-112)

### The optical mechanism (pp. 107-108)

The section begins with a perceptual explanation: contemporary optical art relies on moiré effects, in which the printed design interacts with the physiological tremor of the eye to produce a distracting appearance of vibration and movement (p. 107). Crucially, the effect is not confined to the inked region — it spreads beyond the design's ink to the whole page (p. 108).

**Figure (p. 108, top):** a wide rectangular band of dense, closely spaced diagonal black-and-white stripes, printed without caption, so the reader directly experiences the shimmer being described.

Tufte concedes the effect's artistic legitimacy in the right hands: when exploited by experts such as Bridget Riley and Victor Vasarely, op art effects are genuinely eye-catching (p. 108). But statistical graphics are also often drawn so that they shimmer, and there the verdict is categorical: this moiré vibration is probably the most common form of graphical clutter, and it is inevitably both bad art and bad data graphics, because the optical noise clouds the flow of information (p. 108).

### First exhibit: the Brazilian cotton-textiles poster (p. 108)

**Figure (p. 108, bottom):** a full statistical poster titled "Tecidos de Algodão" (Cotton Textiles), from the Instituto de Expansão Commercial, *Brasil: Graphicos Economicos-Estatisticas* (Rio de Janeiro, 1929), p. 15 (source given in the sidenote). The page is a dashboard of cotton-industry statistics, trilingual in Portuguese, French, and English (the title carries the glosses "Cotonnades" and "Cotton Textiles," and the panel headings likewise gloss each Portuguese label in French and English — e.g., "Fabriques de Tissus"/"Cotton Factories"): a large central ring (donut) chart labeled 1927 shows fabric production in meters divided among Brazilian states (Alagoas, Bahia, Ceará, and others), each wedge filled with a different bold pattern — stripes of varying angle, checkerboards, dotted grids, some printed in red and green. Around it sit panel charts: counts of cotton factories ("Fabricas de Tecidos") as striped bars for 1924-1927; factory capital ("Capitaes das Fabricas," in contos de réis) as tall diagonal-striped bars; fabric production ("Producção de Tecidos," in meters) as checkerboard bars; taxes on consumed fabrics ("Impostos de Consumo Tecidos"); legends with colored squares for shuttles ("fuzos") and looms ("teares"); and along the bottom a long row of small grouped bars showing imports ("Importação") year by year from 1913 to 1927. Every single area is filled with a competing high-contrast pattern. The poster serves as the opening specimen of a technical/statistical publication drawn up to shimmer: the riot of hatchings makes the whole sheet vibrate and buries the data (p. 108).

### Bad graphics in major scientific journals (p. 109)

Tufte's framing sentence for this page: here, content that should have been simple tables was instead turned into bad graphics published in major scientific journals (p. 109).

**Figure (p. 109, top):** a three-dimensional pyramid chart reproduced from Nicholas T. Kouchoukos et al., "Replacement of the Aortic Root with a Pulmonary Autograft in Children and Young Adults with Aortic-Valve Disease," *The New England Journal of Medicine*, 330 (January 6, 1994), p. 4 (sidenote citation). The original's own caption identifies it as Figure 2, serial echocardiographic assessments of the severity of regurgitation in the pulmonary autograft in 31 patients, with numerical severity grades: 0 = none; 0.5 = trivial; 1.0 to 1.5 = mild; 2.0 = moderate; 3.0 = severe. The vertical axis ("Severity of Aortic Regurgitation") runs 0.0 to 2.0, duplicated on both sides; the horizontal axis ("Months after Operation") has nine bins: <1, 1-6, 7-12, 13-18, 19-24, 25-30, 31-36, 37-42, 43-48. Each patient-measurement is a horizontally hatched pyramid standing on one of several planes receding in fake depth, the planes ruled with vertical grid lines.

Tufte's diagnosis (p. 109): the chart is a duck moiré carrying an unintentional **Necker Illusion** — the two back planes optically flip to the front, the way the ambiguous Necker cube reverses. Some pyramids hide behind others, so data are literally concealed. And one entire plotted variable — the stacked depth dimension of the pyramids, which he derides as stupid — has no label and no scale. The reader learns almost nothing about the data.

**Figures (p. 109, bottom):** two further published bar charts, shown side by side with their sidenote citations:

- Eain M. Cornford and Marie E. Huot, "Glucose Transfer from Male to Female Schistosomes," *Science*, 213 (September 11, 1981), p. 1270 — a panel labeled "A" plotting [14C]glucose in *S. mansoni* (axis unit printed as "TUI") on a vertical axis running roughly 10 to 70, against doses 0, 0.5, 1, 2, 3 on the horizontal, as pairs of bars (one cross-hatched, one open) with long error bars.
- James T. Kuznicki and N. Bruce McCutcheon, "Cross-Enhancement of the Sour Taste on Single Human Taste Papillae," *Journal of Experimental Psychology: General*, 108 (1979), p. 76 — stacked panels of evenly spaced open bars (axes marked roughly 2 through 12), significant bars flagged with asterisks.

Tufte's lesson from these (p. 109): the displays teach very little about the data, but they do yield one perceptual discovery — moiré vibration may well be at a maximum for equally spaced bars. Uniform spacing, the default of every bar-chart routine, is precisely the geometry that vibrates worst.

### The JASA style sheet (p. 110)

The indictment escalates from individual papers to official editorial guidance. **Figure (p. 110):** a histogram reproduced from the style sheet once issued by the *Journal of the American Statistical Association*, where it was described as "an example of a figure prepared in the proper form" (Tufte quotes this short phrase; the citation sidenote reads "JASA Style Sheet," *Journal of the American Statistical Association*, 71 (March 1976), 260-261). The figure is titled "A. Average Probabilities of W from N(1,1) with n = 10"; its vertical axis ("AVERAGE PROBABILITY") is labeled 0.05, 0.10, 0.15, and its horizontal axis runs 0 to 15 (ending in an arrow labeled ω). The distribution is drawn as a dense forest of thin vertical strokes forming a decaying histogram.

Tufte's audit (p. 110): the display needed 131 line-strokes plus 15 digits to communicate its simple information, and the vibrating lines are poorly drawn, unevenly spaced, and misaligned with the vertical axis. The official model of proper form is itself vibrating chartjunk.

### Survey 1: moiré vibration in the ten most-cited journals (p. 110)

To show that vibrating chartjunk frequents the graphics of major scientific journals, Tufte presents a content-analysis table: for each of the ten most frequently cited (i.e., most footnoted) scientific journals, a random sample of issues published 1980-1982 was examined and the percentage of graphics exhibiting moiré vibration recorded (p. 110). The table in full:

| The ten most frequently cited (footnoted) scientific journals: random sample of issues published 1980-1982 | Percentage of graphics with moiré vibration | Number of graphics in sample |
|---|---|---|
| *Biochemistry* | 2% | 568 |
| *Journal of Biological Chemistry* | 2% | 565 |
| *Journal of the American Chemical Society* | 3% | 317 |
| *Journal of Chemical Physics* | 6% | 327 |
| *Biochimica et Biophysica Acta* | 8% | 432 |
| *Nature* | 11% | 225 |
| *Proceedings of the National Academy of Sciences, U.S.A.* | 12% | 438 |
| *Lancet* | 15% | 364 |
| *Science* | 17% | 311 |
| *New England Journal of Medicine* | 21% | 338 |

The chemistry journals are cleanest (2-8%); the general-science and especially the medical journals are worst, with more than one graphic in five in the *New England Journal of Medicine* vibrating.

### The pattern catalog and two prescriptions (p. 111)

Tufte traces the technology of the problem (p. 111): moiré effects have proliferated with computer graphics (he names Excel as an example program in this second-edition text). The patterns were once produced by hand with thin plastic transfer sheets; now the computer generates instant chartjunk.

**Figure (p. 111):** a full-page specimen sheet displaying dozens of fill patterns in horizontal bands — checkerboards of several densities, large and small polka dots, diagonal hatching at various angles and weights, fine grids, wavy lines, herringbone, cross-hatch diamonds, brick-like patterns, vertical and horizontal rules of varying pitch, concentric arcs, and heavy rope-like diagonal bands — presented as merely a few of the many vibrating possibilities (p. 111).

Around this figure Tufte states the section's two operational rules (p. 111):

1. Cross-hatching should be replaced with tint screens of shades of gray.
2. Specific areas on a graphic should be labeled with words rather than encoded with hatching (which would then require legend-decoding).

He also fixes the phenomenon historically: this form of chartjunk is a twentieth-century innovation, and computer graphics are multiplying it more than ever (p. 111).

### Survey 2: the textbooks and manuals themselves (pp. 111-112)

The argument's next step: the contamination is not just downstream in journals — the handbooks and textbooks of statistical graphics, together with user's manuals for computer graphics programs, are themselves full of vibrating graphics presented as exemplars of design (p. 111). Tufte directs attention to two patterns in the data: the proportion of chartjunky graphics is higher in the more recent publications, and computer-graphics manuals are particularly active (p. 112). The table, ordered by date of publication (p. 112):

| Textbooks and handbooks of statistical graphics; and manuals for computer graphics programs (ordered by date of publication) | Percentage of graphics with moiré vibration | Total number of graphics |
|---|---|---|
| Willard C. Brinton, *Graphic Methods for Presenting Facts* (New York, 1914) | 12% | 255 |
| R. Satet, *Les Graphiques* (Paris, 1932) | 29% | 28 |
| Herbert Arkin and Raymond R. Colton, *Graphs: How to Make and Use Them* (New York, 1936) | 17% | 95 |
| Mary Eleanor Spear, *Charting Statistics* (New York, 1952) | 46% | 134 |
| Anna C. Rogers, *Graphic Charts Handbook* (Washington, D.C., 1961) | 32% | 201 |
| F. J. Monkhouse and H. R. Wilkinson, *Maps and Diagrams* (London, third edition, 1971) | 14% | 322 |
| Calvin F. Schmid and Stanton E. Schmid, *Handbook of Graphic Presentation* (New York, second edition, 1979) | 22% | 399 |
| A. J. MacGregor, *Graphics Simplified* (Toronto, 1979) | 34% | 65 |
| The user's manual for a widely distributed computer graphics package: *SAS/GRAPH User's Guide* (Cary, North Carolina, 1980) | 68% | 28 |
| The manual for a very extensive computer graphics program: *Tell-A-Graf User's Manual* (San Diego, 1981) | 53% | 459 |

The two computer-package manuals top the list at 68% and 53%, supporting the claim that automation has accelerated rather than cured the problem.

### The Bertin objection: can optical effects ever help? (p. 112)

Tufte then raises the strongest available counterargument: could optical-art effects ever produce a better graphic? He cites Jacques Bertin's exhortation that the designer has a duty to exploit this variation — to capture the resonance of moiré vibration without producing an uncomfortable sensation, to "flirt with ambiguity" without giving in to it (p. 112). The footnote (numbered 1) cites Jacques Bertin, *Semiology of Graphics: Diagrams, Networks, Maps* (Madison, Wisconsin, 1983, translated by William J. Berg), p. 80, noting that this is the English translation of Bertin's important work *Sémiologie graphique* (Paris, 1967).

Tufte's rebuttal proceeds in two moves (p. 112). First, empirically: it is a clever idea, but no good examples can be found. Second, in principle: the key difficulty is that moiré vibration is an *undisciplined* ambiguity — its illusive, eye-straining quality is not confined to a designed accent but contaminates the entire graphic. Verdict: it has no place in data graphical design.

## The Grid (pp. 112-116)

### The principle (pp. 112-113)

The grid is introduced as one of the more sedate graphical elements, but the rule is firm: the grid should usually be muted or suppressed entirely, so that its presence is only implicit, lest it compete with the data (p. 112). Grids belong to the production stage — they are mostly for the initial plotting of data at home or office, not for putting into print (pp. 112-113). Dark grid lines are chartjunk by the chapter's definition: they carry no information, they clutter the graphic, and they generate graphic activity unrelated to the data's information (p. 113).

### Exhibit: the age-sex pyramid of France, 1967 (p. 113)

**Figure (p. 113, top):** a population pyramid titled "Population of France, by Age and Sex: January 1, 1967." Males occupy the left half, females the right; the central vertical axis gives age (0 to 100 in 5-year ticks), both outer vertical axes give year of birth (1866 down to 1966), and the horizontal axes give population in thousands (500 to 0 leftward for males, 0 to 500 rightward for females). The whole field is overlaid with a heavy rectangular grid of dark vertical and horizontal rules. Lettered arrows annotate historical scars on the profile, keyed in a sidenote list:

- (a) military losses in World War I;
- (b) deficit of births during World War I;
- (c) military losses in World War II;
- (d) deficit of births in World War II;
- (e) rise of births due to demobilization after World War II.

Tufte's point: this grid camouflages the very profile of the data (p. 113) — the dramatic notches and bulges that the lettered arrows struggle to point out are exactly what the dark grid hides.

**Figure (p. 113, bottom):** Tufte's revision, which quiets the grid and gives the emphasis back to the data (p. 113). The redrawing removes the outer frame, axis clutter, and labels, and prints a light grid only *inside* the data silhouette, so the pyramid's two facing profiles — with the war notches now strikingly visible — stand as the dominant visual fact. Sidenote citation: based on data in Institut National de la Statistique et des Études Économiques, *Annuaire statistique de la France, 1968* (Paris, 1968), pp. 32-33; redrawn in Henry S. Shryock and Jacob S. Siegel, *The Methods and Materials of Demography* (Washington, D.C., 1973), vol. 1, p. 242.

### Exhibit: the Tukey and Tukey multiwindow plot (p. 114)

This example shows that even excellent, ingenious designs can carry grid chartjunk. **Figure (p. 114, left):** a display titled "MULTIWINDOW PLOT OF PARTICLE PHYSICS MOMENTUM DATA," from Paul A. Tukey and John W. Tukey, "Data-Driven View Selection; Agglomeration and Sharpening," in Vic Barnett, ed., *Interpreting Multivariate Data* (Chichester, England, 1981), pp. 231-232 (sidenote citation). Tufte calls it a "multiwindow plot" and a most ingenious design, and explains its structure parenthetically (p. 114): the large central square holds a matrix of small X4-versus-X7 scatterplots, each for an indicated level of X1 (horizontal, log scale labeled −0.4 to 3.0 with ticks at 0, 0.6, 1.2, 1.8, 2.4, 3.0) and X3 (vertical, labeled 0.2 to 3.2 with ticks at 0.2, 0.7, 1.2, 1.7, 2.2, 2.7, 3.2); the marginal plots along the right edge are conditioned on X3 alone; the plots along the top are conditioned on X1 alone; and the upper right corner shows the unconditional X4, X7 scatter.

The flaw: every window is framed by doubled grid lines, and this doubled grid consumes 18 percent of the design's total area (p. 114). Worse, optical white dots *appear* at the intersections of the grid lines — an illusion (the scintillating-grid family of effects) created by the line crossings, not by any ink. **Figure (p. 114, right):** Tufte's redrawing, which keeps every scatterplot in place but deletes the doubled frames, leaving only faint single outlines; the redrawing eliminates the vibration (p. 114).

### Exhibit: Marey's train schedule, three grid treatments (pp. 115-116)

The classic Marey graphical train schedule (Paris-Lyon; introduced in Chapter 2 of the book) becomes a test bed for grid weight. The schedule plots each train as a diagonal line in a space of stations (vertical, spaced proportionally to distance: Paris, Moret-Montereau, Laroche, Tonnerre, Nuits-sous-Ravières, Les Laumes, Dijon, Chagny, Chalon-sur-Saône, Mâcon, St-Germain-au-Mont-d'Or, Lyon-Perrache) against time of day (horizontal, hours 6 a.m. through noon, "MIDI," through midnight, "MINUIT," back to 6).

- **Figure (p. 115, top):** the original. Its grid of closely spaced dark vertical time-rules is very active (p. 115) — the dense verticals compete with and nearly drown the diagonal train lines.
- **Figure (p. 115, bottom):** the same schedule with thinned grid lines. Tufte's assessment: thinning helps a little bit (p. 115).
- **Figure (p. 116, top):** the same schedule with a **gray grid**. This, he says, is the better treatment (p. 116): the grid recedes to a background tone and the train paths dominate.

### The look-up exception and graph-paper advice (p. 116)

Tufte then states the legitimate use case: when a graphic serves as a look-up table — as the Marey schedule literally does — a grid may genuinely help in reading and interpolating values (p. 116). But even then the grid should be muted relative to the data. A gray grid works well, and drawn with a delicate line it may actually promote more accurate data reconstruction than a dark grid (p. 116) — muting is not merely aesthetic; it can improve the precision of reading.

The section closes with practical, almost domestic advice (p. 116): most ready-made graph paper is printed with a dark grid. Plot on the reverse, unprinted side, where the grid shows through faintly and does not clutter the data. And if the paper is heavily gridded on both sides, throw it out.

## Self-Promoting Graphics: The Duck (pp. 116-121)

### Definition and naming (p. 116)

The third species gets a three-part definition (p. 116): when a graphic is taken over by decorative forms or computer debris, when the data measures and structures become Design Elements, when the overall design purveys Graphical Style rather than quantitative information — then that graphic may be called a **duck**. (Tufte capitalizes "Design Elements" and "Graphical Style" mockingly, as pretensions.) The name honors the duck-form store called the "Big Duck": in that building the whole structure is itself decoration, exactly as in a duck data graphic (p. 116).

### The architecture argument: Venturi, Ruskin, Pugin (pp. 116-117)

Tufte imports the concept from architectural criticism. In *Learning from Las Vegas*, Robert Venturi, Denise Scott Brown, and Steven Izenour discuss the ducks of modern architecture, and Tufte says their reflections apply to data-graphic design as well (pp. 116-117). Their argument, given in an indented quotation that Tufte reproduces (paraphrased here, p. 117): when Modern architects righteously renounced ornament on buildings, they unknowingly began designing buildings that *were* ornament; by exalting Space and Articulation over symbolism and applied decoration, they distorted the entire building into a duck. They traded the innocent, inexpensive practice of applying decoration to a conventional shed for the rather cynical and expensive distortion of a building's program and structure in order to promote a duck. The passage ends by calling for a reevaluation of John Ruskin's once-shocking claim that architecture is the decoration of construction — amended by Pugin's warning that decorating construction is acceptable, but constructing decoration never is.

Footnote 2 (p. 117) cites Robert Venturi, Denise Scott Brown, and Steven Izenour, *Learning from Las Vegas* (Cambridge, revised edition, 1977), p. 163, and notes that the initial statement of the duck concept appears on pp. 87-103 of that book.

**Figure (p. 117):** a color photograph of the Big Duck itself — a white, duck-shaped building with a yellow bill and a doorway cut into its breast, standing on grass before a line of trees. Sidenote: Big Duck, Flanders, New York; photograph by Edward Tufte, July 2000. (The photo is Tufte's own, added for the second edition.)

Pugin's maxim, transferred to graphics, becomes the section's operating rule: decorate the data's construction if you must, but never let the construction itself be the decoration.

### Fake perspective and Boutique Data Graphics (p. 118)

A particular duck genre: adding fake perspective (false third dimensions) to the data structure clutters many graphics (p. 118). Tufte labels this variety, then at high fashion, the world of "Boutique Data Graphics," and locates its habitats: corporate annual reports, the phony statistical studies presented in advertisements, the mass media, and the more muddled sorts of social science research (p. 118).

### Exhibit: the worst graphic ever printed (p. 118)

A series of weird three-dimensional displays that ran in the magazine *American Education* during the 1970s, Tufte says, delighted connoisseurs of the graphically preposterous (p. 118). He reproduces one and renders the famous verdict that it may well be the worst graphic ever to find its way into print (p. 118).

**Figure (p. 118):** titled "AGE STRUCTURE OF COLLEGE ENROLLMENT," vertical axis "Percent of total enrollment," horizontal axis years 1972-1976. The vertical axis is broken (a zigzag) into two segments: 66-72 percent for the "UNDER 25" share (upper panel) and 28-34 percent for the "25 AND OVER" share (lower panel). Each share is drawn as a thick, flowing, pseudo-three-dimensional colored ribbon: the under-25 ribbon in green sweeping down across a yellow field, the 25-and-over ribbon in blue rising across a red field. Printed value labels: under 25 — 72.0 (1972), 70.8 (1973), 67.2 (1974), 66.4 (1975), 67.0 (1976); 25 and over — 28.0 (1972), 29.2 (1973), 32.8 (1974), 33.6 (1975), 33.0 (1976).

Tufte's arithmetic of futility (p. 118): five colors report, almost by happenstance, only five pieces of data — because the two age shares within each year sum to 100 percent, the lower panel is fully determined by the upper one. (Check: 72.0+28.0, 70.8+29.2, 67.2+32.8, 66.4+33.6, 67.0+33.0 each equal 100.) An elaborate two-panel, five-color, fake-3D construction encodes five numbers.

### Exhibit: the superbly produced duck (p. 119)

Tufte then concedes — and the concession sharpens the definition — that some ducks are superbly produced (p. 119). **Figure (p. 119, full page, color):** "Applied Irrigation Water 1972," from William L. Kahrl, et al., *The California Water Atlas* (Sacramento, 1978, 1979), p. 55 (sidenote citation). A handsome shaded-relief map of California carries, positioned over each hydrologic basin area (North Coastal, North Lahontan, Sacramento Basin, Delta-Central Sierra, San Francisco Bay, San Joaquin Basin, Central Coastal, Tulare Basin, South Lahontan, South Coastal, Colorado Desert), a square grid of small colored blocks stacked in rows by crop type. The legend lists thirteen crop types, each with a color: pasture, meadow pasture, alfalfa, grain, miscellaneous field, rice, cotton, deciduous orchard, subtropical orchard, miscellaneous truck, sugar beets, tomatoes, grapes. Each block represents 5,000 acre-feet of water applied to that crop type, and a printed number beneath each grid gives the basin's total acre-feet of applied irrigation water (the legend uses 707,000 — North Coastal's total — as its example; other legible totals include San Francisco Bay 243,000, South Lahontan 306,000, North Lahontan 420,000, South Coastal 922,000, Central Coastal 1,025,000, Delta-Central Sierra 2,474,000, and Colorado Desert 3,217,000, with the largest grids over the Sacramento, San Joaquin, and Tulare basins running into the millions). A scale bar in miles and kilometers sits at lower left.

The point of including it: beautiful production values do not redeem the form. The map remains a duck — its block-grid construction is itself the decoration — even though it is gorgeous. Craftsmanship and chartjunk are independent dimensions.

### The We-Used-A-Computer-To-Build-A-Duck Syndrome (p. 120)

The final duck genre is technological self-congratulation. Occasionally, Tufte observes, designers seem to seek credit merely for possessing a new technology rather than for using it to make better designs (p. 120). He is careful not to indict the technology: computers and their affiliated apparatus can do powerful things graphically — in part by turning out the hundreds of plots necessary for good data analysis (p. 120). But at least a few computer graphics provoke only admiration that a computer could be programmed to draw that way, instead of interest in the data themselves (p. 120).

**Figure (p. 120):** a computer-drawn bar chart from Arthur H. Miller, Edie N. Goldenberg, and Lutz Erbring, "Type-Set Politics: Impact of Newspapers on Public Confidence," *American Political Science Review*, 73 (1979), pp. 67-84 (sidenote citation). Vertical axis "PERCENT CRITICAL ARTICLES," labeled at every 5 from 0 to 60; horizontal axis "ISSUE AREAS" with nine cross-hatched bars labeled in staggered computer abbreviations (INF, UNEM, SHORT, RACE, CRIME, GOVTPOW, CONF, WATERG, COMP). A legend decodes the nine hatch patterns: INFLATION (N=415), UNEMPLOYMENT (N=100), SHORTAGES (N=68), RACE (N=103), CRIME (N=123), GOVT. POWER (N=154), CONFIDENCE (N=268 as printed in the crinkly legend; the table on p. 121 gives 266), WATERGATE (N=537), COMPETENCE (N=322). Bar heights run from roughly 13 percent (unemployment) to roughly 52 percent (confidence). Everything is set in cramped uppercase sans serif machine lettering.

Tufte names the disease — the symptoms of the We-Used-A-Computer-To-Build-A-Duck Syndrome — and lists them as they appear in this display from a professional journal (p. 120):

- thin substance (little actual information);
- clotted, crinkly lettering, all in upper-case sans serif;
- pointlessly ordered cross-hatching;
- labels written in computer abbreviations;
- optical vibration —

all of these being by-products of the technology of graphic fabrication rather than choices serving the data. He adds two further specific faults and their remedies (p. 120): the overly busy vertical scale shows more percentage markers and labels than there are data points — the observed values of the percentages should simply be printed instead; and since the information consists of a few numbers and a good many words, the right move is to pass up the computerized graphics capability this time and tell the story with a table.

### The table redesign (p. 121)

Tufte then supplies that table (p. 121), which carries all the chart's information plus the verbal detail of each issue area, sorted by number of articles in descending order:

| Content and tone of front-page articles in 94 U.S. newspapers, October and November, 1974 | Number of articles | Percent of articles with negative criticism of specific person or policy |
|---|---|---|
| Watergate: defendants and prosecutors, Ford's pardon of Nixon | 537 | 49% |
| Inflation, high cost of living | 415 | 28% |
| Government competence: costs, quality, salaries of public employees | 322 | 30% |
| Confidence in government: power of special interests, trust in political leaders, dishonesty in politics | 266 | 52% |
| Government power: regulation of business, secrecy, control of CIA and FBI | 154 | 42% |
| Crime | 123 | 30% |
| Race | 103 | 25% |
| Unemployment | 100 | 13% |
| Shortages: energy, food | 68 | 16% |

The redesign demonstrates the chapter's table doctrine in action: the rich category descriptions ("Watergate: defendants and prosecutors, Ford's pardon of Nixon") were impossible in the chart's abbreviation-labels, and the exact percentages replace bar-height guessing against an overdrawn scale.

## Conclusion (p. 121)

The conclusion argues that chartjunk fails even on its own terms — it does not achieve the goals of its propagators (p. 121). The overwhelming fact about data graphics is that they stand or fall on their content, gracefully displayed. Ornamental hatching and false perspective applied to a few bars do not make a graphic attractive or interesting. The asymmetry is stated as an aphorism: chartjunk can turn bores into disasters, but it can never rescue a thin data set (p. 121).

The positive counterpart: the best designs — Tufte lists Minard's map of Napoleon in Russia, Marey's graphical train schedule, the cancer maps, the *New York Times* weather history of New York City, the chronicle of the annual adventures of the Japanese beetle, and the new view of the galaxies (all shown earlier in the book) — are *intriguing and curiosity-provoking* (his italics), drawing viewers into the wonder of the data by three distinct routes: narrative power, immense detail, or the elegant presentation of simple but interesting data (p. 121). Chartjunk, by contrast, generates no information, no sense of discovery, no wonder, no substance (p. 121).

The chapter ends with its injunction set off in centered lines like verse (p. 121): forgo chartjunk — including moiré vibration, the grid, and the duck.

## Closing Epigraph: Ad Reinhardt (p. 122)

A facing page carries, in italics, a statement by the painter Ad Reinhardt written for the catalogue of the exhibition "The New Decade: 35 American Painters and Sculptors," Whitney Museum of American Art, New York, 1955. Paraphrased: Reinhardt describes painting as a special, separate matter of meditation and contemplation rather than physical action or social sport, demanding maximal consciousness; he affirms clarity, completeness, quintessence, and quiet, and renounces noise, mess, sentimentality, and wild expressionist fervor; he affirms perfection, passiveness, consonance, and consummateness, and renounces palpitation, gesticulation, and grotesquerie; he affirms spirituality, serenity, absoluteness, and coherence, and renounces automatism, accident, anxiety, catharsis, and chance; he closes with detachment, disinterestedness, thoughtfulness, and transcendence, and a final renunciation of humbug, button-holing, exploitation, and mixing things up. Placed at the chapter's end, the credo stands as Tufte's aesthetic ideal for data graphics: quiet, clear, complete, and free of every species of junk.

## Chapter Vocabulary and Rules (Consolidated)

Terms of art introduced or used in this chapter:

- **Chartjunk** — interior decoration of graphics; ink that tells the viewer nothing new; non-data-ink or redundant data-ink (p. 107).
- **Moiré vibration / unintentional optical art** — patterns interacting with the physiological tremor of the eye to produce apparent movement (pp. 107-108); maximal for equally spaced bars (p. 109); an undisciplined ambiguity (p. 112).
- **Necker Illusion** — spontaneous depth reversal in ambiguous 3D drawings; afflicts fake-perspective charts (p. 109).
- **The dreaded grid** — non-data rules that compete with data (pp. 112-116); legitimate only when muted, especially in look-up graphics (p. 116).
- **Duck / self-promoting graphic** — a graphic whose structure is itself decoration; data become Design Elements, design purveys Graphical Style (p. 116).
- **Boutique Data Graphics** — the fashion world of fake-perspective decorated charts (p. 118).
- **We-Used-A-Computer-To-Build-A-Duck Syndrome** — technology displayed for its own sake (p. 120).

Operational rules:

1. Replace cross-hatching with gray tint screens (p. 111).
2. Label areas directly with words, not pattern codes (p. 111).
3. Mute or suppress grids; if a grid must show (look-up use), make it thin and gray (pp. 112, 116).
4. Plot on the unprinted back of graph paper; discard double-sided gridded paper (p. 116).
5. Decorate construction if you like, but never construct decoration (Pugin via Venturi, p. 117).
6. Never add more axis markers and labels than there are data points; print the observed values instead (p. 120).
7. For a few numbers and many words, use a table, not a graphic (p. 120).
8. Forgo chartjunk: moiré vibration, the grid, and the duck (p. 121).
