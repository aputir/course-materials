# Template unification implementation plan

> **For agentic workers:** Execute the approved user request inline. Document production uses compiler, font inspection, source fidelity checks, and rendered-page review; do not add automated tests.

**Goal:** Strengthen the shared course theme, use Lora for English prose, and provide one reusable workshop cover and closing reflection.

**Architecture:** `course/theme.typ` owns all visual rules and the workshop wrapper. `course/workshop-reflection.typ` owns the repeated quote, artwork path, Persian story, and two related prompts. Entry files supply their teaching content and metadata; they do not reproduce workshop furniture.

**Tech Stack:** Typst 0.15.1, bundled Vazirmatn/Lora/JetBrains Mono, Poppler.

**Spec:** User request in this chat (2026-10-08); publishing requirements in `docs/document-style-guide.md` and `AGENTS.md`.

## Global constraints

- Keep all assignment requirements, scores, examples, identifiers, and submission rules unchanged.
- Keep one UT seal on each cover; do not render the Engineering mark.
- Keep Persian prose and headings; the shared quote is always English and LTR.
- Keep the existing artwork. English prose uses Lora; exact code uses JetBrains Mono and math uses native math fonts.
- Compile using bundled fonts with system fonts disabled. Review every affected page and update `docs/verification.md`.
- Do not add automated tests, create a worktree, commit, or publish for this document revision.

## Task 1: Shared typography and hierarchy

- [x] Bundle Lora Regular/Bold/Italic/BoldItalic and its OFL license from the pinned upstream commit.
- [x] Add shared English/prose font roles and document type sizes in `course/theme.typ`.
- [x] Consolidate raw/math semantic rules used by documents and slides; tighten heading/paragraph/list gaps modestly.
- [x] Correct unwrapped English proof text and update source/license documentation.

## Task 2: Workshop composition and reflection

- [x] Add `course/workshop-reflection.typ` with one quote, one artwork path, professional Persian story, initial prompt, refined prompt, and takeaway.
- [x] Add framed quote, prompt comparison, closing-page layout, and `course-workshop` wrapper in the theme.
- [x] Make the actual workshop and its starter use that wrapper, with automatic illustrated cover and final reflection page.
- [x] Keep the final-page illustration larger than the cover illustration and the complete reflection on one page.

## Task 3: Production verification and documentation

- [x] Build all editable document entries and the slide template using the bundled fonts.
- [x] Inspect page counts, all six workshop destinations, code/source fidelity, and embedded Lora font roles.
- [x] Render and visually review every changed page, including full-size workshop cover/closing page and bilingual proof.
- [x] Check a metadata-populated workshop cover and a fresh-copy portable build.
- [x] Record discovered gaps, resolved ownership, publishing rules, and verification evidence; run `git diff --check`.

Ruling: Existing sources and prior uncommitted document revisions stay in the user's shared checkout so the follow-up updates the same editable files. No unrelated files or source references are removed.

Completed inline. All nine build entries compiled; all 32 editable-output pages were reviewed. Lora embedding, workshop destinations, unchanged HW1 requirements/examples, raw-extraction character inventories, metadata-populated cover, and fresh-copy outside-directory builds were checked. See `docs/verification.md` for exact evidence.

Final audit refinement: moved HW1 input/output column styling into the shared `example-columns` helper and centralized remaining slide font/spacing roles, including distinct heading levels. The HW1 extraction preserves all nine reviewed page renders.
