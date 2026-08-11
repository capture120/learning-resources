# Chapter 20: Component Principles

If the SOLID principles tell you how to arrange bricks into walls and rooms, the component principles tell you how to arrange the rooms into buildings. Components are the units of deployment (jar files, gems, DLLs, aggregations of source files), and well-designed components always retain the ability to be **independently deployable and therefore independently developable**. Six principles govern them: three for cohesion (what goes inside a component) and three for coupling (how components relate). The driving values are buildability, maintainability, and the isolation of volatility — not functional decomposition.

## Components

- A component is the granule of deployment — the smallest entity that can be deployed as part of a system.
- However components are eventually deployed (statically linked, archived, or as dynamically loaded plug-ins), preserve their independent deployability; that is what makes teams able to work independently.
- Component plug-in architecture took 50 years of hardware and tooling evolution (relocatable binaries, linkers, then fast machines) to become "the casual default as opposed to the herculean effort it once was." Use it.

## The Reuse/Release Equivalence Principle (REP)

**"The granule of reuse is the granule of release."** People cannot and will not reuse a component unless it is tracked through a release process with release numbers, release notifications, and release documentation — without release numbers there is no way to ensure reused components are compatible with each other, and users need to know when releases are coming, what changed, and whether to adopt or stay on the old version. Design consequence: the classes and modules in a component must form a cohesive group with an overarching theme — releasable together, sharing a version number and release docs in a way that "makes sense" to both author and users. Martin admits this is weak advice ("makes sense" is hand-waving), but violations are easy to detect: users notice and are not impressed. The next two principles strongly constrain and compensate for it.

## The Common Closure Principle (CCP)

**"Gather into components those classes that change for the same reasons and at the same times. Separate into different components those classes that change for different reasons or at different times."** This is the Single Responsibility Principle (SRP) restated for components: a component should not have multiple reasons to change. The driving value: for most applications, **maintainability is more important than reusability**. If a change is confined to one component, you redeploy only that one; components that don't depend on it need no revalidation or redeployment. It is also "closure" in the Open–Closed Principle sense: since 100% closure is unattainable, closure must be strategic — group classes that are closed to the same expected kinds of change. The "different times" clause matters too: avoid mixing high-volatility and low-volatility elements in one component, even if they change for the same reasons.

## The Common Reuse Principle (CRP)

**"Don't force users of a component to depend on things they don't need."** Classes that tend to be reused together (e.g., a container and its iterators) belong in the same component. More importantly, the CRP says what NOT to keep together: depending on even one module in a component creates a dependency on the whole component, so every change to it likely means recompile/revalidate/redeploy of dependents — possibly even for changes they don't care about. So make the classes in a component inseparable: you should depend on the majority of them, not a few. The CRP is the generic version of the Interface Segregation Principle (ISP). Combined sound bite: **"Don't depend on things you don't need."**

## The Tension Diagram for Component Cohesion

