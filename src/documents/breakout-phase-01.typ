#import "../course/theme.typ": *
#import "breakout/cover.typ": *
#import "breakout/foundations.typ": *
#import "breakout/architecture.typ": *
#import "breakout/physics.typ": *
#import "breakout/lifecycle.typ": *
#import "breakout/evaluation.typ": *

#show: course-document.with(
  kind: "فاز پروژه",
  title: "هستهٔ بازی Breakout",
  subtitle: "اهداف، نیازمندی‌های فنی، طراحی شی‌گرا و معیارهای ارزیابی",
  number: "01",
  cover-artwork: breakout-cover-vignette(),
)

#set par(justify: true, leading: 4.5pt, spacing: 6pt)

#breakout-foundations-page()
#pagebreak()

#breakout-architecture-page()
#pagebreak()

#breakout-physics-page()
#pagebreak()

#breakout-lifecycle-page()
#pagebreak()

#breakout-evaluation-page()
