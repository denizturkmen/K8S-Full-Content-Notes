# CKA: Network Policy

Why is the network policy?


Template: Network Policy
``` bash
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: test-network-policy
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - ipBlock:
            cidr: 172.17.0.0/16
            except:
              - 172.17.1.0/24
        - namespaceSelector:
            matchLabels:
              project: myproject
        - podSelector:
            matchLabels:
              role: frontend
      ports:
        - protocol: TCP
          port: 6379
  egress:
    - to:
        - ipBlock:
            cidr: 10.0.0.0/24
      ports:
        - protocol: TCP
          port: 5978
```

Policy Types:

**Ingress:** inbound traffic.

**Egress:** outbound traffic.

for example: ingress_1

**Note:** each operation allowed here.
``` bash
ingress:
    - from:
        - ipBlock:
            cidr: 172.17.0.0/16
            except:
              - 172.17.1.0/24
    ports:
        - protocol: TCP
          port: 6379

```

for example: ingress_2
``` bash
ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              project: myproject
    ports:
        - protocol: TCP
          port: 6379

```

for example: ingress_3
``` bash
ingress:
    - from: 
        - podSelector:
            matchLabels:
              role: frontend
    ports:
        - protocol: TCP
          port: 6379

```


We can also give you the port range.
``` bash
ports:
    - protocol: TCP
      port: 32000
      endPort: 32768

```

**Note:** There are 3 types that we can define in **egress**, just like ingress.

    1- ipBlock

    2- NamespaceSelector

    3- Pod Selector


Targeting multiple namespaces by label
``` bash
- namespaceSelector:
        matchExpressions:
        - key: namespace
          operator: In
          values: ["frontend", "backend"]

```



Default deny all ingress traffic
``` bash
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  policyTypes:
  - Ingress

```

Allow all ingress traffic
``` bash
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-all-ingress
spec:
  podSelector: {} # all pod
  ingress:
  - {}
  policyTypes:
  - Ingress

```

Network Policy: Example
``` bash
# create ns a and ns b
kubectl create ns a
kubectl create ns b

# checking ns
kubectl get ns

# create pod-a into ns a
kubectl run pod-a -n a --image busybox --command sleep 6000

# checking pod into ns a
kubectl get pods -n a

# create pod-b into ns b
kubectl run pod-b -n b --image busybox --command sleep 6000

# checking pod into ns b
kubectl get pods -n b

# check all namespace
kubectl get all -A  | grep pod-

# exec from pod-a
kubectl get pods -A -owide | grep pod-
kubectl exec -it -n a pod-a -- sh
    ping pod_b ip 


```


1- Network Policy create: Preventing access from pod-a to pod-b
``` bash
# create network policy
kubectl apply -f np1.yaml 

# checking  networkpolicies
kubectl get networkpolicies -n b

# describe networkpolicies
kubectl describe networkpolicies -n b np1

# exec into pod-a
kubectl exec -it -n a pod-a -- sh
    ping pod-b ip

# delete np1
kubectl delete networkpolicies -n b np1 

# checking  networkpolicies
kubectl get networkpolicies -n b

```


2- Network Policy create: Allowing access from pod-a to pod-b
``` bash
# create network policy
kubectl apply -f np2.yaml

# looking the namespace label
kubectl get ns --show-labels
kubectl get ns a --show-labels 

# checking  networkpolicies
kubectl get networkpolicies -n b

# describe networkpolicies
kubectl describe networkpolicies -n b np2

# exec into pod-a
kubectl exec -it -n a pod-a -- sh
    ping pod-b ip

# delete np1
kubectl delete networkpolicies -n b np2 

# checking  networkpolicies
kubectl get networkpolicies -n b

```

3- Network Policy create: Allowing access from pod-a to pod-b **( namescapeSelector)**
``` bash
# create network policy
kubectl apply -f np2.yaml

# looking the namespace label
kubectl get ns --show-labels
kubectl get ns a --show-labels 

# checking  networkpolicies
kubectl get networkpolicies -n b

# describe networkpolicies
kubectl describe networkpolicies -n b np2

# exec into pod-a
kubectl exec -it -n a pod-a -- sh
    ping pod-b ip

# delete np2
kubectl delete networkpolicies -n b np2 

# checking  networkpolicies
kubectl get networkpolicies -n b

```

4- Network Policy create: Allowing access from pod-a to pod-b **( podSelector)**
``` bash
# create network policy
kubectl apply -f np3.yaml

# looking the pods label
kubectl get pods --show-labels
kubectl get pods -n a pod-a --show-labels

# checking  networkpolicies
kubectl get networkpolicies -n b

# describe networkpolicies
kubectl describe networkpolicies -n b np3

# exec into pod-a
kubectl exec -it -n a pod-a -- sh
    ping pod-b ip

# delete np3
kubectl delete networkpolicies -n b np3

# checking  networkpolicies
kubectl get networkpolicies -n b

```

**Note:** Let's pay attention to the **and (&&)** and **or (||)** logic

5- Network Policy create: Allowing access from pod-c to pod-b but preventing from pod-a to pod-b
``` bash
# create network policy
kubectl apply -f np4.yaml

# create pod-c
kubectl run pod-c -n a --image busybox --command sleep 6000

# checking pod into ns a
kubectl get pods -n a -owide
kubectl get pods -A -owide | grep pod-

# checking  networkpolicies
kubectl get networkpolicies -n b

# describe networkpolicies
kubectl describe networkpolicies -n b np4

# exec into pod-c
kubectl exec -it -n a pod-c -- sh
    ping pod-b ip

# delete np4
kubectl delete networkpolicies -n b np4

# checking  networkpolicies
kubectl get networkpolicies -n b


# create network policy
kubectl apply -f np5.yaml

# checking  networkpolicies
kubectl get networkpolicies -n b

# exec into pod-c
kubectl exec -it -n a pod-c -- sh
    ping pod-b ip -> OK
   
# exec into pod-a
kubectl exec -it -n a pod-a -- sh
    ping pod-b ip -> Not OK
    
```