#!/bin/sh
# Description: Simple script to update and upgrade Debian-based systems using nala.
# Author: ibra-kdbra
# Dependencies: nala, tput, sudo

set -e

green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

echo "${yellow}==>${reset} nala update..."
sudo nala update 2>&1
echo "${green}==>${reset} nala update finished."

echo "${yellow}==>${reset} Running full-upgrade..."
sudo nala full-upgrade -y 2>&1
echo "${green}==>${reset} Finished full-upgrade"

echo "${green}==>${reset} Cleaning..."
sudo nala clean -y 2>&1
sudo nala autoremove -y 2>&1
echo "${green}==>${reset} All Updates & Cleanups Finished"

