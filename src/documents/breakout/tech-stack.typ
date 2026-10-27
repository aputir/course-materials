#import "../../course/theme.typ": *

#let breakout-tech-stack-page() = [
  = بستر فنی و نسخهٔ جاوا

  پیاده‌سازی فاز اول باید به زبان جاوا#footnote[#en[Java]] و با کتابخانهٔ گرافیکی قابل اجرا در محیط درس باشد. *مسیر رسمی درس:* #en[ACM]#footnote[#en[ACM: Java Task Force]] + #en[Swing] روی *جاوا ۱۱*. بسترهای دیگر در صورت ثبت در README مجازند؛ پشتیبانی دستیاران در رفع اشکال برای آن‌ها محدود‌تر است.

  #v(2pt)

  #table(
    columns: (1.1fr, 1.4fr, 2fr),
    align: (right, center, right),
    table.header(
      [*بستر*],
      [*نسخهٔ جاوا*],
      [*یادداشت*],
    ),

    [
      #en[ACM] + #en[Swing] — مسیر رسمی
    ],
    [۱۱ LTS],
    [
      #code-inline("acm.program.GraphicsProgram") و #code-inline("acm.graphics.*"). فایل #code-inline("acm.jar") را در classpath کامپایل و اجرا قرار دهید.
    ],

    [#en[Swing] خالص],
    [۱۱ تا ۲۱],
    [
      بدون #en[ACM]: #code-inline("JPanel")، #code-inline("Timer") و نقاشی دستی. مسئولیت بافر دوگانه#footnote[#en[Double Buffering]] با شماست.
    ],

    [#en[JavaFX]],
    [۱۷ یا ۲۱],
    [
      #code-inline("Canvas") یا #code-inline("Pane"). ماژول‌های #en[JavaFX] را خودتان به پروژه اضافه کنید.
    ],

    [#en[Processing]],
    [۱۷],
    [
      حالت #en[Java]: #code-inline("setup") و #code-inline("draw"). معماری MVC را خودتان ساختاردهی کنید.
    ],
  )

  #v(2pt)

  جاوا ۸ نیز با همان #code-inline("acm.jar") در بسیاری از محیط‌های درس کار می‌کند. #en[JavaFX] از JDK ۱۱ به بعد جدا از JDK توزیع می‌شود و #en[Processing 4] بر پایهٔ JDK ۱۷ است.

  #note[آزادی در چیدمان و ظاهر][
    ابعاد، مختصات و رفتارهای ذکر‌شده در این سند برای موجودیت‌ها و فیزیک الزامی‌اند. رنگ آجرها، فونت پیام‌ها، چیدمان نوار وضعیت، نماد جان‌ها و هر جزئی بصری که عدد یا فرمول ندارد را آزادانه و سلیقه‌ای انتخاب کنید؛ فقط خوانایی و روانی ۶۰ هرتز را حفظ کنید.
  ]
]
