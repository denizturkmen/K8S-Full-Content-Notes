# Example Istio: BookInfo 

Hands-On

You can deployment it with the following command.
We've enabled auto-injection of **Envoy sidecar** proxies for the default namespace

Look at **istio documents** for scenarios

Hands-on 
``` bash
# Injection istio using namespave
kubectl label namespace namespace_name istio-injection=enabled
kubectl label namespace default istio-injection=enabled

# Injection label and selector show 
kubectl get namespaces --show-labels
kubectl get namespaces default --show-labels 

# Apply
kubectl apply -f bookinfo.yaml

# Checking deployments, pod and service
kubectl get deployments,pods,svc

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


ingress name and ingress namespace export via ISTIO-APIs
``` bash
export INGRESS_NAME=istio-ingressgateway
export INGRESS_NS=istio-system

```

Ingress
``` bash
# Ip addresss for istio-ingressgateway
export INGRESS_HOST=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# Port number to http
export INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')

# Checking
echo $INGRESS_HOST
echo $INGRESS_PORT

# Export and check Gateway 
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo $GATEWAY_URL

```

# Referance
```
https://istio.io/latest/docs/setup/getting-started/
BookInfo: https://istio.io/latest/docs/examples/bookinfo/
Manuel Injection: https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/#manual-sidecar-injection



```