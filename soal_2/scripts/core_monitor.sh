#!/bin/bash

LOG_FILE="../log/core.log"

timestamp=$(date "+%Y-%m-%d %H:%M:%S")
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
cpu_model=$(lscpu | grep "Model name" | cut -d':' -f2 | xargs)

echo "[$timestamp] - Core Usage [$cpu_usage%] - Terminal Model [$cpu_model]" >> "$LOG_FILE"
