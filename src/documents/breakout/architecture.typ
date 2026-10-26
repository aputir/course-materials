#import "../../course/theme.typ": *

#let breakout-architecture-page() = [
  = معماری سیستم و تفکیک مسئولیت‌ها (#en[MVC])

  در پیاده‌سازی پروژه‌های تعاملی، بزرگ‌ترین خطای رایج تجمع تمام منطق بازی، شنوندگان رخداد، حلقه‌های زمانی و اشکال گرافیکی درون یک کلاس زیرمجموعهٔ #code-inline("GraphicsProgram") است؛ الگویی نامناسب که به ساخت یک شیء همه‌کاره (#term[God Class])، ناپایدار و غیرقابل آزمون منجر می‌شود. برای دستیابی به یک معماری اصولی و تفکیک مسئولیت‌ها (#term[SoC])، سیستم به سه لایهٔ اصلی تفکیک می‌شود:

  #v(spacing.element)

  #grid(
    columns: (1fr, 1.25fr, 1fr),
    gutter: 8pt,
    block(
      fill: colors.pale,
      stroke: 0.6pt + colors.rule,
      radius: 4pt,
      inset: (x: 8pt, y: 7pt),
      width: 100%,
      [
        #set align(center)
        #text(weight: "bold", fill: colors.blue)[نمایشگر (#en[View])]
        #v(3pt)
        #text(size: type-scale.small, fill: colors.ink)[#code-inline("BreakoutCanvas")]
        #v(4pt)
        #set align(right)
        #set text(size: 8.5pt)
        • پوستهٔ بوم و کپسوله‌سازی #en[ACM]\
        • ترسیم #code-inline("GRect") و #code-inline("GOval")\
        • نمایش #en[HUD] (امتیاز و ۳ قلب جان)\
        • لایهٔ پیام وضعیت (#en[Overlay])
      ]
    ),
    block(
      fill: colors.pale,
      stroke: 1pt + colors.blue,
      radius: 4pt,
      inset: (x: 8pt, y: 7pt),
      width: 100%,
      [
        #set align(center)
        #text(weight: "bold", fill: colors.blue)[کنترلر (#en[Controller])]
        #v(3pt)
        #text(size: type-scale.small, fill: colors.ink)[#code-inline("GameEngine")]
        #v(4pt)
        #set align(right)
        #set text(size: 8.5pt)
        • حلقهٔ بازی با زمان‌بندی #latin-number("60 FPS")\
        • شنوندهٔ ورودی صفحه‌کلید (#en[Key Events])\
        • توزیع‌کنندهٔ برخوردها (#en[Dispatcher])\
        • هماهنگ‌سازی مدل و فرمان بازترسیم
      ]
    ),
    block(
      fill: colors.pale,
      stroke: 0.6pt + colors.rule,
      radius: 4pt,
      inset: (x: 8pt, y: 7pt),
      width: 100%,
      [
        #set align(center)
        #text(weight: "bold", fill: colors.blue)[مدل دامنه (#en[Model])]
        #v(3pt)
        #text(size: type-scale.small, fill: colors.ink)[دامنهٔ خالص جاوا]
        #v(4pt)
        #set align(right)
        #set text(size: 8.5pt)
        • کلاس‌های #code-inline("Ball")، #code-inline("Paddle")، #code-inline("Brick")\
        • وضعیت بازی (#code-inline("GameState"))\
        • قرارداد رکورد (#code-inline("HighScoreStorage"))\
        • بدون وابستگی به #en[GUI] و کاملاً آزمون‌پذیر
      ]
    )
  )

  #v(2pt)

  == مسئولیت کلاس‌ها و کپسوله‌سازی داده‌ها

  #table(
    columns: (0.9fr, 1.4fr, 2.2fr),
    table.header([*کلاس*], [*فیلدهای کپسوله‌شده (#code-inline("private"))*], [*رفتارها و مسئولیت‌های کلیدی*]),
    [#code-inline("Ball")],
    [`x, y, vx, vy, radius`],
    [به‌روزرسانی مختصات با بردار سرعت (`update`)، بازتاب افقی و عمودی (`bounceX`, `bounceY`) و استخراج جعبهٔ مرزی.],
    [#code-inline("Paddle")],
    [`x, y, width, height, speed`],
    [حرکت به چپ و راست بر اساس ورودی، و مهار موقعیت در محدودهٔ بوم (`clampToScreen`) جهت جلوگیری از خروج.],
    [#code-inline("Brick")],
    [`x, y, width, height, durability, destroyed`],
    [ثبت برخورد گلوله (`hit`)، کاهش مقاومت، تعیین امتیاز اعطایی (`getPoints`) و گزارش تخریب کامل شیء.],
    [#code-inline("GameEngine")],
    [`ball, paddle, bricks, state, storage`],
    [مدیریت تیک‌های زمانی #latin-number("60") هرتز، پردازش ورودی‌ها، تشخیص برخوردها، گذار وضعیت و فرمان رندر به بوم.],
  )

  = آینده‌نگری معماری: قرارداد ذخیره‌سازی داده

  یکی از اصول کلیدی طراحی شی‌گرا، وابستگی به انتزاع‌ها به‌جای پیاده‌سازی‌های انضمامی است. بدون ورود به پیچیدگی اصطلاحات الگوهای طراحی، تعریف یک رابط (#term[Interface]) ساده به ما اجازه می‌دهد ثبت بیشترین امتیاز (#en[High Score]) را بدون دستکاری هستهٔ بازی تغییر دهیم:

  #grid(
    columns: (1.5fr, 1.7fr),
    gutter: 10pt,
    [
      #code-block("public interface HighScoreStorage {
    int loadHighScore();
    void saveHighScore(int score);
}")
    ],
    [
      #set text(size: 9.5pt)
      - *پیاده‌سازی فوری (#code-inline("InMemoryScoreStorage")):* ذخیرهٔ بالاترین امتیاز در حافظهٔ موقت (#en[RAM]) طی اجرای جاری برنامه.
      - *پیاده‌سازی آتی (#code-inline("FileScoreStorage")):* خواندن و نوشتن رکورد در فایل متنی پس از آموزش مبحث #en[File I/O].
      - *چندریختی بدون بازنویسی:* موتور بازی (#code-inline("GameEngine")) تنها با این رابط کار می‌کند و نوع ذخیره‌ساز در زمان ساخت به آن تزریق می‌شود؛ در نتیجه گذار به فاز بعدی نیازمند کوچک‌ترین تغییری در کدهای موتور نخواهد بود.
    ]
  )
]
