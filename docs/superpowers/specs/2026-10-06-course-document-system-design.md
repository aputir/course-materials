# UT Advanced Programming document system

## Purpose

Create a reusable Typst system for the University of Tehran Advanced Programming course. It must provide one coherent visual identity across homework sheets, workshop notes, project phase descriptions, and future course handouts. The first finished document will be the Persian first homework supplied by the user.

## Source findings and constraints

- The supplied PDF and DOCX contain the same Persian-first assignment. The document title identifies it as the first homework for Advanced Programming, although both filenames contain `Homework 0x04`.
- The homework contains six missions, practical and analytical subsections, point values, Java code and identifiers, a submission guide, a checklist, TA contact handles, and a short closing note. Preserve all meaningful instructions and scoring.
- The content is Persian with embedded English technical terms and code, including `Java`, `GOval`, `ship.getX()`, `Integer Division`, and `Short-Circuit Evaluation`.
- The source PDF is US Letter. The new system will use A4, as proposed and approved by the user.
- The supplied DOCX embeds the University of Tehran seal and a Faculty of Engineering mark. Use an official University of Tehran logo asset where a suitable downloadable file is available. For the Engineering mark, prefer an official online PNG/SVG if it can be verified; otherwise use the exact supplied mark, retain its attribution/source note, and avoid redrawing it.
- Course term, instructor, and other missing metadata must remain configurable. Do not invent values.

## Approaches considered

1. **Shared core with type-specific templates (recommended):** centralize brand tokens, page furniture, typography, and reusable blocks; provide focused homework, workshop, project phase, and generic handout templates. This keeps the family consistent and lets each document type have appropriate content structures.
2. **Separate full templates:** quick to create initially, but repeated layout and style decisions would drift over time.
3. **One large conditional template:** minimizes files, but mixes unrelated document logic and makes future editing harder.

Use approach 1.

## Visual system

- Formal, modern academic tone with a restrained technical character.
- A4 pages with Persian RTL composition, dark navy text, University of Tehran blue as the main accent, a quiet neutral background palette, and limited geometric details.
- Use the two institutional marks as supporting identity, not as oversized decoration.
- Establish a clear title, subtitle, document type, number, and course metadata hierarchy. Use consistent running headers/footers and page numbering on continuation pages.
- Reuse components for mission/question headers, score labels, practical/analytical labels, callouts, submission checklists, examples, tables, and code/math content.
- Homework pages emphasize mission structure and score breakdown. Workshop notes emphasize learning goals, concepts, examples, exercises, and takeaways. Project phase descriptions emphasize objectives, deliverables, milestones, evaluation criteria, and deadlines. The generic handout template supports content not covered by those three types.

## Persian, English, code, and mathematics

Use Typst's built-in bidirectional text layout and make direction explicit at semantic boundaries:

- Set the document's primary text language to Persian (`fa`) and dominant direction to RTL.
- Provide an inline English helper that marks a span as English/Latin and LTR. Keep Persian prose in the RTL paragraph so punctuation and line wrapping follow the paragraph's direction.
- Provide a code helper that uses Typst raw blocks, a monospaced font, and LTR direction. Inline identifiers and longer Java listings must remain readable in natural source order.
- Typeset equations with Typst's native math syntax rather than composing formula glyphs as ordinary text. Keep displayed equations and their numbering/alignment predictable within the RTL page layout.
- Avoid manual Unicode bidi control characters as the default authoring technique. If a specific mixed punctuation pattern renders incorrectly, isolate a reusable helper for that case and document the reason rather than adding invisible controls throughout content.
- Include a mixed-script proof page or fixture using Persian sentences with leading/trailing punctuation, parentheses, English names, Java member access, comparison operators, inline math, displayed math, and multiline code. Inspect the compiled PDF visually and check copied/extracted text order where practical.

Typst's official documentation says RTL language/direction should be set for right-to-left scripts; individual runs are direction-aware, while the dominant direction helps order punctuation and inline objects. It also supports direction-aware alignment and native equation markup. Implementation must still verify the actual Persian/Latin combinations used here in the compiled PDF.

## Reference sources

- Typst text direction and language: <https://typst.app/docs/reference/text/text/>
- Typst direction values and directional layout: <https://typst.app/docs/reference/layout/direction/>
- Typst equation layout and alignment: <https://typst.app/docs/reference/math/equation/>
- Current compiler release: <https://github.com/typst/typst/releases>
- Official University of Tehran logo asset visible on the university site: <https://ut.ac.ir/assets/5c006a29/images/logos/loading-logo.png>
- Faculty of Engineering mark: embedded in the user-supplied DOCX; replace with an official online vector/raster only if its match and source can be verified.

