# Course Document Authoring System Implementation Plan

> Respect each user-review gate; do not batch ahead across approved-question boundaries.

**Goal:** Establish clean Typst authoring conventions, Persian-first technical footnotes, supervised question editing, reusable document components, and six cohesive HW1 illustrations.

**Architecture:** Keep `theme.typ` as the source of design tokens and page setup; place semantic content blocks and approved terminology in small Typst modules. Keep `hw1.typ` as the build entry point and split each numbered mission into a readable content fragment. Review each mission story/image and each scored sub-question with the user before changing content; render each approved unit before continuing.

**Tech Stack:** Typst 0.15.1, bundled Vazirmatn and JetBrains Mono fonts, Poppler `pdftoppm`/`pdfinfo`, ImageGen, shell archive/build scripts.

**Spec:** `docs/design/specs/2026-10-07-course-document-authoring-design.md`

## Global Constraints

- Keep the UT seal and current formal academic document design; apply the attached lighthouse visual system to problem illustrations.
- Write Persian technical terms in Persian and provide the canonical English term in a footnote at first use; later mentions remain Persian.
- Use «ساختارهای دادهٔ آرایه‌ای» for the combined `Array`/`ArrayList` restriction, with both exact API names in its English footnote.
- Generate one answer-neutral illustration per numbered HW1 mission; the mission's subparts share its image.
- Before revising each mission or scored part, present the review card and wait for the user's choice.
- Preserve assignment requirements, scores, examples, inputs/outputs, identifiers, required output strings, and submission instructions.
- Do not add automated tests unless the user asks; verify with Typst builds, PDF text checks, and rendered-page inspection.
- Do not commit implementation edits unless the user asks for another checkpoint.

---

## File map

| Path | Responsibility |
| --- | --- |
| `AGENTS.md` | Durable agent instructions, preservation rules, bilingual terms, and approval gates. |
| `README.md` | Project orientation and entry point to the authoring conventions. |
| `docs/typst-authoring-conventions.md` | Typst source style, component usage, naming, file organization, and examples. |
| `docs/document-style-guide.md` | Human-facing typography, bilingual terminology, illustration, and page-quality standards. |
| `course/theme.typ` | Fonts, colors, spacing tokens, page setup, document metadata, cover, headers, and footers. |
| `course/components.typ` | Mission headings, scored parts, notes, challenges, checklists, and accessible illustration wrappers. |
| `course/terms.typ` | Approved term records and the Persian-plus-English-footnote helper. |
| `examples/typography.typ` | Mixed Persian/English/math/footnote and figure proof. |
| `templates/*.typ` | Future document starters demonstrating the approved components and term syntax. |
| `documents/hw1.typ` | HW1 compilation entry point, imports, cover metadata, document-level sections, and mission order. |
| `documents/hw1/mission-*.typ` | Source for one numbered mission each, in original reading order. |
| `assets/illustrations/hw1/mission-*.png` | Final approved art for the six numbered missions. |
| `docs/editorial-review.md` | Per-mission/per-part status, approved direction, and outstanding decisions. |
| `output/pdf/*.pdf` | Generated, visually verified documents; never hand-edited. |
| `docs/verification.md` | Build, portability, text-preservation, and visual QA record. |

## Task 1: Publish the authoring rules

**Files:**
- Modify: `AGENTS.md`
- Modify: `README.md`
- Create: `docs/typst-authoring-conventions.md`
- Modify: `docs/document-style-guide.md`
- Verify: read back all three files and compare the stated workflow with the approved spec.

- [ ] Add durable agent rules: read the README/style guide first; preserve sourced requirements; use Persian prose and English technical footnotes; review one story/illustration and one scored unit at a time; present suggestions and wait for the user's choice; do not proceed to the next unit until the current render is shown.
- [ ] Add the eight source conventions from the spec to `docs/typst-authoring-conventions.md`, including semantic components, named optional arguments, shared tokens, source/include order, and source-versus-PDF authority.
- [ ] Add the term policy, Array/ArrayList umbrella wording, reusable-component rule, accessible illustration requirements, and mission-review gate to the style guide.
- [ ] Add a concise README link to the authoring conventions and explain the main source/build entry points.
- [ ] Confirm these rules do not imply automatic rewriting, score changes, or copying visible wording from an attached visual reference.

## Task 2: Implement shared Typst term and component modules

**Files:**
- Modify: `course/theme.typ`
- Create: `course/components.typ`
- Create: `course/terms.typ`
- Verify: compile existing HW1/template/proof entry points after imports are migrated.

