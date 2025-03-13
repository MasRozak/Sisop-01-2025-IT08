#!/bin/bash

DB_PATH="/data/player.csv"
SALT="static_salt"

touch "$DB_PATH"

validate_email() {
    [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]
}

validate_password() {
    [[ "$1" =~ [A-Z] ]] && [[ "$1" =~ [a-z] ]] && [[ "$1" =~ [0-9] ]] && [[ ${#1} -ge 8 ]]
}

while true; do
    read -p "Enter email: " email
    if ! validate_email "$email"; then
        echo "❌ Invalid email format!"
        continue
    fi

    if grep -q "^$email," "$DB_PATH"; then
        echo "❌ Email is already registered!"
        continue
    fi

    read -p "Enter username: " username
    if [[ -z "$username" ]]; then
        echo "❌ Username cannot be empty!"
        continue
    fi

    while true; do
        read -s -p "Enter password: " password
        echo ""
        if ! validate_password "$password"; then
            echo "❌ Password must have at least 8 characters, 1 uppercase letter, 1 lowercase letter, and 1 number!"
            continue
        fi
        break
    done

    hashed_password=$(echo -n "$password$SALT" | sha256sum | awk '{print $1}')
    echo "$email,$username,$hashed_password" >> "$DB_PATH"

    echo "✅ Registration successful!"
    break
done

