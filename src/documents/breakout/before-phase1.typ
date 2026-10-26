#import "../../course/theme.typ": *

#let breakout-before-phase1-page() = [
  = اقدامات پیش از شروع

  قبل از اینکه سراغ نوشتن اولین خط کد در جاوا بروید، برداشتن ۳ گام مقدماتی زیر مسیر را برایتان کاملاً هموار و لذت‌بخش می‌کند:

  #v(2pt)

  == ۱. راه‌اندازی گیت‌هاب و ساختار پروژه
  نخستین قدم، ایجاد یک مخزن در گیت‌هاب (#en[GitHub]) است. یک پروژه حرفه‌ای با ساختار پوشه‌بندی استاندارد و ثبت منظم تاریخچه تغییرات شناخته می‌شود:

  #list(
    [
      *ساختار پوشه‌بندی استاندارد:* کلاس‌های پروژه را در بسته‌های مجزا مرتب کنید:
      - پوشه #code-inline("src/model/"): کلاس‌های وضعیت و منطق بازی (#code-inline("Ball")، #code-inline("Paddle")، #code-inline("Brick") و #code-inline("GameState")).
      - پوشه #code-inline("src/view/"): کدهای رندر و واسط گرافیکی (#code-inline("BreakoutCanvas") و #code-inline("HUD")).
      - پوشه #code-inline("src/controller/"): موتور هدایت و شنونده کلیدها (#code-inline("GameEngine") و #code-inline("Main")).
      - پوشه #code-inline("src/util/"): مقادیر ثابت و ابزارها (#code-inline("GameConstants")).
    ],
    [
      *تنظیم گیت ایگنور برای تمیزی مخزن:*\
      فایل‌های موقت، خروجی‌های کامپایل #code-inline(".class") و تنظیمات ویرایشگر را درون فایل #code-inline(".gitignore") بگذارید تا مخزن گیت‌هاب شما همیشه سبک و پاکیزه بماند.
    ],
    [
      *نگارش فایل راهنما (#en[README.md]):*\
      در این فایل نام و شماره دانشجویی خودتان، نسخه جاوا و دستور اجرای بازی را ثبت کنید.
    ],
    [
      *کامیت‌های استاندارد (#en[Conventional Commits]):*\
      تغییرات را در گام‌های کوچک و شفاف کامیت کنید؛ مانند #code-inline("feat: add paddle") یا #code-inline("fix: ball bounce").
    ],
  )

  #v(2pt)

  == ۲. تجربه بازی و درک رفتار فیزیکی
  برای اینکه درک درستی از حس بازی و مکانیک‌های آن پیدا کنید، حتماً قبل از شروع کدنویسی چند دقیقه یک نسخه آنلاین از بریک‌اوت را تجربه کنید:

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 6pt,
    block(
      fill: colors.pale,
      stroke: 0.5pt + colors.rule,
      radius: 3pt,
      inset: (x: 6pt, y: 5pt),
      width: 100%,
      [
        #text(size: type-scale.small, weight: "bold", fill: colors.blue)[زاویه کمانه توپ]
        #v(2pt)
        #text(size: 8.5pt)[توپ در مرکز سکو بازتابی ملایم دارد و در کناره‌ها با زاویه تند پرتاب می‌شود.]
      ]
    ),
    block(
      fill: colors.pale,
      stroke: 0.5pt + colors.rule,
      radius: 3pt,
      inset: (x: 6pt, y: 5pt),
      width: 100%,
      [
        #text(size: type-scale.small, weight: "bold", fill: colors.blue)[روانی حرکت (۶۰ هرتز)]
        #v(2pt)
        #text(size: 8.5pt)[پاسخ آنی سکو به کلیدها و حرکت روان و نرم توپ بدون لگ یا پرش تصویری.]
      ]
    ),
    block(
      fill: colors.pale,
      stroke: 0.5pt + colors.rule,
      radius: 3pt,
      inset: (x: 6pt, y: 5pt),
      width: 100%,
      [
        #text(size: type-scale.small, weight: "bold", fill: colors.blue)[رفتار برخورد آجرها]
        #v(2pt)
        #text(size: 8.5pt)[محو شدن سریع آجر پس از اصابت، بازتاب لحظه‌ای توپ و ثبت امتیاز ۱۰۰ عددی.]
      ]
    ),
  )

  #v(2pt)

  == ۳. طراحی مدل شی‌گرا (نمودار UML)
  یک طراحی خوب روی کاغذ، جلوی ساعت‌ها سردرگمی در کدنویسی را می‌گیرد:

  #grid(
    columns: (1.2fr, 1fr),
    gutter: 8pt,
    block(
      fill: colors.pale,
      stroke: (right: 2.5pt + colors.blue),
      radius: 3pt,
      inset: (x: 8pt, y: 6pt),
      width: 100%,
      [
        #text(weight: "bold", size: type-scale.small, fill: colors.blue)[ترسیم نمودار کلاس (#en[UML Diagram])]
        #v(2pt)
        #text(size: 8.5pt)[پیشنهاد می‌کنیم با ابزارهایی مثل #en[Draw.io]، نام کلاس‌ها، فیلدهای خصوصی و متدهای عمومی را قبل از نوشتن کد مشخص کنید تا نقشه ذهنی روشنی داشته باشید.]
      ]
    ),
    block(
      fill: colors.pale,
      stroke: (right: 2.5pt + colors.muted),
      radius: 3pt,
      inset: (x: 8pt, y: 6pt),
      width: 100%,
      [
        #text(weight: "bold", size: type-scale.small, fill: colors.ink)[وضعیت در ارزیابی فاز اول]
        #v(2pt)
        #text(size: 8.5pt)[تحویل نمودار در فاز اول *اختیاری* است؛ اما رسم آن به تسلط شخصی شما در جلسه مصاحبه دفاع کمک شایانی خواهد کرد.]
      ]
    ),
  )
]