**Interfaces:**
- `technical-term(key)` returns Persian inline content followed by an English LTR footnote; supported keys include `recursion` and `array-structures`.
- `mission-figure(path, alt, width: illustration-width)` returns a figure with descriptive alternative text and a shared width token.
- `components.typ` exports the existing `mission`, `part`, `note`, and `checklist` helpers and adds only repeated semantic structures required by real documents.
- `components.typ` imports its color, spacing, font, and badge tokens (`colors`, `spacing`, `fa`, `badge`) from `theme.typ`; `terms.typ` imports the English footnote helper (`en`) from `theme.typ`.
- `theme.typ` exports design tokens and page/document setup; it does not import `components.typ` or `terms.typ`, avoiding circular dependencies.

- [ ] Move existing `mission`, `part`, `note`, and `checklist` rendering functions from `theme.typ` into `components.typ` without changing their current rendered appearance.
- [ ] Define `recursion` with Persian label «بازگشت» and English note `recursion` in `terms.typ`.
- [ ] Define `array-structures` with Persian label «ساختارهای دادهٔ آرایه‌ای» and a footnote naming exact `Array` and `ArrayList` APIs.
- [ ] Implement `technical-term(key)` to retrieve the approved pair, typeset the Persian label inline, and put the English note in an LTR context. Keep the helper's use explicit only at the first occurrence in a document.
- [ ] Add a shared illustration-size token and implement `mission-figure(path, alt, width: ...)` using Typst's native figure alternative text.
- [ ] Update current imports in templates, example, and HW1 entry so components and term helpers are available without circular imports.
- [ ] Run `./scripts/build.sh all`; expect all six existing PDFs to compile without warnings. Render `output/pdf/typography-proof.pdf` and inspect footnote direction, placement, and figure alt-data source markup.

## Task 3: Demonstrate the authoring API in templates

**Files:**
- Modify: `examples/typography.typ`
- Modify: `templates/handout.typ`
- Modify: `templates/homework.typ`
- Modify: `templates/project-phase.typ`
- Modify: `templates/workshop-notes.typ`
- Verify: `./scripts/build.sh all` and inspect all starter content pages.

- [ ] Show first-use «بازگشت» with its English footnote in the typography proof, and show `Array`/`ArrayList` grouped under the Persian umbrella wording with its footnote.
- [ ] Keep one example each for Persian prose, exact code/API identifiers, Latin numeric values, math, full English paragraphs, and code blocks; label each example by meaning rather than Latin script alone.
- [ ] Replace redundant English concept glosses in starter prose where an approved Persian term and its footnote already teach the English label.
- [ ] Use only components that a real course document needs; keep the four starters short and readable.
- [ ] Rebuild and inspect the affected pages. Confirm footnotes remain legible and don't force accidental section or page breaks.

## Task 4: Create the editorial ledger and split HW1 source without content edits

**Files:**
- Modify: `documents/hw1.typ`
- Create: `documents/hw1/mission-01-navigation.typ`
- Create: `documents/hw1/mission-02-buoys.typ`
- Create: `documents/hw1/mission-03-satellite.typ`
- Create: `documents/hw1/mission-04-biosample.typ`
- Create: `documents/hw1/mission-05-control.typ`
- Create: `documents/hw1/mission-06-arrival.typ`
- Create: `docs/editorial-review.md`
- Verify: build HW1 and compare extracted text and page order against the pre-split PDF.

- [ ] Keep metadata/import setup, cover, introduction, and delivery/checklist sections in `documents/hw1.typ`; include the six mission fragments in their original order.
- [ ] Move each existing mission, every scored part, and optional challenge verbatim into its corresponding fragment. Do not revise wording or score during this mechanical split.
- [ ] Create ledger rows for each mission-level story/image and each scored sub-question; include the optional challenge as its own review unit.
- [ ] Use states `unreviewed`, `proposal`, `approved`, `revised`, and `rendered`; initialize the six missions and their units as `unreviewed`.
- [ ] Build HW1. Use `pdftotext -raw` to compare assignment wording, points, outputs, filenames, and contacts before/after. Confirm the PDF remains in the same question order; any layout change is visually reviewed, not silently accepted.

## Global opening and mission review tasks

Each unit below starts with a review card and stops for the user's choice. An image is generated only after the user approves its mission-level subject cue. After each approved text change, rebuild and render the affected page(s); show the render and wait before proceeding.

### Task 5: Global opening and notes

**Files:** `documents/hw1.typ`, `docs/editorial-review.md`

- [ ] Present a review card for the cover, opening narrative, and shared notes: audience/purpose, current storyline, hierarchy, spacing/format, first-use terms (`بازگشت`, array structures), and proposed improvements. Ask for the user's choice before rewriting this content.
- [ ] Apply only the approved changes; preserve course/assignment metadata, requirements, scores, and original references. Keep the already-existing page-one rewrite as a draft proposal until this review.
- [ ] Render affected opening pages, show them for review, and wait for the user's response before proceeding to Mission 1.

### Task 6: Mission 1 — navigation

**Files:** `documents/hw1/mission-01-navigation.typ`, `assets/illustrations/hw1/mission-01-navigation.png`, `docs/editorial-review.md`

