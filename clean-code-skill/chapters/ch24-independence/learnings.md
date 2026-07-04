# Chapter 24: Independence

A good architecture keeps the system's components so well isolated and independent that as many decisions as possible stay open for as long as possible. Architecture must support four things — the use cases, the operation, the development, and the deployment of the system — and it satisfies all four through the same means: proper partitioning into well-isolated components.

## Support the Use Cases
The first priority of an architecture is to support the intent of the system. Architecture has little influence over behavior itself; its real power is to **clarify and expose** behavior so the system's intent is visible at the architectural level. A shopping cart application with a good architecture *looks like* a shopping cart application: use cases appear as first-class elements — classes, functions, or modules in prominent positions with names that clearly describe their function. Developers should never have to hunt for behaviors.

## Support the Operation
Architecture must support the system's throughput and response-time demands (e.g., 100,000 transactions per second, millisecond queries over big data). The execution shape varies: parallel services across many servers, lightweight threads in one process, a few isolated processes, or a simple monolith. The key insight: **this decision is an option a good architecture leaves open.** A system written as a monolith that *depends* on its monolithic structure cannot easily move to threads, processes, or microservices. An architecture that isolates its components and does not assume the means of communication between them will find it much easier to transition through the spectrum of threads, processes, and services as operational needs change.

## Support the Development
Conway's law and the Single Responsibility Principle (SRP) apply here. An organization with many teams and many concerns needs an architecture that lets those teams act independently without interfering with each other. Achieve this by partitioning the system into well-isolated, independently developable components that can each be allocated to a team.

## Support the Deployment
The goal is **"immediate deployment"**: the system should be deployable immediately after each build. A good architecture does not rely on dozens of little configuration scripts, property-file tweaks, or manually created directories and files arranged just so. This too comes from proper partitioning and isolation — including the master components that tie the system together and ensure each component is started, integrated, and supervised.

## Leaving Options Open
Balancing all four concerns at once is hard, because in reality we usually don't know the use cases, operational constraints, team structure, or deployment requirements — and even when we do, they all change over the system's lifecycle. The goals are "indistinct and inconstant." The answer: apply architectural principles that are relatively inexpensive and that partition systems into well-isolated components, so the maximum number of options stays open for as long as possible. **A good architecture makes the system easy to change, in all the ways it must change, by leaving options open.**

## In practice
- Make use cases visible at the top level: name prominent modules/classes after the behaviors they implement, so the system's intent is readable from its structure.
- Do not let code depend on its current execution shape (monolith, threads, processes, services); avoid assuming the means of communication between components.
- Partition along team boundaries: components should be independently developable so teams don't block each other (Conway's law, SRP).
- Aim for immediate deployability after every build; treat manual configuration steps, script sprawl, and hand-arranged files as architectural defects.
- When requirements are unknown or shifting (the normal case), don't guess and lock in — isolate components so the decision can be deferred.
- Judge an architecture by how easy the system is to change in the ways it must change.
