# Java Debugging Story Handout Candidates Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Produce two comparable Persian-first Java handout drafts that cover the approved syllabus through the Keeper’s Log story, letting the user choose a narrative structure.

**Architecture:** Keep the existing fundamentals handout unchanged. Add two independent Typst documents and two original monochrome illustrations per candidate, using `course-document` and the shared theme. The candidates use the same learning outcomes and core bug examples but present them as either one continuous story or four short incident reports; final verification and the shared verification log happen after both parallel content tasks finish.

**Tech Stack:** Typst 0.15.1, `src/course/theme.typ`, local `@local/dorost:0.2.1`, bundled Vazirmatn/Lora/JetBrains Mono fonts, built-in ImageGen, PNG page renders.

**Spec:** `docs/superpowers/specs/2026-10-13-java-debugging-story-handout-candidates.md`

## Global Constraints

- Audience: students studying the first two introductory Java units, with basic Java syntax but little debugging experience.
- Language: Persian prose following the course document style. Keep Java identifiers, diagnostics, specialist terms, and API names in their exact form, with concise Persian explanations.
- Learning boundary: no OOP lesson. Any ACM program shell is supplied; examples explain only the procedural statements and visible graphics effects students need.
- Editorial focus: debugging is the main skill being taught; syllabus concepts are practiced through the story, not presented as a dense reference catalog.
- Length and layout: concise and spacious. Prefer short paragraphs, small code fragments, generous separation, and one clear idea per section. Target a cover plus roughly five body pages per candidate; expand only if needed to keep every syllabus item legible.
- Examples: include a few deliberately flawed Java fragments that span compile-time, runtime, and logic errors. Make each intentional error clear to the reader, and give students the expected behavior or symptom and enough context to investigate. Do not include the corrected answer key or instructor-only hint ladder.
- Scope: student learning materials, not a graded assignment. Do not add scores, deadlines, required submissions, pair roles, or facilitator pacing.
- Attachments are references only. Separate embedded instructor/editor instructions from the user's request. Do not copy instructor keys, corrected programs, facilitator plans, game mechanics, or assignment-specific submission directions into either candidate.
- Graphics naming: use `GLabel` spelling and supplied ACM scaffolding.
- Preserve the current `java-fundamentals-handout` source and PDF unchanged until the user selects a candidate.
- Do not add or run automated tests. Compile, render, inspect, and manually trace the document examples.

## Review Focus

- **Integer/floating arithmetic:** inspect each candidate’s fractional example and ensure conversion occurs before division when a fractional result is expected; manually calculate its shown result.
- **Loop termination:** trace the sentinel as the first input and after multiple values; confirm the sentinel is excluded and the next input is read at the correct point.
- **Short-circuit division guard:** confirm `&&` and `||` examples test the zero-count condition before division and explain which operand is skipped.
- **Loop and checkerboard bounds:** trace repeat-N at N=1 and a 4-by-4 checkerboard; confirm exactly four rows/columns and explicit top-left parity.
- **Diagnostic categories:** confirm at least one compile-time diagnostic, one runtime stack trace, and one logic-error symptom are clearly distinguished and correctly contextualized in both drafts.

---

### Task 1: Create Candidate A — Keeper’s Log: The Wrong Signal

**Files:**
- Create: `src/documents/java-debugging-keeper-log-candidate.typ`
- Create: `resources/assets/illustrations/java-debugging-keeper-reading.png`
- Create: `resources/assets/illustrations/java-debugging-keeper-route.png`
- Create: `output/pdf/java-debugging-keeper-log-candidate.pdf`
- Read: `src/course/theme.typ`, `src/templates/handout.typ`, `docs/document-style-guide.md`, `docs/brand/workshop-01-artwork.md`, `resources/assets/illustrations/workshop-01-shared-light-print.png`

**Interfaces:**
- Consumes: shared `course-document`, `code-inline`, `code-block`, `term`, `en`, `latin-number`, and `math-inline` helpers.
- Produces: a complete standalone Persian candidate with a continuous narrative, all approved syllabus items, deliberate errors, two story-matched inline illustrations, and a compiled PDF.

