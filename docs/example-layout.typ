#import "@preview/tidy:0.4.3"

#let code_bg = blue.lighten(92%)
#let example-stroke = 1pt + black.lighten(70%)
#let example-inset = .8em

#let example-block(it, fill: none, file: none, inset: example-inset) = {
  block(
    radius: .5em,
    fill: fill,
    width: 100%,
    stroke: example-stroke,
    clip: true,
    breakable: false,
  )[
    #show heading: set block(inset: .5em, spacing: 0pt)
    #show heading: set text(size: 12pt)
    #set text(size: 10pt)
    #show raw: set text(size: 10pt)
    #if file != none [
      ===== #file
      #line(
        start: (-example-inset, 0%),
        length: 100% + 2 * example-inset,
        stroke: example-stroke,
      )
    ]
    #block(it, inset: inset, spacing: 0pt)
  ]
}

#let my-layout-example(input_file: none, output_file: none, scale-preview: 100%, ..args) = {
  tidy.show-example.default-layout-example(
    dir: ttb,
    code-block: (it, ..args) => block(
      example-block(fill: code_bg, file: input_file, it),
      ..args,
    ),
    preview-block: (it, ..args) => block(
      example-block(it, file: output_file, inset: 0pt),
      ..args,
    ),
    scale-preview: scale-preview,
    ..args,
  )
}
