# 

step by step
``` bash
1- certbot install
2- dns challange start
    txt record ache_challend and answer
3- keys location
4- mv keys
5- created secret 
6- deployment
7- service CLUSTERIP
8- tls ingress configuration
```

Install certbort on ubuntu
``` bash
# update package
sudo apt update

# install
sudo apt install certbot -y

# dns challange
sudo certbot certonly --manual --preferred-challenges=dns --email turkmen_deniz@hotmail.com  --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d devops-deniz.net



```


Created secret tls for Ingress
``` bash
# Template
kubectl create secret tls tls_name -n namespace_name --key=key --cert=crt

# Apply
kubectl create secret tls ing-tls -n web --key=denizturkmen.com.key --cert=denizturkmen.com.crt

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

Now let's create an ingress without tls
``` bash
# Apply service
kubectl apply -f non-ingress.yaml

# Checking service
kubectl get ingress -n web

 
```




# Referance
``` bash
https://kubernetes.io/docs/concepts/services-networking/ingress/#tls


```

