#!/bin/sh
echo "" > Foto.log
kitten=1
for ((i = 1; i < 24 ; i++)); do
    if [[ $kitten == 1 ]]; then
        wget https://loremflickr.com/320/240/kitten -O "Koleksi_$i.jpg" >> Foto.log 2>&1
    fi
    if [[ $kitten == 0 ]]; then
        wget https://loremflickr.com/320/240/bunny -O "Koleksi_$i.jpg" >> Foto.log 2>&1
    fi
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

if [[ $kitten == 1 ]]; then
    target="Kucing_$(date +%m)-$(date +%d)-$(date +%Y)"
fi
if [[ $kitten == 0 ]]; then
    target="Kelinci_$(date +%m)-$(date +%d)-$(date +%Y)"
fi

mkdir $target
mv *.jpg $target
mv Foto.log $target
