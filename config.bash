# Change default password for root and default user
# Default passwords are "orangepi"
sudo passwd root
sudo passwd orangepi

# Update packages
sudo apt update
sudo apt upgrade -y
sudo apt autoremove
sudo apt clean
sudo reboot

# SSH in as orangepi user, then configure SSH and add public key for remote
ssh orangepi@192.168.1.128
mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
