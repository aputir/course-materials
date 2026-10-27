#import "config.typ": course-info
#import "workshop-reflection.typ": workshop-reflection
#import "@local/dorost:0.2.1": code-inline as dorost-code-inline, ltr as dorost-ltr, math-inline as dorost-math-inline, persian-digits, border-frame

#let colors = (
  ink: rgb("162B45"), blue: rgb("0077BD"), muted: rgb("627489"),
  pale: rgb("F0F6FA"), rule: rgb("D7E5EF"), white: white,
)
#let body-font = "Vazirmatn"
#let english-font = "Lora"
// Lora supplies Latin glyphs, including unwrapped prose; Vazirmatn shapes Persian.
#let prose-fonts = (english-font, body-font)
#let code-font = "JetBrains Mono"
#let type-scale = (
  body: 11pt, heading: 16pt, subheading: 12pt, minor-heading: 11pt,
  label: 10pt, small: 9pt, footer: 8pt, code: 9pt,
  cover-course: 19pt, cover-title: 32pt, cover-number: 48pt,
  cover-subtitle: 12pt, quote: 13pt, quote-title: 22pt,
)
#let document-style = (
  margin-x: 21mm, body-top: 24mm, body-bottom: 20mm, cover-y: 25mm,
  furniture-gap: 7mm, logo: 32mm,
)
// Absolute spacing avoids larger gaps merely because a heading uses larger type.
// Typst collapses adjacent block gaps to the larger value, so a heading's "after"
// must exceed the paragraph gap (7pt) to take effect; "before" stays clearly larger
// than "after" so each heading groups with the content it introduces.
#let spacing = (
  line: 6.5pt, paragraph: 7pt, item: 7.5pt,
  section-before: 14pt, section-after: 8pt,
  subsection-before: 12pt, subsection-after: 8pt,
  minor-before: 12pt, minor-after: 8pt,
  element: 6pt, panel-x: 10pt, panel-y: 8pt, label: 4pt,
  cover-brand: 22mm, cover-course: 5mm, cover-subtitle: 4mm,
  cover-rule: 6mm, cover-details: 10mm,
)
#let metadata-text(value) = {
  if type(value) == str { value }
  else if type(value) != content { str(value) }
  else if value.func() == linebreak { " " }
  else if value.has("text") { value.text }
  else if value.has("children") { value.children.map(metadata-text).join("") }
  else if value.has("body") { metadata-text(value.body) }
  else { "" }
}
#let fa = persian-digits

// An inline box has its own bidi context. Use for short terms, not paragraphs.
#let en(body) = box(text(font: english-font, lang: "en")[#dorost-ltr[#body]])
// A concept is prose, even when its name comes from programming.
#let term(body) = en(body)
#let latin-number(value) = en(str(value))
#let english(body) = block(width: 100%, above: spacing.element, below: spacing.element)[
  #set text(font: english-font, lang: "en")
  #set align(left)
  #dorost-ltr[#body]
]
#let code-inline(value) = box(text(font: code-font, lang: "en")[
  #dorost-code-inline(value, font: code-font, size: 0.86em / 0.8)
])
#let code-block(value, lang: "java") = raw(value, block: true, lang: lang)
#let example-columns(right-body, left-body) = grid(
  columns: (1fr, 1fr), gutter: 2 * spacing.element, right-body, left-body,
)
#let math-inline = dorost-math-inline
#let semantic-typography(body) = {
  // Cards own their appearance; ordinary prose links need an explicit cue.
  show link: it => if it.body.func() == block { it } else { text(fill: colors.blue, underline(it)) }
  show math.equation: set text(font: "New Computer Modern Math", lang: "en", dir: ltr)
  show raw: set text(font: code-font, lang: "en", dir: ltr, ligatures: false, features: (calt: 0, liga: 0))
  // Typst raw applies a built-in 0.8em reduction; final inline size is 0.86em.
  show raw.where(block: false): set text(size: 0.86em / 0.8)
  body
}
#let badge(body) = box(fill: colors.white, stroke: 0.6pt + colors.rule, inset: (x: 8pt, y: 4pt), radius: 3pt, text(size: type-scale.small, fill: colors.blue, body))

