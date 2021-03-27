#!/bin/bash

now=$(date +"%d-%m-%Y" )
jml=23
count=$(date "+%d" )
let count=$count%2
if [ $count -eq 0 ]
then
	mkdir "Kelinci_$now"
	for (( a=1; a<=jml; a++ ))
	do
		wget -O "Koleksi_$a.jpg" https://loremflickr.com/320/240/bunny 2>> Foto.log
	done

	for (( a=1; a<=jml; b++ ))
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
elif [ $count -eq 1 ]
then
	mkdir "Kucing_$now"
	for (( a=1; a<=jml; a++ ))
	do
		wget -O "Koleksi_$a.jpg" https://loremflickr.com/320/240/kitten -a Foto.log
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
	mv ./Koleksi_* "./Kucing_$now/"
	mv ./Foto.log "./Kucing_$now/"
fi



