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

# B --------------------------
{
if( $2~"2017" && $10=="Albuquerque" )
{
namacust[$7]++
}
}

# C --------------------------
{
if($8=="Consumer")
consumercounter++
else if($8=="Home Office")
homeofficecounter++
else if($8=="Corporate")
corporatecounter++
}

# D --------------------------
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

END {

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
