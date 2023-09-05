# New Token Create using Kubeadm


Creating a new token with kubeadm for master node 
```bash
# list of token
sudo kubeadm token list

# helping
sudo kubeadm token --help

# new token create to help
sudo kubeadm token create --help

# Note
To create a new certificate key you must use  ' kubeadm init phase upload-certs --upload-certs '
kubeadm init phase upload-certs --upload-certs 

# this command one generate token for master node. This token --certificate-key must add
sudo kubeadm token create --certificate-key XXXXXXXXXXXXXXXXXXXXXXXX --print-join-command

# For instance 
sudo kubeadm token create --certificate-key 9c7a0dc7decab29fd2f44fc91e35c93c1a07e0137eb69e4555eebfb0bc765d23 --print-join-command 

```


**Note: Container runtime, kubelet, kubeadm and kubectl** need to load all associated items on the **master node.**
The following command run master or control plane
``` bash
sudo kubeadm join kubernetes.dev.env.test:6443 --token wwydlo.xxbhqbkpq3rip9qy --discovery-token-ca-cert-hash sha256:8128ce844199816ae9129b9159b669522eaad15baafc6f2e719aeb45f4a09fcd --control-plane --certificate-key 9c7a0dc7decab29fd2f44fc91e35c93c1a07e0137eb69e4555eebfb0bc765d23 --node-name k8s-master-2

```

**Note: Container runtime, kubelet, kubeadm and kubectl** need to load all associated items on the **worker node.**
Creating a new token with kubeadm for master node worker node
``` bash
# list of token
sudo kubeadm token list

# helping
sudo kubeadm token --help

# new token create to help
sudo kubeadm token create --help

# this command one generate token for worker node
sudo kubeadm token create --print-join-command

# For instance
sudo kubeadm join kubernetes.dev.env.test:6443 --token thcbhg.d3owm52l6owryxgc --discovery-token-ca-cert-hash sha256:8128ce844199816ae9129b9159b669522eaad15baafc6f2e719aeb45f4a09fcd  --node-name k8s-worker-1

```

