#import "@local/feather-icons:0.1.0": icons

#grid(..icons
  .values()
  .filter(it => type(it) == content),
  columns: 20, gutter: 5pt)
