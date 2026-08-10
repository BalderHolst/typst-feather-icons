# Feather icons for Typst!
This is a simple Typst package for using [Feather Icons](https://feathericons.com/) in your Typst documents.

## Example

```typst
#import "@local/feather-icons:0.1.0": icons, inline-icons

// Just some simple setup
#set page(height: 50mm, width: 100mm)
#show: it => align(horizon, it)
#set text(size: 12pt)

Icon images are accessed with the exposed `icons` variable:
#stack(dir: ltr, spacing: 7pt, icons.package, icons.music, icons.navigation, icons.mail, icons.phone, icons.user, icons.github, icons.map-pin)

We have inline icons like this moon #inline-icons.moon which can be accessed with the `inline-icons` variable.
```

***Output:***

![Output svg](./demo.svg)
