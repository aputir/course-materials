#import "../course/theme.typ": *
#import "breakout/cover.typ": *
#import "breakout/toc.typ": *
#import "breakout/rules.typ": *
#import "breakout/introduction.typ": *
#import "breakout/tech-stack.typ": *
#import "breakout/before-phase1.typ": *
#import "breakout/architecture.typ": *
#import "breakout/entities.typ": *
#import "breakout/rules-gameplay.typ": *
#import "breakout/graphics.typ": *
#import "breakout/physics.typ": *
#import "breakout/milestones.typ": *
#import "breakout/evaluation.typ": *

#show: course-document.with(
  kind: "فاز پروژه",
  title: "هسته بازی Breakout",
  subtitle: "اهداف، نیازمندی‌های فنی، طراحی شی‌گرا و معیارهای ارزیابی",
  number: "01",
  cover-artwork: breakout-cover-vignette(),
)

#breakout-toc-page()
#pagebreak()

#breakout-rules-page()
#pagebreak()

#breakout-introduction-page()
#pagebreak()

#breakout-tech-stack-page()
#pagebreak()

#breakout-before-phase1-page()
#pagebreak()

#breakout-architecture-page()
#pagebreak()

#breakout-entities-page()
#pagebreak()

#breakout-rules-gameplay-page()
#pagebreak()

#breakout-graphics-page()
#pagebreak()

#breakout-physics-page()
#pagebreak()

#breakout-milestones-page()
#pagebreak()

#breakout-evaluation-page()
