#!/usr/bin/env bash

export EXAMPLE_SVG_URL="https://balderholst.github.io/typst-feather-icons/example.svg"
export DOCS_URL="https://balderholst.github.io/typst-feather-icons/"
export NAMESPACE="local"

python3 ./txtx.py ./README.mdx > ./README.md
