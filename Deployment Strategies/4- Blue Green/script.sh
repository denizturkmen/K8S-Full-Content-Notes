#!/bin/bash

echo "Changing selector inside to service..."

selector=$(kubectl get service web-svc -o json | jq '.spec.selector.strategies')
echo $selector

if [ "$selector" = "blue" ]; then
    kubectl patch service web-svc  --type JSON -p='[{"op": "replace", "path": "/spec/selector/strategies", "value":"green"}]'
fi

if [ "$selector" = "green" ]; then
    kubectl patch service web-svc  --type JSON -p='[{"op": "replace", "path": "/spec/selector/strategies", "value":"blue"}]'
fi