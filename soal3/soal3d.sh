#!/usr/bin/bash
cd /home/prk/soal-shift-sisop-modul-1-B09-2021-main/soal3
target="$(date +%m)$(date +%d)$(date +%Y)"

for foldername in K*; do
    zip --password $target -ur Koleksi.zip "$foldername"
    rm -rf $foldername
done
