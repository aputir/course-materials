#import "config.typ": course-info

#let colors = (
  ink: rgb("162B45"), blue: rgb("0077BD"), muted: rgb("627489"),
  pale: rgb("F0F6FA"), rule: rgb("D7E5EF"), white: white,
)
#let body-font = "Vazirmatn"
#let code-font = "JetBrains Mono"
// Absolute spacing avoids larger gaps merely because a heading uses larger type.
#let spacing = (
  line: 4pt, paragraph: 6pt, item: 6pt,
  section-before: 18pt, section-after: 7pt,
  subsection-before: 13pt, subsection-after: 5pt,
  minor-before: 10pt, minor-after: 4pt,
  element: 7pt, panel-x: 10pt, panel-y: 8pt, label: 5pt,
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
#let fa(value) = {
  let result = str(value)
  for (a, b) in ("0": "۰", "1": "۱", "2": "۲", "3": "۳", "4": "۴", "5": "۵", "6": "۶", "7": "۷", "8": "۸", "9": "۹") {
    result = result.replace(a, b)
  }
  result
}

// An inline box has its own bidi context. Use for short terms, not paragraphs.
#let en(body) = box(text(font: body-font, lang: "en", dir: ltr, body))
// A concept is prose, even when its name comes from programming.
#let term(body) = en(body)
#let latin-number(value) = en(str(value))
#let english(body) = block(width: 100%, above: spacing.element, below: spacing.element)[
  #set text(font: body-font, lang: "en", dir: ltr)
  #set align(left)
  #body
]
#let code-inline(value) = box(text(font: code-font, lang: "en", dir: ltr, ligatures: false, features: (calt: 0, liga: 0), raw(value)))
#let code-block(value, lang: "java") = raw(value, block: true, lang: lang)
#let math-inline(body) = box(text(lang: "en", dir: ltr, body))
#let badge(body) = box(fill: colors.white, stroke: 0.6pt + colors.rule, inset: (x: 8pt, y: 4pt), radius: 3pt, text(size: 9pt, fill: colors.blue, body))

#let mission(number, title, points) = heading(level: 1)[
  #block(width: 100%, fill: colors.pale, stroke: (right: 2pt + colors.blue), radius: 3pt, inset: (x: spacing.panel-x, y: spacing.panel-y), above: 0pt, below: 0pt, breakable: false)[
    #grid(columns: (1fr, auto), gutter: 12pt, align: (right, left),
      [
        #set par(spacing: 0pt)
        #text(size: 9pt, fill: colors.blue, weight: "regular")[مأموریت #fa(number)]
        #v(spacing.label)
        #text(size: 17pt, weight: "bold")[#title]
      ],
      badge[#fa(points) نمره],
    )
  ]
]
#let part(title, points: none) = heading(level: 2)[
  #title #if points != none { h(6pt); box(text(size: 9pt, weight: "regular", fill: colors.muted)[(#fa(points) نمره)]) }
]
#let note(title, body) = block(width: 100%, fill: colors.pale, inset: (x: spacing.panel-x, y: spacing.panel-y), above: spacing.element, below: spacing.element, radius: 3pt, breakable: true)[
  #block(above: 0pt, below: 0pt, sticky: true)[#text(weight: "bold", fill: colors.blue)[#title]]
  #v(spacing.label)
  #body
]
#let checklist(items) = {
  set list(marker: box(rect(width: 5pt, height: 5pt, stroke: 0.8pt + colors.muted)), spacing: spacing.item)
  list(..items)
}

#let course-cover(kind, title, subtitle, number, meta, deadline, prepared-by, issued-on) = {
  let details = ()
  for (label, value) in (
    ("استاد درس", meta.instructor), ("تهیه‌کنندگان", prepared-by),
    ("نیمسال تحصیلی", meta.term), ("تاریخ انتشار", issued-on),
    ("مهلت تحویل", deadline),
  ) {
    if value != none {
      details.push(block(above: 0pt, below: 0pt)[
        #set par(spacing: 0pt)
        #text(size: 9pt, fill: colors.muted)[#label]
        #v(spacing.label)
        #text(size: 11pt)[#value]
      ])
    }
  }
  page(paper: "a4", margin: (x: 21mm, y: 25mm), header: none, footer: none, numbering: none)[
    #set block(above: 0pt, below: 0pt)
    #set par(spacing: 0pt)
    #grid(columns: (32mm, 1fr), gutter: 10mm, align: horizon,
      image("../assets/logos/ut-source.png", width: 32mm),
      align(right)[
        #text(size: 11pt, weight: "bold")[#meta.university]
        #v(spacing.label)
        #text(size: 9pt, fill: colors.muted)[#meta.faculty]
      ],
    )
    #v(spacing.cover-brand)
    #block(width: 100%, above: 0pt, below: 0pt)[
      #text(size: 19pt, weight: "bold", fill: colors.ink)[#meta.title]
      #v(spacing.cover-course)
      #text(size: 10pt, weight: "bold", fill: colors.blue)[#kind]
      #v(8pt)
      #grid(columns: (1fr, auto), gutter: 20pt, align: (right + horizon, left + horizon),
        text(size: 32pt, weight: "bold")[#title],
        if number != none { text(size: 48pt, weight: "bold", fill: colors.blue)[#fa(number)] },
      )
      #if subtitle != none { v(spacing.cover-subtitle); text(size: 12pt, fill: colors.muted)[#subtitle] }
      #v(spacing.cover-rule)
      #line(length: 24mm, stroke: 1.8pt + colors.blue)
    ]
    #if details.len() > 0 {
      v(spacing.cover-details)
      grid(columns: (1fr, 1fr), column-gutter: 15mm, row-gutter: 8mm, ..details)
    }
    #v(1fr)
    #line(length: 100%, stroke: 0.6pt + colors.rule)
  ]
}

