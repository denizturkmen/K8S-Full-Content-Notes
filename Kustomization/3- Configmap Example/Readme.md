# How can we make a deployment example with kustomization?

Standalone install on k8s cluster
``` bash
# Install
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

# permission 
sudo install -o root -g root -m 0755 kustomize /usr/local/bin/kustomize

# check
kustomize version

```

Example of ConfigMapGenerator: dev environment. ConfigMag
``` bash
# both dev and prod must create directory 
├── kustomize
  ├── base
    │   ├── deployment.yaml
    │   ├── kustomization.yaml
    └ overlays
        ├── dev
        │   └── kustomization.yaml
        └── prod
            ├── prod-deployment.yaml
            └── namespace.yaml
            └── kustomization.yaml

# build dev env: go to directory
cd /kustomize/overlays/dev
kustomize build .

# apply
kustomize build .| kubectl apply -f -
or
kubectl apply -k .

# check
kubectl get pods -n default
kubectl get cm -n default
kubectl exec -it pod_name -- env

```

Example of ConfigMapGenerator: prod environment. Let's patch it to 2 replicas and read file for configmap.
``` bash
# both dev and prod must create directory 
├── kustomize
  ├── base
    │   ├── deployment.yaml
    │   ├── kustomization.yaml
    └ overlays
        ├── dev
        │   └── kustomization.yaml
        └── prod
            ├── prod-deployment.yaml
            └── namespace.yaml
            └── kustomization.yaml

# build dev env: go to directory
cd /kıustomize/overlays/prod
kustomize build .

# apply
kustomize build . | kubectl apply -k .
or
kubectl apply -k .

# check
kubectl get pods -n prod

```