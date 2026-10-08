#import "../course/theme.typ": *
#show: course-workshop.with(
  title: "جلسهٔ اول",
  subtitle: [۱۵ مهر],
  number: "01",
)

= اهداف
- معرفی کارگاه و روش کاری
- تاریخچهٔ بشریت و برنامه‌نویسی
- راه‌اندازی و نصب جاوا
- نوشتن اولین خط کد و اجرای آن
- معرفی گرافیک کامپیوتری

= معرفی
در کارگاه‌های این درس، با نوشتن و اجرای کد به بررسی مسائل می‌پردازیم. هدف این است که ایده‌ها را قدم‌به‌قدم به برنامه تبدیل کنیم و نتیجهٔ هر تغییر را ببینیم.

= بشریت و تکنولوژی
از ابزارهای ساده تا رایانه‌ها و هوش مصنوعی، فناوری راهی برای گسترش توانایی‌های انسان بوده است. در این بخش، نگاهی کوتاه به این مسیر و نقش برنامه‌نویسی در آن داریم.

= زبان‌های برنامه‌نویسی
زبان‌های برنامه‌نویسی به ما کمک می‌کنند دستورها را دقیق و قابل‌اجرا بیان کنیم. در این درس، با #en[Java] کار می‌کنیم و به‌تدریج با ساختار و منطق برنامه‌ها آشنا می‌شویم.

= آماده‌سازی محیط برنامه‌نویسی
برای ساخت و اجرای نخستین پروژهٔ #en[Java]، یکی از دو مسیر زیر را دنبال کنید.

== مسیر پیشنهادی: #en[IntelliJ IDEA]
نصب #en[IntelliJ IDEA] ساده است. راهنمای متنی یا ویدیوی زیر را دنبال کنید؛ ویدیو روی مک ضبط شده است و مراحل کلی راه‌اندازی در ویندوز نیز مشابه‌اند.

#resource-links(
  resource-link("https://www.jetbrains.com/help/idea/creating-and-running-your-first-java-application.html#create-project", [راهنمای ساخت پروژه]),
  resource-link("https://www.youtube.com/watch?v=XCqVCq249Iw&t=308s&pp=ygUTc2V0dXAgamF2YSBpbnRlbGxpag%3D%3D", [ویدیوی راه‌اندازی در مک]),
)

== مسیر جایگزین: #en[VSCode]
اگر از #en[VSCode] استفاده می‌کنید، راهنمای متنی یا ویدیوی متناسب با سیستم‌عامل خود را ببینید.

#resource-links(
  resource-link("https://code.visualstudio.com/docs/java/java-tutorial", [راهنمای متنی]),
  resource-link("https://www.youtube.com/watch?v=YQQ-sWcx12I&pp=ygUbdnNjb2RlIGphdmEgc2V0dXAgZ3VpZGUgbWFj", [ویدیوی مک]),
  resource-link("https://www.youtube.com/watch?v=m-NiWvYpUfQ", [ویدیوی ویندوز]),
)

= سلام دنیا
این برنامه را اجرا کنید و خروجی #code-inline("Hello world!") را در کنسول ببینید. سپس متن داخل گیومه را تغییر دهید و دوباره اجرا کنید.
#code-block("class App {\n  public static void main(String[] args) {\n    System.out.println(\"Hello world!\");\n  }\n}", lang: "java")

= گرافیک کامپیوتری
در گرافیک کامپیوتری، نتیجهٔ کد را به شکل تصویر می‌بینیم. نمونهٔ زیر را در ویرایشگر #en[p5.js] باز و اجرا کنید؛ کد و تصویر خروجی را کنار هم بررسی کنید.

#resource-links(
  resource-link("https://editor.p5js.org/alirezaopmc/sketches/iUmapUPd8", [باز کردن نمونهٔ گرافیکی], detail: [ویرایشگر آنلاین #en[p5.js] · #en[editor.p5js.org]]),
)
