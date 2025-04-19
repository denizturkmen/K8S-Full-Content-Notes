# Useful Helm Commands


## Install 
``` bash
# add
helm repo add bitnami https://charts.bitnami.com/bitnami

# list
helm repo list

# search
helm search repo bitnami

# update
helm repo update

# specific version list
helm search repo repo_name --versions
helm search repo bitnami/nginx --versions


# show version
helm show values repo_name
helm show values bitnami/nginx > values.yaml
helm show values bitnami/nginx --version 19.1.0 > values.yaml

# install
helm install my-nginx bitnami/nginx --version 17.3.3

# nginx version
kubectl exec -it pod/pod_name -- nginx -v

# helm fetch command: dowland to local directory from repository
helm fetch bitnami/nginx --version 17.3.3
ls
tar -zxvf nginx-17.3.3.tgz

#installed helm on the local
helm list

helm get values release_name --all -o yaml > my-nginx-values-backup.yaml
helm get values my-nginx --all -o yaml > my-nginx-values-backup.yaml

# manifest backup
helm get manifest relasease_name > my-nginx-manifest.yaml
helm get manifest my-nginx > my-nginx-manifest.yaml


# values
helm show values bitnami/nginx
helm show values bitnami/nginx --versions 17.3.3

# upgrade
helm upgrade release_name repo_name --version version
helm upgrade my-nginx bitnami/nginx --version 19.1.0 --dry-run
helm upgrade my-nginx bitnami/nginx --version 19.1.0


# rollback
helm history release_name
helm history my-nginx
--
helm rollback release_name
helm rollback <release-name> <revision-number>
helm history my-nginx 1


# from backup
kubectl apply --dry-run=client -f my-nginx-manifest.yaml
kubectl apply  -f my-nginx-manifest.yaml

```


##
``` bash



```


##
``` bash



```