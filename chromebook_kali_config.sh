#!/bin/bash

### Elevate privileges with su to avoid installation errors ###

### Update repository sources
echo " "
echo "Updating repository sources..."
echo " "

# Path to the sources.list file
sources_list="/etc/apt/sources.list"

# Create a temporary file
temp_file=$(mktemp)

# Prepend '#' to each line and append new lines
{
    cat "$sources_list" | sed 's/^/#/'; 
    echo " ";
    echo "# Updating repository sources...";
    echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware";
	echo " ";
	echo "# Additional line for source packages";
	echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware";
} > "$temp_file"

# Update sources file & verify correctly done
cat $temp_file
sudo cat $temp_file > $sources_list
echo " "
echo "Source update complete!"

sleep 5

### Download gpg key, update system & install base system requirements.
echo " "
echo "Downloading Kali GPG key..."
echo " "
sudo wget https://archive.kali.org/archive-key.asc -O /etc/apt/trusted.gpg.d/kali-archive-keyring.asc

sleep 2

echo " "
echo "Updating system..."
echo " "
sudo apt update -y && sudo apt full-upgrade -y 

sleep 1.5

echo " "
echo "Installing base system requirements..."
echo " "
sudo apt install configure-debian dialog whiptail tasksel command-not-found bash-completion zsh-autosuggestions -y
sudo apt install kali-defaults -y
sudo apt install kali-desktop-xfce -y
sudo apt install synaptic -y
sudo apt install xserver-xephyr -y

sleep 30

### Create /usr/bin/gox file (replace 'username' with your actual username).
echo " "
echo "Creating /usr/bin/gox..."
sudo tee /usr/bin/kld > /dev/null << 'EOF'
Xephyr -br -fullscreen -resizeable :20 &
sleep 1
sudo -u username DISPLAY=:20 startxfce4 &> /dev/null &
EOF

sleep 1.5

### Create /usr/bin/gox_launch file.
echo " "
echo "Creating /usr/bin/gox_launch..."
sudo tee /usr/bin/kld_launch > /dev/null << 'EOF'
xhost + &&
sudo synaptic &&
xhost -
EOF

sleep 2

### Make /usr/bin/gox & /usr/bin/gox_launch files executable.
echo " "
echo "Making /usr/bin/gox & /usr/bin/gox_launch executable..."
echo " "
sudo chmod +x /usr/bin/gox /usr/bin/gox_launch

sleep 2

### Set 'xgo' command for shutting down the Kali Xfce4 Desktop.
echo " "
echo "Setting 'xgo' command for shutting down the Kali Xfce4 Desktop..."
sudo echo " " >> ~/.bashrc 
sudo echo "alias xgo='killall Xephyr'" >> ~/.bashrc 

sleep 5

### Install Kali base system utilities.
echo " "
echo "Installing Kali base system utilities..."
echo " "
sudo apt -y install tor traceroute xdotool iputils-ping
sudo apt install kali-tools-crypto-stego -y
sudo apt install kali-tools-database -y
sudo apt install kali-tools-vulnerability -y
sudo apt install kali-tools-web -y
sudo apt install kali-tools-exploitation -y
sudo apt install kali-tools-information-gathering -y
sudo apt install kali-tools-passwords -y
sudo apt install kali-tools-post-exploitation -y
sudo apt install kali-tools-sniffing-spoofing -y
sudo apt install kali-tools-social-engineering -y
sudo apt install kali-tools-reverse-engineering -y

sleep 1

### Install useful linux packages.
echo " "
echo "Installing useful linux packages..."
echo " "
sudo apt -y install nano curl pip tree cmatrix fping net-tools qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon ovmf build-essential libncurses-dev bison flex libssl-dev libelf-dev dirmngr gnupg gnupg2 apt-transport-https libosinfo-bin libguestfs-tools cockpit cockpit-machines samba vde2 imvirt imvirt-helper imvirt-helper xclip xsel uuid oz hping3 macchanger

sleep 1

echo " "
echo "Making /usr/bin/kld & /usr/bin/kld_launch executable..."
echo " "

sleep 2

### Update & upgrade the system.
echo " "
echo "Making /usr/bin/kld & /usr/bin/kld_launch executable..."
echo " "
sudo apt update
sudo apt upgrade -y

sleep 10 

echo " "
echo "Kali linux base system setup complete successfully!"
sleep 1
echo " "
echo "Terminating script is (5) seconds."
sleep 1
echo "Terminating script is (4) seconds."
sleep 1
echo "Terminating script is (3) seconds."
sleep 1
echo "Terminating script is (2) seconds."
sleep 1
echo "Terminating script is (1) seconds."
sleep 1
echo " "
echo "Script terminated! Shutdown linux and reset Chromebook!"
exit

### KALI BASE SYSTEM SETUP COMPLETE! ### 
