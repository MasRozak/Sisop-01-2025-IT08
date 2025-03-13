#!/bin/bash

DB_PATH="/data/player.csv"
SALT="static_salt"

read -p "Enter email: " email
read -s -p "Enter password: " password
echo ""

hashed_password=$(echo -n "$password$SALT" | sha256sum | awk '{print $1}')

if grep -q "^$email,.*,$hashed_password" "$DB_PATH"; then
    username=$(grep "^$email," "$DB_PATH" | cut -d',' -f2)
    echo "✅ Login successful! Welcome, $username"
else
    echo "❌ Incorrect email or password!"
    exit 1
fi
