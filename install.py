#!/usr/bin/env python3

from pathlib import Path
import os
import tomllib
import shutil
import argparse
import subprocess

import txtx

ROOT = Path(__file__).parent
DATA_DIR = Path("~/.local/share").expanduser()

FILES = [
    "README.md",
    "LICENSE",
    "lib.typ",
    "typst.toml",
    "data.typ",
]

with open(ROOT / "typst.toml", 'rb') as f:
    MANIFEST = tomllib.load(f)

NAME = MANIFEST['package']['name']
VERSION = MANIFEST['package']['version']
DEFAULT_NAMESPACE = MANIFEST['tool']['install']['namespace']

if 'XDG_CACHE_HOME' in os.environ:
    DATA_DIR = Path(os.environ['XDG_CACHE_HOME'])

LOCAL_PKGS_DIR = DATA_DIR / "typst/packages"

def package_dir(pkgs_dir: Path, namespace: str, name: str, version: str):
    return pkgs_dir / namespace / name / version

parser = argparse.ArgumentParser()
parser.add_argument('-f', '--force', action="store_true", help="Override existing package")
parser.add_argument('-s', '--symlink', action="store_true", help="Install package with symlink")
parser.add_argument('-n', '--namespace', type=str, default=DEFAULT_NAMESPACE, help="Namespace to install to")
parser.add_argument('-p', '--pkgs-dir', type=Path, default=LOCAL_PKGS_DIR, help="Package index directory")

args = parser.parse_args()

pkgs_dir = args.pkgs_dir
namespace = args.namespace

dst_dir = package_dir(pkgs_dir, namespace, NAME, VERSION)

print(f"ROOT : {ROOT}")
print(f"DST  : {dst_dir}")

def error(msg):
    print()
    print(msg)
    exit(1)

if args.force:
    if dst_dir.exists():
        if os.path.islink(dst_dir):
            os.remove(dst_dir)
        else:
            shutil.rmtree(dst_dir)

if dst_dir.exists():
    error(f"Destination '{dst_dir}' already exists. Delete it or use the `-f` flag to override.")

if args.symlink:
    subprocess.run(["ln", "-s", ROOT, dst_dir])
    exit(0)

for path in FILES:
    src = ROOT / path
    dst = dst_dir / path
    os.makedirs(dst.parent, exist_ok=True)

    if os.path.isfile(src):
        shutil.copy(src, dst)
    if os.path.isdir(src):
        shutil.copytree(src, dst)

if namespace != DEFAULT_NAMESPACE:
    print("[WARN]: Make sure to change the README to reflect the new namespace.")
