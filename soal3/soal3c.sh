#!/bin/sh
echo "" > Foto.log
kitten=0
for ((i = 1; i < 24 ; i++)); do
    if [[ $kitten == 1 ]]; then
        wget https://loremflickr.com/320/240/kitten -O $( printf "Koleksi_%02d" $i) -a Foto.log
    fi
    if [[ $kitten == 0 ]]; then
        wget https://loremflickr.com/320/240/bunny -O $( printf "Koleksi_%02d" $i) -a Foto.log
    fi
done

for ((i = 1 ; i < 24 ; i++)); do
    for ((j = i + 1 ; j < 24 ; j++)); do
        if diff $( printf "Koleksi_%02d" $i) $( printf "Koleksi_%02d" $j) &> /dev/null; then
            # diff evaluated true if file matches
            rm $( printf "Koleksi_%02d" $j)
        fi
    done
done

for i in {1..23}; do
    if [ ! -f $( printf "Koleksi_%02d" $i ) ]; then
        for ((j = 23; i < j; j--)); do
            if [ -f $( printf "Koleksi_%02d" $j ) ]; then
                mv $( printf "Koleksi_%02d" $j ) $( printf "Koleksi_%02d" $i )
                break
            fi
        done
    fi
done


if [[ $kitten == 1 ]]; then
    target="Kucing_$(date +%d)-$(date +%m)-$(date +%Y)"
fi
if [[ $kitten == 0 ]]; then
    target="Kelinci_$(date +%d)-$(date +%m)-$(date +%Y)"
fi

mkdir $target
mv Koleksi_* $target
mv Foto.log $target
