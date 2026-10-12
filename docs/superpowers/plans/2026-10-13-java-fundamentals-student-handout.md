# Java Fundamentals Student Handout Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a Persian-first student handout covering the first two Java fundamentals units with approachable examples, practice checkpoints, and no OOP instruction.

**Architecture:** Add one Typst entry under `src/documents/` using the shared `course-document` layout and helpers from `src/course/theme.typ`. Organize it into a values/loops/graphics unit and a Boolean/control/checkerboard unit, then compile, render, review, and record the finished PDF without changing shared theme or build configuration.

**Tech Stack:** Typst 0.15.1, the course theme, local `@local/dorost:0.2.1`, bundled Vazirmatn/Lora/JetBrains Mono fonts, Poppler rendering tools.

**Spec:** `docs/superpowers/specs/2026-10-13-java-fundamentals-student-handout-design.md`

## Global Constraints

- Language: Persian prose, following the course's Persian-first document rules. Keep exact Java identifiers, API names, and expressions in their original spelling.
- Learning boundary: do not teach object-oriented concepts. Supply any Java/ACM program shell as prepared scaffolding. Explain only the listed procedural ideas and the graphics calls students need to recognize and use.
- Level: prefer short, readable examples over the long planted-bug programs in either source. Students should spend their effort predicting, tracing, and changing expressions and control flow.
- Scope: one stand-alone student handout covering both units. It is a learning resource with practice, not a graded assignment; do not invent scores, deadlines, or submission rules.
- Graphics naming: use the correct ACM API spelling `GLabel`; the request's `GLabl` is treated as a typo.
- A student can work through numeric and text-grid examples without access to ACM graphics; the graphics portions are clearly bounded as a separate application of the same fundamentals.
- All code examples are valid Java fragments in the context supplied, use `GLabel` spelling, and avoid asking students to author the surrounding framework structure.
- The handout should remain useful in print: examples must be legible in grayscale, tables should be compact, and no essential distinction may rely on color alone.
- Keep the supplied attachments unmodified at their provided paths. Do not copy the mixed instructor notes or solution material into student-facing or published course files; use only the student-relevant source material in the handout.
- No instructor key, facilitator-only hint ladder, unpublished answers, grading rubric, or unsupported submission requirement appears in the handout.

## Review Focus

- Java integer division must happen only where intended; inspect the arithmetic examples to ensure casting or a floating-point operand occurs before division when fractional output is expected.
- Sentinel input must be excluded from totals and the loop must read/update at the end of each iteration; inspect traces for immediate sentinel and multiple values.
- Counted loops and nested grid loops must produce exactly N iterations in each dimension; inspect boundaries at N=1 and the 4-by-4 board.
- A zero boat count must not reach division in the short-circuit example; inspect operand order and truth conditions for `&&` and `||`.
- Persian and LTR content must remain readable across page breaks; render and inspect every page, especially code, operators, table cells, and page furniture.

---

### Task 1: Create the document shell and Unit 1

**Files:**
- Create: `src/documents/java-fundamentals-handout.typ`
- Read: `src/course/theme.typ`
- Read: `src/templates/handout.typ`

**Interfaces:**
- Consumes: shared `course-document`, `code-inline`, `code-block`, `term`, `latin-number`, and `math-inline` helpers from the theme.
- Produces: a compilable Typst handout source with the approved Persian title/subtitle, orientation, primitive reference, and first-unit material. Unit 2 is added in Task 2.

- [ ] **Step 1: Add the shared document wrapper and cover metadata**

Use `#import "../course/theme.typ": *` and `course-document.with` with kind `راهنمای درس`, title `مبانی برنامه‌سازی در جاوا`, and subtitle `عبارت‌ها، حلقه‌ها، منطق بولی و گرافیک مقدماتی`. Omit an invented document number, date, and author.

- [ ] **Step 2: Add the orientation and the eight-type reference**

State that the Java/ACM shell is supplied scaffolding. Add all eight primitive names with valid sample values (`byte`, `short`, `int`, `long`, `float`, `double`, `char`, `boolean`); identify `L` and `f` suffixes where used and single quotes for `char`. Do not add numeric range memorization or advanced representation details.

- [ ] **Step 3: Add expression and variable examples**

Cover declaration, initialization, `final`, local scope, assignment, `+=`, `-=`, `*=`, `++`, `--`, the five arithmetic operators, integer division, pre-division floating-point conversion, precedence, associativity, and Java's left-to-right operand evaluation. Use separate examples to show that precedence/associativity determine grouping while operand evaluation order determines which expression is evaluated first. Include a short battery percentage trace that contrasts integer and floating-point results.

- [ ] **Step 4: Add the two loop idioms and the lighthouse frame example**

Show a repeat-N `for` loop and a sentinel `while` loop with a visible update at the end. Use a supplied input scaffold rather than explaining an input API. Add a small frame loop demonstrating `move` and `pause`, plus concise `GRect`, `GOval`, `GLine`, and `GLabel` examples inside a provided ACM shell. Show that rectangles/ovals use position and dimensions, lines use endpoints, labels use a baseline point, and drawn graphics are added to the canvas. Explain only each call's visible effect.

