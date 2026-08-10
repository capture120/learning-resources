# Chapter 10: Define Errors Out Of Existence — Learnings

## Central idea

Exception handling is one of the worst sources of complexity in software systems, and the complexity comes from the handling code, not the throwing code. The key lesson: **reduce the number of places where exceptions must be handled**. The most powerful way to do this is to change an operation's semantics so the "error" case becomes normal behavior and there is nothing exceptional to report.

## Key concepts and definitions

- **Exception (broad definition):** any uncommon condition that alters the normal flow of control in a program. This includes formal language exceptions (throw/catch) *and* special return values that signal a method didn't complete its normal behavior. All forms contribute to complexity.
- **Sources of exceptions:** (1) callers passing bad arguments or configuration; (2) invoked operations failing (I/O failure, unavailable resource); (3) distributed-system conditions (lost/delayed packets, unresponsive servers, unexpected peer behavior); (4) the code detecting bugs, internal inconsistencies, or situations it isn't prepared for.
- **Exception handling is big and inherently hard:** large systems face many exceptional conditions, especially if distributed or fault-tolerant — exception handling can account for a significant fraction of all the code in a system. And handling code is inherently more difficult to write than normal-case code: an exception disrupts normal flow and usually means an operation cannot complete as planned.
- **Two ways to handle any exception, both complicated:** (1) move forward and complete the work despite the exception (e.g., resend a lost packet, recover from a redundant copy); (2) abort and report upward — but aborting may leave system state inconsistent (partially initialized data structures), so handling code must restore consistency by unwinding changes.
- **Secondary exceptions:** exception handling code creates opportunities for *more* exceptions (resending a delayed-not-lost packet creates duplicates; the redundant copy may also be lost; an aborted operation becomes a new exception to the caller). Secondary exceptions during recovery are often subtler and more complex than primary ones. To prevent an unending cascade, the developer must eventually find a way to handle exceptions without introducing more exceptions.
- **Exceptions are part of the interface:** classes with lots of exceptions have complex interfaces and are shallower than classes with fewer exceptions. An exception is a particularly complex interface element because it can propagate up several stack levels before being caught, affecting not just the method's caller but higher-level callers and their interfaces too.
- **Exception handling code is rarely exercised, so it's rarely correct:** some exceptions (e.g., I/O errors) can't easily be generated in tests; exceptions occur rarely in production, so handler bugs go undetected for a long time ("code that hasn't been executed doesn't work"). A study found more than 90% of catastrophic failures in distributed data-intensive systems were caused by incorrect error handling (Yuan et al., OSDI 2014). When handlers do fail, the rarity makes debugging hard.
- **Language exception syntax is verbose and clunky:** try-catch boilerplate can exceed the normal-case code, it obscures where each exception is generated, and splitting code into many small try blocks breaks reading flow and duplicates handler code.

## The four techniques (in order of preference)

### 1. Define errors out of existence
Redefine the API's semantics so the exceptional case becomes valid normal behavior. Don't ask "should I report this error?" — ask "can I specify the operation so this case isn't an error at all?" Example pattern: change "delete a variable" (fails if absent) to "ensure the variable no longer exists" (trivially succeeds if absent). This simplifies the API **and often increases functionality**, making the method deeper. Use it when the exception information isn't needed by callers.

### 2. Mask exceptions
Detect and handle the exceptional condition at a low level so higher levels never need to know it occurred (TCP resending lost packets; NFS retrying requests to a crashed server). Masking results in deeper classes: it shrinks the interface (fewer exceptions for users to be aware of) while adding functionality (the masking code). It is an instance of pulling complexity downward. Masking works best when the exception is handled in a low-level method used by many callers — letting it propagate would multiply the handling sites.

