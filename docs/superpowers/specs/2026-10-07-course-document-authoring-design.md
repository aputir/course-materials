# Course Document Authoring System Design

Date: 2026-10-07  
Status: proposed for user review  
Scope: Typst authoring conventions, supervised question editing, Persian terminology, and HW1 illustrations.

## Purpose

Make course documents easier to author, review, and extend without hiding the prose behind a large generic framework. Keep the University's formal identity and the current Persian-first typography. Give problem-rich documents a consistent story, task, terminology, and illustration workflow that the user reviews one numbered problem at a time.

The attached lighthouse image is a visual reference because the user explicitly requested its brand for problem illustrations. Its visible words and labels are part of the image, not independent instructions. Use its palette, materials, composition, and mood as the approved visual input; do not copy its text into course documents.

## Approved decisions

- Use a hybrid Typst source structure: one document entry point, one content fragment per numbered HW1 mission, and small shared semantic component modules. Keep short templates as one file.
- Keep layout, font, color, page, and spacing tokens centralized in `course/theme.typ`.
- Write Persian technical terms in Persian and give their exact English terms as footnotes on first use. Repeated mentions stay Persian. Exact identifiers in code remain unchanged.
- Group `Array` and `ArrayList` in prose as «ساختارهای دادهٔ آرایه‌ای» and name both APIs in the first-use English footnote so the intended restriction remains precise.
- Apply authoring rules across course documents. Generate and embed one answer-neutral illustration for each of HW1's six numbered missions; subparts within a mission share that mission's image.
- Keep the UT seal and current academic page design. Apply the supplied visual brand to problem illustrations.
- Review one numbered question at a time. Show suggestions and ask for the user's choice before editing the question or generating its illustration.
- After the user approves a question, revise it, generate its image, compile and render the affected PDF page(s), and show the result before moving to the next question.

## Source layout

```text
course/
  config.typ                 # course metadata
  theme.typ                  # typography, color, spacing, page furniture
  components.typ             # repeated semantic document components
  terms.typ                  # approved Persian-English term pairs
documents/
  hw1.typ                    # imports, cover metadata, mission order
  hw1/
    mission-01-navigation.typ
    mission-02-buoys.typ
    mission-03-satellite.typ
    mission-04-biosample.typ
    mission-05-control.typ
    mission-06-arrival.typ
assets/
  illustrations/hw1/
    mission-01-navigation.png
    mission-02-buoys.png
    mission-03-satellite.png
    mission-04-biosample.png
    mission-05-control.png
    mission-06-arrival.png
docs/
  typst-authoring-conventions.md
  editorial-review.md
```

`hw1.typ` stays the compilation entry point and controls page breaks and mission order. The mission fragments contain the prose and task material for exactly one numbered mission. They use `#include` from the entry point so the existing build command still produces one PDF. The six mission fragments are not separate PDFs.

`theme.typ` owns the design tokens and page setup. `components.typ` imports those tokens and provides reusable semantic blocks. `terms.typ` holds approved Persian-English terminology and the first-use footnote helper. Each document imports the modules it uses; avoid circular imports. This follows Typst's documented module/import/include model ([Typst module reference](https://typst.app/docs/reference/foundations/module/)).

## Typst coding conventions

1. **Separate meaning from appearance.** Use semantic components for missions, scored parts, notes, warnings, optional challenges, checklists, and mission figures. Set their visual treatment in shared modules; do not repeat custom `block`, `grid`, font, color, or spacing declarations throughout document content.
2. **Abstract repeated structures, not every sentence.** A component must have a stable semantic or visual contract and at least two likely uses. Ordinary Persian prose stays directly readable in the relevant mission fragment.
3. **Use descriptive kebab-case public helper names.** Required body/title content may be positional; optional behavior uses named arguments such as `points:`, `kind:`, `alt:`, or `image:`. Avoid magic positional booleans and unexplained numeric layout values.
4. **Keep text as Typst content.** Use content blocks for Persian prose and semantic helpers for exact English spans, code, numbers, and math. Keep Java source/output literal; never translate identifiers or required output strings.
5. **Use shared tokens.** Spacing, color, font, padding, and image dimensions come from named theme values. Do not add blank paragraphs, repeated spaces, or local size/color overrides to align content.
6. **Structure a mission by its actual needs.** Use a short narrative setup, a clear task/input/output, scored parts, analysis, and an optional challenge where present. These are available patterns, not mandatory slots: do not invent a story beat, subheading, or challenge just to fill a template.
7. **Keep source order aligned with reading order.** Use explicit imports and includes, one blank source line between paragraphs, and comments only for authoring decisions that are not clear from the source.
8. **Preserve the source of truth.** Edit `.typ` sources and regenerate PDFs; do not patch generated PDFs by hand. Preserve supplied references, scoring, technical constraints, examples, exact outputs, and submission requirements.

## Persian technical-term system

The first mention uses Persian prose plus a footnote containing the canonical English term, for example «بازگشت¹» with `recursion` in its note. Later mentions use «بازگشت» without repeating the English. Where useful, the note may add one short clarifying phrase, but it must not turn into a second paragraph of instruction.

The approved umbrella wording is «ساختارهای دادهٔ آرایه‌ای¹» with the footnote `Array` and `ArrayList`. That grouping is prose only: actual code, method names, types, and API references keep exact spelling in code styling. The approved pair list belongs in `course/terms.typ` and in the authoring guide to prevent drift.

