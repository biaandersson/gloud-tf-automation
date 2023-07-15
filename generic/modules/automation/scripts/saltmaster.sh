#!/bin/bash

# update, clean, upgrade
sudo apt-get update ; sudo apt-get clean ; sudo apt-get upgrade -y

# install python3
sudo apt-get install python3 -y

# install salt-master
sudo apt-get install salt-master -y

# add ssh key
sudo mkdir -p /root/.ssh

sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/TB/1qVDU0TB1AskDRHPIiFWkD8irkT2i7OGVEVUNL0OAJO3yVjmJvQgbpb5mEGoTXyXD2iq6lLFcULbUabutce0+Qdw4LOiIgc7JVpgtXSOXY5VfNd0x5Kv8QiCkMAFmIJY5PWOtYxIPyQX7FZ6doM1aEgVOup4L9Gc9rZj7Q7hsQOlUa44fjJvE7yIJjqAFFZeV/OsjikD02/YhaJf82t5YNe6730zrl4DR7oYsFFjrQ6UdC/kxvLJBQ1SGXLsOOxrdl+8otQj9AeXHaqxv+4MqQgyJx51Vt9YdJvxJmb+AydVQvBU2mOvxJfK907LBh59CTXqUwEZoGsJiztzwKLkYXIU0J2OqOi6vskNwJMIs2j2uMSbNBkT1UfIEJNk42MkOihcFeIdo9/OHNJGiDdAyys9rLaawVJ8hQIA1Mcw8+JEJYQpfnn/fnZeiSJhHhlUsKAomNmDlV9qWsny1sG+ixtpSOVU9PfuJ+0JvI0agVAwloPeBwxIQ2WjH+iPk4eFUUc1xhMxXoX/Rg3K1ZsUW1vxBDUWxr4D4LQvGQ5HP3320z5tl8dyAFd79QOCNKFG9vtoGcI1MXZioco4FSx9F8f/46x+AnCjwIQo7YfXydH0HZ1SS3Gy3aaMoF0GWn57nOKMGbqJWZmgJV/ZPROXFlOAPXyCioyMRP1vazw== tobias.andersson@X6NPK97HN2.local
" > /root/.ssh/authorized_keys

# create the salt-deploy key
echo "-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAaAAAABNlY2RzYS
1zaGEyLW5pc3RwMjU2AAAACG5pc3RwMjU2AAAAQQR+WRe7xDppP6QSw7U2EV5C3ciduXJd
E7vAEainl6sQZvwWhgBpnkp7ju2pc0aIDwIZYqB7vcp1IuOVjFrflXm4AAAAwNKcG3PSnB
tzAAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBH5ZF7vEOmk/pBLD
tTYRXkLdyJ25cl0Tu8ARqKeXqxBm/BaGAGmeSnuO7alzRogPAhlioHu9ynUi45WMWt+Veb
gAAAAgE/I1nAVO6iOAN+NV/qEj+ax/rXJbgjjE/Y8gs3YMJzkAAAAhdG9iaWFzLmFuZGVy
c3NvbkBYNk5QSzk3SE4yLmxvY2FsAQIDBAUGBw==
-----END OPENSSH PRIVATE KEY-----" > /root/.ssh/salt-deploy

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

# cd /srv/
cd /srv 

#  clone the repo
git clone git@github.com:biaandersson/saltstack.git
