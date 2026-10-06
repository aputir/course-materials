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