// Descriptive resource labels stay Persian; addresses have their own LTR context.
#let external-link-mark() = box(width: 9pt, height: 9pt)[
  #place(top + left, line(start: (0pt, 9pt), end: (9pt, 0pt), stroke: 0.8pt + colors.blue))
  #place(top + left, line(start: (4pt, 0pt), end: (9pt, 0pt), stroke: 0.8pt + colors.blue))
  #place(top + left, line(start: (9pt, 0pt), end: (9pt, 5pt), stroke: 0.8pt + colors.blue))
]
#let resource-link(url, label, detail: none) = {
  link(url, block(
    width: 100%, fill: colors.pale, stroke: 0.6pt + colors.rule,
    inset: (x: spacing.panel-x, y: spacing.panel-y), radius: 3pt,
    above: 0pt, below: 0pt, breakable: false,
  )[
    #set par(spacing: 0pt)
    #grid(columns: (1fr, auto), gutter: 6pt,
      text(size: type-scale.label, weight: "bold", fill: colors.blue)[#underline(label)],
      external-link-mark(),
    )
    #if detail != none {
      v(spacing.label)
      text(size: type-scale.small, fill: colors.muted)[#detail]
    }
  ])
}
#let resource-links(..items) = block(width: 100%, above: spacing.element, below: spacing.element)[
  #grid(columns: (1fr,) * items.pos().len(), gutter: 8pt, ..items.pos())
]

#let workshop-style = (
  cover-width: 130mm, cover-height: 72mm,
  closing-width: 158mm, closing-height: 96mm,
  frame-stroke: 0.7pt, frame-radius: 2pt,
)
#let quote-frame(quote, size: type-scale.quote) = block(
  width: 100%, stroke: workshop-style.frame-stroke + colors.ink,
  radius: workshop-style.frame-radius, inset: (x: 12pt, y: 9pt),
  above: 0pt, below: 0pt, breakable: false,
)[
  #set text(font: english-font, size: size, style: "italic", fill: colors.ink, lang: "en", dir: ltr)
  #set align(center)
  #set par(spacing: 0pt)
  “#quote”
]
// Artwork and an editable framed quote form one shared lower-cover group.
#let cover-vignette(path, quote) = align(center, block(width: workshop-style.cover-width, breakable: false)[
  #image(path, width: workshop-style.cover-width, height: workshop-style.cover-height, fit: "contain")
  #v(3mm)
  #quote-frame(quote)
])

#let prompt-example(label, body) = block(
  width: 100%, fill: colors.pale, stroke: (left: 1pt + colors.rule),
  inset: (x: spacing.panel-x, y: spacing.panel-y), radius: 3pt,
  above: spacing.element, below: spacing.element, breakable: false,
)[
  #set block(above: 0pt, below: 0pt)
  #text(size: type-scale.small, weight: "bold", fill: colors.blue)[#label]
  #v(spacing.label)
  #body
]
#let workshop-closing(reflection) = [
  #set text(font: english-font, lang: "en", dir: ltr)
  #set align(left)
  #quote-frame(reflection.quote, size: type-scale.quote-title)
  #v(4mm)
  #align(center, image(reflection.image, width: workshop-style.closing-width,
    height: workshop-style.closing-height, fit: "contain"))
  #v(spacing.element)
  #reflection.story
  #prompt-example(reflection.naive-label, [#reflection.naive#linebreak()#reflection.output-instruction])
  #prompt-example(reflection.refined-label, [#reflection.naive #reflection.refinement#linebreak()#reflection.output-instruction])
  #reflection.takeaway
  #parbreak()
  #reflection.invitation
]

