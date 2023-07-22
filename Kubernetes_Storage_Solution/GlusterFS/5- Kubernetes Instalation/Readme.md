Step by step: Kubernetes Installation and Configuration

Firstly, Check your heketi cluster
``` bash
sudo heketi-cli cluster list

```

Instalation to glusterfs-client all kubernetes nodes. master + worker
``` bash
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:gluster/glusterfs-7
sudo apt install glusterfs-client -y

```


Create Kubernetes Secret
**Note:** Secret key must be base64. Heketi **admin** user password into **heketi.json**. For this instance; **ivd7dfORN7QNeKVO**

``` bash
echo -n "PASSWORD" | base64
aXZkN2RmT1JON1FOZUtWTw==

cat <<EOF > secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: heketi-secret
  namespace: default
type: "kubernetes.io/glusterfs"
data:
  # echo -n "PASSWORD" | base64
  key: aXZkN2RmT1JON1FOZUtWTw==
EOF


kubectl apply -f secret.yaml


```

Create StorageClass

``` bash
cat <<EOF > storageClass.yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
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
  volumetype: "replicate:3"
  volumenameprefix: "k8s-demo"
  clusterid: "763f96aaee09e7f028297bdcb5b58f2e"
EOF



kubectl apply -f storageClass.yaml

```

**gluster-heketi** is the name of the StorageClass to be created.
The valid options for reclaim policy are **Retain, Delete or Recycle**. 
The **volumeBindingMode** field controls when volume binding and dynamic provisioning should occur. Valid options are **Immediate & WaitForFirstConsumer.** 
The **resturl** is the URL of your **heketi endpoint**
**heketi-secret** is the secret created for Heketi credentials.
**default** is the name of namespace where secret was created
**replicate:2** indicated the default replication factor for Gluster Volumes created. For more HA, use 3.
**volumenameprefix:** By default dynamically provisioned volumes have the naming schema of vol_UUID format. 
**763f96aaee09e7f028297bdcb5b58f2e** is the ID of the cluster obtained from the command heketi-cli cluster list