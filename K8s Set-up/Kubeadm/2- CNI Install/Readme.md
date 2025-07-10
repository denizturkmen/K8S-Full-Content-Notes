 # Installing and Configuring CNI
 
 ## Install Kubernetes network plugin: **WeaveNet**
 ``` bash
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

 ```

## Install Kubernetes network plugin: **Calico**
 ```bash
coming soon

 ```

 ## Install Kubernetes network plugin: **Flannel**
 ```bash
coming soon

 ```


## Install Kubernetes network plugin: **Cillium** with Helm
``` bash 
# Install helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# Pre-installation 
sudo su -
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1

# Add Helm repo
helm repo add cilium https://helm.cilium.io/
helm repo update

# dowland 1.17.5
helm show values cilium/cilium --version 1.17.5 > values-prod-cillum.yaml

# taints
kubectl get po -n kube-system -w
kubectl taint nodes k8s-master-1 node-role.kubernetes.io/control-plane-

# install
helm install cilium cilium/cilium \
  --version 1.17.5 \
  --namespace kube-system \
  --set kubeProxyReplacementHealthzBindAddr="0.0.0.0:10256" \
  --set routingMode="tunnel" \ ?
  --set enableIPv4Masquerade="true" \
  --set enableIPv6Masquerade="false" \
  --set ipv6.enabled="false" \
  --set autoDirectNodeRoutes="true" \ ? 
  --set hubble.enabled="true" \
  --set hubble.ui.enabled="true" \
  --set hubble.relay.enabled="true" \
  --set operator.replicas=1 \
  --set \
  --set \

helm install cilium cilium/cilium \
  --version 1.17.5 \
  --namespace kube-system \
  --set kubeProxyReplacementHealthzBindAddr="0.0.0.0:10256" \
  --set routingMode="tunnel" \
  --set enableIPv4Masquerade="true" \
  --set enableIPv6Masquerade="false" \
  --set ipv6.enabled="false" \
  --set hubble.enabled="true" \
  --set hubble.ui.enabled="true" \
  --set hubble.relay.enabled="true" \
  --set operator.replicas=1


# install
helm install cilium cilium/cilium \
  --version 1.17.5 \
  --namespace kube-system \
  -f values-prod-cillum.yaml

# Upgrade
helm upgrade --install cilium cilium/cilium \
  --version 1.17.5 \
  --namespace kube-system \
  -f values-prod.yaml



```








 
# Refereances:
``` bash
WeaveNet:
 https://www.weave.works/docs/net/latest/kubernetes/kube-addon/
 https://github.com/weaveworks/weave/

Calico:

Flannel: 

Cilium: 
 https://github.com/cilium/cilium
 https://docs.cilium.io/en/stable/helm-reference/



```