#let mission(number, title, points) = heading(level: 1)[
  #block(width: 100%, fill: colors.pale, stroke: (right: 2pt + colors.blue), radius: 3pt, inset: (x: spacing.panel-x, y: spacing.panel-y), above: 0pt, below: 0pt, breakable: false)[
    #grid(columns: (1fr, auto), gutter: 12pt, align: (right, left),
      [
        #set par(spacing: 0pt)
        #text(size: type-scale.small, fill: colors.blue, weight: "regular")[مأموریت #fa(number)]
        #v(spacing.label)
        #text(size: type-scale.heading, weight: "bold")[#title]
      ],
      badge[#fa(points) نمره],
    )
  ]
]
#let part(title, points: none) = heading(level: 2)[
  #title #if points != none { h(6pt); box(text(size: type-scale.small, weight: "regular", fill: colors.muted)[(#fa(points) نمره)]) }
]
#let note(title, body) = block(width: 100%, fill: colors.pale, inset: (x: spacing.panel-x, y: spacing.panel-y), above: spacing.element, below: spacing.element, radius: 3pt, breakable: true)[
  #block(above: 0pt, below: 0pt, sticky: true)[#text(weight: "bold", fill: colors.blue)[#title]]
  #v(spacing.label)
  #body
]
// Full-width, vertically stacked explanation card with an accent rule on the right.
#let course-card(title, accent, tag: none, body) = block(
  width: 100%, fill: colors.pale, stroke: (right: 3pt + accent), radius: 3pt,
  inset: (x: spacing.panel-x, y: spacing.panel-y), above: spacing.element, below: spacing.element, breakable: false,
)[
  #text(weight: "bold", size: type-scale.minor-heading, fill: accent)[#title]
  #if tag != none and tag != "" and tag != [] [
    #h(6pt)
    #text(size: type-scale.footer, fill: colors.muted)[#tag]
  ]
  #v(spacing.label)
  #text(size: type-scale.small)[#body]
]
#let checklist(items) = {
  set list(marker: box(rect(width: 5pt, height: 5pt, stroke: 0.8pt + colors.muted)), spacing: spacing.item)
  list(..items)
}

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
      #if is-user [شما:] else [#en[AI:]]
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

// Dark cover variant: a navy page with one white band that holds the seal and university name.
#let dark-cover = (
  page: rgb("#0D1727"), band: white,
  ink: rgb("#E6F3FF"), accent: rgb("#5EC8F2"), muted: rgb("#7F95B5"), rule: rgb("#2F5183"),
  band-height: document-style.cover-y + document-style.logo + 6mm,
)
#let course-cover(kind, title, subtitle, number, meta, deadline, prepared-by, issued-on, artwork: none, dark: false) = {
  let ink = if dark { dark-cover.ink } else { colors.ink }
  let accent = if dark { dark-cover.accent } else { colors.blue }
  let muted = if dark { dark-cover.muted } else { colors.muted }
  let rule-color = if dark { dark-cover.rule } else { colors.rule }
  let page-fill = if dark { dark-cover.page } else { none }
  let page-background = if dark {
    place(top + left, rect(width: 210mm, height: dark-cover.band-height, fill: dark-cover.band))
  } else { none }
  let details = ()
  for (label, value) in (
    ("استاد درس", meta.instructor), ("تهیه‌کنندگان", prepared-by),
    ("نیمسال تحصیلی", meta.term), ("تاریخ انتشار", issued-on),
    ("مهلت تحویل", deadline),
  ) {
    if value != none {
      details.push(block(above: 0pt, below: 0pt)[
        #set par(spacing: 0pt)
        #text(size: type-scale.small, fill: muted)[#label]
        #v(spacing.label)
        #text(size: type-scale.body, fill: ink)[#value]
      ])
    }
  }
  page(paper: "a4", margin: (x: document-style.margin-x, y: document-style.cover-y), header: none, footer: none, numbering: none, fill: page-fill, background: page-background)[
    #set block(above: 0pt, below: 0pt)
    #set par(spacing: 0pt)
    #grid(columns: (document-style.logo, 1fr), gutter: 10mm, align: horizon,
      image("../../resources/assets/logos/ut-source.png", width: document-style.logo),
      align(right)[
        #text(size: type-scale.body, weight: "bold", fill: colors.ink)[#meta.university]
        #v(spacing.label)
        #text(size: type-scale.small, fill: colors.muted)[#meta.faculty]
      ],
    )
    #v(if dark { 12mm } else { spacing.cover-brand })
    #block(width: 100%, above: 0pt, below: 0pt)[
      #text(size: type-scale.cover-course, weight: "bold", fill: ink)[#meta.title]
      #v(spacing.cover-course)
      #text(size: type-scale.label, weight: "bold", fill: accent)[#kind]
      #v(8pt)
      #grid(columns: (1fr, auto), gutter: 20pt, align: (right + horizon, left + horizon),
        text(size: type-scale.cover-title, weight: "bold", fill: ink)[#title],
        if number != none { text(size: type-scale.cover-number, weight: "bold", fill: accent)[#fa(number)] },
      )
      #if subtitle != none { v(spacing.cover-subtitle); text(size: type-scale.cover-subtitle, fill: muted)[#subtitle] }
      #v(spacing.cover-rule)
      #line(length: 24mm, stroke: 1.8pt + accent)
    ]
    #if details.len() > 0 {
      v(spacing.cover-details)
      grid(columns: (1fr, 1fr), column-gutter: 15mm, row-gutter: 8mm, ..details)
    }
    #v(1fr)
    #if artwork != none {
      artwork
      v(if dark { 6mm } else { 12mm })
    }
    #line(length: 100%, stroke: 0.6pt + rule-color)
  ]
}

