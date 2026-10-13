# Debugging, Search & AI Handout — Design Spec

**Date:** 2026-10-13  
**Type:** Student Handout (`راهنمای درس`)  
**Working title:** `اشکال‌زدایی، جستجو و هوش مصنوعی`  
**Subtitle:** `چگونه با خطاها روبه‌رو شویم`  
**File:** `src/documents/debugging-ai-handout.typ`  
**Output:** `output/pdf/debugging-ai-handout.pdf`

---

## Purpose

Create a Persian-first student handout that teaches four connected skills — reading compiler and runtime errors, understanding logic bugs, writing effective search queries, and using AI assistants well — through a single, clear narrative flow. The document is a mental model primer: students read it *before* they start writing programs in earnest, so they arrive with a vocabulary for what goes wrong and a protocol for fixing it.

The handout covers topics from Weeks 1–3 (expressions, loops, Boolean logic, basic graphics) as the source of all code examples. It does not introduce any concept beyond that scope — no classes, no OOP, no advanced data structures.

---

## Audience & Constraints

- **Audience:** First-year Advanced Programming students who have seen basic Java syntax (Weeks 1–3) and are about to encounter their first real bugs.
- **Language:** Persian prose, Persian-first rule. All exact Java identifiers, error messages, and search/AI examples remain in English. Use the shared semantic helpers (`en`, `term`, `code-inline`, `code-block`, `note`, `latin-number`).
- **OOP boundary:** No classes, no object-oriented explanations. Any ACM graphics shell is presented as given scaffolding; focus on what the student reads and types, not how the framework is structured.
- **Level:** Short, sharp snippets. Students should recognize the shape of an error before they know the full theory behind it.
- **Print-friendly:** All distinctions remain legible in grayscale. No essential meaning encoded only in color.
- **Copiable code:** Every code snippet should be self-contained and concise enough to copy into a file. Where the full context requires more than ~20 lines, supply a GitHub link placeholder (e.g., `resource-link` pointing to the course repo snippet).

---

## Document Format

Use `course-document` from `src/course/theme.typ`. No workshop reflection ending (this is a handout, not a `course-workshop`).

### New Typst Components Needed (add to theme.typ)

The user asked that reusable visual patterns be defined as theme components so they can be used in future documents. Add the following to `src/course/theme.typ`:

#### 1. `terminal-block(value)` — Error output panel

A dark-background code panel that reads like a terminal. Used exclusively for compiler/runtime error messages and raw program output. Distinguished from `code-block` (pale blue left-border, source code) by its dark fill and monospace text.

**Important:** Do not use `raw(value, block: true)` inside this component. The `course-document` wrapper sets a `show raw.where(block: true)` rule that forces a pale blue background on all block-level raw elements. `terminal-block` must bypass `raw` entirely and render the string directly as monospace text. This avoids the styling conflict while keeping the dark fill.

The dark fill (`rgb("1E2A35")`) and light text (`rgb("E2EDF4")`) must remain legible when printed in grayscale — the high contrast ratio satisfies this. Definition suggestion:

```typst
#let terminal-block(value) = block(
  width: 100%, fill: rgb("1E2A35"),
  stroke: (left: 1.5pt + colors.blue),
  inset: (x: spacing.panel-x, y: spacing.panel-y),
  above: spacing.element, below: spacing.element,
  radius: 3pt, breakable: true,
)[
  #set block(above: 0pt, below: 0pt)
  #set text(size: type-scale.code, font: code-font, lang: "en", dir: ltr, fill: rgb("E2EDF4"))
  #set align(left)
  #set par(leading: 4pt, spacing: 0pt)
  #value
]
```

Callers pass a content argument (not a string): `terminal-block[error: incompatible types]` or pre-formatted content with line breaks.

#### 2. `chat-bubble(role, body)` — AI conversation mockup

A two-tone chat bubble pair simulating a student–AI conversation. `role` is either `"user"` or `"ai"`. Used in the AI section to show a realistic prompt/response exchange inline. Visual suggestion:
- `"user"`: pale blue background, right-aligned, navy label "شما:"
- `"ai"`: white background with border, left-aligned, muted label "AI:"

