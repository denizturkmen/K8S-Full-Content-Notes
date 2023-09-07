# Lens Dashboard Installation for Kubernetes

**Note:** Lens control panel is now **paid.**
You can use it with a trial account for 14 days

Installation on ubuntu 20.04
``` bash
# Adding public security key and add it to your keyring
curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/lens-archive-keyring.gpg > /dev/null

# Add the Lens Desktop repo
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/lens.list > /dev/null

# Package updated then install
sudo apt update
sudo apt install lens

# Run Desktop
lens-desktop

```



# Referance
``` bash
https://k8slens.dev/


```