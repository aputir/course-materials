#import "../course/theme.typ": *
#show: course-document.with(
  kind: "پیش‌نویس جزوهٔ دانشجو — گزینهٔ ب",
  title: "گزارش‌های عیب‌یابی فانوس دریایی",
  subtitle: "چهار رویداد کوتاه برای یادگیریِ دیدن، پرسیدن و آزمودن",
)

= پیش از گزارش‌ها

فانوس‌بان برای هر مشکل، چهار جمله می‌نویسد: «چه انتظاری داشتم؟»، «چه دیدم؟»، «چه شاهدی لازم دارم؟» و «کدام فرضیه را می‌آزمایم؟». قطعه‌های علامت‌دار عمداً ایراد دارند. پوستهٔ ورودی و برنامهٔ گرافیکی در محیط درس آماده است؛ در اینجا فقط دستورها و اثرشان را بررسی می‌کنیم.

#align(center, image("../../resources/assets/illustrations/java-debugging-report-evidence.png", width: 87mm))

= گزارش ۰۱ · خوانش نادرست

*انتظار:* درصد باتری از مقدار باقی‌مانده و ظرفیت به‌دست آید. *مشاهده:* یک خط اصلاً کامپایل نمی‌شود؛ خطی دیگر عدد صفر چاپ می‌کند. *شاهد:* پیام کامپایلر و مقدارهای پیش از تقسیم. *پرسش:* خطا به نوع مقدار مربوط است یا زمان تبدیل آن؟

== مقدار و نوع

در جاوا نوع و مقدار اولیه را کنار نام می‌نویسیم. این هشت مقدار معتبرند؛ #code-inline("L") برای #code-inline("long")، #code-inline("f") برای #code-inline("float") و تک‌نقل‌قول برای #code-inline("char") ضروری‌اند.

#code-block("byte level = 12;       short steps = 240;\nint left = 7;          long distance = 3000000000L;\nfloat ratio = 0.5f;   double capacity = 20.0;\nchar mark = 'L';      boolean lampOn = true;")

اعلان نام را معرفی می‌کند و مقداردهی اولیه نخستین مقدار را می‌دهد. #code-inline("final") مقدار را پس از آن ثابت نگه می‌دارد. نامی که در یک جفت آکولاد داخلی اعلان شود بیرون همان بلوک دیده نمی‌شود. #code-inline("=") مقدار سمت راست را به متغیر سمت چپ می‌سپارد؛ #code-inline("+="), #code-inline("-="), #code-inline("*="), #code-inline("++") و #code-inline("--") مقدار فعلی را تغییر می‌دهند.

#code-block("int remaining;              // declaration\nremaining = 7;             // initialization\nfinal int limit = 20;\n{ int used = 2; remaining -= used; } // used is local\nremaining += 2;  remaining *= 2;\nremaining++;     remaining--;")

== سه شاهد از یک محاسبه

این برشِ مستقل عمداً کامپایل نمی‌شود. پیام زیر نمونهٔ پیام کامپایلر است، نه ردّ پشتهٔ زمان اجرا.

#code-block("int batteryPercent = 35.0; // intentional compile error\n// error: incompatible types: possible lossy conversion\n//        from double to int")

در اجرای جداگانهٔ زیر، با #code-inline("remaining = 7") و #code-inline("capacity = 20") خروجی صفر است. این قطعه بدون اعلان معیوبِ بالا کامپایل می‌شود؛ خروجی #code-inline("println") را با انتظار مقایسه کنید.

#code-block("int remaining = 7, capacity = 20;\nint shown = remaining / capacity * 100;\nSystem.out.println(shown);")

ابتدا هر مشکل را در نمونه‌ای کوچک بازسازی کنید. پنج عمل #code-inline("+"), #code-inline("-"), #code-inline("*"), #code-inline("/") و #code-inline("%") به‌ترتیب جمع، تفریق، ضرب، تقسیم و باقی‌مانده‌اند. در تقسیم دو #code-inline("int") بخش کسری حذف می‌شود؛ برای بخش کسری باید *پیش از تقسیم* یک عملوند به نوع اعشاری تبدیل شود. این عبارت را برای آزمودن فرضیه، جدا از دو قطعهٔ پیشین اجرا و پیش‌بینی کنید:

