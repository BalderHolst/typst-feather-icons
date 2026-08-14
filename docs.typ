#set document(title: [Feather Icons Package Documentation])

#set page(paper: "a4", margin: 15mm)

#import "@preview/tidy:0.4.3"
#import "./docs/theme.typ"
#import "./docs/example-layout.typ": my-layout-example

#let package = toml("./typst.toml").package

#import package.entrypoint as feather-icons

#let package-items = dictionary(feather-icons)

#let docs = tidy.parse-module(
  read(package.entrypoint),
  name: package.name,
  scope: package-items,
)

#let GRAY = black.lighten(30%)

#rect(
  {
    set align(center + horizon)
    box[
      #show heading: set text(size: 35pt)
      = Feather Icons
    ]
    h(1mm)
    [
      #set text(fill: GRAY, size: 18pt)
      #show text: it => box(skew(it, ax: -5deg))
      Typst Package Documentation
    ]

    set text(size: 13pt)
    show text: smallcaps
    set align(center)
    stack(
      dir: ltr,
      [Typst Package Version: #package.version],
      [Feather Icons Version: #json("./feather-icons/package.json").version],
      spacing: 15mm,
    )
  },
  height: 30mm,
  width: 100%,
  stroke: 1pt + white.darken(30%),
)

#v(1mm)

#show heading.where(level: 1): set text(size: 18pt)

#outline(depth: 3)

// #show heading.where(level: 1): it => {
//   pagebreak()
//   it
// }

= Minimal Example
#[
  #show: tidy.render-examples.with(
    scope: package-items,
    layout: my-layout-example.with(input_file: "example.typ", output_file: "example.pdf"),
  )
  ```example
  <<<#import "@local/feather-icons:0.1.0": icons, inline-icons, make-icons

  <<<#set page(height: 100mm, width: 100mm)
  #show: it => align(horizon, it)
  #set text(size: 12pt)

  Icon images are accessed with the exposed `icons` variable:
  #stack(dir: ltr, spacing: 7pt, icons.phone, icons.user, icons.github, icons.map-pin)

  We have inline icons like this moon #inline-icons.moon which can be accessed with the `inline-icons` variable:

  Icons can be customized using the `make-icons` and `make-inline-icons` functions.
  #let slim-red-icons = make-icons(stroke: red, stroke-width: 1)

  #stack(dir: ltr, spacing: 7pt, slim-red-icons.phone, slim-red-icons.user, slim-red-icons.github, slim-red-icons.map-pin)
  ```
]

= Typst API (with examples)

#show heading.where(level: 3): set text(font: "DejaVu Sans Mono")

#let priority = dictionary(feather-icons).keys()

#let ord = it => {
  let idx = priority.position(x => x == it)
  assert(idx != none, message: repr(it))
  return idx
}

#tidy.show-module(
  docs,
  style: theme,
  break-param-descriptions: true,
  omit-private-definitions: true,
  show-module-name: false,
  show-outline: false,
  sort-functions: it => ord(it.name),
)

= List Icons

#columns(4)[
  #set block(spacing: 2pt)
  #for (name, image) in feather-icons.icons {
    stack(
      dir: ltr,
      spacing: 8pt,
      image,
      align(left + horizon, name),
    )
  }
]
