#import "../../course/theme.typ": *

#let breakout-lifecycle-page() = [
  = ماشین وضعیت و چرخهٔ حیات بازی (#en[State Machine])

  مدیریت تعاملات و جریان بازی نیازمند یک ماشین حالت متناهی (#term[FSM]) شفاف است تا رفتار موتور در واکنش به رخدادهای صفحه‌کلید، از دست رفتن جان یا اتمام آجرها به شکلی قطعی و بدون تداخل هدایت شود:

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
            #text(size: 7.5pt, fill: colors.ink)[شبیه‌سازی #latin-number("60 FPS")]
          ]),
          [
            #text(size: 8pt, fill: colors.blue)[#sym.arrow.l.r]\
            #text(size: 6.5pt, fill: colors.muted)[کلید #code-inline("P")]
          ],
          block(fill: colors.white, stroke: 0.8pt + colors.muted, radius: 3pt, inset: (x: 5pt, y: 5pt), [
            #text(weight: "bold", size: 9pt)[#code-inline("PAUSED")] \
            #v(1pt)
            #text(size: 7.5pt, fill: colors.muted)[توقف موقت و پرده]
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
            #text(size: 6.5pt, fill: colors.muted)[بررسی پایان هر فریم شبیه‌سازی]
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
            #text(size: 7.5pt, fill: colors.ink)[اتمام ۳ جان (#math-inline($ "Lives" = 0 $))] \
            #text(size: 6.5pt, fill: colors.muted)[ثبت رکورد در حافظه]
          ]),
          [
            #line(length: 100%, stroke: 0.5pt + colors.rule)
          ],
          block(fill: rgb("EAFAF1"), stroke: 0.8pt + rgb("27AE60"), radius: 3pt, inset: (x: 6pt, y: 5pt), [
            #text(weight: "bold", size: 8.5pt, fill: rgb("1E8449"))[#code-inline("VICTORY")] \
            #v(1pt)
            #text(size: 7.5pt, fill: colors.ink)[تخریب ۴۰ آجر (#math-inline($ "Bricks" = 0 $))] \
            #text(size: 6.5pt, fill: colors.muted)[ثبت رکورد در حافظه]
          ]),
        )

        #v(3pt)

        #block(
          width: 100%,
          stroke: (top: 0.5pt + colors.blue),
          inset: (top: 3pt),
          [
            #set align(center)
            #text(size: 7.5pt, fill: colors.blue)[#sym.arrow.l.long #h(4pt) فشردن کلید #code-inline("R") در هر وضعیت: شروع مجدد بازی و بازگشت به وضعیت #code-inline("READY") #h(4pt) #sym.arrow.l.long]
          ]
        )
      ]
    )
  ]

  #v(1pt)

  #table(
    columns: (0.9fr, 3.1fr),
    align: (center, right),
    table.header([*وضعیت*], [*شرح رفتار و گذارهای مجاز*]),
    [#code-inline("READY")],
    [حالت آغازین بازی یا پس از هربار سوختن جان؛ توپ به مرکز سکو چسبیده و همگام با آن جابه‌جا می‌شود. فشردن کلید #code-inline("Space") بردار سرعت اولیه را فعال کرده و بازی را وارد وضعیت #code-inline("RUNNING") می‌کند.],
    [#code-inline("RUNNING")],
    [وضعیت اصلی شبیه‌سازی با نرخ نوسازی ۶۰ هرتز؛ جابه‌جایی سکو با کلیدهای جهت‌نما، محاسبات فیزیک توپ، بازتاب از دیواره‌ها و تخریب آجرها در این حالت فعال است.],
    [#code-inline("PAUSED")],
    [با فشردن کلید #code-inline("P") شبیه‌سازی فیزیک متوقف شده و یک پردهٔ نیمه‌شفاف با نشان #latin-number("PAUSED") روی بوم ظاهر می‌شود. فشردن مجدد #code-inline("P") بازی را ادامه می‌دهد.],
    [#code-inline("GAME_OVER")],
    [با سقوط توپ از کف و اتمام ۳ جان رخ می‌دهد؛ شبیه‌سازی متوقف، پیام باخت نمایش، بالاترین امتیاز در منبع ذخیره‌سازی ثبت و کلید #code-inline("R") بازی را از نو راه‌اندازی می‌کند.],
    [#code-inline("VICTORY")],
    [با تخریب هر ۴۰ آجر فعال می‌شود؛ پیام پیروزی نمایش داده شده، رکورد نهایی ثبت و کلید #code-inline("R") زمین را برای بازی جدید بازنشانی می‌کند.],
  )

  = گام‌های پنج‌گانهٔ پیاده‌سازی گام‌به‌گام (#en[Milestones])

  برای جلوگیری از سردرگمی در توسعه، فرآیند پیاده‌سازی به ۵ فاز مشخص با معیارهای اعتبارسنجی مستقل تفکیک شده است:

  #set text(size: 8.5pt)

  + *گام اول (پنجره، بوم و سکوی مهارشده):* راه‌اندازی پنجره به ابعاد #math-inline($800 times 600$)، ساخت کلاس سکو (#code-inline("Paddle")) و کنترل با کلیدهای چپ و راست.\
    _معیار پذیرش:_ سکو با کلیدهای جهت‌نما نرم حرکت کند و تابع #code-inline("clampToScreen") مانع خروج آن از مرزهای چپ و راست شود.
  + *گام دوم (حرکت توپ، بازتاب دیواره‌ها و پرتاب دستی):* پیاده‌سازی کلاس توپ (#code-inline("Ball"))، بازتاب از ۳ دیواره و حالت سکون روی سکو.\
    _معیار پذیرش:_ توپ در وضعیت آماده‌باش همراه با سکو حرکت کند و پس از فشردن #code-inline("Space")، با زاویه به سمت بالا پرتاب شود.
  + *گام سوم (بازتاب زاویه‌دار از سکو و چرخهٔ ۳ جان):* پیاده‌سازی فرمول انحراف زاویه‌دار از سکو ($[-60^degree, +60^degree]$) و مدیریت قلب‌های جان در #en[HUD].\
    _معیار پذیرش:_ با عبور توپ از کف صفحه، یک جان کسر و یک قلب حذف شود؛ توپ مجدداً در وضعیت آماده‌باش روی سکو قرار گیرد.
  + *گام چهارم (چیدمان ماتریس آجرها، برخورد #term[AABB] و ثبت امتیاز):* ترسیم ۴۰ آجر ($5 times 8$)، تشخیص برخورد و افزایش امتیاز (+۱۰۰).\
    _معیار پذیرش:_ برخورد با هر آجر موجب حذف فوری آن و بازتاب صحیح توپ شود؛ بیشترین امتیاز در شیء #code-inline("InMemoryScoreStorage") ذخیره گردد.
  + *گام پنجم (ماشین وضعیت جامع، پرده‌های نمایشی و شروع مجدد):* یکپارچه‌سازی متغیر #code-inline("GameState")، پرده‌های گرافیکی و شروع مجدد با کلید #code-inline("R").\
    _معیار پذیرش:_ باخت با ۳ خطا، برد با شکستن ۴۰ آجر، توقف موقت با #code-inline("P") و بازنشانی کامل بازی با کلید #code-inline("R") بدون خطای زمان اجرا.

  #set text(size: type-scale.body)

  = بخش‌های اختیاری و امتیازی (#en[Bonus Features])

  - *آجرهای مقاوم با دو جان (#latin-number("+10") نمره):* تعریف نوعی آجر ویژه در سطرهای بالایی که برای تخریب به #latin-number("2") برخورد پیاپی نیاز دارند. ضربهٔ نخست موجب تغییر رنگ یا نمایش ترک‌خوردگی دیداری شده و ضربهٔ دوم آجر را از بین می‌برد (+۲۰۰ امتیاز).
  - *تعویض پویای روش ذخیره‌سازی داده (#latin-number("+5") نمره):* امکان جابه‌جایی بلادرنگ نوع ذخیره‌ساز رکورد در کنترلر بین حافظهٔ موقت (#code-inline("InMemoryScoreStorage")) و فایل دیسک با فشردن کلید درون بازی (بدون نیاز به راه‌اندازی مجدد برنامه).
]
