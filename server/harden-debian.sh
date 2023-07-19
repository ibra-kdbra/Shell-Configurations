#!/bin/bash

function setup_user() {
    echo "Enter a username: "
    read username
    echo "Enter your ssh key: "
    read sshKey

    # validate user input
    if [[ -z "$username" || -z "$sshKey" ]]; then
        echo "Username or SSH key cannot be empty"
        exit 1
    fi

    # check if user already exists
    if id "$username" >/dev/null 2>&1; then
        echo "User $username already exists"
        exit 1
    fi

    echo "Creating user $username..."
    sudo useradd -m -s /bin/bash $username
    sudo mkdir -p /home/$username/.ssh
    sudo chown $username:$username /home/$username/.ssh
    sudo chmod 700 /home/$username/.ssh
    echo $sshKey | sudo tee /home/$username/.ssh/authorized_keys
    sudo chown $username:$username /home/$username/.ssh/authorized_keys
    sudo chmod 600 /home/$username/.ssh/authorized_keys
    sudo usermod -aG sudo $username


    echo "Enter the password for the user: "
    sudo passwd $username
    return 0
}

function change_hostname() {
    echo "Changing host name..."
    echo "Enter the new host name: "
    read hostname
    sudo hostnamectl set-hostname $hostname
    echo "127.0.0.1 $hostname" | sudo tee -a /etc/hosts
    return 0
}

function install_docker() {
    echo "Installing docker..."
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl enable docker
    sudo systemctl start docker
    return 0
}

function print_header() {
    echo "This is a Debian server hardening script."
    echo "This script automates various security tasks to enhance the security of your Debian server."
    echo "The script will then proceed to update the system, install basic packages, set up the firewall, configure fail2ban, and harden SSH settings."
    echo
    return 0
}

print_header

# Debian server securization script
echo "Do you want to setup a new user? (y/n)"
read setupUser
if [[ "$setupUser" == "y" ]]; then
    setup_user
fi

echo "Do you want to change the hostname? (y/n)"
read changeHostname
if [[ "$changeHostname" == "y" ]]; then
    change_hostname
fi

echo "Updating system..."
sudo apt update
sudo apt upgrade

echo "Installing basic packages..."
sudo apt -y install ca-certificates curl gnupg git fail2ban ncdu ufw htop

echo "Installing ctop..."
sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -O /usr/local/bin/ctop
sudo chmod +x /usr/local/bin/ctop

# Setup firewall
echo "Setting up firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable

# Setup fail2ban
echo "Setting up fail2ban..."
sudo systemctl enable fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.conf.bak

pub_ip=$(curl https://ipinfo.io/ip 2>> /dev/null) 
sudo sed -ri "/^\[DEFAULT\]$/,/^# JAILS$/ s/^bantime[[:blank:]]*= .*/bantime = 18000/" /etc/fail2ban/jail.local
sudo sed -ri "/^\[DEFAULT\]$/,/^# JAILS$/ s/^backend[[:blank:]]*=.*/backend = polling/" /etc/fail2ban/jail.local
sudo sed -ri "/^\[DEFAULT\]$/,/^# JAILS$/ s/^ignoreip[[:blank:]]*=.*/ignoreip = 127.0.0.1\/8 ::1 ${pub_ip}/" /etc/fail2ban/jail.local

sudo cp /etc/fail2ban/jail.d/defaults-debian.conf /etc/fail2ban/jail.d/defaults-debian.conf.bak

cat <<FAIL2BAN | sudo tee /etc/fail2ban/jail.d/defaults-debian.conf
[sshd]
enabled = true
maxretry = 3
bantime = 2592000

[sshd-ddos]
enabled = true
maxretry = 5
bantime = 2592000

[recidive]
enabled = true
bantime  = 31536000             ; 1 year
findtime = 86400                ; 1 days
maxretry = 10
FAIL2BAN
sudo systemctl restart fail2ban

# Setup SSH
echo "Setting up SSH..."
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
cat <<SSHDCONF | sudo tee /etc/ssh/sshd_config
Port 22
Protocol 2
PermitRootLogin no
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding no
PrintMotd no
AcceptEnv LANG LC_*
AuthorizedKeysFile      \.ssh\/authorized_keys %h\/\.ssh\/authorized_keys
Ciphers aes256-ctr,aes192-ctr,aes128-ctr
KexAlgorithms diffie-hellman-group-exchange-sha256
MaxAuthTries 3
SSHDCONF

sudo systemctl restart sshd

sudo chown root:root /etc/ssh/sshd_config
sudo chmod 600 /etc/ssh/sshd_config

echo "Do you want to install docker? (y/n)"
read installDocker
if [[ "$installDocker" == "y" ]]; then
    install_docker
fi

echo "All done!"