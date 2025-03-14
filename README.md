# Sisop-01-2025-IT08

Anggota IT08:
| Nama | NRP |
| ---------------------- | ---------- |
| Arya Bisma Putra Refman | 5027241036 |
| Moch. Rizki Nasrullah | 5027241038 |
| Nadia Fauziazahra Kusumastuti | 5027241094 |
----

## Soal 4
[Author: Amoes / winter]

Pada suatu hari, anda diminta teman anda untuk membantunya mempersiapkan diri untuk turnamen Pokemon “*Generation 9 OverUsed 6v6 Singles*” dengan cara membuatkan tim yang cocok untuknya. Tetapi, anda tidak memahami meta yang dimainkan di turnamen tersebut. Untungnya, seorang informan memberikan anda data pokemon_usage.csv yang bisa anda download dan analisis. 

- Data tersebut memiliki banyak kolom:
    - Nama Pokemon
    - Usage% yang merupakan persentase Pokemon yang disesuaikan dengan Rank pengguna dan Winrate
    - Raw Usage yang merupakan jumlah mentah Pokemon dalam semua tim yang tercatat
    - Type1 dan Type2 Pokemon
    - Statistic Pokemon: HP, Atk, Def, SpAtk, SpDef, dan Speed

Untuk menganalisis data tersebut dengan baik, anda berpikiran untuk membuat script yang bernama pokemon_analysis.sh

```bash
wget "https://drive.usercontent.google.com/u/0/uc?id=1n-2n_ZOTMIeqa8qZ2nB8ALAbGFyN4-LJ&export=download" -O pokemon_usage.csv
```
- `wget`: Perintah dalam Linux untuk mengunduh file dari internet
- `"https://drive.usercontent.google.com/u/0/uc?id=1n-2n_ZOTMIeqa8qZ2nB8ALAbGFyN4-LJ&export=download"`: Link file yang akan diunduh dari Google Drive
- `-O pokemon_usage.csv`: Menentukan nama file hasil unduhan sebagai `pokemon_usage.csv`
- Perintah ini akan mengunduh file dari Google Drive dan menyimpannya dengan nama `pokemon_usage.csv`
<br>

```bash
nano pokemon_analysis.sh
```
- `nano`: Editor teks berbasis terminal di Linux
- `pokemon_analysis.sh`: Nama file skrip shell yang akan dibuat dan diedit menggunakan `nano`
- Perintah ini membuka editor `nano` untuk membuat atau mengedit skrip bernama `pokemon_analysis.sh`

dengan fitur sebagai berikut:

