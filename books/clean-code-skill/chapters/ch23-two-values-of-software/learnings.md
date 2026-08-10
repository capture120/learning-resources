# Chapter 23: The Two Values of Software

Software has two values: the value of its behavior and the value of its structure. Structure is the greater of the two, because structure is what makes software *soft* — easy to change. Everything in this chapter serves one strategy: shape the system so that decisions about details can be delayed and deferred.

## The Two Values of Software

Behavior (what the system does) and structure (the shape that lets it change) are both valuable, but structure is the greater value. Software was invented because we needed a way to quickly and easily change the behavior of our machines; that flexibility depends critically on the shape of the system — the arrangement of its components and how they are interconnected. A system that works today but cannot be changed loses the very property software exists to provide.

## Architecture Serves the Lifecycle, Not the Behavior

Architecture is the shape given to a system by its builders: the division of the system into components, the arrangement of those components, and the ways they communicate. The purpose of that shape is to facilitate the development, deployment, operation, and maintenance of the system — not to make it work. Making the system work properly is still one of architecture's highest priorities, yet architecture has very little bearing on whether a system works: many systems with terrible architectures work just fine; their troubles are in deployment, maintenance, and ongoing development. Architecture's role in supporting correct behavior is real and critical, but "passive and cosmetic, not active or essential" — there are few, if any, behavioral options architecture can leave open. Good architecture makes the system easy to understand, easy to develop, easy to maintain, and easy to deploy; the ultimate goal is to minimize the lifetime cost of the system and maximize programmer productivity.

## Keeping Options Open

You keep software soft by leaving as many options open as possible, for as long as possible. The options to keep open are "the details that don't matter." The strategy behind all architectural facilitation is exactly this: preserve options.

## Policy and Detail

Every software system decomposes into two major elements: **policy** and **detail**. Policy embodies all the business rules and procedures — it is where the true value of the system lives. Details are the things needed so humans, other systems, and programmers can communicate with the policy, but that do not affect the policy's behavior at all: IO devices, databases, web systems, servers, frameworks, communication protocols. The goal of architecture is to give the system a shape that recognizes policy as the most essential element while making the details irrelevant to it.

## Delay and Defer Decisions

If you can develop the high-level policy without committing to the details around it, you can defer decisions about those details for a long time. The longer you wait, the more information you have with which to decide properly. Concretely: it is not necessary to choose the database, web server, REST, microservices/SOA frameworks, React, or a dependency injection framework early — the high-level policy should not care about any of them, and should not even know it is being delivered over the Web.

## Deferred Decisions Enable Experiments

A database-agnostic policy can be connected to several different databases to check applicability and performance; the same holds for web systems, web frameworks, or even the Web itself. The longer options stay open, the more experiments you can run and the more information you have when a decision can no longer be deferred.

## Pretend Made Decisions Are Unmade

If someone else has already committed your company to a database, web server, or framework, Martin suggests you pretend those decisions have not been made and give the system a shape that defers them as long as possible. You never know when decisions like that might suddenly change. An external commitment is not a license to couple your policy to a detail.

## A Good Architecture Maximizes the Number of Decisions Not Made

This is the chapter's closing maxim and the measure of an architecture: not how cleverly it chose, but how much it avoided having to choose.

## In practice

- When asked to "make it work," also protect the structure — structure is the more valuable of the two values.
- Identify what in your current task is policy (business rules) and what is detail (database, framework, transport, UI, DI mechanism). Keep policy ignorant of detail.
- Before committing to a database, web framework, delivery mechanism, or DI framework, ask: can the high-level policy be written without this decision? If yes, defer it.
- Write business rules so they would still work if the database were relational, distributed, hierarchical, or flat files.
- Keep policy code free of web vocabulary (HTML, CSS, AJAX, framework types) and framework imports.
- Use deferred decisions to run experiments: swap in candidate databases or delivery mechanisms and measure.
- When a technology choice is imposed from outside, still architect as if it were undecided — isolate it behind a boundary.
- Judge an architecture by how many decisions it leaves unmade, and by lifetime cost and programmer productivity, not by whether the system currently works.
