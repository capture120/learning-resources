# Chapter 18: Simple Design — Examples

### The YAGNI whiteboard anecdote (1999)

While teaching an Extreme Programming course with Martin Fowler, Kent Beck, Ron Jeffries, and others, the conversation turned to overdesign and premature generalization. Someone wrote YAGNI on the whiteboard: "You aren't gonna need it." Kent Beck interrupted with a sharper formulation: you might in fact need it, but ask yourself, "What if you aren't going to need it?" The lesson: YAGNI is not a ban on future-proofing but a discipline of discernment. Each time you reach for a speculative hook, ask what happens if you leave it out: if the cost of leaving it out is tolerable, or the cost of carrying it in the design year after year is high while the odds you'd eventually need it are low, you probably shouldn't put it in.

### 1960s code and the ubiquitous comment

The chapter shows a fragment of late-1960s code drowning in comments. The comments were absolutely necessary because the code itself revealed nothing about its intent — the very word "code" suggests obscured meaning. The lesson: that era is over. Modern languages are expressive enough that disciplined naming and structure can make the code itself reveal intent, like well-written prose, without leaning on comments.

### RentalCalculator: code that reads like prose

A small Java class demonstrates expressive code:

```java
public class RentalCalculator {
  private List<Rental> rentals = new ArrayList<>();

  public void addRental(String title, int days) {
    rentals.add(new Rental(title, days));
  }

  public int getRentalFee() {
    int fee = 0;
    for (Rental rental : rentals)
      fee += rental.getFee();
    return fee;
  }

  public int getRenterPoints() {
    int points = 0;
    for (Rental rental : rentals)
      points += rental.getPoints();
    return points;
  }
}
```

Even an outsider to the project grasps the designer's basic intent at a glance: the names of variables, functions, and types are deeply descriptive and the algorithm's structure is plain. This is what "expressive" and "simple" look like — and it anchors the point that expressiveness starts with names and visible structure.

### The payroll system: exposing the underlying abstraction

The chapter's favorite example of separating levels. The requirements are messy: hourly employees are paid every Friday from time cards, with time-and-a-half after 40 hours; commissioned employees are paid base salary plus commission on the first and third Friday; salaried employees get a fixed amount on the last day of the month. The obvious implementation — a switch statement or if/else chain over employee types — is likely to obscure the underlying abstraction. Instead:

```java
public List<Paycheck> run(Database db) {
  Calendar now = SystemTime.getCurrentDate();
  List<Paycheck> paychecks = new ArrayList<>();
  for (Employee e : db.getAllEmployees()) {
    if (e.isPayDay(now))
      paychecks.add(e.calculatePay());
  }
  return paychecks;
}
```

None of the hideous scheduling and calculation details appear. The underlying truth of the whole application is visible in one breath: pay every employee on their payday. The lesson: separating high-level policy from low-level detail is the most fundamental part of making a design simple and expressive — expressiveness is about levels of abstraction, not just nice names.

### Pencils, coding forms, and the copy/paste editor: a history of duplication

A war story explaining why duplication infests modern systems. In the earliest days, programs couldn't call each other; programmers kept snippets ("subroutines") in paper notebooks and copied them by hand. In the 1950s subroutine calls arrived, and since code was written with #2 pencils on preprinted coding forms, writing a snippet once and calling it was easier than duplicating it — calls cost CPU cycles but saved memory, often a good trade. Then source code editors brought copy/paste: suddenly duplicating and fiddling was the easy path, memory got cheap, and systems accumulated massive duplication. The lesson: duplication grew because tooling made it easy, not because it became harmless — it still leads to fragility.

### Duplicated traversal of a complex data structure

A case where the standard fix for duplication (extract a function with arguments) doesn't directly work. Many parts of a system traverse the same complex data structure with identical looping/traversal code, differing only in what they do to the data inside the loop. When the structure changes, every duplicated traversal must be found and updated — the more copies, the more fragile the system. The remedy: encapsulate the traversal in one place and pass the varying operation into it via lambdas, Command objects, the Strategy pattern, or the Template Method pattern.

### Accidental duplication that must be left alone

A counter-example to "always deduplicate": two stretches of code can be very similar, even identical, yet change for entirely different reasons (the Single Responsibility Principle territory). Martin names this *accidental duplication* and insists it should persist — as requirements change, the copies evolve separately and the apparent duplication dissolves on its own. The diagnostic: real duplications have convergent intent, accidental duplications have divergent intent — and telling them apart depends strongly on how well the code expresses its intent.

### Kent Beck's claim: four rules subsume all design principles

In a conversation years ago, Beck told Martin that following the four rules — coverage, expression, singularization, and reduction — as diligently as possible would satisfy all other design principles. Martin reports the claim honestly without endorsing it: he doesn't know whether a perfectly covered, expressed, singularized, and reduced program necessarily conforms to the Open–Closed or Single Responsibility Principles. What he is sure of is that studying the principles of good design (such as SOLID) makes it much easier to create well-partitioned, simple designs. The lesson: the four rules are a powerful compass, but they complement rather than replace knowledge of design principles.
