# Cheat Sheet for K8s

Kubectl autocomplete 
``` bash
source <(kubectl completion bash) 
echo "source <(kubectl completion bash)" >> ~/.bashrc 
```

Alias for kubectl
``` bash
# alias
alias k=kubectl
complete -o default -F __start_kubectl k

# node
alias kgn="kubectl get nodes"

```

Running a pod
``` bash
# helping a command
kubectl run --help

# run
kubectl run pod_name --image image_name
kubectl run nginx --image nginx

# log
kubectl logs -f pod pod_name

# expose port 8080
kubectl run nginx1 --image=nginx --port=80
kubectl expose pod pod_name --port container_port --target-port host_port
kubectl expose pod pod_name --port container_port --target-port host_port --type=NodePort,LoadBalancer


# set labels "app=v1" and "env=test" in the container
kubectl run nginx2 --image=nginx--labels="app=v1,env=prod"

# show labels
kubectl get pods pod_name --show-labels

# Dry run;
kubectl run nginx3 --image=nginx --dry-run=client
kubectl run nginx3 --image=nginx --dry-run=client -o yaml
kubectl run nginx3 --image=nginx --dry-run=client -o yaml > nginx.yaml

 # set environment variables "POD_NAMESPACE=default" 
kubectl run nginx4 --image=nginx  --env="POD_NAMESPACE=default"

```

Create deployment
``` bash
# create
kubectl create deployment nginx4 --image nginx

# expose deployment
kubectl expose deployment deployment_name --port port_number
kubectl expose deployment nginx4 --port 8080
kubectl create deployment nginx5 --image nginx --replicas 3 --dry-run=client --port 80 

# edit deployment
kubectl edit deployment deployment_name

# set image
kubectl set image deployments deployment_nane image_name=image_name:version
kubectl set image deployments nginx5  nginx=nginx:1.9.1 

# scale deployment
kubectl scale deployment deployment_name --replicas number
kubectl scale deployment a --replicas 5

# desribe deployments
kubectl describe deployments deoployment_name --namespace namespace_name

# port-forward
kubectl port-forward deployments/deployment_name host_port:container_port
kubectl port-forward deployments/deniz 8081:80

```


Copy deployment from host to container 
``` bash
# from host to container
kubectl cp file_name namespace_name/pod_name:/usr/share/nginx/html

# from container to host
kubectl cp namespace_name/pod_name:/usr/share/nginx/html ~/directories

```

Viewing and finding resources 
``` bash
# create
kubectl create deployment nginx --image nginx --replicas 1 --namespace default --port 80 

# list
kubectl get deployments

# opening yaml file
kubectl get deployments -o yaml

# opening json file
kubectl get deployments.apps nginx -ojson

# finding pod name
kubectl get deployments.apps nginx -ojsonpath='{.metadata.name}'

# finding image name
kubectl get deployments.apps nginx -ojsonpath='{.spec.template.spec.containers[].name}'
or 
kubectl get deployments.apps nginx -o json | jq .spec.template.spec.containers[].name


# node
kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}'


```



``` bash
# All images name
kubectl get pods -A -o=custom-columns='DATA:spec.containers[*].image'

# 
kubectl get pods --namespace default --output=custom-columns="NAME:.metadata.name,IMAGE:.spec.containers[*].image"


