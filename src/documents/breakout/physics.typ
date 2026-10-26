#import "../../course/theme.typ": *

#let breakout-physics-page() = [
  = فیزیک و برخوردها

  موتور فیزیک بازی وظیفه شبیه‌سازی حرکت پیوسته، محاسبه زاویه بازتاب از سکو و انهدام دقیق آجرها را بر عهده دارد:

  #v(2pt)

  == ۱. بازتاب زاویه‌دار از سکو

  اگر توپ همیشه مثل آینه بازتاب کند، بازی سریعاً وارد یک چرخه تکراری و خسته‌کننده می‌شود. برای هیجان بیشتر، زاویه پرتاب با توجه به فاصله نقطه برخورد تا مرکز سکو تغییر می‌کند:

  #grid(
    columns: (1.2fr, 1.8fr),
    gutter: 8pt,
    [
      #set text(size: 8.5pt)
      - *محاسبه انحراف نسبی برخورد:*\
        $d = (x_"ball" - x_"paddle_center") / (W_"paddle" / 2) in [-1.0, +1.0]$
      - *زاویه بیشینه پرتاب:*\
        $theta = d times 60^degree$
      - *پایستگی تندی کل توپ:*\
        $v = sqrt(v_x^2 + v_y^2)$
      - *سرعت‌های تفکیک‌شده جدید:*\
        $v_x' = v sin(theta)$ و $v_y' = -v cos(theta)$
      #v(2pt)
      علامت مؤلفه عمودی همیشه منفی است تا توپ همیشه رو به بالا و به سمت آجرها شلیک شود.
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

  #v(2pt)

  == ۲. تشخیص برخورد با آجرها (#en[AABB])

  برای بررسی برخورد توپ با آجرها و دیواره‌ها، از الگوریتم تداخل مستطیل‌های محیطی (#en[AABB]) استفاده می‌کنیم. به محض برخورد، سرعت عمودی یا افقی معکوس شده، آجر مربوطه ناپدید می‌شود و ۱۰۰ امتیاز شیرین به بازیکن اضافه می‌گردد!

  #v(2pt)

  #note[نکات طلایی برای پیاده‌سازی روان فیزیک][
    #set text(size: 8.5pt)
    + *گیر افتادن توپ در سکو:* اگر فقط علامت سرعت را منفی کنید، توپ ممکن است در فریم بعدی همچنان داخل سکو بماند و شروع به لرزیدن کند! چاره کار: موقعیت عمودی توپ را پس از برخورد، مماس با سطح بالایی سکو قرار دهید.
    + *تقسیم صفر ناشی از اعداد صحیح:* در محاسبه نسبت فاصله، متغیرها باید اعشاری (#code-inline("double")) باشند؛ در غیر این صورت تقسیم عدد صحیح حاصل را صفر می‌کند.
    + *پرش شبح‌وار از موانع (#en[Tunneling]):* اگر سرعت توپ خیلی زیاد شود، ممکن است در یک فریم از عرض آجر رد شود بدون اینکه برخوردی ثبت شود! سرعت را در اندازه‌ای منطقی نگه دارید.
  ]
]
