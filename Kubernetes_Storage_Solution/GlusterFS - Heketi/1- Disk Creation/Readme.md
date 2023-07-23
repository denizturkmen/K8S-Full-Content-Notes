**Step by step**  Disk Creation on ubuntu for GlusterFS

Disk Should Creation and Setup
Disk type **must be LVM** for GlusterFS.
You can create lvm by running the following commands

**Note:** Lv2 **must** install on ubuntu beacuse it's making the problem when loading heketi. For this, Run the command below
``` bash
sudo apt install -y lvm2
```

Disk operation
``` bash
sudo lsblk 
sudo lsblk -f
sudo fdisk /dev/sdb
  n
  p
  enter
  t
  L
  8e
  w

```

**Check Disk Partion**
``` bash
sudo sfdisk -l
sudo sfdisk -l /dev/sdb

```