sudo gluster volume create heketi-db-volume replica 3 transport tcp \
  glusterfs-cluster-25:/dev/mapper/ \
  glusterfs-cluster-26:/dev/mapper/ \
  glusterfs-cluster-27:/dev/mapper/

gluster volume start heketi-db-volume


-------


sudo gluster volume create k8s-volume replica 2 arbiter 1 transport tcp   glusterfs-cluster-25:/gluster-data/k8s   glusterfs-cluster-26:/gluster-data/k8s   glusterfs-cluster-27:/gluster-data/k8s force


gluster volume start k8s-volume

-------------

sudo gluster volume create k8s-vol-deniz replica 3 transport tcp   glusterfs-cluster-25:/gluster-data   glusterfs-cluster-26:/gluster-data   glusterfs-cluster-27:/gluster-data force

-------------------------

sudo gluster volume create heketi-db-volume replica 3 transport tcp glusterfs-cluster-25:/gluster-data glusterfs-cluster-26:/gluster-data glusterfs-cluster-27:/gluster-data force

sudo gluster volume start heketi-db-volume


# Configuring client
sudo apt install glusterfs-client

# 3 inde de
sudo mkdir -p /gluster-data
sudo mount -t glusterfs glusterfs-cluster-25:heketi-db-volume /gluster-data

sudo mount -t glusterfs glusterfs-cluster-26:heketi-db-volume /gluster-data
sudo mount -t glusterfs glusterfs-cluster-27:testvolume /gluster-data