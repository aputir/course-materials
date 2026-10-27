#import "../../course/theme.typ": *

#let breakout-architecture-page() = [
  = ساختار و معماری سیستم

  تصور کنید تمام بازی در یک کلاس غول‌آسای ۲۵۰۰ خطی نوشته شود: از سرعت توپ و برخورد با دیواره تا رنگ صورتی آجرها و شنونده کلید #code-inline("Space"). شاید اولش ساده به نظر برسد، اما با اولین باگ نامرئی، کد تبدیل به کلافی سردرگم می‌شود. نجات‌بخش ما در این بازی، الگوی درخشان معماری مدل-نما-کنترل‌گر#footnote[#en[MVC: Model-View-Controller]] است که وظایف را به ۳ بخش مستقل تقسیم می‌کند:

  #v(2pt)

  #let mvc-card(title, en-tag, accent, desc) = course-card(title, accent, tag: en-tag, desc)

  #mvc-card(
    "لایه مدل",
    [#en[Model] | کلاس‌های منطق],
    colors.ink,
    [حقیقت جهان بازی؛ مختصات توپ، سکو، آجرها و جان‌ها. کدهای کاملاً مستقل از پنجره و گرافیک با آزمون‌پذیری آسان.]
  )
  #v(2pt)
  #mvc-card(
    "لایه نما",
    [#en[View] | #code-inline("BreakoutCanvas")],
    colors.blue,
    [پرده نقاشی و تماشا؛ دریافت وضعیت از کنترل‌گر و ترسیم اشکال، آجرها و نشانگر جان‌ها. بدون داشتن منطق بازی.]
  )
  #v(2pt)
  #mvc-card(
    "لایه کنترل‌گر",
    [#en[Controller] | #code-inline("GameEngine")],
    rgb("1B8755"),
    [مغز هماهنگ‌کننده؛ اجرای حلقه بازی در ۶۰ هرتز، دریافت فشرده‌شدن کلیدها، حل برخوردها و فرمان بازترسیم به نما.]
  )

  #v(2pt)

  == جریان داده در ۳ گام
  #block(
    fill: rgb("FAFDFE"),
    stroke: 0.5pt + colors.rule,
    radius: 3pt,
    inset: (x: 8pt, y: 5.5pt),
    width: 100%,
    [
      #set text(size: type-scale.small)
      + *ورودی کاربر:* فشرده شدن کلیدهای جهت‌نما، #code-inline("Space")، #code-inline("P") و #code-inline("R") توسط کنترل‌گر دریافت می‌شود.
      + *محاسبه در مدل:* کنترل‌گر متدهای حرکتی سکو و توپ را صدا زده و وضعیت جدید دنیای بازی را ثبت می‌کند.
      + *بازترسیم نما:* کنترل‌گر پس از قطعی شدن محاسبات فیزیک، وضعیت تازه را برای ترسیم به بوم نقاشی می‌فرستد.
    ]
  )

  #v(2pt)

  == قرارداد ذخیره رکورد: #code-inline("HighScoreStorage")
  برای استقلال کامل بازی از نحوه ذخیره‌سازی، یک رابط ساده تعریف می‌کنیم. در فاز اول پیاده‌سازی حافظه‌ای برای رکورد کافی است؛ اتصال فایل در همین فاز *اختیاری* است، اما هم در بخش امتیازی نمره دارد و هم برای فاز بعد و مباحث ورودی/خروجی آموزشی بسیار مفید است:

  #v(1pt)

  #code-block("public interface HighScoreStorage {
    int loadHighScore();
    void saveHighScore(int score);
}")

  #v(2pt)

  #course-card("پیاده‌سازی موقت در حافظه", colors.blue, tag: code-inline("InMemoryScoreStorage"))[
    نگه‌داری بالاترین رکورد در حافظهٔ موقت#footnote[#en[RAM: Random Access Memory]] طی اجرای بازی؛ این پیاده‌سازی برای تحویل فاز اول الزامی است.
  ]

  #v(2pt)

  #course-card("پیاده‌سازی آینده در فایل", colors.ink, tag: code-inline("FileScoreStorage"))[
    ذخیره‌سازی دائمی رکورد در فایل متنی؛ می‌توانید همین فاز آن را پیاده کنید یا به فاز بعد موکول کنید—در هر صورت رابط #code-inline("HighScoreStorage") ثابت می‌ماند.
  ]
]
