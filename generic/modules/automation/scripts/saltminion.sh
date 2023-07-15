#!/bin/bash

masterIP="master-ip-goes-here"

# update, clean, upgrade
sudo apt-get update ; sudo apt-get clean ; sudo apt-get upgrade -y

# install python3
sudo apt-get install python3 -y

# install salt-minion
sudo apt-get install salt-minion -y

# add ssh key
sudo mkdir -p /root/.ssh

sudo echo "public-key-goes-here" > /root/.ssh/authorized_keys

# restart ssh
sudo systemctl ssh restart

# backup the salt-minion config
sudo mv /etc/salt/minion /etc/salt/minion.bak

# create the salt-minion config
sudo echo "master: $masterIP" > /etc/salt/minion

# echo short hostname to /etc/salt/minion_id
sudo hostname | cut -d "." -f 1 > /etc/salt/minion_id

# enable and restart salt-master
sudo systemctl enable salt-minion ; sudo systemctl restart salt-minion
