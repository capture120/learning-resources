# Chapter 4: Storage and Retrieval — Examples

All examples below come from the chapter, retold in plain language.

## The world's simplest database: two bash functions

The chapter opens with a key-value store written in two lines of bash. `db_set` appends `key,value` to a text file; `db_get` greps for the key and takes the last match. Storing a JSON document under key 42 and reading it back works fine. Updating key 42 appends a new line rather than overwriting the old one, so the file accumulates both versions and `db_get`'s `tail -n 1` picks the latest.

Writes are fast because appending to a file is the cheapest possible write — this is exactly the append-only log many real databases use internally. But reads are O(n): every lookup scans the entire file. Real databases also handle concurrency, disk-space reclamation, and crash recovery, but the core tension is visible already.

**Demonstrates:** logs make writes cheap; without an index, reads degrade linearly, which is why indexes exist.

## Hash map over the log

To fix slow reads while keeping the append-only file, keep an in-memory hash map from each key to the byte offset of its latest value (Figure 4-1). Each append updates the map; each read seeks directly to the offset. If the data is in the filesystem cache, a read needs no disk I/O at all.

The example then surfaces the approach's limits: disk space grows forever, restarts require rescanning the log to rebuild the map, the entire keyset must fit in RAM, and range scans (e.g., all keys 10000–19999) require one lookup per key.

**Demonstrates:** why hash indexes are rarely used as the main database index, motivating sorted structures.

## SSTable sparse-index lookup: finding "handiwork"

In a sorted SSTable, you only need some keys in memory. Suppose the sparse index says one block starts at "handbag" and the next at "handsome". To find "handiwork" — absent from the sparse index — sorting guarantees it must lie between those two keys, so you seek to "handbag"'s offset and scan a few kilobytes (Figure 4-2). Each block can also be compressed, trading a little CPU for less disk space and I/O bandwidth.

**Demonstrates:** sorted files allow a sparse index — you trade a small in-block scan for a dramatically smaller in-memory index.

## Merging SSTable segments

Compaction (Figure 4-3) works like mergesort: read the segment files side by side, repeatedly copy the lowest key to the output, and when the same key appears in multiple inputs, keep only the value from the most recent segment. The output is a new sorted segment with one value per key, produced with minimal memory because the inputs are iterated one key at a time.

**Demonstrates:** sorted immutable segments make background compaction cheap and streaming-friendly.

## Bloom filter: "handbag" and "handheld"