```bash
#!/bin/bash

LINE=$(printf '=%.0s' $(seq 1 $(tput cols)))

print_centered() {
    local termwidth=$(tput cols)
    local padding=$(((termwidth - ${#1}) / 2))
    printf "%*s%s%*s\n" $padding "" "$1" $padding ""
}

show_help_ascii() {
    cat << "EOF"
⠀⠀⠀⠀⠀⠀⣤⣶⢦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀           ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠙⢾⡱⣟⢿⣳⣶⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠪⡷⣭⣟⣿⣿⣿⣷⣶⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⢟⣾⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⢀⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ______ _____ _   __ ________  ________ _   _⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⠽⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣤⣀⠀⠀⢸⡿⣷⣄⡤⠶⡤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ | ___ \  _  | | / /|  ___|  \/  |  _  | \ | |⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠻⢿⣿⣿⣿⣿⣿⣶⣾⣿⣯⣷⣾⣷⣷⣧⣝⣓⠶⢤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀| |_/ / | | | |/ / | |__ | .  . | | | |  \| |⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⣻⣿⣿⣿⣿⣿⣿⣽⣫⢿⣿⡿⣿⣿⣿⣷⣮⣼⣗⣲⣒⠲⠤⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀|  __/| | | |    \ |  __|| |\/| | | | | . ` |⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠶⣏⣷⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⡿⣜⠢⡍⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀| |   \ \_/ / |\  \| |___| |  | \ \_/ / |\  |⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡴⣁⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣩⣿⣿⡥⢣⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\_|    \___/\_| \_/\____/\_|  |_/\___/\_| \_/⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⣳⠛⢼⡻⣏⡯⣽⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢙⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠮⣵⠋⣴⢯⣳⣳⢟⡲⣝⠶⣹⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⡿⠿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢏⣽⠃⣷⣛⢮⣵⣛⢮⣳⣽⣞⡵⣣⠟⣿⣿⢿⡻⣿⢿⣿⣏⠉⠁⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣏⢾⠃⣼⡳⣭⡟⡮⣧⣿⣿⣿⣿⣿⡵⢫⡝⣿⣯⠷⣭⢏⡟⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡞⡼⡏⢰⣯⢟⢧⣻⣿⣿⣿⣿⣿⠿⢿⣿⡳⡜⡹⣿⣿⣷⡟⣾⡱⢿⣆⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⢯⡽⣠⡿⢙⡾⢯⣿⣿⣿⣿⡿⠁⠀⠀⠙⣷⡹⠴⡹⣿⣟⣿⢶⣫⢟⣿⣾⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀ ⠀ ⠀⠀⠀⠀⠀⠀⠀⢸⣺⢟⢵⡵⢹⣙⢯⣿⣿⣿⣿⠃⠀⠀⠀⠀⠈⢷⣩⢳⢹⣿⣻⣧⣛⢾⣿⡷⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣑⣲⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⣠⢞⣱⡟⢹⡝⣢⢫⢶⡹⢿⣿⣿⡀⠀⠀⠀⠀⠀⠈⢧⢎⡳⣜⢿⣽⡾⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢷⣹⣥⡀⠙⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠾⠥⢺⡟⣷⠸⡫⡜⣫⢮⡝⣯⢿⣿⢧⠀⠀⠀⠀⠀⠀⠀⠉⠓⣿⣮⠿⢽⣮⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣦⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡿⣼⠐⢴⣹⢣⡗⢾⣩⢞⡹⢯⣧⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⡉⢉⣛⣻⣿⡛⠢⢄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡞⢇⠸⣧⡛⣼⢣⠟⣮⡝⣧⢛⡷⣄⠀⠀⠀⠀⠀⠀⠀⠘⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣼⣿⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢏⣸⡆⠻⣝⢷⣋⣟⡲⣝⡎⡷⡹⢜⡳⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣿⣿⣿⡿⠁⠀⠉⠛⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⣻⣧⠀⠀⠀⠀⠀⠈⢧⣹⣶⠙⣾⠵⣌⠵⢮⣝⢲⡙⡎⣕⣣⢿⠳⡍⢯⣙⢲⠲⡤⢤⣀⣤⢤⡤⣄⡀⠀⠀⠀⠀⠀⠀⠀⣿⢿⣱⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣞⣿⣿⣿⣧⣀⣀⣠⣴⣶⣾⣧⣻⢧⡈⠻⣭⡳⣆⡉⢒⡙⣴⡿⡙⢎⡱⢎⡱⣘⠦⢣⡙⠢⠍⢭⠳⣝⣖⣻⣆⡀⠀⠀⠀⠀⢠⡟⣧⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣮⢟⣦⡌⠳⢷⡸⡠⢼⡟⡖⡹⣘⠴⢣⡱⢮⠼⡑⡎⠽⣘⠦⣡⣿⣿⢣⠝⣫⢷⣦⣄⣠⢯⡝⣮⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣼⣻⣿⣿⣿⣿⣿⣿⣿⣿⣏⣿⣏⠉⢿⢯⣽⣿⣼⡹⢷⣄⡙⠣⣿⡹⢔⢣⣱⣮⣷⣾⣮⣶⣩⣼⣷⣾⣿⣿⠿⡿⣿⣾⣥⡚⢬⡙⠿⣎⡷⣃⣾⣥⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣠⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⣾⣦⠈⣝⢿⣿⣿⣿⣧⡯⡽⢶⣿⣷⣯⣼⡿⡹⢀⢆⢣⣛⣿⣿⡛⡽⡘⢦⡙⣔⠣⡭⣛⢿⣷⣯⣜⠢⢝⣻⣿⣿⣿⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣷⣿⡷⡿⠛⠙⣿⣽⣿⣧⣿⡽⣻⣿⢖⣑⠢⡘⢦⣓⢾⣿⡵⢣⡝⣢⢕⠪⡕⢲⡡⢞⢈⣻⣿⡿⠿⠟⡛⠿⣿⣿⣿⣿⣿⡦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣞⣧⣴⡿⠀⠀⠀⠉⢳⣷⣿⣿⠹⣏⣷⢳⢎⣿⣿⣝⢧⣛⠶⣩⠳⣜⣡⠞⣴⣿⠟⡉⠆⠱⡈⢌⠣⢝⠻⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠛⢡⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠸⣿⡿⢎⡽⣚⣾⣿⣿⣿⣿⣿⣿⣾⣽⣣⢟⢦⣣⣾⣿⢣⠓⣌⡘⡐⠐⡂⢡⠊⢣⣓⢻⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣿⣿⣿⣿⣷⢳⣤⣀⠀⠀⠀⠀⢠⡟⡱⣏⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⡟⣆⠣⡝⢢⠗⣌⠱⠠⢡⠘⢠⠘⢧⡚⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠉⠛⢿⣗⢮⡜⣹⢒⠦⣼⡑⣜⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⡌⠳⣭⡜⣡⣫⡜⣢⠑⣂⠡⢂⡉⠔⢫⡖⣳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠛⠛⠋⠉⠁⠀⠀⠀⠈⠳⢝⡦⣏⡚⡴⢻⣖⡟⠉⠛⠿⣿⣿⣿⡿⢿⡿⢿⡿⣿⢿⣿⣿⣿⣿⣦⡠⢙⣤⢦⣙⡑⢯⡄⢊⠤⠐⡉⠤⢹⡒⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢼⣝⡾⣿⠏⠀⠀⠀⠀⠀⠉⠻⢽⡷⣾⣥⣻⣼⣿⠟⠋⠉⠺⣿⢢⣿⣋⠶⣥⢛⣦⢙⣦⠌⡁⢆⠑⡂⢟⡴⣻⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠫⠷⠋⠁⠀⠀⠀⠀⠘⢿⣳⢎⡟⣴⢫⡔⢧⡘⣦⠑⢢⠈⡔⢊⢶⡹⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢸⣎⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⢮⡝⢶⡓⣮⢓⡗⣼⠑⢢⠑⢨⠘⣦⢛⡟⣿⣿⣿⣿⣿⣿⢷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠘⣿⡎⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣟⢞⣣⠟⣼⣩⢾⣸⢍⠢⡘⠤⡙⢴⢫⣽⣯⣛⢿⡿⢿⢯⣿⣯⣟⣷⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤
⠀⠀⠀⢻⣿⢸⣿⣿⣿⣿⣿⣿⣻⢷⣻⢼⡹⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣠⡤⣤⣤⡴⣒⡢⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⢯⣜⠻⡰⢧⢇⡾⢎⡔⢡⠒⣍⢎⡗⣾⠈⠛⠷⣾⣿⣷⣶⣬⣛⢾⣽⡾⣽⣦⢤⡀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣴⣶⡾⣟⢷⣿⠃
⠀⠀⠀⠈⢿⣎⣿⡿⣟⣯⣷⢿⣽⣻⣽⢎⡷⣹⢳⣄⡀⠀⠀⠀⠀⠀⠀⠀⣰⣿⠿⡿⢟⣛⣛⠻⣩⢙⠭⣻⡬⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡿⣦⡉⢳⣛⣥⢾⣹⠲⣌⠧⡹⣌⠞⡼⡗⠀⠀⠀⠀⠉⠙⠻⠿⣛⡷⡝⢿⣳⢯⣟⡿⣿⣶⣤⣴⣾⣿⣽⣿⣻⡽⣶⣻⡼⣿⠃⠀
⠀⠀⠀⠀⠈⢧⣻⡿⣽⣻⣞⣯⣟⣷⣻⣮⡱⢏⡷⣭⣛⣦⣀⠀⠀⠀⠀⢠⣿⣏⢯⣓⠯⣖⣣⠷⣱⢎⡵⢢⢻⣽⣧⡀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣞⡳⣝⡶⢋⣰⡽⢎⡳⣥⠻⣔⢫⡕⢮⣹⢳⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠚⠹⢿⣮⣽⣳⣿⢯⠿⡽⢯⣟⣾⢷⣿⣳⣯⡿⠃⠀⠀
⠀⠀⠀⠀⠀⠈⢦⡙⢷⠟⢊⠓⠻⢾⣳⢯⣷⣡⠛⡲⣝⡶⣹⣛⡶⣤⣤⡾⡿⣜⣧⣫⣝⣮⡵⢯⢷⣮⢷⢯⢷⠻⣓⣷⣤⣀⣀⣤⣤⠶⣚⣫⣭⣭⢭⣉⠰⣔⢯⡜⣏⡳⣭⢳⢎⡳⣜⠳⣜⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠺⣿⣽⣧⢿⡼⣯⢾⡷⣯⣿⠷⠖⠀
⠀⠀⠀⠀⠀⠀⠀⠻⡆⣿⢻⢿⡷⣦⣌⠛⢶⣏⡷⣅⠲⣘⠱⣋⣶⡟⣧⢻⡽⣹⢎⢷⡹⢶⡙⢯⠞⡬⢋⠞⣩⣳⣿⢻⡼⣹⠞⣪⡵⣞⢯⡳⢞⣉⠲⣌⡧⣹⢮⡝⣎⢷⣙⢮⢣⠗⣮⢛⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣻⣷⣭⡳⣝⡞⣽⣆⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠈⠾⣯⢞⡵⣫⢟⡿⣦⡙⢾⣭⣛⠶⣣⣼⡟⣼⢣⣏⠶⣍⡞⣬⢓⣣⠚⡤⢋⠴⣉⠎⣼⣿⢧⢻⣴⢣⣞⢷⡹⢎⡳⣜⡖⣮⢛⡼⣡⡟⣧⢻⡜⣧⣛⢮⢏⡾⣱⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠾⣿⣾⣼⣡⠿⣧⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣜⢧⡻⣜⣳⢻⣆⠱⣯⢽⣡⣿⡝⡶⣫⡜⣏⣞⡹⣜⡏⣶⢫⢗⣫⢖⡳⣌⢿⣯⠯⠾⠇⢾⡭⢞⡭⣏⠷⣎⣽⠶⢋⣶⠯⣝⣎⢧⡻⣴⣫⢞⣳⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠯⢷⣿⣧
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⣽⡜⣧⢻⠂⣬⡙⣒⣿⣽⡵⣧⢿⣜⣞⣷⣻⣞⡿⢯⠿⣛⣿⣿⣿⢯⣷⣬⡴⢶⣌⣛⡛⣒⣛⣛⣩⣤⢾⡻⣥⢻⡜⣮⢷⣻⠷⣹⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠶⣿⣿⣿⣿⣻⣟⣿⣯⣿⣽⣯⣿⣷⣿⣿⣿⣿⣿⣿⣿⢏⡾⣹⣷⣝⢧⣫⠽⣹⢭⢞⣭⢳⡹⢮⡵⣯⢷⣻⢯⡯⠗⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣾⣵⣧⣿⣿⣾⣵⡿⣧⣿⢾⡾⣟⣿⣟⡿⠽⠛⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣽⣿⣾⣷⣯⣟⡝⠛⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠻⣼⡷⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣟⣿⣟⣿⣽⠳⣌⣳⡿⣽⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠛⠛⠿⠿⠿⠿⠯⠿⠿⠽⠿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

EOF
}

