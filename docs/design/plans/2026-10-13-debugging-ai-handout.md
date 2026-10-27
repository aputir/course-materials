# Debugging, Search & AI Handout Implementation Plan

> Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a Persian-first student handout teaching error taxonomy, error reading, search queries, and AI-assisted debugging through short Java examples from Weeks 1–3.

**Architecture:** Add four reusable theme components to `src/course/theme.typ` (`terminal-block`, `chat-bubble`, `ai-conversation`, `error-anatomy`), then create one Typst document at `src/documents/debugging-ai-handout.typ` using `course-document`. The document has six parts with micro-checkpoints plus a final recap. Standalone Java snippet files go in `src/examples/debugging/`.

**Tech Stack:** Typst 0.15.1, the course theme, local `@local/dorost:0.2.1`, bundled Vazirmatn/Lora/JetBrains Mono fonts, Poppler rendering tools.

**Spec:** `docs/design/specs/2026-10-13-debugging-ai-handout-design.md`

## Global Constraints

- Persian prose, Persian-first rule. Exact Java identifiers, error messages, search/AI examples stay English.
- No OOP: no classes, constructors, inheritance, encapsulation. ACM graphics shells are given scaffolding.
- All code from Weeks 1–3 only: primitive types, arithmetic, loops, Boolean logic, conditionals, basic ACM graphics.
- `GLabel` spelling (not `GLabl`).
- Print-friendly: grayscale-legible, no essential meaning relies on color alone.
- Use shared helpers: `en`, `term`, `code-inline`, `code-block`, `note`, `latin-number`, `example-columns`, `resource-link`, `prompt-example`.
- Do not modify `scripts/build.sh`. Compile manually.
- No automated tests.

## Review Focus

- `terminal-block` must NOT use `raw(value, block: true)` — the `course-document` show rule for `raw.where(block: true)` would override its dark fill with pale blue. The component renders monospace text directly.
- `border-frame` from Dorost is not imported by the course theme. Either import it in the theme or import it directly in the document source.
- All Java code fragments must be valid in the context described (standalone or inside a provided ACM shell).
- Error messages shown in `terminal-block` must match what `javac` / the JVM actually produce for the given code.
- The off-by-one checkerboard (`row <= rows` instead of `row < rows`) must produce exactly 5 rows when `rows = 4`.
- The division-by-zero sentinel loop must crash on the first iteration when count is zero.
- Generous spacing between sections; use heading levels and `v(spacing.element)` between conceptual units within a Part.

---

### Task 1: Add four reusable theme components

**Files:**
- Modify: `src/course/theme.typ`

**Interfaces:**
- Consumes: existing `colors`, `spacing`, `type-scale`, `code-font` dictionaries/values in the theme.
- Produces: four exported functions — `terminal-block(body)`, `chat-bubble(role, body)`, `ai-conversation(..bubbles)`, `error-anatomy(body, annotations)` — available to any document that imports the theme with `*`.

- [x] **Step 1: Add `terminal-block` after the existing `note` function (around line 169)**

Add immediately after the `checklist` function (line 173). This goes before `course-cover`:

```typst
#let terminal-block(body) = block(
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
  #body
]
```

Do NOT use `raw()` inside this function. The `course-document` wrapper's `show raw.where(block: true)` rule would override the dark fill with the standard pale blue panel.

- [x] **Step 2: Add `chat-bubble` and `ai-conversation` after `terminal-block`**

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
      #if is-user [شما:] else [AI:]
    ]
    #v(spacing.label)
    #body
  ]
}

#let ai-conversation(..bubbles) = block(
  width: 100%, above: spacing.element, below: spacing.element,
)[
  #for pair in bubbles.pos() {
    let (role, body) = pair
    if role == "user" { align(right, chat-bubble("user", body)) }
    else { align(left, chat-bubble("ai", body)) }
    v(2pt)
  }
]
```

`ai-conversation` takes positional array arguments where each is a `(role, body)` tuple. Usage:
```typst
#ai-conversation(
  ("user", [سلام، کدم کار نمی‌کنه.]),
  ("ai", [لطفاً کد و پیام خطا را بفرستید.]),
)
```

- [x] **Step 3: Add `error-anatomy` after `ai-conversation`**

```typst
#let error-anatomy(body, annotations) = block(
  width: 100%, above: spacing.element, below: spacing.element,
)[
  #terminal-block(body)
  #v(spacing.label)
  #block(width: 100%, fill: colors.pale, inset: (x: spacing.panel-x, y: spacing.panel-y), radius: 3pt, stroke: 0.5pt + colors.rule)[
    #set block(above: 0pt, below: 0pt)
    #set text(size: type-scale.small)
    #text(weight: "bold", fill: colors.blue)[آناتومی پیام خطا]
    #v(spacing.label)
    #for (label, meaning) in annotations [
      #text(font: code-font, lang: "en", dir: ltr, size: type-scale.small)[#label]
      #h(6pt) #sym.arrow.l #h(6pt)
      #meaning
      #linebreak()
    ]
  ]
]
```

Usage:
```typst
#error-anatomy([
  BatteryCalc.java:4: error: incompatible types
], (
  ("BatteryCalc.java:4", [نام فایل و شمارهٔ خط]),
  ("error: incompatible types", [توصیف خطا از کامپایلر]),
))
```

- [x] **Step 4: Import `border-frame` from Dorost in the theme**

Add `border-frame` to the existing Dorost import on line 3. Change:

```typst
#import "@local/dorost:0.2.1": code-inline as dorost-code-inline, ltr as dorost-ltr, math-inline as dorost-math-inline, persian-digits
```

to:

```typst
#import "@local/dorost:0.2.1": code-inline as dorost-code-inline, ltr as dorost-ltr, math-inline as dorost-math-inline, persian-digits, border-frame
```

This makes `border-frame` available to documents that use `#import "../course/theme.typ": *`.

