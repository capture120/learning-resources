# Chapter 02: Clean That Code! — Examples

The whole chapter is one extended worked example: writing, then incrementally cleaning, a Roman-numeral-to-integer converter in Java (with AI assistance from GitHub Copilot, and later Grok3). The stages below follow the chronological order of the work (the chapter itself presents the final result first, then walks back through the process).

### The discarded state-machine attempt

Before the "ugly" version even existed, Martin fumbled with a few bad ideas, including a state-machine approach he cooked up in the shower. He wrote it partway and threw it away before it got far. He cites Linus Pauling's answer to how he had so many good ideas: have lots of ideas and throw away the bad ones. Lesson: early drafts are disposable; discarding a bad approach is part of the normal process, not failure.

### Listing 2-1: the ugly first version that works

Martin, with Copilot's help, wrote it by "throwing code into a function and fumbling around until I thought it worked." The result, presented in full to make the reader's "eyes cross": one long static `convert` method containing a wall of `roman.contains(...)` checks for illegal patterns, then an ad hoc digraph-replacement trick:

```java
roman = roman.replace("IV", "4");
roman = roman.replace("IX", "9");
roman = roman.replace("XL", "F");
roman = roman.replace("XC", "N");
roman = roman.replace("CD", "G");
roman = roman.replace("CM", "O");
```

followed by a giant switch mapping characters (including the fake digits 4, 9, F, N, G, O) to values, and a descending-order check. The accompanying tests were equally thrown together, and Martin doubted they covered all cases. "Future Bob," re-reading two months later, laughs at how awful parts are ("like 49FNGO") while noting some parts are insightful. Cleaning took roughly as long as the initial writing, and Copilot — moderately helpful while writing — was significantly less helpful while cleaning. Lesson: this messy state is the normal, expected output of "make it work" — it earns no shame, but it demands cleaning.

### Step 1 of cleaning: extract low-hanging fruit into named static functions

Keeping all tests passing, Martin extracted the ugly pattern checks into `checkForIllegalPrefixCombinations` and `checkForImproperRepetitions`, then similarly extracted `replaceDigraphs`, `convertLettersToNumbers`, and `checkNumbersAreInOrder`. The top-level function now reads as a story:

```java
public static int convert(String roman) {
    checkForIllegalPrefixCombinations(roman);
    checkForImproperRepetitions(roman);
    roman = replaceDigraphs(roman);
    int[] numbers = convertLettersToNumbers(roman);
    checkNumbersAreInOrder(numbers, roman);
    return Arrays.stream(numbers).sum();
}
```

He liked how `convert` read but disliked passing arguments around to every helper. Lesson: extraction of well-named functions is the first cleaning move, and each extraction immediately suggests the next improvement.

### Step 2: an object so helpers can communicate

To eliminate the argument-passing, Martin turned the static helpers into instance methods of a `FromRoman` object holding `roman`, `numbers`, and a `values` map as instance variables. The public API stays a pure static function:

```java
public static int convert(String roman) {
    return new FromRoman(roman).doConversion();
}
```

This anchors his answer to functional-programming objections: `convert` is as pure as a function can be; the instance variables just let the helpers inside one invocation communicate without argument lists. Lesson: one good use of an object is as a scratchpad for helper functions operating within a pure function.

### Step 3: killing "49FNGO" — too clever

Martin really disliked the digraph replacement ("IV" becomes "4", "XL" becomes "F", and so on) — "that was just too clever." He cites a rule of thumb (footnoted [DOET]): "if you think something is clever and sophisticated, beware — it is probably self-indulgence." He merged digraph handling into the letter-to-number conversion, one digraph at a time, tests passing throughout; that merge left duplicated inline if/else blocks in the switch cases. Reducing that duplication and removing the magic numbers then produced the `addValueConsideringPrefix(char p1, char p2)` helper that handles subtractive pairs like IV/IX uniformly. Lesson: clever encodings are a cleanliness smell; remove them incrementally under test.

### The final cleaned version and its claimed virtues

The result: short, well-named functions (`doConversion` calls `checkInitialSyntax`, `convertLettersToNumbers`, `checkNumbersInDecreasingOrder`), well-named instance variables, and functions listed in the order they are called, so the file reads top to bottom like a story. Martin pre-empts complaints: yes it is longer (the length is the explanatory names); yes object allocation and small-method calls cost time, which "could seem insane" in embedded real-time code with very tight timing constraints or a high-performance first-person shooter, but for his situation he thinks trading speed for clarity, within reason, is a good trade. He also concedes `convertLettersToNumbers` is longer than he likes but holds together, and further decomposition would obscure more than help.

### Future Bob's annoyance: the cost of cleaning, seen months later

Re-reading the cleaned code two months later, Martin ("Future Bob") is torn. The names and ordering read like a story and reveal intent, but he kept scrolling up to check instance-variable types and found the chopped-up functions annoying — because he already understood the algorithm, so the explanatory artifacts felt redundant. This is the debate he has had with John Ousterhout. He flags `addValueConsideringPrefix` as a name that made sense only while he understood the algorithm; it jarred later. It might have been better written as `numbers.add(decrementValueIfThisCharIsaPrefix)`, symmetrical with the `numbers.add(value)` of the nonprefixed case. He still judges the clean version better, by the test that matters: which version would you rather read first; which reveals intent and which obscures it? Lesson: your understanding of code biases the names and comments you write to explain it; choose them with special care, expect some readers to be annoyed, and re-read after months — it is humbling and profitable.

### The tests: from ad hoc to flooded zone

The initial tests were ad hoc and, it turned out, incomplete: the cleaning process itself surfaced situations needing more tests, and one or two small bugs. The final suite enumerates dozens of valid conversions (up to "MMXXIV" = 2024) and dozens of invalid patterns. Martin admits the volume is daunting, suspects redundancy in the valid cases (but is reasonably sure there is none in the invalid ones), and Future Bob is "slightly annoyed" he never found a more abstract way to determine and test invalid conditions. Lesson: cleaning code and completing tests are one activity; when no elegant test structure presents itself, exhaustive concrete cases ("flooding the zone") beat false confidence.

### Postscript: Grok3 rewrites the code

In February 2025, Martin fed his cleaned version to Grok3. It returned a much shorter solution: a single validation regex —

```java
"^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$"
```

— plus a simple loop that subtracts a value when the next value is larger, otherwise adds. It compiled and passed all of Martin's tests. He is pleased: it "reduces things to the bare essence." He is not a regex fan but finds this one readable, and he would delete Grok3's comments as unhelpful. Lesson: AI can genuinely improve cleaned code, and you should accept good improvements — after judging them against your own standard.

### Postscript: Grok3 rewrites the tests — and the catch

Grok3 also reorganized the tests into well-commented groups (edge case, single characters, subtractive notation, complex cases), an organization Martin had struggled to find before deciding to flood the zone. But the new tests lean on the same regex as the implementation and test invalid inputs inadequately — for example, they never check that "IM" is invalid. Martin would add such tests. Lesson: AI-written tests can share blind spots with AI-written code; audit them independently.

### The autopilot analogy

Given how well Grok3 did, was Martin's cleaning effort wasted? No: "I, and not Grok3, am the final arbiter of the code that gets produced. The buck stops with me." Knowing an LLM gave you good code requires doing enough of the work yourself — writing and cleaning — to be able to judge it. He compares it to an aircraft autopilot: it vastly reduces workload but must never be implicitly trusted; the pilot continuously oversees it and must keep flying skills current. Programmers must likewise stay in practice to competently oversee the automation that lightens their load.
