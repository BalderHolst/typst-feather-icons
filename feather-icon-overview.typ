#import "lib.typ" as feather-icons

#show heading: set text(size: 25pt)
#set block(spacing: 1em)

= Feather Icons
#{
  show text: smallcaps
  set text(size: 16pt)
  grid(
    columns: 2,
    gutter: 10pt,
    [Typst Package Version:], toml("./typst.toml").package.version,
    [Feather Icons Version:], feather-icons.version,
  )
}

#line(length: 100%)

#grid(..feather-icons.icons
  .pairs()
  .filter(it => type(it.last()) == content)
  .map(it => {
    let (name, image) = it
    (image, align(left + horizon, name))
  })
  .flatten(),
  columns: 8, column-gutter: 1fr, row-gutter: 0.4em)
