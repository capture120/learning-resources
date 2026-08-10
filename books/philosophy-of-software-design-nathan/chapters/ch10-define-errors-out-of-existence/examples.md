# Chapter 10: Define Errors Out Of Existence — Examples

## Java tweet-file deserialization: try-catch boilerplate dwarfs the real code

**Design problem:** read a collection of tweets from a file using Java object serialization.

The normal-case logic is tiny — open a `FileInputStream`, wrap it in a `BufferedInputStream` and `ObjectInputStream`, then loop `tweets.add((Tweet) objectStream.readObject())`. But Java's checked exceptions force five separate catch clauses around it:

```java
try ( /* open file/buffered/object streams */ ) {
    for (int i = 0; i < tweetsPerFile; i++) {
        tweets.add((Tweet) objectStream.readObject());
    }
}
catch (FileNotFoundException e) { ... }
catch (ClassNotFoundException e) { ... }
catch (EOFException e) { /* not a problem: not all tweet files are full */ }
catch (IOException e) { ... }
catch (ClassCastException e) { ... }
```

The try-catch boilerplate alone exceeds the normal-case code, before any actual handling logic. It's also hard to relate handlers to the code that throws: it isn't obvious where each exception is generated. The alternative — many small try blocks, in the extreme one per throwing line — would show where exceptions come from but would shred the code's flow and duplicate handler code across blocks.

**Lesson:** language exception support is verbose and clunky; exception handling code is inherently hard to write and read, which is why minimizing the number of handling sites matters (motivates the whole chapter).

## Tcl `unset`: a self-confessed design mistake, then the fix

**Design problem:** Ousterhout designed Tcl's `unset` command, which removes a variable, to throw an error if the variable doesn't exist — reasoning that deleting a nonexistent variable must be a bug worth reporting.

**Why it failed:** a very common use of `unset` is cleaning up temporary state left by a previous operation, especially one that aborted partway through. The caller can't easily predict which variables were actually created, so the natural move is to delete everything that *might* exist. The error-throwing definition makes this awkward: developers wrap `unset` calls in catch statements just to swallow the error. Ousterhout calls this one of the biggest mistakes in Tcl's design.

