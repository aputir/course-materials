#import "../course/theme.typ": *
#show: course-document.with(
  kind: "راهنمای درس",
  title: "اشکال‌زدایی، جستجو و هوش مصنوعی",
  subtitle: "چگونه با خطاها روبه‌رو شویم",
)

= پیش از شروع

خطا بخشی طبیعی، اجتناب‌ناپذیر و حتی آموزنده از فرآیند برنامه‌نویسی است. هیچ برنامه‌نویسی، از مبتدی تا حرفه‌ای، کدی بدون خطا نمی‌نویسد؛ تفاوت در نحوهٔ برخورد با آن است. کامپایلر و محیط اجرای #en[Java] دشمن شما نیستند؛ پیام‌های خطا تلاش آن‌ها برای برقراری ارتباط و نشان‌دادن ریشهٔ مشکل است.

هدف این راهنما آموزش چهار مهارت زنجیره‌ای و متوالی است:
+ *شناخت ماهیت خطاها:* تفکیک خطای کامپایلر، خطای زمان اجرا و خطای منطقی.
+ *خواندن و کالبدشکافی خطاها:* استخراج اطلاعات حیاتی از متن پیام‌ها بدون سردرگمی.
+ *جستجوی هدفمند:* فرمول‌بندی عبارات جستجو برای رسیدن سریع به پاسخ در منابع معتبر.
+ *بهره‌گیری هوشمندانه از هوش مصنوعی:* پرامپت‌نویسی اصولی، درک محدودیت‌ها، بازبینی کد و فرآیند گام‌به‌گام رفع اشکال.

کدهای این راهنما از مفاهیم هفته‌های اول تا سوم درس (نوع‌های پایه، عملگرها، عبارت‌ها، حلقه‌ها، عبارات شرطی و بستر گرافیکی ساده) انتخاب شده‌اند و از هیچ مفهوم شیءگرایی استفاده نمی‌کنند.

#resource-links(
  resource-link(
    "https://github.com/aputir/course-materials/tree/main/src/examples/debugging",
    [کدهای نمونهٔ اشکال‌زدایی در گیت‌هاب],
    detail: [#en[GitHub] · سه برنامه با خطاهای کامپایلر، زمان اجرا و منطقی],
  ),
)

#v(spacing.element)

= بخش ۱: خطاها چیستند؟ دسته‌بندی سه‌گانه

هنگام نوشتن و اجرای یک برنامه، اشکال‌ها می‌توانند در سه لایه و زمان کاملاً مجزا بروز کنند. پیش از تلاش برای اصلاح هر خطایی، باید بدانید با کدام دسته روبه‌رو هستید:

