#!/bin/bash

for a in {1..23}
do
	wget -O "Koleksi_$a.jpg" https://loremflickr.com/320/240/kitten 2>> Foto.log 
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

