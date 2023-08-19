# Recreate and RollingUpdate

What is **Recreate Deployment?**

Recreate is the simplest deployment strategy. A recreate deployment would go something like this. Version 1 of the app is deployed. Deployment starts, all pods running version 1 of the app are deleted. Immediately followed by version 2 of the application being deployed. The biggest draw back with recreate deployments is the small window of downtime.

**!Important** : Terminate the **old version** and **release the new one**
We use full migration. For example **db migration**

Hands-on

First, we will deploy the deployment v1 version, For this;
``` bash
# Apply
kubeclt apply -f  recreate-deployment-v1.yaml

# Checking pods status
kubectl get pods 

# To look replicaset
kubectl get replicaset

```

Secondly, Service created. For this
``` bash
# Apply
kubeclt apply -f  recreate-services.yaml

# Checking pods status
kubectl get services

# Checking via browser
curl node_ip:node_port
curl http://192.168.1.7:32568

```

Finally, we deploy v1 to v2.
``` bash
# Apply
kubeclt apply -f  recreate-deployment-v1.yaml

# Checking pods status
kubectl get pods 

# To look replicaset
kubectl get replicaset

```

