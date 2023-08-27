# Example Istıo 

Hands-On

You can deployment it with the following command.
We've enabled auto-injection of **Envoy sidecar** proxies for the istio_ns namespace
``` bash
# Apply
kubectl apply -f bookinfo.yaml

# Checking pod and service
kubectl get pods,svc

# Checking service accounts
kubectl get sa

# Rating page check
 kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

```

**Important:**  Istio is primarily responsible for handling all the mesh traffic. Hence, **any traffic** to or **from outside** of the mesh is **not permitted** by default. Istio uses **gateways** to manage **inbound and outbound** traffic from the mesh.Istio provides some preconfigured gateway proxy deployments: **istio-ingressgateway and istio-egressgateway.**

istio-ingressgateway: inbound traffic.
istio-egressgateway: outbound traffic.


Gateway and virtual service should create for outbound and inbound traffic. For this;
``` bash
# Apply
kubectl apply -f bookinfo-gateway.yaml

# Checking
kubectl get  gateway.networking.istio.io,virtualservice.networking.istio.io

# Ensure that there are no issues with the configuration:
istioctl analyze

# Note: To mention Destination rule

```



View the dashboard
``` bash
# Apply
kubectl apply -f samples/addons

```







# Referance
```
BookInfo: https://istio.io/latest/docs/examples/bookinfo/

```