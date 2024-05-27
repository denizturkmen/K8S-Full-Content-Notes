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

Example of SecretMapGenerator: dev environment. 
``` bash
# both dev and prod must create directory 
├── kustomize
  ├── base
    │   ├── deployment.yaml
    │   ├── kustomization.yaml
    │   │   ├── prod
    │────     ├── more-secret-deployment.yaml
    │────     ├── kustomization.yaml       
    └ overlays
        ├── dev
        │   └── kustomization.yaml
        └── prod
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
kubectl get secrets -n default
kubectl get secrets -o yaml 
  echo -n "XXXX" | base64 -d 
kubectl exec -it pod_name -- env

```

Example of ConfigMapGenerator: prod environment. Let's patch it to 2 replicas and read file for configmap.
``` bash
# both dev and prod must create directory 
├── kustomize
  ├── base
    │   ├── deployment.yaml
    │   ├── kustomization.yaml
    │   │   ├── prod
    │────     ├── more-secret-deployment.yaml
    │────     ├── kustomization.yaml       
    └ overlays
        ├── dev
        │   └── kustomization.yaml
        └── prod
            └── namespace.yaml
            └── kustomization.yaml


# build dev env: go to directory
cd /kustomize/overlays/prod
kustomize build .

# apply
kustomize build . | kubectl apply -k .
or
kubectl apply -k .

# check
kubectl get pods -n prod
kubectl get secrets -n prod
kubectl get deployments -n prod
kubectl exec -it -n prod pods/pod_name -- env

```