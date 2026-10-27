#import "../../course/theme.typ": *

#let paddle-visual() = block(
  width: 100%,
  height: 64pt,
  fill: rgb("F8FAFC"),
  stroke: 0.6pt + colors.blue.lighten(50%),
  radius: 3pt,
  clip: true,
  [
    #set text(dir: ltr, font: english-font)
    // Canvas coordinate reference top-left
    #place(top + left, dx: 4pt, dy: 3pt)[
      #text(font: body-font, size: 5.5pt, fill: colors.muted)[$(x, ۵۴۵)$]
    ]

    // Paddle rectangle
    #let pw = 68pt
    #let ph = 12pt
    #let px = 20pt
    #let py = 18pt

    #place(top + left, dx: px, dy: py,
      rect(width: pw, height: ph, fill: colors.blue.lighten(85%), stroke: 1.1pt + colors.blue, radius: 2pt))

    // Dimension: Width 100 px
    #place(top + left, dx: px, dy: py - 7pt)[
      #line(start: (0pt, 0pt), end: (pw, 0pt), stroke: 0.45pt + colors.blue)
      #line(start: (0pt, -2pt), end: (0pt, 2pt), stroke: 0.45pt + colors.blue)
      #line(start: (pw, -2pt), end: (pw, 2pt), stroke: 0.45pt + colors.blue)
    ]
    #place(top + left, dx: px + pw / 2 - 14pt, dy: py - 14pt)[
      #text(dir: rtl, font: body-font, size: 6.2pt, fill: colors.blue, weight: "bold")[۱۰۰ پیکسل]
    ]

    // Center Notch (cx)
    #place(top + left, dx: px + pw / 2, dy: py)[
      #line(start: (0pt, 0pt), end: (0pt, 4pt), stroke: 0.7pt + colors.ink)
    ]
    #place(top + left, dx: px + pw / 2 - 4pt, dy: py + 4pt)[
      #text(size: 5.2pt, fill: colors.ink)[$c_x$]
    ]

    // Height dimension: 15 px
    #place(top + left, dx: px + pw + 22pt, dy: py + 2pt)[
      #text(dir: rtl, font: body-font, size: 5.6pt, fill: colors.muted)[۱۵ پیکسل]
    ]

    // Horizontal Movement Range: [0, 700]
    #place(bottom + center, dy: -5pt)[
      #text(dir: rtl, font: body-font, size: 6.0pt, fill: rgb("0F172A"), weight: "medium")[
        دامنه افقی: [#fa(0)، #fa(700)] پیکسل
      ]
    ]
  ]
)

#let ball-visual() = block(
  width: 100%,
  height: 64pt,
  fill: rgb("FFFDF7"),
  stroke: 0.6pt + rgb("D97706").lighten(50%),
  radius: 3pt,
  clip: true,
  [
    #set text(dir: ltr, font: english-font)

    #let br = 10pt
    #let bx = 30pt
    #let by = 32pt

    // AABB Bounding Box (dashed square)
    #place(top + left, dx: bx - br - 1pt, dy: by - br - 1pt,
      rect(width: 2 * br + 2pt, height: 2 * br + 2pt,
        stroke: (paint: rgb("D97706").lighten(40%), dash: "dashed", thickness: 0.5pt), radius: 1pt))

    // Ball circle
    #place(top + left, dx: bx - br, dy: by - br,
      circle(radius: br, fill: rgb("FEF3C7"), stroke: 1.15pt + rgb("D97706")))

    // Center point
    #place(top + left, dx: bx - 1pt, dy: by - 1pt,
      circle(radius: 1.2pt, fill: rgb("B45309")))

    // Radius line and label (r = 8 with Persian 8)
    #place(top + left,
      line(start: (bx, by), end: (bx + br, by), stroke: 0.7pt + rgb("B45309")))
    #place(top + left, dx: bx + 20pt, dy: by + 2pt)[
      #text(dir: rtl, font: body-font, size: 5.6pt, fill: rgb("B45309"), weight: "bold")[شعاع ۸]
    ]

    // Velocity Vector arrow
    #place(top + left,
      line(start: (bx, by), end: (bx + 26pt, by - 18pt), stroke: 1.1pt + rgb("D97706")))
    #place(top + left, dx: bx + 24pt, dy: by - 21pt)[
      #rotate(-35deg)[
        #line(start: (-3pt, -2pt), end: (0pt, 0pt), stroke: 1.1pt + rgb("D97706"))
        #line(start: (-3pt, 2pt), end: (0pt, 0pt), stroke: 1.1pt + rgb("D97706"))
      ]
    ]

    // Velocity label
    #place(top + left, dx: bx + 14pt, dy: by - 26pt)[
      #text(dir: rtl, font: body-font, size: 6.0pt, fill: rgb("D97706"), weight: "bold")[تندی ۶.۰]
    ]

    // Diameter label
    #place(bottom + left, dx: 4pt, dy: -4pt)[
      #text(dir: rtl, font: body-font, size: 5.6pt, fill: colors.muted)[قطر ۱۶ پیکسل؛ جعبه مرز ۱۶×۱۶]
    ]
  ]
)

