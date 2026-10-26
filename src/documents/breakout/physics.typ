#import "../../course/theme.typ": *

#let breakout-physics-page() = [
  = دستگاه مختصات و هندسهٔ بازی

  در محیط گرافیکی کامپیوتر، جهت‌گیری محورهای مختصات با دستگاه دکارتی رایج در ریاضیات تفاوت دارد: نقطهٔ مبدا $(0, 0)$ در گوشهٔ بالا-چپ قرار دارد، محور $+X$ به سمت راست و محور $+Y$ به سمت پایین افزایش می‌یابد. در نتیجه علامت مؤلفهٔ سرعت عمودی نقشی حیاتی در رفتار توپ دارد:

  #grid(
    columns: (1.1fr, 2.1fr),
    gutter: 8pt,
    block(
      fill: colors.pale,
      stroke: 0.6pt + colors.rule,
      radius: 4pt,
      inset: (x: 8pt, y: 7pt),
      width: 100%,
      [
        #set align(center)
        #text(weight: "bold", fill: colors.blue)[مختصات بوم و بردار سرعت]
        #v(3pt)
        #line(length: 100%, stroke: 0.5pt + colors.rule)
        #v(3pt)
        #set align(right)
        #set text(size: 8.5pt)
        $(0, 0) arrow.r.long +X$ (حرکت به راست)\
        $arrow.b +Y$ (افزایش عمق به سمت کف)\
        #v(2pt)
        #text(weight: "bold", fill: colors.ink)[قواعد جهت حرکت:]\
        • $v_y > 0$: سقوط رو به پایین\
        • $v_y < 0$: اوج‌گیری رو به بالا (سمت آجرها)
      ]
    ),
    table(
      columns: (1fr, 1.15fr, 1.4fr),
      table.header([*مؤلفه*], [*ابعاد استاندارد*], [*توضیحات و رفتار*]),
      [بوم (#en[Canvas])], [#math-inline($800 times 600$) پیکسل], [محیط پایدار با نرخ به‌روزرسانی #latin-number("60 FPS")],
      [سکو (#en[Paddle])], [#math-inline($100 times 15$) پیکسل], [فاصلهٔ #latin-number("40") پیکسلی از کف، مهار کامل در افق],
      [توپ (#en[Ball])], [شعاع #latin-number("8") (قطر #latin-number("16"))], [آغاز حرکت با زاویهٔ روبه‌بالا و تندی ثابت],
      [آجرها (#en[Bricks])], [۵ سطر در ۸ ستون (#latin-number("40"))], [ابعاد #math-inline($85 times 25$) با فاصلهٔ #latin-number("6") پیکسل],
    )
  )

  = بازتاب زاویه‌دار قطعه‌ای از سکو (#en[Segmented Deflection])

  اگر توپ همواره با بازتاب آینه‌ای از سکو کمانه کند، بازی پس از چند ضربه وارد یک چرخهٔ تکراری و خسته‌کنندهٔ ۴۵ درجه می‌شود. با بازتاب زاویه‌دار، زاویهٔ پرتاب بر اساس فاصلهٔ برخورد از مرکز سکو کنترل‌پذیر می‌گردد:

  #grid(
    columns: (1.2fr, 1.8fr),
    gutter: 8pt,
    [
      #set text(size: 8.5pt)
      - *انحراف نسبی:* $d = (x_"ball" - x_"paddle_center") / (W_"paddle" / 2) in [-1.0, +1.0]$
      - *زاویهٔ بیشینه:* $theta = d times 60^degree$
      - *تندی پایسته:* $v = sqrt(v_x^2 + v_y^2)$
      - *سرعت جدید:* $v_x' = v sin(theta)$ و $v_y' = -v cos(theta)$
      #v(2pt)
      مقدار $v_y'$ همواره منفی است تا بازتاب قطعاً رو به بالا باشد.
    ],
    [
      #code-block("// Calculate hit offset relative to paddle center (-1.0 to +1.0)
double paddleCenter = paddle.getX() + paddle.getWidth() / 2.0;
double ballCenter = ball.getX() + ball.getRadius();
double offset = (ballCenter - paddleCenter) / (paddle.getWidth() / 2.0);
offset = Math.max(-1.0, Math.min(1.0, offset));

double maxAngle = Math.toRadians(60.0);
double angle = offset * maxAngle;
double speed = Math.hypot(ball.getVx(), ball.getVy());

ball.setVx(speed * Math.sin(angle));
ball.setVy(-Math.abs(speed * Math.cos(angle)));")
    ]
  )

  = برخورد جعبه‌های مرزی (#en[AABB]) و تالار خطاهای متداول

  برای تشخیص برخورد دایره با مستطیل، نزدیک‌ترین نقطهٔ مستطیل به مرکز دایره محاسبه ($c_x = "clamp"(x, x_r, x_r + w)$ و $c_y = "clamp"(y, y_r, y_r + h)$) و فاصلهٔ آن با مرکز دایره مقایسه می‌شود ($d^2 <= r^2$).

  #note[تالار خطاهای متداول در پیاده‌سازی فیزیک][
    + *باگ سکوی چسبنده (#term[Sticky Paddle]):* معکوس‌کردن صرف علامت $v_y$ بدون خارج‌کردن توپ، باعث گیر افتادن و لرزش مداوم درون سکو می‌شود. هنگام برخورد باید فوراً مختصات توپ روی `ball.setY(paddle.getY() - ball.getRadius())` بازنشانی شود.
    + *خطای برش در تقسیم صحیح (#term[Integer Truncation]):* استفاده از عملوند عدد صحیح در فرمول انحراف (`width / 2`) مقدار اعشاری را حذف کرده و نتیجه همواره صفر خواهد شد؛ حتماً از مخرج اعشاری `2.0` و متغیرهای `double` استفاده کنید.
    + *تونل‌زنی در سرعت بالا (#term[High-Speed Tunneling]):* اگر گام جابه‌جایی توپ در یک فریم از ضخامت آجر یا سکو بیشتر شود، توپ بدون برخورد از مانع عبور می‌کند. سرعت باید مقداری محدود و متناسب با ابعاد اشکال باشد.
  ]
]