#let course-document(body, kind: "جزوه", title: "", subtitle: none, number: none, meta: course-info, deadline: none, prepared-by: none, issued-on: none, pdf-author: none, cover-artwork: none, cover-dark: false) = {
  let author = if pdf-author == none { metadata-text(meta.university) + " — " + metadata-text(meta.title) } else { pdf-author }
  set document(title: str(title), author: author)
  set text(font: prose-fonts, size: type-scale.body, lang: "fa", dir: rtl, fill: colors.ink)
  show: semantic-typography
  set par(justify: false, leading: spacing.line, spacing: spacing.paragraph)
  set block(above: spacing.element, below: spacing.element)
  set list(indent: 0pt, body-indent: 13pt, spacing: spacing.item, marker: text(fill: colors.blue)[•])
  set enum(indent: 0pt, body-indent: 16pt, spacing: spacing.item, numbering: n => fa(n) + ".")
  set heading(numbering: none)
  show heading: set block(above: spacing.section-before, below: spacing.section-after, sticky: true)
  show heading.where(level: 2): set block(above: spacing.subsection-before, below: spacing.subsection-after)
  show heading.where(level: 3): set block(above: spacing.minor-before, below: spacing.minor-after)
  show heading.where(level: 1): set text(size: type-scale.heading, weight: "bold", fill: colors.ink)
  show heading.where(level: 2): set text(size: type-scale.subheading, weight: "bold", fill: colors.blue)
  show heading.where(level: 3): set text(size: type-scale.minor-heading, weight: "bold")
  set math.equation(number-align: left + horizon)
  show math.equation.where(block: true): set block(above: spacing.element, below: spacing.element)
  show raw.where(block: true): it => block(width: 100%, fill: colors.pale, stroke: (left: 1.5pt + colors.rule), inset: (x: spacing.panel-x, y: spacing.panel-y), above: spacing.element, below: spacing.element, radius: 3pt, breakable: true)[
    #set block(above: 0pt, below: 0pt)
    #set text(size: type-scale.code, lang: "en", dir: ltr)
    #set align(left)
    #set par(leading: 4pt, spacing: 0pt)
    #it
  ]
  show table: set text(size: type-scale.label)
  set table(stroke: 0.5pt + colors.rule, inset: (x: 8pt, y: 6pt))
  set footnote(numbering: "۱")
  set page(
    paper: "a4", margin: (x: document-style.margin-x, top: document-style.body-top, bottom: document-style.body-bottom),
    numbering: "۱",
    header: context {
      block(above: 0pt, below: 0pt)[
        #set text(font: prose-fonts, lang: "fa", dir: rtl)
        #set align(right)
        #set par(spacing: 0pt)
        #text(size: type-scale.small, weight: "bold")[#meta.title]
        #h(1fr)
        #if meta.faculty != none [
          #text(size: type-scale.small, fill: colors.muted)[#meta.faculty]
          #h(1fr)
        ]
        #box(text(size: type-scale.small, fill: colors.blue)[#kind #if number != none { h(spacing.label); fa(number) }])
        #v(spacing.label)
        #line(length: 100%, stroke: 0.6pt + colors.rule)
      ]
    },
    footer: context [
      #set text(font: prose-fonts, lang: "fa", dir: rtl)
      #set align(right)
      #set par(spacing: 0pt)
      #line(length: 100%, stroke: 0.6pt + colors.rule)
      #v(spacing.label)
      #text(size: type-scale.footer, fill: colors.muted)[#meta.university #h(1fr) #fa(counter(page).get().first())]
    ],
    header-ascent: document-style.furniture-gap, footer-descent: document-style.furniture-gap,
  )
  course-cover(kind, title, subtitle, number, meta, deadline, prepared-by, issued-on, artwork: cover-artwork, dark: cover-dark)
  counter(page).update(1)
  body
}

