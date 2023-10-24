#!/bin/bash

HOSTNAME=$(hostname)

TIMEZONE="$(timedatectl | grep "Time zone" | awk '{print($3)}') UTC $(date +"%:z" | awk '{split($0,hour,":"); print(hour[1])}')"

USER=$(whoami)

DATE=$(date +"%d %b %Y %T")

UPTIME=$(uptime -p)

UPTIME_SEC=$(awk '{print int($1)}' /proc/uptime)

IP=$(ip a | grep -w "inet" | grep -v "127.0.0.1" | awk '{print($2)}' | cut -d/ -f1)

MASK=$(ipcalc "$(ip a | grep -w "inet" | grep -v "127.0.0.1" | awk '{print($2)}' | awk '{split($0,a,"/"); print(a[2])}')" | grep "Address" | awk '{print($2)}')

GATEWAY=$(ip route | grep "default" | awk '{print($3)}')

RAM_TOTAL=$(free -m | awk '/Mem:/{printf "%.3f GB", $2/1024}')

RAM_USED=$(free -m | awk '/Mem:/{printf "%.3f GB", $3/1024}')

RAM_FREE=$(free -m | awk '/Mem:/{printf "%.3f GB", $4/1024}')

SPACE_ROOT=$(df /root | awk '/\/$/ {printf "%.2f", $2/1024}')

SPACE_ROOT_USED=$(df /root | awk '/\/$/ {printf "%.2f", $3/1024}')

SPACE_ROOT_FREE=$(df /root | awk '/\/$/ {printf "%.2f", $4/1024}')


