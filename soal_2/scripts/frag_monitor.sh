#!/bin/bash

LOG_FILE="../log/fragment.log"

timestamp=$(date "+%Y-%m-%d %H:%M:%S")
ram_usage=$(free | awk '/Mem/ {printf "%.2f", $3/$2 * 100}')
total_ram=$(free -m | awk '/Mem/ {print $2}')
available_ram=$(free -m | awk '/Mem/ {print $7}')

echo "[$timestamp] - Fragment Usage [$ram_usage%] - Fragment Count [$available_ram MB] - Details [Total: $total_ram MB, Available: $available_ram MB]" >> "$LOG_FILE"