# Fungsi untuk ASCII Art setiap fitur
show_info_ascii() {
    cat << "EOF"
                                                    ⢀⣴⡆
                                                   ⢀⣾⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠋⠉⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠃⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⣠⠖⠲⢤⡖⠒⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⠀⠀⠀⠀⠀⠀⠀⠀⢀⡏⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⡏⠀⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⠀⠀⠀⠀⢀⣀⠀⠀⢸⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠸⣄⠀⠁⣠⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣠⣤⣤⣤⣤⠀⠀
                                        ⠀⡞⠉⠻⠁⢹⠀⠀⡏⠀⠀⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠹⣶⠋⠀⠀⠀⠀⣀⡤⠴⠒⠊⠉⠉⠀⠀⣿⣿⣿⠿⠋⠀⠀
                                        ⠀⠳⢤⡀⠀⡞⠁⠀⡇⠀⠀⢀⡠⠼⠴⠒⠒⠒⠒⠦⠤⠤⣄⣀⠀⢀⣠⠴⠚⠉⠀⠀⠀⠀⠀⠀⠀⠀⣼⠿⠋⠁⠀⠀⠀⠀
                                        ⠀⠀⠀⠈⠷⡏⠀⠀⣇⠔⠂⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠖⠋⠁⠀⠀⠀⠀⠀⠀⠀
                                        ⠀⠀⠀⠀⠀⠀⠀⢰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⠤⠒⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⠀⠀⠀⠀⠀⠀⢀⡟⠀⣠⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⢻⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⡤⠤⢴
                                        ⠀⠀⠀⠀⠀⠀⣸⠁⣾⣿⣀⣽⡆⠀⠀⠀⠀⠀⠀⠀⢠⣾⠉⢿⣦⠀⠀⠀⢸⡀⠀⠀⢀⣠⠤⠔⠒⠋⠉⠉⠀⠀⠀⠀⢀⡞
                                        ⠀⠀⠀⠀⠀⢀⡏⠀⠹⠿⠿⠟⠁⠀⠰⠦⠀⠀⠀⠀⠸⣿⣿⣿⡿⠀⠀⠀⢘⡧⠖⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠀
                                        ⠀⠀⠀⠀⠀⣼⠦⣄⠀⠀⢠⣀⣀⣴⠟⠶⣄⡀⠀⠀⡀⠀⠉⠁⠀⠀⠀⠀⢸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠁⠀
                                        ⠀⠀⠀⠀⢰⡇⠀⠈⡇⠀⠀⠸⡾⠁⠀⠀⠀⠉⠉⡏⠀⠀⠀⣠⠖⠉⠓⢤⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠃⠀⠀
                                        ⠀⠀⠀⠀⠀⢧⣀⡼⠃⠀⠀⠀⢧⠀⠀⠀⠀⠀⢸⠃⠀⠀⠀⣧⠀⠀⠀⣸⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠃⠀⠀⠀
                                        ⠀⠀⠀⠀⠀⠈⢧⡀⠀⠀⠀⠀⠘⣆⠀⠀⠀⢠⠏⠀⠀⠀⠀⠈⠳⠤⠖⠃⡟⠀⠀⠀⢾⠛⠛⠛⠛⠛⠛⠛⠛⠁⠀⠀⠀⠀
                                        ⠀⠀⠀⠀⠀⠀⠀⠙⣆⠀⠀⠀⠀⠈⠦⣀⡴⠋⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⠙⢦⠀⠀⠘⡇⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀
                                        ⠀⠀⠀⠀⠀⠀⠀⢠⡇⠙⠦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠋⠸⡇⠈⢳⡀⠀⢹⡀⠀⠀⠀⢀⡞⠁⠉⣇⣀⠀⠀
                                        ⠀⠀⠀⠀⠀⠀⠀⡼⣀⠀⠀⠈⠙⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⣷⠴⠚⠁⠀⣀⣷⠀⠀⠀⢠⠇⠀⠀⠀⠀⠀⣳
                                        ⠀⠀⠀⠀⠀⠀⡴⠁⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⡴⠚⠉⠉⠀⠀⠀⠀⢸⠃⣀⣠⠤⠤⠖⠋
                                        ⣼⢷⡆⠀⣠⡴⠧⣄⣇⠀⠀⠀⠀⡴⠚⠙⠲⠞⠛⠙⡆⠀⠀⠀⠀⠀⢀⡇⣠⣽⢦⣄⢀⣴⣶⠀⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⡿⣼⣽⡞⠁⠀⠀⠀⢹⡀⠀⠀⠀⢹⠀⠀⠀⠀⠀⠀⣸⠀⠀⠀⠀⠀⣼⠉⠁⠀⠀⢠⢟⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⣷⠉⠁⢳⠀⠀⠀⠀⠈⣧⠀⠀⠀⠀⠙⢦⠀⠀⠀⡠⠁⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⠏⠀⠀⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⠹⡆⠀⠈⡇⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⠀⠹⣧⠞⠁⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⠀⠀⠀⣸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⠀⢳⡀⠀⠙⠀⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⢀⡄⠀⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⠀⠀⢳⡀⣰⣀⣀⣀⠀⠀⠀⠘⣦⣀⠀⠀⠀⡇⠀⠀⠀⢀⡴⠃⠀⠀⠀⠀⠀⢸⡇⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                        ⠀⠀⠀⠉⠉⠀⠀⠈⠉⠉⠉⠙⠻⠿⠾⠾⠻⠓⢦⠦⡶⡶⠿⠛⠛⠓⠒⠒⠚⠛⠛⠁
                ,-.----.       ,----..          ,--.                    ____      ,----..            ,--.
                \    /  \     /   /   \     ,--/  /|    ,---,.        ,'  , `.   /   /   \         ,--.'|
                |   :    \   /   .     : ,---,': / '  ,'  .' |     ,-+-,.' _ |  /   .     :    ,--,:  : |
                |   |  .\ : .   /   ;.  \:   : '/ / ,---.'   |  ,-+-. ;   , || .   /   ;.  \,`--.'`|  ' :
                .   :  |: |.   ;   /  ` ;|   '   ,  |   |   .' ,--.'|'   |  ;|.   ;   /  ` ;|   :  :  | |
                |   |   \ :;   |  ; \ ; |'   |  /   :   :  |-,|   |  ,', |  ':;   |  ; \ ; |:   |   \ | :
                |   : .   /|   :  | ; | '|   ;  ;   :   |  ;/||   | /  | |  |||   :  | ; | '|   : '  '; |
                ;   | |`-' .   |  ' ' ' ::   '   \  |   :   .''   | :  | :  |,.   |  ' ' ' :'   ' ;.    ;
                |   | ;    '   ;  \; /  ||   |    ' |   |  |-,;   . |  ; |--' '   ;  \; /  ||   | | \   |
                :   ' |     \   \  ',  / '   : |.  \'   :  ;/||   : |  | ,     \   \  ',  / '   : |  ; .'
                :   : :      ;   :    /  |   | '_\.'|   |    \|   : '  |/       ;   :    /  |   | '`--'
                |   | :       \   \ .'   '   : |    |   :   .';   | |`-'         \   \ .'   '   : |
                `---'.|        `---`     ;   |,'    |   | ,'  |   ;/              `---`     ;   |.'
                  `---`                  '---'      `----'    '---'                         '---'
                                               .--.--.      ,---,         ,----..       ,---,.
                                         ,--, /  /    '.   '  .' \       /   /   \    ,'  .' |
                                       ,'_ /||  :  /`. /  /  ;    '.    |   :     : ,---.'   |
                                  .--. |  | :;  |  |--`  :  :       \   .   |  ;. / |   |   .'
                                ,'_ /| :  . ||  :  ;_    :  |   /\   \  .   ; /--`  :   :  |-,
                                |  ' | |  . . \  \    `. |  :  ' ;.   : ;   | ;  __ :   |  ;/|
                                |  | ' |  | |  `----.   \|  |  ;/  \   \|   : |.' .'|   :   .'
                                :  | | :  ' ;  __ \  \  |'  :  | \  \ ,'.   | '_.' :|   |  |-,
                                |  ; ' |  | ' /  /`--'  /|  |  '  '--'  '   ; : \  |'   :  ;/|
                                :  | : ;  ; |'--'.     / |  :  :        '   | '/  .'|   |    \
                                '  :  `--'   \ `--'---'  |  | ,'        |   :    /  |   :   .'
                                :  ,      .-./           `--''           \   \ .'   |   | ,'
                                 `--`----'                                `---`     `----'
		                                    ____            ____
		  .--.--.                         ,'  , `.        ,'  , `.   ,---,       ,-.----.
		 /  /    '.          ,--,      ,-+-,.' _ |     ,-+-,.' _ |  '  .' \      \    /  \        ,---,
		|  :  /`. /        ,'_ /|   ,-+-. ;   , ||  ,-+-. ;   , || /  ;    '.    ;   :    \      /_ ./|
		;  |  |--`    .--. |  | :  ,--.'|'   |  ;| ,--.'|'   |  ;|:  :       \   |   | .\ :,---, |  ' :
		|  :  ;_    ,'_ /| :  . | |   |  ,', |  ':|   |  ,', |  '::  |   /\   \  .   : |: /___/ \.  : |
		 \  \    `. |  ' | |  . . |   | /  | |  |||   | /  | |  |||  :  ' ;.   : |   |  \ :.  \  \ ,' '
		  `----.   \|  | ' |  | | '   | :  | :  |,'   | :  | :  |,|  |  ;/  \   \|   : .  / \  ;  `  ,'
		  __ \  \  |:  | | :  ' ; ;   . |  ; |--' ;   . |  ; |--' '  :  | \  \ ,';   | |  \  \  \    '
		 /  /`--'  /|  ; ' |  | ' |   : |  | ,    |   : |  | ,    |  |  '  '--'  |   | ;\  \  '  \   |
		'--'.     / :  | : ;  ; | |   : '  |/     |   : '  |/     |  :  :        :   ' | \.'   \  ;  ;
		  `--'---'  '  :  `--'   \;   | |`-'      ;   | |`-'      |  | ,'        :   : :-'      :  \  \
		            :  ,      .-./|   ;/          |   ;/          `--''          |   |.'         \  ' ;
		             `--`----'    '---'           '---'                          `---'            `--`
EOF
}

