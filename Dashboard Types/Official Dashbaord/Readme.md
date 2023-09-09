# Official Kubernetes Dashboard Install and Configuration


Installation k8s dashboard
``` bash
# Apply
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml

# Check
kubectl get all -n kubernetes-dashboard

# Changed loadbalancer type to service
kubectl edit service -n kubernetes-dashboard kubernetes-dashboard 
    LoadBalancer

```

You have to add **etc/hosts** entry and IP Addresses.
``` bash
sudo vim /etc/hosts
    IP_Adresses         Dns_name
    192.168.1.201       dashboard.dev.com

```

Apply to ingress.yaml
``` bash
# Apply
kubectl apply -f ingress-dashboard.yaml

# Check
kubectl get ingress -n kubernetes-dashboard

```


Admin user
``` bash
# Apply
kubeclt apply -f admin-user.yaml

# Check
kubectl get sa -n kubernetes-dashboard 
---
kubectl get clusterrole -n kubernetes-dashboard 
kubectl get clusterrole -n kubernetes-dashboard | grep cluster-admin
---
kubectl get clusterrolebinding -n kubernetes-dashboard 
kubectl get clusterrolebinding -n kubernetes-dashboard | grep admin-user

# Token
kubectl -n kubernetes-dashboard create token admin-user

or

kubectl create token default --duration=488h --output yaml

```

Getting a long-lived Bearer Token for ServiceAccount
``` bash
# Apply
kubectl apply -f long-secret-dashboard.yaml

# Check
kubectl get secret -n kubernetes-dashboard

# Token
kubectl get secret admin-user -n kubernetes-dashboard -o jsonpath={".data.token"} | base64 -d

kubectl describe secret -n kubernetes-dashboard admin-user

```




# Referance
``` bash
https://github.com/kubernetes/dashboard
Admin USER: https://computingforgeeks.com/create-admin-user-to-access-kubernetes-dashboard/
Token: https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md
Non-Expiring-Token: https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/#:~:text=To%20create%20a%20non-expiring,with%20that%20generated%20token%20data.

```
