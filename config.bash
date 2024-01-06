# After flashing Debian, SSH in as orangepi user
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

# After testing SSH with key, remove SSH password access
sudo nano /etc/ssh/sshd_config # Change "PasswordAuthentication" to no
sudo systemctl restart sshd

# Update packages
sudo apt update
sudo apt upgrade -y
sudo apt autoremove
sudo apt clean
sudo reboot

# Install Node.js
sudo apt-get install -y ca-certificates curl gnupg && sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=16
echo deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update && sudo apt-get install -y nodejs


# Check Node.js version to ensure v16.x.x
node -v

# If Node.js is not v16.x.x, proceed to install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
sudo reboot

# Confirm that NVM installed successfully
nvm -v

# Install and select v16.20.2
nvm install v16.20.2
nvm use v16.20.2

# Install Plexamp Headless - CHOOSE LATEST VERSION instead of 4.9.4
curl https://plexamp.plex.tv/headless/Plexamp-Linux-headless-v4.9.4.tar.bz2 > plexamp.tar.bz2
tar -xvf plexamp.tar.bz2

# Start Plexamp and enter claim token from https://plex.tv/claim
node plexamp/js/index.js

# Check hostname and restart Plexamp, then log in at x.x.x.x:32500
hostname -I
node plexamp/js/index.js

# Configure plexamp.service to refer to custom username and node verion
nano plexamp/plexamp.service

# [Unit]
# Description=Plexamp
# After=network-online.target
# Requires=network-online.target

# [Service]
# Type=simple
# User=orangepi
# WorkingDirectory=/home/orangepi/plexamp
# ExecStart=/home/orangepi/.nvm/versions/node/v16.20.2/bin/node /home/orangepi/plexamp/js/index.js
# Restart=on-failure

# [Install]
# WantedBy=multi-user.target


# Configure Plexamp to start automatically
cd plexamp
sudo cp plexamp.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable plexamp
sudo systemctl start plexamp