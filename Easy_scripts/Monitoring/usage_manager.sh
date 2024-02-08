#!/bin/bash

echo "$(date +"%D-T")" >> "/opt/monitoring.txt"
echo "Mem CPU Disk" >> "/opt/monitoring.txt"

for int in {1..720}
do
useMem=$(free | grep "Mem" | awk '{print $3}')
totalMem=$(free | grep "Mem" | awk '{print $2}')
perMem=$(( $useMem * 100 / totalMem ))

notUseD=$(lsblk /dev/sda | grep sda2 | awk '{print $4}')
perD=$(( ${notUseD:0:2} * 100 / 20 ))
usedD=$(( 100-$perD ))

CPUper=$(mpstat | grep "all" | awk '{print $5}')

echo "$perMem       $CPUper     $usedD  " >> "/opt/monitoring.txt"

sleep 5

done