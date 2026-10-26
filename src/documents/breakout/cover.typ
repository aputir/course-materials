#import "../../course/theme.typ": *

// Minimal Black & White Breakout Gameplay Vector Graphic
// Features: Single paddle, single ball, single brick, trajectory traces, angle demonstration,
// with the ball positioned along the outbound trace just before impacting the brick.

#let breakout-cover-vignette() = align(center, block(width: workshop-style.cover-width, breakable: false)[
  #block(
    width: 130mm,
    height: 70mm,
    fill: white,
    radius: 3pt,
    stroke: 0.75pt + rgb("#1A202C"),
    clip: true,
  )[
    #set text(lang: "en", dir: ltr, font: english-font)

    // Corner drafting ticks (minimal framing)
    #let tick-len = 3.5mm
    #let tick-pad = 2.2mm
    #let w-total = 130mm
    #let h-total = 70mm
    #let frame-stroke = 0.35pt + rgb("#A0AEC0")

    // Top-left corner tick
    #place(top + left, dx: tick-pad, dy: tick-pad, line(end: (tick-len, 0mm), stroke: frame-stroke))
    #place(top + left, dx: tick-pad, dy: tick-pad, line(end: (0mm, tick-len), stroke: frame-stroke))
    // Top-right corner tick
    #place(top + left, dx: w-total - tick-pad - tick-len, dy: tick-pad, line(end: (tick-len, 0mm), stroke: frame-stroke))
    #place(top + left, dx: w-total - tick-pad, dy: tick-pad, line(end: (0mm, tick-len), stroke: frame-stroke))
    // Bottom-left corner tick
    #place(top + left, dx: tick-pad, dy: h-total - tick-pad, line(end: (tick-len, 0mm), stroke: frame-stroke))
    #place(top + left, dx: tick-pad, dy: h-total - tick-pad - tick-len, line(end: (0mm, tick-len), stroke: frame-stroke))
    // Bottom-right corner tick
    #place(top + left, dx: w-total - tick-pad - tick-len, dy: h-total - tick-pad, line(end: (tick-len, 0mm), stroke: frame-stroke))
    #place(top + left, dx: w-total - tick-pad, dy: h-total - tick-pad - tick-len, line(end: (0mm, tick-len), stroke: frame-stroke))

    // -------------------------------------------------------------------------
    // 1. SINGLE BRICK (Top-Right)
    // -------------------------------------------------------------------------
    #let brick-x = 90.0mm
    #let brick-y = 12.0mm
    #let brick-w = 22.0mm
    #let brick-h = 7.0mm

    // Brick shadow / offset line for crisp depth
    #place(top + left, dx: brick-x + 0.6mm, dy: brick-y + 0.6mm,
      rect(width: brick-w, height: brick-h, fill: rgb("#EDF2F7"), radius: 1pt))
    // Main Brick rectangle
    #place(top + left, dx: brick-x, dy: brick-y,
      rect(width: brick-w, height: brick-h, fill: white, stroke: 1.1pt + rgb("#1A202C"), radius: 1pt))

    // Subtle dimension or label for brick
    #place(top + left, dx: brick-x + 4.5mm, dy: brick-y + 1.8mm)[
      #text(size: 6.5pt, fill: rgb("#718096"), weight: "medium")[BRICK]
    ]

    // -------------------------------------------------------------------------
    // 2. SINGLE PADDLE (Bottom Center)
    // -------------------------------------------------------------------------
    #let pad-x = 36.0mm
    #let pad-y = 53.0mm
    #let pad-w = 40.0mm
    #let pad-h = 5.0mm

    // Paddle shadow / subtle outline
    #place(top + left, dx: pad-x + 0.6mm, dy: pad-y + 0.6mm,
      rect(width: pad-w, height: pad-h, fill: rgb("#EDF2F7"), radius: 1.2pt))
    // Main Paddle rectangle
    #place(top + left, dx: pad-x, dy: pad-y,
      rect(width: pad-w, height: pad-h, fill: white, stroke: 1.15pt + rgb("#1A202C"), radius: 1.2pt))

    // Center notch on paddle
    #place(top + left, dx: pad-x + pad-w / 2, dy: pad-y - 1.2mm,
      line(end: (0mm, 1.2mm), stroke: 0.6pt + rgb("#718096")))
    #place(top + left, dx: pad-x + pad-w / 2 - 2.5mm, dy: pad-y + 1.2mm)[
      #text(size: 5.5pt, fill: rgb("#A0AEC0"))[PADDLE]
    ]

    // -------------------------------------------------------------------------
    // 3. IMPACT POINT & BALL TRAJECTORY LINES
    // -------------------------------------------------------------------------
    // Impact coordinates on paddle
    #let hit-x = pad-x + 12.0mm   // 48.0mm (left of center, creates clear angle)
    #let hit-y = pad-y           // 53.0mm

    // Brick target impact point (bottom edge of brick)
    #let target-x = brick-x + 8.0mm  // 98.0mm
    #let target-y = brick-y + brick-h // 19.0mm

    // Inbound origin (upper left)
    #let in-start-x = 16.0mm
    #let in-start-y = 17.0mm

    // Inbound trajectory (dashed line)
    #place(top + left,
      line(start: (in-start-x, in-start-y), end: (hit-x, hit-y),
        stroke: (paint: rgb("#2D3748"), dash: "dashed", thickness: 0.75pt)))

    // Inbound direction arrow
    #let mid-in-x = (in-start-x + hit-x) / 2
    #let mid-in-y = (in-start-y + hit-y) / 2
    #place(top + left, dx: mid-in-x - 1.5mm, dy: mid-in-y - 1.5mm)[
      #rotate(48deg)[
        #line(start: (0mm, 0mm), end: (2.2mm, 0mm), stroke: 0.9pt + rgb("#2D3748"))
        #line(start: (1.2mm, -0.9mm), end: (2.2mm, 0mm), stroke: 0.9pt + rgb("#2D3748"))
        #line(start: (1.2mm, 0.9mm), end: (2.2mm, 0mm), stroke: 0.9pt + rgb("#2D3748"))
      ]
    ]

    // Surface Normal at impact (dotted vertical reference)
    #place(top + left,
      line(start: (hit-x, hit-y), end: (hit-x, hit-y - 18.0mm),
        stroke: (paint: rgb("#A0AEC0"), dash: "dotted", thickness: 0.65pt)))
    #place(top + left, dx: hit-x - 1.0mm, dy: hit-y - 21.0mm)[
      #text(size: 6.5pt, fill: rgb("#718096"), style: "italic")[N]
    ]

    // Right-angle symbol (perpendicular to paddle surface)
    #place(top + left, dx: hit-x + 0.3mm, dy: hit-y - 2.8mm,
      line(end: (2.5mm, 0mm), stroke: 0.45pt + rgb("#A0AEC0")))
    #place(top + left, dx: hit-x + 2.8mm, dy: hit-y - 2.8mm,
      line(end: (0mm, 2.8mm), stroke: 0.45pt + rgb("#A0AEC0")))

    // Angle arcs & labels
    // Incident angle arc (between inbound and normal)
    #place(top + left, dx: hit-x - 9.0mm, dy: hit-y - 9.5mm)[
      #text(size: 7.2pt, fill: rgb("#2D3748"))[$theta_i$]
    ]
    // Reflected angle arc (between normal and outbound)
    #place(top + left, dx: hit-x + 4.5mm, dy: hit-y - 9.5mm)[
      #text(size: 7.2pt, fill: rgb("#2D3748"))[$theta_r$]
    ]
    // Law of reflection equality note
    #place(top + left, dx: hit-x - 22.0mm, dy: hit-y - 14.5mm)[
      #text(size: 6.5pt, fill: rgb("#718096"), weight: "medium")[$theta_i = theta_r$]
    ]

    // Outbound trajectory line from paddle impact to brick target
    #place(top + left,
      line(start: (hit-x, hit-y), end: (target-x, target-y),
        stroke: (paint: rgb("#2D3748"), dash: "dashed", thickness: 0.75pt)))

    // -------------------------------------------------------------------------
    // 4. BALL (Positioned on the outbound trace, just before the brick)
    // -------------------------------------------------------------------------
    // Parametric position along outbound trace: t = 0.82 (just before impact)
    #let t-ball = 0.80
    #let ball-x = hit-x + t-ball * (target-x - hit-x) // ~88.0mm
    #let ball-y = hit-y + t-ball * (target-y - hit-y) // ~25.8mm
    #let ball-r = 2.4mm

    // Ball circle (clean crisp white with black stroke)
    #place(top + left, dx: ball-x - ball-r, dy: ball-y - ball-r,
      circle(radius: ball-r, fill: white, stroke: 1.15pt + rgb("#1A202C")))

    // Velocity vector arrow from ball pointing towards brick
    #let v-angle = -34.2deg
    #place(top + left, dx: ball-x + 0.8mm, dy: ball-y - 0.8mm)[
      #rotate(v-angle)[
        #line(start: (0mm, 0mm), end: (4.5mm, 0mm), stroke: 1.0pt + rgb("#1A202C"))
        #line(start: (3.2mm, -1.0mm), end: (4.5mm, 0mm), stroke: 1.0pt + rgb("#1A202C"))
        #line(start: (3.2mm, 1.0mm), end: (4.5mm, 0mm), stroke: 1.0pt + rgb("#1A202C"))
      ]
    ]

    // Velocity vector label
    #place(top + left, dx: ball-x - 6.0mm, dy: ball-y - 6.0mm)[
      #text(size: 7.2pt, fill: rgb("#1A202C"), weight: "bold")[$arrow(v)$]
    ]

    // Ghost circle at impact point on paddle to show contact
    #place(top + left, dx: hit-x - ball-r, dy: hit-y - ball-r,
      circle(radius: ball-r, stroke: (paint: rgb("#A0AEC0"), dash: "dotted", thickness: 0.55pt)))

    // Ghost circle at target on brick to show impending contact
    #place(top + left, dx: target-x - ball-r, dy: target-y - ball-r,
      circle(radius: ball-r, stroke: (paint: rgb("#CBD5E0"), dash: "dotted", thickness: 0.45pt)))
  ]

  #v(2.5mm)

  // Framed quote block containing 1976 Wozniak/Jobs Atari 44-chip historical fun fact
  #block(
    width: 100%,
    stroke: workshop-style.frame-stroke + colors.ink,
    radius: workshop-style.frame-radius,
    inset: (x: 10pt, y: 5.5pt),
    above: 0pt,
    below: 0pt,
    breakable: false,
  )[
    #set text(font: prose-fonts, size: 7.8pt, fill: colors.ink, lang: "fa", dir: rtl)
    #set par(justify: true, leading: 4.0pt, spacing: 0pt)
    «در سال ۱۹۷۶، نولان باشنل در شرکت آتاری از استیو جابز خواست بازی #en[Breakout] را با کمترین تعداد تراشه سخت‌افزاری بسازد. جابز پروژه را به استیو وازنیاک سپرد؛ وازنیاک طی ۴ شبانه‌روز کار بی‌وقفه، مدار بازی را تنها با ۴۴ تراشه پیاده کرد. ابتکارات وازنیاک در بهینه‌سازی مدارهای گرافیکی این بازی، مستقیماً الهام‌بخش او در طراحی معماری نمایش تصویر و رنگ در رایانه انقلابی #en[Apple II] شد.»
  ]

  #v(1.5mm)

  #prompt-example("پرامپت پیشنهادی برای بازتولید تصویر خطی گیم‌پلی")[
    #set text(font: english-font, size: 6.8pt, style: "italic", fill: colors.muted, lang: "en", dir: ltr)
    #set par(leading: 3.2pt)
    Minimalist black and white technical line art of 1976 Breakout game mechanics, single paddle at bottom, single brick at top, dashed trajectory line showing angle of reflection off paddle, and single ball right before impact with brick, clean vector geometry, high contrast.
  ]
])
