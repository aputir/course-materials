#import "../../course/theme.typ": *

#let breakout-architecture-page() = [
  = ساختار و معماری سیستم

  تصور کنید تمام بازی در یک کلاس غول‌آسای ۲۵۰۰ خطی نوشته شود: از سرعت توپ و برخورد با دیواره تا رنگ صورتی آجرها و شنونده کلید Space! شاید اولش ساده به نظر برسد، اما با اولین باگ نامرئی، کد تبدیل به کلافی سردرگم می‌شود. نجات‌بخش ما در این بازی، الگوی درخشان معماری مدل-نما-کنترل‌گر (#en[MVC]) است که وظایف را به ۳ بخش مستقل تقسیم می‌کند:

  #v(2pt)

  #let mvc-card(title, en-tag, accent, desc) = block(
    fill: colors.pale,
    stroke: (right: 3.5pt + accent),
    radius: 3pt,
    inset: (x: 8pt, y: 5.5pt),
    width: 100%,
    grid(
      columns: (105pt, 1fr),
      gutter: 8pt,
      align: horizon,
      [
        #text(weight: "bold", size: type-scale.small, fill: accent)[#title]\
        #text(size: 8pt, fill: colors.muted)[#en-tag]
      ],
      [
        #set text(size: 8.5pt)
        #desc
      ]
    )
  )

  #mvc-card(
    "لایه مدل (Model)",
    "کلاس‌های منطق خالص",
    colors.ink,
    [حقیقت جهان بازی؛ مختصات توپ، سکو، آجرها و جان‌ها. کدهای کاملاً مستقل از پنجره و گرافیک با آزمون‌پذیری آسان.]
  )
  #v(2pt)
  #mvc-card(
    "لایه نما (View)",
    code-inline("BreakoutCanvas"),
    colors.blue,
    [پرده نقاشی و تماشا؛ دریافت وضعیت از کنترل‌گر و ترسیم اشکال، آجرها و قلب‌های جان. بدون داشتن منطق بازی.]
  )
  #v(2pt)
  #mvc-card(
    "لایه کنترل‌گر (Controller)",
    code-inline("GameEngine"),
    rgb("1B8755"),
    [مغز هماهنگ‌کننده؛ اجرای حلقه بازی در ۶۰ هرتز، دریافت فشرده‌شدن کلیدها، حل برخوردها و فرمان بازترسیم به نما.]
  )

  #v(2pt)

  == جریان داده در ۳ گام
  #block(
    fill: rgb("FAFDFE"),
    stroke: 0.5pt + colors.rule,
    radius: 3pt,
    inset: (x: 8pt, y: 6pt),
    width: 100%,
    [
      #set text(size: 8.5pt)
      + *ورودی کاربر:* فشرده شدن کلیدهای جهت‌نما یا کلیدهای فاصله، #en[P] و #en[R] توسط کنترل‌گر دریافت می‌شود.
      + *محاسبه در مدل:* کنترل‌گر متدهای حرکتی سکو و توپ را صدا زده و وضعیت جدید دنیای بازی را ثبت می‌کند.
      + *بازترسیم نما:* کنترل‌گر پس از قطعی شدن محاسبات فیزیک، وضعیت تازه را برای ترسیم به بوم نقاشی می‌فرستد.
    ]
  )

  #v(2pt)

  == قرارداد ذخیره رکورد (#code-inline("HighScoreStorage"))
  برای استقلال کامل بازی از نحوه ذخیره‌سازی، یک رابط ساده تعریف می‌کنیم تا در این فاز رکورد در رم بماند و در فاز آینده بدون دست زدن به موتور بازی، ذخیره در فایل متصل شود:

  #grid(
    columns: (1.35fr, 1.65fr),
    gutter: 8pt,
    align: horizon,
    [
      #code-block("public interface HighScoreStorage {
    int loadHighScore();
    void saveHighScore(int score);
}")
    ],
    [
      #set text(size: 8.5pt)
      - *پیاده‌سازی موقت:* کلاس #en[InMemoryScoreStorage] برای نگه‌داری بالاترین رکورد در حافظه جاری بازی.
      - *پیاده‌سازی آینده:* کلاس #en[FileScoreStorage] برای ذخیره دائمی رکورد در فایل متنی پس از آموزش I/O.
    ]
  )
]
