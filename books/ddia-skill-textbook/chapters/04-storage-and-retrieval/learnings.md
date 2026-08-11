# Chapter 4: Storage and Retrieval — Core Learnings

**Central thesis:** A database does two things: store data you give it, and find it again when you ask. Storage engines optimized for transactional workloads (OLTP) look fundamentally different from those optimized for analytics (OLAP), and within OLTP there are two main schools: log-structured engines that write immutable files (LSM-trees) and update-in-place engines built on fixed-size pages (B-trees). Knowing how the engine works under the hood is what lets you pick the right one for your workload and tune it sensibly. (The chapter's epigraph, from Feynman: computers don't primarily compute — "they primarily are filing systems.")

## Indexes: the fundamental trade-off

- An index is a derived structure built from primary data. Adding or removing it never changes the data, only query performance.
- **Core trade-off: every index speeds up some reads but consumes disk space and slows down every write**, because the index must be updated on each write. Appending to a plain file is the fastest possible write; anything more costs.
- Databases therefore don't index everything by default. You choose indexes based on your application's query patterns.
- Without an index, a key lookup in an append-only log is O(n) — a full scan.
- Terminology: in this book a **log** means any append-only sequence of records on disk — possibly binary and purely internal to the database — not just human-readable application logs.

## Log-Structured Storage (LSM-trees)

### Hash-indexed log (the simplest index)
In-memory hash map: key → byte offset of latest value in an append-only log. Fast, but four problems:
1. Old overwritten values are never reclaimed; disk fills up.
2. The hash map isn't persisted; rebuilding it on restart requires scanning the whole log.
3. The hash table must fit in memory (on-disk hash maps perform poorly: random I/O, expensive growth, collision handling).
4. Range queries are impossible without looking up every key individually.

This is why production engines use **sorted** structures instead of hash indexes.

### SSTables
- **Sorted Strings Table**: file of key-value pairs sorted by key, each key appearing once.
- Enables a **sparse index**: store only the first key of each block (a few KB each), kept in a separate part of the SSTable as a structure with fast key lookup (e.g., an immutable B-tree or trie). To find a key, look up the preceding block boundary in the sparse index, seek to that block, scan it. You don't need all keys in memory.
- Blocks can be compressed: saves disk space and I/O bandwidth at the cost of some CPU.

### The LSM-tree algorithm
1. Writes go to an in-memory sorted structure (**memtable**: red–black tree, skip list, or trie).
2. When the memtable exceeds a threshold (typically a few MB), write it out as a new immutable SSTable segment. Writing continues into a fresh memtable.
3. Reads check the memtable first, then segments from newest to oldest, stopping at the first hit.
4. Background **compaction** merges segments mergesort-style, keeping only the newest value per key, and deletes the inputs afterward.

