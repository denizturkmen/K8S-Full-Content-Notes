# How to create helm template with cli


### Hello-world example
``` bash
# Initialize a Helm Chart Repository
helm repo add stable https://charts.helm.sh/stable

```

``` bash
# List Available Charts
helm search repo stable

```

``` bash
# Create Hello-world Example
helm create hello-wolrd

```


``` bash
# Install Hello-worls Helm Chart
kubectl create namespace test
helm install -f hello-wolrd/values.yaml -n test hello-wolrd ./hello-wolrd

```


``` bash
# Learn About hello-world Release
helm ls -n test

```

Clean Up
``` bash
# Uninstall a Release
$ helm uninstall -n dev hello-wolrd

# remove stable repo
$ helm repo remove stable

```


