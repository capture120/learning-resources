# Chapter 5 Examples: Information Hiding (and Leakage)

## Kinds of knowledge a module can hide

Ousterhout opens with examples of information worth hiding inside a module: how to store and efficiently access information in a B-tree; how to map each logical block in a file to a physical disk block; how to implement the TCP protocol; how to schedule threads on a multi-core processor; how to parse JSON documents. Hidden knowledge spans data structures and algorithms, low-level details (the size of a page), and abstract higher-level assumptions (most files are small). A B-tree user shouldn't have to think about ideal node fanout or rebalancing; if TCP adds a new congestion-control mechanism, only the protocol implementation changes — code that uses TCP to send and receive data is untouched.

**Principle demonstrated:** information hiding both simplifies interfaces (less cognitive load) and localizes change (no outside dependencies on hidden decisions).

## File read–modify–write: temporal decomposition

An application reads a file in a particular format, modifies its contents, and writes the file back out. The temporal-decomposition design creates three classes matching the timeline: a reader, a modifier, and a writer. Bad: both the reading and writing classes must understand the file format, so that knowledge leaks into two places — a format change forces edits to both. Good: combine the core file reading and writing mechanisms into a single class that gets used during both the reading and writing phases of execution.

**Principle demonstrated:** structure modules around knowledge, not execution order; most design decisions (like a file format) surface at several different times in an application's life.

## HTTP server course project (framing for sections 5.5–5.7)

Students in a software design course implemented classes to let web servers receive HTTP requests and send responses. An HTTP POST request (Figure 5.1) is text over a TCP socket: an initial line with method, URL, optional parameters (`POST /comments/create?photo_id=246 HTTP/1.1`), headers like `Content-Length: 40`, then an optional body carrying more parameters (`comment=What+a+cute+baby%21&priority=low`). The student designs supply both positive and negative examples below.

## Too many classes: splitting request reading from request parsing

The most common student mistake was dividing code into many shallow classes, causing leakage between them. One team used two classes for receiving requests: the first read the request from the network connection into a string; the second parsed the string. This is temporal decomposition ("first we read the request, then we parse it"). Bad consequences: an HTTP request cannot be read without parsing much of it anyway — the `Content-Length` header determines the body length, so headers must be parsed just to know how much to read. Both classes ended up understanding most of HTTP request structure, parsing code was duplicated in both, and callers had to invoke two methods in different classes in a particular order. Good: merge reading and parsing into one class — all knowledge of the request format isolated in one place, and a simpler interface (one method to call).

**Principle demonstrated:** information hiding can often be improved by making a class slightly larger — both to bring all code for one capability together and to raise the interface level (one method instead of multi-step protocols). Counterpoint in the text: larger classes can go too far (one class for the whole application); Chapter 9 covers when to split.

## HTTP parameter handling: what students hid well

Parameters appear in the URL line (`photo_id`) or the body (`comment`, `priority`), and values are URL-encoded (`+` for space, `%21` for `!`). The student projects made two good choices: (1) servers don't care where a parameter was specified, so they merged URL-line and body parameters and hid the distinction from callers; (2) they hid URL encoding — the parser decodes values before returning them, so `comment` comes back as "What a cute baby!", not "What+a+cute+baby%21".

**Principle demonstrated:** hiding distinctions and encodings the caller doesn't care about yields simpler APIs.

## HTTP parameter handling: the getParams leak

Most projects then squandered the win with a shallow accessor on their `HTTPRequest` class:

```java
public Map<String, String> getParams() {
    return this.params;
}
```

Bad: this returns a reference to the internal Map holding all parameters. It exposes the internal representation, so any representation change (common when tuning performance) changes the interface and forces all callers to be modified. It also makes callers work harder — call `getParams`, then a second method to pull a value from the Map — and callers must somehow know not to modify the returned Map, since that would corrupt the `HTTPRequest`'s internal state. Good:

```java
public String getParameter(String name) { ... }
public int getIntParameter(String name) { ... }
```

`getParameter` returns one value and hides the internal representation. `getIntParameter` additionally converts the value from its string form in the request to an integer (e.g., `photo_id`), hiding the conversion mechanism; more types (`getDoubleParameter`) can be added as needed. All throw exceptions if the parameter is missing or unconvertible.

**Principle demonstrated:** avoid exposing internal data structures; deeper accessors that do useful transformation hide more and serve callers better.

## Defaults in HTTP responses

The most common mistake on the response side was inadequate defaults. Bad: one team required callers to explicitly specify the HTTP protocol version when creating a response object. But the response version must match the request's version, and the request object is already passed as an argument when sending the response (it says where to send it) — so the caller is unlikely to know what to specify, and supplying it leaks knowledge between the HTTP library and the caller. Good: the HTTP classes fill in the version automatically, and likewise supply a sensible default for the `Date` header.

**Principle demonstrated:** design interfaces so the common case is as simple as possible. Defaults are partial information hiding — normally the caller need not know the defaulted item exists; rare overriders invoke a special method.

## Java I/O buffering (negative callback to Chapter 4)

The Java I/O example from page 26 illustrates defaults negatively. Buffering in file I/O is so universally desirable that no one should ever have to ask for it explicitly (Java makes you wrap streams in `BufferedInputStream`), or even know it exists; the I/O classes should provide it automatically.

**Principle demonstrated:** classes should "do the right thing" without being asked — the best features are the ones you get without even knowing they exist. Forcing common-case users to learn rarely-needed machinery is the Overexposure red flag.

## Information hiding within a class

Beyond public APIs, the same idea applies inside a class: design each private method to encapsulate some information or capability and hide it from the rest of the class, and minimize the number of places each instance variable is used. Some variables genuinely need wide access, but for the rest, fewer usage sites mean fewer internal dependencies and lower complexity.

**Principle demonstrated:** information hiding operates at every level of the system, not just module boundaries.

## Taking it too far: tunable configuration parameters

Suppose a module's performance depends on certain configuration parameters, and different uses of the module need different settings. Then the parameters must be exposed in the interface so they can be tuned — hiding them would be wrong. The designer's goal is still to minimize information needed outside (a module that auto-adjusts its configuration beats one exposing knobs), but you must recognize which information is genuinely needed outside the module and make sure it is exposed.

**Principle demonstrated:** hide information only when it is not needed outside the module; needed information must be surfaced.
