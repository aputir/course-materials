# Java Debugging Story Handout Candidates

## Purpose

Create two comparable Persian-first student handout drafts that teach the full approved Java fundamentals syllabus through a debugging story. Students follow the same practical investigation routine in both drafts: understand the requirement and observed behavior, make a small reproducible case, inspect output and diagnostics, investigate with `System.out.println`, search from the exact error or symptom, ask AI to explain unfamiliar concepts, test a proposed change, and rerun the case.

The two drafts differ in narrative structure so the user can compare them before choosing one for final publication:

- **Candidate A — Keeper’s Log: The Wrong Signal:** one continuous lighthouse story whose bug escalates through readings, signal timing, harbor rules, and a checkerboard route map.
- **Candidate B — Four Debugging Reports:** four short incident reports from the same lighthouse, each using a repeated expected/observed/investigate/verify pattern. The story is lighter and the syllabus sections are easier to scan independently.

Both candidates are drafts for selection, not two separate course requirements. Keep the already-created `java-fundamentals-handout` source and PDF unchanged until the user chooses a candidate.

## Audience and constraints

- Audience: students studying the first two introductory Java units, with basic Java syntax but little debugging experience.
- Language: Persian prose following the course document style. Keep Java identifiers, diagnostics, specialist terms, and API names in their exact form, with concise Persian explanations.
- Learning boundary: no OOP lesson. Any ACM program shell is supplied; examples explain only the procedural statements and visible graphics effects students need.
- Editorial focus: debugging is the main skill being taught; syllabus concepts are practiced through the story, not presented as a dense reference catalog.
- Length and layout: concise and spacious. Prefer short paragraphs, small code fragments, generous separation, and one clear idea per section. Target a cover plus roughly five body pages per candidate; expand only if needed to keep every syllabus item legible.
- Examples: include a few deliberately flawed Java fragments that span compile-time, runtime, and logic errors. Make each intentional error clear to the reader, and give students the expected behavior or symptom and enough context to investigate. Do not include the corrected answer key or instructor-only hint ladder.
- Scope: student learning materials, not a graded assignment. Do not add scores, deadlines, required submissions, pair roles, or facilitator pacing.
- Attachments are references only. Separate embedded instructor/editor instructions from the user's request. Do not copy instructor keys, corrected programs, facilitator plans, game mechanics, or assignment-specific submission directions into either candidate.
- Graphics naming: use `GLabel` spelling and supplied ACM scaffolding.

## Shared learning path

Both candidates use the same four-stage debugging loop:

1. **Understand the situation:** state the requirement, expected result, actual result, and the input or action that reproduces the problem.
2. **Investigate with evidence:** classify a compile-time, runtime, or logic symptom; inspect the first useful diagnostic or stack-trace frame; add a small `System.out.println` trace near the suspected state; state a testable hypothesis; change one thing at a time.
3. **Search and ask:** search with Java plus the exact error or concept, remove private/local details, compare reliable explanations, and test the rule in a tiny example. Give AI the requirement, minimal code, expected/actual behavior, exact error, and current hypothesis. Ask for an explanation, concept clarification, or a test/hint before asking for a full fix. Follow up with requests such as “Explain this term more simply,” “What does this stack-trace line mean?” or “Show a tiny example.” Treat the answer as a claim to check.
4. **Verify and explain:** rerun the reproducer, check related cases, compare expected and actual behavior, and explain why the accepted change works. Keep a short record of evidence, location, hypothesis, change, and verification.

These steps recur in the story but do not become long checklists on every page. The final page condenses them into one reusable debugging card.

## Candidate A — Keeper’s Log: The Wrong Signal

Use one continuous narrative: a keeper investigates a lighthouse system whose readings become inconsistent, signal loop behaves unexpectedly, harbor decision fails, and route map is drawn incorrectly. The story supports the learning sequence without becoming a game or adding scorekeeping.

Suggested content progression:

1. **A reading does not match:** values, all eight primitive types, variables, `final`, scope, assignment and shorthand updates; arithmetic operators, integer division/casting, precedence, associativity, and operand evaluation. A small flawed battery/readout example introduces expected-versus-actual and a print trace.
2. **The signal repeats at the wrong time:** repeat-N `for`, sentinel `while`, `for`/`while` equivalence, loop boundaries, `++`/`--`, and a compact `move`/`pause` animation frame loop. Include a loop or sentinel mistake as an investigation prompt.
3. **The harbor rule crashes or chooses the wrong route:** relational/equality operators, `&&`, `||`, `!`, short-circuit order, `if`/`else if`/`else`, ternary, and `switch`/`case`/`break`/`default`. Include a short diagnostic or stack-trace excerpt and guide students to relevant context.
4. **The route map is uneven:** nested loops, checkerboard parity and bounds, plus a small mapping to `GRect`, `GOval`, `GLine`, and `GLabel`. Include a visual logic bug and a way to inspect row/column values.
5. **Keeper’s closing note:** the compact debugging card; searching with the exact error; prompting AI for a concept explanation and a test; verify a repair and a nearby case.

Use a few small, text-free black-ink Workshop 1 style sketches to mark transitions, not as page backgrounds.

## Candidate B — Four Debugging Reports

Use four modular incident reports from the lighthouse. Each report repeats a small editorial pattern: “what should happen,” “what happened,” “evidence to collect,” and one investigation question. Avoid extra story prose beyond a short framing note and report transitions.

