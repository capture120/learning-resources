# Chapter 4 Examples: Data-Ink and Graphical Redesign

### Playfair's 1785 imports/exports chart vs. his 1786 redesign (pp. 91–92)

William Playfair's very first charts spent too much ink on graphical apparatus. His August 1785 time-series from *The Commercial and Political Atlas*, "Chart of Imports and Exports of England to and from all North America, 1770–1782," is dense with elaborate grid lines and detailed labels along the right edge. Within a year Playfair had eliminated much of the non-data detail; working with a new engraver, he produced the far cleaner 1786 chart of exports and imports to and from Denmark and Norway, 1700–1780, which focuses attention on the time-series itself: two curves with the shaded balance between them. Tufte uses Playfair's own improvement to introduce the fundamental principle — "Above all else show the data" — and calls it the basis for a theory of data graphics.

### Electroencephalogram tracks (p. 93)

Eight continuous tracks of an EEG (from Kenneth A. Kooi, *Fundamentals of Electroencephalography*, 1971) show brain activity changing from background activity to a series of polyspike bursts. Nothing in the graphic can be erased without losing information; nearly every drop of ink conveys measured quantities. Tufte's example of a data-ink ratio at or near 1.0 — the ideal limit of the data-ink concept.

### Bonner's size-and-cycle scatterplot (p. 94)

John Tyler Bonner's logarithmic scatterplot (*Size and Cycle*, 1965) plots organism length at reproduction against generation time, from bacteria up to sequoias, each point labeled with its organism. Most of the ink is data-ink (the dots and labels arrayed along the diagonal); only perhaps 10–20 percent is non-data-ink (grid ticks and frame). An example of a strong, naturally high data-ink ratio in real scientific work.

### Voter-registration scatterplot: three published versions (pp. 94–95)

The same data — actual versus predicted voter registration rates for 104 cities in 1960, from Kelley, Ayres, and Bowen's 1967 *American Political Science Review* article — appeared in print three times with wildly different data-ink ratios:

1. The original: a dense dark grid mesh overwhelms the faint data points scattered about the diagonal; nearly all ink is non-data-ink (p. 94).
2. A reprint (in Tufte's own edited 1970 volume) dropped the grid for plain axes, driving the data-ink share up to about 0.7 — an improvement (p. 95).
3. A third reprint (Crotty, ed., 1970) "forgot to plot the points," retracing only the grid lines, including the excess strip of grid along the top and right margins. It achieves "a graphical absolute zero, a null data-ink ratio" (p. 95).

The trio shows the full range of the data-ink ratio on identical data, and the absurd endpoint when the data vanish entirely.

### The labeled, shaded bar — six redundant encodings (pp. 96–97)

A single bar labeled "35.9" encodes its value six separate ways: height of the left line, height of the shading, height of the right line, position of the top line, position of the number, and the number itself. Any five can be erased and the sixth still gives the height. Tufte's canonical illustration of redundant data-ink — more encodings than needed.

### Decorated declining bar series (p. 97)

A chart of values declining over biennial periods 1939–40 to 1975–76, drawn with heavy shading and curved, ornamental bar tops. Gratuitous decoration and reinforcement of the data measures generate much redundant data-ink. Shown without further redesign as a specimen of redundancy through decoration.

### Box plot, open bar, and Chernoff faces — bilateral symmetry (p. 97)

The box plot, the open (outlined) bar, and Chernoff faces (cartoon faces whose features encode variables) are all bilaterally symmetric: the left half mirrors the right. Half-faces carry the same information as full faces, and Flury and Riedwyl (1981) found halves may even sort more easily (matching the right half of an unsorted face to the left half of a sorted face); the freed half-face can report additional variables. Symmetry doubles the space consumed without adding information, and eye-movement research (Zusne, 1970) shows viewers inspect one half, confirm the mirror, and stop. Lesson: avoid bilaterally symmetric encodings.

### Marey's train schedule with an extra half-cycle (p. 98)

E. J. Marey's 1880 graphical train schedule (Paris–Lyon, stations on the vertical axis, time across the horizontal, each train a diagonal line) cuts evening trains off at the right edge; the reader must jump back to the left edge to follow them. Appending an extra half-cycle of time makes every train in the first 24 hours a continuous line — equivalent to mounting the schedule on a cylinder. Tufte's example of *useful* redundancy: in cyclical data, repeating part of the cycle lets the eye track any portion without breaking.

### Ocean-currents world map, one-and-two-thirds times around (p. 99)

Bryan and Cox's 1972 numerical model of world ocean circulation, mapped once around the globe, splits current systems at the map edges. A redesign extending the map one-and-two-thirds times around the world keeps each circulation pattern whole. Same lesson as Marey: justified redundancy for cyclical (here, circumglobal) data.

### Taste-papillae bar chart: erasing 65 percent of the ink (pp. 100–102)

A bar chart from Kuznicki and McCutcheon's 1979 *Journal of Experimental Psychology* paper on cross-enhancement of sour taste compares pairs of long and short bars under various experimental conditions, with asterisks marking significance, full frames, shading, and dense tick marks. Tufte's vigorous pruning keeps all the original data while erasing about 65 percent of the ink — a mix of non-data-ink and redundant data-ink, so both erasing principles are at work (p. 101): bars become thin open brackets, frames and most ticks disappear. The horizontals marking the paired comparisons stay because they would change if the experimental design changed — they carry information. All asterisks go because every comparison was significant, a fact the caption can state once. Tufte presents the "data graphical arithmetic": original design = erased part + good part, showing all three side by side (p. 102). "It is remarkable that erasing alone can work such a transformation" (p. 101).

### Pauling's atomic-volume chart: a full redesign cycle (pp. 102–105)

Roger Hayward's illustration in Linus Pauling's *General Chemistry* (1947) plots atomic volume against atomic number, showing the periodicity of the elements with data points and dashed reference curves. The original's data-ink ratio is under 0.6 because the 76 data points and the reference curves are obscured by 63 dark grid crosses sitting over the data plane "like a precision marching band of 63 mosquitoes." Tufte walks the chart through a full revision cycle:

1. **Erase the grid marks and part of the frame** — they compete with the curves and observations and can be removed from the ratio's denominator. The ratio rises to about 0.9, with only frame lines left as pure non-information. The uncluttered display also reveals something new: several elements visibly fail to fit the smooth theoretical curves (p. 103).
2. **Test removing the reference curves** — data points alone fail to show the periodicity. The curves "create a structure, giving an ordering, a hierarchy, to the flow of information" and prove essential (p. 104). Erasing has limits; keep ink that organizes the data.
3. **Test restoring the grid** — the ticks fail to organize the data, add a disconcerting visual vibration, and make the curves all the more necessary as guidance through the maze of dots and crosses (p. 104).
4. **Reinvest the freed space** — label the alkali elements (Li, Na, K, Rb, Cs, Fr) that begin each period, mark the anomalous rare earths, and rotate the vertical-axis label and numbers to read left-to-right, making the graphic "slightly more accessible, a little more friendly" (p. 105).

This is the chapter's capstone case study: maximize data-ink, erase, but verify each erasure and addition against what actually helps the reader, then revise and edit again.

### Other examples mentioned

- T. S. Eliot on the "capital importance of criticism in the work of creation itself" — quoted to liken graphical editing to a writer's critical labor (p. 100).
- Jonathan Swift's verse mocking 17th-century cartographers who filled empty map space with "savage pictures" and elephants — the epigraph bridging to Chapter 5 on chartjunk (p. 106).
