!#/bin/bash

sudo swapoff -a 
sudo sed -i '/ swap / s/^/#/' /etc/fstab
sudo mount -a
free -h