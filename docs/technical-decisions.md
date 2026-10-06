# Technical decisions

## Scope and identity

The course is Advanced Programming / برنامه‌سازی پیشرفته. The supplied file names contain Advanced Algorithms and Homework 0x04, but the printed Persian heading says first homework and the requested ZIP name ends with HW1. The migrated entry is therefore `documents/hw1.typ`. This decision uses the document's content rather than stale filenames.

The user approved a formal modern family with UT blue, navy text, A4 pages, Persian-first composition, and shared typography. There is no instructor, term, deadline, or course code in the supplied source. These remain optional configurable metadata, omitted until supplied.

## One theme with focused starters

`course/config.typ` is the single metadata source. `course/theme.typ` owns colors, fonts, direction handling, page furniture, cover composition, and reusable components. The four starter files import it and contain their own content structures. This prevents style drift while keeping files easy to copy and edit.

The primary interface is `course-document` used as a show rule. Titles, types, and numbers are strings; subtitles and metadata can contain rich Typst content. A reusable `mission` heading keeps its title with subsequent content and shows the score separately. Notes and code panels are breakable so longer documents can flow across pages.

## Cover and information hierarchy revision

The user's subsequent feedback calls for a dedicated cover and clearer priority among information. Each document opens on an unnumbered A4 cover. The latest revision uses a single 32 mm UT seal at the upper right beside quiet university/faculty text; the Engineering mark is not rendered. The course name, document title, and number are the main visual anchors, with a short descriptive Persian subtitle. Navy type, white space, and a short blue rule carry the brand without a large colored title panel. Duplicated English course-name labels were removed from the theme/configuration, and PDF author metadata is Persian.

Below the cover's title group, only supplied metadata appears: course instructor and term from the central configuration, plus document-specific `prepared-by`, `issued-on`, and `deadline`. Preparers and the professor are separate roles; TA Telegram handles are not treated as cover names. The typography proof uses illustrative placeholders to demonstrate all fields. Other documents omit missing fields.