- [x] **Step 5: Compile a smoke test**

Create a minimal temporary file to verify the new components compile:

```sh
cat > /tmp/debug-components-test.typ << 'EOF'
#import "src/course/theme.typ": *
#show: course-document.with(
  kind: "آزمایش", title: "بررسی مؤلفه‌ها", subtitle: [تست],
)
#terminal-block[
  error: cannot find symbol
]
#error-anatomy([
  Test.java:3: error: ';' expected
], (
  ("Test.java:3", [خط سوم]),
  ("';' expected", [نقطه‌ویرگول فراموش شده]),
))
#ai-conversation(
  ("user", [سلام]),
  ("ai", [چطور کمک کنم؟]),
)
#border-frame[مرز]
EOF
typst compile --root / --package-path packages --ignore-system-fonts --font-path resources/assets/fonts /tmp/debug-components-test.typ /tmp/debug-components-test.pdf
```

Expected: Typst exits 0, no errors. Remove the temp files after confirming.

- [x] **Step 6: Commit the theme changes**

Run:
```bash
git add src/course/theme.typ && git commit -m "feat(theme): add terminal-block, chat-bubble, ai-conversation, error-anatomy components

New reusable components for debugging/AI documents:
- terminal-block: dark terminal panel for error output (bypasses raw show rule)
- chat-bubble + ai-conversation: student-AI conversation mockup
- error-anatomy: labeled error message with Persian annotation legend
- Re-export border-frame from Dorost"
```

Expected: theme changes committed. No other files changed.

---

### Task 2: Write Parts 1–2 (taxonomy and compile errors)

**Files:**
- Create: `src/documents/debugging-ai-handout.typ`

**Interfaces:**
- Consumes: `course-document`, `terminal-block`, `error-anatomy`, `code-inline`, `code-block`, `note`, `en`, `term`, `latin-number`, `example-columns`, `border-frame` from the theme (Task 1).
- Produces: a compilable Typst document with cover, orientation, Part 1 (error taxonomy), and Part 2 (compile errors). Parts 3–6 and recap are added in subsequent tasks.

- [ ] **Step 1: Create the document shell, cover, and orientation**

Create `src/documents/debugging-ai-handout.typ`:

```typst
#import "../course/theme.typ": *
#show: course-document.with(
  kind: "راهنمای درس",
  title: "اشکال‌زدایی، جستجو و هوش مصنوعی",
  subtitle: "چگونه با خطاها روبه‌رو شویم",
)

= پیش از شروع

خطا بخشی طبیعی از برنامه‌نویسی است. هدف این راهنما آموختن خواندن خطاها، نه اجتناب از آن‌هاست. کامپایلر و محیط اجرا با پیام‌های خود سعی دارند مشکل را توضیح دهند. این راهنما چهار مهارت پیوسته را دنبال می‌کند: شناختن انواع خطا، خواندن پیام خطا، جستجوی مؤثر و بهره‌گیری هوشمندانه از هوش مصنوعی. هر مهارت بر مهارت قبلی بنا شده است.
```

- [ ] **Step 2: Add Part 1 — error taxonomy table and overview**

Append after orientation:

