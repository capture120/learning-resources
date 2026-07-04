# Chapter 4 Examples: Modules Should Be Deep

## Balanced tree class — complexity hidden behind a simple interface

A module implementing balanced trees contains sophisticated code to keep the tree balanced, but none of that complexity is visible to users. The interface is a few simple operations — insert, remove, fetch — and an insert caller supplies only a key and value. Tree traversal and node splitting never appear in the interface.

**Principle**: a good module exposes *what* it does, not *how*; users of a module should never need its implementation, only its interface.

## File system abstraction — what to omit vs. what must stay visible

A file system rightly omits details like which disk blocks store a file's data; users don't care as long as performance is adequate. But some implementation details *are* important to users: most file systems cache writes in memory and delay flushing to disk. Databases need to know exactly when data reaches durable storage to survive crashes, so the rules for flushing data must be visible in the file system's interface.

**Principle**: an abstraction may only omit details that are genuinely unimportant. Omitting an important detail creates a false abstraction — simple-looking but obscure. The design skill is deciding what is important and minimizing it.

## Everyday abstractions — microwave ovens and cars

A microwave contains complex electronics that convert AC power to microwave radiation and distribute it through the cavity; users see a few buttons controlling timing and intensity. Cars let us drive without understanding electrical motors, battery management, anti-lock brakes, or cruise control.

**Principle**: abstractions manage complexity everywhere, not just in code; a good interface is a radically simplified view of a powerful mechanism.

## Unix file I/O — the canonical deep module

Unix (and descendants like Linux) exposes file I/O through just five basic system calls with simple signatures:

```c
int open(const char* path, int flags, mode_t permissions);
ssize_t read(int fd, void* buffer, size_t count);
ssize_t write(int fd, const void* buffer, size_t count);
off_t lseek(int fd, off_t offset, int referencePosition);
int close(int fd);
```

`open` maps a hierarchical path like `/a/b/c` to an integer file descriptor; its other arguments cover read/write mode, file creation, and permissions. `read`/`write` move data between application buffers and the file; `close` ends access. Sequential access is the default because it's the common case; random access is available via `lseek` when needed.

Behind this tiny interface, a modern implementation is hundreds of thousands of lines handling: on-disk file representation for efficient access; directory storage and path-name resolution; permission enforcement; the split between interrupt handlers and background code and their safe communication; scheduling of concurrent accesses; in-memory caching to cut disk reads; and supporting diverse storage devices (disks, flash) under one file system. All invisible to callers. Implementations have changed radically over the years; the five kernel calls have not — so no caller code had to change.

**Principle**: deep modules hide enormous implementation complexity behind stable, simple interfaces, and a stable interface lets the implementation evolve freely.

## Garbage collectors — a module with no interface at all

A garbage collector (as in Go or Java) works invisibly to reclaim unused memory. It has no interface; adding it actually *shrinks* the system's overall interface by eliminating the API for freeing objects. Its implementation is complex, but that complexity is fully hidden.

**Principle**: depth can be extreme — adding functionality can reduce the system's interface. Less interface, all else equal, is better.

## Linked list class — an unavoidable shallow module

A linked-list class is shallow: inserting or deleting an element takes only a few lines, so the abstraction hides almost nothing. Its interface complexity is nearly as great as its implementation complexity. Such classes are sometimes unavoidable and can still be useful, but they provide little leverage against complexity.

**Principle**: shallowness is a measure of leverage, not a moral failing — but expect little complexity payoff from shallow modules.

## Student-project method — the extreme shallow method

From a software design class project:

```java
private void addNullValueForAttribute(String attribute) {
    data.put(attribute, null);
}
```

This method makes complexity *worse*. It offers no abstraction: everything it does is visible from its interface, and callers probably still need to know the attribute lands in the `data` variable. The interface is no simpler to think about than the implementation. Proper documentation would be longer than the code. Invoking it takes more keystrokes than manipulating `data` directly. It adds a new interface for developers to learn with no compensating benefit.

**Principle**: this is the "Shallow Module" red flag in its purest form — a wrapper that adds interface without hiding anything.

## Java file I/O — classitis in a mainstream library

For many years, reading serialized objects from a file in Java required composing three objects:

```java
FileInputStream fileStream = new FileInputStream(fileName);
BufferedInputStream bufferedStream = new BufferedInputStream(fileStream);
ObjectInputStream objectStream = new ObjectInputStream(bufferedStream);
```

`FileInputStream` gives only rudimentary unbuffered I/O; `BufferedInputStream` adds buffering; `ObjectInputStream` adds serialization. The first two objects are never used again after setup. Worse, buffering must be requested explicitly — forget the `BufferedInputStream` and I/O silently becomes slow. The likely defense ("not everyone wants buffering, keep it separate so people can choose") fails Ousterhout's test: choice is good, but **interfaces should make the common case as simple as possible**. Nearly every file I/O user wants buffering, so it should be the default, with a cleanly separated mechanism to disable it (a special constructor, or a method that disables/replaces buffering) that most developers never even see.

**Principle**: classitis pushes setup complexity and error-prone choices onto every caller; design for the common case and hide the rare options.

## Unix sequential-vs-random access — common case made simple

The Unix designers recognized sequential I/O as the common case and made it the default. Random access remains easy via `lseek`, but a developer doing only sequential access never needs to know `lseek` exists.

**Principle**: when an interface has many features but most developers need only a few, the effective interface complexity is just that of the commonly used features. Layer rare features so they can be ignored.
