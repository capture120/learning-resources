# Chapter 26: Clean Boundaries — Examples

This chapter (written by James Grenning) is built around one extended case study — the "Hydra" water-pump IoT prototype — plus a learning-tests demonstration and a war story about coding against a nonexistent API.

### The Hydra IoT prototype: isolating a vendor you expect to replace

Grenning's brother needed to automate testing of high-capacity water pumps. The manual process: technicians flow thousands of gallons per minute out onto the street for 20–30 minutes, reading physical pressure gauges and recording values on a clipboard. The idea was electronic pressure sensors reporting once per second to a tablet. Bluetooth worked in the lab but couldn't penetrate the brick walls found in real buildings, so they adopted an off-the-shelf IoT vendor whose radio infrastructure let them build the application in Python.

The key decision: they assumed from day one that the vendor might be temporary. The vendor could become too expensive at production scale, go out of business, or be acquired in the fast-moving IoT market. To preserve their business-logic investment, the prototype needed clean code, separation of concerns, and a limited dependency on the vendor's infrastructure. Although the vendor offered an elaborate, capability-rich framework, they used very little of its very wide interface — "we wanted to use the radios for some simple message passing, not marry the vendor (until death do us part)." They started from the vendor's working "hello world" demo (messages between a small industrial Linux box and the microcontroller radios) and morphed it into the layer containing all vendor dependencies — preferring to grow a working system in small, verified changes rather than break it and fix it later.

All hub-side vendor dependencies were encapsulated in a single class, `HydraNetwork`, whose functions are low complexity and merely delegate to the vendor's RPC and messaging facilities. For example, announcing the hub to listening radios is a thin delegation:

```python
# In the hub
class HydraNetwork:
    def announceHub(self):
        self.broadcast('announceHub', '')
        self.poll_a_second()
```

Replies flow back through `processAck()`, which hands the payload to an injected `ack_handler` (a `HydraDataSource`). The `reply_dispatcher` and its collaborators — the parts that parse sensor measurements and build per-second reports — are test-driven and completely free of IoT dependencies. The payoff stated plainly: because `HydraNetwork` encapsulated all the vendor dependencies, a different vendor's infrastructure could be substituted without touching the application.

Lesson: confine a vendor to one thin, simple class; keep business logic ignorant of it; depend on only what you need.

### Lots o' boundaries: radio, ADC microcontroller, UI, and concurrency

The case study shows the same isolation pattern repeated at every boundary in the system, not just the vendor API:

- **Sensor/ADC boundary.** A separate microcontroller reads the analog-to-digital converter and computes PSI. The radio talks to it over a serial line; a hook (`measurementDone`) receives the CSV reply and forwards it to the hub as an ACK. The serial protocol details stay in tiny radio-side functions.
- **UI/application boundary.** The UI is a web browser served by Python/Flask. The system runs as two processes: a `Collector` gathering measurements and a `WebServer` running Flask. They communicate only through two simple message queues — a `CommandQueue` (UI drives the system: start/stop test) and a `ReplyQueue` (measurement reports flow back). Business logic is fully separate from the UI.
- **Concurrency.** None of the business logic knows about concurrency. The concurrency mechanisms live in low-complexity functions unlikely to change, like the `measurement_loop()` entry point that waits on the command queue with a one-second timeout and treats each timeout as a refresh command.
- **Creation vs. use.** `hydra_run()` is called from `main()` with its `data_source` injected — the real `HydraDataSource` in production, a simulated source in development and testing. The author admits this wiring function is "a little messy, as all the dependencies come together here," but accepts it because the code is simple and probably won't change much. Object creation is separated from object usage, and binding is on a need-to-know basis.

Lesson: a clean system is a collection of clean boundaries — vendor, hardware, UI, process, and concurrency seams each get the same treatment.

### Hexagonal architecture and the BrandX thought experiment

Stepping back from the pieces, the author observes that following SOLID and isolating outside-world dependencies naturally produced Alistair Cockburn's Hexagonal architecture (Ports and Adapters): all product logic inside the hexagon, the execution environment outside, with the application depending on service abstraction layers at the edge.

He stresses that the boundary interfaces — `broadcast()` and `handle_reply()` — express what the Hydra application *wants* from the ACME IoT vendor, not what ACME *offers*. Because ACME's facilities happen to be close to those needs, the adapter is very thin.

Then the thought experiment: imagine a cheaper vendor, BrandX, that has no broadcast facility — each radio must be addressed individually. A BrandX implementation of `HydraNetwork` could still implement `broadcast()` by tracking every sensor connection internally. That adapter layer might become nontrivial, but the vendor could be changed without any risk of touching the Hydra core application.

Lesson: shape interfaces around your needs; let adapters absorb the mismatch when reality diverges.

### Learning tests for Python's Queue and Process

Needing concurrency for Hydra but never having done concurrent programming in Python, the author faced a choice: read the docs and integrate directly into production code (risking long debugging sessions where you can't tell whose bug it is), or run controlled experiments first. Learning a third-party API is hard, and integrating it is hard — doing both at once is doubly hard. So he wrote *learning tests* (Jim Newkirk's term): tests that call the API exactly as the application would use it.

He test-drove two small wrappers, `put_message()` and `get_message()`, pinning down the behaviors he cared about — timeouts return `None`, puts to a full queue return `False`:

```python
def test_get_message_None_when_timeout(self):
    q = Queue(maxsize=1)
    self.assertEqual(None, get_message(q, 0.01))

def test_put_message_False_when_full(self):
    q = Queue(maxsize=1)
    self.assertTrue(put_message(q, 'hey1'))
    self.assertFalse(put_message(q, 'hey2'))
```

Then he extended the experiments to inter-process communication: a `worker()` function on a separate `Process` echoing messages from an input queue to an output queue — the approach he expected at the time to use to separate the Hydra core from the web server.

The kicker: "who expects Python to change? So, there is no future payback." But Python did change. During the Python 2 to 3 migration, packaging changed and some edits were needed, and the learning tests confirmed the queue/process behavior was preserved. Learning tests cost nothing (you must learn the mechanics anyway) and pay off on every third-party release.

Lesson: explore foreign APIs in tests, not in production code; keep those tests as a tripwire for behavioral changes in new releases.

### The Transmitter: coding against an API that doesn't exist yet

Years earlier, on a radio communications system, Grenning's team depended on a "Transmitter" subsystem whose owners hadn't yet defined an interface — the hardware and API didn't exist. Rather than be blocked, the team worked away from the unknown, and as they bumped against the boundary they learned what they *wanted* the interface to be. They could state it in a sentence: "Key the transmitter on the provided frequency and emit an analog representation of the data coming from this stream."

So they defined the interface they wished they had — a `Transmitter` with a `transmit(frequency, dataStream)` method — and wrote their `CommunicationsController` classes against it. Because the interface was under their control, the client code stayed clean, readable, and focused on its own purpose, unburdened by implementation details no one knew yet. Notably, had a hardware abstraction layer (HAL) existed, they probably would have depended on it — and HALs are usually not very abstract from the application's perspective. Not having one turned out to be an advantage.

When the real transmitter API finally arrived, they wrote a `TransmitterAdapter` to bridge the gap, giving a single place to change as the API evolves. The design also gave them a convenient testing seam: with a suitable `FakeTransmitter` they could test the controllers, and once they had the real API they could also create boundary tests to make sure they were using it correctly.

Lesson: at the boundary between known and unknown, invent the interface you wish you had, code against it, and adapt to reality later.
