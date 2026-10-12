#import "../course/theme.typ": *
#show: course-document.with(
  kind: "راهنمای درس",
  title: "مبانی برنامه‌سازی در جاوا",
  subtitle: "عبارت‌ها، حلقه‌ها، منطق بولی و گرافیک مقدماتی",
)

= پیش از شروع

این راهنما با چند مقدار و دستور کوتاه آغاز می‌شود و سپس همان ایده‌ها را در چراغ دریایی ایستگاه «نصف‌النهار» به کار می‌گیرد. قطعه‌های #en[Java] را با دنبال‌کردن مقدار متغیرها بخوانید و پیش از دیدن توضیح، نتیجه را حدس بزنید. پوستهٔ برنامه و ورودیِ نمونه در تمرین‌های مربوط آماده‌اند؛ تمرکز این بخش روی عبارت‌ها، حلقه‌ها و اثر فرمان‌های رسم است.

= مرجع سریع: مقدارها و عبارت‌ها

== هشت نوع پایه

هر مقدار نمونه در اعلان زیر برای نوع خودش معتبر است. پسوند #code-inline("L") مقدار #code-inline("long") و پسوند #code-inline("f") مقدار #code-inline("float") را مشخص می‌کند. نویسهٔ #code-inline("char") در تک‌نقل‌قول قرار می‌گیرد.

#code-block("byte signal = 12;\nshort steps = 240;\nint battery = 7;\nlong distance = 3000000000L;\nfloat ratio = 0.5f;\ndouble percent = 35.0;\nchar marker = 'M';\nboolean lampOn = true;")

نوع را با شکل مقدار موردنیاز انتخاب کنید: #code-inline("boolean") برای درست/نادرست، #code-inline("char") برای یک نویسه، نوع‌های صحیح برای شمارش و نوع‌های اعشاری برای نتیجهٔ کسری به کار می‌روند. در اینجا حفظ‌کردن بازهٔ عددی نوع‌ها لازم نیست.

== متغیر، مقدار اولیه و دامنه

اعلان، نام و نوع را معرفی می‌کند؛ مقداردهی اولیه نخستین مقدار را می‌دهد. #code-inline("final") جلوی تغییر دوبارهٔ همان متغیر را می‌گیرد. متغیری که در آکولاد داخلی اعلان شده، بیرون آن آکولاد در دسترس نیست.

#code-block("int remaining;           // declaration\nremaining = 7;           // first value\nfinal int capacity = 20;\n{\n    int used = 2;         // local to this block\n    remaining -= used;   // remaining is now 5\n}\n// used is not available here\nremaining += 3;          // 8\nremaining *= 2;          // 16\nremaining++;             // 17\nremaining--;             // 16")

در #code-inline("remaining = 7") مقدار سمت راست به نام سمت چپ سپرده می‌شود. #code-inline("+=")، #code-inline("-=") و #code-inline("*=") مقدار قبلی را با عمل مربوط به‌روزرسانی می‌کنند؛ #code-inline("++") یک واحد می‌افزاید و #code-inline("--") یک واحد می‌کاهد.

== حساب و ترتیب اجرا

پنج عمل اصلی #code-inline("+")، #code-inline("-")، #code-inline("*")، #code-inline("/") و #code-inline("%") هستند؛ #code-inline("%") باقی‌ماندهٔ تقسیم را می‌دهد. تقسیم دو #code-inline("int") بخش کسری را حذف می‌کند. برای نتیجهٔ اعشاری، پیش از تقسیم یکی از عملوندها را تبدیل کنید.

#code-block("int sum = 7 + 2;          // 9\nint difference = 7 - 2;   // 5\nint product = 7 * 2;      // 14\nint quotient = 7 / 2;     // 3\nint remainder = 7 % 2;    // 1\ndouble exact = (double) 7 / 2; // 3.5")

تقدم عملگرها گروه‌بندی را تعیین می‌کند: ضرب پیش از جمع انجام می‌شود. اگر تقدم یکسان باشد، این تفریق‌ها از چپ گروه‌بندی می‌شوند. پرانتز می‌تواند گروه‌بندی را عوض کند.

#code-block("int a = 2 + 3 * 4;       // 14: 2 + (3 * 4)\nint b = 20 - 6 - 4;      // 10: (20 - 6) - 4\nint c = (2 + 3) * 4;     // 20")

گروه‌بندی با ترتیب ارزیابی عملوندها یکسان نیست. #en[Java] عملوندهای یک عبارت را از چپ به راست ارزیابی می‌کند؛ در مثال جداگانهٔ زیر، نخستین #code-inline("n++") مقدار #latin-number("1") و دومی مقدار #latin-number("2") را به جمع می‌دهد.