**The fix (defining the error out of existence):** change the semantics slightly. Instead of "delete a variable" (impossible if it doesn't exist, so an error seems justified), define `unset` as "ensure the variable no longer exists." Under that definition, being called on a nonexistent variable is perfectly natural: the work is already done, so `unset` simply returns. There is no error case left to report.

**Lesson:** the flagship example of "define errors out of existence" — a small change in an operation's specification can make the exceptional case normal, eliminating the exception and all of its handlers. Also a warning against over-defensive design ("the more errors detected, the better").

## Windows vs. Unix file deletion: defining away two kinds of errors

**Design problem:** what should happen when a file is deleted while a process has it open?

**Bad approach (Windows):** refuse to delete a file that is open in any process. This is a continual source of frustration: to delete an in-use file, the user must hunt down the process holding it open and kill it; some users give up and reboot just to delete a file.

**Good approach (Unix):** if the file is open when deleted, don't delete it immediately — mark it for deletion and return success. The name is removed from the directory, so no new process can open the old file and a new file with the same name can be created, but the data persists. Processes that already have it open keep reading and writing normally; when the last one closes it, the data is freed.

This defines away **two** errors at once: (1) delete no longer returns an "in use" error — it succeeds, and the file will eventually be deleted; (2) the processes using the file get no exceptions either. The alternative — delete immediately and disable existing opens so later reads/writes fail — would have manufactured new errors for those processes to handle. Delaying the deletion defines those errors out of existence too.

It may seem strange to let a process keep reading and writing a doomed file, but Ousterhout reports never encountering a situation where this caused significant problems. The Unix definition is simpler for both developers and users.

**Lesson:** when choosing semantics for an operation, pick the definition that produces no exceptional condition for *anyone* — the caller or third parties affected by the operation.

## Java `substring` vs. an error-free range API

**Design problem:** Java's `String.substring(beginIndex, endIndex)` throws `IndexOutOfBoundsException` if either index is outside the string.

**Why it's bad:** the exception is unnecessary and complicates use. Ousterhout often has indices that may fall outside the string and wants all characters overlapping the given range; the throwing API forces him to clamp each index to [0, length] himself, turning a one-line call into 5–10 lines.

**Good approach:** define the API as "returns the characters of the string (if any) with index >= beginIndex and < endIndex." Now behavior is well-defined even for negative indexes or beginIndex > endIndex, the `IndexOutOfBoundsException` is defined out of existence, and the method gains functionality while its API gets simpler — i.e., the method becomes **deeper**. Python takes this error-free approach: out-of-range list slices return an empty result.

**Counterargument addressed here:** people object that throwing errors catches bugs, so defining errors away will produce buggier software (perhaps why Java chose to throw). Ousterhout's response: the error-ful approach may catch some bugs, but it also increases complexity, which causes other bugs — developers must write extra code to avoid or ignore the errors, or they forget and get surprise runtime exceptions. Defining errors out of existence simplifies APIs and reduces code. **"Overall, the best way to reduce bugs is to make software simpler."**

**Lesson:** defining errors out of existence can simultaneously simplify an interface and increase functionality (depth), and the bug-catching argument for error-ful APIs underestimates the bugs that complexity itself creates.

## TCP packet loss: classic exception masking

**Design problem:** in a network transport, packets are dropped for many reasons (corruption, congestion).

**Approach:** TCP masks packet loss by resending lost packets inside its own implementation. All data eventually gets through; clients never see the drops.

**Lesson:** exception masking — detect and handle the condition at a low level so higher levels need not be aware of it. Masking is especially common in distributed systems.

## NFS server outages: controversial but correct masking

**Design problem:** an NFS network file server crashes or stops responding. Should the client report errors to applications?

**Approach taken:** the NFS client masks the failure — it reissues requests over and over until the server recovers. Low-level client file system code reports no exceptions; the in-progress operation (and thus the application) simply hangs until it can complete. If the hang lasts a while, the client prints console messages like "NFS server xyzzy not responding still trying."

**Why the alternatives are worse:** users complain about hanging and suggest aborting with an exception instead, but reporting would make things worse, not better. An application that loses access to its files can do little: (a) it could retry the operation itself — but that still hangs the application, and it's easier to retry once in the NFS layer than at every file system call in every application (a compiler shouldn't have to worry about this); (b) it could abort and return errors to its callers — who likely don't know what to do either, so they abort too, collapsing the user's entire working environment. Users still couldn't work while the server was down and would have to restart all their applications afterward.

With masking, applications need no code for server problems and resume seamlessly when the server returns; impatient users can always kill applications manually.

**Lesson:** masking results in deeper classes — a smaller interface (fewer exceptions for users) plus added functionality (the masking code). It is an example of pulling complexity downward. Masking is right when callers have no useful response to the error.

## Web server missing parameters: exception aggregation (student project)

**Design problem:** a web server dispatches incoming URLs to URL-specific service methods; each method calls `getParameter` to extract parameters from the URL, and `getParameter` throws `NoSuchParameter` when a parameter is absent.

**Bad approach (Figure 10.1):** students in a software design class wrapped *each* `getParameter` call in its own try-catch for `NoSuchParameter`. This produced a large number of handlers, all doing essentially the same thing: generate an error response.

**Good approach (Figure 10.2):** aggregate. Don't catch in the service methods; let `NoSuchParameter` propagate up to the top-level dispatch method, where a single handler catches all such exceptions and generates the error response. The service methods become clean straight-line calls to `getParameter`.

**Going further:** many other request errors besides missing parameters should also end in an error response — wrong parameter syntax ("expected an integer, got 'xyz'"), insufficient permission, etc. They differ only in the message. So one top-level handler can cover all of them: generate the human-readable message where the error is detected, store it in the exception, and have the top-level handler extract it into the response (e.g., `getParameter` produces "parameter 'quantity' not present in URL").

**Encapsulation properties:** the top-level handler knows how to generate error responses but nothing about specific errors; `getParameter` knows how to extract parameters and how to describe extraction failures in human-readable form (two closely related pieces of knowledge that belong together), but nothing about HTTP error response syntax. New methods that throw exceptions inheriting from the same superclass, with a message inside, plug into the system with no other changes — the top-level handler covers them automatically.

