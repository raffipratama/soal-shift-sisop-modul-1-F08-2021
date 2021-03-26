# soal-shift-sisop-modul-1-F08-2021 

## Penjelasan NO 1

## Penjelasan NO 2 : TokoShiShop
Steven dan Manis mendirikan sebuah startup bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.

### a. Menentukan __Row ID__ dan __profit percentage terbesar__
```
#!/bin/bash

LC_ALL=C awk '
BEGIN {FS="\t"}

# A --------------------------

{
if(max_PP<=$21/($18-$21)*100)
{
max_PP=$21/($18-$21)*100
max_rid=$1
}
}
```
Penjelasan :
- Sebelumnya diinputkan `#!/bin/bash` agar file dapat dibaca dalam terminal bash.
- `LC_ALL=C` digunakan agar format data (koma) terbaca dengan benar
- Lalu awk diaktifkan.
- `BEGIN {FS="\t"}` dijalankan pada awal pelaksanaan file yang berfungsi sebagai penanda untuk memisahkan tab/("\t").
- `if(max_PP<=$21/($18-$21)*100)`artinya apabila persentase keuntungan (sales - profit) data yang sedang diproses saat ini lebih besar dari persentase keuntungan data-data sebelumnya maka, `max_PP=$21/($18-$21)*100` persentase keuntungan terbesar diperbarui dan `max_rid=$1` row id disimpan.

### b. Mencari nama customer di tahun 2017, kota Albuquerque ###
```
{
if( $2~"2017" && $10=="Albuquerque" )
{
namacust[$7]++
}
}
```
Penjelasan :
- Berarti dicari data dengan kolom kedua (kolom Order ID) menunjukkan bahwa order dibuat pada tahun 2017, dan kota di dalam data yaitu Albuquerque.
- Data yang ditemukan tersebut disimpan pada array `namacust[$7]++`.

### c. Mencari segment customer dan jumlah transaksi yang paling sedikit ###
```
{
if($8=="Consumer")
consumercounter++
else if($8=="Home Office")
homeofficecounter++
else if($8=="Corporate")
corporatecounter++
}
```

Penjelasan :
- Dilakukan pengecekan pada kolom 8 (segmen) apakah mengandung _Consumer, Home Office,_ atau _Corporate_ lalu dihitung dengan menggunakan data masing-masing segmen counter.

### d. Mencari wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut. ###

```
{
if($13=="Central")
profitcentral+=$21
else if($13=="East")
profiteast+=$21
else if($13=="West")
profitwest+=$21
else if($13=="South")
profitsouth+=$21
}
```
Penjelasan :
- Hampir sama seperti dengan nomer 2c, dilakukan pengecekan pada kolom 13 (region) apakah mengandung _central, east, west,_ atau _south_ lalu total keuntungan (profit) masing-masing region ditambahkan dengan kolom 21 (profit).

### e. Diharapkan menghasilkan output dengan file "hasil.txt"
```END {

# Print A --------------------------
printf "Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.02f%% . \n", max_rid, max_PP

# Print B --------------------------
printf "\nDaftar nama customer di Albuquerque pada tahun 2017 antara lain:\n"
for(ulang in namacust)
{
printf "%s \n", ulang
}

# Print C --------------------------
printf "\nTipe segmen customer yang penjualannya paling sedikit adalah "
if (consumercounter<homeofficecounter && consumercounter<corporatecounter)
printf "%s dengan %d transaksi.", "Consumer", consumercounter
else if(homeofficecounter<consumercounter && homeofficecounter<corporatecounter)
printf "%s dengan %d transaksi.", "Home Office", homeofficecounter
else if(corporatecounter<homeofficecounter && corporatecounter<consumercounter)
printf "%s dengan %d transaksi.", "Corporate", corporatecounter

# Print D --------------------------
printf "\n\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah "

if (profitcentral<profiteast && profitcentral<profitwest && profitcentral<profitsouth)
printf "%s dengan total keuntungan %d \n", "Central", profitcentral
else if (profiteast<profitcentral && profiteast<profitwest && profiteast<profitsouth)
printf "%s dengan total keuntungan %d \n", "East", profiteast
else if (profitwest<profitcentral && profitwest<profiteast && profitwest<profitsouth)
printf "%s dengan total keuntungan %d \n", "West", profitwest
else if (profitsouth<profitcentral && profitsouth<profitwest && profitsouth<profiteast)
printf "%s dengan total keuntungan %d \n", "South", profitsouth

}
' /home/raffi/Downloads/Laporan-TokoShiSop.tsv > hasil.txt
```
Penjelasan :
- `END` berarti coding di dalamnya dilaksanakan saat terakhir pengulangan.
- Print A : Dihasilkan output dengan menampilkan __row id__ dan __profit percentage terbesar__.
- Print B : Dihasilkan output dengan menampilkan __nama customer__ sebanyak jumlah array.
- Print C : Dihasilkan output __segment customer__ dengan cara mencari __jumlah transaksi segment customer paling sedikit__ (menggunakan if).
- Print D : Dihasilkan output dengan cara mencari __jumlah profit__ paling sedikit (membandingkan menggunakan if) dan __total wilayah keuntungan__ tersebut.
- Mengambil file `Laporan-TokoShiSop.tsv` lalu output nya di simpan di `hasil.txt`

## Penjelasan NO 3