A 16-bit Bloom filter example (Figure 4-4): key "handbag" hashes to positions (2, 9, 4), so those bits are set to 1. Later, a query for "handheld" hashes to (6, 11, 2). Bit 2 is set, but bits 6 and 11 are 0 — so "handheld" is definitely not in this SSTable and the segment is skipped without consulting its sparse index or decoding any block. If all three bits had been 1, the key would only *probably* be present (false positives happen when other keys' bits coincide), and the engine would consult the sparse index to confirm — a little wasted work, no incorrect results.

The chapter's sizing rule: roughly 10 bits per key gives a 1% false-positive rate, and every additional 5 bits per key cuts the rate tenfold.

**Demonstrates:** a small probabilistic structure eliminates most useless segment reads in LSM engines; false positives are harmless here because they're always verified.

## Size-tiered compaction: four 256 MB SSTables become 898 MB

Under size-tiered compaction, newer small SSTables merge into older large ones. The chapter's example: four 256 MB SSTables compact into one 898 MB SSTable — not 1,024 MB, because deletions, overwrites, and TTL expirations shrink the result. Old SSTables grow very large and merging them needs lots of temporary disk space, but most data gets rewritten only a few times in big sequential merges, so write throughput is excellent.

**Demonstrates:** size-tiered compaction favors write throughput at the cost of disk-space spikes and bigger reads.

## Leveled compaction: L1 split into a–m and n–z

Leveled compaction keeps SSTables at a fixed size and arranges them in levels. L0 holds the newest data; every deeper level is key-range partitioned — e.g., L1 might hold two SSTables, one covering keys a–m and one covering n–z — and each level is larger than the one above. When a level exceeds its size limit, SSTables from it merge into the next level down. Reads touch fewer SSTables because each level partitions the key space.

**Demonstrates:** leveled compaction trades more incremental merging for better read efficiency and lower space overhead.

## Per-tenant embedded databases

The chapter notes embedded engines (RocksDB, SQLite, LMDB, DuckDB, KùzuDB) run as libraries inside your process. Beyond mobile apps, one backend scenario: a multitenant system where each tenant's data is small and never queried jointly with other tenants' data can run a separate embedded database instance per tenant.

**Demonstrates:** when data fits one machine and tenants are isolated, an embedded engine can replace a database server.

## B-tree lookup: finding key 251

Figure 4-5 walks a lookup for key 251. Start at the root page, which holds boundary keys and child references; 251 falls between boundaries 200 and 300, so follow that reference. The child page subdivides 200–300 further; follow the 250–270 reference. Eventually a leaf page contains the key with its value inline or a pointer to it. With a branching factor in the hundreds, most databases fit in a tree 3–4 levels deep — the chapter notes a four-level tree of 4 KiB pages with branching factor 500 can address up to 250 TB.

**Demonstrates:** B-tree reads are a handful of page reads with predictable latency.

## B-tree page split: inserting key 334

Figure 4-6 shows inserting key 334 when the page covering 333–345 is full. The page splits into two half-full pages — 333–337 (receiving the new key) and 337–345 — and the parent gains a reference to both children with boundary 337. If the parent is also full, it splits too; splits can cascade to the root, and splitting the root adds a new root, which is how the tree gains depth while staying balanced.

The chapter then points out the danger: a split overwrites several pages, and a crash partway through can leave a corrupted tree (orphan pages) or a torn page — which is why B-trees need a write-ahead log.

**Demonstrates:** how B-trees grow while staying balanced, and why multi-page in-place updates demand WAL-based crash recovery.

## SSD garbage collection: why random writes still cost on flash

Flash memory reads and writes in ~4 KiB pages but erases only in ~512 KiB blocks. A sequential workload writes large chunks, so a whole block usually belongs to one file; deleting the file frees the block for erasure with no extra work. A random workload leaves each block a mix of valid and dead pages, so before erasing, the controller must copy the valid pages elsewhere — garbage collection that steals write bandwidth from the application and wears out the flash faster.

**Demonstrates:** sequential writes beat random writes even on SSDs, so the LSM write pattern still wins on modern hardware.

## Benchmarking an empty LSM-tree

When measuring write throughput, the chapter warns that a freshly created LSM-tree has no compaction running, so all disk bandwidth serves new writes and throughput looks great. As the database grows, compaction starts competing for the same bandwidth and sustained throughput drops. Benchmarks must run long enough for write amplification to show.

**Demonstrates:** short benchmarks systematically flatter log-structured engines.

## The fruit-versus-candy query (Example 4-1)

A warehouse query asks whether people buy more fresh fruit or candy depending on the weekday: it joins `fact_sales` to `dim_date` and `dim_product`, filters to 2024 and the two product categories, and sums quantity grouped by weekday and category. The fact table has 100+ columns, but the query touches only three (`date_key`, `product_sk`, `quantity`). A row-oriented engine would still load all the wide rows from disk and discard most of each. Columnar storage reads just the three column files.

**Demonstrates:** the canonical motivation for column-oriented storage — analytical queries scan many rows but few columns.

## Bitmap encoding of product_sk

A retailer may have billions of sales rows but only ~100,000 distinct products. Figure 4-8 turns a `product_sk` column into one bitmap per distinct value, one bit per row; sparse bitmaps are then run-length encoded. Queries map directly to bit operations: `WHERE product_sk IN (31, 68, 69)` ORs three bitmaps; `WHERE product_sk = 30 AND store_sk = 3` ANDs bitmaps from two columns, which works because both columns store rows in the same order. The chapter notes bitmaps can even answer social-graph queries like "users followed by X who also follow Y."

**Demonstrates:** low-cardinality columns compress to bitmaps that make warehouse predicates nearly free.

## Choosing date_key as the first sort key

If queries usually target recent date ranges, sorting the table with `date_key` first lets a last-month query scan only that slice instead of all rows. Making `product_sk` the second key groups same-product sales within each day, helping per-product filters and groupings. Sorting also compresses: the first sort key has long runs of identical values, so run-length encoding can shrink a column of a billion rows to a few kilobytes — though the effect weakens for later sort keys, which appear increasingly jumbled.

**Demonstrates:** picking sort keys to match query patterns buys both scan pruning and compression.

## Vectorized banana query

To find all sales of bananas in one store, pass the `product_sk` column plus the banana ID to an equality operator, getting back a bitmap; do the same for `store_sk` and the store ID; AND the two bitmaps (Figure 4-9). A fixed set of such batch operators, working on whole columns at a time in tight loops, is what makes interpreted query execution fast — versus the alternative of JIT-compiling each query to machine code.

**Demonstrates:** vectorized execution turns row-by-row interpretation into batch bit operations that modern CPUs run efficiently.

## Data cube: dates by products

Figure 4-10 sketches a two-dimensional cube: dates along one axis, products along the other, each cell holding the sum of `net_price` for that date-product pair. Summing along a row or column collapses one dimension — total sales per product across all dates, or per date across all products. Real fact tables have more dimensions (date, product, store, promotion, customer makes a 5-D hypercube), but the principle holds. "Total sales per store yesterday" becomes a lookup along precomputed totals instead of a scan over millions of rows. The flip side: if a question involves an attribute that isn't a dimension — what share of sales came from items over $100, when price isn't a dimension — the cube cannot answer it, so warehouses keep the raw data and treat cubes as a cache.

**Demonstrates:** materialized aggregates trade query flexibility for precomputed speed.

## Phone book: the concatenated index

A paper phone book indexes (lastname, firstname) → phone number. You can find everyone named "Smith", or "Smith, John", but it is useless for finding everyone named "John" regardless of surname, because firstname is sorted only within each lastname.

**Demonstrates:** concatenated multi-column indexes only serve queries on a prefix of their columns.

## Restaurant search on a map

A restaurant site stores each restaurant's latitude and longitude. When a user views a map rectangle, the site needs every restaurant with latitude between 51.4946 and 51.5079 AND longitude between -0.1162 and -0.1004. A concatenated (latitude, longitude) index can return either a latitude band at any longitude, or a longitude band spanning pole to pole — never both constraints at once. The fixes are a space-filling curve plus a regular B-tree, or spatial structures like R-trees or Bkd-trees that group nearby points in the same subtree (PostGIS builds R-trees on PostgreSQL's GiST).

