#import "../../course/theme.typ": *

// Solid navy schematic of the Breakout game geometry and collision model.
// Layout follows the reference diagram: a 800 × 600 play field on the left,
// spec panels on the right, and one solid background shared with the quote below.
// Coordinates are reference pixels on a 1024 × 614 canvas that spans the full page width;
// play-field coordinates are game units (800 × 600) mapped into the field frame.
// Values follow the specification: 85 × 25 bricks with a 6 px gap, paddle at y = 545.

#let art-w = 210mm
#let scale-px = art-w / 1024
#let art-h = 614 * scale-px
// Text sizes were designed for a 130 mm canvas and scale with the wider one.
#let text-k = art-w / 130mm
#let art-bg = rgb("#0D1727")
#let art-panel = rgb("#12223A")
#let art-border = rgb("#2F5183")
#let art-line = rgb("#4A9CBF")
#let art-grid = rgb("#16263E")
#let art-text = rgb("#E6F3FF")
#let art-muted = rgb("#7F95B5")
#let art-cyan = rgb("#5EC8F2")
#let art-gold = rgb("#FFD45E")
#let art-teal = rgb("#4FB3AD")
#let art-paddle = rgb("#6FD4A4")
#let art-dash = rgb("#8A9BB3")
#let art-brick-rows = (
  rgb("#E0604F"), rgb("#EE8F43"), rgb("#EFCF55"), rgb("#62B873"), rgb("#4FB3AD"),
)

// Reference pixel → mm point, and game unit → reference pixel.
#let P(x, y) = (x * scale-px, y * scale-px)
#let GX(g) = 42 + g * 0.7625
#let GY(g) = 82 + g * 0.7717
#let G(x, y) = P(GX(x), GY(y))

// Places content with its top-left corner at a reference pixel.
#let at-px(x, y, body) = place(top + left, dx: x * scale-px, dy: y * scale-px, body)
// Places content with its right edge at a reference pixel.
#let at-right(x, y, body) = place(top + right, dx: x * scale-px - art-w, dy: y * scale-px, body)

// Straight segment between two points in absolute lengths.
// The line is placed at its own bounding box so every coordinate stays non-negative.
#let seg(p, q, stroke) = {
  let x0 = calc.min(p.at(0), q.at(0))
  let y0 = calc.min(p.at(1), q.at(1))
  place(top + left, dx: x0, dy: y0, line(
    start: (p.at(0) - x0, p.at(1) - y0),
    end: (q.at(0) - x0, q.at(1) - y0),
    stroke: stroke,
  ))
}

// Two-arm arrowhead whose tip is at b and which points away from a.
#let arrow-head(a, b, stroke) = {
  let dx = (b.at(0) - a.at(0)) / 1mm
  let dy = (b.at(1) - a.at(1)) / 1mm
  let n = calc.sqrt(dx * dx + dy * dy)
  let (ux, uy) = (-dx / n, -dy / n)
  let (c, s) = (calc.cos(28deg), calc.sin(28deg))
  let arm = 1.9
  let (v1x, v1y) = (ux * c - uy * s, ux * s + uy * c)
  let (v2x, v2y) = (ux * c + uy * s, -ux * s + uy * c)
  seg(b, (b.at(0) + arm * v1x * 1mm, b.at(1) + arm * v1y * 1mm), stroke)
  seg(b, (b.at(0) + arm * v2x * 1mm, b.at(1) + arm * v2y * 1mm), stroke)
}

// Rectangle positioned by its top-left reference pixel and its size in pixels.
#let rect-px(x, y, w, h, ..args) = at-px(x, y, rect(
  width: w * scale-px, height: h * scale-px, ..args,
))

// Rectangle positioned and sized in play-field game units.
#let rect-game(x, y, w, h, ..args) = {
  let (ax, ay) = G(x, y)
  place(top + left, dx: ax, dy: ay, rect(
    width: w * 0.7625 * scale-px, height: h * 0.7717 * scale-px, ..args,
  ))
}

#let hud(body, fill: art-text, weight: "regular", size: 4.4pt) = text(
  font: code-font, size: size * text-k, fill: fill, weight: weight, body,
)

