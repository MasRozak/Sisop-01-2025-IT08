#!/bin/bash

if [ ! -f reading_data.csv ]; then
    wget -O reading_data.csv "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download"
fi

echo "Pilih opsi yang ingin ditampilkan:"
echo "1. Jumlah buku yang dibaca oleh Chris Hemsworth"
echo "2. Rata-rata durasi membaca dengan Tablet"
echo "3. Pembaca dengan rating tertinggi"
echo "4. Genre paling populer di Asia setelah 2023"
read -p "Masukkan pilihan (1-4): " pilihan

if ! [[ "$pilihan" =~ ^[1-4]$ ]]; then
    echo "Pilihan tidak valid."
    exit 1
fi

if [ "$pilihan" -eq 1 ]; then
   awk 'BEGIN {FS=","}\
	$0 ~/Chris Hemsworth/ {++n }\
	END {if(n>0)\
		{print "Chris Hemsworth membaca", n, "buku"}\
	else\
		{print "Chris Hemsworth tidak membaca buku"}\
	}'\
	reading_data.csv

elif [ "$pilihan" -eq 2 ]; then
   awk 'BEGIN {FS=","; sum=0; n=0}\
	 $8 ~ /Tablet/ {sum += $6; n++}\
	 END {if (n>0){\
		printf "Rata-rata durasi baca dengan Tablet: %.2f menit \n", sum/n}\
	else {\
		print "Tidak ada yang membaca menggunakan Tablet"}\
	}'\
	reading_data.csv 

elif [ "$pilihan" -eq 3 ]; then
   awk 'BEGIN {FS=","; m=0}\
	NR > 1 \
	{if($7 > m) {m = $7; b = $3; n = $2}}\
	END {print "Pembaca dengan rating tertinggi adalah", n, "berjudul", b, "dengan rating", m}'\
	reading_data.csv

elif [ "$pilihan" -eq 4 ]; then
   awk 'BEGIN {FS=","; prev=0}\
	$9 ~ /Asia/ && $5 > "2023-12-31"\
	{count[$4]++; for(genre in count){\
		if(count[genre] > prev){\
			prev = count[genre]; g = genre}\
	}\
	} END {print "Genre paling populer di Asia setelah 2023 adalah", g, "dengan buku sebanyak", prev}'\
	reading_data.csv  
fi
