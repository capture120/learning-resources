# Chapter 19: The SOLID Principles — Examples

### The Employee class and the livid COO (SRP: Accidental Duplication)

A payroll `Employee` class has three methods: `calculatePay()`, `reportHours()`, and `save()`. Each answers to a different actor: accounting (under the CFO) specifies `calculatePay()`, HR (under the COO) uses `reportHours()`, and the DBAs (under the CTO) specify `save()`. Putting all three in one class couples those actors.

The war story: `calculatePay()` and `reportHours()` share a non-overtime-hours algorithm, which conscientious developers (avoiding duplication) extracted into `regularHours()`. The CFO's team asks for a tweak to that calculation. A developer changes `regularHours()`, tests carefully, and the CFO's team validates it — but nobody notices `reportHours()` also calls it. HR keeps using its reports, now silently wrong, until the problem is eventually discovered — and the COO is livid because the bad data has cost his budget millions.

Lesson: code that different actors depend upon must not live in close proximity. The "good" instinct to deduplicate created a hidden coupling between two stakeholders' requirements. The SRP says separate the code that different actors depend upon.

### Three ways to split Employee (SRP: Solutions)

The book shows three remedies, all moving the functions into different classes:

1. Separate data from functions: `PayCalculator`, `HourReporter`, and `EmployeeSaver` classes each hold one actor's code and share a methodless `EmployeeData` structure. The three classes are not allowed to know about each other, so accidental duplication-coupling cannot recur.
2. Add an `EmployeeFacade` (the Facade pattern) that contains very little code and just instantiates and delegates to the function classes, so developers don't juggle three classes.
3. Keep the most important business rule (e.g., pay calculation) in the original `Employee` class and use that class as a facade for the lesser functions, for those who prefer business rules close to the data.

The book preempts the objection that each class would hold one function: calculating pay, reporting, and saving each likely need many public and private methods.

### The financial report thought experiment (OCP)

A system shows a financial summary on a scrollable web page with negative numbers in red. Stakeholders then ask for the same information as a paginated black-and-white printed report with headers, footers, column labels, and negatives in parentheses. The question: how much old code must change? A good architecture answers "ideally, zero."

The solution separates the two responsibilities (calculating the reportable data vs. presenting it for web or print — that's the SRP), then arranges components so dependencies point at what must be protected (that's the DIP): Controller → Interactor, with Presenters and Views downstream. The Interactor, holding the business rules, is protected from changes to everything; Views are protected from almost nothing. Adding the print report becomes new code (a new presenter/view), not modified code.

Two interface roles in the design are called out: `FinancialDataGateway` exists purely to invert the dependency that would otherwise point from Interactor to Database (directional control), while `FinancialReportRequester` exists to hide the Interactor's internals from the Controller and prevent transitive dependencies on `FinancialEntities` (information hiding).

A "Future Bob" aside tempers the formality: the author would never expect you to draw the full class diagram; he might draw the abbreviated component view on a whiteboard for the team to discuss — most of the classes within would be obvious — and if a team member had a particular question, someone could scribble a portion of the diagram on a whiteboard or napkin.

### License billing (LSP conformance)

A `License` class has `calcFee()`, called by a Billing application. `PersonalLicense` and `BusinessLicense` subtypes use different fee algorithms. This conforms to the LSP: Billing's behavior doesn't depend in any way on which subtype it gets. It is the positive baseline before the violations.

### Square/Rectangle (LSP: the canonical violation)

`Square` is not a proper subtype of `Rectangle` because Rectangle's height and width are independently mutable while Square's must change together. A user that believes it has a Rectangle gets burned:

```java
Rectangle r = ...
r.setW(5);
r.setH(2);
assert(r.area() == 10);  // fails if r is actually a Square
```

The only defense is putting type-detection (an `if`) in the user — but then the user's behavior depends on the concrete type, so the types aren't substitutable, and the `if` violates the OCP. This anchors the rule: every LSP violation is a latent OCP violation.

### The taxi aggregator and Acme's "dest" field (LSP at architecture scale)

A taxi-aggregation system dispatches drivers from many companies via REST. Each driver record holds a dispatch URI such as `purplecab.com/driver/Bob`, and the system appends standard fields (`pickupAddress`, `pickupTime`, `destination`) and sends a PUT. The whole scheme assumes every company's dispatch service conforms to the same REST interface.

Then Acme's programmers, who didn't read the spec carefully, abbreviate `destination` to `dest` — and Acme is the biggest company in the area, with the CEO's ex-wife now married to ours, so the deviation stays. The naive fix is `if (driver.getDispatchUri().startsWith("acme.com"))…`, but hard-coding "acme" into the system invites mysterious errors and security breaches (what if Acme buys Purple Taxi and unifies the systems — do we add an `if` for "purple"?). So the architect must instead build a dispatch-command-creation module driven by a configuration database keyed by dispatch URI.

Lesson: a single nonconforming implementation of a shared interface — even a trivially small deviation by a third party — can pollute the architecture with significant extra mechanism. LSP applies to any family of interchangeable implementations, including REST services, not just inheritance.

### OPS and its three users (ISP)

A class `OPS` has operations op1, op2, op3; User1 uses only op1, User2 only op2, User3 only op3. In a language like C++, User1's source code nonetheless depends on op2 and op3, so a change to op2 forces User1 to recompile and redeploy even though nothing it cares about changed. Segregating into interfaces (User1 depends on `U1Ops` exposing only op1) breaks that. The book notes Java/C# are softer (declaration-based recompilation) and dynamic languages have no such source dependencies at all — which tempts the conclusion that ISP is just a language issue.

### System S, framework F, database D (ISP as a design principle)

A developer building system S adopts framework F, whose authors bound it to database D. So S depends on F depends on D. D contains features F never uses and S doesn't care about — yet changes to those features can force redeployment of F and therefore S, and a failure in one of them can cascade failures into F and S. This rebuts the "language issue" conclusion: depending on something that carries baggage you don't need causes troubles you didn't expect. Bottom line: don't depend on things you don't need.

### The Service factory and the curved line (DIP: Factories and Concrete Components)

To use a `ConcreteImpl` through a `Service` interface without depending on the concrete class, the Application calls `makeSvc` on a `ServiceFactory` interface; `ServiceFactoryImpl` (on the concrete side) instantiates `ConcreteImpl` and returns it as a `Service`. A curved line in the diagram is an architectural boundary separating abstract from concrete: every source dependency crosses it pointing toward the abstract side, while flow of control crosses in the opposite direction — which is why the principle is called dependency *inversion*.

One dependency on the concrete side still violates the DIP, and the book says this is typical: DIP violations can't be entirely removed, only gathered into a few concrete components — usually `main`, which instantiates `ServiceFactoryImpl` and stows it in a `ServiceFactory`-typed global for the Application to use. This boundary pattern previews the book's later "Dependency Rule."

### Java's String class (DIP: the stability exception)

`java.lang.String` is concrete, and depending on it directly cannot and should not be avoided. Why is that fine? Because String is very stable — changes are rare and tightly controlled. The DIP targets *volatile* concretions: the modules under active development and frequent change. We tolerate, and ignore, the stable background of OS and platform facilities. This example carries the chapter's pragmatism: the DIP rules are warnings, not laws, and abstracting the stable would just produce interfaces no one needs.
