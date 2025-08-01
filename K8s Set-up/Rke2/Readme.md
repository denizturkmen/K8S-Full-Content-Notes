# Install and configure Kubernetes with RKE2


## Turn-off Swap on all Nodes
``` bash
# Swap off
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

# Permanently: swapfile -> adding in front of swapfile #
sudo vim /etc/fstab

# Require package
sudo apt update && sudo apt install -y curl wget gnupg lsb-release

# Firewall (optional)
sudo ufw disable

# Confirm setting is correct
sudo mount -a
free -h

```

## Install Master Node
``` bash
# install
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_TYPE="server" sh -

# Starting service
sudo systemctl enable rke2-server.service
sudo systemctl start rke2-server.service

# logs
journalctl -u rke2-server -f

# copy kubeconfig
mkdir -p $HOME/.kube
sudo cp /etc/rancher/rke2/rke2.yaml $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Get tokens for worker node
sudo cat /var/lib/rancher/rke2/server/node-token

```

## Install Worker-Nod
``` bash
# install
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_TYPE="agent" sh -

# Preparing config file
# Creating file
sudo mkdir -p /etc/rancher/rke2

# config file: template
sudo tee /etc/rancher/rke2/config.yaml > /dev/null <<EOF
server: https://master_IP:Port
token: Node Token
EOF

# apply
sudo tee /etc/rancher/rke2/config.yaml > /dev/null <<EOF
server: https://192.168.1.41:9345
token: K108da33a869404acbebdf016194560bc399ee98866f311b38d6a39aeb9c02be986::server:c914c6ece114979d54f8570ca29efa92
EOF

# Starting Service
sudo systemctl enable rke2-agent.service
sudo systemctl start rke2-agent.service

# logs
journalctl -u rke2-server -f

```

## Install Kubectl
``` bash
# update
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

# dowland
curl -LO https://dl.k8s.io/release/v1.33.0/bin/linux/amd64/kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# validate
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# install
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl

# check
kubectl version

```

## Install Containerd
``` bash
# Install required packages
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

# Add Docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install containerd
sudo apt update
sudo apt install -y containerd.io

# Configure containerd and start service
sudo su -
mkdir -p /etc/containerd
containerd config default>/etc/containerd/config.toml

# restart containerd
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl status containerd


# To use the systemd cgroup driver, set plugins.cri.systemd_cgroup = true 
cat /etc/containerd/config.toml | grep SystemdCgroup
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

```

## 
``` bash


```


## Referance
``` bash
https://docs.rke2.io/install/quickstart


```
