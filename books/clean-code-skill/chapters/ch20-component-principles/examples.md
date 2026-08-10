# Chapter 20: Component Principles — Examples

This chapter is mostly conceptual; its "examples" are a long historical war story, a worked component-dependency scenario, metric calculations, and a handful of vivid illustrations. They are retold below.

### The PDP-8 program and the history of components

Martin opens with an assembly program for the PDP-8: a `GETSTR` subroutine that reads a string from the keyboard into a buffer, plus a tiny unit test that exercises it. The key line is `*200` at the top — an *origin statement* telling the compiler the program would be loaded at octal address 200. In those days programs were not relocatable; choosing the load address was one of a programmer's first decisions, and libraries were kept in source form and compiled together with the application (Martin's first employer kept decks of library source code on a shelf; you slapped a deck onto the end of yours).

The anecdote anchors a 50-year arc:

1. Compiling everything together was too slow (slow devices, scarce memory, multi-pass compilers; large builds took hours), so libraries were compiled separately and loaded at fixed addresses with a symbol table.
2. Programs outgrew their fixed memory slots and had to be split into segments jumping around the library — unsustainable fragmentation.
3. **Relocatable binaries** solved it: compile to address zero, let a loader add the load address, and emit function names as metadata (external references and definitions). The *linking loader* was born.
4. Programs grew again; linking from slow tapes and disks took over an hour, so linking and loading were split into a separate **linker** producing a fast-loading executable.
5. Through the '60s–'80s every speedup was eaten by program growth — Martin invokes **Murphy's law of program size: "Programs will grow to fill all available compile and link time."**
6. Then Moore's law beat Murphy: by the mid-'90s link time shrank to seconds, link-at-load-time became feasible again, and the era of ActiveX, shared libraries, .jar and .dll files arrived.

Lesson: today's casual plug-in component architecture (drop a .jar into a Minecraft mods folder, drop DLLs to plug ReSharper into Visual Studio) is the hard-won endpoint of decades of fighting build/link turnaround. Components exist to make systems independently deployable and developable — exploit that, because it used to be a herculean effort and now it's nearly free.

### Container and iterators (CRP illustration)

A container class and its associated iterator classes are reused together and are tightly coupled to each other, so they belong in the same component. The flip side is the real point: classes not tightly bound to each other should *not* share a component, because depending on any one module in a component means depending on the whole thing — and likely absorbing its release/recompile/redeploy churn, possibly even for changes you don't care about.

### The morning-after syndrome (ADP war story)

You work all day, get your stuff working, and go home. The next morning it's broken — because someone stayed later and changed something you depend upon. Martin calls this the **morning-after syndrome**. On small teams it's an annoyance; on large projects it can mean weeks without a stable build, with everyone endlessly chasing everyone else's latest changes. The fix is to partition development into releasable components: each team releases a numbered version into a shared directory, others adopt new releases on their own schedule, and integration happens in small increments with no big-bang integration moment. This widely used process works *only* if the component dependency graph has no cycles.

### The application dependency DAG (Presenters, Interactors, Entities…)

The chapter's central worked example is a typical application's component diagram: Main, View, Presenters, Controllers, Interactors, Authorizer, Database, Entities, connected as a directed acyclic graph. What it demonstrates, point by point:

- When the Presenters team cuts a release, you find who's affected by following the arrows backward: only View and Main. The rest of the system doesn't know or care.
- To test Presenters, its team builds it against the versions of Interactors and Entities they're already using — no other components involved, few variables to consider.
- System release proceeds bottom-up in a clear order: Entities; then Database and Interactors; then Presenters, View, Controllers, Authorizer; Main last. "We know how to build the system because we understand the dependencies between its parts."

### Introducing a cycle: User depends on Permissions

Then a new requirement makes the `User` class in Entities use the `Permissions` class in Authorizer. Since Authorizer already depends on Entities (through Interactors), this single edge creates a cycle that effectively fuses Interactors, Entities, and Authorizer into one giant component: anyone using one now depends on them all. Worse, there is no correct build order anymore — you can't build Entities first (it needs Authorizer) and you can't build Authorizer first (it needs Entities). "Any system built without a correct build order functions by accident rather than by plan."