#code-block("int n = 1;\nint result = n++ + n++; // result = 3, n = 3")

== ردگیری باتری چراغ

از ظرفیت #latin-number("20") واحد، #latin-number("7") واحد مانده است. نتیجهٔ خط اول درصد واقعی نیست، چون تقسیم صحیح پیش از ضرب انجام شده است. تبدیل در خط دوم پیش از تقسیم رخ می‌دهد؛ تبدیلِ پس از تقسیم در خط سوم دیر است.

#code-block("int remaining = 7;\nint capacity = 20;\nint wholeFirst = remaining / capacity * 100;       // 0\ndouble batteryPercent = (double) remaining / capacity * 100; // 35.0\ndouble tooLate = (double) (remaining / capacity) * 100;      // 0.0")

#note[پیش‌بینی][اگر #code-inline("remaining") به #latin-number("10") برسد، پیش از محاسبه بگویید هر سه خط درصد چه مقداری می‌سازند. جای تبدیل نوع را در پاسخ مشخص کنید.]

= واحد یک: تکرار و چراغ دریایی

== تکرار با تعداد معلوم

وقتی تعداد اجراها معلوم است، #code-inline("for") مقدار آغازین، شرط ادامه و به‌روزرسانی را کنار هم نشان می‌دهد. در این مثال بدنه دقیقاً سه بار با #code-inline("frame") برابر #latin-number("0")، #latin-number("1") و #latin-number("2") اجرا می‌شود.

#code-block("for (int frame = 0; frame < 3; frame++) {\n    System.out.println(frame);\n}")

== تکرار تا نشانهٔ پایان

در قطعهٔ بعد، محیط تمرین یک ورودی عددی آماده کرده است. #code-inline("-1") نشانهٔ پایان است و به جمع افزوده نمی‌شود. هر دور پس از افزودن مقدار فعلی، مقدار بعدی خوانده می‌شود؛ پس شرط دور بعد با دادهٔ تازه بررسی می‌شود.

#code-block("// Supplied input scaffold\njava.util.Scanner input = new java.util.Scanner(System.in);\nint total = 0;\nint reading = input.nextInt();\nwhile (reading != -1) {\n    total += reading;\n    reading = input.nextInt();\n}\nSystem.out.println(total);")

برای ورودی #code-inline("4 7 -1")، مقدار #code-inline("total") به‌ترتیب #latin-number("0")، #latin-number("4") و #latin-number("11") است و همان #latin-number("11") چاپ می‌شود. اگر اولین مقدار #code-inline("-1") باشد، بدنه حتی یک بار اجرا نمی‌شود و خروجی #latin-number("0") است.

#note[ردگیری][برای دنبالهٔ #code-inline("3 2 5 -1")، مقدار #code-inline("reading") و #code-inline("total") را درست پیش از هر بررسی شرط بنویسید. سپس بگویید چرا نشانهٔ پایان وارد جمع نمی‌شود.]

== رسم و حرکت در پوستهٔ آماده

این پوستهٔ #en[ACM] برای مثال فراهم شده است. چهار فرمان #code-inline("GRect")، #code-inline("GOval")، #code-inline("GLine") و #code-inline("GLabel") به‌ترتیب یک مستطیل، بیضی، خط و نوشته می‌سازند. مختصات مستطیل و بیضی همراه عرض و ارتفاع است؛ خط با دو سر مشخص می‌شود و جای نوشته نقطهٔ خط مبنای آن است. هر شکل با #code-inline("add") روی بوم دیده می‌شود.

#code-block("import acm.graphics.*;\nimport acm.program.GraphicsProgram;\n\n// Supplied ACM program shell\npublic class LighthouseDemo extends GraphicsProgram {\n    public void run() {\n        GRect tower = new GRect(50, 90, 34, 110);\n        GOval light = new GOval(54, 76, 26, 18);\n        GLine shore = new GLine(0, 210, 300, 210);\n        GLabel sign = new GLabel(\"نصف‌النهار\", 24, 70);\n        add(tower);\n        add(light);\n        add(shore);\n        add(sign);\n\n        GOval boat = new GOval(30, 190, 24, 12);\n        add(boat);\n        for (int frame = 0; frame < 40; frame++) {\n            boat.move(2, 0);\n            pause(40);\n        }\n    }\n}")

در هر قاب، #code-inline("move(2, 0)") بیضی قایق را دو واحد به راست می‌برد و #code-inline("pause(40)") مکث کوتاهی پیش از قاب بعدی ایجاد می‌کند. به تغییر یک قاب فکر کنید: اگر آرگومان اول #code-inline("move") منفی شود، مسیر دیده‌شده چه تغییری می‌کند؟
