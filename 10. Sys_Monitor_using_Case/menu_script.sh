#!/usr/bin/env bash
# Enhanced System Monitoring Menu

set -euo pipefail

while true; do
    clear
    echo -e "\e[1;34m================== System Menu ==================\e[0m"
    echo -e "\e[1;32m1)\e[0m Disk Usage"
    echo -e "\e[1;32m2)\e[0m Memory Usage"
    echo -e "\e[1;32m3)\e[0m CPU Usage (Top 10)"
    echo -e "\e[1;32m4)\e[0m Top Memory-Consuming Processes"
    echo -e "\e[1;32m5)\e[0m Network Info"
    echo -e "\e[1;32m6)\e[0m Logged-in Users"
    echo -e "\e[1;32m7)\e[0m System Uptime"
    echo -e "\e[1;32m8)\e[0m Exit"
    echo -e "\e[1;34m=================================================\e[0m"

    read -rp "Enter your choice [1-8]: " choice

    case "$choice" in
        1)
            echo -e "\nDisk Usage:\n"
            df -h
            ;;
        2)
            echo -e "\nMemory Usage:\n"
            free -h
            ;;
        3)
            echo -e "\nCPU Usage (Top 10 processes):\n"
            top -bn1 | head -n 20
            ;;
        4)
            echo -e "\nTop 10 Memory-Consuming Processes:\n"
            ps aux --sort=-%mem | head -n 10
            ;;
        5)
            echo -e "\nNetwork Info:\n"
            ip addr
            ;;
        6)
            echo -e "\nLogged-in Users:\n"
            who
            ;;
        7)
            echo -e "\nSystem Uptime:\n"
            uptime
            ;;
        8)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice! Please enter a number between 1 and 8."
            ;;
    esac

    echo
    read -rp "Press Enter to return to the menu..." dummy
done
