# Course document style guide

This is the project's working editorial and design standard. Apply it to homework, workshop notes, project phases, and handouts through the shared Typst theme.

## References and skills

- [Butterick's Practical Typography: key rules](https://practicaltypography.com/summary-of-key-rules.html) and [Typography in ten minutes](https://practicaltypography.com/typography-in-ten-minutes.html): prioritize readable body text; control font size, line spacing, measure, and emphasis; use consistent paragraph spacing and avoid alignment with repeated spaces. Its numerical recommendations primarily describe Latin typography, so Persian settings are judged in rendered pages rather than copied mechanically.
- [Typst page setup guide](https://typst.app/docs/guides/page-setup/) and [text direction reference](https://typst.app/docs/reference/text/text/): implement consistent page geometry, furniture, and language/direction contexts.
- The installed PDF skill supplies the production workflow: compile, render, inspect every page, and repair visual defects before delivery.

An online skill search also found [Adobe's whitepaper skill](https://github.com/adobe/skills/blob/main/plugins/aem/project-management/skills/whitepaper/SKILL.md), which uses Pandoc and Typst. Its hierarchy and separate code typography are relevant, but its conversion workflow deletes input Markdown and assumes a whitepaper asset bundle. It was inspected as a reference, not installed or executed. Our reusable Persian course sources remain editable and local. Third-party web/CSS typography skills were not adopted as print-document workflows.

These are general publishing references, not an official University of Tehran brand manual. No verified public UT brand manual was found in this search.

## Identity and hierarchy

1. One unmodified UT seal, 32 mm wide, at the cover's upper right. Keep 10 mm between it and the neighboring affiliation text. Never stretch or redraw the seal.
2. Persian course name, document title, and number are the main information. University/faculty wording is supporting information.
3. Use a short Persian subtitle to describe the document. Omit English translations of course/institution names when they repeat Persian labels.
4. Write ordinary prose and descriptive names in Persian when a natural equivalent exists; do not add an English gloss when it merely repeats a clear Persian phrase. Keep English for exact code/API names, named products/libraries, and specialist terms students need to recognize. For example, the fictional research vessel is «کاوشگر جاوا», while the Java language name and its API identifiers retain their exact spelling.
5. Put supplied professor, preparer, term, publication date, and deadline metadata below the title area. Do not infer names or dates.
6. No running header/footer or printed page number on the cover. Body page numbering begins at ۱; running headers identify course and document.

## Typography and spacing

- Use Vazirmatn for Persian and ordinary Latin prose, JetBrains Mono for exact code, and native Typst math for formulas.
- Keep body text at 11 pt. Use the shared heading scale, navy text, and restrained blue accents. Bold signals hierarchy or a genuinely important instruction.
- Set spacing with layout functions and shared rules, never strings of spaces or blank paragraphs. Align cover and body groups to consistent right edges.
- The user selected an airy layout: generous white space between sections, with closer spacing inside related groups. Keep the cover's course/title anchor consistent whether metadata is present or absent.
- Prefer short descriptive headings. Keep headings with their following content; allow explanatory prose and code panels to flow naturally.
- Do not justify Persian prose by inserting manual kashida characters or extra spaces. Retain the theme's natural word spacing.
- Avoid adding heavy panels to ordinary prose. Code blocks and labeled notes may use a quiet tinted background.

The `spacing` dictionary in `course/theme.typ` owns the common rhythm. Values below are layout gaps, not baseline-to-baseline line heights. Typst may collapse adjacent block gaps and discard gaps at page boundaries; avoid adding compensating blank paragraphs.

| Relationship | Shared value |
| --- | --- |
| Body leading / paragraph spacing | 4 pt / 6 pt |
| Bullet, numbered, and checklist item spacing | 6 pt |
| Main heading before / after | 18 pt / 7 pt |
| Subheading before / after | 13 pt / 5 pt |
| Minor heading before / after | 10 pt / 4 pt |
| Notes, code, English blocks, display equations | 7 pt above and below |
| Panel padding | 10 pt horizontal, 8 pt vertical |
| Label to related text | 5 pt |
| Cover brand to course group | 22 mm |
| Cover course to document group | 5 mm |
| Cover title to subtitle / short rule | 4 mm / 6 mm |
| Cover title group to metadata | 10 mm |

Use the same 21 mm horizontal margin on cover and body. Body top/bottom margins are 24/20 mm; the header is lifted 7 mm above the body area. Table cells use 8 pt horizontal and 6 pt vertical padding. Inline code is 86% of its surrounding text size (9.46 pt in body prose); block code is 9 pt with 4 pt leading. Avoid assigning a fixed size to all raw text, which would stop inline code scaling in headings.

## Meaning determines inline styling

| Role | Markup | Treatment |
| --- | --- | --- |
| Name / ordinary English phrase | `en` | Proportional, isolated LTR span |
| Concept, e.g. Recursion or Array | `term` | Proportional, isolated LTR span |
| Exact Java type, identifier, expression, filename | `code-inline` | Monospace, isolated LTR span |
| Latin numeric value in Persian prose | `latin-number` | Proportional LTR digits, preserves notation |
| Code fragment, literal input/output, file tree | `code-block` | LTR panel preserving source lines |
| Mathematical expression | Native math / `math-inline` | Math typesetting |
| Warning or important note | `note[هشدار][...]` | Clear label and ordinary prose; code entities retain code styling |

English technical names required by an assignment remain unchanged. Persian sentence punctuation stays outside a Latin span; the span's own parentheses and punctuation stay inside. Do not add invisible bidi controls to individual paragraphs.

## Editorial and production quality

- Preserve assignment requirements, scores, examples, identifiers, outputs, and submission filenames. Record substantive ambiguities rather than resolving them silently.
- Review all PDF pages for shaping, punctuation, clipped content, header spacing, table alignment, page breaks, code characters, and numbering.
- Check both empty metadata and the populated proof cover. Keep real cover titles and author lists concise; review again after changing them.
- Keep PDF title/author metadata aligned with visible course metadata. Supply `pdf-author` when a separate publishing credit is needed.
- Build with bundled fonts and embedded math fonts, without network or system-font dependencies.
- Keep Typst sources, reference copies, font licenses, and provenance. Update the guide and verification record when the shared presentation changes.
