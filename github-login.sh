#!/bin/bash

# Author: Robin Cormie
# Website: robincormie.dev
# GitHub repository: https://github.com/rcormie/linux-automation-scripts
# This script configures Git on a Linux system and login to GitHub using their GitHub account.

# This script is released under the Apache License, Version 2.0
# For more information, see the file LICENSE.txt in the root directory of this repository

read -p "Enter your github email address: " email_address
read -p "Enter your github username: " user_name

git config --global user.email "$email_address"
git config --global user.name "$user_name"

git config --global --list

read -p "Enter the name of the SSH private key (located in ~/.ssh): " ssh_key

mkdir ~/.ssh
touch ~/.ssh/known_hosts

chmod 600 ~/.ssh/"$ssh_key"

ssh -T git@github.com

