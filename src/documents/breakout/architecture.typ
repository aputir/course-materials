#import "../../course/theme.typ": *

#let breakout-architecture-page() = [
  = ساختار و معماری سیستم

  فرض کنید کل بازی در یک کلاس ۲۵۰۰ خطی نوشته شده باشد: سرعت توپ، برخورد با دیواره، رنگ آجرها و شنیدن کلید #code-inline("Space")، همه در یک جا. با اولین خطای پنهان، پیدا کردن علت خیلی سخت می‌شود. برای جلوگیری از این وضعیت، الگوی مدل-نما-کنترل‌گر#footnote[#en[MVC: Model-View-Controller]] وظایف را میان سه بخش مستقل تقسیم می‌کند:

  #v(2pt)

  #let mvc-card(title, en-tag, accent, desc) = course-card(title, accent, tag: en-tag, desc)

  #mvc-card(
    "لایه مدل",
    [#en[Model] | کلاس‌های منطق],
    colors.ink,
    [وضعیت واقعی بازی: مختصات توپ، سکو و آجرها و تعداد جان‌ها. این کلاس‌ها به پنجره و گرافیک وابسته نیستند و آزمودنشان ساده است.]
  )
  #v(2pt)
  #mvc-card(
    "لایه نما",
    [#en[View] | #code-inline("BreakoutCanvas")],
    colors.blue,
    [ترسیم وضعیت بازی روی صفحه: اشکال، آجرها و نشانگر جان‌ها. این لایه وضعیت را از کنترل‌گر می‌گیرد و هیچ منطق بازی ندارد.]
  )
  #v(2pt)
  #mvc-card(
    "لایه کنترل‌گر",
    [#en[Controller] | #code-inline("GameEngine")],
    rgb("1B8755"),
    [هماهنگ‌کنندهٔ بازی: حلقهٔ بازی را ۶۰ بار در ثانیه اجرا می‌کند، فشردن کلیدها را دریافت می‌کند، برخوردها را حل می‌کند و به نما می‌گوید دوباره رسم کند.]
  )

  #v(2pt)

  == مسیر داده در سه گام
  #block(
    fill: rgb("FAFDFE"),
    stroke: 0.5pt + colors.rule,
    radius: 3pt,
    inset: (x: 8pt, y: 5.5pt),
    width: 100%,
    [
      #set text(size: type-scale.small)
      + *ورودی:* کنترل‌گر کلیدهای جهت، #code-inline("Space")، #code-inline("P") و #code-inline("R") را دریافت می‌کند.
      + *محاسبه:* کنترل‌گر متدهای حرکت سکو و توپ را صدا می‌زند و وضعیت تازهٔ بازی را در مدل ثبت می‌کند.
      + *نمایش:* پس از پایان محاسبات فیزیک، کنترل‌گر وضعیت تازه را برای رسم به نما می‌دهد.
    ]
  )

  #v(2pt)

  == قرارداد ذخیره رکورد: #code-inline("HighScoreStorage")
  بازی نباید به نحوهٔ ذخیرهٔ رکورد وابسته باشد. برای همین رابط ساده‌ای تعریف می‌کنیم. در فاز اول، ذخیره در حافظه کافی است. ذخیره در فایل در همین فاز *اختیاری* است؛ اگر آن را انجام دهید، در بخش امتیازی نمره می‌گیرید و برای فاز بعد و مبحث ورودی/خروجی هم مفید است:

  #v(1pt)

  #code-block("public interface HighScoreStorage {
    int loadHighScore();
    void saveHighScore(int score);
}")

  #v(2pt)

  #course-card("پیاده‌سازی موقت در حافظه", colors.blue, tag: code-inline("InMemoryScoreStorage"))[
    بالاترین رکورد را در حافظهٔ موقت#footnote[#en[RAM: Random Access Memory]] نگه دارید؛ با بستن برنامه از بین می‌رود. این پیاده‌سازی برای تحویل فاز اول الزامی است.
  ]

  #v(2pt)

  #course-card("ذخیره در فایل", colors.ink, tag: code-inline("FileScoreStorage"))[
    ذخیرهٔ دائمی رکورد در یک فایل متنی. می‌توانید همین فاز آن را انجام دهید یا به فاز بعد بسپارید؛ در هر دو حالت رابط #code-inline("HighScoreStorage") تغییر نمی‌کند.
  ]
]
