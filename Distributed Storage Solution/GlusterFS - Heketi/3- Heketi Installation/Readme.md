Step by Step: Heketi installation and configure



Load all Kernel modules that will be required by **Heketi.** 
Running all glusterfs node
``` bash
sudo apt -y install thin-provisioning-tools 
sudo su
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

Heketi downland and installation on glusterfs-cluster-25 machine
Run the following commands from terminal.

``` bash
sudo wget https://github.com/heketi/heketi/releases/download/v10.4.0/heketi-v10.4.0-release-10.linux.amd64.tar.gz
sudo tar -xvf heketi-v10.4.0-release-10.linux.amd64.tar.gz
sudo chmod +x heketi/{heketi,heketi-cli}
sudo cp heketi/{heketi,heketi-cli} /usr/bin
sudo mkdir -p /var/lib/heketi /etc/heketi /var/log/heketi

```

Check heketi version
``` bash
sudo heketi --version
sudo heketi-cli --version

```

Heketi Configuration
Add heketi system user 
``` bash
sudo groupadd --system heketi
sudo useradd -s /sbin/nologin --system -g heketi heketi

```

Edit the Heketi configuration file
``` bash
sudo cp heketi/heketi.json /etc/heketi
sudo vim /etc/heketi/heketi.json

```
**Note:** heketi.json into Heketi directory

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
**Note:** If ssh keys are run before they can **be copied** to **all glusterfs nodes**, you will get an **error** from the heketi service
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

Also download sample environment file for Heketi and Set all directory permissions

``` bash
sudo wget -O /etc/heketi/heketi.env https://raw.githubusercontent.com/heketi/heketi/master/extras/systemd/heketi.env
sudo chown -R heketi:heketi /var/lib/heketi /var/log/heketi /etc/heketi

```


Create a systemd file for heketi.service
sudo vim /etc/systemd/system/heketi.service
``` bash
[Unit]
Description=Heketi Server
[Service]
Type=simple
WorkingDirectory=/var/lib/heketi
EnvironmentFile=-/etc/heketi/heketi.env
User=heketi
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

Check heketi port before install net-tools
``` bash
sudo apt update
sudo apt install -y net-tools
# Check
sudo netstat -tuplen | grep LISTEN | grep heketi

```

Check Heketi service 
``` bash
curl http://glusterfs-cluster-25:8080/hello

```

Heketi topology install and configure
Run the commands below
``` bash
sudo vim /etc/heketi/topology.json
sudo chown -R heketi:heketi /var/lib/heketi /var/log/heketi /etc/heketi

sudo heketi-cli topology load --json=/etc/heketi/topology.json

sudo heketi-cli topology load --user admin --secret heketi_admin_secret --json=/etc/heketi/topology.json -> this OK
sudo heketi-cli topology load --user admin --secret ivd7dfORN7QNeKVO --json=/etc/heketi/topology.json

```


Add the Heketi access credentials to your **~/.bashrc** file.
sudo vim ~/.bashrc
```
export HEKETI_CLI_SERVER=http://192.168.1.25:8080
export HEKETI_CLI_USER=admin
export HEKETI_CLI_KEY="ivd7dfORN7QNeKVO"

```

Source file
``` bash
source ~/.bashrc

```

Checking **Heketi-cluster;** run the commands below;
**Note:** Run without **sudo** as user and group have changed
``` bash
heketi-cli --help
heketi-cli cluster list

heketi-cli node list
heketi-cli node info ID ( XXXXXXXXXXXXX )
heketi-cli topology info
heketi-cli cluster info 481c05debed6fc3a670960e38e5f884d
sudo tail -f /var/log/glusterfs/glusterd.log

```

After loading topology file, run the command below to list your clusters.
``` bash
heketi-cli cluster list

```

List nodes available in the Cluster
``` bash
heketi-cli node list
heketi-cli node info id

heketi-cli node info 5d4a3b948fe7c9c9b23523e369c93d31
heketi-cli cluster info 481c05debed6fc3a670960e38e5f884d

```

Let’s now create a Gluster volume to verify Heketi & GlusterFS is working
``` bash
heketi-cli volume create --size=1

check
heketi-cli volume list

```

Check new volume look using topology info
``` bash
heketi-cli topology info

```

You can also use the below command to view the nodes:
``` bash
sudo gluster pool list

```


## Referenace
```
Heketi Release: https://github.com/heketi/heketi/releases
https://github.com/heketi/heketi/blob/master/docs/admin/install-kubernetes.md

```