1. **Report 01 — Incorrect reading:** primitive type quick reference, variables/constants/scope/assignment, arithmetic, division/casting, precedence and evaluation; use one wrong-reading code fragment and a `println` trace.
2. **Report 02 — Signal loop:** repeat-N and sentinel loops, loop translation, shorthand updates, frame loop, `move` and `pause`; use one boundary or sentinel defect.
3. **Report 03 — Harbor decision:** comparisons, Boolean operators, short-circuit mechanics, conditional branches, ternary, and switch forms; use a runtime or logic symptom with a small stack trace or diagnostic. Across the reports, include at least one compile-time diagnostic as well.
4. **Report 04 — Broken map:** nested loops, checkerboard, row/column bounds and parity, `GRect`, `GOval`, `GLine`, and `GLabel`; use one visual mismatch and a trace of coordinates.
5. **Field card:** consolidate the investigation, search, AI explanation, and verification routine in a single compact reference.

Use two or three small text-free monochrome sketches as restrained incident markers; retain ample white space.

## Syllabus coverage map — required in both candidates

| Syllabus item | Required treatment |
| --- | --- |
| Primitive types | Name and show concise valid samples for `int`, `double`, `boolean`, `char`, `long`, `float`, `byte`, and `short`; identify `L` and `f` suffixes and single-quoted `char`. Avoid range memorization. |
| Arithmetic | `+`, `-`, `*`, `/`, `%`; integer truncation versus floating-point conversion before division; precedence and associativity separated from left-to-right operand evaluation. |
| Variables and constants | Declaration, initialization, local scope, `final`, assignment, `+=`, `-=`, `*=`, `++`, and `--`. |
| Loop idioms | Exact repeat-N `for`; repeat-until-sentinel `while` with visible update and sentinel exclusion; equivalent `for`/`while` order. |
| Introductory graphics | `GLabel`, `GRect`, `GOval`, `GLine`, `move`, `pause`, and a frame loop within supplied program scaffolding. |
| Comparisons and Boolean logic | `==`, `!=`, `<`, `>`, `<=`, `>=`, `&&`, `||`, `!`; demonstrate short-circuit behavior and safe operand order. |
| Control flow | `if`, `else if`, `else`, `condition ? x : y`, `switch`, `case`, `break`, and `default`. |
| Checkerboard | Nested row/column loops, explicit bounds and top-left parity, text grid, and a concise graphics mapping. |
| Debugging skills | Understand expected and actual behavior; reproduce and reduce; use `System.out.println`; read diagnostics and stack-trace context; search from exact evidence; prompt AI for explanations and concept follow-ups; verify claims and changes. |

## Visual and document design

- Use the shared `course-document` wrapper, not `course-workshop`, so these handouts remain ordinary Persian-first course documents and do not inherit the workshop-only English closing reflection.
- Follow the workshop-1 monochrome adaptation: sparse uneven black pen lines on pure white, rounded friendly silhouettes, calm curiosity, lantern/keeper/companion motifs, and open space. Keep images text-free, small, and between content sections; do not add a cover-only visual at the expense of requested in-page images.
- Generate two or three distinct small illustrations for each candidate, with image placement aiding transitions. Reuse the same visual language, not necessarily the same exact scenes.
- Use shared theme typography/layout and semantic helpers. Do not introduce local page-layout overrides unless the rendered content exposes a concrete issue.
- Maintain grayscale clarity; no essential meaning depends on color or image detail.

## Production artifacts

- Preserve the current approved fundamentals handout as a separate existing artifact.
- Add two clearly named editable Typst sources under `src/documents/` and their PDFs under `output/pdf/`. Names must identify them as candidate A and B, so neither is mistaken for the selected final document.
- Record exact compile commands, Typst version, page count, and page-by-page visual review in `docs/verification.md` after both PDFs are rendered.
- Do not alter the attachments, shared theme, build registry, or course infrastructure unless a concrete issue requires it.

## Review criteria

- Every item in the syllabus coverage map appears in both student handouts.
- The story paths are distinct enough to compare while maintaining equivalent learning outcomes, core examples, and visual tone.
- Each code fragment is a valid Java fragment aside from clearly intentional marked errors; include at least one compiler diagnostic, one runtime stack trace, and one logic-error symptom across the set. Students are told the symptom/expected behavior, not the fix.
- The document teaches a sound debugging process. `System.out.println` is used as temporary evidence collection, not as a substitute for reading diagnostics, forming a hypothesis, or testing.
- Stack-trace guidance distinguishes the exception message from source location/context and points students to the first relevant frame in their own code; compiler diagnostics are not mislabeled as stack traces.
- Web and AI use is critical and privacy-aware: remove names, local paths, tokens, and private data; compare explanations; do not assume AI output is correct; verify with small tests.
- The examples remain introductory and OOP-free. Graphics framework structure is supplied.
- Both PDFs are compiled with the bundled fonts and local package. Render and inspect every page for Persian/LTR flow, code readability, intentional errors being visible, image fit, spacing, page breaks, footer clearance, and grayscale legibility.
- No instructor answer key, grading rule, submission requirement, or facilitator-only note is added.

## Out of scope

- Reproducing the attached lab or Keeper’s Log verbatim.
- A full debugging course, advanced debugger/IDE tutorials, stack-trace internals, or advanced Java topics.
- Teaching OOP, arrays, collections, exceptions as a formal unit, or how to build the ACM framework.
- A scored assignment, hidden answer key, instructor guide, or assessment rubric.
- Choosing or publishing one candidate as the final course document before the user compares them.