The chapter extends the idea beyond geography: an (R, G, B) index for color-range product search, or a (date, temperature) index to find all observations in a year with temperature between 25 and 30°C — a one-dimensional index would force scanning everything in the year and filtering by temperature, or vice versa.

**Demonstrates:** range predicates on two dimensions simultaneously require true multidimensional indexes.

## "Canceling your subscription" vs. "how to close my account"

A help center has a page titled "canceling your subscription." Users search "how to close my account" or "terminate contract" — no shared words, same meaning. Keyword search fails; semantic search succeeds by embedding documents and queries as vectors and matching by proximity. This is also the retrieval step in retrieval-augmented generation for LLMs.

**Demonstrates:** embeddings capture meaning beyond keyword overlap, motivating vector search.

## Three Wikipedia pages as vectors

A toy three-dimensional embedding: a page about agriculture sits at [0.38, 0.83, 0.41], a page about vegetables nearby at [0.36, 0.64, 0.67], and a page about star schemas far away at [0.85, 0.10, -0.52]. Semantic similarity becomes geometric closeness, measured with cosine similarity or Euclidean distance. Real models use vectors of 1,000+ numbers, and the individual numbers carry no human-interpretable meaning.

**Demonstrates:** how embedding distance encodes semantic relatedness, the basis for vector indexes (flat, IVF, HNSW).

## Searching an HNSW index

Figure 4-11 walks a query through an HNSW vector index. The index keeps multiple layers of the vector space, each a graph whose nodes are vectors and whose edges connect nearby vectors. The query first finds the nearest vector in the topmost layer, which holds only a few nodes. It then drops to that same node in the layer below — which is more densely connected — and follows edges toward vectors ever closer to the query vector, repeating layer by layer until the bottom. Like IVF, the result is approximate.

**Demonstrates:** coarse-to-fine graph navigation finds near neighbors in high-dimensional spaces without comparing against every vector.

## Trigrams of "hello"

The trigrams of "hello" are hel, ell, and llo. Indexing all trigrams of all documents in an inverted index supports searching for arbitrary substrings of three or more characters, and even regular-expression queries — at the price of a large index.

**Demonstrates:** n-gram indexes trade index size for substring and regex search power.
