apiVersion: apps/v1
kind: Deployment
metadata:
  name: test
  namespace: default
  labels:
    app: test
spec:
  selector:
    matchLabels:
      app: test
  replicas: 1
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: test
    spec:
      serviceAccountName: default
      containers:
      - name: test
        image: denizturkmen/backend:latest
        imagePullPolicy: IfNotPresent
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
          limits:
            cpu: 100m
            memory: 100Mi
        ports:
        - containerPort: 80
          name: test
      restartPolicy: Always
---
kubectl create secret docker-registry <secret-name> \
  --docker-server=<your-registry-server> \
  --docker-username=<your-username> \
  --docker-password=<your-password> \
  --docker-email=<your-email>

 --docker-server=https://index.docker.io/v1/ 
---
kubectl patch serviceaccount <service-account-name> \
  -p '{"imagePullSecrets": [{"name": "<secret-name>"}]}'

