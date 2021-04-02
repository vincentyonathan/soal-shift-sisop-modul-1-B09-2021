# soal-shift-sisop-modul-1-B09-2021

* Vincent Yonathan    - 05111940000186
* Aprilia Annisa      - 05111940000199
* Pramudityo Prabowo  - 05111940000210

### Soal Modul 1
[Soal Shift Modul 1](https://docs.google.com/document/d/1T3Y4o2lt5JvLTHdgzA5vRBQ0QYempbC5z-jcDAjela0/edit)

### Daftar isi
* [Soal 1](#soal-1)
* [Soal 2](#soal-2)
* [Soal 3](#soal-3)


### Soal 1
*Praktikan* diminta untuk membuat laporan harian perusahaan untuk aplikasi internal perusahaan, *ticky*. Ada 2 macam laporan yang harus dibuat yaitu laporan **daftar peringkat pesan error** terbanyak yang dibuat oleh *ticky* dan laporan **penggunaan user** pada aplikasi *ticky*.  

#### 1. a)
*Praktikan* diminta untuk mengumpulkan informasi berupa: jenis log (`ERROR`/`INFO`), pesan log, dan username pada file `syslog.log` untuk setiap baris *log*nya.&nbsp;

#### Source Code :
```bash
#!/bin/bash

#1.a)
errorinfo=$(grep -o "[INFO|ERROR].*" syslog.log)
echo "$errorinfo"
```
- Pengerjaan menggunakan regex `[INFO|ERROR].*` yang mengambil baris dari `syslog.log` dengan kata-kata tersebut untuk dimunculkan di output.  

#### Contoh Output :
```
INFO closed ticket [#1754] (noel)
ERROR ticket doesn't exist (xlg)
```

#### 1. b)
*Praktikan* diminta menampilkan semua pesan error yang muncul beserta jumlah kemunculannya dari `syslog.log`&nbsp;
#### Source Code :
```bash
errorcount=$(grep -o "ERROR.*" syslog.log |sort -nr | cut -d "(" -f1 | uniq -c)
echo $errorcount
```
- Melakukan `grep -o` pada `syslog.log` untuk mem*filter* dan mencetak baris eksplisit yang sesuai dengan regex yang diminta/tidak mencetak seluruh baris.
- Menggunakan *regex* `ERROR.*` yang mengambil baris berisikan `(ERROR)` pada kata depannya.
- Melakukan sorting atau pengurutan menggunakan command `| sort` yang mengurutkan seluruh baris dengan konten kata yang sama, hasilnya akan seperti berikut
```
ERROR Tried to add information to closed ticket (sri)
ERROR Tried to add information to closed ticket (oren)
ERROR Tried to add information to closed ticket (oren)
ERROR Tried to add information to closed ticket (nonummy)
ERROR Tried to add information to closed ticket (noel)
... dst
```
- Menggunakan command `| cut -d` yang berarti cut dengan delimiter `"(" -f1` yang berarti mengambil semua sampai dengan sebelum `(nama-pengguna)`
- Terakhir, menggunakan command `| uniq -c` dimana `uniq` berarti mengelompokan dan `-c` yang berarti menghitung baris sehingga diketahui jumlah setiap error.&nbsp;
#### Output :
```
12 ERROR Tried to add information to closed ticket 
15 ERROR Timeout while retrieving information 
 7 ERROR Ticket doesn't exist 
 9 ERROR The ticket was modified while updating 
10 ERROR Permission denied while closing ticket 
13 ERROR Connection to DB failed 
```

#### 1. c)
*Praktikan* diminta untuk  menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap *user*-nya.&nbsp;

#### Source Code :
```bash
uinforegex=$(grep "INFO.*" syslog.log | cut -d "(" -f2 | cut -d ")" -f1| sort -nr | uniq -c)
uerroregex=$(grep "ERROR.*" syslog.log | cut -d "(" -f2 | cut -d ")" -f1 | sort -nr | uniq -c)
echo "$uinforegex"
echo "$uerroregex"
```
- Menggunakan command `grep` untuk mengambil baris dari file `syslog.log`
- Melakukan filter yaitu dengan menggunakan *regex* `INFO.*` dan `ERROR.*` yang bertujuan untuk mengambil baris dengan kata `(INFO)` dan `(ERROR)`
- Menggunakan command `| cut -d` yang berarti cut dengan delimiter `"(" -f2` yang berarti memotong sampai dengan sebelum `(nama-pengguna)` 
- Sekali lagi menggunakan command `| cut -d` namun dengan delimiter `")" -f1` yang berarti memotong semua kalimat sampai dengan akhir setelah `(nama-pengguna)` agar yang tercetak hanya nama pengguna
- Kemudian, melakukan `sort` untuk mengurutkan tiap baris dengan konten yang sama
- Terakhir, menggunakan command `| uniq -c` dimana `uniq` berarti mengelompokan dan `-c` yang berarti menghitung baris sehingga diketahui jumlah setiap error.&nbsp;

#### Output :
```bash
untuk info
      2 sri
      2 rr.robinson
      2 oren
      2 nonummy
 .. dst
 untuk error
      4 xlg
      2 sri
      1 rr.robinson
      7 oren
..dst
```

#### 1. d)
Menuliskan informasi pada poin **b** kedalam file error_message.csv. Header adalah Error,Count dengan daftar pesan error dan jumlah kemunculannya diurutkan dari yang terbanyak.&nbsp;

#### Source Code :
```bash
grep -o "ERROR.*" syslog.log | sed 's/\<ERROR\>//g' | cut -d "(" -f1 | sort | uniq -c |
while read count msg
do
        echo $msg,$count
done | sort -nr -t, -k2 | sed '1i\Error,Count' > error_message.csv
```
- Menggunakan cara yang sama dengan poin b yaitu melakukan `grep -o` pada `syslog.log` dan menggunakan *regex* `ERROR.*` untuk memfilter isinya.
- Kemudian pada soal ini ditambahkan command `| sed 's/\<ERROR\>//g'` untuk menghilangkan kata ERROR dan mengambil sisa dari baris tersebut. 
- Setelah itu, melakukan hal yang sama yaitu menggunakan command `| cut -d` yang berarti cut dengan delimiter `"(" -f1` dan command `uniq -c`
- Kemudian, pada poin ini, program akan melakukan iterasi dengan command `| while read count msg` yang menyimpan nilai jumlah kemunculan pesan info dan kalimatnya ke dalam variabel `'count'` dan `'msg'`
- Melakukan echo dengan posisi `$msg,$count` agar disesuaikan dengan permintaan soal
- Berikutnya, melakukan sorting sekali lagi menggunakan command `| sort -nr -t, -k2` yaitu melakukan sort secara *descending* dan memberitahu bahwa yang di sort adalah kolom kedua.
- Terakhir, untuk memberikan header menggunakan command `| sed '1i\Error,Count' > error_message.csv` dan mengeluarkan outputnya pada file error_message.csv dan menimpa apapun yang ada disana dengan command `> error_message.csv`.&nbsp;

#### Output :
![1d](./screenshots/soal1d.JPG)

#### 1. e)
Menuliskan informasi pada poin **c** kedalam file user_statistic.csv dengan header 'Username, INFO, ERROR' diurutkan berdasarkan username secara *ascending*.&nbsp;

#### Source Code :
```bash
echo "Username,INFO,ERROR" > user_statistic.csv

cut -d "(" -f2 syslog.log | cut -d ")" -f1 | sort -t , -k1 | uniq |
while read line;
do
        info=$(grep "INFO.*($line)" syslog.log | wc -l)
        error=$(grep "ERROR.*($line)" syslog.log | wc -l)
        echo -e "$line,$info,$error"
done >> user_statistic.csv
```
- Menggunakan `echo "Username, INFO, ERROR"` sebagai header dari file yang akan mencetak output, `echo` akan berjalan ke user_statistic.csv lewat `> user_statistic.csv`.
- Melakukan langkah yang sama dengan bagian **c** yaitu menggunakan command `| cut -d` yang berarti cut dengan delimiter `"(" -f2` dan sekali lagi menggunakan `| cut -d` namun dengan delimiter `")" -f1` untuk mengambil hanya nama dari penggunanya
- Kemudian juga melakukan sort, namun yang disort adalah kolom 1 dengan command `| sort -t, -k1` yang berarti diurutkan berdasarkan kolom 1 dan dengan pemisah `,`. Setelah itu dilakukan pengelompokan yang menggunakan command `uniq`
- Setelah itu melakukan iterasi dengan command `| while read line` yang menyimpan nama dari pengguna dalam variabel line
- Menggunakan command `grep` untuk memfilter file `syslog.log` dengan regex `INFO.*($line)` dan `ERROR.*($line)` yang berarti mengambil baris yang berisi `(INFO)` dan `(ERROR)` dengan nama dari user yang sedang dibaca melalui iterasi. 
- Setelah melakukan `grep`, juga digunakan command `wc -l` untuk menghitung banyaknya line sehingga mengetahui berapa banyak `(INFO)` dan `(ERROR)` dari seorang pengguna.
- Langkah berikutnya adalah menggunakan command `echo -e "$line,$info,$error` untuk mencetak hasil sesuai urutan yang diminta oleh soal, kemudian mencetaknya kedalam user_statistic.csv melalui command `>> user_statistic.csv`, disini digunakan `>>` agar tidak menimpa `echo` pertama pada header.

#### Output :
![1e](./screenshots/soal1e.JPG)

### Soal 2
#### 2.a)

#### 2.b)

#### 2.c)

#### 2.d)


### Soal 3