Supporting mechanisms:
- **Crash recovery log:** every write is also appended to an unsorted log on disk so the memtable can be rebuilt after a crash. That log portion is discarded once the memtable is flushed. Checksums detect and discard partially written log records.
- **Tombstones:** deletes are written as special deletion records; compaction uses them to drop earlier values. A tombstone can be removed only once it has reached the oldest segment.
- **Immutability advantages:** segments are written once, never modified. Crash mid-write? Delete the unfinished file and restart. Reads continue against old segments during a merge; switch atomically when done. Segments also work well on object storage (SlateDB, Delta Lake).
- Used by: RocksDB, Cassandra, ScyllaDB, HBase (all descended from Google's Bigtable paper, which coined "SSTable" and "memtable"). The design was published in 1996 as the Log-Structured Merge-tree, building on earlier log-structured filesystems.

### Bloom filters
- Problem: reading a missing key (or one updated long ago) requires checking many segments.
- A Bloom filter per SSTable answers "might this key be here?" using k hash-derived bit positions. **If any queried bit is 0 → key definitely absent (skip the segment). If all queried bits are 1 → key probably present** (false positives possible; you do a little wasted work, no correctness issue).
- **Rule of thumb: ~10 bits per key gives ~1% false-positive rate; each extra 5 bits per key cuts the rate 10×.**
- Bloom filters do NOT help range queries (you can't hash every possible key in a range).
- The filter is stored inside the SSTable alongside the sparse index and is generally small relative to the rest of the file; membership checks use the bitwise operations all CPUs support, so they are extremely fast.

### Compaction strategies
- **Size-tiered:** merge newer, smaller SSTables into older, larger ones. Handles very high write throughput (data rewritten few times, in large sequential merges), but old SSTables get huge and merging needs lots of temporary disk space.
- **Leveled:** fixed-size SSTables organized into levels L0, L1, …; levels beyond L0 are key-range-partitioned; each level larger than the last. Overflowing SSTables merge into the next level. More incremental, less disk space, fewer SSTables to check per read.
- **Choose size-tiered when write-heavy with few reads; choose leveled when read-dominated**, or when a few hot keys are written frequently and many keys rarely.

## B-Trees

- The most widely used index structure (since 1970); standard in nearly all relational databases and many non-relational ones.
- Like SSTables, keys are sorted (so lookups and range queries are efficient), but the design is opposite: the database is broken into **fixed-size pages** (traditionally 4 KiB; PostgreSQL 8 KiB, MySQL 16 KiB) that are **overwritten in place**.
- Pages reference each other by page number (disk pointers), forming a tree; if all pages live in one file, page number × page size gives the byte offset. A lookup walks from the root, following the child whose key range contains the target, down to a leaf page holding the value or a reference to it. (This structure is sometimes called a B+ tree, but the distinction from other variants rarely matters.)
- **Branching factor** (child references per page) is typically several hundred. The tree stays balanced: depth O(log n). **Most databases fit in 3–4 levels; a 4-level tree of 4 KiB pages with branching factor 500 stores up to 250 TB.** So a lookup costs only 3–4 page reads.
- Updating an existing key = overwrite its leaf page in place. The overwrite is assumed not to move the page, so every reference to it stays intact — the stark opposite of LSM files, which are never modified once written.
- Insert into a full page → **page split** into two half-full pages, parent updated with the new boundary; splits can cascade to the root, where a new root is created. Deleting keys is more complex than inserting: it may require merging nodes.

### Reliability mechanisms
- Overwriting multiple pages (e.g., a split) is dangerous: a crash mid-way leaves a corrupted tree (orphan pages), and non-atomic page writes leave **torn pages**.
- Fix: a **write-ahead log (WAL)** — every modification is appended to the WAL before being applied to pages; on crash, the WAL restores consistency. (Filesystem equivalent: journaling.) Pages are buffered in memory and flushed lazily; durability comes from the WAL plus `fsync`.
- Variants: **copy-on-write** instead of WAL (LMDB) — write modified pages to new locations and re-point parents; also useful for snapshot isolation. **Key abbreviation** in interior pages raises branching factor and lowers depth. Sequential leaf layout speeds range scans (hard to maintain). **Sibling pointers** between leaves speed in-order scans.

## B-Trees vs. LSM-Trees: decision guidance

**Rule of thumb: LSM-trees for write-heavy workloads, B-trees for read-heavy.** But benchmarks are workload-sensitive — test with your own workload. Hybrids exist (multiple B-trees merged LSM-style).

| Dimension | B-tree | LSM-tree |
|---|---|---|
| Point reads | Fast, predictable (one page per level) | Must check memtable + several SSTables; Bloom filters mitigate |
| Range queries | Simple and fast | More expensive: scan all segments in parallel and merge; Bloom filters don't help |
| Write pattern | Random writes (scattered page overwrites) | Sequential writes (whole segments) |
| Write throughput | Lower | Higher on same hardware |
| Write latency | No compaction-induced stalls | Spikes possible: if compaction can't keep up and the memtable fills, engines (e.g., RocksDB) apply backpressure and suspend reads and writes |
| Disk space | Fragmentation; freed pages stay in the file (needs e.g. PostgreSQL vacuum) | Compaction rewrites files; better block compression; smaller on disk. Size-tiered compaction temporarily uses lots of space |
| Snapshots/backups | Hard (pages overwritten in place) | Easy: record which immutable segments existed; no copying needed |
| Hard deletion (compliance) | Direct | Deleted data lingers until the tombstone propagates through all compaction levels — can take a long time (specialist engine designs can propagate deletions faster) |

- Read-throughput note: modern NVMe SSDs (PCIe rather than SATA) serve many independent reads in parallel. Both families can deliver high read throughput, but only if the storage engine is designed to exploit that parallelism.

### Sequential vs. random writes
- Disks have higher sequential than random write throughput. The gap is huge on spinning disks (mechanical head seek = milliseconds) and smaller but still real on SSDs.
- On SSDs the reason is flash garbage collection: flash writes in ~4 KiB pages but erases in ~512 KiB blocks. Sequential writes tend to fill whole blocks that can be erased together; random writes mix valid and dead pages in each block, forcing the controller to relocate valid pages before erasing. GC consumes write bandwidth and wears out the drive faster.

### Write amplification
- Definition: total bytes written to disk ÷ bytes the application logically wrote (sometimes counted in I/O ops instead).
- LSM writes each value multiple times: crash-recovery log, memtable flush, then once per compaction it participates in. (If values are much larger than keys, store values separately and compact keys only — the WiscKey approach.)
- B-trees write everything at least twice (WAL + page), and sometimes must write out a whole page even when only a few bytes changed, to ensure correct recovery after a crash or power failure.
- Which side has lower amplification depends on key/value lengths and how often you overwrite existing keys versus insert new ones; **for typical workloads, LSM-trees have lower write amplification** (no full-page writes; compressible SSTable blocks). Lower write amplification means more application writes per second within a disk-bandwidth budget, and slower SSD wear.
- **Benchmark gotcha:** an empty LSM-tree has no compaction running, so initial write throughput looks artificially high. Run write benchmarks long enough for compaction to share the disk bandwidth.

## Secondary indexes and value placement

- A secondary index is a key-value index where indexed values aren't unique. Handle duplicates either by storing a list of matching row IDs per entry (like a postings list) or by appending the row ID to the key to make it unique. Both B-trees and LSM structures work.
- Where the row data lives:
  - **Clustered index:** the row is stored inside the index (MySQL InnoDB primary key; SQL Server allows one per table).
  - **Reference:** the index value points at the data instead of containing it — either the row's primary key, resolved via the clustered index (InnoDB secondary indexes do this), or a direct disk location in a **heap file** storing rows in no particular order (PostgreSQL); the heap may be append-only, or track deleted rows so their space can be overwritten with new data.
  - **Covering index:** stores some columns in the index so certain queries are answered from the index alone — faster reads, more space, slower writes.
- Heap-file update gotcha: overwriting in place works only if the new value isn't larger. Otherwise the row moves, and either every index must be updated or a forwarding pointer left at the old location.

## In-memory databases

- Motivation: disks earn their awkwardness (careful data layout needed for performance) through two advantages — durability across power loss, and lower cost per gigabyte than RAM. Cheaper RAM erodes the cost argument: many datasets simply fit in memory, potentially spread across several machines.
- Durability options: battery-backed RAM, append-only change log on disk, periodic snapshots, or replication. Redis and Couchbase write to disk asynchronously (weak durability). Memcached is cache-only (data loss on restart is acceptable). Still "in-memory" because reads are served entirely from memory; the disk log also has operational benefits (files can be backed up and inspected with external tools).
- **Counterintuitive point: the speed advantage is not from avoiding disk reads** — the OS page cache means a disk-based engine with enough RAM rarely reads from disk anyway. The win is avoiding the overhead of encoding in-memory structures into disk-writable form.
- In-memory databases can also offer data models hard to do on disk (e.g., Redis's priority queues and sets).
- Examples: VoltDB, SingleStore, Oracle TimesTen, RAMCloud (durable, log-structured in memory and on disk).

## Embedded storage engines

- Libraries in your process (RocksDB, SQLite, LMDB, DuckDB, KùzuDB) rather than network servers.
- Good for: mobile apps; backends where the data fits one machine and concurrency is low; per-tenant databases in multitenant systems where tenants are small and never queried jointly.

## Data Storage for Analytics

- Warehouses stay relational/SQL because SQL fits analytical queries well and the many graphical analysis tools (drill-down, slicing and dicing) generate SQL.
- Data warehouses usually expose SQL like an OLTP database, but internals differ completely because query patterns differ. Many vendors focus on one or the other; HTAP products (SQL Server, SAP HANA, SingleStore) increasingly run two separate engines behind one SQL interface.
- **Cloud warehouses** (BigQuery, Redshift, Snowflake) decouple compute from storage (data in object storage), so each scales independently and integration with cloud services is easier.
- The open-source warehouse stack — components formerly integrated in one system such as Apache Hive — has decomposed into layers:
  - **Query engine** (Trino, Presto, DataFusion): parses, optimizes, executes SQL, often via distributed execution (sometimes delegating to Spark/Flink).
  - **Storage format** (Parquet, ORC, Lance, Nimble): how rows are encoded as bytes in immutable files.
  - **Table format** (Apache Iceberg, Delta Lake): which files constitute a table + schema; adds inserts/deletes over immutable files, time travel, GC, transactions.
  - **Data catalog** (Polaris, Unity Catalog): which tables make up a database; used to create, rename, and drop tables. Usually a standalone REST service (Iceberg also ships a catalog), enabling separate data discovery/governance tooling.

### Column-oriented storage
- The storage challenge is the fact table (trillions of rows, petabytes); dimension tables are usually far smaller (millions of rows) and manageable, so columnar techniques target facts.
- Fact tables are often 100+ columns wide, but a typical analytical query touches only 4–5. Row-oriented storage forces loading entire rows (even with indexes on the filtered columns, the engine still loads, parses, and discards the wide rows); **columnar storage stores all values of each column together, so a query reads only the columns it needs.** Document databases are row-oriented in this sense too: a document is stored as one contiguous byte sequence.
- Row reconstruction works because every column stores rows in the same order: the kth value of each column belongs to row k.
- In practice, tables are split into blocks of thousands–millions of rows, columnar within each block; blocks often correspond to timestamp ranges so date-bounded queries skip irrelevant blocks.
- Used by virtually all analytical databases: Snowflake, DuckDB, Pinot, Druid; formats Parquet/ORC/Lance/Nimble; in-memory formats Arrow, Pandas/NumPy; time-series DBs InfluxDB IOx, TimescaleDB. Parquet supports nested/document data via shredding (from Google's Dremel).
- **Naming gotcha:** "wide-column" / "column-family" databases (Bigtable, HBase, Accumulo) are NOT column-oriented — they store each row's values together.

### Column compression
- Columns compress well because values repeat. Key technique: **bitmap encoding** — a column with n distinct values becomes n bitmaps (one bit per row). Sparse bitmaps are then **run-length encoded**; **roaring bitmaps** switch between representations automatically.
- Works when distinct values are few relative to rows (e.g., billions of sales, 100,000 products).
- Bitmaps make warehouse predicates cheap: `WHERE x IN (...)` = bitwise OR of bitmaps; `WHERE a = ... AND b = ...` = bitwise AND (valid because all columns share row order).

### Sort order in column storage
- Easiest is insertion order (append to each column). Optionally sort whole rows (columns can't be sorted independently — that breaks row alignment) by admin-chosen keys matching common queries, e.g., `date_key` first so a last-month query scans only recent rows.
- Sorting boosts compression: the first sort key has long runs of repeated values → run-length encoding can shrink a billion-row column to a few KB. The effect fades for second/third sort keys and disappears beyond.

### Writing to columnar storage
- Inserting a single row into the middle of sorted, compressed column files would require rewriting everything from that point on — far too expensive.
- Solution: LSM-style. Writes accumulate in a row-oriented, sorted in-memory store; when enough accumulate, they're merged with on-disk column files into new immutable files (well-suited to object storage). Queries transparently combine in-memory recent writes with on-disk data. Snowflake, Vertica, Pinot, Druid do this.
- Warehouse writes are typically bulk ETL imports anyway, which amortize the rewrite cost.

### Query execution: compilation and vectorization
- A complex analytical query is first broken into a query plan of stages called operators, possibly distributed across machines; the planner optimizes by choosing which operators to use, in what order, and where each runs.
- Scanning millions of rows makes CPU time matter, not just I/O. A naive per-row interpreter is too slow. Two production approaches:
  - **Query compilation:** generate code for the specific query and JIT-compile it to machine code (often via LLVM).
  - **Vectorized processing:** interpret the query but process column values in batches through a fixed set of optimized operators (e.g., equality operator over a column returns a bitmap; combine bitmaps with bitwise AND).
- Both win by exploiting modern CPUs: sequential memory access (fewer cache misses), tight inner loops (no branch mispredictions, full pipelines), multithreading + SIMD, and operating directly on compressed data without decoding.

### Materialized views and data cubes
- **Virtual view:** a stored query, expanded at read time. **Materialized view:** the query's results physically stored; must be updated when underlying data changes (more write cost, cheaper repeated reads). Some databases update them automatically, and systems such as Materialize specialize in materialized view maintenance.
- **Data cube (OLAP cube):** materialized aggregates (SUM/COUNT/etc.) on a grid over dimension combinations; summarize along any dimension. Queries hitting precomputed cells are extremely fast.
- **Limit:** a cube can only answer queries over its dimensions — e.g., no "fraction of sales over $100" if price isn't a dimension. So warehouses keep raw data and use cubes only as a performance boost for hot aggregates.

## Multidimensional and Full-Text Indexes

- **Concatenated index:** several columns appended into one key (like phone book: lastname, firstname). Works for prefixes of the column list only — useless for searching the second column alone.
- **Multidimensional indexes** query several dimensions simultaneously, essential for geospatial (latitude AND longitude ranges at once — a concatenated index can't do this). Options: map 2D to 1D via a **space-filling curve** + ordinary B-tree; or specialized structures (**R-trees**, **Bkd-trees**) grouping nearby points in the same subtree (PostGIS uses R-trees via PostgreSQL's GiST); or regular grids (triangles/squares/hexagons).
- Multidimensional indexes also work for non-geo data: (R, G, B) color search, (date, temperature) queries.

### Full-text search
- Real information retrieval also needs language-specific processing — splitting text into words (some Asian languages have no spaces, so a model must decide word boundaries), matching grammatical variants and typos, and handling synonyms.
- Conceptually a multidimensional query where each term is a dimension (1 = document contains it): searching "red apples" means requiring a 1 in the *red* dimension AND a 1 in the *apples* dimension simultaneously.
- Core structure: **inverted index** — term → postings list of document IDs; with sequential IDs, a postings list can be a sparse bitmap, and multi-term AND queries are bitwise ANDs of bitmaps.
- **Lucene** (engine under Elasticsearch and Solr) stores term→postings in SSTable-like sorted files merged in the background — the same log-structured approach as LSM engines. PostgreSQL's GIN index uses postings lists too, supporting both full-text search and indexing inside JSON documents.
- **n-grams/trigrams:** index all length-n substrings to support arbitrary substring and even regex search; trade-off is large index size.
- **Fuzzy matching:** Lucene stores terms as a finite state automaton (trie-like) and turns it into a Levenshtein automaton to find words within a given edit distance (edit distance 1 = one letter added, removed, or replaced) for typo tolerance.

### Vector embeddings and semantic search
- Embedding models (often LLM-based; commonly 1,000+ dimensions) map documents to float vectors such that semantically similar documents are nearby. Distance measured by **cosine similarity** (angle between vectors) or **Euclidean distance** (straight-line distance). Enables matching "how to close my account" to "canceling your subscription."
- Early embedding models (Word2Vec, BERT, GPT) handled text, usually as neural networks; later models cover images, audio, and video, and recent multimodal models embed several modalities with a single model. At query time the user's query (plus context such as location) is embedded and the index finds the nearest document vectors.
- (Don't confuse with vectorized query processing — unrelated meanings of "vector.")
- R-trees don't work in high dimensions; specialized **vector indexes**:
  - **Flat:** compare query to every vector. Exact but slow.
  - **IVF (inverted file):** cluster vectors into partitions (centroids); search only some partitions ("probes"). Approximate because the query and a nearby document can fall into different partitions; more probes = more accurate, slower.
  - **HNSW (Hierarchical Navigable Small World):** multiple layers of graphs whose nodes are vectors and whose edges connect nearby vectors. The sparse top layer finds a rough nearest neighbor; the query then drops to the same node in each denser layer below and follows edges toward closer vectors until the bottom layer. Approximate.
- Implementations: Facebook's Faiss, PostgreSQL's pgvector (both IVF and HNSW).

## How this connects

- Builds on Chapter 1's OLTP-vs-analytics distinction and the cloud compute/storage separation, and on Chapter 3's data models and query languages (this chapter is the same problem from the database's side; star/snowflake schemas motivate columnar storage).
- Logs introduced here recur throughout the book. Durability, crash recovery, and the WAL are deepened in Chapter 8 (transactions); copy-on-write B-trees connect to snapshot isolation there.
- Chapters 6–7 cover scaling these single-node engines across machines (replication and partitioning).
- Materialized view maintenance returns in the stream-processing material ("Maintaining materialized views").
- Embedding models and semantic search feed AI/RAG use cases.
