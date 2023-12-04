#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu
sudo apt install npm -y

sudo docker pull ayodev581/website:latest
sudo docker run -d -p 80:80 ayodev581/website:latest