show_sort_ascii() {
    cat << "EOF"
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠖⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡤⢤⡀⠀⠀⠀⠀⢸⠀⢱⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⡀⠈⠢⡀⠀⠀⢀⠀⠈⡄⠀⠀⠀⠀⠀⠀⠀⠀⡔⠦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⠊⡹⠀⠀⠘⢄⠀⠈⠲⢖⠈⠀⠀⠱⡀⠀⠀⠀⠀⠀⠀⠀⠙⣄⠈⠢⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠖⠁⢠⠞⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀⠀⠀⢱⠀⠀⠀⠀⠀⠀⠀⠀⠈⡆⠀⠀⠉⠑⠢⢄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⡠⠚⠁⠀⠀⠀⡇⠀⠀⠀⠀⠀⢀⠇⠀⡤⡀⠀⠀⠀⢀⣼⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⢠⣾⣿⣷⣶⣤⣄⣉⠑⣄⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⢀⠞⢁⣴⣾⣿⣿⡆⢇⠀⠀⠀⠀⠀⠸⡀⠀⠂⠿⢦⡰⠀⠀⠋⡄⠀⠀⠀⠀⠀⠀⠀⢰⠁⣿⣿⣿⣿⣿⣿⣿⣿⣷⣌⢆⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⡴⢁⣴⣿⣿⣿⣿⣿⣿⡘⡄⠀⠀⠀⠀⠀⠱⣔⠤⡀⠀⠀⠀⠀⠀⠈⡆⠀⠀⠀⠀⠀⠀⡜⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⢣⠀⠀⠀⠀⠀
				⠀⠀⠀⡼⢠⣾⣿⣿⣿⣿⣿⣿⣿⣧⡘⢆⠀⠀⠀⠀⠀⢃⠑⢌⣦⠀⠩⠉⠀⡜⠀⠀⠀⠀⠀⠀⢠⠃⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣣⡀⠀⠀⠀
				⠀⠀⢰⢃⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠱⡀⠀⠀⠀⢸⠀⠀⠓⠭⡭⠙⠋⠀⠀⠀⠀⠀⠀⠀⡜⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡱⡄⠀⠀
				⠀⠀⡏⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢃⠀⠀⠀⢸⠀⠀⠀⠀⢰⠀⠀⠀⠀⠀⠀⠀⢀⠜⢁⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠘⣆⠀
				⠀⢸⢱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡘⣆⠀⠀⡆⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⡠⠖⣡⣾⠁⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⢸⠀
				⠀⡏⣾⣿⣿⣿⣿⡿⡛⢟⢿⣿⣿⣿⣿⣿⣿⣧⡈⢦⣠⠃⠀⠀⠀⠀⠀⢱⣀⠤⠒⢉⣾⡉⠻⠋⠈⢘⢿⣿⣿⣿⣿⠿⣿⣿⠏⠉⠻⢿⣿⣿⣿⣿⡘⡆
				⢰⡇⣿⣿⠟⠁⢸⣠⠂⡄⣃⠜⣿⣿⠿⠿⣿⣿⡿⠦⡎⠀⠀⠀⠀⠀⠒⠉⠉⠑⣴⣿⣿⣎⠁⠠⠂⠮⢔⣿⡿⠉⠁⠀⠹⡛⢀⣀⡠⠀⠙⢿⣿⣿⡇⡇
				⠘⡇⠏⠀⠀⠀⡾⠤⡀⠑⠒⠈⠣⣀⣀⡀⠤⠋⢀⡜⣀⣠⣤⣀⠀⠀⠀⠀⠀⠀⠙⢿⡟⠉⡃⠈⢀⠴⣿⣿⣀⡀⠀⠀⠀⠈⡈⠊⠀⠀⠀⠀⠙⢿⡇⡇
				⠀⠿⠀⠀⠀⠀⠈⠀⠉⠙⠓⢤⣀⠀⠁⣀⡠⢔⡿⠊⠀⠀⠀⠀⠙⢦⡀⠀⠐⠢⢄⡀⠁⡲⠃⠀⡜⠀⠹⠟⠻⣿⣰⡐⣄⠎⠀⠀⠀⠀⠀⠀⠀⠀⢣⡇
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠁⠀⡜⠀⠀⠀⠀⠀⠀⠀⠀⠱⡀⠀⠀⠀⠙⢦⣀⢀⡴⠁⠀⠀⠀⠀⠉⠁⢱⠈⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢱⠀⠀⠀⠀⠈⢏⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠈⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠱⡄⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡜⠀⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⠀⠀⣰⠃⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠀⠀⠘⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠁⠀⠀⠀⠀⠀⠀⠸⡄⠀⠀⠀⢀⡴⠁⠀⠀⢀⠇⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢧⠀⠀⠀⠘⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⣧⣠⠤⠖⠋⠀⠀⠀⠀⡸⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⡀⠀⠀⠀⠳⢄⠀⠀⠀⠀⠀⠀⠀⢣⠀⠀⠀⠀⠀⠀⠀⠀⡏⠀⠀⠀⠀⠀⠀⢀⡴⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡠⠊⠈⠁⠀⠀⠀⡔⠛⠲⣤⣀⣀⣀⠀⠈⢣⡀⠀⠀⠀⠀⠀⢸⠁⠀⠀⠀⢀⡠⢔⠝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⢈⠤⠒⣀⠀⠀⠀⠀⣀⠟⠀⠀⠀⠑⠢⢄⡀⠀⠀⠈⡗⠂⠀⠀⠀⠙⢦⠤⠒⢊⡡⠚⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠆⠒⣒⡁⠬⠦⠒⠉⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠒⢺⢠⠤⡀⢀⠤⡀⠠⠷⡊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠣⡀⡱⠧⡀⢰⠓⠤⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠈⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				                                            ,----,
				                ,----..                   ,/   .`|
				  .--.--.      /   /   \  ,-.----.      ,`   .'  :
				 /  /    '.   /   .     : \    /  \   ;    ;     /
				|  :  /`. /  .   /   ;.  \;   :    \.'___,/    ,'
				;  |  |--`  .   ;   /  ` ;|   | .\ :|    :     |
				|  :  ;_    ;   |  ; \ ; |.   : |: |;    |.';  ;
				 \  \    `. |   :  | ; | '|   |  \ :`----'  |  |
				  `----.   \.   |  ' ' ' :|   : .  /    '   :  ;
				  __ \  \  |'   ;  \; /  |;   | |  \    |   |  '
				 /  /`--'  / \   \  ',  / |   | ;\  \   '   :  |
				'--'.     /   ;   :    /  :   ' | \.'   ;   |.'
				  `--'---'     \   \ .'   :   : :-'     '---'
				                `---`     |   |.'
				                          `---'
EOF
}

