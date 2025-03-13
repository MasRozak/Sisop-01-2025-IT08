#!/bin/bash

LOG_FILE="$(dirname "$0")/../.logs/core.log"

timestamp=$(date "+%Y-%m-%d %H:%M:%S")
cpu_usage=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' \
<(grep 'cpu ' /proc/stat) <(sleep 1; grep 'cpu ' /proc/stat))
cpu_model=$(lscpu | grep "Model name" | cut -d':' -f2 | xargs)

echo "[$timestamp] - Core Usage [$cpu_usage] - Terminal Model [$cpu_model]" >> "$LOG_FILE"