The three cohesion principles fight each other: REP and CCP are inclusive (they tend to make components larger); CRP is exclusive (drives components to be smaller — the book's printed text says "CCP" here, an apparent typo). Costs of abandoning each: focus on REP+CRP and too many components are impacted by simple changes; focus on CCP+REP and you cause too many unneeded releases. There is no fixed right answer — find a position in the tension triangle that meets the team's **current** concerns and shift it as the system evolves. Early in a project, CCP dominates REP because developability matters more than reuse; as other projects start drawing on yours, slide toward reusability. Therefore the component structure **cannot be determined up front** — it jitters and evolves, and restructuring components is a normal part of any Agile iterative cycle. Component structure reflects how a project is developed and used, not what it does.

This redefines cohesion itself. The old view — a module performs one, and only one, function — is too simple; the three principles describe a much more complex variety of cohesion: a dynamic balance of opposing forces (reusability vs. developability) against the needs of the application.

## The Acyclic Dependencies Principle (ADP)

The three coupling principles (ADP, SDP, SAP) deal with relationships *between* components, where the same developability-vs-design tension recurs; the forces on a component structure are technical, political, and volatile.

**"Allow no cycles in the component dependency graph."** The component dependency structure must be a directed acyclic graph (DAG). The motivating pain is the **"morning-after syndrome"**: you arrive in the morning and your working code is broken because someone changed something you depend on; on large teams this can mean weeks without a stable build. The cure: partition into releasable components owned by developers/teams; each team releases numbered versions and others adopt new releases on their own schedule, so no team is at the mercy of another and integration happens in small increments. This only works without cycles. In a DAG you can find who is affected by a release (follow arrows backward), test a component with just its dependencies, and release bottom-up in a clear build order. A cycle effectively fuses the cyclic components into one giant component, destroys the build order, and makes the system "function by accident rather than by plan."

Two mechanisms always break a cycle:
1. **Apply the Dependency Inversion Principle (DIP)**: create an interface owned by the depending component and implement it in the other, inverting the offending dependency.
2. **Create a new component** that both depend upon, and move the shared classes into it.

The "Jitters": breaking cycles can create new components, so the dependency structure grows and shifts with requirements. Monitor it continuously for cycles and break them as they appear.

## Top-Down Design (why you can't do it for components)

The component structure **cannot be designed from the top down**; it evolves as the system grows. Component dependency diagrams have very little to do with describing the function of the application — they are **a map to the buildability and maintainability of the application**. At project start there is no software to build or maintain, so there is nothing for such a map to describe; designing it first would fail badly (no knowledge of common closure, no known reusable elements, near-certain cycles). One of the overriding concerns is **isolation of volatility**: protect stable, high-value components (business rules, high-level policy) from volatile, low-level ones (GUI cosmetics, report formats). Sequence in practice: SRP/CCP first to localize change, CRP later as reuse emerges, ADP as cycles appear.

## The Stable Dependencies Principle (SDP)

**"Depend in the direction of stability."** Some volatility is necessary if the design is to be maintained; conforming to the CCP is what creates components sensitive to certain kinds of changes but immune to others. Some components are designed to be volatile — we expect and want them to change. A volatile component must not be depended on by a hard-to-change component, or it too becomes hard to change. Martin notes the perversity of software: someone can make your easy-to-change module hard to change simply by hanging a dependency on it, without touching a line of your code.

**Stability** means "not easily moved" — the amount of work required to change something, not its frequency of change (a penny on edge isn't changing, but it isn't stable). It is a continuum, not a boolean. Many factors make a component hard to change (size, complexity, clarity…); the metrics deliberately ignore all of those and measure only *positional* stability: many incoming dependencies make a component stable, each dependent being a reason not to change. Metrics:
- **Fan-in**: incoming couplings (outside modules depending on modules inside).
- **Fan-out**: outgoing couplings (inside modules depending on outside modules). (In earlier publications Martin called these Afferent and Efferent couplings, Ca and Ce.)
- **I (Instability)** = Fan-out ÷ (Fan-in + Fan-out), range [0,1]. I = 0 is maximally stable ("responsible and independent: an adult"); I = 1 is maximally unstable ("dependent and irresponsible: a teenager").

The SDP in metric form: **I should decrease in the direction of dependency.** Not all components should be stable — a maximally stable system would be unchangeable. Design some components to be unstable (on top) and some stable (at the bottom); by convention, any dependency arrow pointing up in the diagram violates the SDP. Fix violations with the DIP: extract an interface into a new, very stable abstract component that both sides depend on. Such interface-only **abstract components** are a common and necessary tactic in statically typed languages (Java, C#); in dynamically typed languages (Ruby, Python) they don't exist and dependency structures are correspondingly simpler.

## The Stable Abstractions Principle (SAP)

**"A component should be as abstract as it is stable."** High-level policies and architectural decisions belong in stable components (I = 0), but stability makes source code hard to change — so stable components must be made of interfaces and abstract classes, which can be extended without modification (per the OCP). Unstable components should be concrete, since their instability lets the concrete code change easily. SDP + SAP together amount to the DIP for components: dependencies run toward stability, stability implies abstraction, so dependencies run toward abstraction.

- **A (Abstractness)** = Na ÷ Nc (abstract classes + interfaces over total classes), range [0,1].

### The Main Sequence, Zone of Pain, Zone of Uselessness

Plot components on an A (vertical) vs. I (horizontal) graph. The two ideal points are (0,1) — stable and abstract — and (1,0) — unstable and concrete. Zones of exclusion:
- **Zone of Pain** (near A=0, I=0): stable and concrete — rigid, can't be extended, hard to change. Real inhabitants: database schemas (volatile, concrete, highly depended upon — why schema updates hurt). Exception: **nonvolatile** concrete components like a String utility library are harmless here; pain scales with volatility, which might be considered a third axis.
- **Zone of Uselessness** (near A=1, I=1): maximally abstract with no dependents — interfaces no one implements, leftover abstract detritus.
- **The Main Sequence**: the line from (1,0) to (0,1), maximally distant from both zones. A component on it is depended upon to the extent it is abstract and depends on others to the extent it is concrete. Strive to put most components at the endpoints; the rest should sit on or near the line. Not all components can reach the endpoints: an abstract class deriving from another abstract class is maximally abstract yet not maximally stable — its dependency lowers its stability.
- **D (Distance)** = |A + I − 1|, range [0,1]. Zero means on the main sequence. Any component whose D is not near zero can be reexamined and restructured.

## Theory vs. practice

Martin does not suggest you routinely measure all these metrics: "It's good to know that F = ma, but you don't often do that math when you drive your car." He envisions the relationships and infers stability and abstractness as a "feeling." Understand the theory so your intuition is grounded; do the actual math only in extreme cases, or let your IDE compute the numbers on large projects and sanity-check them.

## In practice

- Group classes into a component only if they change for the same reasons and at the same times (CCP), and would be reused and released together (REP/CRP).
- Don't make users depend on things they don't need; if dependents use only a fraction of a component, split it.
- Anything you intend others to reuse must have versioned releases, release notes, and a way for users to defer adoption.
- Early in a project, optimize component boundaries for developability (CCP); shift toward reuse (REP/CRP) as the project matures. Expect and accept component restructuring as routine.
- Never design the component structure up front; let it evolve from the class design and the needs of build/release.
- Keep the component dependency graph a DAG. Check for cycles whenever you add a dependency; break cycles with the DIP or by extracting a shared component.
- Depend in the direction of stability: never let a hard-to-change component depend on one designed to be easy to change.
- Put high-level policy in stable, abstract components; put volatile detail (UI, reports, I/O) in unstable, concrete components that depend inward.
- Before adding a dependency on a stable concrete component, ask whether you're pushing it into the Zone of Pain; before adding another interface, ask whether anyone will depend on it (Zone of Uselessness).
- Use I, A, and D as a mental model (or IDE report on large projects), not as a ritual of calculation.