- [ ] Present the learning goal, exact collision behavior/size/count/speed requirements, current narrative, proposed clarity/story/layout improvements, and image cue (vessel within bounded harbor). Ask for a choice.
- [ ] After approval, update the mission-level story and mission-figure placement; generate answer-neutral art with no collision count, trajectory, text, code, logo, or watermark.
- [ ] Review the practical task independently: retain 600×400 bounds, 40 px oval, initial center, `dx`/`dy`, wall-specific reversals, actual shape size, 10 collisions, and exact `MISSION COMPLETED` output.
- [ ] Review the analysis question independently; preserve its comparison target and request for reasoning.
- [ ] Render the resulting page(s); inspect figure alt description, footnote placement, RTL/LTR order, scores, clipping, and whether the picture hints at an answer. Show the page and wait.

### Task 7: Mission 2 — buoy field

**Files:** `documents/hw1/mission-02-buoys.typ`, `assets/illustrations/hw1/mission-02-buoys.png`, `docs/editorial-review.md`

- [ ] Review the narrative/image cue (vessel threading buoys), then obtain the user's choice before image generation.
- [ ] Review buoy drawing, ship movement, analysis, and optional challenge as four distinct units; preserve all dimensions, counts, scores, movement rules, exact expressions, and challenge conditions.
- [ ] Generate one shared answer-neutral buoy-field image after story/image approval.
- [ ] Render all affected page(s), inspect that both practical parts and analysis still read in their intended sequence, then show and wait.

### Task 8: Mission 3 — satellite relay

**Files:** `documents/hw1/mission-03-satellite.typ`, `assets/illustrations/hw1/mission-03-satellite.png`, `docs/editorial-review.md`

- [ ] Review the story/image cue (vessel exchanging signal pulses with a satellite) and wait for the user's direction.
- [ ] Review the rate-limit practical task and interval/integer-division analysis as separate units; preserve 10-second windows, limit 3, sorted timestamps, sample data, and exact outputs.
- [ ] Generate art without showing request limits, interval labels, sample values, or accepted/blocked outcomes.
- [ ] Render, inspect, show, and wait before proceeding.

### Task 9: Mission 4 — biosample

**Files:** `documents/hw1/mission-04-biosample.typ`, `assets/illustrations/hw1/mission-04-biosample.png`, `docs/editorial-review.md`

- [ ] Review the story/image cue (biological specimen with subtle branching growth); wait for user choice.
- [ ] Review practical and analytical parts separately; preserve the Fibonacci sequence source values, positive `N`, loop requirement, `Array`/recursion restrictions, scores, and explanation request.
- [ ] Generate art without numbers or a displayed Fibonacci sequence.
- [ ] Render, inspect, show, and wait.

### Task 10: Mission 5 — control logic

**Files:** `documents/hw1/mission-05-control.typ`, `assets/illustrations/hw1/mission-05-control.png`, `docs/editorial-review.md`

- [ ] Review the story/image cue (brass/glass control console with a forked signal path); wait for user choice.
- [ ] Review subparts a, b, and c individually. Preserve exact Java code, initial values, operators, output calls, scores, no-execution instruction, and short-circuit reasoning target.
- [ ] Generate an answer-neutral console image that does not communicate branch execution or final values.
- [ ] Render, inspect, show, and wait.

### Task 11: Mission 6 — arrival

**Files:** `documents/hw1/mission-06-arrival.typ`, `assets/illustrations/hw1/mission-06-arrival.png`, `docs/editorial-review.md`

- [ ] Review the story/image cue (vessel nearing a beacon with low fuel); wait for user choice.
- [ ] Review practical and analytical parts separately; preserve inputs, per-step distance/speed/fuel rules, stopping condition, exact output strings, step count, and loop-choice request.
- [ ] Generate art without indicating arrival versus fuel exhaustion.
- [ ] Render, inspect, show, and wait.

## Task 12: Final production and portable package

**Files:**
- Modify: `docs/verification.md`
- Modify: `docs/template-review.md`
- Regenerate: all PDFs in `output/pdf/`
- Regenerate: `output/ut-course-template.zip`
- Verify: package extraction and build from outside the extracted project.

- [ ] Run `./scripts/build.sh all`; require exit code 0 and no warnings.
- [ ] Render and visually inspect every final PDF page for Persian shaping, footnotes, image/text balance, section order, tables, code, page numbers, and clipping. Keep the nine-page HW1 page count only if the approved images and spacing allow it; if it changes, explain and show the changed page boundaries.
- [ ] Confirm all six images have alt text and do not contain answers, unintended text, or marks resembling a logo.
- [ ] Package only the listed course sources, local fonts/licenses, UT asset/provenance, references, documentation, scripts, and six PDFs; omit scratch files and unrelated work.
- [ ] Extract the ZIP into a fresh temporary directory and invoke its build script from outside that directory; verify all six PDFs rebuild using local files.
- [ ] Update the verification record with exact build, page, rendering, and portability results.