```typst
= خطاها چیستند؟

برنامه‌نویسی خطا‌داشتن نیست؛ خطاها دسته‌بندی‌شده، خواندنی و قابل‌رفع هستند. سه دستهٔ اصلی وجود دارد:

#table(
  columns: (auto, 1fr, 1fr),
  align: (right, right, right),
  table.header[نوع خطا][کِی رخ می‌دهد؟][چه کسی متوجه می‌شود؟],
  [خطای کامپایلر (#en[Compile Error])], [پیش از اجرای برنامه], [کامپایلر],
  [خطای اجرا (#en[Runtime Error])], [در حین اجرای برنامه], [ماشین مجازی جاوا],
  [خطای منطق (#en[Logic Error])], [برنامه اجرا می‌شود ولی نتیجه اشتباه است], [هیچ‌کس — خودتان باید بررسی کنید],
)

مثال ساده: اگر #code-inline("int") بنویسید جایی که #code-inline("double") لازم است، کامپایلر خطا می‌دهد. اگر عددی را بر صفر تقسیم کنید، برنامه هنگام اجرا متوقف می‌شود. اگر حلقه‌ای به‌جای #latin-number("4") بار، #latin-number("5") بار تکرار شود، برنامه تا آخر اجرا شده ولی نتیجهٔ اشتباه می‌دهد.

#note[پیش‌بینی][حلقه‌ای که به‌جای #latin-number("4") بار، #latin-number("5") بار اجرا می‌شود، کدام نوع خطاست؟ چرا کامپایلر آن را نمی‌بیند؟]
```

- [ ] **Step 3: Add Part 2 — compile error anatomy and five common errors**

Append after Part 1. This part includes:
1. A 5-line battery program with a type error, shown via `code-block`
2. The javac error message via `error-anatomy`
3. Five common compile errors with `example-columns` showing bad/good pairs

```typst
#pagebreak()

= خطای کامپایلر: خواندن پیام

== آناتومی یک پیام خطا

این برنامه درصد باتری را محاسبه می‌کند. یک خطا دارد — نتیجهٔ تقسیم صحیح به متغیر #code-inline("double") ریخته شده ولی مقدار ورودی نادرست است:

#code-block("int remaining = 7;
int capacity = 20;
double percent = remaining / capacity * 100;
System.out.println(percent);", lang: "java")

خروجی این کد #code-inline("0.0") است، نه #code-inline("35.0"). اما اگر نوع متغیر را اشتباه بنویسیم:

#code-block("int remaining = 7;
int capacity = 20;
int percent = (double) remaining / capacity * 100;", lang: "java")

#error-anatomy([
  BatteryCalc.java:3: error: incompatible types: possible lossy conversion from double to int\
  #h(2em)int percent = (double) remaining / capacity * 100;\
  #h(2em)#h(14em)^\
  1 error
], (
  ("BatteryCalc.java:3", [نام فایل و شمارهٔ خط — اولین چیزی که نگاه می‌کنید]),
  ("error: incompatible types", [توصیف خطا — کامپایلر انتظار نوع دیگری داشت]),
  ("^", [فلش — محل دقیق مشکل در خط]),
))

#v(spacing.element)

*قانون اول:* همیشه ابتدا شمارهٔ خط را نگاه کنید. سپس فلش (#code-inline("^")) محل دقیق‌تر مشکل را نشان می‌دهد.

== پنج خطای کامپایلر رایج

هر ردیف یک خطای معمول در سه هفتهٔ اول را نشان می‌دهد. سمت راست کد اشتباه و سمت چپ کد درست است.

=== #code-inline("cannot find symbol")
اسم متغیر اشتباه نوشته شده یا متغیر اعلان نشده.
#example-columns(
  code-block("int remaning = 7;
System.out.println(remaining);", lang: "java"),
  code-block("int remaining = 7;
System.out.println(remaining);", lang: "java"),
)

=== #code-inline("incompatible types")
مقداری از نوع اشتباه به متغیر سپرده شده.
#example-columns(
  code-block("int x = 3.14;", lang: "java"),
  code-block("double x = 3.14;", lang: "java"),
)

=== #code-inline("reached end of file while parsing")
آکولاد بسته (#code-inline("}")) فراموش شده.
#example-columns(
  code-block("for (int i = 0; i < 3; i++) {
    System.out.println(i);
", lang: "java"),
  code-block("for (int i = 0; i < 3; i++) {
    System.out.println(i);
}", lang: "java"),
)

=== #code-inline("';' expected")
نقطه‌ویرگول آخر دستور فراموش شده.
#example-columns(
  code-block("int x = 5", lang: "java"),
  code-block("int x = 5;", lang: "java"),
)

=== #code-inline("illegal start of expression")
کلمهٔ کلیدی بی‌جا یا پرانتز نامتناظر.
#example-columns(
  code-block("System.out.println(\"hi\"));", lang: "java"),
  code-block("System.out.println(\"hi\");", lang: "java"),
)

#note[ردگیری][در قطعهٔ زیر دو خطا وجود دارد. نوع هر کدام را مشخص کنید و اصلاح‌شان کنید.

#code-block("int total = 10
double avg = totl / 3;", lang: "java")]
```

- [ ] **Step 4: Compile Parts 1–2**

Run:
```bash
typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/debugging-ai-handout.typ output/pdf/debugging-ai-handout.pdf
```

Expected: Typst exits 0. Inspect that the error-anatomy annotation renders correctly, example-columns show bad/good pairs side by side, and the table in Part 1 has correct Persian/LTR mixing.

- [ ] **Step 5: Commit Parts 1–2**

