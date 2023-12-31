# Https Connection with Ingress-Controller 


Created secret tls for Ingress
``` bash
# create ns
kubectl create ns web

# Template
kubectl create secret tls tls_name -n namespace_name --key=key --cert=crt

# Apply
kubectl create secret tls ing-tls -n web --key=denizturkmen.devops-deniz.net.key --cert=denizturkmen.devops-deniz.net.crt

# Checking
kubectl get secrets -n web

# Describe
kubectl describe secret ing-tls -n web

```

We should create deployment.
``` bash
# Apply Deployment
kubectl apply -f deployment.yaml

# Checking deployment
kubectl get deployment -n web

# Checking pods
kubectl get pods -n web
 
```

Then We should create service.
``` bash
# Apply service
kubectl apply -f service.yaml

# Checking service
kubectl get service -n web
 
```

Now let's create an ingress without TLS
``` bash
# Apply service
kubectl apply -f non-ingress.yaml

# Checking service
kubectl get ingress -n web

# adding /etch/hosts to dns
    192.168.1.200   denizturkmen.devops-deniz.net

```

Now let's create an ingress with TLS
``` bash
# Apply service
kubectl apply -f tls-ingress.yaml

# Checking service
kubectl get ingress -n web


```



# Referance
``` bash
https://kubernetes.io/docs/concepts/services-networking/ingress/#tls


```

