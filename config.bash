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