Step by Step: Heketi installation and configure

Heketi downland and installation on glusterfs-cluster-25 machine
Run the following commands from terminal.

``` bash
sudo wget https://github.com/heketi/heketi/releases/download/v7.0.0/heketi-v7.0.0.linux.amd64.tar.gz
sudo tar -xvf heketi-v7.0.0.linux.amd64.tar.gz
sudo chmod +x heketi/{heketi,heketi-cli}
sudo cp heketi/{heketi,heketi-cli} /usr/bin
sudo mkdir -p /var/lib/heketi /etc/heketi /var/log/heketi

```

Check heketi version
``` bash
sudo heketi --version
sudo heketi-cli --version

```

Load all Kernel modules that will be required by **Heketi.**
``` bash
sudo apt -y install thin-provisioning-tools 
for i in dm_snapshot dm_mirror dm_thin_pool; do
  sudo modprobe $i
done
```

Checked kernel modules
``` bash
sudo echo dm_thin_pool | sudo tee -a /etc/modules
sudo echo dm_snapshot | sudo tee -a /etc/modules
sudo echo dm_mirror | sudo tee -a /etc/modules

```

Heketi Configuration
Add heketi system user 
``` bash
sudo groupadd --system heketi
sudo useradd -s /sbin/nologin --system -g heketi heketi

```

Edit the Heketi configuration file
``` bash
sudo vim /etc/heketi/heketi.json
```
Note: heketi.json into Heketi directory

Generate Heketi SSH keys on heketi server machine
``` bash
sudo ssh-keygen -m PEM -t rsa -b 4096 -q -f /etc/heketi/heketi_key

or
sudo ssh-keygen -f /etc/heketi/heketi_key -t rsa -N ''

sudo chown heketi:heketi /etc/heketi/heketi_key*
```

Checking public and private keys
``` bash
cd /etc/heketi
ls -al

```

Copy generated public key to all GlusterFS nodes
**Note:** If ssh keys are run before they can **be copied** to **all glusterfs nodes**, you will get an **error**
 from the heketi service
``` bash
sudo su 
for i in glusterfs-cluster-25 glusterfs-cluster-26 glusterfs-cluster-27; do
  ssh-copy-id -i /etc/heketi/heketi_key.pub root@$i
done
```

Checking
``` bash
sudo ssh -i /etc/heketi/heketi_key root@glusterfs-cluster-25
sudo ssh -i /etc/heketi/heketi_key root@glusterfs-cluster-26
sudo ssh -i /etc/heketi/heketi_key root@glusterfs-cluster-27

```

2nd way
``` bash
sudo ssh-copy-id -i /etc/heketi/heketi_key root@glusterfs-cluster-25
sudo ssh-copy-id -i /etc/heketi/heketi_key root@glusterfs-cluster-26
sudo ssh-copy-id -i /etc/heketi/heketi_key root@glusterfs-cluster-27
```


Create a systemd file for heketi.service
sudo vim /etc/systemd/system/heketi.service
``` bash
[Unit]
Description=Heketi Server
[Service]
Type=simple
WorkingDirectory=/var/lib/heketi
ExecStart=/usr/bin/heketi --config=/etc/heketi/heketi.json
Restart=on-failure
StandardOutput=syslog
StandardError=syslog
[Install]
WantedBy=multi-user.target

```


**Note:** heketi.service into Heketi directory

Allow heketi user perms on folders
``` bash
sudo chown -R heketi:heketi /var/lib/heketi /var/log/heketi /etc/heketi

```

Reload systemd and enable new heketi service
``` bash
sudo systemctl start heketi
sudo systemctl daemon-reload
sudo systemctl enable heketi
sudo systemctl status heketi

```

Check heketi port
``` bash
sudo netstat -tuplen | grep LISTEN | grep heketi
```

Check Heketi service 
``` bash
curl http://glusterfs-cluster-25:8080/hello

```

Heketi topology install and configure
Run the commands below
``` bash
export HEKETI_CLI_SERVER=http://192.168.1.25:8080
sudo vim /etc/heketi/topology.json
sudo chown -R heketi:heketi /var/lib/heketi /var/log/heketi /etc/heketi


sudo heketi-cli topology load --json=/etc/heketi/topology.json
```

Checking **Heketi-cluster;** run the commands below;
``` bash
sudo heketi-cli --help
sudo heketi-cli cluster list
sudo heketi-cli topology info
sudo heketi-cli cluster info 0e5f6cc9ed2bbc2c58889dcecca769bd
sudo tail -f /var/log/glusterfs/glusterd.log

```






## Referenace
```
Heketi Release: https://github.com/heketi/heketi/releases
https://github.com/heketi/heketi/blob/master/docs/admin/install-kubernetes.md

```