#code-block("int remaining = 7, capacity = 20;\ndouble probe = (double) remaining / capacity * 100;")

تقدم، گروه‌بندی را تعیین می‌کند: #code-inline("2 + 3 * 4") برابر #latin-number("14") است و #code-inline("20 - 6 - 4") از چپ گروه‌بندی می‌شود. پرانتز گروه‌بندی را تغییر می‌دهد. *ترتیب ارزیابی عملوندها* بحث دیگری است: جاوا آن‌ها را از چپ به راست می‌سنجد؛ در #code-inline("n++ + n++") با #code-inline("n = 1")، عملوند اول #latin-number("1") و دومی #latin-number("2") است. این دو قاعده را با هم یکی نگیرید.

= گزارش ۰۲ · چراغی که تکرار می‌شود

*انتظار:* چراغ سه بار چشمک بزند و جمع خوانش‌ها با رسیدن به #code-inline("-1") متوقف شود. *مشاهده:* گاهی تعداد قاب‌ها یا جمع نامنتظر است. *شاهد:* شمارهٔ قاب و مقدار خوانش درست پیش از شرط. *پرسش:* آغاز، شرط و به‌روزرسانی کجا قرار دارند؟

== تعداد معلوم، نشانهٔ پایان

وقتی تعداد تکرار معلوم است، #code-inline("for") آغاز، شرط و تغییر را در یک سطر نشان می‌دهد. برای #code-inline("n = 1") بدنه دقیقاً یک بار با #code-inline("frame = 0") اجرا می‌شود. صورت #code-inline("while") همین ترتیب را در چند سطر نشان می‌دهد.

#code-block("int n = 3;\nfor (int frame = 0; frame < n; frame++) {\n    System.out.println(frame);\n}\nint frame = 0;\nwhile (frame < n) {\n    System.out.println(frame);\n    frame++;\n}")

برای ورودیِ با نشانهٔ پایان، خواندن نخستین مقدار *پیش از* شرط انجام می‌شود. #code-inline("-1") وارد جمع نمی‌شود. ورودی #code-inline("4 7 -1") باید #latin-number("11") بدهد و ورودیِ فقط #code-inline("-1") باید #latin-number("0") بدهد. #code-inline("println") موقت را نزدیک شرط بگذارید تا معلوم شود کدام مقدار بررسی می‌شود.

#code-block("// Supplied input scaffold: java.util.Scanner input\nint total = 0;\nint reading = input.nextInt();\nwhile (reading != -1) {\n    System.out.println(\"reading=\" + reading); // temporary trace\n    total += reading;\n    reading = input.nextInt();\n}\nSystem.out.println(total);")

== یک قاب، یک حرکت

در پوستهٔ آمادهٔ #en[ACM]، #code-inline("GOval") شکل چراغ یا قایق است؛ #code-inline("add") آن را به بوم می‌آورد. در هر قاب #code-inline("move(2, 0)") شکل را دو واحد به راست می‌برد و #code-inline("pause(40)") مکث کوتاه می‌سازد. این قطعه داخل #code-inline("run") پوستهٔ آماده قرار می‌گیرد.

#code-block("GOval boat = new GOval(30, 180, 24, 12);\nadd(boat);\nfor (int frame = 0; frame < 3; frame++) {\n    boat.move(2, 0);\n    pause(40);\n}")

این برشِ مستقل عمداً مرز نادرست دارد. انتظار سه چاپِ نمایندهٔ سه چشمک است؛ مشاهده چهار خط با شماره‌های #latin-number("0") تا #latin-number("3") است. مقدار #code-inline("frame") را پیش از هر دور با انتظار مقایسه کنید.

#code-block("int flashes = 3;\nfor (int frame = 0; frame <= flashes; frame++) { // intentional boundary error\n    System.out.println(\"blink \" + frame);\n}")

#pagebreak()

= گزارش ۰۳ · تصمیمِ بندر

*انتظار:* وقتی هیچ قایقی نیست، برنامه بدون محاسبهٔ میانگین وضعیت بندر را بگوید. *مشاهده:* برنامه هنگام اجرا می‌ایستد. *شاهد:* متن استثنا، نخستین خط مربوط به کد خودمان در ردّ پشته و مقدار #code-inline("boats"). *پرسش:* آیا شرط محافظ پیش از تقسیم بررسی می‌شود؟

