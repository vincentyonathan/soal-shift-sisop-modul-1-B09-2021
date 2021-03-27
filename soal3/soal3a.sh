#!/bin/sh
echo "" > file.log
for i in {1..23}; do
    wget https://loremflickr.com/320/240/kitten -O $( printf "Koleksi_%02d.jpg" $i) >> file.log 2>&1
done

for ((i = 1 ; i < 24 ; i++)); do
    for ((j = i + 1 ; j < 24 ; j++)); do
        if diff $( printf "Koleksi_%02d.jpg" $i) $( printf "Koleksi_%02d.jpg" $j) &> /dev/null; then
            # diff evaluated true if file matches
            rm $( printf "Koleksi_%02d.jpg" $j)
        fi
    done
done

for i in {1..23}; do
    if [ ! -f $( printf "Koleksi_%02d.jpg" $i ) ]; then
        for ((j = 23; i < j; j--)); do
            if [ -f $( printf "Koleksi_%02d.jpg" $j ) ]; then
                mv $( printf "Koleksi_%02d.jpg" $j ) $( printf "Koleksi_%02d.jpg" $i )
                break
            fi
        done
    fi
done