#let brick-visual() = block(
  width: 100%,
  height: 64pt,
  fill: rgb("F7FEFA"),
  stroke: 0.6pt + rgb("059669").lighten(50%),
  radius: 3pt,
  clip: true,
  [
    #set text(dir: ltr, font: english-font)

    #let bw = 54pt
    #let bh = 14pt
    #let bx = 12pt
    #let by = 14pt

    // Intact Brick
    #place(top + left, dx: bx, dy: by,
      rect(width: bw, height: bh, fill: rgb("D1FAE5"), stroke: 1.1pt + rgb("059669"), radius: 1.5pt))
    #place(top + left, dx: bx + 8pt, dy: by + 3pt)[
      #text(dir: rtl, font: body-font, size: 6.2pt, fill: rgb("065F46"), weight: "bold")[۸۵ × ۲۵ پیکسل]
    ]

    // Second Brick below showing gap
    #place(top + left, dx: bx, dy: by + bh + 6pt,
      rect(width: bw, height: 10pt, fill: rgb("E6FDF1"), stroke: 0.8pt + rgb("10B981"), radius: 1.5pt))

    // Gap dimension line (6 px)
    #place(top + left, dx: bx + bw + 4pt, dy: by + bh)[
      #line(start: (0pt, 0pt), end: (0pt, 6pt), stroke: 0.45pt + rgb("059669"))
      #line(start: (-2pt, 0pt), end: (2pt, 0pt), stroke: 0.45pt + rgb("059669"))
      #line(start: (-2pt, 6pt), end: (2pt, 6pt), stroke: 0.45pt + rgb("059669"))
    ]
    #place(top + left, dx: bx + bw + 8pt, dy: by + bh - 1pt)[
      #text(dir: rtl, font: body-font, size: 5.8pt, fill: rgb("059669"))[۶ پیکسل]
    ]

    // Score Callout Badge
    #place(top + right, dx: -6pt, dy: 8pt)[
      #box(fill: rgb("ECFDF5"), stroke: 0.5pt + rgb("059669"), inset: (x: 4pt, y: 2pt), radius: 2pt)[
        #text(dir: rtl, font: body-font, size: 6.2pt, fill: rgb("065F46"), weight: "bold")[+۱۰۰ امتیاز]
      ]
    ]

    // Matrix summary
    #place(bottom + center, dy: -4pt)[
      #text(dir: rtl, font: body-font, size: 5.8pt, fill: colors.muted)[ماتریس ۵×۸ — ۴۰ آجر]
    ]
  ]
)