== خطا در زمان اجرا

در قطعهٔ عمداً معیوب، #code-inline("boats = 0") است. خط اولِ ردّ پشته نوع مشکل را می‌گوید؛ #code-inline("Harbor.java:12") محل نمونهٔ آن در کد ماست. شماره‌خط را با فایل خودتان تطبیق دهید؛ خودِ ردّ پشته پاسخ اصلاح نیست.

#code-block("int boats = 0;\nint total = 18;\nint average = total / boats; // intentional runtime error\n// Exception in thread \"main\" java.lang.ArithmeticException: / by zero\n//     at Harbor.run(Harbor.java:12)")

مقایسه‌ها #code-inline("=="), #code-inline("!="), #code-inline("<"), #code-inline(">"), #code-inline("<="), #code-inline(">=") نتیجهٔ #code-inline("boolean") می‌دهند؛ #code-inline("=") برای انتساب است. #code-inline("&&") یعنی هر دو شرط درست باشند، #code-inline("||") یعنی دست‌کم یکی درست باشد، و #code-inline("!") نتیجه را وارونه می‌کند. عملوند سمت چپ اول سنجیده می‌شود. اگر در #code-inline("&&") نادرست یا در #code-inline("||") درست باشد، سمت راست اصلاً اجرا نمی‌شود.

#code-block("boolean safeAndHigh = boats != 0 && total / boats > 5;\nboolean emptyOrHigh = boats == 0 || total / boats > 5;\nboolean notEmpty = !(boats == 0);")

برای #code-inline("boats = 0") مشخص کنید کدام تقسیم‌ها اجرا نمی‌شوند؛ سپس همین سؤال را برای #code-inline("boats = 3") بپرسید. چاپ موقتِ #code-inline("boats") پیش از شرط، فرضیهٔ «صفر بودن» را می‌آزماید. یک تغییر کوچک بدهید و هر دو ورودی را دوباره بررسی کنید.

== انتخاب یکی از حالت‌ها

#code-inline("if")، #code-inline("else if") و #code-inline("else") اولین شاخهٔ مناسب را انتخاب می‌کنند. عبارت #code-inline("condition ? x : y") یکی از دو مقدار را برمی‌گرداند. #code-inline("switch") مقدار را با #code-inline("case")ها می‌سنجد، #code-inline("break") خروج از همان انتخاب است و #code-inline("default") حالت‌های دیگر را می‌گیرد.

#code-block("int wind = 18;\nif (wind >= 30) { System.out.println(\"بسته\"); }\nelse if (wind >= 15) { System.out.println(\"احتیاط\"); }\nelse { System.out.println(\"باز\"); }\nint signal = wind > 20 ? 2 : 1;\nswitch (signal) {\n    case 1: System.out.println(\"آماده\"); break;\n    case 2: System.out.println(\"هشدار\"); break;\n    default: System.out.println(\"نامعلوم\");\n}")

#pagebreak()

= گزارش ۰۴ · نقشه‌ای با یک ستون اضافه

*انتظار:* نقشهٔ چهار در چهار، چهار خانه در هر سطر داشته باشد؛ خانهٔ بالا و چپ تیره باشد. *مشاهده:* خروجی پنج ستون نشان می‌دهد، بی‌آنکه برنامه از اجرا بایستد. *شاهد:* مقدار #code-inline("row") و #code-inline("col") در آخرین خانهٔ هر سطر. *پرسش:* آخرین مقدار مجاز ستون چیست؟

#align(center, image("../../resources/assets/illustrations/java-debugging-report-map.png", width: 82mm))

== خطای منطقیِ دیدنی

این قطعه عمداً یک مرز نادرست دارد. #code-inline("row") و #code-inline("col") از صفر آغاز می‌شوند. زوج‌بودن #code-inline("(row + col) % 2") خانه‌های شطرنجی را یکی‌درمیان می‌سازد. برای #code-inline("row = 0") و #code-inline("col = 0")، نشانهٔ #code-inline("X") چاپ می‌شود.

