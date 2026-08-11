#let _TAGS = json("feather-icons/src/tags.json")
#let _ICON_DIR = "./feather-icons/icons/"
#let _MANIFEST = json("feather-icons/package.json")

#let version = _MANIFEST.version

#let _name_to_path(name) = {
  _ICON_DIR + name + ".svg"
}

#let _variant(f) = {
  _TAGS
    .keys()
    .map(name => {
      (name, f(_name_to_path(name)))
    })
    .to-dict()
}

/// Convert an icon set to an inline icon set
#let inline(icons) = {
  icons
    .pairs()
    .map(it => {
      let (name, image) = it
      (name, box(image, height: 1em, baseline: 0.2em))
    })
    .to-dict()
}

#let _set-svg-variable(s, ..opts) = {
  let match = s.match(regex("^<svg .+?>"))
  assert(match.start == 0)
  let svg-tag = match.text
  for (name, value) in opts.named() {
    if value == none { value = "none" }
    if type(value) == color { value = value.to-hex() }
    if type(value) != str { value = str(value) }
    svg-tag = svg-tag.replace(
      regex(name + "=\".+?\""),
      name + "=\"" + str(value) + "\"",
    )
  }
  svg-tag + s.slice(match.end)
}

/// Icon Images
#let icons = _variant(image)

/// Icons for use inside text
#let inline-icons = inline(icons)

/// SVG source for icons
#let svg-icons = _variant(read)

/// Create an icon set with additional options
#let make-icons(
  stroke: "currentColor",
  stroke-width: 2,
  fill: none,
) = {
  _variant(path => {
    let svg = read(path)
    let svg = _set-svg-variable(
      svg,
      stroke: stroke,
      stroke-width: stroke-width,
      fill: fill,
    )
    image(bytes(svg))
  })
}

/// Create an *inline* icon set with additional options
#let make-inline-icons(
  stroke: "currentColor",
  stroke-width: 2,
  fill: none,
) = {
  inline(
    make-icons(
      stroke: stroke,
      stroke-width: stroke-width,
      fill: fill,
    ),
  )
}
