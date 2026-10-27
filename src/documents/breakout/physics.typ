#import "../../course/theme.typ": *

#let breakout-physics-page() = [
  = فیزیک و برخوردها

  موتور فیزیک بازی وظیفه شبیه‌سازی حرکت پیوسته، محاسبه زاویه بازتاب از سکو و انهدام دقیق آجرها را بر عهده دارد. هر «تیک» یک گام از حلقهٔ ۶۰ هرتزی بازی است:

  #v(2pt)

  == ۱. بازتاب زاویه‌دار از سکو

  اگر توپ همیشه مثل آینه بازتاب کند، بازی سریعاً وارد یک چرخه تکراری و خسته‌کننده می‌شود. برای پویایی بیشتر، زاویه پرتاب با توجه به فاصله نقطه برخورد تا مرکز سکو تعیین می‌گردد:

  #v(2pt)

  #block(
    fill: colors.pale,
    stroke: (right: 3.5pt + colors.blue),
    radius: 3pt,
    inset: (x: 10pt, y: 7pt),
    width: 100%,
    [
      #text(weight: "bold", size: type-scale.small, fill: colors.blue)[روابط ریاضی کمانه زاویه‌دار]
      #v(3pt)

      #set text(size: type-scale.small)

      - *۱. انحراف نسبی برخورد نسبت به مرکز سکو ($d in [-1.0, +1.0]$):*
        فاصلهٔ افقی مرکز توپ تا مرکز سکو ($Delta x$) و نیم‌عرض سکو ($w_"half"$) را به‌صورت متغیرهای تفکیک‌شده تعریف می‌کنیم:
        $ Delta x = x_"ball" - x_"paddle_center" quad , quad w_"half" = W_"paddle" / 2 $
        $ d = (Delta x) / w_"half" $
        #text(size: type-scale.footer, fill: colors.muted)[مقدار منفی نشان‌دهنده اصابت در نیمه چپ ($Delta x < 0$) و مقدار مثبت نشان‌دهنده اصابت در نیمه راست سکو ($Delta x > 0$) است.]

      #v(2pt)
      - *۲. زاویه پرتاب متناسب با نقطه برخورد (تا بیشینه ۶۰ درجه):*
        $ theta = d times 60^degree $
        #text(size: type-scale.footer, fill: colors.muted)[برخورد در مرکز سکو بازتابی عمودی ($theta = 0$) و برخورد در لبه‌ها ($d = plus.minus 1.0$) تندترین زاویه پرتاب را می‌سازد.]

      #v(2pt)
      - *۳. پایستگی تندی کل توپ بر پایه قضیه فیثاغورس:*
        $ v = sqrt(v_x^2 + v_y^2) $

      #v(2pt)
      - *۴. تجزیه سرعت به مؤلفه‌های جدید (پرتاب رو به بالا):*
        $ v_x' = v sin(theta) quad , quad v_y' = -|v cos(theta)| $
        #text(size: type-scale.footer, fill: colors.muted)[علامت منفی در مؤلفه عمودی تضمین می‌کند که توپ همیشه رو به بالا و به سمت آجرها کمانه کند.]
    ]
  )

  #v(2pt)

  #text(size: type-scale.small)[این قطعه فقط بازتاب زاویه‌دار از سکو است؛ برای دیواره‌ها و آجرها از #code-inline("reverseX") و #code-inline("reverseY") استفاده کنید.]

  #v(1pt)

  #code-block("// Calculate horizontal offset and half-width as separate variables
double paddleCenter = paddle.getX() + paddle.getWidth() / 2.0;
double ballCenter = ball.getX() + ball.getRadius();
double deltaX = ballCenter - paddleCenter;
double halfWidth = paddle.getWidth() / 2.0;

double offset = deltaX / halfWidth;
offset = Math.max(-1.0, Math.min(1.0, offset));

// Calculate bounce angle (max 60 deg) and preserve total velocity
double angle = offset * Math.toRadians(60.0);
double speed = Math.hypot(ball.getVx(), ball.getVy());

// Apply new velocity components (always deflect upwards)
ball.setVx(speed * Math.sin(angle));
ball.setVy(-Math.abs(speed * Math.cos(angle)));")

  #v(2pt)

  == ۲. تشخیص برخورد با آجرها

  برای بررسی برخورد توپ با آجرها و دیواره‌ها، از الگوریتم تداخل مستطیل‌های مرز#footnote[#en[AABB: Axis-Aligned Bounding Box]] استفاده می‌کنیم. به محض برخورد، محور برخورد را با عمق هم‌پوشانی تعیین کنید: عمق هم‌پوشانی توپ و آجر را در محور افقی و عمودی حساب کنید و فقط مؤلفهٔ سرعت محوری را معکوس کنید که عمق کمتری دارد. در گوشهٔ آجر نیز همین قاعده را به کار ببرید تا تنها یک مؤلفه معکوس شود. امتیاز ۱۰۰ با نابودی هر آجر ثبت می‌شود.

  #v(2pt)

  #note[نکات طلایی برای پیاده‌سازی روان فیزیک][
    #set text(size: type-scale.small)
    + *گیر افتادن توپ در سکو:* اگر فقط علامت سرعت را منفی کنید، توپ ممکن است در فریم بعدی همچنان داخل سکو بماند و شروع به لرزیدن کند! چاره: پس از برخورد، موقعیت عمودی توپ را طوری تنظیم کنید که لبهٔ پایین جعبه مرز توپ مماس با لبهٔ بالای سکو باشد؛ مثلاً #code-inline("ball.setY(paddle.getY() - 2 * ball.getRadius())") وقتی #code-inline("getY") گوشه بالا-چپ است.
    + *تقسیم صفر ناشی از اعداد صحیح:* در محاسبه نسبت فاصله، متغیرها باید از نوع اعشاری #code-inline("double") باشند؛ در غیر این صورت تقسیم عدد صحیح حاصل را صفر می‌کند.
    + *پرش شبح‌وار از موانع#footnote[#en[Tunneling]]:* اگر سرعت توپ خیلی زیاد شود، ممکن است در یک فریم از عرض آجر رد شود بدون اینکه برخوردی ثبت شود! در هر تیک، توپ را کمتر از قطر خودش (۱۶ پیکسل) جابه‌جا کنید؛ در غیر این صورت ممکن است بدون ثبت برخورد از آجر عبور کند.
  ]
]