show_search_ascii() {
    cat << "EOF"
			⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣠⠤⠤⠤⠤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠶⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠢⣄⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠁⠀⠀⠀⠀⢀⣀⡐⢄⠀⠀⠀⠀⠀⠀⠈⠳⣄⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡞⠁⠀⠀⠀⠀⠀⡜⠁⠀⣿⡌⠀⠀⠀⠀⠀⠀⠀⠀⠈⢆⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠀⠀⠀⠀⠀⠀⣸⣷⣤⣾⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠊⣼⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢤⡀⠀⠀⠀⢰⡇⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⡜⣼⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡎⠀⠉⠲⣄⣀⣼⡇⠀⠀⠀⠀⠀⠀⠻⠿⣿⣟⡼⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠉⠉⠁⠀⡏⠑⠌⠓⢬⣧⠀⠀⠀⠀⠘⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⠿⡀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣇⠀⠀⠀⠇⠀⠀⠀⠀⠙⣆⠀⠀⠀⠀⠀⠈⠉⠓⠒⠲⠤⢤⣀⠀⠂⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀
			⠀⠀⠀⠀⢀⣠⠤⠖⠒⠒⠒⠦⢤⡀⠀⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠈⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠲⠤⠤⠒⠋⢉⠟⠀⠀⠀⠀
			⠀⠀⢀⡴⠋⠁⠀⠀⠀⠀⠀⠀⠀⠙⢦⠀⠀⠀⢠⡞⠹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠋⠀⠀⠀⠀⠀
			⠀⣠⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢇⠀⢠⡟⠀⠀⠹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⡏⠈⠑⠢⢤⣀⣀⠀⠀⠀⠀⢀⣀⡤⠖⠯⣀⠀⠀⠀⠀⠀⠀
			⢀⡟⠀⠀⠀⠀⠠⠴⠤⣀⠀⠀⠀⠀⠀⢸⣠⡟⠀⠀⠀⠀⢹⣄⠀⠀⠀⠀⠀⠀⢀⣼⡁⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⢻⠀⠀⠀⠀⠀⠉⠢⣄⣀⡀⠀
			⢸⡇⠀⠀⠀⠀⠀⠀⠀⠘⡆⠀⠀⠀⠀⢈⣿⡇⠀⠀⠀⠀⢸⠉⢢⣀⡀⢀⣀⣴⠟⠀⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡆⠀⠀⠀⠀⠀⠀⠀⠀⢇⡀
			⠘⣇⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⢸⡇⣷⠀⠀⠀⢀⡞⠀⢰⠏⠉⠉⠁⢸⡀⠀⠀⠀⠈⠓⠶⠤⣤⣄⣀⣠⡤⠴⡇⠀⠀⠀⠀⠀⠀⠀⠀⡔⠁
			⠀⠹⣆⠀⠀⠀⠀⠀⢀⡼⠁⠀⠀⠀⠀⢸⠁⠸⡆⠀⣠⠞⠀⢀⡞⠀⠀⠀⠀⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⢸⠃⠀⠀⢰⣧⣀⣀⡀⠀⢀⣀⣠⠴⠃⠀
			⠀⠀⠹⡓⠦⠤⠤⠖⠋⠀⠀⠀⠀⠀⠀⢸⠀⠀⠹⡴⠁⠀⢠⠞⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⡞⠀⠀⠀⣸⠀⠀⠉⠉⠉⠉⠀⠀⠀⠀⠀
			⠀⠀⠀⠘⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⢸⢁⡠⠴⢧⡀⠀⠀⠀⠀⣀⠔⠳⣄⠀⠀⠀⠀⠀⠀⡼⠁⠀⠀⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠘⣇⣠⡿⠋⠀⠀⠀⠙⢦⣀⡠⠞⠁⠀⠀⠈⠙⠶⣤⣀⡀⣰⠃⠀⠀⣠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠙⢦⣀⠀⠀⠀⠀⠀⠀⣸⠏⠀⠀⠀⠀⠀⠀⠈⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣹⠋⠉⠉⣹⠏⠙⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠲⢤⣄⣀⣠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀⠀⠀⠀⡰⠃⢀⣤⠞⠁⠀⠀⠘⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡽⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣻⠶⠤⠤⠤⠤⠤⢤⣞⡥⠖⠋⠀⠀⠀⠀⠀⠀⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠟⠒⠀⠀⠒⠒⠺⢯⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠃⠀⠀⠀⠀⠀⠀⠀⠀⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⢄⣈⠆⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⢄⡀⠀⠀⠀⠀⠀⠀⢀⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣄⠀⠀⠀⠀⢀⣠⠴⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢇⣀⡤⠖⢄⠀⣰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⠒⠒⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠈⠙⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			                                                                   ,--,
			  .--.--.       ,---,.   ,---,       ,-.----.     ,----..        ,--.'|
			 /  /    '.   ,'  .' |  '  .' \      \    /  \   /   /   \    ,--,  | :
			|  :  /`. / ,---.'   | /  ;    '.    ;   :    \ |   :     :,---.'|  : '
			;  |  |--`  |   |   .':  :       \   |   | .\ : .   |  ;. /|   | : _' |
			|  :  ;_    :   :  |-,:  |   /\   \  .   : |: | .   ; /--` :   : |.'  |
			 \  \    `. :   |  ;/||  :  ' ;.   : |   |  \ : ;   | ;    |   ' '  ; :
			  `----.   \|   :   .'|  |  ;/  \   \|   : .  / |   : |    '   |  .'. |
			  __ \  \  ||   |  |-,'  :  | \  \ ,';   | |  \ .   | '___ |   | :  | '
			 /  /`--'  /'   :  ;/||  |  '  '--'  |   | ;\  \'   ; : .'|'   : |  : ;
			'--'.     / |   |    \|  :  :        :   ' | \.''   | '/  :|   | '  ,/
			  `--'---'  |   :   .'|  | ,'        :   : :-'  |   :    / ;   : ;--'
			            |   | ,'  `--''          |   |.'     \   \ .'  |   ,/
			            `----'                   `---'        `---`    '---'
EOF
}

