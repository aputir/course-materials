#import "../../course/theme.typ": *

#let breakout-rules-gameplay-page() = [
  = سازوکار گیم‌پلی و وضعیت‌ها

  مدیریت جریان بازی با یک ماشین وضعیت متناهی و بسیار شفاف پیاده‌سازی می‌شود تا واکنش بازی به کلیدها، برخوردها و باخت جان‌ها کاملاً منظم و قابل پیش‌بینی باشد:

  #v(spacing.element)

  #align(center)[
    #block(
      fill: colors.pale,
      stroke: 0.6pt + colors.rule,
      radius: 4pt,
      inset: (x: 10pt, y: 7pt),
      width: 100%,
      [
        #set text(dir: ltr)
        #grid(
          columns: (1.2fr, 0.7fr, 1.4fr, 0.7fr, 1.1fr),
          align: horizon + center,
          gutter: 4pt,
          block(fill: colors.white, stroke: 0.8pt + colors.blue, radius: 3pt, inset: (x: 5pt, y: 5pt), [
            #text(weight: "bold", size: 9pt)[#code-inline("READY")] \
            #v(1pt)
            #text(size: 7.5pt, fill: colors.muted)[آماده‌باش / پرتاب]
          ]),
          [
            #text(size: 8pt, fill: colors.blue)[#sym.arrow.r]\
            #text(size: 6.5pt, fill: colors.muted)[#code-inline("Space")]
          ],
          block(fill: rgb("EBF5FB"), stroke: 1.2pt + colors.blue, radius: 3pt, inset: (x: 5pt, y: 5pt), [
            #text(weight: "bold", size: 9.5pt, fill: colors.blue)[#code-inline("RUNNING")] \
            #v(1pt)
            #text(size: 7.5pt, fill: colors.ink)[شبیه‌سازی ۶۰ هرتز]
          ]),
          [
            #text(size: 8pt, fill: colors.blue)[#sym.arrow.l.r]\
            #text(size: 6.5pt, fill: colors.muted)[کلید #code-inline("P")]
          ],
          block(fill: colors.white, stroke: 0.8pt + colors.muted, radius: 3pt, inset: (x: 5pt, y: 5pt), [
            #text(weight: "bold", size: 9pt)[#code-inline("PAUSED")] \
            #v(1pt)
            #text(size: 7.5pt, fill: colors.muted)[توقف موقت شبیه‌سازی]
          ]),
        )

        #v(3pt)

        #grid(
          columns: (1fr, 1.4fr, 1fr),
          align: horizon + center,
          gutter: 6pt,
          [],
          [
            #text(size: 7.5pt, fill: colors.ink)[#sym.arrow.b]\
            #text(size: 6.5pt, fill: colors.muted)[بررسی پایان هر گام شبیه‌سازی]
          ],
          [],
        )

        #v(2pt)

        #grid(
          columns: (1.3fr, 0.4fr, 1.3fr),
          align: horizon + center,
          gutter: 8pt,
          block(fill: rgb("FDEDEC"), stroke: 0.8pt + rgb("E74C3C"), radius: 3pt, inset: (x: 6pt, y: 5pt), [
            #text(weight: "bold", size: 8.5pt, fill: rgb("C0392B"))[#code-inline("GAME_OVER")] \
            #v(1pt)
            #text(size: 7.5pt, fill: colors.ink)[اتمام ۳ جان بازی] \
            #text(size: 6.5pt, fill: colors.muted)[پایان دور و ثبت رکورد]
          ]),
          [
            #line(length: 100%, stroke: 0.5pt + colors.rule)
          ],
          block(fill: rgb("EAFAF1"), stroke: 0.8pt + rgb("27AE60"), radius: 3pt, inset: (x: 6pt, y: 5pt), [
            #text(weight: "bold", size: 8.5pt, fill: rgb("1E8449"))[#code-inline("VICTORY")] \
            #v(1pt)
            #text(size: 7.5pt, fill: colors.ink)[تخریب تمامی ۴۰ آجر] \
            #text(size: 6.5pt, fill: colors.muted)[پیروزی قاطع و ثبت رکورد]
          ]),
        )

        #v(3pt)

        #block(
          width: 100%,
          stroke: (top: 0.5pt + colors.blue),
          inset: (top: 3pt),
          [
            #set align(center)
            #text(size: 7.5pt, fill: colors.blue)[#sym.arrow.l.long #h(4pt) فشردن کلید #code-inline("R") در هر وضعیت: راه‌اندازی مجدد فوری بازی و بازگشت به وضعیت آغازین #h(4pt) #sym.arrow.l.long]
          ]
        )
      ]
    )
  ]

  #v(2pt)

  #table(
    columns: (0.9fr, 3.1fr),
    align: (center, right),
    table.header([*وضعیت*], [*رفتار و انتقال‌های مجاز در جریان بازی*]),

    [حالت آماده‌باش\ #code-inline("READY")],
    [
      وضعیت نخستین بازی یا پس از هربار سوختن یک جان؛ توپ در مرکز سکو مهار شده و همراه با آن جابه‌جا می‌شود. با فشردن کلید فاصله، بردار سرعت اولیه فعال شده و بازی وارد وضعیت اجرا می‌شود.
    ],

    [حالت اجرای فعال\ #code-inline("RUNNING")],
    [
      حلقه اصلی شبیه‌سازی بلادرنگ؛ حرکت پیوسته توپ، واکنش سکو به کلیدهای چپ و راست، بازتاب از دیواره‌ها و انهدام آجرها در این حالت انجام می‌پذیرد.
    ],

    [توقف موقت\ #code-inline("PAUSED")],
    [
      با فشردن کلید پی شبیه‌سازی متوقف و پیام توقف موقت روی صفحه نمایان می‌شود. فشردن دوباره همین کلید، شبیه‌سازی را بدون پرش زمانی یا برهم خوردن موقعیت اشیا ادامه می‌دهد.
    ],

    [پایان بازی / شکست\ #code-inline("GAME_OVER")],
    [
      با سقوط توپ از کف صفحه و اتمام ۳ جان رخ می‌دهد. موتور متوقف شده، پیام پایان بازی به نمایش درمی‌آید، بالاترین امتیاز در منبع ذخیره ثبت شده و فشردن کلید آر بازی را از نو شروع می‌کند.
    ],

    [پیروزی بازیکن\ #code-inline("VICTORY")],
    [
      با پاکسازی کامل تمامی ۴۰ آجر فعال می‌شود. پیام تبریک و پیروزی به همراه امتیاز نهایی نمایش داده شده و کلید آر امکان شروع یک دور تازه را فراهم می‌سازد.
    ],
  )
]
