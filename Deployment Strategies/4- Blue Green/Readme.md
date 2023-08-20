# Blue & Green

What is **Blue Green Deployment?**

Blue/green deployment is a software deployment approach that helps organizations deploy frequent updates while maintaining high quality and a **smooth user experience**. The blue/green deployment method helps **to minimize** the risk of introducing flaws during software updates while limiting **downtime** during the transition to new versions. 


**Hands-on**

First, we will deploy the deployment v1 version, For this;
``` bash
# Apply
kubeclt apply -f  bluegreen-deployment-blue.yaml

# Checking pods status
kubectl get pods 

# Port forward
kubectl port-forward pod pod_name host_port_number:container_port_number
kubectl port-forward pods/web-app-1-8d585d64f-bkcng 8080:80

# Checking service
kubeclt get svc

```


Secondly, we will deploy the deployment v2 version, For this;
``` bash
# Apply
kubeclt apply -f  bluegreen-deployment-green.yaml

# Checking pods status
kubectl get pods 

# Checking service
kubeclt get svc

```


Thirdly, Service created. For this
``` bash
# Apply
kubeclt apply -f  bluegreen-service.yaml

# Checking service
kubeclt get svc

```

Redirection traffic from blue to green pod.
``` bash
# Edit service
kubectl edit svc web-svc

# Redirection with label-Selector
selector:
    app: web-app
    strategies: green

# Describe
kubectl describe svc web-svc 

```

Then, we will deploy the ingress for blue and green together
``` bash
# Apply
kubeclt apply -f bluegreen-ingress.yaml

# Checking ingress
kubectl get ingress

```

We must add the IP addresses and dns name under **/etc/hosts**.
**sudo vim /etc/hosts** .For this;
``` bash
Ingress_IP_Addresses           Dns_Name
192.168.1.200                  bluegreen.com

```


Script change from blue to green
``` bash
# Install jq
sudo apt update
sudo apt install -y jq

# Finding the selector value inside the service
kubectl get service web-svc -ojsonpath='{.spec.selector.strategies}

# with jq
kubectl get service web-svc -o json | jq '.spec.selector.strategies'

# Patching
kubectl patch service web-svc  --type JSON -p='[{"op": "replace", "path": "/spec/selector/strategies", "value":"green"}]'



```