The body begins on the next page with its page counter reset to ۱. Its header separates the course name from the document type/number with flexible space and a thin rule; the university is secondary information in the footer. Cover groups use deliberate vertical gaps, and section headings have more breathing room. Explicit page elements and counter updates follow [Typst page](https://typst.app/docs/reference/layout/page/) and [counter](https://typst.app/docs/reference/introspection/counter/) documentation.

## Bidirectional text method

The primary text has `lang: "fa"` and `dir: rtl`. Typst handles shaping and bidi reordering. The dominant paragraph direction is set explicitly because punctuation and neutral characters need that context. See [Typst text documentation](https://typst.app/docs/reference/text/text/).

Short English terms and code identifiers are isolated as inline `box` content with a local LTR context. This isolates parentheses, periods, operators, and internal ordering from surrounding Persian text. The whole short span stays together. The author should use `english` for long English prose, which wraps normally in an LTR paragraph. Use `code-block` for snippets, literal input/output, and file trees; raw blocks preserve source line breaks and need sensible author-supplied breaks for long lines. The `en` helper uses the Latin glyphs of Vazirmatn to retain the text's visual tone. JetBrains Mono distinguishes code from explanatory prose.

This method is explicit and locally scoped. It adds no automatic paragraph-language detection package and needs no hidden bidi controls sprinkled through the source. Authors can read and edit the source in logical order. The typography proof covers leading/trailing Persian punctuation, English parentheses, Java member access and comparisons, standalone English prose, and mathematical expressions.

The revised starters make semantic distinctions explicit. `en` is for names and ordinary English phrases; `term` is a prose alias for concepts such as Recursion or Array. Exact Java entities such as `ArrayList`, `List<String>`, `items`, and `items.get(0)` use `code-inline`. A numeric helper, `latin-number`, preserves Latin digits, signs, and decimal punctuation in ordinary prose, using the body font. Code blocks hold complete snippets or literal structured examples. Math remains native math; warning text remains ordinary text in a labeled callout. The author chooses these roles rather than an automatic keyword formatter guessing from spelling.

## Airy spacing and consistency audit

The user first asked for an airy feel, then visually rejected the result as too loose. Fresh PDF measurements showed about 16-17 pt between lines of 11 pt prose, in addition to large spaces around headings and blocks. The current shared `spacing` dictionary reduces leading to 4 pt, paragraph gaps to 6 pt, list gaps to 6 pt, and section openings to 18 pt. The absolute point/mm values keep spacing independent from heading size. Notes and raw blocks have explicit outer spacing and 10/8 pt horizontal/vertical padding; nested default block spacing is suppressed. Note labels stay with their first body content. Mission labels use a separate 5 pt gap instead of inheriting heading paragraph leading, and score labels remain intact.

The cover and body share a 21 mm horizontal margin. A fixed 22 mm gap follows the brand block, anchoring the course/title group consistently across empty and populated covers. Optional metadata follows that group by 10 mm, and flexible space remains below. The body top margin is 24 mm and header ascent 7 mm. See the numeric scale in `document-style-guide.md` and [Typst block spacing](https://typst.app/docs/reference/layout/block/).

The audit found a global 9 pt raw-text rule overriding inline code's requested relative size. Inline raw text now finishes at 0.86 times the surrounding size, while blocks remain 9 pt. Typst applies a built-in 0.8em reduction to raw text, so the inline rule explicitly compensates with `0.86em / 0.8`. This follows [Typst raw styling](https://typst.app/docs/reference/text/raw/). PDF font inspection confirms 9.46 pt code in 11 pt prose and 10.32 pt code in 12 pt subheadings.

PDF author metadata previously duplicated fixed university/course labels. It now derives from the supplied `meta` using a small text extractor for strings, text nodes, sequences, ordinary body wrappers, and line breaks. It is not a serializer for arbitrary content such as images or generated context. Those cases, or a different publishing credit, use the optional string `pdf-author`. This keeps cover and file metadata consistent without requiring the course name to be maintained twice. See [Typst content fields](https://typst.app/docs/reference/foundations/content/) and [document metadata](https://typst.app/docs/reference/model/document/).

Equations use native Typst math with New Computer Modern Math. Inline expressions can be isolated with `math-inline`; display equations use ordinary `$ ... $` syntax. Equation numbers use left alignment in RTL pages when numbering is enabled. See [Typst equation documentation](https://typst.app/docs/reference/math/equation/).

Visual reading and text extraction are different checks. Both `pdftotext -raw` and pypdf retain the tested Java identifiers and ASCII operators. Poppler's `-layout` reconstruction can insert bidi controls and reorder trailing punctuation on Persian-dominant pages even when the rendered code and raw extraction are correct. Flattened mathematics also loses semantic superscripts/subscripts. Copy behavior depends on the PDF reader; the editable Typst source is the authoritative logical text. Do not use PDF extraction as an editable substitute for the source.

## Fonts, portability, and assets

The project vendors Vazirmatn 33.003 Regular/Bold and JetBrains Mono 2.304 Regular with their OFL licenses. The build ignores system fonts and loads `assets/fonts`. Math comes from Typst's embedded fonts. No package import or online dependency is required during compilation.

The only rendered logo is the unmodified supplied UT PNG. An official university asset URL was found online, but the direct request returned HTML. At the current 32 mm cover size the UT seal is approximately 440 ppi. The source Engineering PNG remains an unused reference asset. See `assets/SOURCES.md` for exact provenance.

## HW1 editorial decisions

All six missions, their practical and analytical tasks, scores, optional challenge, examples, submission rules, final checklist, and TA handles were retained. Persian spacing, half-spaces, punctuation, and obvious spelling errors were normalized without changing requirements. The typo “چاپ کنی” is corrected to “چاپ کنید”. The original file tree was rebuilt as genuine LTR text rather than preserving its distorted Word box characters. Mission 5 code was transcribed from the PDF/text box because ordinary DOCX paragraph extraction omits that box.

Descriptive prose and the fictional research vessel's name use Persian wording («کاوشگر جاوا»). Exact programming names/APIs, named products or libraries, and specialist terms students should recognize remain in English where useful. Concepts with natural Persian equivalents (such as recursion, integer division, and nested loops) are written in Persian; short-circuit evaluation retains its specialized English name after a Persian explanation. The concluding topic summary is Persian prose, with only Java syntax/API names set apart as code.

Missions 1, 2, 3, and 6 begin on dedicated pages. Missions 4 and 5 share a page. Submission details and the final checklist are on separate pages. The current document has one cover and eight content pages. The later Persian cover title is «تمرین اول», with the descriptive subtitle «سفر با کشتی پژوهشی». The latest spacing revision changes the shared presentation; the subsequent editorial localization changes the fictional vessel's name and replaces ordinary English prose with Persian equivalents while preserving the technical instructions.

Source ambiguities are retained for the teaching team to resolve later: Mission 1 does not say how to count simultaneous corner collisions; Mission 2 does not specify the row/column indexing convention for the optional parity challenge; Mission 3 does not specify the request stream's termination rule or timestamp domain; Mission 6 does not state input types or discuss simultaneous arrival and fuel exhaustion. These are assignment-content questions, not template defaults. No extra constraints or solutions were invented.

The six top-level mission scores sum to 7.5 points. The source does not state a total, so the migrated homework does not add an assumed total or rescale scores.

## Publishing guidance

`docs/document-style-guide.md` records the researched typography references and the project's concrete publishing rules. Butterick supplies general readability and spacing principles; Typst's official documentation supplies layout/direction mechanics; the installed PDF skill supplies visual production review. Recommendations for Latin text are adapted to Persian shaping instead of being treated as universal numerical rules. The local `AGENTS.md` points future document work to this guide.

Adobe's online whitepaper skill was inspected but not installed or executed: its Markdown conversion/cleanup workflow is unsuitable for preserving reusable course sources. No public official UT brand manual was verified, so this is a course document style, not a claim of official brand compliance.

## Tool setup

- Typst: Homebrew upgrade to 0.15.1; verified with `typst --version`.
- Superpowers: the installed Codex plugin is already enabled (6.4.2 in this session); no duplicate skill installation was needed.
- RTK: Rust Token Killer 0.51.0 installed through `brew install rtk-ai/tap/rtk`, verified by `rtk --version` and `rtk gain`.
- Codex RTK integration: `rtk init -g --codex` created `~/.codex/RTK.md`, added its reference to `~/.codex/AGENTS.md`, and registered `~/.codex/hooks.json`. Automatic hook activation requires restarting Codex. RTK was invoked explicitly during this session.

The project directory has no Git metadata. The user instructed implementation here, so no new repository, commits, or worktree were created. The design and implementation plan retain the decisions and progress.