```typst
#let chat-bubble(role, body) = {
  let is-user = role == "user"
  block(
    width: 85%, fill: if is-user { colors.pale } else { colors.white },
    stroke: 0.5pt + colors.rule,
    inset: (x: spacing.panel-x, y: spacing.panel-y),
    radius: 6pt, above: 3pt, below: 3pt,
    breakable: false,
  )[
    #set block(above: 0pt, below: 0pt)
    #text(size: type-scale.small, weight: "bold", fill: if is-user { colors.blue } else { colors.muted })[
      #if is-user { "شما:" } else { "AI:" }
    ]
    #v(spacing.label)
    #body
  ]
}
```

Wrap pairs in:
```typst
#let ai-conversation(..bubbles) = block(
  width: 100%, above: spacing.element, below: spacing.element,
)[
  #for (role, body) in bubbles.pos() {
    if role == "user" { align(right, chat-bubble("user", body)) }
    else { align(left, chat-bubble("ai", body)) }
    v(2pt)
  }
]
```

#### 3. `error-anatomy(error-text, annotations)` — Labeled error diagram

A `terminal-block` with a Persian annotation legend underneath. `annotations` is an array of `(label, meaning)` pairs, rendered as a compact table. This shows students *what each field of an error message means* without cluttering the message itself.

---

## Narrative Approach

**No single overarching story.** Each section uses a fresh, purposeful small example drawn from Weeks 1–3 topics. The examples are:

1. A battery percentage calculation with a type-cast bug (compile error)
2. A sentinel loop that divides by zero (runtime error)
3. A checkerboard loop that prints one row too many (logic error)
4. The same checkerboard used for all search and AI examples (continuity)

This keeps examples varied but small enough to reason about without a story frame.

---

## Document Structure

### Cover & Orientation (1 page)

- Kind: `راهنمای درس`
- Title: `اشکال‌زدایی، جستجو و هوش مصنوعی`
- Subtitle: `چگونه با خطاها روبه‌رو شویم`
- 3–4 sentence orientation paragraph: this handout teaches you to read errors, not to avoid them; errors are the compiler's way of talking to you; the four skills (errors, reading, searching, AI) build on each other.

### Part 1: What Are Bugs and Errors? (2 pages)

**Goal:** Teach the three-category taxonomy; give students a mental model before they see the details.

**Content:**

- Opening paragraph: software errors are not moral failures; they are categorized, readable, fixable.
- Quick reference table: three columns — Type | When does it happen? | Who notices?
  - خطای کامپایلر (Compile Error): before the program runs; the compiler
  - خطای اجرا (Runtime Error): while the program runs; the JVM / operating system
  - خطای منطق (Logic Error): the program runs and finishes but gives the wrong answer; nobody tells you
- One-sentence example for each type (no code yet — just the plain description).
- Micro-checkpoint (**پیش‌بینی**): "A loop that counts to 5 instead of 4 is which type? Why doesn't the compiler catch it?"

### Part 2: Compile Errors — Reading the Compiler's Message (2 pages)

**Goal:** Students learn that a compile error message has anatomy: file, line, error code, message. They learn to look at the *line number first*, not panic at the wall of text.

**Content:**

- A 5-line program with a deliberate type-cast bug (missing cast on `int/int` → `double`). Show the source with `code-block`, then the javac error with `terminal-block`.
- `error-anatomy` callout: label the key parts — filename, line number, error description.
- Explain the most common compile errors students will see in Weeks 1–3:
  - `cannot find symbol` — typo in variable name
  - `incompatible types` — wrong type in assignment
  - `reached end of file while parsing` — missing closing brace
  - `';' expected` — missing semicolon
  - `illegal start of expression` — orphaned keyword or mismatched brackets
- For each: one-line description + a 2-line bad/good code pair using `example-columns`.
- Micro-checkpoint (**ردگیری**): given a 6-line snippet with two errors, identify error type and fix.

### Part 3: Runtime Errors — When the Program Crashes (2 pages)

**Goal:** Students learn what a stack trace looks like and how to extract the signal from it.

**Content:**

- A sentinel `while` loop that reads user input but has `total / count` inside the loop body. When `count = 0` on the first iteration, it crashes.
- Show the source with `code-block`, then the stack trace with `terminal-block`.
- `error-anatomy` callout: label — Exception type, message, file, line number, call chain.
- Cover the three runtime errors they will most likely hit:
  - `ArithmeticException: / by zero`
  - `ArrayIndexOutOfBoundsException` (brief mention only — arrays come later)
  - `NullPointerException` (brief mention only — objects come later)
- Stack trace reading strategy: "Read from the top. The first `at` line that names *your* file is the one to look at first."
- Micro-checkpoint (**پیش‌بینی**): given a stack trace snippet, identify the file and line to fix.