**Generalized pattern:** in any system that processes a series of requests, define an exception that aborts the current request, cleans up system state, and continues with the next request; catch it in one place near the top of the request-handling loop; subclass it for different conditions; keep it clearly distinguished from exceptions fatal to the entire system.

**Masking vs. aggregation:** aggregation works best when an exception propagates several stack levels before handling (more exceptions from more methods reach one handler); masking works best when handled low, typically in a library method used by many callers (propagation would multiply handling sites). Both position the handler where it catches the most exceptions, eliminating handlers.

**Lesson:** replace many duplicated special-purpose handlers with one general-purpose handler — exception aggregation, and another illustration of the benefits of general-purpose mechanisms.

## RAMCloud crash recovery: aggregation via error promotion

**Design problem:** the RAMCloud storage system keeps multiple copies of each object across storage servers and must recover from many kinds of failures, from a server crash that loses all its data down to a single corrupted object.

**Approach:** RAMCloud does *not* build a separate recovery mechanism for each error kind. It "promotes" many smaller errors into larger ones. It could in principle restore one corrupted object from a backup copy, but instead, on discovering a corrupted object, it crashes the server containing it. Crash recovery was unavoidable anyway and is quite complex, so reusing it minimized the number of distinct recovery mechanisms to build. Bonus: server crash recovery gets invoked more often, so bugs in it are more likely to be discovered and fixed ("code that hasn't been executed doesn't work").

**The disadvantage and its limit:** promoting a corrupted object into a server crash makes recovery much more expensive. That's fine in RAMCloud because corruption is rare. Error promotion does not make sense for frequent errors — e.g., it would be impractical to crash a server every time a network packet is lost.

**Lesson:** a variant of exception aggregation — promote rare small errors into an existing larger recovery path instead of building special-purpose mechanisms; only for infrequent errors.

## malloc / ckalloc and out-of-memory: just crash

**Design problem:** C's `malloc` returns `NULL` when it cannot allocate memory, assuming every caller will check and respond.

**Why that's bad:** applications call malloc everywhere; checking each call adds significant complexity, and if a programmer forgets a check (fairly likely), the application dereferences a null pointer when memory runs out — a crash that camouflages the real problem. And there's little an application can do on exhaustion anyway: if it had unneeded memory to free, it would already have freed it, preventing the error. Modern systems have so much memory that running out usually indicates an application bug. Handling out-of-memory creates too much complexity for too little benefit.

**Good approach:** define `ckalloc`, which calls malloc, checks the result, and aborts with an error message if memory is exhausted. The application never calls malloc directly — always ckalloc.

**Newer languages:** in C++ and Java, `new` throws on exhaustion, but catching it is mostly pointless — the handler will probably try to allocate memory too, and fail too. Dynamic allocation is so fundamental that continuing without it makes no sense; crash as soon as the error is detected.

**Other crash-worthy errors:** for most programs, an I/O error on an open file (disk hard error) or failure to open a network socket leaves nothing useful to do; aborting with a clear message is sensible, and these errors are infrequent enough not to hurt usability. Aborting is also appropriate for internal errors like inconsistent data structures, which probably indicate bugs.

**The application-dependence caveat:** whether crashing is acceptable depends on the application. A replicated storage system must *not* abort on an I/O error — it must use replicated data to recover what was lost. The recovery mechanisms add considerable complexity, but recovering lost data is the essential value the system provides.

**Lesson:** for rare, effectively unhandleable errors, print diagnostics and crash; pull the check into one wrapper so callers never see the error. But "unhandleable" is relative to the application's purpose.

## Student network module: masking taken too far

**Design problem:** a student team built a module for network communication and masked *all* network exceptions: on any network error, the module caught it, discarded it, and continued as if nothing had happened.

**Why it failed:** applications using the module had no way to learn that messages were lost or that a peer server had failed. Without that information, building robust applications on top of the module was impossible.

**The correct call:** in this case the module must expose the exceptions, even though they add complexity to its interface. Defining away or masking exceptions only makes sense when the exception information isn't needed outside the module — true for Tcl `unset` and Java `substring` (and in the rare cases a caller does care about those special cases, it has other ways to find out), but false here.

**Lesson:** the "taking it too far" boundary. Determine what is important and what is not: hide everything unimportant (the more the better), but expose anything important, exceptions included.