// Titled panel with key/value rows (two-element rows) or single lines (one-element rows).
#let panel(x, y, w, h, title, rows) = {
  at-px(x, y, rect(width: w * scale-px, height: h * scale-px, fill: art-panel,
    stroke: 0.4pt + art-border, radius: 2pt))
  at-px(x + 9, y + 7, hud(size: 4.8pt, weight: "bold", fill: art-cyan)[#title])
  for (i, row) in rows.enumerate() {
    let ry = y + 22 + i * 14
    if row.len() == 2 {
      at-px(x + 9, ry, hud(fill: art-muted)[#row.at(0)])
      at-px(x + 64, ry, hud(fill: art-text)[#row.at(1)])
    } else {
      at-px(x + 9, ry, hud(fill: art-text)[#row.at(0)])
    }
  }
}

#let breakout-cover-vignette() = {
  // The page is right-to-left, so align(left) pins the artwork to the left edge before
  // the bleed shift; the artwork then spans the full 210 mm page width.
  align(left, move(dx: -document-style.margin-x, block(
    width: art-w,
    height: art-h,
    fill: art-bg,
    clip: true,
  )[
    #set text(lang: "en", dir: ltr, font: english-font)

    // Title block
    #at-px(38, 26, hud(size: 6.2pt, weight: "bold")[BREAKOUT — GAME GEOMETRY & COLLISION MODEL])
    #at-px(38, 50, hud(size: 4.4pt, fill: art-cyan)[Canvas 800 × 600 px · 4:3 · 60 Hz · origin top-left, y axis points down])

    // Play field: frame, faint grid and axis dimensions
    #for gx in range(100, 800, step: 100) {
      seg(G(gx, 0), G(gx, 600), 0.25pt + art-grid)
    }
    #for gy in range(100, 600, step: 100) {
      seg(G(0, gy), G(800, gy), 0.25pt + art-grid)
    }
    #rect-px(42, 82, 610, 463, stroke: 0.6pt + art-line)
    #at-px(318, 61, box(fill: art-bg, inset: (x: 2pt), hud(fill: art-cyan)[800 px]))
    #seg(P(42, 70), P(652, 70), 0.6pt + art-line)
    #arrow-head(P(60, 70), P(42, 70), 0.6pt + art-line)
    #arrow-head(P(634, 70), P(652, 70), 0.6pt + art-line)
    #seg(P(26, 82), P(26, 545), 0.6pt + art-line)
    #arrow-head(P(26, 100), P(26, 82), 0.6pt + art-line)
    #arrow-head(P(26, 527), P(26, 545), 0.6pt + art-line)
    #place(top + left, dx: 12 * scale-px, dy: 330 * scale-px,
      rotate(-90deg, reflow: true)[#hud(fill: art-cyan)[600 px]])
    #at-px(46, 86, hud(fill: art-muted, size: 4pt)[(0, 0)])
    #at-px(46, 531, hud(fill: art-muted, size: 4pt)[(0, 600)])
    #at-right(650, 531, hud(fill: art-muted, size: 4pt)[(800, 600)])
    #at-px(42, 552, hud(fill: art-muted)[X_MIN = 0])
    #at-right(652, 552, hud(fill: art-muted)[X_MAX = 800])

    // Bricks: 5 rows × 8 columns, 85 × 25 px, pitch 91 × 31; the last brick is destroyed
    #at-px(196, 113, hud(fill: art-cyan)[BRICKS 5 × 8 = 40 · 85 × 25 px · +100 pts])
    #for r in range(5) {
      for c in range(8) {
        if not (r == 4 and c == 7) {
          rect-game(39 + c * 91, 60 + r * 31, 85, 25,
            fill: art-brick-rows.at(r), radius: 1pt)
        }
      }
    }
    #rect-game(676, 184, 85, 25, fill: none, stroke: (paint: art-text, dash: "dashed", thickness: 0.5pt))
    #at-px(580, 229, hud(fill: art-cyan, weight: "bold")[+100])
    #at-px(596, 268, hud(fill: art-teal, size: 4pt)[destroyed])

    // Paddle: 100 × 15 px at y = 545, centred at x = 400
    #rect-game(350, 545, 100, 15, fill: art-paddle, radius: 1pt, stroke: 0.4pt + rgb("#B6F2D6"))
    #at-px(296, 519, hud(fill: art-muted)[cx = 400])
    #at-px(388, 519, hud(fill: art-gold)[Δx = +35])
    #at-px(296, 534, hud(fill: art-cyan)[PADDLE 100 × 15 px])

    // Incoming and normal reference lines at the paddle hit point (x = 435)
    #let hx = GX(435)
    #let hy = GY(545)
    #seg(P(272, 372), P(hx, hy), (paint: art-dash, thickness: 0.6pt, dash: "dashed"))
    #arrow-head(P(272, 372), P(hx, hy), 0.6pt + art-dash)
    #at-px(268, 362, hud(fill: art-dash)[incoming])
    #seg(P(hx, hy), P(hx, 360), (paint: art-dash, thickness: 0.6pt, dash: "dashed"))
    #at-px(336, 350, hud(fill: art-dash)[normal])
    #place(top + left, dx: hx * scale-px, dy: hy * scale-px,
      circle(radius: 1.2 * scale-px, fill: art-cyan))

    // Reflection angle arc from the normal (θ = 42°) and its label
    #for i in range(12) {
      let a0 = 42deg * i / 12
      let a1 = 42deg * (i + 1) / 12
      seg(
        P(hx + 60 * calc.sin(a0), hy - 60 * calc.cos(a0)),
        P(hx + 60 * calc.sin(a1), hy - 60 * calc.cos(a1)),
        0.8pt + art-gold,
      )
    }
    #at-px(392, 398, hud(fill: art-gold, weight: "bold")[θ = +42°])

    // Outbound path after the paddle hit (ends at the destroyed brick)
    #let tip-x = 435 + 0.6691 * 452.2
    #seg(P(hx, hy), G(tip-x, 209), (paint: art-cyan, thickness: 0.9pt, dash: "dotted"))
    #arrow-head(P(hx, hy), G(tip-x, 209), 0.9pt + art-cyan)

    // Ball on the outbound path, its velocity vector and labels
    #let ball-x = 612.4
    #let ball-y = 348.0
    #let vel-tip-x = ball-x + 46 * 0.6691
    #let vel-tip-y = ball-y - 46 * 0.7431
    #arrow-head(G(ball-x + 9 * 0.6691, ball-y - 9 * 0.7431), G(vel-tip-x, vel-tip-y), 1.4pt + art-gold)
    #place(top + left, dx: GX(ball-x) * scale-px - 6.1 * scale-px, dy: GY(ball-y) * scale-px - 6.1 * scale-px,
      circle(radius: 6.1 * scale-px, fill: art-gold, stroke: 0.4pt + rgb("#FFF1B8")))
    #at-px(532, 352, hud(fill: art-gold, weight: "bold")[BALL r = 8 px])
    #at-px(532, 364, hud(fill: art-text)[|v| = hypot(vx, vy)])
    #at-px(580, 300, hud(fill: art-gold)[v = (vx, vy)])

    // Side panels following the specification
    #panel(690, 82, 310, 64, "CANVAS", (
      ("size", "800 × 600 px (4:3)"),
      ("tick", "60 Hz"),
      ("origin", "top-left, y grows down"),
    ))
    #panel(690, 152, 310, 64, "BRICKS", (
      ("grid", "5 rows × 8 cols = 40"),
      ("size", "85 × 25 px, gap 6"),
      ("reward", "+100 pts each"),
    ))
    #panel(690, 222, 310, 56, "PADDLE", (
      ("size", "100 × 15 px"),
      ("pos", "y = 545, x in [0, 700]"),
    ))
    #panel(690, 284, 310, 56, "BALL", (
      ("radius", "r = 8 px"),
      ("speed", "|v| = hypot(vx, vy)"),
    ))
    #panel(690, 346, 310, 108, "PADDLE REFLECTION", (
      ("offset = Δx / (w / 2)",),
      ("clamped to [-1, 1]",),
      ("θ = offset · 60°",),
      ("vx = |v| · sin θ",),
      ("vy = - |v| · cos θ",),
      ("e.g. Δx = +35 → θ = +42°",),
    ))
    #panel(690, 460, 310, 84, "CONTROLS", (
      ("← →   move paddle",),
      ("SPACE   serve",),
      ("P       pause",),
      ("R       reset",),
    ))

    // Footer legend
    #at-px(42, 598, hud(fill: art-muted, size: 3.8pt)[Dotted cyan = ball path after paddle hit · dashed grey = incoming path · yellow = velocity / angle])
  ]))

  v(2.5mm)

  // Framed quote block containing 1976 Wozniak/Jobs Atari 44-chip historical fun fact
  block(
    width: 100%,
    fill: art-bg,
    stroke: 0.6pt + art-border,
    radius: workshop-style.frame-radius,
    inset: (x: 10pt, y: 5.5pt),
    above: 0pt,
    below: 0pt,
    breakable: false,
  )[
    #set text(font: prose-fonts, size: type-scale.small, fill: art-text, lang: "fa", dir: rtl)
    #set par(justify: true, leading: 4.0pt, spacing: 0pt)
    «در سال ۱۹۷۶، نولان باشنل در شرکت آتاری از استیو جابز خواست بازی #en[Breakout] را با کمترین تعداد تراشه سخت‌افزاری بسازد. جابز پروژه را به استیو وازنیاک سپرد؛ وازنیاک طی ۴ شبانه‌روز کار بی‌وقفه، مدار بازی را تنها با ۴۴ تراشه پیاده کرد. ابتکارات وازنیاک در بهینه‌سازی مدارهای گرافیکی این بازی، این تجربه را با طراحی نمایش تصویر و رنگ در رایانهٔ انقلابی #en[Apple II] مرتبط می‌دانند.»
  ]
}