### Part 4: Logic Errors — When the Program Is Wrong but Polite About It (2 pages)

**Goal:** Logic errors are invisible to the compiler and JVM; students must develop the habit of checking output against expectation.

**Content:**

- A nested loop producing a 5×4 checkerboard when 4×4 was intended (off-by-one in loop bound: `row <= rows` instead of `row < rows`). Show expected output vs. actual output side-by-side with `example-columns`.
- Three logic error patterns with names:
  - اشتباه یک‌به‌یک (Off-by-one): wrong loop bound
  - تبدیل نوع دیرهنگام (Late cast): `(double)(a / b)` vs. `(double)a / b`
  - شرط اشتباه (Wrong condition): `&&` vs. `||`, or `>` vs. `>=`
- Debugging strategy: trace method — trace variable values by hand before running the program.
- Micro-checkpoint (**تلاش کنید**): given the checkerboard code with the bug, identify the wrong token and fix it.

### Part 5: How to Search for Errors (2 pages)

**Goal:** Students learn to write a search query that gets useful results, not generic noise.

**Content:**

- Search query formula: `[language] [error name] [what you were doing]`
  - Example: `java ArithmeticException division by zero while loop`
  - Example: `java "cannot find symbol" variable inside for loop`
  - Example: `java int division result is 0 cast to double`
- What to add in quotes (exact error string from the terminal) vs. what to leave unquoted (your context words).
- A mockup of a Google results page (simple text-box using `border-frame` from the Dorost package): show three fake result titles and URLs, label "which one to click first" with a `note`.
- Stack Overflow anatomy (prose only, no screenshot): question title, accepted answer badge, vote count. One sentence on why to check the date on answers — Java idioms change.
- What makes a bad query: pasting the entire stack trace, including your class name, being too vague.
- Quick-reference box: 5 query templates as a `checklist`:
  - `java [خطا] [چه کاری می‌کردید]`
  - `java "exact error message" site:stackoverflow.com`
  - `java [عملگر یا دستور] not working [نتیجهٔ اشتباه]`
  - `java how to [کاری که می‌خواستید انجام دهید]`
  - `java difference between [الف] and [ب]`
- Micro-checkpoint (**پیش‌بینی**): given the off-by-one bug from Part 4, write a good search query.

### Part 6: How AI Can Help (3 pages)

**Goal:** Teach students the full picture — AI is a powerful pair-programmer that requires skill to use well: prompt engineering, context, verification, and knowing when *not* to use it.

**Content:**

#### 6a. What AI can and can't do

Brief prose:
- Can: explain an error message, suggest a fix for a short snippet, explain a concept in plain language, generate a skeleton to start from.
- Can't (reliably): guarantee correctness, know your specific assignment, remember what you said two sessions ago, replace understanding.
- One-sentence pitfall: "AI that hallucinates confidently is more dangerous than no AI."

#### 6b. Prompt anatomy — the template

Show the three-part prompt structure with `prompt-example`:
1. **Context:** What you were trying to do (`"I'm writing a Java while loop that reads integers until -1"`)
2. **Code:** Paste the relevant snippet (not your entire 300-line project)
3. **Problem:** What the error says or what the wrong output is

Template card (use `prompt-example` component):
```
I'm learning Java. I have this code:

[paste snippet, 5–15 lines]

When I run it, I get: [paste error or wrong output]
I expected: [what you wanted]
What's wrong and why?
```

#### 6c. Worked example — full conversation

Use `ai-conversation` to show a real student–AI exchange about the off-by-one checkerboard bug:
- **Student (bad prompt):** "my code doesn't work fix it" + pasted 80 lines
- **AI response (vague):** generic advice, no real fix
- Short note: this prompt is bad — *why?*
- **Student (good prompt):** uses the template; includes the 12-line loop, the wrong output, the expected output
- **AI response (useful):** identifies `row <= rows`, explains the off-by-one, suggests the fix
- One note after: verify the fix yourself before submitting.

#### 6d. Do / Don't reference table

| نکته | درست | اشتباه |
|---|---|---|
| میزان کد | فقط بخش مشکل‌دار | کل پروژه |
| توصیف مشکل | «انتظار داشتم X بگیرم ولی Y گرفتم» | «کار نمی‌کنه» |
| خطا | پیام دقیق خطا را کپی کنید | «ارور می‌ده» |
| راستی‌آزمایی | خودتان اجرا و تست کنید | مستقیم کپی و تحویل |
| زمان استفاده | وقتی مفهوم را می‌دانید ولی گیر کرده‌اید | جایگزین یادگیری |

