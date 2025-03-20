#!/bin/bash

argu=$1
argu="${argu#--play}"
clear

affirm() {
RESET="\e[0m"
HIGHLIGHT="\e[30;47m"  

affirmations=("" "" "")

while true; do
    rows=$(tput lines)
    cols=$(tput cols)

    new_affirmation=$(curl -s https://www.affirmations.dev/ | sed -E 's/.*"affirmation":"([^"]+)".*/\1/')

    affirmations=("${affirmations[1]}" "${affirmations[2]}" "$new_affirmation")

    clear

    start_row=$((rows / 2 - 1))

    for i in {0..2}; do
        text_length=${#affirmations[i]}
        col=$(((cols - text_length) / 2))
        tput cup $((start_row + i)) $col
        
        if [[ $i -eq 1 ]]; then
            printf "${HIGHLIGHT}%s${RESET}\n" "${affirmations[i]}"
        else
            printf "%s\n" "${affirmations[i]}"
        fi
    done

    sleep 1
done
}

progress_bar() {
    local progress=$1
    local i=$1
    local total=100
    local width=$(tput cols)  
    width=$((width - 10))     

    local num_stars=$((progress * width / total))
    local num_space=$((width - num_stars))

    printf "\e[30m\e[47m\r["
    printf "\e[38;5;${i}m\e[47m"
    printf "%0.s*" $(seq 1 $num_stars)  
    printf "\e[0m\e[47m"  
    printf "%0.s " $(seq 1 $num_space)  
    printf "\e[30m\e[47m] %d%%\e[0m" "$progress"
}

otr() {
    for i in $(seq 1 100); do
        progress_bar "$i"
        delay=$(shuf -i 1-10 -n 1)
        delay=$(echo "scale=2; $delay / 10" | bc)
        sleep $delay
    done
    echo ""
}

waktu() {
    while true; do
        clear
        hari=$(printf "%(%A)T\n" -1)
        case "$hari" in
            "Monday") hari="Senin" ;;
            "Tuesday") hari="Selasa" ;;
            "Wednesday") hari="Rabu" ;;
            "Thursday") hari="Kamis" ;;
            "Friday") hari="Jumat" ;;
            "Saturday") hari="Sabtu" ;;
            "Sunday") hari="Minggu" ;;
        esac
        echo "$hari,"
        printf "%(%d %b %Y %H:%M:%S)T\n" -1
        sleep 1
    done
}


uang() {
    local symbols=('$' '€' '£' '¥' '₫' '₹' '₩' '฿' '₣')
    local colors=("\033[31m" "\033[32m" "\033[33m" "\033[34m" "\033[35m" "\033[36m" "\033[91m" "\033[92m" "\033[93m")
    local rows=$(tput lines)
    local cols=$(tput cols)
    
    while true; do  
        local rand_row=$(( RANDOM % rows + 1 ))
        local rand_col=$(( RANDOM % cols + 1 ))
        local rand_num=$((RANDOM % 9))
        local symbol="${symbols[$rand_num]}"
        local color="${colors[$rand_num]}"
        printf "$color\n\n\n\033[%d;%dH%s\e[0m" "$rand_row" "$rand_col" "$symbol"
        sleep 0.005
    done
}

bdm() {
    while true; do
        clear
        width=$(tput cols)
        half_width=$((width / 2))
        title="Task Manager - $(date)"
        length=$(echo -n "$title" | wc -c)
        half_length=$((length / 2))
        half_width=$((half_width - half_length))

        total_cpu=$(ps -eo %cpu | awk '{sum+=$1} END {print sum}')
        total_mem_used=$(free -m | awk '/Mem:/ {print $3}')
        total_mem_total=$(free -m | awk '/Mem:/ {print $2}')
        total_process=$(ps -eo pid | awk 'NR>1 {sum+=1} END {print sum}')

        printf "%-${half_width}s" " "
        echo "$title"
        printf "%-${half_width}s" " "
        printf "%-${length}s\n" "-" | tr ' ' '-'

        printf "%-${half_width}s                USER : " " "
        whoami
        
        echo -e "Total Proses: $total_process \n"
        echo -e "Total CPU Usage: $total_cpu% \n"
        echo -e "Total Memory Used: $total_mem_used MiB / $total_mem_total MiB \n"
        printf "%-${width}s\n" "-" | tr ' ' '-'

        ps -eo pid,user,%cpu,%mem,vsz,rss,stat,start,time,command --sort=-%cpu |
        awk 'NR==1 {printf "|%-7s \t| %-8s | %-5s | %-5s | %-7s | %-5s | %-5s | %-8s | %-8s | %s\n", "PID", "USER" , "%CPU" , "%MEM" , "VSZ", "RSS" , "STAT" , "START" , "TIME" , "COMMAND"}
             NR>1 {printf "|%-7s \t| %-8s | %-5s | %-5s | %-7s | %-5s | %-5s | %-8s | %-8s | %s \n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}'
        
        printf "%-${width}s\n" "-" | tr ' ' '-'
        sleep 1
    done
}

case "$argu" in 
    "Speak to Me")
        affirm
        ;;
    "On the Run")
        otr
        ;;
    "Time")
        waktu
        ;;
    "Money")
        uang
        ;;
    "Brain Damage")
        bdm
        ;;
    *)
        echo "Argumen tidak dikenali."
        ;;
esac
