# Installation and Configure Istio


You can dowland it with the following command
``` bash
# Latest version
curl -L https://istio.io/downloadIstio | sh -

# Specific version;
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=X.XX.X TARGET_ARCH=x86_64 sh -

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.18.2 TARGET_ARCH=x86_64 sh -

# Release list
https://github.com/istio/istio/releases

# Move to the Istio package directory. 
cd istio-1.18.2

# Add the istioctl client to your path 
export PATH=$PWD/bin:$PATH

# to do list command for istioctl
istioctl --help

```


You can enable and install it with the following command
``` bash
# Install
istioctl install --set profile=profile_name -y
istioctl install --set profile=demo -y

# Controlling istio-system namespace
kubectl get all -n istio-system

# Install verify
istioctl verify-install

# Profile list
https://istio.io/latest/docs/setup/additional-setup/config-profiles/


```


Profile listing with istioctl
``` bash
istioctl profile list

```








# Referance
```
Dowland: https://istio.io/latest/docs/setup/getting-started/#download
Profile: https://istio.io/latest/docs/setup/additional-setup/config-profiles/
Realases: https://github.com/istio/istio/releases
Install Types: https://istio.io/latest/docs/setup/install/

```