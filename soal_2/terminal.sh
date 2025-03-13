#!/bin/bash

while true; do
    echo "=== Sistem Arcaea ==="
    echo "1. Register"
    echo "2. Login"
    echo "3. Crontab Manager"
    echo "4. Keluar"

    read -p "Pilih menu: " choice

    case $choice in
        1) bash register.sh ;;
        2) bash login.sh ;;
        3) bash scripts/manager.sh ;;
        4) exit 0 ;;
        *) echo "Pilihan tidak valid." ;;
    esac
done
