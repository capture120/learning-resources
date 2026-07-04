# Chapter 25: Architectural Boundaries

Software architecture is the art of drawing boundary lines that separate software elements and restrict what each side may know about the other. Some lines are drawn very early — even before any code is written — and others much later; the early ones exist to defer decisions — especially decisions about frameworks, databases, web servers, and other details — so they never pollute the core business logic. The goal of architecture is to minimize the manpower required to build and maintain the system, and what saps manpower is coupling, especially coupling to premature decisions.

## Premature decisions

A premature decision is one that has nothing to do with the business requirements — the use cases — of the system: frameworks, databases, web servers, utility libraries, dependency injection, and the like. A good architecture renders these decisions ancillary and deferrable; the system does not depend on them, and they can be made at the latest possible moment without significant impact.

## What lines do you draw, and when?

Draw lines to separate things that matter from things that don't. The GUI doesn't matter to the business rules; the database doesn't matter to the GUI; the database doesn't matter to the business rules — so there should be a line between each pair. The author explicitly rejects the common belief that the database is inextricably connected to (or even embodies) the business rules: the database is a tool the business rules use indirectly. The business rules need not know the schema, the query language, or any other database detail — only that a set of functions exists to fetch and save data. That is what lets you put the database behind an interface.

## Where the boundary sits and which way the arrow points

The boundary is drawn across the inheritance/implements relationship, just below the interface (e.g., `DatabaseInterface`). Both dependency arrows point away from the implementation (`DatabaseAccess`), so none of the other classes knows that class exists — that's the line. At the component level: the `Database` component knows about the `BusinessRules`; the `BusinessRules` know nothing of the `Database`. Therefore the interface classes live in the BusinessRules component and the access/implementation classes live in the Database component. The Database cannot exist without the BusinessRules (its translation code knows about them), but the BusinessRules could run against Oracle, MySQL, Couch, Datomic, or flat files — they don't care, so the database decision can be deferred while you write and test the business rules.

## Plug-in Architecture

Treat the GUI and the database as plug-ins to the business rules, with arrows pointing from the lower-level components to the high-level BusinessRules component. The pattern repeats for any component that is optional or could be implemented in many different forms: keep the core business rules separate from and independent of it. A plug-in UI can be web, client/server, SOA, console, or anything else; a plug-in database can be SQL, NoSQL, file-system based, or anything else.

**Trade-off the author insists on:** replacements might not be trivial. Swapping a web UI for client/server would likely force rework of some communication between the BusinessRules and the new UI. The plug-in structure does not make every change easy — it makes such changes *practical*.

## Deferring decisions into nonexistence

Deferring a decision is not just postponement; sometimes the deferred decision turns out to be unnecessary (FitNesse deferred MySQL for 18 months, found flat files were good enough, and "deferred that decision into nonexistence"). Crucially, deferring did not prevent or even impede the original option — when a customer later wanted MySQL, the boundary made it a one-day plug-in job. Deferral also pays daily dividends: no schema, query, server, password, or connection issues, and fast tests because no database slows them down.

## The Dependency Rule of Architecture

Partition the system into components: some are core business rules; some are plug-ins containing necessary functions not directly related to the core business. Arrange the code so the arrows between components point in one direction — toward the core business. This is an application of the Dependency Inversion Principle (DIP) and the Stable Abstractions Principle (SAP): dependency arrows point from lower-level details to higher-level abstractions. The rule itself: **Dependencies that cross architectural boundaries must always point toward the higher-level side.**

## In practice

- Identify what is core business logic (use cases) and what is detail (GUI, database, framework, web server, library, DI mechanism); draw a line between them.
- Put an interface in front of every detail; place the interface in the high-level (business-rules) component and the implementation in the low-level component.
- Check arrow direction at every boundary crossing: dependencies must point toward the higher-level side. If business rules import database/framework code, the boundary is broken.
- Defer detail decisions to the latest possible moment; start with stubs or in-memory implementations and build features against the interface.
- Prefer simple substitutes (mock, in-memory, flat file) over firing up real infrastructure — you avoid its operational headaches and keep tests fast.
- Accept that swapping a plug-in may still require work; the boundary's job is to make the swap practical, not free.
- Be willing to let a deferred decision die: if the simple implementation proves good enough, never make the "real" decision at all.
