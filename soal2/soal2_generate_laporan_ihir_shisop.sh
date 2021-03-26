#!/bin/bash

export LC_ALL=C

#2a
awk '
    BEGIN{FS="\t"}
    {
        rowID=$1
        profit=$21
        sales=$18

        profit_percentage=(profit/(sales-profit))*100

        if(profit_percentage>=maks){
            maks=profit_percentage
            maksID=rowID
        }
    }
    END{
        printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %d%%.\n", maksID, maks)
    }
' Laporan-TokoShisop.tsv >> hasil.txt

#2b
awk '
    BEGIN{FS="\t"}
    {
        year=$2
        city=$10
        name=$7

        if(year~"2017" && city=="Albuquerque"){
            list[name]+=1
        }
    }
    END{
        printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n")
        for(data in list){
            printf("%s\n", data)
        }
    }
' Laporan-TokoShisop.tsv >> hasil.txt

#2c
awk '
    BEGIN{FS="\t"}
    {
        segment=$8

        if(segment=="Consumer"){
            #menghitung jumlah setiap segment
            hitung[segment]+=1
        }
        else if(segment=="Corporate"){
            hitung[segment]+=1
        }
        else if(segment=="Home Office"){
            hitung[segment]+=1
        }
    }
    END{
        transaksi=99999
        for(n in hitung){
            if(hitung[n]<transaksi){
                transaksi=hitung[n]
                nama_segment=n
            }
        }
        printf("\n\nTipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n\n", nama_segment, transaksi)
    }
' Laporan-TokoShisop.tsv >> hasil.txt

#2d
awk '
    BEGIN{FS="\t"}
    {
        wilayah=$13
        profit=$21

        if(wilayah=="Central"){
            #untuk menghitung total keuntungan dr setiap wilayah
            jumlah[wilayah]+=profit
        }
        else if(wilayah=="East"){
            jumlah[wilayah]+=profit
        }
        else if(wilayah=="South"){
            jumlah[wilayah]+=profit
        }
        else if(wilayah=="West"){
            jumlah[wilayah]+=profit
        }
    }
    END{
        minimal_profit=99999
        for(x in jumlah){
            if(jumlah[x]<minimal_profit){
                minimal_profit=jumlah[x]
                nama_wilayah=x
            }
        }
        printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.2f.\n", nama_wilayah, minimal_profit)
    }
' Laporan-TokoShisop.tsv >> hasil.txt