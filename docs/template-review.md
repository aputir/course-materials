# Template consistency and spacing review

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

## Evidence and authoring limits

See `verification.md` for compilation, all-page visual review, font sizes, PDF metadata, source fidelity, and portable rebuild evidence. `document-style-guide.md` contains the numeric spacing scale; `technical-decisions.md` explains the implementation.

Inline boxes keep short technical spans intact; use a full English paragraph or code block for long material. Raw code preserves authored line breaks. Arbitrarily long titles, large author lists, and changed content need another visual review. Actual names, term, and dates remain optional until supplied. Source assignment ambiguities are recorded for the teaching team rather than changed during template work.
