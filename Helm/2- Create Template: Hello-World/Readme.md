# How to create helm template with cli


### Hello-world example: Initialize a Helm Chart Repository
``` bash
helm repo add stable https://charts.helm.sh/stable

```

### List Available Charts
``` bash
helm search repo stable

```

### Create Hello-world Example
``` bash
helm create hello-wolrd

```

### Install Hello-worls Helm Chart
``` bash
kubectl create namespace test
helm install -f hello-wolrd/values.yaml -n test hello-wolrd ./hello-wolrd
or
cd hello-world
helm install hello-world -n test -f values.yaml .
```

### Learn About hello-world Release
``` bash
helm ls -n test

```

### Clean Up
``` bash
# Uninstall a Release
helm uninstall -n test hello-world

# remove stable repo
helm repo remove stable

```