#let hud-visual() = block(
  width: 100%,
  height: 64pt,
  fill: rgb("F8FAFC"),
  stroke: 0.6pt + colors.ink.lighten(50%),
  radius: 3pt,
  clip: true,
  [
    #set text(dir: ltr, font: english-font)

    #let cw = 88pt
    #let ch = 48pt
    #let cx = 10pt
    #let cy = 8pt

    // Canvas boundary (800 x 600 scaled)
    #place(top + left, dx: cx, dy: cy,
      rect(width: cw, height: ch, fill: white, stroke: 0.9pt + colors.ink, radius: 2pt))

    // Top HUD Bar
    #place(top + left, dx: cx, dy: cy,
      rect(width: cw, height: 9pt, fill: rgb("F1F5F9"), stroke: (bottom: 0.5pt + colors.rule), radius: (top: 2pt)))
    #place(top + left, dx: cx + 3pt, dy: cy + 1.5pt)[
      #text(dir: rtl, font: body-font, size: 4.8pt, fill: colors.ink)[نوار: #text(fill: rgb("EF4444"))[جان ۳] | امتیاز ۱۰۰]
    ]

    // Coordinate Origin (0,0)
    #place(top + left, dx: cx - 6pt, dy: cy - 7pt)[
      #text(dir: rtl, font: body-font, size: 5.5pt, fill: colors.muted)[مبدا: #fa(0)، #fa(0)]
    ]

    // Dimensions 800 x 600
    #place(top + left, dx: cx + 14pt, dy: cy + 18pt)[
      #text(dir: rtl, font: body-font, size: 6.2pt, fill: colors.ink, weight: "bold")[۸۰۰ × ۶۰۰ پیکسل]
    ]

    // Bottom fall line (below paddle)
    #place(top + left, dx: cx, dy: cy + ch - 1pt,
      line(start: (0pt, 0pt), end: (cw, 0pt), stroke: (paint: rgb("EF4444"), dash: "dashed", thickness: 0.65pt)))
    #place(bottom + center, dy: -2pt)[
      #text(dir: rtl, font: body-font, size: 5.6pt, fill: rgb("DC2626"))[کف بوم — مرز سقوط توپ]
    ]
  ]
)

