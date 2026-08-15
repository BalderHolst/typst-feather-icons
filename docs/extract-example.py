import subprocess
import os

def run(cmd):
    res = subprocess.run(cmd, shell=True, capture_output=True, check=True)
    if res.stderr != b"": print(res.stderr)
    return res.stdout.decode()

src = run("typst eval 'query(<example-code>).first().value' --in docs.typ | jq . -r")

lines = [
    "#set page(height: 80mm, width: 100mm, margin: 6mm)",
    "#show: it => align(horizon, it)",
    "#set text(size: 12pt)",
]

for l in src.split("\n"):
    l = l.replace("@local/feather-icons:0.1.0", "lib.typ")
    lines.append(l)


src = "\n".join(lines)
print(src)