#### 6e. Workflow decision tree

A numbered list (no diagram to keep it printable):
1. خودتان خطا را بخوانید — آناتومی را یادآوری کنید.
2. تغییر کوچک و دوباره اجرا کنید.
3. اگر حل نشد، جستجو کنید با فرمول بخش ۵.
4. اگر جستجو پاسخ نداد، از AI بخواهید — با قالب بخش ۶ب.
5. اگر هیچ‌کدام کار نکرد، از استاد یا دستیار آموزشی بپرسید.

Micro-checkpoint (**تلاش کنید**): given a fresh runtime error snippet, go through the workflow: what would your search query be? Write a prompt using the template.

### Final Recap (1 page)

Four self-check questions, one per skill, no answer key:
1. سه نوع خطای برنامه‌نویسی را توضیح دهید و بگویید چرا کامپایلر خطای منطق را نمی‌بیند.
2. در پیام خطای کامپایلر، اولین چیزی که باید نگاه کنید کجاست؟
3. برای یافتن دلیل خطای `ArithmeticException` در یک حلقه، چه جستجویی می‌نویسید؟
4. چرا پرامپت «کدم کار نمی‌کنه» مفید نیست؟ با قالب این جزوه یک نمونهٔ بهتر بنویسید.

---

## Topic Coverage Map

| Topic from weeks 1–3 | Where it appears |
|---|---|
| Primitive types & arithmetic | Part 2 compile error (wrong type), Part 3 runtime (division) |
| Integer division / casting | Part 2 bad code example, Part 4 late-cast logic error |
| Variables & scope | Part 2 `cannot find symbol` example |
| for / while loops | Part 3 sentinel while loop, Part 4 nested for loop |
| Boolean logic & conditions | Part 4 wrong-condition logic error pattern |
| Relational operators | Part 4 off-by-one (`<` vs `<=`) |
| Nested loops / checkerboard | Part 4, Part 5, Part 6 (the running example) |

---

## Component Registry Plan

The following new theme components must be defined in `src/course/theme.typ` before the document content is written:

| Component | Purpose | Re-usability |
|---|---|---|
| `terminal-block(value)` | Dark terminal-style error output panel | Any document showing error messages or CLI output |
| `chat-bubble(role, body)` | Single AI chat bubble (user or AI) | Any document with AI conversation examples |
| `ai-conversation(..bubbles)` | Wraps multiple `chat-bubble` items | Any document with AI conversation examples |
| `error-anatomy(error-text, annotations)` | `terminal-block` + annotation legend table | Any document teaching error reading |

---

## Editorial Decisions

- Use `course-document`, not `course-workshop`. No reflection ending.
- The Google / Stack Overflow mockup in Part 5 uses `border-frame` from the Dorost package. It is a simple rectangle with styled text, not a screenshot, so it compiles with bundled fonts.
- The AI conversation in Part 6c uses the `ai-conversation` component defined above. No screenshots.
- All GitHub links use `resource-link` pointing to `https://github.com/aputir/course-materials` (placeholder; path will be `src/examples/debugging/`). Create copiable Java example files at `src/examples/debugging/` alongside the handout.
- Spacing: use extra `v(spacing.element)` between sections within a Part to create the airy feel the user requested. Keep content grouped, separation generous.
- Do not add a document number or deadline — this is a standing reference, not a dated assignment.

---

## Production Criteria

- Every section from the document structure above appears in the Typst source.
- All four new theme components (`terminal-block`, `chat-bubble`, `ai-conversation`, `error-anatomy`) compile without errors and match the visual descriptions above.
- The PDF compiles with `typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/debugging-ai-handout.typ output/pdf/debugging-ai-handout.pdf`
- Review all pages: Persian shaping, code characters, terminal block contrast in grayscale, chat bubble alignment, page breaks between parts.
- Add a dated entry to `docs/verification.md`.

---

## Out of Scope

- Classes, OOP, inheritance, encapsulation.
- Arrays, ArrayLists, custom data structures.
- Input validation beyond what's shown in Weeks 1–3 examples.
- Advanced debugging tools (breakpoints, IDE debugger views) — a future document.
- Automated tests.
- Modifying `scripts/build.sh`.
