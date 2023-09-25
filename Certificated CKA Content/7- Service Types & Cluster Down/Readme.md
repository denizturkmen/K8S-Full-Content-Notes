# Service Types & Control Plane And Worker Node Down


Question_1: Let's expose in the deployment nodeport type and let the host port be 80 nodeport 31562
``` bash
# create deployment
kubectl create deployment nginx --replicas 1 --port 80 --image nginx 

# look at deployment
kubectl get deployments

# look at pods
kubectl get pods

# expose deployment 
( ? ) 
kubectl expose deployment nginx --type NodePort --port 80 --target-port 80 

# check service
kubectl get service

# expose to 32566 
kubectl describe svc nginx
kubectl expose deployment nginx --type NodePort --port 80 --target-port 80 -o yaml > svc.yaml
vim svc.yaml
    nodePort: 31562

kubectl apply -f svc.yaml

# checking svc
kubectl get svc

# clean-up deployment and service
kubectl delete deployment nginx
kubectl delete svc nginx

```

Question_2: Control plane issue.
``` bash
# apply 
kubectl create deployment nginx --replicas 2 --port 80 --image nginx 

# checking
kubectl get deployments
kubectl get pods
kubectl get rs

# kube-system namespace
kubectl get pods -n kube-system 
kubectl logs -n kube-system  kube-scheduler_pod
kubectl describe -n kube-system  kube-scheduler_pod

# clean-up deployment and service
kubectl delete deployment nginx


```


Question_3: Control plane issue. ( scale issue)
``` bash
# apply 
 kubectl scale deployment nginx --replicas 3

# checking
kubectl get deployments
kubectl get pods
kubectl get rs

# kube-system namespace
kubectl get pods -n kube-system 
kubectl logs -n kube-system kube-controller-manager
kubectl describe -n kube-system kube-controller-manager-controlplane

# clean-up deployment and service
kubectl delete deployment nginx

```

Question_4: Worker Node Issue
``` bash
# check nodes
kubectl get nodes

# solve
ssh node01
sudo systemctl start kubelet.servive

```