### 3. Exception aggregation
Handle many exceptions with a single piece of code instead of writing distinct handlers for each. Let exceptions propagate up to one top-level handler (e.g., a web server's dispatch loop) that does the common thing (generate an error response). Generate the human-readable message where the error is detected and carry it in the exception; the top-level handler knows how to produce error responses but nothing about specific errors. This gives good encapsulation and extensibility: new methods that throw subclasses of the common exception plug in with no other changes. Aggregation works best when an exception propagates *several levels up* the stack before handling — the opposite of masking, which works best low. Both techniques position the handler where it catches the most exceptions, eliminating many handlers. A general pattern: in request-processing systems, define one exception that aborts the current request, cleans up state, and continues with the next request, caught in a single place near the top of the request loop; subclass it for different conditions; keep it clearly distinct from exceptions fatal to the whole system. Aggregation also illustrates the value of general-purpose mechanisms: one general handler replaces several special-purpose ones. A related move is **error promotion**: promote rare small errors into a bigger error that already has a recovery mechanism (RAMCloud crashes a server on object corruption because crash recovery already exists) — this reduces the number of distinct recovery mechanisms and exercises the remaining one more often, flushing out its bugs. Don't promote frequent errors (don't crash a server for every lost packet) because recovery cost becomes prohibitive.

### 4. Just crash
For errors that are difficult or impossible to handle and rare, print diagnostic information and abort. Canonical case: out-of-memory. Checking every malloc return adds significant complexity, forgotten checks cause null-pointer crashes that camouflage the real problem, and there's nothing useful an application can do anyway (if it had freeable memory it would already have freed it; running out usually indicates a bug). Wrap the primitive (a `ckalloc` that checks and aborts) so callers never face the error. Catching C++/Java out-of-memory exceptions is similarly pointless: the handler will probably allocate memory too. Crashing with a clear message is also sensible for I/O errors on open files, failure to open a network socket, or internal inconsistencies (likely program bugs). **Whether crashing is acceptable depends on the application:** a replicated storage system must not abort on I/O errors — recovering lost data is the system's core value, so the recovery complexity is justified.

## Decision rules

- Prefer redefining semantics over reporting an error whenever no caller needs the exception information. Ask whether callers genuinely need to distinguish the case; if not, make it normal behavior.
- Don't throw an exception just because input "looks suspicious." Over-defensive error detection ("the more errors detected, the better") proliferates unnecessary exceptions and increases system complexity.
- Don't use exceptions to punt hard design problems to callers. If you can't figure out what to do in a situation, the caller probably can't either; throwing just passes the problem along and adds complexity. (Some argue throwing "empowers" callers to handle each case their own way — usually false in practice.)
- Throwing is easy; handling is hard. Judge every proposed exception by the handling burden it creates across all callers and all stack levels it may cross.
- Choose masking when one low-level, widely used method can absorb the condition; choose aggregation when the condition naturally propagates up to a single high-level handler. Both minimize handler count.
- Choose crashing when the error is rare, hard to handle, and recovery adds more complexity than value for this application.
- The error-ful approach may catch some bugs, but it increases complexity, which causes other bugs: developers must write extra code to avoid or ignore the errors (more code, more bugs), or they forget that code and get unexpected runtime errors. **The best way to reduce bugs is to make software simpler.**

## Nuances and counterpoints

- **"Won't defining errors away make software buggier?"** Critics say throwing errors catches bugs (this is presumably why Java's `substring` throws). Ousterhout's answer: error-ful APIs force extra defensive code everywhere, and that code is itself a bug source; defining errors away simplifies APIs and reduces total code, which reduces bugs overall.
- **Taking it too far:** defining away or masking exceptions only makes sense when the exception information isn't needed outside the module. A student team's network module masked *all* network errors — caught, discarded, continued as if nothing happened — so applications couldn't detect lost messages or failed peers, making robust applications impossible to build. When the information is important to callers, the module **must expose the exception**, even though it complicates the interface.
- The governing principle: determine what is important and what is not. Hide everything unimportant (the more the better); expose everything important.
- Masking can be controversial in specific systems (NFS hanging applications during server outages draws complaints), but the alternative is worse: applications can't do anything useful without their files; per-application retry duplicates work that one NFS-layer retry does once (a compiler shouldn't worry about this); aborting cascades into a collapse of the user's working environment. Hanging plus a console message is the least-bad design, and users can manually kill applications if needed.
- Special cases of *any* form make code harder to understand and increase bug likelihood; exceptions are just the most significant source of special-case code. The overall priority order: redefine semantics to eliminate the error; if you can't, mask low to limit impact; or aggregate several special-case handlers into one generic handler; crash for the rare/unhandleable remainder.

## Red flags

(Chapter 10 defines no boxed red flags; these are the implicit warning signs it teaches.)

- A class or API that throws many exceptions — its interface is complex and shallow; exceptions are interface complexity.
- "Suspicious input → throw" reflexes: defining exceptions over-defensively without considering who will handle them or how.
- Throwing an exception to avoid figuring out a hard case — punting the problem to a caller who knows even less.
- try-catch boilerplate that outweighs normal-case code, or many duplicated handlers all doing essentially the same thing (a sign aggregation is needed).
- Exception handling code that recovery can itself fail in (secondary exceptions), risking handler cascades.
- Exception handlers that rarely execute and are untested or untestable — assume they don't work.
- Callers wrapping a call in catch-and-ignore just to suppress an error the API shouldn't have raised (the Tcl `unset` symptom — the API definition is wrong).
- Checking a special return value (e.g., NULL from malloc) at every call site — the burden should be pulled into one wrapper or eliminated.
- Masking exceptions whose information callers actually need — silently swallowing errors that matter makes robust client code impossible.
