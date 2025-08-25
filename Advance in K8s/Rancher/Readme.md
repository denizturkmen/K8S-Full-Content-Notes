# How to Install and Configure Rancher with Helm

## Addin helm repo
``` bash
# add
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo update

# specific version list
helm search repo repo_name --versions
helm search repo rancher --versions

# dowland values.yaml
helm show values rancher-stable/rancher --version 2.11.3 > rancher-values.yaml

```


## Install
``` bash
# 

```


## Optimize and Tuning
``` bash
# 

```


##
``` bash


```


##
``` bash


```


##
``` bash


```