show_filter_ascii() {
    cat << "EOF"
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣾⡄
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣶⣾⣷⣾⣿⣃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⠟⢹⣧
			⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠋⠀⢸⣿
			⠀⠀⠀⢀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⡿⠁⠀⠀⢸⣿
			⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⡀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⡿⠁⠀⠀⠀⣿⣿
			⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣍⢤⣬⣥⣾⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⠁⠀⠀⠀⢰⣿⡏
			⣸⣿⣿⣿⣿⣿⣿⡟⠛⠻⠿⠿⠿⠿⣿⡿⠇⢨⣍⣙⣛⣠⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⡏⠀⠀⠀⢀⣾⣿⠁
			⣿⣿⣿⣿⣿⣿⣿⣧⡘⢶⣶⣶⣶⣶⣶⣤⣤⣤⣤⣭⣉⣉⣉⣛⠛⠿⠿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⢀⣠⣴⣦⣤⣶⣶⣿⣿⣧⣤⣤⣄⠉⢻⡇⠀⠀⠀⣼⣿⡏⠀
			⣿⣿⣿⣿⣿⣿⠿⣿⣿⣄⠙⢿⣿⣄⠀⠀⠀⠀⠈⠉⠙⠛⠻⠿⣿⣿⣶⣤⡉⠻⣿⣿⣿⡆⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣥⣤⣭⣁⣀⠀⣸⣿⡟⠀⠀
			⢻⣿⣿⣿⣿⣿⡄⢬⣙⠻⢰⣤⡙⠻⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣿⣷⣌⠻⢿⡇⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣍⡁⠿⠋⠀⠀⠀
			⠸⣿⡏⣉⡻⢿⣿⡜⣿⣿⣿⣿⣿⣶⣄⡙⠻⣷⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣷⣄⢁⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⣛⣛⠛⠂⠀⠀⠀⠀
			⠀⢻⡇⣿⣿⣶⣬⣙⠈⢿⣿⣿⣿⣿⣿⣿⣶⣌⡙⠻⢿⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀
			⠀⠈⠁⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣈⠙⠻⢿⣿⣶⣦⣄⣀⣀⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀
			⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠗⢀⣀⣉⠙⠛⠛⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣉⠻⣿⣿⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢉⣠⣾⣿⣿⠟⣁⣤⣴⣶⣶⢸⣿⣿⣿⣿⣿⣿⣿⢟⣛⠻⣿⣿⣿⣿⣿⣿⣿⣿⠁⣿⠇⠸⣿⡀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠿⢿⣿⣿⣿⣿⡿⠃⣴⣿⣿⣿⠟⣡⣾⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⢣⣿⣿⠀⠘⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⣿⡇⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⢀⣾⣿⣿⣿⠏⣼⡿⢟⣿⣿⣿⣿⣿⠀⣿⣿⣿⣿⣿⣿⠘⠛⠋⠀⠀⢹⣿⣿⣿⣿⣿⣿⣇⠠⠤⢃⣿⡇⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣀⡅⣠⣿⣿⣿⣿⣿⣿⣇⢹⣿⣿⣿⣿⣿⠰⣷⣀⣠⡄⣸⣿⣿⣿⣿⣿⠿⢻⣷⣶⣿⣿⡇⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⢡⣿⣿⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⣿⣷⣬⣉⣉⣴⣿⣿⣿⣿⣿⣿⣿⠿⢟⣿⣿⠟⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⡇⢸⡇⣿⣿⣿⣿⣿⡿⢹⣿⣦⡙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⣋⣭⣶⣾⡿⢟⣡⣾⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣇⢈⣥⢸⣿⣿⣿⣿⡇⣾⣿⣿⣿⣶⣬⣙⠻⠿⣿⣿⣿⣿⣿⣿⠿⠿⢛⣉⣥⣶⣿⡿⠟⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⡿⠈⢿⣿⣿⣿⡀⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣤⣤⣤⣴⣶⣾⣿⣿⢿⣿⣿⠁⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⠡⣿⣌⢻⣿⣿⣧⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⠃⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⠇⠀⢿⣿⣷⡙⠛⣿⡇⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠛⠁⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⠀⠀⠈⢿⣿⣿⣶⠈⣰⣷⣬⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠈⠉⠋⢠⣿⣿⣿⣿⣮⡛⢿⠏⠻⢿⣿⣿⣿⣿⢟⣴⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⢿⠆⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⢉⡛⠟⣱⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⠀⠀⠀⠀⠈⣿⣾⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⢹⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠉⠛⠋⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⣿⡟⢿⠟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				                     ,--,           ,----,
				                  ,---.'|         ,/   .`|
				    ,---,.   ,---,|   | :       ,`   .'  :   ,---,.,-.----.
				  ,'  .' |,`--.' |:   : |     ;    ;     / ,'  .' |\    /  \
				,---.'   ||   :  :|   ' :   .'___,/    ,',---.'   |;   :    \
				|   |   .':   |  ';   ; '   |    :     | |   |   .'|   | .\ :
				:   :  :  |   :  |'   | |__ ;    |.';  ; :   :  |-,.   : |: |
				:   |  |-,'   '  ;|   | :.'|`----'  |  | :   |  ;/||   |  \ :
				|   :  ;/||   |  |'   :    ;    '   :  ; |   :   .'|   : .  /
				|   |   .''   :  ;|   |  ./     |   |  ' |   |  |-,;   | |  \
				'   :  '  |   |  ';   : ;       '   :  | '   :  ;/||   | ;\  \
				|   |  |  '   :  ||   ,/        ;   |.'  |   |    \:   ' | \.'
				|   :  \  ;   |.' '---'         '---'    |   :   .':   : :-'
				|   | ,'  '---'                          |   | ,'  |   |.'
				`----'                                   `----'    `---'
EOF
}

if [[ ! -f "$1" ]]; then
    echo "Error: File not Found!"
    exit 1
fi

FILE="$1"
COMMAND="$2"
OPTION="$3"
```
- `#!/bin/bash`: Shebang line yang menunjukkan bahwa skrip ini akan dijalankan menggunakan Bash shell
<br>

- `LINE=$(printf '=%.0s' $(seq 1 $(tput cols)))`:
    - `tput cols` → Mengambil jumlah kolom terminal saat ini
    - `seq 1 $(tput cols)` → Membuat deret angka dari 1 hingga jumlah kolom terminal
    - `printf '=%.0s' $(seq 1 $(tput cols))` → Mencetak karakter '=' sebanyak jumlah kolom terminal tanpa output tambahan
    - Variabel LINE akan berisi garis horizontal '=' sepanjang terminal
<br>

- `print_centered()` → Mendefinisikan fungsi untuk mencetak teks di tengah terminal
    - `local termwidth=$(tput cols)` → Mengambil jumlah kolom terminal
    - `local padding=$(((termwidth - ${#1}) / 2))` → Menghitung jumlah spasi di kiri dan kanan agar teks berada di tengah
    - `printf "%*s%s%*s\n" $padding "" "$1" $padding ""` → Mencetak teks dengan spasi di kiri dan kanan agar berada di tengah
<br>

- `show_help_ascii()` → Fungsi untuk menampilkan teks ASCII (help)
- `show_info_ascii()` → Fungsi untuk menampilkan teks ASCII (info)
- `show_sort_ascii()` → Fungsi untuk menampilkan teks ASCII (sort)
- `show_search_ascii()` → Fungsi untuk menampilkan teks ASCII (search)
- `show_filter_ascii()` → Fungsi untuk menampilkan teks ASCII (filter)
- `cat << "EOF" ... EOF` → Tempat menulis teks ASCII
<br>

- `if [[ ! -f "$1" ]]; then` → Jika kolom pertama($1)/file tidak ada
- `echo "Error: File not Found!"` → Tampilkan error
- `exit 1` → Menghentikan script
- `fi` → Menutup if
<br>

- Contoh: `./script.sh pokemon_usage.csv --info dark`
- `FILE="$1"` → Mengisi variabel `FILE` dengan argumen pertama (`pokemon_usage.csv`)
- `COMMAND="$2"` → Mengisi variabel `COMMAND` dengan argumen kedua (`--info`)
- `OPTION="$3"` → Mengisi variable `OPTION` dengan argumen ketiga (`dark`)
<br>

A. Melihat summary dari data → Untuk mengetahui Pokemon apa yang sedang membawa teror kepada lingkungan “*8eneration 9 OverUsed*” anda berusaha untuk membuat sebuah fitur untuk menampilkan nama Pokemon dengan Usage% dan RawUsage paling tinggi.

```bash
case "$COMMAND" in
    -i|--info)
        show_info_ascii
        USAGE_POKEMON=$(awk -F',' 'NR>1 { if ($2 > maxUsage) { maxUsage = $2; maxPokemon = $1 } } END { print maxPokemon }' "$FILE")
        USAGE_PERCENT=$(awk -F',' 'NR>1 { if ($2 > maxUsage) { maxUsage = $2 } } END { printf "%.5f", maxUsage }' "$FILE")
        RAW_POKEMON=$(awk -F',' 'NR>1 { if ($3 > maxRaw) { maxRaw = $3; maxRawPokemon = $1 } } END { print maxRawPokemon }' "$FILE")
        RAW_USAGE=$(awk -F',' 'NR>1 { if ($3 > maxRaw) { maxRaw = $3 } } END { print maxRaw }' "$FILE")

        print_centered "$LINE"
        print_centered "📜 USAGE SUMMARY OF $FILE"
        print_centered "$LINE"
        print_centered "🔹 Highest Adjusted Usage 🔹"
        print_centered "🦁 $USAGE_POKEMON with $USAGE_PERCENT%"
        print_centered ""
        print_centered "🔸 Highest Raw Usage 🔸"
        print_centered "🐯 $RAW_POKEMON with $RAW_USAGE uses"
        print_centered "$LINE"
        exit 0
        ;;
```
- `case "$COMMAND" in` → Memulai struktur case untuk menangani berbagai perintah yang diberikan sebagai argumen kedua (COMMAND)
- `i|--info)` → Jika argumen kedua adalah `-i` atau `--info`, maka perintah di dalam blok ini akan dijalankan
	- `show_info_ascii` → Memanggil fungsi untuk menampilkan teks ASCII terkait informasi
 	- `USAGE_POKEMON=$(awk -F',' 'NR>1 { if ($2 > maxUsage) { maxUsage = $2; maxPokemon = $1 } } END { print maxPokemon }' "$FILE")` → Menggunakan awk untuk mencari Pokémon dengan Usage% tertinggi pada dataset
		- `-F','` → Menentukan pemisah kolom sebagai koma (CSV)
		- `NR>1` → Melewati baris pertama (header)
		- `if ($2 > maxUsage) { maxUsage = $2; maxPokemon = $1 }` → Menyimpan Pokémon dengan nilai Usage% tertinggi
		- `END { print maxPokemon }` → Mencetak nama Pokémon dengan Usage% tertinggi
	- `USAGE_PERCENT=$(awk -F',' 'NR>1 { if ($2 > maxUsage) { maxUsage = $2 } } END { printf "%.5f", maxUsage }' "$FILE")` → Menggunakan awk untuk mencari persentase Usage% tertinggi dalam dataset (5 desimal)
	- `RAW_POKEMON=$(awk -F',' 'NR>1 { if ($3 > maxRaw) { maxRaw = $3; maxRawPokemon = $1 } } END { print maxRawPokemon }' "$FILE")` → Menggunakan awk untuk mencari Pokémon dengan RawUsage tertinggi pada dataset
	- `RAW_USAGE=$(awk -F',' 'NR>1 { if ($3 > maxRaw) { maxRaw = $3 } } END { print maxRaw }' "$FILE")` → Menggunakan awk untuk mencari nilai RawUsage tertinggi dalam dataset
