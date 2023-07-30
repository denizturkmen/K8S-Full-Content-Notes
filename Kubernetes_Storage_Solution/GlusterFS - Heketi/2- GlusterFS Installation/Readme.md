GlusterFS Installation and Setup Guide on Ubuntu 20.04

Configuring your **/etc/hosts**
The below command running all on the glusterfs node.
``` bash
sudo hostnamectl set-hostname hostname
    192.168.1 25 -> sudo hostnamectl set-hostname glusterfs-cluster-25  
    192.168.1 26 -> sudo hostnamectl set-hostname glusterfs-cluster-26
    192.168.1 27 -> sudo hostnamectl set-hostname glusterfs-cluster-27
```

Reboot all machine after change hostname 
``` bash
sudo reboot
```

**Hostname** and **IP address** must be added to **/etc/hosts** to connect glusterfs nodes.
Note: Glusterfs **must be** added to **all nodes** where it **will be** installed.
``` bash
sudo vim /etc/hosts

  192.168.1.25   glusterfs-cluster-25
  192.168.1.26   glusterfs-cluster-26
  192.168.1.27   glusterfs-cluster-27

```

For **Ubuntu** Installation GlusterFS
``` bash
sudo apt install software-properties-common
sudo add-apt-repository ppa:gluster/glusterfs-7
sudo apt update
sudo apt install -y glusterfs-server

```

Started and Enabled **GlusterFS Service**
``` bash
sudo systemctl start glusterd
sudo systemctl enable glusterd
sudo systemctl status glusterd

```

Check glusterfs version
``` bash
sudo gluster --version

```

Node connection from main **glusterfs-cluster-25** (192.168.1.25) on machine.
``` bash
sudo gluster peer probe glusterfs-cluster-26
sudo gluster peer probe glusterfs-cluster-27

```

GlusterFS checking connection status to all Nodes
``` bash
sudo gluster peer status

```

Useful command list 
``` bash
sudo gluster --help
sudo gluster volume help
sudo gluster volume list

```


## Referenace
``` bash
Install: https://docs.gluster.org/en/main/Install-Guide/Install/
Configure: https://docs.gluster.org/en/main/Install-Guide/Configure/#for-debian
Github repository: https://github.com/gluster/glusterfs/tree/v9.6


```