Run:
```bash
git add src/documents/debugging-ai-handout.typ && git commit -m "docs: add debugging handout Parts 1-2 (taxonomy, compile errors)"
```

---

### Task 3: Write Parts 3–4 (runtime errors and logic errors)

**Files:**
- Modify: `src/documents/debugging-ai-handout.typ`

**Interfaces:**
- Consumes: document shell and Parts 1–2 from Task 2, plus `terminal-block`, `error-anatomy`, `code-block`, `code-inline`, `note`, `example-columns`, `latin-number` from the theme.
- Produces: the document extended with Parts 3 (runtime errors + stack trace anatomy) and 4 (logic errors + tracing strategy).

- [ ] **Step 1: Add Part 3 — runtime errors and stack trace anatomy**

Append after Part 2. Content includes:
1. A sentinel while loop with `total / count` where count starts at 0
2. The stack trace via `error-anatomy`
3. Three common runtime errors (brief)
4. The reading strategy

```typst
#pagebreak()

= خطای اجرا: وقتی برنامه متوقف می‌شود

== تقسیم بر صفر در حلقه

در این مثال، مقدار #code-inline("count") هنوز صفر است ولی تقسیم پیش از افزایش آن انجام می‌شود:

#code-block("int total = 0;
int count = 0;
java.util.Scanner input = new java.util.Scanner(System.in);
int value = input.nextInt();
while (value != -1) {
    int avg = total / count;  // count is still 0!
    total += value;
    count++;
    value = input.nextInt();
}", lang: "java")

برای ورودی #code-inline("5 3 -1")، برنامه در همان دور اول متوقف می‌شود:

#error-anatomy([
  Exception in thread "main" java.lang.ArithmeticException: / by zero\
  #h(2em)at AverageCalc.main(AverageCalc.java:6)
], (
  ("java.lang.ArithmeticException", [نوع استثنا — نام خطا]),
  ("/ by zero", [پیام — چه اتفاقی افتاد]),
  ("AverageCalc.java:6", [فایل و خط — کجا باید نگاه کنید]),
))

#v(spacing.element)

*قانون دوم:* از بالا بخوانید. اولین خط #code-inline("at") که نام *فایل شما* را دارد، همان خطی است که باید اصلاح کنید.

== سه خطای اجرای رایج

- #code-inline("ArithmeticException: / by zero") — تقسیم بر صفر. معمولاً شمارنده‌ای هنوز مقدار نگرفته.
- #code-inline("ArrayIndexOutOfBoundsException") — دسترسی به خانه‌ای خارج از آرایه. #en[(در هفته‌های آینده با آن آشنا می‌شوید.)]
- #code-inline("NullPointerException") — استفاده از متغیری که مقدار ندارد. #en[(در هفته‌های آینده با آن آشنا می‌شوید.)]

#note[پیش‌بینی][در این قطعهٔ خطا، فایل و خط مشکل‌دار کجاست؟

#terminal-block[
  Exception in thread "main" java.lang.ArithmeticException: / by zero\
  #h(2em)at Lighthouse.run(Lighthouse.java:12)\
  #h(2em)at acm.program.Program.start(Program.java:580)
]]
```

- [ ] **Step 2: Add Part 4 — logic errors with off-by-one checkerboard**

Append after Part 3:

```typst
#pagebreak()

= خطای منطق: وقتی برنامه مؤدبانه اشتباه می‌کند

== تخته‌ای با یک سطر اضافه

این حلقه قرار است تختهٔ #latin-number("4") در #latin-number("4") بسازد، اما یک سطر اضافه چاپ می‌کند:

#code-block("int rows = 4;
int cols = 4;
for (int row = 0; row <= rows; row++) {
    for (int col = 0; col < cols; col++) {
        System.out.print((row + col) % 2 == 0 ? \"X \" : \". \");
    }
    System.out.println();
}", lang: "java")

#example-columns(
  [*خروجی مورد انتظار:*
#code-block("X . X .
. X . X
X . X .
. X . X")],
  [*خروجی واقعی:*
#code-block("X . X .
. X . X
X . X .
. X . X
X . X .")],
)

مشکل: #code-inline("row <= rows") به‌جای #code-inline("row < rows"). وقتی #code-inline("rows = 4")، شرط #code-inline("row <= 4") در دور پنجم هم درست است. کامپایلر این خطا را نمی‌بیند — نحو درست است و برنامه تا آخر اجرا می‌شود.

== سه الگوی خطای منطقی

=== اشتباه یک‌به‌یک (#en[Off-by-one])
حد حلقه اشتباه: #code-inline("<") به‌جای #code-inline("<=") یا برعکس. *راه حل:* مقدار شمارنده را در اولین و آخرین دور بررسی کنید.

=== تبدیل نوع دیرهنگام (#en[Late cast])
#example-columns(
  [اشتباه:
#code-block("(double)(7 / 2)  // 3.0", lang: "java")],
  [درست:
#code-block("(double) 7 / 2   // 3.5", lang: "java")],
)
تقسیم صحیح *پیش از* تبدیل انجام شده. تبدیل باید *پیش از* تقسیم بیاید.

=== شرط اشتباه (#en[Wrong condition])
#code-inline("&&") به‌جای #code-inline("||") یا #code-inline(">") به‌جای #code-inline(">="). *راه حل:* حالت مرزی (صفر، یک، آخرین مقدار) را امتحان کنید.

== روش ردگیری

پیش از اجرای برنامه، مقدار متغیرها را قدم‌به‌قدم روی کاغذ بنویسید. برای حلقه، مقدار شمارنده و شرط را در هر دور یادداشت کنید. اگر نتیجهٔ دستی با خروجی برنامه فرق دارد، خطا در همان فاصله است.

#note[تلاش کنید][در تختهٔ بالا، توکن اشتباه را پیدا کنید و اصلاح کنید. سپس خروجی را برای #code-inline("rows = 2") و #code-inline("cols = 3") پیش‌بینی کنید.]
```

