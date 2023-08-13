Step by step: Kubernetes Configuration


Firstly, Check your heketi cluster
``` bash
heketi-cli cluster list

```

Instalation to glusterfs-client all kubernetes nodes. master + worker
``` bash
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:gluster/glusterfs-9
sudo apt install glusterfs-client -y

```


Create Kubernetes Secret
**Note:** Secret key must be base64. Heketi **admin** user password into **heketi.json**. For this instance; **ivd7dfORN7QNeKVO**

``` bash
echo -n "PASSWORD" | base64

For this example,
echo -n "ivd7dfORN7QNeKVO" | base64

# Check
echo -n "aXZkN2RmT1JON1FOZUtWTw==" | base64 -d

cat <<EOF > secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: heketi-secret
  namespace: default
type: "kubernetes.io/glusterfs"
data:
  # echo -n "ivd7dfORN7QNeKVO" | base64
  key: aXZkN2RmT1JON1FOZUtWTw==
type: kubernetes.io/glusterfs
EOF


kubectl apply -f secret.yaml

```

Create StorageClass

``` bash
cat <<EOF > storageClass.yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: gluster-heketi
provisioner: kubernetes.io/glusterfs
reclaimPolicy: Delete
volumeBindingMode: Immediate
allowVolumeExpansion: true
parameters:
  resturl: "http://192.168.1.25:8080" 
  restuser: "admin" 
  secretName: "heketi-secret"
  secretNamespace: "default"
  volumetype: "replicate:2"
  volumenameprefix: "k8s-dev"
  clusterid: "481c05debed6fc3a670960e38e5f884d"

EOF

kubectl apply -f storageClass.yaml

```

**Notes**
``` bash
**gluster-heketi** is the name of the StorageClass to be created.
The valid options for reclaim policy are **Retain, Delete or Recycle**. 
The **volumeBindingMode** field controls when volume binding and dynamic provisioning should occur. Valid options are **Immediate & WaitForFirstConsumer.** 
The **resturl** is the URL of your **heketi endpoint**
**heketi-secret** is the secret created for Heketi credentials.
**default** is the name of namespace where secret was created
**replicate:2** indicated the default replication factor for Gluster Volumes created. For more HA, use 3.
**volumenameprefix:** By default dynamically provisioned volumes have the naming schema of vol_UUID format. 
**763f96aaee09e7f028297bdcb5b58f2e** is the ID of the cluster obtained from the command heketi-cli cluster list
```

Create Persistent volume
``` bash
cat <<EOF > pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
 name: gluster-pvc
 annotations:
   volume.beta.kubernetes.io/storage-class: gluster-heketi
spec:
 accessModes:
  - ReadWriteMany
 resources:
   requests:
     storage: 1Gi
EOF

```

Checking
``` bash
kubectl get pvc

```

Create Pods
``` bash
cat <<EOF > pods.yaml
apiVersion: v1
kind: Pod
metadata:
  name: gluster-pod
  labels:
    name: gluster-pod
spec:
  containers:
  - name: gluster-pod
    image: busybox
    command: ["sleep", "60000"]
    volumeMounts:
    - name: gluster-vol
      mountPath: /usr/share/busybox 
      readOnly: false
  volumes:
  - name: gluster-vol
    persistentVolumeClaim:
      claimName: gluster-pvc
```


Checking
``` bash
kubectl get pods

```

Adding Manuel Volume
``` bash
kubectl exec -it pod_name -- sh
vim test
  glusterfs
  heketi
  beni bitirdi..
```

Cheking glusterfs
``` bash
sudo gluster volume info

```





