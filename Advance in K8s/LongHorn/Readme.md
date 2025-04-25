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
sudo systemctl enable iscsid
sudo systemctl start iscsid

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

# Trouble_5
[ERROR] cryptsetup is not found in k8s-master-1.

# solution
sudo apt-get install -y  cryptsetup 

```

## Install Helm
``` bash
# install w
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install -y helm

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

# Install longhorn with Helm
``` bash
# add repo
helm repo add longhorn https://charts.longhorn.io

# update
helm repo update

# specific version list
helm search repo repo_name --versions
helm search repo longhorn/longhorn --versions

# specific version install: disable metrics
helm show values longhorn/longhorn --version 1.6.1 > longhorn-values.yaml
helm install longhorn-poc longhorn/longhorn \
  --namespace longhorn-system \
  --version 1.6.1 \
  --create-namespace \
  -f longhorn-values.yaml

# list
helm list -A
helm list -n namespace


# upgrade: enable metrics. before dowland yaml to local machine
helm get values release_name -n longhorn-system --output yaml
helm get values longhorn-poc  -n longhorn-system --output yaml
helm get values longhorn-poc  -n longhorn-system --output yaml > longhorn-current-values.yaml
---
helm get manifest longhorn-poc  -n longhorn-system > longhorn-manifest.yaml
---
helm get values longhorn-poc  -n longhorn-system > longhorn-values-backup.yaml
helm get values longhorn-poc  -n longhorn-system --all > longhorn-values-complete.yaml
helm upgrade --install longhorn-poc longhorn/longhorn --namespace longhorn-system -f longhorn-values-complete.yaml
helm get values longhorn-poc  -n longhorn-system --output yaml > longhorn-values-backup.yaml
---
# Nope
helm upgrade longhorn-poc  longhorn/longhorn \
  --namespace longhorn-system \
  --set manager.service.ports.metrics=9500
helm upgrade longhorn-poc  longhorn/longhorn \
  --namespace longhorn-system \
  --set defaultSettings.telemetry.enableMetric=true \
  --set manager.service.ports.metrics=9500

# upgrade
helm upgrade longhorn-poc longhorn/longhorn \
  -f longhorn-values.yaml

# install
helm install longhorn-poc longhorn/longhorn \
  --namespace longhorn-system \
  --create-namespace

# deploy pods
kubectl apply -f test-pvc.yaml
kubectl apply -f test-pvc-1.yaml

# pod size
kubectl exec -it volume-test -- sh
dd if=/dev/zero of=/data/testfile bs=1M count=100

# rollback
helm rollback longhorn-poc -n longhorn-system
```


## Integration and Implementation Prometheus-Stack
``` bash
# Check metrics
cat longhorn-values-complete.yaml

# Check metrics
curl http://pods_name:ports_number/metrics
curl http://192.168.1.7:32322/metrics

# actual metrics
longhorn_volume_actual_size_bytes

# creating: headliness service. There is a longhorn-metrics on longhorn-system ns
kubectl apply -f longhorn-metrics-service.yaml

# creating pod monitor
kubectl apply -f longhorn-podmonitor.yaml


```


## useful
``` bash
kubectl get settings -n longhorn-system



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

