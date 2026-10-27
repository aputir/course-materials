#import "../../course/theme.typ": *

#let breakout-tech-stack-page() = [
  = بستر فنی و نسخهٔ جاوا

  پیاده‌سازی فاز اول باید با زبان جاوا#footnote[#en[Java]] و یک کتابخانهٔ گرافیکی باشد که در محیط درس اجرا شود. *مسیر رسمی درس:* #en[ACM]#footnote[#en[ACM: Java Task Force]] + #en[Swing] روی *#en[Java 11]* است. اگر از بستر دیگری استفاده می‌کنید، آن را در README ثبت کنید. این بسترها مجازند، اما دستیاران در رفع اشکال آن‌ها امکان کمتری دارند.

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
    [#en[11 LTS]],
    [
      از کلاس‌های #code-inline("acm.program.GraphicsProgram") و #code-inline("acm.graphics.*") استفاده کنید. فایل #code-inline("acm.jar") را در classpath قرار دهید.
    ],

    [#en[Swing] خالص],
    [#en[11] تا #en[21]],
    [
      بدون #en[ACM]، با #code-inline("JPanel")، #code-inline("Timer") و نقاشی دستی کار کنید. بافر دوگانه#footnote[#en[Double Buffering]] را خودتان مدیریت می‌کنید.
    ],

    [#en[JavaFX]],
    [#en[17] یا #en[21]],
    [
      از #code-inline("Canvas") یا #code-inline("Pane") استفاده کنید. ماژول‌های #en[JavaFX] را خودتان به پروژه اضافه کنید.
    ],

    [#en[Processing]],
    [#en[17]],
    [
      از حالت #en[Java] با #code-inline("setup") و #code-inline("draw") استفاده کنید. معماری MVC را خودتان طراحی کنید.
    ],
  )

  #v(2pt)

  #en[Java 8] هم با همان #code-inline("acm.jar") در بسیاری از محیط‌های درس کار می‌کند. #en[JavaFX] از #en[JDK 11] به بعد جدا از JDK توزیع می‌شود و #en[Processing 4] بر پایهٔ #en[JDK 17] است.

  #note[آزادی در چیدمان و ظاهر][
    ابعاد، مختصات و رفتارهایی که در این سند آمده برای موجودیت‌ها و فیزیک الزامی‌اند. رنگ آجرها، فونت پیام‌ها، چیدمان نوار وضعیت، نماد جان‌ها و هر بخش بصری بدون عدد یا فرمول را آزادانه انتخاب کنید. فقط خوانایی و روانی ۶۰ هرتز باید حفظ شود.
  ]
]
