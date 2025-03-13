#!/bin/bash

echo "=== Crontab Manager ==="
echo "1. Tambah Pemantauan CPU"
echo "2. Tambah Pemantauan RAM"
echo "3. Hapus Semua Jadwal"
echo "4. Lihat Jadwal Aktif"
echo "5. Keluar"

read -p "Pilihan: " choice

case $choice in
    1) (crontab -l; echo "* * * * * $(pwd)/scripts/core_monitor.sh") | crontab - ;;
    2) (crontab -l; echo "* * * * * $(pwd)/scripts/frag_monitor.sh") | crontab - ;;
    3) crontab -r ;;
    4) crontab -l ;;
    5) exit 0 ;;
    *) echo "Pilihan tidak valid." ;;
esac
