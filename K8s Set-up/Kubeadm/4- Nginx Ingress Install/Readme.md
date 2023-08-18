# Nginx Ingress Installation and Configure

The Ingress is a Kubernetes resource that lets you configure an HTTP load balancer for applications running on Kubernetes, represented by one or more Services. 
Such a load balancer is necessary to deliver those applications to clients outside of the Kubernetes cluster.
Layer-7 Http


# Nginx-Ingress apply
``` bash
# Apply
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.7.1/deploy/static/provider/cloud/deploy.yaml 

# Check
kubectl get all -n ingress-nginx

```



# Refereance
``` bash
https://kubernetes.github.io/ingress-nginx/deploy/
https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-manifests/
Compatible: https://github.com/kubernetes/ingress-nginx


```
