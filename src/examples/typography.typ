#import "../course/theme.typ": *
#import "../course/config.typ": course-info
#show: course-document.with(
  kind: "راهنمای نگارش", title: "فارسی، انگلیسی و ریاضی",
  subtitle: "نمونه‌های واقعی برای کنترل جهت متن", number: "01",
  meta: course-info + (instructor: [نام استاد درس], term: [نیمسال نمونه]),
  prepared-by: [نام تهیه‌کننده], issued-on: [تاریخ انتشار سند], deadline: [تاریخ و ساعت مصوب],
)

= عبارت‌های انگلیسی در متن فارسی

برای حرکت کشتی کاوشگر جاوا از کلاس #code-inline("GOval") استفاده کنید. مفهوم تقسیم صحیح #term[(Integer Division)] در یک جملهٔ فارسی، همراه با نشانه‌گذاری صحیح، قرار می‌گیرد.

نام #en[Java]، مفهوم بازگشت، نوع #code-inline("List<String>")، شناسهٔ #code-inline("ArrayList") و عددهای #latin-number("0.75")، #latin-number("-3.5") و #latin-number(10) در نثر فارسی نقش‌های متفاوتی دارند. فقط قطعهٔ کامل برنامه در بلوک کد قرار می‌گیرد.

آیا #code-inline("ship.getX() + ship.getWidth() >= getWidth()") شرط مناسبی است؟ مقدار #math-inline($x^2 + y^2$) را با #math-inline($sqrt(a^2 + b^2)$) مقایسه کنید.

#note[نمونهٔ پرانتز و نشانه‌گذاری][
ارزیابی اتصال کوتاه #en[(Short-Circuit Evaluation)] در #en[Java] چه نتیجه‌ای می‌دهد؟ ورودی #code-inline("timestamp = 10") و خروجی #code-inline("ALLOWED") را بررسی کنید؛ سپس مقدار #math-inline($F_n$) را بنویسید.
]

= پاراگراف کامل انگلیسی
#english[
An English paragraph has its own left-to-right flow and can wrap normally across several lines. The identifiers #code-inline("ship.getX()"), #code-inline("getWidth()"), and #code-inline("timestamp") retain their source order. Parentheses (like these), mathematical notation $x^2 + y^2$, and punctuation follow the paragraph's English direction. Lora supports *bold*, _italic_, and *_bold italic_* emphasis.
]

= ریاضی و کد
$ F_n = cases(1 & "if" n <= 2, F_(n-1) + F_(n-2) & "otherwise") $
$ [0, 10), quad [10, 20), quad [20, 30), quad dots $

#code-block("int x = 4;\nint y = 2;\nif (x % 2 == 0 || ++y > 5) {\n    x += y;\n}\nSystem.out.println(x);\nSystem.out.println(y);")

#pagebreak()
#mission(1, "نمونهٔ عنوان بلند برای کنترل شکست سطر و فاصله‌های صفحه", "۱.۵")
این صفحه سرصفحهٔ ادامه، شمارهٔ صفحه، و یک عنوان بلند را نمایش می‌دهد. از #code-inline("dx = 3") و #code-inline("dy = 2") استفاده کنید.
#part("بخش تحلیلی", points: "۰.۵")
برای #math-inline($n in NN$)، پیچیدگی #math-inline($O(n log n)$) را توضیح دهید.
#checklist(("فارسی راست‌به‌چپ خوانده می‌شود.", "کد و عبارت انگلیسی با ترتیب طبیعی نمایش داده می‌شوند.", "فرمول‌ها با موتور ریاضی تایپست حروف‌چینی شده‌اند."))

== کد در عنوان: #code-inline("List<String>")
اندازهٔ شناسه در عنوان، متناسب با همان عنوان است؛ در نثر، #code-inline("List<String>") متناسب با اندازهٔ متن نمایش داده می‌شود.
