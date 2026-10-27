#import "../../course/theme.typ": *

#let breakout-physics-page() = [
  = فیزیک و برخوردها

  موتور فیزیک حرکت توپ، زاویهٔ بازتاب از سکو و تخریب آجرها را محاسبه می‌کند. هر «تیک» یک بار اجرای حلقهٔ ۶۰ هرتزی بازی است:

  #v(2pt)

  == ۱. بازتاب زاویه‌دار از سکو

  اگر توپ مثل آینه بازتاب کند، بازی خیلی زود یکنواخت می‌شود. برای اینکه هر ضربه متفاوت باشد، زاویهٔ بازتاب به فاصلهٔ نقطهٔ برخورد از مرکز سکو بستگی دارد:

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

      - *۱. انحراف برخورد نسبت به مرکز سکو ($d in [-1.0, +1.0]$):*
        فاصلهٔ افقی مرکز توپ تا مرکز سکو ($Delta x$) و نصف عرض سکو ($w_"half"$) را جدا تعریف می‌کنیم:
        $ Delta x = x_"ball" - x_"paddle_center" quad , quad w_"half" = W_"paddle" / 2 $
        $ d = (Delta x) / w_"half" $
        #text(size: type-scale.footer, fill: colors.muted)[$Delta x$ منفی یعنی توپ به نیمهٔ چپ سکو خورده و $Delta x$ مثبت یعنی به نیمهٔ راست.]

      #v(2pt)
      - *۲. زاویهٔ بازتاب (حداکثر ۶۰ درجه):*
        $ theta = d times 60^degree $
        #text(size: type-scale.footer, fill: colors.muted)[اصابت به مرکز سکو بازتاب عمودی ($theta = 0$) می‌دهد. اصابت به لبه‌ها ($d = plus.minus 1.0$) بیشترین زاویه، یعنی ۶۰ درجه، را می‌دهد.]

      #v(2pt)
      - *۳. حفظ تندی کل توپ:* اندازهٔ سرعت را با قضیهٔ فیثاغورس حساب کنید:
        $ v = sqrt(v_x^2 + v_y^2) $

      #v(2pt)
      - *۴. تجزیهٔ سرعت به مؤلفه‌های جدید (توپ به بالا برمی‌گردد):*
        $ v_x' = v sin(theta) quad , quad v_y' = -|v cos(theta)| $
        #text(size: type-scale.footer, fill: colors.muted)[علامت منفی در مؤلفهٔ عمودی باعث می‌شود توپ همیشه به سمت بالا، یعنی به طرف آجرها، برگردد.]
    ]
  )

  #v(2pt)

  #text(size: type-scale.small)[این بخش فقط بازتاب از سکو را پوشش می‌دهد. برای دیواره‌ها و آجرها از #code-inline("reverseX") و #code-inline("reverseY") استفاده کنید.]

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

  برای تشخیص برخورد توپ با آجرها و دیواره‌ها از الگوریتم مستطیل‌های مرزی#footnote[#en[AABB: Axis-Aligned Bounding Box]] استفاده کنید. هنگام برخورد، عمق هم‌پوشانی توپ و آجر را در محور افقی و عمودی حساب کنید و فقط مؤلفهٔ سرعتی را معکوس کنید که عمق کمتری دارد. در گوشهٔ آجر هم همین قاعده را اعمال کنید تا فقط یک مؤلفه برگردد. با نابودی هر آجر ۱۰۰ امتیاز ثبت می‌شود.

  #v(2pt)

  #note[نکته‌هایی برای پیاده‌سازی درست فیزیک][
    #set text(size: type-scale.small)
    + *توپ داخل سکو گیر می‌کند:* اگر فقط علامت سرعت را عوض کنید، ممکن است توپ در فریم بعد هنوز داخل سکو باشد و بلرزد. بعد از برخورد، موقعیت عمودی توپ را طوری تنظیم کنید که لبهٔ پایین جعبهٔ مرز توپ دقیقاً به لبهٔ بالای سکو برسد؛ برای مثال #code-inline("ball.setY(paddle.getY() - 2 * ball.getRadius())") وقتی #code-inline("getY") گوشهٔ بالا-چپ را برمی‌گرداند.
    + *نتیجهٔ صفر در تقسیم صحیح:* برای نسبت فاصله‌ها از نوع اعشاری #code-inline("double") استفاده کنید. در غیر این صورت تقسیم صحیح، نتیجه را صفر می‌کند.
    + *عبور توپ از آجر#footnote[#en[Tunneling]]:* اگر توپ در یک تیک خیلی دور برود، ممکن است از روی آجر بپرد و برخورد ثبت نشود. در هر تیک توپ را کمتر از قطرش (۱۶ پیکسل) جابه‌جا کنید.
  ]
]
