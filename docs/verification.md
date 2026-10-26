# Verification record

## Breakout Phase 1 project phase document redesign (2026-10-26)

Typst version: `typst 0.15.1`. From the `course-materials` repository root, the 12-page modular project phase PDF was compiled successfully with:

```sh
PATH="/home/opmc/.cargo/bin:$PATH" ./scripts/build.sh breakout-phase-01
```

All 12 pages were rendered to numbered PNG files and visually verified individually:
- **Cover (p. 1):** Dedicated unnumbered cover with official 32 mm UT seal, department affiliation «دانشکده علوم کامپیوتر», course title «برنامه‌سازی پیشرفته», kind «فاز پروژه», title «هسته بازی Breakout», phase number «۰۱», and custom vector blueprint vignette (`130 × 70 mm`).
- **Table of Contents (p. 2):** Automated `#outline` with dotted leaders and clean section hierarchy.
- **Rules & Submission (p. 3):** Solo development, GitHub commit expectations, in-person oral defense, and Quera submission guidelines.
- **Introduction & Goals (p. 4):** Historical Atari 1976 Wozniak/Jobs sprint context, core OOP educational goals (SoC, SRP, Encapsulation, Event-driven architecture).
- **Pre-Phase 1 Actions (p. 5):** High-level tasks for GitHub repository setup, .gitignore configuration, and Conventional Commits; game feel exploration; and UML modeling in vertical card layout without horizontal columns.
- **System Architecture (p. 6):** MVC pattern with storytelling hook, vertically stacked MVC cards, 3-step data flow, and vertical `HighScoreStorage` interface definition followed by in-memory and file persistence cards.
- **Entities & Geometry (p. 7):** Uncompact, complete 175pt vector schematic of the 800×600 playfield with HUD bar, full 40-brick matrix in 5 colored rows, ball velocity trajectory, paddle bounds, and danger line; accompanied by 4 vertical entity cards with geometry definitions, vector badges, and encapsulation rules.
- **Gameplay & State Machine (p. 8):** Vector state machine diagram connecting all 5 states (`READY`, `RUNNING`, `PAUSED`, `GAME_OVER`, `VICTORY`) with directional transition arrows (Space launch, P pause/resume, ball drop life decrement loop, game over, victory, and R restart) plus states table.
- **Graphics & HUD (p. 9):** 2D coordinate system, double buffering mechanics with clean footnote terminology (no parenthetical glosses), and visual HUD requirements table.
- **Physics & Collisions (p. 10):** Segmented paddle deflection math with displayed equations on dedicated lines with full breathing room and physical explanations, split numerator ($Delta x$) and denominator ($w_"half"$) variable fractions matching Java implementation, complete Java code block, and AABB brick collision guidelines.
- **Implementation Milestones (p. 11):** Five discrete implementation milestones with acceptance criteria and commit strategy.
- **Evaluation Criteria (p. 12):** Comprehensive 100-point rubric (40 Functionality, 35 OOP Architecture, 15 Code Quality, 10 Oral Defense) and bonus challenges.

All pages adhere strictly to the 12-page budget (1 page per section) without clipped text or overflowing pages. All parenthetical English glosses `(#en[...])` across all sections have been completely replaced with `#footnote[#en[...]]` or clean card badges, and the convention is formally documented in `AGENTS.md` and `docs/document-style-guide.md`.

## Debugging, Search & AI student handout (2026-10-13)

Typst version: `typst 0.15.1 (unknown commit)`. From the repository root, with
`/home/opmc/.cargo/bin` added to `PATH`, the final eleven-page PDF was compiled
successfully with:

```sh
typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/debugging-ai-handout.typ output/pdf/debugging-ai-handout.pdf
```

All 11 pages were rendered to numbered PNG files with `typst compile --format png --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/debugging-ai-handout.typ /tmp/debugging-page-{p}.png`.
Every page was visually inspected individually:
- **Cover (p. 1):** Unnumbered, standard UT seal and course title, subtitle «چگونه با خطاها روبه‌رو شویم», clean metadata presentation.
- **Section 1 & Orientation (p. 2):** Body page ۱, GitHub example resource card, error taxonomy table (Compile, Runtime, Logic), and predict checkpoint.
- **Section 2 (pp. 3–4):** Compile error anatomy, `error-anatomy` component with `BatteryCalc.java:7` type mismatch, Golden Rule 1, 5 common compiler errors side-by-side using `example-columns`, and trace checkpoint.
- **Section 3 (p. 5):** Runtime error and stack trace anatomy, `AverageCalc.java:12` division by zero in sentinel loop, Golden Rule 2, 3 common runtime exceptions, and predict checkpoint.
- **Section 4 (p. 6):** Logic error and `Checkerboard.java` off-by-one error (5 rows instead of 4), expected vs actual output columns, late casting, wrong conditions, desk checking strategy, and try-it checkpoint.
- **Section 5 (p. 7):** Search query formula, professional search tricks, Google search mockup rendered with `border-frame`, Stack Overflow anatomy, 5 query templates checklist, and predict checkpoint.
- **Section 6 (pp. 8–10):** AI capabilities and limitations, prompt template with `prompt-example`, worked conversation mockup (bad vs good prompt) using `ai-conversation` and `chat-bubble`, do/don't comparative table, 5-step debugging workflow, and try-it checkpoint.
- **Recap & Self-Check (p. 11):** 4 self-check conceptual questions and a 5-item personal skill evaluation checklist.

