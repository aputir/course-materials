#import "../../course/theme.typ": *

#let breakout-entities-page() = [
  = موجودیت‌ها و هندسه بازی

  جهان بریک‌اوت از ۴ موجودیت اصلی تشکیل شده که هر کدام قوانین و هندسه خاص خود را دارند. مختصات صفحه از گوشه بالا-چپ $(0,0)$ آغاز می‌شود و تمام ابعاد بر حسب پیکسل محاسبه می‌گردند:

  #v(1pt)

  #align(center)[
    #block(
      width: 100%,
      height: 98pt,
      fill: rgb("0F172A"),
      radius: 4pt,
      stroke: 0.8pt + colors.blue,
      inset: (x: 10pt, y: 7pt),
      [
        #place(top + left)[
          #text(size: 7.5pt, fill: rgb("38BDF8"))[#en[(0, 0)]]
        ]
        #place(top + center)[
          #text(size: 7.5pt, fill: rgb("E2EDF4"))[نوار بالا (HUD): ۳ قلب جان #h(4pt) | #h(4pt) امتیاز: ۱۰۰ #h(4pt) | #h(4pt) رکورد: ۵۰۰]
        ]
        #place(top + right)[
          #text(size: 7.5pt, fill: rgb("38BDF8"))[#en[(800, 0)]]
        ]
        
        #place(top + center, dy: 15pt)[
          #grid(
            columns: (1fr,) * 8,
            rows: (4.5pt,) * 3,
            gutter: 3pt,
            ..range(24).map(i => {
              let clr = if i < 8 { rgb("EF4444") } else if i < 16 { rgb("F59E0B") } else { rgb("10B981") }
              rect(width: 100%, height: 100%, fill: clr, radius: 1pt)
            })
          )
        ]
        #place(top + center, dy: 35pt)[
          #text(size: 6.5pt, fill: rgb("94A3B8"))[شبکه ۴۰ آجر در ۵ سطر (ابعاد ۸۵×۲۵ px با فاصله ۶ px)]
        ]

        #place(top + center, dy: 49pt, dx: -45pt)[
          #circle(radius: 4.5pt, fill: rgb("FACC15"), stroke: 0.6pt + white)
        ]
        #place(top + center, dy: 47pt, dx: 30pt)[
          #text(size: 7pt, fill: rgb("FACC15"))[توپ: قطر ۱۶ px با بردار سرعت (#en[vx, vy])]
        ]

        #place(bottom + center, dy: -5pt)[
          #rect(width: 80pt, height: 8pt, fill: rgb("38BDF8"), radius: 2pt)
        ]
        #place(bottom + center, dy: -17pt)[
          #text(size: 7pt, fill: rgb("7DD3FC"))[سکو: ۱۰۰×۱۵ px (حرکت افقی با مهار در لبه‌ها)]
        ]
        #place(bottom + left, dy: -2pt)[
          #text(size: 6.5pt, fill: rgb("94A3B8"))[فاصله از کف: ۴۰ px]
        ]
        #place(bottom + right, dy: -2pt)[
          #text(size: 7.5pt, fill: rgb("38BDF8"))[#en[(800, 600)]]
        ]
      ]
    )
  ]

  #v(2pt)

  #grid(
    columns: (1fr, 1fr),
    gutter: 7pt,
    block(
      fill: colors.pale,
      stroke: (right: 3pt + colors.blue),
      radius: 3pt,
      inset: (x: 8pt, y: 6pt),
      width: 100%,
      [
        #text(weight: "bold", size: type-scale.small, fill: colors.blue)[سکو (#code-inline("Paddle"))]
        #v(2pt)
        #text(size: 8.5pt)[
          مستطیلی به ابعاد ۱۰۰ در ۱۵ پیکسل در فاصله ۴۰ پیکسلی از پایین صفحه. جابه‌جایی منحصراً افقی با کلیدهای چپ و راست، همراه با تابع مهار موقعیت برای جلوگیری از خروج از کادر.
        ]
      ]
    ),
    block(
      fill: colors.pale,
      stroke: (right: 3pt + rgb("F59E0B")),
      radius: 3pt,
      inset: (x: 8pt, y: 6pt),
      width: 100%,
      [
        #text(weight: "bold", size: type-scale.small, fill: rgb("D97706"))[توپ (#code-inline("Ball"))]
        #v(2pt)
        #text(size: 8.5pt)[
          دایره‌ای به قطر ۱۶ پیکسل (شعاع ۸) با بردار سرعت پیوسته. در شروع بازی و پس از سوختن، روی مرکز سکو می‌نشیند و تنها با زدن کلید فاصله پرتاب می‌شود.
        ]
      ]
    ),
    block(
      fill: colors.pale,
      stroke: (right: 3pt + rgb("10B981")),
      radius: 3pt,
      inset: (x: 8pt, y: 6pt),
      width: 100%,
      [
        #text(weight: "bold", size: type-scale.small, fill: rgb("059669"))[آجرها (#code-inline("Brick"))]
        #v(2pt)
        #text(size: 8.5pt)[
          شبکه‌ای در ۵ سطر و ۸ ستون (مجموعاً ۴۰ آجر) به ابعاد ۸۵ در ۲۵ پیکسل با فاصله ۶ پیکسل. با اصابت توپ، آجر محو شده و ۱۰۰ امتیاز به بازیکن داده می‌شود.
        ]
      ]
    ),
    block(
      fill: colors.pale,
      stroke: (right: 3pt + colors.ink),
      radius: 3pt,
      inset: (x: 8pt, y: 6pt),
      width: 100%,
      [
        #text(weight: "bold", size: type-scale.small, fill: colors.ink)[نشانگر وضعیت (#code-inline("HUD"))]
        #v(2pt)
        #text(size: 8.5pt)[
          نوار بالایی صفحه که در جریان بازی ۳ قلب جان و امتیاز را نشان می‌دهد و پس از برد یا باخت، پیام پایان و رکورد ذخیره‌شده را به تصویر می‌کشد.
        ]
      ]
    )
  )

  #v(2pt)

  == اصول طراحی شی‌گرا و کپسوله‌سازی

  #list(
    [
      *فیلدهای کاملاً خصوصی:* تعریف تمام متغیرهای مختصات، ابعاد و بردار سرعت با سطح دسترسی #code-inline("private") تا هیچ کلاسی نتواند مستقیماً حالت درونی شیء دیگر را دستکاری کند.
    ],
    [
      *ارائه رفتارهای معنادار:* پیاده‌سازی متدهایی با منطق روشن مانند حرکت به چپ، بازتاب عمودی و بررسی برخورد به جای قرار دادن توابع تغییردهنده خام.
    ],
    [
      *ثابت‌های نام‌گذاری‌شده:* تجمیع ابعاد پنجره، سرعت پایه توپ، امتیاز هر آجر و فواصل در کلاس #code-inline("GameConstants") برای پرهیز جدی از اعداد جادویی (#en[Magic Numbers]).
    ],
  )
]
