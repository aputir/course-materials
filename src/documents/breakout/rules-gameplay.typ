#import "../../course/theme.typ": *

#let breakout-rules-gameplay-page() = [
  = سازوکار گیم‌پلی و وضعیت‌ها

  جریان بازی با یک ماشین وضعیت متناهی پیاده‌سازی می‌شود. واکنش بازی به کلیدها، برخوردها و پایان بازی بر اساس وضعیت فعلی تعیین می‌شود:

  #v(2pt)

  #align(center)[
    #block(
      fill: rgb("F8FAFC"),
      stroke: 0.8pt + colors.blue.lighten(40%),
      radius: 4pt,
      inset: (x: 10pt, y: 8pt),
      width: 100%,
      height: 150pt,
      [
        #set text(dir: ltr)

        // Helper for state box
        #let state-box(name, sub, clr, bg, border-w: 1.2pt) = block(
          fill: bg,
          stroke: border-w + clr,
          radius: 4pt,
          inset: (x: 6pt, y: 4pt),
          width: 100%,
          height: 100%,
          [
            #set align(center + horizon)
            #text(weight: "bold", size: 8.5pt, fill: clr)[#code-inline(name)] \
            #v(1.5pt)
            #text(dir: rtl, size: 6.8pt, fill: rgb("334155"))[#sub]
          ]
        )

        // --- TOP ROW NODES ---
        // 1. READY (left)
        #place(top + left, dx: 12pt, dy: 6pt)[
          #box(width: 88pt, height: 32pt)[
            #state-box("READY", [آماده‌باش / پرتاب], rgb("0284C7"), rgb("F0F9FF"))
          ]
        ]

        // 2. RUNNING (center)
        #place(top + left, dx: 180pt, dy: 4pt)[
          #box(width: 102pt, height: 36pt)[
            #state-box("RUNNING", [شبیه‌سازی ۶۰ هرتز], rgb("1D4ED8"), rgb("EFF6FF"), border-w: 1.6pt)
          ]
        ]

        // 3. PAUSED (right)
        #place(top + right, dx: -12pt, dy: 6pt)[
          #box(width: 88pt, height: 32pt)[
            #state-box("PAUSED", [توقف موقت], rgb("D97706"), rgb("FFFBEB"))
          ]
        ]

        // --- TOP ROW TRANSITIONS ---
        // READY -> RUNNING (Space)
        #place(top + left, dx: 102pt, dy: 11pt)[
          #line(start: (0pt, 0pt), end: (76pt, 0pt), stroke: 1.1pt + rgb("1D4ED8"))
        ]
        #place(top + left, dx: 174pt, dy: 11pt)[
          #polygon(fill: rgb("1D4ED8"), (0pt, 2pt), (0pt, -2pt), (4pt, 0pt))
        ]
        #place(top + left, dx: 110pt, dy: 0pt)[
          #text(dir: rtl, size: 6.8pt, fill: rgb("1D4ED8"), weight: "bold")[کلید #code-inline("Space")]
        ]

        // RUNNING -> READY (Ball drop with lives remaining: -1 life)
        #place(top + left, dx: 178pt, dy: 27pt)[
          #line(start: (0pt, 0pt), end: (-76pt, 0pt), stroke: 1.1pt + rgb("E11D48"))
        ]
        #place(top + left, dx: 106pt, dy: 27pt)[
          #polygon(fill: rgb("E11D48"), (0pt, 2pt), (0pt, -2pt), (-4pt, 0pt))
        ]
        #place(top + left, dx: 104pt, dy: 29pt)[
          #text(dir: rtl, size: 6.2pt, fill: rgb("E11D48"), weight: "bold")[افتادن توپ؛ کسر ۱ جان]
        ]

        // RUNNING <-> PAUSED (Key P): spans the gap from RUNNING's right edge
        // (x = 282pt) to PAUSED's left edge (container width - 100pt).
        #place(top + left)[
          #layout(size => {
            let clr = rgb("D97706")
            let x-start = 284pt
            let x-end = size.width - 102pt
            let span = x-end - x-start
            place(top + left, dx: x-start, dy: 22pt)[
              #line(start: (0pt, 0pt), end: (span, 0pt), stroke: 1.1pt + clr)
            ]
            place(top + left, dx: x-start + 4pt, dy: 22pt)[
              #polygon(fill: clr, (0pt, 2pt), (0pt, -2pt), (-4pt, 0pt))
            ]
            place(top + left, dx: x-end - 4pt, dy: 22pt)[
              #polygon(fill: clr, (0pt, 2pt), (0pt, -2pt), (4pt, 0pt))
            ]
            place(top + left, dx: x-start, dy: 10pt)[
              #box(width: span)[#align(center)[
                #text(dir: rtl, size: 6.8pt, fill: clr, weight: "bold")[کلید #code-inline("P")]
              ]]
            ]
          })
        ]
        // --- BOTTOM ROW NODES ---
        // 4. GAME_OVER (bottom-left)
        #place(top + left, dx: 65pt, dy: 80pt)[
          #box(width: 115pt, height: 33pt)[
            #state-box("GAME_OVER", [اتمام ۳ جان / ثبت رکورد], rgb("DC2626"), rgb("FEF2F2"))
          ]
        ]

        // 5. VICTORY (bottom-right)
        #place(top + left, dx: 280pt, dy: 80pt)[
          #box(width: 115pt, height: 33pt)[
            #state-box("VICTORY", [تخریب ۴۰ آجر / ثبت رکورد], rgb("059669"), rgb("ECFDF5"))
          ]
        ]

        // --- DOWNWARD TRANSITIONS FROM RUNNING ---
        // RUNNING -> GAME_OVER
        #place(top + left, dx: 205pt, dy: 42pt)[
          #line(start: (0pt, 0pt), end: (-65pt, 36pt), stroke: 1.1pt + rgb("DC2626"))
        ]
        #place(top + left, dx: 140pt, dy: 77pt)[
          #polygon(fill: rgb("DC2626"), (1pt, -3pt), (-3pt, 2pt), (4pt, 2pt))
        ]
        #place(top + left, dx: 66pt, dy: 44pt)[
          #box(width: 110pt)[#align(right)[
            #text(dir: rtl, size: 6.5pt, fill: rgb("DC2626"), weight: "bold")[افتادن توپ؛ جان ۰]
          ]]
        ]

        // RUNNING -> VICTORY
        #place(top + left, dx: 255pt, dy: 42pt)[
          #line(start: (0pt, 0pt), end: (65pt, 36pt), stroke: 1.1pt + rgb("059669"))
        ]
        #place(top + left, dx: 320pt, dy: 77pt)[
          #polygon(fill: rgb("059669"), (-1pt, -3pt), (3pt, 2pt), (-4pt, 2pt))
        ]
        #place(top + left, dx: 284pt, dy: 42pt)[
          #text(dir: rtl, size: 6.5pt, fill: rgb("059669"), weight: "bold")[پاکسازی تمام ۴۰ آجر]
        ]

        // --- BOTTOM RESTART BAR ---
        #place(bottom + center, dy: -2pt)[
          #block(
            width: 100%,
            stroke: (top: 0.6pt + colors.rule),
            inset: (top: 4pt),
            [
              #set align(center)
              #text(dir: rtl, size: 7.2pt, fill: colors.blue, weight: "bold")[
                کلید #code-inline("R") در هر وضعیت، بازی را از نو شروع می‌کند و به #code-inline("READY") برمی‌گرداند. آجرها، جان‌ها و امتیاز جاری ریست می‌شوند و بالاترین رکورد باقی می‌ماند.
              ]
            ]
          )
        ]
      ]
    )
  ]

  #v(2pt)

  #table(
    columns: (1fr, 3fr),
    align: (center, right),
    table.header([*وضعیت*], [*رفتار، شرایط ورود و انتقال‌های مجاز در جریان بازی*]),

    [حالت آماده‌باش\ #code-inline("READY")],
    [
      وضعیت آغاز بازی، و وضعیتی که بعد از افتادن توپ به آن برمی‌گردیم (اگر جان مانده باشد). توپ روی مرکز سکو می‌ماند و همراه سکو حرکت می‌کند. فقط ورودی سکو پردازش می‌شود. با فشردن #code-inline("Space")، شبیه‌سازی شروع می‌شود و بازی به #code-inline("RUNNING") می‌رود.
    ],

    [حالت اجرای فعال\ #code-inline("RUNNING")],
    [
      حلقهٔ اصلی بازی با ۶۰ هرتز اجرا می‌شود: توپ حرکت می‌کند، سکو به کلیدها واکنش نشان می‌دهد و توپ از دیواره‌ها و آجرها برمی‌گردد. اگر لبهٔ پایین توپ از خط پایین بوم رد شود، یک جان کم می‌شود. اگر جان مانده باشد، بازی به #code-inline("READY") برمی‌گردد. با تخریب همهٔ آجرها، وضعیت #code-inline("VICTORY") فعال می‌شود.
    ],

    [توقف موقت\ #code-inline("PAUSED")],
    [
      با #code-inline("P")، محاسبات متوقف می‌شوند و پیام توقف نمایش داده می‌شود. دوباره #code-inline("P") را بزنید تا بازی از همان مکان و با همان سرعت ادامه پیدا کند.
    ],

    [پایان بازی / شکست\ #code-inline("GAME_OVER")],
    [
      لبهٔ پایین توپ از خط پایین بوم رد شود و جانی نمانده باشد. شبیه‌سازی متوقف می‌شود، پیام پایان نمایش داده می‌شود و اگر امتیاز از بالاترین رکورد بیشتر باشد، رکورد ثبت می‌شود. کلید #code-inline("R") بازی را ریست می‌کند.
    ],

    [پیروزی بازیکن\ #code-inline("VICTORY")],
    [
      با تخریب همهٔ ۴۰ آجر فعال می‌شود. توپ می‌ایستد، پیام تبریک و امتیاز نهایی نمایش داده می‌شود و بالاترین رکورد ذخیره می‌شود. کلید #code-inline("R") یک بازی تازه را شروع می‌کند.
    ],
  )

  #v(3pt)

  #block(
    fill: rgb("FAFDFE"),
    stroke: (right: 3.5pt + colors.blue),
    radius: 3pt,
    inset: (x: 10pt, y: 7pt),
    width: 100%,
    [
      #text(weight: "bold", size: type-scale.small, fill: colors.blue)[پیاده‌سازی تمیز وضعیت‌ها با ساختار شمارشی #code-inline("enum")]
      #v(2.5pt)
      #text(size: type-scale.small)[
        به جای چند متغیر بولی مثل #code-inline("isPaused") یا #code-inline("isGameOver")، وضعیت بازی را با #code-inline("enum GameState") و ۵ مقدار بالا نشان دهید. در #code-inline("READY") فقط سکو و توپ چسبیده به آن به‌روز می‌شوند. فیزیک و برخورد فقط در #code-inline("RUNNING") اجرا می‌شوند. این جداسازی جلوی بسیاری از باگ‌های منطقی را می‌گیرد.
      ]
    ]
  )
]