#let course-document(body, kind: "جزوه", title: "", subtitle: none, number: none, meta: course-info, deadline: none, prepared-by: none, issued-on: none, pdf-author: none) = {
  let author = if pdf-author == none { metadata-text(meta.university) + " — " + metadata-text(meta.title) } else { pdf-author }
  set document(title: str(title), author: author)
  set text(font: body-font, size: 11pt, lang: "fa", dir: rtl, fill: colors.ink)
  set par(justify: false, leading: spacing.line, spacing: spacing.paragraph)
  set block(above: spacing.element, below: spacing.element)
  set list(indent: 0pt, body-indent: 13pt, spacing: spacing.item, marker: text(fill: colors.blue)[•])
  set enum(indent: 0pt, body-indent: 16pt, spacing: spacing.item, numbering: n => fa(n) + ".")
  set heading(numbering: none)
  show heading: set block(above: spacing.section-before, below: spacing.section-after)
  show heading.where(level: 2): set block(above: spacing.subsection-before, below: spacing.subsection-after)
  show heading.where(level: 3): set block(above: spacing.minor-before, below: spacing.minor-after)
  show heading.where(level: 1): set text(size: 17pt, weight: "bold", fill: colors.ink)
  show heading.where(level: 2): set text(size: 12pt, weight: "bold", fill: colors.blue)
  show heading.where(level: 3): set text(size: 11pt, weight: "bold")
  show math.equation: set text(font: "New Computer Modern Math", lang: "en", dir: ltr)
  set math.equation(number-align: left + horizon)
  show math.equation.where(block: true): set block(above: spacing.element, below: spacing.element)
  show raw: set text(font: code-font, lang: "en", dir: ltr, ligatures: false, features: (calt: 0, liga: 0))
  // Raw applies a built-in 0.8em reduction; compensate so the final size is 0.86em.
  show raw.where(block: false): set text(size: 0.86em / 0.8)
  show raw.where(block: true): it => block(width: 100%, fill: colors.pale, stroke: (left: 1.5pt + colors.rule), inset: (x: spacing.panel-x, y: spacing.panel-y), above: spacing.element, below: spacing.element, radius: 3pt, breakable: true)[
    #set block(above: 0pt, below: 0pt)
    #set text(size: 9pt, lang: "en", dir: ltr)
    #set align(left)
    #set par(leading: 4pt, spacing: 0pt)
    #it
  ]
  show table: set text(size: 10pt)
  set table(stroke: 0.5pt + colors.rule, inset: (x: 8pt, y: 6pt))
  set page(
    paper: "a4", margin: (x: 21mm, top: 24mm, bottom: 20mm),
    header: context {
      block(above: 0pt, below: 0pt)[
        #set par(spacing: 0pt)
        #text(size: 9pt, weight: "bold")[#meta.title]
        #h(1fr)
        #box(text(size: 9pt, fill: colors.blue)[#kind #if number != none { h(5pt); fa(number) }])
        #v(4pt)
        #line(length: 100%, stroke: 0.6pt + colors.rule)
      ]
    },
    footer: context [
      #set par(spacing: 0pt)
      #line(length: 100%, stroke: 0.6pt + colors.rule)
      #v(4pt)
      #text(size: 8pt, fill: colors.muted)[#meta.university #h(1fr) #fa(counter(page).get().first())]
    ],
    header-ascent: 7mm, footer-descent: 7mm,
  )
  course-cover(kind, title, subtitle, number, meta, deadline, prepared-by, issued-on)
  counter(page).update(1)
  body
}
