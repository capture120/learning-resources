# Chapter 2: Graphical Integrity

A graphic tells the truth when its visual representation is consistent with its numerical representation. Tufte argues that graphical lies are common, systematic, and nearly always exaggerate the rate of recent change — and he gives concrete, measurable rules (above all the Lie Factor and six principles) for detecting and avoiding distortion. "Graphical excellence begins with telling the truth about the data" (p. 53).

## Framing: Graphics and Lying (p. 53)

- Graphics are no more inherently deceptive than words; any means of communication can be used to deceive. Most viewers have "pretty good graphical lie detectors."
- Two fruitless doctrines dominated 1930–1970: (1) graphics must be "alive," overdecorated, and exaggerated to hold a dull audience; (2) the main task of graphical analysis is detecting and denouncing deception. Both assume graphics are devices for showing the obvious to the ignorant — "It is hard to imagine any doctrine more likely to stifle intellectual progress in a field" (p. 53).
- John Tukey (late 1960s) made graphics respectable by using them as instruments for reasoning about quantitative information — serious data analysis, not decoration or lie-policing.
- Actionable stance: design graphics as tools for reasoning, but still confront and demolish deception when it appears.

## What is Distortion in a Data Graphic? (pp. 55–56)

- Definition: "A graphic does not distort if the visual representation of the data is consistent with the numerical representation" (p. 55).
- The complication: is the "visual representation" what is physically measured on the surface, or the *perceived* visual effect? Perception experiments find only approximate power laws, e.g. reported perceived area of a circle = (actual area)^x, where x = .8 ± .3 — a discouraging result (p. 55).
- Perception varies between people, changes with experience, and is context-dependent; even reported line length depends on what other people have already said about the lines (Asch's conformity experiments) (p. 56).
- Practical consequences:
  - For small data sets (about 20 numbers or less), use a table — tables usually outperform graphics. The special power of graphics is in displaying large data sets (p. 56).
  - Since perceivers cannot be standardized, aim for uniformity in the graphics themselves so perceivers have a fair chance of getting the numbers right.
- Two principles that enhance graphical integrity (p. 56):
  1. "The representation of numbers, as physically measured on the surface of the graphic itself, should be directly proportional to the numerical quantities represented."
  2. "Clear, detailed, and thorough labeling should be used to defeat graphical distortion and ambiguity. Write out explanations of the data on the graphic itself. Label important events in the data."

## The Lie Factor (pp. 57–58)

- Definition (p. 57):

  Lie Factor = (size of effect shown in graphic) / (size of effect in data)

- Size of effect is computed as percentage change: (second value − first value) / first value × 100.
- Interpretation:
  - Lie Factor = 1: the graphic may be doing a reasonable job of representing the numbers.
  - Lie Factor > 1.05 or < 0.95: substantial distortion, far beyond minor plotting inaccuracy.
  - Take the logarithm to compare overstating (log LF > 0) with understating (log LF < 0) on an equal footing.
  - In practice almost all distortions overstate; Lie Factors of two to five are not uncommon (p. 57). The chapter documents LFs of 2.8, 9.4, 9.5, 14.8, and 59.4.
- Worked example (fuel economy chart, pp. 57–58): data change 53% shown by lines that change 783%, so Lie Factor = 783/53 = 14.8 — "which is too big."
- Perspective compounds the lie: decorative perspective mixes the change in data values with the change due to perspective, and "viewers have no chance of separating the two" (p. 58). Avoid perspective on data measures.

## Decoration versus Distortion (p. 59)

- It is easy to decorate data without lying — decoration can even editorialize about the substance of the graphic.
- But it is wrong to distort the data measures — the ink locating values of numbers — to make an editorial comment or fit a decorative scheme. Doing so is "a sure sign of the Graphical Hack at work" (p. 59).
- Honest redesigns also add value beyond honesty: the corrected fuel-economy chart added context (actual on-road mileage) and revealed the data's hidden story (gradual start, doubled rate of improvement 1980–1983, then flattening) (pp. 58–59).

## Design and Data Variation (pp. 60–63)

- Each part of a graphic generates visual expectations about its other parts; these expectations often determine what the eye sees. "Deception results from the incorrect extrapolation of visual expectations generated at one place on the graphic to other places" (p. 60).
- A scale moving in regular intervals is expected to continue consistently to the end. Changing interval size mid-axis (e.g. seven 10-year intervals followed by one 4-year interval) manufactures fake trends (p. 60).
- The confounding of design variation with data variation leads to ambiguity and deception, for the eye may mix up changes in the design with changes in the data. "A steady canvas makes for a clearer picture" (p. 61).
- The principle (p. 61): "Show data variation, not design variation."
- Design variation means the graphic's own scales or encodings change across its surface, so the eye cannot tell data change from design change. When vertical and horizontal scales shift simultaneously, distortion takes on multiplicative force — the same quantity can be drawn 15.1 times larger depending on where it falls on the graphic (p. 61).
- Money over time: "The only way to think clearly about money over time is to make comparisons using inflation-adjusted units of money" (p. 63). Plotting nominal (current) dollars is itself design variation, because the value of the money unit changes across the years shown (pp. 62–63).
- Distortion also hides news: the decorated OPEC price chart missed that the real price of oil had *declined* in the four years before the 1979–80 increases (p. 63).

## The Case of Skyrocketing Government Spending (pp. 64–68)

- The government spending/debt display is "probably the most frequently printed graphic, other than the daily weather map and stock-market trend line" (p. 65) — and these arrays nearly always create an impression of rapid increase. The standard tricks: nominal (undeflated) money, no adjustment for population growth, and a tall, thin shape that emphasizes vertical climb (pp. 65–66).
- Aspect ratio is rhetorical: Playfair drew fewer than one-tenth of his ~90 graphics taller than wide; he chose the tall shape precisely when he wanted to emphasize rapid growth (p. 65). A spending chart 2.7 times taller than wide "helps its political point along" (p. 66).
- Layered graphical gimmicks (the New York State budget chart, pp. 66–67) all push the same direction: optical front plane for recent bars, stretched type at the small early value, squeezed type for old budgets, vertical arrows on recent years.
- Statistical lapses bias charts as much as visual tricks: ignoring population growth (here 10%) and inflation (here $1.00 in 1967 = $2.03 in 1977) mixes changes in the value of money with changes in the budget (p. 68).
- Application of simple arithmetic — constant (real) dollars per capita — can reverse the apparent story entirely (p. 68).
- The principle (p. 68): "In time-series displays of money, deflated and standardized units of monetary measurement are nearly always better than nominal units."

## Visual Area and Numerical Measure (pp. 69–73)

- Using areas (or volumes) to show one-dimensional data confuses data variation with design variation (p. 69).
- The classic error: varying both dimensions of a drawn object in response to a one-dimensional change, so the area changes as the square of the data — e.g. the shrinking-dollar fallacy for inflation charts (p. 70).
- Perception makes it worse: changes in physical area do not reliably produce proportional changes in perceived area, and the problem worsens when areas are "tricked up into three dimensions" (p. 71). Volume encodings can produce record Lie Factors (59.4 for the 3-D oil barrels, p. 71).
- Conclusion: "The use of two (or three) varying dimensions to show one-dimensional data is a weak and inefficient technique, capable of handling only very small data sets, often with error in design and ambiguity in perception" (p. 71).
- The principle (p. 71): "The number of information-carrying (variable) dimensions depicted should not exceed the number of dimensions in the data."
- Two-dimensional encodings are acceptable when the data are genuinely two-dimensional and multiply meaningfully (Gabaglio: books issued × average deposit = total deposits, p. 72). Cartoon-like graphics may be exempt from the principle (p. 73).

## Context is Essential for Graphical Integrity (pp. 74–75)

- "To be truthful and revealing, data graphics must bear on the question at the heart of quantitative thinking: 'Compared to what?'" (p. 74).
- "The emaciated, data-thin design should always provoke suspicion, for graphics often lie by omission, leaving out data sufficient for comparisons" (p. 74).
- The principle (p. 74): "Graphics must not quote data out of context."
- Actionable tests: show enough of the time series that the highlighted change can be judged against normal variation; show comparison groups (e.g. adjacent states) so the viewer can tell whether the effect is specific to the case at hand (p. 75).

## Conclusion: How Graphics Lie, and the Two Bad Defenses (pp. 76–77)

- Published lies multiply: a lying TV chart lies tens of millions of times; a lying New York Times chart lies 900,000 times to influential readers, about major public-policy issues (p. 76).
- "The lies are systematic and quite predictable, nearly always exaggerating the rate of recent change" (p. 76).
- Defense 1 ("at least it was approximately correct; we were just showing the general direction of change") fails twice: many of the chapter's deceptions were fifteenfold lies, far too large to count as approximately correct, and several falsified the real news in the data, failing even "the most lax of standards" (p. 76). More fundamentally, numbers have magnitude as well as order; numbers measure *quantity*. Getting only direction right is "the philosophy that informs the Pravda School of Ordinal Graphics," where "every chart has a crystal clear direction coupled with fantasy magnitudes" (p. 76).
- Defense 2 ("the correct numbers are printed on the graphic") fails: "It is as if not lying in one place justified fifteenfold lies elsewhere. Few writers would work under such a modest standard of integrity, and graphic designers should not either" (p. 77).

## The Six Principles of Graphical Integrity (p. 77)

Quoted verbatim — Tufte's summary of the chapter:

1. "The representation of numbers, as physically measured on the surface of the graphic itself, should be directly proportional to the numerical quantities represented."
2. "Clear, detailed, and thorough labeling should be used to defeat graphical distortion and ambiguity. Write out explanations of the data on the graphic itself. Label important events in the data."
3. "Show data variation, not design variation."
4. "In time-series displays of money, deflated and standardized units of monetary measurement are nearly always better than nominal units."
5. "The number of information-carrying (variable) dimensions depicted should not exceed the number of dimensions in the data."
6. "Graphics must not quote data out of context."
