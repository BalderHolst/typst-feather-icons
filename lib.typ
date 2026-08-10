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

// Create tag categories in `icons`
#for tags in _TAGS.values() {
  for tag in tags {
    icons.insert(tag, ().to-dict())
  }
}

// Populate tag categories
#for (name, tags) in _TAGS.pairs() {
  for tag in tags {
    icons.at(tag).insert(name, from_name(name))
  }
}
