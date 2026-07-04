# Chapter 15: Clean Tests — Examples

### FitNesse page-hierarchy tests: refactoring noisy tests into a testing language
Martin shows three real tests from FitNesse (code he helped write ~20 years earlier, so he "feels free to roundly criticize it"). Each test adds wiki pages through a crawler, builds a request, constructs a `SerializedPageResponder`, casts the response, and then asserts substrings of the XML. The problems: massive duplication in repeated `addPage`/`assertSubString` calls, and a flood of irrelevant detail — `PathParser.parse` converting strings to `PagePath` objects (a transformation that has nothing to do with what's being tested), responder construction, response casting, and ham-handed request-URL building. "This code was not designed to be read."

The refactored version does exactly the same thing but reads at the level of the test's intent:

```java
public void testGetPageHierarchyAsXml() throws Exception {
    makePages("PageOne", "PageOne.ChildOne", "PageTwo");

    submitRequest("root", "type:pages");

    assertResponseIsXML();
    assertResponseContains(
        "<name>PageOne</name>", "<name>PageTwo</name>", "<name>ChildOne</name>");
}
```

What it demonstrates: the Arrange/Act/Assert pattern made structurally obvious; helper functions (`makePages`, `submitRequest`, `assertResponseIsXML`, `assertResponseContains`) forming a domain-specific testing language with composed assertions. The lesson: hide system-manipulation mechanics behind a test-facing API so readers see only what the test truly needs. These testing APIs aren't designed up front — they evolve from refactoring tests that have gotten too tainted by detail.

### Environment controller tests: composed test results ("HBchL")
From an environment control system Martin prototyped. The original test for "way too cold" sets the temperature, calls a cryptic `tic()`, then makes five separate boolean assertions:

```java
hw.setTemp(WAY_TOO_COLD);
controller.tic();
assertTrue(hw.heaterState());
assertTrue(hw.blowerState());
assertFalse(hw.coolerState());
assertFalse(hw.hiTempAlarm());
assertTrue(hw.loTempAlarm());
```

Reading it, your eye bounces between each state name and its assertTrue/assertFalse sense — tedious and unreliable, and this is one of 14 similar tests. The refactored version compresses the whole hardware state into one string:

```java
wayTooCold();
assertEquals("HBchL", hw.getState());
```

Uppercase means on, lowercase means off, in fixed order {heater, blower, cooler, hi-temp-alarm, lo-temp-alarm}. `getState()` builds the string with simple ternaries (`state += heater ? "H" : "h";` ...). Sibling tests become instantly scannable: `tooHot()` → `"hBChl"`, `tooCold()` → `"HBchl"`, `wayTooHot()` → `"hBCHl"`. The lesson: when results are needlessly complex, compose them into a compact, easily compared form; once the encoding is learned, reading the tests "becomes almost a pleasure." The `wayTooCold()` helper also hides the irrelevant `tic()` detail.

### The StringBuffer objection: the Dual Standard
Anticipating the complaint that `getState()` concatenates strings without a StringBuffer/StringBuilder — wasteful in an embedded real-time system, where computer and memory resources are likely very constrained — Martin points out that the *test* runs on his laptop, which isn't constrained at all. This anchors the Dual Standard: things you might never do in production are perfectly fine in tests — usually on efficiency grounds (memory, CPU), never on cleanliness.

### The same tests reread through the Single Assert / Single Act Rule
Martin reuses both examples to defuse a misreading of the Single Assert Rule. The original five-assertion environment test, hard to read as it is, still asserts one logical fact (the system state for "way too cold") — which is exactly why it could be compressed into a composed result. Likewise the refactored page-hierarchy assertions assert the single logical fact that the response is an XML document with certain contents. If "document type" and "document contents" feel like different facts, that's because the rule is poorly named: it should be the Single Act Rule — one action per test, never act–assert–act–assert or act–act–assert–assert, so downstream assertions aren't corrupted by upstream actions.

### The poorly designed test suite (thought experiment)
A hypothetical anchoring the Test Design section: a system of hundreds of modules where one change forces edits to a majority of modules is poorly designed, by definition. Now picture a *well-designed* system whose test suite breaks hundreds of its thousands of tests on a single change — that is a very poorly designed test suite. The lesson: software design principles (especially minimizing coupling) apply to tests exactly as to production code; one production function-signature change must not ripple through hundreds of tests.
