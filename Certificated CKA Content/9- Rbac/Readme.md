# Using RBAC Authorization


Question_1: Create a new service account with the name **pod-viewer**. Grant this Service account access to get all pods in the cluster by creating an appropriate cluster role called **pod-viewer-role** and ClusterRoleBinding called **pod-viewer-role-binding**.

``` bash
# create service account
kubectl create serviceaccount --help
kubectl create serviceaccount pod-viewer

# checking sa
kubectl get sa

# create cluster-role
kubectl create clusterrole --help
kubectl create clusterrole pod-viewer-role --verb=get --resource=pods

# create cluster-role-binding
kubectl create clusterrole --help
kubectl create clusterrolebinding pod-viewer-role-binding --clusterrole=pod-viewer-role --serviceaccount=default:pod-viewer

# authorization
kubectl auth can-i get pods --namespace default --as system:serviceaccount:default:pod-viewer

```


