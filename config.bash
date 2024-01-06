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