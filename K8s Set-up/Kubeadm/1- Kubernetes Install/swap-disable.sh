!#/bin/bash

sudo sed -i '/ swap / s/^/#/' /etc/fstab
sudo mount -a
free -h