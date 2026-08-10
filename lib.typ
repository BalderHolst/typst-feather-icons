#let _TAGS = json("feather-icons/src/tags.json")
#let _ICON_DIR = "./feather-icons/icons/"
#let _MANIFEST = json("feather-icons/package.json")

#let version = _MANIFEST.version

#let from_name(name) = {
  image(_ICON_DIR + name + ".svg")
}

#let icons = _TAGS.keys().map(name => {
  (name, from_name(name))
}).to-dict()

#let inline-icons = icons.pairs().map(it => {
  let (name, image) = it
  (name, box(image, height: 1em, baseline: 0.2em))
}).to-dict()