- `print_centered "$LINE"` → Mencetak garis pemisah secara terpusat
- `print_centered "📜 USAGE SUMMARY OF $FILE"` → Menampilkan judul laporan
- `print_centered "$LINE"` → Mencetak garis pemisah
- `print_centered "🔹 Highest Adjusted Usage 🔹"` → Menampilkan subjudul
- `print_centered "🦁 $USAGE_POKEMON with $USAGE_PERCENT%"` → Menampilkan Pokémon dengan Usage% tertinggi
- `print_centered ""` → Mencetak baris kosong untuk pemisahan visual
- `print_centered "🔸 Highest Raw Usage 🔸"` → Menampilkan subjudul
- `print_centered "🐯 $RAW_POKEMON with $RAW_USAGE uses"` → Menampilkan Pokémon dengan RawUsage tertinggi
- `print_centered "$LINE"` → Mencetak garis pemisah
- `exit 0` → Menghentikan skrip dengan kode sukses
<br>

B. Mengurutkan Pokemon berdasarkan data kolom → Untuk memastikan bahwa anda mengetahui kondisi lingkungan “*8eneration 9 OverUsed*”, anda berusaha untuk membuat sebuah fitur untuk sort berdasarkan:
- Usage%
- RawUsage
- Nama
- HP
- Atk
- Def
- Sp.Atk
- Sp.Def
- Speed
 
Sort dilakukan dengan urutan descending untuk semua angka selain nama, yang diurutkan secara alphabetical. Output harus sesuai dengan format csv yang diberikan.

```bash
    -s|--sort)
    	show_sort_ascii
    	if [[ -z "$OPTION" ]]; then
        	echo "Error: No sorting option provided"
        	exit 1
    	fi
    	print_centered "$LINE"
    	print_centered "📜 SORTED POKEMON LIST BASED ON $OPTION"
    	print_centered "$LINE"

    	awk -F',' -v col="$OPTION" '
    	NR==1 {
        	for (i=1; i<=NF; i++) if (tolower($i) == tolower(col)) colnum = i;
        	if (!colnum) { print "Error: Column not found"; exit 1 }
        	print;
        	next;
    	}
    	{ print | "sort -t, -k" colnum "nr" }' "$FILE" | column -s ',' -t

    	print_centered "$LINE"
    	exit 0
    	;;
```
- `-s|--sort)` → Jika argumen kedua adalah `-s` atau `--sort`, maka blok perintah ini akan dijalankan
- `show_sort_ascii` → Memanggil fungsi untuk menampilkan teks ASCII terkait sorting
- `if [[ -z "$OPTION" ]]; then` → Mengecek apakah argumen ketiga `OPTION` kosong
	- `echo "Error: No sorting option provided"` → Jika tidak ada opsi sorting yang diberikan, tampilkan pesan error		
 	- `exit 1` → Hentikan skrip dengan kode error
- `print_centered "$LINE"` → Mencetak garis pemisah secara terpusat
- `print_centered "📜 SORTED POKEMON LIST BASED ON $OPTION"` → Menampilkan judul laporan berdasarkan opsi sorting yang diberikan
- `print_centered "$LINE"` → Mencetak garis pemisah
- `awk -F',' -v col="$OPTION" '` → Menggunakan awk untuk mencari kolom yang sesuai dengan OPTION dan mengurutkan datanya
	- `NR==1 {` → Jika sedang memproses baris pertama (header)
		- `for (i=1; i<=NF; i++) if (tolower($i) == tolower(col)) colnum = i;` → Loop untuk mencari indeks kolom yang sesuai dengan OPTION (case-insensitive)
		- `if (!colnum) { print "Error: Column not found"; exit 1 }` → Jika tidak ditemukan, tampilkan error dan hentikan skrip
		- `print;` → Cetak header
		- `next;` → Lompat ke baris berikutnya
	- `}` → Jika bukan header, cetak setiap baris dan teruskan ke perintah sort
- `sort -t, -k" colnum "nr"` → Mengurutkan data berdasarkan kolom yang ditemukan (colnum), menggunakan koma sebagai pemisah, dan sorting numerik (nr)
- `| column -s ',' -t` → Memformat output agar lebih rapi dengan pemisah kolom yang sesuai
- `print_centered "$LINE"` → Mencetak garis pemisah
- `exit 0` → Menghentikan skrip
<br>

C. Mencari nama Pokemon tertentu → Setelah mengetahui kondisi lingkungan “*Generation 9 OverUsed*”, anda ingin mencari tahu statistik penggunaan dari beberapa Pokemon yang mungkin dapat bertanding baik melawan sebagian besar Pokemon yang ada di Top 10 usage. Oleh karena itu, anda membuat fitur search berdasarkan nama Pokemon. Pastikan agar search yang dimasukkan tidak memunculkan hasil yang tidak diinginkan (seperti memunculkan semua Grass type ketika mengetik search “Grass”), dan output harus sesuai dengan format csv yang diberikan dengan sort Usage%.

```bash
    -sh|--search)
    	show_search_ascii
    	if [[ -z "$OPTION" ]]; then
        	echo "Error: No search term provided"
        	exit 1
    	fi
    	print_centered "$LINE"
    	print_centered "🔍 SEARCH RESULTS FOR: $OPTION"
    	print_centered "$LINE"

    	awk -F',' -v term="$OPTION" 'NR==1 || tolower($1) ~ tolower(term)' "$FILE" | sort -t',' -k2,2nr | column -s ',' -t

    	print_centered "$LINE"
    	exit 0
    	;;
```
- `-sh|--search)` → Jika argumen kedua adalah `-sh` atau `--search`, maka blok perintah ini akan dijalankan
	- `show_search_ascii` → Memanggil fungsi untuk menampilkan teks ASCII terkait pencarian
 	- `if [[ -z "$OPTION" ]]; then` → Mengecek apakah argumen ketiga `OPTION` kosong
		- `echo "Error: No search term provided"` → Jika tidak ada istilah pencarian, tampilkan pesan error
		- `exit 1` → Hentikan skrip dengan kode error
	- `print_centered "$LINE"` → Mencetak garis pemisah secara terpusat
	- `print_centered "🔍 SEARCH RESULTS FOR: $OPTION"` → Menampilkan judul hasil pencarian berdasarkan istilah yang diberikan
	- `print_centered "$LINE"` → Mencetak garis pemisah
 	- `awk -F',' -v term="$OPTION" 'NR==1 || tolower($1) ~ tolower(term)' "$FILE"` → Menggunakan awk untuk mencari Pokémon yang cocok dengan istilah pencarian
		- `-F','` → Menentukan koma sebagai pemisah kolom (CSV)
		- `-v term="$OPTION"` → Menyimpan istilah pencarian ke dalam variabel term
		- `NR==1` → Selalu mencetak baris pertama (header)
		- `tolower($1) ~ tolower(term)` → Mencari istilah dalam kolom pertama (nama Pokémon) secara case-insensitive
	- `| sort -t',' -k2,2nr` → Mengurutkan hasil pencarian berdasarkan olom kedua (Usage%) secara numerik dari terbesar ke terkecil
	- `| column -s ',' -t` → Memformat output agar lebih rapi dengan pemisah kolom yang sesuai
	- `print_centered "$LINE"` → Mencetak garis pemisah
	- `exit 0` → Menghentikan skrip
 <br>

