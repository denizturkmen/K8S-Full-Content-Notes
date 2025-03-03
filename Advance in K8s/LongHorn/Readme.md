# The Longhorm Installation and Configuration in Kubernetes


## Installation Requirements
``` bash
# Using the Environment Check Script
curl -sSfL https://raw.githubusercontent.com/longhorn/longhorn/v1.8.0/scripts/environment_check.sh | bash

# Trouble_1


# Trouble_2
# Trouble_3

```

## Install
``` bash
# dowland via wget: latest
wget https://github.com/longhorn/longhorn/releases/download/v1.6.1/longhorn.yaml

# Install
kubectl apply -f longhorn.yaml

# view
kubectl get all -n longhorn-system

# stable: v1.7.3
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.7.3/deploy/longhorn.yaml

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

