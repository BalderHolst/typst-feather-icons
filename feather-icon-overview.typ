#import "lib.typ" as feather-icons

#show heading: set text(size: 25pt)

= Feather Icons
VERSION: #feather-icons.version

#grid(..feather-icons.icons
  .pairs()
  .filter(it => type(it.last()) == content)
  .map(it => {
    let (name, image) = it
    (image, align(left + horizon, name))
  })
  .flatten(),
  columns: 8, column-gutter: 1fr, row-gutter: 0.4em)
