#import "@local/feather-icons:0.1.0": *

#let icons = make-icons(stroke-width: 2.0, stroke: white.darken(80%))

#for (k, v) in icons [
  #k \ #v
  #line(length: 100%)
]
