import subprocess
import os
import re
import json
import sys

def extract_code(namespace=None):

    cmd = ["typst", "eval", "query(<example-code>).first().value", "--in", "docs.typ"]
    if namespace != None:
        cmd.extend(["--input", f"namespace={namespace}"])

    json_src = subprocess.run(cmd, capture_output=True, check=True)

    src = json.loads(json_src.stdout)

    lines = [
        "#set page(height: 80mm, width: 100mm, margin: 6mm)",
        "#show: it => align(horizon, it)",
        "#set text(size: 12pt)",
    ]

    for l in src.split("\n"):
        l = re.sub(r'^#import "@.+:', '#import "lib.typ":', l)
        lines.append(l)


    return "\n".join(lines)

if __name__ == "__main__":
    src = extract_code()
    print(src)