## Typography and assets

- Bundle or otherwise pin an openly licensed Persian-capable font and a compatible monospaced code font so output is reproducible across machines. Record font names, versions, and licenses in the project documentation.
- Check glyph coverage for Persian letters, Persian/Arabic punctuation, Latin technical terms, and the mathematical symbols used in the assignment.
- Keep image assets local to the project. Record each logo's source URL or source document, file format, and any applicable reuse terms.
- Prefer SVG for clean scalable institutional marks; use PNG when a suitable vector source is unavailable.

## Typst project shape

Organize the project around:

- A shared course theme module for metadata, colors, fonts, RTL/LTR helpers, page setup, headers/footers, and reusable content components.
- One small editable template for each supported document type.
- A complete HW1 source document that imports the shared theme and exercises the components with the supplied content.
- Local logo/font assets, compiled preview PDFs, and a README with edit and compile commands.
- A technical decisions document describing the architecture, bilingual typesetting policy, logos/fonts, and maintenance guidance.

The precise filenames and directory layout are an implementation detail, but shared styling must have one source of truth.

## Deliverables

1. Reusable Typst core and blank templates for homework, workshop notes, project phase descriptions, and generic handouts.
2. A complete reworked HW1 `.typ` source and compiled A4 PDF.
3. Local course assets with documented sources and font licenses.
4. README/editing instructions and technical decisions documentation.
5. Original supplied PDF and DOCX retained as references inside the project.

## Acceptance criteria

- Every template compiles with Typst 0.15.1 and has consistent branding, typography, margins, and page furniture.
- HW1 preserves the six missions, all prompt text, point values, submission rules, contact details, code/formula examples, and the document's first-homework identity.
- Persian paragraphs flow RTL; English terms, Java code, and equations remain correctly ordered and legible in mixed lines and standalone blocks.
- The compiled HW1 PDF has no clipping, collisions, awkward page breaks, missing glyphs, distorted logos, or unreadable code/math.
- A maintainer can change course/term/instructor metadata and theme settings centrally, and can create each document type without editing the shared layout internals.
- Source assets, font licenses, and the choices made for the document system are documented.

## Deferred details

- Exact term, instructor, and optional course contact metadata will be filled by the user when available; the templates will expose these fields without fabricated defaults.
- Any additional document types beyond the named list can use the generic handout or gain a focused template later.

## Subsequent cover and authoring refinement

On 2026-10-06 the user requested a dedicated minimal cover and emphasized that the course name and document identity should take priority over university/department wording. The revised shared cover gives the course, descriptive title, and number prominent placement, with quieter institutional branding above and optional names/dates below. Body content starts on a new page, numbered ۱. Professor and preparer metadata are separate optional fields; actual names remain unsupplied.

The user also requested consistent handling of English names, concepts, exact Java entities, Latin numbers in regular text, code blocks, and warnings throughout the starters and generic handout. These are explicit authoring roles: proportional text for names/concepts/numbers, monospaced text for exact code entities, native math for formulas, and dedicated panels only for complete code or labeled notes. Shared spacing and header hierarchy are refined; HW1's assignment wording is preserved.

## Current identity refinement (supersedes earlier logo layout)

The user's latest instructions remove the Engineering mark from all templates, enlarge the UT seal, omit duplicated English course names, and use a Persian HW1 title. The current cover uses one 32 mm UT seal at the upper right with 10 mm space to supporting affiliation text. HW1 is titled «تمرین اول» with a Persian descriptive subtitle. Course identity and document title/number remain primary. Required technical terms inside assignment prose are preserved. `docs/document-style-guide.md` is the ongoing publishing standard, grounded in researched typography guidance and official Typst documentation.

## Airy spacing refinement

The user selected an airy feel with generous but consistent space. The shared theme uses a central absolute spacing scale, with larger section gaps and smaller label/content gaps. Cover and body share a 21 mm horizontal margin. The cover's course/title anchor remains steady when optional metadata is filled; names and dates follow the title group. Lists and checklists share one item gap, and notes/code use explicit padding without accumulated default gaps. Inline code scales with its surrounding text while listings keep a readable fixed size. PDF author metadata must follow the visible configuration or an explicitly supplied publishing credit. The audit record and publishing guide describe the implementation and measured values.
