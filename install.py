#!/usr/bin/env python3

from pathlib import Path
import os
import tomllib
import shutil
import argparse
import subprocess

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

parser = argparse.ArgumentParser()
parser.add_argument('-f', '--force', action="store_true", help="Override existing package")
parser.add_argument('-s', '--symlink', action="store_true", help="Install package with symlink")

args = parser.parse_args()

print(f"ROOT : {ROOT}")
print(f"DST  : {DST}")

def error(msg):
    print()
    print(msg)
    exit(1)

if args.force:
    if DST.exists():
        shutil.rmtree(DST)

if DST.exists():
    error(f"Destination '{DST}' already exists. Delete it or use the `-f` flag to override.")

if args.symlink:
    subprocess.run(["ln", "-s", ROOT, DST])
else:
    shutil.copytree(ROOT, DST)
