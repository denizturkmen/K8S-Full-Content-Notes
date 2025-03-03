# The Longhorm Installation and Configuration in Kubernetes


## Installation Requirements
``` bash
# Using the Environment Check Script
curl -sSfL https://raw.githubusercontent.com/longhorn/longhorn/v1.8.0/scripts/environment_check.sh | bash

# Trouble_1
[ERROR] Not found: jq
[INFO]  Please install missing dependencies: kubectl jq mktemp sort printf.

# solution
sudo apt install -y jq

# Trouble_2
[ERROR] Neither iscsid.service nor iscsid.socket is running on k8s-master-1

# solution
sudo apt-get install -y open-iscsi

# Trouble_3
[ERROR] kernel module iscsi_tcp is not enabled on k8s-master-1

# solution
lsmod|grep iscsi
sudo modprobe iscsi_tcp
lsmod|grep iscsi

# Trouble_4
[ERROR] nfs-common is not found in k8s-master-1.

# solution
sudo apt install -y nfs-common

```

## Install
``` bash
# dowland via wget: latest
wget https://github.com/longhorn/longhorn/releases/download/v1.8.0/longhorn.yaml

# Install
kubectl apply -f longhorn.yaml

# view
kubectl get all -n longhorn-system

# stable: v1.7.3
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.7.3/deploy/longhorn.yaml

# longhorn-iscsi
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.7.3/deploy/prerequisite/longhorn-iscsi-installation.yaml
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.8.0/deploy/prerequisite/longhorn-iscsi-installation.yaml

```


## NFS Enable RWX
``` bash
# NFS package to enable the creation of ReadWriteMany (RWX) volumes in your cluster
# Dowland
wget https://raw.githubusercontent.com/longhorn/longhorn/v1.7.3/deploy/prerequisite/longhorn-nfs-installation.yaml

# Install
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.7.3/deploy/prerequisite/longhorn-nfs-installation.yaml

# verify
kubectl get pods | grep longhorn-nfs-installation

```


## Create a Longhorn Storage Class
``` bash
# Creating: ReadWriteOnly (RWO) StorageClass



```


## Referance
``` bash
https://github.com/longhorn/longhorn/


```