// Both workshop starters and real workshops use this composition contract.
#let course-workshop(body, title: "عنوان کارگاه", subtitle: none, number: none,
  meta: course-info, prepared-by: none, issued-on: none, pdf-author: none,
  reflection: workshop-reflection,
) = course-document(
  kind: "یادداشت کارگاه", title: title, subtitle: subtitle, number: number,
  meta: meta, prepared-by: prepared-by, issued-on: issued-on, pdf-author: pdf-author,
  cover-artwork: cover-vignette(reflection.image, reflection.quote),
  [#body #pagebreak() #workshop-closing(reflection)],
)

// Widescreen presentations share the document family's identity and helpers.
// All slide geometry and type live here; entries only supply content.
#let slide-style = (
  width: 960pt, height: 540pt, margin-x: 48pt, margin-y: 30pt,
  body: 24pt, title: 38pt, cover: 58pt, section: 62pt,
  label: 14pt, footer: 12pt, gap: 24pt, column-gap: 36pt,
  heading: 30pt, subheading: 28pt, minor-heading: 26pt, code: 19pt,
  affiliation: 18pt, course: 20pt, cover-subtitle: 25pt,
  section-number: 26pt, section-subtitle: 26pt,
  metadata: 16pt, statement: 46pt, attribution: 20pt,
  leading: 8pt, paragraph: 16pt, item: 16pt, heading-gap: 14pt,
  list-gap: 20pt, panel-inset: 18pt, code-leading: 6pt,
)
#let slide-counter = counter("course-slide")

#let course-slides(body, title: "ارائهٔ درس", meta: course-info, pdf-author: none) = {
  let author = if pdf-author == none { metadata-text(meta.university) + " — " + metadata-text(meta.title) } else { pdf-author }
  set document(title: title, author: author)
  set text(font: prose-fonts, size: slide-style.body, lang: "fa", dir: rtl, fill: colors.ink)
  show: semantic-typography
  set align(right)
  set par(justify: false, leading: slide-style.leading, spacing: slide-style.paragraph)
  set block(above: 0pt, below: 0pt)
  set list(indent: 0pt, body-indent: 22pt, spacing: slide-style.item, marker: text(fill: colors.blue)[•])
  set enum(indent: 0pt, body-indent: 26pt, spacing: slide-style.item, numbering: n => fa(n) + ".")
  show list: set block(above: slide-style.list-gap, below: slide-style.list-gap)
  show enum: set block(above: slide-style.list-gap, below: slide-style.list-gap)
  set heading(numbering: none)
  show heading: set block(above: 0pt, below: slide-style.heading-gap, sticky: true)
  show heading: set text(weight: "bold", fill: colors.blue)
  show heading.where(level: 1): set text(size: slide-style.heading)
  show heading.where(level: 2): set text(size: slide-style.subheading)
  show heading.where(level: 3): set text(size: slide-style.minor-heading)
  show raw.where(block: true): it => block(width: 100%, fill: colors.pale, inset: slide-style.panel-inset, radius: 4pt)[
    #set text(size: slide-style.code)
    #set par(leading: slide-style.code-leading, spacing: 0pt)
    #set align(left)
    #it
  ]
  set page(width: slide-style.width, height: slide-style.height, margin: 0pt,
    header: none, footer: none, numbering: none, fill: colors.white)
  slide-counter.update(0)
  body
}

#let slide-page(body, fill: colors.white, counted: true) = {
  if counted { slide-counter.step() }
  page(width: slide-style.width, height: slide-style.height, margin: 0pt,
    header: none, footer: none, numbering: none, fill: fill)[
    #block(width: 100%, height: 100%, inset: (x: slide-style.margin-x, y: slide-style.margin-y))[
      #body
    ]
  ]
}

