#import "../../course/theme.typ": *

#let breakout-toc-page() = [
  #align(center)[
    #v(4mm)
    #text(size: type-scale.heading, weight: "bold", fill: colors.ink)[فهرست مطالب]
    #v(2mm)
    #line(length: 24mm, stroke: 1.5pt + colors.blue)
  ]
  #v(8mm)

  #outline(title: none, indent: 1.5em, depth: 1)
]
