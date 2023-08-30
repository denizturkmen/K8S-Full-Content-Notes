# Pull an Image from a Private Registry


**Step by Step:** Pull an Image from a Private Registry

We are using docker hub as private registry.

First, let's do the public  image deployment. For this
``` bash
# Apply 
kubectl apply -f deployment-public.yaml

# Checking for deployment
kubectl get deployments

# Checking for pods
kubectl get pods

```

Secondly, let's do the private image deployment. For this
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

Thirdth, One secret must create for pull private image.

**Note:** Command to run to learn registry Url.
first login to docker hub then run below command: 
docker login command: **docker login -uusername**
registry_url check command:  **cat ~/.docker/config.json**

``` bash
# Template
kubectl create secret docker-registry "secret_ismi" --docker-server="registry_url" --docker-username="username" --docker-password="password"

# Apply for secret
kubectl create secret docker-registry regcred --docker-server="https://index.docker.io/v1/" --docker-username="denizyoutube" --docker-password="q1w2e3r4*"

# Checking for secret
kubectl get secret 

```

Then let's do the private image deployment. For this
``` bash
# Apply 
kubectl apply -f deployment-private-regcred.yaml

# Checking for deployment
kubectl get deployments

# Checking for pods
kubectl get pods

# Checking describe
kubectl describe pods pod_name
```


**2 way:** Pull an Image from a Private Registry
first, must be **docker login**

``` bash
# docker hun config file 
cat ~/.docker/config

# Template
kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=<path/to/.docker/config.json> \
    --type=kubernetes.io/dockerconfigjson

# Apply
kubectl create secret generic regcred \
> --from-file=.dockerconfigjson=/home/k8s1/.docker/config.json \
> --type=kubernetes.io/dockerconfigjson

# Create for deployment
kubectl apply -f deployment-private-regcred.yaml

# Checking
kubect get pods

```


## Referance
``` bash
https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
https://jamesdefabia.github.io/docs/user-guide/kubectl/kubectl_create_secret_docker-registry/
https://kubernetes.io/docs/concepts/configuration/secret/


```