# Horizontal Pod AutoScaling

## What's Scaling
Horizontal;
Vertical;



Metric server install
``` bash
# Check cpu and ram usage
kubectl top node
kubectl top pod

# Apply
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Check
kubectl get pods -n kube-system 

# Logs
kubectl logs -f -n kube-system pod_name

# Fixing this issue
kubectl edit deployments -n kube-system metrics-server

# The following commands should be added under the deployment
    command:
    - /metrics-server
    - — kubelet-insecure-tls
    - --kubelet-preferred-address-types=InternalIP
    - --kubelet-preferred-address-types=InternalDNS,InternalIP,ExternalDNS,ExternalIP,Hostname

# Check 
kubectl top node
kubectl top pods -A
kubectl top pods -n kube-system

```

Hands-on; 
``` bash
# Create ns
kubectl create ns hpa
kubectl get ns

# Create deployment and service
kubectl apply -f deployment-service.yaml

# Check deployment and service
kubectl get deployments -n hpa
kubectl get service -n hpa


# Let's look at the currently used CPU and RAM
kubectl top pods -n hpa

# Imperative: Creating horizontal deployment scale
kubectl autoscale -n hpa deployment deployment_name --min=X --max=X --cpu-percent=XX
kubectl autoscale -n hpa deployment hpa --min=1 --max=5 --cpu-percent=20

# Declarative: Creating horizontal deployment scale
kubectl apply -f declarative-auto-scaling-1.yaml

# Checking Horizontal Pod Scaling
kubectl get -n hpa horizontalpodautoscalers.autoscaling

# CPU workload increase
while true; do curl http://192.168.1.7:32562 && sleep 0.01 && echo ""; done;

# Declarative: Creating horizontal deployment scale. Scale up and scale down example
kubectl apply -f declarative-auto-scaling-3.yaml

# Checking Horizontal Pod Scaling
kubectl get -n hpa horizontalpodautoscalers.autoscaling

```


















# Referance
``` bash
https://github.com/kubernetes-sigs/metrics-server
https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/
https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

```