- [ ] **Step 3: Compile Parts 1–4**

Run:
```bash
typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/debugging-ai-handout.typ output/pdf/debugging-ai-handout.pdf
```

Expected: Typst exits 0. Verify: stack trace anatomy renders in dark panel, example-columns in Part 4 show expected/actual side by side, page breaks separate each Part cleanly.

- [ ] **Step 4: Commit Parts 3–4**

Run:
```bash
git add src/documents/debugging-ai-handout.typ && git commit -m "docs: add debugging handout Parts 3-4 (runtime errors, logic errors)"
```

---

### Task 4: Write Part 5 (searching for errors) and Part 6 (AI)

**Files:**
- Modify: `src/documents/debugging-ai-handout.typ`

**Interfaces:**
- Consumes: Parts 1–4 from Tasks 2–3, plus `terminal-block`, `chat-bubble`, `ai-conversation`, `error-anatomy`, `note`, `prompt-example`, `border-frame`, `code-inline`, `code-block`, `en`, `latin-number` from the theme.
- Produces: the complete document with all six Parts and the final recap.

- [ ] **Step 1: Add Part 5 — search query formula and templates**

Append after Part 4:

```typst
#pagebreak()

= جستجوی خطا

== فرمول جستجو

وقتی پیام خطا را خواندید و خودتان نتوانستید حلش کنید، جستجو کنید. فرمول ساده:

#note[فرمول جستجو][
  #set text(font: code-font, lang: "en", dir: ltr)
  #set align(left)
  java [error name] [what you were doing]
]

سه نمونه:

- #code-inline("java ArithmeticException division by zero while loop")
- #code-inline("java \"cannot find symbol\" variable inside for loop")
- #code-inline("java int division result is 0 cast to double")

*نکته:* پیام دقیق خطا را در گیومه (#code-inline("\"...\"")) بگذارید تا موتور جستجو دقیقاً همان عبارت را پیدا کند. کلمات توصیفی خودتان را بدون گیومه بنویسید.

#v(spacing.element)

== نتایج جستجو را چگونه بخوانیم؟

#border-frame(title: [نتایج جستجو — نمونه])[
  #set text(size: type-scale.small, lang: "en", dir: ltr)
  #set align(left)
  *1.* #text(fill: colors.blue)[java - ArithmeticException: / by zero - Stack Overflow]\
  #text(fill: rgb("006621"))[stackoverflow.com/questions/...]\
  #linebreak()
  *2.* #text(fill: colors.blue)[How to fix division by zero error in Java - GeeksforGeeks]\
  #text(fill: rgb("006621"))[geeksforgeeks.org/...]\
  #linebreak()
  *3.* #text(fill: colors.blue)[Java ArithmeticException - Baeldung]\
  #text(fill: rgb("006621"))[baeldung.com/java-arithmeticexception]
]

#note[نکته][نتیجهٔ #en[Stack Overflow] معمولاً مفیدتر است چون پرسش و پاسخ مشخص دارد. به تعداد رأی‌ها (#en[votes]) و علامت پاسخ پذیرفته‌شده (#en[accepted answer]) نگاه کنید. تاریخ پاسخ را بررسی کنید — زبان جاوا تغییر می‌کند.]

== چه جستجویی بد است؟

- کل #en[stack trace] را کپی نکنید — خیلی طولانی و مختص پروژهٔ شماست.
- اسم کلاس خودتان (#en[مثلاً] #code-inline("MyHomework")) را در جستجو نگذارید — هیچ‌کس دیگر آن اسم را ندارد.
- فقط «#en[java error]» ننویسید — خیلی کلی است.

== قالب‌های آماده

+ #code-inline("java [خطا] [چه کاری می‌کردید]")
+ #code-inline("java \"exact error message\" site:stackoverflow.com")
+ #code-inline("java [عملگر یا دستور] not working [نتیجهٔ اشتباه]")
+ #code-inline("java how to [کاری که می‌خواستید انجام دهید]")
+ #code-inline("java difference between [الف] and [ب]")

#note[پیش‌بینی][برای خطای یک‌به‌یک تختهٔ بخش قبل، یک جستجوی خوب به انگلیسی بنویسید.]
```

