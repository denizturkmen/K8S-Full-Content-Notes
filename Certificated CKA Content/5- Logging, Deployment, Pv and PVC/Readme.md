# Logging, Deployment, Persistent Volume and Persistent Volume Claims 


Question_1- Logging a pod to xxx file 
``` bash
# create a pod
kubectl run nginx --image nginx --restart Always

# Log the nginx pod in / /home/k8s1/tst.log
kubectl logs nginx /home/k8s1/tst.log

```


Question_2: Scale deployment
``` bash
# create a deployment
kubectl create deployment nginx1 --image nginx --replicas 1 

# check a pod and deployments
kubectl get pods
kubectl get deployment

# 1st way: scale
kubectl scale deployment nginx1 --replicas 3

# 2nd way: edit
kubectl edit deployments.apps nginx 


```

Question_3: pod bound to pv
``` bash
# apply manifest
kubectl apply -f pv-pvc.yaml

# check pv and pvc
kubectl get pv,pvc 

# create pods
kubectl apply -f pods.yaml

# copy
kubectl cp index.html nginx3:/usr/share/nginx/html

# expose pods
kubectl expose pods nginx --type NodePort --port 80 

```
