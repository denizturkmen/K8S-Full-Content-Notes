# Helm install with script on ubuntu

``` bash
# permission
sudo chmod +x helm-install.sh

# install
./helm-install.sh


```

### How to install to helm with package manager: debian/ubuntu
``` bash
# The below run command
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm


# check version
helm version

```

### How to install to helm with script: debian/ubuntu
``` bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

```


### Helm Useful Command list: Helm Repo

``` bash
# Adding helm repo
helm repo add bitnami https://charts.bitnami.com/bitnami

# Removing helm repo
helm repo remove bitnami https://charts.bitnami.com/bitnami

# helm repo list
helm repo list
helm repo ls

# Updatig helm repo 
helm repo update 

# search repo
helm search repo repo_name
helm search repo bitnami

```

### Helm Install
``` bash
# Adding bitnami helm repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# Method_1: Deploying postgres repositoty with helm 
helm install my-release bitnami/postgresql

# Method_2: Deploying postgres repositoty with helm 
helm install my-release --values=my-values.yaml bitnami/postgresql 

# Method_3: Deploying postgres repositoty with helm  
helm install my-release --set global.postgresql.postgresqlUsername=denizturkmen bitnami/postgresql


```

### Helm Upgrade
``` bash
# Firstly, Deployment postgres wiwth helm
helm install my-release bitnami/postgresql

# Upgrade 
helm upgrade my-release --set global.postgresql.postgresqlUsername=denizturkmen bitnami/postgresql

```

### Helm List
``` bash
# List of release
helm list
or
helm ls

```

### Helm Rollback
``` bash
# rollback 
helm rollback my-release

# spesifik version rollback
helm rollback my-release <revision>

```

### Helm Create
``` bash
# create
helm create <chart_name>

```

### Helm Lint
``` bash
# find error in the chart
helm lint <path>

```

### Helm Uninstall
``` bash
# remove release
helm uninstall my-release

```

