# Java Fundamentals Student Handout Design

## Purpose

Create a Persian-first student handout for the first two Java fundamentals units: expressions, primitive types, variables, loops, Boolean logic, control statements, and introductory graphics. The handout should help students connect short rules to visible results through small examples and practice tasks.

The attached Word lab and Keeper's Log are reference material, not controlling instructions. The Word draft contributes its approachable console exercises and student-facing worksheet pattern. The Keeper's Log contributes the Meridian lighthouse setting, battery calculation, animation, harbor board, and checkerboard. Instructor-only keys, facilitator pacing, and embedded submission directions are not part of the new handout unless separately requested.

## Audience and constraints

- Audience: students studying the listed introductory topics; assume they have seen basic Java syntax but are new to these concepts.
- Language: Persian prose, following the course's Persian-first document rules. Keep exact Java identifiers, API names, and expressions in their original spelling.
- Learning boundary: do not teach object-oriented concepts. Supply any Java/ACM program shell as prepared scaffolding. Explain only the listed procedural ideas and the graphics calls students need to recognize and use.
- Level: prefer short, readable examples over the long planted-bug programs in either source. Students should spend their effort predicting, tracing, and changing expressions and control flow.
- Scope: one stand-alone student handout covering both units. It is a learning resource with practice, not a graded assignment; do not invent scores, deadlines, or submission rules.
- Graphics naming: use the correct ACM API spelling `GLabel`; the request's `GLabl` is treated as a typo.

## Selected approach

Use a progressive, lightly themed handout that blends both sources without reproducing either full starter program. A short battery-use exercise introduces types, arithmetic, casting, assignment, and sentinel loops. A compact lighthouse animation demonstrates `GRect`, `GOval`, `GLine`, `GLabel`, `move`, and `pause` using supplied framework scaffolding. A text checkerboard makes nested-loop bounds and parity easy to inspect; a final extension connects the same row/column pattern to a graphics grid. Harbor conditions provide natural examples for relational operators, short-circuit Boolean logic, `if` chains, `switch`, and the ternary operator.

This keeps the strongest examples from both sources while reducing framework setup and accidental dependence on concepts outside the requested scope. The narrative is a quiet “Keeper's log” at Station Meridian, used as context for the examples rather than as a game, competition, or grading system.

## Learning outcomes

After working through the handout, students should be able to:

1. Recognize and choose among Java's eight primitive types: `byte`, `short`, `int`, `long`, `float`, `double`, `char`, and `boolean`.
2. Predict arithmetic results, including integer division, floating-point conversion, remainder, precedence, associativity, and Java's left-to-right operand evaluation.
3. Declare and initialize variables and constants, update values with assignment and shorthand operators, and identify where a local variable is in scope.
4. Trace a count-controlled `for` loop and a sentinel-controlled `while` loop, including their boundaries and update steps.
5. Evaluate comparisons and Boolean expressions, explain short-circuit behavior of `&&` and `||`, and select the appropriate conditional form.
6. Translate a simple `for` loop to an equivalent `while` loop while preserving initialization, condition, and update order.
7. Use nested loops to form a checkerboard and connect its row/column structure to a basic graphics layout.
8. Read and adapt introductory ACM graphics calls for drawing and simple frame-based animation.

## Handout structure

1. **Cover and orientation** — Persian title, concise subtitle, and a short note that examples use prepared Java/ACM scaffolding.
2. **Quick reference: values and expressions** — all eight primitive types with a valid representative value; declaration, initialization, `final`, assignment, shorthand updates, arithmetic operators, integer versus floating-point division, precedence, and evaluation examples.
3. **Unit 1: values, loops, and a working lamp** — trace a small battery calculation; complete a repeat-N example; follow a sentinel loop; then read a short animation frame loop using the provided graphics shell. Include concise predict/trace/try checkpoints.
4. **Quick reference: comparisons and decisions** — comparison and equality operators, Boolean operators, short-circuit evaluation, and compact examples for `if`/`else if`/`else`, ternary, and `switch` with `break` and `default`.
5. **Unit 2: a harbor board** — build a text checkerboard with nested loops, then compare equivalent `for` and `while` forms. Use a small set of harbor-status examples to practice Boolean conditions and branch order. End with an optional mapping from cells to `GRect` calls.
6. **Recap** — a short self-check asking students to explain one arithmetic result, one loop trace, one Boolean decision, and one graphics action in their own words. Do not include a full answer key.

