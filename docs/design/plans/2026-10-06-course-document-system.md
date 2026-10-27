# UT Course Documents Implementation Plan

> **For agentic workers:** Use superpowers:executing-plans to implement this plan in the current session. Steps use checkbox syntax for tracking.

**Goal:** Deliver reusable Persian-first course templates and a faithful, polished HW1 in Typst and PDF.

**Architecture:** One course configuration, one shared style/component module, four focused starter files, and one complete migrated homework. Local fonts and logos make builds reproducible.

**Tech Stack:** Typst 0.15.1, Vazirmatn 33.003, JetBrains Mono, native Typst math, Poppler for PDF review.

**Spec:** `docs/superpowers/specs/2026-10-06-course-document-system-design.md`

## Global Constraints

- A4 pages, Persian primary language, RTL paragraphs, explicit LTR technical spans and blocks.
- Preserve HW1's six missions, points, instructions, examples, contacts, and submission naming.
- Centralize metadata and style. Omit unset term/instructor/deadline values.
- Local fonts with licenses; verified online logos where available, exact source logo as fallback.
- This folder is not a Git repository. Work directly here; keep a persistent progress record instead of Git/worktree scripts.
- User explicitly authorized installation and immediate execution on 2026-10-06. No further design/plan approval pause is required.

## Review Focus

- Mixed punctuation and parentheses around English names in Persian text: isolated spans preserve order.
- Long English paragraphs: the dedicated LTR paragraph helper wraps naturally. Code panels preserve source line breaks; long code lines need sensible authored breaks.
- Math with subscripts, intervals, delimiters, and equation numbering: native math stays legible within RTL pages.
- Unset metadata and longer titles: layout remains balanced without empty labels.
- Long prose/callouts and mission headings near page ends: no clipping or orphaned headings.

## Files and interfaces

- `course/config.typ`: central metadata dictionary.
- `course/theme.typ`: `course-document(body, kind: "جزوه", title: "", subtitle: none, number: none, meta: course-info, deadline: none, prepared-by: none, issued-on: none, pdf-author: none)`, `en(body)`, `term(body)`, `latin-number(value)`, `english(body)`, `code-inline(value)`, `code-block(value, lang: "java")`, `math-inline(body)`, `mission(number, title, points)`, `part(title, points: none)`, `note(title, body)`, `checklist(items)`.
- `assets/fonts/`, `assets/logos/`, `assets/SOURCES.md`: versioned assets and provenance.
- `templates/{homework,workshop-notes,project-phase,handout}.typ`: editable starters using the same interface.
- `documents/hw1.typ`: complete homework migration.
- `examples/typography.typ`: meaningful mixed-language rendering proof.
- `scripts/build.sh`: compile all six PDFs with local font path and project root.
- `README.md`, `docs/technical-decisions.md`, `docs/verification.md`: usage, reasoning, quality record.

### Task 1: Shared theme and typography

- [x] Write `examples/typography.typ` against the shared interface and compile before the core exists; expect missing `course/theme.typ`.
- [x] Download fonts/licenses, retrieve UT logo from official site, and preserve exact Engineering mark if official source cannot be verified.
- [x] Implement configuration and theme helpers. Inline English/code use isolated boxes with explicit LTR context; longer English content uses an LTR block. Math uses native equations.
- [x] Compile proof without warnings and visually inspect punctuation, code, formulas, line wrapping, and page furniture.

### Task 2: Reusable starter family

- [x] Create homework, workshop, project phase, and generic starters, covering questions/scores, notes/examples, deliverables/milestones/rubrics, and freeform text.
- [x] Create build script with stable outputs under `output/pdf/`.
- [x] Compile all starters and inspect all pages. Confirm unset metadata, long titles, tables, and running page furniture behave consistently.

### Task 3: HW1 migration and documentation

- [x] Read full DOCX text in logical paragraph order and transcribe into `documents/hw1.typ` using semantic helpers.
- [x] Compile HW1; inspect every page and compare every mission, example, score, and submission/contact section against sources.
- [x] Document bilingual authoring, assets, tool setup, the source filename mismatch, and unresolved source ambiguities without changing assignment requirements.
- [x] Compile all six outputs with no warnings; verify page size/fonts/content, source copies, and bundle portability.
- [x] Obtain one fresh independent review of the implementation and content; fix material findings and compile/render affected outputs again.

## Progress

- Installation: Typst 0.15.1 verified; Superpowers installed/enabled; RTK 0.51.0 installed with global Codex integration registered. Automatic RTK hooks take effect after restart.
- Ruling: apply the Git-based workflow through this plan and progress record because the user's target directory has no Git repository. Cost: no commit history for the changes.
- Ruling: use compilation and visual/content checks for document templates rather than unit tests mirroring layout code. Cost: visual regressions require human image inspection.

- Initial delivery: shared theme, four starters, eight-page HW1, and two-page typography proof complete. All six builds exited 0 without warnings; all 14 pages visually reviewed. Exact raw PDF content checks passed 32/32, all fonts embedded, and source copies matched SHA-256. Independent review found no actionable defects.
- Subsequent user refinement: dedicated cover, course/document-first hierarchy, more deliberate cover/header spacing, optional preparers/publication date, and semantic helpers/examples for concepts and Latin prose numbers. Updated all four starters and the typography proof through the existing shared theme; HW1 assignment source untouched. Current outputs total 20 pages (HW1 9, starters 2 each, proof 3). All current pages visually reviewed; fresh independent review found no actionable defects. Current checks and portable rebuild are recorded in `docs/verification.md`.
- Current identity refinement: one enlarged UT seal (32 mm, upper right), no Engineering logo in any output, no redundant English course label, and Persian HW1 cover title/subtitle. Body content remains pixel-identical to the previous reviewed revision. Researched online skills and publishing guidance; adopted the installed PDF workflow plus Butterick/official Typst references into `docs/document-style-guide.md` and linked it from local `AGENTS.md`. Adobe whitepaper was inspected as a candidate but not installed or executed. Six current covers reviewed; image/text/PDF metadata checks confirm the requested changes.
- Latest consistency audit: the user selected airy, consistent spacing. Added central absolute spacing values, matching cover/body edges, stable cover title anchoring, explicit label/panel gaps, and shared list spacing. Fixed inline raw sizing (including Typst's built-in reduction) and derived PDF author metadata. Clarified code line wrapping and the fixed six-entry build scope. Extended the typography proof with code in a subheading; manually rendered a long cover title and multiple preparer names. HW1 source remains unchanged. Current evidence is in `docs/verification.md`; findings and changes are in `docs/template-review.md`.
