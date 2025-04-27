# Installing and Configuring Kube-Prometheus-Stack

## Install
``` bash
# Install
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace monitoring
helm install prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring



```