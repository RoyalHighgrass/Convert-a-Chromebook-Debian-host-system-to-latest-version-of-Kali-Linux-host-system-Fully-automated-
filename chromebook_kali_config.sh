#!/bin/bash

### Elevate privileges with 'sudo su' to avoid installation errors ###

# Get username
read -p "Enter your username: " get_new_username_input

# Get the output of lsb_release -a
lsb_output=$(lsb_release -a)

# Extract the required fields
distributor_id=$(echo "$lsb_output" | grep "Distributor ID:")
release=$(echo "$lsb_output" | grep "Release:")

# Construct the desired output
hs="$distributor_id-$release"

### Update repository sources
echo " "
echo "Convert repository sources from $hs to Kali linux (kali-rolling)..."
echo " "

# Path to the sources.list file
sources_list="/etc/apt/sources.list"

# Create a temporary file
temp_file=$(mktemp)

# Prepend '#' to each line and append new lines
{
    cat "$sources_list" | sed 's/^/#/'; 
    echo " ";
    echo "# Convert repository sources from $hs to Kali linux (kali-rolling)...";
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

### Create /usr/bin/gox file ('$get_new_usrname_input' automatically replaced with username provided at the start).
echo " "
echo "Creating /usr/bin/gox..."
sudo tee /usr/bin/kld > /dev/null << 'EOF'
if ! pgrep -x "zsh" > /dev/null; then
    Xephyr -br -fullscreen -resizeable :20 &
    sleep 1
    sudo -u $get_new_username_input DISPLAY=:20 startxfce4 &> /dev/null &
else
    echo " "
    echo "Terminate 'zsh' process to launch Kali Linux desktop!"
fi
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
#sudo echo "gox" >> ~/.bashrc 

sleep 2

### Set  'xgo' command for shutting down the Kali Xfce4 Desktop.
echo " "
echo "Setting 'xgo' command for shutting down the Kali Xfce4 Desktop..."
sudo echo " " >> ~/.bashrc 
sudo echo "alias xgo='killall Xephyr'" >> ~/.bashrc
sudo echo " " >> ~/.zshrc 
sudo echo "alias xgo='killall Xephyr'" >> ~/.zshrc

sleep 5

### Install Kali base system utilities.
echo " "
echo "Installing Kali base system utilities...(this may likely take a while)..."
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

sleep 2

### Update & upgrade the system.
echo " "
echo "Updating & upgrading the system..."
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