#code-block("int rows = 4, cols = 4;\nfor (int row = 0; row < rows; row++) {\n    for (int col = 0; col <= cols; col++) { // intentional logic error\n        System.out.print((row + col) % 2 == 0 ? \"X \" : \". \");\n        System.out.println(\"row=\" + row + \" col=\" + col); // trace\n    }\n    System.out.println();\n}")

برای دیدن شکلِ واقعیِ تخته، چاپ ردگیری را موقتاً جدا یا حذف کنید؛ برای بررسی مرز، مقدار آخر #code-inline("col") را در هر سطر ثبت کنید. خروجیِ مورد انتظار چنین الگویی دارد؛ قطعهٔ بالا عمداً آن را نمی‌سازد:

#code-block("X . X .\n. X . X\nX . X .\n. X . X", lang: "text")

== همان مختصات روی بوم

در پوستهٔ گرافیکی آماده، #code-inline("GRect") خانه را در #code-inline("col * cell") و #code-inline("row * cell") می‌گذارد. #code-inline("GOval") شکل گرد، #code-inline("GLine") خط، و #code-inline("GLabel") نوشته است. ساختن شکل به‌تنهایی آن را نشان نمی‌دهد؛ #code-inline("add") لازم است. این برش داخل #code-inline("run") قرار می‌گیرد؛ پوستهٔ کلاس و واردکردن #en[ACM] از قبل فراهم است.

#code-block("int row = 0, col = 0, cell = 18;\nGRect tile = new GRect(col * cell, row * cell, cell, cell);\ntile.setFilled(true); add(tile);\nGOval marker = new GOval(2, 2, 8, 8); add(marker);\nGLine shore = new GLine(0, 90, 90, 90); add(shore);\nGLabel label = new GLabel(\"X\", 4, 105); add(label);")

وقتی مرز حلقه را بررسی کردید، یک نقشهٔ #latin-number("1") در #latin-number("1") و سپس #latin-number("4") در #latin-number("4") را امتحان کنید. تغییر را با خروجی متنی و شکل روی بوم بسنجید.

#pagebreak()

= کارت جیبیِ بررسی خطا

۱. *وضعیت را بفهم:* خواسته، ورودیِ بازتولیدکننده، نتیجهٔ مورد انتظار و نتیجهٔ واقعی را کوتاه بنویس. نمونه را تا حد ممکن کوچک کن.

۲. *شاهد جمع کن:* پیام کامپایلر، متن استثنا و نخستین خط مربوط به کد خودت در ردّ پشته را از هم جدا کن. برای خطای بی‌پیام، یک #code-inline("System.out.println") موقت نزدیک مقدار مشکوک بگذار و یک فرضیهٔ قابل‌آزمون بساز.

۳. *جست‌وجو و پرسش:* عبارت جست‌وجو را از «#en[Java] + متن دقیق خطا یا مفهوم» بساز. در پرسش از هوش مصنوعی، خواسته، کد کوچک، انتظار، مشاهده، خطای دقیق و فرضیه‌ات را بده و بپرس: «این مفهوم را ساده‌تر توضیح بده؛ این خطِ ردّ پشته چه می‌گوید؛ چه آزمایشی فرضیه‌ام را رد می‌کند؟» نام اشخاص، مسیر محلی، دادهٔ خصوصی و کلیدها را حذف کن.

۴. *ادعا را بیازما:* توضیح‌ها را با منابع معتبر مقایسه کن و گفتهٔ هوش مصنوعی را حکم قطعی ندان. یک چیز را تغییر بده، همان ورودی و یک ورودیِ نزدیک را دوباره اجرا کن و بگو چرا نتیجه با انتظار سازگار شده است.

#note[نمونهٔ پرسش خوب][«در جاوا، برای #code-inline("boats = 0") این قطعه #code-inline("total / boats") خطای #code-inline("ArithmeticException: / by zero") می‌دهد. انتظار دارم وضعیتِ نبود قایق بدون تقسیم مشخص شود. مفهوم ارزیابی کوتاه‌مدار را با یک مثال کوچک توضیح بده و بگو چه دو ورودی را برای آزمودن ادعایت امتحان کنم. پاسخِ نهاییِ کد را ننویس.»]