#let slide-footer(meta, dark: false, source: none) = context {
  let tint = if dark { colors.rule } else { colors.muted }
  grid(columns: (1fr, auto), gutter: 24pt, align: (right, left),
    text(size: slide-style.footer, fill: tint)[#if source == none { meta.university } else { source }],
    text(size: slide-style.footer, fill: tint)[#fa(slide-counter.get().first())],
  )
}

// An open content area, with a quiet course/section header and numbered footer.
#let slide-shell(title, body, section: none, meta: course-info, source: none) = slide-page[
  #grid(columns: (1fr,), rows: (24pt, 24pt, auto, 24pt, 1fr, 22pt, 22pt),
    grid(columns: (1fr, auto), align: (right, left),
      text(size: slide-style.label, fill: colors.muted)[#meta.title],
      text(size: slide-style.label, fill: colors.blue)[#if section != none { section }],
    ),
    [],
    block[#text(size: slide-style.title, weight: "bold")[#title]],
    [],
    block(width: 100%, height: 100%)[#body],
    [],
    slide-footer(meta, source: source),
  )
]

#let slide-cover(title, subtitle: none, meta: course-info, presented-by: none, date: none) = slide-page(counted: false)[
  #grid(columns: (1fr,), rows: (80pt, 1fr, auto, 1fr, 28pt),
    grid(columns: (80pt, 1fr), gutter: 24pt, align: horizon,
      image("../../resources/assets/logos/ut-source.png", width: 80pt),
      [
        #text(size: slide-style.affiliation, weight: "bold")[#meta.university]
        #v(6pt)
        #text(size: slide-style.label, fill: colors.muted)[#meta.faculty]
      ],
    ),
    [],
    [
      #text(size: slide-style.course, fill: colors.blue)[#meta.title]
      #v(16pt)
      #text(size: slide-style.cover, weight: "bold")[#title]
      #if subtitle != none { v(18pt); text(size: slide-style.cover-subtitle, fill: colors.muted)[#subtitle] }
    ],
    [],
    grid(columns: (1fr, auto), gutter: 24pt,
      text(size: slide-style.metadata, fill: colors.muted)[#if presented-by != none { presented-by }],
      text(size: slide-style.metadata, fill: colors.muted)[#if date != none { date } else if meta.term != none { meta.term }],
    ),
  )
]

#let slide-section(title, subtitle: none, number: none, meta: course-info) = slide-page(fill: colors.ink)[
  #set text(fill: colors.white)
  #grid(columns: (1fr,), rows: (24pt, 1fr, auto, 1fr, 22pt),
    text(size: slide-style.label, fill: colors.rule)[#meta.title],
    [],
    [
      #if number != none { text(size: slide-style.section-number, fill: colors.rule)[بخش #fa(number)]; v(22pt) }
      #text(size: slide-style.section, weight: "bold")[#title]
      #if subtitle != none { v(slide-style.gap); text(size: slide-style.section-subtitle, fill: colors.rule)[#subtitle] }
    ],
    [],
    slide-footer(meta, dark: true),
  )
]

// First column is the logical right-hand column in the Persian layout.
#let slide-columns(title, right-body, left-body, section: none, meta: course-info, source: none) = slide-shell(
  title, section: section, meta: meta, source: source,
  grid(columns: (1fr, 1fr), gutter: slide-style.column-gap, right-body, left-body),
)

#let slide-image-text(title, path, body, section: none, meta: course-info, source: none, fit: "contain") = slide-shell(
  title, section: section, meta: meta, source: source,
  grid(columns: (0.85fr, 1.15fr), rows: (1fr,), gutter: slide-style.column-gap,
    block(width: 100%, height: 100%)[#body],
    image(path, width: 100%, height: 100%, fit: fit),
  ),
)

// The entire source image remains visible by default, without any furniture.
// Use fit: "cover" only when cropping is intentional.
#let slide-image(path, fit: "contain", background: colors.white) = {
  slide-counter.step()
  page(width: slide-style.width, height: slide-style.height, margin: 0pt,
    header: none, footer: none, numbering: none, fill: background)[
    #place(top + left, image(path, width: slide-style.width, height: slide-style.height, fit: fit))
  ]
}

#let slide-statement(body, attribution: none, meta: course-info) = slide-page(fill: colors.pale)[
  #grid(columns: (1fr,), rows: (24pt, 1fr, auto, 1fr, 22pt),
    text(size: slide-style.label, fill: colors.blue)[#meta.title],
    [],
    [
      #text(size: slide-style.statement, weight: "bold")[#body]
      #if attribution != none { v(slide-style.gap); text(size: slide-style.attribution, fill: colors.muted)[#attribution] }
    ],
    [],
    slide-footer(meta),
  )
]
