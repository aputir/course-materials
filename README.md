# University of Tehran course documents

A Persian-first Typst document system for Advanced Programming. Homework sheets, workshop notes, project phases, and course handouts share one visual style. HW1 is migrated from the supplied Word/PDF references.

## Start here

- Finished homework: `output/pdf/hw1.pdf`
- Editable homework: `src/documents/hw1.typ`
- Session 1 workshop note (۱۵ مهر): `output/pdf/workshop-01.pdf`
- Editable session 1 note: `src/documents/workshop-01.typ`
- Starter documents: `src/templates/`
- Course metadata: `src/course/config.typ`
- Single master theme, layout, typography, and components: `src/course/theme.typ`
- Pinned local bilingual Typst package: `packages/local/dorost/0.2.1/`
- Shared workshop quote, image, story, and prompt content: `src/course/workshop-reflection.typ`
- Mixed Persian/English/math examples: `src/examples/typography.typ`
- Slide starter and layout showcase: `src/templates/slides.typ`
- Design rationale and limitations: `docs/technical-decisions.md`
- Rendering and portability checks: `docs/verification.md`
- Publishing rules and researched references: `docs/document-style-guide.md`
- Latest consistency and spacing audit: `docs/template-review.md`
- APUT visual identity, supplied references, and monochrome print adaptation: `docs/brand/README.md`

## Project layout

```text
src/                      Typst sources: course system, documents, examples, templates
resources/assets/         Fonts, licenses, logos, artwork, and provenance
resources/references/     Original supplied course files
packages/                 Pinned local Typst packages used by the build
docs/                     Style, brand, review, decisions, and verification
scripts/                  Build and package commands
output/                   Generated PDFs and the distributable source archive
```

Prerequisites: Typst 0.15.1 and Bash. The local Dorost package is pinned in `packages/`; builds do not need Typst Universe access. Build the documents and presentations:

```sh
./scripts/build.sh
```

Compile one entry:

```sh
./scripts/build.sh hw1
./scripts/build.sh workshop-01
./scripts/build.sh typography
```

The build script accepts `all`, `hw1`, `workshop-01`, `homework`, `workshop-notes`, `project-phase`, `handout`, `typography`, and `slides`. In the maintainer's full local checkout it also accepts `evolution-ai-story`; that source, its narration script, and its artwork are local-only work and are excluded from Git and the source archive. The script works from any directory, loads bundled fonts, ignores system fonts, and writes PDFs to `output/pdf/`. It builds eight portable entries; newly created documents use the manual command below or a new entry in the script. The archive includes eight PDFs. The story's published PDFs remain available as separate release assets.

Refresh the portable source-and-PDF archive after building:

```sh
./scripts/package.sh
```

