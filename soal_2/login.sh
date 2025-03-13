#!/bin/bash

DB_PATH="/data/player.csv"
SALT="static_salt"

while true; do
    read -p "Enter email: " email
    read -s -p "Enter password: " password
    echo ""

    hashed_password=$(echo -n "$password$SALT" | sha256sum | awk '{print $1}')
    user_data=$(grep "^$email," "$DB_PATH")

    if [[ -z "$user_data" ]]; then
        echo "❌ Incorrect email or password! Please try again."
        continue
    fi

    stored_password=$(echo "$user_data" | cut -d',' -f3)

    if [[ "$hashed_password" == "$stored_password" ]]; then
        username=$(echo "$user_data" | cut -d',' -f2)
        echo "✅ Login successful! Welcome, $username"
        exit 0
    else
        echo "❌ Incorrect email or password! Please try again."
    fi
done