Grayscale readability was verified; the dark fill of `terminal-block` maintains strong contrast without relying on syntax colors. All three standalone Java examples (`BatteryCalc.java`, `AverageCalc.java`, `Checkerboard.java`) were verified with `javac` and runtime execution. No automated tests were added.

## Java fundamentals student handout (2026-10-12)

Typst version: `typst 0.15.1 (unknown commit)`. From the repository root, with
`/home/opmc/.cargo/bin` added to `PATH`, the final seven-page PDF was compiled
successfully with:

```sh
typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/java-fundamentals-handout.typ output/pdf/java-fundamentals-handout.pdf
```

All seven pages were rendered to numbered PNG files in the ignored SDD workspace
with `typst compile --format png --ppi 144 --root . --package-path packages
--ignore-system-fonts --font-path resources/assets/fonts
src/documents/java-fundamentals-handout.typ
.superpowers/sdd/2026-10-13-java-fundamentals-student-handout/rendered/page-{p}.png`.
Every page was inspected individually in color and grayscale. Persian shaping
and paragraph direction, Latin identifiers, Java operators, code line fit,
headings, page breaks, page numbers ۱–۶ after the unnumbered cover, and footer
clearance were legible. No clipping or extra blank page appeared. The handout
uses code panels rather than tables; its checkerboard rows aligned in both
renderings. The initial rendering exposed reordered Java punctuation around
Persian string literals in code blocks. Those sample literals were changed to
short ASCII labels, then the PDF was recompiled and every page reviewed again;
the final code lines read in their intended order. Grayscale retains readable
text and code without relying on syntax colors. No automated tests were run.

## Dorost integration and archive hygiene (2026-10-12)

The course theme now uses Dorost's LTR, inline code/math, and Persian-digit
helpers. A local `@local/dorost:0.2.1` package snapshot keeps clean clones and
the portable archive buildable while the upstream Typst Universe entries are
pending. Dorost's inline-code helper accepts the course's font and size and
disables ligatures/contextual substitutions.

`./scripts/build.sh all` completed with exit code 0 for all eight entries, using
the bundled fonts and local package. Typst-rendered PNG previews of HW1's first
body page and the typography proof cover were visually inspected; inline Latin
terms, code, math, and surrounding Persian remain readable. `./scripts/package.sh`
created the source archive; its contents include Dorost and no Finder metadata.
An extracted archive successfully rebuilt HW1 without network access. The
generated archive is ignored. Git history contains the generated ZIP in two
early commits and no `.DS_Store` Git path. The full Dorost check compiled its
fixtures, including the new code-inline fixture, then stopped at its PDF text
inspection step because `pdftotext` is not installed in this environment.
`git diff --check` passed.

## Output-only prompts and final family review (2026-10-08)

Added the exact sentence “Your output must be only a p5.js codeblock.” on a separate line at the end of both prompt panels. One `output-instruction` field owns the copy; the theme renders it twice. The refined prompt now requests its explanation through code comments, respecting the output restriction. The editorial brief documents this requirement for future workshops.

`./scripts/build.sh all` completed with exit code 0 and no warnings, using bundled fonts and disabled system fonts. All nine entries rendered successfully with Poppler at 1200 px. The main editor visually reviewed all 32 editable-output pages and all 43 image-only story pages in contact sheets. The workshop reflection, HW1 submission page, bilingual proof page, and slide comparison were additionally inspected individually. No clipping, overlaps, extra blank pages, or lost current-output content were found. Both workshops remain three A4 pages, with the full reflection on the last page. Raw extraction confirms two exact standalone output-instruction lines and the comments request in both final pages. The image-only story retains exactly one image and no added text on each of its 43 pages.

The requesting-code-review skill dispatched an independent reviewer with a precise requirements brief and no prior session history. It reviewed all source families, current documentation, scripts, the HEAD diff, relevant untracked additions, and PDF typography/bounds. Its confirmed findings and suggestions are recorded in `docs/final-review-2026-10-08.md`: two important compression-helper destination issues, minor HW1 semantic styling and documentation wording issues, and optional pagination/slide-checklist refinements. Compression probes used only disposable `/tmp` copies and directories. These broader findings are open recommendations; this revision implements only the user's prompt instruction and the necessary code-comment wording alignment. No automated tests, commits, or pushes were added. `git diff --check` passed.

## Ships animation reflection (2026-10-08)

Replaced the shared tournament story and prompt comparison with the user's requested p5.js ships scenario. The English story contrasts describing a fleet visually with using animation experience to specify drawing, motion, and canvas-edge behavior. The refined prompt reuses the exact initial sentence and expands it with an 800 × 500 white canvas, five ships, simple outlined shapes, an array of ship objects, separate display/update/wrap methods, initialization and frame responsibilities, speed in pixels per second, elapsed-time scaling, complete-exit wrapping, and explanations of the decisions and adjustable parameters. The reader invitation now asks students to run both sketches, compare movement/edge behavior/ease of modification, and share their experience and a prompt improvement with classmates.

