#import "@local/feather-icons:0.1.0"

= Feather Icons
VERSION: #feather-icons.version

#grid(..feather-icons.icons
  .values()
  .filter(it => type(it) == content),
  columns: 20, gutter: 5pt)