The repository is [APUT course materials](https://github.com/aputir/course-materials). The lossless 43-page story PDF is approximately 127 MiB, exceeding GitHub's [100 MiB regular-file limit](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github). It is available in the [course-materials release](https://github.com/aputir/course-materials/releases/tag/course-materials-2026-10-07). Its editable source and original images remain in the maintainer's local checkout, excluded from Git and the source archive.

The release also includes `evolution-ai-story-compressed.pdf`, a 22.9 MiB sharing copy. On macOS with Swift installed, generate a separate compressed copy after the Typst build:

```sh
swift scripts/compress-pdf.swift output/pdf/evolution-ai-story.pdf \
  output/pdf/evolution-ai-story-compressed.pdf
```

The compression helper uses macOS Quartz and is optional; it is not part of `build.sh`. Without an output argument it writes a sibling `-compressed.pdf`; it never replaces the source. Keep the original PNG assets and lossless build when preparing a sharing copy.

## Create a document

Run these manual commands from the project root. Copy the appropriate starter to `src/documents/`, replace the example copy, and keep the import at `../course/theme.typ`:

```sh
cp src/templates/workshop-notes.typ src/documents/workshop-02.typ
typst compile --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts \
  src/documents/workshop-02.typ output/pdf/workshop-02.pdf
```

For a live preview that updates when files change:

```sh
typst watch --root . --package-path packages --ignore-system-fonts --font-path resources/assets/fonts \
  src/documents/workshop-02.typ output/pdf/workshop-02.pdf
```

Every entry opens with a dedicated, unnumbered cover. The course, document title, and number take priority. A single 32 mm UT seal anchors the upper right, beside quieter university/faculty text. English course-name translations are omitted. The body starts on the next page with Persian page number ۱. Its running header emphasizes the course and document type/number; affiliation sits in the footer.

Set course-wide information in `src/course/config.typ`. Optional `term` and `instructor` fields default to `none` and disappear from the cover. Set them to content such as `[پاییز ۱۴۰۵]`. A document can supply its own preparers, publication date, and deadline:

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

There is one master theme with focused content starters, rather than separate competing visual templates. Documents use `course-document`; workshops use `course-workshop`; presentations use `course-slides`. The latter two share the same typography/components and adapt their page composition in the theme. Entry files contain content and metadata, without font, type-size, or margin overrides.

Every workshop uses this wrapper, as demonstrated by both `src/documents/workshop-01.typ` and `src/templates/workshop-notes.typ`:

```typst
#show: course-workshop.with(
  title: "جلسهٔ دوم", subtitle: [موضوع جلسه], number: "02",
)
```

The wrapper automatically adds the illustrated cover with a framed English quote in double quotation marks and a dedicated final page with the same quote, a larger illustration, professional English story, and initial/refined prompts. All reflection prose, labels, and quotes use Lora in English LTR flow; exact code identifiers retain JetBrains Mono and math retains its native font. This includes the takeaway and invitation to try both prompts and share the experience with classmates. This is an explicit exception to the Persian-first course prose rule. `src/course/workshop-reflection.typ` is the single content source for those repeated elements. It stores the initial request once; the refined example appends its extra context to that same request. Follow the [workshop reflection editorial brief](docs/brand/workshop-reflection-editorial.md), copy the workshop starter for future sessions, and keep `course-workshop` in the show rule.

For an illustrated non-workshop cover, `course-document` still accepts optional `cover-artwork: cover-vignette(path, quote)`. Workshops get this automatically. The shared theme centers the artwork and its editable Lora quote in a thin frame in the lower cover area.

Use `resource-link(url, [descriptive label], detail: [optional context])` inside `resource-links(...)` for a row of clearly clickable resources. Each card has a tinted surface, an underlined blue label, and an external-link arrow; its entire surface is clickable. Keep Persian labels descriptive and isolate a displayed English name or domain with `en`. Ordinary inline links are blue and underlined. The first workshop demonstrates two- and three-resource rows plus a full-width graphics link.

Use `example-columns([right-hand input], [left-hand output])` for paired input/output examples, as in HW1. The theme owns the column proportions and gap; entry files only supply the example content.

PDF author metadata follows `meta.university` and `meta.title`, including ordinary text, bold/emphasis, and line breaks. For a separate publishing credit or nontext metadata content, pass `pdf-author: "نام ناشر"` explicitly. The PDF title follows the document's `title`.

Scores may use Persian or Latin numeric strings; `mission` and `part` normalize displayed digits to Persian. Homework uses `mission(number, title, points)` and `part(title, points: ...)`. Workshop, project, and generic documents use normal Typst headings, tables, `note`, and `checklist`.

The hierarchy is compact and readable: 11 pt body, 16/12/11 pt headings, and smaller supporting labels. `type-scale`, `spacing`, `document-style`, `workshop-style`, and `slide-style` in `src/course/theme.typ` own all roles; change these to adjust the family. Keep headings, labels, notes, and code on those scales rather than adding per-document overrides. The style guide records their purpose. Cover and body share a 21 mm horizontal margin; populated and empty covers use the same title-area anchor.

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

Choose by meaning: an array as a concept is prose; `int[]` as an exact Java type is code. `term` and `en` use Lora for English prose, while Persian uses Vazirmatn. English words and numbers do not receive code panels simply because they use Latin characters. Code uses JetBrains Mono; formulas use the native math font. Warnings and important instructions use `note[هشدار][...]`; individual identifiers inside them keep their code styling. Write ordinary explanatory prose and descriptive names in Persian when a natural equivalent exists. The HW1 vessel is «کاوشگر جاوا». Keep exact APIs, product/library names, and specialist terms students need to recognize.

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

Use native math syntax for equations; do not type formulas as plain text or images. Persian display numbers and labels remain Persian, while code and mathematical values use their native numeric notation. `src/examples/typography.typ` demonstrates punctuation, comparison operators, member access, English wrapping, subscripts, interval notation, cases, and multiline Java.

## Create slides

Copy `src/templates/slides.typ` to `src/documents/` and replace the demonstration copy. It shows eight pages using seven layouts: cover, dark section divider, open content shell, two columns, image with text, statement, and image only. The shell is also demonstrated with code. All layout and typography come from `src/course/theme.typ`, using the same fonts, colors, metadata, and inline helpers as the documents.

```sh
./scripts/build.sh slides
```

The optional `evolution-ai-story` selector works only in the maintainer's local checkout, which contains its ignored source and images.

Slides use a 16:9 canvas (960 × 540 pt). The cover contains one UT seal and no running header, footer, or number. Content layouts have quiet course/section headers and a Persian slide number in the footer. A dedicated slide counter starts at ۱ after the cover; image slides count in a mixed deck but display no furniture.

```typst
#import "../course/theme.typ": *
#show: course-slides.with(title: "عنوان ارائه")

#slide-cover([عنوان ارائه], subtitle: [موضوع جلسه])
#slide-shell([عنوان اسلاید], section: [موضوع])[
  توضیح کوتاه با نام #en[Java] و شناسهٔ #code-inline("ArrayList").
]
#slide-image("../../resources/assets/illustrations/workshop-01-shared-light-print.png")
```

Additional helpers are `slide-section(title, number: ..., subtitle: ...)`, `slide-columns(title, right-body, left-body)`, `slide-image-text(title, path, body)`, and `slide-statement(body, attribution: ...)`. Pass `meta` to branded layouts when overriding `course-info`. Content layouts accept `source` for an optional footer credit. Titles and prose follow the same Persian-first conventions as the documents.

`slide-image` shows the complete source with `fit: "contain"` by default. Use `fit: "cover"` only when cropping is intended; `background` controls any empty space. Image pages have no additional text, logo, header, footer, or number. Keep prose brief and break long code lines manually; these fixed slides do not shrink text to fit. Recompile and review after editing.

## Assets and reference copies

Fonts and the UT logo are local, so compilation requires no network or system font installation. The Engineering mark is retained only as an unused reference asset. Sources and licenses are recorded in `resources/assets/SOURCES.md`. The original Word/PDF copies are in `resources/references/HW1/`. Their filenames say `Homework 0x04`, but their title and submission name identify HW1. The current homework cover title is «تمرین اول».

Lora Regular/Bold/Italic/BoldItalic is bundled alongside Vazirmatn and JetBrains Mono, with its OFL license. All editable English text receives Lora through the common theme. Text already drawn into the supplied image-only story artwork remains part of the original images. `scripts/build.sh` has one registry of selectors, source paths, and output names, used for both individual and `all` builds.

The supplied root `brand/` folder is now organized as `resources/assets/brand/reference/visual-system-direction-01.jpg` and `docs/brand/references/direction-01-source.txt`, with both originals preserved. `docs/brand/README.md` documents its motifs, palette, and print adaptation; the finished workshop sketch is in `resources/assets/illustrations/`, with its generation prompts in `docs/brand/workshop-01-artwork.md`.

The editable starter copy is instructional and should be replaced before distribution. The migrated homework PDF contains the actual source assignment.
