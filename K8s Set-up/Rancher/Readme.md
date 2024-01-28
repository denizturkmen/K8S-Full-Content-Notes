# Rancher Install and Configure

Installing docker on ubuntu with script
``` bash
# Install
sudo su -
curl https://raw.githubusercontent.com/denizturkmen/Docker-Full-Content-Notes/main/Installing%20useful%20tools/Sonarqube/1-%20Install/docker-install.sh | bash

```

Installing docker-compose on ubuntu with script
``` bash
# Install
sudo su -
curl https://raw.githubusercontent.com/denizturkmen/Docker-Full-Content-Notes/main/Installing%20useful%20tools/Sonarqube/1-%20Install/docker-compose-install.sh | bash

```

Run Docker Without sudo
``` bash
# create docker group
sudo groupadd docker

# add docker user to docker group
sudo usermod -aG docker $USER

# add docker group
newgrp docker

# run docker without sudo
docker ps
```

Rancher install via docker command
``` bash
# pull image
docker pull rancher/rancher:latest

# install
docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  --privileged \
  rancher/rancher:latest

# log
docker logs -f containerid

# secret password
docker logs container_id  2>&1 | grep "Bootstrap Password:"

```

On-prem cluster import and configure
``` bash
# all k8s object
kubectl get all -n cattle-system 

# Import Cluster with secure
kubectl apply -f https://192.168.1.7/v3/import/6b7d4vwhhkfxb9rdzv97xxjfblm68dhgksdxptg7x6vldn772v6dfg_c-m-dmm5h68x.yaml

# Import Cluster with non-secure
curl --insecure -sfL https://192.168.1.7/v3/import/6b7d4vwhhkfxb9rdzv97xxjfblm68dhgksdxptg7x6vldn772v6dfg_c-m-dmm5h68x.yaml | kubectl apply -f -

```








# Referance
``` bash
https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/other-installation-methods/rancher-on-a-single-node-with-docker


```