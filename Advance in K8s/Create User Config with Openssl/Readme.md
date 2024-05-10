# Creating user with Opensll for kubernetes and adding Kubeconfig 

Firstly, Let's create a specific user and define limited authority for this user. For this;
``` bash
# we need crt and key for user
openssl genrsa -out denizturkmen.key 2048

# we must create from .key
openssl req -new -key denizturkmen.key -out denizturkmen.csr -subj "/CN=denizturkmen"

# We need to create crt using ca.crt and ca.key. ca.key and ca.crt under /etc/kubernetes/pki
sudo cp ca.* /home/k8s1/Desktop/user_rbac/
sudo openssl x509 -req -in denizturkmen.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out denizturkmen.crt

# opening .crt
cat denizturkmen.crt

# check kubeconfig
cat ~/.kube/config

# We will add it to the user config file with the certificate we just created.
kubectl config set-credentials denizturkmen --client-certificate=denizturkmen.crt --client-key=denizturkmen.key

# user list
kubectl config get-users 

# context lists
kubectl config get-contexts

# cluster lists
kubectl config get-clusters
kubectl config get-contexts

# We will set the user with our existing cluster on a new context.
kubectl config set-context denizturkmen-context --cluster=kubernetes --user=denizturkmen


# switcing new context
kubectl config use-context denizturkmen-context

# check
kubectl get nodes

# switcing admin context
kubectl config get-contexts
kubectl config use-context kubernetes-admin@kubernetes
kubectl config current-context

# export and minify, new user 
kubectl config use-context denizturkmen-context
kubectl config view --minify --flatten > denizturkmen.kubeconfig

```

Rbac create with user
``` bash
# create cluster-role
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: denizturkmen-role
rules:
- apiGroups: [""]
  resources: ["nodes", "pods", "deployments", "statefulsets", "services", "configmaps", "secrets"]
  verbs: ["get", "watch", "list", "create", "update", "patch"]

# apply
kubectl apply -f cluster-role.yaml

# create cluster-role-binding
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: denizturkmen-clusterbinding
subjects:
- kind: User
  name: denizturkmen
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: denizturkmen-role
  apiGroup: rbac.authorization.k8s.io

# apply 
kubectl apply -f cluster-role-binding.yaml

# checking rbac permission: test denizturkmen user
kubectl config use-context denizturkmen-context
kubectl auth can-i get ingress
kubectl auth can-i delete pods

```

Useful
``` bash
kubectl config view --minify=true

kubectl get ingress --kubeconfig denizturkmen.kubeconfig


```