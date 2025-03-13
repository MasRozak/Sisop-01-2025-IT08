#!/bin/bash

clear

cat << "EOF"
   ___   ___  ________   _______     ______  __________________  ___
  / _ | / _ \/ ___/ _ | / __/ _ |   / __/\ \/ / __/_  __/ __/  |/  /
 / __ |/ , _/ /__/ __ |/ _// __ |  _\ \   \  /\ \  / / / _// /|_/ /
/_/ |_/_/|_|\___/_/ |_/___/_/ |_| /___/   /_/___/ /_/ /___/_/  /_/
⠀⠀⠀⠀⠀⠀⠀⠀⠀
EOF

echo "          ┌───────────────────────────────────────┐"
echo "          │            ARCAEA TERMINAL            │"
echo "          ├───────┬───────────────────────────────┤"
echo "          │  ID   │ OPTION                        │"
echo "          ├───────┼───────────────────────────────┤"
echo "          │   1   │ Register New Account          │"
echo "          │   2   │ Login to Existing Account     │"
echo "          │   3   │ Exit Arcaea Terminal          │"
echo "          └───────┴───────────────────────────────┘"

printf "\n> Enter option [1-3]: "
read choice

case $choice in
    1)
        bash register.sh
        ;;
    2)
        bash login.sh
        if [ $? -eq 0 ]; then
            bash ./scripts/manager.sh
        fi
        ;;
    3)
        echo -e "\n👋 Exiting Arcaea Terminal..."
        exit 0
        ;;
    *)
        echo -e "\n❌ Invalid choice. Please enter a number between 1 and 3."
        ;;
esac

