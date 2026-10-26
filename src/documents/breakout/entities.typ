#import "../../course/theme.typ": *

// Page 7: Entities & Geometry (موجودیت‌ها و هندسه بازی)
// Features 4 modular OOP entity cards with inline vector graphic visualizations,
// Persian digits throughout, and strict encapsulation guidelines.

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
      #text(dir: rtl, font: body-font, size: 5.6pt, fill: colors.muted)[قطر: ۱۶ پیکسل (جعبه ۱۶×۱۶)]
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
      #text(dir: rtl, font: body-font, size: 5.8pt, fill: colors.muted)[ماتریس ۵ سطر × ۸ ستون (۴۰ آجر)]
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
      #text(dir: rtl, font: body-font, size: 4.8pt, fill: colors.ink)[نوار: #text(fill: rgb("EF4444"))[♥ ♥ ♥] | ۱۰۰]
    ]

    // Coordinate Origin (0,0)
    #place(top + left, dx: cx - 6pt, dy: cy - 7pt)[
      #text(dir: rtl, font: body-font, size: 5.5pt, fill: colors.muted)[(#fa(0), #fa(0))]
    ]

    // Dimensions 800 x 600
    #place(top + left, dx: cx + 14pt, dy: cy + 18pt)[
      #text(dir: rtl, font: body-font, size: 6.2pt, fill: colors.ink, weight: "bold")[۸۰۰ × ۶۰۰ پیکسل]
    ]

    // Bottom Fall Line (y > 600)
    #place(top + left, dx: cx, dy: cy + ch - 1pt,
      line(start: (0pt, 0pt), end: (cw, 0pt), stroke: (paint: rgb("EF4444"), dash: "dashed", thickness: 0.65pt)))
    #place(bottom + center, dy: -2pt)[
      #text(dir: rtl, font: body-font, size: 5.6pt, fill: rgb("DC2626"))[سقوط توپ: $y > #text(font: body-font)[۶۰۰]$]
    ]
  ]
)

#let breakout-entities-page() = [
  = موجودیت‌ها و هندسه بازی

  جهان بازی Breakout از ۴ موجودیت بنیادین تشکیل شده که هر کدام مشخصات دقیق هندسی و مرزهای کپسوله‌شده داده‌ای دارند. مختصات صفحه با مبدا $(#fa(0), #fa(0))$ در گوشه بالا-چپ بوم تعریف شده و تمام محاسبات بر پایه پیکسل انجام می‌گیرد:

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
          #text(weight: "bold", size: type-scale.small + 0.5pt, fill: accent)[#title]
          #h(6pt)
          #text(size: 8pt, fill: colors.muted)[#en-tag]
        ],
        box(fill: accent.lighten(90%), inset: (x: 6pt, y: 2.5pt), radius: 2pt)[
          #text(size: 7.5pt, fill: accent, weight: "bold")[#badge-text]
        ]
      )
      #v(3pt)
      #grid(
        columns: (1fr, 110pt),
        gutter: 10pt,
        [
          #text(size: 8.5pt)[
            *هندسه و ابعاد:* #geom-text
          ]
          #v(2.5pt)
          #text(size: 8.5pt)[
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
    [ابعاد ۱۰۰×۱۵ px | Y=۵۴۵ px | بازه X: [۰, ۷۰۰]],
    [مستطیل به ابعاد ۱۰۰ در ۱۵ پیکسل مستقر در فاصله ۴۰ پیکسلی از کف پنجره ($y = ۵۴۵$). بازه مجاز جابه‌جایی افقی $x in [۰, ۷۰۰]$ است تا سکو هرگز از حاشیه چپ یا راست بوم خارج نشود.],
    [فیلدهای مختصات خصوصی (#code-inline("private")) هستند. جابه‌جایی با سرعت ۸ پیکسل بر تیک صرفاً از طریق فراخوانی متدهای #code-inline("moveLeft") و #code-inline("moveRight") با اعمال مهار مرزی انجام می‌پذیرد.],
    paddle-visual()
  )

  #v(3pt)

  #entity-card(
    "توپ",
    code-inline("Ball"),
    rgb("D97706"),
    [قطر ۱۶ px (شعاع ۸) | تندی پایه ۶.۰ px/tick],
    [دایره به قطر ۱۶ پیکسل با شعاع $r$ برابر ۸ پیکسل. مستطیل محاطی تداخل آن ۱۶×۱۶ پیکسل است. بردار سرعت با تندی پایه ۶.۰ پیکسل بر تیک در برخورد با دیواره‌ها و سکو به صورت الاستیک بازتاب می‌یابد.],
    [در شروع دور، توپ در نقطه مهار روی سکو $(x_"paddle" + ۴۲, ۵۲۹)$ قرار داشته و با کلید فاصله پرتاب می‌شود. فیلدهای سرعت و موقعیت خصوصی بوده و متدهای #code-inline("reverseX") و #code-inline("reverseY") جهت بردار را معکوس می‌کنند.],
    ball-visual()
  )

  #v(3pt)

  #entity-card(
    "آجرها",
    code-inline("Brick"),
    rgb("059669"),
    [ماتریس ۴۰ آجر (۵×۸) | ابعاد ۸۵×۲۵ px | فاصله ۶ px],
    [شبکه ۵ سطر در ۸ ستون (۴۰ آجر). ابعاد هر آجر ۸۵ در ۲۵ پیکسل با فاصله ۶ پیکسل و حاشیه بالای ۶۰ پیکسل. فرمول مکان آجر سطر $r$ و ستون $c$: $x = ۳۹ + c times ۹۱$ و $y = ۶۰ + r times ۳۱$.],
    [هر آجر دارای مستطیل محیطی تداخل و فیلد وضعیت تخریب خصوصی است. با اصابت توپ، متد #code-inline("hit") وضعیت آجر را به نابود تغییر داده، آجر از صفحه محو شده و ۱۰۰ امتیاز به بازیکن تعلق می‌گیرد.],
    brick-visual()
  )

  #v(3pt)

  #entity-card(
    "نشانگر وضعیت و بوم",
    code-inline("HUD / Canvas"),
    colors.ink,
    [بوم ۸۰۰×۶۰۰ px | نوار وضعیت ارتفاع ۳۵ px],
    [پنجره گرافیکی با ابعاد ۸۰۰ در ۶۰۰ پیکسل و مبدا $(#fa(0), #fa(0))$ در گوشه بالا-چپ. نوار بالایی صفحه به ارتفاع ۳۵ پیکسل برای نمایش وضعیت جان‌ها، امتیاز و رکورد بازی در نظر گرفته شده است.],
    [موتور بازی وضعیت ۳ جان و امتیاز جاری را مدیریت می‌کند. خروج توپ از کف ($y > #text(font: body-font)[۶۰۰]$) جان کسر کرده و پس از اتمام جان‌ها یا تخریب تمام ۴۰ آجر، پیام‌های پایان توسط نما نمایش داده می‌شوند.],
    hud-visual()
  )
]
