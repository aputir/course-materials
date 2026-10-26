#import "../../course/theme.typ": *

// Breakout Arcade Engineering Blueprint Cover Vignette
// Implemented according to the 1976 Breakout Technical Blueprint Specification:
// Vector-first poster layout with dark navy background, green phosphor strokes,
// two-column technical architecture, exact dimension lines, brick matrix, kinematics, and reflection math.

#let bp-bg = rgb("#052B49")         // Midnight blueprint navy
#let bp-primary = rgb("#62F2C2")    // Luminous cyan-green (primary strokes)
#let bp-highlight = rgb("#A0FFDA")  // Phosphor mint highlight
#let bp-secondary = rgb("#36C9C5")  // Cyan-teal (panel dividers & secondary lines)
#let bp-text = rgb("#E3FFF7")       // Pale mint (body text & formulas)
#let bp-dim = rgb("#80C8C7")        // Muted cyan (grid & dimensions)

#let breakout-cover-vignette() = align(center, block(width: workshop-style.cover-width, breakable: false)[
  #block(
    width: 130mm,
    height: 70mm,
    fill: bp-bg,
    radius: 2.5pt,
    stroke: 0.65pt + bp-secondary,
    clip: true,
  )[
    #set text(lang: "en", dir: ltr, font: code-font)

    // -------------------------------------------------------------------------
    // 0. BLUEPRINT BACKGROUND GRID & OUTER FRAME
    // -------------------------------------------------------------------------
    // Minor technical grid (5mm grid lines with subtle opacity)
    #for gx in range(1, 26) {
      place(top + left, dx: gx * 5mm, dy: 0mm,
        line(end: (0mm, 70mm), stroke: 0.15pt + bp-dim.transparentize(85%)))
    }
    #for gy in range(1, 14) {
      place(top + left, dx: 0mm, dy: gy * 5mm,
        line(end: (130mm, 0mm), stroke: 0.15pt + bp-dim.transparentize(85%)))
    }

    // Outer border inset (~1.6mm)
    #place(top + left, dx: 1.6mm, dy: 1.6mm,
      rect(width: 126.8mm, height: 66.8mm, stroke: 0.35pt + bp-secondary))

    // Corner drafting crosshairs (+)
    #for (cx, cy) in ((1.6mm, 1.6mm), (128.4mm, 1.6mm), (1.6mm, 68.4mm), (128.4mm, 68.4mm)) {
      place(top + left, dx: cx - 1.4mm, dy: cy,
        line(end: (2.8mm, 0mm), stroke: 0.45pt + bp-highlight))
      place(top + left, dx: cx, dy: cy - 1.4mm,
        line(end: (0mm, 2.8mm), stroke: 0.45pt + bp-highlight))
    }

    // -------------------------------------------------------------------------
    // 1. HEADER BAND (5.5% Page Proportions)
    // -------------------------------------------------------------------------
    // Main Title & Subtitle (Left)
    #place(top + left, dx: 3.6mm, dy: 2.5mm)[
      #text(size: 7.2pt, weight: "bold", fill: bp-highlight)[BREAKOUT#super[TM]]
      #h(4pt)
      #text(size: 4.6pt, weight: "medium", fill: bp-primary)[ARCADE GAME (1976)]
    ]
    #place(top + left, dx: 3.6mm, dy: 5.8mm)[
      #text(size: 3.3pt, fill: bp-dim)[ATARI INC. · HARDWARE: S. WOZNIAK · CIRCUIT: 44 TTL CHIPS · 60 HZ RASTER]
    ]

    // Blueprint Classification & Sheet Info (Right)
    #place(top + left, dx: 87.5mm, dy: 2.5mm)[
      #text(size: 4.8pt, weight: "bold", fill: bp-highlight)[TECHNICAL BLUEPRINT]
    ]
    #place(top + left, dx: 87.5mm, dy: 4.8mm)[
      #text(size: 3.3pt, fill: bp-dim)[DIMENSIONS & RE-ENGINEERING SPECS]
    ]
    #place(top + left, dx: 87.5mm, dy: 6.8mm)[
      #text(size: 3.1pt, fill: bp-secondary)[SCALE: 1:1 LOGICAL · DWG: AT-1976-BK]
    ]

    // Header divider rule
    #place(top + left, dx: 1.6mm, dy: 9.2mm,
      line(end: (126.8mm, 0mm), stroke: 0.4pt + bp-secondary))

    // Vertical column divider (Main column ~66% width = 84mm, Right ~33% = 43mm)
    #place(top + left, dx: 85.5mm, dy: 9.2mm,
      line(end: (0mm, 59.2mm), stroke: 0.35pt + bp-secondary))

    // -------------------------------------------------------------------------
    // 2. MAIN COLUMN (LEFT, x: 1.6mm - 85.5mm): PLAYFIELD & KINEMATICS
    // -------------------------------------------------------------------------
    // HUD / Score Bar
    #place(top + left, dx: 4.8mm, dy: 10.3mm)[
      #text(size: 3.4pt, fill: bp-highlight)[SCORE <1> 0000]
    ]
    #place(top + left, dx: 34.0mm, dy: 10.3mm)[
      #text(size: 3.4pt, fill: bp-primary)[HIGH 0840]
    ]
    #place(top + left, dx: 63.0mm, dy: 10.3mm)[
      #text(size: 3.4pt, fill: bp-highlight)[BALL 1/3 (3 LIVES)]
    ]

    // Playfield viewport frame (width: 77mm, height: 43.5mm)
    #let pf-x = 4.8mm
    #let pf-y = 13.5mm
    #let pf-w = 77.0mm
    #let pf-h = 43.5mm

    #place(top + left, dx: pf-x, dy: pf-y,
      rect(width: pf-w, height: pf-h, stroke: 0.45pt + bp-primary))

    // Playfield corner ticks (+)
    #for (tcx, tcy) in (
      (pf-x, pf-y), (pf-x + pf-w, pf-y),
      (pf-x, pf-y + pf-h), (pf-x + pf-w, pf-y + pf-h)
    ) {
      place(top + left, dx: tcx - 1.2mm, dy: tcy,
        line(end: (2.4mm, 0mm), stroke: 0.4pt + bp-highlight))
      place(top + left, dx: tcx, dy: tcy - 1.2mm,
        line(end: (0mm, 2.4mm), stroke: 0.4pt + bp-highlight))
    }

    // Playfield Coordinate System Indicators
    #place(top + left, dx: pf-x + 1.2mm, dy: pf-y + 1.2mm)[
      #text(size: 3.1pt, fill: bp-dim)[(0,0)]
      #line(start: (0mm, 0.7mm), end: (3.0mm, 0.7mm), stroke: 0.3pt + bp-dim)
      #line(start: (0mm, 0.7mm), end: (0mm, 3.8mm), stroke: 0.3pt + bp-dim)
    ]
    #place(top + left, dx: pf-x + 22.0mm, dy: pf-y + 1.2mm)[
      #text(size: 2.8pt, fill: bp-dim)[BRICK ARRAY: 8 COLS x 6 ROWS (48 TOTAL)]
    ]
    #place(top + left, dx: pf-x + pf-w - 11.2mm, dy: pf-y + 1.2mm)[
      #text(size: 2.9pt, fill: bp-dim)[X_MAX: 224]
    ]
    #place(top + left, dx: pf-x + 1.2mm, dy: pf-y + pf-h - 3.6mm)[
      #text(size: 2.9pt, fill: bp-dim)[Y_MAX: 256]
    ]
    #place(top + left, dx: pf-x + pf-w - 17.5mm, dy: pf-y + pf-h - 3.6mm)[
      #text(size: 2.9pt, fill: bp-dim)[ASPECT: 7:8 (CRT)]
    ]

    // Playfield Dimension Lines
    // Top Dimension Line (224 px)
    #place(top + left, dx: pf-x, dy: pf-y - 1.2mm)[
      #line(start: (0mm, 0mm), end: (pf-w, 0mm), stroke: 0.22pt + bp-dim)
      #line(start: (0mm, -0.5mm), end: (0mm, 0.5mm), stroke: 0.22pt + bp-dim)
      #line(start: (pf-w, -0.5mm), end: (pf-w, 0.5mm), stroke: 0.22pt + bp-dim)
    ]
    // Left Dimension Line (256 px)
    #place(top + left, dx: pf-x - 1.2mm, dy: pf-y)[
      #line(start: (0mm, 0mm), end: (0mm, pf-h), stroke: 0.22pt + bp-dim)
      #line(start: (-0.5mm, 0mm), end: (0.5mm, 0mm), stroke: 0.22pt + bp-dim)
      #line(start: (-0.5mm, pf-h), end: (0.5mm, pf-h), stroke: 0.22pt + bp-dim)
    ]
    #place(top + left, dx: 1.8mm, dy: pf-y + pf-h / 2 - 4mm)[
      #text(size: 2.6pt, fill: bp-dim)[256]
    ]

    // -------------------------------------------------------------------------
    // BRICK ARRAY (8 Columns x 6 Rows, thin wireframe outline per spec)
    // -------------------------------------------------------------------------
    #let b-cols = 8
    #let b-rows = 6
    #let b-w = 7.4mm
    #let b-h = 1.75mm
    #let b-gx = 1.2mm
    #let b-gy = 0.8mm
    #let b-start-x = pf-x + 4.6mm
    #let b-start-y = pf-y + 4.6mm

    #for r in range(b-rows) {
      let cur-y = b-start-y + r * (b-h + b-gy)
      for c in range(b-cols) {
        let cur-x = b-start-x + c * (b-w + b-gx)
        if r == 4 and c == 4 {
          // Destroyed / cleared brick at (4, 4) with impact debris
          place(top + left, dx: cur-x, dy: cur-y,
            rect(width: b-w, height: b-h, stroke: (paint: bp-primary, dash: "dashed", thickness: 0.35pt), radius: 0.3pt))
          // Flying fragments
          place(top + left, dx: cur-x + 1.5mm, dy: cur-y - 0.7mm,
            rect(width: 0.7mm, height: 0.4mm, fill: bp-highlight, radius: 0.1pt))
          place(top + left, dx: cur-x + 5.2mm, dy: cur-y + 1.2mm,
            rect(width: 0.5mm, height: 0.6mm, fill: bp-primary, radius: 0.1pt))
        } else if r == 3 and c == 4 {
          // Weakened / cracked brick
          place(top + left, dx: cur-x, dy: cur-y,
            rect(width: b-w, height: b-h, stroke: 0.35pt + bp-primary, radius: 0.3pt))
          place(top + left, dx: cur-x + 2.2mm, dy: cur-y,
            line(end: (3.0mm, b-h), stroke: 0.35pt + bp-highlight))
        } else {
          // Standard wireframe brick
          place(top + left, dx: cur-x, dy: cur-y,
            rect(width: b-w, height: b-h, stroke: 0.28pt + bp-primary, radius: 0.3pt))
        }
      }
    }

    // -------------------------------------------------------------------------
    // PADDLE DETAIL (Bottom center, double-line detail & center notch)
    // -------------------------------------------------------------------------
    #let pad-w = 20.0mm
    #let pad-h = 2.4mm
    #let pad-x = pf-x + 28.5mm
    #let pad-y = pf-y + 36.5mm

    // Outer paddle rounded rect
    #place(top + left, dx: pad-x, dy: pad-y,
      rect(width: pad-w, height: pad-h, fill: bp-primary.transparentize(80%), stroke: 0.45pt + bp-primary, radius: 0.8pt))
    // Inner precision line (double-line detail)
    #place(top + left, dx: pad-x + 0.6mm, dy: pad-y + 0.6mm,
      rect(width: pad-w - 1.2mm, height: pad-h - 1.2mm, stroke: 0.2pt + bp-highlight, radius: 0.4pt))

    // Paddle Center Notch & cx = 0
    #place(top + left, dx: pad-x + pad-w / 2, dy: pad-y - 1.4mm,
      line(end: (0mm, 1.4mm), stroke: 0.4pt + bp-highlight))
    #place(top + left, dx: pad-x + pad-w / 2 - 4.5mm, dy: pad-y - 2.8mm)[
      #text(size: 2.8pt, fill: bp-highlight)[cx = 0]
    ]

    // Paddle Dimension Annotation
    #place(top + left, dx: pad-x, dy: pad-y + pad-h + 0.8mm)[
      #line(start: (0mm, 0mm), end: (pad-w, 0mm), stroke: 0.25pt + bp-dim)
      #line(start: (0mm, -0.5mm), end: (0mm, 0.5mm), stroke: 0.25pt + bp-dim)
      #line(start: (pad-w, -0.5mm), end: (pad-w, 0.5mm), stroke: 0.25pt + bp-dim)
    ]
    #place(top + left, dx: pad-x + 3.0mm, dy: pad-y + pad-h + 1.2mm)[
      #text(size: 2.8pt, fill: bp-dim)[PADDLE: 58 x 8 px]
    ]

    // -------------------------------------------------------------------------
    // BALL & TRAJECTORY DEFLECTION VECTORS
    // -------------------------------------------------------------------------
    // Impact point on paddle
    #let hit-x = pad-x + 6.0mm
    #let hit-y = pad-y

    // Inbound trajectory (from left wall bounce at pf-x to paddle impact)
    #place(top + left, dx: 0mm, dy: 0mm,
      line(start: (pf-x, pf-y + 20.0mm), end: (hit-x, hit-y),
        stroke: (paint: bp-secondary, dash: "dashed", thickness: 0.4pt)))
    // Arrow on inbound trajectory
    #place(top + left, dx: 18.0mm, dy: 38.0mm)[
      #line(start: (0mm, 0mm), end: (1.2mm, 0.7mm), stroke: 0.45pt + bp-secondary)
      #line(start: (1.2mm, 0.7mm), end: (0.3mm, 1.4mm), stroke: 0.45pt + bp-secondary)
    ]

    // Surface Normal Vector at Paddle Impact
    #place(top + left, dx: hit-x, dy: hit-y - 6.0mm,
      line(end: (0mm, 6.0mm), stroke: (paint: bp-dim, dash: "dotted", thickness: 0.3pt)))
    #place(top + left, dx: hit-x - 11.5mm, dy: hit-y - 4.5mm)[
      #text(size: 2.7pt, fill: bp-dim)[NORMAL N]
    ]

    // Deflection Angle Arc
    #place(top + left, dx: hit-x - 15.0mm, dy: hit-y - 8.2mm)[
      #text(size: 2.9pt, fill: bp-highlight)[theta = offset · 60°]
    ]

    // Outbound Deflected Trajectory (from paddle impact through ball into brick)
    #let brick-hit-x = b-start-x + 4 * (b-w + b-gx) + b-w / 2
    #let brick-hit-y = b-start-y + 4 * (b-h + b-gy) + b-h

    #place(top + left, dx: 0mm, dy: 0mm,
      line(start: (hit-x, hit-y), end: (brick-hit-x, brick-hit-y),
        stroke: (paint: bp-primary, dash: "dashed", thickness: 0.55pt)))
    // Impact arrow into brick
    #place(top + left, dx: brick-hit-x - 0.7mm, dy: brick-hit-y + 0.3mm)[
      #line(start: (0mm, 1.2mm), end: (0.7mm, 0mm), stroke: 0.6pt + bp-primary)
      #line(start: (0.7mm, 0mm), end: (1.4mm, 1.2mm), stroke: 0.6pt + bp-primary)
    ]

    // Reflected trajectory off brick towards right wall
    #place(top + left, dx: 0mm, dy: 0mm,
      line(start: (brick-hit-x, brick-hit-y - b-h), end: (pf-x + pf-w, pf-y + 18.0mm),
        stroke: (paint: bp-secondary, dash: "dotted", thickness: 0.35pt)))

    // Ball on Outbound Trajectory
    #let ball-x = hit-x + 0.52 * (brick-hit-x - hit-x)
    #let ball-y = hit-y + 0.52 * (brick-hit-y - hit-y)
    #let ball-r = 1.35mm

    #place(top + left, dx: ball-x - ball-r, dy: ball-y - ball-r,
      circle(radius: ball-r, fill: bp-highlight, stroke: 0.5pt + bp-primary))

    // Velocity Vector Arrow from Ball
    #place(top + left, dx: ball-x, dy: ball-y)[
      #line(start: (0mm, 0mm), end: (2.2mm, -3.2mm), stroke: 0.55pt + bp-highlight)
    ]
    #place(top + left, dx: ball-x + 2.5mm, dy: ball-y - 2.8mm)[
      #text(size: 3.1pt, fill: bp-highlight)[BALL (r = 4 px)]
    ]
    #place(top + left, dx: ball-x + 2.5mm, dy: ball-y + 0.5mm)[
      #text(size: 2.8pt, fill: bp-text)[v = hypot(vx, vy)]
    ]

    // -------------------------------------------------------------------------
    // LOWER TECHNICAL STRIP (Main Column Bottom)
    // -------------------------------------------------------------------------
    #place(top + left, dx: 1.6mm, dy: 58.2mm,
      line(end: (83.9mm, 0mm), stroke: 0.35pt + bp-secondary))

    #place(top + left, dx: 3.6mm, dy: 59.4mm)[
      #text(size: 3.2pt, weight: "bold", fill: bp-highlight)[PADDLE DEFLECTION]
      #linebreak()
      #text(size: 2.8pt, fill: bp-text)[9 SEGMENTS · theta in [-60, +60] deg]
      #linebreak()
      #text(size: 2.6pt, fill: bp-dim)[SPEED MULTIPLIER: 1.0x - 1.4x]
    ]
    #place(top + left, dx: 32.5mm, dy: 59.4mm)[
      #text(size: 3.2pt, weight: "bold", fill: bp-highlight)[ELASTIC COLLISION]
      #linebreak()
      #text(size: 2.8pt, fill: bp-text)[RESTITUTION e = 1.0 (CONSERVED)]
      #linebreak()
      #text(size: 2.6pt, fill: bp-dim)[CLAMP: |vx| in [1.5, 8.0] px/tick]
    ]
    #place(top + left, dx: 60.5mm, dy: 59.4mm)[
      #text(size: 3.2pt, weight: "bold", fill: bp-highlight)[CONTROL MAPPING]
      #linebreak()
      #text(size: 2.8pt, fill: bp-text)[ARROWS: MOVE · SPACE: SERVE]
      #linebreak()
      #text(size: 2.6pt, fill: bp-dim)[KEY P: PAUSE · KEY R: RESTART]
    ]

    // -------------------------------------------------------------------------
    // 3. RIGHT TECHNICAL COLUMN (x: 85.5mm - 128.4mm): MATHEMATICS & PANELS
    // -------------------------------------------------------------------------

    // PANEL 1: BRICK ARRAY SPECIFICATION (y: 9.2mm - 23.0mm)
    #place(top + left, dx: 87.5mm, dy: 10.4mm)[
      #text(size: 3.8pt, weight: "bold", fill: bp-highlight)[01 — BRICK SPECIFICATION]
    ]
    // Mini Brick Wireframe Diagram
    #place(top + left, dx: 87.5mm, dy: 13.8mm)[
      #rect(width: 5.6mm, height: 1.8mm, stroke: 0.3pt + bp-primary)
      #place(top + left, dx: 6.8mm, dy: 0mm,
        rect(width: 5.6mm, height: 1.8mm, stroke: 0.3pt + bp-primary))
      #line(start: (0mm, 2.4mm), end: (5.6mm, 2.4mm), stroke: 0.2pt + bp-dim)
      #place(top + left, dx: 1.0mm, dy: 2.7mm)[
        #text(size: 2.4pt, fill: bp-dim)[28 px]
      ]
      #line(start: (5.6mm, -0.6mm), end: (6.8mm, -0.6mm), stroke: 0.2pt + bp-dim)
      #place(top + left, dx: 5.4mm, dy: -2.3mm)[
        #text(size: 2.3pt, fill: bp-dim)[4]
      ]
    ]
    #place(top + left, dx: 103.5mm, dy: 13.2mm)[
      #text(size: 2.9pt, fill: bp-text)[GRID: 8 COLS x 6 ROWS]
      #linebreak()
      #text(size: 2.9pt, fill: bp-highlight)[COUNT: 48 TILES]
      #linebreak()
      #text(size: 2.9pt, fill: bp-text)[VALUE: +100 PTS/HIT]
    ]

    // Divider Rule 1
    #place(top + left, dx: 85.5mm, dy: 23.2mm,
      line(end: (42.9mm, 0mm), stroke: 0.3pt + bp-secondary))

    // PANEL 2: DEFLECTION & REFLECTION LAWS (y: 23.2mm - 37.8mm)
    #place(top + left, dx: 87.5mm, dy: 24.2mm)[
      #text(size: 3.8pt, weight: "bold", fill: bp-highlight)[02 — REFLECTION LAWS]
    ]
    // Mini Ray Reflection Diagram
    #place(top + left, dx: 88.0mm, dy: 29.5mm)[
      // Wall boundary
      #line(start: (0mm, 0mm), end: (12.0mm, 0mm), stroke: 0.4pt + bp-secondary)
      // Normal
      #line(start: (6.0mm, 0mm), end: (6.0mm, -4.5mm), stroke: (paint: bp-dim, dash: "dotted", thickness: 0.25pt))
      // Incident ray
      #line(start: (1.5mm, -4.2mm), end: (6.0mm, 0mm), stroke: 0.4pt + bp-secondary)
      // Reflected ray
      #line(start: (6.0mm, 0mm), end: (10.5mm, -4.2mm), stroke: 0.45pt + bp-primary)
      #place(top + left, dx: 3.2mm, dy: -3.8mm)[
        #text(size: 2.4pt, fill: bp-dim)[$theta_i$]
      ]
      #place(top + left, dx: 7.2mm, dy: -3.8mm)[
        #text(size: 2.4pt, fill: bp-primary)[$theta_r$]
      ]
    ]
    // Reflection Equations
    #place(top + left, dx: 103.5mm, dy: 26.5mm)[
      #text(size: 3.3pt, fill: bp-text)[$theta_i = theta_r$]
      #v(0.6pt)
      #text(size: 2.9pt, fill: bp-text)[$v'_x = -v_x$ (wall)]
      #v(0.6pt)
      #text(size: 2.9pt, fill: bp-text)[$v'_y = -v_y$ (brick)]
      #v(0.6pt)
      #text(size: 2.9pt, fill: bp-dim)[$theta = arctan(Delta y / Delta x)$]
    ]

    // Divider Rule 2
    #place(top + left, dx: 85.5mm, dy: 38.0mm,
      line(end: (42.9mm, 0mm), stroke: 0.3pt + bp-secondary))

    // PANEL 3: BALL TRAJECTORY & EQUATIONS (y: 38.0mm - 52.8mm)
    #place(top + left, dx: 87.5mm, dy: 39.0mm)[
      #text(size: 3.8pt, weight: "bold", fill: bp-highlight)[03 — KINEMATICS & TRAJECTORY]
    ]
    #place(top + left, dx: 88.0mm, dy: 42.4mm)[
      #text(size: 3.2pt, fill: bp-text)[$x(t) = x_0 + v_x t$]
      #v(0.8pt)
      #text(size: 3.2pt, fill: bp-text)[$y(t) = y_0 + v_y t - 1/2 g t^2$]
      #v(0.8pt)
      #text(size: 3.2pt, fill: bp-highlight)[$theta = arctan(v_y / v_x)$]
      #v(0.8pt)
      #text(size: 2.5pt, fill: bp-dim)[NOTE: CONTINUOUS APPROXIMATION]
    ]

    // Divider Rule 3
    #place(top + left, dx: 85.5mm, dy: 53.0mm,
      line(end: (42.9mm, 0mm), stroke: 0.3pt + bp-secondary))

    // PANEL 4: HARDWARE & SYSTEM SPECIFICATIONS (y: 53.0mm - 68.4mm)
    #place(top + left, dx: 87.5mm, dy: 54.0mm)[
      #text(size: 3.8pt, weight: "bold", fill: bp-highlight)[04 — ARCHITECTURE & SPECS]
    ]
    #place(top + left, dx: 88.0mm, dy: 57.5mm)[
      #text(size: 2.8pt, fill: bp-text)[RELEASE: MAY 13, 1976 (ATARI)]
      #linebreak()
      #text(size: 2.8pt, fill: bp-highlight)[HARDWARE: 44 DISCRETE TTL ICS]
      #linebreak()
      #text(size: 2.8pt, fill: bp-text)[NO MICROPROCESSOR · NO ROM]
      #linebreak()
      #text(size: 2.8pt, fill: bp-dim)[TARGET: JAVA 17 · OOP (MVC)]
      #linebreak()
      #text(size: 2.8pt, fill: bp-dim)[STATUS: PHASE 01 SPECIFICATION]
    ]
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
    «در سال ۱۹۷۶، نولان باشنل در شرکت آتاری از استیو جابز خواست بازی #en[Breakout] را با کمترین تعداد تراشهٔ سخت‌افزاری بسازد. جابز پروژه را به استیو وازنیاک سپرد؛ وازنیاک طی ۴ شبانه‌روز کار بی‌وقفه، مدار بازی را تنها با ۴۴ تراشه پیاده کرد. ابتکارات وازنیاک در بهینه‌سازی مدارهای گرافیکی این بازی، مستقیماً الهام‌بخش او در طراحی معماری نمایش تصویر و رنگ در رایانهٔ انقلابی #en[Apple II] شد.»
  ]

  #v(1.5mm)

  #prompt-example("پرامپت پیشنهادی برای بازتولید تصویر شماتیک مهندسی")[
    #set text(font: english-font, size: 6.8pt, style: "italic", fill: colors.muted, lang: "en", dir: ltr)
    #set par(leading: 3.2pt)
    Technical blueprint drawing of classic 1976 Breakout arcade game, showing green phosphor wireframe paddle, mathematical ball deflection angles, and brick array grid on deep navy blueprint paper, clean line art, precise dimension labels, engineering schematic style.
  ]
])
