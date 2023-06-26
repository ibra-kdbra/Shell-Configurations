#!/bin/sh

green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

echo "${yellow}==>${reset} nala update..."
sudo nala update 2>&1
echo "${green}==>${reset} apt nala finished."

echo "${yellow}==>${reset} Running full-upgrade..."
sudo nala full-upgrade -y 2>&1
echo "${green}==>${reset} Finished full-upgrade"

echo "${green}==>${reset} Cleaning..."
sudo apt autoclean -y 2>&1
sudo apt autoremove -y 2>&1
echo "${green}==>${reset} All Updates & Cleanups Finished"
