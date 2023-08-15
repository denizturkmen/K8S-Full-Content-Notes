MetalLB Installation and Set-up

if you usage as ipvs mode to kube-proxy, ARP mode should enable.
For this,
**kubectl edit configmap -n kube-system kube-proxy**
``` bash
ipvs:
 strictARP: true

```

To be with sed editor

``` bash
kubectl get configmap kube-proxy -n kube-system -o yaml | \ sed -e "s/strictARP: false/strictARP: true/" | \ kubectl apply -f — -n kube-system

```

Run the following command and install metallb
``` bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.6/config/manifests/metallb-native.yaml

```

Checking pods status
``` bash
kubectl get pods -n metallb-system

```

Metallb configuration
Open metallb-config yaml via vim editor.

``` bash
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.1.200-192.168.1.250
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: example
  namespace: metallb-system
spec:
  ipAddressPools:
  - first-pool

# Apply metallb-config
kubectl apply -f metallb-config.yaml

# Check metallb-config
kubectl get pods -n metallb-system

# Desribe
kubectl describe ipaddresspools first-pool -n metallb-system


```




