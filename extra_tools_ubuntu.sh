#!/bin/bash
sudo apt update 
sudo apt upgrade -y
sudo apt install ubuntu-restricted-extras -y
sudo apt install net-tools -y
sudo apt install nmap -y
wget https://raw.githubusercontent.com/LionSec/katoolin/master/katoolin.py
sudo mv katoolin.py /usr/bin/katoolin
sudo chmod +x /usr/bin/katoolin