- [ ] **Step 2: Add Part 6a — what AI can and can't do**

Append after Part 5:

```typst
#pagebreak()

= هوش مصنوعی چگونه کمک می‌کند؟

== چه کارهایی می‌تواند و چه کارهایی نمی‌تواند

هوش مصنوعی (#en[مانند ChatGPT, Claude, Gemini]) ابزار قدرتمندی است، ولی مهارت لازم دارد:

*می‌تواند:*
- پیام خطا را توضیح دهد
- برای قطعهٔ کوتاه راه‌حل پیشنهاد کند
- مفهومی را به زبان ساده توضیح دهد
- پوستهٔ اولیهٔ یک برنامه را بسازد

*نمی‌تواند (به‌طور قابل اتکا):*
- صحت کد را تضمین کند
- تمرین شما را بشناسد
- گفت‌وگوی قبلی را دقیق به یاد بیاورد
- جایگزین یادگیری شود

#note[هشدار][هوش مصنوعی که با اطمینان اشتباه می‌گوید، خطرناک‌تر از نبودن هوش مصنوعی است.]
```

- [ ] **Step 3: Add Part 6b — prompt template**

Append:

```typst
#v(spacing.element)

== آناتومی یک پرامپت خوب

هر پرامپت مؤثر سه بخش دارد:

+ *زمینه:* چه کاری می‌کردید
+ *کد:* فقط بخش مشکل‌دار (#latin-number("5") تا #latin-number("15") خط)
+ *مشکل:* پیام خطا یا خروجی اشتباه

#prompt-example[قالب پرامپت][
  #set text(font: english-font, lang: "en", dir: ltr)
  #set align(left)
  I'm learning Java. I have this code:\
  \
  \[paste snippet, 5–15 lines\]\
  \
  When I run it, I get: \[paste error or wrong output\]\
  I expected: \[what you wanted\]\
  What's wrong and why?
]
```

- [ ] **Step 4: Add Part 6c — worked conversation example (bad prompt → good prompt)**

Append:

```typst
#v(spacing.element)

== نمونهٔ عملی: گفت‌وگو با هوش مصنوعی

=== پرامپت بد

#ai-conversation(
  ("user", [
    #set text(font: english-font, lang: "en", dir: ltr)
    #set align(left)
    my code doesn't work fix it \
    \[80 lines of code pasted\]
  ]),
  ("ai", [
    #set text(font: english-font, lang: "en", dir: ltr)
    #set align(left)
    There could be several issues with your code. Make sure your variables are initialized correctly and check your loop conditions. Also verify that you're not dividing by zero anywhere...
  ]),
)

#note[نکته][چرا این پرامپت بد است؟ هشتاد خط کد بدون توضیح مشکل — هوش مصنوعی نمی‌داند کجا نگاه کند و پاسخش کلی و بی‌فایده است.]

=== پرامپت خوب

#ai-conversation(
  ("user", [
    #set text(font: english-font, lang: "en", dir: ltr)
    #set align(left)
    I'm learning Java. I have a nested loop that should print a 4×4 checkerboard, but it prints 5 rows instead of 4. Here's my code:

    ```
    int rows = 4;
    int cols = 4;
    for (int row = 0; row <= rows; row++) {
        for (int col = 0; col < cols; col++) {
            System.out.print((row + col) % 2 == 0 ? "X " : ". ");
        }
        System.out.println();
    }
    ```

    Expected: 4 rows. Actual: 5 rows. What's wrong?
  ]),
  ("ai", [
    #set text(font: english-font, lang: "en", dir: ltr)
    #set align(left)
    The issue is in your outer loop condition. You have `row <= rows` which means the loop runs for `row` values 0, 1, 2, 3, *and* 4 — that's 5 iterations.

    Change `row <= rows` to `row < rows`:

    ```
    for (int row = 0; row < rows; row++)
    ```

    This is called an "off-by-one" error. With `<`, the loop runs for values 0 through 3 (4 iterations). With `<=`, it includes 4 as well (5 iterations).
  ]),
)

#note[نکته][این پاسخ مفید است چون پرامپت دقیق بود: کد کوتاه، مشکل مشخص، انتظار و نتیجه. *اما همیشه پاسخ را خودتان اجرا و بررسی کنید — هوش مصنوعی ممکن است اشتباه کند.*]
```

- [ ] **Step 5: Add Part 6d — do/don't table**

Append:

