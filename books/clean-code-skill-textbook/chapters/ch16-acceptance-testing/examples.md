# Chapter 16: Acceptance Testing — Examples

This chapter is short and argumentative, with two concrete illustrations and one framing anecdote.

### The QA sign-off ritual (framing anecdote)
The book opens with how organizations frequently decide a system is ready to deploy: a QA department typically runs a large battery of manual tests walking through the system's behaviors, and when those tests "pass," QA blesses the deployment. Martin's point is that this ritual reveals the truth about requirements — the requirements document is irrelevant; only the tests that gate deployment matter. If QA signs off, the system ships, so those tests *are* the requirements. The whole discipline of acceptance testing follows from accepting this fact: make the real requirements (the tests) explicit, written up front by BA and QA, and automated by programmers instead of run manually forever.

### FitNesse tabular acceptance test
The book shows a portion of an acceptance test from the FitNesse tool itself (FitNesse is a wiki). The test checks that wiki markup gestures are correctly translated into HTML, laid out as a table: the action is "widget should render," the input column is the "wiki text," and the output column is the expected "html text." It demonstrates that a behavior specification is always just input data + action + expected output, and that a simple tabular format makes such specs both readable by non-programmers (BA and QA) and easy to automate.

### Given-When-Then wiki rendering test
A wiki-rendering example in the Given-When-Then style of behavior-driven development:

```
Given a page with the wiki text: !1 header
When that page is rendered.
Then the page will contain: <h1>header</h1>
```

This anchors the lesson that the formalism — tabular tool, BDD prose, spreadsheet, or text editor — doesn't matter. All of these map onto Arrange/Act/Assert and are relatively easy to automate. Tools like FitNesse, JBehave, SpecFlow, and Cucumber help, but "tools are not really the issue"; the shared, readable specification is.
