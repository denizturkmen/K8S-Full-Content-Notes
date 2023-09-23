# Multi-Container


multi-container
``` bash
# create 
kubectl run nginx --image nginx --dry-run=client -o yaml


```


Logging: multi-container 
``` bash
# create
kubectl apply -f three-container.yaml

# check
kubectl get pods

# describe pods
kubectl describe pods pods_name

# look at log 
kubectl logs -f pods_name

# exec to container
kubectl exec -it pods_name -c container_name

```


Sidecar container
``` bash
# create manifest
kubectl apply -f sidecar-container.yaml

# describe pods
kubectl describe pods sidecar 

# look at sidecar container 
kubectl logs -f sidecar -c sidecar-container

```