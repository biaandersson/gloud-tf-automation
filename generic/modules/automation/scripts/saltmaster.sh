#!/bin/bash

# update, clean, upgrade
sudo apt-get update ; sudo apt-get clean ; sudo apt-get upgrade -y

# install python3
sudo apt-get install python3 -y

# install salt-master
sudo apt-get install salt-master -y

# add ssh key
sudo mkdir -p /root/.ssh

sudo echo "public-key-goes-here" > /root/.ssh/authorized_keys

# create the salt-deploy key
echo "key-goes-here" > /root/.ssh/salt-deploy

# change the permissions
sudo chmod 600 /root/.ssh/authorized_keys ; sudo chmod 600 /root/.ssh/salt-deploy

# restart ssh
sudo systemctl ssh restart

# mv the salt master config
sudo mv /etc/salt/master /etc/salt/master.bak

# create the new salt master config
sudo echo "interface: 0.0.0.0

file_roots:
  base:
    - /srv/saltstack/salt
    - /srv/saltstack/formulas

pillar_roots:
  base:
    - /srv/saltstack/pillar

log_level: warning
auto_accept: True

jinja_env:
  trim_blocks: True
  lstrip_blocks: True" > /etc/salt/master

# enable and restart salt-master
sudo systemctl enable salt-master ; sudo systemctl restart salt-master

# create the config in .ssh/config
sudo echo "Host github.com
  HostName github.com
  User git
  IdentityFile /root/.ssh/salt-deploy
  IdentitiesOnly yes" > /root/.ssh/config

# add the /etc/environment file
echo "GIT_SSH_COMMAND='ssh -i /root/.ssh/salt-deploy -o IdentitiesOnly=yes'" > /etc/environment

# clone the saltstack repo
cd /srv ; git clone git@github.com:biaandersson/saltstack.git
