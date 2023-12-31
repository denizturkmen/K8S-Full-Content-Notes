# Harbor Registry Install Guide



Disk create and setting on ubuntu
``` bash
lsblk
sudo parted -s -a optimal -- /dev/sdc mklabel gpt
sudo parted -s -a optimal -- /dev/sdc  mkpart primary 0% 100%
sudo parted -s -- /dev/sdc  align-check optimal 1
sudo pvcreate /dev/sdc1
sudo vgcreate vg0 /dev/sdc1
sudo lvcreate -n harbor -l +100%FREE vg0
sudo mkfs.xfs /dev/vg0/harbor
sudo mkdir /data
sudo echo "/dev/vg0/harbor /data xfs defaults 0 0" | sudo tee -a /etc/fstab
---

sudo mount -a
df -hT /data/

```


Docker and Docker-compose Install
``` bash
# Docker
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
---
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
---
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
---
sudo apt-cache madison docker-ce | awk '{ print $3 }'
VERSION_STRING=5:20.10.24~3-0~ubuntu-focal
sudo apt-get install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin

# Docker-Compose Install
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

```


Harbor Install with docker
``` bash
# dowland
curl -s https://api.github.com/repos/goharbor/harbor/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep '\.tgz$' | wget -i -

# opening tar
tar xvzf harbor-online-installer-v2.10.0.tgz

# configutartion to harbor.yml
cp harbor.yml.tmpl harbor.yml

# install
sudo ./install.sh 

# adding /etc/host to domain
sudo vim /etc/hosts
  harbor.devops-deniz.net

```

Admin user create on the harbor ui
``` bash
# go to user lett menü after click set-up admin

# dowland image
docker image pulll nginx

# docker image tag 
docker image tag nginx:latest harbor.devops-deniz.net/test/nginx:v1

# docker login
docker login hostname
docker login harbor.devops-deniz.net
  username: denizturkmen
  password: Q1w2e3r4*


```

New project create
``` bash
# go to new project
# private
# looked docker image tag and push command

```

Integration trivy. Trivy is image scan tool
``` bash
# install
sudo ./install.sh --with-trivy

```






# Referance
```
https://computingforgeeks.com/install-harbor-registry-centos-debian-ubuntu/
Install: https://goharbor.io/docs/2.0.0/install-config/download-installer/
Github: https://github.com/goharbor/harbor
Trivy: https://goharbor.io/docs/2.1.0/install-config/run-installer-script/

```