The editorial subagent reviewed the expanded brief and recommended explicit method responsibilities and speed units. Checked lifecycle/timing language against the official p5.js references for [setup](https://p5js.org/reference/p5/setup/), [draw](https://p5js.org/reference/p5/draw/), and [deltaTime](https://p5js.org/reference/p5/deltaTime/). The requested ship methods are application methods, not library APIs. Updated the current editorial brief, style guide, template audit, and future-workshop instruction; earlier verification entries remain historical records.

`./scripts/build.sh workshop-01` and `./scripts/build.sh workshop-notes` both completed with exit code 0 and no warnings, using bundled fonts and disabled system fonts. Both PDFs remain three A4 pages. All six pages were rendered at 1600 px with Poppler and visually reviewed. Both expanded reflections fit on one page with footer clearance, intact frames and double quotation marks, readable prose and inline identifiers, and no clipping or overlaps. PDF content streams for the cover and teaching page are unchanged from the PDFs saved immediately before this revision.

Raw text inspection confirms identical closing copy in both outputs, two occurrences of the stored initial prompt, the double-quoted title, English-only reflection content, and the invitation to classmates. Font inspection confirms 11 pt Lora for the story, prompt prose, and invitation; exact API/class/method identifiers use the existing 9.46 pt JetBrains Mono inline-code treatment. `pdffonts` confirms embedded Lora Regular/Bold/Italic and JetBrains Mono with Unicode maps. The shared layout and existing illustration were not modified. No live p5.js sketch or AI output was generated; the document presents prompts for readers to try. `git diff --check` passed. No automated tests were added.

## Workshop setup structure (2026-10-08)

Reorganized only the first workshop's setup section. Renamed its main heading to «آماده‌سازی محیط برنامه‌نویسی» and gave IntelliJ IDEA and VSCode parallel level-2 headings, «مسیر پیشنهادی» and «مسیر جایگزین». The shared theme supplies the existing 16/12 pt hierarchy and standard spacing. The first route's installation/platform guidance now appears before its two resources; the second route retains its system-specific guidance and three resources. IntelliJ link labels now identify project creation and the Mac setup video more clearly. No local typography/layout rules were added.

`./scripts/build.sh workshop-01` completed with exit code 0 and no warnings, using bundled fonts and disabled system fonts. The PDF remains three A4 pages. All three pages were rendered at 1600 px with Poppler and visually inspected: the setup hierarchy is clear, both resource groups fit on the teaching page, and the following Java example and graphics resource have adequate footer clearance. There are no clipped elements, isolated link rows, or extra pages.

Source comparison confirms all content outside the setup section is unchanged. All six original URL strings and PDF link destinations match the previous version, including query parameters and the IntelliJ timestamp. Raw PDF extraction retains the exact original Java print statement. The cover and English reflection retain their existing composition. Updated the style guide with the parallel-path convention. `git diff --check` passed; no automated tests were added.

## English reflection and stronger prompt comparison (2026-10-08)

Corrected the shared closing reflection to English throughout: story, prompt labels/examples, takeaway, and reader invitation. This overrides the Persian story treatment recorded in the earlier audit below. The theme supplies Lora, English language, LTR direction, left alignment, and a left border for prompt panels. Running headers/footers explicitly retain their Persian context so the English section cannot reverse their arrangement. The shared quote frame adds typographic double quotation marks on the cover and closing-page title.

Expanded the user's brief into a professional micro-story and a simple, engaging programming example. Separate story-writing and prompt-writing subagents proposed copy; an independent editorial subagent reviewed it. The story follows two friends building a tournament leaderboard after a tied final match. The initial Java prompt is stored once and repeated verbatim in the improved prompt, which adds arrays, descending scores, tied ranks (1, 1, 3), and a worked example with an expected scoreboard. The conclusion asks readers to try both prompts in the same AI tool, compare the results, check the tie, and share their experience with classmates. The image is unchanged. The content module now exports a dictionary without an unused helper argument or theme import; the theme remains the sole layout/typography source.

`./scripts/build.sh workshop-01` and `./scripts/build.sh workshop-notes` completed with exit code 0 and no warnings, using bundled fonts and disabled system fonts. Both final PDFs remain three A4 pages. All six pages were rendered with Poppler at 1600 px and visually inspected; after isolating the page furniture, both closing pages were rendered and inspected again. Both reflections fit on one page, with readable Lora, correctly ordered quotation marks, and no clipped text, overlaps, or blank pages. The two middle teaching pages are pixel-identical before/after the furniture isolation.

`pdffonts` confirms embedded Lora Regular/Bold/Italic with Unicode maps in both PDFs. PDF text/font inspection confirms 11 pt Lora Regular for the story, prompt text, and invitation, and 9 pt Lora Bold for prompt labels. Poppler raw extraction retains the complete double-quoted sentence on both covers and final pages and the exact original Java print statement. The two closing sections have identical editorial content, the initial sentence appears twice, and all text from the quote through the invitation is English. The real workshop still has six body-page resource links. No workshop teaching source or assignment requirements were edited in this revision.

Future-workshop requirements are recorded in AGENTS, the README, style guide, and `docs/brand/workshop-reflection-editorial.md`; current brand notes, template audit, and technical rationale no longer prescribe a Persian story. Historical verification entries below remain as records of their earlier versions. No automated tests were added. `git diff --check` passed.

## Single-theme audit, Lora, and shared workshop reflection (2026-10-08)

Audited all `documents/`, `templates/`, and `examples/` entries against the shared theme. The family already used `course/theme.typ`; gaps were duplicated semantic rules and heading sizes, a manually assembled real-workshop cover, an incomplete workshop starter, repeated build mappings, and English prose using Vazirmatn. The master theme now owns `type-scale`, `spacing`, document/workshop/slide geometry, and the common `semantic-typography` rules for raw code, math, and links. Entry files have no local font, margin, type-size, or page-layout overrides. Normal and mission headings share the 16 pt size; sub/minor headings use 12/11 pt above 11 pt body text. Paragraph/list gaps are 5 pt, main-heading gaps 16/6 pt, and body leading remains 4 pt. `slide-style` now owns the remaining slide text roles and differentiates in-shell headings at 30/28/26 pt below the 38 pt page title.

Bundled unmodified Lora 3.021 Regular/Bold/Italic/BoldItalic from Cyreal commit `2d53b449b60e185b39f671b44fded83e0910ad30`, with its exact OFL license. English prose, proper names, concepts, Latin numbers, and quotes use Lora, including default Latin glyph fallback. Persian uses Vazirmatn, exact code uses JetBrains Mono, and equations use New Computer Modern Math. The proof now isolates its English term and treats identifiers inside English prose as code; it demonstrates all four Lora styles. TTF name-table inspection confirmed version 3.021 for every face. `pdffonts` confirmed embedded Lora in all eight editable-text outputs, with Unicode maps. The typography proof embeds all four Lora styles; inspected JetBrains sizes remain 9 pt blocks, 9.46 pt body-inline code, and 10.32 pt inline code in 12 pt subheadings.

Added `course-workshop` as the composition contract for both `documents/workshop-01.typ` and `templates/workshop-notes.typ`. It automatically supplies the illustrated cover and one dedicated final reflection page. `course/workshop-reflection.typ` owns the English quote, existing artwork path, Persian story, initial prompt, refinement, and takeaway. Its factory receives the theme's `en` helper without importing the theme or specifying local styling. The initial prompt is stored once; the improved example appends purpose, Java/arrays, two playlist operations, and clarifying questions to that same request. No assignment requirement was added by the reflection.

The cover quote has a thin 0.7 pt navy frame and 13 pt Lora Italic text. The closing-page title uses the same framed English quote at 22 pt, with a larger 158 × 96 mm contained illustration versus the cover's 130 × 72 mm image area. The original PNG was retained without changes. Both workshops now have three A4 pages: cover, teaching content, and reflection. Their closing pages use the same source content and fit on one page. The workshop retains all five objectives, its date label, all six original URLs including query strings/timestamp, and the exact Java example.

`/bin/bash -n scripts/build.sh` and `./scripts/build.sh all` completed with exit code 0 and no warnings. The script now has one registry of selector/source/output triples; an unknown selector returned exit code 2 with usage derived from that registry. A fresh input copy containing the course sources, entries, scripts, assets, and fonts was built with `/bin/bash` from outside the copied repository; all nine outputs compiled without network or system fonts. No automated tests were added.

| Editable output | Pages |
| --- | ---: |
| `hw1.pdf` | 9 |
| `homework-template.pdf` | 2 |
| `workshop-notes-template.pdf` | 3 |
| `project-phase-template.pdf` | 2 |
| `handout-template.pdf` | 2 |
| `typography-proof.pdf` | 3 |
| `slides-template.pdf` | 8 |
| `workshop-01.pdf` | 3 |

All 32 editable-output pages were rendered at 1200 px and visually reviewed in per-document contact sheets. The actual workshop cover/body/closing pages and bilingual proof page were additionally inspected at 1600 px; the HW1 page containing missions 4/5 was inspected individually. A metadata-populated workshop proof used a long title, two illustrative instructors, three preparers, term, and publication date: it compiled to three pages and its cover was reviewed at 1600 px without collisions. Its English prose page confirmed regular/bold/italic/bold-italic Lora and an underlined link. After the initial family review, the two workshop closing pages changed because the refinement's Java name moved into the shared `en` helper; those final pages were inspected again. The final slide-role consolidation changed only slides 4 and 6, whose level-1 in-shell headings now use 30 pt rather than 28 pt; both were rendered and individually reviewed at 1200 px. PDF font measurements confirmed the intended 30 pt content heading beneath the 38 pt slide title. All remaining final pages were pixel-identical to their already-reviewed renders. No clipping, overlaps, orphaned resources, blank pages, or lost content were found.

PDF structure inspection found exactly six body-page workshop link annotations, each spanning its full card and matching the original destination; the quote appears once on the cover and once on the final page. The cover contains one UT seal and the sketch; the final page contains only that same sketch. PDF author/title metadata follow the visible Persian metadata. HW1's only source change replaces its locally styled input/output grid with the theme's `example-columns` call, retaining its equal columns and 12 pt gap; no requirement, score, submission filename, or example text was edited. A final rebuild after this extraction was pixel-identical to all nine reviewed HW1 pages. Poppler raw-extraction character inventories match the previous HW1/homework/project/handout/slide outputs. Exact Java tokens and all submission-tree filenames remain present. pypdf paragraph-string equality is not a fidelity criterion: changing font runs alters its RTL punctuation reconstruction and restores some characters it omitted in the prior extraction; the logical editable source, raw extraction, and rendered text were checked together.

The 43-page image-only story also rebuilt through `all`; its source images and entry were unchanged. It has no editable English text to assign a font to, so original lettering baked into those images is retained. No new rendering treatment was applied to that deck. The current audit and ownership contracts are documented in `template-review.md`, `document-style-guide.md`, `technical-decisions.md`, the README, and brand/provenance notes. `git diff --check` passed.

## Workshop links, editorial revision, and illustrated cover (2026-10-08)

Revised `documents/workshop-01.typ` with concise Persian introductions for the previously empty history and programming-language sections, clearer workshop/setup prose, a short instruction before the unchanged Java example, and an explanation before the graphics resource. The five objectives, date label «۱۵ مهر», all six original URL destinations (including query parameters and the IntelliJ video timestamp), the installation/platform note, and the exact Java class/main/print statements are retained. This supersedes the initial workshop's deliberately empty sections described below.

Added shared `resource-link`/`resource-links` components and opt-in `cover-artwork`/`cover-vignette` support to `course/theme.typ`. Resource cards have an underlined blue label, pale background, quiet border, and a vector external-link arrow, with the entire card clickable. Detail text is not underlined; Latin domains/software names are isolated with `en`. Ordinary inline document links are blue and underlined. The graphics explanation and its full-width link fit together on the single body page; an intermediate layout that left only that link on a third page was corrected with concise setup cards.

The cover's lower area contains the generated 1536 × 1024 black-ink lighthouse/keeper/AI-companion sketch and the user-confirmed, separately typeset LTR quote “AI knows as much as you know.” One unmodified 554 × 554 UT seal remains above the title; the Engineering mark is absent. The supplied brand image and notes were moved into `assets/brand/reference/` and `docs/brand/references/` without edits. `docs/brand/README.md` records the original visual tokens and requested monochrome adaptation; `docs/brand/workshop-01-artwork.md` records both ImageGen prompts and provenance. Original file SHA-256 values are `116f05deffed11473a813139444f489719b6093a0c9379591efe44ca4704dd68` (board) and `347545fd2b730550444b8ff620ff984b701a53e2188a970e6b3ba641d0a8c78b` (notes).

`./scripts/build.sh workshop-01` completed with exit code 0 and no warnings, using Typst 0.15.1, bundled fonts, and `--ignore-system-fonts`. The build script now includes this workshop in `all` and exposes a dedicated `workshop-01` selector. The final PDF has two A4 pages, an unnumbered cover and body page ۱. Both final pages were rendered with Poppler at 1600 px and visually reviewed for the cover composition, Persian shaping, line breaks, LTR quote/domain, link hierarchy, arrows, code, and footer clearance. No clipping, collisions, orphan resources, or blank pages were found.

PDF structure inspection confirmed exactly six link annotations on the body page, each spanning a full card and matching its supplied destination. Text extraction retained the exact quote, `class App {`, `public static void main(String[] args)`, and `System.out.println("Hello world!");`. PDF metadata remain «جلسهٔ اول» and «دانشگاه تهران — برنامه‌سازی پیشرفته». `pdffonts` confirmed embedded Vazirmatn Regular/Bold and JetBrains Mono with Unicode maps; the arrows use vector strokes and require no fallback font.

Seven existing sources (HW1, homework/workshop/project/handout starters, typography proof, and slide template) compiled without warnings into an ignored QA directory. Their 28 pages were rendered at 72 DPI and compared with the existing distributed PDFs; all pixels were unchanged. Their tracked PDFs were not regenerated. The untouched image-only story deck was outside this revision. `git diff --check` passed. No automated tests were added.

## Session 1 workshop note (2026-10-07)

Created `documents/workshop-01.typ` and `output/pdf/workshop-01.pdf` from the supplied session 1 text, using `course/theme.typ` without layout overrides. The cover identifies «جلسهٔ اول» and «۱۵ مهر»; all five objectives, the introduction, both intentionally empty topic headings, setup resources and installation note, the original Java statements, and the graphics sketch link remain present. Only Persian orthography, code indentation, and link presentation were normalized. No additional teaching content or inferred date/year was added.

`typst compile --root . --ignore-system-fonts --font-path assets/fonts documents/workshop-01.typ output/pdf/workshop-01.pdf` exited 0 without warnings. The final PDF has two A4 pages: an unnumbered cover with one 554 × 554 UT seal and a content page numbered ۱. Both pages were rendered with Poppler at 1600 px and visually reviewed for Persian shaping, hierarchy, inline Latin names, code punctuation, link layout, and header/footer spacing. No clipping, collisions, or blank pages were found. `pdffonts` confirmed embedded Vazirmatn Regular/Bold and JetBrains Mono with Unicode maps. PDF annotation inspection confirmed all six supplied URL destinations, including the IntelliJ video timestamp and query parameters; the sketch URL has two annotations for its linked text. pypdf extraction confirmed the original Java class, main signature, and exact `Hello world!` print statement. PDF title/author metadata match the Persian document and course. No automated tests were added.

Date: 2026-10-06. Compiler: Typst 0.15.1 on macOS ARM64.
This record describes the current airy-spacing and bilingual-text revision with one UT logo and Persian cover titles.

## Compilation and PDF checks

`./scripts/build.sh` completed with exit code 0 and no warnings. Builds use only bundled fonts and Typst's embedded math font, with system fonts disabled.

| Output | Pages | Size |
| --- | ---: | --- |
| `hw1.pdf` | 9 | A4 |
| `homework-template.pdf` | 2 | A4 |
| `workshop-notes-template.pdf` | 2 | A4 |
| `project-phase-template.pdf` | 2 | A4 |
| `handout-template.pdf` | 2 | A4 |
| `typography-proof.pdf` | 3 | A4 |

All 20 current pages were freshly rendered and visually inspected for shaping, punctuation, the shared airy spacing, hierarchy, page breaks, tables, code, equations, headers, and footers. No clipping or collisions were found. Covers have no running furniture or printed page number; body numbering begins at ۱. Mission 4/5 still share one page; project tables and the final note fit on its content page. `pdffonts` confirmed embedded fonts and Unicode maps in every PDF.

After the latest editorial check, all six PDFs were rebuilt. The HW1 opening/body page and homework-starter content page were rendered again: «کاوشگر جاوا» is typeset as Persian prose, the homework starter contains no ordinary English placeholder comment, and the remaining Latin spans are technical names, exact code/output, or specialist terminology. The full family shares the same spacing values recorded in `document-style-guide.md`.

On 2026-10-07, HW1's first content page was rewritten for a concise six-mission narrative and clearer pre-mission notes. `./scripts/build.sh hw1` completed without warnings; the PDF remains nine pages. The affected page was rendered and visually checked for Persian shaping, mixed-direction technical spans, spacing, and fit. Its original Java/tool, topic-scope, analytical-reasoning, readability, valid-input, and pre-submission requirements remain present.

PDF image inspection found exactly one image on each cover, matching the UT seal's 554 × 554 dimensions. No page contained the 447 × 447 Engineering asset. Extracted text contained no duplicated English course label in any output. HW1's PDF title metadata is «تمرین اول», and the PDF author metadata is Persian.

The typography proof demonstrates all five optional cover fields using illustrative placeholder labels. Its body covers proper names, concepts, exact Java entities, decimal and negative Latin numbers in Persian prose, mathematical notation, and complete code blocks. It now includes inline code inside a 12 pt subheading. PDF font inspection found inline code at 9.46 pt in 11 pt body prose and 10.32 pt in that subheading, with block listings at 9 pt. The project starter includes a warning with inline prose and code.

A temporary cover proof used a three-line title, all five metadata fields, two illustrative instructor names, and four preparer names across two lines. It compiled to one cover plus one body page, and its cover was rendered and visually inspected without collisions. A custom metadata dictionary with a bold university label produced `دانشگاه نمونه — درس نمونه` as PDF author; an explicit `pdf-author` produced exactly `Custom publishing team`. Both builds exited 0 without warnings. These proofs are QA intermediates, not distributed course documents.

## Source fidelity

The copied DOCX and PDF are byte-identical to the files in the supplied Downloads folder (fresh SHA-256 comparison). The latest language pass revises the Persian name of the fictional ship and translates ordinary English prose; the six missions and all assignment requirements remain intact. The six missions, points and sub-scores, examples, optional challenge, submission rules, checklist, and contacts were compared against the source. Mission 5's text-box code was checked visually against the source PDF.

An exact-token check using `pdftotext -raw` found all 32 selected code lines, identifiers, output messages, submission filenames, and contact handles. pypdf independently retained the Java operators and punctuation. Poppler's `-layout` output may reconstruct punctuation differently in mixed-direction pages; this is recorded in `technical-decisions.md`. Rendered PDF text and raw extraction are correct, but arbitrary PDF-reader clipboard behavior was not exhaustively checked.

## Independent review

The initial consistency audit found two implementation defects: fixed PDF author metadata and a global raw-text size overriding inline sizing. It also found misleading code-wrapping/build-scope wording and incomplete cover robustness evidence. The implementation and documentation now address those findings. The final language edit rendered all nine HW1 pages again plus the affected typography proof page. The fictional title is Persian throughout; extracted PDF text contains no “Java Explorer”, “Screenshot”, “Nested Loop”, “Integer Division”, or English topic-list terms. The body remains nine pages with no clipping.

The final reviewer follow-up could not complete because the review agent reached its service usage limit. The primary agent completed the final source/API/documentation review and all-page visual review. This record does not claim a second independent approval of the final revision.

The editorial pass uses «کاوشگر جاوا» consistently for the vessel, translates generic programming concepts when Persian equivalents are clear, and localizes the final topic summary. It retains exact Java/API names, named software/libraries, and the technical short-circuit term with a Persian explanation.

Source ambiguities were deliberately preserved. Very long code lines require sensible author-supplied line breaks. Current and three-line cover titles were reviewed; arbitrary large titles or extensive author lists still require another visual review. PDF-reader clipboard behavior, institutional permission, live Telegram accounts, and compiler installation on other operating systems were not exhaustively assessed.

## Portability

The delivery archive includes the theme, configuration, starters, HW1 source, typography proof, build script, local fonts and licenses, logo assets, documentation including the researched style guide, local `AGENTS.md`, reference copies, and all six PDFs. It excludes temporary research/review files and unrelated workspace content. The Engineering asset is retained only for provenance and is not loaded by the theme.

The latest 33-file archive was extracted into a fresh temporary directory, and its build script was invoked outside the extracted project. All six PDFs compiled with exit code 0 and no warnings. The archived source includes the Persian-first homework-template comment cleanup and reproduces the PDFs with local assets. This confirms path independence and local asset resolution on this machine. Other operating systems have not been exercised.

## Slide template and image-only story (2026-10-07)

Added a presentation family to `course/theme.typ`, reusing its colors, bundled Vazirmatn/JetBrains Mono fonts, Persian metadata, and bilingual inline helpers. `templates/slides.typ` demonstrates eight pages across seven layouts: cover, section, content shell, two columns, image with text, statement, and image only. The shell also includes a code example. `documents/evolution-ai-story.typ` lists all 43 original image filenames in numbered order.

Both presentation sources compiled with Typst 0.15.1 using `--ignore-system-fonts --font-path assets/fonts`, with exit code 0 and no warnings. The final template was also built through `./scripts/build.sh slides`. Both PDFs use 960 × 540 pt (16:9) pages: `slides-template.pdf` has 8 pages; `evolution-ai-story.pdf` has 43 pages. `pdffonts` confirmed embedded Vazirmatn, JetBrains Mono, and New Computer Modern Math with Unicode maps in the template. The story contains no text fonts.

All 51 pages were rendered with Poppler and visually reviewed. The eight template pages were checked at 1440 px width, including full-size inspection of the cover, lists, bilingual prose, two columns, equation, image layout, code, and statement page. An initial collision around the shell's list was corrected with explicit block spacing; the final eight-page render and contact sheet show clear separation. The 43 image pages were reviewed in three contact sheets rendered from the PDF. No clipped source images, added furniture, blank pages, or layout collisions were found. The cover contains exactly one unmodified UT seal; the Engineering mark is absent. Persian content numbering starts at ۱ after the cover.

PDF structure inspection found exactly one image and no extractable text on every story page. Each decoded PDF image matched the corresponding original PNG's RGB pixels, in the expected order, for all 43 pages. The `contain` fit preserves complete artwork and its proportions. Original images and story script were not edited. The lossless story PDF is approximately 127 MiB.

The handout was compiled as a smoke check for the unchanged document layout, without warnings; its tracked PDF was restored to avoid a timestamp-only change. No automated tests were added. The pre-existing document ZIP was not replaced. At initial slide delivery, the story image folder was Git-ignored; the GitHub preparation below includes it in version control. Current templates and source files are documented in the README and style guide. The old archive's portability results above apply to its six-document contents only.

## GitHub publication preparation (2026-10-07)

Reviewed the course sources, templates, reference documents, fonts and licenses, current PDFs, story script, and both illustration folders. The 43 current illustrations and eight earlier reference images are included without modification. OS metadata, temporary review files, and the unrelated Java scratch directory remain excluded. Original Word/PDF references and the existing document-only ZIP are retained. Binary file attributes keep Git from treating PDFs and image/font/archive files as text.

The initial staged publication snapshot contains 93 files totaling approximately 135.6 MiB, with a largest individual file of 5.41 MiB and no file above GitHub's 100 MiB limit. The generated 127 MiB story PDF stays local and is distributed as a release asset; all inputs needed to rebuild it are tracked. The current text sources were checked for common credential/private-key patterns, with no matches found. This is a focused publishing check, not a comprehensive security audit.

A clean temporary copy made from Git's staging index successfully ran `scripts/build.sh all` from outside the copied repository. All eight outputs compiled with bundled fonts, exit code 0, and no warnings. This checks that a clone includes the image assets previously missing from version control. Git's staged whitespace check passed. No automated tests were added, and no source content or artwork was changed during publication preparation.

## Story PDF compression (2026-10-07)

Compressed `output/pdf/evolution-ai-story.pdf` from 127.0 MiB (133,150,872 bytes) down to 22.9 MiB (24,041,717 bytes), achieving an 81.9% reduction in size.

The compression applies macOS Quartz filters (`scripts/compress-pdf.swift`) preserving all 43 pages, native 960 × 540 pt geometry, and original 1672 × 941 canvas resolution, while retaining Persian metadata (`از ماده تا هوش مصنوعی` as Title and `دانشگاه تهران — برنامه‌سازی پیشرفته` as Author). Rendered pages (including pages 1, 22, and 43) were visually reviewed at 150 DPI; line drawings, color gradients, and textures remain crisp without visible artifacts.

Publication review independently confirmed 43 pages, 960 × 540 pt geometry, no extractable text, and the Persian title/author in the compressed PDF. Pages 1, 22, and 43 were rendered with Poppler at 1440 px width and visually checked without clipping or layout defects. `swiftc -typecheck scripts/compress-pdf.swift` completed with exit code 0. pypdf ignored two unused cross-reference entries pointing to offset zero; it read every page and the metadata successfully. The full-resolution Typst PDF remains available separately. The helper and its documentation add one tracked file to the initial snapshot, bringing the repository to 94 files.

Regenerated the sharing copy on 2026-10-07 with `./scripts/build.sh evolution-ai-story` followed by the documented Swift compression command. The lossless build is now retained at `output/pdf/evolution-ai-story.pdf` (133,150,872 bytes), and the separate sharing copy is `output/pdf/evolution-ai-story-compressed.pdf` (24,041,717 bytes), an 81.9% reduction. Both commands exited 0. Fresh `pdfinfo` checks confirmed all 43 pages, 960 × 540 pt geometry, and the same Persian title/author. `pdfimages -list` confirmed one JPEG per compressed page with each source canvas retained (1672 × 940 or 941 pixels). All 43 compressed pages were rendered and reviewed in three contact sheets, with page 41 additionally inspected at 1440 px width; no blank pages, clipping, or visible rendering defects were found. Original PNG assets and editable sources remain unchanged. No automated tests were added.

### Stronger sharing copy (2026-10-07)

Created `output/pdf/evolution-ai-story-compact.pdf` directly from the lossless Typst PDF using the same Quartz page-copy workflow with a temporary custom filter. The filter starts with macOS's `Reduce File Size.qfilter`, sets `Compression Quality` to 0.25, `ImageResolution` to 96, and `ImageSizeMax` to 1280, and retains interpolation. The output is 8,271,422 bytes (7.9 MiB), 65.6% smaller than the 22.9 MiB sharing copy and 93.8% smaller than the lossless build. The standard compression helper was not changed.

Fresh `pdfinfo` and `pdfimages -list` checks confirmed 43 pages, unchanged 960 × 540 pt page geometry and Persian title/author, and one JPEG per page at approximately 1280 × 720 pixels. All 43 pages rendered successfully and were reviewed in three contact sheets. Detailed pages 26 and 41 were additionally inspected at 1440 px width. Artwork is complete, with no blank pages or clipping; fine textures are softer at enlarged viewing sizes because this copy uses lower resolution and stronger lossy compression. The final output's SHA-256 matches the visually reviewed candidate. The lossless PDF, previous sharing copy, original artwork, and editable sources were retained. No automated tests were added.

## Source and resource layout (2026-10-08)

Moved authored Typst modules to `src/{course,documents,examples,templates}/` and bundled assets plus original assignment copies to `resources/{assets,references}/`. Updated the active README, build registry, theme image references, brand/document guides, and agent instructions to use those paths. Dated planning records and earlier verification entries retain their historical paths. Source wording, artwork, and reference contents were not changed by the move.

`./scripts/build.sh all` compiled all nine entries with bundled fonts, system fonts disabled, exit code 0, and no warnings. Page counts remain HW1 9, workshop 3, homework starter 2, workshop-notes starter 3, project-phase starter 2, handout starter 2, typography proof 3, slides 8, and image-only story 43. Every output page was rendered and reviewed in contact sheets; the workshop closing page and HW1 final page were also inspected at full size. No clipping, missing images, blank pages, or layout changes appeared.

The two original HW1 references retain their pre-move SHA-256 values: DOCX `da3d9b679f2f9c846186c9811c8143b1c88e33cfc30b3f19373558269f6aeecf`; PDF `bd5070fde023dfd40b1171815ed5f1505c7bebe4007a559eb9bdc0c908bd75cc`.

Added `scripts/package.sh` and refreshed `output/ut-course-template.zip`. The archive contains the current `src/` and `resources/` trees, active user documentation, build/package scripts, and eight PDFs (32 pages). It omits the 127 MiB lossless story PDF; that generated file remains available as a separately published release asset and is rebuilt from the packaged source. A fresh extraction under `/tmp` successfully built all nine entries from outside the extracted directory with no warnings; both archived HW1 reference copies compare byte-for-byte with their source copies. `git diff --check` passed.

The 2026-10-08 final review's two important PDF-compression findings are resolved in `scripts/compress-pdf.swift`: the default destination is now a sibling `-compressed.pdf`, source/destination paths are resolved before same-file checks, directories and special files are rejected, and output is installed with a same-directory atomic rename. `swiftc -typecheck` passed. Disposable-file checks confirmed the input hash stays unchanged, same-file and symlink aliases are rejected, a directory and its contents remain untouched, and an existing regular destination can be replaced successfully.

The HW1 source now styles `Array` as a concept and generic PDF/ZIP format names as English prose; exact filenames and code remain code-styled. The reflection guides now clarify that English prose, labels, and quotes use Lora while embedded exact identifiers keep JetBrains Mono and math uses its native font. Rebuilt HW1 at nine pages without warnings; no assignment wording, scores, or submission requirements changed.

## Local story assets and generated files (2026-10-08)

The 135.68 MiB source archive had copied the maintainer-local 43-slide story artwork (about 108 MiB) and eight earlier reference images (about 19 MiB) along with the portable sources. Excluded the story source, narration script, both artwork folders, generated story PDFs, generated slide preview PDF, and source ZIP from Git while retaining local working files. `scripts/package.sh` removes the local story items from staging even when run from the maintainer's full checkout. The build registry includes the optional story selector only when its local source exists. The slide template now uses the tracked workshop illustration, so it builds in a clean source clone.

The current GitHub main tree had 53 tracked files over 1 MiB, totaling about 133.6 MiB, dominated by the 51 story PNGs and the 5.41 MiB generated slide preview. Those are removed from the current tree in this cleanup; prior commits remain in history. The 1.13 MiB workshop illustration remains tracked because it is an active source asset. Generated source archives and PDFs are recreated locally and are not versioned.
