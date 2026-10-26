#import "../../course/theme.typ": *

#let breakout-cover-vignette() = align(center, block(width: workshop-style.cover-width, breakable: false)[
  #block(
    width: 130mm,
    height: 65mm,
    fill: rgb("122236"),
    radius: 3pt,
    stroke: 0.75pt + rgb("1E4976"),
    clip: true,
  )[
    // Background technical grid (5mm minor grid)
    #for gx in range(1, 26) {
      place(top + left, dx: gx * 5mm, dy: 0mm,
        line(end: (0mm, 65mm), stroke: 0.2pt + rgb("16324F")))
    }
    #for gy in range(1, 13) {
      place(top + left, dx: 0mm, dy: gy * 5mm,
        line(end: (130mm, 0mm), stroke: 0.2pt + rgb("16324F")))
    }

    // Major grid lines
    #for mx in (25, 65, 105) {
      place(top + left, dx: mx * 1mm, dy: 0mm,
        line(end: (0mm, 65mm), stroke: 0.35pt + rgb("1E4369")))
    }
    #for my in (20, 45) {
      place(top + left, dx: 0mm, dy: my * 1mm,
        line(end: (130mm, 0mm), stroke: 0.35pt + rgb("1E4369")))
    }

    // Playfield outer border
    #place(top + left, dx: 10mm, dy: 5mm,
      rect(width: 110mm, height: 53mm, stroke: 0.65pt + rgb("2E628D")))

    // Corner crosshairs
    #for (cx, cy) in ((10mm, 5mm), (120mm, 5mm), (10mm, 58mm), (120mm, 58mm)) {
      place(top + left, dx: cx - 1.5mm, dy: cy,
        line(end: (3mm, 0mm), stroke: 0.5pt + rgb("00D8F6")))
      place(top + left, dx: cx, dy: cy - 1.5mm,
        line(end: (0mm, 3mm), stroke: 0.5pt + rgb("00D8F6")))
    }

    // Matrix of bricks (5 rows x 8 cols, muted arcade colors)
    #let brick-colors = (
      rgb("E05A47"), // Red (row 0)
      rgb("E88834"), // Orange (row 1)
      rgb("ECC94B"), // Yellow (row 2)
      rgb("48BB78"), // Green (row 3)
      rgb("38B2AC"), // Cyan (row 4)
    )
    #let b-width = 11.4mm
    #let b-height = 2.5mm
    #let b-gap-x = 1.25mm
    #let b-gap-y = 1.0mm
    #let start-x = 15.0mm
    #let start-y = 9.0mm

    #for row in range(5) {
      let b-col = brick-colors.at(row)
      let cur-y = start-y + row * (b-height + b-gap-y)
      for col in range(8) {
        let cur-x = start-x + col * (b-width + b-gap-x)
        // Simulate hit/cleared brick at row 4, col 4
        if row == 4 and col == 4 {
          place(top + left, dx: cur-x, dy: cur-y,
            rect(width: b-width, height: b-height, stroke: (paint: b-col.lighten(40%), dash: "dashed", thickness: 0.45pt), radius: 0.5pt))
          // Shatter debris particles
          place(top + left, dx: cur-x + 2mm, dy: cur-y - 0.8mm,
            rect(width: 1.0mm, height: 0.6mm, fill: b-col, radius: 0.2pt))
          place(top + left, dx: cur-x + 7mm, dy: cur-y + 1.2mm,
            rect(width: 0.7mm, height: 0.9mm, fill: b-col, radius: 0.2pt))
        } else if row == 3 and col == 4 {
          // Weakened/cracked brick
          place(top + left, dx: cur-x, dy: cur-y,
            rect(width: b-width, height: b-height, fill: b-col.darken(15%), stroke: 0.4pt + b-col.lighten(20%), radius: 0.5pt))
          place(top + left, dx: cur-x + 3mm, dy: cur-y,
            line(end: (4mm, b-height), stroke: 0.4pt + white.transparentize(30%)))
        } else {
          // Standard intact brick
          place(top + left, dx: cur-x, dy: cur-y,
            rect(width: b-width, height: b-height, fill: b-col, stroke: 0.3pt + b-col.lighten(30%), radius: 0.5pt))
        }
      }
    }

    // Paddle (green rounded rect at bottom center, 100x15 proportion)
    #let pad-w = 25mm
    #let pad-h = 3.75mm
    #let pad-x = 52.5mm
    #let pad-y = 50.0mm
    #place(top + left, dx: pad-x, dy: pad-y,
      rect(width: pad-w, height: pad-h, fill: rgb("38D39F"), radius: 1.4pt, stroke: 0.8pt + rgb("A7F3D0")))

    // Paddle center notch
    #place(top + left, dx: 65mm, dy: 49.0mm,
      line(end: (0mm, 1.2mm), stroke: 0.6pt + rgb("A7F3D0")))
    #place(top + left, dx: 63.2mm, dy: 46.2mm)[
      #text(font: code-font, size: 4.2pt, fill: rgb("A7F3D0"))[cx = 0]
    ]

    // Paddle dimension label & ticks
    #place(top + left, dx: pad-x, dy: 54.8mm,
      line(end: (pad-w, 0mm), stroke: 0.4pt + rgb("7CE4FE")))
    #place(top + left, dx: pad-x, dy: 54.0mm,
      line(end: (0mm, 1.6mm), stroke: 0.4pt + rgb("7CE4FE")))
    #place(top + left, dx: pad-x + pad-w, dy: 54.0mm,
      line(end: (0mm, 1.6mm), stroke: 0.4pt + rgb("7CE4FE")))
    #place(top + left, dx: 54.8mm, dy: 55.4mm)[
      #text(font: code-font, size: 4.8pt, fill: rgb("7CE4FE"))[PADDLE: 100 × 15 px]
    ]

    // Deflection trajectory vectors & Ball
    // 1. Inbound vector from left wall bounce (22mm, 28mm) to paddle (59.0mm, 50.0mm)
    #place(top + left, dx: 0mm, dy: 0mm,
      line(start: (22mm, 28mm), end: (59.0mm, 50.0mm),
        stroke: (paint: rgb("7CE4FE").darken(10%), dash: "dotted", thickness: 0.65pt)))
    // Inbound arrow head at (40.5mm, 39.0mm)
    #place(top + left, dx: 39.5mm, dy: 38.0mm)[
      #line(start: (0mm, 0mm), end: (1.5mm, 0.9mm), stroke: 0.6pt + rgb("7CE4FE"))
      #line(start: (1.5mm, 0.9mm), end: (0.3mm, 1.6mm), stroke: 0.6pt + rgb("7CE4FE"))
    ]

    // Paddle surface normal at impact
    #place(top + left, dx: 0mm, dy: 0mm,
      line(start: (59.0mm, 50.0mm), end: (59.0mm, 42.0mm),
        stroke: (paint: rgb("7CE4FE"), dash: "dashed", thickness: 0.35pt)))
    #place(top + left, dx: 43.5mm, dy: 43.0mm)[
      #text(font: code-font, size: 4.2pt, fill: rgb("7CE4FE"))[θ = offset · 60°]
    ]

    // 2. Outbound deflected trajectory vector from (59.0mm, 50.0mm) to brick at (67.5mm, 24.5mm)
    #place(top + left, dx: 0mm, dy: 0mm,
      line(start: (59.0mm, 50.0mm), end: (67.5mm, 24.5mm),
        stroke: (paint: rgb("00E5FF"), dash: "dotted", thickness: 0.85pt)))
    // Arrow head into brick at (67.0mm, 26.0mm)
    #place(top + left, dx: 66.0mm, dy: 24.5mm)[
      #line(start: (0mm, 1.5mm), end: (1.5mm, 0mm), stroke: 0.8pt + rgb("00E5FF"))
      #line(start: (1.5mm, 0mm), end: (1.5mm, 1.5mm), stroke: 0.8pt + rgb("00E5FF"))
    ]

    // 3. Ball on outbound trajectory at (63.5mm, 36.5mm)
    #place(top + left, dx: 63.5mm - 2.1mm, dy: 36.5mm - 2.1mm,
      circle(radius: 2.1mm, fill: rgb("FCD34D"), stroke: 0.75pt + rgb("F59E0B")))
    // Ball velocity vector
    #place(top + left, dx: 0mm, dy: 0mm,
      line(start: (63.5mm, 36.5mm), end: (65.2mm, 31.5mm), stroke: 0.8pt + rgb("FDE047")))
    #place(top + left, dx: 67.2mm, dy: 34.5mm)[
      #text(font: code-font, size: 4.6pt, fill: rgb("FCD34D"))[BALL (r = 8)]
    ]
    #place(top + left, dx: 67.2mm, dy: 38.5mm)[
      #text(font: code-font, size: 4.0pt, fill: rgb("FDE047"))[v = hypot(vx, vy)]
    ]

    // Technical dimension & status labels
    #place(top + left, dx: 11.5mm, dy: 6.2mm)[
      #text(font: code-font, size: 4.5pt, fill: rgb("00E5FF"))[CANVAS: 800 × 600 px | ASPECT: 4:3 | TICK: 60 Hz]
    ]
    #place(top + left, dx: 86.5mm, dy: 6.2mm)[
      #text(font: code-font, size: 4.5pt, fill: rgb("8BE9FD"))[BRICK ARRAY: 5 × 8 = 40 | +100 PTS]
    ]
    #place(top + left, dx: 11.5mm, dy: 56.5mm)[
      #text(font: code-font, size: 4.2pt, fill: rgb("627489"))[X_MIN = 0]
    ]
    #place(top + left, dx: 104.5mm, dy: 56.5mm)[
      #text(font: code-font, size: 4.2pt, fill: rgb("627489"))[X_MAX = 800]
    ]
    #place(top + left, dx: 11.5mm, dy: 61.2mm)[
      #text(font: code-font, size: 4.2pt, fill: rgb("4A7596"))[CONTROL: ARROWS | SERVE: SPACE | PAUSE: P | RESET: R]
    ]
    #place(top + left, dx: 106.5mm, dy: 61.2mm)[
      #text(font: code-font, size: 4.2pt, fill: rgb("4A7596"))[UT AP | PH-01]
    ]
  ]

  #v(3mm)

  // Framed quote block containing 1976 Wozniak/Jobs Atari 44-chip historical fun fact
  #block(
    width: 100%,
    stroke: workshop-style.frame-stroke + colors.ink,
    radius: workshop-style.frame-radius,
    inset: (x: 10pt, y: 7pt),
    above: 0pt,
    below: 0pt,
    breakable: false,
  )[
    #set text(font: prose-fonts, size: 8pt, fill: colors.ink, lang: "fa", dir: rtl)
    #set par(justify: true, leading: 4.2pt, spacing: 0pt)
    «در سال ۱۹۷۶، نولان باشنل در شرکت آتاری از استیو جابز خواست بازی #en[Breakout] را با کمترین تعداد تراشهٔ سخت‌افزاری بسازد. جابز پروژه را به استیو وازنیاک سپرد؛ وازنیاک طی ۴ شبانه‌روز کار بی‌وقفه، مدار بازی را تنها با ۴۴ تراشه پیاده کرد. ابتکارات وازنیاک در بهینه‌سازی مدارهای گرافیکی این بازی، مستقیماً الهام‌بخش او در طراحی معماری نمایش تصویر و رنگ در رایانهٔ انقلابی #en[Apple II] شد.»
  ]

  #prompt-example("پرامپت پیشنهادی برای تولید تصویر هنری کاور")[
    #set text(font: english-font, size: 7.2pt, style: "italic", fill: colors.muted, lang: "en", dir: ltr)
    #set par(leading: 3.5pt)
    Technical blueprint drawing of classic 1976 Breakout arcade game, showing green phosphor wireframe paddle, mathematical ball deflection angles, and brick array grid on deep navy blueprint paper, clean line art, precise dimension labels, engineering schematic style.
  ]
])
