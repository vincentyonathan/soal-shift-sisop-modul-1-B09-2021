#!/bin/sh
echo "" > Foto.log
for ((i = 1; i < 24 ; i++)); do
    wget https://loremflickr.com/320/240/kitten -O "Koleksi_$i.jpg" >> Foto.log 2>&1
done

for ((i = 1 ; i < 24 ; i++)); do
    for ((j = i + 1 ; j < 24 ; j++)); do
        if diff Koleksi_$i.jpg Koleksi_$j.jpg &> /dev/null; then
            # diff evaluated true if file matches
            rm Koleksi_$j.jpg
        fi
    done
done

for i in {1..23}; do
    if [ ! -f Koleksi_$i.jpg ]; then
        for ((j = 23; i < j; j--)); do
            if [ -f Koleksi_$j.jpg ]; then
                mv Koleksi_$j.jpg Koleksi_$i.jpg
                break
            fi
        done
    fi
done

target="$(date +%m)-$(date +%d)-$(date +%Y)"
mkdir $target
mv *.jpg $target
mv Foto.log $target
