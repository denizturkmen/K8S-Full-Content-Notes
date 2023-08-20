What is **RollingUpdate Deployment?**

A Rolling Update, on the other hand, gradually replaces pod instances with newer versions to ensure there are enough new pods to maintain the availability threshold before terminating old pods. Such a phased replacement ensures there is always a minimum number of available pods that enable a safe rollout of updates without causing **any downtime**.


**Hands-on**

First, we will deploy the deployment v1 version, For this;
``` bash
# Apply
kubeclt apply -f rollingUpdate-deployment-v1.yaml

# Checking pods status
kubectl get pods 

# To look replicaset
kubectl get replicaset

```

Secondly, Service created. For this
``` bash
# Apply
kubeclt apply -f  rollingUpdate-service.yaml

# Checking pods status
kubectl get services

# Checking via browser
curl node_ip:node_port
curl http://192.168.1.7:32425

```

Finally, we deploy v1 to v2.
``` bash
# Apply
kubeclt apply -f  rollingUpdate-deployment-v2.yaml

# Checking pods status
kubectl get pods 

# To look replicaset
kubectl get replicaset