```typst
#v(spacing.element)

== درست و اشتباه

#table(
  columns: (auto, 1fr, 1fr),
  align: (right, right, right),
  table.header[نکته][درست ✓][اشتباه ✗],
  [میزان کد], [فقط بخش مشکل‌دار (#latin-number("5") تا #latin-number("15") خط)], [کل پروژه],
  [توصیف مشکل], [«انتظار داشتم X بگیرم ولی Y گرفتم»], [«کار نمی‌کنه»],
  [خطا], [پیام دقیق خطا را کپی کنید], [«ارور می‌ده»],
  [راستی‌آزمایی], [خودتان اجرا و تست کنید], [مستقیم کپی و تحویل],
  [زمان استفاده], [وقتی مفهوم را می‌دانید ولی گیر کرده‌اید], [جایگزین یادگیری],
)
```

- [ ] **Step 6: Add Part 6e — workflow decision tree and micro-checkpoint**

Append:

```typst
#v(spacing.element)

== مسیر حل مشکل

وقتی با خطایی روبه‌رو شدید، این مسیر را دنبال کنید:

+ *خودتان خطا را بخوانید* — آناتومی پیام را مرور کنید (بخش ۲ و ۳).
+ *تغییر کوچک و دوباره اجرا* — یک چیز عوض کنید و ببینید خطا تغییر کرد یا نه.
+ *جستجو کنید* — با فرمول بخش ۵ یک جستجوی هدفمند بنویسید.
+ *از هوش مصنوعی بخواهید* — با قالب این بخش یک پرامپت دقیق بسازید.
+ *از استاد یا دستیار آموزشی بپرسید* — اگر هیچ‌کدام جواب نداد.

#note[تلاش کنید][فرض کنید این خطا را دریافت کرده‌اید:

#terminal-block[
  Exception in thread "main" java.lang.ArithmeticException: / by zero\
  #h(2em)at BatteryCalc.main(BatteryCalc.java:5)
]

+ جستجوی مناسب به انگلیسی بنویسید.\
+ با قالب بخش ۶ یک پرامپت بسازید (کد فرضی خودتان را بنویسید).]
```

- [ ] **Step 7: Add the final recap**

Append:

```typst
#pagebreak()

= مرور پایانی

پاسخ هر پرسش را با یک ردگیری کوتاه برای خود توضیح دهید:

+ سه نوع خطای برنامه‌نویسی را توضیح دهید و بگویید چرا کامپایلر خطای منطق را نمی‌بیند.
+ در پیام خطای کامپایلر، اولین چیزی که باید نگاه کنید کجاست؟
+ برای یافتن دلیل خطای #code-inline("ArithmeticException") در یک حلقه، چه جستجویی می‌نویسید؟
+ چرا پرامپت «کدم کار نمی‌کنه» مفید نیست؟ با قالب این جزوه یک نمونهٔ بهتر بنویسید.
```

- [ ] **Step 8: Compile the complete document**

Run:
```bash
typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/debugging-ai-handout.typ output/pdf/debugging-ai-handout.pdf
```

Expected: Typst exits 0. Verify: AI conversation bubbles render with correct alignment (user right, AI left), the do/don't table has three columns, `border-frame` renders the search results mockup, terminal-block maintains dark fill throughout.

- [ ] **Step 9: Commit Parts 5–6 and recap**

Run:
```bash
git add src/documents/debugging-ai-handout.typ && git commit -m "docs: complete debugging handout Parts 5-6 (search, AI) and recap"
```

---

### Task 5: Create standalone example files and add resource links

**Files:**
- Create: `src/examples/debugging/BatteryCalc.java`
- Create: `src/examples/debugging/AverageCalc.java`
- Create: `src/examples/debugging/Checkerboard.java`
- Modify: `src/documents/debugging-ai-handout.typ`

**Interfaces:**
- Consumes: the three code examples already present in the handout Parts 2–4.
- Produces: standalone Java files students can download or copy, plus `resource-link` cards in the handout pointing to them.

- [ ] **Step 1: Create BatteryCalc.java (compile error example)**

Create `src/examples/debugging/BatteryCalc.java`:

```java
// This file intentionally contains a compile error.
// See the debugging handout, Part 2.
class BatteryCalc {
    public static void main(String[] args) {
        int remaining = 7;
        int capacity = 20;
        int percent = (double) remaining / capacity * 100;
        System.out.println(percent);
    }
}
```

- [ ] **Step 2: Create AverageCalc.java (runtime error example)**

Create `src/examples/debugging/AverageCalc.java`:

```java
// This file intentionally contains a runtime error (division by zero).
// See the debugging handout, Part 3.
import java.util.Scanner;

class AverageCalc {
    public static void main(String[] args) {
        int total = 0;
        int count = 0;
        Scanner input = new Scanner(System.in);
        int value = input.nextInt();
        while (value != -1) {
            int avg = total / count;  // count is still 0!
            total += value;
            count++;
            value = input.nextInt();
        }
        System.out.println("Total: " + total);
    }
}
```

