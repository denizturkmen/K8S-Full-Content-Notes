#  Canary

What is **Canary**
A canary deployment is a progressive rollout of an application that splits traffic between an already-deployed version and a new version, rolling it out to a subset of users before rolling out fully.


**Hands-On**


First, we will deploy the configmap,deployment and service v1 version, For this;
``` bash
# Apply
kubeclt apply -f canary-configmaps-deployment-service-v1.yaml

# Checking get pods status
kubectl get pods 

# Checking get svc
kubectl get service

# Checking get configmaps

# Checking the container inside the application
curl http://Cluster_IP:Port_number

```



Secondly, we will deploy the configmap,deployment and service v2 version, For this;
``` bash
# Apply
kubeclt apply -f canary-configmaps-deployment-service-v2.yaml

# Checking get pods status
kubectl get pods 

# Checking get svc
kubectl get service

# Checking get configmaps
kubectl get configmaps

# Checking the container inside the application
curl http://Cluster_IP:Port_number


```

Thirdly, we will deploy the ingress for v1 version. 
``` bash
# Apply
kubeclt apply -f canary-ingress-v1.yaml

# Checking ingress
kubectl get ingress

# Run script.sh 
while true; do curl http://canary.com && sleep 1 && echo ""; done;

```

We must add the IP addresses and dns name under **/etc/hosts**.
**sudo vim /etc/hosts** .For this;
``` bash
Ingress_IP_Addresses           Dns_Name
192.168.1.200                  canary.com

# Checking ingress
kubectl get ingress

```

``` bash
# Apply
kubeclt apply -f canary-ingress-v2.yaml

# Checking ingress
kubectl get ingress

# Run script.sh 
while true; do curl http://canary.com && sleep 1 && echo ""; done;

```

Let's make the weight **100** in **canary.com**
``` bash
# Edit
kubectl edit ingress ing-web-v2 

# To trace script

```



# Referance
``` bash
https://kubernetes.github.io/ingress-nginx/examples/canary/


```
