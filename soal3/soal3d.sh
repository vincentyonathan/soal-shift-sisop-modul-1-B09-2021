#!/usr/bin/bash
target="$(date +%m)$(date +%d)$(date +%Y)"

for foldername in K*; do
    zip --password $target -ur Koleksi.zip "$foldername"
done
