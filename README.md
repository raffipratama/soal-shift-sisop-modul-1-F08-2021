# soal-shift-sisop-modul-1-F08-2021 

## Anggota Kelompok :
Anggota | NRP
--------|-------------
M. Rayhan Raffi P. | 05111940000110
M. Akmal Joedhiawan | 05111940000125
Nur Moh. Ihsanuddien | 05111940000142

## Penjelasan NO 1
Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, ticky. Terdapat 2 laporan yang harus dia buat, yaitu laporan daftar peringkat pesan error terbanyak yang dibuat oleh ticky dan laporan penggunaan user pada aplikasi ticky. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

**a** Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya. 
```
#1a
syslog='syslog.log'


ERROR=$(grep 'ERROR' $syslog  | sed 's/^.*://')  
INFO=$(grep 'INFO' $syslog | sed 's/^.*://')

#echo "$ERROR"
#echo "$INFO
```
1) mencari kata yang diawali oleh ERROR dan INFO di tiap line-nya
2) menghapus kata yang berada sebelum simbol ' : '

**b**	Menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.
```
ERRORdetail=$(grep 'ERROR' $syslog  | sed 's/^.*R//' | sed 's/(.*//' | sort | uniq -c| sort -nr)
```
1) melakukan grep kepada kata ERROR di tiap line
2) menghilangkan kata dari awal sampai karakter R terakhir tiap line
3) menghilangkan karakter mulai simbol '(' sampai akhir kalimat tiap line
4) melakukan sorting
5) menghapus duplikat dan menghitungnya
6) melakukan sort berdasarkan banyak duplikat secara ascending

**c** Menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.
```
errorUser=$(grep  'ERROR'  $syslog | sed 's/^.*(//' | cut -d ")" -f1 | sort | uniq -c)
```
1) melakukan grep kepada kata ERROR di tiap line
2) menghilangkan kata dari awal sampai simbol '(' terakhir tiap line
3) menghilangkan karakter mulai simbol ')' sampai akhir kalimat tiap line
4) melakukan sort
5) menghilangkan duplikat dan menghitungnya

#echo "ERROR"
#echo "$errorUser"

```
infoUser=$(grep 'INFO' $syslog | sed 's/^.*(//' | cut -d ")" -f1 | sort | uniq -c)
```
1) melakukan grep kepada kata INFO di tiap line
2) menghilangkan kata dari awal sampai simbol '(' terakhir tiap line
3) menghilangkan karakter mulai simbol ')' sampai akhir kalimat tiap line
4) melakukan sort
5) menghilangkan duplikat dan menghitungnya
#echo "INFO"
#echo "$infoUser

(d) Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.
```
echo "Error,Count" > error_message.csv
echo "$ERRORdetail" | while read list
do 
 error=$(echo $list | cut -d' ' -f2-)
 errorcount=$(echo $list | cut -d' ' -f 1)
 echo "$error,$errorcount" >> error_message.csv
done

#cat error_message.csv
```
1)memberi header
2)menginput tiap data di $ERRORdetail di tampung di $list untuk dilakukan looping
3)data dari $list setelah " " di cut  untuk dimasukkan pada $error
4)data dari $list sebelum " " di cut untuk dimasukkan pada $errorcount
5)menampilkan $error dan $errorcount kemudian dimassukkan file error_message.csv

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
Soal no. c memiliki cara pengerjaan yang hampir sama dengan soal a, namun bedanya terletak pada 2 link yang harus didownload setiap harinya berbeda
```
#!/bin/bash

now=$(date +"%d-%m-%Y" )
jml=23
kuc=$(ls | grep -e "Kucing.*" | wc -l)
kel=$(ls | grep -e "Kelinci.*" | wc -l)
if [[ $kuc -eq $kel ]] ;
then
	mkdir "Kucing_$now"
	for (( a=1; a<=jml; a++ ))
	do
		wget -O "Koleksi_$a.jpg" https://loremflickr.com/320/240/kitten 2>> Foto.log
	done

	for (( a=1; a<=jml; a++ ))
	do
		for (( b=a+1; b<=jml; b++ ))
		do
			cmp -s Koleksi_$a.jpg Koleksi_$b.jpg
			compare=$?
			if [ $compare -eq 0 ]
			then
				rm Koleksi_$b.jpg
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
	mv ./Koleksi_* "./Kucing_$now/"
	mv ./Foto.log "./Kucing_$now/"
else
	mkdir "Kelinci_$now"
	for (( a=1; a<=jml; a++ ))
	do
		wget -O "Koleksi_$a.jpg" https://loremflickr.com/320/240/bunny -a Foto.log
	done
	
	for (( a = 1; a<=jml; a++ ))
	do
		for (( b=a+1; b<=jml; b++ ))
		do
			cmp -s Koleksi_$a.jpg Koleksi_$b.jpg
			compare=$?
			if [ $compare -eq 0 ]
			then
				rm Koleksi_$b.jpg 
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
	mv ./Koleksi_* "./Kelinci_$now/"
	mv ./Foto.log "./Kelinci_$now/"
fi
```
Penjelasan :
- `kuc=$(ls | grep -e "Kucing.*" | wc -l), kel=$(ls | grep -e "Kelinci.*" | wc -l)` digunakan untuk menginisialisasi kapan waktu kitten didownloan dan bunny didownload
- `if [[ $kuc -eq $kel ]] ;` mengecek link mana yang harus didownload
- Untuk proses download file serupa dengan no. 3a bedanya hanya pada pembuatan direktori kucing `mkdir "Kucing_$now"` dan direktori kelinci `mkdir "Kelinci_%now"`
- Kemudian memindahkan foto ke dalam direktori kelinci `mv ./Koleksi_* "./Kelinci_$now/"` atau ke dalam direktori kucing `mv ./Koleksi_* "./Kelinci_$now/"`  sesuai jenis foto

### d. Zip file 
```
#!/bin/bash

Now="%d%m%Y"
Password=$(date +"$Now")
zip -P $"Password" -r -m Koleksi.zip ./Kelinci* ./Kucing*
```
Penjelasan :
- `Now="%d%m%Y"` mengecek tanggal saat ini
- `Password=$(date +"$Now")` membuat password berdasar tanggal saat ini
- `zip -P $"Password" -r -m Koleksi.zip ./Kelinci* ./Kucing*` maksud line berikut adalah buat suatu zip file dengan password tanggal saat ini mengecek apakah direktori kelinci dan kucing readable dan memindahkannya kedalam Koleksi.zip

### e. Jadwal Zip dan Unzip
```
0 7 * * 1-5 bash ~/home/akmal/Desktop/Akmal/Praktikum1/3/3d.sh

0 18 * * 1-5 unzip -P `date +"%d%m%Y"` Koleksi.zip && rm Koleksi.zip
```
Penjelasan :
- `0 7 * * 1-5 bash ~/home/akmal/Desktop/Akmal/Praktikum1/3/3d.sh` maksud dari line ini adalah dari mulai pukul 07.00 selama hari Senin - Jumat lakukan script 3d yang mana isinya adalah perintah untuk melakukan zip file
- `0 18 * * 1-5 unzip -P `date +"%d%m%Y"` Koleksi.zip && rm Koleksi.zip` maksud dari line ini adalah dari pukul 18.00 selama hari Senin - Jumat melakukan unzip file dengan password tanggal saat ini dan menghapus file Koleksi.zip

