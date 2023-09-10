
View the dashboard
``` bash
# Apply
kubectl apply -f samples/addons

# Cheking to svc
kubectl get svc -n istio-systen

# Expose service to kiali

```



while true; do curl -s "http://${GATEWAY_URL}/productpage" | grep -o "<title>.*</title>" && sleep 1 && echo ""; done;