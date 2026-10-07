# Verification record

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
