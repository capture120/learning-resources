# Chapter 26: Clean Boundaries

We seldom control all the software in our systems — third-party packages, open source, other teams' components. The chapter's single idea: keep the places where foreign code touches your code few, thin, tested, and shaped by *your* application's needs, so that change on the other side of the boundary doesn't demand huge investments and rework of your core logic. "It's better to depend on something you control than on something you don't control, lest it end up controlling you."

## Minimize and Localize Third-Party Dependencies

Manage third-party boundaries by having very few places in the code that refer to them. Encapsulate all vendor dependencies in a single class or layer (e.g., one `HydraNetwork` class holding every hub-side dependency on the IoT vendor framework). Avoid letting too much of your code know about the third-party particulars. The reasoning: vendors get acquired, go out of business, may become too costly by the time you go to market, and ship breaking releases; the original authors will change their code under pressures of their own. Localizing the dependency means a vendor swap touches one class, not the application core. Don't "marry the vendor (until death do us part)" — use only the slice of their wide interface you actually need.

## Define Interfaces Around Your Needs, Not Their Offerings

The interfaces at the boundary should express what *your application wants* from the foreign code, not what the foreign code offers. In Hydra, `broadcast()` and `handle_reply()` have more to do with what the application needs from the vendor than with the vendor's API surface. This keeps client code readable and focused on what it's trying to accomplish, and it means a replacement vendor only requires reimplementing your small interface — even if (as with the hypothetical BrandX vendor lacking broadcast) the adapter must grow nontrivial, the core application is never at risk.

## Wrap Boundaries in an Adapter

You *may* wrap third-party dependencies in an ADAPTER that converts from your application-centered interface to the provided interface — the rule is few reference points; the adapter is one way to get there. Either way, your code speaks to you better, promotes internally consistent usage across the boundary, and has fewer maintenance points when the third-party code changes. The adapter encapsulates the interaction with the API and provides a single place to change when the API evolves. When the foreign API closely matches your needs, the adapter stays very thin and low complexity; when it doesn't, the complexity lives in the adapter instead of leaking into business logic. The adapter also creates a convenient *seam* for testing — substitute a fake (e.g., `FakeTransmitter`) and test your logic without the real dependency.

## Keep Boundary Code Low-Complexity and Stable

Functions that touch the boundary (vendor calls, concurrency mechanisms, queue plumbing, wiring in `main`) should be low complexity, mostly delegation, and unlikely to change often. Business logic should know nothing about the radio system, the UI framework, or concurrency. Some wiring code (like a `hydra_run()` startup function) is allowed to be "a little messy" because all the dependencies come together there — that's acceptable precisely because it is simple and rarely changes.

## Separate Object Creation From Object Usage

Create and bind concrete objects during initialization, then inject them where used (e.g., the production `HydraDataSource` versus a simulated data source for development). Binding is on a need-to-know basis. This is what lets you run and test the system without real hardware or a real network.

## SOLID Leads to Hexagonal Architecture (Ports and Adapters)

Following the SOLID principles and isolating dependencies on the outside world naturally leads to what Alistair Cockburn calls the Hexagonal architecture (aka Ports and Adapters). Inside the hexagon lives all product logic and behavior, with responsibilities allocated to separate classes and domain objects rather than a big ball of mud. Outside the hexagon is the execution environment (UI, network, vendor frameworks); the application depends on service abstraction layers at the hexagon's edge.

## Learning Tests

Third-party code helps you get more functionality delivered in less time. When adopting a third-party package, don't experiment inside production code. Write *learning tests* (Jim Newkirk's term): tests that call the third-party API exactly as you expect to use it — controlled experiments that check your understanding, focused on what you want out of the API. The reasoning: learning a third-party API is hard, integrating it is hard, and doing both at once is doubly hard; learning tests separate the two. They cost nothing (you had to learn the mechanics anyway) and have a positive return on investment: when a new release ships, rerun them to detect behavioral differences immediately. Even "stable" platforms change — the Python 2 to 3 migration proved it.

## Boundary Tests

Regardless of whether you needed learning tests to learn, a clean boundary should be supported by boundary tests that exercise the interface the same way the production code does. It's not your job to test third-party code, but it may be in your best interest to test the parts you use. Without boundary tests to ease migration, you might be tempted to stay on an old version longer than you should. Once integrated, there are no guarantees the third-party code stays compatible with your needs; with each release comes new risk.

## Using Code That Does Not Yet Exist

Another kind of boundary separates the known from the unknown: sometimes what's on the other side is unknowable right now (code, hardware, or APIs that don't exist yet or whose interface another team hasn't defined), and sometimes you choose to look no further than the boundary. Don't be blocked: define the interface you *wish you had* (e.g., a `Transmitter` with a `transmit(frequency, stream)` method) and code against it. Writing the interface yourself keeps it under your control, keeps client code expressive, and frees you from implementation details you can't know anyway. When the real API arrives, write an adapter to bridge the gap. The undefined boundary can be an advantage rather than a liability: an existing hardware abstraction layer would probably have invited dependence on it, and HALs usually aren't all that abstract from the application's perspective.

## Grow From a Working System

Prefer starting with a working system (even a vendor's "hello world" sample) and making small, verified changes to grow functionality — "it's easier to keep a system working than to fix it after you break it." TDD makes the value of small, verified changes visible.

## In practice

- When adding a third-party library, first write learning tests that exercise the API the way you plan to use it.
- Confine every reference to a vendor/framework to one class or thin layer; grep should find very few files that import it.
- Design the boundary interface from your application's needs ("what do I want from this?"), not from the vendor's API shape.
- Wrap foreign APIs in an adapter; use the adapter seam to substitute fakes in tests.
- Keep boundary and wiring code simple and delegating; keep business logic ignorant of vendors, UI, and concurrency.
- Separate construction from use: bind concrete dependencies at initialization, inject them, and bind only what each part needs to know.
- Maintain boundary tests that mirror production usage; rerun them on every third-party upgrade so you're never afraid to migrate.
- When a needed API or subsystem doesn't exist yet, define the interface you wish you had, code against it, and adapt later.
- Start from something working and evolve in small, verified steps rather than big risky integrations.
