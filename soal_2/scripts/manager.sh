#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")

while true; do
	clear

	cat << "EOF"

  ___             _        _      __  __
 / __|_ _ ___ _ _| |_ __ _| |__  |  \/  |__ _ _ _  __ _ __ _ ___ _ _
| (__| '_/ _ \ ' \  _/ _` | '_ \ | |\/| / _` | ' \/ _` / _` / -_) '_|
 \___|_| \___/_||_\__\__,_|_.__/ |_|  |_\__,_|_||_\__,_\__, \___|_|
                                                       |___/

     ┌───────────────────────────────────────────────────────┐
     │                  ARCAEA TERMINAL                      │
     ├───────┬───────────────────────────────────────────────┤
     │  ID   │ OPTION                                        │
     ├───────┼───────────────────────────────────────────────┤
     │   1   │ Add CPU - Core Monitor to Crontab             │
     │   2   │ Add RAM - Fragment Monitor to Crontab         │
     │   3   │ Remove CPU - Core Monitor from Crontab        │
     │   4   │ Remove RAM - Fragment Monitor from Crontab    │
     │   5   │ View All Scheduled Monitoring Jobs            │
     │   6   │ Exit Arcaea Terminal                          │
     └───────┴───────────────────────────────────────────────┘
EOF

	printf "\n> Enter option [1-6]: "
	read choice

	case $choice in
    	1)
        	(crontab -l 2>/dev/null; echo "* * * * * /bin/bash $SCRIPT_DIR/core_monitor.sh") | crontab -
        	echo "✅ CPU Monitoring added to crontab."
        	;;
    	2)
        	(crontab -l 2>/dev/null; echo "* * * * * /bin/bash $SCRIPT_DIR/frag_monitor.sh") | crontab -
        	echo "✅ RAM Monitoring added to crontab."
        	;;
    	3)
        	crontab -l | grep -v "$SCRIPT_DIR/core_monitor.sh" | crontab -
        	echo "✅ CPU Monitoring removed from crontab."
        	;;
    	4)
        	crontab -l | grep -v "$SCRIPT_DIR/frag_monitor.sh" | crontab -
        	echo "✅ RAM Monitoring removed from crontab."
        	;;
    	5)
        	echo "📋 Active crontab schedules:"
        	crontab -l
        	;;
    	6)
        	echo "👋 Exiting..."
        	exit 0
        	;;
    	*)
        	echo "❌ Invalid choice."
        	;;
	esac

    printf "\nPress Enter to continue..."
    read
done
