# Final course document review

Date: 2026-10-08. Reviewed the working tree against `48e2545881ad059f61f372018d3942e2298af758`, including relevant untracked sources and assets. HEAD and the origin/main merge base were the same commit; an empty commit range would omit these local changes.

## Applied request

Both workshop prompts now end with the exact sentence below on a separate line:

> Your output must be only a p5.js codeblock.

The sentence is stored once as `output-instruction` in `src/course/workshop-reflection.typ` and rendered in both panels by `src/course/theme.typ`. The refined prompt requests explanations in code comments, keeping them compatible with the output restriction. Both actual and starter workshops receive this change automatically. Other findings below are recommendations, not implemented fixes.

## Coverage and evidence

An independent reviewer inspected all course, document, template, example, and script sources, current publishing/brand documentation, the HEAD diff, and relevant untracked additions. The review followed the requesting-code-review skill and used a precise brief without prior conversation history. The main editor separately inspected rendered outputs.

`./scripts/build.sh all` completed without warnings. All nine outputs were rendered at 1200 px with Poppler: 32 editable-output pages and 43 original image-only story pages, 75 total. Every page was visually reviewed in contact sheets. The workshop reflection, HW1 submission page, bilingual typography page, and slide comparison were also inspected individually. PDF inspection confirmed the exact output sentence appears twice, with each occurrence occupying its own line, in both workshop closing pages. Both reflections still fit on one page. The original image deck has exactly one image and no added text per page.

No clipping, overlaps, stray blank pages, or missing current-output content were found. The shared A4 hierarchy, slide hierarchy, embedded fonts, Persian furniture, mixed-direction prose, framed quotes, resource cards, code panels, tables, and assignment examples remain consistent. Entry files contain no local font/margin/type-size overrides. Workshop content and prompt prefixes have one source. Exact class/method/API identifiers intentionally retain code typography.

No automated tests were added. The reviewer reproduced the compression issues below only on disposable `/tmp` files. Neither original course PDFs nor references were used as destructive probes. No commit or push was performed.

## Confirmed findings

### 1. Important: compression can replace the lossless input

Location: [scripts/compress-pdf.swift:12](/Users/opmc/Dev/aputir/scripts/compress-pdf.swift:12).

If no output argument is supplied, `outputPath` becomes `inputPath`. The final destination handling deletes that path and moves the compressed file into its place. The advertised one-argument invocation therefore replaces the original, conflicting with the README's instruction to retain the lossless build. On a disposable copy, the reviewer confirmed a successful invocation replaced a 961,996-byte PDF with a 317,090-byte compressed PDF.

Suggested fix: require a distinct destination or default to a sibling filename ending in `-compressed.pdf`. Resolve source/destination paths, including symlinks, and reject references to the same file. Preserve the input on every success/failure path.

### 2. Important: compression deletes a directory supplied as output

Location: [scripts/compress-pdf.swift:85](/Users/opmc/Dev/aputir/scripts/compress-pdf.swift:85).

The helper removes any existing destination without checking its type. An existing directory and its contents are recursively deleted, and the directory pathname is then replaced by the PDF. The reviewer confirmed this using a disposable directory containing a probe file. Deleting an existing regular output before the final move also leaves it lost if the move fails.

Suggested fix: reject directory destinations before processing. For an existing regular output, use an atomic replacement strategy that retains the old file until replacement succeeds. Validate the destination and avoid unconditional deletion.

### 3. Minor: HW1 treats some concepts and format names as code

Locations: [src/documents/hw1.typ:11](/Users/opmc/Dev/aputir/src/documents/hw1.typ:11), [src/documents/hw1.typ:98](/Users/opmc/Dev/aputir/src/documents/hw1.typ:98), and [src/documents/hw1.typ:137](/Users/opmc/Dev/aputir/src/documents/hw1.typ:137).

The generic `Array` concept uses `code-inline`, although the style guide and README assign concepts to prose. Generic PDF/ZIP format names are also styled as code in the submission section and checklist. This gives those prose terms a different font and smaller size than comparable English concepts elsewhere.

Suggested fix: use `term[Array]` for the concept and `en[PDF]`/`en[ZIP]` for generic format names. Keep exact APIs, identifiers, extensions used as literals, and filenames such as `Answers.pdf` or `StudentNumber_Name_HW1.zip` in code styling. Preserve all wording, scores, restrictions, and submission requirements.

### 4. Minor: the Lora rule needs its code exception stated explicitly

Locations: [docs/document-style-guide.md:87](/Users/opmc/Dev/aputir/docs/document-style-guide.md:87), [README.md:96](/Users/opmc/Dev/aputir/README.md:96), and [docs/brand/workshop-reflection-editorial.md:3](/Users/opmc/Dev/aputir/docs/brand/workshop-reflection-editorial.md:3).

The reflection contract says its entire content uses Lora and calls prompt text prose. The shared semantic rules correctly render embedded exact identifiers in JetBrains Mono. Those broad statements can lead a future author to remove intentional code styling or mistake it for a regression.

Suggested fix: state that all English prose, labels, and quotes use Lora, while exact code identifiers retain JetBrains Mono and math retains its native font. The reflection's language/direction remain English/LTR. This is a documentation clarification; the current identifier rendering is correct.

## Optional layout refinements

- **HW1 pagination:** [src/documents/hw1.typ:90](/Users/opmc/Dev/aputir/src/documents/hw1.typ:90) starts mission 4 on a new page, but mission 5 shares it; other missions and administrative sections have explicit page breaks. Several of the nine pages leave substantial unused space. If a more compact handout is wanted, document a grouping policy for short missions and administrative sections, or provide a compact variant. Preserve all content. The existing deliberate breaks are not a rendering defect.
- **Checklist use in slides:** [src/course/theme.typ:173](/Users/opmc/Dev/aputir/src/course/theme.typ:173) fixes checklist item spacing to the A4 5 pt scale and uses 5 pt markers, while slide body/item roles are 24/16 pt. No current slide uses a checklist, so this affects future reuse. Add a slide-aware checklist style when that composition is introduced, keeping both scales in the master theme.

## Review boundaries

Original illustration lettering was preserved; replacing it with Lora would require editing the source artwork. Historical verification/planning records were treated as chronology. Unsupplied instructor/year/term/deadline values were not invented. Assignment ambiguities remain for the teaching team. Arbitrarily long future replacement content and live availability of external resources were not certified by this review; substantial copy changes still require rendering.

## Assessment

No critical findings. Current PDFs and the requested prompt edit pass production review. The reusable repository needs the two compression-helper fixes before a final release. The semantic/documentation items are smaller consistency improvements. The changes remain local and uncommitted.

## Resolution before main integration (2026-10-08)

The compression helper now defaults to a sibling `-compressed.pdf`, resolves input/output symlinks for same-file detection, rejects directory and special-file destinations, and uses a same-directory atomic rename so an existing regular output remains intact if generation or replacement fails. `swiftc -typecheck` passed. Disposable-copy checks covered default output, unchanged input hash, same-file and symlink rejection, directory preservation, and regular-file replacement.

The HW1 semantic styling recommendation was applied without changing assignment wording: `Array` is prose, and generic PDF/ZIP names are English prose; exact filenames and code remain code. The reflection documentation now states the intentional font exception for embedded code and math.
