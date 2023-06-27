## Step by step: Disk Creation for Ubuntu



## Disk Should Create
Disk type must be **LVM** for ***GlusterFS***.


## You can create lvm by running the following commands

```bash
sudo fdisk /dev/vdb
  n
  p
  enter
  t
  8e
  w

```bash