#let breakout-entities-page() = [
  = موجودیت‌ها و هندسه بازی

  بازی Breakout از چهار موجودیت تشکیل شده است. هر کدام ابعاد مشخص دارند و داده‌های داخلی‌شان پنهان است. مختصات از مبدأ $(#fa(0), #fa(0))$ در گوشهٔ بالا-چپ بوم شروع می‌شود و همهٔ محاسبات بر حسب پیکسل است:

  #v(3pt)

  #let entity-card(title, en-tag, accent, badge-text, geom-text, oop-text, visual-widget) = block(
    fill: colors.pale,
    stroke: (right: 3.5pt + accent),
    radius: 3pt,
    inset: (x: 9pt, y: 6pt),
    width: 100%,
    [
      #grid(
        columns: (1fr, auto),
        align: (right + horizon, left + horizon),
        [
          #text(weight: "bold", size: type-scale.minor-heading, fill: accent)[#title]
          #h(6pt)
          #text(size: type-scale.footer, fill: colors.muted)[#en-tag]
        ],
        box(fill: accent.lighten(90%), inset: (x: 6pt, y: 2.5pt), radius: 2pt)[
          #text(size: type-scale.footer, fill: accent, weight: "bold")[#badge-text]
        ]
      )
      #v(3pt)
      #grid(
        columns: (1fr, 110pt),
        gutter: 10pt,
        [
          #text(size: type-scale.small)[
            *هندسه و ابعاد:* #geom-text
          ]
          #v(2.5pt)
          #text(size: type-scale.small)[
            *رفتار و کپسوله‌سازی:* #oop-text
          ]
        ],
        visual-widget
      )
    ]
  )

  #entity-card(
    "سکو",
    code-inline("Paddle"),
    colors.blue,
    [ابعاد ۱۰۰×۱۵ پیکسل | Y=۵۴۵ پیکسل | بازه X: [۰, ۷۰۰]],
    [مستطیل ۱۰۰ در ۱۵ پیکسل که ۴۰ پیکسل بالاتر از کف پنجره قرار دارد ($y = ۵۴۵$). سکو فقط در بازهٔ $x in [۰، ۷۰۰]$ جابه‌جا می‌شود تا از لبه‌های بوم بیرون نزند.],
    [فیلدهای مختصات #code-inline("private") هستند. سکو فقط با #code-inline("moveLeft") و #code-inline("moveRight") جابه‌جا می‌شود، با سرعت ۸ پیکسل در هر تیک و با کنترل مرز.],
    paddle-visual()
  )

  #v(3pt)

  #entity-card(
    "توپ",
    code-inline("Ball"),
    rgb("D97706"),
    [قطر ۱۶ \| شعاع ۸ \| تندی پایه ۶.۰ پیکسل/تیک],
    [دایره‌ای به قطر ۱۶ پیکسل. موقعیت آن گوشهٔ بالا-چپ جعبهٔ مرزی ۱۶×۱۶ است. با دیواره‌ها و آجرها، #code-inline("reverseX") و #code-inline("reverseY") مؤلفهٔ سرعت را برمی‌گردانند. بازتاب از سکو زاویه‌دار است و در بخش فیزیک توضیح داده شده است؛ بازتاب آینه‌ای ساده کافی نیست.],
    [در شروع هر دور توپ روی سکو قرار دارد؛ مثلاً در $(x_"paddle" + ۴۲, ۵۲۹)$، یعنی وسط سکو منهای شعاع توپ. با #code-inline("Space") پرتاب می‌شود. فیلدهای سرعت و موقعیت #code-inline("private") هستند. برای تغییر سرعت از سکو، از #code-inline("setVx")/#code-inline("setVy") یا متد #code-inline("bounceOffPaddle") استفاده کنید.],
    ball-visual()
  )

  #v(3pt)

  #entity-card(
    "آجرها",
    code-inline("Brick"),
    rgb("059669"),
    [ماتریس ۴۰ آجر (۵×۸) | ابعاد ۸۵×۲۵ پیکسل | فاصله ۶ پیکسل],
    [۴۰ آجر در ۵ سطر و ۸ ستون. هر آجر ۸۵ در ۲۵ پیکسل است و تا آجر بعدی ۶ پیکسل فاصله دارد. حاشیهٔ بالای شبکه ۶۰ پیکسل است. مکان آجر سطر $r$ و ستون $c$ از این فرمول به دست می‌آید: $x = ۳۹ + c times ۹۱$ و $y = ۶۰ + r times ۳۱$.],
    [هر آجر یک مستطیل مرزی#footnote[#en[AABB: Axis-Aligned Bounding Box]] و وضعیت تخریب #code-inline("private") دارد. متد #code-inline("hit") با اصابت، آجر را از بین می‌برد و ۱۰۰ امتیاز ثبت می‌کند.],
    brick-visual()
  )

  #v(3pt)

  #entity-card(
    "نشانگر وضعیت و بوم",
    code-inline("HUD / Canvas"),
    colors.ink,
    [بوم ۸۰۰×۶۰۰ پیکسل | نوار وضعیت ارتفاع ۳۵ پیکسل],
    [پنجرهٔ بازی ۸۰۰ در ۶۰۰ پیکسل است و مبدأ $(#fa(0), #fa(0))$ در گوشهٔ بالا-چپ قرار دارد. نوار بالای صفحه ۳۵ پیکسل ارتفاع دارد و جان‌ها، امتیاز و رکورد را نشان می‌دهد.],
    [موتور بازی جان‌ها و امتیاز را نگه می‌دارد. وقتی لبهٔ پایین توپ از خط پایین بوم رد شود، یک جان کم می‌شود؛ شرط دقیق در بخش گیم‌پلی آمده است. با تمام شدن جان‌ها یا تخریب ۴۰ آجر، نما پیام پایان را نشان می‌دهد.],
    hud-visual()
  )
]
