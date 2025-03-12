#!/bin/bash

awk 'BEGIN {FS=","} \
	$0 ~/Chris Hemsworth/ {++n } \
	END {print "Chris Hemsworth membaca", n, "buku"}'\
	 /home/nadiakusuma1001/sisop1_1/reading_data.csv
awk 'BEGIN {FS=","; sum=0; n=0}\
	 $8 ~ /Tablet/ {sum += $6; n++}\
	 END {printf "Rata-rata durasi baca dengan Tablet: %.2f menit \n", sum/n}'\
	 /home/nadiakusuma1001/sisop1_1/reading_data.csv
awk 'BEGIN {FS=","; m=0}\
	NR > 1 \
	{if($7 > m) {m = $7; b = $3; n = $2}}\
	END {print "Pembaca dengan rating tertinggi adalah", n, "berjudul", b, "dengan rating", m}'\
	/home/nadiakusuma1001/sisop1_1/reading_data.csv
awk 'BEGIN {FS=","; prev=0}\
	$9 ~ /Asia/ && $5 > "2023-12-31"\
	{count[$4]++; for(genre in count){\
		if(count[genre] > prev){\
			prev = count[genre]; g = genre}\
	}\
	} END {print "Genre paling populer di Asia setelah 2023 adalah", g, "dengan buku sebanyak", prev}'\
	/home/nadiakusuma1001/sisop1_1/reading_data.csv
