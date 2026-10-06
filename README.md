# University of Tehran course documents

A Persian-first Typst document system for Advanced Programming. Homework sheets, workshop notes, project phases, and course handouts share one visual style. HW1 is migrated from the supplied Word/PDF references.

## Start here

- Finished homework: `output/pdf/hw1.pdf`
- Editable homework: `documents/hw1.typ`
- Starter documents: `templates/`
- Course metadata: `course/config.typ`
- Shared layout and components: `course/theme.typ`
- Mixed Persian/English/math examples: `examples/typography.typ`
- Design rationale and limitations: `docs/technical-decisions.md`
- Rendering and portability checks: `docs/verification.md`
- Publishing rules and researched references: `docs/document-style-guide.md`
- Latest consistency and spacing audit: `docs/template-review.md`

Prerequisite: Typst 0.15.1, which is installed on this machine. The build script requires Bash. Build the six bundled documents:

```sh
./scripts/build.sh
```

Compile one entry:

```sh
./scripts/build.sh hw1
./scripts/build.sh typography
```

The build script accepts `all`, `hw1`, `homework`, `workshop-notes`, `project-phase`, `handout`, and `typography`. It works from any directory, loads the bundled fonts, ignores system fonts, and writes PDFs to `output/pdf/`. It builds this fixed set; newly created documents use the manual command below or a new entry in the script.

## Create a document

Run these manual commands from the project root. Copy the appropriate starter to `documents/`, replace the example copy, and keep the import at `../course/theme.typ`:

```sh
cp templates/workshop-notes.typ documents/workshop-02.typ
typst compile --root . --ignore-system-fonts --font-path assets/fonts \
  documents/workshop-02.typ output/pdf/workshop-02.pdf
```

For a live preview that updates when files change:

```sh
typst watch --root . --ignore-system-fonts --font-path assets/fonts \
  documents/workshop-02.typ output/pdf/workshop-02.pdf
```

Every entry opens with a dedicated, unnumbered cover. The course, document title, and number take priority. A single 32 mm UT seal anchors the upper right, beside quieter university/faculty text. English course-name translations are omitted. The body starts on the next page with Persian page number ۱. Its running header emphasizes the course and document type/number; affiliation sits in the footer.

Set course-wide information in `course/config.typ`. Optional `term` and `instructor` fields default to `none` and disappear from the cover. Set them to content such as `[پاییز ۱۴۰۵]`. A document can supply its own preparers, publication date, and deadline:

```typst
#show: course-document.with(
  kind: "تمرین",
  title: "تمرین دوم",
  subtitle: "موضوع تمرین",
  number: "02",
  prepared-by: [نام تهیه‌کنندگان],
  issued-on: [تاریخ انتشار],
  deadline: [تاریخ و ساعت مصوب],
)
```

`title`, `kind`, and `number` use strings; `subtitle` and optional metadata accept content. Keep cover titles descriptive and concise. Names are not inferred from TA contact handles. `prepared-by`, `issued-on`, and `deadline` are optional and default to `none`. The typography proof shows the full metadata layout using explicitly illustrative labels.

PDF author metadata follows `meta.university` and `meta.title`, including ordinary text, bold/emphasis, and line breaks. For a separate publishing credit or nontext metadata content, pass `pdf-author: "نام ناشر"` explicitly. The PDF title follows the document's `title`.

Scores may use Persian or Latin numeric strings; `mission` and `part` normalize displayed digits to Persian. Homework uses `mission(number, title, points)` and `part(title, points: ...)`. Workshop, project, and generic documents use normal Typst headings, tables, `note`, and `checklist`.

Spacing is intentionally airy. Change the shared `spacing` dictionary in `course/theme.typ` to adjust the whole family. Keep headings, labels, notes, and code on that scale rather than adding per-document gaps. The style guide records the values and their purpose. Cover and body share a 21 mm horizontal margin; populated and empty covers use the same title-area anchor.

## Persian, English, and math

Write Persian prose in ordinary logical reading order. The theme sets Persian language and RTL paragraph direction. Use the following semantic helpers:

| Meaning | Helper | Example |
| --- | --- | --- |
| English proper name or prose phrase | `en` | `#en[Java]` |
| Concept, including a programming concept | `term` | `#term[Recursion]` or `#term[Array]` |
| Exact class/type, variable, method, filename, or expression | `code-inline` | `#code-inline("List<String>")` or `#code-inline("items.get(0)")` |
| Latin number in regular prose | `latin-number` | `#latin-number("0.75")` |
| Program fragment, input/output example, or file tree | `code-block` | A multiline Java listing or literal data |
| Mathematical notation | `math-inline` or native display math | `#math-inline($n >= 0$)` |

Choose by meaning: an array as a concept is prose; `int[]` as an exact Java type is code. `term` and `en` deliberately share the body font. English words and numbers do not receive code panels simply because they use Latin characters. Warnings and important instructions use `note[هشدار][...]`; individual identifiers inside them keep their code styling. Write ordinary explanatory prose and descriptive names in Persian when a natural equivalent exists. The HW1 vessel is «کاوشگر جاوا». Keep exact APIs, product/library names, and specialist terms students need to recognize.

```typst
از کاوشگر جاوا و کلاس #code-inline("GOval") استفاده کنید.
مفهوم #term[Recursion] و مقدار #latin-number("0.75") در همان جمله می‌آیند.
مفهوم تقسیم صحیح (Integer Division) را توضیح دهید.
برای #math-inline($n in NN$)، مقدار #math-inline($F_n$) را بنویسید.

#english[
An English paragraph wraps normally in its own LTR context.
]

#code-block("int window = timestamp / 10;", lang: "java")

$ F_n = F_(n-1) + F_(n-2) $
```

`en`, `term`, `latin-number`, `code-inline`, and `math-inline` create inline objects with their own LTR layout context. Short terms stay together, including their internal parentheses and operators. Keep Persian sentence punctuation outside those spans. Put an English term's own punctuation inside the span. `latin-number` preserves the supplied notation, including decimals and signs; pass a string when formatting such as trailing zeros matters. For a whole English paragraph, use `english` so it can wrap naturally. Long code belongs in `code-block`; break very long source lines at sensible syntax boundaries. Code ligatures and contextual substitutions are disabled so operators show their actual characters.

Use native math syntax for equations; do not type formulas as plain text or images. Persian display numbers and labels remain Persian, while code and mathematical values use their native numeric notation. `examples/typography.typ` demonstrates punctuation, comparison operators, member access, English wrapping, subscripts, interval notation, cases, and multiline Java.

## Assets and reference copies

Fonts and the UT logo are local, so compilation requires no network or system font installation. The Engineering mark is retained only as an unused reference asset. Sources and licenses are recorded in `assets/SOURCES.md`. The original Word/PDF copies are in `references/HW1/`. Their filenames say `Homework 0x04`, but their title and submission name identify HW1. The current homework cover title is «تمرین اول».

The editable starter copy is instructional and should be replaced before distribution. The migrated homework PDF contains the actual source assignment.