Two ways the chapter breaks the cycle:

1. **Dependency Inversion Principle**: create an interface declaring the methods `User` needs, put the interface *in Entities*, and implement it in Authorizer. The dependency between Entities and Authorizer is inverted; the cycle is gone.
2. **Extract a new component** that both Entities and Authorizer depend on, and move the shared classes into it. This grows the component count — illustrating "the jitters": the component structure jitters and grows as requirements change, so cycles must be continuously watched for and broken.

### The penny and the table (what "stability" means)

Stand a penny on its side. It isn't changing — it could stay there a long time — yet nobody calls it stable, because almost no work is needed to topple it. A table is stable because turning it over takes considerable effort. Lesson: stability is about the *work required to make a change*, not the frequency of change, and it is a continuum, not a boolean. In software, one sure way to make a component hard to change is to have lots of other components depend on it (the chapter deliberately sets aside other factors like size, complexity, and clarity).

### The adult and the teenager (stable component X, unstable component Y)

Component X has three components depending on it and depends on nothing: three good reasons not to change, no external influences forcing it to. It is *responsible and independent* — "an adult." Component Y has no dependents and depends on three components: nothing stops it from changing and change can be forced on it from three directions. It is *irresponsible and dependent* — "a teenager." These caricatures define the endpoints of the instability metric I.

### Calculating I for component Cc

A worked metric example: three classes outside component Cc depend on classes inside it (Fan-in = 3), and one class outside Cc is depended on by classes inside it (Fan-out = 1). So I = Fan-out ÷ (Fan-in + Fan-out) = 1/4. Practically, dependencies are counted from `#include` statements in C++ (easiest with one class per source file), `import` statements and qualified names in Java, or `using`/`require` in other languages.

### Stable depends on Flexible (SDP violation and DIP fix)

`Flexible` is a component deliberately designed to be easy to change. A developer working in a component named `Stable` hangs a dependency on it. Without a single line of Flexible's source changing, Flexible is now hard to change: any change to it forces dealing with Stable and all of Stable's dependents. This is the chapter's demonstration of software's perversity — others can ruin your module's changeability just by depending on it.

The fix: class `U` in Stable needs class `C` in Flexible. Create an interface `US` declaring exactly the methods U needs, put it in a new component `UServer`, and have C implement it. Now Stable and Flexible both depend on UServer. UServer is maximally stable (I = 0), Flexible regains its needed instability (I = 1), and all dependencies flow in the direction of decreasing I. The example also legitimizes **abstract components** — components containing nothing but interfaces, with no executable code — as a common and necessary tactic in statically typed languages (and notes they simply don't exist in Ruby or Python, where dependency inversion needs no declared interfaces).

### Database schemas and the String library (Zone of Pain inhabitants)

Two real-world examples of components at (A=0, I=0), the stable-and-concrete corner:

- **Database schemas** are notoriously volatile, extremely concrete, and highly depended upon — one of the reasons the OO-application/database interface is so difficult and schema updates are generally painful. A genuine Zone of Pain resident.
- **A concrete utility library like String** also sits there, but harmlessly: it is so widely used that changing it would create chaos, so nobody changes it — it is *nonvolatile*. Lesson: pain in the (0,0) zone scales with volatility; we might consider volatility a third axis of the graph, with the plotted plane showing only the most painful case (volatility = 1).

### Detritus in the Zone of Uselessness

At (A=1, I=1) live components that are maximally abstract with no dependents: leftover abstract classes no one ever implemented, or superfluous interfaces a few classes implemented but no class ever used. Martin calls them "a kind of detritus" found sitting unused in systems from time to time. A component deep in this zone necessarily contains a significant fraction of such useless entities.

### "F = ma" (don't worship the metrics)

The closing analogy: it's good to know that F = ma, but you don't do that math while driving your car. Martin doesn't routinely gather statistics, compute I, A, and D, and plot graphs; he envisions the relationships and "feels" how stable and abstract each component is. The theory matters because it grounds that feeling — and in a few extreme cases, or on large projects where the IDE computes the numbers anyway, the actual calculations are worth looking at.
