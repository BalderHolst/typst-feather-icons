#let manifest = toml("./typst.toml")
#let original-package = json("./feather-icons/package.json")

#let package = manifest.package

#set document(
  title: [Feather Icons Package Documentation],
  author: package.authors,
  keywords: ("Documentation", "API", "Example", package.keywords).flatten(),
)

#metadata(package) <package-metadata>

#set page(paper: "a4", margin: 18mm)

#import "@preview/tidy:0.4.3"
#import "./docs/theme.typ"
#import "./docs/example-layout.typ": my-layout-example


#import package.entrypoint as feather-icons

#let package-items = dictionary(feather-icons)

#let docs = tidy.parse-module(
  read(package.entrypoint),
  name: package.name,
  scope: package-items,
)

#let GRAY = black.lighten(30%)

#show heading.where(level: 1): set text(size: 18pt)
#set text(size: 12pt)

#show link: it => {
  show text: underline.with(offset: 2pt)
  it
}

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
      [Feather Icons Version: #original-package.version],
      spacing: 15mm,
    )
  },
  height: 30mm,
  width: 100%,
  stroke: 1pt + white.darken(30%),
)
#v(1mm)

This package contains Typst bindings for the open source #link("https://feathericons.com/", [feather icons #feather-icons.inline-icons.globe]). They are vector icons under the MIT license and ready for use in your document!


#outline(depth: 3)

= Minimal Example
#[
  #show: tidy.render-examples.with(
    scope: package-items,
    layout: my-layout-example.with(input_file: "example.typ", output_file: "example.pdf"),
  )

  #let example-code = {
    "<<<#import \"@" + manifest.tool.install.namespace + "/feather-icons:" + package.version +"\": icons, inline-icons, make-icons

Icon images are accessed with the exposed `icons` variable:
#stack(dir: ltr, spacing: 7pt, icons.phone, icons.user, icons.github, icons.map-pin)

We have inline icons like this moon #inline-icons.moon which can be accessed with the `inline-icons` variable:

Icons can be customized using the `make-icons` and `make-inline-icons` functions.
#let slim-red-icons = make-icons(stroke: red, stroke-width: 1)

#stack(dir: ltr, spacing: 7pt, slim-red-icons.phone, slim-red-icons.user, slim-red-icons.github, slim-red-icons.map-pin)
"
  }

  #metadata(example-code.split("\n").map(it => {
    it.replace(regex("^<<<"), "")
  }).join("\n")) <example-code>

  #raw(
    example-code,
    lang: "example",
  )

]

= Relevant Links
#table(
  columns: 2,
  inset: 5pt,
  [Package Repository], [#link(package.repository)],
  [Feather Icons Repository], [#link(original-package.repository.url)],
  [Feather Icons Website], [#link("https://feathericons.com/")],
),

= Local Installation
This package includes an install script for Linux. Simply run it to install this package to the `local` namespace.
```bash
python ./install.py
```

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

= List of Icons

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
