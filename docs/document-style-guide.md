# Course document style guide

This is the project's working editorial and design standard. Apply it to homework, workshop notes, project phases, and handouts through the shared Typst theme.

## References and skills

The bilingual primitives (`ltr`, `rtl`, `code-inline`, `math-inline`, and
Persian digit conversion) come from the pinned local [Dorost package](../packages/README.md).
The course theme remains the source of APUT page geometry, visual identity,
and course-specific components.

- [Butterick's Practical Typography: key rules](https://practicaltypography.com/summary-of-key-rules.html) and [Typography in ten minutes](https://practicaltypography.com/typography-in-ten-minutes.html): prioritize readable body text; control font size, line spacing, measure, and emphasis; use consistent paragraph spacing and avoid alignment with repeated spaces. Its numerical recommendations primarily describe Latin typography, so Persian settings are judged in rendered pages rather than copied mechanically.
- [Typst page setup guide](https://typst.app/docs/guides/page-setup/) and [text direction reference](https://typst.app/docs/reference/text/text/): implement consistent page geometry, furniture, and language/direction contexts.
- The installed PDF skill supplies the production workflow: compile, render, inspect every page, and repair visual defects before delivery.

An online skill search also found [Adobe's whitepaper skill](https://github.com/adobe/skills/blob/main/plugins/aem/project-management/skills/whitepaper/SKILL.md), which uses Pandoc and Typst. Its hierarchy and separate code typography are relevant, but its conversion workflow deletes input Markdown and assumes a whitepaper asset bundle. It was inspected as a reference, not installed or executed. Our reusable Persian course sources remain editable and local. Third-party web/CSS typography skills were not adopted as print-document workflows.

These are general publishing references, not an official University of Tehran brand manual. No verified public UT brand manual was found in this search.

## Identity and hierarchy

1. One unmodified UT seal, 32 mm wide, at the cover's upper right. Keep 10 mm between it and the neighboring affiliation text. Never stretch or redraw the seal.
2. Persian course name, document title, and number are the main information. University/faculty wording is supporting information.
3. Use a short Persian subtitle to describe the document. Omit English translations of course or institution names when they repeat Persian labels.
4. Write ordinary prose and descriptive names in Persian when a natural equivalent exists; do not add an English gloss when it merely repeats a clear Persian phrase. Keep English for exact code/API names, named products/libraries, and specialist terms students need to recognize. For example, the fictional research vessel is «کاوشگر جاوا», while the Java language name and its API identifiers retain their exact spelling.
5. Put supplied professor, preparer, term, publication date, and deadline metadata below the title area. Do not infer names or dates.
6. No running header/footer or printed page number on the cover. Body page numbering begins at ۱; running headers identify course and document.

## Typography and spacing

- Use Vazirmatn for Persian, Lora for English prose/names/concepts/numbers/quotes, JetBrains Mono for exact code, and native Typst math for formulas. The common fallback stack starts with Lora and falls back to Vazirmatn for Persian; use the semantic helpers for direction as well as font.
- Keep body text at 11 pt and main/sub/minor headings at 16/12/11 pt. Normal and mission headings read from the same `type-scale`. Use navy text and restrained blue accents. Bold signals hierarchy or a genuinely important instruction.
- Set spacing with layout functions and shared rules, never strings of spaces or blank paragraphs. Align cover and body groups to consistent right edges.
- Keep related groups compact while leaving clear separation between sections. Keep the cover's course/title anchor consistent whether metadata is present or absent.
- Prefer short descriptive headings. Keep headings with their following content; allow explanatory prose and code panels to flow naturally.
- Do not justify Persian prose by inserting manual kashida characters or extra spaces. Retain the theme's natural word spacing.
- Avoid adding heavy panels to ordinary prose. Code blocks and labeled notes may use a quiet tinted background.

The `spacing` dictionary in `src/course/theme.typ` owns the common rhythm. Values below are layout gaps, not baseline-to-baseline line heights. Typst may collapse adjacent block gaps and discard gaps at page boundaries; avoid adding compensating blank paragraphs.

| Relationship | Shared value |
| --- | --- |
| Body leading / paragraph spacing | 4 pt / 5 pt |
| Bullet, numbered, and checklist item spacing | 5 pt |
| Main heading before / after | 16 pt / 6 pt |
| Subheading before / after | 11 pt / 4 pt |
| Minor heading before / after | 9 pt / 3 pt |
| Notes, code, English blocks, display equations | 6 pt above and below |
| Panel padding | 10 pt horizontal, 8 pt vertical |
| Label to related text | 4 pt |
| Cover brand to course group | 22 mm |
| Cover course to document group | 5 mm |
| Cover title to subtitle / short rule | 4 mm / 6 mm |
| Cover title group to metadata | 10 mm |

Use the same 21 mm horizontal margin on cover and body. Body top/bottom margins are 24/20 mm; the header is lifted 7 mm above the body area. Table cells use 8 pt horizontal and 6 pt vertical padding. Inline code is 86% of its surrounding text size (9.46 pt in body prose); block code is 9 pt with 4 pt leading. Avoid assigning a fixed size to all raw text, which would stop inline code scaling in headings.

## Meaning determines inline styling

| Role | Markup | Treatment |
| --- | --- | --- |
| Name / ordinary English phrase | `en` | Lora, isolated LTR span |
| Concept, e.g. Recursion or Array | `term` | Lora, isolated LTR span |
| Exact Java type, identifier, expression, filename | `code-inline` | Monospace, isolated LTR span |
| Latin numeric value in Persian prose | `latin-number` | Lora LTR digits, preserves notation |
| Code fragment, literal input/output, file tree | `code-block` | LTR panel preserving source lines |
| Mathematical expression | Native math / `math-inline` | Math typesetting |
| Warning or important note | `note[هشدار][...]` | Clear label and ordinary prose; code entities retain code styling |

English technical names required by an assignment remain unchanged. Persian sentence punctuation stays outside a Latin span; the span's own parentheses and punctuation stay inside. Do not add invisible bidi controls to individual paragraphs.

## Editorial and production quality

### Links and optional cover illustrations

Ordinary document links use blue text and an underline so they remain distinguishable without relying only on color. For stand-alone resources, use the shared `resource-link(url, label, detail: none)` and `resource-links(...)` helpers. Cards use the existing pale fill, quiet border, panel inset, blue underlined title, and an external-link arrow. The whole card is a link; optional detail text stays un-underlined. Use meaningful Persian labels rather than a bare address. Displayed English domains and software names use `en` for an isolated LTR context.

Group related resources in one row, as in the first workshop's two IntelliJ resources and three VSCode resources. Use concise labels; do not repeat the same explanation in every card. Keep a section's introductory text and its resource together when reviewing page breaks.

For setup instructions with alternative tools, use one descriptive main heading and parallel level-2 headings for the recommended and alternative paths. Keep the recommendation in the subheading, platform guidance before its related resource row, and link labels specific to their purpose or operating system. The first workshop uses «آماده‌سازی محیط برنامه‌نویسی», then «مسیر پیشنهادی» for IntelliJ IDEA and «مسیر جایگزین» for VSCode. Use the theme's standard heading sizes and spacing; do not add entry-level formatting overrides.

`course-document` accepts optional `cover-artwork` content. `cover-vignette(path, quote)` centers a lower-cover illustration in a 130 × 72 mm area and a separate 13 pt Lora Italic LTR quote within a thin navy frame. The quote stays editable and selectable. The title/metadata anchors and single UT seal remain unchanged; the cover has no running furniture or printed number. Artwork is opt-in for generic documents; workshop covers receive it automatically.

### Workshop composition contract

Use `course-workshop` for every workshop. It delegates the cover/body layout to `course-document` and automatically appends one dedicated closing page. Both the workshop starter and actual workshop use it; do not reproduce the quote, image, story, or prompt examples in entry files.

`src/course/workshop-reflection.typ` owns the common quote, artwork path, professional English story, prompt labels, initial request, refinement, takeaway, and invitation. It exports content without importing the theme or specifying local typography. The improved prompt is the initial request plus the stored refinement, so they cannot drift into unrelated requests. The user-selected example animates ships on a p5.js canvas; the refinement specifies visual choices, object state, method responsibilities, initialization, elapsed-time movement, edge wrapping, and an explanation of decisions. The constraints express subject knowledge and make the answer checkable and easier to modify.

`workshop-style` owns image geometry and frame styling. The closing image occupies 158 × 96 mm and is larger than the cover image. The final page title is the same English quote at 22 pt Lora Italic in the shared frame, followed by the illustration, story, two labeled prose panels, takeaway, and invitation. The frame adds typographic double quotation marks once around the stored quote, on both cover and closing page.

The entire closing reflection must use English LTR flow. Prose, labels, and quotes use Lora; exact code identifiers retain JetBrains Mono, and math retains its native font. This is the user's explicit exception to Persian-first course prose and applies to every future workshop. Audience interests should shape the example, without inserting “Gen Z,” “AP student,” or novice labels into the narrative. End by inviting the reader to try both prompts, compare/check the answers, and share their experience with classmates. Prompt text is prose, not code. Keep this section on a single page and review fit after editing the shared copy. See [the full editorial brief](brand/workshop-reflection-editorial.md).

For the APUT monochrome adaptation, follow [the brand guide](brand/README.md): sparse black pen strokes, a white background, rounded silhouettes, lantern light, and a restrained lighthouse/orbital cue. Keep original brand references separate from finished illustrations. Do not treat the supplied creative board as an official institutional identity manual.

### Production checks

- Preserve assignment requirements, scores, examples, identifiers, outputs, and submission filenames. Record substantive ambiguities rather than resolving them silently.
- Review all PDF pages for shaping, punctuation, clipped content, header spacing, table alignment, page breaks, code characters, and numbering.
- Check both empty metadata and the populated proof cover. Keep real cover titles and author lists concise; review again after changing them.
- Keep PDF title/author metadata aligned with visible course metadata. Supply `pdf-author` when a separate publishing credit is needed.
- Build with bundled fonts and embedded math fonts, without network or system-font dependencies.
- Keep Typst sources, reference copies, font licenses, and provenance. Update the guide and verification record when the shared presentation changes.

## Presentations

The slide family uses `course-slides` and the `slide-*` helpers in `src/course/theme.typ`. `slide-style` owns its 960 × 540 pt canvas, 48 pt horizontal and 30 pt vertical margins, and typography. Use Vazirmatn at 24 pt for body copy, 38 pt for content titles, 58 pt for cover titles, and 62 pt for section titles. Code blocks use 19 pt JetBrains Mono; inline code scales with surrounding text. Header labels are 14 pt and footer credits/numbers are 12 pt.

English slide prose uses Lora through the same semantic helpers and fallback stack as documents. In-shell heading levels are 30/28/26 pt, below the 38 pt slide title and above 24 pt body text. `slide-style` owns these roles, code size, caption/metadata sizes, and paragraph/list rhythm. Use heading levels for within-slide content; slide titles are supplied by the `slide-*` helpers.

Keep compositions flat and airy. White content pages, navy section dividers, a pale statement page, large titles, and restrained blue accents provide variety without decorative panels around ordinary prose. Two-column layouts place the first column on the right. Use a code panel only for literal code.

The cover uses one original UT seal, 80 pt wide, at the upper right. It has no running furniture or printed number. Other branded layouts use course/section labels and Persian slide numbering beginning at ۱. Image-only slides override those conventions: exactly one complete image occupies the canvas with no added copy, logo, header, footer, or printed number. Their default `contain` fit preserves image proportions and all source content. Optional `cover` fit crops and must be an intentional author choice.

The demonstration deck is `src/templates/slides.typ`; it uses the tracked workshop illustration for its image examples. The maintainer-local `src/documents/evolution-ai-story.typ` presentation and its 43 original illustrations are kept outside Git and the portable source archive. Presentation authoring follows the same Persian prose, bilingual-helper, bundled-font, render-and-review rules as the course documents. Treat all demonstration copy as placeholders and review long titles, lists, and code after editing.
