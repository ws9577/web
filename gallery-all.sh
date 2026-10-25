#!/bin/sh
# 用法：在上層資料夾執行 gallery-all [長邊px] [門檻] [品質]
find . -name gallery.js | while read -r g; do
  d=$(dirname "$g")
  echo "== $d"
  ( cd "$d" || exit
    exec </dev/null
    shrink "$@"
    mkthumbs
    ls | grep -iE '\.(jpg|jpeg|png|gif)$' | awk 'BEGIN{printf "["} {printf "%s\"%s\"", (NR>1?",":""), $0} END{print "]"}' > list.json
  )
done
echo "全部完成"
chmod +x /usr/local/bin/gallery-all