- [ ] **Step 3: Create Checkerboard.java (logic error example)**

Create `src/examples/debugging/Checkerboard.java`:

```java
// This file intentionally contains a logic error (off-by-one).
// See the debugging handout, Part 4.
class Checkerboard {
    public static void main(String[] args) {
        int rows = 4;
        int cols = 4;
        for (int row = 0; row <= rows; row++) {
            for (int col = 0; col < cols; col++) {
                System.out.print((row + col) % 2 == 0 ? "X " : ". ");
            }
            System.out.println();
        }
    }
}
```

- [ ] **Step 4: Add resource links to the handout**

Add a resource-links row at the end of the orientation section (after "هر مهارت بر مهارت قبلی بنا شده است."):

```typst
#resource-links(
  resource-link(
    "https://github.com/aputir/course-materials/tree/main/src/examples/debugging",
    [فایل‌های نمونهٔ این راهنما],
    detail: [#en[GitHub] · سه برنامهٔ جاوا با خطای عمدی],
  ),
)
```

- [ ] **Step 5: Compile and verify**

Run:
```bash
typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/debugging-ai-handout.typ output/pdf/debugging-ai-handout.pdf
```

Expected: Typst exits 0. The resource-link card appears on the orientation page.

- [ ] **Step 6: Commit example files and link**

Run:
```bash
git add src/examples/debugging/ src/documents/debugging-ai-handout.typ && git commit -m "docs: add standalone Java debugging examples with resource link"
```

---

### Task 6: Render, review, and record the final PDF

**Files:**
- Modify: `docs/verification.md`
- Output: `output/pdf/debugging-ai-handout.pdf`

**Interfaces:**
- Consumes: the complete Typst source from Tasks 2–5 and successful compile.
- Produces: a visually reviewed PDF and a verification entry.

- [ ] **Step 1: Final compile**

Run:
```bash
typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts src/documents/debugging-ai-handout.typ output/pdf/debugging-ai-handout.pdf
```

Expected: exit 0, no errors.

- [ ] **Step 2: Render every page for visual inspection**

Use the available PDF renderer to produce page images at readable resolution. Inspect every page.

- [ ] **Step 3: Review checklist**

Check each item:
- [ ] Persian shaping and direction on every page
- [ ] Code characters render correctly (operators, braces, semicolons)
- [ ] Terminal-block: dark fill visible, text readable, legible in grayscale
- [ ] Chat bubbles: user aligned right, AI aligned left, both legible
- [ ] Error-anatomy annotations: labels match their pointers
- [ ] Example-columns: bad/good pairs side by side, not overlapping
- [ ] Border-frame search mockup: text inside is LTR and readable
- [ ] Tables: three columns, correct headers, no clipping
- [ ] Page breaks: each Part starts cleanly, no stranded headings
- [ ] Page numbering: starts at ۱ on the first body page
- [ ] Cover: correct title, subtitle, no number or deadline

Fix any issues found and recompile.

- [ ] **Step 4: Update verification record**

Add a dated entry to `docs/verification.md` with: exact compile command, Typst version, page count, rendering method, pages reviewed, and observed results.

- [ ] **Step 5: Commit the final PDF and verification**

Run:
```bash
git add output/pdf/debugging-ai-handout.pdf docs/verification.md && git commit -m "docs: publish debugging & AI handout PDF"
```

- [ ] **Step 6: Run final checks**

Run: `git diff --check`

Confirm:
- Source at `src/documents/debugging-ai-handout.typ` present
- PDF at `output/pdf/debugging-ai-handout.pdf` present
- All three Java example files in `src/examples/debugging/` present
- Theme components in `src/course/theme.typ` present
- No unrelated changes in the working tree

---

## Plan Self-Review

- **Spec coverage:** All six document parts (taxonomy, compile errors, runtime errors, logic errors, search, AI), four new theme components, standalone Java files, resource links, verification — all assigned to Tasks 1–6.
- **Placeholder scan:** Every step contains the exact Typst or Java code to write. No "TBD", "implement later", or "similar to Task N".
- **Type/interface consistency:** `terminal-block(body)` takes content, not a string — consistent across all tasks. `ai-conversation` takes `("role", content)` tuples — consistent in definition (Task 1) and usage (Task 4). `error-anatomy(body, annotations)` takes content + array of pairs — consistent in definition and usage. `border-frame` is imported from Dorost in Task 1 Step 4 and used in Task 4 Step 1.
- **Raw show rule conflict:** Explicitly documented and resolved in Task 1 Step 1: `terminal-block` does not use `raw()`.
- **Review focus:** Terminal-block grayscale legibility, chat-bubble alignment, error-anatomy annotation correctness, checkerboard off-by-one producing exactly 5 rows, division-by-zero on first iteration — each has an explicit check in its owning task.
- **Proportion:** Six tasks for theme components + document content + examples + review. Each task produces independently compilable progress.
