#!/bin/bash

# A script to help configure docker on linux. The script gives the currently logged in user ability to manager docker (as non root).
# Author: Robin Cormie
# Website: robincormie.dev
# GitHub repository: https://github.com/rcormie/linux-automation-scripts

# Step 1: Install Required Dependencies
sudo yum install -y yum-utils

# Step 2: Add the Docker Repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Step 3: Install Docker Engine
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Step 4: Start and Verify Docker Installation
sudo systemctl start docker
sudo docker run hello-world

# Step 5: Enable Docker Service at Boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Step 6: Manage Docker as a Non-Root User
sudo groupadd docker
sudo usermod -aG docker $USER
#sudo reboot -h now
docker run hello-world