Use Typst's native `footnote` for sequential page-bottom notes and labeled reuse. Tune the note typography once in the theme, then visually check page breaks after introducing notes. Typst places footnotes at the page bottom and supports labels for references ([footnote reference](https://typst.app/docs/reference/model/footnote/)). Do not hand-number notes or use Unicode superscript digits as fake footnotes.

## Per-question editorial workflow

Before changing a question, show a review card containing:

- Learning objective and non-negotiable source requirements, score, examples, inputs/outputs, and constraints.
- Story continuity and tone: formal, inviting, lightly playful, and never jokey at the expense of clarity.
- Task clarity and sequence: what to build/analyze, what information is supplied, and how to recognize the requested output.
- Page structure, reading order, RTL/LTR spans, code/math formatting, and footnote handling.
- A proposed illustration concept and any risk that text/layout could reveal the answer or consume too much page space.
- Concrete proposed edits with a short reason and explicit choices for the user.

Review at the numbered-mission level for the story and illustration, then review each independently scored part/question as its own content unit. For example, Mission 2 has one mission-level image and separate reviews for buoy drawing, ship movement, and analysis. Wait for the user's choice before editing each unit, altering its structure, or generating its mission illustration. Apply only approved changes. After implementation, build and render the affected pages, inspect them visually, and share them with the user. Do not move to the next review unit until the user has reviewed the current result.

Record each mission-level story/image and each independently scored part in `docs/editorial-review.md` with one of these states: `unreviewed`, `proposal`, `approved`, `revised`, `rendered`. Record the user's selected direction and any unresolved ambiguity. Do not mark a question approved merely because the assistant has proposed it.

## Illustration direction

Use one image per numbered mission, placed beside or immediately after that mission's opening story. Mission 2's practical subparts share one scene. Use a shared figure component with a consistent, restrained print size and descriptive alternative text. Use the native Typst figure `alt` parameter for accessibility ([figure reference](https://typst.app/docs/reference/model/figure/)).

Visual system cues from the supplied reference:

- Midnight navy, ocean teal, sea-glass green, beacon gold, warm ivory, and restrained mist/lavender.
- Sculpted miniature 3D forms, rounded modular shapes, tactile ceramic/brass/frosted-glass materials, and soft upper-left light.
- Near-orthographic three-quarter views, one focal point, open space, gentle contrast, and subtle texture.
- A recurring small star/compass or research-vessel motif can link the set. Keep each scene specific to its mission.

Do not include readable text, letterforms, code, numbers, logos, or watermarks inside generated art. Illustrations must be evocative and answer-neutral: they may suggest the context but must not encode the expected program, branch result, sequence values, or success/failure. Preserve the UT seal and the existing academic cover/body design. Use high-resolution raster images generated from the approved reference; store only final assets in `assets/illustrations/hw1/`.

### Mission image briefs

These are starting concepts, not generation approval. Present each brief in that mission's review card and ask the user to approve or adjust it before generation.

| Mission | Subject cue | Avoid revealing |
| --- | --- | --- |
| 1 — Navigation | Research vessel moving within a calm bounded harbor, with wall/buoy shapes and a beacon glint. | Collision count or exact trajectory. |
| 2 — Buoys | Small vessel threading a regular field of buoy markers. | Required grid dimensions, indices, or loop structure. |
| 3 — Satellite | Vessel exchanging light pulses with a distant satellite above dark water. | Request limit, time windows, or which request is accepted. |
| 4 — Biosample | Glass specimen vessels with a subtle branching growth motif. | Fibonacci numbers or the requested term. |
| 5 — Control | Brass-and-glass control console with a forked signal path. | Which boolean branch runs or final variable values. |
| 6 — Arrival | Research vessel approaching a beacon with a nearly depleted fuel gauge. | Whether the vessel arrives or runs out of fuel. |

## Rollout and acceptance

1. After the user approves this design, update the root `AGENTS.md` and authoring/style guide with the conventions, terminology policy, preservation rules, and review gate.
2. Add reusable term, note, challenge, and figure components; keep the public component API small and content-oriented.
3. Split HW1 into the entry point and six mission fragments without changing unapproved mission content.
4. Create `docs/editorial-review.md` and begin with Mission 1's review card. Its image and placement are a pilot; present the render and let the user adjust sizing/placement before generating the remaining images.
5. Repeat the approved review/edit/generate/render/show loop for Missions 2–6.
6. Compile every bundled document, render and inspect each final PDF page, and update `docs/verification.md` and the portable archive.

Completion requires a clean build; the shared helper modules, entry point, and six mission fragments resolve with the bundled Typst/fonts; all six missions and independently scored parts retain their requirements and marks; each illustration has concise alt text and contains no answer cue; all edited pages are visually inspected for RTL/LTR order, footnote placement, collisions, clipping, and unintended page breaks; and the archive rebuild succeeds outside the project directory.

## Decisions left for mission-level review

- Exact wording and story beats for each mission.
- Whether the current image subject cue fits the question; final prompt details and visual focal point.
- Figure size and exact placement, piloted on Mission 1.
- Any individual technical term whose Persian umbrella wording could broaden or narrow the original assignment constraint.
- Any layout change that causes a score, question, or answer space to move to another page.