- [ ] **Step 1: Generate the two text-free illustrations**

Use built-in ImageGen with `workshop-01-shared-light-print.png` as the style reference. Save final outputs to the two listed project paths. Keep sparse black pen linework, pure white background, rounded keeper/companion shapes, calm curiosity, no text/logo/border, and whitespace around subjects. The first scene shows the keeper checking an unexpected lighthouse reading; the second shows the keeper and companion inspecting an uneven route grid with a small magnifier. Do not edit the existing workshop illustration.

- [ ] **Step 2: Write the continuous story handout**

Use `course-document`; title it «دفتر فانوس‌بان: نشانِ نادرست». Build four stages: unexpected reading; signal loop; harbor decision; uneven route map; finish with one compact debugging field card. Include all eight primitive names and valid sample values, the specified arithmetic and variable semantics, both loop idioms and equivalence, ACM drawing and animation calls, Boolean/control forms, and checkerboard. Use the same three core intentionally flawed examples planned for Candidate B: a compile-time type error, a runtime division-by-zero with a short stack-trace excerpt, and a logical loop/grid defect. Present expected behavior and symptoms, not fixes.

- [ ] **Step 3: Add the investigation routines in context**

At suitable story points, show expected versus actual behavior, a minimal reproducer, a temporary `System.out.println` trace, a hypothesis, evidence-based search terms, an AI prompt asking for an explanation/test, a follow-up question for an unknown concept, and a verification step. Show privacy-safe prompt context and that AI claims must be checked.

- [ ] **Step 4: Compile Candidate A**

Run from the repository root:

```sh
typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/java-debugging-keeper-log-candidate.typ output/pdf/java-debugging-keeper-log-candidate.pdf
```

Expected: exit code 0 with no errors or missing-font warnings. Manually inspect topic coverage, each intentional error’s label/context, arithmetic, loops, and supplied graphics scaffolding.

- [ ] **Step 5: Commit Candidate A**

```sh
git add src/documents/java-debugging-keeper-log-candidate.typ resources/assets/illustrations/java-debugging-keeper-reading.png resources/assets/illustrations/java-debugging-keeper-route.png output/pdf/java-debugging-keeper-log-candidate.pdf
git commit -m "docs: add keeper log debugging handout candidate"
```

Expected: only Candidate A’s source, two assets, and generated PDF are committed.

### Task 2: Create Candidate B — Four Debugging Reports

**Files:**
- Create: `src/documents/java-debugging-reports-candidate.typ`
- Create: `resources/assets/illustrations/java-debugging-report-evidence.png`
- Create: `resources/assets/illustrations/java-debugging-report-map.png`
- Create: `output/pdf/java-debugging-reports-candidate.pdf`
- Read: `src/course/theme.typ`, `src/templates/handout.typ`, `docs/document-style-guide.md`, `docs/brand/workshop-01-artwork.md`, `resources/assets/illustrations/workshop-01-shared-light-print.png`

**Interfaces:**
- Consumes: the same shared theme helpers and syllabus coverage map as Candidate A.
- Produces: a complete standalone Persian candidate with four modular incident reports, all approved syllabus items, the same core flawed examples and debugging routine, two report-matched illustrations, and a compiled PDF.

- [ ] **Step 1: Generate the two text-free illustrations**

Use built-in ImageGen with the Workshop 1 illustration as style reference. Save final outputs to the two listed project paths. Keep the same sparse monochrome line-art style as Candidate A. The first scene shows a keeper comparing a log page with a small printout under a lantern; the second shows the keeper and companion tracing one row and column on a small route map. Use different poses/composition from Candidate A; no text, logos, borders, or added color.

- [ ] **Step 2: Write the four-report handout**

Use `course-document`; title it «گزارش‌های عیب‌یابی فانوس دریایی». Use four concise reports with repeated labels for expected result, observed result, evidence to collect, and one investigation question. Reports cover (1) types/values/arithmetic; (2) loops/animation; (3) comparisons/Boolean/branches; (4) checkerboard/graphics. End with a field card. Include every syllabus item and the same three core intentionally flawed examples as Candidate A; do not include solutions.