- [ ] **Step 5: Compile the Unit 1 draft**

Run: `typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/java-fundamentals-handout.typ output/pdf/java-fundamentals-handout.pdf`

Expected: Typst exits 0 with no errors or missing-font warnings. Manually review each Unit 1 example for Java syntax and the integer/floating-point distinction; trace the sentinel as the first input and after multiple values, confirming it is excluded from the total and each iteration reads the next value.

- [ ] **Step 6: Commit the first unit**

Run: `git add src/documents/java-fundamentals-handout.typ && git commit -m "docs: add Java fundamentals unit one handout"`

Expected: the source and its Unit 1 content are committed; no generated PDF is staged at this draft stage.

### Task 2: Add Boolean logic, control flow, and checkerboard practice

**Files:**
- Modify: `src/documents/java-fundamentals-handout.typ`

**Interfaces:**
- Consumes: the cover, semantic helpers, and Unit 1 material from Task 1.
- Produces: the complete handout covering all requested topics, with a recap and no answer key.

- [ ] **Step 1: Add comparisons and Boolean short-circuit examples**

Cover `==`, `!=`, `<`, `>`, `<=`, `>=`, `&&`, `||`, and `!`. Use separate short-circuit examples for both operators: `boats != 0 && total / boats > limit` and `boats == 0 || total / boats > limit`. Explain which side each operator skips, and why putting the division first or using `&`/`|` would not protect it.

- [ ] **Step 2: Add branching examples**

Use a small harbor-status context for `if`, `else if`, and `else`; show one simple ternary expression; show `switch`, `case`, `break`, and `default`, including the need to stop fall-through.

- [ ] **Step 3: Add equivalent loops and the checkerboard**

Show one `for` loop and its behavior-equivalent `while` translation, with initialization, condition, and update order visible. Add a text checkerboard using nested row/column loops and parity, then an optional small mapping to `GRect` calls. Make dimensions and top-left parity explicit.

- [ ] **Step 4: Add the recap and check topic coverage**

Add a short self-check with no solutions. Compare the handout against every row of the spec's topic coverage map and correct any omission before compiling.

- [ ] **Step 5: Compile the complete handout and inspect content**

Run: `typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/java-fundamentals-handout.typ output/pdf/java-fundamentals-handout.pdf`

Expected: Typst exits 0 with no errors or missing-font warnings. Check code fragments in context for valid Java, verify loop traces at N=1 and 4-by-4, and confirm the sentinel and zero-count cases described in Review Focus.

- [ ] **Step 6: Commit the complete handout source**

Run: `git add src/documents/java-fundamentals-handout.typ && git commit -m "docs: complete Java fundamentals handout"`

Expected: the full editable source, including Unit 2 and recap, is committed.

### Task 3: Render, review, and record the final PDF

**Files:**
- Modify: `docs/verification.md`
- Output: `output/pdf/java-fundamentals-handout.pdf`

**Interfaces:**
- Consumes: the complete Typst source and successful compile from Task 2.
- Produces: a visually reviewed PDF and a concise verification entry documenting the compiler command, page count, and review scope.

- [ ] **Step 1: Render every PDF page for visual inspection**

Use the repository's available PDF renderer to produce page images at a readable resolution. Inspect each page, not only the cover or first content page.

- [ ] **Step 2: Review typography, pagination, code, and grayscale behavior**

Check Persian shaping and direction, Latin identifier direction, operator glyphs, code wrapping, table alignment, page numbering, clipping, headings stranded at page ends, and whether distinctions remain understandable in grayscale. Fix the Typst source and recompile if any issue appears.

- [ ] **Step 3: Update the verification record**

Add a dated entry to `docs/verification.md` with the exact compile command, Typst version, final page count, rendering method, and the pages/aspects reviewed. Record only observed results.

- [ ] **Step 4: Run the final document checks**

Run `git diff --check`. Confirm the source and generated PDF are present, all topic-map rows are covered, no answer key or OOP lesson was introduced, and the working tree contains no unrelated changes.

- [ ] **Step 5: Commit the reviewed PDF and verification record**

Run: `git add output/pdf/java-fundamentals-handout.pdf docs/verification.md && git commit -m "docs: publish Java fundamentals handout PDF"`

Expected: the generated handout PDF and its observed verification record are committed with no unrelated files.

## Plan Self-Review

- **Spec coverage:** Purpose, audience, Persian-first language, no-OOP boundary, all eight primitive types, every listed operator/loop/control form, ACM graphics, checkerboard, no answer key, shared theme usage, editable source, PDF output, grayscale review, and verification logging are assigned to Tasks 1–3.
- **Step scan:** Each step adds one content group or performs one compile/review action. The plan does not add tests or alter shared infrastructure.
- **Type/interface consistency:** One Typst source is used throughout; the approved `course-document` wrapper and helper names match the shared theme.
- **Review focus:** Arithmetic, sentinel termination, loop boundaries, short-circuit division safety, and bilingual PDF layout each have an explicit review check in their owning task.
- **Proportion:** Three tasks cover one source document and its required rendered output; no independent subsystem or build-script change is planned.
