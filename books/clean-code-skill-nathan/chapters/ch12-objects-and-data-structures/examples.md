# Chapter 12 Examples: Objects and Data Structures

### Point 1 vs. Point 2 — concrete fields vs. abstract interface

The book contrasts two representations of a Cartesian point. Point 1 is a class with two public fields, `x` and `y` — its rectangular implementation is fully exposed, and callers must manipulate the coordinates independently. Point 2 is an interface:

```java
public interface Point {
    double getX();
    double getY();
    void setCartesian(double x, double y);
    double getR();
    double getTheta();
    void setPolar(double r, double theta);
}
```

From Point 2 you cannot tell whether the implementation is rectangular, polar, or neither — the interface is an abstract data structure. It also enforces a behavioral policy: both coordinates must be set together, atomically. Lesson: hiding implementation is about abstraction, not about wrapping fields in accessors. Point 1 would still expose its implementation even with private fields and single-variable getters/setters.

### Vehicle 1 vs. Vehicle 2 — gallons vs. percentage

Vehicle 1 exposes fuel state in concrete terms: `getFuelTankCapacityInGallons()` and `getGallonsOfGasoline()` — almost certainly raw variable accessors. Vehicle 2 exposes one abstraction: `getPercentFuelRemaining()`, which tells you nothing about how the data is stored. The second is preferable. Lesson: express data in abstract terms; the worst option is to blithely add getters and setters. Choosing the right abstraction takes serious thought.

### Procedural Shapes vs. OO Shapes — the antisymmetry demonstrated

The procedural version has `Square`, `Rectangle`, and `Circle` as bare data structures (public fields, no methods), with a `Geometry` class whose `area(Object shape)` method type-tests each shape and computes its area. Adding a new function (say `perimeter()`) touches only `Geometry`; the shapes and their dependents are unaffected. But adding a new shape forces every function in `Geometry` to change.

The OO version makes `area()` a polymorphic method on each shape class, eliminating `Geometry`. Now adding a new shape touches nothing existing, but adding a new function forces every shape class to change.

This pair anchors the chapter's core dichotomy: procedural code makes new functions easy and new data structures hard; OO code makes new data structures easy and new functions hard. A footnote concedes that Visitor/dual-dispatch can work around the OO limitation but at costs that essentially return the design to procedural form.

### The Apache trainwreck — `ctxt.getOptions().getScratchDir().getAbsolutePath()`

A line found in the Apache framework chains three calls to dig a path out of a context object. The book names this style a "trainwreck" (coupled train cars), calls it sloppy style, and says it is usually best to split it into intermediate variables — then asks whether either version violates Demeter: the function still knows that a context contains options, which contain a scratch directory, which has an absolute path. Whether this violates the Law of Demeter depends on whether `ctxt`, `Options`, and `ScratchDir` are objects (then it's a clear violation) or data structures (then Demeter doesn't apply). Written as `ctxt.options.scratchDir.absolutePath`, plain data access, we probably wouldn't be worried. Lesson: the object/data-structure convention determines which rules apply; accessor functions blur the line and create confusion.

### Hiding structure — `createScratchFileStream`

Continuing the Apache example: if `ctxt` is a real object, how do we get the scratch directory's path? `ctxt.getAbsolutePathOfScratchDirectoryOption()` risks a method explosion on `ctxt`; `ctx.getScratchDirectoryOption().getAbsolutePath()` presumes the return is a data structure. Neither feels good. The book then looks farther down the same module and finds why the path was wanted — to build an output stream for a scratch file (in code that troublingly mixes dots, slashes, file extensions, and File objects). So tell the context to do that:

```java
BufferedOutputStream bos = ctxt.createScratchFileStream(classFileName);
```

A reasonable thing for an object to do. `ctxt` hides its internals; the caller stops navigating objects it shouldn't know about. This anchors the advice "Tell the Other Guy," and the cited Thomas/Hunt summary of OO: "Keep it DRY, Shy, and Tell the Other Guy."

### The Address bean — quasi-encapsulated DTO

An `Address` class with five private String fields, a constructor, and five getters illustrates the early-Java "bean" form of a data transfer object. The quasi-encapsulation makes OO purists feel better but usually provides no other benefit — the DTO might as well have public fields. Lesson: a DTO is a data structure; dressing it in accessors adds ceremony, not abstraction.

### The ShapeManager startup — a war story about switch statements

The chapter's longest example is a narrative. A shape system has `Shape` carrying a `ShapeType` enum tag, with `ShapeManager.renderShapes` switching on the tag and casting (might look quite normal to a C programmer, a little odd to a Java programmer). Adding a `Triangle` requires changing the enum, writing the new class, and updating the switch — plus the same switch hidden inside `dragShapes`, `eraseShapes`, `rotateShapes`, `scaleShapes`, and more. Worse, some use if/else chains instead, and clever programmers have applied logical optimizations (e.g., `rotateShapes` omits the CIRCLE case because circles have rotational symmetry), so in a large system you will almost certainly miss one. The design is rigid (many modules change for one requirement — SRP and OCP violations) and fragile.

Then the business twist: the CEO announces the company will give `ShapeManager` away free and sell shapes as separately downloadable products. The dream is dead on arrival — `Circle` and `Square` are woven through every switch in the system and cannot be deployed independently. The design is immobile, violating the Dependency Inversion Principle. "It's trash. It's a horror scene."

A "seagull consultant" (flies in, makes noise, craps on everything, flies home) delivers the OO rewrite: `Shape` becomes an interface with `render()`, each shape implements it, and `ShapeManager` just loops calling `shape.render()`. Adding Triangle now changes nothing existing (except, perhaps, the main program), and shapes can ship in their own jar files. OCP and DIP restored.

### "Not So Fast, Johnson" — the counter-punch

The same war story then reverses. The OO design protects only against new *shapes*. When customers instead ask for a new *method* — drop-shadow rendering — every class (`Shape`, `Circle`, `Square`, `ShapeManager`) must change, and the abstraction gives no benefit. The original switch-based design handles it by adding `renderDropShadow` functions to `ShapeManager` alone, never touching the shapes. Lesson: neither style wins outright; choose by which axis of change — new types or new functions — your application actually experiences. Martin's stated personal preference is OO (interpret changes as new data types), with switches confined to the system's periphery, at most one per switchable type, creating the polymorphic objects — but he won't force an OO round peg into a procedural square hole.

### Enterprise database vs. IDE — which side is volatile?

Two brief comparative examples ground the hide-the-volatile rule. A large enterprise database's structure is relatively static while the programs' business rules churn constantly — so expose the data structure and let behavior live in replaceable programs around it. An IDE is the inverse: its behavior (editing text files) is stable, but every newly supported language brings a remarkably different data structure — so expose the stable behavior and hide the volatile data. Lesson: the object/data-structure choice depends on which is more static, and the answer differs by component, even within one system.