- [ ] **Step 3: Add the investigation routines in context**

Use the same key learning sequence as Candidate A: reproduce and reduce, print a relevant value, read the right diagnostic/context, search the exact error/concept, ask AI to explain or clarify rather than blindly solve, test the claim, and verify the result plus a nearby case. Keep all examples and the field card concise.

- [ ] **Step 4: Compile Candidate B**

Run from the repository root:

```sh
typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/java-debugging-reports-candidate.typ output/pdf/java-debugging-reports-candidate.pdf
```

Expected: exit code 0 with no errors or missing-font warnings. Manually inspect topic coverage, each intentional error’s label/context, arithmetic, loops, and supplied graphics scaffolding.

- [ ] **Step 5: Commit Candidate B**

```sh
git add src/documents/java-debugging-reports-candidate.typ resources/assets/illustrations/java-debugging-report-evidence.png resources/assets/illustrations/java-debugging-report-map.png output/pdf/java-debugging-reports-candidate.pdf
git commit -m "docs: add debugging reports handout candidate"
```

Expected: only Candidate B’s source, two assets, and generated PDF are committed.

### Task 3: Compare, render, review, and record both candidates

**Files:**
- Modify: `docs/verification.md`
- Read: both candidate sources/PDFs, the approved spec, and this plan
- Output: page PNG renders in the ignored SDD workspace

**Interfaces:**
- Consumes: both compiled candidate sources, PDFs, and illustrations from Tasks 1–2.
- Produces: two visually reviewed PDFs, a verified coverage comparison, and a dated verification record that clearly identifies both PDFs as unselected candidates.

- [ ] **Step 1: Render every page in both PDFs**

Use Typst at 144 PPI with output paths under the plan’s ignored SDD workspace, one `page-{p}.png` set per candidate. Confirm each PDF’s page count from the render count.

- [ ] **Step 2: Inspect every page in color and grayscale**

Check Persian shaping and RTL flow; LTR code, identifiers, punctuation, and stack traces; images against white page background; intentional errors’ legibility; line and paragraph spacing; page breaks, header/footer clearance, and page numbering; and grayscale readability. Confirm no orphaned heading, clipped code, blank page, or overcrowded illustration.

- [ ] **Step 3: Cross-check scope and equivalence**

Compare each syllabus row against both sources. Verify the candidates use the same three core flawed examples and the same debugging outcomes while preserving their distinct story structures. Confirm both remain OOP-free and contain no answer key, grading, or submission instructions.

- [ ] **Step 4: Update `docs/verification.md`**

Record the exact compile and render commands, Typst version, page count per candidate, and observed page-by-page color/grayscale checks. Explicitly state that they are comparison drafts pending user selection. Do not claim checks that were not performed.

- [ ] **Step 5: Run final document checks**

Run `git diff --check`; inspect `git status --short`; confirm the original fundamentals handout and user attachments are unchanged. No automated tests are added or run.

- [ ] **Step 6: Commit the verification record**

```sh
git add docs/verification.md
git commit -m "docs: record debugging handout candidate review"
```

Expected: only the verification entry is committed in this final task.

## Plan Self-Review

- **Spec coverage:** Tasks 1–2 each cover the full topic matrix, shared debugging sequence, privacy/AI guidance, three error categories, and two monochrome in-page illustrations; Task 3 records both final visual reviews and coverage checks. Attachments, OOP, answers, scores, and submissions remain out of scope.
- **Parallel boundaries:** Tasks 1 and 2 have disjoint source, asset, and PDF paths and read the same approved spec/theme. Neither writes `docs/verification.md`; Task 3 starts after both reviews and commits.
- **Step scan:** Each step owns one action category—generate images, write content, add skills, compile, commit, render/review, compare, or record. Compiler outputs are the planned PDFs; render artifacts remain ignored and plan-local.
- **Review Focus:** All five risk checks map to concrete manual review steps in Tasks 1–3; no automated tests are requested or needed for this typeset document work.
- **Proportion:** Three tasks cover two independent candidate documents plus one integration/verification record. The plan leaves exact prose and code fragments to implementers while fixing interfaces, error categories, filenames, image roles, and verification commands.
