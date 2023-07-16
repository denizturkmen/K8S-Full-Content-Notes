# Root User create and Set-up


Createad and set-up root user
Add the following commands below

``` bash
sudo passwd root
sudo vim /etc/ssh/sshd_config
    -> port  22
	-> PermitRootLogin yes
	-> PasswordAuthentication yes 

sudo service ssh restart

``` 

Check root user

**ssh root@Ip_addresess**