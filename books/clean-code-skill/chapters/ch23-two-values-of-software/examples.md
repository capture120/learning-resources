# Chapter 23: The Two Values of Software — Examples

This chapter contains no code examples. Its argument is carried by a series of concrete deferral scenarios — technology decisions the author insists you do not need to make early — plus one workplace scenario about imposed decisions. They are retold here.

### Deferring the database decision

The book argues you do not need to choose a database system in the early days of development, because high-level policy should not care what kind of database will be used. Done carefully, the policy will not even care whether storage is relational, distributed, hierarchical, or plain flat files. The lesson: persistence is a detail; if your business rules reference it, you have surrendered the option and the information advantage that comes from deciding later.

### Deferring the web server — and the Web itself

You do not need to choose a Web server early, because the high-level policy should not know it is being delivered over the Web at all. If the policy is unaware of HTML, CSS, AJAX, JSP, JSF, "or any of the rest of the alphabet soup of web development," the choice of web system can wait until much later — and you do not even have to decide whether the system will be delivered over the Web. The lesson: even the delivery mechanism, which feels foundational, is a deferrable detail.

### Deferring REST, microservices, SOA, and React

It is not necessary to adopt REST early, because policy should be agnostic about the interface to the outside world. The same goes for a microservices framework, an SOA framework, or React. The lesson: interface style and architectural fashion are details; high-level policy should not care about any of them.

### Deferring the dependency injection framework

You do not need to adopt a dependency injection framework early, because high-level policy should not care how dependencies are resolved. The lesson: even the mechanism that wires the system together is a detail to be kept out of the policy.

### Database-agnostic policy enables experiments

The book sketches the payoff of deferral: if a portion of the high-level policy is working and is agnostic about the database, you can connect it to several different databases to check applicability and performance. The same applies to web systems, web frameworks, or even the Web itself. The lesson: open options are not just risk insurance — they are an experimental capability. The longer options stay open, the more experiments you can run and the more information you have when the decision finally must be made.

### "What if the decision has already been made?"

The chapter's one workplace anecdote-style scenario: your company has already committed to a certain database, web server, or framework. The author's advice is to pretend those decisions have not been made and give the system a shape that defers them for as long as possible: "You never know when decisions like that might suddenly change." The lesson: organizational commitments are not architectural commitments; isolate imposed details exactly as you would undecided ones.

### Closing maxim

The chapter ends on its single-sentence summary, set off as a rule: "A good architecture maximizes the number of decisions not made." Every scenario above is an instance of this measure.
