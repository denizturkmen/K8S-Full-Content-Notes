# Master and Worker Node Upgraded

First, master and worker node check version.
``` bash
# Check version
kubectl get nodes -owide

```

**Control plane** upgrade using kubeadm
``` bash
# Unhold
apt-mark unhold kubeadm 

# Upgrade
apt-get update && apt-get install -y kubeadm=version
apt-get update && apt-get install -y kubeadm=1.28.1-00

# Hold
apt-mark hold kubeadm

# Verify version
kubeadm version

# Verify the upgrade plan
kubeadm upgrade plan

# Apply version upgrade
kubeadm upgrade apply version
kubeadm upgrade apply v1.28.1

```

Kubectl and kubelet upgrade on **master node**
``` bash
# Drain node
kubectl drain node_name --ignore-daemonsets --force
kubectl drain controlplane --ignore-daemonsets --force

# Upgrade kubelet and kubect
# Unhold
apt-mark unhold kubelet kubectl 

# Upgrade
apt-get update && apt-get install -y kubelet=1.28.1-00 kubectl=1.28.1-00

# Hold
apt-mark hold kubelet kubectl

# Restart daemon and kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# Check node
kubectl get nodes -owide

# Uncordon master node
kubectl uncordon <node-to-uncordon>
kubectl uncordon controlplane

```

Upgrade worker nodes
``` bash
# ssh 
ssh node01

# Upgrade kubeadm
#  hold
apt-mark unhold kubeadm 

# Update kubeadm
apt-get update && apt-get install -y kubeadm=1.28.1-00

# hold
apt-mark hold kubeadm

# for worker node upgrade 
sudo kubeadm upgrade node

# drain node on controlplane
kubectl drain <node-to-drain> --ignore-daemonsets
kubectl drain node01 --ignore-daemonsets

```

Upgrade kubelet and kubectl on worker-node
``` bash
# Unhold
apt-mark unhold kubelet kubectl 

# Upgrade
apt-get update && apt-get install -y kubelet=1.28.1-00 kubectl=1.28.1-00

# Hold
apt-mark hold kubelet kubectl

# Restart daemon and kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# Uncordon worker node on CONTROLPLANE
kubectl uncordon <node-to-uncordon>
kubectl uncordon controlplane

```

