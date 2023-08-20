# A&B Testing

What is **A&B Testing Deployment?**

A/B testing is an online experimentation process that helps you determine which of two or more assets, like a web page or a page element, performs best according to whatever measurable criteria you want to set. Put simply, A/B tests allow you to see which variation works better for your audience based on statistical analysis.

**Hands-On**

First, we will deploy the configmap,deployment and service v1 version, For this;
``` bash
# Apply
kubeclt apply -f ab-deployment-svc-config-v1.yaml

# Checking pods status
kubectl get pods 

# To look replicaset
kubectl get replicaset

# Checking the container inside the application
curl http://Cluster_IP:Port_number

```

Secondly, we will deploy the configmap,deployment and service v2 version, For this;
``` bash
# Apply
kubeclt apply -f ab-deployment-svc-config-v2.yaml

# Checking pods status
kubectl get pods 

# To look replicaset
kubectl get replicaset

# Checking the container inside the application
curl http://Cluster_IP:Port_number


```

Thirdly, we will deploy the ingress for v1 version. 
``` bash
# Apply
kubeclt apply -f ab-ingress-v1.yaml

# Checking ingress
kubectl get ingress

# Run script.sh 
while true; do curl http://abtesting.com && sleep 1 && echo ""; done;

```

We must add the IP addresses and dns name under **/etc/hosts**.
**sudo vim /etc/hosts** .For this;
``` bash
Ingress_IP_Addresses           Dns_Name
192.168.1.200                  abtesting.com

# Apply
kubeclt apply -f ab-ingress-v1.yaml

# Checking ingress
kubectl get ingress

```

Then, we will deploy the ingress for v2 version. 

``` bash
# Apply
kubeclt apply -f ab-ingress-v2.yaml

# Checking ingress
kubectl get ingress

# Run script.sh 
while true; do curl http://abtesting.com && sleep 1 && echo ""; done;

```

Let's make the weight 100 in ab-ingress-v2
``` bash
# Edit
kubectl edit ingress ing-web-v2 

# To trace script

```