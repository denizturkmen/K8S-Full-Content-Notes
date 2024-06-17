# Pull an Image from a Private Registry ( serviceAccount level) 


**Step by Step:** Pull an Image from a Private Registry

We are using docker hub as private registry.
let's do the private image deployment. For this
``` bash
# Apply 
kubectl apply -f deployment-private.yaml

# Checking for deployment
kubectl get deployments

# Checking for pods
kubectl get pods

# Checking describe
kubectl describe pods pod_name

```

Regcred must create for pull an image from private registry
``` bash
# template
kubectl create secret docker-registry <secret-name> \
  --docker-server=<your-registry-server> \
  --docker-username=<your-username> \
  --docker-password=<your-password> \
  --docker-email=<your-email>

# docker-registry create for docker hub
kubectl create secret docker-registry <secret-name> \
  --docker-server=<your-registry-server> \
  --docker-username=<your-username> \
  --docker-password=<your-password> \
  --docker-email=<your-email>

# docker hub server url
 --docker-server=https://index.docker.io/v1/ 

# patching level sa
kubectl patch serviceaccount <service-account-name> \
  -p '{"imagePullSecrets": [{"name": "<secret-name>"}]}'
  

```


