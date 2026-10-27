#import "../../course/theme.typ": *

#let breakout-rules-gameplay-page() = [
  = سازوکار گیم‌پلی و وضعیت‌ها

  مدیریت جریان بازی با یک ماشین وضعیت متناهی و شفاف پیاده‌سازی می‌شود تا واکنش بازی به کلیدها، برخوردها و رویدادهای مرگ و پیروزی کاملاً ساختاریافته و پیش‌بینی‌پذیر باشد:

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
          #line(start: (0pt, 0pt), end: (74pt, 0pt), stroke: 1.1pt + rgb("1D4ED8"))
        ]
        #place(top + left, dx: 172pt, dy: 9pt)[
          #polygon(fill: rgb("1D4ED8"), (0pt, 2pt), (0pt, -2pt), (4pt, 0pt))
        ]
        #place(top + left, dx: 110pt, dy: 0pt)[
          #text(dir: rtl, size: 6.8pt, fill: rgb("1D4ED8"), weight: "bold")[کلید #code-inline("Space")]
        ]

        // RUNNING -> READY (Ball drop with lives remaining: -1 life)
        #place(top + left, dx: 176pt, dy: 27pt)[
          #line(start: (0pt, 0pt), end: (-74pt, 0pt), stroke: 1.1pt + rgb("E11D48"))
        ]
        #place(top + left, dx: 106pt, dy: 25pt)[
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
                فشردن کلید #code-inline("R") در هر وضعیت: راه‌اندازی مجدد بازی و بازگشت به #code-inline("READY") — ریست ۴۰ آجر، ۳ جان و امتیاز جاری؛ بالاترین رکورد حفظ می‌شود
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
      وضعیت نخستین بازی یا پس از هر بار سوختن یک جان، در صورت داشتن جان باقی‌مانده. توپ روی مرکز سکو مستقر است و همراه با آن جابه‌جا می‌شود؛ فقط ورودی سکو و چسبیدن توپ پردازش می‌شود. با #code-inline("Space") شبیه‌سازی شروع و بازی وارد وضعیت اجرا می‌شود.
    ],

    [حالت اجرای فعال\ #code-inline("RUNNING")],
    [
      حلقه اصلی شبیه‌سازی بلادرنگ ۶۰ هرتز؛ حرکت پیوسته توپ، فرمان‌پذیری سکو، بازتاب از دیواره‌ها و انهدام آجرها. وقتی لبهٔ پایین توپ از خط پایین بوم عبور کند، یک جان کم می‌شود و در صورت باقی‌ماندن جان به #code-inline("READY") برمی‌گردید؛ با تخریب تمام آجرها وضعیت پیروزی فعال می‌شود.
    ],

    [توقف موقت\ #code-inline("PAUSED")],
    [
      با فشردن کلید #code-inline("P") در حین بازی، محاسبات متوقف شده و پیام توقف روی صفحه ظاهر می‌شود. فشردن مجدد همین کلید شبیه‌سازی را دقیقاً از همان مختصات و با همان بردار سرعت پیشین ادامه می‌دهد.
    ],

    [پایان بازی / شکست\ #code-inline("GAME_OVER")],
    [
      وقتی لبهٔ پایین توپ از خط پایین بوم عبور کند و جان باقی نمانده باشد. شبیه‌سازی متوقف می‌شود، پیام پایان نمایش داده می‌شود و در صورت برتری امتیاز، بالاترین رکورد ثبت می‌شود. کلید #code-inline("R") بازی را ریست می‌کند.
    ],

    [پیروزی بازیکن\ #code-inline("VICTORY")],
    [
      به محض انهدام کامل تمام ۴۰ آجر فعال می‌شود. حرکت توپ متوقف شده، پیام تبریک و امتیاز نهایی بازیکن نمایش داده شده و بالاترین رکورد ذخیره می‌گردد. فشردن کلید #code-inline("R") امکان آغاز یک بازی جدید را فراهم می‌سازد.
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
        به جای متغیرهای بولی پراکنده مانند #code-inline("isPaused") یا #code-inline("isGameOver")، حالت بازی را با #code-inline("enum GameState") و ۵ مقدار بالا مدل‌سازی کنید. در #code-inline("READY") فقط ورودی سکو و مهار توپ را به‌روز کنید؛ محاسبات فیزیک و برخورد فقط در #code-inline("RUNNING") پیش می‌رود. این تفکیک از باگ‌های منطقی رایج جلوگیری می‌کند.
      ]
    ]
  )
]