## Topic coverage map

| Requested topic | Handout treatment |
| --- | --- |
| Primitive types | Reference table and tiny declarations for all eight types |
| Arithmetic and semantics | `+`, `-`, `*`, `/`, `%`; integer truncation; casts; precedence, associativity, and operand evaluation |
| Variables and constants | Declaration, initialization, `final`, local scope, assignment |
| Shorthand modifiers | `+=`, `-=`, `*=`, `++`, `--` in loop and total examples |
| Repeat-N / sentinel loops | Count-controlled `for`; input-driven `while` with sentinel update |
| Introductory graphics | `GLabel`, `GRect`, `GOval`, `GLine`, `move`, `pause`, frame loop |
| Relational and equality | `==`, `!=`, `<`, `>`, `<=`, `>=` |
| Boolean logic | `&&`, `||`, `!`; explicit short-circuit example that safely guards a division |
| Branching | `if`, `else if`, `else`, ternary, `switch`, `case`, `break`, `default` |
| `for` / `while` equivalence | Side-by-side equivalent loop forms with state-order tracing |
| Checkerboard | Nested row/column loops, parity expression, dimensions, and optional graphics mapping |

## Editorial and technical decisions

- Use `course-document` from `src/course/theme.typ`, with the shared course typography and layout. The deliverable is a handout, not a workshop note, so do not use the workshop-only reflection ending.
- Place the editable source at `src/documents/java-fundamentals-handout.typ`. Compile it with the documented manual Typst command; do not expand `scripts/build.sh` solely for this one handout.
- Use the shared helpers for Persian prose, English terms, exact code, numbers, and math. Keep code in short blocks and avoid dense full-file listings.
- Show graphics code only inside a provided framework shell or as isolated statements. Identify the graphics API names and the visible effect of each call; do not explain class/object models, inheritance, encapsulation, polymorphism, constructors, or other OOP topics.
- Keep the supplied attachments unmodified at their provided paths. Do not copy the mixed instructor notes or solution material into student-facing or published course files; use only the student-relevant source material in the handout.
- The handout should remain useful in print: examples must be legible in grayscale, tables should be compact, and no essential distinction may rely on color alone.

## Production and review criteria

- Every item in the topic coverage map appears in the student handout at the stated introductory level.
- All code examples are valid Java fragments in the context supplied, use `GLabel` spelling, and avoid asking students to author the surrounding framework structure.
- A student can work through numeric and text-grid examples without access to ACM graphics; the graphics portions are clearly bounded as a separate application of the same fundamentals.
- No instructor key, facilitator-only hint ladder, unpublished answers, grading rubric, or unsupported submission requirement appears in the handout.
- The editable Typst source compiles with the bundled fonts and local package setup. Render and inspect every PDF page for Persian shaping and direction, code characters, clipping, page breaks, table alignment, page numbering, and grayscale clarity.
- Keep the source and generated PDF with the course materials and record the result in `docs/verification.md` after production.

## Out of scope

- Teaching debugging as a full workshop, web research, or AI-assisted programming; those are present in the Keeper's Log but are not required by the requested topic list.
- Reproducing either supplied program verbatim or carrying over its instructor key and facilitator plan.
- Advanced numeric representation, input validation, arrays, custom data structures, or any OOP lesson.
- Changes to the shared Typst theme, course metadata, build script, or package dependencies unless a concrete layout issue makes one necessary.
