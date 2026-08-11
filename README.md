# Feather icons for Typst!
This is a simple Typst package for using [Feather Icons](https://feathericons.com/) in your Typst documents.

## Example

```typst
#import "@local/feather-icons:0.1.0": icons, inline-icons, make-icons

#set page(height: 100mm, width: 100mm)
#show: it => align(horizon, it)
#set text(size: 12pt)

Icon images are accessed with the exposed `icons` variable:
#stack(
  dir: ltr,
  spacing: 7pt,
  icons.package,
  icons.music,
  icons.navigation,
  icons.mail,
  icons.phone,
  icons.user,
  icons.github,
  icons.map-pin,
)

We have inline icons like this moon #inline-icons.moon which can be accessed with the `inline-icons` variable:

Icons can be customized using the `make-icons` and `make-inline-icons` functions.

#let slim-red-icons = make-icons(
  stroke: red,
  stroke-width: 1,
)

#stack(
  dir: ltr,
  spacing: 7pt,
  slim-red-icons.package,
  slim-red-icons.music,
  slim-red-icons.navigation,
  slim-red-icons.mail,
  slim-red-icons.phone,
  slim-red-icons.user,
  slim-red-icons.github,
  slim-red-icons.map-pin,
)
```

*Output:*

![Output svg](./demo.svg)

## Local Installation
You can use the included installer to install this package locally on Linux.

```bash
./install.py
```

After installation it will be available with:

```typst
#import "@local/feather-icons:{version}"
```