D. Mencari Pokemon berdasarkan filter nama type → Agar dapat membuat tim yang baik, anda perlu memikirkan kombinasi yang baik dari beberapa Pokemon, hal ini disebut sebagai “core” oleh komunitas Pokemon! Oleh karena itu, anda berpikiran untuk membuat fitur filter berdasarkan Type sebuah Pokemon. Output harus sesuai dengan format csv yang diberikan dengan sort Usage%

```bash
    -f|--filter)
        show_filter_ascii
        if [[ -z "$OPTION" ]]; then
            echo "Error: No filter option provided"
            exit 1
        fi
        print_centered "$LINE"
        print_centered "🌿 FILTERED POKEMON LIST FOR TYPE: $OPTION"
        print_centered "$LINE"
        awk -F',' -v type="$OPTION" 'NR==1 || tolower($4) == tolower(type) || tolower($5) == tolower(type)' "$FILE" |sort -t',' -k2,2nr | column -s ',' -t
        print_centered "$LINE"
        exit 0
        ;;
```
- `-f|--filter)` → Jika argumen kedua adalah `-f` atau `--filter`, maka blok perintah ini akan dijalankan
	- `show_filter_ascii` → Memanggil fungsi untuk menampilkan teks ASCII terkait filter
	- `if [[ -z "$OPTION" ]]; then` → Mengecek apakah argumen ketiga `OPTION` kosong
		- `echo "Error: No filter option provided"` → Jika tidak ada opsi filter yang diberikan, tampilkan pesan error
		- `exit 1` → Hentikan skrip dengan kode error
	- `print_centered "$LINE"` → Mencetak garis pemisah secara terpusat
	- `print_centered "🌿 FILTERED POKEMON LIST FOR TYPE: $OPTION"` → Menampilkan judul daftar Pokémon yang difilter berdasarkan tipe tertentu
	- `print_centered "$LINE"` → Mencetak garis pemisah
	- `awk -F',' -v type="$OPTION" 'NR==1 || tolower($4) == tolower(type) || tolower($5) == tolower(type)' "$FILE"` → Menggunakan awk untuk memfilter Pokémon berdasarkan tipe yang diberikan
		- `-F','` → Menentukan koma sebagai pemisah kolom (CSV)
		- `-v type="$OPTION"` → Menyimpan tipe Pokémon yang ingin difilter ke dalam variabel type
		- `NR==1` → Selalu mencetak baris pertama (header)
		- `tolower($4) == tolower(type) || tolower($5) == tolower(type)` → Mencocokkan tipe Pokémon pada kolom ke-4 atau ke-5 (karena beberapa Pokémon memiliki dua tipe), dengan pencocokan case-insensitive
	- `| sort -t',' -k2,2nr` → Mengurutkan hasil filter berdasarkan kolom kedua (Usage%) secara numerik dari terbesar ke terkecil
	- `| column -s ',' -t` → Memformat output agar lebih rapi dengan pemisah kolom yang sesuai
	- `print_centered "$LINE" → Mencetak garis pemisah`
	- `exit 0` → Menghentikan skrip dengan kode sukses
   <br>

E. Error handling → Pastikan program yang anda buat mengecek semua kesalahan pengguna agar dapat memberikan kejelasan kepada pengguna pada setiap kasus.

```bash
if [[ ! -f "$1" ]]; then
    echo "Error: File not Found!"
    exit 1
fi
```
- Mengatasi file yang tidak ada

```bash
if [[ -z "$OPTION" ]]; then
	echo "Error: No sorting option provided"
	exit 1
fi
```
- Mengatasi argumen kedua yang tidak ada

```bash
    *)
        show_info_ascii
        print_centered "$LINE"
        print_centered "❌ ERROR: Invalid Command"
        print_centered "$LINE"
        exit 1
        ;;
```
- Mengatasi argumen ketiga yang tidak ada
<br>

F. Help screen yang menarik → Untuk memberikan petunjuk yang baik pada pengguna program, anda berpikir untuk membuat sebuah help screen yang muncul ketika mengetik -h atau --help sebagai command yang dijalankan. Kriteria yang harus ada dalam help screen pada program ini adalah:
- ASCII Art yang menarik! Gunakan kreativitas anda untuk mencari/membuat art yang cocok untuk program yang sudah anda buat!
- Penjelasan setiap command dan sub-command

```bash
    -h|--help)
        show_help_ascii
        print_centered "$LINE"
        print_centered "📜 HELP SCREEN"
        print_centered "$LINE"
        cat << EOF
	Usage: ./pokemon_analysis.sh <file_name> [options]

	Options:
	  -h, --help            Display this help message.
	  -i, --info            Display the highest adjusted and raw usage.
	  -s, --sort <method>   Sort the data by the specified column.
	                        name    Sort by Pokemon name.
	                        usage   Sort by Adjusted Usage.
	                        raw     Sort by Raw Usage.
	                        hp      Sort by HP.
	                        atk     Sort by Attack.
	                        def     Sort by Defense.
	                        spatk   Sort by Special Attack.
	                        spdef   Sort by Special Defense.
	                        speed   Sort by Speed.
	  -sh, --search <name>     Search for a specific Pokemon sorted by usage.
	  -f, --filter <type>   Filter by type of Pokemon sorted by usage.
EOF
        print_centered "$LINE"
        exit 0
        ;;
```
- `-h|--help)` → Jika argumen kedua adalah `-h` atau `--help`, maka blok perintah ini akan dijalankan
	- `show_help_ascii` → Memanggil fungsi untuk menampilkan teks ASCII terkait bantuan
	- `print_centered "$LINE"` → Mencetak garis pemisah secara terpusat
	- `print_centered "📜 HELP SCREEN"` → Menampilkan judul "HELP SCREEN"
	- `print_centered "$LINE"` → Mencetak garis pemisah
	- `cat << EOF ... EOF` → Menampilkan blok teks bantuan kepada pengguna
		- `Usage: ./pokemon_analysis.sh <file_name> [options]` → Menjelaskan cara menggunakan skrip
		- `Options:` → Daftar opsi yang tersedia dalam skrip
		- `-h, --help` → Menampilkan pesan bantuan
		- `-i, --info` → Menampilkan Pokémon dengan Adjusted Usage dan Raw Usage tertinggi
		- `-s, --sort <method>` → Mengurutkan data berdasarkan kolom tertentu
			- `name` → Mengurutkan berdasarkan nama Pokémon
			- `usage` → Mengurutkan berdasarkan Adjusted Usage
			- `raw` → Mengurutkan berdasarkan Raw Usage
			- `hp` → Mengurutkan berdasarkan HP
			- `atk` → Mengurutkan berdasarkan Attack
			- `def` → Mengurutkan berdasarkan Defense
			- `spatk` → Mengurutkan berdasarkan Special Attack
			- `spdef` → Mengurutkan berdasarkan Special Defense
			- `speed` → Mengurutkan berdasarkan Speed
		- `-sh, --search <name>` → Mencari Pokémon berdasarkan nama dan mengurutkan hasilnya berdasarkan Usage
		- `-f, --filter <type>` → Memfilter Pokémon berdasarkan tipe dan mengurutkan hasilnya berdasarkan Usage
	- `print_centered "$LINE"` → Mencetak garis pemisah
	- `exit 0` → Menghentikan skrip
