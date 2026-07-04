# Starting from Scratch — Examples

Every figure in the chapter, paraphrased with enough context to learn the lesson without seeing it.

## Start with a feature, not a layout

**Three app-shell wireframes with question marks.** Three skeleton layouts of the same hypothetical app: top nav with a contained list, left sidebar with a table, and a full-width card grid. Each is stamped with a question mark. The point: choosing between shells is unanswerable at the start because no feature exists yet to inform the choice. Shell questions (top nav or sidebar? items left or right? contained or full-width? where's the logo?) only resolve themselves after features are designed.

**Flight search, feature only.** For a flight booking service, the "search for a flight" feature needs exactly five elements: departure city field, destination city field, departure date field, return date field, and a search button. The figure shows just that — a centered white card with "Leaving from…", "Going to…", Depart, Return, and a dark "Search Flights" button under a single modest heading ("Find the best deals on flights right now"), on a plain background. No nav, no logo placement, no footer. Lesson: a real, designable starting point needs nothing but the feature's own elements.

**Flight search as a finished page.** The same search form, now polished: a hero layout with a logo mark, large "Find the best deals on flights right now" headline, a star-rating social-proof line ("rated 4.5 out of 5 based on 3200+ reviews"), and the search card enriched with Round Trip/One Way radios, passenger and cabin-class selectors, and small icons inside every field (map pins, calendars) — detail that only appears at the polish stage. Notably, the headline is the exact same text that sat as the modest heading above the bare card, now promoted to hero scale, and all five original elements (two city fields, two date fields, search button) persist unchanged — the polish pass restyles and extends the feature-first artifact rather than replacing it, so nothing from the bare version is thrown away. There is still no traditional app shell — the feature essentially is the page, like Google's homepage. Lesson: you may never need the shell you were tempted to design first, and starting with just the feature isn't wasted work.

## Detail comes later

**Sharpie wireframe.** A layout sketched on paper with a thick marker: rough rectangles for content rows, a circle for an avatar, heavy bars for headings and buttons. A Sharpie physically cannot render typefaces, shadows, or icons, so you can only make layout-level decisions — which is exactly the level that matters early, and it lets you burn through many layout ideas fast.

**Grayscale signup/pricing screen (before color).** A "Choose the amount of storage that's right for you" screen: a signup form (name, email, password, card number) with a "Create Account" button on the left, three plan cards (Essential 200 GB $10/mo, Pro 1 TB $20/mo, Premium 2 TB $40/mo) on the right, a yearly/monthly billing toggle. Everything is gray. Hierarchy is built entirely from size (big bold storage amounts), weight, contrast (dark button, muted labels), and spacing — and the selected plan reads clearly via a darker border and checkmark even without color.

**The same screen with color added.** Identical layout, but the button, billing toggle, selected-plan border, and checkmark become indigo. Because the grayscale version already had strong hierarchy, color is a small finishing layer that highlights the same things the gray design already emphasized. Lesson: design so color enhances hierarchy rather than creating it.

## Don't design too much

**A pile of overlapping wireframes.** Dozens of screen mockups scattered on top of each other, representing an entire app designed up front. It illustrates the trap of trying to resolve every interaction and edge case (a screen with 2000 contacts, error message placement, two calendar events at the same time) in the abstract, with only a design tool and imagination.

**One screen in focus, the pile blurred behind it.** A single simple wireframe sharp in the center while all the other screens fade into the background. The working method: design only a simple version of the next feature, make it real, fix problems in the usable interface, then design the next one.

**Design/Code cycle diagram.** A circular two-arrow loop labeled Design at the top and Code at the bottom. Short alternating cycles keep you out of the abstract; building early means your imagination doesn't carry all the load.

**Comment box with attachments (the pessimist's cautionary example).** A "Add a new comment" card for a project management tool: avatar, message textarea, a dashed drop zone reading "Attach files by dragging & dropping or selecting them", a "Some HTML is OK" hint, and a Post Comment button. Attachments were included because they'd be nice someday. In implementation, attachments turn out to be far more work than expected; with no time to finish, the whole commenting system stalls — nothing ships, even though comments without attachments would have been valuable.

**Comment box without attachments.** The same card minus the drop zone: avatar, textarea, HTML hint, Post Comment. This is the smallest useful version — shippable now, with attachments designed later as a true nice-to-have. Lesson: expect features to be hard to build; never let a deferred extra block a shippable core.

## Choose a personality

**Bank vs. social startup landing pages.** "Union Bank" uses a photo of an older couple, a padlock logo, restrained dark teal, and institutional financial copy: under the headline "Saving just got a lot easier", the subheading reads "Earn 4.00%* interest when you setup your first Savings Account, TFSA or RSP" — a precise interest rate with a fine-print asterisk and financial-product acronyms. The jargon-laden, fine-print register of the copy is itself part of what makes the page read secure and professional. "Digest", a discussion startup, uses pastel cartoon avatar illustrations connected by dotted lines, a bright teal CTA, and friendly copy — it reads fun and playful. Same genre of page, opposite personalities, all from concrete choices.

**Serif font for elegance.** "Argyle — Modern bookkeeping for digital businesses" sets its headline in Freight Text, a serif. Paired with a professional handshake photo and a deep purple button, the serif gives a classic, elegant, trustworthy feel.

**Rounded sans serif for playfulness.** "Heroicons UI", a free icon set, sets its headline in Proxima Soft, a rounded sans serif, with a bright purple pill-shaped download button and a purple icon grid. The rounded letterforms make it feel friendly and playful.

**Neutral sans serif for a plain look.** "CoSpace — A Workspace for the World's Biggest Companies" uses Freight Sans over a duotone photo with a yellow button. The neutral typeface stays out of the way, letting imagery and color provide the personality.

**Blue = safe and familiar.** "ChitChat", a customer live-chat product, is rendered almost entirely in blue: logo, CTA, chat bubbles. Blue is the safe default — nobody ever complains about it.

**Gold = expensive and sophisticated.** "Oasis Sky Lounge — Toronto's most luxurious rooftop lounge" pairs a muted gold "Make a Reservation" button with a thin-line logo, serif headline, and a dramatic black-and-white aerial city photo. The gold accent signals luxury.

**Pink = fun, not serious.** "Citywide tours like no other", a hop-on hop-off tour site, uses a pink map-pin logo and pink "Book a Tour" button over a flat pastel city illustration. Pink keeps it lighthearted.

**Small border radius = neutral.** "Roommate", a meeting-room scheduling tool, uses slightly rounded corners on its "Book a Demo" button and Sign in chip. The small radius carries no strong personality by itself — it's the safe middle.

**Large border radius = playful.** "cleargrowth", a startup analytics dashboard, uses fully rounded pill buttons ("Start free trial", "See demo"), rounded stat cards, and a big purple circle motif. The generous rounding makes a numbers product feel approachable and playful.

**No border radius = serious/formal.** "Fusion Ventures — We invest in companies that make a difference" uses perfectly square corners on its button and layout blocks. Sharp corners read formal and serious, fitting an investment firm. The accompanying rule: whatever radius you choose, keep it consistent — mixing square and rounded corners in one interface almost always looks worse.

**Formal vs. casual language in an identity-verification flow.** Two versions of the same "Verify your identity" step (numbered progress bubbles, phone field, Continue button). The formal one, in corporate blue: "Thank you Mr. Benson. To confirm your identity, please provide a phone number where we can send you a verification code." The casual one, in pink: "Sweet, thanks Steve! Just to make sure this is really you, where can we send you a verification code?" Identical functionality; the copy alone shifts the product from official to friendly. Words shape personality as much as color or type.

## Limit your choices

**Three near-identical blue buttons.** Three "Download" buttons with backgrounds #3381B8, #2F7DB3, and #2D78AD. By eye they are indistinguishable. With an unconstrained color picker, none of these is a wrong choice, so no choice can feel confident — the demonstration of why limitless options are paralyzing.

**A pre-picked blue palette.** Ten shades of blue laid out from near-black navy to almost-white, chosen ahead of time. When a new shade is needed, you pick from these 8–10 instead of opening the color picker — the decision space shrinks from millions to ten.

**A fixed type scale.** A specimen showing the sentence "The quick brown fox jumps over the lazy dog" at exactly 12, 14, 16, 18, 20, 24, 32, and 48px. Each step is noticeably different from its neighbors, so font-size decisions become picking one of eight distinct options rather than nudging pixels.

**Icon size scale.** Four red squares at 12, 16, 24, and 32px — the only small-to-medium icon sizes the system allows.

**Elimination round one.** The same "Bookmark" button rendered with its icon at 12, 16, and 24px. You guessed 16px and compare it against both neighbors; odds are two of the three will look obviously bad, and if it's the two outer ones, the middle 16px is the only good choice and you're done.

**Elimination round two (re-centering).** Four "Bookmark" buttons: the eliminated 12px option grayed out on the left, with 16, 24, and 32px active beside it. If an outer option from the first comparison had looked best (say 24px), you repeat the comparison with it as the new middle (16/24/32) to confirm nothing better sits beyond it. Because system values differ noticeably, two of any three options are usually obviously bad — picking becomes trivial. This works for any property you've systematized.
