#!/bin/sh
# Print the --h1..--h7 line for cms_stubs.html for each page (all accordions closed, +40px).
# Usage: tools/measure_heights.sh mun safeguarding ...   (needs google-chrome and network for fonts)
set -e
cd "$(dirname "$0")"
pages=$(echo "$@" | tr ' ' ',')
google-chrome --headless=new --disable-gpu --no-sandbox --allow-file-access-from-files \
  --window-size=1400,900 --virtual-time-budget=30000 --dump-dom "file://$PWD/measure.html#$pages" 2>/dev/null \
  | grep -o 'data-r="[^"]*"' | sed 's/&quot;/"/g; s/^data-r="//; s/"$//' \
  | python3 -c '
import json, math, sys
bands = [[1260], [1004], [1180, 920, 796], [795, 641], [640, 489], [488, 376], [285]]
for page, h in json.load(sys.stdin).items():
    line = "".join("--h%d:%dpx;" % (i + 1, math.ceil((max(h[str(w)] for w in b) + 40) / 10) * 10) for i, b in enumerate(bands))
    print("%-15s %s" % (page, line))
'
