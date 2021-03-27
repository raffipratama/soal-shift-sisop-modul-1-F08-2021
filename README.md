# soal-shift-sisop-modul-1-F08-2021 

## Anggota Kelompok :
Anggota | NRP
--------|-------------
M. Rayhan Raffi P. | 05111940000110
M. Akmal Joedhiawan | 05111940000125
Nur Moh. Ihsanuddien | 05111940000142

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

## Penjelasan NO 3 : Gambar Kucing
Kuuhaku adalah orang yang sangat suka mengoleksi foto-foto digital, namun Kuuhaku juga merupakan seorang yang pemalas sehingga ia tidak ingin repot-repot mencari foto, selain itu ia juga seorang pemalu, sehingga ia tidak ingin ada orang yang melihat koleksinya tersebut, sayangnya ia memiliki teman bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian.

### a. Mendownload gambar kucing
```
#!/bin/bash

for a in {1..23}
do
	wget -O "Koleksi_$a.jpg" https://loremflickr.com/320/240/kitten 2>> Foto.log | sort -k 23 -n -r
done

jml=23
for (( a=1; a<=jml; a++ ))
do
	for (( b=a+1; b<=jml; b++ ))
	do
		cmp -s Koleksi_$a.jpg Koleksi_$b.jpg
		compare=$?
		if [ $compare -eq 0 ]
		then
			rm "Koleksi_$b.jpg"
			let jml=$jml-1
			let b=$b-1
		fi
	done
done

num=1
for file in *.jpg;
do 
	if [ $num -le 9 ]
	then
		mv "$file" "Koleksi_0${num}.jpg"
		let num=$num+1
	else 
		mv "$file" "Koleksi_${num}.jpg"
		let num=$num+1
	fi
done
```
Penjelasan :
- dilakukan looping sejumlah 23 kali `for a in {1..23}` untuk mendownload file dari `https://loremflickr.com/320/240/kitten` 
- menyimpan lognya ke `2>> Foto.log` dan memberi nama file  `-O "Koleksi_$a.jpg"
- Dilakukan nested loop untuk membandingkan 23 file yang didownload 
- melakukan compare 2 file `cmp -s Koleksi_$a.jpg Koleksi_$b.jpg`  dan jika file sama maka akan diremove `rm "Koleksi_$b.jpg"`
- Setelah dilakukan compare dilakukan loop kembali `for file in *.jpg;` untuk mengurutkan dan memberi nama file baru `mv "$file" "Koleksi_0${num}.jpg"`

### b. menjalankan autoscript dan simpan file
```
#!/bin/bash

bash ./3a.sh

tanggal_unduh=$(date +"%d-%m-%Y")
mkdir "$tanggal_unduh"

mv ./Koleksi_* "./$tanggal_unduh/"
mv ./Foto.log "./$tanggal_unduh/"
``` 
Penjelasan :
- Menjalankan script soal3a.sh `bash ./3a.sh` 
- melakukan set tanggal saat ini `tanggal_unduh=$(date +"%d-%m-%Y")` dan membuat direktori baru `mkdir "$tanggal_unduh"
- Memindahkan file gambar `mv ./Koleksi_* "./$tanggal_unduh/"` dan file log `mv ./Foto.log "./$tanggal_unduh/"` ke dalam folder direktori baru
- dilanjutkan menset waktu unduhan
```
0 20 1-31/7,2-31/4 * * bash ~/home/akmal/Desktop/Akmal/Praktikum1/3/3b.sh
```
Penjelasan :
- `0 20 1-31/7,2-31/4 * *` maksud dari potongan tersebut adalah setiap jam 8 malam mulai dari tanggal 1 tujuh hari sekali dan setiap 4 hari sekali dimulai tanggal 2
- `bash ~/home/akmal/Desktop/Akmal/Praktikum1/3/3b.sh` menjalankan script soal3b.sh sesuai dengan syarat diatas

### c. Mendowload 2 link berbeda 

 

