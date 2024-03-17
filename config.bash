# After flashing Debian 3.1.0 and connecting with ethernet, SSH in as default user "orangepi"
ssh orangepi@orangepizero2

# Change default password for root and default user
# Default passwords are "orangepi"
sudo passwd root
sudo passwd orangepi

# Update hostname
sudo nano /etc/hostname # Update hostname from "orangepizero2" to new
sudo nano /etc/hosts # Update hostname in L2/3 from "orangepizero2" to new
sudo systemctl restart systemd-hostnamed

# Configure SSH and add public key for remote
mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
nano ~/.ssh/authorized_keys

# Update packages
sudo apt update
sudo apt upgrade -y
sudo apt autoremove
sudo apt clean

# Connect to WiFi
# sudo iwlist wlan0 scan | grep ESSID
sudo nmcli device wifi connect ATTRufwJsA password <WiFi_Password>
sudo reboot

# Install latest version of Node Version Manager (NVM) from https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
sudo reboot

# Confirm that NVM installed successfully
nvm -v

# Install and select v20.11.1
nvm install v20.11.1
nvm use v20.11.1

# Install Plexamp Headless - CHOOSE LATEST VERSION instead of 4.10.0
curl https://plexamp.plex.tv/headless/Plexamp-Linux-headless-v4.10.0.tar.bz2 > plexamp.tar.bz2
tar -xvf plexamp.tar.bz2

# Start Plexamp and enter claim token from https://plex.tv/claim
node ~/plexamp/js/index.js

# Check hostname and restart Plexamp, then log in at x.x.x.x:32500
hostname -I
node ~/plexamp/js/index.js

# Configure plexamp.service to refer to custom username and node version
nano ~/plexamp/plexamp.service

# [Unit]
# Description=Plexamp
# After=network-online.target
# Requires=network-online.target

# [Service]
# Type=simple
# User=orangepi
# WorkingDirectory=/home/orangepi/plexamp
# ExecStart=/home/orangepi/.nvm/versions/node/v20.11.1/bin/node /home/orangepi/plexamp/js/index.js
# Restart=on-failure

# [Install]
# WantedBy=multi-user.target


# Configure Plexamp to start automatically
cd ~/plexamp
sudo cp plexamp.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable plexamp
sudo systemctl start plexamp

# After testing SSH with key, remove SSH password access
sudo nano /etc/ssh/sshd_config # Change "PasswordAuthentication" to no
sudo systemctl restart sshd