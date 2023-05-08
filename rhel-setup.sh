#!/bin/bash

# A script to help configure new RHEL devices,
# Author: Robin Cormie
# Website: robincormie.dev
# GitHub repository: https://github.com/rcormie/linux-automation-scripts

# The script uses nmcli, which does not require Network Manager or changes network adapter configuration files
# Make sure to allow the script to be executable with `chmod +x rhel-setup.sh`

# This script is released under the Apache License, Version 2.0
# For more information, see the file LICENSE.txt in the root directory of this repository

network_interface=enp1s0

# Prompt for IP address
read -p "Enter static IP address: " ip_address

# Prompt for netmask
read -p "Enter the netmask in CIDR notation (e.g /24): " netmask

# Prompt for gateway
read -p "Enter the gateway: " gateway

# Prompt for DNS
read -p "Enter the DNS address: " dns1

# Prompt for hostname
read -p "Enter the hostname of this device: " hostname

nmcli con mod enp1s0 ipv4.address "$ip_address""$netmask" ipv4.gateway "$gateway" ipv4.dns "$dns1"
nmcli con mod enp1s0 connection.autoconnect yes
hostnamectl set-hostname "$hostname"

echo "Setting IP address to $ip_address$netmask".
echo "Setting gateway to $gateway".
echo "Setting DNS address to $dns1".
echo "Setting hostname to $hostname".

read -p "Would you like to automatically connect the network interface on boot? (y/n)" connection_autoconnect

# Check if the user wants to autoconnect the network interface on boot
if [ "$connection_autoconnect" == "y" ] || [ "$connection_autoconnect"  == "yes" ]; then
	nmcli con mod "$network_interface" connection.autoconnect yes
	echo "Network interface "$network_interface" will automatically connect on boot."
else
	echo "Network interface "$network_interface" will not automatically connect on boot."
fi

read -p "Do you want to restart the network interface? (y/n)" restart_network

# Check if the user wants to restart the network
if [ "$restart_network" == "y" ] || [ "$restart_network" == "yes" ]; then
	# Bring down the network interface
	echo "Bringing down the network inferface... " "$network_interface"
	nmcli dev disconnect "$network_interface"

	#Bring up the network interface
	echo "Bringing up the network infterface... " "$network_interface"
	nmcli con up id "$network_interface"

	echo "Network restart complete."
else
	echo "Network restart cancelled."
fi

echo "Script completed successfully."

# Replace the current shell process with a new isntance of the Bash shell (loads hostname)
exec bash
