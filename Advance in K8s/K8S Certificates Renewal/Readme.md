# How to k8s certificate upgrade

Firstly, Checking our cluster
``` bash
# list of Node
kubectl get nodes

# command to look at list of k8s objects
kubectl get all -A

```

To look at the expiry date of the certificates
``` bash
# Expiration
sudo kubeadm certs check-expiration

# Config Manifest
kubectl -n kube-system get cm kubeadm-config -o yaml

```

Let's back up config file
``` bash
# Create directory
mkdir -p backup_config

# Backup
sudo cp -r /etc/kubernetes/*.conf /home/k8s1/backup_config/k8sconf
sudo cp -r /etc/kubernetes/pki /home/k8s1/backup_config/k8sconfcert/
sudo cp -r /var/lib/kubelet/pki /home/k8s1/backup_config/k8scerts/

```

Certificate renewal using kubeadm
``` bash
# Help
sudo kubeadm certs renew --help


# Renew certificates of all k8s objects
sudo kubeadm certs renew all

# Checking certificate
sudo kubeadm certs check-expiration

```