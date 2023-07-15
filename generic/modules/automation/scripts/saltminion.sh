#!/bin/bash

masterIP="34.88.12.192"

# update, clean, upgrade
sudo apt-get update ; sudo apt-get clean ; sudo apt-get upgrade -y

# install python3
sudo apt-get install python3 -y

# install salt-minion
sudo apt-get install salt-minon -y

# add ssh key
sudo mkdir -p /root/.ssh

sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/TB/1qVDU0TB1AskDRHPIiFWkD8irkT2i7OGVEVUNL0OAJO3yVjmJvQgbpb5mEGoTXyXD2iq6lLFcULbUabutce0+Qdw4LOiIgc7JVpgtXSOXY5VfNd0x5Kv8QiCkMAFmIJY5PWOtYxIPyQX7FZ6doM1aEgVOup4L9Gc9rZj7Q7hsQOlUa44fjJvE7yIJjqAFFZeV/OsjikD02/YhaJf82t5YNe6730zrl4DR7oYsFFjrQ6UdC/kxvLJBQ1SGXLsOOxrdl+8otQj9AeXHaqxv+4MqQgyJx51Vt9YdJvxJmb+AydVQvBU2mOvxJfK907LBh59CTXqUwEZoGsJiztzwKLkYXIU0J2OqOi6vskNwJMIs2j2uMSbNBkT1UfIEJNk42MkOihcFeIdo9/OHNJGiDdAyys9rLaawVJ8hQIA1Mcw8+JEJYQpfnn/fnZeiSJhHhlUsKAomNmDlV9qWsny1sG+ixtpSOVU9PfuJ+0JvI0agVAwloPeBwxIQ2WjH+iPk4eFUUc1xhMxXoX/Rg3K1ZsUW1vxBDUWxr4D4LQvGQ5HP3320z5tl8dyAFd79QOCNKFG9vtoGcI1MXZioco4FSx9F8f/46x+AnCjwIQo7YfXydH0HZ1SS3Gy3aaMoF0GWn57nOKMGbqJWZmgJV/ZPROXFlOAPXyCioyMRP1vazw== tobias.andersson@X6NPK97HN2.local
" > /root/.ssh/authorized_keys

# restart ssh
sudo systemctl ssh restart

# backup the salt-minion config
sudo mv /etc/salt/minion /etc/salt/minion.bak

# create the salt-minion config
sudo echo "master: $masterIP" > /etc/salt/minion

# enable and restart salt-master
sudo systemctl enable salt-minion ; sudo systemctl restart salt-minion
