# Kubeanv Dashboard Installation for Kubernetes


Installation on ubuntu 20.04
``` bash
# Apply
kubectl apply --kustomize github.com/kubenav/deploy/kustomize

#Checking
kubectl get svc,pods -n kubeanv

```