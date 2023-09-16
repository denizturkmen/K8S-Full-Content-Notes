# Backuping Up and Restore


Let's create a service and deployment before backup
``` bash
# applied service
kubectl apply -f back-res-svc.yaml

# appliced deployment
kubectl apply -f back-res-dep.yaml

```

Install etcd-client
``` bash
# package updated
sudo apt update

# install
sudo apt install -y etcd-client

# check
etcdctl

```

Backuping Up for etcd
``` bash
# describe
kubectl describe pod -n kube-system etcd_pod_name

# backup
ETCDCTL_API=3 etcdctl --endpoints=https:/172.30.1.2:2379\
  --cacert=<trusted-ca-file> --cert=<cert-file> --key=<key-file> \
  snapshot save <backup-file-location>

ETCDCTL_API=3 etcdctl --endpoints=https://172.30.1.2:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
  snapshot save snapshotdb-$(date +%m-%d-%y)

# menber list
ETCDCTL_API=3 etcdctl --endpoints=https://172.30.1.2:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
  member list

# healty check
ETCDCTL_API=3 etcdctl --endpoints=https://172.30.1.2:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
  endpoint health

# check snapshot
ETCDCTL_API=3 etcdctl --write-out=table snapshot status snapshotdb_name

```

Removed service and deployment
``` bash
# delete deployment
kubectl delete deployment deployment_name

# delete svc
kubectl delete svc service_name

```

Restoring for etcd
``` bash
# restore
ETCDCTL_API=3 etcdctl snapshot restore --data-dir <data-dir-location> snapshotdb

ETCDCTL_API=3 \
etcdctl snapshot restore snapshotdb_name \
--data-dir=/var/lib/etcd-snapshot

# changed host past from /var/lib/etcd to /var/lib/etcd-snapshot 
sudo vim /etc/kubernetes/manifests/etcd.yaml


```