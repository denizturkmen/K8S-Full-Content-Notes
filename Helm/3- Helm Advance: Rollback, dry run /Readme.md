# Helm CLI-Command

### Creating app
``` bash
# create
helm create app

```

### Running nginx 1.22 version
``` bash
# dry run
helm install --dry-run --set image.tag=1.22.1 -n default app ./app

# create nginx image
helm install --set image.tag=1.22.1 -n default app ./app

# list
helm list -n default

```

### Learning image tag
``` bash
# application name  - image tag
kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].image}{"\n"}{end}'

```


### Helm upgrade
``` bash
# help command
helm upgrade --help

# upgrade
helm upgrade app --set image.tag=1.23.1 -n default ./app/

# check
kubectl get pods -n default

```


### Helm roolback
``` bash
# rolback command
helm rolback relaase_name
helm rollback app

# Check image tag
kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].image}{"\n"}{end}'

```


### Helm upgrade: failed step
``` bash
# upgrade
helm upgrade app --set image.tag=wrong --timeout=30s --atomic --cleanup-on-fail -n default ./app/


```



