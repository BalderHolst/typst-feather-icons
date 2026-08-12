#import "@preview/tidy:0.4.3"
#import "./docs/theme.typ"

#let package = toml("./typst.toml").package

#import package.entrypoint as feather-icons

#let docs = tidy.parse-module(
  read(package.entrypoint),
  name: package.name,
  scope: dictionary(feather-icons),
)


#tidy.show-module(
  docs,
  style: theme,
  break-param-descriptions: true,
  omit-private-definitions: true,
)
