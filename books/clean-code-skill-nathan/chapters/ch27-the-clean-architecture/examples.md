# Chapter 27: The Clean Architecture — Examples

This chapter has no code listings. Its examples are architectural scenarios built around the concentric-circle diagram. They carry the chapter's values: details belong outside, policies inside, and dependencies only point inward.

### The lineage: Hexagonal, DCI, and BCE

The chapter opens by surveying prior architectures: Hexagonal architecture (Ports and Adapters) by Alistair Cockburn, adopted by Freeman and Pryce in *Growing Object-Oriented Software, Guided by Tests*; Data, Context, and Interaction (DCI) by Coplien and Reenskaug; and Boundary–Control–Entity (BCE) by Ivar Jacobson. Despite differing details, all pursue the same objective — separation of concerns via layers, with at least one layer for business rules and another for interfaces. The Clean Architecture is presented as an integration of these into one actionable idea. Lesson: the layering-plus-dependency discipline is not one author's invention but a convergent industry conclusion.

### Crossing the boundary: use case calling the presenter via an output port

The chapter's central worked example. Flow of control runs controller → use case → presenter, but the Dependency Rule forbids the use case (inner) from naming the presenter (outer). The usual resolution, via the Dependency Inversion Principle: the use case calls an interface declared in its own circle — the Use Case Output Port — and the presenter implements that interface. Dynamic polymorphism is the mechanism that makes the source code dependency oppose the flow of control exactly at the boundary. The same technique crosses every boundary in the architecture. Lesson: whenever control must flow outward, invert the dependency with an inner-owned interface rather than letting the inner circle reach out.

### The forbidden row structure

A concrete anti-pattern: many database frameworks return a convenient "row structure" from a query. Passing that row inward across a boundary would force an inner circle to know about an outer one, violating the Dependency Rule. Instead, data crossing a boundary must be an isolated, simple structure — a struct, DTO, function arguments, hash map, or plain object — always in the form most convenient for the inner circle. Lesson: don't cheat by passing entities or database rows across boundaries; convenience offered by a framework is exactly the coupling the architecture exists to prevent.

### A typical scenario: web request through a database-backed system

A walkthrough of one full request in a web system:

1. The web server gathers user input and hands it to the Controller.
2. The Controller packages the input into a plain old object and passes it through the InputBoundary to the UseCaseInteractor.
3. The UseCaseInteractor interprets the data, uses it to "control the dance of the Entities," and uses a DataAccessInterface to bring entity data into memory from the Database.
4. On completion, the UseCaseInteractor gathers results from the Entities into OutputData — another plain object — and passes it through the OutputBoundary interface to the Presenter.
5. The Presenter repackages OutputData into a ViewModel of mostly strings and flags: Date and Currency objects become user-formatted strings; button and menu-item names, and the flags saying whether they should be grayed out, all go in the ViewModel.
6. The View is left with almost nothing to do but move ViewModel data into the HTML page.

Every dependency in this scenario crosses boundary lines pointing inward. Lesson: each layer talks to its neighbors only through plain data and inner-owned interfaces; formatting intelligence lives in the presenter so the view stays trivially dumb (and the use case stays trivially testable).

### "The Web is a detail. The database is a detail."

The chapter's signature aphorism, attached to the outermost circle of frameworks and drivers, where you generally write little code beyond glue. Keeping the web and the database at the edge means they "can do little harm" — and the conclusion cashes this out: when external parts become obsolete, like the database or the web framework, you replace them with minimum fuss, and the system is intrinsically testable along the way. Lesson: treat the technologies that feel most central to a project as its most peripheral, replaceable parts.
