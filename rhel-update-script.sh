#!/bin/bash

# RHEL update script
# Author: Robin Cormie
# Website: robincormie.dev
# GitHub repository: https://github.com/rcormie/linux-automation-scripts

# This script will update the system by installing available updates.
# The user will be prompted to confirm the update before it is installed.

# This script is released under the Apache License, Version 2.0
# For more information, see the file LICENSE.txt in the root directory of this repository

# Set the log file path
LOG_FILE=/var/log/update_script.log

# Prompt the user to confirm the update
read -p "Are you sure you want to update the system? [y/n] " answer

# If the user does not confirm the update, exit the script
if [[ "$answer" != "y" ]]; then
  echo "Update cancelled."
  exit 1
fi

# Update the system using the package manager
sudo yum update -y >> $LOG_FILE 2>&1

# Check if the update was successful
if [[ $? -eq 0 ]]; then
  echo "System updated successfully." | tee -a $LOG_FILE
else
  echo "Error: Update failed." | tee -a $LOG_FILE
  exit 1
fi

# Check if a reboot is required
if [[ -f /var/run/reboot-required ]]; then
  echo "Reboot required. Automatically rebooting in 5 minutes..." | tee -a $LOG_FILE
  sleep 300
  sudo reboot
fi
