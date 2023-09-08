# Skooner Dashboard Installation for Kubernetes


Installation on ubuntu 20.04
``` bash
# Apply
kubectl apply -f https://raw.githubusercontent.com/skooner-k8s/skooner/master/kubernetes-skooner.yaml

# Checking deployment and service
kubectl get svc,deployments.apps -n kube-system 

# Expose service
kubectl edit svc -n kube-system skooner

# Ingress
kubectl apply -f ingress-skooner.yaml

# Check Ingress
kubectl get ingress -n kube-system

# Create the service account in the current namespace (we assume default)
kubectl create serviceaccount skooner-sa

# Give that service account root on the cluster
kubectl create clusterrolebinding skooner-sa --clusterrole=cluster-admin --serviceaccount=default:skooner-sa

# For Kubernetes v1.21 or lower
# Find the secret that was created to hold the token for the SA
kubectl get secrets

# Show the contents of the secret to extract the token
kubectl describe secret skooner-sa-token-xxxxx

# For Kubernetes v1.22 or higher
kubectl create token skooner-sa

```



# Referance
``` bash
https://github.com/skooner-k8s/skooner



```