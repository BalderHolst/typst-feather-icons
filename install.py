#!/usr/bin/env python3

from pathlib import Path
import os
import tomllib
import shutil

ROOT = Path(__file__).parent
DATA_DIR = Path("~/.local/share").expanduser()

with open(ROOT / "typst.toml", 'rb') as f:
    MANIFEST = tomllib.load(f)

NAME = MANIFEST['package']['name']
VERSION = MANIFEST['package']['version']

if 'XDG_CACHE_HOME' in os.environ:
    DATA_DIR = Path(os.environ['XDG_CACHE_HOME'])

PACKAGE_DIR = DATA_DIR / "typst/packages/local" / NAME

os.makedirs(PACKAGE_DIR, exist_ok=True)

DST = PACKAGE_DIR / VERSION

print(f"ROOT : {ROOT}")
print(f"DST  : {DST}")

shutil.copytree(ROOT, DST)