#table(
  columns: (1.2fr, 1fr, 1.2fr),
  align: (right, right, right),
  table.header[*دستهٔ خطا*][*زمان وقوع*][*چه کسی متوجه می‌شود؟*],
  [خطای کامپایلر (#en[Compile Error])], [پیش از اجرای برنامه (زمان ترجمه)], [کامپایلر (#en[javac])],
  [خطای زمان اجرا (#en[Runtime Error])], [هنگام اجرای برنامه], [ماشین مجازی جاوا (#en[JVM])],
  [خطای منطقی (#en[Logic Error])], [برنامه تا پایان اجرا می‌شود], [تنها برنامه‌نویس یا کاربر],
)

#v(spacing.element)

- *خطای کامپایلر:* قواعد دستوری زبان (#en[Syntax]) یا سازگاری نوع‌ها (#en[Types]) نقض شده است. کامپایلر اجازهٔ تولید فایل اجرایی را نمی‌دهد. مثل این است که در جمله‌ای فارسی، فعل را فراموش کنید یا املای کلمه‌ای اشتباه باشد.
- *خطای زمان اجرا:* برنامه کامپایل شده و اجرا آغاز می‌شود، اما در میان راه دستور ناممکنی پیش می‌آید (مانند تقسیم عددی بر صفر یا درخواست حافظهٔ نامعتبر)؛ برنامه ناگهان متوقف و اصطلاحاً «کِرَش» (#en[Crash]) می‌کند.
- *خطای منطقی:* برنامه با موفقیت کامپایل و تا انتها اجرا می‌شود، اما خروجی آن با خروجی مورد انتظار مطابقت ندارد. کامپایلر یا سیستم هیچ پیام خطایی نمی‌دهند، چون دستورها از نظر زبان معتبر بوده‌اند اما مقصود شما را محقق نکرده‌اند.

#note[پیش‌بینی][اگر حلقه‌ای قرار باشد #latin-number("4") بار تکرار شود ولی به اشتباه #latin-number("5") بار اجرا شود، این باگ جزو کدام‌یک از این سه دسته است؟ چرا کامپایلر مانع اجرای برنامه نمی‌شود؟]

#pagebreak()

= بخش ۲: خطای کامپایلر و نحوهٔ خواندن آن

کامپایلر زبان جاوا (#en[javac]) بازرس سخت‌گیری است. وقتی خطای کامپایل دریافت می‌کنید، پیام ظاهرشده شامل اطلاعات دقیق دربارهٔ محل و علت خطا است.

== کالبدشکافی پیام کامپایلر

فرض کنید می‌خواهیم درصد شارژ باقی‌ماندهٔ باتری را با داشتن شارژ فعلی و ظرفیت کل به صورت درصدی صحیح حساب کنیم:

#code-block("class BatteryCalc {
    public static void main(String[] args) {
        int remaining = 7;
        int capacity = 20;
        int percent = (double) remaining / capacity * 100;
        System.out.println(percent);
    }
}", lang: "java")

چون عبارت سمت راست به دلیل تبدیل #code-inline("(double)") دارای نوع اعشاری است، ریختن آن در متغیر صحیح #code-inline("int") بدون تبدیل صریح مجاز نیست. کامپایلر چنین خطایی نمایش می‌دهد:

#error-anatomy(
  [src/examples/debugging/BatteryCalc.java:7: error: incompatible types: possible lossy conversion from double to int\
  #h(2em)int percent = (double) remaining / capacity \* 100;\
  #h(2em)#h(24.5em)^\
  1 error],
  (
    ("BatteryCalc.java:7", [نام فایل و شمارهٔ خط دقیق رخ‌داد خطا]),
    ("error: incompatible types", [نوع خطا: عدم تطابق نوع متغیر با مقدار انتسابی]),
    ("possible lossy conversion", [توضیح تکمیلی: خطر از بین رفتن قسمت اعشاری در تبدیل]),
    ("^", [نشانگر مکان دقیق خطا در عبارت]),
  ),
)

#v(spacing.element)

*قانون طلایی اول:* با دیدن پیام کامپایلر مضطرب نشوید! ابتدا فقط نام فایل و شمارهٔ خط را بخوانید، به همان سطر در ویرایشگر خود بروید و نماد نشانه (#code-inline("^")) را بررسی کنید.

#v(spacing.element)

== پنج خطای رایج کامپایلر در مبانی برنامه‌سازی

در جدول زیر، خطاهای متداولی که در چند هفتهٔ آغازین با آن‌ها روبه‌رو می‌شوید همراه نمونهٔ نادرست و اصلاح‌شده آورده شده‌اند:

=== ۱. نماد پیدا نشد (#code-inline("cannot find symbol"))
این خطا معمولاً به علت غلط املایی در نام متغیر یا استفاده از متغیری خارج از دامنهٔ تعریف (#en[Scope]) رخ می‌دهد.
#example-columns(
  [کد نادرست:
#code-block("int remaining = 7;
System.out.println(remaning);", lang: "java")],
  [کد اصلاح‌شده:
#code-block("int remaining = 7;
System.out.println(remaining);", lang: "java")],
)

=== ۲. ناسازگاری نوع‌ها (#code-inline("incompatible types"))
سعی در انتساب یک نوع دادهٔ بزرگتر یا ناسازگار به متغیری با نوع محدودتر.
#example-columns(
  [کد نادرست:
#code-block("int score = 19.5;
boolean active = 1;", lang: "java")],
  [کد اصلاح‌شده:
#code-block("double score = 19.5;
boolean active = true;", lang: "java")],
)

#pagebreak()

=== ۳. پایان پیش‌ازموعد فایل (#code-inline("reached end of file while parsing"))
معمولاً به معنای فراموش کردن آکولاد بسته (#code-inline("}")) برای یک حلقه، شرط یا کلاس است.
#example-columns(
  [کد نادرست:
#code-block("for (int i = 0; i < 3; i++) {
    System.out.println(i);
// آکولاد بسته فراموش شد", lang: "java")],
  [کد اصلاح‌شده:
#code-block("for (int i = 0; i < 3; i++) {
    System.out.println(i);
}", lang: "java")],
)

=== ۴. انتظار نقطه‌ویرگول (#code-inline("';' expected"))
پایان هر دستور در جاوا نیازمند نقطه‌ویرگول (#code-inline(";")) است.
#example-columns(
  [کد نادرست:
#code-block("int step = 10
step += 5;", lang: "java")],
  [کد اصلاح‌شده:
#code-block("int step = 10;
step += 5;", lang: "java")],
)

=== ۵. شروع نامعتبر عبارت (#code-inline("illegal start of expression"))
پرانتزهای باز و بستهٔ ناهماهنگ، یا قرار گرفتن کلمات کلیدی در جایی نامناسب.
#example-columns(
  [کد نادرست:
#code-block("int total = (5 + 3));", lang: "java")],
  [کد اصلاح‌شده:
#code-block("int total = (5 + 3);", lang: "java")],
)

#note[ردگیری][در قطعه‌کد زیر، دو خطای کامپایلر وجود دارد. بدون اجرای کامپایلر، آن‌ها را بیابید، نام خطای احتمالی هریک را بنویسید و کد را اصلاح کنید:

#code-block("int count = 0
double average = totl / count;", lang: "java")]

#pagebreak()

= بخش ۳: خطای زمان اجرا و ردگیری پشته (#en[Stack Trace])

خطاهای زمان اجرا زمانی رخ می‌دهند که کد شما از نظر گرامری سالم است، اما در جریان اجرا با وضعیت غیرممکن روبه‌رو می‌شود.

== کالبدشکافی ردگیری پشته (#en[Stack Trace])

در برنامهٔ زیر، قرار است میانگین اعدادی را تا رسیدن به نشانهٔ پایان (#latin-number("-1")) محاسبه کنیم:

#code-block("import java.util.Scanner;

class AverageCalc {
    public static void main(String[] args) {
        int total = 0;
        int count = 0;
        Scanner input = new Scanner(System.in);
        int value = input.nextInt();
        while (value != -1) {
            int avg = total / count; // در اولین تکرار count برابر 0 است!
            total += value;
            count++;
            value = input.nextInt();
        }
        System.out.println(\"Total: \" + total);
    }
}", lang: "java")

اگر کاربر ورودی #code-inline("5 3 -1") را وارد کند، برنامه پیش از افزودن عدد، اقدام به تقسیم #code-inline("total / count") می‌کند و متوقف می‌شود:

#error-anatomy(
  [Exception in thread "main" java.lang.ArithmeticException: / by zero\
  #h(2em)at AverageCalc.main(AverageCalc.java:12)],
  (
    ("ArithmeticException", [نوع استثنا — خطای محاسباتی ریاضی در زمان اجرا]),
    ("/ by zero", [پیام تفصیلی استثنا — تلاش برای تقسیم یک عدد صحیح بر صفر]),
    ("AverageCalc.main", [متد و کلاسی که خطا در آن رخ داده است]),
    ("AverageCalc.java:12", [نام فایل و شمارهٔ خط دقیق توقف برنامه]),
  ),
)

#v(spacing.element)

*قانون طلایی دوم:* در گزارش‌های طولانی خطا (#en[Stack Trace])، همیشه از بالاترین خط شروع کنید و نخستین خطی را بیابید که به فایل و خطِ نوشته‌شده توسط *شما* اشاره می‌کند. کدهای درونی سیستم یا کتابخانه‌ها معمولاً در خطوط بعدی قرار دارند.

== سه خطای زمان اجرای رایج در ادامهٔ مسیر

+ #code-inline("ArithmeticException: / by zero") — تقسیم بر صفر در محاسبات اعداد صحیح.
+ #code-inline("ArrayIndexOutOfBoundsException") — مراجعه به اندیسی فراتر از طول آرایه (در مباحث هفته‌های آینده).
+ #code-inline("NullPointerException") — تلاش برای استفاده از متغیری ارجاعی که به هیچ شیءای اشاره نمی‌کند.

#note[پیش‌بینی][در پیام خطای زیر که از یک برنامهٔ گرافیکی صادر شده، مشکل اصلی در کدام خط از کد شماست؟

#terminal-block[
  Exception in thread "main" java.lang.ArithmeticException: / by zero\
  #h(2em)at LighthouseAnimation.drawLighthouse(LighthouseAnimation.java:24)\
  #h(2em)at LighthouseAnimation.run(LighthouseAnimation.java:10)\
  #h(2em)at acm.program.GraphicsProgram.runHook(GraphicsProgram.java:312)
]]

#pagebreak()

= بخش ۴: خطای منطقی — برنامه‌ای که مؤدبانه اشتباه می‌کند!

خطاهای منطقی بدقلق‌ترین نوع باگ‌ها هستند، زیرا نه کامپایلر شکایتی دارد و نه سیستم متوقف می‌شود. برنامه ظاهراً سالم اجرا می‌شود، اما نتیجه اشتباه است.

== نمونه: تختهٔ شطرنجی با یک سطر اضافه (#en[Off-by-One])

می‌خواهیم یک تختهٔ شطرنجی #latin-number("4") در #latin-number("4") با نویسه‌های متنی بسازیم:

#code-block("class Checkerboard {
    public static void main(String[] args) {
        int rows = 4;
        int cols = 4;
        for (int row = 0; row <= rows; row++) { // به علامت <= دقت کنید!
            for (int col = 0; col < cols; col++) {
                System.out.print((row + col) % 2 == 0 ? \"X \" : \". \");
            }
            System.out.println();
        }
    }
}", lang: "java")

#example-columns(
  [خروجی مورد انتظار (#latin-number("4") سطر):
#code-block("X . X .
. X . X
X . X .
. X . X", lang: "text")],
  [خروجی واقعی برنامه (#latin-number("5") سطر):
#code-block("X . X .
. X . X
X . X .
. X . X
X . X .", lang: "text")],
)

*ریشهٔ اشکال:* شرط حلقهٔ بیرونی #code-inline("row <= rows") نوشته شده است. با شروع از صفر، مقادیر #code-inline("row") برابر با #latin-number("0")، #latin-number("1")، #latin-number("2")، #latin-number("3") و #latin-number("4") خواهند بود؛ یعنی دقیقاً #latin-number("5") بار تکرار!

== سه الگوی پرتکرار خطای منطقی

=== ۱. خطای یک‌به‌یک (#en[Off-by-One Error])
اشتباه در تعیین حد مرزی حلقه با استفاده از #code-inline("<=") به‌جای #code-inline("<") یا شروع شمارنده از #latin-number("1") به‌جای #latin-number("0").
*راهبرد کشف:* حلقه را در مقادیر اولیه و نهایی شمارنده به‌صورت ذهنی ردگیری کنید.

=== ۲. تبدیل نوع دیرهنگام در تقسیم صحیح (#en[Late Casting])
#example-columns(
  [محاسبهٔ نادرست (نتیجه #code-inline("0.0")):
#code-block("double ratio = (double) (3 / 4);", lang: "java")],
  [محاسبهٔ درست (نتیجه #code-inline("0.75")):
#code-block("double ratio = (double) 3 / 4;", lang: "java")],
)
در نمونهٔ اول، تقسیم دو عدد صحیح ابتدا انجام شده و حاصل #code-inline("0") به #code-inline("0.0") تبدیل می‌شود.

=== ۳. منطق شرطی یا عملگر اشتباه
استفاده از #code-inline("||") به‌جای #code-inline("&&")، یا اشتباه در معکوس‌سازی با #code-inline("!"). همچنین کوتاه‌مداری (#en[Short-circuit]) ممکن است باعث اجرا نشدن بخش موردنظر شود.

== راهبرد اشکال‌زدایی: ردگیری روی کاغذ (#en[Desk Checking / Tracing])

پیش از تغییر دادن تصادفی کدها، یک برگه و قلم بردارید:
+ جدولی بکشید که ستون‌های آن متغیرها و شروط حلقه باشند.
+ مقادیر را خط به خط مانند کامپیوتر جلو ببرید و در هر تکرار به‌روزرسانی کنید.
+ اولین جایی که مقدار متغیر با انتظار شما مغایرت پیدا کرد، همان سطر منبع اشکال است.

#note[تلاش کنید][اگر بخواهیم در کد تختهٔ شطرنجی، ابعاد تخته را #latin-number("3") در #latin-number("5") قرار دهیم و مشکل سطر اضافه را هم حل کنیم، چه تغییراتی در مقادیر و شروط حلقه‌ها نیاز است؟ خروجی را پیش از اجرا روی کاغذ ترسیم کنید.]

#pagebreak()

= بخش ۵: چگونه خطاهایمان را جستجو کنیم؟

هنگامی که پیام خطا یا رفتار برنامه را متوجه نمی‌شوید، موتورهای جستجو بهترین ابزار هستند — به شرط آنکه بدانید چه چیزی را تایپ کنید.

== فرمول طلایی جستجوی فنی

یک جستجوی مؤثر از فرمول زیر پیروی می‌کند:

#note[فرمول جستجوی استاندارد][
  #set text(font: code-font, lang: "en", dir: ltr)
  #set align(left)
  java [error name or concept] [exact behavior or operation]
]

به این سه مثال توجه کنید:
- #code-inline("java ArithmeticException division by zero in while loop")
- #code-inline("java \"cannot find symbol\" variable declared in loop")
- #code-inline("java integer division returns zero float cast")

#v(spacing.element)

== ترفندهای حرفه‌ای جستجو

+ *استفاده از گیومه برای پیام دقیق:* قرار دادن متن خطا داخل گیومه (#code-inline("\"...\"")) به موتور جستجو می‌گوید دقیقاً دنبال همان عبارت بگردد:
  #code-inline("java \"possible lossy conversion from double to int\"")
+ *محدود کردن به مراجع معتبر:* افزودن #code-inline("site:stackoverflow.com") نتایج را روی پرسش و پاسخ‌های فنی متمرکز می‌کند.
+ *حذف اطلاعات خصوصی و تصادفی:* هرگز نام متغیرهای پروژه، نام فایل کلاستان، یا شماره خط‌های محلی خود را در جستجو قرار ندهید (مثلاً #code-inline("AverageCalc.java") در اینترنت وجود ندارد!).

== چگونه نتایج را بخوانیم و ارزیابی کنیم؟

نمونه‌ای از یک نتیجهٔ جستجو:

#border-frame(title: [نمونهٔ نتایج جستجو در گوگل])[
  #set text(size: type-scale.small, lang: "en", dir: ltr)
  #set align(left)
  *1.* #text(fill: colors.blue)[java - Why does integer division truncate in Java? - Stack Overflow]\
  #text(fill: rgb("006621"))[stackoverflow.com/questions/4141682/...]\
  In Java, when you divide two integers, the result is always an integer. To get a floating-point...
]

#v(spacing.element)

در سایت #en[Stack Overflow]:
- به نماد تیک سبز (پاسخ پذیرفته‌شده توسط پرسش‌گر) دقت کنید.
- به امتیاز مثبت (#en[Upvotes]) پاسخ‌ها نگاه کنید. گاهی پاسخی که بیشترین رأی را دارد بهتر از پاسخ پذیرفته‌شده است.
- به سال ارسال پاسخ توجه کنید؛ در کدهای بسیار قدیمی ممکن است روش‌های منسوخ استفاده شده باشد.

== ۵ الگوی جستجوی آماده

#checklist((
  [#code-inline("java [error name] [operation]") — جستجوی پایه برای یافتن نمونه‌های مشابه],
  [#code-inline("java \"exact error message\" site:stackoverflow.com") — جستجوی عین پیام خطا در استک اورفلو],
  [#code-inline("java [operator/statement] not working [observed result]") — رفع اشکال رفتار نامنتظره],
  [#code-inline("java how to [intended task] without [restriction]") — یادگیری پیاده‌سازی سازگار با درس],
  [#code-inline("java difference between [term A] and [term B]") — درک تفاوت دو مفهوم مشابه (مانند #code-inline("for") و #code-inline("while"))],
))

#note[پیش‌بینی][فرض کنید با خطای #code-inline("';' expected") در تعریف یک متغیر مواجه شده‌اید اما مطمئنید در انتهای خط سمیکالن گذاشته‌اید. چه عبارتی برای جستجو پیشنهاد می‌کنید؟]

#pagebreak()

= بخش ۶: هوش مصنوعی چگونه و کجا می‌تواند کمک کند؟

مدل‌های زبانی بزرگ (#en[مانند ChatGPT, Claude, Gemini]) می‌توانند مانند یک دستیار آموزشی (#en[TA]) صبور در کنار شما باشند؛ اما مانند هر ابزار قدرتمندی، اگر روش استفاده از آن را ندانید، مهارت یادگیری شما را تضعیف خواهند کرد.

== هوش مصنوعی چه کارهایی می‌تواند و نمی‌تواند بکند؟

*کارهایی که در آن‌ها توانا است:*
- توضیح دادن معنای یک پیام خطای مبهم به زبان ساده.
- بررسی یک قطعه‌کد کوتاه و اشاره به علت عدم کارکرد آن.
- پیشنهاد دادن مثال‌های ساده برای شفاف‌سازی یک مفهوم (مانند تفاوت #code-inline("for") و #code-inline("while")).
- پیدا کردن اشتباهات املایی و نشانه‌گذاری‌های فراموش‌شده.

*محدودیت‌ها و خطرات:*
- هوش مصنوعی ممکن است با اطمینان کامل کدی نادرست یا منسوخ به شما تحویل دهد (#en[Hallucination]).
- هوش مصنوعی از پیش‌نیازها و محدودیت‌های درس شما (مانند ممنوعیت استفاده از توابع پیشرفته یا کلاس‌ها) آگاه نیست مگر اینکه صریحاً قید کنید.
- کپی کردن مستقیم کد هوش مصنوعی بدون درک آن، در آزمون‌ها و تمرین‌های عملی بعدی باعث ناتوانی شما خواهد شد.

#note[هشدار][هوش مصنوعی جایگزین مغز شما نیست؛ یک آینه است! کیفیت پاسخی که دریافت می‌کنید مستقیماً وابسته به کیفیت سوال و اطلاعاتی است که به آن می‌دهید.]

== قالب یک پرامپت (#en[Prompt]) حرفه‌ای

یک پرامپت استاندارد برای رفع اشکال باید سه رکن اصلی داشته باشد:

#prompt-example[قالب پرامپت رفع اشکال][
  #set text(font: english-font, lang: "en", dir: ltr)
  #set align(left)
  I am learning introductory Java (no OOP, no advanced libraries).\
  Here is my code (10 lines):\
  \[کد کوتاه خود را اینجا قرار دهید\]\
  \
  What I expected: \[خروجی یا رفتار مورد انتظار شما\]\
  What actually happened: \[پیام خطا یا خروجی فعلی\]\
  Please explain what is causing the issue and guide me to fix it myself without writing the full solution.
]

#pagebreak()

== مقایسهٔ عملی: پرامپت ضعیف در برابر پرامپت هدفمند

فرض کنید می‌خواهیم باگ اضافه بودن سطر در برنامهٔ تختهٔ شطرنجی را با کمک هوش مصنوعی حل کنیم:

=== پرامپت ضعیف و پاسخ سردرگم‌کننده

#ai-conversation(
  ("user", [
    #set text(font: english-font, lang: "en", dir: ltr)
    #set align(left)
    my java code doesn't work please fix it\
    \[چسباندن ۱۰۰ خط کد مختلف از چند بخش پروژه\]
  ]),
  ("ai", [
    #set text(font: english-font, lang: "en", dir: ltr)
    #set align(left)
    There could be multiple reasons why your code isn't working. You might have issues with loop variables, scanner inputs, or class structure. Here is a completely rewritten version using Object-Oriented patterns, Streams, and 2D arrays...
  ]),
)

#v(spacing.element)

*اشکال:* هوش مصنوعی کدی پیچیده با استفاده از کلاس‌ها و مفاهیمی تولید کرد که اصلاً هنوز نخوانده‌اید و مجاز به استفاده از آن‌ها نیستید!

=== پرامپت هدفمند و پاسخ آموزنده

#ai-conversation(
  ("user", [
    #set text(font: english-font, lang: "en", dir: ltr)
    #set align(left)
    I am learning basic Java loops (no OOP). I am trying to print a 4x4 checkerboard, but my program prints 5 rows instead of 4.

    ```
    int rows = 4;
    int cols = 4;
    for (int row = 0; row <= rows; row++) {
        for (int col = 0; col < cols; col++) {
            System.out.print((row + col) % 2 == 0 ? "X " : ". ");
        }
        System.out.println();
    }
    ```

    Expected: 4 rows. Actual: 5 rows. Where is the extra iteration coming from?
  ]),
  ("ai", [
    #set text(font: english-font, lang: "en", dir: ltr)
    #set align(left)
    The extra row is coming from the outer loop condition: `row <= rows`.

    Since `row` starts at `0` and stops when it exceeds `rows` (4), the loop executes for `row = 0, 1, 2, 3, 4` — which is 5 iterations in total.

    To get exactly 4 rows, change the condition from `<=` to `<`:
    `for (int row = 0; row < rows; row++)`

    This is known as an "off-by-one error".
  ]),
)

#pagebreak()

== جدول بایدها و نبایدهای کار با هوش مصنوعی

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  align: (right, right, right),
  table.header[*معیار*][*روش درست ✓*][*روش اشتباه ✗*],
  [دامنهٔ کد], [تنها بخش مشکل‌دار (#latin-number("5") تا #latin-number("15") خط)], [کپی کردن کل فایل و پروژه],
  [توصیف وضعیت], [بیان دقیق انتظار در مقابل واقعیت], [«کدم کار نمی‌کنه» یا «درستش کن»],
  [خطا], [کپی کردن متن دقیق خطا یا استک تریس], [«یک ارور قرمز رنگ می‌ده»],
  [سطح پاسخ], [درخواست راهنمایی و چرایی اشکال], [درخواست نوشتن کل پروژه از ابتدا],
  [صحت‌سنجی], [تست و ارزیابی شخصی هر پیشنهاد], [اعتماد کورکورانه و کپی مستقیم],
)

#v(spacing.element)

== چرخهٔ استاندارد حل مسئله (#en[Debugging Workflow])

هنگامی که به مانعی برخوردید، دقیقاً این مسیر گام‌به‌گام را طی کنید:

+ *گام اول (خواندن و تفکر):* پیام خطای کامپایلر یا زمان اجرا را با دقت بخوانید. شماره سطر را بیابید و متغیرها را بازبینی کنید.
+ *گام دوم (آزمون فرضیه):* با تغییر کوچک و هدفمند، دوباره برنامه را اجرا کنید و بررسی کنید آیا پیام خطا تغییر کرد؟
+ *گام سوم (جستجوی مستقل):* اگر علت خطا نامشخص بود، با فرمول بخش ۵ در وب جستجو کنید.
+ *گام چهارم (همفکری با هوش مصنوعی):* اگر پاسخ مناسبی نیافتید، با پرامپت ساختاریافته از هوش مصنوعی بخواهید علت را برایتان باز کند.
+ *گام پنجم (مشورت حضوری):* اگر پس از طی مراحل بالا مشکل پابرجا بود، با همراه داشتن گزارش دقیق کارهای انجام‌شده، به دستیار آموزشی یا استاد مراجعه کنید.

#note[تلاش کنید][تصور کنید در حین نوشتن یک حلقهٔ شمارش با خطای زیر روبه‌رو شده‌اید:
#terminal-block[
  Exception in thread "main" java.lang.ArithmeticException: / by zero\
  #h(2em)at HarborStatus.main(HarborStatus.java:9)
]
یک پرامپت انگلیسی مطابق قالب این بخش بنویسید که بدون درخواست کد آماده، علت خطا را از هوش مصنوعی جویا شود.]

#pagebreak()

= مرور پایانی و خودآزمایی

پیش از شروع تکالیف بعدی، مطمئن شوید می‌توانید به پرسش‌های زیر به زبان خودتان و با استدلال پاسخ دهید:

+ تفاوت اساسی میان خطای کامپایلر، خطای زمان اجرا و خطای منطقی چیست؟ چرا کامپایلر قادر به تشخیص خطای تقسیم بر صفر قبل از اجرا نیست؟
+ در یک استک تریس (#en[Stack Trace]) چند ده سطری، اولین نگاه شما باید به کدام خط جلب شود؟
+ در جستجوی اینترنتی برای یک باگ، چه تفاوت تعیین‌کننده‌ای میان کلمات داخل گیومه و کلمات بدون گیومه وجود دارد؟
+ چرا فرستادن کل پروژه به هوش مصنوعی با پرامپت «کدم کار نمی‌کنه» معمولاً به کدهای پیچیده و غیرقابل استفاده ختم می‌شود؟

#v(spacing.element)

== چک‌لیست مهارت‌های فردی

پیش از تحویل تمرین‌ها یا پرسیدن از دیگران، این معیارها را بررسی کنید:

#checklist((
  [می‌توانم با دیدن پیام خطای کامپایلر، شمارهٔ سطر و نشانگر (#code-inline("^")) را بیابم و علت اعلام‌شده را بفهمم.],
  [می‌توانم در استک تریس‌های طولانی، نخستین سطر مربوط به فایل خودم را جدا کنم و ریشهٔ توقف برنامه را شناسایی کنم.],
  [روش ردگیری روی کاغذ (#en[Tracing]) را برای حلقه‌ها و شرایط مرزی پیش از تغییر تصادفی کدها به کار می‌گیرم.],
  [می‌توانم برای هر ارور یا رفتار ناخواسته، یک عبارت جستجوی ساختاریافته به انگلیسی بسازم.],
  [هنگام استفاده از هوش مصنوعی، پرامپت سه‌بخشی (زمینه، کد کوتاه، مشکل دقیق) می‌نویسم و پاسخ را شخصاً راستی‌آزمایی می‌کنم.],
))
