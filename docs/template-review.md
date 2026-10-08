# Template consistency and spacing review

The [final review of 2026-10-08](final-review-2026-10-08.md) records the latest prompt change, full-family production review, two open compression-helper issues, semantic/documentation polish, and optional layout refinements. The findings below document the earlier unification work.

## Current audit (2026-10-08)

The project has one master theme (`src/course/theme.typ`) and focused starters. `course-document`, `course-workshop`, and `course-slides` represent A4 documents, workshop composition, and widescreen presentation geometry within that theme. Source inspection found no local font, margin, type-size, or layout overrides in document/template/proof entries.

| Gap found | Resolution |
| --- | --- |
| The actual workshop manually assembled its cover, while the starter omitted the shared illustration and reflection. | Both use `course-workshop`, which automatically adds the cover and closing page. |
| English used the Persian font; some proof prose bypassed the language helper. | Bundle four Lora styles; use Lora for English helpers and a Lora/Vazirmatn default fallback stack. Isolate the proof's English term with `term`. |
| Mission and ordinary heading sizes could diverge; slides had one undifferentiated in-shell heading size. | One `type-scale` owns A4 headings at 16/12/11 pt above 11 pt body text; `slide-style` differentiates in-shell levels at 30/28/26 pt below the 38 pt page title. |
| Code/math semantics were repeated between documents and slides. | One `semantic-typography` rule owns raw/math/link behavior in both. |
| Paragraph, list, and section gaps were slightly loose for compact workshop notes. | Tighten the shared scale to 5 pt paragraph/items and 16/6 pt main-heading gaps; retain 4 pt leading and readable panel padding. |
| The quote had no visual enclosure. | One thin-frame component uses Lora Italic for the cover quote and closing-page title. |
| Repeated quote/story/image and prompt prefixes could drift between workshops. | One shared content dictionary owns the reflection. The improved prompt appends context to the single stored initial prompt. |
| The story and examples incorrectly followed the Persian-first rule, and the prompt example lacked meaningful design detail. | The entire reflection uses English LTR Lora. The user-selected p5.js ships example specifies visual decisions, object methods, motion, and canvas-edge behavior. Future-workshop requirements are explicit in AGENTS and the editorial brief. |
| The quote lacked double quotation marks and the reflection lacked a reader invitation. | The shared frame adds double marks on both pages; shared copy ends by asking readers to try both prompts and share their experience with classmates. |
| Build entry paths and output mappings were maintained twice. | One build registry drives individual selectors, `all`, and usage text. |
| HW1's input/output example specified its column gutter locally. | The theme's `example-columns` helper owns the equal-column layout and gap; the example text is unchanged. |
| The rationale still described Vazirmatn for English and a checkout without Git metadata. | Update the current rationale, style guide, README, asset provenance, and verification record. |

The English closing story connects the shared lantern light to the learner's understanding: experience improves how they frame the problem, supply context, and evaluate an answer. The user-selected example compares a simple request to animate ships in p5.js with the same request plus visual choices, an array of ship objects, separate methods, elapsed-time movement, edge wrapping, and an explanation of decisions. It introduces no new assignment requirement. The editorial subagent reviewed the ships revision for clarity, technical meaning, and suitability; it supersedes the earlier tournament scenario developed by the writing subagents.

See `verification.md` for the final build, 32-page review, font checks, original workshop destinations, unchanged HW1 requirements/examples, metadata-populated cover, and fresh-copy compilation. The audit below is the earlier design record; its spacing numbers were superseded by this revision.

## Earlier audit (2026-10-06)

Date: 2026-10-06. User direction: **airy, generous space, but consistent**.

The revision applies to the shared theme, all four starters, the typography proof, and HW1's rendered presentation. The HW1 content remains the same; the fictional vessel's name and ordinary English prose now use Persian equivalents.

## Findings and changes

| Finding | Change |
| --- | --- |
| Heading gaps inherited larger type sizes; spacing rules were scattered. | One absolute spacing scale, with 18/7 pt section gaps and 13/5 pt subsection gaps. |
| Cover title position shifted when optional names/dates were filled and sat too far below the seal. | A fixed anchor after the brand group, 22 mm below it; metadata follows the title group. |
| Cover and content used different horizontal margins. | A shared 21 mm edge alignment. |
| Related labels and panel content accumulated default paragraph/block gaps. | Explicit 6 pt label gaps and controlled nested spacing. |
| Lists and checklists used different relative spacing. | One 6 pt item gap for all three list types. |
| Tables and code/notes had inconsistent padding. | Tables use 8/6 pt; code and notes use 10/8 pt, suited to their distinct content. |
| Inline code was fixed at 9 pt despite requesting relative sizing. | Inline code scales to 86% of surrounding type; block listings remain 9 pt. |
| PDF author metadata was hardcoded. | Derive it from visible course metadata; allow an explicit publishing credit. |
| Documentation implied code wrapped like prose and the build script discovered every new file. | Clarify source line breaks, six bundled build entries, prerequisites, and manual build location. |
| A previous cover revision lacked a long-title/multiple-name check. | Rendered a three-line title with all optional fields and four illustrative preparer names. |

## Design judgment

White space separates unrelated sections; close gaps connect labels, titles, and explanations. The course/title group stays prominent on the cover, and the single UT seal anchors institutional identity above it. Missing metadata leaves intentional white space. Content pages are not stretched to fill their height; mission page breaks remain author-controlled.

The first implementation felt too loose when inspected as actual pages: body lines were spaced 7 pt apart, paragraph and list gaps were 8 pt, and section openings were 24 pt. The revised rhythm cuts those distances while retaining distinct headings and panel padding. The cover brand-to-title gap is reduced from 30 mm to 22 mm. This visual pass intentionally tunes the page relationships as a whole instead of treating the word “airy” as a request to maximize each gap.

The family retains Persian-first titles, one unmodified 32 mm UT seal, navy text, restrained blue accents, and semantic LTR handling for English, code, numbers, and math. Exact Java/API names, named products/libraries, and needed specialist English terminology remain intact.

In response to the user's language review, HW1's fictional ship/homework name is «کاوشگر جاوا». Ordinary concepts and the closing topic list use Persian phrasing. Exact Java/API and file names, software product names, Stanford ACM Graphics, and the specialized short-circuit term remain where students benefit from recognizing those labels.

A follow-up bilingual-text review confirmed that no «Java Explorer» phrase remains in HW1 and the visible English spans are exact language/API/product names, code literals, or specialist course terminology. The homework starter's ordinary English placeholder comment was removed from its Java example; the Persian instructions now carry that guidance. The style guide explicitly avoids English glosses that only repeat clear Persian wording.

The first HW1 content page now introduces a restrained six-mission story arc and gives the student a clear role on the ship's programming team. Its pre-mission notes group the existing language, topic, reasoning, readability, input, and submission rules in concise action-oriented wording. Visual inspection confirms the page still fits cleanly; no assignment constraint was removed.

## Evidence and authoring limits

See `verification.md` for compilation, all-page visual review, font sizes, PDF metadata, source fidelity, and portable rebuild evidence. `document-style-guide.md` contains the numeric spacing scale; `technical-decisions.md` explains the implementation.

Inline boxes keep short technical spans intact; use a full English paragraph or code block for long material. Raw code preserves authored line breaks. Arbitrarily long titles, large author lists, and changed content need another visual review. Actual names, term, and dates remain optional until supplied. Source assignment ambiguities are recorded for the teaching team rather than changed during template work.
