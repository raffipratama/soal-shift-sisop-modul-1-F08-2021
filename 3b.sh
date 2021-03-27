#!/bin/bash

bash ./3a.sh

tanggal_unduh=$(date +"%d-%m-%Y")
mkdir "$tanggal_unduh"

mv ./Koleksi_* "./$tanggal_unduh/"
mv ./Foto.log "./$tanggal_unduh/"









